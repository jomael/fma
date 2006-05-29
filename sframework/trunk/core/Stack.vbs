'FMA Script Framework Core Class
'Stack
'A stack class. Push, Pop, Pop, IsEmpty. You can use variants and objects on the stack

'TODO
'-nothing atm. should be correct
'-Maybe implement this one with linked elements instead of an array

Class Stack
	
	Private m_Stack()
	
	Sub Class_Initialize()
		Redim m_Stack(0)
	End Sub
	
	Public Sub Push(elem)
		Redim Preserve m_Stack(UBound(m_Stack)+1)
		If IsObject(elem) Then
			Set m_Stack(UBound(m_Stack)) = elem
		Else
			m_Stack(UBound(m_Stack)) = elem
		End If
	End Sub
	
	Public Function Top
		If UBound(m_Stack) > 0 Then
			If IsObject(m_Stack(UBound(m_Stack))) Then
				Set Top = m_Stack(UBound(m_Stack))
			Else
				Top = m_Stack(UBound(m_Stack))
			End If
		End If
	End Function
	
	Public Function Pop
		If UBound(m_Stack) > 0 Then
			If IsObject(m_Stack(UBound(m_Stack))) Then
				Set Pop = m_Stack(UBound(m_Stack))
			Else
				Pop = m_Stack(UBound(m_Stack))
			End If
			Redim Preserve m_Stack(UBound(m_Stack)-1)
		End If
	End Function
	
	Public Function IsEmpty
		If UBound(m_Stack) = 0 Then IsEmpty = True Else IsEmpty = False
	End Function

End Class
