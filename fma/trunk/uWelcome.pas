unit uWelcome;

{
*******************************************************************************
* Descriptions: Welcome Tips dialog
* $Source: /cvsroot/fma/fma/Attic/uWelcome.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uWelcome.pas,v $
* Revision 1.1.2.3  2005/09/09 10:39:00  z_stoichev
* Fixed Welcome Tips can not be closed issue.
*
* Revision 1.1.2.2  2005/09/08 21:07:56  z_stoichev
* Welcome Tips are optional.
*
* Revision 1.1.2.1  2005/09/08 16:12:53  z_stoichev
* Added Welcome Tips dialog and COM object method AddTip.
*
*
*******************************************************************************
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TntClasses, ExtCtrls, StdCtrls, TntStdCtrls, ComCtrls, TntComCtrls;

type
  TfrmWelcomeTips = class(TForm)
    Timer1: TTimer;
    Panel1: TPanel;
    Image1: TImage;
    Panel2: TPanel;
    btnOK: TTntButton;
    btnNext: TTntButton;
    reTip: TTntRichEdit;
    cbDontShow: TTntCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure reTipEnter(Sender: TObject);
    procedure reTipExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FOK: WideString;
    FTips: TTntStringList;
    FClosed,FCloseEmpty,FTimerRunning: boolean;
    FSecondsLeft: Integer;
    procedure DoProcessQueue;
    procedure Set_CloseEmpty(const Value: boolean);
    function Get_Count: Integer;
  public
    { Public declarations }
    procedure ClearQueue;
    procedure QueueTip(AText: WideString; TimeoutSecs: Integer = 0; ShowNow: Boolean = False);
    property QueuedCount: Integer read Get_Count;
    property CloseOnEmptyQueue: boolean read FCloseEmpty write Set_CloseEmpty;
    property DialogClosed: boolean read FClosed;
  end;

var
  frmWelcomeTips: TfrmWelcomeTips;

implementation

uses
  gnugettext, gnugettexthelpers, Unit1;

{$R *.dfm}

{ TfrmWelcomeTips }

procedure TfrmWelcomeTips.DoProcessQueue;
var
  m: TMemoryStream;
  //w: WideString;
  s: String;
begin
  Timer1.Enabled := False;
  if FTips.Count <> 0 then begin
    reTip.Clear;
    m := TMemoryStream.Create;
    try
      { TODO: Fix unicode support }
      s := FTips[0];
      m.WriteBuffer(s[1],Length(s));
      {
      w := FTips[0];
      s := FTips[0];
      if Pos('{\rtf',s) = 1 then
        m.WriteBuffer(s[1],Length(s)) // RTF text, so save it as normal
      else
        m.WriteBuffer(w[1],Length(w)*2); // WideString text message
      }
      m.Position := 0;
      FSecondsLeft := Integer(FTips.Objects[0]);
      FTips.Delete(0);
      reTip.Lines.LoadFromStream(m);
      reTip.SelStart := 0;
      reTip.SelLength := 0;
      Timer1.Enabled := FSecondsLeft <> 0;
      btnNext.Enabled := FTips.Count <> 0;
      { Skip empty tips }
      if Trim(reTip.Lines.Text) = '' then
        DoProcessQueue;
    finally
      m.Free;
    end;
  end
  else begin
    btnNext.Enabled := False;
    if FCloseEmpty then btnOK.Click;
  end;
end;

procedure TfrmWelcomeTips.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);

{$IFDEF VER150}
  Panel1.ParentBackground := False;
{$ENDIF}

  FClosed := True;
  FOK := btnOK.Caption;
  FTips := TTntStringList.Create;
end;

procedure TfrmWelcomeTips.FormDestroy(Sender: TObject);
begin
  FTips.Free;
end;

procedure TfrmWelcomeTips.QueueTip(AText: WideString; TimeoutSecs: Integer; ShowNow: Boolean);
begin
  // Objects property will hold tip's Timeout value
  if ShowNow then begin
    FTips.InsertObject(0,AText,Pointer(TimeoutSecs));
    if not DialogClosed then DoProcessQueue;
  end
  else begin
    FTips.AddObject(AText,Pointer(TimeoutSecs));
    btnOK.Caption := FOK;
    btnNext.Enabled := True;
  end;  
end;

procedure TfrmWelcomeTips.Timer1Timer(Sender: TObject);
begin
  Dec(FSecondsLeft);
  if QueuedCount = 0 then
    btnOK.Caption := WideFormat('%s (%d)',[FOK,FSecondsLeft]);
  if FSecondsLeft = 0 then
    if btnNext.Enabled then btnNext.Click
      else btnOK.Click;
end;

procedure TfrmWelcomeTips.btnNextClick(Sender: TObject);
begin
  DoProcessQueue;
end;

procedure TfrmWelcomeTips.Set_CloseEmpty(const Value: boolean);
begin
  FCloseEmpty := Value;
end;

procedure TfrmWelcomeTips.FormShow(Sender: TObject);
begin
  if reTip.Lines.Count = 0 then begin
    { Show first tip }
    btnOK.Caption := FOK;
    btnNext.Enabled := True;
    FClosed := False;
  end;
  btnOK.SetFocus;
  DoProcessQueue;
end;

function TfrmWelcomeTips.Get_Count: Integer;
begin
  Result := FTips.Count;
end;

procedure TfrmWelcomeTips.btnOKClick(Sender: TObject);
begin
  if cbDontShow.Checked then begin
    Form1.FormStorage1.StoredValue['Welcome Tips'] := False; // do not localize
    cbDontShow.Checked := False;
  end;
  Close;
end;

procedure TfrmWelcomeTips.reTipEnter(Sender: TObject);
begin
  FTimerRunning := Timer1.Enabled;
  Timer1.Enabled := False;
end;

procedure TfrmWelcomeTips.reTipExit(Sender: TObject);
begin
  Timer1.Enabled := FTimerRunning;
end;

procedure TfrmWelcomeTips.ClearQueue;
begin
  FTips.Clear;
  btnNext.Enabled := False;
end;

procedure TfrmWelcomeTips.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Timer1.Enabled := False;
  cbDontShow.Visible := False;
  FClosed := True;
end;

end.

