'FMA Script Framework Plugin
'PowerDVD5
'Lets you control PowerDVD5

'TODO:
'-Testing

Class PowerDVD5
	
	Private llist
	Private m_Self
	Private mainMenu
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = True
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = g_(Me,"PowerDVD 5")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"Lets you control PowerDVD5")
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
		If IsEmpty(Settings(Me, "Title")) or Settings(Me, "Title") = "" Then Settings(Me, "Title") = "PowerDVD"
		If IsEmpty(Settings(Me, "Exe"))   or Settings(Me, "Exe")   = "" Then Settings(Me, "Exe")   = "C:\Program Files\Cyberlink\PowerDVD\PowerDVD.exe"
		Set mainMenu = New ManagedMenu
		mainMenu.Title = TITLE
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
		If PowerDVDOpen Then
			bi.Item = Array(g_(Me,"Play"),          Self & ".Play")
			bi.Item = Array(g_(Me,"Pause"),         Self & ".Pause")
			bi.Item = Array(g_(Me,"Stop"),          Self & ".Stopp")
			bi.Item = Array(g_(Me,"Prev Chapter"),  Self & ".PrevChapter")
			bi.Item = Array(g_(Me,"Next Chapter"),  Self & ".NextChapter")
			bi.Item = Array(g_(Me,"AudioStream"),   Self & ".AudioStream")
			bi.Item = Array(g_(Me,"Subtitles"),     Self & ".SubTitles")
			bi.Item = Array(g_(Me,"Fullscreen"),    Self & ".Fullscreen")
			bi.Item = Array(g_(Me,"Volume +5"),     Self & ".VolumeUp")
			bi.Item = Array(g_(Me,"Volume -5"),     Self & ".VolumeDown")
			bi.Item = Array(g_(Me,"(Un)Mute"),      Self & ".Mute")
			bi.Item = Array(g_(Me,"Step Backward"), Self & ".StepBwd")
			bi.Item = Array(g_(Me,"Step Forward"),  Self & ".StepFwd")
			bi.Item = Array(g_(Me,"Set Repeat"),    Self & ".Repeat")
			bi.Item = Array(g_(Me,"Capture Frame"), Self & ".CaptureFrame")
			bi.Item = Array(g_(Me,"Minimize"),      Self & ".Minimize")
			bi.Item = Array(g_(Me,"Close"),         Self & ".Close")
		Else
			bi.Item = Array(g_(Me,"Launch"),        Self & ".Launch")
		End If
		mainMenu.SetList llist
		mainMenu.ShowMenu
	End Sub
	
	Function PowerDVDOpen
		PowerDVDOpen = Shell.AppActivate(Settings(Me, "Title"))
	End Function
	
	Sub Launch
		If Fso.FileExists(Settings(Me, "Exe")) Then
			Shell.Exec Settings(Me, "Exe")
			Util.WaitForAppLoad Settings(Me, "Title"), 10000 'Give PDVD max. 10 secs to load
		Else
			Debug.ErrorMsg Self & " - Launch: File not found: " & Settings(Me, "Exe")
		End If
		Show
	End Sub
	
	Sub Close
		If PowerDVDOpen Then
			Shell.SendKeys "^x"
			Util.Sleep 3000 'Give PDVD 3secs to close itself
		End If
		Show
	End Sub
	
	Sub Play
		If PowerDVDOpen Then Shell.SendKeys "~"
		am.Update
	End Sub
	
	Sub Pause
		If PowerDVDOpen Then Shell.SendKeys "{ }"
		am.Update
	End Sub
	
	Sub Stopp
		If PowerDVDOpen Then Shell.SendKeys "s"
		am.Update
	End Sub
	
	Sub PrevChapter
		If PowerDVDOpen Then Shell.SendKeys "p"
		am.Update
	End Sub
	
	Sub NextChapter
		If PowerDVDOpen Then Shell.SendKeys "n"
		am.Update
	End Sub
	
	Sub SubTitles
		If PowerDVDOpen Then Shell.SendKeys "u"
		am.Update
	End Sub
	
	Sub Repeat
		If PowerDVDOpen Then Shell.SendKeys "r"
		am.Update
	End Sub
	
	Sub StepBwd
		If PowerDVDOpen Then Shell.SendKeys "^b"
		am.Update
	End Sub
	
	Sub StepFwd
		If PowerDVDOpen Then Shell.SendKeys "t"
		am.Update
	End Sub
	
	Sub CaptureFrame
		If PowerDVDOpen Then Shell.SendKeys "c"
		am.Update
	End Sub
	
	Sub AudioStream
		If PowerDVDOpen Then Shell.SendKeys "h"
		am.Update
	End Sub
	
	Sub VolumeUp
		If PowerDVDOpen Then Shell.SendKeys "{+}"
		am.Update
	End Sub
	
	Sub VolumeDown
		If PowerDVDOpen Then Shell.SendKeys "{-}"
		am.Update
	End Sub
	
	Sub Mute
		If PowerDVDOpen Then Shell.SendKeys "q"
		am.Update
	End Sub
	
	Sub Fullscreen
		If PowerDVDOpen Then Shell.SendKeys "z"
		am.Update
	End Sub
	
	Sub Minimize
		If PowerDVDOpen Then Shell.SendKeys "^n"
		am.Update
	End Sub	
	
End Class

