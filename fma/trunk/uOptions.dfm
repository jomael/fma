object frmOptions: TfrmOptions
  Left = 292
  Top = 158
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'FMA Options'
  ClientHeight = 395
  ClientWidth = 618
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = TntFormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    618
    395)
  PixelsPerInch = 96
  TextHeight = 13
  object LMDFill1: TLMDFill
    Left = 196
    Top = 8
    Width = 413
    Height = 26
    Bevel.Mode = bmCustom
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clWindowText
    Caption.Font.Height = -11
    Caption.Font.Name = 'Tahoma'
    Caption.Font.Style = []
    Color = clBtnShadow
    FillObject.Style = sfGradient
    FillObject.Gradient.Color = clHighlight
    FillObject.Gradient.ColorCount = 128
    FillObject.Gradient.Style = gstHorizontal
    FillObject.Gradient.EndColor = clBtnFace
    ParentColor = False
    Anchors = [akTop, akRight]
  end
  object lblPageCaption: TTntLabel
    Left = 204
    Top = 8
    Width = 405
    Height = 25
    Anchors = [akTop, akRight]
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clCaptionText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Bevel1: TBevel
    Left = 196
    Top = 36
    Width = 413
    Height = 9
    Anchors = [akTop, akRight]
    Shape = bsTopLine
  end
  object ImageAutoLang: TTntImage
    Left = 220
    Top = 370
    Width = 23
    Height = 14
    Picture.Data = {
      07544269746D617026040000424D260400000000000036000000280000001700
      00000E0000000100180000000000F0030000120B0000120B0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000EAEAEAF1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1
      F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1
      F1F1F1F1F1F1F1F1F1EAEAEA000000000000000000F1F1F1FFFFFFFFFFFFFFFF
      FFFFFFFF777E835D4F5BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F1F1000000000000000000F1F1F1
      FFFFFFFFFFFFFFFFFFFFFFFF7EAFD65582C769576AE4DDDDFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F1F100000000
      0000000000F1F1F1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF67B7F5567DC16E5C70
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFF1F1F1000000000000000000F1F1F1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7
      F2FA67B6F55788CB706F77BEACA59FA0AAACA3A5E0CAC0FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFF1F1F1000000000000000000F1F1F1FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFF9CBFDAB08F83D8BB9CF0EDC6EBE5C6C9AB98BE
      AFABFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F1F1000000000000000000F1F1F1
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE5D3CDD8B899F9F2BEF5FA
      D5F6FAF0F8FEFCAF8D76FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F1F100000000
      0000000000F1F1F1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDEC6BE
      F0E8BFF5DDABF5F9D0F5F9E3F5F9DFBAA388FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFF1F1F1000000000000000000F1F1F1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFDFC8C1EADFBAF5E3BDF5F0BEF5F4C6F6F4C5A19581FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFF1F1F1000000000000000000F1F1F1FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFE0D7D6CDAB96F8FBF9F5EBC2F6D7A7EAE4B5A8
      7D68FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F1F1000000000000000000F1F1F1
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE1D3CFC7A99AD6BF
      A3D5BBA0B48873FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F1F100000000
      0000000000EAEAEAF1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1
      F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1
      F1EAEAEA00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000}
    Visible = False
  end
  object OptionPages: TTntPageControl
    Left = 196
    Top = 40
    Width = 413
    Height = 317
    ActivePage = tabStartup
    Anchors = [akTop, akRight, akBottom]
    MultiLine = True
    Style = tsButtons
    TabOrder = 1
    OnChange = OptionPagesChange
    object tabConnectivity: TTntTabSheet
      Caption = 'Connectivity'
      ImageIndex = 28
      TabVisible = False
      object GroupBox17: TTntGroupBox
        Left = 4
        Top = 0
        Width = 397
        Height = 93
        Caption = 'Connect to Phone via'
        TabOrder = 0
        object rbUseIRDA: TTntRadioButton
          Tag = 1
          Left = 8
          Top = 42
          Width = 369
          Height = 17
          Caption = 'Native IrDA Port (Requires Windows 2000 or later)'
          TabOrder = 1
          OnClick = rbUseSerialClick
        end
        object rbUseSerial: TTntRadioButton
          Tag = 2
          Left = 8
          Top = 66
          Width = 369
          Height = 17
          Caption = 'Serial/Virtual Port (If none of the above worked)'
          Checked = True
          TabOrder = 2
          TabStop = True
          OnClick = rbUseSerialClick
        end
        object rbUseBluetooth: TTntRadioButton
          Left = 8
          Top = 18
          Width = 369
          Height = 17
          Caption = 'Native Bluetooth (Requires Windows XP SP1 or later)'
          TabOrder = 0
          OnClick = rbUseSerialClick
        end
      end
      object TntGroupBox11: TTntGroupBox
        Left = 4
        Top = 228
        Width = 397
        Height = 77
        Caption = 'Helper'
        TabOrder = 1
        object lblConnectionHelp: TTntLabel
          Left = 10
          Top = 18
          Width = 375
          Height = 22
          AutoSize = False
          Caption = '*'
          WordWrap = True
        end
        object lblDevice: TTntLabel
          Left = 10
          Top = 46
          Width = 219
          Height = 27
          AutoSize = False
          Caption = '*'
          ParentShowHint = False
          ShowHint = True
          WordWrap = True
        end
        object btnLookupDevice: TTntButton
          Left = 240
          Top = 40
          Width = 69
          Height = 25
          Caption = '&Lookup'
          TabOrder = 0
          OnClick = btnLookupDeviceClick
        end
        object btnConnectWizard: TTntButton
          Left = 316
          Top = 40
          Width = 69
          Height = 25
          Caption = 'Wizard...'
          TabOrder = 1
          OnClick = btnConnectWizardClick
        end
      end
      object pcConnectDetails: TPageControl
        Left = 0
        Top = 94
        Width = 405
        Height = 135
        ActivePage = tsConnectCOM
        Style = tsButtons
        TabOrder = 2
        object tsConnectBT: TTabSheet
          Caption = 'tsConnectBT'
          TabVisible = False
          object groupBluetoothSetup: TTntGroupBox
            Left = 0
            Top = 0
            Width = 397
            Height = 121
            Caption = 'Bluetooth Setup'
            TabOrder = 0
            object Label14: TTntLabel
              Left = 220
              Top = 60
              Width = 19
              Height = 13
              Caption = 'Port'
              Transparent = True
            end
            object Label13: TTntLabel
              Left = 10
              Top = 16
              Width = 65
              Height = 13
              Caption = 'Device Name'
              Transparent = True
            end
            object TntLabel23: TTntLabel
              Left = 10
              Top = 60
              Width = 75
              Height = 13
              Caption = 'Device Address'
              Transparent = True
            end
            object cbBTDevice: TTntComboBox
              Left = 10
              Top = 32
              Width = 299
              Height = 21
              Style = csDropDownList
              ItemHeight = 13
              TabOrder = 0
              OnSelect = cbBTDeviceSelect
            end
            object edBTPort: TTntEdit
              Left = 220
              Top = 76
              Width = 72
              Height = 21
              TabOrder = 3
              Text = '0'
            end
            object edBTPortSpin: TTntUpDown
              Left = 292
              Top = 76
              Width = 15
              Height = 21
              Associate = edBTPort
              Max = 99
              TabOrder = 4
            end
            object edBTAddress: TTntEdit
              Left = 10
              Top = 76
              Width = 203
              Height = 21
              MaxLength = 30
              TabOrder = 2
              OnChange = edBTAddressChange
            end
            object btnBTSearch: TTntButton
              Left = 316
              Top = 32
              Width = 69
              Height = 25
              Caption = 'Search'
              TabOrder = 1
              OnClick = btnBTSearchClick
            end
          end
        end
        object tsConnectIR: TTabSheet
          Caption = 'tsConnectIR'
          ImageIndex = 1
          TabVisible = False
          object TntGroupBox12: TTntGroupBox
            Left = 0
            Top = 0
            Width = 397
            Height = 121
            Caption = 'Infra-Red Setup'
            TabOrder = 0
          end
        end
        object tsConnectCOM: TTabSheet
          Caption = 'tsConnectCOM'
          ImageIndex = 2
          TabVisible = False
          object groupSerialPortSetup: TTntGroupBox
            Left = 0
            Top = 0
            Width = 397
            Height = 121
            Caption = 'Serial Port Setup'
            TabOrder = 0
            object Label6: TTntLabel
              Left = 201
              Top = 16
              Width = 22
              Height = 13
              Caption = 'RTS'
              Transparent = True
            end
            object Label7: TTntLabel
              Left = 297
              Top = 16
              Width = 23
              Height = 13
              Caption = 'DTR'
              Transparent = True
            end
            object Label2: TTntLabel
              Left = 105
              Top = 16
              Width = 43
              Height = 13
              Caption = 'Baudrate'
              Transparent = True
            end
            object Label1: TTntLabel
              Left = 10
              Top = 16
              Width = 19
              Height = 13
              Caption = 'Port'
              Transparent = True
            end
            object TntLabel24: TTntLabel
              Left = 10
              Top = 80
              Width = 375
              Height = 33
              AutoSize = False
              Caption = 
                'If you'#39're going to use a Bluetooth Virtual COM port, make sure i' +
                't is already created in your Bluetooth device'#39's settings.'
              WordWrap = True
            end
            object cbRTSFlow: TTntComboBox
              Left = 201
              Top = 32
              Width = 89
              Height = 21
              Style = csDropDownList
              ItemHeight = 13
              ItemIndex = 2
              TabOrder = 2
              Text = 'Handshake'
              Items.Strings = (
                'Disabled'
                'Enabled'
                'Handshake'
                'Toggle')
            end
            object cbDTRFlow: TTntComboBox
              Left = 297
              Top = 32
              Width = 89
              Height = 21
              Style = csDropDownList
              ItemHeight = 13
              ItemIndex = 2
              TabOrder = 3
              Text = 'Handshake'
              Items.Strings = (
                'Disabled'
                'Enabled'
                'Handshake')
            end
            object sePort: TComComboBox
              Left = 10
              Top = 32
              Width = 88
              Height = 21
              ComPort = LocalComPort
              ComProperty = cpPort
              Text = 'COM4'
              Style = csDropDownList
              ItemHeight = 13
              ItemIndex = 3
              TabOrder = 0
            end
            object cbBaudrate: TComComboBox
              Left = 105
              Top = 32
              Width = 89
              Height = 21
              ComPort = LocalComPort
              ComProperty = cpBaudRate
              Text = '115200'
              Style = csDropDownList
              ItemHeight = 13
              ItemIndex = 13
              TabOrder = 1
            end
          end
        end
      end
    end
    object tabStartup: TTntTabSheet
      Caption = 'General'
      ImageIndex = 32
      TabVisible = False
      object gbOnConnected1: TTntGroupBox
        Left = 208
        Top = 0
        Width = 193
        Height = 65
        Caption = 'Connection Startup'
        TabOrder = 2
        object cbAutoProfile: TTntCheckBox
          Left = 10
          Top = 38
          Width = 175
          Height = 17
          Caption = 'Restore Last Used Profile'
          TabOrder = 1
        end
        object cbAutoClock: TTntCheckBox
          Left = 10
          Top = 18
          Width = 175
          Height = 17
          Caption = 'Validate Phone Clock'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
      end
      object gbOnConnecting: TTntGroupBox
        Left = 4
        Top = 72
        Width = 193
        Height = 125
        Caption = 'When Connecting'
        TabOrder = 1
        object cbNoGroups: TTntCheckBox
          Left = 10
          Top = 18
          Width = 175
          Height = 17
          Caption = 'Do not retrieve Groups'
          TabOrder = 0
        end
        object cbNoFolders: TTntCheckBox
          Left = 10
          Top = 38
          Width = 175
          Height = 17
          Caption = 'Do not retrieve Files / Folders'
          TabOrder = 1
        end
        object cbNoProfiles: TTntCheckBox
          Left = 10
          Top = 58
          Width = 175
          Height = 17
          Caption = 'Do not retrieve Profiles'
          TabOrder = 2
          OnClick = cbNoProfilesClick
        end
        object cbNoCalls: TTntCheckBox
          Left = 10
          Top = 78
          Width = 175
          Height = 17
          Caption = 'Do not retrieve Calls'
          TabOrder = 3
        end
        object cbNoAlarms: TTntCheckBox
          Left = 10
          Top = 98
          Width = 175
          Height = 17
          Caption = 'Do not retrieve Alarms'
          TabOrder = 4
        end
      end
      object rgExplorer: TTntRadioGroup
        Left = 4
        Top = 204
        Width = 397
        Height = 89
        Caption = 'Phone Explorer Startup folder:'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'FMA Today Page'
          'Messages Inbox Folder'
          'Messages Archive Folder'
          'Phonebook (Phone memory)'
          'Phonebook (SIM memory)'
          'Organizer Calendar Page')
        TabOrder = 4
      end
      object gbOnStartup: TTntGroupBox
        Left = 4
        Top = 0
        Width = 193
        Height = 65
        Caption = 'Application Startup'
        TabOrder = 0
        object cbShowSplash: TTntCheckBox
          Left = 10
          Top = 38
          Width = 175
          Height = 17
          Caption = 'Show Splash Screen on startup'
          TabOrder = 1
        end
        object cbAlwaysMinimized: TTntCheckBox
          Left = 10
          Top = 18
          Width = 175
          Height = 17
          Caption = 'Always start FMA Minimized'
          TabOrder = 0
          OnClick = cbAlwaysMinimizedClick
        end
      end
      object gbOnConnected2: TTntGroupBox
        Left = 208
        Top = 72
        Width = 193
        Height = 125
        Caption = 'When Connected'
        TabOrder = 3
        object cbAutoInbox: TTntCheckBox
          Left = 10
          Top = 18
          Width = 175
          Height = 17
          Caption = 'Synchronize Text Messages'
          TabOrder = 0
        end
        object cbAutoSync: TTntCheckBox
          Left = 10
          Top = 38
          Width = 175
          Height = 17
          Caption = 'Synchronize Phonebook'
          TabOrder = 1
        end
        object cbAutoCalendar: TTntCheckBox
          Left = 10
          Top = 58
          Width = 175
          Height = 17
          Caption = 'Synchronize Calendar'
          TabOrder = 2
        end
        object cbAutoBookmarks: TTntCheckBox
          Left = 10
          Top = 78
          Width = 175
          Height = 17
          Caption = 'Synchronize Bookmarks'
          TabOrder = 3
        end
        object cbAutoOutlookSync: TTntCheckBox
          Left = 10
          Top = 98
          Width = 175
          Height = 17
          Caption = 'Synchronize Microsoft Outlook'
          TabOrder = 4
        end
      end
    end
    object tabSynchronization: TTntTabSheet
      Caption = 'Synchronization'
      ImageIndex = 17
      TabVisible = False
      object rbSyncPhonebook: TTntRadioGroup
        Left = 4
        Top = 0
        Width = 397
        Height = 43
        Caption = 'Phonebook Priority'
        Columns = 3
        ItemIndex = 2
        Items.Strings = (
          'Phone'
          'PC'
          'Let me choose')
        TabOrder = 0
      end
      object rbSyncCalendar: TTntRadioGroup
        Left = 4
        Top = 50
        Width = 397
        Height = 43
        Caption = 'Calendar Priority'
        Columns = 3
        ItemIndex = 2
        Items.Strings = (
          'Phone'
          'PC'
          'Let me choose')
        TabOrder = 1
      end
      object rbPhoneClockSync: TTntRadioGroup
        Left = 4
        Top = 100
        Width = 397
        Height = 43
        Caption = 'Clock Priority'
        Columns = 3
        ItemIndex = 1
        Items.Strings = (
          'Phone'
          'PC'
          'Let me choose')
        TabOrder = 2
      end
      object rbOutlookSync: TTntRadioGroup
        Left = 4
        Top = 200
        Width = 397
        Height = 43
        Caption = 'Outlook Priority'
        Columns = 3
        ItemIndex = 2
        Items.Strings = (
          'Outlook'
          'FMA'
          'Let me choose')
        TabOrder = 4
      end
      object rbBookmarksSync: TTntRadioGroup
        Left = 4
        Top = 150
        Width = 397
        Height = 43
        Caption = 'Bookmarks Priority'
        Columns = 3
        ItemIndex = 2
        Items.Strings = (
          'Phone'
          'PC'
          'Let me choose')
        TabOrder = 3
      end
    end
    object tabOutlook: TTntTabSheet
      Caption = 'Microsoft Outlook'
      ImageIndex = 52
      TabVisible = False
      object grOutlookConfirmation: TTntGroupBox
        Left = 4
        Top = 0
        Width = 397
        Height = 89
        Caption = 'Outlook Confirmation'
        TabOrder = 0
        object cbConfirmAdding: TTntCheckBox
          Left = 10
          Top = 18
          Width = 175
          Height = 17
          Caption = 'Confirm Adding'
          TabOrder = 0
        end
        object cbConfirmUpdating: TTntCheckBox
          Left = 10
          Top = 41
          Width = 175
          Height = 17
          Caption = 'Confirm Updating'
          TabOrder = 1
        end
        object cbConfirmDeleting: TTntCheckBox
          Left = 10
          Top = 64
          Width = 175
          Height = 17
          Caption = 'Confirm Deleting'
          TabOrder = 2
        end
      end
      object TntGroupBox8: TTntGroupBox
        Left = 4
        Top = 96
        Width = 397
        Height = 153
        Caption = 'Outlook New Contacts Action'
        TabOrder = 1
        object TntLabel13: TTntLabel
          Left = 8
          Top = 66
          Width = 381
          Height = 33
          AutoSize = False
          Caption = 
            'When a new contact is found FMA could ask you to link it with al' +
            'ready existing one in Outlook, or reverse.'
          WordWrap = True
        end
        object TntLabel14: TTntLabel
          Left = 8
          Top = 100
          Width = 381
          Height = 49
          AutoSize = False
          Caption = 
            'You can break up a contact'#39's Linking in order to link it again t' +
            'o a different target. To do so, open Contact Properties, go to O' +
            'utlook Synchronization and click Unlink Contact button.'
          WordWrap = True
        end
        object rbOutlookNewActionLinkTo: TTntRadioButton
          Left = 8
          Top = 18
          Width = 175
          Height = 17
          Caption = 'Try Link to Existing'
          Checked = True
          TabOrder = 0
          TabStop = True
        end
        object rbOutlookNewActionAsNew: TTntRadioButton
          Left = 8
          Top = 42
          Width = 175
          Height = 17
          Caption = 'Always Add as New'
          TabOrder = 1
        end
      end
      object TntGroupBox16: TTntGroupBox
        Left = 4
        Top = 256
        Width = 397
        Height = 45
        Caption = 'Synchronize All'
        TabOrder = 2
        object cbOutlookNoSyncAll: TTntCheckBox
          Left = 10
          Top = 18
          Width = 375
          Height = 17
          Caption = 'Do not do Outlook Sync when performing Sync All operation'
          TabOrder = 0
        end
      end
    end
    object tabOutlookContactFolders: TTntTabSheet
      Caption = 'Contact Folders'
      ImageIndex = 21
      TabVisible = False
      object GroupBox14: TTntGroupBox
        Left = 4
        Top = 0
        Width = 397
        Height = 301
        Caption = 'Microsoft Outlook Folders'
        TabOrder = 0
        DesignSize = (
          397
          301)
        object Label27: TTntLabel
          Left = 10
          Top = 52
          Width = 183
          Height = 13
          Caption = 'Synchronize Contacts in these Folders:'
        end
        object Label29: TTntLabel
          Left = 10
          Top = 18
          Width = 375
          Height = 33
          AutoSize = False
          Caption = 
            'Please select which Outlook folders containing contacts to be sy' +
            'nchronized with FMA. Right-click to choose New Contacts target f' +
            'older (shown in bold).'
          WordWrap = True
        end
        object tvOutlookContactFolders: TVirtualStringTree
          Left = 10
          Top = 72
          Width = 297
          Height = 217
          Anchors = [akLeft, akTop, akRight, akBottom]
          Header.AutoSizeIndex = 0
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clWindowText
          Header.Font.Height = -11
          Header.Font.Name = 'Tahoma'
          Header.Font.Style = []
          Header.MainColumn = -1
          Header.Options = [hoColumnResize, hoDrag]
          Images = OutlookImageList
          PopupMenu = pmuOutlookContactsFolder
          TabOrder = 0
          TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoDeleteMovedNodes]
          TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
          TreeOptions.SelectionOptions = [toRightClickSelect]
          OnChange = tvOutlookContactFoldersChange
          OnChecked = tvOutlookContactFoldersChecked
          OnFreeNode = tvOutlookFoldersFreeNode
          OnGetText = tvOutlookFoldersGetText
          OnPaintText = tvOutlookFoldersPaintText
          OnGetImageIndex = tvOutlookFoldersGetImageIndex
          OnInitChildren = tvOutlookFoldersInitChildren
          OnInitNode = tvOutlookFoldersInitNode
          Columns = <>
        end
        object btnRefreshOutlookContactFolders: TTntButton
          Left = 316
          Top = 72
          Width = 69
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = '&Refresh'
          TabOrder = 1
          OnClick = btnRefreshOutlookContactFoldersClick
        end
        object btnDefaultNewContactDir: TTntButton
          Left = 316
          Top = 104
          Width = 69
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = 'Default'
          Enabled = False
          TabOrder = 2
          OnClick = btnDefaultNewContactDirClick
        end
      end
    end
    object tabOBEX: TTntTabSheet
      Caption = 'Protocols'
      ImageIndex = 14
      TabVisible = False
      object cbObexPacketSize: TTntGroupBox
        Left = 4
        Top = 72
        Width = 397
        Height = 105
        Caption = 'Max Packet Size'
        TabOrder = 1
        object lblObexPacketSize: TTntLabel
          Left = 10
          Top = 53
          Width = 375
          Height = 44
          AutoSize = False
          Caption = 
            'Define the maximum size per packet, this is the value to negotia' +
            'te with the Mobile Equipment and will use whichever lower. This ' +
            'implementation is Ericsson specific.'
          Transparent = True
          WordWrap = True
        end
        object TntLabel28: TTntLabel
          Left = 106
          Top = 23
          Width = 25
          Height = 13
          Caption = 'bytes'
        end
        object seMaxPacketSize: TTntEdit
          Left = 10
          Top = 20
          Width = 72
          Height = 21
          TabOrder = 0
          Text = '1'#160'024'
        end
        object seMaxPacketSizeSpin: TTntUpDown
          Left = 82
          Top = 20
          Width = 16
          Height = 21
          Associate = seMaxPacketSize
          Min = 255
          Max = 32767
          Position = 1024
          TabOrder = 1
        end
      end
      object GroupBox10: TTntGroupBox
        Left = 4
        Top = 0
        Width = 397
        Height = 65
        Caption = 'Protocol Settings'
        TabOrder = 0
        object cbNoObex: TTntCheckBox
          Left = 10
          Top = 18
          Width = 180
          Height = 17
          Caption = 'Disable OBEX'
          TabOrder = 0
          OnClick = cbNoObexClick
        end
        object cbNoIRMC: TTntCheckBox
          Left = 10
          Top = 38
          Width = 180
          Height = 17
          Caption = 'Disable IRMC Sync'
          TabOrder = 1
          OnClick = cbNoIRMCClick
        end
      end
    end
    object tabScripting: TTntTabSheet
      Caption = 'Scripting'
      ImageIndex = 15
      TabVisible = False
      object GroupBox12: TTntGroupBox
        Left = 4
        Top = 0
        Width = 397
        Height = 173
        Caption = 'Scripting Engine'
        TabOrder = 0
        DesignSize = (
          397
          173)
        object lblScript: TTntLabel
          Left = 26
          Top = 90
          Width = 99
          Height = 13
          Caption = 'Main script file name:'
        end
        object edScriptPath: TTntEdit
          Left = 26
          Top = 106
          Width = 359
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 3
          OnChange = edScriptPathChange
        end
        object ScriptBrowseButton: TTntButton
          Left = 308
          Top = 136
          Width = 77
          Height = 25
          Anchors = [akLeft, akTop, akRight]
          Caption = 'B&rowse...'
          TabOrder = 4
          OnClick = ScriptBrowseButtonClick
        end
        object cbDoNotUseScripts: TTntRadioButton
          Left = 8
          Top = 18
          Width = 375
          Height = 17
          Caption = 'Disabled'
          TabOrder = 0
          OnClick = cbUseScriptsClick
        end
        object cbUseScriptingFramework: TTntRadioButton
          Left = 8
          Top = 42
          Width = 375
          Height = 17
          Caption = 'Use Scripting Framework (usualy installed by FMA setup)'
          TabOrder = 1
          OnClick = cbUseScriptsClick
        end
        object cbUseScripts: TTntRadioButton
          Left = 8
          Top = 66
          Width = 375
          Height = 17
          Caption = 'Use Custom Script file which I will chose'
          Checked = True
          TabOrder = 2
          TabStop = True
          OnClick = cbUseScriptsClick
        end
      end
      object GroupBox19: TTntGroupBox
        Left = 4
        Top = 180
        Width = 397
        Height = 113
        Caption = 'Details'
        TabOrder = 1
        object lblSTypePrefix: TTntLabel
          Left = 10
          Top = 88
          Width = 94
          Height = 13
          Caption = 'Current Script Type:'
        end
        object lblScriptType: TTntLabel
          Left = 116
          Top = 88
          Width = 37
          Height = 13
          Caption = 'vbscript'
          Transparent = True
        end
        object Label10: TTntLabel
          Left = 10
          Top = 18
          Width = 379
          Height = 67
          AutoSize = False
          Caption = 
            'Note that script file extension must be the scipting engine used' +
            ', for example for "MyScript.VBScript" the system will interprate' +
            ' it using VBScript Engine. In most cases FMA will need to be res' +
            'tarted to fully activate the selected script.'
          ShowAccelChar = False
          Transparent = True
          WordWrap = True
        end
      end
    end
    object tabAppearance: TTntTabSheet
      Caption = 'Appearance'
      ImageIndex = 43
      TabVisible = False
      object GroupBox8: TTntGroupBox
        Left = 4
        Top = 0
        Width = 397
        Height = 145
        Caption = 'Progress Dialog'
        TabOrder = 0
        object cbProgressLongOnly: TTntCheckBox
          Left = 26
          Top = 92
          Width = 355
          Height = 17
          Caption = 'Current operation takes too &Long Time to complete'
          TabOrder = 3
        end
        object cbProgressRestoredOnly: TTntCheckBox
          Left = 26
          Top = 116
          Width = 355
          Height = 17
          Caption = 'Application is Not &Minimized in the system Tray area'
          TabOrder = 4
        end
        object rbShowProgressIf: TTntRadioButton
          Left = 8
          Top = 66
          Width = 375
          Height = 17
          Caption = 'Show Progress Dialog and Status Bar Indicator always or if'
          Checked = True
          TabOrder = 2
          TabStop = True
          OnClick = rbProgressClick
        end
        object rbShowProgressIndicator: TTntRadioButton
          Left = 8
          Top = 42
          Width = 375
          Height = 17
          Caption = 'Show Progress Indicator in Status Bar only'
          TabOrder = 1
          OnClick = rbProgressClick
        end
        object rbDontShowProgress: TTntRadioButton
          Left = 8
          Top = 18
          Width = 375
          Height = 17
          Caption = 'Disabled'
          TabOrder = 0
          OnClick = rbProgressClick
        end
      end
      object gbTransparency: TTntGroupBox
        Left = 4
        Top = 152
        Width = 397
        Height = 153
        Caption = 'Transparency'
        TabOrder = 1
        object Label3: TTntLabel
          Left = 10
          Top = 24
          Width = 113
          Height = 13
          Caption = 'New Message Window:'
        end
        object Label16: TTntLabel
          Left = 10
          Top = 56
          Width = 116
          Height = 13
          Caption = 'Message Arrived Popup:'
        end
        object Label17: TTntLabel
          Left = 10
          Top = 88
          Width = 109
          Height = 13
          Caption = 'Call Information Popup:'
        end
        object Label18: TTntLabel
          Left = 10
          Top = 120
          Width = 108
          Height = 13
          Caption = 'Event Viewer Window:'
        end
        object TntLabel6: TTntLabel
          Left = 168
          Top = 56
          Width = 24
          Height = 13
          Alignment = taRightJustify
          Caption = 'More'
        end
        object TntLabel15: TTntLabel
          Left = 168
          Top = 24
          Width = 24
          Height = 13
          Alignment = taRightJustify
          Caption = 'More'
        end
        object TntLabel16: TTntLabel
          Left = 168
          Top = 88
          Width = 24
          Height = 13
          Alignment = taRightJustify
          Caption = 'More'
        end
        object TntLabel17: TTntLabel
          Left = 168
          Top = 120
          Width = 24
          Height = 13
          Alignment = taRightJustify
          Caption = 'More'
        end
        object TntLabel18: TTntLabel
          Left = 350
          Top = 56
          Width = 26
          Height = 13
          Caption = 'None'
        end
        object TntLabel19: TTntLabel
          Left = 350
          Top = 24
          Width = 26
          Height = 13
          Caption = 'None'
        end
        object TntLabel20: TTntLabel
          Left = 350
          Top = 88
          Width = 26
          Height = 13
          Caption = 'None'
        end
        object TntLabel21: TTntLabel
          Left = 350
          Top = 120
          Width = 26
          Height = 13
          Caption = 'None'
        end
        object tbComposeSpin: TTntTrackBar
          Left = 196
          Top = 20
          Width = 150
          Height = 31
          Max = 255
          Min = 105
          Frequency = 10
          Position = 255
          TabOrder = 0
          ThumbLength = 18
        end
        object tbMessageSpin: TTntTrackBar
          Left = 196
          Top = 52
          Width = 150
          Height = 31
          Max = 255
          Min = 105
          Frequency = 10
          Position = 255
          TabOrder = 1
          ThumbLength = 18
        end
        object tbCallSpin: TTntTrackBar
          Left = 196
          Top = 84
          Width = 150
          Height = 31
          Max = 255
          Min = 105
          Frequency = 10
          Position = 255
          TabOrder = 2
          ThumbLength = 18
        end
        object tbLogSpin: TTntTrackBar
          Left = 196
          Top = 116
          Width = 150
          Height = 31
          Max = 255
          Min = 105
          Frequency = 10
          Position = 255
          TabOrder = 3
          ThumbLength = 18
        end
      end
    end
    object tabBehaviour: TTntTabSheet
      Caption = 'Behaviour'
      ImageIndex = 54
      TabVisible = False
      object GroupBox7: TTntGroupBox
        Left = 4
        Top = 0
        Width = 397
        Height = 105
        Caption = 'Application'
        TabOrder = 0
        object chkMinButton: TTntCheckBox
          Left = 10
          Top = 18
          Width = 375
          Height = 17
          Caption = 'Use X button to minimize instead to close FMA application'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object cbCheckOutbox: TTntCheckBox
          Left = 10
          Top = 38
          Width = 375
          Height = 17
          Caption = 
            'Check out Outbox folder for unsent messages on FMA start and exi' +
            't'
          TabOrder = 1
        end
        object cbWelcomeTips: TTntCheckBox
          Left = 10
          Top = 58
          Width = 375
          Height = 17
          Caption = 'Show useful Welcome Tips and Tricks on FMA application startup'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object cbNotifyBaloons: TTntCheckBox
          Left = 10
          Top = 78
          Width = 375
          Height = 17
          Caption = 'Show Notification baloons on standard application operations'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
      end
      object GroupBox18: TTntGroupBox
        Left = 4
        Top = 112
        Width = 397
        Height = 189
        Caption = 'Popup Dialogs'
        TabOrder = 1
        object chkMsgM: TTntCheckBox
          Left = 10
          Top = 82
          Width = 365
          Height = 17
          Caption = 'Message Arrived'
          TabOrder = 1
          OnClick = chkMsgMClick
        end
        object cbMsgToArchive: TTntCheckBox
          Left = 28
          Top = 142
          Width = 350
          Height = 17
          Caption = 'Move message to FMA (use Delivery Rules)'
          Enabled = False
          TabOrder = 4
        end
        object cbMsgFullWarning: TTntCheckBox
          Left = 28
          Top = 162
          Width = 350
          Height = 17
          Caption = 'Warn if storage is 95% full'
          Enabled = False
          TabOrder = 5
        end
        object cbNoMsgBaloon: TTntCheckBox
          Left = 28
          Top = 122
          Width = 350
          Height = 17
          Caption = 'No Baloon'
          Enabled = False
          TabOrder = 3
        end
        object cbNoMsgPopup: TTntCheckBox
          Left = 28
          Top = 102
          Width = 350
          Height = 17
          Caption = 'No Popup'
          Enabled = False
          TabOrder = 2
        end
        object chkCallM: TTntCheckBox
          Left = 10
          Top = 18
          Width = 365
          Height = 17
          Caption = 'Call Information'
          TabOrder = 0
          OnClick = chkCallMClick
        end
        object cbNoCallPopup: TTntCheckBox
          Left = 28
          Top = 38
          Width = 350
          Height = 17
          Caption = 'No Popup'
          Enabled = False
          TabOrder = 6
        end
        object cbNoCallBaloon: TTntCheckBox
          Left = 28
          Top = 58
          Width = 350
          Height = 17
          Caption = 'No Baloon'
          Enabled = False
          TabOrder = 7
        end
      end
    end
    object tabSMS: TTntTabSheet
      Caption = 'Text Messages'
      ImageIndex = 41
      TabVisible = False
      object GroupBox9: TTntGroupBox
        Left = 4
        Top = 0
        Width = 397
        Height = 189
        Caption = 'New Messages'
        TabOrder = 0
        object TntLabel1: TTntLabel
          Left = 10
          Top = 44
          Width = 377
          Height = 77
          AutoSize = False
          Caption = 
            'If you wish to use special characters (like '#196', '#228', '#220', '#252', '#214', '#246', '#223' ' +
            'mostly used in german, scandinavian and other languages) in stan' +
            'dard encoding, uncheck this option. Otherwise these special char' +
            'acters will force UCS-2 message encoding, thus reduceing maximum' +
            ' message length to about 1/2 (70 chars) of it'#39's original value.'
          WordWrap = True
        end
        object Label33: TTntLabel
          Left = 10
          Top = 120
          Width = 377
          Height = 37
          AutoSize = False
          Caption = 
            'Useful if your message characters limit suddenly drops from 160 ' +
            'down to 70 when you type in, or if you have problems reading rec' +
            'eived messages.'
          WordWrap = True
        end
        object cbForceUCS2: TTntCheckBox
          Left = 10
          Top = 18
          Width = 175
          Height = 17
          Caption = 'Force UCS-2 encoding'
          TabOrder = 0
        end
        object cbArchiveDublicates: TTntCheckBox
          Left = 10
          Top = 160
          Width = 233
          Height = 17
          Caption = 'Allow duplicates in FMA Archive folders.'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
      end
      object GroupBox13: TTntGroupBox
        Left = 4
        Top = 196
        Width = 397
        Height = 109
        Caption = 'Text Messages Counter'
        TabOrder = 1
        DesignSize = (
          397
          109)
        object Label28: TTntLabel
          Left = 230
          Top = 39
          Width = 79
          Height = 13
          Caption = 'day of the month'
        end
        object lblSMSCount: TTntLabel
          Left = 10
          Top = 84
          Width = 48
          Height = 13
          Caption = '<counter>'
        end
        object cbSMSWarning: TTntCheckBox
          Left = 10
          Top = 18
          Width = 265
          Height = 17
          Caption = 'Show warning message when SMS Count reaches'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object udSMSCnt: TTntUpDown
          Left = 319
          Top = 16
          Width = 16
          Height = 21
          Associate = edSMSCnt
          Min = 5
          Max = 1000
          Position = 10
          TabOrder = 2
        end
        object edSMSCnt: TTntEdit
          Left = 278
          Top = 16
          Width = 41
          Height = 21
          TabOrder = 1
          Text = '10'
        end
        object cbSMSReset: TTntCheckBox
          Left = 10
          Top = 38
          Width = 153
          Height = 17
          Caption = 'Reset Counter monthly on'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object udSMSCntRst: TTntUpDown
          Left = 207
          Top = 36
          Width = 16
          Height = 21
          Associate = edSMSCntRst
          Min = 1
          Max = 31
          Position = 1
          TabOrder = 5
        end
        object edSMSCntRst: TTntEdit
          Left = 166
          Top = 36
          Width = 41
          Height = 21
          TabOrder = 4
          Text = '1'
        end
        object Button6: TTntButton
          Left = 284
          Top = 72
          Width = 101
          Height = 25
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Reset Counter'
          TabOrder = 6
          OnClick = Button6Click
        end
      end
    end
    object tabProximity: TTntTabSheet
      Caption = 'Proximity'
      ImageIndex = 35
      TabVisible = False
      object GroupBox2: TTntGroupBox
        Left = 4
        Top = 0
        Width = 397
        Height = 293
        Caption = 'Proximity Detection'
        TabOrder = 0
        object Label24: TTntLabel
          Left = 8
          Top = 18
          Width = 167
          Height = 13
          Caption = 'When I go away from my computer:'
        end
        object Label25: TTntLabel
          Left = 8
          Top = 146
          Width = 162
          Height = 13
          Caption = 'When I'#39'm back near my computer:'
        end
        object cbProximityLock: TTntCheckBox
          Left = 18
          Top = 56
          Width = 357
          Height = 17
          Caption = 'Lock Workstation'
          TabOrder = 1
        end
        object cbProximityUnlock: TTntCheckBox
          Left = 18
          Top = 162
          Width = 357
          Height = 21
          Caption = 'Unlock Workstation (not implemented)'
          Enabled = False
          TabOrder = 3
        end
        object rgProximityAway: TTntRadioGroup
          Left = 18
          Top = 76
          Width = 367
          Height = 61
          Caption = ' Audio '
          Columns = 3
          ItemIndex = 4
          Items.Strings = (
            'Mute'
            'Unmute'
            'Decrease 80%'
            'Increase 80%'
            'Do nothing')
          TabOrder = 2
        end
        object rgProximityNear: TTntRadioGroup
          Left = 18
          Top = 184
          Width = 367
          Height = 61
          Caption = ' Audio '
          Columns = 3
          ItemIndex = 4
          Items.Strings = (
            'Mute'
            'Unmute'
            'Decrease 80%'
            'Increase 80%'
            'Do nothing')
          TabOrder = 4
        end
        object cbRunSS: TTntCheckBox
          Left = 18
          Top = 36
          Width = 357
          Height = 17
          Caption = 'Run Screen Saver'
          TabOrder = 0
        end
        object btnProximityTest: TTntButton
          Left = 284
          Top = 256
          Width = 101
          Height = 25
          Caption = '&Test Proximity'
          TabOrder = 5
          OnClick = btnProximityTestClick
        end
      end
    end
    object tabAdvanced: TTntTabSheet
      Caption = 'Advanced'
      ImageIndex = 34
      TabVisible = False
      object GroupBox3: TTntGroupBox
        Left = 4
        Top = 0
        Width = 193
        Height = 85
        Caption = 'Timeout (seconds)'
        TabOrder = 0
        object Label11: TTntLabel
          Left = 10
          Top = 49
          Width = 169
          Height = 32
          AutoSize = False
          Caption = 
            'Defines the time in seconds to wait for respond before giving up' +
            '.'
          ShowAccelChar = False
          Transparent = True
          WordWrap = True
        end
        object seCommTimeout: TTntEdit
          Left = 11
          Top = 20
          Width = 40
          Height = 21
          TabOrder = 0
          Text = '15'
        end
        object seCommTimeoutSpin: TTntUpDown
          Left = 51
          Top = 20
          Width = 16
          Height = 21
          Associate = seCommTimeout
          Min = 5
          Max = 60
          Position = 15
          TabOrder = 1
        end
      end
      object GroupBox4: TTntGroupBox
        Left = 208
        Top = 0
        Width = 193
        Height = 85
        Caption = 'Polling Interval (seconds)'
        TabOrder = 1
        object Label5: TTntLabel
          Left = 10
          Top = 49
          Width = 177
          Height = 32
          AutoSize = False
          Caption = 
            'Polling Interval specify the interval for Signal & Battery Power' +
            ' polling.'
          ShowAccelChar = False
          Transparent = True
          WordWrap = True
        end
        object sePolling: TTntEdit
          Left = 10
          Top = 20
          Width = 41
          Height = 21
          TabOrder = 0
          Text = '15'
        end
        object sePollingSpin: TTntUpDown
          Left = 51
          Top = 20
          Width = 16
          Height = 21
          Associate = sePolling
          Min = 5
          Max = 60
          Position = 15
          TabOrder = 1
        end
      end
      object GroupBox16: TTntGroupBox
        Left = 4
        Top = 92
        Width = 397
        Height = 209
        Caption = 'Battery and Phone State Monitoring'
        TabOrder = 2
        object TntLabel27: TTntLabel
          Left = 10
          Top = 184
          Width = 375
          Height = 22
          AutoSize = False
          Caption = 
            '* This option is editable only if Proximity Monitoring is turned' +
            ' Off.'
        end
        object cbDiagram: TTntCheckBox
          Left = 28
          Top = 38
          Width = 359
          Height = 17
          Caption = 'Enable Phone Temp/Use/Charge Status Diagram'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object cbStateMonitor: TTntCheckBox
          Left = 10
          Top = 18
          Width = 375
          Height = 17
          Caption = 'Enable Detailed Phone Information Monitor'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = cbStateMonitorClick
        end
        object cbBatterylMonitor: TTntCheckBox
          Left = 10
          Top = 58
          Width = 375
          Height = 17
          Caption = 'Enable Battery Status Monitor'
          Checked = True
          State = cbChecked
          TabOrder = 2
          OnClick = cbBatterylMonitorClick
        end
        object cbIgnoreLowBattery: TTntCheckBox
          Left = 28
          Top = 78
          Width = 359
          Height = 17
          Caption = 'Ignore Low Battery Warnings'
          TabOrder = 3
        end
        object cbSignalMonitor: TTntCheckBox
          Left = 10
          Top = 98
          Width = 375
          Height = 17
          Caption = 'Enable Channel Signal Monitor'
          Checked = True
          State = cbChecked
          TabOrder = 4
        end
        object cbSilentMonitor: TTntCheckBox
          Left = 10
          Top = 118
          Width = 375
          Height = 17
          Caption = 'Enable Silent Mode Monitor'
          Checked = True
          State = cbChecked
          TabOrder = 5
        end
        object cbMinuteMonitor: TTntCheckBox
          Left = 10
          Top = 138
          Width = 375
          Height = 17
          Caption = 'Enable Minute Minder Monitor'
          Checked = True
          State = cbChecked
          TabOrder = 6
        end
        object cbKeylockMonitor: TTntCheckBox
          Left = 10
          Top = 158
          Width = 375
          Height = 17
          Caption = 'Enable Keypad Lock Monitor*'
          Checked = True
          State = cbChecked
          TabOrder = 7
        end
      end
    end
    object tabOutlookTaskFolders: TTntTabSheet
      Caption = 'Task Folders'
      ImageIndex = 51
      TabVisible = False
      object gbOutlookTaskFolders: TTntGroupBox
        Left = 4
        Top = 0
        Width = 397
        Height = 301
        Caption = 'Microsoft Outlook Folders'
        TabOrder = 0
        DesignSize = (
          397
          301)
        object Label35: TTntLabel
          Left = 10
          Top = 52
          Width = 170
          Height = 13
          Caption = 'Synchronize Tasks in these Folders:'
        end
        object Label36: TTntLabel
          Left = 10
          Top = 18
          Width = 375
          Height = 33
          AutoSize = False
          Caption = 
            'Please select which Outlook folders containing tasks to be synch' +
            'ronized with FMA. Right-click to choose New Tasks target folder ' +
            '(shown in bold).'
          WordWrap = True
        end
        object tvOutlookTaskFolders: TVirtualStringTree
          Left = 10
          Top = 72
          Width = 297
          Height = 217
          Anchors = [akLeft, akTop, akRight, akBottom]
          Header.AutoSizeIndex = 0
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clWindowText
          Header.Font.Height = -11
          Header.Font.Name = 'Tahoma'
          Header.Font.Style = []
          Header.MainColumn = -1
          Header.Options = [hoColumnResize, hoDrag]
          Images = OutlookImageList
          PopupMenu = pmuOutlookTasksFolder
          TabOrder = 0
          TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoDeleteMovedNodes]
          TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
          TreeOptions.SelectionOptions = [toRightClickSelect]
          OnChecked = tvOutlookTaskFoldersChecked
          OnFreeNode = tvOutlookFoldersFreeNode
          OnGetText = tvOutlookFoldersGetText
          OnPaintText = tvOutlookFoldersPaintText
          OnGetImageIndex = tvOutlookFoldersGetImageIndex
          OnInitChildren = tvOutlookFoldersInitChildren
          OnInitNode = tvOutlookFoldersInitNode
          Columns = <>
        end
        object btnRefreshOutlookTaskFolders: TTntButton
          Left = 316
          Top = 72
          Width = 69
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = '&Refresh'
          TabOrder = 1
          OnClick = btnRefreshOutlookTaskFoldersClick
        end
      end
    end
    object tabLanguage: TTntTabSheet
      Caption = 'Language'
      ImageIndex = 11
      TabVisible = False
      object GroupBox90: TTntGroupBox
        Left = 4
        Top = 0
        Width = 397
        Height = 133
        Caption = 'User Interface'
        TabOrder = 0
        object TntLabel2: TTntLabel
          Left = 10
          Top = 18
          Width = 189
          Height = 13
          AutoSize = False
          Caption = 'Prefered FMA language:'
        end
        object TntLabel3: TTntLabel
          Left = 10
          Top = 66
          Width = 375
          Height = 25
          AutoSize = False
          Caption = 'Application must be restarted in order to apply this setting.'
          WordWrap = True
        end
        object lblLinkL10N: TTntLabel
          Left = 10
          Top = 106
          Width = 135
          Height = 13
          Cursor = crHandPoint
          Hint = 
            'http://sourceforge.net/project/showfiles.php?group_id=71167&pack' +
            'age_id=138922'
          Caption = 'Download More Translations'
          OnClick = ExecuteClick
        end
        object ComboBoxLang: TTntComboBox
          Left = 10
          Top = 34
          Width = 375
          Height = 22
          Style = csOwnerDrawFixed
          ItemHeight = 16
          Sorted = True
          TabOrder = 0
          OnChange = ComboBoxLangChange
          OnDrawItem = ComboBoxLangDrawItem
        end
        object btnTestLanguage: TTntButton
          Left = 284
          Top = 96
          Width = 101
          Height = 25
          Caption = 'Test Language...'
          Enabled = False
          TabOrder = 1
          OnClick = btnTestLanguageClick
        end
      end
    end
    object tabOutlookCalendarFolders: TTntTabSheet
      Caption = 'Calendar Folders'
      ImageIndex = 59
      TabVisible = False
      object TntGroupBox1: TTntGroupBox
        Left = 4
        Top = 0
        Width = 397
        Height = 301
        Caption = 'Microsoft Outlook Folders'
        TabOrder = 0
        DesignSize = (
          397
          301)
        object TntLabel4: TTntLabel
          Left = 10
          Top = 52
          Width = 183
          Height = 13
          Caption = 'Synchronize Calendar in these Folders:'
        end
        object TntLabel5: TTntLabel
          Left = 10
          Top = 18
          Width = 375
          Height = 33
          AutoSize = False
          Caption = 
            'Please select which Outlook folders containing calendar to be sy' +
            'nchronized with FMA. Right-click to choose New Calendar target f' +
            'older (shown in bold).'
          WordWrap = True
        end
        object tvOutlookCalendarFolders: TVirtualStringTree
          Left = 10
          Top = 72
          Width = 297
          Height = 217
          Anchors = [akLeft, akTop, akRight, akBottom]
          Header.AutoSizeIndex = 0
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clWindowText
          Header.Font.Height = -11
          Header.Font.Name = 'Tahoma'
          Header.Font.Style = []
          Header.MainColumn = -1
          Header.Options = [hoColumnResize, hoDrag]
          Images = OutlookImageList
          PopupMenu = pmuOutlookCalendarFolder
          TabOrder = 0
          TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoDeleteMovedNodes]
          TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
          TreeOptions.SelectionOptions = [toRightClickSelect]
          OnChecked = tvOutlookCalendarFoldersChecked
          OnFreeNode = tvOutlookFoldersFreeNode
          OnGetText = tvOutlookFoldersGetText
          OnPaintText = tvOutlookFoldersPaintText
          OnGetImageIndex = tvOutlookFoldersGetImageIndex
          OnInitChildren = tvOutlookFoldersInitChildren
          OnInitNode = tvOutlookFoldersInitNode
          Columns = <>
        end
        object btnRefreshOutlookCalendarFolders: TTntButton
          Left = 316
          Top = 72
          Width = 69
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = '&Refresh'
          TabOrder = 1
          OnClick = btnRefreshOutlookCalendarFoldersClick
        end
      end
    end
    object tabContacts: TTntTabSheet
      Caption = 'Contacts'
      ImageIndex = 37
      TabVisible = False
      object gbContacts: TTntGroupBox
        Left = 4
        Top = 0
        Width = 397
        Height = 93
        Caption = 'Phonebook'
        TabOrder = 0
        object TntLabel9: TTntLabel
          Left = 10
          Top = 18
          Width = 292
          Height = 13
          Caption = 'Select the order you would like FMA to display for new names:'
        end
        object TntLabel10: TTntLabel
          Left = 10
          Top = 66
          Width = 377
          Height = 25
          AutoSize = False
          Caption = 
            'This setting is to be used as default when importing new contact' +
            's in FMA.'
          WordWrap = True
        end
        object cbDisplayNameFormat: TTntComboBox
          Left = 10
          Top = 34
          Width = 375
          Height = 22
          Style = csOwnerDrawFixed
          DropDownCount = 9
          ItemHeight = 16
          TabOrder = 0
          Items.Strings = (
            ''
            'First Last'
            'Last, First '
            '(Title) First Last '
            '(Title) Last, First'
            'First Last (Organization)'
            'Last, First (Organization)'
            '(Title) First Last (Organization)'
            '(Title) Last, First (Organization)')
        end
      end
    end
    object tabOutlookContactMappings: TTntTabSheet
      Caption = 'Contact Mappings'
      TabVisible = False
      OnShow = tabOutlookContactMappingsShow
      object TntLabel7: TTntLabel
        Left = 0
        Top = 6
        Width = 405
        Height = 25
        Alignment = taCenter
        AutoSize = False
        Caption = 
          'The fields of a FMA contact can be mapped to different contact f' +
          'ields in Outlook.'
      end
      object TntGroupBox2: TTntGroupBox
        Left = 8
        Top = 32
        Width = 185
        Height = 265
        Caption = ' FMA'#39's Fields '
        TabOrder = 0
        object lbxFieldsFMA: TListBox
          Left = 16
          Top = 24
          Width = 153
          Height = 225
          ItemHeight = 13
          TabOrder = 0
          OnClick = lbxFieldsFMAClick
        end
      end
      object TntGroupBox3: TTntGroupBox
        Left = 208
        Top = 32
        Width = 185
        Height = 265
        Caption = ' Outlook'#39's Fields '
        TabOrder = 1
        object lbxFieldsOutlook: TListBox
          Left = 16
          Top = 24
          Width = 153
          Height = 225
          ItemHeight = 13
          TabOrder = 0
          OnClick = lbxFieldsOutlookClick
        end
      end
    end
    object tabWebUpdate: TTntTabSheet
      Caption = 'Internet Updates'
      TabVisible = False
      object TntGroupBox4: TTntGroupBox
        Left = 4
        Top = 0
        Width = 397
        Height = 145
        Caption = 'Automatic Web Updates'
        TabOrder = 0
        object TntLabel12: TTntLabel
          Left = 10
          Top = 118
          Width = 173
          Height = 13
          Caption = 'You could always do check manualy'
        end
        object btnCheckForUpdates: TTntButton
          Left = 284
          Top = 108
          Width = 101
          Height = 25
          Caption = 'Check &Now...'
          TabOrder = 3
          OnClick = btnCheckForUpdatesClick
        end
        object rbWebUpdateStartup: TTntRadioButton
          Left = 8
          Top = 42
          Width = 175
          Height = 17
          Caption = 'On Startup'
          Checked = True
          TabOrder = 1
          TabStop = True
        end
        object rbWebUpdateDaily: TTntRadioButton
          Left = 8
          Top = 66
          Width = 175
          Height = 17
          Caption = 'Daily'
          TabOrder = 2
        end
        object rbWebUpdateNone: TTntRadioButton
          Left = 8
          Top = 18
          Width = 175
          Height = 17
          Caption = 'Disabled'
          TabOrder = 0
        end
        object rbWebUpdateWeekly: TTntRadioButton
          Left = 8
          Top = 90
          Width = 113
          Height = 17
          Caption = 'Weekly'
          TabOrder = 4
        end
      end
      object TntGroupBox5: TTntGroupBox
        Left = 4
        Top = 152
        Width = 397
        Height = 149
        Caption = 'Details'
        TabOrder = 1
        object TntLabel8: TTntLabel
          Left = 10
          Top = 18
          Width = 77
          Height = 13
          Caption = 'Updates Server:'
        end
        object TntLabel11: TTntLabel
          Left = 10
          Top = 68
          Width = 375
          Height = 53
          AutoSize = False
          Caption = 
            'New application versions will be announced on SourceForge.net FM' +
            'A web site (we have a mailing list there) and on FMA News and An' +
            'nouncements Forum. For more information visit out support web si' +
            'te:'
          WordWrap = True
        end
        object lblSupportURL: TTntLabel
          Left = 10
          Top = 120
          Width = 99
          Height = 13
          Cursor = crHandPoint
          Caption = 'FMA Support Forums'
          OnClick = ExecuteClick
        end
        object edWebUpdatesURL: TTntEdit
          Left = 10
          Top = 34
          Width = 375
          Height = 21
          TabOrder = 0
        end
      end
    end
    object tabScriptEditor: TTntTabSheet
      Caption = 'Editor'
      TabVisible = False
      object TntGroupBox6: TTntGroupBox
        Left = 4
        Top = 0
        Width = 397
        Height = 149
        Caption = 'Script Editor'
        TabOrder = 0
        DesignSize = (
          397
          149)
        object lblScriptEditorName: TTntLabel
          Left = 26
          Top = 66
          Width = 104
          Height = 13
          Caption = 'Script editor file name:'
          Enabled = False
        end
        object edScriptEditor: TTntEdit
          Left = 26
          Top = 82
          Width = 359
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Color = clBtnFace
          Enabled = False
          TabOrder = 2
          Text = 'notepad.exe'
        end
        object btnBrowseEditor: TTntButton
          Left = 308
          Top = 112
          Width = 77
          Height = 25
          Anchors = [akLeft, akTop, akRight]
          Caption = 'B&rowse...'
          Enabled = False
          TabOrder = 3
          OnClick = btnBrowseEditorClick
        end
        object rbScriptEditorBuiltin: TTntRadioButton
          Left = 8
          Top = 18
          Width = 375
          Height = 17
          Caption = 'Use Built-in editor'
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = rdScriptEditorClick
        end
        object rbScriptEditorExternal: TTntRadioButton
          Left = 8
          Top = 42
          Width = 375
          Height = 17
          Caption = 'Use an External editor which I will chose'
          TabOrder = 1
          OnClick = rdScriptEditorClick
        end
      end
    end
    object tabBookmarks: TTntTabSheet
      Caption = 'Bookmarks'
      TabVisible = False
      object GroupBox15: TTntGroupBox
        Left = 4
        Top = 132
        Width = 397
        Height = 137
        Caption = 'Sync Folder on PC'
        TabOrder = 0
        DesignSize = (
          397
          137)
        object Label30: TTntLabel
          Left = 10
          Top = 18
          Width = 190
          Height = 13
          Caption = 'Synchronize Bookmarks with this Folder:'
          Enabled = False
        end
        object Label31: TTntLabel
          Left = 10
          Top = 96
          Width = 375
          Height = 37
          AutoSize = False
          Caption = 
            'Only shortcuts stored in this folder will be synchronized with y' +
            'our phone'#39's bookmarks. Any subfolders will be ignored.'
          Enabled = False
          WordWrap = True
        end
        object edBookmarkDir: TTntEdit
          Left = 10
          Top = 34
          Width = 375
          Height = 21
          Color = clBtnFace
          Enabled = False
          TabOrder = 0
        end
        object btnSelectFavBookm: TTntButton
          Left = 308
          Top = 64
          Width = 77
          Height = 25
          Anchors = [akLeft, akTop, akRight]
          Caption = 'B&rowse...'
          Enabled = False
          TabOrder = 1
          OnClick = btnSelectFavBookmClick
        end
      end
      object TntGroupBox10: TTntGroupBox
        Left = 4
        Top = 0
        Width = 397
        Height = 125
        Caption = 'Bookmarks Sync'
        TabOrder = 1
        object cbBookmarksPhone: TTntCheckBox
          Left = 10
          Top = 18
          Width = 375
          Height = 17
          Caption = 'Phone Bookmarks (Always enabled)'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = cbBookmarksPhoneClick
        end
        object rbBookmarksIE: TTntRadioButton
          Left = 26
          Top = 58
          Width = 355
          Height = 17
          Caption = 'Internet Explorer Favorites'
          Checked = True
          Enabled = False
          TabOrder = 1
          TabStop = True
        end
        object rbBookmarksFirefox: TTntRadioButton
          Left = 26
          Top = 78
          Width = 355
          Height = 17
          Caption = 'Firefox Bookmarks'
          Enabled = False
          TabOrder = 2
        end
        object rbBookmarksOpera: TTntRadioButton
          Left = 26
          Top = 98
          Width = 355
          Height = 17
          Caption = 'Opera Bookmarks'
          Enabled = False
          TabOrder = 3
        end
        object cbBookmarksPC: TTntCheckBox
          Left = 10
          Top = 38
          Width = 375
          Height = 17
          Caption = 'PC Application:'
          Enabled = False
          TabOrder = 4
          OnClick = cbBookmarksClick
        end
      end
    end
    object tabOutlookCategories: TTntTabSheet
      Caption = 'Contact Categories'
      TabVisible = False
      object grOutlookCategories: TTntGroupBox
        Left = 4
        Top = 76
        Width = 397
        Height = 229
        Caption = 'Outlook Categories'
        TabOrder = 0
        DesignSize = (
          397
          229)
        object btAddCat: TTntButton
          Left = 316
          Top = 18
          Width = 69
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'New'
          TabOrder = 1
          OnClick = btAddCatClick
        end
        object btDelCat: TTntButton
          Left = 316
          Top = 82
          Width = 69
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Delete'
          Enabled = False
          TabOrder = 3
          OnClick = btDelCatClick
        end
        object lvOutlookCats: TTntListView
          Left = 10
          Top = 18
          Width = 297
          Height = 199
          Columns = <
            item
              Caption = 'Category Name'
              Width = 275
            end>
          ColumnClick = False
          HideSelection = False
          MultiSelect = True
          ReadOnly = True
          SmallImages = OutlookImageList
          TabOrder = 0
          ViewStyle = vsReport
          OnDblClick = lvOutlookCatsDblClick
          OnSelectItem = lvOutlookCatsSelectItem
        end
        object btEditCat: TTntButton
          Left = 316
          Top = 50
          Width = 69
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Change'
          Enabled = False
          TabOrder = 2
          OnClick = btEditCatClick
        end
      end
      object TntGroupBox7: TTntGroupBox
        Left = 4
        Top = 0
        Width = 397
        Height = 69
        Caption = 'Contact Sync'
        TabOrder = 1
        object rbOutlookAllCategories: TTntRadioButton
          Left = 8
          Top = 18
          Width = 200
          Height = 17
          Caption = 'All Categories'
          TabOrder = 0
          OnClick = cbOutlookCategoriesClick
        end
        object rbOutlookCustomCategories: TTntRadioButton
          Left = 8
          Top = 42
          Width = 200
          Height = 17
          Caption = 'Let me choose'
          Checked = True
          TabOrder = 1
          TabStop = True
          OnClick = cbOutlookCategoriesClick
        end
      end
    end
    object tabChat: TTntTabSheet
      Caption = 'Chat'
      TabVisible = False
      object TntGroupBox9: TTntGroupBox
        Left = 4
        Top = 0
        Width = 397
        Height = 113
        Caption = 'SMS Chat'
        TabOrder = 0
        object TntLabel22: TTntLabel
          Left = 10
          Top = 18
          Width = 131
          Height = 13
          Caption = 'Enter your chat Nick Name:'
        end
        object edChatName: TTntEdit
          Left = 10
          Top = 34
          Width = 375
          Height = 21
          TabOrder = 0
        end
        object cbChatLongSMS: TTntCheckBox
          Left = 10
          Top = 64
          Width = 250
          Height = 17
          Caption = 'Activate Long SMS mode by default'
          TabOrder = 1
        end
        object cbChatBoldFont: TTntCheckBox
          Left = 10
          Top = 84
          Width = 250
          Height = 17
          Caption = 'Use Bold font in new Chat Sessions'
          TabOrder = 2
        end
      end
    end
    object tabSMSDelivery: TTntTabSheet
      Caption = 'Delivery Rules'
      TabVisible = False
      object TntGroupBox13: TTntGroupBox
        Left = 4
        Top = 0
        Width = 397
        Height = 205
        Caption = 'Sorting Correspondence'
        TabOrder = 0
        object TntLabel25: TTntLabel
          Left = 10
          Top = 18
          Width = 375
          Height = 34
          AutoSize = False
          Caption = 
            'Automatically sort Sent and Received Text Messages in custom fol' +
            'ders you have created.'
          WordWrap = True
        end
        object TntLabel26: TTntLabel
          Left = 10
          Top = 52
          Width = 76
          Height = 13
          Caption = 'Message Rules:'
        end
        object lvRules: TTntListView
          Left = 10
          Top = 72
          Width = 297
          Height = 121
          Columns = <
            item
              Caption = 'Rule Name'
              Width = 175
            end
            item
              Caption = 'Folder'
              Width = 100
            end
            item
              Caption = 'Correspondents'
              MaxWidth = 1
              Width = 0
            end
            item
              Caption = 'Path'
              MaxWidth = 1
              Width = 0
            end>
          ColumnClick = False
          HideSelection = False
          MultiSelect = True
          ReadOnly = True
          SmallImages = Form1.ImageList1
          TabOrder = 0
          ViewStyle = vsReport
          OnDblClick = lvRulesDblClick
          OnSelectItem = lvRulesSelectItem
        end
        object btnRuleNew: TTntButton
          Left = 316
          Top = 72
          Width = 69
          Height = 25
          Caption = 'New'
          TabOrder = 1
          OnClick = btnRuleNewClick
        end
        object btnRuleEdit: TTntButton
          Left = 316
          Top = 104
          Width = 69
          Height = 25
          Caption = 'Change'
          Enabled = False
          TabOrder = 2
          OnClick = btnRuleEditClick
        end
        object btnRuleDel: TTntButton
          Left = 316
          Top = 136
          Width = 69
          Height = 25
          Caption = 'Delete'
          Enabled = False
          TabOrder = 3
          OnClick = btnRuleDelClick
        end
        object btnRunRules: TTntButton
          Left = 316
          Top = 168
          Width = 69
          Height = 25
          Caption = '&Run Now'
          Enabled = False
          TabOrder = 4
          OnClick = btnRunRulesClick
        end
      end
      object TntGroupBox14: TTntGroupBox
        Left = 4
        Top = 212
        Width = 397
        Height = 93
        Caption = 'Details'
        TabOrder = 1
        object TntLabel30: TTntLabel
          Left = 10
          Top = 18
          Width = 375
          Height = 37
          AutoSize = False
          Caption = 
            'Sorting Correspondence feature requires '#39'Move new SMS messages t' +
            'o FMA'#39' and '#39'Message Arrived Popup'#39' options to be activated.'
          ShowAccelChar = False
          Transparent = True
          WordWrap = True
        end
        object TntLabel29: TTntLabel
          Left = 10
          Top = 68
          Width = 70
          Height = 13
          Caption = 'Current Status:'
        end
        object lblDeliveryStatus: TTntLabel
          Left = 88
          Top = 68
          Width = 40
          Height = 13
          Caption = '<status>'
        end
        object TntButton1: TTntButton
          Left = 316
          Top = 56
          Width = 69
          Height = 25
          Caption = 'Change'
          TabOrder = 0
          OnClick = TntButton1Click
        end
      end
    end
    object tabCalendar: TTntTabSheet
      Caption = 'Events and Tasks'
      TabVisible = False
      object TntGroupBox15: TTntGroupBox
        Left = 4
        Top = 0
        Width = 397
        Height = 109
        Caption = 'Calendar'
        TabOrder = 0
        object cbCalWideMode: TTntCheckBox
          Left = 10
          Top = 18
          Width = 375
          Height = 17
          Caption = 'Open Calendar view in Full screen'
          TabOrder = 0
        end
        object cbCalRecurrence: TTntCheckBox
          Left = 10
          Top = 38
          Width = 375
          Height = 17
          Caption = 'Enable Auto-Recurrence mode'
          Checked = True
          State = cbChecked
          TabOrder = 1
          OnClick = cbCalRecurrenceClick
        end
        object cbCalRecurrAsk: TTntCheckBox
          Left = 28
          Top = 58
          Width = 181
          Height = 17
          Caption = 'Confirm changes'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object cbCalBirthday: TTntCheckBox
          Left = 10
          Top = 80
          Width = 375
          Height = 17
          Caption = 'Enable Auto-Birthday creation'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
      end
    end
  end
  object btnOK: TTntButton
    Left = 388
    Top = 364
    Width = 69
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 3
    OnClick = btnOKClick
  end
  object btnCancel: TTntButton
    Left = 464
    Top = 364
    Width = 69
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object OptionTree: TVirtualStringTree
    Left = 8
    Top = 8
    Width = 181
    Height = 349
    Anchors = [akLeft, akTop, akBottom]
    DefaultNodeHeight = 16
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.MainColumn = -1
    Header.Options = [hoColumnResize, hoDrag]
    Images = Form1.ImageList2
    Margin = 1
    TabOrder = 0
    TextMargin = 3
    TreeOptions.MiscOptions = [toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    OnFocusChanged = OptionTreeFocusChanged
    OnGetText = OptionTreeGetText
    OnGetImageIndex = OptionTreeGetImageIndex
    OnInitChildren = OptionTreeInitChildren
    OnInitNode = OptionTreeInitNode
    Columns = <>
  end
  object btnDefaults: TTntButton
    Left = 8
    Top = 364
    Width = 181
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Reset to Factory Defaults'
    TabOrder = 2
    OnClick = btnDefaultsClick
  end
  object btnHelp: TTntButton
    Left = 540
    Top = 364
    Width = 69
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Help'
    Enabled = False
    TabOrder = 5
  end
  object OpenDialog1: TTntOpenDialog
    Filter = 
      'VBScript (*.vbscript)|*.vbscript;*.vbs|JScript (*.jscript; *.js)' +
      '|*.jscript;*.js|All Files|*.*'
    Options = [ofHideReadOnly, ofNoChangeDir, ofFileMustExist, ofEnableSizing]
    Title = 'Select Script File'
    Left = 32
    Top = 16
  end
  object OutlookImageList: TImageList
    Left = 72
    Top = 64
    Bitmap = {
      494C01010A000E00040010001000FFFFFFFFFF00FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
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
      0000000000000000000000000000000000000000000084695200846963008471
      6300846952008469520084695200735942007359420073514200634931006B51
      3900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000316984003149630000000000000000000000
      000000000000000000000000000000000000A58A7300ADE7FF00A5E3F70094DB
      F7008CD7F7007BCFEF0073C7EF0063BEE70052B6E7004AAEDE0039AADE0031A2
      DE00634931000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B9AAD005286
      9C00528294005279940039798C00316994003159730039596B00315163003149
      63003149630039596B000000000000000000A58A7300BDEBFF00ADE7FF00A5E3
      FF009CDBF7008CD7F70084CFEF0073C7EF0063BEE70052B6E7004AB2E70039AA
      DE00735942006B51390000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000063AAC600D6FF
      FF00B5FBFF0084EBFF0063E3F70052C3E70042B2D60042A2C600318AA5003179
      A50031597300315163000000000000000000A58A7300BDEFFF00BDEFFF00B5E7
      FF00A5E3FF009CDFF7008CD7F70084CFEF0073C7EF0063BEE7005ABAE7004AB2
      E70084695200735142006B513900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000073CB
      E700D6FBFF00B5FBFF00A5F3FF0094EBFF0073D3F70052C3E70042BAE7003182
      A50021597300000000000000000000000000AD968400A5928400A5928400A58A
      8400A58A8400A58A7300A5827300A58273009482730084828400947973009479
      730094796300736152007B594A006B5139000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084CBE70084DBF70073C3D60063B2D60052A2C6003182A500316984003151
      730000000000000000000000000000000000000000009C9A9400F7D3CE00EFCB
      C600EFC3B500E7AE9C00C6AAA500B5A29C00DE866300E76D4200C64921007359
      52008C8A84009479630073594200635142000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084BECE00C6FBFF0094EBF70073DBF70042C3E70031A2C6003192B5003959
      6B000000000000000000000000000000000000000000B5A29400FFC7C600FFBE
      B500FFBEB500FFA69400FF9E8400FF967300F78A6300F78A5200CE5121008461
      5200947163008C82730084716300735942000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007BBED600C6FBFF00A5F3FF0094E3F70063D3F70042C3E70031A2C6003969
      84000000000000000000000000000000000000000000B5A29400FFC7C600FFCF
      C600FFCFC600FFBEB500FFB6A500FFA69400FF9E8400FF9E7300FF8652009471
      6300C64D21006B5952007B716300847163000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084C3D600C6FBFF00C6FBFF00A5F3FF0094EBF70063D3F70042BAE7003969
      84000000000000000000000000000000000000000000B5A29400B5A29400B5A2
      9400B5A29400B5A29400B5A29400A58A8400A58A8400A58A8400B58A8400F7A2
      8400D659210084615200B55931007B7163000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084C3D600C6FBFF00C6FBFF00C6FBFF00B5FBFF0094E3F70063C3E7004A71
      84000000000000000000000000000000000000000000B5A29400F7BAB500FFCF
      C600F7A29400B59A9400E7BAB500FFBEB500FFB6A500FFAE9400FF9E8400FFA6
      8400FF86520094796300C64D210063554A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A5DBE700C6F3F700D6FFFF00D6FFFF00A5EBF7006392A5000000
      0000000000000000000000000000000000000000000000000000B5A29400B5A2
      9400C6A29400D6B2A500B5A29400B5A29400B5A29400A58A8400A58A8400A58A
      8400B58A8400F7A28400CE5121007B6152000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000094D3E70084C3D60073B2C60063A2B500000000000000
      000000000000000000000000000000000000000000000000000000000000B5A2
      9400F7BAB500FFBEB500F79A9400B59A9400E7C3B500FFBEB500FFB6A500FFA6
      9400FF9E8400FFA68400FF865200947963000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B5A29400B5A29400C6A29400D6B2A500B5A29400B5A29400B5A29400A58A
      8400A58A8400A58A8400A58A8400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B5A29400F7BAB500FFBEB500F7A29400B5A29400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B5A29400B59A9400B5A2940000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004A4D42002128
      2100313831000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B4D31006351
      4200634931007351420073615200735142006349310063493100634931006349
      3100634931000000000000000000000000000000000063616300E7D3C600FFC7
      AD00D6B2A5004238420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084AAC600527184004271
      8400427184003171940031719400316984003169840031698400316184003161
      8400316173003159730031597300000000000000000084828400313031003130
      3100313031003130310031282100212021002118100010101000101010001010
      10001010100010101000101010000000000000000000C6AAA500F7F3F700E7DB
      D600E7D3C600E7CBC6009492B500D6C3B500E7BAA500D6B2A500D6B2A500D6AA
      9400D6A2940063493100000000000000000084828400D6C7BD00FFEFEF00FFEB
      D600FFD3C600C6AA940031303100637963005269520042595200425142004249
      4200314131003138310021302100000000000000000084AAC60073D3FF0073DB
      FF0073D3FF0042BAE70021A2E70021AAD6000092D60021A2D60042B2E70052BA
      F70052C3F70052C3F70042597300000000000000000084828400FFFBF700F7E3
      D600F7DBD600F7D3C600F7D3C600F7CBB500F7C3B500F7C3A500F7BAA500F7B2
      9400F7B29400F7B29400101010000000000000000000C6AAA500FFF3F700F7F3
      F700F7EBE7003151C6001038B5007379C600E7D3D600F7D3C600E7D3C600E7CB
      B500D6AA9400634931000000000000000000A5A2A500FFFBF700FFFBF7002128
      210021202100F7CBB5002120210063A263005292520052825200427952004271
      4200427142003169420031614200000000000000000084AAC60073DBFF0063D3
      F70031B2E700109AD600009AE700009AE70031B2E70073DBFF0073D3FF0073DB
      FF0073DBFF0073DBFF0042617300000000000000000084828400FFFBF700FFFB
      F700FFF3F700FFF3E700F7DBD600A5929400FFE3D600FFDBC600FFDBC600FFD3
      C600FFD3B500F7B29400101010000000000000000000C6AAA500FFF3F700D6D3
      E7003151C6003159F7002149E7001038B500A59AC600F7D3C600F7D3C600E7CB
      B500D6AA9400634931000000000000000000A59A9400F7F3F700FFFFFF004238
      4200FFFBF700C6BAB5006359520073AA730063AA730063A26300639A63005292
      6300528252005279520042614200000000000000000084AAC60073D3F70031B2
      E70010AAD60031D3FF0031CBFF0021A2D60073DBFF0073DBFF0073DBFF0073DB
      FF0073DBFF0073DBFF0042617300000000000000000084828400FFFFFF00FFFB
      F700FFFBF700C6B2B50042383100D6CBC600FFE3D600FFE3D600FFDBC600FFDB
      C600FFD3C600F7B29400101010000000000000000000C6B2A500FFFBF7002141
      C6003159F7006382FF005279F7004261F7002141B500D6C3C600F7DBD600E7CB
      C600D6B2A5006349310000000000000000000000000094929400F7F3F700F7F3
      F700E7DBD6006361630084B2840073B2730073BA730073B2730063AA730063A2
      630063926300528A520042714200000000000000000084AAC60052CBF70000A2
      D60031D3F70031CBF700009AD60042C3E70084E3FF0084E3FF0084E3FF0084E3
      FF0084E3FF0084E3FF0042617300000000000000000084828400FFFFFF00FFFF
      FF00E7DBD6003130310052414200FFEBE700FFEBE700FFE3D600FFE3D600FFDB
      C600FFDBC600F7BAA500101010000000000000000000C6B2A500FFFBF70084A2
      FF00849AFF008492F700D6D3E700849AF7004261E7004259B500F7DBD600F7DB
      D600D6BAA5006351420000000000000000000000000000000000949A9400948A
      940084828400739A730094D3A50084C3840084BA840073BA840073BA730073B2
      730063A263005292630042714200000000000000000084AAC60042B2E70042C3
      E70042BAE70031B2E70010A2D60063D3F70084E3FF0084E3FF0084E3FF0084E3
      FF0084E3FF0084E3FF0052697300000000000000000084828400FFFFFF00FFFF
      FF00C6C3C6003130310021202100C6B2A500FFF3E700FFEBE700FFE3D600FFE3
      D600FFDBC600F7C3A500101010000000000000000000D6B2A500FFFBFF00E7EB
      FF00C6CBF700F7F3F700F7F3E700E7DBE7008492F7003159E7005269B500F7E3
      D600E7CBB5007359420000000000000000000000000000000000000000006361
      6300FFFFFF0073AA8400A5D3A50084CB940084C3840084C3840073C3840073BA
      730073B27300639A630042824200000000000000000084AAC60052C3E70084E3
      F70084EBFF0084EBFF0084EBFF0084EBFF0084EBFF0084EBFF0084EBFF0084EB
      FF0084EBFF0084EBFF0052697300000000000000000084828400FFFFFF00FFFF
      FF00F7F3F700848284001010100031303100C6BAB500FFF3E700D6BAA500A582
      7300FFE3D600F7C3B500211810000000000000000000D6BAA500FFFFFF00FFFB
      FF00FFFBF700FFFBF700FFF3F700F7F3E700F7E3E700738AF7002151D6009492
      C600E7D3C6008471630000000000000000000000000000000000000000009486
      84008479840073A27300A5DBB50094CB940084CB940084CB840084C3840073C3
      840073BA730063AA7300528A5200000000000000000084B2C60073D3F70084EB
      FF0084EBFF0084EBFF0084EBFF0084EBFF0084EBFF0084EBFF0084EBFF0084EB
      FF0084EBFF0084EBFF0052697300000000000000000084828400FFFFFF00FFFF
      FF00FFFFFF00D6DBD600424142001010100042414200B5A29400735952004238
      3100FFE3D600F7CBB500212021000000000000000000D6BAB500FFFFFF00FFFF
      FF00FFFBFF00FFFBF700FFFBF700F7F3F700F7E3E700F7EBE7008492F7002149
      D600A59AC600A592840000000000000000000000000000000000000000002120
      2100FFFFFF0073AA8400B5DBB500639A6300639A6300639A630063A2730063A2
      730073AA730073AA730052925200000000000000000084B2C60094E3F70084F3
      FF0084F3FF0084F3FF0094F3FF0094F3FF0094F3FF0094F3FF0094F3FF0094F3
      FF0094F3FF0094F3FF0052697300000000000000000084828400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00B5B2B500313031001010100021202100312021004228
      2100FFEBE700F7D3C600312821000000000000000000D6C3B500FFFFFF00FFFF
      FF0084A2B500638A9400638A940063799400637984007382940094A2B50094A2
      F7003151D600B59A940000000000000000000000000000000000000000009486
      8C008482840084B28400B5E3C600638A630084BA840094C3940094CBA500A5D3
      A500A5DBB50063AA7300529A5200000000000000000084B2C600A5EBF70094FB
      FF0094FBFF0094FBFF0094FBFF0094FBFF0094FBFF0094FBFF0094FBFF0094FB
      FF0094FBFF0094FBFF0052697300000000000000000084828400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00A5AAA5002120210000000000100800003120
      2100FFF3E700F7D3C600313031000000000000000000D6C3B500FFFFFF00FFFF
      FF0084AAB50094DBE70094EBF70084DBF70063CBE700529AB50073829400F7EB
      E700E7DBD600A59A940000000000000000000000000000000000000000002128
      2100FFFFFF0084BA9400C6E3C600638A630073AA730084B2840084BA940094CB
      9400A5CBA50063A27300639A6300000000000000000084BAC600B5F3FF00A5FF
      FF00A5FFFF00A5FFFF00A5FFFF00A5FFFF00A5FFFF00A5FFFF00A5FFFF00A5FF
      FF00A5FFFF00A5FFFF0052698400000000000000000084828400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00D6D3D600636963002128210010081000000000002118
      1000FFF3F700F7DBD600313031000000000000000000D6C3B500FFFFFF00FFFF
      FF00F7FBFF0084AAB500A5AAA5009486730084CBD60052718400F7F3F700F7E3
      E700F7E3E700847163000000000000000000000000000000000000000000A592
      8C008482840084C39400C6E3C600638A6300528A6300638A6300639263006392
      6300639A630063A2630063AA6300000000000000000094CBD600C6FBFF00B5FF
      FF00B5FFFF00B5FFFF00B5FFFF00B5FFFF00B5FFFF00B5FFFF00B5FFFF00B5FF
      FF00B5FFFF00B5FFFF0052718400000000000000000084828400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00B5B2B500525152005249520042494200313031003130
      3100FFFBF700F7E3D60031303100000000000000000000000000D6C3B500D6C3
      B500D6C3B50073AAB500A5EBF700A5EBF70094D3E70042697300C6AAA500C6AA
      A500C6AA94000000000000000000000000000000000000000000000000002128
      2100FFFFFF0094C3A500C6EBC600C6EBC600C6E3C600B5E3C600B5DBB500A5D3
      A50094CB940084C3840084BA8400000000000000000094CBD600E7FBFF00D6FF
      FF00C6FFFF00C6FFFF00C6FFFF00C6FFFF00C6FFFF00C6FFFF00C6FFFF00C6FF
      FF00C6FFFF00C6FFFF0052718400000000000000000084828400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFBF700FFFBF70031303100000000000000000000000000000000000000
      0000000000000000000084B2C60084A2B5007392A50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008C8A840094C3A50094C3940084C3940084BA940084BA940084BA840084B2
      840084B2840073AA730073AA7300000000000000000094CBD60094CBD60094CB
      D60094CBD60094CBD60094CBD60094C3D60094C3D60094C3D60094BAD60084B2
      C60084AAC60084AAC60084AAC600000000000000000084828400848284008482
      8400848284008482840084828400848284008482840084828400848284008482
      8400848284008482840084828400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000084AA
      C600527184004271940031698400316984003161840031597300315973003159
      7300315973003151630031516300314963000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000084AA
      C600D6FFFF00A5EBFF0084E3F70084DBF70073D3F70073D3F70073CBF70073CB
      F70073CBF70063CBF70063C3F70031516300B5A2940063493100634931006349
      3100634942006349310063493100634931006349310063493100634931006349
      3100634931006349310063493100634931000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000738A940073798400637173005261
      6300425152003138420021283100102021001010210010102100101021001010
      21001010210010102100101021000000000000000000000000000000000084AA
      C600C6EBF700B5FBFF0094F3FF0094F3FF0094F3FF0094F3FF0094F3FF0094F3
      FF0094F3FF0084E3FF0063BAE70031516300C6AAA500D6BAA500C6A28400B58A
      7300E7BAA500D6AA9400B5927300E7BAA500C6A28400B58A7300D6BAA500C6A2
      8400B58A7300D6AA9400C69A840063493100B5A2940073615200735942006351
      4200634931006349310063493100634931006349310063493100634931006349
      310063493100634931006349310063493100738A9400A5E3F70073D3F70052BA
      E70031B2E70031AAE70021A2D600219AC6002192C6002182B5002182B5001082
      B5002179A500217194001020210000000000738A9400737984006371730084B2
      C60084BAD60094E3F70094FBFF0094F3FF0084EBFF0073E3FF0084EBFF0084EB
      FF0094F3FF0073DBF700428AB50042596300C6AAA500FFFFFF00FFFFFF00C69A
      8400FFFBFF00FFFBF700C69A8400FFF3F700FFF3F700C69A8400FFEBE700FFEB
      E700C6A28400FFE3D600D6C3B50063493100B5A29400F7E3D600F7DBD600E7D3
      C600E7CBB500E7C3B500E7C3B500E7C3B500E7C3A500E7BAA500E7BAA500E7BA
      A500E7B29400E7B29400E7B2940063493100848A9400B5EBF70094EBFF0084E3
      FF0073DBFF0073D3F70063CBF70052C3F70042BAF70031AAF70031AAE700219A
      E7001092D6002179A5002128310000000000738A9400A5E3F70073D3F70094B2
      C600B5EBF70063BAD60084EBFF0073E3F70052B2E70031A2D6003192C60073D3
      F70073DBF700429AC60063C3E70042597300C6AAA500FFFFFF00FFFFFF00D6AA
      9400FFFFFF00FFFBFF00D6A28400FFFBF700FFF3F700D6A28400FFEBE700FFEB
      E700D6A28400FFE3D600D6C3B50063493100C6AA9400FFF3F700B5BAC6001059
      C6001051B5000041940021519400B5A2A500FFE3D600F7E3D600F7DBC600F7DB
      C600F7DBC600F7DBC600E7B29400634931008492A500B5EBF700A5EBFF0094EB
      FF0084E3FF0073DBFF0073D3F70063CBF70052C3F70042BAF70031AAF70031A2
      E700219AE7001082B5003138420000000000848A9400B5EBF70094EBFF0094BA
      D600D6FFFF00A5EBF70073CBF70052B2E70084DBF70084EBFF0084EBF70042A2
      C60052C3E70084E3F70073CBF70042617300C6B2A500D6B29400C69A8400B58A
      7300D6A28400C69A8400B58A7300D6A28400C69A84001041E7001038E7001038
      C6000030B500D6A28400C69A840063493100C6AAA500E7EBF7002161C60073AA
      F700428AE7000049A5001069D60000419400FFEBE700E7BAB500C6A29400C69A
      8400C69A8400C6928400E7BAA500634931008492A500B5F3FF00B5F3FF00A5EB
      FF0094E3FF0084E3FF0073DBFF0073D3F70063CBF70052C3F70042B2F70031AA
      F70021A2E7001082B50042415200000000008492A500B5EBF700A5EBFF0094C3
      D600D6FFFF0094EBF70063BAE70084E3F700A5FBFF0094F3FF0094F3FF0094EB
      FF0052AAD60084E3F70073D3F70042617300C6B2A500FFFFFF00FFFFFF00C69A
      8400FFFFFF00FFFFFF00C69A8400FFFBFF00FFFBF7003161F700FFFBF700FFFB
      F7001038C600FFEBE700D6C3B50063493100C6B2A500F7F3F7003171C60073AA
      E7002159B5002171E7001051B5002159A500FFF3E700FFE3D600FFE3D600F7E3
      D600F7DBC600F7DBC600E7BAA50063493100849AA500C6F3FF00B5F3F700A5F3
      FF00A5EBFF0094E3FF0084E3FF0073DBFF0063D3F70063CBF70052BAF70042B2
      F70031AAE700108AC60052516300000000008492A500B5F3FF00B5F3FF0094C3
      D600C6FBFF0063C3E70094E3F700A5FBFF00A5FBFF00A5FBFF00A5FBFF0094F3
      FF0094EBFF0052A2C60063C3E70052697300C6B2A500FFFFFF00FFFFFF00D6A2
      8400FFFFFF00FFFFFF00D6A28400FFFFFF00FFFBFF006382FF00FFFFFF00FFFB
      F7001038E700FFEBE700D6CBC60063493100C6B2A500FFFBFF00E7E3E7003151
      9400A59A9400848AA50031519400D6DBE700FFF3F700F7D3C600C6A29400C69A
      8400C69A8400C6928400D6C3B50063493100849AA500C6F3FF00B5F3FF00B5F3
      FF00A5EBFF0094EBFF0094E3FF0084E3FF0073DBFF0063D3F70063CBF70052BA
      F70031AAE7001092C6005261730000000000849AA500C6F3FF00B5F3F70094CB
      D600A5E3F700E7FFFF00E7FFFF00E7FFFF00E7FFFF00E7FFFF00E7FFFF00D6FF
      FF00D6FFFF00B5FBFF00429AC60052718400D6B2A500D6B29400C69A8400B58A
      7300D6A28400C69A8400B58A7300D6A28400C69A8400849AFF006382FF003161
      F7001041E700D6A28400C69A840063493100C6BAA500FFFFFF00636963003128
      2100B5BAB5008482840063697300FFFBFF00FFFBF700FFF3F700FFF3E700FFEB
      E700FFEBE700FFE3D600D6C3B5006349310094A2A500C6F3FF00B5F3FF00B5F3
      FF00B5F3F700A5F3FF0094EBFF0094E3FF0084E3FF0073D3FF0063D3F70052C3
      F70052BAF700219AD6006371840000000000849AA500C6F3FF00B5F3FF0094CB
      D60094CBD60094CBD60094CBD60094C3D60094C3D60094BAD60094BAC60084B2
      C60084B2C60084AAC60084AAC60084AAC600D6BAA500FFFFFF00FFFFFF00C69A
      8400FFFFFF00FFFFFF00C69A8400FFFFFF00FFFFFF00C69A8400FFFBFF00FFFB
      F700C69A8400FFF3F700E7DBD60063514200D6BAB500FFFBFF00525152005249
      5200E7E3E700C6CBC60084797300E7DBE700FFFBF700FFCBA500FFBA9400FFB2
      8400FFAA8400F7A27300D6C3B5006349310094A2B500C6F3FF00C6F3FF00C6F3
      FF00C6F3FF00B5F3FF00B5F3FF00A5EBFF0094EBFF0094E3FF0084DBFF0073D3
      FF0073CBF70063C3F700637184000000000094A2A500C6F3FF00B5F3FF00B5F3
      FF00B5F3F700A5F3FF0094EBFF0094E3FF0084E3FF0073D3FF0063D3F70052C3
      F70052BAF700219AD6006371840000000000D6BAA500FFFFFF00FFFFFF00D6A2
      8400FFFFFF00FFFFFF00D6A28400FFFFFF00FFFFFF00D6A28400FFFFFF00FFFB
      FF00D6A28400FFFBF700FFF3F70063493100D6BAB500FFFFFF00736973007379
      7300A59AA500949A940084798400E7E3E700FFFFFF00FFFBF700FFFBFF00FFFB
      F700FFFBF700FFFBF700D6CBC6006351420094A2B50094A2B50094A2B50094A2
      B50094A2B50094A2B50094A2A500949AA500849AA500849AA500849AA500849A
      A500849AA500849AA500000000000000000094A2B500C6F3FF00C6F3FF00C6F3
      FF00C6F3FF00B5F3FF00B5F3FF00A5EBFF0094EBFF0094E3FF0084DBFF0073D3
      FF0073CBF70063BAF7006371840000000000F7AA9400F7AA9400F7AA8400F7AA
      8400F7A28400F7A27300E79A7300E7927300E7926300E78A6300E7825200E782
      5200E7794200E7794200E7714200C6693900D6C3B500FFFFFF00E7E3E7007379
      7300848A840073797300C6CBC600FFFBFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFBF700FFFBF700D6CBC6007359420094AAB500B5EBF700B5F3FF00B5F3
      FF00B5F3F70094E3F70094A2B500000000000000000000000000000000000000
      00000000000000000000000000000000000094A2B50094A2B50094A2B50094A2
      B50094A2B50094A2B50094A2A500949AA500849AA500849AA500849AA500849A
      A500849AA5008492A5000000000000000000F7AA9400FFEBE700FFEBE700FFEB
      E700FFEBE700FFEBE700FFEBE700FFB29400FFAA8400F7AA8400F7AA8400F7A2
      8400F7A28400F7A28400F7A27300D6693900D6C3B500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFBFF00FFFBFF00FFFFFF00846952000000000094AAB50094AAB50094AA
      B50094AAB50094AAB50000000000000000000000000000000000000000000000
      00000000000000000000000000000000000094AAB500B5EBF700B5F3FF00B5F3
      FF00B5F3F70094E3F70094A2B500000000000000000000000000000000000000
      000000000000000000000000000000000000F7AA9400F7AA9400F7AA8400E7A2
      8400E7A28400E79A7300E7927300E7926300E78A6300E7825200D6825200D679
      5200D6714200D6714200D6714200D6693100D6C3B500D6C3B500D6C3B500D6C3
      B500D6BAB500D6BAB500C6BAA500C6B2A500C6B2A500C6AAA500C6AAA500C6AA
      9400B5A29400B5A29400B5A29400B5A294000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000094AAB50094AAB50094AA
      B50094AAB50094AAB50000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5A6A500FFFFFF0094929400FFFF
      FF008C8E8C00FFFFFF0084828400FFFFFF0084828400FFFFFF0073717300FFFF
      FF0063616300FFFFFF0063596300D6DBD6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000021282100000000002128
      2100000000002128210000000000212821000000000021282100000000002128
      2100000000002128210000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFFF800F00000000
      FE7F000700000000C003000300000000C003000100000000E007000000000000
      F00F800000000000F00F800000000000F00F800000000000F00F800000000000
      F00F800000000000F81FC00000000000FC3FE00000000000FFFFF00100000000
      FFFFF83F00000000FFFFFC7F00000000FFFFC7FFFFFFFFFFC00783FF80018001
      8003000180018001800300018001800180030001800180018003800180018001
      8003C001800180018003E001800180018003E001800180018003E00180018001
      8003E001800180018003E001800180018003E00180018001C007E00180018001
      FC7FF00180018001FFFFFFFFFFFFFFFFFFFFE000FFFFFFFFFFFFE0000000FFFF
      0001E00000000000000100000000000000010000000000000001000000000000
      0001000000000000000100000000000000010000000000000001000000000000
      0001000100000000000300010000000001FF00030000000083FF01FF00000000
      FFFF83FF0000FFFFFFFFFFFFAAABFFFF}
  end
  object LocalWBtSocket: TWBluetoothSocket
    LineMode = False
    LineLimit = 65536
    LineEnd = #13#10
    LineEcho = False
    LineEdit = False
    Port = '0'
    MultiThreaded = False
    ComponentOptions = []
    OnDataAvailable = OnSocketDataAvailable
    FlushTimeout = 60
    SendFlags = wsSendNormal
    LingerOnOff = wsLingerOn
    LingerTimeout = 0
    Left = 72
    Top = 112
  end
  object LocalWIrSocket: TWIrCOMMSocket
    LineMode = False
    LineLimit = 65536
    LineEnd = #13#10
    LineEcho = False
    LineEdit = False
    MultiThreaded = False
    ComponentOptions = []
    OnDataAvailable = OnSocketDataAvailable
    FlushTimeout = 60
    SendFlags = wsSendNormal
    LingerOnOff = wsLingerOn
    LingerTimeout = 0
    Left = 104
    Top = 112
  end
  object PBFolderDialog1: TPBFolderDialog
    Flags = [OnlyAncestors, ShowPath]
    RootFolder = foFavorites
    NewFolderVisible = False
    NewFolderEnabled = False
    LabelCaptions.Strings = (
      'Default=Current folder:'
      '0009=Current folder:'
      '0406=Valgt mappe:'
      '0407=Mappe gew?hlt:'
      '0409=Current folder:'
      '0413=Huidige map')
    NewFolderCaptions.Strings = (
      'Default=New folder'
      '0009=New folder'
      '0406=Ny mappe'
      '0407=Neu Mappe'
      '0409=New folder'
      '0413=Nieuwe map')
    Version = '1.30.00.00'
    Left = 112
    Top = 16
  end
  object pmuOutlookContactsFolder: TTntPopupMenu
    Left = 72
    Top = 160
    object mniNewContacts: TTntMenuItem
      Caption = 'Add New Contacts Here'
      OnClick = mniNewContactsClick
    end
  end
  object pmuOutlookTasksFolder: TTntPopupMenu
    OnPopup = pmuOutlookTasksFolderPopup
    Left = 72
    Top = 256
    object mniNewTasks: TTntMenuItem
      Caption = 'Add New Tasks Here'
      OnClick = mniNewTasksClick
    end
  end
  object pmuOutlookCalendarFolder: TTntPopupMenu
    OnPopup = pmuOutlookCalendarFolderPopup
    Left = 72
    Top = 208
    object mniNewCalendar: TTntMenuItem
      Caption = 'Add New Calendar Here'
      OnClick = mniNewCalendarClick
    end
  end
  object LocalComPort: TComPort
    BaudRate = br115200
    Port = 'COM4'
    Parity.Bits = prNone
    StopBits = sbOneStopBit
    DataBits = dbEight
    Events = [evRxChar]
    Buffer.InputSize = 4096
    Buffer.OutputSize = 2048
    FlowControl.OutCTSFlow = False
    FlowControl.OutDSRFlow = False
    FlowControl.ControlDTR = dtrDisable
    FlowControl.ControlRTS = rtsEnable
    FlowControl.XonXoffOut = False
    FlowControl.XonXoffIn = False
    SyncMethod = smWindowSync
    OnRxChar = LocalComPortRxChar
    Left = 40
    Top = 112
  end
  object OpenDialog2: TTntOpenDialog
    Filter = 'Executable Files (*.exe)|*.exe|All Files|*.*'
    Title = 'Select a File...'
    Left = 72
    Top = 16
  end
end
