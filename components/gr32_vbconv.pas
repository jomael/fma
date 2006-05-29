unit gr32_vbconv;
{
    AltPE Convolution Library - Copyright 2004 Valentim Batista

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

uses GR32;

procedure ConvolveSmall32(v: array of integer; d: Integer; bm: TBitmap32);
procedure ConvolveBig32(v: array of integer; d: Integer; bm: TBitmap32);

procedure ApplyUnsharpMask(bmDst, bmSrc: TBitmap32; Q: Single);

procedure ApplyContour(bmDst, bmSrc: TBitmap32; mh, mv: array of Integer; dh, dv: Integer; Q: Single);
procedure ApplySobel(bmDst, bmSrc: TBitmap32; Q: Single);
procedure ApplyPrewitt(bmDst, bmSrc: TBitmap32; Q: Single);

implementation

uses gr32_vbcommon;

// FILTER:            d, v
// BLUR:             12, [1, 1, 1, 1, 4, 1, 1, 1, 1]
// BLURMORE:         10, [1, 1, 1, 1, 2, 1, 1, 1, 1]
// BLURGAUSSIAN:     16, [1, 2, 1, 2, 4, 2, 1, 2, 1]
// MOTIONBLUR:        3, [0, 0, 0, 1, 1, 1, 0, 0, 0]
// SOFTEN:           16, [2, 2, 2, 2, 0, 2, 2, 2, 2]
// SOFTENMORE:       25, [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
// SHARPEN:           8, [0, -1, 0, -1, 12, -1, 0, -1, 0]
// SHARPENMORE:       1, [1, -2, 1, -2, 5, -2, 1, -2, 1]
// ENHANCE:           1, [0, -1, 0, -1, 5, -1, 0, -1, 0]
// ENHANCEMORE:       1, [-1, -1, -1, -1, 9, -1, -1, -1, -1]
// LAPLACE1:          1, [0, -1, 0, -1, 4, -1, 0, -1, 0]
// LAPLACE2:          1, [1, -2, 1, -2, 4, -2, 1, -2, 1]
// GLOW:              8, [1, 2, 2, 2, 1, 2, 0, 0, 0, 2, 2, 0, -20, 0, 2, 2, 0, 0, 0, 2, 1, 2, 2, 2, 1]
// PATTERN:           1, [0, -4, -9, -4, 0, -4, -24, -1, -24, -4, -9, -1, 168, -1, -9, -4, -24, -1, -24, -4, 0, -4, -9, -4, 0]
// FINDVERTICAL       1, [-1, 1, 1, -1, -2, 1, -1, 1, 1]
// FINDHORIZONTAL:    1, [1, 1, 1, 1, -2, 1, -1, -1, -1]
// VERTICALSOBEL:     1, [1, 0, -1, 2, 0, -2, 1, 0, -1]
// HORIZONTALSOBEL    1, [1, 2, 1, 0, 0, 0, -1, -2, -1]
// VERTICALPREWITT    1, [1, 0, -1, 1, 0, -1, 1, 0, -1]
// HORIZONTALPREWITT  1, [-1, -1, -1, 0, 0, 0, 1, 1, 1]
// EMBOSS             6, [-6, 0, 0, 0, 0, 0, -7, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 6]
// EMBOSSMORE         1, [-6, 0, 0, 0, 0, 0, -7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 6]

procedure ConvolveSmall32(v: array of integer; d: Integer; bm: TBitmap32); overload;
var
  O, T, C, B: PColor32Array; // Scanlines
  x, y: Integer;
  bmTmp: TBitmap32; // temp bitmap
begin
  bmTmp := nil;
  try
    bmTmp := TBitmap32.Create;
    Bitmap32Copy(bmTmp, bm, True);
    for y := 1 to bm.Height - 2 do begin
      O := bm.ScanLine[y]; // New Target (Original)
      T := bmTmp.ScanLine[y - 1]; //old x-1  (Top)
      C := bmTmp.ScanLine[y]; //old x    (Center)
      B := bmTmp.ScanLine[y + 1]; //old x+1  (Bottom)
      case d of
        1: for x := 1 to (bm.Width - 2) do begin // Walk pixels
            TARGB(O[x]).r := ByteConstrain(
              (TARGB(T[x - 1]).r * v[0]) + (TARGB(T[x]).r * v[1]) + (TARGB(T[x + 1]).r * v[2]) +
              (TARGB(C[x - 1]).r * v[3]) + (TARGB(C[x]).r * v[4]) + (TARGB(C[x + 1]).r * v[5]) +
              (TARGB(B[x - 1]).r * v[6]) + (TARGB(B[x]).r * v[7]) + (TARGB(B[x + 1]).r * v[8])
              );
            TARGB(O[x]).g := ByteConstrain(
              (TARGB(T[x - 1]).g * v[0]) + (TARGB(T[x]).g * v[1]) + (TARGB(T[x + 1]).g * v[2]) +
              (TARGB(C[x - 1]).g * v[3]) + (TARGB(C[x]).g * v[4]) + (TARGB(C[x + 1]).g * v[5]) +
              (TARGB(B[x - 1]).g * v[6]) + (TARGB(B[x]).g * v[7]) + (TARGB(B[x + 1]).g * v[8])
              );
            TARGB(O[x]).b := ByteConstrain(
              (TARGB(T[x - 1]).b * v[0]) + (TARGB(T[x]).b * v[1]) + (TARGB(T[x + 1]).b * v[2]) +
              (TARGB(C[x - 1]).b * v[3]) + (TARGB(C[x]).b * v[4]) + (TARGB(C[x + 1]).b * v[5]) +
              (TARGB(B[x - 1]).b * v[6]) + (TARGB(B[x]).b * v[7]) + (TARGB(B[x + 1]).b * v[8])
              );
          end;
      else
        for x := 1 to (bm.Width - 2) do begin // Walk pixels
          TARGB(O[x]).r := ByteConstrain((
            (TARGB(T[x - 1]).r * v[0]) + (TARGB(T[x]).r * v[1]) + (TARGB(T[x + 1]).r * v[2]) +
            (TARGB(C[x - 1]).r * v[3]) + (TARGB(C[x]).r * v[4]) + (TARGB(C[x + 1]).r * v[5]) +
            (TARGB(B[x - 1]).r * v[6]) + (TARGB(B[x]).r * v[7]) + (TARGB(B[x + 1]).r * v[8])
            ) div d);
          TARGB(O[x]).g := ByteConstrain((
            (TARGB(T[x - 1]).g * v[0]) + (TARGB(T[x]).g * v[1]) + (TARGB(T[x + 1]).g * v[2]) +
            (TARGB(C[x - 1]).g * v[3]) + (TARGB(C[x]).g * v[4]) + (TARGB(C[x + 1]).g * v[5]) +
            (TARGB(B[x - 1]).g * v[6]) + (TARGB(B[x]).g * v[7]) + (TARGB(B[x + 1]).g * v[8])
            ) div d);
          TARGB(O[x]).b := ByteConstrain((
            (TARGB(T[x - 1]).b * v[0]) + (TARGB(T[x]).b * v[1]) + (TARGB(T[x + 1]).b * v[2]) +
            (TARGB(C[x - 1]).b * v[3]) + (TARGB(C[x]).b * v[4]) + (TARGB(C[x + 1]).b * v[5]) +
            (TARGB(B[x - 1]).b * v[6]) + (TARGB(B[x]).b * v[7]) + (TARGB(B[x + 1]).b * v[8])
            ) div d);
        end;
      end;
    end;
  finally
    if Assigned(bmTmp) then bmTmp.Free;
  end;
end;

procedure ConvolveBig32(v: array of integer; d: Integer; bm: TBitmap32);
var
  O, T2, T, C, B, B2: PColor32Array; // Scanlines
  x, y: Integer;
  bmTmp: TBitmap32; // temp bitmap
begin
  bmTmp := nil;
  try
    bmTmp := TBitmap32.Create;
    Bitmap32Copy(bmTmp, bm, True);
    for y := 2 to bm.Height - 3 do begin
      O := bm.ScanLine[y]; // New Target (Original)
      T2 := bmTmp.ScanLine[y - 2]; //old x-2  (Top)
      T := bmTmp.ScanLine[y - 1]; //old x-1  (Top)
      C := bmTmp.ScanLine[y]; //old x    (Center)
      B := bmTmp.ScanLine[y + 1]; //old x+1  (Bottom)
      B2 := bmTmp.ScanLine[y + 2]; //old x+2  (Bottom)
      for x := 2 to (bm.Width - 3) do begin // Walk pixels
        TARGB(O[x]).r := ByteConstrain((
          TARGB(T2[x - 2]).r * v[0] + TARGB(T2[x - 1]).r * v[1] + TARGB(T2[x]).r * v[2] + TARGB(T2[x + 1]).r * v[3] + TARGB(T2[x + 2]).r * v[4] +
          TARGB(T[x - 2]).r * v[5] + TARGB(T[x - 1]).r * v[6] + TARGB(T[x]).r * v[7] + TARGB(T[x + 1]).r * v[8] + TARGB(T[x + 2]).r * v[9] +
          TARGB(C[x - 2]).r * v[10] + TARGB(C[x - 1]).r * v[11] + TARGB(C[x]).r * v[12] + TARGB(C[x + 1]).r * v[13] + TARGB(C[x + 2]).r * v[14] +
          TARGB(B[x - 2]).r * v[15] + TARGB(B[x - 1]).r * v[16] + TARGB(B[x]).r * v[17] + TARGB(B[x + 1]).r * v[18] + TARGB(B[x + 2]).r * v[19] +
          TARGB(B2[x - 2]).r * v[20] + TARGB(B2[x - 1]).r * v[21] + TARGB(B2[x]).r * v[22] + TARGB(B2[x + 1]).r * v[23] + TARGB(B2[x + 2]).r * v[24]
          ) div d);
        TARGB(O[x]).g := ByteConstrain((
          TARGB(T2[x - 2]).g * v[0] + TARGB(T2[x - 1]).g * v[1] + TARGB(T2[x]).g * v[2] + TARGB(T2[x + 1]).g * v[3] + TARGB(T2[x + 2]).g * v[4] +
          TARGB(T[x - 2]).g * v[5] + TARGB(T[x - 1]).g * v[6] + TARGB(T[x]).g * v[7] + TARGB(T[x + 1]).g * v[8] + TARGB(T[x + 2]).g * v[9] +
          TARGB(C[x - 2]).g * v[10] + TARGB(C[x - 1]).g * v[11] + TARGB(C[x]).g * v[12] + TARGB(C[x + 1]).g * v[13] + TARGB(C[x + 2]).g * v[14] +
          TARGB(B[x - 2]).g * v[15] + TARGB(B[x - 1]).g * v[16] + TARGB(B[x]).g * v[17] + TARGB(B[x + 1]).g * v[18] + TARGB(B[x + 2]).g * v[19] +
          TARGB(B2[x - 2]).g * v[20] + TARGB(B2[x - 1]).g * v[21] + TARGB(B2[x]).g * v[22] + TARGB(B2[x + 1]).g * v[23] + TARGB(B2[x + 2]).g * v[24]
          ) div d);
        TARGB(O[x]).b := ByteConstrain((
          TARGB(T2[x - 2]).b * v[0] + TARGB(T2[x - 1]).b * v[1] + TARGB(T2[x]).b * v[2] + TARGB(T2[x + 1]).b * v[3] + TARGB(T2[x + 2]).b * v[4] +
          TARGB(T[x - 2]).b * v[5] + TARGB(T[x - 1]).b * v[6] + TARGB(T[x]).b * v[7] + TARGB(T[x + 1]).b * v[8] + TARGB(T[x + 2]).b * v[9] +
          TARGB(C[x - 2]).b * v[10] + TARGB(C[x - 1]).b * v[11] + TARGB(C[x]).b * v[12] + TARGB(C[x + 1]).b * v[13] + TARGB(C[x + 2]).b * v[14] +
          TARGB(B[x - 2]).b * v[15] + TARGB(B[x - 1]).b * v[16] + TARGB(B[x]).b * v[17] + TARGB(B[x + 1]).b * v[18] + TARGB(B[x + 2]).b * v[19] +
          TARGB(B2[x - 2]).b * v[20] + TARGB(B2[x - 1]).b * v[21] + TARGB(B2[x]).b * v[22] + TARGB(B2[x + 1]).b * v[23] + TARGB(B2[x + 2]).b * v[24]
          ) div d);
      end;
    end;
  finally
    if Assigned(bmTmp) then bmTmp.Free;
  end;
end;

///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////

procedure ApplyUnsharpMask(bmDst, bmSrc: TBitmap32; Q: Single);
var
  bmTmp: TBitmap32;
  i, n: Integer;
begin
  if Assigned(bmDst) and Assigned(bmSrc) then begin
    bmTmp := nil;
    try
      bmTmp := TBitmap32.Create;
      Bitmap32Copy(bmTmp, bmSrc, True);
      ConvolveSmall32([1, 2, 1, 2, 4, 2, 1, 2, 1], 16, bmTmp); // gauss
      if bmDst <> bmSrc then bmDst.SetSize(bmSrc.Width, bmSrc.Height);
      n := bmSrc.Width * bmSrc.Height - 1;
      for i := 0 to n do begin
        TARGB(bmDst.bits[i]).a := TARGB(bmSrc.bits[i]).a;
        TARGB(bmDst.bits[i]).r := ByteConstrain(TARGB(bmSrc.bits[i]).r +
          Trunc(Q * (TARGB(bmSrc.bits[i]).r - TARGB(bmTmp.bits[i]).r)));
        TARGB(bmDst.bits[i]).g := ByteConstrain(TARGB(bmSrc.bits[i]).g +
          Trunc(Q * (TARGB(bmSrc.bits[i]).g - TARGB(bmTmp.bits[i]).g)));
        TARGB(bmDst.bits[i]).b := ByteConstrain(TARGB(bmSrc.bits[i]).b +
          Trunc(Q * (TARGB(bmSrc.bits[i]).b - TARGB(bmTmp.bits[i]).b)));
      end;
      bmDst.Changed;
    finally
      if Assigned(bmTmp) then bmTmp.Free;
    end;
  end;
end;

///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////

procedure ApplyContour(bmDst, bmSrc: TBitmap32; mh, mv: array of Integer; dh, dv: Integer; Q: Single);
var
  bmTmp1, bmTmp2: TBitmap32;
  i, n, o, e: Integer;
begin
  e := Trunc(255 * Q);
  o := 255 - e;
  if Assigned(bmDst) and Assigned(bmSrc) then begin
    bmTmp1 := nil;
    bmTmp2 := nil;
    try
      bmTmp1 := TBitmap32.Create;
      Bitmap32Copy(bmTmp1, bmSrc, True);
      ConvolveSmall32(mh, dh, bmTmp1);
      bmTmp2 := TBitmap32.Create;
      Bitmap32Copy(bmTmp2, bmSrc, True);
      ConvolveSmall32(mv, dv, bmTmp2);
      if bmDst <> bmSrc then bmDst.SetSize(bmSrc.Width, bmSrc.Height);
      n := bmSrc.Width * bmSrc.Height - 1;
      for i := 0 to n do begin
        TARGB(bmDst.bits[i]).a := TARGB(bmSrc.bits[i]).a;
        TARGB(bmDst.bits[i]).r := (o * TARGB(bmSrc.bits[i]).r +
          e * ByteConstrain(Trunc(Sqrt(
          (TARGB(bmTmp1.bits[i]).r * TARGB(bmTmp1.bits[i]).r) +
          (TARGB(bmTmp2.bits[i]).r * TARGB(bmTmp2.bits[i]).r))))) shr 8;
        TARGB(bmDst.bits[i]).g := (o * TARGB(bmSrc.bits[i]).g +
          e * ByteConstrain(Trunc(Sqrt(
          (TARGB(bmTmp1.bits[i]).g * TARGB(bmTmp1.bits[i]).g) +
          (TARGB(bmTmp2.bits[i]).g * TARGB(bmTmp2.bits[i]).g))))) shr 8;
        TARGB(bmDst.bits[i]).b := (o * TARGB(bmSrc.bits[i]).b +
          e * ByteConstrain(Trunc(Sqrt(
          (TARGB(bmTmp1.bits[i]).b * TARGB(bmTmp1.bits[i]).b) +
          (TARGB(bmTmp2.bits[i]).b * TARGB(bmTmp2.bits[i]).b))))) shr 8;
      end;
      bmDst.Changed;
    finally
      if Assigned(bmTmp1) then bmTmp1.Free;
      if Assigned(bmTmp2) then bmTmp2.Free;
    end;
  end;
end;

procedure ApplySobel(bmDst, bmSrc: TBitmap32; Q: Single);
begin
  ApplyContour(bmDst, bmSrc, [1, 2, 1, 0, 0, 0, -1, -2, -1], [1, 0, -1, 2, 0, -2, 1, 0, -1], 1, 1, Q);
end;

procedure ApplyPrewitt(bmDst, bmSrc: TBitmap32; Q: Single);
begin
  ApplyContour(bmDst, bmSrc, [-1, -1, -1, 0, 0, 0, 1, 1, 1], [1, 0, -1, 1, 0, -1, 1, 0, -1], 1, 1, Q);
end;

end.
