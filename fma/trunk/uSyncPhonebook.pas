unit uSyncPhonebook;

{
*******************************************************************************
* Descriptions: Synchronize's Phonebook Interface
* $Source: /cvsroot/fma/fma/uSyncPhonebook.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uSyncPhonebook.pas,v $
*
*******************************************************************************
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, StrUtils,Classes, TntClasses, Graphics, TntGraphics, Controls,
  TntControls, Forms, TntForms, Dialogs, TntDialogs, Menus, TntMenus, ImgList, VirtualTrees, ExtCtrls, TntExtCtrls,
  StdCtrls, TntStdCtrls, ActnList, TntActnList, Mask, Placemnt, uVcard, uPromptConflict, uConnProgress;

type
  TNumberPos = Record
    home, work, cell, fax, other : integer;
  end;
  TContactData = Record
    title, name, surname, displayname, org, homepage, email, moremails: WideString;
    home, work, cell, fax, other : WideString;
    homeAddress, workAddress: TPostalAddress;
    Birthday, Modified: TDate;
    CDID: TGUID;
    LUID : WideString;
    StateIndex : Integer; //0 new entry;1 modified entry;2 deleted entry;3 normal entry
    DefaultIndex: Integer; //0 none;1 cell;2 work;3 home;4 other
    Position: TNumberPos;
    picture, sound: WideString;
  end;
  PContactData = ^TContactData;

  TfrmSyncPhonebook = class(TTntFrame)
    ListContacts: TVirtualStringTree;
    PopupMenu1: TTntPopupMenu;
    ForceUpdate: TTntMenuItem;
    Exportselectedcontacts1: TTntMenuItem;
    N1: TTntMenuItem;
    ForceNewContact: TTntMenuItem;
    NoItemsPanel: TTntPanel;
    N2: TTntMenuItem;
    Properties1: TTntMenuItem;
    N3: TTntMenuItem;
    NewContact1: TTntMenuItem;
    Delete1: TTntMenuItem;
    N4: TTntMenuItem;
    AddtoGroup1: TTntMenuItem;
    UndoLastChange1: TTntMenuItem;
    SendMsg1: TTntMenuItem;
    voicecall1: TTntMenuItem;
    FormStorage1: TFormStorage;
    ImportContacts1: TTntMenuItem;
    OpenDialog1: TTntOpenDialog;
    ClearChangedFlag1: TTntMenuItem;
    pmNameOrder: TTntPopupMenu;
    FirstLast1: TTntMenuItem;
    LastFirst1: TTntMenuItem;
    N7: TTntMenuItem;
    DownloadEntirePhonebook1: TTntMenuItem;
    ChatContact1: TTntMenuItem;
    pmColumns: TTntPopupMenu;
    NameFormat1: TTntMenuItem;
    N9: TTntMenuItem;
    DisplayColumns1: TTntMenuItem;
    LastFirst2: TTntMenuItem;
    FirstLast2: TTntMenuItem;
    CurrentView1: TTntMenuItem;
    ForceAs1: TTntMenuItem;
    N10: TTntMenuItem;
    SynchronizeTo1: TTntMenuItem;
    Phone1: TTntMenuItem;
    N11: TTntMenuItem;
    Outlook1: TTntMenuItem;
    //List
    procedure ListContactsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure ListContactsCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure ListContactsHeaderClick(Sender: TVTHeader; Column: TColumnIndex;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ListContactsGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure ForceUpdateClick(Sender: TObject);
    procedure ForceNewContactClick(Sender: TObject);
    procedure ListContactsAfterPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure AddToGroupClick(Sender: TObject);
    procedure UndoLastChange1Click(Sender: TObject);
    procedure ListContactsIncrementalSearch(Sender: TBaseVirtualTree;
      Node: PVirtualNode; const SearchText: WideString;
      var Result: Integer);
    procedure ListContactsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ImportContacts1Click(Sender: TObject);
    procedure ClearChangedFlag1Click(Sender: TObject);
    procedure FirstLast1Click(Sender: TObject);
    procedure DownloadEntirePhonebook1Click(Sender: TObject);
    procedure FormStorage1SavePlacement(Sender: TObject);
    procedure FormStorage1RestorePlacement(Sender: TObject);
    procedure ListContactsHeaderMouseUp(Sender: TVTHeader;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PopupHandler(Sender: TObject);
    procedure PopupShowAll(Sender: TObject);
    procedure ListContactsHeaderDragged(Sender: TVTHeader;
      Column: TColumnIndex; OldPosition: Integer);
    procedure pmColumnsPopup(Sender: TObject);
    procedure FirstLast2Click(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnNEWClick(Sender: TObject);
    procedure btnDELClick(Sender: TObject);
    procedure btnSYNCClick(Sender: TObject);
  private
    ConflictVCardPhone,ConflictVCardPC: TVCard;
    VCard: TVCard;
    CC: WideString;
    FUndoEdit: TContactData;
    FUndoIndx: cardinal;
    FSyncProgressDlg: TfrmConnect;
    function IsUniqueGUID(who: PContactData): boolean;
    function Synchronize: boolean;
    function FullRefresh: boolean;
    function CheckInArray(A: array of widestring; S: Widestring): boolean;
    function EraseContact(LUID :Widestring; Log :Boolean = True):Boolean;
    function LFindContact(LUID :Widestring; var AContact: PContactData):Boolean;
    function ResolveConflict(NameContact: WideString; Info:WideString): integer;
    function GetPhoneCapacity: Integer;
    procedure ForceContact(State: integer);
    function RenderListView(const sl: TStrings): boolean;
    procedure RenderGUIDs;
    procedure DoFirstImportCheck;
    procedure DoBuildColumnsPopup(Where: TComponent);
    procedure DoAutosizeLastColumn;
    procedure DoAddCalendarBirthday;
  public
    State: Integer;
    SelContact: PContactData;
    FMaxRecME,FMaxNameLen,FMaxTitleLen,FMaxOrgLen,FMaxMailLen,FMaxTelLen: cardinal;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadContacts(FileName:WideString);
    procedure SaveContacts(FileName:WideString);
    procedure ExportList(FileType:Integer; Filename: WideString);
    procedure OnConnected;
    procedure OnConflictChanges(Sender: TObject; const TargetName, Option1Name, Option2Name: WideString);
    function FindContact(Number: WideString): WideString; overload;
    function FindContact(FullName: WideString; var AContact: PContactData): boolean; overload;
    function FindContact(FullName: WideString; var ANode: PVirtualNode): boolean; overload;
    { Edit contact. NewNumber and ContactData are for external (not Phonebook) contacts, as Own card, and
      SIM contacts editing. NewNumber is default mobile number when creating new contact. }
    function DoEdit(AsNew: boolean = False; NewNumber: string = ''; ContactData: PContactData = nil): boolean;
  end;

function NewGUID: TGUID;

function MigrateContact(OldContact: PContactData; var NewContact: PContactData): boolean;

function vCard2Contact(VCard: TVCard; contact: PContactData): boolean;
function Contact2vCard(contact: PContactData; var VCard: TVCard): boolean;

function NumPos2Str(Pos: TNumberPos): string;
function NumPosEmpty(contact: PContactData): boolean;

function GetvCardFullName(VCard: TVCard): WideString;

function GetContactPostalAddress(contact: PContactData; Linebreak: string = ', '): WideString;
function GetContactDisplayName(contact: PContactData; FamilyFirst: boolean = False): WideString;
function GetContactFullName(contact: PContactData; FamilyFirst: boolean = False): WideString;
procedure SetContactFullName(contact: PContactData; FullName: WideString);
function GetContactDefPhone(contact: PContactData): string;
function GetContactPictureFile(contact: PContactData): string;
function GetContactSoundFile(contact: PContactData): string;

function GetContactFmaid(contact: PContactData): string;
function GetContactNotes(contact: PContactData; Notes: TTntStrings): boolean;
function SetContactNotes(contact: PContactData; Notes: TTntStrings): boolean;
function GetContactDetails(contact: PContactData; Notes: TTntStrings): boolean;
function GetContactHomeAdr(contact: PContactData): WideString;
function GetContactWorkAdr(contact: PContactData): WideString;

function IsContactPhone(contact: PContactData; Phone: string): boolean;
function GetContactPhoneType(contact: PContactData; Phone: string): string;
function ReplaceContactDefPhone(contact: PContactData; Phone: string): string;

function ContactDefPosition(contact: PContactData; SetPosition: integer = -1): integer;
function GetContactPosition(contact: PContactData; Phone: string): integer;
procedure SetContactPosition(contact: PContactData; Phone: string; SetPosition: integer);
procedure SetDisplayName(contact: PContactData; Format: Integer; FamilyFirst: boolean = False;
  Overwrite: boolean = False);

implementation

uses
  gnugettext, gnugettexthelpers, cUnicodeCodecs, uVCalendar,
  uLogger, uThreadSafe, WebUtil, DateUtils, Unit1, uGlobal, uEditContact, ComCtrls, TntComCtrls,
  UniTntCtrls, uAddToGroup, uStatusDlg, IniFiles, uXML, uDialogs, uConflictChanges;

{$R *.dfm}

{ Utils }

function NewGUID: TGUID;
begin
  CreateGUID(Result);
end;

function IsContactPhone(contact: PContactData; Phone: string): boolean;
var
  a,b: string;
begin
  Result := False;
  a := Form1.GetPartialNumber(Phone);
  with contact^ do begin
    b := Form1.GetPartialNumber(cell);
    if a = b then begin
      Result := True;
      exit;
    end;
    b := Form1.GetPartialNumber(work);
    if a = b then begin
      Result := True;
      exit;
    end;
    b := Form1.GetPartialNumber(home);
    if a = b then begin
      Result := True;
      exit;
    end;
    b := Form1.GetPartialNumber(fax);
    if a = b then begin
      Result := True;
      exit;
    end;
    b := Form1.GetPartialNumber(other);
    if a = b then begin
      Result := True;
    end;
  end;
end;

{ This will update DisplayName according to changes in NewContact and settings in OldContact,
  and all other FMA specific settings }
function MigrateContact(OldContact: PContactData; var NewContact: PContactData): boolean;
begin
  with TfrmEditContact.Create(nil) do
    try
      contact := OldContact^;
      LoadAndMergeWith(NewContact^);
      { Migrate contact Fma internal settings }
      NewContact^.displayname := txtDisplayAs.Text; // get newly generated display name
      NewContact^.DefaultIndex := OldContact^.DefaultIndex;
      NewContact^.sound := OldContact^.sound;
      NewContact^.picture := OldContact^.picture;
      NewContact^.CDID := OldContact^.CDID;
      // - Do not copy old LUID sync id //NewContact^.LUID := OldContact^.LUID;
      // - Do not copy old phone positions //NewContact^.Position := OldContact^.Position;
      Result := True;
    finally
      Free;
    end;
end;

function GetContactFmaid(contact: PContactData): string;
begin
  Result := Format('{%s}-%s',[contact^.LUID,GUIDToString(contact^.CDID)]);
end;

function GetContactHomeAdr(contact: PContactData): WideString;
begin
  { Result = "street, city PostalCode, region country" }
  with contact^.homeAddress do begin
    Result := WideConcatList(street,city,', ');
    Result := WideConcatList(Result,PostalCode,' ');
    Result := WideConcatList(Result,region,', ');
    Result := WideConcatList(Result,country,' ');
  end;
end;

function GetContactWorkAdr(contact: PContactData): WideString;
begin
  { Result = "street, city PostalCode, region country" }
  with contact^.workAddress do begin
    Result := WideConcatList(street,city,', ');
    Result := WideConcatList(Result,PostalCode,' ');
    Result := WideConcatList(Result,region,', ');
    Result := WideConcatList(Result,country,' ');
  end;
end;

function GetContactDetails(contact: PContactData; Notes: TTntStrings): boolean;
var
  s: string;
  i: integer;
  sl: TTntStringList;
begin
  Notes.Clear;
  case contact^.StateIndex of
    0: s := _('New');
    1: s := _('Modified');
    2: s := _('Deleted');
    3: s := _('Unmodified');
  end;
  Notes.Add(_('State:')+' '+s+' '+_('contact'));
  Notes.Add(_('Full name:')+' '+getcontactfullname(contact));
  Notes.Add(_('Display name:')+' '+contact^.displayname);
  Notes.Add(_('Title:')+' '+contact^.title);
  Notes.Add(_('Company:')+' '+contact^.org);
  Notes.Add(_('Home phone:')+' '+contact^.home);
  Notes.Add(_('Work phone:')+' '+contact^.work);
  Notes.Add(_('Cell phone:')+' '+contact^.cell);
  Notes.Add(_('Fax number:')+' '+contact^.fax);
  Notes.Add(_('Other phone:')+' '+contact^.other);
  Notes.Add(_('Home Street:')+' '+contact^.homeAddress.street);
  Notes.Add(_('Home City:')+' '+contact^.homeAddress.city);
  Notes.Add(_('Home Region:')+' '+contact^.homeAddress.region);
  Notes.Add(_('Home Postal code:')+' '+contact^.homeAddress.postalCode);
  Notes.Add(_('Home Country:')+' '+contact^.homeAddress.country);
  Notes.Add(_('Work Street:')+' '+contact^.workAddress.street);
  Notes.Add(_('Work City:')+' '+contact^.workAddress.city);
  Notes.Add(_('Work Region:')+' '+contact^.workAddress.region);
  Notes.Add(_('Work Postal code:')+' '+contact^.workAddress.postalCode);
  Notes.Add(_('Work Country:')+' '+contact^.workAddress.country);
  Notes.Add(_('Picture File:')+' '+contact^.picture);
  Notes.Add(_('Ringing Tone:')+' '+contact^.sound);
  case contact^.DefaultIndex of
    0: s := _('None');
    1: s := _('Cell');
    2: s := _('Work');
    3: s := _('Home');
    4: s := _('Other');
  end;
  Notes.Add(_('Default phone:')+' '+s);
  if contact^.Birthday <> EmptyDate then
    Notes.Add(_('Birthday:')+' '+DateToStr(contact^.Birthday));
  Notes.Add(_('Home page:')+' '+contact^.homepage);
  Notes.Add(_('E-mail:')+' '+contact^.email);
  sl := TTntStringList.Create;
  try
    sl.Text := contact^.moremails;
    for i := 0 to sl.Count-1 do
      Notes.Add(_('E-mail:')+' '+sl[i]);
  finally
    sl.Free;
  end;
  if contact^.Modified <> EmptyDate then
    Notes.Add(_('Modified:')+' '+DateTimeToStr(contact^.Modified));
  Result := True;
end;

function GetContactNotes(contact: PContactData; Notes: TTntStrings): boolean;
var
  DBName,Section: string;
  sl: TStringList;
  i: integer;
begin
  Section := GetContactFmaid(contact);
  DBName := Form1.GetDatabasePath+'CallNotes.dat'; // do not localize
  if not FileExists(DBName) then begin
    ForceDirectories(ExtractFileDir(DBName));
    with TFileStream.Create(DBName,fmCreate) do Free;
  end;
  with TIniFile.Create(DBName) do
    try
      sl := TStringList.Create;
      try
        ReadSection(Section,sl);
        Notes.Clear;
        for i := 0 to sl.Count-1 do
          Notes.Add(ReadString(Section,sl[i],''));
      finally
        sl.Free;
      end;
      Result := True;
    finally
      Free;
    end;
end;

function SetContactNotes(contact: PContactData; Notes: TTntStrings): boolean;
var
  DBName,Section: string;
  i: integer;
begin
  Section := GetContactFmaid(contact);
  DBName := Form1.GetDatabasePath+'CallNotes.dat'; // do not localize
  if not FileExists(DBName) then begin
    ForceDirectories(ExtractFileDir(DBName));
    with TFileStream.Create(DBName,fmCreate) do Free;
  end;
  with TIniFile.Create(DBName) do
    try
      EraseSection(Section);
      if Assigned(Notes) then
        for i := 0 to Notes.Count-1 do
          WriteString(Section,IntToStr(i),Notes[i]);
      Result := True;
    finally
      Free;
    end;
end;

function vCard2Contact(VCard: TVCard; contact: PContactData): boolean;
var
  sl: TTntStringList;
begin
  Result := True;
  FillChar(contact^,SizeOf(contact^),0);
  contact^.title := VCard.title;
  contact^.name := VCard.name;
  contact^.surname := VCard.surname;
  contact^.displayname := VCard.DisplayName;
  contact^.org := VCard.org;
  contact^.email := VCard.email;
  contact^.moremails := VCard.MoreEmails.Text;
  contact^.home := VCard.telhome;
  contact^.work := VCard.telwork;
  contact^.cell := VCard.telcell;
  contact^.fax := VCard.telfax;
  contact^.other := VCard.telother;
  contact^.homeAddress := VCard.HomeAddress;
  contact^.workAddress := VCard.WorkAddress;
  contact^.Birthday := VCard.BDay;
  contact^.homepage := VCard.URL;
  // DefaultIndex = 0 none;1 cell;2 work;3 home;4 other
  if VCard.TelPref = 'M' then // do not localize
    contact^.DefaultIndex := 1
  else if VCard.TelPref = 'W' then // do not localize
    contact^.DefaultIndex := 2
  else if VCard.TelPref = 'H' then // do not localize
    contact^.DefaultIndex := 3
  else if VCard.TelPref = 'O' then // do not localize
    contact^.DefaultIndex := 4;
  contact^.LUID := VCard.LUID;
  try
    if VCard.UID <> '' then
      contact.CDID := StringToGUID('{'+VCard.UID+'}')
    else
      contact.CDID := NewGUID;
  except
    contact.CDID := NewGUID;
  end;
  sl := TTntStringList.Create;
  try
    sl.Text := VCard.Notes;
    SetContactNotes(contact,sl);
  finally
    sl.Free;
  end;
  contact^.Modified := VCard.ModifiedDate;
end;

function Contact2vCard(contact: PContactData; var VCard: TVCard): boolean;
var
  sl: TTntStringList;
begin
  Result := True;
  VCard.Clear;
  VCard.title := contact^.title;
  VCard.name := contact^.name;
  VCard.surname := contact^.surname;
  VCard.DisplayName := contact^.displayname;
  VCard.org := contact^.org;
  VCard.email := contact^.email;
  VCard.MoreEmails.Text := contact^.moremails;
  VCard.telhome := contact^.home;
  VCard.telwork := contact^.work;
  VCard.telcell := contact^.cell;
  VCard.telfax := contact^.fax;
  VCard.telother := contact^.other;
  VCard.HomeAddress := contact^.homeAddress;
  VCard.WorkAddress := contact^.workAddress;
  VCard.BDay := contact^.Birthday;
  VCard.URL := contact^.homepage;
  // DefaultIndex = 0 none;1 cell;2 work;3 home;4 other
  case contact^.DefaultIndex of
    1: VCard.TelPref := 'M'; // do not localize
    2: VCard.TelPref := 'W'; // do not localize
    3: VCard.TelPref := 'H'; // do not localize
    4: VCard.TelPref := 'O'; // do not localize
  end;
  VCard.LUID := contact^.LUID;
  try
    VCard.UID := GUIDToString(contact^.CDID);
  except
    VCard.UID := GUIDToString(NewGUID);
  end;
  { remove TGUID brackets }
  if (length(VCard.UID) > 1) and (VCard.UID[1] = '{') then begin
    Delete(VCard.UID,1,1); // {
    Delete(VCard.UID,length(VCard.UID),1); // }
  end;
  sl := TTntStringList.Create;
  try
    GetContactNotes(contact,sl);
    VCard.Notes := sl.Text;
  finally
    sl.Free;
  end;
  { TODO: Add better Modified date support }
  VCard.ModifiedDate := contact^.Modified;
  //debug
  {
  if Form1.Memo2.Visible then begin
    Form1.Memo2.Lines.Clear;
    Form1.Memo2.Lines.Text := Form1.Memo2.Lines.Text + VCard.Raw.Text;
  end;
  }
end;

function NumPos2Str(Pos: TNumberPos): string;
begin
  Result := IntToStr(Pos.home) + ',' + IntToStr(Pos.work) +
    ',' + IntToStr(Pos.cell) + ',' + IntToStr(Pos.fax) +
    ',' + IntToStr(Pos.other);
end;

function NumPosEmpty(contact: PContactData): boolean;
begin
  Result := ((contact.Position.home = 0) and (contact.home <> '')) or
    ((contact.Position.work = 0) and (contact.work <> '')) or
    ((contact.Position.cell = 0) and (contact.cell <> '')) or
    ((contact.Position.fax = 0) and (contact.fax <> '')) or
    ((contact.Position.other = 0) and (contact.other <> ''));
end;

function GetContactPictureFile(contact: PContactData): string;
var
  s: string;
begin
  s := '';
  if contact.picture <> '' then begin
    s := Form1.GetProfilePath+'pic\'+contact.picture; // do not localize
    if not FileExists(s) then s := '';
  end;
  Result := s;
end;

function GetContactSoundFile(contact: PContactData): string;
var
  s: string;
begin
  s := '';
  if contact.sound <> '' then begin
    s := Form1.GetProfilePath+'snd\'+contact.sound; // do not localize
    if not FileExists(s) then s := '';
  end;
  Result := s;
end;

function GetvCardFullName(VCard: TVCard): WideString;
begin
  with VCard do begin
    Result := name;
    if surname <> '' then Result := Result + ' ' + surname;
  end;
end;

function GetContactPostalAddress(contact: PContactData; Linebreak: string): WideString;
var
  s: WideString;
  procedure AddField(text: WideString);
  begin
    if Trim(text) <> '' then begin
      if s <> '' then s := s + Linebreak;
      s := s + text;
    end;
  end;
begin
  s := '';
  AddField(contact^.homeAddress.country);
  AddField(contact^.homeAddress.postalCode+' '+contact^.homeAddress.city);
  AddField(contact^.homeAddress.region);
  AddField(contact^.homeAddress.street);
  if s <> '' then
    AddField(GetContactDisplayName(contact));
  Result := s;
end;

function GetContactDisplayName(contact: PContactData; FamilyFirst: boolean = False): WideString;
var
  s: WideString;
begin
  s := Trim(contact^.displayname);
  if s = '' then s := GetContactFullName(contact,FamilyFirst);
  Result := s;
end;

function GetContactFullName(contact: PContactData; FamilyFirst: boolean): WideString;
begin
  with contact^ do begin
    if FamilyFirst then begin
      Result := surname;
      if surname <> '' then begin
        if name <> '' then Result := Result + ', ' + name;
      end
      else if name <> '' then Result := name;
    end
    else begin
      Result := name;
      if name <> '' then begin
        if surname <> '' then Result := Result + ' ' + surname;
      end
      else Result := surname;
    end;
  end;
  Result := Trim(Result);
end;

procedure SetContactFullName(contact: PContactData; FullName: WideString);
var
  i,j: integer;
begin
  with contact^ do begin
    j := Length(FullName);
    i := j;
    while (i <> 0) and (FullName[i] <> ' ') do dec(i);
    if i = 0 then i := j+1;
    name := Copy(FullName,1,i-1);
    surname := Copy(FullName,i+1,j);
  end;
end;

function GetContactPosition(contact: PContactData; Phone: string): integer;
begin
  Result := -1;
  with contact^ do begin
    if home = Phone then Result := Position.home;
    if work = Phone then Result := Position.work;
    if cell = Phone then Result := Position.cell;
    if fax = Phone then Result := Position.fax;
    if other = Phone then Result := Position.other;
  end;
end;

procedure SetContactPosition(contact: PContactData; Phone: string; SetPosition: integer);
begin
  with contact^ do begin
    if home = Phone then Position.home := SetPosition;
    if work = Phone then Position.work := SetPosition;
    if cell = Phone then Position.cell := SetPosition;
    if fax = Phone then Position.fax := SetPosition;
    if other = Phone then Position.other := SetPosition;
  end;
end;

function ContactDefPosition(contact: PContactData; SetPosition: integer): integer;
  procedure FindFirstGood;
  begin
    with contact^ do begin
      if cell <> '' then begin
        if SetPosition > 0 then Position.cell := SetPosition;
        if Position.cell > 0 then Result := Position.cell;
      end else
      if work <> '' then begin
        if SetPosition > 0 then Position.work := SetPosition;
        if Position.work > 0 then Result := Position.work;
      end else
      if home <> '' then begin
        if SetPosition > 0 then Position.home := SetPosition;
        if Position.home > 0 then Result := Position.home;
      end else
      if other <> '' then begin
        if SetPosition > 0 then Position.other := SetPosition;
        if Position.other > 0 then Result := Position.other;
      end;
    end;
  end;
begin
  Result := -1;
  with contact^ do case DefaultIndex of
    1: if cell <> '' then begin
         if SetPosition > 0 then Position.cell := SetPosition;
         if Position.cell > 0 then Result := Position.cell;
       end;
    2: if work <> '' then begin
         if SetPosition > 0 then Position.work := SetPosition;
         if Position.work > 0 then Result := Position.work;
       end;
    3: if home <> '' then begin
         if SetPosition > 0 then Position.home := SetPosition;
         if Position.home > 0 then Result := Position.home;
       end;
    4: if other <> '' then begin
         if SetPosition > 0 then Position.other := SetPosition;
         if Position.other > 0 then Result := Position.other;
       end;
  end;
  if Result = -1 then FindFirstGood;
end;

function GetContactDefPhone(contact: PContactData): string;
  procedure FindFirstNumber;
  begin
    with contact^ do begin
      if cell <> '' then begin
        Result := cell;
      end else
      if work <> '' then begin
        Result := work;
      end else
      if home <> '' then begin
        Result := home;
      end else
      if other <> '' then begin
        Result := other;
      end;
    end;
  end;
begin
  Result := '';
  with contact^ do case DefaultIndex of
    1: Result := cell;
    2: Result := work;
    3: Result := home;
    4: Result := other;
  end;
  if Result = '' then FindFirstNumber;
end;

function ReplaceContactDefPhone(contact: PContactData; Phone: string): string;
  procedure FindFirstNumber;
  begin
    with contact^ do begin
      if cell <> '' then begin
        cell := Phone;
      end else
      if work <> '' then begin
        work := Phone;
      end else
      if home <> '' then begin
        home := Phone;
      end else
      if other <> '' then begin
        other := Phone;
      end;
    end;
  end;
begin
  Result := GetContactDefPhone(contact);
  with contact^ do case DefaultIndex of
    1: cell := Phone;
    2: work := Phone;
    3: home := Phone;
    4: other := Phone;
    else FindFirstNumber;
  end;
end;

function GetContactPhoneType(contact: PContactData; Phone: string): string;
begin
  Result := '';
  with contact^ do begin
    if cell = Phone then begin
      Result := 'M'; // do not localize
    end else
    if work = Phone then begin
      Result := 'W'; // do not localize
    end else
    if home = Phone then begin
      Result := 'H'; // do not localize
    end else
    if fax = Phone then begin
      Result := 'F'; // do not localize
    end else
    if other = Phone then begin
      Result := 'O'; // do not localize
    end;
  end;
end;

procedure CheckDefaultDisplayName(contact: PContactData; FamilyFirst: boolean);
begin
  { clear DN if it matches current Full Name format since it is default view setting }
  if WideCompareStr(GetContactFullName(contact,FamilyFirst),contact^.displayname) = 0 then
    contact^.displayname := '';
end;

procedure SetDisplayName(contact: PContactData; Format: Integer; FamilyFirst,Overwrite: boolean);
var
  w: WideString;
begin
  w := GetContactFullName(contact,format mod 2 = 0);
  with contact^ do begin
    if Overwrite or (displayname = '') then
      case Format of
        { TODO: replace Format type from Integer to Enumeration = (dnFirstLast, dnLastFirst, ...) }
        // 1 Firstname Lastname
        // 2 Lastname, Firstname
        // 3 (Title) Firstname Lastname
        // 4 (Title) Lastname, Firstname
        // 5 Firstname Lastname (Organisation)
        // 6 Lastname, Firstname (Organisation)
        // 7 (Title) Firstname Lastname (Organisation)
        // 8 (Title) Lastname, Firstname (Organisation)
        1,2: displayname := w;
        3,4: if title <> '' then displayname := title + ' ' + w;
        5,6: if org <> '' then displayname := w + ' ' + org;
        7,8: begin
               if title <> '' then w := title + ' ' + w;
               if org <> '' then w := w + ' ' + org;
               displayname := w;
             end;
      end;
  end;
  CheckDefaultDisplayName(contact,FamilyFirst);
end;

{ TfrmSyncPhonebook }

constructor TfrmSyncPhonebook.Create(AOwner: TComponent);
begin
  inherited;
  VCard := TVCard.Create;
  ConflictVCardPhone := TVCard.Create;
  ConflictVCardPC := TVCard.Create;
  FMaxRecME := 510; FMaxNameLen := 180; FMaxTelLen := 80;
end;

destructor TfrmSyncPhonebook.Destroy;
begin
  ConflictVCardPhone.Free;
  ConflictVCardPC.Free;
  VCard.Free;
  inherited;
end;

procedure TfrmSyncPhonebook.ListContactsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  contact: PContactData;
begin
  contact := Sender.GetNodeData(Node);

  if Column = 0 then
    case contact.StateIndex of //0 new entry;1 modified entry;2 deleted entry;3 normal entry
      0: CellText := _('New');
      1: CellText := _('Mod');
      2: CellText := _('Del');
      else CellText := '';
    end
  else if Column = 1 then CellText := GetContactFullName(contact,LastFirst1.Checked)
  else if Column = 2 then CellText := contact.title
  else if Column = 3 then CellText := contact.org
  else if Column = 4 then CellText := contact.email
  else if Column = 5 then CellText := contact.home
  else if Column = 6 then CellText := contact.work
  else if Column = 7 then CellText := contact.cell
  else if Column = 8 then CellText := contact.fax
  else if Column = 9 then CellText := contact.other
  else if Column = 10 then CellText := contact.homeAddress.street
  else if Column = 11 then CellText := contact.homeAddress.city
  else if Column = 12 then CellText := contact.homeAddress.region
  else if Column = 13 then CellText := contact.homeAddress.postalcode
  else if Column = 14 then CellText := contact.homeAddress.country
  else if Column = 15 then CellText := GetContactDisplayName(contact);
end;

procedure TfrmSyncPhonebook.ListContactsHeaderClick(Sender: TVTHeader;
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
    ListContacts.Sort(nil, ListContacts.Header.SortColumn, ListContacts.Header.SortDirection);
    ListContacts.ScrollIntoView(ListContacts.FocusedNode,true,false);

  end
  else if Button = mbRight then begin
    if Column = 1 then
      pmNameOrder.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y)
    else
      pmColumns.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
  end;
end;

procedure TfrmSyncPhonebook.PopupHandler(Sender: TObject);
var
  pos: cardinal;
begin
  //determine column
  with ListContacts.Header do begin
    pos := (Sender as TTntMenuItem).Tag;
    if coVisible in Columns[pos].options then
      Columns[pos].options := Columns[pos].options - [coVisible]
    else
      Columns[pos].options := Columns[pos].options + [coVisible];
    DoAutosizeLastColumn;
  end;
end;

procedure TfrmSyncPhonebook.PopupShowAll(Sender: TObject);
var
  i: cardinal;
begin
  with ListContacts.Header do begin
    for i := 0 to columns.count-1 do
      Columns[i].options := Columns[i].options + [coVisible];
    DoAutosizeLastColumn;
  end;
end;

procedure TfrmSyncPhonebook.ListContactsCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  contact1, contact2: PContactData;
begin
  contact1 := Sender.GetNodeData(Node1);
  contact2 := Sender.GetNodeData(Node2);

  if Column = 0 then begin
    if contact1.StateIndex > contact2.StateIndex then
      Result := 1
    else
      if contact1.StateIndex < contact2.StateIndex then
        Result := -1
      else
        Result := 0;
  end
  else if Column = 1 then
    Result := WideCompareStr(GetContactFullName(contact1,LastFirst1.Checked),
                             GetContactFullName(contact2,LastFirst1.Checked))
  else if Column = 2 then Result := WideCompareStr(contact1.title, contact2.title)
  else if Column = 3 then Result := WideCompareStr(contact1.org,   contact2.org)
  else if Column = 4 then Result := WideCompareStr(contact1.email, contact2.email)
  else if Column = 5 then Result := WideCompareStr(contact1.home,  contact2.home)
  else if Column = 6 then Result := WideCompareStr(contact1.work,  contact2.work)
  else if Column = 7 then Result := WideCompareStr(contact1.cell,  contact2.cell)
  else if Column = 8 then Result := WideCompareStr(contact1.fax,   contact2.fax)
  else if Column = 9 then Result := WideCompareStr(contact1.other, contact2.other)
  else if Column = 10 then Result := WideCompareStr(contact1.homeAddress.Street,
                                                    contact2.homeAddress.Street)
  else if Column = 11 then Result := WideCompareStr(contact1.homeAddress.City,
                                                    contact2.homeAddress.City)
  else if Column = 12 then Result := WideCompareStr(contact1.homeAddress.Region,
                                                    contact2.homeAddress.Region)
  else if Column = 13 then Result := WideCompareStr(contact1.homeAddress.PostalCode,
                                                    contact2.homeAddress.PostalCode)
  else if Column = 14 then Result := WideCompareStr(contact1.homeAddress.Country,
                                                    contact2.homeAddress.Country)
  else if Column = 15 then Result := WideCompareStr(GetContactDisplayName(contact1),
                                                    GetContactDisplayName(contact2));
end;

procedure TfrmSyncPhonebook.ListContactsGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  contact: PContactData;
begin
  if Column = 0 then begin
    if (Kind = ikNormal) or (Kind = ikSelected) then begin
      contact := Sender.GetNodeData(Node);
      { Yesllow icon on personalized contacts, blue on others }
      if (contact.StateIndex = 3) and ((contact.picture <> '') or (contact.sound <> '')) then
        ImageIndex := 4
      else
        ImageIndex := contact.StateIndex;
    end
    else ImageIndex := -1;
  end;
end;

procedure TfrmSyncPhonebook.btnEditClick(Sender: TObject);
var
  Node :PVirtualNode;
begin
  Node := ListContacts.FocusedNode;
  if Node <> nil then begin
    Selcontact := ListContacts.GetNodeData(Node);
    FUndoIndx := Node.Index;
    DoEdit;
  end;
end;

function TfrmSyncPhonebook.RenderListView(const sl: TStrings): boolean;
var
  s: WideString;
  i: Integer;
  contact: PContactData;
  Node: PVirtualNode;
  Modified: Boolean;
begin
  Modified := False;
  ListContacts.BeginUpdate;
  try
    ListContacts.Clear;
    ListContacts.NodeDataSize := sizeof(TContactData);
    i := 0;
    while i < sl.Count do begin
      s := LongStringToWideString(sl[i]);
      if Trim(s) = '' then continue;

      { Workaround for NewLine chars in contact names }
      while (not EvenQuotes(s)) and (i < sl.Count - 2) do begin
        Inc(i);
        s := s + sLinebreak + LongStringToWideString(sl.Strings[i]);
      end;

      if Pos('LOG:', s) = 1 then begin // do not localize
         CC := Copy(s, Pos(':', s) + 1, length(s));
         Break;
      end;

      Node := ListContacts.AddChild(nil);
      try
        contact := ListContacts.GetNodeData(Node);
        { Enter data }
        contact.stateindex := strtoint(GetFirstToken(s));
        contact.title := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        contact.name := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        contact.surname := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        contact.org := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        contact.email := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        contact.home := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        contact.work := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        contact.cell := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        contact.fax := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        contact.other := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        contact.LUID := GetFirstToken(s);
        { Get number positions }
        FillChar(contact.Position,SizeOf(contact.Position),0);
        contact.Position.home := StrToInt(WideStringToLongString(GetFirstToken(s)));
        contact.Position.work := StrToInt(WideStringToLongString(GetFirstToken(s)));
        contact.Position.cell := StrToInt(WideStringToLongString(GetFirstToken(s)));
        contact.Position.fax := StrToInt(WideStringToLongString(GetFirstToken(s)));
        contact.Position.other := StrToInt(WideStringToLongString(GetFirstToken(s)));
        { Get default number }
        contact.DefaultIndex := StrToInt(WideStringToLongString(GetFirstToken(s)));
        { Get personalization }
        contact.picture := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        contact.sound := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        try
          { Outlook sync ID field }
          contact.CDID := StringToGUID(GetFirstToken(s));
        except
          contact.CDID := NewGUID;
          Modified := True;
        end;
        { Display Name }
        contact.displayname := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        { Postal Addresses }
        contact.homeAddress.Street := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        contact.homeAddress.City := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        contact.homeAddress.Region := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        contact.homeAddress.PostalCode := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        contact.homeAddress.Country := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        contact.workAddress.Street := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        contact.workAddress.City := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        contact.workAddress.Region := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        contact.workAddress.PostalCode := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        contact.workAddress.Country := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        { Internet }
        contact.homepage := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        contact.moremails := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        { Personal }
        try
          contact.Birthday := StrToInt(WideStringToLongString(GetFirstToken(s)));
          if contact.Birthday = 0 then Abort; // pre-release beta 4 fix
        except
          contact.Birthday := EmptyDate;
        end;
      except
        ListContacts.DeleteNode(Node);
        Log.AddMessageFmt(_('Database: Error loading data (DB Index %d)'), [i], lsError);
        if FindCmdLineSwitch('FIXDB') then begin
          sl[i] := '';
          Log.AddMessageFmt(_('Database: Removed incorrect data (DB Index: %d)'), [i], lsInformation);
        end;
      end;
      Inc(i);
    end;
    RenderGUIDs;
  finally
    ListContacts.EndUpdate;
    ListContacts.Sort(nil, ListContacts.Header.SortColumn, ListContacts.Header.SortDirection);
    UndoLastChange1.Visible := False;
  end;
  Result := Modified;
end;

procedure TfrmSyncPhonebook.SaveContacts(FileName:WideString);
var
  sl: TStrings;
  Node: PVirtualNode;
  contact: PContactData;
  str: String;
begin
  sl := TStringList.Create;
  try
    with ListContacts do begin
      Node := GetFirst;
      while Assigned(Node) do begin
        try
          contact := GetNodeData(node);
          str := inttostr(contact.StateIndex);
          str := str + ',"' + HTMLEncode(WideStringToUTF8String(contact.title),False);
          str := str + '","' + HTMLEncode(WideStringToUTF8String(contact.name),False);
          str := str + '","' + HTMLEncode(WideStringToUTF8String(contact.surname),False);
          str := str + '","' + HTMLEncode(WideStringToUTF8String(contact.org),False);
          str := str + '","' + HTMLEncode(WideStringToUTF8String(contact.email),False);
          str := str + '","' + HTMLEncode(WideStringToUTF8String(contact.home),False);
          str := str + '","' + HTMLEncode(WideStringToUTF8String(contact.work),False);
          str := str + '","' + HTMLEncode(WideStringToUTF8String(contact.cell),False);
          str := str + '","' + HTMLEncode(WideStringToUTF8String(contact.fax),False);
          str := str + '","' + HTMLEncode(WideStringToUTF8String(contact.other),False);
          str := str + '",' + WideStringToLongString(contact.LUID);
          str := str + ',' + NumPos2Str(contact.Position);
          str := str + ',' + IntToStr(contact.DefaultIndex);
          str := str + ',"' + HTMLEncode(WideStringToUTF8String(contact.picture),False);
          str := str + '","' + HTMLEncode(WideStringToUTF8String(contact.sound),False);
          str := str + '",' + GUIDToString(contact.CDID);
          str := str + ',"' + HTMLEncode(WideStringToUTF8String(contact.displayname),False);
          str := str + '","' + HTMLEncode(WideStringToUTF8String(contact.homeAddress.Street),False);
          str := str + '","' + HTMLEncode(WideStringToUTF8String(contact.homeAddress.City),False);
          str := str + '","' + HTMLEncode(WideStringToUTF8String(contact.homeAddress.Region),False);
          str := str + '","' + HTMLEncode(WideStringToUTF8String(contact.homeAddress.PostalCode),False);
          str := str + '","' + HTMLEncode(WideStringToUTF8String(contact.homeAddress.Country),False);
          str := str + '","' + HTMLEncode(WideStringToUTF8String(contact.workAddress.Street),False);
          str := str + '","' + HTMLEncode(WideStringToUTF8String(contact.workAddress.City),False);
          str := str + '","' + HTMLEncode(WideStringToUTF8String(contact.workAddress.Region),False);
          str := str + '","' + HTMLEncode(WideStringToUTF8String(contact.workAddress.PostalCode),False);
          str := str + '","' + HTMLEncode(WideStringToUTF8String(contact.workAddress.Country),False);
          str := str + '","' + HTMLEncode(WideStringToUTF8String(contact.homepage),False);
          str := str + '","' + HTMLEncode(WideStringToUTF8String(contact.moremails),False);
          str := str + '",' + IntToStr(Trunc(contact.Birthday));
          sl.Add(str);
        except
        end;
        Node := GetNext(Node);
      end;
    end;
    sl.add('LOG:' + CC); // do not localize
    sl.SaveToFile(FileName);
    sl.Clear;
    sl.Add(IntToStr(FMaxRecME));
    sl.Add(IntToStr(FMaxNameLen));
    sl.Add(IntToStr(FMaxTitleLen));
    sl.Add(IntToStr(FMaxOrgLen));
    sl.Add(IntToStr(FMaxMailLen));
    sl.Add(IntToStr(FMaxTellen));
    sl.SaveToFile(WideChangeFileExt(FileName,'MAX.dat')); // do not localize
  finally
    sl.Free;
  end;
end;

procedure TfrmSyncPhonebook.LoadContacts(FileName:WideString);
var
  sl : TStringList;
  //Modified: Boolean;
begin
  ListContacts.NodeDataSize := sizeof(TContactData);
  sl := TStringList.Create;
  try
    try
      sl.LoadFromFile(FileName);
    except
    end;
    {Modified := }RenderListView(sl);
    FMaxRecME := 510;
    FMaxNameLen := 30;
    FMaxTitleLen := 15;
    FMaxOrgLen := 15;
    FMaxMailLen := 50;
    FMaxTellen := 40;
    try
      sl.LoadFromFile(WideChangeFileExt(FileName,'MAX.dat')); // do not localize
      FMaxRecME := StrToInt(sl[0]);
      FMaxNameLen := StrToInt(sl[1]);
      FMaxTitleLen := StrToInt(sl[2]);
      FMaxOrgLen := StrToInt(sl[3]);
      FMaxMailLen := StrToInt(sl[4]);
      FMaxTellen := StrToInt(sl[5]);
    except
    end;
  finally
    sl.Free;
  end;
  //if Modified then SaveContacts(FileName);
end;

procedure TfrmSyncPhonebook.btnSYNCClick(Sender: TObject);
var
  isModified: Boolean;
  Err: WideString;
begin
  Form1.ActionSyncPhonebook.Enabled := False;
  FSyncProgressDlg := GetProgressDialog;
  try
    if Form1.CanShowProgress then
      FSyncProgressDlg.ShowProgress(Form1.FProgressLongOnly);
    FSyncProgressDlg.SetDescr(_('Synchronizing phonebook contacts'));
    Form1.Status(_('Start Sync Phonebook....'));
    Log.AddSynchronizationMessage(_('Sync Phonebook started.'));
    VCard.clear;
    try
      //Start the sync process
      isModified := Synchronize;
      //Force refresh phoneBook
      if isModified then begin
        FSyncProgressDlg.SetDescr(_('Refreshing local phonebook'));
        Form1.RefreshPhoneBook;
      end;
      Form1.Status(_('Sync Phonebook completed.'));
      Log.AddSynchronizationMessage(_('Sync Phonebook completed.'));
    except
      on E: Exception do begin
        Err := WideFormat(_('Error: Sync Phonebook aborted - %s'), [E.Message]);
        Form1.Status(Err);
        Log.AddSynchronizationMessage(Err, lsError);
        { TODO: Made phonebook baloon optional }
        Form1.ShowBaloonError(_('Phonebook synchronization failed!'),30);
      end;
    end;
  finally
    FreeProgressDialog;
    FSyncProgressDlg := nil;
    ListContacts.Sort(nil, ListContacts.Header.SortColumn, ListContacts.Header.SortDirection);
    ListContacts.Update;
    Form1.UpdateMEPhonebook;
    Form1.ActionSyncPhonebook.Enabled := True;
  end;
end;

procedure TfrmSyncPhonebook.btnNEWClick(Sender: TObject);
begin
  if ListContacts.RootNodeCount < FMaxRecME then 
    DoEdit(True)
  else
    ShowMessageW(_('No more space in memory! New contact can not be created.'));
end;

procedure TfrmSyncPhonebook.btnDELClick(Sender: TObject);
var
  Node,Tmp: PVirtualNode;
  contact :PContactData;
  oldState :Integer;
  s: WideString;
begin
  if ListContacts.SelectedCount = 0 then exit;
  s := WideFormat(_('Deleting %d %s.'), [ListContacts.SelectedCount,ngettext('contact','contacts',ListContacts.SelectedCount)]);
  if MessageDlgW(s+_(' Do you wish to continue?'),mtConfirmation, MB_YESNO or MB_DEFBUTTON2) <> ID_YES then
    exit;
  Form1.Status(s+'..');
  State := 2;
  ListContacts.BeginUpdate;
  try
    node := ListContacts.GetFirst;
    while Assigned(node) do begin
      if ListContacts.Selected[node] then begin
        contact := ListContacts.GetNodeData(Node);
        oldState := contact.stateindex;
        contact.stateindex := State;
        if oldState = 0 then begin
          Tmp := Node;
          if Node <> ListContacts.GetFirst then begin
            Node := ListContacts.GetPrevious(Node);
            ListContacts.DeleteNode(Tmp);
          end
          else begin
            ListContacts.DeleteNode(Tmp);
            Node := ListContacts.GetFirst;
            continue;
          end;
        end;
      end;
      node := ListContacts.GetNext(Node);
    end;
  finally
    ListContacts.EndUpdate;
    Form1.Status('');
    Form1.UpdateMEPhonebook;
  end;
end;

function TfrmSyncPhonebook.Synchronize: boolean; // True if any change is made!
var
  sl,pl: TStringList;
  stream : TStream;
  addPCont : array of widestring;
  delPCont : array of widestring;
  j: Integer;
  Node: PVirtualNode;
  migrate: TContactData;
  contact: PContactData;
  F,LUID : WideString;
  PhoneOnPc,AsNew,BadCC,GetAll: Boolean;
  procedure ShowProgressTarget(AName: WideString);
  begin
    if Assigned(FSyncProgressDlg) then
      FSyncProgressDlg.SetDescr(_('Synchronizing phonebook contacts')+sLinebreak+'('+AName+')');
  end;
begin
  Result := False;
  if ListContacts.childcount[nil] = 0 then begin
    Result := FullRefresh;
    exit;
  end;

  //start sync process
  Form1.ObexConnect('IRMC-SYNC'); // do not localize
  if not Form1.FConnected then begin
     ShowMessageW(_('The Sync Phonebook can''t start...try to restart your phone.'));
     Log.AddSynchronizationMessage(_('The Sync Phonebook can''t start...try to restart your phone.'), lsError);
     Form1.ActionSyncPhonebook.Enabled := True;
     Exit;
  end;

  VCard.Clear;
  sl := TStringList.Create;
  pl := TStringList.Create;
  try
    BadCC := (CC = '') or (CC[1] = '-'); // Empty or -1 values
    try
      { if Fma CC is 1020, and phone CC is 1025 the result might be like this:
        (here for example, we have 3 new and one deleted contacts)

        SN:351956003653753
        DID:6D25
        Total-Records:100
        Maximum-Records:510
        M:1022::00003D010000
        M:1023::000047010000
        H:1024::0000E4000000
        M:1025::0000E5000000
      }
      //Get all record changes in phone for latest used LOG Number in FMA
      if not BadCC then
        Form1.ObexGetObject('telecom/pb/luid/' + CC +'.log',pl); // do not localize
    except
      BadCC := True; // Not exists or not authorized
    end;

    if not BadCC then begin
      // Build lists of localy modified and deleted contacts (on PC)
      Node := ListContacts.GetFirst;
      while Assigned(Node) do begin
        contact := ListContacts.GetNodeData(node);
        case contact.StateIndex of
          0,1: begin // new or modified
                 SetLength(addPCont, length(addPCont) + 1);
                 addPCont[High(addPCont)] := contact.LUID;
               end;
            2: begin// deleted
                 SetLength(delPCont, length(delPCont) + 1);
                 delPCont[High(delPCont)] := contact.LUID;
               end;
        end;
        Node := ListContacts.GetNext(Node);
      end;

      ListContacts.BeginUpdate;
      try
        // first apply phone changes
        for j := 0 to pl.Count-1 do begin
          F := '';

          if Pos('M:', pl[j]) = 1 then begin //entries modified // do not localize
            LUID := Copy(pl[j], Pos('::', pl[j]) + 2, length(pl[j]));
            if LFindContact(LUID,contact) then begin
              F := GetContactFullName(contact);
              migrate := contact^;
              AsNew := False;
            end
            else
              AsNew := True;
            //Get new VCard
            Form1.ObexGetObject('telecom/pb/luid/' + LUID + '.vcf',sl); // do not localize
            VCard.Raw := sl;

            ShowProgressTarget(GetvCardFullName(VCard));

            if CheckInArray(addPCont, LUID) then begin
              Contact2vCard(contact,ConflictVCardPC);
              ConflictVCardPhone.Raw := VCard.Raw;
              PhoneOnPC := ResolveConflict(F, _('is modified on phone and modified on pc.')) = 0;
              if not PhoneOnPC then continue; // later will overwrite phone contact
              // else overwrite local contact
            end;
            if CheckInArray(delPCont, LUID) then begin
              ConflictVCardPC.Clear;
              ConflictVCardPhone.Clear;
              PhoneOnPC := ResolveConflict(F, _('is modified on phone and deleted on pc.')) = 0;
              if not PhoneOnPC then continue; // later will delete phone contact
              // else resurrect local contact
            end;
            //Remove old VCard
            if not AsNew then
              EraseContact(LUID,False);
            
            //Add new Node and Parse VCard
            Node := ListContacts.AddChild(nil);
            contact := ListContacts.GetNodeData(Node);
            vCard2Contact(VCard,contact);
            contact.stateindex := 3;
            if AsNew then begin
              // Set DisplayName according to FMA default settings
              setDisplayName(contact,form1.FDisplayNameFormat,LastFirst1.Checked);
              Log.AddSynchronizationMessage(GetvCardFullName(VCard) + _(' added to FMA by phone.'), lsInformation);
            end
            else begin
              //Migrate Fma internal settings
              MigrateContact(@migrate,contact);
              Log.AddSynchronizationMessage(GetvCardFullName(VCard) + _(' modified in FMA by phone.'), lsInformation);
            end;
            // TODO: add picture and sound support here....
            VCard.Clear;
            sl.Clear;
            // Update LOG Number dinamicaly (current LOG record has been processed)
            CC := Copy(pl[j],3,Pos('::',pl[j])-3);
            Result := True;
          end;

          if Pos('H:', pl[j]) = 1 then begin  //entries deleted
            LUID := Copy(pl[j], Pos('::', pl[j]) + 2, length(pl[j]));
            if LFindContact(LUID,contact) then begin
              F := GetContactFullName(contact);
              AsNew := False;
            end
            else
              AsNew := True;

            if not AsNew then ShowProgressTarget(F);

            if CheckInArray(addPCont, LUID) then begin
              ConflictVCardPC.Clear;
              ConflictVCardPhone.Clear;
              PhoneOnPC := ResolveConflict(F, _('is deleted on phone and modified on pc.')) = 0;
              if not PhoneOnPC then continue; // later will resurrect phone contact
              // else delete local contact
            end;
            EraseContact(LUID,False);
            if CheckInArray(delPCont, LUID) then
               Log.AddSynchronizationMessage(F + _(' deleted in phone by FMA.'), lsInformation)
            else if not AsNew then
               Log.AddSynchronizationMessage(F + _(' deleted in FMA by phone.'), lsInformation);
            // Update LOG Number dinamicaly (current LOG record has been processed)
            CC := Copy(pl[j],3,Pos('::',pl[j])-3);
            Result := True;
          end;
        end;
        { well, we have processed all "CC.log" entries and we have updated CC up to latest one }
        SetLength(addPCont,0);
        SetLength(delPCont,0);

        // Build lists of contacts modified and deleted in phone
        for j := 0 to pl.Count-1 do begin
           if Pos('M:', pl[j]) = 1 then begin //entries modified
              SetLength(addPCont, length(addPCont) + 1);
              addPCont[High(addPCont)] := Copy(pl[j], Pos('::', pl[j]) + 2, length(pl[j]));
              end
           else if Pos('H:', pl[j]) = 1 then begin  //entries deleted
              SetLength(delPCont, length(delPCont) + 1);
              delPCont[High(delPCont)] := Copy(pl[j], Pos('::', pl[j]) + 2, length(pl[j]));
           end;
        end;

        // next apply PC changes
        try
          Node := ListContacts.GetFirst;
          while Assigned(Node) do begin
            contact := ListContacts.GetNodeData(node);
            if contact.StateIndex <> 3 then begin // skip unmodified contacts
              Contact2vCard(contact,VCard);
              // TODO: add picture and sound support here....
              stream := TMemoryStream.Create;
              try
                VCard.Raw.SaveToStream(stream);
                VCard.Clear;
                stream.Seek(0, soFromBeginning);
                F := GetContactFullName(contact);

                ShowProgressTarget(F);
              
                case contact.StateIndex of
                   0: begin //new
                        //TODO: check if contact with same name already exists
                        contact.LUID := Form1.ObexPutObject('telecom/pb/luid/.vcf', stream); //New LUID // do not localize
                        contact.StateIndex := 3; //entries syncronized
                        Log.AddSynchronizationMessage(F + _(' added to phone by FMA.'), lsInformation);
                        Result := True;
                      end;
                   1: begin //modified
                        AsNew := CheckInArray(delPCont, contact.LUID);
                        if AsNew then begin
                          contact.LUID := Form1.ObexPutObject('telecom/pb/luid/.vcf', stream); //New LUID // do not localize
                          Log.AddSynchronizationMessage(F + _(' added to phone by FMA.'), lsInformation);
                        end
                        else begin
                          contact.LUID := Form1.ObexPutObject('telecom/pb/luid/' + contact.luid + '.vcf', stream); //Modified LUID // do not localize
                          Log.AddSynchronizationMessage(F + _(' modified in phone by FMA.'), lsInformation);
                        end;
                        contact.StateIndex := 3; //entries syncronized
                        Result := True;
                      end;
                   2: begin //deleted
                        contact.LUID := Form1.ObexPutObject('telecom/pb/luid/' + contact.luid + '.vcf', nil); //deletd LUID // do not localize
                        contact.StateIndex := 3; //entries syncronized
                        ListContacts.DeleteNode(Node);
                        Log.AddSynchronizationMessage(F + _(' deleted in phone by FMA.'), lsInformation);
                        Result := True;
                      end;
                end;
              finally
                stream.Free;
              end;
            end;
            Node := ListContacts.GetNext(Node);
          end;
        finally
          // get current LOG Number from phone -- it will include all changes made in FMA that we just apply to phone
          Form1.ObexGetObject('telecom/pb/luid/cc.log',sl); // do not localize
          CC := sl.Strings[0];
        end;
      finally
        RenderGUIDs;
        ListContacts.EndUpdate;
        // Do we have to perform a full refresh? (too many changes in phone)
        {
          SN:351956003653753
          DID:6D25
          Total-Records:100
          Maximum-Records:510
          *
        }
        // Local changes have been applied to the phone already, so we can do
        // full refresh, if needed...
        GetAll := (pl.Count <> 0) and (pl[pl.Count-1] = '*');
      end;
    end
    else 
      GetAll := MessageDlgW(_('Entire phonebook should be downloaded from phone. All local changes will be LOST! Continue?'),
        mtConfirmation, MB_YESNO) = ID_YES;

    if GetAll then Result := FullRefresh;
  finally
    sl.Free;
    pl.Free;
    Form1.ObexDisconnect;
    ListContacts.Sort(nil, ListContacts.Header.SortColumn, ListContacts.Header.SortDirection);
    ListContacts.Update;
    UndoLastChange1.Visible := False;
  end;
end;

{Utilities}

function TfrmSyncPhonebook.CheckInArray(A: array of widestring;
  S: Widestring): boolean;
var
   i:Integer;
begin
  for i:=0 to High(A) do begin
     if A[i] = S then begin
        Result := True;
        Exit;
     end;
  end;
  Result := False;
end;

{
procedure TfrmSyncPhonebook.ResetInArray(var A: array of widestring;
  S: Widestring);
var
   i:Integer;
begin
  for i:=0 to High(A) do begin
     if A[i] = S then begin
        A[i] := '';
     end;
  end;
end;
}

function TfrmSyncPhonebook.EraseContact(LUID :Widestring; Log:Boolean):Boolean;
var
   Node: PVirtualNode;
   contact: PContactData;
begin
  Result := False;
  with ListContacts do begin
    Node := GetFirst;
    while Assigned(Node) do begin
      contact := GetNodeData(node);
      if LUID = contact.LUID then begin
        if Log then
          uLogger.Log.AddSynchronizationMessage(GetContactFullName(contact) +
          _(' deleted in FMA by phone.'), lsInformation);
        SetContactNotes(contact,nil); // delete call notes for that contact
        DeleteNode(Node);
        Result := True;
        break;
      end;
      Node := GetNext(Node);
    end;
  end;
end;

function TfrmSyncPhonebook.ResolveConflict(NameContact: WideString; Info:WideString): Integer;
begin
  Result := Form1.FSyncContactPrio;
  if Result = 2 then begin // ask me?
    Result := 0;
    frmPromptConflict := TfrmPromptConflict.Create(Self);
    try
      { Default frmPromptConflict.ObjKind is 'contact' }
      frmPromptConflict.ObjName := NameContact;
      frmPromptConflict.Info := Info;
      if (ConflictVCardPhone.Raw.Count <> 0) and (ConflictVCardPC.Raw.Count <> 0) then
        frmPromptConflict.OnViewChanges := OnConflictChanges;
      if frmPromptConflict.ShowModal = mrOK then begin
        Result := frmPromptConflict.SelectedItem;
        if frmPromptConflict.cbDontAskAgain.Checked then begin
          Form1.FSyncContactPrio := Result;
          Form1.FormStorage1.StoredValue['Sync Contact'] := Form1.FSyncContactPrio; // do not localize  
        end;
      end;
    finally
      frmPromptConflict.Free;
    end;
  end;  
end;

procedure TfrmSyncPhonebook.ForceUpdateClick(Sender: TObject);
begin
  ForceContact(1);
end;

procedure TfrmSyncPhonebook.ExportList(FileType:Integer; Filename: WideString);
var
  node: PVirtualNode;
  contact: PContactData;
  sl: TStringList;
  str: WideString;
  XML: TXML;
begin
  if FileType > 2 then begin
    if MessageDlgW(_('FMA could Import only vCard and LDIF contact exports. Do you still want to continue exporting?'),
      mtConfirmation, MB_YESNO or MB_DEFBUTTON2) <> ID_YES then
      exit;
  end;
  case FileType of
    1:begin//vCard
        sl := TStringList.Create;
        with ListContacts do begin
          node := GetFirst;
          while Assigned(Node) do begin
            try
              if Selected[node] then begin
                contact := GetNodeData(node);
                Contact2vCard(contact,VCard);
                //TODO: add picture and sound support here....
                sl.Clear;
                sl.AddSTrings(VCard.Raw);
                if ListContacts.SelectedCount <> 1 then begin
                  str := Trim(GetContactFullName(contact));
                  str := StringReplace(str,' ','-',[rfReplaceAll]);
                  str := WideChangeFileExt(FileName,'-'+str)+ExtractFileExt(Filename);
                  sl.SaveToFile(str);
                end
                else
                  sl.SaveToFile(Filename);
              end;
            except
            end;
            node := GetNext(node);
          end;
        end;
        sl.Free;
      end;
    2:begin//LDIF
        sl := TStringList.Create;
        with ListContacts do begin
          node := GetFirst;
          while Assigned(Node) do begin
            try
              if Selected[node] then begin
                contact := GetNodeData(node);
                Contact2vCard(contact,VCard);
                sl.AddStrings(VCard.LDIF);
                sl.Add('');
              end;
            except
            end;
            node := GetNext(node);
          end;
        end;
        sl.SaveToFile(Filename);
        sl.Free;
      end;
    3:begin//CSV
        sl := TStringList.Create;
        str := '"Title","First Name","Last Name","Company","E-mail Address","E-mail Display Name","Home Phone","Business Phone",'+ // do not localize
          '"Mobile Phone","Business Fax","Other Phone","Primary Phone",'+ // do not localize
          '"Home Street","Home City","Home State","Home Postal Code","Home Country","Birthday"'; // do not localize
        sl.add(str);
        with ListContacts do begin
          node := GetFirst;
          while Assigned(Node) do begin
            try
              if Selected[node] then begin
                { Bug 847307 Export to .csv files.
                  Fixed to use "," instead of ";" and field names compatability with Outlook 2003 fields, which are shown here:

                  "Title","First Name","Middle Name","Last Name","Suffix","Company","Department","Job Title","Business Street",
                  "Business Street 2","Business Street 3","Business City","Business State","Business Postal Code","Business Country",
                  "Home Street","Home Street 2","Home Street 3","Home City","Home State","Home Postal Code","Home Country",
                  "Other Street","Other Street 2","Other Street 3","Other City","Other State","Other Postal Code","Other Country",
                  "Assistant's Phone","Business Fax","Business Phone","Business Phone 2","Callback","Car Phone","Company Main Phone",
                  "Home Fax","Home Phone","Home Phone 2","ISDN","Mobile Phone","Other Fax","Other Phone","Pager","Primary Phone",
                  "Radio Phone","TTY/TDD Phone","Telex","Account","Anniversary","Assistant's Name","Billing Information","Birthday",
                  "Business Address PO Box","Categories","Children","Directory Server","E-mail Address","E-mail Type","E-mail Display Name",
                  "E-mail 2 Address","E-mail 2 Type","E-mail 2 Display Name","E-mail 3 Address","E-mail 3 Type","E-mail 3 Display Name",
                  "Gender","Government ID Number","Hobby","Home Address PO Box","Initials","Internet Free Busy","Keywords","Language",
                  "Location","Manager's Name","Mileage","Notes","Office Location","Organizational ID Number","Other Address PO Box",
                  "Priority","Private","Profession","Referred By","Sensitivity","Spouse","User 1","User 2","User 3","User 4","Web Page"
                }
                contact := GetNodeData(node);
                str := WideQuoteStr(contact.title) + ',' +
                  WideQuoteStr(contact.name) + ',' +
                  WideQuoteStr(contact.surname) + ',' +
                  WideQuoteStr(contact.org) + ',' +
                  WideQuoteStr(contact.email) + ',' +
                  WideQuoteStr(contact.displayname) + ',' +
                  WideQuoteStr(contact.home) + ',' +
                  WideQuoteStr(contact.work) + ',' +
                  WideQuoteStr(contact.cell) + ',' +
                  WideQuoteStr(contact.fax) + ',' +
                  WideQuoteStr(contact.other) + ',' +
                  WideQuoteStr(GetContactDefPhone(contact)) + ',' +
                  WideQuoteStr(contact.homeAddress.street) + ',' +
                  WideQuoteStr(contact.homeAddress.city) + ',' +
                  WideQuoteStr(contact.homeAddress.region) + ',' +
                  WideQuoteStr(contact.homeAddress.postalCode) + ',' +
                  WideQuoteStr(contact.homeAddress.country) + ',' +
                  WideQuoteStr(DateToStr(contact.Birthday));
                sl.add(str);
              end;
            except
            end;
            node := GetNext(node);
          end;
        end;
        sl.SaveToFile(FileName);
        sl.Free;
      end;
    4:begin//XML
        XML := TXML.Create;
        try
          XML.TagName := 'fma_contacts'; // do not localize
          with ListContacts do begin
            Node := GetFirst;
            while assigned(Node) do begin
              if Selected[Node] then
                with XML.AddChild('contact') do begin // do not localize
                  Contact := GetNodeData(Node);
                  AddChild('title',     HTMLEncode(WideStringToUTF8String(contact.title), False)); // do not localize
                  AddChild('name',      HTMLEncode(WideStringToUTF8String(contact.name), False)); // do not localize
                  AddChild('surname',   HTMLEncode(WideStringToUTF8String(contact.surname), False)); // do not localize
                  AddChild('org',       HTMLEncode(WideStringToUTF8String(contact.org), False)); // do not localize
                  AddChild('email',     HTMLEncode(WideStringToUTF8String(contact.email), False)); // do not localize
                  AddChild('home',      HTMLEncode(WideStringToUTF8String(contact.home), False)); // do not localize
                  AddChild('work',      HTMLEncode(WideStringToUTF8String(contact.work), False)); // do not localize
                  AddChild('cell',      HTMLEncode(WideStringToUTF8String(contact.cell), False)); // do not localize
                  AddChild('fax',       HTMLEncode(WideStringToUTF8String(contact.fax), False)); // do not localize
                  AddChild('other',     HTMLEncode(WideStringToUTF8String(contact.other), False)); // do not localize
                  AddChild('street',    HTMLEncode(WideStringToUTF8String(contact.homeAddress.street),False)); // do not localize
                  AddChild('city',      HTMLEncode(WideStringToUTF8String(contact.homeAddress.city),False)); // do not localize
                  AddChild('region',    HTMLEncode(WideStringToUTF8String(contact.homeAddress.region),False)); // do not localize
                  AddChild('postalCode',HTMLEncode(WideStringToUTF8String(contact.homeAddress.postalCode),False)); // do not localize
                  AddChild('country',   HTMLEncode(WideStringToUTF8String(contact.homeAddress.country),False)); // do not localize
                end;
              Node := GetNext(Node);
            end;
          end;
          XML.Save(FileName);
        finally
         XML.Free;
        end;
      end;
    5:begin//HTML
        sl := TStringList.Create;
        sl.Add('<html><head><meta content="text/html;charset=utf-8" http-equiv="content-type">'); // do not localize
        sl.Add('<title>FMA Contacts</title></head><body>'); // do not localize
        sl.Add('<TABLE BORDER="1">'); // do not localize
        sl.Add('<TR><TD>Title</TD><TD>Name</TD><TD>Surname</TD><TD>Organization</TD><TD>Email</TD>'); // do not localize
        sl.Add('<TD>Home</TD><TD>Work</TD><TD>Cell</TD><TD>Fax</TD><TD>Other</TD></TR>'); // do not localize
        sl.Add('<TD>Street</TD><TD>City</TD><TD>Region</TD><TD>PostalCode</TD><TD>Country</TD></TR>'); // do not localize
        with ListContacts do begin
          node := GetFirst;
          while Assigned(Node) do begin
            try
              if Selected[node] then begin
                contact := GetNodeData(node);
                str := '<TR>'; // do not localize
                str := str + '<TD>' + HTMLEncode(WideStringToUTF8String(contact.title),False) + '</TD>'; // do not localize
                str := str + '<TD>' + HTMLEncode(WideStringToUTF8String(contact.name),False) + '</TD>'; // do not localize
                str := str + '<TD>' + HTMLEncode(WideStringToUTF8String(contact.surname),False) + '</TD>'; // do not localize
                str := str + '<TD>' + HTMLEncode(WideStringToUTF8String(contact.org),False) + '</TD>'; // do not localize
                str := str + '<TD>' + HTMLEncode(WideStringToUTF8String(contact.email),False) + '</TD>'; // do not localize
                str := str + '<TD>' + HTMLEncode(WideStringToUTF8String(contact.home),False) + '</TD>'; // do not localize
                str := str + '<TD>' + HTMLEncode(WideStringToUTF8String(contact.work),False) + '</TD>'; // do not localize
                str := str + '<TD>' + HTMLEncode(WideStringToUTF8String(contact.cell),False) + '</TD>'; // do not localize
                str := str + '<TD>' + HTMLEncode(WideStringToUTF8String(contact.fax),False) + '</TD>'; // do not localize
                str := str + '<TD>' + HTMLEncode(WideStringToUTF8String(contact.other),False) + '</TD>'; // do not localize
                str := str + '<TD>' + HTMLEncode(WideStringToUTF8String(contact.homeAddress.street),False) + '</TD>'; // do not localize
                str := str + '<TD>' + HTMLEncode(WideStringToUTF8String(contact.homeAddress.city),False) + '</TD>'; // do not localize
                str := str + '<TD>' + HTMLEncode(WideStringToUTF8String(contact.homeAddress.region),False) + '</TD>'; // do not localize
                str := str + '<TD>' + HTMLEncode(WideStringToUTF8String(contact.homeAddress.postalCode),False) + '</TD>'; // do not localize
                str := str + '<TD>' + HTMLEncode(WideStringToUTF8String(contact.homeAddress.country),False) + '</TD>'; // do not localize
                str := str + '</TR>'; // do not localize
                sl.add(str);
              end;
            except
            end;
            node := GetNext(node);
          end;
        end;
        sl.Add('</TABLE>'); // do not localize
        sl.Add('</body></html>'); // do not localize
        sl.SaveToFile(FileName);
        sl.Free;
      end;
    6:begin//Opera contacts (.adr)
        {
        Opera Hotlist version 2.0
        Options: encoding = utf8, version=3

        #FOLDER
          ID=298
          NAME=FMA
          CREATED=1108048774
          ACTIVE=YES
          EXPANDED=YES

        #CONTACT
          ID=311
          NAME=Zhelyazkova, Denitsa BG - EBU
          URL=http://dir.bg
          CREATED=1108048177
          DESCRIPTION=second email adr
          SHORT NAME=deni
          ACTIVE=YES
          MAIL=dzh@ebu.egmont.comtest@eee.de
          PHONE=555999888
          FAX=555111111
          POSTALADDRESS=Sofiastreet123
          PICTUREURL=http://www.mobileagent.info/custom_imgs/forums_logo4.gif
          ICON=Contact34
        }
        sl := TStringList.Create;
        sl.Add('Opera Hotlist version 2.0'); // do not localize
        sl.Add('Options: encoding = utf8, version=3'); // do not localize
        sl.Add(''); // do not localize
        { Export contacts under FMA folder }
        sl.Add('#FOLDER'); // do not localize
        sl.Add('  NAME=FMA'); // do not localize
        { TODO -oagra : add CREATED support }
        sl.Add('  ACTIVE=YES'); // do not localize
        sl.Add('  EXPANDED=YES'); // do not localize
        sl.Add(''); // do not localize
        with ListContacts do begin
          node := GetFirst;
          while Assigned(Node) do begin
            try
              if Selected[node] then begin
                contact := GetNodeData(node);
                sl.Add('#CONTACT'); // do not localize
                str := GetContactDisplayName(contact);
                sl.Add('  NAME=' + WideStringToUTF8String(str)); // do not localize
                if WideCompareText(str,GetContactFullName(contact)) <> 0 then
                  sl.Add('  SHORT NAME=' + WideStringToUTF8String(GetContactFullName(contact))); // do not localize
                { TODO -oagra : add CREATED support }
                sl.Add('  MAIL=' + WideStringToUTF8String(contact.email)); // do not localize
                sl.Add('  PHONE=' + WideStringToUTF8String(contact.cell)); // do not localize
                sl.Add('  FAX=' + WideStringToUTF8String(contact.fax)); // do not localize
                sl.Add('  POSTALADDRESS=' + WideStringToUTF8String(GetContactPostalAddress(contact,#2#2))); // do not localize
                str := GetContactPictureFile(contact);
                if str <> '' then
                  sl.Add('  PICTUREURL=file://localhost/' + HTMLEncode(WideStringToUTF8String(str),False)); // do not localize
                sl.Add('  ICON=Contact0'); // do not localize
                sl.Add(''); // do not localize
              end;
            except
            end;
            node := GetNext(node);
          end;
        end;
        sl.Add('-'); // do not localize
        sl.Add(''); // do not localize
        sl.SaveToFile(FileName);
        sl.Free;
      end;
  end;
end;

procedure TfrmSyncPhonebook.ForceNewContactClick(Sender: TObject);
begin
  ForceContact(0);
end;

procedure TfrmSyncPhonebook.ForceContact(State: integer);
var
  node: PVirtualNode;
  contact: PContactData;
begin
  with ListContacts do
  try
    BeginUpdate;
    node := GetFirst;
    while Assigned(node) do begin
      if Selected[node] then begin
        contact := GetNodeData(node);
        if contact.StateIndex <> 0 then contact.StateIndex := State;
      end;
      node := GetNext(node);
    end;
  finally
    EndUpdate;
  end;
end;

procedure TfrmSyncPhonebook.ListContactsAfterPaint(
  Sender: TBaseVirtualTree; TargetCanvas: TCanvas);
begin
  NoItemsPanel.Visible := ListContacts.ChildCount[nil] = 0;
end;

procedure TfrmSyncPhonebook.PopupMenu1Popup(Sender: TObject);
var
  m: TTntMenuItem;
  contact: PContactData;
  cgroups: WideString;
  itNode: PVirtualNode;
  EData: PFmaExplorerNode;
begin
  DownloadEntirePhonebook1.Enabled := Form1.FConnected and not Form1.FObex.Connected;
  Properties1.Enabled := ListContacts.SelectedCount = 1;
  if FirstLast1.Checked then FirstLast2.Checked := True
    else LastFirst2.Checked := True; // sync FirstLast menus
  DoBuildColumnsPopup(DisplayColumns1);
  AddtoGroup1.Clear;
  if Properties1.Enabled then begin
    contact := ListContacts.GetNodeData(ListContacts.FocusedNode);
    cgroups := Form1.LookupContactGroups(GetContactFullName(contact));
    { Add To Group only for modified and normal contacts, exclude new and deleted ones }
    if contact.StateIndex in [1,3] then begin
      if Assigned(Form1.FNodeGroups) then begin
        itNode := Form1.FNodeGroups.FirstChild;
        while itNode <> nil do begin
          EData := Form1.ExplorerNew.GetNodeData(itNode);
          m := TTntMenuItem.Create(nil);
          try
            m.AutoHotkeys := maManual;
            m.Caption := EData.Text;
            m.Tag := EData.StateIndex;
            m.ImageIndex := 53;
            m.OnClick := AddToGroupClick; // see few lines bellow for implementation
            AddtoGroup1.Add(m);
          except
            m.Free;
          end;
          itNode := itNode.NextSibling;
        end;
      end;
    end;
  end;
  AddtoGroup1.Enabled := AddtoGroup1.Count <> 0;
end;

procedure TfrmSyncPhonebook.AddToGroupClick(Sender: TObject);
var
  Node: PVirtualNode;
  Person: PContactData;
  i,index: integer;
  cname,cnumb: WideString;
  dlg: TfrmStatusDlg;
  IsModified: boolean;
  procedure DoAddToGroup(m: TTntMenuItem);
  var
    node: PVirtualNode;
    data: PFmaExplorerNode;
  begin
    { Find group node in Explorer }
    node := Form1.FNodeGroups.FirstChild;
    while Assigned(node) do begin
      data := Form1.ExplorerNew.GetNodeData(node);
      if data.StateIndex = m.Tag then
        break;
      node := node.NextSibling;
    end;
    { Already added? }
    if Assigned(node) and Assigned(Form1.FindExplorerPhoneNode(cnumb,node)) then
      exit;
    { Add contact to group }
    Form1.Status(WideFormat(_('Adding %s...'),[cname]),False);
    Form1.TxAndWait('AT*ESAG='+IntToStr(m.Tag)+',2,'+IntToStr(index)); // do not localize
    Form1.ExplorerAddToGroup(m.Tag,cname,cnumb);
    IsModified := True;
  end;
begin
  IsModified := False;
  dlg := ShowStatusDlg(_('Adding to Group...'));
  try
    Node := ListContacts.GetFirst;
    while Assigned(Node) do
    try
      if ListContacts.Selected[Node] then begin
        Person := ListContacts.GetNodeData(Node);
        cname := GetContactFullName(Person);
        with TfrmAddToGroup.Create(nil) do
        try
          Contact := Person;
          lblGroup.Caption := (Sender as TTntMenuItem).Caption;
          if clNumbers.Count <> 1 then dlg.Hide;
          if (clNumbers.Count = 1) or (ShowModal = mrOk) then begin
            dlg.Show;
            dlg.Update;
            { Default number }
            if RadioButton1.Checked then begin
              cnumb := Form1.ExtractNumber(lblNumber.Caption);
              index := ContactDefPosition(Person);
              if index < 1 then begin
                Form1.Status(WideFormat(_('Locate position for %s...'),[cname]),False);
                index := Form1.LocatePBIndex('ME',cname,GetContactDefPhone(Person)); // do not localize
              end;
              if index > 0 then begin
                { Remember found position, ie. make a cache here }
                ContactDefPosition(Person,index);
                { Add to group }
                DoAddToGroup(Sender as TTntMenuItem);
              end;
            end
            else begin
              { Custom numbers }
              for i := 0 to clNumbers.Count-1 do begin
                if clNumbers.Checked[i] then begin
                  cnumb := GetNumber(i);
                  index := GetContactPosition(Person,cnumb);
                  if index < 1 then begin
                    Form1.Status(WideFormat(_('Locate position for %s...'),[cname]),False);
                    index := Form1.LocatePBIndex('ME',cname,cnumb); // do not localize
                  end;
                  if index > 0 then begin
                    { Remember found position, ie. make a cache here }
                    SetContactPosition(Person,cnumb,index);
                    { Add to group }
                    DoAddToGroup(Sender as TTntMenuItem);
                  end;
                end;
                if ThreadSafe.AbortDetected then break;
              end;
            end;
          end;
        finally
          Free;
        end;
      end;
    finally
      Node := ListContacts.GetNext(Node);
    end;
  finally
    dlg.Free;
    if IsModified then begin
      Form1.Status(_('Group updated'),False);
      //Form1.InitGroups; --- not needed, because we used Form1.ExplorerAddToGroup()
    end;
  end;
end;

function TfrmSyncPhonebook.DoEdit(AsNew: boolean; NewNumber: string; ContactData: PContactData): boolean;
var
  Node: PVirtualNode;
  NewBday: Boolean;
  procedure SyncChanges;
  begin
    ListContacts.Sort(nil, ListContacts.Header.SortColumn, ListContacts.Header.SortDirection);
    ListContacts.Update;
    Form1.UpdateMEPhonebook;
    { Focus moved edited item in the list }
    if ListContacts.FocusedNode <> nil then begin
      Node := ListContacts.FocusedNode;
      ListContacts.FocusedNode := nil;
      ListContacts.FocusedNode := Node;
    end;
  end;
begin
  Result := False;
  if ContactData <> nil then begin
    SelContact := ContactData;
    AsNew := False;
  end;
  if AsNew then State := 0
  else begin
    State := Selcontact.StateIndex;
    if State = 0 then State := 4 //new >> modified
      else if State = 3 then State := 1;
  end;
  with TfrmEditContact.Create(nil) do
  try
    IsNew := (State = 0) or (Selcontact = nil);
    // set restrictions
    MaxFullNameLen := FMaxNameLen;
    txtName.MaxLength := FMaxNameLen;
    txtDisplayAs.MaxLength := FMaxNameLen; //??
    txtTitle.MaxLength := FMaxTitleLen;
    txtOrganization.MaxLength := FMaxOrgLen;
    //txtEmail.MaxLength := FMaxMailLen;
    txtHome.MaxLength := FMaxTellen;
    txtWork.MaxLength := FMaxTellen;
    txtCell.MaxLength := FMaxTellen;
    txtFax.MaxLength := FMaxTellen;
    txtOther.MaxLength := FMaxTellen;
    // update contact state
    if IsNew then begin
      FillChar(contact,SizeOf(contact),0);
      contact.Birthday := EmptyDate;
      contact.cell := NewNumber;
    end
    else
      contact := Selcontact^;
    // record undo info, or set own card mode
    if ContactData = nil then FUndoEdit := contact
      else UseOwnMode := True;
    // edit contact
    if ShowModal = mrOk then begin
      NewBday := False;
      if Modified then with ListContacts do begin
        // apply total updates
        BeginUpdate;
        try
          if IsNew then begin
            // Set DisplayName according to FMA default settings
            setDisplayName(@contact,form1.FDisplayNameFormat,LastFirst1.Checked);
            // create new node
            FocusedNode := AddChild(nil);
            Selcontact := ListContacts.GetNodeData(FocusedNode);
            Selcontact^.Birthday := EmptyDate;
          end
          else
            CheckDefaultDisplayName(@contact,LastFirst1.Checked);
          { copy all data }
          NewBday := IsEmptyDate(Selcontact^.Birthday) and not IsEmptyDate(contact.Birthday);
          Selcontact^ := contact;
          if IsNew then begin
            // new node, update IDs
            Selcontact^.LUID := '';
            Selcontact^.CDID := NewGUID;
          end;
          Selcontact^.stateindex := State;
          if State = 4 then Selcontact^.stateindex := 0;
          if (State > 0) and (ContactData = nil) then
            UndoLastChange1.Visible := True;   // undo not works on new contact
          Selcontact^.Modified := Now;
          { save call notes to DB }
          SetContactNotes(Selcontact,ContactNotes);
          Result := True;
        finally
          RenderGUIDs;
          EndUpdate;
          SyncChanges;
        end;
      end else
      if customModified then with ListContacts do begin
        // apply only Fma custom data updates
        BeginUpdate;
        try
          { copy custom data only }
          Selcontact^.DefaultIndex := contact.DefaultIndex;
          Selcontact^.Position := contact.Position;
          Selcontact^.picture := contact.picture;
          Selcontact^.sound := contact.sound;
          SelContact^.CDID := contact.CDID;
          if ContactData = nil then UndoLastChange1.Visible := True;
          { save call notes to DB }
          SetContactNotes(Selcontact,ContactNotes);
          Result := True;
        finally
          EndUpdate;
          SyncChanges;
        end;
      end;
      if NewBday and Form1.FCalAutoBirthday then
        case MessageDlgW(WideFormat(_('Do you want to create Calendar entry for %s''s birthday?'),
          [GetContactDisplayName(SelContact)]), mtConfirmation, MB_YESNO) of
          ID_YES:
            DoAddCalendarBirthday;
          ID_NO:
            if not Form1.FStartupOptions.NoBaloons then
              Form1.ShowBaloonInfo(_('You can disable Calendar Birthdays in Tools | Options | Synchronization | Events and  Tasks.'));
        end;
    end;
  finally
    Free;
  end;
end;

procedure TfrmSyncPhonebook.UndoLastChange1Click(Sender: TObject);
var
  Node :PVirtualNode;
begin
  Node := ListContacts.GetFirst;
  while Assigned(Node) do begin
    if Node.Index = FUndoIndx then
      break;
    Node := ListContacts.GetNext(Node);
  end;
  if Node <> nil then begin
    { multiselect is enabled, so this is not correct
    if ListContacts.FocusedNode <> nil then
      ListContacts.FocusedNode.States := ListContacts.FocusedNode.States - [vsSelected];
    Node.States := Node.States + [vsSelected];
    }
    ListContacts.FocusedNode := Node;
    ListContacts.ScrollIntoView(Node,True);
    Selcontact := ListContacts.GetNodeData(Node);
    SelContact^ := FUndoEdit;
    UndoLastChange1.Visible := False;
    ListContacts.Repaint;
    { refresh explorer view on-the-fly (it's quick, don't worry) }
    Form1.UpdateMEPhonebook;
  end;
end;

procedure TfrmSyncPhonebook.ListContactsIncrementalSearch(
  Sender: TBaseVirtualTree; Node: PVirtualNode;
  const SearchText: WideString; var Result: Integer);
var
  Contact: PContactData;
  Text: WideString;
begin
  Contact := ListContacts.GetNodeData(Node);
  Text := Copy(GetContactDisplayName(Contact),1,Length(SearchText));
  Result := WideCompareText(SearchText,Text);
end;

procedure TfrmSyncPhonebook.ListContactsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (ListContacts.SelectedCount = 1) then
    btnEditClick(nil);
end;

procedure TfrmSyncPhonebook.ImportContacts1Click(Sender: TObject);
var
  i,j,adds,mods: integer;
  Node,ANode: PVirtualNode;
  contact: PContactData;
  sl: TStringList;
  slPart: TStrings;
  F: WideString;
  Modified: boolean;
  dlg: TfrmConnect;

  procedure ProcessContact;
  begin
    F := GetvCardFullName(VCard);
    Modified := False;
    //erase the old entry if present
    if FindContact(F,ANode) then begin
      contact := ListContacts.GetNodeData(ANode);
      case MessageDlgW(WideFormat(_('%0:s [%1:s] already exists. Do you want to replace it with newly imported one?'+
        sLinebreak+sLinebreak+
        'Click Yes to replace it, or click No to add it as a New contact'),[F,GetContactDefPhone(contact)]),
        mtConfirmation, MB_YESNOCANCEL or MB_DEFBUTTON2) Of
        ID_YES: begin
          ListContacts.DeleteNode(ANode);
          Log.AddSynchronizationMessage(F + _(' modified in FMA by Import.'), lsInformation);
          Modified := True;
        end;
        ID_NO: Log.AddSynchronizationMessage(F + _(' added to FMA by Import (as dublicate).'), lsInformation);
        ID_CANCEL: Abort;
      end;
    end
    else Log.AddSynchronizationMessage(F + _(' added to FMA by Import.'), lsInformation);
    Node := ListContacts.AddChild(nil);
    contact := ListContacts.GetNodeData(Node);
    vCard2Contact(VCard,contact);
    if Modified then begin
      contact.stateindex := 1;
      inc(mods);
    end
    else begin
      contact.stateindex := 0;
      inc(adds);
      // Set DisplayName according to FMA default settings
      SetDisplayName(contact,Form1.FDisplayNameFormat,LastFirst1.Checked);
    end;
    // TODO: add picture and sound support here....
    ListContacts.Update;
  end;

begin
  if not OpenDialog1.Execute then exit;
  Update;
  dlg := GetProgressDialog;
  try
    if Form1.CanShowProgress then
      dlg.ShowProgress(Form1.FProgressLongOnly);
    dlg.Initialize(OpenDialog1.Files.Count,_('Importing phonebook contacts'));

    Form1.Status(_('Importing contacts...'));
    Log.AddSynchronizationMessage(_('Import started'));

    adds := 0; mods := 0;
    //ListContacts.BeginUpdate;
    sl := TStringList.Create;
    try
      for i := 0 to OpenDialog1.Files.Count-1 do begin
        sl.LoadFromFile(OpenDialog1.Files[i]);
        dlg.IncProgress(1);
        VCard.Clear;
        if (LowerCase(ExtractFileExt(OpenDialog1.Files[i])) <> '.ldif')
           and (LowerCase(ExtractFileExt(OpenDialog1.Files[i])) <> '.ldi') then
        begin
          VCard.Raw := sl;
          ProcessContact;
        end
        else
        begin
          slPart := TStringList.Create;
          try
            for j := 0 to sl.Count-1 do
            begin
              if Length(sl.Strings[j])<>0 then
                slPart.Add(sl.Strings[j])
              else
                if slPart.Count>0 then
                  try
                    if VCard.LoadFromLDIF(slPart) then
                      ProcessContact;
                  finally
                    slPart.Clear;
                    VCard.Clear;
                  end;
            end;
          finally
            FreeAndNil(slPart);
          end;
        end;
      end;
    finally
      sl.free;
      if (adds <> 0) or (mods <> 0) then begin
        RenderGUIDs;
        //ListContacts.EndUpdate;
        ListContacts.Sort(nil, ListContacts.Header.SortColumn, ListContacts.Header.SortDirection);
        ListContacts.Update;
        Form1.UpdateMEPhonebook;
        Log.AddSynchronizationMessage(WideFormat(_('Imported %d %s'),[adds+mods,ngettext('item','items',adds+mods)]),lsInformation);
      end;
    end;
  finally
    FreeProgressDialog;
    Log.AddSynchronizationMessage(_('Import finished'));
    Form1.Status(_('Import complete.'));
  end;
end;

function TfrmSyncPhonebook.FindContact(FullName: WideString;
  var AContact: PContactData): boolean;
var
  Node :PVirtualNode;
begin
  Result := False;
  Node := ListContacts.GetFirst;
  while Assigned(Node) do begin
    AContact := ListContacts.GetNodeData(Node);
    if WideCompareText(FullName,GetContactFullName(AContact)) = 0 then begin
      Result := True;
      break;
    end;
    Node := ListContacts.GetNext(Node);
  end;
end;

function TfrmSyncPhonebook.FindContact(FullName: WideString;
  var ANode: PVirtualNode): boolean;
var
  AContact: PContactData;
begin
  Result := False;
  ANode := ListContacts.GetFirst;
  while Assigned(ANode) do begin
    AContact := ListContacts.GetNodeData(ANode);
    if WideCompareText(FullName,GetContactFullName(AContact)) = 0 then begin
      Result := True;
      break;
    end;
    ANode := ListContacts.GetNext(ANode);
  end;
end;

procedure TfrmSyncPhonebook.ClearChangedFlag1Click(Sender: TObject);
begin
  ForceContact(3);
end;

function TfrmSyncPhonebook.GetPhoneCapacity: Integer;
var
  i: Integer;
  buffer, stop: String;
  slTmp: TStrings;
begin
  Form1.TxAndWait('AT+CPBS="ME"'); // do not localize
  Form1.TxAndWait('AT+CPBR=?'); // do not localize
  // defaults
  buffer := '';
  stop := '510'; FMaxNameLen := 180; FMaxTelLen := 80;
  // +CPBR: (1-200),80,180
  for i := 0 to ThreadSafe.RxBuffer.Count-1 do
    if Pos('+CPBR',ThreadSafe.RxBuffer.Strings[i]) = 1 then begin // do not localize
      buffer := ThreadSafe.RxBuffer.Strings[i];
      break;
    end;
  for i := 1 to length(buffer) do begin
    if IsDelimiter('()-,', buffer, i) then buffer[i] := ' ';
  end;
  // +CPBR:  1 200  80 180
  if buffer <> '' then begin
    slTmp := TStringList.Create;
    try
      slTmp.DelimitedText := buffer;
      stop := slTmp.Strings[2];
      Log.AddMessage('Contact: max entries = '+stop, lsDebug); // do not localize debug
      FMaxTelLen := StrToInt(slTmp.Strings[3]);
      Log.AddMessage('Contact: max tel length = '+slTmp.Strings[3], lsDebug); // do not localize debug
      FMaxNameLen := StrToInt(slTmp.Strings[4]);
      Log.AddMessage('Contact: max name length = '+slTmp.Strings[4], lsDebug); // do not localize debug
    finally
      slTmp.Free;
    end;
  end;
  Result := StrToInt(stop);
end;

procedure TfrmSyncPhonebook.OnConnected;
begin
  FMaxRecME := GetPhoneCapacity;
end;

procedure TfrmSyncPhonebook.RenderGUIDs;
var
  contact: PContactData;
  Node: PVirtualNode;
begin
  { Make sure all contacts' GUIDs are unique }
  Node := ListContacts.GetFirst;
  while Assigned(Node) do begin
    contact := ListContacts.GetNodeData(Node);
    repeat
      if IsUniqueGUID(contact) then break;
      contact.CDID := NewGUID;
    until False;
    Node := ListContacts.GetNext(Node);
  end;
end;

function TfrmSyncPhonebook.IsUniqueGUID(who: PContactData): boolean;
var
  Node: PVirtualNode;
  contact: PContactData;
begin
  { Checks whether who contact has an unique GUID field }
  Result := True;
  Node := ListContacts.GetFirst;
  while Assigned(Node) do begin
    contact := ListContacts.GetNodeData(Node);
    if (contact <> who) and (GUIDToString(contact.CDID) = GUIDToString(who.CDID)) then begin
      Result := False;
      break;
    end;
    Node := ListContacts.GetNext(Node);
  end;
end;

function TfrmSyncPhonebook.FullRefresh: boolean;
var
  sl : TStringList;
  cardstr : TStringList;
  slCC :TStringList;
  i:Integer;
  AsNew,isAgent,isBody: Boolean;
  migrate: TContactData;
  contact: PContactData;
  Node,TmpNode: PVirtualNode;
begin
  Result := False;
  //check if start OBEX
  if not Form1.FConnected then begin
     ShowMessageW(_('The Sync Phonebook can''t start...try to restart your phone.'));
     Log.AddSynchronizationMessage(_('The Sync Phonebook can''t start...try to restart your phone.'), lsError);
     Form1.ActionSyncPhonebook.Enabled := True;
     exit;
  end;
  Update;
  sl := TStringList.Create;
  cardstr := TStringList.Create;
  //Start get of entire phonebook
  Form1.ObexConnect('IRMC-SYNC');       //start sync process // do not localize
  try
    Form1.ObexGetObject('telecom/pb.vcf',sl,True,_('entire phonebook')); // do not localize "telecom..."
    slCC := TStringList.Create;
    try
      Form1.ObexGetObject('telecom/pb/luid/cc.log',slCC);   //Take CC // do not localize
      CC := slCC.Strings[0];
    finally
      slCC.Free;
    end;
  finally
    Form1.ObexDisconnect;        //close the connection
  end;

  ListContacts.BeginUpdate;
  try
    { Mark all entries as deleted }
    Node := ListContacts.GetFirst;
    while Assigned(Node) do begin
      contact := ListContacts.GetNodeData(Node);
      contact.StateIndex := 2;
      Node := ListContacts.GetNext(Node);
    end;
    try
      { Process phonebook entries }
      isBody := False;
      VCard.clear;
      isAgent := False;
      for i := 0 to sl.Count - 1 do begin
        { check for nested vCard and ignore it, if any }
        if pos('AGENT', sl.Strings[i]) = 1 then isAgent := True; // do not localize
        if isAgent then begin
          if pos('END', sl.Strings[i]) = 1 then isAgent := False; // do not localize
          Continue;
        end;
        { process vCard data }
        if pos('BEGIN', sl.Strings[i]) = 1 then isBody := True; // do not localize
        if isBody then begin
          cardstr.add(sl.Strings[i]);
        end;
        if pos('END', sl.Strings[i]) = 1 then begin // do not localize
          isBody := False;
          VCard.Raw := cardstr;
          cardstr.Clear;
          if LFindContact(VCard.LUID,contact) then begin
            migrate := contact^;
            AsNew := False;
          end
          else
            AsNew := True;
          if not AsNew then
            EraseContact(VCard.LUID,False);
          //Add new Node and Parse VCard
          Node := ListContacts.AddChild(nil);
          contact := ListContacts.GetNodeData(Node);
          vCard2Contact(VCard,contact);
          contact.stateindex := 3;
          //Migrate Fma internal settings
          if not AsNew then
            MigrateContact(@migrate,contact);
          // TODO: add picture and sound support here....
          Log.AddSynchronizationMessage(GetvCardFullName(VCard) + _(' added to FMA by phone.'), lsInformation);
          VCard.Clear;
        end;
      end;
    finally
      { Clear all deleted entries }
      Node := ListContacts.GetFirst;
      while Assigned(Node) do begin
        contact := ListContacts.GetNodeData(Node);
        if contact.StateIndex <> 3 then begin
          TmpNode := Node;
          Node := ListContacts.GetNext(Node);
          ListContacts.DeleteNode(TmpNode);
          Log.AddSynchronizationMessage(GetContactFullName(contact) + _(' is obsolete in FMA.'), lsInformation);
        end
        else
          Node := ListContacts.GetNext(Node);
      end;
    end;
    DoFirstImportCheck;
    Result := True;
  finally
    ListContacts.EndUpdate;
    ListContacts.Sort(nil, ListContacts.Header.SortColumn, ListContacts.Header.SortDirection);
    ListContacts.Update;
    UndoLastChange1.Visible := False;
    sl.Free;
    cardstr.Free;
  end;
end;

function TfrmSyncPhonebook.LFindContact(LUID: Widestring;
  var AContact: PContactData): Boolean;
var
  Node: PVirtualNode;
  contact: PContactData;
begin
  Result := False;
  with ListContacts do begin
    Node := GetFirst;
    while Assigned(Node) do begin
      contact := GetNodeData(node);
      if LUID = contact.LUID then begin
         AContact := contact;
         Result := True;
         break;
      end;
      Node := GetNext(Node);
    end;
  end;
end;

procedure TfrmSyncPhonebook.DoFirstImportCheck;
var
  Node: PVirtualNode;
  contact: PContactData;
  HasCells,HasHomes: boolean;
  s: string;
begin
  HasCells := False;
  HasHomes := False;
  with ListContacts do begin
    Node := GetFirst;
    while Assigned(Node) do begin
      contact := GetNodeData(node);
      if contact.cell <> '' then HasCells := True;
      if contact.home <> '' then HasHomes := True;
      Node := GetNext(Node);
    end;
  end;
  { Is this first import from 'old' phone which keep numbers into Home position
    instead of Cell one? This usualy happens when one imports all contacts
    from its SIM card into Phone's memory (phonebook). }
  if not HasCells and HasHomes then
    { Yes, offer exchange }
    if MessageDlgW(_('It seams that all your phone numbers are stored into Home positions. '+
      'Do you wish to exchange them with Cell ones?'),
      mtConfirmation, MB_YESNO) = ID_YES then begin
      with ListContacts do begin
        Node := GetFirst;
        while Assigned(Node) do begin
          contact := GetNodeData(node);
          if contact.home <> '' then begin
            s := contact.cell;
            contact.cell := contact.home;
            contact.home := s;
            contact.StateIndex := 1; // modified
          end;
          Node := GetNext(Node);
        end;
      end;
    end;
end;

procedure TfrmSyncPhonebook.FirstLast1Click(Sender: TObject);
begin
  (Sender as TTntMenuItem).Checked := True;
  ListContacts.Sort(nil, ListContacts.Header.SortColumn, ListContacts.Header.SortDirection);
  ListContacts.ScrollIntoView(ListContacts.FocusedNode,true,false);
end;

procedure TfrmSyncPhonebook.DownloadEntirePhonebook1Click(Sender: TObject);
begin
  if MessageDlgW(_('Local Phonebook will be replaced with a fresh copy from the phone.'+
    sLinebreak+sLinebreak+
    'Any local changes will be lost. Do you wish to continue?'),
    mtConfirmation, MB_YESNO or MB_DEFBUTTON2) = ID_YES then begin
      ListContacts.Clear;
      FullRefresh;
    end;
end;

function TfrmSyncPhonebook.FindContact(Number: WideString): WideString;
var
  Node :PVirtualNode;
  contact: PContactData;
begin
  Result := '';
  Node := ListContacts.GetFirst;
  while Assigned(Node) do begin
    contact := ListContacts.GetNodeData(Node);
    if IsContactPhone(contact,Number) then begin
      Result := GetContactFullName(contact);
      break;
    end;
    Node := ListContacts.GetNext(Node);
  end;
end;

procedure TfrmSyncPhonebook.FormStorage1SavePlacement(Sender: TObject);
var
  s: WideString;
  i: integer;
begin
  with ListContacts.Header do begin
    s := IntToStr(SortColumn)+','+IntToStr(Ord(SortDirection));
    for i := 0 to Columns.Count-1 do
      s := s+','+IntToStr(Columns[i].Width)+','+IntToStr(Columns[i].Position)+','+
        IntToStr(byte(coVisible in Columns[i].options));
  end;
  FormStorage1.StoredValue['ListHeader'] := s; // do not localize
end;

procedure TfrmSyncPhonebook.FormStorage1RestorePlacement(Sender: TObject);
var
  s: WideString;
  i: integer;
  j: cardinal;
  tokenCount: integer;
  poitionArray: array of integer;
  widthArray: array of integer;
  visibleArray: array of integer;
begin
  s := FormStorage1.StoredValue['ListHeader']; // do not localize
  tokenCount := (GetTokenCount(s)-2) div 3;
  if (s <> '') and (tokenCount = ListContacts.Header.Columns.Count) then
    try
      with ListContacts.Header do
      try
        SetLength(poitionArray, tokenCount);
        SetLength(widthArray, tokenCount);
        Setlength(visibleArray, tokenCount);

        SortColumn := StrToInt(GetFirstToken(s));
        SortDirection := TSortDirection(StrToInt(GetFirstToken(s)));

        // getting tokens into arrays
        for i := 0 to tokenCount-1 do begin
          widthArray[i]   := StrToInt(GetFirstToken(s));
          poitionArray[i] := StrToInt(GetFirstToken(s));
          visibleArray[i] := StrToInt(GetFirstToken(s));
          if i >= (Columns.Count-1) then break;
        end;
        for i := 0 to tokenCount-1 do begin
          //search for next pos
          j:=0;
          while poitionArray[j] <> i do inc(j);
          // j is now the column for next position
          Columns[j].Width := widthArray[j];
          Columns[j].Position := poitionArray[j];
          if visibleArray[j] = 0 then
            Columns[j].options := Columns[j].options - [coVisible]
          else
            Columns[j].options := Columns[j].options + [coVisible];
        end;

        // move displayname column close to position of Full Name column, but only if detected for the first time
        if (tokenCount < 16) and (Columns.Count = 16) then
          Columns[15].Position := Columns[2].Position+1;

        // autosize last column
        DoAutosizeLastColumn;
      finally
        SetLength(poitionArray, 0);
        SetLength(widthArray, 0);
        Setlength(visibleArray, 0);
      end;
      if FirstLast1.Checked then FirstLast1Click(FirstLast1)
        else FirstLast1Click(LastFirst1);
    except
    end;
end;

procedure TfrmSyncPhonebook.ListContactsHeaderMouseUp(Sender: TVTHeader;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FormStorage1SavePlacement(nil);
end;

procedure TfrmSyncPhonebook.ListContactsHeaderDragged(Sender: TVTHeader;
  Column: TColumnIndex; OldPosition: Integer);
var
i,j : Integer;
begin
  // determine visible column with highest position and set to autosize column
  with ListContacts.Header do begin
    for i := (Columns.Count-1) downto 0 do begin
      j:=0;
      while integer(Columns[j].Position) <> (i) do inc(j);
      if coVisible in Columns[j].options then begin
        Columns.Header.AutoSizeIndex := j;
        break;
      end;
    end;
  end;
end;

procedure TfrmSyncPhonebook.DoBuildColumnsPopup(Where: TComponent);
var
  i,pos: Integer;
  Item: TTntMenuItem;
begin
  if Where = pmColumns then pmColumns.Items.Clear;
  if Where = DisplayColumns1 then DisplayColumns1.Clear;
  Item := TTntMenuItem.Create(nil);
  Item.Caption := 'Show &All Columns';
  Item.OnClick := PopupShowAll;
  if Where = pmColumns then pmColumns.Items.Add(Item);
  if Where = DisplayColumns1 then DisplayColumns1.Add(Item);
  Item := TTntMenuItem.Create(nil);
  Item.Caption := '-'; // do not localize
  if Where = pmColumns then pmColumns.Items.Add(Item);
  if Where = DisplayColumns1 then DisplayColumns1.Add(Item);
  with ListContacts.Header do begin
    for i := 1 to Columns.Count do begin
      pos := Columns.ColumnFromPosition(i-1);
      Item := TTntMenuItem.Create(nil);
      Item.Caption := Columns[pos].text;
      Item.Checked := coVisible in Columns[pos].options;
      Item.Autohotkeys := maManual;
      Item.Enabled := pos > 1;
      Item.OnClick := PopupHandler;
      Item.Tag := pos;
      if Where = pmColumns then pmColumns.Items.Add(Item);
      if Where = DisplayColumns1 then DisplayColumns1.Add(Item);
    end;
  end;
end;

procedure TfrmSyncPhonebook.pmColumnsPopup(Sender: TObject);
begin
  DoBuildColumnsPopup(pmColumns);
end;

procedure TfrmSyncPhonebook.DoAutosizeLastColumn;
var
  i,j: Integer;
begin
  // determine visible column with highest position and set to autosize column
  with ListContacts.Header do begin
    for i := (Columns.Count-1) downto 0 do begin
      j:=0;
      while Columns[j].Position <> TColumnPosition(i) do inc(j);
      if coVisible in Columns[j].options then begin
        Columns.Header.AutoSizeIndex := j;
        break;
      end;
    end;
  end;
end;

procedure TfrmSyncPhonebook.FirstLast2Click(Sender: TObject);
begin
  if Sender = LastFirst2 then LastFirst1.Click
    else FirstLast1.Click; // sync FirstLast menus
end;

procedure TfrmSyncPhonebook.OnConflictChanges(Sender: TObject;
  const TargetName, Option1Name, Option2Name: WideString);
  function DateToStr(ADate: TDateTime): string;
  begin
    if IsEmptyDate(ADate) then Result := '' else Result := SysUtils.DateToStr(ADate);
  end;
begin
  with TfrmConflictChanges.Create(nil) do
  try
    Target := TargetName;
    Option1 := Option1Name;
    Option2 := Option2Name;

    if WideCompareStr(ConflictVCardPhone.Name,ConflictVCardPC.Name) <> 0 then
      AddChange(_('Name'),ConflictVCardPhone.Name,ConflictVCardPC.Name);

    if WideCompareStr(ConflictVCardPhone.Surname,ConflictVCardPC.Surname) <> 0 then
      AddChange(_('Surname'),ConflictVCardPhone.Surname,ConflictVCardPC.Surname);

    if WideCompareStr(ConflictVCardPhone.TelWork,ConflictVCardPC.TelWork) <> 0 then
      AddChange(_('Tel Work'),ConflictVCardPhone.TelWork,ConflictVCardPC.TelWork);

    if WideCompareStr(ConflictVCardPhone.TelHome,ConflictVCardPC.TelHome) <> 0 then
      AddChange(_('Tel Home'),ConflictVCardPhone.TelHome,ConflictVCardPC.TelHome);

    if WideCompareStr(ConflictVCardPhone.TelFax,ConflictVCardPC.TelFax) <> 0 then
      AddChange(_('Tel Fax'),ConflictVCardPhone.TelFax,ConflictVCardPC.TelFax);

    if WideCompareStr(ConflictVCardPhone.TelCell,ConflictVCardPC.TelCell) <> 0 then
      AddChange(_('Tel Cell'),ConflictVCardPhone.TelCell,ConflictVCardPC.TelCell);

    if WideCompareStr(ConflictVCardPhone.TelOther,ConflictVCardPC.TelOther) <> 0 then
      AddChange(_('Tel Other'),ConflictVCardPhone.TelOther,ConflictVCardPC.TelOther);

    if WideCompareStr(ConflictVCardPhone.Email,ConflictVCardPC.Email) <> 0 then
      AddChange(_('Email'),ConflictVCardPhone.Email,ConflictVCardPC.Email);

    if WideCompareStr(ConflictVCardPhone.URL,ConflictVCardPC.URL) <> 0 then
      AddChange(_('URL'),ConflictVCardPhone.URL,ConflictVCardPC.URL);

    if ConflictVCardPhone.BDay <> ConflictVCardPC.BDay then
      AddChange(_('Birthday'),DateToStr(ConflictVCardPhone.BDay),DateToStr(ConflictVCardPC.BDay));

    if WideCompareStr(ConflictVCardPhone.Title,ConflictVCardPC.Title) <> 0 then
      AddChange(_('Title'),ConflictVCardPhone.Title,ConflictVCardPC.Title);

    if WideCompareStr(ConflictVCardPhone.Org,ConflictVCardPC.Org) <> 0 then
      AddChange(_('Company'),ConflictVCardPhone.Org,ConflictVCardPC.Org);

    if WideCompareStr(ConflictVCardPhone.homeAddress.Street,ConflictVCardPC.homeAddress.Street) <> 0 then
      AddChange(_('Street'),ConflictVCardPhone.homeAddress.Street,ConflictVCardPC.homeAddress.Street);

    if WideCompareStr(ConflictVCardPhone.homeAddress.City,ConflictVCardPC.homeAddress.City) <> 0 then
      AddChange(_('City'),ConflictVCardPhone.homeAddress.City,ConflictVCardPC.homeAddress.City);

    if WideCompareStr(ConflictVCardPhone.homeAddress.Region,ConflictVCardPC.homeAddress.Region) <> 0 then
      AddChange(_('Region'),ConflictVCardPhone.homeAddress.Region,ConflictVCardPC.homeAddress.Region);

    if WideCompareStr(ConflictVCardPhone.homeAddress.PostalCode,ConflictVCardPC.homeAddress.PostalCode) <> 0 then
      AddChange(_('Postal Code'),ConflictVCardPhone.homeAddress.PostalCode,ConflictVCardPC.homeAddress.PostalCode);

    if WideCompareStr(ConflictVCardPhone.homeAddress.Country,ConflictVCardPC.homeAddress.Country) <> 0 then
      AddChange(_('Country'),ConflictVCardPhone.homeAddress.Country,ConflictVCardPC.homeAddress.Country);

    if WideCompareStr(ConflictVCardPhone.workAddress.Street,ConflictVCardPC.workAddress.Street) <> 0 then
      AddChange(_('Work Street'),ConflictVCardPhone.workAddress.Street,ConflictVCardPC.workAddress.Street);

    if WideCompareStr(ConflictVCardPhone.workAddress.City,ConflictVCardPC.workAddress.City) <> 0 then
      AddChange(_('Work City'),ConflictVCardPhone.workAddress.City,ConflictVCardPC.workAddress.City);

    if WideCompareStr(ConflictVCardPhone.workAddress.Region,ConflictVCardPC.workAddress.Region) <> 0 then
      AddChange(_('Work Region'),ConflictVCardPhone.workAddress.Region,ConflictVCardPC.workAddress.Region);

    if WideCompareStr(ConflictVCardPhone.workAddress.PostalCode,ConflictVCardPC.workAddress.PostalCode) <> 0 then
      AddChange(_('Work Postal Code'),ConflictVCardPhone.workAddress.PostalCode,ConflictVCardPC.workAddress.PostalCode);

    if WideCompareStr(ConflictVCardPhone.workAddress.Country,ConflictVCardPC.workAddress.Country) <> 0 then
      AddChange(_('Work Country'),ConflictVCardPhone.workAddress.Country,ConflictVCardPC.workAddress.Country);

    if ChangeCount <> 0 then ShowModal
      else MessageDlgW(_('No changes found.'), mtInformation, MB_OK);
  finally
    Free;
  end;
end;

procedure TfrmSyncPhonebook.DoAddCalendarBirthday;
var
  dY,dM,dD: Word;
  Bday: TDateTime;
  AEntity: TVCalEntity;
  sl: TStringList;
begin
  if Assigned(SelContact) then begin
    { Create the EVENT in this year instead of the actual Birthday one }
    DecodeDate(SelContact^.Birthday,dY,dM,dD);
    Bday := Trunc(EncodeDate(CurrentYear,dM,dD));
    //Bday := Trunc(SelContact^.Birthday); // use real date instead
    { Show Calendar for that very day }
    Form1.SetExplorerNode(Form1.FNodeCalendar);
    Form1.frmCalendarView.VpDayView.Date := Bday;
    Application.ProcessMessages;
    {}
    AEntity := TVCalEntity.Create;
    try
      { Add it to current Calendar items... }
      sl := TStringList.Create;
      try
        {
        BEGIN:VEVENT
        DTSTART:20061029T220000Z
        DTEND:20061030T215900Z
        SUMMARY:TEST
        RRULE:YM1 10 #0
        CATEGORIES:MISCELLANEOUS
        LAST-MODIFIED:20061030T134234Z
        X-SONYERICSSON-DST:0
        X-IRMC-LUID:00000001006D
        END:VEVENT
        }
        sl.Add('BEGIN:VEVENT');
        sl.Add('DTSTART:'+FormatDateTime('yyyymmdd',Bday)+'T000000'); // Add 'Z' to make it UTC
        sl.Add('DTEND:'+FormatDateTime('yyyymmdd',Bday)+'T235900');
        sl.Add('SUMMARY;CHARSET=UTF-8:'+WideStringToUTF8String(GetContactDisplayName(SelContact)));
        if Form1.IsK610orBetter then sl.Add('RRULE:YM1 10 #0'); // Reccurence set to 1 year
        sl.Add('LOCATION;CHARSET=UTF-8:'+WideStringToUTF8String(GetContactHomeAdr(SelContact)));
        //sl.Add('DALARM:'+FormatDateTime('yyyymmdd',Bday)+'T093000');
        sl.Add('AALARM:'+FormatDateTime('yyyymmdd',Bday)+'T093000');
        sl.Add('CATEGORIES:ANNIVERSARY');
        sl.Add('LAST-MODIFIED:'+FormatDateTime('yyyymmdd"T"hhnn00',Now));
        sl.Add('END:VEVENT');
        AEntity.Raw := sl;
      finally
        sl.Free;
      end;
      { ...and mark this item as New }
      AEntity.VFmaState := 0; // UserField9 := '0';
      Form1.frmCalendarView.DB.Connected := False;
      try
        Form1.frmCalendarView.DB.vCalendar.Add(AEntity);
        Form1.frmCalendarView.DB.RefreshEvents;
        Form1.frmCalendarView.DB.RefreshResource;
      finally
        Form1.frmCalendarView.DB.Connected := True;
      end;
    except
      AEntity.Free;
    end;
  end;
end;

end.

