object frmContactsSMEdit: TfrmContactsSMEdit
  Left = 0
  Top = 0
  Width = 529
  Height = 287
  TabOrder = 0
  Visible = False
  DesignSize = (
    529
    287)
  object Panel1: TTntPanel
    Left = 0
    Top = 254
    Width = 529
    Height = 33
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 0
    Visible = False
    object btnUpdateSIM: TTntButton
      Left = 8
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Update SIM'
      TabOrder = 0
      OnClick = btnUpdateSIMClick
    end
    object cbForce: TTntCheckBox
      Left = 92
      Top = 9
      Width = 109
      Height = 17
      Caption = 'Force update all'
      TabOrder = 1
    end
    object btnReset: TTntButton
      Left = 200
      Top = 4
      Width = 105
      Height = 25
      Caption = 'Reset change flaq'
      TabOrder = 2
      OnClick = btnResetClick
    end
  end
  object ListNumbers: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 529
    Height = 254
    Align = alClient
    DefaultNodeHeight = 17
    DragMode = dmAutomatic
    Header.AutoSizeIndex = -1
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.Height = 20
    Header.MainColumn = 1
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoHotTrack, hoShowImages, hoShowSortGlyphs, hoVisible]
    Header.SortColumn = 1
    Header.Style = hsFlatButtons
    HintAnimation = hatNone
    HintMode = hmTooltip
    Images = Form1.ImageList4
    IncrementalSearch = isInitializedOnly
    IncrementalSearchTimeout = 500
    Indent = 0
    LineMode = lmBands
    PopupMenu = PopupMenu1
    TabOrder = 1
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSort, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toInitOnSave, toReportMode, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toHideFocusRect, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toFullRowSelect, toMultiSelect, toRightClickSelect]
    OnAfterPaint = ListNumbersAfterPaint
    OnCompareNodes = ListNumbersCompareNodes
    OnDblClick = btnEDITClick
    OnGetText = ListNumbersGetText
    OnGetImageIndex = ListNumbersGetImageIndex
    OnHeaderClick = ListNumbersHeaderClick
    OnHeaderMouseUp = ListNumbersHeaderMouseUp
    OnIncrementalSearch = ListNumbersIncrementalSearch
    OnKeyDown = ListNumbersKeyDown
    Columns = <
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentColor, coResizable, coShowDropMark, coVisible]
        Position = 0
        WideText = 'Pos'
      end
      item
        Position = 1
        Width = 250
        WideText = 'Contact name'
      end
      item
        Position = 2
        Width = 180
        WideText = 'Number'
      end
      item
        Position = 3
        Width = 100
        WideText = 'Type'
      end
      item
        Position = 4
        Width = 10
        WideText = 'Status'
      end>
  end
  object NoItemsPanel: TTntPanel
    Left = 8
    Top = 28
    Width = 513
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvNone
    Caption = 
      'There are no items to display in this view. To begin, select Vie' +
      'w | Refresh from main menu.'
    Color = clWindow
    PopupMenu = PopupMenu1
    TabOrder = 2
  end
  object PopupMenu1: TTntPopupMenu
    Images = Form1.ImageList2
    OnPopup = PopupMenu1Popup
    Left = 64
    Top = 64
    object NewPerson1: TTntMenuItem
      Action = Form1.ActionContactsNewPerson
    end
    object N3: TTntMenuItem
      Caption = '-'
    end
    object MessageContact1: TTntMenuItem
      Action = Form1.ActionContactsNewMsg
    end
    object CallContact1: TTntMenuItem
      Action = Form1.ActionContactsVoiceCall
    end
    object ChatContact1: TTntMenuItem
      Action = Form1.ActionContactsNewChat
    end
    object CopySelectedToPhone1: TTntMenuItem
      Caption = 'Copy to Phone Memory...'
      ImageIndex = 14
      OnClick = CopySelectedToPhone1Click
    end
    object N5: TTntMenuItem
      Caption = '-'
    end
    object SendToPhone1: TTntMenuItem
      Caption = 'Send To Phone'
      object UpdateChanged1: TTntMenuItem
        Caption = 'Modified Only...'
        OnClick = UpdateChanged1Click
      end
      object UpdateAllRecords1: TTntMenuItem
        Caption = 'All Contacts...'
        OnClick = UpdateAllRecords1Click
      end
    end
    object ForceAs1: TTntMenuItem
      Caption = 'Force As'
      object Resetchangeflag1: TTntMenuItem
        Caption = 'Not Modified'
        OnClick = Resetchangeflag1Click
      end
      object Modified1: TTntMenuItem
        Caption = 'Modified'
        OnClick = Modified1Click
      end
      object NewNoUndo1: TTntMenuItem
        Caption = 'New (No Undo)'
        OnClick = frmSyncPhonebookNewNoUndo1Click
      end
    end
    object otalChange1: TTntMenuItem
      Caption = 'Total Change'
      object UpdateContactsPosition1: TTntMenuItem
        Caption = 'Reindex All...'
        OnClick = UpdateContactsPosition1Click
      end
    end
    object N7: TTntMenuItem
      Caption = '-'
    end
    object DownloadEntirePhonebook1: TTntMenuItem
      Caption = 'Download Entire Phonebook...'
      ImageIndex = 1
      OnClick = DownloadEntirePhonebook1Click
    end
    object N1: TTntMenuItem
      Caption = '-'
    end
    object Clear1: TTntMenuItem
      Action = Form1.ActionDelete
    end
    object N2: TTntMenuItem
      Caption = '-'
    end
    object ImportContacts1: TTntMenuItem
      Caption = 'Import Contacts...'
      OnClick = ImportContacts1Click
    end
    object ExportContacts1: TTntMenuItem
      Action = Form1.ActionContactsExportSM
    end
    object N4: TTntMenuItem
      Caption = '-'
    end
    object Properties1: TTntMenuItem
      Caption = '&Properties'
      ImageIndex = 10
      OnClick = btnEDITClick
    end
  end
  object FormStorage1: TFormStorage
    IniFileName = 'Software\floAt'
    IniSection = 'SM'
    Options = []
    UseRegistry = True
    OnSavePlacement = FormStorage1SavePlacement
    OnRestorePlacement = FormStorage1RestorePlacement
    StoredValues = <
      item
        Name = 'ListHeader'
        Value = ''
      end>
    Left = 28
    Top = 64
  end
  object OpenDialog1: TTntOpenDialog
    DefaultExt = '.vcf'
    Filter = 'vCard Files (*.vcf)|*.vcf|All Files|*.*'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Title = 'Import Contacts...'
    Left = 100
    Top = 64
  end
end
