object frmMessageContact: TfrmMessageContact
  Left = 529
  Top = 330
  Width = 364
  Height = 274
  AlphaBlend = True
  AlphaBlendValue = 210
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = 'New Message'
  Color = clBtnFace
  Constraints.MinHeight = 220
  Constraints.MinWidth = 364
  ParentFont = True
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnActivate = FormActivate
  OnCloseQuery = TntFormCloseQuery
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 356
    Height = 64
    AutoSize = True
    BandMaximize = bmNone
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 36
        Width = 352
      end
      item
        Control = ToolBar2
        ImageIndex = -1
        MinHeight = 22
        Width = 352
      end>
    object ToolBar1: TToolBar
      Left = 9
      Top = 0
      Width = 339
      Height = 36
      AutoSize = True
      ButtonHeight = 36
      ButtonWidth = 42
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      Images = Form1.ImageList2
      ShowCaptions = True
      TabOrder = 0
      TabStop = True
      Wrapable = False
      object btnSend: TToolButton
        Left = 0
        Top = 0
        Hint = 'Send Message Immediately'
        Caption = 'Sen&d'
        ImageIndex = 38
        OnClick = SendClick
      end
      object ToolButton6: TToolButton
        Left = 42
        Top = 0
        Width = 8
        Caption = 'ToolButton6'
        ImageIndex = 5
        Style = tbsSeparator
      end
      object btnSave: TToolButton
        Left = 50
        Top = 0
        Hint = 'Save Message in Drafts'
        Caption = 'Save'
        Enabled = False
        ImageIndex = 44
        OnClick = SaveClick
      end
      object ToolButton8: TToolButton
        Left = 92
        Top = 0
        Width = 8
        Caption = 'ToolButton8'
        ImageIndex = 9
        Style = tbsSeparator
      end
      object ToolButton5: TToolButton
        Left = 100
        Top = 0
        Hint = 'Clear this Message'
        Caption = '&Clear'
        ImageIndex = 6
        OnClick = ClearClick
      end
      object ToolButton9: TToolButton
        Left = 142
        Top = 0
        Width = 8
        Caption = 'ToolButton9'
        ImageIndex = 7
        Style = tbsSeparator
      end
      object btnStatusReport: TToolButton
        Left = 150
        Top = 0
        Hint = 'Request Status Report'
        AllowAllUp = True
        Caption = 'Report'
        ImageIndex = 0
        Style = tbsCheck
      end
      object btnRequestReply: TToolButton
        Left = 192
        Top = 0
        Hint = 'Request Reply'
        AllowAllUp = True
        Caption = 'Answer'
        ImageIndex = 3
        Style = tbsCheck
      end
      object ToolButton1: TToolButton
        Left = 234
        Top = 0
        Width = 8
        Caption = 'ToolButton1'
        ImageIndex = 4
        Style = tbsSeparator
      end
      object btnLongSMS: TToolButton
        Left = 242
        Top = 0
        Hint = 'Send as Long Message'
        AllowAllUp = True
        Caption = 'Long'
        ImageIndex = 45
        Style = tbsCheck
        OnClick = LongClick
      end
      object btnFlashSMS: TToolButton
        Left = 284
        Top = 0
        Hint = 'Send as Flash Message'
        AllowAllUp = True
        Caption = 'Flash'
        ImageIndex = 4
        Style = tbsCheck
      end
    end
    object ToolBar2: TToolBar
      Left = 9
      Top = 38
      Width = 339
      Height = 22
      AutoSize = True
      ButtonWidth = 70
      Caption = 'ToolBar2'
      EdgeBorders = []
      Flat = True
      Images = Form1.ImageList2
      List = True
      ShowCaptions = True
      TabOrder = 1
      TabStop = True
      Wrapable = False
      OnResize = ToolBar2Resize
      DesignSize = (
        339
        22)
      object btnTo: TToolButton
        Left = 0
        Top = 0
        AutoSize = True
        Caption = '&To...'
        ImageIndex = 46
        OnClick = ToClick
      end
      object Edit1: TTntEdit
        Left = 53
        Top = 0
        Width = 199
        Height = 22
        Anchors = []
        AutoSize = False
        PopupMenu = ToPopupMenu
        TabOrder = 0
        OnChange = Edit1Change
        OnClick = Edit1Click
        OnDragDrop = Edit1DragDrop
        OnDragOver = Edit1DragOver
      end
      object btnRecent: TToolButton
        Left = 252
        Top = 0
        Hint = 'Select Recent Recipients'
        AutoSize = True
        Caption = 'Favorites'
        DropdownMenu = FavoritesPopupMenu
        ImageIndex = 18
        OnClick = btnRecentClick
      end
    end
  end
  object StatusBar: TTntStatusBar
    Left = 0
    Top = 229
    Width = 356
    Height = 18
    Panels = <
      item
        Alignment = taCenter
        Width = 100
      end
      item
        Alignment = taCenter
        Width = 50
      end
      item
        Width = 50
      end>
    ParentColor = True
    ParentFont = True
    PopupMenu = EncodingPopupMenu1
    UseSystemFont = False
  end
  object Memo: TTntMemo
    Left = 0
    Top = 85
    Width = 356
    Height = 144
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 2
    OnChange = MemoChange
    OnKeyPress = MemoKeyPress
  end
  object WarningPanel: TTntPanel
    Left = 0
    Top = 64
    Width = 356
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    BorderWidth = 1
    TabOrder = 3
    object Panel1: TTntPanel
      Left = 1
      Top = 1
      Width = 354
      Height = 19
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Color = clInfoBk
      PopupMenu = PopupMenu2
      TabOrder = 0
      object Image1: TTntImage
        Left = 3
        Top = 1
        Width = 16
        Height = 16
        AutoSize = True
        Picture.Data = {
          07544269746D617036030000424D360300000000000036000000280000001000
          000010000000010018000000000000030000120B0000120B0000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000AAAAAA999999777777000000
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF000000CCCCCC777777888888000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000AAAAAA999999777777000000
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF000000336666336666336666000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000AADDDD7DC3C368A6A6000000
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF000000BBEEEEBBEEEE7DC3C3000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000BBEEEECCFFFFCCFFFFAADDDD68A6A6
          000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
          00BBEEEECCFFFFFFFFFFBBEEEE7DC3C3000000FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFF000000BBEEEEFFFFFFFFFFFF33FFFFFFFFFFCCFFFF
          68A6A6000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000BBEE
          EEFFFFFF33FFFFFFFFFF33FFFFFFFFFF68A6A6000000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFF000000AADDDDBBEEEECCFFFFFFFFFFBBEEEE7DC3C3
          68A6A6000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
          00AADDDDBBEEEEAADDDD7DC3C368A6A6000000FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF}
        Transparent = True
      end
      object lbWarning: TTntLabel
        Left = 23
        Top = 2
        Width = 49
        Height = 13
        Caption = '<warning>'
      end
    end
  end
  object FormPlacement1: TFormPlacement
    IniFileName = 'Software\floAt\MobileAgent'
    IniSection = 'MessageWindow'
    UseRegistry = True
    Left = 204
    Top = 128
  end
  object FavoritesPopupMenu: TTntPopupMenu
    AutoHotkeys = maManual
    Images = Form1.ImageList1
    OnPopup = FavoritesPopupMenuPopup
    Left = 172
    Top = 128
    object AddToFavorites1: TTntMenuItem
      Caption = 'Add to Favorites'
      ImageIndex = 20
      OnClick = AddToFavorites1Click
    end
    object Organize1: TTntMenuItem
      Caption = 'Organize Favorites...'
      ImageIndex = 5
      OnClick = Organize1Click
    end
    object N2: TTntMenuItem
      Caption = '-'
    end
  end
  object PopupMenu2: TTntPopupMenu
    OnPopup = PopupMenu2Popup
    Left = 140
    Top = 128
    object ClearMessageCounter1: TTntMenuItem
      Caption = 'Clear Message Counter'
      OnClick = ClearMessageCounter1Click
    end
  end
  object ToPopupMenu: TTntPopupMenu
    Images = Form1.ImageList2
    OnPopup = ToPopupMenuPopup
    Left = 108
    Top = 128
    object Add1: TTntMenuItem
      Caption = 'Select Recepients...'
      ImageIndex = 51
      OnClick = ToClick
    end
    object N3: TTntMenuItem
      Caption = '-'
    end
    object AddToPhonebook1: TTntMenuItem
      Caption = '&Add To Phonebook...'
      ImageIndex = 20
      OnClick = AddToPhonebook1Click
    end
    object N1: TTntMenuItem
      Caption = '-'
    end
    object Delete1: TTntMenuItem
      Caption = 'Delete'
      ImageIndex = 6
      OnClick = Delete1Click
    end
  end
  object EncodingPopupMenu1: TTntPopupMenu
    OnPopup = EncodingPopupMenu1Popup
    Left = 236
    Top = 128
    object ForceUCS2Encoding1: TTntMenuItem
      Caption = 'Force UCS-2'
      OnClick = UCS2Click
    end
  end
end
