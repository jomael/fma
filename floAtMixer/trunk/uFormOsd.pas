unit uFormOsd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFormOSD = class(TForm)
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure DoSetPosition;
  public
    { Public declarations }
    procedure SetOSD(Visible: boolean);
  end;

implementation

uses FormVolumeCtrl, FormVolume, FormOptions;

{$R *.dfm}

procedure TFormOSD.DoSetPosition;
begin
  if FormSettings.RadioButton1.Checked then begin
    Left := 4 + FormSettings.TrackBarPosX.Position;
    Top := 4 + FormSettings.TrackBarPosY.Position;
  end;
  if FormSettings.RadioButton2.Checked then begin
    Left := 4 + FormSettings.TrackBarPosX.Position;
    Top := Screen.Height - Height - 4 - FormSettings.TrackBarPosY.Position;
  end;
  if FormSettings.RadioButton3.Checked then begin
    Left := Screen.Width - Width - 4 - FormSettings.TrackBarPosX.Position;
    Top := Screen.Height - Height - 4 - FormSettings.TrackBarPosY.Position;
  end;
  if FormSettings.RadioButton4.Checked then begin
    Left := Screen.Width - Width - 4 - FormSettings.TrackBarPosX.Position;
    Top := 4 + FormSettings.TrackBarPosY.Position;
  end;
end;

procedure TFormOSD.FormCreate(Sender: TObject);
begin
  { Default position is Top-Left }
  Left := 4;
  Top := 4;
  TransparentColorValue := ColorToRGB(Color);
  TransparentColor := True;
  AutoSize := True;
end;

procedure TFormOSD.SetOSD(Visible: boolean);
const
  IsVisible: boolean = False;
begin
  if Visible then
    begin
      if FormSettings.cbShowOSD.Checked then begin
        DoSetPosition;
        if not IsVisible then begin
          TransparentColor := False;
          TransparentColorValue := ColorToRGB(Color);
          TransparentColor := True;
        end;
        if (FormVolumeBar = nil) or not FormVolumeBar.Visible then
          begin
            { Make current form topmost }
            if FormVolumeBar <> nil then FormVolumeDisp.FormStyle := fsNormal;
            FormStyle := fsStayOnTop;
          end;
        ShowWindow(Handle, SW_SHOWNOACTIVATE);
        IsVisible := True;
      end;
    end
  else
    begin
      ShowWindow(Handle, SW_HIDE);
      IsVisible := False;
      if (FormVolumeBar = nil) or not FormVolumeBar.Visible then
        begin
          { Restore main form topmost }
          FormStyle := fsNormal;
          if FormVolumeBar <> nil then FormVolumeDisp.FormStyle := fsStayOnTop;
        end;  
    end;
end;

end.
