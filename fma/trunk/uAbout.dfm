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
    TabOrder = 3
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
    TabOrder = 0
    DesignSize = (
      493
      314)
    object Image3: TTntImage
      Left = 0
      Top = 0
      Width = 493
      Height = 68
      Align = alTop
    end
    object lbVersion: TTntLabel
      Left = 242
      Top = 25
      Width = 46
      Height = 13
      Caption = '<version>'
      Transparent = True
    end
    object Label3: TTntLabel
      Left = 12
      Top = 72
      Width = 323
      Height = 13
      Caption = 
        'This software product is licensed under terms and conditions of ' +
        'GPL.'
      Transparent = True
    end
    object Label12: TTntLabel
      Left = 12
      Top = 264
      Width = 469
      Height = 29
      AutoSize = False
      Caption = 
        'Please use the FMA website mentioned bellow if you want to post ' +
        'Bug reports or Feature requests. Do not contact the developers p' +
        'ersonally.'
      Transparent = True
      WordWrap = True
    end
    object lbURL: TTntLabel
      Left = 12
      Top = 292
      Width = 23
      Height = 13
      Cursor = crHandPoint
      Anchors = [akLeft, akBottom]
      Caption = '<url>'
      Transparent = True
      OnClick = lbURLClick
    end
    object TntPanel1: TTntPanel
      Left = 12
      Top = 94
      Width = 469
      Height = 163
      BevelOuter = bvNone
      TabOrder = 0
      object CreditsText: TTntMemo
        Left = 0
        Top = 0
        Width = 469
        Height = 163
        Align = alClient
        Alignment = taCenter
        BiDiMode = bdRightToLeft
        Lines.Strings = (
          '(in order of appearance):'
          ''
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
  object DonateButton: TTntButton
    Left = 100
    Top = 324
    Width = 77
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Donate...'
    TabOrder = 2
    OnClick = DonateButtonClick
  end
  object LicenseButton: TTntButton
    Left = 12
    Top = 324
    Width = 77
    Height = 25
    Caption = 'License...'
    TabOrder = 1
    OnClick = LicenseButtonClick
  end
end
