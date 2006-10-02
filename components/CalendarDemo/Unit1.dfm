object Form1: TForm1
  Left = 475
  Top = 215
  BorderStyle = bsDialog
  Caption = 'Calendar Demo'
  ClientHeight = 286
  ClientWidth = 579
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 248
    Width = 47
    Height = 13
    Caption = 'Selection:'
  end
  object Label2: TLabel
    Left = 68
    Top = 248
    Width = 15
    Height = 13
    Caption = '     '
    Transparent = False
  end
  object Label3: TLabel
    Left = 12
    Top = 264
    Width = 36
    Height = 13
    Caption = 'Setting:'
  end
  object Label4: TLabel
    Left = 68
    Top = 264
    Width = 15
    Height = 13
    Caption = '     '
    Transparent = False
  end
  object SECalendar1: TSECalendar
    Left = 12
    Top = 12
    Width = 556
    Height = 227
    PopupMenu = PopupMenu1
    StartOfWeek = 0
    ColorObject = clSkyBlue
    ColorSelect = clInfoBk
    TabOrder = 0
    OnKeyDown = SECalendar1KeyDown
    OnSelChange = SECalendar1SelChange
  end
  object Button1: TButton
    Left = 488
    Top = 252
    Width = 80
    Height = 25
    Caption = 'Close'
    TabOrder = 1
    OnClick = Button1Click
  end
  object XPManifest1: TXPManifest
    Left = 498
    Top = 200
  end
  object PopupMenu1: TPopupMenu
    Left = 530
    Top = 200
    object AddSetting1: TMenuItem
      Caption = 'Add Setting...'
      OnClick = AddSetting1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object ClearSetting1: TMenuItem
      Caption = 'Clear Setting'
      OnClick = ClearSetting1Click
    end
  end
end
