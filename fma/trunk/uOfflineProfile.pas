unit uOfflineProfile;

{
*******************************************************************************
* Descriptions: Manage phone profiles dialog
* $Source: /cvsroot/fma/fma/uOfflineProfile.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uOfflineProfile.pas,v $
* Revision 1.3.2.7  2006/04/07 21:07:32  z_stoichev
* Added Profile Password Protection.
*
* Revision 1.3.2.6  2006/03/16 20:16:44  z_stoichev
* - Fixed Switch Database (Database Manager) implementation.
* - Fixed Relocate old database to Application Data folder.
* - Fixed Manage, Delete and Relocate phone profile changes.
* - Fixed Set friendly name once in Getting Started wizard.
* - Added Set default K750 clones settings for new phones.
* - Added Check OBEX compatability on Getting Started finish.
* - Added Show currentlly opened phone name in Caption.
* - Added New profiles database unique ID by phone name.
*
*
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, StdCtrls, TntStdCtrls, ComCtrls, TntComCtrls, UniTntCtrls, IniFiles,
  ExtCtrls, TntExtCtrls;

const
  DefaultProfileName = 'default.tmp'; // do not localize  

type
  TfrmOfflineProfile = class(TTntForm)
    TntListView1: TTntListView;
    btnOK: TTntButton;
    btnCancel: TTntButton;
    btnDelete: TTntButton;
    btnNew: TTntButton;
    btnRepair: TTntButton;
    NoItemsPanel: TTntPanel;
    TntLabel1: TTntLabel;
    btnProtect: TTntButton;
    procedure TntListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure TntListView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnDeleteClick(Sender: TObject);
    procedure TntListView1DblClick(Sender: TObject);
    procedure btnRepairClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure TntFormShow(Sender: TObject);
    procedure btnProtectClick(Sender: TObject);
  private
    { Private declarations }
    procedure RefreshView;
  public
    { Public declarations }
    function SelectedProfile: string;
    function ProfileExists(PhoneName: WideString): boolean;
    function GetPhoneProfile(PhoneName: WideString; ExceptID: String = ''): string;
  end;

var
  frmOfflineProfile: TfrmOfflineProfile;

implementation

uses
  gnugettext, gnugettexthelpers, cUnicodeCodecs,
  uGlobal, Unit1, uDialogs, uAbout, uPassword;

resourcestring
  dbLocationOld = 'Antiquated';

{$R *.dfm}

procedure TfrmOfflineProfile.TntListView1SelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  btnDelete.Enabled := Selected and (WideCompareStr(TntListView1.Selected.SubItems[0],dbLocationOld) <> 0);
  btnRepair.Enabled := btnDelete.Enabled;
  btnProtect.Enabled := Selected and (WideCompareStr(TntListView1.Selected.SubItems[1],Form1.PhoneIdentity) = 0);
  btnOK.Enabled := btnDelete.Enabled or (Selected and FindCmdLineSwitch('MIGRATEDB')); // do not localize
  btnOK.Default := btnOK.Enabled;
end;

procedure TfrmOfflineProfile.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);
{$IFDEF VER150}
  NoItemsPanel.ParentBackground := False;
{$ENDIF}
  TntLabel1.Caption := WideFormat(_('The "%s" format note:'), [dbLocationOld]);
  if FindCmdLineSwitch('MIGRATEDB') then // do not localize
    TntLabel1.Caption := TntLabel1.Caption + ' ' +
    _('Once you Open such databases you will be asked to Relocate, which will update its format to the latest one.')
  else
    TntLabel1.Caption := TntLabel1.Caption + ' ' +
    _('You can''t Open such databases until you restart FMA with "-MIGRATEDB" command line switch (without quotes).');
  RefreshView;
end;

function TfrmOfflineProfile.SelectedProfile: string;
begin
  if TntListView1.Selected <> nil then
    Result := TntListView1.Selected.SubItems[1]
  else
    Result := '';
end;

procedure TfrmOfflineProfile.TntListView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) and btnOK.Enabled then
    btnOK.Click;
  if (Key = VK_DELETE) and btnDelete.Enabled then
    btnDelete.Click;
end;

procedure TfrmOfflineProfile.RefreshView;
var
  R: TSearchRec;
  s: WideString;
  d: Integer;
  procedure SearchProfilesIn(Dir: string; IsOld: boolean);
    function GetDefName: WideString;
    begin
      if WideCompareText(R.Name,Form1.PhoneIdentity) <> 0 then
        Result := _('Unknown')
      else
        Result := GetToken(GetBuildVersionDtl,0,' ');
    end;
  begin
    if FindFirst(Dir+'*.*',faDirectory,R) = 0 then
    try
      repeat
        if (R.Name <> '') and (R.Name[1] <> '.') and DirectoryExists(Dir+R.Name+'\dat') and // do not localize
          FileExists(Dir+R.Name+'\dat\Phone.dat') and (WideCompareText(R.Name,DefaultProfileName) <> 0) then begin // do not localize
          with TntListView1.Items.Add do begin
            Caption := R.Name;
            if IsOld then begin
              ImageIndex := 29;
              SubItems.Add(dbLocationOld);
            end
            else begin
              ImageIndex := 28;
              //SubItems.Add(GetDefName); // DB Format
              SubItems.Add('');
            end;
            SubItems.Add(R.Name); // Profile ID
            Selected := AnsiCompareText(R.Name,Form1.PhoneIdentity) = 0;
            Focused := Selected;
            try
              with TIniFile.Create(Dir+R.Name+'\dat\Phone.dat') do // do not localize
                try
                  s := ReadString('Global','PhoneName',''); // do not localize
                  if s <> '' then Caption := s;
                  if not IsOld then begin
                    d := StrToInt(ReadString('Global','Modified','0')); // do not localize
                    if d <> 0 then SubItems[0] := DateToStr(d); // do not localize
                    //s := UTF8StringToWideString(ReadString('Global','DBVersion','')); // do not localize
                    //if s <> '' then SubItems[0] := WideFormat('FMA %s',[s]);
                  end;
                finally
                  Free;
                end;
            except
            end;
            SubItems.Add(Caption);
            if Selected then
              Caption := WideFormat('%s (active)',[Caption]);
          end;
        end;
      until FindNext(R) <> 0;
    finally
      FindClose(R);
    end;
  end;
begin
  TntListView1.Items.Clear;
  btnOK.Enabled := False;
  btnDelete.Enabled := False;
  NoItemsPanel.Visible := False;
  SearchProfilesIn(ExePath+'data\',True); // do not localize
  SearchProfilesIn(Form1.GetAppDataPath+'FMA\',False); // do not localize
  NoItemsPanel.Visible := TntListView1.Items.Count = 0;
end;

procedure TfrmOfflineProfile.btnDeleteClick(Sender: TObject);
begin
  MessageBeep(MB_ICONQUESTION);
  if MessageDlgW(_('Delete current profile. ALL PROFILE DATA WILL BE LOST! Do you wish to continue?'),
    mtConfirmation, MB_YESNO or MB_DEFBUTTON2) = ID_YES then
    try
      Enabled := False;
      { Are we deleting current profile? }
      if AnsiCompareStr(SelectedProfile,Form1.PhoneIdentity) = 0 then begin
        { Yes, is the phone connected? }
        if Form1.FConnected then
          if MessageDlgW(_('Phone will be disconnected. Do you wish to continue?'),
            mtConfirmation, MB_YESNO or MB_DEFBUTTON2) = ID_YES then
            { Disconnect it }
            Form1.ActionConnectionDisconnect.Execute
          else
            exit;
        Form1.DeletePhoneDataFiles(SelectedProfile,Handle);
        Form1.ClearExplorerViews;
      end
      else
        Form1.DeletePhoneDataFiles(SelectedProfile,Handle);
    finally
      Enabled := True;
      NoItemsPanel.Visible := TntListView1.Items.Count = 0;
      RefreshView;
    end;
end;

procedure TfrmOfflineProfile.TntListView1DblClick(Sender: TObject);
begin
  if btnOK.Enabled then btnOK.Click;
end;

procedure TfrmOfflineProfile.btnRepairClick(Sender: TObject);
begin
  MessageBeep(MB_ICONQUESTION);
  if MessageDlgW(_('Perform database checks and repair if necessarily. Do you wish to continue (No Undo)?'),
    mtConfirmation,MB_YESNO or MB_DEFBUTTON2) = ID_YES then
    ModalResult := mrRetry;
end;

procedure TfrmOfflineProfile.btnNewClick(Sender: TObject);
begin
  {
  if MessageDlgW(_('Cancel this dialog and open Getting Started wizard?'),
    mtInformation, MB_OKCANCEL) = ID_OK then
    }
    ModalResult := mrIgnore;
end;

function TfrmOfflineProfile.ProfileExists(PhoneName: WideString): boolean;
var
  i: Integer;
begin
  Result := False;
  RefreshView;
  for i := 0 to TntListView1.Items.Count-1 do
    if WideCompareText(PhoneName,TntListView1.Items[i].Caption) = 0 then begin
      Result := True;
      break;
    end;
end;

function TfrmOfflineProfile.GetPhoneProfile(PhoneName: WideString; ExceptID: String): string;
var
  i: Integer;
begin
  Result := '';
  RefreshView;
  for i := 0 to TntListView1.Items.Count-1 do
    if (WideCompareText(ExceptID,TntListView1.Items[i].SubItems[1]) <> 0) and
      (WideCompareText(PhoneName,TntListView1.Items[i].Caption) = 0) then begin
      Result := TntListView1.Items[i].SubItems[1];
      break;
    end;
end;

procedure TfrmOfflineProfile.TntFormShow(Sender: TObject);
begin
  TntListView1.SetFocus;
end;

procedure TfrmOfflineProfile.btnProtectClick(Sender: TObject);
var
  Fullpath: string;
  AName,Pass1,Pass2: WideString;
  Changed: Boolean;
begin
  Changed := False;
  Fullpath := Form1.GetProfilePath(Form1.PhoneIdentity) + 'dat\Phone.dat';
  if FileExists(Fullpath) then
    with TIniFile.Create(Fullpath) do // do not localize
    try
      Pass1 := BaseDecode(ReadString('Global','PhoneLock','')); // do not localize
      AName := UTF8StringToWideString(ReadString('Global','PhoneName','')); // do not localize
      frmPassword := TfrmPassword.Create(nil);
      try
        Pass2 := Pass1;
        if frmPassword.NewPassModal(AName,Pass2) = mrOk then begin
          { is password removed or set? }
          if (Pass1 <> '') or (Pass2 <> '') then begin
            { confirm changes only if password removed }
            if (Pass2 <> '') or // password set
              (MessageDlgW(_('Going to remove Password Protection from this Profile?'),
              mtInformation,MB_YESNO) = ID_YES) then begin
              { update DB }
              WriteString('Global','PhoneLock',BaseEncode(Pass2)); // do not localize
              Changed := True;
            end;
          end
          else
            MessageDlgW(_('Nothing has changed.'),mtInformation,MB_OK)
        end;
      finally
        FreeAndNil(frmPassword);
      end;
    finally
      Free;
    end;
  if Changed then
    if Pass2 <> '' then
      MessageDlgW(_('Your password has been changed successfully.'),mtInformation,MB_OK)
    else
      MessageDlgW(_('Your password has been removed successfully.'),mtInformation,MB_OK);
end;

end.
