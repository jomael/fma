unit uSplash;

{
*******************************************************************************
* Descriptions: Splash Image for FMA
* $Source: /cvsroot/fma/fma/uSplash.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uSplash.pas,v $
*
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, jpeg, ExtCtrls, TntExtCtrls, StdCtrls, TntStdCtrls,
  ComCtrls, SEProgress;

type
  TfrmSplash = class(TTntForm)
    Image1: TTntImage;
    Label1: TTntLabel;
    Timer1: TTimer;
    Timer2: TTimer;
    SEProgress1: TSEProgress;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure OnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    FUseAlphaEffects: boolean;
  public
    { Public declarations }
    ClickToClose: boolean;
    procedure Status(Msg: WideString);
    procedure HideDelayed(Secs: integer);
  end;

var
  frmSplash: TfrmSplash;

function ShowSplashDlg(Msg: WideString; Where: TPosition = poScreenCenter): TfrmSplash;

implementation

uses
  gnugettext, gnugettexthelpers,
  Unit1;

{$R *.dfm}

function ShowSplashDlg(Msg: WideString; Where: TPosition): TfrmSplash;
begin
  Result := TfrmSplash.Create(nil);
  with Result do begin
    Position := Where;
    Status(Msg);
    Show;
    Update;
  end;
end;

{ TfrmSplash }

procedure TfrmSplash.Status(Msg: WideString);
begin
  Label1.Caption := ' '+Msg;
  Label1.Update;
end;

procedure TfrmSplash.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  frmSplash := nil;
  if (Screen.ActiveForm = Self) and Form1.Visible then
    Form1.Show;
end;

procedure TfrmSplash.HideDelayed(Secs: integer);
begin
  Timer1.Enabled := False;
  Timer1.Interval := Secs*1000;
  Timer1.Enabled := True;
end;

procedure TfrmSplash.Timer1Timer(Sender: TObject);
begin
  Close;
end;

procedure TfrmSplash.OnMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ClickToClose then Close;
end;

procedure TfrmSplash.FormCreate(Sender: TObject);
var
  VerInfo: TOsversionInfo;
begin
  ClientHeight := Image1.Picture.Height;
  ClientWidth := Image1.Picture.Width;
  {
  SEProgress1.Left := 2;
  SEProgress1.Height := 4;
  SEProgress1.ShowBorder := False;
  SEProgress1.Width := ClientWidth - 4;
  SEProgress1.Top := ClientHeight - 5;
  }
  gghTranslateComponent(self);

  Label1.Font.Color := $00458946;

  SEProgress1.Top := Label1.Top + Label1.Height + 4;
  SEProgress1.Left := Label1.Left + Canvas.TextWidth(' ');
  SEProgress1.Width := ClientWidth - SEProgress1.Left - 10; // 252
  SEProgress1.BarColor := Label1.Font.Color;

  VerInfo.dwOSVersionInfoSize := SizeOf(VerInfo);
  GetVersionEx(VerInfo);
  FUseAlphaEffects := VerInfo.dwMajorVersion >= 5;
  if FUseAlphaEffects then begin
    AlphaBlendValue := 0;
    AlphaBlend := True;
  end;
end;

procedure TfrmSplash.FormShow(Sender: TObject);
begin
  Application.BringToFront;
  BringToFront;
  Timer2.Enabled := True;
end;

procedure TfrmSplash.Timer2Timer(Sender: TObject);
var
  i: Integer;
begin
  Timer2.Enabled := False;
  if FUseAlphaEffects then
    for i := 1 to 255 div 4 do begin
      AlphaBlendValue := AlphaBlendValue + 4;
      Sleep(6);
    end;
end;

procedure TfrmSplash.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  i: Integer;
begin
  if FUseAlphaEffects then
    for i := 1 to 255 div 4 do begin
      AlphaBlendValue := AlphaBlendValue - 4;
      Sleep(1);
    end;
end;

end.
