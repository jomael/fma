object frmOfflineProfile: TfrmOfflineProfile
  Left = 613
  Top = 284
  ActiveControl = TntListView1
  BorderStyle = bsDialog
  Caption = 'Database Manager - [Phones]'
  ClientHeight = 253
  ClientWidth = 429
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = TntFormShow
  DesignSize = (
    429
    253)
  PixelsPerInch = 96
  TextHeight = 13
  object TntLabel1: TTntLabel
    Left = 8
    Top = 180
    Width = 413
    Height = 37
    AutoSize = False
    Transparent = True
    WordWrap = True
  end
  object TntListView1: TTntListView
    Left = 8
    Top = 12
    Width = 333
    Height = 158
    Columns = <
      item
        Caption = 'Phone Friendly Name'
        Width = 210
      end
      item
        Caption = 'Database Format'
        Width = 100
      end>
    ColumnClick = False
    HideSelection = False
    ReadOnly = True
    SmallImages = Form1.ImageList2
    TabOrder = 0
    ViewStyle = vsReport
    OnDblClick = TntListView1DblClick
    OnKeyDown = TntListView1KeyDown
    OnSelectItem = TntListView1SelectItem
  end
  object btnOK: TTntButton
    Left = 272
    Top = 220
    Width = 69
    Height = 25
    Caption = '&Open'
    Enabled = False
    ModalResult = 1
    TabOrder = 5
  end
  object btnCancel: TTntButton
    Left = 352
    Top = 220
    Width = 69
    Height = 25
    Cancel = True
    Caption = '&Close'
    ModalResult = 2
    TabOrder = 6
  end
  object btnDelete: TTntButton
    Left = 352
    Top = 44
    Width = 69
    Height = 25
    Caption = '&Delete'
    Enabled = False
    TabOrder = 2
    OnClick = btnDeleteClick
  end
  object btnNew: TTntButton
    Left = 352
    Top = 12
    Width = 69
    Height = 25
    Caption = '&New...'
    TabOrder = 1
    OnClick = btnNewClick
  end
  object btnRepair: TTntButton
    Left = 352
    Top = 76
    Width = 69
    Height = 25
    Caption = '&Repair'
    Enabled = False
    TabOrder = 3
    OnClick = btnRepairClick
  end
  object NoItemsPanel: TTntPanel
    Left = 16
    Top = 36
    Width = 319
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvNone
    Caption = 'There are no items to display in this view.'
    Color = clWindow
    TabOrder = 7
    Visible = False
  end
  object btnProtect: TTntButton
    Left = 352
    Top = 144
    Width = 69
    Height = 25
    Caption = '&Protect'
    Enabled = False
    TabOrder = 4
    OnClick = btnProtectClick
  end
end
