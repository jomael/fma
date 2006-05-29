'FMA Script Framework Core Class
'EventManager
'Register your plugins for fired events
'
'Plugins may register for events by doing:
'	Set item = EventManager.RegisterEvent( "<event>", "<command to execute>", <plugin-object> )
'Example:
'	Dim item
'	Set item = EventManager.RegisterEvent( "Connected", "Debug.DebugMsg ""just connected""", Me )
'This will register the command Debug.DebugMsg "just connected" for the event "Connected"
'and from the plugin "Me" (which is the object from which you are calling) and save a reference
'to the event in the variable "item".
'This way you can easily deregister this event by doing:
'	item.Delete
'You may even collect event groups in LinkedList's and deregister them all at once:
'	Dim item, ll, bi
'	Set ll = New LinkedList
'	bi = ll.BackInserter
'	'Register:
'	Set bi.Item = EventManager.RegisterEvent( "Connected",      "Debug.DebugMsg ""just connected""",    Me )
'	Set bi.Item = EventManager.RegisterEvent( "Disconnected",   "Debug.DebugMsg ""just disconnected""", Me )
'	Set bi.Item = EventManager.RegisterEvent( "ConnectionLost", "Debug.DebugMsg ""connection lost!""",  Me )
'	'Deregister:
'	EventManager.DeregisterAllFromLL ll
'If you don't want to deregister like this, you can just call:
'	EventManager.RegisterEvent "Connected", "Debug.DebugMsg ""just connected""", Me
'without saving the reference. Then you can only deregister with DeregisterAll.
'
'Plugins may deregister ALL their registered events at once by passing an object reference to themselves:
' EventManager.DeregisterAll Me
'
'Plugins may even throw own events by simply doing:
'	EventManager.OnEvent <event>, Array([<argument1>, [<argument2>, [...]]])

'TODO
'-nothing atm

'Script Events triggered by FMA. Copied from http://www.fma.xinium.com/resources/docs/scripts_sdk.htm:
'-AMRoot
'-Init
'-Connected
'-ConnectionLost
'-Disconnected
'-NewSMS
'-Call
'-Proximity
'-MusicMute
'-KeyPress

'Some interesting, event related constants
Public Const EVENT_PROXIMITY_NEAR  = 0
Public Const EVENT_PROXIMITY_AWAY  = 1

Class EventManagerClass
	
	Private eventHash
	Private m_Self
	
	Sub Class_Initialize()
		Set eventHash = New Hash
	End Sub
	
	Public Property Let Self (s)
		m_Self = s
	End Property
	Public Property Get Self
		Self = m_Self
	End Property
	
	' Executes all commands associated to the event e. Takes an argument Array
	Sub OnEvent( e, ByRef arguments )
		Debug.DebugMsg Self & ": Event " & e & " triggered"
		Dim args
		
		If Not IsEmpty(eventHash(e)) Then 'Cannot iterate a non existing chain...
			If IsArray(arguments) And UBound(arguments) > -1 Then
				' Generate argument list
				args = " "
				For Each param In arguments
					args = args & """" & Replace(param,"""","""""") & """" & ", "
				Next
				' Cut tailing ","
				If Right(args, 2) = ", " Then args = Left(args, Len(args) -2)
			Else
				args = ""
			End If
			
			Dim evIt, evLast
			evIt   = eventHash(e).Begin
			evLast = eventHash(e).Last
			Do Until evIt.Object Is evLast.Object
				Debug.DebugMsg Self & ": Executing " & evIt.Item.Command & args & " for event " & e
				Execute(evIt.Item.Command & args)
				evIt.Iterate()
			Loop
			'Set evIt = Nothing
		Else
			Debug.DebugMsg Self & ": Event " & e & " has no registered events in it's chain"
		End If
	End Sub
	
	' Registers the command for the given event
	' This will append the command to the linked list, which is stored in the hash with the event "<event>"
	Function RegisterEvent( e, command, plugin )
		Dim ev
		Set ev = New EventItem
		ev.Command = command
		Set ev.Plugin  = plugin
		
		If e <> "" And command <> "" Then 'Don't register "empty" calls
			'Event not known before, create new event chain
			If IsEmpty(eventHash(e)) Then	Set eventHash(e) = New LinkedList
			'append command to event chain
			Set RegisterEvent = eventHash(e).AddBack(ev)
			Debug.DebugMsg Self & ": Registered """ & command & """ for event " & e
		End If
	End Function
	
	' Deregisters the command for the given event
	' This will look for the command in the list, which is stored in the hash with the event "<event>", and delete it
'	Sub DeregisterEvent( e, command )
'		If Not IsEmpty(eventHash(e)) Then
'			If Trim(command) <> "" Then
'				Dim found
'				found = False
'				Dim evIt, evLast
'				evIt   = eventHash(e).Begin
'				evLast = eventHash(e).Last
'				Do Until evIt.Object Is evLast.Object
'					If evIt.Item = command Then
'						evIt.Delete
'						found = True
'						Exit Do
'					End If
'					evIt.Iterate()
'				Loop
'				If found Then
'					Debug.DebugMsg Self & ": Deregistered command: " & command &" for event " & e
'				Else
'					Debug.DebugMsg Self & ": Couldn't deregister command """ & command & """ for event " & e & "! Command not registered!"
'				End If
'			Else
'				Debug.ErrorMsg Self & ": Deregister - Cannot deregister empty commands!"
'			End If
'		Else
'			Debug.ErrorMsg Self & ": Deregister - No commands registered for event " & e & "!"
'		End If
'	End Sub

	' Deregisters all commands that were registered by a specific plugin
	Sub DeregisterAll( plugin )
		Dim key, evIt, evLast, command
		For Each key In eventHash.GetKeysArray
			evIt   = eventHash(key).Begin
			evLast = eventHash(key).Last
			Do Until evIt.Object Is evLast.Object
				If evIt.Item.Plugin Is plugin Then
					command = evIt.Item.Command
					evIt.Delete
					Debug.DebugMsg Self & ": Deregistered command: " & command &" for event " & key
					Exit Do
				End If
				evIt.Iterate()
			Loop
		Next
		Debug.DebugMsg Self & ": Deregistered all commands for the plugin: " & plugin.TITLE
	End Sub
	
	' Explicitly deletes all items within the list, clears the list
	Public Sub DeregisterAllFromLL( ll )
	  Dim it, last
	  it   = ll.Begin
	  last = ll.Last
	  Do Until it.Object Is last.Object
			Debug.DebugMsg Self & ": Deregistered command: " & it.Item.oData.Command &" for plugin " & it.Item.oData.Plugin.TITLE
			it.Item.Delete
			it.Iterate()
	  Loop
		Set ll = New LinkedList
		Debug.DebugMsg Self & ": Deregistered all commands from the given LinkedList"
	End Sub
	
End Class

Class EventItem
	Private m_Plugin
	Private m_Command
	
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

