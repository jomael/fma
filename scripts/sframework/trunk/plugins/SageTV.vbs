'FMA Script Framework Plugin
'SageTV 2.1
'Lets you control SageTV 2.1
'Note, this is designed for t68i.  I've commented out lines for t610 functionality
'Also, "Navigate mode" registers all the keys on the phone as follows:
'yes: enter
'no: channel up
'menu (just below yes button): exit navigate mode
'c: channel down
'1: toggle video
'2: skip forward
'3: view currently playing information
'4: rewind
'5: toggle play/pause
'6: fast forward
'7: main menu
'8: skip backward
'9: TV Guide
'0: Stop
'*: back
'#: recordings (might need to modify sage setup for this to work)
'if you hold down the number keys they will respond by sending the corresponding digit
'if you hold down the c key, it's the same as hitting the DEL key on the keyboard



Class SageTV

Private m_Self
Private mainMenu
       Private m_QuitDlg

'Some info about the plugin
Public Property Get SHOWABLE 'Do I have a menu?
 SHOWABLE    = True
End Property
Public Property Get TITLE 'What's my name?
 TITLE       = g_(Me,"SageTV")
End Property
Public Property Get DESCRIPTION 'What's my purpose?
 DESCRIPTION = g_(Me,"Lets you control SageTV 2.1")
End Property
Public Property Get AUTHOR 'Who created me?
 AUTHOR      = "skyw33 adapted from streawkceur's MoreTV"
End Property
Public Property Get URL 'Were can I be found? Where can you get more information?
 URL = ""
End Property

'Who am I?
Public Property Let Self (s)
 m_Self = s
 ' Some init stuff here:
 If IsEmpty(Settings(Me, "Title")) or Settings(Me, "Title") = "" Then Settings(Me, "Title") = "SageTV"
 If IsEmpty(Settings(Me, "Exe"))   or Settings(Me, "Exe")   = "" Then Settings(Me, "Exe")   = "C:\Program Files\Frey Technologies\SageTV\SageTV.exe"
 
 'MainMenu items will be put every time Show() is called
 Set mainMenu = New ManagedMenu
 
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
 If SageTVOpen Then
  
               bi.Item = Array(g_(Me,"Navigate Mode"),  Self & ".LiveMode")
               bi.Item = Array(g_(Me,"Switch Programs"),   Self & ".SwitchPrograms")
               bi.Item = Array(g_(Me,"Fullscreen"),   Self & ".Fullscreen")
               bi.Item = Array(g_(Me,"Record"),  Self & ".Record")
               bi.Item = Array(g_(Me,"Live TV"),   Self & ".LiveTV")
               bi.Item = Array(g_(Me,"Watched"),   Self & ".Watched")
               bi.Item = Array(g_(Me,"Favorite"), Self & ".Favorite")
               bi.Item = Array(g_(Me,"Don't Like"),     Self & ".DontLike")
               bi.Item = Array(g_(Me,"Forward"), Self & ".Forward")
               bi.Item = Array(g_(Me,"Home"),   Self & ".Home")
               bi.Item = Array(g_(Me,"Pause"),     Self & ".Pause")
               bi.Item = Array(g_(Me,"Play"),   Self & ".Play")
               bi.Item = Array(g_(Me,"Play Faster"), Self & ".PlayFaster")
               bi.Item = Array(g_(Me,"Play Slower"),     Self & ".PlaySlower")
               bi.Item = Array(g_(Me,"Setup"),   Self & ".Setup")
               bi.Item = Array(g_(Me,"Aspect Ratio Fill"),   Self & ".AspectRatioFill")
               bi.Item = Array(g_(Me,"Aspect Ratio 16x9"), Self & ".AspectRatio16x9")
               bi.Item = Array(g_(Me,"Aspect Ratio Source"),   Self & ".AspectRatioSource")
               bi.Item = Array(g_(Me,"DVD Reverse Play"), Self & ".DVDReversePlay")
               bi.Item = Array(g_(Me,"DVD Next Chapter"),   Self & ".DVDNextChapter")
               bi.Item = Array(g_(Me,"DVD Previous Chapter"), Self & ".DVDPrevChapter")
               bi.Item = Array(g_(Me,"DVD Menu"),   Self & ".DVDMenu")
               bi.Item = Array(g_(Me,"DVD Title Menu"), Self & ".DVDTitleMenu")
               bi.Item = Array(g_(Me,"DVD Return"),   Self & ".DVDReturn")
               bi.Item = Array(g_(Me,"DVD Subtitle Change"), Self & ".DVDSubtitleChange")
               bi.Item = Array(g_(Me,"DVD Subtitle Toggle"),   Self & ".DVDSubtitleToggle")
               bi.Item = Array(g_(Me,"DVD"),   Self & ".DVD")
               bi.Item = Array(g_(Me,"Search"),     Self & ".Search")
               bi.Item = Array(g_(Me,"Recording Schedule"),   Self & ".RecordingSchedule")
               bi.Item = Array(g_(Me,"Library"), Self & ".Library")
               bi.Item = Array(g_(Me,"Music Jukebox"), Self & ".MusicJukebox")
               bi.Item = Array(g_(Me,"Picture Library"),   Self & ".PictureLibrary")
               bi.Item = Array(g_(Me,"Video Library"),   Self & ".VideoLibrary")
               bi.Item = Array(g_(Me,"Time Scroll"),   Self & ".TimeScroll")
               bi.Item = Array(g_(Me,"Close"),        Self & ".Close")
 Else
  bi.Item = Array(g_(Me,"Launch"),       Self & ".Launch")
 End If
 mainMenu.SetList llist
 mainMenu.Title = TITLE
 mainMenu.ShowMenu
End Sub

Function SageTVOpen
 SageTVOpen = Shell.AppActivate(Settings(Me, "Title"))
End Function

Sub Launch
 If Fso.FileExists(Settings(Me, "Exe")) Then
  Shell.Exec Settings(Me, "Exe")
  Util.WaitForAppLoad Settings(Me, "Title"), 15000 'Give SageTV max. 15 secs to load
 Else
  Debug.DebugMsg Self & " - Launch: File not found: " & Settings(Me, "Exe")
 End If
 Show
End Sub

Sub Close
 If SageTVOpen Then
  Shell.SendKeys "%{F4}"
  Util.Sleep 3000 'Give SageTV 3secs to close itself
 End If
 Show
End Sub

Sub LiveMode
           EmptyMenu.ShowMenu
           PutDialogue
           m_QuitDlg = False
           KeyManager.DeregisterAll Me
 
               KeyManager.RegisterKey   KEY_1,         Self & ".Key1Down",              STATE_PRESS  , Me
 KeyManager.RegisterKey   KEY_1,         Self & ".Key1Up",                STATE_RELEASE, Me
               KeyManager.RegisterKey   KEY_2,         Self & ".Key2Down",              STATE_PRESS  , Me
 KeyManager.RegisterKey   KEY_2,         Self & ".Key2Up",                STATE_RELEASE, Me
               KeyManager.RegisterKey   KEY_3,         Self & ".Key3Down",              STATE_PRESS  , Me
 KeyManager.RegisterKey   KEY_3,         Self & ".Key3Up",                STATE_RELEASE, Me
               KeyManager.RegisterKey   KEY_4,         Self & ".Key4Down",              STATE_PRESS  , Me
 KeyManager.RegisterKey   KEY_4,         Self & ".Key4Up",                STATE_RELEASE, Me
               KeyManager.RegisterKey   KEY_5,         Self & ".Key5Down",              STATE_PRESS  , Me
 KeyManager.RegisterKey   KEY_5,         Self & ".Key5Up",                STATE_RELEASE, Me
               KeyManager.RegisterKey   KEY_6,         Self & ".Key6Down",              STATE_PRESS  , Me
 KeyManager.RegisterKey   KEY_6,         Self & ".Key6Up",                STATE_RELEASE, Me
               KeyManager.RegisterKey   KEY_7,         Self & ".Key7Down",              STATE_PRESS  , Me
 KeyManager.RegisterKey   KEY_7,         Self & ".Key7Up",                STATE_RELEASE, Me
               KeyManager.RegisterKey   KEY_8,         Self & ".Key8Down",              STATE_PRESS  , Me
 KeyManager.RegisterKey   KEY_8,         Self & ".Key8Up",                STATE_RELEASE, Me
               KeyManager.RegisterKey   KEY_9,         Self & ".Key9Down",              STATE_PRESS  , Me
 KeyManager.RegisterKey   KEY_9,         Self & ".Key9Up",                STATE_RELEASE, Me
               KeyManager.RegisterKey   KEY_0,         Self & ".Key0Down",              STATE_PRESS  , Me
 KeyManager.RegisterKey   KEY_0,         Self & ".Key0Up",                STATE_RELEASE, Me
               KeyManager.RegisterKey   KEY_ASTERIX,         Self & ".KeyAsterixDown",              STATE_PRESS  , Me
 KeyManager.RegisterKey   KEY_ASTERIX,         Self & ".KeyAsterixUp",                STATE_RELEASE, Me
               KeyManager.RegisterKey   KEY_SHARP,         Self & ".KeySharpDown",              STATE_PRESS  , Me
 KeyManager.RegisterKey   KEY_SHARP,         Self & ".KeySharpUp",                STATE_RELEASE, Me
       
 'JoyStick
 KeyManager.RegisterKey   KEY_JOYLEFT,   "Shell.SendKeys ""{LEFT}""",    STATE_PRESS, Me 'menu navigation
 KeyManager.RegisterKey   KEY_JOYUP,     "Shell.SendKeys ""{UP}""",      STATE_PRESS, Me 'menu navigation
 KeyManager.RegisterKey   KEY_JOYRIGHT,  "Shell.SendKeys ""{RIGHT}""",   STATE_PRESS, Me 'menu navigation
 KeyManager.RegisterKey   KEY_JOYDOWN,   "Shell.SendKeys ""{DOWN}""",    STATE_PRESS, Me 'menu navigation
       
               KeyManager.RegisterKey   KEY_C,         Self & ".KeyCDown",              STATE_PRESS  , Me
               KeyManager.RegisterKey   KEY_C,         Self & ".KeyCUp",                STATE_RELEASE, Me
               
               'uncomment the following to restore t610 functionality
 'KeyManager.RegisterKey   KEY_SOFTLEFT,  "Shell.SendKeys ""{PGDN}""",    STATE_PRESS, Me 'channel down
 'KeyManager.RegisterKey   KEY_SOFTRIGHT, "Shell.SendKeys ""{PGUP}""",    STATE_PRESS, Me 'channel up
 'KeyManager.RegisterKey   KEY_BACK,      Self & ".BackButton",           STATE_PRESS, Me
               
               'added for t68i
               KeyManager.RegisterKey   KEY_OPT,       Self & ".BackButton",           STATE_PRESS, Me
               KeyManager.RegisterKey   KEY_YES,         Self & ".KeyYesDown",              STATE_PRESS  , Me
               KeyManager.RegisterKey   KEY_YES,         Self & ".KeyYesUp",                STATE_RELEASE, Me
               KeyManager.RegisterKey   KEY_JOYPRESS,         Self & ".KeyYesDown",              STATE_PRESS  , Me
               KeyManager.RegisterKey   KEY_JOYPRESS,         Self & ".KeyYesUp",                STATE_RELEASE, Me
 KeyManager.RegisterKey   KEY_NO,        "Shell.SendKeys ""{PGUP}""",    STATE_PRESS, Me 'channel up
End Sub    
   
   
   
   Sub VolumeMute()
 ActiveXManager("floAtMediaCtrl.VolumeCtrl").mute = (ActiveXManager("floAtMediaCtrl.VolumeCtrl").mute + 1) Mod 2
 'Show
End Sub
   
   Sub BackButton
               'following line added for t68i
               KeyManager.DeregisterAll Me
 m_QuitDlg = True
End Sub
   
   Sub PutDialogue
				'No Menu here. Just show information and register keys.
				Util.DisplayMsgBox g_(Me,"1:video 2:jumpFd 3:info 4:skipBk 5:Pause 6:skipFd 7:Menu 8:jumpBk 9:Guide 0:Stop *:Back #:Rcrdngs"), 0, Self & ".Quit" 'Mangage the menu quit by ourselves
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
   
   
   Dim currentTime
   Sub Key1Down
       currentTime = timer
 fma.AddTimer 2000, "ActiveXManager(""AutoItX.Control"").Send ""1"""
End Sub
Sub Key1Up
       newTime = timer
       if newTime - currentTime < 2 then
           Shell.SendKeys "^v"
       end if
 fma.DeleteTimer "ActiveXManager(""AutoItX.Control"").Send ""1"""
End Sub    
   Sub Key2Down
       currentTime = timer
 fma.AddTimer 2000, "ActiveXManager(""AutoItX.Control"").Send ""2"""
End Sub
Sub Key2Up
       newTime = timer
       if newTime - currentTime < 2 then
           Shell.SendKeys "{F6}"
       end if
 fma.DeleteTimer "ActiveXManager(""AutoItX.Control"").Send ""2"""
End Sub
   Sub Key3Down
       currentTime = timer
 fma.AddTimer 2000, "ActiveXManager(""AutoItX.Control"").Send ""3"""
End Sub
Sub Key3Up
       newTime = timer
       if newTime - currentTime < 2 then
           Shell.SendKeys "^i"
       end if
 fma.DeleteTimer "ActiveXManager(""AutoItX.Control"").Send ""3"""
End Sub
   Sub Key4Down
       currentTime = timer
 fma.AddTimer 2000, "ActiveXManager(""AutoItX.Control"").Send ""4"""
End Sub
Sub Key4Up
       newTime = timer
       if newTime - currentTime < 2 then
           Shell.SendKeys "^a"
       end if
 fma.DeleteTimer "ActiveXManager(""AutoItX.Control"").Send ""4"""
End Sub
   Sub Key5Down
       currentTime = timer
 fma.AddTimer 2000, "ActiveXManager(""AutoItX.Control"").Send ""5"""
End Sub
Sub Key5Up
       newTime = timer
       if newTime - currentTime < 2 then
           Shell.SendKeys "^+s"
       end if
 fma.DeleteTimer "ActiveXManager(""AutoItX.Control"").Send ""5"""
End Sub
   Sub Key6Down
       currentTime = timer
 fma.AddTimer 2000, "ActiveXManager(""AutoItX.Control"").Send ""6"""
End Sub
Sub Key6Up
       newTime = timer
       if newTime - currentTime < 2 then
           Shell.SendKeys "^f"
       end if
 fma.DeleteTimer "ActiveXManager(""AutoItX.Control"").Send ""6"""
End Sub
   Sub Key7Down
       currentTime = timer
 fma.AddTimer 2000, "ActiveXManager(""AutoItX.Control"").Send ""7"""
End Sub
Sub Key7Up
       newTime = timer
       if newTime - currentTime < 2 then
           Shell.SendKeys "{HOME}"
       end if
 fma.DeleteTimer "ActiveXManager(""AutoItX.Control"").Send ""7"""
End Sub
   Sub Key8Down
       currentTime = timer
 fma.AddTimer 2000, "ActiveXManager(""AutoItX.Control"").Send ""8"""
End Sub
Sub Key8Up
       newTime = timer
       if newTime - currentTime < 2 then
           Shell.SendKeys "{F5}"
       end if
 fma.DeleteTimer "ActiveXManager(""AutoItX.Control"").Send ""8"""
End Sub
   Sub Key9Down
       currentTime = timer
 fma.AddTimer 2000, "ActiveXManager(""AutoItX.Control"").Send ""9"""
End Sub
Sub Key9Up
       newTime = timer
       if newTime - currentTime < 2 then
           Shell.SendKeys "^x"
       end if
 fma.DeleteTimer "ActiveXManager(""AutoItX.Control"").Send ""9"""
End Sub
   Sub Key0Down
       currentTime = timer
 fma.AddTimer 2000, "ActiveXManager(""AutoItX.Control"").Send ""0"""
End Sub
Sub Key0Up
       newTime = timer
       if newTime - currentTime < 2 then
           Shell.SendKeys "^g"
       end if
 fma.DeleteTimer "ActiveXManager(""AutoItX.Control"").Send ""0"""
End Sub
   Sub KeyCDown
       currentTime = timer
 fma.AddTimer 2000, "ActiveXManager(""AutoItX.Control"").Send ""{DEL}"""
End Sub
Sub KeyCUp
       newTime = timer
       if newTime - currentTime < 2 then
           Shell.SendKeys "{PGDN}"
       end if
 fma.DeleteTimer "ActiveXManager(""AutoItX.Control"").Send ""{DEL}"""
End Sub
   Sub KeyOptDown
       currentTime = timer
 fma.AddTimer 2000, "ActiveXManager(""AutoItX.Control"").Send ""^+r"""
End Sub
Sub KeyOptUp
       newTime = timer
       if newTime - currentTime < 2 then
           BackButton
       end if
 fma.DeleteTimer "ActiveXManager(""AutoItX.Control"").Send ""^+r"""
End Sub
       Sub KeyYesDown
       currentTime = timer
 fma.AddTimer 2000, "ActiveXManager(""AutoItX.Control"").Send ""^+l"""
End Sub
Sub KeyYesUp
       newTime = timer
       if newTime - currentTime < 2 then
           Shell.SendKeys "~"
       end if
 fma.DeleteTimer "ActiveXManager(""AutoItX.Control"").Send ""^+l"""
End Sub
   Sub KeyNoDown
       currentTime = timer
 fma.AddTimer 2000, "ActiveXManager(""AutoItX.Control"").Send ""{DEL}"""
End Sub
Sub KeyNoUp
       newTime = timer
       if newTime - currentTime < 2 then
           Shell.SendKeys "{PGUP}"
       end if
 fma.DeleteTimer "ActiveXManager(""AutoItX.Control"").Send ""{DEL}"""
End Sub
   Sub KeyAsterixDown
       currentTime = timer
 fma.AddTimer 2000, "ActiveXManager(""AutoItX.Control"").Send ""^o"""
End Sub
Sub KeyAsterixUp
       newTime = timer
       if newTime - currentTime < 2 then
           Shell.SendKeys "%{LEFT}"
       end if
 fma.DeleteTimer "ActiveXManager(""AutoItX.Control"").Send ""^o"""
End Sub
   Sub KeySharpDown
       currentTime = timer
 fma.AddTimer 2000, "ActiveXManager(""AutoItX.Control"").Send ""^+p"""
End Sub
Sub KeySharpUp
       newTime = timer
       if newTime - currentTime < 2 then
           Shell.SendKeys "%3"
       end if
 fma.DeleteTimer "ActiveXManager(""AutoItX.Control"").Send ""^+p"""
End Sub
   
   

Sub Button1
 If SageTVOpen Then  Shell.SendKeys 1
 am.Update
End Sub
Sub Button2
 If SageTVOpen Then  Shell.SendKeys 2
 am.Update
End Sub
Sub Button3
 If SageTVOpen Then  Shell.SendKeys 3
 am.Update
End Sub
Sub Button4
 If SageTVOpen Then  Shell.SendKeys 4
 am.Update
End Sub
Sub Button5
 If SageTVOpen Then  Shell.SendKeys 5
 am.Update
End Sub
Sub Button6
 If SageTVOpen Then  Shell.SendKeys 6
 am.Update
End Sub
Sub Button7
 If SageTVOpen Then  Shell.SendKeys 7
 am.Update
End Sub
Sub Button8
 If SageTVOpen Then  Shell.SendKeys 8
 am.Update
End Sub
Sub Button9
 If SageTVOpen Then  Shell.SendKeys 9
 am.Update
End Sub
Sub Button0
 If SageTVOpen Then  Shell.SendKeys 0
 am.Update
End Sub

Sub ChannelUp
 If SageTVOpen Then Shell.SendKeys "{PGUP}"
 am.Update
End Sub

Sub ChannelDown
 If SageTVOpen Then Shell.SendKeys "{PGDN}"
 am.Update
End Sub

Sub VideoToggle
 If SageTVOpen Then Shell.SendKeys "^v"
 am.Update
End Sub

Sub Fullscreen
 If SageTVOpen Then Shell.SendKeys "^+f"
 am.Update
End Sub
   
Sub Selects
 If SageTVOpen Then Shell.SendKeys "~"
 am.Update
End Sub
   
Sub Watched
 If SageTVOpen Then Shell.SendKeys "^w"
 am.Update
End Sub
   
   Sub Favorite
 If SageTVOpen Then Shell.SendKeys "^k"
 am.Update
End Sub
   
Sub DontLike
 If SageTVOpen Then Shell.SendKeys "^j"
 am.Update
End Sub
   
Sub Info
 If SageTVOpen Then Shell.SendKeys "^i"
 am.Update
End Sub
   
Sub Record
 If SageTVOpen Then Shell.SendKeys "^y"
 am.Update
End Sub
   
Sub Home
 If SageTVOpen Then Shell.SendKeys "{HOME}"
 am.Update
End Sub
   
Sub Options
 If SageTVOpen Then Shell.SendKeys "{ESC}"
 am.Update
End Sub
   
Sub PageUp
 If SageTVOpen Then Shell.SendKeys "{F5}"
 am.Update
End Sub
   
Sub PageDown
 If SageTVOpen Then Shell.SendKeys "{F6}"
 am.Update
End Sub
   
Sub PageRight
 If SageTVOpen Then Shell.SendKeys "{F8}"
 am.Update
End Sub
   
Sub PageLeft
 If SageTVOpen Then Shell.SendKeys "{F7}"
 am.Update
End Sub
   
Sub PlayPause
 If SageTVOpen Then Shell.SendKeys "^+s"
 am.Update
End Sub
   
Sub SkipForward2
 If SageTVOpen Then Shell.SendKeys "^{F8}"
 am.Update
End Sub
   
Sub SkipBackward2
 If SageTVOpen Then Shell.SendKeys "^{F7}"
 am.Update
End Sub
   
Sub Back
 If SageTVOpen Then Shell.SendKeys "%{LEFT}"
 am.Update
End Sub
   
   Sub Forward
 If SageTVOpen Then Shell.SendKeys "%{RIGHT}"
 am.Update
End Sub
   
   Sub Customize
 If SageTVOpen Then Shell.SendKeys "^+{F12}"
 am.Update
End Sub
   
   Sub Delete
 If SageTVOpen Then Shell.SendKeys "{DEL}"
 am.Update
End Sub
   
   Sub Stopping
 If SageTVOpen Then Shell.SendKeys "^g"
 am.Update
End Sub
   
   Sub Left
 If SageTVOpen Then Shell.SendKeys "{LEFT}"
 am.Update
End Sub
   
   Sub Right
 If SageTVOpen Then Shell.SendKeys "{RIGHT}"
 am.Update
End Sub
   
   Sub Pause
 If SageTVOpen Then Shell.SendKeys "^s"
 am.Update
End Sub
   
   Sub Play
 If SageTVOpen Then Shell.SendKeys "^d"
 am.Update
End Sub
   
   Sub SkipForward
 If SageTVOpen Then Shell.SendKeys "^f"
 am.Update
End Sub
   
Sub SkipBackward
 If SageTVOpen Then Shell.SendKeys "^a"
 am.Update
End Sub
   
   Sub PlayFaster
 If SageTVOpen Then Shell.SendKeys "^m"
 am.Update
End Sub
   
   Sub PlaySlower
 If SageTVOpen Then Shell.SendKeys "^n"
 am.Update
End Sub
   
   Sub Guide
 If SageTVOpen Then Shell.SendKeys "^x"
 am.Update
End Sub
   
   Sub Up
 If SageTVOpen Then Shell.SendKeys "{UP}"
 am.Update
End Sub

Sub Down
 If SageTVOpen Then Shell.SendKeys "{DOWN}"
 am.Update
End Sub
   
   Sub Search
 If SageTVOpen Then Shell.SendKeys "^+1"
 am.Update
End Sub
   
   Sub Setup
 If SageTVOpen Then Shell.SendKeys "^+2"
 am.Update
End Sub
   
   Sub Library
 If SageTVOpen Then Shell.SendKeys "^+3"
 am.Update
End Sub
   
   Sub PowerOn
 If SageTVOpen Then Shell.SendKeys "^+4"
 am.Update
End Sub
   
   Sub PowerOff
 If SageTVOpen Then Shell.SendKeys "^+5"
 am.Update
End Sub
   
   Sub AspectRatioFill
 If SageTVOpen Then Shell.SendKeys "^+6"
 am.Update
End Sub
   
   Sub AspectRatio4x3
 If SageTVOpen Then Shell.SendKeys "^+7"
 am.Update
End Sub
   
   Sub AspectRatio16x9
 If SageTVOpen Then Shell.SendKeys "^+8"
 am.Update
End Sub
   
   Sub AspectRatioSource
 If SageTVOpen Then Shell.SendKeys "^+9"
 am.Update
End Sub
   
   Sub PreviousChannel
 If SageTVOpen Then Shell.SendKeys "^+0"
 am.Update
End Sub
   
   Sub LiveTV
 If SageTVOpen Then Shell.SendKeys "^%1"
 am.Update
End Sub
   
   Sub DVDReversePlay
 If SageTVOpen Then Shell.SendKeys "^%2"
 am.Update
End Sub
   
   Sub DVDNextChapter
 If SageTVOpen Then Shell.SendKeys "^%3"
 am.Update
End Sub
   
   Sub DVDPrevChapter
 If SageTVOpen Then Shell.SendKeys "^%4"
 am.Update
End Sub
   
   Sub DVDMenu
 If SageTVOpen Then Shell.SendKeys "^%5"
 am.Update
End Sub
   
   Sub DVDTitleMenu
 If SageTVOpen Then Shell.SendKeys "^%6"
 am.Update
End Sub
   
   Sub DVDReturn
 If SageTVOpen Then Shell.SendKeys "^%7"
 am.Update
End Sub
   
   Sub DVDSubtitleChange
 If SageTVOpen Then Shell.SendKeys "^%8"
 am.Update
End Sub
   
   Sub DVDSubtitleToggle
 If SageTVOpen Then Shell.SendKeys "^%9"
 am.Update
End Sub
   
   Sub DVD
 If SageTVOpen Then Shell.SendKeys "^%0"
 am.Update
End Sub
   
   Sub MusicJukebox
 If SageTVOpen Then Shell.SendKeys "%1"
 am.Update
End Sub
   
   Sub RecordingSchedule
 If SageTVOpen Then Shell.SendKeys "%2"
 am.Update
End Sub
   
   Sub SageTVRecordings
 If SageTVOpen Then Shell.SendKeys "%3"
 am.Update
End Sub
   
   Sub PictureLibrary
 If SageTVOpen Then Shell.SendKeys "%4"
 am.Update
End Sub
   
   Sub VideoLibrary
 If SageTVOpen Then Shell.SendKeys "%5"
 am.Update
End Sub
   
   Sub TimeScroll
 If SageTVOpen Then Shell.SendKeys "%6"
 am.Update
End Sub
   
   Sub SwitchPrograms
 Shell.SendKeys "%{TAB}"
 am.Update
End Sub

End Class
