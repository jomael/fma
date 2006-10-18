'FMA Script Framework Plugin
'MediaCenter
'Lets you control J. River's Media Center 9 and maybe other versions
'Needs AutoItX control!

'TODO:
'-nothing atm

Class MediaCenter9
	
	Private m_Self
	Private mainMenu
	Private ratingMenu
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = True
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = g_(Me,"Media Center 9")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"Lets you control J. River's Media Center 9 and maybe other versions")
	End Property
	Public Property Get AUTHOR 'Who created me?
		AUTHOR      = "streawkceur"
	End Property
	Public Property Get URL 'Were can I be found? Where can you get more information?
		URL = "http://fma.xinium.com/"
	End Property
	
	'Who am I?
	Public Property Let Self (s)
		m_Self = s
		'Some init stuff here:
		If IsEmpty(Settings(Me, "Title")) or Settings(Me, "Title") = "" Then Settings(Me, "Title") = "MEDIA CENTER"
		If IsEmpty(Settings(Me, "Exe"))   or Settings(Me, "Exe")   = "" Then Settings(Me, "Exe")   = "C:\Program Files\Media Center 9\Media Jukebox.exe"
		'mainMenu items will be put every time Show() is called
		Set mainMenu = New ManagedMenu
		
		'ratingMenu items are static. We can initialize them once
		Set ratingMenu = New ManagedMenu
		Dim tempList, bi
		Set tempList = New LinkedList
		bi = tempList.BackInserter
		bi.Item = Array("1", s & ".Rate 1")
		bi.Item = Array("2", s & ".Rate 2")
		bi.Item = Array("3", s & ".Rate 3")
		bi.Item = Array("4", s & ".Rate 4")
		bi.Item = Array("5", s & ".Rate 5")
		bi.Item = Array("-", s & ".Rate 0")
		
		ratingMenu.SetList tempList
		ratingMenu.Title = g_(Me,"MC - Rating")
	End Property
	Public Property Get Self
		Self = m_Self
	End Property
	
	'Display me. Eventually put a menu on the screen
	Sub Show()
		'--> Init Menu
		Dim tempList, bi
		Set tempList = New LinkedList
		bi = tempList.BackInserter
		If MCOpen Then
			bi.Item = Array(g_(Me,"Play/Pause"), Self & ".Play")
			bi.Item = Array(g_(Me,"Stop"),       Self & ".Stopp")
			bi.Item = Array(g_(Me,"Prev Track"), Self & ".PrevTrack")
			bi.Item = Array(g_(Me,"Next Track"), Self & ".NextTrack")
			bi.Item = Array(g_(Me,"Rate"),       Self & ".ShowratingMenu")
			bi.Item = Array(g_(Me,"Volume +"),   Self & ".VolumeUp")
			bi.Item = Array(g_(Me,"Volume -"),   Self & ".VolumeDown")
			bi.Item = Array(g_(Me,"Close"),      Self & ".Close")
		Else
			bi.Item = Array(g_(Me,"Launch"),     Self & ".Launch")
		End If
		mainMenu.SetList tempList
		mainMenu.Title = TITLE
		
		mainMenu.ShowMenu
	End Sub
	
	Sub ShowratingMenu()
		ratingMenu.ShowMenu
	End Sub
	
	Function MCOpen
		MCOpen = Shell.AppActivate(Settings(Me, "Title"))
	End Function
	
	Sub Launch
		If Fso.FileExists(Settings(Me, "Exe")) Then
			Shell.Exec Settings(Me, "Exe")
			Util.WaitForAppLoad Settings(Me, "Title"), 10000 'Give MC max. 10 secs to load
		Else
			Debug.ErrorMsg Self & " - Launch: File not found: " & Settings(Me, "Exe")
		End If
		Show
	End Sub
	
	Sub Close
		If MCOpen Then
			Shell.SendKeys "%{F4}"
			Util.Sleep 3000 'Give MC 3secs to close itself
		End If
		Show
	End Sub
	
	Sub Play
		If MCOpen Then Shell.SendKeys "^p"
		am.Update
	End Sub
	
	Sub Stopp
		If MCOpen Then Shell.SendKeys "^s"
		am.Update
	End Sub
	
	Sub PrevTrack
		If MCOpen Then Shell.SendKeys "^l"
		am.Update
	End Sub
	
	Sub NextTrack
		If MCOpen Then Shell.SendKeys "^n"
		am.Update
	End Sub
	
	Sub VolumeUp
		If MCOpen Then ActiveXManager("AutoItX.Control").Send "^{NUMPADADD 2}"
		am.Update
	End Sub
	
	Sub VolumeDown
		If MCOpen Then ActiveXManager("AutoItX.Control").Send "^{NUMPADSUB 2}"
		am.Update
	End Sub
	
	Sub Rate( rating )
		If MCOpen Then
			Shell.SendKeys "^2{TAB}" 'Switch to "Playing Now"
			Util.Sleep 500 'Give MC some time...
			Shell.SendKeys "^+" & rating 'Rate the track
		End If
		MenuStack.Top.Quit
	End Sub
	
End Class

