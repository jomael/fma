unit uMEEdit;

{
*******************************************************************************
* Descriptions: Phone Book Edit Implementation
* $Source: /cvsroot/fma/fma/Attic/uMEEdit.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uMEEdit.pas,v $
*
*******************************************************************************
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, Grids, TntComCtrls, TntGrids, ExtCtrls, TntExtCtrls, StdCtrls, TntStdCtrls, Math, Menus, TntMenus, VirtualTrees,
  ImgList, uSyncPhonebook, Placemnt, uSIMEdit;

type
  TfrmContactsMEEdit = class(TTntFrame)
    Panel1: TTntPanel;
    btnUpdateME: TTntButton;
    cbForce: TTntCheckBox;
    btnReset: TTntButton;
    PopupMenu1: TTntPopupMenu;
    Clear1: TTntMenuItem;
    Resetchangeflag1: TTntMenuItem;
    ListNumbers: TVirtualStringTree;
    NoItemsPanel: TTntPanel;
    N1: TTntMenuItem;
    N2: TTntMenuItem;
    Properties1: TTntMenuItem;
    NewPerson1: TTntMenuItem;
    UpdateChanged1: TTntMenuItem;
    UpdateAllRecords1: TTntMenuItem;
    FormStorage1: TFormStorage;
    N5: TTntMenuItem;
    UpdateContactsPosition1: TTntMenuItem;
    N4: TTntMenuItem;
    ImportContacts1: TTntMenuItem;
    ExportContacts1: TTntMenuItem;
    OpenDialog1: TTntOpenDialog;
    N3: TTntMenuItem;
    MessageContact1: TTntMenuItem;
    CallContact1: TTntMenuItem;
    ChatContact1: TTntMenuItem;
    N7: TTntMenuItem;
    DownloadEntirePhonebook1: TTntMenuItem;
    SendToPhone1: TTntMenuItem;
    ForceAs1: TTntMenuItem;
    otalChange1: TTntMenuItem;
    CopySelectedToSIMcard1: TTntMenuItem;
    Modified1: TTntMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure StringGridGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure Resetchangeflag1Click(Sender: TObject);
    procedure ListNumbersAfterPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas);
    procedure ListNumbersCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure ListNumbersGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure ListNumbersGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure ListNumbersHeaderClick(Sender: TVTHeader;
      Column: TColumnIndex; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure NewPerson1Click(Sender: TObject);
    procedure UpdateChanged1Click(Sender: TObject);
    procedure UpdateAllRecords1Click(Sender: TObject);
    procedure UpdateContactsPosition1Click(Sender: TObject);
    procedure ListNumbersIncrementalSearch(Sender: TBaseVirtualTree;
      Node: PVirtualNode; const SearchText: WideString;
      var Result: Integer);
    procedure ImportContacts1Click(Sender: TObject);
    procedure DownloadEntirePhonebook1Click(Sender: TObject);
    procedure ListNumbersKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormStorage1SavePlacement(Sender: TObject);
    procedure FormStorage1RestorePlacement(Sender: TObject);
    procedure ListNumbersHeaderMouseUp(Sender: TVTHeader;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnResetClick(Sender: TObject);
    procedure btnUpdateMEClick(Sender: TObject);
    procedure btnDELClick(Sender: TObject);
    procedure btnEDITClick(Sender: TObject);
    procedure CopySelectedToSIMcard1Click(Sender: TObject);
    procedure Modified1Click(Sender: TObject);
    procedure frmSyncPhonebookNewNoUndo2Click(Sender: TObject);
  private
    { Private declarations }
    FContact: TContactData; // used for SIM contact editing (uEditContact)
    FExplore: PVirtualNode; // remember last rendered data's explorer node
    FOldText: String;
    function IsUniqueGUID(who: PSIMData): boolean;
    procedure FullRefresh;
    procedure UpdatePhone(MaxItems: cardinal = 0);
    procedure RenderGUIDs;
  protected
    { Protected declarations }
    FRendered: Boolean;
    function FindFreePos: integer;
    function GetCapacity(Target, LogName: string): Integer;
    procedure DoForceSelectedAs(State: integer);
  public
    { Public declarations }
    SelContact: PSIMData;
    FMaxNumbers: Cardinal;
    FMaxNameLen,FMaxTelLen: integer;
    constructor Create(AOwner: TComponent); override;

    procedure UpdatePhonebook;
    procedure OnConnected; virtual;
    procedure ExportList(FileType:Integer; Filename: WideString); virtual;
    function RenderData(ForceDBNode: PVirtualNode = nil): boolean;

    function IsMEMode: boolean; virtual;
    function IsRendered: boolean;

    function DoEdit(AsNew: boolean = False; NewNumber: string = ''): boolean;

    function FindContact(Number: WideString): WideString; overload;
    function FindContact(FullName: WideString; var AContact: PSIMData): boolean; overload;
    function FindContact(FullName,NumberType: WideString; var AContact: PSIMData): boolean; overload;
    function FindContact(FullName: WideString; var ANode: PVirtualNode): boolean; overload;

    procedure CheckForChanges;
  end;

implementation

uses
  gnugettext, gnugettexthelpers, cUnicodeCodecs,
  uLogger, uThreadSafe, Unit1, uSMS, uGlobal, uEditContact, uConnProgress, uVcard, uXML, WebUtil, uDialogs;

{$R *.dfm}

{ TfrmContactsSMEdit }

constructor TfrmContactsMEEdit.Create(AOwner: TComponent);
begin
  inherited;
  { Set defaults }
  FMaxNameLen := 180; FMaxTelLen := 80; FMaxNumbers := 510;
  FRendered := False;
end;

function TfrmContactsMEEdit.RenderData(ForceDBNode: PVirtualNode): boolean;
var
  sl: TStrings;
  s: WideString;
  i: Integer;
  contact: PSIMData;
  Node: PVirtualNode;
  EData: PFmaExplorerNode;
  Modified,NeedRefresh: Boolean;
begin
  { ForceDBNode is used when loading Profile database etc. }
  if Assigned(ForceDBNode) then
    FExplore := ForceDBNode
  else
    if Form1.ExplorerNew.FocusedNode = Form1.FNodeContactsME then
      FExplore :=Form1.FNodeContactsME
    else
      FExplore :=Form1.FNodeContactsSM;
  EData := Form1.ExplorerNew.GetNodeData(FExplore);
  sl := EData.Data;
  { Load database }
  Modified := False;
  NeedRefresh := False;
  ListNumbers.BeginUpdate;
  try
    ListNumbers.Clear;
    ListNumbers.NodeDataSize := sizeof(TSIMData);
    for i := 0 to sl.Count - 1 do begin
      s := LongStringToWideString(sl[i]);
      if Trim(s) = '' then continue;
      { process DB }
      Node := ListNumbers.AddChild(nil);
      try
        contact := ListNumbers.GetNodeData(Node);
        contact.cname := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        contact.pnumb := GetFirstToken(s);
        contact.position := StrToInt(GetFirstToken(s));
        if contact.position = 0 then NeedRefresh := True;
        try
          contact.imageindex := StrToInt(GetFirstToken(s));
        except
          contact.imageindex := 3; // 3 = not modified (new) item
          Modified := True;
        end;
        try
          contact.CDID := StringToGUID(GetFirstToken(s));
        except
          contact.CDID := NewGUID;
          Modified := True;
        end;
        contact.LUID := GetFirstToken(s);
        Form1.ExtractName(contact.cname,contact.ptype);
      except
        ListNumbers.DeleteNode(Node);
        Log.AddMessageFmt(_('Database: Error loading data (DB Index %d)'), [i], lsError);
        if FindCmdLineSwitch('FIXDB') then begin
          sl[i] := '';
          Log.AddMessageFmt(_('Database: Removed incorrect data (DB Index: %d)'), [i], lsInformation);
        end;
      end;
    end;
    RenderGUIDs;
    FRendered := True;
  finally
    ListNumbers.EndUpdate;
    ListNumbers.Sort(nil, ListNumbers.Header.SortColumn, ListNumbers.Header.SortDirection);
  end;
  if NeedRefresh then
    if not Form1.IsIrmcSyncEnabled then
      Form1.Status(WideFormat(_('Please refresh %s from phone, because some contact positions are missing!'),
        [EData.Text]));
  Result := Modified;
end;

procedure TfrmContactsMEEdit.Button1Click(Sender: TObject);
begin
  if not Form1.FConnected then Form1.ActionConnectionConnectExecute(Self);

  Form1.ActionContactsDownloadExecute(Self);
  RenderData;
end;

procedure TfrmContactsMEEdit.UpdatePhone(MaxItems: cardinal);
begin
  Form1.frmSMEdit.UploadChangesToPhone(IsMEMode,ListNumbers,MaxItems,FMaxNumbers,FMaxNameLen,cbForce.Checked);
end;

procedure TfrmContactsMEEdit.btnUpdateMEClick(Sender: TObject);
var
  Item: PSIMData;
  Node: PVirtualNode;
  mcount,dcount,count: cardinal;
  s,d: WideString;
begin
  mcount := 0; dcount := 0;

  Node := ListNumbers.GetFirst;
  while Assigned(Node) do
  try
    item := ListNumbers.GetNodeData(Node);
    if item.imageindex = 2 then
      // deleted contact
      inc(dcount)
    else
      // then process modified (or all) entries
      if (item.imageindex <> 3) or cbForce.Checked then begin
        { Do sanity check for modified contacts }
        if (Trim(item.cname) = '') and (Trim(item.pnumb) <> '') then
          raise EConvertError.Create(Format(_('Please enter a contact name at position %s'),[IntToStr(item.position)]));
        if (Trim(item.cname) <> '') and (Trim(item.pnumb) = '') then
          raise EConvertError.Create(Format(_('Please enter a phone number at position %s'),[IntToStr(item.position)]));
        if Length(item.cname) > FMaxNameLen then
          raise EConvertError.Create(Format(_('The name at position %s is too long'),[IntToStr(item.position)]));
        if Length(item.pnumb) > (FMaxTelLen+byte(Pos('+',item.pnumb) <> 0)) then
          raise EConvertError.Create(Format(_('The number at position %s is too long'),[IntToStr(item.position)]));
        inc(mcount);
      end;
  finally
    Node := ListNumbers.GetNext(Node);
  end;

  count := mcount + dcount;
  if count <> 0 then begin
    if mcount <> 0 then
      s := WideFormat(ngettext('%d modified contact', '%d modified contacts', mcount), [mcount])
    else
      s := '';
    if dcount <> 0 then 
      d := WideFormat(ngettext('%d deleted contact', '%d deleted contacts', dcount), [dcount])
    else
      d := '';
    if s <> '' then begin
      if d <> '' then s := WideFormat('%s and %d',[s,d]);
    end
    else
      s := d;
    case MessageDlgW(WideFormat(_('Confirm sending %s to Phonebook?'),[s]), mtConfirmation, MB_YESNOCANCEL) of
      ID_YES: UpdatePhone(count);
      ID_CANCEL: Abort;
    end;
  end;
end;

procedure TfrmContactsMEEdit.btnResetClick(Sender: TObject);
var
  Item: PSIMData;
  Node: PVirtualNode;
begin
  ListNumbers.BeginUpdate;
  Node := ListNumbers.GetFirst;
  while Node <> nil do
  try
    item := ListNumbers.GetNodeData(Node);
    item.imageindex := 3; // mark as not modified
  finally
    Node := ListNumbers.GetNext(Node);
  end;
  ListNumbers.EndUpdate;
  UpdatePhonebook;
end;

procedure TfrmContactsMEEdit.StringGridGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  FOldText := Value;
end;

procedure TfrmContactsMEEdit.btnDELClick(Sender: TObject);
var
  Item: PSIMData;
  Node,Tmp: PVirtualNode;
  s: WideString;
begin
  if ListNumbers.SelectedCount = 0 then exit;
  s := WideFormat(_('Deleting %d %s.'), [ListNumbers.SelectedCount,
    ngettext('contact','contacts',ListNumbers.SelectedCount)]);
  if MessageDlgW(s+_(' Do you wish to continue?'), mtConfirmation, MB_YESNO	or MB_DEFBUTTON2) <> ID_YES then
    exit;
  Form1.Status(s+'..');
  ListNumbers.BeginUpdate;
  try
    Node := ListNumbers.GetFirst;
    while Node <> nil do begin
      if ListNumbers.Selected[Node] then begin
        item := ListNumbers.GetNodeData(Node);
        if item.imageindex <> 0 then begin
          item.imageindex := 2;
        end
        else begin
          Tmp := Node;
          if Node <> ListNumbers.GetFirst then begin
            Node := ListNumbers.GetPrevious(Node);
            ListNumbers.DeleteNode(Tmp);
          end
          else begin
            ListNumbers.DeleteNode(Tmp);
            Node := ListNumbers.GetFirst;
            continue;
          end;
        end;
      end;
      Node := ListNumbers.GetNext(Node);
    end;
  finally
    ListNumbers.EndUpdate;
    UpdatePhonebook;
  end;
  Form1.Status('');
end;

procedure TfrmContactsMEEdit.Resetchangeflag1Click(Sender: TObject);
begin
  DoForceSelectedAs(3);
end;

function TfrmContactsMEEdit.GetCapacity(Target, LogName: string): Integer;
var
  i: Integer;
  buffer, stop: String;
  slTmp: TStrings;
begin
  Form1.TxAndWait('AT+CPBS="'+Target+'"'); // do not localize
  Form1.TxAndWait('AT+CPBR=?'); // do not localize
  // defaults
  buffer := '';
  stop := '200'; FMaxNameLen := 14; FMaxTelLen := 80;
  // +CPBR: (1-200),80,14
  for i := 0 to ThreadSafe.RxBuffer.Count-1 do
    if Pos('+CPBR',ThreadSafe.RxBuffer.Strings[i]) = 1 then begin // do not localize
      buffer := ThreadSafe.RxBuffer.Strings[i];
      break;
    end;
  for i := 1 to length(buffer) do begin
    if IsDelimiter('()-,', buffer, i) then buffer[i] := ' ';
  end;
  // +CPBR:  1 200  80 14
  if buffer <> '' then begin
    slTmp := TStringList.Create;
    try
      slTmp.DelimitedText := buffer;
      stop := slTmp.Strings[2];
      Log.AddMessage(LogName+': max entries = '+stop, lsDebug); // do not localize debug
      FMaxTelLen := StrToInt(slTmp.Strings[3]);
      Log.AddMessage(LogName+': max tel length = '+slTmp.Strings[3], lsDebug); // do not localize debug
      FMaxNameLen := StrToInt(slTmp.Strings[4]);
      Log.AddMessage(LogName+': max name length = '+slTmp.Strings[4], lsDebug); // do not localize debug
    finally
      slTmp.Free;
    end;
  end;  
  Result := StrToInt(stop);
end;

procedure TfrmContactsMEEdit.OnConnected;
begin
  FMaxNumbers := GetCapacity('ME','Phone Book');
end;

procedure TfrmContactsMEEdit.ListNumbersAfterPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas);
begin
  NoItemsPanel.Visible := ListNumbers.RootNodeCount = 0;
end;

procedure TfrmContactsMEEdit.ListNumbersCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  SIM1, SIM2: PSIMData;
begin
  SIM1 := Sender.GetNodeData(Node1);
  SIM2 := Sender.GetNodeData(Node2);

  if Column = 0 then begin
    if SIM1.position > SIM2.position then
      Result := 1
    else
      if SIM1.position < SIM2.position then
        Result := -1
      else
        Result := 0;  
  end
  else if Column = 1 then Result := WideCompareStr(SIM1.cname, SIM2.cname)
  else if Column = 2 then Result := WideCompareStr(SIM1.pnumb, SIM2.pnumb);
end;

procedure TfrmContactsMEEdit.ListNumbersGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  SIM: PSIMData;
begin
  if Column = 0 then begin
    if (Kind = ikNormal) or (Kind = ikSelected) then begin
      SIM := Sender.GetNodeData(Node);
      ImageIndex := SIM.imageindex;
    end
    else ImageIndex := -1;
  end;
end;

procedure TfrmContactsMEEdit.ListNumbersGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  SIM: PSIMData;
begin
  SIM := Sender.GetNodeData(Node);

  if Column = 0 then CellText := IntToStr(SIM.position)
  else if Column = 1 then CellText := SIM.cname
  else if Column = 2 then CellText := SIM.pnumb
  else if Column = 3 then begin
    CellText := '';
    if SIM.ptype = 'M' then CellText := _('Cell');
    if SIM.ptype = 'W' then CellText := _('Work');
    if SIM.ptype = 'H' then CellText := _('Home');
    if SIM.ptype = 'O' then CellText := _('Other');
    if SIM.ptype = 'F' then CellText := _('Fax');
  end
  else if Column = 4 then begin
    CellText := '';
    case SIM.imageindex of
      0: CellText := _('New contact');
      1: CellText := _('Modified contact');
      2: CellText := _('Deleted contact');
      3: CellText := '';
    end;
  end;
end;

procedure TfrmContactsMEEdit.ListNumbersHeaderClick(Sender: TVTHeader;
  Column: TColumnIndex; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if Button = mbLeft then begin
    if Column = Sender.SortColumn then begin
      if Sender.SortDirection = sdDescending then
        Sender.SortDirection := sdAscending
      else
        Sender.SortDirection := sdDescending;
    end
    else
      Sender.SortColumn := Column;
    ListNumbers.Sort(nil, ListNumbers.Header.SortColumn, ListNumbers.Header.SortDirection);
  end;
end;

procedure TfrmContactsMEEdit.btnEDITClick(Sender: TObject);
var
  Node :PVirtualNode;
begin
  Node := ListNumbers.FocusedNode;
  if Node <> nil then begin
    SelContact := ListNumbers.GetNodeData(Node);
    DoEdit;
  end;
end;

procedure TfrmContactsMEEdit.PopupMenu1Popup(Sender: TObject);
begin
  Properties1.Enabled := ListNumbers.SelectedCount = 1;
  DownloadEntirePhonebook1.Enabled := Form1.FConnected and not Form1.FObex.Connected;
  CopySelectedtoSIMcard1.Enabled := ListNumbers.SelectedCount <> 0;
end;

function TfrmContactsMEEdit.DoEdit(AsNew: boolean; NewNumber: string): boolean;
var
  Node: PVirtualNode;
begin
  Result := False;
  with TfrmEditContact.Create(nil) do
  try
    FillChar(FContact,SizeOf(FContact),0);
    IsNew := AsNew or (Selcontact = nil);
    // set restrictions
    MaxFullNameLen :=  FMaxNameLen;
    txtName.MaxLength := FMaxNameLen;
    txtCell.MaxLength := FMaxTellen;
    // update FContact (see TContactData in uSyncPhonebook)
    if IsNew then begin
      FContact.cell := NewNumber;
    end
    else begin
      { Set contact name and surname }
      SetContactFullName(@FContact,Selcontact^.cname);
      FContact.LUID := Selcontact^.LUID;
      FContact.CDID := Selcontact^.CDID;
      { Set number according to phone type }
      if Selcontact^.pnumb <> '' then
        if Selcontact^.ptype = '' then
          FContact.cell := Selcontact^.pnumb // if no number type specified, use cell one (see bellow)
        else
          case Selcontact^.ptype[1] of
            'M': FContact.cell := Selcontact^.pnumb;
            'W': FContact.work := Selcontact^.pnumb;
            'H': FContact.home := Selcontact^.pnumb;
            'F': FContact.fax := Selcontact^.pnumb;
            'O': FContact.other := Selcontact^.pnumb;
          end;
    end;
    contact := FContact;
    UseSIMMode := True;
    // edit contact as a SIM entry  
    if ShowModal = mrOk then begin
      if Modified then with ListNumbers do begin
        // apply total updates
        BeginUpdate;
        try
          if IsNew then begin // create new node
            Node := AddChild(nil);
            Selcontact := ListNumbers.GetNodeData(Node);
            // new node, update IDs
            Selcontact^.LUID := '';
            Selcontact^.CDID := NewGUID;
            contact.LUID := '';
            contact.CDID := Selcontact^.CDID;
          end
          else
            Node := nil;

          { copy all data }
          FContact := contact;
          Selcontact^.cname := FContact.name;
          if FContact.surname <> '' then
            Selcontact^.cname := Selcontact^.cname + ' ' + FContact.surname;

          { get new number }
          if IsNew then begin
            if FContact.cell <> '' then begin
              Selcontact^.pnumb := FContact.cell;
              Selcontact^.ptype := 'M'; // do not localize
            end;
            if FContact.work <> '' then begin
              Selcontact^.pnumb := FContact.work;
              Selcontact^.ptype := 'W'; // do not localize
            end;
            if FContact.home <> '' then begin
              Selcontact^.pnumb := FContact.home;
              Selcontact^.ptype := 'H'; // do not localize
            end;
            if FContact.fax <> '' then begin
              Selcontact^.pnumb := FContact.fax;
              Selcontact^.ptype := 'F'; // do not localize
            end;
            if FContact.other <> '' then begin
              Selcontact^.pnumb := FContact.other;
              Selcontact^.ptype := 'O'; // do not localize
            end;
          end
          else
            if Selcontact^.ptype = '' then begin
              Selcontact^.pnumb := FContact.cell; // if no number type specified, use cell one (see above)
              Selcontact^.ptype := 'M';
            end
            else
              case Selcontact^.ptype[1] of
                'M': Selcontact^.pnumb := FContact.cell;
                'W': Selcontact^.pnumb := FContact.work;
                'H': Selcontact^.pnumb := FContact.home;
                'F': Selcontact^.pnumb := FContact.fax;
                'O': Selcontact^.pnumb := FContact.other;
              end;

          if IsNew then begin
            Selcontact^.imageindex := 0;
            // find free position
            Selcontact^.position := FindFreePos;
            if Selcontact^.position = -1 then begin
              DeleteNode(Node);
              MessageDlgW(_('No free position available'),mtError,MB_OK);
              Abort;
            end
            else
              Result := True;
          end
          else
            if Selcontact^.imageindex <> 0 then begin // mark as modified
              Selcontact^.imageindex := 1;
              Result := True;
            end;
        finally
          EndUpdate;
        end;
        UpdatePhonebook;
      end;
      if customModified then begin
        { save call notes to DB }
        SetContactNotes(@contact,ContactNotes);
        // no need to call UpdatePhonebook here
        Result := True;
      end;
    end;
  finally
    Free;
  end;
  ListNumbers.Sort(nil, ListNumbers.Header.SortColumn, ListNumbers.Header.SortDirection);
end;

procedure TfrmContactsMEEdit.NewPerson1Click(Sender: TObject);
begin
  if ListNumbers.RootNodeCount < FMaxNumbers then
    DoEdit(True)
  else
    MessageDlgW(_('No more space in memory! New contact can not be created.'), mtError, MB_OK);
end;

procedure TfrmContactsMEEdit.UpdateChanged1Click(Sender: TObject);
begin
  cbForce.Checked := False;
  btnUpdateME.Click;
end;

procedure TfrmContactsMEEdit.UpdateAllRecords1Click(Sender: TObject);
begin
  cbForce.Checked := True;
  btnUpdateME.Click;
end;

function TfrmContactsMEEdit.FindFreePos: integer;
var
  Node :PVirtualNode;
  Item: PSIMData;
  Pos: integer;
  found: boolean;
begin
  Pos := 1;
  while cardinal(Pos) <= FMaxNumbers do begin
    found := false;
    Node := ListNumbers.GetFirst;
    while Node <> nil do
    try
      item := ListNumbers.GetNodeData(Node);
      if item.position = Pos then begin
        found := true;
        break;
      end;
    finally
      Node := ListNumbers.GetNext(Node);
    end;
    if not found then break;
    Pos := Pos + 1;
  end;
  if cardinal(Pos) <= FMaxNumbers then Result := Pos else Result := -1;
end;

procedure TfrmContactsMEEdit.UpdateContactsPosition1Click(Sender: TObject);
var
  Pos: Integer;
  Item: PSIMData;
  Node: PVirtualNode;
begin
  if MessageDlgW(_('Sorting contacts will replace all contacts position. Are you sure?'),
    mtConfirmation, MB_YESNO or MB_DEFBUTTON2) <> ID_YES then exit;
  Pos := 1;
  try
    Node := ListNumbers.GetFirst;
    while Node <> nil do
    try
      item := ListNumbers.GetNodeData(Node);
      if item.position <> Pos then begin
        item.position := Pos;
        item.imageindex := 1; // mark as modified
      end;
      inc(Pos);
    finally
      Node := ListNumbers.GetNext(Node);
    end;
  finally
    ListNumbers.Sort(nil, ListNumbers.Header.SortColumn, ListNumbers.Header.SortDirection);
    UpdatePhonebook;
  end;  
end;

function TfrmContactsMEEdit.IsMEMode: boolean;
begin
  Result := True;
end;

procedure TfrmContactsMEEdit.UpdatePhonebook;
begin
  if IsMEMode then
    Form1.UpdateMEPhonebook
  else
    Form1.UpdateSMPhonebook;
end;

function TfrmContactsMEEdit.IsRendered: boolean;
begin
  { Do we have rendered data from currently selected Eplorer node? (ME or SM) }
  //Result := FRendered and (IsMEMode = (Form1.Explorer.Selected = Form1.FNodeContactsME));
  Result := FRendered;
end;

procedure TfrmContactsMEEdit.CheckForChanges;
var
  Modified: boolean;
  Contact: PSIMData;
  Node :PVirtualNode;
begin
  Modified := False;
  Node := ListNumbers.GetFirst;
  while Node <> nil do
  try
    Contact := ListNumbers.GetNodeData(Node);
    if Contact^.imageindex <> 3 then begin
      Modified := True;
      break;
    end;
  finally
    Node := ListNumbers.GetNext(Node);
  end;
  if Modified then UpdateChanged1.Click;
end;

procedure TfrmContactsMEEdit.ListNumbersIncrementalSearch(
  Sender: TBaseVirtualTree; Node: PVirtualNode;
  const SearchText: WideString; var Result: Integer);
var
  SIM: PSIMData;
  Text: WideString;
begin
  SIM := Sender.GetNodeData(Node);
  Text := Copy(SIM.cname,1,Length(SearchText));
  Result := WideCompareText(SearchText,Text);
end;

procedure TfrmContactsMEEdit.ImportContacts1Click(Sender: TObject);
var
  i,j,adds,mods: integer;
  Node: PVirtualNode;
  AContact: TContactData;
  PContact: PContactData;
  contact: PSIMData;
  sl: TStringList;
  F,N,T: WideString;
  Modified: boolean;
  dlg: TfrmConnect;
  VCard: TVCard;
begin
  if not OpenDialog1.Execute then exit;
  Update;
  PContact := @AContact;
  dlg := GetProgressDialog;
  VCard := TVCard.Create;
  try
    if Form1.CanShowProgress then
      dlg.ShowProgress(Form1.FProgressLongOnly);
    dlg.Initialize(OpenDialog1.Files.Count,_('Importing SIM contacts'));

    Form1.Status(_('Importing contacts...'));
    //SyncLog(_('Import started'));

    adds := 0; mods := 0;
    //ListContacts.BeginUpdate;
    sl := TStringList.Create;
    try
      for i := 0 to OpenDialog1.Files.Count-1 do begin
        sl.LoadFromFile(OpenDialog1.Files[i]);
        dlg.IncProgress(1);
        VCard.Clear;
        VCard.Raw := sl;
        vCard2Contact(VCard,PContact);
        F := GetvCardFullName(VCard);
        { Process all contact numbers }
        for j := 1 to 4 do begin
          case j of
            1: N := PContact^.cell;
            2: N := PContact^.work;
            3: N := PContact^.home;
            4: N := PContact^.other;
          end;
          if N = '' then continue;
          T := GetContactPhoneType(PContact,N);
          Modified := False;
          // ask to replace old record, if present
          if FindContact(F,T,contact) then begin
            { TODO: Add dialog with replace details }
            if T <> 'O' then // do not owerwrite Other type, but create a new record instead  // do not localize
              // (TODO: add wizard here) 
              case MessageDlgW(
                WideFormat(_('Contact %s already exists. Do you want to replace its current number [%s] with imported number [%s] ?'+
                  sLinebreak+sLinebreak+
                  'Click Yes to replace number, or click No to add it as a New contact'),[F,contact^.pnumb,N]),
                mtConfirmation, MB_YESNOCANCEL or MB_DEFBUTTON2) of
                ID_YES: begin
                  //SyncLog(F + ' modified in FMA by Import.');
                  Modified := True;
                end;
                //mrNo: SyncLog(F + ' added in FMA by Import (as dublicate).');
                ID_CANCEL: Abort;
              end;
            //else SyncLog(F + ' added to FMA by Import.');
          end;
          //else SyncLog(F + ' added to FMA by Import.');
          if not Modified then begin
            Node := ListNumbers.AddChild(nil);
            contact := ListNumbers.GetNodeData(Node);
            contact^.position := FindFreePos;
            contact^.ptype := T;
          end;
          contact^.cname := F;
          contact^.pnumb := N;
          if Modified then begin
            contact^.imageindex := 1;
            inc(mods);
          end
          else begin
            contact^.imageindex := 0;
            inc(adds);
          end;
        end;
        ListNumbers.Update;
      end;
    finally
      sl.free;
      if (adds <> 0) or (mods <> 0) then begin
        //ListContacts.EndUpdate;
        ListNumbers.Sort(nil, ListNumbers.Header.SortColumn, ListNumbers.Header.SortDirection);
        Form1.UpdateSMPhonebook;
        Log.AddSynchronizationMessage('Imported '+IntToStr(adds+mods)+' item(s)... ('+
          IntToStr(adds)+' added, '+IntToStr(mods)+' modified)', lsDebug); // do not localize debug
      end;
    end;
  finally
    VCard.Free;
    FreeProgressDialog;
    //SyncLog(_('Import finished'));
    Form1.Status(_('Import complete.'));
  end;
end;

function TfrmContactsMEEdit.FindContact(FullName: WideString;
  var AContact: PSIMData): boolean;
var
  Node :PVirtualNode;
begin
  Result := False;
  Node := ListNumbers.GetFirst;
  while Node <> nil do
  try
    AContact := ListNumbers.GetNodeData(Node);
    if WideCompareText(FullName,AContact^.cname) = 0 then begin
      Result := True;
      break;
    end;
  finally
    Node := ListNumbers.GetNext(Node);
  end;
end;

function TfrmContactsMEEdit.FindContact(FullName: WideString;
  var ANode: PVirtualNode): boolean;
var
  Node :PVirtualNode;
  AContact: PSIMData;
begin
  Result := False;
  Node := ListNumbers.GetFirst;
  while Node <> nil do
  try
    AContact := ListNumbers.GetNodeData(Node);
    if WideCompareText(FullName,AContact^.cname) = 0 then begin
      ANode := Node;
      Result := True;
      break;
    end;
  finally
    Node := ListNumbers.GetNext(Node);
  end;
end;

function TfrmContactsMEEdit.FindContact(FullName, NumberType: WideString;
  var AContact: PSIMData): boolean;
var
  Node :PVirtualNode;
begin
  Result := False;
  Node := ListNumbers.GetFirst;
  while Node <> nil do
  try
    AContact := ListNumbers.GetNodeData(Node);
    if (WideCompareText(FullName,AContact^.cname) = 0) and
      (WideCompareText(NumberType,AContact^.ptype) = 0) then begin
      Result := True;
      break;
    end;
  finally
    Node := ListNumbers.GetNext(Node);
  end;
end;

procedure TfrmContactsMEEdit.ExportList(FileType: Integer; Filename: WideString);
var
  node: PVirtualNode;
  contact: PSIMData;
  AContact: TContactData;
  PContact: PContactData;
  sl: TStringList;
  str: WideString;
  VCard: TVCard;
  i: integer;
  s: string;
  XML: TXML;
  CurNodeName: string;
begin
  if FileType <> 1 then begin
    if MessageDlgW(_('FMA could Import only vCard contact exports. Do you still want to continue exporting?'),
      mtConfirmation, MB_YESNO or MB_DEFBUTTON2) <> ID_YES then
      exit;
  end;
  PContact := @AContact;
  case FileType of
    1:begin//vCard
        { TODO: export all records/numbers for a contact at once in a vCard file }
        VCard := TVCard.Create;
        sl := TStringList.Create;
        try
          with ListNumbers do begin
            node := GetFirst;
            if node <> nil then
            repeat
               try
                  if Selected[node] then begin
                     contact := GetNodeData(node);
                     FillChar(AContact,SizeOf(AContact),0);
                     SetContactFullName(PContact,contact^.cname);
                     if contact^.ptype = 'W' then PContact^.work := contact^.pnumb else // do not localize
                     if contact^.ptype = 'H' then PContact^.home := contact^.pnumb else // do not localize
                     if contact^.ptype = 'F' then PContact^.fax := contact^.pnumb else // do not localize
                     if contact^.ptype = 'O' then PContact^.other := contact^.pnumb else // do not localize
                       PContact^.cell := contact^.pnumb;
                     Contact2vCard(PContact,VCard);
                     sl.Clear;
                     sl.AddSTrings(VCard.Raw);
                     if ListNumbers.SelectedCount <> 1 then begin
                       str := contact^.ptype;
                       if str = 'O' then str := ''; // hide Other type
                       if str <> '' then str := ' ('+str+')';
                       str := Trim(contact^.cname) + str;
                       str := StringReplace(str,' ','-',[rfReplaceAll]);
                       str := WideChangeFileExt(FileName,'-'+str)+WideExtractFileExt(Filename);
                     end
                     else
                       str := Filename;
                     i := 0; s := str;
                     while WideFileExists(s) do begin
                       inc(i);
                       s := WideChangeFileExt(str,'') + ' (' + IntToStr(i) + ')' + WideExtractFileExt(str);
                     end;
                     sl.SaveToFile(s);
                  end;
               except
               end;
               node := GetNext(node);
            until node = nil;
          end;
        finally
          sl.Free;
          VCard.Free;
        end;
      end;
    2:begin//xml
        XML := TXML.Create();
        XML.TagName := 'fma_contacts'; // do not localize

        try
          with ListNumbers do
          begin
            node := GetFirst;
            if node <> nil then
            repeat
               try
                  if Selected[node] then
                  begin
                     contact := GetNodeData(node);
                     FillChar(AContact,SizeOf(AContact),0);
                     SetContactFullName(PContact,contact^.cname);

                     if contact^.ptype = 'W' then CurNodeName := 'work' else // do not localize
                     if contact^.ptype = 'H' then CurNodeName := 'home' else // do not localize
                     if contact^.ptype = 'F' then CurNodeName := 'fax' else // do not localize
                     if contact^.ptype = 'O' then CurNodeName := 'other' else // do not localize
                       CurNodeName := 'cell'; // do not localize

                     with XML.AddChild('contact') do // do not localize
                     begin
                      AddChild('name', HTMLEncode(WideStringToUTF8String(PContact^.name), False)); // do not localize
                      AddChild(CurNodeName, HTMLEncode(WideStringToUTF8String(contact^.pnumb), False));
                      AddChild('position', HTMLEncode(WideStringToUTF8String(IntToStr(contact^.position)), False)); // do not localize
                     end;
                  end;
               except
               end;
               node := GetNext(node);
            until node = nil;
          end;

          XML.Save(FileName);
        finally
          XML.Free();
        end;
      end;
    else
      raise Exception.Create(_('Not implemented yet'));
  end;
end;

procedure TfrmContactsMEEdit.DownloadEntirePhonebook1Click(Sender: TObject);
begin
  if MessageDlgW(_('Local Phonebook will be replaced with a fresh copy from the phone.'+sLinebreak+sLinebreak+
    'Any local changes will be lost. Do you wish to continue?'),
    mtConfirmation, MB_YESNO or MB_DEFBUTTON2) = ID_YES then begin
      ListNumbers.Clear;
      FullRefresh;
    end;
end;

procedure TfrmContactsMEEdit.ListNumbersKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (ListNumbers.SelectedCount = 1) then
    btnEditClick(nil);
end;

procedure TfrmContactsMEEdit.FullRefresh;
begin
  Form1.ActionContactsDownload.Execute;
  UpdatePhonebook;
end;

procedure TfrmContactsMEEdit.FormStorage1SavePlacement(Sender: TObject);
var
  s: string;
  i: integer;
begin
  with ListNumbers.Header do begin
    s := IntToStr(SortColumn)+','+IntToStr(Ord(SortDirection));
    for i := 0 to Columns.Count-1 do
      s := s+','+IntToStr(Columns[i].Width)+','+IntToStr(Columns[i].Position);
  end;
  FormStorage1.StoredValue['ListHeader'] := s; // do not localize
end;

procedure TfrmContactsMEEdit.FormStorage1RestorePlacement(Sender: TObject);
var
  s: widestring;
  i: integer;
begin
  s := FormStorage1.StoredValue['ListHeader']; // do not localize
  if s <> '' then
    try
      with ListNumbers.Header do begin
        SortColumn := StrToInt(GetFirstToken(s));
        SortDirection := TSortDirection(StrToInt(GetFirstToken(s)));
        for i := 0 to Columns.Count-1 do begin
          Columns[i].Width := StrToInt(GetFirstToken(s));
          Columns[i].Position := StrToInt(GetFirstToken(s));
        end;
      end;
    except
    end;
end;

procedure TfrmContactsMEEdit.ListNumbersHeaderMouseUp(Sender: TVTHeader;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FormStorage1SavePlacement(nil);
end;

function TfrmContactsMEEdit.FindContact(Number: WideString): WideString;
var
  Node: PVirtualNode;
  contact: PSIMData;
begin
  Result := '';
  Node := ListNumbers.GetFirst;
  while Node <> nil do begin
    contact := ListNumbers.GetNodeData(Node);
    if CompareText(Form1.GetPartialNumber(Number),Form1.GetPartialNumber(contact.pnumb)) = 0 then begin
      Result := contact.cname;
      break;
    end;
    Node := ListNumbers.GetNext(Node);
  end;
end;

procedure TfrmContactsMEEdit.RenderGUIDs;
var
  contact: PSIMData;
  Node: PVirtualNode;
begin
  { Make sure all contacts' GUIDs are unique }
  Node := ListNumbers.GetFirst;
  while Node <> nil do begin
    contact := ListNumbers.GetNodeData(Node);
    repeat
      if IsUniqueGUID(contact) then break;
      contact.CDID := NewGUID;
    until False;
    Node := ListNumbers.GetNext(Node);
  end;
end;

function TfrmContactsMEEdit.IsUniqueGUID(who: PSIMData): boolean;
var
  Node: PVirtualNode;
  contact: PSIMData;
begin
  { Checks whether who contact has an unique GUID field }
  Result := True;
  Node := ListNumbers.GetFirst;
  while Node <> nil do begin
    contact := ListNumbers.GetNodeData(Node);
    if (contact <> who) and (GUIDToString(contact.CDID) = GUIDToString(who.CDID)) then begin
      Result := False;
      break;
    end;
    Node := ListNumbers.GetNext(Node);
  end;
end;

procedure TfrmContactsMEEdit.CopySelectedToSIMcard1Click(Sender: TObject);
var
  NewCnt,UpdCnt,SkpCnt,Answer: integer;
  dl: TStrings;
  node: PVirtualNode;
  contact: PSIMData;
  data1,data2: PFmaExplorerNode;
  cname: WideString;
  procedure AddNumber(AName,Kind: WideString; ANumber: string);
  var
    cnode,nnode: PVirtualNode;
    i,j,image,FoundIndex,cpos: Integer;
    utf8s: String;
  begin
    cpos := Form1.frmSMEdit.FindFreePos(dl);
    if cpos = -1 then Abort;
    FoundIndex := -1;

    { Try to locate contact }
    cnode := Form1.FindExplorerChildNode(AName,Form1.FNodeContactsSM);
    if Assigned(cnode) then begin
      if Kind = 'H' then image := 9 // do not localize
      else if Kind = 'M' then image := 10 // do not localize
      else if Kind = 'W' then image := 11 // do not localize
      else if Kind = 'F' then image := 12 // do not localize
      else image := 13;

      { Try to locate contact's number of the same kind }
      nnode := Form1.ExplorerNew.GetFirstChild(cnode);
      while Assigned(nnode) do begin
        data1 := Form1.ExplorerNew.GetNodeData(nnode);
        if data1.ImageIndex = image then begin
          FoundIndex := data1.StateIndex;
          break;
        end;
        nnode := Form1.ExplorerNew.GetNextSibling(nnode);
      end;

      if FoundIndex <> -1 then begin
        if AnsiCompareStr(data1.Text,ANumber) <> 0 then begin
          Form1.frmSMEdit.CopyContactsConflict(Self,AName,
            _('Contact already exists in SIM Memory but has a different phone number specified.'),
            ANumber,data1.Text,_('Phone Memory'),_('SIM Memory'),Answer);
          case Answer of
            0: dl.Delete(FoundIndex); // copy Phone -> SIM
            1: begin
              inc(SkpCnt);
              exit; // keep SIM one
            end;
            else Abort;
          end;
          {
          case MessageDlgW(WideFormat(_('Contact "%s" already exists in SIM book.')+sLinebreak+sLinebreak,[AName])+
            WideFormat(_('Do you want to replace [%s] with [%s]?'),[data1.Text,ANumber]),
            mtConfirmation, MB_YESNOCANCEL or MB_DEFBUTTON2) of
            ID_YES: dl.Delete(FoundIndex);
            ID_NO: begin
              inc(SkpCnt);
              exit;
            end;
            ID_CANCEL: Abort;
          end;
          }
        end
        else begin
          inc(SkpCnt);
          exit; // number found but is the same, so exit
        end;
      end;
    end;
    { Sanity check phone number length }
    i := Form1.frmSMEdit.FMaxTelLen + byte(Pos('+',ANumber) <> 0);
    j := Length(ANumber);
    if j < i then i := j;
    ANumber := Copy(ANumber,1+j-i,i);
    { Add to SIM database }
    if Kind <> '' then Kind := '/' + Kind;
    utf8s := UTF8Encode(WideQuoteStr(AName + Kind, True));
    dl.Add(utf8s + ',' + WideStringToLongString(ANumber) + ',' + IntToStr(cpos) + ',1,' + // and mark (1) as modified
      GUIDToString(NewGUID)+','); // No LUID
    if FoundIndex = -1 then inc(NewCnt) else inc(UpdCnt);
  end;
begin
  if MessageDlgW(WideFormat(_('Confirm sending %d %s to SIM Memory?'),
    [ListNumbers.SelectedCount,ngettext('contact','contacts',ListNumbers.SelectedCount)]),
    mtConfirmation,MB_YESNO) <> ID_YES then
    exit;
  Form1.frmSMEdit.ResetConflictState;
  Answer := 0;
  NewCnt := 0;
  UpdCnt := 0;
  SkpCnt := 0;
  data2 := Form1.ExplorerNew.GetNodeData(Form1.FNodeContactsSM);
  dl := TStrings(data2.Data); // destination
  (*
  if dl.Count <> 0 then
    case MessageDlgW(_('Do you want to DELETE all SIM entries before copy? (No Undo)'),
      mtConfirmation, MB_YESNOCANCEL or MB_DEFBUTTON2) of
      ID_YES: begin
        { Clear SIM database }
        dl.Clear;
        Form1.ExplorerNew.DeleteChildren(Form1.FNodeContactsSM);
      end;
      ID_CANCEL: exit;
    end;
  *)
  try
    with ListNumbers do begin
      node := GetFirst;
      while Assigned(Node) do begin
        if Selected[node] then
          try
            contact := GetNodeData(node);
            cname := contact^.cname;
            cname := Copy(cname,1,Form1.frmSMEdit.FMaxNameLen);
            if contact^.pnumb  <> '' then AddNumber(cname,contact^.ptype,contact^.pnumb);   // do not localize
          except
            if Cardinal(dl.Count) >= Form1.frmSMEdit.FMaxNumbers then break;
          end;
        node := GetNext(node);
      end;
    end;
  finally
    if (NewCnt <> 0) or (UpdCnt <> 0) then begin
      Form1.RenderContactList(Form1.FNodeContactsSM);
      { Update view }
      Form1.frmSMEdit.RenderData(Form1.FNodeContactsSM);
    end;
    Form1.Status(WideFormat(_('Copy to SIM card: %d new, %d modified and %d items skipped'),
      [NewCnt, UpdCnt, SkpCnt]));
  end;
end;

procedure TfrmContactsMEEdit.Modified1Click(Sender: TObject);
begin
  DoForceSelectedAs(1);
end;

procedure TfrmContactsMEEdit.DoForceSelectedAs(State: integer);
var
  Item: PSIMData;
  Node: PVirtualNode;
begin
  ListNumbers.BeginUpdate;
  Node := ListNumbers.GetFirst;
  while Node <> nil do
  try
    if ListNumbers.Selected[Node] then begin
      item := ListNumbers.GetNodeData(Node);
      if item.imageindex <> 0 then item.imageindex := State;
    end;
  finally
    Node := ListNumbers.GetNext(Node);
  end;
  ListNumbers.EndUpdate;
  UpdatePhonebook;
end;

procedure TfrmContactsMEEdit.frmSyncPhonebookNewNoUndo2Click(
  Sender: TObject);
begin
  DoForceSelectedAs(0);
end;

end.

