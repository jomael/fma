unit uCalling;

{
*******************************************************************************
* Descriptions: Calling/Called Popup Implementation
* $Source: /cvsroot/fma/fma/uCalling.pas,v $
* $Locker:  $
*
* Todo:
*   - Update to support note taking for the active caller
*
* Change Log:
* $Log: uCalling.pas,v $
* Revision 1.16.2.9  2006/03/21 19:49:28  mhr3
* Fixed crash on call hangup
*
* Revision 1.16.2.8  2006/03/15 13:43:31  z_stoichev
* GUI changes and optimizations.
*
* Revision 1.16.2.7  2006/03/15 10:18:24  z_stoichev
* Fixed New Call popup dialog remove resize flag.
*
* Revision 1.16.2.6  2005/12/09 13:29:20  z_stoichev
* - Fixed Update missed calls when minimized.
* - Added Notification icon for missing calls.
* - Added Notification icon for new messages.
*
* Revision 1.16.2.5  2005/09/06 18:32:55  z_stoichev
* Bugfixes and improvements (2.1.1.102b)
*
* Revision 1.16.2.4  2005/08/20 18:09:06  z_stoichev
* - Fixed Personalize Call/New message dialog semafor usage.
* - Fixed Find contact in Phonebook (Irmc), Phone Book, SIM.
*
* Revision 1.16.2.3  2005/08/19 12:14:08  z_stoichev
* GUI fixes.
*
* Revision 1.16.2.2  2005/08/18 17:13:47  z_stoichev
* - Added support for JPEG2000 images.
* - Fixed GIF images displaying issue.
*
* Revision 1.16.2.1  2005/08/17 09:13:00  z_stoichev
* Safe close call window if disconnected.
*
* Revision 1.16  2005/02/08 15:38:33  voxik
* Merged with L10N branch
*
* Revision 1.14.12.4  2005/02/02 23:15:51  voxik
* Changed MessageDlg and ShowMessages replaced by new unicode versions
*
* Revision 1.14.12.3  2005/01/07 17:34:29  expertone
* Merge with MAIN branch
*
* Revision 1.15  2004/12/21 13:59:48  z_stoichev
* Fixed: Incoming call without personalization.
*
* Revision 1.14.12.2  2004/10/25 20:21:38  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.14.12.1  2004/10/19 19:48:30  expertone
* Add localization (gnugettext)
*
* Revision 1.14  2004/07/07 09:41:41  z_stoichev
* Common image usage
* bugfixes.
*
* Revision 1.13  2004/07/06 14:06:52  z_stoichev
* - Added Personalization default contact image.
*
* Revision 1.12  2004/06/29 15:23:54  z_stoichev
* Add Call support without popups.
*
* Revision 1.11  2004/06/29 10:46:54  z_stoichev
* Updated personalization
* Added Call notes support
*
* Revision 1.10  2004/06/28 23:02:21  z_stoichev
* Personalization and GUI changed.
*
* Revision 1.9  2004/06/15 15:30:30  z_stoichev
* - Added Default Ringing sound support.
* - Added Default Busy sound support.
* - Added Handle RING signals (default sound).
* - Added Second Incoming call is ignored.
* - Added Cancel Incoming call silently support.
* - Added Cancel Outgoing call warning message.
*
* Revision 1.8  2004/06/08 19:19:25  lordlarry
* Memory Leak fixed
*
* Revision 1.7  2003/12/11 14:08:02  z_stoichev
* Fixed Command return error on answer.
* Timer and sound start adjusted to match phone ones.
* Handle some possible exceptions.
*
* Revision 1.6  2003/11/28 09:38:07  z_stoichev
* Merged with branch-release-1-1 (Fma 0.10.28c)
*
* Revision 1.5.2.8  2003/11/21 13:34:11  z_stoichev
* Fixed headset button mark call as missed issue.
*
* Revision 1.5.2.7  2003/11/14 15:41:02  z_stoichev
* Updates for patch 27d.
*
* Revision 1.5.2.6  2003/11/13 16:35:39  z_stoichev
* Fixed personalization support.
*
* Revision 1.5.2.5  2003/11/12 16:48:52  z_stoichev
* Do not show error on missing sound file.
*
* Revision 1.5.2.4  2003/11/12 15:19:03  z_stoichev
* Temporary disconnect phone (during call) support.
* Image auto-scale to fit.
*
* Revision 1.5.2.3  2003/11/11 18:11:06  z_stoichev
* Add background image.
* Show contact picture and play sound
* if personalized in phonebook.
*
* Revision 1.5.2.2  2003/10/31 14:51:15  z_stoichev
* Added headset button (disconnect on answer).
*
* Revision 1.5.2.1  2003/10/27 07:22:54  z_stoichev
* Build 0.1.0 RC1 Initial Checkin.
*
* Revision 1.5  2003/10/15 15:49:55  z_stoichev
* MIssed Calls Unicode support.
* GUI changes.
*
* Revision 1.4  2003/02/17 06:51:16  crino77
* Added support for missed calls
*
* Revision 1.3  2003/01/30 04:15:57  warren00
* Updated with header comments
*
*
*******************************************************************************
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, StdCtrls, TntStdCtrls, Placemnt, GR32_Image, ExtCtrls, TntExtCtrls, MPlayer,
  jpeg, MMSystem, uSyncPhonebook;

type
  TfrmCalling = class(TTntForm)
    HandupButton: TTntButton;
    AnswerButton: TTntButton;
    FormPlacement1: TFormPlacement;
    lbAlpha: TTntLabel;
    lbNumber: TTntLabel;
    HeadsetButton: TTntButton;
    ImagePanel: TTntPanel;
    Image32: TImage32;
    MediaPlayer1: TMediaPlayer;
    Image1: TTntImage;
    lblTime: TTntLabel;
    TimeTimer: TTimer;
    Memo: TTntMemo;
    procedure CallButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MediaPlayer1Notify(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure TimeTimerTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    FContactData: TContactData;
    FNotesContact: PContactData;
    FStartTime: TDateTime;
    FCreated,FPersonalized,FPersonalizedSem,FStopped: boolean;
    FIsIncoming: Boolean;
    FRingSecs,FRingOn: integer;
    FCheck,FCalling: Boolean;
    FCustomImage: Boolean;
    procedure Set_IsIncoming(const Value: Boolean);
    function Get_Busy: Boolean;
    procedure Set_Busy(const Value: Boolean);
    procedure Set_CustomImage(const Value: Boolean);
    procedure DoStopPersonalize(Exiting: boolean = True);
  public
    { Public declarations }
    procedure CreateCall(Number: WideString; Popup: boolean; AlphaBlend: Integer);
    procedure CloseCall(CanClose: boolean = True; CanHangUp: boolean = True);
    procedure DoExiting;
    procedure DoInCall;
    procedure DoPersonalize;
    procedure DoShowNotes;
    procedure DoResizeWide;
    function HasPersonalizedSound: boolean;
  published
    property IsCreated: Boolean read FCreated;
    property IsIncoming: Boolean read FIsIncoming write Set_IsIncoming;
    property IsTalking: Boolean read FCheck write FCheck;     { means: Are we picked up the call }
    property IsCalling: Boolean read FCalling write FCalling; { means: Should we hang up or not on exit? }
    property IsPersonalized: Boolean read FPersonalized;      { means: Do we have personalized contact? }
    property IsCustomImage: Boolean read FCustomImage write Set_CustomImage;
    property IsBusy: Boolean read Get_Busy write Set_Busy;    { means: Is busy signal detected? }
  end;

var
  frmCalling: TfrmCalling;

implementation

uses
  gnugettext, gnugettexthelpers,
  uImg32Helper, Unit1, uMissedCalls, uDialogs, uSIMEdit;

const
  DefRingOutgoingSecs = 5;

{$R *.dfm}

procedure TfrmCalling.CallButtonClick(Sender: TObject);
begin
  if Sender = HandupButton then begin
    DoExiting;
    try
      Form1.VoiceHangUp;
    except
    end;
  end
  else
  if Sender = AnswerButton then begin
    DoInCall;
    try
      Form1.VoiceAnswer;
    except // Error may occur if call is alerady active...
    end;
    FCheck := True;
    if Visible and Memo.Visible then
      Memo.SetFocus;
  end
  else
  if Sender = HeadsetButton then begin
    DoInCall;
    try
      Form1.VoiceAnswer;
    except
    end;
    FCheck := True;
    Form1.DoDisconnectTemporary;
  end;
  (Sender As TTntButton).Enabled := False;
end;

procedure TfrmCalling.FormShow(Sender: TObject);
begin
  SetWindowPos(Handle, HWND_TOPMOST,
    Top, Left, Width, Height,
    SWP_NOACTIVATE or SWP_NOSIZE);
end;

procedure TfrmCalling.DoPersonalize;
var
  s: string;
  ContactName: WideString;
  Where: TFindContactResult;
begin
  { Try to lookup caller and load personalized info about the contact }
  if not FPersonalizedSem then begin
    FPersonalizedSem := True; // allow it only once
    { Lookup contact name }
    if (lbAlpha.Caption = sUnknownNumber) or (lbAlpha.Caption = sUnknownContact) then
      lbAlpha.Caption := Form1.LookupContact(lbNumber.Caption,lbAlpha.Caption);
    { Resize window if needed }
    DoResizeWide;
    { Personalize }
    ContactName := Form1.ExtractContact(lbAlpha.Caption);
    Where := Form1.WhereisContact(ContactName,fcByName);
    if Where = Form1.WhereisContact(lbNumber.Caption,fcByNumber) then
    case Where of
      frIrmcSync:
        if Form1.frmSyncPhonebook.FindContact(ContactName,FNotesContact) then begin
          FPersonalized := True;
          if IsIncoming then
            Form1.ShowBaloonInfo(Format(_('%s is calling...'),[GetContactFullName(FNotesContact)]),60);
          // image
          IsCustomImage := False;
          try
            s := GetContactPictureFile(FNotesContact);
            if s <> '' then begin
              { Use uGlobal function }
              LoadBitmap32FromFile(s,Image32.Bitmap);
              IsCustomImage := True;
            end;
          except
          end;
          // sound
          { WaitASec(500); // delay to sync our with phone sounds :) }
          try
            s := GetContactSoundFile(FNotesContact);
            if IsIncoming and (s <> '') then begin
              { Stop default ringing sound }
              if IsIncoming then PlaySound(nil, 0, SND_PURGE);
              { Play personalized sound }
              MediaPlayer1.FileName := s;
              MediaPlayer1.Open;
              MediaPlayer1.Play;
              MediaPlayer1.Notify := True;
            end
            else
              MediaPlayer1.FileName := '';
          except
            MediaPlayer1.FileName := '';
          end;
          FStopped := False;
        end;
    end;
    { Notes }
    DoShowNotes;
  end;
  { Play default ringing sound if no personalization set up for that contact,
    or if personalization is set up, but only for the contact picture, i.e. no sound }
  if (not FPersonalized or (MediaPlayer1.FileName = '')) then
    if IsIncoming then
      FStopped := not PlaySound(pChar('FMA_CallReceived'), 0, SND_ASYNC or SND_APPLICATION or SND_NODEFAULT) // do not localize
    else
      FStopped := not PlaySound(pChar('FMA_Calling'), 0, SND_ASYNC or SND_APPLICATION or SND_NODEFAULT); // do not localize
end;

procedure TfrmCalling.MediaPlayer1Notify(Sender: TObject);
begin
  { loop sound }
  if FPersonalized and not FStopped and (MediaPlayer1.Mode = mpStopped) then
    try
      MediaPlayer1.Play;
      MediaPlayer1.Notify := True;
    except
    end;
end;

procedure TfrmCalling.DoStopPersonalize(Exiting: boolean);
begin
  { if Exiting is False, we are entering call;
    if Exiting is True, we are closing form (call ended) }
  if Exiting then begin
    { Save contact notes always }
    if Assigned(FNotesContact) then
      SetContactNotes(FNotesContact,Memo.Lines);
  end;
  if not FStopped then begin
    FStopped := True; // allow it only once
    if Exiting then
      IsCustomImage := False
    else begin
      TimeTimer.Enabled := True;
      FStartTime := Now;
    end;
    { Stop personalized ringing sound } 
    if MediaPlayer1.FileName <> '' then
      try
        MediaPlayer1.Notify := False;
        if IsIncoming then
          try
            MediaPlayer1.Stop;
            MediaPlayer1.Close;
          except
          end;
        MediaPlayer1.FileName := '';
      except
      end
    else begin
      { Stop default ringing sound }
      PlaySound(nil, 0, SND_PURGE);
    end;
  end;
end;

procedure TfrmCalling.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if Form1.FConnected and IsCalling and not IsTalking and not IsIncoming then
    CanClose := MessageDlgW(_('Closing this box will Hang Up current outgoing call. Continue?'),
      mtConfirmation, MB_OKCANCEL) = ID_OK;
end;

procedure TfrmCalling.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseCall(false);
end;

procedure TfrmCalling.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);

  lbAlpha.Font.Style := lbAlpha.Font.Style + [fsBold];
  Image1.Picture.Assign(Form1.CommonBitmaps.Bitmap[1]);
end;

procedure TfrmCalling.TimeTimerTimer(Sender: TObject);
begin
  { This timer will be triggered once a call is active
    or when an outgoing call is initiated... }
  if IsTalking then
    lblTime.Caption := FormatDateTime('nn:ss',Now - FStartTime) // do not localize ?
  else
    if not IsIncoming then begin
      { perform default outgoing ringing sound on every RingSecs seconds }
      inc(FRingSecs);
      if FRingSecs = FRingOn then begin
        DoPersonalize;
        FRingSecs := 0;
      end;
    end;
end;

procedure TfrmCalling.Set_IsIncoming(const Value: Boolean);
begin
  FIsIncoming := Value;
  if Visible then
    if Value then Form1.ShowBaloonInfo(_('Incoming call...'),60);
end;

function TfrmCalling.HasPersonalizedSound: boolean;
begin
  Result := FPersonalized and (MediaPlayer1.FileName <> '');
end;

function TfrmCalling.Get_Busy: Boolean;
begin
  Result := FRingOn = 1;
end;

procedure TfrmCalling.Set_Busy(const Value: Boolean);
begin
  if Value then FRingOn := 1 else FRingOn := DefRingOutgoingSecs;
  FRingSecs := 0;
end;

procedure TfrmCalling.CreateCall(Number: WideString; Popup: boolean; AlphaBlend: Integer);
var
  CallName: WideString;
begin
  { Setup variables }
  FRingSecs := 0;
  FRingOn := DefRingOutgoingSecs;
  FStopped := False;
  FPersonalized := False;
  FPersonalizedSem := False;
  FCheck := False;
  lblTime.Caption := '00:00'; // do not localize ?
  FNotesContact := nil;
  FillChar(FContactData,0,SizeOf(FContactData));
  Memo.Clear;
  Memo.Visible := False;
  HeadsetButton.Enabled := True;
  HeadsetButton.Visible := False;
  AnswerButton.Enabled := True;
  AnswerButton.Visible := False;
  HandupButton.Enabled := True;
  { Prepare transparancy }
  AlphaBlendValue := AlphaBlend;
  { Resize form to fix message }
  if Number = '' then CallName := sUnknownNumber
    else CallName := form1.LookupContact(Number,sUnknownContact);
  lbAlpha.Font.Style := lbAlpha.Font.Style + [fsBold];  
  lbAlpha.Alignment := taLeftJustify;
  lbAlpha.AutoSize := True;
  lbAlpha.Caption := CallName;
  lbNumber.Caption := Number;
  IsCustomImage := False;  
  { Restore form position }
  FormPlacement1.RestoreFormPlacement;
  Application.ProcessMessages;
  { Resize form }
  DoResizeWide;
  Height := Constraints.MinHeight;
  { Show window but not activate it
  ShowWindow(Handle,SW_SHOWNOACTIVATE);
  ShowWindow(HeadsetButton.Handle,SW_SHOWNOACTIVATE);
  ShowWindow(AnswerButton.Handle,SW_SHOWNOACTIVATE);
  ShowWindow(HandupButton.Handle,SW_SHOWNOACTIVATE);
  ShowWindow(Memo.Handle,SW_SHOWNOACTIVATE);
  ShowWindow(ImagePanel.Handle,SW_SHOWNOACTIVATE);
  ShowWindow(Image32.Handle,SW_SHOWNOACTIVATE);
  {}
  if Popup then
    Show;
  FCreated := True;
end;

procedure TfrmCalling.DoResizeWide;
var
  wide: integer;
begin
  wide := lbAlpha.Width;
  if lbNumber.Width > wide then wide := lbNumber.Width;
  wide := wide + lbAlpha.Left - 4;
  if wide > (Constraints.MinWidth-16) then
    ClientWidth := wide + 8
  else
    Width := Constraints.MinWidth;
end;

procedure TfrmCalling.Set_CustomImage(const Value: Boolean);
begin
  FCustomImage := Value;
  if not Value then
    Image32.Bitmap.Assign(Form1.CommonBitmaps.Bitmap[0]);
end;

procedure TfrmCalling.DoExiting;
begin
  DoStopPersonalize;
end;

procedure TfrmCalling.DoInCall;
begin
  DoStopPersonalize(False);
end;

procedure TfrmCalling.DoShowNotes;
var
  SIMData: PSIMData;
  ContactName: WideString;
  Where: TFindContactResult;
begin
  if not Memo.Visible then begin
    ContactName := Form1.ExtractContact(lbAlpha.Caption);
    Where := Form1.WhereisContact(ContactName,fcByName);
    if Where = Form1.WhereisContact(lbNumber.Caption,fcByNumber) then
    case Where of
      frPhonebook:
        if Form1.frmMEEdit.FindContact(ContactName,SIMData) then begin
          { Fill data needed for Notes access }
          FContactData.LUID := SIMData^.LUID;
          FContactData.CDID := SIMData^.CDID;
          FNotesContact := @FContactData;
        end;
      frSIMCard:
        if Form1.frmSMEdit.FindContact(ContactName,SIMData) then begin
          { Fill data needed for Notes access }
          FContactData.LUID := SIMData^.LUID;
          FContactData.CDID := SIMData^.CDID;
          FNotesContact := @FContactData;
        end;
      frIrmcSync:
        Form1.frmSyncPhonebook.FindContact(ContactName,FNotesContact);
    end;
    // notes
    if Assigned(FNotesContact) then
      Memo.Visible := GetContactNotes(FNotesContact,Memo.Lines);
  end;
end;

procedure TfrmCalling.CloseCall(CanClose,CanHangUp: boolean);
begin
  if FCreated then begin
    FCreated := False;
    { Cancel any call attempt. If we're in call do not hang up here! }
    if CanHangUp and Form1.FConnected and IsCalling and not IsTalking then
      Form1.VoiceHangUp(IsIncoming);
    { Stop any sound }
    DoExiting;
    TimeTimer.Enabled := False;
    Image32.Bitmap.Clear;
  end;
  if CanClose then Close; // could cause stack overflow
end;

end.
