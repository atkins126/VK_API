unit VK.CommonUtils;

interface

{$INCLUDE include.inc}

uses
  System.Classes, System.Net.HttpClient;

function DownloadURL(URL: string): TMemoryStream; overload;

function DownloadURL(URL: string; FileName: string): Boolean; overload;

function GetRandomId: Int64;

function BoolToString(Value: Boolean): string; overload;

function BoolToInt(Value: Boolean): Integer; overload;

function BoolToString(Value: Boolean; TrueValue, FalseValue: string): string; overload;

function GetTokenFromUrl(const Url: string; var Token, ChangePasswordHash, TokenExpiry: string): Boolean;

function GetActionLinkHash(const Html: string; var Hash: string): Boolean;

function CheckForCaptcha(const Html: string; var CaptchaUrl: string): Boolean;

implementation

uses
  System.DateUtils, System.SysUtils, System.IOUtils;

function GetTokenFromUrl(const Url: string; var Token, ChangePasswordHash, TokenExpiry: string): Boolean;
var
  i: integer;
  Str: string;
  Params: TStringList;
begin
  i := Pos('#access_token=', Url);
  if (i = 0) then
    i := Pos('&access_token=', Url);
  if i <> 0 then
  begin
    Str := Url;
    Delete(Str, 1, i);
    Params := TStringList.Create;
    try
      Params.Delimiter := '&';
      Params.DelimitedText := Str;
      ChangePasswordHash := Params.Values['change_password_hash'];
      Token := Params.Values['access_token'];
      TokenExpiry := Params.Values['expires_in'];
    finally
      Params.Free;
    end;
  end;
  Result := not Token.IsEmpty;
end;

function GetActionLinkHash(const Html: string; var Hash: string): Boolean;
const
  Pattern = 'action="/login?act=authcheck_code&hash=';
var
  i: Integer;
begin
  Hash := '';
  i := Pos(Pattern, Html);
  if i > 0 then
  begin
    Hash := Copy(Html, i + Pattern.Length, 50);
    i := Pos('"', Hash);
    if i > 0 then
    begin
      Hash := Copy(Hash, 1, i - 1);
    end;
  end;
  Result := not Hash.IsEmpty;
end;

function CheckForCaptcha(const Html: string; var CaptchaUrl: string): Boolean;
const
  Pattern = 'img src="/captcha.php?sid=';
var
  i: Integer;
begin
  CaptchaUrl := '';
  i := Pos(Pattern, Html);
  if i > 0 then
  begin
    CaptchaUrl := Copy(Html, i + Pattern.Length, 50);
    i := Pos('"', CaptchaUrl);
    if i > 0 then
    begin
      CaptchaUrl := Copy(CaptchaUrl, 1, i - 1);
    end;
  end;
  Result := not CaptchaUrl.IsEmpty;
end;

function BoolToInt(Value: Boolean): Integer; overload;
begin
  if Value then
    Result := 1
  else
    Result := 0;
end;

function BoolToString(Value: Boolean): string;
begin
  if Value then
    Result := '1'
  else
    Result := '0';
end;

function BoolToString(Value: Boolean; TrueValue, FalseValue: string): string;
begin
  if Value then
    Result := TrueValue
  else
    Result := FalseValue;
end;

function GetRandomId: Int64;
begin

  {$IFDEF OLD_VERSION}
  Result := DateTimeToUnix(Now) + 1234567;
  {$ELSE}
  Result := DateTimeToMilliseconds(Now) + 1234567;
  {$ENDIF}
end;

function DownloadURL(URL: string): TMemoryStream;
var
  HTTP: THTTPClient;
begin
  Result := TMemoryStream.Create;
  HTTP := THTTPClient.Create;
  try
    try
      HTTP.HandleRedirects := True;
      HTTP.Get(URL, Result);
      Result.Position := 0;
    except
      //��, ������... ����� �� ����� ������ � ������ �� ������ ����������,
      //���� ��������� ������ ������ ����� ��� ��������������
    end;
  finally
    HTTP.Free;
  end;
end;

function DownloadURL(URL: string; FileName: string): Boolean;
var
  HTTP: THTTPClient;
  Mem: TFileStream;
begin
  //��������, �������� �����
  try
    Mem := TFileStream.Create(FileName, fmCreate);
  except
    begin
      raise Exception.Create('�� �������� ������� ����');
      Exit(False);
    end;
  end;
  //��������
  HTTP := THTTPClient.Create;
  try
    try
      HTTP.HandleRedirects := True;
      Result := HTTP.Get(URL, Mem).StatusCode = 200;
    except
      Result := False;
    end;
  finally
    Mem.Free;
    HTTP.Free;
  end;
end;

end.

