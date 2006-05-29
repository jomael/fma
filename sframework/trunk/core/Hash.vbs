'FMA Script Framework Core Class
'Hash
'Let's you create hash table objects
'Dynamic hash table size, quadratic Probe

'Interface:
'-Attributes
' -hash( key ):value        ^= hash.Item( key ):value
' -hash( key ) = value      ^= hash.Item( key ) = value
' -Set hash( key ) = object ^= Set hash.Item( key ) = object
'-Methods:
' -hash.DeleteItem( key )
' -hash.GetKeysArray:array
' -hash.GetKeysLinkedList:LinkedList
' -hash.LoadFromFile( fileName )
' -hash.SaveToFile( fileName )

'TODO
'-performance tweaking with large number of items (hash gets slow when there are many resizes)
'-hash size should be prime number
'-improve probing function

Class Hash
	
	Private quad() 'Here we'll save the i^2 results for the quadratic probing to save cpu power
	Private hashTable()
	Private itemCount
	
	Sub Class_Initialize
		'Init hashTable size
		ReDim hashTable(10)
		itemCount = 0
		'Init quad array (0, 1, 4, 9, 16, ...)
		Dim q, i
		q = 8
		ReDim quad(q)
		For i = 0 To q
			quad(i) = i*i
		Next
	End Sub
	
	'return value or object by key
	Public Default Property Get Item( key )
		'find item
		Dim slot
		slot = FindSlot( key )
		'return item
		If Not IsEmpty(hashTable(slot)) Then
			If hashTable(slot).key = key Then 'item found
				If IsObject(hashTable(slot).value) Then
					Set Item = hashTable(slot).value
				Else
					Item = hashTable(slot).value
				End If
			Else
				Item = Empty
			End If
		Else 'not found
			Item = Empty
		End If
	End Property
	
	'assign value to key
	Public Property Let Item( key, value )
		ReHash 'Check for hash fill rate
		'Find slot and set item
		Dim it, slot
		slot = FindSlot( key )
		Set it = New HashItem
		it.key   = key
		it.value = value
		Set hashTable(slot) = it
		itemCount = itemCount + 1
	End Property
	
	'assign object to key
	Public Property Set Item( key, value )
		ReHash 'Check for hash fill rate
		'Find slot and set item
		Dim it, slot
		slot = FindSlot( key )
		Set it = New HashItem
		it.key = key
		Set it.value = value
		Set hashTable(slot) = it
		itemCount = itemCount + 1
	End Property
	
	'deletes the hash entry with the given key
	Public Sub DeleteItem( key )
		Dim slot, i, it
		'find item
		slot = FindSlot( key )
		'delete item
		If Not IsEmpty(hashTable(slot)) And hashTable(slot).key = key Then 'item found
			If IsObject(hashTable(slot).value) Then Set hashTable(slot).value = Nothing
			Set hashTable(slot) = Nothing
			hashTable(slot) = Empty
			itemCount = itemCount - 1
			i = 0
			Do
				If i<=UBound(hashTable) Then
					If Not IsEmpty(hashTable(i)) Then
						If FindSlot( hashTable(i).key) <> i Then
							'Debug.DebugMsg key & "> swapping " & i & " to " & FindSlot( hashTable(i).key)
							Set it = New HashItem
							it.key = hashTable(i).key
							Set it.value = hashTable(i).value
							Set hashTable(FindSlot( hashTable(i).key)) = it
							If IsObject(hashTable(i).value) Then Set hashTable(i).value = Nothing
							Set hashTable(i) = Nothing
							hashTable(i) = Empty
						End If
					End If
				Else
					Exit Do
				End If
				i = i+1
			Loop
		End If
	End Sub
	
	'returns an (unsorted) array of the keys of all entries in the hash
	Public Function GetKeysArray()
		Dim i, j, k()
		If itemCount > 0 Then
			ReDim k(itemCount - 1)
			j = 0
			For i = 0 To UBound(hashTable)
				If Not IsEmpty(hashTable(i)) Then
					k(j) = hashTable(i).key
					j = j + 1
				End If
			Next
		End If
		GetKeysArray = k
	End Function
	
	'returns an (unsorted) linked list of the keys of all entries in the hash
	Public Function GetKeysLinkedList()
		Dim i, j, ll, bi
		Set ll = New LinkedList
		If itemCount > 0 Then
			Set bi = ll.BackInserter
			For i = 0 To UBound(hashTable)
				If Not IsEmpty(hashTable(i)) Then	bi.Item = hashTable(i).key
			Next
		End If
		Set GetKeysLinkedList = ll
	End Function

	'generates the hash index for the given key
	Private Function HashKey( ByVal key )
		If IsNumeric(key) Then
			HashKey = key Mod UBound(hashTable)
		Else
			Dim i
			HashKey = 0
			key = LCase(key) 'case insensitive keys
			For i = 1 To Len(key)
				HashKey = (HashKey + Asc(Mid(key, i, 1))) Mod UBound(hashTable)
			Next
		End If
	End Function
	
	'quadratic probing for a free slot. returns the current probing position
	Private Function Probe( i, pos )
		If i > UBound(hashTable) Or i > UBound(quad) Then 'switch to linear probing
			Probe = (pos + i) Mod UBound(hashTable)
		Else
			Probe = (pos + quad(i)) Mod UBound(hashTable)
		End If
	End Function
	
	'Find first empty slot or slot whose key matches the given key
	'Use quadratic probing (0, 1, 4, 9, 16, 25, ...) and later use linear probing,
	'if quadratic probing doesn't quickly find a free slot

	Private Function FindSlot( key )
		Dim pos, q, item, slot
		pos = HashKey(key)
		q = 0
		slot = Probe(q, pos)
		'find item
		Do
			If IsEmpty(hashTable(slot)) Then Exit Do
			If hashTable(slot).key = key Then Exit Do
			q = q + 1
			slot = Probe(q, pos)
		Loop
		FindSlot = slot
	End Function
	
	Private Sub ReHash()
		'Hashes are efficient with less than 80% filled
		If (itemCount / UBound(hashTable)) > 0.85 Then 'Resize hash table
			'Debug.DebugMsg "Resizing hash. Old size: " & UBound(hashTable) & " - items: " & itemCount & " - capacity: " & UBound(hashTable)
			Dim i
			'copy table
			Dim tempTable()
			ReDim tempTable(UBound(hashTable))
			For i = 0 To UBound(hashTable)
				If Not IsEmpty(hashTable(i)) Then Set tempTable(i) = hashTable(i)
			Next
			'resize table to <50% fill rate
			ReDim hashTable(Fix(itemCount / 2)*4 + 3)
			'move entries to new sized table
			itemCount = 0
			For i = 0 To UBound(tempTable)
				If Not IsEmpty(tempTable(i)) Then
					If IsObject(tempTable(i).value) Then
						Set Me.Item(tempTable(i).key) = tempTable(i).value
					Else
						Me.Item(tempTable(i).key) = tempTable(i).value
					End If
				End If
			Next
			'Debug.DebugMsg "Resized hash. New size: " & UBound(hashTable) & " - items: " & itemCount & " - capacity: " & UBound(hashTable)
		End If
	End Sub
	
	'dump hash content into semicolon seperated key=value; list
	Function Dump()
		Dim text, key, k, v
		text = ""
		For Each key In GetKeysArray
			If key <> "" Then
				k = key
				v = Item(key)
				text = text & Util.EscapeLinebreaks(k) & vbCrLf & Util.EscapeLinebreaks(v) & vbCrLf
			End If
		Next
		Dump = text
	End Function
	
	Sub ImportFromFile( fileName )
		Debug.DebugMsg "Importing hash from file " & fileName
	  'import hash
		If (Fso.FileExists(fileName)) Then
		  Dim File, key, value
	  	Set File = Fso.OpenTextFile(fileName, FILE_FOR_READING)
	    Do
				If File.AtEndOfStream Then Exit Do
				key   = File.ReadLine
				If File.AtEndOfStream Then Exit Do
				value = File.ReadLine
				Item(Util.UnescapeLinebreaks(key)) = Util.UnescapeLinebreaks(value)
			Loop
	    File.Close
		Else
		  Debug.ErrorMsg "Import hash from file: File not found: " & fileName
		End If
	End Sub
	
	Sub LoadFromFile( fileName )
		Debug.DebugMsg "Loading hash from file " & fileName
		'clear hash
		ReDim hashTable(10)
		itemCount = 0
	  'import hash
		ImportFromFile fileName
	End Sub
	
	Sub SaveToFile( fileName )
		Debug.DebugMsg "Saving hash to file " & fileName
		Dim File, text
		text = Dump()
		Set File = Fso.OpenTextFile(fileName, FILE_FOR_WRITING, True)
		File.WriteLine text
		File.Close
	End Sub
	
End Class

'An item
Class HashItem
	Public key
	Public value
End Class

'Benchmark:
'Dim h,o,s,c,i
'Set h = New HashClass
'c = 5
's = Timer
'For o = 0 To c
'	Execute("h.Item(""item" & o & """) = ""dings" & o & """")
'Next
'MsgBox "Set: " & c / (Timer - s) & " items per second"
's = Timer
'h.Item("item20") = "hehe"
'For o = 0 To c
'	If h.Item("item" & o) <> "dings" & o Then
'		Execute("MsgBox ""error: item" & o & " <> dings" & o & "! -> " & h.Item("item" & o) & """")
'	End If
'Next
'MsgBox "Get: " & c / (Timer - s) & " items per second"

