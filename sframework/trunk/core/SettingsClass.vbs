'FMA Script Framework Core Class
'Settings
'Central place to read and store settings

'Interface:
'-Attributes
' -Settings( plugin, key ):value   ^= Settings.PluginSetting( plugin, key ):value
' -Settings( plugin, key ) = value ^= Settings.PluginSetting( key ) = value
' -Settings.Setting( key ):value
' -Settings.Setting( key ) = value
'-Methods:
' -Settings.DeletePluginSetting( plugin, key )
' -Settings.DeleteSetting( key )
' -Settings.Load()
' -Settings.Save()

'TODO:
'-nothing atm

Class SettingsClass
	
	Private settingsFile
	Private settingsHash
	Private m_Self
	
	Sub Class_Initialize()
		Set settingsHash = New Hash
		settingsFile = "fma.settings"
	End Sub
	
	'self
	Public Property Let Self (s)
		m_Self = s
		'EventManager.RegisterEvent "Init",           s & ".Load", Me
		EventManager.RegisterEvent "Connected",      s & ".Load", Me
		EventManager.RegisterEvent "Disconnected",   s & ".Save", Me
		EventManager.RegisterEvent "ConnectionLost", s & ".Save", Me
	End Property
	Public Property Get Self
		Self = m_Self
	End Property
	
	'return value or object by key
	Public Default Property Get PluginSetting( plugin, key )
		PluginSetting = settingsHash( plugin.Self & "\" & key )
	End Property
	
	'assign value to key
	Public Property Let PluginSetting( plugin, key, value )
		settingsHash( plugin.Self & "\" & key ) = value
	End Property
	
	'deletes the entry with the given key
	Public Sub DeletePluginSetting( plugin, key )
		settingsHash.DeleteItem( plugin.Self & "\" & key )
	End Sub	
	
	'return value or object by key
	Public Property Get Setting( key )
		Setting = settingsHash( key )
	End Property
	
	'assign value to key
	Public Property Let Setting( key, value )
		settingsHash( key ) = value
	End Property
	
	'deletes the entry with the given key
	Public Sub DeleteSetting( key )
		settingsHash.DeleteItem( key )
	End Sub	
	
	Sub Load()
		Debug.InfoMsg "Loading Settings"
		'We use ImportFromFile to prevent the deletion of new settings
		settingsHash.ImportFromFile ScriptFolder & settingsFile
	End Sub
	
	Sub Save()
		Debug.InfoMsg "Saving Settings"
		settingsHash.SaveToFile ScriptFolder & settingsFile
	End Sub
	
End Class

