object frmDeployOptions: TfrmDeployOptions
  Left = 528
  Top = 315
  Width = 301
  Height = 180
  Caption = 'Options'
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 204
    Top = 112
    Width = 77
    Height = 25
    Cancel = True
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object GroupBox2: TGroupBox
    Left = 12
    Top = 8
    Width = 129
    Height = 89
    Caption = 'Use Compression'
    TabOrder = 0
    object rbCompressNone: TRadioButton
      Left = 12
      Top = 20
      Width = 113
      Height = 17
      Caption = 'None'
      TabOrder = 0
    end
    object rbCompressZLib: TRadioButton
      Left = 12
      Top = 40
      Width = 113
      Height = 17
      Caption = 'Z-LIB'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
    object rbCompressLh5: TRadioButton
      Left = 12
      Top = 60
      Width = 113
      Height = 17
      Caption = 'LH-5'
      Enabled = False
      TabOrder = 2
    end
  end
  object GroupBox3: TGroupBox
    Left = 152
    Top = 8
    Width = 129
    Height = 89
    Caption = 'Use Encryption'
    TabOrder = 1
    object rbEncryptNone: TRadioButton
      Left = 12
      Top = 20
      Width = 113
      Height = 17
      Caption = 'None'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rbEncryptXor: TRadioButton
      Left = 12
      Top = 40
      Width = 113
      Height = 17
      Caption = 'Simple'
      Enabled = False
      TabOrder = 1
    end
    object rbEncryptMore: TRadioButton
      Left = 12
      Top = 60
      Width = 113
      Height = 17
      Caption = 'Strong'
      Enabled = False
      TabOrder = 2
    end
  end
end
