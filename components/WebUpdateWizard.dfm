object frmWebUpdate: TfrmWebUpdate
  Left = 357
  Top = 199
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsSingle
  Caption = 'Web Update Wizard'
  ClientHeight = 357
  ClientWidth = 493
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000077700000000000000000000000000077BB8BE6000000000000078
    F8F0000078B8BB8E668000000000007F8F807007888B8BE66888000000000078
    F8F08707888BBB6688FF00000000007F8F8078788888B868FFFFF00000000078
    F8F087788888800FFF8880000000007F8F807878888808807778800000000078
    F8F0877777770880887770000000007F8F80787FF88EE0088F8880000000007F
    FFF0877F8EE677B888F880000000007FFFF07877EE677B8B888F00000000007F
    FFF08787E66788B8888808888800007FFFF0888876778BBB888000008870007F
    FFF088880777B8B8B00777778870007FFFF088880FF777777FFFFFFFFF700077
    77708888077777777777777778700077777088880000000000000000008007FF
    FFF708880788888888888888870077777777708807FFFFFFFFFFFFFF87000000
    0777770807F444444444444F870000000077777007F4E8E6E6C8C74F87000000
    0007FFFF07F4FE8E6E6C8C4F870000000000777770F4EFE8E6E6C84F87000000
    0000000007F4FEFE8E6E6C4F870000000000000007F4EFEFE8E6E64F87000000
    0000000007F4EEFEFE8E6E4F870000000000000007F4FEEFEFE8E64F87000000
    0000000007F48FEEFEFE8E4F870000000000000007F444444444444F87000000
    0000000007FFFFFFFFFFFFFF870000000000000000777777777777777700FFFE
    07FFC0F801FFC07000FFC020007FC000007FC000003FC000003FC000003FC000
    003FC000003FC000003FC0000003C0000001C0000000C0000000C0000000C000
    0000C00000008000000100000001F8000001FC000001FE000001FF000001FFF8
    0001FFF80001FFF80001FFF80001FFF80001FFF80001FFF80001FFFC0003}
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = TntFormCloseQuery
  OnCreate = FormCreate
  OnShow = TntFormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TTntBevel
    Left = 0
    Top = 313
    Width = 493
    Height = 9
    Align = alTop
    Shape = bsTopLine
  end
  object NextButton: TTntButton
    Left = 316
    Top = 324
    Width = 77
    Height = 25
    Caption = '&Next >'
    TabOrder = 0
    OnClick = NextButtonClick
  end
  object CancelButton: TTntButton
    Left = 404
    Top = 324
    Width = 77
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    TabOrder = 1
    OnClick = CancelButtonClick
  end
  object PreviousButton: TTntButton
    Left = 239
    Top = 324
    Width = 77
    Height = 25
    Caption = '< &Previous'
    Enabled = False
    TabOrder = 2
    OnClick = PreviousButtonClick
  end
  object nbWizard: TNotebook
    Left = 0
    Top = 0
    Width = 493
    Height = 313
    Align = alTop
    TabOrder = 3
    OnPageChanged = nbWizardPageChanged
    object TPage
      Left = 0
      Top = 0
      Caption = 'Welcome'
      object WelcomePanel: TTntPanel
        Left = 0
        Top = 0
        Width = 493
        Height = 314
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object imgWizard: TTntImage
          Left = 0
          Top = 0
          Width = 164
          Height = 314
          Align = alLeft
          AutoSize = True
          Center = True
        end
        object lbProductName: TTntLabel
          Left = 176
          Top = 12
          Width = 103
          Height = 25
          Caption = 'Welcome!'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lbDescription: TTntLabel
          Left = 176
          Top = 44
          Width = 305
          Height = 37
          AutoSize = False
          Caption = '<info>'
          Transparent = True
          WordWrap = True
        end
        object imgWarning: TTntImage
          Left = 176
          Top = 96
          Width = 16
          Height = 16
          AutoSize = True
          Picture.Data = {
            07544269746D617036030000424D360300000000000036000000280000001000
            000010000000010018000000000000030000120B0000120B0000000000000000
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFF000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000AAAAAA999999777777000000
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF000000CCCCCC777777888888000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000AAAAAA999999777777000000
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF000000336666336666336666000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000AADDDD7DC3C368A6A6000000
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF000000BBEEEEBBEEEE7DC3C3000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000BBEEEECCFFFFCCFFFFAADDDD68A6A6
            000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
            00BBEEEECCFFFFFFFFFFBBEEEE7DC3C3000000FFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFF000000BBEEEEFFFFFFFFFFFF33FFFFFFFFFFCCFFFF
            68A6A6000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000BBEE
            EEFFFFFF33FFFFFFFFFF33FFFFFFFFFF68A6A6000000FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFF000000AADDDDBBEEEECCFFFFFFFFFFBBEEEE7DC3C3
            68A6A6000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
            00AADDDDBBEEEEAADDDD7DC3C368A6A6000000FFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF}
          Transparent = True
          Visible = False
        end
        object lbWarning: TTntLabel
          Left = 200
          Top = 96
          Width = 281
          Height = 181
          AutoSize = False
          Caption = '<hint>'
          Visible = False
          WordWrap = True
        end
        object lblWelcomeNext: TTntLabel
          Left = 176
          Top = 288
          Width = 108
          Height = 13
          Caption = 'Click Next to continue.'
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Mirrors'
      object Label8: TTntLabel
        Left = 40
        Top = 80
        Width = 146
        Height = 13
        Caption = 'Prefered download mirror site:'
      end
      object Label9: TTntLabel
        Left = 40
        Top = 288
        Width = 264
        Height = 13
        Caption = 'Select mirror site(s) to use, then click Next to continue.'
      end
      object TopPanel1: TTntPanel
        Left = 0
        Top = 0
        Width = 495
        Height = 58
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object TopDetailsLabel1: TTntLabel
          Left = 40
          Top = 24
          Width = 389
          Height = 30
          AutoSize = False
          Caption = 'Select a prefered mirror site from which to retrieve updates.'
          WordWrap = True
        end
        object TopBevel1: TTntBevel
          Left = 0
          Top = 53
          Width = 495
          Height = 5
          Shape = bsBottomLine
        end
        object TopCaptionLabel1: TTntLabel
          Left = 20
          Top = 10
          Width = 41
          Height = 13
          Caption = 'Mirrors'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object imgWizardSmall1: TTntImage
          Left = 438
          Top = 1
          Width = 54
          Height = 54
          Center = True
        end
      end
      object rbMirrorDefault: TTntRadioButton
        Left = 40
        Top = 108
        Width = 413
        Height = 17
        Caption = 'Use default mirror provided by application vendor.'
        Checked = True
        TabOrder = 1
        TabStop = True
        OnClick = rbMirrorDefaultClick
      end
      object rbMirrorCustom: TTntRadioButton
        Left = 40
        Top = 136
        Width = 413
        Height = 17
        Caption = 'Custom selection:'
        TabOrder = 2
        OnClick = rbMirrorDefaultClick
      end
      object clMirrors: TTntCheckListBox
        Left = 56
        Top = 160
        Width = 397
        Height = 117
        Enabled = False
        ItemHeight = 13
        TabOrder = 3
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Updates'
      object Label2: TTntLabel
        Left = 40
        Top = 80
        Width = 79
        Height = 13
        Caption = 'Current version:'
      end
      object lblNameVer: TTntLabel
        Left = 128
        Top = 80
        Width = 51
        Height = 13
        Caption = '<version>'
      end
      object gbNumbers: TTntGroupBox
        Left = 56
        Top = 179
        Width = 397
        Height = 98
        TabOrder = 5
        object lblVersionInfo: TTntLabel
          Left = 172
          Top = 12
          Width = 217
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '(select custom version to view its details)'
          Enabled = False
        end
        object mmoVersionInfo: TTntMemo
          Left = 171
          Top = 36
          Width = 218
          Height = 54
          BorderStyle = bsNone
          Enabled = False
          ParentColor = True
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 1
        end
        object clNumbers: TTntCheckListBox
          Left = 8
          Top = 12
          Width = 157
          Height = 77
          OnClickCheck = clNumbersClickCheck
          AllowGrayed = True
          Enabled = False
          ItemHeight = 13
          TabOrder = 0
        end
        object Panel1: TPanel
          Left = 172
          Top = 31
          Width = 217
          Height = 1
          BevelOuter = bvNone
          Color = clGrayText
          TabOrder = 2
        end
      end
      object TopPanel2: TTntPanel
        Left = 0
        Top = 0
        Width = 495
        Height = 58
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object TopDetailsLabel2: TTntLabel
          Left = 40
          Top = 24
          Width = 389
          Height = 30
          AutoSize = False
          Caption = 'Select target product version to update to.'
          WordWrap = True
        end
        object TopBevel2: TTntBevel
          Left = 0
          Top = 53
          Width = 495
          Height = 5
          Shape = bsBottomLine
        end
        object TopCaptionLabel2: TTntLabel
          Left = 20
          Top = 10
          Width = 47
          Height = 13
          Caption = 'Updates'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object imgWizardSmall2: TTntImage
          Left = 438
          Top = 1
          Width = 54
          Height = 54
          Center = True
        end
      end
      object RadioButton1: TTntRadioButton
        Left = 40
        Top = 104
        Width = 413
        Height = 17
        Caption = 'Use localy stored update file'
        TabOrder = 1
        OnClick = RadioButtonClick
      end
      object edLocal: TTntEdit
        Left = 56
        Top = 128
        Width = 317
        Height = 21
        Color = clBtnFace
        Enabled = False
        TabOrder = 2
      end
      object BrowseButton: TTntButton
        Left = 380
        Top = 128
        Width = 73
        Height = 25
        Caption = 'Bro&wse'
        Enabled = False
        TabOrder = 3
        OnClick = BrowseButtonClick
      end
      object RadioButton2: TTntRadioButton
        Left = 40
        Top = 160
        Width = 413
        Height = 17
        Caption = 'Upgrade to a custom version:'
        TabOrder = 4
        OnClick = RadioButtonClick
      end
      object RadioButton3: TTntRadioButton
        Left = 40
        Top = 288
        Width = 413
        Height = 17
        Caption = 'Upgrade to the most recent version available'
        Checked = True
        TabOrder = 6
        TabStop = True
        OnClick = RadioButtonClick
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Ready2Download'
      object Label6: TTntLabel
        Left = 40
        Top = 288
        Width = 325
        Height = 13
        Caption = 
          'Click Download to retrieve updates from Internet, or Cancel to e' +
          'xit.'
      end
      object TopPanel3: TTntPanel
        Left = 0
        Top = 0
        Width = 495
        Height = 58
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object TopDetailsLabel3: TTntLabel
          Left = 40
          Top = 24
          Width = 389
          Height = 30
          AutoSize = False
          Caption = 'We are ready to download selected updates.'
          WordWrap = True
        end
        object TopBevel3: TTntBevel
          Left = 0
          Top = 53
          Width = 495
          Height = 5
          Shape = bsBottomLine
        end
        object TopCaptionLabel3: TTntLabel
          Left = 20
          Top = 10
          Width = 109
          Height = 13
          Caption = 'Ready to Download'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object imgWizardSmall3: TTntImage
          Left = 438
          Top = 1
          Width = 54
          Height = 54
          Center = True
        end
      end
      object memDownload: TTntMemo
        Left = 40
        Top = 80
        Width = 413
        Height = 197
        Color = clBtnFace
        Lines.Strings = (
          '<what>')
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 1
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Ready2Install'
      object imgReady: TTntImage
        Left = 16
        Top = 80
        Width = 16
        Height = 16
        AutoSize = True
        Transparent = True
        Visible = False
      end
      object lbReady: TTntLabel
        Left = 40
        Top = 80
        Width = 417
        Height = 197
        AutoSize = False
        Caption = '<ready>'
        Visible = False
        WordWrap = True
      end
      object Label5: TTntLabel
        Left = 40
        Top = 288
        Width = 347
        Height = 13
        Caption = 
          'Click Install to apply downloaded updates immediately, or Cancel' +
          ' to exit.'
      end
      object TopPanel4: TTntPanel
        Left = 0
        Top = 0
        Width = 495
        Height = 58
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object TopDetailsLabel4: TTntLabel
          Left = 40
          Top = 24
          Width = 389
          Height = 30
          AutoSize = False
          Caption = 'We are ready to install downloaded updates.'
          WordWrap = True
        end
        object TopBevel4: TTntBevel
          Left = 0
          Top = 53
          Width = 495
          Height = 5
          Shape = bsBottomLine
        end
        object TopCaptionLabel4: TTntLabel
          Left = 20
          Top = 10
          Width = 90
          Height = 13
          Caption = 'Ready to Install'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object imgWizardSmall4: TTntImage
          Left = 438
          Top = 1
          Width = 54
          Height = 54
          Center = True
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Install'
      object imgSetup: TTntImage
        Left = 40
        Top = 80
        Width = 32
        Height = 32
        Picture.Data = {
          07544269746D6170360C0000424D360C00000000000036000000280000002000
          0000200000000100180000000000000C0000120B0000120B0000000000000000
          0000BDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCE
          BDFFCEBDFFCEBDFFCEBDFFCEBDFFCE5F5F5F5F5F5F5F5F5F3333333333333333
          33BDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBD
          FFCEBDFFCEBDFFCE000000000000000000000000000000000000BDFFCEBDFFCE
          BDFFCEBDFFCEBDFFCE5F5F5F5F5F5F99CCCC99CCCC99FFFFCCFFCCCCCC33CC99
          00333333333333BDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBD
          FFCEBDFFCEBDFFCE868686CCCCCCFFFFFFCCCCCCFFFFFF000000000000BDFFCE
          BDFFCEBDFFCE5F5F5FC0C0C0C0C0C099CCCC99CCCC99FFFFCCFFCCCCCC33CC99
          00999900CCFF99333333BDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBD
          FFCEBDFFCEBDFFCE868686FFFFFFCCCCCCFFFFFFCCCCCC000000868686000000
          BDFFCE5F5F5FB2B2B2C0C0C0C0C0C0C0C0C099CCCC99FFFFCCCC33CC99009999
          00CCFF99CCFF99CCFF99333333BDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBD
          FFCEBDFFCEBDFFCE868686CCCCCCFFFFFFCCCCCCFFFFFF000000A0A0A4868686
          000000777777B2B2B2B2B2B2C0C0C0C0C0C099CCCC99FFFFCC9900999900CCFF
          99CCFF99E3E3E3E3E3E3333333BDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBD
          FFCEBDFFCEBDFFCE868686FFFFFFCCCCCCFFFFFFCCCCCC000000868686A0A0A4
          5F5F5FB2B2B2B2B2B2B2B2B2B2B2B2C0C0C099CCCC99CCCC999900CCFF99E3E3
          E3E3E3E3E3E3E3E3E3E3E3E3E3333333BDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBD
          FFCEBDFFCEBDFFCE868686CCCCCCFFFFFFCCCCCCFFFFFF000000A0A0A4868686
          5F5F5FCCCCCCB2B2B2B2B2B2B2B2B2B2B2B2C0C0C0000000000000E3E3E3E3E3
          E3E3E3E3B2B2B2B2B2B2B2B2B2333333BDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBD
          FFCEBDFFCEBDFFCE868686FFFFFFCCCCCCFFFFFFCCCCCC000000868686A0A0A4
          5F5F5FCCCCCCCCCCCCCCCCCCB2B2B2B2B2B2000000FFFFFFFFFFFF0000008686
          86868686868686B2B2B2B2B2B2333333BDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBD
          FFCEBDFFCEBDFFCE868686CCCCCCFFFFFFCCCCCCFFFFFF000000A0A0A4868686
          5F5F5F999999999999999999999999999999000000FFFFFFFFFFFF000000D7D7
          D7D7D7D7868686868686868686333333BDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBD
          FFCEBDFFCEBDFFCE868686FFFFFFCCCCCCFFFFFFCCCCCC000000868686A0A0A4
          5F5F5FE3E3E3E3E3E3CCFF99CCFF99CCCC33CCCC33000000000000B2B2B2A0A0
          A4FFFFFFD7D7D7B2B2B2B2B2B2333333BDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBD
          FFCEBDFFCEBDFFCE868686FFFFFFFFFFFFFFFFFFFFFFFF000000A0A0A4868686
          5F5F5FE3E3E3CCFF99CCCC33CCCC33CC993399996699996666CCCCB2B2B2A0A0
          A4C0C0C0FFFFFFD7D7D7D7D7D7333333BDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBD
          FFCEBDFFCEBDFFCE868686FFFFFFFFFFFFFFFFFFFFFFFF000000868686A0A0A4
          8686865F5F5FCCCC33CCCC33CC993399996699CC6699FFFF66CCCCB2B2B2B2B2
          B2A0A0A4C0C0C0FFFFFF333333000000000000000000000000000000BDFFCEBD
          FFCEBDFFCEBDFFCE868686FFFFFFFFFFFFFFFFFFFFFFFF000000A0A0A4868686
          A0A0A45F5F5FCCCC33CC9933CC993399996699FFFF99FFFF66CCCC66CCCCB2B2
          B2A0A0A4A0A0A4C0C0C0333333C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000BD
          FFCEBDFFCEBDFFCE868686FFFFFFFFFFFFFFFFFFFFFFFF000000A0A0A4A0A0A4
          A0A0A4A0A0A45F5F5FCC993399996699CC6699FFFF66CCCC66CCCC66CCCCB2B2
          B2B2B2B2A0A0A4333333000000000000000000000000C0C0C0B2B2B286868600
          0000BDFFCEBDFFCE868686FFFFFFFFFFFFFFFFFFFFFFFF000000A0A0A4A0A0A4
          A0A0A4A0A0A400000077777777777799CC6699FFFF66CCCC66CCCC66CCCCB2B2
          B2333333333333868686868686868686868686868686C0C0C0C0C0C086868600
          0000BDFFCEBDFFCE868686FFFFFFFFFFFFFFFFFFFFFFFF000000A0A0A4A0A0A4
          A0A0A4A0A0A4000000FFFFFFFFFFFF9696969696969696969696967777777777
          77FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF86868600
          0000BDFFCEBDFFCE868686868686868686868686868686000000A0A0A4A0A0A4
          A0A0A4A0A0A40000008686868686868686868686868686868686868686868686
          86868686868686868686868686868686868686868686868686B2B2B286868600
          0000BDFFCEBDFFCE5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F000000A0A0A4A0A0A4
          A0A0A4A0A0A40000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000000B2B2B208
          0808BDFFCE868686FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F5F5F000000A0A0A4
          A0A0A4A0A0A4000000868686C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0868686000000BD
          FFCE8686868686868686868686868686868686868686865F5F5F5F5F5F000000
          A0A0A4A0A0A4000000868686FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0868686000000BD
          FFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCE8686865F5F5F5F5F5F5F5F5F5F5F5F
          000000A0A0A4000000868686FFFFFF8000008000008000008000008000008000
          00800000800000800000800000800000800000FFFFFFC0C0C0868686000000BD
          FFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCE8686865F5F5F5F5F5F5F5F5F
          5F5F5F000000000000868686FFFFFF800000FFFF00FFCC66FFCC66CC9900CC99
          00CC9900CC9900FF6633FF6633FF6633800000FFFFFFC0C0C0868686000000BD
          FFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCE868686FFFFFFFFFFFF
          FFFFFFFFFFFF000000868686FFFFFF800000FFFFCCFFFF33FFCC66FFCC66CC99
          00CC9900CC9900CC9900FF6633FF6633800000FFFFFFC0C0C0868686000000BD
          FFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCE868686868686
          868686868686868686000000FFFFFF800000FFFF33FFFFCCFFFF33FFCC66FFCC
          66CC9900CC9900CC9900CC9900FF6633800000FFFFFFC0C0C0868686000000BD
          FFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCE
          BDFFCEBDFFCEBDFFCE868686FFFFFF800000FFFFCCFFFF33FFFFCCFFFF33FFCC
          66FFCC66CC9900CC9900CC9900CC9900800000FFFFFFC0C0C0868686000000BD
          FFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCE
          BDFFCEBDFFCEBDFFCE868686FFFFFF800000FFFF33FFFFCCFFFF33FFFFCCFFFF
          33FFCC66FFCC66CC9900CC9900CC9900800000FFFFFFC0C0C0868686000000BD
          FFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCE
          BDFFCEBDFFCEBDFFCE868686FFFFFF800000FFCC66FFFF33FFFFCCFFFF33FFFF
          CCFFFF33FFCC66FFCC66CC9900CC9900800000FFFFFFC0C0C0868686000000BD
          FFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCE
          BDFFCEBDFFCEBDFFCE868686FFFFFF800000FFCC66FFCC66FFFF33FFFFCCFFFF
          33FFFFCCFFFF33FFCC66FFCC66CC9900800000FFFFFFC0C0C0868686000000BD
          FFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCE
          BDFFCEBDFFCEBDFFCE868686FFFFFF800000FFCC66FFCC66FFCC66FFFF33FFFF
          CCFFFF33FFFFCCFFFF00FFCC66FFCC66800000FFFFFFC0C0C0868686000000BD
          FFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCE
          BDFFCEBDFFCEBDFFCE868686FFFFFF8000008000008000008000008000008000
          00800000800000800000800000800000800000FFFFFFC0C0C0868686000000BD
          FFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCE
          BDFFCEBDFFCEBDFFCE868686FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0C0C0868686000000BD
          FFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCEBDFFCE
          BDFFCEBDFFCEBDFFCEBDFFCE7777777777777777777777777777777777777777
          77777777777777777777777777777777777777777777777777777777BDFFCEBD
          FFCE}
        Transparent = True
      end
      object lblCurrentTask: TTntLabel
        Left = 84
        Top = 88
        Width = 373
        Height = 81
        AutoSize = False
        Caption = '<description>'
        WordWrap = True
      end
      object lblUpdate: TTntLabel
        Left = 40
        Top = 184
        Width = 46
        Height = 13
        Caption = 'Progress:'
        Visible = False
      end
      object lblTotal: TTntLabel
        Left = 40
        Top = 230
        Width = 73
        Height = 13
        Caption = 'Total Progress:'
      end
      object TopPanel5: TTntPanel
        Left = 0
        Top = 0
        Width = 493
        Height = 58
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 1
        object TopDetailsLabel5: TTntLabel
          Left = 40
          Top = 24
          Width = 389
          Height = 30
          AutoSize = False
          Caption = 'Please, wait until Web Update Wizard finishes all update tasks.'
          WordWrap = True
        end
        object TopBevel5: TTntBevel
          Left = 0
          Top = 53
          Width = 495
          Height = 5
          Shape = bsBottomLine
        end
        object TopCaptionLabel5: TTntLabel
          Left = 20
          Top = 10
          Width = 103
          Height = 13
          Caption = 'Installing Updates'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object imgWizardSmall5: TTntImage
          Left = 438
          Top = 1
          Width = 54
          Height = 54
          Center = True
        end
      end
      object pbUpdate: TTntProgressBar
        Left = 40
        Top = 202
        Width = 413
        Height = 21
        Smooth = True
        TabOrder = 0
        Visible = False
      end
      object pbTotal: TTntProgressBar
        Left = 40
        Top = 248
        Width = 413
        Height = 21
        Smooth = True
        TabOrder = 2
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'CompleteNotes'
      object Label10: TTntLabel
        Left = 40
        Top = 288
        Width = 108
        Height = 13
        Caption = 'Click Next to continue.'
      end
      object TopPanel6: TTntPanel
        Left = 0
        Top = 0
        Width = 495
        Height = 58
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object TopDetailsLabel6: TTntLabel
          Left = 40
          Top = 24
          Width = 389
          Height = 30
          AutoSize = False
          Caption = 
            'All update process has completed and install notes are shown bel' +
            'ow. Please read them carefuly.'
          WordWrap = True
        end
        object TopBevel6: TTntBevel
          Left = 0
          Top = 53
          Width = 495
          Height = 5
          Shape = bsBottomLine
        end
        object TopCaptionLabel6: TTntLabel
          Left = 20
          Top = 10
          Width = 105
          Height = 13
          Caption = 'Update Completed'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object imgWizardSmall6: TTntImage
          Left = 438
          Top = 1
          Width = 54
          Height = 54
          Center = True
        end
      end
      object memCompleted: TTntMemo
        Left = 40
        Top = 80
        Width = 413
        Height = 197
        Lines.Strings = (
          '<what>')
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 1
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Finished'
      object FinishedPanel: TTntPanel
        Left = 0
        Top = 0
        Width = 493
        Height = 314
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object imgFinished: TTntImage
          Left = 0
          Top = 0
          Width = 164
          Height = 314
          Align = alLeft
          AutoSize = True
          Center = True
        end
        object Label3: TTntLabel
          Left = 176
          Top = 12
          Width = 93
          Height = 25
          Caption = 'Finished!'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblFinished: TTntLabel
          Left = 176
          Top = 44
          Width = 305
          Height = 37
          AutoSize = False
          Caption = '<done>'
          Transparent = True
          WordWrap = True
        end
        object memNotes: TTntMemo
          Left = 176
          Top = 112
          Width = 305
          Height = 193
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 2
          Visible = False
          WordWrap = False
        end
        object cbDeleteUpdates: TTntCheckBox
          Left = 176
          Top = 84
          Width = 305
          Height = 17
          Caption = 'Delete downloaded updates on Finish.'
          TabOrder = 0
        end
        object DetailsButton: TTntButton
          Left = 404
          Top = 280
          Width = 77
          Height = 25
          Caption = 'Details'
          TabOrder = 1
          Visible = False
          OnClick = DetailsButtonClick
        end
      end
    end
  end
  object OpenDialog1: TTntOpenDialog
    Filter = 'Update files (*.dif;*.rev)|*.dif;*.rev|All files|*.*'
    Options = [ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Browse for an update...'
    Left = 8
    Top = 320
  end
end
