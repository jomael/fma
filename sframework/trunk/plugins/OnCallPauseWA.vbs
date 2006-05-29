'FMA Script Framework Plugin
'OnCallPauseWA
'This will pause Winamp when you've got an incoming call on yout phone

'TODO:
'-nothing atm

Class OnCallPauseWA
	
	Private m_Self
	Private m_WinampState
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = False
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = g_(Me,"On Call Pause Winamp")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"This will puse Winamp when incoming call")
	End Property
	Public Property Get AUTHOR 'Who created me?
		AUTHOR      = "vo.x"
	End Property
	Public Property Get URL 'Were can I be found? Where can you get more information?
		URL = "http://fma.xinium.com/"
	End Property
	
	'Who am I?
	Public Property Let Self (s)
		m_Self = s
		EventManager.RegisterEvent "MusicMute", s & ".MuteWinamp", Me
	End Property
	
	Public Property Get Self
		Self = m_Self
	End Property
	
	Sub MuteWinamp(Start)
		If Start = 1 Then m_WinampState = LCase(ActiveXManager("WinampCOMLib.WinampCOMObj").GetSongState)
			
		If m_WinampState = "playing" Then ActiveXManager("WinampCOMLib.WinampCOMObj").Pause
	End Sub
End Class