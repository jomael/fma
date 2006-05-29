unit uSelectContact;

{
*******************************************************************************
* Descriptions: Selecting Multiple Contacts
* $Source: /cvsroot/fma/fma/uSelectContact.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uSelectContact.pas,v $
* Revision 1.13.2.10  2006/03/11 15:14:23  z_stoichev
* - Fixed Select contacts specified by name only.
*
* Revision 1.13.2.9  2006/01/16 11:26:57  mhr3
* Form1.Explorer -> Form1.ExplorerNew
*
* Revision 1.13.2.8  2005/11/24 13:58:53  z_stoichev
* - Fixed Select Contacts No Items message position.
* - Fixed Select Contacts Properties AV bug issue.
* - Added Select Contacts open Phone book by default.
*
* Revision 1.13.2.7  2005/10/02 22:32:31  z_stoichev
* Allow group to be disabled.
*
* Revision 1.13.2.6  2005/09/20 20:27:24  z_stoichev
* Fixed phone type icon.
*
* Revision 1.13.2.5  2005/09/18 20:32:16  z_stoichev
* Get/select contact(s) fixes.
* Do not delay dialog show.
*
* Revision 1.13.2.4  2005/09/06 18:32:57  z_stoichev
* Bugfixes and improvements (2.1.1.102b)
*
* Revision 1.13.2.3  2005/08/20 18:29:51  z_stoichev
* - Fixed Select Contact popup menu commands lose changes.
*
* Revision 1.13.2.2  2005/08/20 18:11:06  z_stoichev
* - Fixed Select Contact popup menu disabled if no IrmcSync.
* - Fixed Find contact in Phonebook (Irmc), Phone Book, SIM.
*
* Revision 1.13.2.1  2005/04/11 22:20:05  z_stoichev
* Unicode fixes.
*
* Revision 1.13  2005/02/08 15:38:54  voxik
* Merged with L10N branch
*
* Revision 1.10.12.3  2005/01/07 17:34:38  expertone
* Merge with MAIN branch
*
* Revision 1.12  2005/01/03 15:31:40  z_stoichev
* Fixed: Group select in Call Favorites.
*
* Revision 1.11  2004/12/11 11:03:42  z_stoichev
* Refresh after Properties.
*
* Revision 1.10.12.2  2004/10/25 20:21:56  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.10.12.1  2004/10/19 19:48:48  expertone
* Add localization (gnugettext)
*
* Revision 1.10  2004/06/29 11:51:15  z_stoichev
* Added Select One Contact support
*
* Revision 1.9  2004/06/19 11:16:06  z_stoichev
* - Fixed Select contacts phone lookup.
* - Changed Contact Group icons.
*
* Revision 1.8  2004/05/19 18:34:16  z_stoichev
* Build 0.1.0.35c
*
* Revision 1.7  2004/04/01 15:05:49  z_stoichev
* GUI changes
* support for unknown contacts
*
* Revision 1.6  2003/12/16 17:38:38  z_stoichev
* Add support for contacts without numbers.
*
* Revision 1.5  2003/12/01 12:21:28  z_stoichev
* Add filter for mobile numbers only.
*
* Revision 1.4  2003/11/28 09:38:07  z_stoichev
* Merged with branch-release-1-1 (Fma 0.10.28c)
*
* Revision 1.3.2.4  2003/11/10 14:03:10  z_stoichev
* RC3
*
* Revision 1.3.2.3  2003/10/30 15:17:18  z_stoichev
* Remove dublicated contacts issued from Groups.
*
* Revision 1.3.2.2  2003/10/29 16:22:42  z_stoichev
* Add Groups support.
*
* Revision 1.3.2.1  2003/10/27 07:22:54  z_stoichev
* Build 0.1.0 RC1 Initial Checkin.
*
* Revision 1.3  2003/10/21 08:51:52  z_stoichev
* Added SelContacts property containing the
* selected recipients addresses in format
* "name [number]; ..."
*
* Revision 1.2  2003/10/15 16:14:17  z_stoichev
* Select contacts by row, not by name.
* Corrected some typos.
* Added Clear button to delete all recipients.
* Added header comments.
*
*
*
*******************************************************************************
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, ExtCtrls, TntExtCtrls, StdCtrls, TntStdCtrls, ComCtrls, TntComCtrls, UniTntCtrls, ImgList,
  Menus, TntMenus, Placemnt, VirtualTrees;

type
  TfrmSelContact = class(TTntForm)
    Label1: TTntLabel;
    TntListView1: TTntListView;
    AddButton: TTntButton;
    SelectedList: TTntListView;
    Label2: TTntLabel;
    RemButton: TTntButton;
    OkButton: TTntButton;
    CancelButton: TTntButton;
    TntEdit1: TTntEdit;
    Label3: TTntLabel;
    ComboBox1: TTntComboBox;
    ClearButton: TTntButton;
    ImageList1: TImageList;
    CheckBox1: TTntCheckBox;
    PopupMenu1: TTntPopupMenu;
    NewContact1: TTntMenuItem;
    N1: TTntMenuItem;
    Properties1: TTntMenuItem;
    FormStorage1: TFormStorage;
    NoItemsPanel: TTntPanel;
    Animate1: TAnimate;
    Timer1: TTimer;
    procedure TntListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure SelectedListSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure RemButtonClick(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure TntEdit1Change(Sender: TObject);
    procedure TntListView1DblClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure TntListView1Insert(Sender: TObject; Item: TListItem);
    procedure Properties1Click(Sender: TObject);
    procedure NewContact1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
  private
    { Private declarations }
    FAllowSIM,FAllowNoNumbers,FSelProcessed: boolean;
    FSelection: WideString;
    FAllowGroups: boolean;
    function Get_Sel: WideString;
    function Get_MultiSelect: boolean;
    procedure Set_MultiSelect(const Value: boolean);
    procedure Set_AllowSIM(const Value: boolean);
  protected
    { Protected declarations }
    procedure DoAddContact(Node: TTntListItem);
    procedure DoUpdateContacts(Mask: WideString = '');
    procedure DoProcessSelection; virtual;
    procedure DoSelectDefaultItem; virtual;
  public
    { Public declarations }
    property AllowGroups: boolean read FAllowGroups write FAllowGroups;
    property AllowNoNumbers: boolean read FAllowNoNumbers write FAllowNoNumbers;
    property AllowSIMContacts: boolean read FAllowSIM write Set_AllowSIM;
    property AllowMultiSelect: boolean read Get_MultiSelect write Set_MultiSelect;

    property SelContacts: WideString read Get_Sel write FSelection;
  end;

var
  frmSelContact: TfrmSelContact;

implementation

uses
  gnugettext, gnugettexthelpers,
  uSyncPhonebook, uMissedCalls, Unit1, uSIMEdit, uDialogs;

{$R *.dfm}

procedure TfrmSelContact.TntListView1SelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  AddButton.Enabled := (TntListView1.SelCount <> 0) and
    (AllowMultiSelect or (SelectedList.Items.Count = 0));
  Properties1.Enabled := (TntListView1.SelCount = 1) and
    (TntListView1.Selected.ImageIndex = 0); // only for contacts
end;

procedure TfrmSelContact.SelectedListSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  RemButton.Enabled := Selected;
end;

procedure TfrmSelContact.RemButtonClick(Sender: TObject);
var
  i: integer;
begin
  for i := SelectedList.Items.Count-1 downto 0 do
    if SelectedList.Items[i].Selected then
      SelectedList.Items[i].Delete;
end;

procedure TfrmSelContact.AddButtonClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to TntListView1.Items.Count-1 do
    if TntListView1.Items[i].Selected then
      DoAddContact(TntListView1.Items[i]);
end;

procedure TfrmSelContact.TntEdit1Change(Sender: TObject);
begin
  Timer1.Enabled := False;
  Timer1.Enabled := True;
end;

procedure TfrmSelContact.DoUpdateContacts(Mask: WideString);
const
  Sem: boolean = False;
var
  root, node, node2: PVirtualNode;
  EData: PFmaExplorerNode;
  nme,tel,grp: WideString;
begin
  if Sem then begin
    Timer1.Enabled := True;
    exit;
  end;
  Sem := True;
  try
    case ComboBox1.ItemIndex of
      0: root := Form1.FNodeContactsME;
      1: root := Form1.FNodeContactsSM;
      else exit; // just in case
    end;
    Mask := WideUpperCase(Mask);
    TntListView1.Items.BeginUpdate;
    try
      { Clear view }
      TntListView1.Items.Clear;
      TntListView1.Items.EndUpdate;
      NoItemsPanel.Visible := False;
      Animate1.Color := clWindow;
      Animate1.Visible := True;
      Animate1.Active := True;
      Update;
      TntListView1.Items.BeginUpdate;
      { Build list }
      if AllowGroups and AllowMultiSelect and (ComboBox1.ItemIndex = 0) then
      begin
        node := Form1.ExplorerNew.GetFirstChild(Form1.FNodeGroups);
        while node <> nil do begin
          EData := Form1.ExplorerNew.GetNodeData(node);
          nme := EData.Text;
          if (Mask = '') or (Pos(Mask,WideUpperCase(nme)) <> 0) then begin
            tel := '';
            node2 := Form1.ExplorerNew.GetFirstChild(node);
            while node2<>nil do begin
              if length(tel) <> 0 then tel := tel + ',';
              EData := Form1.ExplorerNew.GetNodeData(node2);
              grp := EData.Text;
              { quote group member name which contains the delimiter char }
              if pos(',',grp) <> 0 then grp := '"'+grp+'"';
              tel := tel + grp;
              node2 := Form1.ExplorerNew.GetNextSibling(node2);
            end;
            with TntListView1.Items.Add do begin
              Caption := nme;
              SubItems.Add(tel);
              ImageIndex := 1;
              //StateIndex := -1;
            end;
          end;
          node := Form1.ExplorerNew.GetNextSibling(node);
        end;
      end;

      node := Form1.ExplorerNew.GetFirstChild(root);
      while node<>nil do begin
        EData := Form1.ExplorerNew.GetNodeData(node);
        nme := EData.Text;
        if (Mask = '') or (Pos(Mask,WideUpperCase(nme)) <> 0) then begin
          node2 := Form1.ExplorerNew.GetFirstChild(node);
          while node2<>nil do begin
            EData := Form1.ExplorerNew.GetNodeData(node2);
            if not CheckBox1.Enabled or not CheckBox1.Checked or
              (EData.ImageIndex = 10) then
              begin
                tel := EData.Text;
                with TntListView1.Items.Add do begin
                  Caption := nme;
                  SubItems.Add(tel);
                  ImageIndex := 0;
                  StateIndex := EData.ImageIndex;
                end;
              end;
            node2 := Form1.ExplorerNew.GetNextSibling(node2);
          end;
          { Allow contact without numbers if selecting from Phonebook only
            (see "Add To Phonebook" for details) }
          if FAllowNoNumbers and (root.ChildCount = 0) then
            with TntListView1.Items.Add do begin
              Caption := nme;
              SubItems.Add(''); // no phone
              ImageIndex := 0;
              //StateIndex := -1;
            end;
        end;
        node := Form1.ExplorerNew.GetNextSibling(node);
        Application.ProcessMessages;
      end;
    finally
      TntListView1.Items.EndUpdate;
    end;
    if not FSelProcessed then begin
      DoProcessSelection;
      DoSelectDefaultItem;
      FSelProcessed := True;
    end;
  finally
    Animate1.Visible := False;
    Animate1.Active := False;
    NoItemsPanel.Visible := TntListView1.Items.Count = 0;
    Sem := False;
  end;
end;

procedure TfrmSelContact.TntListView1DblClick(Sender: TObject);
begin
  if TntListView1.Selected <> nil then AddButton.Click;
end;

procedure TfrmSelContact.ClearButtonClick(Sender: TObject);
begin
  //if MessageDlgW(_('Clear all recipients?'),mtConfirmation,MB_YESNO) = ID_YES then
    SelectedList.Clear;
end;

function TfrmSelContact.get_Sel: WideString;
var
  i: integer;
  tel: WideString;
begin
  Result := '';
  for i := 0 to SelectedList.Items.Count-1 do begin
    if Result <> '' then Result := Result + '; ';
    if SelectedList.Items[i].ImageIndex = 0 then begin
      tel := SelectedList.Items[i].SubItems[0];
      if SelectedList.Items[i].Caption <> '' then begin
        if tel <> '' then
          Result := Result + SelectedList.Items[i].Caption + ' [' + tel + ']'
        else
          Result := Result + SelectedList.Items[i].Caption;
      end
      else
        Result := Result + tel;
    end
    else
      Result := Result + SelectedList.Items[i].Caption + ' {' + SelectedList.Items[i].SubItems[0] + '}'
  end;
end;

procedure TfrmSelContact.TntListView1Insert(Sender: TObject;
  Item: TListItem);
begin
  Item.ImageIndex := 0;
end;

procedure TfrmSelContact.Properties1Click(Sender: TObject);
var
  ContactME: PContactData;
  ContactSM: PSIMData;
  Edited: boolean;
begin
  Edited := False;
  case ComboBox1.ItemIndex of
    0: // Phonebook
       if Form1.IsIrmcSyncEnabled then begin
         if Form1.frmSyncPhonebook.FindContact(TntListView1.Selected.Caption,ContactME) then
           with Form1.frmSyncPhonebook do begin
             SelContact := ContactME;
             Edited := DoEdit;
           end;
       end
       else begin
         if Form1.frmMEEdit.FindContact(TntListView1.Selected.Caption,ContactSM) then
           with Form1.frmMEEdit do begin
             SelContact := ContactSM;
             Edited := DoEdit;
           end;
       end;
    1: begin // SIM
         if Form1.frmSMEdit.FindContact(TntListView1.Selected.Caption,ContactSM) then
           with Form1.frmSMEdit do begin
             SelContact := ContactSM;
             Edited := DoEdit;
           end;
       end;
  end;
  if Edited then begin
    case ComboBox1.ItemIndex of
      0: Form1.UpdateMEPhonebook; // Phonebook
      1: Form1.UpdateSMPhonebook; // SIM
    end;
    TntEdit1Change(nil);
  end;
end;

procedure TfrmSelContact.NewContact1Click(Sender: TObject);
var
  Edited: boolean;
begin
  Edited := False;
  case ComboBox1.ItemIndex of
    0: if Form1.IsIrmcSyncEnabled then // Phonebook
         Edited := Form1.frmSyncPhonebook.DoEdit(True)
       else
         Edited := Form1.frmMEEdit.DoEdit(True);
    1: Edited := Form1.frmSMEdit.DoEdit(True); // SIM
  end;
  if Edited then begin
    case ComboBox1.ItemIndex of
      0: Form1.UpdateMEPhonebook; // Phonebook
      1: Form1.UpdateSMPhonebook; // SIM
    end;
    TntEdit1Change(nil);
  end;
end;

procedure TfrmSelContact.DoAddContact(Node: TTntListItem);
var
  i: integer;
  function RemoveDub: boolean;
  var
    i,j,k: integer;
    sl: TStringList;
    Data: PContactData;
    s: string;
  begin
    Result := False;
    try
      sl := TStringList.Create;
      try
        for i := 0 to SelectedList.Items.Count-1 do
          { Find groups }
          if SelectedList.Items[i].ImageIndex = 1 then begin
            { Parse all members }
            sl.CommaText := SelectedList.Items[i].SubItems[0];
            { Replace names with default numbers }
            for j := 0 to sl.Count-1 do begin
              Form1.frmSyncPhonebook.FindContact(sl[j],Data);
              s := GetContactDefPhone(Data);
              sl[j] := s;
            end;
            { Find numbers and remove dubs }
            for j := 0 to sl.Count-1 do
              for k := 0 to SelectedList.Items.Count-1 do
                if sl[j] = SelectedList.Items[k].SubItems[0] then begin
                  { Dublicate, so delete it }
                  SelectedList.Items[k].Delete;
                  Result := True;
                  Abort; // list is modified, we have to cancel loops now
                end;
          end;
      finally
        sl.Free;
      end;
    except
    end;  
  end;
begin
  { first check if contact is already added }
  for i := 0 to SelectedList.Items.Count-1 do
    if SelectedList.Items[i].ImageIndex = Node.ImageIndex then begin
      if (SelectedList.Items[i].Caption = Node.Caption) and
        (SelectedList.Items[i].SubItems[0] = Node.SubItems[0]) then
        exit;
    end;
  { ok, add it }
  with SelectedList.Items.Add do begin
    Caption := Node.Caption;
    SubItems.Add(Node.SubItems[0]);
    ImageIndex := Node.ImageIndex;
    StateIndex := Node.StateIndex;
    MakeVisible(False);
  end;
  { Remove dublicates (Groups + Contact) }
  while RemoveDub do ;
end;

procedure TfrmSelContact.FormShow(Sender: TObject);
begin
  if TntListView1.Items.Count = 0 then
    FormStorage1.RestoreFormPlacement;
  if not FAllowSIM or (ComboBox1.ItemIndex = -1) then
    ComboBox1.ItemIndex := 0;
  if TntListView1.Items.Count = 0 then
    TntEdit1Change(nil);
end;

function TfrmSelContact.Get_MultiSelect: boolean;
begin
  Result := TntListView1.MultiSelect;
end;

procedure TfrmSelContact.Set_MultiSelect(const Value: boolean);
begin
  TntListView1.MultiSelect := Value;
  if not Value then
    while SelectedList.Items.Count > 1 do
      SelectedList.Items.Delete(1);
end;

procedure TfrmSelContact.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);
{$IFDEF VER150}
  NoItemsPanel.ParentBackground := False;
{$ENDIF}
  FAllowSIM := True;
  FAllowGroups := True;
end;

procedure TfrmSelContact.Set_AllowSIM(const Value: boolean);
begin
  FAllowSIM := Value;
  ComboBox1.Enabled := Value;
end;

procedure TfrmSelContact.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  CheckBox1.Enabled := ComboBox1.ItemIndex = 0;

  DoUpdateContacts(TntEdit1.Text);
end;

procedure TfrmSelContact.DoProcessSelection;
var
  i,ptype: integer;
  d,s,nme: WideString;
  node: PVirtualNode;
  EData: PFmaExplorerNode;
  IsGroup: boolean;
  //MEdata: PContactData;
  //SMdata: PSIMData;
  procedure LookupPerson(phone: string; var cname: WideString; var ptype: integer);
  var
    i: integer;
  begin
    for i := 0 to TntListView1.Items.Count-1 do begin
      if AnsiCompareText(Form1.GetPartialNumber(TntListView1.Items[i].SubItems[0]),
        Form1.GetPartialNumber(phone)) = 0 then begin
        cname := TntListView1.Items[i].Caption;
        ptype := TntListView1.Items[i].StateIndex;
        break;
      end;
      if i mod 16 = 0 then Application.ProcessMessages;
    end;
  end;
begin
  SelectedList.Clear;
  d := Trim(FSelection);
  repeat
    nme := '';
    ptype := 13;
    i := Pos(';',d);
    if i = 0 then i := Length(d)+1;
    s := Trim(Copy(d,1,i-1));
    Delete(d,1,i);
    IsGroup := False;
    if s <> '' then begin
      { is it a group? }
      if s[length(s)] = '}' then begin
        IsGroup := True;
        Delete(s,length(s),1);
        i := Pos('{',s);
        if i <> 0 then begin
          nme := Trim(Copy(s,1,i-1));
          Delete(s,1,i);
        end;
      end
      else begin
        nme := Form1.ExtractContact(s);
        s := Form1.ExtractNumber(s);
        if s = '' then begin
          { only name specified, so lookup for the number }
          s := Form1.ExtractNumber(Form1.ContactNumberByName(nme));
        end;
        node := Form1.FindExplorerPhoneNode(s,Form1.FNodeContactsME);
        if Assigned(node) then begin
          EData := Form1.ExplorerNew.GetNodeData(node);
          s := EData.Text;
          ptype := EData.ImageIndex;
          node := node.Parent;
          EData := Form1.ExplorerNew.GetNodeData(node);
          nme := EData.Text;
        end
        else begin
          node := Form1.FindExplorerPhoneNode(s,Form1.FNodeContactsSM);
          if Assigned(node) then begin
            EData := Form1.ExplorerNew.GetNodeData(node);
            s := EData.Text;
            ptype := EData.ImageIndex;
            node := node.Parent;
            EData := Form1.ExplorerNew.GetNodeData(node);
            nme := EData.Text;
          end;
        end;
        (*
        if s[length(s)] = ']' then Delete(s,length(s),1);
        i := Pos('[',s);
        { ignore name, we'll lookup for it from phonebook }
        if i <> 0 then Delete(s,1,i);
        if s <> '' then begin
          {}
          num := Form1.LookupNumber(s);  // if we have name instead of number,
          if num <> '' then s := num;    // swap them...
          LookupPerson(s,nme,ptype);
          {
          // search by number
          case Form1.WhereisContact(s,fcByNumber) of
            frIrmcSync: begin
              nme := Form1.frmSyncPhonebook.FindContact(s);
              Form1.frmSyncPhonebook.FindContact(nme,MEdata);
              if Assigned(MEdata) then begin
                GetContactPhoneType(MEdata,s);
                ...
              end;
            end;
            frPhonebook: begin
              nme := Form1.frmMEEdit.FindContact(s);
              Form1.frmMEEdit.FindContact(nme,SMdata);
              ...
            end;
            frSIMCard: begin
              nme := Form1.frmSMEdit.FindContact(s);
              Form1.frmSMEdit.FindContact(nme,SMdata);
              ...
            end;
          end;
          if nme = '' then begin
            // if not found, search by name
            num := Form1.LookupNumber(s);
            case Form1.WhereisContact(s,fcByName) of
              frIrmcSync:
                Form1.frmSyncPhonebook.FindContact(s,MEdata);
                ...
              frPhonebook:
                Form1.frmMEEdit.FindContact(s,SMdata);
                ...
              frSIMCard:
                Form1.frmSMEdit.FindContact(s,SMdata);
                ...
            end;
          end;
          }
        end;
        *)
      end;
    end;
    if s <> '' then
      with SelectedList.Items.Add do begin
        if nme = '' then nme := Form1.LookupContact(s,sUnknownContact);
        Caption := nme;
        SubItems.Add(s);
        if IsGroup then
          ImageIndex := 1
        else
          StateIndex := ptype;
        if not AllowMultiSelect then break;
      end;
  until d = '';
end;

procedure TfrmSelContact.DoSelectDefaultItem;
begin
  { Do nothing here! see frmGetContact for details. }
end;

procedure TfrmSelContact.OkButtonClick(Sender: TObject);
begin
  if SelectedList.Items.Count = 0 then
    MessageDlgW(_('You have to select recipients.'),mtInformation,MB_OK)
  else
    ModalResult := mrOk;
end;

procedure TfrmSelContact.PopupMenu1Popup(Sender: TObject);
begin
  Properties1.Enabled := TntListView1.SelCount = 1;
end;

end.

