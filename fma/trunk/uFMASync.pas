unit uFMASync;

{
*******************************************************************************
* Descriptions: FMA Contact Sync Unit
* $Source: /cvsroot/fma/fma/uFMASync.pas,v $
* $Locker:  $
*
* Todo:
*   - Deal with contacts marked as Deleted, but are not deleted yet.
*     This is a problem when conflicts arize (deleted and updated).
*
* Change Log:
* $Log: uFMASync.pas,v $
*
}

interface

uses
  uContactSync, uSyncPhonebook;

type
  TContactDataState = (cdsNew, cdsModified, cdsDeleted, cdsNormal);

  TFMAContact = class(TContact)
  private
    FFMAContact: PContactData;
    FOrgFMAContact: TContactData;
  protected
    function Exists: Boolean; override;
  public
    property FMAContact: PContactData read FFMAContact write FFMAContact;
    property OrgFMAContact: TContactData read FOrgFMAContact write FOrgFMAContact;

//    function IsDeleted: Boolean; override;
  end;

  TFMAContactFieldMapper = class(TContactFieldMapper)
  private
    FFMAContact: PContactData;
  protected
    function GetValue(Field: String): String;
    procedure SetValue(Field: String; const Value: String);
    function GetVariant(Field: String): Variant; override;
    procedure SetVariant(Field: String; const Value: Variant); override;
  public
    constructor Create;

    property FMAContact: PContactData read FFMAContact write FFMAContact;
    property StringValue[Field: String]: String read GetValue write SetValue;
  end;

  TFMAContactSource = class(TContactSource)
  protected
    function GetName: String; override;
    procedure Read(Contact: TFMAContact; FMAContact: PContactData);
    procedure Write(Contact: TContact; FMAContact: PContactData);
  public
    constructor Create;
    destructor Destroy; override;

    function New: TContact; override;
    function Add(Value: TContact): TContact; override;
    procedure Update(Contact, Value: TContact); override;
    procedure Delete(Contact: TContact); override;

    procedure Load; override;
  end;

implementation

uses
  gnugettext, gnugettexthelpers, uLogger, uConnProgress, 
  Unit1, VirtualTrees, Dialogs, TntDialogs, SysUtils, TntSysUtils, Forms, TntForms;

{ TFMAContactSource }

function TFMAContactSource.Add(Value: TContact): TContact;
var Contact: TFMAContact;
    ContactData: PContactData;
begin
  Contact := New as TFMAContact;
  Contact.Clone(Value);
  Contact.LinkedContact := Value;
  Value.LinkedContact := Contact;
  Contacts.Add(Contact);

  with Form1.frmSyncPhonebook do begin
    if ListContacts.ChildCount[nil] >= FMaxRecME then
      raise ESynchronize.CreateFmt(_('No more space in phonebook memory! %d is the maximum'), [FMaxRecME]);

    ContactData := ListContacts.GetNodeData(ListContacts.AddChild(nil));
    ContactData.CDID := NewGUID;
    ContactData.StateIndex := Integer(cdsNew);
  end;

  Contact.FMAContact := ContactData;
  Contact.OrgFMAContact := ContactData^;
  Write(Contact, ContactData);
  Contact.ID := GUIDToString(ContactData.CDID);

  Result := Contact;
end;

procedure TFMAContactSource.Delete(Contact: TContact);
begin
  with Contact as TFMAContact do begin
    FMAContact.StateIndex := Integer(cdsDeleted);
    FMAContact := nil;
  end;
end;

function TFMAContactSource.GetName: String;
begin
  Result := 'FMA'; //TODO -cl10n: localize?
end;

procedure TFMAContactSource.Load;
var FMAContact: PContactData;
    Contact: TFMAContact;
    Node: PVirtualNode;
    Count, CountNew, CountFiltered: Integer;
begin
  with Form1.frmSyncPhonebook.ListContacts do begin
    Count := 0;
    CountNew := 0;
    CountFiltered := 0;

    Node := GetFirst;
    while Assigned(Node) do begin
      FMAContact := GetNodeData(Node);

      if TContactDataState(FMAContact.StateIndex) <> cdsDeleted then begin
        Contact := Contacts.FindByID(GUIDToString(FMAContact.CDID)) as TFMAContact;

        if Assigned(Contact) then begin
          Contact.FMAContact := FMAContact;
          Contact.OrgFMAContact := FMAContact^;
        end
        else begin
          Contact := New as TFMAContact;
          Contact.ID := GUIDToString(FMAContact.CDID);
          Contact.SyncHash := Contact.Hash;
          Contact.FMAContact := FMAContact;
          Contact.OrgFMAContact := FMAContact^;
          Contacts.Add(Contact);

          Inc(CountNew);
        end;

        Read(Contact, FMAContact);

        Inc(Count);
      end
      else
        Inc(CountFiltered);
      Node := GetNext(Node);
      Application.ProcessMessages;
    end;
  end;

  Log.AddSynchronizationMessageFmt(_('Loaded %d contacts (%d new, %d filtered out) from %s'), [Count, CountNew, CountFiltered, Name], lsDebug);
end;

function TFMAContactSource.New: TContact;
begin
  Result := TFMAContact.Create(Self);
end;

procedure TFMAContactSource.Read(Contact: TFMAContact; FMAContact: PContactData);
begin
  (FieldMapper as TFMAContactFieldMapper).FMAContact := FMAContact;

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

    Contact.Birthday := Birthday;
  end;
end;

procedure TFMAContactSource.Write(Contact: TContact; FMAContact: PContactData);
begin
  (FieldMapper as TFMAContactFieldMapper).FMAContact := FMAContact;

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

    Birthday := Contact.Birthday;
  end;
end;

procedure TFMAContactSource.Update(Contact, Value: TContact);
begin
  (Contact as TFMAContact).FMAContact^.StateIndex := Integer(cdsModified);
  Write(Value, (Contact as TFMAContact).FMAContact);
  MigrateContact(@((Contact as TFMAContact).FOrgFMAContact), (Contact as TFMAContact).FFMAContact);
end;

constructor TFMAContactSource.Create;
begin
  inherited;

  FieldMapper := TFMAContactFieldMapper.Create;
end;

destructor TFMAContactSource.Destroy;
begin
  FieldMapper.Free;
  
  inherited;
end;

{ TFMAContact }

function TFMAContact.Exists: Boolean;
begin
  Result := Assigned(FFMAContact);
end;

{
// This has as result that LinkedContact = nil
function TFMAContact.IsDeleted: Boolean;
begin
  Result := inherited IsDeleted or (TContactDataState(FFMAContact.StateIndex) = cdsDeleted);
end;
}

{ TFMAContactFieldMapper }

constructor TFMAContactFieldMapper.Create;
begin
  inherited;

  { REFFERENCE !!!
    TBaseContact = class;
    TFMAContactFieldMapper.Create;
    TContactFieldMapper.LoadStandardFields;
    TOutlookContactSource.Read/Write();
  }

  Fields.Add('Title');
  Fields.Add('Name');
  Fields.Add('SurName');
  Fields.Add('DisplayName');
  Fields.Add('Org');
  Fields.Add('EMail');
  Fields.Add('URL');
  Fields.Add('Home');
  Fields.Add('Work');
  Fields.Add('Cell');
  Fields.Add('Fax');
  Fields.Add('Other');
  Fields.Add('Street');
  Fields.Add('City');
  Fields.Add('Region');
  Fields.Add('PostalCode');
  Fields.Add('Country');
  {
  Fields.Add('WorkStreet');
  Fields.Add('WorkCity');
  Fields.Add('WorkRegion');
  Fields.Add('WorkPostalCode');
  Fields.Add('WorkCountry');
  }
  Fields.Add('Birthday');

    MappedFields.Add('Title=Title');
  MappedFields.Add('Name=Name');
  MappedFields.Add('SurName=SurName');
  MappedFields.Add('Organization=Org');
  MappedFields.Add('EMail=EMail');
  MappedFields.Add('HomePhone=Home');
  MappedFields.Add('WorkPhone=Work');
  MappedFields.Add('CellPhone=Cell');
  MappedFields.Add('FaxPhone=Fax');
  MappedFields.Add('OtherPhone=Other');
  MappedFields.Add('Street=Street');
  MappedFields.Add('City=City');
  MappedFields.Add('Region=Region');
  MappedFields.Add('PostalCode=PostalCode');
  MappedFields.Add('Country=Country');
  
  MappedFields.Add('Birthday=Birthday');
end;

function TFMAContactFieldMapper.GetValue(Field: String): String;
begin
  if Field = 'Title' then
    Result := FFMAContact.Title
  else if Field = 'Name' then
    Result := FFMAContact.Name
  else if Field = 'SurName' then
    Result := FFMAContact.SurName
  else if Field = 'Org' then
    Result := FFMAContact.Org
  else if Field = 'EMail' then
    Result := FFMAContact.EMail
  else if Field = 'URL' then
    Result := FFMAContact.homepage
  else if Field = 'Home' then
    Result := FFMAContact.Home
  else if Field = 'Work' then
    Result := FFMAContact.Work
  else if Field = 'Cell' then
    Result := FFMAContact.Cell
  else if Field = 'Fax' then
    Result := FFMAContact.Fax
  else if Field = 'Other' then
    Result := FFMAContact.Other
  else if Field = 'Street' then
    Result := FFMAContact.homeAddress.Street
  else if Field = 'City' then
    Result := FFMAContact.homeAddress.City
  else if Field = 'Region' then
    Result := FFMAContact.homeAddress.Region
  else if Field = 'PostalCode' then
    Result := FFMAContact.homeAddress.PostalCode
  else if Field = 'Country' then
    Result := FFMAContact.homeAddress.Country
  else if Field = 'WorkStreet' then
    Result := FFMAContact.workAddress.Street
  else if Field = 'WorkCity' then
    Result := FFMAContact.workAddress.City
  else if Field = 'WorkRegion' then
    Result := FFMAContact.workAddress.Region
  else if Field = 'WorkPostalCode' then
    Result := FFMAContact.workAddress.PostalCode
  else if Field = 'WorkCountry' then
    Result := FFMAContact.workAddress.Country;
end;

function TFMAContactFieldMapper.GetVariant(Field: String): Variant;
begin
  if Field = 'Birthday' then
    Result := FFMAContact.Birthday
  else
    Result := StringValue[Field];
end;

procedure TFMAContactFieldMapper.SetValue(Field: String; const Value: String);
begin
  if Field = 'Title' then
    FFMAContact.Title := Value
  else if Field = 'Name' then
    FFMAContact.Name := Value
  else if Field = 'SurName' then
    FFMAContact.SurName := Value
  else if Field = 'Org' then
    FFMAContact.Org := Value
  else if Field = 'EMail' then
    FFMAContact.EMail := Value
  else if Field = 'URL' then
    FFMAContact.homepage := Value
  else if Field = 'Home' then
    FFMAContact.Home := Value
  else if Field = 'Work' then
    FFMAContact.Work := Value
  else if Field = 'Cell' then
    FFMAContact.Cell := Value
  else if Field = 'Fax' then
    FFMAContact.Fax := Value
  else if Field = 'Other' then
    FFMAContact.Other := Value
  else if Field = 'Street' then
    FFMAContact.homeAddress.Street := Value
  else if Field = 'City' then
    FFMAContact.homeAddress.City := Value
  else if Field = 'Region' then
    FFMAContact.homeAddress.Region := Value
  else if Field = 'PostalCode' then
    FFMAContact.homeAddress.PostalCode := Value
  else if Field = 'Country' then
    FFMAContact.homeAddress.Country := Value
  else if Field = 'WorkStreet' then
    FFMAContact.workAddress.Street := Value
  else if Field = 'WorkCity' then
    FFMAContact.workAddress.City := Value
  else if Field = 'WorkRegion' then
    FFMAContact.workAddress.Region := Value
  else if Field = 'WorkPostalCode' then
    FFMAContact.workAddress.PostalCode := Value
  else if Field = 'WorkCountry' then
    FFMAContact.workAddress.Country := Value;
end;

procedure TFMAContactFieldMapper.SetVariant(Field: String; const Value: Variant);
begin
  if Field = 'Birthday' then
    FFMAContact.Birthday := Value
  else
    StringValue[Field] := Value;
end;

end.
