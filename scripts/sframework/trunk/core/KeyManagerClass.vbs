'FMA Script Framework Core Class
'KeyManager
'Register your plugins for pressed keys
'
'Plugins may register for keys by doing:
'	Set item = KeyManager.RegisterKey( "<key>", "<command to execute>", <state>, <plugin-object> )
'Example:
'	Dim item
'	Set item = KeyManager.RegisterKey( KEY_JOYPRESS, "Debug.DebugMsg ""joystick pressed""", STATE_PRESS, Me )
'This will register the command Debug.DebugMsg "joystick pressed" for key
'down ":J" and from the plugin "Me" (which is the object from which you are calling)
'and save a reference to the event in the variable "item".
'This way you can easily deregister this key-event by doing:
'	item.Delete
'You may even collect key groups in LinkedList's and deregister them all at once:
'	Dim item, ll, bi
'	Set ll = New LinkedList
'	bi = ll.BackInserter
'	'Register:
'	Set bi.Item = KeyManager.RegisterKey( KEY_JOYPRESS,  "Debug.DebugMsg ""joystick pressed""",      STATE_PRESS, Me )
'	Set bi.Item = KeyManager.RegisterKey( KEY_SOFTLEFT,  "Debug.DebugMsg ""left softkey pressed""",  STATE_PRESS, Me )
'	Set bi.Item = KeyManager.RegisterKey( KEY_SOFTRIGHT, "Debug.DebugMsg ""right softkey pressed""", STATE_PRESS, Me )
'	'Deregister:
'	KeyManager.DeregisterAllFromLL ll
'If you don't want to deregister like this, you can just call:
'	KeyManager.RegisterKey KEY_JOYPRESS, "Debug.DebugMsg ""joystick pressed""", STATE_PRESS, Me
'without saving the reference. Then you can only deregister with DeregisterAll.
'
'Plugins may deregister ALL their registered keys at once by passing an object reference to themselves:
' KeyManager.DeregisterAll Me
'
'Plugins may even throw own key events by simply doing:
'	KeyManager.OnKey <key>
'
'TODO
'-nothing atm

'Some interesting, key related constants
Public Const KEY_JOYUP     = "^"
Public Const KEY_JOYDOWN   = "v"
Public Const KEY_JOYLEFT   = "<"
Public Const KEY_JOYRIGHT  = ">"
Public Const KEY_JOYPRESS  = ":J"
Public Const KEY_BACK      = ":R"
Public Const KEY_C         = "c"
Public Const KEY_SOFTLEFT  = "["
Public Const KEY_SOFTRIGHT = "]"
Public Const KEY_HOME      = ":O"
Public Const KEY_CAMERA    = ":C"
Public Const KEY_VOLUP     = "u"
Public Const KEY_VOLDOWN   = "d"
Public Const KEY_0         = "0"
Public Const KEY_1         = "1"
Public Const KEY_2         = "2"
Public Const KEY_3         = "3"
Public Const KEY_4         = "4"
Public Const KEY_5         = "5"
Public Const KEY_6         = "6"
Public Const KEY_7         = "7"
Public Const KEY_8         = "8"
Public Const KEY_9         = "9"
Public Const KEY_ASTERIX   = "*"
Public Const KEY_SHARP     = "#"
Public Const KEY_YES       = "s" 'T68i
Public Const KEY_NO        = "e" 'T68i
Public Const KEY_OPT       = "f" 'T68i

Public Const STATE_PRESS   = 1
Public Const STATE_RELEASE = 0

Class KeyManagerClass
	
	Private keyDnHash
	
	Private keyUpHash
	Private m_Self
	Private m_RegCount
	Private lastKey
	
	Sub Class_Initialize()
		Set keyDnHash = New Hash
		Set keyUpHash = New Hash
		m_RegCount = 0
	End Sub
	
	Public Property Let Self (s)
		m_Self = s
		EventManager.RegisterEvent "KeyPress",  s & ".OnKey", Me
		EventManager.RegisterEvent "Connected", s & ".EnableOnConnect", Me
	End Property
	Public Property Get Self
		Self = m_Self
	End Property
	
	Public Sub AddReg ()
		If m_RegCount = 0 then Me.Enable
		m_RegCount = m_RegCount + 1
	End Sub
	
	Public Sub DelReg ()
		m_RegCount = m_RegCount - 1
		If m_RegCount = 0 then Me.Disable
	End Sub
	
	' Executes all commands associated to the key k.
	Sub OnKey( k, state )
		Dim keyIt, keyLast, keyHash
		
		If state = 1 then
			Set keyHash = keyDnHash
			lastKey = k
			Debug.DebugMsg Self & ": Key " & k & " pressed"
		Else
			k = lastKey
			Set keyHash = keyUpHash
			Debug.DebugMsg Self & ": Key " & k & " released"
		End If
		If Not IsEmpty(keyHash(k)) Then 'Cannot iterate a non existing chain...
			keyIt   = keyHash(k).Begin
			keyLast = keyHash(k).Last
			Do Until keyIt.Object Is keyLast.Object
				Debug.DebugMsg Self & ": Executing " & keyIt.Item.Command & " for key " & k
				Execute(keyIt.Item.Command)
				keyIt.Iterate()
			Loop
		Else
			Debug.DebugMsg Self & ": Key " & k & " has no registered keys in it's chain"
		End If
	End Sub
	
	' Registers the command for the given key
	' This will append the command to the linked list, which is stored in the hash with the key "<key>"
	Function RegisterKey( k, command, state, plugin )
		Dim keyHash, e
		Set e = New KeyEventItem
		e.Command = command
		Set e.Plugin  = plugin
		
		If state = STATE_PRESS Then
			Set keyHash = keyDnHash
		Else
			Set keyHash = keyUpHash
		End If
		
		If k <> "" And command <> "" Then 'Don't register "empty" calls
			'Key not known before, create new key chain
			If IsEmpty(keyHash(k)) Then	Set keyHash(k) = New LinkedList
			'append command to key chain
			Set RegisterKey = keyHash(k).AddBack(e)
			Debug.DebugMsg Self & ": Registered """ & command & """ for key " & k
		End If
	End Function
	
	' Deregisters all commands that were registered by a specific plugin
	Sub DeregisterAll( plugin )
		Dim key, keyIt, keyLast, command, hashes, curHash
		hashes = Array(keyDnHash, keyUpHash)
		
		For Each curHash In hashes
			For Each key In curHash.GetKeysArray
				keyIt   = curHash(key).Begin
				keyLast = curHash(key).Last
				Do Until keyIt.Object Is keyLast.Object
					If keyIt.Item.Plugin Is plugin Then
						command = keyIt.Item.Command

						Debug.DebugMsg Self & ": Deregistered command: " & command &" for key " & key
						keyIt.Delete

						Exit Do
					End If
					keyIt.Iterate()
				Loop
			Next
		Next
		Debug.DebugMsg Self & ": Deregistered all commands for the plugin: " & plugin.TITLE
	End Sub
	
	' Explicitly deletes all items within the list, clears the list
	Public Sub DeregisterAllFromLL( ll )
	  Dim it, last, keyEvntIt
	  it   = ll.Begin
	  last = ll.Last
	  Do Until it.Object Is last.Object
			Debug.DebugMsg Self & ": Deregistered command: " & it.Item.oData.Command &" for plugin " & it.Item.oData.Plugin.TITLE
			Set keyEvntIt = it.Object.oData
			keyEvntIt.Delete
			it.Delete
			'it.Iterate() 'Delete itself is kind of Iterate
	  Loop
		Set ll = New LinkedList
		Debug.DebugMsg Self & ": Deregistered all commands from the given LinkedList"
	End Sub
	
	'Enable key monitoring on connect
	Sub EnableOnConnect
		If m_RegCount > 0 Then Me.Enable
	End Sub

	'Enable key monitoring
	Sub Enable
		If fma.Connected > 0 Then fma.EnableKeyMonitor
	End Sub
	
	'Disable key monitoring
	Sub Disable
		If fma.Connected > 0 Then fma.DisableKeyMonitor
	End Sub

End Class

Class KeyEventItem
	Private m_Plugin
	Private m_Command
	Sub Class_Initialize ()
		KeyManager.AddReg
		'Debug.DebugMsg "Ctor"
	End Sub
	
	Sub Class_Terminate ()
		KeyManager.DelReg
		'Debug.DebugMsg "Dtor"
	End Sub
	
	Public Property Get Plugin()
		Set Plugin = m_Plugin
	End Property
	Public Property Set Plugin( plug )
		Set m_Plugin = plug
	End Property
	
	Public Property Get Command()
		Command = m_Command
	End Property
	Public Property Let Command( com )
		m_Command = com
	End Property
End Class

