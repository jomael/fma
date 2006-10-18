'FMA Script Framework Plugin
'MediaCenter
'Allows for controlling MS Media Center 2005 (probably older versions too)
'I use a DlgYesNo and a DlgInformation box... don't know which version you need for those to work.
'Furthermore, the info box is layed out for a t610.
'
'For the keys: 
'camera: mute, vol up and down do exactly that :)
'1: play, 4: record, 7: stop
'2: previous, 3: next, 5: rewind, 6: fast forward
'9: channel up, #: channel down
'8: change subtitle, 0: input box (for example to enter a number to change the channel),
'*: close media center
'joystick is navigation with softkeys left and right mouse button (or enter and details) 
'and finally c: back in media center and back: go to previous menu
'
'The key assignment is easily changeable in the code
'
'TODO:
'-nothing atm

Class MediaCenter

Private m_Self
Private m_QuitDlg
Private mainMenu

'Some info about the plugin
Public Property Get SHOWABLE 'Do I have a menu?
 SHOWABLE    = True
End Property
Public Property Get TITLE 'What's my name?
 TITLE       = g_(Me,"Media Center")
End Property
Public Property Get DESCRIPTION 'What's my purpose?
 DESCRIPTION = g_(Me,"Allows for controlling MS Media Center")
End Property
Public Property Get AUTHOR 'Who created me?
 AUTHOR      = "FrodoKenny"
End Property
Public Property Get URL 'Were can I be found? Where can you get more information?
 URL = ""
End Property

'Who am I?
Public Property Let Self (s)
 m_Self = s
 ' Some init stuff here:
 If IsEmpty(Settings(Me, "Title")) or Settings(Me, "Title") = "" Then Settings(Me, "Title") = "Media Center"
 If IsEmpty(Settings(Me, "Exe"))   or Settings(Me, "Exe")   = "" Then Settings(Me, "Exe")   = "C:\Windows\eHome\ehShell.exe"
End Property
Public Property Get Self
 Self = m_Self
End Property

'Display me. Eventually put a menu on the screen
Sub Show()
 'Push empty menu to prevent switching pages of the previous menu
 EmptyMenu.ShowMenu
 PutDialogue
 If Not MCOpen Then ' ask to lauch if not already open
  am.DlgYesNo g_(Me,"Launch Media Center?"), Self & ".MCLaunch", 0
 Else
  m_QuitDlg = False 'Don't quit the dialoge on Left Softkey and Joy Press. Only when the Back button is pressed!
  
  'KeyPad
  KeyManager.RegisterKey   KEY_1,         Self & ".MCPause",             STATE_PRESS  , Me
  KeyManager.RegisterKey   KEY_2,         Self & ".MCPrev",              STATE_PRESS  , Me
  KeyManager.RegisterKey   KEY_3,         Self & ".MCNext",              STATE_PRESS  , Me
  KeyManager.RegisterKey   KEY_4,         Self & ".MCRecord",            STATE_PRESS  , Me
  KeyManager.RegisterKey   KEY_5,         Self & ".MCRewind",            STATE_PRESS  , Me
  KeyManager.RegisterKey   KEY_6,         Self & ".MCForward",           STATE_PRESS  , Me
  KeyManager.RegisterKey   KEY_7,         Self & ".MCStop",              STATE_PRESS  , Me
  KeyManager.RegisterKey   KEY_8,         Self & ".MCSubtitle",          STATE_PRESS  , Me
  KeyManager.RegisterKey   KEY_9,         Self & ".MCChanUp",            STATE_PRESS  , Me
  KeyManager.RegisterKey   KEY_ASTERIX,   Self & ".MCClose",             STATE_PRESS  , Me
  KeyManager.RegisterKey   KEY_0,         Self & ".Input",               STATE_PRESS  , Me
  KeyManager.RegisterKey   KEY_SHARP,     Self & ".MCChanDown",          STATE_PRESS  , Me

  KeyManager.RegisterKey   KEY_SOFTLEFT,  Self & ".MCGreenButton",       STATE_PRESS  , Me
  KeyManager.RegisterKey   KEY_SOFTRIGHT, Self & ".MCDetails",           STATE_PRESS  , Me
  KeyManager.RegisterKey   KEY_BACK,      Self & ".Back",                STATE_PRESS  , Me
  KeyManager.RegisterKey   KEY_C,         Self & ".MCReturn",            STATE_PRESS  , Me

  KeyManager.RegisterKey   KEY_CAMERA,    Self & ".MCMute",              STATE_PRESS  , Me
  KeyManager.RegisterKey   KEY_VOLUP,     Self & ".MCIncVol",            STATE_PRESS  , Me
  KeyManager.RegisterKey   KEY_VOLDOWN,   Self & ".MCDecVol",            STATE_PRESS  , Me

  'JoyStick
  KeyManager.RegisterKey   KEY_JOYLEFT,   "Shell.SendKeys ""{LEFT}""",   STATE_PRESS  , Me
  KeyManager.RegisterKey   KEY_JOYUP,     "Shell.SendKeys ""{UP}""",     STATE_PRESS  , Me
  KeyManager.RegisterKey   KEY_JOYRIGHT,  "Shell.SendKeys ""{RIGHT}""",  STATE_PRESS  , Me
  KeyManager.RegisterKey   KEY_JOYDOWN,   "Shell.SendKeys ""{DOWN}""",   STATE_PRESS  , Me
  KeyManager.RegisterKey   KEY_JOYPRESS,  "Shell.SendKeys ""{ENTER}""",  STATE_PRESS  , Me
'   KeyManager.RegisterKey  KEY_JOYLEFT,   "rl.MouseCtrl"").MouseStop",   STATE_RELEASE, Me
'   KeyManager.RegisterKey  KEY_JOYUP,     "trl.MouseCtrl"").MouseStop",  STATE_RELEASE, Me
'   KeyManager.RegisterKey  KEY_JOYRIGHT,  "trl.MouseCtrl"").MouseStop",  STATE_RELEASE, Me
'   KeyManager.RegisterKey  KEY_JOYDOWN,   "trl.MouseCtrl"").MouseStop",  STATE_RELEASE, Me
 End If
End Sub

Sub PutDialogue
 'No Menu here. Just show information and register keys.
 am.Back = Self & ".Quit" 'Mangage the menu quit by ourselves
 am.DlgInformation TITLE, g_(Me,"joy:nav, c:back vol+- 1,2,3: pl/paus,prv,nxt 4,5,6: rec,rwnd,ffwd 7,8,9: stop,subt,ch+ *,0,#: close,input,ch-")
End Sub

Function MCOpen
 MCOpen = Shell.AppActivate(Settings(Me, "Title"))
End Function

Sub MCLaunch( launch )
 If launch Then
  If Fso.FileExists(Settings(Me, "Exe")) Then
   Shell.Exec Settings(Me, "Exe")
   Util.WaitForAppLoad Settings(Me, "Title"), 10000 'Give WMC max. 10 secs to load
  Else
   Debug.ErrorMsg Self & " - Launch: File not found: " & Settings(Me, "Exe")
  End If
  Show
 Else
  m_QuitDlg = True
  Quit
 End If
End Sub

Sub MCChanUp
 If MCOpen Then Shell.SendKeys "{PGUP}"
End Sub

Sub MCChanDown
 If MCOpen Then Shell.SendKeys "{PGDN}"
End Sub

Sub MCPause
 If MCOpen Then Shell.SendKeys "^p"
End Sub

Sub MCPlay
 If MCOpen Then Shell.SendKeys "^+p"
End Sub

Sub MCRecord
 If MCOpen Then Shell.SendKeys "^r"
End Sub

Sub MCStop
 If MCOpen Then Shell.SendKeys "^+s"
End Sub

Sub MCPrev
 If MCOpen Then Shell.SendKeys "^b"
End Sub

Sub MCNext
 If MCOpen Then Shell.SendKeys "^f"
End Sub

Sub MCRewind
 If MCOpen Then Shell.SendKeys "^+b"
End Sub

Sub MCForward
 If MCOpen Then Shell.SendKeys "^+f"
End Sub

Sub MCGreenButton 'Windows logo key+ALT+ENTER
 If MCOpen Then Shell.SendKeys "{ENTER}"
End Sub

Sub MCReturn
 If MCOpen Then Shell.SendKeys "{BACKSPACE}"
End Sub

Sub MCMyTV
 If MCOpen Then Shell.SendKeys "^+t"
End Sub

Sub MCMyMusic
 If MCOpen Then Shell.SendKeys "^m"
End Sub

Sub MCMyVideos
 If MCOpen Then Shell.SendKeys "^e"
End Sub

Sub MCMyPictures
 If MCOpen Then Shell.SendKeys "^i"
End Sub

Sub MCGuide
 If MCOpen Then Shell.SendKeys "^g"
End Sub

Sub MCDetails
 If MCOpen Then Shell.SendKeys "^d"
End Sub

Sub MCRecordedTV
 If MCOpen Then Shell.SendKeys "^o"
End Sub

Sub MCDVDMenu
 If MCOpen Then Shell.SendKeys "^+m"
End Sub

Sub MCAudio
 If MCOpen Then Shell.SendKeys "^+a"
End Sub

Sub MCSubtitle
 If MCOpen Then Shell.SendKeys "^u"
End Sub

Sub MCFullscreen
 If MCOpen Then Shell.SendKeys "%{ENTER}"
End Sub

Sub Input
 'Unregister all our key events, we don't want to react on them in the Text Input dialogue
 KeyManager.DeregisterAll Me
 am.Back = Self & ".QuitInput" 'Mangage the menu quit by ourselves
 am.DlgInputStr TITLE, g_(Me,"Input:"), 64, "", Self & ".DlgInputStrResult"
End Sub
Sub DlgInputStrResult( input )
 Shell.SendKeys input
 QuitInput
End Sub
Sub QuitInput
 'Show the menu and Register the keys
 Show
End Sub

Sub MCClose
 If MCOpen Then Shell.SendKeys "%{F4}"
 m_QuitDlg = True
 Quit
End Sub

Sub MCMute
 If MCOpen Then Shell.SendKeys "{F8}"
End Sub

Sub MCDecVol
 If MCOpen Then Shell.SendKeys "{F9}"
End Sub

Sub MCIncVol
 If MCOpen Then Shell.SendKeys "{F10}"
End Sub

Sub Back
 m_QuitDlg = True
End Sub

Sub Quit
 If m_QuitDlg Then 'Only quit when we are allowed to. And we're only allowed to quit, when the back button is pressed
  'Unregister all our key events
  KeyManager.DeregisterAll Me
  'Remove emtpy menu
  MenuStack.Top.Quit
 Else
  PutDialogue 'Repaint the dialogue that the back button is monitored again
 End If
End Sub

End Class