object frmAddUpdate: TfrmAddUpdate
  Left = 425
  Top = 264
  BorderStyle = bsDialog
  Caption = 'Add Update'
  ClientHeight = 312
  ClientWidth = 450
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 12
    Width = 61
    Height = 13
    Caption = 'From Version'
  end
  object Label2: TLabel
    Left = 140
    Top = 12
    Width = 53
    Height = 13
    Caption = 'Executable'
  end
  object Label3: TLabel
    Left = 12
    Top = 84
    Width = 51
    Height = 13
    Caption = 'To Version'
  end
  object Label4: TLabel
    Left = 140
    Top = 84
    Width = 53
    Height = 13
    Caption = 'Executable'
  end
  object Label5: TLabel
    Left = 12
    Top = 156
    Width = 70
    Height = 13
    Caption = 'Release Notes'
  end
  object edFromVer: TEdit
    Left = 12
    Top = 28
    Width = 113
    Height = 21
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 0
  end
  object edFromExe: TEdit
    Left = 140
    Top = 28
    Width = 297
    Height = 21
    TabOrder = 1
    Text = 'C:\Program Files\FMA 2\MobileAgent.exe'
  end
  object btnFrom: TButton
    Left = 360
    Top = 56
    Width = 77
    Height = 25
    Caption = 'Browse...'
    TabOrder = 2
    OnClick = btnFromClick
  end
  object edToExe: TEdit
    Left = 140
    Top = 100
    Width = 297
    Height = 21
    TabOrder = 4
    Text = 'C:\Projects\FMA\fma\trunk\MobileAgent.exe'
  end
  object btnTo: TButton
    Left = 360
    Top = 128
    Width = 77
    Height = 25
    Caption = 'Browse...'
    TabOrder = 5
    OnClick = btnToClick
  end
  object edToVer: TComboBox
    Left = 12
    Top = 100
    Width = 113
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 3
    OnChange = edToVerChange
  end
  object Button3: TButton
    Left = 268
    Top = 252
    Width = 77
    Height = 25
    Action = ActionDiffBuild
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
  object cbDoReverse: TCheckBox
    Left = 12
    Top = 128
    Width = 200
    Height = 17
    Caption = 'Also do a reverse update'
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object edHistory: TEdit
    Left = 12
    Top = 172
    Width = 425
    Height = 21
    TabOrder = 7
    Text = 'C:\Projects\cvsroot\fma\history.txt'
  end
  object btnHistory: TButton
    Left = 360
    Top = 200
    Width = 77
    Height = 25
    Caption = 'Browse...'
    TabOrder = 8
    OnClick = btnHistoryClick
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
  end
  object cbDoHistory: TCheckBox
    Left = 12
    Top = 200
    Width = 200
    Height = 17
    Caption = 'Include history notes'
    Checked = True
    State = cbChecked
    TabOrder = 9
  end
  object Button6: TButton
    Left = 12
    Top = 252
    Width = 101
    Height = 25
    Caption = '&Set Options...'
    TabOrder = 10
    OnClick = Button6Click
  end
  object ActionList1: TActionList
    Left = 260
    Top = 200
    object ActionDiffBuild: TAction
      Caption = '&Build...'
      OnExecute = ActionDiffBuildExecute
      OnUpdate = ActionDiffBuildUpdate
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Executale Files|*.exe|All Files|*.*'
    Title = 'Select...'
    Left = 292
    Top = 200
  end
end
