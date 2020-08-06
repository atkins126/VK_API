unit VK.Entity.Stories.Stats;

interface

uses
  Generics.Collections, Rest.Json;

type
  TVkStoryStatCounter = class
  private
    FCount: Integer;
    FState: string;
  public
    property Count: Integer read FCount write FCount;
    /// <summary>
    /// on � ��������, off � ����������, hidden � ����������
    /// </summary>
    property State: string read FState write FState;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkStoryStatCounter;
  end;

  TVkStoryStat = class
  private
    FAnswer: TVkStoryStatCounter;
    FBans: TVkStoryStatCounter;
    FLikes: TVkStoryStatCounter;
    FOpen_link: TVkStoryStatCounter;
    FReplies: TVkStoryStatCounter;
    FShares: TVkStoryStatCounter;
    FSubscribers: TVkStoryStatCounter;
    FViews: TVkStoryStatCounter;
  public
    property Answer: TVkStoryStatCounter read FAnswer write FAnswer;
    property Bans: TVkStoryStatCounter read FBans write FBans;
    property Likes: TVkStoryStatCounter read FLikes write FLikes;
    property OpenLink: TVkStoryStatCounter read FOpen_link write FOpen_link;
    property Replies: TVkStoryStatCounter read FReplies write FReplies;
    property Shares: TVkStoryStatCounter read FShares write FShares;
    property Subscribers: TVkStoryStatCounter read FSubscribers write FSubscribers;
    property Views: TVkStoryStatCounter read FViews write FViews;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkStoryStat;
  end;

implementation

{TVkStoryStatCounter}

function TVkStoryStatCounter.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVkStoryStatCounter.FromJsonString(AJsonString: string): TVkStoryStatCounter;
begin
  result := TJson.JsonToObject<TVkStoryStatCounter>(AJsonString)
end;

{TRootClass}

constructor TVkStoryStat.Create;
begin
  inherited;
  FAnswer := TVkStoryStatCounter.Create();
  FBans := TVkStoryStatCounter.Create();
  FOpen_link := TVkStoryStatCounter.Create();
  FReplies := TVkStoryStatCounter.Create();
  FShares := TVkStoryStatCounter.Create();
  FSubscribers := TVkStoryStatCounter.Create();
  FViews := TVkStoryStatCounter.Create();
  FLikes := TVkStoryStatCounter.Create();
end;

destructor TVkStoryStat.Destroy;
begin
  FAnswer.Free;
  FBans.Free;
  FOpen_link.Free;
  FReplies.Free;
  FShares.Free;
  FSubscribers.Free;
  FViews.Free;
  FLikes.Free;
  inherited;
end;

function TVkStoryStat.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVkStoryStat.FromJsonString(AJsonString: string): TVkStoryStat;
begin
  result := TJson.JsonToObject<TVkStoryStat>(AJsonString)
end;

end.

