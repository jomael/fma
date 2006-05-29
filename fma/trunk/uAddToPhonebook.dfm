object frmAddContact: TfrmAddContact
  Left = 422
  Top = 219
  ActiveControl = RadioButton1
  BorderStyle = bsDialog
  Caption = 'Add To Phonebook Wizard'
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
  object btnOk: TTntButton
    Left = 316
    Top = 324
    Width = 77
    Height = 25
    Caption = '&Finish'
    TabOrder = 0
    OnClick = btnOkClick
  end
  object btnCancel: TTntButton
    Left = 404
    Top = 324
    Width = 77
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
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
    object Image1: TTntImage
      Left = 0
      Top = 0
      Width = 164
      Height = 314
      Align = alLeft
      AutoSize = True
      Center = True
    end
    object Label4: TTntLabel
      Left = 176
      Top = 44
      Width = 305
      Height = 33
      AutoSize = False
      Caption = 
        'This wizard will help you add a number to your phonebook. You co' +
        'uld create a new contact or modify an existing one.'
      Transparent = True
      WordWrap = True
    end
    object lbProductName: TTntLabel
      Left = 176
      Top = 12
      Width = 190
      Height = 25
      Caption = 'Add to phonebook'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label1: TTntLabel
      Left = 176
      Top = 84
      Width = 37
      Height = 13
      Caption = 'Number'
    end
    object lblNumber: TTntLabel
      Left = 220
      Top = 84
      Width = 32
      Height = 13
      Caption = '<num>'
    end
    object edContact: TTntEdit
      Left = 192
      Top = 160
      Width = 289
      Height = 21
      Enabled = False
      ParentColor = True
      ReadOnly = True
      TabOrder = 0
    end
    object btnSelect: TTntButton
      Left = 404
      Top = 188
      Width = 77
      Height = 25
      Caption = 'B&rowse...'
      Enabled = False
      TabOrder = 1
      OnClick = btnSelectClick
    end
    object RadioButton1: TTntRadioButton
      Left = 176
      Top = 108
      Width = 121
      Height = 17
      Caption = 'As a New Contact'
      Checked = True
      TabOrder = 2
      TabStop = True
      OnClick = RadioButtonClick
    end
    object RadioButton2: TTntRadioButton
      Left = 176
      Top = 132
      Width = 165
      Height = 17
      Caption = 'Modify an Existing Contact:'
      TabOrder = 3
      OnClick = RadioButtonClick
    end
    object rgPhoneType: TTntRadioGroup
      Left = 192
      Top = 224
      Width = 289
      Height = 73
      Caption = 'Save As'
      Columns = 3
      Enabled = False
      ItemIndex = 0
      Items.Strings = (
        'Cell Phone'
        'Work Phone'
        'Home Phone'
        'Fax Number'
        'Other')
      TabOrder = 4
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
