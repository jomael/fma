unit uChooseLink;

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, StdCtrls, TntStdCtrls, uContactSync, ComCtrls, TntComCtrls, UniTntCtrls, ExtCtrls, TntExtCtrls,
  ImgList;

type
  TfrmChooseLink = class(TTntForm)
    Label1: TTntLabel;
    lblLinks: TTntLabel;
    btnOk: TTntButton;
    Image1: TTntImage;
    btnCancel: TTntButton;
    lvContacts: TTntListView;
    lblType: TTntLabel;
    lblContact: TTntLabel;
    ImageList1: TImageList;
    cbDontAsk: TTntCheckBox;
    grpAction: TTntRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure lvContactsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure ActionClick(Sender: TObject);
  private
    FContact: TContact;
    FPossibleLinks: TPossibleLinks;
    procedure SetContact(const Value: TContact);
    procedure SetPossibleLinks(const Value: TPossibleLinks);
  public
    property Contact: TContact read FContact write SetContact;
    property PossibleLinks: TPossibleLinks read FPossibleLinks write SetPossibleLinks;
    function OtherContact(GetDefaultOne: boolean = False): TContact;
  end;

implementation

uses
  gnugettext, gnugettexthelpers,
  Unit1;

{$R *.dfm}

{ TfrmChooseLink }

function TfrmChooseLink.OtherContact(GetDefaultOne: boolean): TContact;
begin
  Result := nil;
  if GetDefaultOne and (lvContacts.Items.Count <> 0) then
    lvContacts.Selected := lvContacts.Items[0];
  if lvContacts.Selected <> nil then
    Result := FPossibleLinks[lvContacts.Selected.Index].Contact;
end;

procedure TfrmChooseLink.SetContact(const Value: TContact);
begin
  FContact := Value;
  lblContact.Caption := FContact.FullName;
end;

procedure TfrmChooseLink.SetPossibleLinks(const Value: TPossibleLinks);
var I: Integer;
begin
  FPossibleLinks := Value;
  lvContacts.Items.BeginUpdate;
  try
    lvContacts.Items.Clear;
    for I := 0 to FPossibleLinks.Count - 1 do
      with lvContacts.Items.Add do begin
        Caption := FPossibleLinks[I].Contact.FullName;
        ImageIndex := 2;
      end;
  finally
    lvContacts.Items.EndUpdate;
  end;
end;

procedure TfrmChooseLink.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);

  lblContact.Font.Style := lblContact.Font.Style + [fsBold];
  //lblLinks.Font.Style := lblLinks.Font.Style + [fsBold];
end;

procedure TfrmChooseLink.lvContactsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  btnOk.Enabled := Selected or (grpAction.ItemIndex = 1);
  btnOk.Default := btnOk.Enabled;
end;

procedure TfrmChooseLink.FormShow(Sender: TObject);
begin
  lvContacts.SetFocus;
  if lvContacts.Items.Count <> 0 then begin
    lvContacts.Selected := lvContacts.Items[0];
    lvContactsSelectItem(lvContacts,lvContacts.Selected,True);
  end;
end;

procedure TfrmChooseLink.btnOkClick(Sender: TObject);
begin
  { mrOK = Link Contact, mrAll = Link All, mrIgnore = Add as New }
  if (grpAction.ItemIndex = 1) then
    ModalResult := mrIgnore
  else
  if cbDontAsk.Checked then
    ModalResult := mrAll
  else
    ModalResult := mrOK;
end;

procedure TfrmChooseLink.ActionClick(Sender: TObject);
begin
  case grpAction.ItemIndex of
    0: begin
      lvContacts.Enabled := True;
      lvContacts.Color := clWindow;
      cbDontAsk.Enabled := True;
    end;
    1: begin
      lvContacts.Enabled := False;
      lvContacts.Color := clBtnFace;
      cbDontAsk.Checked := False;
      cbDontAsk.Enabled := False;
    end;  
  end;
  lvContactsSelectItem(lvContacts,lvContacts.Selected,lvContacts.Selected <> nil);
end;

end.
