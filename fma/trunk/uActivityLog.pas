unit uActivityLog;

{
*******************************************************************************
* Descriptions: Activity log window implementation
* $Source: /cvsroot/fma/fma/uActivityLog.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uActivityLog.pas,v $
* Revision 1.2  2005/02/08 15:38:33  voxik
* Merged with L10N branch
*
* Revision 1.1.16.2  2004/10/25 20:21:37  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.1.16.1  2004/10/19 19:48:30  expertone
* Add localization (gnugettext)
*
* Revision 1.1  2004/06/08 06:15:47  z_stoichev
* Initial checkin.
*
*
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, uDebug, Placemnt, StdCtrls, TntStdCtrls, Menus, TntMenus;

type
  TfrmActivityLog = class(TfrmDebug)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmActivityLog: TfrmActivityLog;

implementation

uses
  gnugettext, gnugettexthelpers;

{$R *.dfm}

end.
