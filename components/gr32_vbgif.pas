unit gr32_vbgif;
{
    AltPE GIF Load/Save Library - Copyright 2004 Valentim Batista

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
     TGIFImage 2.2 by Anders Melander - http://www.melander.dk/delphi/gifimage/
}

interface

uses GR32, Graphics;

procedure LoadBitmap32FromGIF(fname: string; bm32: TBitmap32);
procedure SaveBitmap32ToGIF(fname: string; bm32: TBitmap32; dither: Boolean);

implementation

uses GIFImage;

procedure LoadBitmap32FromGIF(fname: string; bm32: TBitmap32);
var
  gif: TGIFImage;
  bm: TBitmap;
begin
  bm := nil;
  gif := nil;
  try
    gif := TGIFImage.Create;
    gif.LoadFromFile(fname);
    bm := TBitmap.Create;
    bm.Assign(gif.Bitmap);
    bm32.Assign(bm);
    bm32.ResetAlpha;
  finally
    if Assigned(bm) then bm.Free;
    if Assigned(gif) then gif.Free;
  end
end;

procedure SaveBitmap32ToGIF(fname: string; bm32: TBitmap32; dither: Boolean);
var
  bm: TBitmap;
  gif: TGIFImage;
begin
  bm := nil;
  gif := nil;
  try
    bm := TBitmap.Create;
    gif := TGIFImage.Create;
    bm.Assign(bm32);
    gif.Compression := gcRLE; // No LZW compression used here !!!
    if dither then gif.DitherMode := dmFloydSteinberg;
    gif.Assign(bm); //Convert data into gif
    gif.SaveToFile(fname);
  finally
    if Assigned(bm) then bm.Free;
    if Assigned(gif) then gif.Free;
  end
end;

end.

