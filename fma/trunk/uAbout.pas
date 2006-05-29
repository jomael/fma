unit uAbout;

interface

{
*******************************************************************************
* Descriptions: About Box Implementation
* $Source: /cvsroot/fma/fma/uAbout.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uAbout.pas,v $
* Revision 1.33.2.5  2006/03/12 13:04:31  z_stoichev
* New UTF8 Codec usage.
*
* Revision 1.33.2.4  2005/10/04 10:05:28  expertone
* L10N Fixes
*
* Revision 1.33.2.3  2005/08/22 07:29:44  z_stoichev
* GUI fixes
*
* Revision 1.33.2.2  2005/08/18 17:42:23  z_stoichev
* GUI fixes.
*
* Revision 1.33.2.1  2005/08/18 17:12:34  z_stoichev
* - Fixed About hyperlinks default font.
* - Added License Button to About dialog.
*
* Revision 1.33  2005/02/11 10:54:49  z_stoichev
* GUI changes.
*
* Revision 1.32  2005/02/10 18:37:34  voxik
* Fixed: Translation issues
*
* Revision 1.31  2005/02/08 15:38:33  voxik
* Merged with L10N branch
*
* Revision 1.28.2.7  2005/02/04 00:10:06  voxik
* Fixed About box flickering
*
* Revision 1.28.2.6  2005/02/03 23:12:15  voxik
* Fixed About box unicode support
*
* Revision 1.28.2.5  2005/01/13 20:18:18  expertone
* Added support for more than one translation for one locale
*
* Revision 1.28.2.4  2005/01/07 17:34:29  expertone
* Merge with MAIN branch
*
* Revision 1.30  2004/12/22 11:13:03  z_stoichev
* Rremoved splash test button.
* Made GPL text as a link.
* made dialog more compact.
*
* Revision 1.29  2004/12/10 16:06:17  z_stoichev
* Fixed: About dialog widgets tab order.
* Added: Splash could be closed by mouse click.
* Added: About dialog shows cool splash image.
*
* Revision 1.28.2.3  2004/11/01 21:20:56  expertone
* Fixed some BiDi problems
*
* Revision 1.28.2.2  2004/10/25 20:37:57  expertone
* Replaced all standart components with TNT components.
* Added Localizations part in Credits.
* Some small fixes.
*
* Revision 1.28.2.1  2004/10/19 19:48:30  expertone
* Add localization (gnugettext)
*
* Revision 1.28  2004/10/11 13:15:44  voxik
* Merged with Calendar branch (Fma 0.1.2.10)
*
* Revision 1.27  2004/07/07 09:13:52  z_stoichev
* Common Wizard Image usage
*
* Revision 1.26  2004/06/25 20:35:02  lordlarry
* - Added warning not to send bugs to developers directly
* - Mentioned the irc channel
*
* Revision 1.25.2.2  2004/07/02 16:31:50  voxik
* - Added Calendar event editing
* - Added Calendar sync
* - Changed VP DB support
*
* Revision 1.25  2004/06/11 12:27:42  z_stoichev
* Updated project admins.
*
* Revision 1.24  2004/04/01 15:01:44  z_stoichev
* Donate link
*
* Revision 1.23  2004/03/28 20:46:16  z_stoichev
* GUI changes
*
* Revision 1.22  2004/03/08 12:20:14  z_stoichev
* Updated INC file comments
*
* Revision 1.21  2003/12/18 15:22:39  z_stoichev
* About image changed, layot changed.
*
* Revision 1.20  2003/12/11 14:54:31  z_stoichev
* Build Letter variable moved into INC file.
*
* Revision 1.19  2003/12/11 12:42:13  z_stoichev
* Patch 28e.
*
* Revision 1.18  2003/12/09 16:08:24  z_stoichev
* Added usage of uVersion unit.
*
* Revision 1.17  2003/12/09 12:05:25  z_stoichev
* Build 0.10.28c + 29a changes without new WaitComplete unit.
*
* Revision 1.16  2003/12/04 16:25:58  z_stoichev
* Update 29a.
*
* Revision 1.15  2003/12/03 16:18:00  z_stoichev
* Build increased to 0.1.0.29.
*
* Revision 1.14  2003/12/02 16:14:58  z_stoichev
* Patch 28d
*
* Revision 1.13  2003/11/28 09:38:07  z_stoichev
* Merged with branch-release-1-1 (Fma 0.10.28c)
*
* Revision 1.12.2.19  2003/11/27 12:58:01  z_stoichev
* Patch 28c.
*
* Revision 1.12.2.18  2003/11/26 12:24:05  z_stoichev
* Update to patch 28b.
*
* Revision 1.12.2.17  2003/11/21 10:56:36  z_stoichev
* Patch 28a
*
* Revision 1.12.2.16  2003/11/19 12:48:57  z_stoichev
* Build 28.
*
* Revision 1.12.2.15  2003/11/14 15:41:02  z_stoichev
* Updates for patch 27d.
*
* Revision 1.12.2.14  2003/11/13 16:49:03  z_stoichev
* Patch updated to 27c.
* Logo image transparancy issue fixed.
*
* Revision 1.12.2.13  2003/11/11 18:10:01  z_stoichev
* Use common background.
*
* Revision 1.12.2.12  2003/11/11 13:15:47  z_stoichev
* Update to patch b.
* GUI changed to allow more space.
*
* Revision 1.12.2.11  2003/11/10 16:07:57  z_stoichev
* Update for patch 27a.
*
* Revision 1.12.2.10  2003/11/10 14:03:09  z_stoichev
* RC3
*
* Revision 1.12.2.9  2003/11/07 16:35:52  z_stoichev
* Update to patch 20c.
*
* Revision 1.12.2.8  2003/11/07 09:48:42  z_stoichev
* Update to patch 20b.
* Wizard Image made common.
*
* Revision 1.12.2.7  2003/11/04 12:28:16  z_stoichev
* Update to patch a.
*
* Revision 1.12.2.6  2003/10/31 14:49:52  z_stoichev
* Added logo background and credits.
*
* Revision 1.12.2.5  2003/10/30 13:20:39  z_stoichev
* Update to patch d.
* Added Fma logo image.
*
* Revision 1.12.2.4  2003/10/29 14:58:06  z_stoichev
* Update to patch c.
*
* Revision 1.12.2.3  2003/10/28 12:56:06  z_stoichev
* Update to patch b.
*
* Revision 1.12.2.2  2003/10/27 15:38:29  z_stoichev
* Update to patch 19a.
*
* Revision 1.12.2.1  2003/10/27 07:22:54  z_stoichev
* Build 0.1.0 RC1 Initial Checkin.
*
* Revision 1.12  2003/10/24 16:59:10  z_stoichev
* Updated to patch 'd'.
*
* Revision 1.11  2003/10/24 12:28:43  z_stoichev
* Patch version "c".
*
* Revision 1.10  2003/10/23 11:36:54  z_stoichev
* Increased patch number, and font changed.
*
* Revision 1.9  2003/10/22 14:13:44  z_stoichev
* Add patch support (show a letter after build number).
*
* Revision 1.8  2003/10/16 11:13:35  z_stoichev
* Changed to show file build instead of
* product version.
*
* Revision 1.7  2003/10/14 08:24:07  z_stoichev
* Removed form transparency.
* Added me as a developer.
*
* Revision 1.6  2003/10/10 13:35:09  z_stoichev
* New about logo including T610 :-))
*
* Revision 1.5  2003/07/02 12:47:08  crino77
* changed role
*
* Revision 1.4  2003/01/30 04:12:54  warren00
* Added hyperlink url and dynamic version info. Configure version info in Project->Option
*
*
*******************************************************************************
}

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, StdCtrls, TntStdCtrls, ExtCtrls, TntExtCtrls, ShellApi,
  Graphics, TntGraphics;

(*
const
  // should be changed manualy when releasing a patch,
  // and should be cleared when releasing a new build version.

  // also keep minor changes patch by increase letters,
  // and majr changes patch by increaseing build number.
  BuildPatchLetter = '';

  // useful for monthly builds ala Xmas Edition.
  BuildFriendlyName = '';
*)

{ Following  include file contains the commented lines above.
  Its done to avoid CVS checkin/checkout on every single update. }

{$I uAbout.inc}

type
  TfrmAbout = class(TTntForm)
    OkButton: TTntButton;
    Bevel2: TTntBevel;
    Panel1: TTntPanel;
    lbVersion: TTntLabel;
    Label3: TTntLabel;
    Image3: TTntImage;
    DonateButton: TTntButton;
    Label12: TTntLabel;
    TntPanel1: TTntPanel;
    CreditsText: TTntMemo;
    lbURL: TTntLabel;
    LicenseButton: TTntButton;
    procedure FormCreate(Sender: TObject);
    procedure lbURLClick(Sender: TObject);
    procedure DonateButtonClick(Sender: TObject);
    procedure LicenseButtonClick(Sender: TObject);
  private
    { Private declarations }
    Procedure LoadVersionInfo;
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

function GetBuildVersionDtl: widestring;

implementation

uses
  gnugettext, gnugettexthelpers, cUnicodeCodecs,
  Unit1, uVersion;

{$R *.dfm}

function GetBuildVersionDtl: widestring;
begin
  Result := ExtractFileVersionInfo(Application.ExeName,'FileVersion') + // do not localize
    BuildPatchLetter;
  if BuildFriendlyName <> '' then
    Result := Result + ' ' + BuildFriendlyName;
  if BuildPatchLetter <> '' then
    Result := Result + _(' (patched)');
end;

{ TfrmAbout }

procedure TfrmAbout.DonateButtonClick(Sender: TObject);
begin
  { Note: this is personal donation link for Dako (temporary placed here)
    TODO: Add support for team donation, or other personal links }
  ShellExecute(Handle, 'open', 'http://order.kagi.com/?6CYME&lang=en', '', '', SW_SHOWNORMAL); // do not localize
end;

procedure TfrmAbout.LoadVersionInfo;
begin
  lbVersion.Caption := WideFormat(_('Version %s'), [GetBuildVersionDtl]);;
  lbURL.Caption := ExtractFileVersionInfo(Application.ExeName,'URL'); // do not localize
  lbURL.Hint := lbURL.Caption;
end;

procedure TfrmAbout.FormCreate(Sender: TObject);
var
  i, ix, p: Integer;
  TR, LNG: TTntStringList;
  S, S1, Translators: WideString;
begin
  TP_Ignore(self, 'lbURL'); // do not localize

  // Disable automatical translation. It does not work :/
  TP_Ignore(Self, 'CreditsText'); // do not locailze

  gghTranslateComponent(self);

{$IFDEF VER150}
  Panel1.ParentBackground := False;
{$ENDIF}

  lbURL.Font.Color := clBlue;
  lbURL.Font.Style := [fsUnderline];

  //Image1.Picture.Assign(Form1.CommonBitmaps.Bitmap[1]);
  Image3.Picture.Assign(Form1.CommonBitmaps.Bitmap[2+byte(IsRightToLeft)]);
  LoadVersionInfo;

  // Find translators names position in the text.
  ix := CreditsText.Lines.IndexOf('<localization-list>'); // do not localize
  CreditsText.Lines.Delete(ix);

  // Manually translate the memo text.
  for I := 0 to CreditsText.Lines.Count do
  begin
    if CreditsText.Lines[I] <> '' then
      CreditsText.Lines[I] := _(CreditsText.Lines[I]);
  end;

  // Add the translator names.
  TR := TTntStringList.Create;
  LNG := TTntStringList.Create;
  try
    gghGetTranslatorsList(TR, LNG);
    for i := TR.Count-1 downto 0 do
      if Trim(TR[i])='' then
        begin
          TR.Delete(i);
          LNG.Delete(i);
        end;
    for i := TR.Count-1 downto 0 do
      begin
        Translators := '';
        // Text is UTF8 encoded. Bug in dxgettext? I have already reported it as bug, so we will see
        S1 := UTF8StringToWideString(TR[i]);
        while S1<>'' do
          begin
            p := Pos(WideChar(','), S1);
            if p=0 then
              begin
                S := S1;
                S1 := '';
              end
            else
              begin
                S := Copy(S1,1,p-1);
                S1 := Copy(S1,p+1,MaxInt);
              end;
            p := WideLastDelimiter('<', S);
            if p>0 then S := Trim(Copy(S,1,p-1));
            Translators := Translators + ', ' + S;
          end;
        Delete(Translators,1,2);
        S := gghGetLocalizedLanguageName(LNG[i], LNG) + ': ' + Translators;
        if i <> TR.Count-1 then S := S + ',';
        CreditsText.Lines.Insert(ix, S);
      end;
    //if TR.Count = 0 then CreditsText.Lines.Insert(ix, _('none'));
  except
  end;
end;

procedure TfrmAbout.lbURLClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar(String(TTntLabel(Sender).Hint)), '', '', SW_SHOWNORMAL); // do not localize
end;

procedure TfrmAbout.LicenseButtonClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar(ExtractFilePath(Application.ExeName)+'General Public License.rtf'), // do not localize
    '', '', SW_SHOWNORMAL);
end;

end.

