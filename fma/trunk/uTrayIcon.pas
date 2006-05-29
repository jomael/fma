unit uTrayIcon;

{ WARNING!! This unit will not compile! Its for demontration only }

uses
  Windows, TntWindows, ShellAPI, uVersion;

interface

const
  ID_MYTRYICON = 101;
  WM_MYTRYICON = WM_USER + ID_MYTRYICON + 1;

  {$EXTERNALSYM NIN_SELECT}
  NIN_SELECT     = WM_USER + 0;
  {$EXTERNALSYM NINF_KEY}
  NINF_KEY       = $01;
  {$EXTERNALSYM NIN_KEYSELECT}
  NIN_KEYSELECT  = NIN_SELECT or NINF_KEY;
  {$EXTERNALSYM NIN_BALLOONSHOW}
  NIN_BALLOONSHOW      = WM_USER + 2;
  {$EXTERNALSYM NIN_BALLOONHIDE}
  NIN_BALLOONHIDE      = WM_USER + 3;
  {$EXTERNALSYM NIN_BALLOONTIMEOUT}
  NIN_BALLOONTIMEOUT   = WM_USER + 4;
  {$EXTERNALSYM NIN_BALLOONUSERCLICK}
  NIN_BALLOONUSERCLICK = WM_USER + 5;
  {$EXTERNALSYM NIM_SETFOCUS}
  NIM_SETFOCUS    = $00000003;
  {$EXTERNALSYM NIM_SETVERSION}
  NIM_SETVERSION  = $00000004;
  {$EXTERNALSYM NOTIFYICON_VERSION}
  NOTIFYICON_VERSION = 3;
  {$EXTERNALSYM NIF_STATE}
  NIF_STATE       = $00000008;
  {$EXTERNALSYM NIF_INFO}
  NIF_INFO        = $00000010;
  {$EXTERNALSYM NIF_GUID}
  NIF_GUID        = $00000020;
  {$EXTERNALSYM NIS_HIDDEN}
  NIS_HIDDEN       = $00000001;
  {$EXTERNALSYM NIS_SHAREDICON}
  NIS_SHAREDICON   = $00000002;
  // says this is the source of a shared icon
  // Notify Icon Infotip flags
  {$EXTERNALSYM NIIF_NONE}
  NIIF_NONE        = $00000000;
  // icon flags are mutualy exclusive
  // and take only the lowest 2 bits
  {$EXTERNALSYM NIIF_INFO}
  NIIF_INFO        = $00000001;
  {$EXTERNALSYM NIIF_WARNING}
  NIIF_WARNING     = $00000002;
  {$EXTERNALSYM NIIF_ERROR}
  NIIF_ERROR       = $00000003;
  {$EXTERNALSYM NIIF_ICON_MASK}
  NIIF_ICON_MASK   = $0000000F;
  {$EXTERNALSYM NIIF_NOSOUND}
  NIIF_NOSOUND     = $00000010;

  { Info Sender ID }
  SID_CPU          = $00010000;
  SID_CLIENT       = $00020000;
  SID_NETWORK      = $00030000;
  SID_OTHER        = $00040000;
  SID_MASK         = $000F0000;

type
  { Version 6 of NotifyIconData }
  TNotifyIconDataA = record
    cbSize: DWORD;
    Wnd: HWND;
    uID: UINT;
    uFlags: UINT;
    uCallbackMessage: UINT;
    hIcon: HICON;
    szTip: array [0..127] of AnsiChar;
    dwState: DWORD;
    dwStateMask: DWORD;
    szInfo: array [0..255] of AnsiChar;
    uTimeout: UINT;
    szInfoTitle: array [0..63] of AnsiChar;
    dwInfoFlags: DWORD;
    guidItem: TGUID;
  end;
  TNotifyIconDataW = record
    cbSize: DWORD;
    Wnd: HWND;
    uID: UINT;
    uFlags: UINT;
    uCallbackMessage: UINT;
    hIcon: HICON;
    szTip: array [0..127] of WideChar;
    dwState: DWORD;
    dwStateMask: DWORD;
    szInfo: array [0..255] of WideChar;
    uTimeout: UINT;
    szInfoTitle: array [0..63] of WideChar;
    dwInfoFlags: DWORD;
    guidItem: TGUID;
  end;
  TNotifyIconData = TNotifyIconDataA;

const
  {$EXTERNALSYM NOTIFYICONDATAA_V1_SIZE}
  NOTIFYICONDATAA_V1_SIZE = 88;
  {$EXTERNALSYM NOTIFYICONDATAW_V1_SIZE}
  NOTIFYICONDATAW_V1_SIZE = 152;
  {$EXTERNALSYM NOTIFYICONDATA_V1_SIZE}
  NOTIFYICONDATA_V1_SIZE  = NOTIFYICONDATAA_V1_SIZE;
  {$EXTERNALSYM NOTIFYICONDATAA_V2_SIZE}
  NOTIFYICONDATAA_V2_SIZE = sizeof(TNotifyIconDataA) - (sizeof(TGUID));
  {$EXTERNALSYM NOTIFYICONDATAW_V2_SIZE}
  NOTIFYICONDATAW_V2_SIZE = sizeof(TNotifyIconDataW) - (sizeof(TGUID));
  {$EXTERNALSYM NOTIFYICONDATA_V2_SIZE}
  NOTIFYICONDATA_V2_SIZE  = NOTIFYICONDATAA_V2_SIZE;

  { Usage, add to your form's declarations }
  procedure WMMYTRYICON(var Message: TMessage); message WM_MYTRYICON;

implementation

{ Sample usage procedures }

procedure TMainForm.WMMYTRYICON(var Message: TMessage);
var
  P: TPoint;
begin
  if Message.WParam = ID_MYTRYICON then
    case Message.LParam of
      WM_RBUTTONUP:
        begin
          GetCursorPos(P);
          PopupMenu1.Popup(P.X,P.Y);
        end;
      WM_LBUTTONDOWN,
      WM_LBUTTONDBLCLK:
        if Visible then Hide else Show;
      NIN_BALLOONHIDE,
      NIN_BALLOONTIMEOUT,
      NIN_BALLOONUSERCLICK:
        BaloonVisible := False;
    end;
end;

procedure TMainForm.ShowTrayIcon;
var
  R: TNotifyIconData;
begin
  FillChar(R,SizeOf(R),0);
  R.cbSize := NIBSize;
  R.Wnd := Handle;
  R.uID := ID_MYTRYICON;
  R.uFlags := NIF_ICON or NIF_TIP or NIF_MESSAGE;
  R.uCallbackMessage := WM_MYTRYICON;
  R.hIcon := Application.Icon.Handle;
  {}
  StrCopy(@R.szTip[0],PChar(Copy(Application.Title,1,63)));
  {
  if NIBSize = NOTIFYICONDATA_V1_SIZE then
    StrCopy(@R.szTip[0],PChar(Copy(Application.Title,1,63)))
  else
    R.szTip[0] := #0;
  }
  Shell_NotifyIcon(NIM_ADD,@R);
end;

procedure TMainForm.ToolipTrayIcon; // change tooltip
var
  R: TNotifyIconData;
  B: TRarBar;
begin
  FillChar(R,SizeOf(R),0);
  R.cbSize := NIBSize;
  R.Wnd := Handle;
  R.uID := ID_MYTRYICON;
  R.uFlags := NIF_TIP;
  StrCopy(@R.szTip[0],PChar(_('CPU utilization is too high!'),1,63)));
  Shell_NotifyIcon(NIM_MODIFY,@R);
end;

procedure TMainForm.InfoTrayIcon; // show baloon
var
  R: TNotifyIconData;
begin
  if not BaloonVisible and (Tooltips.Count <> 0) then
    begin
      FillChar(R,SizeOf(R),0);
      R.cbSize := NIBSize;
      R.Wnd := Handle;
      R.uID := ID_MYTRYICON;
      R.uFlags := NIF_INFO;
      R.uTimeout := 3000;
      { Remember which object has raised the baloon 
      R.dwInfoFlags := DWORD(AnObjectVariable) and NIIF_ICON_MASK;
      }
      StrCopy(@R.szInfo[0],PChar(Copy('Some text here...',1,255)));
      StrCopy(@R.szInfoTitle[0],PChar('Title'));
      Shell_NotifyIcon(NIM_MODIFY,@R);

      BaloonVisible := True;
    end;
end;

procedure TMainForm.HideTrayIcon;
var
  R: TNotifyIconData;
begin
  FillChar(R,SizeOf(R),0);
  R.cbSize := NIBSize;
  R.Wnd := Handle;
  R.uID := ID_MYTRYICON;
  R.uFlags := NIF_ICON;
  Shell_NotifyIcon(NIM_DELETE,@R);
end;

procedure TMainForm.CalculateTrayIconStructureSize;
var
  s: string;
begin
  SetLength(s,MAX_PATH);
  SetLength(s,GetSystemDirectory(PChar(s),MAX_PATH));
  s := ExtractFileVersionInfo(s+'\shell32.dll','FileVersion'); // do not localize
  if(s[1] = '6') then NIBSize := sizeof(TNotifyIconData)
    else if(s[1] = '5') then NIBSize := NOTIFYICONDATA_V2_SIZE
      else NIBSize := NOTIFYICONDATA_V1_SIZE;
end;

initialization
  CalculateTrayIconStructureSize;
end.
