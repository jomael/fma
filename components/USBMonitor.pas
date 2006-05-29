unit USBMonitor;

{
*******************************************************************************
* Descriptions: Component to detect when usb devices are connected or
*   disconnected using RegisterDeviceNotification.
* $Source: /cvsroot/fma/fma/components/USBMonitor.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: USBMonitor.pas,v $
* Revision 1.1  2005/04/08 07:54:00  z_stoichev
* Added TDeviceMonitorUSB component.
*
*
}

interface

uses
  Windows, Messages, SysUtils, Classes, Forms;

type
  TDeviceMonitorUSB = class(TComponent)
  private
    FWindowHandle: HWND;
    FOnUSBArrival: TNotifyEvent;
    FOnUSBRemove: TNotifyEvent;
    procedure WndProc(var Msg: TMessage);
    function USBRegister: Boolean;
  protected
    procedure WMDeviceChange(var Msg: TMessage); dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property OnUSBArrival: TNotifyEvent read FOnUSBArrival write FOnUSBArrival;
    property OnUSBRemove: TNotifyEvent read FOnUSBRemove write FOnUSBRemove;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('FMA', [TDeviceMonitorUSB]);
end;

type
  PDevBroadcastHdr  = ^DEV_BROADCAST_HDR;
  DEV_BROADCAST_HDR = packed record
    dbch_size: DWORD;
    dbch_devicetype: DWORD;
    dbch_reserved: DWORD;
  end;

  PDevBroadcastDeviceInterface  = ^DEV_BROADCAST_DEVICEINTERFACE;
  DEV_BROADCAST_DEVICEINTERFACE = record
    dbcc_size: DWORD;
    dbcc_devicetype: DWORD;
    dbcc_reserved: DWORD;
    dbcc_classguid: TGUID;
    dbcc_name: short;
  end;

const
  GUID_DEVINTERFACE_USB_DEVICE: TGUID = '{A5DCBF10-6530-11D2-901F-00C04FB951ED}';
  DBT_DEVICEARRIVAL          = $8000;          // system detected a new device
  DBT_DEVICEREMOVECOMPLETE   = $8004;          // device is gone
  DBT_DEVTYP_DEVICEINTERFACE = $00000005;      // device interface class

constructor TDeviceMonitorUSB.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FWindowHandle := AllocateHWnd(WndProc);
  USBRegister;
end;

destructor TDeviceMonitorUSB.Destroy;
begin
  DeallocateHWnd(FWindowHandle);
  inherited Destroy;
end;

procedure TDeviceMonitorUSB.WndProc(var Msg: TMessage);
begin
  if (Msg.Msg = WM_DEVICECHANGE) then begin
    try
      WMDeviceChange(Msg);
    except
      Application.HandleException(Self);
    end;
  end
  else
    Msg.Result := DefWindowProc(FWindowHandle, Msg.Msg, Msg.wParam, Msg.lParam);
end;

procedure TDeviceMonitorUSB.WMDeviceChange(var Msg: TMessage);
var
  devType: Integer;
  Datos: PDevBroadcastHdr;
begin
  if (Msg.wParam = DBT_DEVICEARRIVAL) or (Msg.wParam = DBT_DEVICEREMOVECOMPLETE) then begin
    Datos := PDevBroadcastHdr(Msg.lParam);
    devType := Datos^.dbch_devicetype;
    if devType = DBT_DEVTYP_DEVICEINTERFACE then begin // USB Device
      if Msg.wParam = DBT_DEVICEARRIVAL then begin
        if Assigned(FOnUSBArrival) then
          FOnUSBArrival(Self);
      end
      else
      if Msg.wParam = DBT_DEVICEREMOVECOMPLETE then begin
        if Assigned(FOnUSBRemove) then
          FOnUSBRemove(Self);
      end;
    end;
  end;
end;

function TDeviceMonitorUSB.USBRegister: Boolean;
var
  dbi: DEV_BROADCAST_DEVICEINTERFACE;
  Size: Integer;
begin
  Size := SizeOf(DEV_BROADCAST_DEVICEINTERFACE);
  ZeroMemory(@dbi, Size);
  dbi.dbcc_size := Size;
  dbi.dbcc_devicetype := DBT_DEVTYP_DEVICEINTERFACE;
  dbi.dbcc_reserved := 0;
  dbi.dbcc_classguid  := GUID_DEVINTERFACE_USB_DEVICE;
  dbi.dbcc_name := 0;
  Result := Assigned(RegisterDeviceNotification(FWindowHandle, @dbi,
    DEVICE_NOTIFY_WINDOW_HANDLE));
end;

end.