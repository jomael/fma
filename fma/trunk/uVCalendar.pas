unit uVCalendar; // do not localize

{
*******************************************************************************
* Descriptions: Calendar
* $Source: /cvsroot/fma/fma/uVCalendar.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uVCalendar.pas,v $
*
*******************************************************************************
}

interface

uses
  Classes, TntClasses, uVBase;

type
  VCalEntPropertyType = (
    tprAttach, tprAttendee, tprDCreated, tprCompleted,
    tprDescription, tprDue, tprDtEnd, tprExRule, tprLastModified,
    tprLocation, tprRNum, tprPriority, tprRelatedTo, tprRRule,
    tprSequence, tprDtStart, tprSummary, tprTransp, tprUrl, tprUid,
    tprAAlarm, tprCategories, tprClass, tprDAlarm, tprExDate, tprMAlarm,
    tprPAlarm, tprRDate, tprResources, tprStatus,
    // IrMC Specific
    tprIrmcLuid,
    // FMA specific
    tprAlertShown
  );

  TVCalProperty = class(TVProperty)
  protected
    FPropType: VCalEntPropertyType;

    function GetPropertyName: WideString; override;
    procedure SetPropertyName(const Value: WideString); override;
  public
    constructor Create(Owner: TVBaseObj; PropType: VCalEntPropertyType);
  end;

  { Class for handling date infromations }
  TVCalDateTime = class(TVCalProperty)
  private
    function GetDTString: String;
    procedure SetDTString(const Value: String);
  protected
    FDateTime: TDateTime;
    FIsUtc: Boolean;

    FBias: Integer;   // The bias is the difference, in minutes, between UTC time and local time.

    procedure SetDateTime(const Value: TDateTime);

    function GetPropertyValue: WideString; override;
    procedure SetPropertyValue(const Value: WideString); override;
  public
    constructor Create(Owner: TVBaseObj; PropType: VCalEntPropertyType);

    function GetUtc: TDateTime;
    function GetLocal: TDateTime;

    procedure UtcToLocal;
    procedure LocalToUtc;

    property IsUtc: Boolean read FIsUtc write FIsUtc;
    property DateTime: TDateTime read FDateTime write SetDateTime;
    property AsString: String read GetDTString write SetDTString;
  end;

  TVCalCategoriesType = (
    tcaAppointment, tcaBusiness, tcaEducation, tcaHoliday, tcaMeeting,
    tcaMiscellaneous, tcaPersonal, tcaPhoneCall, tcaSickDay, tcaSpecialOccasion,
    tcaTravel, tcaVacation,
    // SE specific
    tcaAnniversary, tcaDate
  );
  TVCalCategoriesAttribs = set of TVCalCategoriesType;

  { Encapsulates categories property }
  TVCalCategories = class(TVCalProperty)
  protected
    FCategories: TVCalCategoriesAttribs;

    procedure SetCategories(Value: TVCalCategoriesAttribs);

    function GetPropertyValue: WideString; override;
    procedure SetPropertyValue(const Value: WideString); override;
  public
    constructor Create(Owner: TVBaseObj);
  published
    property Categories: TVCalCategoriesAttribs read FCategories write SetCategories default [];
  end;

  TVCalStatusType = (
    tstUnknown, tstAccepted, tstNeedsAction, tstSent, tstTentative, tstConfirmed,
    tstDeclined, tstCompleted, tstDelegated
  );

  { Encapsulates status property }
  TVCalStatus = class(TVCalProperty)
  protected
    FStatus: TVCalStatusType;

    procedure SetStatus(Value: TVCalStatusType);

    function GetPropertyValue: WideString; override;
    procedure SetPropertyValue(const Value: WideString); override;
  public
    constructor Create(Owner: TVBaseObj);
  published
    property Status: TVCalStatusType read FStatus write SetStatus default tstUnknown;
  end;

  { Encapsulates boolean property }
  TVCalBoolean = class(TVCalProperty)
  protected
    FStatus: Boolean;

    procedure SetStatus(Value: Boolean);

    function GetPropertyValue: WideString; override;
    procedure SetPropertyValue(const Value: WideString); override;
  public
    constructor Create(Owner: TVBaseObj; PropType: VCalEntPropertyType);
  published
    property IsON: Boolean read FStatus write SetStatus default False;
  end;

  TVCalClassType = (
    tclUnknown, tclPublic, tclPrivate, tclConfidential
  );

  { Encapsulates classification of vCalendar object }
  TVCalClass = class(TVCalProperty)
  protected
    FClass: TVCalClassType;

    procedure SetClass(Value: TVCalClassType);

    function GetPropertyValue: WideString; override;
    procedure SetPropertyValue(const Value: WideString); override;
  public
    constructor Create(Owner: TVBaseObj);
  published
    property Classification: TVCalClassType read FClass write SetClass default tclUnknown;
  end;

  TVCalReccurenceType = (rrNone, rrDaily, rrWeekly, rrMonthly, rrYearly);
  TVCalReccurenceDays = array[1..7] of Boolean;

const
  ReccurenceDayNames: array[1..7] of WideString = ('SA','MO','TU','WE','TH','FR','SU');

type
  { Encapsulates reccurence of vCalendar object }
  TVCalReccurence = class(TVCalProperty)
  private
    function GetWeekDays: WideString;
    procedure SetWeekDays(const Value: WideString);
  protected
    FReccurence: TVCalReccurenceType;
    FRangeEnd: TVCalDateTime;
    FReccurenceOn: Integer;
    FReccurenceDays: TVCalReccurenceDays;

    function GetReccurenceDays(Index: integer): Boolean;
    procedure SetReccurenceDays(Index: integer; const Value: Boolean);
    procedure SetReccurence(Value: TVCalReccurenceType);
    procedure SetReccurenceOn(const Value: Integer);
    procedure SetEndDate(const Value: TDateTime);
    function GetEndDate: TDateTime;

    function GetPropertyValue: WideString; override;
    procedure SetPropertyValue(const Value: WideString); override;
  public
    constructor Create(Owner: TVBaseObj);
    destructor Destroy; override;

    function Description: WideString;
    property WeekDays: WideString read GetWeekDays write SetWeekDays;
    property Reccurence: TVCalReccurenceType read FReccurence write SetReccurence default rrNone;
    property ReccurenceOn: Integer read FReccurenceOn write SetReccurenceOn;
    property ReccurenceDays[Index: integer]: Boolean read GetReccurenceDays write SetReccurenceDays;
    property EndDate: TDateTime read GetEndDate write SetEndDate;
  end;

  TVCalEntity = class(TVBaseObj)
  protected
    { Protected declarations }
    function GetRaw: TStrings; override;
    procedure SetProperty(AProp: TVProperty); override;

    // Declared just to avoid warnings. Method is not used.
    function CreateVObject(Value: WideString): TVBaseObj; override;
  public
    // Simple properties
    VAttach, VAttendee: WideString;
    VDCreated, VCompleted: TVCalDateTime;
    VDescription: WideString;
    VDue, VDtEnd: TVCalDateTime;
    VExRule: WideString;          // TODO: Define own type
    VLastModified: TVCalDateTime;
    VLocation: TVProperty;
    VRNum: Integer;               // TODO: Use with RDate, RRule, ExDate and ExRule
    VPriority: TVProperty;
    VRelatedTo: WideString;
    VRRule: TVCalReccurence;      
    VSequence: Integer;
    VDtStart: TVCalDateTime;
    VSummary: TVProperty;
    VTransp: Integer;             // Could be boolean enough?
    VURL: WideString;
    VUID: WideString;

    // Complex properties
    VAAlarm: TVCalDateTime;       // TODO: Define own type
    VCategories: TVCalCategories;
    VClass: TVCalClass;
    VDAlarm: WideString;          // TODO: Define own type
    VExDate: WideString;          // TODO: Define own type
    VMAlarm: WideString;          // TODO: Define own type
    VPAlarm: WideString;          // TODO: Define own type
    VRDate: WideString;           // TODO: Define own type
    VResources: WideString;       // TODO: Define own type
    VStatus: TVCalStatus;

    // IrMC specific
    VIrmcLUID: TVProperty;
    // FMA specific
    VAlertShown: TVCalBoolean;

    constructor Create;
    destructor Destroy; override;

    procedure Clear; override;
  end;

  { Encapsulates vCalendar object }
  TVCalendar = class(TVBaseObj)
  protected
    { Protected declarations }
    function GetRaw: TStrings; override;
    procedure SetProperty(AProp: TVProperty); override;

    function CreateVObject(Value: WideString): TVBaseObj; override;
  public
    VProdID: WideString;

    constructor Create;

    procedure Clear; override;

    function GetCalEntityByLuid(const Value: WideString): TVCalEntity;
    function GetCalEntityByItemIndex(const Value: Integer): TVCalEntity;
  end;

implementation

uses
  Windows, TntWindows, SysUtils, TntSysUtils, DateUtils, Contnrs, uGlobal;

{ TVCalProperty }

const VCalEntProperties : array [0..31] of WideString = (
  'ATTACH', 'ATTENDEE', 'DCREATED', 'COMPLETED',
  'DESCRIPTION', 'DUE', 'DTEND', 'EXRULE', 'LAST-MODIFIED',
  'LOCATION', 'RNUM', 'PRIORITY', 'RELATED-TO', 'RRULE',
  'SEQUENCE', 'DTSTART', 'SUMMARY', 'TRANSP', 'URL', 'UID',
  'AALARM', 'CATEGORIES', 'CLASS', 'DALARM', 'EXDATE', 'MALARM',
  'PALARM', 'RDATE', 'RESOURCES', 'STATUS',
  // IrMC Specific
  'X-IRMC-LUID',
  // FMA specific
  'X-ALERTED'
);

constructor TVCalProperty.Create(Owner: TVBaseObj; PropType: VCalEntPropertyType);
begin
  inherited Create(Owner);

  FPropType := PropType;
end;

function TVCalProperty.GetPropertyName: WideString;
begin
  Result := VCalEntProperties[Ord(FPropType)];
end;

procedure TVCalProperty.SetPropertyName(const Value: WideString);
var
  Index: Integer;
begin
  inherited;

  Index := PosStrInArray(Value, VCalEntProperties);
  if Index >= 0 then FPropType := VCalEntPropertyType(Index);
end;

{ TVCalDateTime }

constructor TVCalDateTime.Create(Owner: TVBaseObj; PropType: VCalEntPropertyType);
var
  lpTimeZone: _TIME_ZONE_INFORMATION;
  DayLight: LongWord;
begin
  inherited;

  FDateTime := 0;
  FIsUtc := False;

  DayLight := GetTimeZoneInformation(lpTimeZone);

  FBias := lpTimeZone.Bias;
  if DayLight = TIME_ZONE_ID_DAYLIGHT	then FBias := FBias + lpTimeZone.DaylightBias;

  FIsSet := False;
end;

procedure TVCalDateTime.SetDateTime(const Value: TDateTime);
begin
  FDateTime := Value;
  FIsSet := True;
end;

function TVCalDateTime.GetPropertyValue: WideString;
begin
  Result := '';
  if FIsSet then
  begin
    Result := FormatDateTime('yyyymmdd"T"hhnnss', FDateTime);
    if FIsUtc then Result := Result + 'Z';
  end;
end;

procedure TVCalDateTime.SetPropertyValue(const Value: WideString);
  var
    SDate, STime: String;
    NDate, NTime: Integer;
begin
  FIsSet := False;

  if Value = '' then Exit;

  SDate := Copy(Value, 1, Pos('T', UpperCase(Value)) - 1);
  STime := Copy(Value, Pos('T', UpperCase(Value)) + 1, Length(Value));

  if Pos('Z', UpperCase(STime)) > 0 then begin
    FIsUtc := True;
    Delete(STime, Length(STime), 1);
  end
  else
    FIsUtc := False;

  try
    NDate := StrToInt(SDate);
    NTime := StrToInt(STime);

    FDateTime := EncodeDateTime(NDate div 10000, (NDate div 100) mod 100, NDate mod 100, NTime div 10000, (nTime div 100) mod 100, nTime mod 100, 0);

    FIsSet := True;
  except
  end;
end;

function TVCalDateTime.GetUtc: TDateTime;
begin
  if not FIsUtc then Result := IncMinute(FDateTime, FBias)
  else Result := FDateTime;
end;

function TVCalDateTime.GetLocal: TDateTime;
begin
  if FIsUtc then Result := IncMinute(FDateTime, -FBias)
  else Result := FDateTime;
end;

procedure TVCalDateTime.UtcToLocal;
begin
  FDateTime := GetLocal;
  FIsUtc := False;
end;

procedure TVCalDateTime.LocalToUtc;
begin
  FDateTime := GetUtc;
  FIsUtc := True;
end;

function TVCalDateTime.GetDTString: String;
begin
  Result := FloatToStr(GetLocal);
end;

procedure TVCalDateTime.SetDTString(const Value: String);
begin
  IsUtc := False;
  DateTime := StrToFloat(Value);
  LocalToUtc;
end;

{ TVCalCategories }

const CategoriesAttributes: array [0..13] of WideString  = (
  'APPOINTMENT', 'BUSINESS', 'EDUCATION', 'HOLIDAY', 'MEETING',
  'MISCELLANEOUS', 'PERSONAL', 'PHONECALL' { 'PHONE CALL' }, 'SICK DAY', 'SPECIAL OCCASION',
  'TRAVEL', 'VACATION',
   // SE specific
  'ANNIVERSARY', 'DATE'
);

constructor TVCalCategories.Create(Owner: TVBaseObj);
begin
  inherited Create(Owner, tprCategories);
end;

procedure TVCalCategories.SetCategories(Value: TVCalCategoriesAttribs);
begin
  FIsSet := False;

  FCategories := Value;

  if FCategories <> [] then FIsSet := True;
end;

function TVCalCategories.GetPropertyValue: WideString;
  var
    I: TVCalCategoriesType;
begin
  Result := '';

  if FIsSet then
  begin
    for I := tcaAppointment to tcaDate do
    begin
      if I in FCategories then Result := Result + ';' + CategoriesAttributes[Ord(I)];
    end;
    if Length(Result) > 0 then Delete(Result, 1, 1);
  end;
end;

procedure TVCalCategories.SetPropertyValue(const Value: WideString);
  var
    Attribs: TStrings;
    I: Integer;
begin
  FIsSet := False;

  if Value = '' then Exit;

  Attribs := TStringList.Create;
  Attribs.Delimiter := ';';
  Attribs.DelimitedText := UpperCase(Value);

  FCategories := [];

  for I := 0 to Attribs.Count - 1 do begin
    case PosStrInArray(Attribs[I], CategoriesAttributes) of
      { APPOINTMENT }
      0: FCategories := FCategories + [tcaAppointment];
      { BUSINESS }
      1: FCategories := FCategories + [tcaBusiness];
      { EDUCATION }
      2: FCategories := FCategories + [tcaEducation];
      { HOLIDAY }
      3: FCategories := FCategories + [tcaHoliday];
      { MEETING }
      4: FCategories := FCategories + [tcaMeeting];
      { MISCELLANEOUS }
      5: FCategories := FCategories + [tcaMiscellaneous];
      { PERSONAL }
      6: FCategories := FCategories + [tcaPersonal];
      { PHONE CALL }
      7: FCategories := FCategories + [tcaPhoneCall];
      { SICK DAY }
      8: FCategories := FCategories + [tcaSickDay];
      { SPECIAL OCCASION }
      9: FCategories := FCategories + [tcaSpecialOccasion];
      { TRAVEL }
      10: FCategories := FCategories + [tcaTravel];
      { VACATION }
      11: FCategories := FCategories + [tcaVacation];
      { ANNIVERSARY }
      12: FCategories := FCategories + [tcaAnniversary];
      { DATE }
      13: FCategories := FCategories + [tcaDate];
    end;
  end;

  Attribs.Free;

  if FCategories <> [] then FIsSet := True;
end;

{ TVCalStatus }

const StatusAttributes: array [0..8] of WideString  = (
  'UNKNOWN', 'ACCEPTED', 'NEEDS ACTION', 'SENT', 'TENTATIVE', 'CONFIRMED', 'DECLINED',
  'COMPLETED', 'DELEGATED'
);

constructor TVCalStatus.Create(Owner: TVBaseObj);
begin
  inherited Create(Owner, tprStatus);
end;

procedure TVCalStatus.SetStatus(Value: TVCalStatusType);
begin
  FStatus := Value;

  FIsSet := FStatus <> tstUnknown;
end;

function TVCalStatus.GetPropertyValue: WideString;
begin
  if FIsSet and (Ord(FStatus) > 0) then Result := StatusAttributes[Ord(FStatus)]
  else Result := '';
end;

procedure TVCalStatus.SetPropertyValue(const Value: WideString);
  var
    Pos: Integer;
begin
  FIsSet := False;

  if Value = '' then Exit;

  Pos := PosStrInArray(Value, StatusAttributes);

  if Pos < 0 then FStatus := tstUnknown
  else begin
    FStatus := TVCalStatusType(Pos);
    FIsSet := True;
  end;
end;

{ TVCalClass }

const ClassAttributes: array [0..3] of WideString  = (
  'UNKNOWN', 'PUBLIC', 'PRIVATE', 'CONFIDENTIAL'
);

constructor TVCalClass.Create(Owner: TVBaseObj);
begin
  inherited Create(Owner, tprClass);
end;

procedure TVCalClass.SetClass(Value: TVCalClassType);
begin
  FIsSet := False;

  FClass := Value;

  if FClass <> tclUnknown then FIsSet := True;
end;

function TVCalClass.GetPropertyValue: WideString;
begin
  if FIsSet and (Ord(FClass) > 0) then Result := ClassAttributes[Ord(FClass)]
  else Result := '';
end;

procedure TVCalClass.SetPropertyValue(const Value: WideString);
var
  Pos: Integer;
begin
  FIsSet := False;

  if Value = '' then Exit;

  Pos := PosStrInArray(Value, ClassAttributes);

  if Pos < 0 then FClass := tclUnknown
  else begin
    FClass := TVCalClassType(Pos);
    FIsSet := True;
  end;
end;

{ TVCalEntity }

constructor TVCalEntity.Create;
begin
  inherited;

  VAAlarm := TVCalDateTime.Create(Self, tprAAlarm);
  VDCreated := TVCalDateTime.Create(Self, tprDCreated);
  VCompleted := TVCalDateTime.Create(Self, tprCompleted);
  VDue := TVCalDateTime.Create(Self, tprDue);
  VDtEnd := TVCalDateTime.Create(Self, tprDtEnd);
  VLastModified := TVCalDateTime.Create(Self, tprLastModified);
  VLocation := TVCalProperty.Create(Self, tprLocation);
  VPriority := TVCalProperty.Create(Self, tprPriority);
  VDtStart := TVCalDateTime.Create(Self, tprDtStart);
  VSummary := TVCalProperty.Create(Self, tprSummary);

  VCategories := TVCalCategories.Create(Self);
  VClass := TVCalClass.Create(Self);
  VStatus := TVCalStatus.Create(Self);
  VRRule := TVCalReccurence.Create(Self);

  VIrmcLUID := TVCalProperty.Create(Self, tprIrmcLuid);
  VAlertShown := TVCalBoolean.Create(Self, tprAlertShown);
end;

procedure TVCalEntity.Clear;
begin
  inherited;

  if not isDestroying then
  begin
    VAttach := '';
    VAttendee := '';
    VAAlarm.IsSet := False;
    VDCreated.IsSet := False;
    VCompleted.IsSet := False;
    VDescription := '';
    VDue.IsSet := False;
    VDtEnd.IsSet := False;
    VExRule := '';
    VLastModified.IsSet := False;
    VLocation.IsSet := False;
    VRNum := 0;
    VPriority.IsSet := False;
    VRelatedTo := '';
    VRRule.IsSet := False;
    VSequence := 0;
    VDtStart.IsSet := False;
    VSummary.IsSet := False;
    VTransp := 0;
    VURL := '';
    VUID := '';

    VCategories.IsSet := False;
    VClass.IsSet := False;
    VDAlarm := '';
    VExDate := '';
    VMAlarm := '';
    VPAlarm := '';
    VRDate := '';
    VResources := '';
    VStatus.Status := tstUnknown;

    // IrMC Specific
    VIrmcLUID.IsSet := False;
    // FMA specific
    VAlertShown.IsSet := False;
  end;
end;

destructor TVCalEntity.Destroy;
begin
  VAAlarm.Free;
  VDCreated.Free;
  VCompleted.Free;
  VDue.Free;
  VDtEnd.Free;
  VLastModified.Free;
  VLocation.Free;
  VPriority.Free;
  VDtStart.Free;
  VSummary.Free;

  VCategories.Free;
  VClass.Free;
  VStatus.Free;
  VRRule.Free;

  VIrmcLUID.Free;
  VAlertShown.Free;

  inherited;
end;

function TVCalEntity.GetRaw: TStrings;
begin
  FStrList.Clear;

  if VDtStart.IsSet then FStrList.Add(VDtStart.EncodedText);
  if VDtEnd.IsSet then FStrList.Add(VDtEnd.EncodedText);
  if VSummary.IsSet then FStrList.Add(VSummary.EncodedText);
  if VLocation.IsSet then FStrList.Add(VLocation.EncodedText);
  if VCompleted.IsSet then FStrList.Add(VCompleted.EncodedText);
  if VAAlarm.IsSet then FStrList.Add(VAAlarm.EncodedText);
  if VCategories.IsSet then FStrList.Add(VCategories.EncodedText);
  if VPriority.IsSet then FStrList.Add(VPriority.EncodedText);
  if VStatus.IsSet then FStrList.Add(VStatus.EncodedText);
  if VClass.IsSet then FStrList.Add(VClass.EncodedText);
  if VIrmcLUID.IsSet then FStrList.Add(VIrmcLUID.EncodedText);
  if VAlertShown.IsSet then FStrList.Add(VAlertShown.EncodedText);

  if VRRule.IsSet then FStrList.Add(VRRule.EncodedText);

  Result := inherited GetRaw;
end;

procedure TVCalEntity.SetProperty(AProp: TVProperty);
begin
  inherited;

  case PosStrInArray(AProp.PropertyName, VCalEntProperties) of
    // ATTACH
    0: ;
    // ATTENDEE
    1: ;
    // DCREATED
    2: ;
    // COMPLETED
    3: VCompleted.Text := AProp.Text;
    // DESCRIPTION
    4: ;
    // DUE
    5: ;
    // DTEND
    6: VDtEnd.Text := AProp.Text;
    // EXRULE
    7: ;
    // LAST-MODIFIED
    8: ;
    // LOCATION
    9: VLocation.Text := AProp.Text;
    // RNUM
    10: ;
    // PRIORITY
    11: VPriority.Text := AProp.Text;
    // RELATED-TO
    12: ;
    // RRULE
    13: VRRule.Text := AProp.Text;
    // SEQUENCE
    14: ;
    // DTSTART
    15: VDtStart.Text := AProp.Text;
    // SUMMARY
    16: VSummary.Text := AProp.Text;
    // TRANSP
    17: ;
    // URL
    18: ;
    // UID
    19: ;
    // AALARM
    20: VAAlarm.Text := AProp.Text;
    // CATEGORIES
    21: VCategories.Text := AProp.Text;
    // CLASS
    22: VClass.Text := AProp.Text;
    // DALARM
    23: ;
    // EXDATE
    24: ;
    // MALARM
    25: ;
    // PALARM
    26: ;
    // RDATE
    27: ;
    // RESOURCES
    28: ;
    // STATUS
    29: VStatus.Text := AProp.Text;
    // X-IRMC-LUID
    30: VIrmcLUID.Text := AProp.Text;
    // X-ALERTED
    31: VAlertShown.Text := AProp.Text;
  end;
end;

function TVCalEntity.CreateVObject(Value: WideString): TVBaseObj;
begin
  Result := nil;

  inherited;
end;

{ TVCalendar }

const VCalProperties : array [0..3] of WideString = (
  'DAYLIGHT', 'GEO', 'PRODID', 'TZ'
);

constructor TVCalendar.Create;
begin
  inherited;

  VType.EntityType := tenVCalendar;
end;

procedure TVCalendar.Clear;
begin
  inherited;

  if not isDestroying then
  begin
    VType.EntityType := tenVCalendar;
    VProdID := '';
  end;
end;

function TVCalendar.GetRaw: TStrings;
begin
  FStrList.Clear;

  if VVersion = '' then FStrList.Add('VERSION:1.0');
  
  Result := inherited GetRaw;
end;

procedure TVCalendar.SetProperty(AProp: TVProperty);
begin
  case PosStrInArray(AProp.PropertyName, VCalProperties) of
  { DAYLIGHT }
  0: ;
  { GEO }
  1: ;
  { PRODID }
  2: VProdID := AProp.PropertyValue;
  { TZ }
  3: ;
  end;

  inherited;
end;

function TVCalendar.GetCalEntityByLuid(const Value: WideString): TVCalEntity;
  var
    I: Integer;
    ACalEntity: TVCalEntity;
begin
  Result := nil;
  for I := 0 to Count - 1 do begin
    ACalEntity := TVCalEntity(Items[I]);
    if ACalEntity.VIrmcLUID.PropertyValue = Value then
    begin
      Result := ACalEntity;
      Exit;
    end;
  end;
end;

function TVCalendar.GetCalEntityByItemIndex(const Value: Integer): TVCalEntity;
begin
  Result := TVCalEntity(GetByItemIndex(Value));
end;

function TVCalendar.CreateVObject(Value: WideString): TVBaseObj;
begin
  Result := nil;

  case PosStrInArray(Value, VEntityType) of
    // VTODO, VEVENT
    3, 4: Result := TVCalEntity.Create;
  end;
end;


{ TVCalReccurence }

constructor TVCalReccurence.Create(Owner: TVBaseObj);
begin
  inherited Create(Owner, tprRRule);

  FRangeEnd := TVCalDateTime.Create(Owner, tprRDate);
  FRangeEnd.DateTime := EmptyDate;
  FRangeEnd.IsSet := False;
end;

destructor TVCalReccurence.Destroy;
begin
  FRangeEnd.Free;
  
  inherited;
end;

function TVCalReccurence.GetEndDate: TDateTime;
begin
  if FRangeEnd.IsSet then
    Result := FRangeEnd.DateTime
  else
    Result := EmptyDate;
end;

function TVCalReccurence.GetPropertyValue: WideString;
var
  w: WideString;
begin
  Result := '';

  if FIsSet and (FReccurence <> rrNone) then begin
    case FReccurence of
      rrDaily:
        Result := 'D1';
      rrWeekly:
        Result := 'W1 ' + WeekDays;
      rrMonthly:
        Result := 'MD1 ' + IntToStr(FReccurenceOn);
      rrYearly:
        Result := 'YM1 ' + IntToStr(FReccurenceOn);
    end;
    if FRangeEnd.IsSet then begin
      w := FRangeEnd.Text;
      Delete(w,1,Pos(':',w));
      Result := Result + ' ' + w;
    end
    else
      Result := Result + ' #0';
  end;
end;

procedure TVCalReccurence.SetEndDate(const Value: TDateTime);
begin
  if Value = EmptyDate then
    FRangeEnd.IsSet := False
  else
    FRangeEnd.DateTime := Value;
end;

procedure TVCalReccurence.SetPropertyValue(const Value: WideString);
var
  k: Integer;
  w: WideString;
  StartDt: TVCalDateTime;
  procedure GetReccurenceOn;
  var
    i: Integer;
    d: WideString;
  begin
    i := Pos(' ',w);
    if i <> 0 then begin
      Delete(w,1,i);
      repeat
        i := Pos(' ',w);
        if i = 0 then break;
        
        d := Copy(w,1,i-1);
        Delete(w,1,i);

        if FReccurence <> rrWeekly then begin
          FReccurenceOn := StrToInt(d);
          break;
        end
        else
          for i := 1 to 7 do
            if ReccurenceDayNames[i] = d then
              FReccurenceDays[i] := True;
      until False;
    end;
  end;
begin
  FIsSet := False;

  if Value = '' then Exit;

  FReccurence := rrNone;
  FReccurenceOn := 0;
  for k := 1 to 7 do FReccurenceDays[k] := False;

  w := Value;

  if Copy(w,1,1) = 'D'  then FReccurence := rrDaily;
  if Copy(w,1,1) = 'W'  then FReccurence := rrWeekly;
  if Copy(w,1,2) = 'MD' then FReccurence := rrMonthly;
  if Copy(w,1,2) = 'YM' then FReccurence := rrYearly;

  if Ord(FReccurence) > Ord(rrDaily) then begin
    GetReccurenceOn;
    StartDt := (Owner as TVCalEntity).VDtStart;
    if StartDt.IsSet then
      FReccurenceOn := DayOfWeek(StartDt.DateTime);
  end;

  if w = '#0' then begin
    FRangeEnd.DateTime := EmptyDate;
    FRangeEnd.IsSet := False;
  end
  else
    FRangeEnd.Text := w;

  if FReccurence <> rrNone then FIsSet := True;
end;

procedure TVCalReccurence.SetReccurence(Value: TVCalReccurenceType);
var
  StartDt: TVCalDateTime;
begin
  FIsSet := False;

  StartDt := (Owner as TVCalEntity).VDtStart;
  if StartDt.IsSet then begin
    FReccurence := Value;

    case FReccurence of
      rrNone,
      rrDaily:   FReccurenceOn := 0;
      rrWeekly:  FReccurenceOn := DayOfWeek(StartDt.DateTime);
      rrMonthly: FReccurenceOn := DayOfTheMonth(StartDt.DateTime);
      rrYearly:  FReccurenceOn := MonthOfTheYear(StartDt.DateTime);
    end;

    if FReccurence <> rrNone then FIsSet := True;
  end;
end;

procedure TVCalReccurence.SetReccurenceOn(const Value: Integer);
begin
  FReccurenceOn := Value;
end;

function TVCalReccurence.Description: WideString;
begin
  Result := '';
  if FIsSet then
    case FReccurence of
      rrDaily:
        Result := 'Daily';
      rrWeekly:
        Result := 'Weekly on ' + ReccurenceDayNames[FReccurenceOn];
      rrMonthly:
        Result := 'Monthly on day ' + IntToStr(FReccurenceOn);
      rrYearly:
        Result := 'Yearly on month ' + IntToStr(FReccurenceOn);
    end;
    if FRangeEnd.IsSet then
      Result := Result + ', ends on ' + DateTimeToStr(FRangeEnd.DateTime);
end;

function TVCalReccurence.GetReccurenceDays(Index: integer): Boolean;
begin
  Result := FReccurenceDays[Index] or (Index = FReccurenceOn);
end;

procedure TVCalReccurence.SetReccurenceDays(Index: integer;
  const Value: Boolean);
begin
  if Index <> FReccurenceOn then
    FReccurenceDays[Index] := Value;
end;

function TVCalReccurence.GetWeekDays: WideString;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to 7 do
    if ReccurenceDays[i] then begin // do not use FReccurenceDays here!
      if Result <> '' then Result := Result + ' ';
      Result := Result + ReccurenceDayNames[i];
    end;
end;

procedure TVCalReccurence.SetWeekDays(const Value: WideString);
var
  i: Integer;
begin
  for i := 1 to 7 do
    FReccurenceDays[i] := Pos(ReccurenceDayNames[i],Value) <> 0;
end;

{ TVCalBoolean }

constructor TVCalBoolean.Create(Owner: TVBaseObj; PropType: VCalEntPropertyType);
begin
  inherited;

  FStatus := False;
end;

function TVCalBoolean.GetPropertyValue: WideString;
begin
  if FIsSet then Result := IntToStr(Byte(FStatus))
  else Result := '';
end;

procedure TVCalBoolean.SetPropertyValue(const Value: WideString);
begin
  FIsSet := False;

  if Value = '' then Exit;

  try
    if (WideCompareText(Value,'true') = 0) or (WideCompareText(Value,'on') = 0) or
      (WideCompareText(Value,'yes') = 0) then
      FStatus := True
    else
    if (WideCompareText(Value,'false') = 0) or (WideCompareText(Value,'off') = 0) or
      (WideCompareText(Value,'no') = 0) then
      FStatus := False
    else
      FStatus := StrToInt(Value) <> 0; // '1' or '0'

    FIsSet := True;
  except
  end;
end;

procedure TVCalBoolean.SetStatus(Value: Boolean);
begin
  FStatus := Value;

  FIsSet := True;
end;

end.
