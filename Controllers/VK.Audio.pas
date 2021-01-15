unit VK.Audio;

interface

uses
  System.SysUtils, System.Generics.Collections, REST.Client, VK.Controller,
  VK.Types, VK.Entity.Audio, System.JSON, REST.Json, VK.CommonUtils,
  VK.Entity.Playlist, VK.Entity.Audio.Upload, VK.Entity.Audio.Catalog;

type
  TVkParamsAudioGet = record
    List: TParams;
    function OwnerId(Value: Integer): Integer;
    function AlbumId(Value: Integer): Integer;
    function PlaylistId(Value: Integer): Integer;
    function AudioIds(Value: TIds): Integer;
    function Offset(Value: Integer): Integer;
    function Count(Value: Integer): Integer;
    function AccessKey(Value: string): Integer;
  end;

  TVkParamsAudioGetRecomendations = record
    List: TParams;
    function TargetAudio(Value: Integer): Integer;
    function UserId(Value: Integer): Integer;
    function Offset(Value: Integer): Integer;
    function Count(Value: Integer): Integer;
    function Shuffle(Value: Boolean): Integer;
  end;

  TVkParamsPopAudio = record
    List: TParams;
    function Offset(Value: Integer): Integer;
    function Count(Value: Integer): Integer;
    function OnlyEng(Value: Boolean): Integer;
    function GenreId(Value: TAudioGenre): Integer;
  end;

  TVkParamsPlaylist = record
    List: TParams;
    function OwnerId(Value: Integer): Integer;
    function Offset(Value: Integer): Integer;
    function Count(Value: Integer): Integer;
  end;

  TVkAudioSort = (asDateAdd, asDuration, asPopular);

  TVkParamsAudioSearch = record
    List: TParams;
    function Query(Value: string): Integer;
    function AutoComplete(Value: Boolean): Integer;
    function PerformerOnly(Value: Boolean): Integer;
    function Lyrics(Value: string): Integer;
    function Sort(Value: TVkAudioSort): Integer;
    function SearchOwn(Value: Boolean): Integer;
    function Offset(Value: Integer): Integer;
    function Count(Value: Integer): Integer;
  end;

  TVkParamsAudioEdit = record
    List: TParams;
    function AudioId(Value: Integer): Integer;
    function OwnerId(Value: Integer): Integer;
    function Artist(Value: string): Integer;
    function Title(Value: string): Integer;
    function Text(Value: string): Integer;
    function GenreId(Value: TAudioGenre): Integer;
    function NoSearch(Value: Boolean): Integer;
  end;

  TVkParamsAudioEditPlaylist = record
    List: TParams;
    function PlaylistId(Value: Integer): Integer;
    function OwnerId(Value: Integer): Integer;
    function Description(Value: string): Integer;
    function Title(Value: string): Integer;
    function AudioIds(Value: TArrayOfString): Integer;
  end;

  TVkParamsAudioReorder = record
    List: TParams;
    function OwnerId(Value: Integer): Integer;
    function AudioId(Value: Integer): Integer;
    function Before(Value: Integer): Integer;
    function After(Value: Integer): Integer;
  end;

  TAudioController = class(TVkController)
  public
    /// <summary>
    /// ���������� ���������� �� ������������
    /// </summary>
    function Get(var Audios: TVkAudios; OwnerId: Integer = 0): Boolean; overload;
    /// <summary>
    /// ���������� ���������� �� ������������
    /// </summary>
    function Get(var Audios: TVkAudios; Params: TParams): Boolean; overload;
    /// <summary>
    /// ���������� ���������� �� ������������
    /// </summary>
    function Get(var Audios: TVkAudios; Params: TVkParamsAudioGet): Boolean; overload;
    /// <summary>
    /// ���������� ���������� �� ������������
    /// </summary>
    function GetRecommendations(var Audios: TVkAudios; Params: TVkParamsAudioGetRecomendations): Boolean; overload;
    /// <summary>
    /// ���������� ���������� �� ������������
    /// </summary>
    function GetRecommendations(var Audios: TVkAudios; UserId: Integer = 0): Boolean; overload;
    /// <summary>
    /// Returns a list of audio files from the "Popular".
    /// </summary>
    function GetPopular(var Audios: TVkAudios; Params: TVkParamsPopAudio): Boolean; overload;
    /// <summary>
    /// Returns a list of audio files from the "Popular".
    /// </summary>
    function GetPopular(var Audios: TVkAudios; OnlyEng: Boolean = False; GenreId: TAudioGenre = agNone; Count: Integer = 0; Offset: Integer = 0): Boolean; overload;
    /// <summary>
    /// ���������� ���������� �� ������������
    /// </summary>
    function GetPlaylists(var Items: TVkPlaylists; Params: TVkParamsPlaylist): Boolean; overload;
    /// <summary>
    /// ���������� ���������� �� ����������
    /// </summary>
    function GetPlaylists(var Items: TVkPlaylists; OwnerID: Integer): Boolean; overload;
    /// <summary>
    /// ���������� ���������� �� ������������
    /// </summary>
    function GetById(var Audios: TVkAudios; List: TVkAudioIndexes): Boolean; overload;
    /// <summary>
    /// ���������� ���������� �� �����������
    /// </summary>
    function GetById(var Audio: TVkAudio; OwnerId, AudioId: Integer; AccessKey: string = ''): Boolean; overload;
    /// <summary>
    /// ���������� ����� ������� ��� �������� ������������
    /// </summary>
    function GetUploadServer(var UploadUrl: string): Boolean;
    /// <summary>
    /// ���������� ������ ������������ � ������������ (��������� �����)
    /// </summary>
    function Search(var Audios: TVkAudios; Query: string): Boolean; overload;
    /// <summary>
    /// ���������� ������ ������������ � ������������ � �������� ��������� ������
    /// </summary>
    function Search(var Audios: TVkAudios; Query: string; AutoComplete, PerformerOnly: Boolean): Boolean; overload;
    /// <summary>
    /// ���������� ������ ������������ � ������������ � �������� ��������� ������
    /// </summary>
    function Search(var Audios: TVkAudios; Params: TVkParamsAudioSearch): Boolean; overload;
    /// <summary>
    /// ��������� ����������� ����� �������� ��������.
    /// </summary>
    function Save(var Audio: TVkAudio; AudioSaveData: TVkAudioUploadResponse): Boolean;
    /// <summary>
    /// �������� ����������� �� �������� ������������ ��� ������.
    /// </summary>
    function Add(var Id: Integer; AudioId, OwnerId: Integer; GroupId: Integer = 0; AlbumId: Integer = -1; AccessKey: string = ''): Boolean;
    /// <summary>
    /// ������� ����������� �� �������� ������������ ��� ����������.
    /// </summary>
    function Delete(AudioId, OwnerId: Integer): Boolean;
    /// <summary>
    /// ����������� ������ ����������� �� �������� ������������ ��� ����������.
    /// </summary>
    function Edit(Params: TVkParamsAudioEdit): Boolean;
    /// <summary>
    /// ������� ��������
    /// </summary>
    function CreatePlaylist(var Item: TVkAudioPlaylist; const OwnerId: Integer; const Title: string; Description: string = ''; AudioIds: TArrayOfString = []): Boolean;
    /// <summary>
    /// ������� ��������
    /// </summary>
    function DeletePlaylist(const PlaylistId: Integer; OwnerId: Integer = 0): Boolean;
    /// <summary>
    /// �������� ��������
    /// </summary>
    function EditPlaylist(Params: TVkParamsAudioEditPlaylist): Boolean;
    /// <summary>
    /// ���������� ���������� �� ���������
    /// </summary>
    function GetPlaylistById(var Item: TVkAudioPlaylist; const PlaylistId: Integer; OwnerId: Integer = 0): Boolean;
    /// <summary>
    /// ��������������� �����������
    /// </summary>
    function Restore(const AudioId: Integer; OwnerId: Integer = 0): Boolean;
    /// <summary>
    /// �������� ������� ������������
    /// </summary>
    function GetCatalog(var Items: TVkAudioCatalog; Params: TParams = []): Boolean;
    /// <summary>
    /// ��������� �������� ������� �����.
    /// </summary>
    function Reorder(Params: TVkParamsAudioReorder): Boolean;
    /// <summary>
    /// ������� ��������
    /// </summary>
    function AddToPlaylist(var Items: TVkAudioInfoItems; const OwnerId, PlaylistId: Integer; AudioIds: TArrayOfString): Boolean;
    /// <summary>
    ///
    /// </summary>
    function Upload(const UploadUrl, FileName: string; var Response: TVkAudioUploadResponse): Boolean; overload;
    /// <summary>
    ///
    /// </summary>
    function Upload(var Audio: TVkAudio; const FileName: string): Boolean; overload;
  end;

implementation

uses
  VK.API, System.Classes, System.Net.HttpClient, System.Net.Mime;

{
  var parameters = new VkParameters
  {
    { "audio", audio ,
    { "target_ids", targetIds
  ;
  return _vk.Call<ReadOnlyCollection<long>>("audio.setBroadcast", parameters);
}
{
var parameters = new VkParameters
			{
				{ "filter", filter ,
				{ "active", active
			;
			return _vk.Call<ReadOnlyCollection<object>>("audio.getBroadcastList", parameters);
}
{
var parameters = new VkParameters
			{
				{ "lyrics_id", lyricsId
			;
			return _vk.Call<Lyrics>("audio.getLyrics", parameters);
}
{
  var parameters = new VkParameters
  {
    { "owner_id", ownerId ,
    { "playlist_id", playlistId ,
    { "audio_ids", audioIds
  ;
  return _vk.Call("audio.addToPlaylist", parameters).ToReadOnlyCollectionOf<long>(x => x["audio_id"]);
}

{ TAudioController }

function TAudioController.Upload(const UploadUrl, FileName: string; var Response: TVkAudioUploadResponse): Boolean;
var
  HTTP: THTTPClient;
  Data: TMultipartFormData;
  ResStream: TStringStream;
begin
  Result := False;
  Data := TMultipartFormData.Create;
  HTTP := THTTPClient.Create;
  ResStream := TStringStream.Create;
  try
    Data.AddFile('file', FileName);
    if HTTP.Post(UploadUrl, Data, ResStream).StatusCode = 200 then
    begin
      Response := TVkAudioUploadResponse.FromJsonString<TVkAudioUploadResponse>(ResStream.DataString);
      Result := True;
    end;
  finally
    ResStream.Free;
    Data.Free;
    HTTP.Free;
  end;
end;

function TAudioController.Upload(var Audio: TVkAudio; const FileName: string): Boolean;
var
  UploadServer: string;
  Response: TVkAudioUploadResponse;
begin
  Result := False;
  if GetUploadServer(UploadServer) then
  begin
    if Upload(UploadServer, FileName, Response) then
    begin
      try
        Result := Save(Audio, Response);
      finally
        Response.Free;
      end;
    end;
  end;
end;

function TAudioController.Save(var Audio: TVkAudio; AudioSaveData: TVkAudioUploadResponse): Boolean;
var
  Params: TParams;
begin
  Params.Add('audio', AudioSaveData.Audio);
  Params.Add('server', AudioSaveData.Server);
  Params.Add('hash', AudioSaveData.Hash);
  if not AudioSaveData.Artist.IsEmpty then
    Params.Add('artist', AudioSaveData.Artist);
  if not AudioSaveData.Title.IsEmpty then
    Params.Add('title', AudioSaveData.Title);
  Result := Handler.Execute('audio.save', Params).GetObject<TVkAudio>(Audio);
end;

function TAudioController.Search(var Audios: TVkAudios; Params: TVkParamsAudioSearch): Boolean;
begin
  Result := Handler.Execute('audio.search', Params.List).GetObject<TVkAudios>(Audios);
end;

function TAudioController.Search(var Audios: TVkAudios; Query: string): Boolean;
var
  Params: TVkParamsAudioSearch;
begin
  Params.Query(Query);
  Params.AutoComplete(True);
  Params.PerformerOnly(False);
  Result := Search(Audios, Params);
end;

function TAudioController.Search(var Audios: TVkAudios; Query: string; AutoComplete, PerformerOnly: Boolean): Boolean;
var
  Params: TVkParamsAudioSearch;
begin
  Params.AutoComplete(AutoComplete);
  Params.PerformerOnly(PerformerOnly);
  Params.Query(Query);
  Result := Search(Audios, Params);
end;

function TAudioController.Get(var Audios: TVkAudios; OwnerId: Integer): Boolean;
var
  Params: TVkParamsAudioGet;
begin
  if OwnerId <> 0 then
    Params.OwnerId(OwnerId);
  Result := Get(Audios, Params);
end;

function TAudioController.Add(var Id: Integer; AudioId, OwnerId, GroupId, AlbumId: Integer; AccessKey: string): Boolean;
var
  Params: TParams;
begin
  Params.Add('audio_id', AudioId);
  Params.Add('owner_id', OwnerId);
  if not AccessKey.IsEmpty then
    Params.Add('access_key', AccessKey);
  if GroupId <> 0 then
    Params.Add('group_id', GroupId);
  if AlbumId > -1 then
    Params.Add('album_id', AlbumId);
  Result := Handler.Execute('audio.add', Params).ResponseAsInt(Id);
end;

function TAudioController.AddToPlaylist(var Items: TVkAudioInfoItems; const OwnerId, PlaylistId: Integer; AudioIds: TArrayOfString): Boolean;
begin
  Result := Handler.Execute('audio.addToPlaylist', [
    ['playlist_id', PlaylistId.ToString],
    ['owner_id', OwnerId.ToString],
    ['audio_ids', AudioIds.ToString]]).
    GetObjects<TVkAudioInfoItems>(Items);
end;

function TAudioController.CreatePlaylist(var Item: TVkAudioPlaylist; const OwnerId: Integer; const Title: string; Description: string; AudioIds: TArrayOfString): Boolean;
var
  Params: TParams;
begin
  if not AudioIds.IsEmpty then
    Params.Add('audio_ids', AudioIds);
  Params.Add('owner_id', OwnerId);
  Params.Add('title', Title);
  Params.Add('description', Description);
  Result := Handler.Execute('audio.createPlaylist', Params).GetObject<TVkAudioPlaylist>(Item);
end;

function TAudioController.Delete(AudioId, OwnerId: Integer): Boolean;
begin
  with Handler.Execute('audio.delete', [['audio_id', AudioId.ToString], ['owner_id', OwnerId.ToString]]) do
  begin
    Result := Success and ResponseIsTrue;
  end;
end;

function TAudioController.DeletePlaylist(const PlaylistId: Integer; OwnerId: Integer): Boolean;
var
  Params: TParams;
begin
  if OwnerId <> 0 then
    Params.Add('owner_id', OwnerId);
  Params.Add('playlist_id', PlaylistId);
  with Handler.Execute('audio.deletePlaylist', Params) do
    Result := Success and ResponseIsTrue;
end;

function TAudioController.Edit(Params: TVkParamsAudioEdit): Boolean;
begin
  with Handler.Execute('audio.edit', Params.List) do
  begin
    Result := Success and (not ResponseIsFalse);
  end;
end;

function TAudioController.EditPlaylist(Params: TVkParamsAudioEditPlaylist): Boolean;
begin
  with Handler.Execute('audio.editPlaylist', Params.List) do
  begin
    Result := Success and ResponseIsTrue;
  end;
end;

function TAudioController.Get(var Audios: TVkAudios; Params: TParams): Boolean;
begin
  Result := Handler.Execute('audio.get', Params).GetObject<TVkAudios>(Audios);
end;

function TAudioController.Get(var Audios: TVkAudios; Params: TVkParamsAudioGet): Boolean;
begin
  Result := Get(Audios, Params.List);
end;

function TAudioController.GetPlaylistById(var Item: TVkAudioPlaylist; const PlaylistId: Integer; OwnerId: Integer): Boolean;
var
  Params: TParams;
begin
  if OwnerId <> 0 then
    Params.Add('owner_id', OwnerId);
  Params.Add('playlist_id', PlaylistId);
  Result := Handler.Execute('audio.getPlaylistById', Params).GetObject<TVkAudioPlaylist>(Item);
end;

function TAudioController.GetPlaylists(var Items: TVkPlaylists; OwnerID: Integer): Boolean;
var
  Params: TVkParamsPlaylist;
begin
  Params.OwnerId(OwnerID);
  Params.Count(100);
  Result := GetPlaylists(Items, Params);
end;

function TAudioController.GetPopular(var Audios: TVkAudios; Params: TVkParamsPopAudio): Boolean;
begin
  Result := Handler.Execute('audio.getPopular', Params.List).GetObjects<TVkAudios>(Audios);
end;

function TAudioController.GetPopular(var Audios: TVkAudios; OnlyEng: Boolean; GenreId: TAudioGenre; Count, Offset: Integer): Boolean;
var
  Params: TVkParamsPopAudio;
begin
  Params.OnlyEng(OnlyEng);
  if GenreId <> agNone then
    Params.GenreId(GenreId);
  if Count > 0 then
    Params.Count(Count);
  if Offset > 0 then
    Params.Offset(Offset);
  Result := GetPopular(Audios, Params);
end;

function TAudioController.GetRecommendations(var Audios: TVkAudios; UserId: Integer): Boolean;
var
  Params: TVkParamsAudioGetRecomendations;
begin
  if UserId <> 0 then
    Params.UserId(UserId);
  Result := GetRecommendations(Audios, Params);
end;

function TAudioController.GetRecommendations(var Audios: TVkAudios; Params: TVkParamsAudioGetRecomendations): Boolean;
begin
  Result := Handler.Execute('audio.getRecommendations', Params.List).GetObject<TVkAudios>(Audios);
end;

function TAudioController.GetPlaylists(var Items: TVkPlaylists; Params: TVkParamsPlaylist): Boolean;
begin
  Result := Handler.Execute('audio.getPlaylists', Params.List).GetObject<TVkPlaylists>(Items);
end;

function TAudioController.GetById(var Audio: TVkAudio; OwnerId, AudioId: Integer; AccessKey: string): Boolean;
var
  ItemStr: string;
  JArray: TJSONArray;
begin
  if AccessKey.IsEmpty then
    ItemStr := OwnerId.ToString + '_' + AudioId.ToString
  else
    ItemStr := OwnerId.ToString + '_' + AudioId.ToString + '_' + AccessKey;
  with Handler.Execute('audio.getById', [['count', '1'], ['audios', ItemStr]]) do
  begin
    Result := Success;
    if Result then
    begin
      try
        JArray := TJSONArray(TJSONObject.ParseJSONValue(Response));
        try
          if JArray.Count > 0 then
            Audio := TVkAudio.FromJsonString<TVkAudio>(JArray.Items[0].ToString);
        finally
          JArray.Free;
        end;
      except
        Result := False;
      end;
    end;
  end;
end;

function TAudioController.GetCatalog(var Items: TVkAudioCatalog; Params: TParams): Boolean;
begin
  Result := Handler.Execute('audio.getCatalog', Params).GetObject<TVkAudioCatalog>(Items);
end;

function TAudioController.GetById(var Audios: TVkAudios; List: TVkAudioIndexes): Boolean;
var
  ListStr: string;
  i: Integer;
begin
  for i := Low(List) to High(List) do
  begin
    if i <> Low(List) then
      ListStr := ListStr + ',';
    ListStr := ListStr + List[i].OwnerId.ToString + '_' + List[i].AudioId.ToString;
  end;
  Result := Handler.Execute('audio.getById', ['audios', ListStr]).GetObject<TVkAudios>(Audios);
end;

function TAudioController.GetUploadServer(var UploadUrl: string): Boolean;
begin
  with Handler.Execute('audio.getUploadServer') do
  begin
    Result := Success and GetValue('upload_url', UploadUrl);
  end;
end;

function TAudioController.Reorder(Params: TVkParamsAudioReorder): Boolean;
begin
  with Handler.Execute('audio.reorder', Params.List) do
    Result := Success and ResponseIsTrue;
end;

function TAudioController.Restore(const AudioId: Integer; OwnerId: Integer): Boolean;
begin
  with Handler.Execute('audio.restore', [['audio_id', AudioId.ToString], ['owner_id', OwnerId.ToString]]) do
    Result := Success and ResponseIsTrue;
end;

{ TVkAudioParams }

function TVkParamsAudioGet.AccessKey(Value: string): Integer;
begin
  Result := List.Add('access_key', Value);
end;

function TVkParamsAudioGet.AlbumId(Value: Integer): Integer;
begin
  Result := List.Add('album_id', Value);
end;

function TVkParamsAudioGet.AudioIds(Value: TIds): Integer;
begin
  Result := List.Add('audio_ids', Value);
end;

function TVkParamsAudioGet.Count(Value: Integer): Integer;
begin
  Result := List.Add('count', Value);
end;

function TVkParamsAudioGet.Offset(Value: Integer): Integer;
begin
  Result := List.Add('offset', Value);
end;

function TVkParamsAudioGet.OwnerId(Value: Integer): Integer;
begin
  Result := List.Add('owner_id', Value);
end;

function TVkParamsAudioGet.PlaylistId(Value: Integer): Integer;
begin
  Result := List.Add('playlist_id', Value);
end;

{ TVkPlaylistParams }

function TVkParamsPlaylist.Count(Value: Integer): Integer;
begin
  Result := List.Add('count', Value);
end;

function TVkParamsPlaylist.Offset(Value: Integer): Integer;
begin
  Result := List.Add('offset', Value);
end;

function TVkParamsPlaylist.OwnerId(Value: Integer): Integer;
begin
  Result := List.Add('owner_id', Value);
end;

{ TVkPopAudioParams }

function TVkParamsPopAudio.Count(Value: Integer): Integer;
begin
  Result := List.Add('count', Value);
end;

function TVkParamsPopAudio.GenreId(Value: TAudioGenre): Integer;
begin
  Result := List.Add('genre_id', Value.ToConst);
end;

function TVkParamsPopAudio.Offset(Value: Integer): Integer;
begin
  Result := List.Add('offset', Value);
end;

function TVkParamsPopAudio.OnlyEng(Value: Boolean): Integer;
begin
  Result := List.Add('only_eng', Value);
end;

{ TVkAudioEditParams }

function TVkParamsAudioEdit.Artist(Value: string): Integer;
begin
  Result := List.Add('artist', Value);
end;

function TVkParamsAudioEdit.AudioId(Value: Integer): Integer;
begin
  Result := List.Add('audio_id', Value);
end;

function TVkParamsAudioEdit.GenreId(Value: TAudioGenre): Integer;
begin
  Result := List.Add('genre_id', Value.ToConst);
end;

function TVkParamsAudioEdit.NoSearch(Value: Boolean): Integer;
begin
  Result := List.Add('no_search', Value);
end;

function TVkParamsAudioEdit.OwnerId(Value: Integer): Integer;
begin
  Result := List.Add('owner_id', Value);
end;

function TVkParamsAudioEdit.Text(Value: string): Integer;
begin
  Result := List.Add('text', Value);
end;

function TVkParamsAudioEdit.Title(Value: string): Integer;
begin
  Result := List.Add('title', Value);
end;

{ TVkAudioSerachParams }

function TVkParamsAudioSearch.AutoComplete(Value: Boolean): Integer;
begin
  Result := List.Add('auto_complete', Value);
end;

function TVkParamsAudioSearch.Count(Value: Integer): Integer;
begin
  Result := List.Add('count', Value);
end;

function TVkParamsAudioSearch.Lyrics(Value: string): Integer;
begin
  Result := List.Add('lirycs', Value);
end;

function TVkParamsAudioSearch.Offset(Value: Integer): Integer;
begin
  Result := List.Add('offset', Value);
end;

function TVkParamsAudioSearch.PerformerOnly(Value: Boolean): Integer;
begin
  Result := List.Add('performer_only', Value);
end;

function TVkParamsAudioSearch.Query(Value: string): Integer;
begin
  Result := List.Add('q', Value);
end;

function TVkParamsAudioSearch.SearchOwn(Value: Boolean): Integer;
begin
  Result := List.Add('search_own', Value);
end;

function TVkParamsAudioSearch.Sort(Value: TVkAudioSort): Integer;
begin
  Result := List.Add('sort', Ord(Value));
end;

{ TVkParamsAudioEditPlaylist }

function TVkParamsAudioEditPlaylist.AudioIds(Value: TArrayOfString): Integer;
begin
  Result := List.Add('audio_ids', Value);
end;

function TVkParamsAudioEditPlaylist.Description(Value: string): Integer;
begin
  Result := List.Add('description', Value);
end;

function TVkParamsAudioEditPlaylist.OwnerId(Value: Integer): Integer;
begin
  Result := List.Add('owner_id', Value);
end;

function TVkParamsAudioEditPlaylist.PlaylistId(Value: Integer): Integer;
begin
  Result := List.Add('playlist_id', Value);
end;

function TVkParamsAudioEditPlaylist.Title(Value: string): Integer;
begin
  Result := List.Add('title', Value);
end;

{ TVkParamsAudioGetRecomendations }

function TVkParamsAudioGetRecomendations.Count(Value: Integer): Integer;
begin
  Result := List.Add('count', Value);
end;

function TVkParamsAudioGetRecomendations.Offset(Value: Integer): Integer;
begin
  Result := List.Add('offset', Value);
end;

function TVkParamsAudioGetRecomendations.Shuffle(Value: Boolean): Integer;
begin
  Result := List.Add('shuffle', Value);
end;

function TVkParamsAudioGetRecomendations.TargetAudio(Value: Integer): Integer;
begin
  Result := List.Add('target_audio', Value);
end;

function TVkParamsAudioGetRecomendations.UserId(Value: Integer): Integer;
begin
  Result := List.Add('user_id', Value);
end;

{ TVkParamsAudioReorder }

function TVkParamsAudioReorder.After(Value: Integer): Integer;
begin
  Result := List.Add('after', Value);
end;

function TVkParamsAudioReorder.AudioId(Value: Integer): Integer;
begin
  Result := List.Add('audio_id', Value);
end;

function TVkParamsAudioReorder.Before(Value: Integer): Integer;
begin
  Result := List.Add('before', Value);
end;

function TVkParamsAudioReorder.OwnerId(Value: Integer): Integer;
begin
  Result := List.Add('owner_id', Value);
end;

end.

