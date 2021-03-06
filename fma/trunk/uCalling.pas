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
*
*******************************************************************************
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, StdCtrls, TntStdCtrls, Placemnt, GR32_Image, ExtCtrls, TntExtCtrls, MPlayer,
  jpeg, MMSystem, uSyncPhonebook, Menus, TntMenus;

type
  TfrmCalling = class(TTntForm)
    HandupButton: TTntButton;
    AnswerButton: TTntButton;
    FormPlacement1: TFormPlacement;
    lbAlpha: TTntLabel;
    lbNumber: TTntLabel;
    MoreButton: TTntButton;
    ImagePanel: TTntPanel;
    Image32: TImage32;
    MediaPlayer1: TMediaPlayer;
    Image1: TTntImage;
    lblTime: TTntLabel;
    TimeTimer: TTimer;
    Memo: TTntMemo;
    PopupMenu1: TTntPopupMenu;
    HeadsetButton: TTntMenuItem;
    N1: TTntMenuItem;
    AddToPhonebook1: TTntMenuItem;
    N2: TTntMenuItem;
    MessageContact1: TTntMenuItem;
    HangUp1: TTntMenuItem;
    Answer1: TTntMenuItem;
    N3: TTntMenuItem;
    Ignore1: TTntMenuItem;
    procedure FormShow(Sender: TObject);
    procedure MediaPlayer1Notify(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure TimeTimerTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure HeadsetButtonClick(Sender: TObject);
    procedure AddToPhonebook1Click(Sender: TObject);
    procedure MoreButtonClick(Sender: TObject);
    procedure Ignore1Click(Sender: TObject);
    procedure AnswerButtonClick(Sender: TObject);
    procedure HandupButtonClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure MessageContact1Click(Sender: TObject);
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
  uImg32Helper, Unit1, uMissedCalls, uDialogs, uSIMEdit, uComposeSMS;

const
  DefRingOutgoingSecs = 5;

{$R *.dfm}

procedure TfrmCalling.FormShow(Sender: TObject);
begin
  SetWindowPos(Handle, HWND_TOPMOST,
    Left, Top, Width, Height,
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
      lbAlpha.Caption := Form1.ExtractContact(Form1.ContactNumberByTel(lbNumber.Caption));
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
  CloseCall(False);
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
  AnswerButton.Enabled := True;
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
  FCreated := True;
  if not Popup then exit;
  { Show window but not activate it --- if using this CLOSE is not working!!!
  SetWindowPos(Handle, HWND_TOPMOST,
    Left, Top, Width, Height,
    SWP_NOACTIVATE or SWP_NOSIZE);
  ShowWindow(Handle,SW_SHOWNOACTIVATE);
  ShowWindow(HeadsetButton.Handle,SW_SHOWNOACTIVATE);
  ShowWindow(AnswerButton.Handle,SW_SHOWNOACTIVATE);
  ShowWindow(HandupButton.Handle,SW_SHOWNOACTIVATE);
  ShowWindow(Memo.Handle,SW_SHOWNOACTIVATE);
  ShowWindow(ImagePanel.Handle,SW_SHOWNOACTIVATE);
  ShowWindow(Image32.Handle,SW_SHOWNOACTIVATE);
  }
  Show;
  Update;
end;

procedure TfrmCalling.FormCreate(Sender: TObject);
begin
  Left := (Screen.Width - Width) div 2;
  Top := (Screen.Height - Height) div 2;
  gghTranslateComponent(self);

  lbAlpha.Font.Style := lbAlpha.Font.Style + [fsBold];
  Image1.Picture.Assign(Form1.CommonBitmaps.Bitmap[1]);
end;

procedure TfrmCalling.DoResizeWide;
var
  wide,dif: integer;
begin
  wide := lbAlpha.Width;
  if lbNumber.Width > wide then wide := lbNumber.Width;
  wide := wide + lbAlpha.Left - 4;
  if wide > (Constraints.MinWidth-16) then begin
    dif := (wide + 8) - ClientWidth;
    ClientWidth := wide + 8;
  end
  else begin
    dif := Constraints.MinWidth - Width;
    Width := Constraints.MinWidth;
  end;
  Left := Left - dif div 2;
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
    FormPlacement1.SaveFormPlacement;
  end;
  if CanClose then Close; // No stack overflow coz CanClose is false in Close().
end;

procedure TfrmCalling.HeadsetButtonClick(Sender: TObject);
begin
  DoInCall;
  try
    Form1.VoiceAnswer;
  except
  end;
  FCheck := True;
  Form1.DoDisconnectTemporary;
end;

procedure TfrmCalling.AddToPhonebook1Click(Sender: TObject);
begin
  if Form1.AddNewToPhonebook(lbNumber.Caption) then begin
    { Update view }
    lbAlpha.Caption := Form1.ExtractContact(Form1.ContactNumberByTel(lbNumber.Caption));
    Image32.Bitmap.Clear;
    AddToPhonebook1.Enabled := False;
    { Personalize again }
    FPersonalized := False;
    FPersonalizedSem := False;
    DoPersonalize;
  end;
end;

procedure TfrmCalling.MoreButtonClick(Sender: TObject);
var
  p: TPoint;
begin
  with (Sender as TTntButton) do
    p := ClientToScreen(Point(0,Height));
  PopupMenu1.Popup(p.X,p.Y);
end;

procedure TfrmCalling.AnswerButtonClick(Sender: TObject);
begin
  AnswerButton.Enabled := False;
  DoInCall;
  try
    Form1.VoiceAnswer;
  except // Error may occur if call is alerady active...
  end;
  FCheck := True;
  if Visible and Memo.Visible then
    Memo.SetFocus;
end;

procedure TfrmCalling.HandupButtonClick(Sender: TObject);
begin
  HandupButton.Enabled := False;
  DoExiting;
  try
    Form1.VoiceHangUp;
  except
  end;
end;

procedure TfrmCalling.PopupMenu1Popup(Sender: TObject);
begin
  Answer1.Enabled := AnswerButton.Enabled;
  HangUp1.Enabled := HandupButton.Enabled;
  MessageContact1.Enabled := Pos(sUnknownNumber,lbAlpha.Caption) = 0;
  { Add to ME if no name included or it is an unknown contact name }
  AddToPhonebook1.Enabled := MessageContact1.Enabled and (Pos(sUnknownContact,lbAlpha.Caption) <> 0);
end;

procedure TfrmCalling.Ignore1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmCalling.MessageContact1Click(Sender: TObject);
begin
  if lbNumber.Caption <> '' then begin
    frmMessageContact.Clear;
    Form1.ActionSMSNewMsg.Execute;
    frmMessageContact.AddRecipient(Form1.ExtractContact(lbAlpha.Caption)+' ['+lbNumber.Caption+']');
    frmMessageContact.Memo.SetFocus;
  end;
end;

end.
