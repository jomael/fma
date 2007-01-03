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
  DLG_LIST_1      = $0b;
  DLG_LIST_N      = $0c;
  DLG_INPUTERR    = $80;

type
  TAccessoriesMenu = class(TAutoObject, IAccessoriesMenu)
  private
    FTitle: WideString;
    FMenuList: TTntStrings;
    FMenuListOptions: TStrings;
    FUIOpen: Boolean;
    function UseSEcommands: Boolean;
  protected
    { Protected declarations }
    procedure Init; safecall;
    procedure Clear; safecall;
    procedure AddItem(const Caption, Event: WideString); safecall;
    procedure AddItemEx(const Caption: WideString; Disabled, Selected, CanDelete: WordBool; ImgIndex: Integer; const Event: WideString); safecall;
    procedure Set_MenuType(Value: Integer); safecall;
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
    property SessionOpened: boolean read FUIOpen;
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
    if UseSEcommands then begin
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
  FMenuListOptions.Add('0,0,0,0');
  FEventList.Add(Event);
end;

procedure TAccessoriesMenu.AddItemEx(const Caption: WideString; Disabled, Selected, CanDelete: WordBool; ImgIndex: Integer; const Event: WideString);
var
  s: string;
begin
  if Disabled and (not UseSEcommands) then Exit;
  FMenuList.Add(Caption);
  s := IntToStr(ImgIndex) + ',';
  if Disabled then
    s := s + '1,'
  else
    s := s + '0,';
  if Selected then
    s := s + '1,'
  else
    s := s + '0,';
  if CanDelete then
    s := s + '1'
  else
    s := s + '0';
  FMenuListOptions.Add(s);
  FEventList.Add(Event);
end;

procedure TAccessoriesMenu.Set_MenuType(Value: Integer);
begin
  if Value <= DLG_LIST_N then
    FType := Value;
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
  if FType and $0f < DLG_SUBMENU then
    FType := DLG_SUBMENU;
  Log.AddScriptMessage('AccessoriesMenu.Update', lsDebug); // do not localize debug

  if UseSEcommands then begin
    Com := 'AT*SELIST="' + WideStringToUTF8String(FTitle) + '",'; // do not localize
    if FType = DLG_LIST_1 then
      Com := Com + '1,'
    else if FType = DLG_LIST_N then
      Com := Com + '2,'
    else
      Com := Com + '3,';
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
    if UseSEcommands then
      TempBuf := ',"' + TempBuf + '",' + FMenuListOptions[i]
    else
      TempBuf := ',"' + TempBuf + '"';

    // Check if AT command is not too long
    if ((ComLen + Length(Buf) + Length(TempBuf)) > 200) and not UseSEcommands then begin
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
  if UseSEcommands then
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
  FType := DLG_SUBMENU;
  FMenuList.Clear;
  FMenuListOptions.Clear;
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

  if UseSEcommands then begin
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
    if UseSEcommands then
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
    if UseSEcommands then
      buf := ',' + IntToStr(TimeoutS * 1000)
    else
      buf := ',' + IntToStr(TimeoutS * 10);
  end
  else
    buf := '';

  if UseSEcommands then 
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

  if UseSEcommands then begin
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

  if UseSEcommands then begin
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

  if UseSEcommands then begin
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

  if UseSEcommands then begin
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

  if UseSEcommands then begin
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

  if UseSEcommands then begin
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

  if UseSEcommands then begin
    Form1.ScheduleTxAndWait('AT*SEGAUGE="'+WideStringToUTF8String(Copy(Title,1,15))+'",0,1,0'); // do not localize
    //Form1.ScheduleTxAndWait('AT*SELERT="'+WideStringToUTF8String(Copy(Title,1,15))+'",6,1'); // do not localize
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
  if UseSEcommands and not FUIOpen and Form1.FConnected then
    Form1.TxAndWait('AT*SEUIS=1'); // do not localize
  FUIOpen:=True;
end;

{*******************************************************************************
CloseUI() [Closes an UI session]
*******************************************************************************}
procedure TAccessoriesMenu.CloseUI;
begin
  if UseSEcommands and FUIOpen and Form1.FConnected then
    Form1.TxAndWait('AT*SEUIS=0'); // do not localize
  FUIOpen:=False;
end;

destructor TAccessoriesMenu.Destroy;
begin
  Log.AddScriptMessage('AccessoriesMenu.Destroy', lsDebug); // do not localize debug
  FreeAndNil(FMenuList);
  FreeAndNil(FMenuListOptions);
  FreeAndNil(FEventList);
  inherited;
end;

procedure TAccessoriesMenu.Initialize;
begin
  inherited;
  Log.AddScriptMessage('AccessoriesMenu.Initialize', lsDebug); // do not localize debug
  FMenuList := TTntStringList.Create;
  FMenuListOptions := TStringList.Create;
  FEventList := TTntStringList.Create;
end;

function TAccessoriesMenu.UseSEcommands: Boolean;
begin
  Result := Form1.IsK750orBetter; // K750 or better
end;

initialization
  TAutoObjectFactory.Create(ComServer, TAccessoriesMenu, Class_AccessoriesMenu,
    ciMultiInstance, tmApartment);
end.
