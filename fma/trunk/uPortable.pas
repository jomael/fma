unit uPortable;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, TntExtCtrls, StdCtrls, TntStdCtrls, jpeg;

type
  TfrmPortableLogon = class(TForm)
    Image3: TTntImage;
    lblWelcome: TTntLabel;
    TntLabel2: TTntLabel;
    btnCancel: TTntButton;
    rbPortableMode: TTntRadioButton;
    rbNormalMode: TTntRadioButton;
    lblPortableInfo: TTntLabel;
    lblNormalInfo: TTntLabel;
    btnOK: TTntButton;
    Image1: TImage;
    Image2: TImage;
    procedure FormCreate(Sender: TObject);
    procedure OnModeChange(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure lblPortableInfoClick(Sender: TObject);
    procedure lblNormalInfoClick(Sender: TObject);
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
  OnModeChange(nil);
end;

procedure TfrmPortableLogon.OnModeChange(Sender: TObject);
begin
  if rbPortableMode.Checked then begin
    rbNormalMode.ParentFont := True;
    rbPortableMode.Font.Style := rbPortableMode.Font.Style + [fsBold];
    lblNormalInfo.Font.Color := clGray;
    lblPortableInfo.ParentFont := True;
  end
  else begin
    rbPortableMode.ParentFont := True;
    rbNormalMode.Font.Style := rbNormalMode.Font.Style + [fsBold];
    lblPortableInfo.Font.Color := clGray;
    lblNormalInfo.ParentFont := True;
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

end.
