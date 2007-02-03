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
*
*******************************************************************************
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
        AddChatText(WideFormat(_('[%s joined chat session]'),[Sender]));
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
var
  a,b: String;
begin
  a := Form1.GetPartialNumber(Number);
  b := Form1.GetPartialNumber(Form1.ExtractNumber(lblName.Caption));
  Result := CompareText(a,b) = 0;
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
  AddChatText(WideFormat(_('[%s joined chat session]'),[Form1.FChatNick]));
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
