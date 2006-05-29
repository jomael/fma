unit uChatSMS;

{
*******************************************************************************
* Descriptions: Text Messages Chat Window
* $Source: /cvsroot/fma/fma/uChatSMS.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uChatSMS.pas,v $
* Revision 1.6.2.2  2005/08/31 21:59:32  z_stoichev
* Added chat customization support.
*
* Revision 1.6.2.1  2005/04/07 22:08:53  z_stoichev
* Fixed Long SMS click.
*
* Revision 1.6  2005/03/13 10:46:27  z_stoichev
* Fixed: Chat not scrolled on new message.
*
* Revision 1.5  2005/02/09 14:01:38  z_stoichev
* Fixed #13#10 to sLinebreak.
*
* Revision 1.4  2005/02/08 15:38:34  voxik
* Merged with L10N branch
*
* Revision 1.3.12.2  2004/10/25 20:21:38  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.3.12.1  2004/10/19 19:48:30  expertone
* Add localization (gnugettext)
*
* Revision 1.3  2004/07/14 09:35:05  z_stoichev
* - Fixed Chat Message enter text area height.
*
* Revision 1.2  2004/06/29 12:37:03  z_stoichev
* New message window renamed
*
* Revision 1.1  2004/06/23 13:47:25  z_stoichev
* Initial Chat support
*
*
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, uComposeSMS, Menus, TntMenus, Placemnt, StdCtrls, TntStdCtrls, ExtCtrls, TntExtCtrls,
  ComCtrls, TntComCtrls, UniTntCtrls, ToolWin, Buttons, TntButtons;

resourcestring
  DefaultChatNick = 'Me';

type
  TfrmCharMessage = class(TfrmMessageContact)
    SendButton: TTntButton;
    TalkToPanel: TTntPanel;
    Label1: TTntLabel;
    lblName: TTntLabel;
    sbLong: TTntSpeedButton;
    Chat: TTntRichEdit;
    Timer1: TTimer;
    PopupMenu1: TTntPopupMenu;
    Copy1: TTntMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure LongClick(Sender: TObject);
    procedure MemoChange(Sender: TObject);
    procedure SendClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    FResponseReceived: Boolean;
    FOldMsg: WideString;
    procedure SetChatContact(Who: WideString);
  public
    { Public declarations }
    procedure EnableSending(WithError: boolean);
    procedure AddChatText(SystemMessage: WideString); overload;
    procedure AddChatText(Sender,Text: WideString; When: TDateTime; SystemMsg: boolean = False); overload;
    function IsYourNumber(Number: string): boolean;
  end;

var
  frmCharMessage: TfrmCharMessage;

implementation

uses
  gnugettext, gnugettexthelpers,
  Unit1;

{$R *.dfm}

procedure TfrmCharMessage.FormCreate(Sender: TObject);
begin
  inherited;
  lblName.Left := Label1.Left + Label1.Width + 4;
  lblName.Font.Style := lblName.Font.Style + [fsBold];
  FOldMsg := '';
  FChatMode := True;
end;

procedure TfrmCharMessage.Edit1Change(Sender: TObject);
begin
  inherited;
  SetChatContact(Edit1.Text);
end;

procedure TfrmCharMessage.LongClick(Sender: TObject);
begin
  btnLongSMS.Down := not btnLongSMS.Down;
  inherited;
  sbLong.Down := btnLongSMS.Down;
end;

procedure TfrmCharMessage.MemoChange(Sender: TObject);
begin
  inherited;
  SendButton.Enabled := Memo.Lines.Count <> 0;
end;

procedure TfrmCharMessage.SendClick(Sender: TObject);
begin
  Timer1.Enabled := False;
  SendButton.Enabled := False;
  inherited;
  Memo.Color := clBtnFace;
  Memo.ReadOnly := True;
end;

procedure TfrmCharMessage.AddChatText(Sender, Text: WideString;
  When: TDateTime; SystemMsg: boolean);
var
  col: TColor;
begin
  if SystemMsg then begin
    { System message, do not allow dublicates }
    if WideCompareText(FOldMsg,Text) = 0 then
      exit;
    FOldMsg := Text;
    col := clGray;
  end
  else begin
    FOldMsg := '';
    if Sender = '' then begin
      { Outgoing SMS }
      EnableSending(False);
      Sender := Form1.FChatNick;
      col := clRed;
    end
    else begin
      { Incoming SMS }
      if not FResponseReceived then begin
        FResponseReceived := True;
        AddChatText(_(WideFormat('[%s joined chat session]',[Sender])));
      end;
      col := clNavy;
    end;
  end;
  Chat.SelStart := Length(Chat.Text);
  Chat.SelAttributes.Color := col;
  if not SystemMsg then begin
    Chat.SelAttributes.Style := Chat.SelAttributes.Style + [fsBold];
    Chat.SelText := FormatDateTime('hh:nn',When)+' '+Form1.ExtractContact(Sender)+': '; // do not localize?
    Chat.SelStart := Length(Chat.Text);
    Chat.SelAttributes.Style := Chat.SelAttributes.Style - [fsBold];
  end;
  Chat.SelText := Text + sLinebreak;
  Chat.SelStart := Length(Chat.Text);
end;

procedure TfrmCharMessage.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

function TfrmCharMessage.IsYourNumber(Number: string): boolean;
begin
  Result := WideCompareText(Form1.ExtractContact(lblName.Caption),Form1.LookupContact(Number)) = 0;
end;

procedure TfrmCharMessage.SetChatContact(Who: WideString);
begin
  Edit1.Text := Who;
  lblName.Caption := Who;
  //Caption := _('Chatting with ')+Who;
end;

procedure TfrmCharMessage.FormShow(Sender: TObject);
begin
  inherited;
  Memo.Top := StatusBar.Top - Memo.Height - 1;
  SendButton.Top := Memo.Top;
  Chat.Height := Memo.Top - Chat.Top - 2;
  AddChatText(_('Do not send any confidential information as passwords via your phone using text messages!'));
  AddChatText(_(WideFormat('[%s joined chat session]',[Form1.FChatNick])));
end;

procedure TfrmCharMessage.EnableSending(WithError: boolean);
begin
  Memo.Color := clWindow;
  Memo.ReadOnly := False;
  Memo.SetFocus;
  Memo.Text := '';
  MemoChange(nil);
  if WithError then begin
    AddChatText(_('(Sending delayed, will try to send it later)'));
    StatusBar.Panels[2].Text := '';
  end
  else
    StatusBar.Panels[2].Text := Format(_('Total messages sent: %d'),[Form1.FSMSCounter]);
  Timer1.Enabled := True;
end;

procedure TfrmCharMessage.FormActivate(Sender: TObject);
begin
  inherited;
  Chat.SelStart := Length(Chat.Text);
  if WarningPanel.Visible then
    Chat.Top := WarningPanel.Top + WarningPanel.Height
  else
    Chat.Top := TalkToPanel.Top + TalkToPanel.Height;
  Timer1.Enabled := True;
end;

procedure TfrmCharMessage.AddChatText(SystemMessage: WideString);
begin
  AddChatText('',SystemMessage,0,True);
end;

procedure TfrmCharMessage.Timer1Timer(Sender: TObject);
begin
  inherited;
  Timer1.Enabled := False;
  StatusBar.Panels[2].Text := '';
end;

end.
