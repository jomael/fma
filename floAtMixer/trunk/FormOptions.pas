unit FormOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Registry, ExtCtrls, CoolTrayIcon, ComCtrls, jpeg;

type
  TFormSettings = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Timer1: TTimer;
    PageControl1: TPageControl;
    TabSheetMediaCtrl: TTabSheet;
    TabSheetVolumeCtrl: TTabSheet;
    TabSheetMouseCtrl: TTabSheet;
    TabSheetAbout: TTabSheet;
    GroupBox3: TGroupBox;
    cbAutoStartup: TCheckBox;
    cbLoadTrayIcon: TCheckBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    LabelAccel: TLabel;
    LabelStartSpeed: TLabel;
    TrackBarAccel: TTrackBar;
    TrackBarStarSpeed: TTrackBar;
    Image1: TImage;
    Label9: TLabel;
    LabelVersion: TLabel;
    TabSheet1: TTabSheet;
    GroupBox4: TGroupBox;
    TrackBarPosX: TTrackBar;
    Label11: TLabel;
    Label12: TLabel;
    TrackBarPosY: TTrackBar;
    GroupBox5: TGroupBox;
    Label14: TLabel;
    LabelCOMObjectCount: TLabel;
    Label15: TLabel;
    LabelCanUnload: TLabel;
    GroupBox6: TGroupBox;
    Label13: TLabel;
    lblLink1: TLabel;
    ButtonReset: TButton;
    cbShowOSD: TCheckBox;
    Button4: TButton;
    GroupBox1: TGroupBox;
    Label10: TLabel;
    lblLink2: TLabel;
    GroupBox7: TGroupBox;
    Memo1: TMemo;
    Panel1: TPanel;
    Image3: TImage;
    Label16: TLabel;
    Label17: TLabel;
    Image2: TImage;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ButtonResetClick(Sender: TObject);
    procedure TrackBarAccelChange(Sender: TObject);
    procedure TrackBarStarSpeedChange(Sender: TObject);
    procedure TabSheetAboutShow(Sender: TObject);
    procedure PositionClick(Sender: TObject);
    procedure WebLinkClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
    IconMutex: THandle;
    FMixerInstCount: integer;
    FShownByAutoObj,FLoadingSettings: boolean;
    procedure ReleaseIconMutex;
    function Get_ProcID: cardinal;
    procedure Set_ProcID(const Value: cardinal);
  public
    { Public declarations }
    procedure LoadSettings;
    procedure SaveSettings;
    procedure UpdateTrayIcon;
    procedure UpdateCoClass(Increase: boolean);
    function IsMainApplication: boolean;
  published
    property MixerInstCount: integer read FMixerInstCount;
    property InstanceProcID: cardinal read Get_ProcID write Set_ProcID;
  end;

var
  FormSettings: TFormSettings;
  
implementation

uses
  FormVolumeCtrl, ComObj, MouseCtrlCoClass, ShellAPI;

{$R *.dfm}

const
  sProcessID = 'Running Process';
  sFmaKey = 'Software\float\mixer';
  sStartupKey = 'Software\Microsoft\Windows\CurrentVersion\Run';

  sHideTrayIcon = 'Hide Tray Icon';
  sHideOSD = 'Hide OSD';

  sOSDPosition = 'OSD Position';
  sOSDOffsetX = 'OSD Offset X';
  sOSDOffsetY = 'OSD Offset Y';

  sVolemGradual = 'Volume Gradual';

  sMouseAccel = 'Mouse Acceleration';
  sMouseStartSpeed = 'Mouse Start Speed';

procedure TFormSettings.FormCreate(Sender: TObject);
begin
  lblLink1.Font.Style := lblLink1.Font.Style + [fsUnderline];
  lblLink1.Font.Color := clBlue;
  lblLink2.Font.Style := lblLink2.Font.Style + [fsUnderline];
  lblLink2.Font.Color := clBlue;
  LoadSettings;
end;

procedure TFormSettings.Button2Click(Sender: TObject);
begin
  LoadSettings;
  Close;
end;

procedure TFormSettings.FormShow(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_Hide);
  LoadSettings;
  Button1.SetFocus;
end;

procedure TFormSettings.LoadSettings;
begin
  with TRegistry.Create do
  try
    FLoadingSettings := True;
    RootKey := HKEY_CURRENT_USER;
    cbLoadTrayIcon.Checked := True;
    cbShowOSD.Checked := True;
    if OpenKey(sFmaKey,false) then
      try
        if ValueExists(sHideTrayIcon) and ReadBool(sHideTrayIcon) then
          cbLoadTrayIcon.Checked := False;
        if ValueExists(sHideOSD) and ReadBool(sHideOSD) then
          cbLoadTrayIcon.Checked := False;

        if ValueExists(sMouseAccel) then TrackBarAccel.Position := ReadInteger(sMouseAccel);
        if ValueExists(sMouseStartSpeed) then TrackBarStarSpeed.Position := ReadInteger(sMouseStartSpeed);
        if ValueExists(sOSDPosition) then
          case ReadInteger(sOSDPosition) of
            1: RadioButton1.Checked := True;
            2: RadioButton2.Checked := True;
            3: RadioButton3.Checked := True;
            4: RadioButton4.Checked := True;
          end;
        if ValueExists(sOSDOffsetX) then TrackBarPosX.Position := ReadInteger(sOSDOffsetX);
        if ValueExists(sOSDOffsetY) then TrackBarPosY.Position := ReadInteger(sOSDOffsetY);
      finally
        CloseKey;
      end;

    cbAutoStartup.Checked := False;
    if OpenKey(sStartupKey,false) then
      try
        if ValueExists(Application.Title) and
          (CompareText(ReadString(Application.Title),AnsiQuotedStr(Application.ExeName,'"')) = 0) then
          cbAutoStartup.Checked := True;
      finally
        CloseKey;
      end;
  finally
    Free;
    FLoadingSettings := False;
  end;
end;

procedure TFormSettings.SaveSettings;
begin
  with TRegistry.Create do
  try
    RootKey := HKEY_CURRENT_USER;
    if OpenKey(sFmaKey,True) then
      try
        WriteBool(sHideTrayIcon,not cbLoadTrayIcon.Checked);
        WriteBool(sHideOSD,not cbShowOSD.Checked);

        WriteInteger(sMouseAccel, TrackBarAccel.Position);
        WriteInteger(sMouseStartSpeed, TrackBarStarSpeed.Position);
        if RadioButton1.Checked then WriteInteger(sOSDPosition,1);
        if RadioButton2.Checked then WriteInteger(sOSDPosition,2);
        if RadioButton3.Checked then WriteInteger(sOSDPosition,3);
        if RadioButton4.Checked then WriteInteger(sOSDPosition,4);
        WriteInteger(sOSDOffsetX,TrackBarPosX.Position);
        WriteInteger(sOSDOffsetY,TrackBarPosY.Position);
      finally
        CloseKey;
      end;
    if OpenKey(sStartupKey,false) then
      try
        if cbAutoStartup.Checked then WriteString(Application.Title,AnsiQuotedStr(Application.ExeName,'"'))
          else DeleteValue(Application.Title);
      finally
        CloseKey;
      end;
  finally
    Free;
  end;
end;

procedure TFormSettings.Button1Click(Sender: TObject);
begin
  if not cbLoadTrayIcon.Checked and (MessageDlg(Application.Title + #13#13 +
    'If you hide tray management icon you will not be able to access this application anymore and '+
    'it will remain resident in memory. In order to stop it, you will have to kill it via Task Manager. '#13#13+
    'Are you sure you want to continue?',mtConfirmation,[mbYes,mbNo],0) <> mrYes) then begin
      cbLoadTrayIcon.Checked := True;
      exit;
    end;
  SaveSettings;
  FormVolumeDisp.CoolTrayIcon1.IconVisible := cbLoadTrayIcon.Checked;
  Close;
end;

procedure TFormSettings.Timer1Timer(Sender: TObject);
var
  CanShowIcon: boolean;
begin
  Timer1.Enabled := False;
  { Only first instance will show tray icon, others not }
  CanShowIcon := MixerInstCount <= 1;
  if CanShowIcon then begin
    { First instance with or without COM object }
    IconMutex := CreateMutex(nil,True,'floAtMixerIconMutex');
    if GetLastError = ERROR_ALREADY_EXISTS then begin
      if MixerInstCount = 0 then begin
        { Second instance without COM object }
        if FindCmdLineSwitch('U') then
          SendMessage(InstanceProcID, WM_USERCOMMAND, UC_TERMINATE, 0);
        Application.Terminate;
      end;
      CanShowIcon := False;
    end
    else 
      if FindCmdLineSwitch('U') then begin
        { First instance with /U switch }
        Application.Terminate;
        CanShowIcon := False;
      end;
    { Is COM object created? }
    FShownByAutoObj := MixerInstCount <> 0;
  end;
  if CanShowIcon then
    InstanceProcID := FormVolumeDisp.Handle; // GetCurrentProcessId;
  FormVolumeDisp.CoolTrayIcon1.IconVisible := CanShowIcon;
end;

procedure TFormSettings.UpdateTrayIcon;
begin
  Timer1.Enabled := False;
  if cbLoadTrayIcon.Checked then Timer1.Enabled := True
    else FormVolumeDisp.CoolTrayIcon1.IconVisible := False;
end;

function TFormSettings.IsMainApplication: boolean;
begin
  Result := MixerInstCount = 0;
end;

procedure TFormSettings.UpdateCoClass(Increase: boolean);
begin
  if Increase then begin
    inc(FMixerInstCount);
    UpdateTrayIcon;
  end  
  else begin
    dec(FMixerInstCount);
    if FShownByAutoObj then ReleaseIconMutex;
  end;
  LabelCOMObjectCount.Caption := IntToStr(FMixerInstCount);
  if FMixerInstCount <> 0 then LabelCanUnload.Caption := 'No'
    else LabelCanUnload.Caption := 'Yes';
end;

procedure TFormSettings.FormDestroy(Sender: TObject);
begin
  if not FShownByAutoObj then ReleaseIconMutex;
end;

procedure TFormSettings.ReleaseIconMutex;
begin
  if (MixerInstCount = 0) and (IconMutex <> 0) then begin
    ReleaseMutex(IconMutex);
    IconMutex := 0;
    { Exiting from first instance? }
    if FormVolumeDisp.CoolTrayIcon1.IconVisible then
      InstanceProcID := 0;
  end;
end;

procedure TFormSettings.ButtonResetClick(Sender: TObject);
begin
  TrackBarAccel.Position := 50;
  TrackBarStarSpeed.Position := 85;
end;

procedure TFormSettings.TrackBarAccelChange(Sender: TObject);
begin
  LabelAccel.Caption := IntToStr(TrackBarAccel.Position);
end;

procedure TFormSettings.TrackBarStarSpeedChange(Sender: TObject);
begin
  LabelStartSpeed.Caption := IntToStr(TrackBarStarSpeed.Position);
end;

procedure TFormSettings.TabSheetAboutShow(Sender: TObject);
begin
  LabelVersion.Caption := 'Version ' + sVersion;
end;

procedure TFormSettings.PositionClick(Sender: TObject);
begin
  { Show OSD by default on startup if switch /U not specified }
  if not FLoadingSettings then
    FormVolumeDisp.ShowOSD;
end;

function TFormSettings.Get_ProcID: cardinal;
begin
  Result := 0;
  with TRegistry.Create do
  try
    RootKey := HKEY_CURRENT_USER;
    if OpenKey('software\float\mixer',True) then
      try
        if ValueExists(sProcessID) then Result := ReadInteger(sProcessID);
      finally
        CloseKey;
      end;
  finally
    Free;
  end;
end;

procedure TFormSettings.Set_ProcID(const Value: cardinal);
begin
  with TRegistry.Create do
  try
    RootKey := HKEY_CURRENT_USER;
    if OpenKey('software\float\mixer',True) then
      try
        WriteInteger(sProcessID,Value);
      finally
        CloseKey;
      end;
  finally
    Free;
  end;
end;

procedure TFormSettings.WebLinkClick(Sender: TObject);
begin
  ShellExecute(Handle,'open',PChar((Sender as TLabel).Hint),'','',SW_SHOWNORMAL);
end;

procedure TFormSettings.Button4Click(Sender: TObject);
begin
  RadioButton1.Checked := True;
  TrackBarPosX.Position := 0;
  TrackBarPosY.Position := 0;
  cbShowOSD.Checked := True;
end;

end.

