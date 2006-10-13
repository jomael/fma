unit uConflictChanges;

{
*******************************************************************************
* Descriptions: Contact Conflict Details dialog
* $Source: /cvsroot/fma/fma/Attic/uConflictChanges.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uConflictChanges.pas,v $
*
*******************************************************************************
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, TntComCtrls, StdCtrls, TntStdCtrls, ExtCtrls;

type
  TfrmConflictChanges = class(TForm)
    lvChanges: TTntListView;
    btnOK: TTntButton;
    lblType: TTntLabel;
    lblContact: TTntLabel;
    TntLabel1: TTntLabel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function GetOption1: WideString;
    function GetOption2: WideString;
    function GetTarget: WideString;
    procedure SetOption1(const Value: WideString);
    procedure SetOption2(const Value: WideString);
    procedure SetTarget(const Value: WideString);
  public
    { Public declarations }
    procedure ClearChanges;
    procedure AddChange(const FieldName, Option1Value, Option2Value: WideString);
    function ChangeCount: Integer;
    property Target: WideString read GetTarget write SetTarget;
    property Option1: WideString read GetOption1 write SetOption1;
    property Option2: WideString read GetOption2 write SetOption2;
  end;

var
  frmConflictChanges: TfrmConflictChanges;

implementation

{$R *.dfm}

{ TfrmConflictChanges }

procedure TfrmConflictChanges.ClearChanges;
begin
  lvChanges.Clear;
  lvChanges.Columns[1].Caption := '';
  lvChanges.Columns[2].Caption := '';
end;

function TfrmConflictChanges.GetOption1: WideString;
begin
  Result := lvChanges.Columns[1].Caption;
end;

function TfrmConflictChanges.GetOption2: WideString;
begin
  Result := lvChanges.Columns[2].Caption;
end;

function TfrmConflictChanges.GetTarget: WideString;
begin
  Result := lblContact.Caption;
end;

procedure TfrmConflictChanges.SetOption1(const Value: WideString);
begin
  lvChanges.Columns[1].Caption := Value;
end;

procedure TfrmConflictChanges.SetOption2(const Value: WideString);
begin
  lvChanges.Columns[2].Caption := Value;
end;

procedure TfrmConflictChanges.SetTarget(const Value: WideString);
begin
  lblContact.Caption := Value;
end;

procedure TfrmConflictChanges.AddChange(const FieldName, Option1Value, Option2Value: WideString);
begin
  with lvChanges.Items.Add do begin
    Caption := FieldName;
    SubItems.Add(Option1Value);
    SubItems.Add(Option2Value);
  end;
end;

procedure TfrmConflictChanges.FormCreate(Sender: TObject);
begin
  lblContact.Left := lblType.Left + lblType.Width + 8;
  lblContact.Font.Style := lblContact.Font.Style + [fsBold];
end;

function TfrmConflictChanges.ChangeCount: Integer;
begin
  Result := lvChanges.Items.Count;
end;

end.
