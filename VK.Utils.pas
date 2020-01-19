unit VK.Utils;

interface

{$INCLUDE include.inc}

uses
  System.Classes, System.Net.HttpClient;

function DownloadURL(URL: string): TMemoryStream;

function GetRandomId: Int64;

function BoolToString(Value: Boolean): string;

implementation

uses
  System.DateUtils, System.SysUtils;

function BoolToString(Value: Boolean): string;
begin
  if Value then
    Result := '1'
  else
    Result := '0';
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

end.

