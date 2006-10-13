unit uOptionsPage;

{
*******************************************************************************
* Descriptions: Edit Options custom page settings
* $Source: /cvsroot/fma/fma/Attic/uOptionsPage.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uOptionsPage.pas,v $
*
*******************************************************************************
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TntStdCtrls, ComCtrls, TntComCtrls, uOptions, ExtCtrls;

type
  TfrmOptionsPage = class(TForm)
    btnPageOK: TTntButton;
    btnPageCancel: TTntButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnPageOKClick(Sender: TObject);
  private
    { Private declarations }
    FOptions: TfrmOptions;
  public
    { Public declarations }
    function ShowPageModal(ATab: TTntTabSheet; ACaption: WideString = ''): Integer; virtual;
    property Options: TfrmOptions read FOptions;
  end;

var
  frmOptionsPage: TfrmOptionsPage;

implementation

uses
  gnugettext, gnugettexthelpers, uDialogs;

{$R *.dfm}

procedure TfrmOptionsPage.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);

  FOptions := TfrmOptions.Create(nil);

  ClientWidth := FOptions.OptionPages.Width;
  ClientHeight := FOptions.OptionPages.Height + 33;

  FOptions.OptionPages.Parent := Self;
  FOptions.OptionPages.Left := 0;
  FOptions.OptionPages.Top := 0;

  FOptions.btnDefaults.Parent := Self;
  FOptions.btnDefaults.Top := btnPageOK.Top;

  FOptions.OptionPages.Height := ClientHeight - 33;
{$IFNDEF VER150}
  Form1.ThemeManager1.CollectForms(Self);
{$ENDIF}
end;

procedure TfrmOptionsPage.FormDestroy(Sender: TObject);
begin
  FOptions.OptionPages.Parent := FOptions;
  FOptions.btnDefaults.Parent := FOptions;
  FOptions.Free;
end;

function TfrmOptionsPage.ShowPageModal(ATab: TTntTabSheet; ACaption: WideString): Integer;
var
  i,j,h: Integer;
begin
  if ACaption = '' then ACaption := WideFormat(_('%s Options'),[ATab.Caption]);
  Caption := ACaption;

  { Adjust window height according to Tab widgets }
  h := 0;
  for i := 0 to ATab.ControlCount-1 do begin
    with ATab.Controls[i] do j := Top + Height;
    if j > h then h := j;
  end;
  if h <> 0 then begin
    ClientHeight := h + 49;
    FOptions.OptionPages.Height := h + 16;
  end;
  FOptions.OptionPages.ActivePage := ATab;
  FOptions.OptionPagesChange(nil);

  Result := ShowModal;
end;

procedure TfrmOptionsPage.btnPageOKClick(Sender: TObject);
begin
  Options.SanityCheck;
  ModalResult := mrOk;
end;

end.
