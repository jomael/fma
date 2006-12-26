unit uSMSDetail;

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
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, ExtCtrls, TntExtCtrls, StdCtrls, TntStdCtrls, ComCtrls, TntComCtrls, UniTntCtrls, uMessageData;

type
  TfrmDetail = class(TTntForm)
    PageControl1: TTntPageControl;
    TabSheet1: TTntTabSheet;
    Label2: TTntLabel;
    edFrom: TTntEdit;
    Label1: TTntLabel;
    edSMSC: TTntEdit;
    Label3: TTntLabel;
    Button1: TTntButton;
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
    btnEditSMSTime: TTntButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEditSMSTimeClick(Sender: TObject);
    procedure TimeStampChange(Sender: TObject);
  private
    FSMS: TFmaMessageData;
    procedure SetSMS(const Value: TFmaMessageData);
    { Private declarations }
  public
    { Public declarations }
    property SMS: TFmaMessageData read FSMS write SetSMS;
  end;

var
  frmDetail: TfrmDetail;

implementation

uses
  gnugettext, gnugettexthelpers,
  uSMS, Unit1, uMissedCalls;

{$R *.dfm}

{ TfrmDetail }

procedure TfrmDetail.SetSMS(const Value: TFmaMessageData);
resourcestring
  NoInfo = '(No Information)';
var
  sms: Tsms;
  ARef, ATot, An: Integer;
begin
  FSMS := Value;

  sms := TSMS.Create;
  try
    sms.PDU := FSMS.PDU;

    edFrom.Text := FSMS.From;

    memoText.Text := sms.Text;
    edUDHI.Text := sms.UDHI;
    if edUDHI.Text = '' then edUDHI.Text := NoInfo;
    ebRef.Text := sms.MessageReference;

    edSMSC.Text := sms.SMSC;
    if edSMSC.Text = '' then edSMSC.Text := NoInfo;

    btnEditSMSTime.Caption := _('Edit timestamp');
    btnEditSMSTime.Tag := 0;
    btnEditSMSTime.Enabled := FSMS.IsOutgoing;
    btnEditSMSTime.Visible := FSMS.IsOutgoing;

    if FSMS.TimeStamp > 0 then begin
      TimeStampDate.DateTime := FSMS.TimeStamp;
      TimeStampTime.DateTime := FSMS.TimeStamp;
    end
    else begin
      TimeStampDate.DateTime := Now;
      TimeStampTime.DateTime := Now;
    end;

    memoPDU.Clear;

    if sms.IsOutgoing then begin
      Label2.Caption := _('To Address:');
      memoPDU.Lines.Add(WideFormat(_('Message Type: %s'),
        ['SMS SUBMIT'])); // do not localize
    end
    else begin
      Label2.Caption := _('From Address:');
      memoPDU.Lines.Add(WideFormat(_('Message Type: %s'),
        ['SMS DELIVER'])); // do not localize
    end;
    memoPDU.Lines.Add(sLineBreak + FSMS.PDU);

    GSMLongMsgData(FSMS.PDU, ARef, ATot, An);
    if ATot < 1 then ATot := 1;

    edLongCount.Text := IntToStr(ATot);

    lblName.Caption := Form1.LookupContact(sms.Number,sUnknownContact);
    lblName2.Caption := lblName.Caption;
    if ATot > 1 then
      Caption := _('Long Message')
    else
      Caption := _('Message');
    Caption := Caption + ' - [' + lblName.Caption + ']';
  finally
    sms.Destroy;
  end;
end;

procedure TfrmDetail.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmDetail.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);

  Image2.Picture.Assign(Image1.Picture);

{$IFNDEF VER150}
  Form1.ThemeManager1.CollectForms(Self);
{$ENDIF}
end;

procedure TfrmDetail.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  Button1.SetFocus;
end;

procedure TfrmDetail.btnEditSMSTimeClick(Sender: TObject);
begin
  if btnEditSMSTime.Tag = 0 then begin
    PageControl1.ActivePageIndex := 0;
    btnEditSMSTime.Caption := _('Save changes');
    btnEditSMSTime.Tag := 1;
    TimeStampDate.Enabled := True;
    TimeStampTime.Enabled := True;
    TimeStampDate.Color := clWindow;
    TimeStampTime.Color := clWindow;
    Self.Update;
    if TimeStampDate.CanFocus then
      TimeStampDate.SetFocus;
    btnEditSMSTime.Enabled := False;
  end
  else begin
    btnEditSMSTime.Caption := _('Edit timestamp');
    btnEditSMSTime.Tag := 0;
    FSMS.TimeStamp := Int(TimeStampDate.Date) + (TimeStampTime.Time - Int(TimeStampTime.Time));
    TimeStampDate.Enabled := False;
    TimeStampTime.Enabled := False;
    TimeStampDate.Color := clBtnFace;
    TimeStampTime.Color := clBtnFace;
  end;
end;

procedure TfrmDetail.TimeStampChange(Sender: TObject);
begin
  btnEditSMSTime.Enabled := True;
end;

end.
