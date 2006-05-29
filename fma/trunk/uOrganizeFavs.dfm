object frmOrganizeFavs: TfrmOrganizeFavs
  Left = 576
  Top = 397
  BorderStyle = bsDialog
  Caption = 'Organize Favorites'
  ClientHeight = 289
  ClientWidth = 398
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TTntLabel
    Left = 8
    Top = 8
    Width = 185
    Height = 53
    AutoSize = False
    Caption = 
      'To create a new item click on Add button. To delete or arrange a' +
      'n item select it from the list then click on Remove, Move Up or ' +
      'Move Down.'
    WordWrap = True
  end
  object TreeView1: TTntTreeView
    Left = 204
    Top = 8
    Width = 185
    Height = 237
    HideSelection = False
    Images = Form1.ImageList1
    Indent = 19
    PopupMenu = PopupMenu1
    ReadOnly = True
    ShowButtons = False
    ShowRoot = False
    TabOrder = 4
    ToolTips = False
    OnChange = TreeView1Change
    OnDblClick = btnAddClick
  end
  object btnAdd: TTntButton
    Left = 8
    Top = 72
    Width = 89
    Height = 25
    Caption = '&Add...'
    TabOrder = 0
    OnClick = btnAddClick
  end
  object btnRemove: TTntButton
    Left = 8
    Top = 104
    Width = 89
    Height = 25
    Caption = '&Remove'
    Enabled = False
    TabOrder = 1
    OnClick = btnRemoveClick
  end
  object btnUp: TTntButton
    Tag = -1
    Left = 104
    Top = 72
    Width = 89
    Height = 25
    Caption = 'Move &Up'
    Enabled = False
    TabOrder = 2
    OnClick = btnUpDownClick
  end
  object btnDown: TTntButton
    Tag = 1
    Left = 104
    Top = 104
    Width = 89
    Height = 25
    Caption = 'Move &Down'
    Enabled = False
    TabOrder = 3
    OnClick = btnUpDownClick
  end
  object btnOk: TTntButton
    Left = 228
    Top = 256
    Width = 77
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 5
  end
  object btnCancel: TTntButton
    Left = 312
    Top = 256
    Width = 77
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 6
  end
  object TntGroupBox1: TTntGroupBox
    Left = 8
    Top = 136
    Width = 185
    Height = 109
    Caption = 'Selection'
    TabOrder = 7
    object mmoDetails: TTntMemo
      Left = 6
      Top = 18
      Width = 173
      Height = 83
      BorderStyle = bsNone
      ParentColor = True
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      WordWrap = False
    end
  end
  object PopupMenu1: TTntPopupMenu
    Images = Form1.ImageList2
    OnPopup = PopupMenu1Popup
    Left = 8
    Top = 252
    object Add1: TTntMenuItem
      Caption = '&Add...'
      ImageIndex = 21
      OnClick = Add1Click
    end
    object N2: TTntMenuItem
      Caption = '-'
    end
    object Delete1: TTntMenuItem
      Caption = '&Remove'
      ImageIndex = 6
      OnClick = btnRemoveClick
    end
    object N1: TTntMenuItem
      Caption = '-'
    end
    object Edit1: TTntMenuItem
      Caption = '&Properties'
      ImageIndex = 10
      OnClick = btnAddClick
    end
  end
end
