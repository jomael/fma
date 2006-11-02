unit uEditEvent;

{
*******************************************************************************
* Descriptions: Edit Calendar Event
* $Source: /cvsroot/fma/fma/uEditEvent.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uEditEvent.pas,v $
*
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics,
  Controls, TntControls, Forms, TntForms, Dialogs, TntDialogs, ExtCtrls, TntExtCtrls, StdCtrls, TntStdCtrls,
  ComCtrls, TntComCtrls, UniTntCtrls, Buttons, TntButtons, Menus, TntMenus, VpData, VpMisc,
  MPlayer;

type
  TfrmEditEvent = class(TTntForm)
    PageControl1: TTntPageControl;
    TabSheet1: TTntTabSheet;
    Image1: TTntImage;
    Bevel1: TTntBevel;
    Label1: TTntLabel;
    txtLocation: TTntEdit;
    txtSubject: TTntEdit;
    Label2: TTntLabel;
    OkButton: TTntButton;
    CancelButton: TTntButton;
    TabSheet5: TTntTabSheet;
    Label3: TTntLabel;
    txtOutlookID: TTntEdit;
    Label25: TTntLabel;
    txtFileAs: TTntEdit;
    Label4: TTntLabel;
    TntComboBoxCategories: TTntComboBox;
    TntDatePickerStart: TTntDateTimePicker;
    Label5: TTntLabel;
    Label6: TTntLabel;
    TntTimePickerStart: TTntDateTimePicker;
    Bevel2: TTntBevel;
    Label7: TTntLabel;
    Label8: TTntLabel;
    TntTimePickerEnd: TTntDateTimePicker;
    TntDatePickerEnd: TTntDateTimePicker;
    TntComboBoxDuration: TTntComboBox;
    Label9: TTntLabel;
    TabSheet2: TTntTabSheet;
    TntRadioGroupReminder: TTntRadioGroup;
    lblName: TTntLabel;
    Image2: TTntImage;
    lblName2: TTntLabel;
    Bevel3: TTntBevel;
    Image3: TTntImage;
    lblName3: TTntLabel;
    Bevel4: TTntBevel;
    TabSheet3: TTntTabSheet;
    TntBevel1: TTntBevel;
    Image4: TTntImage;
    lblName4: TTntLabel;
    TntRadioGroupReccurence: TTntRadioGroup;
    lblDisabledReccurence: TTntLabel;
    TntLabel3: TTntLabel;
    TntComboBoxRangeEnd: TTntComboBox;
    Label26: TTntLabel;
    Label10: TTntLabel;
    TntTimePickerReminder: TTntDateTimePicker;
    TntDatePickerReminder: TTntDateTimePicker;
    TntLabel2: TTntLabel;
    TntDatePickerReccurence: TTntDateTimePicker;
    TntTimePickerReccurence: TTntDateTimePicker;
    TntLabel1: TTntLabel;
    TntLabel4: TTntLabel;
    TntCheckBox1: TTntCheckBox;
    TntCheckBox2: TTntCheckBox;
    TntCheckBox3: TTntCheckBox;
    TntCheckBox4: TTntCheckBox;
    TntCheckBox7: TTntCheckBox;
    TntCheckBox6: TTntCheckBox;
    TntCheckBox5: TTntCheckBox;
    GroupBox2: TTntGroupBox;
    Label14: TTntLabel;
    Label16: TTntLabel;
    Label17: TTntLabel;
    imgSnd: TTntImage;
    lblSndType: TTntLabel;
    lblSndName: TTntLabel;
    lblSndSize: TTntLabel;
    TntButton1: TTntButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure TntRadioGroupReminderClick(Sender: TObject);
    procedure DurationChange(Sender: TObject);
    procedure StartDateTimeChange(Sender: TObject);
    procedure EndDateTimeChange(Sender: TObject);
    procedure txtSubjectChange(Sender: TObject);
    procedure TntDatePickerReminderChange(Sender: TObject);
    procedure TntRadioGroupReccurenceClick(Sender: TObject);
    procedure TntComboBoxRangeEndChange(Sender: TObject);
    procedure TntDatePickerReccurenceChange(Sender: TObject);
    procedure TntButton1Click(Sender: TObject);
  private
    { Private declarations }
    FAlarmAdv,FPrevWeekDay: integer;
    FAlarmAdvType: TVpAlarmAdvType;
    function GetDayCheck(Day: Integer): TTntCheckbox;
    procedure DoSanityCheck;
    function GetReminderStartVisible: boolean;
    procedure SetReminderStartVisible(const Value: boolean);
    function GetReccurenceEndVisible: boolean;
    procedure SetReccurenceEndVisible(const Value: boolean);
    function GetReccuWeekDaysVisible: boolean;
    procedure SetReccuWeekDaysVisible(const Value: boolean);
    function GetWeekDays: WideString;
    procedure SetWeekDays(const Value: WideString);
  public
    { Public declarations }
    procedure UpdateAlarm;
    procedure UpdateAlarmAdv;
    procedure UpdateDudation;
    procedure UpdateWeekDays;
    property WeekDays: WideString read GetWeekDays write SetWeekDays;
    property AdvMins: Integer read FAlarmAdv write FAlarmAdv;
    property AdvType: TVpAlarmAdvType read FAlarmAdvType write FAlarmAdvType;
    property ReminderStartVisible: boolean read GetReminderStartVisible write SetReminderStartVisible;
    property ReccurenceEndVisible: boolean read GetReccurenceEndVisible write SetReccurenceEndVisible;
    property ReccuWeekDaysVisible: boolean read GetReccuWeekDaysVisible write SetReccuWeekDaysVisible;
  end;

var
  frmEditEvent: TfrmEditEvent;

implementation

uses
  gnugettext, gnugettexthelpers,
  DateUtils, Math, Unit1, uVCalendar;

{$R *.dfm}

procedure TfrmEditEvent.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);
  lblSndType.Left := imgSnd.Left + imgSnd.Width + 4;
  lblSndName.Left := Label14.Left + Label14.Width + 4;
  lblSndSize.Left := Label16.Left + Label16.Width + 4;

  lblSndType.Caption := _('(polyphonic stereo sound, supported by phone)');
  lblSndName.Caption := '';
  lblSndSize.Caption := _('0,0 KB (0 bytes)');

  // gghTranslateComponent changing combo item index :/ set it manually.
  TntComboBoxDuration.ItemIndex := 4;
  TntComboBoxRangeEnd.ItemIndex := 0;

  Image2.Picture.Assign(Image1.Picture);
  Image3.Picture.Assign(Image1.Picture);
  Image4.Picture.Assign(Image1.Picture);

{$IFNDEF VER150}
  Form1.ThemeManager1.CollectForms(Self);
{$ENDIF}
end;

procedure TfrmEditEvent.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  FPrevWeekDay := 0;

  TabSheet3.Enabled := Form1.IsK610orBetter;
  lblDisabledReccurence.Visible := not TabSheet3.Enabled;
  StartDateTimeChange(nil);
  TntRadioGroupReccurenceClick(nil);

  txtSubject.SetFocus;
end;

procedure TfrmEditEvent.OkButtonClick(Sender: TObject);
begin
  DoSanityCheck;
  ModalResult := mrOk;
end;

procedure TfrmEditEvent.DoSanityCheck;
begin
//  raise EConvertError.Create(_('You have to enter valid entry'));
end;

procedure TfrmEditEvent.TntRadioGroupReminderClick(Sender: TObject);
begin
  ReminderStartVisible := TntRadioGroupReminder.ItemIndex <> 0;

  case TntRadioGroupReminder.ItemIndex of
    0: begin
         TntDatePickerReminder.DateTime := TntDatePickerStart.DateTime;
         TntTimePickerReminder.DateTime := TntDatePickerStart.DateTime;
       end;
    1: begin
         TntDatePickerReminder.DateTime := TntDatePickerStart.DateTime;
         TntTimePickerReminder.DateTime := TntDatePickerStart.DateTime;
       end;
    2: begin
         TntDatePickerReminder.DateTime := IncMinute(TntDatePickerStart.DateTime, -5);
         TntTimePickerReminder.DateTime := IncMinute(TntDatePickerStart.DateTime, -5);
       end;
    3: begin
         TntDatePickerReminder.DateTime := IncMinute(TntDatePickerStart.DateTime, -10);
         TntTimePickerReminder.DateTime := IncMinute(TntDatePickerStart.DateTime, -10);
       end;
    4: begin
         TntDatePickerReminder.DateTime := IncMinute(TntDatePickerStart.DateTime, -15);
         TntTimePickerReminder.DateTime := IncMinute(TntDatePickerStart.DateTime, -15);
       end;
    5: begin
         TntDatePickerReminder.DateTime := IncMinute(TntDatePickerStart.DateTime, -30);
         TntTimePickerReminder.DateTime := IncMinute(TntDatePickerStart.DateTime, -30);
       end;
    6: begin
         TntDatePickerReminder.DateTime := IncHour(TntDatePickerStart.DateTime, -1);
         TntTimePickerReminder.DateTime := IncHour(TntDatePickerStart.DateTime, -1);
       end;
    7: begin
         TntDatePickerReminder.DateTime := TntDatePickerStart.DateTime;
         TntTimePickerReminder.DateTime := TntDatePickerStart.DateTime;
       end;
  end;

  UpdateAlarmAdv;
end;

procedure TfrmEditEvent.DurationChange(Sender: TObject);
var
  DateTimeEnd: TDateTime;
begin
  TntDatePickerEnd.Enabled := TntComboBoxDuration.ItemIndex = 4;
  TntTimePickerEnd.Enabled := TntDatePickerEnd.Enabled;
  Label7.Enabled := TntDatePickerEnd.Enabled;
  Label8.Enabled := TntDatePickerEnd.Enabled;
  // If Other duration is selected, do nothing
  if TntComboBoxDuration.ItemIndex <> 4 then begin
    DateTimeEnd := TntDatePickerStart.DateTime;
    case TntComboBoxDuration.ItemIndex of
      // 30 minutes
      0: DateTimeEnd := IncMinute(DateTimeEnd, 30);
      // 1 hour
      1: DateTimeEnd := IncHour(DateTimeEnd);
      // 2 hours
      2: DateTimeEnd := IncHour(DateTimeEnd, 2);
      // 4 hours
      3: DateTimeEnd := IncHour(DateTimeEnd, 4);
    end;
    TntDatePickerEnd.DateTime := DateTimeEnd;
    TntTimePickerEnd.DateTime := DateTimeEnd;
  end;
end;

procedure TfrmEditEvent.StartDateTimeChange(Sender: TObject);
var
  DateTimeStart: TDateTime;
begin
  // Synchronize DateTime of pickers
  DateTimeStart := DateOf(TntDatePickerStart.DateTime) + TimeOf(TntTimePickerStart.DateTime);
  TntDatePickerStart.DateTime := DateTimeStart;
  TntTimePickerStart.DateTime := DateTimeStart;

  // Restrict end date time
  TntDatePickerEnd.MinDate:= DateTimeStart;
  TntTimePickerEnd.MinDate := DateTimeStart;

  DurationChange(Self);
  UpdateAlarm;
  UpdateWeekDays;
end;

procedure TfrmEditEvent.EndDateTimeChange(Sender: TObject);
var
  DateTimeEnd: TDateTime;
begin
  // End date was changed, so change duration on other
  TntComboBoxDuration.ItemIndex := 4;

  // Synchronize DateTime of pickers
  DateTimeEnd := DateOf(TntDatePickerEnd.DateTime) + TimeOf(TntTimePickerEnd.DateTime);
  TntDatePickerEnd.DateTime := DateTimeEnd;
  TntTimePickerEnd.DateTime := DateTimeEnd;

  // UpdateDudation;
end;

procedure TfrmEditEvent.txtSubjectChange(Sender: TObject);
begin
  lblName.Caption  := txtSubject.Text;
  lblName2.Caption := lblName.Caption;
  lblName3.Caption := lblName.Caption;
  lblName4.Caption := lblName.Caption;
end;

procedure TfrmEditEvent.TntDatePickerReminderChange(Sender: TObject);
var
  DateTimeStart: TDateTime;
begin
  // Synchronize DateTime of pickers
  DateTimeStart := DateOf(TntDatePickerReminder.DateTime) + TimeOf(TntTimePickerReminder.DateTime);
  TntDatePickerReminder.DateTime := DateTimeStart;
  TntTimePickerReminder.DateTime := DateTimeStart;

  TntRadioGroupReminder.ItemIndex := 7;
end;

procedure TfrmEditEvent.UpdateAlarm;
var
  StartTime,AdvanceTime,AlarmTime: TDateTime;
begin
  if not Visible then exit;

  StartTime := DateOf(TntDatePickerStart.DateTime) + TimeOf(TntTimePickerStart.DateTime);
  
  if TntRadioGroupReminder.ItemIndex <> 0 then begin
    AdvanceTime := GetAlarmAdvanceTime(FAlarmAdv, FAlarmAdvType);
    case FAlarmAdvType of
      atMinutes: begin
        if FAlarmAdv =  0 then TntRadioGroupReminder.ItemIndex := 1;
        if FAlarmAdv =  5 then TntRadioGroupReminder.ItemIndex := 2;
        if FAlarmAdv = 10 then TntRadioGroupReminder.ItemIndex := 3;
        if FAlarmAdv = 15 then TntRadioGroupReminder.ItemIndex := 4;
        if FAlarmAdv = 30 then TntRadioGroupReminder.ItemIndex := 5;
      end;
      atHours:
        if FAlarmAdv =  1 then TntRadioGroupReminder.ItemIndex := 6;
    end;
    AlarmTime := StartTime - AdvanceTime;
  end
  else
    AlarmTime := StartTime;

  TntRadioGroupReminderClick(Self);
  
  TntDatePickerReminder.DateTime := AlarmTime;
  TntTimePickerReminder.DateTime := AlarmTime;
end;

procedure TfrmEditEvent.UpdateAlarmAdv;
begin
  if not Visible then exit;

  case TntRadioGroupReminder.ItemIndex of
    1: begin
         FAlarmAdvType := atMinutes;
         FAlarmAdv := 0;
       end;
    2: begin
         FAlarmAdvType := atMinutes;
         FAlarmAdv := 5;
       end;
    3: begin
         FAlarmAdvType := atMinutes;
         FAlarmAdv := 10;
       end;
    4: begin
         FAlarmAdvType := atMinutes;
         FAlarmAdv := 15;
       end;
    5: begin
         FAlarmAdvType := atMinutes;
         FAlarmAdv := 30;
       end;
    6: begin
         FAlarmAdvType := atHours;
         FAlarmAdv := 1;
       end;
    7: begin
         FAlarmAdvType := atMinutes;
         FAlarmAdv := Round(((DateOf(TntDatePickerStart.DateTime) + TimeOf(TntTimePickerStart.DateTime)) -
           (DateOf(TntDatePickerReminder.DateTime) + TimeOf(TntTimePickerReminder.DateTime)))*MinsPerDay);
       end;
  end;
end;

procedure TfrmEditEvent.TntRadioGroupReccurenceClick(Sender: TObject);
begin
  TntLabel3.Enabled := TntRadioGroupReccurence.ItemIndex <> 0;
  TntComboBoxRangeEnd.Enabled := TntLabel3.Enabled;
  TntComboBoxRangeEndChange(nil);

  ReccuWeekDaysVisible := TntRadioGroupReccurence.ItemIndex = 2;
end;

procedure TfrmEditEvent.TntComboBoxRangeEndChange(Sender: TObject);
begin
  ReccurenceEndVisible := TntComboBoxRangeEnd.Enabled and (TntComboBoxRangeEnd.ItemIndex <> 0);
end;

function TfrmEditEvent.GetReminderStartVisible: boolean;
begin
  Result := TntDatePickerReminder.Enabled;
end;

procedure TfrmEditEvent.SetReminderStartVisible(const Value: boolean);
begin
  TntDatePickerReminder.Enabled := Value;
  TntTimePickerReminder.Enabled := Value;
  Label26.Enabled := Value;
  Label10.Enabled := Value;
end;

function TfrmEditEvent.GetReccurenceEndVisible: boolean;
begin
  Result := TntDatePickerReccurence.Enabled;
end;

procedure TfrmEditEvent.SetReccurenceEndVisible(const Value: boolean);
begin
  TntDatePickerReccurence.Enabled := Value;
  TntTimePickerReccurence.Enabled := Value;
  TntLabel2.Enabled := Value;
  TntLabel1.Enabled := Value;
end;

procedure TfrmEditEvent.TntDatePickerReccurenceChange(Sender: TObject);
var
  DateTimeStart: TDateTime;
begin
  // Synchronize DateTime of pickers
  DateTimeStart := DateOf(TntDatePickerReccurence.DateTime) + TimeOf(TntTimePickerReccurence.DateTime);
  TntDatePickerReccurence.DateTime := DateTimeStart;
  TntTimePickerReccurence.DateTime := DateTimeStart;
end;

function TfrmEditEvent.GetReccuWeekDaysVisible: boolean;
begin
  Result := TntLabel4.Enabled;
end;

procedure TfrmEditEvent.SetReccuWeekDaysVisible(const Value: boolean);
var
  i: Integer;
begin
  TntLabel4.Enabled := Value;
  for i := 1 to 7 do
    with GetDayCheck(i) do
      Enabled := Value;
  if Value then UpdateWeekDays; // restore current week day settings
end;

procedure TfrmEditEvent.UpdateWeekDays;
var
  i: Integer;
begin
  if FPrevWeekDay <> 0 then
    with GetDayCheck(FPrevWeekDay) do
      Checked := Tag <> 0; // restore Checked state
  for i := 1 to 7 do
    with GetDayCheck(i) do begin
      Enabled := TntRadioGroupReccurence.ItemIndex = 2;
      Tag := 0; // clean-up Checked state
    end;
  FPrevWeekDay := DayOfTheWeek(TntDatePickerStart.DateTime);
  with GetDayCheck(FPrevWeekDay) do begin
    Tag := byte(Checked); // remember Checked state
    Checked := True;
    Enabled := False;
  end;
end;

function TfrmEditEvent.GetWeekDays: WideString;
var
  i: Integer;
  procedure AddDay(Day: WideString);
  begin
    if Result <> '' then Result := Result + ' ';
    Result := Result + Day;
  end;
begin
  Result := '';
  for i := 1 to 7 do
    with GetDayCheck(i) do
     if Checked then AddDay(ReccurenceDayNames[(i mod 7) + 1]);
end;

procedure TfrmEditEvent.SetWeekDays(const Value: WideString);
var
  i: Integer;
begin
  for i := 1 to 7 do
    with GetDayCheck(i) do begin
      Checked := Pos(ReccurenceDayNames[(i mod 7) + 1],Value) <> 0;
      Tag := 0;
    end;
end;

procedure TfrmEditEvent.UpdateDudation;
var
  DateTimeStart: TDateTime;
begin
  DateTimeStart := TntDatePickerStart.DateTime;
  
  // 30 minutes
  if TntDatePickerEnd.DateTime = IncMinute(DateTimeStart, 30) then
    TntComboBoxDuration.ItemIndex := 0;
  // 1 hour
  if TntDatePickerEnd.DateTime = IncHour(DateTimeStart) then
    TntComboBoxDuration.ItemIndex := 1;
  // 2 hours
  if TntDatePickerEnd.DateTime = IncHour(DateTimeStart, 2) then
    TntComboBoxDuration.ItemIndex := 2;
  // 4 hours
  if TntDatePickerEnd.DateTime = IncHour(DateTimeStart, 4) then
    TntComboBoxDuration.ItemIndex := 3;

  DurationChange(nil);
end;

function TfrmEditEvent.GetDayCheck(Day: Integer): TTntCheckbox;
begin
  Result := TTntCheckBox(FindComponent('TntCheckBox'+IntToStr(Day)));
end;

procedure TfrmEditEvent.TntButton1Click(Sender: TObject);
begin
  { TODO: Reminder WAV file support }
end;

end.
