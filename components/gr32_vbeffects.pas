unit gr32_vbeffects;
{
    AltPE Effects Library - Copyright 2004 Valentim Batista

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

procedure GrayBitmap(bm: TBitmap32; alpha: Integer = 255);

procedure ErodeImage(bm: TBitmap32; d: Integer; alpha: Integer = 255);
procedure DilateImage(bm: TBitmap32; d: Integer; alpha: Integer = 255);

procedure ApplyMosaic(bmDst, bmSrc: TBitmap32; d: Integer);

procedure ApplyHSLFactor(bmDst, bmSrc: TBitmap32; dh, ds, dl: Integer; r, g, b: Boolean);

procedure BitmapChannel(bm: TBitmap32; shift: Integer);

implementation

uses Math, GR32_Filters, GR32_Blend, gr32_vbcommon;

///////////////////////////////////////////////////////////////////////
//////////////// GrayBitmap ///////////////////////////////////////////
///////////////////////////////////////////////////////////////////////

procedure GrayBitmap(bm: TBitmap32; alpha: Integer = 255);
var
  i, n, y: Integer;
  c: TColor32;
begin
  TARGB(c).a := alpha;
  if Assigned(bm) then begin
    n := bm.Width * bm.Height - 1;
    for i := 0 to n do begin
      y := (TARGB(bm.Bits[i]).r * 61 + TARGB(bm.Bits[i]).g * 174 + TARGB(bm.Bits[i]).b * 21) shr 8;
      TARGB(c).r := y;
      TARGB(c).g := y;
      TARGB(c).b := y;
      bm.Bits[i] := BlendReg(c, bm.Bits[i]);
    end;
    bm.Changed;
  end;
  EMMS;
end;

///////////////////////////////////////////////////////////////////////
//////////////// Erode/Dilate /////////////////////////////////////////
///////////////////////////////////////////////////////////////////////

procedure ErodeImage(bm: TBitmap32; d: Integer; alpha: Integer = 255);
var
  x, y, i, j, w, h: Integer;
  x0, x1, y0, y1: Integer;
  c, m: TARGB;
  bmTmp: TBitmap32;
begin
  bmTmp := nil;
  try
    bmTmp := TBitmap32.Create;
    Bitmap32Copy(bmTmp, bm, True);
    w := bm.Width - 1;
    h := bm.Height - 1;
    for y := 0 to h do begin
      y0 := Max(0, y - d);
      y1 := Min(h, y + d);
      for x := 0 to w do begin
        x0 := Max(0, x - d);
        x1 := Min(w, x + d);
        c.a := alpha;
        c.r := 255;
        c.g := 255;
        c.b := 255;
        for j := y0 to y1 do begin
          for i := x0 to x1 do begin
            m := TARGB(bmTmp.PixelPtr[i, j]^);
            c.r := Min(c.r, m.r);
            c.g := Min(c.g, m.g);
            c.b := Min(c.b, m.b);
          end;
        end;
        BlendMem(TColor32(c), bm.PixelPtr[x, y]^);
      end;
    end;
  finally
    if Assigned(bmTmp) then bmTmp.Free;
    bm.Changed;
    EMMS;
  end;
end;

procedure DilateImage(bm: TBitmap32; d: Integer; alpha: Integer = 255);
var
  x, y, i, j, w, h: Integer;
  x0, x1, y0, y1: Integer;
  c, m: TARGB;
  bmTmp: TBitmap32;
begin
  bmTmp := nil;
  try
    bmTmp := TBitmap32.Create;
    Bitmap32Copy(bmTmp, bm, True);
    w := bm.Width-1;
    h := bm.Height-1;
    for y := 0 to h do begin
      y0 := Max(0, y - d);
      y1 := Min(h, y + d);
      for x := 0 to w do begin
        x0 := Max(0, x - d);
        x1 := Min(w, x + d);
        c.a := alpha;
        c.r := 0;
        c.g := 0;
        c.b := 0;
        for j := y0 to y1 do begin
          for i := x0 to x1 do begin
            m := TARGB(bmTmp.PixelPtr[i, j]^);
            c.r := Max(c.r, m.r);
            c.g := Max(c.g, m.g);
            c.b := Max(c.b, m.b);
          end;
        end;
        BlendMem(TColor32(c), bm.PixelPtr[x, y]^);
      end;
    end;
  finally
    if Assigned(bmTmp) then bmTmp.Free;
    bm.Changed;
    EMMS;
  end;
end;


///////////////////////////////////////////////////////////////////////
///////////////// Mosaic //////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////

procedure ApplyMosaic(bmDst, bmSrc: TBitmap32; d: Integer);
var
  x, y, i, j, w, q: Integer;
  a, r, g, b: Integer;
  lx, ly: Integer;
  bmTmp: TBitmap32;
begin
  w := d * 2 + 1;
  if Assigned(bmDst) and Assigned(bmSrc) then begin
    bmTmp := nil;
    try
      if bmDst = bmSrc then begin
        bmTmp := TBitmap32.Create;
        Bitmap32Copy(bmTmp, bmSrc, True);
      end
      else bmTmp := bmSrc;
      Bitmap32SetAs(bmDst, bmSrc); // force size and relevant configuration on dest as src
      lx := bmSrc.Width - 1;
      ly := bmSrc.Height - 1;
      y := d;
      while y < (bmSrc.Height + d) do begin
        x := d;
        while x < (bmSrc.Width + d) do begin // Walk pixels
          a := 0;
          r := 0;
          g := 0;
          b := 0;
          q := 0;
          for i := x - d to x + d do begin
            if i > lx then break;
            for j := y - d to y + d do begin
              if j > ly then break;
              a := a + PARGB(bmSrc.pixelptr[i, j])^.a;
              r := r + PARGB(bmSrc.pixelptr[i, j])^.r;
              g := g + PARGB(bmSrc.pixelptr[i, j])^.g;
              b := b + PARGB(bmSrc.pixelptr[i, j])^.b;
              Inc(q);
            end;
          end;
          if q = 0 then break;
          a := a div q;
          r := r div q;
          g := g div q;
          b := b div q;
          for i := x - d to x + d do begin
            if i > lx then break;
            for j := y - d to y + d do begin
              if j > ly then break;
              PARGB(bmDst.pixelptr[i, j])^.a := a;
              PARGB(bmDst.pixelptr[i, j])^.r := r;
              PARGB(bmDst.pixelptr[i, j])^.g := g;
              PARGB(bmDst.pixelptr[i, j])^.b := b;
            end;
          end;
          x := x + w;
        end;
        y := y + w;
      end;
      bmDst.Changed;
    finally
      if Assigned(bmTmp) and (bmSrc <> bmTmp) then bmTmp.Free;
    end;
  end;
end;

///////////////////////////////////////////////////////////////////////
////////// ApplyHSLFactor /////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////

procedure ApplyHSLFactor(bmDst, bmSrc: TBitmap32; dh, ds, dl: Integer; r, g, b: Boolean);
var
  i, n: Integer;
  H, S, L: Single;
  qh, qs, ql: Single;
  px: TARGB;
begin
  if Assigned(bmDst) and Assigned(bmSrc) then begin
    qh := (dh + 100) / 100;
    qs := (ds + 100) / 100;
    ql := (dl + 100) / 100;
    if bmDst <> bmSrc then bmDst.SetSize(bmSrc.Width, bmSrc.Height);
    n := bmSrc.Width * bmSrc.Height - 1;
    for i := 0 to n do begin
      bmDst.Bits[i] := bmSrc.Bits[i];
      RGBToHSL(bmDst.Bits[i], H, S, L);
      H := H * qh;
      if H > 1 then H := 1;
      S := S * qs;
      if S > 1 then S := 1;
      L := L * ql;
      if L > 1 then L := 1;
      px := TARGB(HSLToRGB(H, S, L));
      if r then TARGB(bmDst.Bits[i]).r := px.r;
      if g then TARGB(bmDst.Bits[i]).g := px.g;
      if b then TARGB(bmDst.Bits[i]).b := px.b;
    end;
    bmDst.Changed;
  end;
end;

///////////////////////////////////////////////////////////////////////
////////// BitmapChannel //////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////

procedure BitmapChannel(bm: TBitmap32; shift: Integer);
var
  i, n, v: Integer;
begin
  if Assigned(bm) then begin
    n := bm.Width * bm.Height - 1;
    for i := 0 to n do begin
      v := bm.Bits[i] shr shift and $FF;
      bm.Bits[i] := v shl 16 or v shl 8 or v or Integer(bm.Bits[i] and $FF000000);
    end;
    bm.Changed;
  end;
end;

end.

