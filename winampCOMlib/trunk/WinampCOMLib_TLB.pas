unit WinampCOMLib_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : $Revision: 1.5 $
// File generated on 12.03.2004 15:03:29 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Projects\cvsroot\WinampCtrl\WinampCOMLib.tlb (1)
// LIBID: {A849469B-2282-4DDB-87DE-8A1AC15DAE04}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\System32\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINDOWS\System32\stdvcl40.dll)
// Errors:
//   Hint: Member 'Repeat' of 'IWinampCOMObj' changed to 'Repeat_'
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}

interface

uses Windows, ActiveX, Classes, Graphics, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  WinampCOMLibMajorVersion = 1;
  WinampCOMLibMinorVersion = 0;

  LIBID_WinampCOMLib: TGUID = '{A849469B-2282-4DDB-87DE-8A1AC15DAE04}';

  IID_IWinampCOMObj: TGUID = '{66434BE0-9533-4BE9-B3C2-93B61326807B}';
  DIID_IWinampCOMObjEvents: TGUID = '{5CD372B0-A488-487D-A50F-A0BAA166E166}';
  CLASS_WinampCOMObj: TGUID = '{B1CB3CAD-47F5-489D-B853-3969E906B3B1}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IWinampCOMObj = interface;
  IWinampCOMObjDisp = dispinterface;
  IWinampCOMObjEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  WinampCOMObj = IWinampCOMObj;


// *********************************************************************//
// Interface: IWinampCOMObj
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {66434BE0-9533-4BE9-B3C2-93B61326807B}
// *********************************************************************//
  IWinampCOMObj = interface(IDispatch)
    ['{66434BE0-9533-4BE9-B3C2-93B61326807B}']
    function Get_PathExe: WideString; safecall;
    procedure Set_PathExe(const Value: WideString); safecall;
    procedure Play; safecall;
    procedure Stop; safecall;
    procedure Pause; safecall;
    procedure NextTrack; safecall;
    procedure PreviousTrack; safecall;
    procedure Forward5sec; safecall;
    procedure Back5sec; safecall;
    procedure StartOfPlayList; safecall;
    procedure VolumeUp; safecall;
    procedure VolumeDown; safecall;
    procedure FadeOutStop; safecall;
    function Get_GetTitlePlaying: WideString; safecall;
    function Get_GetSongState: WideString; safecall;
    function Get_GetSongLength: WideString; safecall;
    function Get_GetSongSampleRate: WideString; safecall;
    function Get_GetSongBitRate: WideString; safecall;
    function Get_GetSongChanel: WideString; safecall;
    function Get_GetPlayListPosition: WideString; safecall;
    function Get_GetPlayListLength: WideString; safecall;
    procedure GetPlayList; safecall;
    function Get_GetSongTitlebyPosition(Position: Integer): WideString; safecall;
    function Get_GetFileNamebyPosition(Position: Integer): WideString; safecall;
    procedure PlaySongByPosition(Position: Integer); safecall;
    function Get_SetLengthParseTime: WordBool; safecall;
    procedure Set_SetLengthParseTime(Value: WordBool); safecall;
    function Get_SongPosParseTime: WordBool; safecall;
    procedure Set_SongPosParseTime(Value: WordBool); safecall;
    function Get_GetArtistByPosition(Position: Integer): WideString; safecall;
    function Get_GetSongPosition: WideString; safecall;
    function Get_Shuffle: WordBool; safecall;
    procedure Set_Shuffle(Value: WordBool); safecall;
    function Get_Repeat_: WordBool; safecall;
    procedure Set_Repeat_(Value: WordBool); safecall;
    procedure Set_SetVolume(Param1: Integer); safecall;
    function Get_JumpToTime(ms: Integer): Integer; safecall;
    function Get_GetUniqueArtist(Index: Integer): WideString; safecall;
    function Get_GetTotalUniqueArtist: Integer; safecall;
    function SearchArtist(const str: WideString): Integer; safecall;
    function Get_GetSearchArtist(Index: Integer): Integer; safecall;
    function Get_GetSearchArtistString(Index: Integer): WideString; safecall;
    function SearchSong(const str: WideString): Integer; safecall;
    function Get_GetSearchSong(Index: Integer): Integer; safecall;
    function SearchAll(const str: WideString): Integer; safecall;
    function Get_GetSearchAll(Index: Integer): Integer; safecall;
    function SearchSongsFromArtist(Index: Integer): Integer; safecall;
    function Get_GetSearchSongsFromArtist(Index: Integer): Integer; safecall;
    function Get_WinampState: WordBool; safecall;
    procedure Set_WinampState(Value: WordBool); safecall;
    function Get_GetPlaylistMode: Integer; safecall;
    procedure Set_GetPlaylistMode(Value: Integer); safecall;
    property PathExe: WideString read Get_PathExe write Set_PathExe;
    property GetTitlePlaying: WideString read Get_GetTitlePlaying;
    property GetSongState: WideString read Get_GetSongState;
    property GetSongLength: WideString read Get_GetSongLength;
    property GetSongSampleRate: WideString read Get_GetSongSampleRate;
    property GetSongBitRate: WideString read Get_GetSongBitRate;
    property GetSongChanel: WideString read Get_GetSongChanel;
    property GetPlayListPosition: WideString read Get_GetPlayListPosition;
    property GetPlayListLength: WideString read Get_GetPlayListLength;
    property GetSongTitlebyPosition[Position: Integer]: WideString read Get_GetSongTitlebyPosition;
    property GetFileNamebyPosition[Position: Integer]: WideString read Get_GetFileNamebyPosition;
    property SetLengthParseTime: WordBool read Get_SetLengthParseTime write Set_SetLengthParseTime;
    property SongPosParseTime: WordBool read Get_SongPosParseTime write Set_SongPosParseTime;
    property GetArtistByPosition[Position: Integer]: WideString read Get_GetArtistByPosition;
    property GetSongPosition: WideString read Get_GetSongPosition;
    property Shuffle: WordBool read Get_Shuffle write Set_Shuffle;
    property Repeat_: WordBool read Get_Repeat_ write Set_Repeat_;
    property SetVolume: Integer write Set_SetVolume;
    property JumpToTime[ms: Integer]: Integer read Get_JumpToTime;
    property GetUniqueArtist[Index: Integer]: WideString read Get_GetUniqueArtist;
    property GetTotalUniqueArtist: Integer read Get_GetTotalUniqueArtist;
    property GetSearchArtist[Index: Integer]: Integer read Get_GetSearchArtist;
    property GetSearchArtistString[Index: Integer]: WideString read Get_GetSearchArtistString;
    property GetSearchSong[Index: Integer]: Integer read Get_GetSearchSong;
    property GetSearchAll[Index: Integer]: Integer read Get_GetSearchAll;
    property GetSearchSongsFromArtist[Index: Integer]: Integer read Get_GetSearchSongsFromArtist;
    property WinampState: WordBool read Get_WinampState write Set_WinampState;
    property GetPlaylistMode: Integer read Get_GetPlaylistMode write Set_GetPlaylistMode;
  end;

// *********************************************************************//
// DispIntf:  IWinampCOMObjDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {66434BE0-9533-4BE9-B3C2-93B61326807B}
// *********************************************************************//
  IWinampCOMObjDisp = dispinterface
    ['{66434BE0-9533-4BE9-B3C2-93B61326807B}']
    property PathExe: WideString dispid 201;
    procedure Play; dispid 202;
    procedure Stop; dispid 203;
    procedure Pause; dispid 204;
    procedure NextTrack; dispid 205;
    procedure PreviousTrack; dispid 206;
    procedure Forward5sec; dispid 207;
    procedure Back5sec; dispid 208;
    procedure StartOfPlayList; dispid 209;
    procedure VolumeUp; dispid 210;
    procedure VolumeDown; dispid 211;
    procedure FadeOutStop; dispid 212;
    property GetTitlePlaying: WideString readonly dispid 213;
    property GetSongState: WideString readonly dispid 214;
    property GetSongLength: WideString readonly dispid 215;
    property GetSongSampleRate: WideString readonly dispid 216;
    property GetSongBitRate: WideString readonly dispid 217;
    property GetSongChanel: WideString readonly dispid 218;
    property GetPlayListPosition: WideString readonly dispid 219;
    property GetPlayListLength: WideString readonly dispid 220;
    procedure GetPlayList; dispid 221;
    property GetSongTitlebyPosition[Position: Integer]: WideString readonly dispid 222;
    property GetFileNamebyPosition[Position: Integer]: WideString readonly dispid 223;
    procedure PlaySongByPosition(Position: Integer); dispid 224;
    property SetLengthParseTime: WordBool dispid 225;
    property SongPosParseTime: WordBool dispid 226;
    property GetArtistByPosition[Position: Integer]: WideString readonly dispid 227;
    property GetSongPosition: WideString readonly dispid 228;
    property Shuffle: WordBool dispid 229;
    property Repeat_: WordBool dispid 230;
    property SetVolume: Integer writeonly dispid 231;
    property JumpToTime[ms: Integer]: Integer readonly dispid 232;
    property GetUniqueArtist[Index: Integer]: WideString readonly dispid 233;
    property GetTotalUniqueArtist: Integer readonly dispid 234;
    function SearchArtist(const str: WideString): Integer; dispid 235;
    property GetSearchArtist[Index: Integer]: Integer readonly dispid 236;
    property GetSearchArtistString[Index: Integer]: WideString readonly dispid 237;
    function SearchSong(const str: WideString): Integer; dispid 238;
    property GetSearchSong[Index: Integer]: Integer readonly dispid 239;
    function SearchAll(const str: WideString): Integer; dispid 240;
    property GetSearchAll[Index: Integer]: Integer readonly dispid 241;
    function SearchSongsFromArtist(Index: Integer): Integer; dispid 242;
    property GetSearchSongsFromArtist[Index: Integer]: Integer readonly dispid 243;
    property WinampState: WordBool dispid 244;
    property GetPlaylistMode: Integer dispid 245;
  end;

// *********************************************************************//
// DispIntf:  IWinampCOMObjEvents
// Flags:     (4096) Dispatchable
// GUID:      {5CD372B0-A488-487D-A50F-A0BAA166E166}
// *********************************************************************//
  IWinampCOMObjEvents = dispinterface
    ['{5CD372B0-A488-487D-A50F-A0BAA166E166}']
  end;

// *********************************************************************//
// The Class CoWinampCOMObj provides a Create and CreateRemote method to          
// create instances of the default interface IWinampCOMObj exposed by              
// the CoClass WinampCOMObj. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoWinampCOMObj = class
    class function Create: IWinampCOMObj;
    class function CreateRemote(const MachineName: string): IWinampCOMObj;
  end;

implementation

uses ComObj;

class function CoWinampCOMObj.Create: IWinampCOMObj;
begin
  Result := CreateComObject(CLASS_WinampCOMObj) as IWinampCOMObj;
end;

class function CoWinampCOMObj.CreateRemote(const MachineName: string): IWinampCOMObj;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_WinampCOMObj) as IWinampCOMObj;
end;

end.
