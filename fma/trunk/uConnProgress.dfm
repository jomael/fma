object frmConnect: TfrmConnect
  Left = 469
  Top = 272
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Progress'
  ClientHeight = 165
  ClientWidth = 389
  Color = clBtnFace
  ParentFont = True
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object AbortButton: TTntButton
    Left = 308
    Top = 134
    Width = 73
    Height = 25
    Caption = '&Abort'
    TabOrder = 3
    OnClick = AbortButtonClick
  end
  object HideButton: TTntButton
    Left = 224
    Top = 134
    Width = 73
    Height = 25
    Caption = '&Hide'
    TabOrder = 2
    OnClick = HideButtonClick
  end
  object ListTasks: TVirtualDrawTree
    Left = 8
    Top = 8
    Width = 373
    Height = 118
    DefaultNodeHeight = 32
    Header.AutoSizeIndex = 0
    Header.Font.Charset = RUSSIAN_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoVisible]
    Header.Style = hsFlatButtons
    TabOrder = 0
    TreeOptions.PaintOptions = [toHideFocusRect, toHideSelection, toShowButtons, toShowDropmark, toShowHorzGridLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toFullRowSelect]
    OnDrawNode = ListTasksDrawNode
    OnFreeNode = ListTasksFreeNode
    Columns = <
      item
        Position = 0
        Width = 279
        WideText = 'Task'
      end
      item
        Position = 1
        Width = 90
        WideText = 'Progress'
      end>
  end
  object cbDontShow: TTntCheckBox
    Left = 8
    Top = 138
    Width = 161
    Height = 17
    Caption = 'Don'#39't show it again'
    TabOrder = 1
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = Timer2Timer
    Left = 60
    Top = 56
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 30
    OnTimer = Timer1Timer
    Left = 28
    Top = 56
  end
end
