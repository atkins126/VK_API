unit VK.Entity.Gift;

interface

uses
  Generics.Collections, Rest.Json;

type
  TVkGift = class
  private
    FId: Extended;
    FThumb_256: string;
    FThumb_96: string;
    FThumb_48: string;
  public
    property id: Extended read FId write FId;
    property thumb_256: string read FThumb_256 write FThumb_256;
    property thumb_96: string read FThumb_96 write FThumb_96;
    property thumb_48: string read FThumb_48 write FThumb_48;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkGift;
  end;

implementation

{TVkGift}

function TVkGift.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVkGift.FromJsonString(AJsonString: string): TVkGift;
begin
  result := TJson.JsonToObject<TVkGift>(AJsonString)
end;

end.

