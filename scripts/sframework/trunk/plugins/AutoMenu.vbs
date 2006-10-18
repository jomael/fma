'FMA Script Framework Plugin
'AutoMenu
'This will go to a specified plugin menu after connection.
'The menu can be specified with the configurator
'TODO:
'-nothing atm

Class AutoMenu
	
	Private m_Self
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = False
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = g_(Me,"AutoMenu")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"This will go into the accessories menu after connection")
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
		If IsEmpty(Settings(Me, "Menu")) Or Settings(Me, "Menu") = "" Then Settings(Me, "Menu") = "FrameworkMainMenu" 'MainMenu as default
		EventManager.RegisterEvent "Connected", m_Self & ".GotoMenu", Me
	End Property
	Public Property Get Self
		Self = m_Self
	End Property
	
	Sub GotoMenu
		'Show main menu first
		If PluginManager.IsLoaded("FrameworkMainMenu") Then
			PluginManager("FrameworkMainMenu").Show
		Else
			Debug.ErrorMsg Self & ": Couldn't go to FrameworkMainMenu! The plugin is not loaded."
		End If
		'Show specific plugin menu
		If LCase(Settings(Me, "Menu")) <> "frameworkmainmenu" And PluginManager.IsLoaded(Settings(Me, "Menu")) Then
			PluginManager(Settings(Me, "Menu")).Show
		Else
			Debug.ErrorMsg Self & ": Couldn't go to menu """ & Settings(Me, "Menu") & """! The plugin is not loaded."
		End If
	End Sub
	
End Class
