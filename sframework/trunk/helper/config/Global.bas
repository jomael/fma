Attribute VB_Name = "Global"
Option Explicit

Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

Public Fso, AppPath, Util, QuickSorter, Settings, Description, SettingsPath, SettingsFilename

Public Const FILE_FOR_READING = 1
Public Const FILE_FOR_WRITING = 2
Public Const DESCRIPTION_FILE = "fma.settings.description"

Sub Init()
    Set Fso = CreateObject("Scripting.FileSystemObject")
    Set Util = New UtilClass
    Set QuickSorter = New QuickSort
    If Right(App.Path, 1) = "\" Then AppPath = App.Path Else AppPath = App.Path + "\"
    SettingsPath = AppPath & "..\..\"
    SettingsFilename = SettingsPath & "fma.settings"
    Set Settings = New Hash
    Set Description = New Hash
End Sub

Function findNodeByKey(tree As TreeView, root As Node, key As String) As Node
    Set findNodeByKey = Nothing
    Dim curNode As Node
    Set curNode = root.FirstSibling
    Do
        If LCase(curNode.key) = LCase(key) Then
            Set findNodeByKey = curNode
            Exit Do
        End If
        'curNode.Selected = True
        If curNode.Children > 0 Then
            Set findNodeByKey = findNodeByKey(tree, curNode.Child, key)
        End If
        If curNode Is root.LastSibling Then Exit Do
        Set curNode = curNode.Next
    Loop
End Function

Function findChildByKey(tree As TreeView, root As Node, ByVal key As String) As Node
    Set findChildByKey = Nothing
    If root.Children > 0 Then
        Dim curNode As Node
        Set curNode = root.Child.FirstSibling
        Do
            If LCase(curNode.key) = LCase(key) Then
                Set findChildByKey = curNode
                Exit Do
            End If
            If curNode Is curNode.LastSibling Then Exit Do
            Set curNode = curNode.Next
        Loop
    End If
End Function

Sub Main()
    If Command = "splash" Then
        Load frmSplash
        frmSplash.Show
    Else
        If Not App.PrevInstance Then
            Load frmSettings
            frmSettings.Show
        Else
            End
        End If
    End If
End Sub

Sub LoadSettings()
    If Fso.FileExists(SettingsFilename) Then
        ScriptSaveSettings 'Save before we load them
        Settings.LoadFromFile SettingsFilename
        If Fso.FileExists(AppPath & DESCRIPTION_FILE) Then Description.LoadFromFile AppPath & DESCRIPTION_FILE
        frmSettings.InitTree
    Else
        MsgBox "The settings file: " & SettingsFilename & " could not be found", vbOKOnly, "FMA Configurator"
        SettingsFilename = ""
        frmSettings.labSettingsfile.Caption = "(no file)"
    End If
End Sub

Sub SaveSettings()
    If SettingsFilename <> "" Then
        Dim save
        save = MsgBox("Do you want to save the settings?", vbYesNo, "FMA Configurator")
        If save = vbYes Then
            Settings.SaveToFile SettingsFilename
            ScriptReloadSettings
        End If
    End If
End Sub
Sub ScriptReloadSettings()
    On Error GoTo Error
    AppActivate "floAt's Mobile Agent"
    Dim fma
    Set fma = CreateObject("MobileAgent.MobileAgentApp")
    If fma.Connected = 1 Then
        fma.ScriptCall "Debug.InfoMsg ""Configurator: Forcing Settings reload"""
        fma.ScriptCall "Settings.Load()"
    End If
    Exit Sub
Error:
End Sub
Sub ScriptSaveSettings()
    On Error GoTo Error
    AppActivate "floAt's Mobile Agent"
    Dim fma
    Set fma = CreateObject("MobileAgent.MobileAgentApp")
    If fma.Connected = 1 Then
        fma.ScriptCall "Debug.InfoMsg ""Configurator: Forcing Settings save"""
        fma.ScriptCall "Settings.Save()"
        Sleep 1500
    End If
    Exit Sub
Error:
End Sub

