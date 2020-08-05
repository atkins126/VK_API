unit VKAuth.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Types, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VK.API, VK.Components, VK.Types, Vcl.ExtCtrls, VK.Handler, Vcl.StdCtrls,
  System.Generics.Defaults, Vcl.ComCtrls, VK.UserEvents, VK.GroupEvents, VK.Entity.Media, System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent, VK.Entity.Message, VK.Entity.ClientInfo, VK.Entity.Video,
  VK.Entity.Photo, VK.Entity.Audio, VK.Entity.GroupSettings;

type
  TFormMain = class(TForm)
    VK1: TVK;
    Panel1: TPanel;
    LabelLogin: TLabel;
    Panel2: TPanel;
    Memo1: TMemo;
    MemoLog: TMemo;
    VkUserEvents1: TVkUserEvents;
    VkGroupEventsController1: TVkGroupEventsController;
    VkGroupEvents1: TVkGroupEvents;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    TabSheet3: TTabSheet;
    Button21: TButton;
    Button23: TButton;
    Button24: TButton;
    TabSheet4: TTabSheet;
    Button22: TButton;
    TabSheet5: TTabSheet;
    Button17: TButton;
    Button18: TButton;
    TabSheet6: TTabSheet;
    Button19: TButton;
    TabSheet7: TTabSheet;
    Button12: TButton;
    TabSheet8: TTabSheet;
    Button25: TButton;
    TabSheet9: TTabSheet;
    Button20: TButton;
    Button26: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button8: TButton;
    TabSheet10: TTabSheet;
    Button27: TButton;
    TabSheet11: TTabSheet;
    Button28: TButton;
    Button29: TButton;
    Button30: TButton;
    ButtonGetCatalog: TButton;
    ButtonCreatePlaylist: TButton;
    ButtonEditPlaylist: TButton;
    Button31: TButton;
    TabSheetPolls: TTabSheet;
    Button32: TButton;
    TabSheetPodcasts: TTabSheet;
    Button33: TButton;
    Button34: TButton;
    Button35: TButton;
    Button36: TButton;
    Button37: TButton;
    Button38: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure VK1Login(Sender: TObject);
    procedure VK1Log(Sender: TObject; const Value: string);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure VkUserEvents1UserOnline(Sender: TObject; UserId: Integer; VkPlatform: TVkPlatform; TimeStamp: TDateTime);
    procedure VkUserEvents1RecoverMessages(Sender: TObject; PeerId, LocalId: Integer);
    procedure VkUserEvents1ChangeDialogFlags(Sender: TObject; DialogChangeData: TDialogChangeData);
    procedure VkUserEvents1ChangeMessageFlags(Sender: TObject; MessageChangeData: TMessageChangeData);
    procedure VkUserEvents1ChatChanged(Sender: TObject; const ChatId: Integer; IsSelf: Boolean);
    procedure VkUserEvents1ChatChangeInfo(Sender: TObject; const PeerId: Integer; TypeId: TChatChangeInfoType; Info: Integer);
    procedure VkUserEvents1DeleteMessages(Sender: TObject; PeerId, LocalId: Integer);
    procedure VkUserEvents1EditMessage(Sender: TObject; MessageData: TMessageData);
    procedure VkUserEvents1UserOffline(Sender: TObject; UserId: Integer; InactiveUser: Boolean; TimeStamp: TDateTime);
    procedure VkUserEvents1NewMessage(Sender: TObject; MessageData: TMessageData);
    procedure VkUserEvents1ReadMessages(Sender: TObject; Incoming: Boolean; PeerId, LocalId: Integer);
    procedure VkUserEvents1UsersRecording(Sender: TObject; Data: TChatRecordingData);
    procedure VkUserEvents1UsersTyping(Sender: TObject; Data: TChatTypingData);
    procedure VkUserEvents1UserTyping(Sender: TObject; UserId, ChatId: Integer);
    procedure VkUserEvents1UserCall(Sender: TObject; UserId, CallId: Integer);
    procedure VkUserEvents1CountChange(Sender: TObject; Count: Integer);
    procedure VkUserEvents1NotifyChange(Sender: TObject; PeerId: Integer; Sound: Boolean; DisableUntil: Integer);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure VkGroupEventsController1MessageNew(Sender: TObject; GroupId: Integer; Message: TVkMessage; ClientInfo:
      TVkClientInfo; EventId: string);
    procedure VkGroupEventsController1WallReplyRestore(Sender: TObject; GroupId: Integer; Comment: TVkComment; Info:
      TVkObjectInfo; EventId: string);
    procedure VkGroupEventsController1WallReplyNew(Sender: TObject; GroupId: Integer; Comment: TVkComment; Info:
      TVkObjectInfo; EventId: string);
    procedure VkGroupEventsController1WallReplyEdit(Sender: TObject; GroupId: Integer; Comment: TVkComment; Info:
      TVkObjectInfo; EventId: string);
    procedure VkGroupEventsController1WallReplyDelete(Sender: TObject; GroupId: Integer; Info: TVkCommentInfo; EventId: string);
    procedure VkGroupEventsController1WallPostNew(Sender: TObject; GroupId: Integer; Post: TVkPost; EventId: string);
    procedure VkGroupEventsController1WallRepost(Sender: TObject; GroupId: Integer; Post: TVkPost; EventId: string);
    procedure VkGroupEventsController1VideoNew(Sender: TObject; GroupId: Integer; Video: TVkVideo; EventId: string);
    procedure VkGroupEventsController1VideoCommentRestore(Sender: TObject; GroupId: Integer; Comment: TVkComment; Info:
      TVkObjectInfo; EventId: string);
    procedure VkGroupEventsController1PhotoCommentRestore(Sender: TObject; GroupId: Integer; Comment: TVkComment; Info:
      TVkObjectInfo; EventId: string);
    procedure VkGroupEventsController1MarketCommentRestore(Sender: TObject; GroupId: Integer; Comment: TVkComment; Info:
      TVkObjectInfo; EventId: string);
    procedure VkGroupEventsController1VideoCommentNew(Sender: TObject; GroupId: Integer; Comment: TVkComment; Info:
      TVkObjectInfo; EventId: string);
    procedure VkGroupEventsController1PhotoCommentNew(Sender: TObject; GroupId: Integer; Comment: TVkComment; Info:
      TVkObjectInfo; EventId: string);
    procedure VkGroupEventsController1MarketCommentNew(Sender: TObject; GroupId: Integer; Comment: TVkComment; Info:
      TVkObjectInfo; EventId: string);
    procedure VkGroupEventsController1VideoCommentEdit(Sender: TObject; GroupId: Integer; Comment: TVkComment; Info:
      TVkObjectInfo; EventId: string);
    procedure VkGroupEventsController1PhotoCommentEdit(Sender: TObject; GroupId: Integer; Comment: TVkComment; Info:
      TVkObjectInfo; EventId: string);
    procedure VkGroupEventsController1MarketCommentEdit(Sender: TObject; GroupId: Integer; Comment: TVkComment; Info:
      TVkObjectInfo; EventId: string);
    procedure VkGroupEventsController1BoardPostRestore(Sender: TObject; GroupId: Integer; Comment: TVkComment; Info:
      TVkObjectInfo; EventId: string);
    procedure VkGroupEventsController1BoardPostEdit(Sender: TObject; GroupId: Integer; Comment: TVkComment; Info:
      TVkObjectInfo; EventId: string);
    procedure VkGroupEventsController1BoardPostNew(Sender: TObject; GroupId: Integer; Comment: TVkComment; Info:
      TVkObjectInfo; EventId: string);
    procedure VkGroupEventsController1VideoCommentDelete(Sender: TObject; GroupId: Integer; Info: TVkCommentInfo;
      EventId: string);
    procedure VkGroupEventsController1PhotoCommentDelete(Sender: TObject; GroupId: Integer; Info: TVkCommentInfo;
      EventId: string);
    procedure VkGroupEventsController1MarketCommentDelete(Sender: TObject; GroupId: Integer; Info: TVkCommentInfo;
      EventId: string);
    procedure VkGroupEventsController1BoardPostDelete(Sender: TObject; GroupId: Integer; Info: TVkCommentInfo; EventId: string);
    procedure VkGroupEventsController1PhotoNew(Sender: TObject; GroupId: Integer; Photo: TVkPhoto; EventId: string);
    procedure VkGroupEventsController1AudioNew(Sender: TObject; GroupId: Integer; Audio: TVkAudio; EventId: string);
    procedure VkGroupEventsController1GroupJoin(Sender: TObject; GroupId, UserId: Integer; JoinType: TVkGroupJoinType;
      EventId: string);
    procedure VkGroupEventsController1GroupLeave(Sender: TObject; GroupId, UserId: Integer; IsSelf: Boolean; EventId: string);
    procedure VkGroupEventsController1UserBlock(Sender: TObject; GroupId: Integer; Info: TVkGroupUserBlock; EventId: string);
    procedure VkGroupEventsController1UserUnBlock(Sender: TObject; GroupId: Integer; Info: TVkGroupUserUnBlock; EventId: string);
    procedure VkGroupEventsController1MessageReply(Sender: TObject; GroupId: Integer; Message: TVkMessage; EventId: string);
    procedure VkGroupEventsController1MessageEdit(Sender: TObject; GroupId: Integer; Message: TVkMessage; EventId: string);
    procedure VkGroupEventsController1MessageDeny(Sender: TObject; GroupId, UserId: Integer; Key, EventId: string);
    procedure VkGroupEventsController1MessageAllow(Sender: TObject; GroupId, UserId: Integer; Key, EventId: string);
    procedure VkGroupEventsController1GroupPollVoteNew(Sender: TObject; GroupId: Integer; Info: TVkGroupPollVoteNew;
      EventId: string);
    procedure VkGroupEventsController1GroupOfficersEdit(Sender: TObject; GroupId: Integer; Info: TVkGroupOfficersEdit;
      EventId: string);
    procedure VkGroupEventsController1GroupChangeSettings(Sender: TObject; GroupId: Integer; Changes:
      TVkGroupSettingsChange; EventId: string);
    procedure VkGroupEventsController1GroupChangePhoto(Sender: TObject; GroupId: Integer; Changes: TVkGroupChangePhoto;
      EventId: string);
    procedure VkGroupEventsController1GroupAppPayload(Sender: TObject; GroupId: Integer; Info: TVkAppPayload; EventId: string);
    procedure VkGroupEventsController1GroupPayTransaction(Sender: TObject; GroupId: Integer; Info: TVkPayTransaction;
      EventId: string);
    procedure VkGroupEventsController1MessageTypingState(Sender: TObject; GroupId, UserId: Integer; State, EventId: string);
    procedure Button21Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure VK1Error(Sender: TObject; E: Exception; Code: Integer; Text: string);
    procedure VK1ErrorLogin(Sender: TObject; E: Exception; Code: Integer; Text: string);
    procedure Button23Click(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure Button25Click(Sender: TObject);
    procedure Button26Click(Sender: TObject);
    procedure Button27Click(Sender: TObject);
    procedure Button28Click(Sender: TObject);
    procedure Button29Click(Sender: TObject);
    procedure Button30Click(Sender: TObject);
    procedure VK1Auth(Sender: TObject; Url: string; var Token: string; var TokenExpiry: Int64; var ChangePasswordHash: string);
    procedure ButtonGetCatalogClick(Sender: TObject);
    procedure ButtonCreatePlaylistClick(Sender: TObject);
    procedure ButtonEditPlaylistClick(Sender: TObject);
    procedure Button31Click(Sender: TObject);
    procedure Button32Click(Sender: TObject);
    procedure Button33Click(Sender: TObject);
    procedure Button34Click(Sender: TObject);
    procedure Button35Click(Sender: TObject);
    procedure Button36Click(Sender: TObject);
    procedure Button37Click(Sender: TObject);
    procedure Button38Click(Sender: TObject);
  private
    FToken: string;
    FChangePasswordHash: string;
    FTokenExpiry: Int64;
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

uses
  VK.Entity.AccountInfo, VK.Entity.ProfileInfo, VK.Entity.ActiveOffers, VK.Entity.Counters, VK.Entity.PushSettings,
  VK.Entity.Profile, VK.Entity.Keyboard, VK.Status, VK.Wall, VK.Docs, VK.Entity.Doc.Save, VK.Utils, VK.Account,
  VK.Entity.AccountInfoRequest, VK.Vcl.OAuth2, VK.Entity.Playlist, VK.Audio, VK.Messages, VK.Entity.Audio.Upload,
  VK.Entity.Conversation, VK.Entity.Status, VK.Entity.Catalog, VK.Entity.Catalog.Section, VK.CommonUtils, VK.Groups,
  VK.Entity.Audio.Catalog, VK.Entity.Poll, VK.Entity.Podcast, VK.Entity.Search, VK.Entity.Database.Regions,
  VK.Entity.Database.Schools, VK.Entity.Storage;

{$R *.dfm}

procedure TFormMain.Button10Click(Sender: TObject);
begin
  if VK1.Account.SetOffline then
    Memo1.Lines.Add('offline')
  else
    Memo1.Lines.Add('Error offline');
end;

procedure TFormMain.Button11Click(Sender: TObject);
begin
  if VK1.Auth.CheckPhone('+79512202849', True) then
    Memo1.Lines.Add('CheckPhone')
  else
    Memo1.Lines.Add('Error CheckPhone');
end;

procedure TFormMain.Button12Click(Sender: TObject);
var
  Users: TVkProfiles;
  i: Integer;
begin
  if VK1.Users.Get(Users, [286400863, 415730216], TVkProfileFields.All) then
  begin
    for i := Low(Users.Items) to High(Users.Items) do
    begin
      Memo1.Lines.Add('About: ' + Users.Items[i].About);
      Memo1.Lines.Add('BirthDate: ' + Users.Items[i].BirthDate);
      Memo1.Lines.Add('Books: ' + Users.Items[i].Books);
      Memo1.Lines.Add('Domain: ' + Users.Items[i].Domain);
      Memo1.Lines.Add('FirstName: ' + Users.Items[i].FirstName);
      Memo1.Lines.Add('Movies: ' + Users.Items[i].Movies);
      Memo1.Lines.Add('------------');
    end;
    Users.Free;
  end;
end;

procedure TFormMain.Button13Click(Sender: TObject);
begin
  VkUserEvents1.Start;
end;

procedure TFormMain.Button14Click(Sender: TObject);
begin
  VkUserEvents1.Stop;
end;

procedure TFormMain.Button15Click(Sender: TObject);
begin
  VkGroupEventsController1.Start;
end;

procedure TFormMain.Button16Click(Sender: TObject);
begin
  VkGroupEventsController1.Stop;
end;

procedure TFormMain.Button17Click(Sender: TObject);
var
  Status: TVkStatus;
begin
  if Vk1.Status.Get(Status) then
  begin
    Memo1.Lines.Add(Status.Text);
    if Assigned(Status.Audio) then
    begin
      Memo1.Lines.Add(Status.Audio.Artist + ' ' + Status.Audio.Title + ', ' + Status.Audio.Url);
    end;
    Status.Free;
  end
  else
    Memo1.Lines.Add('Error');
end;

procedure TFormMain.Button18Click(Sender: TObject);
begin
  if VK1.Status.&Set('Test22') then
    Memo1.Lines.Add('Status set')
  else
    Memo1.Lines.Add('Status not set');
end;

procedure TFormMain.Button19Click(Sender: TObject);
var
  Params: TVkParamsWallPost;
begin
//  VK1.Wall.Post('', -145962568, ['video58553419_456239240']);
  Params.Message('Test Text');
  Params.OwnerId(-145962568);
  Params.FromGroup(True);
  Params.Signed(True);
  Params.Attachments(Attachment.Doc(533494309, 58553419, '657138cd5d7842ae0a'));
  VK1.Wall.Post(Params);
end;

procedure TFormMain.Button1Click(Sender: TObject);
begin
  if VK1.Account.Ban(-1) then
    Memo1.Lines.Add('Banned')
  else
    Memo1.Lines.Add('Error banned');
end;

procedure TFormMain.Button20Click(Sender: TObject);
var
  Url, Response: string;
  Doc: TVkDocSaved;
begin
  if VK1.Docs.GetMessagesUploadServer(Url, dutAudioMessage) then
  begin
    if VK1.Uploader.Upload(Url, '1.ogg', Response) then
    begin
      if VK1.Docs.Save(Doc, Response, '�������� �����������', '') then
      begin
        Memo1.Lines.Add(Doc.&Type);
        Memo1.Lines.Add(Doc.AudioMessage.LinkOgg);
        Memo1.Lines.Add(Doc.AudioMessage.ToAttachment);
        Doc.Free;
      end;
    end
    else
    begin
      Memo1.Lines.Add('Error ' + Response);
    end;
  end;
end;

procedure TFormMain.Button21Click(Sender: TObject);
var
  List: TVkAudios;
  i: Integer;
var
  Params: TVkParamsAudioGet;
begin
  Params.OwnerId(415730216);
  Params.AlbumId(86751037);
  if VK1.Audio.Get(List, Params) then
  begin
    for i := Low(List.Items) to High(List.Items) do
    begin
      Memo1.Lines.Add(List.Items[i].Artist + '-' + List.Items[i].Title + ' ' + BoolToString(List.Items[i].ContentRestricted
        = 0,
        '', ' - ����������� �� ��������'));
    end;
    List.Free;
  end
  else
    Memo1.Lines.Add('Error get audios');
end;

procedure TFormMain.Button22Click(Sender: TObject);
begin
  if VK1.Board.CreateComment(145962568, 39960452, '��� �����������') then
    Memo1.Lines.Add('����������� ��������')
  else
    Memo1.Lines.Add('����������� �� ��������');
end;

procedure TFormMain.Button23Click(Sender: TObject);
var
  List: TVkPlaylists;
  i: Integer;
begin
  //VK1.CallMethod('audio.getPlaylist', [['album_id', '86751037']]);
  if VK1.Audio.GetPlaylists(List, 415730216) then
  begin
    for i := Low(List.Items) to High(List.Items) do
    begin
      Memo1.Lines.Add(List.Items[i].Title + '-' + List.Items[i].Description + ' Playlist Type: ' +
        List.Items[i].AlbumType);
    end;
    List.Free;
  end
  else
    Memo1.Lines.Add('Error GetPlaylists');
end;

procedure TFormMain.Button24Click(Sender: TObject);
var
  List: TVkAudios;
  i: Integer;
begin
  if VK1.Audio.GetRecommendations(List) then
  begin
    for i := Low(List.Items) to High(List.Items) do
    begin
      Memo1.Lines.Add(List.Items[i].Artist + '-' + List.Items[i].Title + ' ' + BoolToString(List.Items
        [i].ContentRestricted = 0,
        '', ' - ����������� �� ��������'));
    end;
    List.Free;
  end
  else
    Memo1.Lines.Add('Error GetRecommendations');
end;

procedure TFormMain.Button25Click(Sender: TObject);
var
  Users: TVkProfiles;
  //Users: TIds;
  TS: Cardinal;
  Param: TVkParamsGroupsGetMembers;
begin
  TThread.CreateAnonymousThread(
    procedure
    var
      i: Integer;
    begin
      TS := GetTickCount;
      Param.GroupId('fcarsenaltula');
      if VK1.Groups.GetMembers(Users, Param) then
      begin
        Memo1.Lines.Add('done ' + Users.Count.ToString);
        Memo1.Lines.Add('time ' + ((GetTickCount - TS) / 1000).ToString);
        for i := Low(Users.Items) to High(Users.Items) do
        begin
          Memo1.Lines.Add(Users.Items[i].FirstName + ' ' + Users.Items[i].LastName);
        end;
        Users.Free;
      end;
    end).Start;
end;

procedure TFormMain.Button26Click(Sender: TObject);
var
  Url: string;
  Response: TVkAudioUploadResponse;
  Audio: TVkAudio;
begin
  if VK1.Audio.GetUploadServer(Url) then
  begin
    if VK1.Uploader.UploadAudio(Url,
      'D:\�����������\������\���\������������ - �������� ��������� (2012)\06. ���� ���.mp3', Response) then
    begin
      if VK1.Audio.Save(Audio, Response) then
      begin
        Memo1.Lines.Add(Audio.Title);
        Audio.Free;
      end
      else
        Memo1.Lines.Add('Error VK1.Audio.Save');
      Response.Free;
    end
    else
      Memo1.Lines.Add('Error VK1.Uploader.UploadAudio');
  end
  else
    Memo1.Lines.Add('Error VK1.Audio.GetUploadServer');
end;

procedure TFormMain.Button27Click(Sender: TObject);
var
  List: TVkConversationItems;
  Params: TVkParamsConversationsGet;
  Item: TVkConversationItem;
begin
  if VK1.Messages.GetConversations(List, Params) then
  begin
    Memo1.Lines.Add('Count: ' + List.Count.ToString);
    for Item in List.Items do
    begin
      Memo1.Lines.Add('��� ������: ' + Item.Conversation.Peer.&Type.ToString);
      if Item.Conversation.IsChat then
        Memo1.Lines.Add('�������� ������: ' + Item.Conversation.ChatSettings.Title)
      else
        Memo1.Lines.Add('����������: ' + Item.Conversation.Peer.Id.ToString);
    end;

    List.Free;
  end;
end;

procedure TFormMain.Button28Click(Sender: TObject);
var
  Users: TVkProfiles;
begin
  if VK1.Friends.Get(Users) then
  begin
    for var User in Users.Items do
    begin
      Memo1.Lines.Add(User.GetFullName);
    end;
    Users.Free;
  end;
end;

procedure TFormMain.Button29Click(Sender: TObject);
var
  List: TVkAudios;
  i: Integer;
begin
  if VK1.Audio.GetPopular(List) then
  begin
    for i := Low(List.Items) to High(List.Items) do
    begin
      Memo1.Lines.Add(List.Items[i].Artist + '-' + List.Items[i].Title);
    end;
    List.Free;
  end;
end;

procedure TFormMain.Button2Click(Sender: TObject);
begin
  if VK1.Account.UnBan(-1) then
    Memo1.Lines.Add('Unbanned')
  else
    Memo1.Lines.Add('Error unbanned');
end;

procedure TFormMain.Button30Click(Sender: TObject);
var
  Catalog: TVkCatalog;
  Section: TVkSectionData;
  Chart: TVkSectionData;
  Block, i: Integer;
begin
  if VK1.Catalog.GetAudio(Catalog, True) then
  begin
    if VK1.Catalog.GetSection(Section, Catalog.Catalog.Sections[1].Id, False) then
    begin
      Memo1.Clear;
      Memo1.Lines.Add(Section.ToJsonString);
      Block := Section.Section.FindBlock('music_audios', 'music_chart_triple_stacked_slider');
      if Block <> -1 then
      begin
        if VK1.Catalog.GetSection(Chart, Section.Section.Blocks[Block].Id, False) then
        begin
          Memo1.Clear;
          for i := 0 to High(Chart.Audios) do
          begin
            Memo1.Lines.Add(Chart.Audios[i].AudioChartInfo.Position.ToString + ' - ' + Chart.Audios[i].Artist
              + ' - ' + Chart.Audios[i].Title);
          end;
          Chart.Free;
        end;
      end;
      Section.Free;
    end;
    Catalog.Free;
  end;
end;

procedure TFormMain.Button3Click(Sender: TObject);
var
  Offers: TVkActiveOffers;
  i: Integer;
begin
  if VK1.Account.GetActiveOffers(Offers, 0) then
  begin
    Memo1.Lines.Add('ActiveOffers ' + Offers.count.ToString);
    for i := 0 to Length(Offers.items) - 1 do
    begin
      Memo1.Lines.Add('--');
      Memo1.Lines.Add(Offers.items[i].Description);
    end;
    Offers.Free;
  end;
end;

procedure TFormMain.Button4Click(Sender: TObject);
var
  Perm: Integer;
begin
  if VK1.Account.GetAppPermissions(Perm, 58553419) then
    Memo1.Lines.Add(Perm.ToString);
end;

procedure TFormMain.Button5Click(Sender: TObject);
var
  Counters: TVkCounters;
begin
  if VK1.Account.GetCounters(Counters) then
  begin
    Memo1.Lines.Add('messages ' + Counters.Messages.ToString);
    Memo1.Lines.Add('notifications ' + Counters.Notifications.ToString);
    Counters.Free;
  end;
end;

procedure TFormMain.Button6Click(Sender: TObject);
var
  PushSettings: TVkPushSettings;
begin
  if VK1.Account.GetPushSettings(PushSettings, '1') then
  begin
    Memo1.Lines.Add('disabled ' + PushSettings.Disabled.ToString);
    Memo1.Lines.Add('conversations ' + PushSettings.Conversations.Count.ToString);
    PushSettings.Free;
  end;
end;

procedure TFormMain.Button7Click(Sender: TObject);
var
  Response: TVkAccountInfoRequest;
  Info: TVkParamsProfileInfo;
begin
  Info.Status('test123');
  if VK1.Account.SaveProfileInfo(Info, Response) then
  begin
    Memo1.Lines.Add(Response.Status);
    Response.Free;
  end;
end;

procedure TFormMain.Button8Click(Sender: TObject);
begin
  //audio.get
  //audio.search,q
  {
  "id": 456239099,
                "owner_id": 444273385,
  }
  //VK1.CallMethod('audio.getById', [['audios', '444273385_456239099,444273385_456239107']],
  VK1.CallMethod('audio.search', [['q', 'Noize']],
    procedure(Respone: TResponse)
    begin
      Memo1.Lines.Add(Respone.Response);
    end);
end;

procedure TFormMain.Button9Click(Sender: TObject);
begin
  if VK1.Account.SetOnline() then
    Memo1.Lines.Add('online')
  else
    Memo1.Lines.Add('Error online');
end;

procedure TFormMain.ButtonCreatePlaylistClick(Sender: TObject);
var
  Playlist: TVkAudioPlaylist;
begin
  if VK1.Audio.CreatePlaylist(Playlist, VK1.UserId, '����� �������� 2021') then
  begin
    Memo1.Lines.Add(Playlist.ToJsonString);
    Playlist.Free;
  end;
end;

procedure TFormMain.ButtonEditPlaylistClick(Sender: TObject);
var
  Params: TVkParamsAudioEditPlaylist;
begin
  //Params.OwnerId(VK1.UserId);
  Params.PlaylistId(11);
  Params.AudioIds(['58553419_456239116']);
  if VK1.Audio.EditPlaylist(Params) then
  begin
    Memo1.Lines.Add('ok');
  end
  else
    Memo1.Lines.Add('error');
end;

procedure TFormMain.Button31Click(Sender: TObject);
begin
  var Str1: TVkAudioInfoItems;
  if VK1.Audio.AddToPlaylist(Str1, VK1.UserId, 11, ['58553419_456239101']) then
  begin
    Memo1.Lines.Add(Str1.ToJsonString);
    Str1.Free;
  end
  else
    Memo1.Lines.Add('error');
end;

procedure TFormMain.Button32Click(Sender: TObject);
var
  Items: TVkPollBackgrounds;
begin
  if VK1.Polls.GetBackgrounds(Items) then
  begin
    for var Item in Items.Items do
    begin
      Memo1.Lines.Add(Item.Name);
    end;
    Items.Free;
  end;
end;

procedure TFormMain.Button33Click(Sender: TObject);
var
  Items: TVkPodcastSearch;
begin
  if VK1.Podcasts.Search(Items, '�����') then
  begin
    for var Podcast in Items.Podcasts do
      Memo1.Lines.Add(Podcast.OwnerTitle);
    for var Episode in Items.Episodes do
      Memo1.Lines.Add(Episode.Title);
    Items.Free;
  end;
end;

procedure TFormMain.Button34Click(Sender: TObject);
var
  Items: TVkSearchItems;
begin
  if VK1.Search.GetHints(Items, 'vk') then
  begin
    for var Item in Items.Items do
    begin
      Memo1.Lines.Add(Item.Description);
      Memo1.Lines.Add(Item.Section);
      Memo1.Lines.Add(Item.&Type);
    end;
    Items.Free;
  end;
end;

procedure TFormMain.Button35Click(Sender: TObject);
var
  Items: TVkRegions;
begin
  if VK1.Database.GetRegions(Items, 1, '�����') then
  begin
    for var Item in Items.Items do
    begin
      Memo1.Lines.Add(Item.Title);
    end;
    Items.Free;
  end;
end;

procedure TFormMain.Button36Click(Sender: TObject);
var
  Items: TVkSchoolClasses;
begin
  if VK1.Database.GetSchoolClasses(Items) then
  begin
    for var Item in Items.Items do
    begin
      Memo1.Lines.Add(Item.Text);
    end;
    Items.Free;
  end;
end;

procedure TFormMain.Button37Click(Sender: TObject);
var
  Value: string;
begin
  if VK1.Storage.Get(Value, 'name') then
  begin
    Memo1.Lines.Add(Value);
  end;
end;

procedure TFormMain.Button38Click(Sender: TObject);
var
  Value: Integer;
begin
  if VK1.Secure.GetAppBalance(Value) then
  begin
    Memo1.Lines.Add(Value.ToString);
  end;
end;

procedure TFormMain.ButtonGetCatalogClick(Sender: TObject);
var
  Catalog: TVkAudioCatalog;
begin
  if VK1.Audio.GetCatalog(Catalog) then
  begin
    for var i := 0 to Length(Catalog.Items) - 1 do
    begin
      Memo1.Lines.Add('');
      Memo1.Lines.Add(Catalog.Items[i].&Type);
      if Length(Catalog.Items[i].Audios) > 0 then
      begin
        Memo1.Lines.Add('');
        Memo1.Lines.Add('AUDIOS');
        for var j := 0 to Length(Catalog.Items[i].Audios) - 1 do
          Memo1.Lines.Add(Catalog.Items[i].Audios[j].Artist + ' - ' + Catalog.Items[i].Audios[j].Title);
      end;
      if Length(Catalog.Items[i].Playlists) > 0 then
      begin
        Memo1.Lines.Add('');
        Memo1.Lines.Add('PLAYLISTS');
        for var j := 0 to Length(Catalog.Items[i].Playlists) - 1 do
          Memo1.Lines.Add(Catalog.Items[i].Playlists[j].Title + ' - ' + Catalog.Items[i].Playlists[j].Description);
      end;
      if Length(Catalog.Items[i].Items) > 0 then
      begin
        Memo1.Lines.Add('');
        Memo1.Lines.Add('ITEMS');
        for var j := 0 to Length(Catalog.Items[i].Items) - 1 do
          Memo1.Lines.Add(Catalog.Items[i].Items[j].Title + ' - ' + Catalog.Items[i].Items[j].Subtitle);
      end;
    end;
    Catalog.Free;
  end;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  //��� ��� ������ AppID, AppKey, ServiceKey, ��� ������� ����� ������
  //{$INCLUDE app_cred.inc}  //�� ����������
  //VK1.SetProxy('177.22.24.246', 3128);
  VK1.Login;
end;
{
procedure TFormMain.VK1Auth(Sender: TObject; Url: string; var Token: string; var TokenExpiry: Int64; var
  ChangePasswordHash: string);
begin
  //Token := 'd45g6534f6gfsdfygvjcv6y90856j34vvvx98t3jfsd29i43j34fsdvxcvf59tjd35';
end;}

procedure TFormMain.VK1Auth(Sender: TObject; Url: string; var Token: string; var TokenExpiry: Int64; var
  ChangePasswordHash: string);
begin
  if FToken.IsEmpty then
  begin
    TFormOAuth2.Execute(Url,
      procedure(Form: TFormOAuth2)
      begin
        FToken := Form.Token;
        FTokenExpiry := Form.TokenExpiry;
        FChangePasswordHash := Form.ChangePasswordHash;
        if not FToken.IsEmpty then
          VK1.Login
        else
          ShowMessage('������: ' + Form.ErrorCode.ToString);
      end);
  end
  else
  begin
    Token := FToken;
    TokenExpiry := FTokenExpiry;
  end;
end;

procedure TFormMain.VK1Error(Sender: TObject; E: Exception; Code: Integer; Text: string);
begin
  ShowMessage('������: ' + Code.ToString + ' - ' + Text);
  MemoLog.Lines.Add('������: ' + Code.ToString + ' - ' + Text);
end;

procedure TFormMain.VK1ErrorLogin(Sender: TObject; E: Exception; Code: Integer; Text: string);
begin
  MemoLog.Lines.Add('������ �����������: ' + Code.ToString + ' - ' + Text);
  LabelLogin.Caption := 'login error';
end;

procedure TFormMain.VK1Log(Sender: TObject; const Value: string);
begin
  MemoLog.Lines.Add('Log: ' + Value);
end;

procedure TFormMain.VK1Login(Sender: TObject);
begin
  LabelLogin.Caption := 'login success';
  Memo1.Lines.Add(VK1.Token);
end;

procedure TFormMain.VkGroupEventsController1AudioNew(Sender: TObject; GroupId: Integer; Audio: TVkAudio; EventId: string);
begin
  Memo1.Lines.Add('������ ����������� � ������ ' + GroupId.ToString + ' "' + Audio.Url + '" �� ' +
    Audio.OwnerId.ToString);
end;

procedure TFormMain.VkGroupEventsController1BoardPostDelete(Sender: TObject; GroupId: Integer; Info: TVkCommentInfo;
  EventId: string);
begin
  Memo1.Lines.Add('����������� � ���������� ����� � ������ ' + GroupId.ToString + ' "' + Info.ObjectId.ToString
    + '" �� ' +
    Info.OwnerId.ToString + ', ���������� ' + Info.Id.ToString);
end;

procedure TFormMain.VkGroupEventsController1BoardPostEdit(Sender: TObject; GroupId: Integer; Comment: TVkComment; Info:
  TVkObjectInfo; EventId: string);
begin
  Memo1.Lines.Add('����������� � ���������� �������� � ������ ' + GroupId.ToString + ' "' + Comment.Text + '" �� ' +
    Comment.FromId.ToString + ', ���������� ' + Info.Id.ToString);
end;

procedure TFormMain.VkGroupEventsController1BoardPostNew(Sender: TObject; GroupId: Integer; Comment: TVkComment; Info:
  TVkObjectInfo; EventId: string);
begin
  Memo1.Lines.Add('����� ����������� � ���������� � ������ ' + GroupId.ToString + ' "' + Comment.Text + '" �� ' +
    Comment.FromId.ToString + ', ���������� ' + Info.Id.ToString);
end;

procedure TFormMain.VkGroupEventsController1BoardPostRestore(Sender: TObject; GroupId: Integer; Comment: TVkComment;
  Info: TVkObjectInfo; EventId: string);
begin
  Memo1.Lines.Add('����������� � ���������� ������������ � ������ ' + GroupId.ToString + ' "' +
    Comment.Text + '" ���������� ' +
    Info.Id.ToString);
end;

procedure TFormMain.VkGroupEventsController1GroupAppPayload(Sender: TObject; GroupId: Integer; Info: TVkAppPayload;
  EventId: string);
begin
  Memo1.Lines.Add('������� � VK Mini Apps � ������ ' + GroupId.ToString + ' ��������� ' + Info.UserId.ToString
    + ', Payload: ' + Info.Payload);
end;

procedure TFormMain.VkGroupEventsController1GroupChangePhoto(Sender: TObject; GroupId: Integer; Changes:
  TVkGroupChangePhoto; EventId: string);
begin
  Memo1.Lines.Add('��������� ���� � ������ ' + GroupId.ToString + ' ��������� ' + Changes.UserId.ToString
    + ' => ' + Changes.Photo.Id.ToString);
end;

procedure TFormMain.VkGroupEventsController1GroupChangeSettings(Sender: TObject; GroupId: Integer; Changes:
  TVkGroupSettingsChange; EventId: string);
begin
  Memo1.Lines.Add('��������� ���������� � ������ ' + GroupId.ToString + ' ��������� ' + Changes.UserId.ToString);
end;

procedure TFormMain.VkGroupEventsController1GroupJoin(Sender: TObject; GroupId, UserId: Integer; JoinType:
  TVkGroupJoinType; EventId: string);
begin
  Memo1.Lines.Add('� ������ ������������� ' + UserId.ToString + ' "' + JoinType.ToString + '"');
end;

procedure TFormMain.VkGroupEventsController1GroupLeave(Sender: TObject; GroupId, UserId: Integer; IsSelf: Boolean;
  EventId: string);
begin
  Memo1.Lines.Add('������ ������� ' + UserId.ToString + ' "' + BoolToString(IsSelf, '��� �������', '��������') + '"');
end;

procedure TFormMain.VkGroupEventsController1GroupOfficersEdit(Sender: TObject; GroupId: Integer; Info:
  TVkGroupOfficersEdit; EventId: string);
begin
  Memo1.Lines.Add('��������� � ����������� � ������ ' + GroupId.ToString + ' ' + Info.UserId.ToString + ' => ' +
    Info.LevelNew.ToString);
end;

procedure TFormMain.VkGroupEventsController1GroupPayTransaction(Sender: TObject; GroupId: Integer; Info:
  TVkPayTransaction; EventId: string);
begin
  Memo1.Lines.Add('����� ����� ����� VK Pay � ������ ' + GroupId.ToString + ' �� ' + Info.FromId.ToString +
    ', ����� ' + Info.Amount);
end;

procedure TFormMain.VkGroupEventsController1GroupPollVoteNew(Sender: TObject; GroupId: Integer; Info:
  TVkGroupPollVoteNew; EventId: string);
begin
  Memo1.Lines.Add('����� ����� � ������ ' + GroupId.ToString + ', � ������ ' + Info.PollId.ToString + ', �� ' +
    Info.UserId.ToString + ', ����� ' + Info.OptionId.ToString);
end;

procedure TFormMain.VkGroupEventsController1MarketCommentDelete(Sender: TObject; GroupId: Integer; Info: TVkCommentInfo;
  EventId: string);
begin
  Memo1.Lines.Add('����������� � ������ ����� � ������ ' + GroupId.ToString + ' "' + Info.ObjectId.ToString + '" �� ' +
    Info.OwnerId.ToString + ', ����� ' + Info.Id.ToString);
end;

procedure TFormMain.VkGroupEventsController1MarketCommentEdit(Sender: TObject; GroupId: Integer; Comment: TVkComment;
  Info: TVkObjectInfo; EventId: string);
begin
  Memo1.Lines.Add('����������� � ������ �������� � ������ ' + GroupId.ToString + ' "' + Comment.Text + '" �� ' +
    Comment.FromId.ToString + ', ����� ' + Info.Id.ToString);
end;

procedure TFormMain.VkGroupEventsController1MarketCommentNew(Sender: TObject; GroupId: Integer; Comment: TVkComment;
  Info: TVkObjectInfo; EventId: string);
begin
  Memo1.Lines.Add('����� ����������� � ������ � ������ ' + GroupId.ToString + ' "' + Comment.Text + '" �� ' +
    Comment.FromId.ToString + ', ����� ' + Info.Id.ToString);
end;

procedure TFormMain.VkGroupEventsController1MarketCommentRestore(Sender: TObject; GroupId: Integer; Comment: TVkComment;
  Info: TVkObjectInfo; EventId: string);
begin
  Memo1.Lines.Add('����������� � ������ ������������ � ������ ' + GroupId.ToString + ' "' + Comment.Text + '" ����� ' +
    Info.Id.ToString);
end;

procedure TFormMain.VkGroupEventsController1MessageAllow(Sender: TObject; GroupId, UserId: Integer; Key, EventId: string);
begin
  Memo1.Lines.Add('������������ ���������� �� ��������� � ������ ' + GroupId.ToString +
    ': ' + UserId.ToString);
end;

procedure TFormMain.VkGroupEventsController1MessageDeny(Sender: TObject; GroupId, UserId: Integer; Key, EventId: string);
begin
  Memo1.Lines.Add('������������ ��������� �� �������� �� ��������� � ������ ' + GroupId.ToString +
    ': ' + UserId.ToString);
end;

procedure TFormMain.VkGroupEventsController1MessageEdit(Sender: TObject; GroupId: Integer; Message: TVkMessage; EventId: string);
begin
  Memo1.Lines.Add('�������������� ��������� � ������ ' + GroupId.ToString + ': ' + Message.Text);
end;

procedure TFormMain.VkGroupEventsController1MessageNew(Sender: TObject; GroupId: Integer; Message: TVkMessage;
  ClientInfo: TVkClientInfo; EventId: string);
begin
  Memo1.Lines.Add('����� ��������� � ������ ' + GroupId.ToString + ': ' + Message.Text);
  if Message.Text = '������' then
    VK1.Messages.
      New.
      PeerId(Message.PeerId).
      Message('��� ���� � ��� ��������� ������� ������, ���').
      Send.
      Free;
end;

procedure TFormMain.VkGroupEventsController1MessageReply(Sender: TObject; GroupId: Integer; Message: TVkMessage; EventId: string);
begin
  Memo1.Lines.Add('��������� ��������� � ������ ' + GroupId.ToString + ': ' + Message.Text);
end;

procedure TFormMain.VkGroupEventsController1MessageTypingState(Sender: TObject; GroupId, UserId: Integer; State, EventId: string);
begin
  Memo1.Lines.Add('�������� ��������� � ������ ' + GroupId.ToString + ': ' + UserId.ToString + ' ' + State);
end;

procedure TFormMain.VkGroupEventsController1PhotoCommentDelete(Sender: TObject; GroupId: Integer; Info: TVkCommentInfo;
  EventId: string);
begin
  Memo1.Lines.Add('����������� � ���� ����� � ������ ' + GroupId.ToString + ' "' + Info.ObjectId.ToString + '" �� ' +
    Info.OwnerId.ToString + ', ���� ' + Info.Id.ToString);
end;

procedure TFormMain.VkGroupEventsController1PhotoCommentEdit(Sender: TObject; GroupId: Integer; Comment: TVkComment;
  Info: TVkObjectInfo; EventId: string);
begin
  Memo1.Lines.Add('����������� � ���� �������� � ������ ' + GroupId.ToString + ' "' + Comment.Text + '" �� ' +
    Comment.FromId.ToString + ', ���� ' + Info.Id.ToString);
end;

procedure TFormMain.VkGroupEventsController1PhotoCommentNew(Sender: TObject; GroupId: Integer; Comment: TVkComment; Info:
  TVkObjectInfo; EventId: string);
begin
  Memo1.Lines.Add('����� ����������� � ���� � ������ ' + GroupId.ToString + ' "' + Comment.Text + '" �� ' +
    Comment.FromId.ToString + ', ���� ' + Info.Id.ToString);
end;

procedure TFormMain.VkGroupEventsController1PhotoCommentRestore(Sender: TObject; GroupId: Integer; Comment: TVkComment;
  Info: TVkObjectInfo; EventId: string);
begin
  Memo1.Lines.Add('����������� � ���� ������������ � ������ ' + GroupId.ToString + ' "' + Comment.Text + '" ���� ' +
    Info.Id.ToString);
end;

procedure TFormMain.VkGroupEventsController1PhotoNew(Sender: TObject; GroupId: Integer; Photo: TVkPhoto; EventId: string);
begin
  Memo1.Lines.Add('����� ���� � ������ ' + GroupId.ToString + ' "' + Photo.Text + '" �� ' +
    Photo.OwnerId.ToString);
end;

procedure TFormMain.VkGroupEventsController1UserBlock(Sender: TObject; GroupId: Integer; Info: TVkGroupUserBlock;
  EventId: string);
begin
  Memo1.Lines.Add('������������ ������������ ' + Info.UserId.ToString + ' �������: ' + Info.Reason.ToString);
end;

procedure TFormMain.VkGroupEventsController1UserUnBlock(Sender: TObject; GroupId: Integer; Info: TVkGroupUserUnBlock;
  EventId: string);
begin
  Memo1.Lines.Add('������������� ������������ ' + Info.UserId.ToString + ' �������: ' + BoolToString
    (Info.ByEndDate, '��������� ������� ����������', '�������'));
end;

procedure TFormMain.VkGroupEventsController1VideoCommentDelete(Sender: TObject; GroupId: Integer; Info: TVkCommentInfo;
  EventId: string);
begin
  Memo1.Lines.Add('����������� � ����� ����� � ������ ' + GroupId.ToString + ' "' + Info.ObjectId.ToString + '" �� ' +
    Info.OwnerId.ToString + ', ����� ' + Info.Id.ToString);
end;

procedure TFormMain.VkGroupEventsController1VideoCommentEdit(Sender: TObject; GroupId: Integer; Comment: TVkComment;
  Info: TVkObjectInfo; EventId: string);
begin
  Memo1.Lines.Add('����������� � ����� �������� � ������ ' + GroupId.ToString + ' "' + Comment.Text + '" �� ' +
    Comment.FromId.ToString + ', ����� ' + Info.Id.ToString);
end;

procedure TFormMain.VkGroupEventsController1VideoCommentNew(Sender: TObject; GroupId: Integer; Comment: TVkComment; Info:
  TVkObjectInfo; EventId: string);
begin
  Memo1.Lines.Add('����� ����������� � ����� � ������ ' + GroupId.ToString + ' "' + Comment.Text + '" �� ' +
    Comment.FromId.ToString + ', ����� ' + Info.Id.ToString);
end;

procedure TFormMain.VkGroupEventsController1VideoCommentRestore(Sender: TObject; GroupId: Integer; Comment: TVkComment;
  Info: TVkObjectInfo; EventId: string);
begin
  Memo1.Lines.Add('����������� � ����� ������������ � ������ ' + GroupId.ToString + ' "' + Comment.Text + '" ����� ' +
    Info.Id.ToString);
end;

procedure TFormMain.VkGroupEventsController1VideoNew(Sender: TObject; GroupId: Integer; Video: TVkVideo; EventId: string);
begin
  Memo1.Lines.Add('����� ����� � ������ ' + GroupId.ToString + ' "' + Video.Title + '" �� ' +
    Video.OwnerId.ToString);
end;

procedure TFormMain.VkGroupEventsController1WallPostNew(Sender: TObject; GroupId: Integer; Post: TVkPost; EventId: string);
begin
  Memo1.Lines.Add('����� ���� � ������ ' + GroupId.ToString + ': ' + Post.Text);
end;

procedure TFormMain.VkGroupEventsController1WallReplyDelete(Sender: TObject; GroupId: Integer; Info: TVkCommentInfo;
  EventId: string);
begin
  Memo1.Lines.Add('����������� ����� � ������ ' + GroupId.ToString + ' "' + Info.Id.ToString + '" �� ' +
    Info.DeleterId.ToString);
end;

procedure TFormMain.VkGroupEventsController1WallReplyEdit(Sender: TObject; GroupId: Integer; Comment: TVkComment; Info:
  TVkObjectInfo; EventId: string);
begin
  Memo1.Lines.Add('����������� �������� � ������ ' + GroupId.ToString + ' "' + Comment.Text + '" �� ' +
    Comment.FromId.ToString);
end;

procedure TFormMain.VkGroupEventsController1WallReplyNew(Sender: TObject; GroupId: Integer; Comment: TVkComment; Info:
  TVkObjectInfo; EventId: string);
begin
  Memo1.Lines.Add('����� ����������� � ������ ' + GroupId.ToString + ' "' + Comment.Text + '" �� ' +
    Comment.FromId.ToString);
end;

procedure TFormMain.VkGroupEventsController1WallReplyRestore(Sender: TObject; GroupId: Integer; Comment: TVkComment;
  Info: TVkObjectInfo; EventId: string);
begin
  Memo1.Lines.Add('����������� � ����� ������������ � ������ ' + GroupId.ToString + ' "' + Comment.Text + '" �� ' +
    Comment.FromId.ToString);
end;

procedure TFormMain.VkGroupEventsController1WallRepost(Sender: TObject; GroupId: Integer; Post: TVkPost; EventId: string);
begin
  Memo1.Lines.Add('������ ������ � ������ ' + GroupId.ToString + ' "' + Post.Text + '" �� ' +
    Post.FromId.ToString);
end;

procedure TFormMain.VkUserEvents1ChangeDialogFlags(Sender: TObject; DialogChangeData: TDialogChangeData);
begin
  Memo1.Lines.Add('��������� ������ ������� ' +
    DialogChangeData.PeerId.ToString + ': ' +
    DialogChangeData.ChangeType.ToString + ' ' +
    DialogChangeData.Flags.ToString);
end;

procedure TFormMain.VkUserEvents1ChangeMessageFlags(Sender: TObject; MessageChangeData: TMessageChangeData);
begin
  Memo1.Lines.Add('��������� ������ ��������� ' +
    MessageChangeData.MessageId.ToString + ': ' +
    MessageChangeData.ChangeType.ToString + ' ' +
    MessageChangeData.Flags.ToString);
end;

procedure TFormMain.VkUserEvents1ChatChanged(Sender: TObject; const ChatId: Integer; IsSelf: Boolean);
begin
  Memo1.Lines.Add('��������� � ������ ' + ChatId.ToString + ': ' + IsSelf.ToString);
end;

procedure TFormMain.VkUserEvents1ChatChangeInfo(Sender: TObject; const PeerId: Integer; TypeId: TChatChangeInfoType;
  Info: Integer);
begin
  Memo1.Lines.Add('��������� � ������ ' + PeerId.ToString + ': ' + TypeId.ToString + ' -> ' + Info.ToString);
end;

procedure TFormMain.VkUserEvents1CountChange(Sender: TObject; Count: Integer);
begin
  Memo1.Lines.Add('���-�� ����������� ' + Count.ToString);
end;

procedure TFormMain.VkUserEvents1DeleteMessages(Sender: TObject; PeerId, LocalId: Integer);
begin
  Memo1.Lines.Add('��������� � ���� ' + PeerId.ToString + ' ������� �� ' + LocalId.ToString);
end;

procedure TFormMain.VkUserEvents1EditMessage(Sender: TObject; MessageData: TMessageData);
begin
  Memo1.Lines.Add('�������������� ��������� � ���� ' + MessageData.PeerId.ToString + ': ' + MessageData.Text);
end;

procedure TFormMain.VkUserEvents1NewMessage(Sender: TObject; MessageData: TMessageData);
var
  Msg: TVkMessages;
begin
  Memo1.Lines.Add('����� ��������� � ���� ' + MessageData.PeerId.ToString + ' ' + MessageData.MessageId.ToString
    + ' ' + MessageData.Flags.ToString
    + ': ' + MessageData.Text);
  {if VK1.Messages.GetById(MessageData.MessageId, Msg) then
  begin
    if Length(Msg.attachments) > 0 then
    begin
      if Msg.attachments[0].&type = 'audio_message' then
        Memo1.Lines.Add(Msg.text);
    end;
    Msg.Free;
  end;  }
  if mfOutbox in MessageData.Flags then
  begin
    //��������� �� ���
  end
  else
  begin
    //��������� �� ����-��
    if Pos('���', AnsiLowerCase(MessageData.Text)) <> 0 then
    begin
      VK1.Messages.
        New.
        PeerId(MessageData.PeerId).
        Message('�� ��, ��� ����������').
        Attachment(Attachment.Album(58553419, 234519653)).
        Send.
        Free;
    end;

    if VK1.Messages.GetById(Msg, MessageData.MessageId) then
    begin
      if Length(Msg.Items[0].Attachments) > 0 then
      begin
        if Msg.Items[0].Attachments[0].&Type = atAudioMessage then
          VK1.Messages.
            New.
            PeerId(MessageData.PeerId).
            Message('����� ���� ���� ��������� ��������� �����������').
            Send.
            Free;
      end;
      Msg.Free;
    end;
  end;
end;

procedure TFormMain.VkUserEvents1NotifyChange(Sender: TObject; PeerId: Integer; Sound: Boolean; DisableUntil: Integer);
begin
  Memo1.Lines.Add('���������� ��������� ���������� ' + PeerId.ToString + ' ���� -> ' + Sound.ToString
    + ' �� ���� ' + DisableUntil.ToString);
end;

procedure TFormMain.VkUserEvents1ReadMessages(Sender: TObject; Incoming: Boolean; PeerId, LocalId: Integer);
begin
  case Incoming of
    True:
      Memo1.Lines.Add('��� �������� ��������� � ���� - ' + PeerId.ToString + ' �� ' + LocalId.ToString + ' ��������');
    False:
      Memo1.Lines.Add('��� ��������� ��������� � ���� - ' + PeerId.ToString + ' �� ' + LocalId.ToString + ' ��������');
  end;
end;

procedure TFormMain.VkUserEvents1RecoverMessages(Sender: TObject; PeerId, LocalId: Integer);
begin
  Memo1.Lines.Add('��������� � ���� ' + PeerId.ToString + ' ������������� �� ' + LocalId.ToString);
end;

procedure TFormMain.VkUserEvents1UserCall(Sender: TObject; UserId, CallId: Integer);
begin
  Memo1.Lines.Add('������������ ' + UserId.ToString + ' �������� ������ � ��������������� ' + CallId.ToString);
end;

procedure TFormMain.VkUserEvents1UserOffline(Sender: TObject; UserId: Integer; InactiveUser: Boolean; TimeStamp: TDateTime);
begin
  Memo1.Lines.Add('������� - ' + UserId.ToString + ' ' + VkUserActive[InactiveUser]);
end;

procedure TFormMain.VkUserEvents1UserOnline(Sender: TObject; UserId: Integer; VkPlatform: TVkPlatform; TimeStamp: TDateTime);
begin
  Memo1.Lines.Add('������ - ' + UserId.ToString + ' ' + VkPlatforms[VkPlatform]);
end;

procedure TFormMain.VkUserEvents1UsersRecording(Sender: TObject; Data: TChatRecordingData);
begin
  Memo1.Lines.Add('��������� ������������� ���������� �������������� ' + Data.UserIds.ToString +
    ' � ���� ' + Data.PeerId.ToString);
end;

procedure TFormMain.VkUserEvents1UsersTyping(Sender: TObject; Data: TChatTypingData);
begin
  Memo1.Lines.Add('��������� ������������� �������� ����� ' + Data.UserIds.ToString + ' � ���� ' +
    Data.PeerId.ToString);
end;

procedure TFormMain.VkUserEvents1UserTyping(Sender: TObject; UserId, ChatId: Integer);
begin
  Memo1.Lines.Add('������������ �������� ����� ' + UserId.ToString + ' � ���� ' + ChatId.ToString);
end;

end.

