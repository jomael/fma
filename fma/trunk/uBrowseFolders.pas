unit uBrowseFolders;

{
*******************************************************************************
* Descriptions: Implementation for FMA Folder Browseing
* $Source: /cvsroot/fma/fma/Attic/uBrowseFolders.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uBrowseFolders.pas,v $
*
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, TntComCtrls, StdCtrls, TntStdCtrls, VirtualTrees;

type
  TBrowseSelectionChangeEvent = procedure(Sender: TObject; Node: PVirtualNode;
    var EnableOKButton: boolean; var EnableNewFolder: boolean) of object;

  TfrmBrowseFolders = class(TForm)
    lblPath: TTntLabel;
    btnNewFolder: TTntButton;
    btnOK: TTntButton;
    btnCancel: TTntButton;
    TntLabel1: TTntLabel;
    tvFolders: TVirtualStringTree;
    procedure FormCreate(Sender: TObject);
    procedure btnNewFolderClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure tvFoldersGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure tvFoldersGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure tvFoldersGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure tvFoldersChange(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
  private
    { Private declarations }
    FRootNode: PVirtualNode;
    FOnSelect: TBrowseSelectionChangeEvent;
    FNewFolder: boolean;
    function Get_Selected: WideString;
    procedure Set_Selected(const Value: WideString);
    procedure Set_NewOK(const Value: boolean);
    procedure Set_RootNode(const Value: PVirtualNode);
    function AddExplorerNode(ParentNode,Node: PVirtualNode):PVirtualNode;
  protected
    procedure DoInitTree;
  public
    { Public declarations }
    AllowCurrent: boolean;
    function FindNodeWithPath(path: WideString): PVirtualNode;
    procedure AddNodes(Parent: PVirtualNode);
    property OnSelectionChange: TBrowseSelectionChangeEvent read FOnSelect write FOnSelect;
    property RootNode: PVirtualNode read FRootNode write Set_RootNode;
    property SelectedNodePath: WideString read Get_Selected write Set_Selected;
    property AllowNewFolder: boolean read FNewFolder write Set_NewOK;
  end;

var
  frmBrowseFolders: TfrmBrowseFolders;

implementation

uses
  gnugettext, gnugettexthelpers,
  Unit1, uInputQuery, uDialogs;

{$R *.dfm}

const
  FLastSelected: WideString = '';

{ TfrmBrowseFolders }

procedure TfrmBrowseFolders.DoInitTree;
begin
  tvFolders.Clear;
  AddNodes(FRootNode);
end;

procedure TfrmBrowseFolders.AddNodes(Parent: PVirtualNode);
var
  n: PVirtualNode;
begin
  if FRootNode = nil then
    FRootNode := Parent;
  tvFolders.BeginUpdate;
  try
    n := AddExplorerNode(nil,Parent);
    if Assigned(n) then
      tvFolders.Expanded[n] := true;
  finally
    tvFolders.EndUpdate;
  end;
end;

function TfrmBrowseFolders.AddExplorerNode(ParentNode,Node: PVirtualNode):PVirtualNode;
var
  data, data2: PFmaExplorerNode;
  Cname: WideString;
begin
  Result := nil;
  data := Form1.ExplorerNew.GetNodeData(Node);
  Cname := data.Text;

  if vsVisible in Node.States then begin
    Result := tvFolders.AddChild(ParentNode);
    if Assigned(Result) then begin
      data := Form1.ExplorerNew.GetNodeData(Node);
      data2 := tvFolders.GetNodeData(Result);
      data2.Data := Node;
      data2.ImageIndex := data.ImageIndex;
      data2.StateIndex := data.StateIndex;
      data2.Text := Cname;
      Node := Node.FirstChild;
      while Node<>nil do begin
        AddExplorerNode(Result, Node);
        Node := Node.NextSibling;
      end;
    end;
  end;
end;

function TfrmBrowseFolders.Get_Selected: WideString;
var
  data: PFmaExplorerNode;
begin
  Result := '';
  if tvFolders.SelectedCount > 0 then
  begin
    data := tvFolders.GetNodeData(tvFolders.GetFirstSelected);
    Result := Form1.ExplorerNodePath(PVirtualNode(data.Data));
  end;
end;

procedure TfrmBrowseFolders.Set_RootNode(const Value: PVirtualNode);
begin
  FRootNode := Value;
  DoInitTree;
end;

procedure TfrmBrowseFolders.Set_Selected(const Value: WideString);
  function FindNodeIn(Root: PVirtualNode): PVirtualNode;
  var
    node, node2: PVirtualNode;
    data: PFmaExplorerNode;
  begin
    Result := nil;
    node := Root.FirstChild;
    while node <> nil do begin
      data := tvFolders.GetNodeData(node);
      if WideCompareStr(Value,Form1.ExplorerNodePath(data.Data)) = 0 then begin
        Result := node;
        break;
      end;
      node := node.NextSibling;
    end;
    if not Assigned(Result) then begin
      node2 := Root.FirstChild;
      while not Assigned(Result) and Assigned(node2) do begin
        Result := FindNodeIn(node2);
        node2 := node2.NextSibling;
      end;
    end;
    if Assigned(Result) then begin
      tvFolders.Expanded[Root] := True;
      tvFolders.Selected[Result] := True;
    end;
  end;
begin
  lblPath.Caption := '';
  tvFolders.ClearSelection;
  if tvFolders.RootNodeCount <> 0 then begin
    if not Assigned(FindNodeIn(tvFolders.GetFirst)) then begin
      { If no selection, use Root node as default one }
      tvFolders.Selected[tvFolders.GetFirst] := True;
    end;
    FLastSelected := SelectedNodePath;
    //tvFoldersChange(tvFolders,tvFolders.FocusedNode);
  end;
end;

procedure TfrmBrowseFolders.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);

  AllowCurrent := True;
  TntLabel1.Font.Style := TntLabel1.Font.Style + [fsBold];
  lblPath.Left := TntLabel1.Left + TntLabel1.Width + 8;
end;

function TfrmBrowseFolders.FindNodeWithPath(path: WideString): PVirtualNode;
  function FindIt(root: PVirtualNode): PVirtualNode;
  var
    node: PVirtualNode;
    data: PFmaExplorerNode;
  begin
    Result := nil;
    if Assigned(root) then begin
      if root <> tvFolders.RootNode then begin
        data := tvFolders.GetNodeData(root);
        if WideCompareStr(path,Form1.ExplorerNodePath(data.Data)) = 0 then
          Result := root;
      end;
      node := root.FirstChild;
      while Assigned(node) and not Assigned(Result) do begin
        Result := FindIt(node);
        node := node.NextSibling;
      end;
    end;
  end;
begin
  Result := FindIt(tvFolders.RootNode);
end;

procedure TfrmBrowseFolders.tvFoldersChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  EnableOK,EnableNew: Boolean;
  EData: PFmaExplorerNode;
begin
  { now we have in FmaExplorerNode.Data pointer to original node in Form1.ExplorerNew }
  EData := Sender.GetNodeData(tvFolders.GetFirstSelected);
  if EData = nil then begin
    btnOK.Enabled := false;
    btnOK.Default := btnOK.Enabled;
    btnNewFolder.Visible := false;
    btnNewFolder.Enabled := false;
    Exit;
  end;
  lblPath.Caption := Form1.ExplorerNodePath(EData.Data);
  EnableOK := True;
  EnableNew := False;
  if Assigned(FOnSelect) then begin
    EData := Sender.GetNodeData(FindNodeWithPath(SelectedNodePath));
    { FOnSelect will always have Form1.ExplorerNew's node as argument }
    FOnSelect(Sender,EData.Data,EnableOK,EnableNew);
  end;
  { Do not allow selecting current Explorer's node }
  EData := Sender.GetNodeData(Sender.GetFirstSelected);
  if not AllowCurrent and (EData.Data = Form1.ExplorerNew.GetFirstSelected) then
    EnableOK := False;
  btnOK.Enabled := EnableOK;
  btnOK.Default := btnOK.Enabled;
  btnNewFolder.Visible := FNewFolder and Assigned(FindNodeWithPath(SelectedNodePath));
  btnNewFolder.Enabled := EnableNew;
end;

procedure TfrmBrowseFolders.Set_NewOK(const Value: boolean);
begin
  FNewFolder := Value;
  btnNewFolder.Visible := Value and Assigned(FindNodeWithPath(SelectedNodePath));
end;

procedure TfrmBrowseFolders.btnNewFolderClick(Sender: TObject);
var
  w,n: WideString;
  data: PFmaExplorerNode;
begin
  w := '';
  if WideInputQuery(_('Create Folder'),_('Enter folder name:'),w) then
    if Trim(w) <> '' then begin
      data := tvFolders.GetNodeData(FindNodeWithPath(SelectedNodePath));
      if Form1.FindExplorerChildNode(w,data.Data) = nil then begin
        Form1.SMSNewFolder(data.Data,w);
        n := SelectedNodePath;
        DoInitTree;
        SelectedNodePath := n;
        if tvFolders.GetFirstSelected <> nil then begin
          tvFolders.IsVisible[tvFolders.GetFirstSelected] := true;
          tvFolders.Expanded[tvFolders.GetFirstSelected] := true;
        end;
      end
      else
        MessageDlgW(_('Folder alerady exists.'),mtError,MB_OK);
    end
    else
      MessageDlgW(_('You have to enter folder name.'),mtError,MB_OK);
end;

procedure TfrmBrowseFolders.FormShow(Sender: TObject);
begin
  SelectedNodePath := FLastSelected;
  if tvFolders.GetFirstSelected <> nil then
    tvFolders.IsVisible[tvFolders.GetFirstSelected] := true;
end;

procedure TfrmBrowseFolders.btnOKClick(Sender: TObject);
begin
  FLastSelected := SelectedNodePath;
end;

procedure TfrmBrowseFolders.tvFoldersGetNodeDataSize(
  Sender: TBaseVirtualTree; var NodeDataSize: Integer);
begin
  NodeDataSize := Sizeof(TFmaExplorerNode);
end;

procedure TfrmBrowseFolders.tvFoldersGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  EData: PFmaExplorerNode;
begin
  EData := Sender.GetNodeData(Node);
  if Assigned(EData) then CellText := EData.Text;
end;

procedure TfrmBrowseFolders.tvFoldersGetImageIndex(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
  Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
var
  EData: PFmaExplorerNode;
begin
  EData := Sender.GetNodeData(Node);
  if Assigned(EData) then ImageIndex := EData.ImageIndex;
end;

end.

