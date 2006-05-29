unit uNewMessage;

{
*******************************************************************************
* Descriptions: Incoming Message Pop-up Implementation
* $Source: /cvsroot/fma/fma/uNewMessage.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uNewMessage.pas,v $
* Revision 1.17.2.12  2006/03/11 15:17:12  z_stoichev
* Fixed Add SMS Sender to Phonebook (when no IRMC).
*
* Revision 1.17.2.11  2006/03/09 09:13:01  z_stoichev
* Gsm_SMS code merged into uSMS.pas!
*
* Revision 1.17.2.10  2006/01/16 11:26:57  mhr3
* Form1.Explorer -> Form1.ExplorerNew
*
* Revision 1.17.2.9  2005/10/01 12:59:53  z_stoichev
* - Fixed Delete Popup SMS from custom folder.
* - Fixed Mark Popup SMS as read in custom folder.
*
* Revision 1.17.2.8  2005/09/06 18:32:56  z_stoichev
* Bugfixes and improvements (2.1.1.102b)
*
* Revision 1.17.2.7  2005/08/31 15:15:27  z_stoichev
* - Removed obsolete Long SMS restrictions.
*
* Revision 1.17.2.6  2005/08/31 11:34:46  z_stoichev
* Fixed replay on long message btnLong.Down change.
*
* Revision 1.17.2.5  2005/08/31 11:06:31  z_stoichev
* Added support for Long SMS.
*
* Revision 1.17.2.4  2005/08/22 07:29:44  z_stoichev
* GUI fixes
*
* Revision 1.17.2.3  2005/08/20 18:09:06  z_stoichev
* - Fixed Personalize Call/New message dialog semafor usage.
* - Fixed Find contact in Phonebook (Irmc), Phone Book, SIM.
*
* Revision 1.17.2.2  2005/08/19 12:14:08  z_stoichev
* GUI fixes.
*
* Revision 1.17.2.1  2005/08/18 17:13:47  z_stoichev
* - Added support for JPEG2000 images.
* - Fixed GIF images displaying issue.
*
* Revision 1.17  2005/02/08 15:38:52  voxik
* Merged with L10N branch
*
* Revision 1.16.12.2  2004/10/25 20:21:46  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.16.12.1  2004/10/19 19:48:38  expertone
* Add localization (gnugettext)
*
* Revision 1.16  2004/07/07 11:21:40  z_stoichev
* Fixed minimum message height.
* Personalization always used.
*
* Revision 1.15  2004/07/06 14:43:17  z_stoichev
* - Added Personalization default contact image.
* - Added Open Chat menu command
*
* Revision 1.14  2004/06/29 12:37:07  z_stoichev
* New message window renamed
*
* Revision 1.13  2004/06/29 10:46:34  z_stoichev
* Updated personalization
*
* Revision 1.12  2004/06/28 22:43:04  z_stoichev
* Personalization support added.
*
* Revision 1.11  2004/06/23 13:49:27  z_stoichev
* Fixed Delete from Archive
*
* Revision 1.10  2004/06/21 09:45:28  z_stoichev
* Fixed Rply focus issue.
* Popup menu changed.
*
* Revision 1.9  2004/04/01 15:06:21  z_stoichev
* Mark as read on reply/forward
* popup menu moved
*
* Revision 1.8  2004/01/12 15:36:05  z_stoichev
* Fixed too small width issue.
*
* Revision 1.7  2003/11/28 09:38:07  z_stoichev
* Merged with branch-release-1-1 (Fma 0.10.28c)
*
* Revision 1.6.2.4  2003/11/21 14:00:23  z_stoichev
* Message fade out stopped on mouse over text or when
* window is activated.
* Actions as delete, reply, etc. moved into Popup menu.
* Added Add contact action for unknown senders.
* Window shows inactivated in order do not steal focus.
*
* Revision 1.6.2.3  2003/11/11 18:09:22  z_stoichev
* Add background.
* Auto form resize.
* Add some Buttons.
*
* Revision 1.6.2.2  2003/11/10 14:03:09  z_stoichev
* RC3
*
* Revision 1.6.2.1  2003/10/27 07:22:54  z_stoichev
* Build 0.1.0 RC1 Initial Checkin.
*
* Revision 1.6  2003/10/14 09:23:47  z_stoichev
* Unit SentSMS renamed to uComposeSMS.
*
* Revision 1.5  2003/10/14 09:14:44  z_stoichev
* Method Create renamed to CreateMsg in order
* to avoid hiding of virtual inherited method.
*
* Revision 1.4  2003/01/30 04:15:57  warren00
* Updated with header comments
*
*
*******************************************************************************
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls,
  Forms, TntForms, Dialogs, TntDialogs, StdCtrls, TntStdCtrls, Placemnt, ExtCtrls, TntExtCtrls, jpeg, Menus, TntMenus, TntComCtrls,
  GR32_Image, VirtualTrees;

type
  TMsgDetails = record
    msgType: Integer;
    msgIndex: Integer;
    msgLocation: String;
    msgPDU: String;
  end;

  TfrmNewMessage = class(TTntForm)
    FormPlacement1: TFormPlacement;
    Timer1: TTimer;
    lbText: TTntLabel;
    lbAlpha: TTntLabel;
    Image1: TTntImage;
    OkButton: TTntButton;
    ActionButton: TTntButton;
    PopupMenu1: TTntPopupMenu;
    ReplyBack: TTntMenuItem;
    Forward1: TTntMenuItem;
    N1: TTntMenuItem;
    Delete1: TTntMenuItem;
    N2: TTntMenuItem;
    AddContact1: TTntMenuItem;
    ImagePanel: TTntPanel;
    Image32: TImage32;
    Chat1: TTntMenuItem;
    AnswerButton: TTntButton;
    N3: TTntMenuItem;
    CallContact1: TTntMenuItem;
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ReplyBackClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure ActionButtonClick(Sender: TObject);
    procedure Forward1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure AddContact1Click(Sender: TObject);
    procedure Chat1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CallContact1Click(Sender: TObject);
  private
    { Private declarations }
    FAlphaCount: integer;
    FPrevAlpha: boolean;
    FPersonalized,FPersonalizedSem: Boolean;
    FCustomImage: Boolean;
    FLongSMS: Boolean;
    FMembers: TStringList;
    FFolder: PVirtualNode;
    procedure DoPersonalize;
    procedure DoMarkMsgAsRead;
    procedure GetMemberDetails(Index: Integer; var Details: TMsgDetails);
    procedure Set_CustomImage(const Value: Boolean);
    procedure Set_LongSMS(const Value: Boolean);
  public
    { Public declarations }
    constructor CreateMsg(Sender, text: WideString; AlphaBlend: Integer);
    destructor Destroy; override;
    property IsPersonalized: Boolean read FPersonalized;
    property IsCustomImage: Boolean read FCustomImage write Set_CustomImage;
    property IsLongSMS: Boolean read FLongSMS write Set_LongSMS;
    property Members: TStringList read FMembers write FMembers;
    property FolderNode: PVirtualNode read FFolder write FFolder;
  end;

var
  frmNewMessage: TfrmNewMessage;

implementation

uses
  gnugettext, gnugettexthelpers,
  uGlobal, Unit1, uComposeSMS, uSyncPhonebook, uMissedCalls, uChatSMS, uSMS,
  uCallContact;

{$R *.dfm}

const
  DontFadeSeconds = 5;

constructor TfrmNewMessage.CreateMsg(Sender, text: WideString; AlphaBlend: Integer);
var
  wide,high: integer;
begin
  inherited Create(nil);
  FMembers := TStringList.Create;
  FLongSMS := False;
  FFolder := Form1.FNodeMsgArchive;
  { Prepare fade out }
  AlphaBlendValue := AlphaBlend;
  FAlphaCount := AlphaBlend + DontFadeSeconds*10; // dont fade immediately
  lbAlpha.Font.Style := lbAlpha.Font.Style + [fsBold];
  lbAlpha.Alignment := taLeftJustify;
  lbAlpha.AutoSize := True;
  lbAlpha.Caption := Sender;
  lbText.Anchors := [akLeft,akTop];
  lbText.Caption := '';
  { Restore form position }
  FormPlacement1.RestoreFormPlacement;
  Application.ProcessMessages;
  Constraints.MinHeight := 32;
  ClientHeight := 137;
  { Resize form to fit message }
  lbText.WordWrap := False;
  lbText.AutoSize := True;
  lbText.Caption := text;
  lbText.WordWrap := True;
  wide := lbText.Width;
  if lbAlpha.Width > wide then wide := lbAlpha.Width;
  wide := wide + lbAlpha.Left - 4;
  if wide > (Constraints.MaxWidth-16) then begin
    Width := Constraints.MaxWidth;
    lbText.AutoSize := False;
    lbText.Width := Constraints.MaxWidth - lbText.Left - 16;
    lbText.AutoSize := True;
  end
  else begin
    if wide > (Constraints.MinWidth-16) then
      ClientWidth := wide + 8
    else
      Width := Constraints.MinWidth;
  end;
  high := lbText.Height - 85;
  if high > 0 then
    ClientHeight := ClientHeight + high;
  Constraints.MinHeight := Height;  
  { Fix Buttons, TntButtons top }
  OkButton.Top := ClientHeight-25;
  ActionButton.Top := OkButton.Top;
  AnswerButton.Top := OkButton.Top;
  { Stick text }
  lbText.AutoSize := False;
  lbText.Height := OkButton.Top - lbText.Top - 4;
  lbText.Anchors := [akLeft,akTop,akRight,akBottom];
  { Personalize }
  FPersonalized := False;
  FPersonalizedSem := False;
  DoPersonalize;
  { Show window but not activate it }
  SetWindowPos(Handle, HWND_TOPMOST,
    Top, Left, Width, Height,
    SWP_NOACTIVATE);
  ShowWindow(Handle,SW_SHOWNOACTIVATE);
  ShowWindow(OkButton.Handle,SW_SHOWNOACTIVATE);
  ShowWindow(ActionButton.Handle,SW_SHOWNOACTIVATE);
  ShowWindow(AnswerButton.Handle,SW_SHOWNOACTIVATE);
  ShowWindow(ImagePanel.Handle,SW_SHOWNOACTIVATE);
  ShowWindow(Image32.Handle,SW_SHOWNOACTIVATE);
end;

procedure TfrmNewMessage.Timer1Timer(Sender: TObject);
begin
  FAlphaCount := FAlphaCount - 1;
  if FAlphaCount < AlphaBlendValue then begin
    AlphaBlendValue := AlphaBlendValue - 4;
    if AlphaBlendValue < 15 then
      OkButton.Click;
  end;
end;

procedure TfrmNewMessage.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmNewMessage.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);

  lbAlpha.Font.Style := lbAlpha.Font.Style + [fsBold];
  Image1.Picture.Assign(Form1.CommonBitmaps.Bitmap[1]);
end;

procedure TfrmNewMessage.OkButtonClick(Sender: TObject);
begin
  Timer1.Enabled := False;
  Close;
end;

procedure TfrmNewMessage.ActionButtonClick(Sender: TObject);
var
  p: TPoint;
begin
  with (Sender as TTntButton) do
    p := ClientToScreen(Point(0,Height));
  PopupMenu1.Popup(p.X,p.Y);  
end;

procedure TfrmNewMessage.PopupMenu1Popup(Sender: TObject);
begin
  Chat1.Enabled := lbAlpha.Caption <> sUnknownNumber;
  CallContact1.Enabled := Chat1.Enabled;
  AddContact1.Enabled := (Chat1.Enabled and (Pos('[',lbAlpha.Caption) = 0)) or
    (Pos(sUnknownContact,lbAlpha.Caption) <> 0); // no name included or unknown contact name
end;

procedure TfrmNewMessage.ReplyBackClick(Sender: TObject);
begin
  DoMarkMsgAsRead;
  frmMessageContact.Clear;
  Form1.ActionSMSNewMsg.Execute;
  frmMessageContact.AddRecipient(lbAlpha.Caption);
  frmMessageContact.Memo.SetFocus;
end;

procedure TfrmNewMessage.Forward1Click(Sender: TObject);
begin
  DoMarkMsgAsRead;
  frmMessageContact.Clear;
  Form1.ActionSMSNewMsg.Execute;
  if FLongSMS then
    if not frmMessageContact.btnLongSMS.Down then begin
      frmMessageContact.btnLongSMS.Down := True;
      frmMessageContact.btnLongSMS.Click;
    end;  
  frmMessageContact.Memo.Text := lbText.Caption;
  frmMessageContact.Memo.SelStart := Length(lbText.Caption);
end;

procedure TfrmNewMessage.Delete1Click(Sender: TObject);
var
  i: Integer;
  d: TMsgDetails;
begin
  DoMarkMsgAsRead;
  for i := 0 to FMembers.Count-1 do begin
    GetMemberDetails(i,d);
    { Delete it }
    if d.msgType = 3 then begin // In PC?
      { message is in PC, already deleted from phone, so remove it from Archive }
      Form1.DelMsgFromFolder(FFolder,d.msgPDU);
    end
    else
    if Form1.DeleteSMS(d.msgIndex,d.msgLocation) then begin
      { message has beed deleted from phone successfuly, so remove it from Inbox }
      Form1.DelMsgFromFolder(Form1.FNodeMsgInbox,d.msgPDU);
    end;
  end;
  OkButton.Click;
end;

procedure TfrmNewMessage.AddContact1Click(Sender: TObject);
begin
  { Add new contact to ME - lbAlpha.Caption comtains the number }
  if Form1.IsIrmcSyncEnabled then
    Form1.frmSyncPhonebook.DoEdit(True,lbAlpha.Caption)
  else
    Form1.frmMEEdit.DoEdit(True,lbAlpha.Caption);
end;

procedure TfrmNewMessage.OnMouseEnter(Sender: TObject);
begin
  FPrevAlpha := AlphaBlend;
  AlphaBlend := False;
  Timer1.Enabled := False;
end;

procedure TfrmNewMessage.OnMouseLeave(Sender: TObject);
begin
  if FPrevAlpha then
    FormDeactivate(nil);
end;

procedure TfrmNewMessage.FormDeactivate(Sender: TObject);
begin
  { Was fade out started when we enter ? }
  if FAlphaCount = AlphaBlendValue then begin
    { Yes, fade out faster now }
    Timer1.Interval := 5;
    FAlphaCount := 250;
    AlphaBlendValue := 250;
  end; { No, just continue }
  AlphaBlend := True;
  Timer1.Enabled := True;
end;

procedure TfrmNewMessage.DoMarkMsgAsRead;
var
  i: Integer;
  d: TMsgDetails;
begin
  for i := 0 to FMembers.Count-1 do begin
    GetMemberDetails(i,d);
    { Mark as read }
    if d.msgType = 3 then // In PC?
      Form1.UpdateNewMessagesCounter(FFolder,d.msgPDU)
    else
      Form1.UpdateNewMessagesCounter(Form1.FNodeMsgInbox,d.msgPDU);
  end;
end;

procedure TfrmNewMessage.DoPersonalize;
var
  contact: PContactData;
  w: WideString;
  s: string;
begin
  { Try to lookup caller and load personalized info about the contact }
  if not FPersonalizedSem then begin
    FPersonalizedSem := True;
    w := Form1.ExtractContact(lbAlpha.Caption);
    if Form1.IsIrmcSyncEnabled and Form1.frmSyncPhonebook.FindContact(w,contact) then begin
      FPersonalized := True;
      try
        s := GetContactPictureFile(contact);
        if s <> '' then begin
          { Use uGlobal function }
          LoadBitmap32FromFile(s,Image32.Bitmap);
          IsCustomImage := True;
          ImagePanel.Visible := True;
        end
        else
          IsCustomImage := False;
      except
        IsCustomImage := False;
      end;
    end
    else
      IsCustomImage := False;
  end;
end;

procedure TfrmNewMessage.Set_CustomImage(const Value: Boolean);
begin
  FCustomImage := Value;
  if not Value then
    Image32.Bitmap.Assign(Form1.CommonBitmaps.Bitmap[0]);
end;

procedure TfrmNewMessage.Chat1Click(Sender: TObject);
var
  Chat: TfrmCharMessage;
  sms: TSMS;
  dt: TDateTime;
  d: TMsgDetails;
begin
  { If we are in Popup dialog, contact chat window is not visible for sure! }
  Chat := Form1.GetChatWindow(Form1.ExtractNumber(lbAlpha.Caption),True);
  Chat.Show;
  Chat.BringToFront;
  Chat.Memo.SetFocus;
  { Start new chat session, add current message as first one }
  GetMemberDetails(0,d); // get message timestamp from first message part
  sms := TSMS.Create;
  try
    sms.PDU := d.msgPDU;
    dt := sms.TimeStamp;
    if dt = 0 then dt := Now; // just in case
    Chat.AddChatText(lbAlpha.Caption,lbText.Caption,dt);
    DoMarkMsgAsRead;
  finally
    sms.Free;
  end;
  OkButton.Click;
end;

procedure TfrmNewMessage.FormShow(Sender: TObject);
begin
  SetWindowPos(Handle, HWND_TOPMOST,
    Top, Left, Width, Height,
    SWP_NOACTIVATE);
end;

procedure TfrmNewMessage.CallContact1Click(Sender: TObject);
begin
  DoMarkMsgAsRead;
  Form1.DoCallContact(lbAlpha.Caption);
end;

procedure TfrmNewMessage.Set_LongSMS(const Value: Boolean);
begin
  FLongSMS := Value;
  if Value then Caption := _('Long SMS Received')
    else Caption := _('SMS Received');
end;

destructor TfrmNewMessage.Destroy;
begin
  FMembers.Free;
  inherited;
end;

procedure TfrmNewMessage.GetMemberDetails(Index: Integer; var Details: TMsgDetails);
var
  str: string;
begin
  if (Index >= 0) and (Index < FMembers.Count) then begin
    str := FMembers[Index];
    Details.msgType := StrToInt(GetToken(str,0));
    Details.msgIndex := StrToInt(GetToken(str,1));
    case Details.msgType of
      1: Details.msgLocation := 'ME'; // do not localize
      2: Details.msgLocation := 'SM'; // do not localize
      else Details.msgLocation := ''; // message is in PC (archive folder)
    end;
    Details.msgPDU := GetToken(str,5);
  end
  else Abort;
end;

end.
