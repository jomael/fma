unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, SECalendar, StdCtrls, XPMan;

type
  TForm1 = class(TForm)
    SECalendar1: TSECalendar;
    Button1: TButton;
    XPManifest1: TXPManifest;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure SECalendar1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SECalendar1SelChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

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
begin
  s := '';
  c := SECalendar1.Selection;
  for i := 1 to 31 do
    if i in c then s := s + IntToStr(i) + ' ';
  Label2.Caption := s;
end;

end.
