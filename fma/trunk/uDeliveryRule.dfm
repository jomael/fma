object frmSMSRule: TfrmSMSRule
  Left = 509
  Top = 225
  ActiveControl = edName
  BorderStyle = bsDialog
  Caption = 'Rule'
  ClientHeight = 381
  ClientWidth = 345
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object TntLabel27: TTntLabel
    Left = 8
    Top = 226
    Width = 63
    Height = 13
    Caption = 'Target folder:'
  end
  object TntLabel1: TTntLabel
    Left = 8
    Top = 10
    Width = 54
    Height = 13
    Caption = 'Rule name:'
  end
  object TntLabel26: TTntLabel
    Left = 8
    Top = 58
    Width = 77
    Height = 13
    Caption = 'Correspondents:'
  end
  object TntLabel2: TTntLabel
    Left = 8
    Top = 312
    Width = 329
    Height = 33
    AutoSize = False
    Caption = 
      'All messages sent to or received from selected Correspondents wi' +
      'll be stored into Target Folder above.'
    WordWrap = True
  end
  object edName: TTntEdit
    Left = 8
    Top = 28
    Width = 329
    Height = 21
    TabOrder = 0
  end
  object edFolder: TTntEdit
    Left = 8
    Top = 244
    Width = 329
    Height = 21
    ReadOnly = True
    TabOrder = 3
  end
  object btnBrowse: TTntButton
    Left = 260
    Top = 272
    Width = 77
    Height = 25
    Caption = 'Bro&wse...'
    TabOrder = 4
    OnClick = btnBrowseClick
  end
  object btnContacts: TTntButton
    Left = 224
    Top = 196
    Width = 113
    Height = 25
    Caption = '&Select Contacts...'
    TabOrder = 2
    OnClick = btnContactsClick
  end
  object btnOK: TTntButton
    Left = 188
    Top = 348
    Width = 69
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 5
    OnClick = btnOKClick
  end
  object btnCancel: TTntButton
    Left = 268
    Top = 348
    Width = 69
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 6
  end
  object lvContacts: TTntListView
    Left = 8
    Top = 76
    Width = 329
    Height = 113
    Columns = <
      item
        Caption = 'Name'
        Width = 175
      end
      item
        Caption = 'Phone'
        Width = 130
      end>
    ColumnClick = False
    HideSelection = False
    MultiSelect = True
    ReadOnly = True
    SmallImages = Form1.ImageList1
    SortType = stText
    TabOrder = 1
    ViewStyle = vsReport
  end
end
