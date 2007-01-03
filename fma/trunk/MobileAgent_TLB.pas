unit MobileAgent_TLB;

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

// PASTLWTR : 1.2
// File generated on 31.12.2006 19:02:23 from Type Library described below.

// ************************************************************************  //
// Type Lib: c:\install\fma\MobileAgent.tlb (1)
// LIBID: {6D3D646F-A801-4FE4-8610-F209E33D0D6E}
// LCID: 0
// Helpfile: 
// HelpString: MobileAgent Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
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
  MobileAgentMajorVersion = 1;
  MobileAgentMinorVersion = 0;

  LIBID_MobileAgent: TGUID = '{6D3D646F-A801-4FE4-8610-F209E33D0D6E}';

  IID_IMobileAgentApp: TGUID = '{85984EEC-577C-424F-8823-210985DD844B}';
  CLASS_MobileAgentApp: TGUID = '{FD31E34D-CB7A-4896-ACA1-6276F345E34F}';
  IID_IAccessoriesMenu: TGUID = '{BD3C5F9C-AB43-4121-B44D-E3AD940E3C90}';
  CLASS_AccessoriesMenu: TGUID = '{6399EFF0-639D-4CB5-91B5-7F8D48640D1B}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IMobileAgentApp = interface;
  IMobileAgentAppDisp = dispinterface;
  IAccessoriesMenu = interface;
  IAccessoriesMenuDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  MobileAgentApp = IMobileAgentApp;
  AccessoriesMenu = IAccessoriesMenu;


// *********************************************************************//
// Interface: IMobileAgentApp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {85984EEC-577C-424F-8823-210985DD844B}
// *********************************************************************//
  IMobileAgentApp = interface(IDispatch)
    ['{85984EEC-577C-424F-8823-210985DD844B}']
    procedure AddCmd(const alabel: WideString; const event: WideString); safecall;
    procedure Connect; safecall;
    procedure Disconnect; safecall;
    procedure Exit; safecall;
    function Get_KeyPress: WideString; safecall;
    function Get_PopKey: WideString; safecall;
    procedure EnableKeyMonitor; safecall;
    procedure Debug(const Str: WideString); safecall;
    procedure ClearKey; safecall;
    procedure Status(const Str: WideString); safecall;
    procedure Minimize; safecall;
    procedure Restore; safecall;
    procedure Set_KeyInActivityTimeout(Param1: Integer); safecall;
    procedure Transmit(const Cmd: WideString); safecall;
    function Get_Connected: Integer; safecall;
    function Get_LookupByNumber(const Number: WideString): WideString; safecall;
    function Get_Received: WideString; safecall;
    procedure SentMessage(const Msg: WideString; const DestNo: WideString; ReqReply: Smallint; 
                          Flash: Smallint; StatusReq: Smallint); safecall;
    procedure ObexPut(const filename: WideString); safecall;
    procedure VoiceCall(const Number: WideString); safecall;
    procedure VoiceAnswer; safecall;
    procedure VoiceHangUp; safecall;
    function ObexGetObj(const filename: WideString; const objecturl: WideString): HResult; safecall;
    function ObexPutObj(const filename: WideString; const objecturl: WideString): HResult; safecall;
    function ObexGet(const filename: WideString; const objectname: WideString): HResult; safecall;
    procedure ObexDelete(const objectname: WideString); safecall;
    function ObexCut(const filename: WideString; const objectname: WideString): HResult; safecall;
    procedure AddTimer(msec: Integer; const event: WideString); safecall;
    procedure DeleteTimer(const event: WideString); safecall;
    procedure DisableKeyMonitor; safecall;
    procedure ScriptCall(const Code: WideString); safecall;
    procedure Sleep(msec: Integer); safecall;
    function Get_PhoneType(const Number: WideString): WideString; safecall;
    procedure DisconnectTemporary; safecall;
    function dGetText(const Domain: WideString; const szMsgId: WideString): WideString; safecall;
    function dnGetText(const Domain: WideString; const Singular: WideString; 
                       const Plural: WideString; Number: Integer): WideString; safecall;
    function GetCurrentLocale: WideString; safecall;
    function Get_PhoneModel: WideString; safecall;
    procedure AddTip(const atip: WideString; atimeoutsecs: Integer; ashownow: Smallint); safecall;
    procedure ClearTips; safecall;
    procedure AddBaloon(const atext: WideString; atimeoutsecs: Integer); safecall;
    procedure HideBaloon; safecall;
    function Get_MobileAgentFolder: WideString; safecall;
    function Get_ScriptFolder: WideString; safecall;
    function PhoneEncode(const atext: WideString): OleVariant; safecall;
    function PhoneDecode(atext: OleVariant): WideString; safecall;
    function Get_isT610clone: WordBool; safecall;
    function Get_isK750clone: WordBool; safecall;
    function Get_isK750orBetter: WordBool; safecall;
    property KeyPress: WideString read Get_KeyPress;
    property PopKey: WideString read Get_PopKey;
    property KeyInActivityTimeout: Integer write Set_KeyInActivityTimeout;
    property Connected: Integer read Get_Connected;
    property LookupByNumber[const Number: WideString]: WideString read Get_LookupByNumber;
    property Received: WideString read Get_Received;
    property PhoneType[const Number: WideString]: WideString read Get_PhoneType;
    property PhoneModel: WideString read Get_PhoneModel;
    property MobileAgentFolder: WideString read Get_MobileAgentFolder;
    property ScriptFolder: WideString read Get_ScriptFolder;
    property isT610clone: WordBool read Get_isT610clone;
    property isK750clone: WordBool read Get_isK750clone;
    property isK750orBetter: WordBool read Get_isK750orBetter;
  end;

// *********************************************************************//
// DispIntf:  IMobileAgentAppDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {85984EEC-577C-424F-8823-210985DD844B}
// *********************************************************************//
  IMobileAgentAppDisp = dispinterface
    ['{85984EEC-577C-424F-8823-210985DD844B}']
    procedure AddCmd(const alabel: WideString; const event: WideString); dispid 1;
    procedure Connect; dispid 2;
    procedure Disconnect; dispid 3;
    procedure Exit; dispid 4;
    property KeyPress: WideString readonly dispid 5;
    property PopKey: WideString readonly dispid 7;
    procedure EnableKeyMonitor; dispid 8;
    procedure Debug(const Str: WideString); dispid 9;
    procedure ClearKey; dispid 10;
    procedure Status(const Str: WideString); dispid 11;
    procedure Minimize; dispid 12;
    procedure Restore; dispid 13;
    property KeyInActivityTimeout: Integer writeonly dispid 14;
    procedure Transmit(const Cmd: WideString); dispid 17;
    property Connected: Integer readonly dispid 18;
    property LookupByNumber[const Number: WideString]: WideString readonly dispid 20;
    property Received: WideString readonly dispid 21;
    procedure SentMessage(const Msg: WideString; const DestNo: WideString; ReqReply: Smallint; 
                          Flash: Smallint; StatusReq: Smallint); dispid 22;
    procedure ObexPut(const filename: WideString); dispid 6;
    procedure VoiceCall(const Number: WideString); dispid 15;
    procedure VoiceAnswer; dispid 16;
    procedure VoiceHangUp; dispid 19;
    function ObexGetObj(const filename: WideString; const objecturl: WideString): HResult; dispid 23;
    function ObexPutObj(const filename: WideString; const objecturl: WideString): HResult; dispid 24;
    function ObexGet(const filename: WideString; const objectname: WideString): HResult; dispid 25;
    procedure ObexDelete(const objectname: WideString); dispid 26;
    function ObexCut(const filename: WideString; const objectname: WideString): HResult; dispid 27;
    procedure AddTimer(msec: Integer; const event: WideString); dispid 28;
    procedure DeleteTimer(const event: WideString); dispid 29;
    procedure DisableKeyMonitor; dispid 30;
    procedure ScriptCall(const Code: WideString); dispid 31;
    procedure Sleep(msec: Integer); dispid 32;
    property PhoneType[const Number: WideString]: WideString readonly dispid 34;
    procedure DisconnectTemporary; dispid 35;
    function dGetText(const Domain: WideString; const szMsgId: WideString): WideString; dispid 36;
    function dnGetText(const Domain: WideString; const Singular: WideString; 
                       const Plural: WideString; Number: Integer): WideString; dispid 37;
    function GetCurrentLocale: WideString; dispid 33;
    property PhoneModel: WideString readonly dispid 201;
    procedure AddTip(const atip: WideString; atimeoutsecs: Integer; ashownow: Smallint); dispid 202;
    procedure ClearTips; dispid 203;
    procedure AddBaloon(const atext: WideString; atimeoutsecs: Integer); dispid 204;
    procedure HideBaloon; dispid 205;
    property MobileAgentFolder: WideString readonly dispid 38;
    property ScriptFolder: WideString readonly dispid 39;
    function PhoneEncode(const atext: WideString): OleVariant; dispid 40;
    function PhoneDecode(atext: OleVariant): WideString; dispid 41;
    property isT610clone: WordBool readonly dispid 206;
    property isK750clone: WordBool readonly dispid 207;
    property isK750orBetter: WordBool readonly dispid 208;
  end;

// *********************************************************************//
// Interface: IAccessoriesMenu
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BD3C5F9C-AB43-4121-B44D-E3AD940E3C90}
// *********************************************************************//
  IAccessoriesMenu = interface(IDispatch)
    ['{BD3C5F9C-AB43-4121-B44D-E3AD940E3C90}']
    procedure Init; safecall;
    procedure Clear; safecall;
    procedure AddItem(const Caption: WideString; const event: WideString); safecall;
    procedure Set_Title(const Param1: WideString); safecall;
    procedure Set_Selected(Param1: Integer); safecall;
    procedure Update; safecall;
    procedure Set_Back(const Param1: WideString); safecall;
    procedure ClearMenu; safecall;
    procedure Set_NextState(Param1: Integer); safecall;
    procedure DlgOption; safecall;
    procedure DlgMsgBox(const Msg: WideString; TimeoutS: Integer); safecall;
    procedure DlgYesNo(const Msg: WideString; const event: WideString; TimeoutS: Integer); safecall;
    procedure DlgOnOff(const Title: WideString; const event: WideString; Default: Integer); safecall;
    procedure DlgPercent(const Title: WideString; const event: WideString; Steps: Integer; 
                         Pos: Integer); safecall;
    procedure DlgInputStr(const Title: WideString; const Prompt: WideString; MaxLen: Integer; 
                          const DefaultVal: WideString; const event: WideString); safecall;
    procedure DlgInformation(const Title: WideString; const Msg: WideString); safecall;
    procedure DlgInputInt(const Title: WideString; const Prompt: WideString; MinVal: Integer; 
                          MaxVal: Integer; DefaultVal: Integer; const event: WideString); safecall;
    procedure DlgFeedback(const Title: WideString; const event: WideString); safecall;
    procedure Set_MenuType(Value: Integer); safecall;
    procedure AddItemEx(const Caption: WideString; Disabled: WordBool; Selected: WordBool; 
                        CanDelete: WordBool; ImgIndex: Integer; const Event: WideString); safecall;
    property Title: WideString write Set_Title;
    property Selected: Integer write Set_Selected;
    property Back: WideString write Set_Back;
    property NextState: Integer write Set_NextState;
    property MenuType: Integer write Set_MenuType;
  end;

// *********************************************************************//
// DispIntf:  IAccessoriesMenuDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BD3C5F9C-AB43-4121-B44D-E3AD940E3C90}
// *********************************************************************//
  IAccessoriesMenuDisp = dispinterface
    ['{BD3C5F9C-AB43-4121-B44D-E3AD940E3C90}']
    procedure Init; dispid 1;
    procedure Clear; dispid 2;
    procedure AddItem(const Caption: WideString; const event: WideString); dispid 3;
    property Title: WideString writeonly dispid 5;
    property Selected: Integer writeonly dispid 6;
    procedure Update; dispid 7;
    property Back: WideString writeonly dispid 8;
    procedure ClearMenu; dispid 9;
    property NextState: Integer writeonly dispid 11;
    procedure DlgOption; dispid 12;
    procedure DlgMsgBox(const Msg: WideString; TimeoutS: Integer); dispid 14;
    procedure DlgYesNo(const Msg: WideString; const event: WideString; TimeoutS: Integer); dispid 15;
    procedure DlgOnOff(const Title: WideString; const event: WideString; Default: Integer); dispid 16;
    procedure DlgPercent(const Title: WideString; const event: WideString; Steps: Integer; 
                         Pos: Integer); dispid 17;
    procedure DlgInputStr(const Title: WideString; const Prompt: WideString; MaxLen: Integer; 
                          const DefaultVal: WideString; const event: WideString); dispid 18;
    procedure DlgInformation(const Title: WideString; const Msg: WideString); dispid 10;
    procedure DlgInputInt(const Title: WideString; const Prompt: WideString; MinVal: Integer; 
                          MaxVal: Integer; DefaultVal: Integer; const event: WideString); dispid 4;
    procedure DlgFeedback(const Title: WideString; const event: WideString); dispid 13;
    property MenuType: Integer writeonly dispid 19;
    procedure AddItemEx(const Caption: WideString; Disabled: WordBool; Selected: WordBool; 
                        CanDelete: WordBool; ImgIndex: Integer; const Event: WideString); dispid 20;
  end;

// *********************************************************************//
// The Class CoMobileAgentApp provides a Create and CreateRemote method to          
// create instances of the default interface IMobileAgentApp exposed by              
// the CoClass MobileAgentApp. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMobileAgentApp = class
    class function Create: IMobileAgentApp;
    class function CreateRemote(const MachineName: string): IMobileAgentApp;
  end;

// *********************************************************************//
// The Class CoAccessoriesMenu provides a Create and CreateRemote method to          
// create instances of the default interface IAccessoriesMenu exposed by              
// the CoClass AccessoriesMenu. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoAccessoriesMenu = class
    class function Create: IAccessoriesMenu;
    class function CreateRemote(const MachineName: string): IAccessoriesMenu;
  end;

implementation

uses ComObj;

class function CoMobileAgentApp.Create: IMobileAgentApp;
begin
  Result := CreateComObject(CLASS_MobileAgentApp) as IMobileAgentApp;
end;

class function CoMobileAgentApp.CreateRemote(const MachineName: string): IMobileAgentApp;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MobileAgentApp) as IMobileAgentApp;
end;

class function CoAccessoriesMenu.Create: IAccessoriesMenu;
begin
  Result := CreateComObject(CLASS_AccessoriesMenu) as IAccessoriesMenu;
end;

class function CoAccessoriesMenu.CreateRemote(const MachineName: string): IAccessoriesMenu;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_AccessoriesMenu) as IAccessoriesMenu;
end;

end.
