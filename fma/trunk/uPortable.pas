unit uPortable;

{
*******************************************************************************
* Descriptions: Startup mode selection dialog
* $Source: /cvsroot/fma/fma/uPortable.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uPortable.pas,v $
*
*******************************************************************************
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, TntExtCtrls, StdCtrls, TntStdCtrls, jpeg;

type
  TfrmPortableLogon = class(TForm)
    Image3: TTntImage;
    lblWelcome: TTntLabel;
    lblWelcomeInfo: TTntLabel;
    btnCancel: TTntButton;
    rbPortableMode: TTntRadioButton;
    rbNormalMode: TTntRadioButton;
    lblPortableInfo: TTntLabel;
    lblNormalInfo: TTntLabel;
    btnOK: TTntButton;
    Image1: TImage;
    Image2: TImage;
    cbDontAskAgain: TTntCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure OnModeChange(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure lblPortableInfoClick(Sender: TObject);
    procedure lblNormalInfoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPortableLogon: TfrmPortableLogon;

implementation

{$R *.dfm}

uses
  gnugettext, gnugettexthelpers;
  
procedure TfrmPortableLogon.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);
  lblWelcome.Font.Style := lblWelcome.Font.Style + [fsBold];
  lblWelcome.Font.Size := lblWelcome.Font.Size + 3;
  lblWelcome.Font.Color := clGreen;
end;

procedure TfrmPortableLogon.OnModeChange(Sender: TObject);
begin
  if rbPortableMode.Checked then begin
    rbNormalMode.ParentFont := True;
    lblNormalInfo.Font.Color := clGray;
    lblPortableInfo.ParentFont := True;
    rbPortableMode.Font.Style := rbPortableMode.Font.Style + [fsBold];
    if Visible then rbPortableMode.SetFocus;
  end
  else begin
    rbPortableMode.ParentFont := True;
    lblPortableInfo.Font.Color := clGray;
    lblNormalInfo.ParentFont := True;
    rbNormalMode.Font.Style := rbNormalMode.Font.Style + [fsBold];
    if Visible then rbNormalMode.SetFocus;
  end;
end;

procedure TfrmPortableLogon.btnOKClick(Sender: TObject);
begin
  if rbPortableMode.Checked then
    ModalResult := mrYes
  else
    ModalResult := mrNo;
end;

procedure TfrmPortableLogon.lblPortableInfoClick(Sender: TObject);
begin
  rbPortableMode.Checked := True;
  OnModeChange(nil);
end;

procedure TfrmPortableLogon.lblNormalInfoClick(Sender: TObject);
begin
  rbNormalMode.Checked := True;
  OnModeChange(nil);
end;

procedure TfrmPortableLogon.FormShow(Sender: TObject);
begin
  MessageBeep(MB_ICONQUESTION);
  if rbPortableMode.Checked then
    lblWelcomeInfo.Caption :=
      _('FMA has detected that it is started from a Removable device.') + ' ' +
      lblWelcomeInfo.Caption
  else
    lblWelcomeInfo.Caption :=
      _('FMA has detected that it is started in forced Portable mode.') + ' ' +
      lblWelcomeInfo.Caption;
  OnModeChange(nil);
  // HACK! Workaround for non-activated application Taskbar button
  BringWindowToTop(Application.Handle);
  BringWindowToTop(Handle);
end;

end.
