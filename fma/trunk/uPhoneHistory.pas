unit uPhoneHistory;

{
*******************************************************************************
* Descriptions: Phone Numbers History editor
* $Source: /cvsroot/fma/fma/uPhoneHistory.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uPhoneHistory.pas,v $
*
*******************************************************************************
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TntStdCtrls, ComCtrls, TntComCtrls, ExtCtrls,
  TntExtCtrls;

type
  TfrmPhoneHistory = class(TForm)
    lvPhones: TTntListView;
    NewButton: TTntButton;
    EditButton: TTntButton;
    DeleteButton: TTntButton;
    TntBevel1: TTntBevel;
    OkButton: TTntButton;
    CancelButton: TTntButton;
    procedure lvPhonesSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure DeleteButtonClick(Sender: TObject);
    procedure NewButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure lvPhonesDblClick(Sender: TObject);
    procedure lvPhonesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure CheckNumber(Num: String);
    function GetNums: WideString;
    procedure SetNums(const Value: WideString);
  public
    { Public declarations }
    property Numbers: WideString read GetNums write SetNums;
  end;

var
  frmPhoneHistory: TfrmPhoneHistory;

implementation

uses
  gnugettext, gnugettexthelpers,
  uGlobal, uDialogs, uInputQuery;

{$R *.dfm}

procedure TfrmPhoneHistory.lvPhonesSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  EditButton.Enabled := lvPhones.SelCount = 1;
  DeleteButton.Enabled := lvPhones.SelCount <> 0;
end;

procedure TfrmPhoneHistory.CheckNumber(Num: String);
var
  i: Integer;
begin
  for i := 1 to Length(Num) do
    if not (Num[i] in ['+','0'..'9','#','*','p']) then begin // do not localize
      MessageDlgW(_('Incorrect phone number specified!'),mtError,MB_OK);
      Abort;
    end;
end;

procedure TfrmPhoneHistory.DeleteButtonClick(Sender: TObject);
var
  i: Integer;
begin
  if MessageDlgW(WideFormat(_('Deleting %d %s. Are you sure?'),
    [lvPhones.SelCount,ngettext('number','numbers',lvPhones.SelCount)]),
    mtConfirmation,MB_YESNO or MB_DEFBUTTON2) = ID_YES then begin
    for i := lvPhones.Items.Count-1 downto 0 do
      if lvPhones.Items[i].Selected then lvPhones.Items[i].Delete;
  end;
end;

procedure TfrmPhoneHistory.NewButtonClick(Sender: TObject);
var
  s: WideString;
begin
  s := '';
  if WideInputQuery(_('New Number'),_('Enter number:'),s) then begin
    s := Trim(s);
    CheckNumber(s);
    lvPhones.Items.Add.Caption := s;
  end;
end;

procedure TfrmPhoneHistory.EditButtonClick(Sender: TObject);
var
  s: WideString;
begin
  s := lvPhones.Selected.Caption;
  if WideInputQuery(_('Edit Number'),_('Enter number:'),s) then begin
    s := Trim(s);
    CheckNumber(s);
    lvPhones.Selected.Caption := s;
  end;
end;

function TfrmPhoneHistory.GetNums: WideString;
var
  s: WideString;
  i: Integer;
begin
  s := '';
  for i := 0 to lvPhones.Items.Count-1 do begin
    if i <> 0 then s := s + '|';
    s := s + lvPhones.Items[i].Caption;
  end;
  Result := s;
end;

procedure TfrmPhoneHistory.SetNums(const Value: WideString);
var
  s,n: WideString;
begin
  lvPhones.Items.Clear;
  s := Value;
  repeat
    n := GetFirstToken(s,'|');
    if n = '' then break;
    lvPhones.Items.Add.Caption := n;
  until s = '';
end;

procedure TfrmPhoneHistory.lvPhonesDblClick(Sender: TObject);
begin
  if EditButton.Enabled then EditButton.Click;
end;

procedure TfrmPhoneHistory.lvPhonesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    if EditButton.Enabled then EditButton.Click;
  if Key = VK_DELETE then
    if DeleteButton.Enabled then DeleteButton.Click;
  if (Key = Ord('A')) and (ssCtrl in Shift) then
    lvPhones.SelectAll;
end;

procedure TfrmPhoneHistory.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);
end;

end.
