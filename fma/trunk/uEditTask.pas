unit uEditTask;

{
*******************************************************************************
* Descriptions: Edit Calendar Task
* $Source: /cvsroot/fma/fma/uEditTask.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uEditTask.pas,v $
*
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, ExtCtrls, TntExtCtrls, StdCtrls, TntStdCtrls, ComCtrls, TntComCtrls, UniTntCtrls, Buttons, TntButtons,
  Menus, TntMenus;
  
type
  TfrmEditTask = class(TTntForm)
    PageControl1: TTntPageControl;
    TabSheet1: TTntTabSheet;
    OkButton: TTntButton;
    CancelButton: TTntButton;
    TabSheet5: TTntTabSheet;
    Label3: TTntLabel;
    txtOutlookID: TTntEdit;
    Label25: TTntLabel;
    txtFileAs: TTntEdit;
    Bevel1: TTntBevel;
    Label2: TTntLabel;
    txtSubject: TTntEdit;
    Bevel3: TTntBevel;
    chbCompleted: TTntCheckBox;
    Label1: TTntLabel;
    txtCompleted: TTntEdit;
    chbReminder: TTntCheckBox;
    Image1: TTntImage;
    Label4: TTntLabel;
    dtpDate: TTntDateTimePicker;
    dtpTime: TTntDateTimePicker;
    Label7: TTntLabel;
    Label5: TTntLabel;
    txtNumber: TTntEdit;
    Bevel2: TTntBevel;
    lblName: TTntLabel;
    Image2: TTntImage;
    lblName2: TTntLabel;
    Bevel4: TTntBevel;
    Button1: TTntButton;
    procedure FormCreate(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chbReminderClick(Sender: TObject);
    procedure chbCompletedClick(Sender: TObject);
    procedure txtSubjectChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ReminderDateTimeChange(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure DoSanityCheck;
  public
    { Public declarations }
  end;

var
  frmEditTask: TfrmEditTask;

implementation

uses
  gnugettext, gnugettexthelpers, DateUtils,
  Unit1, uGetContact;

{$R *.dfm}

procedure TfrmEditTask.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);

{$IFNDEF VER150}
  Form1.ThemeManager1.CollectForms(Self);
{$ENDIF}
  Image2.Picture.Assign(Image1.Picture);
end;

procedure TfrmEditTask.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  chbReminderClick(self);
  txtSubject.SetFocus;
end;

procedure TfrmEditTask.OkButtonClick(Sender: TObject);
begin
  DoSanityCheck;
  ModalResult := mrOk;
end;

procedure TfrmEditTask.DoSanityCheck;
begin
  // Sanity Check
end;

procedure TfrmEditTask.chbReminderClick(Sender: TObject);
begin
  dtpDate.Enabled := chbReminder.Checked;
  dtpTime.Enabled := chbReminder.Checked;
end;

procedure TfrmEditTask.chbCompletedClick(Sender: TObject);
begin
  if chbCompleted.Checked = True then txtCompleted.Text := DateTimeToStr(Now);
end;

procedure TfrmEditTask.txtSubjectChange(Sender: TObject);
  var
    I: Integer;
begin
  txtNumber.Text := '';

  I := 1;
  while I <= Length(txtSubject.Text) do
  begin
    if IsDelimiter('0123456789', txtSubject.Text, I) then // do not localize
    begin

      if (I > 1) and (txtSubject.Text[I - 1] = '+') then Dec(I);

      while (I <= Length(txtSubject.Text)) and IsDelimiter('+0123456789', txtSubject.Text, I) do // do not localize
      begin
        txtNumber.Text := txtNumber.Text + txtSubject.Text[I];
        Inc(I);
      end;

      Break;
    end;

    Inc(I);
  end;

  lblName.Caption := txtSubject.Text;
  lblName2.Caption := lblName.Caption;
end;

procedure TfrmEditTask.Button1Click(Sender: TObject);
begin
  with TfrmGetContact.Create(nil) do
    try
      SelContacts := Form1.LookupContact(txtNumber.Text);
      if ShowModal = mrOk then begin
        { This will set txtNumber.Text as well }
        txtSubject.Text  := Format(_('Call %s and arrange a date.'),[SelContacts]);
      end;
    finally
      Free;
    end;
end;

procedure TfrmEditTask.ReminderDateTimeChange(Sender: TObject);
var
  DateTimeStart: TDateTime;
begin
  // Synchronize DateTime of pickers
  DateTimeStart := DateOf(dtpDate.DateTime) + TimeOf(dtpTime.DateTime);
  dtpDate.DateTime := DateTimeStart;
  dtpTime.DateTime := DateTimeStart;
end;

procedure TfrmEditTask.CancelButtonClick(Sender: TObject);
begin
  {if not btnApply.Enabled or (MessageDlgW(_('Discard current changes?'),
    mtConfirmation, MB_YESNO or MB_DEFBUTTON2) = ID_YES) then}
    ModalResult := mrCancel;
end;

end.
