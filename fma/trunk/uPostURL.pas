unit uPostURL;

{
*******************************************************************************
* Descriptions: Bookmark properties implementation
* $Source: /cvsroot/fma/fma/uPostURL.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uPostURL.pas,v $
* Revision 1.5.2.2  2005/09/15 15:01:24  z_stoichev
* GUI fixes.
*
*
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, StdCtrls, TntStdCtrls, ExtCtrls, TntExtCtrls,
  ComCtrls, TntComCtrls;

type
  TfrmBookmark = class(TTntForm)
    OkButton: TTntButton;
    CancelButton: TTntButton;
    PageControl1: TTntPageControl;
    TabSheet1: TTntTabSheet;
    Bevel1: TTntBevel;
    Image1: TTntImage;
    lblName: TTntLabel;
    Label1: TTntLabel;
    Label2: TTntLabel;
    TntEdit1: TTntEdit;
    TntMemo1: TTntMemo;
    procedure OkButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TntEdit1Change(Sender: TObject);
  private
    function Get_Title: WideString;
    function Get_URL: WideString;
    procedure Set_Title(const Value: WideString);
    procedure Set_URL(const Value: WideString);
    { Private declarations }
  public
    { Public declarations }
    property BookmarkTitle: WideString read Get_Title write Set_Title;
    property BookmarkURL: WideString read Get_URL write Set_URL;
  end;

var
  frmBookmark: TfrmBookmark;

implementation

uses
  gnugettext, gnugettexthelpers,
  uDialogs;

{$R *.dfm}

procedure TfrmBookmark.OkButtonClick(Sender: TObject);
begin
  if Trim(BookmarkTitle) = '' then begin
    MessageDlgW(_('You must specify a title.'),mtError,MB_OK);
    exit;
  end;
  if Trim(BookmarkURL) = '' then begin
    MessageDlgW(_('You must specify an URL.'),mtError,MB_OK);
    exit;
  end;
  ModalResult := mrOk;
end;

procedure TfrmBookmark.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);

  BookmarkURL := 'http://'; // do not localize
end;

procedure TfrmBookmark.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  TntEdit1.SetFocus;
end;

function TfrmBookmark.Get_Title: WideString;
begin
  Result := TntEdit1.Text;
end;

function TfrmBookmark.Get_URL: WideString;
begin
  Result := TntMemo1.Text;
end;

procedure TfrmBookmark.Set_Title(const Value: WideString);
begin
  TntEdit1.Text := Value;
  TntEdit1Change(nil);
end;

procedure TfrmBookmark.Set_URL(const Value: WideString);
begin
  TntMemo1.Text := Value;
  TntMemo1.SelStart := Length(TntMemo1.Text);
end;

procedure TfrmBookmark.TntEdit1Change(Sender: TObject);
begin
  lblName.Caption := TntEdit1.Text;
end;

end.
