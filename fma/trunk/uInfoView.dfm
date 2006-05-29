object frmInfoView: TfrmInfoView
  Left = 0
  Top = 0
  Width = 770
  Height = 571
  Color = clWhite
  ParentColor = False
  TabOrder = 0
  Visible = False
  OnResize = FrameResize
  object Splitter1: TTntSplitter
    Left = 413
    Top = 72
    Width = 6
    Height = 499
    ResizeStyle = rsUpdate
    OnPaint = SplitterPaint
  end
  object Panel1: TTntPanel
    Left = 0
    Top = 72
    Width = 413
    Height = 499
    Align = alLeft
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Splitter2: TTntSplitter
      Left = 0
      Top = 97
      Width = 413
      Height = 6
      Cursor = crVSplit
      Align = alTop
      ResizeStyle = rsUpdate
      OnPaint = SplitterPaint
    end
    object Splitter3: TTntSplitter
      Left = 0
      Top = 236
      Width = 413
      Height = 6
      Cursor = crVSplit
      Align = alBottom
      ResizeStyle = rsUpdate
      OnPaint = SplitterPaint
    end
    object InboxPanel: TTntPanel
      Left = 0
      Top = 0
      Width = 413
      Height = 97
      Align = alTop
      BevelOuter = bvNone
      Constraints.MinHeight = 97
      ParentColor = True
      TabOrder = 0
      DesignSize = (
        413
        97)
      object Label10: TTntLabel
        Left = 8
        Top = 8
        Width = 78
        Height = 34
        Caption = 'Inbox'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 14346715
        Font.Height = -29
        Font.Name = 'Book Antiqua'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label17: TTntLabel
        Left = 32
        Top = 18
        Width = 41
        Height = 19
        Caption = 'Inbox'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Bevel2: TTntBevel
        Left = 8
        Top = 40
        Width = 397
        Height = 9
        Anchors = [akLeft, akTop, akRight]
        Shape = bsTopLine
      end
      object Image3: TTntImage
        Left = 8
        Top = 52
        Width = 16
        Height = 16
        AutoSize = True
        Picture.Data = {
          07544269746D617036030000424D360300000000000036000000280000001000
          000010000000010018000000000000030000120B0000120B0000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDE3E3E3B0AEAE8A8585CCCBCB
          F6F6F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7DCDB
          DBACABAB959594B1AAAA645A5A4743436A6565AAA8A8E9E8E8FAFAFAFFFFFFFF
          FFFFFFFFFFF4F4F4CFCFCFAFAFAFAFAEAEA5A4A49192919391914B4848565454
          6F6D6D726E6E686161928C8CD3D2D2FBFBFBE8E8E89F9E9EB0AFAFA7A6A69E9E
          9EA6A6A6BDBEBDB7B5B57574746A67677574747E7F7F353737685B5BBB9C9CBC
          B8B8C8C8C89B9B9BAAAAAAB6B7B6C9CAC9D9D8D8DDDDDDD0D0D0CECECEBBBABA
          9A9999807D7D4D4C4C5D5555C4A1A1A9A2A2CFCFCFC1C2C2D1D1D1D8D7D7EBEB
          EBE0DFDFE0DFDFF4F3F4F4F3F4DEDDDDE4E3E3EBE9E9D6C9C9A39898857A7AC3
          C1C1F4F4F4E8E7E6D8D7D7979797929191C6C6C6FBF9FBECEBEBCAC9CAE4E1E3
          E9EAE9F5F5F5DCDADADEDCDCEEEFEFFCFCFCFFFFFFFFFFFFFCFBFBF6F6F6DDDC
          DCDAD8DAD6D3D54D9E5623762CA4A0A2F0EEF0F5F5F5FEFEFEFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFC60A96804A01608A41A479350
          EFEEEEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFA
          FA7FBD8817AD3320B53B21B53C17AE33479151E5E4E4FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFAFBFA7DBD8821BA4B2EC65A2FC45A2FC45A2FC75B
          23BD4D4B9657E4E3E4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE7CBF8819BC
          4934D1673AD16C3AD16B3AD16B3AD16C33D1661DBF4C41914EF5F4F5FFFFFFFF
          FFFFFFFFFFFFFFFFFDFEFD8EC7967EC38A4DB86545E07949E07B4AE27C3FD46E
          4DA65C80C78D8CC594FAFAF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF8BD39C4CEE8258F18B5AF58D44DD739CB89FFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7EC88D38D26244D66C45D86E31C458
          A8C6ACFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFEDF4EDCCE2CECEE3D0CEE3D0CEE3D0F9FBF9FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF}
        Transparent = True
      end
      object Label11: TTntLabel
        Left = 32
        Top = 52
        Width = 100
        Height = 13
        Caption = 'New Text Messages:'
      end
      object wInboxNew: TTntLabel
        Left = 140
        Top = 52
        Width = 253
        Height = 13
        Alignment = taRightJustify
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = 'none'
      end
      object linkGetMessages: TTntLabel
        Left = 112
        Top = 72
        Width = 75
        Height = 13
        Cursor = crHandPoint
        Caption = 'Sync Messages'
        Transparent = True
        OnClick = linkGetMessagesClick
      end
      object linkJumpInbox: TTntLabel
        Left = 32
        Top = 72
        Width = 26
        Height = 13
        Cursor = crHandPoint
        Caption = 'Inbox'
        Transparent = True
        OnClick = linkJumpMsgFolderClick
      end
      object linkJumpArchive: TTntLabel
        Left = 68
        Top = 72
        Width = 36
        Height = 13
        Cursor = crHandPoint
        Caption = 'Archive'
        Transparent = True
        OnClick = linkJumpMsgFolderClick
      end
      object linkShowNewMessages: TTntLabel
        Left = 365
        Top = 72
        Width = 27
        Height = 13
        Cursor = crHandPoint
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Show'
        Transparent = True
        OnClick = linkJumpMsgFolderClick
      end
      object Image10: TTntImage
        Left = 389
        Top = 12
        Width = 16
        Height = 16
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Picture.Data = {
          07544269746D617036030000424D360300000000000036000000280000001000
          000010000000010018000000000000030000120B0000120B0000000000000000
          0000D4D4FDD4D4FDD4D4FDD4D4FDB7CFC4BDD1C5C6D8CECBDBD3CBDBD3C6D8CE
          BDD2C7B8D0C5D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDBDD8CEB8CEC1D4E2
          DBE9F1EEF0F6F4F0F6F5EFF5F3EDF3F1E4EDE9D0DFD7BBCFC3BBD5CCD4D4FDD4
          D4FDD4D4FDBFD9D1BACFC3E0EAE5F7FAFAF6F9F8F7FAFAF7FAFAF6F9F8F4F8F7
          F1F6F5EEF4F2D8E5DFBBD0C5BAD7CED4D4FDD4D4FDB9CDC1E3ECE7FBFCFCFBFC
          FCFBFCFCFDFEFEFDFEFEFDFEFEFBFCFCF8FBFAF3F8F7EFF5F3D8E4DEB9D0C3D4
          D4FDBED6CCD3E1D9FDFEFDFEFFFE1C674B1C674BFFFFFFFFFFFFFFFFFF1C674B
          1C674BFAFCFCF4F8F7EDF3F1C9DAD1BBD6CDBCD2C6EEF3F0FFFFFFFFFFFFFFFF
          FF1C674B1C674BFFFFFF1C674B1C674BFFFFFFFDFEFEF9FBFBF3F8F7DDE8E3BA
          D2C9C4D6CCFBFCFCFFFFFFFFFFFFFFFFFFFFFFFF1C674B1C674B1C674BFFFFFF
          FFFFFFFEFFFEFBFCFCF6F9F8E7EFECBCD3C8CCDBD3FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF1C674BFFFFFFFFFFFFFFFFFFFFFFFFFCFDFDF9FBFBEBF1EFBE
          D5CACDDCD3FFFFFFFFFFFFFFFFFF1C674B1C674BFFFFFFFFFFFFFFFFFF1C674B
          1C674BFFFFFFFDFEFEFAFCFCEAF1EEBCD3C9C7D8CEF9FBFAFFFFFFFFFFFFFFFF
          FF1C674B1C674BFFFFFF1C674B1C674BFFFFFFFFFFFFFEFFFEFBFCFCE4EDE9BB
          D3CABFD5CAEBF1EEFFFFFFFFFFFFFFFFFFFFFFFF1C674B1C674B1C674BFFFFFF
          FFFFFFFFFFFFFEFFFEFDFEFED1DFD7BED8CFC3DBD2D1DFD8FBFCFCFFFFFFFFFF
          FFFFFFFFFFFFFF1C674BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFECF2EFB9CEC2D4
          D4FDD4D4FDBDD1C6DDE7E1FDFEFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFF1F5F3C3D5CBBFD8CFD4D4FDD4D4FDCAE4DEBBD0C4DBE6E0F7F9
          F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFEFDE7EEEAC2D4CABDD5CAD4D4FDD4
          D4FDD4D4FDD4D4FDD4D4FDBFD5CBC8D9CFDDE7E1E7EEEAEEF3F0EBF1EEE0E9E4
          CCDBD3B7CDC1C3DED4D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDC9E4
          DEC6DED7C3DBD1C5DCD2C4DBD1C2DBD2C7E2DAD4D4FDD4D4FDD4D4FDD4D4FDD4
          D4FD}
        Transparent = True
        OnClick = OpenCloseImageClick
        OnDblClick = OpenCloseImageClick
      end
    end
    object CallsPanel: TTntPanel
      Left = 0
      Top = 103
      Width = 413
      Height = 133
      Align = alClient
      BevelOuter = bvNone
      Constraints.MinHeight = 133
      ParentColor = True
      TabOrder = 1
      DesignSize = (
        413
        133)
      object Label15: TTntLabel
        Left = 8
        Top = 8
        Width = 174
        Height = 34
        Caption = 'Recent Calls'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 14346715
        Font.Height = -29
        Font.Name = 'Book Antiqua'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label21: TTntLabel
        Left = 32
        Top = 18
        Width = 85
        Height = 19
        Caption = 'Recent Calls'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Bevel4: TTntBevel
        Left = 8
        Top = 40
        Width = 397
        Height = 9
        Anchors = [akLeft, akTop, akRight]
        Shape = bsTopLine
      end
      object Image5: TTntImage
        Left = 8
        Top = 52
        Width = 16
        Height = 16
        AutoSize = True
        Picture.Data = {
          07544269746D617036030000424D360300000000000036000000280000001000
          000010000000010018000000000000030000120B0000120B0000000000000000
          0000D9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FC
          D9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCA8A8A89C9C9C9C9C
          9C9D9D9DA5A5A5D9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9
          D1FCD9D1FCAD6D5695543F985241985241834C377052456464647A7A7A939393
          949494898989858585868686949494D9D1FCC66845DD5334F96451FD715CF36D
          53D26F42F86652CD4E2D4E522D336E333384333D8D3D31873127792740624094
          9494CF8164F96451FD7B63FE8C6FDC8557F5CD9BEF7153FD6B5892873D54AF50
          68AE5D62CA6256C35639B5392A852A959595D9D1FCE36649FD886CE17E52FAC7
          94FFD3A0E57851F8755C919C5186C281EFF5E056AF5674D27453C253398939D9
          D1FCD9D1FCD9D1FCA7574E43245B443779614978BC5E3C937B3682DA82A4C697
          FFF5ECBACFA864C16446A646859885D9D1FCD9D1FC16161604070E102C72153B
          A0113297131F674E674E66A56644888E1177B9217EBB1D745E495D49A4A4A4D9
          D1FC3C3C3C1B1B1B1330691B4EB31E58BD1C50B50E33935055666C8C9F2E93F2
          3499FF3499FF2C91EF355568838383D9D1FC1616162929291943812774D92774
          D92774D91C5DBD4A546A468CBE40A5FF41A6FF41A6FF3FA4FF2680C06B6B6BD9
          D1FC2C2C2C36363626466C3190F6359AFF3496FA2274D2505F714D99CF4DB2FF
          4EB3FF4EB3FF4AAFFF3297E660666AD9D1FC6868684B4B4B4343433747661C46
          902363C616487E76839058A5D64DB2F24BB0EC58BDFF51B6FF43A5EA57707DD9
          D1FCD9D1FC3A3A3A6A6A6A8D8D8DA4A4A4505050354048D9D1FC6CA6C32A87B9
          53A4D262A8D3529FD01976A4A1A1A1D9D1FCD9D1FCD9D1FC6B6B6B5D5D5D5E5E
          5E656565D9D1FCD9D1FCD9D1FC358BB88BC4E5A1CFEA58A4CF5990AED9D1FCD9
          D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FC
          90BAD09CC2D59CBCCCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1
          FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9
          D1FC}
        Transparent = True
      end
      object Label22: TTntLabel
        Left = 32
        Top = 52
        Width = 62
        Height = 13
        Caption = 'Recent calls:'
      end
      object wRecentCallsNum: TTntLabel
        Left = 268
        Top = 52
        Width = 125
        Height = 13
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = '?'
      end
      object Image12: TTntImage
        Left = 389
        Top = 12
        Width = 16
        Height = 16
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Picture.Data = {
          07544269746D617036030000424D360300000000000036000000280000001000
          000010000000010018000000000000030000120B0000120B0000000000000000
          0000D4D4FDD4D4FDD4D4FDD4D4FDB7CFC4BDD1C5C6D8CECBDBD3CBDBD3C6D8CE
          BDD2C7B8D0C5D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDBDD8CEB8CEC1D4E2
          DBE9F1EEF0F6F4F0F6F5EFF5F3EDF3F1E4EDE9D0DFD7BBCFC3BBD5CCD4D4FDD4
          D4FDD4D4FDBFD9D1BACFC3E0EAE5F7FAFAF6F9F8F7FAFAF7FAFAF6F9F8F4F8F7
          F1F6F5EEF4F2D8E5DFBBD0C5BAD7CED4D4FDD4D4FDB9CDC1E3ECE7FBFCFCFBFC
          FCFBFCFCFDFEFEFDFEFEFDFEFEFBFCFCF8FBFAF3F8F7EFF5F3D8E4DEB9D0C3D4
          D4FDBED6CCD3E1D9FDFEFDFEFFFE1C674B1C674BFFFFFFFFFFFFFFFFFF1C674B
          1C674BFAFCFCF4F8F7EDF3F1C9DAD1BBD6CDBCD2C6EEF3F0FFFFFFFFFFFFFFFF
          FF1C674B1C674BFFFFFF1C674B1C674BFFFFFFFDFEFEF9FBFBF3F8F7DDE8E3BA
          D2C9C4D6CCFBFCFCFFFFFFFFFFFFFFFFFFFFFFFF1C674B1C674B1C674BFFFFFF
          FFFFFFFEFFFEFBFCFCF6F9F8E7EFECBCD3C8CCDBD3FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF1C674BFFFFFFFFFFFFFFFFFFFFFFFFFCFDFDF9FBFBEBF1EFBE
          D5CACDDCD3FFFFFFFFFFFFFFFFFF1C674B1C674BFFFFFFFFFFFFFFFFFF1C674B
          1C674BFFFFFFFDFEFEFAFCFCEAF1EEBCD3C9C7D8CEF9FBFAFFFFFFFFFFFFFFFF
          FF1C674B1C674BFFFFFF1C674B1C674BFFFFFFFFFFFFFEFFFEFBFCFCE4EDE9BB
          D3CABFD5CAEBF1EEFFFFFFFFFFFFFFFFFFFFFFFF1C674B1C674B1C674BFFFFFF
          FFFFFFFFFFFFFEFFFEFDFEFED1DFD7BED8CFC3DBD2D1DFD8FBFCFCFFFFFFFFFF
          FFFFFFFFFFFFFF1C674BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFECF2EFB9CEC2D4
          D4FDD4D4FDBDD1C6DDE7E1FDFEFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFF1F5F3C3D5CBBFD8CFD4D4FDD4D4FDCAE4DEBBD0C4DBE6E0F7F9
          F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFEFDE7EEEAC2D4CABDD5CAD4D4FDD4
          D4FDD4D4FDD4D4FDD4D4FDBFD5CBC8D9CFDDE7E1E7EEEAEEF3F0EBF1EEE0E9E4
          CCDBD3B7CDC1C3DED4D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDC9E4
          DEC6DED7C3DBD1C5DCD2C4DBD1C2DBD2C7E2DAD4D4FDD4D4FDD4D4FDD4D4FDD4
          D4FD}
        Transparent = True
        OnClick = OpenCloseImageClick
        OnDblClick = OpenCloseImageClick
      end
      object lvCalls: TTntListView
        Left = 28
        Top = 72
        Width = 365
        Height = 51
        Anchors = [akLeft, akTop, akRight, akBottom]
        BorderStyle = bsNone
        Color = clWhite
        Columns = <
          item
            Width = 80
          end
          item
            Width = 100
          end>
        HideSelection = False
        ReadOnly = True
        RowSelect = True
        PopupMenu = PopupMenu2
        ShowColumnHeaders = False
        SmallImages = Form1.ImageList1
        SortType = stData
        TabOrder = 0
        ViewStyle = vsReport
        OnCompare = ListViewCompare
        OnResize = ListViewResize
      end
    end
    object BatteryPanel: TTntPanel
      Left = 0
      Top = 242
      Width = 413
      Height = 257
      Align = alBottom
      BevelOuter = bvNone
      Constraints.MinHeight = 257
      ParentColor = True
      TabOrder = 2
      DesignSize = (
        413
        257)
      object Label26: TTntLabel
        Left = 8
        Top = 8
        Width = 225
        Height = 34
        Caption = 'Phone & Battery'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 14346715
        Font.Height = -29
        Font.Name = 'Book Antiqua'
        Font.Style = [fsBold]
        ParentFont = False
        ShowAccelChar = False
        Transparent = True
      end
      object Label27: TTntLabel
        Left = 32
        Top = 18
        Width = 114
        Height = 19
        Caption = 'Phone & Battery'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ShowAccelChar = False
        Transparent = True
      end
      object Bevel6: TTntBevel
        Left = 8
        Top = 40
        Width = 397
        Height = 9
        Anchors = [akLeft, akTop, akRight]
        Shape = bsTopLine
      end
      object Image7: TTntImage
        Left = 8
        Top = 52
        Width = 16
        Height = 16
        AutoSize = True
        Picture.Data = {
          07544269746D617036030000424D360300000000000036000000280000001000
          000010000000010018000000000000030000120B0000120B0000000000000000
          0000D9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FC
          D9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1
          FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FC6A6A6A717171717171808080919191D9
          D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FC5593A8
          5593A848484846879B4F5056534D4D797979D9D1FCD9D1FCD9D1FCD9D1FCD9D1
          FCD9D1FCD9D1FCD9D1FC94989A7BE1FF5593A86849487BE1FF74889A734E4D53
          5353D9D1FCD9D1FCD9D1FCD9D1FCD9D1FC7F7F7F5858585352526550517BE1FF
          7E7074DC807F7BE1FFA49D9EA16767545454D9D1FCD9D1FCD9D1FCD9D1FC7A7A
          7A9C8A899C8A89A28A8AAE7372A18586A79091D19090DB9D9CDF9D9CA77D7D80
          8080D9D1FCD9D1FCD9D1FC9C8A89F2F2F2FEFFFFDFD6D6D9B3B3BF8585DEBFBF
          F9DEDEF4CECEF5BEBEF3B9B9806767D9D1FCD9D1FCD9D1FCA5A5A59C8A89EAEA
          EAF6F7F7DAD1D1D1B0B0D19393BF9494DFD3D3F1D7D7E0B9B97E6565605D5DD9
          D1FCD9D1FC868686808182878787EDEDEDF8F6F6DED3D0D3AFADE6B0AF7A6363
          656161A69F9FAFAAAA9C8A896C6C6CD9D1FCA2A3A3959597787878979DA0EDEB
          E9EFF5F7C7C9D5C2A5AEE8B1AE8070704949496C6B6B9C8A899C8A89D9D1FCD9
          D1FC9C9D9E8D8E8E818181979DA0BDDFEC8AE2FF348AF11B37B88E61A0C5A3A1
          9C8A899C8A899C8A89D9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FC979DA098D6
          F77BE1FF2686F50121BA5629978E6A69707170D9D1FCD9D1FCD9D1FCD9D1FCD9
          D1FCD9D1FCD9D1FCD9D1FC979DA0B0DCF5C9EBF1A8B2CD9481A7B47AA3866363
          898989D9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FC979DA0979D
          A0E9E6E9C0CAE4A1B0D6E0A29D746362D9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9
          D1FCD9D1FCD9D1FCD9D1FCD9D1FC979DA0979DA0979DA0979DA0979DA0D9D1FC
          D9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1
          FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9
          D1FC}
        Transparent = True
      end
      object Label5: TTntLabel
        Left = 32
        Top = 52
        Width = 95
        Height = 13
        Caption = 'Battery temperature:'
        Transparent = True
      end
      object Label3: TTntLabel
        Left = 32
        Top = 72
        Width = 64
        Height = 13
        Caption = 'Consumption:'
        Transparent = True
      end
      object Label2: TTntLabel
        Left = 32
        Top = 92
        Width = 74
        Height = 13
        Caption = 'Current Charge:'
        Transparent = True
      end
      object Label4: TTntLabel
        Left = 227
        Top = 72
        Width = 77
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Charge Counter:'
        Transparent = True
      end
      object Label7: TTntLabel
        Left = 32
        Top = 132
        Width = 63
        Height = 13
        Caption = 'From Charge:'
        Transparent = True
      end
      object Label1: TTntLabel
        Left = 32
        Top = 112
        Width = 75
        Height = 13
        Caption = 'Battery Voltage:'
        Transparent = True
      end
      object Label28: TTntLabel
        Left = 32
        Top = 152
        Width = 59
        Height = 13
        Caption = 'Battery type:'
      end
      object Label29: TTntLabel
        Left = 227
        Top = 92
        Width = 69
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Battery Status:'
      end
      object Label8: TTntLabel
        Left = 227
        Top = 112
        Width = 68
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Est. Time Left:'
        Transparent = True
      end
      object Label35: TTntLabel
        Left = 227
        Top = 132
        Width = 66
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'On AC power:'
        Transparent = True
      end
      object wCharge: TTntLabel
        Left = 311
        Top = 132
        Width = 81
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = '?'
        Transparent = True
      end
      object lblTimeLeft: TTntLabel
        Left = 303
        Top = 112
        Width = 89
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = '?'
        Transparent = True
      end
      object wBattery: TTntLabel
        Left = 311
        Top = 92
        Width = 81
        Height = 13
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = '?'
      end
      object lbPower: TTntLabel
        Left = 112
        Top = 152
        Width = 280
        Height = 13
        Alignment = taRightJustify
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = '?'
      end
      object lbvbat: TTntLabel
        Left = 124
        Top = 112
        Width = 69
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = '?'
        Transparent = True
      end
      object lbdcio: TTntLabel
        Left = 108
        Top = 132
        Width = 85
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = '?'
        Transparent = True
      end
      object lbcyclescharge: TTntLabel
        Left = 315
        Top = 72
        Width = 77
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = '?'
        Transparent = True
      end
      object lbicharge: TTntLabel
        Left = 116
        Top = 92
        Width = 77
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = '?'
        Transparent = True
      end
      object lbiphone: TTntLabel
        Left = 108
        Top = 72
        Width = 85
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = '?'
        Transparent = True
      end
      object lbtempbatt: TTntLabel
        Left = 140
        Top = 52
        Width = 53
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = '?'
        Transparent = True
      end
      object Image14: TTntImage
        Left = 389
        Top = 12
        Width = 16
        Height = 16
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Picture.Data = {
          07544269746D617036030000424D360300000000000036000000280000001000
          000010000000010018000000000000030000120B0000120B0000000000000000
          0000D4D4FDD4D4FDD4D4FDD4D4FDB7CFC4BDD1C5C6D8CECBDBD3CBDBD3C6D8CE
          BDD2C7B8D0C5D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDBDD8CEB8CEC1D4E2
          DBE9F1EEF0F6F4F0F6F5EFF5F3EDF3F1E4EDE9D0DFD7BBCFC3BBD5CCD4D4FDD4
          D4FDD4D4FDBFD9D1BACFC3E0EAE5F7FAFAF6F9F8F7FAFAF7FAFAF6F9F8F4F8F7
          F1F6F5EEF4F2D8E5DFBBD0C5BAD7CED4D4FDD4D4FDB9CDC1E3ECE7FBFCFCFBFC
          FCFBFCFCFDFEFEFDFEFEFDFEFEFBFCFCF8FBFAF3F8F7EFF5F3D8E4DEB9D0C3D4
          D4FDBED6CCD3E1D9FDFEFDFEFFFE1C674B1C674BFFFFFFFFFFFFFFFFFF1C674B
          1C674BFAFCFCF4F8F7EDF3F1C9DAD1BBD6CDBCD2C6EEF3F0FFFFFFFFFFFFFFFF
          FF1C674B1C674BFFFFFF1C674B1C674BFFFFFFFDFEFEF9FBFBF3F8F7DDE8E3BA
          D2C9C4D6CCFBFCFCFFFFFFFFFFFFFFFFFFFFFFFF1C674B1C674B1C674BFFFFFF
          FFFFFFFEFFFEFBFCFCF6F9F8E7EFECBCD3C8CCDBD3FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF1C674BFFFFFFFFFFFFFFFFFFFFFFFFFCFDFDF9FBFBEBF1EFBE
          D5CACDDCD3FFFFFFFFFFFFFFFFFF1C674B1C674BFFFFFFFFFFFFFFFFFF1C674B
          1C674BFFFFFFFDFEFEFAFCFCEAF1EEBCD3C9C7D8CEF9FBFAFFFFFFFFFFFFFFFF
          FF1C674B1C674BFFFFFF1C674B1C674BFFFFFFFFFFFFFEFFFEFBFCFCE4EDE9BB
          D3CABFD5CAEBF1EEFFFFFFFFFFFFFFFFFFFFFFFF1C674B1C674B1C674BFFFFFF
          FFFFFFFFFFFFFEFFFEFDFEFED1DFD7BED8CFC3DBD2D1DFD8FBFCFCFFFFFFFFFF
          FFFFFFFFFFFFFF1C674BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFECF2EFB9CEC2D4
          D4FDD4D4FDBDD1C6DDE7E1FDFEFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFF1F5F3C3D5CBBFD8CFD4D4FDD4D4FDCAE4DEBBD0C4DBE6E0F7F9
          F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFEFDE7EEEAC2D4CABDD5CAD4D4FDD4
          D4FDD4D4FDD4D4FDD4D4FDBFD5CBC8D9CFDDE7E1E7EEEAEEF3F0EBF1EEE0E9E4
          CCDBD3B7CDC1C3DED4D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDC9E4
          DEC6DED7C3DBD1C5DCD2C4DBD1C2DBD2C7E2DAD4D4FDD4D4FDD4D4FDD4D4FDD4
          D4FD}
        Transparent = True
        OnClick = OpenCloseImageClick
        OnDblClick = OpenCloseImageClick
      end
      object Image8: TTntImage
        Left = 203
        Top = 52
        Width = 16
        Height = 16
        Anchors = [akTop, akRight]
        AutoSize = True
        Picture.Data = {
          07544269746D617036030000424D360300000000000036000000280000001000
          000010000000010018000000000000030000120B0000120B0000000000000000
          0000D9D1FCD9D1FC919191575757696969929292D9D1FCD9D1FCD9D1FCD9D1FC
          D9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCADADAD837F7F8C7A7A5650
          504848485757575A5A5A6E61614848485959597D7D7DD9D1FCD9D1FCD9D1FCD9
          D1FCD9D1FC888888B3AEAE9D8D8DD4B2B2E4B9B9917B7BC59393AE99A0B19497
          997E7E5952525151516D6D6DD9D1FCD9D1FCD9D1FC8D8D8DA8A4A45453535F5D
          5D736868CC9696AE7474FFCCCCFFCCCCFFCCCCFFCCCCFF9999FF99994E4E4ED9
          D1FCD9D1FC9191919B9A9A5353535353537D7272E39999A98181F7F7F77A9DE3
          555DD8323CAD7A9DE3A3B690D9D1FCD9D1FCD9D1FC9E9E9E9C9C9C6868685B5B
          5B706969C7B6B6D9D1FC7A9DE3323CAD7A9EE2545CD77A9DE38E8270D9D1FCD9
          D1FCD9D1FCBCBCBC9B9B9B676767535353797474C7B6B6D9D1FC323CAD799BE4
          78A0DF323CAD789FE0D9D1FCD9D1FCD9D1FCD9D1FCC2C2C29A9A9A3BC96B4CBD
          725C946F9B9696D9D1FC779DE1323CADD9D1FC7B9CE2343EAED9D1FCD9D1FCD9
          D1FCD9D1FCC7C7C792929248E07B40D8734CBE736A6969D9D1FCD9D1FC7C9EE0
          323CADD9D1FC555DD87A9DE3D9D1FCD9D1FCD9D1FCCDCDCD9797975DF58F41D9
          733CAD626A6A6AD9D1FCD9D1FCD9D1FC7C9EE0323CADD9D1FC799EDFD9D1FCD9
          D1FCD9D1FCD3D3D395A89553BA6C50DE7A2EA04E5B5B5BD9D1FCD9D1FCD9D1FC
          D9D1FC323CADD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCAFAFAFA2A2A28181817777
          77868686535353D9D1FCD9D1FCD9D1FCD9D1FC7A9DE3D9D1FCD9D1FCD9D1FCD9
          D1FCD9D1FC9C9C9C8080807171718787879898988E8E8ED9D1FCD9D1FCD9D1FC
          D9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FC8787874127275750508585
          859B9B9BD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9
          D1FCD9D1FCD9D1FC7D7171939393D9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FC
          D9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FC837676D9D1FCD9D1
          FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9
          D1FC}
        Transparent = True
      end
      object Label6: TTntLabel
        Left = 227
        Top = 52
        Width = 93
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Phone temperature:'
        Transparent = True
      end
      object Label12: TTntLabel
        Left = 32
        Top = 172
        Width = 66
        Height = 13
        Caption = 'Manufacturer:'
        Transparent = True
      end
      object Label13: TTntLabel
        Left = 32
        Top = 192
        Width = 32
        Height = 13
        Caption = 'Model:'
        Transparent = True
      end
      object Label16: TTntLabel
        Left = 32
        Top = 212
        Width = 89
        Height = 13
        Caption = 'Software Revision:'
        Transparent = True
      end
      object Label14: TTntLabel
        Left = 32
        Top = 232
        Width = 69
        Height = 13
        Caption = 'Serial Number:'
        Transparent = True
      end
      object lbSerialNumber: TTntLabel
        Left = 108
        Top = 232
        Width = 284
        Height = 14
        Alignment = taRightJustify
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = '?'
        Transparent = True
      end
      object lbSWRevision: TTntLabel
        Left = 132
        Top = 212
        Width = 260
        Height = 14
        Alignment = taRightJustify
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = '?'
        Transparent = True
      end
      object lbModel: TTntLabel
        Left = 76
        Top = 192
        Width = 316
        Height = 14
        Alignment = taRightJustify
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = '?'
        Transparent = True
      end
      object lbManufacturer: TTntLabel
        Left = 112
        Top = 172
        Width = 280
        Height = 14
        Alignment = taRightJustify
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = '?'
        Transparent = True
      end
      object lbtempphone: TTntLabel
        Left = 335
        Top = 52
        Width = 57
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = '?'
        Transparent = True
      end
    end
  end
  object Panel2: TTntPanel
    Left = 419
    Top = 72
    Width = 351
    Height = 499
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object Splitter4: TTntSplitter
      Left = 0
      Top = 97
      Width = 351
      Height = 6
      Cursor = crVSplit
      Align = alTop
      ResizeStyle = rsUpdate
      OnPaint = SplitterPaint
    end
    object Splitter5: TTntSplitter
      Left = 0
      Top = 236
      Width = 351
      Height = 6
      Cursor = crVSplit
      Align = alBottom
      ResizeStyle = rsUpdate
      OnPaint = SplitterPaint
    end
    object OuboxPanel: TTntPanel
      Left = 0
      Top = 0
      Width = 351
      Height = 97
      Align = alTop
      BevelOuter = bvNone
      Constraints.MinHeight = 97
      ParentColor = True
      TabOrder = 0
      DesignSize = (
        351
        97)
      object Label18: TTntLabel
        Left = 8
        Top = 8
        Width = 102
        Height = 34
        Caption = 'Outbox'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 14346715
        Font.Height = -29
        Font.Name = 'Book Antiqua'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label19: TTntLabel
        Left = 32
        Top = 18
        Width = 52
        Height = 19
        Caption = 'Outbox'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Bevel3: TTntBevel
        Left = 8
        Top = 40
        Width = 332
        Height = 9
        Anchors = [akLeft, akTop, akRight]
        Shape = bsTopLine
      end
      object Image4: TTntImage
        Left = 8
        Top = 52
        Width = 16
        Height = 16
        AutoSize = True
        Picture.Data = {
          07544269746D617036030000424D360300000000000036000000280000001000
          000010000000010018000000000000030000120B0000120B0000000000000000
          0000C6DCC6C79B97C29A9BC5AAACC7B9BCC6DCC6C6DCC6C6DCC6C6DCC6C6DCC6
          C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C79B97C79B97E7B999DEAF
          97D0A497C59D9BC5AAACC7B9BCC6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6
          DCC6C6DCC6C79B97E2B698CFA69BF5D6A7F5D0A1F4CB9CEBBE99DEAF97D0A497
          C59997C4A6A7C7B6B9C6DCC6C6DCC6C6DCC6C6DCC6C79B97F5D8A9D7B29EDEC4
          AAF5E8B7F5E1B2F5DBACF5D6A7F5CFA0F4C99CE9BC99DBAE97C49897C79B97C6
          DCC6C6DCC6C79B97F5EFBDF2E4B6CCA69DEBE5BFF5F6C4F5F3C1F5EFBCF5E8B7
          F5E1B2F5DBACE2BC9FC79B97C79B97C6DCC6C6DCC6C79B97F5F9C8F5F9C6EBE5
          BCCCA8A2F2F3D2F5F9D0F5F9CCF5F9C8F5F6C4E2CDAFCCA199E2B799C79B97C6
          DCC6C6DCC6C79B97F5F9D5F5F9D1F5F9CEDBC5B2D7C0B7F5F9E4F5F9DEF5F9D9
          EBE5C8CFABA0F2DDB0E8CBA8C79B97C6DCC6C6DCC6C79B97F5F9E0F5F9DEDBC5
          B6BDA7A7B2ADB4D4B9B6E2D2CBE5D8CFC59C9CEBE5BCF5F6C4E8DAB6C79B97C6
          DCC6C6DCC6C79B97E8DFD5CCA8A5C1C4C6E4F2F3D6F6F9C2DEE6B7C5CCB0BDC6
          B4ADB4D4B9ABF5F9CDE8DFBDC79B97C6DCC6C6DCC6C79B97C29697B5C9DEF5F9
          F9F5F9F9F3F9F9E8F9F9E4F9F9DBF9F9CCF6F9B5B2B9D4B9AEE8DFC5C79B97C6
          DCC6C6DCC6C6DCC6C1A0A1BBD0E0F5F9F9F5F9F9F5F9F9F5F9F9EEF9F9E5F9F9
          B7DFECA9DBF19899B0CFAEA8C79B97C6DCC6C6DCC6C6DCC6C8BDC09EA8C6C2DF
          F9A3D2F7A1D2F68DC7F186C0F18AAAD0AAA4B9B29FAEB49CA8C29697C79B97C6
          DCC6C6DCC6C6DCC6C6DCC6C8BDC0B8A6A894E6F391E1F990D8F98FCFF98EC8F9
          8DC5F98ABAF3A4A4C0C4A6A7C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C8BD
          C0B8A7A894E8F392E4F991DBF990D0F997BFE6B79FA8C7B6B9C6DCC6C6DCC6C6
          DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C8BDC0B8A8A89ED7E094E2F3A5BCCC
          C4A2A3C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DC
          C6C6DCC6C6DCC6C5AEB0C4A6A7C7B9BCC6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6
          DCC6}
        Transparent = True
      end
      object Label20: TTntLabel
        Left = 32
        Top = 52
        Width = 88
        Height = 13
        Caption = 'Unsent Messages:'
      end
      object wOutboxNew: TTntLabel
        Left = 132
        Top = 52
        Width = 196
        Height = 13
        Alignment = taRightJustify
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = 'none'
      end
      object linkComposeMessage: TTntLabel
        Left = 32
        Top = 72
        Width = 68
        Height = 13
        Cursor = crHandPoint
        Caption = 'New Message'
        Transparent = True
        OnClick = linkComposeMessageClick
      end
      object linkSendMessages: TTntLabel
        Left = 302
        Top = 72
        Width = 25
        Height = 13
        Cursor = crHandPoint
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Send'
        Transparent = True
        OnClick = linkSendMessagesClick
      end
      object Image11: TTntImage
        Left = 328
        Top = 12
        Width = 16
        Height = 16
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Picture.Data = {
          07544269746D617036030000424D360300000000000036000000280000001000
          000010000000010018000000000000030000120B0000120B0000000000000000
          0000D4D4FDD4D4FDD4D4FDD4D4FDB7CFC4BDD1C5C6D8CECBDBD3CBDBD3C6D8CE
          BDD2C7B8D0C5D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDBDD8CEB8CEC1D4E2
          DBE9F1EEF0F6F4F0F6F5EFF5F3EDF3F1E4EDE9D0DFD7BBCFC3BBD5CCD4D4FDD4
          D4FDD4D4FDBFD9D1BACFC3E0EAE5F7FAFAF6F9F8F7FAFAF7FAFAF6F9F8F4F8F7
          F1F6F5EEF4F2D8E5DFBBD0C5BAD7CED4D4FDD4D4FDB9CDC1E3ECE7FBFCFCFBFC
          FCFBFCFCFDFEFEFDFEFEFDFEFEFBFCFCF8FBFAF3F8F7EFF5F3D8E4DEB9D0C3D4
          D4FDBED6CCD3E1D9FDFEFDFEFFFE1C674B1C674BFFFFFFFFFFFFFFFFFF1C674B
          1C674BFAFCFCF4F8F7EDF3F1C9DAD1BBD6CDBCD2C6EEF3F0FFFFFFFFFFFFFFFF
          FF1C674B1C674BFFFFFF1C674B1C674BFFFFFFFDFEFEF9FBFBF3F8F7DDE8E3BA
          D2C9C4D6CCFBFCFCFFFFFFFFFFFFFFFFFFFFFFFF1C674B1C674B1C674BFFFFFF
          FFFFFFFEFFFEFBFCFCF6F9F8E7EFECBCD3C8CCDBD3FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF1C674BFFFFFFFFFFFFFFFFFFFFFFFFFCFDFDF9FBFBEBF1EFBE
          D5CACDDCD3FFFFFFFFFFFFFFFFFF1C674B1C674BFFFFFFFFFFFFFFFFFF1C674B
          1C674BFFFFFFFDFEFEFAFCFCEAF1EEBCD3C9C7D8CEF9FBFAFFFFFFFFFFFFFFFF
          FF1C674B1C674BFFFFFF1C674B1C674BFFFFFFFFFFFFFEFFFEFBFCFCE4EDE9BB
          D3CABFD5CAEBF1EEFFFFFFFFFFFFFFFFFFFFFFFF1C674B1C674B1C674BFFFFFF
          FFFFFFFFFFFFFEFFFEFDFEFED1DFD7BED8CFC3DBD2D1DFD8FBFCFCFFFFFFFFFF
          FFFFFFFFFFFFFF1C674BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFECF2EFB9CEC2D4
          D4FDD4D4FDBDD1C6DDE7E1FDFEFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFF1F5F3C3D5CBBFD8CFD4D4FDD4D4FDCAE4DEBBD0C4DBE6E0F7F9
          F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFEFDE7EEEAC2D4CABDD5CAD4D4FDD4
          D4FDD4D4FDD4D4FDD4D4FDBFD5CBC8D9CFDDE7E1E7EEEAEEF3F0EBF1EEE0E9E4
          CCDBD3B7CDC1C3DED4D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDC9E4
          DEC6DED7C3DBD1C5DCD2C4DBD1C2DBD2C7E2DAD4D4FDD4D4FDD4D4FDD4D4FDD4
          D4FD}
        Transparent = True
        OnClick = OpenCloseImageClick
        OnDblClick = OpenCloseImageClick
      end
      object linkJumpOutbox: TTntLabel
        Left = 132
        Top = 72
        Width = 34
        Height = 13
        Cursor = crHandPoint
        Caption = 'Outbox'
        Transparent = True
        OnClick = linkJumpMsgFolderClick
      end
      object linkJumpSent: TTntLabel
        Left = 104
        Top = 72
        Width = 22
        Height = 13
        Cursor = crHandPoint
        Caption = 'Sent'
        Transparent = True
        OnClick = linkJumpSentClick
      end
    end
    object MissedCallsPanel: TTntPanel
      Left = 0
      Top = 103
      Width = 351
      Height = 133
      Align = alClient
      BevelOuter = bvNone
      Constraints.MinHeight = 133
      ParentColor = True
      TabOrder = 1
      DesignSize = (
        351
        133)
      object Label24: TTntLabel
        Left = 8
        Top = 8
        Width = 176
        Height = 34
        Caption = 'Missed Calls'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 14346715
        Font.Height = -29
        Font.Name = 'Book Antiqua'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label25: TTntLabel
        Left = 32
        Top = 18
        Width = 85
        Height = 19
        Caption = 'Missed Calls'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label23: TTntLabel
        Left = 32
        Top = 52
        Width = 97
        Height = 13
        Caption = 'Recent missed calls:'
      end
      object Image6: TTntImage
        Left = 8
        Top = 52
        Width = 16
        Height = 16
        AutoSize = True
        Picture.Data = {
          07544269746D617036030000424D360300000000000036000000280000001000
          000010000000010018000000000000030000120B0000120B0000000000000000
          0000C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6
          C6DCC6C6DCC6C6DCC6C6DCC6AFABA5C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DC
          C6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6A9A093AF
          ABA5B0B0AEB0B0AEB0B0AEB0B0AEB0B0AEB0B0AEB0B0AEB0B0AEB0B0AEB0B0AE
          B8BBBBC6DCC6C6DCC6C6DCC6A9A093A59A877A6E517A6E516E64496E64496E64
          496E64496E64496E6449685D44685D44A59A87C6DCC6C6DCC6C6DCC6A9A0939A
          8B6E9A8B6EE6CB8BCDBB87CDB07BCDB07BCDB07BCDB07BCDB07BBA9F6DA59A87
          C6DCC6C6DCC6C6DCC6C6DCC6A59A878C836EA5996EF4E095E6CB8BE5C585DFC1
          83DFC183DBB67CBA9F6DB8A487C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6A59A8784
          7657A5996EF5EE9EF2D18CE6CB8BE6CB8BE5C585C6A2719E9279C6DCC6C6DCC6
          C6DCC6C6DCC6C6DCC6C6DCC68C836E8C836EA5996EF5EE9EF2D18CE6CB8BE5C5
          85DFC183BA9F6D8C836EAFABA5AFABA5C6DCC6C6DCC6C6DCC69A8B6E8476579A
          8B6EA5996EF4E095F2D18CE6CB8BE6CB8BDFC183DBB67CAE8D637A6E518C836E
          9B99939B99938C836E98815C98815CA59A87A5996EF5EE9EF4E095F4E095F4E0
          95EFCB87DFC183CDB07BA5996E84765784765784765798815CC6A271847657C6
          DCC6A5996EF5EE9EF4E095CDBB87F4E095F4E095EFCB87DBB67CCDB07BC6A271
          BA9F6DBA9F6DCDB07BC6A27198815CC6DCC6A5996EF5EE9ECDBB87D5C9B5CDBB
          87F5EE9EF5EE9EEFCB87DFC183DBB67CDBB67CDBB67CECC07FAE8D63B7B2ABC6
          DCC6A5996EE6CB8BD2BBA2C6DCC6C6DCC6CDBB87F4E095F5EE9EF4E095F2D18C
          F2D18CEFCB87BA9F6DA9A093C6DCC6C6DCC6A5996ED2BBA2C6DCC6C6DCC6C6DC
          C6C6DCC6CDBB87C6A271E5C585F2D18CE5C585AE8D63B8A487C6DCC6C6DCC6C6
          DCC6D2BBA2C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6E5C585CDB07B
          B8A487B8A487C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DC
          C6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6DCC6C6
          DCC6}
        Transparent = True
      end
      object wMissedCallsNum: TTntLabel
        Left = 136
        Top = 52
        Width = 192
        Height = 13
        Alignment = taRightJustify
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = 'none'
      end
      object Bevel5: TTntBevel
        Left = 8
        Top = 40
        Width = 332
        Height = 9
        Anchors = [akLeft, akTop, akRight]
        Shape = bsTopLine
      end
      object Image13: TTntImage
        Left = 328
        Top = 12
        Width = 16
        Height = 16
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Picture.Data = {
          07544269746D617036030000424D360300000000000036000000280000001000
          000010000000010018000000000000030000120B0000120B0000000000000000
          0000D4D4FDD4D4FDD4D4FDD4D4FDB7CFC4BDD1C5C6D8CECBDBD3CBDBD3C6D8CE
          BDD2C7B8D0C5D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDBDD8CEB8CEC1D4E2
          DBE9F1EEF0F6F4F0F6F5EFF5F3EDF3F1E4EDE9D0DFD7BBCFC3BBD5CCD4D4FDD4
          D4FDD4D4FDBFD9D1BACFC3E0EAE5F7FAFAF6F9F8F7FAFAF7FAFAF6F9F8F4F8F7
          F1F6F5EEF4F2D8E5DFBBD0C5BAD7CED4D4FDD4D4FDB9CDC1E3ECE7FBFCFCFBFC
          FCFBFCFCFDFEFEFDFEFEFDFEFEFBFCFCF8FBFAF3F8F7EFF5F3D8E4DEB9D0C3D4
          D4FDBED6CCD3E1D9FDFEFDFEFFFE1C674B1C674BFFFFFFFFFFFFFFFFFF1C674B
          1C674BFAFCFCF4F8F7EDF3F1C9DAD1BBD6CDBCD2C6EEF3F0FFFFFFFFFFFFFFFF
          FF1C674B1C674BFFFFFF1C674B1C674BFFFFFFFDFEFEF9FBFBF3F8F7DDE8E3BA
          D2C9C4D6CCFBFCFCFFFFFFFFFFFFFFFFFFFFFFFF1C674B1C674B1C674BFFFFFF
          FFFFFFFEFFFEFBFCFCF6F9F8E7EFECBCD3C8CCDBD3FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF1C674BFFFFFFFFFFFFFFFFFFFFFFFFFCFDFDF9FBFBEBF1EFBE
          D5CACDDCD3FFFFFFFFFFFFFFFFFF1C674B1C674BFFFFFFFFFFFFFFFFFF1C674B
          1C674BFFFFFFFDFEFEFAFCFCEAF1EEBCD3C9C7D8CEF9FBFAFFFFFFFFFFFFFFFF
          FF1C674B1C674BFFFFFF1C674B1C674BFFFFFFFFFFFFFEFFFEFBFCFCE4EDE9BB
          D3CABFD5CAEBF1EEFFFFFFFFFFFFFFFFFFFFFFFF1C674B1C674B1C674BFFFFFF
          FFFFFFFFFFFFFEFFFEFDFEFED1DFD7BED8CFC3DBD2D1DFD8FBFCFCFFFFFFFFFF
          FFFFFFFFFFFFFF1C674BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFECF2EFB9CEC2D4
          D4FDD4D4FDBDD1C6DDE7E1FDFEFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFF1F5F3C3D5CBBFD8CFD4D4FDD4D4FDCAE4DEBBD0C4DBE6E0F7F9
          F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFEFDE7EEEAC2D4CABDD5CAD4D4FDD4
          D4FDD4D4FDD4D4FDD4D4FDBFD5CBC8D9CFDDE7E1E7EEEAEEF3F0EBF1EEE0E9E4
          CCDBD3B7CDC1C3DED4D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDC9E4
          DEC6DED7C3DBD1C5DCD2C4DBD1C2DBD2C7E2DAD4D4FDD4D4FDD4D4FDD4D4FDD4
          D4FD}
        Transparent = True
        OnClick = OpenCloseImageClick
        OnDblClick = OpenCloseImageClick
      end
      object lvMissed: TTntListView
        Left = 28
        Top = 72
        Width = 300
        Height = 51
        Anchors = [akLeft, akTop, akRight, akBottom]
        BorderStyle = bsNone
        Color = clWhite
        Columns = <
          item
            Width = 80
          end
          item
            Width = 100
          end>
        HideSelection = False
        ReadOnly = True
        RowSelect = True
        PopupMenu = PopupMenu2
        ShowColumnHeaders = False
        SmallImages = Form1.ImageList1
        SortType = stData
        TabOrder = 0
        ViewStyle = vsReport
        OnCompare = ListViewCompare
        OnResize = ListViewResize
      end
    end
    object PhoneAddressPanel: TTntPanel
      Left = 0
      Top = 242
      Width = 351
      Height = 257
      Align = alBottom
      BevelOuter = bvNone
      Constraints.MinHeight = 257
      ParentColor = True
      TabOrder = 2
      DesignSize = (
        351
        257)
      object BigImage: TTntImage
        Left = 101
        Top = 7
        Width = 250
        Height = 250
        Anchors = [akRight, akBottom]
      end
      object Label32: TTntLabel
        Left = 8
        Top = 8
        Width = 193
        Height = 34
        Caption = 'Personal Data'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 14346715
        Font.Height = -29
        Font.Name = 'Book Antiqua'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label33: TTntLabel
        Left = 32
        Top = 18
        Width = 97
        Height = 19
        Caption = 'Personal Data'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Image9: TTntImage
        Left = 8
        Top = 52
        Width = 16
        Height = 16
        AutoSize = True
        Picture.Data = {
          07544269746D617036030000424D360300000000000036000000280000001000
          000010000000010018000000000000030000120B0000120B0000000000000000
          0000B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3
          B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FF
          C3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9
          FFC39E8A74492A005D2A1D321000552C20321A115D1B0062433A5731182A0000
          4D24002D0A0D460C00742A22947256B9FFC34A0800FFFFFFFFFFFFFFFFFFFFFF
          FFFDD7CCDFE3C41310008C778DDDE4C3FFF7E9FFFFFFFFFFFFFFFFFF8B4725B9
          FFC34C424BFFFFFF4101004623030B00001D0300A94D517E4E2890695C311803
          5B3E18310000000000D9C51400103EB9FFC36B3B1DFFFFFF0D0000FFFFFFFFFF
          E9FFFFFFFFFAE1381809FAE5DCFBFFF8EACFAAFFE3B85F005DFFFF007F635CB9
          FFC380634DFFFFFF7E482EFFFFFFFFF3FFFFEBC1FFDCC7321C11E14C13FFFFFF
          EEFFFFFFFFFF48210076D3FF250000B9FFC3AD5842FFFFFF713306FFFFFFFFFF
          FFFFD7CDFFFFFF5C2100FFFFFFB70200FFCA8FFFFFFFD8000000FFFF4E8F5EB9
          FFC3A27655FFFFFF852F00FFFFFFFFFFFFFCFFFFA40000956F4D993A05FFFFFF
          FFFFFFFFFFFF964C009C03183F000FB9FFC3A18C70FFFFFFA73600FFFFFFE85D
          00C66325FFFFFF621400FFFFFFB91300FFFFFFFFFFFF770200FFFFFF000000B9
          FFC3AA8A78F0FFF6993F00FFFFFFFFFFFFFFFFFF9F3B02913519FFFFFFFFFFFF
          FFFFFFFFFFFFFF7B3B4042FF4F3000B9FFC3C29D8FF0FFFFB43100FFFFFFE751
          0FCAA48AFFFFFFAF7147DDB882FFFFFFFFE6BEFFFFFFD4562D003AFF00007AB9
          FFC3CAB4A2CA7B27E26F4DFFFFFFFFFFFFF6C39FD7986DB9FFC3A4B4C7FFC882
          FFFFFFFFF4E79E8470C9C444BD8140B9FFC3B9FFC3B9FFC3E6A793D98645C185
          7AB9FFC3B9FFC3B9FFC3B9FFC39DF3FFDD7742B99B82F7815FB9FFC3B9FFC3B9
          FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3
          B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FF
          C3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9FFC3B9
          FFC3}
        Transparent = True
      end
      object Bevel1: TTntBevel
        Left = 8
        Top = 40
        Width = 332
        Height = 9
        Anchors = [akLeft, akTop, akRight]
        Shape = bsTopLine
      end
      object linkNewContact: TTntLabel
        Left = 52
        Top = 111
        Width = 58
        Height = 13
        Cursor = crHandPoint
        Caption = 'New Person'
        Transparent = True
        OnClick = linkNewContactClick
      end
      object linkShowPhonebook: TTntLabel
        Left = 52
        Top = 151
        Width = 58
        Height = 13
        Cursor = crHandPoint
        Caption = 'Phone book'
        Transparent = True
        OnClick = linkShowPhonebookClick
      end
      object wMENum: TTntLabel
        Left = 244
        Top = 52
        Width = 84
        Height = 14
        Alignment = taRightJustify
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = '?'
        Transparent = True
      end
      object Image15: TTntImage
        Left = 328
        Top = 12
        Width = 16
        Height = 16
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Picture.Data = {
          07544269746D617036030000424D360300000000000036000000280000001000
          000010000000010018000000000000030000120B0000120B0000000000000000
          0000D4D4FDD4D4FDD4D4FDD4D4FDB7CFC4BDD1C5C6D8CECBDBD3CBDBD3C6D8CE
          BDD2C7B8D0C5D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDBDD8CEB8CEC1D4E2
          DBE9F1EEF0F6F4F0F6F5EFF5F3EDF3F1E4EDE9D0DFD7BBCFC3BBD5CCD4D4FDD4
          D4FDD4D4FDBFD9D1BACFC3E0EAE5F7FAFAF6F9F8F7FAFAF7FAFAF6F9F8F4F8F7
          F1F6F5EEF4F2D8E5DFBBD0C5BAD7CED4D4FDD4D4FDB9CDC1E3ECE7FBFCFCFBFC
          FCFBFCFCFDFEFEFDFEFEFDFEFEFBFCFCF8FBFAF3F8F7EFF5F3D8E4DEB9D0C3D4
          D4FDBED6CCD3E1D9FDFEFDFEFFFE1C674B1C674BFFFFFFFFFFFFFFFFFF1C674B
          1C674BFAFCFCF4F8F7EDF3F1C9DAD1BBD6CDBCD2C6EEF3F0FFFFFFFFFFFFFFFF
          FF1C674B1C674BFFFFFF1C674B1C674BFFFFFFFDFEFEF9FBFBF3F8F7DDE8E3BA
          D2C9C4D6CCFBFCFCFFFFFFFFFFFFFFFFFFFFFFFF1C674B1C674B1C674BFFFFFF
          FFFFFFFEFFFEFBFCFCF6F9F8E7EFECBCD3C8CCDBD3FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFF1C674BFFFFFFFFFFFFFFFFFFFFFFFFFCFDFDF9FBFBEBF1EFBE
          D5CACDDCD3FFFFFFFFFFFFFFFFFF1C674B1C674BFFFFFFFFFFFFFFFFFF1C674B
          1C674BFFFFFFFDFEFEFAFCFCEAF1EEBCD3C9C7D8CEF9FBFAFFFFFFFFFFFFFFFF
          FF1C674B1C674BFFFFFF1C674B1C674BFFFFFFFFFFFFFEFFFEFBFCFCE4EDE9BB
          D3CABFD5CAEBF1EEFFFFFFFFFFFFFFFFFFFFFFFF1C674B1C674B1C674BFFFFFF
          FFFFFFFFFFFFFEFFFEFDFEFED1DFD7BED8CFC3DBD2D1DFD8FBFCFCFFFFFFFFFF
          FFFFFFFFFFFFFF1C674BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFECF2EFB9CEC2D4
          D4FDD4D4FDBDD1C6DDE7E1FDFEFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFF1F5F3C3D5CBBFD8CFD4D4FDD4D4FDCAE4DEBBD0C4DBE6E0F7F9
          F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFEFDE7EEEAC2D4CABDD5CAD4D4FDD4
          D4FDD4D4FDD4D4FDD4D4FDBFD5CBC8D9CFDDE7E1E7EEEAEEF3F0EBF1EEE0E9E4
          CCDBD3B7CDC1C3DED4D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDC9E4
          DEC6DED7C3DBD1C5DCD2C4DBD1C2DBD2C7E2DAD4D4FDD4D4FDD4D4FDD4D4FDD4
          D4FD}
        Transparent = True
        OnClick = OpenCloseImageClick
        OnDblClick = OpenCloseImageClick
      end
      object linkShowSIM: TTntLabel
        Left = 116
        Top = 151
        Width = 46
        Height = 13
        Cursor = crHandPoint
        Caption = 'SIM book'
        Transparent = True
        OnClick = linkShowSIMClick
      end
      object linkShowCalendar: TTntLabel
        Left = 168
        Top = 151
        Width = 42
        Height = 13
        Cursor = crHandPoint
        Caption = 'Calendar'
        Transparent = True
        OnClick = linkShowCalendarClick
      end
      object linkSyncCalendar: TTntLabel
        Left = 116
        Top = 191
        Width = 42
        Height = 13
        Cursor = crHandPoint
        Caption = 'Calendar'
        Transparent = True
        OnClick = linkSyncCalendarClick
      end
      object linkShowBookmarks: TTntLabel
        Left = 220
        Top = 151
        Width = 53
        Height = 13
        Cursor = crHandPoint
        Caption = 'Bookmarks'
        Transparent = True
        OnClick = linkShowBookmarksClick
      end
      object linkSyncPhonebook: TTntLabel
        Left = 52
        Top = 191
        Width = 58
        Height = 13
        Cursor = crHandPoint
        Caption = 'Phone book'
        Transparent = True
        OnClick = linkSyncPhonebookClick
      end
      object linkNewTask: TTntLabel
        Left = 116
        Top = 111
        Width = 49
        Height = 13
        Cursor = crHandPoint
        Caption = 'New Task'
        Transparent = True
        OnClick = linkNewTaskClick
      end
      object linkSyncOutlook: TTntLabel
        Left = 228
        Top = 191
        Width = 37
        Height = 13
        Cursor = crHandPoint
        Caption = 'Outlook'
        Transparent = True
        OnClick = linkSyncOutlookClick
      end
      object linkNewEvent: TTntLabel
        Left = 168
        Top = 111
        Width = 53
        Height = 13
        Cursor = crHandPoint
        Caption = 'New Event'
        Transparent = True
        OnClick = linkNewEventClick
      end
      object Label30: TTntLabel
        Left = 32
        Top = 52
        Width = 200
        Height = 13
        Caption = 'Number of contacts stored in Phone book:'
      end
      object Label31: TTntLabel
        Left = 32
        Top = 92
        Width = 89
        Height = 13
        Caption = 'Entering new data:'
      end
      object Label34: TTntLabel
        Left = 32
        Top = 132
        Width = 106
        Height = 13
        Caption = 'Exploring current data:'
      end
      object Label36: TTntLabel
        Left = 32
        Top = 172
        Width = 132
        Height = 13
        Caption = 'Synchronize to remote data:'
      end
      object Label37: TTntLabel
        Left = 32
        Top = 72
        Width = 184
        Height = 13
        Caption = 'Number of messages stored in Archive:'
      end
      object wArchiveNum: TTntLabel
        Left = 232
        Top = 72
        Width = 96
        Height = 14
        Alignment = taRightJustify
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = '?'
        Transparent = True
      end
      object Image16: TTntImage
        Left = 8
        Top = 132
        Width = 16
        Height = 16
        AutoSize = True
        Picture.Data = {
          07544269746D617036040000424D360400000000000036000000280000001000
          000010000000010020000000000000040000120B0000120B0000000000000000
          0000BDFFCE00BDFFCE00BDFFCE00BDFFCE00BDFFCE00BDFFCE00BDFFCE00BDFF
          CE00BDFFCE00BDFFCE00BDFFCE00BDFFCE00BDFFCE00BDFFCE00BDFFCE00BDFF
          CE00BDFFCE00BDFFCE00828282006B6B6B006B6B6B006B6B6B006B6B6B006B6B
          6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B0082828200BDFF
          CE00BDFFCE001D82B5001B81B300187EB000167CAE001379AB001076A8000D73
          A5000B71A300086EA000066C9E00046A9C0002689A00016799004B4B4B008282
          82002287BA0067CCFF002085B80099FFFF006FD4FF0058ACD00058ACD00058AC
          D00058ACD00058ACD00058ACD00058ACD0003BA0D30099FFFF00016799006C6C
          6C00258ABD0067CCFF00278CBF0099FFFF00CDBFBB00CDBFBB00CDBFBB00CDBF
          BB00CDBFBB00CDBFBB00CDBFBB00CDBFBB00CDBFBB00CDBFBB0002689A006B6B
          6B00288DC00067CCFF002D92C50099FFFF00CDBFBB00F0EBDD00F0EBDD00F0EB
          DD00F0EBDD00F0EBDD00F0EBDD00F0EBDD00F0EBDD00CDBFBB00046A9C006B6B
          6B002A8FC20067CCFF003398CB0099FFFF00CDBFBB00F0EBDD00F0EBDD00F0EB
          DD00F0EBDD00F0EBDD00F0EBDD00F0EBDD00F0EBDD00CDBFBB00066C9E006B6B
          6B002D92C5006FD4FF003499CC0099FFFF00CDBFBB00F0EBDD00FFDAAE00FFDA
          AE00FFDAAE00FFDAAE00FFDAAE00FFDAAE00F0EBDD00CDBFBB00086EA0006C6C
          6C002F94C7007BE0FF003499CC00FFFFFF00F0EBDD00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F0EBDD000B71A3008282
          82003196C90085EBFF003499CC003499CC00A97A5F00B6BAB000B6BAB000B6BA
          B000B6BAB000B6BAB000B6BAB000B6BAB000B6BAB000A97A5F001B81B300BFBF
          BF003398CB0091F7FF008EF4FF008EF4FF00AD7E6200FFF3E200FFF3E200FFF3
          E200FFF3E200FFF3E200FFF3E200FFF3E200FFF3E200AD7E62006B6B6B00BDFF
          CE003499CC00FFFFFF0099FFFF0099FFFF00B1816600FFF6EA00FFDAB400FFDA
          B400FFDAB400FFDAB400FFDAB400FFDAB400FFF6EA00B18166006C6C6C00BDFF
          CE00BDFFCE003499CC00FFFFFF00FFFFFF00B7876A00FFF9F200FFF9F200FFF9
          F200FFF9F200FFF9F200FFF9F200FFE8CB00FFE8CB00B7876A0082828200BDFF
          CE00BDFFCE00BDFFCE003499CC003398CB00BC8C6D00FFFDFA00FFDAB400FFDA
          B400FFDAB400FFDAB400FFFDFA00FDA73100FDA73100FDA73100BDFFCE00BDFF
          CE00BDFFCE00BDFFCE00BDFFCE00BDFFCE00C0907100FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFB75D00FFB75D00BDFFCE00BDFFCE00BDFF
          CE00BDFFCE00BDFFCE00BDFFCE00BDFFCE00C4947400C4947400C4947400C494
          7400C4947400C4947400C4947400FFB75D00BDFFCE00BDFFCE00BDFFCE00BDFF
          CE00}
        Transparent = True
      end
      object Image17: TTntImage
        Left = 8
        Top = 92
        Width = 16
        Height = 16
        AutoSize = True
        Picture.Data = {
          07544269746D617036030000424D360300000000000036000000280000001000
          000010000000010018000000000000030000C30E0000C30E0000000000000000
          000000FF00525252525252525252525252525252525252525252525252525252
          00FF0000FF0000FF0000FF0000FF0000FF00848684C6C7C6C6C7C6C6C7C6C6C7
          C6C6C7C6C6C7C6C6C7C6C6C7C652525200FF0000FF0000FF0000FF0000FF0000
          FF00848684FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6C7C6525252
          52525252525252525200FF0000FF0000FF00848684FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFC6C7C6525252C6C7C6C6C7C652525200FF0000FF0000
          FF00848684FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6C7C6525252
          FFFFFFC6C7C6525252525252525252525252848684FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFC6C7C6525252FFFFFFC6C7C6525252C6C7C6C6C7C652
          5252848684FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6C7C6525252
          FFFFFFC6C7C6525252FFFFFFC6C7C6525252848684FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFC6C7C6525252FFFFFFC6C7C6525252FFFFFFC6C7C652
          5252848684FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF525252525252525252525252
          FFFFFFC6C7C6525252FFFFFFC6C7C6525252848684FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF848684FFFFFF525252FFFFFFFFFFFFC6C7C6525252FFFFFFC6C7C652
          5252848684D6E6E6D6E6E6D6E6E6D6E6E6D6E6E6848684525252FFFFFF525252
          525252525252525252FFFFFFC6C7C65252528486848486848486848486848486
          84848684848684FFFFFFFFFFFF848684FFFFFF525252FFFFFFFFFFFFC6C7C652
          525200FF0000FF0000FF00848684FFFFFFFFFFFFFFFFFFFFFFFFD6E6E6848684
          525252FFFFFF52525252525252525252525200FF0000FF0000FF008486848486
          84848684848684848684848684848684FFFFFFFFFFFF848684FFFFFF52525200
          FF0000FF0000FF0000FF0000FF0000FF0000FF00848684FFFFFFFFFFFFFFFFFF
          FFFFFFD6E6E684868452525200FF0000FF0000FF0000FF0000FF0000FF0000FF
          0000FF0084868484868484868484868484868484868484868400FF0000FF0000
          FF00}
        Transparent = True
      end
      object Image18: TTntImage
        Left = 8
        Top = 172
        Width = 16
        Height = 16
        AutoSize = True
        Picture.Data = {
          07544269746D617036030000424D360300000000000036000000280000001000
          000010000000010018000000000000030000120B0000120B0000000000000000
          0000D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FD236C23046504046504046504
          689368D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FD347C
          34027902009B0001B70100C40001B7010187012C762CD4D4FDD4D4FDD4D4FDD4
          D4FDD4D4FDD4D4FDD4D4FD185C18046504368636468E462C762C01870101B701
          00D300009B005E915ED4D4FDD4D4FDD4D4FDD4D4FDD4D4FD3686362C762CD4D4
          FDD4D4FDD4D4FDD4D4FDD4D4FD02790200D30000E400018701D4D4FDD4D4FDD4
          D4FDD4D4FDD4D4FD68A268D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FD468E46
          02AC0200FA0002AC0272A972D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4
          FDD4D4FDD4D4FD9DC59D02790202AC0200D30000FA0000E40000C400009B0036
          8636D4D4FDD4D4FDD4D4FDD4D4FD648D64D4D4FDD4D4FDD4D4FD87BE8701B701
          28FE2828FE2828FE2818F81836A936D4D4FDD4D4FDD4D4FDD4D4FD1671160279
          02648D64D4D4FDD4D4FDD4D4FD75B8752AB92A7DFE7C69F96936A936D4D4FDD4
          D4FDD4D4FDD4D4FD2C762C01B70100C400027902759975D4D4FDD4D4FDD4D4FD
          62B56244C74B3CB53FD4D4FDD4D4FDD4D4FDD4D4FD36863600C40000D30000D3
          0000D30001870187AB87D4D4FDD4D4FDD4D4FD66CA68D4D4FDD4D4FDD4D4FDD4
          D4FD347C3401870102AC0200D30000E40000C400009B000465049DBC9DD4D4FD
          D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FD72A97201B70100FA
          0001B701468E46D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FD68A268D4D4FDD4
          D4FDD4D4FDD4D4FDD4D4FD02AC0218F81818F818129A12D4D4FDD4D4FDD4D4FD
          D4D4FDD4D4FD2E8C2E468E46D4D4FDD4D4FDD4D4FDD4D4FDD4D4FD62B56244C7
          4B69F96956F7562AB92A36A9364EB14E4EB14E129A12188C18D4D4FDD4D4FDD4
          D4FDD4D4FDD4D4FDD4D4FDD4D4FD36A93666CA68C0FEBFCEFECBC0FEBF92E991
          44C74B3CB53FD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4
          FD66CA682BB33844C74B44C74B3CB53FD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4
          D4FD}
        Transparent = True
      end
      object Image19: TTntImage
        Left = 8
        Top = 212
        Width = 16
        Height = 16
        AutoSize = True
        Picture.Data = {
          07544269746D617036030000424D360300000000000036000000280000001000
          000010000000010018000000000000030000C30E0000C30E0000000000000000
          000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
          00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF005252525252525252
          5252525252525252525252525252525200000000000000000000FF0000FF0000
          FF0000FF0000FF00848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF525252
          00FFFF00FFFF00828400000000FF0000FF0000FF0000FF00848484FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF525252FFFFFF00FFFF00FFFF52525200FF0000
          FF0000FF0000FF00848484FFFFFF379048379048379048379048379048FFFFFF
          52525252525252525200FF0000FF0000FF0000FF0000FF00848484FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF52525200FF0000FF0000FF0000FF0000
          FF0000FF0000FF00848484FFFFFF379048379048379048379048379048525252
          00000000000000000000FF0000FF0000FF0000FF0000FF00848484FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00828400FFFF00FFFF00828400000000FF0000
          FF0000FF0000FF00848484FFFFFF379048379048379048379048379048FFFFFF
          00828400FFFF00FFFF00828400000000FF0000FF0000FF00848484FFFFFF3790
          48FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF52525200828400FFFF00FFFF00828400
          000000FF0000FF00848484FFFFFFFFFFFFFFFFFF525252525252525252FFFFFF
          52525200FF0000828400FFFF00FFFF00000000FF0000FF008484848484848484
          8484848452525200FFFF00FFFF52525252525200FF0000828400FFFF00FFFF00
          000000FF0000FF0000FF0000FF0000FF0000FF00525252FFFFFF00FFFF00FFFF
          52525252525200FFFF00FFFF00FFFF00000000FF0000FF0000FF0000FF0000FF
          0000FF0000FF00525252FFFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00828452
          525200FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00525252FFFFFF
          FFFFFFFFFFFF00FFFF00828452525200FF0000FF0000FF0000FF0000FF0000FF
          0000FF0000FF0000FF0000FF0052525252525252525252525252525200FF0000
          FF00}
        Transparent = True
      end
      object Label38: TTntLabel
        Left = 32
        Top = 212
        Width = 62
        Height = 13
        Caption = 'What'#39's next?'
      end
      object linkWhatsNext: TTntLabel
        Left = 52
        Top = 231
        Width = 169
        Height = 13
        Cursor = crHandPoint
        Caption = 'Show me current Tasks and Events'
        Transparent = True
        OnClick = linkWhatsNextClick
      end
      object linkShowFiles: TTntLabel
        Left = 280
        Top = 151
        Width = 21
        Height = 13
        Cursor = crHandPoint
        Caption = 'Files'
        Transparent = True
        OnClick = linkShowFilesClick
      end
      object linkNewNote: TTntLabel
        Left = 228
        Top = 111
        Width = 48
        Height = 13
        Cursor = crHandPoint
        Caption = 'New Note'
        Transparent = True
        OnClick = linkNewNoteClick
      end
      object linkSyncBookmarks: TTntLabel
        Left = 168
        Top = 191
        Width = 53
        Height = 13
        Cursor = crHandPoint
        Caption = 'Bookmarks'
        Transparent = True
        OnClick = linkSyncBookmarksClick
      end
      object linkSyncAll: TTntLabel
        Left = 272
        Top = 191
        Width = 38
        Height = 13
        Cursor = crHandPoint
        Caption = 'Sync All'
        Transparent = True
        OnClick = linkSyncAllClick
      end
    end
  end
  object TodayCaptionPanel: TTntPanel
    Left = 0
    Top = 0
    Width = 770
    Height = 72
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    OnResize = TodayCaptionPanelResize
    DesignSize = (
      770
      72)
    object LMDFill2: TLMDFill
      Left = 80
      Top = 0
      Width = 440
      Height = 72
      Align = alRight
      Bevel.Mode = bmCustom
      Caption.Font.Charset = DEFAULT_CHARSET
      Caption.Font.Color = clWindowText
      Caption.Font.Height = -11
      Caption.Font.Name = 'Tahoma'
      Caption.Font.Style = []
      FillObject.Style = sfGradient
      FillObject.Gradient.Color = clWhite
      FillObject.Gradient.ColorCount = 64
      FillObject.Gradient.Style = gstHorizontal
      FillObject.Gradient.EndColor = clBtnFace
      Anchors = [akLeft, akTop, akRight, akBottom]
    end
    object wDate: TTntLabel
      Left = 84
      Top = 40
      Width = 12
      Height = 16
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label9: TTntLabel
      Left = 84
      Top = 12
      Width = 278
      Height = 27
      Caption = 'floAt'#39's Mobile Agent today'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -24
      Font.Name = 'Book Antiqua'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Image1: TTntImage
      Left = 4
      Top = 2
      Width = 66
      Height = 66
      Picture.Data = {
        055449636F6E0000010001004040000001002000284200001600000028000000
        4000000080000000010020000000000000400000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000010000000200000003
        000000070000000A00000010000000170000001D000000250000002D00000031
        00000035000000380000003800000037000000340000002F0000002900000022
        0000001C000000150000000F0000000A00000006000000030000000100000001
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000010000000200000004000000080000000F
        00000017000000230000003000000040000000500000005F0000006C00000075
        0000007B0000007D0000007E0000007C000000760000006E0000006200000054
        0000004500000037000000290000001D000000140000000C0000000700000004
        0000000200000001000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000001000000020000000400000008000000120000001F00000030
        0000004700000063030303810909099C111112B31D1D1DC4282828D1303030D9
        333333DE353535DF333333DD2D2D2ED9242424D2191919C60E0E0EB6060606A5
        020202920000007D000000670000004E0000003700000025000000180000000E
        0000000800000003000000010000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000001000000030000000800000011000000230000003B0000005C05050687
        151515B2303030D44E4E4FEB696969F67C7C7CFC898989FF929292FF989898FF
        9B9B9BFF9C9C9CFF9A9A9AFF969696FF8F8F8FFF838383FE747474FC5D5D5DF6
        414141E9252526D50E0E0EB90303039C0000007F00000062000000420000002A
        000000190000000E000000070000000300000001000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000100000002
        000000050000000E0000001F0000003A010101650E0E0E9D2F2F2FD05B5B5BEF
        7F7F7FFC979797FFA4A4A4FFABABABFFAEAEAEFFAFAFAFFFB0B0B0FFB0B0B0FF
        B0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFAFAFAFFFADADADFFA9A9A9FF
        A0A0A0FF8D8D8DFF707070FB484848ED212121D2070707AD0000008B00000069
        0000004300000027000000150000000B00000004000000020000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000010000000300000009
        000000160000002F0101015A1010109C3C3C3DD9727272F7959595FFA7A7A7FF
        AEAEAEFFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FF
        B0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FF
        B0B0B0FFAFAFAFFFACACACFFA1A1A1FF868686FF5B5B5BF6292929D9080808AE
        000000880000005F000000380000001D0000000F000000060000000200000001
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000001000000030000000B0000001F
        0000004108080982353535CF737374F79A9A9AFFABABABFFB0B0B0FFB0B0B0FF
        B0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FF
        B0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FF
        B0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFAFAFAFFFA6A6A6FF8A8A8AFF595959F5
        202020D1030303A1000000780000004A00000027000000130000000800000003
        0000000100000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000001000000040000000E0000002601010154
        1B1B1BA8606061ED959595FFABABABFFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FF
        B0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB1B1B1FFB3B3B3FFB6B6B6FFB9B9B9FF
        BBBBBBFFBBBBBBFFBBBBBBFFBABABAFFB7B7B7FFB4B4B4FFB2B2B2FFB0B0B0FF
        B0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFAFAFAFFFA4A4A4FF
        808080FE424242EA0C0C0CB90000008A0000005A0000002E0000001600000009
        0000000300000001000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000001000000040000000F0000002C05050566343434C6
        808080F9A6A6A6FFAFAFAFFFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FF
        B0B0B0FFB3B3B3FFB8B8B8FFBFBFBFFFC0C1C0FFB7BAB7FFA8AEA9FF99A299FF
        939E93FF929D93FF939E94FF9BA49BFFAAB1ABFFBABEBAFFC5C6C5FFC6C6C6FF
        BDBDBDFFB5B5B5FFB1B1B1FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FF
        ADADADFF989898FF5F5F5FF71A1A1ACC01010196000000650000003400000018
        0000000900000003000000010000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000001000000030000000F0000002D09090971494949D7919192FD
        ABABABFFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB1B1B1FFB4B4B4FF
        BDBDBDFFB7B9B7FF98A098FF6A7A6AFF3F5840FF244225FF153516FF0D2F0EFF
        0A2D0BFF0A2D0BFF0A2D0BFF0D2F0EFF143515FF214022FF3A543BFF647664FF
        97A198FFBEC1BEFFC6C7C6FFBABABAFFB2B2B2FFB0B0B0FFB0B0B0FFB0B0B0FF
        B0B0B0FFAFAFAFFFA4A4A4FF747474FC292929D90202029E0000006A00000036
        0000001800000009000000030000000100000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000001000000030000000E0000002C0B0B0B73535353DE9A9A9AFFAEAEAEFF
        B0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFB3B3B3FFBABBBAFFA9AEA9FF
        6D7F6EFF304D31FF133314FF0A2C0AFF072B08FF072B08FF072B08FF072B08FF
        072B08FF072B08FF072B08FF072B08FF072B08FF072B08FF072B08FF072B08FF
        0E300FFF2A472BFF677967FFACB3ADFFC7C7C7FFBABABAFFB1B1B1FFB0B0B0FF
        B0B0B0FFB0B0B0FFB0B0B0FFA9A9A9FF7F7F7FFD2F2F2FDD030303A00000006A
        0000003400000016000000080000000200000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000020000000B000000270A0A0A6D565656DD9D9D9DFFAFAFAFFFB0B0B0FF
        B0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFAFB0AFFFA5A7A5FF6E7E6FFF2C4B2DFF
        123713FF113311FF123212FF103010FF0F2F10FF0B2D0CFF072B08FF072B08FF
        072B08FF072B08FF072B08FF072B08FF072B08FF072B08FF072B08FF072B08FF
        072B08FF072B08FF082C09FF1B3A1CFF5D715DFFB1B6B1FFC5C5C5FFB5B5B5FF
        B0B0B0FFB0B0B0FFB0B0B0FFB0B0B0FFABABABFF838383FE303030DE0202029E
        000000650000002E000000130000000600000001000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000001
        00000008000000200707075E525252D69E9E9EFFB0B0B0FFB1B1B1FFB1B1B1FF
        B1B1B1FFB1B1B1FFB1B1B1FFB1B1B1FFADADADFF8F918FFF696F69FF616761FF
        606760FF606660FF606660FF606660FF5C615CFF364737FF092C0AFF072B08FF
        072B08FF072B08FF072B08FF082B09FF092B0AFF0A2B0BFF092B0AFF092B0AFF
        082B09FF072B08FF072B08FF072B08FF082C09FF224123FF7C8B7DFFC3C6C3FF
        BBBCBBFFB2B2B2FFB1B1B1FFB1B1B1FFB1B1B1FFABABABFF818181FD2A2A2AD9
        010101960000005A000000260000000F00000004000000010000000000000000
        0000000000000000000000000000000000000000000000000000000100000004
        000000170303034A414141C19B9B9CFDB0B0B0FFB2B2B2FFB2B2B2FFB2B2B2FF
        B2B2B2FFB2B2B2FFB2B2B2FFB2B2B2FFB1B1B1FFAEAEAEFFABABABFFABABABFF
        ABABABFFABABABFFABABABFFABABABFFA5A5A5FF696F69FF123213FF072B08FF
        072B08FF082B09FF0A2B0BFF0A2B0DFF0A2B0DFF0A2B0CFF0A2B0CFF0A2B0DFF
        0A2B0CFF092B0AFF072B08FF072B08FF072B08FF072B08FF0D300EFF4F6550FF
        B7BCB7FFC0C1C0FFB3B3B3FFB2B2B2FFB2B2B2FFB2B2B2FFABABABFF787878FC
        1C1C1DCC0000008A0000004A0000001D0000000B000000030000000000000000
        000000000000000000000000000000000000000000000000000000020000000D
        000000352828289F929292F9B1B1B1FFB3B3B3FFB3B3B3FFB3B3B3FFB3B3B3FF
        B7B7B7FFBDBDBDFFB8B8B8FFB3B3B3FFB3B3B3FFB3B3B3FFB3B3B3FFB3B3B3FF
        B3B3B3FFB3B3B3FFB3B3B3FFB3B3B3FFB1B1B1FF898B89FF264026FF082E09FF
        082C09FF0A2B0CFF0A2B0DFF092C0CFF092C0BFF092C0BFF092C0BFF092C0BFF
        092B0CFF0A2B0DFF0A2B0BFF072B08FF072B08FF072B08FF072B08FF0A2C0CFF
        375039FFACB2ACFFC3C3C3FFB4B4B4FFB3B3B3FFB3B3B3FFB3B3B3FFA8A8A8FF
        656565F70D0D0DB9000000780000003800000015000000070000000100000000
        0000000000000000000000000000000000000000000000010000000600000022
        101010727B7B7BECB0B0B0FFB5B5B5FFB5B5B5FFB5B5B5FFB5B5B5FFB7B7B7FF
        ACB1ACFF889B88FFC1C2C1FFB5B5B5FFB5B5B5FFB5B5B5FFB5B5B5FFB5B5B5FF
        B5B5B5FFB5B5B5FFB5B5B5FFB5B5B5FFB5B5B5FFA0A0A0FF445645FF0A320BFF
        0C2F0DFF0A2E0DFF092D0CFF092C0AFF082C0AFF082C0AFF082C0AFF082C0AFF
        092C0AFF092C0CFF0A2B0DFF092B0AFF072B08FF072B08FF072B08FF092C0AFF
        0B2C0DFF2F4830FFA8AEA8FFC3C3C3FFB6B6B6FFB5B5B5FFB5B5B5FFB4B4B4FF
        9F9F9FFF494949EA030303A10000005F000000270000000E0000000300000001
        0000000000000000000000000000000000000000000000020000001203030346
        515151CAABABABFFB6B6B6FFB6B6B6FFB6B6B6FFB6B6B6FFB7B7B7FFAEB2AEFF
        4E734FFF2E6130FFB5BBB6FFB9B9B9FFB6B6B6FFB6B6B6FFB6B6B6FFB6B6B6FF
        B6B6B6FFB6B6B6FFB6B6B6FFB6B6B6FFB6B6B6FFAEAEAEFF687068FF143915FF
        0D3410FF0B320EFF0A300CFF092E0BFF082D0AFF082C09FF082C09FF082C09FF
        082C0AFF092C0AFF092B0CFF0B2B0CFF082B09FF072B08FF072B08FF072B09FF
        092B0BFF0B2C0DFF334B33FFAFB5B0FFC1C1C1FFB7B7B7FFB6B6B6FFB6B6B6FF
        B4B4B4FF8A8A8AFE242424D20000008800000043000000190000000800000002
        000000000000000000000000000000000000000100000007000000272121218B
        979797F8B7B7B7FFB8B8B8FFB8B8B8FFB8B8B8FFB8B8B8FFB5B6B5FF618062FF
        145415FF165317FF94A594FFBFBFBFFFB8B8B8FFB8B8B8FFB8B8B8FFB8B8B8FF
        B8B8B8FFB8B8B8FFB8B8B8FFB8B8B8FFB8B8B8FFB6B6B6FF888A88FF274628FF
        0E3911FF0C370FFF0B350DFF0A330CFF09310BFF082E09FF082D09FF082C09FF
        082C0AFF092C0AFF092C0BFF0A2B0DFF092B0AFF072B08FF072B08FF072B08FF
        082B09FF092C0AFF0C2D0DFF405741FFBDC0BDFFBEBEBEFFB8B8B8FFB8B8B8FF
        B8B8B8FFAEAEAEFF646464F5080809AF000000680000002A0000000E00000004
        0000000100000000000000000000000000000002000000110404044B656565D5
        B5B5B5FFBABABAFFBABABAFFBABABAFFBABABAFFB9BAB9FF809481FF1C5B1DFF
        105512FF105312FF628462FFC5C5C5FFBABABAFFBABABAFFBABABAFFBABABAFF
        BABABAFFBABABAFFBABABAFFBABABAFFBABABAFFBABABAFFA1A1A1FF435945FF
        103E13FF0E3C11FF0D3A0FFF0D380EFF0C350DFF0B330CFF0A300BFF0A2E0BFF
        092C0BFF092C0BFF092C0CFF0A2B0DFF0A2B0BFF082C09FF092E0AFF072B08FF
        072B08FF082B08FF0A2C0BFF0B2D0CFF607361FFC7C8C8FFBCBCBCFFBABABAFF
        BABABAFFB9B9B9FF999999FF303030D90000008B000000420000001800000007
        00000001000000000000000000000000000000050000002322222287A0A0A0F8
        BBBBBBFFBCBCBCFFBCBCBCFFBCBCBCFFBCBCBCFFA2AAA3FF326933FF115913FF
        115813FF115613FF366A37FFBDC1BDFFBDBDBDFFBCBCBCFFBCBCBCFFBCBCBCFF
        BCBCBCFFBCBCBCFFBCBCBCFFBCBCBCFFBCBCBCFFBCBCBCFFB1B1B1FF657166FF
        17451BFF114214FF104012FF0F3D11FF0E3B0FFF0D380EFF0C350DFF0B320CFF
        0B2F0CFF0B2D0DFF0B2C0DFF0B2C0EFF0B2C0CFF0A2D0BFF0A2F0AFF072B08FF
        072B08FF092C09FF0A2C0BFF072B08FF143515FF949E94FFC6C7C6FFBCBCBCFF
        BCBCBCFFBCBCBCFFB3B3B3FF6B6B6BF6090909AD00000062000000250000000C
        000000030000000000000000000000010000000D0202023E5D5D5DC8B9B9B9FF
        BEBEBEFFBEBEBEFFBEBEBEFFBEBEBEFFB8B9B8FF5F8360FF155F17FF135C15FF
        135B15FF135A15FF1D5E1EFF9FAFA0FFC3C3C3FFBEBEBEFFBEBEBEFFBEBEBEFF
        BEBEBEFFBEBEBEFFBEBEBEFFBEBEBEFFBEBEBEFFBEBEBEFFBBBBBBFF878B87FF
        28502BFF144717FF134515FF114213FF104011FF0F3D10FF0E3A0FFF0D370EFF
        0D340EFF0C310EFF0D2F0FFF102E13FF0F2D10FF092C0AFF082C08FF082C08FF
        082C08FF0A2C0AFF092B0AFF072B08FF072B08FF385239FFC0C3C0FFC1C1C1FF
        BEBEBEFFBEBEBEFFBDBDBDFF999999FF282828D20000007F0000003700000014
        000000060000000000000000000000030000001713131368979797F0BFBFBFFF
        C0C0C0FFC0C0C0FFC0C0C0FFBFBFBFFF98A499FF276A29FF146116FF146016FF
        156016FF155F16FF155D17FF709170FFC9CAC9FFC0C0C0FFC0C0C0FFC0C0C0FF
        C0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFBFBFBFFFA2A3A2FF
        425F45FF174D1BFF174B19FF164818FF164617FF134315FF103F12FF0F3C11FF
        0F3910FF0E3611FF0F3412FF1B331EFF163117FF0A2D0CFF082C09FF082C08FF
        092C09FF0B2C0BFF082B09FF072B08FF072B08FF0D2F0EFF828F82FFCACACAFF
        C0C0C0FFC0C0C0FFC0C0C0FFB3B3B3FF5A5A5AEE0303039C0000004E0000001D
        0000000A000000000000000000000006000000263A3A3A9DB8B8B8FDC2C2C2FF
        C2C2C2FFC2C2C2FFC2C2C2FFBBBBBBFF5F8560FF176719FF166517FF166418FF
        166317FF176218FF176118FF427843FFC4C8C4FFC3C3C3FFC2C2C2FFC2C2C2FF
        C2C2C2FFC2C2C2FFC2C2C2FFC2C2C2FFC2C2C2FFC2C2C2FFC2C2C2FFB5B5B5FF
        647365FF215325FF225124FF235126FF235326FF214F23FF1A461CFF134115FF
        113E13FF103B13FF113814FF123613FF0E330FFF0C310DFF092F0AFF092E0AFF
        0B2D0BFF092C0AFF082C08FF072B08FF072B08FF072B08FF355036FFC3C5C3FF
        C4C4C4FFC2C2C2FFC2C2C2FFBFBFBFFF898989FB121212B9000000670000002A
        0000000F00000000000000010000000A0202023C6E6E6ECDC4C4C4FFC4C4C4FF
        C4C4C4FFC4C4C4FFC3C3C3FFA4ACA4FF307332FF176A19FF176919FF18681AFF
        18671AFF19661BFF1A661BFF276B28FFABB9ABFFC8C8C8FFC4C4C4FFC4C4C4FF
        C4C4C4FFC4C4C4FFC4C4C4FFC4C4C4FFC4C4C4FFC4C4C4FFC4C4C4FFC0C0C0FF
        878C87FF375C39FF28582CFF285A2DFF275F2AFF265B29FF244E27FF1E4721FF
        154418FF134017FF143D16FF0F3A10FF0D370EFF0D340DFF0C330CFF0C320CFF
        0B2F0CFF082E09FF082D09FF082C08FF082C08FF072B08FF0F3210FF959F95FF
        CBCBCBFFC4C4C4FFC4C4C4FFC4C4C4FFA8A8A8FF303031D50000007D00000037
        000000150000000000000001000000120E0E0E5A9A9A9AEAC7C7C7FFC7C7C7FF
        C7C7C7FFC7C7C7FFC2C2C2FF7D967DFF1D6F1FFF196E1AFF1A6C1BFF1B6C1CFF
        1B6B1CFF1C6C1DFF1C6B1DFF1E6B20FF7FA080FFCECFCEFFC7C7C7FFC7C7C7FF
        C7C7C7FFC7C7C7FFC7C7C7FFC7C7C7FFC7C7C7FFC7C7C7FFC7C7C7FFC6C6C6FF
        A4A5A4FF4A674AFF2E5E30FF305E35FF306036FF2B5B31FF27532AFF264D29FF
        1F4922FF174619FF124313FF103F10FF0F3C10FF0F3A0FFF103810FF0D350EFF
        0A330BFF09310AFF09300AFF082F09FF082E09FF082E09FF082E09FF576C57FF
        CECECEFFC7C7C7FFC7C7C7FFC7C7C7FFBABABAFF575757E90202029200000045
        0000001C00000000000000020000001A2424247AB7B7B7F8C9C9C9FFC9C9C9FF
        C9C9C9FFC9C9C9FFBBBCBBFF538455FF1B721DFF1B711DFF1C701EFF1D711EFF
        1E711FFF1F7120FF1F7120FF207122FF528852FFCCCFCCFFCACACAFFC9C9C9FF
        C9C9C9FFC9C9C9FFC9C9C9FFC9C9C9FFC9C9C9FFC9C9C9FFC9C9C9FFC9C9C9FF
        B9B9B9FF667866FF346434FF39623AFF3E6040FF375C39FF2D582EFF2A542AFF
        244F24FF184C19FF144814FF124513FF124313FF133F13FF113C12FF0C390DFF
        0B370BFF0A350BFF0A330BFF09320AFF093109FF093109FF083009FF29492AFF
        BFC3BFFFCACACAFFC9C9C9FFC9C9C9FFC4C4C4FF7B7B7BF6080808A500000054
        000000220000000000000004000000223F3F3F9BC6C6C6FECBCBCBFFCBCBCBFF
        CBCBCBFFCACACAFFACB1ACFF387C39FF1D761FFF1E7520FF1F7620FF207621FF
        217622FF227623FF237724FF247725FF367D36FFB7C4B7FFCECECEFFCBCBCBFF
        CBCBCBFFCBCBCBFFCBCBCBFFCBCBCBFFCBCBCBFFCBCBCBFFCBCBCBFFCBCBCBFF
        C5C5C5FF888E87FF446C42FF3D6A3BFF3F673DFF386338FF316032FF2A5B2AFF
        275726FF1D531CFF1A501AFF184C18FF164817FF124414FF104011FF0E3D0FFF
        0C3B0DFF0B390CFF0B370BFF0A350BFF0A340BFF09330AFF09330AFF133A13FF
        A2ABA2FFCFCFCFFFCBCBCBFFCBCBCBFFC9C9C9FF979798FC131313B700000062
        0000002900000000000000050000002C5D5D5DB6CFCFCFFFCECECEFFCECECEFF
        CECECEFFCBCBCBFF98A598FF2A7B2CFF1F7A21FF217A22FF227B23FF237B24FF
        247B25FF267C27FF277D28FF287D29FF2C7E2DFF91AF91FFD4D4D4FFCECECEFF
        CECECEFFCECECEFFCECECEFFCECECEFFCECECEFFCECECEFFCECECEFFCECECEFF
        CCCCCCFFA5A6A5FF557355FF427141FF416F40FF426D43FF3F6940FF336332FF
        2E5F2DFF225A22FF1D551EFF185119FF154D16FF134914FF124613FF104310FF
        0D400EFF0C3D0DFF0B3B0CFF0B390CFF0B380CFF0A360BFF0A360BFF0B360CFF
        7E8F7FFFD3D3D3FFCECECEFFCECECEFFCDCDCDFFABABABFE232323C60000006E
        0000002F000000000000000702020234777777C8D2D2D2FFD0D0D0FFD0D0D0FF
        D0D0D0FFCBCBCBFF849B84FF267E27FF237F24FF248025FF268027FF278028FF
        29812AFF2B832CFF2D832EFF2E842FFF308530FF659B66FFD4D6D4FFD0D0D0FF
        D0D0D0FFD0D0D0FFD0D0D0FFD0D0D0FFD0D0D0FFD0D0D0FFD0D0D0FFD0D0D0FF
        D0D0D0FFBCBCBCFF6B7E6BFF477A49FF457746FF417242FF3A6E3AFF346834FF
        286428FF216021FF1C5B1DFF19571AFF175218FF154E16FF144B15FF114812FF
        0F4510FF0E420FFF0D3F0EFF0C3D0DFF0B3B0CFF0B3A0CFF0A390CFF0A380BFF
        5F7860FFD5D5D5FFD0D0D0FFD0D0D0FFD0D0D0FFB9B9B9FF333333D200000076
        0000003400000000000000090404043B8A8A8AD3D4D4D4FFD2D2D2FFD2D2D2FF
        D2D2D2FFC9C9C9FF759476FF29842BFF29852AFF2B852CFF2C862EFF2F8730FF
        318832FF348A34FF368B37FF388C39FF3A8D3AFF4D924EFFC4CEC4FFD4D4D4FF
        D2D2D2FFD2D2D2FFD2D2D2FFD2D2D2FFD2D2D2FFD2D2D2FFD2D2D2FFD2D2D2FF
        D2D2D2FFCBCBCBFF879087FF4C7C4BFF457B44FF40773FFF3B723AFF306E30FF
        266A26FF236523FF1F611FFF1C5D1DFF19581AFF185419FF165117FF124D14FF
        104A11FF0F4710FF0E440FFF0D410EFF0C3F0DFF0C3E0DFF0B3C0DFF0B3B0CFF
        4A694AFFD3D3D3FFD2D2D2FFD2D2D2FFD2D2D2FFC1C1C1FF424243D90000007C
        0000003700000000000000090505053E949494D9D7D7D7FFD5D5D5FFD5D5D5FF
        D5D5D5FFC9C9C9FF6F926FFF348B35FF358C36FF378D38FF3A8E3BFF3D8F3EFF
        3F9040FF419142FF449345FF469447FF489549FF4D954DFFA7BEA7FFDADADAFF
        D5D5D5FFD5D5D5FFD5D5D5FFD5D5D5FFD5D5D5FFD5D5D5FFD5D5D5FFD5D5D5FF
        D5D5D5FFD3D3D3FFA6A8A5FF577D56FF457E44FF407B40FF377736FF2F732FFF
        2A6E2AFF246A25FF206621FF1E621FFF1C5D1DFF1A591BFF185519FF145214FF
        114F12FF104B11FF0F4910FF0E460FFF0D430EFF0D410EFF0C400DFF0C3F0DFF
        3E623FFFD1D2D1FFD5D5D5FFD5D5D5FFD5D5D5FFC7C7C7FF4C4C4CDD0000007E
        0000003800000000000000090606063F999999DCDADADAFFD8D8D8FFD8D8D8FF
        D8D8D8FFC9C9C9FF6E936FFF409140FF429343FF459447FF49954AFF4C974DFF
        4F984FFF519852FF539953FF559956FF579A58FF5A9A59FF87AC87FFD9DAD9FF
        D8D8D8FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8D8FFD8D8D8FF
        D8D8D8FFD7D7D7FFBFBFBFFF668266FF3F813FFF3B7E3BFF377A37FF347634FF
        2F722FFF2A6E2BFF256A26FF216622FF1F6220FF1C5E1DFF195A1AFF155616FF
        135314FF125013FF104D11FF0F4A10FF0E470FFF0D450EFF0D440EFF0D420EFF
        39603AFFD0D2D0FFD8D8D8FFD8D8D8FFD8D8D8FFCBCBCBFF515151DF0000007D
        0000003800000000000000090606063D999999DADCDCDCFFDADADAFFDADADAFF
        DADADAFFCACACAFF759575FF4E984FFF519952FF549B55FF579C58FF5A9D5BFF
        5D9E5EFF739C74FF798E79FF6F8470FF718470FF718571FF8A998AFFD0D1D0FF
        DADADAFFDADADAFFDADADAFFDADADAFFDADADAFFDADADAFFDADADAFFDADADAFF
        DADADAFFDADADAFFD1D1D1FF939A93FF677D67FF647A64FF637963FF617861FF
        5F7660FF5F755FFF5D745EFF556D56FF316532FF1E621FFF1A5E1AFF175B17FF
        155715FF135414FF115113FF114E11FF104B11FF0F4910FF0E470FFF0D460EFF
        3B643CFFD2D4D2FFDADADAFFDADADAFFDADADAFFCDCDCDFF515151DE0000007B
        0000003500000000000000080404043A939393D4DFDFDFFFDDDDDDFFDDDDDDFF
        DDDDDDFFCECECEFF7D987EFF599D5AFF5C9F5DFF60A161FF63A364FF66A467FF
        69A56AFF8AAE8AFFCFD0CFFFC8C8C8FFC7C7C7FFC7C7C7FFCDCDCDFFDADADAFF
        DDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFF
        DDDDDDFFDDDDDDFFDCDCDCFFD3D3D3FFC9C9C9FFC7C7C7FFC7C7C7FFC7C7C7FF
        C7C7C7FFC7C7C7FFC7C7C7FFB3B4B3FF59775AFF226622FF1B621BFF185F19FF
        165B17FF155815FF135614FF125213FF104F12FF0F4D11FF0E4B10FF0E490FFF
        436C44FFD6D8D6FFDDDDDDFFDDDDDDFFDDDDDDFFCECECEFF4B4B4CD900000075
        00000032000000000000000702020233858585C9E2E2E2FFDFDFDFFFDFDFDFFF
        DFDFDFFFD3D3D3FF879C88FF63A264FF67A668FF6AA76BFF6EA96FFF72AA72FF
        77AC77FF84AE84FFD4D9D4FFE0E0E0FFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFF
        DFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFF
        DFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFF
        DFDFDFFFDFDFDFFFDFDFDFFFD5D5D5FF818F82FF2B6A2BFF1F661FFF1A621BFF
        185F18FF165C17FF145915FF135714FF125313FF115112FF104E11FF0F4C10FF
        537854FFDCDDDCFFDFDFDFFFDFDFDFFFDFDFDFFFCECECEFF3F3F3FD10000006C
        0000002D0000000000000005000000296D6D6DB6E4E4E4FFE1E1E1FFE1E1E1FF
        E1E1E1FFD9D9D9FF95A295FF6DA56EFF71AB72FF75AD76FF79AF7AFF7FB17FFF
        83B283FF86B286FFC1CEC1FFE4E4E4FFE1E1E1FFE1E1E1FFE1E1E1FFE1E1E1FF
        E1E1E1FFE1E1E1FFE1E1E1FFE1E1E1FFE1E1E1FFE1E1E1FFE1E1E1FFE1E1E1FF
        E1E1E1FFE1E1E1FFE1E1E1FFE1E1E1FFE1E1E1FFE1E1E1FFE1E1E1FFE1E1E1FF
        E1E1E1FFE1E1E1FFE1E1E1FFDEDEDEFFA6AAA6FF3B703BFF236A23FF1E661FFF
        19631BFF186018FF165D16FF145B15FF135714FF125413FF115212FF105011FF
        6C8C6DFFE1E1E1FFE1E1E1FFE1E1E1FFE1E1E1FFC8C8C8FF2E2E2EC40000005F
        000000250000000000000003000000215050509BE3E3E3FEE4E4E4FFE4E4E4FF
        E4E4E4FFDFDFDFFFA4ABA4FF77A678FF7AB17BFF7FB380FF85B485FF8AB78AFF
        8DB88DFF90B98FFFADC3ACFFE6E7E6FFE4E4E4FFE4E4E4FFE4E4E4FFE4E4E4FF
        E4E4E4FFE4E4E4FFE4E4E4FFE4E4E4FFE4E4E4FFE4E4E4FFE4E4E4FFE4E4E4FF
        E4E4E4FFE4E4E4FFE4E4E4FFE4E4E4FFE4E4E4FFE4E4E4FFE4E4E4FFE4E4E4FF
        E4E4E4FFE4E4E4FFE4E4E4FFE3E3E3FFC5C5C5FF587C58FF266E26FF236B23FF
        1D671EFF19641AFF176118FF155F16FF145B15FF135814FF125613FF145515FF
        90A691FFE4E4E4FFE4E4E4FFE4E4E4FFE3E3E3FFBDBDBDFC1C1C1CB300000050
        0000001D0000000000000002000000183030307AD9D9D9F9E6E6E6FFE6E6E6FF
        E6E6E6FFE5E5E5FFB7B9B7FF80A480FF84B584FF8AB88AFF90BA90FF94BC93FF
        96BE96FF9AC099FFA4C0A4FFE3E6E3FFECECECFFECECECFFECECECFFECECECFF
        EBEBEBFFE8E8E8FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6E6FF
        E6E6E6FFE6E6E6FFE6E6E6FFE6E6E6FFE6E6E6FFE8E8E8FFEBEBEBFFECECECFF
        ECECECFFECECECFFECECECFFECECECFFE2E2E2FF8FA18FFF2D732EFF266F25FF
        226B22FF1C681DFF196519FF176217FF156016FF145C15FF135914FF205F21FF
        B6C2B6FFE6E6E6FFE6E6E6FFE6E6E6FFE4E4E4FFA8A8A8F60D0D0D9C00000040
        0000001700000000000000000000000F15151557C1C1C1EBEAEAEAFFE8E8E8FF
        E8E8E8FFE8E8E8FFCCCCCCFF8AA08AFF8DB98DFF94BD93FF98BF98FF9CC19CFF
        9FC39FFFA3C5A3FFA5C5A5FFB9CBB9FFC2D0C2FFC4D1C3FFC3D1C3FFC4D1C4FF
        C8D2C7FFE8E9E8FFE9E9E9FFE8E8E8FFE8E8E8FFE8E8E8FFE8E8E8FFE8E8E8FF
        E8E8E8FFE8E8E8FFE8E8E8FFE8E8E8FFE5E5E5FFC2C8C1FFA0B79EFF9BB69AFF
        95B494FF8EB18EFF89AE89FF87AC87FF85AA85FF6F9A6FFF317931FF277327FF
        246F25FF216C21FF1B681CFF186519FF166317FF156016FF145D15FF3D723EFF
        D5D9D5FFE8E8E8FFE8E8E8FFE8E8E8FFE4E4E4FF838383EB0404048100000030
        0000000F00000000000000000000000905050538949494CEEDEDEDFFEBEBEBFF
        EBEBEBFFEBEBEBFFDEDEDEFF9AA39AFF93B893FF9BC19BFF9FC49FFFA3C6A3FF
        A7C8A7FFABCAAAFFAECDAEFFB3D0B2FFB7D2B6FFB9D4B9FFBCD5BCFFBED5BDFF
        BBCFBBFFDEE2DEFFECECECFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFF
        EBEBEBFFEBEBEBFFEBEBEBFFEBEBEBFFE4E4E4FFA3AAA2FF739A6EFF689B64FF
        5B9657FF4C904AFF408B3FFF378637FF328232FF2E7E2EFF2B7A2CFF287729FF
        267326FF236F23FF1F6C1FFF1A691AFF176718FF166417FF166117FF719471FF
        E6E7E6FFEBEBEBFFEBEBEBFFEBEBEBFFDFDFDFFF525252D40000006300000023
        0000000A000000000000000000000004000000225757579EEAEAEAFDEDEDEDFF
        EDEDEDFFEDEDEDFFEAEAEAFFB4B6B4FF93AD93FFA2C5A2FFA6C8A6FFAACAAAFF
        AECCAEFFB2CFB1FFB6D2B6FFBCD5BBFFBFD8BFFFC5DAC5FFCBDBCBFFCEDCCEFF
        CAD9CBFFD4DAD4FFEFEFEFFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFF
        EDEDEDFFEDEDEDFFEDEDEDFFEDEDEDFFEBEBEBFFBABBBAFF7D9679FF75A06FFF
        679C63FF599656FF4B914AFF3F8B3EFF368635FF308230FF2D7E2DFF2A7A2AFF
        287728FF257325FF226F22FF1D6C1DFF186A19FF166818FF236A24FFAFBEB0FF
        ECECECFFEDEDEDFFEDEDEDFFEDEDEDFFCBCBCBFC232323B20000004700000017
        000000060000000000000000000000010000001321212166D0D0D0F1F0F0F0FF
        EFEFEFFFEFEFEFFFEFEFEFFFD4D5D4FF96A296FFA5C5A5FFACCBACFFB0CEB0FF
        B4D0B3FFB8D3B8FFBDD6BDFFC2D9C2FFC7DCC7FFD0DED0FFD8E1DAFFDDE2DEFF
        DAE1DBFFD1D8D2FFEDEDEDFFF0F0F0FFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFF
        EFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFDCDCDCFF919890FF7B9D76FF
        73A16DFF649C60FF559653FF489047FF3D8A3CFF348633FF2F812FFF2C7E2CFF
        297A29FF267626FF237224FF206F20FF1A6D1BFF176B19FF528553FFDCDFDCFF
        EFEFEFFFEFEFEFFFEFEFEFFFEDEDEDFF9D9D9DEF08080887000000300000000E
        000000030000000000000000000000000000000A05050537919191C9F3F3F3FF
        F1F1F1FFF1F1F1FFF1F1F1FFEBEBEBFFADAFADFF9FB69FFFB0CEB0FFB5D1B4FF
        B9D3B8FFBDD6BCFFC2D9C2FFC7DCC6FFCDDFCDFFD6E2D7FFE1E5E2FFE6E7E7FF
        E3E5E4FFD8DED8FFDFE2DFFFF3F3F3FFF1F1F1FFF1F1F1FFF1F1F1FFF1F1F1FF
        F1F1F1FFF1F1F1FFF1F1F1FFF1F1F1FFF1F1F1FFEFEFEFFFC9C9C9FF859083FF
        779A72FF6DA069FF5E9A5BFF50944FFF448F44FF3A8A3AFF318432FF2C802DFF
        2B7D2AFF277927FF247525FF227222FF1C701DFF237124FF9FB49FFFEDEDEDFF
        F1F1F1FFF1F1F1FFF1F1F1FFE7E7E7FF535353D00000005C0000001F00000008
        00000002000000000000000000000000000000040000001D3F3F3F85E5E5E5F9
        F4F4F4FFF3F3F3FFF3F3F3FFF3F3F3FFD5D5D5FF99A399FFB0CBB1FFB9D4B9FF
        BDD6BDFFC1D8C1FFC6DCC6FFCBDFCBFFD1E1D1FFD9E4DAFFE2E7E3FFE7E8E7FF
        E4E7E5FFDDE4DDFFD4DAD3FFEDEEEDFFF4F4F4FFF3F3F3FFF3F3F3FFF3F3F3FF
        F3F3F3FFF3F3F3FFF3F3F3FFF3F3F3FFF3F3F3FFF3F3F3FFEFEFEFFFCBCBCBFF
        8E958DFF718D6FFF649562FF579656FF4B924BFF418E41FF388838FF318231FF
        307D30FF2D7A2DFF257926FF237524FF207321FF598C5AFFDBDEDBFFF3F3F3FF
        F3F3F3FFF3F3F3FFF3F3F3FFC3C3C3F71717179D0000003B0000001200000004
        00000001000000000000000000000000000000010000000D0C0C0C45A6A6A6D6
        F6F6F6FFF5F5F5FFF5F5F5FFF5F5F5FFF0F0F0FFB6B8B6FFA1B1A1FFBCD5BCFF
        C1D8C2FFC6DBC7FFCBDFCBFFCFE1CFFFD2E3D2FFD8E5D8FFDEE6DEFFE2E8E2FF
        E1E7E1FFDDE5DCFFDAE1D7FFDADCD7FFF3F4F3FFF6F6F6FFF5F5F5FFF5F5F5FF
        F5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF5F5F5FFF3F3F3FF
        E2E2E2FFBABBBAFF949B94FF7C8D7CFF6F886FFF698769FF6A876AFF728A72FF
        7C8D7DFF5A7D5AFF287B29FF247824FF377C37FFB2C0B2FFF1F1F1FFF5F5F5FF
        F5F5F5FFF5F5F5FFEFEFEFFF6D6D6DD902020265000000230000000800000002
        0000000000000000000000000000000000000000000000050000001F43434389
        E7E7E7F8F7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFE5E5E5FFA2A6A2FFB2C5B2FF
        C5DBC6FFC8DDC9FFCBDFCCFFCFE2CFFFD2E4D3FFD6E5D6FFDAE6D9FFDCE7DCFF
        DEE7DDFFDCE5DBFFDCE4D9FFDBDED7FFDCDEDAFFF5F5F5FFF7F7F7FFF7F7F7FF
        F7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FF
        F7F7F7FFF5F5F5FFEEEEEEFFE4E4E4FFDBDBDBFFD9D9D9FFDCDCDCFFE3E3E3FF
        E4E4E4FF9CA69CFF337C34FF2B7C2BFF85A485FFE8E8E8FFF7F7F7FFF7F7F7FF
        F7F7F7FFF7F7F7FFC8C8C8F71C1C1C9C0000003A000000110000000400000001
        0000000000000000000000000000000000000000000000010000000C0808083E
        969696C9F7F7F7FFF9F9F9FFF9F9F9FFF9F9F9FFF7F7F7FFD5D5D5FF9CA39DFF
        BCD0BDFFC9DECAFFCCE0CDFFD0E2D0FFD3E4D3FFD6E6D6FFD8E7D8FFDBE7DAFF
        DDE7DCFFDDE6DBFFDEE5DBFFDFE3DBFFDBDDD6FFDEDEDBFFF3F3F3FFF9F9F9FF
        F9F9F9FFF9F9F9FFF9F9F9FFF9F9F9FFF9F9F9FFF9F9F9FFF9F9F9FFF9F9F9FF
        F9F9F9FFF9F9F9FFF9F9F9FFF9F9F9FFF9F9F9FFF9F9F9FFF9F9F9FFF9F9F9FF
        F7F7F7FFC9CAC9FF508251FF669467FFD8DBD8FFF7F7F7FFF9F9F9FFF9F9F9FF
        F9F9F9FFF1F1F1FF606060CF010101590000001F000000080000000200000000
        0000000000000000000000000000000000000000000000000000000400000019
        2929296DD2D2D2EEFBFBFBFFFAFAFAFFFAFAFAFFFAFAFAFFF6F6F6FFC7C8C7FF
        9CA49DFFC4D6C4FFCEE1CEFFD0E3D1FFD3E4D3FFD6E6D6FFD9E7D8FFDBE7DAFF
        DDE7DCFFDEE7DCFFDEE5DBFFE0E3DBFFDFE2DAFFDEDFD8FFDBDBD7FFEAEAE9FF
        F9F9F9FFFBFBFBFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFF
        FAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFFFAFAFAFF
        FAFAFAFFE9E9E9FFA1ABA1FFC7CCC7FFF6F6F6FFFAFAFAFFFAFAFAFFFAFAFAFF
        FAFAFAFFACACADEC0E0E0E810000002F0000000E000000030000000100000000
        0000000000000000000000000000000000000000000000000000000000000008
        0101012A5C5C5C9CEEEEEEFBFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFF5F5F5FF
        C2C2C2FFA0A8A0FFC6D7C6FFD2E3D2FFD4E5D4FFD6E6D6FFD8E6D8FFDBE7DAFF
        DCE7DBFFDEE7DCFFDEE6DBFFDFE4DCFFE0E3DCFFE0E2DBFFDFE0DAFFDADAD4FF
        DCDCD8FFEBEBEAFFF8F8F7FFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFF
        FCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFF
        FCFCFCFFFAFAFAFFF1F1F1FFF7F7F7FFFCFCFCFFFCFCFCFFFCFCFCFFFCFCFCFF
        DCDCDCF9303030A8000000410000001600000005000000010000000000000000
        0000000000000000000000000000000000000000000000000000000000000001
        0000000E0909093E8C8C8CC0F8F8F8FEFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFF
        F6F6F6FFC2C3C2FF9EA49EFFC5D3C5FFD4E5D5FFD6E6D7FFD8E6D8FFDBE7DAFF
        DCE7DBFFDDE7DCFFDDE6DCFFDEE5DCFFE0E4DCFFE0E3DCFFDEE1DAFFDDDFD7FF
        DADCD3FFD4D6CFFFD3D5CFFFDCDDD9FFE9EBE8FFF3F4F3FFFAFAFAFFFDFDFDFF
        FDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFF
        FDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFFDFDFDFFF0F0F0FD
        5C5C5CC6020202540000001E0000000800000002000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000040000001417171753ACACACD6FBFBFBFFFEFEFEFFFEFEFEFFFEFEFEFF
        FEFEFEFFF8F8F8FFCCCCCCFF9EA29EFFBBC7BBFFD5E4D6FFD9E7D9FFDBE7DAFF
        DCE7DBFFDDE7DCFFDDE7DCFFDDE6DCFFDEE5DBFFDFE4DBFFDFE2DBFFDCDFD8FF
        DADDD5FFD7DAD2FFD3D6CCFFCBD1C3FFC0CCBBFFBDCAB9FFBECCBBFFC4D1C2FF
        CDD8CCFFD4DED3FFD8E2D8FFDCE5DCFFDCE5DCFFDBE4DBFFE1E7E1FFF9FAFAFF
        FEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFFF7F7F7FF808080D7
        08080866000000250000000B0000000300000001000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000050000001B23232362B9B9B9DCFCFCFCFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFCFCFCFFDEDEDEFFA7A8A7FFA9B0A9FFCED9CDFFDBE7DAFF
        DCE8DBFFDCE8DBFFDDE7DCFFDDE7DCFFDDE5DBFFDCE4DAFFDCE2D9FFDAE0D7FF
        D8DED4FFD4DBCFFFCED7C9FFC7D4C2FFBFD0BBFFB6CBB2FFADC7AAFFA3C1A0FF
        98BC96FF8EB78CFF86B385FF7FAF7FFF79AA79FF7EA27EFFBAC4BAFFF8F8F8FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F9F9FF929293DE0F0F0F71
        0000002C0000000E000000030000000100000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000070000001D27272766B9B9B9DCFCFCFCFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFF0F0F0FFC1C1C1FF9FA29FFFB4BCB3FF
        D2DDD1FFDBE7DBFFDDE8DCFFDCE7DBFFDCE6DAFFDBE5D9FFD9E3D7FFD7E1D4FF
        D3DED1FFD0DBCDFFCBD8C8FFC4D5C1FFBDD1BAFFB5CCB2FFACC8AAFFA3C4A1FF
        99BF97FF8EBA8EFF84B384FF7EA77EFF8FA48FFFC0C4C0FFEEEEEEFFFEFEFEFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F8FF949494DD111111730000002D
        0000000F00000004000000010000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000001000000070000001E23232363ACACACD6F9F9F9FE
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBFFE5E5E5FFB9BAB9FF
        A0A29FFFADB4ADFFC7D1C7FFD6E1D5FFDAE5D9FFD9E5D8FFD8E3D6FFD5E1D3FF
        D2DFD0FFCEDCCCFFC9D9C7FFC2D6C0FFBBD2B9FFB4CEB2FFABC9AAFFA1C3A0FF
        96B895FF8CAA8CFF94A594FFB7BBB7FFE2E2E2FFF9F9F9FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFF4F4F4FD878787D61010106E0000002C0000000F
        0000000400000001000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000001000000070000001B171717538C8C8CC0
        F0F0F0FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBFF
        E9E9E9FFC7C7C7FFA9AAA9FF9FA3A0FFA9AFA8FFB6BFB6FFC0CBC0FFC5D1C4FF
        C6D4C5FFC4D3C2FFBFD0BDFFB8CAB6FFAEC3ADFFA3B8A2FF9AAC99FF98A598FF
        A6ADA6FFC4C5C4FFE5E5E5FFF9F9F9FFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFE4E4E4F9686868C10A0A0A5E000000270000000E00000003
        0000000100000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000000005000000150909093E
        5D5D5D9CD4D4D4EEFCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFEFEFEFFF7F7F7FFE7E7E7FFD1D1D1FFBCBDBCFFAFB0AFFFA7A9A7FF
        A4A6A3FFA2A5A2FFA3A6A3FFA7AAA6FFAEB0AEFFBBBCBBFFCECECEFFE3E3E3FF
        F4F4F4FFFCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FBFBFBFFBEBEBEEC3D3D3D9F03030349000000200000000B0000000300000001
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000040000000E
        0101012A2929296D989898CAEBEBEBF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFFFAFAFAFFF7F7F7FF
        F4F4F4FFF3F3F3FFF3F3F3FFF6F6F6FFF9F9F9FFFCFCFCFFFEFEFEFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFDFDFDFF8
        7A7A7ACA18181872000000340000001600000008000000020000000100000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000001
        00000008000000190808093E44444488A9A9AAD6ECECECF9FEFEFEFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFCFFE3E3E3F8929292D52F2F2F8B
        03030346000000220000000D0000000400000001000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000040000000C0000001F0C0C0C4540404085959595C9D9D9D9F1
        F8F8F8FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFEFEFEFFF4F4F4FDCDCDCDEF818181C82E2E2F870606064B00000027
        0000001200000007000000020000000100000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000001000000050000000D0000001D0505053722222265
        5B5B5B9E9C9C9CCECDCDCDEBEAEAEAF9F9F9F9FEFEFEFEFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFFF6F6F6FEE5E5E6F8
        C5C5C5EA8C8C8CCD4B4B4B9D191919680303033E000000220000001100000007
        0000000300000001000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000001000000040000000900000013
        0000002205050538161616573232327A5454549B767676B6919191C9A3A3A3D4
        ABABABDAAEAEAEDCAAAAAAD9A0A0A0D38C8C8CC86F6F6FB64C4C4C9B2B2B2B7B
        1111115A0303033C00000026000000170000000C000000050000000200000001
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000001
        00000004000000090000000F000000180000002100000029020202330505053A
        0606063D0606063F0606063E0404043B020202340000002C000000220000001A
        000000120000000A000000060000000300000001000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000200000003000000050000000700000008
        0000000900000009000000090000000900000007000000050000000400000002
        0000000100000001000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000FFFFF0000001FFFFFFFFC00000007FFFFFFF000000003FFFFFFE0000
        00000FFFFFF80000000007FFFFF00000000001FFFFE00000000000FFFFC00000
        0000007FFF8000000000003FFF0000000000001FFE0000000000001FFE000000
        0000000FFC00000000000007F800000000000007F800000000000003F0000000
        00000001F000000000000001E000000000000000E000000000000000E0000000
        00000000C000000000000000C000000000000000C00000000000000080000000
        0000000080000000000000008000000000000000800000000000000080000000
        0000000080000000000000008000000000000000800000000000000080000000
        0000000080000000000000008000000000000000800000000000000080000000
        0000000080000000000000008000000000000000C000000000000000C0000000
        00000000C000000000000000C000000000000000E000000000000000E0000000
        00000000E000000000000001F000000000000001F000000000000003F8000000
        00000003FC00000000000007FC0000000000000FFE0000000000000FFF000000
        0000001FFF8000000000003FFF8000000000007FFFC00000000000FFFFF00000
        000001FFFFF80000000003FFFFFC000000000FFFFFFF000000001FFFFFFF8000
        00007FFFFFFFE0000001FFFFFFFFFC00000FFFFFFFFFFFC0007FFFFFFFFFFFFF
        FFFFFFFF}
      Transparent = True
    end
    object SignalImage: TTntImage
      Left = 455
      Top = 20
      Width = 16
      Height = 16
      Anchors = [akTop, akRight]
      AutoSize = True
      Picture.Data = {
        07544269746D617036030000424D360300000000000036000000280000001000
        000010000000010018000000000000030000120B0000120B0000000000000000
        0000D9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FC
        D9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1
        FCD9D1FC000000000000000000D9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9
        D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FC00000000FF00000000D9D1FC
        D9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1
        FCD9D1FC000000000000000000D9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9
        D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FC000000D9D1FCD9D1FC
        D9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1
        FCD9D1FCD9D1FC000000D9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9
        D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FC000000000000000000D9D1FC
        D9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FC0000
        00D9D1FC00000000FF00000000D9D1FC000000D9D1FCD9D1FCD9D1FCD9D1FCD9
        D1FCD9D1FCD9D1FC808080D9D1FC000000D9D1FC000000000000000000D9D1FC
        000000D9D1FC808080D9D1FCD9D1FCD9D1FCD9D1FCD9D1FC808080D9D1FC0000
        00D9D1FCD9D1FCD9D1FCD9D1FCD9D1FC000000D9D1FC808080D9D1FCD9D1FCD9
        D1FCC0C0C0D9D1FC808080D9D1FCD9D1FC000000000000000000000000000000
        D9D1FCD9D1FC808080D9D1FCC0C0C0D9D1FCC0C0C0D9D1FCD9D1FC808080D9D1
        FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FC808080D9D1FCD9D1FCC0C0C0D9
        D1FCD9D1FCC0C0C0D9D1FCD9D1FC808080808080808080808080808080808080
        808080D9D1FCD9D1FCC0C0C0D9D1FCD9D1FCD9D1FCD9D1FCC0C0C0D9D1FCD9D1
        FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCC0C0C0D9D1FCD9D1FCD9
        D1FCD9D1FCD9D1FCD9D1FCC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0D9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1
        FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9D1FCD9
        D1FC}
      Transparent = True
    end
    object wSignal: TTntLabel
      Left = 499
      Top = 22
      Width = 9
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = '...'
      Transparent = True
    end
    object wOperator: TTntLabel
      Left = 499
      Top = 40
      Width = 9
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = '...'
      Transparent = True
    end
    object DiagramPanel: TTntPanel
      Left = 520
      Top = 0
      Width = 250
      Height = 72
      Align = alRight
      BevelInner = bvLowered
      BevelOuter = bvNone
      BorderWidth = 1
      TabOrder = 0
      DesignSize = (
        250
        72)
      object Chart1: TChart
        Left = 4
        Top = 4
        Width = 241
        Height = 64
        AllowPanning = pmNone
        BackWall.Brush.Color = clWhite
        BackWall.Color = clWhite
        BackWall.Pen.Visible = False
        Gradient.Direction = gdLeftRight
        Gradient.EndColor = clNavy
        Gradient.StartColor = clBlack
        LeftWall.Color = clWhite
        MarginBottom = 0
        MarginLeft = 0
        MarginRight = 0
        MarginTop = 0
        Title.AdjustFrame = False
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clGray
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = []
        Title.Text.Strings = (
          'Phone Status Diagram')
        Title.Visible = False
        BackColor = clWhite
        BottomAxis.Visible = False
        Frame.Visible = False
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMaximum = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.Axis.Color = clWhite
        LeftAxis.AxisValuesFormat = '###0.###'
        LeftAxis.Grid.Color = clBlack
        LeftAxis.Grid.Style = psSolid
        LeftAxis.Grid.Visible = False
        LeftAxis.LabelsFont.Charset = DEFAULT_CHARSET
        LeftAxis.LabelsFont.Color = clGray
        LeftAxis.LabelsFont.Height = -7
        LeftAxis.LabelsFont.Name = 'Tahoma'
        LeftAxis.LabelsFont.Style = []
        LeftAxis.LabelsOnAxis = False
        LeftAxis.Maximum = 55.000000000000000000
        LeftAxis.Minimum = -5.000000000000000000
        LeftAxis.MinorTicks.Color = clSilver
        LeftAxis.MinorTicks.SmallDots = True
        LeftAxis.Ticks.Color = clSilver
        LeftAxis.Ticks.SmallDots = True
        LeftAxis.TicksInner.Color = clBlack
        LeftAxis.TicksInner.Visible = False
        LeftAxis.Title.Caption = 'temperature'
        LeftAxis.Title.Font.Charset = DEFAULT_CHARSET
        LeftAxis.Title.Font.Color = clGray
        LeftAxis.Title.Font.Height = -11
        LeftAxis.Title.Font.Name = 'Tahoma'
        LeftAxis.Title.Font.Style = []
        Legend.Color = clSilver
        Legend.Font.Charset = DEFAULT_CHARSET
        Legend.Font.Color = clBlack
        Legend.Font.Height = -8
        Legend.Font.Name = 'Tahoma'
        Legend.Font.Style = []
        Legend.Frame.Color = clGreen
        Legend.HorizMargin = 2
        Legend.TopPos = 7
        Legend.Visible = False
        MaxPointsPerPage = 60
        RightAxis.Automatic = False
        RightAxis.AutomaticMaximum = False
        RightAxis.AutomaticMinimum = False
        RightAxis.Axis.Color = clWhite
        RightAxis.AxisValuesFormat = '###0.###'
        RightAxis.ExactDateTime = False
        RightAxis.Grid.Color = clSilver
        RightAxis.Grid.Style = psSolid
        RightAxis.Grid.SmallDots = True
        RightAxis.LabelsFont.Charset = DEFAULT_CHARSET
        RightAxis.LabelsFont.Color = clGray
        RightAxis.LabelsFont.Height = -7
        RightAxis.LabelsFont.Name = 'Tahoma'
        RightAxis.LabelsFont.Style = []
        RightAxis.LabelsOnAxis = False
        RightAxis.Maximum = 550.000000000000000000
        RightAxis.Minimum = -50.000000000000000000
        RightAxis.MinorTicks.Color = clSilver
        RightAxis.MinorTicks.SmallDots = True
        RightAxis.Ticks.Color = clSilver
        RightAxis.Ticks.Style = psDot
        RightAxis.Ticks.SmallDots = True
        RightAxis.TicksInner.Color = clBlack
        RightAxis.TicksInner.Visible = False
        RightAxis.Title.Caption = 'use, charge'
        RightAxis.Title.Font.Charset = DEFAULT_CHARSET
        RightAxis.Title.Font.Color = clGray
        RightAxis.Title.Font.Height = -11
        RightAxis.Title.Font.Name = 'Tahoma'
        RightAxis.Title.Font.Style = []
        ScaleLastPage = False
        TopAxis.Visible = False
        View3D = False
        View3DWalls = False
        BevelOuter = bvNone
        BorderWidth = 2
        Color = clWindow
        TabOrder = 0
        Anchors = [akLeft, akTop, akRight, akBottom]
        object Series1: TLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = 43690
          Title = 'Temp'
          LinePen.Color = clWhite
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1.000000000000000000
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1.000000000000000000
          YValues.Order = loNone
        end
        object Series3: TLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          SeriesColor = 170
          Title = 'Charge'
          LinePen.Color = clWhite
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1.000000000000000000
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1.000000000000000000
          YValues.Order = loNone
        end
        object Series2: TLineSeries
          Marks.Arrow.Color = clGreen
          Marks.ArrowLength = 8
          Marks.Frame.Color = clWhite
          Marks.Visible = False
          SeriesColor = 38144
          Title = 'Usage'
          VertAxis = aRightAxis
          LinePen.Color = clWhite
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1.000000000000000000
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1.000000000000000000
          YValues.Order = loNone
        end
      end
    end
  end
  object PopupMenu2: TTntPopupMenu
    Images = Form1.ImageList2
    OnPopup = PopupMenu2Popup
    Left = 152
    Top = 248
    object MessageContact1: TTntMenuItem
      Action = Form1.ActionContactsNewMsg
    end
    object CallContact1: TTntMenuItem
      Action = Form1.ActionContactsVoiceCall
    end
    object ChatContact1: TTntMenuItem
      Action = Form1.ActionContactsNewChat
    end
    object N1: TTntMenuItem
      Caption = '-'
    end
    object AddToPhonebook1: TTntMenuItem
      Action = Form1.ActionContactsAddContact
    end
    object N2: TTntMenuItem
      Caption = '-'
    end
    object Refresh1: TTntMenuItem
      Caption = 'Refresh'
      ImageIndex = 1
      OnClick = Refresh1Click
    end
    object N3: TTntMenuItem
      Caption = '-'
    end
    object Properties1: TTntMenuItem
      Caption = 'Properties'
      ImageIndex = 10
      OnClick = Properties1Click
    end
  end
  object ImageList1: TImageList
    Left = 184
    Top = 248
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000B7CFC400BDD1C500C6D8CE00CBDBD300CBDBD300C6D8CE00BDD2C700B8D0
      C500000000000000000000000000000000000000000000000000000000000000
      0000B7CFC400BDD1C500C6D8CE00CBDBD300CBDBD300C6D8CE00BDD2C700B8D0
      C500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDD8CE00B8CE
      C100D4E2DB00E9F1EE00F0F6F400F0F6F500EFF5F300EDF3F100E4EDE900D0DF
      D700BBCFC300BBD5CC0000000000000000000000000000000000BDD8CE00B8CE
      C100D4E2DB00E9F1EE00F0F6F400F0F6F500EFF5F300EDF3F100E4EDE900D0DF
      D700BBCFC300BBD5CC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BFD9D100BACFC300E0EA
      E500F7FAFA00F6F9F800F7FAFA00F7FAFA00F6F9F800F4F8F700F1F6F500EEF4
      F200D8E5DF00BBD0C500BAD7CE000000000000000000BFD9D100BACFC300E0EA
      E500F7FAFA00F6F9F800F7FAFA00F7FAFA00F6F9F800F4F8F700F1F6F500EEF4
      F200D8E5DF00BBD0C500BAD7CE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B9CDC100E3ECE700FBFC
      FC00FBFCFC00FBFCFC00FDFEFE00FDFEFE00FDFEFE00FBFCFC00F8FBFA00F3F8
      F700EFF5F300D8E4DE00B9D0C3000000000000000000B9CDC100E3ECE700FBFC
      FC00FBFCFC00FBFCFC00FDFEFE001C674B00FDFEFE00FBFCFC00F8FBFA00F3F8
      F700EFF5F300D8E4DE00B9D0C300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BED6CC00D3E1D900FDFEFD00FEFF
      FE001C674B001C674B00FFFFFF00FFFFFF00FFFFFF001C674B001C674B00FAFC
      FC00F4F8F700EDF3F100C9DAD100BBD6CD00BED6CC00D3E1D900FDFEFD00FEFF
      FE00FEFFFE00FFFFFF001C674B001C674B001C674B00FFFFFF00FDFEFE00FAFC
      FC00F4F8F700EDF3F100C9DAD100BBD6CD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BCD2C600EEF3F000FFFFFF00FFFF
      FF00FFFFFF001C674B001C674B00FFFFFF001C674B001C674B00FFFFFF00FDFE
      FE00F9FBFB00F3F8F700DDE8E300BAD2C900BCD2C600EEF3F000FFFFFF00FFFF
      FF00FFFFFF001C674B001C674B00FFFFFF001C674B001C674B00FFFFFF00FDFE
      FE00F9FBFB00F3F8F700DDE8E300BAD2C9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C4D6CC00FBFCFC00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF001C674B001C674B001C674B00FFFFFF00FFFFFF00FEFF
      FE00FBFCFC00F6F9F800E7EFEC00BCD3C800C4D6CC00FBFCFC00FFFFFF00FFFF
      FF001C674B001C674B00FFFFFF00FFFFFF00FFFFFF001C674B001C674B00FEFF
      FE00FBFCFC00F6F9F800E7EFEC00BCD3C8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CCDBD300FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF001C674B00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FCFDFD00F9FBFB00EBF1EF00BED5CA00CCDBD300FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF001C674B00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FCFDFD00F9FBFB00EBF1EF00BED5CA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CDDCD300FFFFFF00FFFFFF00FFFF
      FF001C674B001C674B00FFFFFF00FFFFFF00FFFFFF001C674B001C674B00FFFF
      FF00FDFEFE00FAFCFC00EAF1EE00BCD3C900CDDCD300FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF001C674B001C674B001C674B00FFFFFF00FFFFFF00FFFF
      FF00FDFEFE00FAFCFC00EAF1EE00BCD3C9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C7D8CE00F9FBFA00FFFFFF00FFFF
      FF00FFFFFF001C674B001C674B00FFFFFF001C674B001C674B00FFFFFF00FFFF
      FF00FEFFFE00FBFCFC00E4EDE900BBD3CA00C7D8CE00F9FBFA00FFFFFF00FFFF
      FF00FFFFFF001C674B001C674B00FFFFFF001C674B001C674B00FFFFFF00FFFF
      FF00FEFFFE00FBFCFC00E4EDE900BBD3CA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BFD5CA00EBF1EE00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF001C674B001C674B001C674B00FFFFFF00FFFFFF00FFFF
      FF00FEFFFE00FDFEFE00D1DFD700BED8CF00BFD5CA00EBF1EE00FFFFFF00FFFF
      FF001C674B001C674B00FFFFFF00FFFFFF00FFFFFF001C674B001C674B00FFFF
      FF00FEFFFE00FDFEFE00D1DFD700BED8CF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C3DBD200D1DFD800FBFCFC00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF001C674B00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00ECF2EF00B9CEC20000000000C3DBD200D1DFD800FBFCFC00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00ECF2EF00B9CEC200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDD1C600DDE7E100FDFE
      FD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F1F5F300C3D5CB00BFD8CF000000000000000000BDD1C600DDE7E100FDFE
      FD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F1F5F300C3D5CB00BFD8CF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CAE4DE00BBD0C400DBE6
      E000F7F9F800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFEFD00E7EE
      EA00C2D4CA00BDD5CA00000000000000000000000000CAE4DE00BBD0C400DBE6
      E000F7F9F800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFEFD00E7EE
      EA00C2D4CA00BDD5CA0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BFD5
      CB00C8D9CF00DDE7E100E7EEEA00EEF3F000EBF1EE00E0E9E400CCDBD300B7CD
      C100C3DED400000000000000000000000000000000000000000000000000BFD5
      CB00C8D9CF00DDE7E100E7EEEA00EEF3F000EBF1EE00E0E9E400CCDBD300B7CD
      C100C3DED4000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C9E4DE00C6DED700C3DBD100C5DCD200C4DBD100C2DBD200C7E2DA000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C9E4DE00C6DED700C3DBD100C5DCD200C4DBD100C2DBD200C7E2DA000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00F00FF00F00000000C003C00300000000
      8001800100000000800180010000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000100010000000080018001000000008003800300000000
      E007E00700000000F01FF01F0000000000000000000000000000000000000000
      000000000000}
  end
end
