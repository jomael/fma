'FMA Script Framework Plugin
'WinDVD
'Lets you control Intervideo WinDVD

'TODO:
'-Testing
'-Maybe implement DVD Menu with joystick instead of menu items

Class WinDVD
	
	Private m_Self
	Private mainMenu
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = True
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = g_(Me,"WinDVD")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"Lets you control Intervideo WinDVD")
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
		' Some init stuff here:
		If IsEmpty(Settings(Me, "Title")) or Settings(Me, "Title") = "" Then Settings(Me, "Title") = "Intervideo WinDVD"
		If IsEmpty(Settings(Me, "Exe"))   or Settings(Me, "Exe")   = "" Then Settings(Me, "Exe")   = "C:\Program Files\InterVideo\DVD5\WinDVD.exe"
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
		If WDVDOpen Then
			bi.Item = Array(g_(Me,"Play"),          Self & ".Play")
			bi.Item = Array(g_(Me,"Pause/Resume"),  Self & ".Pause")
			bi.Item = Array(g_(Me,"Stop"),          Self & ".Stopp")
			bi.Item = Array(g_(Me,"Prev Chapter"),  Self & ".PrevChapter")
			bi.Item = Array(g_(Me,"Next Chapter"),  Self & ".NextChapter")
			bi.Item = Array(g_(Me,"Audio Stream"),  Self & ".AudioStream")
			bi.Item = Array(g_(Me,"Volume +"),      Self & ".VolumeUp")
			bi.Item = Array(g_(Me,"Volume -"),      Self & ".VolumeDn")
			bi.Item = Array(g_(Me,"(Un)Mute"),      Self & ".VolumeMute")
			bi.Item = Array(g_(Me,"?SubTitles"),    Self & ".SubTitles")
			bi.Item = Array(g_(Me,"Fullscreen"),    Self & ".Fullscreen")
			bi.Item = Array(g_(Me,"Step Backward"), Self & ".StepBwd")
			bi.Item = Array(g_(Me,"Step Forward"),  Self & ".StepFwd")
			bi.Item = Array(g_(Me,"Speed +"),       Self & ".SpeedUp")
			bi.Item = Array(g_(Me,"Speed -"),       Self & ".SpeedDn")
			bi.Item = Array(g_(Me,"Step Forward"),  Self & ".StepFwd")
			bi.Item = Array(g_(Me,"Capture Frame"), Self & ".CaptureFrame")
			bi.Item = Array(g_(Me,"DVD Menu"),      Self & ".DVDMenu")
			bi.Item = Array(g_(Me,"Select"),        Self & ".MenuSelect")
			bi.Item = Array(g_(Me,"Up"),            Self & ".Up")
			bi.Item = Array(g_(Me,"Down"),          Self & ".Down")
			bi.Item = Array(g_(Me,"Left"),          Self & ".Left")
			bi.Item = Array(g_(Me,"Right"),         Self & ".Right")
			bi.Item = Array(g_(Me,"Close"),         Self & ".Close")
		Else
			bi.Item = Array(g_(Me,"Launch"),        Self & ".Launch")
		End If
		mainMenu.SetList llist
		mainMenu.ShowMenu
	End Sub
	
	Function WDVDOpen
		WDVDOpen = Shell.AppActivate(Settings(Me, "Title"))
	End Function
	
	Sub Launch
		If Fso.FileExists(Settings(Me, "Exe")) Then
			Shell.Exec Settings(Me, "Exe")
			Util.WaitForAppLoad Settings(Me, "Title"), 10000 'Give WDVD max. 10 secs to load
		Else
			Debug.ErrorMsg Self & " - Launch: File not found: " & Settings(Me, "Exe")
		End If
		Show
	End Sub
	
	Sub Close
		If WDVDOpen Then
			Shell.SendKeys "%{F4}"
			Util.Sleep 3000 'Give WDVD 3secs to close itself
		End If
		Show
	End Sub
	
	Sub Play
		If WDVDOpen Then Shell.SendKeys "^p"
		am.Update
	End Sub
	
	Sub Pause
		If WDVDOpen Then Shell.SendKeys "{ }"
		am.Update
	End Sub
	
	Sub Stopp
		If WDVDOpen Then Shell.SendKeys "{END}"
		am.Update
	End Sub
	
	Sub PrevChapter
		If WDVDOpen Then Shell.SendKeys "{PGUP}"
		am.Update
	End Sub
	
	Sub NextChapter
		If WDVDOpen Then Shell.SendKeys "{PGDN}"
		am.Update
	End Sub
	
	Sub AudioStream
		If WDVDOpen Then Shell.SendKeys "a"
		am.Update
	End Sub
	
	Sub VolumeUp
		If WDVDOpen Then Shell.SendKeys "+{UP}"
		am.Update
	End Sub
	
	Sub VolumeDn
		If WDVDOpen Then Shell.SendKeys "+{DOWN}"
		am.Update
	End Sub
	
	Sub VolumeMute
		If WDVDOpen Then Shell.SendKeys "m"
		am.Update
	End Sub
	
	Sub SubTitles
		If WDVDOpen Then Shell.SendKeys "s"
		am.Update
	End Sub
	
	Sub Fullscreen
		If WDVDOpen Then Shell.SendKeys "z"
		am.Update
	End Sub
	
	Sub SpeedUp
		If WDVDOpen Then Shell.SendKeys "^{RIGHT}"
		am.Update
	End Sub
	
	Sub SpeedDn
		If WDVDOpen Then Shell.SendKeys "^{LEFT}"
		am.Update
	End Sub
	
	Sub StepBwd
		If WDVDOpen Then Shell.SendKeys "^n"
		am.Update
	End Sub
	
	Sub StepFwd
		If WDVDOpen Then Shell.SendKeys "n"
		am.Update
	End Sub
	
	Sub CaptureFrame
		If WDVDOpen Then Shell.SendKeys "p"
		am.Update
	End Sub
	
	Sub DVDMenu
		If WDVDOpen Then shell.SendKeys "^m"
		am.Update
	End Sub
	
	Sub MenuSelect
		If WDVDOpen Then shell.SendKeys "~"
		am.Update
	End Sub
	
	Sub Up
		If WDVDOpen Then shell.SendKeys "{UP}"
		am.Update
	End Sub
	
	Sub Down
		If WDVDOpen Then shell.SendKeys "{DOWN}"
		am.Update
	End Sub
	
	Sub Left
		If WDVDOpen Then shell.SendKeys "{LEFT}"
		am.Update
	End Sub
	
	Sub Right
		If WDVDOpen Then shell.SendKeys "{RIGHT}"
		am.Update
	End Sub
	
End Class

