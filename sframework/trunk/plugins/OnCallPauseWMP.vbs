'FMA Script Framework Plugin
'OnCallPauseWMP
'This will pause WMP when you've got an incoming call on your phone

'Note: MusicMute event is called also when you receive e-mail and such,
'      so be careful about it, you might want to disable this plugin
'TODO:
'-nothing atm

Class OnCallPauseWMP
	
	Private m_Self
	Private m_WMPruns
	Private m_WMPcore
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = False
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = g_(Me,"On Call Pause WMP")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"Pauses WMP on incoming call")
	End Property
	Public Property Get AUTHOR 'Who created me?
		AUTHOR      = "mhr"
	End Property
	Public Property Get URL 'Were can I be found? Where can you get more information?
		URL = "http://www.mobileagent.info/"
	End Property
	
	'Who am I?
	Public Property Let Self (s)
		m_Self = s
		EventManager.RegisterEvent "MusicMute", s & ".MuteWMP", Me
	End Property
	
	Public Property Get Self
		Self = m_Self
	End Property
	
	Sub MuteWMP(Start)
		On Error Resume Next
		m_WMPruns = ActiveXManager("WMPuICE.WMPApp").Running
		If m_WMPruns Then
		Set m_WMPcore = ActiveXManager("WMPuICE.WMPApp").Core
			If Start = 1 Then
				If (m_WMPcore.playstate=3) Then m_WMPcore.controls.pause
			Else
				If (m_WMPcore.playstate=2) Then m_WMPcore.controls.play
			End If
		End If
		On Error GoTo 0
	End Sub
End Class