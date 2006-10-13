unit uAddToGroup;

{
*******************************************************************************
* Descriptions: Add contact to phone group 
* $Source: /cvsroot/fma/fma/uAddToGroup.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uAddToGroup.pas,v $
*
*******************************************************************************
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, StdCtrls, TntStdCtrls, CheckLst, TntCheckLst, uSyncPhonebook,
  ExtCtrls, TntExtCtrls, jpeg;

type
  TfrmAddToGroup = class(TTntForm)
    Button1: TTntButton;
    Button2: TTntButton;
    Panel1: TTntPanel;
    Label1: TTntLabel;
    RadioButton1: TTntRadioButton;
    RadioButton2: TTntRadioButton;
    lblName: TTntLabel;
    Label2: TTntLabel;
    lblGroup: TTntLabel;
    clNumbers: TTntCheckListBox;
    Bevel1: TTntBevel;
    Image1: TTntImage;
    Label3: TTntLabel;
    lbProductName: TTntLabel;
    lblNumber: TTntLabel;
    RadioButton3: TTntRadioButton;
    Button3: TTntButton;
    procedure RadioButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FContact: PContactData;
    procedure Set_Contact(const Value: PContactData);
    { Private declarations }
  public
    { Public declarations }
    function CheckedCount: integer;
    function GetNumber(Index: integer): WideString;
    property Contact: PContactData read FContact write Set_Contact;
  end;

var
  frmAddToGroup: TfrmAddToGroup;

implementation

uses
  gnugettext, gnugettexthelpers,
  Unit1, uDialogs;

{$R *.dfm}

procedure TfrmAddToGroup.RadioButtonClick(Sender: TObject);
begin
  clNumbers.Enabled := RadioButton2.Checked;
end;

procedure TfrmAddToGroup.Set_Contact(const Value: PContactData);
var
  i: integer;
begin
  FContact := Value;
  { Build contact numbers check list }
  clNumbers.Items.Clear;
  lblName.Caption := GetContactFullName(FContact);
  if FContact^.cell  <> '' then clNumbers.Items.Add(Format( _('Cell [%s]'), [FContact^.cell]));
  if FContact^.work  <> '' then clNumbers.Items.Add(Format( _('Work [%s]'), [FContact^.work]));
  if FContact^.home  <> '' then clNumbers.Items.Add(Format( _('Home [%s]'), [FContact^.home]));
  if FContact^.other <> '' then clNumbers.Items.Add(Format(_('Other [%s]'), [FContact^.other]));
  { Find default number }
  lblNumber.Caption := GetContactDefPhone(FContact);
  for i := 0 to clNumbers.Count-1 do
    if GetNumber(i) = lblNumber.Caption then begin
      lblNumber.Caption := clNumbers.Items[i];
      break;
    end;
  { Update view }
  RadioButton1.Checked := True;
  RadioButtonClick(nil);
end;

procedure TfrmAddToGroup.Button1Click(Sender: TObject);
var
  i: integer;
begin
  if RadioButton3.Checked then begin
    for i := 0 to clNumbers.Count-1 do clNumbers.Checked[i] := True;
    RadioButton2.Checked := True;
  end;
  if CheckedCount = 0 then begin
    if clNumbers.Count = 0 then 
      MessageDlgW(_('This contact does not have any phone numbers.'),mtError,MB_OK)
    else    
      MessageDlgW(_('You have to select at least one phone number.'),mtError,MB_OK);
    Abort;
  end;
  ModalResult := mrOk;  
end;

function TfrmAddToGroup.CheckedCount: integer;
var
  i: integer;
begin
  if RadioButton2.Checked then begin
    Result := 0;
    for i := 0 to clNumbers.Count-1 do
      if clNumbers.Checked[i] then Result := Result + 1;
  end
  else
    Result := byte(lblNumber.Caption <> '');
end;

procedure TfrmAddToGroup.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);

{$IFNDEF VER150}
  Form1.ThemeManager1.CollectForms(Self);
{$ELSE}
  Panel1.ParentBackground := False;
{$ENDIF}

  Image1.Picture.Assign(Form1.FmaWebUpdate1.Picture);
  lblName.Font.Style := lblName.Font.Style + [fsBold];
end;

function TfrmAddToGroup.GetNumber(Index: integer): WideString;
begin
  if (Index >= 0) and (Index < clNumbers.Count) then
    Result := Form1.ExtractNumber(clNumbers.Items[Index])
  else
    Result := '';
end;

procedure TfrmAddToGroup.Button2Click(Sender: TObject);
begin
  if MessageDlgW(_('The Wizard is not complete. Do you really want to exit?'+
    sLinebreak+sLinebreak+'You can run this wizard at a later time to complete it.'+
    sLinebreak+sLinebreak+'To exit Wizard right now click Yes. To continue click No.'),
    mtConfirmation, MB_YESNO) = ID_YES then
    ModalResult := mrCancel;
end;

end.
