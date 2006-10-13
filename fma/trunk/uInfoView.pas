unit uInfoView;

{
*******************************************************************************
* Descriptions: Phone Info view implementation
* $Source: /cvsroot/fma/fma/uInfoView.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uInfoView.pas,v $
*
*******************************************************************************
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms, Dialogs, TntDialogs,
  StdCtrls, TntStdCtrls, ExtCtrls, TntExtCtrls, TeEngine, Series, TeeProcs, Chart, ComCtrls, TntComCtrls, UniTntCtrls,
  ImgList, jpeg, Buttons, TntButtons, LMDControl, LMDBaseControl,
  LMDBaseGraphicControl, LMDGraphicControl, LMDBaseMeter,
  LMDCustomProgressFill, LMDProgressFill, LMDFill, Menus, TntMenus, VirtualTrees,
  cUnicodeCodecs;

type
  TfrmInfoView = class(TTntFrame)
    Panel1: TTntPanel;
    Panel2: TTntPanel;
    TodayCaptionPanel: TTntPanel;
    wOperator: TTntLabel;
    wSignal: TTntLabel;
    SignalImage: TTntImage;
    wDate: TTntLabel;
    Label9: TTntLabel;
    Image1: TTntImage;
    LMDFill2: TLMDFill;
    PopupMenu2: TTntPopupMenu;
    CallContact1: TTntMenuItem;
    MessageContact1: TTntMenuItem;
    Splitter1: TTntSplitter;
    InboxPanel: TTntPanel;
    Label17: TTntLabel;
    Label10: TTntLabel;
    Bevel2: TTntBevel;
    Image3: TTntImage;
    Label11: TTntLabel;
    wInboxNew: TTntLabel;
    CallsPanel: TTntPanel;
    Label15: TTntLabel;
    Label21: TTntLabel;
    Bevel4: TTntBevel;
    Image5: TTntImage;
    Label22: TTntLabel;
    wRecentCallsNum: TTntLabel;
    lvCalls: TTntListView;
    BatteryPanel: TTntPanel;
    Label26: TTntLabel;
    Label27: TTntLabel;
    Bevel6: TTntBevel;
    Image7: TTntImage;
    Label5: TTntLabel;
    Label3: TTntLabel;
    Label2: TTntLabel;
    Label4: TTntLabel;
    Label7: TTntLabel;
    Label1: TTntLabel;
    Label28: TTntLabel;
    Label29: TTntLabel;
    Label8: TTntLabel;
    Label35: TTntLabel;
    wCharge: TTntLabel;
    lblTimeLeft: TTntLabel;
    wBattery: TTntLabel;
    lbPower: TTntLabel;
    lbvbat: TTntLabel;
    lbdcio: TTntLabel;
    lbcyclescharge: TTntLabel;
    lbicharge: TTntLabel;
    lbiphone: TTntLabel;
    lbtempbatt: TTntLabel;
    Splitter2: TTntSplitter;
    Splitter3: TTntSplitter;
    OuboxPanel: TTntPanel;
    Label18: TTntLabel;
    Label19: TTntLabel;
    Bevel3: TTntBevel;
    Image4: TTntImage;
    Label20: TTntLabel;
    wOutboxNew: TTntLabel;
    MissedCallsPanel: TTntPanel;
    lvMissed: TTntListView;
    Label24: TTntLabel;
    Label25: TTntLabel;
    Label23: TTntLabel;
    Image6: TTntImage;
    wMissedCallsNum: TTntLabel;
    Bevel5: TTntBevel;
    PhoneAddressPanel: TTntPanel;
    BigImage: TTntImage;
    Splitter4: TTntSplitter;
    Splitter5: TTntSplitter;
    Label32: TTntLabel;
    Label33: TTntLabel;
    Image9: TTntImage;
    Bevel1: TTntBevel;
    wMENum: TTntLabel;
    AddToPhonebook1: TTntMenuItem;
    N1: TTntMenuItem;
    N2: TTntMenuItem;
    Refresh1: TTntMenuItem;
    N3: TTntMenuItem;
    Properties1: TTntMenuItem;
    Image10: TTntImage;
    Image11: TTntImage;
    Image12: TTntImage;
    Image13: TTntImage;
    Image14: TTntImage;
    Image15: TTntImage;
    ImageList1: TImageList;
    ChatContact1: TTntMenuItem;
    Image8: TTntImage;
    Label6: TTntLabel;
    Label12: TTntLabel;
    Label13: TTntLabel;
    Label16: TTntLabel;
    Label14: TTntLabel;
    lbSerialNumber: TTntLabel;
    lbSWRevision: TTntLabel;
    lbModel: TTntLabel;
    lbManufacturer: TTntLabel;
    lbtempphone: TTntLabel;
    Label30: TTntLabel;
    Label31: TTntLabel;
    Label34: TTntLabel;
    Label36: TTntLabel;
    Label37: TTntLabel;
    wArchiveNum: TTntLabel;
    Image16: TTntImage;
    Image17: TTntImage;
    Image18: TTntImage;
    Image19: TTntImage;
    Label38: TTntLabel;
    DiagramPanel: TTntPanel;
    Chart1: TChart;
    Series1: TLineSeries;
    Series3: TLineSeries;
    Series2: TLineSeries;
    linkGetMessages: TTntLabel;
    linkJumpInbox: TTntLabel;
    linkJumpArchive: TTntLabel;
    linkComposeMessage: TTntLabel;
    linkSendMessages: TTntLabel;
    linkShowNewMessages: TTntLabel;
    linkSyncPhonebook: TTntLabel;
    linkNewContact: TTntLabel;
    linkShowPhonebook: TTntLabel;
    linkJumpOutbox: TTntLabel;
    linkShowSIM: TTntLabel;
    linkShowCalendar: TTntLabel;
    linkSyncCalendar: TTntLabel;
    linkShowBookmarks: TTntLabel;
    linkNewTask: TTntLabel;
    linkSyncOutlook: TTntLabel;
    linkNewEvent: TTntLabel;
    linkWhatsNext: TTntLabel;
    linkShowFiles: TTntLabel;
    linkNewNote: TTntLabel;
    linkSyncBookmarks: TTntLabel;
    linkSyncAll: TTntLabel;
    linkJumpSent: TTntLabel;
    TntPanel1: TTntPanel;
    TntPanel2: TTntPanel;
    procedure ListViewResize(Sender: TObject);
    procedure ListViewCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure FrameResize(Sender: TObject);
    procedure Refresh1Click(Sender: TObject);
    procedure PopupMenu2Popup(Sender: TObject);
    procedure Properties1Click(Sender: TObject);
    procedure SplitterPaint(Sender: TObject);
    procedure OpenCloseImageClick(Sender: TObject);
    procedure TodayCaptionPanelResize(Sender: TObject);
    procedure linkGetMessagesClick(Sender: TObject);
    procedure linkJumpMsgFolderClick(Sender: TObject);
    procedure linkComposeMessageClick(Sender: TObject);
    procedure linkSendMessagesClick(Sender: TObject);
    procedure linkSyncPhonebookClick(Sender: TObject);
    procedure linkShowPhonebookClick(Sender: TObject);
    procedure linkNewContactClick(Sender: TObject);
    procedure linkShowSIMClick(Sender: TObject);
    procedure linkShowCalendarClick(Sender: TObject);
    procedure linkSyncCalendarClick(Sender: TObject);
    procedure linkShowBookmarksClick(Sender: TObject);
    procedure linkNewTaskClick(Sender: TObject);
    procedure linkSyncOutlookClick(Sender: TObject);
    procedure linkNewEventClick(Sender: TObject);
    procedure linkWhatsNextClick(Sender: TObject);
    procedure linkShowFilesClick(Sender: TObject);
    procedure linkNewNoteClick(Sender: TObject);
    procedure linkSyncAllClick(Sender: TObject);
    procedure linkSyncBookmarksClick(Sender: TObject);
    procedure linkJumpSentClick(Sender: TObject);
    procedure BatteryPanelResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetIdent;
    procedure UpdateWelcomePage(Init: boolean = False);
  end;

implementation

uses
  gnugettext, gnugettexthelpers, uThreadSafe, uConnProgress,
  uGlobal, Unit1, uMissedCalls, uCalling, uSyncPhonebook, uSIMEdit, uComposeSMS;

{$R *.dfm}

{ TfrmInfoView }

procedure TfrmInfoView.GetIdent;
begin
  try
    Form1.TxAndWait('AT+CGMI'); // do not localize
    lbManufacturer.Caption := ThreadSafe.RxBuffer[0];
  except
    lbManufacturer.Caption := '?'; //TODO -cl10n: localize?
  end;

  try
    Form1.TxAndWait('AT+CGMM'); // do not localize
    lbModel.Caption := ThreadSafe.RxBuffer[0];
  except
    lbModel.Caption := '?'; //TODO -cl10n: localize?
  end;

  try
    Form1.TxAndWait('AT+CGMR'); // do not localize
    lbSWRevision.Caption := ThreadSafe.RxBuffer[0];
  except
    lbSWRevision.Caption := '?'; //TODO -cl10n: localize?
  end;

  try
    Form1.TxAndWait('AT+CGSN'); // do not localize
    lbSerialNumber.Caption := ThreadSafe.RxBuffer[0];
  except
    lbSerialNumber.Caption := '?'; //TODO -cl10n: localize?
  end;
end;

procedure TfrmInfoView.UpdateWelcomePage(Init: boolean);
var
  i: integer;
  s: WideString;
  Node: PVirtualNode;
  EData, EData2: PFmaExplorerNode;
  function GetNewSMSCount(Node: PVirtualNode): Integer;
  var
    c: Integer;
    itNode: PVirtualNode;
    data: PFmaExplorerNode;
  begin
    c := Form1.GetNewMessagesCounter(Node);
    itNode := Node.FirstChild;
    while itNode <> nil do begin
      data := Form1.ExplorerNew.GetNodeData(itNode);
      if data.StateIndex = FmaSMSSubFolderFlag then
        c := c + GetNewSMSCount(itNode);
      itNode := itNode.NextSibling;
    end;
    Result := c;
  end;
  procedure AddCallsItem(Target: TTntListView);
  var
    ws: WideString;
  begin
    with Target.Items.Add do begin
      ImageIndex := EData.ImageIndex;
      if Form1.FUseUTF8 then
        ws := UTF8StringToWideString(TStrings(EData2.Data)[EData.StateIndex-1])
      else
        ws := TStrings(EData2.Data)[EData.StateIndex-1];
      Caption := GetFirstToken(ws);
      SubItems.Add(GetFirstToken(ws));
    end;
  end;
begin
  { Signal and Power }
  if Form1.FConnectingComplete then begin
    i := Form1.pbRSSI.Position;
    if Form1.FUseCSQ and (i <> 0) then
      wSignal.Caption := IntToStr(i)+'%'
    else
      wSignal.Caption := _('N/A');
    if Form1.FUseCBC then begin
      wBattery.Caption := IntToStr(Form1.pbPower.Position)+'%';
      if Form1.FOnACPower then wCharge.Caption := _('yes')
        else wCharge.Caption := _('no');
    end
    else begin
      wBattery.Caption := _('N/A');
      wCharge.Caption := _('N/A');
      lblTimeLeft.Caption := _('N/A');
    end;
    if Form1.FBatteryLow then
      wBattery.Font.Color := clRed
    else
      wBattery.ParentFont := True;
  end
  else begin
    wSignal.Caption := '?';
    wBattery.Caption := '?';
    wCharge.Caption := '?';
    //lblTimeLeft.Caption := '?';
  end;
  { Inbox and Outbox }
  i := GetNewSMSCount(Form1.FNodeMsgRoot) + GetNewSMSCount(Form1.FNodeMsgInbox) +
    GetNewSMSCount(Form1.FNodeMsgSent) + GetNewSMSCount(Form1.FNodeMsgArchive);
  if i <> 0 then begin
    wInboxNew.Caption := IntToStr(i);
    wInboxNew.Font.Style := wInboxNew.Font.Style + [fsBold];
    wInboxNew.Font.Color := clRed;
    linkShowNewMessages.Enabled := True;
  end
  else begin
    wInboxNew.Caption := _('none');
    wInboxNew.ParentFont := True;
    linkShowNewMessages.Enabled := False;
  end;
  i := Form1.GetNewMessagesCounter(Form1.FNodeMsgOutbox);
  if i <> 0 then begin
    wOutboxNew.Caption := IntToStr(i);
    wOutboxNew.Font.Style := wInboxNew.Font.Style + [fsBold];
    wOutboxNew.Font.Color := clRed;
    linkSendMessages.Enabled := True;
  end
  else begin
    wOutboxNew.Caption := _('none');
    wOutboxNew.ParentFont := True;
    linkSendMessages.Enabled := False;
  end;
  { Calls }
  if Form1.ActionMissedCalls.Enabled and (frmMissedCalls <> nil) and (frmMissedCalls.RecentMissedCalls <> 0) then begin
    i := frmMissedCalls.RecentMissedCalls;
    wMissedCallsNum.Caption := IntToStr(i);
    wMissedCallsNum.Font.Style := wMissedCallsNum.Font.Style + [fsBold];
    wMissedCallsNum.Font.Color := clRed;
  end
  else begin
    wMissedCallsNum.Caption := _('none');
    wMissedCallsNum.ParentFont := True;
  end;
  { Address book }
  if not Form1.FStartupOptions.NoObex and not Form1.FStartupOptions.NoIRMC then
    i := Form1.frmSyncPhonebook.ListContacts.RootNodeCount
  else begin
    EData := Form1.ExplorerNew.GetNodeData(Form1.FNodeContactsME);
    i := TStrings(EData.Data).Count;
  end;
  wMENum.Caption := IntToStr(i);
  EData := Form1.ExplorerNew.GetNodeData(Form1.FNodeMsgArchive);
  wArchiveNum.Caption := IntToStr(TStrings(EData.Data).Count); { TODO: Add long SMS support }
  { Today page components }
  if Form1.FShowDiagram {and Form1.CanUseEBCA(True)} then begin
    if DiagramPanel.Width = 0 then begin
      DiagramPanel.Width := 250;
      DiagramPanel.Left := LMDFill2.Left + LMDFill2.Width;
      wSignal.Left := wSignal.Left - DiagramPanel.Width;
      wOperator.Left := wOperator.Left - DiagramPanel.Width;
      SignalImage.Left := SignalImage.Left - DiagramPanel.Width;
      if not Form1.FShowTodayCaption then
        Form1.ShowCaption1.Click;
      Chart1.Left := 4;
      Chart1.Width := DiagramPanel.Width - 9;  
    end;
  end
  else begin
    if DiagramPanel.Width <> 0 then begin
      wSignal.Left := wSignal.Left + DiagramPanel.Width;
      wOperator.Left := wOperator.Left + DiagramPanel.Width;
      SignalImage.Left := SignalImage.Left + DiagramPanel.Width;
      DiagramPanel.Width := 0;
      LMDFill2.Left := 80;
    end;
  end;
  TodayCaptionPanel.Visible := Form1.FShowTodayCaption;
  { Initial update when Welcome page is shown }
  if Init then begin
    if not IsRightToLeft then
      begin
        { Inbox }
        linkJumpArchive.Left := linkJumpInbox.Left + linkJumpInbox.Width + 8;
        linkGetMessages.Left := linkJumpArchive.Left + linkJumpArchive.Width + 8;
        { Outbox }
        linkJumpSent.Left := linkComposeMessage.Left + linkComposeMessage.Width + 8;
        linkJumpOutbox.Left := linkJumpSent.Left + linkJumpSent.Width + 8;
        { My Data }
        linkNewTask.Left := linkNewContact.Left + linkNewContact.Width + 8;
        linkNewEvent.Left := linkNewTask.Left + linkNewTask.Width + 8;
        linkNewNote.Left := linkNewEvent.Left + linkNewEvent.Width + 8;
        // 2nd row
        linkShowSIM.Left := linkShowPhonebook.Left + linkShowPhonebook.Width + 8;
        linkShowCalendar.Left := linkShowSIM.Left + linkShowSIM.Width + 8;
        linkShowBookmarks.Left := linkShowCalendar.Left + linkShowCalendar.Width + 8;
        linkShowFiles.Left := linkShowBookmarks.Left + linkShowBookmarks.Width + 8;
        // 3rd row
        linkSyncCalendar.Left := linkSyncPhonebook.Left + linkSyncPhonebook.Width + 8;
        linkSyncBookmarks.Left := linkSyncCalendar.Left + linkSyncCalendar.Width + 8;
        linkSyncOutlook.Left := linkSyncBookmarks.Left + linkSyncBookmarks.Width + 8;
        linkSyncAll.Left := linkSyncOutlook.Left + linkSyncOutlook.Width + 8;
      end
    else
      begin
        (*
        linkJumpArchive.Left := linkJumpInbox.Left - linkJumpArchive.Width - 8;
        linkGetMessages.Left := linkJumpArchive.Left - linkGetMessages.Width - 8;
        linkJumpOutbox.Left := linkComposeMessage.Left - linkJumpOutbox.Width - 8;
        linkShowPhonebook.Left := linkNewContact.Left - linkShowPhonebook.Width - 8;
        linkShowSIM.Left := linkShowPhonebook.Left - linkShowSIM.Width - 8;
        //linkCalendar.Left := linkShowSIM.Left - linkCalendar.Width - 8;
        *)
      end;
    { Date and Operator }
    wDate.Caption := FormatDateTime(LongDateFormat,Date);
    s := Form1.FSelOperator;
    if s = '' then s := '?';
    wOperator.Caption := s;
    try
      { Calls }
      lvCalls.Items.BeginUpdate;
      try
        lvCalls.Clear;
        EData2 := Form1.ExplorerNew.GetNodeData(Form1.FNodeCallsIn);
        Node := Form1.FNodeCallsIn.FirstChild;
        while Node <> nil do begin
          EData := Form1.ExplorerNew.GetNodeData(Node);
          AddCallsItem(lvCalls);
          Node := Node.NextSibling;
        end;

        EData2 := Form1.ExplorerNew.GetNodeData(Form1.FNodeCallsOut);
        Node := Form1.FNodeCallsOut.FirstChild;
        while Node <> nil do begin
          EData := Form1.ExplorerNew.GetNodeData(Node);
          AddCallsItem(lvCalls);
          Node := Node.NextSibling;
        end;
        wRecentCallsNum.Caption := IntToStr(lvCalls.Items.Count);
      finally
        lvCalls.AlphaSort;
        lvCalls.Items.EndUpdate;
      end;
      lvMissed.Items.BeginUpdate;
      try
        lvMissed.Clear;
        EData2 := Form1.ExplorerNew.GetNodeData(Form1.FNodeCallsMissed);
        Node := Form1.FNodeCallsMissed.FirstChild;
        while Node <> nil do begin
          EData := Form1.ExplorerNew.GetNodeData(Node);
          AddCallsItem(lvMissed);
          Node := Node.NextSibling;
        end;
      finally
        lvMissed.AlphaSort;
        lvMissed.Items.EndUpdate;
      end;
    except
    end;
  end;
end;

procedure TfrmInfoView.ListViewResize(Sender: TObject);
begin
  with Sender as TTntListView do begin
    Items.BeginUpdate;
    Columns[1].Width := 100;
    Columns[0].Width := Width - Columns[1].Width - 24;
    Columns[0].Width := Columns[0].Width - 1;
    Items.EndUpdate;
  end;
end;

procedure TfrmInfoView.ListViewCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  { Show recent first }
  Compare := CompareStr(Item2.SubItems[0],Item1.SubItems[0]);
end;

procedure TfrmInfoView.FrameResize(Sender: TObject);
begin
  Panel1.Width := Width div 2;
end;

procedure TfrmInfoView.linkGetMessagesClick(Sender: TObject);
begin
  Form1.DownloadAllMessages;
end;

procedure TfrmInfoView.linkJumpMsgFolderClick(Sender: TObject);
begin
  if Sender = linkJumpOutbox then
    Form1.ExplorerNew.FocusedNode := Form1.FNodeMsgOutbox
  else
  if Sender = linkJumpInbox then
    Form1.ExplorerNew.FocusedNode := Form1.FNodeMsgInbox
  else
  if Sender = linkJumpArchive then
    Form1.ExplorerNew.FocusedNode := Form1.FNodeMsgArchive
  else
  if Sender = linkShowNewMessages then
    if Form1.GetNewMessagesCounter(Form1.FNodeMsgInbox) <> 0 then
      Form1.ExplorerNew.FocusedNode := Form1.FNodeMsgInbox
    else
      Form1.ExplorerNew.FocusedNode := Form1.FNodeMsgArchive;
  Form1.ExplorerNewChange(Form1.ExplorerNew, Form1.ExplorerNew.FocusedNode);
end;

procedure TfrmInfoView.linkComposeMessageClick(Sender: TObject);
begin
  Form1.ActionSMSNewMsg.Execute;
end;

procedure TfrmInfoView.linkSendMessagesClick(Sender: TObject);
begin
  Form1.ActionConnectionSendOutboxMsgs.Execute;
end;

procedure TfrmInfoView.linkSyncPhonebookClick(Sender: TObject);
begin
  Form1.ActionSyncPhonebook.Execute;
end;

procedure TfrmInfoView.linkShowPhonebookClick(Sender: TObject);
begin
  Form1.ExplorerNew.FocusedNode := Form1.FNodeContactsME;
  Form1.ExplorerNewChange(Form1.ExplorerNew, Form1.ExplorerNew.FocusedNode);
end;

procedure TfrmInfoView.linkNewContactClick(Sender: TObject);
begin
  if Form1.ActionContactsNewPerson.Execute then
    UpdateWelcomePage;
end;

procedure TfrmInfoView.Refresh1Click(Sender: TObject);
begin
  if Screen.ActiveControl = lvCalls then begin
    Form1.InitCalls(Form1.fnodecallsIn);
    UpdateWelcomePage(True);
    Form1.InitCalls(Form1.fnodecallsOut);
    UpdateWelcomePage(True);
  end;
  if Screen.ActiveControl = lvMissed then begin
    Form1.InitCalls(Form1.fnodecallsMissed);
    UpdateWelcomePage(True);
  end;
end;

procedure TfrmInfoView.PopupMenu2Popup(Sender: TObject);
var
  found: TFindContactResult;
begin
  Refresh1.Enabled := Form1.FConnected and not Form1.FObex.Connected;
  if Form1.IsContactNumberSelected then begin
    found := Form1.WhereisContact(Form1.LocateSelContactNumber,fcByNumber);
    Properties1.Tag := Ord(found);
    Properties1.Enabled := found <> frNone;
  end
  else
    Properties1.Enabled := False;
end;

procedure TfrmInfoView.Properties1Click(Sender: TObject);
var
  ContactME: PContactData;
  ContactSM: PSIMData;
  ContactName: WideString;
begin
  if Form1.IsContactNumberSelected then begin
    ContactName := Form1.LookupContact(Form1.LocateSelContactNumber);
    case TFindContactResult(Properties1.Tag) of
      frIrmcSync:
        if Form1.frmSyncPhonebook.FindContact(ContactName,ContactME) then
          with Form1.frmSyncPhonebook do begin
            SelContact := ContactME;
            if DoEdit then UpdateWelcomePage(True);
          end;
      frPhonebook: begin
        if Form1.frmMEEdit.FindContact(ContactName,ContactSM) then
          with Form1.frmMEEdit do begin
            SelContact := ContactSM;
            if DoEdit then UpdateWelcomePage(True);
          end;
      end;
      frSIMCard: begin
        if Form1.frmSMEdit.FindContact(ContactName,ContactSM) then
          with Form1.frmSMEdit do begin
            SelContact := ContactSM;
            if DoEdit then UpdateWelcomePage(True);
          end;
      end;
    end;
  end;
end;

procedure TfrmInfoView.SplitterPaint(Sender: TObject);
var
  R: TRect;
  i,j: integer;
begin
  with (Sender as TTntSplitter) do begin
    R := ClientRect;
    with Canvas do begin
      Pen.Color := $00E0F0E0;
      Pen.Style := psDot;
      Brush.Color := Color;
      Brush.Style := bsSolid;
      FillRect(R);
      i := Abs(R.Right - R.Left);
      j := Abs(R.Bottom - R.Top);
      if i < j then begin // vertical
        R.Top := R.Top + j div 2 - 31;
        R.Bottom := R.Bottom - j div 2 + 31;
        i := R.Left + i div 2;
        MoveTo(i-1,R.Top);
        LineTo(i-1,R.Bottom);
        MoveTo(i+1,R.Top);
        LineTo(i+1,R.Bottom);
        Pen.Color := $00A0C0A0;
        MoveTo(i,R.Top);
        LineTo(i,R.Bottom);
      end
      else begin // horizontal
        R.Left := R.Left + i div 2 - 31;
        R.Right := R.Right - i div 2 + 31;
        j := R.Top + j div 2;
        MoveTo(R.Left, j-1);
        LineTo(R.Right,j-1);
        MoveTo(R.Left, j+1);
        LineTo(R.Right,j+1);
        Pen.Color := $00A0C0A0;
        MoveTo(R.Left, j);
        LineTo(R.Right,j);
      end;
    end;
  end;
end;

procedure TfrmInfoView.OpenCloseImageClick(Sender: TObject);
var
  panel: TTntPanel;
begin
  panel := ((Sender as TControl).Parent as TTntPanel);
  if panel.Height < 40 then begin // open it
    (Sender as TTntImage).Tag := 0;
    ImageList1.GetBitmap(0,(Sender as TTntImage).Picture.Bitmap);
    { Resize }
    if Sender = Image13 then begin
      PhoneAddressPanel.Align := alBottom;
      PhoneAddressPanel.Height := PhoneAddressPanel.Height - panel.Tag;
      Splitter5.Align := alBottom;
      panel.Align := alClient;
    end;
    if Sender = Image12 then begin
      BatteryPanel.Align := alBottom;
      BatteryPanel.Height := BatteryPanel.Height - panel.Tag;
      Splitter3.Align := alBottom;
      panel.Align := alClient;
    end;
    panel.Constraints.MaxHeight := 0;
    panel.Constraints.MinHeight := panel.Tag;
    { update view }
    if Sender = Image15 then
      BigImage.Visible := True;
    if Sender = Image10 then begin
      Splitter2.Visible := True;
      Splitter2.Top := InboxPanel.Top + InboxPanel.Height;
    end;
    if Sender = Image11 then begin
      Splitter4.Visible := True;
      Splitter4.Top := OuboxPanel.Top + OuboxPanel.Height;
    end;
    if (Sender = Image14) or (Sender = Image12) then
      if (Image14.Tag = 0) and (Image12.Tag = 0) then begin
        Splitter3.Visible := True;
        Splitter3.Top := BatteryPanel.Top-1;
      end;
    if (Sender = Image15) or (Sender = Image13) then
      if (Image15.Tag = 0) and (Image13.Tag = 0) then begin
        Splitter5.Visible := True;
        Splitter5.Top := PhoneAddressPanel.Top-1;
      end;
  end
  else begin // close it
    (Sender as TTntImage).Tag := 1;
    ImageList1.GetBitmap(1,(Sender as TTntImage).Picture.Bitmap);
    { Resize }
    panel.Tag := panel.Constraints.MinHeight;
    panel.Constraints.MinHeight := 39;
    panel.Constraints.MaxHeight := 39;
    if Sender = Image13 then begin
      panel.Align := alTop;
      Splitter5.Align := alTop;
      PhoneAddressPanel.Align := alClient;
    end;
    if Sender = Image12 then begin
      panel.Align := alTop;
      Splitter3.Align := alTop;
      BatteryPanel.Align := alClient;
    end;
    { update view }
    if Sender = Image15 then
      BigImage.Visible := False;
    if Sender = Image10 then
      Splitter2.Visible := False;
    if Sender = Image11 then
      Splitter4.Visible := False;
    if (Sender = Image14) or (Sender = Image12) then
      Splitter3.Visible := False;
    if (Sender = Image15) or (Sender = Image13) then
      Splitter5.Visible := False;
  end;
end;

procedure TfrmInfoView.linkShowSIMClick(Sender: TObject);
begin
  Form1.ExplorerNew.FocusedNode := Form1.FNodeContactsSM;
  Form1.ExplorerNewChange(Form1.ExplorerNew, Form1.ExplorerNew.FocusedNode);
end;

procedure TfrmInfoView.linkShowCalendarClick(Sender: TObject);
begin
  Form1.ExplorerNew.FocusedNode := Form1.FNodeCalendar;
  Form1.ExplorerNewChange(Form1.ExplorerNew, Form1.ExplorerNew.FocusedNode);
  if Form1.ActionConnectionExplorer.Checked then
    Form1.ActionConnectionExplorer.Execute;
end;

procedure TfrmInfoView.linkSyncCalendarClick(Sender: TObject);
begin
  Form1.ActionSyncCalendar.Execute;
end;

procedure TfrmInfoView.linkSyncOutlookClick(Sender: TObject);
begin
  Form1.ActionSyncWithOutlook.Execute;
end;

procedure TfrmInfoView.linkShowBookmarksClick(Sender: TObject);
begin
  Form1.ExplorerNew.FocusedNode := Form1.FNodeBookmarks;
  Form1.ExplorerNewChange(Form1.ExplorerNew, Form1.ExplorerNew.FocusedNode);
end;

procedure TfrmInfoView.linkNewTaskClick(Sender: TObject);
begin
  Form1.ExplorerNew.FocusedNode := Form1.FNodeCalendar;
  { TODO: Call Add new task -- verify this! }
  Form1.frmCalendarView.VpTaskList.PopupMenu.Items[0].Click;
end;

procedure TfrmInfoView.linkNewEventClick(Sender: TObject);
begin
  Form1.ExplorerNew.FocusedNode := Form1.FNodeCalendar;
  { TODO: Call Add new task -- verify this! }
  Form1.frmCalendarView.VpDayView.PopupMenu.Items[0].Click;
end;

procedure TfrmInfoView.linkWhatsNextClick(Sender: TObject);
begin
  { First sync tasks and events }
  linkSyncCalendarClick(nil);
  { Then show them to the user }
  linkShowCalendarClick(nil);
end;

procedure TfrmInfoView.linkShowFilesClick(Sender: TObject);
begin
  { Browse phone files }
  Form1.ExplorerNew.FocusedNode := Form1.FNodeObex;
  Form1.ExplorerNewChange(Form1.ExplorerNew, Form1.ExplorerNew.FocusedNode);
  { Also show explorer tree }
  if not Form1.ActionConnectionExplorer.Checked then
    Form1.ActionConnectionExplorer.Execute;
end;

procedure TfrmInfoView.linkNewNoteClick(Sender: TObject);
begin
  Form1.ActionToolsPostNote.Execute;
end;

procedure TfrmInfoView.TodayCaptionPanelResize(Sender: TObject);
begin
  wSignal.Left := TodayCaptionPanel.Width - wSignal.Width - DiagramPanel.Width - 12;
  wOperator.Left := TodayCaptionPanel.Width - wOperator.Width - DiagramPanel.Width - 12;
  SignalImage.Left := wSignal.Left - 41;
end;

procedure TfrmInfoView.linkSyncAllClick(Sender: TObject);
var
  dlg: TfrmConnect;
  tid: Integer;
begin
  dlg := GetProgressDialog;
  linkSyncAll.Enabled := False;
  try
    tid := dlg.CurrentTaskID;
    if Form1.CanShowProgress then
      dlg.ShowProgress;
    { First sync with phone... }
    dlg.Initialize(6,_('Synchronization in progress'));
    Form1.ActionSyncClock.Execute;
    dlg.IncProgress(1,tid);
    linkGetMessagesClick(nil);
    dlg.IncProgress(1,tid);
    linkSyncBookmarksClick(nil);
    dlg.IncProgress(1,tid);
    linkSyncPhonebookClick(nil);
    dlg.IncProgress(1,tid);
    linkSyncCalendarClick(nil);
    { ...then sync changes to Outlook... }
    dlg.IncProgress(1,tid);
    linkSyncOutlookClick(nil);
    { ...and finaly apply changes back to phone }
    dlg.IncProgress(1,tid);
    linkSyncPhonebookClick(nil);
    {
    dlg.IncProgress(1,tid);
    linkSyncCalendarClick(nil);
    }
  finally
    linkSyncAll.Enabled := True;
    FreeProgressDialog;
  end;
end;

procedure TfrmInfoView.linkSyncBookmarksClick(Sender: TObject);
begin
  Form1.ActionSyncBookmarks.Execute;
end;

procedure TfrmInfoView.linkJumpSentClick(Sender: TObject);
begin
  Form1.ExplorerNew.FocusedNode := Form1.FNodeMsgSent;
  Form1.ExplorerNewChange(Form1.ExplorerNew, Form1.ExplorerNew.FocusedNode);
end;

procedure TfrmInfoView.BatteryPanelResize(Sender: TObject);
begin
  TntPanel1.Width := BatteryPanel.Width div 2;
  TntPanel2.Left := BatteryPanel.Width div 2;
  TntPanel2.Width := BatteryPanel.Width - TntPanel2.Left;
end;

end.
