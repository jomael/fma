unit gr32_vbj2k;
{
    AltPE JPEG 2000 Load/Save Library - Copyright 2004 Valentim Batista

    Registers JPEG 2000 with TPicture

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

    Code parts were converted (for using with Graphics32 Library) from:
    ImageFileLib 1.14 for Delphi by Michael Vinther - http://logicnet.dk/lib

    Requires:
     Graphics32 Library by Alex A. Denisov - http://g32.org/
     JasPer library 1.700.2 by Michael David Adams  - http://www.ece.uvic.ca/~mdadams/jasper/
     JasPerLib.dll from ImageFileLib 1.14 for Delphi by Michael Vinther - http://logicnet.dk/lib
}

interface

uses GR32, Graphics;

type
  TJ2KObject = class(TBitmap)
    procedure LoadFromFile(const fname: string); override;
    procedure SaveToFile(const fname: string); override;
  end;

procedure LoadBitmap32FromJ2K(fname: string; bm32: TBitmap32);
procedure LoadBitmapFromJ2K(fname: string; bm: Graphics.TBitmap);
procedure SaveBitmap32ToJ2K(fname: string; bm32: TBitmap32; percent: Integer = 0; format: Integer = 3);
procedure SaveBitmapToJ2K(fname: string; bm: Graphics.TBitmap);

implementation

uses Windows, SysUtils, gr32_vbcommon;

type

  TImageContainer = packed record
    Width, Height: Integer;
    BytesPerLine: Integer;
    PixelFormat: Integer;
    Bits: Pointer;
    Palette: Pointer;
    Options: PChar;
  end;

  TLoadImage = function(fname, extension: PChar; var Image: TImageContainer): Integer; stdcall;
  TSaveImage = function(fname, extension: PChar; var Image: TImageContainer): Integer; stdcall;
  TFreeImage = function(var Image: TImageContainer): Integer; stdcall;

procedure LoadBitmap32FromJ2K(fname: string; bm32: TBitmap32);
var
  Image: TImageContainer;
  jasper: THandle;
  LoadImage: TLoadImage;
  FreeImage: TFreeImage;
  TempExt: array[1..MAX_PATH] of Char;
  r, p, i, n: Integer;
  p4d: PARGB;
  p3s: PRGB;
  p1s, p1r, p1g, p1b: PByte;
begin
  if not FileExists(fname) then raise EInOutError.Create('jpeg2000 image file does not exist');

  ZeroMemory(@Image, sizeof(Image));

  jasper := LoadLibrary('JasPerLib.dll');
  if jasper <> 0 then begin
    try
      LoadImage := GetProcAddress(jasper, '?LibLoadImage@@YGHPAD0PAUTImageContainer@@@Z');
      FreeImage := GetProcAddress(jasper, '?LibFreeImage@@YGHPAUTImageContainer@@@Z');

      r := LoadImage(PChar(fname), @TempExt, Image);
      if r = 0 then begin
        try

          bm32.SetSize(Image.Width, Image.Height);
          bm32.Clear(0);

          n := Image.Width * Image.Height;

          p := Image.PixelFormat and $0F;
          if (p <> 1) and (p <> 3) and (p <> 4) then raise EInvalidGraphic.Create('unsupported Bitmap format');

          case Image.PixelFormat of
            $01, $11: begin // tested
                p1s := PByte(Image.Bits);
                p4d := PARGB(bm32.PixelPtr[0, 0]);
                for i := 1 to n do begin
                  p4d^.r := p1s^;
                  p4d^.g := p1s^;
                  p4d^.b := p1s^;
                  p4d^.a := $FF;
                  Inc(p1s);
                  Inc(p4d);
                end;
              end;
            $03: begin // tested
                p3s := PRGB(Image.Bits);
                p4d := PARGB(bm32.PixelPtr[0, 0]);
                for i := 1 to n do begin
                  p4d^.r := p3s^.r;
                  p4d^.g := p3s^.g;
                  p4d^.b := p3s^.b;
                  p4d^.a := $FF;
                  Inc(p3s);
                  Inc(p4d);
                end;
              end;
            $04: begin // not tested ? doesn't work ???
                CopyMemory(bm32.PixelPtr[0, 0], Image.Bits, n * 4);
              end;
            $13: begin // non interleaved planes - tested
                p1b := PByte(Image.Bits);
                p1g := p1b;
                Inc(p1g, n);
                p1r := p1g;
                Inc(p1r, n);
                p4d := PARGB(bm32.PixelPtr[0, 0]);
                for i := 1 to n do begin
                  p4d^.r := p1r^;
                  p4d^.g := p1g^;
                  p4d^.b := p1b^;
                  p4d^.a := $FF;
                  Inc(p1r);
                  Inc(p1g);
                  Inc(p1b);
                  Inc(p4d);
                end;
              end;
          else
            raise EInvalidGraphic.Create('unsupported Bitmap format');
          end;

        finally
          FreeImage(Image);
        end

      end
      else raise EInvalidGraphic.Create('error in Bitmap data');

    finally
      FreeLibrary(jasper);
    end;
  end;

end;

procedure SaveBitmap32ToJ2K(fname: string; bm32: TBitmap32; percent: Integer = 0; format: Integer = 3);
var
  Image: TImageContainer;
  jasper: THandle;
  SaveImage: TSaveImage;
  TempExt: array[1..MAX_PATH] of Char;
  r, i, n: Integer;
  options: string;
  p4s: PARGB;
  p3d: PRGB;
  p1d: PByte;
begin
  ZeroMemory(@Image, sizeof(Image));

  jasper := LoadLibrary('JasPerLib.dll');
  if jasper <> 0 then begin
    Image.Bits := nil;
    try
      SaveImage := GetProcAddress(jasper, '?LibSaveImage@@YGHPAD0PAUTImageContainer@@@Z');
      Image.Width := bm32.Width;
      Image.Height := bm32.Height;
      n := bm32.Height * bm32.Width;

      if format = 1 then begin
        Image.BytesPerLine := bm32.Width;
        Image.PixelFormat := $11;
        GetMem(Image.Bits, n);
        p4s := PARGB(bm32.Bits);
        p1d := PByte(Image.Bits);
        for i := 1 to n do begin
          p1d^ := Intensity(PColor32(p4s)^);
          Inc(p1d);
          Inc(p4s);
        end;
      end
      else begin
        Image.BytesPerLine := bm32.Width * 3;
        Image.PixelFormat := $03;
        GetMem(Image.Bits, n * 3);
        p4s := PARGB(bm32.Bits);
        p3d := PRGB(Image.Bits);
        for i := 1 to n do begin
          p3d^.r := p4s^.r;
          p3d^.g := p4s^.g;
          p3d^.b := p4s^.b;
          Inc(p3d);
          Inc(p4s);
        end;
      end;

      Image.Palette := nil;
      options := '';
      if percent > 0 then begin
        DecimalSeparator := '.';
        options := 'rate=' + FloatToStr(percent / 100);
      end;
      Image.Options := PChar(options);
      StrLCopy(@TempExt, PChar(UpperCase(Copy(ExtractFileExt(fname), 2, 3))), SizeOf(TempExt));
      r := SaveImage(PChar(fname), @TempExt, Image);
      if r <> 0 then raise EInvalidGraphicOperation.Create('Error writing image file');

    finally
      if Assigned(Image.Bits) then FreeMem(Image.Bits);
      FreeLibrary(jasper);
    end;
  end;

end;

procedure LoadBitmapFromJ2K(fname: string; bm: Graphics.TBitmap);
var
  bm32: TBitmap32;
begin
  bm32 := nil;
  try
    bm32 := TBitmap32.Create();
    LoadBitmap32FromJ2K(fname, bm32);
    bm.Assign(bm32);
  finally
    if Assigned(bm32) then bm32.Free;
  end;
end;

procedure SaveBitmapToJ2K(fname: string; bm: Graphics.TBitmap);
var
  bm32: TBitmap32;
begin
  bm32 := nil;
  try
    bm32 := TBitmap32.Create();
    bm32.Assign(bm);
    SaveBitmap32ToJ2K(fname, bm32);
  finally
    if Assigned(bm32) then bm32.Free;
  end;
end;

procedure TJ2KObject.LoadFromFile(const fname: string);
begin
  LoadBitmapFromJ2K(fname, self);
end;

procedure TJ2KObject.SaveToFile(const fname: string);
begin
  SaveBitmapToJ2K(fname, self);
end;

initialization
  TPicture.RegisterFileFormat('JP2', 'JPEG 2000 (jp2) Image File', TJ2KObject);
  TPicture.RegisterFileFormat('J2K', 'JPEG 2000 (code-stream) Image File', TJ2KObject);
  TPicture.RegisterFileFormat('JPC', 'JPEG 2000 (code-stream) Image File', TJ2KObject);
//  TPicture.RegisterFileFormat('PNM', 'Portable Pixmap/Graymap/Bitmap Image File', TJ2KObject);
//  TPicture.RegisterFileFormat('PPM', 'Portable Pixmap/Graymap/Bitmap Image File', TJ2KObject);
//  TPicture.RegisterFileFormat('RAS', 'Sun Rasterfile Image File', TJ2KObject);
finalization
  TPicture.UnregisterGraphicClass(TJ2KObject);
end.

