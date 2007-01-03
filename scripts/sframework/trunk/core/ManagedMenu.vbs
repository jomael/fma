'FMA Script Framework Core Class
'ManagedMenu
'Easy interface to implement a menu in your plugin
'TODO:
'-property let/get for the list!?
'-Tweak max menu items. Title may be shorter than 15ch, prev/next item isn't always needed
'Menu constraints:
'-AT command string must not be >250 bytes/chars (AT*EASM="<title>",1,<selecteditem>,<numitems>,"<item1>","<item2>",...,"<itemn>")
'-Menu title must not be >15 bytes/chars
'-The selected item must not be > number of items

'Const MENU_NEXT_PAGE              = "Next Page >>"
'Const MENU_PREV_PAGE              = "<< Prev Page"

Const MENU_MAX_TITLE_LENGTH = 15
Const MENU_MAX_ITEMS_LENGTH = 320 '320 bytes (UTF-8 encoded string)
Const MENU_MAX_ITEM_LENGTH = 200 '200 bytes (UTF-8 encoded string) 

Public MenuStack
Set MenuStack = New Stack

Class ManagedMenu
	Private m_Title
	Private List
	Private Page
	Private Pages()
	Private numPages
	Private isRoot
	Private updateMenu
	Private m_menuType

	Sub Class_Initialize ()
 	isRoot = 0
	 'Init an empty menu
	 m_Title = ""
	 updateMenu = False
	 m_menuType = 10 'Standard menu
	 Set List = New LinkedList
	End Sub
	Public Property Let Title (ByVal t)
	 m_Title = Util.EscapeInvalidATChars(t)
	End Property
	Public Property Get Title
	 Title = m_Title
	End Property
	Public Property Get CurrentPage
	 CurrentPage = Page
	End Property
	Public Property Let menuType (ByVal mt)
	 m_menuType = mt
	End Property
	Sub SetList(lst)
		Set List = lst
		'Split list into pages. We have to split the list so that the AT command isn't >250 bytes/chars
		Dim ItemsLength, bi, EncodedLen
		numPages = 0
		ReDim Pages(0)
		'Init ATLengt with maxlength to force the creation of the first page
		ItemsLength = MENU_MAX_ITEMS_LENGTH
		Dim menuIt, menuLast, entry, temp
		'escape entries
		menuIt   = List.Begin
		menuLast = List.Last
		Do Until menuIt.Object Is menuLast.Object
			If menuIt.Item.USize = 1 Then
				menuIt.Item = Array(Util.EscapeInvalidATChars(menuIt.Item.Item(0)), menuIt.Item.Item(1))
			ElseIf menuIt.Item.USize = 5 Then
				menuIt.Item = Array(Util.EscapeInvalidATChars(menuIt.Item.Item(0)), menuIt.Item.Item(1), menuIt.Item.Item(2), menuIt.Item.Item(3), menuIt.Item.Item(4), menuIt.Item.Item(5))
			Else
				Debug.ErrorMsg "ManagedMenu: Unexpected number of parameters!"
			End If
			menuIt.Iterate()
		Loop
		'Split list
		menuIt   = List.Begin
		menuLast = List.Last
		Do Until menuIt.Object Is menuLast.Object
		  temp = menuIt.Item.Item(0)
		  EncodedLen = Len(fma.PhoneEncode(temp)) 'Calculate Encoded menu item size
		  Do Until EncodedLen <= MENU_MAX_ITEM_LENGTH
  		  temp = Left(temp, Len(temp) - 1)
		    EncodedLen = Len(fma.PhoneEncode(temp))
		  Loop
			If ItemsLength + EncodedLen > MENU_MAX_ITEMS_LENGTH Then
				'Max menu items text length exceeded. Create new list
				numPages = numPages + 1
				ReDim Preserve Pages(numPages - 1)
				Set Pages(numPages - 1) = New LinkedList
				'Now insert in the next page
				bi = Pages(numPages - 1).BackInserter
				'Init ItemsLength
				ItemsLength = 0
			End If
			'Add next item
			Set bi.Item = menuIt.Item
			ItemsLength = ItemsLength + EncodedLen
			menuIt.Iterate()
		Loop
		'Init Menu
		Page = 1
	End Sub	
	Sub ShowMenu()
		'Push menu if menu stack is empty or the top-menu is unequal to the menu which shall be pushed
		If MenuStack.IsEmpty Then
			MenuStack.Push Me
			isRoot = 1
			'Only register the joystick navigation once!
			'KeyManager.RegisterKey KEY_JOYLEFT,  "MenuStack.Top.PrevPage", STATE_PRESS, Me
			'KeyManager.RegisterKey KEY_JOYRIGHt, "MenuStack.Top.NextPage", STATE_PRESS, Me
			' Now optimized > registred only when there are more pages
		Else
			If Not (Me Is MenuStack.Top) Then 'Don't push the same menu twice
				MenuStack.Push Me
			End If
		End If
		MenuStack.Top.Show
	End Sub
	
	Sub Show()
		'Don't show empty menus
		If List.Count > 0 Then
			If updateMenu Then
				am.ClearMenu
				updateMenu = False
			Else
				am.Clear
			End If

			Dim pagesTitle, cutTitle
			If numPages > 1 Then
				pagesTitle = " (" & Page & "/" & numPages & ")"
				'am.AddItem MENU_PREV_PAGE, "MenuStack.Top.PrevPage"

				If keyRegLList.Count = 0 Then
					Dim bi
					bi = keyRegLList.BackInserter
					Set bi.Item = KeyManager.RegisterKey(KEY_JOYLEFT,  "MenuStack.Top.PrevPage", STATE_PRESS, Me)
					Set bi.Item = KeyManager.RegisterKey(KEY_JOYRIGHT, "MenuStack.Top.NextPage", STATE_PRESS, Me)
					'keyRegLList.Object : LinkedListItem; Object.oData : LinkedListItem; oData.oData : KeyEventItem
					'Debug.DebugMsg "bi.Item > object0.command ? " & keyRegLList.Object(0).oData.oData.Command
					'Debug.DebugMsg "bi.Item > object1.command ? " & keyRegLList.Object(1).oData.oData.Command
				End If
			Else
				KeyManager.DeregisterAllFromLL keyRegLList
			End If
			cutTitle = Left(Title, MENU_MAX_TITLE_LENGTH - Len(pagesTitle))
			If Right(cutTitle, 1) = "\" And Right(cutTitle, 2) <> "\\" Then cutTitle = Left(cutTitle, Len(cutTitle) - 1) 'cut trailing \ which may result when cutting the title
			am.Title = cutTitle & pagesTitle 'A menu title must not be > 15 chars!
			If numPages > 0 Then
				' LinkedList version. Note the menuIt/menuLast assignment without Set!
				Dim menuIt, menuLast
				menuIt   = Pages(Page - 1).Begin
				menuLast = Pages(Page - 1).Last
				Do Until menuIt.Object Is menuLast.Object
					If menuIt.Item.USize >= 5 Then
						am.AddItemEx menuIt.Item.Item(0), menuIt.Item.Item(1), menuIt.Item.Item(2), menuIt.Item.Item(3), menuIt.Item.Item(4), menuIt.Item.Item(5)
					Else
						am.AddItem menuIt.Item.Item(0), menuIt.Item.Item(1)
					End If
					menuIt.Iterate()
				Loop
				'If numPages > 1 Then am.AddItem MENU_NEXT_PAGE, "MenuStack.Top.NextPage"
			End If
		End If
		
		'Capture back-button action
		am.Back = "MenuStack.Top.Quit"

		am.MenuType = m_menuType
		
		'Use "wait" as general next state. So the phone won't fall back to the
		'connection -> accessories -> FMA menu between menu updates.
		'Don't use this for the root menu! Otherwise we cannot quit the menu anymore
		If isRoot <> 1 Then
			am.NextState = 2 'Wait
		Else
			am.NextState = 1 'Previous
		End If
		am.Update
	End Sub

	Sub NextPage()
		If numPages > 1 Then
			Page = Page + 1
			If Page > numPages Then Page = 1
			Show
		End If
	End Sub
	
	Sub PrevPage()
		If numPages > 1 Then
			Page = Page - 1
			If Page < 1 Then Page = numPages
			Show
		End If
	End Sub
	
	Sub ShowPage( num )
		If num > numPages Then num = numPages
		If num < 1 Then num = 1
		Page = num
		ShowMenu
	End Sub

	Sub UpdatePage( num )
		If num > numPages Then num = numPages
		If num < 1 Then num = 1
		Page = num
		updateMenu = True
		ShowMenu
	End Sub

	Function GetPageAndIndexByTitleSubstr( title )
		Dim p, i
		title = Util.EscapeInvalidATChars(title)
		GetPageAndIndexByTitleSubstr = 1 'Failsafe
		For p = 1 To numPages
			Dim menuIt, menuLast
			menuIt   = Pages(p - 1).Begin
			menuLast = Pages(p - 1).Last
			i = 0
			Do Until menuIt.Object Is menuLast.Object
				If InStr(menuIt.Item.Item(0), title) > 0 Then 'Item found
					GetPageAndIndexByTitleSubstr = Array(p, i)
					Exit For
				End If
				menuIt.Iterate()
				i = i + 1
			Loop
		Next
	End Function
	
	Function GetPageByTitleSubstr( title )
		GetPageByTitleSubstr = Me.GetPageAndIndexByTitleSubstr(title)(0)
	End Function
	
	Function GetPageAndIndexByItemIndex( idx )
		Dim p, i, j
		GetPageAndIndexByItemIndex = 1 'Failsafe
		j = 0
		For p = 1 To numPages
			Dim menuIt, menuLast
			menuIt   = Pages(p - 1).Begin
			menuLast = Pages(p - 1).Last
			i = 0
			Do Until menuIt.Object Is menuLast.Object
				If j = idx Then 'Item found
					GetPageAndIndexByItemIndex = Array(p, i)
					Exit For
				End If
				menuIt.Iterate()
				i = i + 1
				j = j + 1
			Loop
		Next
	End Function
	
	Function GetPageByItemIndex( idx )
		GetPageByItemIndex = GetPageAndIndexByItemIndex(idx)(0)
	End Function
	
	Sub Quit()
		EventManager.OnEvent "MenuClose", Array(m_Title)
		If isRoot = 1 Then KeyManager.DeregisterAllFromLL keyRegLList 'Only deregister joystick navigation when the mainmenu quits
		MenuStack.Pop
		'Cannot show not existing menu
		If Not MenuStack.IsEmpty Then MenuStack.Top.Show
	End Sub
	Sub QuitNoShow()
		EventManager.OnEvent "MenuClose", Array(m_Title)
		If isRoot = 1 Then KeyManager.DeregisterAllFromLL keyRegLList 'Only deregister joystick navigation when the mainmenu quits
		MenuStack.Pop
	End Sub

End Class