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
    procedure SetCancel(const Value: boolean);
  public
    property CanBeAborted: boolean write SetCancel;
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

procedure TfrmPromptConflict.SetCancel(const Value: boolean);
begin
  Button2.Enabled := Value;
end;

end.
