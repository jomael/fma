unit uOutlookSync;

{
*******************************************************************************
* Descriptions: Outlook Contact Sync Unit
* $Source: /cvsroot/fma/fma/uOutlookSync.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uOutlookSync.pas,v $
* Revision 1.7.2.2  2005/09/06 18:32:57  z_stoichev
* Bugfixes and improvements (2.1.1.102b)
*
* Revision 1.7.2.1  2005/08/17 18:40:54  lordlarry
* - Added Outlook Field Mappings
*
* Revision 1.9  2005/04/19 19:30:55  lordlarry
* Fixed: Category for new Contacts in Outlook was not written
*
* Revision 1.8  2005/04/18 19:15:40  lordlarry
* Added: Outlook Sync for Addresses
* Added: Any FMA Contact Field can be mapped to any Outlook Contact Field
*
* Revision 1.7  2005/02/19 12:51:01  lordlarry
* Changed Log Messages Category and Severity (Removing the SyncLog method)
*
* Revision 1.6  2005/02/08 15:38:54  voxik
* Merged with L10N branch
*
* Revision 1.5.12.2  2004/10/25 20:21:55  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.5.12.1  2004/10/19 19:48:48  expertone
* Add localization (gnugettext)
*
* Revision 1.5  2004/07/25 13:30:37  lordlarry
* Added the ability to select the Outlook folder where all the New contacts end up.
*
* Revision 1.4  2004/06/25 18:27:09  lordlarry
* Added this changelog header
*
*
}

interface

uses
  uContactSync, Outlook8, Classes, TntClasses;

type
  TOutlookContact = class(TContact)
  private
    FOutlookContact: ContactItem;
  protected
    function Exists: Boolean; override;
  public
    property OutlookContact: ContactItem read FOutlookContact write FOutlookContact;
  end;

  TOutlookContactFieldMapper = class(TContactFieldMapper)
  private
    FOutlookContact: ContactItem;
  protected
    function GetValue(Field: String): String; override;
    procedure SetValue(Field: String; const Value: String); override;
  public
    constructor Create;

    property OutlookContact: ContactItem read FOutlookContact write FOutlookContact;
  end;

  TOutlookContactSource = class(TContactSource)
  private
    Outlook: OutlookApplication;
    NmSpace: NameSpace;
    FCategories: TStrings;
    FFolders: TStrings;
    FNewContactsFolder: String;
    FNewContactsFolderFolder: MAPIFolder;
    function InCategories(OutlookContact: ContactItem): Boolean;
    procedure SetCategories(const Value: TStrings);
    procedure SetFolders(const Value: TStrings);
    procedure SetNewContactsFolder(const Value: String);
  protected
    function GetName: String; override;
    function GetOutlookCategories: String;
    function ExtractQuotedStr(Str: String): String;
    procedure Read(Contact: TOutlookContact; OutlookContact: ContactItem);
    procedure Write(Contact: TContact; OutlookContact: ContactItem);
  public
    constructor Create;
    destructor Destroy; override;

    function New: TContact; override;
    function Add(Value: TContact): TContact; override;
    procedure Update(Contact, Value: TContact); override;
    procedure Delete(Contact: TContact); override;

    procedure Load; override;

    property Categories: TStrings read FCategories write SetCategories;
    property Folders: TStrings read FFolders write SetFolders;
    property NewContactsFolder: String read FNewContactsFolder write SetNewContactsFolder;
  end;

implementation

uses
  gnugettext, gnugettexthelpers, uLogger, uConnprogress, uThreadSafe,
  SysUtils, TntSysUtils, Forms, TntForms, ActiveX, Windows;

// Innerfuse Pascal Script III function
var
  DispPropertyPut: Integer = DISPID_PROPERTYPUT;

function IDispatchInvoke(Self: IDispatch; PropertySet: Boolean; const Name: String; const Par: array of Variant): Variant;
var
  Param: Word;
  i, ArgErr: Longint;
  DispatchId: Longint;
  DispParam: TDispParams;
  ExceptInfo: TExcepInfo;
  aName: PWideChar;
  WSFreeList: TList;
begin
  FillChar(ExceptInfo, SizeOf(ExceptInfo), 0);
  aName := StringToOleStr(Name);
  try
    if Self = nil then
      raise Exception.Create('NIL Interface Exception');
    if Self.GetIDsOfNames(GUID_NULL, @aName, 1, LOCALE_SYSTEM_DEFAULT, @DispatchId) <> S_OK then
      raise Exception.Create('Unknown Method');
  finally
    SysFreeString(aName);
  end;

  DispParam.cNamedArgs := 0;
  DispParam.rgdispidNamedArgs := nil;
  DispParam.cArgs := (High(Par) + 1);

  if PropertySet then
  begin
    Param := DISPATCH_PROPERTYPUT;
    DispParam.cNamedArgs := 1;
    DispParam.rgdispidNamedArgs := @DispPropertyPut;
  end else
    Param := DISPATCH_METHOD or DISPATCH_PROPERTYGET;

  WSFreeList := TList.Create;
  try
    GetMem(DispParam.rgvarg, sizeof(TVariantArg) * (High(Par) + 1));
    FillCHar(DispParam.rgvarg^, sizeof(TVariantArg) * (High(Par) + 1), 0);
    try
      for i := 0 to High(Par)  do
      begin
        if PVarData(@Par[i]).VType = varString then
        begin
          DispParam.rgvarg[i].vt := VT_BSTR;
          DispParam.rgvarg[i].bstrVal := StringToOleStr(Par[i]);
          WSFreeList.Add(DispParam.rgvarg[i].bstrVal);
        end else
        begin
          DispParam.rgvarg[i].vt := VT_VARIANT or VT_BYREF;
          New(POleVariant(DispParam.rgvarg[i].pvarVal));
          POleVariant(DispParam.rgvarg[i].pvarVal)^ := Par[i];
        end;
      end;
      i :=Self.Invoke(DispatchId, GUID_NULL, LOCALE_SYSTEM_DEFAULT, Param, DispParam, @Result, @ExceptInfo, @ArgErr);
      if not Succeeded(i) then
      begin
        if i = DISP_E_EXCEPTION then
          raise Exception.Create(ExceptInfo.bstrSource+': '+ExceptInfo.bstrDescription)
        else
          raise Exception.Create(SysErrorMessage(i));
      end;
    finally
      for i := 0 to High(Par)  do
      begin
        if DispParam.rgvarg[i].vt = (VT_VARIANT or VT_BYREF) then
        begin
          if POleVariant(DispParam.rgvarg[i].pvarVal) <> nil then
            Dispose(POleVariant(DispParam.rgvarg[i].pvarVal));
        end;
      end;
      FreeMem(DispParam.rgvarg, sizeof(TVariantArg) * (High(Par) + 1));
    end;
  finally
    for i := WSFreeList.Count -1 downto 0 do
      SysFreeString(WSFreeList[i]);
    WSFreeList.Free;
  end;
end;

{ TOutlookContactSource }

function TOutlookContactSource.GetOutlookCategories: String;
var I: Integer;
begin
  Result := '';
  for I := 0 to Categories.Count - 1 do
    if Trim(Categories[I]) <> '' then begin
      if Result <> '' then Result := Result + '; ';
      Result := Result + Categories[I];
    end;
end;

function TOutlookContactSource.Add(Value: TContact): TContact;
var
  Contact: TOutlookContact;
begin
  Contact := New as TOutlookContact;
  Contact.Clone(Value);
  Contact.LinkedContact := Value;
  Value.LinkedContact := Contact;
  Contacts.Add(Contact);

  if Assigned(FNewContactsFolderFolder) then
    Contact.OutlookContact := FNewContactsFolderFolder.Items.Add(olContactItem) as ContactItem
  else
    Contact.OutlookContact := Outlook.CreateItem(olContactItem) as ContactItem;
  Contact.OutlookContact.Categories := GetOutlookCategories;
  Write(Contact, Contact.OutlookContact);
  Contact.ID := Contact.OutlookContact.EntryID;

  Result := Contact;
end;

constructor TOutlookContactSource.Create;
begin
  inherited;
  FCategories := TStringList.Create;
  FCategories.Delimiter := ';';
  FFolders := TStringList.Create;

  FieldMapper := TOutlookContactFieldMapper.Create;

  Outlook := CoOutlookApplication.Create;
  NmSpace := Outlook.GetNamespace('MAPI'); // do not localize
//  NmSpace.Logon('', '', False, False);
end;

procedure TOutlookContactSource.Delete(Contact: TContact);
begin
  with Contact as TOutlookContact do begin
    OutlookContact.Delete;

    OutlookContact := nil;
  end;
end;

destructor TOutlookContactSource.Destroy;
begin
  FieldMapper.Free;
  FCategories.Free;
  FFolders.Free;
  
  inherited;
end;

function TOutlookContactSource.ExtractQuotedStr(Str: String): String;
var P: PChar;
begin
  P := PChar(Str);
  Result := AnsiExtractQuotedStr(P, '"');
  if Result = '' then Result := Str;
end;

function TOutlookContactSource.GetName: String;
begin
  Result := 'Outlook'; //TODO -cl10n: localize?
end;

function TOutlookContactSource.InCategories(OutlookContact: ContactItem): Boolean;
var Cats, Cat: String;
    P: Integer;
begin
  if Categories.Count > 0 then begin
    Result := False;
    Cats := OutlookContact.Categories;
    while Cats <> '' do begin
      P := Pos(';', Cats);
      if P = 0 then  // A propper Outlook Version check would be better
        P := Pos(',', Cats);  // Outlook 2003 uses , instead of ;
      if P = 0 then
        P := Length(Cats) + 1;

      Cat := Trim(Copy(Cats, 1, P - 1));
      System.Delete(Cats, 1, P);

      Result := Categories.IndexOf(Cat) <> - 1;
      if Result then Break;
    end;
  end
  else
    Result := True;
end;

procedure TOutlookContactSource.Load;
var j: Integer;
    Folder: MAPIFolder;
    dlg: TfrmConnect;
  procedure LoadFolder(Folder: MAPIFolder);
  var I: Integer;
      OutlookContact: ContactItem;
      Contact: TOutlookContact;
      Count, CountNew, CountFiltered: Integer;
  begin
    Count := 0;
    CountNew := 0;
    CountFiltered := 0;
    //Folder.Items.IncludeRecurrences := False;
    if Assigned(dlg) then dlg.Initialize(Folder.Items.Count,
      WideFormat(_('Loading external contact folders')+sLineBreak+'(%s %s)',[Name,Folder.Name]));   
    for I := 1 to Folder.Items.Count do begin
      if Assigned(dlg) then dlg.IncProgress(1);
      if Supports(Folder.Items.Item(I), ContactItem, OutlookContact) then begin
        if InCategories(OutlookContact) then begin
          Contact := Contacts.FindByID(OutlookContact.EntryID) as TOutlookContact;

          if Assigned(Contact) then begin
            Contact.OutlookContact := OutlookContact;
          end
          else begin
            Contact := New as TOutlookContact;
            Contact.ID := OutlookContact.EntryID;
            Contact.SyncHash := Contact.Hash;
            Contact.OutlookContact := OutlookContact;
            Contacts.Add(Contact);

            Inc(CountNew);
          end;
          Read(Contact, OutlookContact);

          Inc(Count);
        end
        else
          Inc(CountFiltered);
      end;
      { Allow process to be canceled }
      Application.ProcessMessages;
      if ThreadSafe.AbortDetected then Abort;
    end;
    Log.AddSynchronizationMessageFmt(_('Loaded %d contacts (%d new, %d filtered out) from %s folder %s'),
      [Count, CountNew, CountFiltered, Name, Folder.Name], lsDebug);
  end;
begin
  if FFolders.DelimitedText = 'DEFAULT' then begin // do not localize
    Folder := NmSpace.GetDefaultFolder(olFolderContacts);
    if Assigned(Folder) then
      FFolders.DelimitedText := Folder.EntryID;
  end;

  dlg := GetProgressDialog(False);
  try
    for j := 0 to FFolders.Count - 1 do begin
      Folder := NmSpace.GetFolderFromID(FFolders[j], '');
      if Assigned(Folder) then LoadFolder(Folder);
    end;
  finally
    if Assigned(dlg) then FreeProgressDialog;
  end;
end;

function TOutlookContactSource.New: TContact;
begin
  Result := TOutlookContact.Create(Self);
end;

procedure TOutlookContactSource.Read(Contact: TOutlookContact; OutlookContact: ContactItem);
begin
  (FieldMapper as TOutlookContactFieldMapper).OutlookContact := OutlookContact;

  with FieldMapper do begin
    Contact.Title := Title;
    Contact.Name := Name;
    Contact.SurName := SurName;
    Contact.Organization := Organization;
    Contact.Email := Email;
    Contact.HomePhone := DeformatPhoneNumber(HomePhone);
    Contact.WorkPhone := DeformatPhoneNumber(WorkPhone);
    Contact.CellPhone := DeformatPhoneNumber(CellPhone);
    Contact.FaxPhone := DeformatPhoneNumber(FaxPhone);
    Contact.OtherPhone := DeformatPhoneNumber(OtherPhone);
    Contact.Street := Street;
    Contact.City := City;
    Contact.Region := Region;
    Contact.PostalCode := PostalCode;
    Contact.Country := Country;
  end;
end;

procedure TOutlookContactSource.Write(Contact: TContact; OutlookContact: ContactItem);
begin
  (FieldMapper as TOutlookContactFieldMapper).OutlookContact := OutlookContact;

  with FieldMapper do begin
    Title := Contact.Title;
    Name := Contact.Name;
    SurName := Contact.SurName;
    Organization := Contact.Organization;
    Email := Contact.Email;
    HomePhone := Contact.HomePhone;
    WorkPhone := Contact.WorkPhone;
    CellPhone := Contact.CellPhone;
    FaxPhone := Contact.FaxPhone;
    OtherPhone := Contact.OtherPhone;
    Street := Contact.Street;
    City := Contact.City;
    Region := Contact.Region;
    PostalCode := Contact.PostalCode;
    Country := Contact.Country;

    OutlookContact.Save;
  end;
end;

procedure TOutlookContactSource.SetCategories(const Value: TStrings);
begin
  FCategories.Assign(Value);
end;

procedure TOutlookContactSource.Update(Contact, Value: TContact);
begin
  Write(Value, (Contact as TOutlookContact).OutlookContact);
end;

procedure TOutlookContactSource.SetFolders(const Value: TStrings);
begin
  FFolders.Assign(Value);
end;

procedure TOutlookContactSource.SetNewContactsFolder(const Value: String);
begin
  if FNewContactsFolder <> Value then begin
    FNewContactsFolder := Value;

    FNewContactsFolderFolder := NmSpace.GetFolderFromID(FNewContactsFolder, '');
  end;
end;

{ TOutlookContact }

function TOutlookContact.Exists: Boolean;
begin
  Result := Assigned(FOutlookContact);
end;                                             

{ TOutlookContactFieldMapper }

constructor TOutlookContactFieldMapper.Create;
begin
  inherited;

  Fields.Add('Account');
  Fields.Add('Anniversary');
  Fields.Add('AssistantName');
  Fields.Add('AssistantTelephoneNumber');
  Fields.Add('Birthday');
  Fields.Add('Business2TelephoneNumber');
  Fields.Add('BusinessAddress');
  Fields.Add('BusinessAddressCity');
  Fields.Add('BusinessAddressCountry');
  Fields.Add('BusinessAddressPostalCode');
  Fields.Add('BusinessAddressPostOfficeBox');
  Fields.Add('BusinessAddressState');
  Fields.Add('BusinessAddressStreet');
  Fields.Add('BusinessFaxNumber');
  Fields.Add('BusinessHomePage');
  Fields.Add('BusinessTelephoneNumber');
  Fields.Add('CallbackTelephoneNumber');
  Fields.Add('CarTelephoneNumber');
  Fields.Add('Children');
  Fields.Add('CompanyAndFullName');
  Fields.Add('CompanyMainTelephoneNumber');
  Fields.Add('CompanyName');
  Fields.Add('ComputerNetworkName');
  Fields.Add('CustomerID');
  Fields.Add('Department');
  Fields.Add('Email1Address');
  Fields.Add('Email1AddressType');
  Fields.Add('Email1DisplayName');
  Fields.Add('Email1EntryID');
  Fields.Add('Email2Address');
  Fields.Add('Email2AddressType');
  Fields.Add('Email2DisplayName');
  Fields.Add('Email2EntryID');
  Fields.Add('Email3Address');
  Fields.Add('Email3AddressType');
  Fields.Add('Email3DisplayName');
  Fields.Add('Email3EntryID');
  Fields.Add('FileAs');
  Fields.Add('FirstName');
  Fields.Add('FTPSite');
  Fields.Add('FullName');
  Fields.Add('FullNameAndCompany');
  Fields.Add('Gender');
  Fields.Add('GovernmentIDNumber');
  Fields.Add('Hobby');
  Fields.Add('Home2TelephoneNumber');
  Fields.Add('HomeAddress');
  Fields.Add('HomeAddressCity');
  Fields.Add('HomeAddressCountry');
  Fields.Add('HomeAddressPostalCode');
  Fields.Add('HomeAddressPostOfficeBox');
  Fields.Add('HomeAddressState');
  Fields.Add('HomeAddressStreet');
  Fields.Add('HomeFaxNumber');
  Fields.Add('HomeTelephoneNumber');
  Fields.Add('Initials');
  Fields.Add('ISDNNumber');
  Fields.Add('JobTitle');
  Fields.Add('Journal');
  Fields.Add('Language');
  Fields.Add('LastName');
  Fields.Add('LastNameAndFirstName');
  Fields.Add('MailingAddress');
  Fields.Add('MailingAddressCity');
  Fields.Add('MailingAddressCountry');
  Fields.Add('MailingAddressPostalCode');
  Fields.Add('MailingAddressPostOfficeBox');
  Fields.Add('MailingAddressState');
  Fields.Add('MailingAddressStreet');
  Fields.Add('ManagerName');
  Fields.Add('MiddleName');
  Fields.Add('MobileTelephoneNumber');
  Fields.Add('NickName');
  Fields.Add('OfficeLocation');
  Fields.Add('OrganizationalIDNumber');
  Fields.Add('OtherAddress');
  Fields.Add('OtherAddressCity');
  Fields.Add('OtherAddressCountry');
  Fields.Add('OtherAddressPostalCode');
  Fields.Add('OtherAddressPostOfficeBox');
  Fields.Add('OtherAddressState');
  Fields.Add('OtherAddressStreet');
  Fields.Add('OtherFaxNumber');
  Fields.Add('OtherTelephoneNumber');
  Fields.Add('PagerNumber');
  Fields.Add('PersonalHomePage');
  Fields.Add('PrimaryTelephoneNumber');
  Fields.Add('Profession');
  Fields.Add('RadioTelephoneNumber');
  Fields.Add('ReferredBy');
  Fields.Add('SelectedMailingAddress');
  Fields.Add('Spouse');
  Fields.Add('Suffix');
  Fields.Add('TelexNumber');
  Fields.Add('Title');
  Fields.Add('TTYTDDTelephoneNumber');
  Fields.Add('User1');
  Fields.Add('User2');
  Fields.Add('User3');
  Fields.Add('User4');
  Fields.Add('UserCertificate');
  Fields.Add('WebPage');
  Fields.Add('YomiCompanyName');
  Fields.Add('YomiFirstName');
  Fields.Add('YomiLastName');

  MappedFields.Add('Title=Title');
  MappedFields.Add('Name=FirstName');
  MappedFields.Add('SurName=LastName');
  MappedFields.Add('Organization=CompanyName');
  MappedFields.Add('EMail=Email1Address');
  MappedFields.Add('HomePhone=HomeTelephoneNumber');
  MappedFields.Add('WorkPhone=BusinessTelephoneNumber');
  MappedFields.Add('CellPhone=MobileTelephoneNumber');
  MappedFields.Add('FaxPhone=HomeFaxNumber');
  MappedFields.Add('OtherPhone=OtherTelephoneNumber');
  MappedFields.Add('Street=HomeAddressStreet');
  MappedFields.Add('City=HomeAddressCity');
  MappedFields.Add('Region=HomeAddressState');
  MappedFields.Add('PostalCode=HomeAddressPostalCode');
  MappedFields.Add('Country=HomeAddressCountry');
end;

function TOutlookContactFieldMapper.GetValue(Field: String): String;
begin
  Result := IDispatchInvoke(FOutlookContact, False, Field, []);
end;

procedure TOutlookContactFieldMapper.SetValue(Field: String; const Value: String);
begin
  IDispatchInvoke(FOutlookContact, True, Field, [Value]);
end;

end.
