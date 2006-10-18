'FMA Script Framework Plugin
'ZoomPlayer
'Lets you control ZoomPlayer

'TODO:
'-Testing

Class ZoomPlayer
	
	Private m_Self
	Private mainMenu
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = True
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = g_(Me,"ZoomPlayer")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"Lets you control Zoomplayer")
	End Property
	Public Property Get AUTHOR 'Who created me?
		AUTHOR      = "streawkceur (inspired by choroy)"
	End Property
	Public Property Get URL 'Were can I be found? Where can you get more information?
		URL = "http://fma.xinium.com/"
	End Property
	
	'Who am I?
	Public Property Let Self (s)
		m_Self = s
		' Some init stuff here:
		If IsEmpty(Settings(Me, "Title")) or Settings(Me, "Title") = "" Then Settings(Me, "Title") = "Zoom Player"
		If IsEmpty(Settings(Me, "Exe"))   or Settings(Me, "Exe")   = "" Then Settings(Me, "Exe")   = "C:\Program Files\Zoomplayer\ZPlayer.exe"
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
		bi = llist.BackInserter
		If ZoomPlayerOpen Then
			bi.Item = Array(g_(Me,"Play/Pause"),    Self & ".Play")
			bi.Item = Array(g_(Me,"Stop"),          Self & ".Stopp")
			bi.Item = Array(g_(Me,"Prev Chapter"),  Self & ".PrevChapter")
			bi.Item = Array(g_(Me,"Next Chapter"),  Self & ".NextChapter")
			bi.Item = Array(g_(Me,"Jump ahead"),    Self & ".JumpAhead")
			bi.Item = Array(g_(Me,"Jump back"),     Self & ".JumpBack")
			bi.Item = Array(g_(Me,"Volume +"),      Self & ".VolumeUp")
			bi.Item = Array(g_(Me,"Volume -"),      Self & ".VolumeDn")
			bi.Item = Array(g_(Me,"(Un)Mute"),      Self & ".VolumeMute")
			bi.Item = Array(g_(Me,"SubTitles"),     Self & ".Subtitles")
			bi.Item = Array(g_(Me,"Fullscreen"),    Self & ".Fullscreen")
			bi.Item = Array(g_(Me,"Fast Fwd"),      Self & ".FastForward")
			bi.Item = Array(g_(Me,"Rewind"),        Self & ".Rewind")
			bi.Item = Array(g_(Me,"Close"),         Self & ".Close")
		Else
			bi.Item = Array(g_(Me,"Launch"),        Self & ".Launch")
		End If
		mainMenu.SetList llist
		mainMenu.ShowMenu
	End Sub
	
	Function ZoomPlayerOpen
		ZoomPlayerOpen = Shell.AppActivate(Settings(Me, "Title"))
	End Function
	
	Sub Launch
		If Fso.FileExists(Settings(Me, "Exe")) Then
			Shell.Exec Settings(Me, "Exe")
			Util.WaitForAppLoad Settings(Me, "Title"), 10000 'Give ZoomPlayer max. 10 secs to load
		Else
			Debug.ErrorMsg Self & " - Launch: File not found: " & Settings(Me, "Exe")
		End If
		Show
	End Sub
	
	Sub Close
		If ZoomPlayerOpen Then
			Shell.SendKeys "%x"
			Util.Sleep 3000 'Give ZoomPlayer 3secs to close itself
		End If
		Show
	End Sub
	
	Sub Play
		If ZoomPlayerOpen Then Shell.SendKeys "p"
		am.Update
	End Sub
	
	Sub Stopp
		If ZoomPlayerOpen Then Shell.SendKeys "s"
		am.Update
	End Sub
	
	Sub PrevChapter
		If ZoomPlayerOpen Then Shell.SendKeys "+["
		am.Update
	End Sub
	
	Sub NextChapter
		If ZoomPlayerOpen Then Shell.SendKeys "+]"
		am.Update
	End Sub
	
	Sub JumpAhead
		If ZoomPlayerOpen Then Shell.SendKeys "%."
		am.Update
	End Sub
	
	Sub JumpBack
		If ZoomPlayerOpen Then Shell.SendKeys "%,"
		am.Update
	End Sub
	
	Sub VolumeUp
		If ZoomPlayerOpen Then Shell.SendKeys "+{UP}"
		am.Update
	End Sub
	
	Sub VolumeDn
		If ZoomPlayerOpen Then Shell.SendKeys "+{DOWN}"
		am.Update
	End Sub
	
	Sub VolumeMute
		If ZoomPlayerOpen Then Shell.SendKeys "^m"
		am.Update
	End Sub
	
	Sub Subtitles
		If ZoomPlayerOpen Then Shell.SendKeys "+;"
		am.Update
	End Sub
	
	Sub Fullscreen
		If ZoomPlayerOpen Then Shell.SendKeys "%{ENTER}"
		am.Update
	End Sub
	
	Sub FastForward
		If ZoomPlayerOpen Then Shell.SendKeys "%{HOME}"
		am.Update
	End Sub
	
	Sub Rewind
		If ZoomPlayerOpen Then Shell.SendKeys "%{END}"
		am.Update
	End Sub
	
End Class

