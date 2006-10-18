'FMA Script Framework Core Plugin
'Demo
'A "simple" demo plugin

'This plugin will demonstrate the possibilities a script developer has
'when using this framework.
'Currently demonstrated and working properly:
'-(Sub)Menus

'TODO:
'	-Demonstrate EventManager   (not demonstrated yet)
'		-EventManager.RegisterEvent "<eventname>", "<command to execute>", <plugin-object>
'		-EventManager.DeregisterAll Me
'		-EventManager.DeregisterAllFromLL <ll>
'		-EventManager.OnEvent <eventname>, Array(<argument1>, <argument2>, ...)
'		-Script Events triggered by FMA
'	-Demonstrate KeyManager     (not demonstrated yet)
'		-KeyManager.RegisterKey "<key>", <state>, "<command to execute>", <plugin-object>
'		-KeyManager.DeregisterAll
'		-KeyManager.DeregisterAllFromLL <LinkedList>
'		-KeyManager.OnKey <key>
'		-KEY_* constants
'	-Demonstrate accesories menu
'		-Handled by ManagedMenu   (see menu demo)
'			-am.Clear
'			-am.Init
'			-am.AddItem
'			-am.NextState
'			-am.Clear
'			-am.SetTitle
'		-Might be handled by ManagedMenu
'			-am.ClearMenu           (not demonstrated yet)
'			-am.Selected            (not demonstrated yet)
'			-am.DlgOption           (not demonstrated yet)
'		-Not handled by ManagedMenu
'			-am.DlgMsgBox		(now handled by Util.DisplayMsgBox)
'			-am.DlgYesNo
'			-am.DlgOnOff
'			-am.DlgPercent
'			-am.DlgInputStr
'			-am.DlgInputInt
'			-am.DlgInformation
'			-am.DlgFeedback
'			-am.DlgForm             (feature not implemented in FMA)
'	-Demonstrate ADT's          (not demonstrated yet)
'		-Hash
'		-LinkedList
'		-Stack
'	-Demonstrate QuickSort      (not demonstrated yet)
'		-QuickSort
'		-Comparator
'		-DataClass
'	-Demonstrate Util Class     (not demonstrated yet)
'		-Sleep
'		-CreateObject
'		-SetStandbyScreenText
'		-WaitForAppLoad
'	-Demonstrate Settings Class (not demonstrated yet)
'		-Settings( key ) [= value]
'	-Demonstrate ActiveXManager (not demonstrated yet)

Class Demo
	
	'myself
	Private m_Self
	'my menus
	Private mainMenu    'Main plugin menu
	Private demoSubMenu 'Demo submenu
	Private amSubMenu   'am.Dlg* demonstration sub menu
	
	'not needed here
	Sub Class_Initialize()
	End Sub
	Sub Class_Terminate()
	End Sub
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = True
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = g_(Me,"Demo Plugin")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"This plugin has the purpose of plugin developer information.")
	End Property
	Public Property Get AUTHOR 'Who created me?
		AUTHOR      = "streawkceur"
	End Property
	Public Property Get URL 'Were can I be found? Where can you get more information?
		URL         = "http://fma.xinium.com/"
	End Property
	
	'Who am I? The Property Self will be set (once) after the plugin is loaded
	Public Property Let Self (s)
		m_Self = s
		
		'The Property Let Self sub is a good place to initialize your menus.
		'At least in the case of static menus. When your menus are changing, you
		'might initialize them each time Show() is called
		
		'===> Init the plugins Main Menu
		'Our Main Menu is a ManagedMenu
		'The Function Util.CreateObject accepts the classname from which the object
		'should be created and the global accessible object variable name, from which
		'the object can be accessed.
		Set mainMenu = New ManagedMenu
		'A ManagedMenu has to know its items, which will be passed within a LinkedList
		'and its title, which will be set further down.
		Dim llist, bi
		Set llist = New LinkedList
		bi = llist.BackInserter
		'The BackInserter will append the given item at the
		'LinkedList each time you assign an item to it.
		'Each menu item consists of an Array with 2 elements (title, command).
		'Note that you must call am.Update each time an item was selected, otherwise
		'the menu will hang up. You may also call am.Update in a Sub that shall be called.
		'If we want to assign our own object methods as a command, the command looks like: m_Self & ".Method"
		bi.Item = Array(g_(Me,"Submenu"),   m_Self & ".SubMenu")
		bi.Item = Array(g_(Me,"Dialogues"), m_Self & ".AMMenu")
		'Transfer the items list to the menu object
		mainMenu.SetList llist
		'Set the menu's title
		mainMenu.Title = TITLE
		
		'===> Init the demo submenu
		Set demoSubMenu = New ManagedMenu
		'We can reuse our variables "llist" and "bi" here
		Set llist = New LinkedList
		bi = llist.BackInserter
		bi.Item = Array(g_(Me,"Debug Message 1"), "Debug.DebugMsg ""demo1""" & vbCrLf & "am.Update")
		bi.Item = Array(g_(Me,"Debug Message 2"), "Debug.DebugMsg ""demo2""" & vbCrLf & "am.Update")
		
		demoSubMenu.SetList llist
		demoSubMenu.Title = g_(Me,"Sub Menu")
		
		'===> Init the Accessories Demo Menu
		Set amSubMenu = New ManagedMenu
		Set llist = New LinkedList
		bi = llist.BackInserter
		bi.Item = Array(g_(Me,"DlgMsgBox"),      m_Self & ".DlgMsgBox")
		bi.Item = Array(g_(Me,"DlgYesNo"),       m_Self & ".DlgYesNo")
		bi.Item = Array(g_(Me,"DlgOnOff"),       m_Self & ".DlgOnOff")
		bi.Item = Array(g_(Me,"DlgPercent"),     m_Self & ".DlgPercent")
		bi.Item = Array(g_(Me,"DlgInputStr"),    m_Self & ".DlgInputStr")
		bi.Item = Array(g_(Me,"DlgInputInt"),    m_Self & ".DlgInputInt")
		bi.Item = Array(g_(Me,"DlgInformation"), m_Self & ".DlgInformation")
		bi.Item = Array(g_(Me,"DlgFeedback"),    m_Self & ".DlgFeedback")
		amSubMenu.SetList llist
		amSubMenu.Title = g_(Me,"Accessrs. Menu")
	End Property
	Public Property Get Self
		Self = m_Self
	End Property
	
	'Display me. Eventually put a menu on the screen
	Sub Show()
		'We want to display our MainMenu
		mainMenu.ShowMenu
	End Sub
	
	Sub SubMenu()
		'We want to display our DemoSubMenu
		demoSubMenu.ShowMenu
	End Sub
	
	Sub AMMenu()
		amSubMenu.ShowMenu
	End Sub
	
	Sub DlgMsgBox()
		'Usage: am.DlgMsgBox "<message>", <timeout secs>
		'0 timeout will disable the timeout
		
		'The MsgBox will stay until the timout is reached and then fall back
		'to the NextState unless you call another am.* Sub like am.Update and bring
		'the menu to another state manually.
		
		'<next_state> Accept    Reject
		'0            Previous  Previous
		'1            Wait      Previous
		'2            Wait      Wait
		'3            Previous  Wait
		'4            Cancel    Previous
		'5            Cancel    Wait
		'6            Cancel    Cancel
		'7            Previous  Cancel
		'8            Wait      Cancel
		'-Previous will most probable quit to the phones connection -> accessories menu
		'-Cancel will quit the whole menu and return to the phones standy screen (until you call am.Update/am.*)
		'-Wait will just stay at the dialogue screen (until you call am.Update/am.*)
		' Wait is a generally good NextState. This will prevent the phone to fall back
		' to other states (standby, accessories menu) and you are the only one defining
		' what's displayed and what's not
		
		'We have to "show" an empty dummy menu. That's because FMA executes the command
		'that's stored in am.Back when a dialogue is quitted via the back button or it times out.
		'As the back button is managed in the ManagedMenu class,  FMA would call am.Back,
		'which will quit the last menu that was displayed before the dialogue.
		'Putting this empty dummy menu will only quit this dummy and then show the last menu before the dialogue.
		EmptyMenu.ShowMenu
		am.DlgMsgBox g_(Me,"Demo text"), 5
		
		'If you want to react yourself when the user quits the dialogue or when the dialoge
		'times out, you should to it like this:
		'EmptyMenu.ShowMenu
		'am.Back = Self & ".DlgMsgBoxQuit" 'Mangage the menu quit by ourselves
		'am.DlgMsgBox "Demo text", 5 'Put the dialogue
	End Sub
	Sub DlgMsgBoxQuit
		Debug.DebugMsg "Dialogue quitted or timed out" 'Here you can do some stuff...
		MenuStack.Top.Quit 'Remove emtpy menu
	End Sub
	
	Sub DlgYesNo()
		'Usage: am.DlgYesNo "<message>", "<command>", <timeout secs>
		'For more detailed comments look at Sub DlgMsgBox.
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
	
	Sub DlgOnOff()
		'Usage: am.DlgYesNo "<title>", "<command>", <default: 0/1>
		EmptyMenu.ShowMenu
		am.DlgOnOff g_(Me,"Light on?"), Self & ".DlgOnOffResult", 1
	End Sub
	Sub DlgOnOffResult( answer )
		If answer = 1 Then
			Debug.DebugMsg "DlgOnOffResult: On!"
		Else
			Debug.DebugMsg "DlgOnOffResult: Off!"
		End If
		MenuStack.Top.Quit 'Remove emtpy menu
	End Sub
	
	Sub DlgPercent()
		'Usage: am.DlgPercent "<title>", "<command>", <steps: 0-100>, <pos: 0-10>
		EmptyMenu.ShowMenu
		am.DlgPercent g_(Me,"Percent demo"), Self & ".DlgPercentResult", 10, 4
	End Sub
	Sub DlgPercentResult( percent, final )
		Debug.DebugMsg "DlgPercentResult percent: " & percent
		Debug.DebugMsg "DlgPercentResult final:   " & final
		If final = 1 Then MenuStack.Top.Quit 'Remove emtpy menu
	End Sub
	
	Sub DlgInputStr()
		'Usage: am.DlgInputStr "<title>", "<prompt>", <maxlen>, "<defaultstring>", "<command>"
		EmptyMenu.ShowMenu
		am.DlgInputStr g_(Me,"InputStr demo"), g_(Me,"Prompt:"), 16, g_(Me,"Default"), Self & ".DlgInputStrResult"
	End Sub
	Sub DlgInputStrResult( input )
		Debug.DebugMsg "DlgInputStrResult: " & input
		MenuStack.Top.Quit 'Remove emtpy menu
	End Sub
	
	Sub DlgInputInt()
		'Usage: am.DlgInputInt "<title>", "<prompt>", <minval>, <maxval>, <defaultval>, "<command>"
		EmptyMenu.ShowMenu
		am.DlgInputInt g_(Me,"InputInt demo"), g_(Me,"Prompt:"), 0, 42, 23, Self & ".DlgInputIntResult"
	End Sub
	Sub DlgInputIntResult( input )
		Debug.DebugMsg "DlgInputIntResult: " & input
		MenuStack.Top.Quit 'Remove emtpy menu
	End Sub
	
	Sub DlgInformation()
		'Usage: am.DlgInformation "<title>", "<msg>"
		EmptyMenu.ShowMenu
		am.DlgInformation g_(Me,"DlgInfo demo"), g_(Me,"Information dialogue demo")
	End Sub
	
	Sub DlgFeedback()
		'Usage: am.DlgFeedback "<title>", "<command>"
		'Warning: the associated command seems to be never called. FMA only gets an *EAII: 0 instead of *EAII: 13,1
		EmptyMenu.ShowMenu
		am.DlgFeedback g_(Me,"DlgFeedbck demo"), Self & ".DlgFeedbackResult"
	End Sub
	Sub DlgFeedbackResult()
		Debug.DebugMsg "DlgFeedbackResult"
		MenuStack.Top.Quit 'Remove emtpy menu
	End Sub

End Class
