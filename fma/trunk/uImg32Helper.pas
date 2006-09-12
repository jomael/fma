unit uImg32Helper;

{
*******************************************************************************
* Descriptions: Global
* $Source: /cvsroot/fma/fma/uImg32Helper.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uImg32Helper.pas,v $
*
}

interface

uses
  GR32;

procedure LoadBitmap32FromFile(Filename: string; bm32: TBitmap32);
procedure SaveBitmap32ToFile(Filename: string; bm32: TBitmap32);

implementation

uses
  SysUtils, TntSysUtils,
  gr32_vbpng,  // PNG support (disabled)
  gr32_vbgif,  // GIF support
  gr32_vbj2k,  // JPEG2000 support
//gr32_vbwbmp, // WBMP support (not working - disabled)
  uWBMP;       // WBMP support (working)

(* 32bit Images *)

procedure LoadBitmap32FromFile(Filename: string; bm32: TBitmap32);
var
  ext: String;
begin
  ext := ExtractFileExt(Filename);
  {
  if (CompareText('.wbpm',ext) = 0) or (CompareText('.wbm',ext) = 0) then
    LoadBitmap32FromWBMP(Filename,bm32)
  else
  }
  if CompareText('.png',ext) = 0 then
    LoadBitmap32FromPNG(Filename,bm32)
  else
  if CompareText('.gif',ext) = 0 then
    LoadBitmap32FromGIF(Filename,bm32)
  else
    bm32.LoadFromFile(Filename);
end;

procedure SaveBitmap32ToFile(Filename: string; bm32: TBitmap32);
var
  ext: String;
begin
  ext := ExtractFileExt(Filename);
  {
  if (CompareText('.wbpm',ext) = 0) or (CompareText('.wbm',ext) = 0) then
    SaveBitmap32ToWBMP(Filename,bm32)
  else
  }
  if CompareText('.png',ext) = 0 then
    SaveBitmap32ToPNG(Filename,bm32,False,False,Color32(clTrWhite32))
  else
  if CompareText('.gif',ext) = 0 then
    SaveBitmap32ToGIF(Filename,bm32,False)
  else
    bm32.SaveToFile(Filename);
end;

end.
