unit uWBMP;

// Wireless BitMaP (WBMP) Level 0: B/W, Uncompressed

// This implements the WBMP format (WAPSpec 1.1 and 1.2)
// It does support ExtHeaders as defined in the spec.
// The WAP client does not need to implement ExtHeaders.
// It does not support Animation (load only first image).

// File extensions: .wbmp .wbm
// WSP/HTTP Media types: image/xwap.wbmp
//                       image/x-wap.wbmp
//                       image/vnd.wap.wbmp; level=0

// (c) 2004 Alexander Penev <sasho@5group.com>
// License: LGPL 2

interface

uses
  Classes, Windows, Graphics;

(*
  W-Bitmap = Header Image-data
  Header = TypeField FixHeaderField [ExtFields] Width Height
  TypeField = ‘Type of image which is defined in Section 6.1’
  FixHeaderField = ‘Octet which is defined in Table 6-3’
  ExtFields = *ExtFieldType00 | ExtFieldType01 | ExtFieldType10 | *ExtFieldType11
  ExtFieldType00 = ‘Octet which is defined in Section 6.3’
  ExtFieldType01 = ‘Octet which is defined in Section 6.3’
  ExtFieldType10 = ‘Octet which is defined in Section 6.3’
  ExtFieldType11 = ParameterHeader ParameterIdentifier ParameterValue
  ParameterHeader = ‘Octet which is defined in Table 6-4‘
  ParameterIdentifier = ‘Parameter identifier (US-ASCII string), length <= 8 bytes defined in ParameterHeader’
  ParameterValue = ‘Parameter value (alphanumeric string), length <= 16 bytes defined in ParameterHeader’
  Width = ‘Horizontal width of the bitmap in pixels (Multi-byte integer)’
  Height = ‘Vertical height of the bitmap in pixels (Multi-byte integer)’
  Image-data = Main-image *Animated-image ;’There can be 0 to 15 animated images’
  Main-image = ‘Bitmap formed according to image data structure specified by the TypeField’
  Animated-image = ‘Bitmap formed according to image data structure description below’
*)

const
  WBMP_TYPE_BW_NOCOMPRESSION = 0;
  WBMP_CONTINUE_MASK = $80;
  WBMP_DATA_MASK = $7F;
  WBMP_DATA_SHIFT = 7;
  WBMP_FIXEDHEADERFIELD_EXT_MASK = $60;
  WBMP_FIXEDHEADERFIELD_EXT_00 = $00;
  WBMP_FIXEDHEADERFIELD_EXT_01 = $20;
  WBMP_FIXEDHEADERFIELD_EXT_10 = $40;
  WBMP_FIXEDHEADERFIELD_EXT_11 = $60;
  WBMP_FIXEDHEADERFIELD_EXT_11_IDENT_MASK = $70;
  WBMP_FIXEDHEADERFIELD_EXT_11_IDENT_SHIFT = 4;
  WBMP_FIXEDHEADERFIELD_EXT_11_VALUE_MASK = $0F;
  WBMP_FIXEDHEADERFIELD_EXT_11_VALUE_SHIFT = 0;

type
  TWBMP = class(TBitmap)
  private
    FTypeField: Byte;
    FFixHeaderField: Byte;
    FExtHeaders: TStringList;
    procedure SetTypeField(const Value: Byte);
    procedure SetFixHeaderField(const Value: Byte);
    procedure SetExtHeaders(const Value: TStringList);
  private
    procedure FixImage;
    procedure ReadStream(Stream: TStream; Size: Longint);
    procedure WriteStream(Stream: TStream; WriteSize: Boolean);
  protected
    procedure ReadData(Stream: TStream); override;
    procedure WriteData(Stream: TStream); override;
    procedure OnExtHeadersChange(Sender: TObject);
  public
    constructor Create; override;
    procedure Assign(Source: TPersistent); override;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToStream(Stream: TStream); override;
    procedure LoadFromClipboardFormat(AFormat: Word; AData: THandle; APalette: HPALETTE); override;
    procedure SaveToClipboardFormat(var AFormat: Word; var AData: THandle; var APalette: HPALETTE); override;
    property TypeField: Byte read FTypeField write SetTypeField;
    property FixHeaderField: Byte read FFixHeaderField write SetFixHeaderField;
    property ExtHeaders: TStringList read FExtHeaders write SetExtHeaders;
  end;

var
  CF_WBMP: WORD;

resourcestring
  sWBMPImageFile = 'WBMP Image';

  sUnsuportedWBMPType = 'Unsuported WBMP type';
  sReservedExtHeaderType = 'Unsuported extended header type';

  sNotImplemented = 'Unsuported feature: 00 multi-byte bitfield';

implementation

uses
  SysUtils;

{ TWBMP }

constructor TWBMP.Create;
begin
  inherited;
  FExtHeaders := TStringList.Create;
  FExtHeaders.OnChange := OnExtHeadersChange;
  FixImage;
end;

procedure TWBMP.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  FixImage;
  Changed(Self);
end;

procedure TWBMP.FixImage;
var
  Pal: TMaxLogPalette;
begin
  FillChar(Pal, SizeOf(Pal), 0);
  Pal.palVersion := $300;
  Pal.palNumEntries := 2;
  Pal.palPalEntry[1].peRed := $FF;
  Pal.palPalEntry[1].peGreen := $FF;
  Pal.palPalEntry[1].peBlue := $FF;
  Palette := CreatePalette(PLogPalette(@Pal)^);
  PixelFormat := pf1bit;
end;

procedure TWBMP.ReadStream(Stream: TStream; Size: Longint);
var
  B: Byte;
  BytesPerRow: Integer;
  i: Integer;
  SId: string[8];
  SVal: string[16];

  function ReadNum: Integer;
  var
    B: Integer;
  begin
    Result := 0;
    repeat
      //B := 0;
      Stream.Read(B, SizeOf(Byte));
      Result := (Result shl WBMP_DATA_SHIFT) or (B and WBMP_DATA_MASK);
    until (B and WBMP_CONTINUE_MASK) = 0;
  end;

begin
  Stream.Read(B, SizeOf(Byte));
  TypeField := B;
  case TypeField of
    WBMP_TYPE_BW_NOCOMPRESSION:
      begin
        FixImage;
        Stream.Read(B, SizeOf(Byte));
        FixHeaderField := B;
        ExtHeaders.Clear;
        if (FixHeaderField and WBMP_CONTINUE_MASK) <> 0 then
          case FixHeaderField and WBMP_FIXEDHEADERFIELD_EXT_MASK of
            WBMP_FIXEDHEADERFIELD_EXT_00: // Not Implemented
              begin
                raise Exception.Create(sNotImplemented);
              end;
            WBMP_FIXEDHEADERFIELD_EXT_01, WBMP_FIXEDHEADERFIELD_EXT_10: // Reserved
              begin
                raise Exception.Create(sReservedExtHeaderType);
              end;
            WBMP_FIXEDHEADERFIELD_EXT_11:
              begin
                repeat
                  Stream.Read(B, SizeOf(Byte));
                  SetLength(SId, (B and WBMP_FIXEDHEADERFIELD_EXT_11_IDENT_MASK) shr WBMP_FIXEDHEADERFIELD_EXT_11_IDENT_SHIFT);
                  SetLength(SVal, (B and WBMP_FIXEDHEADERFIELD_EXT_11_VALUE_MASK) shr WBMP_FIXEDHEADERFIELD_EXT_11_VALUE_SHIFT);
                  Stream.Read(SId[1], Length(SId));
                  Stream.Read(SVal[1], Length(SVal));
                  ExtHeaders.Values[SId] := SVal;
                until (B and WBMP_CONTINUE_MASK) = 0;
              end;
          end;
        Width := ReadNum;
        Height := ReadNum;
        BytesPerRow := Width div 8;
        for i := 0 to Height - 1 do
          Stream.Read(ScanLine[i]^, BytesPerRow);
        Changed(Self);
      end;
  else
    raise Exception.Create(sUnsuportedWBMPType);
  end;
end;

procedure TWBMP.WriteStream(Stream: TStream; WriteSize: Boolean);
var
  Size: DWORD;
  M: TMemoryStream;
  BytesPerRow: Integer;
  i: Integer;
  SId: string[8];
  SVal: string[16];
  B: Byte;

  procedure WriteNum(N: Integer);
  var
    Rev: array[0..6] of Byte;
    i: Integer;
  begin
    i := 0;
    repeat
      Rev[i] := N or WBMP_CONTINUE_MASK;
      Inc(i);
      N := N shr WBMP_DATA_SHIFT;
    until N = 0;
    Rev[0] := Rev[0] and WBMP_DATA_MASK;
    repeat
      Dec(i);
      M.Write(Rev[i], SizeOf(Byte));
    until i = 0;
  end;

begin
  M := TMemoryStream.Create;
  try
    case TypeField of
      WBMP_TYPE_BW_NOCOMPRESSION:
        begin
          WriteNum(TypeField);
          M.Write(FixHeaderField, SizeOf(Byte));
          if (FixHeaderField and WBMP_CONTINUE_MASK) <> 0 then
            case FixHeaderField and WBMP_FIXEDHEADERFIELD_EXT_MASK of
              WBMP_FIXEDHEADERFIELD_EXT_00:
                begin
                  raise Exception.Create(sNotImplemented);
                end;
              WBMP_FIXEDHEADERFIELD_EXT_01, WBMP_FIXEDHEADERFIELD_EXT_10:
                begin
                  raise Exception.Create(sReservedExtHeaderType); // Reserved
                end;
              WBMP_FIXEDHEADERFIELD_EXT_11:
                begin
                  for i := 0 to ExtHeaders.Count - 1 do
                    begin
                      SId := Copy(ExtHeaders.Names[i], 1, 8);
                      SVal := Copy(ExtHeaders.Values[SId], 1, 16);
                      B := (Length(SId) shl WBMP_FIXEDHEADERFIELD_EXT_11_IDENT_SHIFT) or
                        (Length(SVal) shl WBMP_FIXEDHEADERFIELD_EXT_11_VALUE_SHIFT);
                      if i < ExtHeaders.Count - 1 then
                        B := B or WBMP_CONTINUE_MASK;
                      M.Write(B, SizeOf(Byte));
                      M.Write(SId[1], Length(SId));
                      M.Write(SVal[1], Length(SVal));
                    end;
                end;
            end;
          WriteNum(Width);
          WriteNum(Height);
          BytesPerRow := Width div 8;
          FixImage;
          for i := 0 to Height - 1 do
            M.Write(ScanLine[i]^, BytesPerRow);

          Size := M.Size;
          if WriteSize then
            Stream.WriteBuffer(Size, sizeof(Size));
          Stream.CopyFrom(M, 0);
        end;
    end;
  finally
    M.Free;
  end;
end;

procedure TWBMP.ReadData(Stream: TStream);
var
  Size: DWORD;
begin
  Stream.Read(Size, SizeOf(Size));
  ReadStream(Stream, Size);
end;

procedure TWBMP.WriteData(Stream: TStream);
begin
  WriteStream(Stream, True);
end;

procedure TWBMP.LoadFromStream(Stream: TStream);
begin
  ReadStream(Stream, Stream.Size - Stream.Position);
end;

procedure TWBMP.SaveToStream(Stream: TStream);
begin
  WriteStream(Stream, False);
end;

procedure TWBMP.LoadFromClipboardFormat(AFormat: Word; AData: THandle; APalette: HPALETTE);
var
  Size: Longint;
  Buffer: Pointer;
  Stream: TMemoryStream;
  HWnd: THandle;
begin
  if (AData = 0) then
    AData := GetClipboardData(AFormat);
  if (AData <> 0) and (AFormat = CF_WBMP) then
    begin
      Size := GlobalSize(AData);
      Buffer := GlobalLock(AData);
      try
        Stream := TMemoryStream.Create;
        try
          Stream.SetSize(Size);
          Move(Buffer^, Stream.Memory^, Size);
          LoadFromStream(Stream);
        finally
          Stream.Free;
        end;
      finally
        GlobalUnlock(AData);
      end;
    end
  else
    begin
      HWnd := Classes.AllocateHWnd(nil);
      if OpenClipboard(HWnd) then
        begin
          AData := GetClipboardData(CF_BITMAP);
          inherited LoadFromClipboardFormat(CF_BITMAP, AData, APalette);
          FixImage;
          CloseClipboard;
        end;
      Classes.DeallocateHWnd(HWnd);
    end;
end;

procedure TWBMP.SaveToClipboardFormat(var AFormat: Word; var AData: THandle; var APalette: HPALETTE);
var
  Stream: TMemoryStream;
  Data: THandle;
  Buffer: Pointer;
begin
  if (Empty) then
    exit;

  inherited SaveToClipboardFormat(AFormat, AData, APalette);

  Stream := TMemoryStream.Create;
  try
    SaveToStream(Stream);
    Stream.Position := 0;
    Data := GlobalAlloc(GMEM_MOVEABLE + GMEM_DDESHARE, Stream.Size);
    try
      if (Data <> 0) then
        begin
          Buffer := GlobalLock(Data);
          try
            Move(Stream.Memory^, Buffer^, Stream.Size);
          finally
            GlobalUnlock(Data);
          end;
          SetClipboardData(CF_WBMP, Data);
        end;
    except
      GlobalFree(Data);
      raise;
    end;
  finally
    Stream.Free;
  end;
end;

procedure TWBMP.SetTypeField(const Value: Byte);
begin
  FTypeField := Value;
end;

procedure TWBMP.SetFixHeaderField(const Value: Byte);
begin
  FFixHeaderField := Value;
end;

procedure TWBMP.SetExtHeaders(const Value: TStringList);
begin
  FExtHeaders.Assign(Value);
end;

procedure TWBMP.OnExtHeadersChange(Sender: TObject);
begin
  if ExtHeaders.Count = 0 then
    FixHeaderField := FixHeaderField and (WBMP_FIXEDHEADERFIELD_EXT_MASK or WBMP_CONTINUE_MASK)
  else
    FixHeaderField := FixHeaderField and WBMP_FIXEDHEADERFIELD_EXT_MASK or WBMP_FIXEDHEADERFIELD_EXT_11 or WBMP_CONTINUE_MASK;
end;

initialization
  TPicture.RegisterFileFormat('WBMP', sWBMPImageFile, TWBMP);
  TPicture.RegisterFileFormat('WBM', sWBMPImageFile, TWBMP);
  CF_WBMP := RegisterClipboardFormat(PChar(sWBMPImageFile));
  TPicture.RegisterClipboardFormat(CF_WBMP, TWBMP);
end.

