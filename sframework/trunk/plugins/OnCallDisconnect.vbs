'FMA Script Framework Plugin
'OnCallDisconnect
'This will temporary disconnect your phone from FMA when you have a call
'>> originally designed so you can use your BT headset

'TODO:
'testing

Class OnCallDisconnect
	
	Private m_Self
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = False
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = "On Call Disconnect"
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = "This will temporary disconnect your phone from FMA when you have a call"
	End Property
	Public Property Get AUTHOR 'Who created me?
		AUTHOR      = "mhr"
	End Property
	Public Property Get URL 'Were can I be found? Where can you get more information?
		URL = "http://www.mobileagent.info/forums"
	End Property
	
	'Who am I?
	Public Property Let Self (s)
		m_Self = s
		EventManager.RegisterEvent "Call", s & ".Disc", Me
	End Property
	
	Public Property Get Self
		Self = m_Self
	End Property

	Sub Disc(Amode, Cname, Cnumber)
		fma.DisconnectTemporary
	End Sub
	
End Class