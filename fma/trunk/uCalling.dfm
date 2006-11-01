object frmCalling: TfrmCalling
  Left = 417
  Top = 250
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  ActiveControl = HandupButton
  AlphaBlend = True
  AlphaBlendValue = 200
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Calling'
  ClientHeight = 137
  ClientWidth = 329
  Color = cl3DLight
  Constraints.MaxHeight = 415
  Constraints.MaxWidth = 397
  Constraints.MinHeight = 164
  Constraints.MinWidth = 337
  ParentFont = True
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    329
    137)
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TTntImage
    Left = -33
    Top = -3
    Width = 394
    Height = 386
    Anchors = [akTop]
  end
  object lbAlpha: TTntLabel
    Left = 140
    Top = 4
    Width = 26
    Height = 13
    Caption = 'None'
    Transparent = True
  end
  object lbNumber: TTntLabel
    Left = 140
    Top = 20
    Width = 26
    Height = 13
    Caption = 'None'
    Transparent = True
  end
  object lblTime: TTntLabel
    Left = 140
    Top = 36
    Width = 27
    Height = 13
    Caption = '00:00'
    Transparent = True
  end
  object HandupButton: TTntButton
    Left = 267
    Top = 112
    Width = 58
    Height = 21
    Anchors = [akRight, akBottom]
    Caption = 'Hang Up'
    TabOrder = 1
    OnClick = CallButtonClick
  end
  object AnswerButton: TTntButton
    Left = 203
    Top = 112
    Width = 58
    Height = 21
    Anchors = [akRight, akBottom]
    Caption = 'Answer'
    TabOrder = 0
    OnClick = CallButtonClick
  end
  object HeadsetButton: TTntButton
    Left = 139
    Top = 112
    Width = 58
    Height = 21
    Anchors = [akRight, akBottom]
    Caption = 'Headset'
    TabOrder = 5
    OnClick = CallButtonClick
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
    TabOrder = 3
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
  object MediaPlayer1: TMediaPlayer
    Left = 288
    Top = 12
    Width = 29
    Height = 28
    VisibleButtons = [btPlay]
    Visible = False
    TabOrder = 4
    OnNotify = MediaPlayer1Notify
  end
  object Memo: TTntMemo
    Left = 140
    Top = 56
    Width = 185
    Height = 45
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkTile
    BorderStyle = bsNone
    ScrollBars = ssVertical
    TabOrder = 2
    Visible = False
  end
  object FormPlacement1: TFormPlacement
    IniFileName = 'Software\floAt\MobileAgent'
    IniSection = 'NewCallWindow'
    UseRegistry = True
    Left = 256
    Top = 12
  end
  object TimeTimer: TTimer
    Enabled = False
    OnTimer = TimeTimerTimer
    Left = 224
    Top = 12
  end
end
