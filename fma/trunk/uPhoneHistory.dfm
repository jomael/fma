object frmPhoneHistory: TfrmPhoneHistory
  Left = 634
  Top = 286
  BorderStyle = bsToolWindow
  Caption = 'Numbers History'
  ClientHeight = 217
  ClientWidth = 353
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object TntBevel1: TTntBevel
    Left = 0
    Top = 172
    Width = 353
    Height = 9
    Shape = bsTopLine
  end
  object lvPhones: TTntListView
    Left = 8
    Top = 12
    Width = 253
    Height = 150
    Columns = <
      item
        Caption = 'Phone Number'
        Width = 230
      end>
    ColumnClick = False
    MultiSelect = True
    ReadOnly = True
    TabOrder = 0
    ViewStyle = vsReport
    OnDblClick = lvPhonesDblClick
    OnKeyDown = lvPhonesKeyDown
    OnSelectItem = lvPhonesSelectItem
  end
  object NewButton: TTntButton
    Left = 272
    Top = 12
    Width = 73
    Height = 25
    Caption = '&New'
    TabOrder = 1
    OnClick = NewButtonClick
  end
  object EditButton: TTntButton
    Left = 272
    Top = 44
    Width = 73
    Height = 25
    Caption = 'C&hange'
    Enabled = False
    TabOrder = 2
    OnClick = EditButtonClick
  end
  object DeleteButton: TTntButton
    Left = 272
    Top = 76
    Width = 73
    Height = 25
    Caption = '&Delete'
    Enabled = False
    TabOrder = 3
    OnClick = DeleteButtonClick
  end
  object OkButton: TTntButton
    Left = 188
    Top = 184
    Width = 73
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 4
  end
  object CancelButton: TTntButton
    Left = 272
    Top = 184
    Width = 73
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 5
  end
end
