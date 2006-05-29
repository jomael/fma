'FMA Script Framework Plugin
'MousePlus
'Control your mouse cursor and PC
'Needs AutoItX control!

'TODO:
'-nothing atm

Class MousePlus
	
	Private llist
	Private m_Self
	Private m_QuitDlg
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = True
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = g_(Me,"Mouse+")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"Conotrol your mouse!")
	End Property
	Public Property Get AUTHOR 'Who created me?
		AUTHOR      = "streawkceur (inspired by jbngar)"
	End Property
	Public Property Get URL 'Were can I be found? Where can you get more information?
		URL = "http://fma.xinium.com/"
	End Property
	
	'Who am I?
	Public Property Let Self (s)
		m_Self = s
	End Property
	Public Property Get Self
		Self = m_Self
	End Property
	
	'Display me. Eventually put a menu on the screen
	Sub Show()
		'Push empty menu to prevent switching pages of the previous menu
		EmptyMenu.ShowMenu
		PutDialogue
		m_QuitDlg = False 'Don't quit the dialoge on Left Softkey and Joy Press. Only when the Back button is pressed!
		'KeyPad
		KeyManager.RegisterKey   KEY_1,         "Shell.SendKeys ""{TAB}""",                                     STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_2,         "Shell.SendKeys ""{UP}""",                                      STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_3,         "Shell.SendKeys ""{ESC}""",                                     STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_4,         "Shell.SendKeys ""{LEFT}""",                                    STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_5,         "Shell.SendKeys ""{DOWN}""",                                    STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_6,         "Shell.SendKeys ""{RIGHT}""",                                   STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_7,         Self & ".AltTabDown",                                           STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_7,         Self & ".AltTabUp",                                             STATE_RELEASE, Me
		KeyManager.RegisterKey   KEY_8,         "Shell.SendKeys ""{PGUP}""",                                    STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_9,         "Shell.SendKeys ""{PGDN}""",                                    STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_ASTERIX,   Self & ".CloseApp",                                     	STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_0,         "Shell.SendKeys ""~""",                                         STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_SHARP,     Self & ".Input",                                                STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_C,         "Shell.SendKeys ""{BACKSPACE}""",                               STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_SOFTLEFT,  "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseLeftClick",  STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_SOFTRIGHT, "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseRightClick", STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_VOLUP,     "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseWhlUp",      STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_VOLDOWN,   "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseWhlDown",    STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_BACK,      Self & ".BackButton",                                           STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_NO,	Self & ".BackButton",                                           STATE_PRESS  , Me
		'JoyStick
		KeyManager.RegisterKey   KEY_JOYLEFT,   "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseMove ""W""", STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_JOYUP,     "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseMove ""N""", STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_JOYRIGHT,  "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseMove ""E""", STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_JOYDOWN,   "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseMove ""S""", STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_JOYPRESS,  "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseLeftClick",  STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_YES,  	"ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseLeftClick",  STATE_PRESS  , Me
		KeyManager.RegisterKey	 KEY_JOYLEFT,   "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseStop",	STATE_RELEASE, Me
		KeyManager.RegisterKey	 KEY_JOYUP,     "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseStop",       STATE_RELEASE, Me
		KeyManager.RegisterKey	 KEY_JOYRIGHT,  "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseStop",       STATE_RELEASE, Me
		KeyManager.RegisterKey	 KEY_JOYDOWN,   "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseStop",       STATE_RELEASE, Me
		fma.EnableKeyMonitor
	End Sub
	
	Sub PutDialogue
		'No Menu here. Just show information and register keys.
		Util.DisplayMsgBox g_(Me,"1:tab 3:esc 7:alt-tab 8,9:pgdn/up 0:enter *:alt-F4 #:text-input back:exit"), 0, Self & ".Quit" 'Mangage the menu quit by ourselves
	End Sub
	
	Sub Input
		'Unregister all our key events, we don't want to react on them in the Text Input dialogue
		KeyManager.DeregisterAll Me
		am.Back = Self & ".QuitInput" 'Mangage the menu quit by ourselves
		am.DlgInputStr g_(Me,"Mouse+"), g_(Me,"Prompt:"), 64, "", Self & ".DlgInputStrResult"
	End Sub
	Sub DlgInputStrResult( input )
		Shell.SendKeys input
		'Show the menu and Register the keys
		Show
	End Sub
	Sub CloseApp
		Shell.SendKeys "%{F4}"
	End Sub
	Sub QuitInput
		Show
	End Sub
	
	Sub BackButton
		m_QuitDlg = True
	End Sub
	
	'Alt-TAB cycle
	Sub AltTabDown
		ActiveXManager("AutoItX.Control").Send "{ALTDOWN}{TAB}"
		'Go through windows every second
		fma.AddTimer 1000, "ActiveXManager(""AutoItX.Control"").Send ""{TAB}"""
	End Sub
	Sub AltTabUp
		fma.DeleteTimer "ActiveXManager(""AutoItX.Control"").Send ""{TAB}"""
		ActiveXManager("AutoItX.Control").Send "{ALTUP}"
	End Sub
	
	Sub Quit
		If m_QuitDlg Then 'Only quit when we are allowed to. And we're only allowed to quit, when the back button is pressed
			'Unregister all our key events
			KeyManager.DeregisterAll Me
			fma.DisableKeyMonitor
			'Remove emtpy menu
			MenuStack.Top.Quit
		Else
			PutDialogue 'Repaint the dialogue that the back button is monitored again
		End If
	End Sub
	
End Class