{: ICS WSocket extension supporting WinSock interface to IrDA:IrCOMM (IrSock).
   (c) 2000 Primoz Gabrijelcic

   Author           : Primoz Gabrijelcic
   Creation date    : 2000-11-01
   Last modification: 2000-11-08
   Version          : 1.0
   Limitations      : Currently only supports client side and 9 Wire mode.

   This unit won't compile without a minimal change to WSocket.pas:
   - In class TCustomWSocket move FSelectEvent variable from private to
     protected section.

   History:
   1.0: 2000-11-08
     - Released.

   0.0: 2000-11-01
     - Created.
}

unit WIrCOMMSocket;

interface

uses
  Windows,
  WinSock,
  WSocket,
  Classes;

const

{ Imports from AF_IRDA.H }

  //: IrDA protocol number
  AF_IRDA = 26;
  PF_IRDA = AF_IRDA;

  SOL_IRLMP            = $00FF;

  IRLMP_ENUMDEVICES    = $00000010;
  IRLMP_IAS_SET        = $00000011;
  IRLMP_IAS_QUERY      = $00000012;
  IRLMP_SEND_PDU_LEN   = $00000013;
  IRLMP_EXCLUSIVE_MODE = $00000014;
  IRLMP_IRLPT_MODE     = $00000015;
  IRLMP_9WIRE_MODE     = $00000016;
  IRLMP_TINYTP_MODE    = $00000017;
  IRLMP_PARAMETERS     = $00000018;
  IRLMP_DISCOVERY_MODE = $00000019;

  IAS_ATTRIB_NO_CLASS  = $00000010;
  IAS_ATTRIB_NO_ATTRIB = $00000000;
  IAS_ATTRIB_INT       = $00000001;
  IAS_ATTRIB_OCTETSEQ  = $00000002;
  IAS_ATTRIB_STR       = $00000003;

  IAS_MAX_USER_STRING  = 256;
  IAS_MAX_OCTET_STRING = 1024;
  IAS_MAX_CLASSNAME    = 64;
  IAS_MAX_ATTRIBNAME   = 256;

type
  //:IrDA device ID. Should be treated as four characters, not as PChar.
  TIrdaDeviceID = array [1..4] of char;

  //:Socket-level IrDA device 'address' descriptor.
  TIrdaSockAddr = packed record
    irdaAddressFamily: u_short;
    irdaDeviceID     : TIrdaDeviceID;
    irdaServiceName  : array [0..24] of char;
  end; { TIrdaSockAddr }

  //:Information on one IrDA device.
  TIrdaDeviceInfo = packed record
    irdaDeviceID    : TIrdaDeviceID;
    irdaDeviceName  : array [0..21] of char;
    irdaDeviceHints1: byte;
    irdaDeviceHints2: byte;
    irdaCharSet     : byte;
  end; { TIrdaDeviceInfo }
  PIrdaDeviceInfo = ^TIrdaDeviceInfo;

  TIrdaAttribOctetSeq = packed record
    len     : longint;
    octetSeq: array [0..IAS_MAX_OCTET_STRING-1] of byte;
  end; { TIrdaAttribOctetSeq }

  TIrdaAttribUsrStr = packed record
    len    : longint;
    charSet: longint;
    usrStr : array [0..IAS_MAX_USER_STRING] of char;
  end; { TIrdaAttribUsrStr }

  //:IAS query
  TIrdaIASQuery = packed record
    irdaDeviceID  : TIrdaDeviceID;
    irdaClassName : array [0..IAS_MAX_CLASSNAME-1] of char;
    irdaAttribName: array [0..IAS_MAX_ATTRIBNAME-1] of char;
    irdaAttribType: longint;
    case integer of // irdaAttribute
      0: (irdaAttribInt: longint);
      1: (irdaAttribOctetSeq: TIrdaAttribOctetSeq);
      2: (irdaAttribUsrStr: TIrdaAttribUsrStr);
  end; { TIrdaIASQuery }
  PIrdaIASQuery = ^TIrdaIASQuery;

{ WIrCOMMSocket classes }

  {:Information on all connected IrDA devices, returned from
    TWIrCOMMSocket.GetConnectedDevices.
  }
  TIrdaDevicesInfo = class
  private
    idiDeviceList: TList; 
  protected
    procedure AddDeviceInfo(di: TIrdaDeviceInfo); virtual;
    function  GetDeviceInfo(index: integer): TIrdaDeviceInfo; virtual;
  public
    constructor Create;
    destructor  Destroy; override;
    function    Count: integer;
    property    Items[index: integer]: TIrdaDeviceInfo read GetDeviceInfo; default;
  end; { TIrdaDevicesInfo }

  {:IrCOMM over WinSock - currently only supports client side in 9 Wire mode
    (because Windows 2000 supports 9 Wire mode only).
  }
  TWIrCOMMSocket = class(TCustomSyncWSocket)
  protected
    procedure AssignDefaultValue; override;
    function  InitializeSocket: boolean; virtual;
    function  Set9WireMode: boolean; virtual;
  public
    irDeviceID: TIrdaDeviceID;
    procedure Connect; override;
    function  GetConnectedDevices: TIrdaDevicesInfo;
    property Handle;
    property HSocket;
    property BufSize;
    property Text;
    property AllSent;
    property OnDisplay;
    property DeviceID: TIrdaDeviceID read irDeviceID write irDeviceID;
  published
    property State;
    property ReadCount;
    property RcvdCount;
    property LastError;
    property MultiThreaded;
    property ComponentOptions;
    property OnDataAvailable;
    property OnDataSent;
    property OnSendData;
    property OnSessionClosed;
    property OnSessionAvailable;
    property OnSessionConnected;
    property OnChangeState;
    property OnError;
    property OnBgException;
    property FlushTimeout;
    property SendFlags;
    property LingerOnOff;
    property LingerTimeout;
  end; { TWIrCOMMSocket }

{IrDA helper functions}
  function IrdaIDToString(id: TIrdaDeviceID): string;
  function StringToIrDAID(id: string): TIrdaDeviceID;

{Component registration}
  procedure Register;
  
implementation

uses
  SysUtils;

  {:Component registration.
  }
  procedure Register;
  begin
    RegisterComponents('FMA', [TWIrCOMMSocket]);
  end; { Register }
  
  {:Converts IrDA ID to textual representation.
  }
  function IrdaIDToString(id: TIrdaDeviceID): string;

    function GetLastNonzero: integer;
    var
      iCh: integer;
    begin
      Result := Low(id)-1;
      for iCh := High(id) downto Low(id) do begin
        if id[iCh] <> #0 then begin
          Result := iCh;
          break;
        end;
      end; //for
    end; { GetLastNonzero }

  var
    hiCh: integer;
    iCh : integer;

  begin { IrdaIDToString }
    Result := '';
    hiCh := GetLastNonzero;
    for iCh := Low(id) to hiCh do begin
      if id[iCh] in ([#33..#126]-['#']) then
        Result := Result + id[iCh]
      else
        Result := Result + '#' + Format('%.3d',[Ord(id[iCh])]);
    end; //for
  end; { IrdaIDToString }

  {:Converts textual representation of IrDA ID back to TIrdaDeviceID.
  }
  function StringToIrDAID(id: string): TIrdaDeviceID;

    function ExtractChar: char;
    begin
      if id = '' then
        Result := #0
      else if  id[1] <> '#' then begin
        Result := id[1];
        Delete(id,1,1);
      end
      else begin
        Result := Chr(StrToIntDef(Copy(id,2,3),0));
        Delete(id,1,4);
      end;
    end; { ExtractChar }

  var
    iCh: integer;

  begin { StringToIrDAID }
    for iCh := Low(TIrdaDeviceID) to High(TIrdaDeviceID) do
      Result[iCh] := ExtractChar;
  end; { StringToIrDAID }

{ TIrdaDevicesInfo }

type
  //:Wrapper for IrDA device info record.
  TIrdaDeviceWrapper = class
    idwInfo: TIrdaDeviceInfo;
  end; { TIrdaDeviceWrapper }

{:Adds device info to the list.
}
procedure TIrdaDevicesInfo.AddDeviceInfo(di: TIrdaDeviceInfo);
begin
  idiDeviceList.Add(TIrdaDeviceWrapper.Create);
  TIrdaDeviceWrapper(idiDeviceList[idiDeviceList.Count-1]).idwInfo := di;
end; { TIrdaDevicesInfo.AddDeviceInfo }

{:Returns number of devices in list.
}
function TIrdaDevicesInfo.Count: integer;
begin
  Result := idiDeviceList.Count;
end; { TIrdaDevicesInfo.Count }

{:TIrdaDeviceInfo constructor. Creates internal storage.
}
constructor TIrdaDevicesInfo.Create;
begin
  inherited Create;
  idiDeviceList := TList.Create;
end; { TIrdaDevicesInfo.Create }

{:TIrdaDeviceInfo destructor. Cleanup.
}
destructor TIrdaDevicesInfo.Destroy;
var
  iDev: integer;
begin
  for iDev := 0 to idiDeviceList.Count-1 do begin
    TIrdaDeviceWrapper(idiDeviceList[iDev]).Free;
    idiDeviceList[iDev] := nil;
  end;
  idiDeviceList.Free;
  inherited Destroy;
end; { TIrdaDevicesInfo.Destroy }

{:Returns index-th device info.
}
function TIrdaDevicesInfo.GetDeviceInfo(index: integer): TIrdaDeviceInfo;
begin
  Result := TIrdaDeviceWrapper(idiDeviceList[index]).idwInfo;
end; { TIrdaDevicesInfo.GetDeviceInfo }

{ TWIrCOMMSocket }

{:Assigns default socket values for IrDA communication.
}
procedure TWIrCOMMSocket.AssignDefaultValue;
begin
  inherited AssignDefaultValue;
  FAddrFormat := PF_IRDA;
end; { TWIrCOMMSocket.AssignDefaultValue }

{:Connects to IrCOMM device.
}
procedure TWIrCommSocket.Connect;
var
  iStatus: integer;
  sin    : TIrdaSockAddr;
begin
  if (FHSocket <> INVALID_SOCKET) and (FState <> wsClosed) then begin
    RaiseException('Connect: Socket already in use');
    Exit;
  end;
  if not InitializeSocket then
    Exit;
  sin.irdaAddressFamily := AF_IRDA;
  sin.irdaDeviceID      := DeviceID;
  sin.irdaServiceName   := 'IrDA:IrCOMM';
  iStatus := WSocket_connect(FHSocket, TSockAddr((@sin)^), sizeof(sin));
  if iStatus = 0 then
    ChangeState(wsConnected)
  else begin
    iStatus := WSocket_WSAGetLastError;
    if iStatus = WSAEWOULDBLOCK then
      ChangeState(wsConnecting)
    else begin
      SocketError('Connect');
      Exit;
    end;
  end;
end; { TWIrCommSocket.Connect }

{:Returns list of connected IrDA devices. List is created inside this routine
  and must be destroyed by the caller.
  Mostly copied from MSDN (IrDA: Background and Overview;
  http://msdn.microsoft.com/library/backgrnd/html/irdawp.htm).
}
function TWIrCOMMSocket.GetConnectedDevices: TIrdaDevicesInfo;
// TODO 2 -oPrimoz Gabrijelcic: Implement lazy discovery (http://www.cswl.com/cswl/whiteppr/white/infrared.html)
const
  IAS_QUERY_ATTRIB_MAX_LEN = 32;
var
  IASQueryBuf: PIrdaIASQuery;
  IASQueryLen: integer;

  {:Checks if device supports 9 Wire protocol.
    @param   dev IrDA device.
    @returns True if device supports 9 Wire protocol.
  }
  function Supports9Wire(dev: PIrdaDeviceInfo): boolean;
  var
    PI, PL, PV: integer;
  begin
    Result := false;
    IASQueryBuf^.irdaDeviceID   := dev^.irdaDeviceID;
    IASQueryBuf^.irdaClassName  := 'IrDA:IrCOMM';
    IASQueryBuf^.irdaAttribName := 'Parameters';
    if WSocket_getsockopt(FHSocket, SOL_IRLMP, IRLMP_IAS_QUERY,
         PChar(IASQueryBuf), IASQueryLen) = SOCKET_ERROR then
    begin
      SocketError('Supports9Wire');
      Exit;
    end;
    if IASQueryBuf^.irdaAttribType <> IAS_ATTRIB_OCTETSEQ then
      Exit; // Peer's IAS database entry for IrCOMM is bad.
    if IASQueryBuf^.irdaAttribOctetSeq.len < 3 then
      Exit; // Peer's IAS database entry for IrCOMM is bad.
    // Search for the PI value 0x00 and check 9 Wire, see IrCOMM spec.
    PI := 0;
    PL := PI + 1;
    PV := PL + 1;
    repeat
      if (IASQueryBuf^.irdaAttribOctetSeq.OctetSeq[PI] = 0) and
         ((IASQueryBuf^.irdaAttribOctetSeq.OctetSeq[PV] AND $04) <> 0) then begin
        Result := true;
        break; //repeat
      end;
      if (PL + IASQueryBuf^.irdaAttribOctetSeq.OctetSeq[PL]) >=
         IASQueryBuf.irdaAttribOctetSeq.Len then
        break; //repeat
      PI := PL + IASQueryBuf.irdaAttribOctetSeq.OctetSeq[PL];
      PL := PI + 1;
      PV := PL + 1;
    until false;
  end; { Supports9Wire }

var
  deviceListBuf  : pointer;
  deviceListLen  : integer;
  iDevice        : integer;
  maxDevices     : integer;
  mustCloseSocket: boolean;
  pDevice        : PIrdaDeviceInfo;

begin { TWIrCOMMSocket.GetConnectedDevices }
  Result := nil;
  if FHSocket = INVALID_SOCKET then begin
    if not InitializeSocket then
      Exit
    else
      mustCloseSocket := true;
  end
  else
    mustCloseSocket := false;
  try
    deviceListBuf := nil;
    maxDevices := 5; // more than 10 irda devices on the same irda receiver? unlikely! but we'll adapt in repeat..until if this happens anyway
    try
      repeat
        maxDevices := 2*maxDevices;
        if assigned(deviceListBuf) then
          FreeMem(deviceListBuf);
        //deviceListBuf^ = record
        //  numDevices: longint
        //  deviceData: array [] of TIrdaDeviceInfo
        deviceListLen := SizeOf(longint)+maxDevices*SizeOf(TIrdaDeviceInfo);
        GetMem(deviceListBuf,deviceListLen);
        longint(deviceListBuf^) := 0;
        if WSocket_getsockopt(FHSocket, SOL_IRLMP, IRLMP_ENUMDEVICES,
             deviceListBuf, deviceListLen) = SOCKET_ERROR then
        begin
          SocketError('Device enumeration failed');
          Exit;
        end;
      until longint(deviceListBuf^) < maxDevices;
      Result := TIrdaDevicesInfo.Create;
      pDevice := PIrdaDeviceInfo(integer(deviceListBuf)+SizeOf(longint));
      //IASQueryBuf is used in all calls to Supports9Wire
      IASQueryLen := SizeOf(TIrdaIASQuery) - 3 + IAS_QUERY_ATTRIB_MAX_LEN;
      IASQueryBuf := AllocMem(IASQueryLen);
      try
        for iDevice := 1 to longint(deviceListBuf^) do begin
          if Supports9Wire(pDevice) then // Report only devices supporting 9 wire mode
            Result.AddDeviceInfo(pDevice^);
          Inc(pDevice);
        end; //for
      finally FreeMem(IASQueryBuf); end;
    finally FreeMem(deviceListBuf); end;
  finally
    if mustCloseSocket then
      Close;
  end;
end; { TWIrCOMMSocket.GetConnectedDevices }

{:Initializes IrDA socket and puts it into 9 Wire mode.
}
function TWIrCOMMSocket.InitializeSocket: boolean;
var
  iStatus: integer;
begin
  Result := false;
  FProto := 0;
  FType  := SOCK_STREAM;
  FProtoResolved := true;
  { Remove any data from the internal output buffer }
  { (should already be empty !)                     }
  DeleteBufferedData;
  FHSocket := WSocket_socket(FAddrFormat, FType, FProto);
  if FHSocket = INVALID_SOCKET then begin
    SocketError('Connect (socket)');
    Exit;
  end;
  ChangeState(wsOpened);
  if not Set9WireMode then
    Exit;
  SetLingerOption;
  FSelectEvent := FD_READ or FD_WRITE or FD_CLOSE or FD_ACCEPT or FD_CONNECT;
  iStatus := WSocket_WSAASyncSelect(FHSocket, Handle, WM_ASYNCSELECT, FSelectEvent);
  if iStatus <> 0 then begin
    SocketError('WSAAsyncSelect');
    Exit;
  end;
  Result := true;
end; { TWIrCOMMSocket.InitializeSocket }

{:Sets 9 Wire mode for DeviceID device.
  @return False on error.
}
function TWIrCOMMSocket.Set9WireMode: boolean;
var
  Enable9WireMode: integer;
begin
  Result := false;
  Enable9WireMode := 1;
  if WSocket_setsockopt(FHSocket, SOL_IRLMP, IRLMP_9WIRE_MODE,
       @Enable9WireMode, SizeOf(integer)) = SOCKET_ERROR then
  begin
    SocketError('Set9WireMode');
    Exit;
  end;
  Result := true;
end; { TWIrCOMMSocket.Set9WireMode }

end.


