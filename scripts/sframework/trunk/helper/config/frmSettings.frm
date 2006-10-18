VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form frmSettings 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "FMA Scripting Framework Configuration"
   ClientHeight    =   5835
   ClientLeft      =   45
   ClientTop       =   360
   ClientWidth     =   6525
   Icon            =   "frmSettings.frx":0000
   LinkTopic       =   "Main"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   389
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   435
   StartUpPosition =   2  'CenterScreen
   Begin MSComDlg.CommonDialog CommonDialog 
      Left            =   2010
      Top             =   2850
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.CommandButton cmdLoad 
      Caption         =   "&Load..."
      Height          =   480
      Left            =   2880
      TabIndex        =   9
      Top             =   4935
      Width           =   1695
   End
   Begin VB.CommandButton cmdFindFile 
      Caption         =   "Search &Filename..."
      Height          =   480
      Left            =   2880
      TabIndex        =   8
      Top             =   1380
      Width           =   1695
   End
   Begin VB.CommandButton cmdUpdate 
      Caption         =   "&Update"
      Height          =   480
      Left            =   4680
      TabIndex        =   7
      Top             =   1380
      Width           =   1695
   End
   Begin VB.TextBox txtSetValue 
      Height          =   285
      Left            =   2880
      TabIndex        =   5
      Top             =   960
      Width           =   3480
   End
   Begin VB.CommandButton cmdSave 
      Caption         =   "&Save"
      Height          =   480
      Left            =   4680
      TabIndex        =   4
      Top             =   4935
      Width           =   1695
   End
   Begin VB.TextBox txtValue 
      Enabled         =   0   'False
      Height          =   285
      Left            =   2880
      TabIndex        =   2
      Top             =   360
      Width           =   3480
   End
   Begin MSComctlLib.TreeView SettingsTree 
      Height          =   5040
      Left            =   120
      TabIndex        =   0
      Top             =   360
      Width           =   2535
      _ExtentX        =   4471
      _ExtentY        =   8890
      _Version        =   393217
      Style           =   7
      Appearance      =   1
   End
   Begin VB.Label Label9 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Description:"
      Height          =   195
      Left            =   2880
      TabIndex        =   18
      Top             =   1935
      Width           =   840
   End
   Begin VB.Label labSettingsfile 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Height          =   195
      Left            =   990
      TabIndex        =   17
      Top             =   5580
      Width           =   45
   End
   Begin VB.Label Label8 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Settingsfile:"
      Height          =   195
      Left            =   120
      TabIndex        =   16
      Top             =   5580
      Width           =   810
   End
   Begin VB.Line Line6 
      BorderColor     =   &H80000014&
      X1              =   8
      X2              =   424
      Y1              =   367
      Y2              =   367
   End
   Begin VB.Line Line5 
      BorderColor     =   &H80000010&
      X1              =   8
      X2              =   424
      Y1              =   366
      Y2              =   366
   End
   Begin VB.Label Label6 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "by streawkceur and dVrVm"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000014&
      Height          =   210
      Left            =   3075
      TabIndex        =   14
      Top             =   4395
      Width           =   2235
   End
   Begin VB.Label Label7 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "by streawkceur and dVrVm"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000010&
      Height          =   210
      Left            =   3090
      TabIndex        =   15
      Top             =   4410
      Width           =   2235
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Configurator"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000014&
      Height          =   285
      Left            =   4365
      TabIndex        =   11
      Top             =   4110
      Width           =   1335
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "FMA Scripting Framework"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   11.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000014&
      Height          =   270
      Left            =   2880
      TabIndex        =   10
      Top             =   3870
      Width           =   2460
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Edit value:"
      Height          =   195
      Left            =   2880
      TabIndex        =   6
      Top             =   720
      Width           =   750
   End
   Begin VB.Line Line4 
      BorderColor     =   &H80000010&
      X1              =   192
      X2              =   424
      Y1              =   319
      Y2              =   319
   End
   Begin VB.Line Line3 
      BorderColor     =   &H80000014&
      X1              =   192
      X2              =   424
      Y1              =   320
      Y2              =   320
   End
   Begin VB.Label ValLabel 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Current value:"
      Height          =   195
      Left            =   2880
      TabIndex        =   3
      Top             =   120
      Width           =   990
   End
   Begin VB.Line Line2 
      BorderColor     =   &H80000010&
      X1              =   183
      X2              =   183
      Y1              =   8
      Y2              =   360
   End
   Begin VB.Line Line1 
      BorderColor     =   &H80000014&
      X1              =   184
      X2              =   184
      Y1              =   8
      Y2              =   360
   End
   Begin VB.Label STLabel 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Setting:"
      Height          =   195
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   540
   End
   Begin VB.Label Label5 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Configurator"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000010&
      Height          =   285
      Left            =   4380
      TabIndex        =   13
      Top             =   4125
      Width           =   1335
   End
   Begin VB.Label Label4 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "FMA Scripting Framework"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   11.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000010&
      Height          =   270
      Left            =   2895
      TabIndex        =   12
      Top             =   3885
      Width           =   2460
   End
   Begin VB.Image imgLogo 
      Height          =   840
      Left            =   5520
      Picture         =   "frmSettings.frx":27A2
      Top             =   3855
      Width           =   840
   End
   Begin VB.Label labDescription 
      BackStyle       =   0  'Transparent
      Caption         =   "(empty)"
      Height          =   1635
      Left            =   2880
      TabIndex        =   19
      Top             =   2175
      Width           =   3480
   End
End
Attribute VB_Name = "frmSettings"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub cmdFindFile_Click()
On Error GoTo Error
    CommonDialog.CancelError = False
    CommonDialog.InitDir = SettingsPath
    CommonDialog.Filter = "All files (*.*)|*.*"
    CommonDialog.ShowOpen
    If CommonDialog.fileName <> "" Then
        txtSetValue.text = CommonDialog.fileName
    End If
    Exit Sub
Error:
    If Err.Number <> cdlCancel Then MsgBox "An error occured", vbOKOnly, "FMA Configurator"
End Sub

Private Sub cmdLoad_Click()
On Error GoTo Error
    CommonDialog.CancelError = False
    CommonDialog.InitDir = AppPath
    CommonDialog.Filter = "FMA Settings (fma.settings)|fma.settings"
    CommonDialog.ShowOpen
    If CommonDialog.fileName <> "" Then
        SettingsFilename = CommonDialog.fileName
        LoadSettings
    End If
    Exit Sub
Error:
    If Err.Number <> cdlCancel Then MsgBox "An error occured while loading a settings file", vbOKOnly, "FMA Configurator"
End Sub

Private Sub cmdSave_Click()
    SaveSettings
End Sub

Private Sub cmdUpdate_Click()
    If SettingsTree.SelectedItem.Children = 0 Then
        txtValue.text = txtSetValue.text
        Settings.Item(SettingsTree.SelectedItem.key) = txtSetValue.text
    Else
        MsgBox "You may only set the leaved of the settings tree.", vbOKOnly, "FMA Configurator"
    End If
End Sub

Private Sub Form_Initialize()
    Init
End Sub

Sub InitTree()
    Dim keys, key, splitkeys, splitkey, comp
    Set comp = New PluginComparator
    keys = Settings.GetKeysArray
    'QuickSorter.Sort keys
    QuickSorter.ComparatorSort keys, comp
    SettingsTree.Indentation = 15
    SettingsTree.Nodes.Clear
    Dim nodeRoot As Node, tempNode As Node

    Set nodeRoot = SettingsTree.Nodes.Add(, , "\", "Settings")
    nodeRoot.Expanded = True
    For Each key In keys
        Dim keyStr As String, nodeLast As Node, keyTitle As String
        keyStr = ""
        Set nodeLast = nodeRoot
        splitkeys = Split(key, "\")
        For Each splitkey In splitkeys
            keyStr = keyStr & splitkey
            Set tempNode = findChildByKey(SettingsTree, nodeLast, keyStr)
            If tempNode Is Nothing Then 'no matching tree item yet
                keyTitle = splitkey
                If InStr(LCase(keyTitle), "pluginmanager(""") > 0 Then
                    keyTitle = Replace(keyTitle, "PluginManager(""", "")
                    keyTitle = Replace(keyTitle, """)", "")
                End If
                Set nodeLast = SettingsTree.Nodes.Add(nodeLast, tvwChild, keyStr, keyTitle)
                'nodeLast.Expanded = True
            Else
                Set nodeLast = tempNode
            End If
            keyStr = keyStr & "\"
        Next
    Next
    txtValue.text = ""
    txtSetValue.text = ""
    labSettingsfile.Caption = SettingsFilename
    labDescription.Caption = "(empty)"
End Sub

Private Sub Form_Load()
    LoadSettings
End Sub

Private Sub Form_Unload(Cancel As Integer)
    SaveSettings
End Sub

Private Sub SettingsTree_NodeClick(ByVal Node As MSComctlLib.Node)
    Dim desc
    txtValue.text = Settings.Item(SettingsTree.SelectedItem.key)
    txtSetValue.text = txtValue.text
    desc = Description.Item(SettingsTree.SelectedItem.key)
    If Trim(desc) <> "" Then
        labDescription.Caption = desc
    Else
        labDescription.Caption = "(empty)"
    End If
End Sub

Private Sub txtSetValue_KeyPress(KeyAscii As Integer)
    If KeyAscii = vbKeyReturn Then
        KeyAscii = 0
        cmdUpdate_Click
    End If
End Sub
