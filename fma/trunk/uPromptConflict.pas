unit uPromptConflict;

{
*******************************************************************************
* Descriptions: Interface to solve the conflits during synchronize's phonebook
* $Source: /cvsroot/fma/fma/uPromptConflict.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uPromptConflict.pas,v $
* Revision 1.5.2.2  2005/09/01 13:43:25  z_stoichev
* Added Resolve Conflict Show Changes support.
*
* Revision 1.5.2.1  2005/08/30 12:55:43  z_stoichev
* - Added Conflict dialog Don't Ask Again checkbox.
* - Fixed Prompt Conflict unicode and GUI layout.
* - Fixed Sync Conflict when priority is Let Me Chose.
*
* Revision 1.5  2005/02/08 15:38:54  voxik
* Merged with L10N branch
*
* Revision 1.4.14.3  2005/01/07 17:34:38  expertone
* Merge with MAIN branch
*
* Revision 1.4.14.2  2004/10/25 20:21:55  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.4.14.1  2004/10/19 19:48:48  expertone
* Add localization (gnugettext)
*
* Revision 1.4  2004/06/19 15:43:11  lordlarry
* Added more Unicode support
*
* Revision 1.3  2004/06/05 13:32:56  lordlarry
* Merged with OutlookSync branch
*
* Revision 1.2.4.2  2004/05/17 12:45:12  z_stoichev
* Build 0.1.1.10 beta 2
*
* Revision 1.2.4.1  2004/03/08 17:43:00  lordlarry
* Added properties so it could also be used in the Outlook Synchronization part
*
* Revision 1.2  2003/11/28 09:38:07  z_stoichev
* Merged with branch-release-1-1 (Fma 0.10.28c)
*
* Revision 1.1.2.1  2003/10/27 07:22:54  z_stoichev
* Build 0.1.0 RC1 Initial Checkin.
*
* Revision 1.1  2003/02/14 14:23:54  crino77
* Initial Checkin
*
* $Revision: 1.5.2.2 $
*
*
*******************************************************************************
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, StdCtrls, TntStdCtrls, ExtCtrls, TntExtCtrls;

type
  TSyncConflictChangesEvent = procedure(Sender: TObject;
    const TargetName, Option1Name, Option2Name: WideString) of object;

  TfrmPromptConflict = class(TTntForm)
    Button1: TTntButton;
    grpConflict: TTntRadioGroup;
    lblType: TTntLabel;
    Button2: TTntButton;
    lblContact: TTntLabel;
    Image1: TImage;
    cbDontAskAgain: TTntCheckBox;
    grpDescription: TTntGroupBox;
    lblInfo: TTntLabel;
    btnViewChanges: TTntButton;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnViewChangesClick(Sender: TObject);
  private
    FOnChanges: TSyncConflictChangesEvent;
    function GetInfo: WideString;
    function GetItem0Name: WideString;
    function GetItem1Name: WideString;
    function GetSelectedItem: Integer;
    procedure SetInfo(const Value: WideString);
    procedure SetItem0Name(const Value: WideString);
    procedure SetItem1Name(const Value: WideString);
    procedure SetSelectedItem(const Value: Integer);
    function GetContact: WideString;
    procedure SetContact(const Value: WideString);
    function GetType: WideString;
    procedure SetType(const Value: WideString);
    procedure Set_OnChanges(const Value: TSyncConflictChangesEvent);
  public
    property ObjKind: WideString read GetType write SetType;
    property ObjName: WideString read GetContact write SetContact;
    property Info: WideString read GetInfo write SetInfo;
    property Item0Name: WideString read GetItem0Name write SetItem0Name;
    property Item1Name: WideString read GetItem1Name write SetItem1Name;
    property SelectedItem: Integer read GetSelectedItem write SetSelectedItem;
    property OnViewChanges: TSyncConflictChangesEvent read FOnChanges write Set_OnChanges;
  end;

var
  frmPromptConflict: TfrmPromptConflict;

implementation

uses
  gnugettext, gnugettexthelpers;

{$R *.dfm}

{ TfrmPromptConflict }

function TfrmPromptConflict.GetContact: WideString;
begin
  Result := lblContact.Caption;
end;

function TfrmPromptConflict.GetInfo: WideString;
begin
  Result := lblInfo.Caption;
end;

function TfrmPromptConflict.GetItem0Name: WideString;
begin
  Result := grpConflict.Items[0];
end;

function TfrmPromptConflict.GetItem1Name: WideString;
begin
  Result := grpConflict.Items[1];
end;

function TfrmPromptConflict.GetSelectedItem: Integer;
begin
  Result := grpConflict.ItemIndex;
end;

procedure TfrmPromptConflict.SetContact(const Value: WideString);
begin
  lblContact.Caption := Value;
end;

procedure TfrmPromptConflict.SetInfo(const Value: WideString);
begin
  lblInfo.Caption := Value;
end;

procedure TfrmPromptConflict.SetItem0Name(const Value: WideString);
begin
  grpConflict.Items[0] := Value;
end;

procedure TfrmPromptConflict.SetItem1Name(const Value: WideString);
begin
  grpConflict.Items[1] := Value;
end;

procedure TfrmPromptConflict.SetSelectedItem(const Value: Integer);
begin
  grpConflict.ItemIndex := Value;
end;

procedure TfrmPromptConflict.Button2Click(Sender: TObject);
begin
  Close;
  raise Exception.Create(_('Contacts linking aborted by user'));
end;

procedure TfrmPromptConflict.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);
  lblContact.Font.Style := lblContact.Font.Style + [fsBold];
end;

function TfrmPromptConflict.GetType: WideString;
begin
  Result := lblType.Caption;
end;

procedure TfrmPromptConflict.SetType(const Value: WideString);
var
  w: Integer;
begin
  w := lblType.Width;
  lblType.Caption := Value;
  w := lblType.Width - w;
  lblContact.Width := lblContact.Width - w;
  lblContact.Left := lblContact.Left + w;
end;

procedure TfrmPromptConflict.Set_OnChanges(
  const Value: TSyncConflictChangesEvent);
begin
  FOnChanges := Value;
  btnViewChanges.Enabled := Assigned(Value);
end;

procedure TfrmPromptConflict.btnViewChangesClick(Sender: TObject);
begin
  if Assigned(FOnChanges) then
    FOnChanges(Self, ObjName, Item0Name, Item1Name);
end;

end.
