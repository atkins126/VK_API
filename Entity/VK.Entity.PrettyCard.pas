unit VK.Entity.PrettyCard;

interface

uses
  Generics.Collections, Rest.Json, VK.Entity.Link, VK.Entity.Common, VK.Entity.Common.List;

type
  TVkPrettyCard = class(TVkEntity)
  private
    FButton: TVkLinkButton;
    FCard_id: string;
    FImages: TArray<TVkImage>;
    FLink_url: string;
    FPrice: string;
    FPrice_old: string;
    FTitle: string;
  public
    property Button: TVkLinkButton read FButton write FButton;
    property CardId: string read FCard_id write FCard_id;
    property Images: TArray<TVkImage> read FImages write FImages;
    property LinkUrl: string read FLink_url write FLink_url;
    property Price: string read FPrice write FPrice;
    property PriceOld: string read FPrice_old write FPrice_old;
    property Title: string read FTitle write FTitle;
    constructor Create; override;
    destructor Destroy; override;
  end;

  TVkPrettyCards = TVkEntityList<TVkPrettyCard>;

implementation

uses
  VK.CommonUtils;

{TVkPrettyCard}

constructor TVkPrettyCard.Create;
begin
  inherited;
  FButton := TVkLinkButton.Create();
end;

destructor TVkPrettyCard.Destroy;
begin
  TArrayHelp.FreeArrayOfObject<TVkImage>(FImages);
  FButton.Free;
  inherited;
end;

end.

