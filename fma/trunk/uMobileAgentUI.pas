unit uMobileAgentUI;

{
*******************************************************************************
* Descriptions: COM/Script Interface implementation
* $Source: /cvsroot/fma/fma/uMobileAgentUI.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uMobileAgentUI.pas,v $
*
*******************************************************************************
}

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  gnugettext, gnugettexthelpers,
  ComObj, ActiveX, MobileAgent_TLB, StdVcl, Classes, TntClasses, Menus, TntMenus, ExtCtrls, TntExtCtrls;

type
  TMobileAgentApp = class(TAutoObject, IMobileAgentApp)
  private
    sl: TStrings;
    tl: TStrings;
    rootMenu: TTntMenuItem;
    ScriptGnuGettextInstance: TGnuGettextInstance;
  protected
    procedure AddCmd(const label_, event: WideString); safecall;
    procedure Connect; safecall;
    procedure Disconnect; safecall;
    procedure Exit; safecall;
    function Get_KeyPress: WideString; safecall;
    function Get_PopKey: WideString; safecall;
    procedure Debug(const str: WideString); safecall;
    procedure ClearKey; safecall;
    procedure Status(const Str: WideString); safecall;
    procedure Minimize; safecall;
    procedure Restore; safecall;
    procedure Set_KeyInActivityTimeout(Value: Integer); safecall;
    procedure Transmit(const Cmd: WideString); safecall;
    function Get_Connected: Integer; safecall;
    function Get_LookupByNumber(const Number: WideString): WideString; safecall;
    function Get_Received: WideString; safecall;
    procedure SentMessage(const Msg, DestNo: WideString; ReqReply, Flash, StatusReq: Smallint); safecall;
    procedure ObexPut(const filename: WideString); safecall;
    procedure VoiceAnswer; safecall;
    procedure VoiceCall(const Number: WideString); safecall;
    procedure VoiceHangUp; safecall;
    function ObexGetObj(const filename, objecturl: WideString): HResult; safecall;
    function ObexPutObj(const filename, objecturl: WideString): HResult; safecall;
    function ObexGet(const filename, objectname: WideString): HResult; safecall;
    procedure ObexDelete(const objectname: WideString); safecall;
    function ObexCut(const filename, objectname: WideString): HResult; safecall;
    procedure AddTimer(msec: Integer; const event: WideString); safecall;
    procedure DeleteTimer(const event: WideString); safecall;
    procedure EnableKeyMonitor; safecall;
    procedure DisableKeyMonitor; safecall;
    procedure ScriptCall(const Code: WideString); safecall;
    procedure Sleep(msec: Integer); safecall;
    function Get_PhoneType(const Number: WideString): WideString; safecall;
    procedure DisconnectTemporary; safecall;
    function dGetText(const Domain, szMsgId: WideString): WideString; safecall;
    function dnGetText(const Domain, Singular, Plural: WideString; Number: Integer): WideString; safecall;
    function GetCurrentLocale: WideString; safecall;
    function Get_PhoneModel: WideString; safecall;
    procedure AddTip(const atip: WideString; atimeoutsecs: Integer; ashownow: Smallint); safecall;
    procedure ClearTips; safecall;
    procedure AddBaloon(const atext: WideString; atimeoutsecs: Integer); safecall;
    procedure HideBaloon; safecall;
    function Get_MobileAgentFolder: WideString; safecall;
    function Get_ScriptFolder: WideString; safecall;
    function PhoneDecode(aText: OleVariant): WideString; safecall;
    function PhoneEncode(const aText: WideString): OleVariant; safecall;
    function Get_isT610clone: WordBool; safecall;
    function Get_isK750clone: WordBool; safecall;
    function Get_isK750orBetter: WordBool; safecall;
  public
    procedure Initialize; override;
    destructor Destroy; override;
    procedure MenuClicked(Sender: TObject);
    procedure TimerEvent(Sender: TObject);
  end;

implementation

uses
  cUnicodeCodecs,
  ComServ, Unit1, SysUtils, TntSysUtils, Dialogs, TntDialogs, uObex,
  uSyncPhonebook, uLogger, uThreadSafe, uWelcome;

const
  rootCount: integer = 0;

procedure TMobileAgentApp.AddCmd(const label_, event: WideString);
var
  menuItem: TTntMenuItem;
begin
  if Assigned(rootMenu) then begin
    menuItem := TTntMenuItem.Create(Form1.MainMenu1);
    menuItem.Caption := label_;
    menuItem.Tag := sl.Count;
    menuItem.OnClick := MenuClicked;
    rootMenu.Add(menuItem);
    rootMenu.Enabled := True;
  end;
  sl.Add(IntToStr(sl.Count) + '=' + event);
end;

procedure TMobileAgentApp.Initialize;
var
  SaveExecutableFilename: String;
begin
  inherited;
  sl := TStringList.Create;
  tl := TStringList.Create;

  with Form1.MainMenu1 do begin
    rootMenu := Form1.MyMenu1;
    rootMenu.Enabled := False;
    if rootCount = 0 then rootCount := rootMenu.Count;
  end;

  SaveExecutableFilename := ExecutableFilename;
  ExecutableFilename := Form1.ScriptFilename;
  ScriptGnuGettextInstance := TGnuGettextInstance.Create;
  ScriptGnuGettextInstance.textdomain(getcurrenttextdomain);
  ScriptGnuGettextInstance.UseLanguage(GetCurrentLanguage);
  ExecutableFilename := SaveExecutableFilename;
end;

procedure TMobileAgentApp.MenuClicked(Sender: TObject);
var
  tag: Integer;
  cmd: String;
begin
  tag := (Sender as TTntMenuItem).Tag;
  cmd := sl.Values[IntToStr(tag)];

  Form1.CallScriptMethod(cmd,[]);
end;

procedure TMobileAgentApp.Connect;
begin
  Form1.ActionConnectionConnect.Execute;
end;

procedure TMobileAgentApp.Disconnect;
begin
  Form1.ActionConnectionDisconnect.Execute;
end;

procedure TMobileAgentApp.Exit;
begin
  Form1.ActionExit.Execute;
end;

function TMobileAgentApp.Get_KeyPress: WideString;
begin
  Result := Form1.FKeyActivity;
end;

function TMobileAgentApp.Get_PopKey: WideString;
begin
  Result := Copy(Form1.FKeyActivity, length(Form1.FKeyActivity), 1);
  Form1.FKeyActivity := Copy(Form1.FKeyActivity, 1, length(Form1.FKeyActivity) - 1);
end;

procedure TMobileAgentApp.EnableKeyMonitor;
begin
  Form1.EnableKeyMonitor(True);
end;

procedure TMobileAgentApp.Debug(const str: WideString);
begin
  Log.AddScriptMessage('[Script] ' + str, lsDebug); // do not localize debug
end;

procedure TMobileAgentApp.ClearKey;
begin
  Form1.FKeyActivity := '';
end;

procedure TMobileAgentApp.Status(const Str: WideString);
begin
  Form1.Status(Str);
end;

procedure TMobileAgentApp.Minimize;
begin
  Form1.MinimizeApp;
end;

procedure TMobileAgentApp.Restore;
begin
  Form1.ActionWindowRestore.Execute;
end;

procedure TMobileAgentApp.Set_KeyInActivityTimeout(Value: Integer);
begin
  Log.AddScriptMessage('KeyInactivityTimeout set to ' + IntToStr(Value) + 'ms', lsDebug); // do not localize debug
  Form1.FKeyInactivityTimeout := Value;
end;

procedure TMobileAgentApp.Transmit(const Cmd: WideString);
begin
  Form1.ScheduleTxAndWait(WideStringToUTF8String(Cmd));
end;

function TMobileAgentApp.Get_Connected: Integer;
begin
  if Form1.FConnected then Result := 1
  else Result := 0;
end;

function TMobileAgentApp.Get_LookupByNumber(
  const Number: WideString): WideString;
begin
  Result := Form1.LookupContact(Number);
end;

function TMobileAgentApp.Get_Received: WideString;
begin
  Result := ThreadSafe.RxBuffer.Text;
end;

procedure TMobileAgentApp.SentMessage(const Msg, DestNo: WideString;
  ReqReply, Flash, StatusReq: Smallint);
var
  AReqReply, AFlash, AStatusReq: Boolean;
begin
  if ReqReply = 0 then AReqReply := False
  else AReqReply := True;

  if Flash = 0 then AFlash := False
  else AFlash := True;

  if StatusReq = 0 then AStatusReq := False
  else AStatusReq := True;

  // TODO: fix for sending long messages
  Form1.SendTextMessage('', Msg, DestNo, AReqReply, AFlash, AStatusReq);
end;

procedure TMobileAgentApp.ObexPut(const filename: WideString);
begin
  Form1.ObexPutFile(filename);
end;

procedure TMobileAgentApp.VoiceAnswer;
begin
  Form1.VoiceAnswer;
end;

procedure TMobileAgentApp.VoiceCall(const Number: WideString);
begin
  Form1.VoiceCall(Number);
end;

procedure TMobileAgentApp.VoiceHangUp;
begin
  Form1.VoiceHangUp;
end;

function TMobileAgentApp.ObexGetObj(const filename,
  objecturl: WideString): HResult;
var
  fs: TFileStream;
begin
  Result := 0; // error
  try
    fs := TFileStream.Create(filename,fmCreate);
    try
      with Form1 do begin
        ObexConnect;
        try
          ObexGetObject(objecturl,TStream(fs));
        finally
          ObexDisconnect;
        end;
      end;
      Result := 1;
    finally
      fs.Free;
    end;
  except
  end;  
end;

function TMobileAgentApp.ObexPutObj(const filename,
  objecturl: WideString): HResult;
var
  fs: TFileStream;
begin
  Result := 0; // error
  try
    fs := TFileStream.Create(filename,fmOpenRead);
    try
      with Form1 do begin
        ObexConnect;
        try
          ObexPutObject(objecturl,fs);
        finally
          ObexDisconnect;
        end;
      end;
      Result := 1;
    finally
      fs.Free;
    end;
  except
  end;  
end;

function TMobileAgentApp.ObexGet(const filename,
  objectname: WideString): HResult;
begin
  Result := 0; // error
  try
    Form1.ObexGetFile(filename,objectname,True);
    Result := 1;
  except
  end;
end;

procedure TMobileAgentApp.ObexDelete(const objectname: WideString);
begin
  Form1.ObexPutFile(objectname,True,True);
end;

function TMobileAgentApp.ObexCut(const filename,
  objectname: WideString): HResult;
begin
  with Form1 do begin
    RequestConnection;
    ObexConnect(ObexFolderBrowserServiceID);
    try
      FObex.GetFile(filename,objectname,True);
      ObexPutFile(objectname,True,True);
    finally
      ObexDisconnect;
    end;
  end;
end;

procedure TMobileAgentApp.AddTimer(msec: Integer; const event: WideString);
var
  timer: TTimer;
begin
  DeleteTimer(event);
  timer := TTimer.Create(nil);
  timer.OnTimer := TimerEvent;
  timer.Interval := msec;
  tl.AddObject(event,timer);
end;

procedure TMobileAgentApp.TimerEvent(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to tl.Count-1 do
    if tl.Objects[i] = Sender then
    try
      with Sender as TTimer do
      try
        Enabled := False;
        Form1.CallScriptMethod(tl[i], []);
      finally
        { check if the timer is deleted within CallScriptMethod - reported by mhr }
        if (i < tl.Count) and (tl.Objects[i] = Sender) then
          Enabled := True;
      end;
      break;
    except
      on e: Exception do Log.AddScriptMessage(e.Message, lsDebug);
    end;
end;

procedure TMobileAgentApp.DeleteTimer(const event: WideString);
var
  i: Integer;
begin
  for i := 0 to tl.Count-1 do
    if WideCompareText(tl[i],event) = 0 then begin
      with tl.Objects[i] as TTimer do begin
        Enabled := False;
        Free;
      end;
      tl.Delete(i);
      break;
    end;
end;

destructor TMobileAgentApp.Destroy;
var
  i: Integer;
begin
  { Remove Timer events }
  for i := tl.Count-1 downto 0 do DeleteTimer(tl[i]);
  { Remove Main menu entries }
  if Assigned(rootMenu) then begin
    for i := rootMenu.Count-1 downto rootCount do rootMenu[i].Free;
    rootMenu.Enabled := False;
  end;
  ScriptGnuGettextInstance.Free;

  sl.Free;
  tl.Free;

  inherited;
end;

procedure TMobileAgentApp.DisableKeyMonitor;
begin
  Form1.DisableKeyMonitor(True);
end;

procedure TMobileAgentApp.ScriptCall(const Code: WideString);
begin
  Form1.ScriptControl.CallFunction(__fma_objcall,[Code]);
end;

procedure TMobileAgentApp.Sleep(msec: Integer);
begin
  WaitASec(msec,True);
end;

function TMobileAgentApp.Get_PhoneType(
  const Number: WideString): WideString;
var
  contact: PContactData;
  FullName: WideString;
begin
  Result := ''; // unknown
  if Form1.IsIrmcSyncEnabled then begin
    FullName := Form1.LookupContact(Number);
    if (FullName <> '') and Form1.frmSyncPhonebook.FindContact(FullName,contact) then
      Result := GetContactPhoneType(contact,Number);
  end;
end;

procedure TMobileAgentApp.DisconnectTemporary;
begin
  Form1.DoDisconnectTemporary;
end;

function TMobileAgentApp.dGetText(const Domain, szMsgId: WideString): WideString;
begin
  if Domain='' then
    begin
      Result := ScriptGnuGettextInstance.gettext(szMsgId);
      if Result=szMsgId then Result := ScriptGnuGettextInstance.dgettext('common',szMsgId);
      if Result=szMsgId then Result := gnugettext.gettext(szMsgId);
    end
  else
    begin
      Result := ScriptGnuGettextInstance.dgettext(Domain, szMsgId);
      if Result=szMsgId then Result := ScriptGnuGettextInstance.dgettext('common',szMsgId);
      if Result=szMsgId then Result := gnugettext.dgettext(Domain, szMsgId);
    end;
end;

function TMobileAgentApp.dnGetText(const Domain, Singular, Plural: WideString; Number: Integer): WideString;
var
  org, trans: WideString;
begin
  if Domain='' then
    begin
      org := Singular+#0+Plural;
      trans := ScriptGnuGettextInstance.gettext(org);
      if org<>trans then
        Result := ScriptGnuGettextInstance.ngettext(Singular, Plural, Number)
      else
        begin
          trans := ScriptGnuGettextInstance.dgettext('common', org);
          if org<>trans then
            Result := ScriptGnuGettextInstance.dngettext('common', Singular, Plural, Number)
          else
            Result := gnugettext.ngettext(Singular, Plural, Number);
        end;
    end
  else
    begin
      org := Singular+#0+Plural;
      trans := ScriptGnuGettextInstance.dgettext(Domain, org);
      if org<>trans then
        Result := ScriptGnuGettextInstance.dngettext(Domain, Singular, Plural, Number)
      else
        begin
          if org<>trans then
            Result := ScriptGnuGettextInstance.dngettext('common', Singular, Plural, Number)
          else
            Result := gnugettext.dngettext(Domain, Singular, Plural, Number);
        end;
    end;
end;

function TMobileAgentApp.GetCurrentLocale: WideString;
begin
  Result := ScriptGnuGettextInstance.GetCurrentLanguage;
end;

function TMobileAgentApp.Get_PhoneModel: WideString;
begin
  Result := Form1.PhoneModel; // was... StatusBar.Panels[1].Text; // yuck!!!
end;

procedure TMobileAgentApp.AddTip(const atip: WideString;
  atimeoutsecs: Integer; ashownow: Smallint);
begin
  frmWelcomeTips.QueueTip(atip, atimeoutsecs, ashownow <> 0);
  if Form1.IsStartCompleted and not frmWelcomeTips.Visible then
    frmWelcomeTips.Show;
end;

procedure TMobileAgentApp.ClearTips;
begin
  frmWelcomeTips.ClearQueue;
end;

procedure TMobileAgentApp.AddBaloon(const atext: WideString;
  atimeoutsecs: Integer);
var
  s: String;
begin
  { TODO: Add unicode support }
  s := atext;
  Form1.ShowBaloonInfo(s,atimeoutsecs);
end;

procedure TMobileAgentApp.HideBaloon;
begin
  Form1.CoolTrayIcon1.HideBalloonHint;
end;

function TMobileAgentApp.Get_MobileAgentFolder: WideString;
begin
  Result := ExePath; //ExtractFilePath(Application.ExeName);
end;

function TMobileAgentApp.Get_ScriptFolder: WideString;
begin
  Result := ExtractFilePath(Form1.ScriptFilename); // yuck!!! yuck!!!
end;

function TMobileAgentApp.PhoneDecode(aText: OleVariant): WideString;
begin
  Result := UTF8StringToWideString(aText); // If phone is set to <>UTF-8 encoding, then this function must use diferent decode method
end;

function TMobileAgentApp.PhoneEncode(const aText: WideString): OleVariant;
begin
  Result := WideStringToUTF8String(aText); // If phone is set to <>UTF-8 encoding, then this function must use diferent encode method 
end;

function TMobileAgentApp.Get_isT610clone: WordBool;
begin
  Result := Form1.IsT610Clone;
end;

function TMobileAgentApp.Get_isK750clone: WordBool;
begin
  Result := Form1.IsK750Clone;
end;

function TMobileAgentApp.Get_isK750orBetter: WordBool;
begin
  Result := Form1.IsK750orBetter; // K750 or better
end;

initialization
  TAutoObjectFactory.Create(ComServer, TMobileAgentApp, Class_MobileAgentApp,
    ciMultiInstance, tmSingle);
end.
