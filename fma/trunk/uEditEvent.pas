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
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, ExtCtrls, TntExtCtrls, StdCtrls, TntStdCtrls, ComCtrls, TntComCtrls, UniTntCtrls, Buttons, TntButtons,
  Menus, TntMenus;

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
    TntGroupBoxOther: TTntGroupBox;
    Label10: TTntLabel;
    Label26: TTntLabel;
    TntDatePickerRemider: TTntDateTimePicker;
    TntTimePickerReminder: TTntDateTimePicker;
    lblName: TTntLabel;
    Image2: TTntImage;
    lblName2: TTntLabel;
    Bevel3: TTntBevel;
    Image3: TTntImage;
    lblName3: TTntLabel;
    Bevel4: TTntBevel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure TntRadioGroupReminderClick(Sender: TObject);
    procedure DurationChange(Sender: TObject);
    procedure StartDateTimeChange(Sender: TObject);
    procedure EndDateTimeChange(Sender: TObject);
    procedure txtSubjectChange(Sender: TObject);
    procedure TntDatePickerRemiderChange(Sender: TObject);
  private
    { Private declarations }
    procedure DoSanityCheck;
  public
    { Public declarations }
  end;

var
  frmEditEvent: TfrmEditEvent;

implementation

uses
  gnugettext, gnugettexthelpers,
  DateUtils, Math, Unit1;

{$R *.dfm}

procedure TfrmEditEvent.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);

  // gghTranslateComponent changing combo item index :/ set it manually.
  TntComboBoxDuration.ItemIndex := 4;

{$IFNDEF VER150}
  Form1.ThemeManager1.CollectForms(Self);
{$ENDIF}
  Image2.Picture.Assign(Image1.Picture);
  Image3.Picture.Assign(Image1.Picture);
end;

procedure TfrmEditEvent.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  StartDateTimeChange(Self);
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
  if TntRadioGroupReminder.ItemIndex = 0 then TntGroupBoxOther.Visible := False
  else TntGroupBoxOther.Visible := True;

  case TntRadioGroupReminder.ItemIndex of
    0: begin
         TntDatePickerRemider.DateTime := TntDatePickerStart.DateTime;
         TntTimePickerReminder.DateTime := TntDatePickerStart.DateTime;
       end;
    1: begin
         TntDatePickerRemider.DateTime := TntDatePickerStart.DateTime;
         TntTimePickerReminder.DateTime := TntDatePickerStart.DateTime;
       end;
    2: begin
         TntDatePickerRemider.DateTime := IncMinute(TntDatePickerStart.DateTime, -5);
         TntTimePickerReminder.DateTime := IncMinute(TntDatePickerStart.DateTime, -5);
       end;
    3: begin
         TntDatePickerRemider.DateTime := IncMinute(TntDatePickerStart.DateTime, -10);
         TntTimePickerReminder.DateTime := IncMinute(TntDatePickerStart.DateTime, -10);
       end;
    4: begin
         TntDatePickerRemider.DateTime := IncMinute(TntDatePickerStart.DateTime, -15);
         TntTimePickerReminder.DateTime := IncMinute(TntDatePickerStart.DateTime, -15);
       end;
    5: begin
         TntDatePickerRemider.DateTime := IncMinute(TntDatePickerStart.DateTime, -30);
         TntTimePickerReminder.DateTime := IncMinute(TntDatePickerStart.DateTime, -30);
       end;
    6: begin
         TntDatePickerRemider.DateTime := IncHour(TntDatePickerStart.DateTime, -1);
         TntTimePickerReminder.DateTime := IncHour(TntDatePickerStart.DateTime, -1);
       end;
    7: begin
         TntDatePickerRemider.DateTime := TntDatePickerStart.DateTime;
         TntTimePickerReminder.DateTime := TntDatePickerStart.DateTime;
       end;
  end;
end;

procedure TfrmEditEvent.DurationChange(Sender: TObject);
  var
    DateTimeEnd: TDateTime;
begin
  // If Other duration is selected, do nothing
  if TntComboBoxDuration.ItemIndex <> 4 then
  begin
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
end;

procedure TfrmEditEvent.txtSubjectChange(Sender: TObject);
begin
  lblName.Caption := txtSubject.Text;
  lblName2.Caption := lblName.Caption;
  lblName3.Caption := lblName.Caption;
end;

procedure TfrmEditEvent.TntDatePickerRemiderChange(Sender: TObject);
begin
  TntRadioGroupReminder.ItemIndex := 7;
end;

end.
