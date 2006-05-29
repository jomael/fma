object frmKeyPad: TfrmKeyPad
  Left = 519
  Top = 259
  ActiveControl = Button22
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Phone KeyPad'
  ClientHeight = 241
  ClientWidth = 157
  Color = clBtnFace
  ParentFont = True
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefaultPosOnly
  OnCreate = FormCreate
  OnKeyDown = TntFormKeyDown
  OnKeyUp = TntFormKeyUp
  DesignSize = (
    157
    241)
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TTntSpeedButton
    Left = 136
    Top = 6
    Width = 18
    Height = 37
    Hint = 'E'
    Glyph.Data = {
      76040000424D7604000000000000360400002800000008000000080000000100
      0800000000004000000000000000000000000001000000010000000000000101
      0100020202000303030004040400050505000606060007070700080808000909
      09000A0A0A000B0B0B000C0C0C000D0D0D000E0E0E000F0F0F00101010001111
      1100121212001313130014141400151515001616160017171700181818001919
      19001A1A1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F00202020002121
      2100222222002323230024242400252525002626260027272700282828002929
      29002A2A2A002B2B2B002C2C2C002D2D2D002E2E2E002F2F2F00303030003131
      3100323232003333330034343400353535003636360037373700383838003939
      39003A3A3A003B3B3B003C3C3C003D3D3D003E3E3E003F3F3F00404040004141
      4100424242004343430044444400454545004646460047474700484848004949
      49004A4A4A004B4B4B004C4C4C004D4D4D004E4E4E004F4F4F00505050005151
      5100525252005353530054545400555555005656560057575700585858005959
      59005A5A5A005B5B5B005C5C5C005D5D5D005E5E5E005F5F5F00606060006161
      6100626262006363630064646400656565006666660067676700686868006969
      69006A6A6A006B6B6B006C6C6C006D6D6D006E6E6E006F6F6F00707070007171
      7100727272007373730074747400757575007676760077777700787878007979
      79007A7A7A007B7B7B007C7C7C007D7D7D007E7E7E007F7F7F00808080008181
      8100828282008383830084848400858585008686860087878700888888008989
      89008A8A8A008B8B8B008C8C8C008D8D8D008E8E8E008F8F8F00909090009191
      9100929292009393930094949400959595009696960097979700989898009999
      99009A9A9A009B9B9B009C9C9C009D9D9D009E9E9E009F9F9F00A0A0A000A1A1
      A100A2A2A200A3A3A300A4A4A400A5A5A500A6A6A600A7A7A700A8A8A800A9A9
      A900AAAAAA00ABABAB00ACACAC00ADADAD00AEAEAE00AFAFAF00B0B0B000B1B1
      B100B2B2B200B3B3B300B4B4B400B5B5B500B6B6B600B7B7B700B8B8B800B9B9
      B900BABABA00BBBBBB00BCBCBC00BDBDBD00BEBEBE00BFBFBF00C0C0C000C1C1
      C100C2C2C200C3C3C300C4C4C400C5C5C500C6C6C600C7C7C700C8C8C800C9C9
      C900CACACA00CBCBCB00CCCCCC00CDCDCD00CECECE00CFCFCF00D0D0D000D1D1
      D100D2D2D200D3D3D300D4D4D400D5D5D500D6D6D600D7D7D700D8D8D800D9D9
      D900DADADA00DBDBDB00DCDCDC00DDDDDD00DEDEDE00DFDFDF00E0E0E000E1E1
      E100E2E2E200E3E3E300E4E4E400E5E5E500E6E6E600E7E7E700E8E8E800E9E9
      E900EAEAEA00EBEBEB00ECECEC00EDEDED00EEEEEE00EFEFEF00F0F0F000F1F1
      F100F2F2F200F3F3F300F4F4F400F5F5F500F6F6F600F7F7F700F8F8F800F9F9
      F900FAFAFA00FBFBFB00FCFCFC00FDFDFD00FEFEFE00FFFFFF00FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF0000000000000000FF000000000000FFFFFF00000000
      FFFFFFFF00000000FFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFF}
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TTntSpeedButton
    Left = 136
    Top = 45
    Width = 18
    Height = 37
    Hint = 'D'
    Glyph.Data = {
      76040000424D7604000000000000360400002800000008000000080000000100
      0800000000004000000000000000000000000001000000010000000000000101
      0100020202000303030004040400050505000606060007070700080808000909
      09000A0A0A000B0B0B000C0C0C000D0D0D000E0E0E000F0F0F00101010001111
      1100121212001313130014141400151515001616160017171700181818001919
      19001A1A1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F00202020002121
      2100222222002323230024242400252525002626260027272700282828002929
      29002A2A2A002B2B2B002C2C2C002D2D2D002E2E2E002F2F2F00303030003131
      3100323232003333330034343400353535003636360037373700383838003939
      39003A3A3A003B3B3B003C3C3C003D3D3D003E3E3E003F3F3F00404040004141
      4100424242004343430044444400454545004646460047474700484848004949
      49004A4A4A004B4B4B004C4C4C004D4D4D004E4E4E004F4F4F00505050005151
      5100525252005353530054545400555555005656560057575700585858005959
      59005A5A5A005B5B5B005C5C5C005D5D5D005E5E5E005F5F5F00606060006161
      6100626262006363630064646400656565006666660067676700686868006969
      69006A6A6A006B6B6B006C6C6C006D6D6D006E6E6E006F6F6F00707070007171
      7100727272007373730074747400757575007676760077777700787878007979
      79007A7A7A007B7B7B007C7C7C007D7D7D007E7E7E007F7F7F00808080008181
      8100828282008383830084848400858585008686860087878700888888008989
      89008A8A8A008B8B8B008C8C8C008D8D8D008E8E8E008F8F8F00909090009191
      9100929292009393930094949400959595009696960097979700989898009999
      99009A9A9A009B9B9B009C9C9C009D9D9D009E9E9E009F9F9F00A0A0A000A1A1
      A100A2A2A200A3A3A300A4A4A400A5A5A500A6A6A600A7A7A700A8A8A800A9A9
      A900AAAAAA00ABABAB00ACACAC00ADADAD00AEAEAE00AFAFAF00B0B0B000B1B1
      B100B2B2B200B3B3B300B4B4B400B5B5B500B6B6B600B7B7B700B8B8B800B9B9
      B900BABABA00BBBBBB00BCBCBC00BDBDBD00BEBEBE00BFBFBF00C0C0C000C1C1
      C100C2C2C200C3C3C300C4C4C400C5C5C500C6C6C600C7C7C700C8C8C800C9C9
      C900CACACA00CBCBCB00CCCCCC00CDCDCD00CECECE00CFCFCF00D0D0D000D1D1
      D100D2D2D200D3D3D300D4D4D400D5D5D500D6D6D600D7D7D700D8D8D800D9D9
      D900DADADA00DBDBDB00DCDCDC00DDDDDD00DEDEDE00DFDFDF00E0E0E000E1E1
      E100E2E2E200E3E3E300E4E4E400E5E5E500E6E6E600E7E7E700E8E8E800E9E9
      E900EAEAEA00EBEBEB00ECECEC00EDEDED00EEEEEE00EFEFEF00F0F0F000F1F1
      F100F2F2F200F3F3F300F4F4F400F5F5F500F6F6F600F7F7F700F8F8F800F9F9
      F900FAFAFA00FBFBFB00FCFCFC00FDFDFD00FEFEFE00FFFFFF00FFFFFFFFFFFF
      FFFFFFFFFF0000FFFFFFFFFF00000000FFFFFFFF00000000FFFFFF0000000000
      00FF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    OnClick = SpeedButton2Click
  end
  object Button1: TTntButton
    Left = 60
    Top = 10
    Width = 15
    Height = 16
    Hint = '^'
    Cancel = True
    Caption = '^'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnMouseDown = KeyPadMouseDown
    OnMouseUp = KeyPadMouseUp
  end
  object Button2: TTntButton
    Left = 4
    Top = 177
    Width = 130
    Height = 20
    Hint = 'h'
    Cancel = True
    Caption = 'Handset button'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnMouseDown = KeyPadMouseDown
    OnMouseUp = KeyPadMouseUp
  end
  object Button3: TTntButton
    Left = 60
    Top = 43
    Width = 15
    Height = 16
    Hint = 'v'
    Cancel = True
    Caption = 'v'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnMouseDown = KeyPadMouseDown
    OnMouseUp = KeyPadMouseUp
  end
  object Button4: TTntButton
    Left = 44
    Top = 27
    Width = 15
    Height = 15
    Hint = '<'
    Cancel = True
    Caption = '<'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnMouseDown = KeyPadMouseDown
    OnMouseUp = KeyPadMouseUp
  end
  object Button5: TTntButton
    Left = 76
    Top = 27
    Width = 16
    Height = 15
    Hint = '>'
    Cancel = True
    Caption = '>'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnMouseDown = KeyPadMouseDown
    OnMouseUp = KeyPadMouseUp
  end
  object Button6: TTntButton
    Left = 8
    Top = 6
    Width = 41
    Height = 19
    Hint = 's'
    Cancel = True
    Caption = 'Yes'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnMouseDown = KeyPadMouseDown
    OnMouseUp = KeyPadMouseUp
  end
  object Button7: TTntButton
    Left = 88
    Top = 6
    Width = 41
    Height = 19
    Hint = 'e'
    Cancel = True
    Caption = 'No'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnMouseDown = KeyPadMouseDown
    OnMouseUp = KeyPadMouseUp
  end
  object Button8: TTntButton
    Left = 8
    Top = 44
    Width = 41
    Height = 19
    Hint = 'f'
    Cancel = True
    Caption = 'OPT'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnMouseDown = KeyPadMouseDown
    OnMouseUp = KeyPadMouseUp
  end
  object Button9: TTntButton
    Left = 88
    Top = 44
    Width = 41
    Height = 19
    Hint = 'c'
    Cancel = True
    Caption = 'C'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnMouseDown = KeyPadMouseDown
    OnMouseUp = KeyPadMouseUp
  end
  object GroupBox1: TTntGroupBox
    Left = 4
    Top = 63
    Width = 129
    Height = 113
    TabOrder = 9
    object Button10: TTntButton
      Left = 7
      Top = 11
      Width = 34
      Height = 24
      Hint = '1'
      Cancel = True
      Caption = '1'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnMouseDown = KeyPadMouseDown
      OnMouseUp = KeyPadMouseUp
    end
    object Button11: TTntButton
      Left = 47
      Top = 11
      Width = 34
      Height = 24
      Hint = '2'
      Cancel = True
      Caption = '2'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnMouseDown = KeyPadMouseDown
      OnMouseUp = KeyPadMouseUp
    end
    object Button12: TTntButton
      Left = 87
      Top = 11
      Width = 34
      Height = 24
      Hint = '3'
      Cancel = True
      Caption = '3'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnMouseDown = KeyPadMouseDown
      OnMouseUp = KeyPadMouseUp
    end
    object Button13: TTntButton
      Left = 7
      Top = 35
      Width = 34
      Height = 24
      Hint = '4'
      Cancel = True
      Caption = '4'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnMouseDown = KeyPadMouseDown
      OnMouseUp = KeyPadMouseUp
    end
    object Button14: TTntButton
      Left = 47
      Top = 35
      Width = 34
      Height = 24
      Hint = '5'
      Cancel = True
      Caption = '5'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnMouseDown = KeyPadMouseDown
      OnMouseUp = KeyPadMouseUp
    end
    object Button15: TTntButton
      Left = 87
      Top = 35
      Width = 34
      Height = 24
      Hint = '6'
      Cancel = True
      Caption = '6'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnMouseDown = KeyPadMouseDown
      OnMouseUp = KeyPadMouseUp
    end
    object Button16: TTntButton
      Left = 7
      Top = 59
      Width = 34
      Height = 24
      Hint = '7'
      Cancel = True
      Caption = '7'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnMouseDown = KeyPadMouseDown
      OnMouseUp = KeyPadMouseUp
    end
    object Button17: TTntButton
      Left = 47
      Top = 59
      Width = 34
      Height = 24
      Hint = '8'
      Cancel = True
      Caption = '8'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnMouseDown = KeyPadMouseDown
      OnMouseUp = KeyPadMouseUp
    end
    object Button18: TTntButton
      Left = 87
      Top = 59
      Width = 34
      Height = 24
      Hint = '9'
      Cancel = True
      Caption = '9'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      OnMouseDown = KeyPadMouseDown
      OnMouseUp = KeyPadMouseUp
    end
    object Button19: TTntButton
      Left = 7
      Top = 83
      Width = 34
      Height = 24
      Hint = '*'
      Cancel = True
      Caption = '*'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      OnMouseDown = KeyPadMouseDown
      OnMouseUp = KeyPadMouseUp
    end
    object Button20: TTntButton
      Left = 47
      Top = 83
      Width = 34
      Height = 24
      Hint = '0'
      Cancel = True
      Caption = '0'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      OnMouseDown = KeyPadMouseDown
      OnMouseUp = KeyPadMouseUp
    end
    object Button21: TTntButton
      Left = 87
      Top = 83
      Width = 34
      Height = 24
      Hint = '#'
      Cancel = True
      Caption = '#'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
      OnMouseDown = KeyPadMouseDown
      OnMouseUp = KeyPadMouseUp
    end
  end
  object Button22: TTntButton
    Left = 60
    Top = 27
    Width = 15
    Height = 15
    Hint = 's'
    Caption = '*'
    TabOrder = 2
    OnMouseDown = KeyPadMouseDown
    OnMouseUp = KeyPadMouseUp
  end
  object Button23: TTntButton
    Left = 4
    Top = 197
    Width = 130
    Height = 20
    Hint = ':C'
    Cancel = True
    Caption = 'Camera button'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnMouseDown = KeyPadMouseDown
    OnMouseUp = KeyPadMouseUp
  end
  object Button24: TTntButton
    Left = 4
    Top = 217
    Width = 130
    Height = 20
    Hint = ':O'
    Cancel = True
    Caption = 'Internet/Wap button'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
    OnMouseDown = KeyPadMouseDown
    OnMouseUp = KeyPadMouseUp
  end
  object Button25: TButton
    Left = 136
    Top = 212
    Width = 18
    Height = 25
    Hint = 'Help'
    Anchors = [akBottom]
    Caption = '?'
    TabOrder = 13
    OnClick = Button25Click
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 25500
    OnTimer = Timer1Timer
    Left = 136
    Top = 104
  end
  object FormPlacement1: TFormPlacement
    IniFileName = 'Software\floAt\MobileAgent'
    IniSection = 'KeypadWindow'
    UseRegistry = True
    Left = 136
    Top = 136
  end
end
