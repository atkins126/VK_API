unit VK.Handler;

interface

uses
  Winapi.Windows, System.SysUtils, Vcl.Forms, REST.Authenticator.OAuth, REST.Client, REST.Json, JSON,
  VK.Types;

type
  TRequestConstruct = class
    class var
      Client: TRESTClient;
  public
    class function Request(Resource: string; Params: TParams): TRESTRequest;
  end;

  TVKHandler = class
    const
      RequestLimit = 3; //Round(1000 / 3) + 10; //�������� ����� ��������� 3 ������� � ������� + 10 �� ���������
  private
    FStartRequest: Cardinal;
    FRequests: Integer;
    FRESTClient: TRESTClient;
    FOnConfirm: TOnConfirm;
    FOnError: TOnVKError;
    FOnLog: TOnLog;
    FUseServiceKeyOnly: Boolean;
    FOwner: TObject;
    FOnCaptcha: TOnCaptcha;
    function DoConfirm(Answer: string): Boolean;
    procedure ProcError(Code: Integer; Text: string = ''); overload;
    procedure ProcError(E: Exception); overload;
    procedure ProcError(Msg: string); overload;
    procedure SetOnConfirm(const Value: TOnConfirm);
    procedure SetOnError(const Value: TOnVKError);
    procedure FLog(const Value: string);
    procedure SetOnLog(const Value: TOnLog);
    procedure SetUseServiceKeyOnly(const Value: Boolean);
    procedure SetOwner(const Value: TObject);
    procedure SetOnCaptcha(const Value: TOnCaptcha);
  public
    constructor Create(AOwner: TObject);
    destructor Destroy; override;
    function AskCaptcha(const CaptchaImg: string; var Answer: string): Boolean;
    function Execute(Request: string; Params: TParams): TResponse; overload;
    function Execute(Request: string; Param: TParam): TResponse; overload;
    function Execute(Request: string): TResponse; overload;
    function Execute(Request: TRESTRequest; FreeRequset: Boolean = False): TResponse; overload;
    property RESTClient: TRESTClient read FRESTClient;
    property OnConfirm: TOnConfirm read FOnConfirm write SetOnConfirm;
    property OnCaptcha: TOnCaptcha read FOnCaptcha write SetOnCaptcha;
    property OnError: TOnVKError read FOnError write SetOnError;
    property OnLog: TOnLog read FOnLog write SetOnLog;
    property UseServiceKeyOnly: Boolean read FUseServiceKeyOnly write SetUseServiceKeyOnly;
    property Owner: TObject read FOwner write SetOwner;
  end;

implementation

procedure WaitTime(MS: Int64);
var
  TS: Cardinal;
begin
  if MS < 0 then
    Exit;
  if MS = 0 then
  begin
    Application.ProcessMessages;
    Exit;
  end;
  TS := GetTickCount;
  while TS + MS > GetTickCount do
    Application.ProcessMessages;
end;

{ TRequsetConstruct }

class function TRequestConstruct.Request(Resource: string; Params: TParams): TRESTRequest;
var
  Param: TParam;
begin
  Result := TRESTRequest.Create(nil);
  Result.Client := Client;
  Result.Resource := Resource;
  for Param in Params do
  begin
    if not Param[0].IsEmpty then
      Result.Params.AddItem(Param[0], Param[1]);
  end;
end;

{ TVKHandler }

function TVKHandler.AskCaptcha(const CaptchaImg: string; var Answer: string): Boolean;
begin
  if Assigned(FOnCaptcha) then
  begin
    FOnCaptcha(CaptchaImg, Answer);
    Result := not Answer.IsEmpty;
  end;
end;

constructor TVKHandler.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  FStartRequest := 0;
  FRequests := 0;
  FRESTClient := TRESTClient.Create(nil);
  FRESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  FRESTClient.AcceptCharset := 'UTF-8, *;q=0.8';

  TRequestConstruct.Client := FRESTClient;
end;

destructor TVKHandler.Destroy;
begin
  FRESTClient.Free;
  inherited;
end;

function TVKHandler.DoConfirm(Answer: string): Boolean;
begin
  if not Assigned(FOnConfirm) then
  begin
    Exit(True);
  end
  else
  begin
    Result := False;
    FOnConfirm(Self, Answer, Result);
  end;
end;

function TVKHandler.Execute(Request: string; Param: TParam): TResponse;
begin
  Result := Execute(TRequestConstruct.Request(Request, [Param]), True);
end;

function TVKHandler.Execute(Request: string; Params: TParams): TResponse;
begin
  Result := Execute(TRequestConstruct.Request(Request, Params), True);
end;

function TVKHandler.Execute(Request: string): TResponse;
begin
  Result := Execute(TRequestConstruct.Request(Request, []), True);
end;

function TVKHandler.Execute(Request: TRESTRequest; FreeRequset: Boolean): TResponse;
var
  JS: TJSONValue;
  CaptchaSID: string;
  CaptchaImg: string;
  CaptchaAns: string;
  IsDone: Boolean;
  TimeStamp: Cardinal;
  TimeStampLast: Cardinal;
begin
  TimeStamp := GetTickCount;
  TimeStampLast := FStartRequest;
  Result.Success := False;
  try
    IsDone := False;
    FLog(Request.GetFullRequestURL);

    FRequests := FRequests + 1;
    //���� ��� 3 ������� ����, �� ��� �� ����� ������� FStartRequest
    if FRequests > RequestLimit then
    begin
      FRequests := 0;
      WaitTime(1300 - Int64(GetTickCount - FStartRequest));
    end;
    Request.Response := TRESTResponse.Create(Request);
    Request.ExecuteAsync(
      procedure
      begin
        IsDone := True;
      end);
    while not IsDone do
      Application.ProcessMessages;
    FLog(Request.Response.JSONText);

    //���� ��� ������ ������, �� ��������� �����
    if FRequests = 1 then
      FStartRequest := GetTickCount;

    if Request.Response.JSONValue.TryGetValue<TJSONValue>('error', JS) then
    begin
      Result.Error.Code := JS.GetValue<Integer>('error_code', -1);
      Result.Error.Text := JS.GetValue<string>('error_msg', VKErrorString(Result.Error.Code));
      case Result.Error.Code of
        14: //�����
          begin
            CaptchaSID := JS.GetValue<string>('captcha_sid', '');
            CaptchaImg := JS.GetValue<string>('captcha_img', '');
            if AskCaptcha(CaptchaImg, CaptchaAns) then
            begin
              Request.Params.AddItem('captcha_sid', CaptchaSID);
              Request.Params.AddItem('captcha_key', CaptchaAns);
              Result := Execute(Request);
              Request.Params.Delete('captcha_sid');
              Request.Params.Delete('captcha_key');
              if FreeRequset then
                Request.Free;
              Exit;
            end
            else
              ProcError(Result.Error.Code, Result.Error.Text);
          end;
        24: //������������� ��� ��
          begin
            CaptchaAns := JS.GetValue<string>('confirmation_text', '');
            if DoConfirm(CaptchaAns) then
            begin
              Request.Params.AddItem('confirm', '1');
              Result := Execute(Request);
              Request.Params.Delete('confirm');
              if FreeRequset then
                Request.Free;
              Exit;
            end
            else
              ProcError(Result.Error.Code, Result.Error.Text);
          end;
        6: //��������� ���-�� �������� � ���.
          begin
            ProcError(Format('��������� ���-�� �������� � ���. (%d/%d, Enter %d, StartRequest %d, LastRequest %d)',
              [FRequests, RequestLimit, TimeStamp, FStartRequest, TimeStampLast]));
            WaitTime(1000);
            Result := Execute(Request);
            if FreeRequset then
              Request.Free;
            Exit;
          end;
      else
        ProcError(Result.Error.Code, Result.Error.Text);
      end;
    end
    else
    begin
      if Request.Response.StatusCode = 200 then
      begin
        if Request.Response.JSONValue.TryGetValue<TJSONValue>('response', JS) then
        begin
          Result.Value := JS.ToJSON;
          Result.JSON := Request.Response.JSONText;
          Result.Success := True;
        end;
      end;
    end;
  except
    on E: Exception do
      ProcError(E);
  end;
  if FreeRequset then
    Request.Free;
end;

procedure TVKHandler.FLog(const Value: string);
begin
  if Assigned(FOnLog) then
    FOnLog(Self, Value);
end;

procedure TVKHandler.SetOnError(const Value: TOnVKError);
begin
  FOnError := Value;
end;

procedure TVKHandler.SetOnLog(const Value: TOnLog);
begin
  FOnLog := Value;
end;

procedure TVKHandler.SetOwner(const Value: TObject);
begin
  FOwner := Value;
end;

procedure TVKHandler.SetUseServiceKeyOnly(const Value: Boolean);
begin
  FUseServiceKeyOnly := Value;
end;

procedure TVKHandler.SetOnCaptcha(const Value: TOnCaptcha);
begin
  FOnCaptcha := Value;
end;

procedure TVKHandler.SetOnConfirm(const Value: TOnConfirm);
begin
  FOnConfirm := Value;
end;

procedure TVKHandler.ProcError(Msg: string);
begin
  if Assigned(FOnError) then
    FOnError(Self, ERROR_VK_UNKNOWN, Msg);
end;

procedure TVKHandler.ProcError(Code: Integer; Text: string);
begin
  if Assigned(FOnError) then
  begin
    if Text = '' then
      Text := VKErrorString(Code);
    FOnError(Self, Code, Text);
  end;
end;

procedure TVKHandler.ProcError(E: Exception);
begin
  if Assigned(FOnError) then
    FOnError(Self, ERROR_VK_UNKNOWN, E.Message);
end;

end.

