unit FormVolumeCtrl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, AMixer, ComCtrls, Menus, ImgList, CoolTrayIcon,
{$IFNDEF VER150}
  ThemeMgr,
{$ENDIF}
  MMSystem, AppEvnts, uFormOsd, uVersion;

const
  sVersion: shortstring = '';

  WM_USERCOMMAND = WM_USER + 999;

  UC_TERMINATE = 1;

type
  TMouseControl = class(TControl)
  published
    property MouseCapture;
  end;  

  TFormVolumeDisp = class(TForm)
    ImageList1: TImageList;
    AMixer: TAudioMixer;
    Timer1: TTimer;
    CoolTrayIcon1: TCoolTrayIcon;
    PopupMenu1: TPopupMenu;
    Show1: TMenuItem;
    Options1: TMenuItem;
    About1: TMenuItem;
    N1: TMenuItem;
    Unload1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    Timer2: TTimer;
    Timer3: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AMixerControlChange(Sender: TObject; MixerH, ID: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Show1Click(Sender: TObject);
    procedure Unload1Click(Sender: TObject);
    procedure CoolTrayIcon1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ApplicationEvents1Deactivate(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure CoolTrayIcon1DblClick(Sender: TObject);
    procedure Options1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
  private
    { Private declarations }
    L,R,M: Integer;
    VD,MD,MS,Stereo,IsDoubleClick: Boolean;
    ConnectionName,MuteName: String;
    ControlMuted: boolean;
    MutedIndex: integer;
{$IFNDEF VER150}
    ThemeManager1: TThemeManager;
{$ENDIF}
    function GetVolControlName(AControlID: cardinal; var DestinationID,ConnectionID: integer): string;
  protected
    procedure WM_ENDSESSION(var Msg: TMessage); message WM_ENDSESSION;
    procedure WM_USERCOMMAND(var Msg: TMessage); message WM_USERCOMMAND;
  public
    { Public declarations }
    OSD: TFormOSD;
    FDestinationID, FConnectionID: Integer;
    FGradualVol: Boolean;
    function GetMute(ADestinationID: integer = 0; AConnectionID: Integer = -1): Boolean;
    function GetVolume(ADestinationID: integer = 0; AConnectionID: Integer = -1): Integer;
    procedure SetMute(Mute: Boolean);
    procedure SetVolume(Percentage: Integer);
    procedure ShowOSD;
  end;

var
  FormVolumeDisp: TFormVolumeDisp;

implementation

uses
  FormVolume, FormOptions, VolumeCtrlCoClass;

{$R *.dfm}
{$R WinXP.res}

procedure TFormVolumeDisp.FormShow(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_HIDE);
  ShowWindow(OSD.Handle, SW_HIDE);

  AMixerControlChange(Self, 0, 0);
end;

function TFormVolumeDisp.GetMute(ADestinationID, AConnectionID: Integer): Boolean;
begin
  AMixer.GetMute (ADestinationID,AConnectionID, MD);
  AMixer.GetVolume (ADestinationID,AConnectionID,L,R,M,Stereo,VD,MD,MS);

  Result := M<>0;
end;

function TFormVolumeDisp.GetVolume(ADestinationID, AConnectionID: Integer): Integer;
begin
  AMixer.GetMute (ADestinationID,AConnectionID, MD);
  AMixer.GetVolume (ADestinationID,AConnectionID,L,R,M,Stereo,VD,MD,MS);

  Result := Round(((L+R)/2)/65536 * 100);
end;

procedure TFormVolumeDisp.SetMute(Mute: Boolean);
begin
  AMixer.SetVolume (FDestinationID,FConnectionID,L,-1,Integer(Mute));
  CoolTrayIcon1.IconIndex := byte(Mute);
end;

procedure TFormVolumeDisp.SetVolume(Percentage: Integer);
  var
    I, Vol: Integer;
begin
  if Percentage < 0 then Percentage := 0;
  if FGradualVol then
  begin
    Vol := GetVolume(FDestinationID,FConnectionID);
    if Percentage > Vol then
    begin
      for I := Vol + 1 to Percentage do
      begin
        AMixer.SetVolume (FDestinationID,FConnectionID,Round(I*65536/100),-1,M);
        Sleep(20);
      end;
    end
    else
    begin
      for I := Vol - 1 downto Percentage do
      begin
        AMixer.SetVolume (FDestinationID,FConnectionID,Round(I*65536/100),-1,M);
        Sleep(20);
      end;
    end;
  end
  else AMixer.SetVolume (FDestinationID,FConnectionID,Round(Percentage*65536/100),-1,M);
end;

procedure TFormVolumeDisp.AMixerControlChange(Sender: TObject; MixerH, ID: Integer);
var
  DestinationID,ConnectionID: integer;
begin
  Timer1.Enabled := False;
  Timer1.Enabled := True;

  OSD.SetOSD(True);

  try
    ConnectionName := ' ' + UpperCase(GetVolControlName(ID,DestinationID,ConnectionID)) + ' ';
    ControlMuted := GetMute(DestinationID,ConnectionID);
    MuteName := IntToStr(GetVolume(DestinationID,ConnectionID)) + '%';
    MutedIndex := integer(GetMute);
    Timer3.Enabled := True;
  except
  end;
end;

procedure TFormVolumeDisp.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  Timer3.Enabled := False;

  OSD.SetOSD(False);
end;

procedure TFormVolumeDisp.Timer3Timer(Sender: TObject);
var
  i,w: integer;
begin
  Timer3.Enabled := False;
  if OSD.Label2.Caption <> ConnectionName then begin
    OSD.Label2.Caption := ConnectionName;
    OSD.Label4.Caption := OSD.Label2.Caption;
    OSD.Label2.Height := 19;
    OSD.Label4.Height := 19;
  end;
  if OSD.Label1.Caption <> MuteName then begin
    OSD.Label1.Caption := MuteName;
    OSD.Label3.Caption := OSD.Label1.Caption;
  end;
  if (ColorToRGB(OSD.Label1.Font.Color) <> clLime) <> ControlMuted then
    if ControlMuted then begin
      OSD.Label1.Font.Color := $00A0A0FF;
      OSD.Label3.Font.Color := $00404080;
    end
    else begin
      OSD.Label1.Font.Color := clLime;
      OSD.Label3.Font.Color := clGreen;
    end;
  i := OSD.Label1.Width + 4;
  if i < OSD.Label2.Width then i := OSD.Label2.Width;
  w := OSD.ClientWidth - i - 2;
  if FormSettings.RadioButton3.Checked or FormSettings.RadioButton4.Checked then
    OSD.Left := OSD.Left + w; 
  OSD.ClientWidth := i + 2;
  if CoolTrayIcon1.IconIndex <> MutedIndex then
    CoolTrayIcon1.IconIndex := MutedIndex;
end;

procedure TFormVolumeDisp.FormCreate(Sender: TObject);
begin
{$IFNDEF VER150}
  ThemeManager1 := TThemeManager.Create(Self);
{$ENDIF}
  OSD := TFormOSD.Create(Self);
  Left := 1;
  Top := 1;
  Width := 1;
  Height := 1;
  TransparentColorValue := ColorToRGB(Color);
  TransparentColor := True;
  FDestinationID := 0;
  FConnectionID := -1;
  CoolTrayIcon1.Hint := Application.Title;
  CoolTrayIcon1.IconIndex := byte(GetMute);
  sVersion := ExtractFileVersionInfo(Application.ExeName,'FileVersion');
  FGradualVol := False;
end;

procedure TFormVolumeDisp.ShowOSD;
begin
  AMixerControlChange(Self, 0, 0);
end;

procedure TFormVolumeDisp.Show1Click(Sender: TObject);
begin
  ShowOSD;
end;

procedure TFormVolumeDisp.Unload1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormVolumeDisp.CoolTrayIcon1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then begin
    Timer2.Enabled := False;
    Timer2.Enabled := not IsDoubleClick;
    IsDoubleClick := False;
  end;
end;

procedure TFormVolumeDisp.ApplicationEvents1Deactivate(Sender: TObject);
begin
  if FormVolumeBar.Visible then FormVolumeBar.Hide;
end;

procedure TFormVolumeDisp.Timer2Timer(Sender: TObject);
var
  p: TPoint;
begin
  Timer2.Enabled := False;
  GetCursorPos(p);
  Application.BringToFront;
  FormVolumeBar.ShowAt(p.X,p.Y);
end;

procedure TFormVolumeDisp.Options1Click(Sender: TObject);
begin
  Application.BringToFront;
  FormSettings.PageControl1.ActivePageIndex := 0;
  FormSettings.Show;
end;

procedure TFormVolumeDisp.CoolTrayIcon1DblClick(Sender: TObject);
begin
  IsDoubleClick := True;
  Show1.Click;
end;

procedure TFormVolumeDisp.About1Click(Sender: TObject);
begin
  Application.BringToFront;
  FormSettings.PageControl1.ActivePage := FormSettings.TabSheetAbout;
  FormSettings.Show;
end;

procedure TFormVolumeDisp.PopupMenu1Popup(Sender: TObject);
begin
  Unload1.Enabled := FormSettings.IsMainApplication;
end;

function TFormVolumeDisp.GetVolControlName(AControlID: cardinal; var DestinationID,ConnectionID: integer): string;
var
  MD: TMixerDestination;
  MC: TMixerConnection;
  Cntrls: TMixerControls;
  Cntrl: PMixerControl;
  i,j,k: integer;
begin
  Result := 'Master Volume';
  DestinationID := 0;
  ConnectionID := -1;
  with AMixer do begin
    If not Assigned (Destinations) then Exit;
    for i := 0 to Destinations.Count-1 do begin
      MD := Destinations[i];
      If MD <> nil then begin
        for j := 0 to MD.Connections.Count-1 do begin
          MC := MD.Connections[j];
          If MC <> nil then begin
            Cntrls := MC.Controls;
            if Cntrls <> nil then
              for k := 0 to Cntrls.Count-1 do begin
                Cntrl := Cntrls[k];
                if Cntrl <> nil then
                  if Cntrl.dwControlID = AControlID then begin
                    Result := StrPas(Cntrl.szName);
                    DestinationID := i;
                    ConnectionID := j;
                    exit;
                  end;
              end;
          end
        end;
      end;
    end;
  end;
end;

procedure TFormVolumeDisp.WM_ENDSESSION(var Msg: TMessage);
begin
  if Boolean(Msg.WParam) then Unload1.Click;
  Msg.Result := 0;
end;

procedure TFormVolumeDisp.ApplicationEvents1Minimize(Sender: TObject);
begin
  if FormVolumeBar.Visible then FormVolumeBar.Hide;
  { Do not allow application to be minimized }
  Application.Restore;
end;

procedure TFormVolumeDisp.WM_USERCOMMAND(var Msg: TMessage);
begin
  case Msg.WParam of
    UC_TERMINATE: Unload1.Click;
  end;
  Msg.Result := 0;
end;

end.

