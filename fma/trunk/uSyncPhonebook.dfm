object frmSyncPhonebook: TfrmSyncPhonebook
  Left = 0
  Top = 0
  Width = 587
  Height = 221
  TabOrder = 0
  Visible = False
  DesignSize = (
    587
    221)
  object ListContacts: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 587
    Height = 221
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
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoHotTrack, hoShowHint, hoShowImages, hoShowSortGlyphs, hoVisible]
    Header.SortColumn = 1
    Header.Style = hsFlatButtons
    HintAnimation = hatNone
    HintMode = hmTooltip
    Images = Form1.ImageList4
    IncrementalSearch = isInitializedOnly
    IncrementalSearchTimeout = 500
    Indent = 0
    LineMode = lmBands
    ParentShowHint = False
    PopupMenu = PopupMenu1
    ScrollBarOptions.AlwaysVisible = True
    ShowHint = True
    TabOrder = 0
    TextMargin = 2
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toInitOnSave, toReportMode, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toHideFocusRect, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toFullRowSelect, toMultiSelect, toRightClickSelect]
    OnAfterPaint = ListContactsAfterPaint
    OnCompareNodes = ListContactsCompareNodes
    OnDblClick = btnEditClick
    OnGetText = ListContactsGetText
    OnGetImageIndex = ListContactsGetImageIndex
    OnHeaderClick = ListContactsHeaderClick
    OnHeaderDragged = ListContactsHeaderDragged
    OnHeaderMouseUp = ListContactsHeaderMouseUp
    OnIncrementalSearch = ListContactsIncrementalSearch
    OnKeyDown = ListContactsKeyDown
    Columns = <
      item
        Margin = 2
        MinWidth = 50
        Position = 0
        Spacing = 2
        Width = 53
        WideText = 'Status'
        WideHint = 'Right-click to select columns'
      end
      item
        Margin = 2
        MinWidth = 70
        Position = 1
        Spacing = 2
        Width = 140
        WideText = 'Full Name'
        WideHint = 'Right-click to change order'
      end
      item
        Margin = 2
        MinWidth = 40
        Position = 3
        Spacing = 2
        Width = 40
        WideText = 'Title'
        WideHint = 'Right-click to select columns'
      end
      item
        Margin = 2
        MinWidth = 40
        Position = 4
        Spacing = 2
        Width = 60
        WideText = 'Organization'
        WideHint = 'Right-click to select columns'
      end
      item
        ImageIndex = 14
        Margin = 2
        MinWidth = 50
        Position = 5
        Spacing = 2
        Width = 100
        WideText = 'Email'
        WideHint = 'Right-click to select columns'
      end
      item
        ImageIndex = 9
        Margin = 2
        MinWidth = 50
        Position = 6
        Spacing = 2
        Width = 120
        WideText = 'Home'
        WideHint = 'Right-click to select columns'
      end
      item
        ImageIndex = 11
        Margin = 2
        MinWidth = 50
        Position = 7
        Spacing = 2
        Width = 120
        WideText = 'Work'
        WideHint = 'Right-click to select columns'
      end
      item
        ImageIndex = 10
        Margin = 2
        MinWidth = 50
        Position = 8
        Spacing = 2
        Width = 120
        WideText = 'Cell'
        WideHint = 'Right-click to select columns'
      end
      item
        ImageIndex = 12
        Margin = 2
        MinWidth = 50
        Position = 9
        Spacing = 2
        Width = 120
        WideText = 'Fax'
        WideHint = 'Right-click to select columns'
      end
      item
        ImageIndex = 13
        Margin = 2
        MinWidth = 50
        Position = 10
        Spacing = 2
        Width = 70
        WideText = 'Other'
        WideHint = 'Right-click to select columns'
      end
      item
        Margin = 2
        MinWidth = 40
        Position = 11
        Spacing = 2
        Width = 40
        WideText = 'Street'
        WideHint = 'Right-click to select columns'
      end
      item
        Margin = 2
        MinWidth = 40
        Position = 12
        Spacing = 2
        Width = 40
        WideText = 'City'
        WideHint = 'Right-click to select columns'
      end
      item
        Margin = 2
        MinWidth = 40
        Position = 13
        Spacing = 2
        Width = 40
        WideText = 'Region'
        WideHint = 'Right-click to select columns'
      end
      item
        Margin = 2
        MinWidth = 40
        Position = 14
        Spacing = 2
        Width = 40
        WideText = 'PostalCode'
        WideHint = 'Right-click to select columns'
      end
      item
        Margin = 2
        MinWidth = 40
        Position = 15
        Spacing = 2
        Width = 40
        WideText = 'Country'
        WideHint = 'Right-click to select columns'
      end
      item
        Margin = 2
        MinWidth = 70
        Position = 2
        Spacing = 2
        Width = 70
        WideText = 'DisplayName'
        WideHint = 'Right-click to select columns'
      end>
  end
  object NoItemsPanel: TTntPanel
    Left = 8
    Top = 28
    Width = 554
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvNone
    Caption = 
      'There are no items to display in this view. To begin, select Syn' +
      'c | Address Book from main menu.'
    Color = clWindow
    PopupMenu = PopupMenu1
    TabOrder = 1
  end
  object PopupMenu1: TTntPopupMenu
    Images = Form1.ImageList2
    OnPopup = PopupMenu1Popup
    Left = 56
    Top = 52
    object NewContact1: TTntMenuItem
      Action = Form1.ActionContactsNewPerson
    end
    object UndoLastChange1: TTntMenuItem
      Caption = '&Undo Edit Last Contact...'
      OnClick = UndoLastChange1Click
    end
    object N2: TTntMenuItem
      Caption = '-'
    end
    object SendMsg1: TTntMenuItem
      Action = Form1.ActionContactsNewMsg
    end
    object voicecall1: TTntMenuItem
      Action = Form1.ActionContactsVoiceCall
    end
    object ChatContact1: TTntMenuItem
      Action = Form1.ActionContactsNewChat
    end
    object CopySelectedtoSIMcard1: TTntMenuItem
      Caption = 'Copy to SIM Memory...'
      ImageIndex = 14
      OnClick = CopySelectedtoSIMcard1Click
    end
    object N10: TTntMenuItem
      Caption = '-'
    end
    object SynchronizeTo1: TTntMenuItem
      Caption = '&Synchronize To'
      object Phone1: TTntMenuItem
        Action = Form1.ActionSyncPhonebook
      end
      object N11: TTntMenuItem
        Caption = '-'
      end
      object Outlook1: TTntMenuItem
        Action = Form1.ActionSyncWithOutlook
      end
    end
    object ForceAs1: TTntMenuItem
      Caption = 'Force As'
      object ClearChangedFlag1: TTntMenuItem
        Caption = 'Not Modified'
        OnClick = ClearChangedFlag1Click
      end
      object ForceUpdate: TTntMenuItem
        Caption = 'Modified'
        OnClick = ForceUpdateClick
      end
      object ForceNewContact: TTntMenuItem
        Caption = 'New (No Undo)'
        OnClick = ForceNewContactClick
      end
    end
    object CurrentView1: TTntMenuItem
      Caption = 'Current &View'
      object DisplayColumns1: TTntMenuItem
        Caption = 'Columns'
      end
      object N9: TTntMenuItem
        Caption = '-'
      end
      object NameFormat1: TTntMenuItem
        Caption = 'Full Name'
        object FirstLast2: TTntMenuItem
          Caption = 'First Last'
          Checked = True
          GroupIndex = 1
          RadioItem = True
          OnClick = FirstLast2Click
        end
        object LastFirst2: TTntMenuItem
          Caption = 'Last, First'
          GroupIndex = 1
          RadioItem = True
          OnClick = FirstLast2Click
        end
      end
    end
    object AddtoGroup1: TTntMenuItem
      AutoHotkeys = maManual
      Caption = 'Add to &Group'
      object NewGroup1: TTntMenuItem
        Caption = '&New Group...'
        OnClick = NewGroup1Click
      end
      object GroupsDiv: TTntMenuItem
        Caption = '-'
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
    object N3: TTntMenuItem
      Caption = '-'
    end
    object Delete1: TTntMenuItem
      Action = Form1.ActionDelete
    end
    object N1: TTntMenuItem
      Caption = '-'
    end
    object ImportContacts1: TTntMenuItem
      Caption = 'Imp&ort Contacts...'
      OnClick = ImportContacts1Click
    end
    object Exportselectedcontacts1: TTntMenuItem
      Action = Form1.ActionContactsExport
    end
    object N4: TTntMenuItem
      Caption = '-'
    end
    object Properties1: TTntMenuItem
      Caption = 'P&roperties'
      ImageIndex = 10
      OnClick = btnEditClick
    end
  end
  object FormStorage1: TFormStorage
    IniFileName = 'Software\floAt'
    IniSection = 'ME'
    Options = []
    UseRegistry = True
    OnSavePlacement = FormStorage1SavePlacement
    OnRestorePlacement = FormStorage1RestorePlacement
    StoredProps.Strings = (
      'FirstLast1.Checked'
      'LastFirst1.Checked')
    StoredValues = <
      item
        Name = 'ListHeader'
        Value = ''
      end>
    Left = 20
    Top = 52
  end
  object OpenDialog1: TTntOpenDialog
    DefaultExt = '.vcf'
    Filter = 
      'vCard Files (*.vcf)|*.vcf|Thunderbird LDIF Files (*.ldi,*.ldif)|' +
      '*.ldi;*.ldif|All Files|*.*'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Title = 'Import Contacts...'
    Left = 92
    Top = 52
  end
  object pmNameOrder: TTntPopupMenu
    Left = 128
    Top = 52
    object FirstLast1: TTntMenuItem
      Caption = 'First Last'
      Checked = True
      GroupIndex = 1
      RadioItem = True
      OnClick = FirstLast1Click
    end
    object LastFirst1: TTntMenuItem
      Caption = 'Last, First'
      GroupIndex = 1
      RadioItem = True
      OnClick = FirstLast1Click
    end
  end
  object pmColumns: TTntPopupMenu
    OnPopup = pmColumnsPopup
    Left = 164
    Top = 52
  end
end
