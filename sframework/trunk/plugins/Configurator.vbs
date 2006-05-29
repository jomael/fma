'FMA Script Framework Core Plugin
'Configurator

'TODO:
'-nothing atm

Class Configurator
	
	Private m_Self
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = True
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = g_(Me,"Configurator")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"FMA Scripting Framework Configurator")
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
		'Some init stuff here
		EventManager.RegisterEvent "Init", m_Self & ".Splash", Me
	End Property
	Public Property Get Self
		Self = m_Self
	End Property
	
	Sub Show()
		Shell.Exec ScriptFolder & "helper\config\config.exe"
		am.Update
	End Sub
	
	Sub Splash()
		fma.AddCmd g_(Me,"Script Configurator"), "Shell.Exec """ & ScriptFolder & "helper\config\config.exe"""
		'Shell.Exec ScriptFolder & "helper\config\config.exe splash"
	End Sub

End Class