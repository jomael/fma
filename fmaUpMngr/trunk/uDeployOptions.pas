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
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDeployOptions: TfrmDeployOptions;

implementation

{$R *.dfm}

procedure TfrmDeployOptions.FormShow(Sender: TObject);
begin
  btnOK.SetFocus;
end;

end.
