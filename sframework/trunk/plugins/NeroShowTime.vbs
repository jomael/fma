'FMA Script Framework Plugin
'Nero Show Time
'Lets you control Nero Show Time

'TODO:
'-Testing

Class NeroShowTime
    
    Private m_Self
    Private mainMenu
    Private fwdMenu
    Private bwdMenu
    
    'Some info about the plugin
    Public Property Get SHOWABLE 'Do I have a menu?
        SHOWABLE    = True
    End Property
    Public Property Get TITLE 'What's my name?
        TITLE       = g_(Me,"Nero ShowTime")
    End Property
    Public Property Get DESCRIPTION 'What's my purpose?
        DESCRIPTION = g_(Me,"Lets you control Nero ShowTime")
    End Property
    Public Property Get AUTHOR 'Who created me?
        AUTHOR      = "TK"
    End Property
    Public Property Get URL 'Were can I be found? Where can you get more information?
        URL = "http://"
    End Property
    
    'Who am I?
    Public Property Let Self (s)
        m_Self = s
        ' Some init stuff here:
        If IsEmpty(Settings(Me, "Title")) or Settings(Me, "Title") = "" Then Settings(Me, "Title") = "Nero ShowTime"
        If IsEmpty(Settings(Me, "Exe"))   or Settings(Me, "Exe")   = "" Then Settings(Me, "Exe")   = "C:\Programme\Nero\Nero 7\Nero ShowTime\ShowTime.exe"
        Set mainMenu = New ManagedMenu
        mainMenu.Title = TITLE
        Set fwdMenu = New ManagedMenu
        fwdMenu.Title = "Select Forward Speed"
        Set bwdMenu = New ManagedMenu
        bwdMenu.Title = "Select Backward Speed"
    End Property
    Public Property Get Self
        Self = m_Self
    End Property
    
    'Display me. Eventually put a menu on the screen
    Sub Show()
        '--> Init Menu
        Dim llist
        Set llist = New LinkedList
        Dim bi
        bi = llist.BackInserter
        If NeroShowTimeOpen Then
            bi.Item = Array(g_(Me,"Start"),    Self & ".Start")
            bi.Item = Array(g_(Me,"Play / Pause"),    Self & ".Play")
            bi.Item = Array(g_(Me,"Next Chapter"),    Self & ".NextChapter")
            bi.Item = Array(g_(Me,"Previous Chapter"),    Self & ".PreviousChapter")
            bi.Item = Array(g_(Me,"Stop"),    Self & ".Stopp")
            bi.Item = Array(g_(Me,"Eject"),    Self & ".Eject")
            bi.Item = Array(g_(Me,"Mute"),    Self & ".Mute")
            bi.Item = Array(g_(Me,"Fullscreen"),    Self & ".Fullscreen")
            bi.Item = Array(g_(Me,"Subtitles"),    Self & ".Subtitles")
            bi.Item = Array(g_(Me,"Language"),    Self & ".Language")
            bi.Item = Array(g_(Me,"Next Frame"),    Self & ".NextFrame")
            bi.Item = Array(g_(Me,"Next Bookmark"),    Self & ".NextBookmark")
            bi.Item = Array(g_(Me,"Place Bookmark"),    Self & ".PlaceBookmark")
            bi.Item = Array(g_(Me,"Settings"),    Self & ".SettingsMenu")
            bi.Item = Array(g_(Me,"Forward"),    Self & ".ForwardMenu")
            bi.Item = Array(g_(Me,"Backwards"),    Self & ".BackwardsMenu")
            bi.Item = Array(g_(Me,"Menu"),    Self & ".Menu")
            bi.Item = Array(g_(Me,"Repeat Chapter"),    Self & ".RepeatChapter")
            bi.Item = Array(g_(Me,"Repeat Selection"),    Self & ".RepeatSelection")
            bi.Item = Array(g_(Me,"Change Angel"),    Self & ".ChangeAngel")
            bi.Item = Array(g_(Me,"Zoom"),    Self & ".Zoom")
            bi.Item = Array(g_(Me,"Screenshot"),    Self & ".Screenshot")
            bi.Item = Array(g_(Me,"Close"),    Self & ".Close")
        Else
            bi.Item = Array(g_(Me,"Launch"),        Self & ".Launch")
        End If
        mainMenu.SetList llist
        mainMenu.ShowMenu
    End Sub
    
    Function NeroShowTimeOpen
        NeroShowTimeOpen = Shell.AppActivate(Settings(Me, "Title"))
    End Function

    Sub ForwardMenu()
        '--> Init Menu
        Dim llist
        Set llist = New LinkedList
        Dim bi
        bi = llist.BackInserter
        If NeroShowTimeOpen Then
            bi.Item = Array(g_(Me,"1/8"),    Self & ".FwdSpeed(1)")
            bi.Item = Array(g_(Me,"1/4"),    Self & ".FwdSpeed(2)")
            bi.Item = Array(g_(Me,"1/2"),    Self & ".FwdSpeed(3)")
            bi.Item = Array(g_(Me,"1"),    Self & ".FwdSpeed(4)")
            bi.Item = Array(g_(Me,"1,5"),    Self & ".FwdSpeed(5)")
            bi.Item = Array(g_(Me,"2"),    Self & ".FwdSpeed(6)")
            bi.Item = Array(g_(Me,"2,5"),    Self & ".FwdSpeed(7)")
            bi.Item = Array(g_(Me,"4"),    Self & ".FwdSpeed(8)")
            bi.Item = Array(g_(Me,"8"),    Self & ".FwdSpeed(9)")
            bi.Item = Array(g_(Me,"16"),    Self & ".FwdSpeed(10)")
            bi.Item = Array(g_(Me,"32"),    Self & ".FwdSpeed(11)")
        End If
        fwdMenu.SetList llist
        fwdMenu.ShowMenu
    End Sub

    Sub FwdSpeed( intTimes )
        If NeroShowTimeOpen Then
            dim i
            Shell.SendKeys "f"
            for i=1 to intTimes
                Shell.SendKeys "{DOWN}"
            next
            Shell.SendKeys "{Enter}"
        End If
        am.Update
        Show
    End Sub

    Sub BackwardsMenu
        '--> Init Menu
        Dim llist
        Set llist = New LinkedList
        Dim bi
        bi = llist.BackInserter
        If NeroShowTimeOpen Then
            bi.Item = Array(g_(Me,"1/8"),    Self & ".BwdSpeed(1)")
            bi.Item = Array(g_(Me,"1/4"),    Self & ".BwdSpeed(2)")
            bi.Item = Array(g_(Me,"1/2"),    Self & ".BwdSpeed(3)")
            bi.Item = Array(g_(Me,"1"),    Self & ".BwdSpeed(4)")
            bi.Item = Array(g_(Me,"1,5"),    Self & ".BwdSpeed(5)")
            bi.Item = Array(g_(Me,"2"),    Self & ".BwdSpeed(6)")
            bi.Item = Array(g_(Me,"2,5"),    Self & ".BwdSpeed(7)")
            bi.Item = Array(g_(Me,"4"),    Self & ".BwdSpeed(8)")
            bi.Item = Array(g_(Me,"8"),    Self & ".BwdSpeed(9)")
            bi.Item = Array(g_(Me,"16"),    Self & ".BwdSpeed(10)")
            bi.Item = Array(g_(Me,"32"),    Self & ".BwdSpeed(11)")
        End If
        bwdMenu.SetList llist
        bwdMenu.ShowMenu
    End Sub

    Sub BwdSpeed( intTimes )
        If NeroShowTimeOpen Then
            dim i
            Shell.SendKeys "b"
            for i=1 to intTimes
                Shell.SendKeys "{DOWN}"
            next
            Shell.SendKeys "{Enter}"
        End If
        am.Update
        Show
    End Sub

    Sub Launch
        If Fso.FileExists(Settings(Me, "Exe")) Then
            Shell.Exec Settings(Me, "Exe")
            Util.WaitForAppLoad Settings(Me, "Title"), 10000 'Give NeroShowTime max. 10 secs to load
        Else
            Debug.ErrorMsg Self & " - Launch: File not found: " & Settings(Me, "Exe")
        End If
        Show
    End Sub
    
    Sub Start
        If NeroShowTimeOpen Then Shell.SendKeys "{Enter}"
        am.Update
        Show
    End Sub

    Sub Play
        If NeroShowTimeOpen Then Shell.SendKeys " "
        am.Update
        Show
    End Sub
    
    Sub Stopp
        If NeroShowTimeOpen Then Shell.SendKeys "s"
        am.Update
        Show
    End Sub

    Sub NextChapter
        If NeroShowTimeOpen Then Shell.SendKeys "n"
        am.Update
        Show
    End Sub

    Sub PreviousChapter
        If NeroShowTimeOpen Then Shell.SendKeys "p"
        am.Update
        Show
    End Sub

    Sub Eject
        If NeroShowTimeOpen Then Shell.SendKeys "j"
        am.Update
        Show
    End Sub

    Sub Mute
        If NeroShowTimeOpen Then Shell.SendKeys "q"
        am.Update
        Show
    End Sub

    Sub Fullscreen
        If NeroShowTimeOpen Then Shell.SendKeys "z"
        am.Update
        Show
    End Sub

    Sub Subtitles
        If NeroShowTimeOpen Then Shell.SendKeys "u"
        am.Update
        Show
    End Sub

    Sub Language
        If NeroShowTimeOpen Then Shell.SendKeys "h"
        am.Update
        Show
    End Sub

    Sub NextFrame
        If NeroShowTimeOpen Then Shell.SendKeys "t"
        am.Update
        Show
    End Sub

    Sub NextBookmark
        If NeroShowTimeOpen Then Shell.SendKeys "g"
        am.Update
        Show
    End Sub

    Sub PlaceBookmark
        If NeroShowTimeOpen Then Shell.SendKeys "m"
        am.Update
        Show
    End Sub

    Sub SettingsMenu
        If NeroShowTimeOpen Then Shell.SendKeys "^c"
        am.Update
        Show
    End Sub

    Sub Forward
        If NeroShowTimeOpen Then Shell.SendKeys "f"
        am.Update
        Show
    End Sub

    Sub Menu
        If NeroShowTimeOpen Then Shell.SendKeys "l"
        am.Update
        Show
    End Sub

    Sub RepeatChapter
        If NeroShowTimeOpen Then Shell.SendKeys "^r"
        am.Update
        Show
    End Sub

    Sub RepeatSelection
        If NeroShowTimeOpen Then Shell.SendKeys "r"
        am.Update
        Show
    End Sub

    Sub ChangeAngel
        If NeroShowTimeOpen Then Shell.SendKeys "a"
        am.Update
        Show
    End Sub

    Sub Zoom
        If NeroShowTimeOpen Then Shell.SendKeys "d"
        am.Update
        Show
    End Sub

    Sub Screenshot
        If NeroShowTimeOpen Then Shell.SendKeys "c"
        am.Update
        Show
    End Sub
    
    Sub Close
        If NeroShowTimeOpen Then Shell.SendKeys "%{F4}"
        am.Update
    End Sub

End Class