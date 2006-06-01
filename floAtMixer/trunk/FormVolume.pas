unit FormVolume;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

type
  TFormVolumeBar = class(TForm)
    Panel1: TPanel;
    TrackBar1: TTrackBar;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure EscKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
    AX,AY,PrevX,PrevY: integer;
    MouseMove: boolean;
  public
    { Public declarations }
    procedure ShowAt(X,Y: integer);
  end;

var
  FormVolumeBar: TFormVolumeBar;

implementation

uses
  FormVolumeCtrl;

{$R *.dfm}

procedure TFormVolumeBar.FormCreate(Sender: TObject);
begin
  Width := Label1.Width + Label1.Left*2;
end;

procedure TFormVolumeBar.FormShow(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_Hide);
  CheckBox1.Checked := FormVolumeDisp.GetMute;
  TrackBar1.Position := TrackBar1.Max - FormVolumeDisp.GetVolume;
  BringToFront;
end;

procedure TFormVolumeBar.TrackBar1Change(Sender: TObject);
begin
  FormVolumeDisp.SetVolume(TrackBar1.Max - TrackBar1.Position);
end;

procedure TFormVolumeBar.CheckBox1Click(Sender: TObject);
begin
  FormVolumeDisp.SetMute(CheckBox1.Checked);
end;  

procedure TFormVolumeBar.EscKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then Hide;
end;

procedure TFormVolumeBar.ShowAt(X, Y: integer);
begin
  Left := X;
  Top := Y;
  if (Left + Width) > Screen.Width then Left := Left - Width;
  if (Top + Height) > Screen.Height then Top := Top - Height;
  { Move main form OnTop to this form, since only
    one form at a time can have a such setting. }
  FormVolumeDisp.OSD.FormStyle := fsNormal;
  FormVolumeDisp.FormStyle := fsNormal;
  FormStyle := fsStayOnTop;
  Show;
end;

procedure TFormVolumeBar.FormHide(Sender: TObject);
begin
  { Restore main form as OnTop }
  FormStyle := fsNormal;
  FormVolumeDisp.OSD.FormStyle := fsNormal;
  FormVolumeDisp.FormStyle := fsStayOnTop;
end;

procedure TFormVolumeBar.Panel1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  AX := Left; AY := Top;
  PrevX := X; PrevY := Y;
  MouseMove := True;
  TMouseControl(Sender).MouseCapture := True;
end;

procedure TFormVolumeBar.Panel1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  DX,DY: integer;
  procedure MoveDef;
  begin
    Left := Left + X - PrevX;
    Top := Top + Y - PrevY;
  end;
begin
  if MouseMove and ((X <> PrevX) or (Y <> PrevY)) then
    try
      MouseMove := False;
      if ssShift in Shift then
        begin
          DX := Abs(AX - Left - X + PrevX);
          DY := Abs(AY - Top - Y + PrevY);
          if (DX < 150) or (DY < 150) then
            if DX < DY then
              begin
                Left := AX;
                Top := Top + Y - PrevY;
              end
            else
              begin
                Top := AY;
                Left := Left + X - PrevX;
              end
          else
            MoveDef;
        end
      else
        MoveDef;
    finally
      MouseMove := True;
    end;
end;

procedure TFormVolumeBar.Panel1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  TMouseControl(Sender).MouseCapture := False;
  MouseMove := False;
end;

end.

