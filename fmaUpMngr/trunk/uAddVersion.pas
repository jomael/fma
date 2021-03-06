unit uAddVersion;

{
*******************************************************************************
* Descriptions: Create new version
* $Source: /cvsroot/fma/fmaUpdmngr/uAddVersion.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uAddVersion.pas,v $
*
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, ActnList;

type
  TfrmAddVersion = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edVersion: TEdit;
    edFromExe: TEdit;
    btnFrom: TButton;
    OpenDialog1: TOpenDialog;
    btnOK: TButton;
    btnClose: TButton;
    Label3: TLabel;
    edPatchChar: TEdit;
    cbUsePatchSuffix: TCheckBox;
    UpDown1: TUpDown;
    btnOptions: TButton;
    ActionList1: TActionList;
    ActionVerBuild: TAction;
    cbUseAppDeployment: TCheckBox;
    Label4: TLabel;
    edLabel: TEdit;
    GroupBox1: TGroupBox;
    StatusBar1: TStatusBar;
    lblDetails: TLabel;
    cbDoIncUpdates: TCheckBox;
    Label5: TLabel;
    edSVNRev: TEdit;
    UpDown2: TUpDown;
    rbAddLetter: TRadioButton;
    rbAddSVNRev: TRadioButton;
    procedure btnFromClick(Sender: TObject);
    procedure ActionVerBuildUpdate(Sender: TObject);
    procedure cbUsePatchSuffixClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure ActionVerBuildExecute(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure btnOptionsClick(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown1ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure UpDown2Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown2ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure edSVNRevExit(Sender: TObject);
    procedure edPatchCharExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ForceDeployment(AType: TModalResult);
    function GetVersionLabel: string;
    function GetAppFileName: string;
    function GetUpdateFileName: string;
  end;

var
  frmAddVersion: TfrmAddVersion;

implementation

uses
  uVersion, uDeployOptions, uGenerate, uOptions, Unit1, IcsMD5;

{$R *.dfm}

procedure TfrmAddVersion.btnFromClick(Sender: TObject);
begin
  OpenDialog1.Filter := 'Executale Files|*.exe|All Files|*.*';
  OpenDialog1.InitialDir := ExtractFileDir(edFromExe.Text);
  OpenDialog1.FileName := edFromExe.Text;
  if OpenDialog1.Execute then begin
    edFromExe.Text := OpenDialog1.FileName;
    edVersion.Text := ExtractFileVersionInfo(OpenDialog1.FileName,'FileVersion'); // do not localize
  end;
end;

procedure TfrmAddVersion.ActionVerBuildUpdate(Sender: TObject);
begin
  edLabel.Text := GetVersionLabel;
  ActionVerBuild.Enabled := (Trim(edLabel.Text) <> '') and FileExists(edFromExe.Text);
  if cbUseAppDeployment.Checked then begin
    lblDetails.Caption := 'Will deploy the whole application. No incremental patches will be generated '+
      '(Not Recommended).';
    ActionVerBuild.Caption := '&Build...';
  end
  else
    if cbDoIncUpdates.Checked then begin
      lblDetails.Caption := 'Will generate incremental patches from previous application versions to this '+
        'one (click Next).';
      ActionVerBuild.Caption := '&Next...';
    end
    else begin
      lblDetails.Caption := 'Will create an empty version folder. Later incremental updates could be '+
        'generated from or to it.';
      ActionVerBuild.Caption := 'OK';
    end;
  btnOptions.Visible := cbUseAppDeployment.Checked;
  cbDoIncUpdates.Visible := not cbUseAppDeployment.Checked;
end;

procedure TfrmAddVersion.cbUsePatchSuffixClick(Sender: TObject);
begin
  if cbUsePatchSuffix.Checked then begin
    if rbAddLetter.Checked and (edPatchChar.Text = '') then begin
      UpDown1.Position := 0;
      edPatchChar.Text := 'a';
    end;
    if rbAddSVNRev.Checked and (edSVNRev.Text = '') then begin
      UpDown2.Position := 0;
      edSVNRev.Text := '1';
    end;
  end;
  rbAddLetter.Enabled := cbUsePatchSuffix.Checked;
  rbAddSVNRev.Enabled := cbUsePatchSuffix.Checked;
end;

procedure TfrmAddVersion.FormShow(Sender: TObject);
begin
  StatusBar1.Panels[0].Text := 'Deploy a full update on every 10 incremental ones';
  StatusBar1.Panels[1].Text := '';
  btnClose.Caption := '&Cancel';
  UpDown1.Position := 0;
  cbUsePatchSuffix.Checked := False;
  edPatchChar.Text := '';
  edSVNRev.Text := '';
  if FileExists(edFromExe.Text) then
    edVersion.Text := ExtractFileVersionInfo(edFromExe.Text,'FileVersion') // do not localize
  else
    edVersion.Text := '';
  edFromExe.SetFocus;
end;

procedure TfrmAddVersion.btnCloseClick(Sender: TObject);
begin
  Close;
end;

function TfrmAddVersion.GetVersionLabel: string;
begin
  Result := edVersion.Text;
  if cbUsePatchSuffix.Checked then begin
    if rbAddLetter.Checked then
      Result := Result + edPatchChar.Text;
    if rbAddSVNRev.Checked then
      Result := Result + '.R' + edSVNRev.Text;
  end;
end;

procedure TfrmAddVersion.ActionVerBuildExecute(Sender: TObject);
var
  i: Integer;
  ver: string;
begin
  if cbUseAppDeployment.Checked then begin
    ver := GetVersionLabel;
    for i := 0 to Form1.TreeView1.Items[0].Count-1 do
      if AnsiCompareText(Form1.TreeView1.Items[0].Item[i].Text,ver) = 0 then
        raise Exception.Create('This version already exists');
    if frmDeployOptions.rbPassWord.Checked and (frmDeployOptions.Secret = '') and
      (MessageDlg('Your update protection password is not set. Cancel build?',
      mtConfirmation,[mbYes,mbNo],0) = ID_YES) then
      Abort;
    if frmDeployOptions.rbPassWord.Checked and // TODO: Remove when implemented
      (MessageDlg('Current FMA builds do not support Password. Cancel build?',
      mtConfirmation,[mbYes,mbNo],0) = ID_YES) then
      Abort;
    if frmDeployOptions.rbCompressNone.Checked and
      (MessageDlg('Update compression is off, increasing size. Cancel build?',
      mtConfirmation,[mbYes,mbNo],0) = ID_YES) then
      Abort;
    if MessageDlg('Start building update files now (Might take few minutes)?',
      mtConfirmation,[mbYes,mbNo],0) <> ID_YES then
      Abort;
    { Check filter restrictions }
    if Pos(Form1.ViewFilter,ver) <> 1 then
      MessageDlg('This version will not be visible once update is created '+
        'due to current Filter settings.', mtWarning, [mbOk], 0);
    { Build }
    btnOK.Enabled := False;
    btnClose.Enabled := False;
    btnOptions.Enabled := False;
    Form1.StatusBar1.Panels[1].Text := 'Building...';
    try
      if frmBuild.BuildDeployment then begin
        Form1.StatusBar1.Panels[1].Text := '';
        MessageBeep(MB_ICONEXCLAMATION);
        MessageDlg('Build successful!'+sLineBreak+sLineBreak+
          'Update total size (deployed application) is '+
          IntToStr(frmBuild.BuildSize div 1024)+' KB',mtInformation,[mbOK],0);
        ModalResult := mrAll; // full application deployment done
      end
      else
        ActionVerBuild.Update;
    finally
      Form1.StatusBar1.Panels[1].Text := '';
      btnOK.Enabled := True;
      btnOptions.Enabled := True;
      btnClose.Enabled := True;
      btnClose.Caption := 'Close';
    end;
  end
  else begin
    Form1.CheckNewVersionLabel(GetVersionLabel);
    ModalResult := mrOk; // go to Add Updates dialog
  end;
end;

procedure TfrmAddVersion.ForceDeployment(AType: TModalResult);
begin
  cbUseAppDeployment.Enabled := False;
  case AType of
    mrOk:
      cbUseAppDeployment.Checked := False;
    mrAll:
      cbUseAppDeployment.Checked := True;
    else
      cbUseAppDeployment.Enabled := True;
  end;
end;

procedure TfrmAddVersion.FormHide(Sender: TObject);
begin
  cbUseAppDeployment.Enabled := True;
end;

procedure TfrmAddVersion.btnOptionsClick(Sender: TObject);
begin
  frmDeployOptions.ShowModal;
end;

procedure TfrmAddVersion.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
  edPatchChar.Text := Char(Ord('a')+UpDown1.Position);
end;

procedure TfrmAddVersion.UpDown1ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
  if edPatchChar.Text = '' then begin
    edPatchChar.Text := 'a';
    cbUsePatchSuffix.Checked := True;
    rbAddLetter.Checked := True;
    AllowChange := False;
  end
  else
    AllowChange := (NewValue >= UpDown1.Min) and (NewValue <= UpDown1.Max);
end;

function TfrmAddVersion.GetUpdateFileName: string;
var
  s,d,v: string;
begin
  v := GetVersionLabel;
  s := ExtractFileName(GetAppFileName);
  if frmDeployOptions.rbCompressZLib.Checked then
    d := ChangeFileExt(s,'-' + v + '.z');
  if frmDeployOptions.rbCompressNone.Checked then
    d := ChangeFileExt(s,'-' + v + ExtractFileExt(s)); // .EXE
  Result := ExtractFilePath(Form1.OpenDialog1.FileName) + d;
end;

function TfrmAddVersion.GetAppFileName: string;
begin
  Result := edFromExe.Text;
end;

procedure TfrmAddVersion.UpDown2Click(Sender: TObject; Button: TUDBtnType);
begin
  edSVNRev.Text := IntToStr(UpDown2.Position);
end;

procedure TfrmAddVersion.UpDown2ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
  if edSVNRev.Text = '' then begin
    edSVNRev.Text := '1';
    cbUsePatchSuffix.Checked := True;
    rbAddSVNRev.Checked := True;
    AllowChange := False;
  end
  else
    AllowChange := (NewValue >= UpDown2.Min) and (NewValue <= UpDown2.Max);
end;

procedure TfrmAddVersion.edSVNRevExit(Sender: TObject);
begin
  try
    UpDown2.Position := StrToInt(edSVNRev.Text);
  except
    UpDown2Click(nil,btNext);
  end;
end;

procedure TfrmAddVersion.edPatchCharExit(Sender: TObject);
var
  c: Char;
begin
  try
    if Length(edPatchChar.Text) = 1 then begin
      c := edPatchChar.Text[1];
      if c in ['a'..'z'] then begin
        UpDown1.Position := Ord(c) - Ord('a');
        edPatchChar.Text := c;
      end
      else
        Abort;
    end
    else
      Abort;
  except
    UpDown1Click(nil,btNext);
  end;
end;

end.
