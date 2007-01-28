unit uEditSMS;

{
*******************************************************************************
* Descriptions: SMS Detail view implementation
* $Source: /cvsroot/fma/fma/uSMSDetail.pas,v $
* $Locker:  $
*
* Todo:
*   - More information to show
*
* Change Log:
* $Log: uSMSDetail.pas,v $
*
*******************************************************************************
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics,
  Controls, TntControls, Forms, TntForms, Dialogs, TntDialogs, ExtCtrls, TntExtCtrls, StdCtrls, TntStdCtrls,
  ComCtrls, TntComCtrls, UniTntCtrls, uMessageData, uDialogs;

type
  TfrmDetail = class(TTntForm)
    PageControl1: TTntPageControl;
    TabSheet1: TTntTabSheet;
    lblTarget: TTntLabel;
    edFrom: TTntEdit;
    Label1: TTntLabel;
    edSMSC: TTntEdit;
    lblDate: TTntLabel;
    OkButton: TTntButton;
    Label4: TTntLabel;
    memoText: TTntMemo;
    Image1: TTntImage;
    Bevel2: TTntBevel;
    lblName: TTntLabel;
    TabSheet2: TTabSheet;
    lblName2: TTntLabel;
    Image2: TTntImage;
    Bevel3: TTntBevel;
    Label10: TTntLabel;
    edLongCount: TTntEdit;
    Label6: TTntLabel;
    edUDHI: TTntEdit;
    ebRef: TTntEdit;
    Label7: TTntLabel;
    Label5: TTntLabel;
    memoPDU: TTntMemo;
    TntLabel1: TTntLabel;
    edLocation: TTntEdit;
    TimeStampDate: TTntDateTimePicker;
    TimeStampTime: TTntDateTimePicker;
    ChangeButton: TTntButton;
    CancelButton: TTntButton;
    ApplyButton: TTntButton;
    TntTabSheet1: TTntTabSheet;
    lblName3: TTntLabel;
    Image3: TTntImage;
    TntBevel1: TTntBevel;
    TntLabel3: TTntLabel;
    mmoDRPDU: TTntMemo;
    TntLabel4: TTntLabel;
    edDRStatus: TTntEdit;
    TntLabel5: TTntLabel;
    edDRRepDate: TTntEdit;
    TntLabel6: TTntLabel;
    edDRInfo: TTntEdit;
    procedure OkButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ChangeButtonClick(Sender: TObject);
    procedure TimeStampChange(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    procedure TimeStampDateKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelButtonClick(Sender: TObject);
  private
    { Private declarations }
    FTimestamp: TDateTime;
    FCanEditTime: boolean;
    FSMS: TFmaMessageData;
    FModified: boolean;
    procedure SetSMS(const Value: TFmaMessageData);
    procedure DoShowTimestamp;
    procedure DoSetTimestamp(Value: TDateTime);
  public
    { Public declarations }
    property SMS: TFmaMessageData read FSMS write SetSMS;
    property IsModified: boolean read FModified write FModified;
  end;

var
  frmDetail: TfrmDetail;

implementation

uses
  gnugettext, gnugettexthelpers,
  uSMS, Unit1, uMissedCalls, DateUtils, VirtualTrees;

{$R *.dfm}

resourcestring
  sNoInfo = '(No Information)';
  sChange = 'Chang&e';
  sReset  = '&Reset';

{ TfrmDetail }

procedure TfrmDetail.SetSMS(const Value: TFmaMessageData);
var
  sms: Tsms;
  ARef, ATot, An: Integer;
begin
  FModified := False;
  FSMS := Value;

  sms := TSMS.Create;
  try
    sms.PDU := FSMS.PDU;

    edFrom.Text := FSMS.From;

    memoText.Text := sms.Text;
    edUDHI.Text := sms.UDHI;
    if edUDHI.Text = '' then edUDHI.Text := sNoInfo;
    ebRef.Text := sms.MessageReference;

    edSMSC.Text := sms.SMSC;
    if edSMSC.Text = '' then edSMSC.Text := sNoInfo;

    FCanEditTime := False;
    ChangeButton.Tag := 0;
    ChangeButton.Caption := sChange;
    ChangeButton.Enabled := FSMS.IsOutgoing and (FSMS.ReportPDU = '');

    DoShowTimestamp;

    memoPDU.Clear;

    if sms.IsOutgoing then begin
      lblTarget.Caption := _('To:');
      lblDate.Caption := _('Sent:');
      memoPDU.Lines.Add(WideFormat(_('Message Type: %s'),
        ['SMS SUBMIT'])); // do not localize
    end
    else begin
      lblTarget.Caption := _('From:');
      lblDate.Caption := _('Received:');
      memoPDU.Lines.Add(WideFormat(_('Message Type: %s'),
        ['SMS DELIVER'])); // do not localize
    end;
    memoPDU.Lines.Add(sLineBreak + FSMS.PDU);

    GSMLongMsgData(FSMS.PDU, ARef, ATot, An);
    if ATot < 1 then ATot := 1;

    edLongCount.Text := IntToStr(ATot);

    lblName.Caption := Form1.LookupContact(sms.Number,sUnknownContact);
    lblName2.Caption := lblName.Caption;
    lblName3.Caption := lblName.Caption;
    if ATot > 1 then
      Caption := _('Long Message')
    else
      Caption := _('Message');
    Caption := Caption + ' - [' + lblName.Caption + ']';
  finally
    sms.Destroy;
  end;

  if FSMS.ReportRequested then begin
    mmoDRPDU.Text := FSMS.ReportPDU;
    if mmoDRPDU.Text <> '' then begin
      edDRStatus.Text := _('Responce Received');
      edDRRepDate.Text := DateTimeToStr(FSMS.TimeStamp);
      if FSMS.StatusCode = $FF then
        edDRInfo.Text := sNoInfo // unknown
      else
        if FSMS.StatusCode = 0 then
          edDRInfo.Text := _('Delivery was successful')
        else
          edDRInfo.Text := WideFormat(_('Delivery failed with status code: %d'),[FSMS.StatusCode]);
    end
    else begin
      if FSMS.StatusCode = $FF then begin
        edDRStatus.Text := _('Awaiting Responce...');
        edDRRepDate.Text := sNoInfo;
        edDRInfo.Text := sNoInfo;
      end
      else begin
        edDRStatus.Text := _('Not Received');
        edDRRepDate.Text := sNoInfo;
        edDRInfo.Text := _('Validity period expired');
      end;
    end;
  end
  else
    edDRStatus.Text := _('Not Requested');
end;

procedure TfrmDetail.OkButtonClick(Sender: TObject);
begin
  if ApplyButton.Enabled then ApplyButton.Click;
  Close;
end;

procedure TfrmDetail.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);

  Image2.Picture.Assign(Image1.Picture);
  Image3.Picture.Assign(Image1.Picture);

{$IFNDEF VER150}
  Form1.ThemeManager1.CollectForms(Self);
{$ENDIF}
end;

procedure TfrmDetail.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  ApplyButton.Enabled := False;
  OkButton.SetFocus;
end;

procedure TfrmDetail.ChangeButtonClick(Sender: TObject);
begin
  if ChangeButton.Tag = 0 then begin
    FTimestamp := FSMS.TimeStamp; // save original value
    ChangeButton.Tag := 1;
    ChangeButton.Caption := sReset;
    FCanEditTime := True;
    TimeStampDate.SetFocus;
  end
  else begin
    DoSetTimestamp(FTimestamp); // reset to original value
    ChangeButton.Tag := 0;
    ChangeButton.Caption := sChange;
    ApplyButton.Enabled := False;
    FModified := True;
    FCanEditTime := False;
    DoShowTimestamp;
  end;
end;

procedure TfrmDetail.TimeStampChange(Sender: TObject);
begin
  if FCanEditTime then
    ApplyButton.Enabled := True
  else
    DoShowTimestamp;
end;

procedure TfrmDetail.ApplyButtonClick(Sender: TObject);
begin
  if FCanEditTime then begin
    DoSetTimestamp(DateOf(TimeStampDate.Date) + TimeOf(TimeStampTime.Time));
    ApplyButton.Enabled := False;
    FModified := True;
  end;
end;

procedure TfrmDetail.DoShowTimestamp;
begin
  if FSMS.TimeStamp > 0 then begin
    TimeStampDate.DateTime := FSMS.TimeStamp;
    TimeStampTime.DateTime := FSMS.TimeStamp;
  end
  else begin
    TimeStampDate.DateTime := Now;
    TimeStampTime.DateTime := Now;
  end;
end;

procedure TfrmDetail.TimeStampDateKeyPress(Sender: TObject; var Key: Char);
begin
  if not FCanEditTime and (Key in ['0'..'9']) then Key := #0;
end;

procedure TfrmDetail.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  frmDetail := nil;
end;

procedure TfrmDetail.CancelButtonClick(Sender: TObject);
begin
  if not FModified or (MessageDlgW(_('Discard current changes?'),
    mtConfirmation, MB_YESNO or MB_DEFBUTTON2) = ID_YES) then
    Close;
end;

procedure TfrmDetail.DoSetTimestamp(Value: TDateTime);
begin
  FSMS.TimeStamp := Value;
  if Form1.frmMsgView.Visible then
    with Form1.frmMsgView.ListMsg do begin
      { if Received column selected as sort-column? }
      if (Header.SortColumn <> -1) and (Header.Columns[Header.SortColumn].Tag = 111) then
        try
          { yes, so resort the messages list }
          BeginUpdate;
          Sort(nil, Header.SortColumn, Header.SortDirection);
        finally
          EndUpdate;
        end;
    end;
end;

end.
