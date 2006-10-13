unit uInputQuery;

{
*******************************************************************************
* Descriptions: InputQuery with Unicode support
* $Source: /cvsroot/fma/fma/uInputQuery.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uInputQuery.pas,v $
*
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, StdCtrls, TntStdCtrls;

type
  TfrmInputQuery = class(TTntForm)
    TntLabel1: TTntLabel;
    TntEdit1: TTntEdit;
    Button1: TTntButton;
    Button2: TTntButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInputQuery: TfrmInputQuery;

function WideInputQuery(ACaption,ATitle: WideString; var DefaultText: WideString): boolean;

implementation

uses
  gnugettext, gnugettexthelpers;

{$R *.dfm}

function WideInputQuery(ACaption,ATitle: WideString; var DefaultText: WideString): boolean;
begin
  with TfrmInputQuery.Create(nil) do
  try
    Caption := ACaption;
    TntLabel1.Caption := ATitle;
    TntEdit1.Text := DefaultText;
    Result := ShowModal = mrOk;
    if Result then DefaultText := TntEdit1.Text;
  finally
    Free;
  end;
end;

procedure TfrmInputQuery.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);
end;

end.
