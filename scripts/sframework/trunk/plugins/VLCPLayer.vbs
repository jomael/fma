'Controls the VLC Player

Class VLCPLayer

Private m_Self 'Reference to myself
Private mainMenu 'The menu
Private isFullscreen 'if true the app is fullscreen and should not be tested for foreground
        'running, we take VLC player starts up not fullscreen default

Private hkPlay, hkPrevious, hkNext, hkStop, hkFullscreen, hkVolumeUp, hkVolumeDown, hkMute, hkFwd, hkBwd 'Constants expressing the shortcut key for each action
Private isPressed 'True if the key is still pressed

'Some info about the plugin
Public Property Get SHOWABLE 'Do I have a menu?
SHOWABLE    = True
End Property
Public Property Get TITLE 'What's my name?
 TITLE       = g_(Me,"VLCPlayer")
End Property
Public Property Get DESCRIPTION 'What's my purpose?
 DESCRIPTION = g_(Me,"Lets you control VLC Player")
End Property
Public Property Get AUTHOR 'Who created me?
AUTHOR      = "ChoKamir"
End Property

'Who am I?
Public Property Let Self (s)
m_Self = s
' Some init stuff here:
If IsEmpty(Settings(Me, "Title")) or Settings(Me, "Title") = "" Then Settings(Me, "Title") = "VLC Media Player"
If IsEmpty(Settings(Me, "Exe"))   or Settings(Me, "Exe")   = "" Then Settings(Me, "Exe")   = "C:\Program Files\VideoLAN\VLC\vlc.exe"

'Sets the shortcuts
hkPlay = " "
hkPrevious = "p"
hkNext = "n"
hkStop = "s"
hkFullscreen = "f"
hkVolumeUp = "^{up}"
hkVolumeDown = "^{down}"
hkMute = "m"
hkFwd = "%{right}"
hkBwd = "%{left}"
isFullscreen = false

'Sets the menu
Set mainMenu = New ManagedMenu
mainMenu.Title = TITLE
End Property
Public Property Get Self
Self = m_Self
End Property

'Display me. Eventually put a menu on the screen
Sub Show()
Dim llist
'--> Init Menu
Set llist = New LinkedList
Dim bi
bi = llist.BackInserter
'Creates the menu
If VLCPlayerOpen Then
 bi.Item = Array("Play/Pause",    Self & ".Play")
 bi.Item = Array("Previous",      Self & ".Previouss")
 bi.Item = Array("Next",          Self & ".Nextt")
 bi.Item = Array("Stop",          Self & ".Stopp")
 bi.Item = Array("Fullscreen",    Self & ".Fullscreen")
 bi.Item = Array("(Un)Mute",      Self & ".Mute")
 bi.Item = Array("Close",         Self & ".Close")
Else
 bi.Item = Array("Launch",        Self & ".Launch")
End If

'makes sure we know when we are kicked out for proper clean up
EventManager.RegisterEvent "MenuClose",      Self & ".ExitMenu", Me
EventManager.RegisterEvent "ConnectionLost", Self & ".ExitMenu", Me

'Registers the key actions used for volume
KeyManager.RegisterKey   KEY_VOLUP,  Self & ".VolumeUp" , STATE_PRESS  , Me
KeyManager.RegisterKey   KEY_VOLDOWN,  Self & ".VolumeDown", STATE_PRESS  , Me
KeyManager.RegisterKey   KEY_VOLUP,  Self & ".Released", STATE_RELEASE  , Me
KeyManager.RegisterKey   KEY_VOLDOWN,  Self & ".Released",  STATE_RELEASE  , Me

'Registers the key actions used
KeyManager.RegisterKey   KEY_JOYRIGHT,  Self & ".Forward" , STATE_PRESS  , Me
KeyManager.RegisterKey   KEY_JOYLEFT,  Self & ".Backward", STATE_PRESS  , Me
KeyManager.RegisterKey   KEY_JOYRIGHT,  Self & ".Released", STATE_RELEASE  , Me
KeyManager.RegisterKey   KEY_JOYLEFT,  Self & ".Released", STATE_RELEASE  , Me

'Shows the menu
mainMenu.SetList llist
mainMenu.ShowMenu

If VLCPlayerOpen Then
 'makes sure we show an empty menu so when we return form the msgbox we come back to the original menu
 EmptyMenu.ShowMenu
 Util.DisplayMsgBox  "Use the phone volume keys to change volume and joystick(left/right) to skip forward/backward", 0, ""
End if
End Sub

'Function returns true if the VLCPlayer is open(foregrounded)
Function VLCPlayerOpen
'Checks if we are running fullscreen, otherwise with overlaying the window will come in front
If isFullscreen Then
 VLCPlayerOpen = True
Else
 'Not in fullscreen so check if we can activate the app
 VLCPlayerOpen = Shell.AppActivate(Settings(Me, "Title"))
End if
End Function

'Triggered when the user click play
Sub Play
If VLCPlayerOpen Then Shell.SendKeys hkPlay
am.Update
End Sub

'Triggered when the user click previous
Sub Previouss
If VLCPlayerOpen Then Shell.SendKeys hkPrevious
am.Update
End Sub

'Triggered when the user click next
Sub Nextt
If VLCPlayerOpen Then Shell.SendKeys hkNext
am.Update
End Sub

'Triggered when the user click stop
Sub Stopp
If VLCPlayerOpen Then Shell.SendKeys hkStop
am.Update
End Sub

'Triggered when the user click fullscreen
Sub Fullscreen
If VLCPlayerOpen Then
 Shell.SendKeys hkFullscreen
 'changes the state of fullscreen
 isFullscreen = Not isFullscreen
 am.Update
End if
End Sub

'Triggered when the user releases the joystick so we can stop changing the volume
Sub Released
isPressed = False
End Sub

'Triggered when the user presses the button to make the volume go up
Sub VolumeUp
If VLCPlayerOpen Then
 'Sets that the joystick is pressed
 isPressed = True
 'loops till the user releases the joystick
 While isPressed
  'makes the volume go up
  Shell.SendKeys hkVolumeUp
  'waits 100ms
  Util.sleep(100)
 Wend
End if
End Sub

'Triggered when the user presses the button to make the volume go up
Sub VolumeDown
If VLCPlayerOpen Then
 'Sets that the joystick is pressed
 isPressed = True
 'loops till the user releases the joystick
 While isPressed
  'makes the volume go up
  Shell.SendKeys hkVolumeDown
  'waits 100ms
  Util.sleep(100)
 Wend
End if
End Sub

'Triggered when the user click Mute
Sub Mute
If VLCPlayerOpen Then Shell.SendKeys hkMute
am.Update
End Sub

'Triggered when the user moves the joystick to go forward
Sub Forward
If VLCPlayerOpen Then
 'Sets that the joystick is pressed
 isPressed = True
 'loops till the user releases the joystick
 While isPressed
  'makes the volume go up
  Shell.SendKeys hkFwd
  'waits 100ms
  Util.sleep(500)
 Wend
End if
End Sub

'Triggered when the user moves the joystick to go backward
Sub Backward
If VLCPlayerOpen Then
 'Sets that the joystick is pressed
 isPressed = True
 'loops till the user releases the joystick
 While isPressed
  'makes the volume go up
  Shell.SendKeys hkBwd
  'waits 100ms
  Util.sleep(500)
 Wend
End if
End Sub

'Triggered when the user wants to close the VLC player
Sub Close
If VLCPlayerOpen Then
 Shell.SendKeys "%{F4}"
 Util.Sleep 3000
End If
Show
End Sub

'Triggered when the user wants to launch the player
Sub Launch
If Fso.FileExists(Settings(Me, "Exe")) Then
 Shell.Exec Settings(Me, "Exe")
 Util.WaitForAppLoad Settings(Me, "Title"),10000
Else
 Debug.ErrorMsg Self & " - Launch: File not found: " & Settings(Me, "Exe")
End If
Show
End Sub

'Triggered when we left a menu
Sub ExitMenu ( sName )
Debug.debugmsg "Exit" + sname
'Checks if that was the VLS main menu
If sName = TITLE Then
 'Makes a clear exit
 KeyManager.DeregisterAll Me
 EventManager.DeregisterAll Me
End If
End sub
End Class