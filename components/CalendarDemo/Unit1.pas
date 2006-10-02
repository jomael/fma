unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, SECalendar, StdCtrls, XPMan, Menus;

type
  TForm1 = class(TForm)
    SECalendar1: TSECalendar;
    Button1: TButton;
    XPManifest1: TXPManifest;
    Label1: TLabel;
    Label2: TLabel;
    PopupMenu1: TPopupMenu;
    AddSetting1: TMenuItem;
    N1: TMenuItem;
    ClearSetting1: TMenuItem;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure SECalendar1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SECalendar1SelChange(Sender: TObject);
    procedure ClearSetting1Click(Sender: TObject);
    procedure AddSetting1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateView;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Math;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.SECalendar1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key = ord('A')) then { Ctrl+A selects all }
    SECalendar1.SelectAll;
end;

procedure TForm1.SECalendar1SelChange(Sender: TObject);
var
  s: string;
  i: integer;
  c: TCalSelection;
  o: TObject;
begin
  s := '';
  c := SECalendar1.Selection;
  for i := 1 to 31 do
    if i in c then s := s + IntToStr(i) + ' ';
  Label2.Caption := s;
  s := '';
  o := SECalendar1.DateObjects[SECalendar1.CalendarDate];
  if Assigned(o) then
    with o as TStringList do s := Text;
  Label4.Caption := s;
end;

procedure TForm1.ClearSetting1Click(Sender: TObject);
var
  i: integer;
  s: TCalSelection;
begin
  s := SECalendar1.Selection;
  for i := 1 to 31 do
    if i in s then
      SECalendar1.DateObjects[SECalendar1.DayToDate(i)] := nil;
  UpdateView;
end;

procedure TForm1.AddSetting1Click(Sender: TObject);
var
  i: integer;
  s: TCalSelection;
  o: TStringList;
  a: string;
begin
  a := 'Sample text';
  if InputQuery('Add Setting','Text:',a) then begin
    s := SECalendar1.Selection;
    for i := 1 to 31 do
      if i in s then begin
        o := TStringList.Create;
        o.Text := a;
        SECalendar1.DateObjects[SECalendar1.DayToDate(i)] := o;
      end;
    UpdateView;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  SECalendar1.OwnObjects := True;
end;

procedure TForm1.UpdateView;
begin
  SECalendar1SelChange(SECalendar1);
  SECalendar1.Repaint;
end;

end.
