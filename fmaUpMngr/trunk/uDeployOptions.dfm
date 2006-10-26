object frmDeployOptions: TfrmDeployOptions
  Left = 528
  Top = 315
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 229
  ClientWidth = 341
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  DesignSize = (
    341
    229)
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 252
    Top = 192
    Width = 77
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object GroupBox2: TGroupBox
    Left = 12
    Top = 8
    Width = 153
    Height = 89
    Caption = 'Use Compression'
    TabOrder = 0
    object rbCompressNone: TRadioButton
      Left = 12
      Top = 20
      Width = 134
      Height = 17
      Caption = 'None'
      TabOrder = 0
    end
    object rbCompressZLib: TRadioButton
      Left = 12
      Top = 40
      Width = 134
      Height = 17
      Caption = 'Z-LIB'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
    object rbCompressLh5: TRadioButton
      Left = 12
      Top = 60
      Width = 134
      Height = 17
      Caption = 'LH-5'
      Enabled = False
      TabOrder = 2
    end
  end
  object GroupBox3: TGroupBox
    Left = 176
    Top = 8
    Width = 153
    Height = 89
    Caption = 'Use Encryption'
    TabOrder = 1
    object rbEncryptNone: TRadioButton
      Left = 12
      Top = 20
      Width = 134
      Height = 17
      Caption = 'None'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rbEncryptXor: TRadioButton
      Left = 12
      Top = 40
      Width = 134
      Height = 17
      Caption = 'Simple'
      Enabled = False
      TabOrder = 1
    end
    object rbEncryptMore: TRadioButton
      Left = 12
      Top = 60
      Width = 134
      Height = 17
      Caption = 'Strong'
      Enabled = False
      TabOrder = 2
    end
  end
  object GroupBox4: TGroupBox
    Left = 12
    Top = 104
    Width = 317
    Height = 73
    Caption = 'Update Protection'
    TabOrder = 2
    object lblPassWord: TLabel
      Left = 104
      Top = 41
      Width = 34
      Height = 13
      Caption = 'Not set'
    end
    object rbPassNone: TRadioButton
      Left = 12
      Top = 20
      Width = 85
      Height = 17
      Caption = 'None'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rbPassWord: TRadioButton
      Left = 12
      Top = 40
      Width = 85
      Height = 17
      Caption = 'Password:'
      TabOrder = 1
    end
    object Button1: TButton
      Left = 204
      Top = 36
      Width = 101
      Height = 25
      Caption = 'Set &Password...'
      TabOrder = 2
      OnClick = Button1Click
    end
  end
end
