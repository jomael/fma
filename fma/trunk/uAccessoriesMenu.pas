unit uAccessoriesMenu;

{
*******************************************************************************
* Descriptions: Accessories Menu for Ericsson Phone Implementation
* $Source: /cvsroot/fma/fma/uAccessoriesMenu.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uAccessoriesMenu.pas,v $
* Revision 1.13.2.4  2006/03/12 13:04:31  z_stoichev
* New UTF8 Codec usage.
*
* Revision 1.13.2.3  2005/12/08 19:37:46  mhr3
* fixed problem with AT*EAM
*
* Revision 1.13.2.2  2005/12/07 13:43:38  z_stoichev
* Added K750 scripting support.
*
* Revision 1.13.2.1  2005/10/04 10:09:12  expertone
* Added some AT-command restrictions.
* Fixed localized menus (restriction is 320 bytes, not 320 chars).
*
* Revision 1.13  2005/02/19 12:17:17  lordlarry
* Changed Log Messages Category and Severity (Removing the Debug method)
*
* Revision 1.12  2005/02/19 11:54:50  lordlarry
* Changed Log Messages Category and Severity (Removing the Debug method)
*
* Revision 1.11  2005/02/08 15:38:33  voxik
* Merged with L10N branch
*
* Revision 1.10.14.4  2004/11/10 12:01:26  expertone
* Replaced String with WideString.
* Replaced TStrings with TTntStrings.
* Replaced AnsiToUtf8 with WideStringToUTF8String.
* Added UTF8 transform for all SE dialogs
*
* Revision 1.10.14.3  2004/11/01 21:30:14  expertone
* Added AnsiToUtf8 conversion for menu titles (must use WideString and TWideStringList)
*
* Revision 1.10.14.2  2004/10/25 20:21:37  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.10.14.1  2004/10/19 19:48:30  expertone
* Add localization (gnugettext)
*
* Revision 1.10  2004/05/19 18:34:15  z_stoichev
* Build 0.1.0.35c
*
* Revision 1.9  2004/02/03 16:13:01  z_stoichev
* Fixed Accessories menu Init works in offline mode.
* Fixed am.TxAndWait execute is synced with other TxAndWait calls.
*
* Revision 1.8  2004/01/27 15:54:28  z_stoichev
* menu cleanups.
*
* Revision 1.7  2004/01/23 08:28:16  z_stoichev
* Added missing "
*
* Revision 1.6  2003/12/18 12:45:39  z_stoichev
* Carpedi3m requested implementations.
*
* Revision 1.5  2003/11/28 09:38:07  z_stoichev
* Merged with branch-release-1-1 (Fma 0.10.28c)
*
* Revision 1.4.2.1  2003/10/27 07:22:54  z_stoichev
* Build 0.1.0 RC1 Initial Checkin.
*
* Revision 1.4  2003/07/02 12:43:14  crino77
* added dlginformation
*
* Revision 1.3  2003/01/30 04:15:57  warren00
* Updated with header comments
*
*
*******************************************************************************
}

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  ComObj, ActiveX, MobileAgent_TLB, StdVcl, Classes, TntClasses, SysUtils, TntSysUtils, TntSystem, uThreadSafe;

const
  DLG_OPTION      = $01;
  DLG_MSGBOX      = $02;
  DLG_YESNO       = $03;
  DLG_ONOFF       = $04;
  DLG_PERCENT     = $05;
  DLG_INPUTSTR    = $06;
  DLG_INPUTINT    = $07;
  DLG_INFORMATION = $08;
  DLG_FEEDBACK    = $09;
  DLG_SUBMENU     = $0a;
  DLG_INPUTERR    = $80;

type
  TAccessoriesMenu = class(TAutoObject, IAccessoriesMenu)
  private
    FTitle: WideString;
    FMenuList: TTntStrings;
    FUIOpen: Boolean;
  protected
    { Protected declarations }
    procedure Init; safecall;
    procedure Clear; safecall;
    procedure AddItem(const Caption, Event: WideString); safecall;
    procedure Set_Title(const Value: WideString); safecall;
    procedure Set_Selected(Value: Integer); safecall;
    procedure Update; safecall;
    procedure Set_Back(const Value: WideString); safecall;
    procedure ClearMenu; safecall;
    procedure Set_NextState(Value: Integer); safecall;
    procedure DlgOption; safecall;
    procedure DlgMsgBox(const Msg: WideString; TimeoutS: Integer); safecall;
    procedure DlgYesNo(const Msg, Event: WideString; TimeoutS: Integer); safecall;
    procedure DlgOnOff(const Title, Event: WideString; Default: Integer); safecall;
    procedure DlgPercent(const Title, Event: WideString; Steps, Pos: Integer); safecall;
    procedure DlgInputStr(const Title, Prompt: WideString; MaxLen: Integer;
      const DefaultStr: WideString; const Event: WideString); safecall;
    procedure DlgInputInt(const Title, Prompt: WideString; MinVal, MaxVal,
      DefaultVal: Integer; const event: WideString); safecall;
    procedure DlgInformation(const Title, Msg: WideString); safecall;
    procedure DlgFeedback(const Title, event: WideString); safecall;
  public
    FSelected: Integer;
    FBack: String;
    FEventList: TTntStrings;
    FNextState: Integer;
    FGeneralEvent: String;
    FType: Integer;
    FPercentSteps: Integer;
    FPercentPos: Integer;
    FMenuEntryEvent: String;
    FInputMax: Integer;
    FInputMin: Integer;
    procedure OpenUI; safecall;
    procedure CloseUI; safecall;
    procedure Initialize; override;
    destructor Destroy; override;
  end;

implementation

uses
  gnugettext, gnugettexthelpers, cUnicodeCodecs,
  ComServ, Unit1, uLogger;

{*******************************************************************************
Init() [Called on connect. Initialises FUIOpen property and inserts
        FMA into (Settings/)Connectivity/Accessories menu]
*******************************************************************************}
procedure TAccessoriesMenu.Init;
var
  sl: TTntStringList;
  i: Integer;
begin
  FUIOpen:=False;
  if Form1.FConnected then begin
    if Form1.IsK750Clone then begin
      Form1.TxAndWait('AT*SEAM="FMA",13'); // do not localize
      sl := TTntStringList.Create;
      try
        sl.Text := ThreadSafe.RxBuffer.Text;
        for i := 0 to sl.Count - 1 do
          if pos('*SEAM:', sl[i]) = 1 then // do not localize
            FMenuEntryEvent:='*SEAAI'+Copy(sl[i],6,MaxInt);
      finally
        sl.free
      end;
    end
    else begin
      FMenuEntryEvent:='';
      Form1.ScheduleTxAndWait('AT*EAM="FMA"'); // do not localize
    end;
  end;
  Log.AddCommunicationMessage('AccessoriesMenu.Init: Event="'+FMenuEntryEvent+'"'); // do not localize debug
  Clear;
end;

{*******************************************************************************
Clear() [Clear all properties of the menu: Menu items, Abort command, Title,
         and sets Index of selected item and NextState to 1.
*******************************************************************************}
procedure TAccessoriesMenu.Clear;
begin
  Log.AddScriptMessage('AccessoriesMenu.Clear', lsDebug); // do not localize debug
  ClearMenu;
  FTitle := '';
  FSelected := 1;
  FNextState := 1;
end;

{*******************************************************************************
AddItem(
  WideString Caption  [Text to be inserted into item],
  WideString  Event   [Command to be executed on item select])
*******************************************************************************}
procedure TAccessoriesMenu.AddItem(const Caption, Event: WideString);
begin
  FMenuList.Add(Caption);
  FEventList.Add(Event);
end;

{*******************************************************************************
Set_Title(
  WideString Value  [Text to be displayed as menu title])
*******************************************************************************}
procedure TAccessoriesMenu.Set_Title(const Value: WideString);
begin
  FTitle := Value;
end;

{*******************************************************************************
Set_Selected(
  Integer Value [Index of item to be preselected on menu update])
*******************************************************************************}
procedure TAccessoriesMenu.Set_Selected(Value: Integer);
begin
  FSelected := Value;
end;

{*******************************************************************************
Update() [Shows the menu on the phone]
*******************************************************************************}
procedure TAccessoriesMenu.Update;
var
  Com: String;
  Buf, TempBuf: String;
  ComLen, ComCount: Integer;
  W: WideString;
  i: Integer;
begin
  { AT*EASM=<title>,<next_state>,<selected_item>,<number_of_menu_items>[,<menu_item>[,<menu_item>, ...]][,<final_flag>] }

  // Prepare start of AT command
  OpenUI;
  FType := DLG_SUBMENU;
  Log.AddScriptMessage('AccessoriesMenu.Update', lsDebug); // do not localize debug

  if Form1.IsK750Clone then begin
    Com := 'AT*SELIST="' + WideStringToUTF8String(FTitle) + '",3,'; // do not localize
    If FSelected>0 Then
      Com := Com + IntToStr(FSelected-1) + ',' // do not localize
    else
      Com := Com + '0,';  // do not localize
  end
  else
    Com := 'AT*EASM="' + WideStringToUTF8String(Copy(FTitle,1,15)) + '",' + IntToStr(FNextState) + ',' + IntToStr(FSelected) + ','; // do not localize
  ComLen := Length(Com);

  // Reset all flags and buffers
  ComCount := 0;
  Buf := '';
  TempBuf := '';

  // Build menu
  for i := 0 to FMenuList.Count - 1 do begin
    // Add menu item
    W := FMenuList.Strings[i];
    repeat
      TempBuf := WideStringToUTF8String(W);
      if Length(TempBuf) <= 200 then break; // normally break in first test
      // Remove last char in W. In next iteration this will remove last UTF-8 encoded char in TempBuf (from 1 to 3 bytes)
      SetLength(W, Length(W)-1);
    until false;
    if Form1.IsK750Clone then
      TempBuf := ',"' + TempBuf + '",0,0,0,0'
    else
      TempBuf := ',"' + TempBuf + '"';

    // Check if AT command is not too long
    if ((ComLen + Length(Buf) + Length(TempBuf)) > 200) and not Form1.IsK750Clone then begin
      // It is too long, set final_flag to 0, we will continue
      Buf := Com + IntToStr(ComCount) + Buf + ',0';
      // Send AT command
      Form1.TxAndWait(Buf);

      // Store last item to buffer
      Buf := TempBuf;
      ComCount := 1;
    end
    else begin
      // Add menu item and increase counter of items in one command
      Buf := Buf + TempBuf;
      Inc(ComCount);
    end;
  end;

  // Send rest of menu to phone with final_flag set to 1
  if Form1.IsK750Clone then
    Buf := Com + IntToStr(ComCount) + ',1,1' + Buf 
  else
    Buf := Com + IntToStr(ComCount) + Buf + ',1'; 
  Form1.TxAndWait(Buf);
end;

{*******************************************************************************
Set_Back(
  WideString Value  [Command to be executed on menu abort])
*******************************************************************************}
procedure TAccessoriesMenu.Set_Back(const Value: WideString);
begin
  FBack := Value;
end;

{*******************************************************************************
ClearMenu() [Clears menu items and abort command]
*******************************************************************************}
procedure TAccessoriesMenu.ClearMenu;
begin
  Log.AddScriptMessage('AccessoriesMenu.ClearMenu', lsDebug); // do not localize debug
  FMenuList.Clear;
  FEventList.Clear;
  FBack := '';
end;

{*******************************************************************************
Set_NextState(
  Integer Value)
*******************************************************************************}
procedure TAccessoriesMenu.Set_NextState(Value: Integer);
begin
  FNextState := Value;
end;

{*******************************************************************************
DlgOption()
*******************************************************************************}
procedure TAccessoriesMenu.DlgOption;
var
  buf: String;
  i: Integer;
begin
  OpenUI;
  FType := DLG_OPTION;
  Log.AddScriptMessage('AccessoriesMenu.DlgOption'); // do not localize debug

  if Form1.IsK750Clone then begin
    buf := 'AT*SELIST="' + WideStringToUTF8String(Copy(FTitle,1,15)) + '",3,'; // do not localize
    If FSelected > 0 Then
      buf := buf + IntToStr(FSelected-1) + ',' // do not localize
    else
      buf := buf + '0,';  // do not localize
    buf := buf + IntToStr(FMenuList.Count) + ',1,1';
  end
  else
    buf := 'AT*EAID=5,' + IntToStr(FNextState) + ',' + '"' +  WideStringToUTF8String(Copy(FTitle,1,15)) + '",' + IntToStr(FSelected) + ',' + IntToStr(FMenuList.Count);

  for i := 0 to FMenuList.Count - 1 do begin
    if Form1.IsK750Clone then
      buf := buf + ',"' + WideStringToUTF8String(Copy(FMenuList.Strings[i],1,15)) + '",0,0,0,0'
    else
      buf := buf + ',"' + WideStringToUTF8String(Copy(FMenuList.Strings[i],1,15)) + '"';
  end;

  Form1.ScheduleTxAndWait(buf); 
end;

{*******************************************************************************
DlgMsgBox(
  WideString Msg   [Text to be displayed],
  Integer TimeoutS [Max seconds to display the MsgBox, 0 for infinite])

K750: When the dialog quits (either by accept, back, or timeout) the command
      in FBack is called, no matter what's in FNextState.
*******************************************************************************}
procedure TAccessoriesMenu.DlgMsgBox(const Msg: WideString;
  TimeoutS: Integer);
var
  buf: String;
begin
  OpenUI;
  FType := DLG_MSGBOX;
  Log.AddScriptMessage('AccessoriesMenu.DlgMsgBox: Msg="'+Msg+'" TimeoutS='+IntToStr(TimeoutS), lsDebug); // do not localize debug

  if TimeoutS > 0 then begin
    if TimeoutS > 10 then Exception.Create(_('TimeoutS out of range (0-10)'));
    if Form1.IsK750Clone then 
      buf := ',' + IntToStr(TimeoutS * 1000)
    else
      buf := ',' + IntToStr(TimeoutS * 10);
  end
  else
    buf := '';

  if Form1.IsK750Clone then 
    Form1.ScheduleTxAndWait('AT*SELERT="'+WideStringToUTF8String(Copy(Msg,1,160))+'",6,1'+buf) // do not localize
  else 
    Form1.ScheduleTxAndWait('AT*EAID=1,' + IntToStr(FNextState) + ',"' + WideStringToUTF8String(Copy(Msg,1,160)) + '"' + buf); // do not localize

end;

{*******************************************************************************
DlgYesNo(
  WideString Msg   [Text to be displayed],
  WideString Event [Command to receive the value],
  Integer TimeoutS [Max seconds to wait for selection, 0 for infinite])

K750: TimeoutS is ignored
*******************************************************************************}
procedure TAccessoriesMenu.DlgYesNo(const Msg, Event: WideString;
  TimeoutS: Integer);
var
  buf: String;
begin
  OpenUI;
  FType := DLG_YESNO;
  FGeneralEvent := Event;
  Log.AddScriptMessage('AccessoriesMenu.DlgYesNo', lsDebug); // do not localize debug

  if Form1.IsK750Clone then begin
    Form1.ScheduleTxAndWait('AT*SEYNQ="","'+WideStringToUTF8String(Copy(Msg,1,160))+'",1'); // do not localize
  end
  else begin
    buf := '2,' + IntToStr(FNextState) + ',"' + WideStringToUTF8String(Copy(Msg,1,160)) + '"';
    if TimeoutS > 0 then begin
      if TimeoutS > 10 then Exception.Create(_('TimeoutS out of range (0-10)'));
      buf := buf + ',' + IntToStr(TimeoutS * 10);
    end;
    Form1.ScheduleTxAndWait('AT*EAID=' + buf); // do not localize
  end;
end;

{*******************************************************************************
DlgOnOff(
  WideString Title [Text to be displayed],
  WideString Event [Command to receive the value],
  Integer Default  [Initial value (0=Off, 1=On)])
*******************************************************************************}
procedure TAccessoriesMenu.DlgOnOff(const Title, Event: WideString;
  Default: Integer);
var
  buf: String;
begin
  OpenUI;
  FType := DLG_ONOFF;
  FGeneralEvent := Event;
  Log.AddScriptMessage('AccessoriesMenu.DlgOnOff', lsDebug); // do not localize debug

  if Form1.IsK750Clone then begin
    Form1.ScheduleTxAndWait('AT*SEONO="'+WideStringToUTF8String(Copy(Title,1,15))+'",'+IntToStr(Default)+',1'); // do not localize
  end
  else begin
    buf := '3,' + IntToStr(FNextState) + ',"' + WideStringToUTF8String(Copy(Title,1,15)) + '",' + IntToStr(Default);
    Form1.ScheduleTxAndWait('AT*EAID=' + buf); // do not localize
  end;
end;

{*******************************************************************************
DlgPercent(
  WideString Title [Text to be displayed as title],
  WideString Event [Command to receive the value],
  Integer Steps    [Number of steps],
  Integer Pos      [Initial step])

K750: Only final value gets reported.
*******************************************************************************}
procedure TAccessoriesMenu.DlgPercent(const Title, Event: WideString;
  Steps, Pos: Integer);
begin
  OpenUI;
  FType := DLG_PERCENT;
  FPercentSteps := Steps;
  FPercentPos := Pos;
  FGeneralEvent := Event;
  Log.AddScriptMessage('AccessoriesMenu.DlgPercent: Title="'+Title+'" Event="'+Event+'" Steps='+IntToStr(Steps)+' Pos='+IntToStr(Pos), lsDebug); // do not localize debug

  if Form1.IsK750Clone then begin
    Form1.ScheduleTxAndWait('AT*SEGAUGE="'+WideStringToUTF8String(Copy(Title,1,15))+'",2,1,0,'+IntToStr(pos)+','+IntToStr(Steps)); // do not localize
  end
  else begin
    Form1.ScheduleTxAndWait('AT*EAID=' + '4,' + IntToStr(FNextState) + ',"' + WideStringToUTF8String(Copy(Title,1,15)) + '",' + IntToStr(Steps) + ',' + IntToStr(pos)); // do not localize
  end;
end;

{*******************************************************************************
DlgInputStr(
  WideString Title      [Text to be displayed as title],
  WideString Prompt     [Text to be displayed as prompt],
  Integer    MaxLen     [Max length of String],
  WideString DefaultStr [Initial string value],
  WideString Event      [Command to receive the value])
*******************************************************************************}
procedure TAccessoriesMenu.DlgInputStr(const Title, Prompt: WideString; MaxLen: Integer;
  const DefaultStr: WideString; const Event: WideString);
var
  buf: String;
begin
  OpenUI;
  FType := DLG_INPUTSTR;
  FGeneralEvent := Event;
  FInputMax := MaxLen;
  Log.AddScriptMessage('AccessoriesMenu.DlgInputStr: Title="'+Title+'" Prompt="'+Prompt+'" MaxLen='+IntToStr(MaxLen), lsDebug); // do not localize debug

  if Form1.IsK750Clone then begin
    Form1.ScheduleTxAndWait('AT*SESTRI="'+WideStringToUTF8String(Copy(Title,1,15))+'","'+WideStringToUTF8String(Copy(Prompt,1,15))+'","'+WideStringToUTF8String(Copy(Copy(DefaultStr,1,MaxLen),1,100))+'",0,0,1'); // do not localize
  end
  else begin
    buf := '11,' + IntToStr(FNextState) + ',"' + WideStringToUTF8String(Copy(Title,1,15)) + '","' + WideStringToUTF8String(Copy(Prompt,1,15)) + '",' + IntToStr(maxLen) + ',"' + WideStringToUTF8String(Copy(Copy(DefaultStr,1,MaxLen),1,100)) + '"';
    Form1.ScheduleTxAndWait('AT*EAID=' + buf); // do not localize
  end;
end;

{*******************************************************************************
DlgInputInt(
  WideString Title      [Text to be displayed as title],
  WideString Prompt     [Text to be displayed as prompt],
  Integer    MinVal     [Lowest value to be accepted],
  Integer    MaxVal     [Highest value to be accepted],
  Integer    DefaultVal [Initial value])
*******************************************************************************}
procedure TAccessoriesMenu.DlgInputInt(const Title, Prompt: WideString;
  MinVal, MaxVal, DefaultVal: Integer; const event: WideString);
var
  buf: String;
begin
  OpenUI;
  FType := DLG_INPUTINT;
  FGeneralEvent := Event;
  FInputMin := MinVal;
  FInputMax := MaxVal;
  Log.AddScriptMessage('AccessoriesMenu.DlgInputInt: Title="'+Title+'" Prompt="'+Prompt+'" MinVal='+IntToStr(MinVal)+' MaxVal='+IntToStr(MaxVal)+' DefaultVal='+IntToStr(DefaultVal), lsDebug); // do not localize debug

  if Form1.IsK750Clone then begin
    Form1.ScheduleTxAndWait('AT*SESTRI="'+WideStringToUTF8String(Copy(Title,1,15))+'","'+WideStringToUTF8String(Copy(Prompt,1,15))+'","'+IntToStr(DefaultVal)+'",0,2,1'); // do not localize
  end
  else begin
    buf := '7,' + IntToStr(FNextState) + ',"' + WideStringToUTF8String(Copy(Title,1,15)) + '","' + WideStringToUTF8String(Copy(Prompt,1,15)) + '",' + IntToStr(MinVal) + ',' + IntToStr(MaxVal) + ',' + IntToStr(DefaultVal);
    Form1.ScheduleTxAndWait('AT*EAID=' + buf); // do not localize
  end;
end;

{*******************************************************************************
DlgInformation(
  WideString Title [Text to be displayed as title],
  WideString Msg   [Text to be displayed as main message])
*******************************************************************************}
procedure TAccessoriesMenu.DlgInformation(const Title, Msg: WideString);
begin
  OpenUI;
  FType := DLG_INFORMATION;
  Log.AddScriptMessage('AccessoriesMenu.DlgInformation: Title="'+Title+'" Msg="'+Msg+'"', lsDebug); // do not localize debug

  if Form1.IsK750Clone then begin
    Form1.ScheduleTxAndWait('AT*SELERT="'+WideStringToUTF8String(Copy(Msg,1,160))+'",4,1,"'+WideStringToUTF8String(Copy(Title,1,15))+'"'); // do not localize
  end
  else begin
    Form1.ScheduleTxAndWait('AT*EAID=14,' + IntToStr(FNextState) + ',"' + WideStringToUTF8String(Copy(Title,1,15)) + '","' + WideStringToUTF8String(Copy(Msg,1,160)) + '"'); // do not localize
  end;
end;

{*******************************************************************************
DlgFeedback(
  WideString Title [Text to be displayed],
  WideString Event [Command])

K750: To be compatible to T610, the command is never called, even if user
      pushes Accept.
*******************************************************************************}
procedure TAccessoriesMenu.DlgFeedback(const Title, event: WideString);
begin
  OpenUI;
  FType := DLG_FEEDBACK;
  FGeneralEvent := Event;
  Log.AddScriptMessage('AccessoriesMenu.DlgFeedback: Title="'+Title+'" Event="'+event+'"', lsDebug); // do not localize debug

  if Form1.IsK750Clone then begin
    Form1.ScheduleTxAndWait('AT*SELERT="'+WideStringToUTF8String(Copy(Title,1,15))+'",6,1'); // do not localize
  end
  else begin
    Form1.ScheduleTxAndWait('AT*EAID=13,' + IntToStr(FNextState) + ',"' + WideStringToUTF8String(Copy(Title,1,15)) + '"'); // do not localize
  end;
end;

{*******************************************************************************
OpenUI()  [Opens an UI session]
*******************************************************************************}
procedure TAccessoriesMenu.OpenUI;
begin
  if Form1.IsK750Clone and not FUIOpen and Form1.FConnected then
    Form1.TxAndWait('AT*SEUIS=1'); // do not localize
  FUIOpen:=True;
end;

{*******************************************************************************
CloseUI() [Closes an UI session]
*******************************************************************************}
procedure TAccessoriesMenu.CloseUI;
begin
  if Form1.IsK750Clone and FUIOpen and Form1.FConnected then
    Form1.TxAndWait('AT*SEUIS=0'); // do not localize
  FUIOpen:=False;
end;

destructor TAccessoriesMenu.Destroy;
begin
  Log.AddScriptMessage('AccessoriesMenu.Destroy', lsDebug); // do not localize debug
  FreeAndNil(FMenuList);
  FreeAndNil(FEventList);
  inherited;
end;

procedure TAccessoriesMenu.Initialize;
begin
  inherited;
  Log.AddScriptMessage('AccessoriesMenu.Initialize', lsDebug); // do not localize debug
  FMenuList := TTntStringList.Create;
  FEventList := TTntStringList.Create;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TAccessoriesMenu, Class_AccessoriesMenu,
    ciMultiInstance, tmApartment);
end.
