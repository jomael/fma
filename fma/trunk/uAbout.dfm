object frmAbout: TfrmAbout
  Left = 441
  Top = 291
  ActiveControl = OkButton
  AlphaBlendValue = 200
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 356
  ClientWidth = 493
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = TntFormShow
  DesignSize = (
    493
    356)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TTntBevel
    Left = 0
    Top = 314
    Width = 493
    Height = 8
    Align = alTop
    Shape = bsTopLine
  end
  object OkButton: TTntButton
    Left = 404
    Top = 324
    Width = 77
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object Panel1: TTntPanel
    Left = 0
    Top = 0
    Width = 493
    Height = 314
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = True
    TabOrder = 0
    DesignSize = (
      493
      314)
    object BackgroundImage: TImage
      Left = 112
      Top = 61
      Width = 394
      Height = 386
      Anchors = [akTop, akRight]
      AutoSize = True
      Transparent = True
    end
    object Image3: TTntImage
      Left = 0
      Top = 0
      Width = 493
      Height = 68
      Align = alTop
      Transparent = True
    end
    object MainLabel: TTntLabel
      Left = 12
      Top = 72
      Width = 469
      Height = 173
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = '<url>'
      Transparent = True
      WordWrap = True
    end
    object Label12: TTntLabel
      Left = 12
      Top = 256
      Width = 469
      Height = 29
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = 
        'Please do not contact the developers personally, but use the FMA' +
        ' website mentioned bellow if you want to post Bug Reports or Fea' +
        'ture Requests:'
      Transparent = True
      WordWrap = True
    end
    object lbForumsURL: TTntLabel
      Left = 12
      Top = 292
      Width = 75
      Height = 13
      Cursor = crHandPoint
      Hint = 'http://fma.sourceforge.net/'
      Anchors = [akLeft, akBottom]
      Caption = 'Project Website'
      Transparent = True
      OnClick = OpenWebLinkClick
    end
    object TntLabel1: TTntLabel
      Left = 92
      Top = 292
      Width = 16
      Height = 13
      Alignment = taCenter
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = '|'
      Transparent = True
    end
    object lbLicenseURL: TTntLabel
      Left = 116
      Top = 292
      Width = 91
      Height = 13
      Cursor = crHandPoint
      Anchors = [akLeft, akBottom]
      Caption = 'License Agreement'
      Transparent = True
      OnClick = OpenWebLinkClick
    end
    object TntLabel3: TTntLabel
      Left = 212
      Top = 292
      Width = 16
      Height = 13
      Alignment = taCenter
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = '|'
      Transparent = True
    end
    object lbDonateURL: TTntLabel
      Left = 236
      Top = 292
      Width = 53
      Height = 13
      Cursor = crHandPoint
      Hint = 'http://order.kagi.com/?6CYME&lang=en'
      Anchors = [akLeft, akBottom]
      Caption = 'Support Us'
      Transparent = True
      OnClick = OpenWebLinkClick
    end
    object lbVersion: TTntLabel
      Left = 435
      Top = 292
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Caption = '<version>'
      Transparent = True
    end
    object ContributorsPanel: TTntPanel
      Left = 12
      Top = 94
      Width = 469
      Height = 151
      BevelOuter = bvNone
      ParentBackground = True
      TabOrder = 0
      Visible = False
      object CreditsText: TTntMemo
        Left = 0
        Top = 0
        Width = 469
        Height = 151
        Align = alClient
        Alignment = taCenter
        BiDiMode = bdRightToLeft
        Lines.Strings = (
          ':: CREDITS ::'
          ''
          'Warren,'
          'Crino77,'
          'Dako,'
          'LordLarry,'
          'vo.x,'
          'VoSSy,'
          'Carl-Magnus,'
          'Christian Hans,'
          'Guajon Petursson,'
          'GOwin,'
          'Shaw0,'
          'Ju Ming,'
          'Mimzo,'
          'Arnoldc,'
          'Lethal,'
          'Laffen,'
          'Epedemic,'
          'Rog,'
          'PananzaMan,'
          'Garyd9,'
          'Thomas,'
          'Mindstormpt,'
          'tdjohnston,'
          'boocko,'
          'Kevin Davison,'
          'Todd_jg,'
          'Lexy,'
          'Gravanov,'
          'Iceberg,'
          'Otherland,'
          'mhr'
          '...'
          ''
          ':: DESIGN ::'
          ''
          'Dako,'
          'Alex Yeo,'
          'Stefan Jaeger'
          '...'
          ''
          ':: FORUMS ::'
          ''
          'Sebastian Baciu,'
          'ExpertOne,'
          'Dako'
          '...'
          ''
          ':: SCRIPTS ::'
          ''
          'streawkceur,'
          'CarpeDi3m,'
          'Ultimatex,'
          'Bramus!,'
          'mhr'
          '...'
          ''
          ':: LOCALIZATIONS ::'
          ''
          '<localization-list>'
          '...'
          ''
          'Thanks to all!')
        ParentBiDiMode = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  object MoreButton: TTntButton
    Left = 12
    Top = 324
    Width = 77
    Height = 25
    Caption = 'Credits'
    TabOrder = 2
    OnClick = MoreButtonClick
  end
end
