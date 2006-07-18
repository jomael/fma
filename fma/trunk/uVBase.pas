{$J+}

unit uVBase; // do not localize

interface

uses
  Classes, TntClasses, Contnrs;

const
  VEntityType: array [0..4] of WideString = (
    'VUNKNOWN', 'VCARD', 'VCALENDAR', 'VTODO', 'VEVENT'
  );

type
  TVBaseObj = class;

  TVProperty = class(TObject)
  protected
    FOwner: TVBaseObj;

    FPropertyName: WideString;
    FPropertyValue: WideString;
    FPropertyParams: TStrings;

    FIsSet: Boolean;

    function GetText: WideString; virtual;
    procedure SetText(const Value: WideString); virtual;
    function GetEncodedText: WideString; virtual;
    procedure SetEncodedText(const Value: WideString); virtual;

    function GetPropertyName: WideString; virtual;
    procedure SetPropertyName(const Value: WideString); virtual;
    function GetPropertyValue: WideString; virtual;
    procedure SetPropertyValue(const Value: WideString); virtual;
    procedure SetPropertyParams(const Value: TStrings); virtual;

    function GetParamIndex(const Value: WideString): Integer;
  public
    constructor Create(Owner: TVBaseObj);
    destructor Destroy; override;

    procedure Clear; virtual;
    procedure CheckUTFs;
  published
    property IsSet: Boolean read FIsSet write FIsSet;

    property PropertyName: WideString read GetPropertyName write SetPropertyName;
    property PropertyValue: WideString read GetPropertyValue write SetPropertyValue;
    property PropertyParams: TStrings read FPropertyParams write SetPropertyParams;

    // TODO: Use folding
    property Text: WideString read GetText write SetText;
    property EncodedText: WideString read GetEncodedText write SetEncodedText;

    property Owner: TVBaseObj read FOwner;
  end;

  TVType = (
    tenVUnknown, tenVCard, tenVCalendar, tenVTodo, tenVEvent
  );

  { Encapsulates type of the entity }
  TVEntityType = class(TVProperty)
  protected
    FEntityType: TVType;

    procedure SetEntityType(const Value: TVType);

    function GetPropertyValue: WideString; override;
    procedure SetPropertyValue(const Value: WideString); override;
  published
    property EntityType: TVType read FEntityType write SetEntityType default tenVUnknown;
  end;

  TVCalCharSet = (
    tecNone, tecAscii, tecUtf8
  );

  TVBaseObj = class(TObjectList)
  protected
    FOwner: TVBaseObj;

    FItemIndex: Integer;
    FItemCounter: Integer;
    FCalCharSet: TVCalCharSet;

    isDestroying: Boolean;

    FStrList: TStrings;

    function GetRaw: TStrings; virtual;
    procedure SetRaw(const Value: TStrings); virtual;

    function UnfoldLines(Value: TStrings; var CurrPos: Integer): String;
    function RemoveSoftLineBreakes(Value1: String; Value: TStrings; var CurrPos: Integer): String;
    procedure SetProperty(AProp: TVProperty); virtual;

    // Returns newly created children entity TVBaseObject of specified type
    function CreateVObject(Value: WideString): TVBaseObj; virtual; abstract;
    function GetCalCharSet: TVCalCharSet;
  public
    VType: TVEntityType;
    VVersion: WideString;

    // FMA specific
    VFmaState: Integer; //0 new entry; 1 modified entry; 2 deleted entry; 3 normal entry

    constructor Create;
    destructor Destroy; override;

    procedure Clear; override;
    function Add(AVObj: TVBaseObj): Integer;

    function GetByItemIndex(const Value: Integer): TVBaseObj;
  published
    property Raw: TStrings read GetRaw write SetRaw;
    property ItemIndex: Integer read FItemIndex;
    property OutputCharSet: TVCalCharSet read GetCalCharSet write FCalCharSet default tecAscii;

    property Owner: TVBaseObj read FOwner;
  end;

  TVObjStorage = class(TObjectList)
  protected
    FItemCounter: Integer;

    isDestroying: Boolean;

    FStrList: TStrings;

    function GetRaw: TStrings; virtual;
    procedure SetRaw(const Value: TStrings); virtual;

    // Returns newly created VObject of specified type
    function CreateVObject(Value: WideString): TVBaseObj; virtual;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear; override;
    function Add(AVObj: TVBaseObj): Integer;

    procedure SaveToFile(const FileName: string); virtual;
    procedure LoadFromFile(const FileName: string); virtual;
  published
    property Raw: TStrings read GetRaw write SetRaw;
  end;

 { Returns position of searched string in array }
  function PosStrInArray(const SearchStr: WideString; Contents: array of WideString; const CaseSensitive: Boolean = False): Integer;

  function Str2QP(instr: String): String;
  function QP2Str(instr: String): String;

  function Str2B64(input: string): string;
  { Warning! Next function returns a new instance of stream! }
  function B642Str(instr: TStream): TStream;

implementation

uses
  cUnicodeCodecs,
  TntSystem, SysUtils, TntSysUtils, uVCalendar, uVCard;

{ Returns position of searched string in array }
function PosStrInArray(const SearchStr: WideString; Contents: array of WideString; const CaseSensitive: Boolean = False): Integer;
begin
  for Result := Low(Contents) to High(Contents) do
  begin
    if CaseSensitive then
    begin
      if SearchStr = Contents[Result] then Exit;
    end
    else begin
      if WideSameText(SearchStr, Contents[Result]) then Exit;
    end;
  end;
  Result := -1;
end;

const
  _Code64: string[64]=('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/');

function Str2QP(instr: String): String;
var
  i,j,k,m,n: Integer;
begin
  {
  Quoted-Printable lines of text must also be limited to less than 76 characters.
  The 76 characters does not include the CRLF (RFC 822) line break sequence.
  For example a multiple line LABEL property value of:

  123 Winding Way
  Any Town, CA 12345
  USA

  Would be represented in a Quoted-Printable encoding as:

  LABEL;ENCODING=QUOTED-PRINTABLE:123 Winding Way=0D=0A=Any Town, CA 12345=0D=0A=USA
  }
  { DO NOT use Trim here since it will remove trailing CRLF chars!
  instr := trim(instr);
  }
  Result := '';
  j := 0; k := Length(instr);
  for i := 1 to k do begin
    if instr[i] = '=' then begin
      Result := Result + '=' + IntToHex(Ord(instr[i]),2);
      inc(j,2);
    end
    else
      if ((instr[i] >= #32) and (instr[i] <= #126)) then
        Result := Result + instr[i]
      else begin
        Result := Result + '=' + IntToHex(Ord(instr[i]),2);
        inc(j,2);
      end;
    inc(j);
    // should we fold the line? 73 (+ max next 3) <= max 76
    if (j > 73) and (i < k) then begin
      // Folding the result into several lines is possible wherever there may be
      // linear white space (NOT simply LWSP-chars), a CRLF immediately followed
      // by at least one LWSP-char may instead be inserted.
      n := Length(Result);
      m := n;
      { find latest LWSP-char }
      while (m <> 0) and (Result[m] <> ' ') do dec(m);
      { if found insert soft line break and CRLF before it }
      if m <> 0 then begin
        Insert('=' + sLinebreak,Result,m);
        j := n - m + 1; // count the LWSP-char too
      end;
    end;
  end;
end;

function QP2Str(instr: String): String;
begin
  { Trim here since it will remove trailing CRLF chars! }
  instr := trim(instr);
  Result := '';

  while length(instr) > 0 do begin
    // Check for 'soft' line break
    if (instr[1] = '=') and (Length(instr) >= 3) then begin
      Result := Result + chr(StrToInt('$' + instr[2] + instr[3]));
      Delete(instr, 1, 3);
    end
    else begin
      // If 'soft' line break, just delete it
      if instr[1] <> '=' then Result := Result + instr[1];
      Delete(instr, 1, 1);
    end;
  end;
end;

function Str2B64(input: string): string;
const charBase64:array[0..63] of char =
    ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',
 	 	 'Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f',
  	 'g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v',
		 'w','x','y','z','0','1','2','3','4','5','6','7','8','9','+','/');
var C: array[1..3] of byte;
    E: array[1..4] of byte;
    i,len:integer;
begin
  Result := '';
  len := Length(input);
  i:=0;
  while i < len do
  begin
    case len-i of
    1:
      begin
        c[1]:=ord(input[i+1]);
        i:=i+1;
        E[1] := c[1] shr 2;
        E[2] := ((c[1] and 3) shl 4);
        Result := Result + charBase64[E[1]]+charBase64[E[2]];
        Result := Result + '==';
      end;
    2:
      begin
        c[1]:=ord(input[i+1]);
        i:=i+1;
        c[2]:=ord(input[i+1]);
        i:=i+1;
        E[1] := c[1] shr 2;
        E[2] := ((c[1] and 3) shl 4) or (C[2] shr 4);
        E[3] := ((c[2] and 15) shl 2);
        Result := Result + charBase64[E[1]]+charBase64[E[2]];
        Result := Result + charBase64[E[3]]+'=';
      end;
    else
      begin
        c[1]:=ord(input[i+1]);
        i:=i+1;
        c[2]:=ord(input[i+1]);
        i:=i+1;
        c[3]:=ord(input[i+1]);
        i:=i+1;
        E[1] := c[1] shr 2;
        E[2] := ((c[1] and 3) shl 4) or (C[2] shr 4);
        E[3] := ((c[2] and 15) shl 2) or (C[3] shr 6);
        E[4] := c[3] and 63;
        Result := Result + charBase64[E[1]]+charBase64[E[2]];
        Result := Result + charBase64[E[3]]+charBase64[E[4]];
      end;
    end;
  end;
end;

function B642Str(instr: TStream): TStream;
var
  S2: TMemoryStream;
  A1: array[1..4] of Byte;
  B1: array[1..3] of Byte;
  Byte_Ptr,Real_Bytes: Integer;
  B: Byte;
  C: Char;
begin
  instr.Seek(0,soFromBeginning);
  S2:= TMemoryStream.Create;
  try
    Byte_Ptr:= Low(A1);
    while instr.Position < instr.Size do
    begin
      instr.ReadBuffer(C, SizeOf(C));
      if C > ' ' then
      begin
        case C of
          'A'..'Z': B:=Ord(C)-65;  {<65..90>  --> <0..25>}
          'a'..'z': B:=Ord(C)-71;  {<97..122>  --> <26..51>}
          '0'..'9': B:=Ord(C)+4;   {<48..57>  --> <52..61>}
          '+': B:=62;{43}
          '/': B:=63;{47}
        else
          {'=': }B:=64;{61}
        end;
        A1[Byte_Ptr]:= B;
        Inc(Byte_Ptr);
        if Byte_Ptr=High(A1)+1 then
        begin
          Byte_ptr:=Low(A1);
          Real_Bytes:=3;
          if A1[1]=64 then Real_Bytes:=0;
          if A1[3]=64 then
          begin
            a1[3]:=0;
            a1[4]:=0;
            real_bytes:=1;
          end;
          if a1[4]=64 then
          begin
            a1[4]:=0;
            real_bytes:=2;
          end;
          b1[1]:=a1[1]*4+(a1[2] div 16);
          b1[2]:=(a1[2] mod 16)*16+(a1[3]div 4);
          b1[3]:=(a1[3] mod 4)*64 +a1[4];
          S2.WriteBuffer(b1, real_bytes);
        end;
      end;
    end;
  finally
    result := S2;
    result.Seek(0,soFromBeginning);
  end;
end;

{ TVProperty }

constructor TVProperty.Create(Owner: TVBaseObj);
begin
  inherited Create;;

  FOwner := Owner;

  FIsSet := False;

  FPropertyParams := TStringList.Create;
  FPropertyParams.Delimiter := ';';
  (FPropertyParams as TStringList).CaseSensitive := False;
end;

destructor TVProperty.Destroy;
begin
  FPropertyParams.Free;

  inherited;
end;

procedure TVProperty.Clear;
begin
  FIsSet := False;

  FPropertyName := '';
  FPropertyValue := '';
  if FPropertyParams <> nil then FPropertyParams.Clear;
end;

function TVProperty.GetText: WideString;
begin
  Result := '';

  if FIsSet then
  begin
    Result := PropertyName;
    if PropertyParams.Count <> 0 then
      Result := Result + ';' + LongStringToWideString(PropertyParams.DelimitedText);
    Result := Result + ':' + PropertyValue;
  end;
end;

procedure TVProperty.SetText(const Value: WideString);
  var
    PropText: String;
    StrLen: Integer;
    ParamStart, ParamEnd: Integer;
begin
  PropText := Trim(Value);
  StrLen := Length(PropText);

  if StrLen > 0 then
  begin
    FIsSet := True;

    ParamStart := Pos(';', PropText);
    ParamEnd := Pos(':', PropText);

    if (ParamStart = 0) or (ParamStart > ParamEnd) then
    begin
      ParamStart := ParamEnd;
      PropertyParams.Text := '';
    end
    else PropertyParams.DelimitedText := UpperCase(Copy(PropText, ParamStart + 1, ParamEnd - ParamStart - 1));

    PropertyName := UpperCase(Copy(PropText, 1, ParamStart - 1));
    PropertyValue := LongStringToWideString(Copy(PropText, ParamEnd + 1, StrLen - ParamEnd));

  end
  else FIsSet := False;
end;

function TVProperty.GetEncodedText: WideString;
  var
    strTemp: WideString;
begin
  Result := '';

  if FIsSet then
  begin
    Result := PropertyName;

    strTemp := PropertyValue;

    if Owner <> nil then
    begin
      if Owner.OutputCharSet <> tecNone then
      begin
        if (GetParamIndex('UTF-8') < 0) and (GetParamIndex('QUOTED-PRINTABLE') < 0) then
        begin
          strTemp := LongStringToWideString(WideStringToUTF8(PropertyValue));
          if (Owner.OutputCharSet <> tecUtf8) or (strTemp = PropertyValue) then
          begin
            strTemp := LongStringToWideString(Str2QP(WideStringToLongString(PropertyValue)));
            if PropertyValue <> strTemp then Result := Result + ';ENCODING=QUOTED-PRINTABLE';
          end
          else Result := Result + ';CHARSET=UTF-8';
        end;
      end;
    end;

    if PropertyParams.Count <> 0 then
      Result := Result + ';' + LongStringToWideString(PropertyParams.DelimitedText);
    Result := Result + ':' + strTemp;
  end;
end;

procedure TVProperty.SetEncodedText(const Value: WideString);
begin
  Text := Value;

  CheckUTFs;
end;

function TVProperty.GetPropertyName: WideString;
begin
  Result := FPropertyName;
end;

procedure TVProperty.SetPropertyName(const Value: WideString);
begin
  FPropertyName := Value;
end;

function TVProperty.GetPropertyValue: WideString;
begin
  Result := FPropertyValue;
end;

procedure TVProperty.SetPropertyValue(const Value: WideString);
begin
  FIsSet := False;
  FPropertyValue := Value;

  if FPropertyValue <> '' then FIsSet := True;
end;

procedure TVProperty.SetPropertyParams(const Value: TStrings);
begin
  FPropertyParams.DelimitedText := Value.DelimitedText;
end;

procedure TVProperty.CheckUTFs;
  var
    Index: Integer;
begin
  Index := GetParamIndex('UTF-7');
  if Index >= 0 then
  begin
    PropertyValue := UTF7ToWideString(WideStringToLongString(PropertyValue));
    PropertyParams.Delete(Index);
    Exit;
  end;

  Index := GetParamIndex('UTF-8');
  if Index >= 0 then
  begin
    PropertyValue := UTF8StringToWideString(WideStringToLongString(PropertyValue));
    PropertyParams.Delete(Index);
    Exit;
  end;
end;

function TVProperty.GetParamIndex(const Value: WideString): Integer;
  var
    I: Integer;
begin
  Result := -1;

  for I := Pred(PropertyParams.Count) downto 0 do
  begin
    if Pos(Value, PropertyParams[I]) <> 0 then
    begin
      Result := I;
      Break;
    end
  end;
end;

{ TVEntityType }

procedure TVEntityType.SetEntityType(const Value: TVType);
begin
  FEntityType := Value;

  FIsSet := Value <> tenVUnknown;
end;

function TVEntityType.GetPropertyValue: WideString;
begin
  Result := '';

  if FIsSet then Result := VEntityType[Ord(FEntityType)];
end;

procedure TVEntityType.SetPropertyValue(const Value: WideString);
  var
    Pos: Integer;
begin
  FIsSet := False;

  Pos := PosStrInArray(Value, VEntityType);

  if Pos < 0 then FEntityType := tenVUnknown
  else begin
    FEntityType := TVType(Pos);
    FIsSet := True;
  end;
end;

{ TVBaseObj }

const VObjProperties : array [0..1] of WideString = (
  'VERSION',
  // FMA Specific
  'X-FMA-STATE'
);

constructor TVBaseObj.Create;
begin
  inherited;

  FOwner := nil;

  isDestroying := False;

  FItemIndex := -1;
  FItemCounter := 0;

  VType := TVEntityType.Create(Self);
  VFmaState := 3;

  FStrList := TStringList.Create;
end;

destructor TVBaseObj.Destroy;
begin
  isDestroying := True;

  FOwner := nil;

  VType.Free;
  FStrList.Free;

  inherited;
end;

procedure TVBaseObj.Clear;
begin
  inherited;

  if not isDestroying then
  begin
    FItemIndex := 0;
    FItemCounter := 0;

    VType.IsSet := False;
    VVersion := '';
    VFmaState := 3;

    FStrList.Clear;
  end;
end;

function TVBaseObj.Add(AVObj: TVBaseObj): Integer;
begin
  Result := inherited Add(AVObj);

  AVObj.FItemIndex := FItemCounter;
  AVObj.FOwner := Self;
  Inc(FItemCounter);
end;

function TVBaseObj.GetRaw: TStrings;
  var
    I: Integer;
    AItem: TVBaseObj;
    OutStrList: TStrings;
begin
  OutStrList := TStringList.Create;

  OutStrList.Add('BEGIN:' + VType.PropertyValue);

  if VVersion <> '' then OutStrList.Add('VERSION:' + VVersion);
  if FStrList.Text <> '' then OutStrList.Add(TrimRight(FStrList.Text));
  if VFmaState <> 3 then OutStrList.Add('X-FMA-STATE:' + IntToStr(VFmaState));

  for I := 0 to Count - 1 do
  begin
    AItem := (Items[I] as TVBaseObj);

    OutStrList.Add(TrimRight(AItem.Raw.Text));
  end;

  OutStrList.Add('END:' + VType.PropertyValue);

  FStrList.Text := OutStrList.Text;
  Result := FStrList;

  OutStrList.Free;
end;

procedure TVBaseObj.SetRaw(const Value: TStrings);
  var
    CurrPos: Integer;
    EmbeddedStrList: TStrings;
    Prop: TVProperty;
    AItem: TVBaseObj;
    isEmbedded: Boolean;
    QPData: String;
begin
  Clear;

  EmbeddedStrList := TStringList.Create;
  Prop := TVProperty.Create(Self);

  CurrPos := 0;
  while CurrPos < Value.Count do
  begin
    Prop.Text := Value[CurrPos];

    // Decode QP
    if Pos('QUOTED-PRINTABLE', Prop.PropertyParams.Text) > 0 then
    begin
      // remove of SoftLineBreakes if any
      QPData := RemoveSoftLineBreakes(Prop.PropertyValue, Value, CurrPos);

      // Convert QP to Str
      Prop.PropertyValue := QP2Str(QPData);

      // Remove QP param
      try
        Prop.PropertyParams.Delete(Prop.GetParamIndex('QUOTED-PRINTABLE'))
      except
      end;
    end;

    if pos('BEGIN', Prop.PropertyName) = 1 then
    begin
      // Is embedded
      if CurrPos > 0 then
      begin
        EmbeddedStrList.Clear;

        isEmbedded := True;
        while isEmbedded and (CurrPos < Value.Count) do
        begin
          EmbeddedStrList.Add(Value[CurrPos]);

          if Pos('END:' + Prop.PropertyValue, Value[CurrPos]) = 1 then isEmbedded := False;

          Inc(CurrPos);
        end;

        Dec(CurrPos);

        AItem := CreateVObject(Prop.PropertyValue);
        if AItem <> nil then
        begin
          AItem.Raw := EmbeddedStrList;

          Add(AItem);
        end;
      end
      else begin
        VType.Text := Prop.Text;
      end;
    end
    else begin
      // If end is found, break loop
      if (pos('END', Prop.PropertyName) = 1) and (Prop.PropertyValue = VType.PropertyValue) then break;

      Prop.PropertyValue := Prop.PropertyValue + UnfoldLines(Value, CurrPos);
      Prop.CheckUTFs;
      SetProperty(Prop);
    end;

    Inc(CurrPos);
  end;

  EmbeddedStrList.Free;
  Prop.Free;
end;

function TVBaseObj.UnfoldLines(Value: TStrings; var CurrPos: Integer): String;
begin
  Result := '';
  Inc ( CurrPos );
  while (CurrPos < Value.Count) and ((Length(Value[CurrPos] ) > 0) and
    (Value[CurrPos][1] = ' ' )) do
  begin
    Result := Result + ' ' + Trim(Value[CurrPos]);
    Inc(CurrPos);
  end;
  // Correct for increment in the main while loop
  Dec(CurrPos);
end;

function TVBaseObj.RemoveSoftLineBreakes(Value1: String; Value: TStrings; var CurrPos: Integer): String;
begin
  { schnorbsl: now check for softbreaklines }
  Result := Value1;
  Inc(CurrPos);
  while (CurrPos < Value.Count) and ((Length(Result) > 0) and
    (Result[Length(Result)] = '=' ))  do
  begin
    Result := copy (Result, 1, Length(Result)-1) + Value[CurrPos];
    Inc(CurrPos);
  end;
  // Correct for increment in the main while loop
  Dec(CurrPos);
end;

procedure TVBaseObj.SetProperty(AProp: TVProperty);
begin
  case PosStrInArray(AProp.PropertyName, VObjProperties) of
    // VERSION
    0: VVersion := AProp.PropertyValue;
    // X-FMA-STATE
    1: VFmaState := StrToInt(AProp.PropertyValue);
  end;
end;

function TVBaseObj.GetByItemIndex(const Value: Integer): TVBaseObj;
  var
    I: Integer;
    AVObj: TVBaseObj;
begin
  Result := nil;
  for I := 0 to Count - 1 do
  begin
    AVObj := TVBaseObj(Items[I]);
    if AVObj.ItemIndex = Value then
    begin
      Result := AVObj;
      Exit;
    end;
  end;
end;

function TVBaseObj.GetCalCharSet: TVCalCharSet;
begin
  if Owner <> nil then Result := Owner.OutputCharSet
  else Result := FCalCharSet;
end;

{ TVObjStorage }

constructor TVObjStorage.Create;
begin
  inherited;

  isDestroying := False;

  FItemCounter := 0;
  FStrList := TStringList.Create;
end;

destructor TVObjStorage.Destroy;
begin
  isDestroying := True;

  FStrList.Free;
  
  inherited;
end;

procedure TVObjStorage.Clear;
begin
  inherited;

  if not isDestroying then
  begin
    FItemCounter := 0;
    FStrList.Clear;
  end;
end;

function TVObjStorage.Add(AVObj: TVBaseObj): Integer;
begin
  Result := inherited Add(AVObj);

  AVObj.FItemIndex := FItemCounter;
  Inc(FItemCounter);
end;

function TVObjStorage.GetRaw: TStrings;
  var
    I: Integer;
    AItem: TVBaseObj;
begin
  FStrList.Clear;

  for I := 0 to Count - 1 do
  begin
    AItem := (Items[I] as TVBaseObj);

    FStrList.Add(TrimRight(AItem.Raw.Text));
  end;

  Result := FStrList;
end;

procedure TVObjStorage.SetRaw(const Value: TStrings);
  var
    CurrPos: Integer;
    EmbeddedStrList: TStrings;
    Prop: TVProperty;
    AItem: TVBaseObj;
    isEmbedded: Boolean;
begin
  Clear;

  EmbeddedStrList := TStringList.Create;
  Prop := TVProperty.Create(nil);

  CurrPos := 0;
  while CurrPos < Value.Count do
  begin
    Prop.Text := Value[CurrPos];

    if pos('BEGIN', Prop.PropertyName) = 1 then
    begin
      // Is embedded
      isEmbedded := True;
      EmbeddedStrList.Clear;
      while isEmbedded and (CurrPos < Value.Count) do
      begin
        EmbeddedStrList.Add(Value[CurrPos]);

        if Pos('END:' + Prop.PropertyValue, Value[CurrPos]) = 1 then isEmbedded := False;

        Inc(CurrPos);
      end;

      Dec(CurrPos);

      AItem := CreateVObject(Prop.PropertyValue);
      if AItem <> nil then
      begin
        AItem.Raw := EmbeddedStrList;

        Add(AItem);
      end;
    end;

    Inc(CurrPos);
  end;

  EmbeddedStrList.Free;
  Prop.Free;
end;

procedure TVObjStorage.SaveToFile(const FileName: string);
begin
  Raw.SaveToFile(FileName);
end;

procedure TVObjStorage.LoadFromFile(const FileName: string);
  var
    sl: TStrings;
begin
  sl := TStringList.Create;

  sl.LoadFromFile(FileName);
  Raw := sl;

  sl.Free;
end;

function TVObjStorage.CreateVObject(Value: WideString): TVBaseObj;
begin
  Result := nil;

  case PosStrInArray(Value, VEntityType) of
    // VCARD
// Temporary removed
//    1: Result := TVCard.Create;
    // VCALENDAR
    2: Result := TVCalendar.Create;
  end;
end;

end.
