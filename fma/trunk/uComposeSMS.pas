unit uComposeSMS;

{
*******************************************************************************
* Descriptions: Implementation for SMS Editor Dialog
* $Source: /cvsroot/fma/fma/uComposeSMS.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uComposeSMS.pas,v $
*
*******************************************************************************
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics,
  Controls, TntControls, Forms, TntForms, Dialogs, TntDialogs, StdCtrls, TntStdCtrls, ComCtrls, TntComCtrls,
  UniTntCtrls, ToolWin, ImgList, Placemnt, Buttons, TntButtons, ExtCtrls, TntExtCtrls, Menus, TntMenus, Registry,
  uSMS;

const
  MaxFavorites = 20;

type
  TfrmMessageContact = class(TTntForm)
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    StatusBar: TTntStatusBar;
    FormPlacement1: TFormPlacement;
    Memo: TTntMemo;
    ToolBar2: TToolBar;
    WarningPanel: TTntPanel;
    Panel1: TTntPanel;
    Image1: TTntImage;
    lbWarning: TTntLabel;
    FavoritesPopupMenu: TTntPopupMenu;
    btnSend: TToolButton;
    ToolButton8: TToolButton;
    ToolButton5: TToolButton;
    ToolButton9: TToolButton;
    btnStatusReport: TToolButton;
    btnRequestReply: TToolButton;
    ToolButton1: TToolButton;
    btnSave: TToolButton;
    btnLongSMS: TToolButton;
    btnFlashSMS: TToolButton;
    btnRecent: TToolButton;
    ToolButton6: TToolButton;
    PopupMenu2: TTntPopupMenu;
    ClearMessageCounter1: TTntMenuItem;
    ToPopupMenu: TTntPopupMenu;
    Add1: TTntMenuItem;
    N1: TTntMenuItem;
    Delete1: TTntMenuItem;
    AddToPhonebook1: TTntMenuItem;
    AddToFavorites1: TTntMenuItem;
    Organize1: TTntMenuItem;
    N2: TTntMenuItem;
    btnTo: TToolButton;
    N3: TTntMenuItem;
    Edit1: TTntEdit;
    EncodingPopupMenu1: TTntPopupMenu;
    ForceUCS2Encoding1: TTntMenuItem;
    procedure SendClick(Sender: TObject);
    procedure MemoChange(Sender: TObject);
    procedure Edit1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Edit1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ClearClick(Sender: TObject);
    procedure MemoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure LongClick(Sender: TObject);
    procedure ToolBar2Resize(Sender: TObject);
    procedure ToClick(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PopupMenu1Click(Sender: TObject);
    procedure FavoritesPopupMenuPopup(Sender: TObject);
    procedure btnRecentClick(Sender: TObject);
    procedure ClearMessageCounter1Click(Sender: TObject);
    procedure PopupMenu2Popup(Sender: TObject);
    procedure ToPopupMenuPopup(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure AddToPhonebook1Click(Sender: TObject);
    procedure AddToFavorites1Click(Sender: TObject);
    procedure Organize1Click(Sender: TObject);
    procedure UCS2Click(Sender: TObject);
    procedure EncodingPopupMenu1Popup(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure TntFormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    FMaxLength: Integer;
    FDCS: TGSMCodingScheme;
    procedure DoSend(AsDraft: boolean = False);
  protected
    FChatMode: boolean;
  public
    { Public declarations }
    procedure AddRecipient(node: TTreeNode); overload;
    procedure AddRecipient(str: WideString); overload;
    procedure Clear;
  end;

var
  frmMessageContact: TfrmMessageContact;

implementation

uses
  gnugettext, gnugettexthelpers,
  Unit1, uGlobal, uSelectContact, uDialogs;

{$R *.dfm}

procedure TfrmMessageContact.MemoChange(Sender: TObject);
var
  len, packetCount, packetL: Integer;
begin
  if Form1.FForceUCSusage then
    FDCS := gcs16bitUcs2
  else
    FDCS := GSMCodingScheme(Memo.Text);

  if FDCS = gcs16bitUcs2 then begin
    StatusBar.Panels[1].Text := _('UCS-2');
    FMaxLength := 70;
  end
  else
  if FDCS = gcs8BitOctets then begin
    StatusBar.Panels[1].Text := _('8-bit');
    FMaxLength := 140;
  end
  else
  if FDCS = gcsDefault7Bit then begin
    StatusBar.Panels[1].Text := _('GSM');
    FMaxLength := 160;
  end
  else begin
    StatusBar.Panels[1].Text := _('Error');
    FMaxLength := 0;
  end;

  if not btnLongSMS.Down then begin
     if Length(Memo.Text) > FMaxLength then begin
       { Auto-switch to long-sms mode ON }
       btnLongSMS.Down := True;
     end
  end;
  if btnLongSMS.Down then begin
     packetL := 0;
     case FDCS of
       gcsDefault7Bit:
         packetL := (FMaxLength - 7); { 160 septets - UDH (6 octets+padding) }
       gcs8BitOctets:
         packetL := (FMaxLength - 6); { 140 octets - UDH (6 octets) }
       gcs16bitUcs2:
         packetL := (FMaxLength - 3); { 140 octets (70widechars) - UDH (6 octets) }
     end;
     len := length(Memo.Text);
     packetCount := (len div packetL) + 1;
     if len <= FMaxLength then packetCount := 1;
     if packetCount > 1 then begin
       StatusBar.Panels[0].Text := _('SMS: ') + IntToStr(packetCount);
       StatusBar.Panels[0].Text := StatusBar.Panels[0].Text + _(' - chars ') + IntToStr(length(Memo.Text));
     end
     else begin
       { Auto-switch to long-sms mode OFF }
       btnLongSMS.Down := False;
     end;
  end;
  if not btnLongSMS.Down then begin
     len := length(Memo.Text);
     StatusBar.Panels[0].Text := Format(ngettext('%s char left','%s chars left',FMaxLength - len),
       [IntToStr(FMaxLength - len)]);
  end;

  btnSave.Enabled := memo.Text <> '';
end;

procedure TfrmMessageContact.Edit1DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  node: TTreeNode;
begin
  Accept := False;

  if Source is TTntTreeView then begin
    node := (Source As TTntTreeView).Selected;
    if (node.ImageIndex >= 9) and (node.ImageIndex <= 13) then Accept := True;
  end;
end;

procedure TfrmMessageContact.Edit1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  if Source is TTntTreeView then AddRecipient((Source As TTntTreeView).Selected);
end;

procedure TfrmMessageContact.ClearClick(Sender: TObject);
begin
  Clear;
end;

procedure TfrmMessageContact.AddRecipient(node: TTreeNode);
var
  str: WideString;
begin
  str := node.Parent.Text + ' [' + node.Text + ']';

  if trim(Edit1.Text) <> '' then Edit1.Text := trim(Edit1.Text) + '; ';
  Edit1.Text := Edit1.Text + str;
end;

procedure TfrmMessageContact.AddRecipient(str: WideString);
begin
  Edit1.Text := str;
end;

procedure TfrmMessageContact.Clear;
begin
  if btnSave.Enabled then begin
    MessageBeep(MB_ICONQUESTION);
    case MessageDlgW(_('Do you want to save your current message as a Draft?'),
      mtConfirmation, MB_YESNOCANCEL) of
      ID_YES: begin
        btnSave.Click;
        Form1.Status(_('Previous message saved in Drafts'));
      end;
      ID_CANCEL: Abort;
    end;
  end;
  Memo.Lines.Clear;
  Edit1.Text := '';
  StatusBar.Panels[0].Text := '';
  StatusBar.Panels[1].Text := '';
  btnSave.Enabled := False;
end;


procedure TfrmMessageContact.MemoKeyPress(Sender: TObject; var Key: Char);
begin
  if ord(Key) = 10 then btnSend.Click; // Ctrl-Enter Sent
end;

procedure TfrmMessageContact.FormShow(Sender: TObject);
begin
  try
    btnStatusReport.Enabled := Form1.FStatusReport;
    if btnStatusReport.Enabled then
      btnStatusReport.Hint := _('Request Status Report')
    else
      btnStatusReport.Hint := _('Not supported by phone');

    { Disable Delivery Report feature - it is not fully implemented yet }
    btnStatusReport.Enabled := False;

    btnSave.Enabled := False;
    if Edit1.Text = '' then Edit1.SetFocus else
      Memo.SetFocus;
    CoolBar1.Bands[0].MinHeight := 36;
    CoolBar1.Bands[1].MinHeight := 22;
    Memo.Clear();
  except
  end;
end;

procedure TfrmMessageContact.ToolBar2Resize(Sender: TObject);
begin
  Edit1.Width := ToolBar2.Width - btnTo.Width - btnRecent.Width - 4;
end;

procedure TfrmMessageContact.ToClick(Sender: TObject);
begin
  with TfrmSelContact.Create(nil) do
  try
    SelContacts := Edit1.Text;
    if ShowModal = mrOk then
      Edit1.Text := SelContacts;
  finally
    Free;
  end;
end;

procedure TfrmMessageContact.Edit1Click(Sender: TObject);
var
  a,b: string;
  i,j: integer;
  p,r: pchar;
begin
  a := Copy(Edit1.Text,1,Edit1.SelStart);
  b := Edit1.Text;
  Delete(b,1,Edit1.SelStart);
  i := 1;
  if a <> '' then begin
    p := @a[1];
    r := AnsiStrRScan(p,';');
    if r <> nil then begin
      i := r-p+2;
      while (i < length(a)) and (a[i] = ' ') do inc(i); 
    end;
  end;
  j := Length(b);
  if b <> '' then begin
    p := @b[1];
    r := AnsiStrScan(p,';');
    if r <> nil then j := r-p+1;
  end;
  with Edit1 do begin
    SelStart := i-1;
    SelLength := length(a)-i+1+j;
  end;
end;

procedure TfrmMessageContact.DoSend(AsDraft: boolean);
var
  smsRef: String;
  it,sl: TTntStringList;
  k, i, j, m, startpos, stoppos: Integer;
  group,complex: Boolean;
  str, grp, text, temp: WideString;
  smstot,udhi:string;
  packetL: Integer;
  procedure CheckValidNumber(number: string);
  var
    j: Integer;
  begin
    for j := 1 to length(number) do
      if not isDelimiter('+0123456789pt,', number, j) then begin // do not localize
        MessageBeep(MB_ICONEXCLAMATION);
        MessageDlgW(WideFormat(_('Invalid number specified for %s.'),[number]),
          mtError, MB_OK);
        Abort;
      end;
  end;
begin
  sl := TTntStringList.Create;
  try
    str := '';
    // TODO: Use GetFirstToken(Edit1.Text,';') to separate recipients here....
    for i := 1 to length(Edit1.Text) do begin
      if not IsDelimiter(';', Edit1.Text, i) then str := str + Edit1.Text[i]
      else begin
        if trim(str) <> '' then sl.Add(trim(str));
        str := '';
      end;

      if i = length(Edit1.Text) then
        if trim(str) <> '' then sl.Add(trim(str));
    end;

    if sl.Count = 0 then begin
      MessageBeep(MB_ICONEXCLAMATION);
      MessageDlgW(_('You have to select at least one recepient.'),mtError, MB_OK);
      Abort;
    end;

    { TODO: sanity check all sl.items into separated loop after this one,
      i.e. move CheckValidNumber there. }
    for i := 0 to sl.Count-1 do begin
      group := False;
      complex := False;
      for j := 1 to length(sl.Strings[i]) do begin
        if IsDelimiter('[]', sl.Strings[i], j) then complex := True;
        if IsDelimiter('{}', sl.Strings[i], j) then group := True;
      end;

      if group then begin
        startpos := pos('{', sl.Strings[i]);
        stoppos := pos('}', sl.Strings[i]);

        { make sure it will have at least one element }
        if (startpos = 0) or (stoppos < (startpos+2)) then begin
          MessageBeep(MB_ICONEXCLAMATION);
          MessageDlgW(_('Invalid group address.'),mtError, MB_OK);
          Abort;
        end;

        sl.Strings[i] := copy(sl.Strings[i], startpos + 1, stoppos - startpos - 1);

        it := TTntStringList.Create;
        try
          grp := sl.Strings[i];
          while grp <> '' do it.Add(GetFirstToken(grp));
          { convert all from names to numbers }
          for k := 0 to it.Count-1 do begin
            str := Form1.LookupNumber(it[k]);
            if str <> '' then it[k] := str;
          end;
          { sanity check }
          for k := 0 to it.Count-1 do
            CheckValidNumber(it[k]);
          { replace group with first memeber }
          sl.Strings[i] := it[0];
          { then add others at the end of list. it's safe to do that
            since these number don't have to be checked out. }
          for k := 1 to it.Count-1 do
            sl.Add(it[k]);
        finally
          it.free;
        end;
      end
      else
      if complex then begin
        startpos := pos('[', sl.Strings[i]);
        stoppos := pos(']', sl.Strings[i]);

        { make sure it will have at least one element }
        if (startpos = 0) or (stoppos < (startpos+2)) then begin
          MessageBeep(MB_ICONEXCLAMATION);
          MessageDlgW(_('Invalid address specified.'),mtError, MB_OK);
          Abort;
        end;

        { sanity check }
        sl.Strings[i] := copy(sl.Strings[i], startpos + 1, stoppos - startpos - 1);
        CheckValidNumber(sl.Strings[i]);
      end
      else begin
        { Check if we have contact instead of number }
        str := Form1.LookupNumber(sl.Strings[i]);
        if str <> '' then sl.Strings[i] := str;
        { sanity check }
        CheckValidNumber(sl.Strings[i]);
      end;
    end;

    Text := Memo.Text;

    if btnLongSMS.Down and (Length(Text) > FMaxLength) then begin
       //sending Long SMS...
       packetL := 0;
       case FDCS of
         gcsDefault7Bit:
           packetL := (FMaxLength - 7); { 160 septets - UDH (6 octets+padding) }
         gcs8BitOctets:
           packetL := (FMaxLength - 6); { 140 octets - UDH (6 octets) }
         gcs16bitUcs2:
           packetL := (FMaxLength - 3); { 140 octets (70widechars) - UDH (6 octets) }
         else Abort;
       end;
       smstot := IntToHex((length(Text) div packetL) + 1, 2);
       //for all recepients...
       for i := 0 to sl.Count - 1 do begin
          StatusBar.Panels[2].Text := Format(_('Sending long message to %s...'), [sl.Strings[i]]);
          //...create the sms ref...
          smsRef := Form1.GetNextLongSMSRefference;
          udhi := '050003' + smsRef + smsTot; // see docs for 050003 magic // do not localize
          //...and send sms segments
          Text := Memo.Text;
          for m := 1 to (length(Text) div packetL) + 1 do begin
            Temp := Copy(Text, (m-1)*packetL + 1, packetL);
            Form1.SendTextMessage(udhi + IntToHex(m,2), Temp, sl.Strings[i], btnRequestReply.Down, btnFlashSMS.Down,
              btnStatusReport.Down, FDCS, AsDraft);
          end;
       end;
    end
    else begin
       //normal SMS...
       for i := 0 to sl.Count - 1 do begin
          StatusBar.Panels[2].Text := Format(_('Sending message to %s...'), [sl.Strings[i]]);
          Form1.SendTextMessage('', Text, sl.Strings[i], btnRequestReply.Down, btnFlashSMS.Down, btnStatusReport.Down,
            FDCS, AsDraft);
       end;
    end;

    if AsDraft then
      StatusBar.Panels[2].Text := Format(_('Total messages sent: %d'),[Form1.FSMSCounter]); // we're not sending actualy

    if FChatMode then
      StatusBar.Panels[2].Text := _('Sending message...'); // the recipient is well-known so dont show it
  finally
    sl.Free;
  end;
  { Close window is sending as normal SMS } 
  if not AsDraft and not FChatMode then begin
    btnSave.Enabled := False;
    Close;
  end;
end;

procedure TfrmMessageContact.SendClick(Sender: TObject);
begin
  DoSend;
end;

procedure TfrmMessageContact.SaveClick(Sender: TObject);
begin
  DoSend(True);
  btnSave.Enabled := False;
end;

procedure TfrmMessageContact.Edit1Change(Sender: TObject);
begin
  btnSave.Enabled := memo.Text <> '';
end;

procedure TfrmMessageContact.FormActivate(Sender: TObject);
begin
  StatusBar.Panels[2].Text := Format(_('Total messages sent: %d'),[Form1.FSMSCounter]);
  WarningPanel.Visible := Form1.FSMSDoWarning and (Form1.FSMSCounter >= Form1.FSMSWarning);
  if WarningPanel.Visible then begin
    if not FChatMode then
      Memo.Top := WarningPanel.Top + WarningPanel.Height;
    lbWarning.Caption := Format(_('Warning! You have reached your send limit of %d messages.'),[Form1.FSMSWarning]);
  end;
  ToolBar2Resize(nil);
end;

procedure TfrmMessageContact.PopupMenu1Click(Sender: TObject);
begin
  AddRecipient((Sender as TTntMenuItem).Caption);
end;

procedure TfrmMessageContact.FavoritesPopupMenuPopup(Sender: TObject);
var
  i: integer;
  Item: TTntMenuItem;
begin
  AddToFavorites1.Enabled := Edit1.Text <> '';
  while FavoritesPopupMenu.Items.Count > 3 do
    FavoritesPopupMenu.Items.Delete(3);
  for i := 0 to Form1.FFavoriteRecipients.Count-1 do begin
    Item := TTntMenuItem.Create(FavoritesPopupMenu);
    Item.Caption := Form1.FFavoriteRecipients[i];
    Item.AutoHotkeys := maManual;
    Item.ImageIndex := 26;
    Item.OnClick := PopupMenu1Click;
    FavoritesPopupMenu.Items.Add(Item);
  end;
end;

procedure TfrmMessageContact.btnRecentClick(Sender: TObject);
var
  P: TPoint;
begin
  //btnRecent.CheckMenuDropdown;
  P := btnRecent.ClientToScreen(Point(0,btnRecent.Height));
  btnRecent.DropdownMenu.Popup(P.X,P.Y);
end;

procedure TfrmMessageContact.ClearMessageCounter1Click(Sender: TObject);
begin
  Form1.FSMSCounter := 0;
  FormActivate(nil);
end;

procedure TfrmMessageContact.PopupMenu2Popup(Sender: TObject);
begin
  ClearMessageCounter1.Enabled := Form1.FSMSCounter <> 0;
end;

procedure TfrmMessageContact.LongClick(Sender: TObject);
begin
  if not btnLongSMS.Down and (length(Memo.Text) > FMaxLength) then begin
    MessageBeep(MB_ICONQUESTION);
    if MessageDlgW(_('This will crop some text from the end of the current message?'),
      mtConfirmation, MB_OKCANCEL or MB_DEFBUTTON2) <> ID_OK then begin
      btnLongSMS.Down := True;
      exit;
    end;
  end;
  if not btnLongSMS.Down then begin
    Memo.Text := Copy(Memo.Text,1,FMaxLength);
    Memo.SelStart := Length(Memo.Text);
  end;
  MemoChange(nil);
end;

procedure TfrmMessageContact.ToPopupMenuPopup(Sender: TObject);
begin
  Delete1.Enabled := Edit1.SelText <> '';
  AddToPhonebook1.Enabled := Delete1.Enabled and (Pos('{',Edit1.SelText) = 0) and
    (Form1.LookupContact(Form1.ExtractNumber(Edit1.SelText)) = '');
end;

procedure TfrmMessageContact.Delete1Click(Sender: TObject);
begin
  Edit1.SelText := '';
end;

procedure TfrmMessageContact.AddToPhonebook1Click(Sender: TObject);
begin
  if Form1.frmSyncPhonebook.DoEdit(True,Form1.ExtractNumber(Edit1.SelText)) then
    Edit1.SelText := Form1.ContactNumberByTel(Form1.ExtractNumber(Edit1.SelText));
end;

procedure TfrmMessageContact.AddToFavorites1Click(Sender: TObject);
begin
  if Form1.FFavoriteRecipients.IndexOf(Edit1.Text) = -1 then begin
    Form1.FFavoriteRecipients.Insert(0,Edit1.Text);
    while Form1.FFavoriteRecipients.Count > MaxFavorites do
      Form1.FFavoriteRecipients.Delete(MaxFavorites);
  end;
end;

procedure TfrmMessageContact.Organize1Click(Sender: TObject);
begin
  Form1.EditFavorites1.Click;
end;

procedure TfrmMessageContact.UCS2Click(Sender: TObject);
begin
  with Sender as TTntMenuItem do Checked := not Checked; 
  Form1.FForceUCSusage := ForceUCS2Encoding1.Checked;
  MemoChange(Memo);
end;

procedure TfrmMessageContact.EncodingPopupMenu1Popup(Sender: TObject);
begin
  ForceUCS2Encoding1.Checked := Form1.FForceUCSusage;
end;

procedure TfrmMessageContact.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);
end;

procedure TfrmMessageContact.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #27 then begin
    Key := #0;
    Close;
  end;
end;

procedure TfrmMessageContact.TntFormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  try
    Clear;
  except
    CanClose := False;
  end;
end;

end.
