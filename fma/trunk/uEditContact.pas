unit uEditContact;

{
*******************************************************************************
* Descriptions: Edit phone contact
* $Source: /cvsroot/fma/fma/uEditContact.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uEditContact.pas,v $
*
*******************************************************************************
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics,
  Controls, TntControls, Forms, TntForms, Dialogs, TntDialogs, ExtCtrls, TntExtCtrls, StdCtrls, TntStdCtrls,
  ComCtrls, TntComCtrls, UniTntCtrls, Buttons, TntButtons, uSyncPhonebook, Menus, TntMenus, MPlayer, GR32_Image,
  uContactSync, VirtualTrees, uVCard, ImgList, Mask, DateUtils;

type
  TfrmEditContact = class(TTntForm)
    PageControl1: TTntPageControl;
    tsGeneral: TTntTabSheet;
    TntImage: TTntImage;
    Bevel1: TTntBevel;
    Label1: TTntLabel;
    txtTitle: TTntEdit;
    txtName: TTntEdit;
    Label2: TTntLabel;
    Label4: TTntLabel;
    txtOrganization: TTntEdit;
    Label5: TTntLabel;
    Bevel2: TTntBevel;
    Label6: TTntLabel;
    txtHome: TTntEdit;
    Label7: TTntLabel;
    txtWork: TTntEdit;
    Label8: TTntLabel;
    txtCell: TTntEdit;
    Label9: TTntLabel;
    txtFax: TTntEdit;
    Label10: TTntLabel;
    txtOther: TTntEdit;
    TabSheet2: TTntTabSheet;
    OkButton: TTntButton;
    CancelButton: TTntButton;
    ApplyButton: TTntButton;
    GroupBox1: TTntGroupBox;
    Panel1: TTntPanel;
    btnPicSel: TTntButton;
    Label12: TTntLabel;
    Label13: TTntLabel;
    lblPicDim: TTntLabel;
    Label15: TTntLabel;
    imgDim: TTntImage;
    lblPicName: TTntLabel;
    lblPicSize: TTntLabel;
    btnPicNew: TTntButton;
    GroupBox2: TTntGroupBox;
    btnPicDel: TTntButton;
    Label14: TTntLabel;
    Label16: TTntLabel;
    Label17: TTntLabel;
    btnSndNew: TTntButton;
    btnSndDel: TTntButton;
    btnSndSel: TTntButton;
    imgSnd: TTntImage;
    lblSndType: TTntLabel;
    lblSndName: TTntLabel;
    lblSndSize: TTntLabel;
    Label11: TTntLabel;
    lblPicPal: TTntLabel;
    TabSheet3: TTntTabSheet;
    Label18: TTntLabel;
    ResetButton: TTntButton;
    Label19: TTntLabel;
    tsCallPrefs: TTntTabSheet;
    GroupBox3: TTntGroupBox;
    cbDefaultNum: TTntComboBox;
    Label20: TTntLabel;
    Label21: TTntLabel;
    Label22: TTntLabel;
    Label23: TTntLabel;
    PopupMenu1: TTntPopupMenu;
    MediaPlayer1: TMediaPlayer;
    SelImage: TImage32;
    txtDisplayAs: TTntComboBox;
    TabSheet5: TTntTabSheet;
    Label34: TTntLabel;
    tsCallNotes: TTntTabSheet;
    GroupBox6: TTntGroupBox;
    CheckBox1: TTntCheckBox;
    SaveDialog1: TTntSaveDialog;
    GroupBox8: TTntGroupBox;
    RadioButton1: TTntRadioButton;
    RadioButton2: TTntRadioButton;
    RadioButton3: TTntRadioButton;
    Button2: TTntButton;
    TabSheet7: TTntTabSheet;
    Label28: TTntLabel;
    txtStreet: TTntEdit;
    Label30: TTntLabel;
    txtCity: TTntEdit;
    Label31: TTntLabel;
    txtRegion: TTntEdit;
    txtPostalCode: TTntEdit;
    Label32: TTntLabel;
    txtCountry: TTntEdit;
    Label33: TTntLabel;
    TntImage1: TTntImage;
    TntBevel1: TTntBevel;
    TntLabel1: TTntLabel;
    TntImage2: TTntImage;
    TntLabel2: TTntLabel;
    TntBevel2: TTntBevel;
    TntImage3: TTntImage;
    TntLabel3: TTntLabel;
    TntBevel3: TTntBevel;
    Label3: TTntLabel;
    txtContactDataID: TTntEdit;
    Label26: TTntLabel;
    UnlinkOutlookButton: TTntButton;
    Label25: TTntLabel;
    txtFileAs: TTntEdit;
    Label27: TTntLabel;
    MemoDetails: TTntMemo;
    TntBevel4: TTntBevel;
    btNotesClear: TTntButton;
    btNotesSave: TTntButton;
    MemoNotes: TTntMemo;
    Label29: TTntLabel;
    TntImage4: TTntImage;
    TntLabel4: TTntLabel;
    TntBevel6: TTntBevel;
    TntLabel5: TTntLabel;
    TntBevel7: TTntBevel;
    TntLabel6: TTntLabel;
    txtAddressType: TTntComboBox;
    TntTabSheet1: TTntTabSheet;
    TntImage5: TTntImage;
    TntLabel7: TTntLabel;
    TntBevel5: TTntBevel;
    TntLabel8: TTntLabel;
    txtURL: TTntEdit;
    TntLabel9: TTntLabel;
    lvEmails: TTntListView;
    MailAddButton: TTntButton;
    MailEditButton: TTntButton;
    MailDelButton: TTntButton;
    MailPrefButton: TTntButton;
    ImageList1: TImageList;
    txtBirthday: TTntDateTimePicker;
    TntBevel8: TTntBevel;
    TntLabel10: TTntLabel;
    TntBevel9: TTntBevel;
    TntLabel11: TTntLabel;
    BirthdayDeleteButton: TTntButton;
    lblDisabledPostal: TTntLabel;
    PostalDeleteButton: TTntButton;
    NumbersHistoryButton: TTntButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txtCustomChange(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure txtTelKeyPress(Sender: TObject; var Key: Char);
    procedure ResetButtonClick(Sender: TObject);
    procedure TabSheet4Show(Sender: TObject);
    procedure txtPhoneChange(Sender: TObject);
    procedure txtPhoneEnter(Sender: TObject);
    procedure btnPicSelClick(Sender: TObject);
    procedure btnSndSelClick(Sender: TObject);
    procedure OnPicSelClick(Sender: TObject);
    procedure OnSndSelClick(Sender: TObject);
    procedure btnPicDelClick(Sender: TObject);
    procedure btnSndDelClick(Sender: TObject);
    procedure MediaPlayer1Click(Sender: TObject; Button: TMPBtnType;
      var DoDefault: Boolean);
    procedure PageControl1Change(Sender: TObject);
    procedure btnUploadClick(Sender: TObject);
    procedure txtChangeEditAs(Sender: TObject);
    procedure OnChangeAsEnter(Sender: TObject);
    procedure UnlinkOutlookButtonClick(Sender: TObject);
    procedure btNotesClearClick(Sender: TObject);
    procedure MemoNotesChange(Sender: TObject);
    procedure btNotesSaveClick(Sender: TObject);
    procedure txtChange(Sender: TObject);
    procedure txtDisplayAsChange(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure txtAddressTypeChange(Sender: TObject);
    procedure MailAddButtonClick(Sender: TObject);
    procedure MailPrefButtonClick(Sender: TObject);
    procedure MailEditButtonClick(Sender: TObject);
    procedure MailDelButtonClick(Sender: TObject);
    procedure lvEmailsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvEmailsDblClick(Sender: TObject);
    procedure BirthdayDeleteButtonClick(Sender: TObject);
    procedure txtBirthdayChange(Sender: TObject);
    procedure PostalDeleteButtonClick(Sender: TObject);
    procedure NumbersHistoryButtonClick(Sender: TObject);
  private
    { Private declarations }
    FAddress: integer; // the index of last shown address
    FAddresses: array[0..1] of TPostalAddress;
    FPhonePrev: string;
    FPrevChangeAs,FMoreNumbers: WideString;
    FUseSIMMode,FLoadingData,FUseOwnMode: boolean;
    FCustomImage,FSwappingAdr: Boolean;
    function PhonesCount: integer;
    function PrefEmailIndex: integer;
    procedure DoSetModified;
    procedure DoSanityCheck;
    procedure DoEmailCheck(AMail: WideString);
    procedure LoadContactData;
    procedure SaveContactData;
    procedure ShowFullName(Modified: WideString = '');
    procedure FillInternetAdrs;
    procedure FillPostalAdrs;
    procedure FillDisplayNameList;
    procedure UpdateDefNum(SetTo: integer = 0);
    procedure UpdatePersonalize;
    procedure SelectFile(Pos: TPoint; FileType: byte; Selected: WideString = '');
    procedure SyncContactsError(Sender: TObject; const Message: String);
    procedure SyncContactsConfirm(Sender: TObject; Contact: TContact;
      Action: TContactAction; const Description: WideString;
      var Confirmed: Boolean);
    procedure SetCustomModified;
    procedure Set_UseSIMMode(const Value: boolean);
    procedure Set_UseOwnMode(const Value: boolean);
    procedure Set_CustomImage(const Value: Boolean);
    function Get_Notes: TTntStrings;
  public
    MaxFullNameLen: integer;
    IsNew,Modified,customModified: boolean;
    contact: TContactData;
  published
    procedure LoadAndMergeWith(AContact: TContactData);
    property UseSIMMode: boolean read FUseSIMMode write Set_UseSIMMode default False;
    property UseOwnMode: boolean read FUseOwnMode write Set_UseOwnMode default False;
    property IsCustomImage: Boolean read FCustomImage write Set_CustomImage;
    property ContactNotes: TTntStrings read Get_Notes;
  end;

var
  frmEditContact: TfrmEditContact;

implementation

uses
  gnugettext, gnugettexthelpers,
  uGlobal, uLogger, Unit1, uFiles, uDialogs, uImg32Helper, uInputQuery, uPhoneHistory;

{$R *.dfm}

procedure TfrmEditContact.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);
  { Populate images }
  TntImage1.Picture.Assign(TntImage.Picture);
  TntImage2.Picture.Assign(TntImage.Picture);
  TntImage3.Picture.Assign(TntImage.Picture);
  TntImage4.Picture.Assign(TntImage.Picture);
  TntImage5.Picture.Assign(TntImage.Picture);
  { Align personalization widgets }
  lblPicDim.Left := imgDim.Left + imgDim.Width + 4;
  lblPicName.Left := Label13.Left + Label13.Width + 4;
  lblPicSize.Left := Label15.Left + Label15.Width + 4;
  lblPicPal.Left := Label11.Left + Label11.Width + 4;
  lblSndType.Left := imgSnd.Left + imgSnd.Width + 4;
  lblSndName.Left := Label14.Left + Label14.Width + 4;
  lblSndSize.Left := Label16.Left + Label16.Width + 4;
  //lblDisabledPostal.Font.Color := clRed;
{$IFNDEF VER150}
  Form1.ThemeManager1.CollectForms(Self);
{$ENDIF}
end;

procedure TfrmEditContact.txtDisplayAsChange(Sender: TObject);
begin
  { Populate Display Name }
  TntLabel1.Caption := txtDisplayAs.Text;
  TntLabel2.Caption := txtDisplayAs.Text;
  TntLabel3.Caption := txtDisplayAs.Text;
  TntLabel4.Caption := txtDisplayAs.Text;
  TntLabel7.Caption := txtDisplayAs.Text;
  DoSetModified;
end;

procedure TfrmEditContact.FormShow(Sender: TObject);
begin
  MaxFullNameLen := txtName.MaxLength;
  LoadContactData;
  PageControl1.ActivePageIndex := 0;
  if Form1.IsT610Clone then begin
    { Hide postal adress tab if not supported by phone (T610 clones) }
    TabSheet7.Enabled := False;
    lblDisabledPostal.Visible := True;
  end;
  if not Form1.IsK610orBetter then begin
    txtURL.Enabled := False;
    txtAddressType.Enabled := False;
  end;
  txtBirthday.Enabled := Form1.IsK750orBetter;
  ResetButton.Enabled := not IsNew;
  UnlinkOutlookButton.Enabled := not IsNew;
  txtName.SetFocus;
end;

procedure TfrmEditContact.LoadContactData;
var
  c: TColor;
  b: boolean;
  w: WideString;
  procedure UpdateTelView(var Item: TTntEdit);
  begin
    { Always enable, and disable only empty Edits }
    if b or (Item.Text = '') then begin
      Item.Enabled := b;
      Item.Color := c;
    end;
  end;
begin
  FLoadingData := True;
  try
    FPrevChangeAs := '';
    FPhonePrev := '';
    if FUseSIMMode then c := clBtnFace else c := clWindow;
    b := not FUseSIMMode;
    // contact
    txtTitle.Text := contact.title;
    w := contact.name;
    if contact.surname <> '' then
      w := w + ' ' + contact.surname; // do not use GetContactFullName here!
    txtName.Text := w;
    txtContactDataID.Text := GUIDToString(contact.CDID);
    txtFileAs.Text := contact.displayname;
    txtDisplayAs.Text := contact.displayname;
    txtOrganization.Text := contact.org;
    txtBirthday.Date := contact.Birthday;
    txtBirthdayChange(nil);
    txtHome.Text := contact.home;
    txtWork.Text := contact.work;
    txtCell.Text := contact.cell;
    txtFax.Text := contact.fax;
    txtOther.Text := contact.other;
    FillPostalAdrs;
    FillInternetAdrs;
    ShowFullName;
    FillDisplayNameList;
    FMoreNumbers := contact.morenums;
    if not (FUseSIMMode or FUseOwnMode) then begin
      // Personalize, will fill data on tabsheet open
      btnPicDel.Click;
      btnSndDel.Click;
      // Preferences
      UpdateDefNum(contact.DefaultIndex);
    end;
    { Leave only used field for editing, or enable all fields for new contacts }
    if FUseSIMMode then begin
      if (txtCell.Text <> '') or (txtHome.Text <> '') or (txtWork.Text <> '') or
        (txtFax.Text <> '') or (txtOther.Text <> '') then begin
        UpdateTelView(txtCell);
        UpdateTelView(txtHome);
        UpdateTelView(txtWork);
        UpdateTelView(txtFax);
        UpdateTelView(txtOther);
      end
      else if Form1.ExplorerNew.FocusedNode = Form1.FNodeContactsSM then begin
        { Creating a New Contact in SIM Card - enable only cell phone }
        UpdateTelView(txtHome);
        UpdateTelView(txtWork);
        UpdateTelView(txtFax);
        UpdateTelView(txtOther);
      end;
    end
    else
      GetContactDetails(@contact,MemoDetails.Lines);
    GetContactNotes(@contact,MemoNotes.Lines);
    MemoNotesChange(nil);
  finally
    FLoadingData := False;
  end;
  // done
  ApplyButton.Enabled := False;
  Modified := False;
  customModified := False;
end;

procedure TfrmEditContact.SaveContactData;
var
  i,j: integer;
  s,a: WideString;
begin
  contact.title := txtTitle.text;
  contact.org := txtOrganization.text;
  { Update contact name and surname }
  a := GetContactFullName(@contact);
  s := Trim(txtName.text);
  i := Pos(' ',s);
  if i = 0 then begin
    contact.name := s;
    contact.surname := '';
  end
  else begin
    contact.name := Copy(s,1,i-1);
    Delete(s,1,i);
    contact.surname := Trim(s);
  end;
  (* Commented out since will keep DisplayName as fma internal setting
  s := GetContactFullName(@contact);
  if WideCompareText(a,s) <> 0 then
    { If name/surname are changed, reset display name, since SE T610
      doesnt support displayname vCard peoperty }
    txtDisplayAs.Text := s;
  *)
  contact.displayname := txtDisplayAs.Text;
  contact.home := txtHome.text;
  contact.work := txtWork.text;
  contact.cell := txtCell.text;
  contact.fax := txtFax.text;
  contact.other := txtOther.text;
  contact.homepage := txtURL.text;
  { birthday }
  contact.Birthday := DateOf(txtBirthday.Date);
  { internet }
  a := '';
  i := PrefEmailIndex;
  if i <> -1 then contact.email := lvEmails.Items[i].Caption
    else contact.email := '';
  for j := 0 to lvEmails.Items.Count-1 do
    if i <> j then a := a + lvEmails.Items[j].Caption + sLineBreak;
  contact.moremails := a;
  { postal }
  txtAddressTypeChange(nil); // save current changes to FAddresses
  contact.homeAddress := FAddresses[0];
  contact.workAddress := FAddresses[1];
  contact.morenums := FMoreNumbers;
  //See SyncPhonebook to save notes. SetContactNotes(@contact,MemoNotes.Lines);
  if not (FUseSIMMode or FUseOwnMode) then begin
    contact.DefaultIndex := cbDefaultNum.ItemIndex;
    contact.picture := lblPicName.Caption;
    contact.sound := lblSndName.Caption;
    contact.CDID := StringToGUID(txtContactDataID.Text);
  end;
  { Dont reset modified flags here, since we'll use them in SyncPhonebook. Only disable apply button. }
  ApplyButton.Enabled := False;
end;

procedure TfrmEditContact.ApplyButtonClick(Sender: TObject);
begin
  DoSanityCheck;
  SaveContactData;
end;

procedure TfrmEditContact.OkButtonClick(Sender: TObject);
begin
  DoSanityCheck;
  if ApplyButton.Enabled or IsNew then
    SaveContactData;
  ModalResult := mrOk;  
end;

procedure TfrmEditContact.txtTelKeyPress(Sender: TObject; var Key: Char);
begin
  case ord(Key) of
    8, 48..57: ;
    35, 42: ; // # and * (for special service numbers)
    3, 22, 24, 26: ; //escape CTRL+C,V,X,Z ;)
    43: with (Sender as TTntEdit) do begin
      if (Pos('+',Text) <> 0) or (SelStart <> 0) then begin
        Key := #0;     //only the first char can be '+'
        Beep;
      end;
    end;
    112: ; // p (pause)
    else begin
      Key := #0;
      Beep;
    end;
  end;
end;

procedure TfrmEditContact.ResetButtonClick(Sender: TObject);
begin
  if MessageDlgW(_('Are you sure you want to reset positions?'),
    mtConfirmation, MB_YESNO or MB_DEFBUTTON2) = ID_YES then begin
    ResetButton.Enabled := False;
    FillChar(contact.Position,SizeOf(contact.Position),0);
    SetCustomModified;
  end;  
end;

procedure TfrmEditContact.TabSheet4Show(Sender: TObject);
begin
  UpdateDefNum;
end;

procedure TfrmEditContact.UpdateDefNum(SetTo: integer);
var
  selpos: integer;
begin
  if SetTo = 0 then selpos := cbDefaultNum.ItemIndex else selpos := SetTo;
  cbDefaultNum.Items.Clear;
  // see TContactData.DefaultIndex
  // 0 none;1 cell;2 work;3 home;4 other
  cbDefaultNum.Items.Add(_('None'));
  if txtCell.Text <> '' then cbDefaultNum.Items.Add(Format(_('Mobile [%s]'), [txtCell.Text]));
  if txtWork.Text <> '' then cbDefaultNum.Items.Add(Format(_('Work [%s]'), [txtWork.Text]));
  if txtHome.Text <> '' then cbDefaultNum.Items.Add(Format(_('Home [%s]'), [txtHome.Text]));
  if txtOther.Text <> '' then cbDefaultNum.Items.Add(Format(_('Other [%s]'), [txtOther.Text]));
  if (selpos < 0) or (selpos >= cbDefaultNum.Items.Count) then
    selpos := 0; // Out of range goes to None
  cbDefaultNum.ItemIndex := selpos;
end;

procedure TfrmEditContact.txtCustomChange(Sender: TObject);
begin
  SetCustomModified;
end;

procedure TfrmEditContact.txtPhoneChange(Sender: TObject);
const
  sem: boolean = False;
var
  i: integer;
  s: string;
  b: boolean;
begin
  if {not FLoadingData and} not sem then
    try
      sem := true;
      with (Sender as TTntEdit) do begin
        b := False;
        s := Text;
        i := 1;
        while i <= Length(s) do begin
          if ((i > 1) and (s[1] = '+') and (s[i] = '+')) or
            (Pos('+',s) > 1) or not (s[i] in ['+','0'..'9','#','*','p']) then begin // do not localize
              Delete(s,i,1);
              b := True;
            end
          else
            inc(i);
        end;
        if s <> Text then Text := s;
        if s <> FPhonePrev then begin
          FPhonePrev := s;
          ApplyButton.Enabled := not IsNew;
          Self.Modified := True;
        end;
        if b then Beep;
      end;
    finally
      sem := False;
    end;
end;

procedure TfrmEditContact.txtPhoneEnter(Sender: TObject);
begin
  FPhonePrev := (Sender as TTntEdit).Text;
end;

procedure TfrmEditContact.Set_UseSIMMode(const Value: boolean);
var
  i: integer;
  c: TColor;
  b: boolean;
begin
  FUseSIMMode := Value;
  if Value then c := clBtnFace else c := clWindow;
  b := not Value;
  txtTitle.Enabled := b;
  txtTitle.Color := c;
  txtOrganization.Enabled := b;
  txtOrganization.Color := c;
  txtBirthday.Enabled := b;
  txtBirthday.Color := c;
  txtBirthdayChange(nil);
  txtDisplayAs.Enabled := b;
  txtDisplayAs.Color := c;
  { In SIM mode leave only General tab visible }
  for i := 0 to PageControl1.PageCount-1 do
    if (PageControl1.Pages[i] <> tsCallNotes) and (PageControl1.Pages[i] <> tsCallPrefs) and
      (PageControl1.Pages[i] <> tsGeneral) then
      PageControl1.Pages[i].TabVisible := b;
end;

procedure TfrmEditContact.SelectFile(Pos: TPoint; FileType: byte; Selected: WideString);
var
  m: TTntMenuItem;
  Node{,Item}: PVirtualNode;
  EData: PFmaExplorerNode;
  Offline: boolean;
  What: string;
  ImgIdx: integer;
  rec: TSearchRec;
  procedure GatherExternalFiles(FromFile: TFile; MenuItem: TTntMenuItem; FileType: integer);
  var
    i: integer;
    NewMenuItem: TTntMenuItem;
    CurFile: TFile;
    data: PFmaExplorerNode;
  begin
    if FromFile.FileType = ftDir then begin
      for i := 0 to FromFile.Count - 1 do begin
        CurFile := FromFile.DirContent[i];
        { Add menu item }
        NewMenuItem := TTntMenuItem.Create(nil);
        try
          NewMenuItem.Caption := CurFile.ExternalName;
          NewMenuItem.Hint := CurFile.FullPath;
          NewMenuItem.Tag := CurFile.Size;
          NewMenuItem.AutoHotkeys := maManual;
          data := Form1.ExplorerNew.GetNodeData(CurFile.TreeNode);
          NewMenuItem.ImageIndex := data.ImageIndex;
          MenuItem.Add(NewMenuItem);
        except
          NewMenuItem.Free;
        end;
        { Set item handler }
        case CurFile.FileType of
          ftDir:
            GatherExternalFiles(FromFile.DirContent[i], NewMenuItem, FileType);
          ftFile:
            case FileType of
              0: NewMenuItem.OnClick := OnPicSelClick;
              1: NewMenuItem.OnClick := OnSndSelClick;
            end;
        end;
      end;
    end;
  end;
begin
  Offline := not Form1.FConnected or not Form1.FUseObex;
  PopupMenu1.Items.Clear;
  if Offline then begin
    case FileType of
      0: What := 'pic\*.*'; // do not localize
      1: What := 'snd\*.*'; // do not localize
    end;
    if FindFirst(Form1.GetProfilePath+What,faAnyFile,rec) = 0 then
    try
      repeat
        ImgIdx := Form1.ExplorerFindExtImage(ExtractFileExt(rec.Name));
        if ImgIdx = -1 then continue;
        m := TTntMenuItem.Create(nil);
        try
          m.AutoHotkeys := maManual;
          m.Caption := rec.Name;
          m.Tag := rec.Size;
          m.Hint := rec.Name; // ignored in offline mode
          m.ImageIndex := ImgIdx;
          case FileType of
            0: m.OnClick := OnPicSelClick;
            1: m.OnClick := OnSndSelClick;
          end;
          if Selected <> '' then begin
            if WideCompareText(rec.Name,Selected) = 0 then begin
              m.Click;
              m.Free;
              break;
            end;
            m.Free;
          end
          else
            PopupMenu1.Items.Add(m);
        except
          m.Free;
        end;
      until FindNext(rec) <> 0;
    finally
      FindClose(rec);
    end;
  end
  else begin
    Node := Form1.FindObexFolderNode(FileType);
    EData := Form1.ExplorerNew.GetNodeData(Node);
    if Assigned(Node) then
      GatherExternalFiles(TFile(EData.Data), TTntMenuItem(PopupMenu1.Items), Filetype);
  end;
  if PopupMenu1.Items.Count = 0 then begin
    MessageBeep(MB_ICONASTERISK);
    MessageDlgW(_('You should refresh Explorer Files folder prior using this feature.'+
      sLinebreak+sLinebreak+
      'Note that this is currently not supported if you are using IR connection.'),mtInformation, MB_OK);
  end
  else
    PopupMenu1.Popup(pos.X,pos.Y);
end;

procedure TfrmEditContact.btnPicSelClick(Sender: TObject);
var
  p: TPoint;
begin
  p := btnPicSel.ClientToScreen(Point(btnPicSel.Width,0));
  SelectFile(p,0);
end;

procedure TfrmEditContact.btnSndSelClick(Sender: TObject);
var
  p: TPoint;
begin
  p := btnSndSel.ClientToScreen(Point(btnSndSel.Width,0));
  SelectFile(p,1);
end;

procedure TfrmEditContact.OnPicSelClick(Sender: TObject);
var
  Filename,Fullpath,Objectname: WideString;
  Filesize: integer;
begin
  btnPicSel.Enabled := False;
  btnSndSel.Enabled := False;
  FLoadingData := True;
  try
    Objectname := (Sender as TTntMenuItem).Hint;
    Filename := (Sender as TTntMenuItem).Caption;
    Filesize := (Sender as TTntMenuItem).Tag;
    Fullpath := Form1.GetProfilePath+'pic\'; // do not localize

    lblPicDim.Caption := '';
    lblPicSize.Caption := '';
    lblPicPal.Caption := '';
    lblPicName.Caption := Format(_('(Loading %s...)'), [Filename]);

    try
      ForceDirectories(Fullpath);
      if Form1.FConnected and Form1.FUseObex and not FileExists(Fullpath+Filename) then
        Form1.ObexGetFile(Fullpath+Filename,Objectname,False);
      { Use uGlobal function }
      LoadBitmap32FromFile(Fullpath+Filename,SelImage.Bitmap);
      IsCustomImage := True;
      btnPicDel.Enabled := True;
    except
      btnPicDel.Click;
      raise;
    end;

    lblPicName.Caption := Filename;
    lblPicDim.Caption := Format(_('%dx%d (%dx%d pixels)'),[SelImage.Width,SelImage.Height,
      SelImage.Bitmap.BitmapInfo.bmiHeader.biWidth,-SelImage.Bitmap.BitmapInfo.bmiHeader.biHeight]);
    lblPicSize.Caption := Format(_('%.1n KB (%d bytes)'),[Filesize / 1024,Filesize]);
    case SelImage.Bitmap.BitmapInfo.bmiHeader.biBitCount of
       8: lblPicPal.Caption := _('Low-Color (256 colors)');
      16: lblPicPal.Caption := _('Hi-Color (65535 colors)');
      24: lblPicPal.Caption := _('True-Color (24-bit colors)');
      32: lblPicPal.Caption := _('True-Color (32-bit colors)');
      else lblPicPal.Caption := _('Low-Color (<256 colors)');
    end;
    SetCustomModified;
  finally
    btnPicSel.Enabled := True;
    btnSndSel.Enabled := True;
    FLoadingData := False;
  end;
end;

procedure TfrmEditContact.OnSndSelClick(Sender: TObject);
var
  Filename,Fullpath,Objectname: WideString;
  Filesize: integer;
begin
  btnPicSel.Enabled := False;
  btnSndSel.Enabled := False;
  FLoadingData := True;
  try
    Objectname := (Sender as TTntMenuItem).Hint;
    Filename := (Sender as TTntMenuItem).Caption;
    Filesize := (Sender as TTntMenuItem).Tag;
    Fullpath := Form1.GetProfilePath+'snd\'; // do not localize

    lblSndType.Caption := '';
    lblSndSize.Caption := '';
    lblSndName.Caption := Format(_('(Loading %s...)'), [Filename]);

    try
      ForceDirectories(Fullpath);
      if Form1.FConnected and Form1.FUseObex and not FileExists(Fullpath+Filename) then
        Form1.ObexGetFile(Fullpath+Filename,Objectname,False);
      { Load sound file }
      MediaPlayer1.FileName := Fullpath+Filename;
      MediaPlayer1.Enabled := True;
    except
      btnSndDel.Click;
      raise;
    end;

    lblSndName.Caption := Filename;
    lblSndSize.Caption := Format(_('%.1n KB (%d bytes)'),[Filesize / 1024,Filesize]);
    try
      MediaPlayer1.Open;
      lblSndType.Caption := Format(_('Track length is %d samples (Custom format)'),[MediaPlayer1.TrackLength[1]]);
      btnSndDel.Enabled := True;
    except
      lblSndType.Caption := _('Unknown (Unsupported format)');
      MediaPlayer1.Enabled := False;
    end;
    SetCustomModified;
  finally
    btnPicSel.Enabled := True;
    btnSndSel.Enabled := True;
    FLoadingData := False;
  end;
end;

procedure TfrmEditContact.btnPicDelClick(Sender: TObject);
begin
  if FLoadingData or (MessageDlgW(_('Remove personalized picture?'),
    mtConfirmation, MB_YESNO or MB_DEFBUTTON2) = ID_YES) then begin
    if lblPicName.Caption <> '' then begin
      SetCustomModified;
    end;
    lblPicDim.Caption := _('128x127 (0x0 pixels)');
    lblPicName.Caption := '';
    lblPicSize.Caption := _('0,0 KB (0 bytes)');
    lblPicPal.Caption := _('Hi-Color (65535 colors)');
    SelImage.Bitmap.Clear;
    IsCustomImage := False;
    btnPicDel.Enabled := False;
  end;
end;

procedure TfrmEditContact.btnSndDelClick(Sender: TObject);
begin
  if FLoadingData or (MessageDlgW(_('Remove personalized sound?'),
    mtConfirmation, MB_YESNO or MB_DEFBUTTON2) = ID_YES) then begin
    if lblSndName.Caption <> '' then begin
      SetCustomModified;
    end;
    lblSndType.Caption := _('(polyphonic stereo sound, supported by phone)');
    lblSndName.Caption := '';
    lblSndSize.Caption := _('0,0 KB (0 bytes)');
    MediaPlayer1.Close;
    MediaPlayer1.Enabled := False;
    btnSndDel.Enabled := False;
  end;
end;

procedure TfrmEditContact.UpdatePersonalize;
var
  m: TTntMenuItem;
  f: TFileStream;
  amod,cmod,OldApply: boolean;
  procedure LoadFile(fname: string; ftype: byte);
  var
    dir: string;
  begin
    { Emulate popup menu click here in order to select default
      contact picture/sound file. }
    case ftype of
      0: dir := 'pic\'; // do not localize
      1: dir := 'snd\'; // do not localize
    end;
    m := TTntMenuItem.Create(nil);
    try
      m.Caption := fname;
      m.Hint := fname; // phone's objectname
      try
        f := TFileStream.Create(Form1.GetProfilePath+dir+fname,fmOpenRead);
        try
          m.Tag := f.Size;
        finally
          f.Free;
        end;
      except
        m.Tag := 0;
      end;
      case ftype of
        0: OnPicSelClick(m);
        1: OnSndSelClick(m);
      end;
    finally
      m.Free;
    end;
  end;
begin
  OldApply := ApplyButton.Enabled;
  { Show window while updateing }
  TabSheet2.Update;
  amod := Modified;
  cmod := customModified;
  { Load personalization files on tabsheet enter }
  if (lblPicName.Caption = '') and (contact.picture <> '') then
    LoadFile(contact.picture,0);
  if (lblSndName.Caption = '') and (contact.sound <> '') then
    LoadFile(contact.sound,1);
  Modified := amod;
  customModified := cmod;
  ApplyButton.Enabled := OldApply;
end;

procedure TfrmEditContact.MediaPlayer1Click(Sender: TObject;
  Button: TMPBtnType; var DoDefault: Boolean);
begin
  if Button = btStop then MediaPlayer1.Rewind;
end;

procedure TfrmEditContact.PageControl1Change(Sender: TObject);
begin
  case PageControl1.ActivePageIndex of
    1: UpdatePersonalize;
    2: UpdateDefNum;
  end;
end;

procedure TfrmEditContact.Set_UseOwnMode(const Value: boolean);
var
  i: integer;
begin
  FUseOwnMode := Value;
  { In Edit Own Card mode leave only General tab visible }
  for i := 1 to PageControl1.PageCount-1 do
    PageControl1.Pages[i].TabVisible := not FUseOwnMode;
end;

procedure TfrmEditContact.btnUploadClick(Sender: TObject);
var
  m: TTntMenuItem;
  ObjType: integer;
begin
  Form1.AskRequestConnection;
  btnPicNew.Enabled := False;
  btnSndNew.Enabled := False;
  try
    ObjType := TTntButton(Sender).Tag;
    if not Form1.FUseObex then
      raise EInOutError.Create(_('OBEX is not supported or disabled'));
    if Form1.FConnected and Form1.ActionToolsUpload.Execute then begin
      m := TTntMenuItem.Create(nil);
      try
        m.AutoHotkeys := maManual;
        m.Caption := WideExtractFileName(Form1.ObexOpenDialog.FileName);
        m.Hint := Form1.FindObexFolderName(ObjType)+'/'+m.Caption;
        if ObjType = 0 then
          m.OnClick := OnPicSelClick  // image
        else
          m.OnClick := OnSndSelClick; // sound
        { select it }
        m.Click;
      finally
        m.Free;
      end;
    end;
  finally
    btnPicNew.Enabled := True;
    btnSndNew.Enabled := True;
  end;
end;

procedure TfrmEditContact.DoSanityCheck;
var
  TelCnt: integer;
  s: WideString;
begin
  s := Trim(txtName.Text);
  if (s = '') and (Trim(txtOrganization.Text) <> '') then s := Trim(txtOrganization.Text);
  { check name }
  if s = '' then begin
    MessageDlgW(_('You have to enter contact or company name.'), mtError, MB_OK);
    Abort;
  end;
  if Pos('"',s) <> 0 then begin
    if FUseSIMMode then begin
      MessageDlgW(_('Quotes are not allowed in SIM contact name.'), mtError, MB_OK);
      Abort;
    end;
  end;
  if Trim(txtDisplayAs.Text) = '' then
    txtDisplayAs.Text := s;
  { check numbers }
  TelCnt := PhonesCount;
  if FUseSIMMode and (TelCnt = 0) then begin
    MessageDlgW(_('You have to enter contact phone number.'), mtError, MB_OK);
    Abort;
  end;
  if FUseSIMMode and (TelCnt > 1) then begin
    MessageDlgW(_('You have to enter only one phone number.'), mtError, MB_OK);
    Abort;
  end;
  { check date }
  if BirthdayDeleteButton.Enabled and (txtBirthday.Date >= Now) then begin
    MessageDlgW(_('You have to enter valid birthday date.'), mtError, MB_OK);
    Abort;
  end;
end;

procedure TfrmEditContact.FillDisplayNameList;
var
  w,s: WideString;
  i: integer;
  IgnoreOrg: boolean;
begin
  IgnoreOrg := False;
  txtDisplayAs.Items.Clear;
  s := Trim(txtName.Text);
  if (s = '') and (Trim(txtOrganization.Text) <> '') then begin
    s := Trim(txtOrganization.Text);
    IgnoreOrg := True;
  end;
  if s <> '' then begin
    { Move surname in front }
    w := s;
    if not IgnoreOrg then begin
      i := Length(w);
      while (i >= 1) and (w[i] <> ' ') do dec(i);
      s := Copy(w,1,i-1);
      w := Copy(w,i+1,Length(w));
      if s <> '' then w := w + ', ' + Trim(s);
    end;
    { Fill list }
    txtDisplayAs.Items.Add(s);
    if not IgnoreOrg and (txtOrganization.Text <> '') then
      txtDisplayAs.Items.Add(txtName.Text + ' ' + txtOrganization.Text);
    if WideCompareText(w,s) <> 0 then begin
      txtDisplayAs.Items.Add(w);
      if not IgnoreOrg and (txtOrganization.Text <> '') then
        txtDisplayAs.Items.Add(w + ' ' + txtOrganization.Text);
    end;
    if not IgnoreOrg and (txtTitle.Text <> '') then begin
      txtDisplayAs.Items.Add(txtTitle.Text + ' ' + txtName.Text);
      if txtOrganization.Text <> '' then
        txtDisplayAs.Items.Add(txtTitle.Text + ' ' + txtName.Text + ' ' + txtOrganization.Text);
      if WideCompareText(w,txtName.Text) <> 0 then begin
        txtDisplayAs.Items.Add(txtTitle.Text + ' ' + w);
        if txtOrganization.Text <> '' then
          txtDisplayAs.Items.Add(txtTitle.Text + ' ' + w + ' ' + txtOrganization.Text);
      end;
    end;
  end;
end;

procedure TfrmEditContact.ShowFullName(Modified: WideString);
var
  s,w: WideString;
  i,j: integer;
begin
  s := Trim(txtName.Text);
  if (s = '') and (Trim(txtOrganization.Text) <> '') then s := Trim(txtOrganization.Text);
  if txtDisplayAs.Text = '' then
    txtDisplayAs.Text := s;
  { Update DisplayAs default patterns }
  w := txtDisplayAs.Text;
  i := txtDisplayAs.Items.IndexOf(w);
  { Remove any emptied field }
  if (FPrevChangeAs <> '') and (Modified = '') then begin
    j := Pos(' '+FPrevChangeAs,w);
    if j = 0 then
      j := Pos(FPrevChangeAs+' ',w);
    if j <> 0 then
      Delete(w,j,Length(FPrevChangeAs)+1);
  end;
  { Update predefined values }
  FillDisplayNameList;
  if i <> -1 then begin
    { Predefined value was used, so update it with new fields }
    j := txtDisplayAs.Items.IndexOf(w);
    if j <> -1 then
      { unused field has been changed or field is emptied }
      i := j;
    { do not remove next sanity check, its used when an used field is changed }
    if (i >= 0) and (i < txtDisplayAs.Items.Count) then
      { Set to new predefined value }
      txtDisplayAs.ItemIndex := i;
  end;
  { Update dialog caption }
  if s <> '' then
    if FUseOwnMode then
      Caption := WideFormat(_('Own Business Card - %s'),[s])
    else
      Caption := WideFormat(_('Contact - %s'),[s])
  else
    Caption := _('Contact');
  { Populate changes }
  txtDisplayAsChange(txtDisplayAs);
end;

procedure TfrmEditContact.txtChangeEditAs(Sender: TObject);
var
  w: WideString;
begin
  if not FLoadingData then begin
    w := (Sender as TTntEdit).Text;
    ShowFullName(w);
    FPrevChangeAs := w;
  end;
  DoSetModified;
end;

procedure TfrmEditContact.OnChangeAsEnter(Sender: TObject);
begin
  FPrevChangeAs := (Sender as TTntEdit).Text;
end;

procedure TfrmEditContact.LoadAndMergeWith(AContact: TContactData);
var
  w: WideString;
begin
  LoadContactData;
  txtTitle.Text := AContact.title;
  w := AContact.name;
  if AContact.surname <> '' then
    w := w + ' ' + AContact.surname; // do not use GetContactFullName here!
  txtName.Text := w;
  txtFileAs.Text := AContact.displayname;
  txtOrganization.Text := AContact.org;
  txtBirthday.Date := contact.Birthday;
  txtBirthdayChange(nil);
  txtHome.Text := AContact.home;
  txtWork.Text := AContact.work;
  txtCell.Text := AContact.cell;
  txtFax.Text := AContact.fax;
  txtOther.Text := AContact.other;
  txtURL.Text := AContact.homepage;
  FAddress := -1;
  FAddresses[0] := AContact.homeAddress;
  FAddresses[1] := AContact.workAddress;
  txtAddressType.ItemIndex := 0;
  txtAddressTypeChange(nil);
  if Form1.IsK610orBetter then // notes support for K610+ phones
    GetContactNotes(@AContact,MemoNotes.Lines);
  // - Do not copy displayname, it will be merged
  // txtDisplayAs.Text := AContact.displayname;
  // - Keep old GUID!
  // txtContactDataID.Text := GUIDToString(contact.CDID);
  // - Do not copy personalization!
  // cbDefaultNum.ItemIndex := AContact.DefaultIndex;
  // lblPicName.Caption := AContact.picture;
  // lblSndName.Caption := AContact.sound;
end;

procedure TfrmEditContact.UnlinkOutlookButtonClick(Sender: TObject);
var
  SynchronizeContacts: TSynchronizeContacts;
  Fullpath: String;
begin
  try
    Fullpath := Form1.GetProfilePath+'dat\'; // do not localize
    SynchronizeContacts := TSynchronizeContacts.Create;
    try
      SynchronizeContacts.FileName := Fullpath + 'ContactSync.xml'; // do not localize

      SynchronizeContacts.OnError := SyncContactsError;
      SynchronizeContacts.OnConfirm := SyncContactsConfirm;

      SynchronizeContacts.Unlink(Contact.CDID);
    finally
      SynchronizeContacts.Free;
    end;
  except
    on E: Exception do begin
      Log.AddSynchronizationMessageFmt(_('Error: Unlink aborted (%s: %s)'), [E.ClassName, E.Message], lsError);
      Form1.Status(Format(_('Error: Unlink aborted (%s: %s)'), [E.ClassName, E.Message]));
      MessageDlgW(Format(_('Error: Unlink aborted (%s: %s)'), [E.ClassName, E.Message]), mtError, MB_OK);
    end;
  end;
end;

procedure TfrmEditContact.SyncContactsError(Sender: TObject; const Message: String);
begin
  Log.AddSynchronizationMessageFmt(_('Error: Unlink aborted (%s)'), [Message], lsError);
  Form1.Status(Format(_('Error: Unlink aborted (%s)'), [Message]));
  MessageDlgW(Format(_('Error: Unlink aborted (%s)'), [Message]), mtError, MB_OK);
end;

procedure TfrmEditContact.SyncContactsConfirm(Sender: TObject; Contact: TContact;
    Action: TContactAction; const Description: WideString; var Confirmed: Boolean);
begin
  Confirmed := MessageDlgW(WideFormat(sContactSyncConfirm, [Description]), mtConfirmation, MB_YESNO) = ID_YES;
end;

procedure TfrmEditContact.btNotesClearClick(Sender: TObject);
begin
  MemoNotes.Clear;
  MemoNotesChange(nil);
end;

procedure TfrmEditContact.MemoNotesChange(Sender: TObject);
begin
  btNotesSave.Enabled := Trim(MemoNotes.Text) <> '';
  btNotesClear.Enabled := btNotesSave.Enabled;
  if not (FUseSIMMode or FUseOwnMode) and Form1.IsK610orBetter then
    Modified := True // notes support in K610+ phones...
  else
    customModified := True; // ...or notes are FMA setting
  ApplyButton.Enabled := True;
end;

procedure TfrmEditContact.btNotesSaveClick(Sender: TObject);
begin
  if SaveDialog1.FileName = '' then
    SaveDialog1.FileName := txtName.Text + '.txt'; // do not localize
  if SaveDialog1.Execute then
    MemoNotes.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TfrmEditContact.Set_CustomImage(const Value: Boolean);
begin
  FCustomImage := Value;
  if not Value then
    SelImage.Bitmap.Assign(Form1.CommonBitmaps.Bitmap[0]);
end;

procedure TfrmEditContact.txtChange(Sender: TObject);
begin
  DoSetModified;
end;

procedure TfrmEditContact.CancelButtonClick(Sender: TObject);
begin
  if (not ApplyButton.Enabled and not Modified and (not IsNew or (PhonesCount = 0))) or
    (MessageDlgW(_('Discard current changes?'), mtConfirmation, MB_YESNO or MB_DEFBUTTON2) = ID_YES) then
    ModalResult := mrCancel;
end;

function TfrmEditContact.PhonesCount: integer;
begin
  Result := 0;
  if txtCell.Text <> ''  then inc(Result);
  if txtHome.Text <> ''  then inc(Result);
  if txtWork.Text <> ''  then inc(Result);
  if txtFax.Text <> ''   then inc(Result);
  if txtOther.Text <> '' then inc(Result);
end;

function TfrmEditContact.Get_Notes: TTntStrings;
begin
  Result := MemoNotes.Lines;
end;

procedure TfrmEditContact.txtAddressTypeChange(Sender: TObject);
begin
  FSwappingAdr := True;
  try
    if FAddress <> -1 then with FAddresses[FAddress] do begin
      Street := txtStreet.text;
      City := txtCity.text;
      Region := txtRegion.text;
      PostalCode := txtPostalCode.text;
      Country := txtCountry.text;
    end;
    FAddress := txtAddressType.ItemIndex;
    with FAddresses[FAddress] do begin
      txtStreet.Text := Street;
      txtCity.Text := City;
      txtRegion.Text := Region;
      txtPostalCode.Text := PostalCode;
      txtCountry.Text := Country;
    end;
  finally
    FSwappingAdr := False;
  end;
end;

procedure TfrmEditContact.FillInternetAdrs;
var
  sl: TTntStringList;
  i: integer;
  w: WideString;
begin
  txtURL.Text := contact.homepage;
  lvEmails.Clear;
  if contact.email <> '' then
    with lvEmails.Items.Add do begin
      Caption := contact.email;
      ImageIndex := 1;
    end;
  sl := TTntStringList.Create;
  try
    sl.Text := contact.moremails;
    for i := 0 to sl.Count-1 do begin
      w := Trim(sl[i]);
      if w <> '' then
        with lvEmails.Items.Add do begin
          Caption := w;
          ImageIndex := 0;
        end;
    end;
  finally
    sl.Free;
    lvEmailsSelectItem(lvEmails,nil,False);
  end;
end;

function TfrmEditContact.PrefEmailIndex: integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to lvEmails.Items.Count-1 do
    if lvEmails.Items[i].ImageIndex = 1 then begin
      Result := i;
      break;
    end;
end;

procedure TfrmEditContact.DoEmailCheck(AMail: WideString);
var
  i: integer;
begin
  i := Pos('@',AMail);
  if (i < 2) or (i > Length(AMail)-2) then begin
    MessageDlgW(_('Incorrect e-mail address specified.'),mtError,MB_OK);
    Abort;
  end;
end;

procedure TfrmEditContact.MailPrefButtonClick(Sender: TObject);
var
  i: integer;
begin
  i := PrefEmailIndex;
  if i <> lvEmails.Selected.Index then begin
    lvEmails.Items[i].ImageIndex := 0;
    lvEmails.Selected.ImageIndex := 1;
    DoSetModified;
    MailPrefButton.Enabled := False;
  end;
end;

procedure TfrmEditContact.MailAddButtonClick(Sender: TObject);
var
  w: WideString;
  i: integer;
begin
  w := '';
  if WideInputQuery(_('Add E-mail'),_('E-mail:'),w) then begin
    DoEmailCheck(w);
    i := PrefEmailIndex;
    with lvEmails.Items.Add do begin
      Caption := w;
      if i = -1 then ImageIndex := 1 else ImageIndex := 0;
    end;
    DoSetModified;
    lvEmailsSelectItem(lvEmails,lvEmails.Selected,Assigned(lvEmails.Selected));
  end;
end;

procedure TfrmEditContact.MailEditButtonClick(Sender: TObject);
var
  w: WideString;
begin
  w := lvEmails.Selected.Caption;
  if WideInputQuery(_('Edit E-mail'),_('E-mail:'),w) then begin
    DoEmailCheck(w);
    lvEmails.Selected.Caption := w;
    DoSetModified;
  end;
end;

procedure TfrmEditContact.MailDelButtonClick(Sender: TObject);
var
  i: integer;
begin
  if MessageDlgW(WideFormat(_('Delete e-mail address "%s"?'),[lvEmails.Selected.Caption]),
    mtConfirmation, MB_YESNO or MB_DEFBUTTON2) = ID_YES then begin
    lvEmails.Selected.Delete;
    i := PrefEmailIndex;
    if (i = -1) and (lvEmails.Items.Count <> 0) then
      lvEmails.Items[0].ImageIndex := 1;
    DoSetModified;
    lvEmailsSelectItem(lvEmails,nil,False);
  end;
end;

procedure TfrmEditContact.lvEmailsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  { Allow multiple e-mails for K610+ phones }
  MailAddButton.Enabled := Form1.IsK610orBetter or (lvEmails.Items.Count = 0);
  MailPrefButton.Enabled := Selected and (lvEmails.Selected.ImageIndex <> 1);
  MailEditButton.Enabled := Selected;
  MailDelButton.Enabled := Selected;
end;

procedure TfrmEditContact.DoSetModified;
begin
  if not FSwappingAdr then begin
    ApplyButton.Enabled := not IsNew;
    Modified := True;
  end;
end;

procedure TfrmEditContact.FillPostalAdrs;
begin
  FAddress := -1;
  FAddresses[0] := contact.homeAddress;
  FAddresses[1] := contact.workAddress;
  txtAddressType.ItemIndex := 0;
  txtAddressType.Enabled := Form1.IsK610orBetter;
  txtAddressTypeChange(nil);
end;

procedure TfrmEditContact.lvEmailsDblClick(Sender: TObject);
begin
  if Assigned(lvEmails.Selected) then MailEditButton.Click;
end;

procedure TfrmEditContact.BirthdayDeleteButtonClick(Sender: TObject);
begin
  if MessageDlgW(_('Clear birthday setting?'),mtConfirmation,MB_YESNO or MB_DEFBUTTON2) = ID_YES then begin
    txtBirthday.Date := EmptyDate;
    txtBirthdayChange(nil);
  end;
end;

procedure TfrmEditContact.txtBirthdayChange(Sender: TObject);
begin
  BirthdayDeleteButton.Enabled := txtBirthday.Enabled and not IsEmptyDate(txtBirthday.Date);
  DoSetModified;
end;

procedure TfrmEditContact.PostalDeleteButtonClick(Sender: TObject);
begin
  if MessageDlgW(WideFormat(_('Delete %s postal address?'),[txtAddressType.Text]),
    mtConfirmation,MB_YESNO or MB_DEFBUTTON2) = ID_YES then begin
    txtStreet.Text := '';
    txtCity.Text := '';
    txtRegion.Text := '';
    txtPostalCode.Text := '';
    txtCountry.Text := '';
  end;
end;

procedure TfrmEditContact.NumbersHistoryButtonClick(Sender: TObject);
begin
  with TfrmPhoneHistory.Create(nil) do begin
    Numbers := FMoreNumbers;
    if (ShowModal = mrOk) and (WideCompareText(FMoreNumbers,Numbers) <> 0) then begin
      FMoreNumbers := Numbers;
      SetCustomModified;
    end;
  end;
end;

procedure TfrmEditContact.SetCustomModified;
begin
  ApplyButton.Enabled := not IsNew;
  customModified := True;
end;

end.
