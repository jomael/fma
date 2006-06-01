unit uWinampCOMObj;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  ComObj, ActiveX, AxCtrls, Classes, WinampCOMLib_TLB, StdVcl, Windows, Messages, SysUtils, StrUtils,
  ShellAPI;

type
  TWinampCOMObj = class(TAutoObject, IConnectionPointContainer, IWinampCOMObj)
  private
    { Private declarations }
    FConnectionPoints: TConnectionPoints;
    FConnectionPoint: TConnectionPoint;
    FEvents: IWinampCOMObjEvents;
    FWPath: string;
    SongLengthParseTime: boolean;
    SongPosParseTime: boolean;
    GetPlaylistMode: Integer;

    FWSongList: TStringList;
    FWFileList: TStringList;  //removed

    FWArtistArray: array of Integer;  //array of indexes of unique artist array

    FWUniqueArtistList: TStringList;

    FWSearchArtistArray: array of Integer;    //array of indexes of unique artist array
    FWSearchSongArray: array of Integer;      //array of indexes of songs
    FWSearchAllArray: array of Integer;      //array of indexes of songs
    FWSearchSongsFromArtistArray: array of Integer;      //array of indexes of songs

    function WinampHnd(): THandle;
    function ConvertTime(n: integer;m : integer): string;
    function ConvertTimeTool(n: integer): string;
    function split(seperator: String; text: String; var list: TStringList): Integer;
    { note: FEvents maintains a *single* event sink. For access to more
      than one event sink, use FConnectionPoint.SinkList, and iterate
      through the list of sinks. }
  public

    procedure Initialize; override;
  protected
    { Protected declarations }
    property ConnectionPoints: TConnectionPoints read FConnectionPoints
      implements IConnectionPointContainer;
    procedure EventSinkChanged(const EventSink: IUnknown); override;
    function Get_PathExe: WideString; safecall;
    procedure Set_PathExe(const Value: WideString); safecall;
    procedure Pause; safecall;
    procedure Play; safecall;
    procedure Stop; safecall;
    procedure Back5sec; safecall;
    procedure Forward5sec; safecall;
    procedure NextTrack; safecall;
    procedure PreviousTrack; safecall;
    procedure FadeOutStop; safecall;
    procedure StartOfPlayList; safecall;
    procedure VolumeDown; safecall;
    procedure VolumeUp; safecall;
    function Get_GetTitlePlaying: WideString; safecall;
    function Get_GetSongState: WideString; safecall;
    function Get_GetSongPosition: WideString; safecall;
    function Get_GetSongLength: WideString; safecall;
    function Get_GetSongBitRate: WideString; safecall;
    function Get_GetSongSampleRate: WideString; safecall;
    function Get_GetPlayListPosition: WideString; safecall;
    function Get_GetPlayListLength: WideString; safecall;
    function Get_GetSongChanel: WideString; safecall;
    procedure GetPlayList; safecall;
    function Get_GetSongTitlebyPosition(Position: Integer): WideString;
      safecall;
    function Get_GetFileNamebyPosition(Position: Integer): WideString;
      safecall;
    procedure PlaySongByPosition(Position: Integer); safecall;
    function Get_SetLengthParseTime: WordBool; safecall;
    procedure Set_SetLengthParseTime(Value: WordBool); safecall;

    function Get_SongPosParseTime: WordBool; safecall;
    procedure Set_SongPosParseTime(Value: WordBool); safecall;
    function Get_GetArtistByPosition(Position: Integer): WideString; safecall;
    function Get_Shuffle: WordBool; safecall;
    procedure Set_Shuffle(Value: WordBool); safecall;
    function Get_Repeat_: WordBool; safecall;
    procedure Set_Repeat_(Value: WordBool); safecall;
    procedure Set_SetVolume(Value: Integer); safecall;
    function Get_JumpToTime(ms: Integer): Integer; safecall;
    function Get_GetUniqueArtist(Index: Integer): WideString; safecall;
    function Get_GetSearchArtist(Index: Integer): Integer; safecall;
    function Get_GetTotalUniqueArtist: Integer; safecall;
    function SearchArtist(const str: WideString): Integer; safecall;
    function Get_GetSearchSong(Index: Integer): Integer; safecall;
    function SearchAll(const str: WideString): Integer; safecall;
    function SearchSong(const str: WideString): Integer; safecall;
    function Get_GetSearchAll(Index: Integer): Integer; safecall;
    function SearchSongsFromArtist(Index: Integer): Integer; safecall;
    function Get_GetSearchSongsFromArtist(Index: Integer): Integer; safecall;
    function Get_GetSearchArtistString(Index: Integer): WideString; safecall;
    function Get_WinampState: WordBool; safecall;
    procedure Set_WinampState(Value: WordBool); safecall;
    procedure Set_GetPlaylistMode(Value: Integer); safecall;
    function Get_GetPlaylistMode: Integer; safecall;
  end;
implementation

uses ComServ;

procedure TWinampCOMObj.EventSinkChanged(const EventSink: IUnknown);
begin
  FEvents := EventSink as IWinampCOMObjEvents;
end;

procedure TWinampCOMObj.Initialize;
begin
  inherited Initialize;
  FConnectionPoints := TConnectionPoints.Create(Self);
  if AutoFactory.EventTypeInfo <> nil then
    FConnectionPoint := FConnectionPoints.CreateConnectionPoint(
      AutoFactory.EventIID, ckSingle, EventConnect)
  else FConnectionPoint := nil;
  SongLengthParseTime := False;
  SongPosParseTime := False;
  FWSonglist := TStringlist.Create;
  FWFilelist := TStringlist.Create;
  FWUniqueArtistlist := TStringlist.Create;
  GetPlaylistMode := 0;
end;

{public proprierties}
function TWinampCOMObj.Get_PathExe: WideString;
begin
  Result := FWPath;
end;

procedure TWinampCOMObj.Set_PathExe(const Value: WideString);
begin
  FWPath := value;
end;

function TWinampCOMObj.Get_SetLengthParseTime: WordBool;
begin
  Result := SongLengthParseTime;
end;

procedure TWinampCOMObj.Set_SetLengthParseTime(Value: WordBool);
begin
  SongLengthParseTime := value;
end;

function TWinampCOMObj.Get_SongPosParseTime: WordBool;
begin
  Result := SongPosParseTime;
end;

procedure TWinampCOMObj.Set_SongPosParseTime(Value: WordBool);
begin
  SongPosParseTime := value;
end;
{end properties}

{public method}

procedure TWinampCOMObj.Set_WinampState(Value: WordBool);
var
  cmd : string;
begin
  if Value then
  begin
    cmd := FWPath + '\winamp.exe';
    WinExec(PChar(cmd),0);
  end
  else
    SendMessage(WinampHnd(), WM_COMMAND, 40001, 0);
end;

procedure TWinampCOMObj.Pause;
begin
  SendMessage(WinampHnd(), WM_COMMAND, 40046, 0);
end;

procedure TWinampCOMObj.Play;
begin
  SendMessage(WinampHnd(), WM_COMMAND, 40045, 0);
end;

procedure TWinampCOMObj.Stop;
begin
  SendMessage(WinampHnd(), WM_COMMAND, 40047, 0);
end;

procedure TWinampCOMObj.Back5sec;
begin
  SendMessage(WinampHnd(), WM_COMMAND, 40144, 0);
end;

procedure TWinampCOMObj.Forward5sec;
begin
  SendMessage(WinampHnd(), WM_COMMAND, 40148, 0);
end;

procedure TWinampCOMObj.NextTrack;
begin
  SendMessage(WinampHnd(), WM_COMMAND, 40048, 0);
end;

procedure TWinampCOMObj.PreviousTrack;
begin
  SendMessage(WinampHnd(), WM_COMMAND, 40044, 0);
end;

procedure TWinampCOMObj.FadeOutStop;
begin
  SendMessage(WinampHnd(), WM_COMMAND, 40147, 0);
end;

procedure TWinampCOMObj.StartOfPlayList;
begin
  SendMessage(WinampHnd(), WM_COMMAND, 40154, 0);
end;

procedure TWinampCOMObj.VolumeDown;
begin
  SendMessage(WinampHnd(), WM_COMMAND, 40059, 0);
end;

procedure TWinampCOMObj.VolumeUp;
begin
  SendMessage(WinampHnd(), WM_COMMAND, 40058, 0);
end;

function TWinampCOMObj.Get_GetTitlePlaying: WideString;
var
  TitleLen: integer;
  TempInt : Integer;
  TempStr: String;
begin
  TempStr := 'Winamp isn''t running';

  if WinampHnd() <> 0 then
  begin
    // Get wHnd text
    TitleLen := GetWindowTextLength(WinampHnd()) + 2;
    SetLength(TempStr,TitleLen);
    GetWindowText(WinampHnd(),Pchar(TempStr),TitleLen);
    SetLength(TempStr,Length(TempStr));

    // Remove '- Winamp' part
    TempInt := Pos('- Winamp',TempStr);
    TempStr := Copy(TempStr,0,TempInt -2); // Knock of space and -
  end;

  Result := TempStr;
end;

function TWinampCOMObj.Get_GetSongState: WideString;
var
  SongState : Word;
  SongStateStr : String;
begin
  SongState := SendMessage(WinampHnd(),WM_USER,0,104);
  case SongState of
    1: SongStateStr:= 'Playing';
    3: SongStateStr:= 'Paused';
    0: SongStateStr:= 'Stopped'
  else
    SongStateStr := 'Unknown';
  end;

  Result := SongStateStr;
end;

function TWinampCOMObj.Get_GetSongPosition: WideString;
var
  TempInt : Integer;
begin
  TempInt := SendMessage(WinampHnd(),WM_USER,0,105);

  if SongPosParseTime then
    Result  :=  ConvertTime(TempInt,1000)
  else
    Result := IntToStr(TempInt);
end;

function TWinampCOMObj.Get_GetSongLength: WideString;
var
  TempInt : Integer;
begin
  TempInt := SendMessage(WinampHnd(),WM_USER,1,105);

  if SongLengthParseTime then
    Result := ConvertTime(TempInt,1)
  else
    Result := IntToStr(TempInt);
end;

function TWinampCOMObj.Get_GetSongBitRate: WideString;
begin
  Result := IntToStr(SendMessage(WinampHnd(),WM_USER,1,126));
end;

function TWinampCOMObj.Get_GetSongSampleRate: WideString;
begin
  Result := IntToStr(SendMessage(WinampHnd(),WM_USER,0,126));
end;

function TWinampCOMObj.Get_GetPlayListPosition: WideString;
var
  TempInt : Integer;
begin
  TempInt := SendMessage(WinampHnd(),WM_USER,0,125);

  if StrToInt(get_getPlayListLength()) < 1 then
    Result := IntToStr(TempInt)
  else
    Result := IntToStr(TempInt +1);
end;

function TWinampCOMObj.Get_GetPlayListLength: WideString;
begin
  Result := IntToStr(SendMessage(WinampHnd(),WM_USER,0,124));
end;

function TWinampCOMObj.Get_GetSongChanel: WideString;
begin
  Result := IntToStr(SendMessage(WinampHnd(),WM_USER,2,126));
end;

procedure TWinampCOMObj.GetPlayList;
var
  Buffer: string;
  Stream: TFileStream;
  FileStr : String;

  TempList : TStringList;
  TempList2 : TStringList;
  TempListLen : Integer;
  TempStr,TempStr2,TempStr3: String;
  TempPos,TempPos2,TempPosNewLine: Integer;

  i : Integer;
begin
  fwsonglist.Clear();
  fwuniqueartistList.Clear();
  fwfilelist.Clear();

  SetLength(FWSearchArtistArray, 0);
  SetLength(FWSearchSongArray, 0);
  SetLength(FWSearchAllArray, 0);
  SetLength(FWSearchSongsFromArtistArray, 0);

  SendMessage(WinampHnd(),WM_USER,0,120);

  Stream := TFileStream.Create(FWPath + '\winamp.m3u', fmShareDenyNone);
  try
    SetLength(buffer, Stream.Size);
    Stream.Read(Buffer[1], Stream.Size);
    FileStr := Buffer;
  finally
    Stream.Free;
  end;

  TempList := TStringList.Create;
  TempList2 := TStringList.Create; //Artist of each song
  TempListLen := Split('#EXTINF:', FileStr, TempList);

  // Start from 1 to cut out '#EXTM3U'. Grab Name and Filename
  for i:=1 to TempListLen -1 do
  begin
    TempPos  := Pos(',',TempList.Strings[i]);
    TempPos2 := Pos(' - ',TempList.Strings[i]);
    TempPosNewLine := Pos(#13,TempList.Strings[i]);

    if (TempPos2<>0) and (TempPos2<TempPosNewLine) then begin // ' - ' available
      TempStr  := Trim(Copy(TempList.Strings[i], TempPos + 1, (TempPos2 -1) - TempPos)); //Artist
      TempStr2 := Copy(TempList.strings[i], TempPos2 + 3, (TempPosNewLine -1) - TempPos2 - 2); //Song
    end
    else begin //NO ID3 Tag & ' - ' in file name
      TempStr  := '';
      TempStr2 := Copy(TempList.Strings[i], TempPos + 1, (TempPosNewLine -1) - TempPos); // Song
    end;

    TempList2.Add(TempStr);
    FWSongList.Add(TempStr2);

    if (GetPlaylistMode = 0) then
    begin
      TempStr3 := Copy(TempList.Strings[i], TempPosNewLine + 2, (Length(TempList.Strings[i]) - 1) - (TempPosNewLine + 2));
      FWFileList.Add(TempStr3);
    end;
  end;
  TempList.Free;

  FWUniqueArtistList.Sorted := True;
  FWUniqueArtistList.Duplicates := dupIgnore;

  for i:= 0 to TempListLen -2 do
  begin
    FWUniqueArtistList.Add(TempList2.Strings[i]);
  end;

  SetLength(FWArtistArray, TempListLen-1);

  for i:=0 to TempListLen -2 do   //assign artistarray with indexes of uniqueartistlist
  begin
    FWArtistArray[i] := FWUniqueArtistList.IndexOf(TempList2[i]);
  end;
  TempList2.Free;
end;

function TWinampCOMObj.Get_GetSongTitlebyPosition(
  Position: Integer): WideString;
begin
  Result := FWSonglist.Strings[position];
end;

function TWinampCOMObj.Get_GetArtistByPosition(
  Position: Integer): WideString;
begin
  Result := FWUniqueArtistList.Strings[FWArtistArray[position]];
end;

function TWinampCOMObj.Get_GetFileNamebyPosition(
  Position: Integer): WideString;
begin
  if (GetPlaylistMode = 0) then
    Result := FWFileList.Strings[position]
  else
    Result := '';
end;


procedure TWinampCOMObj.PlaySongByPosition(Position: Integer);
begin
  SendMessage(WinampHnd(),WM_USER,position,121);
  Play();
end;
{end method}

{private method}
function TWinampCOMObj.WinampHnd() :THandle;
begin
  Result := FindWindow('Winamp v1.x', nil);
end;

function TWinampCOMObj.ConvertTime(n: integer;m : integer): string;
begin
    n := n div m;
    Result := ConvertTimeTool(n div 60) + ':' + ConvertTimeTool(n mod 60);
end;

function TWinampCOMObj.ConvertTimeTool(n: integer): string;
begin
  if n < 10 then
    Result := '0' + inttostr(n)
  else
    Result := inttostr(n);
end;

function TWinampCOMObj.split(seperator: String; text: String; var list: TStringList): Integer;
var
  lensep, mypos, number: Integer;
  tmpStr: String;
begin
  number := 0;
  lensep := Length(seperator);
  if Length(text) > 0 then
  begin
    tmpStr := Copy(text, Length(text) - lensep + 1, lensep);
    if  tmpStr <> seperator then
      text := text + seperator;
    while(Pos(seperator, text)) > 0 do
    begin
      mypos := Pos(seperator, text);
      list.Add(Copy(text, 1, mypos - 1));
      text := Copy(text, mypos + lensep, Length(text) - mypos);
      Inc(number);
    end;
  end;
  Result := number;
end;
{end private}

function TWinampCOMObj.Get_Shuffle: WordBool;
var value: integer;
begin
  Result := False;
  value := SendMessage(WinampHnd(),WM_USER, 0, 250);
  if value = 1 then Result := True;
end;

procedure TWinampCOMObj.Set_Shuffle(Value: WordBool);
begin
  if Value then
    SendMessage(WinampHnd(),WM_USER, 1, 252)
  else
    SendMessage(WinampHnd(), WM_USER, 0, 252);
end;

function TWinampCOMObj.Get_Repeat_: WordBool;
var value: integer;
begin
  Result := False;
  value := SendMessage(WinampHnd(),WM_USER, 0, 251);
  if value = 1 then Result := True;
end;

procedure TWinampCOMObj.Set_Repeat_(Value: WordBool);
begin
  if Value then
    SendMessage(WinampHnd(), WM_USER, 1, 253)
  else
    SendMessage(WinampHnd(), WM_USER, 0, 253);
end;

procedure TWinampCOMObj.Set_SetVolume(Value: Integer);
begin
  if (Value >= 0) and (Value <= 255) then
    SendMessage(WinampHnd(), WM_USER, Value, 122);
end;

function TWinampCOMObj.Get_JumpToTime(ms: Integer): Integer;
begin
  Result := SendMessage(WinampHnd(), WM_USER, ms, 106);
end;

function TWinampCOMObj.Get_GetUniqueArtist(Index: Integer): WideString;
begin
  Result := FWUniqueArtistList.Strings[Index];
end;

function TWinampCOMObj.Get_GetSearchArtist(Index: Integer): Integer;
begin
  Result := FWSearchArtistArray[Index];
end;

function TWinampCOMObj.Get_GetTotalUniqueArtist: Integer;
begin
  Result := FWUniqueArtistList.Count;
end;

function TWinampCOMObj.SearchArtist(const str: WideString): Integer;
var
  i, j, len: Integer;
begin
  j := 0;
  len := FWUniqueArtistList.Count;
  SetLength(FWSearchArtistArray, len);
  for i:=0 to len-1 do begin
    if AnsiContainsText(FWUniqueArtistList[i], str) then begin
      FWSearchArtistArray[j] := i;
      Inc(j);
    end;
  end;
  SetLength(FWSearchArtistArray, j);
  Result := j;
end;

function TWinampCOMObj.Get_GetSearchSong(Index: Integer): Integer;
begin
  Result := FWSearchSongArray[Index];
end;

function TWinampCOMObj.SearchAll(const str: WideString): Integer;
var
  i, j, len: Integer;
begin
  j := 0;
  len := FWSongList.Count;
  SetLength(FWSearchAllArray, len);
  for i:=0 to len-1 do begin
    if AnsiContainsText(FWSongList[i] + FWUniqueArtistList[FWArtistArray[i]], str) then begin
      FWSearchAllArray[j] := i;
      Inc(j);
    end;
  end;
  SetLength(FWSearchAllArray, j);
  Result := j;
end;

function TWinampCOMObj.SearchSong(const str: WideString): Integer;
var
  i, j, len: Integer;
begin
  j := 0;
  len := FWSongList.Count;
  SetLength(FWSearchSongArray, len);
  for i:=0 to len-1 do begin
    if AnsiContainsText(FWSongList[i], str) then begin
      FWSearchSongArray[j] := i;
      Inc(j);
    end;
  end;
  SetLength(FWSearchSongArray, j);
  Result := j;
end;

function TWinampCOMObj.Get_GetSearchAll(Index: Integer): Integer;
begin
  Result := FWSearchAllArray[Index];
end;

function TWinampCOMObj.SearchSongsFromArtist(Index: Integer): Integer;
var
  i, j, len: Integer;
begin
  j := 0;
  len := Length(FWArtistArray);
  SetLength(FWSearchSongsFromArtistArray, len);
  for i:=0 to len-1 do begin
    if FWArtistArray[i]=Index then begin
      FWSearchSongsFromArtistArray[j] := i;
      Inc(j);
    end;
  end;
  SetLength(FWSearchSongsFromArtistArray, J);
  Result := J;
end;

function TWinampCOMObj.Get_GetSearchSongsFromArtist(
  Index: Integer): Integer;
begin
  Result := FWSearchSongsFromArtistArray[Index];
end;

function TWinampCOMObj.Get_GetSearchArtistString(
  Index: Integer): WideString;
begin
  Result := FWUniqueArtistList[FWSearchArtistArray[Index]];
end;

function TWinampCOMObj.Get_WinampState: WordBool;
begin
  Result := WinampHnd() <> 0;
end;

procedure TWinampCOMObj.Set_GetPlaylistMode(Value: Integer);
begin
  GetPlaylistMode := Value;
end;

function TWinampCOMObj.Get_GetPlaylistMode: Integer;
begin
  Result := GetPlaylistMode;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TWinampCOMObj, Class_WinampCOMObj,
    ciMultiInstance, tmApartment);
end.
