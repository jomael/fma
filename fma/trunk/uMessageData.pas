unit uMessageData;

interface

uses uSMS, uGlobal, Classes, TntClasses, SysUtils;

type
  TMessageLocation = (mlME = 1, mlSM = 2, mlPC = 3);

  TFmaMessage = class(TObject)
  private
    FChanged, FOutgoing, FUnread: boolean;
    FData, FPDU: string;
    FIndex: Integer;
    FTimeStamp: TDateTime;
    FLocation: TMessageLocation;
  protected
    function GetString: string;
    function GetOutgoing: boolean; virtual;
    function GetTimeStamp: TDateTime; virtual;
    procedure SetString(const AData: string); virtual;
    procedure SetLocation(const NewLocation: TMessageLocation);
    procedure SetIndex(const NewIndex: Integer);
    procedure SetPDU(const NewPDU: string); virtual;
    procedure SetOutgoing(const NewValue: boolean);
    procedure SetTimeStamp(const NewTimeStamp: TDateTime);
    procedure SetUnread(const NewValue: boolean);
  public
    property AsString: string read GetString write SetString;
    property Location: TMessageLocation read FLocation write SetLocation;
    property MsgIndex: Integer read FIndex write SetIndex;
    property PDU: string read FPDU write SetPDU;
    property IsOutgoing: boolean read GetOutgoing write SetOutgoing;
    property TimeStamp: TDateTime read GetTimeStamp write SetTimeStamp;
    property IsNew: boolean read FUnread write SetUnread;
    constructor Create(const AData: string = '');
  end;

  TFmaMessageData = class(TFmaMessage)
  private
    FDecoded: boolean;
    FText: WideString;
    FFrom: string;
    ARef, ATot, An: integer;
  protected
    procedure SetPDU(const NewPDU: string); override;
    procedure SetString(const AData: string); override;
    function GetSMSText: WideString;
    function GetSMSFrom: string;
    function GetOutgoing: boolean; override;
    function GetTimeStamp: TDateTime; override;
    function GetIsLongSMS: boolean;
    function GetIsLongFirst: boolean;
    function GetARef: integer;
    function GetATot: integer;
    function GetAN: integer;
    procedure DecodeSMS;
  public
    property Text: WideString read GetSMSText;
    property From: string read GetSMSFrom;
    property IsLong: boolean read GetIsLongSMS;
    property IsLongFirst: boolean read GetIsLongFirst;
    property Reference: integer read GetARef;
    property Total: integer read GetATot;
    property MsgNum: integer read GetAN;
    constructor Create(const AData: string = '');
  end;

implementation

constructor TFmaMessage.Create(const AData: string);
begin
  FChanged := True;
  FLocation := mlPC;
  FTimeStamp := 0;
  FUnread := False;
  if AData <> '' then
    AsString := AData;
end;

procedure TFmaMessage.SetString(const AData: string);
var
  wl: TTntStrings;
begin
  FData := AData;
  FChanged := False;
  wl := TTntStringList.Create;
  try
    GetTokenList(wl, AData);
    if wl.Count < 6 then
      raise Exception.Create('Invalid message data!');
    // wl[0] = location, [1] = index, [2] = '1'/'3'>incoming/outgoing [3,4] ??
    // [5] = PDU, [6] = timestamp, [7] = newFlag
    FLocation := TMessageLocation(StrToInt(wl[0]));
    FIndex := StrToInt(wl[1]);
    FOutgoing := wl[2] = '3';
    FPDU := wl[5];
    if wl.Count > 6 then begin
      if wl[6] <> '' then try
        FTimeStamp := StrToDateTime(wl[6]);
      except
        // Unexpected date/time format
        FTimeStamp := 0;
        FChanged := True; // correct format on save
      end
      else
        FTimeStamp := 0;
    end;
    if wl.Count > 7 then
      FUnread := wl[7] = '1';
  finally
    wl.Free;
  end;
end;

function TFmaMessage.GetString: string;
begin
  if FChanged then begin
    FData := IntToStr(Ord(FLocation)) + ',' + IntToStr(FIndex) + ',';
    if not FOutgoing then
      FData := FData + '3'
    else
      FData := FData + '1';
    FData := FData + ',,,' + FPDU + ',';
    if FTimeStamp <> 0 then
      FData := FData + DateTimeToStr(FTimeStamp) + ','
    else
      FData := FData + ',';
    FData := FData + IntToStr(Byte(FUnread));
    FChanged := False;
  end;
  Result := FData;
end;

function TFmaMessage.GetOutgoing: boolean;
begin
  Result := FOutgoing;
end;

function TFmaMessage.GetTimeStamp: TDateTime;
begin
  Result := FTimeStamp;
end;

procedure TFmaMessage.SetLocation(const NewLocation: TMessageLocation);
begin
  FChanged := True;
  FLocation := NewLocation;
end;

{procedure TFmaMessage.SetLocation(const NewLocation: string);
begin
  FChanged := True;
  FLocation := TMessageLocation(StrToInt(NewLocation));
end;}

procedure TFmaMessage.SetIndex(const NewIndex: Integer);
begin
  FChanged := True;
  FIndex := NewIndex;
end;

procedure TFmaMessage.SetPDU(const NewPDU: string);
begin
  FChanged := True;
  FPDU := NewPDU;
  // TODO: PDU sanity check
end;

procedure TFmaMessage.SetOutgoing(const NewValue: boolean);
begin
  FChanged := True;
  FOutgoing := NewValue;
end;

procedure TFmaMessage.SetTimeStamp(const NewTimeStamp: TDateTime);
begin
  FChanged := True;
  FTimeStamp := NewTimeStamp;
end;

procedure TFmaMessage.SetUnread(const NewValue: boolean);
begin
  FChanged := True;
  FUnread := NewValue;
end;

constructor TFmaMessageData.Create(const AData: string);
begin
  inherited Create(AData);
  FDecoded := False;
end;

procedure TFmaMessageData.SetString(const AData: string);
begin
  inherited SetString(AData);
  FDecoded := False;
end;

procedure TFmaMessageData.SetPDU(const NewPDU: string);
begin
  inherited SetPDU(NewPDU);
  FDecoded := False;
end;

function TFmaMessageData.GetSMSText: WideString;
begin
  if not FDecoded then
    DecodeSMS;
  Result := FText;
end;

function TFmaMessageData.GetSMSFrom: string;
begin
  if not FDecoded then
    DecodeSMS;
  Result := FFrom;
end;

function TFmaMessageData.GetOutgoing: boolean;
begin
  if (not FDecoded) and FChanged then
    DecodeSMS;
  Result := FOutgoing;
end;

function TFmaMessageData.GetTimeStamp: TDateTime;
begin
  if (not FDecoded) and FChanged then
    DecodeSMS;
  Result := FTimeStamp;
end;

function TFmaMessageData.GetIsLongSMS: boolean;
begin
  if (not FDecoded) then
    DecodeSMS;
  Result := ATot > 1;
end;

function TFmaMessageData.GetIsLongFirst: boolean;
begin
  if (not FDecoded) then
    DecodeSMS;
  Result := (ATot > 1) and (An = 1);
end;

function TFmaMessageData.GetARef: integer;
begin
  if (not FDecoded) then
    DecodeSMS;
  Result := ARef;
end;

function TFmaMessageData.GetATot: integer;
begin
  if (not FDecoded) then
    DecodeSMS;
  Result := ATot;
end;

function TFmaMessageData.GetAN: integer;
begin
  if (not FDecoded) then
    DecodeSMS;
  Result := An;
end;

procedure TFmaMessageData.DecodeSMS;
var
  sms: TSMS;
  dateTime: TDateTime;
  UDHI: string;
  pos, octet, udhil: Integer;
begin
  if FPDU = '' then
    raise Exception.Create('Invalid Message PDU!');
  sms := TSMS.Create;
  try
    sms.PDU := FPDU;
    // set all necessary props
    FText := sms.Text;
    FFrom := sms.Number;
    dateTime := sms.TimeStamp;
    if dateTime <> 0 then
      FTimeStamp := dateTime;
    FOutgoing := sms.IsOutgoing;
    // decode Long Msg Info
    ARef := -1; ATot := -1; An := -1;
    if sms.IsUDH then begin
      UDHI := sms.UDHI;
      udhil := StrToInt('$' + copy(UDHI, 1, 2));
      //ANALIZE UDHI
      UDHI := Copy(UDHI, 3, length(UDHI));
      while UDHI <> '' do begin
        //Get the octet for type
        octet := StrToInt('$' + Copy(UDHI, 1, 2));
        UDHI := Copy(UDHI, 3, length(UDHI));
        case octet of
          0: begin // SMS CONCATENATION WITH 8bit REF
               ARef := StrToInt('$' + Copy( UDHI, 3, 2));
               ATot := StrToInt('$' + Copy( UDHI, 5, 2));
               An := StrToInt('$' + Copy( UDHI, 7, 2));
             end;
          8: begin // SMS CONCATENATION WITH 16bit REF
               ARef := StrToInt('$' + Copy( UDHI, 3, 4));
               ATot := StrToInt('$' + Copy( UDHI, 7, 2));
               An := StrToInt('$' + Copy( UDHI, 9, 2));
             end;
        else begin
               pos := udhil + 1;
               UDHI := Copy(UDHI, pos * 2 + 1, length(UDHI));
             end;
        end;
      end;
    end;
  finally
    sms.Free;
    FDecoded := True;
  end;
end;

end.
