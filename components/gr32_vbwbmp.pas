unit gr32_vbwbmp;
{
    AltPE WBMP (WAP Bitmap) Load/Save Library - Copyright 2004 Valentim Batista

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

procedure LoadBitmap32FromWBMP(fname: string; bm32: TBitmap32);
procedure SaveBitmap32ToWBMP(fname: string; bm32: TBitmap32);

implementation

uses SysUtils;

procedure LoadBitmap32FromWBMP(fname: string; bm32: TBitmap32);
var
  f: file;
  a: array[0..9215] of Byte;
  i, b, bp, px, h, w, l, y, x: Integer;
begin
  AssignFile(f, fname);
  Reset(f, 1);
  try
    BlockRead(f, a[0], sizeof(a), l);
    w := a[2];
    h := a[3];
    bm32.SetSize(w, h);
    i := 4;
    for y := 0 to h - 1 do begin
      bp := 0;
      for x := 0 to w - 1 do begin
        b := a[i];
        px := (b shr (7 - bp)) and 1;
        if px <> 0 then bm32.Pixel[x, y] := clWhite32
        else bm32.Pixel[x, y] := clBlack32;
        Inc(bp);
        if bp = 8 then begin
          a[i] := b;
          Inc(i);
          bp := 0;
        end;
      end;
      if bp > 0 then begin
        Inc(i);
      end;
    end;
  finally
    CloseFile(f);
  end;
  bm32.ResetAlpha;
end;

procedure SaveBitmap32ToWBMP(fname: string; bm32: TBitmap32);
var
  f: file;
  a: array of Byte;
  i, b, bp, px, h, w, l, y, x: Integer;
begin
  h := bm32.Height;
  w := bm32.Width;
  if (h > 255) or (w > 255) then exit;
  AssignFile(f, fname);
  Rewrite(f, 1);
  try
    l := Trunc((w + 7) / 8) * h + 4;
    SetLength(a, l);
    a[0] := Byte(#0);
    a[1] := Byte(#0);
    a[2] := w;
    a[3] := h;
    i := 4;
    for y := 0 to h - 1 do begin
      b := 0;
      bp := 0;
      for x := 0 to w - 1 do begin
        if Intensity(bm32.Pixel[x, y]) < 127 then px := 0
        else px := 1;
        b := b or (px shl (7 - bp));
        Inc(bp);
        if bp = 8 then begin
          a[i] := b;
          Inc(i);
          b := 0;
          bp := 0;
        end;
      end;
      if bp > 0 then begin
        a[i] := b;
        Inc(i);
      end;
    end;
    BlockWrite(f, a[0], i, l);
  finally
    SetLength(a, 0);
    CloseFile(f);
  end;
end;

end.

