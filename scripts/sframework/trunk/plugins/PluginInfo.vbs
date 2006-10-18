'FMA Script Framework Core Plugin
'PluginInfo
'Offers some information of the available plugins

'TODO:
'-nothing atm

Class PluginInfo
	
	Private m_Self
	Private mainMenu
	Private pluginMenu
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = True
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = g_(Me,"Plugin Info")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"Offers some information about the loaded plugins")
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
		Set mainMenu   = New ManagedMenu
		Set pluginMenu = New ManagedMenu
	End Property
	Public Property Get Self
		Self = m_Self
	End Property
	
	Sub Show()
		Dim pluginList, menuList, bi, it, comp
		Set comp = New PluginTitleComparator
		Set pluginList = PluginManager.GetLoadedPluginsLinkedList
		QuickSorter.ComparatorSortLL pluginList, comp
		Set menuList = New LinkedList
		
		bi = menuList.BackInserter
		it = pluginList.Begin
		'Add all plugins
		Do Until it.Object Is pluginList.Last.Object
			bi.Item = Array(it.Item, Self & ".InfoMenu"""& it.Item & """")
			it.iterate()
		Loop
		mainMenu.SetList menuList
		mainMenu.Title = TITLE
		mainMenu.ShowMenu
	End Sub
	
	' Shows a menu with plugin information
	Sub InfoMenu( plugin )
		Dim menuList, bi
		Set menuList = New LinkedList
		
		bi = menuList.BackInserter
		bi.Item = Array(g_(Me,"Title"),       Self & ".InfoTitle"""  & plugin & """")
		bi.Item = Array(g_(Me,"Description"), Self & ".InfoDescr"""  & plugin & """")
		bi.Item = Array(g_(Me,"Author"),      Self & ".InfoAuthor""" & plugin & """")
		bi.Item = Array(g_(Me,"URL"),         Self & ".InfoURL"""    & plugin & """")
		pluginMenu.Title = plugin
		pluginMenu.SetList menuList
		pluginMenu.ShowMenu
	End Sub
	
	Sub InfoTitle( plugin )
		EmptyMenu.ShowMenu
		am.DlgInformation g_(Me,"Title"), PluginManager(plugin).TITLE
	End Sub
	
	Sub InfoDescr( plugin )
		EmptyMenu.ShowMenu
		am.DlgInformation g_(Me,"Description"), PluginManager(plugin).DESCRIPTION
	End Sub
	
	Sub InfoAuthor( plugin )
		EmptyMenu.ShowMenu
		am.DlgInformation g_(Me,"Author(s)"), PluginManager(plugin).AUTHOR
	End Sub
	
	Sub InfoURL( plugin )
		If PluginManager(plugin).URL <> "" Then Shell.Run "RunDLL32.EXE shell32.dll,ShellExec_RunDLL """ & PluginManager(plugin).URL & """"
		am.Update
	End Sub

End Class