object frmCalendarView: TfrmCalendarView
  Left = 0
  Top = 0
  Width = 583
  Height = 412
  TabOrder = 0
  object SplitterVertical: TTntSplitter
    Left = 217
    Top = 0
    Height = 412
    AutoSnap = False
  end
  object Panel: TTntPanel
    Left = 220
    Top = 0
    Width = 363
    Height = 412
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object SplitterHorizontal: TTntSplitter
      Left = 0
      Top = 269
      Width = 363
      Height = 3
      Cursor = crVSplit
      Align = alTop
      AutoSnap = False
    end
    object VpMonthView: TVpMonthView
      Left = 0
      Top = 0
      Width = 363
      Height = 269
      ControlLink = VpControlLink
      Color = clWindow
      Align = alTop
      TabStop = True
      TabOrder = 0
      KBNavigation = True
      DateLabelFormat = 'mmmm yyyy'
      DayHeadAttributes.Color = clBtnFace
      DayHeadAttributes.Font.Charset = DEFAULT_CHARSET
      DayHeadAttributes.Font.Color = clWindowText
      DayHeadAttributes.Font.Height = -13
      DayHeadAttributes.Font.Name = 'Tahoma'
      DayHeadAttributes.Font.Style = []
      DayNameStyle = dsShort
      DayNumberFont.Charset = DEFAULT_CHARSET
      DayNumberFont.Color = clWindowText
      DayNumberFont.Height = -11
      DayNumberFont.Name = 'Tahoma'
      DayNumberFont.Style = []
      DrawingStyle = dsFlat
      EventDayStyle = []
      EventFont.Charset = DEFAULT_CHARSET
      EventFont.Color = clWindowText
      EventFont.Height = -11
      EventFont.Name = 'Tahoma'
      EventFont.Style = []
      LineColor = clGray
      TimeFormat = tf24Hour
      OffDayColor = clMoneyGreen
      SelectedDayColor = clGreen
      ShowEvents = True
      ShowEventTime = False
      WeekStartsOn = dtMonday
    end
    object VpTaskList: TVpTaskList
      Left = 0
      Top = 272
      Width = 363
      Height = 140
      PopupMenu = PopupMenuTaskList
      ControlLink = VpControlLink
      Color = clWindow
      Align = alClient
      TabStop = True
      TabOrder = 1
      ReadOnly = False
      DisplayOptions.CheckBGColor = clWindow
      DisplayOptions.CheckColor = cl3DDkShadow
      DisplayOptions.CheckStyle = csCheck
      DisplayOptions.DueDateFormat = 'd.M.yyyy'
      DisplayOptions.ShowCompletedTasks = True
      DisplayOptions.ShowAll = True
      DisplayOptions.ShowDueDate = True
      DisplayOptions.OverdueColor = clRed
      DisplayOptions.NormalColor = clBlack
      DisplayOptions.CompletedColor = clGray
      LineColor = clGray
      MaxVisibleTasks = 250
      TaskHeadAttributes.Color = clSilver
      TaskHeadAttributes.Font.Charset = DEFAULT_CHARSET
      TaskHeadAttributes.Font.Color = clWindowText
      TaskHeadAttributes.Font.Height = -11
      TaskHeadAttributes.Font.Name = 'Tahoma'
      TaskHeadAttributes.Font.Style = []
      DrawingStyle = dsFlat
      ShowResourceName = False
      PopupMenuAdd = True
      OnOwnerEditTask = VpTaskListOwnerEditTask
    end
  end
  object VpDayView: TVpDayView
    Left = 0
    Top = 0
    Width = 217
    Height = 412
    PopupMenu = PopupMenuDayView
    ControlLink = VpControlLink
    Color = clWindow
    Align = alLeft
    ReadOnly = False
    TabStop = True
    TabOrder = 0
    AllDayEventAttributes.BackgroundColor = clBtnShadow
    AllDayEventAttributes.EventBorderColor = cl3DDkShadow
    AllDayEventAttributes.EventBackgroundColor = clBtnFace
    AllDayEventAttributes.Font.Charset = DEFAULT_CHARSET
    AllDayEventAttributes.Font.Color = clWindowText
    AllDayEventAttributes.Font.Height = -11
    AllDayEventAttributes.Font.Name = 'Tahoma'
    AllDayEventAttributes.Font.Style = []
    ShowEventTimes = False
    DrawingStyle = dsFlat
    TimeSlotColors.Active = clWhite
    TimeSlotColors.Inactive = 8454143
    TimeSlotColors.Holiday = 16744703
    TimeSlotColors.Weekday = clWhite
    TimeSlotColors.Weekend = 16777088
    TimeSlotColors.ActiveRange.RangeBegin = h_09
    TimeSlotColors.ActiveRange.RangeEnd = h_18
    HeadAttributes.Font.Charset = DEFAULT_CHARSET
    HeadAttributes.Font.Color = clWindowText
    HeadAttributes.Font.Height = -13
    HeadAttributes.Font.Name = 'Tahoma'
    HeadAttributes.Font.Style = []
    HeadAttributes.Color = clBtnFace
    RowHeadAttributes.HourFont.Charset = DEFAULT_CHARSET
    RowHeadAttributes.HourFont.Color = clWindowText
    RowHeadAttributes.HourFont.Height = -24
    RowHeadAttributes.HourFont.Name = 'Tahoma'
    RowHeadAttributes.HourFont.Style = []
    RowHeadAttributes.MinuteFont.Charset = DEFAULT_CHARSET
    RowHeadAttributes.MinuteFont.Color = clWindowText
    RowHeadAttributes.MinuteFont.Height = -12
    RowHeadAttributes.MinuteFont.Name = 'Tahoma'
    RowHeadAttributes.MinuteFont.Style = []
    RowHeadAttributes.Color = clBtnFace
    IconAttributes.AlarmBitmap.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000D4D4FDD4D4FD
      D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4
      FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4
      D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FD
      D4D4FDD4D4FDD4D4FDD4D4FDD4D4FD306880304860D4D4FDD4D4FDD4D4FDD4D4
      FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FD6C9BAE54869B528194527A9438788D30
      68903058703B59683050603048603048603B5968D4D4FDD4D4FDD4D4FDD4D4FD
      60A8C0D0FFFFB0F8FF80E8FF60E0F050C0E040B0D040A0C03088A03078A03058
      70305060D4D4FDD4D4FDD4D4FDD4D4FDD4D4FD70C8E0D0F8FFB0F8FFA0F0FF90
      E8FF70D0F050C0E040B8E03080A0205870D4D4FDD4D4FDD4D4FDD4D4FDD4D4FD
      D4D4FDD4D4FD80C8E080D8F070C0D060B0D050A0C03080A0306880305070D4D4
      FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FD87BCC9C0F8FF90E8F070
      D8F040C0E030A0C03090B03B5968D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FD
      D4D4FDD4D4FD7FBFD4C0F8FFA0F0FF90E0F060D0F040C0E030A0C03B6886D4D4
      FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FD86C3D2C0F8FFC0F8FFA0
      F0FF90E8F060D0F040B8E03B6886D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FD
      D4D4FDD4D4FD86C3D2C0F8FFC0F8FFC0F8FFB0F8FF90E0F060C0E04A7086D4D4
      FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDA0D8E0C0F0F0D0
      FFFFD0FFFFA0E8F06090A0D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FD
      D4D4FDD4D4FDD4D4FDD4D4FD90D0E080C0D070B0C060A0B0D4D4FDD4D4FDD4D4
      FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4
      D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FD
      D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4
      FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4
      D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FD}
    ShowResourceName = False
    LineColor = clGray
    GutterWidth = 7
    DateLabelFormat = 'dddd, mmmm dd, yyyy'
    Granularity = gr30Min
    DefaultTopHour = h_07
    TimeFormat = tf24Hour
    PopupMenuAdd = True
    OnDrawIcons = VpDayViewDrawIcons
    OnOwnerEditEvent = VpDayViewOwnerEditEvent
  end
  object VpControlLink: TVpControlLink
    Printer.DayStart = h_08
    Printer.DayEnd = h_05
    Printer.Granularity = gr30Min
    Printer.MarginUnits = imAbsolutePixel
    Printer.PrintFormats = <>
    Left = 96
    Top = 212
  end
  object FormStorage1: TFormStorage
    IniFileName = 'Software\floAt'
    IniSection = 'MobileAgent'
    Options = []
    UseRegistry = True
    StoredProps.Strings = (
      'VpMonthView.Height'
      'VpDayView.Width')
    StoredValues = <>
    Left = 128
    Top = 180
  end
  object ImageListCalPopup: TImageList
    Left = 96
    Top = 180
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000033CC000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000033CC000033CC000033CC0000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000033CC000033CC000033CC0000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF0000000000000000000000000000000000000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000033CC000033CC000033CC000033CC0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF00000000000000000000000000000000000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001040FF000000000000000000000000000000000000000000000000000000
      00000000000033CC000033CC000033CC00000000000033CC000033CC00000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF0000000000000000000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000A39FA000000
      00000050FF00000000000A39FA00000000000000000000000000000000000000
      000033CC000033CC000033CC000000000000000000000000000033CC00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF00000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001040
      FF000A39FA000A39FA00000000000000000000000000000000000000000033CC
      000033CC000033CC00000000000000000000000000000000000033CC000033CC
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001040FF001040FF000A39
      FA00000000001040FF001040FF001040FF000000000000000000000000000000
      000033CC000000000000000000000000000000000000000000000000000033CC
      000033CC00000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001040
      FF000A39FA001040FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000033CC000033CC000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF00000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001040FF000000
      00001040FF00000000001040FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000033CC000033CC0000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000000000000000000000000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001040FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000033CC0000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFFFFFFFFFF0000
      FFFFFFFFFFFF0000FFFFFFFFFFFF0000FFFFFFFFFFF30000FFFFFF7F9FE30000
      FFFFFE3F8FE30000FFFFFE3FC7C70000FFFFFC3FE3C70000FFF7F89FF18F0000
      FFD5F1DFF89F0000FFE3E3CFF83F0000FF88F7E7FE3F0000FFE3FFF3FC9F0000
      FFD5FFF9F1CF0000FFF7FFFDF7F7000000000000000000000000000000000000
      000000000000}
  end
  object PopupMenuDayView: TTntPopupMenu
    OnPopup = PopupMenuDayViewPopup
    Left = 96
    Top = 148
    object ForceasNotModifieDv: TTntMenuItem
      Tag = 1
      Caption = 'Force as Not Modified'
      OnClick = ForceasNotModifieDvClick
    end
    object ForceasModifiedDv: TTntMenuItem
      Tag = 1
      Caption = 'Force as Modified'
      OnClick = ForceasModifiedDvClick
    end
    object ForceasNewEventDv: TTntMenuItem
      Tag = 1
      Caption = 'Force as New Event'
      OnClick = ForceasNewEventDvClick
    end
    object N1: TTntMenuItem
      Caption = '-'
    end
    object DownloadentireCalendar1: TTntMenuItem
      Caption = 'Download Entire Calendar...'
      ImageIndex = 1
      OnClick = DownloadentireCalendar1Click
    end
    object N2: TTntMenuItem
      Caption = '-'
    end
    object RecurItem1: TTntMenuItem
      Caption = 'Time Shifting'
      object NextDay1: TTntMenuItem
        Caption = 'Next Day'
        ImageIndex = 1
        OnClick = RecurringClick
      end
      object NextWeek1: TTntMenuItem
        Caption = 'Next Week'
        ImageIndex = 2
        OnClick = RecurringClick
      end
      object NextMonth1: TTntMenuItem
        Caption = 'Next Month'
        ImageIndex = 3
        OnClick = RecurringClick
      end
      object NextYear1: TTntMenuItem
        Caption = 'Next Year'
        ImageIndex = 4
        OnClick = RecurringClick
      end
    end
    object N5: TTntMenuItem
      Caption = '-'
    end
    object ImportCalendar1: TTntMenuItem
      Action = Form1.ActionToolsImportCalendar
    end
    object ExportCalendar1: TTntMenuItem
      Action = Form1.ActionToolsExportCalendar
    end
    object N7: TTntMenuItem
      Caption = '-'
    end
    object Properties1: TTntMenuItem
      Caption = 'P&roperties'
      ImageIndex = 10
      OnClick = Properties1Click
    end
  end
  object PopupMenuTaskList: TTntPopupMenu
    OnPopup = PopupMenuTaskListPopup
    Left = 128
    Top = 148
    object ForceasNotModifiedTl: TTntMenuItem
      Tag = 1
      Caption = 'Force as Not Modified'
      OnClick = ForceasNotModifiedTlClick
    end
    object ForceasModifiedTl: TTntMenuItem
      Tag = 1
      Caption = 'Force as Modified'
      OnClick = ForceasModifiedTlClick
    end
    object ForceasNewEventTl: TTntMenuItem
      Tag = 1
      Caption = 'Force as New Event'
      OnClick = ForceasNewEventTlClick
    end
    object N3: TTntMenuItem
      Caption = '-'
    end
    object DownloadEntireCalendar2: TTntMenuItem
      Caption = 'Download Entire Calendar...'
      ImageIndex = 1
      OnClick = DownloadentireCalendar1Click
    end
    object N4: TTntMenuItem
      Caption = '-'
    end
    object CompletedStatus1: TTntMenuItem
      Caption = 'Completed Status'
      object CompletedToday1: TTntMenuItem
        Caption = 'Today'
        OnClick = CompletedStatusClick
      end
      object CompletedClear1: TTntMenuItem
        Caption = 'Clear'
        OnClick = CompletedStatusClick
      end
    end
    object N6: TTntMenuItem
      Caption = '-'
    end
    object ImportCalendar2: TTntMenuItem
      Action = Form1.ActionToolsImportCalendar
    end
    object ExportCalendar2: TTntMenuItem
      Action = Form1.ActionToolsExportCalendar
    end
    object N8: TTntMenuItem
      Caption = '-'
    end
    object Properties2: TTntMenuItem
      Caption = 'P&roperties'
      Enabled = False
      ImageIndex = 10
      OnClick = Properties2Click
    end
  end
  object OpenDialog1: TTntOpenDialog
    DefaultExt = '.vcs'
    Filter = 'vCalendar Files (*.vcs)|*.vcs|All Files|*.*'
    Title = 'Import Calendar...'
    Left = 128
    Top = 116
  end
  object TntSaveDialog1: TTntSaveDialog
    DefaultExt = '.vcs'
    Filter = 'vCalendar Files (*.vcs)|*.vcs'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Export Entire Calendar...'
    Left = 96
    Top = 116
  end
end