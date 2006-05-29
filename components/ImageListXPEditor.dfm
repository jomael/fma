object frmImageListXPEdt: TfrmImageListXPEdt
  Left = 589
  Top = 181
  Width = 461
  Height = 340
  BorderIcons = [biSystemMenu]
  Caption = 'Image Editor with XP Alpha Blending support'
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ImagesGroupBox: TGroupBox
    Left = 8
    Top = 128
    Width = 437
    Height = 177
    Caption = '&Images'
    TabOrder = 2
    object ImagesListView: TListView
      Left = 12
      Top = 20
      Width = 413
      Height = 81
      Columns = <>
      ColumnClick = False
      HideSelection = False
      IconOptions.Arrangement = iaLeft
      IconOptions.AutoArrange = True
      MultiSelect = True
      ReadOnly = True
      TabOrder = 0
      OnSelectItem = ImagesListViewSelectItem
    end
    object AddButton: TButton
      Left = 12
      Top = 108
      Width = 77
      Height = 25
      Caption = '&Add...'
      TabOrder = 1
      OnClick = AddButtonClick
    end
    object ReplaceButton: TButton
      Left = 96
      Top = 108
      Width = 77
      Height = 25
      Caption = '&Replace...'
      Enabled = False
      TabOrder = 2
      OnClick = ReplaceButtonClick
    end
    object DeleteButton: TButton
      Left = 264
      Top = 108
      Width = 77
      Height = 25
      Caption = '&Delete...'
      Enabled = False
      TabOrder = 4
      OnClick = DeleteButtonClick
    end
    object LeftButton: TButton
      Left = 12
      Top = 140
      Width = 77
      Height = 25
      Caption = 'Mo&ve Left'
      Enabled = False
      TabOrder = 6
      OnClick = LeftButtonClick
    end
    object RightButton: TButton
      Left = 96
      Top = 140
      Width = 77
      Height = 25
      Caption = '&Move Right'
      Enabled = False
      TabOrder = 7
      OnClick = RightButtonClick
    end
    object ClearButton: TButton
      Left = 348
      Top = 108
      Width = 77
      Height = 25
      Caption = 'Clear...'
      Enabled = False
      TabOrder = 5
      OnClick = ClearButtonClick
    end
    object SaveButton: TButton
      Left = 180
      Top = 108
      Width = 77
      Height = 25
      Caption = '&Save...'
      Enabled = False
      TabOrder = 3
      OnClick = SaveButtonClick
    end
    object ExportButton: TButton
      Left = 264
      Top = 140
      Width = 77
      Height = 25
      Caption = '&Export...'
      Enabled = False
      TabOrder = 9
      OnClick = ExportButtonClick
    end
    object ImportButton: TButton
      Left = 348
      Top = 140
      Width = 77
      Height = 25
      Caption = 'Imp&ort...'
      TabOrder = 10
      OnClick = ImportButtonClick
    end
    object AllButton: TButton
      Left = 180
      Top = 140
      Width = 77
      Height = 25
      Caption = 'Select All'
      Enabled = False
      TabOrder = 8
      OnClick = AllButtonClick
    end
  end
  object OkButton: TButton
    Left = 368
    Top = 12
    Width = 77
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 3
    OnClick = OkButtonClick
  end
  object CancelButton: TButton
    Left = 368
    Top = 40
    Width = 77
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
    OnClick = CancelButtonClick
  end
  object ApplyButton: TButton
    Left = 368
    Top = 68
    Width = 77
    Height = 25
    Caption = 'Apply'
    Enabled = False
    TabOrder = 5
    OnClick = ApplyButtonClick
  end
  object SelImageGroupBox: TGroupBox
    Left = 8
    Top = 8
    Width = 105
    Height = 113
    Caption = '&Selected Image'
    TabOrder = 0
    object Panel1: TPanel
      Left = 12
      Top = 20
      Width = 82
      Height = 82
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Color = clWindow
      TabOrder = 0
      object SelImage: TImage
        Left = 0
        Top = 0
        Width = 78
        Height = 78
        Align = alClient
        Center = True
        Proportional = True
        OnClick = SelImageClick
        OnMouseMove = SelImageMouseMove
      end
    end
  end
  object MagnifyGroupBox: TGroupBox
    Left = 120
    Top = 8
    Width = 237
    Height = 113
    Caption = 'Magnifying Glass'
    TabOrder = 1
    object ColorPanel: TPanel
      Left = 180
      Top = 20
      Width = 45
      Height = 82
      BevelOuter = bvNone
      BorderStyle = bsSingle
      TabOrder = 1
      object Label1: TLabel
        Left = 4
        Top = 6
        Width = 11
        Height = 13
        Caption = 'R:'
      end
      object Label3: TLabel
        Left = 4
        Top = 24
        Width = 11
        Height = 13
        Caption = 'G:'
      end
      object Label6: TLabel
        Left = 4
        Top = 42
        Width = 10
        Height = 13
        Caption = 'B:'
      end
      object lblColorR: TLabel
        Left = 19
        Top = 6
        Width = 18
        Height = 13
        Alignment = taRightJustify
        Caption = '255'
      end
      object lblColorG: TLabel
        Left = 19
        Top = 24
        Width = 18
        Height = 13
        Alignment = taRightJustify
        Caption = '255'
      end
      object lblColorB: TLabel
        Left = 19
        Top = 42
        Width = 18
        Height = 13
        Alignment = taRightJustify
        Caption = '255'
      end
      object Label2: TLabel
        Left = 4
        Top = 60
        Width = 10
        Height = 13
        Caption = 'T:'
      end
      object lblColorT: TLabel
        Left = 19
        Top = 60
        Width = 18
        Height = 13
        Alignment = taRightJustify
        Caption = '255'
      end
    end
    object ZoomPanel: TPanel
      Left = 12
      Top = 20
      Width = 161
      Height = 82
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Color = clWindow
      TabOrder = 0
      OnResize = ZoomPanelResize
      object ZoomImage: TImage
        Left = 0
        Top = 0
        Width = 157
        Height = 78
        Align = alClient
        Center = True
        Proportional = True
        Stretch = True
      end
    end
  end
  object HelpButton: TButton
    Left = 368
    Top = 96
    Width = 77
    Height = 25
    Caption = 'Help'
    Enabled = False
    TabOrder = 6
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Title = 'Import Images...'
    Left = 36
    Top = 172
  end
  object SavePictureDialog1: TSavePictureDialog
    DefaultExt = 'bmp'
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 72
    Top = 172
  end
end
