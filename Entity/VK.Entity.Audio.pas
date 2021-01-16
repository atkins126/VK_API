unit VK.Entity.Audio;

interface

uses
  Generics.Collections, REST.JsonReflect, REST.Json.Interceptors, System.SysUtils, Rest.Json, System.Json, VK.Entity.Common, VK.Types, VK.Entity.Attachment,
  VK.Entity.Common.List;

type
  TVkAudioArtist = class(TVkObject)
  private
    FDomain: string;
    FName: string;
  public
    property Domain: string read FDomain write FDomain;
    property Name: string read FName write FName;
  end;

  TVkAlbumThumb = class
  private
    FHeight: Integer;
    FPhoto_135: string;
    FPhoto_270: string;
    FPhoto_300: string;
    FPhoto_34: string;
    FPhoto_600: string;
    FPhoto_68: string;
    FWidth: Integer;
    FPhoto_1200: string;
  public
    property Height: Integer read FHeight write FHeight;
    property Width: Integer read FWidth write FWidth;
    property Photo34: string read FPhoto_34 write FPhoto_34;
    property Photo68: string read FPhoto_68 write FPhoto_68;
    property Photo135: string read FPhoto_135 write FPhoto_135;
    property Photo270: string read FPhoto_270 write FPhoto_270;
    property Photo300: string read FPhoto_300 write FPhoto_300;
    property Photo600: string read FPhoto_600 write FPhoto_600;
    property Photo1200: string read FPhoto_1200 write FPhoto_1200;
  end;

  TVkAudioAlbum = class(TVkObject)
  private
    FAccess_key: string;
    FOwner_id: Integer;
    FThumb: TVkAlbumThumb;
    FTitle: string;
  public
    property AccessKey: string read FAccess_key write FAccess_key;
    property OwnerId: Integer read FOwner_id write FOwner_id;
    property Thumb: TVkAlbumThumb read FThumb write FThumb;
    property Title: string read FTitle write FTitle;
    constructor Create; override;
    destructor Destroy; override;
  end;

  TVkAudioAds = class
  private
    FAccount_age_type: string;
    FContent_id: string;
    FDuration: string;
    FPuid22: string;
  public
    property AccountAgeType: string read FAccount_age_type write FAccount_age_type;
    property ContentId: string read FContent_id write FContent_id;
    property Duration: string read FDuration write FDuration;
    property PUID22: string read FPuid22 write FPuid22;
  end;

  TVkAudioChartInfo = class
  private
    FPosition: Integer;
  public
    property Position: Integer read FPosition write FPosition;
  end;

  TVkAudio = class(TVkObject, IAttachment)
  private
    FAccess_key: string;
    FAds: TVkAudioAds;
    FAlbum: TVkAudioAlbum;
    FArtist: string;
    [JsonReflectAttribute(ctString, rtString, TUnixDateTimeInterceptor)]
    FDate: TDateTime;
    FDuration: Integer;
    FGenre_id: Integer;
    FIs_licensed: Boolean;
    FMain_artists: TArray<TVkAudioArtist>;
    FOwner_id: Integer;
    FTitle: string;
    FTrack_code: string;
    FUrl: string;
    FLyrics_id: Integer;
    FAlbum_id: Integer;
    FNo_search: Boolean;
    FIs_hq: Boolean;
    FContent_restricted: Integer;
    FAudio_chart_info: TVkAudioChartInfo;
    FIs_explicit: Boolean;
    FStories_allowed: Boolean;
    FShort_videos_allowed: Boolean;
    FIs_focus_track: Boolean;
    FStories_cover_allowed: Boolean;
    FFeatured_artists: TArray<TVkAudioArtist>;
    FSubtitle: string;
    function GetAudioGenre: TAudioGenre;
    procedure SetAudioGenre(const Value: TAudioGenre);
  public
    property AccessKey: string read FAccess_key write FAccess_key;
    property Ads: TVkAudioAds read FAds write FAds;
    property Album: TVkAudioAlbum read FAlbum write FAlbum;
    property AlbumId: Integer read FAlbum_id write FAlbum_id;
    property Artist: string read FArtist write FArtist;
    property AudioChartInfo: TVkAudioChartInfo read FAudio_chart_info write FAudio_chart_info;
    property ContentRestricted: Integer read FContent_restricted write FContent_restricted;
    property Date: TDateTime read FDate write FDate;
    property Duration: Integer read FDuration write FDuration;
    property FeaturedArtists: TArray<TVkAudioArtist> read FFeatured_artists write FFeatured_artists;
    property Genre: TAudioGenre read GetAudioGenre write SetAudioGenre;
    property GenreId: Integer read FGenre_id write FGenre_id;
    property IsExplicit: Boolean read FIs_explicit write FIs_explicit;
    property IsFocusTrack: Boolean read FIs_focus_track write FIs_focus_track;
    property IsHQ: Boolean read FIs_hq write FIs_hq;
    property IsLicensed: Boolean read FIs_licensed write FIs_licensed;
    property LyricsId: Integer read FLyrics_id write FLyrics_id;
    property MainArtists: TArray<TVkAudioArtist> read FMain_artists write FMain_artists;
    property NoSearch: Boolean read FNo_search write FNo_search;
    property OwnerId: Integer read FOwner_id write FOwner_id;
    property ShortVideosAllowed: Boolean read FShort_videos_allowed write FShort_videos_allowed;
    property StoriesAllowed: Boolean read FStories_allowed write FStories_allowed;
    property StoriesCoverAllowed: Boolean read FStories_cover_allowed write FStories_cover_allowed;
    property Subtitle: string read FSubtitle write FSubtitle;
    property Title: string read FTitle write FTitle;
    property TrackCode: string read FTrack_code write FTrack_code;
    property Url: string read FUrl write FUrl;
    constructor Create; override;
    destructor Destroy; override;
    function ToAttachment: string;
    function DurationText(const AFormat: string): string;
  end;

  TVkAudioIndex = record
    OwnerId: Integer;
    AudioId: Integer;
  end;

  TVkAudioIndexes = TArray<TVkAudioIndex>;

  TVkAudios = TVkEntityList<TVkAudio>;

  TVkAudioInfo = class(TVkEntity)
  private
    FAudio_id: Integer;
  public
    property AudioId: Integer read FAudio_id write FAudio_id;
  end;

  TVkAudioInfoItems = TVkEntityList<TVkAudioInfo>;

implementation

uses
  VK.CommonUtils;

{TVkAudio}

constructor TVkAudio.Create;
begin
  inherited;
end;

destructor TVkAudio.Destroy;
begin
  TArrayHelp.FreeArrayOfObject<TVkAudioArtist>(FMain_artists);
  TArrayHelp.FreeArrayOfObject<TVkAudioArtist>(FFeatured_artists);
  if Assigned(FAudio_chart_info) then
    FAudio_chart_info.Free;
  if Assigned(FAlbum) then
    FAlbum.Free;
  if Assigned(FAds) then
    FAds.Free;
  inherited;
end;

function TVkAudio.DurationText(const AFormat: string): string;
var
  M, S: Integer;
begin
  S := Trunc(Duration);
  M := S div 60;
  S := S mod 60;
  Result := Format(AFormat, [M, S]);
end;

function TVkAudio.ToAttachment: string;
begin
  Result := Attachment.Audio(Id, OwnerId, AccessKey);
end;

function TVkAudio.GetAudioGenre: TAudioGenre;
begin
  Result := TAudioGenre.Create(FGenre_Id);
end;

procedure TVkAudio.SetAudioGenre(const Value: TAudioGenre);
begin
  FGenre_id := VkAudioGenres[Value];
end;

{TAlbumClass}

constructor TVkAudioAlbum.Create;
begin
  inherited;
  FThumb := TVkAlbumThumb.Create();
end;

destructor TVkAudioAlbum.Destroy;
begin
  FThumb.Free;
  inherited;
end;

end.

