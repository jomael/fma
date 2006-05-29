unit ImageListXP;

{$R-,T-,H+,X+}

interface

uses Windows, Classes, Consts, Graphics, CommCtrl, ImgList;

type

{ TCustomImageList }

  TImageFormat = (imCOLOR_DDB,imCOLOR,imCOLOR_4,imCOLOR_8,imCOLOR_16,imCOLOR_24,imCOLOR_32);

  TImageListXP = class(TCustomImageList)
  private
    FColorFormat: TImageFormat;
    function CreateColor: UINT;
    procedure SetColorFormat(const Value: TImageFormat);
    procedure CreateImageListXP;
  protected
    procedure Initialize; override;
  published
    property ColorFormat: TImageFormat read FColorFormat write SetColorFormat;
    property BlendColor;
    property BkColor;
    property AllocBy;
    property DrawingStyle;
    property Height;
    property ImageType;
    property Masked;
    property OnChange;
    property ShareImages;
    property Width;
  end;

procedure Register;

implementation

uses SysUtils;

procedure Register;
begin
  RegisterComponents('FMA', [TImageListXP]);
end;  

{ TImageListXP }

procedure TImageListXP.CreateImageListXP;
const
  Mask: array[Boolean] of UINT = (0, ILC_MASK);
begin
  Handle := ImageList_Create(Width, Height, CreateColor or Mask[Masked], AllocBy, AllocBy);
  if not HandleAllocated then raise EInvalidOperation.Create(SInvalidImageList);
  if BkColor <> clNone then BkColor := BkColor;
end;

function TImageListXP.CreateColor: UINT;
begin
  case FColorFormat of
    imCOLOR:    Result := ILC_COLOR;
    imCOLOR_4:  Result := ILC_COLOR4;
    imCOLOR_8:  Result := ILC_COLOR8;
    imCOLOR_16: Result := ILC_COLOR16;
    imCOLOR_24: Result := ILC_COLOR24;
    imCOLOR_32: Result := ILC_COLOR32;
    else        Result := ILC_COLORDDB;
  end;
end;

procedure TImageListXP.SetColorFormat(const Value: TImageFormat);
begin
  FColorFormat := Value;
  CreateImageListXP;
end;

procedure TImageListXP.Initialize;
begin
  FColorFormat := imCOLOR_32;
  Inherited Initialize;
  CreateImageListXP;
end;

end.
