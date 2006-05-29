Class BramusICQ
	
	Private m_Self 'm_Self
	
	'checks
	Private register_api_result
	
	'menu's
	Private mainMenu 'mainMenu
	Private changeStatusMenu 'changeStatusMenu
	Private contactList 'contactList (which is a menu)
	Private contactMenu
	
	'Send Message Stuff
	Private contactUIN
	Private contactNick
	Private messageToSend
	Private urlToSend
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    	= True
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       	= g_(Me,"BramusICQ")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION 	= g_(Me,"Control your ICQ running at your pc from your phone")
	End Property
	Public Property Get AUTHOR 'Who created me?
		AUTHOR      	= "Bramus!"
	End Property
	Public Property Get URL 'Were can I be found? Where can you get more information?
		URL 		= "http://t610.bramus.be/"
	End Property
	
	'Who am I?
	Public Property Let Self (s)
		m_Self = s
		Set mainMenu         = New ManagedMenu
		Set changeStatusMenu = New ManagedMenu
		Set contactList      = New ManagedMenu
		Set contactMenu      = New ManagedMenu
	End Property
	
	Public Property Get Self
		Self = m_Self
	End Property
	
	Sub Show()
		Dim tempList, backIns

		
		register_api_result = ActiveXManager("BramusICQ.cICQ").BiW_Register_API
		
		Select Case register_api_result
		
			Case "err_notrunning"
				EmptyMenu.ShowMenu
				Util.DisplayMsgBox g_(Me,"Error : ICQ Not Running"), 3, ""
				'am.Update
				
			Case "err_version"
				EmptyMenu.ShowMenu
				Util.DisplayMsgBox g_(Me,"Error : Wrong ICQ API version"), 3, ""
				'am.Update
				
			Case "err_license"
				EmptyMenu.ShowMenu
				Util.DisplayMsgBox g_(Me,"Error : API Not installed"), 3, ""
				'am.Update
				
			Case "ok"
			
				'mainMenu
				Set tempList = New LinkedList
				backIns = tempList.BackInserter
					backIns.Item = Array( g_(Me,"Change Status"), 		m_Self & ".showChangeStatusMenu" )
					backIns.Item = Array( g_(Me,"ContactList"), 		m_Self & ".showContactList" )
				mainMenu.SetList tempList
				mainMenu.Title = g_(Me,"Main menu")
				
				'changeStatusMenu
				Set tempList = New LinkedList
				backIns = tempList.BackInserter
					backIns.Item = Array( g_(Me,"Online"), 		m_Self & ".setStatus(0)" )
					backIns.Item = Array( g_(Me,"Invisible"), 		m_Self & ".setStatus(6)" )
					backIns.Item = Array( g_(Me,"Away"), 			m_Self & ".setStatus(2)" )
					backIns.Item = Array( g_(Me,"N/A"), 			m_Self & ".setStatus(3)" )
					backIns.Item = Array( g_(Me,"DND"), 			m_Self & ".setStatus(5)" )
					backIns.Item = Array( g_(Me,"Occupied"), 		m_Self & ".setStatus(4)" )
					backIns.Item = Array( g_(Me,"Free For Chat"), 		m_Self & ".setStatus(1)" )
					backIns.Item = Array( g_(Me,"Disconnect/Offline"), 	m_Self & ".setStatus(7)" )
				changeStatusMenu.SetList tempList
				changeStatusMenu.Title = g_(Me,"Change Status")
				
				Set tempList = New LinkedList
				backIns = tempList.BackInserter
					backIns.Item = Array( g_(Me,"Send Message"),		m_Self & ".setMessage()" )
					backIns.Item = Array( g_(Me,"Send URL"),		m_Self & ".setURL()" )
				contactMenu.SetList tempList
				contactMenu.Title = g_(Me,"Contact Options")
		
				mainMenu.ShowMenu
			Case Else
				EmptyMenu.ShowMenu
				Util.DisplayMsgBox g_(Me,"Error : Unknown error"), 3, ""
				'am.Update
		End Select
		
		
	End Sub
	
	Sub showChangeStatusMenu()
		changeStatusMenu.ShowMenu
	End Sub
	
	Sub setStatus(x)
		ActiveXManager("BramusICQ.cICQ").BiW_setOwnerStatus(x)
		am.Update 'Send an update or FMA just hangs...
	End Sub	

	Sub showContactList()
		Dim tempList, backIns

		Set tempList = New LinkedList
		backIns = tempList.BackInserter
		
		online = ActiveXManager("BramusICQ.cICQ").BiW_GetOnlineListDetails
		
		If online = 0 Then
			EmptyMenu.ShowMenu
			Util.DisplayMsgBox g_(Me,"No contacts online"), 3, ""
			'am.Update
		Else
		  
			For x = 1 To online
				nick = ActiveXManager("BramusICQ.cICQ").BiW_GetNickNameForUin(x)
				uin = ActiveXManager("BramusICQ.cICQ").BiW_GetUin(x)
				temp = nick & " (" & uin & ")"
				Debug.DebugMsg Self & temp
				backIns.Item = Array( temp, 		m_Self & ".setContact(" & x & ")" )
			Next
			
			contactList.SetList tempList
			contactList.Title = g_(Me,"Contact List")
				
			contactList.ShowMenu
		End If
		
	End Sub

	Sub setContact(x)
		contactUIN = ActiveXManager("BramusICQ.cICQ").BiW_GetUin(x)
		contactNick = ActiveXManager("BramusICQ.cICQ").BiW_GetNickNameForUin(x)
		Debug.DebugMsg Self & "Selected :" & x
		am.Update
		contactMenu.Title = contactNick
		contactMenu.ShowMenu
	End Sub	
	
	Sub setMessage()
		EmptyMenu.ShowMenu
		am.DlgInputStr g_(Me,"Enter message"), g_(Me,"Message:"), 40, "", m_Self & ".sendMessage"
	End Sub
	
	Sub sendMessage(input)
		'am.Update
		ActiveXManager("BramusICQ.cICQ").BiW_SendMessage CLng(contactUIN), CStr(input)
		Util.Sleep 100
		Shell.SendKeys "%{S}"
		Util.DisplayMsgBox g_(Me,"Message Sent to ") & contactNick , 3, ""
	End Sub
	
	Sub setURL()
		EmptyMenu.ShowMenu
		am.DlgInputStr g_(Me,"Enter URL"), g_(Me,"URL:"), 40, "", m_Self & ".sendURL"
	End Sub
	
	Sub sendURL(input)
		'am.Update
		ActiveXManager("BramusICQ.cICQ").BiW_SendURL CLng(contactUIN), CStr(input)
		Util.Sleep 100
		Shell.SendKeys "%{S}"
		Util.DisplayMsgBox g_(Me,"URL Sent to ") & contactNick ,2, ""
	End Sub

End Class

