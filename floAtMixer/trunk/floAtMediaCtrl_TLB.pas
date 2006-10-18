unit floAtMediaCtrl_TLB;

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
// File generated on 18.10.2006 18:52:51 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Projects\FMA\floAtMixer\trunk\floAtMediaCtrl.tlb (1)
// LIBID: {84D1617E-2C8E-4140-B017-6FE79FBE71CC}
// LCID: 0
// Helpfile: 
// HelpString: floAtMixer Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\STDOLE2.TLB)
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
  floAtMediaCtrlMajorVersion = 1;
  floAtMediaCtrlMinorVersion = 0;

  LIBID_floAtMediaCtrl: TGUID = '{84D1617E-2C8E-4140-B017-6FE79FBE71CC}';

  IID_IVolumeCtrl: TGUID = '{F285B22E-D732-4089-B9CD-C51C47057FB4}';
  CLASS_VolumeCtrl: TGUID = '{6EAD3C6D-CC87-4F6A-9EB1-D069979FF081}';
  IID_IMouseCtrl: TGUID = '{AA35F9A6-1E09-405B-AC96-8213579A766B}';
  CLASS_MouseCtrl: TGUID = '{78885E41-045D-4D2C-80A6-9AE055A6622D}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IVolumeCtrl = interface;
  IVolumeCtrlDisp = dispinterface;
  IMouseCtrl = interface;
  IMouseCtrlDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  VolumeCtrl = IVolumeCtrl;
  MouseCtrl = IMouseCtrl;


// *********************************************************************//
// Interface: IVolumeCtrl
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F285B22E-D732-4089-B9CD-C51C47057FB4}
// *********************************************************************//
  IVolumeCtrl = interface(IDispatch)
    ['{F285B22E-D732-4089-B9CD-C51C47057FB4}']
    function Get_Mute: Integer; safecall;
    procedure Set_Mute(Value: Integer); safecall;
    function Get_Volume: Integer; safecall;
    procedure Set_Volume(Value: Integer); safecall;
    procedure Set_DestinationID(Param1: Integer); safecall;
    procedure Set_ConnectionID(Param1: Integer); safecall;
    procedure Set_ShowDurationMS(Param1: Integer); safecall;
    procedure Show; safecall;
    function Get_GetReferences: Integer; safecall;
    procedure Set_GradualVol(Param1: Integer); safecall;
    property Mute: Integer read Get_Mute write Set_Mute;
    property Volume: Integer read Get_Volume write Set_Volume;
    property DestinationID: Integer write Set_DestinationID;
    property ConnectionID: Integer write Set_ConnectionID;
    property ShowDurationMS: Integer write Set_ShowDurationMS;
    property GetReferences: Integer read Get_GetReferences;
    property GradualVol: Integer write Set_GradualVol;
  end;

// *********************************************************************//
// DispIntf:  IVolumeCtrlDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {F285B22E-D732-4089-B9CD-C51C47057FB4}
// *********************************************************************//
  IVolumeCtrlDisp = dispinterface
    ['{F285B22E-D732-4089-B9CD-C51C47057FB4}']
    property Mute: Integer dispid 1;
    property Volume: Integer dispid 2;
    property DestinationID: Integer writeonly dispid 3;
    property ConnectionID: Integer writeonly dispid 4;
    property ShowDurationMS: Integer writeonly dispid 5;
    procedure Show; dispid 6;
    property GetReferences: Integer readonly dispid 7;
    property GradualVol: Integer writeonly dispid 8;
  end;

// *********************************************************************//
// Interface: IMouseCtrl
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {AA35F9A6-1E09-405B-AC96-8213579A766B}
// *********************************************************************//
  IMouseCtrl = interface(IDispatch)
    ['{AA35F9A6-1E09-405B-AC96-8213579A766B}']
    procedure MouseMove(const Direction: WideString); safecall;
    procedure MouseStop; safecall;
    procedure MouseWhlUp; safecall;
    procedure MouseWhlDown; safecall;
    procedure MouseRightClick; safecall;
    procedure MouseLeftClick; safecall;
  end;

// *********************************************************************//
// DispIntf:  IMouseCtrlDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {AA35F9A6-1E09-405B-AC96-8213579A766B}
// *********************************************************************//
  IMouseCtrlDisp = dispinterface
    ['{AA35F9A6-1E09-405B-AC96-8213579A766B}']
    procedure MouseMove(const Direction: WideString); dispid 1;
    procedure MouseStop; dispid 2;
    procedure MouseWhlUp; dispid 3;
    procedure MouseWhlDown; dispid 4;
    procedure MouseRightClick; dispid 5;
    procedure MouseLeftClick; dispid 6;
  end;

// *********************************************************************//
// The Class CoVolumeCtrl provides a Create and CreateRemote method to          
// create instances of the default interface IVolumeCtrl exposed by              
// the CoClass VolumeCtrl. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoVolumeCtrl = class
    class function Create: IVolumeCtrl;
    class function CreateRemote(const MachineName: string): IVolumeCtrl;
  end;

// *********************************************************************//
// The Class CoMouseCtrl provides a Create and CreateRemote method to          
// create instances of the default interface IMouseCtrl exposed by              
// the CoClass MouseCtrl. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMouseCtrl = class
    class function Create: IMouseCtrl;
    class function CreateRemote(const MachineName: string): IMouseCtrl;
  end;

implementation

uses ComObj;

class function CoVolumeCtrl.Create: IVolumeCtrl;
begin
  Result := CreateComObject(CLASS_VolumeCtrl) as IVolumeCtrl;
end;

class function CoVolumeCtrl.CreateRemote(const MachineName: string): IVolumeCtrl;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_VolumeCtrl) as IVolumeCtrl;
end;

class function CoMouseCtrl.Create: IMouseCtrl;
begin
  Result := CreateComObject(CLASS_MouseCtrl) as IMouseCtrl;
end;

class function CoMouseCtrl.CreateRemote(const MachineName: string): IMouseCtrl;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MouseCtrl) as IMouseCtrl;
end;

end.
