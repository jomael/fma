unit uMessageData;

{
*******************************************************************************
* Descriptions: SMS message FMA implementaton
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

uses uSMS, uGlobal, Classes, TntClasses, SysUtils, uVCard;

type
  TMessageLocation = (mlME = 1, mlSM = 2, mlPC = 3);

  TFmaMessage = class(TObject)
  private
    FChanged, FOutgoing, FUnread: boolean;
    FData, FPDU, FReportPDU: string;
    FIndex, FStat, FPDULength: Integer;
    FStatusCode: byte;
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
    procedure SetReportPDU(const NewPDU: string); virtual;
    procedure SetOutgoing(const NewValue: boolean);
    procedure SetTimeStamp(const NewTimeStamp: TDateTime);
    procedure SetUnread(const NewValue: boolean);
  public
    constructor Create(const AData: string = '');

    property AsString: string read GetString write SetString;
    property Location: TMessageLocation read FLocation write SetLocation;
    property MsgIndex: Integer read FIndex write SetIndex;
    property PDU: string read FPDU write SetPDU;
    property IsOutgoing: boolean read GetOutgoing write SetOutgoing;
    property TimeStamp: TDateTime read GetTimeStamp write SetTimeStamp;
    property IsNew: boolean read FUnread write SetUnread;
    { properties for Status reports }
    property ReportPDU: string read FReportPDU write SetReportPDU;
    property StatusCode: byte read FStatusCode;
  end;

  TInternalStatus = (seUnknown,seReady,seProcessing,seDone);

  PFmaMessageData = ^TFmaMessageData;
  TFmaMessageData = class(TFmaMessage)
  private
    FDecoded, FReportReq: boolean;
    FText: WideString;
    FFrom, FMsgRef: string;
    ARef, ATot, An: integer;
    FBusinessCard: TVCard;
    FIntStatus: TInternalStatus;
    function GetIsDelivered: boolean;
  protected
    procedure SetPDU(const NewPDU: string); override;
    procedure SetString(const AData: string); override;
    function GetSMSText: WideString;
    function GetSMSFrom: string;
    function GetOutgoing: boolean; override;
    function GetTimeStamp: TDateTime; override;
    function GetIsLongSMS: boolean;
    function GetIsLongFirst: boolean;
    function GetMsgRef: string;
    function GetARef: integer;
    function GetATot: integer;
    function GetAN: integer;
    function GetReportReq: boolean;
    procedure DecodeSMS;
    procedure SetText(AText: WideString);
  public
    constructor Create(const AData: string = '');
    destructor Destroy; override;

    property Text: WideString read GetSMSText;
    property From: string read GetSMSFrom;
    property IsLong: boolean read GetIsLongSMS;
    property IsLongFirst: boolean read GetIsLongFirst;
    property MessageRef: string read GetMsgRef;
    property Reference: integer read GetARef;
    property Total: integer read GetATot;
    property MsgNum: integer read GetAN;
    // next are FMA specific
    property ReportRequested: boolean read GetReportReq;
    property IsDelivered: boolean read GetIsDelivered;
    property BusinessCard: TVCard read FBusinessCard write FBusinessCard;
    property InternalStatus: TInternalStatus read FIntStatus write FIntStatus;
  end;

implementation

constructor TFmaMessage.Create(const AData: string);
begin
  FChanged := True;
  FLocation := mlPC;
  FTimeStamp := 0;
  FUnread := False;
  FStatusCode := $FF; // unknown
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
      raise EConvertError.Create('Invalid message data!');
    {
      wl[0] = location (FMA data)
      wl[1] = index (+CMGL data)
      wl[2] = stat '0,1'/'2,3' > in/out (+CMGL data)
      wl[3] = [alpha] - unused (+CGML data)
      wl[4] = PDU length, in octets (+CGML data)
      wl[5] = PDU (+CMGL data)
      wl[6] = timestamp (FMA data)
      wl[7] = new flag (FMA data)
      wl[8] = status report PDU (+CDS data)
      wl[9] = status code (FMA data)
    }
    FLocation := TMessageLocation(StrToInt(wl[0]));
    FIndex := StrToInt(wl[1]);
    FStat := StrToIntDef(wl[2], 0);
    FOutgoing := FStat in [2, 3];
    // set unread flag by stat field first
    FUnread := FStat in [0, 2];
    FPDULength := StrToIntDef(wl[4],0); // PDU len in octets
    FPDU := wl[5];
    // TODO: Finish and use this sanity check ???
    {
    if FPDULength > 0 then begin
      ExpectedByteLen := FPDULength * ....
      if Length(FPDU) > ExpectedByteLen then // truncate PDU
        FPDU := Copy(FPDU, 1, ExpectedByteLen)
      else if Length(FPDU) < ExpectedByteLen then // error!
        raise EConvertError.Create('Invalid PDU!');
    end;
    }
    if wl.Count > 6 then begin
      if wl[6] <> '' then begin
        if wl[6][1] = '$' then
          FTimeStamp := HexStringToDateTime(wl[6])
        else begin
          FChanged := True; // use HexString on save
          try
            FTimeStamp := StrToDateTime(wl[6]);
          except
            // Unexpected date/time format
            FTimeStamp := 0;
          end;
        end;
      end
      else
        FTimeStamp := 0;
    end;
    if wl.Count > 7 then
      FUnread := wl[7] = '1';
    if wl.Count > 8 then
      FReportPDU := wl[8];
    if wl.Count > 9 then
      FStatusCode := Byte(StrToIntDef(wl[9], $FF));
  finally
    wl.Free;
  end;
end;

function TFmaMessage.GetString: string;
begin
  if FChanged then begin
    FData := IntToStr(Ord(FLocation)) + ',' + IntToStr(FIndex) + ',';
    FData := FData + IntToStr(FStat) + ',';
    FData := FData + ',,' + FPDU + ',';
    if (FTimeStamp <> 0) and (FOutgoing) then
      FData := FData + DateTimeToHexString(FTimeStamp) + ','
    else
      FData := FData + ',';
    FData := FData + IntToStr(Byte(FUnread)) + ',';
    FData := FData + FReportPDU + ',';
    if FReportPDU <> '' then
      FData := FData + IntToStr(FStatusCode);
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
  FPDULength := 0;
  // TODO: PDU sanity check
end;

procedure TFmaMessage.SetReportPDU(const NewPDU: string);
var
  sr: TSMSStatusReport;
begin
  if FOutgoing then begin
    FChanged := True;
    FReportPDU := NewPDU;
    // DONE: decode and change timestamp, status code
    sr := TSMSStatusReport.Create;
    try
      sr.PDU := FReportPDU;
      FTimeStamp := sr.OriginalSentTime;
      FStatusCode := sr.StatusCode;
    finally
      sr.Free;
    end;
  end
  else
    raise Exception.Create('Unable to add status report to SMS-DELIVER!');
end;

procedure TFmaMessage.SetOutgoing(const NewValue: boolean);
begin
  FChanged := True;
  FOutgoing := NewValue;
end;

procedure TFmaMessage.SetTimeStamp(const NewTimeStamp: TDateTime);
begin
  // TimeStamp can be changed only for Outgoing messages
  if FOutgoing then begin
    FChanged := True;
    FTimeStamp := NewTimeStamp;
  end;
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
  if (not FDecoded) then
    DecodeSMS;
  Result := FTimeStamp;
end;

function TFmaMessageData.GetMsgRef: string;
begin
  if (not FDecoded) then
    DecodeSMS;
  Result := FMsgRef;
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

function TFmaMessageData.GetReportReq: boolean;
begin
  if (not FDecoded) then
   DecodeSMS;
  Result := FReportReq;
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
    SetText(sms.Text);
    FFrom := sms.Number;
    dateTime := sms.TimeStamp;
    FMsgRef := sms.MessageReference;
    if dateTime <> 0 then
      FTimeStamp := dateTime;
    FOutgoing := sms.IsOutgoing;
    FReportReq := sms.StatusRequest;
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
    if FReportReq and (FReportPDU <> '') then
      SetReportPDU(FReportPDU); // refresh data from report
    // check report timeout
    if FReportReq and (FReportPDU = '') and (FTimeStamp <> 0) then
      if sms.Validity < 0 then begin // offset value
        if Now > FTimeStamp - sms.Validity then FStatusCode := $46;
      end
      else if sms.Validity > 0 then begin // absolute value
        if Now > sms.Validity then FStatusCode := $46;
      end;
  finally
    sms.Free;
    FDecoded := True;
  end;
  // never set non-first long messages as unread
  if (ATot > 1) and (An > 1) and (FUnread) then begin
    FUnread := False;
    FChanged := True;
  end;
end;

procedure TFmaMessageData.SetText(AText: WideString);
var
  sl: TStrings;
begin
  FText := AText;
  { check if Text is just a Business Card }
  sl := TStringList.Create;
  try
    sl.Text := AText;

    FBusinessCard := TVCard.Create;
    try
      FBusinessCard.Raw := sl;
    finally
      if not FBusinessCard.IsValidVCard then
        FreeAndNil(FBusinessCard);
    end;
  finally
    sl.Free;
  end;
end;

destructor TFmaMessageData.Destroy;
begin
  if Assigned(FBusinessCard) then
    FreeAndNil(FBusinessCard);
    
  inherited;
end;

function TFmaMessageData.GetIsDelivered: boolean;
begin
  Result := IsOutgoing and (StatusCode = 0);
end;

end.
