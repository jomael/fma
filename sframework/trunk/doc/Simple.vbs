'FMA Script Framework Plugin
'Simple plugin

Class Simple
	
	Private m_Self 'Here your own name will be stored. We'll cover that later... See also Property Let/Get Self
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = True
	End Property
	Public Property Get TITLE 'What's my name? This will be the title of your menu entry in the main menu
		TITLE       = "Simple plugin"
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = "A minimum example for a plugin"
	End Property
	Public Property Get AUTHOR 'Who created me?
		AUTHOR      = "streawkceur"
	End Property
	Public Property Get URL 'Were can I be found? Where can you get more information?
		URL         = "http://fma.xinium.com/"
	End Property
	
	'Who am I?
	Public Property Let Self (s)
		m_Self = s
	End Property
	Public Property Get Self
		Self = m_Self
	End Property
	
	'Show will be called every time the user selects your plugin from the main menu
	Sub Show()
		'Just put a log message to FMA
		Debug.InfoMsg "Developing plugins is simple!"
		'put an am.Update to prevent the menu from getting stuck
		am.Update
	End Sub

End Class

