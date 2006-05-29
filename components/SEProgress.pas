unit SEProgress;

{
*******************************************************************************
* Descriptions: Sony Ericsson progress bar
* $Source: /cvsroot/fma/fma/components/SEProgress.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: SEProgress.pas,v $
* Revision 1.6.2.2  2005/10/04 09:44:27  expertone
* Added RightToLeft locales support
*
* Revision 1.6.2.1  2005/09/06 08:11:12  z_stoichev
* Added Unknown Max Width property.
*
* Revision 1.6  2005/03/01 11:29:14  z_stoichev
* Add components to FMA pallete.
*
* Revision 1.5  2004/06/05 13:30:28  lordlarry
* Merged with OutlookSync branch
*
* Revision 1.4  2004/03/07 10:57:43  z_stoichev
* Undo delete SEProgress
* Added WebUpdate resource.
*
* Revision 1.2  2003/12/04 16:21:33  z_stoichev
* removed abort call
*
*
}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, ExtCtrls, Graphics;

type
  TSEProgress = class(TCustomPanel)
  private
    FShowBorder: boolean;
    FBarColor: TColor;
    FPosition: integer;
    FMax: integer;
    FMin: integer;
    FFrame: integer;
    FUnknownMax: boolean;
    FUnknownWidth: integer;
    procedure Set_ShowBorder(const Value: boolean);
    procedure Set_Bar(const Index: Integer; const Value: integer);
    procedure Set_Color(const Index: Integer; const Value: TColor);
    procedure Set_UnknownMax(const Value: boolean);
    { Private declarations }
  protected
    { Protected declarations }
    FShortBarW: integer;
    procedure Paint; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure StepForward;
  published
    { Published declarations }
    property Color;
    property BevelOuter;
    property BiDiMode;
    property ParentBiDiMode;
    property Position: integer index 1 read FPosition write Set_Bar;
    property Max: integer index 2 read FMax write Set_Bar;
    property Min: integer index 3 read FMin write Set_Bar;
    property Frame: integer index 4 read FFrame write Set_Bar;
    property ShowBorder: boolean read FShowBorder write Set_ShowBorder;
    property UnknownMax: boolean read FUnknownMax write Set_UnknownMax;
    property UnknownWidth: integer index 5 read FUnknownWidth write Set_Bar;
    property BarColor: TColor index 1 read FBarColor write Set_Color;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('FMA', [TSEProgress]);
end;

{ TSEProgress }

constructor TSEProgress.Create(AOwner: TComponent);
begin
  inherited;
  Width := 150;
  Height := 18;
  FMax := 100;
  FFrame := 2;
  FBarColor := clHighlight;
  FUnknownMax := true;
  FShowBorder := true;
  BevelOuter := bvLowered;
end;

procedure TSEProgress.Paint;
var
  Rect, CRect: TRect;
  DrawBuffer: TBitmap;
  i: integer;
  TopColor, BottomColor: TColor;
  procedure AdjustColors(Bevel: TPanelBevel);
  begin
    TopColor := clBtnHighlight;
    if Bevel = bvLowered then TopColor := clBtnShadow;
    BottomColor := clBtnShadow;
    if Bevel = bvLowered then BottomColor := clBtnHighlight;
  end;
begin
  Rect := GetClientRect;
  DrawBuffer := TBitmap.Create;
  try
    DrawBuffer.Width := Width;
    DrawBuffer.Height := Height;
    with DrawBuffer.Canvas do
      begin
        Brush.Color := Color;
        FillRect(Rect);
      end;
    if FShowBorder then
      begin
        if BevelOuter <> bvNone then
          begin
            AdjustColors(BevelOuter);
            Frame3D(DrawBuffer.Canvas, Rect, TopColor, BottomColor, BevelWidth);
          end;
      end;
    Frame3D(DrawBuffer.Canvas, Rect, Color, Color, BorderWidth);
    {
    if FShowBorder then
      begin
        if BevelInner <> bvNone then
          begin
            AdjustColors(BevelInner);
            Frame3D(DrawBuffer.Canvas, Rect, TopColor, BottomColor, BevelWidth);
          end;
      end;
    }
    if (FPosition <> FMin) and (FMax <> FMin) then
      try
        if FUnknownWidth = 0 then
          FShortBarW := Round(Width / 6)
        else
          FShortBarW := FUnknownWidth;
        if FFrame <> 0 then
          Frame3D(DrawBuffer.Canvas, Rect, Color, Color, FFrame);
        CRect := Rect;
        i := Round((Rect.Right-Rect.Left)*((1+FPosition-FMin)/(1+FMax-FMin)));
        if (FPosition <> FMin) and (i < 3) then i := 3;
        with CRect do begin
          Right := Left + i;
          if FUnknownMax then
            begin
              Right := Right + Round((FShortBarW)*((1+FPosition-FMin)/(1+FMax-FMin)));
              if Right > Left + FShortBarW then Left := Right - FShortBarW;
              if Right > Rect.Right then Right := Rect.Right;
              if (Left > Rect.Left) and ((Right-Left) < 2) then exit;
            end;
        end;
        if IsRightToLeft then
          with CRect do begin
            i := Right;
            Right := Rect.Right - Left;
            Left := Rect.Left + Rect.Right - i;
          end;
        Frame3D(DrawBuffer.Canvas, CRect, Color, Color, BevelWidth);
        with DrawBuffer.Canvas do
          begin
            Brush.Color := FBarColor;
            FillRect(CRect);
          end;
      except;
      end;
    Canvas.CopyRect(ClientRect,DrawBuffer.Canvas,ClientRect);
  finally
    DrawBuffer.Free;
  end;
end;

procedure TSEProgress.Set_Bar(const Index: Integer; const Value: integer);
{$WRITEABLECONST ON}
const
  LastPos: integer = -1;
{$WRITEABLECONST OFF}
var
  i: integer;
begin
  case Index of
    1: FPosition := Value;
    2: begin
         FMax := Value;
         FUnknownMax := False;
       end;
    3: FMin := Value;
    4: begin
         FFrame := Value;
         Paint;
         exit;
       end;
    5: begin
         FUnknownWidth := Value;
         Paint;
       end;
  end;
  if FMax < FMin then FMax := FMin;
  if FPosition > FMax then FPosition := FMax;
  if FPosition < FMin then FPosition := FMin;
  if FMax = FMin then i := 0
    else i := Round(Width*((FPosition-FMin)/(FMax-FMin)));
  if i <> LastPos then
    begin
      LastPos := i;
      Paint;
    end;
end;

procedure TSEProgress.Set_Color(const Index: Integer; const Value: TColor);
begin
  FBarColor := Value;
  Paint;
end;

procedure TSEProgress.Set_ShowBorder(const Value: boolean);
begin
  FShowBorder := Value;
  Paint;
end;

procedure TSEProgress.Set_UnknownMax(const Value: boolean);
begin
  FUnknownMax := Value;
  if FUnknownMax then FMax := FMin + Width;
  Paint;
end;

procedure TSEProgress.StepForward;
begin
  if FUnknownMax and (FPosition >= FMax) then FPosition := Fmin
    else Position := Position + 1;
end;

end.
