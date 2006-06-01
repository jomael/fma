object frmPassword: TfrmPassword
  Left = 488
  Top = 323
  BorderStyle = bsDialog
  Caption = 'Update Password'
  ClientHeight = 157
  ClientWidth = 269
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 12
    Width = 49
    Height = 13
    Caption = 'Password:'
  end
  object Label2: TLabel
    Left = 12
    Top = 60
    Width = 87
    Height = 13
    Caption = 'Confirm Password:'
  end
  object Edit1: TEdit
    Left = 12
    Top = 28
    Width = 245
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 12
    Top = 76
    Width = 245
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object Button1: TButton
    Left = 88
    Top = 120
    Width = 77
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 180
    Top = 120
    Width = 77
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
