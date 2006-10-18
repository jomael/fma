'FMA Script Framework Core Class
'DebugClass
'Throw debug messages with several debug levels

'TODO:
'-nothing atm

Public Const DEBUG_LEVEL_OFF   = 0
Public Const DEBUG_LEVEL_ERROR = 1
Public Const DEBUG_LEVEL_WARN  = 2
Public Const DEBUG_LEVEL_INFO  = 3
Public Const DEBUG_LEVEL_DEBUG = 4
Public Const DEBUG_LEVEL_NOFMA = 5

Class DebugClass
	
	Public debugLevel
	Private m_Self
	
	Public Property Let Self (s)
		m_Self = s
	End Property
	Public Property Get Self
		Self = m_Self
	End Property
	
	Public Sub SetDebugLevel(l)
		debugLevel = l
	End Sub
	
	Public Sub ErrorMsg(text)
		ThrowMsg "Error: " & text, DEBUG_LEVEL_ERROR
	End Sub
	
	Public Sub WarningMsg(text)
		ThrowMsg "Warning: " & text, DEBUG_LEVEL_WARN
	End Sub
	
	Public Sub InfoMsg(text)
		ThrowMsg "Info: " & text, DEBUG_LEVEL_INFO
	End Sub
	
	Public Sub DebugMsg(text)
		ThrowMsg "Debug: " & text, DEBUG_LEVEL_DEBUG
	End Sub
	
	Private Sub ThrowMsg(msg, level)
		If debugLevel = DEBUG_LEVEL_NOFMA Then
			'Debugging without FMA running
			MsgBox msg
		ElseIf level <= debugLevel And Not IsEmpty(fma) And IsObject(fma) Then
			'Check the existance of fma and print the message, if the debug level fits
			fma.Debug msg
		End If
	End Sub
	
End Class

