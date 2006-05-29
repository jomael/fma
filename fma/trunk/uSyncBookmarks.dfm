object frmSyncBookmarks: TfrmSyncBookmarks
  Left = 0
  Top = 0
  Width = 466
  Height = 262
  TabOrder = 0
  DesignSize = (
    466
    262)
  object ListBookmarks: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 466
    Height = 262
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
    Header.SortColumn = 0
    Header.Style = hsFlatButtons
    HintAnimation = hatNone
    HintMode = hmTooltip
    Images = Form1.ImageList1
    IncrementalSearchTimeout = 500
    Indent = 0
    LineMode = lmBands
    PopupMenu = PopupMenu1
    TabOrder = 0
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSort, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toInitOnSave, toReportMode, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toHideFocusRect, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toFullRowSelect, toMultiSelect, toRightClickSelect]
    OnAfterPaint = ListBookmarksAfterPaint
    OnCompareNodes = ListBookmarksCompareNodes
    OnDblClick = btnEDITClick
    OnGetText = ListBookmarksGetText
    OnGetImageIndex = ListBookmarksGetImageIndex
    OnHeaderClick = ListBookmarksHeaderClick
    OnHeaderMouseUp = ListBookmarksHeaderMouseUp
    OnKeyDown = ListBookmarksKeyDown
    Columns = <
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentColor, coResizable, coShowDropMark, coVisible]
        Position = 0
        WideText = 'Pos'
      end
      item
        Position = 1
        Width = 200
        WideText = 'Location name'
      end
      item
        Position = 2
        Width = 300
        WideText = 'URL'
      end
      item
        Position = 3
        Width = 10
        WideText = 'Status'
      end>
  end
  object NoItemsPanel: TTntPanel
    Left = 8
    Top = 28
    Width = 449
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvNone
    Caption = 'There are no items to display in this view.'
    Color = clWindow
    PopupMenu = PopupMenu1
    TabOrder = 1
  end
  object FormStorage1: TFormStorage
    IniFileName = 'Software\floAt'
    IniSection = 'Bookmarks'
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
  object PopupMenu1: TTntPopupMenu
    Images = Form1.ImageList2
    OnPopup = PopupMenu1Popup
    Left = 68
    Top = 64
    object NewBookmark1: TTntMenuItem
      Action = Form1.ActionToolsPostBookmark
    end
    object N3: TTntMenuItem
      Caption = '-'
    end
    object OpenTargetLocation1: TTntMenuItem
      Caption = 'Open Target Location...'
      Hint = 'Open target bookmark location in your Browser'
      ImageIndex = 55
      OnClick = OpenTargetLocation1Click
    end
    object N8: TTntMenuItem
      Caption = '-'
    end
    object SetasHomePage1: TTntMenuItem
      Caption = 'Set as WAP Home Page'
      Hint = 'Set current bookmark location as your phone home page'
      OnClick = SetasHomePage1Click
    end
    object WAPHomePage1: TTntMenuItem
      Action = Form1.ActionToolsWapHomepage
    end
    object N4: TTntMenuItem
      Caption = '-'
    end
    object SyncTo1: TTntMenuItem
      Caption = '&Synchronize To'
      object SynchrinizePhone1: TTntMenuItem
        Caption = 'Phone'
        OnClick = SynchrinizePhone1Click
      end
      object N7: TTntMenuItem
        Caption = '-'
      end
      object InternetExplorer1: TTntMenuItem
        Caption = 'Internet Explorer'
        Enabled = False
      end
      object Firefox1: TTntMenuItem
        Caption = 'Firefox'
        Enabled = False
      end
      object Opera1: TTntMenuItem
        Caption = 'Opera'
        Enabled = False
      end
    end
    object ForceAs1: TTntMenuItem
      Caption = 'Force As'
      object NotModified1: TTntMenuItem
        Caption = 'Not Modified...'
        OnClick = NotModified1Click
      end
      object Modified1: TTntMenuItem
        Caption = 'Modified...'
        OnClick = Modified1Click
      end
      object NewNoUndo1: TTntMenuItem
        Caption = 'New (No Undo)...'
        OnClick = NewNoUndo1Click
      end
    end
    object N2: TTntMenuItem
      Caption = '-'
    end
    object DownloadEntireList1: TTntMenuItem
      Caption = 'Download Entire List...'
      Hint = 'Download a fresh copy of bookmarks list from phone'
      ImageIndex = 1
      OnClick = DownloadEntireList1Click
    end
    object N5: TTntMenuItem
      Caption = '-'
    end
    object Delete1: TTntMenuItem
      Action = Form1.ActionDelete
    end
    object N6: TTntMenuItem
      Caption = '-'
    end
    object Import1: TTntMenuItem
      Caption = 'Import...'
      Enabled = False
    end
    object Export1: TTntMenuItem
      Caption = 'Export...'
      Enabled = False
    end
    object N1: TTntMenuItem
      Caption = '-'
    end
    object Properties1: TTntMenuItem
      Caption = 'Properties'
      Hint = 'Bookmark properties'
      ImageIndex = 10
      OnClick = btnEDITClick
    end
  end
end
