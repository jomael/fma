unit uOptions;

{
*******************************************************************************
* Descriptions: Main Unit for FMA
* $Source: /cvsroot/fma/fma/uOptions.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uOptions.pas,v $
* Revision 1.54.2.43  2006/03/15 16:42:56  z_stoichev
* - Fixed Move Messages to Archive mode detection.
* - Fixed Main dialog position to screen center.
* - Fixed Main dialog status bar wrong top position.
* - Fixed Explorer splitter initial visible state.
* - Fixed Refresh options when showing only one page.
* - Added Delivery Rules options details information.
* - Added Standard baloons can be disabled in options.
* - Added Call monitoring no popup/baloons options.
* - Added Calendar entities (auto)recurrence support.
* - Added Calendar settings in new FMA Options page.
* - Changed Calendar Events and tasks popup menus.
* - Changed Do not download phonebook on new phone.
*
* Revision 1.54.2.42  2006/03/15 10:06:09  z_stoichev
* Added Delivery Rules options details information.
*
* Revision 1.54.2.41  2006/03/14 14:18:20  z_stoichev
* Get Alarms on Connection is implemented.
* Added Auto-WebUpdate daily and weekly support.
* Changed Wizard confirmation message.
*
* Revision 1.54.2.40  2006/03/13 14:23:49  z_stoichev
* Fixed Delivery Rules GUI selection change.
* Changed GUI on Startup page.
*
* Revision 1.54.2.39  2006/02/23 11:32:36  z_stoichev
* Fixed Options selection lost on keyboard use.
* Fixed Option to disable keylock monitoring.
* Fixed Some GUI label and box positions.
*
* Revision 1.54.2.38  2006/02/21 20:49:34  mhr3
* Added option to disable keylock monitoring
*
* Revision 1.54.2.37  2006/02/02 10:07:18  z_stoichev
* Changed SMS page GUI.
*
* Revision 1.54.2.36  2006/01/25 12:02:34  z_stoichev
* Fixed AV Bug on Bluetooth Search double-click.
*
* Revision 1.54.2.35  2006/01/20 13:56:19  z_stoichev
* Refresh main view after Run Rules click.
*
* Revision 1.54.2.34  2006/01/18 11:21:15  z_stoichev
* Added Contacts folders Default NewContacts button.
*
* Revision 1.54.2.33  2006/01/16 11:26:57  mhr3
* Form1.Explorer -> Form1.ExplorerNew
*
* Revision 1.54.2.32  2005/12/15 11:42:34  z_stoichev
* Added Allow dublicates in Archive folders option.
*
* Revision 1.54.2.31  2005/12/09 13:29:20  z_stoichev
* - Fixed Update missed calls when minimized.
* - Added Notification icon for missing calls.
* - Added Notification icon for new messages.
*
* Revision 1.54.2.30  2005/10/03 08:15:47  z_stoichev
* Browse For Folder changes.
*
* Revision 1.54.2.29  2005/10/02 22:36:44  z_stoichev
* Delivery Rules implementation changes.
*
* Revision 1.54.2.28  2005/10/01 13:01:21  z_stoichev
* added DeliveryRules property.
*
* Revision 1.54.2.27  2005/09/30 20:22:35  z_stoichev
* Delivery Rules changes.
*
* Revision 1.54.2.26  2005/09/30 14:48:03  z_stoichev
* Delivery Rules implementation.
*
* Revision 1.54.2.25  2005/09/21 20:38:37  z_stoichev
* Do not hide Rules selection.
*
* Revision 1.54.2.24  2005/09/20 21:16:46  z_stoichev
* Delivery Rules
*
* Revision 1.54.2.23  2005/09/20 15:17:41  z_stoichev
* Delivery Rules tab created.
*
* Revision 1.54.2.22  2005/09/20 14:44:57  z_stoichev
* Changed Confirmations default button to NO.
*
* Revision 1.54.2.21  2005/09/19 20:46:35  z_stoichev
* BT Setting not remembered.
*
* Revision 1.54.2.20  2005/09/18 20:35:25  z_stoichev
* - Fixed Add Outlook empty/existing Category issue.
* - Fixed Transparency Options hided if no OS support.
* - Fixed Connection types disabled if no OS support.
* - Added Connect via Bluetooth by device Address.
* - Added Options Win XP color scheme change support.
*
* Revision 1.54.2.19  2005/09/15 15:06:58  z_stoichev
* Sync Bookmarks changes.
*
* Revision 1.54.2.18  2005/09/08 21:07:56  z_stoichev
* Welcome Tips are optional.
*
* Revision 1.54.2.17  2005/09/06 18:32:57  z_stoichev
* Bugfixes and improvements (2.1.1.102b)
*
* Revision 1.54.2.16  2005/09/01 11:35:47  z_stoichev
* Added Silent Mode and Minute Minder settings.
*
* Revision 1.54.2.15  2005/08/31 22:02:02  z_stoichev
* - Added chat customization support.
* - Sanity Check exceptions are messages.
* - Defaults - some pages were missed.
*
* Revision 1.54.2.14  2005/08/30 12:59:45  z_stoichev
* - Fixed Various typos and GUI localization issues.
* - Changed Options pages rearranged, GUI changes.
* - Fixed Calling popup and Compone SMS Alpha update.
* - Fixed Defaults for windows/popups transparency.
* - Added Disable protocols in Options confirmations.
*
* Revision 1.54.2.13  2005/08/26 15:30:09  z_stoichev
* - Explorer not visible by default on fresh install.
* - FMA window default height increased on fresh install.
* - Various FMA windows default transparency removed.
* - Fixed quoted parameter send to script editor.
* - External script editor can be specified in Options.
* - Internal script editor restored and is optional.
* - Internal script editor error checking bugfixes.
* - Ask to save modified script on application exit.
* - Ask to save modified script Explorer change.
*
* Revision 1.54.2.12  2005/08/24 10:34:04  z_stoichev
* Internet Updates GUI changes.
*
* Revision 1.54.2.11  2005/08/23 14:47:48  z_stoichev
* Optimized Reset to Defaults works for each page individually.
*
* Revision 1.54.2.10  2005/08/23 12:56:28  z_stoichev
* Web Update added startup check and options.
*
* Revision 1.54.2.9  2005/08/22 23:56:07  z_stoichev
* Various GUI changes and bugfixes.
*
* Revision 1.54.2.8  2005/08/17 18:40:54  lordlarry
* - Added Outlook Field Mappings
*
* Revision 1.54.2.7  2005/08/17 10:51:07  z_stoichev
* - Reset Options to Defaults will ask confirmation.
* - Options GUI changes, missing Caption set.
* - Explorer Icons preparations.
*
* Revision 1.54.2.6  2005/08/16 16:15:31  z_stoichev
* bugfixes
*
* Revision 1.54.2.5  2005/08/13 12:36:33  lordlarry
* - Fixed Exception handleing for reading Outlook folders
*
* Revision 1.54.2.4  2005/04/12 22:27:10  z_stoichev
* Fixed GSM Encode on send AT command (lookup phone).
*
* Revision 1.54.2.3  2005/04/11 22:36:31  z_stoichev
* Fixed GSM coding scheme.
*
* Revision 1.54.2.2  2005/04/10 21:26:05  lordlarry
* Finally fixed the widcomm issue. Successfuly tested with widcomm 1.4.3.4 and P4 3.4 HT! (vo_x)
*
* Revision 1.54.2.1  2005/04/03 12:22:11  lordlarry
* Changed some methods to WideString methods
*
* Revision 1.54  2005/03/13 11:38:44  z_stoichev
* Fixed: Outlook folders small node images.
* Fixed: Edit Outlook category when All checked.
* Changed: Warnings only if Options are shown.
* Added: Browse web for more languages button.
* Some GUI changes as well.
*
* Revision 1.53  2005/03/13 10:45:57  schnorbsl_fma
* added: set default DisplayName with import contact from phone
*
* Revision 1.52  2005/03/12 17:37:30  lordlarry
* Fixed Memory Leaks
*
* Revision 1.51  2005/03/05 14:23:58  lordlarry
* Changed the Name Locally used Comm Components to prevent confiusion and solve a 'with' bug
*
* Revision 1.50  2005/02/24 21:29:14  lordlarry
* Added a better (but ugly) method to make the TWaitThread code threadsafe. All data that is accessed outside of the class goes through the ThreadSafe object which does the locking.
*
* Revision 1.49  2005/02/18 15:31:59  z_stoichev
* Added: Auto-sync Calendar on startup option.
* Added: Auto-sync Tasks and Notes preparation.
* Fixed: Lookup serial device when disconnected.
* Fixed: Widgets widht aligned and GUI changes.
*
* Revision 1.48  2005/02/14 21:21:42  gravanov
* mistake in dialog fixed
*
* Revision 1.47  2005/02/14 21:20:06  gravanov
* fixed: typo in blutooth :)
* fixed: crash in no devices are connected.
* fixed: localization
*
* Revision 1.46  2005/02/14 20:37:11  voxik
* Fixed Default options page set in code instead of design time
*
* Revision 1.45  2005/02/14 20:16:58  lordlarry
* Changed Outlook Folders aren't expanded by default which makes the dialog faster
*
* Revision 1.44  2005/02/14 19:10:37  voxik
* Added BT devices enumeartion
*
* Revision 1.43  2005/02/12 17:15:40  z_stoichev
* GUI changes.
*
* Revision 1.42  2005/02/10 21:36:27  gravanov
* Changed: Options dialog appearance
* Changed: Outlook handling
* Added: Tabs for Outlook calendar and tasks folders.
*
* Revision 1.41  2005/02/10 20:07:30  lordlarry
* New way of Logging
*
* Revision 1.40  2005/02/09 10:58:49  z_stoichev
* Fixed compiler warnings
* Initial TabSheet set to General.
*
* Revision 1.39  2005/02/08 15:38:54  voxik
* Merged with L10N branch
*
* Revision 1.33.2.8  2005/02/02 23:15:52  voxik
* Changed MessageDlg and ShowMessages replaced by new unicode versions
*
* Revision 1.33.2.7  2005/02/02 17:16:25  voxik
* Fixed Dialog height adjustmen due to different number of tabs
*
* Revision 1.33.2.6  2005/01/13 20:18:18  expertone
* Added support for more than one translation for one locale
*
* Revision 1.33.2.5  2005/01/07 17:34:38  expertone
* Merge with MAIN branch
*
* Revision 1.38  2004/12/23 15:00:43  z_stoichev
* Outlook Categories edit, popup menu and delete warning.
*
* Revision 1.37  2004/12/22 13:51:23  z_stoichev
* Fixed: Force UCS2 setting factory default.
* Fixed: Fma Options font default character set.
* Fixed: Outlook categories could be edited now.
* Changed: Options Script page predefined settings.
* Added: Localization Options preparations.
*
* Revision 1.36  2004/12/19 23:47:39  voxik
* Fixed IrDA connection memory leaks
*
* Revision 1.35  2004/12/13 15:34:46  z_stoichev
* - Changed: Made disconnect on low battery optional.
* - Changed: Made Battery monitoring optional.
* - Changed: Made Signal monitoring optional.
*
* Revision 1.34  2004/12/10 16:10:00  z_stoichev
* Added: Always start as Minimized option.
* Added: Show splash on startup option.
* Fixed: Some texts.
*
* Revision 1.33.2.4  2004/11/15 13:44:50  expertone
* Show current language
* Support languages/locales without messages
*
* Revision 1.33.2.3  2004/11/01 21:25:36  expertone
* no message
*
* Revision 1.33.2.2  2004/10/25 20:21:55  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.33.2.1  2004/10/19 19:48:47  expertone
* Add localization (gnugettext)
*
* Revision 1.33  2004/10/15 14:01:53  z_stoichev
* Merged with Stable bugfixes
*
* Revision 1.32.6.2  2004/10/15 11:27:59  z_stoichev
* Bugfixes
*
* Revision 1.32.6.1  2004/10/14 16:43:28  z_stoichev
* Bugfixes
*
* Revision 1.32  2004/07/26 12:53:48  z_stoichev
* - Fixed Outlook contacts folders Factory defaults.
* - Changed Options IrmcSync sanity check and user interface.
* - Added Force UCS-2 new text message encoding.
*
* Revision 1.31  2004/07/25 14:40:03  lordlarry
* Fixed: Different Outlook Categories where seen as one Category. Users need to setup Categories again.
*
* Revision 1.30  2004/07/25 13:30:37  lordlarry
* Added the ability to select the Outlook folder where all the New contacts end up.
*
* Revision 1.29  2004/07/01 09:12:19  z_stoichev
* - Fixed Startup options Factory default.
* - Fixed Outlook Folders small icons were bad.
* - Added Outlook Folders Refresh and Default Buttons.
*
* Revision 1.28  2004/06/30 15:39:04  z_stoichev
* GUI changes.
*
* Revision 1.27  2004/06/29 20:10:18  lordlarry
* Using BeginUpdate EndUpdate for Outlook Folders
*
* Revision 1.26  2004/06/29 12:37:11  z_stoichev
* New message window renamed
*
* Revision 1.25  2004/06/28 16:05:25  z_stoichev
* Outlook Categories Quoted.
*
* Revision 1.24  2004/06/28 15:25:05  z_stoichev
* Outlook Categories recoded.
*
* Revision 1.23  2004/06/25 15:20:38  z_stoichev
* - Added Various phone bookmarks options.
* - Added Factory defaults Buttons in options.
* - Changed Made Script usage optional.
*
* Revision 1.22  2004/06/16 08:48:12  z_stoichev
* Added Device Lookup button in Options.
*
* Revision 1.21  2004/06/15 13:00:01  z_stoichev
* Load Outlook folders on need only.
*
* Revision 1.20  2004/06/11 12:29:22  z_stoichev
* Options Windows enlarged.
* Outlook folders icons usage.
* Show current SMS counter.
*
* Revision 1.19  2004/06/05 13:32:55  lordlarry
* Merged with OutlookSync branch
*
* Revision 1.18  2004/05/21 10:09:05  z_stoichev
* Changed logging handle routines.
*
* Revision 1.17  2004/05/19 18:34:16  z_stoichev
* Build 0.1.0.35c
*
* Revision 1.16  2004/03/26 18:37:40  z_stoichev
* Build 0.1.0.35 RC5
*
* Revision 1.15  2004/03/14 18:47:38  z_stoichev
* Remember Last User Profile option.
*
* Revision 1.14  2004/03/08 12:21:29  z_stoichev
* Access serial port by name.
*
* Revision 1.13  2004/01/15 14:13:56  z_stoichev
* Added SMS Counter and Warning level.
*
* Revision 1.12  2004/01/14 15:04:59  z_stoichev
* Pascal Scripting support.
*
* Revision 1.11  2003/12/17 17:15:22  z_stoichev
* Added Option to turn off notifications for unsent messages.
*
* Revision 1.10  2003/12/12 16:55:36  z_stoichev
* Added options for do not load Calls and Profiles on connect.
*
* Revision 1.9  2003/11/28 09:38:07  z_stoichev
* Merged with branch-release-1-1 (Fma 0.10.28c)
*
* Revision 1.8.2.8  2003/11/21 10:59:46  z_stoichev
* Tab order fixed, GUI changes.
* Outlook and other preparations.
* Test proximity caption change.
*
* Revision 1.8.2.7  2003/11/12 15:02:11  z_stoichev
* Proximity detection options changed.
*
* Revision 1.8.2.6  2003/11/11 13:12:51  z_stoichev
* New options introduced.
*
* Revision 1.8.2.5  2003/11/10 14:03:10  z_stoichev
* RC3
*
* Revision 1.8.2.4  2003/10/31 14:50:33  z_stoichev
* Proximity preparations.
*
* Revision 1.8.2.3  2003/10/29 12:02:43  z_stoichev
* Options to disable Obex, IrmcSync and to
* disable initial loading of Gruops and Folders.
*
* Revision 1.8.2.2  2003/10/28 12:59:38  z_stoichev
* Added option to select clock sync mode.
* Some GUI changes, added some texts.
* Prepare for protocol advanced options.
*
* Revision 1.8.2.1  2003/10/27 07:22:54  z_stoichev
* Build 0.1.0 RC1 Initial Checkin.
*
* Revision 1.8  2003/10/22 13:18:09  z_stoichev
* Add checkbox for Progress dialog usage.
* Add checkbox for Show progress dialog on long operations.
* Add checkbox for Move SMS to Archive warning.
* GUI changed.
*
* Revision 1.7  2003/10/17 09:14:59  z_stoichev
* Default Obex packet size set to 255 (by specs).
* Added header comments.
* Changed GUI.
*
*
* 04/02/2003 - Modified by Crino
* Added the synchronize option
* General tab renamed in Window
*
*******************************************************************************
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, StdCtrls, TntStdCtrls, RXSpin, ComCtrls, TntComCtrls, UniTntCtrls, Placemnt, ExtCtrls, TntExtCtrls, Spin,
  Mask, CPortCtl, VirtualTrees, Outlook8, ImgList,
  WIrCOMMSocket, WSocket, WBluetoothSocket, PBFolderDialog,
  Menus, TntMenus, CPort, LMDControl, LMDBaseControl,
  LMDBaseGraphicControl, LMDGraphicControl, LMDFill;

const
  WM_HANDLEMESSAGE = WM_USER + 111;

type
  TOptionsHandleMessage = record
    Msg: Cardinal;
    Message: PChar;
    Length: Longint;
    Result: Longint;
  end;

  TOptionsGroup = class
  private
    FCaption: WideString;
    FTab: TTntTabSheet;
    FSubGroups: TList;
    function GetCount: Integer;
    function GetGroup(I: Integer): TOptionsGroup;
  public
    constructor Create(Tab: TTntTabSheet);
    destructor Destroy; override;
    procedure AddGroup(group: TOptionsGroup);
    property Caption: WideString read FCaption;
    property Tab: TTntTabSheet read FTab;
    property Count: Integer read GetCount;
    property Group[I: Integer]: TOptionsGroup read GetGroup;
  end;

  TfrmOptions = class(TTntForm)
    OptionPages: TTntPageControl;
    btnOK: TTntButton;
    btnCancel: TTntButton;
    tabConnectivity: TTntTabSheet;
    tabAdvanced: TTntTabSheet;
    tabOBEX: TTntTabSheet;
    cbObexPacketSize: TTntGroupBox;
    seMaxPacketSize: TTntEdit;
    seMaxPacketSizeSpin: TTntUpDown;
    lblObexPacketSize: TTntLabel;
    GroupBox3: TTntGroupBox;
    Label11: TTntLabel;
    seCommTimeout: TTntEdit;
    seCommTimeoutSpin: TTntUpDown;
    GroupBox4: TTntGroupBox;
    sePolling: TTntEdit;
    sePollingSpin: TTntUpDown;
    Label5: TTntLabel;
    tabScripting: TTntTabSheet;
    OpenDialog1: TTntOpenDialog;
    tabBehaviour: TTntTabSheet;
    tabSynchronization: TTntTabSheet;
    rbSyncPhonebook: TTntRadioGroup;
    GroupBox7: TTntGroupBox;
    chkMinButton: TTntCheckBox;
    tabSMS: TTntTabSheet;
    GroupBox9: TTntGroupBox;
    tabAppearance: TTntTabSheet;
    GroupBox8: TTntGroupBox;
    cbProgressLongOnly: TTntCheckBox;
    TntLabel1: TTntLabel;
    tabProximity: TTntTabSheet;
    GroupBox2: TTntGroupBox;
    cbProximityLock: TTntCheckBox;
    cbProximityUnlock: TTntCheckBox;
    Label24: TTntLabel;
    Label25: TTntLabel;
    rgProximityAway: TTntRadioGroup;
    rgProximityNear: TTntRadioGroup;
    cbRunSS: TTntCheckBox;
    GroupBox12: TTntGroupBox;
    edScriptPath: TTntEdit;
    ScriptBrowseButton: TTntButton;
    lblScript: TTntLabel;
    cbProgressRestoredOnly: TTntCheckBox;
    btnProximityTest: TTntButton;
    cbCheckOutbox: TTntCheckBox;
    tabOutlook: TTntTabSheet;
    grOutlookConfirmation: TTntGroupBox;
    cbConfirmAdding: TTntCheckBox;
    cbConfirmUpdating: TTntCheckBox;
    cbConfirmDeleting: TTntCheckBox;
    tabOutlookContactFolders: TTntTabSheet;
    OutlookImageList: TImageList;
    GroupBox14: TTntGroupBox;
    tvOutlookContactFolders: TVirtualStringTree;
    LocalWBtSocket: TWBluetoothSocket;
    LocalWIrSocket: TWIrCOMMSocket;
    PBFolderDialog1: TPBFolderDialog;
    GroupBox16: TTntGroupBox;
    cbDiagram: TTntCheckBox;
    tabStartup: TTntTabSheet;
    gbOnConnected1: TTntGroupBox;
    cbAutoProfile: TTntCheckBox;
    gbOnConnecting: TTntGroupBox;
    cbNoGroups: TTntCheckBox;
    cbNoFolders: TTntCheckBox;
    cbNoProfiles: TTntCheckBox;
    cbNoCalls: TTntCheckBox;
    rgExplorer: TTntRadioGroup;
    gbTransparency: TTntGroupBox;
    Label3: TTntLabel;
    Label16: TTntLabel;
    Label17: TTntLabel;
    Label18: TTntLabel;
    GroupBox13: TTntGroupBox;
    Label28: TTntLabel;
    lblSMSCount: TTntLabel;
    cbSMSWarning: TTntCheckBox;
    udSMSCnt: TTntUpDown;
    edSMSCnt: TTntEdit;
    cbSMSReset: TTntCheckBox;
    udSMSCntRst: TTntUpDown;
    edSMSCntRst: TTntEdit;
    Button6: TTntButton;
    GroupBox10: TTntGroupBox;
    cbNoObex: TTntCheckBox;
    cbNoIRMC: TTntCheckBox;
    GroupBox17: TTntGroupBox;
    rbUseIRDA: TTntRadioButton;
    rbUseSerial: TTntRadioButton;
    rbUseBluetooth: TTntRadioButton;
    GroupBox18: TTntGroupBox;
    chkMsgM: TTntCheckBox;
    cbMsgToArchive: TTntCheckBox;
    cbMsgFullWarning: TTntCheckBox;
    GroupBox19: TTntGroupBox;
    lblSTypePrefix: TTntLabel;
    lblScriptType: TTntLabel;
    Label10: TTntLabel;
    cbNoMsgBaloon: TTntCheckBox;
    cbNoMsgPopup: TTntCheckBox;
    cbStateMonitor: TTntCheckBox;
    Label27: TTntLabel;
    btnRefreshOutlookContactFolders: TTntButton;
    pmuOutlookContactsFolder: TTntPopupMenu;
    mniNewContacts: TTntMenuItem;
    Label29: TTntLabel;
    cbForceUCS2: TTntCheckBox;
    gbOnStartup: TTntGroupBox;
    cbShowSplash: TTntCheckBox;
    cbAlwaysMinimized: TTntCheckBox;
    cbBatterylMonitor: TTntCheckBox;
    cbIgnoreLowBattery: TTntCheckBox;
    cbSignalMonitor: TTntCheckBox;
    cbSilentMonitor: TTntCheckBox;
    cbMinuteMonitor: TTntCheckBox;
    Label33: TTntLabel;
    cbDoNotUseScripts: TTntRadioButton;
    cbUseScriptingFramework: TTntRadioButton;
    cbUseScripts: TTntRadioButton;
    OptionTree: TVirtualStringTree;
    btnDefaults: TTntButton;
    lblPageCaption: TTntLabel;
    Bevel1: TBevel;
    ImageAutoLang: TTntImage;
    tabOutlookTaskFolders: TTntTabSheet;
    gbOutlookTaskFolders: TTntGroupBox;
    Label35: TTntLabel;
    Label36: TTntLabel;
    tvOutlookTaskFolders: TVirtualStringTree;
    btnRefreshOutlookTaskFolders: TTntButton;
    pmuOutlookTasksFolder: TTntPopupMenu;
    mniNewTasks: TTntMenuItem;
    tabLanguage: TTntTabSheet;
    GroupBox90: TTntGroupBox;
    TntLabel2: TTntLabel;
    TntLabel3: TTntLabel;
    ComboBoxLang: TTntComboBox;
    btnTestLanguage: TTntButton;
    tabOutlookCalendarFolders: TTntTabSheet;
    TntGroupBox1: TTntGroupBox;
    TntLabel4: TTntLabel;
    TntLabel5: TTntLabel;
    tvOutlookCalendarFolders: TVirtualStringTree;
    btnRefreshOutlookCalendarFolders: TTntButton;
    pmuOutlookCalendarFolder: TTntPopupMenu;
    mniNewCalendar: TTntMenuItem;
    LocalComPort: TComPort;
    tabContacts: TTntTabSheet;
    gbContacts: TTntGroupBox;
    TntLabel9: TTntLabel;
    TntLabel10: TTntLabel;
    cbDisplayNameFormat: TTntComboBox;
    tabOutlookContactMappings: TTntTabSheet;
    TntLabel7: TTntLabel;
    TntGroupBox2: TTntGroupBox;
    TntGroupBox3: TTntGroupBox;
    lbxFieldsFMA: TListBox;
    lbxFieldsOutlook: TListBox;
    LMDFill1: TLMDFill;
    rbShowProgressIf: TTntRadioButton;
    rbShowProgressIndicator: TTntRadioButton;
    rbDontShowProgress: TTntRadioButton;
    tabWebUpdate: TTntTabSheet;
    TntGroupBox4: TTntGroupBox;
    btnCheckForUpdates: TTntButton;
    TntGroupBox5: TTntGroupBox;
    TntLabel8: TTntLabel;
    edWebUpdatesURL: TTntEdit;
    TntLabel11: TTntLabel;
    lblSupportURL: TTntLabel;
    TntLabel12: TTntLabel;
    rbWebUpdateStartup: TTntRadioButton;
    rbWebUpdateDaily: TTntRadioButton;
    tabScriptEditor: TTntTabSheet;
    TntGroupBox6: TTntGroupBox;
    lblScriptEditorName: TTntLabel;
    edScriptEditor: TTntEdit;
    btnBrowseEditor: TTntButton;
    rbScriptEditorBuiltin: TTntRadioButton;
    rbScriptEditorExternal: TTntRadioButton;
    OpenDialog2: TTntOpenDialog;
    tabBookmarks: TTntTabSheet;
    GroupBox15: TTntGroupBox;
    Label30: TTntLabel;
    Label31: TTntLabel;
    edBookmarkDir: TTntEdit;
    btnSelectFavBookm: TTntButton;
    tabOutlookCategories: TTntTabSheet;
    grOutlookCategories: TTntGroupBox;
    btAddCat: TTntButton;
    btDelCat: TTntButton;
    lvOutlookCats: TTntListView;
    btEditCat: TTntButton;
    rbSyncCalendar: TTntRadioGroup;
    rbPhoneClockSync: TTntRadioGroup;
    TntGroupBox7: TTntGroupBox;
    rbOutlookAllCategories: TTntRadioButton;
    rbOutlookCustomCategories: TTntRadioButton;
    lblLinkL10N: TTntLabel;
    chkCallM: TTntCheckBox;
    TntGroupBox8: TTntGroupBox;
    TntLabel13: TTntLabel;
    TntLabel14: TTntLabel;
    rbOutlookNewActionLinkTo: TTntRadioButton;
    rbOutlookNewActionAsNew: TTntRadioButton;
    rbWebUpdateNone: TTntRadioButton;
    rbWebUpdateWeekly: TTntRadioButton;
    tbComposeSpin: TTntTrackBar;
    tbMessageSpin: TTntTrackBar;
    tbCallSpin: TTntTrackBar;
    tbLogSpin: TTntTrackBar;
    TntLabel6: TTntLabel;
    TntLabel15: TTntLabel;
    TntLabel16: TTntLabel;
    TntLabel17: TTntLabel;
    TntLabel18: TTntLabel;
    TntLabel19: TTntLabel;
    TntLabel20: TTntLabel;
    TntLabel21: TTntLabel;
    rbOutlookSync: TTntRadioGroup;
    rbBookmarksSync: TTntRadioGroup;
    tabChat: TTntTabSheet;
    TntGroupBox9: TTntGroupBox;
    TntLabel22: TTntLabel;
    edChatName: TTntEdit;
    cbChatLongSMS: TTntCheckBox;
    cbChatBoldFont: TTntCheckBox;
    btnHelp: TTntButton;
    cbWelcomeTips: TTntCheckBox;
    TntGroupBox10: TTntGroupBox;
    cbBookmarksPhone: TTntCheckBox;
    rbBookmarksIE: TTntRadioButton;
    rbBookmarksFirefox: TTntRadioButton;
    rbBookmarksOpera: TTntRadioButton;
    cbBookmarksPC: TTntCheckBox;
    TntGroupBox11: TTntGroupBox;
    lblDevice: TTntLabel;
    btnLookupDevice: TTntButton;
    btnConnectWizard: TTntButton;
    pcConnectDetails: TPageControl;
    tsConnectBT: TTabSheet;
    groupBluetoothSetup: TTntGroupBox;
    Label14: TTntLabel;
    Label13: TTntLabel;
    TntLabel23: TTntLabel;
    cbBTDevice: TTntComboBox;
    edBTPort: TTntEdit;
    edBTPortSpin: TTntUpDown;
    edBTAddress: TTntEdit;
    btnBTSearch: TTntButton;
    tsConnectIR: TTabSheet;
    tsConnectCOM: TTabSheet;
    groupSerialPortSetup: TTntGroupBox;
    Label6: TTntLabel;
    Label7: TTntLabel;
    Label2: TTntLabel;
    Label1: TTntLabel;
    cbRTSFlow: TTntComboBox;
    cbDTRFlow: TTntComboBox;
    sePort: TComComboBox;
    cbBaudrate: TComComboBox;
    TntGroupBox12: TTntGroupBox;
    lblConnectionHelp: TTntLabel;
    TntLabel24: TTntLabel;
    tabSMSDelivery: TTntTabSheet;
    TntGroupBox13: TTntGroupBox;
    lvRules: TTntListView;
    TntLabel25: TTntLabel;
    btnRuleNew: TTntButton;
    btnRuleEdit: TTntButton;
    btnRuleDel: TTntButton;
    TntLabel26: TTntLabel;
    btnRunRules: TTntButton;
    btnDefaultNewContactDir: TTntButton;
    cbArchiveDublicates: TTntCheckBox;
    cbKeylockMonitor: TTntCheckBox;
    TntLabel27: TTntLabel;
    TntLabel28: TTntLabel;
    cbNoAlarms: TTntCheckBox;
    cbAutoClock: TTntCheckBox;
    gbOnConnected2: TTntGroupBox;
    cbAutoInbox: TTntCheckBox;
    cbAutoSync: TTntCheckBox;
    cbAutoCalendar: TTntCheckBox;
    cbAutoBookmarks: TTntCheckBox;
    cbAutoOutlookSync: TTntCheckBox;
    TntGroupBox14: TTntGroupBox;
    TntLabel30: TTntLabel;
    TntLabel29: TTntLabel;
    lblDeliveryStatus: TTntLabel;
    TntButton1: TTntButton;
    cbNotifyBaloons: TTntCheckBox;
    cbNoCallPopup: TTntCheckBox;
    cbNoCallBaloon: TTntCheckBox;
    tabCalendar: TTntTabSheet;
    TntGroupBox15: TTntGroupBox;
    cbCalWideMode: TTntCheckBox;
    cbCalRecurrence: TTntCheckBox;
    cbCalRecurrAsk: TTntCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edScriptPathChange(Sender: TObject);
    procedure ScriptBrowseButtonClick(Sender: TObject);
    procedure rbUseSerialClick(Sender: TObject);
    procedure cbNoObexClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure chkMsgMClick(Sender: TObject);
    procedure btnProximityTestClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure cbOutlookCategoriesClick(Sender: TObject);
    procedure btAddCatClick(Sender: TObject);
    procedure btDelCatClick(Sender: TObject);
    procedure cbNoProfilesClick(Sender: TObject);
    procedure cbStateMonitorClick(Sender: TObject);
    procedure OptionPagesChange(Sender: TObject);
    procedure btnLookupDeviceClick(Sender: TObject);
    procedure btnSelectFavBookmClick(Sender: TObject);
    procedure cbBookmarksClick(Sender: TObject);
    procedure lvOutlookCatsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure cbNoIRMCClick(Sender: TObject);
    procedure cbAlwaysMinimizedClick(Sender: TObject);
    procedure cbBatterylMonitorClick(Sender: TObject);
    procedure cbUseScriptsClick(Sender: TObject);
    procedure btEditCatClick(Sender: TObject);
    procedure lvOutlookCatsDblClick(Sender: TObject);
    procedure ComboBoxLangDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ComboBoxLangChange(Sender: TObject);
    procedure btnTestLanguageClick(Sender: TObject);
    procedure cbAutoBookmarksClick(Sender: TObject);
    procedure cbBTDeviceSelect(Sender: TObject);
    procedure OptionTreeInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure OptionTreeInitChildren(Sender: TBaseVirtualTree;
      Node: PVirtualNode; var ChildCount: Cardinal);
    procedure OptionTreeGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure OptionTreeFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure btnDefaultsClick(Sender: TObject);
    procedure btnRefreshOutlookContactFoldersClick(Sender: TObject);
    procedure btnRefreshOutlookCalendarFoldersClick(Sender: TObject);
    procedure btnRefreshOutlookTaskFoldersClick(Sender: TObject);
    procedure tvOutlookFoldersFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure tvOutlookFoldersGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure tvOutlookFoldersGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure tvOutlookFoldersPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure tvOutlookFoldersInitNode(Sender: TBaseVirtualTree;
      ParentNode, Node: PVirtualNode;
      var InitialStates: TVirtualNodeInitStates);
    procedure tvOutlookFoldersInitChildren(Sender: TBaseVirtualTree;
      Node: PVirtualNode; var ChildCount: Cardinal);
    procedure tvOutlookContactFoldersChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure tvOutlookCalendarFoldersChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure tvOutlookTaskFoldersChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure mniNewContactsClick(Sender: TObject);
    procedure pmuOutlookCalendarFolderPopup(Sender: TObject);
    procedure mniNewCalendarClick(Sender: TObject);
    procedure pmuOutlookTasksFolderPopup(Sender: TObject);
    procedure mniNewTasksClick(Sender: TObject);
    procedure LocalComPortRxChar(Sender: TObject; Count: Integer);
    procedure OnSocketDataAvailable(Sender: TObject; Error: Word);
    procedure TntFormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ExecuteClick(Sender: TObject);
    procedure tabOutlookContactMappingsShow(Sender: TObject);
    procedure lbxFieldsFMAClick(Sender: TObject);
    procedure lbxFieldsOutlookClick(Sender: TObject);
    procedure OptionTreeGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure rbProgressClick(Sender: TObject);
    procedure btnCheckForUpdatesClick(Sender: TObject);
    procedure rdScriptEditorClick(Sender: TObject);
    procedure btnBrowseEditorClick(Sender: TObject);
    procedure cbBookmarksPhoneClick(Sender: TObject);
    procedure btnBTSearchClick(Sender: TObject);
    procedure edBTAddressChange(Sender: TObject);
    procedure btnConnectWizardClick(Sender: TObject);
    procedure btnRuleNewClick(Sender: TObject);
    procedure lvRulesSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btnRuleDelClick(Sender: TObject);
    procedure btnRuleEditClick(Sender: TObject);
    procedure lvRulesDblClick(Sender: TObject);
    procedure btnRunRulesClick(Sender: TObject);
    procedure OnFolderSelected(Sender: TObject; Node: PVirtualNode;
      var EnableOKButton: boolean; var EnableNewFolder: boolean);
    procedure tvOutlookContactFoldersChange(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure btnDefaultNewContactDirClick(Sender: TObject);
    procedure TntButton1Click(Sender: TObject);
    procedure chkCallMClick(Sender: TObject);
    procedure cbCalRecurrenceClick(Sender: TObject);
  private
    Options: TOptionsGroup;
    OutlookApp: TOutlookApplication;
    OutlookNS: NameSpace;
    FSelectedOutlookContactFolders, FSelectedOutlookCalendarFolders, FSelectedOutlookTaskFolders: TStringList;
    FOutlookNewContactsNode, FOutlookNewCalendarNode, FOutlookNewTasksNode, FPopupNode: PVirtualNode;
    FCustomScript, FOutlookNewContactsFolder, FOutlookNewCalendarFolder, FOutlookNewTasksFolder: String;

    FReceived: boolean;
    FRxBuffer: TStringList;
    FMessageBuf: string;

    BtDevices: TBtDevicesInfo;
    FBtNotSupported: boolean;
    FBtAddress: String;
    FBtDevice: WideString;
    
    FOutlookFieldMappings: TStringList;
    FDeliveryFolder: PVirtualNode;

    procedure UpdateBtAddress(Value: String);
    procedure UpdateBtCombo(Address: String);

    procedure TxAndWait(Data: string);

    procedure LoadOutlookFolders;
    function GetBtAddress: String;
    procedure SetBtAddress(const Value: String);
    function Get_ConnectionType: Integer;
    procedure Set_ConnectionType(value: Integer);
    function Get_OutlookCategories: WideString;
    procedure Set_OutlookCategories(const Value: WideString);
    function Get_SelectedOutlookContactFolders: String;
    procedure Set_SelectedOutlookContactFolders(const Value: String);
    function Get_SelectedOutlookCalendarFolders: String;
    procedure Set_SelectedOutlookCalendarFolders(const Value: String);
    function Get_SelectedOutlookTaskFolders: String;
    procedure Set_SelectedOutlookTaskFolders(const Value: String);
    procedure SerializeSelectedOutlookFolder(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
    procedure DeSerializeSelectedOutlookFolder(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
    function Get_OutlookNewContactsFolder: String;
    procedure Set_OutlookNewContactsFolder(const Value: String);
    procedure InitOutlookNewContactsFolder;
    procedure GetDefaultOutlookNewContactsFolder(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
    procedure DeSerializeOutlookNewContactsFolder(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
    function Get_OutlookNewCalendarFolder: String;
    procedure Set_OutlookNewCalendarFolder(const Value: String);
    procedure InitOutlookNewCalendarFolder;
    procedure GetDefaultOutlookNewCalendarFolder(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
    procedure DeSerializeOutlookNewCalendarFolder(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
    function Get_OutlookNewTasksFolder: String;
    procedure Set_OutlookNewTasksFolder(const Value: String);
    procedure InitOutlookNewTasksFolder;
    procedure GetDefaultOutlookNewTasksFolder(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
    procedure DeSerializeOutlookNewTasksFolder(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
    procedure LoadFieldMappings;
    procedure ResetFieldMappingsToDefault;
    procedure SetOutlookFieldMappings(const Value: String);
    function GetOutlookFieldMappings: String;
    function Get_DeliveryRules: WideString;
    procedure Set_DeliveryRules(const Value: WideString);
    procedure Set_DeliveryFolder(const Value: PVirtualNode);
    function Get_UILangChanged: Boolean;
    procedure Set_UILangChanged(const Value: Boolean);
  protected
    FInitDeliveryRules: WideString;
    procedure HandleMessage(var Msg: TOptionsHandleMessage); message WM_HANDLEMESSAGE;
    procedure WM_SYSCOLORCHANGE(var Msg: TMessage); message WM_SYSCOLORCHANGE;
  public
    RunGettingStarted: Boolean;
    NewUILang: string;
    procedure SanityCheck;

    property UILangChanged: Boolean read Get_UILangChanged write Set_UILangChanged;

    property BtAddress: String read GetBtAddress write SetBtAddress;
    property BtDevice: WideString read FBtDevice;
    property ConnectionType: Integer read Get_ConnectionType write Set_ConnectionType;

    property OutlookCategories: WideString read Get_OutlookCategories write Set_OutlookCategories;
    property SelectedOutlookContactFolders: String read Get_SelectedOutlookContactFolders write Set_SelectedOutlookContactFolders;
    property OutlookNewContactsFolder: String read Get_OutlookNewContactsFolder write Set_OutlookNewContactsFolder;
    property SelectedOutlookCalendarFolders: String read Get_SelectedOutlookCalendarFolders write Set_SelectedOutlookCalendarFolders;
    property OutlookNewCalendarFolder: String read Get_OutlookNewCalendarFolder write Set_OutlookNewCalendarFolder;
    property SelectedOutlookTaskFolders: String read Get_SelectedOutlookTaskFolders write Set_SelectedOutlookTaskFolders;
    property OutlookNewTasksFolder: String read Get_OutlookNewTasksFolder write Set_OutlookNewTasksFolder;
    property OutlookFieldMappings: String read GetOutlookFieldMappings write SetOutlookFieldMappings;

    property DeliveryRules: WideString read Get_DeliveryRules write Set_DeliveryRules;
    property DeliveryFolder: PVirtualNode read FDeliveryFolder write Set_DeliveryFolder;
  end;

var
  frmOptions: TfrmOptions;

implementation

uses
  gnugettext, gnugettexthelpers, uDialogs,
  ShellAPI, WinSock, WebUpdate, Unit1, uContactSync, uFMASync, uThreadSafe, uSMS, uComposeSMS, uStatusDlg,
  uGlobal, uInputQuery, uOutlookSync, uAbout, uChatSMS, uDeliveryRule, uBrowseFolders;

{$R *.dfm}

const
  ScriptingFrameworkMainFile = 'fma-scripting-framework.vbs';

type
  TOptionsTreeItemData = record
    Data: TOptionsGroup;
  end;
  POptionsTreeItemData = ^TOptionsTreeItemData;

  TOutlookFolder = record
    Folder: MAPIFolder;
    IsTarget: Boolean;
  end;
  POutlookFolder = ^TOutlookFolder;

{********************************************************************************
 * TOptionsGroup
 ********************************************************************************}

constructor TOptionsGroup.Create(Tab: TTntTabSheet);
begin
  FCaption := Tab.Caption;
  FTab := Tab;
  FSubGroups := TList.Create;
end;

destructor TOptionsGroup.Destroy;
  var
    I: Integer;
begin
  for I := 0 to FSubGroups.Count - 1 do
    TOptionsGroup(FSubGroups.Items[I]).Destroy;
  FSubGroups.Destroy;
end;

function TOptionsGroup.GetCount: Integer;
begin
  Result := FSubGroups.Count;
end;

function TOptionsGroup.GetGroup(I: Integer): TOptionsGroup;
begin
  Result := TOptionsGroup(FSubGroups.Items[I]);
end;

procedure TOptionsGroup.AddGroup(group: TOptionsGroup);
begin
  FSubGroups.Add(group);
end;

{********************************************************************************
 * Form events
 ********************************************************************************}

procedure TfrmOptions.FormCreate(Sender: TObject);
var
  ogrp1, ogrp2, scred, smsgr, outl: TOptionsGroup;
  i: Integer;
  S, L: string;
  B: TBitmap;
  VerInfo: TOsversionInfo;
begin
  gghTranslateComponent(self);

  FRxBuffer := TStringList.Create;
  FOutlookFieldMappings := TStringList.Create;
  FSelectedOutlookContactFolders := TStringList.Create;
  FSelectedOutlookCalendarFolders := TStringList.Create;
  FSelectedOutlookTaskFolders := TStringList.Create;

  OutlookApp := nil;
  OutlookNS := nil;

  { Fill Options }
  Options := TOptionsGroup.Create(nil);
  Options.AddGroup(TOptionsGroup.Create(tabStartup));

  ogrp1 := TOptionsGroup.Create(tabAppearance);
  Options.AddGroup(ogrp1);

  ogrp1.AddGroup(TOptionsGroup.Create(tabLanguage));
  ogrp1.AddGroup(TOptionsGroup.Create(tabBehaviour));
  ogrp1.AddGroup(TOptionsGroup.Create(tabProximity));

  ogrp1 := TOptionsGroup.Create(tabConnectivity);
  Options.AddGroup(ogrp1);
  ogrp1.AddGroup(TOptionsGroup.Create(tabOBEX));

  ogrp1 := TOptionsGroup.Create(tabSynchronization);
  Options.AddGroup(ogrp1);
  ogrp1.AddGroup(TOptionsGroup.Create(tabBookmarks));

  outl := TOptionsGroup.Create(tabOutlook);
  ogrp1.AddGroup(outl);
  outl.AddGroup(TOptionsGroup.Create(tabOutlookCategories));
  outl.AddGroup(TOptionsGroup.Create(tabOutlookContactFolders));
  outl.AddGroup(TOptionsGroup.Create(tabOutlookContactMappings));
//  outl.AddGroup(TOptionsGroup.Create(tabOutlookCalendarFolders));
//  outl.AddGroup(TOptionsGroup.Create(tabOutlookTaskFolders));

  smsgr := TOptionsGroup.Create(tabSMS);
  ogrp1.AddGroup(smsgr);
  smsgr.AddGroup(TOptionsGroup.Create(tabSMSDelivery));

  ogrp2 := TOptionsGroup.Create(tabCalendar);
  ogrp1.AddGroup(ogrp2);

  scred := TOptionsGroup.Create(tabScripting);
  Options.AddGroup(scred);
  scred.AddGroup(TOptionsGroup.Create(tabScriptEditor));

  Options.AddGroup(TOptionsGroup.Create(tabAdvanced));
  Options.AddGroup(TOptionsGroup.Create(tabContacts));
  Options.AddGroup(TOptionsGroup.Create(tabChat));
  Options.AddGroup(TOptionsGroup.Create(tabWebUpdate));

  OptionTree.NodeDataSize := SizeOf(TOptionsTreeItemData);
  OptionTree.RootNodeCount := Options.Count;

  LoadFieldMappings;

  // Select default item.
  OptionTree.Selected[OptionTree.RootNode.FirstChild] := True;
  OptionTree.FocusedNode := OptionTree.RootNode.FirstChild;

  { Make web links }
  lblLinkL10N.Font.Style := lblLinkL10N.Font.Style + [fsUnderline];
  lblLinkL10N.Font.Color := clBlue;
  lblSupportURL.Font.Style := lblSupportURL.Font.Style + [fsUnderline];
  lblSupportURL.Font.Color := clBlue;

  { Make important widgets bold }
  Label24.Font.Style := Label24.Font.Style + [fsBold];
  Label25.Font.Style := Label25.Font.Style + [fsBold];
  lblScriptType.Left := lblSTypePrefix.Left + lblSTypePrefix.Width + 8;
  lblScriptType.Font.Style := lblScriptType.Font.Style + [fsBold];
  rbUseBluetooth.Font.Style := rbUseBluetooth.Font.Style + [fsBold];
  rbUseIRDA.Font.Style := rbUseIRDA.Font.Style + [fsBold];
  rbUseSerial.Font.Style := rbUseSerial.Font.Style + [fsBold];
  lblSMSCount.Font.Style := lblSMSCount.Font.Style + [fsBold];
  lblDeliveryStatus.Left := TntLabel29.Left + TntLabel29.Width + 8;
  lblDeliveryStatus.Font.Style := lblDeliveryStatus.Font.Style + [fsBold];

  sePort.Style := csDropDown;
  
  DefaultInstance.GetListOfLanguages(DefaultTextDomain, ComboBoxLang.Items.AnsiStrings);
  if ComboBoxLang.Items.AnsiStrings.IndexOf('en') < 0 then // do not localize
    ComboBoxLang.Items.AnsiStrings.Add('en'); // do not localize
  ComboBoxLang.Items.Insert(0, '');
  for i := 1 to ComboBoxLang.Items.Count - 1 do
    begin
      L := ComboBoxLang.Items[i];
      S := IncludeTrailingPathDelimiter(extractfilepath(ExecutableFilename)) + 'locale' + PathDelim + L + PathDelim; // do not localize
      if FileExists(S + L + '.bmp') then // do not localize
        S := S + L + '.bmp' // do not localize
      else if FileExists(S + 'flag.bmp') then // do not localize
        S := S + 'flag.bmp' // do not localize
      else
        S := '';
      try
        B := TBitmap.Create;
        if S<>'' then
          B.LoadFromFile(S)
        else
          B.LoadFromResourceName(HInstance,'FLAG_'+UpperCase(L)); // do not localize
        ComboBoxLang.Items.Objects[i] := B;
      except;
      end;
    end;

{$IFNDEF VER150}
  Form1.ThemeManager1.CollectForms(Self);
{$ENDIF}

  VerInfo.dwOSVersionInfoSize := SizeOf(VerInfo);
  GetVersionEx(VerInfo);
  if VerInfo.dwMajorVersion < 5 then begin
    { Windows 9x, Me or NT }
    gbTransparency.Visible := False;
    rbUseBluetooth.Enabled := False;
    rbUseIRDA.Enabled := False;
    rbUseSerialClick(rbUseSerial);
  end;
  if (VerInfo.dwMajorVersion = 5) and (VerInfo.dwMinorVersion = 0) then begin
    { Windows 2000, SP123 }
    rbUseBluetooth.Enabled := False;
    if rbUseBluetooth.Checked then
      rbUseSerialClick(rbUseSerial);
  end;
end;

procedure TfrmOptions.FormShow(Sender: TObject);
begin
  edScriptPathChange(nil);
  OptionTree.Selected[OptionTree.RootNode.FirstChild] := True;
  OptionTree.FocusedNode := OptionTree.RootNode.FirstChild;
  cbOutlookCategoriesClick(Self);
  lblSMSCount.Caption := _('Messages sent so far:') + ' ' + IntToStr(Form1.FSMSCounter);
  lblDevice.Caption := '';
  //rbBookmarksClick(nil);
  FCustomScript := edScriptPath.Text;
  OptionPages.Style := tsButtons;
  cbMinuteMonitor.Enabled := not Form1.IsK750Clone; // not suportd for K750+
//  LMDFill1.FillObject.Gradient.Color := Form1.LMDFill1.FillObject.Gradient.Color;
//  LMDFill1.FillObject.Gradient.EndColor := Form1.LMDFill1.FillObject.Gradient.EndColor;
end;

procedure TfrmOptions.FormDestroy(Sender: TObject);
var I: Integer;
begin
  if Assigned(OutlookApp) then OutlookApp.Destroy;
  Options.Free;
  FRxBuffer.Free;
  if Assigned(BtDevices) then BtDevices.Free;
  FSelectedOutlookContactFolders.Free;
  FSelectedOutlookCalendarFolders.Free;
  FSelectedOutlookTaskFolders.Free;
  FOutlookFieldMappings.Free;

  for I := 0 to ComboBoxLang.Items.Count - 1 do
    ComboBoxLang.Items.Objects[I].Free;
end;

procedure TfrmOptions.edScriptPathChange(Sender: TObject);
begin
  lblScriptType.Caption := LowerCase(ExtractFileExt(edScriptPath.Text));
  lblScriptType.Caption := Copy(lblScriptType.Caption, 2, length(lblScriptType.Caption));
  if Pos(ScriptingFrameworkMainFile,LowerCase(edScriptPath.Text)) <> 0 then begin
    if cbUseScripts.Checked then begin
      cbUseScriptingFramework.Checked := True;
      cbUseScriptsClick(nil);
    end;
  end
  else
    { remember any custmo script, but scripting framework one }
    FCustomScript := edScriptPath.Text;
end;

procedure TfrmOptions.ScriptBrowseButtonClick(Sender: TObject);
begin
  OpenDialog1.InitialDir := WideExtractFileDir(edScriptPath.Text);
  OpenDialog1.FileName := WideExtractFileName(edScriptPath.Text);
  if OpenDialog1.Execute then begin
    cbUseScripts.Checked := True;
    edScriptPath.Text := OpenDialog1.FileName;
  end
  else
    cbDoNotUseScripts.Checked := True;
end;

procedure TfrmOptions.rbUseSerialClick(Sender: TObject);
begin
  (Sender as TTntRadioButton).Checked := True;
  case (Sender as TTntRadioButton).Tag of
    0: pcConnectDetails.ActivePage := tsConnectBT;
    1: pcConnectDetails.ActivePage := tsConnectIR;
    2: pcConnectDetails.ActivePage := tsConnectCOM;
  end;
  if btnLookupDevice.Enabled then lblDevice.Caption := '';
  case pcConnectDetails.ActivePageIndex of
    0: begin
         lblConnectionHelp.Caption := _('Set Port = 0 to let the system decide which port to use.');
         OptionPagesChange(Self);
       end;  
    1: lblConnectionHelp.Caption := _('No settings are available for this type of connection.');
    2: lblConnectionHelp.Caption := _('RTS Flow Control might be needed on some devices or cables.');
  end;
end;

procedure TfrmOptions.cbNoObexClick(Sender: TObject);
begin
  if cbNoObex.Checked then begin
    { If no obex, disable other as well }
    if Visible then begin
      MessageBeep(MB_ICONASTERISK);
      if MessageDlgW(_('Phone Folder Browseing and IRMC Sync protocol require OBEX protocol, so these features will be disabled as well!'),
        mtInformation, MB_OKCANCEL) <> ID_OK then begin
        cbNoObex.Checked := False;
        exit;
      end;
    end;
    cbNoFolders.Checked := True;
    cbNoIRMC.Checked := True;
    {}
    cbNoIRMC.Enabled := False;
    cbNoFolders.Enabled := False;
    rbSyncPhonebook.Enabled := False;
    rbSyncCalendar.Enabled := False;
    cbObexPacketSize.Enabled := False;
    lblObexPacketSize.Enabled := False;
  end else begin
    cbNoIRMC.Enabled := True;
    cbNoFolders.Enabled := True;
    rbSyncPhonebook.Enabled := True;
    rbSyncCalendar.Enabled := True;
    cbObexPacketSize.Enabled := True;
    lblObexPacketSize.Enabled := True;
  end;
end;

procedure TfrmOptions.btnOKClick(Sender: TObject);
begin
  SanityCheck;
  ModalResult := mrOk;
end;

procedure TfrmOptions.chkMsgMClick(Sender: TObject);
begin
  cbNoMsgPopup.Enabled := chkMsgM.Checked;
  cbNoMsgBaloon.Enabled := chkMsgM.Checked;
  cbMsgToArchive.Enabled := chkMsgM.Checked;
  cbMsgFullWarning.Enabled := chkMsgM.Checked;
end;

procedure TfrmOptions.btnProximityTestClick(Sender: TObject);
begin
  SanityCheck;
  btnProximityTest.Enabled := False;
  btnProximityTest.Caption := _('Testing...');
  try
    Form1.DoProximityTest;
  finally
    btnProximityTest.Enabled := True;
    btnProximityTest.Caption := _('Test Proximity');
  end;
end;

procedure TfrmOptions.SanityCheck;
begin
  if Visible or (OptionPages.ActivePage = tabProximity) then
    if (rgProximityAway.ItemIndex = rgProximityNear.ItemIndex) and (rgProximityAway.ItemIndex <> 4) then begin
      OptionPages.ActivePage := tabProximity;
      MessageDlgW(_('Proximity settings cannot match for Away and Near.'), mtError, MB_OK);
      Abort;
    end;
  if Visible or (OptionPages.ActivePage = tabChat) then
    if (Trim(edChatName.Text) = '') or (Length(edChatName.Text) < 2) then begin
      OptionPages.ActivePage := tabChat;
      MessageDlgW(_('Enter chat Nick Name at least 2 characters long.'), mtError, MB_OK);
      Abort;
    end;
  if Visible and (lvRules.Items.Count <> 0) and (not chkMsgM.Checked or not cbMsgToArchive.Checked) then
    case MessageDlgW(_('Delivery Rules require "Move message to FMA" option, which is disabled.')+sLineBreak+sLineBreak+
      _('Do you wish to enable it now in order to use Delivery Rules?'), mtConfirmation, MB_YESNOCANCEL) of
      ID_YES: begin
        cbMsgToArchive.Checked := True;
        chkMsgM.Checked := True;
      end;
      ID_CANCEL: Abort;
    end;
end;

procedure TfrmOptions.Button6Click(Sender: TObject);
begin
  Form1.FSMSCounter := 0;
  Form1.FSMSCounterReseted := True;
  if frmMessageContact.Visible then
    frmMessageContact.FormActivate(frmMessageContact);
  lblSMSCount.Caption := _('Messages sent so far:') + ' ' + IntToStr(Form1.FSMSCounter);
end;

procedure TfrmOptions.cbOutlookCategoriesClick(Sender: TObject);
begin
  lvOutlookCats.Enabled := not rbOutlookAllCategories.Checked;
  if lvOutlookCats.Enabled then
    lvOutlookCats.Color := clWindow
  else
    lvOutlookCats.Color := clBtnFace;
  btAddCat.Enabled := lvOutlookCats.Enabled;
  lvOutlookCatsSelectItem(lvOutlookCats,nil,False);
end;

procedure TfrmOptions.btAddCatClick(Sender: TObject);
var
  s: WideString;
  function CatExists: boolean;
  var
    i: Integer;
  begin
    Result := False;
    for i := 0 to lvOutlookCats.Items.Count-1 do
      if WideCompareStr(s,lvOutlookCats.Items[i].Caption) = 0 then begin
        Result := True;
        break;
      end;
  end;
begin
  s := '';
  if WideInputQuery(_('Category'),_('Category name:'),s) then
    if Trim(s) <> '' then
      if not CatExists then
        with lvOutlookCats.Items.Add do begin
          Caption := Trim(s);
          ImageIndex := 0;
        end
      else
        MessageDlgW(_('This Category name already exists.'),mtError,MB_OK)
    else
      MessageDlgW(_('Category name could not be empty.'),mtError,MB_OK);
end;

procedure TfrmOptions.btEditCatClick(Sender: TObject);
var
  s: WideString;
begin
  s := lvOutlookCats.Selected.Caption;
  if WideInputQuery(_('Category'),_('Category name:'),s) then
    if Trim(s) <> '' then
      with lvOutlookCats.Selected do Caption := Trim(s)
    else
      lvOutlookCats.Selected.Delete;
end;

procedure TfrmOptions.btDelCatClick(Sender: TObject);
var
  i: integer;
begin
  MessageBeep(MB_ICONQUESTION);
  if MessageDlgW(WideFormat(_('Are you sure you want to remove %s?'),
    [ngettext('this category','these categories',lvOutlookCats.SelCount)]),
    mtInformation, MB_YESNO or MB_DEFBUTTON2) = ID_YES then begin
    for i := lvOutlookCats.Items.Count-1 downto 0 do
      if lvOutlookCats.Items[i].Selected then
        lvOutlookCats.Items[i].Delete;
    btDelCat.Enabled := False;
  end;
end;

procedure TfrmOptions.cbNoProfilesClick(Sender: TObject);
begin
  if cbNoProfiles.Checked then begin
    cbAutoProfile.Checked := False;
    cbAutoProfile.Enabled := False;
  end else
    cbAutoProfile.Enabled := True;
end;

procedure TfrmOptions.cbStateMonitorClick(Sender: TObject);
begin
  cbDiagram.Enabled := cbStateMonitor.Checked;
  if not cbDiagram.Enabled then cbDiagram.Checked := False;
end;

procedure TfrmOptions.btnLookupDeviceClick(Sender: TObject);
  procedure ProbeConnectedDevice(UseMainFormDevice: boolean);
  var
    model: string;
  begin
    if UseMainFormDevice then begin
      { Using Form1 components (which are already connected) }
      Form1.TxAndWait('ATI'); // do not localize
      model := ThreadSafe.RxBuffer[0];
    end
    else begin
      { Using this form components (we have new connection) }
      TxAndWait('ATE0'); // do not localize
      TxAndWait('ATI'); // do not localize
      model := FRxBuffer[0];
    end;
    if Trim(model) = '' then model := _('Unknown');

    lblDevice.Caption := _('Found device: ') + model;
  end;
begin
  lblDevice.Caption := _('Searching...');
  lblDevice.Hint := '';
  lblDevice.Update;
  btnLookupDevice.Enabled := False;
  try
    try
      if rbUseBluetooth.Checked then begin
        if not Form1.FConnected or (ThreadSafe.ConnectionType <> 0) or (Form1.WBtSocket.Addr <> BtAddress) then begin
          { Different BT address so lookup by using local socket component }
          LocalWBtSocket.Addr := BtAddress;
          LocalWBtSocket.Port := edBTPort.Text;

          LocalWBtSocket.Connect;
          while LocalWBtSocket.State = wsConnecting do WaitASec();

          if LocalWBtSocket.State = wsConnected then begin
            ProbeConnectedDevice(False);

            LocalWBtSocket.Close;
          end
          else
            Abort;
        end
        else
          { We already have connected such BT address in main form }
          ProbeConnectedDevice(True);
      end;

      if rbUseIRDA.Checked then begin
        with LocalWIrSocket.GetConnectedDevices do
          try
            if Count > 0 then
              LocalWIrSocket.irDeviceID := Items[0].irdaDeviceID // check first available IR device only!
            else
              Abort; // silent error if no IR devices
          finally
            Free;
          end;

        if not Form1.FConnected or (ThreadSafe.ConnectionType <> 1) or (Form1.WIrSocket.irDeviceID <> LocalWIrSocket.irDeviceID) then begin
          { Different IR address so lookup by using local socket component }
          LocalWIrSocket.Connect;
          while LocalWIrSocket.State = wsConnecting do WaitASec();

          if LocalWIrSocket.State = wsConnected then begin
            ProbeConnectedDevice(False);

            LocalWIrSocket.Close;
          end
          else
            Abort;
        end
        else
          { We already have connected such IR address in main form }
          ProbeConnectedDevice(True);
      end;

      if rbUseSerial.Checked then begin
        if not Form1.FConnected or (ThreadSafe.ConnectionType <> 2) or (Form1.ComPort.Port <> sePort.Text) then begin
          { Different COM port so lookup by using local socket component }
          LocalComPort.Port := sePort.Text;
          LocalComPort.BaudRate := StrToBaudRate(cbBaudrate.Text);
          LocalComPort.FlowControl.ControlRTS := TRTSFlowControl(cbRTSFlow.ItemIndex);
          LocalComPort.FlowControl.ControlDTR := TDTRFlowControl(cbDTRFlow.ItemIndex);

          LocalComPort.Open;

          // Give the chance to run the com thread.
          // The main event loop in TComThread.Execute have to be started (see the CPort.pas)
          WaitASec(200);
          
          try
            ProbeConnectedDevice(False);
          finally
            LocalComPort.Close;
          end;
        end
        else
          { We already have connected such COM port in main form }
          ProbeConnectedDevice(True);
      end;
    except
      on E: Exception do begin
        lblDevice.Caption := _('Device was not found!');
        lblDevice.Hint := E.Message;
      end;
    end;
  finally
    btnLookupDevice.Enabled := True;
  end;
end;

procedure TfrmOptions.btnSelectFavBookmClick(Sender: TObject);
begin
  PBFolderDialog1.Folder := edBookmarkDir.Text;
  if PBFolderDialog1.Execute then
    edBookmarkDir.Text := PBFolderDialog1.Folder;
end;

procedure TfrmOptions.cbBookmarksClick(Sender: TObject);
begin
  edBookmarkDir.Enabled := cbBookmarksPC.Checked;
  if edBookmarkDir.Enabled then
    edBookmarkDir.Color := clWindow
  else
    edBookmarkDir.Color := clBtnFace;
  btnSelectFavBookm.Enabled := edBookmarkDir.Enabled;
  Label30.Enabled := edBookmarkDir.Enabled;
  Label31.Enabled := edBookmarkDir.Enabled;
end;

procedure TfrmOptions.lvOutlookCatsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  btEditCat.Enabled := btAddCat.Enabled and (lvOutlookCats.SelCount = 1);
  btDelCat.Enabled := btAddCat.Enabled and (lvOutlookCats.SelCount >= 1);
end;

procedure TfrmOptions.cbNoIRMCClick(Sender: TObject);
begin
  if cbNoIRMC.Checked then begin
    { If no irmcSync, disable Outlook too }
    if Visible then begin
      MessageBeep(MB_ICONASTERISK);
      if MessageDlgW(_('Phonebook, Organizer and Outlook synchronizations require IRMC Sync, so these features will be disabled as well!'),
        mtInformation, MB_OKCANCEL) <> ID_OK then begin
        cbNoIRMC.Checked := cbNoObex.Checked; // IRMC depends on OBEX
        exit;
      end;
    end;
    cbAutoOutlookSync.Enabled := False;
    cbAutoOutlookSync.Checked := False;
    cbAutoSync.Enabled := False;
    cbAutoSync.Checked := False;
    cbAutoCalendar.Enabled := False;
    cbAutoCalendar.Checked := False;
    { TODO: Uncomment when those are implemented...
    cbAutoTasks.Enabled := False;
    cbAutoTasks.Checked := False;
    cbAutoNotes.Enabled := False;
    cbAutoNotes.Checked := False;
    }
  end else begin
    cbAutoOutlookSync.Enabled := True;
    cbAutoSync.Enabled := True;
    cbAutoCalendar.Enabled := True;
    { TODO: Uncomment when those are implemented...
    cbAutoTasks.Enabled := True;
    cbAutoNotes.Enabled := True;
    }
  end;
end;

procedure TfrmOptions.cbAlwaysMinimizedClick(Sender: TObject);
begin
  cbShowSplash.Enabled := not cbAlwaysMinimized.Checked;
end;

procedure TfrmOptions.cbBatterylMonitorClick(Sender: TObject);
begin
  cbIgnoreLowBattery.Enabled := cbBatterylMonitor.Checked;
  if not cbIgnoreLowBattery.Enabled then cbIgnoreLowBattery.Checked := False;
end;

procedure TfrmOptions.cbUseScriptsClick(Sender: TObject);
var
  s: string;
begin
  edScriptPath.Enabled := cbUseScripts.Checked;
  if edScriptPath.Enabled then edScriptPath.Color := clWindow
    else edScriptPath.Color := clBtnFace;
  ScriptBrowseButton.Enabled := edScriptPath.Enabled;
  lblScript.Enabled := edScriptPath.Enabled;
  if cbUseScriptingFramework.Checked and
    (Pos(ScriptingFrameworkMainFile,LowerCase(edScriptPath.Text)) = 0) then begin
    s := ExtractFilePath(Application.ExeName)+'sframework\'+ScriptingFrameworkMainFile; // do not localize
    if not FileExists(s) then begin
      MessageBeep(MB_ICONHAND);
      MessageDlgW(_('Could not find Scripting Framework installation files. Please locate them manualy!'),
        mtError, MB_OK);
      { Emulate browse for script button click, with custom filename }
      OpenDialog1.InitialDir := ExtractFileDir(Application.ExeName);
      OpenDialog1.FileName := ScriptingFrameworkMainFile;
      if OpenDialog1.Execute then
        edScriptPath.Text := OpenDialog1.FileName
      else
        cbDoNotUseScripts.Checked := True;
    end
    else
      edScriptPath.Text := s;
  end;
  if not cbUseScriptingFramework.Checked and (FCustomScript <> '') and
    (Pos(ScriptingFrameworkMainFile,LowerCase(edScriptPath.Text)) <> 0) then begin
    { restore custom script if not using scripting framework }
    edScriptPath.Text := FCustomScript;
  end;
end;

procedure TfrmOptions.lvOutlookCatsDblClick(Sender: TObject);
begin
  if btEditCat.Enabled then btEditCat.Click;
end;

{********************************************************************************
 * Options tree and 'Reset To Defaults' button
 ********************************************************************************}

procedure TfrmOptions.OptionTreeInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  ParentOptionsGroupData, OptionsGroupData: POptionsTreeItemData;
begin
  ParentOptionsGroupData := Sender.GetNodeData(ParentNode);
  OptionsGroupData := Sender.GetNodeData(Node);
  if Assigned(OptionsGroupData) then begin
    if Assigned(ParentOptionsGroupData) then
      OptionsGroupData.Data := ParentOptionsGroupData.Data.Group[Node.Index]
    else
      OptionsGroupData.Data := Options.Group[Node.Index];
    if OptionsGroupData.Data.Count > 0 then begin
      Include(InitialStates, ivsHasChildren);
      if OptionsGroupData.Data.FTab <> tabOutlook then // do not expand Outlook subtree
        Include(InitialStates, ivsExpanded);
    end;
  end;
end;

procedure TfrmOptions.OptionTreeInitChildren(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var ChildCount: Cardinal);
var
  OptionsGroupData: POptionsTreeItemData;
begin
  OptionsGroupData := Sender.GetNodeData(Node);
  if Assigned(OptionsGroupData) and Assigned(OptionsGroupData.Data) then
    ChildCount := OptionsGroupData.Data.Count
  else
    ChildCount := 0;
end;

procedure TfrmOptions.OptionTreeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
var
  OptionsGroupData: POptionsTreeItemData;
begin
  OptionsGroupData := Sender.GetNodeData(Node);
  if Assigned(OptionsGroupData) and Assigned(OptionsGroupData.Data) then
    CellText := OptionsGroupData.Data.Caption
  else
    CellText := _('Unknown');
end;

procedure TfrmOptions.OptionTreeFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Caption: String;
  Tab: TTntTabSheet;
  OptionsGroupData: POptionsTreeItemData;
begin
  Tab := nil;
  if Assigned(Node) then begin
    OptionTree.Selected[Node] := True;
    OptionsGroupData := (Sender as TBaseVirtualTree).GetNodeData(Node);
    if Assigned(OptionsGroupData) and Assigned(OptionsGroupData.Data) then begin
      Tab := OptionsGroupData.Data.Tab;
      Caption := OptionsGroupData.Data.Caption;
    end;
  end;
  lblPageCaption.Caption := Caption;
  lblPageCaption.Visible := Tab <> nil;
  Bevel1.Visible := lblPageCaption.Visible;
  OptionPages.ActivePage := Tab;
  OptionPagesChange(OptionPages);
end;

procedure TfrmOptions.btnDefaultsClick(Sender: TObject);
var
  i: Integer;
begin
  if (OptionTree.SelectedCount = 1) and
    (MessageDlgW(WideFormat(_('Are you sure you want to reset %s settings to its factory defaults?'),
    [OptionPages.ActivePage.Caption]), mtConfirmation, MB_YESNO or MB_DEFBUTTON2) = ID_YES) then begin
    if OptionPages.ActivePage = tabConnectivity then begin
      edBTPortSpin.Position := 0;
      cbBaudrate.ItemIndex := 13;
      cbRTSFlow.ItemIndex := 2;
      cbDTRFlow.ItemIndex := 2;
    end
    else
    if OptionPages.ActivePage = tabStartup then begin
      cbAlwaysMinimized.Checked := False;
      cbAlwaysMinimizedClick(nil);
      cbShowSplash.Checked := True;
      for i := 0 to gbOnConnected1.ControlCount-1 do
        if gbOnConnected1.Controls[i] is TTntCheckBox then
          (gbOnConnected1.Controls[i] as TTntCheckBox).Checked := False;
      for i := 0 to gbOnConnected2.ControlCount-1 do
        if gbOnConnected2.Controls[i] is TTntCheckBox then
          (gbOnConnected2.Controls[i] as TTntCheckBox).Checked := False;
      for i := 0 to gbOnConnecting.ControlCount-1 do
        if gbOnConnecting.Controls[i] is TTntCheckBox then
          (gbOnConnecting.Controls[i] as TTntCheckBox).Checked := False;
      cbAutoClock.Checked := True;    
      rgExplorer.ItemIndex := 0;
    end
    else
    if OptionPages.ActivePage = tabSynchronization then begin
      rbSyncPhonebook.ItemIndex := 2;
      rbSyncCalendar.ItemIndex := 2;
      rbPhoneClockSync.ItemIndex := 1;
      rbOutlookSync.ItemIndex := 2;
    end
    else
    {
    if OptionPages.ActivePage = tabBookmarks then begin
      rbBookmarks.ItemIndex := 1;
      rbBookmarksClick(nil);
    end
    else
    }
    if OptionPages.ActivePage = tabOutlook then begin
      for i := 0 to grOutlookConfirmation.ControlCount-1 do
        if grOutlookConfirmation.Controls[i] is TTntCheckBox then
          (grOutlookConfirmation.Controls[i] as TTntCheckBox).Checked := False;
      rbOutlookNewActionLinkTo.Checked := True;
    end
    else
    if OptionPages.ActivePage = tabOutlookContactFolders then begin
      SelectedOutlookContactFolders := 'DEFAULT'; // do not localize
      FOutlookNewContactsFolder := '';
      InitOutlookNewContactsFolder;
    end
    else
    if OptionPages.ActivePage = tabOBEX then begin
      cbNoIRMC.Checked := False;
      cbNoObex.Checked := False;
      cbNoObexClick(nil);
      seMaxPacketSizeSpin.Position := 1024;
    end
    else
    if OptionPages.ActivePage = tabScripting then begin
      cbUseScriptingFramework.Checked := True;
      cbUseScriptsClick(nil);
    end
    else
    if OptionPages.ActivePage = tabAppearance then begin
      rbShowProgressIf.Checked := True;
      rbProgressClick(nil);
      cbProgressLongOnly.Checked := False;
      cbProgressRestoredOnly.Checked := True;
      tbComposeSpin.Position := 255;
      tbMessageSpin.Position := 255;
      tbCallSpin.Position := 255;
      tbLogSpin.Position := 255;
    end
    else
    if OptionPages.ActivePage = tabBehaviour then begin
      chkMinButton.Checked := False;
      cbCheckOutbox.Checked := True;
      chkCallM.Checked := True;
      cbNoCallPopup.Checked := False;
      cbNoCallBaloon.Checked := False;
      chkCallMClick(nil);
      chkMsgM.Checked := True;
      chkMsgMClick(nil);
      cbNoMsgPopup.Checked := False;
      cbNoMsgBaloon.Checked := False;
      cbMsgToArchive.Checked := False;
      cbMsgFullWarning.Checked := True;
    end
    else
    if OptionPages.ActivePage = tabSMS then begin
      cbForceUCS2.Checked := False;
      cbSMSWarning.Checked := True;
      cbSMSReset.Checked := True;
      udSMSCntRst.Position := 1;
    end
    else
    if OptionPages.ActivePage = tabProximity then begin
      cbRunSS.Checked := False;
      cbProximityLock.Checked := False;
      rgProximityAway.ItemIndex := 4;
      rgProximityNear.ItemIndex := 4;
    end
    else
    if OptionPages.ActivePage = tabAdvanced then begin
      seCommTimeoutSpin.Position := 10;
      sePollingSpin.Position := 30;
      cbDiagram.Checked := True;
      cbStateMonitor.Checked := True;
      cbStateMonitorClick(nil);
      cbIgnoreLowBattery.Checked := False;
      cbBatterylMonitor.Checked := True;
      cbBatterylMonitorClick(nil);
      cbSignalMonitor.Checked := True;
      cbSilentMonitor.Checked := True;
      cbMinuteMonitor.Checked := True;
    end
    else
    if OptionPages.ActivePage = tabOutlookTaskFolders then begin
      SelectedOutlookTaskFolders := 'DEFAULT'; // do not localize
      FOutlookNewTasksFolder := '';
      InitOutlookNewTasksFolder;
    end
    else
    if OptionPages.ActivePage = tabOutlookCalendarFolders then begin
      SelectedOutlookCalendarFolders := 'DEFAULT'; // do not localize
      FOutlookNewCalendarFolder := '';
      InitOutlookNewCalendarFolder;
    end
    else
    if OptionPages.ActivePage = tabOutlookContactMappings then begin
      ResetFieldMappingsToDefault;
      tabOutlookContactMappingsShow(nil);
    end
    else
    if OptionPages.ActivePage = tabWebUpdate then begin
      rbWebUpdateStartup.Checked := True;
      edWebUpdatesURL.Text := 'http://fma.sourceforge.net/updates'; // do not localize
    end
    else
    if OptionPages.ActivePage = tabScriptEditor then begin
      rbScriptEditorBuiltin.Checked := True;
    end
    else
    if OptionPages.ActivePage = tabChat then begin
      edChatName.Text := DefaultChatNick;
      cbChatLongSMS.Checked := False;
      cbChatBoldFont.Checked := False;
    end
    else
    if OptionPages.ActivePage = tabOutlookCategories then begin
      rbOutlookAllCategories.Checked := True;
    end
    else
    if OptionPages.ActivePage = tabCalendar then begin
      cbCalWideMode.Checked := False;
      cbCalRecurrence.Checked := True;
      cbCalRecurrenceClick(nil);
      cbCalRecurrAsk.Checked := True;
    end
    else
      MessageDlgW(_('No default settings here.'), mtInformation, MB_OK);
  end;
end;

{********************************************************************************
 * OptionsPages
 ********************************************************************************}

procedure TfrmOptions.OptionPagesChange(Sender: TObject);
var
  dlg: TfrmStatusDlg;
  sel: string;
  I: Integer;
begin
  // refresh GUI first
  Update;
  if (OptionPages.ActivePage = tabConnectivity) and (BtDevices = nil) and rbUseBluetooth.Checked and not FBtNotSupported then begin
    dlg := ShowStatusDlg(_('Searching for Bluetooth devices...'),poMainFormCenter);
    try
      WaitASec(500);
      cbBTDevice.Clear;
      try
        BtDevices := LocalWBtSocket.GetConnectedDevices;
        if Assigned(BtDevices) then begin
          for I := 0 to BtDevices.Count-1 do
            cbBTDevice.Items.Add(BtDevices[I].btDeviceName);
        end
        else
          Abort;
      except
        lblConnectionHelp.Caption := _('Native Bluetooth is not supported under your system.');
        FBtNotSupported := True;
      end;
      UpdateBtCombo(FBtAddress);
    finally
      dlg.Free;
    end;
  end;
  if (OptionPages.ActivePage = tabOutlookContactFolders) and (tvOutlookContactFolders.RootNodeCount = 0) then begin
    btnDefaultNewContactDir.Enabled := False;
    dlg := ShowStatusDlg(_('Reading Outlook Folders...'), poMainFormCenter);
    try
      tabOutlookContactFolders.Update;
      sel := SelectedOutlookContactFolders;
      tvOutlookContactFolders.BeginUpdate;
      if not Assigned(OutlookNS) then
        LoadOutlookFolders;
      if Assigned(OutlookNS) then begin
        try
          tvOutlookContactFolders.NodeDataSize := SizeOf(TOutlookFolder);
          tvOutlookContactFolders.RootNodeCount := OutlookNS.Folders.Count;
        except
          OutlookNS := nil;
          if Assigned(OutlookApp) then begin
            OutlookApp.Destroy;
            OutlookApp := nil;
          end;
        end;
      end;
      SelectedOutlookContactFolders := sel;
      InitOutlookNewContactsFolder;
      tvOutlookContactFolders.EndUpdate;
    finally
      dlg.Free;
    end;
  end;
  if (OptionPages.ActivePage = tabOutlookCalendarFolders) and (tvOutlookCalendarFolders.RootNodeCount = 0) then begin
    dlg := ShowStatusDlg(_('Reading Outlook Folders...'), poMainFormCenter);
    try
      tabOutlookCalendarFolders.Update;
      sel := SelectedOutlookCalendarFolders;
      tvOutlookCalendarFolders.BeginUpdate;
      if not Assigned(OutlookNS) then
        LoadOutlookFolders;
      if Assigned(OutlookNS) then begin
        try
          tvOutlookCalendarFolders.NodeDataSize := SizeOf(TOutlookFolder);
          tvOutlookCalendarFolders.RootNodeCount := OutlookNS.Folders.Count;
        except
          OutlookNS := nil;
          if Assigned(OutlookApp) then begin
            OutlookApp.Destroy;
            OutlookApp := nil;
          end;
        end;
      end;
      SelectedOutlookCalendarFolders := sel;
      InitOutlookNewCalendarFolder;
      tvOutlookCalendarFolders.EndUpdate;
    finally
      dlg.Free;
    end;
  end;
  if (OptionPages.ActivePage = tabOutlookTaskFolders) and (tvOutlookTaskFolders.RootNodeCount = 0) then begin
    dlg := ShowStatusDlg(_('Reading Outlook Folders...'), poMainFormCenter);
    try
      tabOutlookTaskFolders.Update;
      sel := SelectedOutlookTaskFolders;
      tvOutlookTaskFolders.BeginUpdate;
      if not Assigned(OutlookNS) then
        LoadOutlookFolders;
      if Assigned(OutlookNS) then begin
        try
          tvOutlookTaskFolders.NodeDataSize := SizeOf(TOutlookFolder);
          tvOutlookTaskFolders.RootNodeCount := OutlookNS.Folders.Count;
        except
          OutlookNS := nil;
          if Assigned(OutlookApp) then begin
            OutlookApp.Destroy;
            OutlookApp := nil;
          end;
        end;
      end;
      SelectedOutlookTaskFolders := sel;
      InitOutlookNewTasksFolder;
      tvOutlookTaskFolders.EndUpdate;
    finally
      dlg.Free;
    end;
  end;
  if OptionPages.ActivePage = tabSMSDelivery then begin
    if chkMsgM.Checked and cbMsgToArchive.Checked then
      lblDeliveryStatus.Caption := _('Activated and monitoring')
    else
      lblDeliveryStatus.Caption := _('Disabled');
  end;
end;

{********************************************************************************
 * tabOutlookContactFolders
 ********************************************************************************}

procedure TfrmOptions.btnRefreshOutlookContactFoldersClick(Sender: TObject);
var
  sel, new: string;
  dlg: TfrmStatusDlg;
begin
  btnRefreshOutlookContactFolders.Enabled := False;
  btnDefaultNewContactDir.Enabled := False;
  dlg := ShowStatusDlg(_('Reading Outlook Folders...'), poMainFormCenter);
  try
    sel := SelectedOutlookContactFolders;
    new := OutlookNewContactsFolder;
    tvOutlookContactFolders.RootNodeCount := 0;
    tvOutlookContactFolders.Update;
    tvOutlookContactFolders.BeginUpdate;
    LoadOutlookFolders;
    if Assigned(OutlookNS) then begin
      try
        tvOutlookContactFolders.NodeDataSize := SizeOf(TOutlookFolder);
        tvOutlookContactFolders.RootNodeCount := OutlookNS.Folders.Count;
      except
        OutlookNS := nil;
        if Assigned(OutlookApp) then begin
          OutlookApp.Destroy;
          OutlookApp := nil;
        end;
      end;
    end;
    SelectedOutlookContactFolders := sel;
    OutlookNewContactsFolder := new;
    tvOutlookContactFolders.EndUpdate;
  finally
    dlg.Free;
  end;
  btnRefreshOutlookContactFolders.Enabled := true;
end;

{********************************************************************************
 * tabOutlookCalendarFolders
 ********************************************************************************}

procedure TfrmOptions.btnRefreshOutlookCalendarFoldersClick(Sender: TObject);
var
  sel, new: string;
  dlg: TfrmStatusDlg;
begin
  btnRefreshOutlookCalendarFolders.Enabled := false;
  dlg := ShowStatusDlg(_('Reading Outlook Folders...'), poMainFormCenter);
  try
    sel := SelectedOutlookCalendarFolders;
    new := OutlookNewCalendarFolder;
    tvOutlookCalendarFolders.RootNodeCount := 0;
    tvOutlookCalendarFolders.Update;
    tvOutlookCalendarFolders.BeginUpdate;
    LoadOutlookFolders;
    if Assigned(OutlookNS) then begin
      try
        tvOutlookCalendarFolders.NodeDataSize := SizeOf(TOutlookFolder);
        tvOutlookCalendarFolders.RootNodeCount := OutlookNS.Folders.Count;
      except
        OutlookNS := nil;
        if Assigned(OutlookApp) then begin
          OutlookApp.Destroy;
          OutlookApp := nil;
        end;
      end;
    end;
    SelectedOutlookCalendarFolders := sel;
    OutlookNewCalendarFolder := new;
    tvOutlookCalendarFolders.EndUpdate;
  finally
    dlg.Free;
  end;
  btnRefreshOutlookCalendarFolders.Enabled := true;
end;

{********************************************************************************
 * tabOutlookTaskFolders
 ********************************************************************************}

procedure TfrmOptions.btnRefreshOutlookTaskFoldersClick(Sender: TObject);
var
  sel, new: string;
  dlg: TfrmStatusDlg;
begin
  btnRefreshOutlookTaskFolders.Enabled := false;
  dlg := ShowStatusDlg(_('Reading Outlook Folders...'), poMainFormCenter);
  try
    sel := SelectedOutlookTaskFolders;
    new := OutlookNewTasksFolder;
    tvOutlookTaskFolders.RootNodeCount := 0;
    tvOutlookTaskFolders.Update;
    tvOutlookTaskFolders.BeginUpdate;
    LoadOutlookFolders;
    if Assigned(OutlookNS) then begin
      try
        tvOutlookTaskFolders.NodeDataSize := SizeOf(TOutlookFolder);
        tvOutlookTaskFolders.RootNodeCount := OutlookNS.Folders.Count;
      except
        OutlookNS := nil;
        if Assigned(OutlookApp) then begin
          OutlookApp.Destroy;
          OutlookApp := nil;
        end;
      end;
    end;
    SelectedOutlookTaskFolders := sel;
    OutlookNewTasksFolder := new;
    tvOutlookTaskFolders.EndUpdate;
  finally
    dlg.Free;
  end;
  btnRefreshOutlookTaskFolders.Enabled := true;
end;

{********************************************************************************
 * Outlook folder trees - common
 ********************************************************************************}

procedure TfrmOptions.tvOutlookFoldersFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
  var
    OutlookFolder: POutlookFolder;
begin
  OutlookFolder := Sender.GetNodeData(Node);
  if Assigned(OutlookFolder) then
    Finalize(OutlookFolder^);
end;

procedure TfrmOptions.tvOutlookFoldersGetImageIndex(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
  Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
  var
    OutlookFolder, ParentOutlookFolder: POutlookFolder;
begin
  OutlookFolder := Sender.GetNodeData(Node);
  ParentOutlookFolder := Sender.GetNodeData(Node.Parent);
  if Assigned(OutlookFolder) and Assigned(OutlookFolder.Folder) and Assigned(ParentOutlookFolder) then
    case OutlookFolder.Folder.DefaultItemType of
      olMailItem:        ImageIndex := 1;
      olAppointmentItem: ImageIndex := 2;
      olContactItem:     ImageIndex := 3;
      olTaskItem:        ImageIndex := 4;
      olJournalItem:     ImageIndex := 5;
      olNoteItem:        ImageIndex := 6;
      olPostItem:        ImageIndex := 7;
    end
  else if not Assigned(ParentOutlookFolder) then
    ImageIndex := 9 // Account node, it might contain folders 
  else
    ImageIndex := -1;
end;

procedure TfrmOptions.tvOutlookFoldersGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
  var
    OutlookFolder: POutlookFolder;
begin
  OutlookFolder := Sender.GetNodeData(Node);
  if Assigned(OutlookFolder) and Assigned(OutlookFolder.Folder) then
    CellText := OutlookFolder.Folder.Name
  else
    CellText := 'Unknown';
end;

procedure TfrmOptions.tvOutlookFoldersPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
  var
    OutlookFolder: POutlookFolder;
begin
  OutlookFolder := Sender.GetNodeData(Node);
  if Assigned(OutlookFolder) and OutlookFolder.IsTarget then
    TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsBold];
end;

procedure TfrmOptions.tvOutlookFoldersInitNode(
  Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  OutlookFolder, ParentOutlookFolder: POutlookFolder;
begin
  OutlookFolder := Sender.GetNodeData(Node);
  ParentOutlookFolder := Sender.GetNodeData(ParentNode);
  if Assigned(OutlookFolder) then begin
    try
    if Assigned(ParentOutlookFolder) then begin
      OutlookFolder.Folder := ParentOutlookFolder.Folder.Folders.Item(Node.Index + 1);
      Node.CheckType := ctTriStateCheckBox;
    end else
      OutlookFolder.Folder := OutlookNS.Folders.Item(Node.Index + 1);
    if Assigned(OutlookFolder.Folder) and (OutlookFolder.Folder.Folders.Count > 0) then begin
      Include(InitialStates, ivsHasChildren);
    end;
    except
      OutlookFolder.Folder := nil;
      OutlookFolder.IsTarget := False;
    end;
  end;
end;

procedure TfrmOptions.tvOutlookFoldersInitChildren(
  Sender: TBaseVirtualTree; Node: PVirtualNode; var ChildCount: Cardinal);
  var
    OutlookFolder: POutlookFolder;
begin
  OutlookFolder := Sender.GetNodeData(Node);
  if Assigned(OutlookFolder) and Assigned(OutlookFolder.Folder) then
    ChildCount := OutlookFolder.Folder.Folders.Count
  else
    ChildCount := 0;
end;

{********************************************************************************
 * Outlook folder trees - Contacts
 ********************************************************************************}

procedure TfrmOptions.tvOutlookContactFoldersChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
  var
    OutlookFolder: POutlookFolder;
begin
  OutlookFolder := tvOutlookContactFolders.GetNodeData(Node);
  if (Node.CheckState = csCheckedNormal) and Assigned(OutlookFolder) and (FOutlookNewContactsNode = nil) then begin
    OutlookFolder.IsTarget := True;
    FOutlookNewContactsNode := Node;
    Sender.InvalidateNode(Node);
  end
  else if (Node.CheckState = csUnCheckedNormal) and Assigned(OutlookFolder) and OutlookFolder.IsTarget then begin
    OutlookFolder.IsTarget := False;
    FOutlookNewContactsNode := nil;
    Sender.InvalidateNode(Node);
    Sender.IterateSubtree(nil, GetDefaultOutlookNewContactsFolder, nil, [], True);
  end;
end;

{********************************************************************************
 * Outlook folder trees - Calendar
 ********************************************************************************}

procedure TfrmOptions.tvOutlookCalendarFoldersChecked(
  Sender: TBaseVirtualTree; Node: PVirtualNode);
  var
    OutlookFolder: POutlookFolder;
begin
  OutlookFolder := tvOutlookCalendarFolders.GetNodeData(Node);
  if (Node.CheckState = csCheckedNormal) and Assigned(OutlookFolder) and (FOutlookNewTasksNode = nil) then begin
    OutlookFolder.IsTarget := True;
    FOutlookNewCalendarNode := Node;
    Sender.InvalidateNode(Node);
  end
  else if (Node.CheckState = csUnCheckedNormal) and Assigned(OutlookFolder) and OutlookFolder.IsTarget then begin
    OutlookFolder.IsTarget := False;
    FOutlookNewCalendarNode := nil;
    Sender.InvalidateNode(Node);
    Sender.IterateSubtree(nil, GetDefaultOutlookNewCalendarFolder, nil, [], True);
  end;
end;

{********************************************************************************
 * Outlook folder trees - Tasks
 ********************************************************************************}

procedure TfrmOptions.tvOutlookTaskFoldersChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
  var
    OutlookFolder: POutlookFolder;
begin
  OutlookFolder := tvOutlookTaskFolders.GetNodeData(Node);
  if (Node.CheckState = csCheckedNormal) and Assigned(OutlookFolder) and (FOutlookNewTasksNode = nil) then begin
    OutlookFolder.IsTarget := True;
    FOutlookNewTasksNode := Node;
    Sender.InvalidateNode(Node);
  end
  else if (Node.CheckState = csUnCheckedNormal) and Assigned(OutlookFolder) and OutlookFolder.IsTarget then begin
    OutlookFolder.IsTarget := False;
    FOutlookNewTasksNode := nil;
    Sender.InvalidateNode(Node);
    Sender.IterateSubtree(nil, GetDefaultOutlookNewTasksFolder, nil, [], True);
  end;
end;

{********************************************************************************
 * Popup menu functions - Contacts
 ********************************************************************************}

procedure TfrmOptions.mniNewContactsClick(Sender: TObject);
  var
    OutlookFolder: POutlookFolder;
begin
  if Assigned(FPopupNode) and (FPopupNode <> FOutlookNewContactsNode) then begin
    OutlookFolder := tvOutlookContactFolders.GetNodeData(FPopupNode);
    if Assigned(OutlookFolder) then begin
      OutlookFolder.IsTarget := True;
      // Reset old
      if Assigned(FOutlookNewContactsNode) then begin
        OutlookFolder := tvOutlookContactFolders.GetNodeData(FOutlookNewContactsNode);
        if Assigned(OutlookFolder) then begin
          OutlookFolder.IsTarget := False;
          tvOutlookContactFolders.InvalidateNode(FOutlookNewContactsNode);
        end;
      end;
      FOutlookNewContactsNode := FPopupNode;
    end;
  end;
end;

{********************************************************************************
 * Popup menu functions - Calendar
 ********************************************************************************}

procedure TfrmOptions.pmuOutlookCalendarFolderPopup(Sender: TObject);
  var
    Pos: TPoint;
begin
  Pos := tvOutlookCalendarFolders.ScreenToClient(Mouse.CursorPos);
  FPopupNode := tvOutlookCalendarFolders.GetNodeAt(Pos.X, Pos.Y);
  mniNewCalendar.Enabled := Assigned(FPopupNode) and (FPopupNode.CheckState = csCheckedNormal);
end;

procedure TfrmOptions.mniNewCalendarClick(Sender: TObject);
  var
    OutlookFolder: POutlookFolder;
begin
  if Assigned(FPopupNode) and (FPopupNode <> FOutlookNewCalendarNode) then begin
    OutlookFolder := tvOutlookCalendarFolders.GetNodeData(FPopupNode);
    if Assigned(OutlookFolder) then begin
      OutlookFolder.IsTarget := True;
      // Reset old
      if Assigned(FOutlookNewCalendarNode) then begin
        OutlookFolder := tvOutlookCalendarFolders.GetNodeData(FOutlookNewCalendarNode);
        if Assigned(OutlookFolder) then begin
          OutlookFolder.IsTarget := False;
          tvOutlookCalendarFolders.InvalidateNode(FOutlookNewCalendarNode);
        end;
      end;
      FOutlookNewCalendarNode := FPopupNode;
    end;
  end;
end;

{********************************************************************************
 * Popup menu functions - Tasks
 ********************************************************************************}

procedure TfrmOptions.pmuOutlookTasksFolderPopup(Sender: TObject);
  var
    Pos: TPoint;
begin
  Pos := tvOutlookTaskFolders.ScreenToClient(Mouse.CursorPos);
  FPopupNode := tvOutlookTaskFolders.GetNodeAt(Pos.X, Pos.Y);
  mniNewTasks.Enabled := Assigned(FPopupNode) and (FPopupNode.CheckState = csCheckedNormal);
end;

procedure TfrmOptions.mniNewTasksClick(Sender: TObject);
  var
    OutlookFolder: POutlookFolder;
begin
  if Assigned(FPopupNode) and (FPopupNode <> FOutlookNewTasksNode) then begin
    OutlookFolder := tvOutlookTaskFolders.GetNodeData(FPopupNode);
    if Assigned(OutlookFolder) then begin
      OutlookFolder.IsTarget := True;
      // Reset old
      if Assigned(FOutlookNewTasksNode) then begin
        OutlookFolder := tvOutlookTaskFolders.GetNodeData(FOutlookNewTasksNode);
        if Assigned(OutlookFolder) then begin
          OutlookFolder.IsTarget := False;
          tvOutlookTaskFolders.InvalidateNode(FOutlookNewTasksNode);
        end;
      end;
      FOutlookNewTasksNode := FPopupNode;
    end;
  end;
end;

{********************************************************************************
 * Private functions
 ********************************************************************************}

procedure TfrmOptions.LoadOutlookFolders;
begin
  tvOutlookContactFolders.RootNodeCount := 0;
  tvOutlookContactFolders.RootNodeCount := 0;
  tvOutlookTaskFolders.RootNodeCount := 0;
  if not Assigned(OutlookApp) then begin
    try
      OutlookApp := TOutlookApplication.Create(nil);
      OutlookNS := OutlookApp.GetNamespace('MAPI'); // do not localize
    except
      OutlookNS := nil;
      if Assigned(OutlookApp) then begin
        OutlookApp.Destroy;
        OutlookApp := nil;
      end;
    end;
  end;
end;

{********************************************************************************
 * Properties handling - BtAddress
 ********************************************************************************}

procedure TfrmOptions.SetBtAddress(const Value: String);
begin
  if Value <> edBTAddress.Text then begin
    UpdateBtCombo(Value);
    UpdateBtAddress(Value);
  end;
end;

function TfrmOptions.GetBtAddress: String;
begin
  if BtDevice = '' then 
    Result := StringReplace(edBTAddress.Text,':','',[rfReplaceAll])
  else
    Result := FBtAddress;
end;

{********************************************************************************
 * Properties handling - ConnectionType
 ********************************************************************************}

function TfrmOptions.Get_ConnectionType: Integer;
begin
  if rbUseIRDA.Checked then
    Result := 1
  else if rbUseSerial.Checked then
    Result := 2
  else
    Result := 0;
end;

procedure TfrmOptions.Set_ConnectionType(value: Integer);
begin
  case value of
    1: rbUseSerialClick(rbUseIRDA);
    2: rbUseSerialClick(rbUseSerial);
  else rbUseSerialClick(rbUseBluetooth);  
  end;
end;

{********************************************************************************
 * Properties handling - OutlookCategories
 ********************************************************************************}

function TfrmOptions.Get_OutlookCategories: WideString;
var
  i: integer;
begin
  Result := '';
  if not rbOutlookAllCategories.Checked then begin
    for i := 0 to lvOutlookCats.Items.Count-1 do begin
      if Result <> '' then
        Result := Result + ';';
      Result := Result + WideQuoteStr(lvOutlookCats.Items[i].Caption);
    end;
  end;  
end;

procedure TfrmOptions.Set_OutlookCategories(const Value: WideString);
var
  w: WideString;
begin
  w := Value;
  lvOutlookCats.Items.Clear;
  while w <> '' do begin
    with lvOutlookCats.Items.Add do begin
      Caption := GetFirstToken(w, ';');
      ImageIndex := 0;
    end;
  end;
  if lvOutlookCats.Items.Count = 0 then rbOutlookAllCategories.Checked := True
    else rbOutlookCustomCategories.Checked := True;
  cbOutlookCategoriesClick(nil);
end;

{********************************************************************************
 * Properties handling - SelectedOutlookContactFolders
 ********************************************************************************}

function TfrmOptions.Get_SelectedOutlookContactFolders: String;
begin
  if tvOutlookContactFolders.RootNodeCount <> 0 then begin
    FSelectedOutlookContactFolders.Clear;
    tvOutlookContactFolders.IterateSubtree(nil, SerializeSelectedOutlookFolder, FSelectedOutlookContactFolders, [], True);
  end;
  Result := FSelectedOutlookContactFolders.DelimitedText;
end;

procedure TfrmOptions.Set_SelectedOutlookContactFolders(const Value: String);
var
  Folder: MAPIFolder;
begin
  FSelectedOutlookContactFolders.DelimitedText := Value;
  if tvOutlookContactFolders.RootNodeCount <> 0 then begin
    if (FSelectedOutlookContactFolders.DelimitedText = 'DEFAULT') and Assigned(OutlookNS) then begin // do not localize
      Folder := OutlookNS.GetDefaultFolder(olFolderContacts);
      if Assigned(Folder) then
        FSelectedOutlookContactFolders.DelimitedText := Folder.EntryID;
    end;
    tvOutlookContactFolders.IterateSubtree(nil, DeSerializeSelectedOutlookFolder, FSelectedOutlookContactFolders, [], True);
  end;
end;

{********************************************************************************
 * Properties handling - SelectedOutlookCalendarFolders
 ********************************************************************************}

function TfrmOptions.Get_SelectedOutlookCalendarFolders: String;
begin
  if tvOutlookCalendarFolders.RootNodeCount <> 0 then begin
    FSelectedOutlookCalendarFolders.Clear;
    tvOutlookCalendarFolders.IterateSubtree(nil, SerializeSelectedOutlookFolder, FSelectedOutlookCalendarFolders, [], True);
  end;
  Result := FSelectedOutlookCalendarFolders.DelimitedText;
end;

procedure TfrmOptions.Set_SelectedOutlookCalendarFolders(const Value: String);
  var
    Folder: MAPIFolder;
begin
  FSelectedOutlookCalendarFolders.DelimitedText := Value;
  if tvOutlookCalendarFolders.RootNodeCount <> 0 then begin
    if (FSelectedOutlookCalendarFolders.DelimitedText = 'DEFAULT') and Assigned(OutlookNS) then begin // do not localize
      Folder := OutlookNS.GetDefaultFolder(olFolderCalendar);
      if Assigned(Folder) then
        FSelectedOutlookCalendarFolders.DelimitedText := Folder.EntryID;
    end;
    tvOutlookCalendarFolders.IterateSubtree(nil, DeSerializeSelectedOutlookFolder, FSelectedOutlookCalendarFolders, [], True);
  end;
end;

{********************************************************************************
 * Properties handling - SelectedOutlookTaskFolders
 ********************************************************************************}

function TfrmOptions.Get_SelectedOutlookTaskFolders: String;
begin
  if tvOutlookTaskFolders.RootNodeCount <> 0 then begin
    FSelectedOutlookTaskFolders.Clear;
    tvOutlookTaskFolders.IterateSubtree(nil, SerializeSelectedOutlookFolder, FSelectedOutlookTaskFolders, [], True);
  end;
  Result := FSelectedOutlookTaskFolders.DelimitedText;
end;

procedure TfrmOptions.Set_SelectedOutlookTaskFolders(const Value: String);
  var
    Folder: MAPIFolder;
begin
  FSelectedOutlookTaskFolders.DelimitedText := Value;
  if tvOutlookTaskFolders.RootNodeCount <> 0 then begin
    if (FSelectedOutlookTaskFolders.DelimitedText = 'DEFAULT') and Assigned(OutlookNS) then begin // do not localize
      Folder := OutlookNS.GetDefaultFolder(olFolderTasks);
      if Assigned(Folder) then
        FSelectedOutlookTaskFolders.DelimitedText := Folder.EntryID;
    end;
    tvOutlookTaskFolders.IterateSubtree(nil, DeSerializeSelectedOutlookFolder, FSelectedOutlookTaskFolders, [], True);
  end;
end;

{********************************************************************************
 * Properties handling - SelectedOutlookFolders serialize/deserialize
 ********************************************************************************}

procedure TfrmOptions.SerializeSelectedOutlookFolder(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
  var
    folders: TStringList;
    OutlookFolder: POutlookFolder;
begin
  if Node.CheckState = csCheckedNormal then begin
    folders := TStringList(Data);
    OutlookFolder := Sender.GetNodeData(Node);
    if Assigned(OutlookFolder) and Assigned(OutlookFolder.Folder) then
      folders.Add(OutlookFolder.Folder.EntryID);
  end;
end;

procedure TfrmOptions.DeSerializeSelectedOutlookFolder(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
  var
    folders: TStringList;
    OutlookFolder: POutlookFolder;
begin
  OutlookFolder := Sender.GetNodeData(Node);
  if Assigned(OutlookFolder) and Assigned(OutlookFolder.Folder) then begin
    folders := TStringList(Data);
    if folders.IndexOf(OutlookFolder.Folder.EntryID) <> -1 then begin
      Sender.CheckState[Node] := csCheckedNormal;
      Sender.VisiblePath[Node] := True;
    end
    else
      Sender.CheckState[Node] := csUnCheckedNormal;
  end;
end;

{********************************************************************************
 * Properties handling - OutlookNewContactsFolders
 ********************************************************************************}

function TfrmOptions.Get_OutlookNewContactsFolder: String;
  var
    OutlookFolder: POutlookFolder;
begin
  if Assigned(FOutlookNewContactsNode) then begin
    OutlookFolder := tvOutlookContactFolders.GetNodeData(FOutlookNewContactsNode);
    if Assigned(OutlookFolder) then
      Result := OutlookFolder.Folder.EntryID;
  end;
end;

procedure TfrmOptions.Set_OutlookNewContactsFolder(const Value: String);
begin
  FOutlookNewContactsFolder := Value;
  InitOutlookNewContactsFolder;
end;

procedure TfrmOptions.InitOutlookNewContactsFolder;
begin
  FOutlookNewContactsNode := nil;
  tvOutlookContactFolders.IterateSubtree(nil, DeSerializeOutlookNewContactsFolder, nil, [], True);
  // If no folder selected, pick a default one
  if not Assigned(FOutlookNewContactsNode) then
    tvOutlookContactFolders.IterateSubtree(nil, GetDefaultOutlookNewContactsFolder, nil, [], True);
end;

procedure TfrmOptions.GetDefaultOutlookNewContactsFolder(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer;
  var Abort: Boolean);
  var
    OutlookFolder: POutlookFolder;
begin
  OutlookFolder := tvOutlookContactFolders.GetNodeData(Node);
  if (Node.CheckState = csCheckedNormal) and Assigned(OutlookFolder) and Assigned(OutlookFolder.Folder) then begin
    FOutlookNewContactsFolder := OutlookFolder.Folder.EntryID;
    OutlookFolder.IsTarget := True;
    FOutlookNewContactsNode := Node;
    Sender.InvalidateNode(Node);
    Abort := True;

    Sender.VisiblePath[Node] := True;
  end;
end;

procedure TfrmOptions.DeSerializeOutlookNewContactsFolder(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer;
  var Abort: Boolean);
  var
    OutlookFolder: POutlookFolder;
begin
  OutlookFolder := tvOutlookContactFolders.GetNodeData(Node);
  if Assigned(OutlookFolder) and Assigned(OutlookFolder.Folder) then begin
    OutlookFolder.IsTarget := OutlookFolder.Folder.EntryID = FOutlookNewContactsFolder;
    if OutlookFolder.IsTarget then begin
      FOutlookNewContactsNode := Node;

      Sender.VisiblePath[Node] := True;
    end;
  end;
end;

{********************************************************************************
 * Properties handling - OutlookNewCalendarFolders
 ********************************************************************************}

function TfrmOptions.Get_OutlookNewCalendarFolder: String;
  var
    OutlookFolder: POutlookFolder;
begin
  if Assigned(FOutlookNewCalendarNode) then begin
    OutlookFolder := tvOutlookCalendarFolders.GetNodeData(FOutlookNewCalendarNode);
    if Assigned(OutlookFolder) then
      Result := OutlookFolder.Folder.EntryID;
  end;
end;

procedure TfrmOptions.Set_OutlookNewCalendarFolder(const Value: String);
begin
  FOutlookNewCalendarFolder := Value;
  InitOutlookNewCalendarFolder;
end;

procedure TfrmOptions.InitOutlookNewCalendarFolder;
begin
  FOutlookNewCalendarNode := nil;
  tvOutlookCalendarFolders.IterateSubtree(nil, DeSerializeOutlookNewCalendarFolder, nil, [], True);
  // If no folder selected, pick a default one
  if not Assigned(FOutlookNewCalendarNode) then
    tvOutlookCalendarFolders.IterateSubtree(nil, GetDefaultOutlookNewCalendarFolder, nil, [], True);
end;

procedure TfrmOptions.GetDefaultOutlookNewCalendarFolder(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer;
  var Abort: Boolean);
  var
    OutlookFolder: POutlookFolder;
begin
  OutlookFolder := tvOutlookCalendarFolders.GetNodeData(Node);
  if (Node.CheckState = csCheckedNormal) and Assigned(OutlookFolder) and Assigned(OutlookFolder.Folder) then begin
    FOutlookNewCalendarFolder := OutlookFolder.Folder.EntryID;
    OutlookFolder.IsTarget := True;
    FOutlookNewCalendarNode := Node;
    Sender.InvalidateNode(Node);
    Abort := True;
  end;
end;

procedure TfrmOptions.DeSerializeOutlookNewCalendarFolder(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer;
  var Abort: Boolean);
  var
    OutlookFolder: POutlookFolder;
begin
  OutlookFolder := tvOutlookCalendarFolders.GetNodeData(Node);
  if Assigned(OutlookFolder) and Assigned(OutlookFolder.Folder) then begin
    OutlookFolder.IsTarget := OutlookFolder.Folder.EntryID = FOutlookNewCalendarFolder;
    if OutlookFolder.IsTarget then
      FOutlookNewCalendarNode := Node;
  end;
end;

{********************************************************************************
 * Properties handling - OutlookNewTasksFolders
 ********************************************************************************}

function TfrmOptions.Get_OutlookNewTasksFolder: String;
  var
    OutlookFolder: POutlookFolder;
begin
  if Assigned(FOutlookNewTasksNode) then begin
    OutlookFolder := tvOutlookTaskFolders.GetNodeData(FOutlookNewTasksNode);
    if Assigned(OutlookFolder) then
      Result := OutlookFolder.Folder.EntryID;
  end;
end;

procedure TfrmOptions.Set_OutlookNewTasksFolder(const Value: String);
begin
  FOutlookNewTasksFolder := Value;
  InitOutlookNewTasksFolder;
end;

procedure TfrmOptions.InitOutlookNewTasksFolder;
begin
  FOutlookNewTasksNode := nil;
  tvOutlookTaskFolders.IterateSubtree(nil, DeSerializeOutlookNewTasksFolder, nil, [], True);
  // If no folder selected, pick a default one
  if not Assigned(FOutlookNewTasksNode) then
    tvOutlookTaskFolders.IterateSubtree(nil, GetDefaultOutlookNewTasksFolder, nil, [], True);
end;

procedure TfrmOptions.GetDefaultOutlookNewTasksFolder(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer;
  var Abort: Boolean);
  var
    OutlookFolder: POutlookFolder;
begin
  OutlookFolder := tvOutlookTaskFolders.GetNodeData(Node);
  if (Node.CheckState = csCheckedNormal) and Assigned(OutlookFolder) and Assigned(OutlookFolder.Folder) then begin
    FOutlookNewTasksFolder := OutlookFolder.Folder.EntryID;
    OutlookFolder.IsTarget := True;
    FOutlookNewTasksNode := Node;
    Sender.InvalidateNode(Node);
    Abort := True;
  end;
end;

procedure TfrmOptions.DeSerializeOutlookNewTasksFolder(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer;
  var Abort: Boolean);
  var
    OutlookFolder: POutlookFolder;
begin
  OutlookFolder := tvOutlookTaskFolders.GetNodeData(Node);
  if Assigned(OutlookFolder) and Assigned(OutlookFolder.Folder) then begin
    OutlookFolder.IsTarget := OutlookFolder.Folder.EntryID = FOutlookNewTasksFolder;
    if OutlookFolder.IsTarget then
      FOutlookNewTasksNode := Node;
  end;
end;

{********************************************************************************
 *
 ********************************************************************************}

procedure TfrmOptions.ComboBoxLangDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  R: TRect;
  S, L: WideString;
  Flags: Integer;
begin
  with TTntComboBox(Control).Canvas do
    begin
      FillRect(Rect);
      if Index >= 0 then
        begin
          Flags := Control.DrawTextBiDiModeFlags(DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX);
          if not Control.UseRightToLeftAlignment then
            begin
              R := Classes.Rect(Rect.Left+2, Rect.Top+1, Rect.Left+23+2, Rect.Bottom-1);
              Inc(Rect.Left, 23+2+2+2);
            end
          else
            begin
              R := Classes.Rect(Rect.Right-23-2, Rect.Top+1, Rect.Right-2, Rect.Bottom-1);
              Dec(Rect.Right, 23+2+2+2);
            end;
          L := TTntComboBox(Control).Items[Index];
          if Index = 0 then
            begin
              StretchDraw(R, ImageAutoLang.Picture.Bitmap);
              S := _('Auto detect');
            end
          else
            begin
              StretchDraw(R, TBitmap(TTntComboBox(Control).Items.Objects[Index]));
              S := gghGetLocalizedLanguageName(L, TTntComboBox(Control).Items);
              {S := dgettext('languagecodes', L); // do not localize
              if WideSameText(S, L) then
                begin
                  S1 := L;
                  S2 := '';
                  maxLen := 0;
                  for i := 1 to TTntComboBox(Control).Items.Count-1 do
                    if (i<>Index) and
                      WideSameText(Copy(L,1,Length(TTntComboBox(Control).Items[i])),TTntComboBox(Control).Items[i]) and
                      (Length(TTntComboBox(Control).Items[i])>MaxLen) then
                      begin
                        MaxLen := Length(TTntComboBox(Control).Items[i]);
                        S1 := Copy(L,1,MaxLen);
                        S2 := Copy(L,MaxLen+1,MaxInt);
                      end;
                  if WideSameText(Copy(S2,1,1), '_') then Delete(S2,1,1);
                  if WideSameText(Copy(S1,Length(S1),1), '_') then Delete(S1,Length(S1),1);
                  S2 := ' ' + S2;
                  S := dgettext('languagecodes', S1); // do not localize
                  if WideSameText(S, S1) then
                    S := dgettext('languagecodes', Copy(S1,1,2)); // do not localize
                end
              else
                S2 := '';
              S1 := dgettext('languages', S); // do not localize
              if WideSameText(S, S1) then
                S := S1 + S2
              else
                S := S1 + S2 + ' [' + S + ']';}
            end;
          if WideSameText(L,GetCurrentLanguage) or
            (WideSameText(L,Copy(GetCurrentLanguage,1,2)) and (TTntComboBox(Control).Items.IndexOf(GetCurrentLanguage) < 0)) then
            begin
              if Form1.FormStorage1.StoredValue['LANG']='' then // do not localize
                S := S + _('[active, auto detected]')
              else
                S := S + _('[active]');
            end;
          Tnt_DrawTextW(Handle, PWideChar(S), Length(S), Rect, Flags);
        end;
    end;
end;

procedure TfrmOptions.ComboBoxLangChange(Sender: TObject);
begin
  UILangChanged := True;
  NewUILang := ComboBoxLang.Text;
  btnTestLanguage.Enabled := True;
end;

procedure TfrmOptions.btnTestLanguageClick(Sender: TObject);
var
  OldLanguage: string;
  S: WideString;
begin
  OldLanguage := GetCurrentLanguage;
  UseLanguage(NewUILang);
  S := _('This is English language.');
  UseLanguage(OldLanguage);
  ShowMessageW(S);
end;

procedure TfrmOptions.cbAutoBookmarksClick(Sender: TObject);
begin
  if cbAutoBookmarks.Checked then begin
    if Visible then begin
      MessageBeep(MB_ICONASTERISK);
      MessageDlgW(_('Bookmark synchronization is not implemented yet!'),
        mtInformation, MB_OK);
    end;
    cbAutoBookmarks.Checked := False;
  end;
end;

procedure TfrmOptions.cbBTDeviceSelect(Sender: TObject);
begin
  FBtAddress := IntToHex(BtDevices[cbBTDevice.ItemIndex].btDeviceAddr, 12);
  FBtDevice := BtDevices[cbBTDevice.ItemIndex].btDeviceName;
  UpdateBtAddress(FBtAddress);
end;

procedure TfrmOptions.UpdateBtCombo(Address: String);
  var
    I: Integer;
begin
  FBtAddress := Address;
  FBtDevice := '';
  if Assigned(BtDevices) then begin
    for I := 0 to BtDevices.Count-1 do begin
      if IntToHex(BtDevices[I].btDeviceAddr, 12) = FBtAddress then
      begin
        cbBTDevice.ItemIndex := I;
        FBtDevice := BtDevices[I].btDeviceName;
        Break;
      end;
    end;
  end;
  if FBtDevice = '' then FBtAddress := '';
end;

procedure TfrmOptions.LocalComPortRxChar(Sender: TObject; Count: Integer);
var
  c: char;
  i: Integer;
  buffer: String;
  PStr: PChar;
begin
  if rbUseBluetooth.Checked then begin
    SetLength(buffer, 2048);
    SetLength(buffer, LocalWBtSocket.Receive(@buffer[1], 2048));
  end
  else if rbUseIRDA.Checked then begin
    SetLength(buffer, 2048);
    SetLength(buffer, LocalWIrSocket.Receive(@buffer[1], 2048));
  end
  else begin
    SetLength(buffer, Count);
    LocalComPort.ReadStr(buffer, Count);
  end;

  if ThreadSafe.DoCharConvertion then
    buffer := GSMDecode7Bit(buffer);

  { process received data }
  for i := 1 to length(buffer) do begin
    c := buffer[i];
    //if ThreadSafe.DoCharConvertion then c := ConvertCharSet(c);
    case c of
      #00:;
      #10:;
      #13:
        begin
          if length(trim(FMessageBuf)) > 0 then
          begin
            PStr := StrNew(PChar(FMessageBuf));
            PostMessage(Handle, WM_HANDLEMESSAGE, Integer(PStr), 0);
          end;
          FMessageBuf := '';
        end;
      else begin
        FMessageBuf := FMessageBuf + c;
      end;
    end;
    if (FMessageBuf = 'OK') and (FMessageBuf <> '') then begin
      PStr := StrNew(PChar(FMessageBuf));
      PostMessage(Handle, WM_HANDLEMESSAGE, Integer(PStr), 0);
      FMessageBuf := '';
    end;
  end;
end;

procedure TfrmOptions.HandleMessage(var Msg: TOptionsHandleMessage);
var
  s: string;
begin
  s := Msg.Message;
  StrDispose(Msg.Message);
  FReceived := (CompareText('OK',s) = 0) or (CompareText('ERROR',s) = 0);
  FRxBuffer.Add(s);
  inherited;
end;

procedure TfrmOptions.TxAndWait(Data: string);
var
  FMSec: cardinal;
begin
  FReceived := False;
  FMessageBuf := '';
  FRxBuffer.Clear;

  if ThreadSafe.DoCharConvertion then
    Data := GSMEncode7Bit(Data);

  { Send command }
  if rbUseBluetooth.Checked then LocalWBtSocket.SendStr(Data + #13) // Blutooth
  else if rbUseIRDA.Checked then LocalWIrSocket.SendStr(Data + #13) // Infrared
       else LocalComPort.WriteStr(Data + #13); // Serial

  { Set timeout, max 5 seconds }
  FMSec := ThreadSafe.InactivityTimeout;
  if FMSec > 5000 then FMSec := 5000;
  FMSec := GetTickCount + FMSec;

  { Wait for response }
  while not FReceived and not Application.Terminated do begin
    WaitASec(10,True);
    if GetTickCount > FMSec then
      raise EInOutError.Create('Timeout'); // do not localize
  end;
  if FReceived and (CompareText('ERROR',FRxBuffer[0]) = 0) then // do not localize
    raise EInOutError.Create('AT Error'); // do not localize
end;

procedure TfrmOptions.OnSocketDataAvailable(Sender: TObject; Error: Word);
begin
  if Error = 0 then LocalComPortRxChar(nil, 0);
end;

procedure TfrmOptions.TntFormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := btnLookupDevice.Enabled and btnBTSearch.Enabled;
end;

procedure TfrmOptions.ExecuteClick(Sender: TObject);
begin
  ShellExecute(Handle,'open',PChar((Sender as TControl).Hint),'','',SW_SHOWNORMAL); // do not localize
end;

procedure TfrmOptions.LoadFieldMappings;
var FieldMapper: TContactFieldMapper;
begin
  FieldMapper := TOutlookContactFieldMapper.Create;
  try
    lbxFieldsFMA.Items.Assign(FieldMapper.StandardFields);
    lbxFieldsOutlook.Items.Assign(FieldMapper.Fields);
  finally
    FieldMapper.Free;
  end;

  ResetFieldMappingsToDefault;
end;

procedure TfrmOptions.ResetFieldMappingsToDefault;
var FieldMapper: TContactFieldMapper;
begin
  FieldMapper := TOutlookContactFieldMapper.Create;
  try
    FOutlookFieldMappings.Assign(FieldMapper.MappedFields);
  finally
    FieldMapper.Free;
  end;
end;

procedure TfrmOptions.SetOutlookFieldMappings(const Value: String);
begin
  if Value = '' then
    ResetFieldMappingsToDefault
  else
    FOutlookFieldMappings.DelimitedText := Value;
end;

procedure TfrmOptions.tabOutlookContactMappingsShow(Sender: TObject);
begin
  if lbxFieldsFMA.Count > 0 then begin
    lbxFieldsFMA.Selected[0] := True;
    lbxFieldsFMAClick(nil);
  end;  
end;

procedure TfrmOptions.lbxFieldsFMAClick(Sender: TObject);
var I: Integer;
    Index: Integer;
begin
  for I := 0 to lbxFieldsFMA.Count - 1 do
    if lbxFieldsFMA.Selected[I] then begin
      Index := lbxFieldsOutlook.Items.IndexOf(FOutlookFieldMappings.Values[lbxFieldsFMA.Items[I]]);

      if Index <> -1 then
        lbxFieldsOutlook.Selected[Index] := True
      else if lbxFieldsOutlook.Count > 0 then
        lbxFieldsOutlook.Selected[0] := True;

      Break;
    end;
end;

function TfrmOptions.GetOutlookFieldMappings: String;
begin
  Result := FOutlookFieldMappings.DelimitedText;
end;

procedure TfrmOptions.lbxFieldsOutlookClick(Sender: TObject);
var I: Integer;
    Index: Integer;
begin
  Index := -1;
  
  for I := 0 to lbxFieldsFMA.Count - 1 do
    if lbxFieldsFMA.Selected[I] then begin
      Index := I;
      Break;
    end;

  if Index <> -1 then
    for I := 0 to lbxFieldsOutlook.Count - 1 do
      if lbxFieldsOutlook.Selected[I] then begin
        FOutlookFieldMappings.Values[lbxFieldsFMA.Items[Index]] := lbxFieldsOutlook.Items[I];
        Break;
      end;
end;

procedure TfrmOptions.OptionTreeGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
//  var
//    Tab: TTntTabSheet;
//    OptionsGroupData: POptionsTreeItemData;
begin
{ Show ICONS in Tree view....
  if (Kind in [ikNormal,ikSelected]) and (Column = -1) then begin
    Tab := nil;
    if Assigned(Node) then begin
      OptionsGroupData := (Sender as TBaseVirtualTree).GetNodeData(Node);
      if Assigned(OptionsGroupData) and Assigned(OptionsGroupData.Data) then begin
        Tab := OptionsGroupData.Data.Tab;
      end;
    end;
    ImageIndex := Tab.ImageIndex;
  end
  else
    ImageIndex := -1;
}    
end;

procedure TfrmOptions.rbProgressClick(Sender: TObject);
begin
  cbProgressLongOnly.Enabled := rbShowProgressIf.Checked;
  cbProgressRestoredOnly.Enabled := rbShowProgressIf.Checked;
end;

procedure TfrmOptions.btnCheckForUpdatesClick(Sender: TObject);
begin
  if Form1.FmaWebUpdate1.NewUpdateExists(GetBuildVersion,wuWizardOnUpdate) = '' then
    MessageDlgW(_('No new updates are available now.'), mtConfirmation, MB_OK);
end;

procedure TfrmOptions.rdScriptEditorClick(Sender: TObject);
begin
  edScriptEditor.Enabled := rbScriptEditorExternal.Checked;
  if edScriptEditor.Enabled then
    edScriptEditor.Color := clWindow
  else
    edScriptEditor.Color := clBtnFace;
  btnBrowseEditor.Enabled := edScriptEditor.Enabled;
  lblScriptEditorName.Enabled := edScriptEditor.Enabled;
end;

procedure TfrmOptions.btnBrowseEditorClick(Sender: TObject);
begin
  OpenDialog2.InitialDir := WideExtractFileDir(edScriptEditor.Text);
  OpenDialog2.FileName := WideExtractFileName(edScriptEditor.Text);
  if OpenDialog2.Execute then begin
    edScriptEditor.Text := OpenDialog2.FileName;
  end
  else
    rbScriptEditorBuiltin.Checked := True; // not implemented
end;

procedure TfrmOptions.cbBookmarksPhoneClick(Sender: TObject);
begin
  cbBookmarksPhone.Checked := True; // phone bookmarks sync is always enabled
end;

procedure TfrmOptions.WM_SYSCOLORCHANGE(var Msg: TMessage);
begin
  LMDFill1.FillObject.Gradient.Color := ColorToRGB(clHighlight);
  LMDFill1.FillObject.Gradient.EndColor := ColorToRGB(clBtnFace);
  lblPageCaption.Font.Color := ColorToRGB(clCaptionText);
end;

procedure TfrmOptions.btnBTSearchClick(Sender: TObject);
begin
  btnBTSearch.Enabled := False;
  try
    FBtNotSupported := False;
    if Assigned(BtDevices) then BtDevices.Free;
    OptionPagesChange(Self);
  finally
    btnBTSearch.Enabled := True;
  end;
end;

procedure TfrmOptions.edBTAddressChange(Sender: TObject);
begin
  if edBTAddress.Tag = 0 then 
    UpdateBtCombo(edBTAddress.Text);
end;

procedure TfrmOptions.UpdateBtAddress(Value: String);
begin
  edBTAddress.Tag := 1; // prevent update of FBtAddress and FBtDevice
  try
    edBTAddress.Text := StringReplace(Value,':','',[rfReplaceAll]);
  finally
    edBTAddress.Tag := 0;
  end;
end;

procedure TfrmOptions.btnConnectWizardClick(Sender: TObject);
begin
  if MessageDlgW(_('Cancel this dialog and open Getting Started wizard?'),
    mtInformation, MB_OKCANCEL) = ID_OK then begin
      RunGettingStarted := True;
      btnCancel.Click;
    end;
end;

procedure TfrmOptions.lvRulesSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  btnRuleEdit.Enabled := lvRules.SelCount = 1;
  btnRuleDel.Enabled := lvRules.SelCount >= 1;
  btnRunRules.Enabled := btnRuleDel.Enabled and not Assigned(FDeliveryFolder);
end;

procedure TfrmOptions.btnRuleDelClick(Sender: TObject);
var
  i: integer;
begin
  MessageBeep(MB_ICONQUESTION);
  if MessageDlgW(WideFormat(_('Are you sure you want to remove %s?'),
    [ngettext('this rule','these rules',lvRules.SelCount)]),
    mtInformation, MB_YESNO or MB_DEFBUTTON2) = ID_YES then begin
    for i := lvRules.Items.Count-1 downto 0 do
      if lvRules.Items[i].Selected then
        lvRules.Items[i].Delete;
    btnRuleDel.Enabled := False;
  end;
end;

procedure TfrmOptions.btnRuleNewClick(Sender: TObject);
begin
  with TfrmSMSRule.Create(nil) do
  try
    if Assigned(FDeliveryFolder) then begin
      FolderNode := FDeliveryFolder;
      FolderLocked := True;
    end;
    if ShowModal = mrOk then
      with lvRules.Items.Add do begin
        Caption := RuleName;
        SubItems.Add(Form1.GetSMSNodeName(FolderNode));
        SubItems.Add(Correspondents);
        SubItems.Add(Form1.ExplorerNodePath(FolderNode,'\',True));
        Data := Pointer(FolderNode);
        ImageIndex := 62;
      end;
  finally
    Free;
  end;
end;

procedure TfrmOptions.btnRuleEditClick(Sender: TObject);
begin
  with TfrmSMSRule.Create(nil) do
  try
    with lvRules.Selected do begin
      RuleName := Caption;
      Correspondents := SubItems[1];
      FolderNode := PVirtualNode(Data);
      FolderLocked := Assigned(FDeliveryFolder);
      if ShowModal = mrOk then begin
        Caption := RuleName;
        SubItems[0] := Form1.GetSMSNodeName(FolderNode);
        SubItems[1] := Correspondents;
        SubItems[2] := Form1.ExplorerNodePath(FolderNode,'\',True);
        Data := Pointer(FolderNode);
        ImageIndex := 62; // overwrite 'folder not found' index, if any
      end;
    end;
  finally
    Free;
  end;
end;

procedure TfrmOptions.lvRulesDblClick(Sender: TObject);
begin
  if btnRuleEdit.Enabled then btnRuleEdit.Click;
end;

function TfrmOptions.Get_DeliveryRules: WideString;
var
  w: WideString;
  i: Integer;
begin
  Result := '';
  for i := 0 to lvRules.Items.Count-1 do
    with lvRules.Items[i] do begin
      w := WideFormat('%s,%s,%s',
        [WideQuoteStr(Caption),        // rule name
         { skip SubItems[0], it contains folder name }
         WideQuoteStr(SubItems[1]),    // correspondents
         WideQuoteStr(SubItems[2])]);  // node path
      Result := Result + w + sLineBreak;
    end;
end;

procedure TfrmOptions.Set_DeliveryRules(const Value: WideString);
var
  w: WideString;
  i: Integer;
  sl: TTntStringList;
  Node: PVirtualNode;
begin
  FInitDeliveryRules := Value;
  lvRules.Clear;
  sl := TTntStringList.Create;
  try
    sl.Text := Value;
    for i := 0 to sl.Count-1 do
    try
      w := sl[i];
      with lvRules.Items.Add do begin
        Caption := GetFirstToken(w);      // rule name
        SubItems.Add('');                 // folder name (will be set later)
        SubItems.Add(GetFirstToken(w));   // correspondents
        SubItems.Add(GetFirstToken(w));   // node path
        Node := Form1.ExplorerFindNode(SubItems[2]);
        if Assigned(Node) then begin
          SubItems[0] := Form1.GetSMSNodeName(Node);
          Data := Pointer(Node);
          ImageIndex := 62;
        end
        else
          ImageIndex := 29; // set 'folder not found' index
      end;
    except
    end;
  finally
    sl.Free;
  end;
end;

procedure TfrmOptions.btnRunRulesClick(Sender: TObject);
var
  w: WideString;
  i: Integer;
  data: PFmaExplorerNode;
begin
  with TfrmBrowseFolders.Create(nil) do
  try
    OnSelectionChange := OnFolderSelected;

    RootNode := Form1.FNodeMsgRoot;
    Caption := _('Run Rules In...');
    if ShowModal = mrOK then begin
      w := '';
      for i := 0 to lvRules.Items.Count-1 do
        with lvRules.Items[i] do if Selected then begin
          w := w + WideFormat('%s,%s,%s',
            [WideQuoteStr(Caption),        // rule name
             { skip SubItems[0], it contains folder name }
             WideQuoteStr(SubItems[1]),    // correspondents
             WideQuoteStr(SubItems[2])]) + // node path
             sLineBreak;
        end;
      data := tvFolders.GetNodeData(FindNodeWithPath(SelectedNodePath));
      with Form1 do
        try
          DoProcessRules(data.Data,w);
        finally
          ExplorerNewChange(ExplorerNew,ExplorerNew.FocusedNode);
        end;
    end;
  finally
    Free;
  end;
end;

procedure TfrmOptions.Set_DeliveryFolder(const Value: PVirtualNode);
var
  NodePath: WideString;
  i: Integer;
begin
  FDeliveryFolder := Value;
  DeliveryRules := FInitDeliveryRules;
  if Assigned(Value) then begin
    { If target folder is specified, then leave only Delivery Rules
      which target is this very folder. }
    NodePath := Form1.ExplorerNodePath(Value,'\',True);
    for i := lvRules.Items.Count-1 downto 0 do
      if WideCompareStr(NodePath,lvRules.Items[i].SubItems[2]) <> 0 then
        lvRules.Items.Delete(i);
  end;
end;

procedure TfrmOptions.OnFolderSelected(Sender: TObject; Node: PVirtualNode;
  var EnableOKButton, EnableNewFolder: boolean);
begin
  EnableOKButton := Assigned(Node) and (Node <> Form1.FNodeMsgRoot) and
    (Node <> Form1.FNodeMsgDrafts) and (Node <> Form1.FNodeMsgOutbox);
end;

function TfrmOptions.Get_UILangChanged: Boolean;
begin
  Result := NewUILang <> '';
end;

procedure TfrmOptions.Set_UILangChanged(const Value: Boolean);
begin
  if not Value then begin
    ComboBoxLang.ItemIndex := ComboBoxLang.Items.IndexOf(Form1.FormStorage1.StoredValue['LANG']); // do not localize
    if ComboBoxLang.ItemIndex = -1 then ComboBoxLang.ItemIndex := 0;
    NewUILang := '';
  end;
end;

procedure TfrmOptions.tvOutlookContactFoldersChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  FPopupNode := Node;
  mniNewContacts.Enabled := Assigned(FPopupNode) and (FPopupNode.CheckState = csCheckedNormal);
  btnDefaultNewContactDir.Enabled := mniNewContacts.Enabled;
end;

procedure TfrmOptions.btnDefaultNewContactDirClick(Sender: TObject);
begin
  if MessageDlgW(_('This will set New Contacts target folder to current one?'), mtInformation, MB_YESNO) = ID_YES then
    mniNewContacts.Click;
end;

procedure TfrmOptions.TntButton1Click(Sender: TObject);
begin
  if not chkMsgM.Checked then begin
    chkMsgM.Checked := True;
    chkMsgMClick(nil);
    cbMsgToArchive.Checked := True;
  end
  else
    cbMsgToArchive.Checked := not cbMsgToArchive.Checked;
  OptionPagesChange(nil);
end;

procedure TfrmOptions.chkCallMClick(Sender: TObject);
begin
  cbNoCallPopup.Enabled := chkCallM.Checked;
  cbNoCallBaloon.Enabled := chkCallM.Checked;
end;

procedure TfrmOptions.cbCalRecurrenceClick(Sender: TObject);
begin
  cbCalRecurrAsk.Enabled := cbCalRecurrence.Checked;
end;

end.

