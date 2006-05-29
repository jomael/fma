object frmDebug: TfrmDebug
  Left = 353
  Top = 323
  Width = 535
  Height = 164
  BorderStyle = bsSizeToolWin
  Caption = 'Debug'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = MemoChange
  PixelsPerInch = 96
  TextHeight = 13
  object Memo: TTntMemo
    Left = 0
    Top = 0
    Width = 527
    Height = 118
    Align = alClient
    Color = cl3DLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -9
    Font.Name = 'Lucida Console'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
    OnChange = MemoChange
  end
  object FormPlacement1: TFormPlacement
    IniFileName = 'Software\floAt\MobileAgent'
    IniSection = 'DebugWindow'
    UseRegistry = True
    Left = 32
    Top = 56
  end
  object MainMenu1: TTntMainMenu
    Images = Form1.ImageList2
    Left = 68
    Top = 56
    object Log1: TTntMenuItem
      Caption = 'Log'
      object SaveAs1: TTntMenuItem
        Caption = 'Save As...'
        Enabled = False
        ImageIndex = 44
        OnClick = SaveAs1Click
      end
      object N1: TTntMenuItem
        Caption = '-'
      end
      object Clear1: TTntMenuItem
        Caption = 'Clear All'
        Enabled = False
        ImageIndex = 6
        OnClick = Clear1Click
      end
      object N2: TTntMenuItem
        Caption = '-'
      end
      object Close1: TTntMenuItem
        Caption = 'Close'
        OnClick = Close1Click
      end
    end
  end
  object SaveDialog1: TTntSaveDialog
    DefaultExt = 'log'
    Filter = 'Log Files|*.log|All Files|*.*'
    Title = 'Save Log As...'
    Left = 104
    Top = 56
  end
end
