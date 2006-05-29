'FMA Script Framework Plugin
'MoosePlusPlus 1.0 beta 2
'Control your mouse cursor and PC
'Requires AutoItX and floAtMediaCtrl.

' The plugin operates in "modes": each mode has a different keypress mapping and a corresponding help screen.
' Switching between the modes is done by pressing KEY_HOME (on t610 and t630 the key on the right side of the cellphone,
'	normally it opens your mobile internet homepage), or KEY_OPT (I've been told it's on the t68i somewhere)
' The keys and actions for different modes are described on the cellphone's display.
'
' There are three modes so far:
' 1) General    - pretty much for remote control of anything
' 2) Opera 	    - for browsing (sorry FF people out there, but Opera IMHO is more customizable (flamewar, anyone? ;)))
' 3) Powerpoint - for presentations
'
' Known problems & bugs:
' 	-- Bug: KEY_SOFTLEFT and KEY_JOYPRESS sometimes exit to main menu
'			(kludged, now works a bit better, but is ugly :-/  )
'
'
' Send any comments or suggestions to solaraddict(at)chello.cz

Class MoosePlusPlus
	
	Private llist
	Private m_Self
	Private m_QuitDlg
	Private curMode
	Private numModes
	Private modeDescription
	Private keysDn
	Private keysUp
	Private scrollSpeed
	Private minScrollSpeed
	Private maxScrollSpeed
	Private scrollSpeedStep
	Private typeRate
	Private taskSwitchSpeed
	Private pptFullScreen
	Private pptSSWin
	Private pptCurrentPage
	Private ppSlideShowBlackScreen
	Private ppSlideShowRunning
	Private maxSlides
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = True
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = g_(Me,"Moose++")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"Mouse and keyboard control.")
	End Property
	Public Property Get AUTHOR 'Who created me?
		AUTHOR      = "solaraddict (inspired by streawkceur and jbngar)"
	End Property
	Public Property Get URL 'Where can I be found? Where can you get more information?
		URL = "http://www.mobileagent.info/forums/index.php?showtopic=510"
	End Property
	
	'Who am I?
	Public Property Let Self (s)	' init
		m_Self = s
		m_QuitDlg = False
		numModes = 3	' number of modes to switch between
		mode = 0		' will be set in Show()
		minScrollSpeed = 500			' NOTE: the larger the number, the SLOWER the speed!
		maxScrollSpeed = 0
		scrollSpeed = minScrollSpeed	' starting scroll at this speed
		scrollSpeedStep = 100			' scrolling acceleration
		typeRate = 50					' send a character every typeRate milliseconds
		taskSwitchSpeed = 1000
		
		' PowerPoint vars
		pptFullScreen = 0
		pptSSWin = False
		ppSlideShowBlackScreen = 3
		ppSlideShowRunning = 1
	End Property
	Public Property Get Self
		Self = m_Self
	End Property
	
	'Display me. Eventually put a menu on the screen
	Sub Show()
		'Push empty menu to prevent switching modes of the previous menu
		EmptyMenu.ShowMenu

		If curMode < 1 Then
			InitStuff
		End If
		KeyManager.DeregisterAll Me
		RegisterMyKeys
		PutDialogue	' show mode dialogue
	End Sub
	
	Sub InitStuff
		EventManager.RegisterEvent "ConnectionLost", Self & ".Quit", Me
		SetNextMode
	End Sub
	
	' this is the description displayed on mobile's screen
	Function GetDescription( modeNum )
		Select Case modeNum
			Case 1 
				GetDescription = "1:tab 2,5,4,6:curs 3:esc 7:alt-tab 8,9:pgdn/up 0:enter *:alt-F4 #:text ok:dbclk c:bksp" ' original Mouse+ setup
			Case 2
				GetDescription = "1:style 2,5:up/dn 3,6:nav 4:new 7:next *:close 8:prev 9:tab 0:enter #:text" ' made for surfing with (a bit customized) Opera 8
			Case 3
				GetDescription = "1:launch 2:up 3:black 4:prev 5:fullscreen 6:next 7:start 8:down 9:mute 0:enter #:goto"
			'Case 4 ' add modes as desired, e.g. 1,2,3,4,5,...
			Case Else 
				GetDescription = "!!! numModes setting error !!!"	' if you get this as dialog, something is wrong
																	' - did you set numModes correctly?
				SetMode 1
		End Select
	End Function
	
	Sub SetPrevMode					' set previous mode
		curMode = curMode - 1
		If curMode < 1 Then
			curMode = numModes
		End If
	End Sub
	
	Sub SetNextMode					' set next mode
		curMode = curMode + 1
		If curMode > numModes Then
			curMode = 1
		End If
		SetMode
	End Sub
	
	Sub SetMode
		modeDescription = GetDescription( curMode )
		PutDialogue
	End Sub
	
	Sub PutDialogue
		'No Menu here. Just show information and register keys.
		Util.DisplayMsgBox modeDescription, 0, Self & ".Quit" 'Manage the menu quit by ourselves
	End Sub

	Sub Quit
'		Debug.DebugMsg "Quit requested, m_QuitDlg is " & m_QuitDlg
		'Unregister all our key events
		KeyManager.DeregisterAll Me
		
		'Remove empty menu
		MenuStack.Top.Quit
	End Sub
	
	' Mode 3 (PPt): go to selected slide
	Sub InputNum( currentpage, pptminimum, pptmaximum )
		'Unregister all our key events, we don't want to react on them in the Text Input dialogue
		KeyManager.DeregisterAll Me
		' copied from InputText, but we don't want any onscreen feedback during presentation, do we?
		'Shell.Exec ScriptFolder & "helper\MoosePlusPlusAlert"
		am.Back = Self & ".QuitInput" 'Manage the menu quit by ourselves
		am.DlgInputInt "Moose++", "Slide #:", pptminimum, pptmaximum, currentpage, Self & ".InputNumResult"
	End Sub
	'	^- calls back -v
	Sub InputNumResult( input )
		If ( pptFullScreen ) Then
			pptSSWin.View.GotoSlide input
		Else
			ActiveXManager("PowerPoint.Application").ActiveWindow.View.GotoSlide input
		End If
		QuitInput
	End Sub
	'   ^^ if Back pressed, go to main screen


	' sends entered text to whatever has focus (mapped to KEY_SHARP in Modes 1 and 2)
	Sub InputText
		'Unregister all our key events, we don't want to react on them in the Text Input dialogue
		KeyManager.DeregisterAll Me
		' Displays a window saying "Cellphone prompt>" on the computer screen 
		' 	for 30 seconds or until .QuitInput, whichever comes first.
		' Works as a reminder to look and type on mobile now.
		' 	(I used to press # and then wonder "Why isn't anything happening?"
		'	before realizing the prompt pops up on mobile, not on computer)
		Shell.Exec ScriptFolder & "helper\MoosePlusPlusAlert"
		am.Back = Self & ".QuitInput" 'Manage the menu quit by ourselves
		am.DlgInputStr g_(Me,"Moose++"), g_(Me,"Prompt:"), 64, "", Self & ".InputTextResult"
	End Sub
	'	^- calls back -v
	Sub InputTextResult( inputText )
		ActiveXManager("AutoItX.Control").Send(TxEscape(inputText))
		QuitInput
	End Sub
	'   ^^ if Back pressed, go to main screen
	'
	Sub QuitInput
		' close the notifier window (it closes on focus)
		Shell.AppActivate("FMA - Moose++ Alert")
		Show
	End Sub

	' escape entered text for AutoItX
	Function TxEscape (inputText)
		inputText = Replace(inputText,"{", "{{}")
		inputText = Replace(inputText,"!", "{!}")
		inputText = Replace(inputText,"#", "{#}")
		inputText = Replace(inputText,"+", "{+}")
		TxEscape = Replace(inputText,"^", "{^}")
	End Function

	' the registration is common for all modes - select ALL keys that you want to use,
	'	no matter in which mode you intend to use them
	Sub RegisterMyKeys
		' these keys are interesting when depressed (the keys, not user ;))
		keysDn = Array ( KEY_JOYUP, KEY_JOYDOWN, KEY_JOYLEFT, KEY_JOYRIGHT, KEY_C, KEY_SOFTRIGHT, KEY_HOME, KEY_OPT, KEY_CAMERA, KEY_VOLUP, KEY_VOLDOWN, KEY_0, KEY_1, KEY_2, KEY_3, KEY_4, KEY_5, KEY_6, KEY_7, KEY_8, KEY_9, KEY_ASTERIX, KEY_SHARP )
		' and these interest us when released - beware, if added in Sub KeyUp, must add here also!
		keysUp = Array ( KEY_JOYUP, KEY_JOYDOWN, KEY_JOYLEFT, KEY_JOYRIGHT, KEY_VOLUP, KEY_VOLDOWN, KEY_2, KEY_5,KEY_4, KEY_6, KEY_C, KEY_7, KEY_8 )
		
		'register pressed keys
		i = 0
		For Each key In keysDn
			KeyManager.RegisterKey key,  Self & ".Key" & i & "Dn", STATE_PRESS, Me
			i = i + 1
		Next
		
		' Do these keys need direct control? This is the ugly hack for KEY_JOYPRESS et al. to work.
		KeyManager.RegisterKey KEY_BACK, Self & ".Quit", STATE_PRESS, Me
		KeyManager.RegisterKey KEY_JOYPRESS, Self & ".JoyPressHack", STATE_PRESS, Me
		KeyManager.RegisterKey KEY_SOFTLEFT, Self & ".SoftLeftPressHack", STATE_PRESS, Me
		
		'register released keys
		i = 0
		For Each key In keysUp
			KeyManager.RegisterKey key,  Self & ".Key" & i & "Up" , STATE_RELEASE, Me
			i = i + 1
		Next
	End Sub

	' hacks to avoid weird exits
	Sub SoftLeftPressHack
		EmptyMenu.ShowMenu
		KeyDn KEY_SOFTLEFT
		Show
	End Sub
	
	Sub JoyPressHack
		EmptyMenu.ShowMenu
		KeyDn KEY_JOYPRESS
		Show
	End Sub

	' handler for all keys pressed
	Sub KeyDn ( key )
		' keys that are common for all modes
		' These keys could also be moved to the modes' sections (feel free to do so),
		' 	however I wanted to have the mouse controls and mode switching to be the same in every mode
		Select Case key
			Case KEY_OPT
				SetNextMode	' go to next mode - t68i
			Case KEY_HOME
				SetNextMode	' go to next mode - t6x0
				
			' move joystick -> move the mouse
			Case KEY_JOYUP
				ActiveXManager("floAtMediaCtrl.MouseCtrl").MouseMove "N"
			Case KEY_JOYDOWN
				ActiveXManager("floAtMediaCtrl.MouseCtrl").MouseMove "S"
			Case KEY_JOYLEFT
				ActiveXManager("floAtMediaCtrl.MouseCtrl").MouseMove "W"
			Case KEY_JOYRIGHT
				ActiveXManager("floAtMediaCtrl.MouseCtrl").MouseMove "E"
			Case KEY_JOYPRESS
				ActiveXManager("floAtMediaCtrl.MouseCtrl").MouseLeftClick

			Case Else
				' keys that are mode-specific
				Select Case curMode
					Case 1 	' default mode
						Select Case key
							Case KEY_CAMERA	' activate the Magnifier. Good for 
											'	reading the screen across the room :)
								Shell.Exec "%SystemRoot%\system32\magnify.exe"
							Case KEY_1
								ActiveXManager("AutoItX.Control").Send "{TAB}"
							Case KEY_2
								ActiveXManager("AutoItX.Control").Send "{UP}"
								fma.AddTimer scrollSpeed, Self & ".FirstUp"
							Case KEY_3
								ActiveXManager("AutoItX.Control").Send "{ESC}"
							Case KEY_4
								ActiveXManager("AutoItX.Control").Send "{LEFT}"
								fma.AddTimer scrollSpeed, Self & ".FirstLeft"
							Case KEY_5
								ActiveXManager("AutoItX.Control").Send "{DOWN}"
								fma.AddTimer scrollSpeed, Self & ".FirstDown"
							Case KEY_6
								ActiveXManager("AutoItX.Control").Send "{RIGHT}"
								fma.AddTimer scrollSpeed, Self & ".FirstRight"
							Case KEY_7
								AltTabDown
							Case KEY_8
								ActiveXManager("AutoItX.Control").Send "{PGUP}"
							Case KEY_9
								ActiveXManager("AutoItX.Control").Send "{PGDN}"
							Case KEY_0
								ActiveXManager("AutoItX.Control").Send "{ENTER}"

							Case KEY_C
								ActiveXManager("AutoItX.Control").Send "{BACKSPACE}"
								fma.AddTimer scrollSpeed, Self & ".FirstClear"
							Case KEY_SOFTLEFT
								ActiveXManager("floAtMediaCtrl.MouseCtrl").MouseLeftClick
								ActiveXManager("floAtMediaCtrl.MouseCtrl").MouseLeftClick
							Case KEY_SOFTRIGHT
								ActiveXManager("floAtMediaCtrl.MouseCtrl").MouseRightClick
							Case KEY_VOLUP
								WheelUpStart
							Case KEY_VOLDOWN
								WheelDownStart
							Case KEY_ASTERIX
								ActiveXManager("AutoItX.Control").Send "!{F4}"
							Case KEY_SHARP
								InputText
						End Select





					Case 2	' mode 2 - Opera browsing (Opera 6 and up is highly customizable
							' 	and therefore great for control by simulated keypresses)
							' You may do so in Opera's Tools > Preferences > tab Advanced > Shortcuts,
							' edit keyboard setup

						Select Case key
							Case KEY_CAMERA
								ActiveXManager("AutoItX.Control").Send "I"	' toggle image display
							Case KEY_VOLUP	' for some reason, .SendKeys doesn't do the trick :(
								ActiveXManager("AutoItX.Control").Send "{NUMPADADD}"		' zoom +10%
							Case KEY_VOLDOWN
								ActiveXManager("AutoItX.Control").Send "{NUMPADSUB}"		' zoom -10%

							Case KEY_1
								ActiveXManager("AutoItX.Control").Send "G"		' toggle page styles/user styles
							Case KEY_2
								ActiveXManager("AutoItX.Control").Send "{UP}"	' cursor up
								fma.AddTimer scrollSpeed, Self & ".FirstUp"
							Case KEY_3
								ActiveXManager("AutoItX.Control").Send "q"		' previous element
							Case KEY_4
								ActiveXManager("AutoItX.Control").Send "^n"		' new window
							Case KEY_5
								ActiveXManager("AutoItX.Control").Send "{DOWN}"	 ' cursor down
								fma.AddTimer scrollSpeed, Self & ".FirstDown"
							Case KEY_6
								ActiveXManager("AutoItX.Control").Send "a"		' previous link
							Case KEY_7
								ActiveXManager("AutoItX.Control").Send "^{TAB}"	' next tab
							Case KEY_8
								ActiveXManager("AutoItX.Control").Send "z"		' previous page
							Case KEY_9
								ActiveXManager("AutoItX.Control").Send "{TAB}"	' next form element/link
							Case KEY_0
								ActiveXManager("AutoItX.Control").Send "{ENTER}"		' press Enter
							Case KEY_C					' backspace
								ActiveXManager("AutoItX.Control").Send "{BACKSPACE}"
								fma.AddTimer scrollSpeed, Self & ".FirstClear"


	' Show/hide bookmarks panel. Modified keymap:
	' keypress: ctrl alt 2
	' Opera command: Set alignment, "hotlist", 6 & Focus panel, "bookmarks" | Set alignment, "hotlist", 0
							Case KEY_SOFTLEFT
								ActiveXManager("AutoItX.Control").Send "^!2"
							Case KEY_SOFTRIGHT
								ActiveXManager("floAtMediaCtrl.MouseCtrl").MouseRightClick
							Case KEY_ASTERIX
								ActiveXManager("AutoItX.Control").Send "^w"	' close tab
							Case KEY_SHARP
								InputText
								
						End Select
						
	


					Case 3	' "Powerpoint: 1:activate 2:up 3:black 4:prev 5:fullscreen 6:next 7:start 8:down 9:mute 0:enter #goto"
						Select Case key
							Case KEY_1 ' activate PPt
								ActiveXManager("PowerPoint.Application").Activate
								If (ActiveXManager("PowerPoint.Application").Windows.Count < 1) Then
									' nothing is open, try to open most recent document
									'ActiveXManager("AutoItX.Control").Send "{ALTDOWN}"
									ActiveXManager("AutoItX.Control").Send "{ALTDOWN}{ALTUP}{ENTER}1"
								End If
								
							Case KEY_2	'cursor up
								ActiveXManager("AutoItX.Control").Send "{UP}"	' cursor up
								fma.AddTimer scrollSpeed, Self & ".FirstUp"
							
							Case KEY_3 ' blank screen during presentation
								If ( pptFullScreen = 0) Then
									pptFullScreen = 1
									pptCurrentPage = ActiveXManager("PowerPoint.Application").ActiveWindow.View.Slide.SlideIndex
									Set pptSSWin = ActiveXManager("PowerPoint.Application").ActivePresentation.SlideShowSettings.Run
									pptSSWin.View.GotoSlide pptCurrentPage
								End If
								
								If ( pptSSWin.View.State = ppSlideShowBlackScreen ) Then
									pptSSWin.View.State = ppSlideShowRunning
								Else
									pptSSWin.View.State = ppSlideShowBlackScreen
								End If
							Case KEY_4
								If ( pptFullScreen = 0 ) Then
									pptCurrentPage = ActiveXManager("PowerPoint.Application").ActiveWindow.View.Slide.SlideIndex
									If ( pptCurrentPage > 1 ) Then ActiveXManager("PowerPoint.Application").ActiveWindow.View.GotoSlide (pptCurrentPage - 1)
								Else
									pptCurrentPage = pptSSWin.View.Slide.SlideIndex
									If ( pptCurrentPage > 1 ) Then pptSSWin.View.GotoSlide (pptCurrentPage - 1)
								End If
								
							Case KEY_5
								If (pptFullScreen) Then
									pptFullScreen = 0
									pptSSWin = False
									ActiveXManager("AutoItX.Control").Send "{ESC}"
								Else
									pptFullScreen = 1
									pptCurrentPage = ActiveXManager("PowerPoint.Application").ActiveWindow.View.Slide.SlideIndex
									Set pptSSWin = ActiveXManager("PowerPoint.Application").ActivePresentation.SlideShowSettings.Run
									pptSSWin.View.GotoSlide pptCurrentPage
								End If
							Case KEY_6
								maxSlides = ActiveXManager("PowerPoint.Application").ActivePresentation.Slides.Count
								If ( pptFullScreen = 0 ) Then
									pptCurrentPage = ActiveXManager("PowerPoint.Application").ActiveWindow.View.Slide.SlideIndex
									If ( pptCurrentPage < maxSlides ) Then ActiveXManager("PowerPoint.Application").ActiveWindow.View.GotoSlide (pptCurrentPage + 1)
								Else
									pptCurrentPage = pptSSWin.View.Slide.SlideIndex
									If ( pptCurrentPage < maxSlides ) Then pptSSWin.View.GotoSlide (pptCurrentPage + 1)
								End If

							Case KEY_7
								pptFullScreen = 1
								Set pptSSWin = ActiveXManager("PowerPoint.Application").ActivePresentation.SlideShowSettings.Run
							Case KEY_8
								ActiveXManager("AutoItX.Control").Send "{DOWN}"	 ' cursor down
								fma.AddTimer scrollSpeed, Self & ".FirstDown"
							Case KEY_9
								ActiveXManager("floAtMediaCtrl.VolumeCtrl").mute = (ActiveXManager("floAtMediaCtrl.VolumeCtrl").mute + 1) Mod 2
							Case KEY_0
								ActiveXManager("AutoItX.Control").Send "{ENTER}"
							Case KEY_C
								pptFullScreen = 0
								pptSSWin = False
								ActiveXManager("AutoItX.Control").Send "{ESC}"
							Case KEY_SOFTLEFT
							Case KEY_SOFTRIGHT
								ActiveXManager("floAtMediaCtrl.MouseCtrl").MouseRightClick
							Case KEY_VOLUP
								ActiveXManager("floAtMediaCtrl.VolumeCtrl").Volume = ActiveXManager("floAtMediaCtrl.VolumeCtrl").Volume + 10
							Case KEY_VOLDOWN
								ActiveXManager("floAtMediaCtrl.VolumeCtrl").Volume = ActiveXManager("floAtMediaCtrl.VolumeCtrl").Volume - 10
							Case KEY_ASTERIX
							Case KEY_SHARP
								If ( pptFullScreen = 0 ) Then
									pptCurrentPage = ActiveXManager("PowerPoint.Application").ActiveWindow.View.Slide.SlideIndex
								Else
									pptCurrentPage = pptSSWin.View.Slide.SlideIndex
								End If
								InputNum pptCurrentPage, 1, ActiveXManager("PowerPoint.Application").ActivePresentation.Slides.Count
						End Select
'					Case 4 ' if you wish to use this mode, you must change numModes to 3 or above
				End Select
		End Select
	End Sub





'----------------------------------------------------



	Sub KeyUp ( key )
		Select Case key
			' common keys
			Case KEY_JOYLEFT
				ActiveXManager("floAtMediaCtrl.MouseCtrl").MouseStop
			Case KEY_JOYRIGHT
				ActiveXManager("floAtMediaCtrl.MouseCtrl").MouseStop
			Case KEY_JOYUP
				ActiveXManager("floAtMediaCtrl.MouseCtrl").MouseStop
			Case KEY_JOYDOWN
				ActiveXManager("floAtMediaCtrl.MouseCtrl").MouseStop
			Case Else
			' keys that are mode-specific
			Select Case curMode
				Case 1
					Select Case key
						Case KEY_2
							KeyUpStop
						Case KEY_4
							KeyLeftStop
						Case KEY_5
							KeyDownStop
						Case KEY_6
							KeyRightStop
						Case KEY_7
							AltTabUp
						Case KEY_C
							KeyClearStop
						Case KEY_VOLUP
							WheelUpStop
						Case KEY_VOLDOWN
							WheelDownStop
					End Select
				Case 2
					Select Case key
						Case KEY_2
							KeyUpStop
						Case KEY_5
							KeyDownStop
						Case KEY_C
							KeyClearStop
					End Select
				Case 3
					Select Case key
						Case KEY_2
							KeyUpStop
						Case KEY_8
							KeyDownStop
					End Select
			End Select
		End Select
	End Sub

	' keyboard handlers for held cursor keys & similar stuff (backspace,...):
	''up
	Sub FirstUp										' after first char sent, wait a bit longer...
		fma.DeleteTimer Self & ".FirstUp"
		fma.AddTimer typeRate, Self & ".KeyUpPress" '...then start sending them faster
	End Sub
	Sub KeyUpPress
		ActiveXManager("AutoItX.Control").Send "{UP}"
	End Sub
	Sub KeyUpStop									' stop sending characters
		fma.DeleteTimer Self & ".FirstUp"
		fma.DeleteTimer Self & ".KeyUpPress"
	End Sub
	
	''down
	Sub FirstDown
		fma.DeleteTimer Self & ".FirstDown"
		fma.AddTimer typeRate, Self & ".KeyDownPress"
	End Sub
	Sub KeyDownPress
		ActiveXManager("AutoItX.Control").Send "{DOWN}"
	End Sub
	Sub KeyDownStop
		fma.DeleteTimer Self & ".FirstDown"
		fma.DeleteTimer Self & ".KeyDownPress"
	End Sub
	''right
	Sub FirstRight
		fma.DeleteTimer Self & ".FirstRight"
		fma.AddTimer typeRate, Self & ".KeyRightPress"
	End Sub
	Sub KeyRightPress
		ActiveXManager("AutoItX.Control").Send "{RIGHT}"
	End Sub
	Sub KeyRightStop
		fma.DeleteTimer Self & ".FirstRight"
		fma.DeleteTimer Self & ".KeyRightPress"
	End Sub
	''left
	Sub FirstLeft
		fma.DeleteTimer Self & ".FirstLeft"
		fma.AddTimer typeRate, Self & ".KeyLeftPress"
	End Sub
	Sub KeyLeftPress
		ActiveXManager("AutoItX.Control").Send "{LEFT}"
	End Sub
	Sub KeyLeftStop
		fma.DeleteTimer Self & ".FirstLeft"
		fma.DeleteTimer Self & ".KeyLeftPress"
	End Sub
	''clear
	Sub FirstClear
		fma.DeleteTimer Self & ".FirstClear"
		fma.AddTimer typeRate, Self & ".KeyClearPress"
	End Sub
	Sub KeyClearPress
		ActiveXManager("AutoItX.Control").Send "{BACKSPACE}"
	End Sub
	Sub KeyClearStop
		fma.DeleteTimer Self & ".FirstClear"
		fma.DeleteTimer Self & ".KeyClearPress"
	End Sub
	
	'Alt-TAB cycle
	Sub AltTabDown
		ActiveXManager("AutoItX.Control").Send "{ALTDOWN}{TAB}"
		'Go through windows every, um, second
		fma.AddTimer taskSwitchSpeed, "ActiveXManager(""AutoItX.Control"").Send ""{TAB}"""
	End Sub
	Sub AltTabUp
		fma.DeleteTimer "ActiveXManager(""AutoItX.Control"").Send ""{TAB}"""
		ActiveXManager("AutoItX.Control").Send "{ALTUP}"
	End Sub

	'Mouse wheel - mapped to Volume buttons in Mode 1
	'' up
	Sub WheelUpStart
		ActiveXManager("floAtMediaCtrl.MouseCtrl").MouseWhlUp
		fma.AddTimer typeRate, "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseWhlUp"
	End Sub
	Sub WheelUpStop
		fma.DeleteTimer "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseWhlUp"
	End Sub
	'' down
	Sub WheelDownStart
		ActiveXManager("floAtMediaCtrl.MouseCtrl").MouseWhlDown
		fma.AddTimer scrollSpeed, "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseWhlDown"
		If scrollSpeed > maxScrollSpeed Then
			scrollSpeed = scrollSpeed - scrollSpeedStep
		End If
	End Sub
	Sub WheelDownStop
		scrollSpeed = minScrollSpeed
		fma.DeleteTimer "ActiveXManager(""floAtMediaCtrl.MouseCtrl"").MouseWhlDown"
	End Sub

	' this is another ugly hack - I've been trying to get 
	' KeyManager to send key value to handler function
	' but it doesn't allow sending parameters to handler functions :(
	Sub Key0Dn
		KeyDn keysDn(0)
	End Sub
	Sub Key1Dn
		KeyDn keysDn(1)
	End Sub
	Sub Key2Dn
		KeyDn keysDn(2)
	End Sub
	Sub Key3Dn
		KeyDn keysDn(3)
	End Sub
	Sub Key4Dn
		KeyDn keysDn(4)
	End Sub
	Sub Key5Dn
		KeyDn keysDn(5)
	End Sub
	Sub Key6Dn
		KeyDn keysDn(6)
	End Sub
	Sub Key7Dn
		KeyDn keysDn(7)
	End Sub
	Sub Key8Dn
		KeyDn keysDn(8)
	End Sub
	Sub Key9Dn
		KeyDn keysDn(9)
	End Sub
	Sub Key10Dn
		KeyDn keysDn(10)
	End Sub
	Sub Key11Dn
		KeyDn keysDn(11)
	End Sub
	Sub Key12Dn
		KeyDn keysDn(12)
	End Sub
	Sub Key13Dn
		KeyDn keysDn(13)
	End Sub
	Sub Key14Dn
		KeyDn keysDn(14)
	End Sub
	Sub Key15Dn
		KeyDn keysDn(15)
	End Sub
	Sub Key16Dn
		KeyDn keysDn(16)
	End Sub
	Sub Key17Dn
		KeyDn keysDn(17)
	End Sub
	Sub Key18Dn
		KeyDn keysDn(18)
	End Sub
	Sub Key19Dn
		KeyDn keysDn(19)
	End Sub
	Sub Key20Dn
		KeyDn keysDn(20)
	End Sub
	Sub Key21Dn
		KeyDn keysDn(21)
	End Sub
	Sub Key22Dn
		KeyDn keysDn(22)
	End Sub
	Sub Key23Dn
		KeyDn keysDn(23)
	End Sub
	Sub Key24Dn
		KeyDn keysDn(24)
	End Sub
	Sub Key25Dn
		KeyDn keysDn(25)
	End Sub
	
	Sub Key0Up
		KeyUp keysUp(0)
	End Sub
	Sub Key1Up
		KeyUp keysUp(1)
	End Sub
	Sub Key2Up
		KeyUp keysUp(2)
	End Sub
	Sub Key3Up
		KeyUp keysUp(3)
	End Sub
	Sub Key4Up
		KeyUp keysUp(4)
	End Sub
	Sub Key5Up
		KeyUp keysUp(5)
	End Sub
	Sub Key6Up
		KeyUp keysUp(6)
	End Sub
	Sub Key7Up
		KeyUp keysUp(7)
	End Sub
	Sub Key8Up
		KeyUp keysUp(8)
	End Sub
	Sub Key9Up
		KeyUp keysUp(9)
	End Sub
	Sub Key10Up
		KeyUp keysUp(10)
	End Sub
	Sub Key11Up
		KeyUp keysUp(11)
	End Sub
	Sub Key12Up
		KeyUp keysUp(12)
	End Sub
	Sub Key13Up
		KeyUp keysUp(13)
	End Sub
	Sub Key14Up
		KeyUp keysUp(14)
	End Sub
	Sub Key15Up
		KeyUp keysUp(15)
	End Sub
	Sub Key16Up
		KeyUp keysUp(16)
	End Sub
	Sub Key17Up
		KeyUp keysUp(17)
	End Sub
	Sub Key18Up
		KeyUp keysUp(18)
	End Sub
	Sub Key19Up
		KeyUp keysUp(19)
	End Sub
	Sub Key20Up
		KeyUp keysUp(20)
	End Sub
	Sub Key21Up
		KeyUp keysUp(21)
	End Sub
	Sub Key22Up
		KeyUp keysUp(22)
	End Sub
	Sub Key23Up
		KeyUp keysUp(23)
	End Sub
	Sub Key24Up
		KeyUp keysUp(24)
	End Sub
	Sub Key25Up
		KeyUp keysUp(25)
	End Sub
	
End Class

