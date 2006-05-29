unit uGetContact;

{
*******************************************************************************
* Descriptions: Selecting A Contact
* $Source: /cvsroot/fma/fma/uGetContact.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uGetContact.pas,v $
* Revision 1.2.2.1  2005/09/18 20:32:16  z_stoichev
* Get/select contact(s) fixes.
* Do not delay dialog show.
*
* Revision 1.2  2005/02/08 15:38:51  voxik
* Merged with L10N branch
*
* Revision 1.1.14.2  2004/10/25 20:21:42  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.1.14.1  2004/10/19 19:48:38  expertone
* Add localization (gnugettext)
*
* Revision 1.1  2004/06/29 11:51:15  z_stoichev
* Added Select One Contact support
*
*
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, uSelectContact, Placemnt, Menus, TntMenus, ImgList, StdCtrls, TntStdCtrls,
  ComCtrls, TntComCtrls, UniTntCtrls, ExtCtrls, TntExtCtrls;

type
  TfrmGetContact = class(TfrmSelContact)
    procedure TntListView1SelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure OkButtonClick(Sender: TObject);
    procedure TntListView1DblClick(Sender: TObject);
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure DoSelectDefaultItem; override;
  public
    { Public declarations }
  end;

var
  frmGetContact: TfrmGetContact;

implementation

uses
  gnugettext, gnugettexthelpers;

{$R *.dfm}

procedure TfrmGetContact.TntListView1SelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  inherited;
  OkButton.Enabled := AddButton.Enabled;
  OkButton.Default := AddButton.Enabled;
end;

procedure TfrmGetContact.OkButtonClick(Sender: TObject);
begin
  { Use selected contact in top list as current selection and exit }
  AddButton.Click;
  ModalResult := mrOk;
end;

procedure TfrmGetContact.TntListView1DblClick(Sender: TObject);
begin
  if OkButton.Enabled then OkButton.Click;
end;

procedure TfrmGetContact.DoSelectDefaultItem;
var
  i: integer;
begin
  inherited;
  { Select contact in top list }
  if SelectedList.Items.Count <> 0 then begin
    for i := 0 to TntListView1.Items.Count-1 do
      { Compare both name and number }
      if (WideCompareText(TntListView1.Items[i].Caption,SelectedList.Items[0].Caption) = 0) and
        (WideCompareText(TntListView1.Items[i].SubItems[0],SelectedList.Items[0].SubItems[0]) = 0) then begin
        TntListView1.Items[i].Selected := True;
        TntListView1.Items[i].MakeVisible(False);
        break;
      end;
    { clear current selection in order to allow selecting of new one }
    SelectedList.Items.Clear;
  end;
end;

end.
