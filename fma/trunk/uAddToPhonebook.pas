unit uAddToPhonebook;

{
*******************************************************************************
* Descriptions: Add Contact to Phonebook
* $Source: /cvsroot/fma/fma/uAddToPhonebook.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uAddToPhonebook.pas,v $
* Revision 1.7.2.7  2005/09/20 14:44:57  z_stoichev
* Changed Confirmations default button to NO.
*
* Revision 1.7.2.6  2005/09/18 20:34:03  z_stoichev
* Add to Phonebook fixes.
* Avoid dublicate adds (ERROR response).
*
* Revision 1.7.2.5  2005/09/16 10:41:08  z_stoichev
* Fixed phone type is disabled always.
*
* Revision 1.7.2.4  2005/09/06 18:32:55  z_stoichev
* Bugfixes and improvements (2.1.1.102b)
*
* Revision 1.7.2.3  2005/08/24 08:32:24  z_stoichev
* Fixed panel background in Windows XP themes.
*
* Revision 1.7.2.2  2005/08/23 20:58:43  z_stoichev
* - Fixed Add to Phonebook GUI depends on target source.
* - Added Add to Phonebook/Group Cancel confirmation.
*
* Revision 1.7.2.1  2005/08/20 18:07:47  z_stoichev
* - Fixed Find contact in Phonebook (Irmc), Phone Book, SIM.
* - Fixed Add contact to phonebook when replacing old one.
*
* Revision 1.7  2005/02/18 15:22:52  z_stoichev
* Fixed behaviour when IRMC is disabled.
* Added Lookup into SIM phone book.
*
* Revision 1.6  2005/02/08 15:38:33  voxik
* Merged with L10N branch
*
* Revision 1.5.2.4  2005/02/02 23:15:51  voxik
* Changed MessageDlg and ShowMessages replaced by new unicode versions
*
* Revision 1.5.2.3  2005/01/07 17:34:29  expertone
* Merge with MAIN branch
*
* Revision 1.5.2.2  2004/10/25 20:21:37  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.5.2.1  2004/10/19 19:48:30  expertone
* Add localization (gnugettext)
*
* Revision 1.5  2004/10/15 14:01:53  z_stoichev
* Merged with Stable bugfixes
*
* Revision 1.4  2004/09/08 20:21:22  lordlarry
* Changed the Exception to a ShowMessage. Don't scare the poor users again :)
*
* Revision 1.3.6.1  2004/09/08 20:21:19  lordlarry
* Added Exception.Message to the Exception Details Log
*
* Revision 1.3  2004/07/07 08:10:46  z_stoichev
* Common Wizard Image usage
*
* Revision 1.2  2004/06/30 15:28:26  z_stoichev
* GUI improvements
*
* Revision 1.1  2004/06/30 14:05:20  z_stoichev
* Initial checkin.
*
*
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls,
  TntControls, Forms, TntForms, Dialogs, TntDialogs, StdCtrls, TntStdCtrls, ExtCtrls, TntExtCtrls, uSyncPhonebook, uSIMEdit,
  VirtualTrees;

type
  TfrmAddContact = class(TTntForm)
    Bevel1: TTntBevel;
    btnOk: TTntButton;
    btnCancel: TTntButton;
    Panel1: TTntPanel;
    Image1: TTntImage;
    Label4: TTntLabel;
    lbProductName: TTntLabel;
    Button3: TTntButton;
    Label1: TTntLabel;
    lblNumber: TTntLabel;
    edContact: TTntEdit;
    btnSelect: TTntButton;
    RadioButton1: TTntRadioButton;
    RadioButton2: TTntRadioButton;
    rgPhoneType: TTntRadioGroup;
    procedure btnSelectClick(Sender: TObject);
    procedure RadioButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
    procedure Set_NewNumber(const Value: string);
  public
    { Public declarations }
    function GetSelectedContact: Pointer;
    property NewNumber: string write Set_NewNumber;
  end;

var
  frmAddContact: TfrmAddContact;

implementation

uses
  gnugettext, gnugettexthelpers,
  uGetContact, Unit1, uDialogs, uSelectContact;

{$R *.dfm}

procedure TfrmAddContact.btnSelectClick(Sender: TObject);
begin
  with TfrmGetContact.Create(nil) do
    try
      AllowSIMContacts := False; // IMPORTANT!!! Do not allow SIM Book contacts in Browse dialog
      AllowNoNumbers := True; // Allow contacts without numbers to be selected
      SelContacts := edContact.Text;
      if ShowModal = mrOk then begin
        edContact.Text := SelContacts;
        edContact.SetFocus;
        if not Form1.IsIrmcSyncEnabled then
          rgPhoneType.ItemIndex := 0; // only cell phone type for Non-IrmcSync contacts 
        RadioButtonClick(nil);
      end;
    finally
      Free;
    end;
end;

procedure TfrmAddContact.RadioButtonClick(Sender: TObject);
begin
  edContact.Enabled := RadioButton2.Checked;
  btnSelect.Enabled := edContact.Enabled;
  rgPhoneType.Enabled := edContact.Enabled;
end;

procedure TfrmAddContact.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);
  
{$IFNDEF VER150}
  Form1.ThemeManager1.CollectForms(Self);
{$ELSE}
  Panel1.ParentBackground := False;
{$ENDIF}

  Image1.Picture.Assign(Form1.FmaWebUpdate1.Picture);
  lblNumber.Font.Style := lblNumber.Font.Style + [fsBold];

  rgPhoneType.ItemIndex := 0; // cell phone
  { TODO: Add support for phone types when IrmcSync is disabled }
  rgPhoneType.Visible := Form1.IsIrmcSyncEnabled;
end;

procedure TfrmAddContact.btnOkClick(Sender: TObject);
var
  ContactData: PContactData;
  SIMData: PSIMData;
  Number: string;
begin
  if RadioButton1.Checked then
    ModalResult := mrOk
  else begin
    if Form1.IsIrmcSyncEnabled then begin
      ContactData := GetSelectedContact;
      if ContactData = nil then begin
        ShowMessageW(_('You have to select an existing contact first'));
        Exit;
      end;
      case rgPhoneType.ItemIndex of
        0: Number := ContactData^.cell;
        1: Number := ContactData^.work;
        2: Number := ContactData^.home;
        3: Number := ContactData^.fax;
        4: Number := ContactData^.other;
      end;
    end
    else begin
      SIMData := GetSelectedContact;
      if SIMData = nil then begin
        ShowMessageW(_('You have to select an existing contact first'));
        Exit;
      end;
      Number := SIMData^.pnumb;
    end;
    if (Number = '') or (MessageDlgW(Format(_('Do you want to replace existing phone number "%s"?'), [Number]),
      mtConfirmation, MB_YESNO or MB_DEFBUTTON2) = ID_YES) then
      ModalResult := mrOk;
  end;
end;

function TfrmAddContact.GetSelectedContact: Pointer;
var
  ContactData: PContactData;
  SIMData: PSIMData;
  Contact: WideString;
begin
  Result := nil;
  if RadioButton2.Checked then begin
    Contact := Form1.ExtractContact(edContact.Text);
    if Form1.IsIrmcSyncEnabled then begin
      Form1.frmSyncPhonebook.FindContact(Contact,ContactData);
      Result := ContactData;
    end
    else begin
      Form1.frmMEEdit.FindContact(Contact,SIMData);
      Result := SIMData;
    end;
  end;
end;

procedure TfrmAddContact.Set_NewNumber(const Value: string);
begin
  lblNumber.Caption := Value;
end;

procedure TfrmAddContact.btnCancelClick(Sender: TObject);
begin
  if MessageDlgW(_('The Wizard is not complete. Do you really want to exit?'+
    sLinebreak+sLinebreak+'You can run this wizard at a later time to complete it.'+
    sLinebreak+sLinebreak+'To exit Wizard right now click Yes. To continue click No.'),
    mtConfirmation, MB_YESNO) = ID_YES then
    ModalResult := mrCancel;
end;

end.
