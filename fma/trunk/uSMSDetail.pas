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
* Revision 1.10.2.4  2006/03/09 09:13:02  z_stoichev
* Gsm_SMS code merged into uSMS.pas!
*
* Revision 1.10.2.3  2005/12/15 11:43:25  z_stoichev
* Added SMS Location field to SMS Details dialog.
*
* Revision 1.10.2.2  2005/08/30 12:54:13  z_stoichev
* Fixed Show Long SMS details contains all PDUs.
*
* Revision 1.10.2.1  2005/08/23 20:59:58  z_stoichev
* - Changed Text Message properties dialog GUI.
*
* Revision 1.10  2005/02/08 15:38:54  voxik
* Merged with L10N branch
*
* Revision 1.8.14.3  2005/01/07 17:34:38  expertone
* Merge with MAIN branch
*
* Revision 1.9  2004/12/15 15:47:23  z_stoichev
* Merged with Long SMS branch.
*
* Revision 1.8.12.3  2004/12/15 15:20:11  z_stoichev
* Do not show long sms as flatten text.
*
* Revision 1.8.12.2  2004/12/15 13:38:11  z_stoichev
* Long SMS support bugfixes.
* Mark Long SMS as one (read/unread).
*
* Revision 1.8.12.1  2004/09/15 10:02:37  z_stoichev
* Added Long SMS View/Details support
*
* Revision 1.8.14.2  2004/10/25 20:21:56  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.8.14.1  2004/10/19 19:48:49  expertone
* Add localization (gnugettext)
*
* Revision 1.8  2004/06/14 09:33:05  z_stoichev
* Fixed label unicode support.
*
* Revision 1.7  2004/05/19 18:34:16  z_stoichev
* Build 0.1.0.35c
*
* Revision 1.6  2003/11/28 09:38:07  z_stoichev
* Merged with branch-release-1-1 (Fma 0.10.28c)
*
* Revision 1.5.2.5  2003/11/13 16:37:10  z_stoichev
* Changed images.
*
* Revision 1.5.2.4  2003/11/06 16:08:49  z_stoichev
* Close work now.
*
* Revision 1.5.2.3  2003/11/04 11:41:20  z_stoichev
* Made Close button work with ESC hit.
*
* Revision 1.5.2.2  2003/10/31 14:38:51  z_stoichev
* Added Close button, instead of OK, Cancel.
*
* Revision 1.5.2.1  2003/10/27 07:22:54  z_stoichev
* Build 0.1.0 RC1 Initial Checkin.
*
* Revision 1.5  2003/10/23 12:28:36  z_stoichev
* Fixed Win XP theme tabsheet issue.
* Added more information fields.
* Font changed.
*
* Revision 1.4  2003/10/17 09:14:10  z_stoichev
* Changed GUI.
*
* Revision 1.3  2003/01/30 04:15:57  warren00
* Updated with header comments
*
*
*******************************************************************************
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, ExtCtrls, TntExtCtrls, StdCtrls, TntStdCtrls, ComCtrls, TntComCtrls, UniTntCtrls;

type
  TfrmDetail = class(TTntForm)
    PageControl1: TTntPageControl;
    TabSheet1: TTntTabSheet;
    Label2: TTntLabel;
    edFrom: TTntEdit;
    Label1: TTntLabel;
    edSMSC: TTntEdit;
    Label3: TTntLabel;
    edTimeStamp: TTntEdit;
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
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FPDU: String;
    procedure SetPDU(const Value: String);
    { Private declarations }
  public
    { Public declarations }
    property PDU: String read FPDU write SetPDU;
  end;

var
  frmDetail: TfrmDetail;

implementation

uses
  gnugettext, gnugettexthelpers,
  uSMS, Unit1, uMissedCalls;

{$R *.dfm}

{ TfrmDetail }

procedure TfrmDetail.SetPDU(const Value: String);
resourcestring
  NoInfo = '(No Information)';
var
  sms: Tsms;
  ARef, ATot, An: Integer;
begin
  FPDU := Value;

  sms := Tsms.Create;
  try
    sms.PDU := FPDU;

    edFrom.Text := sms.Number;

    memoText.Text := sms.Text;
    edUDHI.Text := sms.UDHI;
    if edUDHI.Text = '' then edUDHI.Text := NoInfo;
    ebRef.Text := sms.MessageReference;

    edSMSC.Text := sms.SMSC;
    if edSMSC.Text = '' then edSMSC.Text := NoInfo;

    if sms.TimeStamp > 0 then
      edTimeStamp.Text := DateTimeToStr(sms.TimeStamp)
    else
      edTimeStamp.Text := NoInfo;

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
    memoPDU.Lines.Add(sLineBreak + FPDU);

    GSMLongMsgData(FPDU, ARef, ATot, An);
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

end.
