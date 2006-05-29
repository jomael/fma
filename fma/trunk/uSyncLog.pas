unit uSyncLog;

{
*******************************************************************************
* Descriptions: Synchronize log window implementation
* $Source: /cvsroot/fma/fma/uSyncLog.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uSyncLog.pas,v $
* Revision 1.5  2005/02/08 15:38:55  voxik
* Merged with L10N branch
*
* Revision 1.4.14.2  2004/10/25 20:21:56  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.4.14.1  2004/10/19 19:48:49  expertone
* Add localization (gnugettext)
*
* Revision 1.4  2004/06/05 13:32:56  lordlarry
* Merged with OutlookSync branch
*
* Revision 1.3  2004/05/21 10:09:05  z_stoichev
* Changed logging handle routines.
*
*
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, uDebug, Placemnt, StdCtrls, TntStdCtrls, Menus, TntMenus;

type
  TfrmSyncLog = class(TfrmDebug)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSyncLog: TfrmSyncLog;

implementation

uses
  gnugettext, gnugettexthelpers;

{$R *.dfm}

end.
