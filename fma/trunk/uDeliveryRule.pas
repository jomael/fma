unit uDeliveryRule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TntStdCtrls, ComCtrls, TntComCtrls, ImgList, VirtualTrees;

type
  TfrmSMSRule = class(TForm)
    edName: TTntEdit;
    TntLabel27: TTntLabel;
    edFolder: TTntEdit;
    btnBrowse: TTntButton;
    TntLabel1: TTntLabel;
    TntLabel26: TTntLabel;
    btnContacts: TTntButton;
    btnOK: TTntButton;
    btnCancel: TTntButton;
    lvContacts: TTntListView;
    TntLabel2: TTntLabel;
    procedure btnContactsClick(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
    procedure OnFolderSelected(Sender: TObject; Node: PVirtualNode;
      var EnableOKButton: boolean; var EnableNewFolder: boolean);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FCorrespondents: WideString;
    FFolderNode: PVirtualNode;
    FFolderLocked: boolean;
    procedure Set_Correspondents(const Value: WideString);
    procedure Set_Folder(const Value: PVirtualNode);
    function Get_Name: WideString;
    procedure Set_Name(const Value: WideString);
    procedure Set_Locked(const Value: boolean);
  public
    { Public declarations }
    property RuleName: WideString read Get_Name write Set_Name;
    property Correspondents: WideString read FCorrespondents write Set_Correspondents;
    property FolderNode: PVirtualNode read FFolderNode write Set_Folder;
    property FolderLocked: boolean read FFolderLocked write Set_Locked;
  end;

var
  frmSMSRule: TfrmSMSRule;

implementation

uses
  gnugettext, gnugettexthelpers, uDialogs,
  Unit1, uGlobal, uSelectContact, uBrowseFolders;

{$R *.dfm}

procedure TfrmSMSRule.btnContactsClick(Sender: TObject);
begin
  with TfrmSelContact.Create(nil) do
  try
    AllowGroups := False;
    SelContacts := Correspondents;
    if ShowModal = mrOk then
      Correspondents := SelContacts;
  finally
    Free;
  end;
end;

procedure TfrmSMSRule.Set_Correspondents(const Value: WideString);
var
  s,w: WideString;
begin
  FCorrespondents := Value;
  lvContacts.Items.Clear;
  w := Value;
  repeat
    s := GetFirstToken(w,';');
    if s <> '' then
      with lvContacts.Items.Add do begin
        Caption := Form1.ExtractContact(s);
        SubItems.Add(Form1.ExtractNumber(s));
        ImageIndex := 26;
      end;
  until w = '';
end;

procedure TfrmSMSRule.Set_Folder(const Value: PVirtualNode);
begin
  edFolder.Text := Form1.ExplorerNodePath(Value,'\',True);
  FFolderNode := Value;
end;

procedure TfrmSMSRule.btnBrowseClick(Sender: TObject);
var EData: PFmaExplorerNode;
begin
  with TfrmBrowseFolders.Create(nil) do
  try
    OnSelectionChange := OnFolderSelected;
    AllowNewFolder := True;
    RootNode := Form1.FNodeMsgRoot;
    SelectedNodePath := Form1.ExplorerNodePath(FolderNode);
    if ShowModal = mrOK then
    begin
      EData := tvFolders.GetNodeData(FindNodeWithPath(SelectedNodePath));
      FolderNode := EData.Data;
    end;
  finally
    Free;
  end;
end;

procedure TfrmSMSRule.OnFolderSelected(Sender: TObject; Node: PVirtualNode;
  var EnableOKButton, EnableNewFolder: boolean);
var data: PFmaExplorerNode;
begin
  data := Form1.ExplorerNew.GetNodeData(Node);
  EnableOKButton := Assigned(Node) and (data.StateIndex = FmaSMSSubFolderFlag);
  EnableNewFolder := (Node <> Form1.FNodeMsgOutbox) and (Node <> Form1.FNodeMsgDrafts);
end;

function TfrmSMSRule.Get_Name: WideString;
begin
  Result := edName.Text;
end;

procedure TfrmSMSRule.Set_Name(const Value: WideString);
begin
  edName.Text := Value;
end;

procedure TfrmSMSRule.btnOKClick(Sender: TObject);
begin
  if Trim(RuleName) = '' then begin
    MessageDlgW(_('You have to enter rule name.'),mtError,MB_OK);
    Abort;
  end;
  if Trim(Correspondents) = '' then begin
    MessageDlgW(_('You have to select correspondents.'),mtError,MB_OK);
    Abort;
  end;
  if not Assigned(FolderNode) then begin
    MessageDlgW(_('You have to select target folder.'),mtError,MB_OK);
    Abort;
  end;
  ModalResult := mrOk;
end;

procedure TfrmSMSRule.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);
end;

procedure TfrmSMSRule.Set_Locked(const Value: boolean);
begin
  FFolderLocked := Value;
  edFolder.ReadOnly := Value;
  btnBrowse.Enabled := not Value;
  if Value then edFolder.Color := clBtnFace
    else edFolder.Color := clWindow;
end;

end.
