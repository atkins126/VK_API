unit VK.Entity.Poll;

interface

uses
  Generics.Collections, Rest.Json, VK.Entity.Photo, VK.Entity.Profile,
  VK.Entity.Group, VK.Entity.Common;

type
  TVkPollFriends = class(TVkObject)
  public
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkPollFriends;
  end;

  TVkPollPoints = class
  private
    FColor: string;
    FPosition: Integer;
  public
    property Color: string read FColor write FColor;
    property Position: Integer read FPosition write FPosition;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkPollPoints;
  end;

  TVkPollBackground = class(TVkObject)
  private
    FAngle: Integer;
    FColor: string;
    FName: string;
    FPoints: TArray<TVkPollPoints>;
    FType: string;
  public
    property Angle: Integer read FAngle write FAngle;
    property Color: string read FColor write FColor;
    property Name: string read FName write FName;
    property Points: TArray<TVkPollPoints> read FPoints write FPoints;
    property&Type: string read FType write FType;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkPollBackground;
  end;

  TVkPollBackgrounds = class
  private
    FItems: TArray<TVkPollBackground>;
  public
    property Items: TArray<TVkPollBackground> read FItems write FItems;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkPollBackgrounds;
  end;

  TVkPollAnswer = class(TVkObject)
  private
    FRate: Integer;
    FText: string;
    FVotes: Integer;
  public
    property Rate: Integer read FRate write FRate;
    property Text: string read FText write FText;
    property Votes: Integer read FVotes write FVotes;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkPollAnswer;
  end;

  TVkPoll = class(TVkObject)
  private
    FAnonymous: Boolean;
    FAnswer_ids: TArray<Integer>;
    FAnswers: TArray<TVkPollAnswer>;
    FAuthor_id: Integer;
    FBackground: TVkPollBackground;
    FCan_edit: Boolean;
    FCan_report: Boolean;
    FCan_share: Boolean;
    FCan_vote: Boolean;
    FClosed: Boolean;
    FCreated: Int64;
    FEnd_date: Int64;
    FIs_board: Boolean;
    FMultiple: Boolean;
    FOwner_id: Integer;
    FQuestion: string;
    FVotes: Integer;
    FPhoto: TVkPhoto;
    FFriends: TArray<TVkPollFriends>;
    FDisable_unvote: Boolean;
    FProfiles: TArray<TVkProfile>;
    FGroups: TArray<TVkGroup>;
  public
    property OwnerId: Integer read FOwner_id write FOwner_id;
    property Created: Int64 read FCreated write FCreated;
    property Question: string read FQuestion write FQuestion;
    property Votes: Integer read FVotes write FVotes;
    property Answers: TArray<TVkPollAnswer> read FAnswers write FAnswers;
    property Anonymous: Boolean read FAnonymous write FAnonymous;
    property Multiple: Boolean read FMultiple write FMultiple;
    property AnswerIds: TArray<Integer> read FAnswer_ids write FAnswer_ids;
    property EndDate: Int64 read FEnd_date write FEnd_date;
    property Closed: Boolean read FClosed write FClosed;
    property IsBoard: Boolean read FIs_board write FIs_board;
    property CanEdit: Boolean read FCan_edit write FCan_edit;
    property CanVote: Boolean read FCan_vote write FCan_vote;
    property CanReport: Boolean read FCan_report write FCan_report;
    property CanShare: Boolean read FCan_share write FCan_share;
    property AuthorId: Integer read FAuthor_id write FAuthor_id;
    property Photo: TVkPhoto read FPhoto write FPhoto;
    property Background: TVkPollBackground read FBackground write FBackground;
    property Friends: TArray<TVkPollFriends> read FFriends write FFriends;
    property DisableUnvote: Boolean read FDisable_unvote write FDisable_unvote;
    //Extended
    property Profiles: TArray<TVkProfile> read FProfiles write FProfiles;
    property Groups: TArray<TVkGroup> read FGroups write FGroups;
    //
    constructor Create; override;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkPoll;
  end;

  TVkPollVoters = class
  private
    FAnswer_id: Integer;
    FUsers: TVkProfiles;
  public
    property AnswerId: Integer read FAnswer_id write FAnswer_id;
    property Users: TVkProfiles read FUsers write FUsers;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkPollVoters;
  end;

implementation

uses
  VK.CommonUtils;

{TVkPollPoints}

function TVkPollPoints.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVkPollPoints.FromJsonString(AJsonString: string): TVkPollPoints;
begin
  result := TJson.JsonToObject<TVkPollPoints>(AJsonString)
end;

{TVkPollBackground}

destructor TVkPollBackground.Destroy;
begin
  TArrayHelp.FreeArrayOfObject<TVkPollPoints>(FPoints);
  inherited;
end;

function TVkPollBackground.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVkPollBackground.FromJsonString(AJsonString: string): TVkPollBackground;
begin
  result := TJson.JsonToObject<TVkPollBackground>(AJsonString)
end;

{TVkPollAnswer}

function TVkPollAnswer.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVkPollAnswer.FromJsonString(AJsonString: string): TVkPollAnswer;
begin
  result := TJson.JsonToObject<TVkPollAnswer>(AJsonString)
end;

{TVkPoll}

constructor TVkPoll.Create;
begin
  inherited;
  FBackground := TVkPollBackground.Create();
end;

destructor TVkPoll.Destroy;
begin
  TArrayHelp.FreeArrayOfObject<TVkPollAnswer>(FAnswers);
  TArrayHelp.FreeArrayOfObject<TVkPollFriends>(FFriends);
  TArrayHelp.FreeArrayOfObject<TVkGroup>(FGroups);
  TArrayHelp.FreeArrayOfObject<TVkProfile>(FProfiles);
  if Assigned(FPhoto) then
    FPhoto.Free;
  FBackground.Free;
  inherited;
end;

function TVkPoll.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVkPoll.FromJsonString(AJsonString: string): TVkPoll;
begin
  result := TJson.JsonToObject<TVkPoll>(AJsonString)
end;

{ TVkPollFriends }

function TVkPollFriends.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVkPollFriends.FromJsonString(AJsonString: string): TVkPollFriends;
begin
  result := TJson.JsonToObject<TVkPollFriends>(AJsonString)
end;

{ TVkPollBackgrounds }

destructor TVkPollBackgrounds.Destroy;
begin
  TArrayHelp.FreeArrayOfObject<TVkPollBackground>(FItems);
  inherited;
end;

class function TVkPollBackgrounds.FromJsonString(AJsonString: string): TVkPollBackgrounds;
begin
  result := TJson.JsonToObject<TVkPollBackgrounds>(AJsonString)
end;

function TVkPollBackgrounds.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

{ TVkPollVoters }

class function TVkPollVoters.FromJsonString(AJsonString: string): TVkPollVoters;
begin
  result := TJson.JsonToObject<TVkPollVoters>(AJsonString)
end;

function TVkPollVoters.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

end.

