object Form1: TForm1
  Left = 474
  Top = 218
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
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 256
    Width = 47
    Height = 13
    Caption = 'Selection:'
  end
  object Label2: TLabel
    Left = 68
    Top = 256
    Width = 413
    Height = 29
    AutoSize = False
    WordWrap = True
  end
  object SECalendar1: TSECalendar
    Left = 12
    Top = 12
    Width = 556
    Height = 227
    StartOfWeek = 0
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
    Left = 452
    Top = 252
  end
end
