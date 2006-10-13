unit uStatusDlg;

{
*******************************************************************************
* Descriptions: Main Unit for FMA
* $Source: /cvsroot/fma/fma/uStatusDlg.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uStatusDlg.pas,v $
*
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, StdCtrls, TntStdCtrls, ExtCtrls, TntExtCtrls;

type
  TfrmStatusDlg = class(TTntForm)
    Image1: TTntImage;
    Label1: TTntLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Status(Msg: WideString);
  end;

var
  frmStatusDlg: TfrmStatusDlg;

function ShowStatusDlg(Msg: WideString; Where: TPosition = poScreenCenter): TfrmStatusDlg;

implementation

uses
  gnugettext, gnugettexthelpers;

{$R *.dfm}

function ShowStatusDlg(Msg: WideString; Where: TPosition): TfrmStatusDlg;
begin
  Result := TfrmStatusDlg.Create(nil);
  with Result do begin
    Position := Where;
    Status(Msg);
    Show;
    Update;
  end;
end;

procedure TfrmStatusDlg.FormCreate(Sender: TObject);
begin
  Image1.Picture.Icon.Assign(Application.Icon);
  gghTranslateComponent(self);
end;

procedure TfrmStatusDlg.Status(Msg: WideString);
begin
  Label1.Caption := Msg;
  if not IsRightToLeft then
    Width := Label1.Left + Label1.Width + 32
  else
    Width := Image1.Width + 16 + Label1.Width + 32;
  if Visible then begin
    Left := (Screen.Width - Width) div 2;
    Update;
  end;
end;

end.
