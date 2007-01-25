unit uSIMEdit;

{
*******************************************************************************
* Descriptions: SIM Card Phonebook Edit Implementation
* $Source: /cvsroot/fma/fma/uSIMEdit.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uSIMEdit.pas,v $
*
*******************************************************************************
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls,
  Forms, TntForms, Dialogs, TntDialogs, Grids, TntComCtrls, TntGrids, ExtCtrls, TntExtCtrls, StdCtrls, TntStdCtrls, Math,
  Menus, TntMenus, VirtualTrees, ImgList, uSyncPhonebook, uPromptConflict, uConflictChanges, Placemnt;

type
  TSIMData = Record
    imageindex: integer; {0=new,1=modified,2=deleted,3=normal}
    position: integer;
    cname,pnumb,ptype: WideString;
    CDID: TGUID;
    LUID : WideString;
  end;
  PSIMData = ^TSIMData;

  TfrmContactsSMEdit = class(TTntFrame)
    Panel1: TTntPanel;
    btnUpdateSIM: TTntButton;
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
    CopySelectedToPhone1: TTntMenuItem;
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
    procedure CopySelectedToPhone1Click(Sender: TObject);
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
    procedure btnUpdateSIMClick(Sender: TObject);
    procedure btnDELClick(Sender: TObject);
    procedure btnEDITClick(Sender: TObject);
    procedure Modified1Click(Sender: TObject);
    procedure frmSyncPhonebookNewNoUndo1Click(Sender: TObject);
  private
    { Private declarations }
    FContact: TContactData; // used for SIM contact editing (uEditContact)
    FExplore: PVirtualNode; // remember last rendered data's explorer node
    FOldText: String;
    function IsUniqueGUID(who: PSIMData): boolean;
    function FindFreePos: integer;
    procedure FullRefresh;
    procedure UpdateSIM(MaxItems: cardinal = 0);
    procedure RenderGUIDs;
  protected
    { Protected declarations }
    FConflictPhone0,FConflictPhone1: string;
    FConflictAnswer: integer;
    FRendered: Boolean;
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
    procedure CopySelectedToME;
    procedure CopySelectedToIRMC;
    procedure CopyContactsConflict(Sender: TObject; ContactName: WideString; const Description: WideString;
      Phone0,Phone1: string; const Item0Name, Item1Name: WideString; var SelectedItem: Integer);
    procedure OnConflictChanges(Sender: TObject; const TargetName, Option1Name, Option2Name: WideString);
    procedure ResetConflictState;
  end;

implementation

uses
  gnugettext, gnugettexthelpers, cUnicodeCodecs,
  uLogger, uThreadSafe, Unit1, uSMS, uGlobal, uEditContact, uConnProgress, uVcard, uXML, WebUtil, uDialogs;

{$R *.dfm}

{ TfrmContactsSMEdit }

constructor TfrmContactsSMEdit.Create(AOwner: TComponent);
begin
  inherited;
  { Set defaults }
  FMaxNameLen := 14; FMaxTelLen := 80; FMaxNumbers := 200;
  FRendered := False;
end;

function TfrmContactsSMEdit.RenderData(ForceDBNode: PVirtualNode): boolean;
var
  sl: TStrings;
  s: WideString;
  i: Integer;
  contact: PSIMData;
  Node: PVirtualNode;
  EData: PFmaExplorerNode;
  Modified,NeedRefresh: Boolean;
begin
  ResetConflictState;
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
    Form1.Status(WideFormat(_('Please refresh %s from phone, because some contact positions are missing!'),
      [EData.Text]));
  Result := Modified;
end;

procedure TfrmContactsSMEdit.Button1Click(Sender: TObject);
begin
  if not Form1.FConnected then Form1.ActionConnectionConnectExecute(Self);

  Form1.ActionContactsDownloadExecute(Self);
  RenderData;
end;

procedure TfrmContactsSMEdit.UpdateSIM(MaxItems: cardinal);
var
  PerformCleanup: boolean;
  i,maxPos,numType: Integer;
  name, number: WideString;
  w, buf: string;
  Item: PSIMData;
  Node: PVirtualNode;
  frmConnect: TfrmConnect;
  target: string;
begin
  if IsMEMode then
    target := _('Phonebook')
  else
    target := _('SIM');
  PerformCleanup := MaxItems = ListNumbers.RootNodeCount;
  Form1.RequestConnection;
  Log.AddSynchronizationMessageFmt(_('Update %s started.'),[target]);
  frmConnect := GetProgressDialog;
  try
    if Form1.CanShowProgress then
      frmConnect.ShowProgress(Form1.FProgressLongOnly);
    if MaxItems > 0 then
      frmConnect.Initialize(MaxItems,WideFormat(_('Updating %s'),[target]))
    else
      frmConnect.SetDescr(WideFormat(_('Updating %s'),[target]));
    Form1.Status(_('Uploading contacts...'));
    maxPos := 0;
    try
      if IsMEMode then
        Form1.TxAndWait('AT+CPBS="ME"')  // do not localize
      else
        Form1.TxAndWait('AT+CPBS="SM"'); // do not localize
      try
        Node := ListNumbers.GetFirst;
        while Assigned(Node) and not ThreadSafe.AbortDetected do
        try
          item := ListNumbers.GetNodeData(Node);
          if (item.imageindex <> 3) or cbForce.Checked then begin
            numType := 129;
            Name := item.cname;
            Number := item.pnumb;

            if maxPos <= item.position then maxPos := item.position;

            buf := 'AT+CPBW=' + IntToStr(item.position); // do not localize
            if Item.imageindex = 2 then begin
              // Delete
              Log.AddSynchronizationMessageFmt(_('%s deleted in %s by FMA.'),[Name, target], lsInformation);
              Form1.TxAndWait(buf);
            end
            else begin
              // Update
              if Number[1] = '+' then begin
                Number := copy(Number, 2, Length(Number)-1);
                numType := 145;
              end;

              if Form1.FUseUTF8 then w := UTF8Encode(Name)
                else w := name;

              { Notes:
              
                - If phone is the currently selected phonebook storage, <text> will be
                  interpreted as "first name" + white space + "last name" when stored in
                  the hierarchical phonebook. The phone number will be stored as of type
                  "other".
                  
                - When writing to SM, <text> shall be written as "last name" + comma +
                  white space + "first name" + "/" + <type_of_number>.
                  Example: "Smith, John/W"

                  <type_of_number> Description
                      "H" Home     Default setting
                      "W" Work
                      "O" Other
                      "M" Mobile
                      "F" Fax
              }
              if IsMEMode then begin
                if (Length(w) < (FMaxNameLen-1)) and (item.ptype <> '') then
                case item.ptype[1] of
                  'M': w := w + '/M'; // do not localize
                  'H': w := w + '/H'; // do not localize
                  'W': w := w + '/W'; // do not localize
                  'F': w := w + '/F'; // do not localize
                  'O': w := w + '/O'; // do not localize
                end;
              end
              else begin
                { HACK! remove obsolete '/O' from SIM entries, added by previous FMA releases }
                i := Length(w);
                if (i > 2) and (w[i-1] = '/') and (Char(w[i]) in ['M','H','W','F','O']) then // do not localize
                  Delete(w,i-1,2);
              end;

              { First clear the position }
              try
                Form1.TxAndWait(buf);
              except
              end;

              { Next upload it }
              buf := buf + ',"' + Number + '",' + IntToStr(numType) + ',"' + w + '"';
              Form1.TxAndWait(buf);
              Log.AddSynchronizationMessageFmt(_('%s stored in %s by FMA.'),[Name, target], lsInformation);
              Item.imageindex := 3;
            end;
          end;
        finally
          frmConnect.IncProgress(1);
          Node := ListNumbers.GetNext(Node);
          ListNumbers.Repaint;
        end;
        { Ususaly happens when you rearrange contacts positions, i.e. modify all of them }
        if PerformCleanup then
        try
          Form1.Status(_('Performing cleanup...'));
          frmConnect.SetDescr(_('Performing cleanup'));
          frmConnect.ClearMaxProgress;
          Form1.SetTaskPercentage(0, FMaxNumbers - Cardinal(maxPos));
          for i := maxPos + 1 to FMaxNumbers do
          try
            Form1.SetTaskPercentageInc;
            buf := 'AT+CPBW=' + IntToStr(i); // do not localize
            Form1.TxAndWait(buf);
          except
          end;
        finally
          Form1.SetTaskPercentage(-1);
        end;
        {}
      finally
        UpdatePhonebook;
      end;
    except
      Form1.Status(_('Error updating memory'));
      Log.AddSynchronizationMessageFmt(_('Update %s failed.'),[target], lsError);
    end;
    if not ThreadSafe.AbortDetected then
      Log.AddSynchronizationMessageFmt(_('Updating %s completed.'),[target])
    else
      Log.AddSynchronizationMessage(_('Update aborted.'));
  finally
    FreeProgressDialog;
  end;
  Form1.Status('');
end;

procedure TfrmContactsSMEdit.btnUpdateSIMClick(Sender: TObject);
var
  Item: PSIMData;
  Node: PVirtualNode;
  mcount,dcount,count: cardinal;
  s: WideString;
begin
  mcount := 0; dcount := 0;

  Node := ListNumbers.GetFirst;
  while Node <> nil do
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
    s := '';
    if mcount <> 0 then
      s := WideFormat(ngettext('%d modified contact', '%d modified contacts', mcount), [mcount]);
    if dcount <> 0 then
      s := WideFormat('%s and %d %s', [s, dcount, ngettext('deleted contact', 'deleted contacts', dcount)]);
    case MessageDlgW(WideFormat(_('Confirm sending %s to phone?'),[s]), mtConfirmation, MB_YESNOCANCEL) of
      ID_YES: UpdateSIM(count);
      ID_CANCEL: Abort;
    end;
  end;
end;

procedure TfrmContactsSMEdit.btnResetClick(Sender: TObject);
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

procedure TfrmContactsSMEdit.StringGridGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  FOldText := Value;
end;

procedure TfrmContactsSMEdit.btnDELClick(Sender: TObject);
var
  Item: PSIMData;
  Node,Tmp: PVirtualNode;
  s: WideString;
begin
  if ListNumbers.SelectedCount = 0 then exit;
  s := WideFormat(_('Deleting %d %s.'), [ListNumbers.SelectedCount,ngettext('contact','contacts',ListNumbers.SelectedCount)]);
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

procedure TfrmContactsSMEdit.Resetchangeflag1Click(Sender: TObject);
begin
  DoForceSelectedAs(3);
end;

function TfrmContactsSMEdit.GetCapacity(Target, LogName: string): Integer;
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

procedure TfrmContactsSMEdit.OnConnected;
begin
  FMaxNumbers := GetCapacity('SM','SIM Book');
end;

procedure TfrmContactsSMEdit.ListNumbersAfterPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas);
begin
  NoItemsPanel.Visible := ListNumbers.RootNodeCount = 0;
end;

procedure TfrmContactsSMEdit.ListNumbersCompareNodes(Sender: TBaseVirtualTree;
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

procedure TfrmContactsSMEdit.ListNumbersGetImageIndex(Sender: TBaseVirtualTree;
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

procedure TfrmContactsSMEdit.ListNumbersGetText(Sender: TBaseVirtualTree;
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

procedure TfrmContactsSMEdit.ListNumbersHeaderClick(Sender: TVTHeader;
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

procedure TfrmContactsSMEdit.btnEDITClick(Sender: TObject);
var
  Node :PVirtualNode;
begin
  Node := ListNumbers.FocusedNode;
  if Node <> nil then begin
    SelContact := ListNumbers.GetNodeData(Node);
    DoEdit;
  end;
end;

procedure TfrmContactsSMEdit.PopupMenu1Popup(Sender: TObject);
begin
  Properties1.Enabled := ListNumbers.SelectedCount = 1;
  DownloadEntirePhonebook1.Enabled := Form1.FConnected and not Form1.FObex.Connected;
  CopySelectedToPhone1.Enabled := ListNumbers.SelectedCount <> 0;
end;

function TfrmContactsSMEdit.DoEdit(AsNew: boolean; NewNumber: string): boolean;
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
        if not IsMEMode or (Selcontact^.ptype = '') then
          FContact.cell := Selcontact^.pnumb
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
          try
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
              if not IsMEMode or (Selcontact^.ptype = '') then
                Selcontact^.pnumb := FContact.cell
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
                raise Exception.Create(_('No free position available'));
              end
              else
                Result := True;
            end
            else
              if Selcontact^.imageindex <> 0 then begin // mark as modified
                Selcontact^.imageindex := 1;
                Result := True;
              end;
          except;
            if IsNew then DeleteNode(Node);
            raise;
          end;
          UpdatePhonebook;
        finally
          EndUpdate;
        end;
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

procedure TfrmContactsSMEdit.NewPerson1Click(Sender: TObject);
begin
  if ListNumbers.RootNodeCount < FMaxNumbers then
    DoEdit(True)
  else
    ShowMessageW(_('No more space in memory! New contact can not be created.'));
end;

procedure TfrmContactsSMEdit.UpdateChanged1Click(Sender: TObject);
begin
  cbForce.Checked := False;
  btnUpdateSIM.Click;
end;

procedure TfrmContactsSMEdit.UpdateAllRecords1Click(Sender: TObject);
begin
  cbForce.Checked := True;
  btnUpdateSIM.Click;
end;

function TfrmContactsSMEdit.FindFreePos: integer;
var
  Node :PVirtualNode;
  Item: PSIMData;
  Pos: cardinal;
  found: boolean;
begin
  Pos := 1;
  while Pos <= FMaxNumbers do begin
    found := false;
    Node := ListNumbers.GetFirst;
    while Node <> nil do
    try
      item := ListNumbers.GetNodeData(Node);
      if cardinal(item.position) = Pos then begin
        found := true;
        break;
      end;
    finally
      Node := ListNumbers.GetNext(Node);
    end;
    if not found then break;
    Pos := Pos + 1;
  end;
  if Pos <= FMaxNumbers then Result := Pos
    else Result := -1;
end;

procedure TfrmContactsSMEdit.UpdateContactsPosition1Click(Sender: TObject);
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

function TfrmContactsSMEdit.IsMEMode: boolean;
begin
  Result := False; // was... FExplore = Form1.FNodeContactsME;
end;

procedure TfrmContactsSMEdit.UpdatePhonebook;
begin
  if IsMEMode then
    Form1.UpdateMEPhonebook
  else
    Form1.UpdateSMPhonebook;
end;

function TfrmContactsSMEdit.IsRendered: boolean;
begin
  { Do we have rendered data from currently selected Eplorer node? (ME or SM) }
  //Result := FRendered and (IsMEMode = (Form1.Explorer.Selected = Form1.FNodeContactsME));
  Result := FRendered;
end;

procedure TfrmContactsSMEdit.CheckForChanges;
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

procedure TfrmContactsSMEdit.ListNumbersIncrementalSearch(
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

procedure TfrmContactsSMEdit.ImportContacts1Click(Sender: TObject);
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

function TfrmContactsSMEdit.FindContact(FullName: WideString;
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

function TfrmContactsSMEdit.FindContact(FullName: WideString;
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

function TfrmContactsSMEdit.FindContact(FullName, NumberType: WideString;
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

procedure TfrmContactsSMEdit.ExportList(FileType: Integer; Filename: WideString);
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

procedure TfrmContactsSMEdit.DownloadEntirePhonebook1Click(Sender: TObject);
begin
  if MessageDlgW(_('Local Phonebook will be replaced with a fresh copy from the phone.'+sLinebreak+sLinebreak+
    'Any local changes will be lost. Do you wish to continue?'),
    mtConfirmation, MB_YESNO or MB_DEFBUTTON2) = ID_YES then begin
      ListNumbers.Clear;
      FullRefresh;
    end;
end;

procedure TfrmContactsSMEdit.ListNumbersKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (ListNumbers.SelectedCount = 1) then
    btnEditClick(nil);
end;

procedure TfrmContactsSMEdit.FullRefresh;
begin
  Form1.ActionContactsDownload.Execute;
  UpdatePhonebook;
end;

procedure TfrmContactsSMEdit.FormStorage1SavePlacement(Sender: TObject);
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

procedure TfrmContactsSMEdit.FormStorage1RestorePlacement(Sender: TObject);
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

procedure TfrmContactsSMEdit.ListNumbersHeaderMouseUp(Sender: TVTHeader;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FormStorage1SavePlacement(nil);
end;

function TfrmContactsSMEdit.FindContact(Number: WideString): WideString;
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

procedure TfrmContactsSMEdit.RenderGUIDs;
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

function TfrmContactsSMEdit.IsUniqueGUID(who: PSIMData): boolean;
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

procedure TfrmContactsSMEdit.Modified1Click(Sender: TObject);
begin
  DoForceSelectedAs(1);
end;

procedure TfrmContactsSMEdit.CopySelectedToPhone1Click(Sender: TObject);
begin
  if Form1.IsIrmcSyncEnabled then
    CopySelectedToIRMC
  else
    CopySelectedToME;
end;

procedure TfrmContactsSMEdit.CopySelectedToIRMC;
var
  Item: PSIMData;
  Node,NewNode: PVirtualNode;
  Contact: PContactData;
  NewCnt,UpdCnt: cardinal;
  s,T,N: WideString;
  i,j,Answer: integer;
  procedure AddNumber(AName: WideString; ANumber: string);
  begin
    { If contact already exists? }
    if Form1.frmSyncPhonebook.FindContact(AName,contact) then begin
      { Check if the number already exists for that contact
      O := GetContactPhoneType(contact,s); // get type if number found in ME contact
      if O = '' then T := item.ptype
        else T := O;
      }
      T := item.ptype;
      {}
      if T = 'W' then N := contact^.work  else // do not localize
      if T = 'H' then N := contact^.home  else // do not localize
      if T = 'F' then N := contact^.fax   else // do not localize
      if T = 'O' then N := contact^.other else // do not localize
        N := contact^.cell; // Default to '' or 'M' phone type
      { Number position already filled in? }
      if N <> '' then
        if AnsiCompareStr(N,ANumber) <> 0 then begin
          CopyContactsConflict(Self,GetContactFullName(contact),
            _('Contact already exists in Phone Memory but has a different phone number specified.'),
            N,ANumber,_('Phone Memory'),_('SIM Memory'),Answer);
          case Answer of
            0: exit; // keep Phone one
            1: ; // copy SIM -> Phone
            else Abort;
          end;
          {
          case MessageDlgW(WideFormat(_('Contact "%s" already exists in Phone.')+sLinebreak+sLinebreak,[item.cname])+
            WideFormat(_('Do you want to replace [%s] with [%s]?'),[N,s]),
            mtConfirmation, MB_YESNOCANCEL or MB_DEFBUTTON2) of
            ID_NO: begin
              //inc(SkpCnt);
              exit;
            end;
            ID_CANCEL: Abort;
          end;
          }
        end
        else
          exit; // number found but is the same, so skip
      if T = 'W' then contact^.work := ANumber  else // do not localize
      if T = 'H' then contact^.home := ANumber  else // do not localize
      if T = 'F' then contact^.fax := ANumber   else // do not localize
      if T = 'O' then contact^.other := ANumber else // do not localize
        contact^.cell := ANumber;
      contact^.StateIndex := 1; // contact modified
      inc(UpdCnt);
    end
    else
    if Form1.frmSyncPhonebook.ListContacts.RootNodeCount < Form1.frmSyncPhonebook.FMaxRecME then begin
      NewNode := Form1.frmSyncPhonebook.ListContacts.AddChild(nil);
      contact := Form1.frmSyncPhonebook.ListContacts.GetNodeData(NewNode);
      FillChar(contact^,SizeOf(contact^),0);
      contact^.cell := ANumber;
      contact^.StateIndex := 0; // new contact
      s := Copy(AName,1,Form1.frmSyncPhonebook.FMaxNameLen+byte(Pos(' ',AName) <> 0)); // sanity check name length
      j := Pos(', ',s);
      if j = 0 then begin
        j := Pos(' ',s);
        if j = 0 then
          contact^.name := s
        else begin
          contact^.name := Copy(s,1,j-1);
          contact^.surname := Copy(s,j+1,Length(s)-j);
        end;
      end
      else begin
        contact^.surname := Copy(s,1,j-1);
        contact^.name := Copy(s,j+2,Length(s)-j-1);
      end;
      inc(NewCnt);
    end
    else
      Abort;
  end;
begin
  ResetConflictState;
  Answer := 0;
  NewCnt := 0;
  UpdCnt := 0;
  try
    with ListNumbers do begin
      Node := GetFirst;
      while Assigned(Node) do begin
        if Selected[Node] then
          try
            item := GetNodeData(Node);
            { Sanity check phone number length }
            i := Form1.frmSyncPhonebook.FMaxTellen;
            if Length(item.pnumb) < i then i := Length(item.pnumb);
            s := Copy(item.pnumb,1+Length(item.pnumb)-i,i);
            if s <> '' then AddNumber(item.cname,s);
          except
            if Form1.frmSyncPhonebook.ListContacts.RootNodeCount >= Form1.frmSyncPhonebook.FMaxRecME then break;
          end;
        Node := GetNext(Node);
      end;
    end;
  finally
    if (NewCnt + UpdCnt) <> 0 then Form1.UpdateMEPhonebook;
    Form1.Status(WideFormat(_('Copy to Phone: %d new, %d modified and %d items skipped'),
      [NewCnt, UpdCnt, Cardinal(ListNumbers.SelectedCount) - NewCnt - UpdCnt]));
  end;
end;

procedure TfrmContactsSMEdit.CopySelectedToME;
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
    i,j,image,FoundIndex: Integer;
    utf8s: String;
  begin
    if Cardinal(dl.Count) >= Form1.frmMEEdit.FMaxNumbers then Abort;
    FoundIndex := -1;

    { Try to locate contact }
    cnode := Form1.FindExplorerChildNode(AName,Form1.FNodeContactsME);
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
          CopyContactsConflict(Self,data1.Text,
            _('Contact already exists in Phone Memory but has a different phone number specified.'),
            data1.Text,ANumber,_('Phone Memory'),_('SIM Memory'),Answer);
          case Answer of
            0: begin
              inc(SkpCnt);
              exit; // keep Phone one
            end;
            1: dl.Delete(FoundIndex); // copy SIM -> Phone
            else Abort;
          end;
          {
          case MessageDlgW(WideFormat(_('Contact "%s" already exists in Phone book.')+sLinebreak+sLinebreak,[AName])+
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
    i := Form1.frmMEEdit.FMaxTelLen + byte(Pos('+',ANumber) <> 0);
    j := Length(ANumber);
    if j < i then i := j;
    ANumber := Copy(ANumber,1+j-i,i);
    { Add to SIM database }
    if Kind <> '' then Kind := '/' + Kind;
    utf8s := UTF8Encode(WideQuoteStr(AName + Kind, True));
    dl.Add(utf8s + ',' + WideStringToLongString(ANumber) + ',' + IntToStr(dl.Count+1) + ',1,' + // and mark (1) as modified
      GUIDToString(NewGUID)+','); // No LUID
    if FoundIndex = -1 then inc(NewCnt) else inc(UpdCnt);
  end;
begin
  ResetConflictState;
  Answer := 0;
  NewCnt := 0;
  UpdCnt := 0;
  SkpCnt := 0;
  data2 := Form1.ExplorerNew.GetNodeData(Form1.FNodeContactsME);
  dl := TStrings(data2.Data); // destination
  (*
  if dl.Count <> 0 then
    case MessageDlgW(_('Do you want to DELETE all Phone entries before copy? (No Undo)'),
      mtConfirmation, MB_YESNOCANCEL or MB_DEFBUTTON2) of
      ID_YES: begin
        { Clear SIM database }
        dl.Clear;
        Form1.ExplorerNew.DeleteChildren(Form1.FNodeContactsME);
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
            cname := Copy(cname,1,Form1.frmMEEdit.FMaxNameLen);
            if contact^.pnumb  <> '' then AddNumber(cname,contact^.ptype,contact^.pnumb);   
          except
            if Cardinal(dl.Count) >= Form1.frmMEEdit.FMaxNumbers then break;
          end;
        node := GetNext(node);
      end;
    end;
  finally
    if (NewCnt <> 0) or (UpdCnt <> 0) then begin
      Form1.RenderContactList(Form1.FNodeContactsME);
      { Update view }
      Form1.frmMEEdit.RenderData(Form1.FNodeContactsME);
    end;
    Form1.Status(WideFormat(_('Copy to Phone: %d new, %d modified and %d items skipped'),
      [NewCnt, UpdCnt, SkpCnt]));
  end;
end;

procedure TfrmContactsSMEdit.CopyContactsConflict(Sender: TObject;
  ContactName: WideString; const Description: WideString; Phone0,
  Phone1: string; const Item0Name, Item1Name: WideString;
  var SelectedItem: Integer);
begin
  if FConflictAnswer = 2 then begin // ask me?
    frmPromptConflict := TfrmPromptConflict.Create(Self);
    try
      FConflictPhone0 := Phone0;
      FConflictPhone1 := Phone1;
      { Default frmPromptConflict.ObjKind is 'contact' }
      frmPromptConflict.ObjName := ContactName;
      frmPromptConflict.Info := Description;
      frmPromptConflict.Item0Name := Item0Name;
      frmPromptConflict.Item1Name := Item1Name;
      frmPromptConflict.SelectedItem := SelectedItem;
      frmPromptConflict.OnViewChanges := OnConflictChanges;
      frmPromptConflict.CanBeAborted := True;
      if frmPromptConflict.ShowModal = mrOK then begin
        SelectedItem := frmPromptConflict.SelectedItem;
        if frmPromptConflict.cbDontAskAgain.Checked then begin
          { Use the same answer for all next conflicts }
          FConflictAnswer := SelectedItem;
        end;
      end
      else
        SelectedItem := -1;
    finally
      frmPromptConflict.Free;
    end;
  end
  else
    SelectedItem := FConflictAnswer;
end;

procedure TfrmContactsSMEdit.OnConflictChanges(Sender: TObject;
  const TargetName, Option1Name, Option2Name: WideString);
begin
  with TfrmConflictChanges.Create(nil) do
  try
    Target := TargetName;
    Option1 := Option1Name;
    Option2 := Option2Name;

    if AnsiCompareStr(FConflictPhone0,FConflictPhone1) <> 0 then
      AddChange(_('Number'),FConflictPhone0,FConflictPhone1);

    if ChangeCount <> 0 then ShowModal
      else MessageDlgW(_('No changes found.'), mtInformation, MB_OK);
  finally
    Free;
  end;
end;

procedure TfrmContactsSMEdit.ResetConflictState;
begin
  FConflictAnswer := 2;
end;

procedure TfrmContactsSMEdit.DoForceSelectedAs(State: integer);
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

procedure TfrmContactsSMEdit.frmSyncPhonebookNewNoUndo1Click(
  Sender: TObject);
begin
  DoForceSelectedAs(0);
end;

end.

