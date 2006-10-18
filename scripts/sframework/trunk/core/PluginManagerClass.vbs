'FMA Script Framework Core Class
'PluginManagerClass
'Interface to the plugin classes

'Interface:
'	-Attributes:
' 	-Self (Let/Get)
'		-PluginManager.Plugin( className ):object ^= PluginManager( className ):object
'	-Methods:
'		-LoadPlugin( className )
'		-UnloadPlugin( className )
'		-IsLoaded( className ):boolean
'		-GetLoadedPluginsArray:array
'		-GetLoadedPluginsLinkedList:LinkedList

'TODO
'-plugin dependencies? could be a hard job...

Class PluginManagerClass
	
	Private m_Self
	Private loadedPlugins
	
	Sub Class_Initialize()
		Set loadedPlugins   = New Hash
	End Sub
	
	Public Property Let Self (s)
		m_Self = s
		If IsEmpty(Settings(Me, "Don't load")) or Settings(Me, "Don't load") = "" Then Settings(Me, "Don't load") = ""
	End Property
	Public Property Get Self
		Self = m_Self
	End Property
	
	'Return plugin object by given plugin class name
	Public Default Property Get Plugin( className )
		If IsLoaded(className) Then
			Set Plugin = loadedPlugins(className)
		Else
			Set Plugin = Nothing
		End If
	End Property
	
	'Create object from class, append to loaded plugin list
	Sub LoadPlugin( pluginFile )
		Dim className

		'Determine class and object name
		className = pluginFile
		If InStr(pluginFile.Name, ".") > 0 Then className = Left(pluginFile.Name, InStr(pluginFile.Name, ".") - 1)

		If not IsLoaded(className) Then
			Debug.DebugMsg "Loading plugin: " & className

			Set loadedPlugins(className) = Util.CreatePluginObject(pluginFile, className, Self & "(""" & className & """)")
			'Debug.DebugMsg "Plugin: " & className & " loaded"
		Else
			Debug.DebugMsg Self & ": Plugin """ & className & """ already loaded!"
		End If
	End Sub
	
	'Kill object, remove from loaded plugin list
	Sub UnloadPlugin( className )
		Debug.DebugMsg "Unloading plugin: " & className
		If IsLoaded(className) Then
			'Deregister events and keys of plugin
			EventManager.DeregisterAll loadedPlugins(className)
			KeyManager.DeregisterAll loadedPlugins(className)
			
			loadedPlugins.DeleteItem className
			Debug.DebugMsg "Plugin unloaded: " & className
		End If
	End Sub
	
	'Is this one loaded?
	Function IsLoaded( className )
		IsLoaded = (Not IsEmpty(loadedPlugins(className)))
	End Function
	
	'returns an (unsorted) array with the class names of all loaded plugins
	Function GetLoadedPluginsArray()
		GetLoadedPluginsArray = loadedPlugins.GetKeysArray
	End Function
	
	'returns an (unsorted) linked list with the class names of all loaded plugins
	Function GetLoadedPluginsLinkedList()
		Set GetLoadedPluginsLinkedList = loadedPlugins.GetKeysLinkedList
	End Function
	
	' Generates a string which will include the pluginclasses and create the plugin objects when Execute()'ed
	Sub LoadPlugins()
		If Fso.FolderExists(ScriptFolder & "plugins") Then
			Dim pluginFolder, pluginFiles, pluginFile, excludeList, exclude, match
			Set pluginFolder = Fso.GetFolder(ScriptFolder & "plugins")
			Set pluginFiles = pluginFolder.Files
			excludeList = Split(Settings(Me, "Don't load"), ",", -1, vbTextCompare)
			
			For Each pluginFile in pluginFiles
				If LCase(Right(pluginFile, 4)) = ".vbs" Then 'Only load .vbs files
					match = False
					For Each exclude In excludeList
						If InStr(LCase(pluginFile.Name), LCase(Trim(exclude))) > 0 Then
							match = True
							Exit For
						End If
					Next
					If match Then
						Debug.DebugMsg Self & ": Plugin """ & pluginFile.Name & """ not loaded!"
					Else
						'Load the plugin via the plugin manager
						LoadPlugin(pluginFile)
					End If
				End If
			Next
		Else
			Debug.ErrorMsg Self & ": Folder " & ScriptFolder & "plugin" & " doesn't exist. No plugins loaded!"
		End If
	End Sub
	
End Class

Class PluginTitleComparator
	Public Function Compare( ByRef p1, ByRef p2 )
		Dim a, b
		a = PluginManager(CStr(p1)).TITLE
		b = PluginManager(CStr(p2)).TITLE
		a = LCase(a)
		b = LCase(b)
		If a = b Then
			Compare = 0
		ElseIf a < b Then
			Compare = -1
		Else
			Compare = 1
		End If
	End Function
End Class
