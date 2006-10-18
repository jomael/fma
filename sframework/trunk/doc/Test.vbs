'FMA Script Framework Core Plugin
'Test
'Playground for some experiments

'TODO
'-this one has no functionality. so there's nothing to do :)

Class Test
	
	Private m_Self
	Private registeredKeysLL
	Private mainMenu 'This is our currently displayed menu
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = True
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = g_(Me,"Test Plugin")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"Experimental Plugin")
	End Property
	Public Property Get AUTHOR 'Who created me?
		AUTHOR      = "streawkceur"
	End Property
	Public Property Get URL 'Were can I be found? Where can you get more information?
		URL = "http://fma.xinium.com/"
	End Property
	
	'Who am I?
	Public Property Let Self (s)
		m_Self = s
		Dim llist, bi
		Set llist = New LinkedList
		Set mainMenu = New ManagedMenu
		mainMenu.Title = TITLE
		bi = llist.BackInserter
		bi.Item = Array(g_(Me,"reg"),   m_Self & ".reg")
		bi.Item = Array(g_(Me,"dereg"), m_Self & ".dereg")
		mainMenu.SetList llist
	End Property
	Public Property Get Self
		Self = m_Self
	End Property
	
	Sub Show()
		mainMenu.ShowMenu
	End Sub
	
	Sub reg()
		Dim bi
		Set registeredKeysLL = New LinkedList
		bi = registeredKeysLL.BackInserter
		Set bi.Item = KeyManager.RegisterKey( KEY_ASTERIX, "Debug.DebugMsg ""--- * pressed""",  STATE_PRESS,   Me )
		Set bi.Item = KeyManager.RegisterKey( KEY_ASTERIX, "Debug.DebugMsg ""--- * released""", STATE_RELEASE, Me )
		am.Update
	End Sub
	
	Sub dereg()
		KeyManager.DeregisterAll Me
		'KeyManager.DeregisterAllFromLL registeredKeysLL
		am.Update
	End Sub
	
	Sub testsub( param )
		MsgBox param
		fma.Sleep 15000
		MsgBox g_(Me,"jup")
	End Sub

End Class

