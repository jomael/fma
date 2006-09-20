object frmAddVersion: TfrmAddVersion
  Left = 425
  Top = 264
  BorderStyle = bsDialog
  Caption = 'Add Version'
  ClientHeight = 312
  ClientWidth = 450
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
  object btnOK: TButton
    Left = 268
    Top = 252
    Width = 77
    Height = 25
    Action = ActionVerBuild
    TabOrder = 11
  end
  object btnClose: TButton
    Left = 360
    Top = 252
    Width = 77
    Height = 25
    Cancel = True
    Caption = '&Close'
    TabOrder = 12
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
  end
  object cbUsePatchChar: TCheckBox
    Left = 12
    Top = 128
    Width = 253
    Height = 17
    Caption = 'Add patch letter to version number'
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
    TabOrder = 10
    Visible = False
    OnClick = btnOptionsClick
  end
  object cbUseAppDeployment: TCheckBox
    Left = 12
    Top = 152
    Width = 253
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
    TabOrder = 8
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
  object cbDoIncUpdates: TCheckBox
    Left = 12
    Top = 255
    Width = 253
    Height = 17
    Caption = 'Generate incremental updates now'
    Checked = True
    State = cbChecked
    TabOrder = 9
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Executale Files|*.exe|All Files|*.*'
    Title = 'Select...'
    Left = 408
    Top = 136
  end
  object ActionList1: TActionList
    Left = 376
    Top = 136
    object ActionVerBuild: TAction
      Caption = '&Next...'
      OnExecute = ActionVerBuildExecute
      OnUpdate = ActionVerBuildUpdate
    end
  end
end
