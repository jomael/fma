object frmAddVersion: TfrmAddVersion
  Left = 435
  Top = 265
  Width = 458
  Height = 343
  Caption = 'Add Version'
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 84
    Width = 75
    Height = 13
    Caption = 'Version Number'
  end
  object Label2: TLabel
    Left = 12
    Top = 12
    Width = 53
    Height = 13
    Caption = 'Executable'
  end
  object Label3: TLabel
    Left = 140
    Top = 84
    Width = 58
    Height = 13
    Caption = 'Patch Letter'
  end
  object Label4: TLabel
    Left = 268
    Top = 84
    Width = 30
    Height = 13
    Caption = 'Result'
  end
  object edVersion: TEdit
    Left = 12
    Top = 100
    Width = 113
    Height = 21
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
  object edFromExe: TEdit
    Left = 12
    Top = 28
    Width = 425
    Height = 21
    TabOrder = 0
    Text = 'C:\Projects\FMA\fma\trunk\MobileAgent.exe'
  end
  object btnFrom: TButton
    Left = 360
    Top = 56
    Width = 77
    Height = 25
    Caption = 'Browse...'
    TabOrder = 1
    OnClick = btnFromClick
  end
  object Button3: TButton
    Left = 268
    Top = 252
    Width = 77
    Height = 25
    Action = ActionVerBuild
    TabOrder = 9
  end
  object btnClose: TButton
    Left = 360
    Top = 252
    Width = 77
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    TabOrder = 10
    OnClick = btnCloseClick
  end
  object edPatchChar: TEdit
    Left = 140
    Top = 100
    Width = 97
    Height = 21
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 3
    Text = '0'
  end
  object cbUsePatchChar: TCheckBox
    Left = 12
    Top = 128
    Width = 200
    Height = 17
    Caption = 'Add patch letter to version'
    TabOrder = 6
    OnClick = cbUsePatchCharClick
  end
  object UpDown1: TUpDown
    Left = 237
    Top = 100
    Width = 15
    Height = 21
    Associate = edPatchChar
    Max = 25
    TabOrder = 4
    OnChangingEx = UpDown1ChangingEx
    OnClick = UpDown1Click
  end
  object btnOptions: TButton
    Left = 12
    Top = 252
    Width = 101
    Height = 25
    Caption = '&Set Options...'
    Enabled = False
    TabOrder = 8
    OnClick = btnOptionsClick
  end
  object cbUseAppDeployment: TCheckBox
    Left = 12
    Top = 156
    Width = 300
    Height = 17
    Caption = 'Deploy application as a full single update'
    TabOrder = 7
  end
  object edLabel: TEdit
    Left = 268
    Top = 100
    Width = 169
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 5
  end
  object GroupBox1: TGroupBox
    Left = 28
    Top = 176
    Width = 409
    Height = 61
    Caption = 'Details'
    TabOrder = 11
    object lblDetails: TLabel
      Left = 12
      Top = 20
      Width = 389
      Height = 37
      AutoSize = False
      WordWrap = True
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 293
    Width = 450
    Height = 19
    Panels = <
      item
        Width = 345
      end
      item
        Alignment = taCenter
        Width = 50
      end>
    SizeGrip = False
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Executale Files|*.exe|All Files|*.*'
    Title = 'Select...'
    Left = 188
    Top = 252
  end
  object ActionList1: TActionList
    Left = 156
    Top = 252
    object ActionVerBuild: TAction
      Caption = '&Next...'
      OnExecute = ActionVerBuildExecute
      OnUpdate = ActionVerBuildUpdate
    end
  end
end
