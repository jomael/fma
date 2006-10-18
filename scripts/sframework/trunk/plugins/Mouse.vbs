'FMA Script Framework Plugin
'Mouse
'Control your mouse

'TODO:
'-nothing atm

Class Mouse
	
	Private llist
	Private m_Self
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = True
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = g_(Me,"Mouse")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"Conotrol your mouse!")
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
	End Property
	Public Property Get Self
		Self = m_Self
	End Property
	
	'Display me. Eventually put a menu on the screen
	Sub Show()
		'Push empty menu to prevent switching pages of the previous menu
		EmptyMenu.ShowMenu
		'No Menu here. Just show information and register keys.
		Util.DisplayMsgBox g_(Me,"Mouse control */5 = leftclick, # = right click"), 0, Self & ".Quit" 'Mangage the menu quit by ourselves
		'KeyPad
		KeyManager.RegisterKey   KEY_1,         "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseMove ""NW""",STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_2,         "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseMove ""N""", STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_3,         "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseMove ""NE""",STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_4,         "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseMove ""W""", STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_5,         "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseLeftClick",  STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_6,         "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseMove ""E""", STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_7,         "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseMove ""SW""",STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_8,         "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseMove ""S""", STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_9,         "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseMove ""SE""",STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_ASTERIX,   "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseLeftClick",  STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_SHARP,     "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseRightClick", STATE_PRESS  , Me
		KeyManager.RegisterKey	 KEY_1,         "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseStop",       STATE_RELEASE, Me
		KeyManager.RegisterKey	 KEY_2,         "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseStop",       STATE_RELEASE, Me
		KeyManager.RegisterKey	 KEY_3,         "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseStop",       STATE_RELEASE, Me
		KeyManager.RegisterKey	 KEY_4,         "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseStop",       STATE_RELEASE, Me
		KeyManager.RegisterKey	 KEY_6,         "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseStop",       STATE_RELEASE, Me
		KeyManager.RegisterKey	 KEY_7,         "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseStop",       STATE_RELEASE, Me
		KeyManager.RegisterKey	 KEY_8,         "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseStop",       STATE_RELEASE, Me
		KeyManager.RegisterKey	 KEY_9,         "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseStop",       STATE_RELEASE, Me
		KeyManager.RegisterKey   KEY_ASTERIX,   "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseStop",       STATE_RELEASE, Me
		KeyManager.RegisterKey   KEY_SHARP,     "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseStop",       STATE_RELEASE, Me
		'JoyStick
		KeyManager.RegisterKey   KEY_JOYLEFT,   "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseMove ""W""", STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_JOYUP,     "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseMove ""N""", STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_JOYRIGHT,  "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseMove ""E""", STATE_PRESS  , Me
		KeyManager.RegisterKey   KEY_JOYDOWN,   "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseMove ""S""", STATE_PRESS  , Me
		KeyManager.RegisterKey	 KEY_JOYLEFT,   "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseStop",	      STATE_RELEASE, Me
		KeyManager.RegisterKey	 KEY_JOYUP,     "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseStop",       STATE_RELEASE, Me
		KeyManager.RegisterKey	 KEY_JOYRIGHT,  "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseStop",       STATE_RELEASE, Me
		KeyManager.RegisterKey	 KEY_JOYDOWN,   "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseStop",       STATE_RELEASE, Me
	End Sub
	
	Sub Quit
		'Unregister all our key events:
		KeyManager.DeregisterAll Me
		'Remove emtpy menu
		MenuStack.Top.Quit
	End Sub
	
End Class

