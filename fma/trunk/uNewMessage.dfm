object frmNewMessage: TfrmNewMessage
  Left = 427
  Top = 256
  Width = 337
  Height = 164
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  ActiveControl = OkButton
  AlphaBlend = True
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = 'SMS Received'
  Color = clBtnFace
  Constraints.MaxHeight = 368
  Constraints.MaxWidth = 370
  Constraints.MinHeight = 164
  Constraints.MinWidth = 337
  ParentFont = True
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDefaultPosOnly
  ShowHint = True
  OnActivate = OnMouseEnter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnShow = FormShow
  DesignSize = (
    329
    137)
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TTntImage
    Left = -34
    Top = -20
    Width = 394
    Height = 386
    Anchors = [akTop]
  end
  object lbText: TTntLabel
    Left = 140
    Top = 20
    Width = 21
    Height = 13
    Caption = 'Text'
    ShowAccelChar = False
    Transparent = True
    OnDblClick = ReplyBackClick
    OnMouseEnter = OnMouseEnter
    OnMouseLeave = OnMouseLeave
  end
  object lbAlpha: TTntLabel
    Left = 140
    Top = 4
    Width = 35
    Height = 13
    Caption = 'lbAlpha'
    Transparent = True
  end
  object OkButton: TTntButton
    Left = 267
    Top = 112
    Width = 58
    Height = 21
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Close'
    TabOrder = 3
    OnClick = OkButtonClick
  end
  object ActionButton: TTntButton
    Left = 139
    Top = 112
    Width = 58
    Height = 21
    Anchors = [akRight, akBottom]
    Caption = 'More '#187
    TabOrder = 1
    OnClick = ActionButtonClick
  end
  object ImagePanel: TTntPanel
    Left = 4
    Top = 4
    Width = 132
    Height = 131
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Caption = '<no photo>'
    Color = cl3DLight
    TabOrder = 0
    object Image32: TImage32
      Left = 2
      Top = 2
      Width = 128
      Height = 127
      Align = alClient
      BitmapAlign = baCenter
      Scale = 1.000000000000000000
      ScaleMode = smResize
      TabOrder = 0
    end
  end
  object AnswerButton: TTntButton
    Left = 203
    Top = 112
    Width = 58
    Height = 21
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Reply'
    TabOrder = 2
    OnClick = ReplyBackClick
  end
  object FormPlacement1: TFormPlacement
    IniFileName = 'Software\floAt\MobileAgent'
    IniSection = 'NewMsgWindow'
    UseRegistry = True
    Left = 256
    Top = 16
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 288
    Top = 16
  end
  object PopupMenu1: TTntPopupMenu
    Images = Form1.ImageList2
    OnPopup = PopupMenu1Popup
    Left = 224
    Top = 16
    object ReplyBack: TTntMenuItem
      Caption = '&Reply'
      ImageIndex = 3
      OnClick = ReplyBackClick
    end
    object Forward1: TTntMenuItem
      Caption = '&Forward'
      ImageIndex = 4
      OnClick = Forward1Click
    end
    object Chat1: TTntMenuItem
      Caption = 'Chat Contact...'
      ImageIndex = 21
      OnClick = Chat1Click
    end
    object N1: TTntMenuItem
      Caption = '-'
    end
    object AddContact1: TTntMenuItem
      Caption = '&Add To Phonebook...'
      ImageIndex = 20
      OnClick = AddContact1Click
    end
    object N2: TTntMenuItem
      Caption = '-'
    end
    object Delete1: TTntMenuItem
      Caption = '&Delete'
      ImageIndex = 6
      OnClick = Delete1Click
    end
    object N3: TTntMenuItem
      Caption = '-'
    end
    object CallContact1: TTntMenuItem
      Caption = '&Call Contact...'
      ImageIndex = 62
      OnClick = CallContact1Click
    end
  end
end
