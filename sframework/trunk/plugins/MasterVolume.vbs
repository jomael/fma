'FMA Script Framework Plugin
'MasterVolume
'Let's you change the master volume of your soundcard

'TODO:
'-nothing atm.
'-maybe react on the event MusicMute

Class MasterVolume
	
	Private m_Self
	Private mainMenu
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = True
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = g_(Me,"Master Volume")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"Let's you change the master volume of your soundcard")
	End Property
	Public Property Get AUTHOR 'Who created me?
		AUTHOR      = "streawkceur (inspired by ultimatex)"
	End Property
	Public Property Get URL 'Were can I be found? Where can you get more information?
		URL = "http://fma.xinium.com/"
	End Property
	
	'Who am I?
	Public Property Let Self (s)
		m_Self = s
		'Create managed menu object
		Set mainMenu = New ManagedMenu
	End Property
	Public Property Get Self
		Self = m_Self
	End Property
	
	'Display me.
	Sub Show()
		'Note that you MUST do an am.Upate EVERYRTIME your menu command was executed
		
		'Init Menu LList
		Dim llist, bi
		Set llist = New LinkedList
		bi = llist.BackInserter
		bi.Item = Array(g_(Me,"Set Volume"), Self & ".VolumeSet")
		If ActiveXManager("floAtMediaCtrl.VolumeCtrl").mute = 0 Then
			bi.Item = Array(g_(Me,"Mute"), Self & ".VolumeMute")
		Else
			bi.Item = Array(g_(Me,"Unmute"),  Self & ".VolumeMute")
		End If
		
		'Set title
		If ActiveXManager("floAtMediaCtrl.VolumeCtrl").Mute = 0 Then
			mainMenu.Title = g_(Me,"Volume (") & ActiveXManager("floAtMediaCtrl.VolumeCtrl").Volume & g_(Me,"%)")
		Else
			mainMenu.Title = g_(Me,"Volume (M)")
		End If
		
		'Set list and show
		mainMenu.SetList llist
		mainMenu.ShowMenu
	End Sub
	
	Sub VolumeSet()
		am.Back = Self & ".Show"
		am.DlgPercent g_(Me,"Volume"), Self & ".VolumeSetEvent", 10, ActiveXManager("floAtMediaCtrl.VolumeCtrl").Volume/10
	End Sub
	
	Sub VolumeSetEvent( value, final )
		ActiveXManager("floAtMediaCtrl.VolumeCtrl").Volume = value
		If final = 1 Then Show
	End Sub
	
	Sub VolumeMute()
		ActiveXManager("floAtMediaCtrl.VolumeCtrl").mute = (ActiveXManager("floAtMediaCtrl.VolumeCtrl").mute + 1) Mod 2
		Show
	End Sub

End Class

