unit uCallContact;

{
*******************************************************************************
* Descriptions: Call Contact Dialog
* $Source: /cvsroot/fma/fma/uCallContact.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uCallContact.pas,v $
*
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, StdCtrls, TntStdCtrls, Placemnt, Buttons, TntButtons, Menus, TntMenus,
  ExtCtrls;

const
  MaxFavorites = 20;  

type
  TfrmCallContact = class(TTntForm)
    Label1: TTntLabel;
    btnCall: TTntButton;
    btnCancel: TTntButton;
    btnSelect: TTntButton;
    FormPlacement1: TFormPlacement;
    edContact: TTntEdit;
    SpeedButton1: TTntSpeedButton;
    FavoritesPopupMenu: TTntPopupMenu;
    AddToFavorites1: TTntMenuItem;
    Organize1: TTntMenuItem;
    N2: TTntMenuItem;
    Image1: TImage;
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edContactChange(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btnCallClick(Sender: TObject);
    procedure FavoritesPopupMenuPopup(Sender: TObject);
    procedure PopupMenu1Click(Sender: TObject);
    procedure Organize1Click(Sender: TObject);
    procedure AddToFavorites1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddRecipient(str: WideString);
  end;

var
  frmCallContact: TfrmCallContact;

implementation

uses
  gnugettext, gnugettexthelpers,
  uGetContact, Unit1, uSelectContact;

{$R *.dfm}

procedure TfrmCallContact.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCallContact.FormShow(Sender: TObject);
begin
  edContact.Text := '';
  edContact.SetFocus;
end;

procedure TfrmCallContact.edContactChange(Sender: TObject);
begin
  btnCall.Enabled := Trim(edContact.Text) <> '';
  btnCall.Default := btnCall.Enabled;
end;

procedure TfrmCallContact.btnSelectClick(Sender: TObject);
begin
  with TfrmGetContact.Create(nil) do
    try
      SelContacts := edContact.Text;
      if ShowModal = mrOk then begin
        edContact.Text := SelContacts;
        edContact.SetFocus;
      end;
    finally
      Free;
    end;
end;

procedure TfrmCallContact.btnCallClick(Sender: TObject);
var
  w: WideString;
begin
  w := Form1.ExtractNumber(edContact.Text);
  if w = '' then // only name?
    edContact.Text := Form1.ContactNumberByName(edContact.Text);
  if w = edContact.Text then // only tel?
    edContact.Text := Form1.ContactNumberByTel(edContact.Text);
  edContact.Update;
  Enabled := False;
  try
    Form1.AskRequestConnection;
    try
      Form1.VoiceCall(Form1.ExtractNumber(edContact.Text));
      Close;
    except
      Form1.Status(_('Error daling number'));
    end;
  finally
    Enabled := True;
  end;
end;

procedure TfrmCallContact.FavoritesPopupMenuPopup(Sender: TObject);
var
  i: integer;
  Item: TTntMenuItem;
begin
  AddToFavorites1.Enabled := edContact.Text <> '';
  while FavoritesPopupMenu.Items.Count > 3 do
    FavoritesPopupMenu.Items.Delete(3);
  for i := 0 to Form1.FFavoriteCalls.Count-1 do begin
    Item := TTntMenuItem.Create(FavoritesPopupMenu);
    Item.Caption := Form1.FFavoriteCalls[i];
    Item.AutoHotkeys := maManual;
    Item.ImageIndex := 26;
    Item.OnClick := PopupMenu1Click;
    FavoritesPopupMenu.Items.Add(Item);
  end;
end;

procedure TfrmCallContact.PopupMenu1Click(Sender: TObject);
begin
  edContact.Text := (Sender as TTntMenuItem).Caption;
  edContact.SetFocus;
end;

procedure TfrmCallContact.Organize1Click(Sender: TObject);
begin
  Form1.EditCallFavorites1.Click;
end;

procedure TfrmCallContact.AddToFavorites1Click(Sender: TObject);
begin
  if Form1.FFavoriteCalls.IndexOf(edContact.Text) = -1 then begin
    Form1.FFavoriteCalls.Insert(0,edContact.Text);
    while Form1.FFavoriteCalls.Count > MaxFavorites do
      Form1.FFavoriteCalls.Delete(MaxFavorites);
  end;
end;

procedure TfrmCallContact.SpeedButton1Click(Sender: TObject);
var
  p: TPoint;
begin
  with SpeedButton1 do p := ClientToScreen(Point(0,Height));
  FavoritesPopupMenu.Popup(p.X,p.Y);
end;

procedure TfrmCallContact.AddRecipient(str: WideString);
begin
  edContact.Text := str;
end;

procedure TfrmCallContact.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);
end;

end.
