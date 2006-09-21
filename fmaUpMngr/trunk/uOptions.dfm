object frmOptions: TfrmOptions
  Left = 558
  Top = 306
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 337
  ClientWidth = 282
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 12
    Top = 8
    Width = 257
    Height = 89
    Caption = 'Recent Scripts'
    TabOrder = 0
    object cbReloadRecent: TCheckBox
      Left = 16
      Top = 24
      Width = 221
      Height = 17
      Caption = 'Load last open Script on Startup'
      TabOrder = 0
    end
    object Button2: TButton
      Left = 140
      Top = 48
      Width = 101
      Height = 25
      Caption = 'Clear History'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object Button1: TButton
    Left = 192
    Top = 300
    Width = 77
    Height = 25
    Cancel = True
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object GroupBox2: TGroupBox
    Left = 12
    Top = 104
    Width = 257
    Height = 181
    Caption = 'Update Engine'
    TabOrder = 2
    object Label1: TLabel
      Left = 16
      Top = 26
      Width = 96
      Height = 13
      Caption = 'Main Section Name:'
    end
    object Label2: TLabel
      Left = 16
      Top = 66
      Width = 72
      Height = 13
      Caption = 'Patch Engines:'
    end
    object Label3: TLabel
      Left = 16
      Top = 106
      Width = 67
      Height = 13
      Caption = 'Update Prefix:'
    end
    object Label4: TLabel
      Left = 16
      Top = 142
      Width = 80
      Height = 13
      Caption = 'Default Mirror ID:'
    end
    object Edit1: TEdit
      Left = 136
      Top = 24
      Width = 105
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
      Text = 'main'
    end
    object Edit2: TEdit
      Left = 136
      Top = 64
      Width = 105
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
      Text = 'bin+null'
    end
    object edFullUpdateName: TEdit
      Left = 136
      Top = 104
      Width = 105
      Height = 21
      TabOrder = 2
      Text = 'MobileAgent'
    end
    object Edit4: TEdit
      Left = 136
      Top = 140
      Width = 105
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 3
      Text = 'default'
    end
  end
end
