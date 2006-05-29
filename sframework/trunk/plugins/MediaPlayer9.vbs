'FMA Script Framework Plugin
'MediaPlayer9
'Allows for controlling MS Media Player 9

'TODO:
'-nothing atm

Class MediaPlayer9
	
	Private llist
	Private m_Self
	Private m_volsteps
	Private mainMenu
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = True
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = g_(Me,"Media Player 9")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"Allows for controlling MS Media Player 9")
	End Property
	Public Property Get AUTHOR 'Who created me?
		AUTHOR      = "streawkceur (inspired by ultimatex)"
	End Property
	Public Property Get URL 'Were can I be found? Where can you get more information?
		URL = "http://fma.xinium.com/"
	End Property
	
	'Who am I?
	Public Property Let Self (s)
		m_Self = s
		' Some init stuff here:
		If IsEmpty(Settings(Me, "Title")) or Settings(Me, "Title") = "" Then Settings(Me, "Title") = "Windows Media Player"
		If IsEmpty(Settings(Me, "Exe"))   or Settings(Me, "Exe")   = "" Then Settings(Me, "Exe")   = "C:\Program Files\Windows Media Player\wmplayer.exe"
		Set mainMenu = New ManagedMenu
		mainMenu.Title = TITLE
	End Property
	Public Property Get Self
		Self = m_Self
	End Property
	
	'Display me. Eventually put a menu on the screen
	Sub Show()
		'--> Menu: LinkedList Style. Sorted and very handy. This would be the one of choice
		Set llist = New LinkedList
		Dim bi
		bi = llist.BackInserter
		If WMPOpen Then
			bi.Item = Array(g_(Me,"Play/Pause"), Self & ".Play")
			bi.Item = Array(g_(Me,"Stop"),       Self & ".Stopp")
			bi.Item = Array(g_(Me,"Shuffle"),    Self & ".Shuffle")
			bi.Item = Array(g_(Me,"Next Track"), Self & ".NextTrack")
			bi.Item = Array(g_(Me,"Prev Track"), Self & ".PrevTrack")
			bi.Item = Array(g_(Me,"Volume"),     Self & ".Volume")
			bi.Item = Array(g_(Me,"Mute"),       Self & ".Mute")
			bi.Item = Array(g_(Me,"Fullscreen"), Self & ".Fullscreen")
			bi.Item = Array(g_(Me,"Close"),      Self & ".Close")
		Else
			bi.Item = Array(g_(Me,"Launch"),     Self & ".Launch")
		End If
		mainMenu.SetList llist
		mainMenu.ShowMenu
	End Sub
	
	Function WMPOpen
		WMPOpen = Shell.AppActivate(Settings(Me, "Title"))
	End Function
	
	Sub Launch
		If Fso.FileExists(Settings(Me, "Exe")) Then
			Shell.Exec Settings(Me, "Exe")
			Util.WaitForAppLoad Settings(Me, "Title"), 10000 'Give WMP max. 10 secs to load
		Else
			Debug.ErrorMsg Self & " - Launch: File not found: " & Settings(Me, "Exe")
		End If
		Show
	End Sub
	
	Sub Play
		If WMPOpen Then Shell.SendKeys "^p"
		am.Update	
	End Sub
	
	Sub Stopp
		If WMPOpen Then Shell.SendKeys "^s"
		am.Update	
	End Sub
	
	Sub Shuffle
		If WMPOpen Then Shell.SendKeys "^h"
		am.Update	
	End Sub
	
	Sub Mute
		If WMPOpen Then Shell.SendKeys "{F8}"
		am.Update	
	End Sub
	
	Sub Fullscreen
		If WMPOpen Then Shell.SendKeys "%{ENTER}"
		am.Update	
	End Sub
	
	Sub PrevTrack
		If WMPOpen Then Shell.SendKeys "^b"
		am.Update	
	End Sub
	
	Sub NextTrack
		If WMPOpen Then Shell.SendKeys "^f"
		am.Update	
	End Sub
	
	Sub Close
		If WMPOpen Then Shell.SendKeys "%{F4}"
		Show	
	End Sub
	
	Sub Volume
		EmptyMenu.ShowMenu 'Push empty menu to prevent page swapping of the last menu
		Util.DisplayMsgBox "Up/down: change volume. Back to exit", 0, Self & ".QuitVolume" 'Mangage the menu quit by ourselves
		KeyManager.RegisterKey KEY_JOYUP,    Self & ".IncVol",     STATE_PRESS, Me
		KeyManager.RegisterKey KEY_JOYDOWN,  Self & ".DecVol",     STATE_PRESS, Me
		KeyManager.RegisterKey KEY_VOLUP,    Self & ".IncVol",     STATE_PRESS, Me
		KeyManager.RegisterKey KEY_VOLDOWN,  Self & ".DecVol",     STATE_PRESS, Me
	End Sub
	
	Sub QuitVolume
		KeyManager.DeregisterAll Me
		MenuStack.Top.Quit 'remove empty menu. this will also show the previous menu
	End Sub
	
	Sub DecVol
		If WMPOpen Then Shell.SendKeys "{F9}"
	End Sub
	
	Sub IncVol
		If WMPOpen Then Shell.SendKeys "{F10}"
	End Sub
	
End Class

