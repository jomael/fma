object ExceptionDialog: TExceptionDialog
  Left = 649
  Top = 262
  AutoScroll = False
  BorderIcons = [biSystemMenu]
  Caption = 'ExceptionDialog'
  ClientHeight = 255
  ClientWidth = 292
  Color = clBtnFace
  Constraints.MinWidth = 300
  ParentFont = True
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnPaint = FormPaint
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    292
    255)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TTntBevel
    Left = 0
    Top = 95
    Width = 292
    Height = 5
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object Label1: TTntLabel
    Left = 56
    Top = 16
    Width = 34
    Height = 13
    Caption = 'Wait...'
  end
  object TextLabel: TTntMemo
    Left = 56
    Top = 9
    Width = 229
    Height = 50
    Hint = 'Use Ctrl+C to copy the report to the Clipboard'
    Anchors = [akLeft, akTop, akRight]
    BorderStyle = bsNone
    Ctl3D = True
    ParentColor = True
    ParentCtl3D = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
    WantReturns = False
  end
  object DetailsMemo: TTntMemo
    Left = 4
    Top = 100
    Width = 284
    Height = 151
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
    WantReturns = False
    WordWrap = False
  end
  object Panel1: TTntPanel
    Left = 66
    Top = 60
    Width = 161
    Height = 29
    Anchors = [akTop]
    BevelOuter = bvNone
    TabOrder = 2
    object OkBtn: TTntButton
      Left = 4
      Top = 0
      Width = 73
      Height = 25
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
    end
    object DetailsBtn: TTntButton
      Left = 84
      Top = 0
      Width = 73
      Height = 25
      Hint = 'Show or hide additional information|'
      Caption = '*'
      Enabled = False
      TabOrder = 1
      OnClick = DetailsBtnClick
    end
  end
end
