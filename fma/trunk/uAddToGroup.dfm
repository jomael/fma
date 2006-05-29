object frmAddToGroup: TfrmAddToGroup
  Left = 422
  Top = 208
  BorderStyle = bsDialog
  Caption = 'Add To Group Wizard'
  ClientHeight = 356
  ClientWidth = 493
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TTntBevel
    Left = 0
    Top = 314
    Width = 493
    Height = 9
    Align = alTop
    Shape = bsTopLine
  end
  object Button1: TTntButton
    Left = 316
    Top = 324
    Width = 77
    Height = 25
    Caption = '&Finish'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TTntButton
    Left = 404
    Top = 324
    Width = 77
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Panel1: TTntPanel
    Left = 0
    Top = 0
    Width = 493
    Height = 314
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 2
    object Label1: TTntLabel
      Left = 176
      Top = 84
      Width = 42
      Height = 13
      Caption = 'Contact:'
    end
    object lblName: TTntLabel
      Left = 228
      Top = 84
      Width = 42
      Height = 13
      Caption = '<name>'
    end
    object Label2: TTntLabel
      Left = 176
      Top = 104
      Width = 33
      Height = 13
      Caption = 'Group:'
    end
    object lblGroup: TTntLabel
      Left = 228
      Top = 104
      Width = 28
      Height = 13
      Caption = 'group'
    end
    object Image1: TTntImage
      Left = 0
      Top = 0
      Width = 164
      Height = 314
      Align = alLeft
      AutoSize = True
      Center = True
    end
    object Label3: TTntLabel
      Left = 176
      Top = 44
      Width = 305
      Height = 33
      AutoSize = False
      Caption = 
        'This wizard will help you add a contact to a group. You can use ' +
        'default contact'#39's number or select from a numbers list below.'
      Transparent = True
      WordWrap = True
    end
    object lbProductName: TTntLabel
      Left = 176
      Top = 12
      Width = 135
      Height = 25
      Caption = 'Add to group'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblNumber: TTntLabel
      Left = 192
      Top = 152
      Width = 36
      Height = 13
      Caption = '<num>'
    end
    object RadioButton1: TTntRadioButton
      Left = 176
      Top = 128
      Width = 125
      Height = 17
      Caption = 'Use default number:'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = RadioButtonClick
    end
    object RadioButton2: TTntRadioButton
      Left = 176
      Top = 176
      Width = 133
      Height = 17
      Caption = 'Use custom numbers:'
      TabOrder = 1
      OnClick = RadioButtonClick
    end
    object clNumbers: TTntCheckListBox
      Left = 192
      Top = 204
      Width = 289
      Height = 69
      Enabled = False
      ItemHeight = 13
      TabOrder = 2
    end
    object RadioButton3: TTntRadioButton
      Left = 176
      Top = 284
      Width = 137
      Height = 17
      Caption = 'Use all phone numbers'
      TabOrder = 3
      OnClick = RadioButtonClick
    end
  end
  object Button3: TTntButton
    Left = 239
    Top = 324
    Width = 77
    Height = 25
    Caption = '< &Previous'
    Enabled = False
    TabOrder = 3
  end
end
