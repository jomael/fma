'FMA Script Framework Plugin
'foobar2000
'Lets you control foobar2000
'Version 1.0
'
'IF you want to see the current title playing and being able to adjust the volume, download the
'fb2k plugin foo_winamp_spam ( http://www.r1ch.net/stuff/foobar/foo_winamp_spam-0.74.zip )
'and install it into your /foobar2000/components/ directory.

'TODO:
'- Testing

Class foobar2000
	
	Private m_Self
	Private mainMenu
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = True
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = g_(Me,"foobar2000")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"Lets you control foobar2000")
	End Property
	Public Property Get AUTHOR 'Who created me?
		AUTHOR      = "cynos, partially based on winamp script"
	End Property
	Public Property Get URL 'Were can I be found? Where can you get more information?
		URL = "http://fma.xinium.com/"
	End Property
	
	'Who am I?
	Public Property Let Self (s)
		m_Self = s
		' Some init stuff here:
		If IsEmpty(Settings(Me, "Title")) or Settings(Me, "Title") = "" Then Settings(Me, "Title") = "foobar2000"                                   'This isn't needed.
		If IsEmpty(Settings(Me, "Exe"))   or Settings(Me, "Exe")   = "" Then Settings(Me, "Exe")   = "C:\Program Files\foobar2000\foobar2000.exe"
		Set mainMenu = New ManagedMenu
		mainMenu.Title = TITLE
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
		ActiveXManager("WinampCOMLib.WinampCOMObj").PathExe = Fso.GetParentFolderName(Settings(Me, "Exe"))          ' Set up fake API.
		bi = llist.BackInserter
		    bi.Item = Array("1 " & ActiveXManager("WinampCOMLib.WinampCOMObj").GetTitlePlaying, Self & ".fbvoid")   ' Get the title playing from the API, doesn't refresh when song ends.
		    state = ActiveXManager("WinampCOMLib.WinampCOMObj").GetSongState                                        ' Get the state of the song playing.
		    
			If state = "Playing" Then
				bi.Item = Array("2 " & g_(Me,"Restart"),            Self & ".Play")     'Restart (Play) track. If order is random, random track.
			Elseif state = "Paused" Then
				bi.Item = Array("2 " & g_(Me,"Resume"),             Self & ".Play")
			Else
			    bi.Item = Array("2 " & g_(Me,"Play / Start fb2k"),  Self & ".Play")
			End If
			
			If state = "Paused" Then
				bi.Item = Array("3 " & g_(Me,"Resume"),             Self & ".Pause")
			Else
				bi.Item = Array("3 " & g_(Me,"Pause"),              Self & ".Pause")
			End If
			
			bi.Item = Array("4 " & g_(Me,"Stop"),                   Self & ".Stopp")
			bi.Item = Array("5 " & g_(Me,"Next Track"),             Self & ".NextTrack")
			bi.Item = Array("6 " & g_(Me,"Previous Track"),         Self & ".PreviousTrack")
			bi.Item = Array("7 " & g_(Me,"Random Track"),           Self & ".RandomTrack")
			bi.Item = Array("8 " & g_(Me,"Volume"),                 Self & ".Volume")
			bi.Item = Array("9 " & g_(Me,"Order"),                  Self & ".Order")
			bi.Item = Array("0 " & g_(Me,"Close"),                  Self & ".Close")
		mainMenu.SetList llist
		mainMenu.ShowMenu
	End Sub
	
	Sub fbvoid
	    Show    'Just refresh if user clicks the first menu item
	End Sub
	
	Sub Close
		Shell.Exec Settings(Me, "Exe") & " /command:""Foobar2000/Close"""   'Start / Invoke foobar2000.exe with commandline command. It won't load to times.
		Util.Sleep 3000                                                     'Give foobar2000 3secs to close itself
		am.Update
		Show                                                                'Refresh the menu and title playing
	End Sub
	
	Sub Play
		Shell.Exec Settings(Me, "Exe") & " /command:""Playback/Play"""
		am.Update
		Show
	End Sub
		
	Sub Pause
		Shell.Exec Settings(Me, "Exe") & " /command:""Playback/Pause"""
		am.Update
		Show
	End Sub
	
	Sub Stopp
		Shell.Exec Settings(Me, "Exe") & " /command:""Playback/Stop"""
		am.Update
		Show
	End Sub
	
	Sub NextTrack
		Shell.Exec Settings(Me, "Exe") & " /command:""Playback/Next"""
		am.Update
		Show
	End Sub
	
	Sub PreviousTrack
		Shell.Exec Settings(Me, "Exe") & " /command:""Playback/Previous"""
		am.Update
		Show
	End Sub
	
	Sub RandomTrack
		Shell.Exec Settings(Me, "Exe") & " /command:""Playback/Random"""
		am.Update
		Show
	End Sub
	
	' Order Start
	Sub Order()
		EmptyMenu.ShowMenu
		'Joyup -> Default
		KeyManager.RegisterKey KEY_JOYUP,    Self & ".DefaultPress",   STATE_PRESS,   Me
		KeyManager.RegisterKey KEY_JOYUP,    Self & ".DefaultRelease", STATE_RELEASE, Me
		'Joyright -> Repeat One
		KeyManager.RegisterKey KEY_JOYRIGHT, Self & ".RepeatOnePress",   STATE_PRESS,   Me
		KeyManager.RegisterKey KEY_JOYRIGHT, Self & ".RepeatOneRelease", STATE_RELEASE, Me
		'Joydown -> Random
		KeyManager.RegisterKey KEY_JOYDOWN,  Self & ".RandomPress",   STATE_PRESS,   Me
		KeyManager.RegisterKey KEY_JOYDOWN,  Self & ".RandomRelease", STATE_RELEASE, Me
		'Joyleft -> Repeat
		KeyManager.RegisterKey KEY_JOYLEFT,  Self & ".RepeatPress",   STATE_PRESS,   Me
		KeyManager.RegisterKey KEY_JOYLEFT,  Self & ".RepeatRelease", STATE_RELEASE, Me
		
		Util.DisplayMsgBox g_(Me,"Joy-Up: Default; Joy-Down: Random; Joy-Left: Repeat; Joy-Right: Repeat One"), 0, Self & ".OrderQuit" 'Mangage the menu quit by ourselves
	End Sub
	
	Sub SetOrderDefault
		Shell.Exec Settings(Me, "Exe") & " /command:""Playback/Order/Default"""
	End Sub
	
	Sub SetOrderRepeatOne
		Shell.Exec Settings(Me, "Exe") & " /command:""Playback/Order/Repeat One"""
	End Sub
	
	Sub SetOrderRandom
		Shell.Exec Settings(Me, "Exe") & " /command:""Playback/Order/Random"""
	End Sub
	
	Sub SetOrderRepeat
		Shell.Exec Settings(Me, "Exe") & " /command:""Playback/Order/Repeat"""
	End Sub
		
	Sub DefaultPress
		fma.AddTimer 60, Self & ".SetOrderDefault"
	End Sub
	Sub DefaultRelease
		fma.DeleteTimer Self & ".SetOrderDefault"
		OrderQuit       ' After choosing order: Quit the Dlg
	End Sub
	
	Sub RepeatOnePress
		fma.AddTimer 60, Self & ".SetOrderRepeatOne"
	End Sub
	Sub RepeatOneRelease
		fma.DeleteTimer Self & ".SetOrderRepeatOne"
		OrderQuit
	End Sub
	
	Sub RandomPress
		fma.AddTimer 60, Self & ".SetOrderRandom"
	End Sub
	Sub RandomRelease
		fma.DeleteTimer Self & ".SetOrderRandom"
		OrderQuit
	End Sub
	
	Sub RepeatPress
		fma.AddTimer 60, Self & ".SetOrderRepeat"
	End Sub
	Sub RepeatRelease
		fma.DeleteTimer Self & ".SetOrderRepeat"
		OrderQuit
	End Sub
		
	Sub OrderQuit()
		KeyManager.DeregisterAll Me
		MenuStack.Top.Quit 'Remove emtpy menu
	End Sub
	' Order End
	
	' Volume Start (API)
	Sub VolUp
		ActiveXManager("WinampCOMLib.WinampCOMObj").Volumeup        'Send Vol+
	End Sub
	Sub VolDn
		ActiveXManager("WinampCOMLib.WinampCOMObj").VolumeDown      'Send Vol-
	End Sub
	
	Sub VolUpPress
		fma.AddTimer 60, Self & ".VolUp"
	End Sub
	Sub VolUpRelease
		fma.DeleteTimer Self & ".VolUp"
	End Sub
	
	Sub VolDnPress
		fma.AddTimer 60, Self & ".VolDn"
	End Sub
	Sub VolDnRelease
		fma.DeleteTimer Self & ".VolDn"
	End Sub
	
	Sub Volume()
		EmptyMenu.ShowMenu
		'Volume Up
		KeyManager.RegisterKey KEY_VOLUP,    Self & ".VolUpPress",   STATE_PRESS,   Me
		KeyManager.RegisterKey KEY_JOYUP,    Self & ".VolUpPress",   STATE_PRESS,   Me
		KeyManager.RegisterKey KEY_JOYRIGHT, Self & ".VolUpPress",   STATE_PRESS,   Me
		KeyManager.RegisterKey KEY_VOLUP,    Self & ".VolUpRelease", STATE_RELEASE, Me
		KeyManager.RegisterKey KEY_JOYUP,    Self & ".VolUpRelease", STATE_RELEASE, Me
		KeyManager.RegisterKey KEY_JOYRIGHT, Self & ".VolUpRelease", STATE_RELEASE, Me
		'Volume Down
		KeyManager.RegisterKey KEY_VOLDOWN,  Self & ".VolDnPress",   STATE_PRESS,   Me
		KeyManager.RegisterKey KEY_JOYDOWN,  Self & ".VolDnPress",   STATE_PRESS,   Me
		KeyManager.RegisterKey KEY_JOYLEFT,  Self & ".VolDnPress",   STATE_PRESS,   Me
		KeyManager.RegisterKey KEY_VOLDOWN,  Self & ".VolDnRelease", STATE_RELEASE, Me
		KeyManager.RegisterKey KEY_JOYDOWN,  Self & ".VolDnRelease", STATE_RELEASE, Me
		KeyManager.RegisterKey KEY_JOYLEFT,  Self & ".VolDnRelease", STATE_RELEASE, Me
		Util.DisplayMsgBox g_(Me,"Joy-Up, -Right: Increase volume; Joy-Down, -Left: Decrease volume"), 0, Self & ".VolumeQuit" 'Mangage the menu quit by ourselves
	End Sub
	
	Sub VolumeQuit()
		KeyManager.DeregisterAll Me
		MenuStack.Top.Quit 'Remove emtpy menu
	End Sub
	' Volume End

End Class