'FMA Script Framework Plugin
'WinTV
'Lets you control Hauppauge WinTV

'TODO:
'-Testing

Class WinTV
	
	Private m_Self
	Private mainMenu
	Private tvRemoteMenu
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = True
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = g_(Me,"WinTV")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"Lets you control Hauppauge WinTV")
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
		If IsEmpty(Settings(Me, "Title")) or Settings(Me, "Title") = "" Then Settings(Me, "Title") = "WinTV32"
		If IsEmpty(Settings(Me, "Exe"))   or Settings(Me, "Exe")   = "" Then Settings(Me, "Exe")   = "C:\Program Files\WinTV\WinTV2K.exe"
		
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
		tvRemoteMenu.Title = g_(Me,"WinTV - Remote")
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
		If WinTVOpen Then
			bi.Item = Array(g_(Me,"Remote Mode"),  Self & ".TVList")
			bi.Item = Array(g_(Me,"Channel Up"),   Self & ".ChannelUp")
			bi.Item = Array(g_(Me,"Channel Down"), Self & ".ChannelDown")
			bi.Item = Array(g_(Me,"Fullscreen"),   Self & ".Fullscreen")
			bi.Item = Array(g_(Me,"Freeze"),       Self & ".Freeze")
			bi.Item = Array(g_(Me,"Snapshot"),     Self & ".Snapshot")
			bi.Item = Array(g_(Me,"Close"),        Self & ".Close")
		Else
			bi.Item = Array(g_(Me,"Launch"),       Self & ".Launch")
		End If
		mainMenu.SetList llist
		mainMenu.Title = TITLE
		mainMenu.ShowMenu
	End Sub
	
	Function WinTVOpen
		WinTVOpen = Shell.AppActivate(Settings(Me, "Title"))
	End Function
	
	Sub Launch
		If Fso.FileExists(Settings(Me, "Exe")) Then
			Shell.Exec Settings(Me, "Exe")
			Util.WaitForAppLoad Settings(Me, "Title"), 10000 'Give WinTV max. 10 secs to load
		Else
			Debug.ErrorMsg Self & " - Launch: File not found: " & Settings(Me, "Exe")
		End If
		Show
	End Sub
	
	Sub Close
		If WinTVOpen Then
			Shell.SendKeys "%{F4}"
			Util.Sleep 3000 'Give WinTV 3secs to close itself
		End If
		Show
	End Sub
	
	Sub TVList
		tvRemoteMenu.ShowMenu
	End Sub
	
	Sub Button1
		If WinTVOpen Then	 Shell.SendKeys 1
		am.Update
	End Sub
	Sub Button2
		If WinTVOpen Then	 Shell.SendKeys 2
		am.Update
	End Sub
	Sub Button3
		If WinTVOpen Then	 Shell.SendKeys 3
		am.Update
	End Sub
	Sub Button4
		If WinTVOpen Then	 Shell.SendKeys 4
		am.Update
	End Sub
	Sub Button5
		If WinTVOpen Then	 Shell.SendKeys 5
		am.Update
	End Sub
	Sub Button6
		If WinTVOpen Then	 Shell.SendKeys 6
		am.Update
	End Sub
	Sub Button7
		If WinTVOpen Then	 Shell.SendKeys 7
		am.Update
	End Sub
	Sub Button8
		If WinTVOpen Then	 Shell.SendKeys 8
		am.Update
	End Sub
	Sub Button9
		If WinTVOpen Then	 Shell.SendKeys 9
		am.Update
	End Sub
	Sub Button0
		If WinTVOpen Then	 Shell.SendKeys 0
		am.Update
	End Sub
	
	Sub ChannelUp
		If WinTVOpen Then Shell.SendKeys "{+}"
		am.Update
	End Sub
	
	Sub ChannelDown
		If WinTVOpen Then Shell.SendKeys "{-}"
		am.Update
	End Sub
	
	Sub Fullscreen
		If WinTVOpen Then Shell.SendKeys "^t"
		am.Update
	End Sub
	
	Sub Freeze
		If WinTVOpen Then Shell.SendKeys "^f"
		am.Update
	End Sub
	
	Sub Snapshot
		If WinTVOpen Then Shell.SendKeys "{ }"
		am.Update
	End Sub

End Class

