unit uDiffOptions;

{
*******************************************************************************
* Descriptions: Build Engine Options
* $Source: /cvsroot/fma/fmaUpdmngr/uDiffOptions.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uDiffOptions.pas,v $
* Revision 1.1  2005/09/03 11:29:03  z_stoichev
* Initial checkin.
*
*
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TfrmDiffOptions = class(TForm)
    GroupBox1: TGroupBox;
    rbFastBuild: TRadioButton;
    rbSmallBuild: TRadioButton;
    rbCustomBuild: TRadioButton;
    tbSpeedIndex: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    rbCompressNone: TRadioButton;
    rbCompressZLib: TRadioButton;
    rbCompressLh5: TRadioButton;
    GroupBox3: TGroupBox;
    rbEncryptNone: TRadioButton;
    rbEncryptXor: TRadioButton;
    rbEncryptMore: TRadioButton;
    GroupBox4: TGroupBox;
    rbPassNone: TRadioButton;
    rbPassWord: TRadioButton;
    Button1: TButton;
    btnOK: TButton;
    lblPassWord: TLabel;
    Label3: TLabel;
    lblOptimize: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rbBuildClick(Sender: TObject);
    procedure tbSpeedIndexChange(Sender: TObject);
  private
    { Private declarations }
    FSecret: string;
    procedure Set_Secret(const Value: string);
    procedure ShowOptimizeDetails; 
  public
    { Public declarations }
    property Secret: string read FSecret write Set_Secret;
  end;

var
  frmDiffOptions: TfrmDiffOptions;

implementation

uses uPassword;

{$R *.dfm}

{ TfrmDiffOptions }

procedure TfrmDiffOptions.Set_Secret(const Value: string);
begin
  FSecret := Value;
  if Trim(Value) <> '' then lblPassWord.Caption := 'Present'
    else lblPassWord.Caption := 'Not set';
end;

procedure TfrmDiffOptions.Button1Click(Sender: TObject);
begin
  frmPassword.Edit1.Text := Secret;
  if frmPassword.ShowModal = mrOk then begin
    rbPassWord.Checked := True;
    Secret := frmPassword.Edit1.Text;
  end;
end;

procedure TfrmDiffOptions.FormShow(Sender: TObject);
begin
  rbBuildClick(nil);
  btnOK.SetFocus; 
end;

procedure TfrmDiffOptions.rbBuildClick(Sender: TObject);
begin
  tbSpeedIndex.Enabled := rbCustomBuild.Checked;
  Label1.Enabled := tbSpeedIndex.Enabled;
  Label2.Enabled := tbSpeedIndex.Enabled;
  ShowOptimizeDetails;
end;

procedure TfrmDiffOptions.ShowOptimizeDetails;
var
  i: Integer;
begin
  if rbFastBuild.Checked then i := 1
  else
  if rbSmallBuild.Checked then i := 10
  else
  i := tbSpeedIndex.Position;
  if i < 3 then lblOptimize.Caption := 'Optimized for faster update generation speed but larger update total size.'
  else
  if i > 8 then lblOptimize.Caption := 'Optimized for smaller update total size but takes more time to complete.'
  else
  if i in [5,6] then
  lblOptimize.Caption := 'Optimized settings for both update generation speed and update total size.'
  else
  lblOptimize.Caption := 'Optimized settings for testing purposes only. Please tune up your settings.';
end;

procedure TfrmDiffOptions.tbSpeedIndexChange(Sender: TObject);
begin
  ShowOptimizeDetails;
end;

end.
