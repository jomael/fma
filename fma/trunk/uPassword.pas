unit uPassword;

{
*******************************************************************************
* Descriptions: Enter or change a password dialog.
* $Source: /cvsroot/fma/fma/Attic/uPassword.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uPassword.pas,v $
*
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TntStdCtrls, ExtCtrls;

type
  TfrmPassword = class(TForm)
    Image1: TImage;
    lblOldPass: TTntLabel;
    edPassword: TTntEdit;
    lblPass1: TTntLabel;
    edNewPassword1: TTntEdit;
    lblPass2: TTntLabel;
    edNewPassword2: TTntEdit;
    btnOK: TTntButton;
    btnCancel: TTntButton;
    TntLabel4: TTntLabel;
    edPhone: TTntEdit;
    lblDescription: TTntLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    FAllowChange: boolean;
    FPhoneLock: WideString;
    procedure Set_AllowChange(const Value: boolean);
    procedure Set_Phone(const Value: widestring);
    procedure DoSanityCheck;
  public
    { Public declarations }
    function LoginModal(APhoneName,APhoneLock: WideString): TModalResult;
    function NewPassModal(APhoneName: WideString; var APhoneLock: WideString): TModalResult;

    property AllowChange: boolean read FAllowChange write Set_AllowChange;
    property PhoneName: widestring write Set_Phone;
  end;

var
  frmPassword: TfrmPassword;

function BaseEncode(S: WideString): String;
function BaseDecode(S: String): WideString;

implementation

{$R *.dfm}

uses
  gnugettext, gnugettexthelpers,
  Zlib, Unit1, uDialogs;

function BaseEncode(S: WideString): String;
var
  ms: TMemoryStream;
  i: Integer;
  a: String;
begin
  ms := TMemoryStream.Create;
  try
    A := '';
    for i := 1 to Length(S) do
      A := A + IntToHex(Word(S[i]),4);
    with TCompressionStream.Create(clDefault,ms) do
    try
      Write(A[1],Length(A));
    finally
      Free;
    end;
    i := ms.Size;
    SetLength(A,i);
    ms.Position := 0;
    ms.ReadBuffer(A[1],i);
    Result := '';
    for i := 1 to Length(A) do
      Result := Result + IntToHex(Byte(A[i]),2);
  finally
    ms.Free;
  end;
end;

function BaseDecode(S: String): WideString;
var
  ms: TMemoryStream;
  i: Integer;
begin
  ms := TMemoryStream.Create;
  try
    for i := 1 to Length(S) div 2 do
      S[i] := Char(StrToInt('$'+Copy(S,i*2-1,2)));
    SetLength(S,Length(S) div 2);
    ms.Write(S[1],Length(S));
    ms.Position := 0;
    with TDecompressionStream.Create(ms) do
    try
      SetLength(S,1000);
      i := Read(S[1],1000);
      SetLength(S,i);
      Result := '';
      for i := 1 to Length(S) div 4 do
        Result := Result + WideChar(StrToInt('$'+Copy(S,4*i-3,4)));
    finally
      Free;
    end
  finally
    ms.Free;
  end;
end;

{ TfrmPassword }

procedure TfrmPassword.Set_AllowChange(const Value: boolean);
begin
  FAllowChange := Value;
  lblPass1.Visible := Value;
  lblPass2.Visible := Value;
  edNewPassword1.Visible := Value;
  edNewPassword2.Visible := Value;
  lblDescription.Visible := not Value;
  if Value then
    lblOldPass.Caption := _('Old Password:')
  else
    lblOldPass.Caption := _('Password:');
end;

procedure TfrmPassword.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);

  lblDescription.Caption :=
    _('Only the above phone''s owner could access this phone profile database.') + ' ' +
    _('Please enter your password and click OK to continue, or click Cancel to start a new profile.');
end;

procedure TfrmPassword.Set_Phone(const Value: widestring);
begin
  edPhone.Text := Value;
end;

procedure TfrmPassword.btnOKClick(Sender: TObject);
begin
  btnOK.Enabled := False;
  try
    DoSanityCheck;
    ModalResult := mrOk;
  finally
    btnOK.Enabled := True;
  end;
end;

function TfrmPassword.LoginModal(APhoneName,APhoneLock: WideString): TModalResult;
begin
  AllowChange := False;
  PhoneName := APhoneName;
  FPhoneLock := APhoneLock;
  Result := ShowModal;
end;

function TfrmPassword.NewPassModal(APhoneName: WideString; var APhoneLock: WideString): TModalResult;
begin
  AllowChange := True;
  PhoneName := APhoneName;
  FPhoneLock := APhoneLock;
  Result := ShowModal;
  if Result = mrOk then APhoneLock := edNewPassword1.Text;
end;

procedure TfrmPassword.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := btnOK.Enabled;
end;

procedure TfrmPassword.DoSanityCheck;
begin
  if edNewPassword1.Visible and (edNewPassword1.Text <> '') and
    (WideCompareStr(edNewPassword1.Text,edNewPassword2.Text) <> 0) then begin
    MessageDlgW(_('Your new password do not match in both fields.'),mtError,MB_OK);
    edNewPassword2.SelectAll;
    edNewPassword2.SetFocus;
    Abort;
  end;
  if WideCompareStr(edPassword.Text,FPhoneLock) <> 0 then begin
    WaitASec(1);
    MessageDlgW(_('Access is denied!') + sLineBreak + sLineBreak +
      _('Please check your password and try again.'),mtError,MB_OK);
    edPassword.SelectAll;
    edPassword.SetFocus;
    Abort;
  end;
end;

end.

