inherited frmCharMessage: TfrmCharMessage
  Left = 539
  Top = 354
  ActiveControl = Memo
  Caption = 'Chat Message'
  OldCreateOrder = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited CoolBar1: TCoolBar
    Height = 4
    AutoSize = False
    Visible = False
    inherited ToolBar2: TToolBar [0]
    end
    inherited ToolBar1: TToolBar [1]
    end
  end
  inherited Memo: TTntMemo
    Top = 180
    Width = 303
    Height = 46
    Align = alNone
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 4
  end
  inherited WarningPanel: TTntPanel
    Top = 27
    TabOrder = 2
  end
  object SendButton: TTntButton [4]
    Left = 304
    Top = 180
    Width = 49
    Height = 46
    Anchors = [akRight, akBottom]
    Caption = 'Sen&d'
    Enabled = False
    TabOrder = 5
    OnClick = SendClick
  end
  object TalkToPanel: TTntPanel [5]
    Left = 0
    Top = 4
    Width = 356
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      356
      23)
    object Label1: TTntLabel
      Left = 4
      Top = 5
      Width = 61
      Height = 13
      Caption = 'Chatting with'
    end
    object lblName: TTntLabel
      Left = 76
      Top = 5
      Width = 38
      Height = 13
      Caption = '<name>'
    end
    object sbLong: TTntSpeedButton
      Left = 329
      Top = 1
      Width = 22
      Height = 21
      Hint = 'Long SMS Mode'
      AllowAllUp = True
      Anchors = [akTop, akRight]
      GroupIndex = 1
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000D4D4FDD4D4FD
        D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4
        FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4
        D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FD
        D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4
        FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4
        D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FD808080
        5454544D4C4C4544443D3C3D353535D4D4FDD4D4FD1E1D1E1817161210100C0B
        0B080606808080D4D4FD80808060605FF6E3CDF4E0C7F1DCC1EED7B9EAD4B233
        32332B2A2AE0C69CDDC195DBBC8ED8B987D5B5820706058080806A6969FAE7D3
        F8E4CE5757575050504848484040413838383130302928292121211A191A1413
        13D6B783D4B37E0504056D6C6DF9E9D4000000D4D4FD565555F0DBBFEDD6B8EA
        D2B1E6CDA9E3C9A1E0C49A1F1F1FD4D4FD000000D5B4800807086F6F70FAEAD6
        F9E7D26061605B5A5A5353534C4B4C4444443C3C3C3434342D2C2C2524241E1D
        1DD8B988D6B6820B0B0A8080806E6F6EFAE8D3F8E5CFF5E1CAF2DEC4EFD9BD4A
        494A424242E5CCA7E3C89FDFC398DCBF91D9BA8A161514808080D4D4FD808080
        6E6E6E6869696364645D5D5E565657D4D4FDD4D4FD40403F383737302F2F2827
        28212020808080D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4
        D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FD
        D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4
        FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4
        D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FD
        D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4
        FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4
        D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FD}
      Layout = blGlyphTop
      Margin = 1
      OnClick = LongClick
    end
  end
  object Chat: TTntRichEdit [6]
    Left = 0
    Top = 48
    Width = 356
    Height = 129
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    PopupMenu = PopupMenu1
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 3
  end
  inherited FormPlacement1: TFormPlacement
    IniSection = 'ChatWindow'
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 236
    Top = 128
  end
  object PopupMenu1: TTntPopupMenu
    Left = 268
    Top = 128
    object Copy1: TTntMenuItem
    end
  end
end
