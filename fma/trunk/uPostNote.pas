unit uPostNote;

{
*******************************************************************************
* Descriptions: Post-a-note implementation
* $Source: /cvsroot/fma/fma/uPostNote.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uPostNote.pas,v $
* Revision 1.6.2.1  2005/09/15 15:01:23  z_stoichev
* GUI fixes.
*
* Revision 1.6  2005/02/08 15:38:54  voxik
* Merged with L10N branch
*
* Revision 1.5.18.2  2004/10/25 20:21:55  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.5.18.1  2004/10/19 19:48:48  expertone
* Add localization (gnugettext)
*
* Revision 1.5  2003/11/28 09:38:07  z_stoichev
* Merged with branch-release-1-1 (Fma 0.10.28c)
*
* Revision 1.4.2.2  2003/11/27 12:54:22  z_stoichev
* Unicode support.
*
* Revision 1.4.2.1  2003/10/27 07:22:54  z_stoichev
* Build 0.1.0 RC1 Initial Checkin.
*
* Revision 1.4  2003/10/13 14:15:28  z_stoichev
* Added Class field (private or public).
*
* Revision 1.3  2003/01/30 04:15:57  warren00
* Updated with header comments
*
*
*******************************************************************************
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, StdCtrls, TntStdCtrls, ExtCtrls, TntExtCtrls,
  ComCtrls, TntComCtrls;

type
  TfrmNote = class(TTntForm)
    OkButton: TTntButton;
    CancelButton: TTntButton;
    PageControl1: TTntPageControl;
    TabSheet1: TTntTabSheet;
    Bevel1: TTntBevel;
    Image1: TTntImage;
    lblName: TTntLabel;
    Label1: TTntLabel;
    Label2: TTntLabel;
    TntMemo1: TTntMemo;
    TntComboBox1: TTntComboBox;
    procedure FormCreate(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure TntFormShow(Sender: TObject);
  private
    function Get_Note: WideString;
    function Get_Type: Integer;
    procedure Set_Note(const Value: WideString);
    procedure Set_Type(const Value: Integer);
    function Get_Class: WideString;
    procedure Set_Class(const Value: WideString);
    { Private declarations }
  public
    { Public declarations }
    property NoteText: WideString read Get_Note write Set_Note;
    property NoteClass: WideString read Get_Class write Set_Class;
    property NoteType: Integer read Get_Type write Set_Type;
  end;

var
  frmNote: TfrmNote;

implementation

uses
  gnugettext, gnugettexthelpers,
  uDialogs;

{$R *.dfm}

procedure TfrmNote.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);
end;

function TfrmNote.Get_Class: WideString;
begin
  Result := TntComboBox1.Text;
end;

function TfrmNote.Get_Note: WideString;
begin
  Result := TntMemo1.Text;
end;

function TfrmNote.Get_Type: Integer;
begin
  Result := TntComboBox1.ItemIndex;
end;

procedure TfrmNote.OkButtonClick(Sender: TObject);
begin
  if Trim(NoteText) = '' then begin
    MessageDlgW(_('You must enter note contents.'),mtError,MB_OK);
    exit;
  end;
  ModalResult := mrOk;
end;

procedure TfrmNote.Set_Class(const Value: WideString);
begin
  TntComboBox1.ItemIndex := TntComboBox1.Items.IndexOf(Value);
end;

procedure TfrmNote.Set_Note(const Value: WideString);
begin
  TntMemo1.Text := Value;
end;

procedure TfrmNote.Set_Type(const Value: Integer);
begin
  TntComboBox1.ItemIndex := Value;
end;

procedure TfrmNote.TntFormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  TntMemo1.SetFocus;
end;

end.
