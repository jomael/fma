object frmDiffOptions: TfrmDiffOptions
  Left = 449
  Top = 232
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 385
  ClientWidth = 341
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 12
    Top = 8
    Width = 317
    Height = 149
    Caption = 'Engine Optimization'
    TabOrder = 0
    object Label1: TLabel
      Left = 124
      Top = 88
      Width = 20
      Height = 13
      Caption = 'Fast'
    end
    object Label2: TLabel
      Left = 274
      Top = 88
      Width = 23
      Height = 13
      Alignment = taRightJustify
      Caption = 'Slow'
    end
    object Label3: TLabel
      Left = 12
      Top = 108
      Width = 35
      Height = 13
      Caption = 'Details:'
    end
    object lblOptimize: TLabel
      Left = 64
      Top = 108
      Width = 245
      Height = 33
      AutoSize = False
      WordWrap = True
    end
    object rbFastBuild: TRadioButton
      Left = 12
      Top = 20
      Width = 264
      Height = 17
      Caption = 'Fast Building'
      TabOrder = 0
      OnClick = rbBuildClick
    end
    object rbSmallBuild: TRadioButton
      Left = 12
      Top = 40
      Width = 264
      Height = 17
      Caption = 'Smaller Update (Recommended)'
      TabOrder = 1
      OnClick = rbBuildClick
    end
    object rbCustomBuild: TRadioButton
      Left = 12
      Top = 60
      Width = 109
      Height = 17
      Caption = 'Custom setting:'
      Checked = True
      TabOrder = 2
      TabStop = True
      OnClick = rbBuildClick
    end
    object tbSpeedIndex: TTrackBar
      Left = 124
      Top = 59
      Width = 173
      Height = 29
      Min = 1
      Position = 6
      TabOrder = 3
      ThumbLength = 18
      OnChange = tbSpeedIndexChange
    end
  end
  object GroupBox2: TGroupBox
    Left = 12
    Top = 164
    Width = 153
    Height = 89
    Caption = 'Update Compression'
    TabOrder = 1
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
      TabOrder = 2
    end
  end
  object GroupBox3: TGroupBox
    Left = 176
    Top = 164
    Width = 153
    Height = 89
    Caption = 'Update Encryption'
    TabOrder = 2
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
  object GroupBox4: TGroupBox
    Left = 12
    Top = 260
    Width = 317
    Height = 73
    Caption = 'Update Protection'
    TabOrder = 3
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
  object btnOK: TButton
    Left = 252
    Top = 348
    Width = 77
    Height = 25
    Cancel = True
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
end
