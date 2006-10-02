unit WebUpdateWizard;

{
*******************************************************************************
* Descriptions: Web Update for FMA
* $Source: /cvsroot/fma/fma/components/WebUpdateWizard.pas,v $
* $Locker:  $
*
* TODO:
*
* Change Log:
* $Log: WebUpdateWizard.pas,v $
* Revision 1.14.2.8  2006/03/14 12:15:19  z_stoichev
* Fixed Hide FMA from Taskbar during Web update.
*
* Revision 1.14.2.7  2005/10/04 15:29:16  z_stoichev
* Optimizations.
*
* Revision 1.14.2.6  2005/10/02 22:30:51  z_stoichev
* Patch delay changes.
*
* Revision 1.14.2.5  2005/09/20 09:04:24  z_stoichev
* GUI changes.
*
* Revision 1.18  2005/09/02 14:46:34  z_stoichev
* GUI fixes.
*
* Revision 1.17  2005/09/02 13:03:52  z_stoichev
* Fixed Statrup Web Update when new version found.
*
* Revision 1.16  2005/09/01 09:11:13  z_stoichev
* - Fixed AV errors on WebUpdate intermediate restart.
* - Changed WebUpdate Wizard show notes in new page.
*
* Revision 1.15  2005/08/29 14:02:16  z_stoichev
* Added Mirrors support.
* Various bugfixes and GUI changes.
*
* Revision 1.14  2005/03/13 00:03:22  z_stoichev
* Fixed: Web Update wrong target build shown.
*
* Revision 1.13  2005/02/11 16:06:02  z_stoichev
* Fixed List index out of bounds on Ready to Install page.
*
* Revision 1.12  2005/02/10 11:39:28  z_stoichev
* Fixed details information messages.
* Confirm exit on window X button click.
*
* Revision 1.11  2005/02/09 14:05:44  z_stoichev
* Fixed #13#10 to sLinebreak.
*
* Revision 1.10  2005/02/09 13:22:59  z_stoichev
* Fixed MessageBoxW text wrapping.
* Fixed Next button caption.
* Wizard pages indexes as constants.
* Changed caption buttons.
*
* Revision 1.9  2005/02/08 15:39:08  voxik
* Merged with L10N branch
*
* Revision 1.5.12.3  2005/02/02 23:16:10  voxik
* Changed MessageDlg and ShowMessages replaced by new unicode versions
*
* Revision 1.5.12.2  2005/01/07 17:57:48  expertone
* Merge with MAIN branch
*
* Revision 1.8  2004/12/21 11:38:42  z_stoichev
* New Wizard bugfixes
*
* Revision 1.7  2004/12/20 16:30:28  z_stoichev
* New Web Update Wizard
*
* Revision 1.6  2004/12/18 19:18:45  voxik
* Fixed D7 used parent color for WebUpdateWizard
*
* Revision 1.5.12.1  2004/10/25 20:45:48  expertone
* initial localization (gnugettext)
*
* Revision 1.5  2004/05/19 18:34:20  z_stoichev
* Build 0.1.0.35c
*
* Revision 1.4  2004/03/20 16:25:22  z_stoichev
* FindPossibleVersions implemented
* Added Web Update Wizard installation/help hints.
*
* Revision 1.3  2004/03/09 10:31:58  z_stoichev
* Browse for local update fixes.
*
* Revision 1.2  2004/03/07 14:35:12  z_stoichev
* Added Ready to Install wizard page.
*
* Revision 1.1  2004/03/07 11:39:19  z_stoichev
* Initial release.
*
*
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, StdCtrls, TntStdCtrls, CheckLst, TntCheckLst, ExtCtrls, TntExtCtrls,
  jpeg, ComCtrls, TntComCtrls;

const
  WM_NEXTWPAGE = WM_USER + 101;
  WM_PREVWPAGE = WM_USER + 102;

  { Wizard pages indexes }
  piWelcome       = 0;
  piMirrors       = 1;
  piUpdates       = 2;
  piReadyDownload = 3;
  piReadyInstall  = 4;
  piInstall       = 5;
  piCompleted     = 6;
  piFinished      = 7;

type
  TWebUpdateHintState = (noOK,noNewVersion,noWebUpdates,noPatchTool);

  TWebUpdateGetDetails = function (const FromVersionSignature, ToVersionSignature: string;
    Path: TStrings): Int64 of object;

  TfrmWebUpdate = class(TTntForm)
    NextButton: TTntButton;
    CancelButton: TTntButton;
    Bevel1: TTntBevel;
    PreviousButton: TTntButton;
    OpenDialog1: TTntOpenDialog;
    nbWizard: TNotebook;
    Label2: TTntLabel;
    lblNameVer: TTntLabel;
    imgWarning: TTntImage;
    lbWarning: TTntLabel;
    RadioButton1: TTntRadioButton;
    edLocal: TTntEdit;
    BrowseButton: TTntButton;
    RadioButton2: TTntRadioButton;
    RadioButton3: TTntRadioButton;
    memNotes: TTntMemo;
    imgReady: TTntImage;
    lbReady: TTntLabel;
    FinishedPanel: TTntPanel;
    imgWizard: TTntImage;
    lbDescription: TTntLabel;
    lbProductName: TTntLabel;
    WelcomePanel: TTntPanel;
    imgFinished: TTntImage;
    lblFinished: TTntLabel;
    Label3: TTntLabel;
    lblWelcomeNext: TTntLabel;
    imgSetup: TTntImage;
    lblCurrentTask: TTntLabel;
    pbUpdate: TTntProgressBar;
    lblUpdate: TTntLabel;
    TopPanel1: TTntPanel;
    TopDetailsLabel1: TTntLabel;
    TopBevel1: TTntBevel;
    TopCaptionLabel1: TTntLabel;
    imgWizardSmall1: TTntImage;
    TopPanel2: TTntPanel;
    TopDetailsLabel2: TTntLabel;
    TopBevel2: TTntBevel;
    TopCaptionLabel2: TTntLabel;
    imgWizardSmall2: TTntImage;
    TopPanel3: TTntPanel;
    TopDetailsLabel3: TTntLabel;
    TopBevel3: TTntBevel;
    TopCaptionLabel3: TTntLabel;
    imgWizardSmall3: TTntImage;
    TopPanel4: TTntPanel;
    TopDetailsLabel4: TTntLabel;
    TopBevel4: TTntBevel;
    TopCaptionLabel4: TTntLabel;
    imgWizardSmall4: TTntImage;
    TopPanel6: TTntPanel;
    TopDetailsLabel6: TTntLabel;
    TopBevel6: TTntBevel;
    TopCaptionLabel6: TTntLabel;
    imgWizardSmall6: TTntImage;
    TopPanel5: TTntPanel;
    TopDetailsLabel5: TTntLabel;
    TopBevel5: TTntBevel;
    TopCaptionLabel5: TTntLabel;
    imgWizardSmall5: TTntImage;
    Label5: TTntLabel;
    Label6: TTntLabel;
    memDownload: TTntMemo;
    memCompleted: TTntMemo;
    Label8: TTntLabel;
    rbMirrorDefault: TTntRadioButton;
    Label9: TTntLabel;
    rbMirrorCustom: TTntRadioButton;
    clMirrors: TTntCheckListBox;
    gbNumbers: TTntGroupBox;
    lblVersionInfo: TTntLabel;
    cbDeleteUpdates: TTntCheckBox;
    DetailsButton: TTntButton;
    mmoVersionInfo: TTntMemo;
    lblTotal: TTntLabel;
    pbTotal: TTntProgressBar;
    Label10: TTntLabel;
    clNumbers: TTntCheckListBox;
    Panel1: TPanel;
    procedure RadioButtonClick(Sender: TObject);
    procedure NextButtonClick(Sender: TObject);
    procedure clNumbersClickCheck(Sender: TObject);
    procedure BrowseButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PreviousButtonClick(Sender: TObject);
    procedure nbWizardPageChanged(Sender: TObject);
    procedure rbMirrorDefaultClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure DetailsButtonClick(Sender: TObject);
    procedure TntFormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TntFormShow(Sender: TObject);
  private
    { Private declarations }
    FCreated,FLocalize,FCanceled,FExiting: boolean;
    FUpdateState: TWebUpdateHintState;
    FOnGetDetails: TWebUpdateGetDetails;
    FOnReadyToDownload: TNotifyEvent;
    procedure Set_Notes(const Value: string);
    function Get_Notes: string;
    procedure Set_Ready(const Value: string);
    function Get_Ready: string;
    procedure WizardPageNext(var Msg: TMessage); message WM_NEXTWPAGE;
    procedure WizardPagePrevious(var Msg: TMessage); message WM_PREVWPAGE;
    function Get_CleanupNeeded: boolean;
  public
    { Public declarations }
    constructor CreateImg(AOwner: TComponent; AImage,AImageSmall: TPicture; AStatus: string = '';
      UseLocales: Boolean = True; UsePosition: TPosition = poMainFormCenter);
    procedure ShowWarning(AText: string; AType: TWebUpdateHintState);
    procedure ShowStatus(AText: string; HideProgress: boolean = True);
    procedure ShowProgress(Percents: integer);
    procedure ShowTotalProgress(Current,Total: integer);
    function CheckedCount: integer;
    function CheckedIndex: integer;
    function SelectedCustomMirrors: TIntegerSet;
    function ReadyToInstall(UserText: string = ''): boolean;
    function UpdateCompleted(NotesText: string = ''): boolean;
    property Notes: string read Get_Notes write Set_Notes;
    property Ready: string read Get_Ready write Set_Ready;
  published
    property IsCanceled: boolean read FCanceled;
    property IsCleanupNeeded: boolean read Get_CleanupNeeded;
    property OnGetDetails: TWebUpdateGetDetails read FOnGetDetails write FOnGetDetails;
    property OnReadyToDownload: TNotifyEvent read FOnReadyToDownload write FOnReadyToDownload;
  end;

var
  frmWebUpdate: TfrmWebUpdate;

implementation

{$R *.dfm}

uses
  gnugettext,
  uolSelectPatchPath, uDialogs;

procedure TfrmWebUpdate.RadioButtonClick(Sender: TObject);
begin
  clNumbers.Enabled := RadioButton2.Checked;
  mmoVersionInfo.Enabled := clNumbers.Enabled;
  lblVersionInfo.Enabled := clNumbers.Enabled and (CheckedCount <> 0);
  edLocal.Enabled := RadioButton1.Checked;
  if edLocal.Enabled then edLocal.Color := clWindow
    else edLocal.Color := clBtnFace;
  BrowseButton.Enabled := edLocal.Enabled;
end;

function TfrmWebUpdate.CheckedCount: integer;
var
  i: integer;
begin
  if RadioButton2.Checked then begin
    Result := 0;
    for i := 0 to clNumbers.Count-1 do
      if clNumbers.Checked[i] then Result := Result + 1;
  end
  else
    Result := 1;
end;

procedure TfrmWebUpdate.clNumbersClickCheck(Sender: TObject);
var
  i,j: integer;
  sl: TStringList;
begin
  mmoVersionInfo.Clear;
  i := clNumbers.ItemIndex;
  if i <> -1 then begin
    for j := 0 to clNumbers.Count-1 do clNumbers.Checked[j] := False;
    clNumbers.Checked[i] := clNumbers.ItemEnabled[i];
  end;
  i := CheckedIndex;
  if i <> -1 then begin
    if Assigned(FOnGetDetails) then begin
      sl := TStringList.Create;
      try
        i := FOnGetDetails(lblNameVer.Caption,clNumbers.Items[i],sl);
        lblVersionInfo.Caption := _('Updates needed (')+IntToStr(i div 1024)+' '+_('Kb)');
        mmoVersionInfo.Text := '';
        for j := 0 to sl.Count-1 do begin
          mmoVersionInfo.Text := mmoVersionInfo.Text + sl[j];
          if j < sl.Count-1 then mmoVersionInfo.Text := mmoVersionInfo.Text + sLineBreak;
        end;
        mmoVersionInfo.SelStart := 0;
        mmoVersionInfo.SelLength := 0;
      finally
        sl.Free;
      end;
    end
    else
      lblVersionInfo.Caption := _('Details are not available.');
    lblVersionInfo.Enabled := True;
  end
  else begin
    lblVersionInfo.Caption := _('(select custom version to view its details)');
    lblVersionInfo.Enabled := False;
  end;
end;

procedure TfrmWebUpdate.BrowseButtonClick(Sender: TObject);
begin
  if edLocal.Text <> '' then begin
    OpenDialog1.FileName := edLocal.Text;
    OpenDialog1.InitialDir := ExtractFileDir(edLocal.Text);
  end
  else
    OpenDialog1.InitialDir := ExtractFileDir(Application.ExeName);
  if OpenDialog1.Execute then edLocal.Text := OpenDialog1.FileName;
end;

constructor TfrmWebUpdate.CreateImg(AOwner: TComponent; AImage,AImageSmall: TPicture; AStatus: string;
  UseLocales: Boolean; UsePosition: TPosition);
begin
  FLocalize := UseLocales;
  Create(AOwner);
  Position := UsePosition;
  if Assigned(AImage) and Assigned(AImage.Graphic) and not AImage.Graphic.Empty then
    imgWizard.Picture.Assign(AImage);
  if Assigned(AImageSmall) and Assigned(AImageSmall.Graphic) and not AImageSmall.Graphic.Empty then
    imgWizardSmall1.Picture.Assign(AImageSmall);
  { Populate dublicate images }
  if not imgWarning.Picture.Graphic.Empty then imgReady.Picture.Assign(imgWarning.Picture);
  if Assigned(imgWizard.Picture.Graphic) and not imgWizard.Picture.Graphic.Empty then
    imgFinished.Picture.Assign(imgWizard.Picture);
  if Assigned(imgWizardSmall1.Picture.Graphic) and not imgWizardSmall1.Picture.Graphic.Empty then begin
    imgWizardSmall2.Picture.Assign(imgWizardSmall1.Picture);
    imgWizardSmall3.Picture.Assign(imgWizardSmall1.Picture);
    imgWizardSmall4.Picture.Assign(imgWizardSmall1.Picture);
    imgWizardSmall5.Picture.Assign(imgWizardSmall1.Picture);
    imgWizardSmall6.Picture.Assign(imgWizardSmall1.Picture);
  end;
  nbWizard.PageIndex := piWelcome;
  { Should we display Install page? }
  if Trim(AStatus) <> '' then ShowStatus(AStatus);
end;

function TfrmWebUpdate.ReadyToInstall(UserText: string): boolean;
begin
  { update GUI as for Ready page }
  nbWizard.PageIndex := piReadyInstall;
  if Trim(UserText) = '' then
    UserText := _('The application Web Update Wizard is ready to install downloaded updates.'+
      sLinebreak+sLinebreak+
      'While doing so the application should be restarted in order to apply updates. If '+
      'you have some unsaved data or settings, please exit now and save them, then go '+
      'back to Web Update Wizard. The updates will not be downloaded again.'+
      sLinebreak+sLinebreak+
      'When the installation completed, application will be restarted once more with '+
      'new updates applied (it might contains any bugfixes and improvement, or any new '+
      'features as well).');
  Ready := UserText;
  Result := ShowModal = mrOk;
end;

function TfrmWebUpdate.UpdateCompleted(NotesText: string): boolean;
var
  i: integer;
  s,Errors: string;
begin
  { update GUI as for Finished page }
  nbWizard.PageIndex := piCompleted;
  memCompleted.Text := NotesText;
  Errors := '';
  for i := 0 to memCompleted.Lines.Count-1 do begin
    s := memCompleted.Lines[i];
    { UOLPatch.dll will report any errors starting with "LU: " on new line }
    if Pos('LU: ',s) = 1 then begin // do not localize
      if Errors = '' then Errors := _('Update failed due to following reasons:') + sLineBreak+sLineBreak;
      Delete(s,1,3);
      Errors := Errors + '- ' + s + sLineBreak;
    end;
  end;
  Notes := Errors;
  Result := ShowModal = mrOk;
end;

procedure TfrmWebUpdate.Set_Notes(const Value: string);
begin
  memNotes.Text := Value;
  lblFinished.Caption := _('You have completed all update tasks.');
  memNotes.Visible := False;
  DetailsButton.Visible := Trim(Value) <> '';
  if DetailsButton.Visible then
    lblFinished.Caption := _('Update process failed! Click on Details to view error messages.');
end;

function TfrmWebUpdate.Get_Notes: string;
begin
  Result := memNotes.Text;
end;

function TfrmWebUpdate.Get_Ready: string;
begin
  Result := lbReady.Caption;
end;

procedure TfrmWebUpdate.Set_Ready(const Value: string);
begin
  if Value <> lbReady.Caption then begin
    lbReady.Caption := Value;
    lbReady.Visible := Value <> '';
    imgReady.Visible := lbReady.Visible;
  end;
end;

procedure TfrmWebUpdate.ShowWarning(AText: string; AType: TWebUpdateHintState);
begin
  FUpdateState := AType;
  lblWelcomeNext.Visible := True;
  NextButton.Enabled := True;
  if AText <> '' then begin
    { Show warning message (hint) }
    lbWarning.Caption := AText;
    lbWarning.Visible := True;
    imgWarning.Visible := True;
    case AType of
      noPatchTool: begin
        { Fatal, disable next wizard page }
        lblWelcomeNext.Visible := False;
        NextButton.Enabled := False;
      end;
      noWebUpdates: begin
        { Non-fatal, so leave local updates enabled, disable web updates }
        RadioButton1.Checked := True;
        RadioButtonClick(nil);
        RadioButton2.Visible := False;
        RadioButton3.Visible := False;
        clNumbers.Visible := False;
        gbNumbers.Visible := False;
      end;
      noNewVersion: begin
        RadioButton3.Visible := False;
      end;
    end;
  end
  else begin
    { No warning, enable all controls }
    lbWarning.Visible := False;
    imgWarning.Visible := False;
    RadioButton1.Visible := True;
    RadioButton2.Visible := True;
    RadioButton3.Visible := True;
    clNumbers.Visible := True;
    gbNumbers.Visible := True;
  end;
end;

procedure TfrmWebUpdate.FormCreate(Sender: TObject);
begin
  FUpdateState := noOK;
  FCanceled := False;
{$IFDEF VER150}
  WelcomePanel.ParentBackground := False;
  TopPanel1.ParentBackground := False;
  TopPanel2.ParentBackground := False;
  TopPanel3.ParentBackground := False;
  TopPanel4.ParentBackground := False;
  TopPanel5.ParentBackground := False;
  TopPanel6.ParentBackground := False;
  FinishedPanel.ParentBackground := False;
{$ENDIF}
  if FLocalize then
    TranslateComponent(Self);
  FCreated := True;
end;

procedure TfrmWebUpdate.WizardPageNext(var Msg: TMessage);
begin
  if nbWizard.PageIndex < nbWizard.Pages.Count-1 then
    nbWizard.PageIndex := nbWizard.PageIndex + 1;
end;

procedure TfrmWebUpdate.WizardPagePrevious(var Msg: TMessage);
begin
  if nbWizard.PageIndex > 0 then
    nbWizard.PageIndex := nbWizard.PageIndex - 1;
end;

procedure TfrmWebUpdate.NextButtonClick(Sender: TObject);
begin
  case nbWizard.PageIndex of
    piWelcome: begin { welcome }
         SendMessage(Handle,WM_NEXTWPAGE,0,0);
         if FUpdateState = noWebUpdates then
           SendMessage(Handle,WM_NEXTWPAGE,0,0);
       end;
    piMirrors: begin { mirrors }
         if rbMirrorCustom.Checked and (SelectedCustomMirrors = []) then begin
           MessageDlgW(_('You have to select at least one mirror.'),mtError, MB_OK);
           Abort;
         end;
         SendMessage(Handle,WM_NEXTWPAGE,0,0);
       end;
    piUpdates: begin { updates }
         if RadioButton1.Checked and not FileExists(edLocal.Text) then begin
           MessageDlgW(_('You have to select update file first.'),mtError, MB_OK);
           Abort;
         end;
         if RadioButton3.Checked then begin
           RadioButton2.Checked := True;
           clNumbers.ItemIndex := clNumbers.Count-1;
           clNumbersClickCheck(nil);
         end;
         if CheckedCount <> 1 then begin
           MessageDlgW(_('You have to select one target version.'),mtError, MB_OK);
           Abort;
         end;
         SendMessage(Handle,WM_NEXTWPAGE,0,0);
       end;
    piReadyDownload: begin { ready to download }
         { exit Wizard in order to download updates using ISXDL.DLL }
         if Assigned(FOnReadyToDownload) then FOnReadyToDownload(Self);
         FExiting := True;
         ModalResult := mrOk;
       end;
    piReadyInstall: begin { ready to install }
         { exit Wizard in order to restart application and patch it }
         FExiting := True;
         ModalResult := mrOk;
       end;
    piCompleted: begin { update completed }
         SendMessage(Handle,WM_NEXTWPAGE,0,0);
    end;   
    piFinished: begin { finished }
         { exit Wizard in order to restart the new application }
         FExiting := True;
         ModalResult := mrOk;
         { In case window is not shown as modal }
         Close;
       end;
  end;
end;

procedure TfrmWebUpdate.PreviousButtonClick(Sender: TObject);
begin
  case nbWizard.PageIndex of
    piWelcome: { welcome };
    piUpdates: begin { updates }
         SendMessage(Handle,WM_PREVWPAGE,0,0);
         if FUpdateState = noWebUpdates then
           SendMessage(Handle,WM_PREVWPAGE,0,0);
       end;
    else
      SendMessage(Handle,WM_PREVWPAGE,0,0);
  end;
end;

procedure TfrmWebUpdate.nbWizardPageChanged(Sender: TObject);
const
  sIdent = '    '; // do not localize
var
  s: String;
  i: Integer;
begin
  if not FCreated then exit;
  case nbWizard.PageIndex of
    piWelcome: begin { welcome }
         if RadioButton3.Visible then
           CancelButton.Caption := _('&Cancel')
         else
           CancelButton.Caption := _('&Finish');
         PreviousButton.Enabled := False;
       end;
    piMirrors: begin { mirrors }
         PreviousButton.Enabled := True;
         CancelButton.Caption := _('&Cancel');
       end;
    piUpdates: begin { updates }
         NextButton.Caption := _('&Next >');
       end;
    piReadyDownload: begin { ready to download }
         s := '';
         if FUpdateState = noWebUpdates then
           s := s + _('Web updates are not supported or not available yet')+sLinebreak+sLinebreak;
           
         if not RadioButton1.Checked then begin
           { TODO: s := s + ngettext('Using Web mirror:','Using Web mirrors:',XX) + sLinebreak; }
           s := s + _('Using Web mirrors:') + sLinebreak;
           if rbMirrorCustom.Checked then begin
             for i := 0 to clMirrors.Items.Count-1 do
               if clMirrors.Checked[i] then begin
                 s := s + sIdent + clMirrors.Items[i] + sLinebreak;
               end;
           end
           else
             s := s + sIdent + _('Vendor provided (default mirror)') + sLinebreak;
         end
         else
           s := s + _('Using local update:')+sLinebreak+sIdent+ExtractFileName(edLocal.Text) + sLinebreak;

         s := s + sLinebreak+_('Current version:')+sLinebreak+sIdent+WideFormat('Build %s',[lblNameVer.Caption]);
         s := s + sLinebreak+sLinebreak+_('Selected target:')+sLinebreak+sIdent;
         if RadioButton1.Checked then
           s := s + _('Build Unknown')
         else begin
           s := s + WideFormat('Build %s',[clNumbers.Items[CheckedIndex]]);
           if lblVersionInfo.Enabled then begin
             { display updates details }
             s := s + sLinebreak+sLinebreak+lblVersionInfo.Caption+sLineBreak;
             for i := 0 to mmoVersionInfo.Lines.Count-1 do
               s := s + sIdent+mmoVersionInfo.Lines[i]+sLineBreak;
           end;
         end;
         memDownload.Text := s;
         memDownload.Update;
         NextButton.Caption := _('&Download');
       end;
    piReadyInstall: begin { ready to install }
         PreviousButton.Enabled := False;
         NextButton.Caption := _('&Install');
       end;
    piInstall: begin { install }
         PreviousButton.Visible := False;
         NextButton.Visible := False;
       end;
    piCompleted: begin { update completed }
         PreviousButton.Visible := True;
         PreviousButton.Enabled := False;
         NextButton.Caption := _('&Next >');
         NextButton.Visible := True;
         CancelButton.Caption := _('&Finish');
         CancelButton.Enabled := True;
       end;
    piFinished: begin { finished }
         PreviousButton.Enabled := True;
         NextButton.Caption := _('&Finish');
         CancelButton.Caption := _('&Cancel');
         CancelButton.Enabled := False;
       end;
  end;
  if Visible and NextButton.Visible and NextButton.Enabled then NextButton.SetFocus;
end;

procedure TfrmWebUpdate.ShowProgress(Percents: integer);
begin
  { update GUI as for Install page }
  nbWizard.PageIndex := piInstall;
  pbUpdate.Position := Percents;
  pbTotal.Position := pbTotal.Tag*100 + pbUpdate.Position; // append to base total position
  pbUpdate.Visible := True;
  pbTotal.Visible := True;
  lblUpdate.Visible := True;
  lblTotal.Visible := True;
  if not Visible then Show;
  Update;
end;

procedure TfrmWebUpdate.ShowTotalProgress(Current, Total: integer);
begin
  { update GUI as for Install page }
  nbWizard.PageIndex := piInstall;
  pbUpdate.Position := 0;
  pbTotal.Tag := Current; // remember base total position
  pbTotal.Max := Total*100;
  pbTotal.Position := pbTotal.Tag*100;
  pbUpdate.Visible := True;
  pbTotal.Visible := True;
  lblUpdate.Visible := True;
  lblTotal.Visible := True;
  if not Visible then Show;
  Update;
end;

procedure TfrmWebUpdate.ShowStatus(AText: string; HideProgress: boolean);
begin
  { update GUI as for Install page }
  nbWizard.PageIndex := piInstall;
  lblCurrentTask.Caption := AText;
  FCanceled := False;
  if HideProgress then begin
    pbUpdate.Visible := False;
    pbTotal.Visible := False;
    lblUpdate.Visible := False;
    lblTotal.Visible := False;
  end;
  if not Visible then Show;
  Update;
end;

procedure TfrmWebUpdate.rbMirrorDefaultClick(Sender: TObject);
begin
  clMirrors.Enabled := rbMirrorCustom.Checked;
  {
  if clMirrors.Enabled then clMirrors.Color := clWindow
    else clMirrors.Color := clBtnFace;
  }
end;

procedure TfrmWebUpdate.CancelButtonClick(Sender: TObject);
begin
  case nbWizard.PageIndex of
    piInstall: begin { install page }
         FCanceled := True;
    end;
    piCompleted: begin { update completed }
         { exit Wizard in order to restart the new application }
         FExiting := True;
         ModalResult := mrOk;
         { In case window is not shown as modal }
         Close;
    end;
    else begin { all other pages }
         if (nbWizard.PageIndex = piWelcome) and not RadioButton3.Visible then begin
           { exit Wizard when using latest version }
           FExiting := True;
           ModalResult := mrCancel;
           { In case window is not shown as modal }
           Close;
         end
         else begin
           if MessageDlgW(_('The Wizard is not complete. Do you realy want to exit it?'+
             sLinebreak+sLinebreak+'You can run this wizard at a later time to complete it.'+
             sLinebreak+sLinebreak+'To exit Wizard right now click Yes. To continue click No.'),
             mtConfirmation, MB_YESNO) = ID_YES then begin
             FExiting := True;
             ModalResult := mrCancel;
           end;
         end;
    end;
  end;
end;

function TfrmWebUpdate.CheckedIndex: integer;
var
  i: integer;
begin
  Result := -1;
  if CheckedCount = 1 then
    for i := 0 to clNumbers.Count-1 do
      if clNumbers.Checked[i] then begin
        Result := i;
        break;
      end;
end;

function TfrmWebUpdate.Get_CleanupNeeded: boolean;
begin
  Result := cbDeleteUpdates.Checked;
end;

procedure TfrmWebUpdate.DetailsButtonClick(Sender: TObject);
begin
  DetailsButton.Visible := False;
  memNotes.Visible := True;
end;

procedure TfrmWebUpdate.TntFormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if CancelButton.Enabled and not FExiting then begin
    CancelButton.Click;
    if not FExiting then begin
      ModalResult := mrNone;
      CanClose := False;
    end;
  end;
end;

function TfrmWebUpdate.SelectedCustomMirrors: TIntegerSet;
var
  i: Integer;
begin
  Result := [];
  if rbMirrorCustom.Checked then
    try
      { TODO: make sure i <= (SizeOf(Integer)*8 - 1) }
      for i := 0 to clMirrors.Count-1 do
        if clMirrors.Checked[i] then Result := Result + [byte(i)];
    except
    end;
end;

procedure TfrmWebUpdate.TntFormShow(Sender: TObject);
begin
  if nbWizard.PageIndex > piReadyInstall then
    ShowWindow(Application.Handle,SW_HIDE);
  nbWizardPageChanged(nbWizard);
end;

end.

