object frmEditContact: TfrmEditContact
  Left = 600
  Top = 183
  BorderStyle = bsDialog
  Caption = 'Contact'
  ClientHeight = 471
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
    Height = 425
    ActivePage = tsGeneral
    MultiLine = True
    TabOrder = 0
    OnChange = PageControl1Change
    object tsGeneral: TTntTabSheet
      Caption = 'General'
      object TntImage: TTntImage
        Left = 8
        Top = 12
        Width = 32
        Height = 32
        Picture.Data = {
          055449636F6E0000010001002020000001002000A81000001600000028000000
          2000000040000000010020000000000000100000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000010000000100000001000000020000000200000002
          0000000200000002000000020000000200000002000000020000000200000002
          0000000200000002000000020000000200000002000000020000000200000002
          0000000200000002000000020000000200000002000000020000000100000001
          0000000100000001000000020000000400000005000000060000000600000006
          0000000600000006000000060000000600000006000000060000000600000006
          0000000600000006000000060000000600000006000000060000000600000006
          0000000600000006000000060000000600000006000000060000000500000004
          0000000200000001000000040000003600000038000000390000003900000039
          0000003900000039000000390000003900000039000000390000003900000039
          0000003900000039000000390000003900000039000000390000003900000039
          0000003900000039000000390000003900000039000000390000003800000037
          0000000400000002BAA596FF87715EFF79624DFF6A533CFF604830FF604830FF
          604830FF604830FF604830FF604830FF604830FF604830FF604830FF604830FF
          604830FF604830FF604830FF604830FF604830FF604830FF604830FF604830FF
          604830FF604830FF604830FF604830FF604830FF604830FF604830FF0000003A
          0000000500000002BAA596FFFFF6F1FFEEDDD3FFEEDACEFFEED7C8FFEFD2C1FF
          EFCEB9FFF0CAB2FFF0C5AAFFF1C0A2FFF1BB99FFF2B691FFF2B691FFF2B691FF
          F2B691FFF2B691FFF2B289FFF3AD82FFF3A97AFFF4A574FFF4A16DFFF4A16DFF
          F4A16DFFF4A16DFFF59E68FFF59C64FFF59A61FFF59A61FF604830FF0000003B
          0000000600000002BBA697FFFFFFFFFFFFFFFEFFFFFDFDFFFFFCFBFFFFFBF8FF
          FFFAF7FFFFF7F4FFFFF6F1FFFFF4EEFFFFF2EBFFFFF1E8FFFFEFE5FFFFEDE2FF
          FFEBDEFFFFE8DBFFFFE7D8FFFFE4D5FFFFE2D1FFFFE0CDFFFFDECAFFFFDCC7FF
          FFDAC4FFFFD8C2FFFFD6BEFFFFD5BCFFFFD3B9FFF59A61FF604830FF0000003B
          0000000600000002BCA899FFFFFFFFFFFFFFFFFFFFFFFEFFD4E0E1FF6C967AFF
          2F8B4BFF209444FF228340FF256E3BFF285C38FF294834FF6D6C6DFFD5C8C1FF
          FFEEE5FFFFEADDFFFFE8DAFFFFE6D7FFFFE4D4FFFFE1D0FFFFE0CDFFFFDEC9FF
          FFDBC7FFFFD9C4FFFFD8C1FFFFD6BDFFFFD4BBFFF59D66FF604830FF0000003B
          0000000600000002BEAA9BFFFFFFFFFFFFFFFFFFBAE4C8FF24A649FF2EAB54FF
          37BC5DFF39BB55FF149028FF1CAE36FF2AAC49FF2F994EFF2A5735FF45464AFF
          E5DAD3FFFFECE0FFFFEADDFFB9927DFFB38B75FFAE846EFFA97D66FFA97D66FF
          A97D66FFA97D66FFA47860FFA1745CFFFFD6BDFFF4A16DFF604830FF0000003B
          0000000600000002C0AC9DFFFFFFFFFFFFFFFFFF2CAB55FF61DD80FF63E282FF
          5BDF7BFF54DB77FF169C2FFF40C45FFF42CD67FF36C25CFF29B951FF235730FF
          6B6C6DFFFFEDE3FFFFEBDFFFFFEADEFFFFE9DBFFFFE6D8FFFFE4D4FFFFE3D2FF
          FFE1CEFFFFDECAFFFFDDC7FFFFDAC5FFFFD7C0FFF4A574FF604830FF0000003B
          0000000600000002C2AE9FFFFFFFFFFFFFFFFFFF24B253FF72EA8CFF6DE789FF
          66E383FF1CAF35FF16862CFF54DB77FF51D874FF47D26CFF3CC863FF1C7A2BFF
          777978FFFFEFE6FFFFEDE2FFB9927DFFB38B75FFAE846EFFA97D66FFA97D66FF
          A97D66FFA97D66FFA47860FFA1745CFFFFD8C1FFF3AB7DFF604830FF0000003B
          0000000600000002C4B0A1FFFFFFFFFFFFFFFFFF1AB84EFF5BDD7DFF75EB8FFF
          27BF4EFF138424FFD2DCD1FF2D9C42FF4DD16EFF54DB77FF4DD670FF196526FF
          A2A09DFFFFF1E8FFFFEEE4FFFFEEE4FFFFECE1FFFFEADEFFFFE8DAFFFFE5D6FF
          FFE4D3FFFFE2D0FFFFE0CDFFFFDDC9FFFFDAC3FFF3B087FF604830FF0000003B
          0000000600000002C6B2A4FFFFFFFFFFFFFFFFFFC0EBCCFF1AB74EFF5FDE7FFF
          1AB336FFD7DED5FFDBE3DAFFB7CFB6FF1B9D34FF54DB77FF54DB77FF81817EFF
          F8EDE7FFFFF2EAFFFFF0E7FFB9927DFFB38B75FFAE846EFFA97D66FFA97D66FF
          A97D66FFA97D66FFA47860FFA1745CFFFFDBC6FFF2B691FF604830FF0000003B
          0000000600000002C7B4A6FFFFFFFFFFFFFFFFFFFFFFFFFFB0E7C0FF1AB74EFF
          159229FF747675FF5D5D5DFF5B5C5BFF387542FF55D777FF31BC4DFFFFF7F2FF
          FFF5EFFFFFF3EDFFFFF2EAFFFFF1E9FFFFEFE5FFFFEDE3FFFFEBDFFFFFE9DCFF
          FFE7D8FFFFE4D5FFFFE3D1FFFFE0CFFFFFDCC9FFF1BD9CFF604830FF0000003B
          0000000600000002C7B4A6FFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFAFFB1AFB0FF
          4C4B4AFF818181FF909090FF818181FF666666FF82817FFFEEEAEBFFFFF8F4FF
          FFF7F2FFFFF4EFFFFFF3ECFFFFF1E9FFFFEFE5FFFFEDE3FFFFEBDFFFFFE9DCFF
          FFE7D8FFFFE4D5FFFFE3D1FFFFE0CFFFFFDECBFFF1BD9CFF604830FF0000003B
          0000000600000002C7B4A6FFFFFFFFFFFFFFFFFFFFFFFFFFB9B8B6FF65625FFF
          242323FFA3A3A3FFA7A7A7FFA4A4A4FF999999FF696968FFBAB5B6FFFFFAF5FF
          FFF8F4FFFFF6F1FFFFF4EFFFFFF2EBFFFFF1E8FFFFEEE5FFFFECE1FFFFEBDEFF
          FFE9DBFFFFE6D7FFFFE4D4FFFFE2D1FFFFE0CEFFF1BD9CFF604830FF0000003B
          0000000600000002C7B4A6FFFFFFFFFFFFFFFFFFFFFFFFFF7C7A7AFF3C3B3AFF
          333333FFB8B8B8FFBDBDBDFFB9B9B9FFA9A9A9FF878686FF878483FFFFFBF8FF
          FFF9F6FFFFF7F3FFFFF6F0FFFFF4EEFFFFF2EAFFFFF0E8FFFFEFE5FFFFEDE1FF
          FFEADEFFFFE8DAFFFFE6D7FFFFE3D3FFFFE2D0FFF1BD9CFF604830FF0000003B
          0000000600000002C7B4A6FFFFFFFFFFFFFFFFFFFFFFFFFF696562FF515050FF
          4A4A4AFFC2C2C2FFCDCDCDFFC6C6C6FFB4B4B4FF9B9B9BFF686867FFFFFCFAFF
          FFFAF8FFFFF9F5FFFFF7F3FFFBB488FFFAAF83FFF9AA7EFFF8A578FFF8A578FF
          F8A578FFF8A578FFF7A073FFF69D70FFFFE3D3FFF1BD9CFF604830FF0000003B
          0000000600000002C7B4A6FFFFFFFFFFFFFFFFFFFFFFFFFF7F7A76FF787674FF
          686868FFA3A3A2FFCACACAFFC7C7C7FFB5B5B5FF9A9999FF787776FFFFFDFBFF
          FFFCF9FFFFFAF7FFFFF8F5FFFFF7F2FFFFF5EFFFFFF3EDFFFFF1E9FFFFEFE6FF
          FFEDE3FFFFEBDFFFFFE9DCFFFFE7D9FFFFE5D5FFF1BD9CFF604830FF0000003B
          0000000600000002C9B6A8FFFFFFFFFFFFFFFFFFFFFFFFFF8B8583FF9F9B98FF
          807F7CFF606060FF505050FF474645FF727170FF949494FF827F7DFFFFFEFDFF
          FFFDFBFFFFFBF9FFFFFAF7FFFBB488FFFAAF83FFF9AA7EFFF8A578FFF8A578FF
          F8A578FFF8A578FFF7A073FFF69D70FFFFE7D8FFF0C3A6FF604830FF0000003B
          0000000600000002CBB8AAFFFFFFFFFFFFFFFFFFFFFFFFFFD3D2D2FF747372FF
          B3B2B2FFA19F9EFF918F8EFF999692FF5D5C5BFF525253FF939292FFFFFFFEFF
          FFFEFDFFFFFCFAFFFFFBF8FFFFFAF6FFFFF8F4FFFFF6F1FFFFF4EEFFFFF2EBFF
          FFF0E8FFFFEEE4FFFFEDE2FFFFEADEFFFFE8DBFFF0C9B1FF664E37FF0000003B
          0000000600000002CDBAACFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDFFB3B3B3FF
          7F7E7CFFB2AFAEFFAEAAA8FFB5AFABFF8C8987FF838282FFD3D2D2FFFFFFFFFF
          FFFEFEFFFFFDFCFFFFFCFAFFFFFAF8FFFFF9F5FFFFF7F3FFFFF6F0FFFFF4EDFF
          FFF2EAFFFFF0E7FFFFEEE4FFFFECE1FFFFEADEFFEFCFBAFF6F5741FF0000003B
          0000000600000002CFBCAEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBFF
          E8E8E7FFA7A4A3FF818181FF818180FF929291FFD3D2D2FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFEFEFFFFFDFCFFFFFBF9FFFFFAF7FFFFF8F5FFFFF7F2FFFFF6EFFF
          FFF4ECFFFFF2E9FFFFF0E7FFFFEEE3FFFFEBE0FFEFD4C4FF79624DFF0000003B
          0000000600000002D0BEB0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFEFFFFFEFDFFFFFDFBFFFFFBF9FFFFFAF7FFFFF9F4FFFFF7F1FF
          FFF5EFFFFFF3ECFFFFF1E9FFFFEFE5FFFFEDE3FFEED9CCFF826D59FF0000003A
          0000000500000001D1BFB1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFDFCFFFFFCFBFFFFFBF8FFFFF9F6FFFFF8F4FF
          FFF6F2FFFFF4EEFFFFF2EBFFFFF1E8FFFFEFE5FFFFF7F2FF8B7663FF00000037
          0000000400000001D2C0B2FFD1BFB1FFD0BEB0FFCFBDAFFFCEBBADFFCCBAACFF
          CBB8AAFFC9B7A8FFC8B5A6FFC6B3A4FFC4B1A2FFC3AFA1FFC3AFA1FFC3AFA1FF
          C3AFA1FFC3AFA1FFC1AD9FFFBFAB9DFFBEA99BFFBCA899FFBBA697FFBBA697FF
          BBA697FFBBA697FFB9A596FFB8A394FFB7A293FFB6A192FFB5A091FF00000004
          0000000200000000000000010000000100000001000000020000000200000002
          0000000200000002000000020000000200000002000000020000000200000002
          0000000200000002000000020000000200000002000000020000000200000002
          0000000200000002000000020000000200000002000000020000000100000001
          0000000100000000000000000000000000000000000000000000000000000000
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
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000FFFFFFFFFFFFFFFF8000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000080000000FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF}
        Transparent = True
      end
      object Bevel1: TTntBevel
        Left = 8
        Top = 56
        Width = 341
        Height = 9
        Shape = bsTopLine
      end
      object Label1: TTntLabel
        Left = 8
        Top = 108
        Width = 23
        Height = 13
        Caption = 'Title:'
      end
      object Label2: TTntLabel
        Left = 8
        Top = 76
        Width = 48
        Height = 13
        Caption = 'Full name:'
      end
      object Label4: TTntLabel
        Left = 8
        Top = 140
        Width = 62
        Height = 13
        Caption = 'Organization:'
      end
      object Label5: TTntLabel
        Left = 8
        Top = 172
        Width = 41
        Height = 13
        Caption = 'Birthday:'
      end
      object Bevel2: TTntBevel
        Left = 8
        Top = 204
        Width = 341
        Height = 9
        Shape = bsTopLine
      end
      object Label6: TTntLabel
        Left = 8
        Top = 224
        Width = 64
        Height = 13
        Caption = 'Home phone:'
      end
      object Label7: TTntLabel
        Left = 8
        Top = 256
        Width = 62
        Height = 13
        Caption = 'Work phone:'
      end
      object Label8: TTntLabel
        Left = 8
        Top = 288
        Width = 67
        Height = 13
        Caption = 'Mobile phone:'
      end
      object Label9: TTntLabel
        Left = 8
        Top = 320
        Width = 58
        Height = 13
        Caption = 'Fax number:'
      end
      object Label10: TTntLabel
        Left = 8
        Top = 352
        Width = 29
        Height = 13
        Caption = 'Other:'
      end
      object txtTitle: TTntEdit
        Left = 96
        Top = 104
        Width = 253
        Height = 21
        MaxLength = 15
        TabOrder = 2
        OnChange = txtChangeEditAs
        OnEnter = OnChangeAsEnter
      end
      object txtName: TTntEdit
        Left = 96
        Top = 72
        Width = 253
        Height = 21
        MaxLength = 30
        TabOrder = 1
        OnChange = txtChangeEditAs
        OnEnter = OnChangeAsEnter
      end
      object txtOrganization: TTntEdit
        Left = 96
        Top = 136
        Width = 253
        Height = 21
        MaxLength = 15
        TabOrder = 3
        OnChange = txtChangeEditAs
        OnEnter = OnChangeAsEnter
      end
      object txtHome: TTntEdit
        Left = 96
        Top = 220
        Width = 253
        Height = 21
        MaxLength = 40
        TabOrder = 6
        OnChange = txtPhoneChange
        OnEnter = txtPhoneEnter
        OnKeyPress = txtTelKeyPress
      end
      object txtWork: TTntEdit
        Left = 96
        Top = 252
        Width = 253
        Height = 21
        MaxLength = 40
        TabOrder = 7
        OnChange = txtPhoneChange
        OnEnter = txtPhoneEnter
        OnKeyPress = txtTelKeyPress
      end
      object txtCell: TTntEdit
        Left = 96
        Top = 284
        Width = 253
        Height = 21
        MaxLength = 40
        TabOrder = 8
        OnChange = txtPhoneChange
        OnEnter = txtPhoneEnter
        OnKeyPress = txtTelKeyPress
      end
      object txtFax: TTntEdit
        Left = 96
        Top = 316
        Width = 253
        Height = 21
        MaxLength = 40
        TabOrder = 9
        OnChange = txtPhoneChange
        OnEnter = txtPhoneEnter
        OnKeyPress = txtTelKeyPress
      end
      object txtOther: TTntEdit
        Left = 96
        Top = 348
        Width = 177
        Height = 21
        MaxLength = 40
        TabOrder = 10
        OnChange = txtPhoneChange
        OnEnter = txtPhoneEnter
        OnKeyPress = txtTelKeyPress
      end
      object txtDisplayAs: TTntComboBox
        Left = 96
        Top = 20
        Width = 253
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        OnChange = txtDisplayAsChange
      end
      object txtBirthday: TTntDateTimePicker
        Left = 96
        Top = 168
        Width = 177
        Height = 21
        Date = 39015.646253206020000000
        Time = 39015.646253206020000000
        DateMode = dmUpDown
        TabOrder = 4
        OnChange = txtBirthdayChange
      end
      object BirthdayDeleteButton: TTntButton
        Left = 280
        Top = 168
        Width = 69
        Height = 25
        Caption = '&Remove'
        TabOrder = 5
        OnClick = BirthdayDeleteButtonClick
      end
      object NumbersHistoryButton: TTntButton
        Left = 280
        Top = 348
        Width = 69
        Height = 25
        Caption = '&History'
        TabOrder = 11
        OnClick = NumbersHistoryButtonClick
      end
    end
    object TabSheet2: TTntTabSheet
      Caption = 'Personalize'
      ImageIndex = 1
      object GroupBox1: TTntGroupBox
        Left = 8
        Top = 8
        Width = 345
        Height = 193
        Caption = 'Picture'
        TabOrder = 0
        object Label12: TTntLabel
          Left = 156
          Top = 20
          Width = 90
          Height = 13
          Caption = 'Picture information:'
        end
        object Label13: TTntLabel
          Left = 156
          Top = 72
          Width = 31
          Height = 13
          Caption = 'Name:'
        end
        object lblPicDim: TTntLabel
          Left = 180
          Top = 48
          Width = 153
          Height = 13
          AutoSize = False
        end
        object Label15: TTntLabel
          Left = 156
          Top = 96
          Width = 23
          Height = 13
          Caption = 'Size:'
        end
        object imgDim: TTntImage
          Left = 156
          Top = 46
          Width = 16
          Height = 16
          AutoSize = True
          Picture.Data = {
            07544269746D6170F6000000424DF60000000000000076000000280000001000
            0000100000000100040000000000800000000000000000000000100000000000
            0000000000000000800000800000008080008000000080008000808000008080
            8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
            FF00300000303030303033303333333333333300033033333330303030333333
            3333333033303333333033303333333333333330333033333330333333333333
            3333300000303030303033333333333333333333333033330330333333303333
            3030333333303000000033333330333330303333333033330330333333333333
            3333}
          Transparent = True
        end
        object lblPicName: TTntLabel
          Left = 192
          Top = 72
          Width = 141
          Height = 13
          AutoSize = False
        end
        object lblPicSize: TTntLabel
          Left = 184
          Top = 96
          Width = 149
          Height = 13
          AutoSize = False
        end
        object Label11: TTntLabel
          Left = 156
          Top = 120
          Width = 36
          Height = 13
          Caption = 'Palette:'
        end
        object lblPicPal: TTntLabel
          Left = 200
          Top = 120
          Width = 133
          Height = 13
          AutoSize = False
        end
        object Panel1: TTntPanel
          Left = 12
          Top = 20
          Width = 132
          Height = 131
          BevelInner = bvLowered
          BevelOuter = bvLowered
          Caption = '<no photo>'
          Color = cl3DLight
          TabOrder = 0
          object SelImage: TImage32
            Left = 2
            Top = 2
            Width = 128
            Height = 127
            Hint = 
              'If the picture differs from the original phone one go to picture' +
              ' properties and click Refresh.'
            Align = alClient
            BitmapAlign = baCenter
            ParentShowHint = False
            Scale = 1.000000000000000000
            ScaleMode = smResize
            ShowHint = True
            TabOrder = 0
          end
        end
        object btnPicSel: TTntButton
          Left = 12
          Top = 156
          Width = 133
          Height = 25
          Caption = '&Select From List '#187
          TabOrder = 1
          OnClick = btnPicSelClick
        end
        object btnPicNew: TTntButton
          Left = 188
          Top = 156
          Width = 69
          Height = 25
          Hint = 'Send to Phone'
          Caption = '&Upload...'
          TabOrder = 2
          OnClick = btnUploadClick
        end
        object btnPicDel: TTntButton
          Left = 264
          Top = 156
          Width = 69
          Height = 25
          Caption = '&Remove'
          TabOrder = 3
          OnClick = btnPicDelClick
        end
      end
      object GroupBox2: TTntGroupBox
        Left = 8
        Top = 208
        Width = 345
        Height = 161
        Caption = 'Sound'
        TabOrder = 1
        object Label14: TTntLabel
          Left = 12
          Top = 72
          Width = 31
          Height = 13
          Caption = 'Name:'
        end
        object Label16: TTntLabel
          Left = 12
          Top = 96
          Width = 23
          Height = 13
          Caption = 'Size:'
        end
        object Label17: TTntLabel
          Left = 12
          Top = 20
          Width = 88
          Height = 13
          Caption = 'Sound information:'
        end
        object imgSnd: TTntImage
          Left = 12
          Top = 46
          Width = 16
          Height = 16
          AutoSize = True
          Picture.Data = {
            07544269746D6170F6000000424DF60000000000000076000000280000001000
            0000100000000100040000000000800000000000000000000000100000000000
            0000000000000000800000800000008080008000000080008000808000008080
            8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
            FF00F00000000000000FF0FFFFFFFFFFFF0FF0FFFFFFFFFFFF0FF0FFFFFFFFFF
            FF0FF0FFFFFFFFFFFF0FF0F7F70007F70F0FF0F0F0FFF0F0FF0FF0F0F0FFF0F0
            FF0FF0F707FFF707FF0FF0FFFFFFFFFFFF0FF0FFFFFFFFFFFF0FF0FFFFFFFF70
            000FF0FFFFFFFF7FFF0FF0FFFFFFFF7FF0FFF0FFFFFFFF7F0FFFF00000000000
            FFFF}
          Transparent = True
        end
        object lblSndType: TTntLabel
          Left = 36
          Top = 48
          Width = 297
          Height = 13
          AutoSize = False
        end
        object lblSndName: TTntLabel
          Left = 48
          Top = 72
          Width = 285
          Height = 13
          AutoSize = False
        end
        object lblSndSize: TTntLabel
          Left = 40
          Top = 96
          Width = 293
          Height = 13
          AutoSize = False
        end
        object btnSndNew: TTntButton
          Tag = 1
          Left = 188
          Top = 124
          Width = 69
          Height = 25
          Hint = 'Send to Phone'
          Caption = 'U&pload...'
          TabOrder = 0
          OnClick = btnUploadClick
        end
        object btnSndDel: TTntButton
          Left = 264
          Top = 124
          Width = 69
          Height = 25
          Caption = 'Re&move'
          TabOrder = 1
          OnClick = btnSndDelClick
        end
        object btnSndSel: TTntButton
          Left = 12
          Top = 124
          Width = 133
          Height = 25
          Caption = 'Select &From List '#187
          TabOrder = 2
          OnClick = btnSndSelClick
        end
        object MediaPlayer1: TMediaPlayer
          Left = 276
          Top = 20
          Width = -1
          Height = 25
          Enabled = False
          VisibleButtons = [btPlay, btStop]
          TabOrder = 3
          OnClick = MediaPlayer1Click
        end
      end
    end
    object tsCallPrefs: TTntTabSheet
      Caption = 'Call Preferences'
      ImageIndex = 2
      object GroupBox3: TTntGroupBox
        Left = 8
        Top = 8
        Width = 345
        Height = 145
        Caption = 'Default Number'
        TabOrder = 0
        object Label20: TTntLabel
          Left = 12
          Top = 28
          Width = 64
          Height = 13
          Caption = 'Prefered one:'
        end
        object Label21: TTntLabel
          Left = 12
          Top = 60
          Width = 321
          Height = 45
          AutoSize = False
          Caption = 
            'If None is selected, the default phone number for a contact will' +
            ' be selected automaticaly in following order, depending of what ' +
            'phone number is present first:'
          WordWrap = True
        end
        object Label22: TTntLabel
          Left = 12
          Top = 112
          Width = 74
          Height = 13
          Caption = 'Autonumbering:'
        end
        object Label23: TTntLabel
          Left = 104
          Top = 112
          Width = 159
          Height = 13
          Caption = 'Mobile -> Work -> Home -> Other.'
        end
        object cbDefaultNum: TTntComboBox
          Left = 104
          Top = 24
          Width = 229
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = txtCustomChange
        end
      end
      object GroupBox6: TTntGroupBox
        Left = 8
        Top = 160
        Width = 345
        Height = 65
        Caption = 'Incoming Calls'
        TabOrder = 1
        object CheckBox1: TTntCheckBox
          Left = 12
          Top = 28
          Width = 329
          Height = 17
          Caption = 
            'Allow this contact to call me even if call restrictions are appl' +
            'ied.'
          Enabled = False
          TabOrder = 0
        end
      end
      object GroupBox8: TTntGroupBox
        Left = 8
        Top = 232
        Width = 345
        Height = 137
        Caption = 'Outgoing Calls'
        TabOrder = 2
        object RadioButton1: TTntRadioButton
          Left = 12
          Top = 28
          Width = 321
          Height = 17
          Caption = 'Always hide my number when calling this contact'
          Enabled = False
          TabOrder = 0
        end
        object RadioButton2: TTntRadioButton
          Left = 12
          Top = 52
          Width = 321
          Height = 17
          Caption = 'Never hide my number when calling this contact'
          Enabled = False
          TabOrder = 1
        end
        object RadioButton3: TTntRadioButton
          Left = 12
          Top = 76
          Width = 321
          Height = 17
          Caption = 'Use current call settings'
          Checked = True
          Enabled = False
          TabOrder = 2
          TabStop = True
        end
        object Button2: TTntButton
          Left = 228
          Top = 100
          Width = 105
          Height = 25
          Caption = 'Factory Defaults'
          Enabled = False
          TabOrder = 3
        end
      end
    end
    object tsCallNotes: TTntTabSheet
      Caption = 'Call Notes'
      ImageIndex = 5
      object Label29: TTntLabel
        Left = 8
        Top = 308
        Width = 341
        Height = 33
        AutoSize = False
        Caption = 
          'Here you could put some Call Drafts about this contact. These no' +
          'tes could be edited while you are in call.'
        WordWrap = True
      end
      object TntImage4: TTntImage
        Left = 8
        Top = 12
        Width = 32
        Height = 32
        Transparent = True
      end
      object TntLabel4: TTntLabel
        Left = 99
        Top = 23
        Width = 38
        Height = 13
        Caption = '<name>'
      end
      object TntBevel6: TTntBevel
        Left = 8
        Top = 56
        Width = 341
        Height = 9
        Shape = bsTopLine
      end
      object TntLabel5: TTntLabel
        Left = 8
        Top = 76
        Width = 51
        Height = 13
        Caption = 'Call Notes:'
      end
      object TntBevel7: TTntBevel
        Left = 8
        Top = 296
        Width = 341
        Height = 9
        Shape = bsTopLine
      end
      object btNotesClear: TTntButton
        Left = 204
        Top = 344
        Width = 69
        Height = 25
        Caption = 'Clea&r All'
        TabOrder = 0
        OnClick = btNotesClearClick
      end
      object btNotesSave: TTntButton
        Left = 280
        Top = 344
        Width = 69
        Height = 25
        Caption = '&Export...'
        TabOrder = 1
        OnClick = btNotesSaveClick
      end
      object MemoNotes: TTntMemo
        Left = 96
        Top = 72
        Width = 253
        Height = 209
        ScrollBars = ssVertical
        TabOrder = 2
        OnChange = MemoNotesChange
      end
    end
    object TabSheet7: TTntTabSheet
      Caption = 'Postal Address'
      ImageIndex = 6
      object Label28: TTntLabel
        Left = 8
        Top = 108
        Width = 31
        Height = 13
        Caption = 'Street:'
      end
      object Label30: TTntLabel
        Left = 8
        Top = 140
        Width = 20
        Height = 13
        Caption = 'City:'
      end
      object Label31: TTntLabel
        Left = 8
        Top = 172
        Width = 37
        Height = 13
        Caption = 'Region:'
      end
      object Label32: TTntLabel
        Left = 8
        Top = 204
        Width = 60
        Height = 13
        Caption = 'Postal Code:'
      end
      object Label33: TTntLabel
        Left = 8
        Top = 236
        Width = 39
        Height = 13
        Caption = 'Country:'
      end
      object TntImage1: TTntImage
        Left = 8
        Top = 12
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
      object TntLabel1: TTntLabel
        Left = 99
        Top = 23
        Width = 38
        Height = 13
        Caption = '<name>'
      end
      object TntLabel6: TTntLabel
        Left = 8
        Top = 76
        Width = 27
        Height = 13
        Caption = 'Type:'
      end
      object TntBevel8: TTntBevel
        Left = 8
        Top = 268
        Width = 341
        Height = 9
        Shape = bsTopLine
      end
      object TntLabel10: TTntLabel
        Left = 8
        Top = 280
        Width = 341
        Height = 37
        AutoSize = False
        Caption = 
          'Your phone might support multiple postal addresses. You can swit' +
          'ch between them using Type drop-down list box above.'
        WordWrap = True
      end
      object lblDisabledPostal: TTntLabel
        Left = 8
        Top = 356
        Width = 269
        Height = 13
        Caption = 'This page is disabled because phone does not support it.'
        Enabled = False
        Visible = False
      end
      object txtStreet: TTntEdit
        Left = 96
        Top = 104
        Width = 253
        Height = 21
        MaxLength = 25
        TabOrder = 1
        OnChange = txtChange
      end
      object txtCity: TTntEdit
        Left = 96
        Top = 136
        Width = 253
        Height = 21
        MaxLength = 25
        TabOrder = 2
        OnChange = txtChange
      end
      object txtRegion: TTntEdit
        Left = 96
        Top = 168
        Width = 253
        Height = 21
        MaxLength = 25
        TabOrder = 3
        OnChange = txtChange
      end
      object txtPostalCode: TTntEdit
        Left = 96
        Top = 200
        Width = 253
        Height = 21
        MaxLength = 25
        TabOrder = 4
        OnChange = txtChange
      end
      object txtCountry: TTntEdit
        Left = 96
        Top = 232
        Width = 253
        Height = 21
        MaxLength = 25
        TabOrder = 5
        OnChange = txtChange
      end
      object txtAddressType: TTntComboBox
        Left = 96
        Top = 72
        Width = 177
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = 'Home'
        OnChange = txtAddressTypeChange
        Items.Strings = (
          'Home'
          'Work')
      end
      object PostalDeleteButton: TTntButton
        Left = 280
        Top = 72
        Width = 69
        Height = 25
        Caption = '&Remove'
        TabOrder = 6
        OnClick = PostalDeleteButtonClick
      end
    end
    object TntTabSheet1: TTntTabSheet
      Caption = 'Internet Address'
      object TntImage5: TTntImage
        Left = 8
        Top = 12
        Width = 32
        Height = 32
        Transparent = True
      end
      object TntLabel7: TTntLabel
        Left = 99
        Top = 23
        Width = 38
        Height = 13
        Caption = '<name>'
      end
      object TntBevel5: TTntBevel
        Left = 8
        Top = 56
        Width = 341
        Height = 9
        Shape = bsTopLine
      end
      object TntLabel8: TTntLabel
        Left = 8
        Top = 76
        Width = 58
        Height = 13
        Caption = 'Home page:'
      end
      object TntLabel9: TTntLabel
        Left = 8
        Top = 108
        Width = 36
        Height = 13
        Caption = 'E-mails:'
      end
      object TntBevel9: TTntBevel
        Left = 8
        Top = 296
        Width = 341
        Height = 9
        Shape = bsTopLine
      end
      object TntLabel11: TTntLabel
        Left = 8
        Top = 308
        Width = 341
        Height = 37
        AutoSize = False
        Caption = 
          'Your phone might support several E-mail addresses. You should se' +
          'lect one as a prefered one from the list above.'
        WordWrap = True
      end
      object txtURL: TTntEdit
        Left = 96
        Top = 72
        Width = 253
        Height = 21
        MaxLength = 25
        TabOrder = 0
        OnChange = txtChange
      end
      object lvEmails: TTntListView
        Left = 96
        Top = 104
        Width = 253
        Height = 141
        Columns = <
          item
            Caption = 'Address'
            Width = 248
          end>
        ColumnClick = False
        ReadOnly = True
        ShowColumnHeaders = False
        SmallImages = ImageList1
        TabOrder = 1
        ViewStyle = vsReport
        OnDblClick = lvEmailsDblClick
        OnSelectItem = lvEmailsSelectItem
      end
      object MailAddButton: TTntButton
        Left = 96
        Top = 252
        Width = 73
        Height = 25
        Caption = '&New'
        TabOrder = 2
        OnClick = MailAddButtonClick
      end
      object MailEditButton: TTntButton
        Left = 176
        Top = 252
        Width = 73
        Height = 25
        Caption = 'C&hange'
        Enabled = False
        TabOrder = 3
        OnClick = MailEditButtonClick
      end
      object MailDelButton: TTntButton
        Left = 276
        Top = 252
        Width = 73
        Height = 25
        Caption = '&Delete'
        Enabled = False
        TabOrder = 4
        OnClick = MailDelButtonClick
      end
      object MailPrefButton: TTntButton
        Left = 248
        Top = 344
        Width = 101
        Height = 25
        Caption = 'Set &Prefered'
        Enabled = False
        TabOrder = 5
        OnClick = MailPrefButtonClick
      end
    end
    object TabSheet5: TTntTabSheet
      Caption = 'Outlook'
      ImageIndex = 4
      object TntImage2: TTntImage
        Left = 8
        Top = 12
        Width = 32
        Height = 32
        Transparent = True
      end
      object TntLabel2: TTntLabel
        Left = 99
        Top = 23
        Width = 38
        Height = 13
        Caption = '<name>'
      end
      object TntBevel2: TTntBevel
        Left = 8
        Top = 56
        Width = 341
        Height = 9
        Shape = bsTopLine
      end
      object Label3: TTntLabel
        Left = 8
        Top = 76
        Width = 43
        Height = 13
        Caption = 'Identifier:'
      end
      object Label26: TTntLabel
        Left = 8
        Top = 296
        Width = 341
        Height = 49
        AutoSize = False
        Caption = 
          'You can break up current Contact'#39's linking to an existing Outloo' +
          'k contact in order to link it again to a different one. To do so' +
          ', click the Unlink Contact button bellow.'
        WordWrap = True
      end
      object Label25: TTntLabel
        Left = 8
        Top = 108
        Width = 34
        Height = 13
        Caption = 'File As:'
      end
      object Label27: TTntLabel
        Left = 8
        Top = 140
        Width = 46
        Height = 13
        Caption = 'Summary:'
      end
      object TntBevel4: TTntBevel
        Left = 8
        Top = 284
        Width = 341
        Height = 9
        Shape = bsTopLine
      end
      object txtContactDataID: TTntEdit
        Left = 96
        Top = 72
        Width = 253
        Height = 21
        Color = clBtnFace
        MaxLength = 30
        ReadOnly = True
        TabOrder = 0
        OnChange = txtCustomChange
      end
      object UnlinkOutlookButton: TTntButton
        Left = 248
        Top = 344
        Width = 101
        Height = 25
        Caption = '&Unlink Contact'
        TabOrder = 1
        OnClick = UnlinkOutlookButtonClick
      end
      object txtFileAs: TTntEdit
        Left = 96
        Top = 104
        Width = 253
        Height = 21
        Color = clBtnFace
        MaxLength = 30
        ReadOnly = True
        TabOrder = 2
      end
      object MemoDetails: TTntMemo
        Left = 96
        Top = 136
        Width = 253
        Height = 133
        Color = clBtnFace
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 3
      end
    end
    object TabSheet3: TTntTabSheet
      Caption = 'Advanced'
      ImageIndex = 3
      object Label18: TTntLabel
        Left = 8
        Top = 120
        Width = 341
        Height = 61
        AutoSize = False
        Caption = 
          'Each contact'#39's phone number has an unique position in phone'#39's ph' +
          'onebook memory. When you'#39're adding a contact to group or so, thi' +
          's position is used. Ir order to speed up these operations FMA is' +
          ' maintaining a cache with positions.'
        WordWrap = True
      end
      object Label19: TTntLabel
        Left = 8
        Top = 184
        Width = 341
        Height = 57
        AutoSize = False
        Caption = 
          'From this button you can clear the cached information about this' +
          ' contact. Do it only if you know what are you doing or if you re' +
          'ceive an inccorect name for this contact in the phone groups.'
        WordWrap = True
      end
      object Label34: TTntLabel
        Left = 8
        Top = 68
        Width = 341
        Height = 49
        AutoSize = False
        Caption = 
          'Please note that settings for Personalize, Call Prefferences and' +
          ' Outlook Synchronization are FMA specific and will not be synchr' +
          'onized with phone data.'
        WordWrap = True
      end
      object TntImage3: TTntImage
        Left = 8
        Top = 12
        Width = 32
        Height = 32
        Transparent = True
      end
      object TntLabel3: TTntLabel
        Left = 99
        Top = 23
        Width = 38
        Height = 13
        Caption = '<name>'
      end
      object TntBevel3: TTntBevel
        Left = 8
        Top = 56
        Width = 341
        Height = 9
        Shape = bsTopLine
      end
      object ResetButton: TTntButton
        Left = 248
        Top = 244
        Width = 101
        Height = 25
        Caption = '&Reset Positions'
        TabOrder = 0
        OnClick = ResetButtonClick
      end
    end
  end
  object OkButton: TTntButton
    Left = 156
    Top = 440
    Width = 69
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = OkButtonClick
  end
  object CancelButton: TTntButton
    Left = 232
    Top = 440
    Width = 69
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    TabOrder = 2
    OnClick = CancelButtonClick
  end
  object ApplyButton: TTntButton
    Left = 308
    Top = 440
    Width = 69
    Height = 25
    Caption = '&Apply'
    Enabled = False
    TabOrder = 3
    OnClick = ApplyButtonClick
  end
  object PopupMenu1: TTntPopupMenu
    AutoHotkeys = maManual
    Images = Form1.ImageList1
    Left = 8
    Top = 440
  end
  object SaveDialog1: TTntSaveDialog
    DefaultExt = 'txt'
    Filter = 'Text Files (*.txt)|*.txt|All Files|*.*'
    Title = 'Save Notes...'
    Left = 40
    Top = 440
  end
  object ImageList1: TImageList
    Left = 72
    Top = 440
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF00FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000005A5D5A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000000000000000000005A5D
      5A000000000000000000000000005A5D5A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      00005A5D5A0000000000000000005A5D5A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400D6D6D600DEDE
      DE00848484008484840000000000000000005A5D5A0000000000000000000000
      00005A5D5A000000000000000000000000005A5D5A0000000000000000000000
      00005A5D5A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008484840084848400CECECE00D6D6D600D6D6D600DEDE
      DE00E7E7E700848484000000000000000000000000005A5D5A00000000000000
      0000000000005A5D5A00000000000000000000000000000000005A5D5A005A5D
      5A005A5D5A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484840084848400C6C6C600CECECE00CECECE00D6D6D600D6D6D600DEDE
      DE00E7E7E700848484000000000000000000000000005A5D5A00000000000000
      0000000000000000000000000000000000005A5D5A005A5D5A00FFDF9C00FFE3
      AD005A595A005A595A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400B5B5B500BDBDBD00C6C6C600CECECE00CECECE00D6D6D600D6D6D600DEDE
      DE00E7E7E700EFEFEF00848484000000000000000000000000005A5D5A000000
      000000000000000000005A5D5A005A5D5A00FFD78400FFDB8C00FFDF9C00FFE3
      AD00FFE7BD005A595A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400ADADAD00B5B5
      B500B5B5B500BDBDBD00C6C6C600848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      00005A5D5A005A5D5A00FFCB6300FFCF7300FFD78400FFDB8C00FFDF9C00FFE3
      AD00FFE7BD005A595A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400ADADAD00B5B5
      B500B5B5B500BDBDBD0084848400DEDEDE00E7E7E700E7E7E700E7E7E700E7E7
      E700E7E7E700EFEFEF00848484008484840000000000000000005A595A005A5D
      5A00FFC34200FFC75200FFCB6300FFCF7300FFD78400FFDB8C00FFDF9C00FFE3
      AD00FFE7BD00FFEFCE005A595A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400ADADAD00B5B5
      B500B5B5B50084848400DEDEDE00DEDEDE00E7E7E700E7E7E700E7E7E700E7E7
      E700848484008484840000000000000000005A595A005A595A00FFB62100FFBA
      3100FFC34200FFC75200FFCB63005A5D5A005A5D5A005A5D5A005A5D5A005A5D
      5A005A5D5A005A5D5A005A595A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400B5B5
      B50084848400DEDEDE00DEDEDE00DEDEDE00E7E7E70084848400848484008484
      840000000000000000000000000000000000000000005A595A00FFB62100FFBA
      3100FFC34200FFC752005A5D5A00C6E3E700CEE7E700D6E7E700DEE7DE00E7E7
      DE00EFEBD600F7EBD6005A595A005A595A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400DEDEDE00DEDEDE00DEDEDE00848484008484840000000000000000000000
      000000000000000000000000000000000000000000005A595A00FFB62100FFBA
      3100FFC342005A5D5A00BDE3EF00C6E3E700CEE7E700D6E7E700DEE7DE00E7E7
      DE005A595A005A595A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400DEDEDE008484840084848400000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005A595A00FFBA
      31005A5D5A00B5E3EF00BDE3EF00C6E3E700CEE7E7005A595A005A595A005A59
      5A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005A595A005A59
      5A00ADDFF700B5E3EF00BDE3EF005A595A005A595A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005A59
      5A00ADDFF7005A595A005A595A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005A59
      5A005A595A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFDFF00000000FFF7EEFF00000000
      FFC7F6FF00000000FF03777700000000FC03BBC700000000F003BF0300000000
      C001DC03000000000001F003000000008000C001000000008003000100000000
      C00F800000000000C07F800300000000E1FFC00F00000000E7FFC07F00000000
      FFFFE1FF00000000FFFFE7FF00000000}
  end
end
