object frmDetail: TfrmDetail
  Left = 391
  Top = 171
  BorderStyle = bsDialog
  Caption = 'Message'
  ClientHeight = 454
  ClientWidth = 385
  Color = clBtnFace
  ParentFont = True
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TTntPageControl
    Left = 8
    Top = 8
    Width = 369
    Height = 409
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTntTabSheet
      Caption = 'General'
      object lblTarget: TTntLabel
        Left = 8
        Top = 76
        Width = 26
        Height = 13
        Caption = 'From:'
        Transparent = True
      end
      object Label1: TTntLabel
        Left = 8
        Top = 108
        Width = 60
        Height = 13
        Caption = 'SMS Center:'
        Transparent = True
      end
      object lblDate: TTntLabel
        Left = 8
        Top = 140
        Width = 49
        Height = 13
        Caption = 'Received:'
        Transparent = True
      end
      object Label4: TTntLabel
        Left = 8
        Top = 172
        Width = 45
        Height = 13
        Caption = 'Contents:'
      end
      object Image1: TTntImage
        Left = 12
        Top = 16
        Width = 32
        Height = 32
        Picture.Data = {
          055449636F6E0000010001002020000001002000A81000001600000028000000
          2000000040000000010020000000000000100000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000100000001000000020000000200000002
          0000000200000002000000020000000200000002000000020000000200000002
          0000000200000002000000020000000200000002000000020000000200000002
          0000000200000002000000020000000200000002000000020000000100000001
          0000000000000000000000010000000200000004000000060000000700000007
          0000000700000007000000070000000700000007000000070000000700000007
          0000000700000007000000070000000700000007000000070000000700000007
          0000000700000007000000070000000700000007000000060000000400000003
          0000000100000000000000010000000400000041000000440000004500000045
          0000004500000045000000450000004500000045000000450000004500000045
          0000004500000045000000450000004500000045000000450000004500000045
          0000004500000045000000450000004500000045000000440000004100000004
          000000010000000000000002B88983FFB78781FFB78781FFB78781FFB78781FF
          B88580FFB8857FFFB8847EFFB7827DFFB5817BFFB18079FFAE7D76FFAD7B74FF
          AC7973FFAB7771FFAA7470FFAA726FFFA7716DFFA5706BFFA5706BFFA5706BFF
          A5706BFFA5706BFFA5706BFFA5706BFFA5706BFFA5706BFF0000004400000006
          000000020000000000000002BB8883FFFFEBC7FFFFE7BEFFFFDCAAFFFFD39DFF
          FFCA92FFFFC58AFFFFBF83FFFDB97EFFF9B37AFFF4AF77FFF0AB74FFEFA76FFF
          ECA16BFFE99C6AFFE79868FFE29466FFDE9164FFDB8D62FFD68862FFCF8562FF
          C98263FFC47F64FFC37E62FFBF7D62FFC68568FFA5706BFF0000004500000007
          000000020000000000000002BE8C86FFDDAB9BFFFEFAF7FFFFF9F3FFFFF6EDFF
          FFF3E7FFFFEFE1FFFFEBDAFFFFE8D4FFFFE5CCFFFFE1C5FFFFDCBDFFFFD9B6FF
          FFD5B0FFFFD2A9FFFFCFA2FFFFCB9DFFFFC897FFFFC692FFFFC48EFFFFC28BFF
          FFC28BFFFFC28BFFFFC28BFFDC9D79FFC0806AFFA5706BFF0000004500000007
          000000020000000000000002BD8C86FFF3DBD1FFDDAB9BFFFEFAF8FFFFFCF8FF
          FFF9F3FFFFF5EEFFFFF3E7FFFFF0E1FFFFECDBFFFFE8D4FFFFE5CCFFFFE0C5FF
          FFDCBEFFFFD8B7FFFFD5B0FFFFD2A9FFFFCEA3FFFFCB9CFFFFC897FFFFC692FF
          FFC38FFFFFC28BFFDD9F7BFFBF7E6AFFC37F66FFA5706BFF0000004500000007
          000000020000000000000002BE8E87FFFEF4EFFFF3D9CFFFDDAB9BFFFEFAF8FF
          FFFEFCFFFFFBF7FFFFF9F2FFFFF6EDFFFFF3E8FFFFEFE1FFFFECDBFFFFE8D3FF
          FFE4CCFFFFE0C5FFFFDDBEFFFFD9B7FFFFD5B0FFFFD2A9FFFFCEA3FFFFCB9DFF
          FFC997FFDEA280FFBF7F6AFFF2A664FFC37F65FFA5706BFF0000004500000007
          000000020000000000000002BD9089FFFEF7F4FFFEF4EEFFF1D6CBFFDDAB9BFF
          FEFAF8FFFFFFFFFFFFFEFCFFFFFBF8FFFFF9F2FFFFF6EDFFFFF2E7FFFFEFE2FF
          FFECDBFFFFE8D4FFFFE5CCFFFFE0C5FFFFDDBEFFFFD9B7FFFFD6B0FFFFD2A8FF
          DEA687FFBF806BFFF5B477FFFAB774FFC48166FFA5706BFF0000004500000007
          000000020000000000000002BF918CFFFEFAF7FFFEF7F3FFFEF3EEFFF1D4C9FF
          DEAC9DFFFDF9F6FFFFFFFFFFFFFFFFFFFFFDFCFFFFFBF8FFFFF9F3FFFFF6EDFF
          FFF2E7FFFFEFE1FFFFEBDAFFFFE8D3FFFFE4CCFFFFE0C5FFFFDDBDFFDFAD92FF
          BE806CFFF6C791FFFDCC90FFFCC586FFC8856AFFA5706BFF0000004500000007
          000000020000000000000002C1968EFFFFFCFBFFFEFAF7FFFEF6F2FFFEF3EDFF
          F0D4C9FFDEAC9CFFFDF8F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFBFFFFFBF8FF
          FFF9F3FFFFF6EEFFFFF3E7FFFFEFE1FFFFECDBFFFFE8D4FFE0B49EFFBE806DFF
          F7D6A5FFFEDEA9FFFED9A1FFFDD398FFCB8D70FFA5706BFF0000004500000007
          000000020000000000000002C39A92FFFFFEFEFFFEFCFBFFFEF9F7FFFEF6F2FF
          F4DED4FFE1B3A4FFDEAC9CFFFDF6F3FFFFFEFDFFFFFEFFFFFFFFFEFFFFFCFBFF
          FFFAF8FFFFF8F6FFFFF7EFFFFFF5EBFFFFF2E7FFE2BDABFFBB7C6BFFD6A289FF
          FFE5B5FFFFEAC4FFFFE3B0FFFEDEA8FFD19679FFA5706BFF0000004500000007
          000000020000000000000002C59994FFFFFFFFFFFFFEFDFFFFFBFAFFF5E4DCFF
          DFB1A1FFF9F5F3FFF4E2DDFFDEAC9CFFE9C7B9FFEFD5CBFFF3DED2FFF5E1D8FF
          F6E1D5FFF5DDCEFFF2D5C4FFEBC6B3FFDEAB96FFBE8171FFF3EAE6FFF7EFEBFF
          DCAE96FFFFEAC5FFFFEFD0FFFFE4B3FFD8A284FFA5706BFF0000004500000007
          000000020000000000000002C49994FFFFFFFFFFFFFFFFFFF6E9E4FFDFB1A2FF
          FCF6F6FFFAF6F1FFF5EEEAFFF0E5DEFFE2B9ADFFD8A494FFD39888FFD09281FF
          D09282FFD09282FFD19586FFDAA999FFE4C1B7FFEFDDD9FFF2E7E3FFF5ECE8FF
          FBEFECFFDFAF90FFFFECC9FFFFEFD2FFDFB191FFA5706BFF0000004500000007
          000000020000000000000002C49A93FFFFFFFFFFF8EDE9FFE0B1A2FFFAEFEBFF
          F9F7F4FFF9F5F4FFF5EEE9FFF2EBE6FFF0E8E5FFECE4E0FFE8DBD6FFE5D4CFFF
          E3D2CDFFE5D5D0FFE9DAD6FFEBE0DAFFEDE4E0FFF1E5E3FFF4EAE9FFF4EEE9FF
          F4EBE7FFF3E6DEFFDCB095FFFFEAC4FFE6BE9DFFA5716CFF0000004500000007
          000000020000000000000002C49A93FFF8EDE9FFE0B1A2FFF7EEEAFFFAFCF9FF
          FAF9F7FFF8F5F2FFF5F0E8FFF4EEE6FFF1E9E4FFF1E9E5FFF1E9E5FFF1E7E4FF
          F1E8E4FFF0E8E2FFF1E9E5FFF2EBE6FFF3EFE9FFF4F0EBFFF3F0E8FFF2ECE7FF
          F2EBE4FFECEAE8FFCCE5F3FFA3B2B3FFEFCDABFFA6726DFF0000004500000007
          000000020000000000000002C79C94FFE0B3A4FF88D9FBFFEBF7FDFFF8FBFBFF
          FBFAFAFFFBF8F6FFF9F6F1FFF8F0ECFFF5EFEAFFF5ECE8FFF3EBE7FFF3EBE7FF
          F3EAE7FFF3EAE8FFF3ECE8FFF4EDEAFFF5F0EBFFF4EFEBFFF3EEE9FFF5F1EBFF
          F5F1ECFFE2EAEEFFC4E4F6FF29A8EFFFE3B191FFA6716CFF0000004500000007
          000000020000000000000002CDA197FFA9CEDDFF89D9FBFFCEF0FDFFECF9FFFF
          F5FAFDFFFDFDFFFFFFFFFFFFFFFFFFFFFEFFFEFFFEFDFDFFFFFDFDFFFEFEFDFF
          FEFDFCFFFEFDFAFFFEFDF9FFFCFBF7FFFAFAF4FFF9F8F4FFF9F7F3FFF6F5F3FF
          F2F4F3FFDAE8EFFFAADCF7FF20A8F0FF19A7F4FFA5706BFF0000004500000007
          000000020000000000000002C79C95FFA6E6FCFF9EE3FBFFBAEAFDFFD4F2FEFF
          E5F6FEFFEFFAFFFFF7FBFEFFFCFDFEFFFDFCFFFFFFFEFFFFFEFFFFFFFEFFFFFF
          FEFEFEFFFDFEFEFFFBFEFEFFF9FCFEFFF4F9FDFFF1F7FDFFEBF3F8FFE3EEF5FF
          C6E4F4FF85CFF5FF47B8F7FF1AA7F4FF19A7F4FFA5706BFF0000004500000006
          000000020000000000000001C79C95FFB8EFFDFFB0EBFDFFB9EDFDFFB4EBFCFF
          9DE2FBFF8CDBFBFF83D7FAFF7AD2F9FF70CEF9FF67CAF9FF5DC6F8FF53C2F7FF
          4BBEF7FF42BAF7FF3AB6F6FF32B3F6FF2BAFF5FF25ACF5FF20AAF4FF1BA8F4FF
          19A7F4FF19A7F4FF25AAF4FF19A7F4FF19A7F4FFA7736EFF0000004300000005
          000000010000000000000001D1C8C6FFCBC6C4FFC0F0FBFFB9F0FDFFB3ECFDFF
          ABE9FDFFA1E4FCFF98E0FCFF8FDCFBFF85D8FBFF7CD4FAFF73D0F9FF69CBF9FF
          60C7F8FF56C3F8FF4DBFF7FF45BBF6FF3CB7F6FF34B4F5FF2DB0F5FF27ADF4FF
          21ABF5FF1DA9F5FF19A7F4FF21A4ECFF7C8295FFC4A8A5FF0000000600000003
          00000001000000000000000000000001D7C1BCFFCDB4AEFFC9E9EEFFC2F3FEFF
          BBF0FEFFB4EDFDFFACEAFDFFA3E5FCFF9BE1FCFF91DEFBFF88D9FAFF7ED5FAFF
          75D1F9FF6BCCF9FF61C8F9FF59C3F7FF50BFF8FF47BBF7FF3FB8F6FF36B4F6FF
          30B1F5FF28AEF4FF3F9ED7FF98787CFFC5A8A5FF000000050000000300000001
          000000000000000000000000000000000000000100000002CDACA5FFCED8D8FF
          CAF6FFFFC4F4FEFFBDF1FEFFB5EDFDFFAEEAFDFFA6E6FCFF9DE3FCFF93DEFBFF
          8ADBFBFF80D6FAFF77D2F9FF6ECDF9FF64C8F9FF5BC5F8FF51C1F7FF49BDF7FF
          41B9F6FF6595B9FFA57875FF0000000700000004000000020000000100000000
          00000000000000000000000000000000000000000000000000000001D0B4ADFF
          CFC6C3FFCFF7FCFFCAF7FEFFC5F5FEFFBEF2FEFFB7EEFEFFAFEBFCFFA8E8FCFF
          9FE3FCFF96DFFBFF8DDBFAFF83D7FBFF79D3FAFF70CEF9FF67CAF9FF61C1F0FF
          878898FFB18987FF000000060000000300000001000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000001
          DBC7C2FFCEB4AEFFD2EDEFFFD1FAFFFFCCF8FEFFC6F6FEFFC0F2FEFFBAF0FDFF
          B1ECFDFFAAE8FCFFA1E4FCFF98E1FBFF8EDCFBFF86D8FAFF83BCDAFF9E7C7DFF
          C2A29FFF00000005000000030000000100000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000100000002CDADA6FFD1D9D8FFD3FBFFFFD2FAFFFFCEF8FFFFC8F6FEFF
          C2F4FEFFBCF0FEFFB3EDFDFFACE9FDFFA3E5FDFF9CB3C1FFA57A77FF00000007
          0000000400000002000000010000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000001D2B4AEFFCFC2BEFFD3F6FAFFD3FBFFFFD3FBFFFF
          CFF9FEFFC9F7FEFFC3F4FEFFBCEAF6FFA8989AFFB08885FF0000000600000003
          0000000100000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000001E1C8C3FFCEB0AAFFD2E8EAFFD3FBFFFF
          D3FBFFFFD3FBFFFFC9E2E7FFAA8380FFC2A29FFF000000050000000300000001
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000100000002CDACA4FFD0D3D1FF
          D3FBFFFFC1C3C4FFA97C77FF0000000700000004000000020000000100000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000001D7BBB6FF
          CDA69EFFB68F8CFF000000050000000300000001000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000001
          0000000100000002000000010000000100000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000FFFFFFFFC00000018000000080000000800000008000000080000000
          8000000080000000800000008000000080000000800000008000000080000000
          80000000800000008000000080000000800000008000000080000000C0000001
          E0000003F800000FFC00001FFE00003FFF8000FFFFC001FFFFE003FFFFF80FFF
          FFFC1FFF}
        Transparent = True
      end
      object Bevel2: TTntBevel
        Left = 8
        Top = 56
        Width = 341
        Height = 9
        Shape = bsTopLine
      end
      object lblName: TTntLabel
        Left = 64
        Top = 20
        Width = 15
        Height = 13
        Caption = '     '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object TntLabel1: TTntLabel
        Left = 8
        Top = 352
        Width = 44
        Height = 13
        Caption = 'Location:'
        Transparent = True
      end
      object TntLabel2: TTntLabel
        Left = 8
        Top = 320
        Width = 55
        Height = 13
        Caption = 'Replyed At:'
        Transparent = True
      end
      object edFrom: TTntEdit
        Left = 92
        Top = 72
        Width = 257
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 0
      end
      object edSMSC: TTntEdit
        Left = 92
        Top = 104
        Width = 257
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 1
      end
      object memoText: TTntMemo
        Left = 92
        Top = 168
        Width = 257
        Height = 137
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 5
      end
      object edLocation: TTntEdit
        Left = 92
        Top = 348
        Width = 257
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 7
      end
      object TimeStampDate: TTntDateTimePicker
        Left = 92
        Top = 136
        Width = 101
        Height = 21
        Date = 39077.016685648130000000
        Time = 39077.016685648130000000
        Color = clBtnFace
        DateMode = dmUpDown
        TabOrder = 2
        OnChange = TimeStampChange
        OnKeyPress = TimeStampDateKeyPress
      end
      object TimeStampTime: TTntDateTimePicker
        Left = 200
        Top = 136
        Width = 73
        Height = 21
        Date = 39077.016910983800000000
        Time = 39077.016910983800000000
        Color = clBtnFace
        DateMode = dmUpDown
        Kind = dtkTime
        TabOrder = 3
        OnChange = TimeStampChange
        OnKeyPress = TimeStampDateKeyPress
      end
      object ChangeButton: TTntButton
        Left = 280
        Top = 136
        Width = 69
        Height = 25
        Caption = 'C&hange'
        TabOrder = 4
        OnClick = ChangeButtonClick
      end
      object edReplyDate: TTntEdit
        Left = 92
        Top = 316
        Width = 257
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 6
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Technical Data'
      ImageIndex = 1
      object lblName2: TTntLabel
        Left = 64
        Top = 20
        Width = 15
        Height = 13
        Caption = '     '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Image2: TTntImage
        Left = 12
        Top = 16
        Width = 32
        Height = 32
        Transparent = True
      end
      object Bevel3: TTntBevel
        Left = 8
        Top = 56
        Width = 341
        Height = 9
        Shape = bsTopLine
      end
      object Label10: TTntLabel
        Left = 8
        Top = 76
        Width = 57
        Height = 13
        Caption = 'SMS Count:'
        Transparent = True
      end
      object Label6: TTntLabel
        Left = 8
        Top = 108
        Width = 56
        Height = 13
        Caption = 'UDHI Data:'
        Transparent = True
      end
      object Label7: TTntLabel
        Left = 8
        Top = 140
        Width = 53
        Height = 13
        Caption = 'Reference:'
        Transparent = True
      end
      object Label5: TTntLabel
        Left = 8
        Top = 172
        Width = 52
        Height = 13
        Caption = 'PDU Data:'
      end
      object edLongCount: TTntEdit
        Left = 92
        Top = 72
        Width = 257
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 0
      end
      object edUDHI: TTntEdit
        Left = 92
        Top = 104
        Width = 257
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 1
      end
      object ebRef: TTntEdit
        Left = 92
        Top = 136
        Width = 257
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 2
      end
      object memoPDU: TTntMemo
        Left = 92
        Top = 168
        Width = 257
        Height = 201
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Lucida Console'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 3
      end
    end
    object TntTabSheet1: TTntTabSheet
      Caption = 'Delivery Report'
      object lblName3: TTntLabel
        Left = 64
        Top = 20
        Width = 15
        Height = 13
        Caption = '     '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Image3: TTntImage
        Left = 12
        Top = 16
        Width = 32
        Height = 32
        Transparent = True
      end
      object TntBevel1: TTntBevel
        Left = 8
        Top = 56
        Width = 341
        Height = 9
        Shape = bsTopLine
      end
      object TntLabel3: TTntLabel
        Left = 8
        Top = 172
        Width = 52
        Height = 13
        Caption = 'PDU Data:'
      end
      object TntLabel4: TTntLabel
        Left = 8
        Top = 76
        Width = 33
        Height = 13
        Caption = 'Status:'
        Transparent = True
      end
      object TntLabel5: TTntLabel
        Left = 8
        Top = 108
        Width = 26
        Height = 13
        Caption = 'Date:'
        Transparent = True
      end
      object TntLabel6: TTntLabel
        Left = 8
        Top = 140
        Width = 40
        Height = 13
        Caption = 'Reason:'
        Transparent = True
      end
      object mmoDRPDU: TTntMemo
        Left = 92
        Top = 168
        Width = 257
        Height = 201
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Lucida Console'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object edDRStatus: TTntEdit
        Left = 92
        Top = 72
        Width = 257
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 1
      end
      object edDRRepDate: TTntEdit
        Left = 92
        Top = 104
        Width = 257
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 2
      end
      object edDRInfo: TTntEdit
        Left = 92
        Top = 136
        Width = 257
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 3
      end
    end
    object TntTabSheet2: TTntTabSheet
      Caption = 'Business Card'
      object Image4: TTntImage
        Left = 12
        Top = 16
        Width = 32
        Height = 32
        Transparent = True
      end
      object lblName4: TTntLabel
        Left = 64
        Top = 20
        Width = 15
        Height = 13
        Caption = '     '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object TntBevel2: TTntBevel
        Left = 8
        Top = 56
        Width = 341
        Height = 9
        Shape = bsTopLine
      end
      object TntLabel8: TTntLabel
        Left = 8
        Top = 108
        Width = 341
        Height = 45
        AutoSize = False
        Caption = 
          'This text message contains embedded Business Card which could be' +
          ' imported or saved as a vCard file on your computer.'
        Transparent = True
        WordWrap = True
      end
      object TntLabel7: TTntLabel
        Left = 8
        Top = 76
        Width = 71
        Height = 13
        Caption = 'Contact Name:'
        Transparent = True
      end
      object lblContact: TTntLabel
        Left = 94
        Top = 76
        Width = 255
        Height = 13
        AutoSize = False
        Caption = '     '
        Transparent = True
      end
      object ImportCardButton: TTntButton
        Left = 132
        Top = 160
        Width = 105
        Height = 25
        Caption = '&Import Contact...'
        TabOrder = 0
        OnClick = ImportCardButtonClick
      end
      object SaveCardButton: TTntButton
        Left = 244
        Top = 160
        Width = 105
        Height = 25
        Caption = '&Save as vCard...'
        TabOrder = 1
        OnClick = SaveVCardButtonClick
      end
    end
  end
  object OkButton: TTntButton
    Left = 156
    Top = 424
    Width = 69
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = OkButtonClick
  end
  object CancelButton: TTntButton
    Left = 232
    Top = 424
    Width = 69
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    TabOrder = 2
    OnClick = CancelButtonClick
  end
  object ApplyButton: TTntButton
    Left = 308
    Top = 424
    Width = 69
    Height = 25
    Caption = '&Apply'
    Enabled = False
    TabOrder = 3
    OnClick = ApplyButtonClick
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'vcf'
    Filter = 'vCard files (*.vcf)'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Save vCard As...'
    Left = 8
    Top = 420
  end
end
