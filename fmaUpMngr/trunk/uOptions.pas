unit uOptions;

{
*******************************************************************************
* Descriptions: Main Options Window
* $Source: /cvsroot/fma/fmaUpdmngr/uOptions.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uOptions.pas,v $
* Revision 1.1  2005/09/03 11:29:03  z_stoichev
* Initial checkin.
*
*
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmOptions = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    cbReloadRecent: TCheckBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOptions: TfrmOptions;

implementation

uses Unit1;

{$R *.dfm}

procedure TfrmOptions.Button2Click(Sender: TObject);
begin
  Form1.ClearRecentHistory;
end;

end.
