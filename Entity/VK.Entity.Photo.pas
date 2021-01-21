unit VK.Entity.Photo;

interface

uses
  Generics.Collections, REST.Json.Interceptors, REST.JsonReflect, Rest.Json,
  VK.Entity.Common, VK.Entity.Info, VK.Entity.Attachment;

type
  TVkPhotoTag = class(TVkObject)
  private
    [JsonReflectAttribute(ctString, rtString, TUnixDateTimeInterceptor)]
    FDate: TDateTime;
    FPlacer_id: Integer;
    FTagged_name: string;
    FUser_id: Integer;
    FViewed: Boolean;
    FX: Integer;
    FX2: Integer;
    FY: Integer;
    FY2: Integer;
  public
    property Date: TDateTime read FDate write FDate;
    property PlacerId: Integer read FPlacer_id write FPlacer_id;
    property TaggedName: string read FTagged_name write FTagged_name;
    property UserId: Integer read FUser_id write FUser_id;
    property Viewed: Boolean read FViewed write FViewed;
    property X: Integer read FX write FX;
    property X2: Integer read FX2 write FX2;
    property Y: Integer read FY write FY;
    property Y2: Integer read FY2 write FY2;
  end;

  TVkPhotoTags = class(TVkEntity)
  private
    FItems: TArray<TVkPhotoTag>;
    FCount: Integer;
  public
    property Items: TArray<TVkPhotoTag> read FItems write FItems;
    property Count: Integer read FCount write FCount;
    destructor Destroy; override;
  end;

  TVkPhoto = class(TVkObject, IAttachment)
  private
    FAlbum_id: Integer;
    FCan_comment: Integer;
    FCan_repost: Integer;
    FComments: TVkCommentsInfo;
    [JsonReflectAttribute(ctString, rtString, TUnixDateTimeInterceptor)]
    FDate: TDateTime;
    FLikes: TVkLikesInfo;
    FOwner_id: Integer;
    FReposts: TVkRepostsInfo;
    FSizes: TVkSizes;
    FTags: TVkTags;
    FText: string;
    FUser_id: Integer;
    FWidth: Integer;
    FHeight: Integer;
    FAccess_key: string;
    FPhoto_604: string;
    FPhoto_75: string;
    FPhoto_1280: string;
    FPhoto_807: string;
    FPhoto_2560: string;
    FPhoto_130: string;
    FHas_tags: Boolean;
    [JsonReflectAttribute(ctString, rtString, TUnixDateTimeInterceptor)]
    FTag_created: TDateTime;
    FPlacer_id: Integer;
    FTag_id: Integer;
  public
    property AlbumId: Integer read FAlbum_id write FAlbum_id;
    property OwnerId: Integer read FOwner_id write FOwner_id;
    property UserId: Integer read FUser_id write FUser_id;
    property Text: string read FText write FText;
    property Date: TDateTime read FDate write FDate;
    property Sizes: TVkSizes read FSizes write FSizes;
    property Width: Integer read FWidth write FWidth;
    property Height: Integer read FHeight write FHeight;
    //
    property CanComment: Integer read FCan_comment write FCan_comment;
    property CanRepost: Integer read FCan_repost write FCan_repost;
    property Comments: TVkCommentsInfo read FComments write FComments;
    property Likes: TVkLikesInfo read FLikes write FLikes;
    property Reposts: TVkRepostsInfo read FReposts write FReposts;
    property Tags: TVkTags read FTags write FTags;
    property AccessKey: string read FAccess_key write FAccess_key;
    property HasTags: Boolean read FHas_tags write FHas_tags;
    // old field api < 5.77
    property Photo1280: string read FPhoto_1280 write FPhoto_1280;
    property Photo130: string read FPhoto_130 write FPhoto_130;
    property Photo2560: string read FPhoto_2560 write FPhoto_2560;
    property Photo604: string read FPhoto_604 write FPhoto_604;
    property Photo75: string read FPhoto_75 write FPhoto_75;
    property Photo807: string read FPhoto_807 write FPhoto_807;
    //
    property PlacerId: Integer read FPlacer_id write FPlacer_id;
    property TagCreated: TDateTime read FTag_created write FTag_created;
    property TagId: Integer read FTag_id write FTag_id;
    //
    constructor Create; override;
    destructor Destroy; override;
    function ToAttachment: string;
  end;

  TVkCropPhoto = class(TVkEntity)
  private
    FCrop: TVkCrop;
    FPhoto: TVkPhoto;
    FRect: TVkRect;
  public
    property Photo: TVkPhoto read FPhoto write FPhoto;
    property Crop: TVkCrop read FCrop write FCrop;
    property Rect: TVkRect read FRect write FRect;
  end;

  TVkPostedPhoto = class(TVkObject)
  private
    FOwner_id: Integer;
    FPhoto_130: string;
    FPhoto_604: string;
  public
    property OwnerId: Integer read FOwner_id write FOwner_id;
    property Photo130: string read FPhoto_130 write FPhoto_130;
    property Photo604: string read FPhoto_604 write FPhoto_604;
  end;

  TVkPhotos = class(TVkEntity)
  private
    FItems: TArray<TVkPhoto>;
    FCount: Integer;
    FSaveObjects: Boolean;
    procedure SetSaveObjects(const Value: Boolean);
  public
    property Items: TArray<TVkPhoto> read FItems write FItems;
    property Count: Integer read FCount write FCount;
    property SaveObjects: Boolean read FSaveObjects write SetSaveObjects;
    procedure Append(Users: TVkPhotos);
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

uses
  VK.Types, VK.CommonUtils;

{TVkPhoto}

constructor TVkPhoto.Create;
begin
  inherited;
  FLikes := TVkLikesInfo.Create;
  FReposts := TVkRepostsInfo.Create;
  FComments := TVkCommentsInfo.Create;
  FTags := TVkTags.Create;
end;

destructor TVkPhoto.Destroy;
begin
  TArrayHelp.FreeArrayOfObject<TVkSize>(FSizes);
  FLikes.Free;
  FReposts.Free;
  FComments.Free;
  FTags.Free;
  inherited;
end;

function TVkPhoto.ToAttachment: string;
begin
  Attachment.Photo(Id, OwnerId, AccessKey);
end;

{TVkPhotos}

procedure TVkPhotos.Append(Users: TVkPhotos);
var
  OldLen: Integer;
begin
  OldLen := Length(Items);
  SetLength(FItems, OldLen + Length(Users.Items));
  Move(Users.Items[0], FItems[OldLen], Length(Users.Items) * SizeOf(TVkPhoto));
end;

constructor TVkPhotos.Create;
begin
  inherited;
  FSaveObjects := False;
end;

destructor TVkPhotos.Destroy;
begin
  {$IFNDEF AUTOREFCOUNT}
  if not FSaveObjects then
  begin
    TArrayHelp.FreeArrayOfObject<TVkPhoto>(FItems);
  end;
  {$ENDIF}
  inherited;
end;

procedure TVkPhotos.SetSaveObjects(const Value: Boolean);
begin
  FSaveObjects := Value;
end;

{ TVkPhotoTags }

destructor TVkPhotoTags.Destroy;
begin
  TArrayHelp.FreeArrayOfObject<TVkPhotoTag>(FItems);
  inherited;
end;

end.

