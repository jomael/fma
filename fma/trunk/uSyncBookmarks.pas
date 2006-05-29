unit uSyncBookmarks;

{
*******************************************************************************
* Descriptions: Phone Info view implementation
* $Source: /cvsroot/fma/fma/uSyncBookmarks.pas,v $
* $Locker:  $
*
* Todo:
* - Create a custmo view for bookmarks, custom popup menu, custom Properties.
*
* Change Log:
* $Log: uSyncBookmarks.pas,v $
* Revision 1.4.2.12  2006/03/12 13:04:31  z_stoichev
* New UTF8 Codec usage.
*
* Revision 1.4.2.11  2006/01/16 11:26:57  mhr3
* Form1.Explorer -> Form1.ExplorerNew
*
* Revision 1.4.2.10  2005/12/12 21:40:48  mhr3
* fixed access violation when deleting bookmark
*
* Revision 1.4.2.9  2005/09/20 14:44:57  z_stoichev
* Changed Confirmations default button to NO.
*
* Revision 1.4.2.8  2005/09/19 13:16:51  z_stoichev
* Properties Toolbar button initial click issue fixed.
*
* Revision 1.4.2.7  2005/09/19 12:19:04  z_stoichev
* Added Command line switch "/fixdb" to clean DB.
*
* Revision 1.4.2.6  2005/09/18 21:40:52  z_stoichev
* - Added Bookmarks sync Force As popup menu commands.
* - Fixed Bookmarks sync editor multi-select support.
*
* Revision 1.4.2.5  2005/09/16 14:18:49  z_stoichev
* Fixed typos.
*
* Revision 1.4.2.4  2005/09/15 15:06:58  z_stoichev
* Sync Bookmarks changes.
*
* Revision 1.4.2.3  2005/09/14 15:24:05  z_stoichev
* Bookmarks sync.
*
* Revision 1.4.2.2  2005/09/13 20:25:54  z_stoichev
* Started 'real' bookmarks sync implementation.
*
* Revision 1.4.2.1  2005/08/24 14:36:18  z_stoichev
* - Synchronization display messages are uniform now.
*
* Revision 1.4  2005/02/19 12:51:01  lordlarry
* Changed Log Messages Category and Severity (Removing the SyncLog method)
*
* Revision 1.3  2005/02/18 16:18:23  z_stoichev
* Intermediate bugfixes - not finished work, sorry no time!
*
* Revision 1.2  2005/02/08 15:38:55  voxik
* Merged with L10N branch
*
* Revision 1.1.2.2  2005/02/02 23:15:54  voxik
* Changed MessageDlg and ShowMessages replaced by new unicode versions
*
* Revision 1.1.2.1  2005/01/07 18:04:01  expertone
* Merge with MAIN branch
*
* Revision 1.1  2004/12/23 15:52:29  z_stoichev
* Sync Bookmarks started.
* Bugfixes.
*
*
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics,
  Controls, TntControls, Forms, TntForms, Dialogs, TntDialogs, Placemnt, VirtualTrees, ExtCtrls, TntExtCtrls,
  Menus, TntMenus, uConnProgress;

resourcestring
  sHomePageLocked = 'Could not change WAP home page!'+sLinebreak+sLinebreak+
      'In certain terminals a number of WAP profiles may be locked at '+
      'manufacturing to prevent the users from altering the predefined WAP settings. When such a '+
      'profile is active some of the commands in this ensemble will not function according to '+
      'specification. The read and test commands should always function as expected but the set '+
      'command will return ERROR even though the command is given using the correct syntax and '+
      'all parameters are within range.';

type
  TBookmarkStatus = (bsNew, bsModified, bsDeleted, bsNormal);

  TBookmarkData = Record
    status: TBookmarkStatus;
    position: integer;
    title,url: WideString;
    id: TGUID; // HASH for original title and url values as loaded from phone first time!
               // This will be used to detect any changes made in phone for that bookmark.
  end;
  PBookmarkData = ^TBookmarkData;

  TfrmSyncBookmarks = class(TTntFrame)
    ListBookmarks: TVirtualStringTree;
    FormStorage1: TFormStorage;
    NoItemsPanel: TTntPanel;
    PopupMenu1: TTntPopupMenu;
    Properties1: TTntMenuItem;
    N1: TTntMenuItem;
    Delete1: TTntMenuItem;
    NewBookmark1: TTntMenuItem;
    N3: TTntMenuItem;
    OpenTargetLocation1: TTntMenuItem;
    N5: TTntMenuItem;
    DownloadEntireList1: TTntMenuItem;
    N6: TTntMenuItem;
    Import1: TTntMenuItem;
    Export1: TTntMenuItem;
    SyncTo1: TTntMenuItem;
    InternetExplorer1: TTntMenuItem;
    SetasHomePage1: TTntMenuItem;
    N2: TTntMenuItem;
    Firefox1: TTntMenuItem;
    Opera1: TTntMenuItem;
    WAPHomePage1: TTntMenuItem;
    N8: TTntMenuItem;
    SynchrinizePhone1: TTntMenuItem;
    N4: TTntMenuItem;
    N7: TTntMenuItem;
    ForceAs1: TTntMenuItem;
    NotModified1: TTntMenuItem;
    Modified1: TTntMenuItem;
    NewNoUndo1: TTntMenuItem;
    procedure FormStorage1RestorePlacement(Sender: TObject);
    procedure FormStorage1SavePlacement(Sender: TObject);
    procedure ListBookmarksAfterPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas);
    procedure ListBookmarksCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure ListBookmarksGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure ListBookmarksGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure ListBookmarksHeaderClick(Sender: TVTHeader;
      Column: TColumnIndex; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer);
    procedure ListBookmarksHeaderMouseUp(Sender: TVTHeader;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ListBookmarksKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OpenTargetLocation1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure DownloadEntireList1Click(Sender: TObject);
    procedure SetasHomePage1Click(Sender: TObject);
    procedure SynchrinizePhone1Click(Sender: TObject);
    procedure NotModified1Click(Sender: TObject);
    procedure Modified1Click(Sender: TObject);
    procedure NewNoUndo1Click(Sender: TObject);
    procedure btnSYNCClick(Sender: TObject);
    procedure btnNEWClick(Sender: TObject);
    procedure btnEDITClick(Sender: TObject);
    procedure btnDELClick(Sender: TObject);
  private
    { Private declarations }
    FRendered: boolean;
    PhoneData: TBookmarkData;
    FFmaBData: PBookmarkData;
    FSyncDialog: TfrmConnect;
    FMaxItems,FMaxTitleLen,FMaxUrlLen,FMaxHomeLen: Cardinal;
    function GetBookmarksCapacity: Integer;
    function GetHomePageCapacity: Integer;
    function ResolveConflict(NameContact: WideString; Info:WideString): integer;
    function Synchronize: boolean;
    procedure GetPhoneBookmarks(var sl: TStringList);
    procedure FullRefresh;
    procedure ForceContact(State: TBookmarkStatus);
  protected
    procedure DoUploadBookmark(Item: PBookmarkData; DeleteOld: boolean = False);
    procedure DoDeleteBookmark(Item: PBookmarkData);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure RenderList;
    procedure UpdateBookmarks;
    procedure OnConnected;
    procedure LoadBookmarks(FileName:WideString);
    procedure SaveBookmarks(FileName:WideString);
    function FindBookmark(Position: integer; var Data: PBookmarkData): PVirtualNode;
    function FindBookmarkID(AID: TGUID; var Data: PBookmarkData): PVirtualNode;
    function FindBookmarkUrl(AURL: WideString; var Data: PBookmarkData): PVirtualNode;
    function FindBookmarkTitle(ATitle: WideString; var Data: PBookmarkData): PVirtualNode;

    function DoEdit(Node: PVirtualNode): boolean;
    procedure OnConflictChanges(Sender: TObject; const TargetName, Option1Name, Option2Name: WideString);
  published
    property IsRendered: boolean read FRendered write FRendered;
    property MaxHomePageLength: Cardinal read FMaxHomeLen;
  end;

var
  frmSyncBookmarks: TfrmSyncBookmarks;

function SameBookmarkIDs(Data1,Data2: PBookmarkData): boolean;
function IsThisBookmark(ID: TGUID; Data: PBookmarkData): boolean;
function IsBookmarkModified(Data: PBookmarkData): boolean;
function GetBookmarkNewID(Data: PBookmarkData): TGUID;
procedure SetBookmarkStatus(Data: PBookmarkData; Status: TBookmarkStatus);

implementation

{$R *.dfm}

uses
  gnugettext, gnugettexthelpers, cUnicodeCodecs,
  uLogger, ShellAPI, TntComCtrls, Unit1, uGlobal, uPostURL, uDialogs,
  uInfoView, uPromptConflict, uThreadSafe, uConflictChanges, Math;

function SameBookmarkIDs(Data1,Data2: PBookmarkData): boolean;
begin
  Result := CompareMem(@(Data1^.id),@(Data2^.id),SizeOf(Data1^.id));
end;

function IsThisBookmark(ID: TGUID; Data: PBookmarkData): boolean;
begin
  Result := CompareMem(@ID,@(Data^.id),SizeOf(ID));
end;

function IsBookmarkModified(Data: PBookmarkData): boolean;
var
  g: TGUID;
begin
  g := GetBookmarkNewID(Data);
  Result := not CompareMem(@g,@(Data^.id),SizeOf(g));
end;

function GetBookmarkNewID(Data: PBookmarkData): TGUID;
var
  g: TGUID;
  i,s: Integer;
  w: WideString;
  p: PChar;
begin
  p := @g;
  w := Data^.title + '|' + Data^.url;
  s := SizeOf(g);
  FillChar(g,s,0);
  for i := 0 to Length(w) do begin
    (p + i mod s)^ := PChar(@w[i])^;
  end;
  Result := g;
end;

procedure SetBookmarkStatus(Data: PBookmarkData; Status: TBookmarkStatus);
begin
  case Status of
    bsNew:
      FillChar(Data^.id,SizeOf(Data^.id),0);
    bsModified,
    bsDeleted:
      Data^.status := Status;
    bsNormal:
      Data^.id := GetBookmarkNewID(Data);
  end;
end;

{ TfrmSyncBookmarks }

function TfrmSyncBookmarks.Synchronize: boolean;
var
  sl: TStringList;
  i: Integer;
  g: TBookmarkData;
  Item,Data: PBookmarkData;
  Node: PVirtualNode;
  PhoneOnPC,PhoneModified,PhoneDeleted: boolean;
  PhoneSpecialMod: Set of Byte;
  procedure UpdatePositions(PosDeleted: Integer);
  var
    Node: PVirtualNode;
    Data: PBookmarkData;
    bpos: byte;
  begin
    Node := ListBookmarks.GetFirst;
    while Assigned(Node) do begin
      Data := ListBookmarks.GetNodeData(Node);
      if Assigned(Data) then
        if Data.position > PosDeleted then begin
          bpos := byte(Data.position);
          if bpos in PhoneSpecialMod then
            PhoneSpecialMod := PhoneSpecialMod - [bpos] + [bpos-1];
          Data.position := Data.position-1;
        end;
      Node := ListBookmarks.GetNext(Node)
    end;
  end;
  function LocalInPhone(Data: PBookmarkData): boolean;
  var
    bd: TBookmarkData;
  begin
    i := 0;
    while i < sl.Count do begin
      FillChar(bd,SizeOf(bd),0);
      bd.status := bsNormal;
      bd.position := StrToInt(GetToken(sl[i],0));
      bd.url := GetToken(sl[i],1);
      bd.title := UTF8StringToWideString(GetToken(sl[i],2));
      bd.id := GetBookmarkNewID(@bd);
      if SameBookmarkIDs(Data,@bd) then
        break;
      inc(i);
    end;
    Result := i < sl.Count;
  end;
  function DelAndGetNext(Node: PVirtualNode): PVirtualNode;
  var
    Prev: PVirtualNode;
  begin
    Prev := Node;
    Result := ListBookmarks.GetNext(Node);
    ListBookmarks.DeleteNode(Prev);
  end;
  procedure ShowProgressTarget(AName: WideString);
  begin
    if Assigned(FSyncDialog) then
      FSyncDialog.SetDescr(_('Synchronizing phone bookmarks')+sLinebreak+'('+AName+')');
  end;
begin
  Result := False;
  Form1.RequestConnection;
  sl := TStringList.Create;
  try
    { First process phone changes }
    PhoneSpecialMod := [];
    GetPhoneBookmarks(sl);
    for i := 0 to sl.Count-1 do begin
      FillChar(PhoneData,SizeOf(PhoneData),0);
      PhoneData.status := bsNormal;
      PhoneData.position := StrToInt(GetToken(sl[i],0));
      PhoneData.url := GetToken(sl[i],1);
      PhoneData.title := UTF8StringToWideString(GetToken(sl[i],2));
      PhoneData.id := GetBookmarkNewID(@PhoneData);
      Log.AddSynchronizationMessage('Debug: Processing phone bookmark '+PhoneData.title, lsDebug);
      { Locate Bookmark in FMA }
      Node := FindBookmarkID(PhoneData.id,Data); // modified both title and url in FMA? (phone item not modified)
      if not Assigned(Node) then
        Node := FindBookmarkUrl(PhoneData.url,Data); // modified title in FMA?
      if not Assigned(Node) then
        Node := FindBookmarkTitle(PhoneData.title,Data); // modified url in FMA?
      if not Assigned(Node) then begin
        Node := FindBookmark(PhoneData.position,Data); // modified phone-title and fma-url? (or reverse)
        if Assigned(Node) then begin
          { Try to lookup local bookmark using unchanged fields in both instances }
          FillChar(g,SizeOf(g),0);
          g.title := PhoneData.title;
          g.url := Data.url;
          g.id := GetBookmarkNewID(@g);
          if not SameBookmarkIDs(@g,Data) then begin
            g.title := Data.title;
            g.url := PhoneData.url;
            g.id := GetBookmarkNewID(@g);
            if not SameBookmarkIDs(@g,Data) then
              Node := nil;
          end;
          { Remember fixed-changes positions, if any }
          if Assigned(Node) then
            PhoneSpecialMod := PhoneSpecialMod + [byte(PhoneData.position)];
        end;
      end;
      { Bookmark found? }
      if Node <> nil then begin
        { yes, check if it is modified in phone }
        PhoneModified := not SameBookmarkIDs(Data,@PhoneData); // Data.id = Hash of original phone values
        if PhoneModified then
          ShowProgressTarget(Data.title);
        Data.position := PhoneData.position; // update bookmark position in phone
        FFmaBData := nil; // used for conflicts details
        case Data.status of
          bsNew,
          bsModified: begin
            if PhoneModified then begin
              FFmaBData := Data;
              PhoneOnPC := ResolveConflict(Data.title, _('is modified on phone and modified on pc.')) = 0;
              if PhoneOnPC then begin
                Data^ := PhoneData;
                SetBookmarkStatus(Data,bsNormal);
                Log.AddSynchronizationMessage(Data.title + _(' modified in FMA by phone.'), lsInformation);
              end;
            end;
          end;
          bsDeleted: begin
            if PhoneModified then begin
              PhoneOnPC := ResolveConflict(Data.title, _('is modified on phone and deleted on pc.')) = 0;
              if PhoneOnPC then begin
                Data^ := PhoneData;
                SetBookmarkStatus(Data,bsNormal);
                Log.AddSynchronizationMessage(Data.title + _(' modified in FMA by phone.'), lsInformation);
              end;
            end;
          end;
          bsNormal: begin
            if PhoneModified then begin
              Data^ := PhoneData;
              SetBookmarkStatus(Data,bsNormal); 
              Log.AddSynchronizationMessage(Data.title + _(' modified in FMA by phone.'), lsInformation);
            end;
          end;
        end;
      end
      else begin
        { no, it is a new bookmark in phone }
        ShowProgressTarget(PhoneData.title);
        Node := ListBookmarks.AddChild(nil);
        Item := ListBookmarks.GetNodeData(Node);
        Item^ := PhoneData;
        SetBookmarkStatus(Item,bsNormal);
        Log.AddSynchronizationMessage(PhoneData.title + _(' added to FMA by phone.'), lsInformation);
      end;
    end;

    { Next process FMA changes }
    Node := ListBookmarks.GetFirst;
    while Assigned(Node) do begin
      Data := ListBookmarks.GetNodeData(Node);
      if Assigned(Data) then begin
        Log.AddSynchronizationMessage('Debug: Processing FMA bookmark '+Data.title, lsDebug);
        { if we're checking mixed-changed position, it is in Phone for sure }
        if byte(Data.position) in PhoneSpecialMod then
          PhoneDeleted := False
        else
          { check if bookmark is deleted in phone? }
          PhoneDeleted := not LocalInPhone(Data);
        if PhoneDeleted or (Data.status <> bsNormal) then
          ShowProgressTarget(Data.title);
        FFmaBData := nil; // used for conflicts details
        case Data.status of
          bsNew: begin
            DoUploadBookmark(Data);
            SetBookmarkStatus(Data,bsNormal);
            Log.AddSynchronizationMessage(Data.title + _(' added in phone by FMA.'), lsInformation);
          end;
          bsModified: begin
            if PhoneDeleted then begin
              PhoneOnPC := ResolveConflict(Data.title, _('is deleted on phone and modified on pc.')) = 0;
              if PhoneOnPC then begin
                Node := DelAndGetNext(Node);
                Log.AddSynchronizationMessage(Data.title + _(' deleted in FMA by phone.'), lsInformation);
                continue;
              end;
            end;
            DoUploadBookmark(Data,not PhoneDeleted);
            SetBookmarkStatus(Data,bsNormal);
            if PhoneDeleted then
              Log.AddSynchronizationMessage(Data.title + _(' added in phone by FMA.'), lsInformation)
            else begin
              UpdatePositions(Data.position);
              Log.AddSynchronizationMessage(Data.title + _(' modified in phone by FMA.'), lsInformation);
            end;  
          end;
          bsDeleted: begin
            if not PhoneDeleted then begin
              DoDeleteBookmark(Data);
              SetBookmarkStatus(Data,bsNormal);
              UpdatePositions(Data.position);
            end;
            Node := DelAndGetNext(Node);
            if not PhoneDeleted then
              Log.AddSynchronizationMessage(Data.title + _(' deleted in phone by FMA.'), lsInformation);
            continue;
          end;
          bsNormal: begin
            if PhoneDeleted then begin
              Node := DelAndGetNext(Node);
              Log.AddSynchronizationMessage(Data.title + _(' deleted in FMA by phone.'), lsInformation);
              continue;
            end;
          end;
        end;
      end;
      Node := ListBookmarks.GetNext(Node);
    end;
  finally
    sl.Free;
    { Update list }
    FullRefresh;
  end;
end;

procedure TfrmSyncBookmarks.FormStorage1RestorePlacement(Sender: TObject);
var
  s: widestring;
  i: integer;
begin
  s := FormStorage1.StoredValue['ListHeader']; // do not localize
  if s <> '' then
    try
      with ListBookmarks.Header do begin
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

procedure TfrmSyncBookmarks.FormStorage1SavePlacement(Sender: TObject);
var
  s: string;
  i: integer;
begin
  with ListBookmarks.Header do begin
    s := IntToStr(SortColumn)+','+IntToStr(Ord(SortDirection));
    for i := 0 to Columns.Count-1 do
      s := s+','+IntToStr(Columns[i].Width)+','+IntToStr(Columns[i].Position);
  end;
  FormStorage1.StoredValue['ListHeader'] := s; // do not localize
end;

procedure TfrmSyncBookmarks.btnNEWClick(Sender: TObject);
var
  Node: PVirtualNode;
  Item: PBookmarkData;
begin
  if ListBookmarks.ChildCount[nil] >= FMaxItems then begin
    ShowMessageW(_('No more space in phone memory!'+sLinebreak+'I''m sorry.'));
    Exit;
  end;
  frmBookmark := TfrmBookmark.Create(nil);
  try
    frmBookmark.TntEdit1.MaxLength := FMaxTitleLen;
    frmBookmark.TntMemo1.MaxLength := FMaxUrlLen;
    if frmBookmark.ShowModal = mrOk then begin
      Node := ListBookmarks.AddChild(nil);
      Item := ListBookmarks.GetNodeData(Node);
      FillChar(Item^,SIzeOf(TBookmarkData),0);
      Item.title := frmBookmark.BookmarkTitle;
      Item.url := frmBookmark.BookmarkURL;
      Item.status := bsNew;
      UpdateBookmarks;
      Form1.Status(_('Bookmark created'));
    end;
  finally
    FreeAndNil(frmBookmark);
  end;
end;

procedure TfrmSyncBookmarks.btnDELClick(Sender: TObject);
var
  Node: PVirtualNode;
  Item: PBookmarkData;
  s: WideString;
begin
  if ListBookmarks.SelectedCount = 0 then exit;
  s := WideFormat(_('Deleting %d %s.'), [ListBookmarks.SelectedCount,ngettext('bookmark','bookmarks',ListBookmarks.SelectedCount)]);
  if MessageDlgW(s+_(' Do you wish to continue?'), mtConfirmation, MB_YESNO	or MB_DEFBUTTON2) <> ID_YES then
    exit;
  Node := ListBookmarks.GetFirst;
  while Assigned(Node) do begin
    if ListBookmarks.Selected[Node] then begin
      Item := ListBookmarks.GetNodeData(Node);
      if Item.position <> 1 then begin // bookmark at pos 1 is reserved
        if Item.status = bsNew then ListBookmarks.DeleteNode(Node)
          else Item.status := bsDeleted;
      end
      else begin
        ListBookmarks.FocusedNode := Node;
        MessageDlgW(_('Bookmark 1 is reserved and should not be deleted.')+sLineBreak+sLineBreak+
          _('Hint: You could probably edit it directlly in your phone.'),
          mtError, MB_OK);
        Abort;
      end;
    end;
    Node := ListBookmarks.GetNext(Node);
  end;
  UpdateBookmarks;
  Form1.Status(_('Delete completed'));
end;

procedure TfrmSyncBookmarks.btnEDITClick(Sender: TObject);
var
  Node :PVirtualNode;
begin
  Node := ListBookmarks.FocusedNode;
  if Assigned(Node) then
    DoEdit(Node);
end;

function TfrmSyncBookmarks.DoEdit(Node: PVirtualNode): boolean;
var
  Item: PBookmarkData;
begin
  Result := False;
  frmBookmark := TfrmBookmark.Create(nil);
  try
    frmBookmark.TntEdit1.MaxLength := FMaxTitleLen;
    frmBookmark.TntMemo1.MaxLength := FMaxUrlLen;
    if Node <> nil then begin
      Item := ListBookmarks.GetNodeData(Node);
      if Item.position <> 1 then begin
        frmBookmark.BookmarkTitle := Item.title;
        frmBookmark.BookmarkURL := Item.url;
        if frmBookmark.ShowModal = mrOk then begin
          if (WideCompareStr(Item.title,frmBookmark.BookmarkTitle) <> 0) or
            (WideCompareStr(Item.url,frmBookmark.BookmarkURL) <> 0) then begin
            Item.title := frmBookmark.BookmarkTitle;
            Item.url := frmBookmark.BookmarkURL;
            Item.status := bsModified;
            UpdateBookmarks;
            Form1.Status(_('Bookmark changed'));
            Result := True;
          end;  
        end;
      end
      else begin
        MessageDlgW(_('Bookmark 1 is reserved and should not be edited.')+sLineBreak+sLineBreak+
          _('Hint: You could probably edit it directlly in your phone.'),
          mtError, MB_OK);
        Abort;
      end;
    end;
  finally
    FreeAndNil(frmBookmark);
  end;
end;

procedure TfrmSyncBookmarks.RenderList;
var
  sl: TStrings;
  i,bindex,bstate: integer;
  s,btitle,burl,bid: WideString;
  Item: PBookmarkData;
  Node: PVirtualNode;
  EData: PFmaExplorerNode;
begin
  try
    ListBookmarks.BeginUpdate;
    ListBookmarks.Clear;
    ListBookmarks.NodeDataSize := sizeof(TBookmarkData);
    try
      EData := Form1.ExplorerNew.GetNodeData(Form1.FNodeBookmarks);
      sl := EData.Data;
      for i := 0 to sl.Count-1 do begin
        s := sl[i];
        if Trim(s) = '' then continue;
        Node := ListBookmarks.AddChild(nil);
        try
          bindex := StrToInt(GetToken(sl[i],0));
          burl := UTF8StringToWideString(GetToken(sl[i],1));
          btitle := UTF8StringToWideString(GetToken(sl[i],2));
          try
            bstate := StrToInt(GetToken(sl[i],3));
          except
            bstate := Ord(bsNormal);
          end;
          try
            bid := GetToken(sl[i],4);
          except
            bid := '';
          end;

          item := ListBookmarks.GetNodeData(Node);
          FillChar(item^,SizeOf(TBookmarkData),0);
          with item^ do begin
            status := TBookmarkStatus(bstate);
            position := bindex;
            title := btitle;
            url := burl;
            try
              if bid <> '' then id := StringToGUID(bid) else Abort;
            except
              id := GetBookmarkNewID(item);
            end;
          end;
        except
          ListBookmarks.DeleteNode(Node);
          Log.AddMessageFmt(_('Database: Error loading data (DB Index %d)'), [i], lsError);
          if FindCmdLineSwitch('FIXDB') then begin
            sl[i] := '';
            Log.AddMessageFmt(_('Database: Removed incorrect data (DB Index: %d)'), [i], lsInformation);
          end;
        end;
      end;
      FRendered := True;
    finally
      ListBookmarks.EndUpdate;
      ListBookmarks.Sort(nil, ListBookmarks.Header.SortColumn, ListBookmarks.Header.SortDirection);
    end;
  except
  end;
end;

procedure TfrmSyncBookmarks.ListBookmarksAfterPaint(
  Sender: TBaseVirtualTree; TargetCanvas: TCanvas);
begin
  NoItemsPanel.Visible := ListBookmarks.ChildCount[nil] = 0;
end;

procedure TfrmSyncBookmarks.ListBookmarksCompareNodes(
  Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode;
  Column: TColumnIndex; var Result: Integer);
var
  BM1, BM2: PBookmarkData;
begin
  BM1 := Sender.GetNodeData(Node1);
  BM2 := Sender.GetNodeData(Node2);

  if Column = 0 then begin
    if BM1.position > BM2.position then
      Result := 1
    else
      if BM1.position < BM2.position then
        Result := -1
      else
        Result := 0;
  end
  else if Column = 1 then Result := WideCompareStr(BM1.title, BM2.title)
  else if Column = 2 then Result := WideCompareStr(BM1.url, BM2.url);
end;

procedure TfrmSyncBookmarks.ListBookmarksGetImageIndex(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
  Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
//var BM: PBookmarkData;
begin
  if Column = 0 then begin
    if (Kind = ikNormal) or (Kind = ikSelected) then begin
      { Do not show different icons depending on item state (for now) }
      //BM := Sender.GetNodeData(Node);
      //ImageIndex := BM.imageindex;
      ImageIndex := 59;
    end
    else ImageIndex := -1;
  end;
end;

procedure TfrmSyncBookmarks.ListBookmarksGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  BM: PBookmarkData;
begin
  BM := Sender.GetNodeData(Node);

  if Column = 0 then begin
    if BM.position > 0 then
      CellText := IntToStr(BM.position)
    else
      CellText := ''; // new bookmark - has not position yet
  end
  else
  if Column = 1 then CellText := BM.title
  else
  if Column = 2 then CellText := BM.url
  else
  if Column = 3 then begin
    CellText := '';
    case BM.status of
      bsNew: CellText := _('New bookmark');
      bsModified: CellText := _('Modified bookmark');
      bsDeleted: CellText := _('Deleted bookmark');
      bsNormal: CellText := '';
    end;
  end;
end;

procedure TfrmSyncBookmarks.ListBookmarksHeaderClick(Sender: TVTHeader;
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
    ListBookmarks.Sort(nil, ListBookmarks.Header.SortColumn, ListBookmarks.Header.SortDirection);
  end;
end;

procedure TfrmSyncBookmarks.ListBookmarksHeaderMouseUp(Sender: TVTHeader;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FormStorage1SavePlacement(nil);
end;

procedure TfrmSyncBookmarks.ListBookmarksKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (ListBookmarks.SelectedCount = 1) then
    btnEditClick(nil);
end;

procedure TfrmSyncBookmarks.btnSYNCClick(Sender: TObject);
var
  Err: WideString;
begin
  Form1.ActionSyncBookmarks.Enabled := False;
  FSyncDialog := GetProgressDialog;
  try
    if Form1.CanShowProgress then
      FSyncDialog.ShowProgress(Form1.FProgressLongOnly);
    FSyncDialog.SetDescr(_('Synchronizing phone bookmarks'));
    Form1.Status(_('Start Sync Phone Bookmarks....'));
    Log.AddSynchronizationMessage('Sync Phone Bookmarks started.');
    try
      //Start the sync process
      Synchronize; //(Form1.FBookmarkRootFolder);
      Form1.Status(_('Sync Phone Bookmarks completed.'));
      Log.AddSynchronizationMessage('Sync Phone Bookmarks completed.');
    except
      on E: Exception do begin
        Err := WideFormat(_('Error: Sync Phone Bookmarks aborted - %s'), [E.Message]);
        Form1.Status(Err);
        Log.AddSynchronizationMessage(Err, lsError);
      end;
    end;
  finally
    FreeProgressDialog;
    FSyncDialog := nil;
    ListBookmarks.Sort(nil, ListBookmarks.Header.SortColumn, ListBookmarks.Header.SortDirection);
    ListBookmarks.Update;
    Form1.ActionSyncBookmarks.Enabled := True;
  end;
end;

procedure TfrmSyncBookmarks.OpenTargetLocation1Click(Sender: TObject);
var
  BM: PBookmarkData;
begin
  BM := ListBookmarks.GetNodeData(ListBookmarks.FocusedNode);
  ShellExecute(Handle,'open',PChar(string(BM.url)),'','',SW_SHOWNORMAL); // do not localize
end;

procedure TfrmSyncBookmarks.PopupMenu1Popup(Sender: TObject);
begin
  Properties1.Enabled := ListBookmarks.SelectedCount = 1;
  OpenTargetLocation1.Enabled := Properties1.Enabled;
  DownloadEntireList1.Enabled := Form1.FConnected and not Form1.FObex.Connected;
  SetasHomePage1.Enabled := DownloadEntireList1.Enabled and Properties1.Enabled and (FMaxHomeLen <> 0);
end;

function TfrmSyncBookmarks.FindBookmark(Position: integer; var Data: PBookmarkData): PVirtualNode;
var
  Node: PVirtualNode;
  Item: PBookmarkData;
begin
  Result := nil;
  Node := ListBookmarks.GetFirst;
  while Node <> nil do begin
    Item := ListBookmarks.GetNodeData(Node);
    if Item.position = Position then begin
      Result := Node;
      Data := Item;
      break;
    end;
    Node := ListBookmarks.GetNext(Node);
  end;
end;

procedure TfrmSyncBookmarks.DoDeleteBookmark(Item: PBookmarkData);
begin
  Form1.TxAndWait('AT*EWBA='+IntToStr(Item.Position)+','); // do not localize
end;

procedure TfrmSyncBookmarks.GetPhoneBookmarks(var sl: TStringList);
var
  j: integer;
  it: TStringList;
  s: WideString;
  bindex,btitle,burl: WideString;
begin
  if Form1.frmInfoView.Visible then Form1.EBCAState(False);
  { Retrieve Bookmarks now }
  sl.Clear;
  it := TStringList.Create;
  try
    Form1.TxAndWait('AT*EWBA?'); // do not localize
    it.Text := ThreadSafe.RxBuffer.Text;
    for j := 0 to it.Count - 2 do begin
      if pos('*EWBA', it[j]) = 1 then begin // do not localize
        s := it[j];
        if Form1.FUseUTF8 then s := UTF8StringToWideString(s);
        System.Delete(s,1,7);
        bindex := GetToken(s,0);
        burl := GetToken(s,1);
        btitle := GetToken(s,2);
        sl.Add(bindex+','+burl+','+WideStringToUTF8String(btitle)+','+IntToStr(Ord(bsNormal)));
      end;
    end;
  finally
    it.Free;
    if Form1.frmInfoView.Visible then Form1.EBCAState(True);
  end;
end;

function TfrmSyncBookmarks.ResolveConflict(NameContact, Info: WideString): integer;
begin
  Result := Form1.FSyncBookmarkPrio;
  if Result = 2 then begin // ask me?
    Result := 0;
    frmPromptConflict := TfrmPromptConflict.Create(Self);
    try
      { Default frmPromptConflict.ObjKind is 'contact' }
      frmPromptConflict.ObjKind := _('The Bookmark:');
      frmPromptConflict.ObjName := NameContact;
      frmPromptConflict.Info := Info;
      if Assigned(FFmaBData) then
        frmPromptConflict.OnViewChanges := OnConflictChanges;
      if frmPromptConflict.ShowModal = mrOK then begin
        Result := frmPromptConflict.SelectedItem;
        if frmPromptConflict.cbDontAskAgain.Checked then begin
          Form1.FSyncBookmarkPrio := Result;
          Form1.FormStorage1.StoredValue['Sync Bookmarks'] := Form1.FSyncBookmarkPrio; // do not localize  
        end;
      end;
    finally
      frmPromptConflict.Free;
    end;
  end;  
end;

function TfrmSyncBookmarks.FindBookmarkUrl(AURL: WideString; var Data: PBookmarkData): PVirtualNode;
var
  Node: PVirtualNode;
  Item: PBookmarkData;
begin
  Result := nil;
  Node := ListBookmarks.GetFirst;
  while Node <> nil do begin
    Item := ListBookmarks.GetNodeData(Node);
    if WideCompareStr(Item.url,AURL) = 0 then begin
      Result := Node;
      Data := Item;
      break;
    end;
    Node := ListBookmarks.GetNext(Node);
  end;
end;

function TfrmSyncBookmarks.FindBookmarkTitle(ATitle: WideString; var Data: PBookmarkData): PVirtualNode;
var
  Node: PVirtualNode;
  Item: PBookmarkData;
begin
  Result := nil;
  Node := ListBookmarks.GetFirst;
  while Node <> nil do begin
    Item := ListBookmarks.GetNodeData(Node);
    if (WideCompareText(Item.title,ATitle) = 0) then begin
      Result := Node;
      Data := Item;
      break;
    end;
    Node := ListBookmarks.GetNext(Node);
  end;
end;

function TfrmSyncBookmarks.FindBookmarkID(AID: TGUID; var Data: PBookmarkData): PVirtualNode;
var
  Node: PVirtualNode;
  Item: PBookmarkData;
begin
  Result := nil;
  Node := ListBookmarks.GetFirst;
  while Node <> nil do begin
    Item := ListBookmarks.GetNodeData(Node);
    if IsThisBookmark(AID,Item) then begin
      Result := Node;
      Data := Item;
      break;
    end;
    Node := ListBookmarks.GetNext(Node);
  end;
end;

procedure TfrmSyncBookmarks.DoUploadBookmark(Item: PBookmarkData; DeleteOld: boolean);
var
  bu,bt: WideString;
begin
  if Form1.FUseUTF8 then begin
    bt := WideStringToUTF8String(item.title);
    bu := WideStringToUTF8String(item.url);
  end
  else begin
    bt := item.Title;
    bu := item.URL;
  end;
  if DeleteOld then
    Form1.TxAndWait('AT*EWBA='+IntToStr(Item.position)+','); // do not localize
  Form1.TxAndWait('AT*EWBA=0,"'+bu+'","'+bt+'"'); // do not localize
end;

procedure TfrmSyncBookmarks.OnConflictChanges(Sender: TObject;
  const TargetName, Option1Name, Option2Name: WideString);
begin
  with TfrmConflictChanges.Create(nil) do
  try
    Target := TargetName;
    Option1 := Option1Name;
    Option2 := Option2Name;

    if WideCompareStr(PhoneData.title,FFmaBData^.title) <> 0 then
      AddChange(_('Title'),PhoneData.title,FFmaBData^.title);
    if WideCompareStr(PhoneData.url,FFmaBData^.url) <> 0 then
      AddChange(_('Location'),PhoneData.url,FFmaBData^.url);

    if ChangeCount <> 0 then ShowModal
      else MessageDlgW(_('No changes found.'), mtInformation, MB_OK);
  finally
    Free;
  end;

end;

procedure TfrmSyncBookmarks.FullRefresh;
var
  sl: TStringList;
  i: Integer;
  EData: PFmaExplorerNode;
begin
  EData := Form1.ExplorerNew.GetNodeData(Form1.FNodeBookmarks);
  sl := TStringList(EData.Data);
  sl.Clear;
  GetPhoneBookmarks(sl);
  for i := 0 to sl.Count-1 do begin
    FillChar(PhoneData,SizeOf(PhoneData),0);
    PhoneData.status := bsNormal;
    PhoneData.position := StrToInt(GetToken(sl[i],0));
    PhoneData.url := GetToken(sl[i],1);
    PhoneData.title := UTF8StringToWideString(GetToken(sl[i],2));
    PhoneData.id := GetBookmarkNewID(@PhoneData);
    sl[i] := sl[i] + ',' + GUIDToString(PhoneData.id);
  end;
  Form1.RenderBookmarkList(Form1.FNodeBookmarks);
  RenderList;
end;

procedure TfrmSyncBookmarks.UpdateBookmarks;
var
  Node: PVirtualNode;
  Item: PBookmarkData;
  sl: TStringList;
  EData: PFmaExplorerNode;
begin
  EData := Form1.ExplorerNew.GetNodeData(Form1.FNodeBookmarks);
  sl := TStringList(EData.Data);
  sl.Clear;
  Node := ListBookmarks.GetFirst;
  while Assigned(Node) do begin
    Item := ListBookmarks.GetNodeData(Node);
    sl.Add(IntToStr(Item.position)+',"'+WideStringToUTF8String(Item.url)+'","'+WideStringToUTF8String(Item.title)+'",'+
      IntToStr(Ord(Item.status))+','+GUIDToString(Item.id));
    Node := ListBookmarks.GetNext(Node);
  end;
  Form1.RenderBookmarkList(Form1.FNodeBookmarks);
end;

procedure TfrmSyncBookmarks.DownloadEntireList1Click(Sender: TObject);
begin
  if MessageDlgW(_('Local bookmarks will be replaced with a fresh copy from the phone.'+
    sLinebreak+sLinebreak+
    'Any local changes will be lost. Do you wish to continue?'),
    mtConfirmation, MB_YESNO or MB_DEFBUTTON2) = ID_YES then begin
      ListBookmarks.Clear;
      FullRefresh;
    end;
end;

procedure TfrmSyncBookmarks.OnConnected;
begin
  FMaxItems := GetBookmarksCapacity;
  FMaxHomeLen := GetHomePageCapacity;
end;

function TfrmSyncBookmarks.GetBookmarksCapacity: Integer;
var
  i: Integer;
  buffer, stop: String;
  slTmp: TStrings;
begin
  Form1.TxAndWait('AT*EWBA=?'); // do not localize
  // defaults
  buffer := '';
  stop := '25'; FMaxTitleLen := 15; FMaxUrlLen := 120; 
  // *EWBA: (0, 2-25), 120, 15
  for i := 0 to ThreadSafe.RxBuffer.Count-1 do
    if Pos('*EWBA',ThreadSafe.RxBuffer.Strings[i]) = 1 then begin // do not localize
      buffer := ThreadSafe.RxBuffer.Strings[i];
      break;
    end;
  for i := 1 to length(buffer) do begin
    if IsDelimiter('()-,', buffer, i) then buffer[i] := ' ';
  end;
  // *EWBA:  0  2 25   120  15
  if buffer <> '' then begin
    slTmp := TStringList.Create;
    try
      slTmp.DelimitedText := buffer;
      stop := slTmp.Strings[slTmp.Count-3];
      Log.AddMessage('Bookmark: max entries = '+stop, lsDebug); // do not localize debug
      FMaxUrlLen := StrToInt(slTmp.Strings[slTmp.Count-2]);
      Log.AddMessage('Bookmark: max url length = '+slTmp.Strings[slTmp.Count-2], lsDebug); // do not localize debug
      FMaxTitleLen := StrToInt(slTmp.Strings[slTmp.Count-1]);
      Log.AddMessage('Bookmark: max title length = '+slTmp.Strings[slTmp.Count-1], lsDebug); // do not localize debug
    finally
      slTmp.Free;
    end;
  end;
  Result := StrToInt(stop);
end;

constructor TfrmSyncBookmarks.Create(AOwner: TComponent);
begin
  inherited;
  FMaxItems := 25; FMaxTitleLen := 15; FMaxUrlLen := 120; FMaxHomeLen := 120; 
end;

procedure TfrmSyncBookmarks.LoadBookmarks(FileName: WideString);
var
  sl : TStringList;
  EData: PFmaExplorerNode;
begin
  ListBookmarks.NodeDataSize := sizeof(TBookmarkData);
  EData := Form1.ExplorerNew.GetNodeData(Form1.FNodeBookmarks);
  sl := TStringList(EData.Data);
  sl.Clear;
  try
    sl.LoadFromFile(FileName);
  except
  end;
  FMaxItems := 25;
  FMaxUrlLen := 120;
  FMaxTitleLen := 15;
  FMaxHomeLen := 120;
  sl := TStringList.Create;
  try
    try
      sl.LoadFromFile(WideChangeFileExt(FileName,'.SYNC.dat')); // do not localize
      FMaxItems := StrToInt(sl[0]);
      FMaxUrlLen := StrToInt(sl[1]);
      FMaxTitleLen := StrToInt(sl[2]);
      FMaxHomeLen := StrToInt(sl[3]);
    except
    end;
  finally
    sl.Free;
    RenderList;
  end;
end;

procedure TfrmSyncBookmarks.SaveBookmarks(FileName: WideString);
var
  sl: TStrings;
  Node: PVirtualNode;
  Data: PBookmarkData;
begin
  sl := TStringList.Create;
  try
    with ListBookmarks do begin
      Node := GetFirst;
      while Assigned(Node) do begin
        try
          Data := GetNodeData(node);
          sl.Add(inttostr(Data.position) + ',"' + WideStringToUTF8String(Data.url) + '","' + WideStringToUTF8String(Data.title) +
            '",' + IntToStr(Ord(Data.status)) + ',' + GUIDToString(Data.id));
        except
        end;
        Node := GetNext(Node);
      end;
    end;
    sl.SaveToFile(FileName);
    sl.Clear;
    sl.Add(IntToStr(FMaxItems));
    sl.Add(IntToStr(FMaxUrlLen));
    sl.Add(IntToStr(FMaxTitleLen));
    sl.Add(IntToStr(FMaxHomeLen));
    sl.SaveToFile(WideChangeFileExt(FileName,'.SYNC.dat')); // do not localize
  finally
    sl.Free;
  end;
end;

procedure TfrmSyncBookmarks.SetasHomePage1Click(Sender: TObject);
var
  Data: PBookmarkData;
  s,d: WideString;
  i: Integer;
begin
  Data := ListBookmarks.GetNodeData(ListBookmarks.FocusedNode);
  { TODO: Unicode? }
  d := Copy(Data.url,1,FMaxHomeLen);
  if Form1.FUseUTF8 then d := WideStringToUTF8String(d);
  { Get current home page }
  Form1.TxAndWait('AT*EWHP?'); // do not localize
  for i := 0 to ThreadSafe.RxBuffer.Count-1 do
    if Pos('*EWHP',ThreadSafe.RxBuffer[i]) = 1 then begin
      s := ThreadSafe.RxBuffer[i];
      Delete(s,1,7);
      s := GetToken(s,0); // trim and remove quotes
      if WideCompareStr(s,d) = 0 then
        MessageDlgW('Nothing to change.',mtInformation,MB_OK)
      else  
      if MessageDlgW(WideFormat(_('Change WAP Hope Page from "%s" to "%s"?'),[s,d]),
        mtConfirmation, MB_OKCANCEL) = ID_OK then begin
        try
          Form1.TxAndWait('AT*EWHP="'+d+'"'); // do not localize
          Form1.Status(_('Home page changed'));
        except
          MessageDlgW(sHomePageLocked,mtError,MB_OK);
        end;
      end;
      break;
    end;
end;

function TfrmSyncBookmarks.GetHomePageCapacity: Integer;
var
  s: WideString;
  i: integer;
begin
  Result := 0;
  try
    Form1.TxAndWait('AT*EWHP=?'); // do not localize
    for i := 0 to ThreadSafe.RxBuffer.Count-1 do
      if Pos('*EWHP',ThreadSafe.RxBuffer[i]) = 1 then begin
        s := ThreadSafe.RxBuffer[i];
        Delete(s,1,7);
        Result := StrToInt(s);
        break;
      end;
  except
  end;
end;

procedure TfrmSyncBookmarks.SynchrinizePhone1Click(Sender: TObject);
begin
  Form1.ActionSyncBookmarks.Execute;
end;

procedure TfrmSyncBookmarks.ForceContact(State: TBookmarkStatus);
var
  node: PVirtualNode;
  data: PBookmarkData;
begin
  with ListBookmarks do
  try
    BeginUpdate;
    node := GetFirst;
    while Assigned(Node) do begin
      if Selected[node] then begin
        data := GetNodeData(node);
        if (data.status <> bsNew) and (data.position <> 1) then data.status := State;
      end;
      node := GetNext(node);
    end;
  finally
    EndUpdate;
  end;
end;

procedure TfrmSyncBookmarks.NotModified1Click(Sender: TObject);
begin
  ForceContact(bsNormal);
end;

procedure TfrmSyncBookmarks.Modified1Click(Sender: TObject);
begin
  ForceContact(bsModified);
end;

procedure TfrmSyncBookmarks.NewNoUndo1Click(Sender: TObject);
begin
  ForceContact(bsNew);
end;

end.

