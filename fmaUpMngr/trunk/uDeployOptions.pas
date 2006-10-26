unit uDeployOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmDeployOptions = class(TForm)
    btnOK: TButton;
    GroupBox2: TGroupBox;
    rbCompressNone: TRadioButton;
    rbCompressZLib: TRadioButton;
    rbCompressLh5: TRadioButton;
    GroupBox3: TGroupBox;
    rbEncryptNone: TRadioButton;
    rbEncryptXor: TRadioButton;
    rbEncryptMore: TRadioButton;
    GroupBox4: TGroupBox;
    lblPassWord: TLabel;
    rbPassNone: TRadioButton;
    rbPassWord: TRadioButton;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FSecret: string;
    procedure Set_Secret(const Value: string);
  public
    { Public declarations }
    property Secret: string read FSecret write Set_Secret;
  end;

var
  frmDeployOptions: TfrmDeployOptions;

implementation

uses uPassword;

{$R *.dfm}

procedure TfrmDeployOptions.FormShow(Sender: TObject);
begin
  btnOK.SetFocus;
end;

procedure TfrmDeployOptions.Set_Secret(const Value: string);
begin
  FSecret := Value;
  if Trim(Value) <> '' then lblPassWord.Caption := 'Present'
    else lblPassWord.Caption := 'Not set';
end;

procedure TfrmDeployOptions.Button1Click(Sender: TObject);
begin
  frmPassword.Edit1.Text := Secret;
  if frmPassword.ShowModal = mrOk then begin
    rbPassWord.Checked := True;
    Secret := frmPassword.Edit1.Text;
  end;
end;

end.
