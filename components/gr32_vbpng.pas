unit gr32_vbpng;
{
    AltPE PNG Load/Save Library - Copyright 2004 Valentim Batista

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
     TPNGImage 1.4 by Gustavo Daud - http://pngdelphi.sourceforge.net/
}

interface

uses GR32, Graphics;

procedure LoadBitmap32FromPNG(fname: string; bm32: TBitmap32);
procedure SaveBitmap32ToPNG(fname: string; bm32: TBitmap32; paletted, transparent: Boolean; bgcolor: TColor; compression:Integer = 9);

implementation

uses PNGImage, gr32_vbcommon;

procedure LoadBitmap32FromPNG(fname: string; bm32: TBitmap32);
var
  png: TPngObject;
  tc: TColor32;
  x, y: Integer;
  bm: TBitmap;
  p: PByteArray;
begin
  bm := nil;
  png := nil;
  try
    png := TPngObject.Create;
    png.LoadFromFile(fname);
    bm := TBitmap.Create;
    bm.Assign(png);
    bm32.Assign(bm);
    bm32.ResetAlpha;
    case png.TransparencyMode of
      ptmBit: begin
          tc := Color32(png.TransparentColor);
          for y := 0 to bm32.Height - 1 do
            for x := 0 to bm32.Width - 1 do
              if bm32.Pixel[x, y] = tc then PARGB(bm32.PixelPtr[x, y])^.a := 0;
        end;
      ptmPartial: begin
          if (png.Header.ColorType = COLOR_GRAYSCALEALPHA) or
            (png.Header.ColorType = COLOR_RGBALPHA) then begin
            for y := 0 to bm32.Height - 1 do begin
              p := png.AlphaScanline[y];
              for x := 0 to bm32.Width - 1 do
                PARGB(bm32.PixelPtr[x, y])^.a := p[x];
            end;
          end;
        end;
    end;
  finally
    if Assigned(bm) then bm.Free;
    if Assigned(png) then png.Free;
  end
end;

procedure SaveBitmap32ToPNG(fname: string; bm32: TBitmap32; paletted, transparent: Boolean; bgcolor: TColor; compression:Integer = 9);
var
  bm: TBitmap;
  png: TPngObject;
  TRNS: TCHUNKtRNS;
  p: PByteArray;
  x, y: Integer;
begin
  bm := nil;
  png := nil;
  try
    bm := TBitmap.Create;
    png := TPngObject.Create;
    bm.Assign(bm32);
    if paletted then bm.PixelFormat := pf8bit; // force paletted on TBitmap, transparent for the web must be 8bit
    png.InterlaceMethod := imNone;
    png.CompressionLevel := compression;
    png.Assign(bm); //Convert data into png
    if transparent then begin
      if png.Header.ColorType in [COLOR_PALETTE] then begin
        if (png.Chunks.ItemFromClass(TChunktRNS) = nil) then png.CreateAlpha();
        TRNS := png.Chunks.ItemFromClass(TChunktRNS) as TChunktRNS;
        if Assigned(TRNS) then TRNS.TransparentColor := bgcolor;
      end;
      if png.Header.ColorType in [COLOR_RGB, COLOR_GRAYSCALE] then png.CreateAlpha();
      if png.Header.ColorType in [COLOR_RGBALPHA, COLOR_GRAYSCALEALPHA] then begin
        for y := 0 to png.Header.Height - 1 do begin
          p := png.AlphaScanline[y];
          for x := 0 to png.Header.Width - 1 do p[x] := TARGB(bm32.Pixel[x,y]).a;
        end;
      end;
    end;
    png.SaveToFile(fname);
  finally
    if Assigned(bm) then bm.Free;
    if Assigned(png) then png.Free;
  end
end;

end.

