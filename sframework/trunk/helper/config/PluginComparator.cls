VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "PluginComparator"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'Comparator for plugin names
Public Function Compare(ByVal a, ByVal b)
    'compare case insensitive
    a = LCase(a)
    b = LCase(b)
    If InStr(LCase(a), "pluginmanager(""") > 0 Then
        a = Replace(a, "pluginmanager(""", "")
        a = Replace(a, """)", "")
    End If
    If InStr(LCase(b), "pluginmanager(""") > 0 Then
        b = Replace(b, "pluginmanager(""", "")
        b = Replace(b, """)", "")
    End If
    If a = b Then
        Compare = 0
    ElseIf a < b Then
        Compare = -1
    Else
        Compare = 1
    End If
End Function

