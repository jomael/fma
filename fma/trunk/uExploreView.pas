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
* Revision 1.15.2.12  2006/03/15 14:19:47  z_stoichev
* Fixed Typo 'reccur' to 'recur' in few places.
*
* Revision 1.15.2.11  2006/03/14 12:20:19  z_stoichev
* Added Default explorer view New popup option.
*
* Revision 1.15.2.10  2006/03/13 13:59:16  z_stoichev
* Create new alarm using Properties dialog.
*
* Revision 1.15.2.9  2006/03/13 12:59:19  z_stoichev
* Popup menu rearranged.
* New Alarm code moved into Unit1.
*
* Revision 1.15.2.8  2006/03/12 22:52:38  z_stoichev
* Added Organized Alarms support (testing).
*
* Revision 1.15.2.7  2006/01/16 11:26:55  mhr3
* Form1.Explorer -> Form1.ExplorerNew
*
* Revision 1.15.2.6  2005/11/24 15:03:15  z_stoichev
* Fixed default theme font usage. Do not alter FORM's font property!
*
* Revision 1.15.2.5  2005/10/04 13:09:08  z_stoichev
* Fixed AV bug on Folder (1) double-click.
*
* Revision 1.15.2.4  2005/08/30 12:57:38  z_stoichev
* Fixed OBEX unknown file types support (delete).
*
* Revision 1.15.2.3  2005/08/18 22:26:25  z_stoichev
* - Allow Contact popup options to work with calls.
* - Fixed Double-click behaviour in default explorer view.
*
* Revision 1.15.2.2  2005/04/03 12:22:11  lordlarry
* Changed some methods to WideString methods
*
* Revision 1.15.2.1  2005/03/21 22:41:57  schnorbsl_fma
* Fixed: OBEX files: download not possible for not registered file types
* Fixed: Explorer: MultiSelect capability for OBEX files node and subnodes
*
* Revision 1.15  2005/02/08 15:38:51  voxik
* Merged with L10N branch
*
* Revision 1.14.2.2  2004/10/25 20:21:40  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.14.2.1  2004/10/19 19:48:38  expertone
* Add localization (gnugettext)
*
* Revision 1.14  2004/09/20 11:57:00  merijnb
* merged with FileObject
*
* Revision 1.13.8.1  2004/09/02 10:16:33  merijnb
* introduced TFile object
*
* Revision 1.13  2004/06/30 15:25:53  z_stoichev
* Added Create Group menu item
*
* Revision 1.12  2004/06/27 21:19:21  z_stoichev
* Explore phone WAP bookmarks.
*
* Revision 1.11  2004/06/25 15:23:27  z_stoichev
* Bookmark support
*
* Revision 1.10  2004/06/24 09:06:06  z_stoichev
* - Added Chat to Contact command to various popup Menus.
* - Added Add to Phonebook to various popup Menus.
*
* Revision 1.9  2004/06/19 11:17:31  z_stoichev
* - Changed Contact Group icons.
*
* Revision 1.8  2004/05/21 12:03:09  z_stoichev
* Profile context menu and properties.
*
* Revision 1.7  2004/05/19 18:34:15  z_stoichev
* Build 0.1.0.35c
*
* Revision 1.6  2004/04/01 15:30:28  z_stoichev
* New Calls data format support
*
* Revision 1.5  2004/03/08 15:53:52  z_stoichev
* Fixed Explorer view foder types.
* Added Explorer view default properties.
*
* Revision 1.4  2004/01/28 17:13:09  z_stoichev
* Popup menu rearranged.
*
* Revision 1.3  2003/12/12 12:57:22  z_stoichev
* Add delete file support.
* Add properties link.
* Add customize view support.
*
* Revision 1.2  2003/11/28 09:38:07  z_stoichev
* Merged with branch-release-1-1 (Fma 0.10.28c)
*
* Revision 1.1.2.8  2003/11/21 16:18:30  z_stoichev
* Show calls time in second column.
*
* Revision 1.1.2.7  2003/11/14 15:41:02  z_stoichev
* Updates for patch 27d.
*
* Revision 1.1.2.6  2003/11/13 16:39:54  z_stoichev
* Add more items type support.
*
* Revision 1.1.2.5  2003/11/11 13:18:12  z_stoichev
* Update since new icons.
* Optimized contents reload.
*
* Revision 1.1.2.4  2003/11/10 14:03:09  z_stoichev
* RC3
*
* Revision 1.1.2.3  2003/11/06 16:27:20  z_stoichev
* Popup menu expanded.
* Dont show -1 size.
*
* Revision 1.1.2.2  2003/11/04 12:27:26  z_stoichev
* Display size in Kb for files and hide for folders.
* Added amr sound type support.
*
* Revision 1.1.2.1  2003/10/29 09:20:50  z_stoichev
* Initial checkin.
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

end.
