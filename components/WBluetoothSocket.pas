{  ICS WSocket extension supporting WinSock interface to XPSP1 Bluetooth
   Based on WIrCOMMSocket by Primoz Gabrijelcic

   Author           : Warren Chin
   Creation date    : 2002-07-09
   Last modification: 2002-07-09
   Version          : 0.1
   Limitations      : Supports only basic MS-BT (XP SP1 beta) Operation

   Changes:
   $Log: WBluetoothSocket.pas,v $
   Revision 1.5  2005/03/01 11:29:14  z_stoichev
   Add components to FMA pallete.

   Revision 1.4  2005/02/14 19:11:02  voxik
   Added BT devices enumeartion

   Revision 1.3  2004/10/11 13:15:47  voxik
   Merged with Calendar branch (Fma 0.1.2.10)

   Revision 1.2.8.1  2004/08/18 16:55:56  voxik
   Fixed Removed unnecessary property for compatibility with newer ICS

   Revision 1.2  2003/01/30 02:33:19  warren00
   unix/dos CRLF problem

}

unit WBluetoothSocket;

interface

uses
  Windows,
  WinSock,
  WSocket,
  Classes,
  // These uses can be removed in the future versions of Delphi which will
  // provide BT API support.
  JwaWs2Bth, JwaWinsock2, JwaBthDef;

type
  // Information on one BT device.
  PBtDeviceInfo = ^TBtDeviceInfo;
  TBtDeviceInfo = record
    btDeviceName: WideString;
    btDeviceAddr: BTH_ADDR;
  end;

  { Information on all paired BT devices, returned from
    TWBluetoothSocket.GetConnectedDevices. }
  TBtDevicesInfo = class
  private
    btdiDeviceList: TList;
  protected
    procedure AddDeviceInfo(btDeviceName: WideString; btDeviceAddr: BTH_ADDR); virtual;
    function GetDeviceInfo(const Index: Integer): TBtDeviceInfo; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    function Count: Integer;
    property Items[const Index: Integer]: TBtDeviceInfo read GetDeviceInfo; default;
  end;

  TWBluetoothSocket = class(TCustomSyncWSocket)
  protected
    procedure AssignDefaultValue; override;
    function  InitializeSocket: boolean; virtual;
  public
    procedure Connect; override;
    function GetConnectedDevices: TBtDevicesInfo;
    property Handle;
    property HSocket;
    property BufSize;
    property Text;
    property AllSent;
    property OnDisplay;
  published
    property Addr;
    property Port;
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
  end;

  procedure Register;

implementation

uses
  SysUtils;

procedure Register;
begin
  RegisterComponents('FMA', [TWBluetoothSocket]);
end;

{ Adds device info to the list. }
procedure TBtDevicesInfo.AddDeviceInfo(btDeviceName: WideString; btDeviceAddr: BTH_ADDR);
  var
    iDev: PBtDeviceInfo;
begin
  New(iDev);

  iDev.btDeviceName := btDeviceName;
  iDev.btDeviceAddr := btDeviceAddr;

  btdiDeviceList.Add(iDev);
end;

{ Returns number of devices in list. }
function TBtDevicesInfo.Count: integer;
begin
  Result := btdiDeviceList.Count;
end;

{ Creates internal storage. }
constructor TBtDevicesInfo.Create;
begin
  inherited Create;

  btdiDeviceList := TList.Create;
end;

destructor TBtDevicesInfo.Destroy;
var
  iDev: integer;
begin
  for iDev := 0 to btdiDeviceList.Count - 1 do
  begin
    Dispose(btdiDeviceList[iDev]);
    btdiDeviceList[iDev] := nil;
  end;

  btdiDeviceList.Free;

  inherited Destroy;
end;

{ Returns index-th device info. }
function TBtDevicesInfo.GetDeviceInfo(const Index: Integer): TBtDeviceInfo;
begin
  Result := PBtDeviceInfo(btdiDeviceList[Index])^;
end;

{ TWBluetoothSocket }

procedure TWBluetoothSocket.AssignDefaultValue;
begin
  inherited AssignDefaultValue;
  FAddrFormat := AF_BTH;
  FProto := BTHPROTO_RFCOMM;
  FPortStr := '0';
end;

procedure TWBluetoothSocket.Connect;
var
  iStatus : integer;
  sin : TSockAddrBth;
begin
  if (FHSocket <> WinSock.INVALID_SOCKET) and (FState <> wsClosed) then begin
    RaiseException('Connect: Socket already in use');
    Exit;
  end;

  if not InitializeSocket then Exit;

  sin.addressFamily := AF_BTH;
  sin.btAddr := StrToInt64('$' + GetAddr);
  sin.serviceClassId := SerialPortServiceClass_UUID;
  sin.port := StrToInt(GetRemotePort);

  iStatus := WSocket_connect(FHSocket, WSocket.TSockAddr((@sin)^), sizeof(sin));
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
end;

function TWBluetoothSocket.InitializeSocket: boolean;
var
  iStatus: integer;
begin
  Result := false;
  FProtoResolved := true;

  DeleteBufferedData;
  FHSocket := WSocket_socket(FAddrFormat, FType, FProto);

  if FHSocket = WinSock.INVALID_SOCKET then begin
    SocketError('Connect (socket)');
    Exit;
  end;

  ChangeState(wsOpened);

  SetLingerOption;

  FSelectEvent := FD_READ or FD_WRITE or FD_CLOSE or FD_ACCEPT or FD_CONNECT;

  iStatus := WSocket_WSAASyncSelect(FHSocket, Handle, WM_ASYNCSELECT, FSelectEvent);
  if iStatus <> 0 then begin
    SocketError('WSAAsyncSelect');
    Exit;
  end;
  Result := true;
end;

function TWBluetoothSocket.GetConnectedDevices: TBtDevicesInfo;
const
  WSAQUERYSET_BUFFER_LENGTH = 1000;
var
  {
  deviceListBuf  : pointer;
  deviceListLen  : integer;
  iDevice        : integer;
  maxDevices     : integer;
  pDevice        : PBtDeviceInfo;
  }
  mustCloseSocket: boolean;
  RetCode: Integer;
  querySet: TWsaQuerySet;
  hLookup: THandle;
  flags: LongWord;
  buffer: array [0..WSAQUERYSET_BUFFER_LENGTH] of Byte;
  bufferLength: LongWord;

  pResults: PWsaQuerySet;
  pCSAddr: PCsAddrInfo;
begin
  Result := nil;
  if FHSocket = WinSock.INVALID_SOCKET then begin
    if not InitializeSocket then Exit
    else mustCloseSocket := true;
  end
  else mustCloseSocket := false;

  try
    FillChar(querySet, SizeOf(querySet), 0);

    querySet.dwSize := SizeOf(querySet);
    querySet.dwNameSpace := NS_BTH;

    flags := LUP_RETURN_NAME or LUP_CONTAINERS or LUP_RETURN_ADDR or LUP_FLUSHCACHE or LUP_RES_SERVICE;

    RetCode := WSALookupServiceBegin(@querySet, flags, hLookup);
    if RetCode = 0 then
    begin
      Result := TBtDevicesInfo.Create;

      bufferLength := SizeOf(buffer);
      pResults := PWsaQuerySet(@buffer);

      while WSALookupServiceNext(hLookup, flags, bufferLength, LPWSAQUERYSET(pResults)) = 0 do
      begin
        pCSAddr := PCsAddrInfo(pResults.lpcsaBuffer);

        Result.AddDeviceInfo(pResults.lpszServiceInstanceName, BTH_ADDR((@pCSAddr.RemoteAddr.lpSockaddr.sa_data)^));
      end;

      WSALookupServiceEnd(hLookup);
    end;
  finally
    if mustCloseSocket then Close;
  end;
end;

end.


