'FMA Script Framework Plugin
'Powerpoint
'Lets you control MS Powerpoint

'TODO:
'-nothing atm

Class Powerpoint

Private llist
Private m_Self
Private mainMenu

'Some info about the plugin
Public Property Get SHOWABLE 'Do I have a menu?
  SHOWABLE    = True
End Property
Public Property Get TITLE 'What's my name?
  TITLE      = g_(Me,"PowerPoint")
End Property
Public Property Get DESCRIPTION 'What's my purpose?
  DESCRIPTION = g_(Me,"Lets you control Powerpoint")
End Property
Public Property Get AUTHOR 'Who created me?
  AUTHOR      = "streawkceur (inspired by CarpeDi3m) - extended by ws"
End Property
Public Property Get URL 'Were can I be found? Where can you get more information?
  URL = "http://fma.sourceforge.net/"
End Property

'Who am I?
Public Property Let Self (s)
  m_Self = s
  ' Some init stuff here:
  If IsEmpty(Settings(Me, "Title")) or Settings(Me, "Title") = "" Then Settings(Me, "Title") = "Microsoft PowerPoint"
  If IsEmpty(Settings(Me, "Exe"))  or Settings(Me, "Exe")  = "" Then Settings(Me, "Exe")  = "C:\Program Files\Microsoft Office\Office10\Powerpnt.exe"
  'keyboard shortcut to switch to the slide overview. the default is only correct for the german Powerpoint.
  If IsEmpty(Settings(Me, "SlideOverviewShortcut"))  or Settings(Me, "SlideOverviewShortcut")  = "" Then Settings(Me, "SlideOverviewShortcut")  = "{ESC}%ai"
  'keyboard shortcut to resume presentation with the selected slide. the default is only correct if Powerpoint shortcuts are installed
  '(see http://officeone.mvps.org/ppshortcuts/ppshortcuts.html). For Powerpoint2003, "+{F5}" can be used.
  If IsEmpty(Settings(Me, "ResumePresentationShortcut"))  or Settings(Me, "ResumePresentationShortcut")  = "" Then Settings(Me, "ResumePresentationShortcut")  = "{F3}"
  Set mainMenu = New ManagedMenu
  mainMenu.Title = TITLE
End Property
Public Property Get Self
  Self = m_Self
End Property

'Display me. Eventually put a menu on the screen
Sub Show()
  '--> Init Menu
  Set llist = New LinkedList
  Dim bi
  bi = llist.BackInserter
  If PPOpen Then
  bi.Item = Array(g_(Me,"Start Show"),    Self & ".StartShow")
  bi.Item = Array(g_(Me,"Resume"),        Self & ".ResumeShow")
  bi.Item = Array(g_(Me,"End Show"),      Self & ".EndShow")
  bi.Item = Array(g_(Me,"Prev Slide"),    Self & ".PrevSlide")
  bi.Item = Array(g_(Me,"Navigate..."),   Self & ".Navigate")
  bi.Item = Array(g_(Me,"Next Slide"),    Self & ".NextSlide")
  bi.Item = Array(g_(Me,"Choose..."),     Self & ".ChooseSlide")
  bi.Item = Array(g_(Me,"Toggle Screen"), Self & ".Toggle")
  bi.Item = Array(g_(Me,"Close"),         Self & ".Close")
  Else
  bi.Item = Array(g_(Me,"Launch"),        Self & ".Launch")
  End If
  mainMenu.SetList llist
  mainMenu.ShowMenu
End Sub

Function PPOpen
  PPOpen = Shell.AppActivate(Settings(Me, "Title"))
End Function

Sub Launch
  If Fso.FileExists(Settings(Me, "Exe")) Then
  Shell.Exec Settings(Me, "Exe")
  Util.WaitForAppLoad Settings(Me, "Title"), 10000 'Give PP max. 10 secs to load
  Else
  Debug.ErrorMsg Self & " - Launch: File not found: " & Settings(Me, "Exe")
  End If
  Show
End Sub

Sub Close
  If PPOpen Then Shell.SendKeys "%{F4}"
  Util.WaitForAppClose Settings(Me, "Title"), 10000
  Show
End Sub

Sub StartShow
  Shell.SendKeys "{F5}"
  am.Update
  Navigate
End Sub

Sub ResumeShow
  Shell.SendKeys Settings(Me, "ResumePresentationShortcut")
  am.Update
  Navigate
End Sub


Sub NextSlide
  Shell.SendKeys "{RIGHT}"
  am.Update
End Sub

Sub PrevSlide
  Shell.SendKeys "{LEFT}"
  am.Update
End Sub


Sub Toggle
  If PPOpen Then Shell.SendKeys "."
  am.Update
End Sub

Sub EndShow
  If PPOpen Then Shell.SendKeys "{ESC}"
  am.Update
End Sub

'Navigate function allows to use all useful means to switch to the
'next/previous slide: joystick, number keys or volume control
Sub Navigate
  EmptyMenu.ShowMenu
  KeyManager.RegisterKey KEY_JOYLEFT,  Self & ".NavPrevSlide",  STATE_PRESS,  Me
  KeyManager.RegisterKey KEY_JOYUP,    Self & ".NavPrevSlide",  STATE_PRESS,  Me
  KeyManager.RegisterKey KEY_VOLUP,    Self & ".NavPrevSlide",  STATE_PRESS,  Me
  KeyManager.RegisterKey KEY_1,        Self & ".NavPrevSlide",  STATE_PRESS,  Me
  KeyManager.RegisterKey KEY_4,        Self & ".NavPrevSlide",  STATE_PRESS,  Me
  KeyManager.RegisterKey KEY_7,        Self & ".NavPrevSlide",  STATE_PRESS,  Me
  KeyManager.RegisterKey KEY_JOYRIGHT, Self & ".NavNextSlide",  STATE_PRESS,  Me
  KeyManager.RegisterKey KEY_JOYDOWN,  Self & ".NavNextSlide",  STATE_PRESS,  Me
  KeyManager.RegisterKey KEY_VOLDOWN,  Self & ".NavNextSlide",  STATE_PRESS,  Me
  KeyManager.RegisterKey KEY_3,        Self & ".NavNextSlide",  STATE_PRESS,  Me
  KeyManager.RegisterKey KEY_6,        Self & ".NavNextSlide",  STATE_PRESS,  Me
  KeyManager.RegisterKey KEY_9,        Self & ".NavNextSlide",  STATE_PRESS,  Me
  KeyManager.RegisterKey KEY_JOYPRESS, Self & ".QuitAndChoose",  STATE_PRESS,  Me
  KeyManager.RegisterKey KEY_5,        Self & ".QuitAndChoose",  STATE_PRESS,  Me
  KeyManager.RegisterKey KEY_0,        Self & ".NavigateQuit",  STATE_PRESS,  Me
  KeyManager.RegisterKey KEY_ASTERIX,  Self & ".NavigateQuit",  STATE_PRESS,  Me
  KeyManager.RegisterKey KEY_SHARP,    Self & ".NavigateQuit",  STATE_PRESS,  Me

  Util.DisplayMsgBox g_(Me,"Use Joystick or keys for next/prev slide, 5 to choose, 0 to quit"), 0, Self & ".ChooseNavigateQuit" 'Manage the menu quit by ourselves
End Sub


Sub NavigateQuit
  KeyManager.DeregisterAll Me
  MenuStack.Top.Quit 'Remove emtpy menu
End Sub


Sub QuitAndChoose
  NavigateQuit
  ChooseSlide
End Sub



Sub NavNextSlide
  Shell.SendKeys "{RIGHT}"
End Sub

Sub NavPrevSlide
  Shell.SendKeys "{LEFT}"
End Sub


'Choose slide
'switches to slide overview and lets you choose another slide.
'to choose the right slide, you can either use the joystick or the number keys.
'on exit, resumes presentation
Sub ChooseSlide()
  Shell.SendKeys Settings(Me, "SlideOverviewShortcut")
  EmptyMenu.ShowMenu
  KeyManager.RegisterKey KEY_JOYUP,    Self & ".SlideUp",    STATE_PRESS, Me
  KeyManager.RegisterKey KEY_2,        Self & ".SlideUp",    STATE_PRESS, Me
  KeyManager.RegisterKey KEY_JOYRIGHT, Self & ".SlideRight",  STATE_PRESS, Me
  KeyManager.RegisterKey KEY_6,        Self & ".SlideRight",  STATE_PRESS, Me
  KeyManager.RegisterKey KEY_JOYDOWN,  Self & ".SlideDown",  STATE_PRESS, Me
  KeyManager.RegisterKey KEY_8,        Self & ".SlideDown",  STATE_PRESS, Me
  KeyManager.RegisterKey KEY_JOYLEFT,  Self & ".SlideLeft",  STATE_PRESS, Me
  KeyManager.RegisterKey KEY_4,        Self & ".SlideLeft",  STATE_PRESS, Me
  KeyManager.RegisterKey KEY_JOYPRESS, Self & ".ChooseQuitAndNavigate", STATE_PRESS, Me
  KeyManager.RegisterKey KEY_5,        Self & ".ChooseQuitAndNavigate", STATE_PRESS, Me
  KeyManager.RegisterKey KEY_0,        Self & ".ChooseSlideQuit", STATE_PRESS, Me

  Util.DisplayMsgBox g_(Me,"Use Joystick or keys to select slide, 5 to continue, 0 to quit"), 0, Self & ".ChooseSlideQuit" 'Manage the menu quit by ourselves
End Sub

Sub ChooseSlideQuit()
  Shell.SendKeys Settings(Me, "ResumePresentationShortcut")
'  Shell.SendKeys "{F3}"
  KeyManager.DeregisterAll Me
  MenuStack.Top.Quit 'Remove emtpy menu
  Navigate
End Sub

Sub ChooseQuitAndNavigate()
  ChooseSlideQuit
  Navigate
End Sub


Sub SlideUp
  Shell.SendKeys "{UP}"
End Sub

Sub SlideDown
  Shell.SendKeys "{DOWN}"
End Sub

Sub SlideLeft
  Shell.SendKeys "{LEFT}"
End Sub

Sub SlideRight
  Shell.SendKeys "{RIGHT}"
End Sub


End Class
