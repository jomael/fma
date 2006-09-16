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
* Revision 1.7.2.3  2006/04/07 21:03:59  z_stoichev
* Added support for non-96 dpi screens.
*
* Revision 1.7.2.2  2006/01/20 13:52:36  z_stoichev
* Alpha-blending fixes (detect OS support).
*
* Revision 1.7.2.1  2006/01/18 15:28:43  z_stoichev
* Added smooth show/hide.
*
* Revision 1.7  2005/02/08 15:38:55  voxik
* Merged with L10N branch
*
* Revision 1.6.4.2  2005/01/27 13:24:40  voxik
* Fixed Splashscreen unicode support
*
* Revision 1.6.4.1  2005/01/07 18:04:01  expertone
* Merge with MAIN branch
*
* Revision 1.6  2004/12/22 13:49:23  z_stoichev
* Slpash image do not stay on top.
*
* Revision 1.5  2004/12/21 14:10:39  z_stoichev
* Final edition (2.1 beta)
*
* Revision 1.4  2004/12/19 15:28:28  z_stoichev
* Using White splash image
* Set custom font color on form Create
*
* Revision 1.3  2004/12/10 16:10:32  z_stoichev
* Fixed: Splash image contains FMA logo now.
* Added: Splash could be closed by mouse click.
*
* Revision 1.2  2004/12/09 19:32:43  z_stoichev
* Hide splash delayed.
*
* Revision 1.1  2004/12/09 16:41:45  z_stoichev
* Initial checkin.
*
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
    Label2: TTntLabel;
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
  Label2.Font.Color := clRed;

  SEProgress1.Top := Label1.Top + Label1.Height + 4;
  SEProgress1.Left := Label1.Left + 3;
  SEProgress1.Width := Label1.Width - 7;
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
