unit uMissedCalls;

{
*******************************************************************************
* Descriptions: Missed calls list and count.
* $Source: /cvsroot/fma/fma/uMissedCalls.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uMissedCalls.pas,v $
* Revision 1.8.2.2  2006/01/16 11:26:56  mhr3
* Form1.Explorer -> Form1.ExplorerNew
*
* Revision 1.8.2.1  2005/12/09 13:29:20  z_stoichev
* - Fixed Update missed calls when minimized.
* - Added Notification icon for missing calls.
* - Added Notification icon for new messages.
*
* Revision 1.8  2005/02/08 15:38:52  voxik
* Merged with L10N branch
*
* Revision 1.7.12.2  2004/10/25 20:21:46  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.7.12.1  2004/10/19 19:48:38  expertone
* Add localization (gnugettext)
*
* Revision 1.7  2004/06/29 12:37:07  z_stoichev
* New message window renamed
*
* Revision 1.6  2004/06/15 13:03:27  z_stoichev
* Missed calls fixes.
*
* Revision 1.5  2004/04/01 15:06:47  z_stoichev
* unknown contact support
*
* Revision 1.4  2004/03/26 18:37:39  z_stoichev
* Build 0.1.0.35 RC5
*
* Revision 1.3  2003/11/28 09:38:07  z_stoichev
* Merged with branch-release-1-1 (Fma 0.10.28c)
*
* Revision 1.2.2.5  2003/11/21 16:05:48  z_stoichev
* Added Add contact option for unknown numbers.
* List view is not cleared when clear list check is on.
* GUI changes.
*
*
*
*******************************************************************************
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, StdCtrls, TntStdCtrls, ExtCtrls, TntExtCtrls, ComCtrls, TntComCtrls, UniTntCtrls, Menus, TntMenus;

resourcestring
  sUnknownNumber = 'Unknown Number';    // no number, no stored contact
  sUnknownContact = 'Unknown Contact';  // known number, no stored contact
                                        // known number, stored contact - represented as "cotact name [number]"

type
  TfrmMissedCalls = class(TTntForm)
    lblCountCall: TTntLabel;
    OkButton: TTntButton;
    MissedCalls: TTntListView;
    PopupMenu1: TTntPopupMenu;
    VoiceCall1: TTntMenuItem;
    SendMessage1: TTntMenuItem;
    CheckBox1: TTntCheckBox;
    N1: TTntMenuItem;
    AddContact1: TTntMenuItem;
    procedure OkButtonClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure SendMessage1Click(Sender: TObject);
    procedure VoiceCall1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AddContact1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FMissedCalls: integer;
    { Private declarations }
    function GetSelNumber: string;
    procedure Set_MissedCalls(const Value: integer);
  public
    { Public declarations }
  property
    RecentMissedCalls: integer read FMissedCalls write Set_MissedCalls;
  end;

var
  frmMissedCalls: TfrmMissedCalls;

implementation

uses
  gnugettext, gnugettexthelpers,
  Unit1, uComposeSMS,
  uCalling, uInfoView;

{$R *.dfm}

procedure TfrmMissedCalls.OkButtonClick(Sender: TObject);
begin
  if CheckBox1.Checked then RecentMissedCalls := 0;
  Close;
  { Workaround for current calls implementation }
  if Form1.frmInfoView.Visible then Form1.frmInfoView.UpdateWelcomePage(True)
    else Form1.ExplorerNewChange(Form1.ExplorerNew,Form1.ExplorerNew.FocusedNode);
  Form1.ActionMissedCalls.Update; // update even if minimized
end;

function TfrmMissedCalls.GetSelNumber: string;
var
  s: string;
  i: integer;
begin
  Result := '';
  if (MissedCalls.Selected <> nil) and (MissedCalls.Selected.Caption <> sUnknownNumber) then begin
    s := MissedCalls.Selected.Caption;
    i := Pos('[',s);
    if i <> 0 then begin
      Delete(s,1,i);
      Delete(s,Length(s),1);
    end;
    Result := s;
  end;
end;

procedure TfrmMissedCalls.PopupMenu1Popup(Sender: TObject);
begin
  VoiceCall1.Enabled := (MissedCalls.Selected <> nil) and (GetSelNumber <> '');
  SendMessage1.Enabled := VoiceCall1.Enabled;
  AddContact1.Enabled := VoiceCall1.Enabled and (Pos(sUnknownContact,MissedCalls.Selected.Caption) <> 0);
end;

procedure TfrmMissedCalls.SendMessage1Click(Sender: TObject);
begin
  if not frmMessageContact.Visible then
    frmMessageContact.Clear;
  Form1.ActionSMSNewMsg.Execute;
  frmMessageContact.AddRecipient(GetSelNumber);
end;

procedure TfrmMissedCalls.VoiceCall1Click(Sender: TObject);
begin
  Form1.VoiceCall(GetSelNumber);
end;

procedure TfrmMissedCalls.FormShow(Sender: TObject);
begin
  CheckBox1.Checked := False;
end;

procedure TfrmMissedCalls.AddContact1Click(Sender: TObject);
begin
  Form1.frmSyncPhonebook.DoEdit(True,GetSelNumber);
end;

procedure TfrmMissedCalls.Set_MissedCalls(const Value: integer);
begin
  FMissedCalls := Value;
  if Value <> 0 then begin
    lblCountCall.Caption := _('Recent Missed Calls: ') + IntToStr(Value);
    CheckBox1.Visible := True;
  end
  else begin
    lblCountCall.Caption := _('Missed Calls List:');
    CheckBox1.Visible := False;
  end;
end;

procedure TfrmMissedCalls.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);
end;

end.
