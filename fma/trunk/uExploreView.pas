unit uExploreView;

{
*******************************************************************************
* Descriptions: Main Unit for FMA
* $Source: /cvsroot/fma/fma/uExploreView.pas,v $
* $Locker:  $
*
* Todo:
*   - add full popup menu
*
* Change Log:
* $Log: uExploreView.pas,v $
*
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms, Dialogs, TntDialogs,
  ExtCtrls, TntExtCtrls, VirtualTrees, TntComCtrls, Menus, TntMenus, Placemnt, uFiles;

type
  TfrmExplore = class(TTntFrame)
    ListItems: TVirtualStringTree;
    NoItemsPanel: TTntPanel;
    PopupMenu1: TTntPopupMenu;
    Explore1: TTntMenuItem;
    newmsg1: TTntMenuItem;
    newcall1: TTntMenuItem;
    N3: TTntMenuItem;
    Delete1: TTntMenuItem;
    N4: TTntMenuItem;
    Note1: TTntMenuItem;
    Bookmark1: TTntMenuItem;
    sms1: TTntMenuItem;
    person1: TTntMenuItem;
    download1: TTntMenuItem;
    FormStorage1: TFormStorage;
    Upload1: TTntMenuItem;
    N5: TTntMenuItem;
    Properties1: TTntMenuItem;
    N7: TTntMenuItem;
    ActivatePr1: TTntMenuItem;
    ChatContact1: TTntMenuItem;
    N1: TTntMenuItem;
    AddToPhonebook1: TTntMenuItem;
    NewGroup1: TTntMenuItem;
    N2: TTntMenuItem;
    NewAlarm1: TTntMenuItem;
    New1: TTntMenuItem;
    Advanced1: TTntMenuItem;
    EditSettings1: TTntMenuItem;
    NewItem1: TTntMenuItem;
    procedure ListItemsGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure ListItemsGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure Open1Click(Sender: TObject);
    procedure Properties1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure ListItemsDblClick(Sender: TObject);
    procedure FormStorage1RestorePlacement(Sender: TObject);
  private
    { Private declarations }
    FRootNode: PVirtualNode;
    procedure Set_RootNode(const Value: PVirtualNode);
    procedure NodeExplore(Node: PVirtualNode);
    procedure NodeProperties(Node: PVirtualNode);
  public
    { Public declarations }
    procedure RefreshView;
    function GetSelectedNode: PVirtualNode; // returns Form1.ExplorerNew's node!
    property RootNode: PVirtualNode read FRootNode write Set_RootNode default nil;
  end;

  TExploreItem = record
    name,descr,param: WideString;
    fNode: PVirtualNode; // ExplorerNew corresponding node
    fFile: TFile;
  end;
  PExploreItem = ^TExploreItem;

implementation

uses
  gnugettext, gnugettexthelpers,
  uGlobal, uDialogs, Unit1;

{$R *.dfm}

procedure TfrmExplore.Set_RootNode(const Value: PVirtualNode);
var
  w,s,col1,col2: WideString;
  Node, itNode: PVirtualNode;
  EData, rootData: PFmaExplorerNode;
  Item: PExploreItem;
  TreeNode: PVirtualNode;
  i: Integer;
begin
  FRootNode := Value;
  col1 := _('Type');
  col2 := _('Size');
  ListItems.BeginUpdate;
  try
    ListItems.Clear;
    ListItems.NodeDataSize := SizeOf(TExploreItem);
    rootData := Form1.ExplorerNew.GetNodeData(FRootNode);
    itNode := FRootNode.FirstChild;
    while itNode <> nil do begin
      if not (vsVisible in itNode.States) then begin
        itNode := itNode.NextSibling; // careful we have continue here
        continue; // skip default handler
      end;
      EData := Form1.ExplorerNew.GetNodeData(itNode);
      Node := ListItems.AddChild(nil);
      Node.Dummy := EData.ImageIndex;
      Item := ListItems.GetNodeData(Node);
      Item.name := EData.Text;
      Item.fNode := itNode; // remember ExplorerNew corresponding node
      if Node.Dummy in idxFolders then begin
        Item.descr := _('Folder');
        Item.param := '';
        Item.fFile := EData.Data;
        itNode := itNode.NextSibling; // careful we have continue here
        continue; // skip default handler
      end
      else
      if Node.Dummy in idxFiles then begin // see uFiles TIcon definition
        case TFiles.FindFileIcon(Item.name) of
          iWaveFile:  Item.descr := _('Wave Sound');
          iMidiFile:  Item.descr := _('Synthesed Sound');
          iImageFile: Item.descr := _('Picture');
          iThemeFile: Item.descr := _('Theme');
          else        Item.descr := _('File');
        end;
        Item.param := Format(_('%.1n Kb'),[EData.StateIndex / 1024]);
        Item.fFile := EData.Data;
        itNode := itNode.NextSibling; // careful we have continue here
        continue; // skip default handler
      end
      else
      case Node.Dummy of
        8: Item.descr := _('Contact');
        9..13: Item.descr := _('Phone number');
        18: begin
          Item.descr := _('Search');
          Item.param := IntToStr(EData.StateIndex+1);
          col2 := _('Position');
          itNode := itNode.NextSibling; // careful we have continue here
          continue; // skip default handler
        end;
        24: Item.descr := _('Profile');
        26,58: Item.descr := _('Group');
        59: Item.descr := _('Bookmark');
        53..55: begin // calls
          s := TStrings(rootData.Data)[EData.StateIndex-1];
          Item.descr := GetToken(s,1);
          col1 := _('When');
          col2 := _('Position');
        end;
        66: begin // alarms
          Item.descr := _('Alarm');
          col1 := _('Type');
          col2 := _('Recurrence');
          if EData.StateIndex <> -1 then begin
            s := TStringList(rootData.Data)[itNode.Index];
            s := GetToken(s,4);
          end
          else
            s := ''; // new alarm, which is canceled and will be deleted, see Form1.ActionToolsPostAlarmExecute()
          w := '';
          if s = '0' then w := _('All days in the week')
          else begin
            for i := 1 to 7 do
              if Pos(IntToStr(i),s) <> 0 then begin
                if w <> '' then w := w + ', ';
                case i of
                  1: w := w + _('Monday');
                  2: w := w + _('Tuesday');
                  3: w := w + _('Wednesday');
                  4: w := w + _('Thursday');
                  5: w := w + _('Friday');
                  6: w := w + _('Saturday');
                  7: w := w + _('Sunday');
                end;
            end;
          end;
          Item.param := w;
          itNode := itNode.NextSibling; // careful we have continue here
          continue; // skip default handler
        end;
        else
          Item.descr := _('Undefined');
      end;
      { default handler }
      if EData.StateIndex <> -1 then
        Item.param := IntToStr(EData.StateIndex)
      else
        Item.param := '';
      itNode := itNode.NextSibling;
    end;
  finally
    ListItems.Header.Columns[1].Text := col1;
    ListItems.Header.Columns[2].Text := col2;
    TreeNode := Form1.ExplorerNew.FocusedNode;
    while (TreeNode <> nil) and (Form1.ExplorerNew.GetNodeLevel(TreeNode) > 1) do
      TreeNode := TreeNode.Parent;
    if TreeNode = Form1.FNodeObex then
      ListItems.TreeOptions.SelectionOptions := ListItems.TreeOptions.SelectionOptions + [toMultiSelect]
    else
      ListItems.TreeOptions.SelectionOptions := ListItems.TreeOptions.SelectionOptions - [toMultiSelect];
    ListItems.EndUpdate;
    NoItemsPanel.Visible := FRootNode.ChildCount = 0;
  end;
end;

procedure TfrmExplore.ListItemsGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
begin
  if Column = 0 then
    if (Kind = ikNormal) or (Kind = ikSelected) then
      ImageIndex := Node.Dummy;
end;

procedure TfrmExplore.ListItemsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Item: PExploreItem;
begin
  Item := ListItems.GetNodeData(Node);
  case Column of
    0: CellText := Item.name;
    1: CellText := Item.descr;
    2: CellText := Item.param;
  end;
end;

procedure TfrmExplore.PopupMenu1Popup(Sender: TObject);
var
  Item: PExploreItem;
  Node, Child: PVirtualNode;
  EData: PFmaExplorerNode;
  IsSel: Boolean;
begin
  Properties1.Enabled := ListItems.SelectedCount <= 1;
  Explore1.Enabled := Properties1.Enabled;
  ActivatePr1.Enabled := False;
  EditSettings1.Enabled := False;
  if ListItems.SelectedCount = 1 then begin
    Node := ListItems.FocusedNode;
    if Node <> nil then begin
      Item := ListItems.GetNodeData(Node);
      Child := Form1.FindExplorerChildNode(Item.name);
      EData := Form1.ExplorerNew.GetNodeData(Child);
      if (Child <> nil) and (EData.ImageIndex = 24) then begin
        IsSel := WideCompareStr(EData.Text,Form1.cbProfile.Text) <> 0;
        ActivatePr1.Enabled := IsSel;
        EditSettings1.Enabled := not IsSel;
      end;
    end;
  end;
  { Set custom "New X..." popup menu option }
  NewItem1.Action := Form1.ActionToolsPostNote;
  if Form1.ExplorerNew.FocusedNode = Form1.FNodeGroups then NewItem1.Action := Form1.ActionToolsCreateGroup;
  if Form1.ExplorerNew.FocusedNode = Form1.FNodeAlarms then NewItem1.Action := Form1.ActionToolsPostAlarm;
  //NewItem1.Visible := Assigned(NewItem1.Action);  
end;

procedure TfrmExplore.Open1Click(Sender: TObject);
var
  Child: PVirtualNode;
begin
  Child := GetSelectedNode;
  if Child <> nil then NodeExplore(Child);
end;

procedure TfrmExplore.Properties1Click(Sender: TObject);
var
  Child: PVirtualNode;
begin
  Child := GetSelectedNode;
  if Assigned(Child) then NodeProperties(Child);
end;

procedure TfrmExplore.ListItemsDblClick(Sender: TObject);
var
  Child: PVirtualNode;
  CItem: PFmaExplorerNode;
begin
  Child := GetSelectedNode; // returns Form1.ExplorerNew's node, not ListItems's one
  CItem := Form1.ExplorerNew.GetNodeData(Child);
  if (Child.ChildCount = 0) and (Child <> Form1.FNodeCalendar) and
    (Child <> Form1.FNodeMsgInbox) and (Child <> Form1.FNodeMsgSent) and
    (Child <> Form1.FNodeMsgOutbox) and (Child <> Form1.FNodeMsgDrafts) and
    (Child <> Form1.FNodeMsgArchive) and not (CItem.ImageIndex in idxFolders) then
    NodeProperties(Child)
  else
    NodeExplore(Child);
end;

procedure TfrmExplore.NodeExplore(Node: PVirtualNode);
begin
  if Node <> Form1.ExplorerNew.FocusedNode then
  begin
    Form1.ExplorerNew.FocusedNode := Node;
    Form1.ExplorerNewChange(Form1.ExplorerNew, Form1.ExplorerNew.FocusedNode);
  end;
end;

procedure TfrmExplore.NodeProperties(Node: PVirtualNode);
begin
  Form1.ShowExplorerProperties(Node);
end;

function TfrmExplore.GetSelectedNode: PVirtualNode;
var
  Item: PExploreItem;
  Node: PVirtualNode;
  //Data: PFmaExplorerNode;
  //Name: WideString;
begin
  Node := ListItems.FocusedNode;
  if Node <> nil then begin
    Item := ListItems.GetNodeData(Node);
    Result := Item.fNode; // get corresponding ExplorerNew node
    {
    Name := Item.name;
    Data := Form1.ExplorerNew.GetNodeData(Form1.ExplorerNew.FocusedNode);
    if Data.StateIndex and $F00000 = FmaMessagesRootFlag then
      Name := Form1.GetSMSNodeName(Name);
    Result := Form1.FindExplorerChildNode(Name);
    }
  end
  else
    Result := Form1.ExplorerNew.FocusedNode;
end;

procedure TfrmExplore.FormStorage1RestorePlacement(Sender: TObject);
begin
  with ListItems do Header.Font.Assign(Font); // hack! Update Header font according to default theme font
end;

procedure TfrmExplore.RefreshView;
begin
  RootNode := FRootNode;
end;

end.
