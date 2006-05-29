unit uStatusDlg;

{
*******************************************************************************
* Descriptions: Main Unit for FMA
* $Source: /cvsroot/fma/fma/uStatusDlg.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uStatusDlg.pas,v $
* Revision 1.4.2.1  2005/10/04 10:05:28  expertone
* L10N Fixes
*
* Revision 1.4  2005/02/08 15:38:55  voxik
* Merged with L10N branch
*
* Revision 1.3.14.4  2005/02/02 16:51:54  voxik
* Fixed Unicode support
*
* Revision 1.3.14.3  2004/11/01 21:20:56  expertone
* Fixed some BiDi problems
*
* Revision 1.3.14.2  2004/10/25 20:21:56  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.3.14.1  2004/10/19 19:48:49  expertone
* Add localization (gnugettext)
*
* Revision 1.3  2004/06/15 13:00:51  z_stoichev
* Allow different window position usage.
*
* Revision 1.2  2003/12/11 14:04:44  z_stoichev
* Removed Always on top.
* Show as screen centered.
*
* Revision 1.1  2003/12/09 16:09:31  z_stoichev
* Initial checkin.
*
*
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, StdCtrls, TntStdCtrls, ExtCtrls, TntExtCtrls;

type
  TfrmStatusDlg = class(TTntForm)
    Image1: TTntImage;
    Label1: TTntLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Status(Msg: WideString);
  end;

var
  frmStatusDlg: TfrmStatusDlg;

function ShowStatusDlg(Msg: WideString; Where: TPosition = poScreenCenter): TfrmStatusDlg;

implementation

uses
  gnugettext, gnugettexthelpers;

{$R *.dfm}

function ShowStatusDlg(Msg: WideString; Where: TPosition): TfrmStatusDlg;
begin
  Result := TfrmStatusDlg.Create(nil);
  with Result do begin
    Position := Where;
    Status(Msg);
    Show;
    Update;
  end;
end;

procedure TfrmStatusDlg.FormCreate(Sender: TObject);
begin
  Image1.Picture.Icon.Assign(Application.Icon);
  gghTranslateComponent(self);
end;

procedure TfrmStatusDlg.Status(Msg: WideString);
begin
  Label1.Caption := Msg;
  if not IsRightToLeft then
    Width := Label1.Left + Label1.Width + 32
  else
    Width := Image1.Width + 16 + Label1.Width + 32;
  if Visible then begin
    Left := (Screen.Width - Width) div 2;
    Update;
  end;
end;

end.
