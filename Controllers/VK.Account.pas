unit VK.Account;

interface

uses
  System.SysUtils, System.Generics.Collections, REST.Client, VK.Controller, VK.Types, VK.Entity.AccountInfo,
  VK.Entity.ProfileInfo, VK.Entity.ActiveOffers, VK.Entity.Counters, VK.Entity.PushSettings, VK.Entity.Common,
  VK.Entity.AccountInfoRequest, VK.Entity.Account.Banned, VK.CommonUtils;

type
  TVkParamsRegisterDevice = record
    List: TParams;
    function Token(const Value: string): TVkParamsRegisterDevice;
    function DeviceModel(const Value: string): TVkParamsRegisterDevice;
    function DeviceYear(const Value: Integer): TVkParamsRegisterDevice;
    function DeviceId(const Value: string): TVkParamsRegisterDevice;
    function SystemVersion(const Value: string): TVkParamsRegisterDevice;
    function Settings(const Value: string): TVkParamsRegisterDevice;
    function Sandbox(const Value: string): TVkParamsRegisterDevice;
  end;

  TVkParamsProfileInfo = record
    List: TParams;
    function FirstName(const Value: string): TVkParamsProfileInfo;
    function LastName(const Value: string): TVkParamsProfileInfo;
    function MaidenName(const Value: string): TVkParamsProfileInfo;
    function ScreenName(const Value: string): TVkParamsProfileInfo;
    function CancelRequestId(const Value: Integer): TVkParamsProfileInfo;
    function Sex(const Value: TVkSex): TVkParamsProfileInfo;
    function Relation(const Value: TVkRelation): TVkParamsProfileInfo;
    function RelationPartnerId(const Value: Integer): TVkParamsProfileInfo;
    function BirthDate(const Value: TDateTime): TVkParamsProfileInfo;
    function BirthDateVisibility(const Value: TVkBirthDateVisibility): TVkParamsProfileInfo;
    function HomeTown(const Value: string): TVkParamsProfileInfo;
    function CountryId(const Value: Integer): TVkParamsProfileInfo;
    function CityId(const Value: Integer): TVkParamsProfileInfo;
    function Status(const Value: string): TVkParamsProfileInfo;
  end;

  TAccountController = class(TVkController)
  public
    /// <summary>
    /// ��������� ������������ ��� ������ � ������ ������.
    /// </summary>
    function Ban(var Status: Boolean; const OwnerID: Integer): Boolean;
    /// <summary>
    /// ��������� ������� ������ ������������ ����� ��������� �������������� ������� � �������� ����� ���, ��������� ����� Auth.Restore.
    /// </summary>
    function ChangePassword(var Token: string; NewPassword: string; RestoreSid, ChangePasswordHash, OldPassword: string): Boolean;
    /// <summary>
    /// ���������� ������ �������� ��������� ����������� (�������), �������� ������� ������������ ������ �������� ��������������� ���������� ������� �� ���� ���� ������ ����������.
    /// </summary>
    function GetActiveOffers(var Items: TVkActiveOffers; Count: Integer = 100; Offset: Integer = 0): Boolean;
    /// <summary>
    /// �������� ��������� �������� ������������ � ������ ����������.
    /// </summary>
    function GetAppPermissions(var Mask: Integer; UserId: Integer): Boolean;
    /// <summary>
    /// ���������� ������ �������������, ����������� � ������ ������.
    /// </summary>
    function GetBanned(var Items: TVkBannedList; Count: Integer = 20; Offset: Integer = 0): Boolean;
    /// <summary>
    /// ���������� ��������� �������� ��������� ������������.
    /// </summary>
    function GetCounters(var Counters: TVkCounters; Filter: TVkCounterFilters = []): Boolean;
    /// <summary>
    /// ���������� ���������� � ������� ��������.
    /// </summary>
    function GetInfo(var Info: TVkAccountInfo; Fields: TVkInfoFilters = []): Boolean;
    /// <summary>
    /// ���������� ���������� � ������� �������.
    /// </summary>
    function GetProfileInfo(var ProfileInfo: TVkProfileInfo): Boolean;
    /// <summary>
    /// ��������� �������� ��������� Push-�����������.
    /// </summary>
    function GetPushSettings(var PushSettings: TVkPushSettings; DeviceId: string): Boolean;
    /// <summary>
    /// ����������� ���������� �� ���� iOS, Android, Windows Phone ��� Mac �� ��������� Push-�����������.
    /// </summary>
    function RegisterDevice(var Status: Boolean; const Data: TVkParamsRegisterDevice): Boolean;
    /// <summary>
    /// ����������� ���������� �������� �������.
    /// </summary>
    function SaveProfileInfo(const Data: TVkParamsProfileInfo; var Request: TVkAccountInfoRequest): Boolean;
    /// <summary>
    /// ��������� ������������� ���������� � ������� ��������.
    /// </summary>
    function SetInfo(var Status: Boolean; const Name, Value: string): Boolean;
    /// <summary>
    /// ������������� �������� �������� ���������� (�� 17 ��������), ������� ��������� ������������ � ����� ����.
    /// </summary>
    function SetNameInMenu(var Status: Boolean; const UserId: Integer; Name: string): Boolean;
    /// <summary>
    /// �������� �������� ������������ ��� offline (������ � ������� ����������).
    /// </summary>
    function SetOffline(var Status: Boolean): Boolean;
    /// <summary>
    /// �������� �������� ������������ ��� online �� 5 �����.
    /// </summary>
    function SetOnline(var Status: Boolean; Voip: Boolean = False): Boolean;
    /// <summary>
    /// �������� ��������� Push-�����������.
    /// </summary>
    function SetPushSettings(var Status: Boolean; const DeviceId, Settings, Key, Value: string): Boolean;
    /// <summary>
    /// ��������� push-����������� �� �������� ���������� �������.
    /// </summary>
    function SetSilenceMode(var Status: Boolean; const DeviceId: string; Time: Integer; PeerId: string; Sound: Boolean): Boolean;
    /// <summary>
    /// ������� ������������ ��� ������ �� ������� ������.
    /// </summary>
    function UnBan(var Status: Boolean; const OwnerID: Integer): Boolean;
    /// <summary>
    /// ���������� ���������� �� Push �����������.
    /// </summary>
    function UnRegisterDevice(var Status: Boolean; const DeviceId: string; const Token: string; Sandbox: Boolean): Boolean;
  end;

implementation

{ TAccountController }

function TAccountController.ChangePassword(var Token: string; NewPassword: string; RestoreSid, ChangePasswordHash, OldPassword: string): Boolean;
begin
  Result := Handler.Execute('account.changePassword', [
    ['new_password', NewPassword],
    ['restore_sid', RestoreSid],
    ['change_password_hash', ChangePasswordHash],
    ['old_password', OldPassword]]).
    GetValue('token', Token) and (not Token.IsEmpty);
end;

function TAccountController.GetActiveOffers(var Items: TVkActiveOffers; Count: Integer; Offset: Integer): Boolean;
begin
  Result := Handler.Execute('account.getActiveOffers', [
    ['offset', Offset.ToString],
    ['count', Count.ToString]]).
    GetObject(Items);
end;

function TAccountController.GetAppPermissions(var Mask: Integer; UserId: Integer): Boolean;
begin
  Result := Handler.Execute('account.getAppPermissions', ['user_id', UserId.ToString]).ResponseAsInt(Mask);
end;

function TAccountController.GetBanned(var Items: TVkBannedList; Count, Offset: Integer): Boolean;
begin
  Result := Handler.Execute('account.getBanned', [
    ['count', Count.ToString],
    ['offset', Offset.ToString]]).
    GetObject(Items);
end;

function TAccountController.GetCounters(var Counters: TVkCounters; Filter: TVkCounterFilters): Boolean;
begin
  Result := Handler.Execute('account.getCounters', ['filter', Filter.ToString]).GetObject(Counters);
end;

function TAccountController.GetInfo(var Info: TVkAccountInfo; Fields: TVkInfoFilters = []): Boolean;
begin
  Result := Handler.Execute('account.getInfo', ['fields', Fields.ToString]).GetObject(Info);
end;

function TAccountController.GetProfileInfo(var ProfileInfo: TVkProfileInfo): Boolean;
begin
  Result := Handler.Execute('account.getProfileInfo').GetObject(ProfileInfo);
end;

function TAccountController.GetPushSettings(var PushSettings: TVkPushSettings; DeviceId: string): Boolean;
begin
  Result := Handler.Execute('account.getPushSettings', ['device_id', DeviceId]).GetObject(PushSettings);
end;

function TAccountController.RegisterDevice(var Status: Boolean; const Data: TVkParamsRegisterDevice): Boolean;
begin
  Result := Handler.Execute('account.registerDevice', Data.List).ResponseAsBool(Status);
end;

function TAccountController.SaveProfileInfo(const Data: TVkParamsProfileInfo; var Request: TVkAccountInfoRequest): Boolean;
begin
  Result := Handler.Execute('account.saveProfileInfo', Data.List).GetObject(Request);
end;

function TAccountController.SetInfo(var Status: Boolean; const Name, Value: string): Boolean;
begin
  Result := Handler.Execute('account.setInfo', [['name', Name], ['value', Value]]).ResponseAsBool(Status);
end;

function TAccountController.SetNameInMenu(var Status: Boolean; const UserId: Integer; Name: string): Boolean;
begin
  Result := Handler.Execute('account.setNameInMenu', [['user_id', UserId.ToString], ['name', Name]]).ResponseAsBool(Status);
end;

function TAccountController.SetOffline(var Status: Boolean): Boolean;
begin
  Result := Handler.Execute('account.setOffline').ResponseAsBool(Status);
end;

function TAccountController.SetOnline(var Status: Boolean; Voip: Boolean): Boolean;
begin
  Result := Handler.Execute('account.setOnline', ['voip', BoolToString(Voip)]).ResponseAsBool(Status);
end;

function TAccountController.SetPushSettings(var Status: Boolean; const DeviceId, Settings, Key, Value: string): Boolean;
var
  Params: TParams;
begin
  Params.Add('device_id', DeviceId);
  if not Settings.IsEmpty then
    Params.Add('settings', Settings);
  if not Key.IsEmpty then
  begin
    Params.Add(['key', Key]);
    Params.Add(['value', Value]);
  end;
  Result := Handler.Execute('account.setPushSettings', Params).ResponseAsBool(Status);
end;

function TAccountController.SetSilenceMode(var Status: Boolean; const DeviceId: string; Time: Integer; PeerId: string; Sound: Boolean): Boolean;
var
  Params: TParams;
begin
  Params.Add('device_id', DeviceId);
  Params.Add('time', Time);
  Params.Add('peer_id', PeerId);
  Params.Add('sound', Sound);
  Result := Handler.Execute('account.setSilenceMode', Params).ResponseAsBool(Status);
end;

function TAccountController.Ban(var Status: Boolean; const OwnerID: Integer): Boolean;
begin
  Result := Handler.Execute('account.ban', ['owner_id', OwnerID.ToString]).ResponseAsBool(Status);
end;

function TAccountController.UnBan(var Status: Boolean; const OwnerID: Integer): Boolean;
begin
  Result := Handler.Execute('account.unban', ['owner_id', OwnerID.ToString]).ResponseAsBool(Status);
end;

function TAccountController.UnRegisterDevice(var Status: Boolean; const DeviceId: string; const Token: string; Sandbox: Boolean): Boolean;
var
  Params: TParams;
begin
  if not DeviceId.IsEmpty then
    Params.Add('device_id', DeviceId);
  if not Token.IsEmpty then
    Params.Add('token', Token);
  Params.Add('sandbox', Sandbox);
  Result := Handler.Execute('account.unregisterDevice', Params).ResponseAsBool(Status);
end;

{ TVkRegisterDeviceParams }

function TVkParamsRegisterDevice.DeviceId(const Value: string): TVkParamsRegisterDevice;
begin
  List.Add('device_id', Value);
  Result := Self;
end;

function TVkParamsRegisterDevice.DeviceModel(const Value: string): TVkParamsRegisterDevice;
begin
  List.Add('device_model', Value);
  Result := Self;
end;

function TVkParamsRegisterDevice.DeviceYear(const Value: Integer): TVkParamsRegisterDevice;
begin
  List.Add('device_year', Value);
  Result := Self;
end;

function TVkParamsRegisterDevice.Sandbox(const Value: string): TVkParamsRegisterDevice;
begin
  List.Add('sandbox', Value);
  Result := Self;
end;

function TVkParamsRegisterDevice.Settings(const Value: string): TVkParamsRegisterDevice;
begin
  List.Add('settings', Value);
  Result := Self;
end;

function TVkParamsRegisterDevice.SystemVersion(const Value: string): TVkParamsRegisterDevice;
begin
  List.Add('system_version', Value);
  Result := Self;
end;

function TVkParamsRegisterDevice.Token(const Value: string): TVkParamsRegisterDevice;
begin
  List.Add('token', Value);
  Result := Self;
end;

{ TVkProfileInfoParams }

function TVkParamsProfileInfo.BirthDate(const Value: TDateTime): TVkParamsProfileInfo;
begin
  List.Add('bdate', Value, 'DD.MM.YYYY');
  Result := Self;
end;

function TVkParamsProfileInfo.BirthDateVisibility(const Value: TVkBirthDateVisibility): TVkParamsProfileInfo;
begin
  List.Add('bdate_visibility', Ord(Value));
  Result := Self;
end;

function TVkParamsProfileInfo.CancelRequestId(const Value: Integer): TVkParamsProfileInfo;
begin
  List.Add('cancel_request_id', Value);
  Result := Self;
end;

function TVkParamsProfileInfo.CityId(const Value: Integer): TVkParamsProfileInfo;
begin
  List.Add('city_id', Value);
  Result := Self;
end;

function TVkParamsProfileInfo.CountryId(const Value: Integer): TVkParamsProfileInfo;
begin
  List.Add('country_id', Value);
  Result := Self;
end;

function TVkParamsProfileInfo.FirstName(const Value: string): TVkParamsProfileInfo;
begin
  List.Add('first_name', Value);
  Result := Self;
end;

function TVkParamsProfileInfo.HomeTown(const Value: string): TVkParamsProfileInfo;
begin
  List.Add('home_town', Value);
  Result := Self;
end;

function TVkParamsProfileInfo.LastName(const Value: string): TVkParamsProfileInfo;
begin
  List.Add('last_name', Value);
  Result := Self;
end;

function TVkParamsProfileInfo.MaidenName(const Value: string): TVkParamsProfileInfo;
begin
  List.Add('maiden_name', Value);
  Result := Self;
end;

function TVkParamsProfileInfo.Relation(const Value: TVkRelation): TVkParamsProfileInfo;
begin
  List.Add('relation', Ord(Value));
  Result := Self;
end;

function TVkParamsProfileInfo.RelationPartnerId(const Value: Integer): TVkParamsProfileInfo;
begin
  List.Add('relation_partner_id', Value);
  Result := Self;
end;

function TVkParamsProfileInfo.ScreenName(const Value: string): TVkParamsProfileInfo;
begin
  List.Add('screen_name', Value);
  Result := Self;
end;

function TVkParamsProfileInfo.Sex(const Value: TVkSex): TVkParamsProfileInfo;
begin
  List.Add('sex', Ord(Value));
  Result := Self;
end;

function TVkParamsProfileInfo.Status(const Value: string): TVkParamsProfileInfo;
begin
  List.Add('status', Value);
  Result := Self;
end;

end.

