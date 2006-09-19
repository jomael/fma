unit uAddVersion;

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
    Button3: TButton;
    btnClose: TButton;
    Label3: TLabel;
    edPatchChar: TEdit;
    cbUsePatchChar: TCheckBox;
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
    procedure btnFromClick(Sender: TObject);
    procedure ActionVerBuildUpdate(Sender: TObject);
    procedure cbUsePatchCharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure ActionVerBuildExecute(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure btnOptionsClick(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown1ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
  private
    { Private declarations }
    procedure DoBuild;
  public
    { Public declarations }
    procedure ForceDeployment(AType: TModalResult);
    function GetVersionLabel: string;
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
  else begin
    lblDetails.Caption := 'Will generate incremental patches from previous application versions to this '+
      'one (click Next).';
    ActionVerBuild.Caption := '&Next...';
  end;
  btnOptions.Enabled := cbUseAppDeployment.Checked;
end;

procedure TfrmAddVersion.cbUsePatchCharClick(Sender: TObject);
begin
  if cbUsePatchChar.Checked and (edPatchChar.Text = '') then begin
    UpDown1.Position := 0;
    edPatchChar.Text := 'a';
  end;
end;

procedure TfrmAddVersion.FormShow(Sender: TObject);
begin
  StatusBar1.Panels[0].Text := 'Deploy a full update on every 10 incremental ones';
  StatusBar1.Panels[1].Text := '';
  btnClose.Caption := '&Cancel';
  UpDown1.Position := 0;
  cbUsePatchChar.Checked := False;
  if cbUseAppDeployment.Enabled then
    cbUseAppDeployment.Checked := False;
  edPatchChar.Text := '';
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
  if cbUsePatchChar.Checked then Result := Result + edPatchChar.Text;
end;

procedure TfrmAddVersion.ActionVerBuildExecute(Sender: TObject);
begin
  if cbUseAppDeployment.Checked then begin
    Button3.Enabled := False;
    btnClose.Enabled := False;
    btnOptions.Enabled := False;
    try
      DoBuild;
      ModalResult := mrAll; // full application deployment
    finally
      Button3.Enabled := True;
      btnClose.Enabled := True;
      btnClose.Caption := 'OK';
      ActionVerBuild.Update;
    end;
  end
  else
    ModalResult := mrOk;
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
    cbUsePatchChar.Checked := True;
    AllowChange := False;
  end
  else
    AllowChange := (NewValue >= UpDown1.Min) and (NewValue <= UpDown1.Max);
end;

procedure TfrmAddVersion.DoBuild;
var
  i,j: integer;
  s,d,z,ver: string;
  sl: TStringList;
  Found,InMain: boolean;
begin
  ver := GetVersionLabel;
  for i := 0 to Form1.TreeView1.Items[0].Count-1 do
    if AnsiCompareText(Form1.TreeView1.Items[0].Item[i].Text,ver) = 0 then
      raise Exception.Create('This version already exists');
  if MessageDlg('Start building update files now (Might take few minutes)?',
    mtConfirmation,[mbYes,mbNo],0) <> ID_YES then
    Abort;
  { Check filter restrictions }
  if Pos(Form1.ViewFilter,ver) <> 1 then
    MessageDlg('This version will not be visible once update is created '+
      'due to current Filter settings.', mtWarning, [mbOk], 0);
  Form1.StatusBar1.Panels[1].Text := 'Building...';
  Form1.StatusBar1.Update;
  sl := TStringList.Create;
  try
    sl.Assign(Form1.Memo1.Lines);
    { find 1st occurance ot any next ver }
    j := -1; Found := False; InMain := False;
    while not Found and (j < sl.Count-1) do begin
      inc(j);
      if Copy(sl[j],1,1) = ';' then continue;
      if Pos('[main]',sl[j]) <> 0 then InMain := True
      else begin
        if InMain and (Copy(sl[j],1,1) = '[') then begin
          while (j <> 0) do begin
            if Trim(sl[j-1]) <> '' then break;
            dec(j);
          end;
          break;
        end;
      end;
    end;
    { MobileAgent-*-0.1.0.99=MobileAgent-0.1.0.99.exe,2000000,null[,<md5>] }
    s := ExtractFileName(edFromExe.Text);
    d := ChangeFileExt(s,'-'+ver+'.z');
    z := ExtractFilePath(OpenDialog1.FileName) + d;
    if frmBuild.BuildZ(edFromExe.Text,z) then begin
      if frmBuild.BuildSize = 0 then Abort;
      s := frmOptions.Edit3.Text + '-*-' + ver + '=' + d + ',' + IntToStr(frmBuild.BuildSize) + ',null';
      { MD5 update file }
      s := s + ',' + FileMD5(z);
      sl.Insert(j,s);
      { Notify user }
      Form1.StatusBar1.Panels[1].Text := '';
      MessageBeep(MB_ICONEXCLAMATION);
      MessageDlg('Build successful!'+sLineBreak+sLineBreak+
        'Update total size (deployed application) is '+
        IntToStr(frmBuild.BuildSize div 1024)+' KB',mtInformation,[mbOK],0);
      { Update code }
      Form1.Memo1.Lines.Assign(sl);
      Form1.SyncGUI2Code; // save settings
    end;
  finally
    sl.Free;
    Form1.StatusBar1.Panels[1].Text := '';
  end;
end;

end.
