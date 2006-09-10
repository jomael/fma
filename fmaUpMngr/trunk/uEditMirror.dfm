object frmMirror: TfrmMirror
  Left = 429
  Top = 280
  BorderStyle = bsDialog
  Caption = 'Mirror'
  ClientHeight = 217
  ClientWidth = 406
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 12
    Width = 60
    Height = 13
    Caption = 'Mirror Name:'
  end
  object Label2: TLabel
    Left = 12
    Top = 64
    Width = 86
    Height = 13
    Caption = 'Server Base URL:'
  end
  object edName: TEdit
    Left = 12
    Top = 28
    Width = 381
    Height = 21
    TabOrder = 0
  end
  object mmoURL: TMemo
    Left = 12
    Top = 80
    Width = 381
    Height = 85
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Button1: TButton
    Left = 224
    Top = 180
    Width = 77
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 316
    Top = 180
    Width = 77
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object cbDefault: TCheckBox
    Left = 12
    Top = 182
    Width = 105
    Height = 17
    Caption = 'Default mirror'
    TabOrder = 2
  end
end
