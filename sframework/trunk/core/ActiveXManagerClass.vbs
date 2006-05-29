'FMA Script Framework Core Class
'ActiveXManager
'Provides access to external ActiveX-/COM-controls

'Interface:
'	-Attributes:
' 	-Use an object:
'			ActiveXManager.Control( className ):object        ^= ActiveXManager( className ):object

'TODO
'-nothing

Class ActiveXManagerClass
	
	Private m_Self
	Private controlHash
	
	Sub Class_Initialize()
		Set controlHash = New Hash
	End Sub
	
	Public Property Let Self (s)
		m_Self = s
	End Property
	Public Property Get Self
		Self = m_Self
	End Property
	
	'Return object by given class name
	Public Default Property Get Control( className )
		If IsEmpty(controlHash(LCase(className))) Then 'Slot empty, init it
			Set controlHash(LCase(className)) = CreateObject(className)
			Debug.DebugMsg Self & ": Created " & className
		End If
		Set Control = controlHash(LCase(className))
	End Property
	
End Class


