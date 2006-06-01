unit uPassword;

{
*******************************************************************************
* Descriptions: Enter password dialog
* $Source: /cvsroot/fma/fmaUpdmngr/uPassword.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uPassword.pas,v $
* Revision 1.2  2006/03/02 09:16:26  z_stoichev
* Bugfixes
*
*
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmPassword = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPassword: TfrmPassword;

implementation

{$R *.dfm}

procedure TfrmPassword.Button1Click(Sender: TObject);
begin
  if Length(Trim(Edit1.Text)) < 5 then
    raise EConvertError.Create('Password is too short');
  if CompareStr(Edit1.Text,Edit2.Text) <> 0 then
    raise EConvertError.Create('Passwords do not match');
  ModalResult := mrOk;
end;

procedure TfrmPassword.FormShow(Sender: TObject);
begin
  Edit2.Text := '';
  Edit1.SetFocus;
end;

end.
