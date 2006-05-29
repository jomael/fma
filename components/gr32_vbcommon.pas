unit gr32_vbcommon;
{
    AltPE Common Library - Copyright 2004 Valentim Batista

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

    The author can be contacted at:
    Valentim Batista
    timsara@softhome.net
    http://timsara.zetafleet.com/
    http://www.geocities.com/gc_timsara/

    Requires:
     Graphics32 Library by Alex A. Denisov - http://g32.org/
}

interface

uses Windows, GR32, GR32_Filters;

const
  SQRT2 = 1.414213562;
  SQRTSQRT2 = 1.189207115;

type
  TARGB = record
    b: Byte;
    g: Byte;
    r: Byte;
    a: Byte;
  end;
  PARGB = ^TARGB;
  TArrayARGB = array[0..0] of TARGB;
  PArrayARGB = ^TArrayARGB;

  TRGB = record
    b: Byte;
    g: Byte;
    r: Byte;
  end;
  PRGB = ^TRGB;

  PLUT8 = ^TLUT8;

  TPolarPoint = record
    R, A: Extended;
  end;

function NormalizeCoord(p: TFloatPoint; w, h: Integer): TFloatPoint;
function UnNormalizeCoord(p: TFloatPoint; w, h: Integer): TFloatPoint;
function RectToPolar(rp: TFloatPoint): TPolarPoint;
function PolarToRect(pp: TPolarPoint): TFloatPoint;

function ByteConstrain(i: Integer): Integer;

procedure Bitmap32SetAs(bmDst, bmSrc: TBitmap32);
procedure Bitmap32Copy(bmDst, bmSrc: TBitmap32; complete: Boolean = False);
procedure Bitmap32StretchCopy(bmDst, bmSrc: TBitmap32; complete: Boolean = False);
procedure MergeBitmap32(bmDst, bmSrc: TBitmap32; alpha: Integer);
procedure MergeBitmap32At(bmDst: TBitmap32; xOffset, yOffset: Integer; bmSrc: TBitmap32; alpha: Integer);

function BitmapRect(bm: TBitmap32): TRect;
function BitmapFloatRect(bm: TBitmap32): TFloatRect;
function RectRound(frc: TFloatRect): TRect;
function ConstrainRectInRect(rcIn, rcOut: TFloatRect): TFloatRect;
function GetBitmapUsedRect(bm: Tbitmap32; bx, by: Integer): TRect;

implementation

uses Math, Classes, GR32_Transforms;

function NormalizeCoord(p: TFloatPoint; w, h: Integer): TFloatPoint;
begin
  result.X := (p.X * 2 - w) / w;
  result.Y := (p.Y * 2 - h) / h;
end;

function UnNormalizeCoord(p: TFloatPoint; w, h: Integer): TFloatPoint;
begin
  result.X := (p.X + 1) * w / 2;
  result.Y := (p.Y + 1) * h / 2;
end;

function RectToPolar(rp: TFloatPoint): TPolarPoint;
begin
  result.R := Hypot(rp.X, rp.Y);
  if rp.X <> 0 then result.A := ArcTan2(rp.Y, rp.X)
  else begin
    if rp.Y < 0 then result.A := -Pi / 2
    else result.A := Pi / 2;
  end;
end;

function PolarToRect(pp: TPolarPoint): TFloatPoint;
var
  sina, cosa: Extended;
begin
  SinCos(pp.A, sina, cosa);
  result.X := pp.R * cosa;
  result.Y := pp.R * sina;
end;

function ByteConstrain(i: Integer): Integer;
asm
//  MOV  EAX,i
  CMP  EAX,0    // EAX = i
  JL   @MOV00
  CMP  EAX,$FF
  JG   @MOVFF
  RET
@MOV00:
  MOV  EAX,0
  RET
@MOVFF:
  MOV  EAX,$FF
end;


///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////

procedure Bitmap32SetAs(bmDst, bmSrc: TBitmap32);
begin
  if Assigned(bmDst) and Assigned(bmSrc) then begin
    bmDst.SetSize(bmSrc.Width, bmSrc.Height);
    bmDst.DrawMode := bmSrc.DrawMode;
    bmDst.MasterAlpha := bmSrc.MasterAlpha;
    bmDst.OuterColor := bmSrc.OuterColor;
    bmDst.StretchFilter := bmSrc.StretchFilter;
  end;
end;

procedure Bitmap32Copy(bmDst, bmSrc: TBitmap32; complete: Boolean = False);
begin
  if Assigned(bmDst) and Assigned(bmSrc) then begin
    if (bmDst.Width<>bmSrc.Width) or (bmDst.Height<>bmSrc.Height) then bmDst.SetSize(bmSrc.Width, bmSrc.Height);
    if complete then begin
      bmDst.DrawMode := bmSrc.DrawMode;
      bmDst.MasterAlpha := bmSrc.MasterAlpha;
      bmDst.OuterColor := bmSrc.OuterColor;
      bmDst.StretchFilter := bmSrc.StretchFilter;
    end;
    if bmSrc.Empty then exit;
    BitBlt(bmDst.Handle, 0, 0, bmDst.Width, bmDst.Height, bmSrc.Handle, 0, 0, SRCCOPY);
  end;
end;

procedure Bitmap32StretchCopy(bmDst, bmSrc: TBitmap32; complete: Boolean = False);
begin
  if Assigned(bmDst) and Assigned(bmSrc) then begin
    if complete then begin
      bmDst.DrawMode := bmSrc.DrawMode;
      bmDst.MasterAlpha := bmSrc.MasterAlpha;
      bmDst.OuterColor := bmSrc.OuterColor;
      bmDst.StretchFilter := bmSrc.StretchFilter;
    end;
    if bmSrc.Empty then exit;
    StretchTransfer(bmDst, BitmapRect(bmDst), BitmapRect(bmDst), bmSrc, BitmapRect(bmSrc), sfLinear, dmOpaque, nil);
  end;
end;

procedure MergeBitmap32(bmDst, bmSrc: TBitmap32; alpha: Integer);
var
  aSrc: Integer;
begin
  if Assigned(bmDst) and Assigned(bmSrc) then begin
    if not bmDst.Empty and not bmSrc.Empty then begin
      aSrc := bmSrc.MasterAlpha;
      bmSrc.MasterAlpha := alpha;
      if (bmSrc.Width <> bmDst.Width) or (bmSrc.Height <> bmDst.Height) then
        StretchTransfer(bmDst, BitmapRect(bmDst), BitmapRect(bmDst), bmSrc, BitmapRect(bmSrc), sfLinear, dmBlend, nil)
      else BlockTransfer(bmDst, 0, 0, BitmapRect(bmDst), bmSrc, BitmapRect(bmSrc), dmBlend, nil);
      bmSrc.MasterAlpha := aSrc;
    end;
  end;
end;

procedure MergeBitmap32At(bmDst: TBitmap32; xOffset, yOffset: Integer; bmSrc: TBitmap32; alpha: Integer);
var
  aSrc: Integer;
begin
  if Assigned(bmDst) and Assigned(bmSrc) then begin
    if not bmDst.Empty and not bmSrc.Empty then begin
      aSrc := bmSrc.MasterAlpha;
      bmSrc.MasterAlpha := alpha;
      BlockTransfer(bmDst, xOffset, yOffset, BitmapRect(bmDst), bmSrc, BitmapRect(bmSrc), dmBlend, nil);
      bmSrc.MasterAlpha := aSrc;
    end;
  end;
end;

///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////

function BitmapRect(bm: TBitmap32): TRect;
begin
  result := Rect(0, 0, bm.Width, bm.Height);
end;

function BitmapFloatRect(bm: TBitmap32): TFloatRect;
begin
  result := FloatRect(0, 0, bm.Width, bm.Height);
end;

function RectRound(frc: TFloatRect): TRect;
begin
  result := Rect(Round(frc.Left), Round(frc.Top), Round(frc.Right), Round(frc.Bottom));
end;


function ConstrainRectInRect(rcIn, rcOut: TFloatRect): TFloatRect;
begin
  rcIn.Left := Min(Max(rcIn.Left, rcOut.Left), rcOut.Right - 1);
  rcIn.Top := Min(Max(rcIn.Top, rcOut.Top), rcOut.Bottom - 1);
  rcIn.Right := Max(Min(rcIn.Right, rcOut.Right), rcOut.Left + 1);
  rcIn.Bottom := Max(Min(rcIn.Bottom, rcOut.Bottom), rcOut.Top + 1);
  result := rcIn;
end;

///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////

function GetBitmapUsedRect(bm: Tbitmap32; bx, by: Integer): TRect;
var
  rcU: TRect;
  x, y: Integer;
begin
  rcU := Rect(bm.Width - 1, bm.Height - 1, 0, 0);
  for y := 0 to bm.Height - 1 do begin
    for x := 0 to bm.Width - 1 do begin
      if TARGB(bm.Pixel[x, y]).a <> 0 then begin
        if x < rcU.Left then rcU.Left := x;
        if y < rcU.Top then rcU.Top := y;
        if x > rcU.Right then rcU.Right := x;
        if y > rcU.Bottom then rcU.Bottom := y;
      end;
    end;
  end;
  rcU.Left := Max(0, rcU.Left - bx);
  rcU.Top := Max(0, rcU.Top - by);
  rcU.Right := Min(rcU.Right + bx, bm.Width - 1);
  rcU.Bottom := Min(rcU.Bottom + by, bm.Height - 1);
  result := rcU;
end;


end.

