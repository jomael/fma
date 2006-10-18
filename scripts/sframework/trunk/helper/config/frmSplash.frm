VERSION 5.00
Begin VB.Form frmSplash 
   BorderStyle     =   0  'None
   Caption         =   "Splash"
   ClientHeight    =   1035
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   3645
   Icon            =   "frmSplash.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   69
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   243
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Timer tmrClose 
      Enabled         =   0   'False
      Interval        =   5000
      Left            =   90
      Top             =   480
   End
   Begin VB.Line Line4 
      BorderColor     =   &H80000010&
      X1              =   0
      X2              =   243
      Y1              =   68
      Y2              =   68
   End
   Begin VB.Line Line3 
      BorderColor     =   &H80000010&
      X1              =   242
      X2              =   242
      Y1              =   1
      Y2              =   69
   End
   Begin VB.Line Line2 
      BorderColor     =   &H80000014&
      X1              =   0
      X2              =   250
      Y1              =   0
      Y2              =   0
   End
   Begin VB.Line Line1 
      BorderColor     =   &H80000014&
      X1              =   0
      X2              =   0
      Y1              =   0
      Y2              =   70
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
      Left            =   165
      TabIndex        =   3
      Top             =   105
      Width           =   2460
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Loaded!"
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
      Left            =   1995
      TabIndex        =   2
      Top             =   345
      Width           =   825
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
      Left            =   360
      TabIndex        =   0
      Top             =   630
      Width           =   2235
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
      Left            =   180
      TabIndex        =   5
      Top             =   120
      Width           =   2460
   End
   Begin VB.Label Label5 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Loaded!"
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
      Left            =   2010
      TabIndex        =   4
      Top             =   360
      Width           =   825
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
      Left            =   375
      TabIndex        =   1
      Top             =   645
      Width           =   2235
   End
   Begin VB.Image imgLogo 
      Height          =   840
      Left            =   2640
      Picture         =   "frmSplash.frx":27A2
      Top             =   90
      Width           =   840
   End
End
Attribute VB_Name = "frmSplash"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
    tmrClose.Enabled = True
End Sub

Private Sub tmrClose_Timer()
    Unload Me
    End
End Sub
