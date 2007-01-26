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
*
*******************************************************************************
}

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, StdCtrls, TntStdCtrls, ExtCtrls, TntExtCtrls, ShellApi,
  Graphics, TntGraphics, JvGIF, jpeg;

{$I uAbout.inc}

type
  TfrmAbout = class(TTntForm)
    OkButton: TTntButton;
    Bevel2: TTntBevel;
    Panel1: TTntPanel;
    MainLabel: TTntLabel;
    Image3: TTntImage;
    Label12: TTntLabel;
    ContributorsPanel: TTntPanel;
    CreditsText: TTntMemo;
    lbForumsURL: TTntLabel;
    TntLabel1: TTntLabel;
    lbLicenseURL: TTntLabel;
    TntLabel3: TTntLabel;
    lbDonateURL: TTntLabel;
    lbVersion: TTntLabel;
    MoreButton: TTntButton;
    BackgroundImage: TImage;
    procedure FormCreate(Sender: TObject);
    procedure OpenWebLinkClick(Sender: TObject);
    procedure MoreButtonClick(Sender: TObject);
    procedure TntFormShow(Sender: TObject);
  private
    { Private declarations }
    Procedure LoadVersionInfo;
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

function GetBuildVersionDtl: widestring;
function GetBuildVersion: widestring;

implementation

uses
  gnugettext, gnugettexthelpers, cUnicodeCodecs,
  Unit1, uVersion, JclSysInfo;

{$R *.dfm}

function GetBuildVersionDtl: widestring;
begin
  {
  Result := ExtractFileVersionInfo(Application.ExeName,'FileVersion') + // do not localize
    BuildPatchLetter;
  }
  Result := ExtractFileVersionInfo(Application.ExeName,'ProductVersion') + ' Build ' + // do not localize
    IntToStr(SvnRevision);
  if BuildFriendlyName <> '' then
    Result := Result + ' ' + BuildFriendlyName;
  {
  if BuildPatchLetter <> '' then
    Result := Result + ' ' + _('(patched)');
  }
end;

function GetBuildVersion: widestring;
begin
  Result := ExtractFileVersionInfo(Application.ExeName,'FileVersion') + '.R' + IntToStr(SvnRevision); // do not localize
end;

{ TfrmAbout }

procedure TfrmAbout.LoadVersionInfo;
begin
  lbVersion.Caption := WideFormat(_('Version %s'), [GetBuildVersion]);
  lbLicenseURL.Hint := ExtractFilePath(Application.ExeName)+'General Public License.rtf';
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

  lbForumsURL.Font.Color := clBlue;
  lbForumsURL.Font.Style := lbForumsURL.Font.Style + [fsUnderline];
  lbDonateURL.Font.Assign(lbForumsURL.Font);
  lbLicenseURL.Font.Assign(lbForumsURL.Font);

  TntLabel1.Left := lbForumsURL.Left + lbForumsURL.Width;
  lbLicenseURL.Left := TntLabel1.Left + TntLabel1.Width;
  TntLabel3.Left := lbLicenseURL.Left + lbLicenseURL.Width;
  lbDonateURL.Left := TntLabel3.Left + TntLabel3.Width;

  BackgroundImage.Picture.Assign(Form1.CommonBitmaps.Bitmap[1]);
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

procedure TfrmAbout.OpenWebLinkClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar(String(TTntLabel(Sender).Hint)), '', '', SW_SHOWNORMAL); // do not localize
end;

procedure TfrmAbout.MoreButtonClick(Sender: TObject);
begin
  if MoreButton.Tag = 1 then begin
    MoreButton.Tag := 0;
    MoreButton.Caption := _('Credits');
    ContributorsPanel.Visible := False;
    BackgroundImage.Visible := True;
    MainLabel.Caption := _(
      '©2003-2007 by Contributors. All Rights Reserved. FMA, floAt''s and floAt''s Mobile Agent texts ' +
      'and green logo are copyright work of the FMA Team. Some parts in this project used under terms ' +
      'and agreements of FMA License Agreement are available under separate third party licenses too. ' +
      'Please refer to product''s documentation for more information.') + sLineBreak + sLineBreak +
      WideFormat(_('FMA 2.2 Stable (System: %s %s, Version: %d.%d, Build: %x, "%s")'),
        [GetWindowsVersionString, NtProductTypeString, Win32MajorVersion, Win32MinorVersion,
         Win32BuildNumber, Win32CSDVersion]);
  end
  else begin
    MoreButton.Tag := 1;
    MoreButton.Caption := _('Notices');
    ContributorsPanel.Visible := True;
    BackgroundImage.Visible := False;
    MainLabel.Caption := _('These are the project contributors (in order of appearance):');
  end;
end;

procedure TfrmAbout.TntFormShow(Sender: TObject);
begin
  { Update view }
  MoreButton.Tag := 1;
  MoreButtonClick(nil);
end;

end.
