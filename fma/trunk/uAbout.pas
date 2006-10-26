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
  Graphics, TntGraphics;

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
function GetBuildVersion: widestring;

implementation

uses
  gnugettext, gnugettexthelpers, cUnicodeCodecs,
  Unit1, uVersion;

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

procedure TfrmAbout.DonateButtonClick(Sender: TObject);
begin
  { Note: this is personal donation link for Dako (temporary placed here)
    TODO: Add support for team donation, or other personal links }
  ShellExecute(Handle, 'open', 'http://order.kagi.com/?6CYME&lang=en', '', '', SW_SHOWNORMAL); // do not localize
end;

procedure TfrmAbout.LoadVersionInfo;
begin
  lbVersion.Caption := WideFormat(_('Version %s'), [GetBuildVersion]);;
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

