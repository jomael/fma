'FMA Script Framework Core Class
'QuickSort
'Allows for sorting of arrays with a comparator object

'Interface:
'	-QuickSortObject.Sort( array ) 'will sort the array with the default comparator
'	-QuickSortObject.SortLL( LList ) 'will sort the LList with the default comparator
'	-QuickSortObject.ComparatorSort( array, ComparatorObject ) 'will sort the array with a given comparator
'	-QuickSortObject.ComparatorSortLL( LList, ComparatorObject ) 'will sort the LList with a given comparator
'	-QuickSortObject.DataSort( DataObject ) 'will sort by using the given DataObject with the default comparator
'	-QuickSortObject.DataComparatorSort( DataObject, ComparatorObject ) 'will sort by using the given DataObject with a given comparator

'TODO:
'-remove ArrayData.GetArray and try to use array pointers
'-nothing atm

Class QuickSort
	
	'Interfaces
	Sub Sort( ByRef a )
		Dim comp
		Set comp = New DefaultComparator
		ComparatorSort a, comp
	End Sub
	
	Sub SortLL( ll )
		Dim comp
		Set comp = New DefaultComparator
		ComparatorSortLL ll, comp
	End Sub
	
	Sub ComparatorSort( ByRef a, comp )
		Dim data
		Set data = New ArrayData
		data.SetArray a
		privSort data, comp, data.First, data.Last
		a = data.GetArray
	End Sub
	
	Sub ComparatorSortLL( ll, comp )
		Dim data
		Set data = New LLData
		data.SetLL ll
		privSort data, comp, data.First, data.Last
	End Sub
	
	Sub DataSort( data )
		Dim comp
		Set comp = New DefaultComparator
		privSort data, comp, data.First, data.Last
	End Sub
	
	Sub DataComparatorSort( data, comp )
		privSort data, comp, data.First, data.Last
	End Sub
	
	'QuickSort
	Private Sub privSort( data, comp, l, r )
		If r > l Then
			Dim p, i, j
			p = data(r) 'Pivot-Element
			i = l
			j = r
			Do
				Do While comp.Compare(data(i), p) = -1
					i = i + 1
				Loop
				Do While comp.Compare(data(j), p) = 1
					j = j - 1
				Loop
				If i <= j Then
					data.Swap i, j
					i = i + 1
					j = j - 1
				End If
			Loop Until i > j
			privSort data, comp, l, j
			privSort data, comp, i, r
		End If
	End Sub
	
End Class

'Comparator Classes
Class DefaultComparator
	Public Function Compare( ByVal a, ByVal b )
		'compare case insensitive
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

'Data Classes
Class ArrayData
	Private m_Array
	
	Public Sub SetArray( ByRef ary )
		m_Array = ary
	End Sub
	
	Public Function GetArray()
		GetArray = m_Array
	End Function
	
	Public Property Get First()
		First = LBound(m_Array)
	End Property
	
	Public Property Get Last()
		Last = UBound(m_Array)
	End Property
	
	Public Default Property Get Item( idx )
		Item = m_Array(idx)
	End Property
	
	Public Property Let Item( idx, val )
		m_Array(idx) = val
	End Property
	
	Public Property Set Item( idx, object )
		Set m_Array(idx) = object
	End Property
	
	Public Sub Swap( i, j )
		Dim h
		If IsObject(Me.Item(i)) Then 'object swap
			Set h = Me.Item(i)
			Set Me.Item(i) = Me.Item(j)
			Set Me.Item(j) = h
		Else
			h = Me.Item(i)
			Me.Item(i) = Me.Item(j)
			Me.Item(j) = h
		End If
	End Sub
End Class

Class LLData
	Private m_LL
	
	Public Sub SetLL( ll )
		Set m_LL = ll
	End Sub
	
	Public Property Get First()
		First = 0
	End Property
	
	Public Property Get Last()
		Last = m_LL.Count - 1
	End Property
	
	Public Default Property Get Item( idx )
		Item = m_LL(idx)
	End Property
	
	Public Property Let Item( idx, val )
		m_LL(idx) = val
	End Property
	
	Public Property Set Item( idx, object )
		Set m_LL(idx) = object
	End Property
	
	Public Sub Swap( i, j )
		Dim h
		If IsObject(Me.Item(i)) And IsObject(Me.Item(j)) Then 'object swap
			Set h = Me.Item(i)
			Set Me.Item(i) = Me.Item(j)
			Set Me.Item(j) = h
		ElseIf IsObject(Me.Item(i)) Then
			Set h = Me.Item(i)
			Set Me.Item(i) = Nothing
			Me.Item(i) = Me.Item(j)
			Set Me.Item(j) = h
		ElseIf IsObject(Me.Item(j)) Then
			Set h = Me.Item(j)
			Set Me.Item(j) = Nothing
			Me.Item(j) = Me.Item(i)
			Set Me.Item(i) = h
		Else
			h = Me.Item(i)
			Me.Item(i) = Me.Item(j)
			Me.Item(j) = h
		End If
	End Sub
End Class

