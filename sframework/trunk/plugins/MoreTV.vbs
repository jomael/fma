'FMA Script Framework Plugin
'MoreTV
'Lets you control MoreTV

'TODO:
'-Testing

Class MoreTV
	
	Private m_Self
	Private mainMenu
	Private tvRemoteMenu
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = True
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = g_(Me,"MoreTV")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"Lets you control MoreTV")
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
		If IsEmpty(Settings(Me, "Title")) or Settings(Me, "Title") = "" Then Settings(Me, "Title") = "MoreTV"
		If IsEmpty(Settings(Me, "Exe"))   or Settings(Me, "Exe")   = "" Then Settings(Me, "Exe")   = "C:\Program Files\MoreTV\MoreTV.exe"
		
		'MainMenu items will be put every time Show() is called
		Set mainMenu = New ManagedMenu
		
		'RatingMenu items are static. We can initialize them once
		Set tvRemoteMenu = New ManagedMenu
		Dim tempList, bi
		Set tempList = New LinkedList
		bi = tempList.BackInserter
		bi.Item = Array(g_(Me,"Button 1"), s & ".Button1")
		bi.Item = Array(g_(Me,"Button 2"), s & ".Button2")
		bi.Item = Array(g_(Me,"Button 3"), s & ".Button3")
		bi.Item = Array(g_(Me,"Button 4"), s & ".Button4")
		bi.Item = Array(g_(Me,"Button 5"), s & ".Button5")
		bi.Item = Array(g_(Me,"Button 6"), s & ".Button6")
		bi.Item = Array(g_(Me,"Button 7"), s & ".Button7")
		bi.Item = Array(g_(Me,"Button 8"), s & ".Button8")
		bi.Item = Array(g_(Me,"Button 9"), s & ".Button9")
		bi.Item = Array(g_(Me,"Button 0"), s & ".Button0")
		tvRemoteMenu.SetList tempList
		tvRemoteMenu.Title = g_(Me,"MoreTV - Remote")
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
		If MoreTVOpen Then
			bi.Item = Array(g_(Me,"Remote Mode"),  Self & ".TVList")
			bi.Item = Array(g_(Me,"Channel Up"),   Self & ".ChannelUp")
			bi.Item = Array(g_(Me,"Channel Down"), Self & ".ChannelDown")
			bi.Item = Array(g_(Me,"(Un)Mute"),     Self & ".Mute")
			bi.Item = Array(g_(Me,"Fullscreen"),   Self & ".Fullscreen")
			bi.Item = Array(g_(Me,"Videotext"),    Self & ".Videotext")
			bi.Item = Array(g_(Me,"Close"),        Self & ".Close")
		Else
			bi.Item = Array(g_(Me,"Launch"),       Self & ".Launch")
		End If
		mainMenu.SetList llist
		mainMenu.Title = TITLE
		mainMenu.ShowMenu
	End Sub
	
	Function MoreTVOpen
		MoreTVOpen = Shell.AppActivate(Settings(Me, "Title"))
	End Function
	
	Sub Launch
		If Fso.FileExists(Settings(Me, "Exe")) Then
			Shell.Exec Settings(Me, "Exe")
			Util.WaitForAppLoad Settings(Me, "Title"), 10000 'Give MoreTV max. 10 secs to load
		Else
			Debug.DebugMsg Self & " - Launch: File not found: " & Settings(Me, "Exe")
		End If
		Show
	End Sub
	
	Sub Close
		If MoreTVOpen Then
			Shell.SendKeys "{F10}"
			Util.Sleep 3000 'Give MoreTV 3secs to close itself
		End If
		Show
	End Sub
	
	Sub TVList
		tvRemoteMenu.ShowMenu
	End Sub
	
	Sub Button1
		If MoreTVOpen Then	 Shell.SendKeys 1
		am.Update
	End Sub
	Sub Button2
		If MoreTVOpen Then	 Shell.SendKeys 2
		am.Update
	End Sub
	Sub Button3
		If MoreTVOpen Then	 Shell.SendKeys 3
		am.Update
	End Sub
	Sub Button4
		If MoreTVOpen Then	 Shell.SendKeys 4
		am.Update
	End Sub
	Sub Button5
		If MoreTVOpen Then	 Shell.SendKeys 5
		am.Update
	End Sub
	Sub Button6
		If MoreTVOpen Then	 Shell.SendKeys 6
		am.Update
	End Sub
	Sub Button7
		If MoreTVOpen Then	 Shell.SendKeys 7
		am.Update
	End Sub
	Sub Button8
		If MoreTVOpen Then	 Shell.SendKeys 8
		am.Update
	End Sub
	Sub Button9
		If MoreTVOpen Then	 Shell.SendKeys 9
		am.Update
	End Sub
	Sub Button0
		If MoreTVOpen Then	 Shell.SendKeys 0
		am.Update
	End Sub
	
	Sub ChannelUp
		If MoreTVOpen Then Shell.SendKeys "{UP}"
		am.Update
	End Sub
	
	Sub ChannelDown
		If MoreTVOpen Then Shell.SendKeys "{DOWN}"
		am.Update
	End Sub
	
	Sub Mute
		If MoreTVOpen Then Shell.SendKeys "m"
		am.Update
	End Sub
	
	Sub Fullscreen
		If MoreTVOpen Then Shell.SendKeys "{F9}"
		am.Update
	End Sub
	
	Sub Videotext
		If MoreTVOpen Then Shell.SendKeys "v"
		am.Update
	End Sub

End Class

