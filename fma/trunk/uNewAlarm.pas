unit uNewAlarm;

{
*******************************************************************************
* Descriptions: Alarm popup dialog
* $Source: /cvsroot/fma/fma/Attic/uNewAlarm.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uNewAlarm.pas,v $
*
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TntStdCtrls, ExtCtrls, TntExtCtrls, Placemnt,
  ComCtrls, TntComCtrls;

type
  TAlarmExitAction = (aaIgnore, aaPostpone, aaDismiss);

  TfrmNewAlarm = class(TForm)
    FormPlacement1: TFormPlacement;
    Image1: TTntImage;
    PostponeButton: TTntButton;
    CloseButton: TTntButton;
    lbText: TTntLabel;
    lbTime: TTntLabel;
    Image2: TImage;
    AlarmTimer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure PostponeButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AlarmTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FAlarmID: Integer;
    FAction: TAlarmExitAction;
  public
    { Public declarations }
    procedure CreateAlarm(Text: WideString; AlphaBlend,AlarmID: Integer);
  end;

var
  frmNewAlarm: TfrmNewAlarm;

implementation

uses
  gnugettext, gnugettexthelpers,
  uGlobal, Unit1, uThreadSafe, MMSystem;

{$R *.dfm}

procedure TfrmNewAlarm.CreateAlarm(Text: WideString; AlphaBlend,AlarmID: Integer);
begin
  AlphaBlendValue := AlphaBlend;
  FAlarmID := AlarmID;
  lbText.Caption := Text;
  lbTime.Caption := DateTimeToStr(Now);
  FAction := aaDismiss; // default action
  AlarmTimer.Interval := 100;
  AlarmTimer.Enabled := True;
  FormPlacement1.RestoreFormPlacement;
  Application.ProcessMessages;
  { Show window but not activate it
  SetWindowPos(Handle, HWND_TOPMOST,
    Top, Left, Width, Height,
    SWP_NOACTIVATE);
  ShowWindow(Handle,SW_SHOWNOACTIVATE);
  ShowWindow(PostponeButton.Handle,SW_SHOWNOACTIVATE);
  ShowWindow(CloseButton.Handle,SW_SHOWNOACTIVATE);
  }
  Show;
end;

procedure TfrmNewAlarm.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);

  Image1.Picture.Assign(Form1.CommonBitmaps.Bitmap[1]);
end;

procedure TfrmNewAlarm.CloseButtonClick(Sender: TObject);
begin
  FAction := aaDismiss;
  Close;
end;

procedure TfrmNewAlarm.PostponeButtonClick(Sender: TObject);
begin
  FAction := aaPostpone;
  Close;
end;

procedure TfrmNewAlarm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  s: String;
begin
  case FAction of
    aaDismiss:  s := 'AT+CAPD=0';   // dismisses the alarm
    aaPostpone: s := 'AT+CAPD=540'; // postpone for 9 minutes
    aaIgnore: Exit;
  end;
  { Postpone or dismiss alarm }
  FAction := aaIgnore;
  AlarmTimer.Enabled := False;
  try
    if Form1.FConnected and not Form1.FObex.Connected and not ThreadSafe.ObexConnecting then
      Form1.TxAndWait(s);
  except
  end;
end;

procedure TfrmNewAlarm.AlarmTimerTimer(Sender: TObject);
begin
  AlarmTimer.Interval := 5000;
  PlaySound(pChar('FMA_Alarm'), 0, SND_ASYNC or SND_APPLICATION or SND_NODEFAULT); // do not localize
end;

procedure TfrmNewAlarm.FormShow(Sender: TObject);
begin
  SetWindowPos(Handle, HWND_TOPMOST,
    Top, Left, Width, Height,
    SWP_NOACTIVATE);
end;

end.
