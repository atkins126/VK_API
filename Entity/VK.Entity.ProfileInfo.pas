unit VK.Entity.ProfileInfo;

interface

uses
  Generics.Collections, Rest.Json, VK.Entity.Common, VK.Entity.Database.Countries;

type
  TVkProfileInfo = class(TVkEntity)
  private
    FBdate: string;
    FBdate_visibility: Extended;
    FCountry: TVkCountry;
    FFirst_name: string;
    FHome_town: string;
    FLast_name: string;
    FPhone: string;
    FRelation: Extended;
    FRelation_partner: TVkRelationData;
    FRelation_requests: TArray<TVkRelationData>;
    FScreen_name: string;
    FSex: Extended;
    FStatus: string;
  public
    property BirthDate: string read FBdate write FBdate;
    property BirthDateVisibility: Extended read FBdate_visibility write FBdate_visibility;
    property Country: TVkCountry read FCountry write FCountry;
    property FirstName: string read FFirst_name write FFirst_name;
    property HomeTown: string read FHome_town write FHome_town;
    property LastName: string read FLast_name write FLast_name;
    property Phone: string read FPhone write FPhone;
    property Relation: Extended read FRelation write FRelation;
    property RelationPartner: TVkRelationData read FRelation_partner write FRelation_partner;
    property RelationRequests: TArray<TVkRelationData> read FRelation_requests write FRelation_requests;
    property ScreenName: string read FScreen_name write FScreen_name;
    property Sex: Extended read FSex write FSex;
    property Status: string read FStatus write FStatus;
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

uses
  VK.CommonUtils;

{TVkProfileInfo}

constructor TVkProfileInfo.Create;
begin
  inherited;
  FCountry := TVkCountry.Create();
  FRelation_partner := TVkRelationData.Create();
end;

destructor TVkProfileInfo.Destroy;
begin
  TArrayHelp.FreeArrayOfObject<TVkRelationData>(FRelation_requests);
  FCountry.Free;
  FRelation_partner.Free;
  inherited;
end;

end.

