object frmExplore: TfrmExplore
  Left = 0
  Top = 0
  Width = 528
  Height = 224
  TabOrder = 0
  Visible = False
  DesignSize = (
    528
    224)
  object ListItems: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 528
    Height = 224
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
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoHotTrack, hoShowImages, hoVisible]
    Header.Style = hsFlatButtons
    HintAnimation = hatNone
    HintMode = hmTooltip
    Images = Form1.ImageList1
    Indent = 0
    LineMode = lmBands
    PopupMenu = PopupMenu1
    ScrollBarOptions.AlwaysVisible = True
    TabOrder = 0
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSpanColumns, toAutoTristateTracking, toAutoDeleteMovedNodes]
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toInitOnSave, toReportMode, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toHideFocusRect, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toFullRowSelect, toRightClickSelect]
    OnDblClick = ListItemsDblClick
    OnGetText = ListItemsGetText
    OnGetImageIndex = ListItemsGetImageIndex
    Columns = <
      item
        MinWidth = 70
        Position = 0
        Width = 300
        WideText = 'Name'
      end
      item
        MinWidth = 70
        Position = 1
        Width = 120
      end
      item
        Alignment = taRightJustify
        MinWidth = 70
        Position = 2
        Width = 88
      end>
  end
  object NoItemsPanel: TTntPanel
    Left = 8
    Top = 28
    Width = 495
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvNone
    Caption = 'There are no items to display in this view.'
    Color = clWindow
    PopupMenu = PopupMenu1
    TabOrder = 1
  end
  object PopupMenu1: TTntPopupMenu
    Images = Form1.ImageList2
    OnPopup = PopupMenu1Popup
    Left = 56
    Top = 80
    object NewItem1: TTntMenuItem
      Action = Form1.ActionToolsPostNote
    end
    object N7: TTntMenuItem
      Caption = '-'
    end
    object newmsg1: TTntMenuItem
      Action = Form1.ActionContactsNewMsg
    end
    object newcall1: TTntMenuItem
      Action = Form1.ActionContactsVoiceCall
    end
    object ChatContact1: TTntMenuItem
      Action = Form1.ActionContactsNewChat
    end
    object N2: TTntMenuItem
      Caption = '-'
    end
    object New1: TTntMenuItem
      Caption = 'Create'
      object sms1: TTntMenuItem
        Action = Form1.ActionSMSNewMsg
      end
      object person1: TTntMenuItem
        Action = Form1.ActionContactsNewPerson
      end
      object Note1: TTntMenuItem
        Action = Form1.ActionToolsPostNote
      end
      object Bookmark1: TTntMenuItem
        Action = Form1.ActionToolsPostBookmark
      end
      object NewGroup1: TTntMenuItem
        Action = Form1.ActionToolsCreateGroup
      end
      object NewAlarm1: TTntMenuItem
        Action = Form1.ActionToolsPostAlarm
      end
    end
    object Advanced1: TTntMenuItem
      Caption = 'Profiles'
      object EditSettings1: TTntMenuItem
        Caption = 'Profile Settings...'
        ImageIndex = 13
        OnClick = Properties1Click
      end
      object ActivatePr1: TTntMenuItem
        Caption = 'Activate Profile'
      end
    end
    object N4: TTntMenuItem
      Caption = '-'
    end
    object Upload1: TTntMenuItem
      Action = Form1.ActionToolsUpload
    end
    object download1: TTntMenuItem
      Action = Form1.ActionToolsDownload
    end
    object Explore1: TTntMenuItem
      Caption = '&Explore'
      OnClick = Open1Click
    end
    object N1: TTntMenuItem
      Caption = '-'
    end
    object AddToPhonebook1: TTntMenuItem
      Action = Form1.ActionContactsAddContact
    end
    object N3: TTntMenuItem
      Caption = '-'
    end
    object Delete1: TTntMenuItem
      Action = Form1.ActionDelete
    end
    object N5: TTntMenuItem
      Caption = '-'
    end
    object Properties1: TTntMenuItem
      Caption = '&Properties'
      ImageIndex = 10
      OnClick = Properties1Click
    end
  end
  object FormStorage1: TFormStorage
    IniFileName = 'Software\floAt'
    IniSection = 'MobileAgent'
    Options = []
    UseRegistry = True
    OnRestorePlacement = FormStorage1RestorePlacement
    StoredProps.Strings = (
      'ListItems.Header')
    StoredValues = <>
    Left = 24
    Top = 80
  end
end
