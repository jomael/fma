'FMA Script Framework Plugin
'BSPlayer
'Lets you control BSPlayer

'TODO:
'-Testing

Class BSPlayer
    
    Private llist
    Private m_Self
    Private m_BSPlayerZoom
    Private mainMenu
    Private PausePressed
    Private m_QuitDlg
    
    'Some info about the plugin
    Public Property Get SHOWABLE 'Do I have a menu?
        SHOWABLE    = True
    End Property
    Public Property Get TITLE 'What's my name?
        TITLE       = g_(Me,"BSPlayer")
    End Property
    Public Property Get DESCRIPTION 'What's my purpose?
        DESCRIPTION = g_(Me,"Lets you control BSPlayer")
    End Property
    Public Property Get AUTHOR 'Who created me?
        AUTHOR      = "streawkceur (inspired by CarpeDi3m)"
    End Property
    Public Property Get URL 'Were can I be found? Where can you get more information?
        URL = "http://fma.xinium.com/"
    End Property
    
    'Who am I?
    Public Property Let Self (s)
        m_Self = s
        ' Some init stuff here:
        If IsEmpty(Settings(Me, "Title")) or Settings(Me, "Title") = "" Then Settings(Me, "Title") = "BSPlayer"
        If IsEmpty(Settings(Me, "Exe"))   or Settings(Me, "Exe")   = "" Then Settings(Me, "Exe")   = "C:\Program Files\Cyberlink\BSPlayer\BSPlayer.exe"
        m_BSPlayerZoom = 0
        Set mainMenu = New ManagedMenu
    End Property
    Public Property Get Self
        Self = m_Self
    End Property
    
    'Display me. Eventually put a menu on the screen
    Sub Show()
        '--> Init Menu
        Set llist = New LinkedList
        Dim bi
        bi = llist.BackInserter
        If BSPlayerOpen Then
            bi.Item = Array(g_(Me,"MultiControl"),  Self & ".MultiControl")
            bi.Item = Array(g_(Me,"Play"),          Self & ".Play")
            bi.Item = Array(g_(Me,"Pause"),         Self & ".Pause")
            bi.Item = Array(g_(Me,"Stop"),          Self & ".Stopp")
            bi.Item = Array(g_(Me,"Prev Chapter"),  Self & ".PrevChapter")
            bi.Item = Array(g_(Me,"Next Chapter"),  Self & ".NextChapter")
            bi.Item = Array(g_(Me,"Subtitles"),     Self & ".SubTitles")
            bi.Item = Array(g_(Me,"Fullscreen"),    Self & ".Fullscreen")
            bi.Item = Array(g_(Me,"Zoom"),          Self & ".Zoom")
            bi.Item = Array(g_(Me,"Close"),         Self & ".Close")
        Else
            bi.Item = Array(g_(Me,"Launch"),        Self & ".Launch")
            bi.Item = Array(g_(DD,"About"),        Self & ".Launch")

        End If
        mainMenu.SetList llist
        
        mainMenu.Title = TITLE
        mainMenu.ShowMenu
    End Sub
    
    Function BSPlayerOpen
        BSPlayerOpen = Shell.AppActivate(Settings(Me, "Title"))
    End Function
    
    Sub Launch
        If Fso.FileExists(Settings(Me, "Exe")) Then
            Shell.Exec Settings(Me, "Exe")
            Util.WaitForAppLoad Settings(Me, "Title"), 10000 'Give BSPlayer max. 10 secs to load
        Else
            Debug.ErrorMsg Self & " - Launch: File not found: " & Settings(Me, "Exe")
        End If
        Show
    End Sub
    
    Sub MultiControl
        EmptyMenu.ShowMenu
        PutDialogue
        
        m_QuitDlg = False 'Don't quit the dialoge on Left Softkey and Joy Press. Only when the Back button is pressed!

        KeyManager.RegisterKey KEY_VOLUP,    Self & ".VolUpPress",   STATE_PRESS,   Me
        KeyManager.RegisterKey KEY_VOLUP,    Self & ".VolUpRelease", STATE_RELEASE, Me

        KeyManager.RegisterKey KEY_JOYUP,    Self & ".VolUpPress",   STATE_PRESS,   Me
        KeyManager.RegisterKey KEY_JOYUP,    Self & ".VolUpRelease", STATE_RELEASE, Me

        KeyManager.RegisterKey KEY_JOYRIGHT, Self & ".FFPress",      STATE_PRESS,   Me
        KeyManager.RegisterKey KEY_JOYRIGHT, Self & ".FFRelease",    STATE_RELEASE, Me

        KeyManager.RegisterKey KEY_VOLDOWN,  Self & ".VolDnPress",   STATE_PRESS,   Me
        KeyManager.RegisterKey KEY_VOLDOWN,  Self & ".VolDnRelease", STATE_RELEASE, Me

        KeyManager.RegisterKey KEY_JOYDOWN,  Self & ".VolDnPress",   STATE_PRESS,   Me
        KeyManager.RegisterKey KEY_JOYDOWN,  Self & ".VolDnRelease", STATE_RELEASE, Me

        KeyManager.RegisterKey KEY_JOYLEFT,  Self & ".RewPress",     STATE_PRESS,   Me
        KeyManager.RegisterKey KEY_JOYLEFT,  Self & ".RewRelease",   STATE_RELEASE, Me

        'Pause
        KeyManager.RegisterKey KEY_JOYPRESS, Self & ".PausePress",   STATE_PRESS,   Me

        KeyManager.RegisterKey KEY_BACK,     Self & ".BackButton",   STATE_PRESS  , Me
        KeyManager.RegisterKey KEY_NO,        Self & ".BackButton",   STATE_PRESS  , Me

        fma.EnableKeyMonitor

        'KeyManager.DeregisterAll Me
    End Sub

    Sub PutDialogue
        'No Menu here. Just show information and register keys.
        am.Back = Self & ".MultiControlQuit" 'Mangage the menu quit by ourselves
        am.DlgMsgBox "VolUp:Joy-up, VolDown:Joy-down, FF:Joy-right, Rew:Joy-left, Play/Pause:Joy-press", 0
    End Sub

    Sub BackButton
        m_QuitDlg = True
    End Sub

    Sub MultiControlQuit
        If m_QuitDlg Then 'Only quit when we are allowed to. And we're only allowed to quit, when the back button is pressed
            'Unregister all our key events
            KeyManager.DeregisterAll Me
            fma.DisableKeyMonitor
            'Remove emtpy menu
            MenuStack.Top.Quit
        Else
            PutDialogue 'Repaint the dialogue that the back button is monitored again
        End If
    End Sub
    
    Sub VolUpPress
        fma.AddTimer 100, Self & ".VolUp"
    End Sub
    Sub VolUpRelease
        fma.DeleteTimer Self & ".VolUp"
    End Sub
    
    Sub VolDnPress
        fma.AddTimer 100, Self & ".VolDn"
    End Sub
    Sub VolDnRelease
        fma.DeleteTimer Self & ".VolDn"
    End Sub
    
    Sub ClearPausePressed
        PausePressed = 0
        fma.DeleteTimer Self & ".ClearPausePressed"
    End Sub
    
    Sub PausePress
        If PausePressed = 0 Then
            PausePressed = 1
            Pause
            fma.AddTimer 500, Self & ".ClearPausePressed"
        Else
            fma.DeleteTimer Self & ".ClearPausePressed"
            fma.AddTimer 500, Self & ".ClearPausePressed"
        End if
    End Sub
    
    Sub RewPress
        fma.AddTimer 60, Self & ".Rew"
    End Sub
    Sub RewRelease
        fma.DeleteTimer Self & ".Rew"
    End Sub

    Sub FFPress
        fma.AddTimer 60, Self & ".FF"
    End Sub
    Sub FFRelease
        fma.DeleteTimer Self & ".FF"
    End Sub

    Sub VolDn
        If BSPlayerOpen Then Shell.SendKeys "{DOWN}"
    End Sub

    Sub VolUp
        If BSPlayerOpen Then Shell.SendKeys "{UP}"
    End Sub

    Sub Rew
        If BSPlayerOpen Then Shell.SendKeys "{LEFT}"
    End Sub

    Sub FF
        If BSPlayerOpen Then Shell.SendKeys "{RIGHT}"
    End Sub

    Sub Close
        If BSPlayerOpen Then
            Shell.SendKeys "%{F4}"
            Util.Sleep 5000 'Give BsPlayer 3secs to close itself
        End If
        Show
    End Sub
    
    Sub Play
        If BSPlayerOpen Then Shell.SendKeys "x"
        am.Update
    End Sub
    
    Sub Pause
        If BSPlayerOpen Then Shell.SendKeys "c"
        am.Update
    End Sub
    
    Sub Stopp
        If BSPlayerOpen Then Shell.SendKeys "v"
        am.Update
    End Sub
    
    Sub PrevChapter
        If BSPlayerOpen Then Shell.SendKeys "z"
        am.Update
    End Sub
    
    Sub NextChapter
        If BSPlayerOpen Then Shell.SendKeys "b"
        am.Update
    End Sub
    
    Sub SubTitles
        If BSPlayerOpen Then Shell.SendKeys "s"
        am.Update
    End Sub
    
    Sub Fullscreen
        If BSPlayerOpen Then Shell.SendKeys "f"
        am.Update
    End Sub
    
    Sub Zoom
      m_BSPlayerZoom = (m_BSPlayerZoom + 1) Mod 3
      If BSPlayerOpen Then Shell.SendKeys (m_BSPlayerZoom + 1)
        am.Update
    End Sub    
    
End Class