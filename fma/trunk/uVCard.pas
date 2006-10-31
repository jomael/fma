unit uVCard; // do not localize

{
*******************************************************************************
* Descriptions: vCard object implementaton
* $Source: /cvsroot/fma/fma/uVCard.pas,v $
* $Locker:  $
*
* Todo:
*   - explore source for comments
*
* Change Log:
* $Log: uVCard.pas,v $
*
}

interface

uses Classes, TntClasses, SysUtils, TntSysUtils, Jpeg, RxGif, Graphics, TntGraphics;

type
  TPostalAddress = record
    Street: Widestring;
    City: Widestring;
    Region: Widestring;
    PostalCode: Widestring;
    Country: Widestring;
  end;

  TVCard = class(TObject)
  private
    { Private declarations }
    Grouping,PropertyName: Widestring;
    sl,mails: TStringList;
    function GetRaw: TStrings;
    procedure SetRaw(const ValueRaw: TStrings);
    procedure setProperty(Value: String);
    procedure checkPropertyParams(value:String);
    procedure RemoveSoftLineBrakes(var Value: TStringList);
    function DecodePropertyValue(const PParams, PValue: String): WideString;
    function GetLDIF: TStrings;
    function GetMail: TStrings;
    procedure SetMail(const Value: TStrings);
  public
    { Public declarations }
    Name: Widestring;
    TelWork: Widestring;
    TelHome: Widestring;
    TelFax: Widestring;
    TelCell: Widestring;
    TelOther: Widestring;
    URL: Widestring;
    Email: Widestring;
    Title: Widestring;
    Org: Widestring;
    LUID: Widestring;
    VType: Widestring;
    Version: Widestring;
    PhotoType: Integer;
    Photo: TGraphic;
    Surname: Widestring;
    DisplayName: Widestring;
    FullName: Widestring;
    Notes: Widestring;
    TelPref: string; // H = HOME, W = Work, F = Fax, M = CELL, O = Other
    UID: string;
    ModifiedDate: TDateTime;
    HomeAddress: TPostalAddress;
    WorkAddress: TPostalAddress;
    BDay: TDateTime;
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function LoadFromLDIF(ldif: TStrings): boolean;
  published
    property Raw: TStrings read GetRaw write SetRaw;
    property MoreEmails: TStrings read GetMail write SetMail;
    property LDIF: TStrings read GetLDIF;
  end;

var
    IsQP : boolean;     // QuotedPrintable
    IsUTF7 : boolean;   // UTF7
    IsUTF8 : boolean;   // UTF8

implementation

uses
  cUnicodeCodecs, uGlobal,
  Unit1, TntSystem, uVBase, uLogger, Variants;

{ TVCard }

procedure TVCard.Clear;
begin
    Name:='';
    Surname := '';
    TelPref := '';
    TelWork:='';
    TelHome:='';
    TelFax:='';
    TelCell:='';
    Email:='';
    TelOther:='';
    Title:='';
    Org:='';
    LUID:='';
    VType:='';
    Version:='';
    DisplayName := '';
    Grouping := '';
    PropertyName := '';
    UID := '';
    Notes := '';
    URL := '';
    HomeAddress.Street:='';
    HomeAddress.City:='';
    HomeAddress.Region:='';
    HomeAddress.PostalCode:='';
    HomeAddress.Country:='';
    WorkAddress.Street:='';
    WorkAddress.City:='';
    WorkAddress.Region:='';
    WorkAddress.PostalCode:='';
    WorkAddress.Country:='';
    ModifiedDate := EmptyDate;
    BDay := EmptyDate;
    PhotoType := 0;
    FreeAndNil(Photo);
    mails.Clear;
    sl.Clear;
end;

constructor TVCard.Create;
begin
  inherited;
  sl := TStringList.Create;
  mails := TStringList.Create;
end;

destructor TVCard.Destroy;
begin
  Clear;
  mails.Free;
  sl.Free;
  inherited;
end;

function TVCard.GetRaw: TStrings;
var
  strTemp : string;
  strN : WideString;
  i: integer;
  bY,bM,bD: word;
  //tz: TTimeZoneInformation;
  procedure slAddAdr(AName: string; Adr: TPostalAddress);
  var
    Str: WideString;
  begin
    with Adr do begin
      Str := Street + City + Region + PostalCode + Country;
      if Trim(Str) <> '' then begin
        strTemp :=  WideStringToUTF8(Str);
        if not Form1.FUseUTF8 or (strTemp = Str) then begin
          strTemp := Str2QP(Str);
          if strTemp = Str then
            sl.add('ADR;'+AName+':;;' + Street + ';' + City + ';' + Region + ';' + PostalCode + ';' + Country)
          else
            sl.Add('ADR;ENCODING=QUOTED-PRINTABLE;'+AName+':;;' + Str2QP(Street) + ';' + Str2QP(City) + ';' +
              Str2QP(Region) + ';' + Str2QP(PostalCode) + ';' + Str2QP(Country));
        end
        else
          sl.Add('ADR;CHARSET=UTF-8;'+AName+':;;' + WideStringToUTF8(Street) + ';' + WideStringToUTF8(City) + ';' +
            WideStringToUTF8(Region) + ';' + WideStringToUTF8(PostalCode) + ';' + WideStringToUTF8(Country));
      end;
    end;
  end;
begin
  sl.Clear;
  if VType = '' then
     sl.Add('BEGIN:VCARD')
  else
     sl.Add('BEGIN:' + VType);

  if Version = '' then
     sl.Add('VERSION:2.1')
  else
     sl.Add('VERSION:' + Version);

  { remove old name/surname from fullname }
  strN := FullName;
  i := Pos(';',strN);
  if i <> 0 then Delete(strN,1,i);
  i := Pos(';',strN);
  if i = 0 then i := Length(strN);
  Delete(strN,1,i);
  { add new ones to fullname }
  FullName := Surname + ';' + Name;
  if strN <> '' then
    FullName := FullName + ';' + strN;
  strN := FullName;

  strTemp := WideStringToUTF8(strN);
  if not Form1.FUseUTF8 or (strTemp = strN) then begin
    strTemp := Str2QP(strN);
    if strN = strTemp then
       sl.add('N:' + strN)
    else
       sl.Add('N;ENCODING=QUOTED-PRINTABLE:' + strTemp);
  end else
    sl.Add('N;CHARSET=UTF-8:' + strTemp);

  if DisplayName = '' then begin
    { build default 'file as' field }
    DisplayName := Name;
    if Surname <> '' then
      DisplayName := DisplayName + ' ' + Surname;
    if Name = '' then
      DisplayName := Surname;
  end;
  if DisplayName <> '' then begin
    strTemp := WideStringToUTF8(DisplayName);
    if not Form1.FUseUTF8 or (strTemp = DisplayName) then begin
      strTemp := Str2QP(DisplayName);
      if DisplayName = strTemp then
         sl.add('FN:' + DisplayName)
      else
         sl.Add('FN;ENCODING=QUOTED-PRINTABLE:' + strTemp);
    end else
      sl.Add('FN;CHARSET=UTF-8:' + strTemp);
  end;

  if Notes <> '' then begin
     strTemp := WideStringToUTF8(Notes);
     if not Form1.FUseUTF8 or (strTemp = Notes) or (Pos(#13,Notes) <> 0) then begin
       strTemp := Str2QP(Notes);
       if Notes = strTemp then
          sl.add('NOTE:' + Notes)
       else
          sl.Add('NOTE;ENCODING=QUOTED-PRINTABLE:' + strTemp);
     end else
       sl.Add('NOTE;CHARSET=UTF-8:' + strTemp);
  end;

  if Title <> '' then begin
     strTemp := WideStringToUTF8(Title);
     if not Form1.FUseUTF8 or (strTemp = Title) then begin
       strTemp := Str2QP(Title);
       if Title = strTemp then
          sl.add('TITLE:' + Title)
       else
          sl.Add('TITLE;ENCODING=QUOTED-PRINTABLE:' + strTemp);
     end else
       sl.Add('TITLE;CHARSET=UTF-8:' + strTemp);
  end;

  if Org <> '' then begin
     strTemp := WideStringToUTF8(Org);
     if not Form1.FUseUTF8 or (strTemp = Org) then begin
       strTemp := Str2QP(Org);
       if Org = strTemp then
          sl.add('ORG:' + Org)
       else
          sl.Add('ORG;ENCODING=QUOTED-PRINTABLE:' + strTemp);
     end else
       sl.Add('ORG;CHARSET=UTF-8:' + strTemp);
  end;

  if Email <> '' then
    sl.add('EMAIL;INTERNET;PREF:' + Email);
  for i := 0 to mails.Count-1 do
    sl.add('EMAIL;INTERNET:' + mails[i]);

  if BDay <> EmptyDate then begin
    DecodeDate(BDay,bY,bM,bD);
    sl.add(Format('BDAY:%.4d%.2d%.2d',[bY,bM,bD]));
  end;

  if URL <> '' then begin
    strTemp := WideStringToUTF8(URL);
    if not Form1.FUseUTF8 or (strTemp = URL) then begin
       strTemp := Str2QP(URL);
       if URL = strTemp then
          sl.add('URL:' + URL)
       else
          sl.Add('URL;ENCODING=QUOTED-PRINTABLE:' + strTemp);
     end else
       sl.Add('URL;CHARSET=UTF-8:' + strTemp);
  end;

  if TelHome <> '' then begin
    if TelPref <> 'H' then
      sl.add('TEL;HOME:' + TelHome)
    else
      sl.add('TEL;HOME;PREF:' + TelHome)
  end;
  if TelWork <> '' then begin
    if TelPref <> 'W' then
      sl.add('TEL;WORK:' + TelWork)
    else
      sl.add('TEL;WORK;PREF:' + TelWork)
  end;
  if TelCell <> '' then begin
    if TelPref <> 'M' then
      sl.add('TEL;CELL:' + TelCell)
    else
      sl.add('TEL;CELL;PREF:' + TelCell)
  end;
  if TelFax <> '' then begin
    if TelPref <> 'F' then
      sl.add('TEL;FAX:' + TelFax)
    else
      sl.add('TEL;FAX;PREF:' + TelFax)
  end;
  if TelOther <> '' then begin
    if TelPref <> 'O' then
      sl.add('TEL:' + TelOther)
    else
      sl.add('TEL;PREF:' + TelOther)
  end;

  slAddAdr('HOME',HomeAddress);
  slAddAdr('WORK',WorkAddress);

  // TODO: Optional, add support for photo image

  if UID <> '' then begin
     sl.add('UID:' + UID)
  end;

  if LUID <> '' then begin
     sl.add('X-IRMC-LUID:' + LUID)
  end;

  // REV:20040701T095208Z
  if ModifiedDate <> EmptyDate then begin
    sl.add('REV:'+FormatDateTime('yyyymmdd"T"hhnnss',ModifiedDate)); // Add "Z" for UTC
  end;

  if VType = '' then
     sl.Add('END:VCARD')
  else
     sl.Add('END:' + VType);
  Result := sl;
end;

procedure TVCard.setProperty(Value: String);
const
  ValueRaw: String = '';
var
  grp,grpdescr,nmedescr: String;
  PName,PParams,PValue:String;   // Schnorbsl : P stands for property
  PWValue, str: WideString;
  i,j,k: integer;

  function IsField(FName,Value: string): boolean;
  var
    i,j: integer;
  begin
    i := Length(FName);
    j := Length(Value);
    Result := (Pos(FName,Value) = 1) and ((i = j) or
      (Value[i+1] in [';',':']) or (FName[i] in [';',':']));
  end;

  procedure ProcessAdr(AName: string; var Adr: TPostalAddress; var Value: WideString);
  begin
    with Adr do
      if Pos(AName,PParams) <> 0 then begin
          str := Value;

          // skip POST OFFICE ADDRESS
          if pos(';', str) > 0 then
             str := copy(str, pos(';', str) + 1, length(str));
          // skip EXTENDED ADDDRESS
          if pos(';', str) > 0 then
             str := copy(str, pos(';', str) + 1, length(str));
          // Street
          if pos(';', str) > 0 then begin
             Street := copy(str, 0, pos(';', str) - 1);
             str := copy(str, pos(';', str) + 1, length(str));
          end;
          // City
          if pos(';', str) > 0 then begin
             City := copy(str, 0, pos(';', str) - 1);
             str := copy(str, pos(';', str) + 1, length(str));
          end;
          // Region
          if pos(';', str) > 0 then begin
             Region := copy(str, 0, pos(';', str) - 1);
             str := copy(str, pos(';', str) + 1, length(str));
          end;
          // PostalCode
          if pos(';', str) > 0 then begin
             PostalCode := copy(str, 0, pos(';', str) - 1);
             str := copy(str, pos(';', str) + 1, length(str));
          end;
          // Country
          if pos(';', str) > 0 then
             Country := copy(str, 0, pos(';', str) - 1)
          else if length(str) > 0 then
             Country := str;
      end;
  end;

  procedure ProcessRaw(var Value: String);
  begin
    { find start pos-1 of propery value : k }
    k := Pos(':',Value);
    PValue := Copy(Value,k+1,length(Value));
    // delete PValue part
    Value := Copy(Value,1,k-1);

    { find end pos+1 of propery name : j }
    j := Pos(';',Value);
    { find start pos-1 of propery name : i }
    i := Pos('.',Value);
    if i > j then i := 0; // no group
    if j = 0 then j := length(value)+1;

    { get grouping name, if any }
    grp := UpperCase(Copy(Value,1,i-1));
    grpdescr := Copy(Value,i+1,length(Value));

    { get property name }
    PName := UpperCase(Copy(Value,i+1,j-i-1));

    { get full name (with desctiptions) }
    nmedescr := Copy(Value,i+1,k-i-1);
    PParams := Copy(Value,j+1,k-j-1);
    { remove grouping, leave property name at the begining of Value }
    Delete(Value,1,i);
    { value should now start with property name }

    { keep values }
    if Grouping = grp then begin
      {
      The grouping of a comment property with a telephone property is shown in the following example:

      A.TEL;HOME:+1-213-555-1234
      A.NOTE:This is my vacation home

      In this case PropertyName="TEL;HOME", Grouping="A", nme="NOTE", grpdescr="This is my vacation home"
      }
      // TODO: use grouping description somehow
    end
    else
      Grouping := grp;
    PropertyName := nmedescr;

    if CompareStr('BEGIN',PName) = 0 then
      Vtype := PValue
    else if CompareStr('VERSION',PName) = 0 then
      Version := PValue

    else if CompareStr('N',PName) = 0 then begin
      {  Schnorbsl : check and decode in this order 'QP', 'UTF-7', 'UTF-8' }
      // check for params
      PWValue := DecodePropertyValue(PParams,PValue);
      // PWValue should now contain decoded value (widestring)

      if Pos(';',PWValue) <> 0 then begin
        Surname := GetFirstToken(PWValue,';');
        Name := PWValue;
      end
      else begin
        Surname := '';
        Name := PWValue;
      end;
      // VCard.FullName is not really used, but to be on save side it is set up here
      FullName := Name + ';' + Surname;
    end

    else if CompareStr('FN',PName) = 0 then begin
      {  Schnorbsl : check and decode in this order 'QP', 'UTF-7', 'UTF-8' }
      // check for params
      PWValue := DecodePropertyValue(PParams,PValue);
      // PWValue should now contain decoded value (widestring)
      DisplayName := PWValue;
    end

    else if  CompareStr('TEL',PName) = 0 then begin
      {  Schnorbsl : normally TEL should be not encoded, but will do check nevertheless }
      {  Schnorbsl : check and decode in this order 'QP', 'UTF-7', 'UTF-8' }
      // check for params
      PWValue := DecodePropertyValue(PParams,PValue);
      // PWValue should now contain decoded value (widestring)
      if Pos('WORK',PParams) <> 0 then begin
        if Pos('PREF',PParams) <> 0 then TelPref := 'W';
        TelWork := PWValue;
      end
      else if Pos('HOME',PParams) <> 0 then begin
        if Pos('PREF',PParams) <> 0 then TelPref := 'H';
        TelHome := PWValue;
      end
      else if Pos('FAX',PParams) <> 0 then begin
        if Pos('PREF',PParams) <> 0 then TelPref := 'F';
        TelFax := PWValue;
      end
      else if Pos('CELL',PParams) <> 0 then begin
        if Pos('PREF',PParams) <> 0 then TelPref := 'M';
        TelCell := PWValue;
      end
      { phone type not specified }
      { all other types or none type }
      else begin
        if Pos('PREF',PParams) <> 0 then TelPref := 'O';
        TelOther := PWValue;
      end;
    end

    else if CompareStr('TITLE',PName) = 0 then begin
      {  Schnorbsl : check and decode in this order 'QP', 'UTF-7', 'UTF-8' }
      // check for params
      PWValue := DecodePropertyValue(PParams,PValue);
      // PWValue should now contain decoded value (widestring)
      Title := PWValue;
    end

    else if CompareStr('ORG',PName) = 0 then begin
      {  Schnorbsl : check and decode in this order 'QP', 'UTF-7', 'UTF-8' }
      // check for params
      PWValue := DecodePropertyValue(PParams,PValue);
      // PWValue should now contain decoded value (widestring)
      Org := PWValue;
    end

    else if CompareStr('EMAIL',PName) = 0 then begin
      // TODO: Add support for several e-mail addresses
      {  Schnorbsl : check and decode in this order 'QP', 'UTF-7', 'UTF-8' }
      // check for params
      PWValue := DecodePropertyValue(PParams,PValue);
      // PWValue should now contain decoded value (widestring)
      if Pos('INTERNET',PParams) <> 0 then begin
        if Pos('PREF',PParams) <> 0 then
          Email := PWValue
        else
          mails.Add(PWValue);
      end;
    end

    { BDAY:19730205 }
    else if CompareStr('BDAY',PName) = 0 then begin
      PWValue := DecodePropertyValue(PParams,PValue);
      BDay := EncodeDate(StrToInt(Copy(PWValue,1,4)),StrToInt(Copy(PWValue,5,2)),StrToInt(Copy(PWValue,7,2)));
    end

    { URL;CHARSET=UTF-8:http://www.5group.com }
    else if CompareStr('URL',PName) = 0 then begin
      PWValue := DecodePropertyValue(PParams,PValue);
      URL := PWValue;
    end

    { NOTE;CHARSET=UTF-8:Me me me }
    else if CompareStr('NOTE',PName) = 0 then begin
      {  Schnorbsl : check and decode in this order 'QP', 'UTF-7', 'UTF-8' }
      // check for params
      PWValue := DecodePropertyValue(PParams,PValue);
      // PWValue should now contain decoded value (widestring)
      Notes := PWValue;
    end

    else if CompareStr('ADR',PName) = 0 then begin
      {  Schnorbsl : check and decode in this order 'QP', 'UTF-7', 'UTF-8' }
      // check for params
      PWValue := DecodePropertyValue(PParams,PValue);
      // PWValue should now contain decoded value (widestring)

      ProcessAdr('HOME',HomeAddress,PWValue);
      ProcessAdr('WORK',WorkAddress,PWValue);
    end

    { TODO: Add ModifiedDate support }
    // REV:20040701T095208Z

    else if CompareStr('UID',PName) = 0 then begin
      {  Schnorbsl : check and decode in this order 'QP', 'UTF-7', 'UTF-8' }
      // check for params
      PWValue := DecodePropertyValue(PParams,PValue);
      // PWValue should now contain decoded value (widestring)
      UID := PWValue;
    end

    else if CompareStr('X-IRMC-LUID',PName) = 0 then begin
      {  Schnorbsl : check and decode in this order 'QP', 'UTF-7', 'UTF-8' }
      // check for params
      PWValue := DecodePropertyValue(PParams,PValue);
      // PWValue should now contain decoded value (widestring)
      LUID := PWValue;
    end;

    Value := '';
  end;
begin
  { unfold a vCard raw, if needed }
  if Value = '' then begin
    if ValueRaw <> '' then ProcessRaw(ValueRaw); // this will clear ValueRaw
  end
  else begin
    if Value[1] = ' ' then begin
      {
      Individual lines within the vCard data stream are delimited by the (RFC 822) line break,
      which is a CRLF sequence (ASCII decimal 13, followed by ASCII decimal 10). Long lines
      of text can be split into a multiple-line representation using the RFC 822 "folding"
      technique. That is, wherever there may be linear white space (NOT simply LWSP-chars),
      a CRLF immediately followed by at least one LWSP-char may instead be inserted.
      For example the line:

      NOTE:This is a very long description that exists on a long line.

      Can be represented as:

      NOTE:This is a very long description
        that exists on a long line.

      The process of moving from this folded multiple-line representation of a property definition
      to its single line representation is called "unfolding". Unfolding is accomplished by regarding
      CRLF immediately followed by a LWSP-char as equivalent to the LWSP-char.
      }
      ValueRaw := ValueRaw + ' ' + TrimLeft(Value);
      exit;
    end
    else begin
      if ValueRaw <> '' then ProcessRaw(ValueRaw);
      ValueRaw := Value;
    end;
  end;
end;

procedure TVCard.SetRaw(const ValueRaw: TStrings);
var
  i: Integer;
  s: string;
  isAgent,isBody,isPhoto,isPhotoQP: boolean;
  PhotoStream: TStream;
  stream: TStream;
  Value : TStringList;
begin
  Clear;
  isAgent := False;
  isBody := False;
  isPhoto := False;
  isPhotoQP := False; // default is BASE64
  PhotoStream := nil;

  // Schnorbsl : copy now const ValueRaw to var Value, further processing is done with Value
  Value := TStringList.Create;
  Value.Text := ValueRaw.Text;

  // Schnorbsl 2005-09-05:
  // on "remove SoftLineBrakes" and "Unfolding"
  // order should be: 1st remove of SoftLineBrakes and then unfolding,
  //       otherwise there might still be some problems.
  //       Unfolding is done (as in previous versions) in uVCard.pas setProperty

  // Schnorbsl : check and remove SoftLineBrakes, if any (whole stream).
  RemoveSoftLineBrakes(Value);

  { Process incoming data }
  for i := 0 to Value.Count - 1 do begin
    { check for nested vCard (Agent) into specified vCard }
    if pos('AGENT', Value.Strings[i]) = 1 then isAgent := True;
    if isAgent then begin
      {
      This property specifies information about another person who will act on behalf of the vCard object.
      Typically this would be an area administrator, assistant, or secretary for the individual. A key
      characteristic of the Agent property is that it represents somebody or something which is separately
      addressable.
      }
      // ignore Agent vCard!
      // SetProperty(Value.Strings[i]);
      if pos('END', Value.Strings[i]) = 1 then isAgent := False;
      Continue;
    end;

    if pos('BEGIN', Value.Strings[i]) = 1 then isBody := True
    else if pos('END', Value.Strings[i]) = 1 then isBody := False
    else if pos('PHOTO', Value.Strings[i]) = 1 then isPhoto :=True
    else if Value.Strings[i] = '' then
        isPhoto := False;

    if isBody then begin
        if isPhoto then begin
          if Pos('PHOTO', Value.Strings[i]) = 1 then begin
            { check image encoding }
            if Pos('TYPE=GIF', Value.Strings[i]) <> 0 then
              PhotoType := 1
            else if Pos('TYPE=JPEG', Value.Strings[i]) <> 0 then
              PhotoType := 2;
            {
            In the case of the vCard being transported within a MIME email message, the property value
            can be specified as being located in a separate MIME entity with the "Content-ID" value, or
            "CID" for short. In this case, the property value is the Content-ID for the MIME entity
            containing the property value. In addition, the property value can be specified as being
            located out on the network within some Internet resource with the "URL" value. In this case,
            the property value is the Uniform Resource Locator for the Internet resource containing the
            property value. The following specifies a value not located inline with the vCard but out
            in the Internet:

            PHOTO;VALUE=URL;TYPE=GIF:http://www.abc.com/dir_photos/my_photo.gif
            SOUND;VALUE=CONTENT-ID:<jsmith.part3.960817T083000.xyzMail@host1.com
            }
            if Pos('VALUE=URL', Value.Strings[i]) <> 0 then begin
              s := copy(Value.Strings[i], pos(':', Value.Strings[i]) + 1, length(Value.Strings[i]));
              if Pos('file:///',s) = 1 then begin
                Delete(s,1,8);
                try
                  PhotoStream := TFileStream.Create(s,fmOpenRead);
                except
                  PhotoType := 0; // ignore image on error (file not found etc.)
                end;
              end
              else
                // TODO: Add support for vCard external images (http)
                PhotoType := 0; // ignore image - not implemented
            end
            else if Pos('VALUE=CONTENT-ID', Value.Strings[i]) <> 0 then begin
              // TODO: Add support for vCard MIME content-id
              PhotoType := 0; // ignore image - not implemented
            end
            else begin
              { begin collecting image data... }
              isPhotoQP := Pos('QUOTED-PRINTABLE',Value.Strings[i]) <> 0;
              sl.Add(Trim(copy(Value.Strings[i], pos(':', Value.Strings[i]) + 1, length(Value.Strings[i]))));
            end;
          end
          else begin
            { ...adding more image data }
            sl.add(Trim(Value.Strings[i]));
          end;
        end
        else
          SetProperty(Value.Strings[i]);
    end;
  end;
  { Flush any unfolded vCard raw }
  SetProperty('');

  { check if photo image exists }
  stream := TMemoryStream.Create;
  try
    sl.SaveToStream(stream);
    sl.Clear;
    if (PhotoStream = nil) and (PhotoType <> 0) then begin
      if isPhotoQP then begin
        sl.Text := QP2Str(StringReplace(sl.Text,sLinebreak,'',[rfReplaceAll]));
        PhotoStream := TMemoryStream.Create;
        sl.SaveToStream(PhotoStream);
      end
      else
        PhotoStream := b642str(stream); // this will create a stream instance
    end;
    try
      case PhotoType of
        1: begin
            Photo := TGIFImage.Create;
            Photo.LoadFromStream(PhotoStream)
        end;
        2: begin
            Photo := TJPEGImage.Create;
            Photo.LoadFromStream(PhotoStream)
        end;
      end;
    finally
      PhotoStream.Free;
    end;
  finally
    stream.Free;
  end;  
end;


procedure TVCard.checkPropertyParams(value:String);
begin
  { "ENCODING" "=" "7BIT" / "8BIT" / "QUOTED-PRINTABLE" / "BASE64" / "X-" word
    "CHARSET"  "=" <a character set string as defined in Section 7.1 of RFC 1521>}
  IsQP := false;
  IsUTF7 := false;
  IsUTF8 := false;
  if Pos('QUOTED-PRINTABLE',value) <> 0 then IsQP := true;
  if Pos('UTF-7',value) <> 0 then IsUTF7 := true;
  if Pos('UTF-8',value) <> 0 then IsUTF8 := true;
end;

function TVCard.DecodePropertyValue(const PParams, PValue: String): WideString;
var
  s: String;
begin
  Result := '';
  checkPropertyParams(PParams);
  s := PValue;
  // first unquote if needed
  try
    if IsQP then s := QP2Str(s);
  except
    // just for the case there is a EConvertError we set the Value to '??convert_error??'
    // on EConvertError do PValue := '??convert_error??';
    Log.AddMessage('QP2Str: Convert error for "'+PValue+'".', lsDebug); // do not localize debug
  end;
  Result := LongStringToWideString(s);
  // now decode UTF7 if needed
  if IsUTF7 then Result := UTF7ToWideString(s);
  // now decode UTF8 if needed
  if IsUTF8 then Result := UTF8StringToWideString(s);
end;

  { Schnorbsl :
    Check and remove SoftLineBrakes, if any.
    Going throug VCard stram line by line it is checked whether QUOTED-PRINTABLE applies,
    if yes it is checked whether a SoftLineBrakes is there, if yes lines are concatenated
  }
procedure TVCard.RemoveSoftLineBrakes(var Value: TStringList);
var
  valueNew : TStringList;
  i : Integer;
  s : String;
begin
  valueNew := TStringList.Create;
  try
    i:=0;
    while i < Value.Count do begin
      s := Value[i];
      if (Pos('QUOTED-PRINTABLE',Value[i]) <> 0) then
        {if line ends with '=' concatenate with next line}
        {original next line can contain only CRLFCRLF, which TStringList
         would interpret as Value[i+1 && i+2]=''; so we will workaround this
         TODO: should we save this CRLF? (ie. Contact name could end with CRLF)}
        while (Value[i]<>'')and(Value[i][Length(Value[i])] = '=')and(i+1 < Value.Count) do begin
          Delete(s, Length(s), 1);
          Inc(i);
          s := s + Value[i];
        end;
      if (s<>'') then
        valueNew.Add(s);
      Inc(i);
    end;
    Value.Assign(ValueNew);
  finally
    valueNew.Free;
  end;
end;

function TVCard.LoadFromLDIF(ldif: TStrings):boolean;
var
  isB64Encoded, validPersonEntry: boolean;
  PValue, PName: WideString;
  temp: String;
  i,j,k: integer;

  function B64Value2WideStr(const Value: String):WideString;
  var B64Decoded: TStream;
      strStream: TStringStream;
  begin
    Result := '';
    B64Decoded := nil;
    strStream := TStringStream.Create(Value);
    try
      B64Decoded := B642Str(strStream);
      strStream.Position := 0;
      strStream.CopyFrom(B64Decoded, B64Decoded.Size);
      Result := UTF8StringToWideString(strStream.DataString);
    finally
      FreeAndNil(B64Decoded);
      FreeAndNil(strStream);
    end;
  end;

  procedure ProcessRaw(const Value: String);
  begin
    { determine b64 encoding }
    isB64Encoded := false;
    k := Pos(':',Value);
    if k=0 then Exit;
    if Length(Value)>k then
      if Value[k+1]=':' then
        isB64Encoded := true;

    { prepare PName and PValue}
    PName := Copy(Value, 1, k-1);
    if isB64Encoded then
    begin
      temp := copy(Value, k+2, Length(Value)-k-1);
      if (Length(temp)>1) and (temp[1]=' ') then
        Delete(temp, 1, 1);
      PValue := B64Value2WideStr(temp);
    end
    else
    begin
      temp := copy(Value, k+1, Length(Value)-k);
      if (Length(temp)>1) and (temp[1]=' ') then
        Delete(temp, 1, 1);
      PValue := temp;
    end;

    { fill VCard }
    if (WideCompareStr(PName, 'dn')=0) then
    begin
      // dn may contain cn and/or mail etc, so lets
      // pick first as displayName
      k := Pos(',', PValue);
      if k=0 then
        k := Length(PValue)+1;
      j := Pos('=', PValue);
      if j<>0 then
        DisplayName := copy(PValue, j+1, k-j-1)
      else
        DisplayName := PValue;
    end
    else if (WideCompareStr(PName, 'objectclass')=0) then
    begin   // importing only "objectclass: person"
      if WideCompareStr(PValue, 'person')=0 then
        validPersonEntry := true;
    end
    else if (WideCompareStr(PName, 'givenName')=0) then
    begin
      Name := PValue;
    end
    else if (WideCompareStr(PName, 'sn')=0) then
    begin
      Surname := PValue;
    end
    else if (WideCompareStr(PName, 'cn')=0) then
    begin // fullName should be Name;Surname
      DisplayName := PValue;
    end
    else if (WideCompareStr(PName, 'mail')=0) then
    begin
      Email := PValue;
    end
    else if (WideCompareStr(PName, 'telephoneNumber')=0) then
    begin
      TelWork := PValue;
      TelPref := 'W';
    end
    else if (WideCompareStr(PName, 'homePhone')=0) then
    begin
      TelHome := PValue;
      TelPref := 'H';
    end
    else if (WideCompareStr(PName, 'fax')=0) then
    begin
      TelFax := PValue;
      TelPref := 'F';
    end
    else if (WideCompareStr(PName, 'pager')=0) then
    begin
      TelOther := PValue;
      TelPref := 'O';
    end
    else if (WideCompareStr(PName, 'mobile')=0) then
    begin
      TelCell := PValue;
      TelPref := 'M';
    end
    else if (WideCompareStr(PName, 'homeStreet')=0) then
    begin
      HomeAddress.Street := PValue;
    end
    else if (WideCompareStr(PName, 'homePostalAddress')=0) then
    begin // seems older versions of Thunderbird use this
      HomeAddress.Street := PValue;
    end
    else if (WideCompareStr(PName, 'mozillaHomeStreet2')=0) then
    begin
      HomeAddress.Street := HomeAddress.Street + ' ' + PValue;
    end
    else if (WideCompareStr(PName, 'mozillaHomeLocalityName')=0) then
    begin
      HomeAddress.City := PValue;
    end
    else if (WideCompareStr(PName, 'mozillaHomeState')=0) then
    begin
      HomeAddress.Region := PValue;
    end
    else if (WideCompareStr(PName, 'mozillaHomePostalCode')=0) then
    begin
      HomeAddress.PostalCode := PValue;
    end
    else if (WideCompareStr(PName, 'mozillaHomeCountryName')=0) then
    begin
      HomeAddress.Country := PValue;
    end
    else if (WideCompareStr(PName, 'company')=0) then
    begin
      Org := PValue;
    end
    else if (WideCompareStr(PName, 'description')=0) then
    begin
      Notes := PValue;
    end
    else if (WideCompareStr(PName, 'title')=0) then
    begin
      Title := PValue;
    end;
    { TODO: Add ModifiedDate support }
  end;

begin
  validPersonEntry := false;
  for i := 0 to ldif.Count-1 do
    ProcessRaw(ldif.Strings[i]);
  if validPersonEntry then begin
    if Name = '' then begin
      Name := DisplayName;
      //FullName := DisplayName;
    end;
    if (Name <> '') and (Surname <> '') then
      FullName := Name +';'+ Surname;
  end;

  Result := validPersonEntry;
end;

function TVCard.GetLDIF: TStrings;

  function B64EncodeAsNeccessary(instr: WideString; var outstr: string):boolean;
  var temp: string;
  begin // returns true if B64encoded
    temp := WideStringToUTF8String(instr);
    if Length(temp)<>Length(instr) then
    begin
      outstr := Str2B64(temp);
      Result := true;
    end
    else
    begin
      outstr := temp;
      Result := false;
    end;
  end;

  function PNameValueEncode(PName, PValue: WideString):string;
  var value: string;
  begin
    value := '';
    if B64EncodeAsNeccessary(PValue, value) then
      Result := PName + ':: ' + value
    else
      Result := PName + ': ' + value;
  end;

begin
  sl.Clear;

  if Email <> '' then
  begin
    if DisplayName <> '' then
      sl.Add(PNameValueEncode('dn', 'cn='+DisplayName+',mail='+Email))
    else if Name <> '' then
      sl.Add(PNameValueEncode('dn', 'cn='+Name+',mail='+Email))
    else
      sl.Add(PNameValueEncode('dn', 'mail='+Email));
  end
  else
  begin
    if DisplayName <> '' then
      sl.Add(PNameValueEncode('dn', 'cn='+DisplayName))
    else
      sl.Add(PNameValueEncode('dn', 'cn='+Name));
  end;

  sl.Add('objectclass: top');
  sl.Add('objectclass: person');
  sl.Add('objectclass: organizationalPerson');
  sl.Add('objectclass: inetOrgPerson');
  sl.Add('objectclass: mozillaAbPersonAlpha');

  if Name <> '' then
    sl.Add(PNameValueEncode('givenName', Name));
  if Surname <> '' then
    sl.Add(PNameValueEncode('sn', Surname));
  if DisplayName <> '' then
    sl.Add(PNameValueEncode('cn', DisplayName));
  if Email <> '' then
    sl.Add(PNameValueEncode('mail', Email));
  if TelWork <> '' then
    sl.Add(PNameValueEncode('telephoneNumber', TelWork));
  if TelHome <> '' then
    sl.Add(PNameValueEncode('homePhone', TelHome));
  if TelFax <> '' then
    sl.Add(PNameValueEncode('fax', TelFax));
  if TelOther <> '' then
    sl.Add(PNameValueEncode('pager', TelOther));
  if TelCell <> '' then
    sl.Add(PNameValueEncode('mobile', TelCell));
  if HomeAddress.Street <> '' then
    sl.Add(PNameValueEncode('homePostalAddress', HomeAddress.Street));
  if HomeAddress.City <> '' then
    sl.Add(PNameValueEncode('mozillaHomeLocalityName', HomeAddress.City));
  if HomeAddress.Region <> '' then
    sl.Add(PNameValueEncode('mozillaHomeState', HomeAddress.Region));
  if HomeAddress.PostalCode <> '' then
    sl.Add(PNameValueEncode('mozillaHomePostalCode', HomeAddress.PostalCode));
  if HomeAddress.Country <> '' then
    sl.Add(PNameValueEncode('mozillaHomeCountryName', HomeAddress.Country));
  if Org <> '' then
    sl.Add(PNameValueEncode('company', Org));
  if Notes <> '' then
    sl.Add(PNameValueEncode('description', Notes));
  if Title <> '' then
    sl.Add(PNameValueEncode('title', Title));

  // TODO: support modifyTime
  sl.Add('modifytimestamp: 0Z');
  Result := sl;
end;

function TVCard.GetMail: TStrings;
begin
  Result := mails;
end;

procedure TVCard.SetMail(const Value: TStrings);
begin
  mails.Text := Value.Text;
end;

end.
