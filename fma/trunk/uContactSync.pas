unit uContactSync;

{
*******************************************************************************
* Descriptions: Main Contact Sync Unit
* $Source: /cvsroot/fma/fma/uContactSync.pas,v $
* $Locker:  $
*
* Todo:
*   - Let the OOD reflect the xml
*   - Filters on the external contacts
*   - Hash sperate items of a contact so less conflicts arise
*   - Do it using interfaces. IIdentifiable INameble IConflictSolver ISynchronizable
*
* Change Log:
* $Log: uContactSync.pas,v $
*
}

interface

uses
  Contnrs, Classes, TntClasses, SysUtils, TntSysUtils;

resourcestring
  sContactSyncConfirm = '%s.'+sLinebreak+sLinebreak+'Please, confirm to continue.';

const
  MaxCardinal = High(Cardinal);

type
  ESynchronize = class(Exception);

  TContactState = (csUnknown, csUnchanged, csNew, csChanged, csDeleted);
  TContactSollution = (slLeft, slRight, slNeither);
  TContactAction = (caAdd, caUpdate, caDelete, caUnlink);
  TContactActions = set of TContactAction;

  TBaseContact = class(TObject)
  private
    FTitle: WideString;
    FCellPhone: WideString;
    FFaxPhone: WideString;
    FOtherPhone: WideString;
    FOrganization: WideString;
    FEMail: WideString;
    FName: WideString;
    FWorkPhone: WideString;
    FSurName: WideString;
    FHomePhone: WideString;
    FCity: WideString;
    FRegion: WideString;
    FCountry: WideString;
    FStreet: WideString;
    FPostalCode: WideString;
    FBirthday: WideString;
    function GetFullName: WideString;
  public
  { REFFERENCE !!!
    TBaseContact = class;
    TFMAContactFieldMapper.Create;
    TContactFieldMapper.LoadStandardFields;
    TOutlookContactSource.Read/Write();
  }
    property Title: WideString read FTitle write FTitle;
    property Name: WideString read FName write FName;
    property SurName: WideString read FSurName write FSurName;
    property Organization: WideString read FOrganization write FOrganization;
    property EMail: WideString read FEMail write FEMail;
    property HomePhone: WideString read FHomePhone write FHomePhone;
    property WorkPhone: WideString read FWorkPhone write FWorkPhone;
    property CellPhone: WideString read FCellPhone write FCellPhone;
    property FaxPhone: WideString read FFaxPhone write FFaxPhone;
    property OtherPhone: WideString read FOtherPhone write FOtherPhone;
    property Street: WideString read FStreet write FStreet;
    property City: WideString read FCity write FCity;
    property Region: WideString read FRegion write FRegion;
    property PostalCode: WideString read FPostalCode write FPostalCode;
    property Country: WideString read FCountry write FCountry;

    property Birthday: WideString read FBirthday write FBirthday;

    property FullName: WideString read GetFullName;
  end;

  TContactSource = class;

  TContact = class(TBaseContact)
  private
    FSyncID: Cardinal;
    FID: Variant;
    FSyncHash: Cardinal;
    FLinkedContact: TContact;
    FSynchronized: Boolean;
    FContactSource: TContactSource;
    function GetHash: Cardinal;
  protected
    function GetHashString: String; virtual;
    function Exists: Boolean; virtual; abstract;
  public
    constructor Create(ContactSource: TContactSource);

    property ContactSource: TContactSource read FContactSource write FContactSource;

    property Synchronized: Boolean read FSynchronized write FSynchronized;

    property SyncID: Cardinal read FSyncID write FSyncID;
    property ID: Variant read FID write FID;
    property SyncHash: Cardinal read FSyncHash write FSyncHash;
    property Hash: Cardinal read GetHash;
    property LinkedContact: TContact read FLinkedContact write FLinkedContact;

    function IsUnchanged: Boolean;
    function IsNew: Boolean; virtual;
    function IsChanged: Boolean; virtual;
    function IsDeleted: Boolean; virtual;
    function GetContactState: TContactState;

    procedure Clone(Value: TContact);
  end;

  TContacts = class
  private
    FList: TObjectList;
    function GetItem(Index: Integer): TContact;
    function GetCount: Integer;
    procedure PutItem(Index: Integer; const Value: TContact);
  public
    constructor Create;
    destructor Destroy; override;

    function Add(Item: TContact): Integer;
    procedure Clear;
    procedure Delete(Index: Integer);
    procedure Remove(Item: TContact);
    function IndexOf(Item: TContact): Integer;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TContact read GetItem write PutItem; default;
    function FindByID(ID: Variant): TContact;
    function FindBySyncID(SyncID: Cardinal): TContact;
  end;

  TContactFieldMapper = class
  private
    FMappedFields: TStrings;
    FFields: TStrings;
    FStandardFields: TStrings;

    function GetCellPhone: WideString;
    function GetEMail: WideString;
    function GetFaxPhone: WideString;
    function GetHomePhone: WideString;
    function GetName: WideString;
    function GetOrganization: WideString;
    function GetOtherPhone: WideString;
    function GetSurName: WideString;
    function GetTitle: WideString;
    function GetWorkPhone: WideString;
    procedure SetCellPhone(const Value: WideString);
    procedure SetEMail(const Value: WideString);
    procedure SetFaxPhone(const Value: WideString);
    procedure SetHomePhone(const Value: WideString);
    procedure SetName(const Value: WideString);
    procedure SetOrganization(const Value: WideString);
    procedure SetOtherPhone(const Value: WideString);
    procedure SetSurName(const Value: WideString);
    procedure SetTitle(const Value: WideString);
    procedure SetWorkPhone(const Value: WideString);
    function GetCity: WideString;
    function GetCountry: WideString;
    function GetPostalCode: WideString;
    function GetRegion: WideString;
    function GetStreet: WideString;
    procedure SetCity(const Value: WideString);
    procedure SetCountry(const Value: WideString);
    procedure SetPostalCode(const Value: WideString);
    procedure SetRegion(const Value: WideString);
    procedure SetStreet(const Value: WideString);

    function GetMappedField(Field: String): String;
    procedure SetMappedFields(const Value: TStrings);
    function GetMappedValue(Field: String): String;
    procedure SetMappedValue(Field: String; const AValue: String);
    procedure SetFields(const Value: TStrings);

    procedure LoadStandardFields;
    
    function GetBirthday: WideString;
    procedure SetBirthday(const Value: WideString);
  protected
    function GetValue(Field: String): String; virtual; abstract;
    procedure SetValue(Field: String; const Value: String); virtual; abstract;
  public
    constructor Create;
    destructor Destroy; override;

    property Title: WideString read GetTitle write SetTitle;
    property Name: WideString read GetName write SetName;
    property SurName: WideString read GetSurName write SetSurName;
    property Organization: WideString read GetOrganization write SetOrganization;
    property EMail: WideString read GetEMail write SetEMail;
    property HomePhone: WideString read GetHomePhone write SetHomePhone;
    property WorkPhone: WideString read GetWorkPhone write SetWorkPhone;
    property CellPhone: WideString read GetCellPhone write SetCellPhone;
    property FaxPhone: WideString read GetFaxPhone write SetFaxPhone;
    property OtherPhone: WideString read GetOtherPhone write SetOtherPhone;
    property Street: WideString read GetStreet write SetStreet;
    property City: WideString read GetCity write SetCity;
    property Region: WideString read GetRegion write SetRegion;
    property PostalCode: WideString read GetPostalCode write SetPostalCode;
    property Country: WideString read GetCountry write SetCountry;

    property Birthday: WideString read GetBirthday write SetBirthday;

    property Fields: TStrings read FFields write SetFields;
    property MappedField[Field: String]: String read GetMappedField;
    property MappedFields: TStrings read FMappedFields write SetMappedFields;
    property Value[Field: String]: String read GetValue write SetValue;
    property MappedValue[Field: String]: String read GetMappedValue write SetMappedValue;
    property StandardFields: TStrings read FStandardFields;
  end;

  TContactSource = class
  private
    FContacts: TContacts;
    FConfirmActions: TContactActions;
    FFieldMapper: TContactFieldMapper;
  protected
    function GetName: String; virtual; abstract;
    function DeformatPhoneNumber(PhoneNumber: String): String; virtual;
  public
    constructor Create;
    destructor Destroy; override;

    property FieldMapper: TContactFieldMapper read FFieldMapper write FFieldMapper;

    property Name: String read GetName;

    property Contacts: TContacts read FContacts;

    function New: TContact; virtual; abstract;
    function Add(Value: TContact): TContact; virtual; abstract;
    procedure Update(Contact, Value: TContact); virtual; abstract;
    procedure Delete(Contact: TContact); virtual; abstract;
    function Find(SyncID: Cardinal): TContact;
    procedure Unlink(Contact: TContact); virtual;

    procedure Load; virtual; abstract;

    property ConfirmActions: TContactActions read FConfirmActions write FConfirmActions;
  end;

  TPossibleLink = class
  private
    FScore: Integer;
    FContact: TContact;
  public
    property Contact: TContact read FContact write FContact;
    property Score: Integer read FScore write FScore;
  end;

  TPossibleLinks = class
  private
    FList: TObjectList;
    function GetItem(Index: Integer): TPossibleLink;
    function GetCount: Integer;
    procedure PutItem(Index: Integer; const Value: TPossibleLink);
  public
    constructor Create;
    destructor Destroy; override;

    function Add(Contact: TContact; Score: Integer): Integer;
    procedure Clear;
    procedure Delete(Index: Integer);
    procedure Remove(Item: TPossibleLink);
    function IndexOf(Item: TPossibleLink): Integer;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TPossibleLink read GetItem write PutItem; default;
    procedure Sort;
  end;

  TSyncContactsConflictEvent = procedure(Sender: TObject; Contact,OtherContact: TContact;
    const Description: WideString; const Item0Name, Item1Name: WideString; var SelectedItem: Integer) of object;
  TSyncContactsFirstTimeEvent = procedure(Sender: TObject; var Continue: Boolean) of object;
  TSyncContactsErrorEvent = procedure(Sender: TObject; const Message: String) of object;
  TSyncContactsConfirmEvent = procedure(Sender: TObject; Contact: TContact; Action: TContactAction;
    const Description: WideString; var Confirmed: Boolean) of object;
  TSyncContactsChooseContactEvent = procedure(Sender: TObject; Contact: TContact; PossibleLinks: TPossibleLinks;
    var OtherContact: TContact) of object;

  TSynchronizeContacts = class
  private
    FFMA: TContactSource;
    FExtern: TContactSource;
    FFileName: String;
    FOnConflict: TSyncContactsConflictEvent;
    FSWitched: Boolean;
    FOnFirstTime: TSyncContactsFirstTimeEvent;
    FOnError: TSyncContactsErrorEvent;
    FOnConfirm: TSyncContactsConfirmEvent;
    FOnChooseLink: TSyncContactsChooseContactEvent;
    procedure DoSynchronize(Left, Right: TContactSource);
    function CalculateLinkScore(Contact, OtherContact: TContact): Integer;
    function FindLink(Contact: TContact; OtherSource: TContactSource): TContact;
    function Conflict(Left, Right: TContact): TContactSollution;
    function Confirm(Action: TContactAction; Source: TContactSource; Contact: TContact): Boolean;
    function BuildCompareDescription(Contact, OtherContact: TContact): WideString;
    function BuildActionDescription(Action: TContactAction; Source: TContactSource; Contact: TContact): WideString;
    function Add(Source: TContactSource; Value: TContact): TContact;
    procedure Update(Source: TContactSource; Contact, Value: TContact);
    procedure Delete(Source: TContactSource; Contact, OtherContact: TContact);
    procedure Link(Contact, OtherContact: TContact);
  protected
    procedure DoConflict(Contact,OtherContact: TContact;
      const Description: WideString; const Item0Name, Item1Name: String;
      var SelectedItem: Integer); virtual;
    function DoFirstTime: Boolean; virtual;
    procedure DoError(const Message: String); virtual;
    procedure DoConfirm(Contact: TContact; Action: TContactAction;
      const Description: WideString; var Confirmed: Boolean); virtual;
    procedure DoChooseLink(Contact: TContact; PossibleLinks: TPossibleLinks; var OtherContact: TContact); virtual;
  public
    property FileName: String read FFileName write FFileName;
    property FMA: TContactSource read FFMA write FFMA;
    property Extern: TContactSource read FExtern write FExtern;
    property OnConflict: TSyncContactsConflictEvent read FOnConflict write FOnConflict;
    property OnFirstTime: TSyncContactsFirstTimeEvent read FOnFirstTime write FOnFirstTime;
    property OnError: TSyncContactsErrorEvent read FOnError write FOnError;
    property OnConfirm: TSyncContactsConfirmEvent read FOnConfirm write FOnConfirm;
    property OnChooseLink: TSyncContactsChooseContactEvent read FOnChooseLink write FOnChooseLink;

    procedure Load;
    procedure Synchronize;
    procedure Save;

    procedure Unlink(CDID: TGUID);
  end;

implementation

uses
  gnugettext, gnugettexthelpers, uLogger, uConnProgress, uThreadSafe,
  Forms, TntForms, Variants, uXMLContactSync, CRC32, uSyncPhonebook, Unit1;

{ TSynchronizeContacts }

procedure TSynchronizeContacts.DoSynchronize(Left, Right: TContactSource);
var I: Integer;
    LeftContact, RightContact: TContact;
    LeftState, RightState: TContactState;
    Sollution: TContactSollution;
begin
  for I := 0 to Left.Contacts.Count - 1 do begin
    LeftContact := Left.Contacts[I];
    if not LeftContact.Synchronized then begin
      LeftState := LeftContact.GetContactState;

      RightContact := LeftContact.LinkedContact;

      if LeftState = csNew then begin
        RightContact := FindLink(LeftContact, Right);
        if Assigned(RightContact) then
          Link(LeftContact, RightContact)
        else
          Add(Right, LeftContact);
      end
      else begin
        if not Assigned(RightContact) then
          raise ESynchronize.Create(_('Linked contact not found'));

        RightState := RightContact.GetContactState;

        if LeftState = csChanged then begin
          if RightState = csUnchanged then begin
            Update(Right, RightContact, LeftContact);
          end
          else if RightState = csChanged then begin
            Sollution := Conflict(LeftContact, RightContact);
            if Sollution = slLeft then begin
              Update(Right, RightContact, LeftContact);
            end
            else if Sollution = slRight then begin
              Update(Left, LeftContact, RightContact);
            end;
          end
          else if RightState = csDeleted then begin
            Sollution := Conflict(LeftContact, RightContact);
            if Sollution = slLeft then begin
              Add(Right, LeftContact);
            end
            else if Sollution = slRight then begin
              Delete(Left, LeftContact, RightContact);
            end;
          end;
        end
        else if LeftState = csDeleted then begin
          if RightState = csUnchanged then begin
            Delete(Right, RightContact, LeftContact);
          end
          else if RightState = csChanged then begin
            Sollution := Conflict(LeftContact, RightContact);
            if Sollution = slLeft then begin
              Delete(Right, RightContact, LeftContact);
            end
            else if Sollution = slRight then begin
              Add(Left, RightContact);
            end;
          end;
        end;
      end;
    end;
    { Allow synchronization to be canceled }
    Application.ProcessMessages;
    if ThreadSafe.AbortDetected then Abort;
  end;
end;

procedure TSynchronizeContacts.Synchronize;
begin
  Log.AddSynchronizationMessage(_('Synchronize started'));
  try
    FSwitched := False;
    DoSynchronize(FMA, Extern);
    FSwitched := True;
    DoSynchronize(Extern, FMA);

    Log.AddSynchronizationMessage(_('Synchronize completed'));
  except
    on E: ESynchronize do begin
      Log.AddSynchronizationMessageFmt(_('Synchronize error: %s'), [E.Message], lsError);
      DoError(E.Message);
    end;
  end;
end;

function TSynchronizeContacts.Conflict(Left, Right: TContact): TContactSollution;
var Contact, OtherContact: TContact;
    SelectedItem: Integer;
    Description: WideString;
begin
  if FSwitched then begin
    Contact := Right;
    OtherContact := Left;
  end
  else begin
    Contact := Left;
    OtherContact := Right;
  end;
  SelectedItem := 0;
  Description := BuildCompareDescription(Contact, OtherContact);
  Log.AddSynchronizationMessageFmt(_('%s has a conflict: %s'), [Contact.FullName, Description], lsDebug);
  DoConflict(Contact, OtherContact, Description, Contact.ContactSource.Name, Contact.LinkedContact.ContactSource.Name, SelectedItem);
  case SelectedItem of
    0: begin
      if Contact = Left then
        Result := slLeft
      else
        Result := slRight;
      Log.AddSynchronizationMessageFmt(_('Conflict has been solved in favor of %s'), [Contact.ContactSource.Name], lsDebug);
    end;
    1: begin
      if Contact = Left then
        Result := slRight
      else
        Result := slLeft;
      Log.AddSynchronizationMessageFmt(_('Conflict has been solved in favor of %s'), [Contact.LinkedContact.ContactSource.Name], lsDebug);
    end;
    else begin
      Result := slNeither;
      Log.AddSynchronizationMessage(_('Conflict has not been solved'), lsDebug);
    end;
  end;
end;

procedure TSynchronizeContacts.Load;
var XMLContactSync: IXMLFmaSyncType;
    XMLContact: IXMLContactType;
    I: Integer;
    FMAContact: TContact;
    ExternContact: TContact;
begin
  Log.AddSynchronizationMessage(_('Loading started'), lsDebug);
  try
    if FileExists(FFileName) then begin
      XMLContactSync := Loadfmasync(FFileName);
      for I := 0 to XMLContactSync.Count - 1 do begin
        XMLContact := XMLContactSync.Contact[I];

        FMAContact := FMA.New;
        FMAContact.SyncID := XMLContact.SyncID;
        FMAContact.ID := XMLContact.FMA.ID;
        FMAContact.SyncHash := StrToInt(XMLContact.FMA.Hash);
        FMA.Contacts.Add(FMAContact);

        ExternContact := Extern.New;
        ExternContact.SyncID := XMLContact.SyncID;
        ExternContact.ID := XMLContact.Extern.ID;
        ExternContact.SyncHash := StrToInt(XMLContact.Extern.Hash);
        Extern.Contacts.Add(ExternContact);

        FMAContact.LinkedContact := ExternContact;
        ExternContact.LinkedContact := FMAContact;

        Application.ProcessMessages;
      end;
      Log.AddSynchronizationMessageFmt(_('Loaded %d contacts from XML'), [XMLContactSync.Count], lsDebug);
    end
    else
      if not DoFirstTime then Abort;

    FMA.Load;
    Extern.Load;

    Log.AddSynchronizationMessage(_('Loading completed'), lsDebug);
  except
    on E: ESynchronize do begin
      Log.AddSynchronizationMessageFmt(_('Loading error: %s'), [E.Message], lsError);
      DoError(E.Message);
    end;
  end;
end;

procedure TSynchronizeContacts.Save;
var XMLContactSync: IXMLFmaSyncType;
    XMLContact: IXMLContactType;
    I: Integer;
    FMAContact: TContact;
    ExternContact: TContact;
    ID: Integer;
begin
  Log.AddSynchronizationMessage(_('Saving started'), lsDebug);
  try
    XMLContactSync := Newfmasync;

    ID := 0;

    for I := 0 to FMA.Contacts.Count - 1 do begin
      FMAContact := FMA.Contacts[I];
      ExternContact := FMAContact.LinkedContact;

      if Assigned(ExternContact) and (not FMAContact.IsDeleted) and (not ExternContact.IsDeleted) then begin
        XMLContact := XMLContactSync.Add;
        XMLContact.SyncID := ID;

        XMLContact.FMA.ID := FMAContact.ID;
        XMLContact.FMA.Hash := '$' + IntToHex(FMAContact.Hash, 8);

        XMLContact.Extern.ID := ExternContact.ID;
        XMLContact.Extern.Hash := '$' + IntToHex(ExternContact.Hash, 8);

        Inc(ID);
      end;

      Application.ProcessMessages;
    end;

    XMLContactSync.OwnerDocument.SaveToFile(FFileName);

    Log.AddSynchronizationMessage(_('Saving completed'), lsDebug);
  except
    on E: ESynchronize do begin
      Log.AddSynchronizationMessageFmt(_('Saving error: %s'), [E.Message], lsError);
      DoError(E.Message);
    end;
  end;
end;

procedure TSynchronizeContacts.DoConflict(Contact,OtherContact: TContact; const Description:
    WideString; const Item0Name, Item1Name: String; var SelectedItem: Integer);
begin
  SelectedItem := 0;

  if Assigned(FOnConflict) then
    FOnConflict(Self, Contact, OtherContact, Description, Item0Name, Item1Name, SelectedItem);

  if SelectedItem = -1 then
    SelectedItem := 0;
end;

function TSynchronizeContacts.DoFirstTime: Boolean;
begin
  Result := True;
  
  if Assigned(FOnFirstTime) then
    FOnFirstTime(Self, Result);
end;

procedure TSynchronizeContacts.DoError(const Message: String);
begin
  if Assigned(FOnError) then
    FOnError(Self, Message);
end;

function TSynchronizeContacts.BuildCompareDescription(Contact, OtherContact: TContact): WideString;
{
var
  FullName: WideString;
begin
  if Contact.FullName <> '' then
    FullName := Contact.FullName
  else
    FullName := OtherContact.FullName;
}
begin
  case Contact.GetContactState of
    csUnchanged:
      Result := WideFormat(_('is unchanged in %s'), [Contact.ContactSource.Name]);
    csNew:
      Result := WideFormat(_('is new in %s'), [Contact.ContactSource.Name]);
    csChanged:
      Result := WideFormat(_('is changed in %s'), [Contact.ContactSource.Name]);
    csDeleted:
      Result := WideFormat(_('is deleted from %s'), [Contact.ContactSource.Name]);
    else
      Result := '';
  end;

  case OtherContact.GetContactState of
    csUnchanged:
      Result := Result + WideFormat(_(' and unchanged in %s'), [OtherContact.ContactSource.Name]);
    csNew:
      Result := Result + WideFormat(_(' and new in %s'), [OtherContact.ContactSource.Name]);
    csChanged:
      Result := Result + WideFormat(_(' and changed in %s'), [OtherContact.ContactSource.Name]);
    csDeleted:
      Result := Result + WideFormat(_(' and deleted from %s'), [OtherContact.ContactSource.Name]);
  end;
end;

function TSynchronizeContacts.BuildActionDescription(Action: TContactAction;
    Source: TContactSource; Contact: TContact): WideString;
begin
  case Action of
    caAdd:
      Result := WideFormat(_('%s will be added to %s'), [Contact.FullName, Source.Name]);
    caUpdate:
      Result := WideFormat(_('%s will be updated into %s'), [Contact.FullName, Source.Name]);
    caDelete:
      Result := WideFormat(_('%s will be deleted from %s'), [Contact.FullName, Source.Name]);
    else
      Result := '';
  end;
end;

function TSynchronizeContacts.Confirm(Action: TContactAction; Source: TContactSource; Contact: TContact): Boolean;
var Description: WideString;
begin
  Log.AddSynchronizationMessageFmt(_('Confirmation is asked for %s'), [Contact.FullName], lsDebug);

  Description := BuildActionDescription(Action, Source, Contact);

  DoConfirm(Contact, Action, Description, Result);

  if Result then
    Log.AddSynchronizationMessage(_('Confirmation is granted'), lsDebug)
  else
    Log.AddSynchronizationMessage(_('Confirmation is not granted'), lsDebug);
end;

procedure TSynchronizeContacts.DoConfirm(Contact: TContact; Action: 
    TContactAction; const Description: WideString; var Confirmed: Boolean);
begin
  Confirmed := True;
  if Assigned(FOnConfirm) then
    FOnConfirm(Self, Contact, Action, Description, Confirmed);
end;

function TSynchronizeContacts.Add(Source: TContactSource; Value: TContact): TContact;
begin
  Result := nil;

  if caAdd in Source.ConfirmActions then
    if not Confirm(caAdd, Source, Value) then Exit;

  Result := Source.Add(Value);

  Result.Synchronized := True;
  Value.Synchronized := True;
  Log.AddSynchronizationMessageFmt(_('%s is added to %s'), [Result.FullName, Source.Name], lsInformation);
end;

procedure TSynchronizeContacts.Update(Source: TContactSource; Contact, Value: TContact);
begin
  if caUpdate in Source.ConfirmActions then
    if not Confirm(caUpdate, Source, Value) then Exit;

  Source.Update(Contact, Value);

  Contact.Synchronized := True;
  Value.Synchronized := True;
  Log.AddSynchronizationMessageFmt(_('%s is updated into %s'), [Contact.FullName, Source.Name], lsInformation);
end;

procedure TSynchronizeContacts.Delete(Source: TContactSource; Contact, OtherContact: TContact);
begin
  if caDelete in Source.ConfirmActions then
    if not Confirm(caDelete, Source, Contact) then Exit;

  Source.Delete(Contact);

  Contact.Synchronized := True;
  OtherContact.Synchronized := True;
  Log.AddSynchronizationMessageFmt(_('%s is deleted from %s'), [Contact.FullName, Source.Name], lsInformation);
end;

procedure TSynchronizeContacts.Link(Contact, OtherContact: TContact);
begin
  Contact.LinkedContact := OtherContact;
  OtherContact.LinkedContact := Contact;

  Log.AddSynchronizationMessageFmt(_('%0:s in %1:s is linked to %2:s in %3:s'),
    [Contact.FullName, Contact.ContactSource.Name, OtherContact.FullName, OtherContact.ContactSource.Name], lsInformation);
end;

function TSynchronizeContacts.FindLink(Contact: TContact; OtherSource: TContactSource): TContact;
var I: Integer;
    OtherContact: TContact;
    OtherState: TContactState;
    PossibleLinks: TPossibleLinks;
    Score: Integer;
begin
  PossibleLinks := TPossibleLinks.Create;
  try
    for I := 0 to OtherSource.Contacts.Count - 1 do begin
      OtherContact := OtherSource.Contacts[I];
      if Assigned(OtherContact) then begin
        OtherState := OtherContact.GetContactState;

        if OtherState = csNew then begin
          Score := CalculateLinkScore(Contact, OtherContact);
          PossibleLinks.Add(OtherContact, Score)
        end;
      end;
    end;
    PossibleLinks.Sort;

    OtherContact := nil;
    if PossibleLinks.Count > 0 then
      DoChooseLink(Contact, PossibleLinks, OtherContact);
    Result := OtherContact;
  finally
    PossibleLinks.Free;
  end;
end;

function TSynchronizeContacts.CalculateLinkScore(Contact, OtherContact: TContact): Integer;
begin
  Result := 0;
  
  if Contact.Title = OtherContact.Title then
    Inc(Result, 1);
  if Contact.Name = OtherContact.Name then
    Inc(Result, 10);
  if Contact.SurName = OtherContact.SurName then
    Inc(Result, 100);
  if Contact.Organization = OtherContact.Organization then
    Inc(Result, 1);
  if Contact.Email = OtherContact.Email then
    Inc(Result, 100);
  if Contact.HomePhone = OtherContact.HomePhone then
    Inc(Result, 100);
  if Contact.WorkPhone = OtherContact.WorkPhone then
    Inc(Result, 10);
  if Contact.CellPhone = OtherContact.CellPhone then
    Inc(Result, 100);
  if Contact.FaxPhone = OtherContact.FaxPhone then
    Inc(Result, 10);
  if Contact.OtherPhone = OtherContact.OtherPhone then
    Inc(Result, 10);
  if Contact.Street = OtherContact.Street then
    Inc(Result, 10);
  if Contact.City = OtherContact.City then
    Inc(Result, 10);
  if Contact.Region = OtherContact.Region then
    Inc(Result, 1);
  if Contact.PostalCode = OtherContact.PostalCode then
    Inc(Result, 10);
  if Contact.Country = OtherContact.Country then
    Inc(Result, 1);

  if Contact.Birthday = OtherContact.Birthday then
    Inc(Result, 100);

  if Contact.Name = OtherContact.SurName then
    Inc(Result, 100);
  if Contact.SurName = OtherContact.Name then
    Inc(Result, 100);
end;

procedure TSynchronizeContacts.DoChooseLink(Contact: TContact; PossibleLinks: TPossibleLinks; var OtherContact: TContact);
begin
  if Assigned(FOnChooseLink) then
    FOnChooseLink(Self, Contact, PossibleLinks, OtherContact);
end;

procedure TSynchronizeContacts.Unlink(CDID: TGUID);
var XMLContactSync: IXMLFmaSyncType;
    XMLContact: IXMLContactType;
    I: Integer;
    Confirmed: Boolean;
begin
  Log.AddSynchronizationMessage(_('Unlinking started'), lsDebug);
  try
    if FileExists(FFileName) then begin
      XMLContactSync := Loadfmasync(FFileName);
      for I := 0 to XMLContactSync.Count - 1 do begin
        XMLContact := XMLContactSync.Contact[I];

        if IsEqualGUID(StringToGUID(XMLContact.FMA.ID), CDID) then begin
          Confirmed := False;
          DoConfirm(nil, caUnlink, _('Link found. About to unlinking'), Confirmed);

          if Confirmed then begin
            Log.AddSynchronizationMessageFmt(_('Link %s found and Unlinked'), [GUIDToString(CDID)], lsDebug);
            XMLContactSync.Delete(I);
          end;

          Break;
        end;

        Application.ProcessMessages;
      end;

      XMLContactSync.OwnerDocument.SaveToFile(FFileName);
    end;

    Log.AddSynchronizationMessage(_('Unlinking completed'), lsDebug);
  except
    on E: ESynchronize do begin
      Log.AddSynchronizationMessageFmt(_('Unlinking error: %s'), [E.Message], lsError);
      DoError(E.Message);
    end;
  end;
end;

{ TContact }

procedure TContact.Clone(Value: TContact);
begin
  inherited;

  Title := Value.Title;
  Name := Value.Name;
  SurName := Value.SurName;
  Organization := Value.Organization;
  Email := Value.Email;
  HomePhone := Value.HomePhone;
  WorkPhone := Value.WorkPhone;
  CellPhone := Value.CellPhone;
  FaxPhone := Value.FaxPhone;
  OtherPhone := Value.OtherPhone;
  Street := Value.Street;
  City := Value.City;
  Region := Value.Region;
  PostalCode := Value.PostalCode;
  Country := Value.Country;

  Birthday := Value.Birthday;

  SyncID := Value.SyncID;
  ID := Unassigned;
  SyncHash := Hash;
end;

constructor TContact.Create(ContactSource: TContactSource);
begin
  inherited Create;

  FContactSource := ContactSource;

  FSyncID := MaxCardinal;
end;

function TContact.GetContactState: TContactState;
begin
  if IsDeleted then
    Result := csDeleted
  else if IsNew then
    Result := csNew
  else if IsChanged then
    Result := csChanged
  else
    Result := csUnchanged;
end;

function TContact.GetHash: Cardinal;
var Str: String;
begin
  Str := GetHashString;
  Result := CalculateCRC32(Str[1], Length(Str));
end;

function TContact.GetHashString: String;
begin
  Result := FTitle + '|' + FCellPhone + '|' + FFaxPhone + '|' + FOtherPhone + '|' +
            FOrganization + '|' + FEmail + '|' + FName + '|' + FWorkPhone + '|' +
            FSurName + '|' +FHomePhone + '|' + FStreet + '|' + FCity + '|' +
            FRegion + '|' + FPostalCode + '|' + FCountry + '|' + FBirthday;
end;

function TContact.IsChanged: Boolean;
begin
  Result := FSyncHash <> Hash;
end;

function TContact.IsDeleted: Boolean;
begin
  Result := not Exists;
end;

function TContact.IsNew: Boolean;
begin
  Result := VarIsEmpty(FID) or not Assigned(FLinkedContact);
end;

function TContact.IsUnchanged: Boolean;
begin
  Result := not (IsNew or IsChanged or IsDeleted);
end;

{ TContactSource }

constructor TContactSource.Create;
begin
  inherited;

  FContacts := TContacts.Create;
  FConfirmActions := [caAdd, caUpdate, caDelete]; 
end;

function TContactSource.DeformatPhoneNumber(PhoneNumber: String): String;
const ValidChars = ['*', '#', '+', '0'..'9', 'p']; // do not localize
var I: Integer;
begin
  Result := '';
  for I := 1 to Length(PhoneNumber) do
    if PhoneNumber[I] in ValidChars then
      Result := Result + PhoneNumber[I];
end;

destructor TContactSource.Destroy;
begin
  FContacts.Free;

  inherited;
end;

function TContactSource.Find(SyncID: Cardinal): TContact;
begin
  Result := FContacts.FindBySyncID(SyncID);
end;

procedure TContactSource.Unlink(Contact: TContact);
begin
  if Assigned(Contact.LinkedContact) then begin
    Contact.LinkedContact.LinkedContact := nil;
    Contact.LinkedContact := nil;
  end;
end;

{ TContacts }

function TContacts.Add(Item: TContact): Integer;
begin
  Result := FList.Add(Item);
end;

procedure TContacts.Clear;
begin
  FList.Clear;
end;

constructor TContacts.Create;
begin
  inherited;

  FList := TObjectList.Create;
end;

procedure TContacts.Delete(Index: Integer);
begin
  FList.Delete(Index);
end;

destructor TContacts.Destroy;
begin
  FList.Free;

  inherited;
end;

function TContacts.GetItem(Index: Integer): TContact;
begin
  Result := FList[Index] as TContact;
end;

function TContacts.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TContacts.IndexOf(Item: TContact): Integer;
begin
  Result := FList.IndexOf(Item);
end;

procedure TContacts.PutItem(Index: Integer; const Value: TContact);
begin
  FList[Index] := Value;
end;

procedure TContacts.Remove(Item: TContact);
begin
  FList.Remove(Item);
end;

function TContacts.FindByID(ID: Variant): TContact;
var I: Integer;
begin
  Result := nil;

  for I := 0 to Count - 1 do
    if Items[I].ID = ID then begin
      Result := Items[I];
      Break;
    end;
end;

function TContacts.FindBySyncID(SyncID: Cardinal): TContact;
var I: Integer;
begin
  Result := nil;

  for I := 0 to Count - 1 do
    if Items[I].SyncID = SyncID then begin
      Result := Items[I];
      Break;
    end;
end;

{ TBaseContact }

function TBaseContact.GetFullName: WideString;
begin
  Result := FName;
  if FSurName <> '' then
    if Result <> '' then
      Result := Result + ' ' + FSurName
    else
      Result := FSurName;
end;

{ TPossibleLinks }

constructor TPossibleLinks.Create;
begin
  inherited;

  FList := TObjectList.Create;
end;

destructor TPossibleLinks.Destroy;
begin
  FList.Free;

  inherited;
end;

function TPossibleLinks.Add(Contact: TContact; Score: Integer): Integer;
var PossibleLink: TPossibleLink;
begin
  PossibleLink := TPossibleLink.Create;
  PossibleLink.Contact := Contact;
  PossibleLink.Score := Score;


  Result := FList.Add(PossibleLink);
end;

procedure TPossibleLinks.Clear;
begin
  FList.Clear;
end;

procedure TPossibleLinks.Delete(Index: Integer);
begin
  FList.Delete(Index);
end;

function TPossibleLinks.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TPossibleLinks.GetItem(Index: Integer): TPossibleLink;
begin
  Result := FList[Index] as TPossibleLink;
end;

function TPossibleLinks.IndexOf(Item: TPossibleLink): Integer;
begin
  Result := FList.IndexOf(Item);
end;

procedure TPossibleLinks.PutItem(Index: Integer; const Value: TPossibleLink);
begin
  FList[Index] := Value;
end;

procedure TPossibleLinks.Remove(Item: TPossibleLink);
begin
  FList.Remove(Item);
end;

function PossibleLinksSortCompare(Item1, Item2: Pointer): Integer;
var Score1, Score2: Integer;
begin
  Score1 := TPossibleLink(Item1).Score;
  Score2 := TPossibleLink(Item2).Score;

  if Score1= Score2 then
    Result := 0
  else if Score1 < Score2 then
    Result := 1
  else
    Result := -1;
end;

procedure TPossibleLinks.Sort;
begin
  FList.Sort(PossibleLinksSortCompare);
end;

{ TContactFieldMapper }

constructor TContactFieldMapper.Create;
begin
  inherited;

  FMappedFields := TStringList.Create;
  FFields := TStringList.Create;
  FStandardFields := TStringList.Create;

  LoadStandardFields;
end;

destructor TContactFieldMapper.Destroy;
begin
  FMappedFields.Free;
  FFields.Free;
  FStandardFields.Free;

  inherited;
end;

function TContactFieldMapper.GetBirthday: WideString;
begin
  Result := MappedValue['Birthday'];
end;

function TContactFieldMapper.GetCellPhone: WideString;
begin
  Result := MappedValue['CellPhone'];
end;

function TContactFieldMapper.GetCity: WideString;
begin
  Result := MappedValue['City'];
end;

function TContactFieldMapper.GetCountry: WideString;
begin
  Result := MappedValue['Country'];
end;

function TContactFieldMapper.GetEMail: WideString;
begin
  Result := MappedValue['EMail'];
end;

function TContactFieldMapper.GetFaxPhone: WideString;
begin
  Result := MappedValue['FaxPhone'];
end;

function TContactFieldMapper.GetHomePhone: WideString;
begin
  Result := MappedValue['HomePhone'];
end;

function TContactFieldMapper.GetMappedField(Field: String): String;
begin
  Result := FMappedFields.Values[Field];
end;

function TContactFieldMapper.GetMappedValue(Field: String): String;
begin
  Result := Value[MappedField[Field]];
end;

function TContactFieldMapper.GetName: WideString;
begin
  Result := MappedValue['Name'];
end;

function TContactFieldMapper.GetOrganization: WideString;
begin
  Result := MappedValue['Organization'];
end;

function TContactFieldMapper.GetOtherPhone: WideString;
begin
  Result := MappedValue['OtherPhone'];
end;

function TContactFieldMapper.GetPostalCode: WideString;
begin
  Result := MappedValue['PostalCode'];
end;

function TContactFieldMapper.GetRegion: WideString;
begin
  Result := MappedValue['Region'];
end;

function TContactFieldMapper.GetStreet: WideString;
begin
  Result := MappedValue['Street'];
end;

function TContactFieldMapper.GetSurName: WideString;
begin
  Result := MappedValue['SurName'];
end;

function TContactFieldMapper.GetTitle: WideString;
begin
  Result := MappedValue['Title'];
end;

function TContactFieldMapper.GetWorkPhone: WideString;
begin
  Result := MappedValue['WorkPhone'];
end;

procedure TContactFieldMapper.LoadStandardFields;
begin

  { REFFERENCE !!!

    TFMAContactFieldMapper.Create;
    TContactFieldMapper.LoadStandardFields;
    TOutlookContactSource.Read/Write();
  }

  FStandardFields.Add('Title');
  FStandardFields.Add('Name');
  FStandardFields.Add('SurName');
  FStandardFields.Add('Organization');
  FStandardFields.Add('EMail');
  FStandardFields.Add('HomePhone');
  FStandardFields.Add('WorkPhone');
  FStandardFields.Add('CellPhone');
  FStandardFields.Add('FaxPhone');
  FStandardFields.Add('OtherPhone');
  FStandardFields.Add('Street');
  FStandardFields.Add('City');
  FStandardFields.Add('Region');
  FStandardFields.Add('PostalCode');
  FStandardFields.Add('Country');
  {
  Fields.Add('WorkStreet');
  Fields.Add('WorkCity');
  Fields.Add('WorkRegion');
  Fields.Add('WorkPostalCode');
  Fields.Add('WorkCountry');
  }
  FStandardFields.Add('Birthday');
end;

procedure TContactFieldMapper.SetBirthday(const Value: WideString);
begin
  MappedValue['Birthday'] := Value;
end;

procedure TContactFieldMapper.SetCellPhone(const Value: WideString);
begin
  MappedValue['CellPhone'] := Value;
end;

procedure TContactFieldMapper.SetCity(const Value: WideString);
begin
  MappedValue['City'] := Value;
end;

procedure TContactFieldMapper.SetCountry(const Value: WideString);
begin
  MappedValue['Country'] := Value;
end;

procedure TContactFieldMapper.SetEMail(const Value: WideString);
begin
  MappedValue['EMail'] := Value;
end;

procedure TContactFieldMapper.SetFaxPhone(const Value: WideString);
begin
  MappedValue['FaxPhone'] := Value;
end;

procedure TContactFieldMapper.SetFields(const Value: TStrings);
begin
  FFields.Assign(Value);
end;

procedure TContactFieldMapper.SetHomePhone(const Value: WideString);
begin
  MappedValue['HomePhone'] := Value;
end;

procedure TContactFieldMapper.SetMappedFields(const Value: TStrings);
begin
  FMappedFields.Assign(Value);
end;

procedure TContactFieldMapper.SetMappedValue(Field: String; const AValue: String);
begin
  Value[MappedField[Field]] := AValue;
end;

procedure TContactFieldMapper.SetName(const Value: WideString);
begin
  MappedValue['Name'] := Value;
end;

procedure TContactFieldMapper.SetOrganization(const Value: WideString);
begin
  MappedValue['Organization'] := Value;
end;

procedure TContactFieldMapper.SetOtherPhone(const Value: WideString);
begin
  MappedValue['OtherPhone'] := Value;
end;

procedure TContactFieldMapper.SetPostalCode(const Value: WideString);
begin
  MappedValue['PostalCode'] := Value;
end;

procedure TContactFieldMapper.SetRegion(const Value: WideString);
begin
  MappedValue['Region'] := Value;
end;

procedure TContactFieldMapper.SetStreet(const Value: WideString);
begin
  MappedValue['Street'] := Value;
end;

procedure TContactFieldMapper.SetSurName(const Value: WideString);
begin
  MappedValue['SurName'] := Value;
end;

procedure TContactFieldMapper.SetTitle(const Value: WideString);
begin
  MappedValue['Title'] := Value;
end;

procedure TContactFieldMapper.SetWorkPhone(const Value: WideString);
begin
  MappedValue['WorkPhone'] := Value;
end;

end.
