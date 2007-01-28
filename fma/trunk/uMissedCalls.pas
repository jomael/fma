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
    N2: TTntMenuItem;
    ClearNotifications1: TTntMenuItem;
    procedure OkButtonClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure SendMessage1Click(Sender: TObject);
    procedure VoiceCall1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AddContact1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ClearNotifications1Click(Sender: TObject);
  private
    FMissedCalls: integer;
    { Private declarations }
    function GetSelNumber: string;
    procedure Set_MissedCalls(const Value: integer);
  public
    { Public declarations }
    procedure RefreshAllSenders;
    property RecentMissedCalls: integer read FMissedCalls write Set_MissedCalls;
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
begin
  Result := '';
  if (MissedCalls.Selected <> nil) and (MissedCalls.Selected.Caption <> sUnknownNumber) then
    Result := MissedCalls.Selected.Caption;
end;

procedure TfrmMissedCalls.PopupMenu1Popup(Sender: TObject);
begin
  VoiceCall1.Enabled := GetSelNumber <> '';
  SendMessage1.Enabled := VoiceCall1.Enabled;
  AddContact1.Enabled := VoiceCall1.Enabled and (Pos(sUnknownContact,MissedCalls.Selected.Caption) <> 0);
end;

procedure TfrmMissedCalls.SendMessage1Click(Sender: TObject);
begin
  frmMessageContact.Clear;
  Form1.ActionSMSNewMsg.Execute;
  frmMessageContact.AddRecipient(GetSelNumber);
  frmMessageContact.Memo.SetFocus;
end;

procedure TfrmMissedCalls.VoiceCall1Click(Sender: TObject);
begin
  Form1.DoCallContact(GetSelNumber);
end;

procedure TfrmMissedCalls.FormShow(Sender: TObject);
begin
  RefreshAllSenders;
  CheckBox1.Checked := False;
end;

procedure TfrmMissedCalls.AddContact1Click(Sender: TObject);
begin
  if Form1.AddNewToPhonebook(GetSelNumber) then begin
    { Update view }
    RefreshAllSenders;
    AddContact1.Enabled := False;
  end;
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

procedure TfrmMissedCalls.ClearNotifications1Click(Sender: TObject);
begin
  CheckBox1.Checked := True;
  OkButton.Click;
end;

procedure TfrmMissedCalls.RefreshAllSenders;
var
  i: integer;
begin
  for i := 0 to MissedCalls.Items.Count-1 do
    MissedCalls.Items[i].Caption := Form1.ContactNumberByTel(MissedCalls.Items[i].Caption);
end;

end.
