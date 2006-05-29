'FMA Script Framework Plugin
'MediaPlayer
'Allows for controlling MS Media Player

'TODO:
'-nothing atm

Class MediaPlayer

Private m_Self
Private QuitDlg
Private status

'Some info about the plugin
Public Property Get SHOWABLE 'Do I have a menu?
 SHOWABLE    = True
End Property
Public Property Get TITLE 'What's my name?
 TITLE       = g_(Me,"Media Player")
End Property
Public Property Get DESCRIPTION 'What's my purpose?
 DESCRIPTION = g_(Me,"Allows for controlling MS Media Player")
End Property
Public Property Get AUTHOR 'Who created me?
 AUTHOR      = "streawkceur (inspired by ultimatex) rewritten by rien-ne-va-plus"
End Property
Public Property Get URL 'Were can I be found? Where can you get more information?
 URL = "http://fma.xinium.com/"
End Property

'Who am I?
Public Property Let Self (s)
 m_Self = s
 ' Some init stuff here:
 If IsEmpty(Settings(Me, "Title")) or Settings(Me, "Title") = "" Then Settings(Me, "Title") = "Windows Media Player"
 If IsEmpty(Settings(Me, "Exe"))   or Settings(Me, "Exe")   = "" Then Settings(Me, "Exe")   = "C:\Program Files\Windows Media Player\wmplayer.exe"
End Property
Public Property Get Self
 Self = m_Self
End Property

Sub Show
 EmptyMenu.ShowMenu
 PaintDlg
 QuitDlg = False

 KeyManager.DeregisterAll Me

 KeyManager.RegisterKey KEY_JOYUP,    Self & ".Play",   STATE_PRESS  , Me
 KeyManager.RegisterKey KEY_JOYDOWN,  Self & ".Stopp",   STATE_PRESS  , Me
 KeyManager.RegisterKey KEY_JOYRIGHT, Self & ".NextTrack", STATE_PRESS  , Me
 KeyManager.RegisterKey KEY_JOYLEFT,  Self & ".PrevTrack",  STATE_PRESS  , Me 
 KeyManager.RegisterKey KEY_JOYPRESS, Self & ".Play",   STATE_PRESS  , Me

 KeyManager.RegisterKey KEY_SOFTLEFT,   Self & ".Shuffle",  STATE_PRESS  , Me 
 KeyManager.RegisterKey KEY_SOFTRIGHT,   Self & ".Fullscreen",  STATE_PRESS  , Me 
'  KeyManager.RegisterKey KEY_C,    Self & ".PrgList",  STATE_PRESS  , Me 
 KeyManager.RegisterKey KEY_BACK,   Self & ".PluginQuit",  STATE_PRESS  , Me

'  KeyManager.RegisterKey KEY_1,       Self & ".No1", STATE_PRESS  , Me
'  KeyManager.RegisterKey KEY_2,       Self & ".No2", STATE_PRESS  , Me
'  KeyManager.RegisterKey KEY_3,       Self & ".No3", STATE_PRESS  , Me
'  KeyManager.RegisterKey KEY_4,       Self & ".No4", STATE_PRESS  , Me
'  KeyManager.RegisterKey KEY_5,       Self & ".No5", STATE_PRESS  , Me
'  KeyManager.RegisterKey KEY_6,       Self & ".No6", STATE_PRESS  , Me
'  KeyManager.RegisterKey KEY_7,       Self & ".No7", STATE_PRESS  , Me
'  KeyManager.RegisterKey KEY_8,       Self & ".No8", STATE_PRESS  , Me
'  KeyManager.RegisterKey KEY_9,       Self & ".No9", STATE_PRESS  , Me
'  KeyManager.RegisterKey KEY_0,       Self & ".No0", STATE_PRESS  , Me

'  KeyManager.RegisterKey KEY_ASTERIX,     Self & ".Launch",   STATE_PRESS  , Me
'  KeyManager.RegisterKey KEY_SHARP,   "Shell.SendKeys ""%{F4}""",  STATE_PRESS  , Me 

 KeyManager.RegisterKey KEY_HOME,     Self & ".LaunchClose",   STATE_PRESS  , Me
 KeyManager.RegisterKey KEY_VOLUP,   Self & ".VolUp",   STATE_PRESS  , Me
 KeyManager.RegisterKey KEY_VOLDOWN,     Self & ".VolDown",  STATE_PRESS  , Me
 KeyManager.RegisterKey KEY_CAMERA,     Self & ".Mute",   STATE_PRESS  , Me

End Sub

Function WMPOpen
 WMPOpen = Shell.AppActivate(Settings(Me, "Title"))
End Function

Sub PaintDlg
 am.Back = Self & ".Quit"

 Dim text, text1, text2, text3

 If WMPOpen=false Then 
  text1 = g_(Me,"WMP not open!")
 Else
  text1 = g_(Me,status)
 End If

 If ActiveXManager("floAtMediaCtrl.VolumeCtrl").mute = 1 Then
   text2 = g_(Me,"Volume is muted")
 ElseIf ActiveXManager("floAtMediaCtrl.VolumeCtrl").Volume = 100 Then
  text2 = g_(Me,"Volume: 100%")
 Else
  text2 = g_(Me,"Volume: ") & ActiveXManager("floAtMediaCtrl.VolumeCtrl").Volume & "%"
 End If

 text = text1 & Space(21 - Len(text1)) & text2 & Space(21 - Len(text2)) & text3
 am.DlgInformation g_(Me,"Media Player"), text

End Sub

Sub Launch
 If Fso.FileExists(Settings(Me, "Exe")) Then
  Shell.Exec Settings(Me, "Exe")
  Util.WaitForAppLoad Settings(Me, "Title"), 10000 'Give WMP max. 10 secs to load
 Else
  Debug.ErrorMsg Self & " - Launch: File not found: " & Settings(Me, "Exe")
 End If
 Show
End Sub

Sub Play
 If WMPOpen Then Shell.SendKeys "^p"

 If status="playing" then
  status="paused"
 Else
  status="playing"
 End If
 PaintDlg 
End Sub

Sub Stopp
 If WMPOpen Then Shell.SendKeys "^s"
 status="stopped"
 PaintDlg 
End Sub

Sub Shuffle
 If WMPOpen Then Shell.SendKeys "^h"
 PaintDlg 
End Sub

Sub Fullscreen
 If WMPOpen Then Shell.SendKeys "%{ENTER}"
 PaintDlg 
End Sub

Sub PluginQuit
 QuitDlg = True
End Sub

Sub Quit
 If QuitDlg Then
  KeyManager.DeregisterAll Me
  MenuStack.Top.Quit 
 Else
  PaintDlg
 End If
End Sub

Sub PrevTrack
 If WMPOpen Then Shell.SendKeys "^b"
 PaintDlg
End Sub

Sub NextTrack
 If WMPOpen Then Shell.SendKeys "^f"
 PaintDlg 
End Sub

Sub LaunchClose
'  If WMPOpen Then 
'   Shell.SendKeys "%{F4}"
'  Else
'   If Fso.FileExists(Settings(Me, "Exe")) Then
   Shell.Exec Settings(Me, "Exe")
   Util.WaitForAppLoad Settings(Me, "Title"), 10000
'   Else
'    Debug.ErrorMsg Self & " - Launch: File not found: " & Settings(Me, "Exe")
'   End If
'  End If
 PaintDlg
End Sub

Sub VolUp
 If ActiveXManager("floAtMediaCtrl.VolumeCtrl").Volume <= 90 Then
  ActiveXManager("floAtMediaCtrl.VolumeCtrl").Volume = ActiveXManager("floAtMediaCtrl.VolumeCtrl").Volume + 10
 Else
  ActiveXManager("floAtMediaCtrl.VolumeCtrl").Volume = 100
 End If 
 PaintDlg
End Sub

Sub VolDown
 If ActiveXManager("floAtMediaCtrl.VolumeCtrl").Volume >= 10 Then
  ActiveXManager("floAtMediaCtrl.VolumeCtrl").Volume = ActiveXManager("floAtMediaCtrl.VolumeCtrl").Volume - 10
 Else
  ActiveXManager("floAtMediaCtrl.VolumeCtrl").Volume = 0
 End If 
 PaintDlg
End Sub

Sub Mute
 If ActiveXManager("floAtMediaCtrl.VolumeCtrl").mute = 0 Then
  ActiveXManager("floAtMediaCtrl.VolumeCtrl").mute = 1
 Else
  ActiveXManager("floAtMediaCtrl.VolumeCtrl").mute = 0
 End If 
 PaintDlg
End Sub

End Class
