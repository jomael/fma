object frmEditTask: TfrmEditTask
  Left = 496
  Top = 185
  BorderStyle = bsDialog
  Caption = 'Task'
  ClientHeight = 434
  ClientWidth = 385
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TTntPageControl
    Left = 8
    Top = 8
    Width = 369
    Height = 389
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTntTabSheet
      Caption = 'General'
      object Bevel1: TTntBevel
        Left = 8
        Top = 56
        Width = 341
        Height = 9
        Shape = bsTopLine
      end
      object Label2: TTntLabel
        Left = 8
        Top = 76
        Width = 39
        Height = 13
        Caption = 'Subject:'
      end
      object Bevel3: TTntBevel
        Left = 8
        Top = 168
        Width = 341
        Height = 9
        Shape = bsTopLine
      end
      object Label1: TTntLabel
        Left = 8
        Top = 220
        Width = 68
        Height = 13
        Caption = 'Completed on:'
      end
      object Image1: TTntImage
        Left = 8
        Top = 12
        Width = 32
        Height = 32
        Picture.Data = {
          055449636F6E0000010001002020000001002000A81000001600000028000000
          2000000040000000010020000000000000100000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000100000001
          0000000100000001000000010000000100000001000000010000000100000001
          0000000100000001000000010000000100000001000000010000000100000001
          0000000100000001000000010000000100000001000000010000000000000000
          0000000000000000000000000000000000000000000000010000000200000003
          0000000400000005000000050000000500000005000000050000000500000005
          0000000500000005000000050000000500000005000000050000000500000005
          0000000500000005000000050000000400000003000000020000000100000000
          000000000000000000000000000000000000000100000002000000040000002D
          0000002E0000002E0000002E0000002E0000002E0000002E0000002E0000002E
          0000002E0000002E0000002E0000002E0000002E0000002E0000002E0000002E
          0000002E0000002E0000002E0000002E0000002D000000040000000200000001
          000000000000000000000000000000000000000100000003917C6AFF78604BFF
          796047FF7B5C43FF7B5B41FF7A5A41FF795A41FF785A40FF785A41FF775A3FFF
          765A3FFF745A3DFF73573DFF70583AFF6F553AFF6A5137FF685036FF664E34FF
          644D32FF614931FF624931FF624931FF000000300000002D0000000300000001
          0000000000000000000000000000000000000001BFAD9EFFF9ECE2FFEDDCD4FF
          EBD1C5FFECCAB7FFECC9B5FFEEC1A7FFEFBB9DFFEFB99BFFF0B897FFF0B795FF
          F0B694FFF0B594FFF0B492FFF0B38EFFF0B18DFFF0B087FFF1AE86FFF2AB80FF
          F3A97AFFECA171FFDE9667FFDE9667FF664C33FF0000002E0000000400000001
          0000000000000000000000000000000000000001BFAD9EFFFDF5F0FFFEF3EDFF
          FAE8DDFFFAE7DAFFFAE4D7FFF9E3D4FFF9E1D2FFF6D8C4FFF6D5C2FFF5D3BDFF
          F6D2BCFFF5D0BAFFF4CFB7FFF4CEB4FFF4CCB2FFF4CBB0FFF4C9ADFFF4C8ABFF
          F4C7AAFFF4C6A9FFF0BC9BFFE09869FF694E35FF0000002E0000000500000001
          0000000000000000000000000000000000000001C3B1A3FFFEF9F6FFFEF7F3FF
          FDF6F0FFFEF4EEFFFDF1EBFFFDEFE8FFFCEEE4FFE2C6C5FF5453AAFF907CBAFF
          FBE4D5FFFBE3D4FFFBE1D1FFFBDFCEFFFBDCCBFFFADCC7FFFAD9C5FFFAD7C1FF
          FAD5BFFFFAD4BCFFF4C7AAFFF1A575FF684C34FF0000002E0000000500000001
          0000000000000000000000000000000000000001C3B1A3FFFFFAF9FFFEF9F6FF
          FEF8F4FFFDF6F0FFFDF4EEFFFEF2EBFFE8DEE5FF0216BAFF0000A1FF0000BBFF
          C9B7CEFFFCE5D8FFFCE3D4FFFBE1D1FFFBDFCEFFFBDDCBFFFADBC8FFFAD9C4FF
          FAD7C2FFFAD5BFFFF4C8ACFFF3A675FF684C34FF0000002E0000000500000001
          0000000000000000000000000000000000000001C3B1A3FFFEFCFAFFFEFBF8FF
          FEF9F6FFFFF7F3FFFEF6F1FFE7E1E9FF1629BAFF0005B9FF1831DCFF0013D6FF
          2B42D0FFF1DFD9FFFCE6D8FFFBE3D5FFFBE1D1FFFBDFCEFFFBDECBFFFBDBC8FF
          FADAC5FFFAD8C2FFF4C9AEFFF2A776FF684C34FF0000002E0000000500000001
          0000000000000000000000000000000000000001C3B1A3FFFFFEFCFFFEFCFBFF
          FFFBF9FFFEF9F6FFE3E0EEFF1124BBFF0000B8FF2B3EE1FF5D71FCFF3A50ECFF
          0014D3FF3F4DC5FFFCE7D9FFFCE5D8FFFCE3D5FFFCE2D2FFFBDFCEFFFBDDCBFF
          FBDBC8FFFADAC5FFF4CAB2FFF2A97BFF684C34FF0000002E0000000500000001
          0000000000000000000000000000000000000001C3B1A3FFFFFEFEFFFFFDFDFF
          FFFDFBFFE0E0F1FF1C2DC2FF0000B8FF283CE1FF6578FFFF7B8BFFFF6172F9FF
          1534E3FF000AC8FF7C73C6FFFCE8DBFFFCE6D8FFFCE3D5FFFCE2D2FFFBDFCEFF
          FBDECCFFFBDCC8FFF5CCB3FFF1AB82FF684C34FF0000002E0000000500000001
          0000000000000000000000000000000000000001CAB8AAFFFFFFFFFFFFFFFEFF
          D3D6F3FF0018C4FF0000C4FF3144E5FF687AFFFF8F99FFFFC0C5FCFF8794FBFF
          596EF7FF0B24E1FF1223CCFFD4C5D3FFFDE8DCFFFCE6D9FFFBE4D6FFFBE2D2FF
          FBDFCFFFFBDECBFFF5CEB5FFF1AD87FF694E36FF0000002E0000000500000001
          0000000000000000000000000000000000000001CCBAACFFFFFFFFFFF3F4FEFF
          0F26D1FF0009D3FF3B4EF1FF6C7CFFFF8FA1FFFFC3C7F6FFFEF8F2FFDDD8F3FF
          8690FCFF4E63FAFF011FE0FF061CC4FFF6E4DAFFFCE9DDFFFCE7D9FFFBE4D5FF
          FCE2D3FFFBE0CFFFF5D0B9FFF0AE8AFF6D5238FF0000002E0000000500000001
          0000000000000000000000000000000000000001CCBAACFFFFFFFFFFFFFFFFFF
          B2BAFDFF4A5FFBFF3B53FEFF7C8AFFFFC2C6FDFFFFFAF7FFFEF8F4FFFEF7F2FF
          C3C4F7FF6E7FFFFF4258F1FF061ED8FF5D65CDFFFCEBDEFFFCE9DCFFFCE7D9FF
          FCE4D6FFFBE2D3FFF5D1BBFFF0AF8CFF6D5238FF0000002E0000000500000001
          0000000000000000000000000000000000000001CCBAACFFFFFFFFFFFFFFFFFF
          FFFFFFFFAFB8FFFF7C8DFFFFD3D8FFFFFFFDFDFFFFFBF9FFFEFAF7FFFEF8F5FF
          FEF7F2FFE0DAF2FF7283FFFF4057F1FF0012D0FF9695CEFFFDEBE0FFFCE9DCFF
          FCE7DAFFFCE5D6FFF6D4BEFFEFAF8BFF6D5238FF0000002E0000000500000001
          0000000000000000000000000000000000000001CCBAACFFFFFFFFFFFFFFFFFF
          FFFFFFFFFEFEFFFFFBFBFFFFFFFFFFFFFFFDFDFFFFFDFCFFFEFBFAFFFFFAF7FF
          FEF9F5FFFDF6F2FFD9D4F4FF5E72FFFF2640EFFF061ECDFFAEA6D1FFFDEBE0FF
          FDE9DDFFFCE6DAFFF9DCCBFFEFB28EFF6D5238FF0000002E0000000500000001
          0000000000000000000000000000000000000001CCBAACFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFDFFFFFDFBFFFEFBFAFF
          FEFAF7FFFEF9F5FFFEF7F3FFE1DBF4FF8895FDFF1832EDFF0E25C9FFD1C7D9FF
          FCEBE0FFFCE9DDFFF9DFCEFFF0B593FF6D5238FF0000002E0000000500000001
          0000000000000000000000000000000000000001CCBAACFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFDFFFFFDFCFF
          FFFCFAFFFFFAF8FFFEF9F6FFFEF7F3FFD9D6F1FF97A6FFFF0824E2FF2738C9FF
          EFE0DEFFFDEBE1FFF9E1D2FFF1BA9AFF6D5238FF0000002E0000000500000001
          0000000000000000000000000000000000000001CCBAACFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFF
          FEFDFCFFFEFCFAFFFFFAF7FFFEF9F5FFFEF7F3FFE8E2EEFF7885FFFF011BE4FF
          4E55CAFFFCECE4FFFAE2D5FFF1BC9EFF6D5238FF0000002E0000000500000001
          0000000000000000000000000000000000000001CCBAACFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFEFFFFFDFDFFFFFBFAFFFEFAF8FFFEF9F5FFFEF7F4FFE6DDECFF677AFFFF
          1C37E6FF7176D0FFFBE9DDFFF3C9B1FF6D5238FF0000002E0000000500000001
          0000000000000000000000000000000000000001CCBAACFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFEFEFFFFFDFCFFFFFCFBFFFFFAF8FFFEF9F6FFFEF7F4FFE9E0EBFF
          7288FFFF132ADAFFA19AC6FFF3D1BDFF87725CFF0000002F0000000500000002
          0000000000000000000000000000000000000001CCBAACFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFEFFFFFDFDFFFEFCFBFFFFFAF9FFFEFAF6FFFFF8F3FF
          F4EEF1FF7681F4FF0000E5FF9685B0FFA08F7DFF000000300000000600000003
          0000000100000000000000000000000000000001CEBCADFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFFFFFDFDFFFFFCFAFFFFFAF9FFFFF9F6FF
          FEF8F4FFF3ECEFFF7580F6FF100ED9FF6C6CACFF000000300000002D00000003
          0000000100000000000000000000000000000001CFBDAFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCF4F0FFF9EAE2FFF6E1D5FFF4D9CAFF
          F2D2C0FFF2D2C0FFF2D2C0FFF2D2C0FFF2D2C0FFF2D2BFFFF1D2BDFFF4D8C6FF
          FEF9F7FFFEF8F4FFFEF7F1FF7D88F7FF0305CFFF767FF1FF0000002E00000004
          0000000100000000000000000000000000000001D0BEB0FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF5F8C9CFF558192FF4C7688FF4B6D7FFF486374FF
          486374FF486374FF486374FF486272FF485F6FFF76777DFFA59590FFF4D9C7FF
          FFFBF9FFFFFAF7FFFEF8F4FFF5E2D7FF7E87EAFF595AEBFF0000002D00000003
          0000000100000000000000000000000000000001D1BFB1FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF7499A8FFBBE5ECFF99DDE8FF7ECFDFFF75C5D5FF
          75C5D5FF75C5D5FF75C5D5FF70C1D2FF6EBACDFF6DB1C2FF6C727AFFF4D9C9FF
          FFFDFBFFFFFBF9FFFFFAF7FFF5DDCFFFBEB2A6FFA4ABECFF0000000500000002
          0000000100000000000000000000000000000001D1BFB1FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF8BAAB6FFA4C9D2FFB6ECF3FF618C9CFF74B1BEFF
          74B1BEFF74B1BEFF74B1BEFF7ECFDEFF77C8DAFF5D8D9EFF465D6DFFF9EAE1FF
          FFFEFDFFFFFDFCFFFEFBF9FFF6DECFFF917D68FF0000002D0000000400000001
          0000000000000000000000000000000000000001D2C0B2FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFDEE7EAFF759BAAFFC7EDF4FF577685FF5E808FFF
          5E808FFF5E808FFF5E808FFF6995A4FF8DD0DEFF4D6C7CFFBFB2A8FFFFFFFFFF
          FFFFFFFFFFFEFDFFFFFDFBFFF6DECFFF786047FF000000040000000200000001
          000000000000000000000000000000000000000000000001D8CBC0FFD1BFB1FF
          D1BFB1FFD0BEB0FFCFBDAFFFC8B7AAFF739AA9FFA0C1CBFFC5F0F7FFBFECF3FF
          BFECF3FFBFECF3FFBFECF3FFAEE5EFFF83B7C4FF697E86FFC0AE9EFFC2B0A1FF
          C1AFA0FFC1AFA0FFC0AE9FFFBFAD9EFF00000003000000020000000100000000
          0000000000000000000000000000000000000000000000000000000100000001
          00000001000000010000000100000001000000027CA6B5FF9DC8D3FFACD8E1FF
          AAD6DFFFA8D3DDFFAAD6DFFF8FB9C5FF66808FFF000000050000000300000002
          0000000100000001000000010000000100000001000000010000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000199B9C3FF729CABFF
          729CABFF729CABFF729CABFF86A4B1FF00000003000000020000000100000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000100000001
          0000000100000001000000010000000100000001000000010000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000F8000007F0000003E0000001E0000001E0000001E0000001E0000001
          E0000001E0000001E0000001E0000001E0000001E0000001E0000001E0000001
          E0000001E0000001E0000001E0000001E0000001E0000001E0000000E0000000
          E0000000E0000000E0000000E0000001E0000001F0000003F8000007FFF003FF
          FFF807FF}
        Transparent = True
      end
      object Label4: TTntLabel
        Left = 8
        Top = 300
        Width = 26
        Height = 13
        Caption = 'Date:'
      end
      object Label7: TTntLabel
        Left = 8
        Top = 332
        Width = 26
        Height = 13
        Caption = 'Time:'
      end
      object Label5: TTntLabel
        Left = 8
        Top = 108
        Width = 72
        Height = 13
        Caption = 'Phone number:'
      end
      object Bevel2: TTntBevel
        Left = 8
        Top = 252
        Width = 341
        Height = 9
        Shape = bsTopLine
      end
      object lblName: TTntLabel
        Left = 64
        Top = 20
        Width = 9
        Height = 13
        Caption = '   '
      end
      object txtSubject: TTntEdit
        Left = 96
        Top = 72
        Width = 253
        Height = 21
        TabOrder = 0
        OnChange = txtSubjectChange
      end
      object chbCompleted: TTntCheckBox
        Left = 8
        Top = 187
        Width = 89
        Height = 17
        Caption = 'Completed'
        TabOrder = 3
        OnClick = chbCompletedClick
      end
      object txtCompleted: TTntEdit
        Left = 96
        Top = 216
        Width = 253
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 4
      end
      object chbReminder: TTntCheckBox
        Left = 8
        Top = 268
        Width = 89
        Height = 17
        Caption = 'Reminder'
        TabOrder = 5
        OnClick = chbReminderClick
      end
      object dtpDate: TTntDateTimePicker
        Left = 96
        Top = 296
        Width = 253
        Height = 21
        Date = 38161.606045011600000000
        Time = 38161.606045011600000000
        Enabled = False
        TabOrder = 6
        OnChange = ReminderDateTimeChange
      end
      object dtpTime: TTntDateTimePicker
        Left = 96
        Top = 328
        Width = 253
        Height = 21
        Date = 38161.606045011600000000
        Time = 38161.606045011600000000
        Enabled = False
        Kind = dtkTime
        TabOrder = 7
        OnChange = ReminderDateTimeChange
      end
      object txtNumber: TTntEdit
        Left = 96
        Top = 104
        Width = 253
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 1
      end
      object Button1: TTntButton
        Left = 276
        Top = 132
        Width = 73
        Height = 25
        Caption = 'B&rowse...'
        TabOrder = 2
        OnClick = Button1Click
      end
    end
    object TabSheet5: TTntTabSheet
      Caption = 'Outlook'
      ImageIndex = 4
      object Label3: TTntLabel
        Left = 8
        Top = 76
        Width = 30
        Height = 13
        Caption = 'GUID:'
      end
      object Label25: TTntLabel
        Left = 8
        Top = 108
        Width = 34
        Height = 13
        Caption = 'File As:'
      end
      object Image2: TTntImage
        Left = 8
        Top = 12
        Width = 32
        Height = 32
        Transparent = True
      end
      object lblName2: TTntLabel
        Left = 64
        Top = 20
        Width = 9
        Height = 13
        Caption = '   '
      end
      object Bevel4: TTntBevel
        Left = 8
        Top = 56
        Width = 341
        Height = 9
        Shape = bsTopLine
      end
      object txtOutlookID: TTntEdit
        Left = 96
        Top = 72
        Width = 253
        Height = 21
        Color = clBtnFace
        MaxLength = 30
        ReadOnly = True
        TabOrder = 0
      end
      object txtFileAs: TTntEdit
        Left = 96
        Top = 104
        Width = 253
        Height = 21
        Color = clBtnFace
        MaxLength = 30
        ReadOnly = True
        TabOrder = 1
      end
    end
  end
  object OkButton: TTntButton
    Left = 232
    Top = 404
    Width = 69
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = OkButtonClick
  end
  object CancelButton: TTntButton
    Left = 308
    Top = 404
    Width = 69
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    TabOrder = 2
    OnClick = CancelButtonClick
  end
end
