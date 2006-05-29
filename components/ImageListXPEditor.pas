unit ImageListXPEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  DesignIntf, DesignEditors, Dialogs, StdCtrls, ComCtrls, ImageListXP,
  ExtDlgs, ExtCtrls, ShellAPI;

type
  TfrmImageListXPEdt = class(TForm)
    ImagesGroupBox: TGroupBox;
    OkButton: TButton;
    CancelButton: TButton;
    ApplyButton: TButton;
    ImagesListView: TListView;
    AddButton: TButton;
    ReplaceButton: TButton;
    DeleteButton: TButton;
    LeftButton: TButton;
    RightButton: TButton;
    ClearButton: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    SelImageGroupBox: TGroupBox;
    Panel1: TPanel;
    SelImage: TImage;
    SavePictureDialog1: TSavePictureDialog;
    SaveButton: TButton;
    MagnifyGroupBox: TGroupBox;
    ZoomPanel: TPanel;
    ZoomImage: TImage;
    ExportButton: TButton;
    ImportButton: TButton;
    HelpButton: TButton;
    AllButton: TButton;
    ColorPanel: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    lblColorR: TLabel;
    lblColorG: TLabel;
    lblColorB: TLabel;
    Label2: TLabel;
    lblColorT: TLabel;
    procedure AddButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure ImagesListViewSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure DeleteButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure ReplaceButtonClick(Sender: TObject);
    procedure LeftButtonClick(Sender: TObject);
    procedure RightButtonClick(Sender: TObject);
    procedure ExportButtonClick(Sender: TObject);
    procedure ImportButtonClick(Sender: TObject);
    procedure SelImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SelImageClick(Sender: TObject);
    procedure AllButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure ZoomPanelResize(Sender: TObject);
  private
    { Private declarations }
    SelBitmap: TBitmap;
    FLastBitmapIndex: integer;
    FZoomX,FZoomY: integer;
    FModified,FEverModified: Boolean;
    FImages,FEditorImages: TImageListXP;
    FAnalizer: boolean;
    //FItemRect: TRect;
    procedure SetImages(const Value: TImageListXP);
    procedure SetModified(const Value: Boolean);
    procedure SetBitmapIndex(const Value: Integer);
    procedure SetAnalizerisible(const Value: boolean);
    procedure DoDrawZoom(X,Y: integer); 
    procedure DoClearImages;
    procedure DoApplyChanged;
    procedure DoDeleteImage(Index: integer);
    procedure DoLoadPicture(ReplaceIndex: Integer = -1; MaskX: Integer = -1; MaskY: Integer = -1);
    property IsModified: Boolean read FModified write SetModified;
    property LastBitmapIndex: Integer read FLastBitmapIndex write SetBitmapIndex;
    property EyedropperVisible: boolean read FAnalizer write SetAnalizerisible;
  public
    { Public declarations }
    property Images: TImageListXP read FImages write SetImages;
    property Modified: Boolean read FEverModified;
  end;

  TImageListXPEditor = class(TDefaultEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure Edit; override;
  end;

procedure Register;

implementation

uses ImgList, Types;

{$R *.DFM}

procedure Register;
begin
  RegisterComponentEditor(TImageListXP, TImageListXPEditor);
end;

{ TImageListXPEditor }

function TImageListXPEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

function TImageListXPEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := 'I&mageList Editor...'
  else
    Result := '';
end;

procedure TImageListXPEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then Edit;
end;

procedure TImageListXPEditor.Edit;
var
  Editor: TfrmImageListXPEdt;
begin
  Editor := TfrmImageListXPEdt.Create(Application);
  try
    Editor.Images := TImageListXP(Component);
    Editor.ShowModal;
    if Editor.Modified then
      Designer.Modified;
  finally
    Editor.Free;
  end;
end;

{ TfrmImageListXPEdt }

procedure TfrmImageListXPEdt.SetImages(const Value: TImageListXP);
var
  i: integer;
  Icon: TIcon;
begin
  FImages := Value;
  ImagesListView.Clear;
  FEditorImages.Clear;
  if Assigned(FImages) then begin
    FEditorImages.Assign(Value);
    FEditorImages.ColorFormat := FImages.ColorFormat;
    Icon := TIcon.Create;
    try
      for i := 0 to FImages.Count-1 do begin
        FImages.GetIcon(i,Icon);
        with ImagesListView.Items.Add do begin
          Caption := IntToStr(i);
          ImageIndex := FEditorImages.AddIcon(Icon);
        end;
      end;
    finally
      Icon.Free;
    end;
    ClearButton.Enabled := FEditorImages.Count <> 0;
    ExportButton.Enabled := ClearButton.Enabled;
    AllButton.Enabled := ClearButton.Enabled;
  end;
  FEverModified := False;
  IsModified := False;
end;

procedure TfrmImageListXPEdt.SetModified(const Value: Boolean);
begin
  LastBitmapIndex := -1;
  FModified := Value;
  ApplyButton.Enabled := FModified;
  ClearButton.Enabled := FEditorImages.Count <> 0;
  ExportButton.Enabled := ClearButton.Enabled;
  AllButton.Enabled := ClearButton.Enabled;
end;

procedure TfrmImageListXPEdt.FormCreate(Sender: TObject);
begin
  SelBitmap := TBitmap.Create;
  FEditorImages := TImageListXP.Create(Self);
  FEditorImages.ColorFormat := imCOLOR_32;
  ImagesListView.SmallImages := FEditorImages;
  ImagesListView.LargeImages := FEditorImages;
  ZoomImage.Picture.Bitmap.Height := ZoomImage.Height;
  ZoomImage.Picture.Bitmap.Width := ZoomImage.Width;
  ZoomImage.Canvas.Brush.Color := ColorToRGB(clWhite);
  ZoomImage.Canvas.Pen.Mode := pmNot;
  LastBitmapIndex := -1;
end;

procedure TfrmImageListXPEdt.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FEditorImages);
  {
  FreeAndNil(SelBitmap);
  }
end;

procedure TfrmImageListXPEdt.ApplyButtonClick(Sender: TObject);
begin
  DoApplyChanged;
  IsModified := False;
end;

procedure TfrmImageListXPEdt.DoApplyChanged;
var
  i: integer;
  Icon: TIcon;
begin
  if IsModified and Assigned(FImages) then begin
    FImages.Clear;
    FImages.ColorFormat := FEditorImages.ColorFormat;
    Icon := TIcon.Create;
    try
      for i := 0 to FEditorImages.Count-1 do begin
        FEditorImages.GetIcon(i,Icon);
        FImages.AddIcon(Icon);
      end;
      FEverModified := True;
    finally
      Icon.Free;
    end;
  end;
end;

procedure TfrmImageListXPEdt.OkButtonClick(Sender: TObject);
begin
  if IsModified then ApplyButton.Click;
  Close;
end;

procedure TfrmImageListXPEdt.CancelButtonClick(Sender: TObject);
begin
  IsModified := False;
  Close;
end;

procedure TfrmImageListXPEdt.ImagesListViewSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  DeleteButton.Enabled := ImagesListView.SelCount <> 0;
  ReplaceButton.Enabled := ImagesListView.SelCount = 1;
  SaveButton.Enabled := ReplaceButton.Enabled;
  LeftButton.Enabled := ReplaceButton.Enabled and (ImagesListView.Selected.Index > 0);
  RightButton.Enabled := ReplaceButton.Enabled and (ImagesListView.Selected.Index < ImagesListView.Items.Count-1);
  EyedropperVisible := ReplaceButton.Enabled and (LastBitmapIndex = ImagesListView.Selected.Index);
  if ReplaceButton.Enabled then begin
    SelBitmap.Width := 0;
    SelBitmap.Height := 0;
    FEditorImages.GetIcon(ImagesListView.Selected.Index,SelImage.Picture.Icon);
    FEditorImages.GetBitmap(ImagesListView.Selected.Index,SelBitmap);
    ZoomImage.Canvas.FillRect(Rect(0,0,ZoomImage.Width,ZoomImage.Height));
    FZoomX := -SelBitmap.Width;
    FZoomY := -SelBitmap.Height;
    DoDrawZoom(FZoomX,FZoomY);
  end;
end;

procedure TfrmImageListXPEdt.DoLoadPicture(ReplaceIndex, MaskX, MaskY: Integer);
var
  Buf,Img: TImage;
  Icon,IconSm: HICON;
  NewIndex: integer;
begin
  Buf := TImage.Create(nil);
  Img := TImage.Create(nil);
  try
    LastBitmapIndex := -1;
    NewIndex := ImagesListView.Items.Count;
    Buf.AutoSize := True;
    Buf.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    { TODO: Add support for JPEG and other formats... }
    if CompareText('.ICO',ExtractFileExt(OpenPictureDialog1.FileName)) <> 0 then begin
      { Adding bitmap }
      Img.Height := FEditorImages.Height;
      Img.Width := FEditorImages.Width;
      SetStretchBltMode(Img.Canvas.Handle, HALFTONE);
      SetBrushOrgEx(Img.Canvas.Handle, 0, 0, nil);
      StretchBlt(Img.Canvas.Handle, 0, 0, Img.Width, Img.Height,
        Buf.Canvas.Handle, 0, 0, Buf.Width, Buf.Height, SRCCOPY);
      if MaskX = -1 then MaskX := 0;
      if MaskY = -1 then MaskY := Img.Picture.Bitmap.Height-1;
      if ReplaceIndex = -1 then
        with ImagesListView.Items.Add do begin
          Caption := IntToStr(NewIndex);
          ImageIndex := FEditorImages.AddMasked(Img.Picture.Bitmap,
            Img.Picture.Bitmap.Canvas.Pixels[MaskX,MaskY]);
          MakeVisible(False);
        end
      else
        FEditorImages.ReplaceMasked(ReplaceIndex,Img.Picture.Bitmap,
          Img.Picture.Bitmap.Canvas.Pixels[MaskX,MaskY]);
      IsModified := True;
      if ReplaceIndex = -1 then
        LastBitmapIndex := NewIndex;
    end
    else begin
      { Adding icon }
      if Buf.Height <> FEditorImages.Height then begin
        if ExtractIconEx(PChar(OpenPictureDialog1.FileName),0,Icon,IconSm,1) > 1 then begin
          if FEditorImages.Width = 32 then begin
            Buf.Picture.Icon.Handle := Icon;
            DeleteObject(IconSm);
          end
          else
          if FEditorImages.Width = 16 then begin
            Buf.Picture.Icon.Handle := IconSm;
            DeleteObject(Icon);
          end
          else begin
            DeleteObject(Icon);
            DeleteObject(IconSm);
          end;
        end;
      end;
      if ReplaceIndex = -1 then
        with ImagesListView.Items.Add do begin
          Caption := IntToStr(NewIndex);
          ImageIndex := FEditorImages.AddIcon(Buf.Picture.Icon);
          MakeVisible(False);
        end
      else
        FEditorImages.ReplaceIcon(ReplaceIndex,Buf.Picture.Icon);
      IsModified := True;
    end;
  finally
    Img.Free;
    Buf.Free;
  end;
end;

procedure TfrmImageListXPEdt.DeleteButtonClick(Sender: TObject);
var
  i,Index: integer;
  s: string;
begin
  s := IntToStr(ImagesListView.SelCount)+' image';
  if ImagesListView.SelCount <> 1 then s := s + 's';
  MessageBeep(MB_ICONQUESTION);
  if MessageDlg('Deleting '+s+' from list?',mtConfirmation,[mbYes,mbNo],0) = ID_YES then begin
    Index := ImagesListView.Selected.Index;
    for i := ImagesListView.Items.Count-1 downto 0 do
      if ImagesListView.Items[i].Selected then
        DoDeleteImage(ImagesListView.Items[i].Index);
    if Index >= ImagesListView.Items.Count then
      Index := ImagesListView.Items.Count-1;
    if Index <> -1 then begin
      ImagesListView.Selected := ImagesListView.Items[Index];
      ImagesListView.Selected.MakeVisible(False);
    end;
  end;
end;

procedure TfrmImageListXPEdt.ClearButtonClick(Sender: TObject);
begin
  MessageBeep(MB_ICONQUESTION);
  if MessageDlg('Deleting ALL images from list?',mtConfirmation,[mbYes,mbNo],0) = ID_YES then
    DoClearImages;
end;

procedure TfrmImageListXPEdt.AddButtonClick(Sender: TObject);
begin
  OpenPictureDialog1.Options := OpenPictureDialog1.Options + [ofAllowMultiSelect];
  if OpenPictureDialog1.Execute then begin
    ImagesListView.Selected := nil;
    while OpenPictureDialog1.Files.Count <> 0 do begin
      OpenPictureDialog1.FileName := OpenPictureDialog1.Files[0];
      DoLoadPicture;
      OpenPictureDialog1.Files.Delete(0);
      ImagesListView.Selected := ImagesListView.Items[ImagesListView.Items.Count-1]; 
    end;
  end;
end;

procedure TfrmImageListXPEdt.ReplaceButtonClick(Sender: TObject);
begin
  OpenPictureDialog1.Options := OpenPictureDialog1.Options - [ofAllowMultiSelect];
  if OpenPictureDialog1.Execute then begin
    DoLoadPicture(ImagesListView.Selected.Index);
    ImagesListViewSelectItem(ImagesListView,ImagesListView.Selected,True);
  end;
end;

procedure TfrmImageListXPEdt.LeftButtonClick(Sender: TObject);
var
  Index: integer;
  Icon1,Icon2: TIcon;
begin
  Icon1 := TIcon.Create;
  Icon2 := TIcon.Create;
  try
    Index := ImagesListView.Selected.Index;
    FEditorImages.GetIcon(Index-1,Icon1);
    FEditorImages.GetIcon(Index,Icon2);
    FEditorImages.ReplaceIcon(Index-1,Icon2);
    FEditorImages.ReplaceIcon(Index,Icon1);
    ImagesListView.Selected := nil;
    ImagesListView.Selected := ImagesListView.Items[Index-1];
    IsModified := True;
  finally
    Icon2.Free;
    Icon1.Free;
  end;
end;

procedure TfrmImageListXPEdt.RightButtonClick(Sender: TObject);
var
  Index: integer;
  Icon1,Icon2: TIcon;
begin
  Icon1 := TIcon.Create;
  Icon2 := TIcon.Create;
  try
    Index := ImagesListView.Selected.Index;
    FEditorImages.GetIcon(Index,Icon1);
    FEditorImages.GetIcon(Index+1,Icon2);
    FEditorImages.ReplaceIcon(Index,Icon2);
    FEditorImages.ReplaceIcon(Index+1,Icon1);
    ImagesListView.Selected := nil;
    ImagesListView.Selected := ImagesListView.Items[Index+1];
    IsModified := True;
  finally
    Icon2.Free;
    Icon1.Free;
  end;
end;

procedure TfrmImageListXPEdt.DoDeleteImage(Index: integer);
var
  i: integer;
begin
  Index := ImagesListView.Selected.Index;
  FEditorImages.Delete(Index);
  ImagesListView.Items.Delete(Index);
  for i := Index to ImagesListView.Items.Count-1 do
    with ImagesListView.Items[i] do begin
      Caption := IntToStr(i);
      ImageIndex := ImageIndex-1;
    end;
  IsModified := True;
end;

procedure TfrmImageListXPEdt.ExportButtonClick(Sender: TObject);
var
  Bitmap: TBitmap;
  Icon: TIcon;
  i: integer;
begin
  { TODO: Add export to PNG/ICO in order to keep Alpha channel }
  Icon := TIcon.Create;
  Bitmap := TBitmap.Create;
  try
    SavePictureDialog1.Title := 'Export All Images...';
    if SavePictureDialog1.Execute then begin
      Bitmap.Height := FEditorImages.Height;
      Bitmap.Width := FEditorImages.Width*FEditorImages.Count;
      for i := 0 to FEditorImages.Count-1 do begin
        FEditorImages.GetIcon(i,Icon);
        Bitmap.Canvas.Draw(i*FEditorImages.Width,0,Icon);
      end;
      Bitmap.SaveToFile(SavePictureDialog1.FileName);
    end;
  finally
    Bitmap.Free;
    Icon.Free;
  end;
end;

procedure TfrmImageListXPEdt.ImportButtonClick(Sender: TObject);
var
  Bitmap: TBitmap;
  Img: TImage;
  i,w,IconCount: integer;
begin
  { TODO: Add import from PNG/ICO in order to keep Alpha channel }
  if (ImagesListView.Items.Count = 0) or ((MessageBeep(MB_ICONQUESTION) or True) and
    (MessageDlg('Import does not support Windows XP Alpha Blending. Continue will delete ALL current images?',
    mtConfirmation,[mbYes,mbNo],0) = ID_YES)) then begin
    if OpenPictureDialog1.Execute then begin
      Img := TImage.Create(nil);
      Bitmap := TBitmap.Create;
      try
        Bitmap.LoadFromFile(OpenPictureDialog1.FileName);
        if (Bitmap.Height <> FEditorImages.Height) or (Bitmap.Width mod FEditorImages.Width <> 0) then
          raise EConvertError.Create('Bitmap size is not valid');
        Img.Height := FEditorImages.Height;
        Img.Width := FEditorImages.Width;
        IconCount := Bitmap.Width div FEditorImages.Width;
        DoClearImages;
        for i := 0 to IconCount-1 do begin
          w := i*FEditorImages.Width;
          Img.Canvas.CopyRect(Rect(0,0,Img.Width,Img.Height),Bitmap.Canvas,
            Rect(w,0,w+FEditorImages.Width,FEditorImages.Height));
          with ImagesListView.Items.Add do begin
            Caption := IntToStr(ImagesListView.Items.Count);
            ImageIndex := FEditorImages.AddMasked(Img.Picture.Bitmap,
              Img.Picture.Bitmap.Canvas.Pixels[0,Img.Picture.Bitmap.Height-1]);
            MakeVisible(False);
          end;
        end;
        IsModified := True;
      finally
        Bitmap.Free;
        Img.Free;
      end;
    end;
  end;
end;

procedure TfrmImageListXPEdt.DoClearImages;
begin
  FEditorImages.Clear;
  ImagesListView.Items.Clear;
  IsModified := True;
end;

procedure TfrmImageListXPEdt.SelImageMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  X := Round(X - (SelImage.Width - SelImage.Picture.Width) / 2);
  Y := Round(Y - (SelImage.Height - SelImage.Picture.Height) / 2);
  if (X <> FZoomX) or (Y <> FZoomY) then begin
    DoDrawZoom(X,Y);
    FZoomX := X;
    FZoomY := Y;
  end;
end;

procedure TfrmImageListXPEdt.SelImageClick(Sender: TObject);
var
  x,y: integer;
begin
  if (FZoomX >= 0) and (FZoomY >= 0) and (FZoomX < SelBitmap.Width) and (FZoomY < SelBitmap.Height) and
    EyedropperVisible then begin
    { Reload image with new transparent color set }
    x := FZoomX;
    y := FZoomY; // Remember hot spot
    DoDeleteImage(LastBitmapIndex);
    DoLoadPicture(-1,x,y);
    { Update view }
    ImagesListView.Selected := ImagesListView.Items[LastBitmapIndex];
    DoDrawZoom(x,y);
  end
  else
    Beep;
end;

procedure TfrmImageListXPEdt.AllButtonClick(Sender: TObject);
begin
  ImagesListView.SelectAll;
end;

procedure TfrmImageListXPEdt.SaveButtonClick(Sender: TObject);
var
  Img: TBitmap;
begin
  Img := TBitmap.Create;
  try
    SavePictureDialog1.Title := 'Save Image As...';
    if SavePictureDialog1.Execute then begin
      FEditorImages.GetBitmap(ImagesListView.Selected.Index,Img);
      Img.SaveToFile(SavePictureDialog1.FileName);
    end;
  finally
    Img.Free;
  end;
end;

procedure TfrmImageListXPEdt.SetBitmapIndex(const Value: Integer);
begin
  FLastBitmapIndex := Value;
  SetAnalizerisible(Value <> -1);
end;

procedure TfrmImageListXPEdt.ZoomPanelResize(Sender: TObject);
begin
  ZoomImage.Picture.Bitmap.Width := ZoomImage.Width;
end;

procedure TfrmImageListXPEdt.SetAnalizerisible(const Value: boolean);
begin
  FAnalizer := Value;
  if Value then MagnifyGroupBox.Caption := 'Eyedropper Tool'
    else MagnifyGroupBox.Caption := 'Magnifying Glass';
  DoDrawZoom(FZoomX,FZoomY);
end;

procedure TfrmImageListXPEdt.DoDrawZoom(X,Y: integer);
const
  ZoomDx = 19; { should be odd number, and so than dy is odd too, see * formulae }
var
  dx,dy: integer;
  Zoom: TRect;
  SelColor: TColor;
begin
  { Draw zoom with center (X,Y) }
  ZoomImage.Canvas.FillRect(Rect(0,0,ZoomImage.Width,ZoomImage.Height));
  dx := ZoomDx;
  dy := Round(dx * ZoomImage.Height / ZoomImage.Width); {*}
  StretchBlt(ZoomImage.Canvas.Handle, 0, 0, ZoomImage.Width, ZoomImage.Height,
    SelBitmap.Canvas.Handle, X - dx div 2, Y - dy div 2, dx, dy, SRCCOPY);
  { Show color details }
  SelColor := SelBitmap.Canvas.Pixels[X,Y];
  lblColorT.Caption := IntToStr(DWORD(SelColor) and $FF000000 shr 24);
  lblColorB.Caption := IntToStr(DWORD(SelColor) and $00FF0000 shr 16);
  lblColorG.Caption := IntToStr(DWORD(SelColor) and $0000FF00 shr 8);
  lblColorR.Caption := IntToStr(DWORD(SelColor) and $000000FF);
  { Draw transparent color pointer if bitmap is last added }
  X := ZoomImage.Width div 2;
  Y := ZoomImage.Height div 2;
  dx := ZoomImage.Width div (2*ZoomDx);
  dy := dx;
  Zoom.Left := X - dx;
  Zoom.Right := X + dx;
  Zoom.Top := Y - dy;
  Zoom.Bottom := Y + dy;
  if EyedropperVisible then begin
    ZoomImage.Canvas.Polyline([Point(Zoom.Left,Zoom.Top),Point(Zoom.Right,Zoom.Top),
      Point(Zoom.Right,Zoom.Bottom),Point(Zoom.Left,Zoom.Bottom),Point(Zoom.Left,Zoom.Top)]);
  end
  else begin
    ZoomImage.Canvas.Polyline([Point(X,Zoom.Top),Point(X,Zoom.Bottom + byte((2*dy) mod 2 = 0))]);
    ZoomImage.Canvas.Polyline([Point(Zoom.Left,Y),Point(Zoom.Right + byte((2*dx) mod 2 = 0),Y)]);
  end;
end;

end.
