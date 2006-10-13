unit uOrganizeFavs;

{
*******************************************************************************
* Descriptions: Organize Favorites
* $Source: /cvsroot/fma/fma/uOrganizeFavs.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uOrganizeFavs.pas,v $
*
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, ExtCtrls, TntExtCtrls, StdCtrls, TntStdCtrls, ComCtrls, TntComCtrls, UniTntCtrls, Menus, TntMenus;

type
  TfrmOrganizeFavs = class(TTntForm)
    TreeView1: TTntTreeView;
    Label1: TTntLabel;
    btnAdd: TTntButton;
    btnRemove: TTntButton;
    btnUp: TTntButton;
    btnDown: TTntButton;
    btnOk: TTntButton;
    btnCancel: TTntButton;
    PopupMenu1: TTntPopupMenu;
    Edit1: TTntMenuItem;
    N1: TTntMenuItem;
    Delete1: TTntMenuItem;
    TntGroupBox1: TTntGroupBox;
    mmoDetails: TTntMemo;
    Add1: TTntMenuItem;
    N2: TTntMenuItem;
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnUpDownClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Add1Click(Sender: TObject);
  private
    FFavsType: string;
    FMultiSel: boolean;
    function Get_Favs: TTntStringList;
    procedure Set_Favs(const Value: TTntStringList);
    procedure Set_FavType(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    property FavsType: string read FFavsType write Set_FavType;
    property FavsList: TTntStringList read Get_Favs write Set_Favs;
    property MultiSel: boolean read FMultiSel write FMultiSel;
  end;

var
  frmOrganizeFavs: TfrmOrganizeFavs;

implementation

uses
  gnugettext, gnugettexthelpers,
  Unit1, uSelectContact, uGetContact, uDialogs;

{$R *.dfm}

{ TfrmOrganizeFavs }

function TfrmOrganizeFavs.Get_Favs: TTntStringList;
var
  sl: TTntStringList;
  i: integer;
begin
  sl := TTntStringList.Create;
  try
    for i := 0 to TreeView1.Items.Count-1 do
      sl.Add(TreeView1.Items[i].Text);
  except
    FreeAndNil(sl);
  end;
  Result := sl;
end;

procedure TfrmOrganizeFavs.Set_Favs(const Value: TTntStringList);
var
  i: integer;
begin
  TreeView1.Items.BeginUpdate;
  try
    TreeView1.Items.Clear;
    for i := 0 to Value.Count-1 do
      with TreeView1.Items.Add(nil,Value[i]) do begin
        ImageIndex := 26;
        SelectedIndex := 25;
      end;
  finally
    TreeView1.Items.EndUpdate;
  end;
end;

procedure TfrmOrganizeFavs.TreeView1Change(Sender: TObject;
  Node: TTreeNode);
begin
  if Assigned(Node) then
    mmoDetails.Text := StringReplace(Node.Text,'; ',sLinebreak,[rfReplaceAll])
  else
    mmoDetails.Text := '';
  btnRemove.Enabled := TreeView1.Selected <> nil;
  btnUp.Enabled := btnRemove.Enabled and (TreeView1.Selected.Index > 0);
  btnDown.Enabled := btnRemove.Enabled and (TreeView1.Selected.Index < TreeView1.Items.Count-1);
end;

procedure TfrmOrganizeFavs.btnRemoveClick(Sender: TObject);
begin
  if MessageDlgW(_('Current favorite item will be removed from list. Do you wish to continue?'),
    mtConfirmation, MB_YESNO or MB_DEFBUTTON2) = ID_YES then begin
    TreeView1.Selected.Delete;
    TreeView1Change(TreeView1,TreeView1.Selected);
  end;
end;

procedure TfrmOrganizeFavs.btnUpDownClick(Sender: TObject);
var
  Node: TTntTreeNode;
  s: string;
begin
  Node := TreeView1.Items[TreeView1.Selected.Index + (Sender as TTntButton).Tag];
  s := Node.Text;
  Node.Text := TreeView1.Selected.Text;
  TreeView1.Selected.Text := s;
  TreeView1.Selected := Node;
end;

procedure TfrmOrganizeFavs.btnAddClick(Sender: TObject);
var
  Dlg: TfrmSelContact;
begin
  if FMultiSel then
    Dlg := TfrmSelContact.Create(nil)
  else
    Dlg := TfrmGetContact.Create(nil);
  with Dlg do
    try
      if (Sender <> btnAdd) and (TreeView1.Selected <> nil) then
        SelContacts := TreeView1.Selected.Text
      else
        SelContacts := '';
      if ShowModal = mrOk then
        if SelContacts <> '' then
          if (Sender = btnAdd) or (TreeView1.Selected = nil) then
            with TreeView1.Items.Add(nil,SelContacts) do begin
              ImageIndex := 26;
              SelectedIndex := 25;
              Selected := True;
              Focused := True;
            end
          else begin
            TreeView1.Selected.Text := SelContacts;
            TreeView1Change(TreeView1,TreeView1.Selected);
          end
        else
          if (Sender <> btnAdd) and (TreeView1.Selected <> nil) then
            TreeView1.Selected.Delete;
    finally
      Free;
    end;
end;

procedure TfrmOrganizeFavs.PopupMenu1Popup(Sender: TObject);
begin
  Edit1.Enabled := TreeView1.Selected <> nil;
  Delete1.Enabled := Edit1.Enabled;
end;

procedure TfrmOrganizeFavs.Set_FavType(const Value: string);
begin
  FFavsType := Value;
  //Edit1.Caption := _('Edit...');
  Caption := _('Organize Favorites');
  if Value <> '' then begin
    Caption := Format('%s - [%s]',[Caption,Value]);
    //Edit1.Caption := Format(_('Edit %s'),[Value]);
  end;
end;

procedure TfrmOrganizeFavs.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);

{$IFNDEF VER150}
  Form1.ThemeManager1.CollectForms(Self);
{$ENDIF}
  FMultiSel := True;
end;

procedure TfrmOrganizeFavs.Add1Click(Sender: TObject);
begin
  btnAdd.Click;
end;

end.
