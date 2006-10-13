object frmEditor: TfrmEditor
  Left = 0
  Top = 0
  Width = 443
  Height = 273
  Align = alClient
  TabOrder = 0
  object MessagesSplitter1: TTntSplitter
    Left = 0
    Top = 236
    Width = 443
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    Color = clBtnFace
    ParentColor = False
    Visible = False
    OnMoved = MessagesSplitter1Moved
  end
  object MessagesPanel: TTntPanel
    Left = 0
    Top = 239
    Width = 443
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    Visible = False
    object Panel1: TTntPanel
      Left = 424
      Top = 0
      Width = 19
      Height = 34
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        19
        34)
      object sbClose: TTntSpeedButton
        Left = 1
        Top = 0
        Width = 16
        Height = 15
        Anchors = [akTop, akRight]
        Flat = True
        Glyph.Data = {
          D6000000424DD60000000000000076000000280000000C0000000C0000000100
          0400000000006000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          0000333333333333000033333333333300003300333300330000333003300333
          0000333300003333000033333003333300003333000033330000333003300333
          0000330033330033000033333333333300003333333333330000}
        OnClick = sbCloseClick
      end
    end
    object MessagesMemo1: TTntMemo
      Left = 0
      Top = 0
      Width = 424
      Height = 34
      Align = alClient
      ReadOnly = True
      TabOrder = 1
      OnChange = MessagesMemo1Change
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 443
    Height = 236
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    TabOrder = 1
    object DetailsPanel: TTntPanel
      Left = 0
      Top = 0
      Width = 439
      Height = 20
      Align = alTop
      Alignment = taLeftJustify
      TabOrder = 0
      DesignSize = (
        439
        20)
      object sbSave: TSpeedButton
        Left = 20
        Top = 1
        Width = 18
        Height = 18
        Hint = 'Save Script'
        Anchors = [akTop, akRight]
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000D4D4FDD4D4FD
          D4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4
          FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FD6E5B4D5E4B3D53413853413853413846
          332D433428433428392A2336231D36231D2B1C18291D13D4D4FDD4D4FD7C6158
          E4CAA3E2C79EE0C398403020C0B8B0C0B8B0D0C0C0D0C8C03C3C3CD3B27DD2B0
          7AD1AF782B1C18D4D4FDD4D4FD7E685DE6CDA7E4CAA2E2C69E70585040403090
          7870F0E0E0F0E8E0908070D4B480D3B27DD2B07B36231DD4D4FDD4D4FD7E6B5D
          E9CFACE6CDA8E4CAA2705850000000404030F0D8D0F0E0D0807860D6B683D5B4
          80D3B27D392A23D4D4FDD4D4FD816A63EAD2B1E9CFACE6CDA770585070585070
          5850705850706050806860D7B887D6B683D4B480392A23D4D4FDD4D4FD8E786D
          ECD5B6EAD2B1E8CFADE6CCA8E3C9A3E2C69EE0C499DEC094DBBE90DABB8CD8B9
          88D6B683433428D4D4FDD4D4FD917A73EFD9BBECD6B7D06060C06050C05850C0
          5040B05030B04830A04020A03810DABB8BD8B887433428D4D4FDD4D4FD938178
          F1DBC0D06860FFFFFFFFFFFFFFF8F0F0F0F0F0E8E0F0D8D0E0D0C0E0C8C0A038
          10DABB8B46332DD4D4FDD4D4FD96837DF2DEC4D07070FFFFFFFFFFFFFFFFFFFF
          F8F0F0F0F0F0E8E0F0D8D0E0D0C0A04020DBBE8F534138D4D4FDD4D4FDA39188
          F5E0C8E07870FFFFFFFFFFFFFFFFFFFFFFFFFFF8F0F0F0F0F0E8E0F0D8D0B048
          30DEC095534138D4D4FDD4D4FDA39488F6E3CBE08080FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFF8F0F0F0F0F0E8E0B05030E0C399534138D4D4FDD4D4FDA99A93
          F7E5CFF08890FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F0F0F0F0C050
          406030305E4B3DD4D4FDD4D4FDA99A93F9E7D2FF9090FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFF8F0C05850E4CAA2614A43D4D4FDD4D4FDA99D93
          A99D93A99A93A99A93A6938DA3918896837D938178938178917A738E786D816A
          637E6B5D7E685DD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4
          D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FDD4D4FD}
        ParentShowHint = False
        ShowHint = True
        Visible = False
        OnClick = SaveChanges1Click
      end
      object lblCaption: TTntLabel
        Left = 4
        Top = 3
        Width = 4
        Height = 13
        Caption = '*'
      end
    end
    object Script: TSynMemo
      Left = 0
      Top = 20
      Width = 439
      Height = 212
      Cursor = crIBeam
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 1
      BorderStyle = bsNone
      Gutter.Font.Charset = DEFAULT_CHARSET
      Gutter.Font.Color = clWindowText
      Gutter.Font.Height = -11
      Gutter.Font.Name = 'Tahoma'
      Gutter.Font.Style = []
      Gutter.LeftOffset = 0
      Gutter.ShowLineNumbers = True
      Highlighter = SynVBScriptSyn1
      Keystrokes = <
        item
          Command = ecUp
          ShortCut = 38
        end
        item
          Command = ecSelUp
          ShortCut = 8230
        end
        item
          Command = ecScrollUp
          ShortCut = 16422
        end
        item
          Command = ecDown
          ShortCut = 40
        end
        item
          Command = ecSelDown
          ShortCut = 8232
        end
        item
          Command = ecScrollDown
          ShortCut = 16424
        end
        item
          Command = ecLeft
          ShortCut = 37
        end
        item
          Command = ecSelLeft
          ShortCut = 8229
        end
        item
          Command = ecWordLeft
          ShortCut = 16421
        end
        item
          Command = ecSelWordLeft
          ShortCut = 24613
        end
        item
          Command = ecRight
          ShortCut = 39
        end
        item
          Command = ecSelRight
          ShortCut = 8231
        end
        item
          Command = ecWordRight
          ShortCut = 16423
        end
        item
          Command = ecSelWordRight
          ShortCut = 24615
        end
        item
          Command = ecPageDown
          ShortCut = 34
        end
        item
          Command = ecSelPageDown
          ShortCut = 8226
        end
        item
          Command = ecPageBottom
          ShortCut = 16418
        end
        item
          Command = ecSelPageBottom
          ShortCut = 24610
        end
        item
          Command = ecPageUp
          ShortCut = 33
        end
        item
          Command = ecSelPageUp
          ShortCut = 8225
        end
        item
          Command = ecPageTop
          ShortCut = 16417
        end
        item
          Command = ecSelPageTop
          ShortCut = 24609
        end
        item
          Command = ecLineStart
          ShortCut = 36
        end
        item
          Command = ecSelLineStart
          ShortCut = 8228
        end
        item
          Command = ecEditorTop
          ShortCut = 16420
        end
        item
          Command = ecSelEditorTop
          ShortCut = 24612
        end
        item
          Command = ecLineEnd
          ShortCut = 35
        end
        item
          Command = ecSelLineEnd
          ShortCut = 8227
        end
        item
          Command = ecEditorBottom
          ShortCut = 16419
        end
        item
          Command = ecSelEditorBottom
          ShortCut = 24611
        end
        item
          Command = ecToggleMode
          ShortCut = 45
        end
        item
          Command = ecCopy
          ShortCut = 16429
        end
        item
          Command = ecCut
          ShortCut = 8238
        end
        item
          Command = ecPaste
          ShortCut = 8237
        end
        item
          Command = ecDeleteChar
          ShortCut = 46
        end
        item
          Command = ecDeleteLastChar
          ShortCut = 8
        end
        item
          Command = ecDeleteLastChar
          ShortCut = 8200
        end
        item
          Command = ecDeleteLastWord
          ShortCut = 16392
        end
        item
          Command = ecUndo
          ShortCut = 32776
        end
        item
          Command = ecRedo
          ShortCut = 40968
        end
        item
          Command = ecLineBreak
          ShortCut = 13
        end
        item
          Command = ecLineBreak
          ShortCut = 8205
        end
        item
          Command = ecTab
          ShortCut = 9
        end
        item
          Command = ecShiftTab
          ShortCut = 8201
        end
        item
          Command = ecContextHelp
          ShortCut = 16496
        end
        item
          Command = ecSelectAll
          ShortCut = 16449
        end
        item
          Command = ecCopy
          ShortCut = 16451
        end
        item
          Command = ecPaste
          ShortCut = 16470
        end
        item
          Command = ecCut
          ShortCut = 16472
        end
        item
          Command = ecBlockIndent
          ShortCut = 24649
        end
        item
          Command = ecBlockUnindent
          ShortCut = 24661
        end
        item
          Command = ecLineBreak
          ShortCut = 16461
        end
        item
          Command = ecInsertLine
          ShortCut = 16462
        end
        item
          Command = ecDeleteWord
          ShortCut = 16468
        end
        item
          Command = ecDeleteLine
          ShortCut = 16473
        end
        item
          Command = ecDeleteEOL
          ShortCut = 24665
        end
        item
          Command = ecUndo
          ShortCut = 16474
        end
        item
          Command = ecRedo
          ShortCut = 24666
        end
        item
          Command = ecGotoMarker0
          ShortCut = 16432
        end
        item
          Command = ecGotoMarker1
          ShortCut = 16433
        end
        item
          Command = ecGotoMarker2
          ShortCut = 16434
        end
        item
          Command = ecGotoMarker3
          ShortCut = 16435
        end
        item
          Command = ecGotoMarker4
          ShortCut = 16436
        end
        item
          Command = ecGotoMarker5
          ShortCut = 16437
        end
        item
          Command = ecGotoMarker6
          ShortCut = 16438
        end
        item
          Command = ecGotoMarker7
          ShortCut = 16439
        end
        item
          Command = ecGotoMarker8
          ShortCut = 16440
        end
        item
          Command = ecGotoMarker9
          ShortCut = 16441
        end
        item
          Command = ecSetMarker0
          ShortCut = 24624
        end
        item
          Command = ecSetMarker1
          ShortCut = 24625
        end
        item
          Command = ecSetMarker2
          ShortCut = 24626
        end
        item
          Command = ecSetMarker3
          ShortCut = 24627
        end
        item
          Command = ecSetMarker4
          ShortCut = 24628
        end
        item
          Command = ecSetMarker5
          ShortCut = 24629
        end
        item
          Command = ecSetMarker6
          ShortCut = 24630
        end
        item
          Command = ecSetMarker7
          ShortCut = 24631
        end
        item
          Command = ecSetMarker8
          ShortCut = 24632
        end
        item
          Command = ecSetMarker9
          ShortCut = 24633
        end
        item
          Command = ecNormalSelect
          ShortCut = 24654
        end
        item
          Command = ecColumnSelect
          ShortCut = 24643
        end
        item
          Command = ecLineSelect
          ShortCut = 24652
        end
        item
          Command = ecMatchBracket
          ShortCut = 24642
        end>
      MaxLeftChar = 2048
      MaxUndo = 4096
      Options = [eoAutoIndent, eoDragDropEditing, eoDropFiles, eoGroupUndo, eoKeepCaretX, eoScrollPastEol, eoShowScrollHint, eoSmartTabDelete, eoSmartTabs, eoTabIndent, eoTabsToSpaces, eoTrimTrailingSpaces]
      RightEdge = 120
      TabWidth = 4
      WantTabs = True
      OnChange = ScriptChange
      OnReplaceText = ScriptReplaceText
      OnStatusChange = ScriptStatusChange
    end
  end
  object PrecompileTimer1: TTimer
    Enabled = False
    OnTimer = PrecompileTimer1Timer
    Left = 64
    Top = 44
  end
  object SynVBScriptSyn1: TSynVBScriptSyn
    DefaultFilter = 'VBScript Files (*.vbs)|*.vbs'
    CommentAttri.Foreground = clGreen
    CommentAttri.Style = []
    KeyAttri.Foreground = clNavy
    KeyAttri.Style = []
    StringAttri.Foreground = clMaroon
    Left = 96
    Top = 44
  end
  object PopupMenu1: TTntPopupMenu
    Images = Form1.ImageList2
    OnPopup = PopupMenu1Popup
    Left = 160
    Top = 44
    object FindNextError1: TTntMenuItem
      Caption = 'Check Script Syntax'
      ImageIndex = 51
      ShortCut = 16504
      OnClick = FindNextError1Click
    end
    object N4: TTntMenuItem
      Caption = '-'
    end
    object Find1: TTntMenuItem
      Caption = 'Find...'
      ImageIndex = 0
      ShortCut = 16454
      OnClick = Find1Click
    end
    object FindNext1: TTntMenuItem
      Caption = 'Find Next'
      ShortCut = 114
      OnClick = FindNext1Click
    end
    object Replace1: TTntMenuItem
      Caption = 'Replace...'
      ShortCut = 16456
      OnClick = Replace1Click
    end
    object N2: TTntMenuItem
      Caption = '-'
    end
    object Delete1: TTntMenuItem
      Action = Form1.ActionDelete
    end
    object N5: TTntMenuItem
      Caption = '-'
    end
    object SelectAll1: TTntMenuItem
      Action = Form1.ActionSelectAll
    end
    object N6: TTntMenuItem
      Caption = '-'
    end
    object LoadFromFile1: TTntMenuItem
      Caption = 'Open Script...'
      ShortCut = 16463
      OnClick = LoadFromFile1Click
    end
    object SaveChanges1: TTntMenuItem
      Caption = '&Save Changes'
      ImageIndex = 44
      ShortCut = 16467
      OnClick = SaveChanges1Click
    end
    object N1: TTntMenuItem
      Caption = '-'
    end
    object ScriptingOptions1: TTntMenuItem
      Caption = 'Scripting Options...'
      ImageIndex = 34
      OnClick = ScriptingOptions1Click
    end
  end
  object ReplaceDialog1: TReplaceDialog
    OnFind = ReplaceDialog1Find
    OnReplace = ReplaceDialog1Find
    Left = 128
    Top = 44
  end
  object OpenDialog1: TTntOpenDialog
    Filter = 
      'VBScript (*.vbscript)|*.vbscript;*.vbs|JScript (*.jscript)|*.jsc' +
      'ript|All Files|*.*'
    Title = 'Open Script File...'
    Left = 192
    Top = 44
  end
  object SaveDialog1: TTntSaveDialog
    Filter = 
      'VBScript (*.vbscript)|*.vbscript;*.vbs|JScript (*.jscript)|*.jsc' +
      'ript|All Files|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Save Script File As...'
    Left = 224
    Top = 44
  end
end
