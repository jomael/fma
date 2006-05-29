unit uInputQuery;

{
*******************************************************************************
* Descriptions: InputQuery with Unicode support
* $Source: /cvsroot/fma/fma/uInputQuery.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uInputQuery.pas,v $
* Revision 1.3  2005/02/08 15:38:52  voxik
* Merged with L10N branch
*
* Revision 1.2.2.2  2004/10/25 20:21:46  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.2.2.1  2004/10/19 19:48:38  expertone
* Add localization (gnugettext)
*
* Revision 1.2  2004/10/15 14:01:52  z_stoichev
* Merged with Stable bugfixes
*
* Revision 1.1.2.1  2004/10/15 11:29:22  z_stoichev
* Initial checkin.
*
*
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, StdCtrls, TntStdCtrls;

type
  TfrmInputQuery = class(TTntForm)
    TntLabel1: TTntLabel;
    TntEdit1: TTntEdit;
    Button1: TTntButton;
    Button2: TTntButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInputQuery: TfrmInputQuery;

function WideInputQuery(ACaption,ATitle: WideString; var DefaultText: WideString): boolean;

implementation

uses
  gnugettext, gnugettexthelpers;

{$R *.dfm}

function WideInputQuery(ACaption,ATitle: WideString; var DefaultText: WideString): boolean;
begin
  with TfrmInputQuery.Create(nil) do
  try
    Caption := ACaption;
    TntLabel1.Caption := ATitle;
    TntEdit1.Text := DefaultText;
    Result := ShowModal = mrOk;
    if Result then DefaultText := TntEdit1.Text;
  finally
    Free;
  end;
end;

procedure TfrmInputQuery.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);
end;

end.
