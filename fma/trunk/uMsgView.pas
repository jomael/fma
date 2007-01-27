unit uMsgView;

{
*******************************************************************************
* Descriptions: Implementation for SMS Listing
* $Source: /cvsroot/fma/fma/uMsgView.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uMsgView.pas,v $
*
*******************************************************************************
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls,
  Forms, TntForms, Dialogs, TntDialogs, Menus, TntMenus, ImgList, VirtualTrees, ExtCtrls, TntExtCtrls, StdCtrls, TntStdCtrls,
  ComCtrls, TntComCtrls, UniTntCtrls, DateUtils, GR32_Image, Buttons, TntButtons, Placemnt, LMDControl, LMDBaseControl,
  LMDBaseGraphicControl, LMDGraphicControl, LMDFill, ToolWin, uMessageData;

type
  TListData = Record
    imageindex: Integer;
    stateindex: Integer;
    from,sender: WideString; // from is 'sender [number]', and sender is just the name
    smsData: TFmaMessageData;
  end;
  PListData = ^TListData;

  TSearchMode = (smSender,smFrom,smAll,smText,smDate);

  TfrmMsgView = class(TTntFrame)
    Splitter2: TTntSplitter;
    ImageList: TImageList;
    PreviewPanel: TTntPanel;
    MemoMsgBody: TTntRichEdit;
    ImagePanel: TTntPanel;
    Panel2: TTntPanel;
    SelImage: TImage32;
    DetailsPanel: TTntPanel;
    SpeedButton1: TTntSpeedButton;
    Bevel1: TTntBevel;
    Timer1: TTimer;
    FormStorage1: TFormStorage;
    OpenDialog1: TTntOpenDialog;
    Label1: TTntLabel;
    tbCommands: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    ToolButton4: TToolButton;
    sbClearSearch: TTntSpeedButton;
    SearchPanel: TTntPanel;
    Timer2: TTimer;
    ListPanel: TTntPanel;
    NoItemsPanel: TTntPanel;
    ListMsg: TVirtualStringTree;
    Animate1: TAnimate;
    pmListMsg: TTntPopupMenu;
    Newmessage1: TTntMenuItem;
    SendMessage1: TTntMenuItem;
    SendfromPhone1: TTntMenuItem;
    N5: TTntMenuItem;
    Reply1: TTntMenuItem;
    Forward1: TTntMenuItem;
    contactcall1: TTntMenuItem;
    ChatContact1: TTntMenuItem;
    N6: TTntMenuItem;
    Advanced1: TTntMenuItem;
    Search1: TTntMenuItem;
    N10: TTntMenuItem;
    addcontact1: TTntMenuItem;
    AddNewFolder1: TTntMenuItem;
    DeleteFolder1: TTntMenuItem;
    DeliveryRules1: TTntMenuItem;
    N11: TTntMenuItem;
    FixSMSDatabase1: TTntMenuItem;
    MarkAs1: TTntMenuItem;
    MarkasRead1: TTntMenuItem;
    MarkasUnread1: TTntMenuItem;
    N9: TTntMenuItem;
    MarkAllRead1: TTntMenuItem;
    FileAs1: TTntMenuItem;
    MoveToFolder1: TTntMenuItem;
    N3: TTntMenuItem;
    Archive1: TTntMenuItem;
    MovetoArchive1: TTntMenuItem;
    SendTO: TTntMenuItem;
    SendToPhone1: TTntMenuItem;
    SendToSIM1: TTntMenuItem;
    N7: TTntMenuItem;
    DownloadSMS1: TTntMenuItem;
    N15: TTntMenuItem;
    Delete1: TTntMenuItem;
    N1: TTntMenuItem;
    ImportTextMessages1: TTntMenuItem;
    ExportselectedSMS1: TTntMenuItem;
    N2: TTntMenuItem;
    Properties1: TTntMenuItem;
    pmRich: TTntPopupMenu;
    MovetoFolder2: TTntMenuItem;
    N8: TTntMenuItem;
    Copy1: TTntMenuItem;
    N4: TTntMenuItem;
    Picture1: TTntMenuItem;
    Commands1: TTntMenuItem;
    LookupPanel: TTntPanel;
    LookupWhitePanel: TTntPanel;
    Image1: TImage;
    Image2: TImage;
    edSearchFor: TTntEdit;
    pmSearch: TTntPopupMenu;
    sfSenderNumber: TTntMenuItem;
    sfEntireMessage: TTntMenuItem;
    N12: TTntMenuItem;
    SaveSearch1: TTntMenuItem;
    sfDate: TTntMenuItem;
    sfSender: TTntMenuItem;
    sfText: TTntMenuItem;
    SaveSearch2: TTntMenuItem;
    TogglePreviewPane1: TTntMenuItem;
    N13: TTntMenuItem;
    TntLabel1: TTntLabel;
    TntLabel2: TTntLabel;
    lblFiltered: TTntLabel;
    procedure ListMsgBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellRect: TRect);
    procedure ListMsgCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure ListMsgGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure ListMsgGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure ListMsgHeaderClick(Sender: TVTHeader; Column: TColumnIndex;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Properties1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure pmListMsgPopup(Sender: TObject);
    procedure sbCloseSearchClick(Sender: TObject);
    procedure ListMsgKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Splitter2Moved(Sender: TObject);
    procedure ListMsgChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure Timer1Timer(Sender: TObject);
    procedure MarkasReadUnreadClick(Sender: TObject);
    procedure ListMsgDblClick(Sender: TObject);
    procedure SendMessage1Click(Sender: TObject);
    procedure ImportTextMessages1Click(Sender: TObject);
    procedure FormStorage1SavePlacement(Sender: TObject);
    procedure FormStorage1RestorePlacement(Sender: TObject);
    procedure ListMsgHeaderMouseUp(Sender: TVTHeader; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SendToPhone1Click(Sender: TObject);
    procedure SendToSIM1Click(Sender: TObject);
    procedure DownloadSMS1Click(Sender: TObject);
    procedure ListMsgIncrementalSearch(Sender: TBaseVirtualTree;
      Node: PVirtualNode; const SearchText: WideString;
      var Result: Integer);
    procedure Commands1Click(Sender: TObject);
    procedure Picture1Click(Sender: TObject);
    procedure MarkAllRead1Click(Sender: TObject);
    procedure ListMsgClick(Sender: TObject);
    procedure ListMsgPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure edSearchForKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edSearchForKeyPress(Sender: TObject; var Key: Char);
    procedure edSearchForChange(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Search1Click(Sender: TObject);
    procedure SendfromPhone1Click(Sender: TObject);
    procedure ListMsgFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure ListMsgKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FixSMSDatabase1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure edSearchForEnter(Sender: TObject);
    procedure edSearchForExit(Sender: TObject);
    procedure OnSearchTypeChange(Sender: TObject);
    procedure pmSearchPopup(Sender: TObject);
    procedure SaveSearch1Click(Sender: TObject);
    procedure TogglePreviewPane1Click(Sender: TObject);
  private
    FCustomImage,FIsRendered: Boolean;
    FRendered: TStringList;
    FRenderCanceled: boolean;
    FSearchName: WideString;
    FSearchMode: TSearchMode;
    function CanModifyReadStatus: boolean;
    function FlattenText(str: WideString; link: WideString = #32): WideString;
    procedure WriteSMS(Mem: String; StoreAs: Integer = -1);
    procedure Set_CustomImage(const Value: Boolean);
    procedure ResetAutoMarkAsReadTimer;
    procedure UpdatePropertiesStatus;
    procedure DeselectAll;
    procedure DoMarkMessages(AsRead: boolean; SelectedOnly: Boolean = True);
    procedure DoShowDetails(Node: PVirtualNode);
    procedure DoCloseDetails;
    procedure DoShowPreview(Node: PVirtualNode);
    procedure UpdatePreview;
    procedure SetSearchMode(const Value: TSearchMode);
    procedure SetSearchWhat(const Value: WideString);
    procedure SetSearchName(const Value: WideString);
  public
    constructor Create(AOwner: TComponent); override;
    procedure ClearView;
    procedure RenderListView(sl: TStringList);
    procedure ExportList(FileType:Integer; Filename: WideString);

    procedure DeleteSelected(Ask: boolean = True);
    procedure CleanupDatabase(Ask: boolean = True; removeDuplicates: boolean = True);

    procedure GetLongMsgData(Node: PVirtualNode; var ARef, ATot, An: Integer);

    function IsRenderingComplete: boolean;
    function IsRendered(const sl: TStrings): boolean;
    function IsLongSMSNode(ANode: PVirtualNode): boolean;
    function IsLongSMSFirstNode(ANode: PVirtualNode): boolean;
    function GetNodeLongText(ANode: PVirtualNode): WideString;
    function GetNodeLongList(ANode: PVirtualNode; var AList: TTntStringList): boolean;
    function FindSMS(APDU: string): PVirtualNode;

    { Saved Searches }
    procedure SearchForMessages(what: WideString);
    //
    property SearchName: WideString read FSearchName write SetSearchName;
    property SearchMode: TSearchMode read FSearchMode write SetSearchMode;
    property SearchWhat: WideString write SetSearchWhat;

    property IsCustomImage: Boolean read FCustomImage write Set_CustomImage;
    property RenderCanceled: boolean read FRenderCanceled write FRenderCanceled;
  end;

implementation

uses
  gnugettext, gnugettexthelpers, cUnicodeCodecs,
  Unit1, uEditSMS, uLogger, uInputQuery, uThreadSafe, uMissedCalls, uSyncPhonebook,
  uSMS, uGlobal, uComposeSMS, uConnProgress, WebUtil, uDialogs, uImg32Helper;

{$R *.dfm}

{ TfrmMsgView }

function TfrmMsgView.FlattenText(str: WideString; link: WideString): WideString;
var
  sl: TTntStrings;
  i: Integer;
begin
  sl := TTntStringList.Create;
  sl.Text := str;

  for i := 0 to sl.Count - 1 do begin
    Result := Result + link + sl.Strings[i];
  end;
  sl.Destroy;

  Result := Trim(Result);
end;

procedure TfrmMsgView.ListMsgBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellRect: TRect);
var
  item: PListData;
begin
  item := Sender.GetNodeData(Node);

  if Assigned(item) and Assigned(item.smsData) then
  try
    if Column = 0 then begin
      if item.smsData.IsOutgoing then
        TargetCanvas.Brush.Color := $00E0E0FF  // from column (out)
      else
        TargetCanvas.Brush.Color := $00FFE0E0; // from column (in)
      TargetCanvas.FillRect(CellRect);
    end
    else if (item.smsData.IsLong) and (item.smsData.IsLongFirst) then begin
      TargetCanvas.Brush.Color := $CAFFFF; // long sms
      TargetCanvas.FillRect(CellRect);
    end
    else if (item.smsData.IsLong) and (not item.smsData.IsLongFirst) then begin
      TargetCanvas.Brush.Color := $CCCCCC; // this is obsolete - these nodes are hided
      TargetCanvas.FillRect(CellRect);
    end;
  except
    item.smsData := nil;
  end;
end;

procedure TfrmMsgView.ListMsgCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  item1, item2: PListData;
begin
  item1 := Sender.GetNodeData(Node1);
  item2 := Sender.GetNodeData(Node2);

  if Column = 0 then Result := CompareStr(item1.from, item2.from)
  else if Column = 1 then Result := WideCompareStr(item1.smsData.Text, item2.smsData.Text)
  else if Column = 3 then Result := CompareDateTime(item1.smsData.TimeStamp, item2.smsData.TimeStamp);
end;

procedure TfrmMsgView.ListMsgGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  item: PListData;
begin
  case Column of
  0:begin
      if (Kind = ikNormal) or (Kind = ikSelected) then begin
        item := Sender.GetNodeData(Node);
        ImageIndex := item.imageindex;
      end
      else ImageIndex := -1;
    end;
  2:begin
      if (Kind = ikNormal) or (Kind = ikSelected) then begin
        item := Sender.GetNodeData(Node);
        try
          if item.smsData.IsNew then
            ImageIndex := 21
          else
            ImageIndex := 20;
        except
        end;
      end
      else ImageIndex := -1;
    end;
  end;
end;

procedure TfrmMsgView.ListMsgGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  item: PListData;
begin
  item := Sender.GetNodeData(Node);

  if Column = 0 then CellText := item.from
  else
  if Column = 1 then begin
    try
      if Assigned(item.smsData) then begin
        CellText := FlattenText(item.smsData.Text);
        if IsLongSMSNode(Node) then CellText := CellText + ' (...)'; // do not localize
      end;
    except
      item.smsData := nil;
    end;
    {
    if IsLongSMSNode(Node) then
      CellText := FlattenText(GetNodeLongText(node))
    else
      CellText := FlattenText(item.msg);
    }
  end
  else
  if Column = 2 then CellText := #32 // span columns doesnt take effect
  else
  if Column = 3 then begin
    try
      if (Assigned(item.smsData) and (item.smsData.TimeStamp > 0)) then begin
        if isToday(item.smsData.TimeStamp) then CellText := TimeToStr(item.smsData.TimeStamp)
        else CellText := DateTimeToStr(item.smsData.TimeStamp)
      end
      else CellText := _('(not available)');
    except
      item.smsData := nil;
    end;
  end;
end;

procedure TfrmMsgView.ListMsgHeaderClick(Sender: TVTHeader;
  Column: TColumnIndex; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if Column = Sender.SortColumn then begin
    if Sender.SortDirection = sdDescending then
      Sender.SortDirection := sdAscending
    else
      Sender.SortDirection := sdDescending;
  end
  else
    Sender.SortColumn := Column;
end;

procedure TfrmMsgView.RenderListView(sl: TStringList);
const
  Sem: boolean = False;
var
  i,j: Integer;
  isNumber: boolean;
  item: PListData;
  Node: PVirtualNode;
  dbfixed: boolean;
  md: TFmaMessageData;
  test: DWord;
  procedure FindMatchingDeliveryReport(sd: TFmaMessageData);
  var
    i,num: integer;
    b: byte;
    sr: TSMSStatusReport;
  begin
    b := StrToIntDef('$'+sd.MessageRef,0);
    num := Form1.FReportLookupList[b];
    if (num > 0) and (b > 0) then begin // skip messages with reference 0
      for i:=0 to Form1.FStatusReportList.Count-1 do begin
        sr := TSMSStatusReport(Form1.FStatusReportList.Objects[i]);
        if Assigned(sr) then begin
          if sr.MessageReference = sd.MessageRef then begin
            Dec(Num);
            if sr.Number = sd.From then begin
              // this is really it!
              Log.AddMessageFmt('DB: Found matching Status Report! [Index %d]', [i]);
              Dec(Form1.FReportLookupList[b]);
              sd.ReportPDU := sr.PDU;
              // dispose object
              sr.Free;
              Form1.FStatusReportList.Delete(i);
              Break;
            end;
          end;
        end;
        if num <= 0 then break; // it can't be here now
      end;
    end;
  end;
begin
  if Sem then exit;
  Sem := True;

  { Clear view }
  DoCloseDetails;
  dbfixed := False;
  SearchName := '';
  SearchMode := smAll;
  edSearchFor.Text := '';
  edSearchForExit(nil);
  FIsRendered := False;
  lblFiltered.Visible := False;

  { Fill list }
  try
    if sl.Count <> 0 then NoItemsPanel.Visible := False;
    if sl.Count > 99 then begin // show a message to user on large folder
      Form1.Status(_('Building messages list, please wait...'),False);
      Animate1.Top := ListMsg.Top + (ListMsg.Height - Animate1.Height) div 2 + 32;
      Animate1.Color := ColorToRGB(clWindow);
      Animate1.Visible := ListMsg.Height > 128;
      Animate1.Active := Animate1.Visible;
      if Animate1.Visible then NoItemsPanel.Visible := False;
    end;

    { Clear view }
    MemoMsgBody.Clear;//ADD
    FCustomImage := True; //Force image reload
    IsCustomImage := False;
    ListMsg.BeginUpdate;
    ListMsg.Clear;
    ListMsg.EndUpdate;
    Update;

    { Build message list }
    ListMsg.BeginUpdate;
    try
      ListMsg.NodeDataSize := sizeof(TListData);
      { process DB }
      if sl <> FRendered then
        FRendered := nil;
      FRenderCanceled := False;

      i := 0;
      test := GetTickCount;
      while i < sl.Count do begin
        if FRenderCanceled then break;
        md := TFmaMessageData(sl.Objects[i]);
        if md = nil then begin
          Inc(i);
          continue;
        end;
        Node := ListMsg.AddChild(nil);
        try
          item := ListMsg.GetNodeData(Node);
          item.smsData := md;

          // DONE: check if smsData.From is number (can be alpha string)
          isNumber := item.smsData.From = '';
          for j:=1 to Length(item.smsData.From) do
            if IsDelimiter('+0123456789', item.smsData.From, j) then begin
              isNumber := True;
              break;
            end;
          if isNumber then
            item.from := Form1.ContactNumberByTel(item.smsData.From)
          else
            item.from := item.smsData.From;
          item.sender := Form1.ExtractContact(item.from);

          item.stateindex := md.MsgIndex and $FFFF; // index

          if Ord(md.Location) = 1 then begin // ME
            item.ImageIndex := 14;
            item.StateIndex := item.StateIndex or $600000; // set to 0 shl 16
          end
          else if Ord(md.Location) = 2 then begin // SM
            item.ImageIndex := 15;
            item.StateIndex := item.StateIndex or $640000; // set to 4 shl 16
          end
          else {3} begin // PC
            if md.IsOutgoing then item.ImageIndex := 17
            else item.ImageIndex := 16;
            item.StateIndex := item.StateIndex or $680000; // set to 8 shl 16
          end;

          // Direction Bit
          if md.IsOutgoing then begin
            item.StateIndex := item.StateIndex or $020000;
            if md.ReportPDU = '' then
              FindMatchingDeliveryReport(md);
          end
          else item.StateIndex := item.StateIndex or $010000;

          // Long SMS? - show only first SMS message
          if (md.IsLong) and (not md.IsLongFirst) then begin
            ListMsg.IsVisible[Node] := False;
            if md.IsNew then begin
              { Don't set non-first Long SMS part as new flag }
              md.IsNew := False;
              if FindCmdLineSwitch('FIXDB') then begin
                md.IsNew := False;
                Log.AddMessageFmt(_('Database: Removed new message flag (DB Index: %d)'), [i], lsInformation);
                dbfixed := True;
              end;
            end;
          end;

          if i mod 8 = 0 then begin
            Application.ProcessMessages;
            if Application.Terminated then break;
          end;
        except
          ListMsg.DeleteNode(Node);
          Log.AddMessageFmt(_('Database: Error loading data (DB Index %d)'), [i], lsError);
          if FindCmdLineSwitch('FIXDB') then begin
            sl[i] := '';
            Log.AddMessageFmt(_('Database: Removed incorrect data (DB Index: %d)'), [i], lsInformation);
            dbfixed := True;
          end;
        end;
        Inc(i);
      end;
      FRendered := sl;
      Log.AddMessageFmt('Rendering messages took: %d ms', [GetTickCount - test], lsDebug);
    finally
      Animate1.Visible := False;
      Animate1.Active := False;
      ListMsg.Sort(nil, ListMsg.Header.SortColumn, ListMsg.Header.SortDirection);
      ListMsg.EndUpdate;
      UpdatePropertiesStatus;
      i := 0;
      Node := ListMsg.GetFirstVisible;
        while Assigned(Node) do begin
          Inc(i);
          Node := ListMsg.GetNextVisible(Node);
        end;
      Form1.Status(WideFormat(_('%d %s'),[i,ngettext('message','messages',i)]),False);
    end;
  finally
    Sem := False;
    NoItemsPanel.Visible := ListMsg.ChildCount[nil] = 0;
    if dbfixed then
      Form1.UpdateNewMessagesCounter(Form1.ExplorerNew.FocusedNode);
    FIsRendered := True;
  end;
end;

procedure TfrmMsgView.DoShowDetails(Node: PVirtualNode);
var
  curr: PVirtualNode;
  item: PListData;
  sms: TSMS;
  sl: TTntStringList;
  i: Integer;
begin
  if Assigned(Node) then begin
    item := ListMsg.GetNodeData(node);
    if item <> nil then begin
      { Create details dialog if needed }
      if not Assigned(frmDetail) then frmDetail := TfrmDetail.Create(Self);

      frmDetail.SMS := item.smsData;

      if item.StateIndex and $C0000 = 0 then // ME
        frmDetail.edLocation.Text := _('FMA and Phone')
      else
      if item.StateIndex and $C0000 = $40000 then // SM
        frmDetail.edLocation.Text := _('FMA and SIM card')
      else
      {if item.StateIndex and $C0000 = $80000 then} // PC
        frmDetail.edLocation.Text := _('FMA only');

      if IsLongSMSNode(node) then begin
        { Add full long SMS text, since it can't be obtained from PDU }
        frmDetail.memoText.Text := GetNodeLongText(node);
        sl := TTntStringList.Create;
        sms := TSMS.Create;
        try
          { Refill PDU memo with all Long SMS PDUs }
          frmDetail.memoPDU.Clear;
          GetNodeLongList(node,sl);
          for i := 0 to sl.Count-1 do begin
            frmDetail.memoPDU.Lines.Add(WideFormat(_('SMS Number: %d'),[i+1]));

            curr := PVirtualNode(sl.Objects[i]);
            if Assigned(curr) then begin
              item := ListMsg.GetNodeData(curr);
              sms.PDU := item.smsData.PDU;

              if sms.IsOutgoing then
                frmDetail.memoPDU.Lines.Add(WideFormat(_('Message Type: %s'),
                  ['SMS SUBMIT'])) // do not localize
              else
                frmDetail.memoPDU.Lines.Add(WideFormat(_('Message Type: %s'),
                  ['SMS DELIVER'])); // do not localize
              frmDetail.memoPDU.Lines.Add(sLineBreak + item.smsData.PDU + sLineBreak);
            end
            else
              frmDetail.memoPDU.Lines.Add(sLineBreak + _('Message part is missing.') + sLineBreak);
          end;
        finally
          sms.Free;
          sl.Free;
        end;
      end;
      frmDetail.Show;
    end;
  end;
end;

procedure TfrmMsgView.Properties1Click(Sender: TObject);
var
  Node :PVirtualNode;
begin
  if Form1.ExplorerNew.FocusedNode = Form1.FNodeMsgDrafts then
    exit;
  Node := ListMsg.FocusedNode;
  if Assigned(Node) then begin
    Timer1.Enabled := False;
    Timer1.Interval := 100;
    Timer1.Enabled := True;
    DoShowDetails(Node);
  end;
end;

procedure TfrmMsgView.ExportList(FileType:Integer; Filename: WideString);
var
  node: PVirtualNode;
  item: PListData;
  sl: TStringList;
  wl: TTntStringList;
  t: WideString;
  s,ss,str: String;
  i: Integer;
begin
  if FileType <> 1 then begin
    if MessageDlgW(_('FMA could Import only CSV message exports. Do you still want to continue exporting?'),
      mtConfirmation, MB_YESNO or MB_DEFBUTTON2) <> ID_YES then
      exit;
  end;
  case FileType of
    1:begin//CSV
        sl := TStringList.Create;
        try
          { Write export header }
          ss := '"Subject","Body","From: (Name)","From: (Address)","From: (Type)",'+ // do not localize
                '"To: (Name)","To: (Address)","To: (Type)",'+ // do not localize
                '"Fma Date","Fma State","Fma PDU","Fma IsNew"'; // do not localize
          sl.add(ss);
          with ListMsg do begin
            node := GetFirst;
            repeat
               try
                 if Selected[node] then begin
                   { Skip Long SMS entries except for the first one }
                   item := GetNodeData(node);
                   if (item.smsData.IsLong) and (not item.smsData.IsLongFirst) then begin
                     node := GetNext(node);
                     Continue;
                   end;
                   wl := TTntStringList.Create;
                   try
                     { Break long SMS into several parts in order to keep original PDU-s.
                       If it's regular SMS, then emulate a Long one with one member (PDU) }
                     if not item.smsData.IsLong then
                       wl.AddObject(item.smsData.Text,Pointer(node))
                     else
                       if not GetNodeLongList(node,wl) then begin
                         node := GetNext(node);
                         continue; // skip missing parts messages
                       end;

                     for i := 0 to wl.Count-1 do begin
                       item := GetNodeData(PVirtualNode(wl.Objects[i]));
                       { NOTE: every item should be quoted!!! Import depends on it }
                       ss := '"SMS","' + WideStringToUTF8String(Tnt_WideStringReplace(item.smsData.Text, '"', '""', [rfReplaceAll])) + '",'; // do not localize
                       s := item.smsData.From;
                       t := Form1.ExtractContact(item.from);
                       if item.StateIndex and $20000 <> 0 then begin // outgoing message
                         ss := ss + '"(Outgoing)","' + WideStringToUTF8String(item.from) + '","PHONE",';  // do not localize
                         ss := ss + '"' + WideStringToUTF8String(t) + '","' + s + '","PHONE",';  // do not localize
                       end
                       else begin
                         ss := ss + '"' + WideStringToUTF8String(t) + '","' + s + '","PHONE",';  // do not localize
                         ss := ss + '"(Incoming)","' + WideStringToUTF8String(item.from) + '","PHONE",';  // do not localize
                       end;
                       if item.smsData.TimeStamp > 0 then ss := ss + '"' + DateTimeToStr(item.smsData.TimeStamp) + '",'
                         else ss := ss + '"",';
                       ss := ss + '"' + IntToStr(item.stateindex) + '","' + item.smsData.PDU + '","' + IntToStr(byte(item.smsData.IsNew)) + '"';
                       sl.add(ss);
                     end;
                   finally
                     wl.Free;
                   end;
                 end;
               except
               end;
               node := GetNext(node);
            until node = nil;
          end;
          { Write export body }
          sl.SaveToFile(FileName);
        finally
          sl.Free;
        end;
       end;
    2:begin//XML
        sl := TStringList.Create;
        try
        sl.Add('<?xml version="1.0" encoding="utf-8" ?>'); // do not localize
        sl.Add('<fma_messages>'); // do not localize
        with ListMsg do begin
          node := GetFirst;
          repeat
             try
               if Selected[node] then begin
                 { Skip Long SMS entries except for the first one }
                 item := GetNodeData(node);
                 if (item.smsData.IsLong) and (not item.smsData.IsLongFirst) then begin
                  node := GetNext(node);
                  Continue;
                 end;
                 str := '<sms>'; // do not localize
                 str := str + '<from>' + HTMLEncode(WideStringToUTF8String(item.from),False) + '</from>'; // do not localize
                 if item.smsData.IsLong then
                   str := str + '<msg>' + HTMLEncode(WideStringToUTF8String(GetNodeLongText(Node)),False) + '</msg>' // do not localize
                 else
                   str := str + '<msg>' + HTMLEncode(WideStringToUTF8String(item.smsData.Text),False) + '</msg>'; // do not localize
                 if item.smsData.TimeStamp > 0 then
                   str := str + '<date>' + HTMLEncode(DateTimeToStr(item.smsData.TimeStamp),False) + '</date>' // do not localize
                 else
                   str := str + '<date/>'; // do not localize
                 str := str + '</sms>'; // do not localize
                 sl.add(str);
               end;
             except
             end;
             node := GetNext(node);
          until node = nil;
        end;
        sl.Add('</fma_messages>'); // do not localize
        sl.SaveToFile(FileName);
        finally
          sl.Free;
        end;
      end;
    3:begin//HTML
        sl := TStringList.Create;
        try
        sl.Add('<html><head><meta content="text/html;charset=utf-8" http-equiv="content-type">'); // do not localize
        sl.Add('<title>FMA Messages</title></head><body>'); // do not localize
        sl.Add('<TABLE BORDER="1">'); // do not localize
        sl.Add('<TR><TD>FROM</TD><TD>BODY</TD><TD>DATE</TD></TR>'); // do not localize
        with ListMsg do begin
          node := GetFirst;
          repeat
            try
              if Selected[node] then begin
                 { Skip Long SMS entries except for the first one }
                 item := GetNodeData(node);
                 if (item.smsData.IsLong) and (not item.smsData.IsLongFirst) then begin
                   node := GetNext(node);
                   Continue;
                 end;
                 str := '<TR>'; // do not localize
                 str := str + '<TD>' + HTMLEncode(WideStringToUTF8String(item.from),False) + '</TD>'; // do not localize
                 if item.smsData.IsLong then
                   str := str + '<TD>' + HTMLEncode(WideStringToUTF8String(GetNodeLongText(Node)),False) + '</TD>' // do not localize
                 else
                   str := str + '<TD>' + HTMLEncode(WideStringToUTF8String(item.smsData.Text),False) + '</TD>'; // do not localize
                 if item.smsData.TimeStamp > 0 then
                   str := str + '<TD>' + HTMLEncode(DateTimeToStr(item.smsData.TimeStamp),False) + '</TD>' // do not localize
                 else
                   str := str + '<TD></TD>'; // do not localize
                 str := str + '</TR>'; // do not localize
                 sl.add(str);
              end;
            except
            end;
            node := GetNext(node);
          until node = nil;
        end;
        sl.Add('</TABLE>'); // do not localize
        sl.Add('</body></html>'); // do not localize
        sl.SaveToFile(FileName);
        finally
          sl.Free;
        end;
      end;
  end;
end;

procedure TfrmMsgView.Copy1Click(Sender: TObject);
begin
  memomsgbody.CopyToClipboard;
end;

procedure TfrmMsgView.WriteSMS(Mem: String; StoreAs: Integer);
var
  State: Integer;
  node,prev: PVirtualNode;
  EData: PFmaExplorerNode;
  item: PListData;
  sl: TStringList;
  wl: TTntStringList;
  j: Integer;
  UpdateIncoming,UpdateOutgoing: boolean;
  procedure DelNodeFromDBandView;
  var
    index: Integer;
  begin
    index := sl.IndexOfObject(item.smsData);
    if index <> -1 then begin
      item.smsData := nil;
      TFmaMessageData(sl.Objects[index]).Free;
      sl.Delete(index);
      if prev = ListMsg.FocusedNode then begin
        MemoMsgBody.Clear;
        IsCustomImage := False;
      end;
      ListMsg.DeleteNode(prev);
    end;
  end;
begin
  { By default message status will be set to 'Received unread' (StoreAs = -1) }
  UpdateIncoming := False;
  UpdateOutgoing := False;
  ListMsg.BeginUpdate;
  try
    EData := Form1.ExplorerNew.GetNodeData(Form1.ExplorerNew.FocusedNode);
    sl := TStringList(EData.Data);
    with ListMsg do begin
      node := GetFirst;
      while node <> nil do begin
        prev := nil;
        if Selected[node] then begin
          { Skip Long SMS entries except for the first one }
          item := GetNodeData(node);
          if (item.smsData.IsLong) and (not item.smsData.IsLongFirst) then begin
            node := GetNext(node);
            Continue;
          end;
          wl := TTntStringList.Create;
          try
            { Break long SMS into several parts in order to keep original PDU-s.
              If it's regular SMS, then emulate a Long one with one member (PDU) }
            if not item.smsData.IsLong then
              wl.AddObject(item.smsData.Text,Pointer(node))
            else
              if not GetNodeLongList(node,wl) then begin
                node := GetNext(node);
                continue; // skip missing parts messages
              end;

            { Send all message parts to phone }
            for j := 0 to wl.Count-1 do begin
              item := GetNodeData(PVirtualNode(wl.Objects[j]));
              State := StoreAs;
              if State = -1 then begin
                { State description:
                  0 Received unread (new) message - Default setting
                  1 Received read message
                  2 Stored unsent message (only applicable to SMs)
                  3 Stored sent message (only applicable to SMs) }
                if item.StateIndex and $10000 <> 0 then // incoming message
                  State := 1
                else
                if item.StateIndex and $20000 <> 0 then // outgoing message
                  State := 3;
              end;
              if State = -1 then State := 0;
              { Upload to phone }
              if Form1.WriteSMS(Mem, item.smsData.PDU, State) then
                case State of
                  0,1: UpdateIncoming := True;
                  2,3: UpdateOutgoing := True;
                end
              else
                raise EInOutError.Create(_('Could not send message to phone (storage full?)'));
            end;

            { Delete message parts from database if its not first part which will be deleted below. }
            for j := 0 to wl.Count-1 do begin
              prev := PVirtualNode(wl.Objects[j]);
              item := GetNodeData(prev);
              if prev <> node then DelNodeFromDBandView;
            end;
          finally
            wl.Free;
          end;
          { Mark node for deletion }
          prev := node;
        end;
        node := GetNext(node);
        if Assigned(prev) then begin
          item := GetNodeData(prev);
          DelNodeFromDBandView;
          ListMsg.Repaint;
        end;
      end;
    end;
  finally
    ListMsg.EndUpdate;
    Form1.UpdateNewMessagesCounter(Form1.ExplorerNew.FocusedNode);
  end;

  { Refresh Phone Text Folders as needed }
  if UpdateIncoming then
    if UpdateOutgoing then
      Form1.DownloadAllMessages
    else
      Form1.DownloadMessages(Form1.FNodeMsgInbox)
  else
    if UpdateOutgoing then
      Form1.DownloadMessages(Form1.FNodeMsgSent);
end;

procedure TfrmMsgView.pmListMsgPopup(Sender: TObject);
var
  node: PVirtualNode;
  data: PFmaExplorerNode;
  item: PListData;
  HasRead,HasUnread: boolean;
begin
  { check Read/Unread status }
  HasRead := False;
  HasUnread := False;
  if CanModifyReadStatus and (ListMsg.SelectedCount <> 0) then begin
    node := ListMsg.GetFirst;
    Repeat
      if ListMsg.Selected[node] then begin
        item := ListMsg.GetNodeData(node);
        if item.smsData.IsNew then HasUnread := True else HasRead := True;
        if HasRead and HasUnread then break;
      end;
      node := ListMsg.GetNext(node);
    Until node = nil;
  end;
  { Check other options }
  SendMessage1.Visible := Form1.ExplorerNew.FocusedNode = Form1.FNodeMsgDrafts;
  SendMessage1.Enabled := ListMsg.SelectedCount = 1;
  Newmessage1.Visible := not SendMessage1.Visible;
  MarkasRead1.Enabled := HasUnread;
  MarkasUnread1.Enabled := HasRead;
  MarkAllRead1.Enabled := CanModifyReadStatus;
  DownloadSMS1.Enabled := (not Form1.FConnected or not Form1.FObex.Connected) and
    ((Form1.ExplorerNew.FocusedNode = Form1.FNodeMsgInbox) or (Form1.ExplorerNew.FocusedNode = Form1.FNodeMsgSent));
  data := Form1.ExplorerNew.GetNodeData(Form1.ExplorerNew.FocusedNode);
  SendToPhone1.Enabled := not SendMessage1.Visible and Form1.FConnected and not Form1.FObex.Connected and
    ((Form1.ExplorerNew.FocusedNode = Form1.FNodeMsgArchive) or (data.StateIndex = FmaSMSSubFolderFlag));
  SendToSIM1.Enabled := SendToPhone1.Enabled;
  SendfromPhone1.Visible := SendMessage1.Visible;
  SendfromPhone1.Enabled := (ListMsg.SelectedCount >= 1) and Form1.FConnected and not Form1.FObex.Connected;
  SaveSearch2.Enabled := (edSearchFor.Text <> '') and edSearchFor.ParentFont;
  UpdatePropertiesStatus;
end;

procedure TfrmMsgView.DeleteSelected(Ask: boolean = True);
var
  i,j,index: Integer;
  s,memType: String;
  node,prev: PVirtualNode;
  data: PFmaExplorerNode;
  item: PListData;
  sl: TStringList;
  wl : TTntStringList;
  procedure DelNodeFromView;
  begin
    { If deleteing current node, clear personalization and msg preview too }
    if prev = ListMsg.FocusedNode then begin
      MemoMsgBody.Clear;
      IsCustomImage := False;
    end;
    ListMsg.DeleteNode(prev);
  end;
begin
  if ListMsg.SelectedCount = 0 then exit;
  s := WideFormat(_('Deleting %d %s.'), [ListMsg.SelectedCount,ngettext('message','messages',ListMsg.SelectedCount)]);
  if Ask and (MessageDlgW(s+_(' Do you wish to continue?'), mtConfirmation, MB_YESNO or MB_DEFBUTTON2) <> ID_YES) then
    exit;
  Form1.Status(s+'..');
  Update;
  frmConnect := GetProgressDialog;
  try
    if Ask and Form1.CanShowProgress and (ListMsg.SelectedCount > 1) then
      frmConnect.ShowProgress(Form1.FProgressLongOnly);
    frmConnect.Initialize(ListMsg.SelectedCount,s);
    Form1.Enabled := False; // prevent keyboard move up/down in list while deleteing
    ListMsg.BeginUpdate;
    try
      data := Form1.ExplorerNew.GetNodeData(Form1.ExplorerNew.FocusedNode);
      sl := TStringList(data.Data);
      node := ListMsg.GetLast;
      while node <> nil do begin
        prev := nil;
        if ListMsg.Selected[node] then begin
          { Skip Long SMS entries except for the first one }
          item := ListMsg.GetNodeData(node);
          if (not item.smsData.IsLong) or (item.smsData.IsLongFirst) then begin
            wl := TTntStringList.Create;
            try
              { Break long SMS into several parts in order to keep original PDU-s.
                If it's regular SMS, then emulate a Long one with one member (PDU) }
              if not item.smsData.IsLong then
                wl.AddObject(item.smsData.Text,Pointer(node))
              else
                GetNodeLongList(node,wl);

              { Delete all parts of the message }
              for j := 0 to wl.Count-1 do begin
                prev := PVirtualNode(wl.Objects[j]);
                if Assigned(prev) then begin
                  item := ListMsg.GetNodeData(prev);
                  index := item.StateIndex and $FFFF;

                  if item.StateIndex and $C0000 = 0 then // ME
                    memType := 'ME' // do not localize
                  else
                  if item.StateIndex and $C0000 = $40000 then // SM
                    memType := 'SM' // do not localize
                  else
                  {if item.StateIndex and $C0000 = $80000 then} // PC
                    memType := '';

                  { If deleteing from Outbox, notify and enable Chat window }
                  if Form1.ExplorerNew.FocusedNode = Form1.FNodeMsgOutbox then
                    Form1.ChatNotifyDel(item.smsData.PDU);

                  { Remove message from database }
                  i := sl.IndexOfObject(item.smsData);
                  if i <> -1 then begin
                    if memType <> '' then begin { in phone? }
                      Form1.AskRequestConnection;
                      try
                        Form1.DeleteSMS(index, memType, item.smsData.PDU);
                      except
                        { silently ignore delete failure - it means message is not in phone anyway }
                      end;
                    end;
                    (item.smsData).Free;
                    item.smsData := nil;
                    sl.Delete(i);
                    { Delete message part from database if its not the first one.
                      The first part will be deleted below in DelNodeFromView call. }
                    if prev <> node then DelNodeFromView;
                  end
                  else begin // this should never happen
                    RenderListView(sl);
                    Exit;
                  end;
                end;
              end;
            finally
              wl.Free;
            end;
            { Update progress }
            frmConnect.IncProgress(1);
            prev := node; // prev is used in DelNode
          end;
        end;
        node := ListMsg.GetPrevious(node);
        if Assigned(prev) then begin
          DelNodeFromView;
          if Ask then ListMsg.Repaint;
        end;
      end;
    finally
      ListMsg.EndUpdate;
      NoItemsPanel.Visible := ListMsg.ChildCount[nil] = 0;
      Form1.Enabled := True;
      Form1.UpdateNewMessagesCounter(Form1.ExplorerNew.FocusedNode);
    end;
  finally
    FreeProgressDialog;
  end;
  Form1.Status('');
end;

procedure TfrmMsgView.sbCloseSearchClick(Sender: TObject);
begin
  edSearchFor.Text := '';
  ListMsg.SetFocus;
  SearchPanel.Visible := False;
end;

procedure TfrmMsgView.ListMsgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (ListMsg.SelectedCount = 1) then
    ListMsgDblClick(ListMsg);
end;

procedure TfrmMsgView.Splitter2Moved(Sender: TObject);
begin
 if PreviewPanel.Height < Splitter2.MinSize then PreviewPanel.Height := Splitter2.MinSize;
end;

procedure TfrmMsgView.ListMsgChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  ResetAutoMarkAsReadTimer;
  UpdatePropertiesStatus;
  // we need to update actions (for drag&drop)
  Form1.ActionSMSToFolder.Update;
  pmListMsgPopup(nil);
end;

procedure TfrmMsgView.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  Timer1.Interval := 4000;
  if ListMsg.SelectedCount <> 0 then
    MarkasReadUnreadClick(MarkasRead1);
end;

procedure TfrmMsgView.MarkasReadUnreadClick(Sender: TObject);
begin
  DoMarkMessages(TTntMenuItem(Sender).Tag <> 0);
end;

procedure TfrmMsgView.ListMsgDblClick(Sender: TObject);
begin
  if Form1.ExplorerNew.FocusedNode = Form1.FNodeMsgDrafts then
    SendMessage1Click(nil)
  else
    Properties1Click(nil);
end;

procedure TfrmMsgView.SendMessage1Click(Sender: TObject);
var
  node: PVirtualNode;
  item: PListData;
begin
  if ListMsg.SelectedCount = 1 then begin
    node := ListMsg.GetFirstSelected;
    repeat
      if ListMsg.Selected[node] then begin
        item := ListMsg.GetNodeData(node);
        Form1.ActionSMSNewMsg.Execute;
        frmMessageContact.AddRecipient(item.from);
        frmMessageContact.Memo.Text := '';
        if IsLongSMSNode(node) then begin
          if not frmMessageContact.btnLongSMS.Down then begin
            frmMessageContact.btnLongSMS.Down := True;
            frmMessageContact.btnLongSMS.Click;
          end;
          frmMessageContact.Memo.SelText := GetNodeLongText(node);
        end
        else
          frmMessageContact.Memo.SelText := item.smsData.Text;
        frmMessageContact.Memo.SelStart := Length(frmMessageContact.Memo.Text);
        frmMessageContact.Memo.SetFocus;
        { Message is already in Drafts, so mark new message as not modified }
        frmMessageContact.btnSave.Enabled := False;
        break;
      end;
      node := ListMsg.GetNext(node);
    until node = nil;
    ListMsg.Update;
  end;
end;

procedure TfrmMsgView.ImportTextMessages1Click(Sender: TObject);
var
  ImpList: TStringList;
  sl,dl: TStringList;
  data: PFmaExplorerNode;
  md: TFmaMessageData;
  t,p,str: String;
  i,j,Added,iBody,iDate,iState,iPDU,iNew: integer;
  function IsMultilineBody(s: String): boolean;
  var
    i,j,l: integer;
  begin
    j := 0;
    l := Length(s);
    for i := 1 to l do
      if s[i] = '"' then inc(j);
    { Quotes not closed or not all columns present? }
    Result := (j mod 2 <> 0) or ((l <> 0) and (s[l] = ','));
  end;
  function PDUExists(aPDU: string): boolean;
  var
    i: integer;
    sPDU: string;
  begin
    Result := False;
    if sl.IndexOf(aPDU) <> -1 then
      Result := True;
    {
    for i := 0 to sl.Count-1 do begin
      sPDU := GetToken(sl[i], 5);
      if AnsiCompareStr(aPDU,sPDU) = 0 then begin
        Result := True;
        break;
      end;
    end;
    }
    for i := 0 to dl.Count-1 do begin
      sPDU := GetToken(dl[i], 5);
      if AnsiCompareStr(aPDU,sPDU) = 0 then begin
        Result := True;
        break;
      end;
    end;
  end;
begin
  if (Form1.ExplorerNew.FocusedNode = nil) or not OpenDialog1.Execute then exit;
  data := Form1.ExplorerNew.GetNodeData(Form1.ExplorerNew.FocusedNode);
  sl := TStringList(data.Data);
  Added := 0;
  ImpList := TStringList.Create;
  dl := TStringList.Create;
  try
    ImpList.LoadFromFile(OpenDialog1.FileName);
    if ImpList.Count <= 1 then raise Exception.Create(_('Nothing to import'));

    Form1.Status(_('Importing messages...'));

    iBody := 0; iDate := 0; iState := 0; iPDU := 0; iNew := 0;
    i := 0; str := '';
    while i < ImpList.Count do begin
      if Trim(ImpList[i]) <> '' then begin
        str := str + ImpList[i];
        if not IsMultilineBody(str) then begin
          if iBody = 0 then begin // find fields mapping
            for j := 0 to GetTokenCount(str)-1 do begin
              { Check ExportList() for details about header info:
                "Subject","Body","From: (Name)","From: (Address)","From: (Type)","To: (Name)","To: (Address)","To: (Type)",
                "Fma Date","Fma State","Fma PDU","Fma New" }
              t := GetToken(str,j);
              if AnsiCompareText(t,'Body') = 0 then iBody := j; // do not localize
              if AnsiCompareText(t,'Fma Date') = 0 then iDate := j; // do not localize
              if AnsiCompareText(t,'Fma State') = 0 then iState := j; // do not localize
              if AnsiCompareText(t,'Fma PDU') = 0 then iPDU := j; // do not localize
              if AnsiCompareText(t,'Fma IsNew') = 0 then iNew := j; // do not localize
            end;
            if (iBody = 0) or (iDate = 0) or (iState = 0) or (iPDU = 0) or (iNew = 0) then begin
              MessageDlgW(_('Incorrect import file header!'),mtError,MB_OK);
              Abort;
            end;
          end
          else begin
            t := '3,' + IntToStr(sl.Count + dl.Count + 1);
            if StrToInt(GetToken(str,iState)) and $2000 <> 0 then // outgoing message
              t := t + ',3,,,'
            else
              t := t + ',1,,,';
            p := GetToken(str,iPDU);
            t := t + p + ',"' + GetToken(str,iDate) + '",' + GetToken(str,iNew);
            if Form1.FArchiveDublicates or not PDUExists(p) then begin
              dl.Add(t);
              inc(Added);
            end;
          end;
          str := '';
        end;
      end;
      inc(i);
    end;
    if Added <> 0 then begin
      { Add changes at once }
      for i:=0 to dl.Count-1 do begin
        md := TFmaMessageData.Create(dl[i]);
        sl.AddObject(md.PDU, md);
      end;
      Form1.UpdateNewMessagesCounter(Form1.ExplorerNew.FocusedNode);
      RenderListView(sl);
      Log.AddSynchronizationMessage('Imported '+IntToStr(Added)+' item(s)...'); // do not localize debug
    end;
  finally
    ImpList.Free;
    dl.Free;
  end;
  Form1.Status(_('Import complete.'));
end;

procedure TfrmMsgView.Set_CustomImage(const Value: Boolean);
begin
  if not Value and (FCustomImage <> Value) then
    SelImage.Bitmap.Assign(Form1.CommonBitmaps.Bitmap[0]);
  FCustomImage := Value;
end;

procedure TfrmMsgView.GetLongMsgData(Node: PVirtualNode; var ARef, ATot, An: Integer);
var
  item: PListData;
begin
  ARef := -1; ATot := -1; An := -1;
  if Assigned(Node) then begin
    item := ListMsg.GetNodeData(Node);
    if Assigned(item) then begin
      ARef := item.smsData.Reference;
      ATot := item.smsData.Total;
      An := item.smsData.MsgNum;
    end;
  end;
end;

function TfrmMsgView.GetNodeLongText(ANode: PVirtualNode): WideString;
var
  sl: TTntStringList;
  i: integer;
  w: WideString;
begin
  sl := TTntStringList.Create;
  try
    if Assigned(ANode) then
      GetNodeLongList(ANode,sl);
    w := '';
    for i := 0 to sl.Count-1 do
      w := w + sl[i];
    Result := w;
  finally
    sl.Free;
  end;
end;

function TfrmMsgView.GetNodeLongList(ANode: PVirtualNode;
  var AList: TTntStringList): boolean;
var
  Ref, ARef, Tot, ATot, An, FoundCount: Integer;
  Node: PVirtualNode;
  Up, Down: Integer;
  GoDown, NoGoDown, NoGoUp: Boolean;
begin
  Result := False;
  { This function will return a list of SMS parts where Objects property contains corresponding
    Nodes (PVirtualNode) }
  AList.Clear;
  GetLongMsgData(ANode, Ref, Tot, An);
  if Ref >= 0 then begin
    with ListMsg do begin
      FoundCount := 0;
      NoGoDown := False;
      NoGoUp := False;
      Node := ANode;
      Up := 0;
      Down := 1;
      while AList.Count < Tot do
        AList.AddObject('',nil);
      while Node <> nil do begin
        GetLongMsgData(Node, ARef, ATot, An);
        if (ARef = Ref) and (ATot = Tot) then begin
          if (An > 0) and (An <= AList.Count) then begin
            if not Assigned(AList.Objects[An-1]) then
              Inc(FoundCount);
            AList[An - 1] := PListData(GetNodeData(Node))^.smsData.Text;
            AList.Objects[An - 1] := Pointer(Node); // keep track of the nodes containing Long SMS parts
            if FoundCount = Tot then
              Break;
          end;
        end;

        GoDown := Down > 0;
        if Down > 0 then
          while (Down > 0) and (Node <> nil) do begin
            Node := GetNext(Node);
            Dec(Down);
            Inc(Up);
          end
        else
          while (Up > 0) and (Node <> nil) do begin
            Node := GetPrevious(Node);
            Dec(Up);
            Inc(Down);
          end;

        if GoDown then
          if (Node <> nil) and (Down = 0) then
            Inc(Up)
          else
            if Node = nil then begin
              Node := GetLast;
              repeat
                Node := GetPrevious(Node);
                Dec(Up);
                Inc(Down);
              until (Up = 0) or (Node = nil);
              NoGoDown := True;
            end;
        if not GoDown then
          if (Node <> nil) and (Up = 0) then
            Inc(Down)
          else
            if Node = nil then begin
              Node := GetFirst;
              repeat
                Node := GetNext(Node);
                Dec(Down);
                Inc(Up);
              until (Down = 0) or (Node = nil);
              NoGoUp := True;
            end;

        if NoGoDown and NoGoUp then // All parts could not be found
          Break;

        if NoGoDown then begin
          Up := 1;
          Down := 0;
        end;
        if NoGoUp then begin
          Down := 1;
          Up := 0;
        end;
      end;
    end;
    Result := FoundCount = Tot;
  end;
end;

function TfrmMsgView.IsLongSMSNode(ANode: PVirtualNode): boolean;
var
  item: PListData;
begin
  Result := False;
  if not Assigned(ANode) then Exit;
  item := ListMsg.GetNodeData(ANode);
  if Assigned(item) then begin
    Result := item.smsData.IsLong;
  end;
end;

function TfrmMsgView.IsLongSMSFirstNode(ANode: PVirtualNode): boolean;
var
  item: PListData;
begin
  Result := False;
  if not Assigned(ANode) then Exit;
  item := ListMsg.GetNodeData(ANode);
  if Assigned(item) then begin
    Result := item.smsData.IsLongFirst;
  end;
end;

function TfrmMsgView.FindSMS(APDU: string): PVirtualNode;
var
  node: PVirtualNode;
  item: PListData;
begin
  Result := nil;
  node := ListMsg.GetFirst;
  while Assigned(node) do begin
    item := ListMsg.GetNodeData(node);
    if item.smsData.PDU = APDU then begin
      Result := node;
      break;
    end;
    node := ListMsg.GetNext(node);
  end;
end;

procedure TfrmMsgView.ResetAutoMarkAsReadTimer;
begin
  Timer1.Enabled := False;
  Timer1.Enabled := (ListMsg.SelectedCount = 1) and PreviewPanel.Visible;
end;

procedure TfrmMsgView.FormStorage1SavePlacement(Sender: TObject);
var
  s: string;
  i: integer;
begin
  Timer2.Enabled := False; // cancel search timer
  with ListMsg.Header do begin
    s := IntToStr(SortColumn)+','+IntToStr(Ord(SortDirection));
    for i := 0 to Columns.Count-1 do
      s := s+','+IntToStr(Columns[i].Width)+','+IntToStr(Columns[i].Position);
  end;
  FormStorage1.StoredValue['ListHeader'] := s; // do not localize
end;

procedure TfrmMsgView.FormStorage1RestorePlacement(Sender: TObject);
var
  s: widestring;
  i: integer;
begin
  s := FormStorage1.StoredValue['ListHeader']; // do not localize
  if s <> '' then
    try
      with ListMsg.Header do begin
        SortColumn := StrToInt(GetFirstToken(s));
        SortDirection := TSortDirection(StrToInt(GetFirstToken(s)));
        for i := 0 to Columns.Count-1 do begin
          Columns[i].Width := StrToInt(GetFirstToken(s));
          Columns[i].Position := StrToInt(GetFirstToken(s));
        end;
      end;
    except
    end;
  Picture1Click(nil);
  Commands1Click(nil);
end;

procedure TfrmMsgView.ListMsgHeaderMouseUp(Sender: TVTHeader;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FormStorage1SavePlacement(nil);
end;

function TfrmMsgView.CanModifyReadStatus: boolean;
var EData: PFmaExplorerNode;
begin
  EData := Form1.ExplorerNew.GetNodeData(Form1.ExplorerNew.FocusedNode);
  Result := Assigned(EData) and
    (EData.StateIndex and FmaMessagesRootMask = FmaMessagesRootFlag) and
    (Form1.ExplorerNew.FocusedNode <> Form1.FNodeMsgOutbox) and (Form1.ExplorerNew.FocusedNode <> Form1.FNodeMsgDrafts);
end;

procedure TfrmMsgView.DownloadSMS1Click(Sender: TObject);
begin
  { Obsolete
  if MessageDlgW(_('Local messages will be replaced with a fresh copy from the phone.'+
    sLinebreak+sLinebreak+
    'Any local changes will be lost. Do you wish to continue?'),
    mtConfirmation, MB_YESNO or MB_DEFBUTTON2) = ID_YES then
  }
  Form1.ActionConnectionDownload.Execute;
end;

procedure TfrmMsgView.ListMsgIncrementalSearch(Sender: TBaseVirtualTree;
  Node: PVirtualNode; const SearchText: WideString; var Result: Integer);
var
  Data: PListData;
  Text: WideString;
begin
  Data := ListMsg.GetNodeData(Node);
  Text := Copy(Data.from,1,Length(SearchText));
  Result := WideCompareText(SearchText,Text);
end;

procedure TfrmMsgView.Commands1Click(Sender: TObject);
begin
  tbCommands.Visible := Commands1.Checked;
end;

procedure TfrmMsgView.Picture1Click(Sender: TObject);
begin
  ImagePanel.Visible := Picture1.Checked;
end;

function TfrmMsgView.IsRendered(const sl: TStrings): boolean;
begin
  { Do we have rendered data from currently selected Eplorer node? }
  Result := (ListMsg.ChildCount[nil] <> 0) and (FRendered = sl) and Assigned(sl) and (edSearchFor.Text = '');
end;

procedure TfrmMsgView.DoMarkMessages(AsRead, SelectedOnly: Boolean);
var
  node,curr: PVirtualNode;
  item: PListData;
  wl : TTntStringList;
  i: Integer;
begin
  { do not mark as read/unread messages stored in Outbox or Drafts }
  if CanModifyReadStatus then begin
    node := ListMsg.GetFirst;
    while Assigned(node) do begin
      if not SelectedOnly or ListMsg.Selected[node] then begin
        { Skip Long SMS entries except for the first one }
        item := ListMsg.GetNodeData(node);
        if (item.smsData.IsLong) and (not item.smsData.IsLongFirst) then begin
          node := ListMsg.GetNext(node);
          Continue;
        end;
        wl := TTntStringList.Create;
        try
          { Break long SMS into several parts in order to process each PDU-s.
            If it's regular SMS, then emulate a Long SMS with one member (PDU) }
          if not item.smsData.IsLong then
            wl.AddObject(item.smsData.Text,Pointer(node))
          else
            GetNodeLongList(node,wl);
          for i := 0 to wl.Count-1 do begin
            curr := PVirtualNode(wl.Objects[i]);
            if Assigned(curr) then begin
              item := ListMsg.GetNodeData(curr);
              item.smsData.IsNew := not AsRead;
              { Do not mark long SMS entries as Unread, except the first one }
              if not AsRead then break;
            end;
          end;
        finally
          wl.Free;
        end;
      end;
      node := ListMsg.GetNext(node);
    end;
    ListMsg.Repaint;
  end;
  ResetAutoMarkAsReadTimer;
  Form1.UpdateNewMessagesCounter(Form1.ExplorerNew.FocusedNode);
end;

procedure TfrmMsgView.MarkAllRead1Click(Sender: TObject);
begin
  DoMarkMessages(True,False);
end;

procedure TfrmMsgView.SearchForMessages(what: WideString);
var
  Node: PVirtualNode;
  Item: PListData;
  md,mn: string;
  mt,ms: WideString;
  EmptySearch: boolean;
begin
  what := WideUpperCase(what);
  EmptySearch := what = '';
  Timer2.Enabled := False; // cancel search timer
  try
    ListMsg.BeginUpdate;
    DeselectAll;
    node := ListMsg.GetFirst;
    while Assigned(node) do begin
      Item := ListMsg.GetNodeData(Node);
      if (item.smsData.IsLong) and (not item.smsData.IsLongFirst) then begin
        node := ListMsg.GetNext(node);
        Continue;
      end;

      { Get message info }
      if item.smsData.IsLong then mt := GetNodeLongText(Node) else mt := item.smsData.Text;
      mt := WideUpperCase(mt); // message text (for both short or long SMS message)
      md := UpperCase(DateTimeToStr(item.smsData.TimeStamp)); // sent or received date
      ms := WideUpperCase(item.sender); // message sender's name (no number!)
      mn := UpperCase(item.smsData.From); // sender's number only (no name!)

      { Apply search filter }
      case FSearchMode of
        smSender:
          ListMsg.IsVisible[Node] := EmptySearch or (Pos(what,ms) <> 0);
        smFrom:
          ListMsg.IsVisible[Node] := EmptySearch or (Pos(what,ms) <> 0) or (Pos(what,mn) <> 0);
        smAll:
          ListMsg.IsVisible[Node] := EmptySearch or (Pos(what,mt) <> 0) or // text
            (Pos(what,ms) <> 0) or (Pos(what,mn) <> 0) or // sender and number
            (Pos(what,md) <> 0); // message date
        smText:
          ListMsg.IsVisible[Node] := EmptySearch or (Pos(what,mt) <> 0);
        smDate:
          ListMsg.IsVisible[Node] := EmptySearch or (Pos(what,md) <> 0);
      end;

      node := ListMsg.GetNext(node);
    end;
  finally
    ListMsg.EndUpdate;
    lblFiltered.Visible := not EmptySearch;
  end;
end;

procedure TfrmMsgView.DeselectAll;
begin
  ListMsg.BeginUpdate;
  try
    ListMsg.ClearSelection;
  finally
    ListMsg.EndUpdate;
  end;
end;

procedure TfrmMsgView.ListMsgClick(Sender: TObject);
var
  item: PListData;
  mouse: TPoint;
  hit: THitInfo;
  b: boolean;
begin
  if ListMsg.SelectedCount = 1 then begin
    GetCursorPos(mouse);
    mouse := ListMsg.ScreenToClient(mouse);
    ListMsg.GetHitTestInfoAt(mouse.X, mouse.Y, True, hit);
    if hit.HitColumn = 2 then
      if Assigned(hit.HitNode) then begin
        item := ListMsg.GetNodeData(hit.HitNode);
        b := item.smsData.IsNew;
        Screen.Cursor := crAppStart;
        try
          Timer1.Enabled := false;
          DoMarkMessages(b);
          Timer1.Enabled := false;
          ListMsg.RepaintNode(ListMsg.GetFirstSelected);
        finally
          Screen.Cursor := crDefault;
        end;
      end;
  end;
end;

procedure TfrmMsgView.ListMsgPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  item: PListData;
begin
  item := Sender.GetNodeData(Node);

  if item.smsData.IsNew then
    TargetCanvas.Font.Style := [fsBold]
  else
    TargetCanvas.Font.Style := [];
end;

procedure TfrmMsgView.edSearchForKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then begin
    Key := 0;
    if Timer2.Enabled then SearchForMessages(edSearchFor.Text);
  end
  else
  if Key = VK_ESCAPE then begin
    Key := 0;
    if edSearchFor.Text <> '' then begin
      edSearchFor.Text := '';
      SearchForMessages('');
    end;
  end;
end;

procedure TfrmMsgView.edSearchForKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in [#13,#27] then Key := #0; // disables beep sound on enter and escape
end;

procedure TfrmMsgView.edSearchForChange(Sender: TObject);
begin
  Timer2.Enabled := False;
  Timer2.Enabled := edSearchFor.ParentFont;
end;

procedure TfrmMsgView.Timer2Timer(Sender: TObject);
begin
  SearchForMessages(edSearchFor.Text);
end;

procedure TfrmMsgView.Search1Click(Sender: TObject);
begin
  edSearchFor.Text := '';
  edSearchForExit(nil);
  SearchPanel.Visible := True;
  if Visible then
    if ListMsg.Focused then
      edSearchFor.SetFocus
    else
      ListMsg.SetFocus;
end;

procedure TfrmMsgView.SendToPhone1Click(Sender: TObject);
begin
  WriteSMS('ME'); // do not localize
  Form1.Status(_('Messages sent to Phone'));
end;

procedure TfrmMsgView.SendToSIM1Click(Sender: TObject);
begin
  WriteSMS('SM'); // do not localize
  Form1.Status(_('Messages sent to SIM card'));
end;

procedure TfrmMsgView.SendfromPhone1Click(Sender: TObject);
begin
  WriteSMS('ME',2); // do not localize
  Form1.Status(_('Drafts sent to Phone'));
end;

procedure TfrmMsgView.DoShowPreview(Node: PVirtualNode);
const
  LastImage: string = '';
var
  item: PListData;
  sms: TSMS;
  UDHI: String;
  pos, octet, {posTemp,} udhil: Integer;
  Description: String;
  contact: PContactData;
  s: WideString;
  //SL: TWideStringList;
  //i: Integer;
begin
  IsCustomImage := False;
  if Node = nil then begin
    MemoMsgBody.Clear;
    exit;
  end;

  sms := TSMS.Create;//ADD
  try
    //posTemp := 0;
    item := ListMsg.GetNodeData(Node);
    MemoMsgBody.Text := item.smsData.Text;// + inttostr(length(item.msg));
    MemoMsgBody.DefAttributes.Color := clWindowText;
    MemoMsgBody.DefAttributes.Size  := 10;
    sms.PDU := item.smsData.PDU; //ADD
    sms.Text; // Decode all PDU fields
    { try to load contact personalized image and maintain a cache }
    s := Form1.LookupContact(item.smsData.From);
    if Form1.IsIrmcSyncEnabled and Form1.frmSyncPhonebook.FindContact(s,contact) then begin
      s := GetContactPictureFile(contact);
      if s <> '' then
        try
          { cache loaded image name }
          if not IsCustomImage or (s <> LastImage) then begin
            { Use uGlobal function }
            LoadBitmap32FromFile(s,SelImage.Bitmap);
            IsCustomImage := True;
            LastImage := s;
          end;
        except
          IsCustomImage := False;
        end
      else
        IsCustomImage := False;
    end
    else
        IsCustomImage := False;
    { show message info }
    //item.msg := sms.Text;
    if sms.IsUDH then begin
       UDHI := sms.UDHI;
       udhil := StrToInt('$' + copy(UDHI, 1, 2));
       //ANALIZE UDHI
       UDHI := Copy(UDHI, 3, length(UDHI));
       //pos := 1;
       repeat
          //Get the octet for type
          octet := StrToInt('$' + Copy(UDHI, 1, 2));
          UDHI := Copy(UDHI, 3, length(UDHI));
          case octet of
             0,8:begin //SMS CONCATENATION
                 pos := StrToInt('$' + Copy(UDHI, 1, 2)) + 1;
                 if octet = 0 then begin
                   Description := Description + _('[LONG SMS - REFID:') + IntToStr(StrToInt('$' + Copy(UDHI, 3, 2)));
                   Description := Description + _(' - COUNT:') + IntToStr(StrToInt('$' + Copy(UDHI, 5, 2))) + ']';
                 end
                 else begin
                   Description := Description + _('[LONG SMS - REFID:') + IntToStr(StrToInt('$' + Copy(UDHI, 3, 4)));
                   Description := Description + _(' - COUNT:') + IntToStr(StrToInt('$' + Copy(UDHI, 7, 2))) + ']';
                 end;
                 UDHI := Copy(UDHI, pos*2+1, length(UDHI));
                 MemoMsgBody.Clear;
                 (*
                 SL := TWideStringList.Create;
                 try
                   SL.Text := GetNodeLongText(Node);
                   for i := 0 to SL.Count - 1 do begin
                     {
                     // Show different parts in different colors
                     if i mod 2 = 0 then
                       MemoMsgBody.SelAttributes.Color := clHotLight
                     else
                       MemoMsgBody.SelAttributes.Color := MemoMsgBody.Font.Color;
                     }
                     MemoMsgBody.SelText := SL[i];
                   end;
                   MemoMsgBody.SelAttributes.Color := MemoMsgBody.Font.Color;
                 finally
                   SL.Free;
                 end;
                 *)
                 MemoMsgBody.Text := MemoMsgBody.Text + GetNodeLongText(node);
               end;
           {10:begin //TEXT FORMATTING
                 pos := StrToInt('$' + Copy(UDHI, 1, 2)) + 1 ;
                 MemoMsgBody.SelStart := StrToInt('$' + Copy(UDHI, 3, 2));
                 MemoMsgBody.SelLength := Length(MemoMsgBody.text) - MemoMsgBody.SelStart;
                 UDHI := Copy(UDHI, pos*2+1, length(UDHI));
                 Description := Description + _('[EMS TEXT FORMATTING]');
               end;
            11:begin //SOUND
                 pos := StrToInt('$' + Copy(UDHI, 1, 2)) + 1;
                 MemoMsgBody.SelStart := posTemp + StrToInt('$' + Copy(UDHI, 3, 2));
                 MemoMsgBody.SelText := _('[SOUND TYPE: ') + Copy(UDHI, 5, 2) + ']';
                 posTemp := posTemp + 16 ;
                 UDHI := Copy(UDHI, pos*2+1, length(UDHI));
               end;}
             else begin
                 pos := udhil + 1;
                 UDHI := Copy(UDHI, pos*2+1, length(UDHI));
                 Description := _('[EMS]');
               end;
          end;
       until UDHI = '';
       MemoMsgBody.SelStart := length(MemoMsgBody.text);
       MemoMsgBody.selAttributes.Color := clGray;
       MemoMsgBody.selAttributes.Size := 8;
       MemoMsgBody.Lines.add(Description);
    end;   //ADD   }
  finally
    sms.Destroy;   //ADD
  end;
end;

procedure TfrmMsgView.UpdatePropertiesStatus;
var
  Node: PVirtualNode;
begin
  Properties1.Enabled := (ListMsg.SelectedCount = 1) and (Form1.ExplorerNew.FocusedNode <> Form1.FNodeMsgDrafts);
  Node := ListMsg.FocusedNode;
  if ListMsg.SelectedCount = 0 then Node := nil;
  DoShowPreview(Node);
end;

procedure TfrmMsgView.ListMsgFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
begin
  UpdatePreview;
end;

procedure TfrmMsgView.UpdatePreview;
begin
  if Assigned(ListMsg.FocusedNode) and (MemoMsgBody.Lines.Count = 0) then
    DoShowPreview(ListMsg.FocusedNode);
end;

procedure TfrmMsgView.ListMsgKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  { HACK! ... }
  UpdatePropertiesStatus;
  if MemoMsgBody.Lines.Count <> 0 then begin
    ListMsg.Selected[ListMsg.FocusedNode] := True;
    ListMsg.Repaint;
  end;
  { ... HACK! }
end;

procedure TfrmMsgView.CleanupDatabase(Ask,removeDuplicates: boolean);
var
  sl,cl,ml,nl: TStringList;
  i,j,DelCount: Integer;
  APDU: string;
  WasEnabled: Boolean;
  w: WideString;
  md: TFmaMessageData;
begin
  if FRendered = nil then exit;
  if removeDuplicates then
    w := _('Remove duplicate messages and fix unread flags.')
  else
    w := _('Fix hidden unread messages flags.');
  if Ask and (MessageDlgW(w + ' ' + _('Do you wish to continue (No Undo)?'),
    mtConfirmation,MB_YESNO or MB_DEFBUTTON2) <> ID_YES) then
    exit;
  sl := FRendered;
  WasEnabled := Form1.Enabled;
  frmConnect := GetProgressDialog;
  try
    if Form1.CanShowProgress then
      frmConnect.ShowProgress(Form1.FProgressLongOnly);
    w := _('Cleanup messages database...');
    frmConnect.Initialize(sl.Count*(byte(removeDuplicates)+1),w);
    Form1.Status(w);
    Update;
    Form1.Enabled := False; // prevent keyboard move up/down in list while fixing
    if removeDuplicates then begin
      Log.AddMessage('Fix DB: Starting duplicates removal...', lsDebug); // do not localize debug
      i := 0;
      DelCount := 0;
      while i < sl.Count do begin
        APDU := sl[i];
        { All items up to skippedIndex are already processed for duplicates }
        j := i + 1;
        while j < sl.Count do begin
          if AnsiCompareStr(APDU,sl[j]) = 0 then begin
            TFmaMessageData(sl.Objects[j]).Free;
            sl.Delete(j);
            Inc(DelCount);
            Log.AddMessageFmt(_('Database: Removed duplicate message (DB Index: %d, Original: %d)'),
              [j,i], lsInformation);
          end
          else
            Inc(j);
        end;
        frmConnect.IncProgress(1);
        if i mod 32 = 0 then begin
          Application.ProcessMessages;
          if ThreadSafe.AbortDetected then break;
        end;
        Inc(i);
      end;
      Log.AddMessageFmt('Fix DB: Removed %d entries from DB', [DelCount], lsDebug); // do not localize debug
      if Self.Visible then RenderListView(sl);
    end;
    if not ThreadSafe.AbortDetected then begin
      Log.AddMessage('Fix DB: Clearing redundant unread flags...', lsDebug); // do not localize debug
      DelCount := 0;
      for i := 0 to sl.Count-1 do begin
        md := TFmaMessageData(sl.Objects[i]);
        try
          if md.IsLong and not md.IsLongFirst then begin
            if md.IsNew then begin
              md.IsNew := False;
              Inc(DelCount);
              Log.AddMessageFmt(_('Database: Removed new message flag (DB Index: %d)'), [i], lsInformation);
            end;
          end;
        except
          // PDU error? maybe use sl.Delete(i) of course after changing 'for' to 'while'
        end;
        frmConnect.IncProgress(1);
        if i mod 32 = 0 then begin
          Application.ProcessMessages;
          if ThreadSafe.AbortDetected then break;
        end;
      end;
      Log.AddMessageFmt('Fix DB: Removed %d new flags from DB', [DelCount], lsDebug); // do not localize debug
    end;
    { Compact database for faster message parts finding }
    if not ThreadSafe.AbortDetected then begin
      w := _('Compacting message database...');
      frmConnect.Initialize(sl.Count, w);
      Form1.Status(w);
      Update;
      cl := TStringList.Create; // original csv list
      ml := TStringList.Create; // membersList
      nl := TStringList.Create; // new compacted list
      try
        for i:=0 to sl.Count-1 do begin
          md := TFmaMessageData(sl.Objects[i]);
          cl.Add(md.AsString);
        end;
        i := 0;
        while i < cl.Count do try
          if Form1.GetSMSMembers(i, cl, ml) then begin
            for j := 0 to ml.Count-1 do begin
              nl.Add(cl[Integer(ml.Objects[j])]);
              frmConnect.IncProgress(1);
              cl[Integer(ml.Objects[j])] := ''; // blind item
            end;
            repeat
              j := cl.IndexOf('');
              if j = -1 then break;
              cl.Delete(j);
            until cl.Count = 0;
          end
          else
            Inc(i);
          if i mod 32 = 0 then begin
            Application.ProcessMessages;
            if ThreadSafe.AbortDetected then break;
          end;
        except
          // only exception can come from GetSMSMembers, so just skip it
          Inc(i);
        end;
        { TODO: what to do? ask user? cl contains now only incomplete SMS (removal suggested) }
        //for j:=0 to cl.Count-1 do nl.Add(cl[j]);
        Log.AddMessageFmt('Fix DB: Removed %d incomplete message parts', [cl.Count]);
        // nl now contains entire compacted database
        Form1.ClearSMSMessages(sl); // sl == FRendered == EData.Data
        for j := 0 to nl.Count-1 do
          try
            md := TFmaMessageData.Create(nl[j]);
            sl.AddObject(md.PDU, md);
          except
          end;
      finally
        nl.Free;
        ml.Free;
        cl.Free;
      end;
    end;
    Log.AddMessage('Fix DB: Cleanup finished', lsDebug); // do not localize debug
  finally
    FreeProgressDialog;
    Form1.Enabled := WasEnabled;
  end;
  RenderListView(FRendered);
  Form1.UpdateNewMessagesCounter(Form1.ExplorerNew.FocusedNode);
  Form1.Status(_('Database cleanup completed'));
end;

procedure TfrmMsgView.ClearView;
begin
  DoCloseDetails;
  SearchName := '';
  SearchMode := smAll;
  edSearchFor.Text := '';
  edSearchForExit(nil);
  FIsRendered := False;
  FRendered := nil;
  lblFiltered.Visible := False;
  ListMsg.BeginUpdate;
  ListMsg.Clear;
  ListMsg.EndUpdate;
end;

procedure TfrmMsgView.FixSMSDatabase1Click(Sender: TObject);
begin
  CleanupDatabase(True,not Form1.FArchiveDublicates);
end;

procedure TfrmMsgView.SpeedButton1Click(Sender: TObject);
begin
  Form1.ActionViewMsgPreview.Execute;
end;

procedure TfrmMsgView.Image2Click(Sender: TObject);
begin
  edSearchFor.SetFocus;
  edSearchFor.Text := '';
  SearchForMessages(''); // speed-up searching
end;

procedure TfrmMsgView.Image1Click(Sender: TObject);
var
  p: TPoint;
begin
  edSearchFor.SetFocus;
  p := Image1.ClientToScreen(Point(-2,Image1.Height+2));
  pmSearch.Popup(p.X,p.Y);
end;

procedure TfrmMsgView.edSearchForEnter(Sender: TObject);
begin
  if not edSearchFor.ParentFont then begin
    edSearchFor.ParentFont := True;
    edSearchFor.Text := '';
  end;
end;

procedure TfrmMsgView.edSearchForExit(Sender: TObject);
var
  i: Integer;
  s: WideString;
begin
  if edSearchFor.Text = '' then begin
    for i := 0 to pmSearch.Items.Count-1 do
      if pmSearch.Items[i].Checked then begin
        { remove Hot-Key from Caption, if any }
        s := Tnt_WideStringReplace(pmSearch.Items[i].Caption,'&','',[rfReplaceAll]);
        break;
      end;
    edSearchFor.Font.Color := clGray;
    edSearchFor.Text := WideFormat('(%s)',[s]);
  end;
end;

procedure TfrmMsgView.OnSearchTypeChange(Sender: TObject);
begin
  if not (Sender as TTntMenuItem).Checked then begin
    (Sender as TTntMenuItem).Checked := True;

    if sfSender.Checked        then FSearchMode := smSender;
    if sfSenderNumber.Checked  then FSearchMode := smFrom;
    if sfEntireMessage.Checked then FSearchMode := smAll;
    if sfText.Checked          then FSearchMode := smText;
    if sfDate.Checked          then FSearchMode := smDate;

    Timer2.Enabled := False;
    Timer2.Enabled := edSearchFor.ParentFont;
  end;
end;

procedure TfrmMsgView.pmSearchPopup(Sender: TObject);
begin
  SaveSearch1.Enabled := edSearchFor.Text <> '';
end;

procedure TfrmMsgView.SaveSearch1Click(Sender: TObject);
var
  s: WideString;
begin
  s := FSearchName;
  if WideInputQuery('Save Search','Enter search name:',s) and (Trim(s) <> '') then begin
    if Form1.FSavedSearches.IndexOfName(s) <> -1 then
      if MessageDlgW(WideFormat(_('Search "%s" already exists. Do you want to overwrite it?'),[s]),
        mtConfirmation, MB_YESNO or MB_DEFBUTTON2) <> ID_YES then
        exit;
    { Node path is relative to 'My Phone' root node }    
    Form1.FSavedSearches.Values[s] := Form1.ExplorerNodePath(Form1.ExplorerNew.FocusedNode,'\',1)+','+
      IntToStr(Ord(FSearchMode))+','+edSearchFor.Text;
    Form1.RenderSavedSearches;
    Form1.ExplorerNew.Expanded[Form1.FNodeSavedSearches] := True;
  end;
end;

procedure TfrmMsgView.SetSearchMode(const Value: TSearchMode);
begin
  FSearchMode := Value;
  case Value of
    smSender: sfSender.Checked := True;
    smFrom:   sfSenderNumber.Checked := True;
    smAll:    sfEntireMessage.Checked := True;
    smText:   sfText.Checked := True;
    smDate:   sfDate.Checked := True;
  end;
end;

procedure TfrmMsgView.SetSearchWhat(const Value: WideString);
begin
  edSearchFor.ParentFont := True;
  edSearchFor.Text := Value;
end;

function TfrmMsgView.IsRenderingComplete: boolean;
begin
  Result := FIsRendered;
end;

procedure TfrmMsgView.TogglePreviewPane1Click(Sender: TObject);
begin
  Form1.ActionViewMsgPreview.Execute;
end;

procedure TfrmMsgView.DoCloseDetails;
begin
  if Assigned(frmDetail) then begin
    frmDetail.IsModified := False; // Force: Discard any changes!
    frmDetail.Close;
  end;
end;

constructor TfrmMsgView.Create(AOwner: TComponent);
begin
  inherited;
{$IFDEF VER150}
  DetailsPanel.ParentBackground := False;
  SearchPanel.ParentBackground := False;
  LookupPanel.ParentBackground := False;
  LookupWhitePanel.ParentBackground := False;
{$ENDIF}
  TntLabel1.Left := LookupPanel.Left + LookupPanel.Width + 8;
  TntLabel2.Left := TntLabel1.Left + TntLabel1.Width + 4;
  TntLabel2.Font.Style := TntLabel2.Font.Style + [fsBold]; 
end;

procedure TfrmMsgView.SetSearchName(const Value: WideString);
begin
  FSearchName := Value;
  TntLabel1.Visible := Value <> '';
  TntLabel2.Visible := TntLabel1.Visible;
  TntLabel2.Caption := Value;
end;

end.
