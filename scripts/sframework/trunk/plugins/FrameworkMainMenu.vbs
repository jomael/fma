'FMA Script Framework Core Plugin
'MainMenu
'The main menu that is shown as root menu

'TODO:
'-nothing atm. does what it should

Class FrameworkMainMenu
	
	Private List
	Private m_Self
	Private mainMenu
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = False 'This will prevent from adding myself to my plugin list
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = g_(Me,"Main Menu")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"Shows a list of all loaded and showable plugin")
	End Property
	Public Property Get AUTHOR 'Who created me?
		AUTHOR      = "dVrVm"
	End Property
	Public Property Get URL 'Were can I be found? Where can you get more information?
		URL = "http://fma.xinium.com/"
	End Property
	
	Public Property Let Self (s)
		m_Self = s
		Set List = New LinkedList
		EventManager.RegisterEvent "AMRoot", s & ".Show", Me
		Set mainMenu = New ManagedMenu
		mainMenu.Title = TITLE
	End Property
	Public Property Get Self
		Self = m_Self
	End Property
	
	Sub Show()
		Refresh
		Set MenuStack = Nothing
		Set MenuStack = New Stack
		mainMenu.ShowMenu
	End Sub
	
	Sub Refresh( )
		Dim pluginList, menuList, bi, it, comp
		Set comp = New PluginTitleComparator
		Set pluginList = PluginManager.GetLoadedPluginsLinkedList
		QuickSorter.ComparatorSortLL pluginList, comp
		Set menuList = New LinkedList
		
		bi = menuList.BackInserter
		it = pluginList.Begin
		'Add showable plugins with their title and show method
		Do Until it.Object Is pluginList.Last.Object
			If PluginManager(it.Item).SHOWABLE Then
				bi.Item = Array(PluginManager(it.Item).TITLE, "PluginManager(""" & it.Item & """).Show")
				Debug.DebugMsg "MainMenu added: " & it.Item
			Else
				Debug.DebugMsg "MainMenu not added: " & it.Item
			End If
			it.iterate()
		Loop
		
		mainMenu.SetList menuList
	End Sub
End Class
