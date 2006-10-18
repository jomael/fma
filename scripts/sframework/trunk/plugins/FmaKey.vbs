'FMA Script Framework Plugin
'fmakey
'Lets you start FMA via # key
'Here is a plugin that allows the user to use the # key (2-sec keydown) to activate FMA. 
'Hacked from "CarpeDi3m1687 v3.5b.vbs":

Class FmaKey

Private m_Self
Private m_MenuEnter
Private m_MenuExit

'Some info about the plugin
Public Property Get SHOWABLE 'Do I have a menu?
SHOWABLE = False
End Property
Public Property Get TITLE 'What's my name?
TITLE = g_(Me,"FmaKey Plugin")
End Property
Public Property Get DESCRIPTION 'What's my purpose?
DESCRIPTION = g_(Me,"Plugin to start FMA from # key")
End Property
Public Property Get AUTHOR 'Who created me?
AUTHOR = "khsoh"
End Property
Public Property Get URL 'Were can I be found? Where can you get more information?
URL = "http://fma.sourceforge.net/"
End Property

'Who am I?
Public Property Let Self (s)
m_Self = s
m_MenuEnter = FALSE
m_MenuExit = FALSE
EventManager.RegisterEvent "Connected", m_Self & ".OnConnected", Me
EventManager.RegisterEvent "Disconnected", m_Self & ".OnDisconnected", Me
EventManager.RegisterEvent "ConnectionLost", m_Self & ".OnDisconnected", Me
End Property
Public Property Get Self
Self = m_Self
End Property

Sub OnConnected()
KeyManager.RegisterKey KEY_SHARP, Self & ".KeyDn", STATE_PRESS, Me
KeyManager.RegisterKey KEY_SHARP, Self & ".KeyUp", STATE_RELEASE, Me
End Sub
Sub OnDisconnected()
KeyManager.DeregisterAll Me
End Sub

Sub KeyDn()
'# key down - start 2 sec timer if not in any menu
m_MenuEnter = FALSE
m_MenuExit = FALSE
If MenuStack.IsEmpty Then
fma.AddTimer 2000, Self & ".Timer"
End If
End Sub

Sub KeyUp()
'# key up - stop timer and delete it
m_MenuExit = TRUE
If not m_MenuEnter Then
fma.DeleteTimer Self & ".Timer"
End If
End Sub

Sub Timer()
'timer expire - start FMA
fma.DeleteTimer Self & ".Timer"
If not m_MenuExit Then
m_MenuEnter = TRUE
EventManager.OnEvent "AMRoot", Array()
End If
End Sub
End Class