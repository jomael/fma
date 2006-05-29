'FMA Script Framework Plugin
'Simple plugin (L10N)

'
'
'
'
'

Class SimpleL10n
	
	Private m_Self 'Here your own name will be stored. We'll cover that later... See also Property Let/Get Self
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = True
	End Property
	Public Property Get TITLE 'What's my name? This will be the title of your menu entry in the main menu
		TITLE       = g_(Me,"Simple plugin") 'Localized TITLE string - SimpleL10n.po must contain translation of this string
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"A minimum example for a plugin") 'Localized DESCRIPTION
	End Property
	Public Property Get AUTHOR 'Who created me?
		AUTHOR      = "streawkceur" 'do not localize AUTHOR
	End Property
	Public Property Get URL 'Were can I be found? Where can you get more information?
		URL         = "http://fma.xinium.com/" 'do not localize URL
	End Property
	
	'Who am I?
	Public Property Let Self (s)
		m_Self = s
	End Property
	Public Property Get Self
		Self = m_Self
	End Property
	
	'Show will be called every time the user selects your plugin from the main menu
	Sub Show()
		'Just put a log message to FMA
		Debug.InfoMsg "Developing plugins is simple!" 'do not localize debug messages
    
    '--> Init Menu
		Set llist = New LinkedList
		Dim bi
		bi = llist.BackInserter
			bi.Item = Array(g_(Me,"Test"),  Self & ".Test")
			bi.Item = Array(g_(DD,"About"), Self & ".About")
		End If
		mainMenu.SetList llist
		
		mainMenu.Title = TITLE
		mainMenu.ShowMenu		
		
		'put an am.Update to prevent the menu from getting stuck
		am.Update
	End Sub

	Sub Test
		EmptyMenu.ShowMenu
		am.DlgYesNo g_(Me,"Do you like this demo?"), Self & ".DlgYesNoResult", 5
	End Sub
  Sub DlgYesNoResult( answer )
		If answer = 1 Then
			Debug.DebugMsg "DlgYesNoResult: Yes, you do!"
		Else 
			Debug.DebugMsg "DlgYesNoResult: No, you don't!"
		End If
		MenuStack.Top.Quit 'Remove emtpy menu
	End Sub
	
  Sub About()
		EmptyMenu.ShowMenu
		am.DlgInformation g_(DD,"About"), g_(Me,"L10n Demo")
	End Sub

End Class

