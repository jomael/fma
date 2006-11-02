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
  TAlarmOriginator = (aoPhone, aoFMA);

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
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
    FAlarmID,FAlertNum: Integer;
    FAction: TAlarmExitAction;
    FCreator: TAlarmOriginator;
  public
    { Public declarations }
    procedure CreateAlarm(Text: WideString; AlphaBlend,AlarmID: Integer); // phone
    procedure CreateEvent(Text: WideString; AlphaBlend,AlarmID: Integer); // FMA
  end;

var
  frmNewAlarm: TfrmNewAlarm;

implementation

uses
  gnugettext, gnugettexthelpers, 
  uGlobal, Unit1, uThreadSafe, MMSystem;

{$R *.dfm}

const
  AlertCount: integer = 0;

procedure TfrmNewAlarm.CreateAlarm(Text: WideString; AlphaBlend,AlarmID: Integer);
begin
  AlphaBlendValue := AlphaBlend;
  FCreator := aoPhone;
  FAlarmID := AlarmID;
  lbText.Caption := Text;
  lbTime.Caption := DateTimeToStr(Now);
  FAction := aaDismiss; // default action
  AlarmTimer.Interval := 100;
  AlarmTimer.Enabled := True;
  FAlertNum := AlertCount + 1;
  AlertCount := FAlertNum;
  { Restore form position }
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
  Left := 100 + 24 * (Screen.FormCount mod 10);
  Top := Left + 24 * (Screen.FormCount div 10);
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
  case FCreator of
    aoPhone:
      case FAction of
        aaDismiss:
          s := 'AT+CAPD=0';   // dismisses the alarm
        aaPostpone:
          s := 'AT+CAPD=540'; // postpone for 9 minutes
        aaIgnore:
          exit;
      end;
    aoFMA:
      case FAction of
        aaDismiss: ; // do nothing
        aaPostpone:
          try
            // postpone for 9 minutes
            Form1.frmCalendarView.ClearAlertFlag(FAlarmID, Now + 9/MinsPerDay);
          except
          end;
        aaIgnore:
          exit;  
      end;
  end;
  { Postpone or dismiss alarm }
  FAction := aaIgnore;
  AlarmTimer.Enabled := False;
  //EnterCriticalSection(c);
  AlertCount := AlertCount - 1;
  //LeaveCriticalSection(c);
  try
    case FCreator of
      aoPhone:
        if Form1.FConnected and not Form1.FObex.Connected and not ThreadSafe.ObexConnecting then
          Form1.TxAndWait(s);
      aoFMA:
        Action := caFree; { Calendar events use new alarm dialog for each new event }
    end;
  except
  end;
end;

procedure TfrmNewAlarm.AlarmTimerTimer(Sender: TObject);
begin
  AlarmTimer.Interval := 5000;
  if AlertCount = FAlertNum then // only one source at a time!
    PlaySound(pChar('FMA_Alarm'), 0, SND_ASYNC or SND_APPLICATION or SND_NODEFAULT); // do not localize
end;

procedure TfrmNewAlarm.FormShow(Sender: TObject);
begin
  SetWindowPos(Handle, HWND_TOPMOST,
    Top, Left, Width, Height,
    SWP_NOACTIVATE);
end;

procedure TfrmNewAlarm.CreateEvent(Text: WideString; AlphaBlend,
  AlarmID: Integer);
begin
  CreateAlarm(Text,AlphaBlend,AlarmID);
  FCreator := aoFMA;
end;

procedure TfrmNewAlarm.FormHide(Sender: TObject);
begin
  FormPlacement1.SaveFormPlacement;
end;

end.
