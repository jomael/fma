object frmBrowseFolders: TfrmBrowseFolders
  Left = 445
  Top = 259
  BorderStyle = bsDialog
  Caption = 'Browse For a Folder'
  ClientHeight = 265
  ClientWidth = 321
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblPath: TTntLabel
    Left = 52
    Top = 12
    Width = 261
    Height = 28
    AutoSize = False
    Caption = '*'
    WordWrap = True
  end
  object TntLabel1: TTntLabel
    Left = 8
    Top = 12
    Width = 34
    Height = 13
    Caption = 'Target:'
  end
  object btnNewFolder: TTntButton
    Left = 8
    Top = 232
    Width = 105
    Height = 25
    Caption = '&New Folder...'
    Enabled = False
    TabOrder = 1
    Visible = False
    OnClick = btnNewFolderClick
  end
  object btnOK: TTntButton
    Left = 164
    Top = 232
    Width = 69
    Height = 25
    Caption = 'OK'
    Enabled = False
    ModalResult = 1
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnCancel: TTntButton
    Left = 244
    Top = 232
    Width = 69
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object tvFolders: TVirtualStringTree
    Left = 8
    Top = 40
    Width = 305
    Height = 181
    BevelInner = bvLowered
    BevelOuter = bvNone
    ChangeDelay = 100
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.MainColumn = -1
    Header.Options = [hoColumnResize, hoDrag]
    Images = Form1.ImageList1
    Indent = 19
    TabOrder = 0
    TreeOptions.MiscOptions = [toFullRepaintOnResize, toInitOnSave, toReportMode, toToggleOnDblClick, toWheelPanning]
    OnChange = tvFoldersChange
    OnGetText = tvFoldersGetText
    OnGetImageIndex = tvFoldersGetImageIndex
    OnGetNodeDataSize = tvFoldersGetNodeDataSize
    Columns = <>
  end
end
