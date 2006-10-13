object frmInputQuery: TfrmInputQuery
  Left = 592
  Top = 334
  ActiveControl = TntEdit1
  BorderStyle = bsDialog
  Caption = 'frmInputQuery'
  ClientHeight = 105
  ClientWidth = 361
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object TntLabel1: TTntLabel
    Left = 12
    Top = 12
    Width = 79
    Height = 13
    Caption = 'Enter text below:'
  end
  object TntEdit1: TTntEdit
    Left = 12
    Top = 32
    Width = 337
    Height = 21
    TabOrder = 0
  end
  object Button1: TTntButton
    Left = 184
    Top = 68
    Width = 77
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TTntButton
    Left = 272
    Top = 68
    Width = 77
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
