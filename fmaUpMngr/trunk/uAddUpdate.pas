unit uAddUpdate;

{
*******************************************************************************
* Descriptions: Create new patches
* $Source: /cvsroot/fma/fmaUpdmngr/uAddUpdate.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uAddUpdate.pas,v $
* Revision 1.14  2006/03/17 14:18:40  z_stoichev
* Build 1.0.6.34 (MD5)
*
* Revision 1.13  2006/03/02 09:16:26  z_stoichev
* Bugfixes
*
* Revision 1.12  2005/09/03 11:29:36  z_stoichev
* Added Diff Engine Options dialog.
*
* Revision 1.11  2005/09/03 01:12:14  z_stoichev
* Added uolDiff.DLL usage.
*
* Revision 1.10  2005/09/02 10:16:23  z_stoichev
* Disable form while building updates.
*
* Revision 1.9  2005/09/02 09:39:23  z_stoichev
* GUI Bugfixes, Added recent open files. Fixed Ctrl+S hotkey.
*
* Revision 1.8  2005/03/14 13:36:01  z_stoichev
* Do not consume CPU while generating updates.
*
* Revision 1.7  2005/02/15 14:26:25  z_stoichev
* Build 1.0.3.10
*
* Revision 1.6  2005/02/09 16:33:19  z_stoichev
* Magor updates. Added Manager custom settings in project file.
*
* Revision 1.5  2004/06/16 13:08:18  z_stoichev
* Added header comments and new build
*
*
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ActnList, ShellAPI, ComCtrls;

type
  TfrmAddUpdate = class(TForm)
    Label1: TLabel;
    edFromVer: TEdit;
    Label2: TLabel;
    edFromExe: TEdit;
    btnFrom: TButton;
    Label3: TLabel;
    Label4: TLabel;
    edToExe: TEdit;
    btnTo: TButton;
    edToVer: TComboBox;
    Button3: TButton;
    Button4: TButton;
    ActionList1: TActionList;
    ActionDiffBuild: TAction;
    OpenDialog1: TOpenDialog;
    cbDoReverse: TCheckBox;
    Label5: TLabel;
    edHistory: TEdit;
    btnHistory: TButton;
    StatusBar1: TStatusBar;
    cbDoHistory: TCheckBox;
    Button6: TButton;
    procedure Button4Click(Sender: TObject);
    procedure ActionDiffBuildUpdate(Sender: TObject);
    procedure btnFromClick(Sender: TObject);
    procedure btnToClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btnHistoryClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edToVerChange(Sender: TObject);
    procedure ActionDiffBuildExecute(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
    ReverseDif,DosRunning: boolean;
  public
    { Public declarations }
    ReadyUpdates: TStringList;
    property IsReverseDif: boolean read ReverseDif;
  end;

var
  frmAddUpdate: TfrmAddUpdate;

implementation

uses Unit1, uGenerate, uDiffOptions;

{$R *.dfm}

{ TfrmAddUpdate }

procedure TfrmAddUpdate.Button4Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmAddUpdate.ActionDiffBuildUpdate(Sender: TObject);
begin
  ActionDiffBuild.Enabled := (edToVer.ItemIndex <> -1) and FileExists(edFromExe.Text) and FileExists(edToExe.Text);  
end;

procedure TfrmAddUpdate.btnFromClick(Sender: TObject);
begin
  OpenDialog1.Filter := 'Executale Files|*.exe|All Files|*.*';
  OpenDialog1.InitialDir := ExtractFileDir(edFromExe.Text);
  OpenDialog1.FileName := edFromExe.Text;
  if OpenDialog1.Execute then edFromExe.Text := OpenDialog1.FileName;
end;

procedure TfrmAddUpdate.btnToClick(Sender: TObject);
begin
  OpenDialog1.Filter := 'Executale Files|*.exe|All Files|*.*';
  OpenDialog1.InitialDir := ExtractFileDir(edToExe.Text);
  OpenDialog1.FileName := edToExe.Text;
  if OpenDialog1.Execute then edToExe.Text := OpenDialog1.FileName;
end;

procedure TfrmAddUpdate.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := not DosRunning;
end;

procedure TfrmAddUpdate.FormShow(Sender: TObject);
begin
  frmDiffOptions.Secret := '';
  ReadyUpdates.Clear;
  edToVer.SetFocus;
end;

procedure TfrmAddUpdate.btnHistoryClick(Sender: TObject);
begin
  OpenDialog1.Filter := 'Text Files|*.txt|All Files|*.*';
  OpenDialog1.InitialDir := ExtractFileDir(edHistory.Text);
  OpenDialog1.FileName := edHistory.Text;
  if OpenDialog1.Execute then edHistory.Text := OpenDialog1.FileName;
end;

procedure TfrmAddUpdate.FormCreate(Sender: TObject);
begin
{$IFNDEF VER150}
  Form1.ThemeManager1.CollectForms(Self);
{$ENDIF}
  ReadyUpdates := TStringList.Create;
end;

procedure TfrmAddUpdate.edToVerChange(Sender: TObject);
begin
  ReverseDif := edFromVer.Tag > Integer(edToVer.Items.Objects[edToVer.ItemIndex]);
  cbDoReverse.Enabled := not ReverseDif;
  StatusBar1.Panels[0].Text := ExtractFilePath(Form1.OpenDialog1.FileName)+
    'update-'+edFromVer.Text+'-'+edToVer.Text;
  if ReverseDif then
    StatusBar1.Panels[1].Text := 'Reverse Update'
  else
    StatusBar1.Panels[1].Text := 'Forward Update';
end;

procedure TfrmAddUpdate.ActionDiffBuildExecute(Sender: TObject);
begin
  if frmDiffOptions.rbPassWord.Checked and (frmDiffOptions.Secret = '') and
    (MessageDlg('Your update protection password is not set. Cancel build?',
    mtConfirmation,[mbYes,mbNo],0) = ID_YES) then
    exit;
  if frmDiffOptions.rbPassWord.Checked and // TODO: Remove when implemented
    (MessageDlg('Current FMA builds do not support Password. Cancel build?',
    mtConfirmation,[mbYes,mbNo],0) = ID_YES) then
    exit;
  if frmDiffOptions.rbCompressNone.Checked and
    (MessageDlg('Update compression is off, increasing size. Cancel build?',
    mtConfirmation,[mbYes,mbNo],0) = ID_YES) then
    exit;
  if MessageDlg('Start building update files now (Might take few minutes)?',
    mtConfirmation,[mbYes,mbNo],0) <> ID_YES then
    exit;
  Button3.Enabled := False;
  Button4.Enabled := False;
  Button6.Enabled := False;
  Form1.StatusBar1.Panels[1].Text := 'Building...';
  try
    if frmBuild.BuildUpdates then begin
      Form1.StatusBar1.Panels[1].Text := '';
      MessageBeep(MB_ICONEXCLAMATION);
      MessageDlg('Build successful!'+sLineBreak+sLineBreak+
        'Update total size (all generated files) is '+
        IntToStr(frmBuild.BuildSize div 1024)+' KB',mtInformation,[mbOK],0);
      ModalResult := mrOk;
    end
    else begin
      edToVerChange(nil);
    end;
  finally
    Form1.StatusBar1.Panels[1].Text := '';
    Button3.Enabled := True;
    Button4.Enabled := True;
    Button6.Enabled := True;
  end;
end;

procedure TfrmAddUpdate.Button6Click(Sender: TObject);
begin
  frmDiffOptions.ShowModal;
end;

end.
