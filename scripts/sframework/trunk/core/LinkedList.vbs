' Double-linked list class.

'Classes/Interfaces:
'-LinkedList
' -Attributes:
'  -Item (Get(idx) :value / Let( idx, value ) / Set( idx, object ) )
'  -Count:value
' -Methods:
'  -Object( idx ):object
'  -AddFront( object/value ):object
'  -AddBack( object/value ):object
'  -Insert( idx, object/value):object
'  -Delete( idx )
'  -Begin, Last, RBegin, RLast: BDIteratorClass
'  -AtIt( idx ) : BDIteratorClass
'  -BackInserter : BackInserterClass
'-LinkedListItem
' -Attributes:
'  -oNext
'  -oPrev
'  -bIsTerminator
'  -bIsFirst
'  -oData
' -Methods:
'  -Delete
'-BDIteratorClass
' -Attributes:
'  -Item (Get:value / Let( value ) / Set( object ))
'  -Object :LinkedListItem (for comparison)
' -Methods:
'  -Iterate: BDIteratorClass
'  -IterateBack: BDIteratorClass
'  -Delete
'  -GetCopy (standard method): Returns a copy of the iterator
'-BackInserterClass
' -Attributes:
'  -Item ( Let( value ), Set( object ) )
' -Methods:
'  -SetIterator ( LinkedListItem )
'  -GetCopy (standard method): BackInserterClass
'-ArrayContainer
' -Attributes:
'  -Item ( Get( idx ):value/object, Set( idx, object ), Let( idx,  value ) )
'  -USize ( Get:value )
' -Methods
'  -RedimAry ( size )
'  -RedimPAry ( size )
'  -SetAry ( array )

'TODO:
'-Insert( BDIteratorClass )
' or Insert( idx )
'-bIsTerminator needed? You could just check (item.oNext = Nothing And item <> m_oFirst), then it must be a terminator
'-Fix array container to work more intuitively (like ll.Item(idx)(aidx), it.Item(aidx) or similar)
'-Array container let, set
'-BDIteratorClass.Get Item -> subject to change. Doesn't work right ATM

Class LinkedList
	Private m_oFirst
	Private m_oTerminator
	
	Sub Class_Initialize
		Set m_oFirst = New LinkedListItem
		m_oFirst.bIsFirst = 1
		Set m_oTerminator = New LinkedListItem
		m_oTerminator.bIsTerminator = 1
		Set m_oFirst.oNext = m_oTerminator
		Set m_oTerminator.oNext = Nothing
		Set m_oTerminator.oPrev = m_oFirst
		Set m_oFirst.oPrev = Nothing
	End Sub
	
	Sub Class_Terminate
		Set m_oTerminator = Nothing
		Set m_oFirst = Nothing
	End Sub
	
	' Returns the selected item (not its value)
	' Usage: item = ll.Object ( nIndex )
	Public Function Object ( nIndex )
		Dim oItem
		Dim nStep
		nStep = nIndex
		Set oItem = m_oFirst
		While ( oItem.bIsTerminator <> 1 ) And ( nStep >= 0 )
			Set oItem = oItem.oNext
			nStep = nStep - 1
		Wend
		Set Object = oItem
	End Function
	
	' Returns the selected item's data
	' Usage: variable = ll ( nIndex )
	' or:    variable = ll.Item ( nIndex )
	Public Default Property Get Item( nIndex )
		Dim oItem
		Set oItem = Object ( nIndex )
		If oItem.bIsTerminator = 1 Then
			'Set Item = Nothing
			Item = Empty
		Else
			If IsObject(oItem.oData) Then
				Set Item = oItem.oData
			Else
				Item = oItem.oData
			End If
		End If
	End Property
	
	' Assigns to the selected item.
	' Usage: ll ( nIndex ) = value
	' (don't ask me why it works, as it isn't set as Default)
	' or:    ll.Item ( nIndex ) = value
	Public Property Let Item( nIndex, vVal )
		Dim oItem
		Set oItem = Object ( nIndex )
		If oItem.bIsTerminator <> 1 Then
			If IsArray( vVal ) Then
				Set oItem.oData = New ArrayContainer
				oItem.oData.SetAry ( vVal )
			Else
				oItem.oData = vVal
			End If
		End If
	End Property
	
	' Assigns a reference to the selected item.
	' Usage: Set ll ( nIndex ) = object
	' (don't ask me why it works, as it isn't set as Default)
	' or:    Set ll.Item ( nIndex ) = object
	Public Property Set Item( nIndex, oVal )
		Dim oItem
		Set oItem = Object ( nIndex )
		If oItem.bIsTerminator <> 1 Then
			Set oItem.oData = oVal
		End If
	End Property	
	
	' Adds an item in front of the list
	' Returns the added item (not its value)
	' Usage: item = ll.AddFront ( valueorobject )
	Public Function AddFront( oData )
		Dim oItem
		Set oItem = New LinkedListItem
		
		' Link items
		Set oItem.oNext       = m_oFirst.oNext
		Set oItem.oNext.oPrev = oItem
		Set oItem.oPrev       = m_oFirst
		Set m_oFirst.oNext    = oItem
		
		If IsObject( oData ) Then
			Set oItem.oData = oData
		ElseIf IsArray( oData ) Then
			Set oItem.oData = New ArrayContainer
			oItem.oData.SetAry ( oData )
		Else
			oItem.oData = oData
		End If
		Set AddFront = oItem
	End Function
	
	' Adds an item at the end of the list
	' Returns the added item (not its value)
	' Usage: item = ll.AddBack ( valueorobject )
	Public Function AddBack( oData )
		Dim oItem
		Set oItem = New LinkedListItem
		
		' Link items
		Set oItem.oNext = m_oTerminator
		Set oItem.oPrev = m_oTerminator.oPrev
		
		Set m_oTerminator.oPrev = oItem
		Set oItem.oPrev.oNext = oItem
		
		If IsObject( oData ) Then
			Set oItem.oData = oData
		ElseIf IsArray( oData ) Then
			Set oItem.oData = New ArrayContainer
			oItem.oData.SetAry ( oData )
		Else
			oItem.oData = oData
		End If
		Set AddBack = oItem
	End Function
	
	' Adds an item at a custom position
	' (UNTESTED YET!)
	Public Function Insert ( nPos, oData )
		Dim oItem, oOldPos
		Set oItem = New LinkedListItem
		
		Set oOldPos = Object(nPos)
		
		' Link items
		Set oItem.oNext = oOldPos.oNext
		Set oItem.oPrev = oOldPos
		
		Set oOldPos.oNext.oPrev = oItem
		Set oOldPos.oNext = oItem
		
		If IsObject( oData ) Then
			Set oItem.oData = oData
		ElseIf IsArray( oData ) Then
			Set oItem.oData = New ArrayContainer
			oItem.oData.SetAry ( oData )
		Else
			oItem.oData = oData
		End If
		Set Insert = oItem
		
		
	End Function
	
	' Deletes an item from the list
	' Usage: ll.Delete nIndex
	Public Sub Delete ( nIndex )
		Dim oItem
		Set oItem = Object( nIndex )
		If oItem.bIsTerminator <> 1 Then
			oItem.Delete
		End If
	End Sub
	
	' Returns the number of objects in the list
	' Usage: variable = ll.Count
	Public Property Get Count ()
		Dim oItem
		Dim nCnt
		nCnt = 0
		Set oItem = m_oFirst
		While oItem.oNext.bIsTerminator <> 1
			Set oItem = oItem.oNext
			nCnt = nCnt + 1
		Wend
		Count = nCnt
	End Property
	
	Public Property Get Begin ()
		Set Begin = New BDIteratorClass
		Begin.SetIterator( m_oFirst.oNext )
	End Property

	Public Property Get Last ()
		Set Last = New BDIteratorClass
		Last.SetIterator( m_oTerminator )
	End Property
	
	Public Property Get RBegin ()
		Set RBegin = New BDIteratorClass
		RBegin.SetIterator( m_oTerminator.oPrev )
	End Property
	
	Public Property Get RLast ()
		Set RLast = New BDIteratorClass
		RLast.SetIterator( m_oFirst )
	End Property
	
	Public Function AtIt ( nIndex )
		Set AtIt = New BDIteratorClass
		AtIt.SetIterator(Object(nIndex))
	End Function
	
	Public Function BackInserter ()
		Set BackInserter = New BackInserterClass
		BackInserter.SetIterator ( m_oTerminator )
	End Function
End Class

' An item
Class LinkedListItem
	Public oNext
	Public oPrev
	Public bIsTerminator
	Public bIsFirst
	Public oData
	
	Sub Class_Terminate
		Set oPrev = Nothing
		Set oNext = Nothing
		If IsObject ( oData ) Then
			Set oData = Nothing
		End If
	End Sub
	
	Sub Delete ()
		Set oPrev.oNext = oNext
		Set oNext.oPrev = oPrev
	End Sub
End Class

' Bidirectional iterator class.
' Usage:	Assignment:	it.Item = value
'						Set it.Item = object
'			Reading:	valvar = it.Item
'						Set objvar = it.Item
'			Proceeding:	it.Iterate()
'			Backwards:	it.IterateBack()
'			( These functions move the iterator forward / backward by 1
'			and return a copy of the iterator )
'			IMPORTANT: Copying: Set it2 = it
'			( overloaded. returns a copy instead of the same object )
Class BDIteratorClass
	Private m_oItem
	
	' Set the iterator.
	' Returns 1 if the selected item is a valid item,
	' 0 if it is a terminator.
	' Usage: bOK = it.SetIterator( oItem )
	' (where it is a BDIteratorClass object)
	' Obsolete for public usage, internal use
	Public Function SetIterator ( oItem )
		Set m_oItem = oItem
		If m_oItem.bIsTerminator <> 1 Then
			SetIterator = 1
		Else
			SetIterator = 0
		End If
	End Function
	
	' Returns the currently selected item.
	' Callable as standard method.
	' Usage: Var = it.Item
	Public Property Get Item()
		If IsObject(m_oItem.oData) Then
			Set Item = m_oItem.oData
		ElseIf nAryInd > -1 Then
			' subject to change. Doesn't work right ATM
			Item = m_oItem.oData
		Else
			Item = m_oItem.oData
		End If
	End Property
	
	
	' Assigns to the currently selected item.
	' Usage: it.Item = Value
	Public Property Let Item ( nVal )
		If IsArray( nVal ) Then
			Set m_oItem.oData = New ArrayContainer
			m_oItem.oData.SetAry ( nVal )
		Else
			m_oItem.oData = nVal
		End If		
	End Property

	' Assigns a reference to the currently selected item.
	' Usage: Set it.Item = Value
	' Can't be used like the Get property as standard method!
	Public Property Set Item ( oVal )
		Set m_oItem.oData = oVal
	End Property
	
	' Returns the item object (for comparison)
	' Usage: objvar = it.Object
	Public Property Get Object ()
		Set Object = m_oItem
	End Property
	
	' Creates a copy of the iterator and returns it.
	' Usage: it2 = it
	' or:    it2 = it.GetCopy
	Public Default Property Get GetCopy ()
		Set GetCopy = New BDIteratorClass
		GetCopy.SetIterator(m_oItem)
	End Property
	
	' Proceeds by 1 in the list. Returns a copy.
	' Usage: it2 = it.Iterate()
	Public Function Iterate ()
		If m_oItem.bIsTerminator <> 1 Then
			Set m_oItem = m_oItem.oNext
		End If
		Iterate = GetCopy()
	End Function
	
	' Iterates backwards
	' Usage: it2 = it.BIterateBack()
	Public Function IterateBack ()
		If m_oItem.bIsFirst = 0 Then
			Set m_oItem = m_oItem.oPrev
		End If
		IterateBack = GetCopy()
	End Function
	
	' Deletes the active item from the list. Returns an iterator
	' to the next object
	' Usage: it.Delete
	Public Function Delete ()
		m_oItem.Delete
		Delete = Iterate()
	End Function
		
End Class

' Backinserter class.
Class BackInserterClass
	Private m_oItem
	
	' Assigns a list to the inserter
	Public Sub SetIterator ( oItem )
		Set m_oItem = oItem
	End Sub
	
	' Creates a copy of the iterator and returns it.
	Public Default Property Get GetCopy ()
		Set GetCopy = New BackInserterClass
		GetCopy.SetIterator( m_oItem )
	End Property
	
	' Adds an item at the end of the list.
	' Usage: it.Item = Value
	Public Property Let Item ( nVal )
		Dim oItem
		Set oItem = New LinkedListItem
		Set oItem.oNext = m_oItem
		Set oItem.oPrev = m_oItem.oPrev
		Set oItem.oPrev.oNext = oItem
		Set m_oItem.oPrev = oItem
		
		If IsArray( nVal ) Then
			Set oItem.oData = New ArrayContainer
			oItem.oData.SetAry ( nVal )
		Else
			oItem.oData = nVal
		End If		
	End Property
	
	' Adds an object at the end of the list
	Public Property Set Item ( oVal )
		Dim oItem
		Set oItem = New LinkedListItem
		Set oItem.oNext = m_oItem
		Set oItem.oPrev = m_oItem.oPrev
		Set oItem.oPrev.oNext = oItem
		Set m_oItem.oPrev = oItem
		
		Set oItem.oData = oVal
	End Property
	
End Class

Class ArrayContainer
	Private m_Array
	
	Public Sub SetAry ( ByRef myAry )
		m_Array = myAry
	End Sub
	
	Public Default Property Get Item ( nAryIndex )
		if ( BoundCheck( nAryIndex ) = true) then	
			If IsObject( m_Array( nAryIndex ) ) = True Then
				Set Item = m_Array( nAryIndex )
			Else
				Item = (m_Array( nAryIndex ))
			End If
		end if
	End Property
	
	Public Property Set Item ( nAryIndex, oVal )
		if ( BoundCheck( nAryIndex ) = true) then
			Set m_Array( nAryIndex ) = oVal
		end if
	End Property
	
	Public Property Let Item ( nAryIndex, nVal )
		if ( BoundCheck( nAryIndex ) = true) then
			m_Array( nAryIndex ) = nVal
		end if
	End Property
	
	Public Function RedimAry ( nDim )
		Redim m_Array( nDim )
	End Function
	
	Public Function RedimPAry ( nDim )
		Redim Preserve m_Array( nDim )
	End Function
	
	Public Property Get USize
		USize = UBound(m_Array)
	End Property

	Private Function BoundCheck ( nAryIndex )
		If ( nAryIndex <= UBound(m_Array) ) and ( nAryIndex >= LBound(m_Array) ) Then
			BoundCheck = true
		else
			BoundCheck = false
			Debug.ErrorMsg "ArrayContainer: Index out of bounds."
		end if
	End Function
	
End Class


' Example for use of linked list, iterator and backinserter

'Dim ll
'Set ll = New LinkedList
'Dim bi
'bi = ll.BackInserter
'bi.Item = 1
'bi.Item = 2
'bi.Item = 3
'bi.Item = 4
'Dim it
'it = ll.Begin
'Do Until it.Object Is ll.Last.Object
'	Msgbox it.Item
'	it.iterate()
'Loop

