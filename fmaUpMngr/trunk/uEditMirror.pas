unit uEditMirror;

{
*******************************************************************************
* Descriptions: Mirror Properties
* $Source: /cvsroot/fma/fmaUpdmngr/uEditMirror.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uEditMirror.pas,v $
* Revision 1.1  2005/09/01 15:43:31  z_stoichev
* Initial release.
*
*
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmMirror = class(TForm)
    Label1: TLabel;
    edName: TEdit;
    Label2: TLabel;
    mmoURL: TMemo;
    Button1: TButton;
    Button2: TButton;
    cbDefault: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FEditMode: boolean;
  public
    { Public declarations }
  end;

var
  frmMirror: TfrmMirror;

implementation

uses Unit1;

{$R *.dfm}

procedure TfrmMirror.FormCreate(Sender: TObject);
begin
{$IFNDEF VER150}
  Form1.ThemeManager1.CollectForms(Self);
{$ENDIF}
end;

procedure TfrmMirror.Button1Click(Sender: TObject);
var
  i: Integer;
begin
  if Trim(edName.Text) = '' then
    raise Exception.Create('Please fill in Mirror Name');
  if Trim(mmoURL.Text) = '' then
    raise Exception.Create('Please fill in Server Base URL');
  if (Pos('://',mmoURL.Text) = 0) or (Length(mmoURL.Text) < 6) then { ftp:// }
    raise Exception.Create('Invalid Server Base URL');
  if not FEditMode then
    for i := 0 to Form1.ListView2.Items.Count-1 do
      if CompareStr(mmoURL.Text,Form1.ListView2.Items[i].SubItems[0]) = 0 then
        raise Exception.Create('Server Base URL already exists');
  ModalResult := mrOk;
end;

procedure TfrmMirror.FormShow(Sender: TObject);
begin
  FEditMode := edName.Text <> '';
  edName.SetFocus;
end;

end.
