'FMA Script Framework Core Plugin
'PluginManager
'Disables menu items in FMA menu - pretty the same functionality as Configurator > PluginManager > Don't load
'WARNING : FMA must be restarted for changes to take effect

'1.2: added support for ManagedMenu's UpdatePage
'1.1: fixed enabling only one disabled item
' added save (no longer waits for disconnect to save)
'1.0: basic functionality

'TODO:
'some fixing...
'changes should take effect immediately

Class PluginManager

Private m_Self
Private mainMenu
Private update

'Some info about the plugin
Public Property Get SHOWABLE 'Do I have a menu?
SHOWABLE    = True
End Property
Public Property Get TITLE 'What's my name?
 TITLE       = g_(Me,"Plugin Manager")
End Property
Public Property Get DESCRIPTION 'What's my purpose?
 DESCRIPTION = g_(Me,"Allows you to enable and disable plugins from FMA menu")
End Property
Public Property Get AUTHOR 'Who created me?
AUTHOR      = "mhr"
End Property
Public Property Get URL 'Were can I be found? Where can you get more information?
URL = "http://www.mobileagent.info/forums/"
End Property

'Who am I?
Public Property Let Self (s)
m_Self = s
Set mainMenu  = New ManagedMenu
update = False
'KeyManager.RegisterKey KEY_OPT, s & ".Show", STATE_PRESS, MenuStack
'KeyManager.RegisterKey KEY_SOFTRIGHT, s & ".Show", STATE_PRESS, MenuStack
'enabling ^^ lines will show you this menu everytime you press optionkey / right softkey
End Property
Public Property Get Self
Self = m_Self
End Property

Sub Show()
If Fso.FolderExists(ScriptFolder & "plugins") Then
  Dim menuList, bi, page
  Dim pluginFolder, pluginFiles, pluginFile, className, objectName, excludeList, exclude, match
  Set pluginFolder = Fso.GetFolder(ScriptFolder & "plugins")
  Set pluginFiles = pluginFolder.Files
  excludeList = Split(Settings(PluginManager, "Don't load"), ",", -1, vbTextCompare)
 
  Set menuList = New LinkedList
  bi = menuList.BackInserter

  For Each pluginFile in pluginFiles
  If LCase(Right(pluginFile, 4)) = ".vbs" Then 'Only load .vbs files
    match = False
    For Each exclude In excludeList
    If InStr(LCase(pluginFile.Name), LCase(Trim(exclude))) > 0 Then
      match = True
      Exit For
    End If
    Next

    className = pluginFile
    If InStr(pluginFile.Name, ".") > 0 Then className = Left(pluginFile.Name, InStr(pluginFile.Name, ".") - 1)

    If match Then
     bi.Item = Array(g_(Me,"[  ] ") & className, Self & ".Enable """ & pluginFile.Name & """, """ & pluginFile & """")
    Else
     bi.Item = Array(g_(Me,"[*] ") & className, Self & ".Disable """ & pluginFile.Name & """, """ & pluginFile & """")
    End If
  End If
  Next
Else
  Debug.ErrorMsg Self & ": Folder " & ScriptFolder & "plugin" & " doesn't exist. No plugins loaded!"
End If

page = mainMenu.CurrentPage
mainMenu.SetList menuList
mainMenu.Title = TITLE
If update Then
  mainMenu.UpdatePage(page)
  update = False
Else
  mainMenu.ShowMenu
End If
End Sub

Sub Enable( pluginFile, path )
Dim excludeList, s1, s2

excludeList = Settings(PluginManager, "Don't load")
If (Len(excludeList) - InStr(LCase(excludeList), LCase(pluginFile)) - Len(pluginFile))>=0 Then
  s1 = Left(excludeList, InStr(LCase(excludeList), LCase(pluginFile))-1)
  s2 = Right(excludeList, Len(excludeList) - Len(pluginFile) - InStr(LCase(excludeList), LCase(pluginFile)))
ElseIf (LCase(excludeList) = LCase(pluginFile)) Then
  s1 = ""
  s2 = ""
Else
  s1 = Left(excludeList, InStr(LCase(excludeList), LCase(pluginFile))-2)
  s2 = ""
End If

Settings (PluginManager, "Don't load") = s1 & s2
Settings.Save

PluginManager.LoadPlugin(Fso.GetFile(path))
PluginManager("FrameworkMainMenu").Refresh

update = True
Me.Show
End Sub

Sub Disable( pluginFile, path )
Dim excludeList, exceptions
exceptions = "FrameworkMainMenu.vbs,PluginManager.vbs"

excludeList = Settings(PluginManager, "Don't load")

If InStr(exceptions, pluginFile)>0 Then
  Util.DisplayMsgBox g_(Me,"Cannot be disabled"), 2, ""
Else
  If Len(excludeList)<=3 Then
  excludeList = pluginFile
  Else
  excludeList = excludeList & "," & pluginFile
  End If

  Settings (PluginManager, "Don't load") = excludeList
  Settings.Save

  Dim className 
  If InStr(pluginFile, ".") > 0 Then className = Left(pluginFile, InStr(pluginFile, ".") - 1)

  PluginManager.UnloadPlugin(className)
  PluginManager("FrameworkMainMenu").Refresh
End If
update = True
Me.Show
End Sub

End Class