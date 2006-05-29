unit uLogDetails;

{
*******************************************************************************
* Descriptions: Event Viewer - display event details.
* $Source: /cvsroot/fma/fma/uLogDetails.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uLogDetails.pas,v $
* Revision 1.3.2.2  2005/08/17 18:39:11  lordlarry
* - Changed Implementation of Log Classes
*
* Revision 1.5  2005/04/19 08:51:00  z_stoichev
* Fixed D6 Windows XP Theme support
* Prev,Next do not select all message text.
*
* Revision 1.4  2005/03/28 18:53:44  lordlarry
* Changed some implementation details of the LogObservers en LogWriters
*
* Revision 1.3  2005/03/13 10:41:26  z_stoichev
* Added Up, Down button texts
* Added Track new messages option.
* GUI changes.
*
* Revision 1.2  2005/03/12 16:17:09  z_stoichev
* Added own LogObserver to monitor LogEnumeration changes.
* Images replaced with some XP style images.
*
* Revision 1.1  2005/03/08 13:31:43  z_stoichev
* Initial checkin.
*
*
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TntStdCtrls, ExtCtrls, TntExtCtrls, ComCtrls,
  TntComCtrls, uLogger, Buttons, ImgList, uLogObserver, ImageListXP,
  TntButtons;

type
  TfrmLogDetails = class(TForm)
    PageControl1: TTntPageControl;
    TabSheet1: TTntTabSheet;
    Image1: TTntImage;
    Bevel1: TTntBevel;
    lblDateTime: TTntLabel;
    OkButton: TTntButton;
    TntLabel1: TTntLabel;
    edSeverity: TTntEdit;
    TntLabel2: TTntLabel;
    edCategory: TTntEdit;
    mmoMessage: TTntMemo;
    TntLabel3: TTntLabel;
    btnHelpMe: TTntButton;
    ImageListXP1: TImageListXP;
    cbTrackMessages: TTntCheckBox;
    sbUp: TTntBitBtn;
    sbDown: TTntBitBtn;
    procedure OkButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbUpClick(Sender: TObject);
    procedure sbDownClick(Sender: TObject);
    procedure btnHelpMeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FObserver: TLogBasicObserver;
    FLogEnumeration: ILogEnumeration;
    FLogItem: ILogItem;
    procedure Set_LogEnumeration(const Value: ILogEnumeration);
    procedure Set_LogItem(const Value: ILogItem);
    procedure DoClearView;
    procedure DoUpdateButtons;
    procedure LogChanged(Sender: TObject);
  public
    { Public declarations }
    property LogEnumeration: ILogEnumeration read FLogEnumeration write Set_LogEnumeration;
    property LogItem: ILogItem read FLogItem write Set_LogItem;
  end;

var
  frmLogDetails: TfrmLogDetails;

implementation

uses
  gnugettext, gnugettexthelpers, uDialogs, uLogWriters, Unit1;

{$R *.dfm}

{ TfrmLogDetails }

procedure TfrmLogDetails.Set_LogEnumeration(const Value: ILogEnumeration);
begin
  FLogEnumeration := Value;

  if Assigned(FLogEnumeration) then
    FObserver.Log := FLogEnumeration.Log
  else
    FObserver.Log := nil;

  LogItem := nil;
end;

procedure TfrmLogDetails.Set_LogItem(const Value: ILogItem);
begin
  FLogItem := Value;
  if Assigned(FLogItem) then begin
    lblDateTime.Caption := FormatDateTime('hh":"nn":"ss":"zzz" - "dddddd" ("dddd")"',FLogItem.DateTime);;
    edSeverity.Text := LogSeverityToString(FLogItem.Severity);
    edSeverity.Color := clWindow;
    edCategory.Text := LogCategoryToString(FLogItem.Category);
    edCategory.Color := clWindow;
    btnHelpMe.Enabled := FLogItem.Severity = lsError;
    ImageListXP1.GetIcon(Integer(FLogItem.Severity),Image1.Picture.Icon);
    mmoMessage.Color := clWindow;
    mmoMessage.Lines.BeginUpdate;
    try
      mmoMessage.Text := FLogItem.Message;
      mmoMessage.SelStart := 0;
      mmoMessage.SelLength := 0; //Length(FLogItem.Message);
    finally
      mmoMessage.Lines.EndUpdate;
    end;
  end
  else
    DoClearView;
  DoUpdateButtons;
end;

procedure TfrmLogDetails.OkButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmLogDetails.DoClearView;
begin
  lblDateTime.Caption := '';
  edSeverity.Text := '';
  edSeverity.Color := clBtnFace;
  edCategory.Text := '';
  edCategory.Color := clBtnFace;
  mmoMessage.Text := '';
  mmoMessage.Color := clBtnFace;
  btnHelpMe.Enabled := False;
  sbUp.Enabled := False;
  sbDown.Enabled := False;
end;

procedure TfrmLogDetails.DoUpdateButtons;
begin
  if Assigned(FLogEnumeration) and Assigned(FLogItem) then begin
    sbUp.Enabled := FLogItem.Index <> FLogEnumeration.First.Index;
    sbDown.Enabled := FLogItem.Index <> FLogEnumeration.Last.Index;
  end
  else begin
    sbUp.Enabled := False;
    sbDown.Enabled := False;
  end;
end;

procedure TfrmLogDetails.FormShow(Sender: TObject);
begin
  OkButton.SetFocus;
  DoUpdateButtons;
end;

procedure TfrmLogDetails.sbUpClick(Sender: TObject);
begin
  LogItem := LogEnumeration.Previous(LogItem);
  OkButton.SetFocus;
end;

procedure TfrmLogDetails.sbDownClick(Sender: TObject);
begin
  LogItem := LogEnumeration.Next(LogItem);
  OkButton.SetFocus;
end;

procedure TfrmLogDetails.btnHelpMeClick(Sender: TObject);
begin
  MessageDlgW(_('Could not start event log Troubleshooter!'),mtInformation,MB_OK);
end;

procedure TfrmLogDetails.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FObserver.Free;
  FLogEnumeration := nil;
  FLogItem := nil;
  Action := caFree;
  frmLogDetails := nil;
end;

procedure TfrmLogDetails.FormCreate(Sender: TObject);
begin
  FObserver := TLogBasicObserver.Create(Self);
  FObserver.OnLogChanged := LogChanged;

{$IFNDEF VER150}
  Form1.ThemeManager1.CollectForms(Self);
{$ENDIF}
end;

procedure TfrmLogDetails.LogChanged(Sender: TObject);
begin
  DoUpdateButtons;
  while sbDown.Enabled and cbTrackMessages.Checked do
    sbDown.Click;
end;

end.
