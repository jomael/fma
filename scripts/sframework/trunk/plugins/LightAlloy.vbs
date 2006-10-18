'FMA Script Framework Plugin
'Light Alloy
'Lets you control Light Alloy

'tested with Light Alloy 4.0
'TODO:
'-Testing with old versions of Light Alloy

Class LightAlloy

	Private m_Self
	Private mainMenu

	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = True
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = g_(Me,"Light Alloy")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"Lets you control Light Alloy")
	End Property
	Public Property Get AUTHOR 'Who created me?
		AUTHOR      = "Vladimir Lukianov"
	End Property
	Public Property Get URL 'Were can I be found? Where can you get more information?
		URL = "http://fma.xinium.com/"
	End Property

	'Who am I?
	Public Property Let Self (s)
		m_Self = s
		' Some init stuff here:
		If IsEmpty(Settings(Me, "Title")) or Settings(Me, "Title") = "" Then Settings(Me, "Title") = "Light Alloy"
		If IsEmpty(Settings(Me, "Exe"))   or Settings(Me, "Exe")   = "" Then Settings(Me, "Exe")   = "C:\Program Files\Light Alloy\LA.exe"
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
		If LightAlloyOpen Then
			bi.Item = Array(g_(Me,"Play"),    Self & ".Play")
			bi.Item = Array(g_(Me,"Stop"),          Self & ".Stopp")
			bi.Item = Array(g_(Me,"Window/Fullscreen"),    Self & ".Fullscreen")
			bi.Item = Array(g_(Me,"Jump ahead"),    Self & ".JumpAhead")
			bi.Item = Array(g_(Me,"Jump back"),     Self & ".JumpBack")
			bi.Item = Array(g_(Me,"Volume +"),      Self & ".VolumeUp")
			bi.Item = Array(g_(Me,"Volume -"),      Self & ".VolumeDn")
			bi.Item = Array(g_(Me,"(Un)Mute"),      Self & ".VolumeMute")
			bi.Item = Array(g_(Me,"Rewind"),        Self & ".Rewind")
			bi.Item = Array(g_(Me,"Close"),         Self & ".Close")
		Else
			bi.Item = Array(g_(Me,"Launch"),        Self & ".Launch")
		End If
		mainMenu.SetList llist
		mainMenu.ShowMenu
	End Sub

	Function LightAlloyOpen
		LightAlloyOpen = Shell.AppActivate(Settings(Me, "Title"))
	End Function

	Sub Launch
		If Fso.FileExists(Settings(Me, "Exe")) Then
			Shell.Exec Settings(Me, "Exe")
			Util.WaitForAppLoad Settings(Me, "Title"), 10000 'Give LightAlloy max. 10 secs to load
		Else
			Debug.ErrorMsg Self & " - Launch: File not found: " & Settings(Me, "Exe")
		End If
		Show
	End Sub

	Sub Close
		If LightAlloyOpen Then
			Shell.SendKeys "%{F4}"
			Util.Sleep 3000 'Give LightAlloy 3secs to close itself
		End If
		Show
	End Sub

	Sub Play
		If LightAlloyOpen Then Shell.SendKeys "x"
		am.Update
	End Sub

	Sub Stopp
		If LightAlloyOpen Then Shell.SendKeys "v"
		am.Update
	End Sub

	Sub JumpAhead
		If LightAlloyOpen Then Shell.SendKeys "+{RIGHT}"
		am.Update
	End Sub

	Sub JumpBack
		If LightAlloyOpen Then Shell.SendKeys "+{LEFT}"
		am.Update
	End Sub

	Sub VolumeUp
		If LightAlloyOpen Then Shell.SendKeys "{UP}"
		am.Update
	End Sub

	Sub VolumeDn
		If LightAlloyOpen Then Shell.SendKeys "{DOWN}"
		am.Update
	End Sub

	Sub VolumeMute
		If LightAlloyOpen Then Shell.SendKeys "^m"
		am.Update
	End Sub

	Sub Fullscreen
		If LightAlloyOpen Then Shell.SendKeys "{ENTER}"
		am.Update
	End Sub

	Sub Rewind
		If LightAlloyOpen Then Shell.SendKeys "{BACKSPACE}"
		am.Update
	End Sub

End Class

