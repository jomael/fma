'FMA Script Framework Plugin
'BSPlayer
'Lets you control BSPlayer

'TODO:
'-Testing

Class MediaPlayerClassic
	
	Private llist
	Private m_Self
	Private m_BSPlayerZoom
	Private mainMenu
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = True
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = g_(Me,"MPlayer Classic")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"Lets you control Media Player Classic")
	End Property
	Public Property Get AUTHOR 'Who created me?
		AUTHOR      = "wertherman (based on bsplayer code by streawkceur)"
	End Property
	Public Property Get URL 'Were can I be found? Where can you get more information?
		URL = "http://fma.sourceforge.net/"
	End Property
	
	'Who am I?
	Public Property Let Self (s)
		m_Self = s
		' Some init stuff here:
		If IsEmpty(Settings(Me, "Title")) or Settings(Me, "Title") = "" Then Settings(Me, "Title") = "Media Player Classic"
		If IsEmpty(Settings(Me, "Exe"))   or Settings(Me, "Exe")   = "" Then Settings(Me, "Exe")   = "C:\Program Files\Media Player Classic\mplayerc.exe"
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
		If MpcOpen Then
			bi.Item = Array(g_(Me,"Play/Pause"),    Self & ".PlayPause")
			bi.Item = Array(g_(Me,"Stop"),          Self & ".Stopp")
			bi.Item = Array(g_(Me,"Subtitles"),     Self & ".SubTitles")
			bi.Item = Array(g_(Me,"Audio"),	        Self & ".SwitchAudio")
			bi.Item = Array(g_(Me,"Fullscreen"),    Self & ".Fullscreen")
			bi.Item = Array(g_(Me,"Volume Up"),	    Self & ".VolumeUp")
			bi.Item = Array(g_(Me,"Volume Down"),	  Self & ".VolumeDown")
			bi.Item = Array(g_(Me,"Close"),         Self & ".Close")
		Else
			bi.Item = Array(g_(Me,"Launch"),        Self & ".Launch")
		End If
		mainMenu.SetList llist
		
		mainMenu.Title = TITLE
		mainMenu.ShowMenu
	End Sub
	
	Function MpcOpen
		MpcOpen = Shell.AppActivate(Settings(Me, "Title"))
	End Function
	
	Sub Launch
		If Fso.FileExists(Settings(Me, "Exe")) Then
			Shell.Exec Settings(Me, "Exe")
			Util.WaitForAppLoad Settings(Me, "Title"), 10000 'Give Mpc max. 10 secs to load
		Else
			Debug.ErrorMsg Self & " - Launch: File not found: " & Settings(Me, "Exe")
		End If
		Show
	End Sub
	
	Sub Close
		If MpcOpen Then
			Shell.SendKeys "%{F4}"
			Util.Sleep 5000 'Give Mpc 3secs to close itself
		End If
		Show
	End Sub
	
	Sub PlayPause
		If MpcOpen Then Shell.SendKeys " "
		am.Update
	End Sub	

	Sub VolumeUp
		If MpcOpen Then Shell.SendKeys "{UP}"
		am.Update
	End Sub	
	
	Sub VolumeDown
		If MpcOpen Then Shell.SendKeys "{DOWN}"
		am.Update
	End Sub	

	
	Sub SwitchAudio
		If MpcOpen Then Shell.SendKeys "A"
		am.Update
	End Sub	
	
	Sub Stopp
		If MpcOpen Then Shell.SendKeys "."
		am.Update
	End Sub
	
	
	Sub SubTitles
		If MpcOpen Then Shell.SendKeys "S"
		am.Update
	End Sub
	
	Sub Fullscreen
		If MpcOpen Then Shell.SendKeys "%{ENTER}"
		am.Update
	End Sub
End Class

