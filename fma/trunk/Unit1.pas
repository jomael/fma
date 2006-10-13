unit Unit1;

{
*******************************************************************************
* Descriptions: Main Unit for FMA
* $Source: /cvsroot/fma/fma/Unit1.pas,v $
* $Locker:  $
*
* Todo:
*   - Replace all 'name + [ + number + ]' with ContactNumberByTel and ContactNumberByName
*   - split implementation to different smaller units
*   - store msg to folder not by pdu but by index and location
*
* Change Log:
* $Log: Unit1.pas,v $
* Revision 1.184.2.126  2006/04/07 21:07:28  z_stoichev
* Added Profile Password Protection.
*
* Revision 1.184.2.125  2006/04/06 22:00:55  mhr3
* Fixed few issues for multibyte character sets decoding
*
* Revision 1.184.2.124  2006/03/23 16:39:07  z_stoichev
* - Fixed Open DB Manager only in Offline mode.
* - Fixed Load same profile DB, don't clear GUI.
*
* Revision 1.184.2.123  2006/03/21 19:50:43  mhr3
* Fixed New message trayicon not disappearing
*
* Revision 1.184.2.122  2006/03/16 20:16:40  z_stoichev
* - Fixed Switch Database (Database Manager) implementation.
* - Fixed Relocate old database to Application Data folder.
* - Fixed Manage, Delete and Relocate phone profile changes.
* - Fixed Set friendly name once in Getting Started wizard.
* - Added Set default K750 clones settings for new phones.
* - Added Check OBEX compatability on Getting Started finish.
* - Added Show currentlly opened phone name in Caption.
* - Added New profiles database unique ID by phone name.
*
* Revision 1.184.2.121  2006/03/15 16:42:51  z_stoichev
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
* Revision 1.184.2.120  2006/03/14 15:10:11  z_stoichev
* - Fixed Abort action if RequestConnection fails.
* - Fixed Don't show Getting Started if minimized.
* - Fixed Debug severity type set on debug events.
* - Fixed Do not show empty offline profile name.
* - Fixed Repairing profile DB relocate if needed.
* - Fixed Hide temporary new Alarm explorer node.
* - Fixed Refresh action was not reloading Alarms.
* - Added Auto-WebUpdate daily and weekly support.
* - Added FMA Main menu and Toolbars popup menu.
* - Changed Some main menu items were rearranged.
* - Changed Sony Ericsson known brands DB updated.
* - Changed Initial Getting Started is optional.
* - Changed Get Alarms on Connection is optional.
* - Changed Default FMA Main form appearance.
*
* Revision 1.184.2.119  2006/03/13 13:59:22  z_stoichev
* Create new alarm using Properties dialog.
*
* Revision 1.184.2.118  2006/03/12 23:00:29  z_stoichev
* - Fixed New UTF8 codec implementation usage.
* - Fixed Keyboard Lock toolbar icon blinking.
* - Fixed Click special icons if scrollbar visible.
* - Fixed Developer Tools Send AT implementation.
* - Fixed Developer Tools UTF8 decode folder LS.
* - Fixed Sync Phone Clock added more logging.
* - Fixed Profiles and Groups unicode support.
* - Changed Hide Developer Tools on node change.
* - Added Organized Alarms support (testing).
*
* Revision 1.184.2.117  2006/03/11 15:33:29  z_stoichev
* - Fixed ContactNumberByName implementation.
* - Fixed Select contacts specified by name only.
* - Fixed Creating new Profile statusbar text.
* - Fixed Don't restore FMA in Web Update mode.
* - Added Remember phone model in database.
*
* Revision 1.184.2.116  2006/03/10 15:30:55  z_stoichev
* Fixed New text messages receiving speed issue.
* Changed Inbox suspending interval to 30 seconds.
*
* Revision 1.184.2.115  2006/03/10 13:55:58  z_stoichev
* Added Repair DB button to Switch Profiles dialog.
*
* Revision 1.184.2.114  2006/03/09 22:57:59  mhr3
* - Fixed messages duplicating
*
* Revision 1.184.2.113  2006/03/09 16:03:37  z_stoichev
* Fixed Sending UCS2 Long SMSes.
*
* Revision 1.184.2.112  2006/03/09 09:13:01  z_stoichev
* Gsm_SMS code merged into uSMS.pas!
*
* Revision 1.184.2.111  2006/02/23 15:45:17  z_stoichev
* - Fixed Display (0) unread message items.
* - Fixed Gradient fills removed on few places.
* - Fixed Delete folder will focus parent one.
* - Fixed Change Profile GUI notifications.
* - Fixed Delivery Rules database update.
*
* Revision 1.184.2.110  2006/02/23 12:02:26  z_stoichev
* Fixed Option to disable keylock monitoring.
* Changed Main Menu options under Phone.
*
* Revision 1.184.2.109  2006/02/21 20:49:33  mhr3
* Added option to disable keylock monitoring
*
* Revision 1.184.2.108  2006/02/14 13:35:02  mhr3
* refresh icons now always right-aligned
*
* Revision 1.184.2.107  2006/02/08 18:09:07  mhr3
* added IsK700Clone
*
* Revision 1.184.2.106  2006/02/06 14:25:26  z_stoichev
* Fixed Clear views clear unread counters too.
*
* Revision 1.184.2.105  2006/02/02 10:11:41  z_stoichev
* - Fixed Set Default Font to MS Shell Dlg.
* - Fixed Refresh view after messages move.
* - Fixed Node paint on Explorer node change.
* - Added Search messages Main menu option.
* - Added Search messages Toolbar button.
*
* Revision 1.184.2.104  2006/01/30 16:35:25  z_stoichev
* - Fixed Refresh view after messages move.
* - Fixed Node paint on Explorer node change.
* - Added Search messages Main menu option.
* - Added Search messages Toolbar button.
*
* Revision 1.184.2.103  2006/01/27 22:48:42  mhr3
* modified SpecialImages + added new actions
*
* Revision 1.184.2.102  2006/01/24 13:48:25  z_stoichev
* Fixed FExit and FExiting usage.
* Fixed Save changes on Frame exit.
*
* Revision 1.184.2.101  2006/01/23 16:22:18  z_stoichev
* - Added Start Obex Session with AT+CPROT support.
* - Added Show Use Wizard tip on new USB device.
* - Added Toggle Media Player play/stop button.
* - Fixed Checking keypad support implementation.
*
* Revision 1.184.2.100  2006/01/23 11:29:08  z_stoichev
* GUI changes.
*
* Revision 1.184.2.99  2006/01/20 13:58:31  z_stoichev
* Fixed On fast reconnect expand default nodes.
* Fixed Explorer node changed without focus.
* Fixed Delivery Rules for default folders.
*
* Revision 1.184.2.98  2006/01/20 09:22:07  mhr3
* changed message searching
*
* Revision 1.184.2.97  2006/01/18 16:14:29  mhr3
* more fixes
*
* Revision 1.184.2.96  2006/01/18 12:16:39  z_stoichev
* Show Getting Started wizard on first run.
* Chaged Explorer special icons images.
*
* Revision 1.184.2.95  2006/01/18 11:20:22  z_stoichev
* Added Refresh Calls explorer icon.
*
* Revision 1.184.2.94  2006/01/18 10:43:24  z_stoichev
* Fixes.
*
* Revision 1.184.2.93  2006/01/16 14:58:58  mhr3
* fixed: able to create subfolders to Search results node
*
* Revision 1.184.2.91  2006/01/06 14:40:30  z_stoichev
* Added HTML Help by JediAPIs.
*
* Revision 1.184.2.90  2006/01/06 14:22:07  z_stoichev
* Added HTML Help support.
*
* Revision 1.184.2.89  2005/12/21 13:30:13  z_stoichev
* Fixed Show/Move/Copy/Export long SMS AV bugs.
* Fixed Clear explorer view for SM and ME books.
*
* Revision 1.184.2.88  2005/12/21 10:08:11  mhr3
* fixed OnNewSms not returning proper text body
*
* Revision 1.184.2.87  2005/12/15 11:46:37  z_stoichev
* - Fixed Store SMS from subfolder back to Archive.
* - Fixed Unknown number shown as first in phonebook.
* - Fixed Show Unknown for operator alpha numbers.
* - Fixed Show properly months starting on Sunday.
* - Fixed Sync SMS will detect deleted in Phone ones.
* - Fixed Delete in phone will check for same PDU.
*
* Revision 1.184.2.86  2005/12/12 21:41:52  mhr3
* fixed wrong Explorer node selected when using DownloadAll
*
* Revision 1.184.2.85  2005/12/09 13:41:00  z_stoichev
* - Fixed Preserve OBEX LastErrorCode on error.
* - Fixed Ignore Proximity Away on first connect.
* - Fixed Proximity Detection search engine.
* - Fixed Missing Call balloon is not visible.
* - Fixed Connection not possible issue (AV bug).
* - Fixed Update missed calls when minimized.
* - Check minute minder disabled for K750 clones.
* - Included is new Scripting Framework by mhr.
* - Added GetContactRestrict loop util success.
* - Added Notification icon for missing calls.
* - Added Notification icon for new messages.
*
* Revision 1.184.2.84  2005/12/08 20:02:39  mhr3
* fixed wrong node selected when using DownloadAll
*
* Revision 1.184.2.83  2005/12/07 13:43:38  z_stoichev
* Added K750 scripting support.
*
* Revision 1.184.2.82  2005/12/07 10:52:32  mhr3
* Added export contacts to .LDIF file (Thunderbird)
*
* Revision 1.184.2.81  2005/11/24 14:04:40  z_stoichev
* - Fixed Script Uploading on application exit.
* - Fixed Call Contact Alpha changed in Options.
* - Fixed GUI small issues on various places.
* - Added More Welcome Tips by ToddJG (thanks alot).
*
* Revision 1.184.2.80  2005/11/20 12:19:04  mhr3
* - Fixed Key Monitoring disabled on startup by mhr
* - Fixed WideStringReplace to Tnt_WideStringReplace (update your Tnt package)
*
* Revision 1.184.2.79  2005/11/20 09:18:06  z_stoichev
* - Fixed Key Monitoring disabled on startup.
* - Fixed Do not show Welcome Tips if minimized.
*
* Revision 1.184.2.78  2005/11/03 14:38:12  z_stoichev
* GUI WinXP theme fixes.
*
* Revision 1.184.2.77  2005/11/03 12:49:10  z_stoichev
* fixed panel background with WinXP theme support.
*
* Revision 1.184.2.76  2005/10/04 15:11:57  z_stoichev
* GUI Fixes
*
* Revision 1.184.2.75  2005/10/04 13:16:17  z_stoichev
* - Fixed AV bug on Folder (1) double-click.
* - Fixed AV bug after apply delivery rules.
* - Fixed Delete Obex Files confirmation text.
*
* Revision 1.184.2.74  2005/10/04 10:05:28  expertone
* L10N Fixes
*
* Revision 1.184.2.73  2005/10/03 14:58:22  z_stoichev
* Apply Delivery Rules on folder.
*
* Revision 1.184.2.72  2005/10/03 08:17:05  z_stoichev
* Browse For Folder changes.
* Set 'Move to FMA' option on custom Options Page dialogs.
*
* Revision 1.184.2.71  2005/10/02 22:36:44  z_stoichev
* Delivery Rules implementation changes.
*
* Revision 1.184.2.70  2005/10/01 13:00:38  z_stoichev
* - Added Delivery Rules for outgoing messages.
* - Added Delivery Rules Export/Import support.
* - Fixed Move message to FMA implementation.
*
* Revision 1.184.2.69  2005/10/01 10:12:05  z_stoichev
* WideQuoteStr function fixes.
*
* Revision 1.184.2.68  2005/09/30 21:13:58  z_stoichev
* Fixed Outlook Categories save.
*
* Revision 1.184.2.67  2005/09/30 20:29:32  z_stoichev
* Delivery Rules changes.
* Quoted strings bufgixes.
* Main menu changed again.
*
* Revision 1.184.2.66  2005/09/30 15:03:08  z_stoichev
* Fixed save Delivery Rules after Options dialog change.
*
* Revision 1.184.2.65  2005/09/30 14:49:29  z_stoichev
* Delivery Rules implementation.
* Startup optimizations and fixes.
* Do not clead folder on new SMS arrive.
* Custom SMS folder fixes.
*
* Revision 1.184.2.64  2005/09/21 20:40:21  z_stoichev
* Fixed move sms to folder.
*
* Revision 1.184.2.63  2005/09/21 14:24:12  z_stoichev
* Fixed Move messages to Folder keep SMS type.
*
* Revision 1.184.2.62  2005/09/20 23:22:51  z_stoichev
* no message
*
* Revision 1.184.2.61  2005/09/20 21:29:58  z_stoichev
* - Fixed Create Empty folder will show warning.
* - Changed Main menu reorganized from scratch.
* - Edit Owner Card enabled when connected only.
*
* Revision 1.184.2.60  2005/09/20 14:48:00  z_stoichev
* Do not allow empty folder creation.
* Added main menu add/delete folder.
*
* Revision 1.184.2.59  2005/09/20 13:56:24  z_stoichev
* - Added User SMS Messages folders support.
* - Added Move Messages to custom folder.
* - Changed Confirmation default buttons.
*
* Revision 1.184.2.58  2005/09/20 06:57:33  z_stoichev
* Sync messages progress text changed.
*
* Revision 1.184.2.57  2005/09/19 22:46:21  z_stoichev
* Fixed Proximity Away detection not working issue.
*
* Revision 1.184.2.56  2005/09/19 20:46:35  z_stoichev
* BT Setting not remembered.
*
* Revision 1.184.2.55  2005/09/19 14:09:35  z_stoichev
* Fixed AV bugs after Explorer Properties click.
*
* Revision 1.184.2.54  2005/09/19 13:21:10  z_stoichev
* - Added SMS Folders Synchronize instead Download !!!
* - Added Command line switch "/fixdb" to clean DB.
*
* Revision 1.184.2.53  2005/09/18 21:45:07  z_stoichev
* - Fixed Add to Phonebook marks New contact as modified.
* - Fixed Explorer view of Contacts without numbers.
* - Fixed Update Explorer Properties on connection change.
* - Added Contact Group properties add/remove members.
* - Other bugfixes.
*
* Revision 1.184.2.52  2005/09/17 15:19:35  z_stoichev
* Add to Group fixes.
*
* Revision 1.184.2.51  2005/09/17 12:15:57  z_stoichev
* Add to Contact Group fixes.
* Added Task ID refference.
* Sync Clock is Action now.
*
* Revision 1.184.2.50  2005/09/16 10:21:04  z_stoichev
* Changed Popup menu options/text.
*
* Revision 1.184.2.49  2005/09/15 15:06:57  z_stoichev
* Sync Bookmarks changes.
*
* Revision 1.184.2.48  2005/09/14 15:24:05  z_stoichev
* Bookmarks sync.
*
* Revision 1.184.2.47  2005/09/13 20:25:53  z_stoichev
* Started 'real' bookmarks sync implementation.
*
* Revision 1.184.2.46  2005/09/13 13:26:27  z_stoichev
* Fixed Old components used by ExpertOne.
*
* Revision 1.184.2.45  2005/09/12 18:51:24  expertone
* Script related fixes (localization, ScriptFolder)
*
* Revision 1.184.2.44  2005/09/09 10:39:00  z_stoichev
* Fixed Welcome Tips can not be closed issue.
*
* Revision 1.184.2.43  2005/09/08 21:09:03  z_stoichev
* Fixed common Edit actions.
* Welcome Tips are optional.
* Monitor system color scheme.
*
* Revision 1.184.2.42  2005/09/08 16:12:52  z_stoichev
* Added Welcome Tips dialog and COM object method AddTip.
*
* Revision 1.184.2.41  2005/09/08 11:19:55  z_stoichev
* Unicode bugfixes.
*
* Revision 1.184.2.40  2005/09/06 18:32:56  z_stoichev
* Bugfixes and improvements (2.1.1.102b)
*
* Revision 1.184.2.39  2005/09/02 13:05:10  z_stoichev
* - Fixed Statrup Web Update when new version found.
* - Added Receiving messages failed notification.
*
* Revision 1.184.2.38  2005/09/01 13:47:28  z_stoichev
* - Added Silent Mode and Minute Minder are optional.
* - Added Partially downloaded messages saved to DB.
*
* Revision 1.184.2.37  2005/09/01 08:40:53  z_stoichev
* - Fixed AV errors on WebUpdate intermediate restart.
* - Changed Do not check for update if just updated.
*
* Revision 1.184.2.36  2005/09/01 01:47:03  z_stoichev
* - Fixed Scripting Editor executable not found warning.
* - Script Editor changes, improvements and bugfixes.
* - Database Profiles in AppData only ("-migratedb" to override).
* - Added Chat Nick name and Long SMS settings in Options.
*
* Revision 1.184.2.35  2005/08/31 18:21:32  z_stoichev
* Send-Receive SMS bugfixes.
*
* Revision 1.184.2.34  2005/08/31 12:18:01  z_stoichev
* - Fixed AV error when Explorer Node.Data is nil.
*
* Revision 1.184.2.33  2005/08/31 12:04:55  z_stoichev
* - Fixed AV error when Explorer data is nil.
*
* Revision 1.184.2.32  2005/08/31 11:51:52  z_stoichev
* - Fixed New Message Popup shows Long SMS as one.
* - Fixed Outbox sending routines optimizations.
* - Click on message baloon do not mark it as read.
*
* Revision 1.184.2.31  2005/08/30 15:27:59  z_stoichev
* - Fixed Outbox processing recoded frmo scratch.
* - Added Sync Calendar priority Options setting.
* - Added Conflict dialog Don't Ask Again checkbox.
* - Fixed Prompt Conflict unicode and GUI layout.
* - Fixed Sync Conflict when priority is Let Me Chose.
* - Fixed OBEX unknown file types support (delete).
* - Changed Options pages rearranged, GUI changes.
* - Fixed Calling popup and Compone SMS Alpha update.
*
* Revision 1.184.2.30  2005/08/29 15:19:31  z_stoichev
* Unicode fixes.
*
* Revision 1.184.2.29  2005/08/29 14:41:04  z_stoichev
* - Fixed Incorrect phonebook tree with cyrillic names.
*
* Revision 1.184.2.28  2005/08/26 15:30:08  z_stoichev
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
* Revision 1.184.2.27  2005/08/24 14:36:18  z_stoichev
* - Synchronization display messages are uniform now.
*
* Revision 1.184.2.26  2005/08/24 13:14:47  z_stoichev
* - Fixed Contacts Database loading and parsing.
* - Fixed Contacts Database Unicode support.
*
* Revision 1.184.2.25  2005/08/23 12:56:28  z_stoichev
* Web Update added startup check and options.
*
* Revision 1.184.2.24  2005/08/23 00:06:21  z_stoichev
* Fixed AV errors if run as second instance.
*
* Revision 1.184.2.23  2005/08/22 23:56:06  z_stoichev
* Various GUI changes and bugfixes.
*
* Revision 1.184.2.22  2005/08/22 21:21:37  z_stoichev
* Fixed Proximity implementation.
*
* Revision 1.184.2.21  2005/08/22 17:37:38  z_stoichev
* - Fixed Messages Folder name lookup thread removed.
* - Fixed Text Messages sorted by name column issue.
*
* Revision 1.184.2.20  2005/08/22 12:55:05  z_stoichev
* Communication bugfixes.
*
* Revision 1.184.2.19  2005/08/20 19:29:25  z_stoichev
* no message
*
* Revision 1.184.2.18  2005/08/20 18:59:06  z_stoichev
* - Changed "-debug", "-debugobex" to use "/" instead "-".
* - Fixed Properties toolbar button recreated as an Action.
* - Fixed Incorrect Explorer frame on Explorer properties.
*
* Revision 1.184.2.17  2005/08/20 18:13:38  z_stoichev
* - Fixed LookupContact, LookupNumber, ContactNumberByName.
* - Fixed Find contact in Phonebook (Irmc), Phone Book, SIM.
*
* Revision 1.184.2.16  2005/08/19 12:29:06  z_stoichev
* - Added more Codec stuff to FMA developer tools.
* - Fixed Explorer ME contact properties without IrmcSync.
* - Fixed Contact Personalize Upload canceled.
* - Fixed Update explorer and views if contact modified.
* - If not IrmcSync supported, disable Calendar view.
* - Fixed Phonebook update on IrmcSync option change.
* - Edit script code confirmation could be canceled.
* - Fixed Voice Call Contact unicode support.
* - Select contact to Voice Call GUI changes.
* - Different user-friendly Refresh Action captions.
*
* Revision 1.184.2.15  2005/08/18 23:05:37  z_stoichev
* Added detailed info and some actions to Call properties.
*
* Revision 1.184.2.14  2005/08/18 17:16:51  z_stoichev
* - Fixed missing Group members properties.
* - uWBMP refference moved into uGlobal.
*
* Revision 1.184.2.13  2005/08/17 18:40:05  lordlarry
* - Added /log to directly log to a file on disk
* - Added Outlook Field Mappings
*
* Revision 1.184.2.12  2005/08/17 11:39:42  z_stoichev
* - Removed useless Scripts Phone Explorer node.
* - Edit Script Code menu command launches Notepad.
* - Fixed explorer frames NoItemsPanel background.
*
* Revision 1.184.2.11  2005/08/17 09:13:27  z_stoichev
* - Do not accept drag'n'drop files while connecting.
* - Call OnDisconnected script event properly.
* - Better handling for AT commands on Options exit.
* - Proximity implementation small changes.
* - Multiple Syncs on Startup issue fixes.
*
* Revision 1.184.2.10  2005/08/16 16:15:31  z_stoichev
* bugfixes
*
* Revision 1.184.2.9  2005/05/17 18:08:06  lordlarry
* - Added Exception Test only visible with -debug
*
* Revision 1.184.2.8  2005/04/11 22:36:28  z_stoichev
* Fixed GSM coding scheme.
*
* Revision 1.184.2.7  2005/04/11 09:38:09  z_stoichev
* Translate user-friendly error messages.
*
* Revision 1.184.2.6  2005/04/10 21:26:03  lordlarry
* Finally fixed the widcomm issue. Successfuly tested with widcomm 1.4.3.4 and P4 3.4 HT! (vo_x)
*
* Revision 1.184.2.5  2005/04/10 17:57:19  z_stoichev
* Fixed: Explorer Save message to folder routines.
* Changed: GUI small changes, added menu item.
*
* Revision 1.184.2.4  2005/04/09 17:24:10  lordlarry
* Fixed: Made exception while deleting SMS message return more information
*
* Revision 1.184.2.3  2005/04/09 17:21:48  lordlarry
* Fixed: Some typos
* Fixed: URL to forums
* Fixed: AV when deleting SMS messages
* Changed: Made exception while deleting SMS message return more information
*
* Revision 1.184.2.2  2005/04/03 12:24:37  lordlarry
* Changed some methods to WideString methods
* Fixed the bug where deleting a file didn't work in subdirectories
* Fixed the bug where assigning an image to a contact didn't work
* Fixed: BlueSoleil issue workaround. (z_stoichev)
* Fixed: Unsafe chars in phone model. (z_stoichev)
*
* Revision 1.184.2.1  2005/03/21 22:41:36  schnorbsl_fma
* Fixed: OBEX files: download not possible for not registered file types
* Fixed: Explorer: MultiSelect capability for OBEX files node and subnodes
*
* Revision 1.184  2005/03/13 10:46:29  schnorbsl_fma
* added: set default DisplayName with import contact from phone
*
* Revision 1.183  2005/03/12 17:37:07  lordlarry
* Fixed Memory Leaks
* Fixed Percentage not showing when connecting in Baloon message
*
* Revision 1.182  2005/03/12 12:43:48  z_stoichev
* Fixed: BT or IR on connect failure logic.
* Added: Connection failure friendly messages.
* Added: New wizards image with K700 phone.
*
* Revision 1.181  2005/03/07 14:18:14  z_stoichev
* Fixed: Quit on Windows End Session.
*
* Revision 1.180  2005/03/05 14:23:55  lordlarry
* Changed the Name Locally used Comm Components to prevent confiusion and solve a 'with' bug
*
* Revision 1.179  2005/03/02 17:57:44  voxik
* Removed obsolete Unicode unit
*
* Revision 1.178  2005/03/01 12:04:54  z_stoichev
* Components update for latest Tnt Controls.
*
* Revision 1.177  2005/02/28 20:05:48  lordlarry
* Fixed a time out bug which occured after making the code thread safe
*
* Revision 1.176  2005/02/28 07:40:21  z_stoichev
* Invoke ScreenSaver fixed. Credit goes to Vladimir Kopjov
*
* Revision 1.175  2005/02/24 21:29:13  lordlarry
* Added a better (but ugly) method to make the TWaitThread code threadsafe. All data that is accessed outside of the class goes through the ThreadSafe object which does the locking.
*
* Revision 1.174  2005/02/19 12:57:32  lordlarry
* Removed the last call to the Debug method
*
* Revision 1.173  2005/02/19 12:51:00  lordlarry
* Changed Log Messages Category and Severity (Removing the SyncLog method)
*
* Revision 1.172  2005/02/19 11:02:35  lordlarry
* Changed Log Messages Category and Severity (Removing the Debug method)
*
* Revision 1.171  2005/02/19 10:49:28  lordlarry
* Changed Log Messages Category and Severity (Removing the Debug method)
*
* Revision 1.170  2005/02/18 16:18:21  z_stoichev
* Intermediate bugfixes - not finished work, sorry no time!
*
* Revision 1.169  2005/02/17 11:58:57  z_stoichev
* Getting Started Wizard Improvements
*
* Revision 1.168  2005/02/16 23:29:21  schnorbsl_fma
* * - Fixed Estimated Time Left displays '%d days' instead of 'days'.
*
* Revision 1.167  2005/02/15 11:19:06  z_stoichev
* Getting Started Wizard finished.
* Fixed Remember Bluetooth device name.
*
* Revision 1.166  2005/02/14 19:45:39  lordlarry
* Fixed FMA wouldn't close with log window open
*
* Revision 1.165  2005/02/14 19:10:07  voxik
* Added BT devices enumeartion
*
* Revision 1.164  2005/02/14 16:02:03  z_stoichev
* Getting Started Wizard
*
* Revision 1.163  2005/02/14 10:23:54  z_stoichev
* Export contacts as Opera contacts file.
*
* Revision 1.162  2005/02/12 17:22:38  z_stoichev
* LOG main menu and toolbar button fixes.
* Clear/close LOG when exiting Fma.
*
* Revision 1.161  2005/02/11 08:57:48  z_stoichev
* ADDED DB LOADING BUGFIXES AGAIN
*
* Revision 1.160  2005/02/10 21:35:51  gravanov
* Changed: Options dialog appearance
* Changed: Outlook handling
* Added: Tabs for Outlook calendar and tasks folders.
*
*
* Revision 1.159  2005/02/10 20:07:03  lordlarry
* New way of Logging
*
* Revision 1.158  2005/02/10 09:27:30  z_stoichev
* - Fixed: Database overriden on second phone usage.
* - Fixed: Database upgrade rollback on failure.
* - Fixed: Use old database on upgrade failure.
* - Fixed: Forced upgrade from single database.
*
* Revision 1.157  2005/02/09 14:01:38  z_stoichev
* Fixed #13#10 to sLinebreak.
*
* Revision 1.156  2005/02/09 11:01:12  z_stoichev
* Fixed WideChar cast for initial Outlook sync.
* Added Getting Started main menu item.
*
* Revision 1.155  2005/02/08 19:03:38  voxik
* Fixed Activity log alpha blended
*
* Revision 1.154  2005/02/08 18:42:56  voxik
* Fixed WideFormat used instead of Format
*
* Revision 1.153  2005/02/08 15:38:30  voxik
* Merged with L10N branch
*
* Revision 1.130.2.11  2005/02/07 23:32:40  voxik
* Fixed Unicode debug logs
*
* Revision 1.130.2.10  2005/02/02 23:28:11  voxik
* Fixed Unicode support
*
* Revision 1.130.2.9  2005/02/02 23:15:49  voxik
* Changed MessageDlg and ShowMessages replaced by new unicode versions
*
* Revision 1.130.2.8  2005/01/27 14:05:57  voxik
* Fixed Unicode support
*
* Revision 1.130.2.7  2005/01/27 13:24:10  voxik
* Fixed Splashscreen unicode support
*
* Revision 1.130.2.6  2005/01/26 12:40:55  voxik
* Removed VirtualTree was removed due to performance issues.
*
* Revision 1.130.2.5  2005/01/07 17:34:35  expertone
* Merge with MAIN branch
*
* Revision 1.152  2005/01/04 15:55:38  z_stoichev
* - Fixed: Phone toolbar behaviour and icons
*
* Revision 1.151  2005/01/04 12:31:28  z_stoichev
* - Fixed: Relocate DB create AppData path.
* - Added: Ask for DB relocate only once.
* - Added: Main menu toolbars are optional.
* - Added: Remember toolbars positions.
*
* Revision 1.150  2005/01/03 16:13:05  z_stoichev
* - Fixed: Copy/move Long SMS to Archive.
* - Fixed: Create Bookmark on-update event.
* - Fixed: Main menu hints text updated.
* - Fixed: Main menu selection with keyboard.
* - Changed: Various main menu images.
* - Changed: Main menu reorganized alot.
* - Changed: Tray icon popup menu.
* - Changed: Source code cleanup.
* - Added: Minute Minder menu option (iceberg).
* - Added: Save unsent New message as Draft.
*
* Revision 1.149  2004/12/25 05:46:41  iceberg_boc
* *** empty log message ***
*
*
* Revision 1.149  2004/12/25 02:07:16  iceberg
* Add Minute minder function.
*
* Revision 1.148  2004/12/23 15:52:28  z_stoichev
* Sync Bookmarks started.
* Bugfixes.
*
* Revision 1.147  2004/12/22 13:50:52  z_stoichev
* Options Script page predefined settings.
* Slpash image do not stay on top.
*
* Revision 1.146  2004/12/21 14:01:10  z_stoichev
* New Web Update Wizard implementation.
*
* Revision 1.145  2004/12/19 23:47:38  voxik
* Fixed IrDA connection memory leaks
*
* Revision 1.144  2004/12/19 10:33:37  voxik
* Fixed Debug log is not scrolling anymore when cursor position is not on the end of text
*
* Revision 1.143  2004/12/18 18:06:36  z_stoichev
* Fixed Update_KeyMonitor_And_EBCA_State by vo.x
*
* Revision 1.142  2004/12/15 15:47:20  z_stoichev
* Merged with Long SMS branch.
*
* Revision 1.141  2004/12/14 11:22:41  z_stoichev
* - Fixed: Update Fma Today caption on phone rename.
* - Fixed: Use AppData path to access local files.
* - Fixed: Themes database profile sub-path.
*
* Revision 1.140  2004/12/13 15:35:11  z_stoichev
* - Fixed: Key Monitoring state detection bugfixes.
* - Added: Check Battery support on connecting.
* - Added: Check Signal support on connecting.
* - Changed: Made disconnect on low battery optional.
* - Changed: Made Battery monitoring optional.
* - Changed: Made Signal monitoring optional.
* - Changed: Enable Key Monitoring while minimized.
*
* Revision 1.139  2004/12/11 15:59:16  z_stoichev
* Fixed: Status Diagram moved into Today Caption.
* Fixed: Load profile from various locations.
* Fixed: Reset SMS counter if the reset-day passed.
* Added: Send Outbox messages progress dialog.
* Added: Confirmation moving profile to AppData.
*
* Revision 1.138  2004/12/11 12:14:02  z_stoichev
* Add Send Messages Progress dialog
* Bugfixes.
*
* Revision 1.137  2004/12/10 22:17:18  z_stoichev
* Fixed some default fonts and charsets.
*
* Revision 1.136  2004/12/10 16:09:13  z_stoichev
* Fixed: Tray area icon popup menu enchanced.
* Fixed: Startup code cleanup and optimization.
* Fixed: Clear some global variables on exit.
* Fixed: Splash shown on first instance only.
* Added: Always start as Minimized option.
* Added: Show splash on startup option.
*
* Revision 1.135  2004/12/09 19:34:41  z_stoichev
* Fixed DB move to AppData folder error.
* Hide splash delayed and other fixes.
*
* Revision 1.134  2004/12/09 16:40:40  z_stoichev
* Added Splash image for MobileAgent 2 release.
*
* Revision 1.133  2004/11/22 14:02:51  z_stoichev
* Fixed: Upgrade from single DB (some files arent copied).
* Added: Database files moved to Application Data folder.
*
* Revision 1.132  2004/10/16 15:47:50  tuxscreen
* Fixed: last fix broke T610 Accu parser
*
* Revision 1.131  2004/10/16 14:42:40  tuxscreen
* Fixed EBCA Battery parsing for K700i
*
* Revision 1.130.2.4  2004/11/10 11:42:03  expertone
* Decode input message from UTF8
*
* Revision 1.130.2.3  2004/11/01 21:15:32  expertone
* Added VirtualExplorer to replace Explorer
* Added pictures for About header (for BiDi RtL)
*
* Revision 1.130.2.2  2004/10/25 20:21:52  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.130.2.1  2004/10/19 19:48:44  expertone
* Add localization (gnugettext)
*
* Revision 1.130  2004/10/15 14:01:58  z_stoichev
* Merged with Stable bugfixes
*
* Revision 1.129  2004/10/14 21:28:25  voxik
* Changed vObject handling background
*
* Revision 1.128  2004/10/11 13:46:16  voxik
* Fixed Cal sync doubled
*
* Revision 1.127  2004/10/11 13:15:44  voxik
* Merged with Calendar branch (Fma 0.1.2.10)
*
* Revision 1.126  2004/09/21 14:38:57  z_stoichev
* Added WBMP support.
*
* Revision 1.125  2004/09/20 11:57:00  merijnb
* merged with FileObject
*
* Revision 1.124  2004/09/10 11:58:24  z_stoichev
* - Fixed 'Old data format' error when turn off IrmcSync.
* - Fixed Switch IrmcSync do not remember contact states.
* - Fixed End Windows Session and FMA do not exits.
*
* Revision 1.123  2004/09/08 19:06:17  lordlarry
* New Line Char in Contact Name is read properly from the Contacts.SYNC.dat file too
*
* Revision 1.122  2004/09/07 19:26:13  lordlarry
* New Line Char in Contact Name is read properly from the Contacts.ME.dat file (not checked Contacts.SYNC.dat)
*
* Revision 1.121  2004/09/04 13:48:26  lordlarry
* Enter in contact names throws EAbort when reading from DB. Catched and loged it so FMA doesn't blow. Needs a propper fix.
*
* Revision 1.120.2.7  2004/10/15 11:27:58  z_stoichev
* Bugfixes
*
* Revision 1.120.2.6  2004/10/14 16:43:26  z_stoichev
* Bugfixes
*
* Revision 1.120.2.5  2004/09/20 08:32:20  merijnb
* added support for paths with CRLF's and / or spaces in them
*
* Revision 1.120.2.4  2004/09/10 12:10:12  z_stoichev
* - Fixed 'Old data format' error when turn off IrmcSync.
* - Fixed Switch IrmcSync do not remember contact states.
* - Fixed End Windows Session and FMA do not exits.
*
* Revision 1.120.2.3  2004/09/08 19:24:24  lordlarry
* New Line Char in Contact Name is read properly from the Contacts.SYNC.dat file too
*
* Revision 1.120.2.2  2004/09/07 19:30:03  lordlarry
* New Line Char in Contact Name is read properly from the Contacts.ME.dat file (not checked Contacts.SYNC.dat)
*
* Revision 1.120.2.1  2004/09/04 13:49:48  lordlarry
* Enter in contact names throws EAbort when reading from DB. Catched and loged it so FMA doesn't blow. Needs a propper fix.
*
* Revision 1.120  2004/08/27 20:41:59  lordlarry
* Merge from newxml
*
* Revision 1.119.4.2  2004/08/25 15:41:13  merijnb
* added export to xml for SIM entries
*
* Revision 1.119.4.1  2004/08/25 10:54:13  merijnb
* implemented xml parser
*
* Revision 1.119  2004/08/19 12:55:29  merijnb
* contents of sms textbox aren't cleared if the sms compose window was already visible (1003202)
*
* Revision 1.118  2004/08/19 12:27:29  merijnb
* changed the way voice dialling support is deteced since K700 does not support at*evd, but does at*eva and at*evh. this fixed the "can't hangup with k700" bug, since k700 does _not_ support ATH very well
*
* Revision 1.117  2004/08/18 17:16:57  voxik
* Fixed Removed Ifdefs for WinXP.res
*
* Revision 1.116  2004/08/17 20:21:58  merijnb
* little cosmetic thing. Units are now made readable (10.000 mA -> 10 A)
*
* Revision 1.115  2004/08/17 14:49:15  merijnb
* added support for (K700) subfolders (bugfix for 1007256 and 994461)
*
* Revision 1.114  2004/07/26 12:55:55  z_stoichev
* - Fixed Clock sync if hour separator is not colon.
* - Fixed Auto-reconnect loop can be aborted now.
* - Fixed Parse Obex Folders file size ends with 'd' issue.
* - Changed Quote of the day :-D
* - Added Force UCS-2 new text message encoding.
* - Added Power Off phone tools feature.
*
* Revision 1.113  2004/07/25 14:38:35  lordlarry
* - Fixed: Outlook Sync is disabled if IrmcSync is disabled
* - Changed: Options menu item have moved to the Tools menu
*
* Revision 1.112  2004/07/25 13:30:36  lordlarry
* Added the ability to select the Outlook folder where all the New contacts end up.
*
* Revision 1.111  2004/07/24 15:59:04  lordlarry
* D7 compatibility thing fixed
*
* Revision 1.110  2004/07/14 10:04:12  z_stoichev
* - Fixed Do not steal notes focus on active call.
* - Fixed Estimated Time Left displays wrong days.
* - Fixed Disable explorer view during files delete.
*
* Revision 1.109  2004/07/07 11:23:25  z_stoichev
* - Fixed '' is not valid integer on SMS sending.
* - Fixed Call/msg personalized much faster now.
* - Fixed UpdateNewMessagesCounter is failsafe.
* - Added Chat messages are auto-marked as read.
* - Added Chat messages are deleted from phone.
* - Added Chat messages do not open popup window.
* - Added Toggle Silent Mode on/off toolbar buton.
* - Added More startup explorer folder options.
* - Changed Connect/disconnect phone icons.
* - Changed Conection progress indicator.
*
* Revision 1.108  2004/07/06 14:44:42  z_stoichev
* - Fixed Call/msg personalized much faster now.
* - Added K700 subfolders partial support.
*
* Revision 1.107  2004/07/02 20:14:23  z_stoichev
* - Fixed Save Script editor changes issue.
* - Close mutex handle on exit mem leak bugfix.
*
* Revision 1.106  2004/07/02 18:14:16  lordlarry
* Fixed 100% CPU when communicating
*
* Revision 1.105  2004/07/02 08:14:02  z_stoichev
* - Added Sound events for Proximity Away/Near.
*
* Revision 1.104  2004/07/02 07:46:05  z_stoichev
* - Fixed DB upgrade in Save Message To Folder.
* - Fixed DB upgrade in Update Folder Unread Counter.
*
* Revision 1.103  2004/07/01 14:40:23  z_stoichev
* Quote of the day :)
*
* Revision 1.102  2004/06/30 16:13:42  z_stoichev
* - Fixed Sync menu items disabled in offline mode.
* - Fixed FMA main menu changes reapplied.
*
* Revision 1.101  2004/06/30 15:34:01  z_stoichev
* - Fixed New Bookmark action update check.
* - Fixed Ask for unsent messages on exit when minimized.
* - Fixed Hide GUI when starting second Fma instance.
* - Fixed dial wrong number when name contains digits.
* - Fixed WAP Home Page UTF-8 codec support.
* - Added WAP Home Page locked warning message.
* - Added WAP Home Page edit sanity check.
* - Added Add contact number to Phonebook wizard.
* - Added Create/Delete phone contacts Group.
* - Changed Message storage full warning is optional.
*
* Revision 1.100  2004/06/29 15:25:51  z_stoichev
* Add Call support without popups.
* Edit Call Favorites support
* Call Contact confirmation dialog.
* Dont remember what is next :)
*
* Revision 1.99  2004/06/28 22:43:54  z_stoichev
* Delete bugfixes.
*
* Revision 1.98  2004/06/28 15:34:30  z_stoichev
* - Fixed 977988 Files overwritten without Prompt.
* - Fixed 977310 Quotes in phone serial number.
* - Fixed Connection loop if clock sync is on.
* - Fixed Send Message selects message store first.
* - Added Phone message storage is 90% full warning.
* - Added Sync with Outlook on startup option.
* - Added Edit WAP Home Page URL (under Tools).
* - Added Explore phone WAP bookmarks.
* - Added 10 secs delay after Disconnect Temporary.
* - Added Edit Favorites from main menu.
* - Added Delete phone Bookmark.
* - Added Bookmark root folder profile setting.
* - Changed Create new phone bookmark (without Obex).
* - Changed Made Script usage optional (see Options).
* - Changed Low battery warning (typos) (LL).
* - Changed Fma Home page URL to sf.net one.
* - Changed Outlook categories moved to phone profile.
* - Changed Outlook folders moved to phone profile.
* - Changed Favorites list moved to phone profile.
* - Changed TxAndWait communication routine (LL).
* - Changed Main menu has Edit submenu now.
* - Changed Main menu reorganized a lot.
* - Changed Outlook categories Options recoded.
*
* Revision 1.97  2004/06/28 09:13:32  z_stoichev
* TxAndWait Bugfixes.
* 10 secs delay after Disconnect Temporary.
*
* Revision 1.96  2004/06/27 21:49:41  z_stoichev
* Retrieve and Explore phone WAP bookmarks.
* Fixed Connection loop if clock sync is on.
* TxAndWait INFINITE loop changed to 50 ms.
*
* Revision 1.95  2004/06/27 20:26:23  lordlarry
* - Optimized a part of TxAndWait. Didn't help much tho'
* - Corrected some spelling thanks to Astrakaw
*
* Revision 1.94  2004/06/27 11:28:56  z_stoichev
* Fixed bookmarks loading
*
* Revision 1.93  2004/06/25 15:19:05  z_stoichev
* - Fixed 977988 Files overwritten without Prompt.
* - Fixed 977310 Quotes in phone serial number.
* - Fixed 977367 No quotes in imported message PDUs.
* - Fixed Send Message selects message store first.
* - Added Phone message storage is 90% full warning.
* - Added Sync with Outlook on startup option.
* - Added Edit WAP Home Page URL (under Tools).
* - Added JCL exception dialog with Send Report.
*
* Revision 1.92  2004/06/25 08:25:16  z_stoichev
* - Fixed 977310 Quotes in phone serial number.
* - Fixed Send Message selects message store first.
* - Added Phone message storage is 90% full warning.
*
* Revision 1.91  2004/06/24 14:56:02  z_stoichev
* - Fixed Upload Contacts phone type to SIM issues.
* - Fixed Max field length for ME and SM Phonebooks.
* - Fixed Contact name lookup routines use ME phonebook.
* - Changed Connect after unknown number call is entered.
* - Changed Explorer Popup menu reorganized.
* - Added Chat to Contact command to various popup Menus.
* - Added Add to Phonebook to various popup Menus.
* - Added hit Enter in SIM editor to edit contact.
* - Added Remove favorite item confirmation message.
* - Added Download entire SIM phonebook.
* - Added New SIM editor columns (phone type, status).
* - Broken Phonebook editors Sorting is not remembered.
*
* Revision 1.90  2004/06/24 09:09:33  z_stoichev
* - Fixed Contact name lookup routines use ME phonebook.
* - Added Chat to Contact command to various popup Menus.
* - Added Add to Phonebook to various popup Menus.
*
* Revision 1.89  2004/06/23 13:52:17  z_stoichev
* Fixed New Message Delete from Archive folder.
* Added Chat to Contact using Text messages.
*
* Revision 1.88  2004/06/22 14:51:37  z_stoichev
* - Fixed SIM database old format detection.
* - Fixed Copy SIM contacts to Phonebook.
* - Fixed Export file type filter misusage/order.
* - Fixed Export messages UTF-8 and html encoding.
* - Fixed Export contacts multiple headers (csv).
* - Fixed Broken Proximity auto re-connect feature.
* - Fixed Incorrect phone detection messages.
* - Fixed SMS Reply focuses message body.
* - Added Fma Today splitters display marker.
* - Added Fma Today open/close panel Buttons.
* - Added GetToken double-quotes support.
* - Added Export contacts DisplayName field (csv).
* - Added Import contacts status line feedback.
* - Added Import/Export SIM contacts (vCard only).
* - Added Copy from Phonebook to SIM w/phone type.
*
* Revision 1.87.2.6  2004/08/18 16:50:53  voxik
* Fixed New VBase and VProperty support
*
* Revision 1.87.2.5  2004/07/12 19:20:52  voxik
* Changed AAlarm parsing output
*
* Revision 1.87.2.4  2004/07/11 13:31:48  voxik
* Added vCalendar debug tools
*
* Revision 1.87.2.3  2004/07/02 18:26:10  z_stoichev
* Fixed FNodeCalendar lookup
*
* Revision 1.87.2.2  2004/07/02 16:31:48  voxik
* - Added Calendar event editing
* - Added Calendar sync
* - Changed VP DB support
*
* Revision 1.87  2004/06/19 16:10:57  lordlarry
* Memory leak fixed in Outlook Sync
*
* Revision 1.86  2004/06/19 15:44:52  lordlarry
* Added more Unicode support
*
* Revision 1.85  2004/06/19 11:18:45  z_stoichev
* - Added Fma Today cotext popup menu.
* - Changed Fma Today page hides explorer.
* - Changed Contact Group icons.
*
* Revision 1.84  2004/06/18 13:51:16  z_stoichev
* - Changed Fma Today hyperlinks Buttons.
* - Fixed New Message notification for K700 phones.
* - Added Keypad support K700 models as T610 clone.
*
* Revision 1.83  2004/06/17 13:28:37  z_stoichev
* uEditProfile usage
*
* Revision 1.82  2004/06/16 08:49:00  z_stoichev
* Fixed Use X button to minimize instead close.
* Fixed Disconnect on Windows logout/shutdown.
*
* Revision 1.81  2004/06/15 15:31:39  z_stoichev
* - Fixed 130 MB memory usage on startup.
* - Fixed Recent Missed Calls list management.
* - Fixed Several "is not integer value" issues.
* - Fixed Script Key Monitoring on startup.
* - Changed Load Outlook folders on need only.
* - Added Default contact DisplayName patterns.
* - Added Default Ringing sound support.
* - Added Default Busy sound support.
* - Added Handle RING signals (default sound).
* - Added Second Incoming call is ignored.
* - Added Cancel Incoming call silently support.
* - Added Cancel Outgoing call warning message.
*
* Revision 1.80  2004/06/11 12:30:42  z_stoichev
* Show info while loading Options (outlook folder issue).
*
* Revision 1.79  2004/06/08 19:31:55  lordlarry
* Memory Leak fixed
*
* Revision 1.78  2004/06/05 13:32:55  lordlarry
* Merged with OutlookSync branch
*
* Revision 1.77  2004/05/21 12:04:19  z_stoichev
* Profile context menu and properties.
* Split Fma Today page vertically.
* Key Monitoring bugfix.
* Signal and Battery status optimized.
*
* Revision 1.76  2004/05/21 10:09:05  z_stoichev
* Changed logging handle routines.
*
* Revision 1.75  2004/05/19 18:34:14  z_stoichev
* Build 0.1.0.35c
*
* Revision 1.74  2004/04/15 06:59:57  z_stoichev
* added  GetPartialNumber
*
* Revision 1.73  2004/04/01 15:34:46  z_stoichev
* New Calls data format support
* Unknown contact support
* Do not send message to unknown number
* Get contact display name by tel/name
*
* Revision 1.72  2004/03/31 07:05:20  z_stoichev
* Fixed Load phone database check and show error.
* Fixed New missed call when answered from phone.
* Fixed Show low battery warning after connect.
* Fixed Blink missed calls toolbar button every second.
* Changed Low battery show warning level < 2%,
* Changed Low battery auto-disconnect level < 1%.
* Changed Welcome page renamed to Fma Today.
* Added Fma toolar button for Welcome page.
* Added Main menu shortcut for Activity log.
*
* Revision 1.71  2004/03/28 22:11:17  z_stoichev
* GUI changes
* Add Fma Today toolbar button.
* Fixed wrong Missed cal when answer from phone.
*
* Revision 1.70  2004/03/26 18:37:39  z_stoichev
* Build 0.1.0.35 RC5
*
* Revision 1.69  2004/03/20 16:28:18  z_stoichev
* Changed All Explorer/menu icons (Stefan Jaeger).
* Added fma.ScriptCall(code) COMObject method.
* Added fma.Sleep(msec) COMObject method.
*
* Revision 1.68  2004/03/14 18:50:49  z_stoichev
* Fixed Execute disconnect events before exit.
* Added Refresh messages folder progress dialog.
* Added Send Text message command support check.
* Added Remember and auto-switch to last user Profile.
* Changed Copy/move to archive mark message as read.
* Changed Delayed diagram show on connect.
*
* Revision 1.67  2004/03/12 16:59:32  z_stoichev
* Fixed Long SMS refference number auto-increment.
* Obex Get/PutObject friendly name support.
* Bugfixes and improvements.
*
* Revision 1.66  2004/03/11 15:13:20  z_stoichev
* Fixed Databases mix up on phone change.
* Fixed Explore incorrect view set on database load.
* Fixed Progress dialog do not hide when diagram is shown.
* Fixed Script method call without params gives false error.
* Fixed A typo "garbadge" in Activity log.
* Fixed Note line breaks are not removed anymore.
*
* Revision 1.65  2004/03/09 15:08:59  z_stoichev
* Fixed Connect on startup waits script to initialize.
* Fixed Missed var declaration in Fma script functions.
* Fixed Refresh Phonebook issue when IrmcSync disabled.
* Fixed Load/Save phone database issues and bugfixes.
* Fixed Transmit scheduled AT while in Obex mode.
* Added Force save phone database after Refresh.
* Added Show group member's phone number in Explorer.
* Added Allow multiple member's numbers into a Group.
* Added Sanity check AT command data before transmit it.
* Added Script dialog exit/timeout event support.
* Changed GUI and various Phone explorer icons.
* Changed Do not ask for Outbox connection if Connect on startup option is activated.
*
* Revision 1.64  2004/03/08 13:11:45  z_stoichev
* Fixed Script object.method call with params executin.
* Fixed Web update mail mirror URL.
* Added Connect to Serial port by (user friendly) name.
* GUI changes.
*
* Revision 1.63  2004/03/07 22:12:03  z_stoichev
* Fixed Open SIM Database when Phonebook is selected issue.
* Fixed Holding No/Back button in AM issue.
* Fixed Hide Calling box on Proximity Away.
* Fixed Database folder name is OS safe (Motorolla IMEI issue).
* Fixed Timeout error triggered on unhandle AT response.
* Fixed Abort does not cancel Auto-reconnect feature.
* Added Scrit Object method call with parameters support.
* Added Web Update wizard, allow update/downgrade at once.
* Changed sleep mode while executing AT command.
* Changed Sync Phonebook button merged with Refresh button.
* Changed GUI colors and other Bugfixes.
*
* Revision 1.62  2004/03/07 11:49:08  z_stoichev
* Fixed bug 849905: '@' added at the end of text messages (SMS)
* Fixed Holding No/Back button in AM issue.
* Added Scrit Object calls parameters support.
* Added Web Update wizard, allow update/downgrade at once.
* Changed sleep mode while executing AT command.
* Changed GUI colors.
*
* Revision 1.61  2004/02/04 16:20:20  z_stoichev
* Added UOL.
*
* Revision 1.60  2004/02/04 13:40:58  z_stoichev
* Added Remove Missed call message from phone.
* Added Script object methods calling support.
* Fixed Script function call routines.
* Fixed Scheduled Script call empty func name.
* Fixed Scheduled AT command execute.
*
* Revision 1.59  2004/02/03 16:02:25  z_stoichev
* Fixed Diagram show/hide on proper place (AT) now.
* Fixed AT command execution with separated threads.
* Fixed Auto Re-connect with separated threads.
* Changed Execute AT commands moved into separate thread.
* Changed Script errors are not modal (see Debug/Activiry log now).
* Changed Script re-initialization proccess after script editing.
* Changed Script changes do not require Fma restart anymore.
*
* Revision 1.58  2004/01/30 16:44:57  z_stoichev
* Do not play sound on exit fixed.
*
* Revision 1.57  2004/01/30 16:39:59  z_stoichev
* Made ObexDelete work in silent mode.
* Fixed Minimum Fma toolbar width constraint.
* Fixed Do not ask twice for sending Outbox on exit.
* Fixed Refresh explorer view on message sent.
* Fixed Incorrect phone ID detected on folder change.
* Fixed Power diagram not visible after connect.
* Fixed Inbox/Get messages on startup shows Sent items.
* Fixed Send SMS failure due to too short timeout.
* Added Move new SMS to Archive removes it from phone.
* Added Debug tools option in main menu.
* Added Silent mode sending/deleteing Obex file.
* Changed Do not play Disconnected sound on exit.
*
* Revision 1.56  2004/01/28 17:46:02  z_stoichev
* Fixed New Person action enabled for SIM editor.
* Fixed Mark multiple messages as read/unread.
* Fixed Remember SIM entries state (modified etc).
* Changed No Build contact structure if no SyncIRMC.
* Added Phone memory Contacts editor if no SyncIRMC.
* Added Send modified contacts to phone before Refresh.
*
* Revision 1.55  2004/01/27 15:57:28  z_stoichev
* Fixed Sending long Text Messages frmo Outbox.
* Fixed Extra @ chars displayed for long Text messages.
* Fixed Timeout after Obex send object.
* Fixed Auto reconnect feature support.
* Removed Transmit script AT command scheduler.
* Added Save script code even on script error.
*
* Revision 1.54  2004/01/26 10:36:33  z_stoichev
* Changed TxAndWait implementation (build 29 merge).
* Fixed Clock sync with incorrect time zone.
* Fixed Auto reconnect feature support (not tested).
* Fixed Text Message send reported as unsent, while it was.
* Added Keypad support for SE T610.
* Fixed Send Text Message TP length calculation.
* Fixed Send Text Message Refference when sent.
* Fixed Upload Text Message to phone.
* Fixed EAMI command responces processing.
* Fixed AT Commands execution misplace.
* Fixed Accessories menu Transmit command.
* Fixed Connection failure if Obex fails.
* Added Main Menu changes, Import under tools.
* Added Upload SMS to phone for incoming ones.
* Added Call unknown number when no selection.
* Added Last call duration in Activity log.
*
* Revision 1.53  2004/01/15 14:14:51  z_stoichev
* Added SMS Counter and Warning level.
* Added Explorer Startup folder selection.
* GUI Changes.
*
* Revision 1.52  2004/01/14 15:04:59  z_stoichev
* Pascal Scripting support.
*
* Revision 1.51  2004/01/13 12:37:32  z_stoichev
* Fixed Keypress Monitoring (by Vit Ondruch)
*
* Revision 1.50  2003/12/22 17:37:47  z_stoichev
* Fixed Outbox send failure will delay...
* Restored Auto Updates Wizard mode (user req).
*
* Revision 1.49  2003/12/22 17:28:22  z_stoichev
* Fixed restore proximity status on exit.
* Fixed Timeout popup on connection loss.
* Connection loss check fixed in every 6 seconds.
* Outbox send failure will delay next attempt with 30 secs.
* Removed doubled "new message received" message.
*
* Revision 1.48  2003/12/19 10:04:44  z_stoichev
* Fixed Proximity/Connect issue on exiting Fma.
* Fixed Keyboard Lock/Unlock state on disconnect.
* Added second icon for Keyboard Lock/Unlock.
* Do not show release build in baloon tooltips.
* Do not show baloon tooltips on exiting Fma.
*
* Revision 1.47  2003/12/18 16:41:29  z_stoichev
* Fixed Store Sent Messages to Archive folder.
* Fixed Popup dialog remove on new message (T610).
* Fixed View Caption update on read/unread count change.
* Execute Keypad Event Reporting start/stop commands when busy.
* Keyboard lock/unlock support, added toolbar button and menu option.
* Fma Build shown on main application window's caption.
*
* Revision 1.46  2003/12/17 17:15:22  z_stoichev
* Added Option to turn off notifications for unsent messages.
*
* Revision 1.45  2003/12/17 16:59:26  z_stoichev
* Fixed Delete from message view removes random, but not only
* selected messages (saveing Draft error).
* Fixed Changes made in offline mode lost on connect.
* Fixed Obex freeze because of missplaced FlushOK calls.
* Added Script engine re-initialization on Options exit.
* Added Outbox and Drafts folders for Text Messages.
* Added Send Outbox messages menu command and toolbar button.
* Added Notifications for unsent messages in Outbox.
*
* Revision 1.44  2003/12/16 17:42:59  z_stoichev
* Fixed Option X button to minimize is not being remembered.
* Fixed New message not send to script function due to AV error.
* Fixed Missed call entry shown contact default number instead
* of real one (which was maded the call with).
* New Message received popup removed on phone (T610).
* Removed exception message box on connect error.
*
* Revision 1.43  2003/12/12 17:01:05  z_stoichev
* Removed dublicate Win XP theme support resource.
* Add support for no calls and no profiles on connect.
* sing new Audio Mixer component.
* Add support for deleteing Obex files.
* Frame view look can be customized.
* Check for phone timer interval set to 2 seconds.
*
* Revision 1.42  2003/12/11 15:09:47  z_stoichev
* Fixed Missed calls window list cleared on calls refresh.
* Moveing diagram to the start point on new connection.
* Files summary status information removed.
*
* Revision 1.41  2003/12/11 14:12:49  z_stoichev
* New functions for Obex folders/files.
* WaitASec moved here from uObex.
* Fixed No baloon on outgoing call.
* Detect Auto answering call with headset.
* Battery and Signal pool disabled during a call.
* Check for re-conect / startup connect disabled during a call.
* Automatic Updates url changed to sf.net.
* Automatic Updates doesn't hide main window now.
*
* Revision 1.40  2003/12/09 16:34:37  z_stoichev
* Added Baloon tooltip on Incoming call.
* Added units uStatusDlg and uVersion.
* Added support for Auto Updates.
* Removed warning for running multiple instances.
* Removed Note and Bookmark toolbar icons.
*
* Revision 1.39  2003/12/09 12:05:26  z_stoichev
* Build 0.10.28c + 29a changes without new WaitComplete unit.
*
* Revision 1.38  2003/12/08 10:37:08  z_stoichev
* Fixed KeyPad not enabled issue.
*
* Revision 1.37  2003/12/04 16:32:15  z_stoichev
* Fixed Home page click works again.
* Fixed Edit own card when no connection.
* Fixed auto re-connect feature.
* Fixed AV error on new connection timeout.
* Added Inbox new messages number into Explorer.
* Added timestamp to outgoing/archive messages.
* Added Fma forums web page link.
*
* Revision 1.36  2003/12/03 16:24:26  z_stoichev
* WaitComplete moved into separated thread.
* FlushOK now uses TxAndWait instead.
*
* Revision 1.35  2003/12/02 16:43:32  z_stoichev
* vCard usage changes.
* Added Connecting Obex property - Timers will check it.
* Fixed restore monitoring on app restore.
*
* Revision 1.34  2003/12/01 16:00:50  z_stoichev
* Fixed Exiting application when connecting.
* Fixed Pressing Enter triggers empty TX command.
* Fixed Wait for last command completion when
* disconnecting.
* Fixed Restore proximity status on disconnect.
* Update tray icon hint on phone rename.
* Changed connection tray icon animation.
* Added Edit own business card (Tools).
* Added calls folder refresh action.
* Changes calls and new contact icons.
*
* Revision 1.33  2003/11/28 09:38:06  z_stoichev
* Merged with branch-release-1-1 (Fma 0.10.28c)
*
* Revision 1.32.2.26  2003/11/27 16:09:26  z_stoichev
* Fixed bug 849698 Adding multiline notes add first line only.
* Fixed bug 850125 Delete New Message leaves it in Inbox.
* Fixed sending text message general error.
* Fixed show fatal errors on connect to prevent future
* operation execution.
* Added unicode support to Notes.
* Added sent message sound.
* Added Save draft button to New message window.
*
* Revision 1.32.2.25  2003/11/26 12:52:59  z_stoichev
* Upload multiple files at once.
*
* Revision 1.32.2.24  2003/11/26 12:30:18  z_stoichev
* Dont change explorer selection on reconnect.
* Select All now works with SIM conacts view.
* Fixed Battery and Signal resume on first status
* check when minimized.
* Fixed active call interrupted on new SMS.
* Removed 'times' from charge count info.
* Phone sync fixes.
* Fixed some typos.
*
* Revision 1.32.2.23  2003/11/21 16:36:46  z_stoichev
* Removed test code.
*
* Revision 1.32.2.22  2003/11/21 16:22:08  z_stoichev
* Fixed new message stops Pooling timer issue.
* Fixed AV error when startup connection is aborted.
* Fixed connect on startup option clear flag on failure.
* Fixed New messages processing routines.
* Fixed random false Phone disconnected message.
* Fixed new Missing call display format.
* Fixed last Explorer node was not explored (was ignored).
* Fixed some memory leaks.
* Fixed (maybe, not tested) clear message box in phone
* when new text message is received.
* Battery and Signal monitoring disabled when minimized.
* Show main Windows (if needed) on startup connection.
* Phone clock sync add messages to sync log.
* Phone clock sync show error baloon only on update fail.
* Startup operations processed after connect operation.
* Show new message baloon only if new msg queue is empty.
* New message is processed on every second, not all at once.
* Forward message sets cursor position at the end of text.
* Added blinking toolbar icon on new missing calls.
* Added Web links in Help menu.
*
* Revision 1.32.2.21  2003/11/19 15:13:31  z_stoichev
* Fixed proximity loop calls and missing Proximity Near
* execution when a new phone is connected.
* Fixed load database settings for new phone (do not
* keep previous phone settings, but allow upgrade from
* single phone database Fma version).
* Fixed Auto-reconnect disables popup notifications.
* Auto-reconnect and New message routines moved in
* separated Timer, not using Pooling timer anymore.
* New one is faster and will not blink toolbar Buttons.
*
* Revision 1.32.2.20  2003/11/14 15:41:02  z_stoichev
* Updates for patch 27d.
*
* Revision 1.32.2.19  2003/11/13 17:57:56  z_stoichev
* Update to patch 27c.
*
* Revision 1.32.2.18  2003/11/12 16:58:39  z_stoichev
* Add new icons and replace some old.
* Proximity can run Screensaver now.
* Proximity test implemented.
* Phone can temporary disconnect if Headset clicked.
* Download all messages on Text Messages Refresh.
* Save database files on phonebook change.
* Add voice call to sender from messages view.
* Fixed volume and mute control.
* Render SIM phonebook view on database load.
*
* Revision 1.32.2.17  2003/11/11 13:54:08  z_stoichev
* Add personalization support.
* Add text messages options: no popup, no baloon,
* and move to archive.
* Show progress on download all messages.
* Add option for Show progress only if Restored.
* Memeber sort mode when switching folders.
* Fixed delete from group.
* Don't delete SMS on phone when CNMI mode
* 3 is used (forward messages only).
* Refresh view when exit from Options.
* Hide baloons on 3rd connect failure.
* Volume control fixed.
*
* Revision 1.32.2.16  2003/11/10 16:24:59  z_stoichev
* Fixed: changes are lost on re-connect.
*
* Revision 1.32.2.15  2003/11/10 14:03:10  z_stoichev
* RC3
*
* Revision 1.32.2.14  2003/11/07 16:41:18  z_stoichev
* Fixed phone clock zone missing issue (S55).
* SIM phonebook view/editor recoded.
*
* Revision 1.32.2.13  2003/11/07 11:27:40  z_stoichev
* Added common wizard image.
* Replaced some toolbar images.
* AddToGroup method created.
* Connect on synchronization, if not
* already connected.
*
* Revision 1.32.2.12  2003/11/06 16:33:12  z_stoichev
* Action update state changed alot.
* Abort action Esc hotkey removed.
* Fixed Add to Group with non-english chars in
* contact names.
* Added HTML converter (+ XML '&apos;' named
* character support).
* Added a Calls folder in Phone explorer (not finished
* yet).
* Added Select All action for phonebook entries.
* Added Send message and Voice call to contacts
* and phones into Explorer and default view Windows.
* Added Battery and Charging Algorithm support check.
* Explorer Obex folder types auto-detection.
* Obex file type auto-detection.
* Don't say Connection Loss on user Abort.
* New images added.
* Bugfixes.
*
* Revision 1.32.2.11  2003/11/04 15:56:47  z_stoichev
* FindPBbyName unicode support.
* Update def explorer view on connect.
* Don't show baloons on auto-connect.
* Fix profiles toolbar left shift on folder click.
* Obex folders type auto-detection.
* Don't say Connection lost on Abort.
* Add some debug messages.
* Fixed typos.
*
* Revision 1.32.2.10  2003/10/31 15:02:15  z_stoichev
* Ask for retry if Obex is already used by another app.
* Load missed calls from phone.
* Add headset button for incoming calls.
*
* Revision 1.32.2.9  2003/10/30 15:32:04  z_stoichev
* Execute AT command semafor usage.
* Get Operator error shown as "unknown operator".
*
* Revision 1.32.2.8  2003/10/30 13:31:57  z_stoichev
* Fixed on connection steps are non-fatal.
* Fixed execute phone command semafor usage.
* Fixed minimize/restore on double-click when
* Win+D, Win+M is pressed.
* Fixed sending SMS to groups will select the
* default number for any group memeber.
* Fixed phone number positions cache update.
* Abort works only if command is executing.
*
* Revision 1.32.2.7  2003/10/29 16:27:03  z_stoichev
* SMS Status Report is detected from phone.
* Fixed recoursive grouping name retrieval.
* Fixed Groups loading is times faster (you
* may have to refresh your phonebook, so the
* phone positions are available).
* Fixed Explorer update on contact change.
* Fixed reload settings on restore issue.
* Battery and Signal color scheme and font
* are changed (by user request).
* Added Send message to Group (not finished yet,
* will select first contact number, which may
* not be the proper one).
* Added options for Startup loading of groups
* and Folders (by user request).
* Added options to disable Obex and IrmcSync
* Thus disabling synchronization at all,
* only full phonebook refresh is done.
* Show Sent message to Name not to Number.
*
* Revision 1.32.2.6  2003/10/29 12:09:28  z_stoichev
* Fixed recoursive grouping name retrieval.
* Fixed Groups loading is times faster (you
* may have to refresh your phonebook, so the
* phone positions are available).
* Fixed reload settings on restore issue.
* Battery and Signal color scheme and font
* are changed (by user request).
*
* Revision 1.32.2.5  2003/10/28 15:24:14  z_stoichev
* Added new frame for default explorer view.
*
* Revision 1.32.2.4  2003/10/28 13:07:08  z_stoichev
* Connect even if build contact structure fail
* and use the default settings.
* Fixed Groups mixed content/add to group.
* Fixed clock synchronization error.
* Clock sync is optional.
* Changed battery est. time calculation.
* Play connected sound on last connect step.
* Always scroll Debug and Avtivity log to the
* last line and remove empty last line.
* Images changed.
*
* Revision 1.32.2.3  2003/10/27 17:08:12  z_stoichev
* If folder Browsing fails, connect will continue without this feature.
* Trying to sync phone clock will first try to connect if not connected.
* Fixed auto-connect looping/messages.
* On auto-connect failure show only debug information
* message instead of error one.
* Battery time left calculation tuned up.
* When charging battery time left indicates time
* until charge will complete. Show 'Done' when ready.
* Separator line removed on profiles popup menu.
* Check for stray OK is always called, even on errors.
*
* Revision 1.32.2.2  2003/10/27 09:50:55  z_stoichev
* Prerelease bug-fixes.
*
* Revision 1.32.2.1  2003/10/27 07:22:54  z_stoichev
* Build 0.1.0 RC1 Initial Checkin.
*
* Revision 1.32  2003/10/24 16:57:20  z_stoichev
* Fixed "ATI phone" issue.
*
* Revision 1.31  2003/10/24 14:24:24  z_stoichev
* Fixed errors on startup when the script file is missing.
*
* Revision 1.30  2003/10/24 13:04:00  z_stoichev
* Added some new images.
* Added profiles folder containing all phone profiles.
* Diagram is cleared on connect.
* Ask for item (contact, sms) deletion.
* Fixed: "don't warn for SMS to archive" option was ignored.
* Show baloon tooltip on profile change.
* Preserve messages view and contacts view sort order.
* Last empty line in debug log is removed.
*
* Revision 1.29  2003/10/22 13:25:35  z_stoichev
* Make SMS to Archive warning optional.
* Make progress indicator optional.
* Show progress on Phonebook download.
* Clerar some vars on destroy, and add some
* checks on usage.
* Make LoadOptions exceptions silent.
*
* Revision 1.28  2003/10/21 15:35:49  z_stoichev
* Battery and Signal status border removed.
* Code clean up.
*
* Revision 1.27  2003/10/21 13:46:15  z_stoichev
* Show debug log only once on program startup.
* Added "Show debug log" item in help menu if -debug
* option is present.
* Added "Fma on the web" link in Help menu.
* New icons added in ImageList2.
* Bug-fixes.
*
* Revision 1.26  2003/10/21 12:39:33  z_stoichev
* Changed Obex Get method result value to cardinal.
* Show baloon tooltip on new SMS message for 1 min.
* Some display messages changed.
*
* Revision 1.25  2003/10/20 09:40:49  z_stoichev
* Fixed some typo errors.
* Minimize/restore animation bugfixes
* and it's temporary disabled now.
* Reverted to old tray area icons.
*
* Revision 1.24  2003/10/16 15:31:19  z_stoichev
* Now diagram shows last 1 minute of statistics.
* Charge is shown on battery's axe, because
* they have similar values.
* Battery and Signal indicators have new font color
* and text labels, and they are read immediately on
* startup, not waiting for timer trigger (first time only).
*
* Revision 1.23  2003/10/16 09:55:40  z_stoichev
* Added CoolTrayIcon component reference.
* Tray Icon is always visible, and appears after
* Explorer crash, and with new icons (t610).
* Minimize to tray area animation is added.
* Baloon tooltip support with various info/error.
* Missed calls shows baloon tooltip for 1 minute.
* Explorer shows the phone model.
* Bugfixes; some try-finally stats are included.
*
* Revision 1.22  2003/10/15 15:51:56  z_stoichev
* Missed Calls Unicode support.
* Missed Calls button is always visible until
* the list of missed calls is cleared.
* Added explorer folders for sounds, pics etc.
* Post bookmark added to main menu.
*
* Revision 1.21  2003/10/15 11:11:21  z_stoichev
* Fixed bug 823902: Move SMS from Archive to Phone/SIM.
*
* Revision 1.20  2003/10/14 15:05:10  z_stoichev
* Fixed tray icon bug 672426.
* OnShow routines moved to new method called StartupInitialize.
* If Obex is not supported Phonebook refresh works without it.
* Debug log is updated even if Debug window is closed (if start
* minimized).
*
* Revision 1.19  2003/10/14 13:01:07  z_stoichev
* Abort will not cancel future Obex sessions.
* Unit SentSMS moved to uComposeSMS
* which uses Address book etc.
*
* Revision 1.18  2003/10/14 10:26:14  z_stoichev
* Fixed multiple Synchronization Log Windows issue.
* Synchronization Log is updated in realtime.
* Unit SentSMS renamed to uComposeSMS.
*
* Revision 1.17  2003/10/14 08:14:31  z_stoichev
* Fixed Monitoring activation on Options exit.
* Sony Ericsson progress bar usage on connect.
* Fixed pooling on disconnect/out of range.
* Abort can interrupt connecting now.
*
* Revision 1.16  2003/10/13 14:19:38  z_stoichev
* Modified to reflect changes in Obex methods.
* Added is bookmark posting.
* Posting note has a new field Class.
* Connect to phone progress dialog.
*
* Revision 1.15  2003/10/10 13:26:54  z_stoichev
* Phonebook refresh means sync.
* Sync is faster, refresh only on changes.
* Some icons remade.
* Fix on disconnect when no device.
*
* Revision 1.14  2003/10/09 15:10:29  z_stoichev
* Unicode support in tree vew explorer.
* UTF-8 and UTF-7 support for vCard and Phonebook
* entries (allow cyrillic etc. symbols).
*
* Revision 1.13  2003/10/09 10:17:10  z_stoichev
* Trying to set UTF-8 or Latin-1 character sets
* if they are supported by phone (in that order).
* UTF-8 (cyrillic etc.) support for Profile names
* using Latin-1 displays names as "???????".
* Connection initialization on connect/disconnect
* in order to reset changes made by previous
* session (ATZ).
*
* Revision 1.12  2003/10/08 11:03:22  z_stoichev
* New Message Indicator Mode detection and proper use.
* Will not display error message on long operations as
* entering a PIN code.
* SIM status is retrieved and shown in status bar on connect
* allowing Emergency Mode (not used yet) if SIM is absent.
*
* Revision 1.11  2003/08/31 07:26:48  bufflig
* Added alternative export file dialogue to accomodate vCard export
* of contacts, SaveDialog2.
* Fixed minor bug regarding missed calls, stack variable was expected to keep
* value between calls. Could make missed calls not beeing registered. Now
* class variable is used instead.
* Removed some unused variables etc, reducing warnings at compile time.
*
* Revision 1.10  2003/08/11 18:06:49  bufflig
* Support for voice dialling on T300 series by using old fasioned
* AT commands on phones that dont support AT*EVD and friends.
* Also fixed bug 716685, the disappearing HangUp button.
*
* Revision 1.9  2003/07/18 12:27:48  bufflig
* Added routine to flush a stray OK that SE T300/310 with software R3B sometimes
* outputs after OBEX session is ended. Makes synchronize work on these phones.
*
* Revision 1.8  2003/07/02 12:32:01  crino77
* RefreshPhoneBook for refresh after sync
* statemonitor
* x to minimize
* fixed bug in call popup
* All archive file must be in exe path
* Unicode in profile
* fixed bug in missed calls
* added edit profile in Tool menu
*
* Revision 1.7  2003/02/26 13:27:25  crino77
* Added winxp.res reference
*
* Revision 1.6  2003/02/17 06:56:51  crino77
* Added support for missed calls
*
* Revision 1.5  2003/02/14 14:09:27  crino77
* Modified SentMessage to get the MessRef
* Modified procedure SendMessage for long sms support;
* Added synclog button on toolbar and menurmes
* Added sync button on toolbar and menu
* Added AutoConnect feature in Form1.SHOW;
* Added Sync Conflict storage
* Added -DEBUGOBEX to debug Obex transaction
* Bug "List out of bounds (16)" solved - HandleEBCA  add try/except on cycles times ;)
* Added ActionExportSMS
* Added some public function:
*      - ObexGetObject(Path: Widestring): TStream;
*      - ObexPutObject(Path: Widestring; Stream: TStream): TStream;
* Added public procedure ObexDisconnect;
*
* Revision 1.4  2003/01/30 04:15:57  warren00
* Updated with header comments
*
*
*******************************************************************************
}

interface

{$R WinXP.res}

uses
{$IFDEF VER150}
  XPStyleActnCtrls,
{$ELSE}
  ThemeMgr, TntThemeMgr,
{$ENDIF}
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics,
  Controls, TntControls, Forms, TntForms, Dialogs, TntDialogs, StdCtrls, TntStdCtrls, ComCtrls, TntComCtrls,
  UniTntCtrls, ExtCtrls, TntExtCtrls, ToolWin, ActnList, TntActnList, Menus, TntMenus, ShellAPI, uSMS, ImgList,
  DateUtils, ActnMan, ActnCtrls, ActnMenus, AppEvnts, StdActns, TntStdActns, Placemnt, Registry, WinSock, IniFiles,
  Buttons, TntButtons, VirtualTrees, uObex, uExploreView, uWaitComplete, LMDCustomComponent, LMDOneInstance,
  LMDControl, LMDBaseControl, LMDBaseGraphicControl, LMDGraphicControl, LMDBaseMeter, LMDCustomProgressFill,
  LMDProgressFill, LMDHookComponent, LMDFMDrop, WSocket, WBluetoothSocket, WIrCOMMSocket, mmsystem, uAccessoriesMenu,
  uMissedCalls, uKeyPad, CoolTrayIcon, WebUtil, jpeg, AMixer, LMDFill, WebUpdate, aw_SCtrl, CPort, uScriptEditor,
  uContactSync, uChatSMS, GR32_Image, uFiles, uSyncCalendar, PBFolderDialog, uSIMEdit, uMEEdit, uMsgView, uInfoView,
  uXML, uSyncPhonebook, uSyncBookmarks, uVCard, uLog, uLogger, SEProgress, USBMonitor;

const
  LongOperationsTimeout = 45000; // 45 seconds (for searching in phone book, sending messages etc.)

  __fma_objcall = 'FmaInternalObjectCall'; // do not localize

  FMA_HANDLEMESSAGE = WM_USER + 100;

  FmaMessagesRootFlag  = $200000;
  FmaMessageFolderFlag = $080000; // added to Explorer.Node's stateindex

  FmaSMSSubFolderFlag  = FmaMessagesRootFlag or FmaMessageFolderFlag;
  FmaNodeSubitemsMask  = $0F0000;

type
  TConfirmation = (cfNone, cfYesToAll, cfNoToAll);
  TFindContactMode = (fcByNumber, fcByName);
  TFindContactResult = (frNone, frIrmcSync, frPhonebook, frSIMCard);

  TFmaHandleMessage = record
    Msg: Cardinal;
    Message: PChar;
    Length: Longint;
    Result: Longint;
  end;

  PFmaExplorerNode = ^TFmaExplorerNode;
  TFmaExplorerNode = record
    Data: Pointer;
    Text: WideString;
    ImageIndex, StateIndex: Integer;
    SpecialImages: Cardinal;
    { specialImages:Cardinal = $ ST M1 M2 NC
        ST - standard imageIndex
        M1 - mouseOver1 imageIndex
        M2 - mouseOver2 imageIndex
        NC - not connected imageIndex }
    SpecialImagesFlags: Byte;
    { specialImagesFlags:Byte = $ FL
        FL - flags::
          $01: use image and perform action on click
          $02: use mouseOver1 image
          $04: use disconnected image
          $08: use mouseOver1 image if disconnected (in combination with 4)
          $10: use mouseOver2 image if disconnected (in combination with 4)
          $20: perform action if disconnected  (in combination with 4)
          $40: ignore ThreadSafe's Busy state on perform action
          $80: show SpecialImages as number

        // action that should be performed has to be set in ExplorerNewClick }
  end;

  TStartupOptions = record
    NoObex,NoIRMC,NoGroups,NoFolders,NoProfiles,NoCalls,NoAlarms,NoBaloons,NoClock: boolean;
  end;
  TProximityOptions = record
    AwayLock,NearUnlock,RunSS: boolean;
    AwayMusicMode,NearMusicMode: integer;
  end;
  TTextMessageOptions = record
    NoPopup,NoBaloon,MoveToArchive,FullWarning: boolean;
  end;
  TCallOptions = record
    NoPopup,NoBaloon: boolean;
  end;

  TProfileLoadCallback = procedure (Pos,Max: Integer);

  TForm1 = class(TTntForm)
    StatusBar: TTntStatusBar;
    CoolBar: TCoolBar;
    ActionList1: TTntActionList;
    ActionConnectionConnect: TTntAction;
    ActionConnectionDisconnect: TTntAction;
    ImageList1: TImageList;
    ActionContactsDownload: TTntAction;
    Splitter1: TTntSplitter;
    PopupMenu1: TTntPopupMenu;
    Refresh3: TTntMenuItem;
    ActionConnectionDownload: TTntAction;
    ActionSMSArchiveMsg: TTntAction;
    ActionSelectAll: TTntAction;
    ActionDelete: TTntAction;
    ActionSMSMoveMsgToArchive: TTntAction;
    ActionSMSNewMsg: TTntAction;
    ActionContactsNewMsg: TTntAction;
    NewMessage2: TTntMenuItem;
    ActionSMSReplyMsg: TTntAction;
    ActionSMSForwardMsg: TTntAction;
    ActionConnectionToggle: TTntAction;
    ActionContactsVoiceCall: TTntAction;
    Call1: TTntMenuItem;
    Timer1: TTimer;
    ApplicationEvents1: TApplicationEvents;
    trayMenu: TTntPopupMenu;
    Connect1: TTntMenuItem;
    NewMessage1: TTntMenuItem;
    MainMenu1: TTntMainMenu;
    Connection1: TTntMenuItem;
    Connect2: TTntMenuItem;
    Disconnect1: TTntMenuItem;
    Refresh1: TTntMenuItem;
    N5: TTntMenuItem;
    Exit1: TTntMenuItem;
    Action2: TTntMenuItem;
    MessagetoContact1: TTntMenuItem;
    NewMessage3: TTntMenuItem;
    Reply2: TTntMenuItem;
    Forward2: TTntMenuItem;
    Delete2: TTntMenuItem;
    N8: TTntMenuItem;
    CopytoArchive1: TTntMenuItem;
    MovetoArchive2: TTntMenuItem;
    N9: TTntMenuItem;
    SelectAll1: TTntMenuItem;
    Help1: TTntMenuItem;
    About1: TTntMenuItem;
    ImageList2: TImageList;
    ActionAbout: TTntAction;
    ActionWindowRestore: TTntAction;
    ShowRestore1: TTntMenuItem;
    Exit2: TTntMenuItem;
    FormStorage1: TFormStorage;
    ActionToolsOptions: TTntAction;
    Tools1: TTntMenuItem;
    Options1: TTntMenuItem;
    ActionConnectionMonitor: TTntAction;
    Monitor1: TTntMenuItem;
    ActionConnectionAutoConnect: TTntAction;
    AutoConnect1: TTntMenuItem;
    tbStandard: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    RefreshToolButton: TToolButton;
    ScriptControl: TawScriptControl;
    ActionToolsEditScript: TTntAction;
    EditScript1: TTntMenuItem;
    ObexOpenDialog: TTntOpenDialog;
    ActionConnectionAbort: TTntAction;
    N16: TTntMenuItem;
    Abort1: TTntMenuItem;
    ActionToolsUpload: TTntAction;
    Upload1: TTntMenuItem;
    ToolButton13: TToolButton;
    ActionToolsPostNote: TTntAction;
    Postanote1: TTntMenuItem;
    LMDOneInstance1: TLMDOneInstance;
    LMDFMDrop: TLMDFMDrop;
    tbProfile: TToolBar;
    cbProfile: TTntComboBox;
    ToolButton11: TToolButton;
    ActionSMSDownloadInbox: TTntAction;
    ActionToolsEditProfile: TTntAction;
    WBtSocket: TWBluetoothSocket;
    WIrSocket: TWIrCOMMSocket;
    ActionSMSExport: TTntAction;
    ExportSMS1: TTntMenuItem;
    SaveDialog1: TTntSaveDialog;
    ToolButton14: TToolButton;
    ActionSyncPhonebook: TTntAction;
    StartSyncPhoneBook1: TTntMenuItem;
    Sync1: TTntMenuItem;
    ToolButton16: TToolButton;
    ActionMissedCalls: TTntAction;
    ActionMissedCalls1: TTntMenuItem;
    ActionToolsKeyPad: TTntAction;
    KeyPad1: TTntMenuItem;
    ActionExit: TTntAction;
    ActionContactsExportME: TTntAction;
    ExportContacts1: TTntMenuItem;
    ActionToolsEditProfile1: TTntMenuItem;
    SaveDialog2: TTntSaveDialog;
    ActionToolsPostBookmark: TTntAction;
    Postbookmark1: TTntMenuItem;
    CoolTrayIcon1: TCoolTrayIcon;
    ImageList3: TImageList;
    ActionWindowMinimize: TTntAction;
    FmaOnSFNet1: TTntMenuItem;
    ActionToolsChangeProfile: TTntAction;
    ActionToolsDownload: TTntAction;
    ObexSaveDialog: TTntSaveDialog;
    Download2: TTntMenuItem;
    PanelExplorer: TTntPanel;
    PanelFolders: TTntPanel;
    SpeedButton1: TTntSpeedButton;
    ViewExplorer1: TTntMenuItem;
    ActionConnectionExplorer: TTntAction;
    SyncPhoneClock1: TTntMenuItem;
    ActionExplorerUpFolder: TTntAction;
    ActionContactsNewPerson: TTntAction;
    newcontact1: TTntMenuItem;
    Properties1: TTntMenuItem;
    tbMessages: TToolBar;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton29: TToolButton;
    ToolButton30: TToolButton;
    tbCalls: TToolBar;
    ToolButton17: TToolButton;
    ToolButton10: TToolButton;
    ActionEditGoUp: TTntAction;
    ActionEditGoDown: TTntAction;
    FramePanel: TTntPanel;
    PanelTest: TTntPanel;
    TntPageControl1: TTntPageControl;
    TntTabSheet2: TTntTabSheet;
    Memo3: TTntMemo;
    Button3: TTntButton;
    cbTerminal: TTntComboBox;
    TntTabSheet1: TTntTabSheet;
    Label1: TTntLabel;
    Image: TTntImage;
    Label4: TTntLabel;
    Label5: TTntLabel;
    Memo2: TTntMemo;
    Memo1: TTntMemo;
    Button1: TTntButton;
    Button2: TTntButton;
    Edit2: TTntEdit;
    RadioButton1: TTntRadioButton;
    RadioButton2: TTntRadioButton;
    cbObex: TTntComboBox;
    Button10: TTntButton;
    Button11: TTntButton;
    TntTabSheet3: TTntTabSheet;
    Label2: TTntLabel;
    Label3: TTntLabel;
    TntEdit1: TTntEdit;
    TntEdit2: TTntEdit;
    Button4: TTntButton;
    Button5: TTntButton;
    Button6: TTntButton;
    Button7: TTntButton;
    Button8: TTntButton;
    Button9: TTntButton;
    Button12: TTntButton;
    DescrPanel: TTntPanel;
    Panel1: TTntPanel;
    ToolButton21: TToolButton;
    AudioMixer1: TAudioMixer;
    lblCurrentPage: TTntLabel;
    PopupMenu2: TTntPopupMenu;
    ShowExplorer1: TTntMenuItem;
    N14: TTntMenuItem;
    ImageList4: TImageList;
    LMDFill1: TLMDFill;
    View1: TTntMenuItem;
    MsgPreview1: TTntMenuItem;
    ActionViewMsgPreview: TTntAction;
    Timer2: TTimer;
    FmaOnTheWeb1: TTntMenuItem;
    FmaOnTheWeb2: TTntMenuItem;
    ActionContactsAddContact: TTntAction;
    EditOwnCard1: TTntMenuItem;
    ActionContactsOwn: TTntAction;
    N6: TTntMenuItem;
    SyncOutlook1: TTntMenuItem;
    SyncBookmarks1: TTntMenuItem;
    N13: TTntMenuItem;
    FmaOnForums1: TTntMenuItem;
    N22: TTntMenuItem;
    CheckforUpdate1: TTntMenuItem;
    N25: TTntMenuItem;
    N26: TTntMenuItem;
    SendOutboxMessages1: TTntMenuItem;
    ToolButton3: TToolButton;
    ToolButton25: TToolButton;
    ActionConnectionSendOutboxMsgs: TTntAction;
    ActionToolsKeybLock: TTntAction;
    ToggleKeyboardLock1: TTntMenuItem;
    pbRSSI: TLMDProgressFill;
    pbPower: TLMDProgressFill;
    Label6: TTntLabel;
    ActionSMSImport: TTntAction;
    ActionContactsImportME: TTntAction;
    Export1: TTntMenuItem;
    ImportSMS1: TTntMenuItem;
    ImportContacts1: TTntMenuItem;
    DebugTools1: TTntMenuItem;
    Timer3: TTimer;
    FmaWebUpdate1: TFmaWebUpdate;
    ActionSyncWithOutlook: TTntAction;
    N29: TTntMenuItem;
    swprofile1: TTntMenuItem;
    ActionSwitchUserProfile: TTntAction;
    ToolButton15: TToolButton;
    lblCurrentPageDtls: TTntLabel;
    activitylog1: TTntMenuItem;
    ActionViewLog: TTntAction;
    ComPort: TComPort;
    tbMainMenu: TToolBar;
    ToolButton36: TToolButton;
    ToolButton4: TToolButton;
    ActionSyncCalendar: TTntAction;
    ShowCaption1: TTntMenuItem;
    ShowDiagram1: TTntMenuItem;
    ActionContactsExportSM: TTntAction;
    ActionContactsExport: TTntAction;
    ActionContactsImportSM: TTntAction;
    ActionContactsImport: TTntAction;
    ActionContactsNewChat: TTntAction;
    ToolButton31: TToolButton;
    ChatContact1: TTntMenuItem;
    ChatContact2: TTntMenuItem;
    N11: TTntMenuItem;
    ActionToolsWapHomepage: TTntAction;
    EditWapHomePage1: TTntMenuItem;
    EditFavorites1: TTntMenuItem;
    Edit1: TTntMenuItem;
    EditCallFavorites1: TTntMenuItem;
    ToolButton32: TToolButton;
    ActionContactsVoiceHangup: TTntAction;
    N12: TTntMenuItem;
    ToolButton33: TToolButton;
    ActionToolsCreateGroup: TTntAction;
    NewGroup2: TTntMenuItem;
    CommonBitmaps: TBitmap32List;
    ActionToolsSilent: TTntAction;
    ToggleSilentMode1: TTntMenuItem;
    N2: TTntMenuItem;
    N4: TTntMenuItem;
    PowerOffPhone1: TTntMenuItem;
    ActionToolsPowerOff: TTntAction;
    SyncPhoneCalendar1: TTntMenuItem;
    Button13: TTntButton;
    CallContact1: TTntMenuItem;
    NewNote1: TTntMenuItem;
    NewBookmark1: TTntMenuItem;
    N24: TTntMenuItem;
    NewPerson1: TTntMenuItem;
    PhoneContacts1: TTntMenuItem;
    Synchronize1: TTntMenuItem;
    PhoneCalendar1: TTntMenuItem;
    OutlookContacts1: TTntMenuItem;
    HangupCall1: TTntMenuItem;
    Upload2: TTntMenuItem;
    N30: TTntMenuItem;
    N33: TTntMenuItem;
    Refresh2: TTntMenuItem;
    ActionSyncBookmarks: TTntAction;
    ActionToolsMinuteMinder: TTntAction;
    ToggleMinuteMinder1: TTntMenuItem;
    HangupCall2: TTntMenuItem;
    CallContact2: TTntMenuItem;
    Phone1: TTntMenuItem;
    N37: TTntMenuItem;
    NewGroup3: TTntMenuItem;
    N28: TTntMenuItem;
    PhoneBookmarks1: TTntMenuItem;
    PhoneClock2: TTntMenuItem;
    tbPhone: TToolBar;
    ToolButton37: TToolButton;
    ToolButton38: TToolButton;
    ToolButton39: TToolButton;
    Toolbars1: TTntMenuItem;
    ActionViewTBStandard: TTntAction;
    ActionViewTBPhone: TTntAction;
    ActionViewTBCalls: TTntAction;
    ActionViewTBMessages: TTntAction;
    ActionViewTBProfile: TTntAction;
    ActionViewTBStandard1: TTntMenuItem;
    ActionViewTBPhone1: TTntMenuItem;
    ActionViewTBCalls1: TTntMenuItem;
    ActionViewTBMessages1: TTntMenuItem;
    ActionViewTBProfile1: TTntMenuItem;
    tbExplorer: TToolBar;
    ToolButton27: TToolButton;
    ToolButton19: TToolButton;
    ToolButton34: TToolButton;
    ToolButton22: TToolButton;
    ToolButton24: TToolButton;
    ToolButton35: TToolButton;
    ToolButton40: TToolButton;
    ToolButton41: TToolButton;
    ToolButton9: TToolButton;
    ToolButton12: TToolButton;
    ToolButton20: TToolButton;
    ActionViewTBExplorer: TTntAction;
    Explorer1: TTntMenuItem;
    GettingStarted1: TTntMenuItem;
    N40: TTntMenuItem;
    AddToPhonebook1: TTntMenuItem;
    TntButton1: TTntButton;
    TntButton2: TTntButton;
    TntButton3: TTntButton;
    TntButton4: TTntButton;
    TntButton5: TTntButton;
    ToolButton26: TToolButton;
    ActionViewProperties: TTntAction;
    MyMenu1: TTntMenuItem;
    pbTask: TSEProgress;
    N10: TTntMenuItem;
    ActionSyncClock: TTntAction;
    AddNewFolder1: TTntMenuItem;
    ActionViewAddFolder: TTntAction;
    ActionViewDelFolder: TTntAction;
    DeleteFolder1: TTntMenuItem;
    AddNewFolder2: TTntMenuItem;
    DeleteFolder2: TTntMenuItem;
    N23: TTntMenuItem;
    Properties2: TTntMenuItem;
    AddToPhonebook2: TTntMenuItem;
    N39: TTntMenuItem;
    Export2: TTntMenuItem;
    N27: TTntMenuItem;
    N17: TTntMenuItem;
    Favorites1: TTntMenuItem;
    ImportBookmarks1: TTntMenuItem;
    ExportBookmarks1: TTntMenuItem;
    N15: TTntMenuItem;
    SynchronizeAll1: TTntMenuItem;
    PhoneTextMessages1: TTntMenuItem;
    ImportRules1: TTntMenuItem;
    ExportRules1: TTntMenuItem;
    ActionSMSToFolder: TTntAction;
    ToolButton28: TToolButton;
    ToolButton42: TToolButton;
    N19: TTntMenuItem;
    N21: TTntMenuItem;
    N20: TTntMenuItem;
    ActionSyncAll: TTntAction;
    ActionSyncMessages: TTntAction;
    PhoneTextMessages2: TTntMenuItem;
    RulesSaveDialog: TTntSaveDialog;
    ActionRulesExport: TTntAction;
    RulesOpenDialog: TTntOpenDialog;
    DeliveryRules1: TTntMenuItem;
    Proximity1: TTntMenuItem;
    ScriptingOptions1: TTntMenuItem;
    LanguageOptions1: TTntMenuItem;
    N1: TTntMenuItem;
    ActionSMSDelivery: TTntAction;
    DeliveryRules2: TTntMenuItem;
    DeliveryRules3: TTntMenuItem;
    MissedCallsTrayIcon: TCoolTrayIcon;
    NewMessageTrayIcon: TCoolTrayIcon;
    Index1: TTntMenuItem;
    Search1: TTntMenuItem;
    ExplorerNew: TVirtualStringTree;
    DeviceMonitorUSB1: TDeviceMonitorUSB;
    ActionPlayerTogglePlay: TTntAction;
    ToolButton43: TToolButton;
    SearchMessages1: TTntMenuItem;
    ActionViewMsgSearch: TTntAction;
    ToolButton44: TToolButton;
    GettingStarted2: TTntMenuItem;
    N18: TTntMenuItem;
    ActionToolsPostAlarm: TTntAction;
    NewAlarm1: TTntMenuItem;
    Create1: TTntMenuItem;
    N31: TTntMenuItem;
    Message1: TTntMenuItem;
    N35: TTntMenuItem;
    Create2: TTntMenuItem;
    NewAlarm2: TTntMenuItem;
    N32: TTntMenuItem;
    N7: TTntMenuItem;
    N34: TTntMenuItem;
    pmToolbars: TTntPopupMenu;
    ToolButton18: TToolButton;
    DatabaseManager1: TTntMenuItem;
    LabeledEdit1: TLabeledEdit;
    TntButton6: TTntButton;
    ActionToolsExportCalendar: TTntAction;
    ActionToolsImportCalendar: TTntAction;
    ImportCalendar1: TTntMenuItem;
    ExportCalendar1: TTntMenuItem;
    procedure ActionConnectionConnectExecute(Sender: TObject);
    procedure ActionConnectionDisconnectExecute(Sender: TObject);
    procedure ActionConnectionDownloadExecute(Sender: TObject);
    procedure ActionContactsDownloadExecute(Sender: TObject);
    procedure ActionConnectionToggleExecute(Sender: TObject);
    procedure ActionContactsVoiceCallExecute(Sender: TObject);
    procedure ActionSMSDownloadInboxExecute(Sender: TObject);
    procedure ActionSMSArchiveMsgExecute(Sender: TObject);
    procedure ActionSelectAllExecute(Sender: TObject);
    procedure ActionDeleteExecute(Sender: TObject);
    procedure ActionSMSMoveMsgToArchiveExecute(Sender: TObject);
    procedure ActionSMSNewMsgExecute(Sender: TObject);
    procedure ActionSMSReplyMsgExecute(Sender: TObject);
    procedure ActionSMSForwardMsgExecute(Sender: TObject);
    procedure ActionAboutExecute(Sender: TObject);
    procedure ActionWindowRestoreExecute(Sender: TObject);
    procedure ActionToolsOptionsExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ContactListGetSelectedIndex(Sender: TObject;
      Node: TTreeNode);
    procedure ComPortAfterOpen(Sender: TObject);
    procedure ComPortAfterClose(Sender: TObject);
    procedure ComPortRxChar(Sender: TObject; Count: Integer);
    procedure ActionContactsNewMsgExecute(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure ApplicationEvents1Restore(Sender: TObject);
    procedure ScriptControlError(Sender: TObject;
      Error: TawScriptError);
    procedure ActionToolsEditScriptExecute(Sender: TObject);
    procedure ActionConnectionAbortExecute(Sender: TObject);
    procedure ActionToolsUploadExecute(Sender: TObject);
    procedure ActionToolsPostNoteExecute(Sender: TObject);
    procedure cbProfileChange(Sender: TObject);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure LMDFMDropFMDragDrop(Sender: TObject; fcount, x, y: Integer;
      FileList: TStrings);
    procedure WSocketOnSessionConnect(Sender: TObject; Error: Word);
    procedure WSocketOnSessionClosed(Sender: TObject; Error: Word);
    procedure WBtSocketDataAvailable(Sender: TObject; Error: Word);
    procedure WBtSocketChangeState(Sender: TObject; OldState,
      NewState: TSocketState);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ActionSMSExportExecute(Sender: TObject);
    procedure ActionSyncPhonebookExecute(Sender: TObject);
    procedure ActionMissedCallsExecute(Sender: TObject);
    procedure ActionToolsKeyPadExecute(Sender: TObject);
    procedure ActionExitExecute(Sender: TObject);
    procedure ActionContactsExportMEExecute(Sender: TObject);
    procedure ActionToolsPostBookmarkExecute(Sender: TObject);
    procedure ActionObexReadyUpdate(Sender: TObject);
    procedure ActionToolsEditProfileUpdate(Sender: TObject);
    procedure ActionConnectionConnectUpdate(Sender: TObject);
    procedure ActionConnectionDisconnectUpdate(Sender: TObject);
    procedure ActionConnectionToggleUpdate(Sender: TObject);
    procedure ActionMissedCallsUpdate(Sender: TObject);
    procedure ActionWindowMinimizeExecute(Sender: TObject);
    procedure FmaOnTheWeb1Click(Sender: TObject);
    procedure ActionToolsChangeProfileExecute(Sender: TObject);
    procedure ActionToolsChangeProfileUpdate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure ActionToolsDownloadUpdate(Sender: TObject);
    procedure ActionToolsDownloadExecute(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ActionConnectionExplorerUpdate(Sender: TObject);
    procedure ActionConnectionExplorerExecute(Sender: TObject);
    procedure ActionExplorerUpFolderUpdate(Sender: TObject);
    procedure ActionExplorerUpFolderExecute(Sender: TObject);
    procedure trayMenuPopup(Sender: TObject);
    procedure ActionBusyUpdate(Sender: TObject);
    procedure ActionEditCommonUpdate(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure ActionContactsNewPersonUpdate(Sender: TObject);
    procedure ActionContactsNewPersonExecute(Sender: TObject);
    procedure ActionContactsVoiceCallUpdate(Sender: TObject);
    procedure ActionContactsNewMsgUpdate(Sender: TObject);
    procedure ActionSMSUpdate(Sender: TObject);
    procedure ActionContactsExportMEUpdate(Sender: TObject);
    procedure ActionEditGoUpUpdate(Sender: TObject);
    procedure ActionEditGoUpExecute(Sender: TObject);
    procedure ActionEditGoDownUpdate(Sender: TObject);
    procedure ActionEditGoDownExecute(Sender: TObject);
    procedure ActionSMSArchiveMsgUpdate(Sender: TObject);
    procedure ActionConnectionDownloadUpdate(Sender: TObject);
    procedure Properties1Click(Sender: TObject);
    procedure ShowExplorer1Click(Sender: TObject);
    procedure ActionViewMsgPreviewUpdate(Sender: TObject);
    procedure ActionViewMsgPreviewExecute(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FmaOnSFNet1Click(Sender: TObject);
    procedure ActionContactsAddContactUpdate(Sender: TObject);
    procedure ActionContactsAddContactExecute(Sender: TObject);
    procedure ActionContactsOwnExecute(Sender: TObject);
    procedure FmaOnForums1Click(Sender: TObject);
    //procedure CheckforUpdate1Click(Sender: TObject);
    procedure ActionConnectionSendOutboxMsgsExecute(Sender: TObject);
    procedure ActionConnectionSendOutboxMsgsUpdate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ActionToolsKeybLockUpdate(Sender: TObject);
    procedure ActionToolsKeybLockExecute(Sender: TObject);
    procedure cbTerminalEnter(Sender: TObject);
    procedure cbTerminalExit(Sender: TObject);
    procedure ActionSMSImportUpdate(Sender: TObject);
    procedure ActionSMSImportExecute(Sender: TObject);
    procedure ActionContactsImportMEUpdate(Sender: TObject);
    procedure ActionContactsImportMEExecute(Sender: TObject);
    procedure DebugTools1Click(Sender: TObject);
    procedure ScriptControlCallFunction(Sender: TObject;
      const FunctionName: String; const Params: array of Variant);
    procedure Timer3Timer(Sender: TObject);
    procedure ActionSyncWithOutlookExecute(Sender: TObject);
    procedure FmaWebUpdate1BeforeUpdate(Sender: TObject;
      var AllowRestart: Boolean);
    procedure FmaWebUpdate1Error(Sender: TObject; Message: String);
    procedure CheckforUpdate2Click(Sender: TObject);
    procedure ActionSwitchUserProfileUpdate(Sender: TObject);
    procedure ActionSwitchUserProfileExecute(Sender: TObject);
    procedure ToolButton15Click(Sender: TObject);
    procedure CoolTrayIcon1BalloonHintClick(Sender: TObject);
    procedure ActionViewLogExecute(Sender: TObject);
    procedure tbMainMenuCustomDrawButton(Sender: TToolBar;
      Button: TToolButton; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ActionSyncCalendarExecute(Sender: TObject);
    procedure PopupMenu2Popup(Sender: TObject);
    procedure ShowCaption1Click(Sender: TObject);
    procedure ShowDiagram1Click(Sender: TObject);
    procedure ActionContactsExportSMUpdate(Sender: TObject);
    procedure ActionContactsExportSMExecute(Sender: TObject);
    procedure ActionContactsExportUpdate(Sender: TObject);
    procedure ActionContactsExportExecute(Sender: TObject);
    procedure ActionContactsImportSMUpdate(Sender: TObject);
    procedure ActionContactsImportSMExecute(Sender: TObject);
    procedure ActionContactsImportUpdate(Sender: TObject);
    procedure ActionContactsImportExecute(Sender: TObject);
    procedure ActionContactsNewChatUpdate(Sender: TObject);
    procedure ActionContactsNewChatExecute(Sender: TObject);
    procedure ActionToolsWapHomepageUpdate(Sender: TObject);
    procedure ActionToolsWapHomepageExecute(Sender: TObject);
    procedure EditFavorites1Click(Sender: TObject);
    procedure EditCallFavorites1Click(Sender: TObject);
    procedure ActionContactsVoiceHangupUpdate(Sender: TObject);
    procedure ActionContactsVoiceHangupExecute(Sender: TObject);
    procedure ApplicationEvents1Hint(Sender: TObject);
    procedure ActionToolsCreateGroupExecute(Sender: TObject);
    procedure ActionToolsSilentUpdate(Sender: TObject);
    procedure ActionToolsSilentExecute(Sender: TObject);
    procedure ActionToolsPowerOffExecute(Sender: TObject);
    procedure ActionIrmcReadyUpdate(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure FormStorage1RestorePlacement(Sender: TObject);
    procedure Refresh2Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure ActionSyncBookmarksExecute(Sender: TObject);
    procedure ActionToolsMinuteMinderExecute(Sender: TObject);
    procedure ActionToolsMinuteMinderUpdate(Sender: TObject);
    procedure ActionViewTBUpdate(Sender: TObject);
    procedure ActionViewTBExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CoolBarChange(Sender: TObject);
    procedure GettingStarted1Click(Sender: TObject);
    procedure WBtSocketSessionAvailable(Sender: TObject; ErrCode: Word);
    procedure ExceptionTest1Click(Sender: TObject);
    procedure TntButton1Click(Sender: TObject);
    procedure TntButton2Click(Sender: TObject);
    procedure TntButton3Click(Sender: TObject);
    procedure TntButton4Click(Sender: TObject);
    procedure TntButton5Click(Sender: TObject);
    procedure ActionViewPropertiesUpdate(Sender: TObject);
    procedure ActionViewPropertiesExecute(Sender: TObject);
    procedure StatusBarResize(Sender: TObject);
    procedure FmaWebUpdate1AfterUpdate(Sender: TObject; Text: String);
    procedure ActionSyncClockExecute(Sender: TObject);
    procedure ActionViewAddFolderUpdate(Sender: TObject);
    procedure ActionViewAddFolderExecute(Sender: TObject);
    procedure ActionViewDelFolderUpdate(Sender: TObject);
    procedure ActionViewDelFolderExecute(Sender: TObject);
    procedure ActionSMSToFolderUpdate(Sender: TObject);
    procedure ActionSMSToFolderExecute(Sender: TObject);
    procedure OnFolderSelected(Sender: TObject; Node: PVirtualNode;
      var EnableOKButton: boolean; var EnableNewFolder: boolean);
    procedure ActionSyncAllExecute(Sender: TObject);
    procedure ActionSyncMessagesExecute(Sender: TObject);
    procedure ActionRulesExportUpdate(Sender: TObject);
    procedure ActionRulesExportExecute(Sender: TObject);
    procedure ImportRules1Click(Sender: TObject);
    procedure DeliveryRules1Click(Sender: TObject);
    procedure Proximity1Click(Sender: TObject);
    procedure ScriptingOptions1Click(Sender: TObject);
    procedure LanguageOptions1Click(Sender: TObject);
    procedure ActionSMSDeliveryUpdate(Sender: TObject);
    procedure ActionSMSDeliveryExecute(Sender: TObject);
    procedure MissedCallsTrayIconDblClick(Sender: TObject);
    procedure NewMessageTrayIconDblClick(Sender: TObject);
    function ApplicationEvents1Help(Command: Word; Data: Integer;
      var CallHelp: Boolean): Boolean;
    procedure Index1Click(Sender: TObject);
    procedure Search1Click(Sender: TObject);
    procedure ExplorerNewChange(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure ExplorerNewGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure ExplorerNewGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure ExplorerNewGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure ExplorerNewContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure ExplorerNewPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure ExplorerNewDblClick(Sender: TObject);
    procedure ExplorerNewFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure ExplorerNewMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ExplorerNewClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure DeviceMonitorUSB1USBArrival(Sender: TObject);
    procedure ActionPlayerTogglePlayUpdate(Sender: TObject);
    procedure ActionPlayerTogglePlayExecute(Sender: TObject);
    procedure ActionViewMsgSearchUpdate(Sender: TObject);
    procedure ActionViewMsgSearchExecute(Sender: TObject);
    procedure ExplorerNewAfterCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellRect: TRect);
    procedure ActionDummyExecute(Sender: TObject);
    procedure Memo3Change(Sender: TObject);
    procedure ActionNotInObexUpdate(Sender: TObject);
    procedure ActionToolsPostAlarmExecute(Sender: TObject);
    procedure TntButton6Click(Sender: TObject);
    procedure ActionToolsExportCalendarExecute(Sender: TObject);
    procedure ActionToolsExportCalendarUpdate(Sender: TObject);
    procedure ActionToolsImportCalendarExecute(Sender: TObject);
    procedure ActionToolsImportCalendarUpdate(Sender: TObject);
  private
    { Private declarations }
    LastSMSSendFailure,LastSMSReceiveFailure: TDateTime;
    FSendingMessage: Boolean;

    FLastMenuButton: TToolButton;
    ChartShiftCnt, FKeyMSec: Cardinal;

    FBtAddress: String;
    FBtDevice: WideString;
    FBtPort: String;

    FConnectionError,FProximityActive,FLastReconnect,FTemporaryOffline,FAutoProfile,
    FDoNotRefreshViewOnConnect,FHaveVoiceDialCommand_Answer,FHaveVoiceDialCommand_Dial,
    FHaveVoiceDialCommand_Hangup,FDatabaseLoaded: Boolean;

    FMessage: String;

    FNewMessageList,FNewPDUList: TStringList;

    FLookupList: TTntStringList;

    FNotFirstInstance,FAppInitialized,FIgnoreLowBattery,FStateMonitor,
    FDoSyncClock,FKeyState,FKeyMonitoring,FKeybLocked,FSilentMode,FEBCAKeyMonStopped: Boolean;
    FMinuteMinder : Boolean;

    FScriptFile,FScriptEditor: WideString;

    FOutlookConflict1,FOutlookConflict2: TContact;

    //FCurrentInterval: Integer;
    EBCALastState: Integer;

    FAlphaCall : Integer;
    FAlphaLog : Integer;
    FAlphaMessage : Integer;
    FAlphaCompose : Integer;

    FAccessoriesMenu: TAccessoriesMenu;
    FCallM,FMsgM,FExit,FExiting,FExitWindows,FMinimize,FCheckOutbox,FRelocateDBDenied: Boolean;
    FLastECAVStatus: Integer;
    FLastShownFrame,FLastClockTZ: string;

    FLogForm: TfrmLog;
    FPhoneModel: String;

    function GetAssociatedBand(Bar: TToolBar): TCoolBand;
    function GetBandSettings(Band: TCoolBand): string;
    procedure SetBandSettings(Band: TCoolBand; Data: WideString);

    procedure InitExplorerTree;
    function InitNewPhone(ReturnDontShow: boolean = False): boolean;

    procedure ReleaseMainMenuButton;
    procedure UpdateColorScheme;

    procedure DoRemoveAlarm;
    procedure DoRemoveGroupMemberOrFile;
    procedure DoRemoveBookmark;
    procedure DoRemoveGroup;

    // for selected explorer item
    procedure DownloadSMS(msgType: Integer; Node: PVirtualNode = nil); overload;
    procedure DownloadSMS(msgType: Integer; memLocation: String; Node: PVirtualNode = nil); overload;
    // into custom location (tstrings)
    procedure DownloadSMS(msgType: Integer; var sl: TStringList); overload;
    procedure DownloadSMS(msgType: Integer; memLocation: String; var sl: TStringList;
      MarkAsNew: boolean = False); overload;
    // for new messages
    procedure DoDownloadSMSFromPhone(memLocation: String; index: Integer);
    // other
    procedure FlushOK;

    function CheckScriptEditorExt: boolean;
    procedure ScriptingCleanup;

    procedure HandleCALV(AMsg: String);
    procedure HandleCPMS(AMsg: String);
    procedure HandleECAV(AMsg: String);
    procedure HandleCOPS(AMsg: String);
    procedure HandleCKEV(AMsg: String);
    procedure HandleCIEV(AMsg: String);
    procedure HandleCSCS(AMsg: String);
    procedure HandleCCLK(AMsg: String);
    procedure HandleCPIN(AMsg: String);
    procedure HandleCNMI(AMsg: String);
    procedure HandleEMIV(AMsg: String);
    procedure HandleEAMI(AMsg: String);
    procedure HandleSEGUII(AMsg: String);
    procedure HandleEBCA(AMsg: String);
    procedure HandleCLCK(AMsg: String);
    procedure HandleCMTI(AMsg: String);
    procedure HandleCIND(AMsg: String);
    procedure HandleStatus(AMsg: String; OverrideBatteryLow: Integer = -1);
    procedure LoadOptions;
    procedure RetrieveNewSMS(AMsg: String);
    procedure ParsePhonebookList(const buffer: String; var sl: TStrings);
    procedure ParsePhonebookListFromSync(var sl: TStrings);      // SIM View only
    procedure ParsePhonebookListFromEditor(ANode: PVirtualNode); // SIM View only
    procedure SetPanelText(id: Integer; str: WideString = '');
    function LoadScript: boolean;
    procedure ScriptEvent(const FunctionName: string; const Params: array of Variant);
    procedure ScheduleScriptEvent(const FunctionName: string; const Params: array of Variant);
    procedure UpdateSpecialMonitors;
    procedure ClearBuffer;
    procedure SetFrameVisible(name: String; visible: Boolean = True);
    procedure GetContactRestrict;
    procedure GetSignalMeter;
    procedure GetBatteryMeter;

    procedure ObexListFolder(Path: WideString; var Dir: TStringList; Connect: boolean = true); overload;

    procedure CalculateTimeLeft(Model,Charge: string; Position, Max: integer);
    procedure UpdateMessagePreview;
    procedure AddCall(Node: PVirtualNode; contact: WideString; time: string; AsFirst: boolean = false);
    procedure ReindexCallsNode(Node: PVirtualNode);
    procedure SyncContactsConflict(Sender: TObject; Contact,OtherContact: TContact;
      const Description: WideString; const Item0Name, Item1Name: WideString;
      var SelectedItem: Integer);
    procedure SyncContactsFirstTime(Sender: TObject; var Continue: Boolean);
    procedure SyncContactsError(Sender: TObject; const Message: String);
    procedure SyncContactsConfirm(Sender: TObject; Contact: TContact; Action: TContactAction;
      const Description: WideString; var Confirmed: Boolean);
    procedure SyncContactsChooseLink(Sender: TObject; Contact: TContact; PossibleLinks: TPossibleLinks;
      var OtherContact: TContact);
    procedure LogFormDestroy(Sender: TObject);
    function getExplorerSelectedNodeLevel1: PVirtualNode;
    procedure OnOutlookConflictChanges(Sender: TObject; const TargetName, Option1Name, Option2Name: WideString);
  protected
    FScriptEventName: string;
    FScriptEventParams: array of Variant;
    procedure HandleRinging;
    procedure HandleMessage(var Msg: TFmaHandleMessage); message FMA_HANDLEMESSAGE;
    procedure WM_QUERYENDSESSION(var Msg: TMessage); message WM_QUERYENDSESSION;
    procedure WM_ENDSESSION(var Msg: TMessage); message WM_ENDSESSION;
    procedure WM_SYSCOLORCHANGE(var Msg: TMessage); message WM_SYSCOLORCHANGE;
  public
    { Public declarations }
{$IFNDEF VER150}
    ThemeManager1: TTntThemeManager;
{$ENDIF}

    FForceUCSusage,FArchiveDublicates: boolean;
    FStartupOptions: TStartupOptions;
    FProximityOptions: TProximityOptions;
    FTextMessageOptions: TTextMessageOptions;
    FCallOptions: TCallOptions;
    FScriptRunning, FScriptInitialized, FScriptErrorOccur, FBatteryLow, FBatteryWarning,
    FCalWideView,FCalRecurrence,FCalRecurrAsk: boolean;
    FFmaMutex: Cardinal;
    FShowDiagram,FShowTodayCaption,FClearPhoneMessage: Boolean;
    FUseCIND,FUseAlternateSignalMeter,FUseAlternateBatteryMeter: Boolean;
    FOutlookConfirmed: array[TContactAction] of TConfirmation;
    FAutolinkContacts,FShowSplash,FAlwaysMinimized: Boolean;
    FamCommand: String;
    FObex: TObex;

    // Forms, TntForms
    frmSMEdit: TfrmContactsSMEdit;
    frmMEEdit: TfrmContactsMEEdit;
    frmMsgView: TfrmMsgView;
    frmInfoView: TfrmInfoView;
    frmSyncPhonebook: TfrmSyncPhonebook;
    frmSyncBookmarks: TfrmSyncBookmarks;
    frmExplore: TfrmExplore;
    frmEditor: TfrmEditor;
    frmCalendarView: TfrmCalendarView;

    // new ones begin
    FNodeContactsRoot,
    FNodeContactsME, FNodeContactsSM, FNodeProfiles, FNodeGroups, FNodeCalls, FNodeCallsIn, FNodeCallsOut, FNodeCallsMissed,
    FNodeObex, FNodeOrganizer, FNodeAlarms, FNodeBookmarks, FNodeScripts, FNodeCalendar: PVirtualNode;
    FNodeMsgRoot,
    FNodeMsgInbox, FNodeMsgSent, FNodeMsgOutbox, FNodeMsgDrafts, FNodeMsgArchive: PVirtualNode;
    // new ones end
    FSMSCounterReseted,FSMSDoWarning,FSMSDoReset: boolean;
    FSMSCounter, FSMSWarning, FSMSCounterResetDay,FSMSCounterResetLastMonth: Integer;
    FSyncContactPrio,FSyncCalendarPrio,FSyncClockPrio,FSyncBookmarkPrio: Integer;
    FSyncBookmarksIE,FSyncBookmarksFirefox,FSyncBookmarksOpera: boolean;
    FBookmarkRootFolder: string;
    FOutlookSyncConflict: Integer;
    FOutlookConfirmAdding, FOutlookConfirmUpdating, FOutlookConfirmDeleting: Boolean;
    FOutlookNewAction: Integer;
    FOutlookCategories, FOutlookFieldMappings,
    FSelectedOutlookContactFolders, FSelectedOutlookCalendarFolders, FSelectedOutlookTaskFolders,
    FOutlookNewContactsFolder, FOutlookNewCalendarFolder, FOutlookNewTasksFolder: WideString;
    FLastWebUpdateDate: TDateTime;
    FExplorerStartupMode,FAutoWebUpdateMode: Integer;
    FConnected,FConnectingComplete,FConnectingStarted,FStartupSyncFinished,FJustWebUpdated: Boolean;
    FDontProgress,FProgressIndicatorOnly,FProgressLongOnly,FProgressRestoredOnly: Boolean;
    FEmergencyMode,FUseCNMIMode3,FStatusReport,FUseUTF8,FUseObex,FUseObexCompat,
    FUseEBCA,FUseScript,FUseCBC,FUseCSQ,FUseSilentMonitor,FUseMinuteMonitor,FUseKeylockMonitor,FUseScriptEditorExt: Boolean;
    FAutoConnectionError,FOnACPower,LoadingDBFiles,FChatLongSMS,FChatBold,FUseMediaPlayer: Boolean;
    FSelOperator,FSelPhone,FChatNick: WideString;
    FSupportedCS,FKeyActivity,FDatabaseVersion: String;
    FKeyInactivityTimeout: Integer;
    FFavoriteRecipients,FFavoriteCalls: TTntStringList;
    FDeliveryRules: TTntStringList;

    fFiles: TFiles;

    { Mixer vars }
    L,R,M,FLastVolume:Integer;
    VD,MD,MS,Stereo:Boolean;

    FDisplayNameFormat: Integer;

    function GetHelpFilename(AppendPath: WideString = ''): WideString;

    procedure ScriptingEnable(NewScriptFile: String = '');
    procedure ScriptingDisable;

    function ObexListFolder(Path: WideString; Connect: boolean = true): string; overload;

    { Diagram }
    function IsEBCAEnabled: boolean;
    function CanUseEBCA(IgnoreConnectingState: boolean = False): boolean;
    procedure EBCAState(Enable: Boolean; KeyMonToo: Boolean = True);

    { Text Messages }
    function IsMoveToArchiveEnabled: boolean;
    procedure DownloadMessages(Node: PVirtualNode);
    procedure DownloadAllMessages;
    procedure SMSToFolder(FolderNode: PVirtualNode);
    function SMSNewFolder(ParentNode: PVirtualNode; AName: WideString): PVirtualNode;

    { Phonebook }
    procedure DownloadPhonebook(var ABuffer: string);

    { This allows calling object methods as well (m.func) }
    procedure CallScriptMethod(FunctionName: string; Params: array of Variant);
    function ApplyEditorChanges(SaveOnly: Boolean = False): boolean;

    procedure RenderContactLists;
    procedure RenderContactList(var rootNode: PVirtualNode);

    { Organizer }
    procedure RenderBookmarkList(var rootNode: PVirtualNode);

    { Phone Database }
    function GetPhoneIdentity: string;
    procedure SetPhoneIdentity(ID: string);
    function ExtractPhoneIdentity(var Model,Serial: string): string;

    function GetAppDataPath: string;
    function GetDatabasePath: string;
    function GetProfilePath(OverrideID: string = ''): string;

    function PhoneExists(AName: WideString): boolean;
    function PhoneUnique(AName,AIdentity: WideString): boolean;

    function LoadPhoneDataFiles(ID: string = ''; ShowStatus: Boolean = True; ShowProgress: Boolean = False): boolean;
    function OpenPhoneDataFiles(ID: string = ''): boolean;
    procedure DeletePhoneDataFiles(ID: string; Wnd: THandle = 0);
    procedure RepairPhoneDataFiles(ID: string);
    procedure SavePhoneDataFiles(ShowStatus: Boolean = False);

    procedure LoadUserFoldersData(DBPath: string; ShowUnreadFolders: Boolean = True);
    procedure SaveUserFoldersData(DBPath: string);

    function GetSMSDeliveryNode(Sender: WideString; CustomRules: WideString = '';
      AllowDefaultArchive: Boolean = True): PVirtualNode;
    function GetSMSNodeName(Node: PVirtualNode): WideString; overload;
    function GetSMSNodeName(const Name: WideString): WideString; overload;
    procedure EditSMSDeliveryRules(Node: PVirtualNode);

    procedure ClearExplorerViews;

    { Text Messages }
    function GetChatWindow(Contact: string; AllowCreateNew: boolean = False): TfrmCharMessage;
    procedure ChatNotifyDel(PDU: String);

    function UpdateNewMessagesCounter(rootNode: PVirtualNode; ModifyPDU: string = ''; MarkAsRead: boolean = True): integer;
    function GetNewMessagesCounter(rootNode: PVirtualNode): integer;

    procedure SaveMsgToFolder(var rootNode: PVirtualNode; PDU: String;
      OverwriteOld: boolean = false; AsNew: boolean = true; UpdateView: boolean = true;
      ForceIndex: Integer = -1; ForceDate: TDateTime = 0; AllowDuplicates: Boolean = false);
    procedure SaveToArchive(PDU: String; OverwriteOld: boolean = false; UpdateView: boolean = True);
    function DelMsgFromFolder(var rootNode: PVirtualNode; PDU: string; UpdateView: boolean = True): Boolean;
    function DeleteSMS(index: Integer; memType: String; CheckPDU: String = ''): Boolean;

    function GetNextLongSMSRefference: string;
    procedure SendTextMessage(UDHI: String; msg: WideString; destNo: WideString; reqReply: Boolean = False;
      Flash: Boolean = False; StatusReq: Boolean = False; dcs: TGSMCodingScheme = gcsUnknown; SaveDraft: Boolean = False);

    function GetStatus: WideString;
    procedure Status(str: WideString; AddToLog: Boolean = True);

    procedure TxAndWait(Data: string; WaitStr: String = 'OK'); // do not localize
    procedure ScheduleTxAndWait(Data: string; WaitStr: String = 'OK'); // do not localize

    function LookupContact(Number: WideString; DefaultName: WideString = ''): WideString;
    function LookupNumber(Contact: WideString): String;

    function LookupContactGroups(Contact: WideString): String;

    procedure InitAlarms;
    procedure InitProfile;
    procedure InitGroups;
    procedure InitCalls; overload;
    procedure InitCalls(Node: PVirtualNode); overload;
    procedure InitObexFolders;

    function ExplorerFindExtImage(Ext: string): integer;

    procedure ExplorerAddToGroup(GroupIndex: integer; Contact: WideString; Number: String);
    procedure ExplorerDelFromGroup(GroupIndex: integer; Contact: WideString);

    function ExplorerFindNode(NodePath: WideString; AllowCreate: Boolean = False): PVirtualNode;
    function ExplorerNodePath(Node: PVirtualNode; SepChar: WideChar = '\'; SkipRoot: Boolean = False): WideString;

    function ExplorerNodeIsFileOrFolder(Node: PVirtualNode): Boolean;

    function WhereisContact(SearchFor: WideString; Mode: TFindContactMode): TFindContactResult; // see comments in function!

    procedure ExtractName(var Name,numType: WideString);
    function ExtractNumber(ContactNumber: WideString): WideString;
    function ExtractContact(ContactNumber: WideString): WideString;
    function ContactNumberByTel(ContactNumber: string): WideString;
    function ContactNumberByName(ContactName: WideString): WideString;

    function IsIrmcSyncEnabled: boolean;

    function IsContactNumberSelected: boolean;
    function LocateSelContactNumber: string;
    function GetPartialNumber(Number: string): string;

    function LocatePBName(Where: string; Index: integer): WideString; overload;
    function LocatePBName(Where: string; Index: integer; var Number: string): WideString; overload;
    function LocatePBIndex(Where: string; Person: WideString; Phone: string): integer;

    function WriteSMS(memLocation, PDU: String; Stat: Integer = -1): boolean;

    procedure RefreshPhoneBook;
    procedure UpdateMEPhonebook;
    procedure UpdateSMPhonebook;

    procedure EnableKeyMonitor(TxDelay: boolean = False);
    procedure DisableKeyMonitor(TxDelay: boolean = False);

    procedure MinimizeApp;

    procedure VoiceCall(number: String);
    procedure VoiceAnswer;
    procedure VoiceHangUp(SilentMode: boolean = False);

    procedure DoAbort;
    procedure DoConnect;
    procedure DoDisconnect;
    procedure DoDisconnectTemporary;
    procedure AskRequestConnection;
    procedure RequestConnection(DoNotRefreshView: boolean = True);

    procedure DoProximityNear;
    procedure DoProximityAway;
    procedure DoProximityTest;

    procedure DoCallContact(ContactNumber: WideString);

    procedure DoProcessRules(Node: PVirtualNode; Rules: WideString = '');
    procedure DoProcessInbox;
    procedure DoProcessOutbox;

    procedure DoCleanupOutbox;

    function GetSMSMembers(Index: Integer; NodeData: TStringList; var Members: TStringList): boolean;

    function GetMute: Boolean;
    function GetVolume: Integer;
    procedure SetMute(Mute: Boolean);
    procedure SetVolume(Percentage: Integer);

    function IsAutoConnect: boolean;
    function IsScriptInitialized: boolean;
    function IsStartCanceled: boolean;
    function IsStartCompleted: boolean;

    function CanShowProgress: boolean;
    function CanShowProgressDialog: boolean;

    { Obex folder routines }
    function FindObexFolderNode(AType: byte): PVirtualNode; // 0-pics,1-snds
    function FindObexFolderName(AType: byte): WideString; // 0-pics,1-snds

    procedure SetActionState(act: TTntAction; state: Boolean);

    { Obex routines within Connect/disconnect block }
    procedure ObexConnect(Target: widestring = '');
    procedure ObexDisconnect;

    function ObexGetObject(Path: Widestring; var Where: TStringList;
      progress: boolean = False; FriendlyName: string = ''): cardinal; overload;
    function ObexGetObject(Path: Widestring; var stream: TStream;
      progress: boolean = False): cardinal; overload;
    function ObexPutObject(Path: Widestring; Stream: TStream;
      progress: boolean = False): WideString;

    { Direct obex calls }
    procedure ObexPutFile(filename: WideString; Delete: boolean = False; Silent: boolean = False);
    procedure ObexGetFile(filename,objname: WideString; Silent: boolean = False);

    procedure StartupInitialize;
    procedure ViewInitialize;
    procedure ScriptInitialize;

    procedure SetTaskPercentageInc;
    procedure SetTaskPercentage(Pos: Integer; Max: Integer = 100; Loop: Boolean = False);
    procedure FloatingRectangles(Minimizing, OverrideUserSettings: Boolean);
    procedure ShowBaloonInfo(Text: WideString; Timeout: TBalloonHintTimeOut = 10; Where: TCoolTrayIcon = nil; IconT: TBalloonHintIcon = bitInfo);
    procedure ShowBaloonError(Text: WideString; Timeout: TBalloonHintTimeOut = 10);

    { Explorer properties }
    function FindExplorerChildNode(Named: WideString; RootNode: PVirtualNode = nil): PVirtualNode;
    function FindExplorerPhoneNode(Number: String; RootNode: PVirtualNode): PVirtualNode;
    procedure ShowExplorerProperties(Node: PVirtualNode);
    procedure SetExplorerNode(Node: PVirtualNode);

    function IsT610Clone(BrandName: WideString = ''): Boolean;
    function IsK610Clone(BrandName: WideString = ''): Boolean;
    function IsK700Clone(BrandName: WideString = ''): Boolean;    // mostly compatible with T610
    function IsK750Clone(BrandName: WideString = ''): Boolean;
    function IsWalkmanClone(BrandName: WideString = ''): Boolean; // only detects if phone has MediaPlayer
  published
    procedure ActionToolsEditProfileExecute(Sender: TObject);
    procedure Explore(Node: PVirtualNode);
    //
    property PhoneIdentity: string read GetPhoneIdentity write SetPhoneIdentity;
    property ScriptFilename: WideString read FScriptFile;
    property PhoneModel: String read FPhoneModel;
  end;

var
  Form1: TForm1;
  ExePath: WideString;

{ Wait seconds if < 100, else miliseconds, but one can force as miliseconds
  Note that passed by time is checked in steps of 10 miliseconds }
procedure WaitASec(Seconds: integer = 1; ForceMSecs: boolean = False);

function EvenQuotes(const Str: WideString): Boolean;

{ The default TFont uses "MS Sans Serif" which doesn't work well with most non-ANSI characters.
  I'd recommend using a TrueType font such as "Tahoma" if it is installed on the machine.
  To make TFont use a different font like "Tahoma" add this to the first line in the project:

    Graphics.DefFontData.Name := 'Tahoma';

  You might have to include "Graphics" in the file's uses clauses.  Furthermore, adding this line
  of code to the project will cause the changed setting to only be applied at runtime, not at design time.
  To make a designtime change, you'd have to add this line to the initialization section of a unit in a
  design package.
  Regarding the IDE, I use GExperts to change the font of the Object Inspector.  The Wide String List
  editor uses the font used by the object inspector.
  Also keep in mind that the font used by certain message boxes come from that set by Windows' Display
  properties. }
procedure SetDefaultFont;

var WaitCompleteIsBusyEvent, WaitCompleteEvent: Cardinal;

const
  HelpTopics: array[1..1] of WideString = ( // do not localize!
    'html/welcome.htm'
  );

procedure ShowHelpPopup(Where: TPoint; ContextId: Integer); overload;
procedure ShowHelpPopup(Where: TPoint; ShowText: string); overload;

implementation

uses
  gnugettext, gnugettexthelpers, cUnicodeCodecs, cPortCtl, uNewAlarm, uRegistry,
  uThreadSafe, JclSysInfo, ShlObj, uCalling, uAbout, uOptions, uOptionsPage, uNewMessage, uMobileAgentUI,
  uPostNote, uGlobal, uEditProfile, uPostURL, uConnProgress, uComposeSMS, uVersion, uStatusDlg, TeEngine,
  uFolderProps, Types, uOfflineProfile, uFMASync, uOutlookSync, uPromptConflict, uChooseLink, uLogObserverWriter,
  uOrganizeFavs, uCallContact, uAddToPhonebook, StrUtils, uLogWriters, janXMLParser2, uInputQuery,
  uVBase, uVCalendar, uSplash, uConflictChanges, jclShell, MobileAgent_TLB, UrlMOn, uDialogs, uNewDeviceWizard,
  uWelcome, LMDGradient, uBrowseFolders, JwaHtmlHelp, uPassword;

{$R *.dfm}

{ Globals }

function HtmlHelpFile: string;
begin
  Result := ExtractFileDir(Application.ExeName) + '\help\' +
    ChangeFileExt(ExtractFileName(Application.ExeName),'.chm');
end;

procedure HtmlPopup(Where: TPoint; ContextId: Integer; ShowText: WideString = '');
var
  Popup: THHPopup;
  s: WideString;
begin
  FillChar(Popup, SizeOf(Popup), 0);
  Popup.cbStruct := SizeOf(Popup);
  Popup.hinst_ := 0;
  if ShowText = '' then begin
    Popup.idString := 1;
    Popup.pszText := nil;
  end
  else begin
    Popup.idString := 0;
    Popup.pszText := PWideChar(ShowText);
  end;
  Popup.pt.x := Where.X;
  Popup.pt.y := Where.Y;
  Popup.clrForeGround := TColorRef(-1);
  Popup.clrBackground := TColorRef(-1);
  Popup.rcMargins := Rect(-1, -1, -1, -1);
  Popup.pszFont := '';
  if ShowText = '' then begin
    if (ContextId >= Low(HelpTopics)) and (ContextId <= High(HelpTopics)) then begin
      s := HtmlHelpFile + '::/' + HelpTopics[ContextId];
      HtmlHelp(0, PWideChar(s), HH_DISPLAY_TOC, DWORD(@Popup));
    end;
  end
  else
    HtmlHelp(0, nil, HH_DISPLAY_TEXT_POPUP, DWORD(@Popup));
end;

{ TODO: Add L10N support }
const
  HelpPopups: array[1..1] of record id: integer; txt: string end = (
    (id: 101; txt: 'This is a sample help popup text.')
  );

procedure ShowHelpPopup(Where: TPoint; ContextId: Integer); overload;
var
  s: string;
  function GetPopupText: string;
  var
    i: integer;
  begin
    Result := '';
    for i := Low(HelpPopups) to High(HelpPopups) do
      if HelpPopups[i].id = ContextId then begin
        Result := HelpPopups[i].txt;
        break;
      end;
  end;
begin
  s := GetPopupText;
  if s <> '' then
    HtmlPopup(Where,0,s)
  else
    HtmlPopup(Where,ContextId);
end;

procedure ShowHelpPopup(Where: TPoint; ShowText: string); overload;
begin
  HtmlPopup(Where,0,ShowText);
end;

procedure SetDefaultFont;
var
  lf: LOGFONT;
  nc: NONCLIENTMETRICS;
begin
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS,SizeOf(nc),@nc,SPIF_SENDCHANGE) then
    lf := nc.lfMessageFont
  else begin
    if not SystemParametersInfo(SPI_GETICONTITLELOGFONT,SizeOf(lf),@lf,SPIF_UPDATEINIFILE) then begin
      Graphics.DefFontData.Name := 'MS Shell Dlg';
      exit;
    end;
  end;
  Graphics.DefFontData.Name := StrPas(@(lf.lfFaceName[0]));
  Graphics.DefFontData.Height := lf.lfHeight;
  Graphics.DefFontData.Charset := DEFAULT_CHARSET;
end;

function EvenQuotes(const Str: WideString): Boolean;
var
  P: Integer;
  WS: WideString;
begin
  WS := Str;
  Result := False;
  repeat
    { D7 code
    P := PosEx('"', S, P + 1); }
    { D6 code }
    P := Pos(WideString('"'),WS); Delete(WS,1,P);
    {}
    Result := not Result;
  until P = 0;
end;

procedure WaitASec(Seconds: integer; ForceMSecs: boolean);
var
  time: cardinal;
begin
  if Seconds < 1 then Seconds := 1;
  if (Seconds < 100) and not ForceMSecs then
    time := GetTickCount + cardinal(1000*Seconds)
  else
    time := GetTickCount + cardinal(Seconds);
  while (GetTickCount < time) and not Application.Terminated do begin
    Sleep(10);
    Application.ProcessMessages;
  end;
end;

{ Form1 - Codec developer tools }

procedure TForm1.Button4Click(Sender: TObject);
begin
  TntEdit2.Text := WideStringToUTF8String(TntEdit1.Text);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  TntEdit2.Text := UTF8StringToWideString(TntEdit1.Text);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  TntEdit2.Text := GSMEncodeUcs2(TntEdit1.Text);
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  TntEdit2.Text := GSMDecodeUcs2(TntEdit1.Text);
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  TntEdit2.Text := Str2QP(TntEdit1.Text);
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  TntEdit2.Text := QP2Str(TntEdit1.Text);
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
  TntEdit2.Text := HTMLEncode(TntEdit1.Text);
end;

var LogObserverWriter: TLogObserverWriter = nil;
procedure TForm1.TntButton1Click(Sender: TObject);
begin
  TntEdit2.Text := HTMLDecode(TntEdit1.Text);
end;

procedure TForm1.TntButton2Click(Sender: TObject);
begin
  TntEdit2.Text := GSMEncode7Bit(TntEdit1.Text);
end;

procedure TForm1.TntButton3Click(Sender: TObject);
begin
  TntEdit2.Text := GSMDecode7Bit(TntEdit1.Text);
end;

procedure TForm1.TntButton4Click(Sender: TObject);
begin
  TntEdit2.Text := GSMEncode8Bit(TntEdit1.Text);
end;

procedure TForm1.TntButton5Click(Sender: TObject);
begin
  TntEdit2.Text := GSMDecode8Bit(TntEdit1.Text);
end;

procedure TForm1.TntButton6Click(Sender: TObject);
const s: string = '*EAPN: 1,"æ™®é€š"';
var
  ws: WideString;
begin
  ws := LongStringToWideString(s{LabeledEdit1.Text});
  ws := GetToken(ws, 1);
  TntEdit2.Text := UTF8StringToWideString(WideStringToLongString(ws));
end;
{ Form1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  str: TMemoryStream;
begin
  if RadioButton2.Checked then
    ObexConnect(Edit2.Text)
  else
    ObexConnect(ObexFolderBrowserServiceID);
  str := TMemoryStream.Create;
  try
    FObex.GetObject(cbObex.Text,str);
    memo1.Lines.LoadFromStream(str);
  finally
    str.free;
    ObexDisconnect;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  vCard: TVCard;
begin
  vCard := TVCard.Create;
  try
    vcard.Raw := Memo1.Lines.AnsiStrings;
    memo2.Lines.Clear;
    memo2.Lines.Add('Type = ' + vcard.VType); // do not localize
    memo2.Lines.Add('Version = ' + vcard.Version); // do not localize
    memo2.Lines.Add('Name = ' + vcard.Name); // do not localize
    memo2.Lines.Add('Surname = ' + vcard.Surname ); // do not localize
    memo2.Lines.Add('Home = ' + vcard.TelHome ); // do not localize
    memo2.Lines.Add('Work = ' + vcard.TelWork ); // do not localize
    memo2.Lines.Add('Fax = ' + vcard.TelFax  ); // do not localize
    memo2.Lines.Add('Other = ' + vcard.TelOther ); // do not localize
    memo2.Lines.Add('Title = ' + vcard.Title ); // do not localize
    memo2.Lines.Add('Org = ' + vcard.Org ); // do not localize
    memo2.Lines.Add('Email = ' + vcard.email  ); // do not localize
    memo2.Lines.Add('XLUID = ' + vcard.LUID ); // do not localize
    if vcard.Photo <> nil then begin
      Image.Picture.Graphic.Assign(vcard.Photo);
    end;
  finally
    vCard.free;
  end;
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
  ObexConnect(ObexFolderBrowserServiceID);
  try
    memo1.Lines.Clear;
    FObex.ChangeDir(cbObex.Text);
    memo1.Lines.Add('OK') // do not localize
  finally
    ObexDisconnect;
  end;
end;

procedure TForm1.Button11Click(Sender: TObject);
var
  sl: TStringStream;
begin
  ObexConnect(ObexFolderBrowserServiceID);
  sl := TStringStream.Create('');
  try
    FObex.ChangeDir('');
    FObex.ChangeDir(cbObex.Text);
    FObex.List(sl);
    memo1.Lines.LoadFromStream(sl);
    if memo1.Lines.Count <> 0 then
      if Pos('encoding="UTF-8"',memo1.Lines[0]) <> 0 then
        memo1.Text := UTF8StringToWideString(memo1.Text);
  finally
    sl.free;
    ObexDisconnect;
  end;
end;

{ Form1 }

procedure TForm1.ActionConnectionConnectExecute(Sender: TObject);
var
  dlg: TfrmConnect;
  i,tid: Integer;
  so1,so2,so3,so4,so5: boolean;
begin
  if FConnectingStarted or FConnected then exit;
  if (PhoneIdentity = '') and not Assigned(frmNewDeviceWizard) then begin
    { No phone profile created yet }
    GettingStarted1.Click;
    exit;
  end;

  Timer1.Enabled := False;
  if not Visible and (FormStorage1.StoredValue['StartMinimized'] = False) then begin // do not localize
    Show;
    Update;
  end;
  try
    { Clear flags }
    ThreadSafe.Timedout := False;
    FAutoConnectionError := False;
    FConnectingStarted := True;
    FConnectingComplete := False;
    FStartupSyncFinished := False;
    FConnectionError := False;
    FConnected := False;
    ThreadSafe.Abort := False;
    ThreadSafe.AbortDetected := False;
    FEmergencyMode := True;
    FamCommand := '';
    try
      { Do connect }
      DoConnect;
      while not (FConnected or ThreadSafe.AbortDetected or ThreadSafe.Timedout or
        FConnectionError or Application.Terminated) do
        Application.ProcessMessages;
      if Application.Terminated then Abort;

      { Check for error }
      if FConnectionError then begin
        if not FAutoConnectionError then
          if ThreadSafe.AbortDetected then
            if FBatteryLow then
              raise Exception.Create(_('Connection aborted by user or phone battery is too low'))
            else
              raise Exception.Create(_('Connection aborted by user'))
          else
            raise Exception.Create(_('Connection failed'))
        else
          exit;
      end;

      if FConnected then begin
        { do not show Getting Started on startup anymore }
        Form1.FormStorage1.StoredValue['First Run'] := False; // do not localize
        { Allow auto-connect feature (if checked) }
        ActionConnectionMonitor.Tag := 1;
        { Done }
        FConnectingComplete := True;
        ExplorerNew.Repaint;
      end
      else
        Abort;
    except
      On E:Exception do begin
        Status(E.Message);
        DoDisconnect;
        { if aborted raise here to show this to user, and to
          cancel next connect operations.
        if not IsAutoConnect or ThreadSafe.AbortDetected then
          raise;
        }
       if ThreadSafe.Timedout or ThreadSafe.AbortDetected or not FConnected then Abort;
      end;
    end;
  finally
    Timer1.Enabled := True;
    FConnectingStarted := False;
  end;

  { Connection is completed successfuly }
  if FConnected and not FStartupSyncFinished then begin
    FStartupSyncFinished := True;
    { Perform any startup operations }
    dlg := GetProgressDialog;
    try
      tid := dlg.CurrentTaskID;
      { TODO: Add support for AutoTasks, AutoNotes options }
      so1 := FormStorage1.StoredValue['AutoInbox']; // do not localize
      so2 := FormStorage1.StoredValue['AutoSync']; // do not localize
      so3 := FormStorage1.StoredValue['AutoSyncOutlook']; // do not localize
      so4 := FormStorage1.StoredValue['AutoBookmarks']; // do not localize
      so5 := FormStorage1.StoredValue['AutoCalendar']; // do not localize

      i := byte(FDoSyncClock) + byte(so1) + byte(so2) + byte(so3) + byte(so4) + byte(so5);
      if so3 then i := i + byte(so2) {+ byte(so5)};
      if CanShowProgress and (i > 0) then begin
        dlg.Initialize(i,_('Synchronization in progress'));
        dlg.ShowProgress;
      end;  
      { First sync with phone... }
      if so1 then begin
        dlg.IncProgress(1,tid);
        DownloadAllMessages;
      end;
      if FDoSyncClock then begin
        dlg.IncProgress(1,tid);
        ActionSyncClock.Execute;
      end;
      if so4 then begin
        dlg.IncProgress(1,tid);
        ActionSyncBookmarks.Execute;
      end;
      if so2 then begin
        dlg.IncProgress(1,tid);
        ActionSyncPhonebook.Execute;
      end;
      if so5 then begin
        dlg.IncProgress(1,tid);
        ActionSyncCalendar.Execute;
      end;
      { ...then sync changes to Outlook... }
      if so3 then begin
        dlg.IncProgress(1,tid);
        ActionSyncWithOutlook.Execute;
        { ...and finaly apply changes back to phone }
        if so2 then begin
          dlg.IncProgress(1,tid);
          ActionSyncPhonebook.Execute;
        end;
        { next is not needed since Outlook do not sync with FMA Calendar - disabled!!
        if so5 then begin
          dlg.SetDescr(_('Synchronize Phone Calendar'),tid);
          ActionSyncCalendar.Execute;
        end;
        }
      end;
    finally
      FreeProgressDialog;
      UpdateSpecialMonitors;
      { Show SIM info }
      if FEmergencyMode then
        Status(_('SIM card not found or not a SIM card, emergency mode activated'))
      else
        Status(WideFormat(_('SIM card found and ready with operator %s'),[FSelOperator]));
    end;
  end;
end;

procedure TForm1.ComPortAfterOpen(Sender: TObject);
var
  dlg: TfrmConnect;
  s,CurrentIdentity,model,serial: String;
  device: WideString;
  PhoneChanged: boolean;
  SelNode: PVirtualNode;
  EData: PFmaExplorerNode;
  procedure DoReady;
  begin
    FAutoConnectionError := False;
    PhoneIdentity := CurrentIdentity;
    SetPanelText(0,_('Connected'));
    PlaySound(pChar('FMA_MEConnected'), 0, SND_ASYNC or SND_APPLICATION or SND_NODEFAULT); // do not localize
    if not FStartupOptions.NoBaloons then
      ShowBaloonInfo(WideFormat(_('Connected successfully to %s phone.'),[model]));
    ScriptEvent('OnConnected', []); // do not localize
    { Update explorer view, if needed }
    if (SelNode = ExplorerNew.GetFirstSelected) and not FDoNotRefreshViewOnConnect then begin
      SetExplorerNode(SelNode);
      ExplorerNewChange(ExplorerNew, ExplorerNew.FocusedNode);
    end;
    FDoNotRefreshViewOnConnect := False;
    if FTemporaryOffline then begin
      FTemporaryOffline := False;
      { Restore re-connect settings before last disconnect }
      ActionConnectionMonitor.Checked := FLastReconnect;
      ActionConnectionMonitor.Tag := byte(FLastReconnect);
    end;
  end;
  procedure ShowNextProgress(Inc: integer = 1);
  begin
    dlg.IncProgress(Inc);
  end;
begin
  SelNode := ExplorerNew.FocusedNode;
  ThreadSafe.AlreadyInUseObex := False;
  ThreadSafe.ObexConnecting := False;
  FAutoConnectionError := IsAutoConnect;
  FUseAlternateSignalMeter := False;
  FUseAlternateBatteryMeter := False;
  FSendingMessage := False;
  FUseMediaPlayer := False;
  FSelOperator := '';

  ClearBuffer;
  { Go back to chart start point }
  if ChartShiftCnt <> 0 then begin
    with frmInfoView.Chart1.BottomAxis do Scroll(-ChartShiftCnt,False);
    ChartShiftCnt := 0;
  end;
  frmInfoView.Chart1.Page := 1;
  frmInfoView.Chart1.Series[0].Clear;
  frmInfoView.Chart1.Series[1].Clear;
  frmInfoView.Chart1.Series[2].Clear;

  if not IsAutoConnect then Status(_('Connecting...')); // will be added to LOG too!
  CoolTrayIcon1.Hint := _('Connecting...');
  CoolTrayIcon1.CycleIcons := True;
  try
    dlg := GetProgressDialog;
    try
      Application.ProcessMessages;
      { Show progress if not auto-connecting and if enabled in options }
      if not IsAutoConnect and CanShowProgress then begin
        { If so, always do it, ignore delay option, since we have to see all connect steps }
        dlg.Initialize(32, // for total, count [ShowNextProgress] calls below - 1!
          _('Searching Device...'));
        dlg.ShowProgress;
      end;
      Application.ProcessMessages;

      if not IsAutoConnect then Log.AddCommunicationMessage('Initializing phone...',lsDebug); // do not localize debug
      Application.ProcessMessages;
        
      try TxAndWait('ATE0'); except; end; // do not localize
      if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
      ShowNextProgress; 

      FConnected := True;
      SetPanelText(0,_('Negotiate'));
      ActionConnectionToggle.Update;

      if not IsAutoConnect then Log.AddCommunicationMessage('Check for Battery and Charging support',lsDebug); // do not localize debug
      try
        TxAndWait('AT*EBCA=?'); // do not localize
        TxAndWait('AT*EBCA=0'); // do not localize
        FUseEBCA := True;
      except
        FUseEBCA := False;
        Log.AddCommunicationMessage('Battery and Charging Algorithm not supported!',lsDebug); // do not localize debug
      end;
      if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
      ShowNextProgress;

      { Retrieve phone model, device name and serial number }
      dlg.SetDescr(_('Identifying phone'));
      if IsAutoConnect then Log.AddMessage('Auto-connect: Identify phone model', lsDebug) // do not localize debug
        else Log.AddMessage('Identify phone model', lsDebug); // do not localize debug
      try
        TxAndWait('ATI'); // do not localize
        model := ThreadSafe.RxBuffer[0];
        if Trim(model) = '' then model := _('Unknown');
        FPhoneModel := Model;
      except
        Log.AddCommunicationMessage('Error: Could not identify phone model!',lsDebug); // do not localize debug
        Abort;
      end;
      if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
      ShowNextProgress; 

      try
        if ThreadSafe.ConnectionType = 0 then begin
          device := FBtDevice;
        end else
        if ThreadSafe.ConnectionType = 1 then
          with WIrSocket.GetConnectedDevices do
          begin
            device := Items[0].irdaDeviceName;
            Free;
          end
        else begin
          TxAndWait('AT+CGMM'); // do not localize
          device := ThreadSafe.RxBuffer[0];
        end
      except
        device := '';
      end;
      if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
      ShowNextProgress;

      try
        TxAndWait('AT+CGSN'); // do not localize
        serial := ThreadSafe.RxBuffer[0];
      except
        serial := _('Unknown');
      end;
      if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
      ShowNextProgress; 

      { Detect phone database state }
      dlg.SetDescr(_('Opening phone database'));
      CurrentIdentity := ExtractPhoneIdentity(model,serial);
      PhoneChanged := AnsiCompareText(PhoneIdentity,CurrentIdentity) <> 0;
      Log.AddMessage('Auto-connect: Prev phone ID: '+PhoneIdentity, lsDebug); // do not localize debug
      Log.AddMessage('Auto-connect: Curr phone ID: '+CurrentIdentity, lsDebug); // do not localize debug
      if IsAutoConnect then begin
        if PhoneChanged then begin
          Log.AddMessage('Auto-connect: NEW phone found!', lsDebug); // do not localize debug
          Log.AddMessage('Auto-connect: Doing normal connect...', lsDebug); // do not localize debug
        end
        else begin
          Log.AddMessage('Auto-connect: Previous phone found!', lsDebug); // do not localize debug
          Log.AddMessage('Auto-connect: Doing fast re-connect...', lsDebug); // do not localize debug
        end;
      end;
      { Load phone database settings and show as connected }
      Log.AddMessage('Opening phone database', lsDebug); // do not localize debug
      try
        if PhoneChanged then begin
          FRelocateDBDenied := False;
          FAutoConnectionError := False;
        end;
        LoadPhoneDataFiles(CurrentIdentity,False);
      except
      end;
      EData := ExplorerNew.GetNodeData(ExplorerNew.GetFirst);
      if FSelPhone = '' then begin
        CoolTrayIcon1.Hint := WideFormat(_('Connected to %s phone'), [model]);
        if device = '' then
          EData.Text := WideFormat(_('My %s Phone'), [model])
        else
          EData.Text := WideFormat(_('My %0:s Phone (%1:s)'), [model,device]);
      end
      else begin
        CoolTrayIcon1.Hint := WideFormat(_('Connected to %s'), [FSelPhone]);
        EData.Text := FSelPhone;
      end;
      EData.ImageIndex := 52;
      ExplorerNew.Repaint;
      Caption := WideFormat(_('floAt''s Mobile Agent %s - [%s]'),[GetBuildVersionDtl,EData.Text]);
      SetPanelText(1,model);
      CoolTrayIcon1.HideBalloonHint; // if previous 'failed' is shown, hide it
      ShowNextProgress;

      if IsAutoConnect then begin
        if PhoneChanged then begin
          { Cancel auto-connect }
          ActionConnectionMonitor.Tag := 0;
          if CanShowProgress then
            dlg.ShowProgress(False);
        end;
        DoProximityNear;
      end;

      dlg.SetDescr(_('Switching character set'));
      Log.AddCommunicationMessage('Try switching character set to UTF-8 or Latin-1',lsDebug); // do not localize debug
      try
        FUseUTF8 := False;
        TxAndWait('AT+CSCS=?'); // do not localize
        { UTF-8 has priority than Laton-1 - UTF gives us cyrillic support }
        if Pos('UTF-8',FSupportedCS) <> 0 then // do not localize
          begin
            TxAndWait('AT+CSCS="UTF-8"'); // do not localize
            FUseUTF8 := True;
          end
        else
          if Pos('8859-1',FSupportedCS) <> 0 then // do not localize
            TxAndWait('AT+CSCS="8859-1"') // do not localize
          else
            Log.AddCommunicationMessage('TODO: Add UCS-2 support!',lsDebug); // do not localize debug
        ThreadSafe.DoCharConvertion := False;
      except;
        Log.AddCommunicationMessage('Will convert characters manually',lsDebug); // do not localize debug
        ThreadSafe.DoCharConvertion := True;
      end;
      if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
      ShowNextProgress;

      dlg.SetDescr(_('Checking SIM status'));
      Log.AddCommunicationMessage('Check SIM status',lsDebug); // do not localize debug
      try TxAndWait('AT+CPIN?'); except; end; // do not localize
      try
        TxAndWait('AT+COPS=3,0'); // do not localize
        TxAndWait('AT+COPS?'); // do not localize
      except; end;
      if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
      ShowNextProgress;

      dlg.SetDescr(_('Setting caller ID'));
      Log.AddCommunicationMessage('Request calling line ident',lsDebug); // do not localize debug
      try TxAndWait('AT+CLIP=1'); except; end; // do not localize
      if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
      ShowNextProgress;

      dlg.SetDescr(_('Setting presentation ID'));
      Log.AddCommunicationMessage('Request Alpha Tags',lsDebug); // do not localize debug
      try TxAndWait('AT*EIPS=1,1'); except; end; // do not localize
      try TxAndWait('AT*EIPS=2,1'); except; end; // do not localize
      if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
      ShowNextProgress;

      dlg.SetDescr(_('Setting call monitoring'));
      Log.AddCommunicationMessage('Enable Call Monitoring',lsDebug); // do not localize debug
      try TxAndWait('AT*ECAM=1'); except; end; // do not localize
      if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
      ShowNextProgress;

      // new msg indication
      dlg.SetDescr(_('Setting sms notification'));
      Log.AddCommunicationMessage('Enable New Msg Notification',lsDebug); // do not localize debug
      try
        TxAndWait('AT+CNMI=?'); // do not localize
        if FStatusReport then
          s := ',0,1' // do not localize
        else begin
          s := '';
          Log.AddCommunicationMessage('New Messages: Status Report to Terminal not supported!',lsDebug); // do not localize debug
        end;
        if FUseCNMIMode3 then
          TxAndWait('AT+CNMI=3,1'+s) // do not localize
        else begin
          Log.AddCommunicationMessage('New Messages: Class 3 Delivery not supported!',lsDebug); // do not localize debug
          try
            TxAndWait('AT+CNMI=2,1'+s); // do not localize
          except
            Log.AddCommunicationMessage('New Messages: Class 2 Delivery not supported!',lsDebug); // do not localize debug
            //TxAndWait('AT+CNMI=1,1'+s); // trying to guess (1)
          end;
        end;
      except; end;
      if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
      ShowNextProgress;

      dlg.SetDescr(_('Setting mute notification'));
      Log.AddCommunicationMessage('Enable Music Mute Notification',lsDebug); // do not localize debug
      try TxAndWait('AT*EMIR=1'); except; end; // do not localize
      if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
      ShowNextProgress;

      if not IsAutoConnect then begin
        dlg.SetDescr(_('Checking voice support'));
        Log.AddCommunicationMessage('Check for special voice dialing commands (dial) (T68, T610)',lsDebug); // do not localize debug
        try
          TxAndWait('AT*EVD=?'); // do not localize
          FHaveVoiceDialCommand_Dial := True;
        except;
          Log.AddCommunicationMessage('Voice dialing dial command not supported! Will use old style dialing commands',lsDebug); // do not localize debug
          FHaveVoiceDialCommand_Dial := False;
        end;
        Log.AddCommunicationMessage('Check for special voice dialing commands (answer) (T68, T610)',lsDebug); // do not localize debug
        try
          TxAndWait('AT*EVA=?'); // do not localize
          FHaveVoiceDialCommand_Answer := True;
        except;
          Log.AddCommunicationMessage('Voice dialing answer command not supported! Will use old style dialing commands',lsDebug); // do not localize debug
          FHaveVoiceDialCommand_Answer := False;
        end;
        Log.AddCommunicationMessage('Check for special voice dialing commands (hangup) (T68, T610)',lsDebug); // do not localize debug
        try
          TxAndWait('AT*EVH=?'); // do not localize
          FHaveVoiceDialCommand_Hangup := True;
        except;
          Log.AddCommunicationMessage('Voice dialing hangup command not supported! Will use old style dialing commands',lsDebug); // do not localize debug
          FHaveVoiceDialCommand_Hangup := False;
        end;
        if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
        ShowNextProgress;

        FUseObex := False;
        FUseObexCompat := False;
        if not FStartupOptions.NoObex then begin
          dlg.SetDescr(_('Checking Obex support'));
          Log.AddCommunicationMessage('Checking OBEX Capability',lsDebug); // do not localize debug
          try
            TxAndWait('AT*EOBEX=?'); // do not localize
            FUseObex := True;
            LMDFMDrop.Enabled := True;
            Log.AddCommunicationMessage('E0BEX is supported', lsDebug); // do not localize debug
          except
            Log.AddCommunicationMessage('E0BEX is not supported', lsDebug); // do not localize debug
          end;
          if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
          if not FUseObex then begin
            try
              TxAndWait('AT+CPROT=?'); // do not localize
              FUseObex := True;
              FUseObexCompat := True;
              LMDFMDrop.Enabled := True;
              Log.AddCommunicationMessage('CPROT is supported', lsDebug); // do not localize debug
            except
              Log.AddCommunicationMessage('CPROT is not supported', lsDebug); // do not localize debug
            end;
            if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
          end;
        end;
        ShowNextProgress;

        if FUseObex then begin
          dlg.SetDescr(_('Build contact structure'));
          Log.AddCommunicationMessage('Obex Build contact structure',lsDebug); // do not localize debug
          if not FStartupOptions.NoIRMC then
            try
              GetContactRestrict;
            except
              Log.AddCommunicationMessage('Obex Build contact by defaults',lsDebug); // do not localize debug
            end
          else
            try
              frmSyncPhonebook.OnConnected;
            except
            end;
          Status(_('Connecting...'),False); // restore status
          if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
          ShowNextProgress;

          if not FStartupOptions.NoFolders then begin
            dlg.SetDescr(_('Build phone folders'));
            Log.AddCommunicationMessage('Obex Build phone folders',lsDebug); // do not localize debug
            try InitObexFolders; except; end;
            if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
          end
          else
            Log.AddMessage('Startup: Skipping folders loading', lsDebug); // do not localize debug
          ShowNextProgress;
        end
        else begin
          dlg.SetDescr(_('Retrieving Phone info'));
          Log.AddCommunicationMessage('Retrieving Phone info',lsDebug); // do not localize debug
          try
            frmSyncPhonebook.OnConnected;
          except
          end;
          if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
          ShowNextProgress(2);
        end;
      end
      else begin
        ExplorerNew.Expanded[FNodeObex] := True;
        ShowNextProgress(4);
      end;

      dlg.SetDescr(_('Checking keypad support'));
      Log.AddCommunicationMessage('Checking keypad support',lsDebug); // do not localize debug
      try
        { TODO: use TxAndWait('AT*CMEC?'); // do not localize }
        { Set to 2 so ME keypad can be operated from both ME keypad and TE }
        if IsK750Clone then // only supported on K750+ phones ?
          TxAndWait('AT+CMEC=2'); // do not localize
      except
      end;
      try
        TxAndWait('AT+CKPD=?'); // do not localize
        ActionToolsKeyPad.Visible := True;
        frmKeyPad.SetKeysMode(IsT610Clone or IsK700Clone or IsK750Clone or IsK610Clone or IsWalkmanClone);
      except
        Log.AddCommunicationMessage('Send key (keypad) not supported',lsDebug); // do not localize debug
      end;
      if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
      ShowNextProgress; 

      if not IsAutoConnect then begin
        if not FStartupOptions.NoProfiles then begin
          dlg.SetDescr(_('Retrieving profiles'));
          Log.AddCommunicationMessage('Retrieving profiles',lsDebug); // do not localize debug
          try InitProfile; except; end;
          if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
        end;
        ShowNextProgress;

        if not FStartupOptions.NoGroups then begin
          dlg.SetDescr(_('Retrieving groups'));
          Log.AddCommunicationMessage('Retrieving groups',lsDebug); // do not localize debug
          try InitGroups; except; end;
          if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
        end
        else
          Log.AddCommunicationMessage('Startup: Skipping groups loading', lsDebug); // do not localize debug
        ShowNextProgress;

        if not FStartupOptions.NoCalls then begin
          dlg.SetDescr(_('Retrieving calls'));
          Log.AddCommunicationMessage('Retrieving calls',lsDebug); // do not localize debug
          try InitCalls; except; end;
          if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
        end;
        ShowNextProgress;

        if not FStartupOptions.NoAlarms then begin
          dlg.SetDescr(_('Retrieving alarms'));
          Log.AddCommunicationMessage('Retrieving alarms',lsDebug); // do not localize debug
          try InitAlarms; except; end;
          if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
        end;
        ShowNextProgress;

        //if not FStartupOptions.NoBookmarks then begin
        dlg.SetDescr(_('Retrieving bookmarks info'));
        Log.AddCommunicationMessage('Retrieving bookmarks info',lsDebug); // do not localize debug
        try
          frmSyncBookmarks.OnConnected;
        except;
        end;
        if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
        //end;
        ShowNextProgress;

        dlg.SetDescr(_('Retrieving SIM info'));
        Log.AddCommunicationMessage('Retrieving SIM info',lsDebug); // do not localize debug
        try
          frmSMEdit.OnConnected;
        except;
        end;
        if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
        ShowNextProgress;

        dlg.SetDescr(_('Retrieving phone book info'));
        Log.AddCommunicationMessage('Retrieving Phone book info',lsDebug); // do not localize debug
        try
          frmMEEdit.OnConnected;
        except;
        end;
        if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
        ShowNextProgress;
      end
      else begin
        ExplorerNew.Expanded[FNodeProfiles] := True;
        ExplorerNew.Expanded[FNodeGroups] := True;
        ExplorerNew.Expanded[FNodeCalls] := True;
        ShowNextProgress(7);
      end;

      dlg.SetDescr(_('Retrieving phone info'));
      Log.AddCommunicationMessage('Retrieve Identification Information',lsDebug); // do not localize debug
      try frmInfoView.GetIdent; except; end;
      if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
      ShowNextProgress;

      // checking alternate metering
      FUseCIND := False;
      dlg.SetDescr(_('Checking indication support'));
      Log.AddCommunicationMessage('Checking Indication Capability',lsDebug); // do not localize debug
      try
        TxAndWait('AT+CIND=?'); // do not localize
        FUseCIND := True;
        Log.AddCommunicationMessage('Indication CIND supported', lsDebug); // do not localize debug
      except
        Log.AddCommunicationMessage('Indication CIND not supported',lsDebug); // do not localize debug
      end;
      if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
      ShowNextProgress;

      if FUseCBC then begin
        dlg.SetDescr(_('Checking battery support'));
        Log.AddCommunicationMessage('Checking Battery Capability',lsDebug); // do not localize debug
        try
          TxAndWait('AT+CBC=?'); // do not localize
          Log.AddCommunicationMessage('Battery CBC supported', lsDebug) // do not localize debug
        except
          FUseCBC := False;
          Log.AddCommunicationMessage('Battery CBC not supported',lsDebug); // do not localize debug
        end;
      end;
      if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
      ShowNextProgress;

      if FUseCSQ then begin
        dlg.SetDescr(_('Checking signal support'));
        Log.AddCommunicationMessage('Checking Signal Capability',lsDebug); // do not localize debug
        try
          TxAndWait('AT+CSQ=?'); // do not localize
          Log.AddCommunicationMessage('Signal CSQ supported', lsDebug); // do not localize debug
        except
          FUseCSQ := False;
          Log.AddCommunicationMessage('Signal CSQ not supported',lsDebug); // do not localize debug
        end;
      end;
      if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
      ShowNextProgress;

      { Testing 
      FUseCBC := False;
      FUseCSQ := False;
      { Can we use alternate mettering? }
      if FUseCIND then begin
        if not FUseCBC then begin
          FUseAlternateBatteryMeter := True;
          FUseCBC := True;
        end;
        if not FUseCSQ then begin
          FUseAlternateSignalMeter := True;
          FUseCSQ := True;
        end;
      end;

      if FUseCBC then begin
        dlg.SetDescr(_('Retrieving battery status'));
        Log.AddCommunicationMessage('Retrieve Battery Status',lsDebug); // do not localize debug
        try
          GetBatteryMeter;
        except;
        end;
      end
      else begin
        SetPanelText(2, _('Battery N/A'));
        pbPower.Position := 0;
      end;
      if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
      ShowNextProgress; 

      if FUseCSQ then begin
        dlg.SetDescr(_('Retrieving signal status'));
        Log.AddCommunicationMessage('Retrieve Signal Status',lsDebug); // do not localize debug
        try
          if FUseAlternateBatteryMeter and FUseAlternateSignalMeter then Abort; // ignore double +CIND ATs
          GetSignalMeter;
        except
        end;
      end
      else begin
        SetPanelText(3, _('Signal N/A'));
        pbRSSI.Position := 0;
      end;
      if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
      ShowNextProgress; 

      if not IsAutoConnect and IsWalkmanClone then begin
        dlg.SetDescr(_('Checking Media Player support'));
        Log.AddCommunicationMessage('Checking for W800 Media Player support',lsDebug); // do not localize debug
        try
          TxAndWait('AT*SEMP=?'); // do not localize
          FUseMediaPlayer := True;
        except;
          FUseMediaPlayer := False;
        end;
      end;
      ShowNextProgress; 

      if not IsAutoConnect and not FStartupOptions.NoClock then begin
        if FSyncClockPrio <> 0 then begin // is it enabled?
          dlg.SetDescr(_('Checking phone clock'));
          Log.AddCommunicationMessage('Synchronizing Phone Clock with PC Clock',lsDebug); // do not localize debug
          try TxAndWait('AT+CCLK?'); except; end; // do not localize
        end;
        if ThreadSafe.AbortDetected or ThreadSafe.Timedout then Abort;
      end;
      ShowNextProgress; 

      if FAutoProfile then begin
        cbProfile.ItemIndex := cbProfile.Items.IndexOf(FormStorage1.StoredValue['AutoProfileName']); // do not localize
        if cbProfile.ItemIndex <> -1 then cbProfileChange(cbProfile);
      end;
    finally
      FreeProgressDialog;
      if ExplorerNew.FocusedNode <> nil then
        ExplorerNew.IsVisible[ExplorerNew.FocusedNode] := True;
    end;
    DoReady;
  finally
    CoolTrayIcon1.CycleIcons := False;
    CoolTrayIcon1.IconIndex := 0;
  end;
  CoolTrayIcon1.IconIndex := 5; // show as connected
  { notify any open common properties dialog }
  if Assigned(frmFolderProps) then
    frmFolderProps.OnConnectionChange(True);
  { update FMA Today page }
  frmInfoView.UpdateWelcomePage(True);
end;

procedure TForm1.ActionConnectionDisconnectExecute(Sender: TObject);
begin
  try
    if not IsAutoConnect then begin
      Status(_('Disconnecting...')); // will be added to LOG too!
      CoolTrayIcon1.Hint := _('Disconnecting...');
    end;
    { Cancel auto-connect if toolbar button is clicked by user }
    if Assigned(Sender) then
      ActionConnectionMonitor.Tag := 0;
    if FObex.Connected then FObex.ForceAbort;
    DoDisconnect;
    ExplorerNew.Repaint;
    Status('');
  except
    Status(_('Disconnection Error'));
  end;
end;

procedure TForm1.ComPortAfterClose(Sender: TObject);
var data: PFmaExplorerNode;
begin
  ThreadSafe.WaitStr := 'ERROR'; // do not localize
  SetEvent(WaitCompleteEvent);
  { notify any open common properties dialog }
  if Assigned(frmFolderProps) then
    frmFolderProps.OnConnectionChange(False);

  FMessage := '';
  EBCALastState := -1;

  if FAppInitialized and FConnected and FConnectingComplete then begin
    // Do not play sound on exiting
    if not FExiting and not Application.Terminated then begin
      if not FProximityActive then
        PlaySound(pChar('FMA_MEDisconnected'), 0, SND_ASYNC or SND_APPLICATION or SND_NODEFAULT); // do not localize
      if not FAutoConnectionError and not FStartupOptions.NoBaloons then
        if FTemporaryOffline then
          ShowBaloonInfo(_('Phone is temporary disconnected...'))
        else
          ShowBaloonInfo(_('Phone disconnected or out of range.'));
    end;
    // On disconnect should be processed everytime
    ScriptEvent('OnDisconnected', []); // do not localize
  end;

  FUseMediaPlayer := False;
  FBatteryWarning := False;
  FStartupSyncFinished := False;
  FConnectingStarted := False;
  FConnectingComplete := False;
  FConnected := False;
  FSendingMessage := False;
  FUseAlternateSignalMeter := False;
  FUseAlternateBatteryMeter := False;
  ThreadSafe.AlreadyInUseObex := False;
  ThreadSafe.ObexConnecting := False;
  FObex.Connected := False;

  ExplorerNew.Repaint;

  if FProximityActive then SetPanelText(0,_('Proximity')) else SetPanelText(0, _('Disconnected'));
  SetPanelText(1);
  SetPanelText(2);
  SetPanelText(3);

  CoolTrayIcon1.CycleIcons := False;
  CoolTrayIcon1.IconIndex := 0;
  CoolTrayIcon1.Hint := _('Not Connected');

  ActionToolsKeyPad.Visible := False;
  LMDFMDrop.Enabled := False;

  if ExplorerNew.NodeDataSize > 0 then begin
    data := ExplorerNew.GetNodeData(ExplorerNew.GetFirst);
    if Assigned(data) then begin
      if data.ImageIndex = 45 then data.ImageIndex := 44 else data.ImageIndex := 51;
      if FSelPhone = '' then FSelPhone := _('My Phone');
      data.Text := FSelPhone;
      ExplorerNew.Repaint;
      Caption := WideFormat(_('floAt''s Mobile Agent %s - [%s]'),[GetBuildVersionDtl,data.Text]);
    end;
  end;

  // hide call dialog
  if Assigned(frmCalling) and frmCalling.IsCreated then
    frmCalling.CloseCall;

  // hide alarm dialog
  if Assigned(frmNewAlarm) and frmNewAlarm.Visible then
    frmNewAlarm.Close; 
end;

procedure TForm1.HandleMessage(var Msg: TFmaHandleMessage);
var
  AMsg: String;
begin
  AMsg := StrPas(Msg.Message);
  StrDispose(Msg.Message);

  // AMsg := trim(AMsg); This will alter response, so it is commented! Dako
  Log.AddCommunicationMessage('[RX] ' + LongStringToWideString(AMsg), lsDebug); // do not localize debug
  // Reset inactivity timeout
  if pos('*EBCA', AMsg) <> 1 then // do not localize
    ThreadSafe.MSec := GetTickCount + ThreadSafe.InactivityTimeout;
  try
    try
      if pos('RING', AMsg) = 1 then begin // do not localize
        HandleRinging;
      end
      else if pos('*ECAV', AMsg) = 1 then begin // do not localize
        HandleECAV(AMsg);
      end
      else if pos('*EOLP', AMsg) = 1 then begin // do not localize
        HandleECAV(AMsg);
      end
      else if pos('*ELIP', AMsg) = 1 then begin // do not localize
        HandleECAV(AMsg);
      end
      else if pos('+CSQ', AMsg) = 1 then begin // do not localize
        HandleStatus(AMsg);
      end
      else if pos('+CIND', AMsg) = 1 then begin // do not localize
        HandleCIND(AMsg);
      end
      else if pos('+CBC', AMsg) = 1 then begin // do not localize
        HandleStatus(AMsg);
      end
      else if pos('+CMTI', AMsg) = 1 then begin // do not localize
        HandleCMTI(AMsg);
      end
      else if pos('+CKEV', AMsg) = 1 then begin // do not localize
        HandleCKEV(AMsg);
      end
      else if pos('+CPMS', AMsg) = 1 then begin // do not localize
        HandleCPMS(AMsg);
      end
      else if pos('+CALV', AMsg) = 1 then begin // do not localize
        HandleCALV(AMsg);
      end
      else if pos('+CIEV', AMsg) = 1 then begin // do not localize
        HandleCIEV(AMsg);
      end
      else if pos('+COPS', AMsg) = 1 then begin // do not localize
        HandleCOPS(AMsg);
      end
      else if pos('+CSCS', AMsg) = 1 then begin // do not localize
        HandleCSCS(AMsg);
      end
      else if pos('+CPIN', AMsg) = 1 then begin // do not localize
        HandleCPIN(AMsg);
      end
      else if pos('+CCLK', AMsg) = 1 then begin // do not localize
        HandleCCLK(AMsg);
      end
      else if pos('+CNMI', AMsg) = 1 then begin // do not localize
        HandleCNMI(AMsg);
      end
      else if pos('+CLCK', AMsg) = 1 then begin // do not localize
        HandleCLCK(AMsg);
      end
      else if pos('*EMIV', AMsg) = 1 then begin // do not localize
        HandleEMIV(AMsg);
      end
      else if Assigned(FAccessoriesMenu) and (pos(FAccessoriesMenu.FMenuEntryEvent, AMsg) = 1) then begin
        ScriptEvent('OnAMRoot',[]);
      end
      else if pos('*EAAI', AMsg) = 1 then begin // do not localize
        ScriptEvent('OnAMRoot', []); // do not localize
      end
      else if (pos('*EAMI', AMsg) = 1) or (pos('*EAII', AMsg) = 1) then begin // do not localize
        HandleEAMI(AMsg);
      end
      else if (pos('*SEGUII',AMsg) = 1) then begin
        HandleSEGUII(AMsg);
      end
      else if (pos('*EBCA', AMsg) = 1) then begin // do not localize
        HandleEBCA(AMsg);
      end
      else begin
        if ThreadSafe.RxBuffer <> nil then
          ThreadSafe.RxBuffer.Add(AMsg);

        if ThreadSafe.WaitStr <> '' then begin
          if ThreadSafe.WaitStr = AMsg then begin
            ThreadSafe.WaitStr := ''; // This is a signal to the thread the correct result is found
            SetEvent(WaitCompleteEvent);
          end;

          if pos('ERROR: 515', AMsg) > 0  then begin // do not localize
            Log.AddCommunicationMessage('Please wait, init in progress...', lsDebug); // do not localize debug
            // 515 means "please wait, init in progress"
            // so skip it.
          end
          else if (pos('NO CARRIER', AMsg) > 0) and
            ((ThreadSafe.LastCommand = 'AT*EOBEX') or (ThreadSafe.LastCommand = 'AT+CPROT')) then begin // do not localize
            Log.AddCommunicationMessage('Obex already in use or connect failed',lsDebug); // do not localize debug
            ThreadSafe.AlreadyInUseObex := True;
            ThreadSafe.WaitStr := '';
            SetEvent(WaitCompleteEvent);
          end
          else if pos('ERROR', AMsg) > 0  then begin // do not localize
            ThreadSafe.WaitStr := 'ERROR'; // do not localize
            SetEvent(WaitCompleteEvent);
          end;
        end;
      end;
    finally
      if AMsg = 'OK' then begin // do not localize
        ThreadSafe.WaitingOK := False;
        FScriptRunning := False;
      end;
    end;
  except
    { silent errors }
  end;
  inherited;
end;

// --------------------------------------------------------------------------------------

procedure TForm1.TxAndWait(Data, WaitStr: String);
var
  i: Integer;
//  msg: TMsg;
//  Hndl: THandle;
begin
  if ThreadSafe.RxBuffer <> nil then
    {
    if not FObex.Connected and (Length(Data) > 250) then begin
      Debug('[TX] ERROR: Data length > 250 Chars, dropped!'); // do not localize debug
      Abort;
    end;
    }
    if WaitStr = '' then begin
      { Transmit data immediately and don't wait for a response }
      Log.AddCommunicationMessage('[TX] ' + Data, lsDebug); // do not localize debug
      if ThreadSafe.ConnectionType = 0 then WBtSocket.SendStr(Data + #13)
      else if ThreadSafe.ConnectionType = 1 then WIrSocket.SendStr(Data + #13)
      else ComPort.WriteStr(Data + #13); // Serial
    end
    else try
      { If Data is '' then just check for stray WaitStr response.
        Create new thread for sending data, it will update FMSec as well }
      with TWaitThread.Create(Data,WaitStr) do
      try
        { This is the most stable version, so I shall keep it }
        while not Finished do begin
          Sleep(25); // give some CPU time to other threads, should b tested with Automation objects's calls!!
          Application.ProcessMessages;
          if ThreadSafe.Abort or ThreadSafe.AbortDetected or Application.Terminated then Abort;
        end;

        if IsErrorOccur then begin
          { Obex error NO CARRIER ? force obex abort }
          if not ThreadSafe.Timedout and ThreadSafe.ObexConnecting and FConnected then begin
            FObex.ForceAbort; // cancel obex session if needed
          end;
          { phone is out of range ? force disconnect }
          if ThreadSafe.Timedout then begin
            if IsAutoConnect and ThreadSafe.AbortDetected then
              ActionConnectionDisconnect.Execute // this execute will clear auto-connect flag
            else
              ActionConnectionDisconnectExecute(nil); // nil = do not clear auto-connect flag
          end;
          raise EInOutError.Create(GetLastError);
        end;
      finally
        Free;
        { Update actions since phone operation has completed }
        for i := 0 to ActionList1.ActionCount-1 do ActionList1.UpdateAction(ActionList1.Actions[i]);
        Update;
      end;
    except
      { Clear Watch for OK flag }
      ThreadSafe.WaitingOK := False;
      FScriptRunning := False;
      raise;
    end;
end;

procedure TForm1.FlushOK;
begin
  if FObex.Connected then ObexDisconnect;
  TxAndWait(''); // this will not transmit data, but only check for stray OK response.
  ThreadSafe.AbortDetected := ThreadSafe.AbortDetected or (FObex.IsAborted and not CoolTrayIcon1.CycleIcons);
end;

procedure TForm1.ComPortRxChar(Sender: TObject; Count: Integer);
var
  c: Char;
  i: Integer;
  buffer: String;
  PStr: PChar;
begin
  if ThreadSafe.ConnectionType = 0 then begin
    SetLength(buffer, 2048);
    SetLength(buffer, WBtSocket.Receive(@buffer[1], 2048));
  end
  else if ThreadSafe.ConnectionType = 1 then begin
    SetLength(buffer, 2048);
    SetLength(buffer, WIrSocket.Receive(@buffer[1], 2048));
  end
  else begin
    //SetLength(buffer, Count); // is done by ReadStr itself
    ComPort.ReadStr(buffer, Count);
  end;

  if ThreadSafe.DoCharConvertion then
    buffer := GSMDecode7Bit(buffer);

  for i := 1 to length(buffer) do begin
    c := buffer[i];
    //if ThreadSafe.DoCharConvertion then c := ConvertCharSet(c);
    if FObex.Connected then FObex.OnRxChar(c)
    else begin
      case c of
        #00: ;
        #10: ;
        #13: begin
          if FMessage <> '' then begin
            PStr := StrNew(PChar(FMessage));
            PostMessage(Handle, FMA_HANDLEMESSAGE, Integer(PStr), 0);
            FMessage := '';
          end;
        end;
        else begin
          FMessage := FMessage + c;
        end;
      end;

      if (FMessage = ThreadSafe.WaitStr) and (FMessage <> '') then begin
        PStr := StrNew(PChar(FMessage));
        PostMessage(Handle, FMA_HANDLEMESSAGE, Integer(PStr), 0);
        FMessage := '';
      end;
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  sa: TSecurityAttributes;
  i: Integer;
  {
  W: WideString;
  DU: array[0..200] of WideChar;
  SDI: TSoftDistInfo;
  }
  m: TTntMenuItem;
begin
  ExePath := ExtractFilePath(Application.ExeName);

  pbRSSI.Parent := StatusBar;
  pbPower.Parent := StatusBar;
  pbTask.Parent := StatusBar;
  pbTask.Position := 0;
  pbTask.Max := 100;

{$IFNDEF VER150}
  ThemeManager1 := TTntThemeManager.Create(Self);
  ThemeManager1.Options := [toAllowNonClientArea, toAllowControls, toAllowWebContent, toSubclassButtons,
    toSubclassCheckListbox, toSubclassDBLookup, toSubclassFrame, toSubclassGroupBox, toSubclassPanel,
    toSubclassTabSheet, toSubclassSpeedButtons, toSubclassStatusBar, toSubclassTrackBar, toSubclassWinControl,
    toResetMouseCapture, toSetTransparency];
{$ELSE}
  FramePanel.ParentBackground := False;
{$ENDIF}

  WaitCompleteEvent := CreateEvent(nil, False, False, nil);
  WaitCompleteIsBusyEvent := CreateSemaphore(nil,1,1,PChar('FmaIsBusy')); // do not localize

  { Check whether we are the first instance? }
  sa.nLength := SizeOf(sa);
  sa.lpSecurityDescriptor := nil;
  sa.bInheritHandle := True;
  FFmaMutex := CreateMutex(@sa,False,PChar('Fma_Instance_One_Mutex')); // do not localize
  if FmaWebUpdate1.Active or (WaitForSingleObject(FFmaMutex, 5) = WAIT_TIMEOUT) then begin
    FNotFirstInstance := True;
    { Another instance of Fma is already running }
    if FNotFirstInstance then begin
      Application.ShowMainForm := False;
    end;
  end;

  Log.AddMessageFmt('Build: %s', [GetBuildVersionDtl], lsDebug); // do not localize debug
  Log.AddMessageFmt('System: %s %s, Version: %d.%d, Build: %x, "%s"', [GetWindowsVersionString, NtProductTypeString,
    Win32MajorVersion, Win32MinorVersion, Win32BuildNumber, Win32CSDVersion], lsDebug); // do not localize debug

  for i := 0 to CoolBar.Bands.Count-1 do begin
    CoolBar.Bands[i].MinWidth := CoolBar.Bands[i].Control.Constraints.MinWidth;
    if CoolBar.Bands[i].MinWidth <> 0 then
      CoolBar.Bands[i].Width := CoolBar.Bands[i].MinWidth;
  end;
  for i := 0 to Toolbars1.Count-1 do begin
    m := TTntMenuItem.Create(Self);
    m.Action := Toolbars1.Items[i].Action;
    pmToolbars.Items.Add(m);
  end;

  FEBCAKeyMonStopped := True;
  FKeyInactivityTimeout := 10000;

  FNewMessageList := TStringList.Create;
  FNewPDUList := TStringList.Create;

  FLookupList := TTntStringList.Create;

  FFavoriteRecipients := TTntStringList.Create;
  FFavoriteCalls := TTntStringList.Create;

  FDeliveryRules := TTntStringList.Create;

  FObex := TObex.Create;
  FObex.debugobex := False;

  frmMsgView := TfrmMsgView.Create(FramePanel);
  frmMsgView.Parent := FramePanel;
  frmMsgView.Align := alClient;
{$IFDEF VER150}
  frmMsgView.DetailsPanel.ParentBackground := False;
  frmMsgView.SearchPanel.ParentBackground := False;
{$ENDIF}

  frmSMEdit := TfrmContactsSMEdit.Create(FramePanel);
  frmSMEdit.Parent := FramePanel;
  frmSMEdit.Align := alClient;

  frmMEEdit := TfrmContactsMEEdit.Create(FramePanel);
  frmMEEdit.Parent := FramePanel;
  frmMEEdit.Align := alClient;

  frmInfoView := TfrmInfoView.Create(FramePanel);
  frmInfoView.Parent := FramePanel;
  frmInfoView.Align := alClient;
  frmInfoView.PopupMenu := PopupMenu2;
  frmInfoView.BigImage.Picture.Assign(CommonBitmaps.Bitmap[1]);
{$IFDEF VER150}
  frmInfoView.Label5.Font.Color := clOlive;
  frmInfoView.Label3.Font.Color := clGreen;
  frmInfoView.Label2.Font.Color := clMaroon;
  for i := 0 to frmInfoView.ComponentCount-1 do
    if frmInfoView.Components[i] is TTntLabel then
      // hack! change all linkXXX labels font style and color
      if Pos('link',frmInfoView.Components[i].Name) = 1 then
        with frmInfoView.Components[i] as TTntLabel do begin
          Font.Color := clHotLight;
          Font.Style := Font.Style + [fsUnderline];
        end;
  frmInfoView.ParentBackground := False;
  frmInfoView.DiagramPanel.ParentBackground := False;
{$ENDIF}

  frmSyncPhonebook := TfrmSyncPhonebook.Create(FramePanel);
  frmSyncPhonebook.Parent := FramePanel;
  frmSyncPhonebook.Align := alClient;

  frmSyncBookmarks := TfrmSyncBookmarks.Create(FramePanel);
  frmSyncBookmarks.Parent := FramePanel;
  frmSyncBookmarks.Align := alClient;

  frmExplore := TfrmExplore.Create(FramePanel);
  frmExplore.Parent := FramePanel;
  frmExplore.Align := alClient;

  frmEditor := TfrmEditor.Create(FramePanel);
  frmEditor.Parent := FramePanel;
  frmEditor.Align := alClient;
{$IFDEF VER150}
  frmEditor.DetailsPanel.ParentBackground := False; // HACK!!
{$ENDIF}

  frmCalendarView := TfrmCalendarView.Create(FramePanel);
  frmCalendarView.Parent := FramePanel;
  frmCalendarView.Align := alClient;

  if not FNotFirstInstance then begin
    LoadOptions;
    InitRegistry;
  end;

  FormStorage1.Active := False;

  {
  StringToWideChar(GUIDToString(LIBID_MobileAgent),@DU[0],200);
  SDI.cbSize := SizeOf(SDI);
  GetSoftwareUpdateInfo(@DU[0],SDI);
  SoftwareUpdateMessageBox(Handle,@DU[0],0,SDI);
  }

  TP_Ignore(self, 'PanelTest'); // do not localize
  TP_Ignore(self, 'FormStorage1'); // do not localize
  gghTranslateComponent(self); // localize after all frames construction
  Caption := WideFormat(_('floAt''s Mobile Agent %s'),[GetBuildVersionDtl]);

  if IsRightToLeft then
    with frmInfoView do begin
      LMDFill2.FillObject.Gradient.Color := clBtnFace;
      LMDFill2.FillObject.Gradient.EndColor := clWindow;
      LMDFill2.Width := TodayCaptionPanel.Width - 82;
      BigImage.Left := BigImage.Left - (CommonBitmaps.Bitmap[1].Width - BigImage.Width);
      BigImage.Width := CommonBitmaps.Bitmap[1].Width;
    end;

  UpdateColorScheme;
end;

procedure TForm1.ActionSMSDownloadInboxExecute(Sender: TObject);
begin
  AskRequestConnection;
  DownloadMessages(FNodeMsgInbox);
end;

procedure TForm1.DownloadSMS(msgType: Integer; Node: PVirtualNode);
begin
  try
    DownloadSMS(msgType, 'SM', Node); // do not localize
    DownloadSMS(msgType, 'ME', Node); // do not localize
  except
    Status(_('Error Downloading SMS'));
  end;
end;

procedure TForm1.DownloadSMS(msgType: Integer; memLocation: String; Node: PVirtualNode);
var
  sl: TStringList;
  EData: PFmaExplorerNode;
begin
  if Node <> nil then begin
    EData := ExplorerNew.GetNodeData(Node);
    sl := TStringList(EData.Data);
  end
  else
    if ExplorerNew.FocusedNode = nil then
      exit
    else begin
      EData := ExplorerNew.GetNodeData(ExplorerNew.FocusedNode);
      sl := TStringList(EData.Data);
    end;
  DownloadSMS(msgType,memLocation,sl);
end;

procedure TForm1.DoDownloadSMSFromPhone(memLocation: String; index: Integer);
var
  i,memType: Integer;
  header,str,pdu: WideString;
  sl: TStringList;
begin
  if memLocation = 'ME' then memType := 1 else memType := 2; // do not localize
  { memType 1 = ME, 2 = SM, 3 means message is in PC (archive) }
  Log.AddCommunicationMessage('Downloading new message from ' + memLocation + ' at pos ' + IntToStr(index), lsDebug); // do not localize debug
  try
    {
    12:22:50:139 [TX] AT+CMGR=54
    12:22:50:340 [RX] +CMGR: 0,,24
    12:22:50:440 [RX] 07911614910910F7040B911614910631F400004060522122140405F4F29C2E03
    12:22:50:640 [RX] OK
    }
    sl := TStringList.Create;
    try
      { Download message PDU from phone }
      TxAndWait('AT+CPMS="' + memLocation + '"'); // select read and delete phonebook // do not localize
      TxAndWait('AT+CMGR=' + IntToStr(index)); // do not localize
      { Download OK }
      sl.Text := ThreadSafe.RxBuffer.Text;
      for i := 0 to sl.Count - 1 do begin
        if pos('+CMGR', sl[i]) = 1 then begin // do not localize
          header := trim(copy(sl[i], 8, length(sl[i])));
          pdu := sl[i+1];
          { TODO: 'header' already contains if the message is 'new' flag }
          str := IntToStr(memType) + ',' + IntToStr(index) + ',' + header + ',' + pdu + ',,1'; // 1=new
          // str = '1,54,0,,24,07911614910910F7040B911614910631F400004060522122140405F4F29C2E03,,1'
          { Fill downloaded messages list - It will be processed in DoProcessInbox;  }
          FNewPDUList.Add(str);
        end;
      end;
    finally
      sl.Free;
    end;
  except
    Status(_('Error downloading new message'));
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  LogVisible,ExplVisible: boolean;
begin
  if not FExit and FMinimize then begin
    { Just minimize }
    Action := caNone;
    Application.Minimize;
  end
  else begin
    { Exit now... }
    FExiting := True;
    ExplVisible := ActionConnectionExplorer.Checked;
    try
      if PanelTest.Visible then DebugTools1.Click; // Hide developer tools (if any)
      if ExplVisible then ActionConnectionExplorer.Execute; // Hide explorer
      SetFrameVisible(''); // Save frame internal changes
      DescrPanel.Visible := False;
      FramePanel.Font.Size := 16;
      FramePanel.Font.Color := cl3DLight;
      FramePanel.Font.Style := [fsBold];
      FramePanel.Caption := _('Exiting FMA... Have a nice day!');
      Update;
      if FConnected then
        ActionConnectionDisconnect.Execute // Disconnect and save database changes
      else
        DoDisconnect; // Save database changes
    finally
      FramePanel.ParentFont := True;
      LogVisible := Assigned(FLogForm) and FLogForm.Visible;
      FormStorage1.StoredValue['Log'] := LogVisible; // do not localize
      if LogVisible then FLogForm.Close; // Close LOG before exiting to prevent delay
      HtmlHelp(0, nil, HH_CLOSE_ALL, 0); // Close any HELP windows
      Hide;
      if ExplVisible then ActionConnectionExplorer.Execute; // Restore explorer
      { save settings }
      FormStorage1.Active := True;
      FormStorage1.SaveFormPlacement;
    end;
  end;
end;

procedure TForm1.ActionContactsDownloadExecute(Sender: TObject);
var
  sl: TStrings;
  EData: PFmaExplorerNode;
  buffer: String;
begin
  AskRequestConnection;
  if frmInfoView.Visible then EBCAState(False);
  try
    try
      EData := ExplorerNew.GetNodeData(ExplorerNew.FocusedNode);
      if (EData.StateIndex and $0C0000) = $000000 then begin
        ActionSyncPhonebookExecute(Self);
      end;
      if (EData.StateIndex and $0C0000) = $040000 then begin
        EData := ExplorerNew.GetNodeData(FNodeContactsSM);
        sl := EData.data;
        frmSMEdit.CheckForChanges;
        TxAndWait('AT+CPBS="SM"'); // do not localize
        DownloadPhonebook(buffer);
        ParsePhonebookList(buffer,sl);
        RenderContactList(FNodeContactsSM);
        frmSMEdit.RenderData;
        { clear contact lookup cache }
        FLookupList.Clear;
      end;
      { Update database }
      SavePhoneDataFiles(True);
    except
      Status(_('Error downloading phonebook'));
    end;
  finally
    if frmInfoView.Visible then EBCAState(True);
  end;
end;

procedure TForm1.DownloadPhonebook(var ABuffer: string);
var
  i,j: Integer;
  buffer, start, stop, FromTo: String;
  slTmp: TStrings;
  dlg: TfrmConnect;
begin
  buffer := '';
  slTmp := TStringList.Create;
  try
    TxAndWait('AT+CPBR=?'); // do not localize
    slTmp.Text := ThreadSafe.RxBuffer.Text;
    for j := 0 to slTmp.Count-1 do
      if Pos('+CPBR',slTmp[j]) = 1 then begin // do not localize
        buffer := slTmp[j];
        for i := 1 to length(buffer) do 
          if IsDelimiter('()-', buffer, i) then buffer[i] := ' '; // do not localize
        break;
      end;
    if buffer = '' then Abort;

    slTmp.DelimitedText := buffer;
    start := slTmp.Strings[1];
    stop := slTmp.Strings[2];
  finally
    slTmp.Free;
  end;

  FromTo := start + ' - ' + stop; // do not localize
  Status(WideFormat(_('Downloading phonebook (%s)...'), [FromTo]));
  dlg := GetProgressDialog;
  try
    if CanShowProgress then
      dlg.ShowProgress(FProgressLongOnly);
    dlg.SetDescr(_('Downloading phonebook'));
    TxAndWait('AT+CPBR=' + start + ',' + stop); // do not localize
    ABuffer := ThreadSafe.RxBuffer.Text;
    Status(_('Download completed'));
  finally
    FreeProgressDialog;
  end;
end;

procedure TForm1.ParsePhonebookList(const buffer: String; var sl: TStrings);
var
  Name, s: WideString;
  i, position: Integer;
  Number, NumType: String;
  ml: TStringList;
begin
  { Parameter 'buffer' should be result (all lines) from command 'AT+CPBR=1,xxx' }
  sl.Clear;
  ml := TStringList.Create;
  ml.Text := buffer;
  try
    for i := 0 to ml.Count - 1 do begin
      if pos('+CPBR', ml[i]) = 1 then begin // do not localize
        s := LongStringToWideString(ml[i]);
        Delete(s,1,7);
        if FUseUTF8 then s := UTF8StringToWideString(WideStringToLongString(s));
        position := StrToInt(GetFirstToken(s));
        Number := GetFirstToken(s);
        NumType := GetFirstToken(s);
        Name := GetFirstToken(s);

        if (NumType = '145') and (Number[1] <> '+') then
          Number := '+' + Number;

        sl.Add(UTF8Encode(WideQuoteStr(Name,True)) + ',' + Number + ',' + IntToStr(position) +
          ',3' + // 3 = not modified (new) item
          ',' + GUIDToString(NewGUID) + ',""'); // CDID and LUID fields
      end;
    end;
  finally
    ml.Free;
    TStringList(sl).Sort;
  end;
end;

procedure TForm1.RenderContactLists;
begin
  ExplorerNew.BeginUpdate;
  try
    RenderContactList(FNodeContactsME);
    RenderContactList(FNodeContactsSM);
  finally
    ExplorerNew.EndUpdate;
  end;
end;

procedure TForm1.RenderContactList(var rootNode: PVirtualNode);
var
  nameNode, numNode, node: PVirtualNode;
  EData: PFmaExplorerNode;
  i: Integer;
  sl: TStrings;
  tracker: TTntStringList;
  s, Names, NumType: WideString;
  Number, position, partialNumber: String;
begin
  ExplorerNew.BeginUpdate;
  try
    EData := ExplorerNew.GetNodeData(rootNode);
    sl := EData.Data;
    ExplorerNew.DeleteChildren(rootNode);

    nameNode := nil;
    tracker := TTntStringList.Create;
    try
      i := 0;
      while i < sl.Count do begin
        try
          s := LongStringToWideString(sl[i]);
          if Trim(s) = '' then continue;

          { Workaround for NewLine chars in contact names }
          while (not EvenQuotes(s)) and (i < sl.Count - 2) do begin
            Inc(i);
            s := s + sLinebreak + LongStringToWideString(sl.Strings[i]);
          end;

          Names := UTF8StringToWideString(WideStringToLongString(GetFirstToken(s)));
          Number := GetFirstToken(s);
          position := GetFirstToken(s);

          ExtractName(Names, NumType);

          partialNumber := GetPartialNumber(Number);
          FLookupList.Values[partialNumber] := Names;

          if tracker.IndexOf(Names) = -1 then begin
            nameNode := ExplorerNew.AddChild(rootNode);
            EData := ExplorerNew.GetNodeData(nameNode);
            EData.Text := Names;
            EData.ImageIndex := 8;
            tracker.Add(Names);
          end
          else begin
            node := rootNode;
            while node <> nil do begin
              EData := ExplorerNew.GetNodeData(node);
              if WideCompareStr(EData.Text,Names) = 0 then begin
                nameNode := node;
                break;
              end;
              node := node.NextSibling;
            end;
          end;

          if Number <> '' then begin
            { Each number's StateIndex contains its position in phonebook }
            numNode := ExplorerNew.AddChild(nameNode);
            EData := ExplorerNew.GetNodeData(numNode);
            EData.Text := Number;
            EData.StateIndex := StrToInt(position);

            if NumType = 'H' then EData.ImageIndex := 9 // do not localize
            else if NumType = 'M' then EData.ImageIndex := 10 // do not localize
            else if NumType = 'W' then EData.ImageIndex := 11 // do not localize
            else if NumType = 'F' then EData.ImageIndex := 12 // do not localize
            else EData.ImageIndex := 13;
          end;
        except
          Log.AddMessageFmt(_('Database: Error loading data (DB Index %d)'), [i], lsError);
          if FindCmdLineSwitch('FIXDB') then begin
            sl[i] := '';
            Log.AddMessageFmt(_('Database: Removed incorrect data (DB Index: %d)'), [i], lsInformation);
          end;
        end;
        Inc(i);
      end;
    finally
      tracker.Free;
    end;
  finally
    ExplorerNew.Sort(RootNode, 0, sdAscending);
    ExplorerNew.EndUpdate;
    { Update explorer default view if nessesery }
    if (ExplorerNew.FocusedNode = rootNode) and frmExplore.Visible then
      frmExplore.RootNode := rootNode;
  end;
end;

procedure TForm1.ContactListGetSelectedIndex(Sender: TObject;
  Node: TTreeNode);
begin
  Node.SelectedIndex := Node.ImageIndex;
end;

function TForm1.LookupContact(Number: WideString; DefaultName: WideString): WideString;
var
  partialNumber: String;
  node: PVirtualNode;
  data: PFmaExplorerNode;
begin
  Result := '';
  { remove any name suplyed }
  Number := ExtractNumber(Number);
  if Number <> '' then begin
    { lookup in cache first }
    partialNumber := GetPartialNumber(Number);
    if FLookupList.IndexOfName(partialNumber) = -1 then begin
      { then lookup in various address book places }
      case WhereisContact(Number,fcByNumber) of
        frIrmcSync:
          Result := frmSyncPhonebook.FindContact(Number);
        frPhonebook: begin
          node := FindExplorerPhoneNode(Number,FNodeContactsME);
          data := ExplorerNew.GetNodeData(node);
          if data <> nil then
            Result := data.Text;
        end;
        frSIMCard: begin
          node := FindExplorerPhoneNode(Number,FNodeContactsSM);
          data := ExplorerNew.GetNodeData(node);
          if data <> nil then
            Result := data.Text;
        end;
      end;
      FLookupList.Add(partialNumber + '=' + Result);
    end
    else
      Result := FLookupList.Values[partialNumber];
  end;
  { return default name if not found }
  if Result = '' then Result := DefaultName;
end;

procedure TForm1.ExplorerNewChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  EData: PFmaExplorerNode;
  s: WideString;
begin
  if ExplorerNew.GetFirstSelected <> Node then begin
    SetExplorerNode(Node);
    Exit; // SetExplorerNode() generates OnChange event.
  end;

  try
    if Node <> nil then begin
      { hide developer tools if node changed }
      if DebugTools1.Checked and (Node <> ExplorerNew.GetFirst) then
        DebugTools1Click(nil);
      { change selection }
      ExplorerNew.InvalidateNode(Node);
      EData := Sender.GetNodeData(Node);
      { Set custom Refresh Action captions }
      if Node = FNodeContactsSM then
        ActionConnectionDownload.Hint := _('Download Phonebook')
      else
      if Node = FNodeContactsME then begin
        if IsIrmcSyncEnabled then
          ActionConnectionDownload.Hint := _('Synchronize Phonebook')
        else
          ActionConnectionDownload.Hint := _('Download Phonebook');
      end
      else
      if Node = FNodeCalendar then
        ActionConnectionDownload.Hint := _('Synchronize Calendar')
      else
      if Node = FNodeAlarms then
        ActionConnectionDownload.Hint := _('Download Alarms')
      else
      if Node = FNodeBookmarks then
        ActionConnectionDownload.Hint := _('Synchronize Bookmarks')
      else
        ActionConnectionDownload.Hint := _('Refresh Data');

      if ((EData.StateIndex and $F00000) = FmaMessagesRootFlag) and
        ((EData.StateIndex and FmaNodeSubitemsMask) <> 0) then begin // SMS text Messages
        ActionConnectionDownload.Hint := _('Download Messages');
        SetFrameVisible('MSG'); // do not localize
        if not frmMsgView.IsRendered(TStringList(EData.Data)) then
          frmMsgView.RenderListView(TStringList(EData.Data));
      end
      else if (EData.StateIndex and $F00000) = $100000 then begin // Contacts

      end
      else if (EData.StateIndex and $F00000) = $500000 then begin // Files
        SetFrameVisible('EXPLORE'); // do not localize
      end
      else if (EData.StateIndex and $F00000) = $700000 then begin // Profiles
        SetFrameVisible('EXPLORE'); // do not localize
      end
      else if (EData.StateIndex and $F00000) = $800000 then begin // Groups
        SetFrameVisible('EXPLORE'); // do not localize
      end
      else if Node <> ExplorerNew.GetFirst then begin // Common Explore
        SetFrameVisible('EXPLORE'); // do not localize
      end
      else if (Node = ExplorerNew.GetFirst) then begin // Root
        if PanelTest.Enabled then
          SetFrameVisible('')
        else
          SetFrameVisible('INFO'); // Fma Today // do not localize
      end;
      if Node = FNodeContactsSM then begin // SIM book
        SetFrameVisible('SM'); // do not localize
        if not frmSMEdit.IsRendered then frmSMEdit.RenderData;
      end else
      if Node = FNodeContactsME then begin // Phone book
        if not IsIrmcSyncEnabled then begin
          SetFrameVisible('ME'); // No-IRMC // do not localize
          if not frmMEEdit.IsRendered then frmMEEdit.RenderData;
        end
        else begin
          SetFrameVisible('PHONE'); // IRMC // do not localize
        end;
      end else
      if Node = FNodeCalendar then begin // Calendar
        { If not IrmcSync, disable Calendar view.
          Temporary until Outlook Calendar sync is implemented }
        if FStartupOptions.NoObex or FStartupOptions.NoIRMC then
          SetFrameVisible('EXPLORE') // do not localize
        else begin
          SetFrameVisible('CALENDAR'); // do not localize

          if FCalWideView and ActionConnectionExplorer.Checked then
            ActionConnectionExplorer.Execute; // set Wide mode

          frmCalendarView.OnConnected; // check auto-recurrence
        end;
      end;
      if Node = FNodeScripts then begin // Script Editor
        if FUseScriptEditorExt then begin
          SetFrameVisible('EXPLORE'); // do not localize
          ActionToolsEditScript.Execute;
        end
        else
          SetFrameVisible('SCRIPT'); // do not localize
      end;
      if Node = FNodeBookmarks then begin // Bookmarks
        SetFrameVisible('BOOKMARK'); // do not localize
        if not frmSyncBookmarks.IsRendered then frmSyncBookmarks.RenderList;
      end;
      if Node = FNodeAlarms then begin // Alarms
        SetFrameVisible('EXPLORE'); // do not localize
      end;
    end
    else
      SetFrameVisible('');
    if ExplorerNew.FocusedNode <> nil then begin
      EData := ExplorerNew.GetNodeData(ExplorerNew.FocusedNode);
      s := EData.Text;
      if ExplorerNew.FocusedNode = ExplorerNew.GetFirst then begin
        lblCurrentPage.Caption := _('FMA Today');
        lblCurrentPageDtls.Left := lblCurrentPage.Left*2 + lblCurrentPage.Width;
        lblCurrentPageDtls.Caption := s;
        lblCurrentPageDtls.Visible := True;
      end
      else begin
        if EData.SpecialImagesFlags and $80 <> 0 then begin
          if EData.SpecialImages > 0 then
            s := s + ' (' + IntToStr(EData.SpecialImages) + ')';
        end;
        lblCurrentPage.Caption := s;
        lblCurrentPageDtls.Visible := False;
      end;
    end;
  finally
    UpdateSpecialMonitors;
  end;
end;

procedure TForm1.ActionConnectionDownloadExecute(Sender: TObject);
var
  id: Integer;
  data: PFmaExplorerNode;
begin
  data := ExplorerNew.GetNodeData(ExplorerNew.FocusedNode);
  id := data.StateIndex;
  { Do not ask for connection if refreshing Archive, Drafts or Custom SMS folders }
  if (id and $F00000 <> FmaMessagesRootFlag) or (id and FmaNodeSubitemsMask = 0) then
    AskRequestConnection;

  // Contacts
  if (id and $F00000) = $100000 then ActionContactsDownloadExecute(Self);
  // Messages
  if (id and $F00000) = FmaMessagesRootFlag then
    if (id and FmaMessageFolderFlag) = 0 then
      { Text Messages, Inbox or Sent Items folders }
      if (id and FmaNodeSubitemsMask) = 0 then
        DownloadAllMessages // this is Text Messages root folder, so download all of them :)
      else
        DownloadMessages(ExplorerNew.FocusedNode) // this will work for both Inbox and Send Items
    else
      { Archive, Drafts and Custom folders }
      UpdateNewMessagesCounter(ExplorerNew.FocusedNode);
  // Calls
  if (id and $F00000) = $400000 then
    case (id and FmaNodeSubitemsMask) shr 16 of
      0: InitCalls;
      1: InitCalls(FNodeCallsIn);
      2: InitCalls(FNodeCallsOut);
      3: InitCalls(FNodeCallsMissed);
    end;
  // Organizer
  if (id and $F00000) = $300000 then
    case (id and FmaNodeSubitemsMask) shr 16 of
      0: ;
      1: ;
      2: ActionSyncBookmarksExecute(Self);
      3: ;
      4: ActionSyncCalendarExecute(Self);
    end;
  // Other
  if (id and $F00000) = $500000 then InitObexFolders;
  if (id and $F00000) = $700000 then InitProfile;
  if (id and $F00000) = $800000 then InitGroups;
  if (id and $FF0000) = $310000 then InitAlarms;
  // Update view
  ExplorerNewChange(ExplorerNew,ExplorerNew.FocusedNode);
  // Update database
  // Only if not Messages, Calls or Groups since they will do it anyway
  if not ((id and $F00000 shr 20) in [2,4,8]) then begin
    SavePhoneDataFiles(True);
  end;
end;

procedure TForm1.Status(str: WideString; AddToLog: boolean);
begin
  if AddToLog and (str <> '') then
    Log.AddMessage(str);
  StatusBar.Panels[4].Text := str;
  StatusBar.Update;
end;

procedure TForm1.ActionSelectAllExecute(Sender: TObject);
begin
  if frmMsgView.Visible then
    frmMsgView.ListMsg.SelectAll(True);
  if frmSyncPhonebook.Visible then
    frmSyncPhonebook.ListContacts.SelectAll(false);
  if frmSyncBookmarks.Visible then
    frmSyncBookmarks.ListBookmarks.SelectAll(false);
  if frmSMEdit.Visible then
    frmSMEdit.ListNumbers.SelectAll(false);
  if frmMEEdit.Visible then
    frmMEEdit.ListNumbers.SelectAll(false);
  if frmExplore.Visible then
    frmExplore.ListItems.SelectAll(false);
  if frmEditor.Visible then
    frmEditor.Script.SelectAll;
end;

function TForm1.DeleteSMS(index: Integer; memType,CheckPDU: String): Boolean;
var
  sl: TStringList;
  CheckOK: boolean;
  i: Integer;
begin
  AskRequestConnection;
  try
    TxAndWait('AT+CPMS="' + memType + '"'); // do not localize
    if CheckPDU <> '' then begin
      CheckOK := False;
      { Should we check if the message is the same in phone?
      12:22:50:139 [TX] AT+CMGR=54
      12:22:50:340 [RX] +CMGR: 0,,24
      12:22:50:440 [RX] 07911614910910F7040B911614910631F400004060522122140405F4F29C2E03
      12:22:50:640 [RX] OK
      }
      sl := TStringList.Create;
      try
        { Get current message in phone }
        try
          TxAndWait('AT+CMGR=' + IntToStr(index)); // do not localize
          { Download OK }
          sl.Text := ThreadSafe.RxBuffer.Text;
          for i := 0 to sl.Count - 1 do begin
            { Compare it to message in FMA }
            if pos('+CMGR', sl[i]) = 1 then begin // do not localize
              CheckOK := AnsiCompareStr(CheckPDU,sl[i+1]) = 0;
              break;
            end;
          end;
        except
          { silently ignore read failure - it means message is not in phone anyway }
        end;
      finally
        sl.Free;
      end;
    end
    else
      CheckOK := True;
    if CheckOK then
      TxAndWait('AT+CMGD=' + IntToStr(index)); // do not localize
    Result := True;
  except
    on E: Exception do  
      raise Exception.Create(Format(_('Delete failed: %s'), [E.Message]));
  end;
end;

procedure TForm1.ActionDeleteExecute(Sender: TObject);
begin
  if frmMsgView.Visible and (frmMsgView.ListMsg.Focused) then begin
    frmMsgView.DeleteSelected;
  end
  else if frmSyncPhonebook.Visible and frmSyncPhonebook.ListContacts.Focused then begin
    frmSyncPhonebook.btnDELClick(nil);
  end
  else if frmSyncBookmarks.Visible and frmSyncBookmarks.ListBookmarks.Focused then begin
    frmSyncBookmarks.btnDELClick(nil);
  end
  else if frmSMEdit.Visible and frmSMEdit.ListNumbers.Focused then begin
    frmSMEdit.btnDELClick(nil);
  end
  else if frmMEEdit.Visible and frmMEEdit.ListNumbers.Focused then begin
    frmMEEdit.btnDELClick(nil);
  end
  else if frmExplore.Visible and frmExplore.ListItems.Focused then begin
    if (ExplorerNew.FocusedNode.Parent = FNodeGroups) or ExplorerNodeIsFileOrFolder(ExplorerNew.FocusedNode) then
      DoRemoveGroupMemberOrFile;
    if (ExplorerNew.FocusedNode = FNodeBookmarks) then
      DoRemoveBookmark;
    if (ExplorerNew.FocusedNode = FNodeAlarms) then
      DoRemoveAlarm;
    if (ExplorerNew.FocusedNode = FNodeGroups) then
      { check for DoRemoveGroupMemberOrFile should be before DoRemoveGroup }
      DoRemoveGroup;
  end
  else if frmEditor.Visible and frmEditor.Script.Focused then
    frmEditor.Script.SelText := ''
  else if ActiveControl = ExplorerNew then
    ActionViewDelFolder.Execute;
end;

procedure TForm1.ActionSMSArchiveMsgExecute(Sender: TObject);
begin
  SMSToFolder(FNodeMsgArchive);
end;

procedure TForm1.ActionSMSMoveMsgToArchiveExecute(Sender: TObject);
var
  PhoneSource: Boolean;
begin
  PhoneSource := (ExplorerNew.FocusedNode = FNodeMsgInbox) or (ExplorerNew.FocusedNode = FNodeMsgSent);
  { frmMsgView.DeleteSelected() will ask for connection if needed
  if PhoneSource then AskRequestConnection; }

  ActionSMSArchiveMsg.Execute;
  frmMsgView.DeleteSelected(False);

  if not FStartupOptions.NoBaloons and not IsMoveToArchiveEnabled and PhoneSource then
    ShowBaloonInfo(_('You can enable auto-move in Options | Behaviour | Message Arrived | Move message to FMA.'));
end;

procedure TForm1.SendTextMessage(UDHI: String; msg, destNo: WideString; reqReply,
  Flash: Boolean; StatusReq: Boolean; dcs: TGSMCodingScheme; SaveDraft: Boolean);
var
  sms: TSMS;
  pdu,who: String;
begin
  sms := TSMS.Create;
  try
    who := LookupContact(destNo);
    if who = '' then who := destNo;
    sms.Number := destNo;
    sms.RequestReply := reqReply;
    sms.FlashSMS := Flash;
    sms.StatusRequest := StatusReq;
    sms.UDHI := UDHI;
    sms.Text := msg;
    sms.TextEncoding := dcs; // override DCS if needed
    pdu := sms.PDU;
    if SaveDraft then begin
      { TODO: Remove previous saved Draft for this message/sender }
      SaveMsgToFolder(FNodeMsgDrafts,pdu,True);
      Status(_('Message saved in Drafts'));
    end
    else begin
      { Move message from Drafts (if any) to Outbox folder }
      SaveMsgToFolder(FNodeMsgOutbox,pdu,True);
      DelMsgFromFolder(FNodeMsgDrafts,pdu);
      Status(_('Message stored in Outbox'));
    end;
  finally
    sms.Free;
  end;
end;

procedure TForm1.ActionSMSNewMsgExecute(Sender: TObject);
begin
  with frmMessageContact do begin
    AlphaBlendValue := FAlphaCompose;
    Show;
    Clear;
    Edit1.SetFocus;
  end;
end;

procedure TForm1.ExtractName(var Name, numType: WideString);
begin
  if copy(Name, length(Name) - 1, 1) = '/' then begin
    numType := copy(Name, length(Name), 1);
    Name := copy(Name, 1, length(Name) - 2);
  end
  else numType := 'O'; // do not localize
end;

procedure TForm1.SaveToArchive(PDU: String; OverwriteOld,UpdateView: boolean);
begin
  SaveMsgToFolder(FNodeMsgArchive,PDU,OverwriteOld,UpdateView);
end;

procedure TForm1.SetActionState(act: TTntAction; state: Boolean);
begin
  act.Enabled := state;
//  act.Visible := state;
end;

procedure TForm1.ActionContactsNewMsgExecute(Sender: TObject);
var
  Number: string;
begin
  Number := LocateSelContactNumber;
  if Number <> '' then begin
    ActionSMSNewMsg.Execute;
    frmMessageContact.AddRecipient(Number);
    frmMessageContact.Memo.SetFocus;
  end;
end;

procedure TForm1.ActionSMSReplyMsgExecute(Sender: TObject);
var
  node: PVirtualNode;
  item: PListData;
begin
  try
    node := frmMsgView.ListMsg.FocusedNode;
    if Assigned(node) then
      item := frmMsgView.ListMsg.GetNodeData(node)
    else
      item := nil;
  except
    exit;
  end;
  if item <> nil then begin
    ActionSMSNewMsg.Execute;
    frmMessageContact.AddRecipient(item.from);
    frmMessageContact.Memo.SetFocus;
  end;
end;

procedure TForm1.ActionSMSForwardMsgExecute(Sender: TObject);
var
  node: PVirtualNode;
  item: PListData;
begin
  try
    node := frmMsgView.ListMsg.FocusedNode;
    if Assigned(node) then
      item := frmMsgView.ListMsg.GetNodeData(node)
    else
      item := nil;
  except
    exit;
  end;
  if item <> nil then begin
    ActionSMSNewMsg.Execute;
    frmMessageContact.Memo.Text := '';
    if frmMsgView.IsLongSMSNode(node) then
      frmMessageContact.Memo.SelText := frmMsgView.GetNodeLongText(node)
    else
      frmMessageContact.Memo.SelText := item.msg;
    frmMessageContact.Memo.SelStart := Length(frmMessageContact.Memo.Text);
  end;
end;

procedure TForm1.ActionConnectionToggleExecute(Sender: TObject);
begin
  if FConnected then
    ActionConnectionDisconnect.Execute
  else
    ActionConnectionConnect.Execute;
end;

procedure TForm1.ActionContactsVoiceCallExecute(Sender: TObject);
var
  Number: WideString;
begin
  if (frmCalling <> nil) and frmCalling.IsIncoming and frmCalling.IsCalling and not frmCalling.IsTalking then
    { Incomming Call in progress, so pick up it }
    frmCalling.AnswerButton.Click
  else begin
    { No active call, so create a new outgoing one }
    if IsContactNumberSelected then
      Number := LocateSelContactNumber
    else
      Number := '';
    DoCallContact(Number);
  end;
end;

procedure TForm1.HandleEMIV(AMsg: String);
var
  str: String;
begin
  str := copy(AMsg, 8, length(AMsg));
  ScriptEvent('OnMusicMute', [str]); // do not localize
end;

procedure TForm1.HandleEAMI(AMsg: String);
var
  position: Integer;
  Event, buf: String;
  value: WideString;
  dlgType: Integer;
begin
  dlgType := -1;
  buf := copy(AMsg, 8, length(AMsg));

  if pos('*EAMI', AMsg) = 1 then begin // do not localize
    try
      position := StrToInt(buf);
    except
      position := 0; //on EConvertError do exit;
    end;
  end
  else begin // EAII
    dlgType := StrToInt(GetToken(buf, 0));
    case dlgType of
     0,1,14: position := 0; // 0 - Back/timeout, 1,14 - MsgBox - Information
     2,3,4,7,11,
     15: begin
           position := 0;
           value := UTF8StringToWideString(GetToken(buf, 1));
         end;
      5: begin
           try
             position := StrToInt(UTF8StringToWideString(GetToken(buf, 1)));
           except
             position := 0;
           end;
         end;
      else
        Exit;
    end;
  end;

  if position = 0 then Event := FAccessoriesMenu.FBack
  else begin
    Event := FAccessoriesMenu.FEventList.Strings[position-1];
    FAccessoriesMenu.FSelected := position;
  end;

  { Use scheduled (delayed) execution of script events }
  case dlgType of
   -1,0,1,14: if Event <> '' then ScheduleScriptEvent(Event, []);
           5: if Event <> '' then ScheduleScriptEvent(Event, [position]);
    2,3,7,11: if FAccessoriesMenu.FGeneralEvent <> '' then ScheduleScriptEvent(FAccessoriesMenu.FGeneralEvent, [value]);
           4: if FAccessoriesMenu.FGeneralEvent <> '' then ScheduleScriptEvent(FAccessoriesMenu.FGeneralEvent, [value, 1]);
          15: if FAccessoriesMenu.FGeneralEvent <> '' then ScheduleScriptEvent(FAccessoriesMenu.FGeneralEvent, [value, 0]);
  end;
end;

procedure TForm1.HandleSEGUII(AMsg: String);
var
  position, objectId, action: Integer;
  msg, buf, result: WideString;
begin
  Msg := LongStringToWideString(AMsg);
  GetFirstToken(Msg,' ');
  objectId:=StrToInt(GetFirstToken(Msg,','));
  action:=StrToInt(GetFirstToken(Msg,','));
{
          0, // CANCEL
          1: // PREVIOUS
            begin
              FAccessoriesMenu.CloseUI;
              ScheduleScriptEvent(FAccessoriesMenu.FBack,[]);
            end;
          2, // NO
          3, // YES
          4, // ACCEPT
          5, // ACCEPT INDEX (AMsg=Index)
          6, // DELETE INDEX (AMsg=Index)
          7, // ACCEPT N_OF_MANY (AMsg=Index1,Index2,..IndexN)
          8, // ACCEPT DATE (AMsg="yy/MM/dd" or "yyyy/MM/dd")
          9, // ACCEPT TIME
          10, // ACCEPT BOOLEAN (AMsg=Bool)
          11, // ACCEPT STRING (AMsg="String")
          12, // ACCEPT INTEGER (AMsg=Integer)
          13, // SOFT KEY ACTION (AMsg=ActionID)
          108, // FORM ACCEPT DATE (AMsg="yy/MM/dd" or "yyyy/MM/dd")
          109, // FORM ACCEPT TIME
          111, // FORM ACCEPT STRING (AMsg="String")
          112: // FORM ACCEPT INTEGER (AMsg=IntegerValue)
}
  case FAccessoriesMenu.FType of
    DLG_OPTION:
      begin
        case action of
          0, // CANCEL
          1: // PREVIOUS
            begin
              FAccessoriesMenu.CloseUI;
              ScheduleScriptEvent(FAccessoriesMenu.FBack,[]);
            end;
          2, // NO
          3, // YES
          4, // ACCEPT
          5, // ACCEPT INDEX (AMsg=Index)
          6, // DELETE INDEX (AMsg=Index)
          7, // ACCEPT N_OF_MANY (AMsg=Index1,Index2,..IndexN)
          8, // ACCEPT DATE (AMsg="yy/MM/dd" or "yyyy/MM/dd")
          9, // ACCEPT TIME
          10, // ACCEPT BOOLEAN (AMsg=Bool)
          11, // ACCEPT STRING (AMsg="String")
          12, // ACCEPT INTEGER (AMsg=Integer)
          13, // SOFT KEY ACTION (AMsg=ActionID)
          108, // FORM ACCEPT DATE (AMsg="yy/MM/dd" or "yyyy/MM/dd")
          109, // FORM ACCEPT TIME
          111, // FORM ACCEPT STRING (AMsg="String")
          112: // FORM ACCEPT INTEGER (AMsg=IntegerValue)
            begin
            end;
        end;
      end;
    DLG_MSGBOX:
      begin
        case action of
          0, // CANCEL
          1: // PREVIOUS
            begin
              FAccessoriesMenu.CloseUI;
              ScheduleScriptEvent(FAccessoriesMenu.FBack,[]);
            end;
          3: // YES
            ScheduleScriptEvent(FAccessoriesMenu.FBack,[]);
          else
            Log.AddMessage('Unexpected action from Message Box',lsDebug); // do not localize debug
        end;
      end;
    DLG_YESNO:
      begin
        case action of
          0, // CANCEL
          1: // PREVIOUS
            begin
              FAccessoriesMenu.CloseUI;
              ScheduleScriptEvent(FAccessoriesMenu.FBack,[]);
            end;
          2: // NO
            if FAccessoriesMenu.FGeneralEvent <> '' then
              ScheduleScriptEvent(FAccessoriesMenu.FGeneralEvent, ['0']);
          3: // YES
            if FAccessoriesMenu.FGeneralEvent <> '' then
              ScheduleScriptEvent(FAccessoriesMenu.FGeneralEvent, ['1']);
          else
            Log.AddMessage('Unexpected action from Yes/No Dialog',lsDebug); // do not localize debug
        end;
      end;
    DLG_ONOFF:
      begin
        case action of
          0, // CANCEL
          1: // PREVIOUS
            begin
              FAccessoriesMenu.CloseUI;
              ScheduleScriptEvent(FAccessoriesMenu.FBack,[]);
            end;
          10: // ACCEPT BOOLEAN (AMsg=Bool)
              if FAccessoriesMenu.FGeneralEvent <> '' then
                ScheduleScriptEvent(FAccessoriesMenu.FGeneralEvent, [UTF8StringToWideString(WideStringToLongString(Msg))]);
          else
            Log.AddMessage('Unexpected action from On/Off Dialog',lsDebug); // do not localize debug
        end;
      end;
    DLG_PERCENT:
      begin
        case action of
          0, // CANCEL
          1: // PREVIOUS
            begin
              FAccessoriesMenu.CloseUI;
              ScheduleScriptEvent(FAccessoriesMenu.FBack,[]);
            end;
          12, // ACCEPT INTEGER (AMsg=IntegerValue)
          112: // FORM ACCEPT INTEGER (AMsg=IntegerValue)
            begin
              if FAccessoriesMenu.FGeneralEvent <> '' then
                ScheduleScriptEvent(FAccessoriesMenu.FGeneralEvent, [StrToInt(Msg)*100/FAccessoriesMenu.FPercentSteps, 1]);
            end;
          else
            Log.AddMessage('Unexpected action from Percent Dialog',lsDebug); // do not localize debug
        end;
      end;
    DLG_INPUTSTR:
      begin
        case action of
          0, // CANCEL
          1: // PREVIOUS
            begin
              FAccessoriesMenu.CloseUI;
              ScheduleScriptEvent(FAccessoriesMenu.FBack,[]);
            end;
          11, // ACCEPT STRING (AMsg="String")
          111: // FORM ACCEPT STRING (AMsg="String")
            if FAccessoriesMenu.FGeneralEvent <> '' then begin
              buf := UTF8StringToWideString(WideStringToLongString(Copy(Msg,2,Length(Msg)-2)));
              if Length(buf)<=FAccessoriesMenu.FInputMax then begin
                result := '';
                while Pos('"',buf)>0 do
                  result := result + GetFirstToken(buf,'"') + '""';
                { TODO: Use WideStringReplace() to double quotes }
                result := result + buf;
                ScheduleScriptEvent(FAccessoriesMenu.FGeneralEvent, [result]);
              end
              else begin
                TxAndWait('AT*SELERT="Maximum Input Length is '+IntToStr(FAccessoriesMenu.FInputMax)+'",3,1,"Input too long"');
                FAccessoriesMenu.FType := DLG_INPUTSTR + DLG_INPUTERR;
              end;
            end;
          else
            Log.AddMessage('Unexpected action from Input String Dialog',lsDebug); // do not localize debug
        end;
      end;
    DLG_INPUTINT:
      begin
        case action of
          0, // CANCEL
          1: // PREVIOUS
            begin
              FAccessoriesMenu.CloseUI;
              ScheduleScriptEvent(FAccessoriesMenu.FBack,[]);
            end;
          11, // ACCEPT STRING (AMsg="String")
          111: // FORM ACCEPT STRING (AMsg="String")
            if FAccessoriesMenu.FGeneralEvent <> '' then begin
              position := StrToInt(Copy(Msg,2,Length(Msg)-2));
              if position<FAccessoriesMenu.FInputMin then begin
                TxAndWait('AT*SELERT="Minimum value is '+IntToStr(FAccessoriesMenu.FInputMin)+'",3,1,"Input too low"');
                FAccessoriesMenu.FType := DLG_INPUTINT + DLG_INPUTERR;
              end
              else if position>FAccessoriesMenu.FInputMax then begin
                TxAndWait('AT*SELERT="Maximum value is '+IntToStr(FAccessoriesMenu.FInputMax)+'",3,1,"Input too high"');
                FAccessoriesMenu.FType := DLG_INPUTINT + DLG_INPUTERR;
              end
              else begin
                ScheduleScriptEvent(FAccessoriesMenu.FGeneralEvent, [position]);
              end;
            end;
          else
            Log.AddMessage('Unexpected action from Input Integer Dialog',lsDebug); // do not localize debug
        end;
      end;
    DLG_INFORMATION:
      begin
        case action of
          0, // CANCEL
          1: // PREVIOUS
            begin
              FAccessoriesMenu.CloseUI;
              ScheduleScriptEvent(FAccessoriesMenu.FBack,[]);
            end;
          3: // YES
            ScheduleScriptEvent(FAccessoriesMenu.FBack,[]);
          else
            Log.AddMessage('Unexpected action from Information Dialog',lsDebug); // do not localize debug
        end;
      end;
    DLG_FEEDBACK:
      begin
        case action of
          0, // CANCEL
          1: // PREVIOUS
            begin
              FAccessoriesMenu.CloseUI;
              ScheduleScriptEvent(FAccessoriesMenu.FBack,[]);
            end;
          3: // YES
            ScheduleScriptEvent(FAccessoriesMenu.FBack,[]);
          else
            Log.AddMessage('Unexpected action from Feedback Dialog',lsDebug); // do not localize debug
        end;
      end;
    DLG_SUBMENU:
      begin
        case action of
          0, // CANCEL
          1: // PREVIOUS
            begin
              FAccessoriesMenu.CloseUI;
              ScheduleScriptEvent(FAccessoriesMenu.FBack,[]);
            end;
          5: // ACCEPT INDEX (AMsg=Index)
            begin
              position:=StrToInt(Msg);
              FAccessoriesMenu.FSelected := position+1;
              ScheduleScriptEvent(FAccessoriesMenu.FEventList.Strings[position],[]);
            end;
          else
            Log.AddMessage('Unexpected action from Submenu Dialog',lsDebug); // do not localize debug
        end;
      end;
    else
      begin
        if FAccessoriesMenu.FType>DLG_INPUTERR then
          FAccessoriesMenu.FType := FAccessoriesMenu.FType - DLG_INPUTERR;
      end;
  end;
  if (action>1) and (FAccessoriesMenu.FType<DLG_INPUTERR) then
    TxAndWait('AT*SEDEL='+IntToStr(objectId));
end;

procedure TForm1.HandleECAV(AMsg: String);
var
  timestamp: String;
  str: String;
  ccstatus: Integer;
  IsAutoAnswer: boolean; // When using headset
resourcestring
  sIdle = 'Idle';
  sCalling = 'Calling';
  sConnecting = 'Connecting';
  sActive = 'Active';
  sHold = 'Hold';
  sWaiting = 'Waiting';
  sAlerting = 'Alerting';
  sBusy = 'Busy';
const
  ccsDesc: array[0..7] of string = (sIdle, sCalling, sConnecting, sActive, sHold, sWaiting, sAlerting, sBusy);
begin
  DateTimeToString(timestamp, 'yyyy"/"mm"/"dd,hh":"nn', now); //TODO -cl10n: localize?

  { TODO: Handle Second incoming call }
  { TODO: Handle frmCalling <> nil }

  if not frmCalling.IsCalling and not frmCalling.IsCreated then begin
    { Setup popup window, but show it only if specified }
    frmCalling.CreateCall('',not FCallOptions.NoPopup,FAlphaCall);
  end;

  str := copy(AMsg, 8, length(AMsg));
  if pos('*ECAV', AMsg) = 1 then begin // do not localize
    ccstatus := StrToInt(GetToken(str, 1));

    { TODO: Handle calling while talking }
    if (ccstatus = 1) and not frmCalling.IsTalking then begin
      { Outgoing call }
      frmCalling.Caption := _('Calling...');
      frmCalling.lbNumber.Caption := GetToken(str, 5);
      if (GetToken(str, 6) = '145') and (frmCalling.lbNumber.Caption <> '') and (frmCalling.lbNumber.Caption[1] <> '+') then
        frmCalling.lbNumber.Caption := '+' + frmCalling.lbNumber.Caption;
      if frmCalling.lbAlpha.Caption = sUnknownNumber then
        frmCalling.lbAlpha.Caption := sUnknownContact;
      frmCalling.AnswerButton.Visible := False;
      frmCalling.HeadsetButton.Visible := False;
      frmCalling.HandupButton.Visible := True;
      if frmCalling.Visible then
        frmCalling.HandupButton.SetFocus;
      frmCalling.IsIncoming := False;
      frmCalling.IsCalling := True;
      frmCalling.IsBusy := False;
      frmCalling.DoPersonalize;
      { Start outgoing ringing, we'll use a timer }
      frmCalling.TimeTimer.Enabled := True;
      Status(_('Dialing...'));
      { Add to explorer outgoing call }
      AddCall(FNodeCallsOut,ContactNumberByTel(frmCalling.lbNumber.Caption),timestamp,True);
      { Update view }
      if frmInfoView.Visible then frmInfoView.UpdateWelcomePage(True)
        else ExplorerNewChange(ExplorerNew,ExplorerNew.FocusedNode);
    end;

    if ccstatus = 7 then begin
      frmCalling.IsBusy := True;
    end;

    { TODO: Handle second call while talking }
    if (ccstatus = 6) and not frmCalling.IsTalking then begin
      { Incoming call }
      frmCalling.Caption := _('Incoming Call...');
      frmCalling.lbNumber.Caption := GetToken(str, 5);
      if (GetToken(str, 6) = '145') and (frmCalling.lbNumber.Caption <> '') and (frmCalling.lbNumber.Caption[1] <> '+') then
        frmCalling.lbNumber.Caption := '+' + frmCalling.lbNumber.Caption;
      frmCalling.HeadsetButton.Visible := True;
      frmCalling.HandupButton.Visible := True;
      frmCalling.AnswerButton.Visible := True;
      if frmCalling.Visible then
        frmCalling.AnswerButton.SetFocus;
      frmCalling.IsIncoming := True;
      frmCalling.IsCalling := True;
      frmCalling.DoPersonalize;
      Status(_('Ringing...'));
    end;

    if ccstatus = 3 then begin
      { Call activated }
      IsAutoAnswer := frmCalling.AnswerButton.Enabled and frmCalling.IsIncoming; // Using BT Audio Gateway?
      frmCalling.DoInCall;
      frmCalling.AnswerButton.Enabled := False;
      frmCalling.HeadsetButton.Visible := False;
      frmCalling.HandupButton.Visible := True;
      if frmCalling.Visible and (frmCalling.ActiveControl <> frmCalling.Memo) then
        frmCalling.HandupButton.SetFocus;
      { Active call, so mark it as processed, i.e. not missed one }
      frmCalling.IsTalking := True;
      Status(_('Talking...'));
      if frmCalling.IsIncoming then begin
        { Add to explorer incoming call }
        AddCall(FNodeCallsIn,ContactNumberByTel(frmCalling.lbNumber.Caption),timestamp,True);
        { Update view }
        if frmInfoView.Visible then frmInfoView.UpdateWelcomePage(True)
          else ExplorerNewChange(ExplorerNew,ExplorerNew.FocusedNode);
      end;
    end
    else
      IsAutoAnswer := False;

    if ccstatus = 0 then
      { Call ended }
      try
        CoolTrayIcon1.HideBalloonHint; // hide calling baloon
        if frmCalling.IsIncoming and not frmCalling.IsTalking then begin
          { Add to explorer missed calls }
          str := ContactNumberByTel(frmCalling.lbNumber.Caption);
          AddCall(FNodeCallsMissed,str,timestamp,True);
          { Add to Recent missed calls counter }
          if frmMissedCalls <> nil then
            frmMissedCalls.RecentMissedCalls := frmMissedCalls.RecentMissedCalls + 1;
          { Update view }
          if frmInfoView.Visible then frmInfoView.UpdateWelcomePage(True)
            else ExplorerNewChange(ExplorerNew,ExplorerNew.FocusedNode);
          ActionMissedCalls.Update; // update even if minimized

          { Schedule command to remove Popup window in phone }
          FClearPhoneMessage := True;

          { Show otification icon }
          MissedCallsTrayIcon.IconVisible := True;
          MissedCallsTrayIcon.IconIndex := 48;
          if not FCallOptions.NoBaloon then
            ShowBaloonInfo(_('New missed call registered.'),60,MissedCallsTrayIcon);
        end;
      finally
        Log.AddMessage(WideFormat(_('Last call duration: %s'), [frmCalling.lblTime.Caption]));
        Status(WideFormat(_('Call ended (%s)'), [frmCalling.lblTime.Caption]));
        frmCalling.IsCalling := False;
        frmCalling.IsTalking := False;
        frmCalling.CloseCall;
      end
    else begin
      frmCalling.Caption := ccsDesc[ccstatus];
      if (ccstatus = 3) and IsAutoAnswer then
        frmCalling.Caption := frmCalling.Caption + _(' (Auto-answered)');
    end;
    FLastECAVStatus := ccstatus;
  end;

  { Get Caller ID }
  if (pos('*EOLP', AMsg) = 1) or (pos('*ELIP', AMsg) = 1) then begin // do not localize
    if FUseUTF8 then
      str := UTF8StringToWideString(WideStringToLongString(GetToken(LongStringToWideString(str), 0)))
    else
      str := GetToken(str, 0);
    { TODO: Handle miltiple calls }
    if not frmCalling.IsTalking then begin
      frmCalling.lbAlpha.Caption := str;
      frmCalling.DoShowNotes; // in case they are not shown yet
    end;
  end;

  { Notify script }
  if FCallM then
    ScriptEvent('OnCall', [frmCalling.Caption, frmCalling.lbAlpha.Caption, frmCalling.lbNumber.Caption]); // do not localize
end;

procedure TForm1.HandleRinging;
begin
  if (frmCalling <> nil) and not frmCalling.IsTalking then begin
    if frmCalling.Visible or not FCallM then begin
      frmCalling.DoPersonalize;
      if frmCalling.IsPersonalized then
        Status(WideFormat(_('%s is calling...'), [frmCalling.lbAlpha.Caption]))
      else
        Status(_('Ringing...'));
      { DoPersonalize will perform the ringing sound loop }
      //PlaySound(pChar('FMA_CallReceived'), 0, SND_ASYNC or SND_APPLICATION or SND_NODEFAULT); // do not localize
    end;
  end;
end;

procedure TForm1.HandleCOPS(AMsg: String);
var
  sl: TTntStringList;
  ws: WideString;
begin
  {
  AT+COPS?
  +COPS: 0,0,"M-TEL GSM BG"
  ATZCOPS=?
  +COPS: (2,"M-TEL GSM BG","BG M-TEL","28401")
  +COPS: (3,"BG GLOBUL","BG GLOBUL","28405")
  }
  Delete(AMsg,1,7);
  sl := TTntStringList.Create;
  try
    if FUseUTF8 then
      ws := UTF8StringToWideString(AMsg)
    else
      ws := AMsg;
    sl.CommaText := ws;
    if sl.Count < 3 then
      FSelOperator := _('Unknown')
    else
      FSelOperator := sl[2];
  finally
    sl.Free;
  end;
end;

procedure TForm1.HandleCKEV(AMsg: String);
var
  str: String;
  curKey: String;
begin
  if GetTickCount > FKeyMSec then begin
    FKeyActivity := '';
    FKeyState := False;
    Log.AddMessage('Key Buffer: Cleanup due to inactivity', lsDebug); // do not localize debug
  end;
  FKeyMSec := GetTickCount + Cardinal(FKeyInactivityTimeout);

  str := copy(AMsg, 8, length(AMsg));

  {
  try
    GetToken(str, 1);
  except
    FKeyState := not FKeyState;
    if FKeyState = True then str := str + ',1'
    else str := str + ',0';
    Debug('Dirty Fix: ' + str); // do not localize debug
  end;
  }

  try
    if GetToken(str, 1) = '1' then begin
      curKey := GetToken(str, 0);
      FKeyActivity := FKeyActivity + curKey;
      Log.AddMessage('Key Buffer: ' + FKeyActivity, lsDebug); // do not localize debug
      ScriptEvent('OnKeyPress', [curKey, 1]); // do not localize
    end
    else if GetToken(str, 1) = '0' then begin
      ScriptEvent('OnKeyPress', [curKey, 0]); // do not localize
    end
    else begin
      Log.AddMessage('Unknow key pressed', lsDebug); // do not localize debug
    end;
  except
  end;
end;

procedure TForm1.HandleCIEV(AMsg: String);
var
   sl: TStringList;
   s: WideString;
begin
  {
  +CKEV: <ind>,<value>

  <ind> Description
  1 Battery charge level indicator
  2 Signal quality indicator
  3 Battery warning indicator
  4 Charger connected indicator
  5 Service availability indicator
  6 Sounder activity indicator
  7 Message received indicator
  8 Call-in-progress indicator
  9 Transmit activated by voice activity indicator
  10 Roaming indicator
  11 Short message memory storage indicator in the SMS
  12 Bluetooth proprietary call set up status indicator

  <value> Description (range)
  1 “battchg” battery charge level (0-5)
  2 “signal” signal quality (0-5)
  3 “batterywarning” batterywarning (0-1)
  4 “chargerconnected” chargerconnected (0-1)
  5 “service” service availability (0-1) (Net contact status, 1 = Net contact)
  6 “sounder” sounder activity (0-1) (Phone silent status, 1 = phone silent)
  7 “message” message received (0-1)
  8 “call” call in progress (0-1)
  9 “vox” transmit activated by voice activity (0-1) Not supported
  10 “roam” roaming indicator (0-1) (Home net status, 0 = Home Net)
  11 “smsfull” a short message memory storage in the MT has become full (1), or memory locations are available (0); i.e. the range is (0-1)
  12 "callsetup" Bluetooth proprietary call set up status indicator. Not currently in call set up (0), incoming call process
     ongoing (1), outgoing call set up is ongoing (2), remote party being alerted in an outgoing call (3); i.e the range is (0-3)
  }
  try
    sl := TStringList.Create;
    try
      sl.DelimitedText := copy(AMsg, 8, length(AMsg));
      case StrToInt(sl[0]) of
        11: if sl[1] = '1' then begin
              s := _('Phone SMS storage is full. Please delete some messages.');
              CoolTrayIcon1.ShowBalloonHint(TntApplication.Title,s,bitWarning,60);
              Log.AddCommunicationMessage(s, lsError);
            end;
      end;
    finally
      sl.Free;
    end;
  except
  end;
end;

procedure TForm1.HandleEBCA(AMsg: String);

 function MakeReadable(Value: double; Units: array of string; Divider: word = 1000): string; overload;
 var UnitIndex: integer;
 begin
  UnitIndex := 0;

  while (Value > Divider) and (UnitIndex < Length(Units)) do
  begin
   Inc(UnitIndex);
   Value := Value / Divider;
  end;

  result := FormatFloat('##0.##', Value) + ' ' + Units[UnitIndex];
 end;

 function MakeReadable(Value: string; Units: array of string; Divider: word = 1000): string; overload;
 begin
  result := MakeReadable(StrToFloatDef(Value, 0), Units, Divider);
 end;

var
  sl: TStringList;
  vbat: Integer;
  consumption: Int64;
begin
  if not FUseEBCA or (frmInfoView = nil) then exit;
  {
    *EBCA: <vbat>,<dcio>,<icharge>,<iphone>,<tempbattery>,<tempphone>,
     <chargingmethod>,<chargestate>,<remainingcapacity>,<remcapacity>,
     <powerdissipation>,<noccycles>,<nosostimer>,<suspensioncause>

    SE T6xx result:
    *EBCA: 0,0,0,389,1,385,0,246,0,0,537,770,27,27,3,69,342,0,5,5,45,4,61,0,65147,0,46945

    SE K6xx result:
    *EBCA: 3746,4100,0,4294967100,25,27,0,7,270,30,70,15,556,0
  }
  try
    sl := TStringList.Create;
    try
      sl.DelimitedText := copy(AMsg, 8, length(AMsg));
      if sl.Count < 4 then exit;

      // Check for K700i! There should be a better way?? Like taking the product Id or name into account :)
      //if sl.Count <> 14 then begin
      if not (IsK610Clone or IsK700Clone or IsK750Clone or IsWalkmanClone) then begin
        //battery voltage
        vbat := strtoint(sl.Strings[1]) * 10 +
          strtoint(sl.Strings[2]) * 10 +
          strtoint(sl.Strings[3]) * 10 +
          strtoint(sl.Strings[0]) * 10;

        frmInfoView.lbvbat.Caption := MakeReadable(vbat, [_('mV'), _('V'), _('kV')]);

        //battery type
        case strtoint(sl.Strings[4]) of
          0: frmInfoView.lbPower.Caption := _('NiMH Battery');
          1: frmInfoView.lbPower.Caption := _('Litium ion/Polymer Battery');
          2: frmInfoView.lbPower.Caption := _('Unknown Battery');
        end;

        //battery voltage from the charge
        frmInfoView.lbdcio.Caption := MakeReadable(strtoint(sl.Strings[5]) * 10, [_('mV'), _('V'), _('kV')]);

        //current charge
        if sl.Count = 27 then begin
          frmInfoView.lbicharge.Caption := MakeReadable(strtoint(sl.Strings[6])/10, [_('mA'), _('A')]);
          frmInfoView.Chart1.Series[1].Add(Round(strtoint(sl.Strings[6])/10));
        end
        else begin
          frmInfoView.lbicharge.Caption := MakeReadable(sl.Strings[6], [_('mA'), _('A')]);
          frmInfoView.Chart1.Series[1].Add(strtoint(sl.Strings[6]));
        end;

        //phone current consumption
        if sl.Count = 27 then begin
          frmInfoView.lbiphone.Caption := MakeReadable(strtoint(sl.Strings[7])/10, [_('mA'), _('A')]);
          frmInfoView.Chart1.Series[2].Add(Round(strtoint(sl.Strings[7])/10));
        end
        else begin
          frmInfoView.lbiphone.Caption := MakeReadable(sl.Strings[7], [_('mA'), _('A')]);
          frmInfoView.Chart1.Series[2].Add(strtoint(sl.Strings[7]));
        end;

        // scroll chart if it's full
        if frmInfoView.Chart1.Series[0].Count > frmInfoView.Chart1.MaxPointsPerPage then begin
          with frmInfoView.Chart1.BottomAxis do Scroll(1,False);
          inc(ChartShiftCnt);
        end;

        //phone and battery temperature
        if sl.Count = 24 then begin
          frmInfoView.lbtempbatt.Caption := inttostr(strtoint(sl.Strings[10])) + _('°C');
          frmInfoView.lbtempphone.Caption := inttostr(strtoint(sl.Strings[11])) + _('°C');
        end
        else begin
          frmInfoView.lbtempbatt.Caption := inttostr(strtoint(sl.Strings[12])) + _('°C');
          frmInfoView.lbtempphone.Caption := inttostr(strtoint(sl.Strings[13])) + _('°C');
        end;
        frmInfoView.Chart1.Series[0].Add(strtoint(sl.Strings[12]));

        try //ADD because not all support all EBCA's values  //this causes the error "List index out of bounds (16)"
          //number of charge cycles
          if sl.Count > 24 then begin
            frmInfoView.lbcyclescharge.Caption := sl.Strings[16]; // + ' times';
            //CalculateTimeLeft(StatusBar.Panels[1].Text,sl.Strings[16],pbPower.Position,pbPower.MaxValue);
          end;
        except
          frmInfoView.lbcyclescharge.Visible := False;
        end;
      end
      else begin
        //battery voltage
        vbat := strtoint(sl.Strings[0]); // mV
        frmInfoView.lbvbat.Caption := MakeReadable(vbat, [_('mV'), _('V'), _('kV')]);

        //battery type
        //this has to be rechecked!! I have a polymer and it is reporting 0 ???
        case strtoint(sl.Strings[6]) of
          0: frmInfoView.lbPower.Caption := _('Lithium Polymer');
          1: frmInfoView.lbPower.Caption := _('Lithium Ion');
          2: frmInfoView.lbPower.Caption := _('NiMH');
          else frmInfoView.lbPower.Caption := _('Unknown');
        end;
        //battery voltage from the charge
        frmInfoView.lbdcio.Caption := MakeReadable(strtoint(sl.Strings[1]), [_('mV'), _('V'), _('kV')]);

        //current charge
        consumption := abs(strtoint64(sl.Strings[2]));
        frmInfoView.lbicharge.Caption := MakeReadable(consumption/10.0, [_('mA'), _('A')]);
        frmInfoView.Chart1.Series[1].Add(consumption div 10);

        //phone current consumption
        consumption := abs(strtoint64(sl.Strings[3]));
        if IsK610Clone then
          consumption := abs(integer(consumption)); // just guessing here :-o
        frmInfoView.lbiphone.Caption := MakeReadable(consumption/10.0, ['mA', 'A']);
        frmInfoView.Chart1.Series[2].Add(consumption div 10);

        // scroll chart if it's full
        if frmInfoView.Chart1.Series[0].Count > frmInfoView.Chart1.MaxPointsPerPage then begin
          with frmInfoView.Chart1.BottomAxis do Scroll(1,False);
          inc(ChartShiftCnt);
        end;

        //phone and battery temperature
        frmInfoView.lbtempbatt.Caption := inttostr(strtoint(sl.Strings[4])) + _('°C');
        frmInfoView.lbtempphone.Caption := inttostr(strtoint(sl.Strings[5])) + _('°C');
        frmInfoView.Chart1.Series[0].Add(strtoint(sl.Strings[4]));

        try
          frmInfoView.lbcyclescharge.Caption := sl.Strings[11]; // + ' times';
          //CalculateTimeLeft(StatusBar.Panels[1].Text,sl.Strings[16],pbPower.Position,pbPower.MaxValue);
        except
          frmInfoView.lbcyclescharge.Visible := False;
        end;
      end;
    finally
      sl.Free;
    end;
  except
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if not FAppInitialized or not Timer2.Enabled then exit;

  Timer1.Enabled := False;
  if Application.Terminated then
    exit;
  try
    if FConnected and FConnectingComplete and not FSendingMessage and Assigned(FObex) and not FObex.Connected and
      Assigned(ThreadSafe) and not ThreadSafe.Busy and (ThreadSafe.ActiveThread = nil) and not ThreadSafe.ObexConnecting and
      (not Assigned(frmCalling) or (not frmCalling.IsCalling and not frmCalling.IsTalking)) then
      try
        if not FUseAlternateSignalMeter or not FUseAlternateBatteryMeter then begin
          if Timer1.Tag = 1 then begin
            if FUseCSQ then begin
              GetSignalMeter;
              if frmInfoView.Visible then frmInfoView.UpdateWelcomePage;
            end;
            Timer1.Tag := 0;
          end
          else begin
            if FUseCBC then begin
              GetBatteryMeter;
              if frmInfoView.Visible then frmInfoView.UpdateWelcomePage;
            end;
            Timer1.Tag := 1;
          end;
        end
        else begin
          { We will use alternate mettering for both battery and signal }
          if Timer1.Tag = 1 then Timer1.Tag := 0 else Timer1.Tag := 1;
          if (Timer1.Tag = 1) and (FUseCSQ or FUseCBC) then
            TxAndWait('AT+CIND?'); // do not localize
        end;
      except
      end;
  finally
    Timer1.Enabled := True;
  end;
end;

procedure TForm1.HandleStatus(AMsg: String; OverrideBatteryLow: Integer);
var
  s,str: String;
  w: WideString;
  signal,bstate: Integer;
  function Percentage(Pos,Max: integer): string;
  begin
    Result := IntToStr(Round((100*Pos)/Max))+'%';
  end;
begin
  str := copy(AMsg, 7, length(AMsg));
  { Ignore command support responces }
  if (Pos('(',str) <> 0) or (Pos(')',str) <> 0) then exit;

  {
  +CBC: <bsc>,<bcl>
  <bcs> Description
        0 Phone powered by the battery. No charger connected.
        1 Phone has a battery connected, but it is powered by the charger.
        2 Phone does not have a battery connected.
  <bcl> Description
        0 Battery exhausted.
        1-99 Battery charging level; the battery has 1-99 percent of capacity remaining.
        100 Battery fully charged.
  }

  if pos('+CBC', AMsg) = 1 then begin // do not localize
    bstate := StrToInt(GetToken(str, 0));
    signal := StrToInt(GetToken(str, 1));
    if bstate <> 0 then begin
      { Enable warning message again }
      FBatteryWarning := False;
      FBatteryLow := False;
    end;
    case bstate of
      0: begin // Phone powered by the battery. No charger connected.
           SetPanelText(2, _('Battery ')+Percentage(signal,pbPower.MaxValue));
           { Battery exhausted? }
           FBatteryLow := signal = 0;
           if FBatteryLow and not FBatteryWarning and FConnectingComplete then begin
             { Show warning message only once }
             FBatteryWarning := True;
             w := _('The phone battery is too low! Plug the phone into the charger now if you wish to use it...');
             Status(w);
             CoolTrayIcon1.ShowBalloonHint(TntApplication.Title,w,bitWarning,60);
           end;
         end;
      1: begin // Phone has a battery connected, but it is powered by the charger.
           SetPanelText(2, _('AC Powered'));
           FOnACPower := True;
           { Remove any low battery warning message }
           CoolTrayIcon1.HideBalloonHint;
         end;
      2: begin // Phone does not have a battery connected.
           SetPanelText(2, _('Battery N/A'));
           FBatteryLow := False;
           signal := 0;
         end;
      3: begin // Recorgnized power fault, calls inhibited (reported by SHARP phones).
           SetPanelText(2, _('Battery Err'));
           FUseAlternateBatteryMeter := True;
           FBatteryLow := True;
           signal := 0;
         end;
    end;
    if OverrideBatteryLow <> -1 then begin
      FBatteryLow := OverrideBatteryLow <> 0;
    end;
    pbPower.Position := signal;
    s := frmInfoView.lbcyclescharge.Caption;
    if (s <> '') and not (s[1] in ['0'..'9']) then s := '';
    if FUseCBC then
      CalculateTimeLeft(StatusBar.Panels[1].Text,s,pbPower.Position,pbPower.MaxValue);

    if FUseCBC and not FIgnoreLowBattery and FBatteryLow then begin
      Log.AddMessage('Battery is too low. Going to Offline mode...', lsDebug); // do not localize debug
      ActionConnectionAbort.Execute;
      Status(_('Disconnecting due to low battery or power fault...'));
      if FConnected and FConnectingComplete then
        ActionConnectionDisconnect.Execute
      else
        raise Exception.Create(_('Disconnected due to low battery'));
    end;
  end;

  {
  +CSQ: <rssi>,<ber>
  <rssi> Description
         0    -113 dBm or less
         1    -111 dBm
         2-30 -109 dBm to -53 dBm
         31   -51 dBm or greater
         99    Not known or not detectable.
  <ber>  Description
         0-7   RXQUAL values
         99    Not known or not detectable.
  }

  if pos('+CSQ', AMsg) = 1 then begin // do not localize
    signal := StrToInt(GetToken(str, 0));
    if signal = 99 then begin
      FUseAlternateSignalMeter := True;
      SetPanelText(3, _('Signal N/A'));
      pbRSSI.Position := 0;
    end
    else begin
      signal := Round((signal / 31) * pbRSSI.MaxValue);
      SetPanelText(3, WideFormat(_(' Signal %s '), [Percentage(signal,pbRSSI.MaxValue)]));
      pbRSSI.Position := signal;
    end;
  end;

  { Update signal using alternate method }
  if FUseCIND then
    if FUseAlternateSignalMeter or FUseAlternateBatteryMeter then
      ScheduleTxAndWait('AT+CIND?');
end;

procedure TForm1.RetrieveNewSMS(AMsg: String);
var
  str, memLocation: String;
  index: Integer;
begin
  { Should we monitor messages? }
  if FMsgM then begin
    { Yes, do it }
    str := copy(AMsg, 8, length(AMsg));
    memLocation := GetToken(str, 0);
    index := StrToInt(GetToken(str, 1));
    { Now download message }
    DoDownloadSMSFromPhone(memLocation, index);
    { Clear the msgbox after receive, if needed...
      CNMI mode 3 just forwards message to Fma and do not
      keep it on phone, so we don't have to delete the
      message box (have to be tested), which leads to:
      849510 Active call interruption on incoming SMS }
    if not FUseCNMIMode3 and not IsMoveToArchiveEnabled then begin
      if not frmCalling.IsTalking and not frmCalling.IsCalling then // do not cancel active call here
        { Schedule execution... }
        FClearPhoneMessage := True;
        { TODO: handle else state? for now the message will stay on phone }
    end;
  end;  
end;

procedure TForm1.ApplicationEvents1Minimize(Sender: TObject);
begin
  if frmInfoView.Visible then EBCAState(False,False); // 2nd false = do not alter key monitoring
  if FormStorage1.StoredValue['StartMinimized'] = False then begin // do not localize
    //FloatingRectangles(True, False);
    FormStorage1.StoredValue['StartMinimized'] := True; // do not localize
  end;
  ShowRestore1.Action := ActionWindowRestore;
  if not FStartupOptions.NoBaloons then
    ShowBaloonInfo(_('This application will continue working in background. Double-click this icon to open application again.'));
end;

procedure TForm1.ApplicationEvents1Restore(Sender: TObject);
begin
  FormStorage1.StoredValue['StartMinimized'] := False; // do not localize
  ShowRestore1.Action := ActionWindowMinimize;
  if frmWelcomeTips.DialogClosed then
    ShowWindow(frmWelcomeTips.Handle,SW_HIDE); // HACK!!!
  if frmInfoView.Visible then begin
    { Make sure we will enable EBCA since we dont know its actual state during Minimized App state }
    EBCALastState := -1;
    EBCAState(True,False); // 2nd false = do not alter key monitoring
  end;
end;

procedure TForm1.SetPanelText(id: Integer; str: WideString);
begin
  StatusBar.Panels[id].Text := str;
  StatusBar.Canvas.Font := StatusBar.Font;
  StatusBar.Panels[id].Width := Canvas.TextWidth(str) + 20;
  StatusBarResize(nil);
end;

procedure TForm1.ActionAboutExecute(Sender: TObject);
begin
  frmAbout := TfrmAbout.Create(Self);
  try
    frmAbout.ShowModal;
  finally
    frmAbout.Free;
  end;
end;

procedure TForm1.ActionWindowRestoreExecute(Sender: TObject);
begin
  //FloatingRectangles(False, False);
  if CheckforUpdate1.Enabled then
    Show; { Do not show main form if Web Update wizard is visible }
  Application.Restore;
  Application.BringToFront;
end;

procedure TForm1.LoadOptions;
begin
  try
    FormStorage1.StoredValues.RestoreValues;

    FObex.MaxPacketSize := FormStorage1.StoredValue['MaxPacketSize']; // do not localize
    ThreadSafe.InactivityTimeout := FormStorage1.StoredValue['CommTimeout']; // do not localize
    FScriptFile := FormStorage1.StoredValue['ScriptFile']; // do not localize
    FScriptEditor := FormStorage1.StoredValue['ScriptEditor']; // do not localize
    FUseScript := FormStorage1.StoredValue['UseScript']; // do not localize
    FUseScriptEditorExt := FormStorage1.StoredValue['UseScriptEditorExt']; // do not localize
    ThreadSafe.ConnectionType := FormStorage1.StoredValue['ConnectionType']; // do not localize
    FExplorerStartupMode := FormStorage1.StoredValue['ExplorerStartup']; // do not localize
    FSMSDoWarning := FormStorage1.StoredValue['SMSDoWarning']; // do not localize
    FSMSDoReset := FormStorage1.StoredValue['SMSDoReset']; // do not localize
    FBtAddress := FormStorage1.StoredValue['BluetoothAddr']; // do not localize
    FBtDevice := FormStorage1.StoredValue['BluetoothName']; // do not localize
    FBtPort := FormStorage1.StoredValue['BluetoothPort']; // do not localize
    ComPort.FlowControl.ControlRTS := TRTSFlowControl(FormStorage1.StoredValue['ComPortControlRTS']); // do not localize
    ComPort.FlowControl.ControlDTR := TDTRFlowControl(FormStorage1.StoredValue['ComPortControlDTR']); // do not localize
    FAlphaCall := FormStorage1.StoredValue['AlphaCall']; // do not localize
    FAlphaLog := FormStorage1.StoredValue['AlphaLog']; // do not localize
    FAlphaMessage := FormStorage1.StoredValue['AlphaMessage']; // do not localize
    FAlphaCompose := FormStorage1.StoredValue['AlphaCompose']; // do not localize

    FCallM := FormStorage1.StoredValue['Call Monitor']; // do not localize
    FMsgM := FormStorage1.StoredValue['Message Monitor']; // do not localize

    FCalWideView := FormStorage1.StoredValue['Calendar Wide']; // do not localize
    FCalRecurrence := FormStorage1.StoredValue['Calendar Recurr']; // do not localize
    FCalRecurrAsk := FormStorage1.StoredValue['Ask Cal Recurr']; // do not localize

    FUseSilentMonitor := FormStorage1.StoredValue['Silent Monitor']; // do not localize
    FUseMinuteMonitor := FormStorage1.StoredValue['Minute Monitor']; // do not localize
    FUseKeylockMonitor := FormStorage1.StoredValue['Keylock Monitor']; // do not localize
    FUseCSQ := FormStorage1.StoredValue['Signal Monitor']; // do not localize
    FUseCBC := FormStorage1.StoredValue['Battery Monitor']; // do not localize
    FIgnoreLowBattery := FormStorage1.StoredValue['Ignore Low Battery']; // do not localize
    FStateMonitor := FormStorage1.StoredValue['State Monitor']; // do not localize
    FShowDiagram := FormStorage1.StoredValue['Phone Diagram']; // do not localize
    FShowTodayCaption := FormStorage1.StoredValue['Today Caption']; // do not localize
    FShowSplash := FormStorage1.StoredValue['Show Splash']; // do not localize
    FAlwaysMinimized := FormStorage1.StoredValue['Always Minimized']; // do not localize

    FMinimize := FormStorage1.StoredValue['Minimize']; // do not localize
    FCheckOutbox := FormStorage1.StoredValue['Check Outbox']; // do not localize

    FAutoWebUpdateMode := FormStorage1.StoredValue['Web Update Mode']; // do not localize
    FLastWebUpdateDate := FormStorage1.StoredValue['Web Update Date']; // do not localize

    FSyncBookmarkPrio := FormStorage1.StoredValue['Sync Bookmarks']; // do not localize
    FSyncContactPrio := FormStorage1.StoredValue['Sync Contact']; // do not localize
    FSyncCalendarPrio := FormStorage1.StoredValue['Sync Calendar']; // do not localize
    FSyncClockPrio := FormStorage1.StoredValue['Sync Clock']; // do not localize
    FDontProgress := FormStorage1.StoredValue['Dont Progress']; // do not localize
    FProgressLongOnly := FormStorage1.StoredValue['Progress Long']; // do not localize
    FProgressRestoredOnly := FormStorage1.StoredValue['Progress Restored']; // do not localize
    FProgressIndicatorOnly := FormStorage1.StoredValue['Progress Indicator']; // do not localize

    FOutlookSyncConflict := FormStorage1.StoredValue['Outlook Sync Conflict']; // do not localize
    FOutlookConfirmAdding := FormStorage1.StoredValue['Outlook Sync Confirm Adding']; // do not localize
    FOutlookConfirmUpdating := FormStorage1.StoredValue['Outlook Sync Confirm Updating']; // do not localize
    FOutlookConfirmDeleting := FormStorage1.StoredValue['Outlook Sync Confirm Deleting']; // do not localize
    FOutlookNewAction := FormStorage1.StoredValue['Outlook New Action']; // do not localize

//  FConnectOnLaunch := FormStorage1.StoredValue['ConnectOnLaunch']; // do not localize
//  FAutoReconnect := FormStorage1.StoredValue['AutoReconnect']; // do not localize
    FForceUCSusage := FormStorage1.StoredValue['ForceUCS2']; // do not localize
    FArchiveDublicates := FormStorage1.StoredValue['ArchiveDubs']; // do not localize
    with FStartupOptions do begin
      NoObex := FormStorage1.StoredValue['NoObex']; // do not localize
      NoIRMC := FormStorage1.StoredValue['NoIRMC']; // do not localize
      NoGroups := FormStorage1.StoredValue['NoGroups']; // do not localize
      NoFolders := FormStorage1.StoredValue['NoFolders']; // do not localize
      NoProfiles := FormStorage1.StoredValue['NoProfiles']; // do not localize
      NoCalls := FormStorage1.StoredValue['NoCalls']; // do not localize
      NoAlarms := FormStorage1.StoredValue['NoAlarms']; // do not localize
      NoBaloons := FormStorage1.StoredValue['NoBaloons']; // do not localize
      NoClock := FormStorage1.StoredValue['NoClock']; // do not localize
    end;
    with FProximityOptions do begin
      AwayLock := FormStorage1.StoredValue['AwayLock']; // do not localize
      NearUnlock := FormStorage1.StoredValue['NearUnlock']; // do not localize
      AwayMusicMode := FormStorage1.StoredValue['AwayMusicMode']; // do not localize
      NearMusicMode := FormStorage1.StoredValue['NearMusicMode']; // do not localize
      RunSS := FormStorage1.StoredValue['RunSS']; // do not localize
    end;
    with FTextMessageOptions do begin
      NoPopup := FormStorage1.StoredValue['MsgNoPopup']; // do not localize
      NoBaloon := FormStorage1.StoredValue['MsgNoBaloon']; // do not localize
      MoveToArchive := FormStorage1.StoredValue['MsgAutoArchive']; // do not localize
      FullWarning := FormStorage1.StoredValue['MsgFullWarning']; // do not localize
    end;
    with FCallOptions do begin
      NoPopup := FormStorage1.StoredValue['CallNoPopup']; // do not localize
      NoBaloon := FormStorage1.StoredValue['CallNoBaloon']; // do not localize
    end;
    FAutoProfile := FormStorage1.StoredValue['AutoProfileName'] <> ''; // do not localize
    FDisplayNameFormat := FormStorage1.StoredValue['DisplayNameFormat']; // do not localize
  except
  end;
end;

procedure TForm1.ActionToolsOptionsExecute(Sender: TObject);
var
  ScriptCheck,IrmcSyncCheck,RunWizard: Boolean;
  i: Integer;
begin
  IrmcSyncCheck := False;
  frmOptions := TfrmOptions.Create(Self);
  with frmOptions do try
    // Connection
    connectionType := ThreadSafe.ConnectionType;
    { BtDevice is read-only }
    BtAddress := FBtAddress;
    edBTPortSpin.Position := StrToInt(FBtPort);
    sePort.Text := ComPort.Port;
    cbBaudrate.ItemIndex := Integer(ComPort.BaudRate);
    cbRTSFlow.ItemIndex := Integer(ComPort.FlowControl.ControlRTS);
    cbDTRFlow.ItemIndex := Integer(ComPort.FlowControl.ControlDTR);

    // Communication
    sePollingSpin.Position := Round(Timer1.Interval / 1000);
    seCommTimeoutSpin.Position := Round(ThreadSafe.InactivityTimeout / 1000);
    cbIgnoreLowBattery.Checked := FIgnoreLowBattery;
    cbDiagram.Checked := FShowDiagram;
    cbAutoProfile.Checked := FAutoProfile;

    // Advanced
    cbStateMonitor.Checked := FStateMonitor;
    cbStateMonitorClick(nil);
    cbBatterylMonitor.Checked := FUseCBC;
    cbBatterylMonitorClick(nil);
    cbSignalMonitor.Checked := FUseCSQ;
    cbSilentMonitor.Checked := FUseSilentMonitor;
    cbMinuteMonitor.Checked := FUseMinuteMonitor;
    cbKeylockMonitor.Checked := FUseKeylockMonitor;
    { allow change only if Proximity Monitoring is disabled }
    cbKeylockMonitor.Enabled := not ActionConnectionMonitor.Checked;
    if not cbKeylockMonitor.Checked and not cbKeylockMonitor.Enabled then
      cbKeylockMonitor.State := cbGrayed;

    // OBEX
    seMaxPacketSizeSpin.Position := FObex.MaxPacketSize;

    // Scripts
    CheckScriptEditorExt;
    edScriptEditor.Text := FScriptEditor;
    if FUseScriptEditorExt then
      rbScriptEditorExternal.Checked := True;
    rdScriptEditorClick(nil);

    edScriptPath.Text := FScriptFile;
    edScriptPathChange(edScriptPath);
    if FUseScript then cbUseScripts.Checked := True
      else cbDoNotUseScripts.Checked := True;
    cbUseScriptsClick(nil);

    //Alpha
    tbComposeSpin.Position := FAlphaCompose;
    tbCallSpin.Position := FAlphaCall;
    tbLogSpin.Position := FAlphaLog;
    tbMessageSpin.Position := FAlphaMessage;

    //Monitor
    with FCallOptions do begin
      cbNoCallPopup.Checked := NoPopup;
      cbNoCallBaloon.Checked := NoBaloon;
    end;
    chkCallM.Checked := FCallM;
    chkCallMClick(nil);
    with FTextMessageOptions do begin
      cbNoMsgPopup.Checked := NoPopup;
      cbNoMsgBaloon.Checked := NoBaloon;
      cbMsgToArchive.Checked := MoveToArchive;
      cbMsgFullWarning.Checked := FullWarning;
    end;
    chkMsgM.Checked := FMsgM;
    chkMsgMClick(nil);

    chkMinButton.Checked := FMinimize;
    cbCheckOutbox.Checked := FCheckOutbox;

    //Synchronize
    rbBookmarksSync.ItemIndex := FSyncBookmarkPrio;
    rbSyncPhonebook.ItemIndex := FSyncContactPrio;
    rbSyncCalendar.ItemIndex := FSyncCalendarPrio;
    rbPhoneClockSync.ItemIndex := FSyncClockPrio;
    cbAutoInbox.Checked := FormStorage1.StoredValue['AutoInbox'] = True; // do not localize
    cbAutoSync.Checked := FormStorage1.StoredValue['AutoSync'] = True; // do not localize
    cbAutoCalendar.Checked := FormStorage1.StoredValue['AutoCalendar'] = True; // do not localize
    cbAutoOutlookSync.Checked := FormStorage1.StoredValue['AutoSyncOutlook'] = True; // do not localize
    cbAutoBookmarks.Checked := FormStorage1.StoredValue['AutoBookmarks'] = True; // do not localize
    edBookmarkDir.Text := FBookmarkRootFolder;
    rbBookmarksIE.Checked := FSyncBookmarksIE;
    rbBookmarksFirefox.Checked := FSyncBookmarksFirefox;
    rbBookmarksOpera.Checked := FSyncBookmarksOpera;
    cbCalWideMode.Checked := FCalWideView;
    cbCalRecurrence.Checked := FCalRecurrence;
    cbCalRecurrenceClick(nil);
    cbCalRecurrAsk.Checked := FCalRecurrAsk;

    //Outlook Sync
    rbOutlookSync.ItemIndex := FOutlookSyncConflict;
    cbConfirmAdding.Checked := FOutlookConfirmAdding;
    cbConfirmUpdating.Checked := FOutlookConfirmUpdating;
    cbConfirmDeleting.Checked := FOutlookConfirmDeleting;
    OutlookCategories := FOutlookCategories;
    case FOutlookNewAction of
      0: rbOutlookNewActionLinkTo.Checked := True;
      1: rbOutlookNewActionAsNew.Checked := True;
    end;
    SelectedOutlookContactFolders := FSelectedOutlookContactFolders;
    OutlookNewContactsFolder := FOutlookNewContactsFolder;
    SelectedOutlookCalendarFolders := FSelectedOutlookCalendarFolders;
    OutlookNewCalendarFolder := FOutlookNewCalendarFolder;
    SelectedOutlookTaskFolders := FSelectedOutlookTaskFolders;
    OutlookNewTasksFolder := FOutlookNewTasksFolder;
    OutlookFieldMappings := FOutlookFieldMappings;

    //Regional settings
    cbForceUCS2.Checked := FForceUCSusage;
    UILangChanged := False;

    // Interface
    cbProgressLongOnly.Checked := FProgressLongOnly;
    cbProgressRestoredOnly.Checked := FProgressRestoredOnly;
    rbDontShowProgress.Checked := FDontProgress;
    rbShowProgressIndicator.Checked := FProgressIndicatorOnly;
    rbProgressClick(nil);
    cbWelcomeTips.Checked := Form1.FormStorage1.StoredValue['Welcome Tips'] = True; // do not localize

    // Chat
    edChatName.Text := FChatNick;
    cbChatLongSMS.Checked := FChatLongSMS;
    cbChatBoldFont.Checked := FChatBold;

    // Web Update
    case FAutoWebUpdateMode of
      0: rbWebUpdateNone.Checked := True;
      1: rbWebUpdateStartup.Checked := True;
      2: rbWebUpdateDaily.Checked := True;
      3: rbWebUpdateWeekly.Checked := True;
    end;
    edWebUpdatesURL.Text := FmaWebUpdate1.UpdatesURL;
    lblSupportURL.Hint := FmaWebUpdate1.SupportURL; // used for ShellExecute call

    // Startup Options
    with FStartupOptions do begin
      cbNoIRMC.Checked := NoIRMC;
      cbNoGroups.Checked := NoGroups;
      cbNoFolders.Checked := NoFolders;
      cbNoProfiles.Checked := NoProfiles;
      cbNoProfilesClick(nil);
      cbNoCalls.Checked := NoCalls;
      cbNoAlarms.Checked := NoAlarms;
      cbNoObex.Checked := NoObex;
      cbNoObexClick(nil);
      cbNotifyBaloons.Checked := not NoBaloons;
      cbAutoClock.Checked := not NoClock;
    end;
    cbShowSplash.Checked := FShowSplash;
    cbAlwaysMinimized.Checked := FAlwaysMinimized;
    cbAlwaysMinimizedClick(nil);

    // Appearance
    rgExplorer.ItemIndex := FExplorerStartupMode;
    cbSMSWarning.Checked := FSMSDoWarning;
    cbSMSReset.Checked := FSMSDoReset;
    udSMSCnt.Position := FSMSWarning;
    udSMSCntRst.Position := FSMSCounterResetDay;

    // Proximity settings
    with FProximityOptions do begin
      cbProximityLock.Checked := AwayLock;
      rgProximityAway.ItemIndex := AwayMusicMode;
      cbProximityUnlock.Checked := NearUnlock;
      rgProximityNear.ItemIndex := NearMusicMode;
      cbRunSS.Checked := RunSS;
    end;

    // Contacts settings
    cbDisplayNameFormat.ItemIndex := FDisplayNameFormat;

    // Delivery rules
    DeliveryRules := FDeliveryRules.Text;
    cbArchiveDublicates.Checked := FArchiveDublicates;

    (*******************************************************************************
     *                                                                             *
     *  SHOW FMA OPTIONS MODAL DIALOG HERE....                                     *
     *                                                                             *
     *******************************************************************************)
    if ShowModal = mrOK then begin
      // Delivery rules
      FDeliveryRules.Text := DeliveryRules;

      // Appearance
      FSMSDoWarning := cbSMSWarning.Checked;
      FormStorage1.StoredValue['SMSDoWarning'] := FSMSDoWarning; // do not localize
      FSMSDoReset := cbSMSReset.Checked;
      FormStorage1.StoredValue['SMSDoReset'] := FSMSDoReset; // do not localize
      FExplorerStartupMode := rgExplorer.ItemIndex;
      FormStorage1.StoredValue['ExplorerStartup'] := FExplorerStartupMode; // do not localize
      FSMSWarning := udSMSCnt.Position;
      FSMSCounterResetDay := udSMSCntRst.Position;

      // Proximity settings
      with FProximityOptions do begin
        AwayLock := cbProximityLock.Checked;
        AwayMusicMode := rgProximityAway.ItemIndex;
        NearUnlock := cbProximityUnlock.Checked;
        NearMusicMode := rgProximityNear.ItemIndex;
        RunSS := cbRunSS.Checked;
        FormStorage1.StoredValue['AwayLock'] := AwayLock; // do not localize
        FormStorage1.StoredValue['AwayMusicMode'] := AwayMusicMode; // do not localize
        FormStorage1.StoredValue['NearUnlock'] := NearUnlock; // do not localize
        FormStorage1.StoredValue['NearMusicMode'] := NearMusicMode; // do not localize
        FormStorage1.StoredValue['RunSS'] := RunSS; // do not localize
      end;

      // Startup Options
      IrmcSyncCheck := FStartupOptions.NoObex or FStartupOptions.NoIRMC;
      with FStartupOptions do begin
        NoObex := cbNoObex.Checked;
        NoIRMC := cbNoIRMC.Checked;
        NoGroups := cbNoGroups.Checked;
        NoFolders := cbNoFolders.Checked;
        NoProfiles := cbNoProfiles.Checked;
        NoCalls := cbNoCalls.Checked;
        NoAlarms := cbNoAlarms.Checked;
        NoBaloons := not cbNotifyBaloons.Checked;
        NoClock := not cbAutoClock.Checked;
        FormStorage1.StoredValue['NoObex'] := NoObex; // do not localize
        FormStorage1.StoredValue['NoIRMC'] := NoIRMC; // do not localize
        FormStorage1.StoredValue['NoGroups'] := NoGroups; // do not localize
        FormStorage1.StoredValue['NoFolders'] := NoFolders; // do not localize
        FormStorage1.StoredValue['NoProfiles'] := NoProfiles; // do not localize
        FormStorage1.StoredValue['NoCalls'] := NoCalls; // do not localize
        FormStorage1.StoredValue['NoAlarms'] := NoAlarms; // do not localize
        FormStorage1.StoredValue['NoBaloons'] := NoBaloons; // do not localize
        FormStorage1.StoredValue['NoClock'] := NoClock; // do not localize
      end;
      IrmcSyncCheck := IrmcSyncCheck <> (FStartupOptions.NoObex or FStartupOptions.NoIRMC);
      Form1.FormStorage1.StoredValue['Welcome Tips'] := cbWelcomeTips.Checked; // do not localize

      FAutoProfile := cbAutoProfile.Checked;
      if FAutoProfile then FormStorage1.StoredValue['AutoProfileName'] := cbProfile.Text // do not localize
        else FormStorage1.StoredValue['AutoProfileName'] := ''; // do not localize
      FShowSplash := cbShowSplash.Checked;
      FAlwaysMinimized := cbAlwaysMinimized.Checked;
      FormStorage1.StoredValue['Show Splash'] := FShowSplash; // do not localize
      FormStorage1.StoredValue['Always Minimized'] := FAlwaysMinimized; // do not localize

      // Activate/Save the changes
      try
        if ComPort.BaudRate <> StrToBaudRate(cbBaudrate.Text) then
          ComPort.BaudRate := StrToBaudRate(cbBaudrate.Text);
      except
        Status(_('Reconnection needed (Baudrate changed)'));
      end;

      try
        if ComPort.Port <> sePort.Text then
          ComPort.Port := sePort.Text;
      except
        Status(_('Serial port/device change Failed'));
      end;

      try
        if Integer(ComPort.FlowControl.ControlRTS) <> cbRTSFlow.ItemIndex then
        begin
          ComPort.FlowControl.ControlRTS := TRTSFlowControl(cbRTSFlow.ItemIndex);
          FormStorage1.StoredValue['ComPortControlRTS'] := Integer(ComPort.FlowControl.ControlRTS); // do not localize
        end;

        if Integer(ComPort.FlowControl.ControlDTR) <> cbDTRFlow.ItemIndex then
        begin
          ComPort.FlowControl.ControlDTR := TDTRFlowControl(cbDTRFlow.ItemIndex);
          FormStorage1.StoredValue['ComPortControlDTR'] := Integer(ComPort.FlowControl.ControlDTR); // do not localize
        end;
      except
        Status(_('Flow Control change failed'));
      end;

      if ThreadSafe.ConnectionType <> connectionType then begin
        ActionConnectionDisconnect.Execute;
        ThreadSafe.ConnectionType := connectionType;
        FormStorage1.StoredValue['ConnectionType'] := ThreadSafe.ConnectionType; // do not localize
      end;

      FAutoWebUpdateMode := 0;
      if rbWebUpdateStartup.Checked then FAutoWebUpdateMode := 1;
      if rbWebUpdateDaily.Checked then FAutoWebUpdateMode := 2;
      if rbWebUpdateWeekly.Checked then FAutoWebUpdateMode := 3;
      FormStorage1.StoredValue['Web Update Mode'] := FAutoWebUpdateMode; // do not localize
      FmaWebUpdate1.UpdatesURL := edWebUpdatesURL.Text;

      FDontProgress := rbDontShowProgress.Checked;
      FProgressIndicatorOnly := rbShowProgressIndicator.Checked;
      FormStorage1.StoredValue['Progress Indicator'] := FProgressIndicatorOnly; // do not localize
      FormStorage1.StoredValue['Dont Progress'] := FDontProgress; // do not localize

      FProgressLongOnly := cbProgressLongOnly.Checked;
      FProgressRestoredOnly := cbProgressRestoredOnly.Checked;
      FormStorage1.StoredValue['Progress Long'] := FProgressLongOnly; // do not localize
      FormStorage1.StoredValue['Progress Restored'] := FProgressRestoredOnly; // do not localize

      FBtAddress := BtAddress;
      FBtDevice := BtDevice;
      FormStorage1.StoredValue['BluetoothAddr'] := FBtAddress; // do not localize
      FormStorage1.StoredValue['BluetoothName'] := FBtDevice; // do not localize

      FBtPort := IntToStr(edBTPortSpin.Position);
      FormStorage1.StoredValue['BluetoothPort'] := FBtPort; // do not localize

      Timer1.Interval := sePollingSpin.Position * 1000;

      FObex.MaxPacketSize := seMaxPacketSizeSpin.Position;
      FormStorage1.StoredValue['MaxPacketSize'] := FObex.MaxPacketSize; // do not localize

      ThreadSafe.InactivityTimeout := seCommTimeoutSpin.Position * 1000;
      FormStorage1.StoredValue['CommTimeout'] := ThreadSafe.InactivityTimeout; // do not localize

      FShowDiagram := cbDiagram.Checked;
      FormStorage1.StoredValue['Phone Diagram'] := FShowDiagram; // do not localize
      FStateMonitor := cbStateMonitor.Checked;
      FormStorage1.StoredValue['State Monitor'] := FStateMonitor; // do not localize
      if not FStateMonitor or frmInfoView.Visible then
        EBCAState(FStateMonitor,False); // false = do not alter key monitoring
      FIgnoreLowBattery := cbIgnoreLowBattery.Checked;
      FormStorage1.StoredValue['Ignore Low Battery'] := FIgnoreLowBattery; // do not localize
      FUseCBC := cbBatterylMonitor.Checked;
      FormStorage1.StoredValue['Battery Monitor'] := FUseCBC; // do not localize
      if FUseCBC then begin
        if FConnected and FConnectingComplete and not FObex.Connected and
          not ThreadSafe.Busy and not ThreadSafe.WaitingOK and not ThreadSafe.ObexConnecting then
          GetBatteryMeter;
        //if frmInfoView.Visible then frmInfoView.UpdateWelcomePage;
      end
      else begin
        SetPanelText(2, _('Battery N/A'));
        pbPower.Position := 0;
      end;
      FUseCSQ := cbSignalMonitor.Checked;
      FormStorage1.StoredValue['Signal Monitor'] := FUseCSQ; // do not localize
      if FUseCSQ then begin
        if FConnected and FConnectingComplete and not FObex.Connected and
          not ThreadSafe.Busy and not ThreadSafe.WaitingOK and
          not ThreadSafe.ObexConnecting then 
          GetSignalMeter;
        //if frmInfoView.Visible then frmInfoView.UpdateWelcomePage;
      end
      else begin
        SetPanelText(3, _('Signal N/A'));
        pbRSSI.Position := 0;
      end;
      FUseSilentMonitor := cbSilentMonitor.Checked;
      FormStorage1.StoredValue['Silent Monitor'] := FUseSilentMonitor; // do not localize
      FUseMinuteMonitor := cbMinuteMonitor.Checked;
      FormStorage1.StoredValue['Minute Monitor'] := FUseMinuteMonitor; // do not localize
      if cbKeylockMonitor.Enabled then begin
        FUseKeylockMonitor := cbKeylockMonitor.Checked;
        FormStorage1.StoredValue['Keylock Monitor'] := FUseKeylockMonitor; // do not localize
      end;

      //Alpha Blending
      FAlphaCall := tbCallSpin.Position;
      FormStorage1.StoredValue['AlphaCall'] := FAlphaCall; // do not localize
      FAlphaLog := tbLogSpin.Position;
      FormStorage1.StoredValue['AlphaLog'] := FAlphaLog; // do not localize
      FAlphaMessage := tbMessageSpin.Position;
      FormStorage1.StoredValue['AlphaMessage'] := FAlphaMessage; // do not localize
      FAlphaCompose := tbComposeSpin.Position;
      FormStorage1.StoredValue['AlphaCompose'] := FAlphaCompose; // do not localize
      { no reason to update frmNewMessage alpha } 
      if Assigned(FLogForm) and FLogForm.Visible then
        FLogForm.AlphaBlendValue := FAlphaLog;
      if Assigned(frmCalling) and frmCalling.Visible then
        frmCalling.AlphaBlendValue := FAlphaCall;
      if Assigned(frmCallContact) and frmCallContact.Visible then
        frmCallContact.AlphaBlendValue := FAlphaCall;
      if Assigned(frmMessageContact) and frmMessageContact.Visible then
        frmMessageContact.AlphaBlendValue := FAlphaCompose;
      if Assigned(frmNewAlarm) and frmNewAlarm.Visible then
        frmNewAlarm.AlphaBlendValue := FAlphaCompose;

      //Monitor
      FCallM := chkCallM.Checked;
      FormStorage1.StoredValue['Call Monitor'] := FCallM; // do not localize
      FMsgM := chkMsgM.Checked;
      FormStorage1.StoredValue['Message Monitor'] := FMsgM; // do not localize

      FMinimize := chkMinButton.Checked;
      FormStorage1.StoredValue['Minimize'] := FMinimize; // do not localize
      FCheckOutbox := cbCheckOutbox.Checked;
      FormStorage1.StoredValue['Check Outbox'] := FCheckOutbox; // do not localize

      with FTextMessageOptions do begin
        NoPopup := cbNoMsgPopup.Checked;
        NoBaloon := cbNoMsgBaloon.Checked;
        MoveToArchive := cbMsgToArchive.Checked;
        FullWarning := cbMsgFullWarning.Checked;
        FormStorage1.StoredValue['MsgNoPopup'] := NoPopup; // do not localize
        FormStorage1.StoredValue['MsgNoBaloon'] := NoBaloon; // do not localize
        FormStorage1.StoredValue['MsgAutoArchive'] := MoveToArchive; // do not localize
        FormStorage1.StoredValue['MsgFullWarning'] := FullWarning; // do not localize
      end;
      with FCallOptions do begin
        NoPopup := cbNoCallPopup.Checked;
        NoBaloon := cbNoCallBaloon.Checked;
        FormStorage1.StoredValue['CallNoPopup'] := NoPopup; // do not localize
        FormStorage1.StoredValue['CallNoBaloon'] := NoBaloon; // do not localize
      end;

      //Synchronize
      FSyncBookmarkPrio := rbBookmarksSync.ItemIndex;
      FormStorage1.StoredValue['Sync Bookmarks'] := FSyncBookmarkPrio; // do not localize
      FSyncContactPrio := rbSyncPhonebook.ItemIndex;
      FormStorage1.StoredValue['Sync Contact'] := FSyncContactPrio; // do not localize
      FSyncCalendarPrio := rbSyncCalendar.ItemIndex;
      FormStorage1.StoredValue['Sync Calendar'] := FSyncCalendarPrio; // do not localize
      FSyncClockPrio := rbPhoneClockSync.ItemIndex; // do not localize
      FormStorage1.StoredValue['Sync Clock'] := FSyncClockPrio; // do not localize
      FormStorage1.StoredValue['AutoInbox'] := cbAutoInbox.Checked; // do not localize
      FormStorage1.StoredValue['AutoSync'] := cbAutoSync.Checked; // do not localize
      FormStorage1.StoredValue['AutoCalendar'] := cbAutoCalendar.Checked; // do not localize
      FormStorage1.StoredValue['AutoSyncOutlook'] := cbAutoOutlookSync.Checked; // do not localize
      FormStorage1.StoredValue['AutoBookmarks'] := cbAutoBookmarks.Checked; // do not localize
      FBookmarkRootFolder := edBookmarkDir.Text;
      FSyncBookmarksIE := rbBookmarksIE.Checked;
      FSyncBookmarksFirefox := rbBookmarksFirefox.Checked;
      FSyncBookmarksOpera := rbBookmarksOpera.Checked;
      FCalWideView := cbCalWideMode.Checked;
      FCalRecurrence := cbCalRecurrence.Checked;
      FCalRecurrAsk := cbCalRecurrAsk.Checked;
      FormStorage1.StoredValue['Calendar Wide'] := FCalWideView; // do not localize
      FormStorage1.StoredValue['Calendar Recurr'] := FCalRecurrence; // do not localize
      FormStorage1.StoredValue['Ask Cal Recurr'] := FCalRecurrAsk; // do not localize

      //Outlook Synchronize
      FOutlookSyncConflict := rbOutlookSync.ItemIndex;
      FormStorage1.StoredValue['Outlook Sync Conflict'] := FOutlookSyncConflict; // do not localize
      FOutlookConfirmAdding := cbConfirmAdding.Checked;
      FormStorage1.StoredValue['Outlook Sync Confirm Adding'] := FOutlookConfirmAdding; // do not localize
      FOutlookConfirmUpdating := cbConfirmUpdating.Checked;
      FormStorage1.StoredValue['Outlook Sync Confirm Updating'] := FOutlookConfirmUpdating; // do not localize
      FOutlookConfirmDeleting := cbConfirmDeleting.Checked;
      FormStorage1.StoredValue['Outlook Sync Confirm Deleting'] := FOutlookConfirmDeleting; // do not localize
      FOutlookCategories := OutlookCategories;
      FSelectedOutlookContactFolders := SelectedOutlookContactFolders;
      FSelectedOutlookCalendarFolders := SelectedOutlookCalendarFolders;
      FSelectedOutlookTaskFolders := SelectedOutlookTaskFolders;
      FOutlookNewContactsFolder := OutlookNewContactsFolder;
      FOutlookNewCalendarFolder := OutlookNewCalendarFolder;
      FOutlookNewTasksFolder := OutlookNewTasksFolder;
      FOutlookFieldMappings := OutlookFieldMappings;
      FOutlookNewAction := byte(rbOutlookNewActionAsNew.Checked);
      FormStorage1.StoredValue['Outlook New Action'] := FOutlookNewAction; // do not localize

      //Chat
      FChatNick := edChatName.Text;
      FChatLongSMS := cbChatLongSMS.Checked;
      FChatBold := cbChatBoldFont.Checked;
      { disabled - will clear font formatting...
      for i := 0 to Screen.FormCount-1 do
        if Screen.Forms[i] is TfrmCharMessage then
          with (Screen.Forms[i] as TfrmCharMessage) do begin
            if FChatBold then Chat.Font.Style := Chat.Font.Style + [fsBold]
              else Chat.ParentFont := True;
          end;
      }

      //Regional
      FForceUCSusage := cbForceUCS2.Checked;
      FormStorage1.StoredValue['ForceUCS2'] := FForceUCSusage; // do not localize
      if UILangChanged then FormStorage1.StoredValue['LANG'] := NewUILang; // do not localize

      //Contacts settings
      FDisplayNameFormat := cbDisplayNameFormat.ItemIndex;
      FormStorage1.StoredValue['DisplayNameFormat'] := FDisplayNameFormat; // do not localize

      //Delivery rules
      FArchiveDublicates := cbArchiveDublicates.Checked;
      FormStorage1.StoredValue['ArchiveDubs'] := FArchiveDublicates; // do not localize

      //Script - keep this the last in this begin..end statement
      FScriptEditor := edScriptEditor.Text;
      CheckScriptEditorExt;
      FUseScriptEditorExt := rbScriptEditorExternal.Checked;
      FormStorage1.StoredValue['ScriptEditor'] := FScriptEditor; // do not localize
      FormStorage1.StoredValue['UseScriptEditorExt'] := FUseScriptEditorExt; // do not localize

      ScriptCheck := FUseScript;
      FUseScript := cbUseScripts.Checked or cbUseScriptingFramework.Checked;
      FormStorage1.StoredValue['UseScript'] := FUseScript; // do not localize
      if FUseScript and (not ScriptCheck or (WideCompareText(FScriptFile,edScriptPath.Text) <> 0)) then begin
        ScriptingEnable(edScriptPath.Text);
      end;
      if not FUseScript and ScriptCheck then
        ScriptingDisable;

      // Remember changes
      SavePhoneDataFiles(True);
    end;
  finally
    RunWizard := frmOptions.RunGettingStarted;
    frmOptions.Free;
    { Update view }
    if IrmcSyncCheck then begin
      { IrmcSync setting changed, so collapse the Phonebook(ME) node
        in order to update its view database when selected again. }
      if Form1.ExplorerNew.Expanded[Form1.FNodeContactsME] then
        Form1.ExplorerNew.Expanded[Form1.FNodeContactsME] := false;
    end;
    ExplorerNewChange(ExplorerNew, ExplorerNew.FocusedNode);
  end;
  if RunWizard then GettingStarted1.Click;
end;

procedure TForm1.SavePhoneDataFiles(ShowStatus: Boolean);
var
  Fullpath: string;
  OldStat: WideString;
  i: integer;
  EData: PFmaExplorerNode;
begin
  { Is there a database loaded at all? }
  if not FDatabaseLoaded then
    exit;

  if ShowStatus and Visible then begin
    OldStat := GetStatus;
    Status(_('Saving current profile...'));
    Update;
  end;

  { Get Database dir path, i.e. "...\ID\dat\" }
  Fullpath := GetDatabasePath; // do not localize
  { Create profile dir if needed }
  ForceDirectories(Fullpath);
  { Save phone database files into phone profile dir }
  if not IsAutoConnect then
    Log.AddMessage('Database: Saving to '+Fullpath, lsDebug); // do not localize debug

  { Save Profile settings }
  with TIniFile.Create(Fullpath + 'Phone.dat') do // do not localize
  try
    if PhoneIdentity = '' then FSelPhone := ''; // reset phone name if default profile is saved
    WriteString('Global','Modified',IntToStr(Trunc(Date))); // do not localize
    WriteString('Global','DBVersion',WideStringToUTF8String(FDatabaseVersion)); // do not localize
    WriteString('Global','PhoneName',WideStringToUTF8String(FSelPhone)); // do not localize
    WriteString('Global','PhoneBrand',WideStringToUTF8String(FPhoneModel)); // do not localize
    WriteBool('SMS','Reset',FSMSCounterReseted); // do not localize
    WriteInteger('SMS','Reset Day',FSMSCounterResetDay); // do not localize
    WriteInteger('SMS','Reset Last Month',FSMSCounterResetLastMonth); // do not localize
    WriteInteger('SMS','Count',FSMSCounter);  // do not localize
    WriteInteger('SMS','Warning',FSMSWarning);  // do not localize
    WriteString('Outlook','Categories','"'+WideStringToUTF8String(FOutlookCategories)+'"'); // do not localize
    WriteString('Outlook','ContactsFolder',WideStringToUTF8String(FSelectedOutlookContactFolders)); // do not localize
    WriteString('Outlook','NewContactsFolder',WideStringToUTF8String(FOutlookNewContactsFolder)); // do not localize
    WriteString('Outlook','CalendarFolder',WideStringToUTF8String(FSelectedOutlookCalendarFolders)); // do not localize
    WriteString('Outlook','NewCalendarFolder',WideStringToUTF8String(FOutlookNewCalendarFolder)); // do not localize
    WriteString('Outlook','TasksFolder',WideStringToUTF8String(FSelectedOutlookTaskFolders)); // do not localize
    WriteString('Outlook','NewTasksFolder',WideStringToUTF8String(FOutlookNewTasksFolder)); // do not localize
    WriteString('Outlook','FieldMappings','"'+WideStringToUTF8String(FOutlookFieldMappings)+'"');  // do not localize
    WriteString('Bookmarks','Root',FBookmarkRootFolder); // do not localize
    WriteBool('Bookmarks','IE',FSyncBookmarksIE); // do not localize
    WriteBool('Bookmarks','Firefox',FSyncBookmarksFirefox); // do not localize
    WriteBool('Bookmarks','Opera',FSyncBookmarksOpera); // do not localize
    EraseSection('Favorites SMS'); // do not localize
    for i := 0 to FFavoriteRecipients.Count-1 do
      WriteString('Favorites SMS',IntToStr(i+1),'"'+WideStringToUTF8String(FFavoriteRecipients[i])+'"'); // do not localize
    EraseSection('Favorites Call'); // do not localize
    for i := 0 to FFavoriteCalls.Count-1 do
      WriteString('Favorites Call',IntToStr(i+1),'"'+WideStringToUTF8String(FFavoriteCalls[i])+'"'); // do not localize
    EraseSection('Delivery Rules'); // do not localize
    for i := 0 to FDeliveryRules.Count-1 do
      WriteString('Delivery Rules',IntToStr(i+1),'"'+WideStringToUTF8String(FDeliveryRules[i])+'"'); // do not localize
    WriteString('Chat','Nick','"'+WideStringToUTF8String(FChatNick)+'"'); // do not localize
    WriteBool('Chat','Long SMS',FChatLongSMS); // do not localize
    WriteBool('Chat','Bold Font',FChatBold); // do not localize
    WriteInteger('Contacts','PBMax',frmSyncPhonebook.FMaxRecME);  // do not localize
    WriteInteger('Contacts','PBMaxName',frmSyncPhonebook.FMaxNameLen);  // do not localize
    WriteInteger('Contacts','PBMaxTel',frmSyncPhonebook.FMaxTelLen);  // do not localize
    WriteInteger('Contacts','PBMaxTitle',frmSyncPhonebook.FMaxTitleLen);  // do not localize
    WriteInteger('Contacts','PBMaxOrg',frmSyncPhonebook.FMaxOrgLen);  // do not localize
    WriteInteger('Contacts','PBMaxMail',frmSyncPhonebook.FMaxMailLen);  // do not localize
    WriteInteger('Contacts','MEMax',frmMEEdit.FMaxNumbers);  // do not localize
    WriteInteger('Contacts','MEMaxName',frmMEEdit.FMaxNameLen);  // do not localize
    WriteInteger('Contacts','MEMaxTel',frmMEEdit.FMaxTelLen);  // do not localize
    WriteInteger('Contacts','SMMax',frmSMEdit.FMaxNumbers);  // do not localize
    WriteInteger('Contacts','MEMaxName',frmSMEdit.FMaxNameLen);  // do not localize
    WriteInteger('Contacts','MEMaxTel',frmSMEdit.FMaxTelLen);  // do not localize
    WriteString('Connection','COM',ComPort.Port); // do not localize
  finally
    Free;
  end;

  { Save database files }
  FNewPDUList.SaveToFile(Fullpath + 'SMSIncoming.dat'); // do not localize
  FNewMessageList.SaveToFile(Fullpath + 'SMSIncoming.Index.dat'); // do not localize

  EData := ExplorerNew.GetNodeData(FNodeMsgInbox);
  TStrings(EData.Data).SaveToFile(Fullpath + 'SMSInbox.dat'); // do not localize
  EData := ExplorerNew.GetNodeData(FNodeMsgOutbox);
  TStrings(EData.Data).SaveToFile(Fullpath + 'SMSOutbox.dat'); // do not localize
  EData := ExplorerNew.GetNodeData(FNodeMsgSent);
  TStrings(EData.Data).SaveToFile(Fullpath + 'SMSSent.dat'); // do not localize
  EData := ExplorerNew.GetNodeData(FNodeMsgArchive);
  TStrings(EData.Data).SaveToFile(Fullpath + 'SMSArchive.dat'); // do not localize
  EData := ExplorerNew.GetNodeData(FNodeMsgDrafts);
  TStrings(EData.Data).SaveToFile(Fullpath + 'SMSDrafts.dat'); // do not localize
  EData := ExplorerNew.GetNodeData(FNodeContactsME);
  TStrings(EData.Data).SaveToFile(Fullpath + 'Contacts.ME.dat'); // do not localize
  EData := ExplorerNew.GetNodeData(FNodeContactsSM);
  TStrings(EData.Data).SaveToFile(Fullpath + 'Contacts.SM.dat'); // do not localize

  SaveUserFoldersData(Fullpath);

  frmSyncBookmarks.SaveBookmarks(Fullpath + 'Bookmarks.dat'); // do not localize
  frmSyncPhonebook.SaveContacts(Fullpath + 'Contacts.SYNC.dat'); // do not localize
  frmCalendarView.SaveCalendar(Fullpath + 'Calendar.vcs'); // do not localize

  { Backward compatability support }
  if FindCmdLineSwitch('MIGRATEDB') then begin // do not localize
    { Delete old common files, if any -- upgradeing from single database }
    if (PhoneIdentity <> '') and FileExists(ExePath + 'Phone.dat') then // do not localize
    try
      DeleteFile(ExePath + 'Phone.dat'); // do not localize
      DeleteFile(ExePath + 'SMSInbox.dat'); // do not localize
      DeleteFile(ExePath + 'SMSIncoming.dat'); // do not localize
      DeleteFile(ExePath + 'SMSIncoming.Index.dat'); // do not localize
      DeleteFile(ExePath + 'SMSOutbox.dat'); // do not localize
      DeleteFile(ExePath + 'SMSSent.dat'); // do not localize
      DeleteFile(ExePath + 'SMSArchive.dat'); // do not localize
      DeleteFile(ExePath + 'SMSDrafts.dat'); // do not localize
      DeleteFile(ExePath + 'Contacts.ME.dat'); // do not localize
      DeleteFile(ExePath + 'Contacts.SM.dat'); // do not localize
      DeleteFile(ExePath + 'Contacts.SYNC.dat'); // do not localize
      DeleteFile(ExePath + 'Contacts.SYNCMAX.dat'); // do not localize
      DeleteFile(ExePath + 'Calendar.vcs'); // do not localize
      DeleteFile(ExePath + 'Calendar.SYNC.dat'); // do not localize
      DeleteFile(ExePath + 'Bookmarks.dat'); // do not localize
      DeleteFile(ExePath + 'Bookmarks.SYNC.dat'); // do not localize
      DeleteFile(ExePath + 'CallNotes.dat'); // do not localize
      DeleteFile(ExePath + 'ContactSync.xml'); // do not localize
      DeleteFile(ExePath + 'UserFolders.dat'); // do not localize
    except
    end;
  end;

  if ShowStatus and Visible then
    Status(OldStat,False);
end;

procedure TForm1.ScriptControlError(Sender: TObject;
  Error: TawScriptError);
var
  s: string;
begin
  FScriptErrorOccur := True;
  s := Error.Description;
  if Trim(s) <> '' then s := '"' + s + '"';
  Log.AddScriptMessageFmt('Script: Error at line %d, col %d %s',[Error.Line,Error.Column,s], lsDebug); // do not localize debug
end;

procedure TForm1.ActionToolsEditScriptExecute(Sender: TObject);
var
  ed,vb: String;
begin
  if FUseScriptEditorExt then begin
    if not FUseScript then
      case MessageDlgW(_('Scripting is disabled. Do you want to enable it now?'),
        mtConfirmation, MB_YESNOCANCEL) of
        ID_YES: ScriptingEnable;
        ID_CANCEL: exit;
      end;
    CheckScriptEditorExt;
    ed := FScriptEditor;
    vb := FScriptFile;
    if Pos(' ',ed) <> 0 then ed := '"' + ed + '"';
    if Pos(' ',vb) <> 0 then vb := '"' + vb + '"';
    if FileExists(FScriptFile) then
      ShellExecute(Handle,'open',PChar(ed),PChar(vb), // do not localize
        PChar(ExtractFileDir(FScriptFile)),SW_SHOWNORMAL);
  end
  else
    SetExplorerNode(FNodeScripts);
end;

procedure TForm1.EnableKeyMonitor(TxDelay: boolean);
begin
  Log.AddCommunicationMessage('Enable Keypad Event Reporting',lsDebug); // do not localize debug
  try
    if TxDelay then ScheduleTxAndWait('AT+CMER=3,2') // do not localize
      else TxAndWait('AT+CMER=3,2'); // 2 = set keypad monitoring // do not localize
    FKeyMonitoring := True;
  except;
  end;
end;

procedure TForm1.MinimizeApp;
begin
  ActionWindowMinimize.Execute;
end;

procedure TForm1.ActionConnectionAbortExecute(Sender: TObject);
begin
  DoAbort;
end;

procedure TForm1.VoiceCall(number: String);
begin
  if FHaveVoiceDialCommand_Dial then
    TxAndWait('AT*EVD="' + number + '"') // do not localize
  else
  if IsK610Clone then
    TxAndWait('ATDT' + number) // do not localize
  else
    TxAndWait('ATDT' + number + ';'); // do not localize
end;

procedure TForm1.VoiceAnswer;
begin
  if FHaveVoiceDialCommand_Answer then
    TxAndWait('AT*EVA') // do not localize
  else
    TxAndWait('ATA'); // do not localize
end;

procedure TForm1.VoiceHangUp(SilentMode: boolean);
var
  IsLocked: boolean;
begin
  { TODO: Use SilentMode to cancel a call without Busy sound to the caller WITHOUT using keypress }
  if SilentMode and (IsT610Clone or IsK700Clone or IsK750Clone) then begin
    { First unlock keyboard if needed }
    if FUseKeylockMonitor then begin
      TxAndWait('AT+CLCK="CS",2'); // do not localize
      IsLocked := FKeybLocked;
      if IsLocked then
        ActionToolsKeybLock.Execute;
    end
    else
      IsLocked := false; // assume keypad is unlocked

    { Cancel call silently, i.e. Remove ringing }
    try
      TxAndWait('AT+CKPD="c"'); // do not localize
    except
    end;
    { Lock keyboard again if needed }
    if IsLocked then
      ActionToolsKeybLock.Execute;
  end
  else
    if FHaveVoiceDialCommand_Hangup then
      TxAndWait('AT*EVH') // do not localize
    else
      ScheduleTxAndWait('ATH'); // do not localize
  if Assigned(frmCalling) and frmCalling.IsCreated then begin
    if not SilentMode then
      frmCalling.IsCalling := False;
    frmCalling.IsTalking := False;
    frmCalling.CloseCall(True,False); // False = to avoid reccursion
  end;
end;

procedure TForm1.ActionToolsPostNoteExecute(Sender: TObject);
var
  sl: TStrings;
  stream: TStream;
  s: WideString;
begin
  AskRequestConnection;
  if FConnected and FUseObex then
    with frmNote do if ShowModal = mrOK then begin
      s := NoteText;
      //s := WideStringReplace(s,sLinebreak,' ',[rfReplaceAll]);
      if s <> '' then begin
        sl := TStringList.Create;
        try
          sl.Add('BEGIN:VNOTE'); // do not localize
          sl.Add('VERSION:1.1'); // do not localize
          if FUseUTF8 then
            sl.Add('BODY;CHARSET=UTF-8;ENCODING=QUOTED-PRINTABLE:' + Str2QP(WideStringToUTF8String(s))) // do not localize
          else
            sl.Add('BODY;ENCODING=QUOTED-PRINTABLE:' + Str2QP(s)); // do not localize
          sl.Add('CLASS:'+frmNote.NoteClass); // do not localize
          sl.Add('END:VNOTE'); // do not localize

          stream := TMemoryStream.Create;
          try
            sl.SaveToStream(stream);
            FObex.PutObject('fma.vnt', stream, true); // do not localize
          finally
            stream.Free;
            FlushOK;
          end;
        finally
          sl.Free;
        end;
      end
      else
        Status(_('Nothing to post'),False);
    end
  else
    Status(_('Not supported or OBEX disabled'),False);
end;

function TForm1.LoadScript: boolean;
var
  FmaFunc,ext: String;
begin
  Result := True;
  if FScriptFile <> '' then begin
    if FileExists(FScriptFile) then begin
      ext := ExtractFileExt(FScriptFile);
      try
        frmEditor.Script.Lines.LoadFromFile(FScriptFile);
        frmEditor.Filename := FScriptFile;
        ScriptControl.Code.BeginUpdate;
        try
          { load script from file }
          ScriptControl.Code.Clear;
          ScriptControl.Language := Copy(ext, 2, length(ext)-1);
          ScriptControl.Code.Assign(frmEditor.Script.Lines);
          { if Fma internal functions does not exist, append it to script now }
          FmaFunc := 'Sub '+__fma_objcall+'(command)'; // do not localize
          if ScriptControl.Code.IndexOf(FmaFunc) = -1 then begin
            Log.AddScriptMessage('Script: Adding FMA enhancements', lsDebug); // do not localize debug
            ScriptControl.Code.Add('');
            ScriptControl.Code.Add(''' FMA enhancements - DO NOT REMOVE/ALTER THIS FUNCTION!!!'); // do not localize
            ScriptControl.Code.Add(FmaFunc);
            ScriptControl.Code.Add('  Execute(command)'); // do not localize
            ScriptControl.Code.Add('End Sub'); // do not localize
          end;
          FmaFunc := 'Sub '+__fma_objcall+'Ex(command, arguments)'; // do not localize
          if ScriptControl.Code.IndexOf(FmaFunc) = -1 then begin
            Log.AddScriptMessage('Script: Adding FMA advanced enhancements', lsDebug); // do not localize debug
            ScriptControl.Code.Add('');
            ScriptControl.Code.Add(''' FMA enhancements - DO NOT REMOVE/ALTER THIS FUNCTION!!!'); // do not localize
            ScriptControl.Code.Add(FmaFunc);
            ScriptControl.Code.Add('  Dim args, param'); // do not localize
            ScriptControl.Code.Add('  If IsArray(arguments) And UBound(arguments) > -1 Then'); // do not localize
            ScriptControl.Code.Add('      '' Generate argument list'); // do not localize
            ScriptControl.Code.Add('      args = " "'); // do not localize
            ScriptControl.Code.Add('      For Each param In arguments'); // do not localize
            ScriptControl.Code.Add('              args = args & """" & param & """" & ", "'); // do not localize
            ScriptControl.Code.Add('      Next'); // do not localize
            ScriptControl.Code.Add('      '' Cut tailing ","'); // do not localize
            ScriptControl.Code.Add('      If Right(args, 2) = ", " Then args = Left(args, Len(args) -2)'); // do not localize
            ScriptControl.Code.Add('  Else'); // do not localize
            ScriptControl.Code.Add('      args = ""'); // do not localize
            ScriptControl.Code.Add('  End If'); // do not localize
            ScriptControl.Code.Add('  Execute(command & args)'); // do not localize
            ScriptControl.Code.Add('End Sub'); // do not localize
          end;
        finally
          ScriptControl.Code.EndUpdate;
        end;
        Log.AddScriptMessage('Script: Loaded OK', lsDebug); // do not localize debug
      except
        on e: Exception do begin
          Log.AddScriptMessage('Script: Load failed: '+e.Message, lsDebug); // do not localize debug
          Result := False;
        end;
      end;
    end
    else
      Log.AddScriptMessage('Script: File "'+FScriptFile+'" not found', lsDebug); // do not localize debug
  end;
end;

procedure TForm1.InitProfile;
var
  i: Integer;
  str: WideString;
  sl: TstringList;
  EData: PFmaExplorerNode;
begin
  try
    if frmInfoView.Visible then EBCAState(False);
    if not CoolTrayIcon1.CycleIcons then
      Status(_('Loading profiles...'));
    TxAndWait('AT*EAPN?'); // do not localize
    sl := TstringList.Create;
    sl.Text := ThreadSafe.RxBuffer.Text;
    try
      cbProfile.Items.Clear;
      ExplorerNew.DeleteChildren(FNodeProfiles);
      ExplorerNew.Update;
      for i := 0 to sl.Count - 2 do begin
        if pos('*EAPN', sl[i]) = 1 then begin // do not localize
          str := LongStringToWideString(Copy(sl[i], 8, length(sl[i])));
          str := GetToken(str, 1);
          if FUseUTF8 then str := UTF8StringToWideString(WideStringToLongString(str));
          cbProfile.Items.Add(str);
          EData := ExplorerNew.GetNodeData(ExplorerNew.AddChild(FNodeProfiles));
          EData.Text := str;
          EData.ImageIndex := 24;
        end;
      end;
    finally
      sl.Free;
      if frmExplore.Visible then frmExplore.RootNode := ExplorerNew.FocusedNode;
    end;
    TxAndWait('AT*EAPS?'); // do not localize
    str := Copy(ThreadSafe.RxBuffer.Strings[0], 8, length(ThreadSafe.RxBuffer.Strings[0]));
    cbProfile.ItemIndex := StrToInt(GetToken(str, 0)) - 1;
    if frmInfoView.Visible then EBCAState(True);
    ExplorerNew.Expanded[FNodeProfiles] := true;
    if not CoolTrayIcon1.CycleIcons then
      Status('');
  except
    Log.AddCommunicationMessage('Error getting Profiles', lsDebug); // do not localize debug
  end;
end;

procedure TForm1.cbProfileChange(Sender: TObject);
begin
  try
    TxAndWait('AT*EAPS=' + IntToStr(cbProfile.ItemIndex + 1)); // do not localize
    Status(_('Profile changed'));
    if not FStartupOptions.NoBaloons then
      ShowBaloonInfo(WideFormat(_('Profile "%s" activated.'), [cbProfile.Text]));
    if FAutoProfile then
      FormStorage1.StoredValue['AutoProfileName'] := cbProfile.Text; // do not localize
  except
    Status(_('Error switching profile'));
  end;
end;

procedure TForm1.ScriptEvent(const FunctionName: string;
  const Params: array of Variant);
begin
  if FUseScript and (Trim(FunctionName) <> '') then
    try
      if ScriptControl.Code.Count > 0 then
        CallScriptMethod(FunctionName, Params);
    except
      on E: Exception do
        if not FScriptErrorOccur then
          Log.AddScriptMessage('Error: ' + FunctionName + ' exits with error: '+E.Message, lsDebug); // do not localize debug
    end;
end;

procedure TForm1.ExplorerNewDblClick(Sender: TObject);
var
  Data: PFmaExplorerNode;
begin
  Data := ExplorerNew.GetNodeData(ExplorerNew.FocusedNode);
  if (Data <> nil) and (Data.ImageIndex >= 9) and (Data.ImageIndex <= 13) then
    ActionContactsNewMsg.Execute;
end;

procedure TForm1.StatusBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  if Panel = StatusBar.Panels[2] then begin
    pbPower.Top := rect.Top + 1;
    pbPower.Left := rect.Left + 1;
    pbPower.Width := rect.Right - rect.Left - 3;
    pbPower.Height := rect.Bottom - rect.Top - 2;

    if Panel.Text <> '' then begin
      pbPower.Caption := Panel.Text;
      pbPower.Visible := True;
    end
    else pbPower.Visible := False;
  end
  else if Panel = StatusBar.Panels[3] then begin
    pbRSSI.Top := rect.Top + 1;
    pbRSSI.Left := rect.Left + 1;
    pbRSSI.Width := rect.Right - rect.Left - 3;
    pbRSSI.Height := rect.Bottom - rect.Top - 2;

    if Panel.Text <> '' then begin
      pbRSSI.Caption := Panel.Text;
      pbRSSI.Visible := True;
    end
    else pbRSSI.Visible := False;
  end
  else if Panel = StatusBar.Panels[5] then begin
    pbTask.Top := rect.Top + 1;
    pbTask.Left := rect.Left + 1;
    pbTask.Width := rect.Right - rect.Left - 3;
    pbTask.Height := rect.Bottom - rect.Top - 2;

    pbTask.Visible := StatusBar.Panels[5].Bevel <> pbNone;
  end
end;

procedure TForm1.LMDFMDropFMDragDrop(Sender: TObject; fcount, x,
  y: Integer; FileList: TStrings);
var
  i: Integer;
begin
  if FConnected and FConnectingComplete then begin
    for i := 0 to FileList.Count - 1 do
      ObexPutFile(FileList.Strings[i]);
  end
  else
    Beep;
end;

procedure TForm1.WBtSocketDataAvailable(Sender: TObject; Error: Word);
begin
  if Error <> 0 then begin
    Status(WideFormat(_('Connection Error (0x%s)'),[IntToHex(Error,8)]));
    FConnectionError := True;
  end
  else
    ComPortRxChar(nil,0);
end;

procedure TForm1.DoConnect;
const
  SecondAutoConn: boolean = False;
var
  ErrMsg: WideString;
  procedure ShowConnectVia(What: WideString);
  var
    s: String;
  begin
    if not IsAutoConnect then begin
      Log.AddCommunicationMessage('Establishing new connection via '+What+'.',lsDebug); // do not localize debug
      Log.AddCommunicationMessage('Accessing device (may take a while)...',lsDebug); // do not localize debug
    end;
    if IsAutoConnect and not SecondAutoConn then begin
      if FSelPhone <> '' then s := FSelPhone else s := PhoneIdentity;
      Log.AddMessage(WideFormat(_('Auto-connect: Watching for %s phone...'),[s]));
    end;
    if SecondAutoConn then CoolTrayIcon1.HideBalloonHint;
    SecondAutoConn := IsAutoConnect;
  end;
begin
  SetPanelText(0,_('Searching'));
  try
    if ThreadSafe.ConnectionType = 0 then begin // Bluetooth
      ShowConnectVia(_('Bluetooth'));
      WBtSocket.Addr := FBTAddress;
      WBtSocket.Port := FBtPort;

      WBtSocket.Connect;
      while WBtSocket.State = wsConnecting do WaitASec(200);
    end
    else if ThreadSafe.ConnectionType = 1 then begin // IR
      ShowConnectVia(_('IRDA'));
      with WIrSocket.GetConnectedDevices do
      try
        if Count > 0 then begin
          WIrSocket.DeviceID := Items[0].irdaDeviceID;

          WIrSocket.Connect;
          while WIrSocket.State = wsConnecting do WaitASec(200);
        end
        else FConnectionError := True;
      finally
        Free;
      end;
    end
    else begin // Serial
      ShowConnectVia(_('Serial'));
      ComPort.Open;
      // Give the chance to run the com thread.
      // The main event loop in TComThread.Execute have to be started (see the CPort.pas)
      WaitASec(200);
    end;
  except
    on e: Exception do begin
      SetPanelText(0,_('Disconnected'));
      FConnectionError := True;
      if IsAutoConnect then begin
        if ThreadSafe.AbortDetected then begin
          { Cancel auto-connect feature }
          ActionConnectionMonitor.Tag := 0;
        end;
        DoDisconnect;
      end
      else begin
        FAutoConnectionError := False;
        DoDisconnect;
        if not Application.Terminated then
          if ThreadSafe.AbortDetected then
            ShowBaloonError(_('Connection aborted by user!'),10)
          else begin
            { Connection error, check for some specifi error codes and show user friendly error message }
            if Pos('10043',e.Message) <> 0 then
              ErrMsg := _('Protocol is not supported!')
            else
            if Pos('10047',e.Message) <> 0 then
              ErrMsg := _('Your device is not supported by current Windows drivers. Install or update your drivers and try again!')
            else
            if Pos('10048',e.Message) <> 0 then
              ErrMsg := _('Address is already in use!')
            else
            if Pos('10050',e.Message) <> 0 then
              ErrMsg := _('Target network is down. If not using MS drivers, try to set up a Virtual COM port connection instead!')
            else
            if Pos('10051',e.Message) <> 0 then
              ErrMsg := _('Network is unreachable!')
            else
            if Pos('10053',e.Message) <> 0 then
              ErrMsg := _('Connection aborted!')
            else
            if Pos('10060',e.Message) <> 0 then
              ErrMsg := _('Connection timed out!')
            else
            if Pos('10061',e.Message) <> 0 then
              ErrMsg := _('Connection refused!')
            else
            if Pos('10064',e.Message) <> 0 then
              ErrMsg := _('Target host is down!')
            else
            if Pos('10092',e.Message) <> 0 then
              ErrMsg := _('Windows Socket version is not supported!')
            else
              { Unknown error code, use common error message }
              ErrMsg := _('Connection failed!');
            ShowBaloonError(ErrMsg,10);
          end;
      end;
    end;
  end;
end;

procedure TForm1.DoDisconnect;
begin
  { Wait for last command to finish, if needed }
  if not ThreadSafe.AbortDetected and not ThreadSafe.Timedout then
    while ThreadSafe.Busy do Application.ProcessMessages;
  { Save phone database }
  SavePhoneDataFiles(True);

  { Proximity detection... }
  if not FExiting and ThreadSafe.Timedout and not FAutoConnectionError then
    DoProximityAway;
  if FExiting or not ThreadSafe.Timedout then
    DoProximityNear; // restore proximity status on FMA exit or manual disconnect

  { Do disconnect now... }
  if ThreadSafe.ConnectionType = 0 then // Bluetooth
    WBtSocket.Close
  else
  if ThreadSafe.ConnectionType = 1 then // IR
    WIrSocket.Close
  else // Serial
    ComPort.Close;
end;


procedure TForm1.WBtSocketChangeState(Sender: TObject; OldState, NewState: TSocketState);
const
  aSocketState: array[TSocketState] of string = ('Invalid', 'Opened', 'Bound', 'Connecting', 'Socketed', 'Connected',
    'Accepting', 'Listening', 'Closed'); // do not localize
begin
  Log.AddCommunicationMessage('Socket State Changed: ' + aSocketState[NewState], lsDebug); // do not localize debug
end;

procedure TForm1.ClearBuffer;
begin
  if ThreadSafe.ConnectionType = 0 then begin // Bluetooth
    WBtSocket.DeleteBufferedData;
  end
  else if ThreadSafe.ConnectionType = 1 then begin // Infrared
    WIrSocket.DeleteBufferedData;
  end
  else begin // Serial
    ComPort.ClearBuffer(True, True);
  end;
end;

procedure TForm1.EBCAState(Enable,KeyMonToo: Boolean);
var
  State: boolean;
begin
  try
    State := Enable and CanUseEBCA;
    if FConnected and FConnectingComplete and not FSendingMessage and
      not FObex.Connected and not ThreadSafe.ObexConnecting then begin
      if byte(State) <> EBCALastState then begin
        if State then begin
          { Do not enable EBCA while App is minimized, it will be re-enabled once
            the application is Restored. meanwhile keep it off. }
          if FormStorage1.StoredValue['StartMinimized'] = False then // do not localize
            TxAndWait('AT*EBCA=1'); // do not localize
          if KeyMonToo and FKeyMonitoring then begin
            TxAndWait('AT+CMER=3,2'); // do not localize
            FEBCAKeyMonStopped := False;
          end;
        end
        else begin
          TxAndWait('AT*EBCA=0'); // do not localize
          if KeyMonToo and FKeyMonitoring then begin
            TxAndWait('AT+CMER=0,0'); // do not localize
            FEBCAKeyMonStopped := True;
          end;
        end;
        EBCALastState := byte(State);
      end;
    end
    else
      if not FConnected then EBCALastState := -1;
  except;
  end;
end;

procedure TForm1.ActionToolsEditProfileExecute(Sender: TObject);
begin
  if frmInfoView.Visible then EBCAState(False);
  with TfrmEditProfile.Create(nil) do
    try
      ShowModal;
    finally
      Free;
    end;
  if frmInfoView.Visible then EBCAState(True);
end;

procedure TForm1.SetFrameVisible(name: String; visible: Boolean = True);
//var i,num,size: integer;
  function GetFrameByName(Name: string): TTntFrame;
  begin
    Result := nil;
    Name := Trim(UpperCase(Name));
    if Name = 'EXPLORE' then Result := frmExplore; // do not localize
    if Name = 'SM' then Result := frmSMEdit; // do not localize
    if Name = 'ME' then Result := frmMEEdit; // do not localize
    if Name = 'MSG' then Result := frmMsgView; // do not localize
    if Name = 'INFO' then Result := frmInfoView; // do not localize
    if Name = 'PHONE' then Result := frmSyncPhonebook; // do not localize
    if Name = 'CALENDAR' then Result := frmCalendarView; // do not localize
    if Name = 'SCRIPT' then Result := frmEditor; // do not localize
    if Name = 'BOOKMARK' then Result := frmSyncBookmarks; // do not localize
  end;
  procedure SetFramePrefs(Name: string; Save: boolean = False); // save or restore
  var
    i: integer;
    var Frame: TTntFrame;
  begin
    Frame := GetFrameByName(Name);
    if Frame = nil then exit;
    for i := 0 to Frame.ComponentCount-1 do begin
      if Frame.Components[i] is TFormStorage then begin
        with Frame.Components[i] as TFormStorage do
          if Save then SaveFormPlacement
            else RestoreFormPlacement;
      end;
{$IFDEF VER150}
      if not Save and (Frame.Components[i] is TVirtualStringTree) then begin
        with (Frame.Components[i] as TVirtualStringTree) do
          Header.Font.Assign(Font); // hack! Update Header font according to default theme font
      end;
      if not Save and (Frame.Components[i] is TTntPanel) then begin
        if AnsiCompareText(Frame.Components[i].Name,'NoItemsPanel') = 0 then // hack! TFrame doesnt have OnCreate event
          (Frame.Components[i] as TTntPanel).ParentBackground := False;
      end;
{$ENDIF}
    end;
    { Cancel Messages View long rendering operation }
    if Save and (Frame = frmMsgView) then begin
      frmMsgView.RenderCanceled := True;
      frmMsgView.ListMsg.Clear;
    end;
  end;
begin
  { Save old frame settings }
  if FLastShownFrame <> name then begin
    SetFramePrefs(FLastShownFrame,True);
    if name <> '' then SetFrameVisible('');
  end;

  if FExiting then begin
    visible := False;
    if name <> '' then exit;
  end;

  if name = 'INFO' then // do not localize
    FramePanel.BevelOuter := bvLowered
  else
    FramePanel.BevelOuter := bvNone;
  { Set new frame }
  if name = 'EXPLORE' then begin // do not localize
    frmExplore.rootNode := ExplorerNew.FocusedNode;
    frmExplore.visible := visible;
    {
    if (Explorer.Selected <> nil) and (Explorer.Selected.Parent = FNodeObex) then begin
      num := Explorer.Selected.Count;
      size := 0;
      for i := 0 to num-1 do begin
        size := size + Explorer.Selected.Item[i].StateIndex;
      end;
      Status(WideFormat(_('View %d files(s) in total of %.2n Kb (%.0n bytes)'),[num,size / 1024,size * 1.0]));
    end;
    }
  end
  else if name = 'SM' then begin // do not localize
    frmSMEdit.visible := visible;
  end
  else if name = 'ME' then begin // do not localize
    frmMEEdit.visible := visible;
  end
  else if name = 'MSG' then begin // do not localize
    UpdateMessagePreview;
    frmMsgView.Visible := visible;
  end
  else if name = 'INFO' then begin // do not localize
    frmInfoView.Visible := visible;
    frmInfoView.UpdateWelcomePage(True);
  end
  else if name = 'PHONE' then begin // do not localize
    frmSyncPhonebook.Visible := visible;
  end
  else if name = 'CALENDAR' then begin // do not localize
    frmCalendarView.Visible := visible;
    //frmCalendarView.Initialize;
  end
  else if name = 'SCRIPT' then begin // do not localize
    frmEditor.Visible := visible;
    if visible then frmEditor.Initialize;
  end
  else if name = 'BOOKMARK' then begin // do not localize
    frmSyncBookmarks.Visible := visible;
  end
  else begin
    { Hide all }
    frmExplore.visible := False;
    frmSMEdit.visible := False;
    frmMEEdit.visible := False;
    frmMsgView.Visible := False;
    frmInfoView.Visible := False;
    frmSyncPhonebook.Visible := False;
    frmSyncBookmarks.Visible := False;
    frmCalendarView.Visible := False;
    frmEditor.Visible := False;
  end;
  { Load frame settings, if any }
  if FLastShownFrame <> name then begin
    FLastShownFrame := name;
    SetFramePrefs(name);
  end;
end;

procedure TForm1.ObexConnect(Target: widestring);
begin
  RequestConnection;
  if not FObex.Connected then
    FObex.Connect(Target);
end;

function TForm1.ObexGetObject(Path: Widestring; var stream: TStream; progress: boolean): cardinal;
var
  str: TMemoryStream;
begin
  str := TMemoryStream.Create;
  try
    stream.Size := 0;
    Result := FObex.GetObject(Path,str);
    stream.CopyFrom(str,str.Size);
  finally
    str.Free;
  end;
end;

function TForm1.ObexPutObject(Path: Widestring; Stream: TStream; progress: boolean): WideString;
begin
  Result := FObex.PutObject(Path, stream, progress);
end;

procedure TForm1.ObexDisconnect;
begin
  if FObex.Connected then
  try
    FObex.Disconnect;
  finally
    FlushOK;
  end;
end;

procedure TForm1.ActionSMSExportExecute(Sender: TObject);
var
   Extension: WideString;
begin
  SaveDialog1.Filter := _('CSV files (*.csv)|*.csv|XML files (*.xml)|*.xml|Html files (*.html)|*.html');
  if SaveDialog1.Execute then begin
     case SaveDialog1.FilterIndex of
        // sync order with ExportList!
        1: Extension := '.csv'; // do not localize
        2: Extension := '.xml'; // do not localize
        3: Extension := '.html'; // do not localize
     end;
     if WideExtractFileExt(SaveDialog1.FileName) = Extension then
        frmMsgView.ExportList(SaveDialog1.FilterIndex, SaveDialog1.FileName)
     else
        frmMsgView.ExportList(SaveDialog1.FilterIndex, SaveDialog1.FileName + Extension);
  end;
end;

procedure TForm1.ActionSyncPhonebookExecute(Sender: TObject);
begin
  AskRequestConnection;
  if frmInfoView.Visible then EBCAState(False);
  frmInfoView.linkSyncPhonebook.Enabled := False;
  try
    if IsIrmcSyncEnabled then
      frmSyncPhonebook.btnSYNCClick(nil)
    else
      RefreshPhoneBook;
  finally
    frmInfoView.linkSyncPhonebook.Enabled := True;
    if frmInfoView.Visible then EBCAState(True);
  end;
end;

function TForm1.WriteSMS(memLocation, PDU: String; Stat: Integer): boolean;
var
  GW: string;
  sms: TSMS;
begin
  AskRequestConnection;
  Result := False;
  try
    if frmInfoView.Visible then EBCAState(False);
    FSendingMessage := True;
    try
      sms := TSMS.Create;
      try
        sms.PDU := pdu;
        { AT+CMGW      Write Message To Memory (ver. 2)
          Description: Execution command stores a message to memory storage <mem2>.
          Memory location <index> of the stored message is returned. By default
          message status will be set to 'stored unsent', but parameter <stat> allows
          also other status values to be given. (ME/TA manufacturer may choose to
          use different default <stat> values for different message types.) The
          entering of PDU is done similarly as specified in command AT+CMGS. }
        GW := 'AT+CMGW=' + IntToStr(sms.TPLength); // do not localize
      finally
        sms.Free;
      end;
      { Stat = -1 means default to "received unread" }
      if Stat <> -1 then GW := GW + ',' + IntToStr(Stat);
      TxAndWait('AT+CPMS="' + memLocation + '","' + memLocation + '"'); // do not localize
      //FSendingMessage := True;
      try
        TxAndWait(GW, '> ');
      except
        //FSendingMessage := False;
        raise;
      end;
      if ThreadSafe.AbortDetected then begin
        { Cancel sending }
        try
          TxAndWait(#$1B); // Sending can be cancelled by giving <ESC> character (IRA 27).
        finally
          //FSendingMessage := False;
        end;
        Abort;
      end;
      try
        TxAndWait(PDU + #$1A);
      finally
        //FSendingMessage := False;
      end;
      Log.AddCommunicationMessage('Message sent to ' + memLocation,lsDebug); // do not localize debug
      Result := True;
    except
      Log.AddCommunicationMessage('Message send to ' + memLocation + ' failed!', lsDebug); // do not localize debug
    end;
  finally
    FSendingMessage := False;
    if frmInfoView.Visible then EBCAState(True);
  end;
end;

procedure TForm1.ActionMissedCallsExecute(Sender: TObject);
begin
  frmMissedCalls.Hide;
  frmMissedCalls.Show;
end;

procedure TForm1.ActionToolsKeyPadExecute(Sender: TObject);
begin
  frmKeyPad.Show;
end;

procedure TForm1.RefreshPhoneBook;
var
  sl: TStrings;
  ATMode: boolean;
  buffer: String;
  EData: PFmaExplorerNode;
begin
  AskRequestConnection;
  EData := ExplorerNew.GetNodeData(FNodeContactsME);
  sl := EData.data;
  if not IsIrmcSyncEnabled then begin
    { Obex is not supported, or SyncIRMC is disabled, so use standard AT commands }
    ATMode := True;
    frmMEEdit.CheckForChanges;
    TxAndWait('AT+CPBS="ME"'); // do not localize
    DownloadPhonebook(buffer);
    ParsePhonebookList(buffer,sl);
  end
  else begin
    ATMode := False;
    { Zdravko: do to read phonebook from the phone, but use sync data to generate it - it's faster }
    ParsePhonebookListFromSync(sl);
  end;
  RenderContactList(FNodeContactsME);
  if ATMode then frmMEEdit.RenderData;
  { clear contact lookup cache }
  FLookupList.Clear;
end;

procedure TForm1.ActionExitExecute(Sender: TObject);
begin
  FExit := True;
  FExiting := True;
  Close;
end;

procedure TForm1.ActionContactsExportMEExecute(Sender: TObject);
var
   Extension: WideString;
begin
  SaveDialog2.Filter := _('vCard files (*.vcf)|*.vcf|Thunderbird LDIF files (*.ldi,*.ldif)|*.ldi;*.ldif|CSV files (*.csv)|*.csv|XML files (*.xml)|*.xml|Html files (*.html)|*.html|Opera contacts (*.adr)|*.adr');
  if SaveDialog2.Execute then begin
     case SaveDialog2.FilterIndex of
        // sync order with TfrmSyncPhonebook.ExportList
        1: Extension := '.vcf';  // do not localize
        2: Extension := '.ldif'; // do not localize
        3: Extension := '.csv';  // do not localize
        4: Extension := '.xml';  // do not localize
        5: Extension := '.html'; // do not localize
        6: Extension := '.adr';  // do not localize
     end;
     if WideExtractFileExt(SaveDialog2.FileName) = Extension then
         frmSyncPhonebook.ExportList(SaveDialog2.FilterIndex, SaveDialog2.FileName)
     else
         frmSyncPhonebook.ExportList(SaveDialog2.FilterIndex, SaveDialog2.FileName + Extension);
  end;
end;

procedure TForm1.ActionContactsExportSMExecute(Sender: TObject);
var
   Extension: WideString;
begin
  SaveDialog2.Filter := _('vCard files (*.vcf)|*.vcf|XML files (*.xml)|*.xml|');
  if SaveDialog2.Execute then begin
     case SaveDialog2.FilterIndex of
        // sync order with TfrmSIMEdit.ExportList
        1: Extension := '.vcf'; // do not localize
        2: Extension := '.xml'; // do not localize
     end;
     if WideExtractFileExt(SaveDialog2.FileName) <> Extension then begin
       SaveDialog2.FileName := SaveDialog2.FileName + Extension;
       if frmSMEdit.Visible then
         frmSMEdit.ExportList(SaveDialog2.FilterIndex, SaveDialog2.FileName);
       if frmMEEdit.Visible then
         frmMEEdit.ExportList(SaveDialog2.FilterIndex, SaveDialog2.FileName);
     end;
  end;
end;

procedure TForm1.HandleCCLK(AMsg: String);
var
  Year,Hour,Zone,LYear,LHour,LZone: string;
  TimeZone: TTimeZoneInformation;
  i,dif: integer;
  function SecondsDif: integer;
  var
    hpc,hhs,mpc,mhs,spc,shs: integer;
  begin
    hpc := StrToInt(Copy(LHour,1,2)) * 3600;
    hhs := StrToInt(Copy(Hour,1,2)) * 3600;
    mpc := StrToInt(Copy(LHour,4,2)) * 60 + hpc;
    mhs := StrToInt(Copy(Hour,4,2)) * 60 + hhs;
    spc := StrToInt(Copy(LHour,7,2)) + mpc;
    shs := StrToInt(Copy(Hour,7,2)) + mhs;
    Result := Abs(spc-shs);
  end;
begin
  // +CCLK: "03/12/10,17:18:11+32"
  // +CCLK: "03/10/27,11:16:30+08"
  Log.AddCommunicationMessage('CLOCK: Checking Sync Status...', lsDebug); // do not localize debug
  Delete(AMsg,1,7);
  i := Pos(',',AMsg);
  Year := Copy(AMsg,1,i-1);
  Delete(AMsg,1,i);
  Delete(Year,1,1); // remove the "
  if Year[3] = '/' then LYear := 'yy"/"mm"/"dd' else LYear := 'yyyy"/"mm"/"dd';
  LYear := FormatDateTime(Lyear,Date);
  i := Pos('+',AMsg);
  if i = 0 then i := Pos('-',AMsg);
  if i = 0 then i := Length(AMsg); // Zone doesn't specified
  Hour := Copy(AMsg,1,i-1);
  LHour := FormatDateTime('hh":"nn":"ss',Time);
  Delete(AMsg,1,i-1);
  Zone := AMsg;
  Delete(Zone,Length(Zone),1); // remove the "
  if GetTimeZoneInformation(TimeZone) > TIME_ZONE_ID_UNKNOWN then begin
    LZone := Format('%.2d',[TimeZone.Bias div 15]);
    if LZone[1] = '-' then LZone[1] := '+'
      else if LZone <> '00' then LZone := '-'+LZone
           else LZone := '+'+LZone;
    if Zone = '' then LZone := ''; // is this correct ?
  end
  else
    LZone := Zone;
  Log.AddCommunicationMessage('CLOCK: '+Year+','+Hour+Zone+' on Phone', lsDebug); // do not localize debug
  Log.AddCommunicationMessage('CLOCK: '+LYear+','+LHour+LZone+' on PC', lsDebug); // do not localize debug
  dif := SecondsDif;
  FLastClockTZ := Zone;
  FDoSyncClock := (LYear+LZone <> Year+Zone) or (Copy(Hour,1,5) <> Copy(LHour,1,5)) or (dif > 3);
  if FDoSyncClock then
    Log.AddMessage('CLOCK: Difference more than 3 seconds!', lsDebug) // do not localize debug
  else
    Log.AddMessage('CLOCK: Synchronized with PC, no update needed!', lsDebug); // do not localize debug
end;

procedure TForm1.HandleCPIN(AMsg: String);
begin
  Delete(AMsg,1,7);
  FEmergencyMode := Pos(AMsg,'READY') = 0; // do not localize
  if Pos(AMsg,'BLOCKED') <> 0 then // do not localize
    Log.AddMessage(_('The SIM card is blocked for that user!'), lsError); 
end;

procedure TForm1.HandleCNMI(AMsg: String);
var
  sl: TStringList;
begin
  // +CNMI: (2),(0,1,3),(0,2),(0),(0)
  Delete(AMsg,1,7);
  AMsg := StringReplace(Amsg,'),(',');(',[rfReplaceAll]);
  sl := TStringList.Create;
  try
    sl.Delimiter := ';';
    sl.DelimitedText := AMsg;
    FUseCNMIMode3 := Pos('3',sl[0]) <> 0;
    FStatusReport := Pos('1',sl[3]) <> 0; // check the specs for proper value here!
  finally
    sl.Free;
  end;
end;

procedure TForm1.HandleCSCS(AMsg: String);
begin
  Delete(AMsg,1,7);
  FSupportedCS := AMsg;
end;

procedure TForm1.HandleCLCK(AMsg: String);
begin
  Delete(AMsg,1,7);
  FKeybLocked := AMsg = '1';
  ActionToolsKeybLock.Enabled := FUseKeylockMonitor;
end;

procedure TForm1.ParsePhonebookListFromSync(var sl: TStrings);
var
  Node :PVirtualNode;
  contact: PContactData;
  Name: WideString;
  procedure DoAdd(TelType,Tel: WideString; position: integer);
  var utf8s: string;
  begin
    { WARNING!! contact.StateIndex meaning should match SIM.imageindex one (new,mod,del) }
    { SEE ParsePhonebookListFromEditor !!! Implementations should match }
    utf8s := UTF8Encode(WideQuoteStr(Name + TelType,True));
    sl.Add(utf8s + ',' + WideStringToLongString(Tel) + ',' +
      IntToStr(position) + ',' + IntToStr(contact.StateIndex) + ',' +
      GUIDToString(contact^.CDID) + ',"' + WideStringToLongString(contact^.LUID) + '"');
  end;
begin
  sl.Clear;
  Node := frmSyncPhonebook.ListContacts.GetFirst;
  if Node <> nil then
    repeat
      contact := frmSyncPhonebook.ListContacts.GetNodeData(Node);
      Name := contact.name;
      if contact.surname <> '' then Name := Name + ' ' + contact.surname;
      if contact.home  <> '' then DoAdd('/H',contact.home,contact.Position.home); // do not localize
      if contact.work  <> '' then DoAdd('/W',contact.work,contact.Position.work); // do not localize
      if contact.cell  <> '' then DoAdd('/M',contact.cell,contact.Position.cell); // do not localize
      if contact.fax   <> '' then DoAdd('/F',contact.fax,contact.Position.fax); // do not localize
      if contact.other <> '' then DoAdd('/O',contact.other,contact.Position.other); // do not localize
      if GetContactDefPhone(contact) = '' then
        DoAdd('','',0); // add contact without numbers
      Application.ProcessMessages;
      Node := frmSyncPhonebook.ListContacts.GetNext(Node);
    until Node = nil;
  TStringList(sl).Sort;
end;

procedure TForm1.ActionToolsPostBookmarkExecute(Sender: TObject);
begin
  frmSyncBookmarks.btnNEWClick(nil);
end;

procedure TForm1.ActionObexReadyUpdate(Sender: TObject);
begin
  with (Sender as TTntAction) do begin
    Enabled := not ThreadSafe.Busy and not FStartupOptions.NoObex and FUseObex and FConnected;
  end;
end;

procedure TForm1.ActionToolsDownloadUpdate(Sender: TObject);
var
  EData: PFmaExplorerNode;
begin
  EData := ExplorerNew.GetNodeData(ExplorerNew.FocusedNode);
  ActionToolsDownload.Enabled := FConnected and not ThreadSafe.Busy and not FStartupOptions.NoObex and FUseObex and
    ((EData <> nil) and (EData.ImageIndex in [27,36..38])) or // only for obex folder items
    (frmExplore.Visible and (frmExplore.ListItems.SelectedCount <> 0) and (getExplorerSelectedNodeLevel1 = FNodeObex) ) ;
end;

procedure TForm1.ActionToolsUploadExecute(Sender: TObject);
var
  i: integer;
  dlg: TfrmConnect;
begin
  AskRequestConnection;
  if FConnected and FUseObex then
    if ObexOpenDialog.Execute then begin
      ObexConnect;
      try
        dlg := GetProgressDialog;
        if CanShowProgress then
          dlg.ShowProgress(FProgressLongOnly);
        try
          for i := 0 to ObexOpenDialog.Files.Count-1 do begin
            try
              ObexPutFile(ObexOpenDialog.Files[i]);
            except
              on e: exception do
                if FObex.IsAborted then raise
                else Status(e.Message);
            end;
          end;
        finally
          FreeProgressDialog;
        end;
      finally
        ObexDisconnect;
      end;
    end
    else
      Abort // stop processing if Open dialog is canceled
  else
    Status(_('Not supported or OBEX disabled'),False);
end;

procedure TForm1.ActionToolsEditProfileUpdate(Sender: TObject);
begin
  ActionToolsEditProfile.Enabled := not ThreadSafe.Busy and FConnected and (cbProfile.Items.Count <> 0);
  cbProfile.Enabled := ActionToolsEditProfile.Enabled;
end;

procedure TForm1.ActionConnectionConnectUpdate(Sender: TObject);
begin
  ActionConnectionConnect.Enabled := not FConnected;
end;

procedure TForm1.ActionConnectionDisconnectUpdate(Sender: TObject);
begin
  (Sender as TTntAction).Enabled := FConnected;
end;

procedure TForm1.ActionConnectionToggleUpdate(Sender: TObject);
begin
  ActionConnectionToggle.Checked := FConnected;
  ActionConnectionToggle.ImageIndex := 28 + byte(not FConnected);
  ActionConnectionToggle.Enabled := not FConnectingStarted or FConnectingComplete;
end;

function TForm1.ObexGetObject(Path: Widestring; var Where: TStringList; progress: boolean;
  FriendlyName: string): cardinal;
var
  str: TMemoryStream;
begin
  str := TMemoryStream.Create;
  try
    Where.Clear;
    Result := FObex.GetObject(Path,str,progress,FriendlyName);
    Where.LoadFromStream(str);
  finally
    str.Free;
  end;
end;

procedure TForm1.StartupInitialize;
var
  dlg: TTntForm;
  procedure ShowStatus(Msg: WideString);
  begin
    if Assigned(dlg) then begin
      if FShowSplash then
        (dlg as TfrmSplash).Status(Msg)
      else
        (dlg as TfrmStatusDlg).Status(Msg);
    end;
  end;
  procedure IncProgress;
  begin
    if Assigned(dlg) then begin
      if FShowSplash then
        with (dlg as TfrmSplash) do
          SEProgress1.Position := SEProgress1.Position + 1;
    end;
  end;
begin
  { Are we the first instance? }
  if IsStartCanceled or FAppInitialized then exit;
  
  { Load stored values }
  FormStorage1.RestoreFormPlacement;
  { Are we going to be Minimized? }
  if Application.ShowMainForm then begin
    { No, so show loading dialog }
    if FShowSplash then begin
      { ShowSplashDlg will create an instance object, and HideDelayed
        below will free it automaticaly. }
      frmSplash := ShowSplashDlg(_('Initializing...'));
      frmSplash.SEProgress1.Max := 4 + 13;
      // Above: 4 = The count of IncProgress() calls bellow; 13 = The steps count from LoadPhoneDataFiles()
      dlg := frmSplash;
    end
    else
      dlg := ShowStatusDlg(_('Initializing...'));
    { Hide from Taskbar while loading }
    ShowWindow(Application.Handle,SW_HIDE);
    Application.ProcessMessages;
  end
  else
    dlg := nil;
  try
    { Initialize }
    Log.AddMessage(_('Starting...'));
    ComPortAfterClose(ComPort);

    if FindCmdLineSwitch('DEBUG') then begin // do not localize
      DebugTools1.Visible := True;
      Log.AddMessage(_('Debug mode enabled (AT commands).'));
    end;
    if FindCmdLineSwitch('DEBUGOBEX') then begin // do not localize
      DebugTools1.Visible := True;
      FObex.debugobex := True;
      Log.AddMessage(_('Debug mode enabled (OBEX hex).'));
    end;

    { Create explorer tree }
    InitExplorerTree; // Locates all nodes, and creates database storage
    SetExplorerNode(ExplorerNew.GetFirst);
    ExplorerNew.Expanded[ExplorerNew.GetFirst] := True;
    ExplorerNew.Expanded[FNodeMsgRoot] := True;
    ExplorerNew.Expanded[FNodeContactsRoot] := True;
    ExplorerNew.Expanded[FNodeCalls] := True;
    ExplorerNew.Expanded[FNodeOrganizer] := True;

    { Create phone files support object }
    fFiles := TFiles.Create(nil, FNodeObex);
    SetFrameVisible(''); // hide all frames
    IncProgress;

    { Load database files }
    ShowStatus(_('Loading Profile Database...'));
    try
      if not LoadPhoneDataFiles('',False) then
        Log.AddMessage(_('ERROR: Could not initialize phone database (load failed)'), lsError);
    except
      PhoneIdentity := '';
    end;
    // LoadPhoneDataFiles will call IncProgress

    ShowStatus(_('Building Contact Lists...'));
    RenderContactLists;
    IncProgress;

    { Set startup folder, if specified, load welcome tips, etc }
    ViewInitialize;
    IncProgress;

    { Load script, if any }
    ShowStatus(_('Initializing Script Engine...'));
    ScriptInitialize;
    IncProgress;
  finally
    { Restore application in Taskbar }
    if Application.ShowMainForm then
      ShowWindow(Application.Handle,SW_SHOW);
    { Close splash }
    if Assigned(dlg) then begin
      if FShowSplash then
        with dlg as TfrmSplash do begin
          Status(_('Ready'));
          { Hide splash form in few seconds }
          HideDelayed(2);
        end
        else
          dlg.Free;
    end;
    CoolTrayIcon1.IconVisible := True;
    Timer1.Enabled := True;
    Log.AddMessage(WideFormat(_('Welcome to %s!'),[Caption]));
    { All done }
    FAppInitialized := True;
  end;
end;

procedure TForm1.ActionMissedCallsUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := (frmMissedCalls <> nil) and (frmMissedCalls.RecentMissedCalls <> 0);
  if ActionMissedCalls.Enabled and not b then begin
    ActionMissedCalls.ImageIndex := 16;
    MissedCallsTrayIcon.IconVisible := False;
  end;
  ActionMissedCalls.Enabled := b;
end;

procedure TForm1.FloatingRectangles(Minimizing, OverrideUserSettings: Boolean);
{
var
  RectFrom, RectTo: TRect;
  GotRectTo: Boolean;
  abd: TAppBarData;
  HTaskbar, HTrayWnd: HWND;
  ResetRegistry: Boolean;
  ai: TAnimationInfo;

  procedure SetAnimation(Animation: Boolean);
  begin
    FillChar(ai, SizeOf(ai), 0);
    ai.cbSize := SizeOf(ai);
    if Animation then
      ai.iMinAnimate := $C0
    else
      ai.iMinAnimate := 0;
    SystemParametersInfo(SPI_SETANIMATION, SizeOf(ai), @ai, SPIF_SENDCHANGE);
  end;
}
begin
  // temporary disabled, because it results double animation:
  // one to taskbar and one to tray area, not so good :(

  { TODO: Disable Windows animation for this window, and then use FloatingRectangles }

  (*
  // Check if user wants window animation
  FillChar(ai, SizeOf(ai), 0);
  ai.cbSize := SizeOf(ai);
  if not SystemParametersInfo(SPI_GETANIMATION, SizeOf(ai), @ai, 0) then
    exit;
  ResetRegistry := False;
  if OverrideUserSettings then begin
    if ai.iMinAnimate = 0 then begin
      // Temporarily enable window animation
      ResetRegistry := True;
      SetAnimation(True);
    end;
  end
  else
    if ai.iMinAnimate = 0 then exit;

  RectFrom := BoundsRect;
  GotRectTo := False;

  // Get the traybar's bounding rectangle
  HTaskbar := FindWindow('Shell_TrayWnd', nil); // do not localize
  if HTaskbar <> 0 then
  begin
    HTrayWnd := FindWindowEx(HTaskbar, 0, 'TrayNotifyWnd', nil); // do not localize
    if HTrayWnd <> 0 then
      if GetWindowRect(HTrayWnd, RectTo) then
        GotRectTo := True;
  end;

  // If that fails, invent a rectangle in the corner where the traybar is
  if not GotRectTo then
  begin
    FillChar(abd, SizeOf(abd), 0);
    abd.cbSize := SizeOf(abd);
    if SHAppBarMessage(ABM_GETTASKBARPOS, abd) = 0 then Exit;
    with Screen, abd.rc do
      if (Top > 0) or (Left > 0) then
        RectTo := Rect(Width-32, Height-32, Width, Height)
      else if (Bottom < Height) then
        RectTo := Rect(Width-32, 0, Width, 32)
      else if (Right < Width) then
        RectTo := Rect(0, Height-32, 32, Height);
  end;

  if Minimizing then
    DrawAnimatedRects(Handle, IDANI_CAPTION, RectFrom, RectTo)
  else
    DrawAnimatedRects(Handle, IDANI_CAPTION, RectTo, RectFrom);

  if ResetRegistry then
    SetAnimation(False);               // Disable window animation
  *)
end;

procedure TForm1.ActionWindowMinimizeExecute(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TForm1.ShowBaloonInfo(Text: WideString; Timeout: TBalloonHintTimeOut; Where: TCoolTrayIcon;
  IconT: TBalloonHintIcon);
begin
  if Where = nil then Where := CoolTrayIcon1;
  Where.ShowBalloonHint(TntApplication.Title,Text,IconT,Timeout);
  Log.AddMessage(Text);
end;

procedure TForm1.ShowBaloonError(Text: WideString; Timeout: TBalloonHintTimeOut);
begin
  ShowBaloonInfo(Text,Timeout,nil,bitError);
end;

procedure TForm1.LogFormDestroy(Sender: TObject);
begin
  FLogForm := nil;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  try
    if Assigned(CoolTrayIcon1) then CoolTrayIcon1.IconVisible := False;
    try
      try
        ClearExplorerViews;
        try
          { Free views }
          FreeAndNil(frmMsgView);
          FreeAndNil(frmSMEdit);
          FreeAndNil(frmMEEdit);
          FreeAndNil(frmInfoView);
          FreeAndNil(frmSyncPhonebook);
          FreeAndNil(frmSyncBookmarks);
          FreeAndNil(frmCalendarView);
          FreeAndNil(frmExplore);
          FreeAndNil(frmEditor);
        except
        end;
        if FAppInitialized then
        try
          { Free database storage }
          FNodeMsgInbox := nil;
          FNodeMsgOutbox := nil;
          FNodeMsgArchive := nil;
          FNodeMsgDrafts := nil;
          FNodeContactsME := nil;
          FNodeContactsSM := nil;
          FNodeCallsIn := nil;
          FNodeCallsOut := nil;
          FNodeCallsMissed := nil;
          FNodeBookmarks := nil;
          FNodeAlarms := nil;
        except
        end;
        { Free local variables }
        FreeAndNil(FObex);
        FreeAndNil(FNewMessageList);
        FreeAndNil(FNewPDUList);
        FreeAndNil(FLookupList);
        FreeAndNil(FFavoriteRecipients);
        FreeAndNil(FFavoriteCalls);
        FreeAndNil(FDeliveryRules);
        FreeAndNil(FFiles);
      except
      end;
{$IFNDEF VER150}
      ThemeManager1.Free;
{$ENDIF}
      if Assigned(FLogForm) then FLogForm.Free;
    finally
      { Close handles }
      CloseHandle(WaitCompleteEvent);
      CloseHandle(WaitCompleteIsBusyEvent);
      CloseHandle(FFmaMutex);
    end;
  except
  end;  
end;

procedure TForm1.ActionToolsChangeProfileExecute(Sender: TObject);
var
  EData: PFmaExplorerNode;
begin
  EData := ExplorerNew.GetNodeData(ExplorerNew.FocusedNode);
  if EData = nil then Exit;
  cbProfile.ItemIndex := cbProfile.Items.IndexOf(EData.Text);
  cbProfileChange(cbProfile);
end;

procedure TForm1.ActionToolsChangeProfileUpdate(Sender: TObject);
var
  EData: PFmaExplorerNode;
begin
  EData := ExplorerNew.GetNodeData(ExplorerNew.FocusedNode);
  ActionToolsChangeProfile.Enabled := not ThreadSafe.Busy and FConnected and
    (ExplorerNew.FocusedNode <> nil) and (EData.ImageIndex = 24) and (EData.Text <> cbProfile.Text)
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  w: WideString;
begin
  Memo3.Lines.Add(cbTerminal.Text);
  try
    TxAndWait(cbTerminal.Text);
    w := LongStringToWideString(ThreadSafe.RxBuffer.Text);
    if FUseUTF8 then w := UTF8StringToWideString(WideStringToLongString(w));
    Memo3.Text := Memo3.Text + w;
    Memo3.Lines.Add('');
    if cbTerminal.Items.IndexOf(cbTerminal.Text) = -1 then
      cbTerminal.Items.Insert(0,cbTerminal.Text);
    cbTerminal.Text := '';
  except
    on e: Exception do Memo3.Lines.Add(e.Message);
  end;
end;

procedure TForm1.InitGroups;
const
  Sem: boolean = False;
  iiGroup = 58;
var
  i,j,typ: Integer;
  str,who: WideString;
  num,number: String;
  sl,it: TStringList;
  grp,cnt,member,node1,node2: PVirtualNode;
  EData, EData2: PFmaExplorerNode;
  IsMEModified: boolean;
  function GetName(From: string; index: integer; var Number: string): string;
  var
    root, itNode1, itNode2: PVirtualNode;
    s: WideString;
    data1, data2: PFmaExplorerNode;
  begin
    Result := _('(Unknown)');
    { Each contact number's StateIndex contains its position in phonebook }
    if From <> '' then begin
      s := '';
      if From = 'ME' then root := FNodeContactsME else root := FNodeContactsSM; // do not localize
      // TODO: check if this really is root.FirstChild
      itNode1 := root.FirstChild;
      while itNode1 <> nil do begin
        data1 := ExplorerNew.GetNodeData(itNode1);
        itNode2 := itNode1.FirstChild;
        while itNode2 <> nil do begin
          data2 := ExplorerNew.GetNodeData(itNode2);
          if data2.StateIndex = index then begin
            s := data1.Text;
            Number := data2.Text;
            break;
          end;
          itNode2 := itNode2.NextSibling;
        end;
        if s <> '' then break;
        itNode1 := itNode1.NextSibling;
        Application.ProcessMessages;
        if ThreadSafe.AbortDetected then break;
      end;

      if s = '' then begin
        s := LocatePBName(From,index,Number);
        if s <> '' then IsMEModified := True;
      end;
      if s <> '' then begin
        Result := s;
      end;
    end
    { Each group's StateIndex contains its phone index }
    else begin
      root := FNodeGroups;
      itNode1 := root.FirstChild;
      while itNode1 <> nil do begin
        data1 := ExplorerNew.GetNodeData(itNode1);
        if data1.StateIndex = index then begin
          Result := data1.Text;
          break;
        end;
        itNode1 := itNode1.NextSibling;
      end;
    end;
  end;
begin
  if Sem then exit;
  Sem := True;
  try
    IsMEModified := False;
    if Assigned(FNodeGroups) then
    try
      if frmInfoView.Visible then EBCAState(False);
      if not CoolTrayIcon1.CycleIcons then
        Status(_('Loading groups...'));
      ExplorerNew.DeleteChildren(FNodeGroups);
      ExplorerNew.Update; 
      { Retrieve groups now }
      sl := TStringList.Create;
      it := TStringList.Create;
      try
        TxAndWait('AT*ESGR=?'); // do not localize
        TxAndWait('AT*ESGR'); // do not localize
        sl.Text := ThreadSafe.RxBuffer.Text;
        for i := 0 to sl.Count - 2 do begin
          if pos('*ESGR', sl[i]) = 1 then begin // do not localize
            str := LongStringToWideString(Copy(sl[i], 8, length(sl[i])));
            num := GetToken(str, 0);
            str := GetToken(str, 1); // folder name
            if FUseUTF8 then str := UTF8StringToWideString(WideStringToLongString(str));
            Log.AddCommunicationMessage('Building group '+str+'...', lsDebug); // do not localize debug
            grp := ExplorerNew.AddChild(FNodeGroups);
            EData := ExplorerNew.GetNodeData(grp);

            EData.Text := str;
            EData.ImageIndex := iiGroup;
            EData.StateIndex := StrToInt(num);
            TxAndWait('AT*EGIR='+num); // do not localize
            it.Clear; // clear items from previous group, 10x to Mindstormpt
            it.Text := ThreadSafe.RxBuffer.Text;
            for j := 0 to it.Count - 2 do begin
              if pos('*EGIR', it[j]) = 1 then begin // do not localize
                str := Copy(it[j], 8, length(it[j]));
                num := GetToken(str, 0);
                typ := StrToInt(GetToken(str, 1));
                str := GetToken(str, 2); // item index
                { if it's number index get name and number (from ME) }
                if typ = 2 then who := GetName('ME',StrToInt(str),number); // do not localize
                { check if member is already added }
                member := nil;
                cnt := grp.FirstChild;
                while cnt <> nil do begin
                  EData2 := ExplorerNew.GetNodeData(cnt);
                  if WideCompareText(EData2.Text,who) = 0 then begin
                    member := cnt;
                    break;
                  end;
                  cnt := cnt.NextSibling;
                end;
                if member = nil then begin
                  { nop, add it now }
                  member := ExplorerNew.AddChild(grp); // str is an index here, not a name!
                  EData2 := ExplorerNew.GetNodeData(member);
                  EData2.Text := str;
                  EData2.ImageIndex := 8;
                  EData2.StateIndex := StrToInt(num);
                end;
                { add member data }
                EData2 := ExplorerNew.GetNodeData(member);
                case typ of
                  0: EData2.ImageIndex := iiGroup; // group, will get name later
                  1: EData2.Text := _('Contact #')+str; // contact, how to handle this ???
                  2: begin
                       EData2.Text := who;
                       // new EData2
                       EData2 := ExplorerNew.GetNodeData(ExplorerNew.AddChild(member));
                       EData2.Text := number;
                       EData2.ImageIndex := 13; // add number under name in Explorer
                     end;
                end;
                if ThreadSafe.AbortDetected then break;
              end;
            end;
          end;
        end;
        { Update group names }
        node1 := FNodeGroups.FirstChild;
        while node1 <> nil do begin
          node2 := node1.FirstChild;
          while node2 <> nil do begin
            EData2 := ExplorerNew.GetNodeData(node2);
            if EData2.ImageIndex = iiGroup then begin
              EData2.Text := GetName('',StrToInt(Text),num);
            end;
            node2 := node2.NextSibling;
          end;
          node1 := node1.NextSibling;
        end;
        ExplorerNew.Expanded[FNodeGroups] := true;
        if not CoolTrayIcon1.CycleIcons then
          Status('');
      finally
        sl.Free;
        it.Free;
        if frmInfoView.Visible then EBCAState(True);
        if frmExplore.Visible then frmExplore.RootNode := ExplorerNew.FocusedNode;
      end;
      if IsMEModified then UpdateMEPhonebook;
    except
      Log.AddCommunicationMessage('Error getting Groups', lsDebug); // do not localize debug
    end;
  finally
    Sem := False;
  end;
end;

function TForm1.ExplorerNodeIsFileOrFolder(Node: PVirtualNode): Boolean;
begin
  if Assigned(Node) then begin
    repeat
      Node := Node.Parent;
    until not Assigned(Node) or (Node = FNodeObex);
  end;

  Result := Node = FNodeObex;
end;

procedure TForm1.DoRemoveGroupMemberOrFile;
var
  GID,PID: integer;
  gname,cname,s: WideString;
  FromView: boolean;
  Item: PExploreItem;
  SelNode,Node,DelNode: PVirtualNode;
  Data: PFmaExplorerNode;
  dlg: TfrmConnect;
  Multiselect: boolean;
  CurFile: TFile;
  procedure ReindexGroup;
  var
    j: integer;
    Root,DelNode,itNode: PVirtualNode;
    EData: PFmaExplorerNode;
    procedure FixIt;
    begin
      EData.StateIndex := j;
      inc(j);
    end;
  begin
    DelNode := nil;
    j := 1;
    if FromView then Root := ExplorerNew.FocusedNode
      else Root := ExplorerNew.FocusedNode.Parent;
    itNode := Root.FirstChild;
    while itNode <> nil do begin
      EData := ExplorerNew.GetNodeData(itNode);
      if FromView then
        if WideCompareText(EData.Text,cname) <> 0 then
          FixIt
        else
          DelNode := itNode // we have to delete explorer entry too
      else
        if itNode <> ExplorerNew.FocusedNode then FixIt;
      itNode := itNode.NextSibling;
    end;
    if Assigned(DelNode) then ExplorerNew.DeleteNode(DelNode);
  end;
  procedure ReindexFolder;
  var
    Root,DelNode,itNode: PVirtualNode;
    EData: PFmaExplorerNode;
  begin
    if FromView then begin
      DelNode := nil;
      Root := ExplorerNew.FocusedNode;
      itNode := Root.FirstChild;
      while itNode <> nil do begin
        EData := ExplorerNew.GetNodeData(itNode);
        if WideCompareText(EData.Text,cname) = 0 then begin
          DelNode := itNode; // we have to delete explorer entry too
          break;
        end;
        itNode := itNode.NextSibling;
      end;
      if Assigned(DelNode) then ExplorerNew.DeleteNode(DelNode);
    end;
  end;
begin
  SelNode := frmExplore.ListItems.FocusedNode;
  { Delete from Groups }
  if (ExplorerNew.FocusedNode.Parent = FNodeGroups) or (ExplorerNew.FocusedNode.Parent.Parent = FNodeGroups) then begin
    FromView := frmExplore.Visible and frmExplore.ListItems.Focused and (SelNode.Dummy = 8); // for contacts only
    if FromView then begin
      Item := frmExplore.ListItems.GetNodeData(SelNode);
      Data := ExplorerNew.GetNodeData(ExplorerNew.FocusedNode);
      GID := Data.StateIndex;
      PID := StrToInt(Item.param);
      gname := Data.Text;
      cname := Item.name;
    end
    else begin
      Data := ExplorerNew.GetNodeData(ExplorerNew.FocusedNode);
      PID := Data.StateIndex;
      cname := Data.Text;
      Data := ExplorerNew.GetNodeData(ExplorerNew.FocusedNode.Parent);
      GID := Data.StateIndex;
      gname := Data.Text;
    end;
    if MessageDlgW(WideFormat(_('Removing "%0:s" from group "%1:s". Do you wish to continue?'), [cname,gname]),
      mtConfirmation, MB_YESNO or MB_DEFBUTTON2) <> ID_YES then
      exit;
    TxAndWait('AT*ESDI='+IntToStr(GID)+','+IntToStr(PID)); // do not localize
    ReindexGroup;
    if FromView then begin
      frmExplore.ListItems.DeleteNode(SelNode);
      frmExplore.RootNode := ExplorerNew.FocusedNode; // update view
    end;
  end;

  { Delete from Obex files }
  if ExplorerNodeIsFileOrFolder(ExplorerNew.FocusedNode) then begin
    // for SelNode.Dummy see TfrmExplore.Set_RootNode()
    FromView := frmExplore.Visible and frmExplore.ListItems.Focused and (SelNode.Dummy in [27,36..38,60]);
    Multiselect := FromView and (frmExplore.ListItems.SelectedCount > 1);
    Data := ExplorerNew.GetNodeData(ExplorerNew.FocusedNode);
    if FromView then
      CurFile := PExploreItem(frmExplore.ListItems.GetNodeData(SelNode))^.fFile
    else
      CurFile := TFile(Data.Data);
    cName := WideExtractFileName(CurFile.InternalName);
    gName := Tnt_WideStringReplace(WideExtractFileDir(Tnt_WideStringReplace(CurFile.FullPath,'/','\',[rfReplaceAll])),'\','/',[rfReplaceAll]);
    if Multiselect then
      s := WideFormat(ngettext('%s item','%s items',frmExplore.ListItems.SelectedCount), [IntToStr(frmExplore.ListItems.SelectedCount)])
    else
      s := '"' + cname + '"';
    if MessageDlgW(WideFormat(_('Deleting "%0:s" from folder "%1:s". Do you wish to continue?'), [s, gname]),
      mtConfirmation, MB_YESNO or MB_DEFBUTTON2) = ID_YES then begin

      dlg := nil;
      try
        { Multiple files selected? }
        if Multiselect then
        try
          frmExplore.ListItems.Enabled := False;
          dlg := GetProgressDialog;
          if CanShowProgress then
            dlg.ShowProgress(FProgressLongOnly);
          dlg.SetDescr(_('Deleting files'));
          Status(_('Deleting files'));
          { Yes, delete rest of the files }
          Node := frmExplore.ListItems.GetFirst;
          while Node <> nil do begin
            DelNode := nil;
            if frmExplore.ListItems.Selected[Node] then begin
              CurFile := PExploreItem(frmExplore.ListItems.GetNodeData(Node))^.fFile;
              cName := WideExtractFileName(CurFile.InternalName);
              gName := WideExtractFilePath(CurFile.InternalName);
              dlg.SetDescr(_('Deleting ')+cname+'...');
              ObexPutFile(CurFile.FullPath,True);
              ReindexFolder;
              DelNode := Node;
            end;
            Node := frmExplore.ListItems.GetNext(Node);
            if Assigned(DelNode) then
              frmExplore.ListItems.DeleteNode(DelNode);
          end;
        finally
          frmExplore.ListItems.Enabled := True;
          frmExplore.RootNode := ExplorerNew.FocusedNode;
        end
        else begin
          ObexPutFile(CurFile.FullPath,True);
          ReindexFolder; // Delete node from Explorer too
          if FromView then begin
            frmExplore.ListItems.DeleteNode(SelNode);
            frmExplore.RootNode := ExplorerNew.FocusedNode; // update view
          end
          else
            ExplorerNew.DeleteNode(ExplorerNew.FocusedNode);
        end;

        Status(_('Delete completed'));
      finally
        if Assigned(dlg) then FreeProgressDialog;
      end;
    end;
  end;
end;

procedure TForm1.GetContactRestrict;
var
  sl: TStringList;
  errcnt: Integer;
  function FindIdx(Substr: string): integer;
  var
    i: integer;
  begin
    Result := -1;
    for i := 0 to sl.Count-1 do
      if Pos(Substr,sl[i]) <> 0 then begin
        Result := i;
        break;
      end;
  end;
  function FindStr(Substr: string): string;
  var
    i: integer;
  begin
    i := FindIdx(Substr);
    if i = -1 then Result := ''
      else Result := sl[i];
  end;
  function GetMaxME(DefVal: cardinal): cardinal;
  var
    s: string;
  begin
    try
      s := FindStr('Maximum-Records'); // do not localize
      if s <> '' then begin
        Delete(s,1,16);
        if s <> '*' then begin
          Result := StrToInt(s);
          exit;
        end;
      end;
      Result := 0;
      s := FindStr('Total-Records'); // do not localize
      if s <> '' then begin
        Delete(s,1,14);
        Result := Result + cardinal(StrToInt(s));
      end;
      s := FindStr('Free-Records'); // do not localize
      if s <> '' then begin
        Delete(s,1,13);
        Result := Result + cardinal(StrToInt(s));
      end;
    except
      Result := DefVal;
    end;
  end;
  function GetMaxLen(Field: string; DefVal: cardinal): cardinal;
  var
    s: string;
    i: integer;
  begin
    Result := DefVal;
    try
      s := FindStr(Field);
      if s <> '' then begin
        i := Pos(':=',s);
        Delete(s,1,i+1);
        Result := StrToInt(s);
      end;
    except
      Result := DefVal;
    end;
  end;
begin
  if not FStartupOptions.NoObex and FUseObex then begin
    sl := TStringList.Create;
    try
      { Retrieve "telecom/pb/info.log" T610 example:
      Total-Records:149
      Maximum-Records:*
      Free-Records:346
      DID:6D25
      IEL:0x08
      HD:YES
      SAT:CC
      MCL:NO
      ICL:NO
      OCL:NO
      X-IRMC-FIELDS:
      <Begin>
      VERSION:
      N;CHARSET=ISO-8859-1;CHARSET=UTF-7[1=15;2=15]:=30
      EMAIL;TYPE=INTERNET:=50
      TITLE;CHARSET=ISO-8859-1;CHARSET=UTF-7:=15
      ORG;CHARSET=ISO-8859-1;CHARSET=UTF-7:=15
      X-TEL-TYPES:6
      TEL;TYPE=WORK:=40
      TEL;TYPE=HOME:=40
      TEL;TYPE=CELL:=40
      TEL;TYPE=FAX:=40
      TEL:=40
      X-IRMC-LUID:=12
      REV:
      <End>
      }
      Form1.ObexConnect('IRMC-SYNC'); // do not localize
      try
        errcnt := 0;
        repeat
          try
            try
              ObexGetObject('telecom/pb/info.log',sl); // do not localize
            finally
              FlushOK;
            end;
            break;
          except
            case FObex.LastErrorCode of
              $00: break; // all is OK! exit loop.
              $D3: begin
                     inc(errcnt);
                     { If we got exception "211 Service Unavailable" we'll have to try again later,
                       because phone is still powering up... }
                     Status(_('Phone is powering up. Please wait...'),False);
                     WaitASec(5);
                   end;
              else raise;
            end;
          end;
        until errcnt > 3;
      finally
        Form1.ObexDisconnect;
      end;
      with frmSyncPhonebook do begin
        // Set phonebook ME size
        FMaxRecME := GetMaxME(510);
        Log.AddMessage('Contact: max items = '+IntToStr(FMaxRecME), lsDebug); // do not localize debug
        // Set contact fields max size
        FMaxNameLen := GetMaxLen('N;',30); // do not localize
        Log.AddMessage('Contact: name length = '+IntToStr(FMaxNameLen), lsDebug); // do not localize debug
        FMaxMailLen := GetMaxLen('EMAIL;',50); // do not localize
        Log.AddMessage('Contact: e-mail length = '+IntToStr(FMaxMailLen), lsDebug); // do not localize debug
        FMaxTitleLen := GetMaxLen('TITLE',15); // do not localize
        Log.AddMessage('Contact: title length = '+IntToStr(FMaxTitleLen), lsDebug); // do not localize debug
        FMaxOrgLen := GetMaxLen('ORG;',15); // do not localize
        Log.AddMessage('Contact: organization length = '+IntToStr(FMaxOrgLen), lsDebug); // do not localize debug
        { TODO: should we check individual numbers here? (work,cell...) }
        FMaxTellen := GetMaxLen('TEL:',40); // do not localize
        Log.AddMessage('Contact: phone length = '+IntToStr(FMaxTellen), lsDebug); // do not localize debug
        // Set Obex LUID size
        FMaxLuidLen := GetMaxLen('X-IRMC-LUID:',FMaxLuidLen); // do not localize
        Log.AddMessage('Contact: LUID length = '+IntToStr(FMaxLuidLen), lsDebug); // do not localize debug
      end;
    finally
      sl.Free;
    end;
  end;
end;

procedure TForm1.ObexListFolder(Path: WideString; var Dir: TStringList; Connect: boolean);
begin
  Dir.Clear;
  Dir.Text := ObexListFolder(Path,Connect);
end;

function TForm1.ObexListFolder(Path: WideString; Connect: boolean): string;
var
  StringStream: TStringStream;
  w: WideString;
begin
  AskRequestConnection;
  { Result is a XML document (encoded) }
  if Connect then ObexConnect(ObexFolderBrowserServiceID);
  try
    { make sure we always go to the root dir }
    if (Path = '') or (Path[1] <> '/') then
      Path := '/' + Path;
    { trunc last '/' otherwise we'd end up in the root }
    while (Length(Path) > 1) and (Path[Length(Path)] = '/') do
      Delete(Path, Length(Path), 1);

    //Log.AddCommunicationMessage('OBEX listing folder: '+Path, lsDebug); // do not localize debug  

    { to make sure CL-LF's and spaces aren't seen as new item, we will quote
      each folder name, and will double intermediate quotes. }
    if Path <> '/' then
      Path := Tnt_WideStringReplace(WideQuoteStr(Path,True), '/', '"/"', [rfReplaceAll]);
    { changing nested dirs at once (Pictures/Camera) doesn't seem to be supported
      so we do it in steps (change to '/' -> change to 'Pictures' -> change to 'Camera') }
    while Path <> '' do begin
      w := GetFirstToken(Path,'/');
      FObex.ChangeDir(w); // if w is empty we'll change to root folder
    end;
    { old way...
    with TTntStringList.Create do
    try
      Delimiter := '/';
      DelimitedText := Path;
      for i := 0 to Count-1 do
        FObex.ChangeDir(Strings[i]);
    finally
      Free;
    end;
    { get current dir contents }
    StringStream := TStringStream.Create('');
    try
      FObex.List(StringStream);
      Result := StringStream.DataString;
    finally
      StringStream.Free;
    end;
  finally
    if Connect then ObexDisconnect;
  end;
end;

procedure TForm1.InitObexFolders;
begin
  if not FStartupOptions.NoObex and FUseObex then begin
    if not CoolTrayIcon1.CycleIcons then
      Status(_('Loading folders...'));
    try
      fFiles.Update;
      ExplorerNew.Expanded[FNodeObex] := true;
    finally
      if not CoolTrayIcon1.CycleIcons then
        Status('');
      if frmExplore.Visible then frmExplore.RootNode := ExplorerNew.FocusedNode;
    end;
  end;
end;

procedure TForm1.ObexPutFile(filename: WideString; Delete,Silent: boolean);
begin
  RequestConnection;
  { We don't call ObexConnect here since we don't know in
    which server the file should go. So, the phone will
    handle file put request and it will do whatsoever. }
  try
    if Delete then begin
      ObexConnect(ObexFolderBrowserServiceID);
      try
        FObex.PutFile(filename,True); // delete
        if not Silent and not FStartupOptions.NoBaloons then
          ShowBaloonInfo(WideFormat(_('File "%s" deleted.'),[WideExtractFileName(filename)]))
      finally
        ObexDisconnect;
      end
    end
    else begin
      FObex.PutFile(filename);
      if not Silent and not FStartupOptions.NoBaloons then
        ShowBaloonInfo(WideFormat(_('File "%s" sent to phone.'),[WideExtractFileName(filename)]));
    end;
  finally
    FlushOK;
  end;
end;

procedure TForm1.ActionToolsDownloadExecute(Sender: TObject);
var
  fname: WideString;
  Node: PVirtualNode;
  EData: PFmaExplorerNode;
  dlg: TfrmConnect;
  Multiselect: boolean;
  CurFile: TFile;
begin
  { Multiple files selected? }
  Multiselect := frmExplore.Visible and frmExplore.ListItems.Focused and (frmExplore.ListItems.SelectedCount > 1);

  dlg := nil;
  try
    if frmExplore.Visible and frmExplore.ListItems.Focused and
      (frmExplore.ListItems.FocusedNode <> nil) then
      CurFile := PExploreItem(frmExplore.ListItems.GetNodeData(frmExplore.ListItems.FocusedNode))^.fFile
    else begin
      EData := ExplorerNew.GetNodeData(ExplorerNew.FocusedNode);
      CurFile := TFile(EData.Data);
    end;

    fName := WideExtractFileName(CurFile.InternalName);
    Node := frmExplore.ListItems.GetFirst;
    if CurFile.FileType = ftDir then begin
      MessageDlgW(WideFormat(_('Error: Download of Directories (here: %0:s) is not yet supported'), [fName]),mtError, MB_OK);
      if not Multiselect then exit;

      CurFile := nil;
      while (Node <> nil) do begin
        if frmExplore.ListItems.Selected[Node] and (Node <> frmExplore.ListItems.FocusedNode) then begin
          if (PExploreItem(frmExplore.ListItems.GetNodeData(Node))^.fFile.FileType <> ftDir) then begin
            CurFile := PExploreItem(frmExplore.ListItems.GetNodeData(Node))^.fFile;
            Node := frmExplore.ListItems.GetNext(Node);
            Break;
          end;
        end
        else begin
          Node := frmExplore.ListItems.GetNext(Node);
          continue;
        end;
      end;
      if (Node = nil) and (CurFile = nil) then exit;
    end;
    fName := WideExtractFileName(CurFile.InternalName);
    ObexSaveDialog.FileName := fname;
    ObexSaveDialog.Filter := _('Similar Files|*')+WideExtractFileExt(fname)+_('|All Files|*.*');
    if ObexSaveDialog.Execute then begin
      if Multiselect then begin
        dlg := GetProgressDialog;
        if CanShowProgress then
          dlg.ShowProgress(FProgressLongOnly);
        dlg.SetDescr(_('Downloading files'));
        Status(_('Downloading files'));
        Enabled := False; // prevent keyboard move up/down in list while deleteing
        try
          ObexGetFile(ObexSaveDialog.FileName, CurFile.FullPath);
          { Download rest of the files using same settings }
          while Node <> nil do begin
            if frmExplore.ListItems.Selected[Node] and (Node <> frmExplore.ListItems.FocusedNode) then begin
              dlg.SetDescr(_('Saving...'));
              CurFile := PExploreItem(frmExplore.ListItems.GetNodeData(Node))^.fFile;
              fName := WideExtractFileName(CurFile.InternalName);
              if CurFile.FileType = ftDir then begin
                MessageDlgW(WideFormat(_('Error: Download of Directories (here: %0:s) is not yet supported'), [fName]),mtError, MB_OK);
                Node := frmExplore.ListItems.GetNext(Node);
                continue;
              end;
              ObexSaveDialog.FileName := WideExtractFilePath(ObexSaveDialog.FileName) + fname;
              if FileExists(ObexSaveDialog.FileName) then begin
                ObexSaveDialog.Filter := _('Similar Files|*')+WideExtractFileExt(fname)+_('|All Files|*.*');
                if not ObexSaveDialog.Execute then begin
                  Node := frmExplore.ListItems.GetNext(Node);
                  continue;
                end;
              end;
              ObexGetFile(ObexSaveDialog.FileName, CurFile.FullPath);
              frmExplore.ListItems.Selected[Node] := False;
            end;
            Node := frmExplore.ListItems.GetNext(Node);
          end;
        finally
          Enabled := True;
        end;
      end
      else
        { Download the selected file only }
        ObexGetFile(ObexSaveDialog.FileName, CurFile.FullPath);
    end
    else
      Abort; // stop processing if Save dialog is canceled
    Status(_('Download completed'));
  finally
    if Assigned(dlg) then FreeProgressDialog;
  end;
end;

procedure TForm1.ObexGetFile(filename,objname: WideString; Silent: boolean);
begin
  RequestConnection;
  ObexConnect(ObexFolderBrowserServiceID);
  try
    FObex.GetFile(filename,objname,Silent);
    if not Silent and not FStartupOptions.NoBaloons then
      ShowBaloonInfo(WideFormat(_('File "%s" received from phone.'),[WideExtractFileName(filename)]));
  finally
    ObexDisconnect;
  end;
end;

function TForm1.LocatePBName(Where: string; Index: integer; var Number: string): WideString;
var
  Tm,i: Integer;
  sl: TStringList;
  slTmp: TTntStringList;
  Who,s: WideString;
  contact: PContactData;
begin
  // +CPBR: 100,"+359xxxxxxxxx",145,"Ilko"
  Result := '';
  TxAndWait('AT+CPBS="' + Where + '"'); // do not localize
  sl := TStringList.Create;
  try
    { Temporary increase timeout since searching may take alot of time }
    Tm := ThreadSafe.InactivityTimeout;
    if Tm < LongOperationsTimeout then
      ThreadSafe.InactivityTimeout := LongOperationsTimeout;
    try
      TxAndWait('AT+CPBR=' + IntToStr(Index)); // do not localize
      sl.Text := ThreadSafe.RxBuffer.Text;
    finally
      ThreadSafe.InactivityTimeout := Tm;
    end;
    { Parse results }
    for i := 0 to sl.Count-1 do
      if Pos('+CPBR',sl[i]) = 1 then begin // do not localize
        slTmp := TTntStringList.Create;
        try
          s := LongStringToWideString(sl[i]);
          if FUseUTF8 then s := UTF8StringToWideString(WideStringToLongString(s));
          slTmp.DelimitedText := s;
          Number := slTmp.Strings[2];
          if (slTmp.Strings[3] = '145') and (Number[1] <> '+') then
            Number := '+' + Number;
          Who := slTmp.Strings[4];
          if (Length(Who) > 2) and (Who[Length(Who)-1] = '/') then
            Who := Copy(Who,1,Length(Who)-2);
          { Do cache phone number position }
          if IsIrmcSyncEnabled and (Where = 'ME') then
            { Only supported for phone book view }
            if frmSyncPhonebook.FindContact(Who,contact) then begin
              SetContactPosition(contact,Number,Index);
              UpdateMEPhonebook;
            end;
          Result := Who;
        finally
          slTmp.Free;
        end;
        break;
      end;
  finally
    sl.Free;
  end;
end;


function TForm1.LocatePBName(Where: string; Index: integer): WideString;
var
  dummy: string;
begin
  Result := LocatePBName(Where,Index,dummy);
end;

function TForm1.LocatePBIndex(Where: string; Person: WideString; Phone: string): integer;
var
  Tm,i,Pos: Integer;
  slTmp: TTntStringList;
  Num: string;
  Who,s: WideString;
  contact: PContactData;
  sl: TStringList;
begin
  // +CPBF: 13,"35988xxxxxxx",145,"Ilko/H"
  // +CPBF: 100,"359887xxxxxxx",145,"Ilko/M"
  Result := -1;
  if FUseUTF8 then s := WideStringToUTF8String(Person) else s := Person;
  if Where = 'SM' then
    s := Copy(s,1,frmSMEdit.FMaxNameLen)
  else
    s := Copy(s,1,frmMEEdit.FMaxNameLen);
  Log.AddCommunicationMessage('Searching for contact info: '+Person, lsDebug); // do not localize debug
  TxAndWait('AT+CPBS="' + Where + '"'); // do not localize
  sl := TStringList.Create;
  try
    { Temporary increase timeout since searching may take alot of time }
    Tm := ThreadSafe.InactivityTimeout;
    if Tm < LongOperationsTimeout then
      ThreadSafe.InactivityTimeout := LongOperationsTimeout;
    try
      TxAndWait('AT+CPBF="' + s + '"'); // do not localize
      sl.Text := ThreadSafe.RxBuffer.Text;
    finally
      ThreadSafe.InactivityTimeout := Tm;
    end;
    { Parse results }
    for i := 0 to sl.Count-1 do begin
      if System.Pos('+CPBF',sl[i]) = 1 then begin // do not localize
        slTmp := TTntStringList.Create;
        try
          s := LongStringToWideString(sl[i]);
          if FUseUTF8 then s := UTF8StringToWideString(WideStringToLongString(s));
          slTmp.DelimitedText := s;

          Pos := StrToInt(slTmp.Strings[1]);

          Num := slTmp.Strings[2];
          if (slTmp.Strings[3] = '145') and (Num[1] <> '+') then Num := '+' + Num;

          Who := slTmp.Strings[4];
          if (Length(Who) > 2) and (Who[Length(Who)-1] = '/') then
            Who := Copy(Who,1,Length(Who)-2);
        finally
          slTmp.Free;
        end;
        if (AnsiCompareText(Num,Phone) = 0) and (WideCompareText(Who,Person) = 0) then begin
          { Do cache phone number position }
          if IsIrmcSyncEnabled and (Where = 'ME') then
            { Only supported for phone book view }
            if frmSyncPhonebook.FindContact(Who,contact) then begin
              SetContactPosition(contact,Num,Pos);
              UpdateMEPhonebook;
            end;
          Result := Pos;
          break;
        end;
      end;
    end;
  finally
    sl.Free;
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  ActionConnectionExplorer.Execute;
end;

procedure TForm1.ActionConnectionExplorerUpdate(Sender: TObject);
begin
  ActionConnectionExplorer.Checked := PanelExplorer.Visible;
  DescrPanel.Visible := not PanelExplorer.Visible;
  DescrPanel.Update;
end;

procedure TForm1.ActionConnectionExplorerExecute(Sender: TObject);
begin
  ActionConnectionExplorer.Checked := not ActionConnectionExplorer.Checked;
  PanelExplorer.Visible := ActionConnectionExplorer.Checked;
  if DescrPanel.Visible then DescrPanel.Top := 0; // make on top
  Splitter1.Visible := PanelExplorer.Visible;
  Splitter1.Left := PanelExplorer.Left + PanelExplorer.Width;
  if frmInfoView.Visible then frmInfoView.OnResize(nil);
end;

procedure TForm1.CalculateTimeLeft(Model,Charge: string; Position, Max: integer);
var
  pos,sec,secfix,PrevPos: integer;
  key,PrevCharge: string;
  PrevTime: TDateTime;
  Reg: TRegistry;
  days: integer;
  procedure SaveInfo;
  begin
    with Reg do begin
      WriteInteger('Power',Position); // do not localize
      WriteString('Charge',Charge); // do not localize
      WriteTime('When',Now); // do not localize
    end;
  end;
begin
  Reg := TRegistry.Create;
  with Reg do
  try
    PrevPos := -1;
    PrevCharge := Charge;
    PrevTime := Now;
    key := 'software\float\fma\'+Model; // do not localize
    RootKey := HKEY_CURRENT_USER;
    if OpenKey(key,True) then
      try
        if ValueExists('Power') then PrevPos := ReadInteger('Power'); // do not localize
        if ValueExists('Charge') then PrevCharge := ReadString('Charge'); // do not localize
        if ValueExists('When') then PrevTime := ReadTime('When'); // do not localize
        if Charge = '' then Charge := PrevCharge;
        { is there are status change detected }
        if (PrevPos <> -1) or (PrevCharge <> Charge) then
          begin
            if PrevCharge = Charge then begin
              secfix := 0;
              sec := Round((Now - PrevTime) * SecsPerDay);
              pos := Abs(PrevPos-Position);
              (*
              { on every 30 secs or on status change calculate time left }
              if (sec mod 30 = 0) and (pos = 0) then begin
                pos := 1;
                { metter tune up: appr. +5 days on full batteries (4320*100) }
                if (Position > 94) and not FOnACPower then
                  secfix := (4320 * (Position-94)) div (Max-94);
              end;
              *)
              if (pos = 0) and (Position > 94) and not FOnACPower then
                secfix := (4320 * (Position-94)) div (Max-94);
              if (sec >= 10) and (pos > 0) then begin
                //if PrevPos <> Position then SaveInfo;
                inc(sec,secfix);
                { on AC power show time until charge complete }
                if FOnACPower then begin
                  sec := Round((sec*(Max-Position))/pos);
                  frmInfoView.Label8.Caption := _('Est. Charge Left:');
                end
                else begin
                  sec := Round((sec*Position)/pos);
                  frmInfoView.Label8.Caption := _('Est. Time Left:');
                end;
                { show time left }
                if sec = 0 then
                  if FOnACPower then frmInfoView.lblTimeLeft.Caption := _('done')
                  else frmInfoView.lblTimeLeft.Caption := _('none')
                else begin
                  days := sec div SecsPerDay;
                  if days > 6 then days := 6;
                  frmInfoView.lblTimeLeft.Caption := Format(_('%dd %.2d:%.2dh'),
                    [days,(sec mod SecsPerDay) div 3600,(sec mod 3600) div 60]);
                end;
              end
            end
            else begin
              SaveInfo;
              frmInfoView.lblTimeLeft.Caption := '?';
              frmInfoView.Label8.Caption := _('Est. Time Left:');
            end;
          end
        else
          SaveInfo;
      finally
        CloseKey;
      end;
  finally
    Free;
  end;
end;

procedure TForm1.ActionExplorerUpFolderUpdate(Sender: TObject);
begin
  ActionExplorerUpFolder.Enabled := ExplorerNew.FocusedNode <> ExplorerNew.GetFirst;
end;

procedure TForm1.ActionExplorerUpFolderExecute(Sender: TObject);
begin
  SetExplorerNode(ExplorerNew.FocusedNode.Parent);
end;

procedure TForm1.trayMenuPopup(Sender: TObject);
begin
  { Workaround for Win+D and Win+M keys }
  if IsIconic(Application.Handle) then
    ShowRestore1.Action := ActionWindowRestore
  else
    ShowRestore1.Action := ActionWindowMinimize;
end;

function TForm1.LookupNumber(Contact: WideString): String;
var
  DataME: PContactData;
  Node: PVirtualNode;
  EData: PFmaExplorerNode;
begin
  Result := '';
  { remove any number suplyed }
  Contact := ExtractContact(Contact);
  { then lookup in various address book places }
  case WhereisContact(Contact,fcByName) of
    frIrmcSync:
      if frmSyncPhonebook.FindContact(Contact,DataME) then
        Result := GetContactDefPhone(DataME);
    frPhonebook: begin
      Node := FindExplorerChildNode(Contact,FNodeContactsME);
      if Node.ChildCount <> 0 then
      begin
        EData := ExplorerNew.GetNodeData(Node.FirstChild);
        Result := EData.Text;
      end;
    end;
    frSIMCard: begin
      Node := FindExplorerChildNode(Contact,FNodeContactsSM);
      if Node.ChildCount <> 0 then
      begin
        EData := ExplorerNew.GetNodeData(Node.FirstChild);
        Result := EData.Text;
      end;
    end;
  end;
end;

procedure TForm1.ActionBusyUpdate(Sender: TObject);
begin
  with (Sender as TTntAction) do begin
    { Do not put FConnected check here! }
    Enabled := not ThreadSafe.Busy and not FObex.Connected and not ThreadSafe.ObexConnecting;
  end;
end;

procedure TForm1.ActionEditCommonUpdate(Sender: TObject);
begin
  with (Sender as TTntAction) do begin
    Enabled := frmMsgView.Visible or frmSyncPhonebook.Visible or frmSMEdit.Visible or frmMEEdit.Visible or
      frmEditor.Visible or frmSyncBookmarks.Visible or
      (frmExplore.Visible and (ExplorerNew.FocusedNode = FNodeAlarms) and (frmExplore.ListItems.SelectedCount = 1)) or
      (frmExplore.Visible and (ExplorerNew.FocusedNode.Parent = FNodeGroups) and (frmExplore.ListItems.SelectedCount = 1)) or
      (frmExplore.Visible and (ExplorerNew.FocusedNode = FNodeGroups) and (frmExplore.ListItems.SelectedCount = 1)) or
      (frmExplore.Visible  and (frmExplore.ListItems.SelectedCount <> 0) and (getExplorerSelectedNodeLevel1 = FNodeObex) );
  end;
end;

procedure TForm1.ActionContactsNewPersonUpdate(Sender: TObject);
begin
  ActionContactsNewPerson.Enabled := not FStartupOptions.NoIRMC or frmSyncPhonebook.Visible or
    frmSMEdit.Visible or frmMEEdit.Visible;
end;

procedure TForm1.ActionContactsNewPersonExecute(Sender: TObject);
begin
  if frmSMEdit.Visible then
    frmSMEdit.NewPerson1Click(nil)
  else
  if frmMEEdit.Visible then
    frmMEEdit.NewPerson1Click(nil)
  else
  { Allow new person task even if phonebook view is not active one }
  if IsIrmcSyncEnabled or frmSyncPhonebook.Visible then
    frmSyncPhonebook.btnNEWClick(nil)
  else
    frmMEEdit.NewPerson1Click(nil);
end;

procedure TForm1.ActionContactsVoiceCallUpdate(Sender: TObject);
begin
  ActionContactsVoiceCall.Enabled := not FObex.Connected;
end;

procedure TForm1.ActionContactsNewMsgUpdate(Sender: TObject);
begin
  ActionContactsNewMsg.Enabled := IsContactNumberSelected and (LocateSelContactNumber <> sUnknownNumber);
end;

function TForm1.LocateSelContactNumber: string;
var
  Number: WideString;
  contact: PContactData;
  simrec: PSimData;
  smsrec: PListData;
  Item: PExploreItem;
  Node: PVirtualNode;
  EData: PFmaExplorerNode;
begin
  Number := '';
  try
    if frmInfoView.Visible and (ActiveControl is TTntListView) then begin
      Number := (Form1.ActiveControl as TTntListView).Selected.Caption;
    end
    else
    if frmSyncPhonebook.Visible and (ActiveControl = frmSyncPhonebook.ListContacts) then begin
      contact := frmSyncPhonebook.ListContacts.GetNodeData(frmSyncPhonebook.ListContacts.FocusedNode);
      if contact <> nil then
        Number := ContactNumberByName(GetContactFullName(contact));
    end
    else
    if frmMsgView.Visible and (ActiveControl = frmMsgView.ListMsg) then begin
      smsrec := frmMsgView.ListMsg.GetNodeData(frmMsgView.ListMsg.FocusedNode);
      if smsrec <> nil then
        Number := smsrec.from;
    end
    else
    if frmSMEdit.Visible and (ActiveControl = frmSMEdit.ListNumbers) then begin
      simrec := frmSMEdit.ListNumbers.GetNodeData(frmSMEdit.ListNumbers.FocusedNode);
      if simrec <> nil then
        Number := simrec.cname + ' [' + simrec.pnumb + ']';
    end
    else
    if frmMEEdit.Visible and (ActiveControl = frmMEEdit.ListNumbers) then begin
      simrec := frmMEEdit.ListNumbers.GetNodeData(frmMEEdit.ListNumbers.FocusedNode);
      if simrec <> nil then
        Number := simrec.cname + ' [' + simrec.pnumb + ']';
    end
    else
    if frmExplore.Visible and (ActiveControl = frmExplore.ListItems) then begin
      if frmExplore.ListItems.FocusedNode <> nil then begin
        { we have selected item in te view }
        Item := frmExplore.ListItems.GetNodeData(frmExplore.ListItems.FocusedNode);
        if Item <> nil then begin
          if frmExplore.ListItems.FocusedNode.Dummy = 8 then begin // contact
            Number := ContactNumberByName(Item.name);
          end
          else
          if frmExplore.ListItems.FocusedNode.Dummy in [9..13] then begin // numbers
            Number := ContactNumberByTel(Item.name);
          end
          else begin // calls
            Number := Item.name;
          end;
        end;
      end
      else begin
        { no item selected }
        Node := frmExplore.GetSelectedNode;
        EData := Form1.ExplorerNew.GetNodeData(Node);
        if EData.ImageIndex = 8 then begin // contact in explorer
          Number := ContactNumberByName(EData.Text);
        end
        else
        if EData.ImageIndex in [9..13] then begin // numbers in explorer
          Number := ContactNumberByTel(EData.Text);
        end
        else begin // calls in explorer
          Number := EData.Text;
        end;
      end;
    end
    else begin
      EData := ExplorerNew.GetNodeData(ExplorerNew.FocusedNode);
      if EData.ImageIndex = 8 then begin // explorer contact
        Number := ContactNumberByName(EData.Text);
      end
      else
      if EData.ImageIndex in [53..55] then begin // explorer call
        Number := EData.Text;
      end
      else begin// explorer number (leaf, has contact as parent)
        Number := ' [' + EData.Text + ']';
        EData := ExplorerNew.GetNodeData(ExplorerNew.FocusedNode.Parent);
        Number := EData.Text + Number;
      end;
    end;
  except
    Log.AddMessage('Error: Could not found selected contact (LocateSelContactNumber)', lsDebug); // do not localize debug
  end;
  Result := Number;
end;

function TForm1.IsContactNumberSelected: boolean;
var
  EData: PFmaExplorerNode;
begin
  if ActiveControl = ExplorerNew then begin
    EData := ExplorerNew.GetNodeData(ExplorerNew.FocusedNode);
    Result := (ExplorerNew.FocusedNode <> nil) and (EData.ImageIndex in [8..13,53..55]); // contact and numbers, calls
  end
  else
  if frmInfoView.Visible and (ActiveControl is TTntListView) then
    Result := (ActiveControl as TTntListView).SelCount = 1
  else
  if ActiveControl = frmSyncPhonebook.ListContacts then
    Result := frmSyncPhonebook.ListContacts.SelectedCount = 1
  else
  if ActiveControl = frmExplore.ListItems then begin
    EData := ExplorerNew.GetNodeData(frmExplore.GetSelectedNode);
//  Result := (frmExplore.ListItems.FocusedNode <> nil) and (frmExplore.ListItems.FocusedNode.Dummy in [8..13,53..55])
    Result := (frmExplore.GetSelectedNode <> nil) and (EData.ImageIndex in [8..13,53..55]);
  end
  else
  if ActiveControl = frmSMEdit.ListNumbers then
    Result := frmSMEdit.ListNumbers.SelectedCount = 1
  else
  if ActiveControl = frmMEEdit.ListNumbers then
    Result := frmMEEdit.ListNumbers.SelectedCount = 1
  else
  if ActiveControl = frmMsgView.ListMsg then
    Result := frmMsgView.ListMsg.SelectedCount = 1
  else
    Result := False;
end;

procedure TForm1.ActionSMSUpdate(Sender: TObject);
begin
  (Sender as TTntAction).Enabled := frmMsgView.Visible and (frmMsgView.ListMsg.SelectedCount <> 0);
end;

procedure TForm1.ActionContactsExportMEUpdate(Sender: TObject);
begin
  (Sender as TTntAction).Enabled := frmSyncPhonebook.Visible and (frmSyncPhonebook.ListContacts.SelectedCount <> 0);
end;

procedure TForm1.ExplorerAddToGroup(GroupIndex: integer; Contact: WideString; Number: String);
var
  grp,cnt,num: PVirtualNode;
  data1,data2,data3: PFmaExplorerNode;
begin
  num := nil;
  grp := FNodeGroups.FirstChild;
  while grp <> nil do
  try
    data1 := ExplorerNew.GetNodeData(grp);
    if data1.StateIndex = GroupIndex then begin
      cnt := grp.FirstChild;
      while cnt <> nil do begin
        { check if name already exists }
        data2 := ExplorerNew.GetNodeData(cnt);
        if WideCompareText(data2.Text,Contact) = 0 then begin
          num := cnt.FirstChild;
          while num <> nil do begin
            { check if number is already added }
            data3 := ExplorerNew.GetNodeData(num);
            if AnsiCompareText(data3.Text,Number) = 0 then begin
              break;
            end;
            num := num.NextSibling;
          end;
          break;
        end;
        cnt := cnt.NextSibling;
      end;
      { add new contact and phone number }
      if not Assigned(num) then begin
        if not Assigned(cnt) then begin
          cnt := ExplorerNew.AddChild(grp); // add contact under group node
          data2 := ExplorerNew.GetNodeData(cnt);
          data2.Text := Contact;
          data2.ImageIndex := 8;
          data2.StateIndex := grp.ChildCount;
        end;
        num := ExplorerNew.AddChild(cnt);
        data3 := ExplorerNew.GetNodeData(num);
        data3.Text := Number;
        data3.ImageIndex := 13; // add phone number in explorer under contact
        { update view if in group view }
        data3 := ExplorerNew.GetNodeData(ExplorerNew.FocusedNode);
        if (data3<>nil) and (data3.ImageIndex = 58) then
          ExplorerNewChange(ExplorerNew,ExplorerNew.FocusedNode);
      end;
      break;
    end;
  finally
    grp := grp.NextSibling;
  end;
end;

procedure TForm1.ExplorerNewContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
var
  Node: PVirtualNode;
begin
  Node := ExplorerNew.GetNodeAt(MousePos.X,MousePos.Y);
  if (Node <> nil) and (Node <> ExplorerNew.FocusedNode) then begin
    ExplorerNew.FocusedNode := Node; // move focus to popup position
    Application.ProcessMessages;
  end;
end;

procedure TForm1.ActionEditGoUpUpdate(Sender: TObject);
begin
  ActionEditGoUp.Enabled := (ExplorerNew.FocusedNode <> nil) and (ExplorerNew.FocusedNode.PrevSibling <> nil);
end;

procedure TForm1.ActionEditGoUpExecute(Sender: TObject);
begin
  SetExplorerNode(ExplorerNew.FocusedNode.PrevSibling);
end;

procedure TForm1.ActionEditGoDownUpdate(Sender: TObject);
begin
  ActionEditGoDown.Enabled := (ExplorerNew.FocusedNode <> nil) and (ExplorerNew.FocusedNode.NextSibling <> nil);
end;

procedure TForm1.ActionEditGoDownExecute(Sender: TObject);
begin
  SetExplorerNode(ExplorerNew.FocusedNode.NextSibling);
end;

procedure TForm1.ActionSMSArchiveMsgUpdate(Sender: TObject);
var data: PFmaExplorerNode;
begin
  if (ExplorerNew.FocusedNode <> nil) and frmMsgView.Visible and (frmMsgView.ListMsg.SelectedCount <> 0) then begin
    data := ExplorerNew.GetNodeData(ExplorerNew.FocusedNode);
    (Sender as TTntAction).Enabled := (data.StateIndex = FmaSMSSubFolderFlag) or
    (ExplorerNew.FocusedNode = FNodeMsgInbox) or (ExplorerNew.FocusedNode = FNodeMsgSent);
  end
  else
    (Sender as TTntAction).Enabled := False;
end;

procedure TForm1.ActionConnectionDownloadUpdate(Sender: TObject);
var
  d: dword;
  data: PFmaExplorerNode;
begin
  if not ThreadSafe.Busy and not FObex.Connected and (ExplorerNew.FocusedNode <> nil) then begin
    data := ExplorerNew.GetNodeData(ExplorerNew.FocusedNode);
    d := (data.StateIndex and $F00000) shr 20;
    ActionConnectionDownload.Enabled := d in [1,2,3,4,5,7,8];
  end
  else
    ActionConnectionDownload.Enabled := False;
end;

procedure TForm1.Properties1Click(Sender: TObject);
begin
  ShowExplorerProperties(ExplorerNew.FocusedNode);
end;

function TForm1.IsAutoConnect: boolean;
begin
  Result := ActionConnectionMonitor.Checked and (ActionConnectionMonitor.Tag = 1);
end;

procedure TForm1.DoProximityAway;
var
  i: integer;
  Ini: TInifile;
  ScreenSaverFile: string;
  function GetLongFileName(const FileName: string): string;
  var
    aInfo: TSHFileInfo;
  begin
    if SHGetFileInfo(PChar(FileName), 0, aInfo, SizeOf(aInfo), SHGFI_DISPLAYNAME) <> 0 then
      Result := StrPas(aInfo.szDisplayName)
    else
      Result := FileName;
  end;
begin
  if FProximityActive or (not IsAutoConnect and not FConnectingComplete) then exit;
  FProximityActive := True;

  Log.AddMessage('Proximity detection: Away', lsDebug); // do not localize debug
  PlaySound(pChar('FMA_Away'), 0, SND_ASYNC or SND_APPLICATION or SND_NODEFAULT); // do not localize

  try
    ScriptEvent('OnProximity', [1]); // do not localize
  except
  end;

  FLastVolume := GetVolume;
  with FProximityOptions do begin
    if not AwayLock and RunSS then begin
      { Invoke screensaver... }
      Ini := TInifile.Create('system.ini'); // do not localize
      try
        ScreenSaverFile := GetLongFileName(Ini.Readstring('boot', 'SCRNSAVE.EXE', '')); // do not localize
        if ScreenSaverFile <> '' then begin
          ScreenSaverFile := ExpandFileName(ScreenSaverFile);
          ShellExecute(Handle,'open',PChar(ScreenSaverFile),'', // do not localize
            PChar(ExtractFileDir(ScreenSaverFile)),SW_SHOWNORMAL);
        end;
      finally
        Ini.Free;
      end;
      { Credit goes to Vladimir Kopjov }
      SendMessage(GetDesktopWindow,WM_SYSCOMMAND,SC_SCREENSAVE,0);
    end;
    if AwayLock then
      ShellExecute(Handle,'open','Rundll32.exe','user32.dll,LockWorkStation','',SW_HIDE); // do not localize
    case AwayMusicMode of
      0: begin // mute
           SetMute(True);
           FLastVolume := -1;
         end;
      1: begin // unmute
           SetMute(False);
           FLastVolume := -1;
         end;
      2: begin // decrease 80%
           for i := 10 downto 2 do begin
             SetVolume(Round(i*FLastVolume/10));
             WaitASec(100,True);
           end;
         end;
      3: begin // increase 80%
           for i := 2 to 10 do begin
             SetVolume(Round(i*FLastVolume/2));
             WaitASec(100,True);
           end;
         end;
    end;
  end;
end;

procedure TForm1.DoProximityNear;
var
  i: integer;
begin
  if not FProximityActive then exit;
  FProximityActive := False;

  Log.AddMessage('Proximity detection: Near', lsDebug); // do not localize debug
  PlaySound(pChar('FMA_Near'), 0, SND_ASYNC or SND_APPLICATION or SND_NODEFAULT); // do not localize

  GetVolume;
  with FProximityOptions do begin
    if NearUnlock then
      { not supported yet } ;
    case NearMusicMode of
      0: SetMute(True);  // mute
      1: SetMute(False); // unmute
      2: if FLastVolume <> -1 then begin // decrease 80%
           for i := 10 downto 2 do begin
             SetVolume(Round(i*FLastVolume/2));
             WaitASec(100,True);
           end;
         end;
      3: if FLastVolume <> -1 then begin // increase 80%
           for i := 2 to 10 do begin
             SetVolume(Round(i*FLastVolume/10));
             WaitASec(100,True);
           end;
         end;
    end;
  end;

  try
    ScriptEvent('OnProximity', [0]); // do not localize
  except
  end;
end;

function TForm1.GetMute: Boolean;
begin
  AudioMixer1.GetMute (0,-1, MD);
  AudioMixer1.GetVolume (0,-1,L,R,M,Stereo,VD,MD,MS);

  Result := M<>0;
end;

function TForm1.GetVolume: Integer;
begin
  AudioMixer1.GetMute (0,-1, MD);
  AudioMixer1.GetVolume (0,-1,L,R,M,Stereo,VD,MD,MS);

  Result := Round(((L+R)/2)/65536 * 100);
end;

procedure TForm1.SetMute(Mute: Boolean);
begin
  AudioMixer1.SetVolume (0,-1,L,-1,byte(Mute)); // left = right
end;

procedure TForm1.SetVolume(Percentage: Integer);
begin
  if Percentage < 0 then Percentage := 0;
  if Percentage > 100 then Percentage := 100;
  AudioMixer1.SetVolume (0,-1,Round(Percentage/100*65536),-1,-1); // left = right, ignore mute
end;

procedure TForm1.DownloadAllMessages;
var
  dlg: TfrmConnect;
begin
  AskRequestConnection;
  frmInfoView.linkGetMessages.Enabled := False;
  dlg := GetProgressDialog;
  try
    if CanShowProgress then
      dlg.ShowProgress(FProgressLongOnly);
    dlg.SetDescr(_('Retrieving text messages'));
    { Sync folders }
    DownloadMessages(FNodeMsgInbox);
    DownloadMessages(FNodeMsgSent);
  finally
    FreeProgressDialog;
    frmInfoView.linkGetMessages.Enabled := True;
  end;
end;

procedure TForm1.DownloadSMS(msgType: Integer; memLocation: String; var sl: TStringList; MarkAsNew: boolean);
var
  ARef, ATot, An: Integer;
  i, memType: Integer;
  header,pdu: String;
  ml: TStringList;
  AsNew: boolean;
begin
  if frmInfoView.Visible then EBCAState(False); // disable EBCA to avoid unsolicited msg
  if memLocation = 'ME' then memType := 1 // do not localize
    else memType := 2;
  try
    ml := TStringList.Create;
    try
      {
      <msgType> Description
      0 Received unread (new) message Default setting
      1 Received read message
      2 Stored unread message (only applicable to SMs)
      3 Stored sent message (only applicable to SMs)
      4 All messages
      16 Template message
      }
      TxAndWait('AT+CPMS="' + memLocation + '"'); // do not localize
      TxAndWait('AT+CMGL=' + IntToStr(msgType)); // do not localize
      ml.Text := ThreadSafe.RxBuffer.Text;
      for i := 0 to ml.Count - 1 do begin
        if pos('+CMGL', ml[i]) = 1 then begin // do not localize
          header := Trim(copy(ml[i], 8, length(ml[i])));
          pdu := ml[i+1];
          AsNew := MarkAsNew;
          if AsNew then begin
            GSMLongMsgData(pdu, ARef, ATot, An);
            { Do not mark as New long SMS entries, except the first one }
            if (ATot > 1) and (An <> 1) then
              AsNew := False;
          end;
          sl.Add(IntToStr(memType) + ',' + header + ',' + pdu + ',,' + IntToStr(byte(AsNew)));
        end;
      end;
    finally
      ml.Free;
    end;
  except
    Status(_('Error downloading SMS'));
  end;
  if frmInfoView.Visible then EBCAState(True);
end;

procedure TForm1.DownloadSMS(msgType: Integer; var sl: TStringList);
begin
  try
    DownloadSMS(msgType, 'SM', sl); // do not localize
    DownloadSMS(msgType, 'ME', sl); // do not localize
  except
    Status(_('Error Downloading SMS'));
  end;
end;

procedure TForm1.ShowExplorer1Click(Sender: TObject);
begin
  ActionConnectionExplorer.Execute;
end;

procedure TForm1.RepairPhoneDataFiles(ID: string);
var
  FullPath: String;
  sl: TStringList;
  frmStatusDlg: TfrmStatusDlg;
  procedure FixDB_SMS(Filename: string);
  begin
    Log.AddMessage('Fix DB: Checking database '+Filename, lsDebug); // do not localize debug
    sl.LoadFromFile(FullPath + Filename);
    frmMsgView.RenderListView(sl);
    frmMsgView.CleanupDatabase(False,not FArchiveDublicates);
    sl.SaveToFile(FullPath + Filename);
  end;
  procedure ScanSMSFolder(Root: PVirtualNode);
  var
    Data: PFmaExplorerNode;
    Node: PVirtualNode;
  begin
    Node := ExplorerNew.GetFirstChild(Root);
    while Assigned(Node) do begin
      { Process node's database }
      Data := ExplorerNew.GetNodeData(Node);
      if Data.StateIndex = FmaSMSSubFolderFlag then begin
        Log.AddMessage('Fix DB: Checking user folder '+Data.Text, lsDebug); // do not localize debug
        sl.Assign(TStringList(Data.Data));
        frmMsgView.RenderListView(sl);
        frmMsgView.CleanupDatabase(False,not FArchiveDublicates);
        TStringList(Data.Data).Assign(sl);
      end;
      { Process node's children }
      ScanSMSFolder(Node);
      Node := ExplorerNew.GetNextSibling(Node);
    end;
  end;
begin
  if FConnected or FConnectingStarted then
    { Perform repair only in Offline mode }
    exit;
  FullPath := GetProfilePath(ID)+'dat\'; // do not localize
  if not FileExists(FullPath+'Phone.dat') then exit; // do not localize
  { Go to top node in order to hide all special frames }
  SetExplorerNode(ExplorerNew.GetFirst);
  frmStatusDlg := ShowStatusDlg(_('Repairing Database...'),poMainFormCenter);
  sl := TStringList.Create;
  try
    Enabled := False;
    LoadingDBFiles := True;
    Log.AddMessage('Database: Repair started', lsDebug); // do not localize debug

    { Cleanup standard SMS Folders }
    FixDB_SMS('SMSInbox.dat'); // do not localize
    FixDB_SMS('SMSOutbox.dat'); // do not localize
    FixDB_SMS('SMSSent.dat'); // do not localize
    FixDB_SMS('SMSDrafts.dat'); // do not localize
    FixDB_SMS('SMSArchive.dat'); // do not localize

    { Cleanup user-defined SMS Folders }
    LoadUserFoldersData(FullPath,False);
    try
      ScanSMSFolder(FNodeMsgRoot);
    finally
      SaveUserFoldersData(FullPath);
    end;

    { TODO: Fix other databases too }
        
  finally
    Enabled := True;
    Log.AddMessage('Database: Repair finished', lsDebug); // do not localize debug
    LoadingDBFiles := False;
    sl.Free;
    FreeAndNil(frmStatusDlg);
  end;
end;

function TForm1.LoadPhoneDataFiles(ID: string; ShowStatus,ShowProgress: Boolean): boolean;
var
  Fullpath: string;
  FDirID: TItemIDList;
  PDirID: PItemIDList;
  i: integer;
  fo: TSHFileOpStructW;
  sl: TStringList;
  db: TStrings;
  data: PFmaExplorerNode;
  w,OldStat: WideString;
  s: String;
  NewProfile: Boolean;
  procedure ProgressNotify;
  begin
    if Assigned(frmSplash) then
      frmSplash.SEProgress1.Position := frmSplash.SEProgress1.Position + 1;
    if ShowProgress and Visible then
      SetTaskPercentageInc;
  end;
begin
  Result := True;
  { First, save any local changes, if any }
  SavePhoneDataFiles(ShowStatus);

  if ShowStatus and Visible then begin
    OldStat := GetStatus;
    Status(_('Clearing current views...'));
    Update;
  end;
  if ShowProgress and Visible then
    SetTaskPercentage(0,13);

  { Second, clear all FMA views if profile changed }
  NewProfile := AnsiCompareStr(ID,PhoneIdentity) <> 0;
  if NewProfile then ClearExplorerViews;

  { Finally, load new database. Fullpath will contain the selected database path through upgrade checks below }
  Fullpath := ExePath;

  { If ID is not specified use current setting }
  if ID = '' then ID := PhoneIdentity;

  if FindCmdLineSwitch('MIGRATEDB') then begin // do not localize
    { Do we have phone ID at all? It depends on Fma version }
    if ID <> '' then begin
      { Should we upgrade from single database? -- Obsolete, but keep for backward compatability! }
      if FileExists(ExePath+'Phone.dat') and not FileExists(GetProfilePath(ID)+'dat\Phone.dat') then // do not localize
        try
          { Create new profile database and migrate single db files }
          Status(_('Upgrading phone profile database...'));
          Log.AddMessage('Database: Upgrading from single database', lsDebug); // do not localize debug
          { Create profile dir if needed }
          Fullpath := GetProfilePath(ID)+'dat\'; // do not localize
          ForceDirectories(Fullpath);
          { Move database, old files will be deleted on next SaveData call }
          CopyFile(PChar(string(ExePath) + 'Phone.dat'),PChar(Fullpath + 'Phone.dat'),True); // do not localize
          CopyFile(PChar(string(ExePath) + 'SMSInbox.dat'),PChar(Fullpath + 'SMSInbox.dat'),True); // do not localize
          CopyFile(PChar(string(ExePath) + 'SMSIncoming.dat'),PChar(Fullpath + 'SMSIncoming.dat'),True); // do not localize
          CopyFile(PChar(string(ExePath) + 'SMSIncoming.Index.dat'),PChar(Fullpath + 'SMSIncoming.Index.dat'),True); // do not localize
          CopyFile(PChar(string(ExePath) + 'SMSOutbox.dat'),PChar(Fullpath + 'SMSOutbox.dat'),True); // do not localize
          CopyFile(PChar(string(ExePath) + 'SMSSent.dat'),PChar(Fullpath + 'SMSSent.dat'),True); // do not localize
          CopyFile(PChar(string(ExePath) + 'SMSArchive.dat'),PChar(Fullpath + 'SMSArchive.dat'),True); // do not localize
          CopyFile(PChar(string(ExePath) + 'SMSDrafts.dat'),PChar(Fullpath + 'SMSDrafts.dat'),True); // do not localize
          CopyFile(PChar(string(ExePath) + 'Contacts.ME.dat'),PChar(Fullpath + 'Contacts.ME.dat'),True); // do not localize
          CopyFile(PChar(string(ExePath) + 'Contacts.SM.dat'),PChar(Fullpath + 'Contacts.SM.dat'),True); // do not localize
          CopyFile(PChar(string(ExePath) + 'Contacts.SYNC.dat'),PChar(Fullpath + 'Contacts.SYNC.dat'),True); // do not localize
          CopyFile(PChar(string(ExePath) + 'Contacts.SYNCMAX.dat'),PChar(Fullpath + 'Contacts.SYNCMAX.dat'),True); // do not localize
          CopyFile(PChar(string(ExePath) + 'Calendar.vcs'),PChar(Fullpath + 'Calendar.vcs'),True); // do not localize
          CopyFile(PChar(string(ExePath) + 'Calendar.SYNC.dat'),PChar(Fullpath + 'Calendar.SYNC.dat'),True); // do not localize
          CopyFile(PChar(string(ExePath) + 'Bookmarks.dat'),PChar(Fullpath + 'Bookmarks.dat'),True); // do not localize
          CopyFile(PChar(string(ExePath) + 'Bookmarks.SYNC.dat'),PChar(Fullpath + 'Bookmarks.SYNC.dat'),True); // do not localize
          CopyFile(PChar(string(ExePath) + 'CallNotes.dat'),PChar(Fullpath + 'CallNotes.dat'),True); // do not localize
          CopyFile(PChar(string(ExePath) + 'ContactSync.xml'),PChar(Fullpath + 'ContactSync.xml'),True); // do not localize
          CopyFile(PChar(string(ExePath) + 'UserFolders.dat'),PChar(Fullpath + 'UserFolders.dat'),True); // do not localize
          Log.AddMessage('Database: Upgrade completed', lsDebug); // do not localize debug
        except
        end;

      { Should we migrate database from "FMA\data" to "AppData\FMA" folder? }
      if DirectoryExists(ExePath+'data\'+ID) then begin
        { Get OLD database storage folder \data\ - as of Fma 0.1.x and 2.0.x releases }
        Fullpath := ExePath+'data\'+ID+'\dat\'; // do not localize
        if not FRelocateDBDenied then begin
          if MessageDlgW(WideFormat(_('Do you wish to Relocate database "%s" to FMA Application Data folder? '+       // do not localize
            '(Recommended)'+sLinebreak+sLinebreak+'Note: If you are not sure or if you do not have administrative '+  // do not localize
            'account on this computer, click Yes.'), [ID]), mtConfirmation, MB_YESNO) = ID_YES then begin             // do not localize
            { Copy all DB files to ApplicationData folder }
            Status(_('Relocating phone profile database...'));
            Log.AddMessage('Database: Moving database to user''s Application Data folder', lsDebug); // do not localize debug
            { Create FMA subfolder under Application Data - a base dir for GetProfilePath subdirs,
              also required for SHFileOperationW call below, or it will fail }
            ForceDirectories(GetAppDataPath+'FMA'); // do not localize
            { Move database }
            repeat
              WaitASec;
              fo.Wnd := Handle;
              { Copies the files specified by pFrom to the location specified by pTo.
                Use Copy instead of Move operation, so we could rollback changes (see bellow) }
              fo.wFunc := FO_MOVE;
              { Pointer to a buffer that specifies one or more source file names. Multiple names must be null-separated.
                The list of names must be double null-terminated. }
              fo.pFrom := PWideChar(LongStringToWideString(string(ExePath)+'data\'+ID+#0#0)); // do not localize
              { Pointer to a buffer that contains the name of the destination file or directory. The buffer can contain
                mutiple destination file names if the fFlags member specifies FOF_MULTIDESTFILES. Multiple names must be
                null-separated. The list of names must be double null-terminated. }
              fo.pTo := PWideChar(LongStringToWideString(GetAppDataPath+'FMA\'#0#0)); // do not localize
              fo.fFlags := FOF_NOCONFIRMATION or FOF_NOCONFIRMMKDIR or FOF_SIMPLEPROGRESS or FOF_ALLOWUNDO or FOF_NOERRORUI;
              fo.lpszProgressTitle := PWideChar(_('Relocating FMA Database...'));
              if (SHFileOperationW(fo) = 0) and not fo.fAnyOperationsAborted then
                break; // success
              Application.BringToFront;
              if MessageDlgW(
                _('Some database files are in use. Please close any applicatiions that might cause this and click OK to continue.'),
                mtInformation, MB_OKCANCEL) = ID_CANCEL then begin
                // failure - do not fail but allow usage of old database
                // raise EInOutError.Create(_('Could not relocate FMA database'));
                fo.fAnyOperationsAborted := True; { just in case }
                break;
              end;
            until False;
            (*
            { Delete old database? }
            if fo.wFunc = FO_COPY then begin
              { Deletes the files specified by pFrom which points the old database (pTo is ignored). }
              fo.wFunc := FO_DELETE;
              fo.pTo := PWideChar(LongStringToWideString(#0#0));
              { Should we rollback? }
              if fo.fAnyOperationsAborted then begin
                { On failure rollback changes i.e. remove any partialy copied new database }
                fo.pFrom := PWideChar(w);
              end;
              fo.fFlags := FOF_NOCONFIRMATION or FOF_NOCONFIRMMKDIR or FOF_SIMPLEPROGRESS or FOF_NOERRORUI; { removed FOF_ALLOWUNDO }
              SHFileOperationW(fo);
            end;
            *)
            Application.BringToFront;
            Status('');
            Log.AddMessage('Database: Moving database completed', lsDebug); // do not localize debug
          end
          else
            FRelocateDBDenied := True;
        end;
      end
      else begin
        { Folder "FMA\data" do not exists, so create "AppData\FMA" by default }
        ForceDirectories(GetAppDataPath+'FMA\'+ID+'\dat'); // do not localize
      end;

      { Use database in AppData folder? }
      w := GetAppDataPath+'FMA\'+ID+'\dat'; // do not localize
      if DirectoryExists(w) then Fullpath := w+'\'; 
    end;
  end
  else begin
    { New fixed setting since FMA 2.1 Beta 3a }
    Fullpath := GetProfilePath(ID)+'dat\'; // do not localize
  end;

  if not NewProfile or OpenPhoneDataFiles(ID) then begin
    { clear contact lookup cache }
    FLookupList.Clear;
  end
  else
    Abort; // exit now!

  { Loading data files...
    Fullpath contains the right database path now }
  if ShowStatus and Visible then begin
    Status(_('Loading phone profile...'));
    Update;
  end;
  Log.AddMessage('Database: '+Fullpath, lsDebug); // do not localize debug
  LoadingDBFiles := True;
  try
    Log.AddMessage('Database: Loading Profile Settings', lsDebug); // do not localize debug
    with TIniFile.Create(Fullpath + 'Phone.dat') do // do not localize
      try
        { For default settings please check out uOptions.pas }
        FSelPhone := UTF8StringToWideString(ReadString('Global','PhoneName','')); // do not localize
        w := FSelPhone;
        i := 1;
        while not PhoneUnique(w,ID) do
          w := WideFormat('%s (%d)',[FSelPhone,i]); // rename dublicated phone names
        if WideCompareStr(w,FSelPhone) <> 0 then begin
          FSelPhone := w;
          WriteString('Global','PhoneName',WideStringToUTF8String(FSelPhone)); // do not localize
        end;
        FDatabaseVersion := UTF8StringToWideString(ReadString('Global','DBVersion','')); // do not localize
        FPhoneModel := UTF8StringToWideString(ReadString('Global','PhoneBrand','')); // do not localize
        FSMSCounterReseted := ReadBool('SMS','Reset',False); // do not localize
        FSMSCounterResetDay := ReadInteger('SMS','Reset Day',1); // do not localize
        FSMSCounterResetLastMonth := ReadInteger('SMS','Reset Last Month',0); // do not localize
        FSMSCounter := ReadInteger('SMS','Count',0); // do not localize
        FSMSWarning := ReadInteger('SMS','Warning',10); // do not localize
        FOutlookCategories := UTF8StringToWideString(ReadString('Outlook','Categories','')); // do not localize
        FSelectedOutlookContactFolders := UTF8StringToWideString(ReadString('Outlook','ContactsFolder','DEFAULT')); // do not localize
        FOutlookNewContactsFolder := UTF8StringToWideString(ReadString('Outlook','NewContactsFolder','')); // do not localize
        FSelectedOutlookCalendarFolders := UTF8StringToWideString(ReadString('Outlook','CalendarFolder','DEFAULT')); // do not localize
        FOutlookNewCalendarFolder := UTF8StringToWideString(ReadString('Outlook','NewCalendarFolder','')); // do not localize
        FSelectedOutlookTaskFolders := UTF8StringToWideString(ReadString('Outlook','TasksFolder','DEFAULT')); // do not localize
        FOutlookNewTasksFolder := UTF8StringToWideString(ReadString('Outlook','NewTasksFolder','')); // do not localize
        FOutlookFieldMappings := UTF8StringToWideString(ReadString('Outlook','FieldMappings',''));  // do not localize
        FBookmarkRootFolder := ReadString('Bookmarks','Root',''); // do not localize
        if FBookmarkRootFolder = '' then
        try
          { Get default Favories folder }
          SetLength(FBookmarkRootFolder,MAX_PATH);
          PDirID := @FDirID;
          SHGetSpecialFolderLocation(Application.Handle,CSIDL_FAVORITES,PDirID);
          SHGetPathFromIDList(PDirID,@FBookmarkRootFolder[1]);
          FBookmarkRootFolder := StrPas(@FBookmarkRootFolder[1]);
        except
          FBookmarkRootFolder := '';
        end;
        FSyncBookmarksIE := ReadBool('Bookmarks','IE',False); // do not localize
        FSyncBookmarksFirefox := ReadBool('Bookmarks','Firefox',False); // do not localize
        FSyncBookmarksOpera := ReadBool('Bookmarks','Opera',False); // do not localize
        sl := TStringList.Create;
        try
          FFavoriteRecipients.Clear;
          ReadSectionValues('Favorites SMS',sl); // do not localize
          for i := 0 to sl.Count-1 do
            FFavoriteRecipients.Add(UTF8StringToWideString(sl.Values[sl.Names[i]]));
          FFavoriteCalls.Clear;
          ReadSectionValues('Favorites Call',sl); // do not localize
          for i := 0 to sl.Count-1 do
            FFavoriteCalls.Add(UTF8StringToWideString(sl.Values[sl.Names[i]]));
          FDeliveryRules.Clear;
          ReadSectionValues('Delivery Rules',sl); // do not localize
          for i := 0 to sl.Count-1 do
            FDeliveryRules.Add(UTF8StringToWideString(sl.Values[sl.Names[i]]));
        finally
          sl.Free;
        end;
        FChatNick := UTF8StringToWideString(ReadString('Chat','Nick',DefaultChatNick)); // do not localize
        FChatLongSMS := ReadBool('Chat','Long SMS',False); // do not localize
        FChatBold := ReadBool('Chat','Bold Font',False); // do not localize
        frmSyncPhonebook.FMaxRecME := ReadInteger('Contacts','PBMax',frmSyncPhonebook.FMaxRecME);  // do not localize
        frmSyncPhonebook.FMaxNameLen := ReadInteger('Contacts','PBMaxName',frmSyncPhonebook.FMaxNameLen);  // do not localize
        frmSyncPhonebook.FMaxTelLen := ReadInteger('Contacts','PBMaxTel',frmSyncPhonebook.FMaxTelLen);  // do not localize
        frmSyncPhonebook.FMaxTitleLen := ReadInteger('Contacts','PBMaxTitle',frmSyncPhonebook.FMaxTitleLen);  // do not localize
        frmSyncPhonebook.FMaxOrgLen := ReadInteger('Contacts','PBMaxOrg',frmSyncPhonebook.FMaxOrgLen);  // do not localize
        frmSyncPhonebook.FMaxMailLen := ReadInteger('Contacts','PBMaxMail',frmSyncPhonebook.FMaxMailLen);  // do not localize
        frmMEEdit.FMaxNumbers := ReadInteger('Contacts','MEMax',frmMEEdit.FMaxNumbers);  // do not localize
        frmMEEdit.FMaxNameLen := ReadInteger('Contacts','MEMaxName',frmMEEdit.FMaxNameLen);  // do not localize
        frmMEEdit.FMaxTelLen := ReadInteger('Contacts','MEMaxTel',frmMEEdit.FMaxTelLen);  // do not localize
        frmSMEdit.FMaxNumbers := ReadInteger('Contacts','SMMax',frmSMEdit.FMaxNumbers);  // do not localize
        frmSMEdit.FMaxNameLen := ReadInteger('Contacts','MEMaxName',frmSMEdit.FMaxNameLen);  // do not localize
        frmSMEdit.FMaxTelLen := ReadInteger('Contacts','MEMaxTel',frmSMEdit.FMaxTelLen);  // do not localize
        s := ReadString('Connection','COM',ComPort.Port); // do not localize
        if not FConnected and not FConnectingStarted then begin
          with TComComboBox.Create(nil) do
          try
            Visible := False;
            Parent := Self;
            ComPort := Self.ComPort;
            ComProperty := cpPort;
            if (Items.Count <> 0) and (Items.IndexOf(s) = -1) and (ThreadSafe.ConnectionType = 2) then begin
              { Ignore obsolete com ports stored in profile DB }
              w := WideFormat(_('Please select a COM port in Options | Connectivity prior connecting to %s.'),[FSelPhone]);
              if FAppInitialized then
                ShowBaloonError(w)
              else
                MessageDlgW(w,mtError,MB_OK);
            end
            else
              ComPort.Port := s;
          finally
            Free;
          end;
        end;
      finally
        Free;
      end;
  except
    Result := False;
  end;
  ProgressNotify;
  try
    Log.AddMessage('Database: Loading Incoming Messages', lsDebug); // do not localize debug
    FNewPDUList.LoadFromFile(Fullpath + 'SMSIncoming.dat'); // do not localize
    FNewMessageList.LoadFromFile(Fullpath + 'SMSIncoming.Index.dat'); // do not localize
  except
    Result := False;
  end;
  ProgressNotify;
  try
    Log.AddMessage('Database: Loading Phone Book', lsDebug); // do not localize debug
    data := ExplorerNew.GetNodeData(FNodeContactsME);
    db := TStrings(data.Data);
    db.Clear;
    db.LoadFromFile(Fullpath + 'Contacts.ME.dat'); // do not localize
    RenderContactList(FNodeContactsME);
    if frmMEEdit.RenderData(FNodeContactsME) then begin // DB corrupted and modified?
      ParsePhonebookListFromEditor(FNodeContactsME);
      RenderContactList(FNodeContactsME);
    end;
  except
    Result := False;
  end;
  ProgressNotify;
  try
    Log.AddMessage('Database: Loading SIM Card Book', lsDebug); // do not localize debug
    data := ExplorerNew.GetNodeData(FNodeContactsSM);
    db := TStrings(data.Data);
    db.Clear;
    db.LoadFromFile(Fullpath + 'Contacts.SM.dat'); // do not localize
    RenderContactList(FNodeContactsSM);
    if frmSMEdit.RenderData(FNodeContactsSM) then begin // DB corrupted and modified?
      ParsePhonebookListFromEditor(FNodeContactsSM);
      RenderContactList(FNodeContactsSM);
    end;
  except
    Result := False;
  end;
  ProgressNotify;
  try
    Log.AddMessage('Database: Loading Bookmarks', lsDebug); // do not localize debug
    frmSyncBookmarks.LoadBookmarks(Fullpath + 'Bookmarks.dat'); // do not localize
    RenderBookmarkList(FNodeBookmarks);
  except
    Result := False;
  end;
  ProgressNotify;
  try
    Log.AddMessage('Database: Loading Phone Contacts', lsDebug); // do not localize debug
    frmSyncPhonebook.LoadContacts(Fullpath + 'Contacts.SYNC.dat'); // do not localize
    data := ExplorerNew.GetNodeData(FNodeContactsME);
    db := TStrings(data.Data);
    if db.Count = 0 then begin
      { Contacts ME database not used, so use IrmcSync database to render explorer tree }
      ParsePhonebookListFromSync(db);
      RenderContactList(FNodeContactsME);
    end;
  except
    Result := False;
  end;
  ProgressNotify;
  try
    Log.AddMessage('Database: Loading Phone Calendar', lsDebug); // do not localize debug
    frmCalendarView.LoadCalendar(Fullpath + 'Calendar.vcs'); // do not localize
  except
    Result := False;
  end;
  ProgressNotify;
  { Text Message Folders should be loaded after Contacts, because they do
    lookups to find senders name in Contacts. }
  try
    Log.AddMessage('Database: Loading SMS Inbox', lsDebug); // do not localize debug
    data := ExplorerNew.GetNodeData(FNodeMsgInbox);
    TStrings(data.Data).Clear;
    TStrings(data.Data).LoadFromFile(Fullpath + 'SMSInbox.dat'); // do not localize
    UpdateNewMessagesCounter(FNodeMsgInbox);
  except
    Result := False;
  end;
  ProgressNotify;
  try
    Log.AddMessage('Database: Loading SMS Outbox', lsDebug); // do not localize debug
    data := ExplorerNew.GetNodeData(FNodeMsgOutbox);
    TStrings(data.Data).Clear;
    TStrings(data.Data).LoadFromFile(Fullpath + 'SMSOutbox.dat'); // do not localize
    DoCleanupOutbox;
    UpdateNewMessagesCounter(FNodeMsgOutbox);
  except
    Result := False;
  end;
  ProgressNotify;
  try
    Log.AddMessage('Database: Loading SMS Sent Items', lsDebug); // do not localize debug
    data := ExplorerNew.GetNodeData(FNodeMsgSent);
    TStrings(data.Data).Clear;
    TStrings(data.Data).LoadFromFile(Fullpath + 'SMSSent.dat'); // do not localize
    UpdateNewMessagesCounter(FNodeMsgSent);
  except
    Result := False;
  end;
  ProgressNotify;
  try
    Log.AddMessage('Database: Loading SMS Archive', lsDebug); // do not localize debug
    data := ExplorerNew.GetNodeData(FNodeMsgArchive);
    TStrings(data.Data).Clear;
    TStrings(data.Data).LoadFromFile(Fullpath + 'SMSArchive.dat'); // do not localize
    UpdateNewMessagesCounter(FNodeMsgArchive);
  except
    Result := False;
  end;
  ProgressNotify;
  try
    Log.AddMessage('Database: Loading SMS Drafts', lsDebug); // do not localize debug
    data := ExplorerNew.GetNodeData(FNodeMsgDrafts);
    TStrings(data.Data).Clear;
    TStrings(data.Data).LoadFromFile(Fullpath + 'SMSDrafts.dat'); // do not localize
    UpdateNewMessagesCounter(FNodeMsgDrafts);
  except
    Result := False;
  end;
  ProgressNotify;
  try
    Log.AddMessage('Database: Loading User Folders', lsDebug); // do not localize debug
    LoadUserFoldersData(Fullpath);
  except
    Result := False;
  end;
  ProgressNotify;
  { Database files loaded }
  LoadingDBFiles := False;
  FDatabaseLoaded := True;
  if (Pos(ExePath,Fullpath) = 0) and (FDatabaseVersion = '') then
    FDatabaseVersion := GetToken(GetBuildVersionDtl,0,' '); // set db version field if it's empty
  { Remember last open database }
  PhoneIdentity := ID;
  { Update view }
  data := ExplorerNew.GetNodeData(ExplorerNew.GetFirst);
  if Assigned(data) then begin
    if FSelPhone = '' then FSelPhone := _('My Phone');
    data.Text := FSelPhone;
    ExplorerNew.Repaint;
    Caption := WideFormat(_('floAt''s Mobile Agent %s - [%s]'),[GetBuildVersionDtl,data.Text]);
  end;
  ExplorerNewChange(ExplorerNew,ExplorerNew.FocusedNode);

  if ShowProgress and Visible then
    SetTaskPercentage(-1);
  if ShowStatus and Visible then
    Status(OldStat,False);
end;

function TForm1.CanShowProgress: boolean;
begin
  Result := not FDontProgress and (not FProgressRestoredOnly or
    (FormStorage1.StoredValue['StartMinimized'] = False)); // do not localize
end;

function TForm1.ExplorerFindExtImage(Ext: string): integer;
begin
  if (Ext = '.thm') then begin // do not localize
    Result := 27
  end else
  if (Ext = '.amr') then begin // do not localize
    Result := 38;
  end else
  if (Ext = '.mid') or (Ext = '.imy') then begin // do not localize
    Result := 36;
  end else
  if (Ext = '.gif') or (Ext = '.jpg') or (Ext = '.wbm') or (Ext = '.wbmp') then begin // do not localize
    Result := 37;
  end else
    Result := -1;
end;

procedure TForm1.DoProximityTest;
var
  ps: TProximityOptions;
begin
  Log.AddMessage('Testing proximity detection...', lsDebug); // do not localize debug
  ps := FProximityOptions;
  with frmOptions, FProximityOptions do begin
    AwayLock := cbProximityLock.Checked;
    AwayMusicMode := rgProximityAway.ItemIndex;
    NearUnlock := cbProximityUnlock.Checked;
    NearMusicMode := rgProximityNear.ItemIndex;
  end;
  try
    DoProximityAway;
    try
      Log.AddMessage('Proximity detection: Sleeping 5 seconds...', lsDebug); // do not localize debug
      WaitASec(5);
    finally
      DoProximityNear;
    end;
  finally
    FProximityOptions := ps;
  end;
end;

procedure TForm1.DoDisconnectTemporary;
begin
  FTemporaryOffline := True;
  { remember re-connect state }
  FLastReconnect := ActionConnectionMonitor.Checked;
  ActionConnectionDisconnect.Execute;
  WaitASec(10);
  { allow auto re-connect }
  ActionConnectionMonitor.Checked := True;
  ActionConnectionMonitor.Tag := 1;
end;

procedure TForm1.RequestConnection(DoNotRefreshView: boolean);
begin
  FDoNotRefreshViewOnConnect := DoNotRefreshView;
  if not FConnected then ActionConnectionConnect.Execute;
  if not FConnected then Abort;
end;

procedure TForm1.ActionViewMsgPreviewUpdate(Sender: TObject);
begin
  if (frmMsgView <> nil) and frmMsgView.Visible then begin
    ActionViewMsgPreview.Enabled := True;
    ActionViewMsgPreview.Checked := frmMsgView.PreviewPanel.Visible;
  end
  else
    ActionViewMsgPreview.Enabled := False;
end;

procedure TForm1.ActionViewMsgPreviewExecute(Sender: TObject);
begin
  ActionViewMsgPreview.Checked := not ActionViewMsgPreview.Checked;
  UpdateMessagePreview;
end;

procedure TForm1.UpdateMessagePreview;
begin
  frmMsgView.PreviewPanel.Visible := ActionViewMsgPreview.Checked;
  frmMsgView.Splitter2.Visible := ActionViewMsgPreview.Checked;
  if frmMsgView.Splitter2.Visible then
    frmMsgView.Splitter2.Top := frmMsgView.PreviewPanel.Top-1;
  if frmMsgView.Visible then frmMsgView.ListMsgChange(nil,nil);
end;

procedure TForm1.InitCalls;
begin
  if Assigned(FNodeCalls) then
  try
    if frmInfoView.Visible then EBCAState(False);
    InitCalls(fnodecallsIn);
    InitCalls(fnodecallsOut);
    InitCalls(fnodecallsMissed);
    if frmInfoView.Visible then EBCAState(True);
    ExplorerNew.Expanded[FNodeCalls] := true;
  except
    Log.AddMessage('Error getting Calls', lsDebug); // do not localize debug
  end;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
const
  UnsentCount: integer = 0;
  KeybCheck: integer = 0;
  ProximityCheck: integer = 0;
  TwoSecs: boolean = False;
  UpdateChecked: boolean = False;
  WelcomeChecked: boolean = False;
  ConnectChecked: boolean = False;
  ProximitySaveTimeout: Cardinal = 0;
var
  i: integer;
  IsLocked: boolean;
  EData: PFmaExplorerNode;
  function DoWebUpdate: boolean;
  begin
    Result := False;
    if not FJustWebUpdated then
      try
        { now check for appliaction update }
        CheckforUpdate1.Enabled := False;
        try
          Update;
          FmaWebUpdate1.NewUpdateExists(GetBuildVersion,wuWizardOnUpdate);
          Result := True;
        finally
          CheckforUpdate1.Enabled := True;
        end;
      except
      end;
  end;
begin
  if not FAppInitialized or not Timer1.Enabled then exit;
  
  Timer2.Enabled := False;
  Timer2.Interval := 1000;
  TwoSecs := not TwoSecs;
  if Application.Terminated then
    exit;
  try
    { On every second... }
    if (ActionMissedCalls <> nil) and (ActionMissedCalls.Enabled) then begin
      if ActionMissedCalls.ImageIndex = 16 then
        ActionMissedCalls.ImageIndex := 36
      else
        ActionMissedCalls.ImageIndex := 16;
    end;
    if FConnected and FConnectingComplete and Assigned(FObex) and not FObex.Connected and Assigned(ThreadSafe) and
      not ThreadSafe.ObexConnecting and not ThreadSafe.Busy and not FSendingMessage then
      { Any new messages pending for retrieval from phone? }
      if FNewMessageList.Count <> 0 then begin
        { yes, retrieve new messages }
        Log.AddCommunicationMessage('SMS: New message receive signaled', lsDebug); // do not localize debug
        if FMsgM then begin
          if not FSendingMessage then begin
            Status(_('Retrieving messages from phone...'));
            try
              RetrieveNewSMS(FNewMessageList[0]);
            finally
              FNewMessageList.Delete(0);
            end;
          end;
        end
        else
          Status(_('New message received in phone'));
      end
      else
      if (LastSMSReceiveFailure = 0) or (((Now - LastSMSReceiveFailure) * SecsPerDay) >= 30) then begin
        { perform Inbox check in online mode :) }
        try
          DoProcessInbox;
          if FNewPDUList.Count <> 0 then
            Abort
          else
            LastSMSReceiveFailure := 0;
        except
          if LastSMSReceiveFailure = 0 then
            Log.AddMessage('SMS: Receiving disabled temporary', lsDebug); // do not localize debug
          LastSMSReceiveFailure := Now;
        end;
      end;
    { On every 2 seconds... }
    if TwoSecs and Assigned(FObex) and not FObex.Connected and Assigned(ThreadSafe) and not ThreadSafe.ObexConnecting and
      not ThreadSafe.Busy and (not Assigned(frmCalling) or (not frmCalling.IsCalling and not frmCalling.IsTalking)) and
      not FSendingMessage then begin

      { count up to 3 x 2 seconds }
      inc(KeybCheck);
      if KeybCheck > 3 then KeybCheck := 1;

      { count up to 10 x 2 seconds }
      inc(ProximityCheck);
      if ProximityCheck > 10 then ProximityCheck := 1;

      if IsStartCompleted and (IsScriptInitialized or not FUseScript) and
        ActionConnectionAutoConnect.Checked and (ActionConnectionAutoConnect.Tag = 0) then begin
        { will wait until script is initialized before perform connect on startup }
        try
          RequestConnection;
        finally
          { Connect on startup succeeded or Aborted by user }
          ActionConnectionAutoConnect.Tag := byte(FConnected or ThreadSafe.AbortDetected);
        end;
      end
      else
      if not FConnected then begin
        if ActionConnectionMonitor.Checked and (ActionConnectionMonitor.Tag = 1) then begin
          { Proximity - Check if phone is back near PC }
          if ProximityCheck = 1 then begin // every 20 seconds 
            Log.AddMessage('Auto-connect: Searching for phone...', lsDebug); // do not localize debug
            { set custom timeout value which is quite low to perform fast check. }
            ProximitySaveTimeout := ThreadSafe.InactivityTimeout;
            ThreadSafe.InactivityTimeout := 2000;
            try
              ActionConnectionConnect.Execute;
            finally
              ThreadSafe.InactivityTimeout := ProximitySaveTimeout;
              Log.AddMessage('Auto-connect: Search completed', lsDebug); // do not localize debug
            end;
          end;
        end;
      end;
      { show Getting Started on first run }
      if not ConnectChecked then
        if not FConnected then
          { yes, but if Connect on startup is active, wait for connection to be established... }
          if not ActionConnectionAutoConnect.Checked or (ActionConnectionAutoConnect.Tag <> 0) then
            { also wait while Splash is visible, wait until App is initialized and restored }
            if IsStartCompleted then
              if FormStorage1.StoredValue['First Run'] = True then begin  // do not localize
                if FormStorage1.StoredValue['StartMinimized'] = False then begin
                  ConnectChecked := True;
                  if InitNewPhone(True) then
                    { Above True = result value is whether Dont Show checkbox is set or not }
                    FormStorage1.StoredValue['First Run'] := False;
                end;
              end
              else
                ConnectChecked := True;
      { show Welcome Tips on startup }
      if not WelcomeChecked then
        if not FConnected then
          { yes, but if Connect on startup is active, wait for connection to be established... }
          if not ActionConnectionAutoConnect.Checked or (ActionConnectionAutoConnect.Tag <> 0) then
            { also wait while Splash is visible, wait until App is initialized and restored }
            if IsStartCompleted then
              if FormStorage1.StoredValue['Welcome Tips'] = True then begin  // do not localize
                if FormStorage1.StoredValue['StartMinimized'] = False then begin // do not localize
                  WelcomeChecked := True;
                  if frmWelcomeTips.QueuedCount <> 0 then frmWelcomeTips.Show;
                end;
              end
              else
                WelcomeChecked := True;
      { check for new version on startup }
      if not UpdateChecked then
        if not FConnected then
          { yes, but if Connect on startup is active, wait for connection to be established... }
          if not ActionConnectionAutoConnect.Checked or (ActionConnectionAutoConnect.Tag <> 0) then
            { also wait while Splash is visible, wait until App is initialized }
            if IsStartCompleted then begin
              UpdateChecked := True; // do it only once
              case FAutoWebUpdateMode of
                { 0 means disabled }
                1: begin // on startup
                     DoWebUpdate;
                   end;
                2: begin // daily
                     if (DayOfWeek(Date) <> DayOfWeek(FLastWebUpdateDate)) or
                       (WeekOfTheMonth(Date) <> WeekOfTheMonth(FLastWebUpdateDate)) or
                       (MonthOfTheYear(Date) <> MonthOfTheYear(FLastWebUpdateDate)) then
                       if DoWebUpdate then begin
                         FLastWebUpdateDate := Date;
                         FormStorage1.StoredValue['Web Update Date'] := Double(FLastWebUpdateDate); // do not localize
                       end;
                   end;
                3: begin // weekly
                     if (WeekOfTheMonth(Date) <> WeekOfTheMonth(FLastWebUpdateDate)) or
                       (MonthOfTheYear(Date) <> MonthOfTheYear(FLastWebUpdateDate)) then
                       if DoWebUpdate then begin
                         FLastWebUpdateDate := Date;
                         FormStorage1.StoredValue['Web Update Date'] := Double(FLastWebUpdateDate); // do not localize
                       end;
                   end;
              end;
            end;
      { should we perform Outbox check now? }
      EData := ExplorerNew.GetNodeData(FNodeMsgOutbox);
      i := TStrings(EData.Data).Count;
      if (i <> 0) and ((LastSMSSendFailure = 0) or (((Now - LastSMSSendFailure) * SecsPerDay) >= 30)) then begin
        { yes, are we work in offline mode? }
        if not FConnected then begin
          { yes, but if Connect on startup is active, wait for connection to be established... }
          if not ActionConnectionAutoConnect.Checked or (ActionConnectionAutoConnect.Tag <> 0) then
            { also wait while Splash is visible, wait until App is initialized }
            if IsStartCompleted then begin
              { ask user to start connection in order to send outbox messages }
              if UnsentCount <> i then begin
                UnsentCount := i; // ask just once per new messages
                if FCheckOutbox then begin
                  if MessageDlgW(_('You have unsent messages in your Outbox folder. Do you want to send them now?'),
                    mtConfirmation, MB_YESNO) = ID_YES then
                    RequestConnection;
                end;
              end;
            end;  
        end
        else begin
          { perform Outbox check in online mode :) }
          try
            if LastSMSSendFailure = 0 then // here user intervention is erquired to be set to zero
              DoProcessOutbox;
            EData := ExplorerNew.GetNodeData(FNodeMsgOutbox);
            if TStrings(EData.Data).Count <> 0 then
              Abort
            else
              LastSMSSendFailure := 0;
          except
            if LastSMSSendFailure = 0 then
              Log.AddMessage('SMS: Sending disabled temporary', lsDebug); // do not localize debug
            LastSMSSendFailure := Now;
          end;
        end;
      end;
      if FConnected and not FSendingMessage and not ThreadSafe.ObexConnecting and not FObex.Connected and (ThreadSafe.ActiveThread = nil) then begin
        { Remove missed call/new message dialog box from phone }
        if FClearPhoneMessage then begin
          FClearPhoneMessage := False;
          if FUseKeylockMonitor then begin
            { First unlock keyboard if needed }
            TxAndWait('AT+CLCK="CS",2'); // do not localize
            IsLocked := FKeybLocked;
            if IsLocked then
              ActionToolsKeybLock.Execute;
          end
          else
            IsLocked := false; // assume keypad is unlocked
          { Remove popup }
          if IsT610Clone then
            try
              // T610 phones...
              TxAndWait('AT+CKPD=":R"'); // do not localize
            except
            end
          else if IsK700Clone or IsK750Clone then
            try
              // K750 phones...
              TxAndWait('AT*EKEY=1,":R",2'); // do not localize
            except
            end
          else
            try
              // T68i phones...
              TxAndWait('AT+CKPD="c"'); // do not localize
            except
            end;
          { Lock keyboard again if needed }
          if IsLocked then
            ActionToolsKeybLock.Execute;
        end;
        { Check keylock and proximity status }
        if FConnectingComplete and (KeybCheck = 1) then // every 6 seconds 
          try
            { check keylock
              WARNING! always do a check if Proximity Monitoring is active! }
            if ActionConnectionMonitor.Checked or FUseKeylockMonitor then
              TxAndWait('AT+CLCK="CS",2'); // do not localize

            { check silent }
            if FUseSilentMonitor then begin
              if IsK750Clone then begin
                TxAndWait('AT+CSIL?'); // do not localize
                { TODO: Add HandleESIL() }
                for i := 0 to ThreadSafe.RxBuffer.Count - 2 do
                  if pos('+CSIL', ThreadSafe.RxBuffer[i]) = 1 then begin // do not localize
                    FSilentMode := Copy(ThreadSafe.RxBuffer[i], 8, length(ThreadSafe.RxBuffer[i])) = '1';
                    ActionToolsSilent.Enabled := True;
                  end;
              end
              else begin
                TxAndWait('AT*ESIL?'); // do not localize
                { TODO: Add HandleESIL() }
                for i := 0 to ThreadSafe.RxBuffer.Count - 2 do
                  if pos('*ESIL', ThreadSafe.RxBuffer[i]) = 1 then begin // do not localize
                    FSilentMode := Copy(ThreadSafe.RxBuffer[i], 8, length(ThreadSafe.RxBuffer[i])) = '1';
                    ActionToolsSilent.Enabled := True;
                  end;
              end;
            end;

            { check minute minder}
            if not IsK750Clone and FUseMinuteMonitor then begin // not suportd for K750+
              TxAndWait('AT*ESMM?'); // do not localize
              { TODO: Add HandleESMM() }
              for i := 0 to ThreadSafe.RxBuffer.Count - 2 do
                if pos('*ESMM', ThreadSafe.RxBuffer[i]) = 1 then begin // do not localize
                  FMinuteMinder := Copy(ThreadSafe.RxBuffer[i], 8, length(ThreadSafe.RxBuffer[i])) = '1';
                  ActionToolsMinuteMinder.Enabled := True;
                end;
            end;
          except
            if ThreadSafe.Timedout and not ThreadSafe.AbortDetected then begin
              ScriptEvent('OnConnectionLost', []); // do not localize
              Status(_('Connection: Lost!'));
              if Assigned(frmCalling) and frmCalling.IsCreated then
                frmCalling.CloseCall;
              if Assigned(frmNewAlarm) and frmNewAlarm.Visible then
                frmNewAlarm.Close;
              { TODO: Close new messages dialogs? }
            end;
          end;
      end;
    end;
  finally
    if (frmInfoView <> nil) and frmInfoView.Visible then
      frmInfoView.UpdateWelcomePage;
    Timer2.Enabled := True;
  end;
end;

procedure TForm1.FmaOnTheWeb1Click(Sender: TObject);
begin
  ShellExecute(Handle,'open','http://fma.sourceforge.net/','','',SW_SHOWNORMAL); // do not localize
end;

procedure TForm1.FmaOnForums1Click(Sender: TObject);
begin
  ShellExecute(Handle,'open','http://fma.sourceforge.net/forums/','','',SW_SHOWNORMAL); // do not localize
end;

procedure TForm1.FmaOnSFNet1Click(Sender: TObject);
begin
  ShellExecute(Handle,'open','http://sourceforge.net/projects/fma','','',SW_SHOWNORMAL); // do not localize
end;

procedure TForm1.ActionContactsAddContactUpdate(Sender: TObject);
begin
  ActionContactsAddContact.Enabled := IsContactNumberSelected and (LookupContact(LocateSelContactNumber) = '')
end;

procedure TForm1.ActionContactsAddContactExecute(Sender: TObject);
var
  ContactData: PContactData;
  SIMData: PSIMData;
  Number: string;
  procedure UpdateView;
  var
    EData: PFmaExplorerNode;
  begin
    if frmSyncPhonebook.Visible then
      frmSyncPhonebook.ListContacts.Repaint;
    if frmSMEdit.Visible then
      frmSMEdit.ListNumbers.Repaint;
    if frmMEEdit.Visible then
      frmMEEdit.ListNumbers.Repaint;
    if frmMsgView.Visible then begin
      EData := ExplorerNew.GetNodeData(ExplorerNew.FocusedNode);
      frmMsgView.RenderListView(TStringList(EData.Data));
    end;
    if frmInfoView.Visible then
      frmInfoView.UpdateWelcomePage(True);
  end;
begin
  Number := ExtractNumber(LocateSelContactNumber);
  with TfrmAddContact.Create(nil) do
    try
      NewNumber := Number;
      if ShowModal = mrOk then begin
        if RadioButton1.Checked then begin
          { Add new contact to ME }
          if IsIrmcSyncEnabled then begin
            if frmSyncPhonebook.DoEdit(True,Number) then
              UpdateView;
          end
          else begin
            if frmMEEdit.DoEdit(True,Number) then
              UpdateView;
          end;
        end;
        if RadioButton2.Checked then begin
          { Update existing contact }
          if IsIrmcSyncEnabled then begin
            ContactData := GetSelectedContact;
            case rgPhoneType.ItemIndex of
              0: ContactData^.cell := Number;
              1: ContactData^.work := Number;
              2: ContactData^.home := Number;
              3: ContactData^.fax := Number;
              4: ContactData^.other := Number;
            end;
            { Mark contact as Modified (if not New) }
            if ContactData^.StateIndex <> 0 then
              ContactData^.StateIndex := 1;
          end
          else begin
            SIMData := GetSelectedContact;
            SIMData^.pnumb := Number;
            { Mark contact as Modified (if not New) }
            if SIMData^.imageindex <> 0 then
              SIMData^.imageindex := 1;
          end;
          UpdateMEPhonebook;
          { Update fma views }
          UpdateView;
        end;
      end;
    finally
      Free;
    end;
end;

function TForm1.ExtractNumber(ContactNumber: WideString): WideString;
var
  i: integer;
begin
  i := Pos('[',ContactNumber);
  if i <> 0 then begin
    Delete(ContactNumber,1,i);
    i := Pos(']',ContactNumber);
    if i <> 0 then Delete(ContactNumber,i,Length(ContactNumber));
  end;
  i := 1;
  while i <= Length(ContactNumber) do begin
    if Char(ContactNumber[i]) in ['+','0'..'9','#','*','p'] then
      Inc(i)
    else
      Delete(ContactNumber,i,1);
  end;
  Result := ContactNumber;
end;

procedure TForm1.ActionContactsOwnExecute(Sender: TObject);
var
  sl: TStringList;
  str: TMemoryStream;
  VCard: TVCard;
  cd: TContactData;
  contact: PContactData;
begin
  contact := @cd;
  sl := TStringList.Create;
  VCard := TVCard.Create;
  str := TMemoryStream.Create;
  try
    Status(_('Loading own card...'));
    ObexConnect;
    try
      try
        ObexGetObject('telecom/pb/0.vcf',sl); // do not localize
      except
        { Skip 'Not found' error }
        if FObex.LastErrorCode <> $C4 then raise;
      end;
    finally
      ObexDisconnect;
    end;
    Status('');
    { Edit card }
    VCard.Raw := sl;
    vCard2Contact(VCard,contact);
    contact^.stateindex := 3;
    if frmSyncPhonebook.DoEdit(False,'',contact) then begin
      Contact2vCard(contact,VCard);
      VCard.Raw.SaveToStream(str);
      str.Position := 0;
      Status(_('Saving own card...'));

      //raise Exception.Create(_('Not implemented yet'));
      {
        Note: If MV, BC or HP is the currently selected phonebook storage, +CME
        ERROR: <err> will be returned.
        Note: DC, RC, and MC are not supported.
        Note: If phone is the currently selected phonebook storage, <text> will be
        interpreted as ”last name” + "," + “first name” when stored in the
        hierarchical phonebook.
        Note: Flags may be used to indicate the contact field where the number
        should be stored. If no flag is used, the phone number will be stored as of
        type "home".
        Note: If phone is the currently selected phonebook storage and AT+CPBW
        is used with an <index> that is already used by another number, the old
        number will be overwritten and removed from whatever contact it was
        previously a part of.
      }
      //TxAndWait('AT+CPBS="BC",password'); // do not localize
      //if contact^.cell <> '' then
      //  TxAndWait('AT+CPBW=[<index>][,<number>[,<type>[,<text>]]]'); // do not localize
      
      ObexConnect;
      try
        try
          ObexPutObject('telecom/pb/0.vcf',nil,False); // do not localize
        except
          // ignore Not Found error
        end;  
        ObexPutObject('telecom/pb/0.vcf',str,False); // do not localize
        Status(_('Own card modified'));
      finally
        ObexDisconnect;
      end;
    end;
  finally
    str.Free;
    sl.Free;
    VCard.Free;
  end;
end;

procedure TForm1.ExplorerNewPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  EData: PFmaExplorerNode;
  i: Integer;
begin
  if Assigned(Node) then begin
    EData := Sender.GetNodeData(Node);
    if ((EData.StateIndex and $F00000) = FmaMessagesRootFlag) and ((EData.StateIndex and FmaNodeSubitemsMask) <> 0) then begin // SMS folders
      if (EData.SpecialImagesFlags and $80 <> 0) and (EData.SpecialImages <> 0) then //if Pos(' (',EData.Text) <> 0 then
        TargetCanvas.Font.Style := [fsBold]
      else
        TargetCanvas.Font.Style := [];
    end
    else
      TargetCanvas.Font.Style := [];
    if (Node = Sender.FocusedNode) and ExplorerNew.Focused then
      TargetCanvas.Font.Color := clHighlightText
    else
      TargetCanvas.Font.Color := clWindowText;
    case Column of
      0: if Node = Sender.HotNode then
           TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsUnderline];
      1: if (EData.SpecialImagesFlags and $80 <> 0) and (EData.SpecialImages <> 0) then begin
           TargetCanvas.Font.Color := clRed;
           { adjust column width to display all digits }
           i := TargetCanvas.TextWidth(IntToStr(EData.SpecialImages)) + 12;
           with ExplorerNew.Header.Columns[1] do
             if i > MaxWidth then begin
               MaxWidth := i;
               MinWidth := i;
             end;
         end;
    end;
  end;
end;

function TForm1.UpdateNewMessagesCounter(rootNode: PVirtualNode; ModifyPDU: string; MarkAsRead: boolean): integer;
var
  cnt,i,stat: integer;
  sl: TStrings;
  flag: string;
  data: PFmaExplorerNode;
  wl: TTntStringList;
  s: WideString;
begin
  Result := 0;
  data := ExplorerNew.GetNodeData(rootNode);
  if not Assigned(rootNode) or (data.StateIndex and $F00000 <> FmaMessagesRootFlag) then
    exit; // this works only for Text Message folders

  cnt := 0;
  sl := TStrings(data.data);
  for i := 0 to sl.Count-1 do begin
    wl := TTntStringList.Create;
    try
      GetTokenList(wl, sl[i]);
      if wl.Count < 6 then
        continue;
      { Should we upgrade DB? }
      if wl.Count < 8 then begin
        if wl.Count = 6 then begin
          { DB upgrade 0.10.29 build, where count is changed from 6 to 8 }
          wl.Add(''); // set date field as empty (unknown)
        end;
        if wl.Count = 7 then begin
          wl.Add(IntToStr(byte(not MarkAsRead))); // set the new message flag
        end;
        sl[i] := GetTokenListText(wl); // save DB changes
      end;
      { Counts new messages }
      try
        flag := wl[7];
        stat := StrToInt(flag);
        if stat <> byte(not MarkAsRead) then begin
          if AnsiCompareStr(ModifyPDU,wl[5]) = 0 then begin // should we modify the item?
            wl[7] := IntToStr(byte(not MarkAsRead)); // set the new message flag
            if not MarkAsRead then inc(cnt);
            sl[i] := GetTokenListText(wl); // save DB changes
            continue;
          end;
        end;
        if stat <> 0 then inc(cnt);
      except
        Log.AddMessageFmt(_('Database: Error loading data (DB Index %d)'), [i], lsError);
        if FindCmdLineSwitch('FIXDB') then begin
          sl[i] := '';
          Log.AddMessageFmt(_('Database: Removed incorrect data (DB Index: %d)'), [i], lsInformation);
        end;
      end;
    finally
      wl.Free;
    end;
  end;
  { Update explorer data }
  s := data.Text;
  if data.SpecialImagesFlags and $80 <> 0 then begin
    data.SpecialImages := cnt;
    if cnt > 0 then
      s := s + ' (' + IntToStr(cnt) + ')';
  end;
  if rootNode = ExplorerNew.FocusedNode then
    lblCurrentPage.Caption := s;
  { Update view }
  if frmInfoView.Visible then frmInfoView.UpdateWelcomePage;
  { Also update Notification icon }
  if MarkAsRead and (cnt = 0) then
    NewMessageTrayIcon.IconVisible := False;
  { TODO: Update Message view as well }
  ExplorerNew.InvalidateNode(rootNode);
  Result := cnt;
end;

function TForm1.FindObexFolderNode(AType: byte): PVirtualNode;
  function FindObexFolderNodeFromNode(Node: PVirtualNode; AType: Byte): PVirtualNode;
  var itNode: PVirtualNode;
      data: PFmaExplorerNode;
begin
  Result := nil;
      data := ExplorerNew.GetNodeData(Node);
      case AType of
      0: if data.ImageIndex = 35 then begin // pic folder
          Result := Node;
        Exit;
        end;
      1: if data.ImageIndex = 34 then begin // snd folder
          Result := Node;
        Exit;
        end;
      2: if data.ImageIndex = 33 then begin // thm folder
          Result := Node;
        Exit;
        end;
      end;

    itNode := Node.FirstChild;
    while itNode <> nil do begin
      Result := FindObexFolderNodeFromNode(itNode, AType);
      if Assigned(Result) then Break;
      itNode := itNode.NextSibling;
    end;
  end;

begin
  Result := nil;
  if Assigned(Form1.FNodeObex) then
    Result := FindObexFolderNodeFromNode(Form1.FNodeObex, AType);
end;

function TForm1.FindObexFolderName(AType: byte): WideString;
var
  Node: PVirtualNode;
  EData: PFmaExplorerNode;
begin
  Node := FindObexFolderNode(AType);
  if Node <> nil then begin
    EData := ExplorerNew.GetNodeData(Node);
    Result := EData.Text;
  end
  else Result := '';
end;

procedure TForm1.ShowExplorerProperties(Node: PVirtualNode);
var
  contact: PContactData;
  bookmark: PBookmarkData;
  ANode: PVirtualNode;
  EData: PFmaExplorerNode;
  sim: PSIMData;
  //bt,bu: WideString;
begin
  EData := ExplorerNew.GetNodeData(Node);
  if (Node.Parent = FNodeBookmarks) then begin
    ANode := frmSyncBookmarks.FindBookmarkTitle(EData.Text,bookmark);
    if ANode <> nil then frmSyncBookmarks.DoEdit(ANode);
  end
  else
  if (EData.ImageIndex = 24) and (EData.Text = cbProfile.Text) then begin
    { Edit current Profile instead showing common properties }
    ActionToolsEditProfile.Execute;
  end
  else
  if EData.ImageIndex = 8 then begin
    { Contact properties }
    if (Node.Parent = FNodeContactsME) or // Phonebook contact
      (Node.Parent.Parent = FNodeGroups) then begin // Group member
      if IsIrmcSyncEnabled then begin
        if frmSyncPhonebook.FindContact(EData.Text,contact) then
          with frmSyncPhonebook do begin
            SelContact := contact;
            if DoEdit then UpdateMEPhonebook;
          end;
      end
      else begin
        if frmMEEdit.FindContact(EData.Text,sim) then
          with frmMEEdit do begin
            SelContact := sim;
            if DoEdit then UpdateMEPhonebook;
          end;
      end;
    end else
    if Node.Parent = FNodeContactsSM then begin // SIM contact
      if frmSMEdit.FindContact(EData.Text,sim) then
        with frmSMEdit do begin
          SelContact := sim;
          if DoEdit then UpdateSMPhonebook;
        end;
    end;
  end
  else begin
    { Show common properties }
    frmFolderProps := TfrmFolderProps.Create(nil);
    with frmFolderProps do
    try
      RootNode := Node;
      if ShowModal = mrOk then begin
        { Phone renamed? }
        if pcGeneral.ActivePage = tsPhone then begin
          FSelPhone := TntEdit1.Text;
          if FSelPhone = '' then FSelPhone := _('My Phone');
          EData.Text := FSelPhone;
          Caption := WideFormat(_('floAt''s Mobile Agent %s - [%s]'),[GetBuildVersionDtl,EData.Text]);
          { Update view }
          ExplorerNewChange(ExplorerNew,ExplorerNew.FocusedNode);
          { Update tray icon if phone is renamed }
          if FConnected then
            CoolTrayIcon1.Hint := WideFormat(_('Connected to %s'),[FSelPhone]);
            
          { Save changes }
          SavePhoneDataFiles(True);
        end;
      end;
    finally
      Free;
      frmFolderProps := nil;
    end;
  end;
  ExplorerNewChange(ExplorerNew,ExplorerNew.FocusedNode);
end;

function TForm1.FindExplorerChildNode(Named: WideString; RootNode: PVirtualNode): PVirtualNode;
var
  Child: PVirtualNode;
  EData: PFmaExplorerNode;
  Cname: WideString;
  MsgMode: boolean;
begin
  Result := nil;
  if RootNode = nil then RootNode := ExplorerNew.FocusedNode;
  if RootNode = nil then exit;
  Child := RootNode;
  MsgMode := False;
  while Assigned(Child) do begin
    if Child = FNodeMsgRoot then begin
      MsgMode := True;
      break;
    end;
    Child := Child.Parent;
  end;
  if RootNode <> nil then begin
    //if Child <> nil then Child := Child.FirstChild else
    Child := RootNode.FirstChild;
    while Child <> nil do begin
      if MsgMode then Cname := GetSMSNodeName(Child)
      else begin
        EData := ExplorerNew.GetNodeData(Child);
        Cname := EData.Text;
      end;
      if WideCompareText(Cname,Named) = 0 then
        break;
      Child := Child.NextSibling;
    end;
  end;
  Result := Child;
end;

procedure TForm1.ScriptInitialize;
begin
  FScriptRunning := False;
  FScriptErrorOccur := False;
  FScriptInitialized := False;
  if FUseScript then begin
    ScriptingCleanup;
    try
      { Load any COM objects }
      ScriptControl.AutoObjects.BeginUpdate;
      try
        FAccessoriesMenu := TAccessoriesMenu.Create;
        with ScriptControl.AutoObjects.Add do begin
          AutoObject := TMobileAgentApp.Create;  { TODO -oLordLarry : Memory Leak. AWScript is full of leaks }
          AutoObjectName := 'fma'; // do not localize
        end;
        with ScriptControl.AutoObjects.Add do begin
          AutoObject := FAccessoriesMenu;
          AutoObjectName := 'am'; // do not localize
        end;
      finally
        ScriptControl.AutoObjects.EndUpdate;
      end;
      { Load script code }
      if not LoadScript then Abort;
      { Initialize }
      ScriptEvent('OnInit', []); // do not localize
      { Ok, script is loaded and initialized }
      FScriptInitialized := True;
    except
      Log.AddMessage(_('ERROR: Can not create automation objects'), lsError);
      ScriptingCleanup;
    end;
  end;
end;

procedure TForm1.SaveMsgToFolder(var rootNode: PVirtualNode; PDU: String; OverwriteOld,
  AsNew,UpdateView: boolean; ForceIndex: Integer; ForceDate: TDateTime; AllowDuplicates: Boolean);
var
  ARef, ATot, An: Integer;
  flag,buffer: String;
  sms: TSMS;
  EntryExist: Boolean;
  j: Integer;
  dt: TDateTime;
  sl: TStringList;
  EData: PFmaExplorerNode;
begin
  EData := ExplorerNew.GetNodeData(rootNode);
  if not Assigned(rootNode) or (EData.StateIndex and FmaMessagesRootFlag <> FmaMessagesRootFlag) then
    exit;

  sms := TSMS.Create;
  try
    sms.PDU := PDU;

    { Set location: 1 = ME, 2 = SM, 3 = PC }
    if EData.StateIndex and FmaMessageFolderFlag <> 0 then
      buffer := '3,'  // message moved to custom folder
    else
      buffer := '1,'; // downloaded new message from ME

    if ForceIndex = -1 then ForceIndex := TStrings(EData.Data).Count + 1;
    buffer := buffer + IntToStr(ForceIndex) + ','; // index

    if sms.IsOutgoing then buffer := buffer + '3,,,'
      else buffer := buffer + '1,,,';

    buffer := buffer + '"' + PDU + '",';

    if ForceDate = 0 then dt := sms.TimeStamp
      else dt := ForceDate;
    { if not timestamp is not set (i.e. outgoing sms) use current time }
    if dt = 0 then dt := Now;
    buffer := buffer + '"' + DateTimeToStr(dt) + '"';

    if AsNew then begin
      GSMLongMsgData(PDU, ARef, ATot, An);
      { Do not mark as New long SMS entries, except the first one }
      if (ATot > 1) and (An <> 1) then
        AsNew := False;
    end;
    buffer := buffer + ',' + IntToStr(Byte(AsNew));
  finally
    sms.Free;
  end;

  { TODO: Optimize for speed }
  sl := TStringList(EData.Data);
  EntryExist := False;
  if not AllowDuplicates then
    for j := 0 to sl.count-1 do begin
      if AnsiCompareText(GetToken(sl[j],5),PDU) = 0 then begin
        if OverwriteOld then begin
          { Mark message as new depending of AsNew }
          buffer := sl[j];
          { DB upgrade 0.10.29 build, where count is changed from 6 to 8 }
          if GetTokenCount(buffer) = 6 then
            buffer := buffer + ',"' + DateTimeToStr(dt) + '",' + IntToStr(Byte(AsNew))
          else begin
            if GetTokenCount(buffer) = 7 then
              buffer := buffer + ',' + IntToStr(Byte(AsNew))
            else begin
              flag := GetToken(buffer,7);
              if byte(AsNew) <> StrToInt(flag) then begin
                buffer := Copy(buffer,1,Length(buffer)-Length(flag));
                buffer := buffer + IntToStr(Byte(AsNew));
              end;
            end;
          end;
          sl[j] := buffer;
        end;
        EntryExist := True;
        break;
      end;
    end;
  if not EntryExist then
    sl.Add(buffer);

  if UpdateView then begin
    UpdateNewMessagesCounter(rootNode);
    if (rootNode = ExplorerNew.FocusedNode) and frmMsgView.Visible then
      frmMsgView.RenderListView(sl);
  end;
end;

procedure TForm1.DoProcessOutbox;
const
  sem: boolean = false;
  slProcessed  = $01;
  slSentOK     = $02;
var
  found: Boolean;
  i,m,mok,rday,rmonth: integer;
  s,LongText: WideString;
  pdu: string;
  sl,ml,fl,newpdu: TStringList;
  sms: TSMS;
  OldMsec: cardinal;
  chat: TfrmCharMessage;
  dlg: TfrmConnect;
  DeliveryNode: PVirtualNode;
  EData: PFmaExplorerNode;
  function DoSendSMS(var pdu: String; FirstMember: boolean): boolean;
  var
    j: Integer;
    OldRef,NewRef: string;
    rx: TStringList;
    who,sender: WideString;
  begin
    Result := False;
    { This message will return True if Message Reference has been changed }
    sms := TSMS.Create;
    try
      { Sending message... }
      sms.PDU := pdu;
      LongText := LongText + sms.Text;
      OldRef := sms.MessageReference;
      if FirstMember then begin
        if sms.Number <> '' then begin
          who := LookupContact(sms.Number);
          if who = '' then who := sUnknownContact;
          sender := who + ' [' + sms.Number + ']';
          DeliveryNode := GetSMSDeliveryNode(sender);
        end;
        chat := GetChatWindow(sms.Number);
      end;

      dlg.SetDescr(_('Sending out messages') + sLinebreak + '(' +
        LookupContact(sms.Number,sUnknownContact) + ')');
      //FSendingMessage := True;
      try
        TxAndWait('AT+CMGS=' + IntToStr(sms.TPLength), '> '); // send message // do not localize
      except
        //FSendingMessage := False;
        raise;
      end;
      if ThreadSafe.AbortDetected then begin
        { Cancel sending }
        try
          TxAndWait(#$1B); // Sending can be cancelled by giving <ESC> character (IRA 27).
        finally
          //FSendingMessage := False;
        end;
        Abort;
      end;
      { Temporary increase timeout since sending may take alot of time }
      OldMsec := ThreadSafe.InactivityTimeout;
      if OldMsec < LongOperationsTimeout then
        ThreadSafe.InactivityTimeout := LongOperationsTimeout;
      try
        rx := TStringList.Create;
        try
          { Transmit PDU... }
          TxAndWait(pdu + #$1A); // <ctrl-Z> (IRA 26) must be used to indicate the ending of PDU.
          { Message sent OK! }
          rx.Text := ThreadSafe.RxBuffer.Text;
          Result := True;
          { Check for Execution command response:
              +CMGS: <mr>[,<ackpdu>]
          }
          for j := 0 to rx.Count-1 do begin
            if Pos('+CMGS:',rx[j]) = 1 then begin // do not localize
              try
                { Analize phone response here:
                  <mr>
                  GSM 03.40 TP-Message-Reference in integer format.
                  <ackpdu> 
                  Optionally (when AT+CSMS <service> value is 1 and network supports) "ackpdu" is returned.
                  Values can be used to identify message upon unsolicited delivery status report result code.
                  GSM 03.40 RP-User-Data element of RP-ACK PDU; format is same as for <pdu> in case of SMS,
                  but without GSM 04.11 SC address field and parameter shall be bounded by double quote
                  characters like a normal string type parameter. }
                s := rx[j];
                Delete(s,1,7);
                NewRef := IntToHex(StrToInt(Trim(GetToken(s,0))),2);
                if OldRef <> NewRef then begin
                  Log.AddCommunicationMessage(Format('Message reference changed to %sh',[NewRef]), lsDebug); // do not localize debug
                  { Return modified PDU }
                  //pdu := sms.GetNewPDU(d);
                end;
              except
                // just in case
              end;
              break;
            end;
          end;
        finally
          rx.Free;
        end;
      finally
        ThreadSafe.InactivityTimeout := OldMsec;
        //FSendingMessage := False;
      end;
    finally
      sms.Free;
    end;
  end;
begin
  if not sem then begin
    sem := True;
    try
      RequestConnection;
      frmInfoView.linkSendMessages.Enabled := False;
      sl := TStringList.Create;
      ml := TStringList.Create; // message parts list
      fl := TStringList.Create; // modified folders list
      newpdu := TStringList.Create;
      dlg := GetProgressDialog;
      try
        if frmInfoView.Visible then EBCAState(False);
        FSendingMessage := True;

        EData := ExplorerNew.GetNodeData(FNodeMsgOutbox);
        sl.AddStrings(TStrings(EData.Data));
        for i := 0 to sl.Count-1 do
          sl.Objects[i] := nil; // Objects will be used as flag if message is processed, so clear it now

        if CanShowProgress then
          dlg.ShowProgress(FProgressLongOnly);
        dlg.SetDescr(_('Preparing Outbox'));

        Status(_('Sending messages from Outbox...'));
        TxAndWait('AT+CMGF=0'); // set PDU mode // do not localize
        TxAndWait('AT+CSMS=0'); // check if phone supports SMS commands // do not localize
        // not needed - TxAndWait('AT+CPMS="ME","ME"'); // store messages in ME phonebook // do not localize

        i := 0;
        dlg.Initialize(sl.Count,_('Sending out messages'));
        while i < sl.Count do begin
          WaitASec;
          if ThreadSafe.AbortDetected then Abort;

          { Is message processed or sent? }
          if sl.Objects[i] = nil then begin
            found := GetSMSMembers(i,sl,ml);

            { Mark messages as processed, message could be found entirely or partialy }
            for m := 0 to ml.Count-1 do
              sl.Objects[Integer(ml.Objects[m])] := Pointer(slProcessed);

            if found then begin
              DeliveryNode := FNodeMsgArchive;

              { Entire message found - send its parts in proper order }
              chat := nil;
              LongText := ''; // will collect entire SMS text
              newpdu.Clear;
              m := 0;
              while m < ml.Count do begin
                try
                  pdu := ml[m];
                  if DoSendSMS(pdu,m = 0) then newpdu.Add(pdu);
                  inc(m);
                  dlg.IncProgress(1);
                except
                  { skip next message parts on failure }
                  dlg.IncProgress(ml.Count-m);
                  break;
                end;
              end;

              { All message parts sent OK? }
              if m = ml.Count then begin
                { Yes, Notify user }
                PlaySound(pChar('FMA_SMSSent'), 0, SND_ASYNC or SND_APPLICATION or SND_NODEFAULT); // do not localize

                { Process message parts - file in proper folders }
                fl.Clear;
                for mok := 0 to ml.Count-1 do begin
                  { Mark message parts as Sent - needed for debug only! }
                  sl.Objects[Integer(ml.Objects[mok])] := Pointer(slSentOK);
                  { Remove from Outbox }
                  if DelMsgFromFolder(FNodeMsgOutbox,ml[mok],False) then begin
                    EData := ExplorerNew.GetNodeData(FNodeMsgOutbox);
                    if fl.IndexOf(EData.Text) = -1 then
                      fl.AddObject(EData.Text, Pointer(FNodeMsgOutbox));
                  end;
                  { Remove from Drafts (if any) }
                  if DelMsgFromFolder(FNodeMsgDrafts,ml[mok],False) then begin
                    EData := ExplorerNew.GetNodeData(FNodeMsgDrafts);
                    if fl.IndexOf(EData.Text) = -1 then
                      fl.AddObject(EData.Text, Pointer(FNodeMsgDrafts));
                  end;
                  { Store it in Archive folder.
                    Modified PDU is stored in Archive (with MessageReferance changed by phone) }
                  SaveMsgToFolder(DeliveryNode,newpdu[mok],True,False,False);
                  EData := ExplorerNew.GetNodeData(DeliveryNode);
                  if fl.IndexOf(EData.Text) = -1 then
                    fl.AddObject(EData.Text, Pointer(DeliveryNode));
                end;
                { Refresh folders if needed }
                for mok := 0 to fl.Count-1 do begin
                  DeliveryNode := PVirtualNode(fl.Objects[mok]);
                  UpdateNewMessagesCounter(DeliveryNode);
                  if (ExplorerNew.FocusedNode = DeliveryNode) and frmMsgView.Visible then begin
                    EData := ExplorerNew.GetNodeData(DeliveryNode);
                    frmMsgView.RenderListView(TStringList(EData.Data));
                  end;
                end;

                { Notify Chat }
                if Assigned(chat) then begin
                  chat.Show;
                  chat.BringToFront;
                  chat.AddChatText('',LongText,Now);
                end;

                { Update SMS counter }
                if FSMSDoReset then begin
                  rday := StrToInt(FormatDateTime('d',Date)); // do not localize
                  rmonth := StrToInt(FormatDateTime('m',Date)); // do not localize
                  { Reset counter if the reset-day has been passed }
                  if (FSMSCounterResetDay <= rday) and (FSMSCounterResetLastMonth <> rmonth) then begin
                    if not FSMSCounterReseted then begin
                      FSMSCounter := 0;
                      FSMSCounterReseted := True;
                      FSMSCounterResetLastMonth := rmonth;
                    end;
                  end
                  else
                    FSMSCounterReseted := False;
                end;
                inc(FSMSCounter,ml.Count);
                { Update Compose SMS counter too }
                if frmMessageContact.Visible then
                  frmMessageContact.FormActivate(frmMessageContact);
              end
              else begin
                { Messages NOT sent, notify Chat }
                if Assigned(chat) then begin
                  chat.Show;
                  chat.BringToFront;
                  chat.EnableSending(True);
                end;
              end;
            end;
          end;
          { Next Outbox item }
          inc(i);
        end;
      finally
        newpdu.Free;
        ml.Free;
        sl.Free;
        fl.Free;

        FreeProgressDialog;

        FSendingMessage := False;
        if frmInfoView.Visible then EBCAState(True);

        EData := ExplorerNew.GetNodeData(FNodeMsgOutbox);
        if TStrings(EData.Data).Count <> 0 then begin
          ShowBaloonError(_('Outbox send failed and suspended temporary!'),30);
          Status(_('Outbox send failed and suspended until user intervention'));
          frmInfoView.linkSendMessages.Enabled := True;
        end
        else begin
          if not FStartupOptions.NoBaloons then
            ShowBaloonInfo(_('Messages sent successfully.'));
          Status(_('Outbox send completed'));
        end;
      end;
    finally
      sem := False;
    end;
  end;
end;

function TForm1.DelMsgFromFolder(var rootNode: PVirtualNode; PDU: String; UpdateView: boolean): Boolean;
var
  j: integer;
  sl: TStringList;
  data: PFmaExplorerNode;
begin
  Result := False;
  data := ExplorerNew.GetNodeData(rootNode);
  if not Assigned(rootNode) or (data.StateIndex and FmaMessagesRootFlag <> FmaMessagesRootFlag) then
    exit;

  sl := TStringList(data.Data);
  for j := 0 to sl.count-1 do begin
    if AnsiCompareText(GetToken(sl[j],5), PDU) = 0 then begin
      { If deleteing from Outbox, notify and enable Chat window }
      if UpdateView and (rootNode = FNodeMsgOutbox) then
        ChatNotifyDel(PDU);
      { Delete msg }
      sl.Delete(j);
      Result := True;
      break;
    end;
  end;

  if UpdateView and Result then begin
    UpdateNewMessagesCounter(rootNode);
    if (rootNode = ExplorerNew.FocusedNode) and frmMsgView.Visible then
      frmMsgView.RenderListView(sl);
  end;
end;

procedure TForm1.ActionConnectionSendOutboxMsgsExecute(Sender: TObject);
begin
  LastSMSSendFailure := 0;
  DoProcessOutbox;
end;

procedure TForm1.ActionConnectionSendOutboxMsgsUpdate(Sender: TObject);
var
  EData: PFmaExplorerNode;
begin
  EData := ExplorerNew.GetNodeData(FNodeMsgOutbox);
  ActionConnectionSendOutboxMsgs.Enabled := not ThreadSafe.Busy and not FObex.Connected and
    (TStrings(EData.Data).Count <> 0);
end;

procedure TForm1.WM_QUERYENDSESSION(var Msg: TMessage);
begin
  Msg.Result := 1;  // 1 = okay, we could exit now and end session
end;

procedure TForm1.WM_ENDSESSION(var Msg: TMessage);
begin
  if Boolean(Msg.WParam) then
    try
      FExitWindows := True;
      try
        if FConnected then ActionConnectionDisconnect.Execute;
        { COM object cleanup workaround }
        ScriptControl.AutoObjects.Clear;
        ScriptControl.Free;
        FAccessoriesMenu := nil;
        ScriptControl := TawScriptControl.Create(Self);
        ScriptControl.OnCallFunction := ScriptControlCallFunction;
        ScriptControl.OnError := ScriptControlError;
      finally
        ActionExit.Execute;
        //Application.Terminate;
      end;
    except
    end
  else
    FExitWindows := False;
  Msg.Result := 0;  // 0 = message processed
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if FCheckOutbox and (FExit or not FMinimize) and not FExitWindows and
    ActionConnectionSendOutboxMsgs.Update and ActionConnectionSendOutboxMsgs.Enabled then begin
    FCheckOutbox := False; // do not show two identical questions on exit
    try
      case MessageDlgW(_('You have unsent messages in your Outbox folder. Do you want to send them now?'),
        mtConfirmation, MB_YESNOCANCEL) of
        ID_YES:
          try
            DoProcessOutbox;
          except
            CanClose := False;
          end;
        ID_CANCEL:
          CanClose := False;
      end;
    finally
      FCheckOutbox := True;
    end;
  end;
  if CanClose then begin
    if Assigned(frmMessageContact) and frmMessageContact.Visible then begin
      frmMessageContact.SetFocus;
      frmMessageContact.Close;
    end;
    CanClose := not frmMessageContact.Visible;
  end;
  if CanClose then
    try
      if FExit or not FMinimize then frmEditor.Finalize;
    except
      CanClose := False;
    end;
  if CanClose then begin
    if FExit or not FMinimize then ScriptingDisable;
  end
  else begin
    { Restore exit flags, if we cancel exiting }
    FExit := False;
    FExiting := False;
  end;
end;

procedure TForm1.ActionToolsKeybLockUpdate(Sender: TObject);
begin
  ActionToolsKeybLock.Checked := not FKeybLocked;
  ActionToolsKeybLock.ImageIndex := 39 + byte(FKeybLocked);
  if FKeybLocked then ActionToolsKeybLock.Caption := _('Enable &Keyboard')
    else ActionToolsKeybLock.Caption := _('Disable &Keyboard');
  if not FConnected or not FUseKeylockMonitor or FObex.Connected or ThreadSafe.ObexConnecting then
    ActionToolsKeybLock.Enabled := False;
end;

procedure TForm1.ActionToolsKeybLockExecute(Sender: TObject);
begin
  TxAndWait('AT+CLCK="CS",'+IntToStr(byte(not FKeybLocked))); // do not localize
  FKeybLocked := not FKeybLocked;
end;

procedure TForm1.Explore(Node: PVirtualNode);
begin
  SetExplorerNode(Node);
end;

procedure TForm1.cbTerminalEnter(Sender: TObject);
begin
  Button3.Default := True;
end;

procedure TForm1.cbTerminalExit(Sender: TObject);
begin
  Button3.Default := False;
end;

procedure TForm1.ActionSMSImportUpdate(Sender: TObject);
begin
  (Sender as TTntAction).Enabled := frmMsgView.Visible;
end;

procedure TForm1.ActionSMSImportExecute(Sender: TObject);
begin
  frmMsgView.ImportTextMessages1.Click;
end;

procedure TForm1.ActionContactsImportMEUpdate(Sender: TObject);
begin
  (Sender as TTntAction).Enabled := frmSyncPhonebook.Visible;
end;

procedure TForm1.ActionContactsImportMEExecute(Sender: TObject);
begin
  frmSyncPhonebook.ImportContacts1.Click;
end;

procedure TForm1.DoAbort;
begin
  if ThreadSafe.ObexConnecting then
    FObex.ForceAbort
  else
  if FObex.Connected then
    FObex.Abort
  else
  if ThreadSafe.Busy then begin
    if not ThreadSafe.Abort then begin
      ThreadSafe.Abort := True;
      Log.AddCommunicationMessage(_('User abort signaled'), lsInformation);
      if Assigned(ThreadSafe.ActiveThread) then
        ThreadSafe.ActiveThread.Terminate;
    end;
  end
  else
    ThreadSafe.AbortDetected := True;
end;

procedure TForm1.UpdateMEPhonebook;
var
  sl: TStrings;
  data: PFmaExplorerNode;
begin
  data := ExplorerNew.GetNodeData(FNodeContactsME);
  sl := data.Data;
  if IsIrmcSyncEnabled then
    ParsePhonebookListFromSync(sl)
  else
    ParsePhonebookListFromEditor(FNodeContactsME);
  RenderContactList(FNodeContactsME);

  { Update database }
  SavePhoneDataFiles(True);
  { clear contact lookup cache }
  FLookupList.Clear;
end;

procedure TForm1.UpdateSMPhonebook;
begin
  ParsePhonebookListFromEditor(FNodeContactsSM);
  RenderContactList(FNodeContactsSM);

  { Update database }
  SavePhoneDataFiles(True);
  { clear contact lookup cache }
  FLookupList.Clear;
end;

procedure TForm1.ParsePhonebookListFromEditor(ANode: PVirtualNode);
var
  NeedRefresh: boolean;
  Node :PVirtualNode;
  EData: PFmaExplorerNode;
  contact: PSIMData;
  s: WideString;
  where: string;
  sl: TStrings;
  Tree: TVirtualStringTree;
  procedure DoAdd(Name: WideString);
  var utf8s: string;
  begin
    { SEE ParsePhonebookListFromSync !!! Implementations should match }
    utf8s := UTF8Encode(WideQuoteStr(Name,True));
    sl.Add(utf8s + ',' + WideStringToLongString(contact^.pnumb) + ',' +
      IntToStr(contact^.position) + ',' + IntToStr(contact^.imageindex) + ',' +
      GUIDToString(contact^.CDID) + ',"' + WideStringToLongString(contact^.LUID) + '"');
  end;
begin
  NeedRefresh := False;
  if ANode = FNodeContactsME then begin
    where := 'ME';
    Tree := frmMEEdit.ListNumbers;
  end
  else begin
    where := 'SM'; // do not localize
    Tree := frmSMEdit.ListNumbers;
  end;
  EData := ExplorerNew.GetNodeData(ANode);
  sl := EData.Data;
  sl.Clear;
  Node := Tree.GetFirst;
  if Node <> nil then
    repeat
      contact := Tree.GetNodeData(Node);
      s := contact^.cname;
      if contact^.ptype <> '' then s := s + '/' + UpperCase(contact^.ptype);
      { Update position if unknown }
      if FConnected and (contact^.position = 0) then begin
        Status(_('Updating contact positions...'));
        contact^.position := LocatePBIndex(where,contact^.cname,contact^.pnumb);
      end;
      if contact^.position = 0 then
        NeedRefresh := True;
      DoAdd(s);
      Application.ProcessMessages;
      Node := Tree.GetNext(Node);
    until Node = nil;
  TStringList(sl).Sort;
  if NeedRefresh then begin
    if FAppInitialized then ExplorerNewChange(ExplorerNew,ExplorerNew.FocusedNode); // update view
    if (where <> 'ME') or not IsIrmcSyncEnabled then
      Status(WideFormat(_('Please refresh %s from phone, because some contact positions are missing!'),
        [EData.Text]));
  end;
end;

procedure TForm1.DebugTools1Click(Sender: TObject);
begin
  PanelTest.Visible := not PanelTest.Visible;
  PanelTest.Enabled := PanelTest.Visible;
  DebugTools1.Checked := PanelTest.Visible;
  if PanelTest.Visible then
    TntPageControl1.ActivePageIndex := 0;
  if Assigned(Sender) then
    { Sender is NIL when hiding DelTools on Explorer node change,
      so don't update selection in this case. }
    SetExplorerNode(ExplorerNew.GetFirst);
end;

procedure TForm1.ScriptControlCallFunction(Sender: TObject;
  const FunctionName: String; const Params: array of Variant);
var
  cmd: String;
begin
  FScriptRunning := FConnected;
  FScriptErrorOccur := False;
  if AnsiCompareText(__fma_objcall,FunctionName) <> 0 then
    cmd := FunctionName
  else
    cmd := Params[Low(Params)];
  if cmd <> '' then Log.AddScriptMessage('Script: Calling '+cmd, lsDebug); // do not localize debug
end;

procedure TForm1.ScheduleScriptEvent(const FunctionName: string;
  const Params: array of Variant);
const
  sem: boolean = False;
var
  i: integer;
begin
  while Timer3.Enabled or sem do begin
    Application.ProcessMessages;
    if Application.Terminated then Abort;
  end;
  try
    sem := True;
    try
      FScriptEventName := FunctionName;
      SetLength(FScriptEventParams,High(Params)-Low(Params)+1);
      for i := Low(Params) to High(Params) do
        FScriptEventParams[i] := Params[i];
      Timer3.Enabled := True;
    finally
      sem := False;
    end;
  except
    on e: exception do Log.AddScriptMessage('Internal error: '+e.Message, lsDebug); // do not localize debug
  end;
end;

procedure TForm1.Timer3Timer(Sender: TObject);
var
  s: string;
begin
  if not FAppInitialized or not Assigned(FObex) or not Assigned(ThreadSafe) or
    ThreadSafe.Busy or ThreadSafe.WaitingOK then exit;
  
  Timer3.Enabled := False;
  if FamCommand <> '' then begin
    if FConnected then begin
      if not FSendingMessage and not ThreadSafe.ObexConnecting and not FObex.Connected then begin
        try
          s := FamCommand;
          if s <> '' then begin
            FamCommand := '';
            Log.AddScriptMessage('Script: Transmit Command...', lsDebug); // do not localize debug
            Timer3.Enabled := FScriptEventName <> '';
            TxAndWait(s);
            Log.AddScriptMessage('Script: Transmit Done', lsDebug); // do not localize debug
          end;
        except
          Status(_('Script: Transmit Error!'));
          Log.AddScriptMessage('Script: Error Transmitting', lsDebug); // do not localize debug
        end;
        Timer3.Enabled := FScriptEventName <> '';
      end
      else
        Timer3.Enabled := True; // retry FamCommand later...
    end
    else begin
      FamCommand := '';
      Timer3.Enabled := FScriptEventName <> '';
    end;  
  end
  else begin
    s := FScriptEventName;
    FScriptEventName := '';
    Timer3.Enabled := FamCommand <> '';
    ScriptEvent(s,FScriptEventParams);
  end;
end;

procedure TForm1.ScheduleTxAndWait(Data, WaitStr: String);
begin
  { Wait for previous scheduled command to finish }
  while Timer3.Enabled do begin
    Application.ProcessMessages;
    if Application.Terminated then Abort;
  end;
  if Trim(Data) <> '' then begin
    FamCommand := Data;
    Log.AddScriptMessage('Scheduling Transmit Command '+Copy(Data,1,7)+'...', lsDebug); // do not localize debug
    Timer3.Enabled := not Application.Terminated;
  end;
end;

procedure TForm1.DisableKeyMonitor(TxDelay: boolean);
begin
  Log.AddScriptMessage('Disable Keypad Event Reporting',lsDebug); // do not localize debug
  try
    if TxDelay then ScheduleTxAndWait('AT+CMER=0,0') // do not localize
      else TxAndWait('AT+CMER=0,0'); // 0 = unset keypad monitoring // do not localize
    FKeyMonitoring := False;
  except
  end;
end;

procedure TForm1.ActionSyncWithOutlookExecute(Sender: TObject);
var
  SynchronizeContacts: TSynchronizeContacts;
  dlg: TfrmConnect;
  Fullpath: String;
  ConfirmActions: TContactActions;
  I: Integer;
  Err: WideString;
begin
  Fullpath := GetDatabasePath;
  FAutolinkContacts := False;
  ActionSyncPhonebook.Enabled := False;
  for I := Integer(Low(TContactAction)) to Integer(High(TContactAction)) do
    FOutlookConfirmed[TContactAction(I)] := cfNone;

  dlg := GetProgressDialog;
  frmInfoView.linkSyncOutlook.Enabled := False;
  try
    if CanShowProgress then
      dlg.ShowProgress(FProgressLongOnly);
    dlg.SetDescr(_('Synchronizing contacts'));
    Status(_('Start Sync Outlook Contacts...'));
    Log.AddSynchronizationMessage(_('Sync Outlook Contacts started.'));
    try
      SynchronizeContacts := TSynchronizeContacts.Create;
      try
        SynchronizeContacts.FileName := Fullpath + 'ContactSync.xml'; // do not localize
        SynchronizeContacts.FMA := TFMAContactSource.Create;
        SynchronizeContacts.Extern := TOutlookContactSource.Create;
        try
          SynchronizeContacts.OnConflict := SyncContactsConflict;
          SynchronizeContacts.OnFirstTime := SyncContactsFirstTime;
          SynchronizeContacts.OnError := SyncContactsError;
          SynchronizeContacts.OnConfirm := SyncContactsConfirm;
          SynchronizeContacts.OnChooseLink := SyncContactsChooseLink;

          if FOutlookConfirmAdding then
            Include(ConfirmActions, caAdd);
          if FOutlookConfirmUpdating then
            Include(ConfirmActions, caUpdate);
          if FOutlookConfirmDeleting then
            Include(ConfirmActions, caDelete);
          SynchronizeContacts.FMA.ConfirmActions := ConfirmActions;
          SynchronizeContacts.Extern.ConfirmActions := ConfirmActions;

           with SynchronizeContacts.Extern as TOutlookContactSource do begin
             { FOutlookCategories countains ';' delimeted categories
               which might be quoted as well }
             //Categories.Delimiter := ';';
             Categories.DelimitedText := FOutlookCategories;
             Folders.DelimitedText := FSelectedOutlookContactFolders;
             NewContactsFolder := FOutlookNewContactsFolder;
             if FOutlookFieldMappings <> '' then
               FieldMapper.MappedFields.DelimitedText := FOutlookFieldMappings;
           end;

          dlg.SetDescr(_('Loading contacts'));
          SynchronizeContacts.Load;
          if not ThreadSafe.AbortDetected then begin
            dlg.InitializeLoop(_('Synchronizing contacts'));
            SynchronizeContacts.Synchronize;
            dlg.SetDescr(_('Saving contacts'));
            SynchronizeContacts.Save;
          end;
        finally
          SynchronizeContacts.FMA.Free;
          SynchronizeContacts.Extern.Free;
        end;
      finally
        SynchronizeContacts.Free;
      end;
      Status(_('Sync Outlook Contacts completed.'));
      Log.AddSynchronizationMessage(_('Sync Outlook Contacts completed.'));
    except
      on E: Exception do begin
        Err := WideFormat(_('Error: Sync Outlook Contacts aborted - %0:s (%1:s)'),
          [E.Message,E.ClassName]);
        Status(Err);
        Log.AddSynchronizationMessage(Err, lsError);
        { TODO: Made outlook baloon optional }
        ShowBaloonError(_('Outlook contacts synchronization failed!'),30);
      end;
    end;
  finally
    frmInfoView.linkSyncOutlook.Enabled := True;
    FreeProgressDialog;
    ActionSyncPhonebook.Enabled := True;
    with frmSyncPhonebook do
      ListContacts.Sort(nil, ListContacts.Header.SortColumn, ListContacts.Header.SortDirection);
    UpdateMEPhonebook;
  end;
end;

procedure TForm1.SyncContactsConflict(Sender: TObject; Contact,OtherContact: TContact;
  const Description: WideString; const Item0Name, Item1Name: WideString; var SelectedItem: Integer);
var
  Target: WideString;
begin
  if FOutlookSyncConflict = 0 then begin
    SelectedItem := 1;
  end
  else if FOutlookSyncConflict = 1 then begin
    SelectedItem := 0;
  end
  else begin
    frmPromptConflict := TfrmPromptConflict.Create(Self);
    try
      FOutlookConflict1 := Contact;
      FOutlookConflict2 := OtherContact;
      { Default frmPromptConflict.ObjKind is 'contact' }
      Target := Contact.FullName;
      if Target = '' then Target := OtherContact.FullName;
      frmPromptConflict.ObjName := Target;
      frmPromptConflict.Info := Description;
      frmPromptConflict.Item0Name := Item0Name;
      frmPromptConflict.Item1Name := Item1Name;
      frmPromptConflict.SelectedItem := SelectedItem;
      if Contact.IsChanged and OtherContact.IsChanged then
        frmPromptConflict.OnViewChanges := OnOutlookConflictChanges;
      if frmPromptConflict.ShowModal = mrOK then begin
        SelectedItem := frmPromptConflict.SelectedItem;
        if frmPromptConflict.cbDontAskAgain.Checked then begin
          if SelectedItem = 0 then FOutlookSyncConflict := 1
            else FOutlookSyncConflict := 0;
          FormStorage1.StoredValue['Outlook Sync Conflict'] := FOutlookSyncConflict; // do not localize
        end;    
      end
      else
        SelectedItem := -1;
    finally
      frmPromptConflict.Free;
    end;
  end;
end;

const
  SSyncContactsFirstTime = 'This is the first time you have started Outlook Synchronization. ' +
                           'All FMA contacts will be added to Outlook and all Outlook contacts ' +
                           'will be added to FMA, unless you choose to link them. ' +
                           'The contacts will be linked after that.' + sLinebreak+sLinebreak +
                           'Make sure you have made a backup of your FMA and Outlook contacts!' + sLinebreak+sLinebreak +
                           'There is a maximum of %d contacts in the phonebook memory.' + sLinebreak+sLinebreak +
                           'Do you want to continue?';

procedure TForm1.SyncContactsFirstTime(Sender: TObject; var Continue: Boolean);
begin
  Continue := MessageDlgW(WideFormat(_(SSyncContactsFirstTime), [frmSyncPhonebook.FMaxRecME]),
    mtConfirmation, MB_YESNO) = ID_YES;
end;

procedure TForm1.SyncContactsError(Sender: TObject; const Message: String);
begin
  Log.AddSynchronizationMessageFmt(_('Error: Synchronize aborted (%s)'), [Message], lsError);
  Status(WideFormat(_('Error: Outlook Synchronize aborted (%s)'), [Message]));
  MessageDlgW(WideFormat(_('Error: Outlook Synchronize aborted (%s)'), [Message]), mtError, MB_OK);
end;

procedure TForm1.SyncContactsConfirm(Sender: TObject; Contact: TContact;
    Action: TContactAction; const Description: WideString; var Confirmed: Boolean);
begin
  case FOutlookConfirmed[Action] of
    cfYesToAll: Confirmed := True;
    cfNoToAll: Confirmed := False;
    else begin
      Confirmed := MessageDlgW(WideFormat(sContactSyncConfirm, [Description]), mtConfirmation, MB_YESNO) = ID_YES;
      {
      // TODO: Update for unicode support!
      case MessageDlg(WideFormat(_(SSyncContactsConfirm), [Description]), mtConfirmation, [mbNo,mbYes,mbYesToAll,mbNoToAll], 0) of
        mrYes: Confirmed := True;
        mrYesToAll: begin
          Confirmed := True;
          FOutlookConfirmed[Action] := cfYesToAll;
        end;
        mrNoToAll: begin
          Confirmed := False;
          FOutlookConfirmed[Action] := cfNoToAll;
        end;
        else Confirmed := False;
      end;
      }
    end;
  end;
end;

procedure TForm1.SyncContactsChooseLink(Sender: TObject; Contact: TContact;
  PossibleLinks: TPossibleLinks; var OtherContact: TContact);
var
  frmChooseLink: TfrmChooseLink;
  LinkResult: TModalResult;
begin
  if FOutlookNewAction = 0 then begin
    frmChooseLink := TfrmChooseLink.Create(nil);
    try
      frmChooseLink.Contact := Contact;
      frmChooseLink.PossibleLinks := PossibleLinks;
      if FAutolinkContacts then
        if frmChooseLink.OtherContact(True) <> nil then
          LinkResult := mrAll // link to
        else
          LinkResult := mrIgnore // as new
      else
        LinkResult := frmChooseLink.ShowModal;
      case LinkResult of
        mrCancel:
          raise ESynchronize.Create(_('Contacts linking aborted by user'));
        mrOk:
          OtherContact := frmChooseLink.OtherContact;
        mrAll: begin
          OtherContact := frmChooseLink.OtherContact(True);
          FAutolinkContacts := True;
        end;
      end;
    finally
      frmChooseLink.Free;
    end;
  end;
end;

procedure TForm1.CallScriptMethod(FunctionName: string; Params: array of Variant);
var
  NewParams: array of Variant;
  HasParams: boolean;
begin
  HasParams := Length(Params) > 0;
  if Pos('.',FunctionName) <> 0 then begin
    { calling object's method }
    if HasParams then begin
      { ...with params }
      SetLength(NewParams,2);
      NewParams[Low(NewParams)] := VarAsType(FunctionName,varString);
      NewParams[Low(NewParams)+1] := VarArrayOf(Params);
      ScriptControl.CallFunction(__fma_objcall+'Ex', NewParams); // do not localize
    end
    else begin
      { ...without params }
      SetLength(NewParams,1);
      NewParams[Low(NewParams)] := VarAsType(FunctionName,varString);
      ScriptControl.CallFunction(__fma_objcall, NewParams);
    end;
  end
  else
    { Dako - I have strange error here using D6 "Variant array index out of bounds" :-o See bellow }
    ScriptControl.CallFunction(FunctionName, Params);
    (*
    try
      { calling regular function }
      ScriptControl.CallFunction(FunctionName, Params);
    except
      { Workaround! Ignore error when no params are sent (new version aw_SCtl.pas bug?) }
      on E: Exception do begin
        if not (E is EVariantError) then
          raise E;
      end;
    end;
    *)
end;

procedure TForm1.CheckforUpdate2Click(Sender: TObject);
begin
  CheckforUpdate1.Enabled := False;
  try
    FmaWebUpdate1.CheckforUpdate(GetBuildVersion);
  finally
    CheckforUpdate1.Enabled := True;
  end;
end;

procedure TForm1.FmaWebUpdate1BeforeUpdate(Sender: TObject; var AllowRestart: Boolean);
begin
  if FConnected then ActionConnectionDisconnect.Execute;
  AllowRestart := not FConnected;
  if AllowRestart then ActionExit.Execute;
end;

procedure TForm1.FmaWebUpdate1Error(Sender: TObject; Message: String);
begin
  MessageDlgW(Message, mtError, MB_OK);
end;

function TForm1.IsScriptInitialized: boolean;
begin
  { True if no script at all or when script OnInit is called }
  Result := (FScriptFile = '') or not FileExists(FScriptFile) or FScriptInitialized;
end;

procedure TForm1.ClearExplorerViews;
var
  data: PFmaExplorerNode;
  procedure ClearNode(var Node: PVirtualNode; ClearData: boolean = True);
  var
    data: PFmaExplorerNode;
  begin
    if Assigned(Node) then
    try
      ExplorerNew.DeleteChildren(Node);
      if ClearData then begin
        data := ExplorerNew.GetNodeData(Node);
        TStrings(data.Data).Clear;
        if data.SpecialImagesFlags and $80 <> 0 then
          data.SpecialImages := 0; // no unread items
      end;
    except
    end;
  end;
  procedure ClearChildren(var Node: PVirtualNode; ClearData: boolean = False);
  var
    itNode: PVirtualNode;
    data: PFmaExplorerNode;
  begin
    if Assigned(Node) then
    try
      itNode := Node.FirstChild;
      while itNode <> nil do begin
        ExplorerNew.DeleteChildren(itNode);
        itNode := itNode.NextSibling;
      end;
      if ClearData then begin
        data := ExplorerNew.GetNodeData(Node);
        TStrings(data.Data).Clear;
      end;
    except
    end;
  end;
  procedure ClearUserFolders(Root: PVirtualNode);
  var
    itNode: PVirtualNode;
    data: PFmaExplorerNode;
  begin
    if (Root = nil) or (Root = FNodeContactsME) or (Root = FNodeContactsSM) then
      exit;

    itNode := Root.FirstChild;
    while itNode <> nil do begin
      ClearUserFolders(itNode);
      itNode := itNode.NextSibling;
    end;

    itNode := Root.LastChild;
    while itNode <> nil do begin
      data := ExplorerNew.GetNodeData(itNode);
      if data.StateIndex = FmaSMSSubFolderFlag then
        ExplorerNew.DeleteNode(itNode);
      itNode := itNode.PrevSibling;
      // TODO: fix!!!
    end;
  end;
begin
  try
    if Assigned(FLookupList) then FLookupList.Clear;
    if FAppInitialized then
    try
      ClearNode(FNodeMsgInbox);
      ClearNode(FNodeMsgOutbox);
      ClearNode(FNodeMsgSent);
      ClearNode(FNodeMsgArchive);
      ClearNode(FNodeMsgDrafts);
      frmMsgView.ClearView;

      ClearNode(FNodeContactsME);
      frmSyncPhonebook.ListContacts.Clear;

      ClearNode(FNodeContactsSM);
      frmSMEdit.ListNumbers.Clear;
      frmMEEdit.ListNumbers.Clear;

      ClearNode(FNodeCallsIn);
      ClearNode(FNodeCallsOut);
      ClearNode(FNodeCallsMissed);

      ClearNode(FNodeAlarms);
      ClearNode(FNodeBookmarks);
      frmSyncBookmarks.ListBookmarks.Clear;
      frmCalendarView.ClearAllData;

      ClearChildren(FNodeOrganizer);
      frmExplore.ListItems.Clear;

      if Assigned(FNodeObex) then ExplorerNew.DeleteChildren(FNodeObex);
      if Assigned(FNodeProfiles) then ExplorerNew.DeleteChildren(FNodeProfiles);
      if Assigned(FNodeGroups) then ExplorerNew.DeleteChildren(FNodeGroups);
      if ExplorerNew.GetFirst.ChildCount <> 0 then ClearUserFolders(ExplorerNew.GetFirst);
    finally
      PhoneIdentity := '';
      FPhoneModel := '';
      if not Application.Terminated then begin // update view
        data := ExplorerNew.GetNodeData(ExplorerNew.GetFirst);
        FSelPhone := _('My Phone');
        data.Text := FSelPhone;
        ExplorerNew.Repaint;
        Caption := WideFormat(_('floAt''s Mobile Agent %s'),[GetBuildVersionDtl]);

        with ExplorerNew.Header.Columns[1] do begin
          MinWidth := 24; // respore column original width
          MaxWidth := 24;
        end;
        ExplorerNewChange(ExplorerNew,ExplorerNew.FocusedNode);
        Update;
      end;
    end;
  except
  end;
  FDatabaseLoaded := False;
  FSelPhone := '';
end;

function TForm1.GetNextLongSMSRefference: string;
var
  mref: integer;
begin
  { TODO: Ask phone for its SMS Reference instead! (Dako) }
  randomize;
  mref := 1 + random(252);
  with TRegistry.Create do
    try
      RootKey := HKEY_CURRENT_USER;
      if OpenKey('Software\floAt\fma',true) then // do not localize
        try
          if ValueExists('MessageRef') then // do not localize
            mref := ReadInteger('MessageRef'); // do not localize
          if (mref < 0) or (mref >= MAXBYTE) then mref := 0;
          inc(mref);
          WriteInteger('MessageRef',mref); // do not localize
        finally
          CloseKey;
        end;
    finally
      Free;
    end;
  Result := IntToHex(mref, 2);
end;

procedure TForm1.ViewInitialize;
begin
  { Set startup folder, if specified }
  case FExplorerStartupMode of
    0: SetExplorerNode(ExplorerNew.GetFirst);
    1: SetExplorerNode(FNodeMsgInbox);
    2: SetExplorerNode(FNodeMsgArchive);
    3: SetExplorerNode(FNodeContactsME);
    4: SetExplorerNode(FNodeContactsSM);
    5: SetExplorerNode(FNodeCalendar);
  end;

  { Restore Event Viewer visible status }
  if FormStorage1.StoredValue['Log'] = True then // do not localize
    ActionViewLog.Execute;

  { Add some default Welcome Tips here }
  frmWelcomeTips.QueueTip('You can upload or download multiple files in a single session by holding down the control key while selecting the files.',15);
  frmWelcomeTips.QueueTip('You can keep FMA up-to-date by using built-in Web Update Wizard, which is accessible from main menu, under Help.',15);
  frmWelcomeTips.QueueTip('You can set-up rules for automatically filing your SMS messages based on who sent it or who you sent it to. Check Tools > Delivery Options to set up the rules.',15);
  frmWelcomeTips.QueueTip('You can create a list of favorite SMS recipients or groups, so you don''t have to go to your Phone Book eveytime.'+sLineBreak+'Click the SMS button and choose Favorites > Organize favorites to set up favorite contacts or groups.',15);
  frmWelcomeTips.QueueTip('You can send Flash SMS so the recipient does not have to read it.  The SMS simply appears on the phone and disappears when the user pushes any button.'+sLineBreak+'Click the SMS button and click the Flash option on the toolbar.',15);
  frmWelcomeTips.QueueTip('You can assign a preferred default number for each contact so that FMA will default to either the Mobile, office or home number when dialed from FMA.'+sLineBreak+'Open a contact and choose the Call Preferences tab.',15);
  frmWelcomeTips.QueueTip('You can assign a personalized photo and sound to pop up on your screen when FMA receives a call from that contact.'+sLineBreak+'Open a contact and choose Personalize tab.',15);
  frmWelcomeTips.QueueTip('FMA has a very active user forums for information and troubleshooting. Visit us at http://www.mobileagent.info/forums',15);
  frmWelcomeTips.QueueTip('FMA has an IRC channel.'+sLineBreak+'server: irc.chatspike.net'+sLineBreak+'channel: #fma',15);
  frmWelcomeTips.QueueTip('You can toggle FMA Today page options by simply right-clicking anywhere on the page.',15);
  frmWelcomeTips.QueueTip('You can hide and show various areas on the FMA Today page by clicking the little "double up arrow" icons at the top of each section.',15);
  frmWelcomeTips.QueueTip('You can call or Message a contact directly from the call list by simply right-clicking the item on the call list.',15);
  frmWelcomeTips.QueueTip('You can hide and show columns in the phone book view by right-clicking any contact name and selecting Current View > Columns from the menu.',15);
  frmWelcomeTips.QueueTip('You can reorder columns in the phone book view using simple drag-and-drop on the column heading names.',15);
  (*
  frmWelcomeTips.QueueTip( // add RichText tip
    '{\rtf1\ansi\deff0{\fonttbl{\f0\fswiss\fprq2\fcharset0 Tahoma;}{\f1\fnil\fcharset204 Tahoma;}}'+sLineBreak+
    '{\colortbl ;\red0\green128\blue0;\red0\green0\blue255;}'+sLineBreak+
    '\viewkind4\uc1\pard\lang1033\f0\fs16 You could keep your \cf1\b FMA\cf0\b0  up-to-date by using built-in \i Web '+
    'Update Wizard\i0 , under Help main menu. Or you could visit \cf2\ul our website <http://fma.sourceforge.net/>'+
    '\cf0\ulnone  often and read News posted there.\lang1026\f1\par'+sLineBreak+
    '}'+sLineBreak+' ',10);
  *)
end;

procedure TForm1.ActionSwitchUserProfileUpdate(Sender: TObject);
begin
  { Allow DB profile change only in Offline mode }
  ActionConnectionConnect.Update;
  ActionSwitchUserProfile.Enabled := ActionConnectionConnect.Enabled;
end;

procedure TForm1.ActionSwitchUserProfileExecute(Sender: TObject);
var
  ID: String;
begin
  with TfrmOfflineProfile.Create(nil) do
    try
      repeat
        case ShowModal of
          mrOk: begin
            { save current }
            if AnsiCompareStr(PhoneIdentity,SelectedProfile) <> 0 then begin
              SavePhoneDataFiles(True);
              ClearExplorerViews;
            end;
            { load selected }
            FRelocateDBDenied := False;
            LoadPhoneDataFiles(SelectedProfile,True,True);
            break; // leave
          end;
          mrRetry: begin
            { selected profile is already open? }
            if AnsiCompareStr(PhoneIdentity,SelectedProfile) <> 0 then begin
              { no, save current }
              SavePhoneDataFiles(True);
              { load in order to relocate if needed }
              FRelocateDBDenied := False;
              LoadPhoneDataFiles(SelectedProfile,True,True);
              ID := SelectedProfile;
            end
            else
              ID := PhoneIdentity;
            { repair }
            Status(_('Repairing profile...')); Update;
            RepairPhoneDataFiles(ID);
          end;
          mrIgnore: begin
            Status(_('Creating profile...'));
            if InitNewPhone then break; // leave
          end;
          mrCancel: break; // leave
        end;
      until False;
    finally
      free;
      Status('');
    end;
end;

function TForm1.ExtractPhoneIdentity(var Model, Serial: string): string;
  function RemoveUnsafeChars(var s: string): string;
begin
    s := StringReplace(s,'"','',[rfReplaceAll]);
    s := StringReplace(s,':','-',[rfReplaceAll]);
    s := StringReplace(s,'\','-',[rfReplaceAll]);
    s := StringReplace(s,'/','-',[rfReplaceAll]);
    Result := s;
  end;
begin
  Result := Format('%s [%s]',[RemoveUnsafeChars(model),RemoveUnsafeChars(serial)]);
end;

function TForm1.GetPhoneIdentity: string;
begin
  Result := FormStorage1.StoredValue['LastIdentity']; // do not localize
end;

procedure TForm1.SetPhoneIdentity(ID: string);
begin
  FormStorage1.StoredValue['LastIdentity'] := ID; // do not localize
end;

function TForm1.GetNewMessagesCounter(rootNode: PVirtualNode): integer;
var
  //s: WideString;
  //i: integer;
  data: PFmaExplorerNode;
begin
  data := ExplorerNew.GetNodeData(rootNode);
  if data.SpecialImagesFlags and $80 <> 0 then
    Result := data.SpecialImages
  else
    Result := 0;
  {
  s := data.Text;
  i := Pos(' (',s);
  if i <> 0 then begin
    Delete(s,1,i+1);       // remove "text ("
    Delete(s,Length(s),1); // remove tail ")"
    Result := StrToInt(s);
  end
  else
    Result := 0;
  }
end;

function TForm1.IsEBCAEnabled: boolean;
begin
  Result := EBCALastState = 1;
end;

function TForm1.CanUseEBCA(IgnoreConnectingState: boolean): boolean;
begin
  { Do not enable monitoring while in Obex, or disconnected }
  Result := FUseEBCA and FStateMonitor and FConnected and not FObex.Connected and not ThreadSafe.ObexConnecting;
  if not IgnoreConnectingState and not FConnectingComplete then Result := False;
end;

procedure TForm1.DownloadMessages(Node: PVirtualNode);
var
  sl,nl: TStringList;
  dlg: TfrmConnect;
  i,NewCount,ModCount: Integer;
  EData: PFmaExplorerNode;
  function FindPDUinList(var AList: TStringList; AType, APDU: String; correctType: boolean): integer;
  var
    i: Integer;
    optimizer: TTntStringList;
  begin
    Result := -1;
    optimizer := TTntStringList.Create;
    try
      for i := 0 to AList.Count-1 do begin
        GetTokenList(optimizer, AList[i]);
        if optimizer.Count < 6 then continue;
        { compare pdu data, if equal compare message type,
          will be considered as found if message type equals AType OR '3'}
        if (AnsiCompareStr(APDU, optimizer[5]) = 0) then
          if (optimizer[0] = AType) or (optimizer[0] = '3') then begin
            Result := i;
            if (correctType) and (optimizer[0] <> AType) then begin
              AList[i] := SetToken(AList[i],AType,0);
              inc(ModCount);
            end;
            break;
          end;
      end;
    finally
      optimizer.Free;
    end;
  end;
begin
  AskRequestConnection;
  Status(_('Start Sync Text Messages...'));
  Log.AddSynchronizationMessage(_('Sync Text Messages started.'),lsInformation);
  frmInfoView.linkGetMessages.Enabled := False;
  NewCount := 0;
  ModCount := 0;
  nl := TStringList.Create;
  dlg := GetProgressDialog;
  try
    dlg.Initialize(4,_('Synchronizing text messages')+sLineBreak+'('+GetSMSNodeName(Node)+')');
    if CanShowProgress then
      dlg.ShowProgress(FProgressLongOnly);
    EData := ExplorerNew.GetNodeData(Node);

    Log.AddSynchronizationMessageFmt('Processing folder: %s', [EData.Text], lsDebug); // do not localize debug
    { Information for nl.strings[] - the format is:
        header := trim(copy(ml[i], 8, length(ml[i])));
        nl.Add(IntToStr(memType) + ',' + header + ',' + PDU + ',,0');
      PDU index in the string is 5 (see GetToken) }
    sl := TStringList(EData.Data);
    { DownloadSMS parameter:
      0 Received unread (new) message Default setting
      1 Received read message
      2 Stored unread message (only applicable to SMs)
      3 Stored sent message (only applicable to SMs)
      4 All messages
      16 Template message }
    case (EData.StateIndex and $3F0000) of
      $210000:
        begin
          //dlg.SetDescr(_('Downloading read messages'));
          Log.AddMessage('Downloading read messages', lsDebug); // do not localize debug
          DownloadSMS(1,'SM',nl,True); dlg.IncProgress(1);
          DownloadSMS(1,'ME',nl,True); dlg.IncProgress(1);
          //dlg.SetDescr(_('Downloading unread messages'));
          Log.AddMessage('Downloading unread messages', lsDebug); // do not localize debug
          DownloadSMS(0,'SM',nl,True); dlg.IncProgress(1);
          DownloadSMS(0,'ME',nl,True); dlg.IncProgress(1);
        end;
      $220000:
        begin
          //dlg.SetDescr(_('Downloading sent messages'));
          Log.AddMessage('Downloading sent messages', lsDebug); // do not localize debug
          DownloadSMS(3,'SM',nl,True); dlg.IncProgress(1);
          DownloadSMS(3,'ME',nl,True); dlg.IncProgress(1);
          //dlg.SetDescr(_('Downloading unsent messages'));
          Log.AddMessage('Downloading unsent messages', lsDebug); // do not localize debug
          DownloadSMS(2,'SM',nl,True); dlg.IncProgress(1);
          DownloadSMS(2,'ME',nl,True); dlg.IncProgress(1);
        end;
    end;
    dlg.SetDescr(_('Saving messages data'));
    Log.AddMessage('Saving messages data', lsDebug); // do not localize debug
    { mark old sl messages as 'in PC only' }
    for i := 0 to sl.Count-1 do
      if FindPDUinList(nl, GetToken(sl[i],0), GetToken(sl[i],5), False) = -1 then begin
        if GetToken(sl[i],0) <> '3' then begin
          sl[i] := SetToken(sl[i],'3',0); // 3 = in PC
          inc(ModCount); // count of SMS messages no longer in ME/SM
        end;
      end;
    { add new messages to sl }
    for i := 0 to nl.Count-1 do
      if FindPDUinList(sl, GetToken(nl[i],0), GetToken(nl[i],5), True) = -1 then begin
        sl.Add(nl[i]);
        inc(NewCount);
      end;
    { done }
    Log.AddSynchronizationMessageFmt(_('%d new and %d modified messages added to FMA by Phone.'),
      [NewCount, ModCount], lsInformation);
    i := NewCount + ModCount;
    Log.AddSynchronizationMessageFmt('Processing folder %s: %d changed, %d skipped messages',
      [EData.Text, i, sl.Count - ModCount], lsDebug); // do not localize debug
    UpdateNewMessagesCounter(Node);
    { Update view }
    if frmMsgView.Visible and (ExplorerNew.FocusedNode = Node) then
      frmMsgView.RenderListView(sl);

    { Update database }
    SavePhoneDataFiles(True);
  finally
    FreeProgressDialog;
    nl.Free;
    frmInfoView.linkGetMessages.Enabled := True;
  end;
  Status(_('Sync Text Messages completed.'));
  Log.AddSynchronizationMessage('Sync Text Messages completed.');
end;

procedure TForm1.ToolButton15Click(Sender: TObject);
begin
  SetExplorerNode(ExplorerNew.GetFirst);
  if ActionConnectionExplorer.Checked then
    ActionConnectionExplorer.Execute;
end;

procedure TForm1.CoolTrayIcon1BalloonHintClick(Sender: TObject);
begin
  if FormStorage1.StoredValue['StartMinimized'] = True then // do not localize
    ActionWindowRestore.Execute
  else
    Application.BringToFront;
end;

procedure TForm1.ActionViewLogExecute(Sender: TObject);
begin
  if IsStartCanceled then exit;

  if not Assigned(FLogForm) then begin
    FLogForm := TfrmLog.Create(Self);
    FLogForm.AlphaBlendValue := FAlphaLog;
    FLogForm.OnDestroy := LogFormDestroy;

    FormStorage1.StoredValue['Log'] := True; // do not localize
  end;

  FLogForm.Show;
end;

procedure TForm1.AddCall(Node: PVirtualNode; contact: WideString;
  time: string; AsFirst: boolean);
var
  itm: PVirtualNode;
  data, data2: PFmaExplorerNode;
begin
  if AsFirst then begin
    itm := ExplorerNew.InsertNode(Node,amAddChildFirst);
    data := ExplorerNew.GetNodeData(Node);
    TStrings(data.Data).Insert(0,WideStringToUTF8String(WideQuoteStr(contact,True) + ',"' + time + '"'));
  end
  else begin
    itm := ExplorerNew.AddChild(Node);
    data := ExplorerNew.GetNodeData(Node);
    TStrings(data.Data).Add(WideStringToUTF8String(WideQuoteStr(contact,True) + ',"' + time + '"'));
  end;
  data2 := ExplorerNew.GetNodeData(itm);
  data2.Text := contact;
  data2.ImageIndex := 52 + (data.StateIndex and FmaNodeSubitemsMask) shr 16;
  data2.StateIndex := Node.ChildCount;

  if (Node = FNodeCallsMissed) and (frmMissedCalls <> nil) then
    with frmMissedCalls.MissedCalls.Items.Add do begin
      Caption := contact;
      SubItems.Add(time);
      ImageIndex := 16;
    end;
  if AsFirst then ReindexCallsNode(Node);
end;

procedure TForm1.InitCalls(Node: PVirtualNode);
var
  k,j,m: integer;
  dtm,typ,str,num,buffer,start,stop: String;
  sl,it,slTmp: TStringList;
  grp: PVirtualNode;
  data: PFmaExplorerNode;
begin
  ExplorerNew.DeleteChildren(Node);
  data := ExplorerNew.GetNodeData(Node);
  TStrings(data.Data).Clear;
  if Node = FNodeCallsMissed then frmMissedCalls.MissedCalls.Clear;
  if frmInfoView.Visible then EBCAState(False);
  { Retrieve Calls now }
  sl := TStringList.Create;
  it := TStringList.Create;
  try
    grp := Node;
    if not CoolTrayIcon1.CycleIcons then
      Status(WideFormat(_('Loading %s calls...'),[data.Text]));
    //with grp do begin
    if grp = FNodeCallsIn then TxAndWait('AT+CPBS="RC"') // do not localize
    else
    if grp = FNodeCallsOut then TxAndWait('AT+CPBS="DC"') // do not localize
    else
    if grp = FNodeCallsMissed then TxAndWait('AT+CPBS="MC"') // do not localize
    else
      Abort;
    TxAndWait('AT+CPBR=?'); // do not localize
    sl.Text := ThreadSafe.RXBuffer.Text;
    buffer := '';
    for m := 0 to sl.Count-1 do
      if Pos('+CPBR',sl[m]) = 1 then begin // do not localize
        buffer := sl[m];
        for k := 1 to length(buffer) do begin
          if IsDelimiter('()-', buffer, k) then buffer[k] := ' ';
        end;
        break;
      end;
    if buffer <> '' then begin
      slTmp := TStringList.Create;
      try
        slTmp.DelimitedText := buffer;
        start := slTmp.Strings[1];
        stop := slTmp.Strings[2];
        TxAndWait('AT+CPBR=' + start + ',' + stop); // do not localize
        it.Text := ThreadSafe.RxBuffer.Text;
        if grp = FNodeCallsMissed then
          frmMissedCalls.MissedCalls.Clear;
        //idx := 1;
        for j := 0 to it.Count - 2 do begin
          if pos('+CPBR', it[j]) = 1 then begin // do not localize
            // could receive this for unknown number ?
            //   +CPBR: 7,"number",145,"name","2004/03/20,12:55"
            buffer := ThreadSafe.RxBuffer.Strings[j];
            k := Pos('"',buffer);
            System.Delete(buffer,1,k-1); // remove up to 1st "
            slTmp.DelimitedText := buffer;
            num := slTmp[0];
            typ := slTmp[1];
            str := slTmp[2];
            dtm := slTmp[3];
            if (num <> '') and (typ = '145') and (num[1] <> '+') then
              num := '+' + num;
            if str = '' then
              { see uMissedCalls for details about when
                sUnknownContact and when sUnknownNumber is used }
              if num <> '' then str := sUnknownContact
                else str := sUnknownNumber;
            if num <> '' then str := str + ' [' + num + ']';
            AddCall(grp,UTF8StringToWideString(str),dtm);
          end;
        end;
      finally
        slTmp.Free;
      end;
    end;
    if not CoolTrayIcon1.CycleIcons then
      Status('');
  finally
    sl.Free;
    it.Free;
    if frmInfoView.Visible then begin
      frmInfoView.UpdateWelcomePage(True);
      EBCAState(True);
    end;
    if frmExplore.Visible then frmExplore.RootNode := ExplorerNew.FocusedNode;
  end;
  //UpdateMEPhonebook;
end;

procedure TForm1.ReindexCallsNode(Node: PVirtualNode);
var
  i: Integer;
  itNode: PVirtualNode;
  data: PFmaExplorerNode;
begin
  i := 0;
  itNode := Node.FirstChild;
  while itNode <> nil do begin
    data := ExplorerNew.GetNodeData(itNode);
    data.StateIndex := i+1;
    itNode := itNode.NextSibling;
    i := i+1;
  end;
end;

function TForm1.ContactNumberByTel(ContactNumber: string): WideString;
begin
  ContactNumber := ExtractNumber(ContactNumber);
  if (ContactNumber <> '') and (ContactNumber <> sUnknownNumber) then
    Result := LookupContact(ContactNumber,sUnknownContact) + ' [' + ContactNumber + ']'
  else
    Result := sUnknownNumber;
end;

function TForm1.ContactNumberByName(ContactName: WideString): WideString;
var
  contact: PContactData;
  simdata: PSIMData;
  Number: WideString;
begin
  Result := '';
  Number := LookupNumber(ContactName);
  if Number = '' then begin
    { not found, look in IrmcSync phonebook }
    if IsIrmcSyncEnabled and frmSyncPhonebook.FindContact(ContactName,contact) then begin
      ContactName := GetContactFullName(contact);
      Number := GetContactDefPhone(contact);
    end;
    { or in Phone Book }
    if (Number = '') and frmMEEdit.FindContact(ContactName,simdata) then begin
      ContactName := simdata^.cname;
      Number := simdata^.pnumb;
    end;
    { or in SIM Book }
    if (Number = '') and frmSMEdit.FindContact(ContactName,simdata) then begin
      ContactName := simdata^.cname;
      Number := simdata^.pnumb;
    end;
    if Number = '' then begin
      { not found again }
      Result := sUnknownNumber;
      exit;
    end;
  end;
  if ContactName = '' then ContactName := sUnknownContact;
  Result := ContactName + ' [' + Number + ']';
end;

function TForm1.GetPartialNumber(Number: string): string;
begin
  Result := copy(Number, length(Number) - 7, 8);
end;

function TForm1.IsT610Clone(BrandName: WideString): boolean;
var
  model: WideString;
begin
  if BrandName = '' then model := FPhoneModel else model := BrandName;
  // do not localize - begin
  Result := (Pos('T610',model) <> 0) or // and T610 clones
            (Pos('T630',model) <> 0) or
            (Pos('Z600',model) <> 0);
  // do not localize - end
end;

function TForm1.IsK610Clone(BrandName: WideString): Boolean;
var
  model: WideString;
begin
  if BrandName = '' then model := FPhoneModel else model := BrandName;
  // do not localize - begin
  Result := (Pos('K610',model) <> 0) or // and T610 clones
            (Pos('K618',model) <> 0) or
            (Pos('K600',model) <> 0) or
            (Pos('K608',model) <> 0) or
            (Pos('K800',model) <> 0) or
            (Pos('V600',model) <> 0) or
            (Pos('V630',model) <> 0) or
            (Pos('Z610',model) <> 0);
  // do not localize - end
end;

function TForm1.IsK700Clone(BrandName: WideString): boolean;
var
  model: WideString;
begin
  if BrandName = '' then model := FPhoneModel else model := BrandName;
  // do not localize - begin
  Result := (Pos('K700',model) <> 0) or
            (Pos('K300',model) <> 0) or //?
            (Pos('K310',model) <> 0) or //?
            (Pos('K500',model) <> 0) or
            (Pos('K510',model) <> 0) or
            (Pos('J300',model) <> 0) or
            (Pos('S700',model) <> 0) or
            (Pos('V800',model) <> 0) or
            (Pos('Z500',model) <> 0) or
            (Pos('Z800',model) <> 0) or
            (Pos('Z1010',model) <> 0);
  // do not localize - end
end;

function TForm1.IsK750Clone(BrandName: WideString): Boolean;
var
  model: WideString;
begin
  if BrandName = '' then model := FPhoneModel else model := BrandName;
  // do not localize - begin
  Result := (Pos('K750',model) <> 0) or // and K750 clones
            (Pos('K790',model) <> 0) or
            (Pos('D750',model) <> 0) or
            (Pos('Z520',model) <> 0);
  // do not localize - end
end;

function TForm1.IsWalkmanClone(BrandName: WideString): Boolean;
var
  model: WideString;
begin
  if BrandName = '' then model := FPhoneModel else model := BrandName;
  // do not localize - begin
  Result := (Pos('W800',model) <> 0) or // and W800 clones
            (Pos('W810',model) <> 0) or
            (Pos('W850',model) <> 0) or
            (Pos('W300',model) <> 0) or
            (Pos('W550',model) <> 0) or
            (Pos('W600',model) <> 0) or
            (Pos('W700',model) <> 0) or
            (Pos('W710',model) <> 0) or
            (Pos('W900',model) <> 0) or
            (Pos('W950',model) <> 0) or
            IsK610Clone(BrandName);     // Ê600+ series also have Walkmen's MediaPlayer
  // do not localize - end
end;

function TForm1.ApplyEditorChanges(SaveOnly: Boolean): boolean;
var
  P: TPoint;
  T,L: integer;
  TempFile: String;
begin
  try
    if frmEditor.Script.Modified then begin
      { Save changes to the script file }
      TempFile := frmEditor.CheckFilename;
      Status(_('Saving changes...'));
      frmEditor.Script.Lines.SaveToFile(TempFile);
      frmEditor.Script.Modified := False;
      frmEditor.Filename := TempFile;
      FScriptFile := TempFile;
      FormStorage1.StoredValue['ScriptFile'] := FScriptFile; // do not localize
      Status(Format(_('Script saved, %d bytes written'),[Length(frmEditor.Script.Text)]));
      { Apply changes to Script control? }
      if not SaveOnly and not FExiting and not FExitWindows then begin
        { On exiting Fma/Windows, TntWindows do not update MS Script control }
        Status(_('Applying changes...'));
        frmEditor.Script.Lines.BeginUpdate;
        P := frmEditor.Script.CaretXY;
        T := frmEditor.Script.TopLine;
        L := frmEditor.Script.LeftChar;
        try
          if FUseScript then ScriptInitialize
            else ScriptingEnable;
        finally
          frmEditor.Script.CaretXY := P;
          frmEditor.Script.TopLine := T;
          frmEditor.Script.LeftChar := L;
          frmEditor.Script.Lines.EndUpdate;
        end;
        Status(_('Script activated'));
      end;
    end;
    if frmEditor.MessagesVisible then Abort;
    Status('');
    Result := True;
  except
    //Status(_('Script save failed or canceled by user!'));
    Result := False;
  end;
end;

procedure TForm1.tbMainMenuCustomDrawButton(Sender: TToolBar;
  Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
const
  Sel: TToolButton = nil;
begin
  if cdsSelected in State then begin
    if FLastMenuButton <> Button then begin
      Sel := Button;
    end;
  end;
  if (State = []) and (Button = Sel) then begin
    if FLastMenuButton <> Button then begin
      ReleaseMainMenuButton;
      FLastMenuButton := Sel;
      Sel.Down := True;
      Sel := nil;
    end;
  end;
end;

procedure TForm1.ReleaseMainMenuButton;
begin
  if FLastMenuButton <> nil then begin
    FLastMenuButton.Down := False;
    FLastMenuButton := nil;
  end;
end;

procedure TForm1.ApplicationEvents1Idle(Sender: TObject;
  var Done: Boolean);
begin
  if FLastMenuButton <> nil then
    { Update main menu tool button }
    ReleaseMainMenuButton;
end;

procedure TForm1.ActionSyncCalendarExecute(Sender: TObject);
begin
  AskRequestConnection;
  if frmInfoView.Visible then EBCAState(False);
  frmInfoView.linkSyncCalendar.Enabled := False;
  try
    try
      frmCalendarView.OnConnected;
      frmCalendarView.btnSYNCClick(nil);

      { Update database }
      SavePhoneDataFiles(True);
    except
      Status(_('Error downloading calendar'));
    end;
  finally
    frmInfoView.linkSyncCalendar.Enabled := True;
    if frmInfoView.Visible then EBCAState(True);
  end;
end;

procedure TForm1.PopupMenu2Popup(Sender: TObject);
begin
  ShowExplorer1.Checked := ActionConnectionExplorer.Checked;
  ShowCaption1.Checked := FShowTodayCaption;
  ShowDiagram1.Checked := FShowDiagram;
end;

procedure TForm1.ShowCaption1Click(Sender: TObject);
begin
  FShowTodayCaption := not FShowTodayCaption;
  FormStorage1.StoredValue['Today Caption'] := FShowTodayCaption; // do not localize
  frmInfoView.UpdateWelcomePage;
end;

procedure TForm1.ShowDiagram1Click(Sender: TObject);
begin
  FShowDiagram := not FShowDiagram;
  FormStorage1.StoredValue['Phone Diagram'] := FShowDiagram; // do not localize
  frmInfoView.UpdateWelcomePage;
end;

procedure TForm1.ActionContactsExportSMUpdate(Sender: TObject);
begin
  (Sender as TTntAction).Enabled := (frmSMEdit.Visible and (frmSMEdit.ListNumbers.SelectedCount <> 0)) or
    (frmMEEdit.Visible and (frmMEEdit.ListNumbers.SelectedCount <> 0));
end;

procedure TForm1.ActionContactsExportUpdate(Sender: TObject);
begin
  ActionContactsExportME.Update;
  ActionContactsExportSM.Update;
  ActionContactsExport.Enabled := ActionContactsExportME.Enabled or ActionContactsExportSM.Enabled;
end;

procedure TForm1.ActionContactsExportExecute(Sender: TObject);
begin
  ActionContactsExportME.Execute;
  ActionContactsExportSM.Execute;
end;

procedure TForm1.ActionContactsImportSMUpdate(Sender: TObject);
begin
  (Sender as TTntAction).Enabled := frmSMEdit.Visible or frmMEEdit.Visible;
end;

procedure TForm1.ActionContactsImportSMExecute(Sender: TObject);
begin
  if frmSMEdit.Visible then frmSMEdit.ImportContacts1.Click
    else frmMEEdit.ImportContacts1.Click;
end;

procedure TForm1.ActionContactsImportUpdate(Sender: TObject);
begin
  ActionContactsImportME.Update;
  ActionContactsImportSM.Update;
  ActionContactsImport.Enabled := ActionContactsImportME.Enabled or ActionContactsImportSM.Enabled;
end;

procedure TForm1.ActionContactsImportExecute(Sender: TObject);
begin
  ActionContactsImportME.Execute;
  ActionContactsImportSM.Execute;
end;

function TForm1.IsMoveToArchiveEnabled: boolean;
begin
  Result := FMsgM and FTextMessageOptions.MoveToArchive;
end;

function TForm1.ExtractContact(ContactNumber: WideString): WideString;
var
  i: integer;
begin
  i := Pos(' [',ContactNumber);
  if i = 0 then
    Result := ContactNumber
  else
    Result := Copy(ContactNumber,1,i-1);
end;

function TForm1.GetChatWindow(Contact: string; AllowCreateNew: boolean): TfrmCharMessage;
var
  i: integer;
  s: string;
  w: WideString;
begin
  Result := nil;
  w := ExtractContact(Contact);
  if WideCompareText(w,Contact) = 0 then begin // only number specified
    s := w;
    w := LookupContact(w,sUnknownContact);
  end
  else
    s := ExtractNumber(Contact);
  for i := 0 to Screen.FormCount-1 do
    if Screen.Forms[i] is TfrmCharMessage then
      if (Screen.Forms[i] as TfrmCharMessage).IsYourNumber(s) then begin
        Result := (Screen.Forms[i] as TfrmCharMessage);
        break;
      end;
  if AllowCreateNew and not Assigned(Result) then begin
    Result := TfrmCharMessage.Create(nil);
    Result.AddRecipient(w + ' [' + s + ']');
    { Apply custom settings }
    if FChatLongSMS then Result.sbLong.Click;
    if FChatBold then Result.Chat.Font.Style := Result.Chat.Font.Style + [fsBold];
  end;
  if Assigned(Result) then Result.AlphaBlendValue := FAlphaCompose;
end;

procedure TForm1.ActionContactsNewChatUpdate(Sender: TObject);
begin
  ActionContactsNewChat.Enabled := IsContactNumberSelected and (LocateSelContactNumber <> sUnknownNumber);
end;

procedure TForm1.ActionContactsNewChatExecute(Sender: TObject);
var
  Number: string;
  Chat: TfrmCharMessage;
begin
  Number := LocateSelContactNumber;
  if Number <> '' then begin
    Chat := GetChatWindow(Number,True);
    Chat.Show;
    Chat.BringToFront;
    Chat.Memo.SetFocus;
  end;
end;

procedure TForm1.ChatNotifyDel(PDU: String);
var
  sms: TSMS;
  chat: TfrmCharMessage;
  ARef, ATot, An: Integer;
begin
  try
    sms := Tsms.Create;
    try
      sms.PDU := PDU;
      chat := GetChatWindow(sms.Number);
      if Assigned(chat) then begin
        GSMLongMsgData(PDU, ARef, ATot, An);
        { Is normal SMS ot first part of Long SMS? }
        if (ATot = -1) or (An = 1) then begin
          chat.AddChatText(_('(Sending canceled, message removed from Outbox)'));
          chat.EnableSending(False);
        end;  
      end;
    finally
      sms.Free;
    end;
  except
  end;
end;

procedure TForm1.HandleCPMS(AMsg: String);
const
  LastWarnTime: TDateTime = 0;
  LimitPercent = 95;
var
  str,location: String;
  used,total,limit: integer;
begin
  // ThreadSafe.LastMessageStore points XX in last command AT+CPMS="XX",...
  // +CPMS: <used1>,<total1>,<used2>,<total2>,<used3>,<total3>
  if FTextMessageOptions.FullWarning then begin
    str := copy(AMsg, 8, length(AMsg));
    used := StrToInt(GetToken(str,0));
    total := StrToInt(GetToken(str,1));
    limit := Round(total * LimitPercent / 100);

    if ThreadSafe.LastMessageStore = 'ME' then location := _('Phonebook')
    else
    if ThreadSafe.LastMessageStore = 'SM' then location := _('SIM')
    else
    location := ThreadSafe.LastMessageStore;

    if used >= limit then
      if ((Now - LastWarnTime) * SecsPerDay) > 300 then begin
        LastWarnTime := Now;
        str := WideFormat(_('%0:s message storage is %1:s%% or more full. Please delete some messages.'), [location, IntToStr(LimitPercent)]);
        Status(str);
        Log.AddMessage(ThreadSafe.LastMessageStore+' memory storage is almost full!', lsDebug); // do not localize debug
        ShowBaloonInfo(str);
      end;
  end;
end;

procedure TForm1.RenderBookmarkList(var rootNode: PVirtualNode);
var
  sl: TStrings;
  i,bindex: integer;
  btitle: WideString;
  node: PVirtualNode;
  data: PFmaExplorerNode;
begin
  data := ExplorerNew.GetNodeData(rootNode);
  sl := data.Data;
  ExplorerNew.DeleteChildren(rootNode);
  for i := 0 to sl.Count-1 do begin
    bindex := StrToInt(GetToken(sl[i],0));
    btitle := UTF8StringToWideString(WideStringToLongString(GetToken(LongStringToWideString(sl[i]),2)));

    node := ExplorerNew.AddChild(rootNode);
    data := ExplorerNew.GetNodeData(node);
    data.Text := btitle;
    data.ImageIndex := 59;
    data.StateIndex := bindex; // abused stateindex = bookmark position
  end;
  frmSyncBookmarks.RenderList;
end;

procedure TForm1.ActionToolsWapHomepageUpdate(Sender: TObject);
begin
  ActionToolsWapHomepage.Enabled := not ThreadSafe.Busy and FConnected and not FObex.Connected and
    (frmSyncBookmarks.MaxHomePageLength > 0);
end;

procedure TForm1.ActionToolsWapHomepageExecute(Sender: TObject);
var
  s: WideString;
  m,i: integer;
begin
  { Get max home page length }
  m := frmSyncBookmarks.MaxHomePageLength;
  { Get current home page }
  TxAndWait('AT*EWHP?'); // do not localize
  for i := 0 to ThreadSafe.RxBuffer.Count-1 do
    if Pos('*EWHP',ThreadSafe.RxBuffer[i]) = 1 then begin
      s := ThreadSafe.RxBuffer[i];
      Delete(s,1,7);
      s := GetToken(s,0); // trim and remove quotes
      if s = '' then s := 'http://'; // do not localize
      if WideInputQuery(_('Edit Wap Home Page'),_('Enter URL:'),s) and (Trim(s) <> '') and (s <> 'http://') then begin
        { Set new page }
        s := Copy(s,1,m);
        { Do not UTF-8 here, or should we? i18n url are possible not }
        if FUseUTF8 then s := WideStringToUTF8String(s);
        try
          TxAndWait('AT*EWHP="' + s + '"'); // do not localize
          Status(_('Home page changed'));
        except
          MessageDlgW(sHomePageLocked,mtError,MB_OK);
        end;
      end;
      break;
    end;
end;

procedure TForm1.DoRemoveBookmark;
var
  Data: PBookmarkData;
  Node: PVirtualNode;
  EData: PFmaExplorerNode;
begin
  if ExplorerNew.FocusedNode = FNodeBookmarks then
    frmSyncBookmarks.btnDELClick(nil);
  if ExplorerNew.FocusedNode.Parent = FNodeBookmarks then begin
    { TODO: Abused StateIndex = bookmark position }
    EData := ExplorerNew.GetNodeData(ExplorerNew.FocusedNode);
    Node := frmSyncBookmarks.FindBookmarkTitle(EData.Text,Data);
    if Assigned(Node) then begin
      frmSyncBookmarks.ListBookmarks.FocusedNode := Node;
      frmSyncBookmarks.btnDELClick(nil);
    end;
  end;
end;

function TForm1.GetDatabasePath: string;
begin
  Result := GetProfilePath+'dat\'; // do not localize
end;

function TForm1.GetProfilePath(OverrideID: string): string;
var
  ID: string;
begin
  if OverrideID = '' then
    { Use currently used phone ID }
    ID := PhoneIdentity
  else
    { Use custom phone ID (override current setting) }
    ID := OverrideID;

  if FindCmdLineSwitch('MIGRATEDB') then begin // do not localize
    { Do we have phone ID at all? Its presence depends on Fma version }
    if ID <> '' then
      if DirectoryExists(ExePath+'data\'+ID) then // do not localize
        { Use "FMA\data" storage folder - compatability mode for Fma 0.1.x and 2.0.x releases
          Later FMA will ask user to migrate database to default AppData\FMA folder }
        Result := ExePath+'data\'+ID+'\' // do not localize
      else
        { Use "Application Data\FMA" storage folder - default for Fma 2.1.x releases }
        Result := GetAppDataPath+'FMA\'+ID+'\' // do not localize
    else
      { Use "FMA" dir as storage folder - compatability mode for Fma pre-0.1.x releases }
      Result := ExePath;
  end
  else begin
    { New fixed setting since FMA 2.1 Beta 3a }
    if ID = '' then ID := DefaultProfileName; // do not localize
    Result := GetAppDataPath+'FMA\'+ID+'\' // do not localize
  end;
end;

procedure TForm1.EditFavorites1Click(Sender: TObject);
var
  sl: TTntStringList;
begin
  with TfrmOrganizeFavs.Create(nil) do
    try
      FavsType := _('Message Recipients'); //TODO -cl10n: localize?
      FavsList := FFavoriteRecipients;
      { Allow multiple contacts per a favorite record }
      // MultiSel := True; { default setting }
      if ShowModal = mrOk then begin
        { Result from FavsList should be handled here, i.e. free-ed manualy! }
        sl := FavsList;
        try
          FFavoriteRecipients.Assign(sl);
        finally
          sl.Free;
        end;
      end;
    finally
      Free;
    end;
end;

procedure TForm1.EditCallFavorites1Click(Sender: TObject);
var
  sl: TTntStringList;
begin
  with TfrmOrganizeFavs.Create(nil) do
    try
      FavsType := _('Call Recipients'); //TODO -cl10n: localize?
      FavsList := FFavoriteCalls;
      { Allow only one contact per a favorite record }
      MultiSel := False;
      if ShowModal = mrOk then begin
        { Result from FavsList should be handled here, i.e. free-ed manualy! }
        sl := FavsList;
        try
          FFavoriteCalls.Assign(sl);
        finally
          sl.Free;
        end;
      end;
    finally
      Free;
    end;
end;

procedure TForm1.ActionContactsVoiceHangupUpdate(Sender: TObject);
begin
  ActionContactsVoiceHangup.Enabled := FConnected and not FObex.Connected and
    (frmCalling <> nil) and (frmCalling.IsTalking or frmCalling.IsCalling);
end;

procedure TForm1.ActionContactsVoiceHangupExecute(Sender: TObject);
begin
  frmCalling.HandupButton.Click;
end;

procedure TForm1.ApplicationEvents1Hint(Sender: TObject);
begin
  if not FConnectingStarted or FConnectingComplete then Status(TntApplication.Hint,False);
end;

procedure TForm1.ActionToolsCreateGroupExecute(Sender: TObject);
var
  s: WideString;
begin
  AskRequestConnection;
  s := '';
  if WideInputQuery(_('Create New Group'),_('Enter group name:'),s) and (Trim(s) <> '') then
    try
      if FUseUTF8 then s := WideStringToUTF8String(s);
      TxAndWait('AT*ESCG="' + s + '"'); // do not localize
      InitGroups;
      Status(_('Group created'));
    except
      Status(_('Group create failed'));
    end;
end;

procedure TForm1.DoRemoveGroup;
var
  Node, grp: PVirtualNode;
  Item: PExploreItem;
  num: string;
  desc: WideString;
begin
  AskRequestConnection;
  if ExplorerNew.FocusedNode = FNodeGroups then begin
    Node := frmExplore.ListItems.FocusedNode;
    Item := frmExplore.ListItems.GetNodeData(Node);
    num := Item.param;
    desc := Item.name;
    if MessageDlgW(WideFormat(_('Are you sure you want to delete group "%s" and all its contents (No Undo)?'),[desc]),
      mtConfirmation, MB_YESNO or MB_DEFBUTTON2) = ID_YES then
      try
        TxAndWait('AT*ESDG='+num); // delete // do not localize
        grp := FindExplorerChildNode(desc,ExplorerNew.FocusedNode);
        if Assigned(grp) then begin
          ExplorerNew.DeleteNode(grp);
          ExplorerNewChange(ExplorerNew,ExplorerNew.FocusedNode);
        end
        else
          InitGroups;
        Status(_('Group deleted'));
      except
        Status(_('Group delete failed'));
      end;
  end;
end;

procedure TForm1.ActionToolsSilentUpdate(Sender: TObject);
begin
  ActionToolsSilent.Checked := FSilentMode;
  ActionToolsSilent.ImageIndex := 57 + byte(FSilentMode);
  if FSilentMode then ActionToolsSilent.Caption := _('Disable &Silent Mode')
    else ActionToolsSilent.Caption := _('Enable &Silent Mode');
  if not FUseSilentMonitor or not FConnected or FObex.Connected or ThreadSafe.ObexConnecting then
    ActionToolsSilent.Enabled := False;
end;

procedure TForm1.ActionToolsSilentExecute(Sender: TObject);
begin
  if IsK750Clone then
    TxAndWait('AT+CSIL='+IntToStr(byte(not FSilentMode))) // do not localize
  else
    TxAndWait('AT*ESIL='+IntToStr(byte(not FSilentMode))); // do not localize
  FSilentMode := not FSilentMode;
end;

procedure TForm1.ActionToolsPowerOffExecute(Sender: TObject);
begin
  MessageBeep(MB_ICONQUESTION);
  if MessageDlgW(_('Are you sure you want to disconnect and power your phone off?'),
    mtConfirmation, MB_YESNO or MB_DEFBUTTON2) = ID_YES then begin
    TxAndWait('AT+CFUN=0'); // do not localize
    ActionConnectionDisconnect.Execute;
  end;
end;

procedure TForm1.Button13Click(Sender: TObject);
  var
    vObjs: TVObjStorage;
    I, J: Integer;
    vCal: TVCalendar;
    vCalEntity: TVCalEntity;
begin
  memo2.Lines.Clear;

  vObjs := TVObjStorage.Create;
  try
    vObjs.Raw := Memo1.Lines.AnsiStrings;
    for I := 0 to vObjs.Count - 1 do
    begin
      case (vObjs[i] as TVBaseObj).VType.EntityType of
        tenVCalendar:
          begin
            vCal := (vObjs[i] as TVCalendar);
            memo2.Lines.Add('Type = ' + vCal.VType.Text); // do not localize
            memo2.Lines.Add('Version = ' + vCal.VVersion); // do not localize
            memo2.Lines.Add('Prod ID = ' + vCal.VProdID); // do not localize
            for J := 0 to vCal.Count - 1 do
            begin
              vCalEntity := (vCal[J] as TVCalEntity);
              memo2.Lines.Add('-----'); // do not localize
              memo2.Lines.Add('Type = ' + vCalEntity.VType.PropertyValue); // do not localize
              memo2.Lines.Add('DT Start = ' + vCalEntity.VDtStart.PropertyValue); // do not localize
              memo2.Lines.Add('DT End = ' + vCalEntity.VDtEnd.PropertyValue); // do not localize
              memo2.Lines.Add('Summary = ' + vCalEntity.VSummary.PropertyValue); // do not localize
              memo2.Lines.Add('Location = ' + vCalEntity.VLocation.PropertyValue); // do not localize
              memo2.Lines.Add('Alarm = ' + vCalEntity.VAAlarm.PropertyValue); // do not localize
              memo2.Lines.Add('Categories = ' + vCalEntity.VCategories.PropertyValue); // do not localize
              memo2.Lines.Add('Class = ' + vCalEntity.VClass.PropertyValue); // do not localize
              memo2.Lines.Add('Completed = ' + vCalEntity.VCompleted.PropertyValue); // do not localize
              memo2.Lines.Add('Status = ' + vCalEntity.VStatus.PropertyValue); // do not localize
              memo2.Lines.Add('Priority = ' + vCalEntity.VPriority.PropertyValue); // do not localize
              memo2.Lines.Add('XLUID = ' + vCalEntity.VIrmcLUID.PropertyValue); // do not localize
            end;
          end;
      end;
    end;
  finally
    vObjs.Free;
  end;
end;

function TForm1.GetAppDataPath: string;
var
  s: string;
begin
  Setlength(s,MAX_PATH);
  SHGetSpecialFolderPath(Handle,@s[1],CSIDL_APPDATA,False);
  Result := StrPas(@s[1])+'\';
end;

procedure TForm1.FormStorage1RestorePlacement(Sender: TObject);
begin
  { Sould we minimize application? }
  if FormStorage1.StoredValue['Always Minimized'] then // do not localize
    FormStorage1.StoredValue['StartMinimized'] := True; // do not localize
  if FormStorage1.StoredValue['StartMinimized'] = True then begin // do not localize
    { Do not flash main form }
    Application.ShowMainForm := False;
    { Minimize to tray area }
    Application.Minimize;
  end;
end;

procedure TForm1.Refresh2Click(Sender: TObject);
begin
  frmInfoView.UpdateWelcomePage(True);
end;

procedure TForm1.UpdateSpecialMonitors; { CMER and EBCA }
begin
  EBCAState(frmInfoView.Visible, FKeyMonitoring and frmInfoView.Visible);

  // Enable Key Monitoring if needed since EBCAState might have disabled it
  // If user disables state checking in Options EBCAState() never enables
  // Key Monitoring back, so we do it here
  if {not frmInfoView.Visible and} FConnected and not FObex.Connected and not ThreadSafe.ObexConnecting and
    FKeyMonitoring and FEBCAKeyMonStopped then
  begin
    TxAndWait('AT+CMER=3,2');
    FEBCAKeyMonStopped := False;
  end;
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
  if Assigned(frmSplash) then frmSplash.Show; // HACK
end;

procedure TForm1.ActionSyncBookmarksExecute(Sender: TObject);
begin
  AskRequestConnection;
  if frmInfoView.Visible then EBCAState(False);
  frmInfoView.linkSyncBookmarks.Enabled := False;
  try
    frmSyncBookmarks.btnSYNCClick(nil);
  finally
    frmInfoView.linkSyncBookmarks.Enabled := True;
    if frmInfoView.Visible then EBCAState(True);
  end;
end;

procedure TForm1.ActionToolsMinuteMinderExecute(Sender: TObject);
begin
  TxAndWait('AT*ESMM='+IntToStr(byte(not FMinuteMinder)));
  FMinuteMinder := not FMinuteMinder;
end;

procedure TForm1.ActionToolsMinuteMinderUpdate(Sender: TObject);
begin
  ActionToolsMinuteMinder.Checked := FMinuteMinder;
  ActionToolsMinuteMinder.ImageIndex := 60 + byte(not FMinuteMinder);
  if FMinuteMinder then ActionToolsMinuteMinder.Caption := 'Disable Minute Minder'
    else ActionToolsMinuteMinder.Caption := 'Enable Minute Minder';
  if not FUseMinuteMonitor or not FConnected or FObex.Connected or ThreadSafe.ObexConnecting then
    ActionToolsMinuteMinder.Enabled := False;
end;

procedure TForm1.ActionViewTBUpdate(Sender: TObject);
var
  Band: TCoolBand;
begin
  Band := nil;
  case (Sender as TTntAction).Tag of
    1: Band := GetAssociatedBand(tbStandard);
    2: Band := GetAssociatedBand(tbPhone);
    3: Band := GetAssociatedBand(tbCalls);
    4: Band := GetAssociatedBand(tbMessages);
    5: Band := GetAssociatedBand(tbProfile);
    6: Band := GetAssociatedBand(tbExplorer);
  end;
  if Assigned(Band) then (Sender as TTntAction).Checked := Band.Visible;
end;

procedure TForm1.ActionViewTBExecute(Sender: TObject);
var
  Band: TCoolBand;
begin
  Band := nil;
  case (Sender as TTntAction).Tag of
    1: Band := GetAssociatedBand(tbStandard);
    2: Band := GetAssociatedBand(tbPhone);
    3: Band := GetAssociatedBand(tbCalls);
    4: Band := GetAssociatedBand(tbMessages);
    5: Band := GetAssociatedBand(tbProfile);
    6: Band := GetAssociatedBand(tbExplorer);
  end;
  if Assigned(Band) then begin
    Band.Visible := not Band.Visible;
    CoolBarChange(nil);
  end;
end;

function TForm1.GetAssociatedBand(Bar: TToolBar): TCoolBand;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to CoolBar.Bands.Count-1 do
    if CoolBar.Bands[i].Control = Bar then begin
      Result := CoolBar.Bands[i];
      break;
    end;
end;

function TForm1.GetBandSettings(Band: TCoolBand): string;
begin
  Result := Format('%s;%d;%d;%d;%d;%d',
    [Band.Control.Name, { This Name setting is used for component lookup only }
     Band.Index,byte(Band.Visible),byte(Band.Break),Band.Control.Left,Band.Control.Width]);
end;

procedure TForm1.SetBandSettings(Band: TCoolBand; Data: WideString);

begin
  { Warning! 'Band.Control.Name' should not be included into Data }
  if Data <> '' then
    try
      Band.Index := StrToInt(GetFirstToken(Data,';'));
      Band.Visible := StrToInt(GetFirstToken(Data,';')) <> 0;
      Band.Break := StrToInt(GetFirstToken(Data,';')) <> 0;
      Band.Control.Left := StrToInt(GetFirstToken(Data,';'));
      Band.Control.Width := StrToInt(GetFirstToken(Data,';'));
    except
    end;
end;

procedure TForm1.FormShow(Sender: TObject);
const
  FirstShow: boolean = True;
var
  Data,a,s: WideString;
  Bar: TComponent;
  Band: TCoolBand;
begin
  if FirstShow then begin
    FirstShow := False;
    s := FormStorage1.StoredValue['Bands']; // do not localize
    while s <> '' do begin
      Data := GetFirstToken(s);
      a := GetFirstToken(Data,';');
      Bar := FindComponent(a);
      if Bar is TToolBar then begin
        Band := GetAssociatedBand(Bar as TToolBar);
        if Assigned(Band) then SetBandSettings(Band,Data);
      end;
    end;
  end;
  if not CheckforUpdate1.Enabled then
    Application.BringToFront; { Do not activate main form if Web Update wizard is started }
  if Visible then begin
    { Update initial view }
    StatusBar.Top := FramePanel.Top + FramePanel.Height;
    Update;
  end;
end;

procedure TForm1.CoolBarChange(Sender: TObject);
var
  i: integer;
  s: string;
begin
  s := '';
  for i := 0 to CoolBar.Bands.Count-1 do begin
    if s <> '' then s := s + ',';
    s := s + GetBandSettings(CoolBar.Bands[i]);
  end;
  FormStorage1.StoredValue['Bands'] := s; // do not localize
end;

procedure TForm1.GettingStarted1Click(Sender: TObject);
begin
  InitNewPhone;
end;

procedure TForm1.ActionIrmcReadyUpdate(Sender: TObject);
begin
  with (Sender as TTntAction) do begin
    Enabled := IsIrmcSyncEnabled and not ThreadSafe.Busy;
  end;
end;

function TForm1.IsIrmcSyncEnabled: boolean;
begin
  { Phonebook is supported only if OBEX and IRMCSYNC are enaled }
  Result := (FUseObex or not FStartupOptions.NoObex) and not FStartupOptions.NoIRMC;
end;

procedure TForm1.WBtSocketSessionAvailable(Sender: TObject; ErrCode: Word);
begin
  Beep;
end;

procedure TForm1.WSocketOnSessionConnect(Sender: TObject; Error: Word);
begin
  if Error <> 0 then begin
    Status(WideFormat(_('Connection Error (0x%s)'),[IntToHex(Error,8)]));
    FConnectionError := True;
  end
  else
    ComPortAfterOpen(nil);
end;

procedure TForm1.WSocketOnSessionClosed(Sender: TObject; Error: Word);
begin
  ComPortAfterClose(ComPort);
end;

function TForm1.getExplorerSelectedNodeLevel1:PVirtualNode;
var
  TreeNode: PVirtualNode;
begin
  result := nil;
  if frmExplore.Visible and
    (Form1.ExplorerNew.FocusedNode <> nil) and
    (frmExplore.ListItems.SelectedCount <> 0) then begin
    TreeNode := Form1.ExplorerNew.FocusedNode;
    if (TreeNode <> nil) and (ExplorerNew.GetNodeLevel(TreeNode) > 1) then
      while ExplorerNew.GetNodeLevel(TreeNode) > 1 do TreeNode := TreeNode.Parent;
    result := TreeNode;
  end;
end;

procedure TForm1.ExceptionTest1Click(Sender: TObject);
begin
  raise Exception.Create(_('This is a test exception which should give a full stack trace'));
end;

procedure TForm1.DoCallContact(ContactNumber: WideString);
begin
  frmCallContact.AlphaBlendValue := FAlphaCall;
  frmCallContact.Show;
  frmCallContact.AddRecipient(ContactNumber);
end;

function TForm1.WhereisContact(SearchFor: WideString; Mode: TFindContactMode): TFindContactResult;
var
  ContactData: PContactData;
  SIMData: PSimData;
  Contact,Number: WideString;
begin
  { Result values could be:
    frNone      - contact not found
    frIrmcSync  - contact found in frmSyncPhonebook
    frPhonebook - contact found in frmMEEdit under FNodeContactsME
    frSIMCard   - contact found in frmSMEdit under FNodeContactsSM }
  Result := frNone;
  case Mode of
    fcByNumber: begin // search by phone number
      Number := ExtractNumber(SearchFor);
      { look in IrmcSync phonebook }
      if IsIrmcSyncEnabled and (frmSyncPhonebook.FindContact(Number) <> '') then
        Result := frIrmcSync;
      { look in Phone Book }
      if (Result = frNone) and (frmMEEdit.FindContact(Number) <> '') then
        Result := frPhonebook;
      { look in SIM Card }
      if (Result = frNone) and (frmSMEdit.FindContact(Number) <> '') then
        Result := frSIMCard;
      {
      if FindExplorerPhoneNode(Number,FNodeContactsME) <> nil then
        Result := frPhonebook
      else
      if FindExplorerPhoneNode(Number,FNodeContactsSM) <> nil then
        Result := frSIMCard;
      }
    end;
    fcByName: begin // search by contact name
      Contact := ExtractContact(SearchFor);
      { look in IrmcSync phonebook }
      if IsIrmcSyncEnabled and frmSyncPhonebook.FindContact(Contact,ContactData) then
        Result := frIrmcSync;
      { look in Phone Book }
      if (Result = frNone) and frmMEEdit.FindContact(Contact,SIMData) then
        Result := frPhonebook;
      { look in SIM Card }
      if (Result = frNone) and frmSMEdit.FindContact(Contact,SIMData) then
        Result := frSIMCard;
      {
      if FindExplorerChildNode(Contact,FNodeContactsME) <> nil then
        Result := frPhonebook
      else
      if FindExplorerChildNode(Contact,FNodeContactsSM) <> nil then
        Result := frSIMCard;
      }
    end;
  end;
end;

function TForm1.FindExplorerPhoneNode(Number: String; RootNode: PVirtualNode): PVirtualNode;
var
  Child,Phone: PVirtualNode;
  EData1, EData2: PFmaExplorerNode;
begin
  { RootNode children should be contacts, their shildren should be Phone numbers.
    It means RootNode could be either FNodeContactsME or FNodeContactsSM or a Group. }
  Phone := nil;
  if RootNode <> nil then begin
    Child := RootNode.FirstChild;
    { Iterate throuth contacts }
    while (Phone = nil) and (Child <> nil) do begin
      EData1 := ExplorerNew.GetNodeData(Child);
      if EData1.ImageIndex = 8 then begin // check only contacts
        Phone := Child.FirstChild;
        { Check each contact phones }
        while Phone <> nil do begin
          EData2 := ExplorerNew.GetNodeData(Phone);
          if AnsiCompareStr(GetPartialNumber(EData2.Text),GetPartialNumber(Number)) = 0 then
            break;
          Phone := Phone.NextSibling;
        end;
      end;
      Child := Child.NextSibling;
    end;
  end;
  Result := Phone;
end;

procedure TForm1.ActionViewPropertiesUpdate(Sender: TObject);
begin
  ActionViewProperties.Enabled := (ExplorerNew.FocusedNode <> nil) or
    (frmSyncBookmarks.Visible and (frmSyncBookmarks.ListBookmarks.SelectedCount = 1)) or
    (frmSyncPhonebook.Visible and (frmSyncPhonebook.ListContacts.SelectedCount = 1)) or
    (frmMEEdit.Visible and (frmMEEdit.ListNumbers.SelectedCount = 1)) or
    (frmSMEdit.Visible and (frmSMEdit.ListNumbers.SelectedCount = 1)) or
    (frmMsgView.Visible and (frmMsgView.ListMsg.SelectedCount = 1)) or
    (frmExplore.Visible and (frmExplore.ListItems.SelectedCount = 1)) or
    (frmInfoView.Visible and IsContactNumberSelected and (WhereisContact(LocateSelContactNumber,fcByNumber) <> frNone));
end;

procedure TForm1.ActionViewPropertiesExecute(Sender: TObject);
  procedure DefaultProps;
  begin
    { fallback to Explorer again }
    if ExplorerNew.FocusedNode <> nil then
      Properties1.Click
  end;
begin
  if ActiveControl = ExplorerNew then
    Properties1.Click
  else
  if frmSyncBookmarks.Visible then
    frmSyncBookmarks.Properties1.Click
  else
  if frmSyncPhonebook.Visible then
    frmSyncPhonebook.Properties1.Click
  else
  if frmMEEdit.Visible then
    frmMEEdit.Properties1.Click
  else
  if frmSMEdit.Visible then
    frmSMEdit.Properties1.Click
  else
  if frmMsgView.Visible then
    frmMsgView.Properties1.Click
  else
  if frmExplore.Visible then
    frmExplore.Properties1.Click
  else
  if frmInfoView.Visible then begin
    frmInfoView.PopupMenu2Popup(nil);
    if frmInfoView.Properties1.Enabled then
      frmInfoView.Properties1.Click;
  end
  else
    DefaultProps;
end;

procedure TForm1.SetTaskPercentageInc;
begin
  pbTask.StepForward;
  StatusBarResize(nil);
end;

procedure TForm1.SetTaskPercentage(Pos, Max: Integer; Loop: Boolean);
begin
  if Pos <> -1 then begin
    if pbTask.UnknownMax <> Loop then begin
      pbTask.Max := Max;
      pbTask.Position := Pos;
      pbTask.UnknownMax := Loop;
    end;
    if Loop then begin
      pbTask.StepForward;
    end
    else begin
      pbTask.Max := Max;
      pbTask.Position := Pos;
    end;
    StatusBar.Panels[5].Bevel := pbLowered;
  end
  else begin
    pbTask.Position := 0;
    StatusBar.Panels[5].Bevel := pbNone;
  end;
  StatusBarResize(nil);
end;

procedure TForm1.StatusBarResize(Sender: TObject);
var
  i: integer;
begin
  with StatusBar do begin
    i := Panels[0].Width + Panels[1].Width + Panels[2].Width + Panels[3].Width;
    Panels[4].Width := Width - i - 100 + Panels[5].Width * byte(Panels[5].Bevel = pbNone);
  end;
end;

function TForm1.CanShowProgressDialog: boolean;
begin
  { Can we show dialog (delayed or not)? Or we'll use status bar indicator only }
  Result := not FDontProgress and not FProgressIndicatorOnly;
end;

function TForm1.CheckScriptEditorExt: boolean;
begin
  Result := True;
  if not FileExists(ExpandFileName(FScriptEditor)) and
    (WideCompareText(FScriptEditor,'notepad.exe') <> 0) then begin // do not localize
    Log.AddScriptMessage(_('[Script] Script editor executable not found, using "notepad.exe" instead.'), lsError);
    FScriptEditor := 'notepad.exe'; // do not localize
    Result := False;
  end;
end;

procedure TForm1.ScriptingEnable(NewScriptFile: String);
begin
  { First save the old script if modified }
  ApplyEditorChanges(True);
  { Enable scripting }
  FUseScript := True;
  FormStorage1.StoredValue['UseScript'] := FUseScript; // do not localize
  { Change script file if needed }
  if NewScriptFile <> '' then begin
    FScriptFile := NewScriptFile;
    FormStorage1.StoredValue['ScriptFile'] := FScriptFile; // do not localize
  end;
  { Then start script engine }
  FScriptInitialized := False;
  ScriptInitialize;
  if FScriptInitialized then
    if FConnected and FConnectingComplete and not FObex.Connected and not ThreadSafe.ObexConnecting then
      ScriptEvent('OnConnected', []); // do not localize
end;

procedure TForm1.ScriptingDisable;
begin
  if FScriptInitialized then
    if FConnected and FConnectingComplete and not FObex.Connected and not ThreadSafe.ObexConnecting then
      ScriptEvent('OnDisconnected', []); // do not localize
  ApplyEditorChanges(True);
  ScriptingCleanup;
  Log.AddScriptMessage('Script: Unloaded OK', lsDebug); // do not localize debug
end;

function TForm1.GetSMSMembers(Index: Integer; NodeData: TStringList; var Members: TStringList): boolean;
const
  slEmpty: Integer = -1;
var
  i, IndexRef, IndexTotal, ARef, ATot, An: Integer;
  pdu: String;
  Item, FoundCount: Integer;
  GoDown, NoGoDown, NoGoUp: Boolean;
  function ValidIndex(Item: Integer): boolean;
  begin
    Result := (Item >= 0) and (Item < NodeData.Count);
  end;
begin
  Result := False;
  { This function will return a list of SMS parts where where Objects property contains corresponding
    Index in NodeData }
  Members.Clear;
  if ValidIndex(Index) then begin
    pdu := GetToken(NodeData[Index],5);
    GSMLongMsgData(pdu, IndexRef, IndexTotal, An);
    if IndexTotal > 1 then begin
      { Long SMS }
      FoundCount := 0;
      NoGoDown := False;
      NoGoUp := False;
      GoDown := True;
      Item := Index;
      while Members.Count < IndexTotal do
        Members.AddObject('',Pointer(slEmpty));
      while ValidIndex(Item) do begin
        pdu := GetToken(NodeData[Item],5);
        GSMLongMsgData(pdu, ARef, ATot, An);
        if (ARef = IndexRef) and (ATot = IndexTotal) then
          if (An > 0) and (An <= Members.Count) then begin
            Members[An-1] := pdu;
            Members.Objects[An-1] := Pointer(Item);
            inc(FoundCount);
            if FoundCount = IndexTotal then
              break;
          end;
        { Move to next item }
        if GoDown then begin
          if ValidIndex(Item+1) then Inc(Item)
          else begin
            NoGoDown := True;
            GoDown := False;
            Item := Index;
          end;
        end;
        if not GoDown then begin
          if ValidIndex(Item-1) then Dec(Item)
          else NoGoUp := True;
        end;
        { Searched entire list? }
        if NoGoDown and NoGoUp then break; // All parts could not be found
      end;
      if FoundCount <> IndexTotal then begin
        { On failure, Members list will contain partialy collected message parts.
          All 'empty' positions are removed. }
        i := 0;
        while i < Members.Count do begin
          if Integer(Members.Objects[i]) = slEmpty then
            Members.Delete(i)
          else
            Inc(i);
        end;
        Result := False;
      end
      else
        Result := True;
    end
    else begin
      { Normal SMS }
      Members.AddObject(pdu,Pointer(Index));
      Result := True;
    end;
  end;
end;

procedure TForm1.DoProcessInbox;
const
  sem: Boolean = False;
  slProcessed  = $01;
  slFileOK     = $02;
var
  Index,i,j,memType: Integer;
  memLocation: String;
  LongText: WideString;
  Received: TDateTime;
  str,sender,who: WideString;
  found,KeepInInbox,DBModified: Boolean;
  sms: Tsms;
  sl,ml,fl: TStringList;
  chat: TfrmCharMessage;
  DeliveryNode,MsgNode: PVirtualNode;
  EData: PFmaExplorerNode;
begin
  if not sem then begin
    sem := True;
    try
      { Check FNewPDUList for any downloaded messages and process them }
      if FNewPDUList.Count <> 0 then begin
        DBModified := False;
        sl := TStringList.Create;
        ml := TStringList.Create; // message parts list
        fl := TStringList.Create; // modified folders list
        try
          { use Objects property as a flag if item is processed }
          for i := 0 to FNewPDUList.Count-1 do
            FNewPDUList.Objects[i] := nil;

          i := 0;
          while i < FNewPDUList.Count do begin
            if FNewPDUList.Objects[i] = nil then begin
              { Check if entire message is received (in case of Long SMS) }
              found := GetSMSMembers(i,FNewPDUList,ml);

              { Mark parts as processed }
              for j := 0 to ml.Count-1 do
                FNewPDUList.Objects[Integer(ml.Objects[j])] := Pointer(slProcessed);

              if found then begin
                DeliveryNode := FNodeMsgArchive;

                { Entire message found - file it in folders and show it to user }
                LongText := '';
                who := sUnknownContact;
                sender := sUnknownNumber;
                Received := Now;
                chat := nil;
                j := 0;
                while j < ml.Count do begin
                  try
                    sms := Tsms.Create;
                    try
                      sms.PDU := ml[j];
                      if j = 0 then begin
                        { First message part - extract sender information etc. }
                        if sms.Number <> '' then begin
                          who := LookupContact(sms.Number);
                          if who = '' then who := sUnknownContact;
                          sender := who + ' [' + sms.Number + ']';
                          DeliveryNode := GetSMSDeliveryNode(sender);
                        end;
                        chat := GetChatWindow(sms.Number);
                        Received := sms.TimeStamp;
                      end;
                      LongText := LongText + sms.Text;
                    finally
                      sms.Free;
                    end;
                    inc(j);
                  except
                    break;
                  end;
                end;

                { All message parts received OK? }
                if j = ml.Count then begin
                  { Show otification icon }
                  NewMessageTrayIcon.IconVisible := True;
                  NewMessageTrayIcon.IconIndex := 14;
                  { Yes, Notify user }
                  PlaySound(pChar('FMA_SMSReceived'), 0, SND_ASYNC or SND_APPLICATION or SND_NODEFAULT); // do not localize
                  { Show baloon on first message only }
                  if FMsgM and not FTextMessageOptions.NoBaloon then begin
                    CoolTrayIcon1.HideBalloonHint; // hide current baloon if any
                    ShowBaloonInfo(_('New message received.'),60,NewMessageTrayIcon);
                  end;

                  { Check where to put message parts }
                  KeepInInbox := not IsMoveToArchiveEnabled and not Assigned(chat); // always move chat messages to archive and delete them
                  MsgNode := DeliveryNode;
                  fl.Clear;
                  for j := 0 to ml.Count-1 do begin
                    { File message part }
                    str := FNewPDUList[Integer(ml.Objects[j])];
                    memType := StrToInt(GetToken(str,0));
                    index := StrToInt(GetToken(str,1));
                    if memType = 1 then memLocation := 'ME' else memLocation := 'SM'; // do not localize
                    if not KeepInInbox then begin
                      try
                        TxAndWait('AT+CPMS="' + memLocation + '"'); // select read and delete phonebook // do not localize
                        TxAndWait('AT+CMGD=' + IntToStr(index));    // delete from phone // do not localize
                        memType := 3; // message moved to archive, i.e. stored in PC
                      except
                        KeepInInbox := True;
                      end;
                    end;
                    if KeepInInbox then begin
                      SaveMsgToFolder(FNodeMsgInbox,ml[j],False,chat = nil,False,index); // put in inbox
                      EData := ExplorerNew.GetNodeData(FNodeMsgInbox);
                      if fl.IndexOf(EData.Text) = -1 then
                        fl.AddObject(EData.Text, Pointer(FNodeMsgInbox));
                      MsgNode := FNodeMsgInbox;
                    end
                    else begin
                      SaveMsgToFolder(DeliveryNode,ml[j],False,chat = nil,False); // put in archive
                      EData := ExplorerNew.GetNodeData(DeliveryNode);
                      if fl.IndexOf(EData.Text) = -1 then
                        fl.AddObject(EData.Text, Pointer(DeliveryNode));
                    end;
                    { sl list will contain modified str values with message part index, type and pdu
                      which are needed for displaying popup window. }
                    Delete(str,1,Length(GetToken(str,0))+1);
                    sl.Add(IntToStr(memType)+','+str);
                    { Mark message parts as Shown - needed for debug only! }
                    FNewPDUList.Objects[Integer(ml.Objects[j])] := Pointer(slFileOK);
                  end;
                  { Refresh folders if needed }
                  for j := 0 to fl.Count-1 do begin
                    DeliveryNode := PVirtualNode(fl.Objects[j]);
                    UpdateNewMessagesCounter(DeliveryNode);
                    if (ExplorerNew.FocusedNode = DeliveryNode) and frmMsgView.Visible then begin
                      EData := ExplorerNew.GetNodeData(DeliveryNode);
                      frmMsgView.RenderListView(TStringList(EData.Data));
                    end;
                  end;
                  DBModified := True;

                  { Notify Chat }
                  if Assigned(chat) then begin
                    chat.Show;
                    chat.BringToFront;
                    chat.AddChatText(who,LongText,Received);
                  end;

                  { Notify user }
                  if Assigned(chat) or FTextMessageOptions.NoPopup then begin // do not popup chat messages
                    if not FTextMessageOptions.NoBaloon then begin
                      { If not Popup, but Baloon, then show msg text in tray icon baloon tooltip }
                      NewMessageTrayIcon.ShowBalloonHint(WideFormat(_('New message from %s'), [who]),LongText,bitNone,60);
                    end;
                  end
                  else
                    if (sl.Count <> 0) and (LongText <> '') then begin
                      { Chat is not visible, so show a popup dialog }
                      with TfrmNewMessage.CreateMsg(sender, LongText, FAlphaCompose) do begin
                        { sl list contains values with message part index, type and pdu for each message part }
                        Members.AddStrings(sl);
                        IsLongSMS := sl.Count > 1;
                        FolderNode := MsgNode;
                      end;
                    end;

                  { Notify script }
                  try
                    ScriptEvent('OnNewSMS', [Sender, LongText]);; // do not localize
                  except
                  end;
                end;
              end;
            end;
            inc(i);
          end;

          { Clear all processed messages from list }
          i := 0;
          while i < FNewPDUList.Count do begin
            if Integer(FNewPDUList.Objects[i]) = slFileOK then
              FNewPDUList.Delete(i)
            else
              Inc(i);
          end;
        finally
          sl.Free;
          ml.Free;
          fl.Free;
          if DBModified then begin
            { Update database }
            SavePhoneDataFiles(True);
            { Update view }
            ExplorerNewChange(ExplorerNew, ExplorerNew.FocusedNode);
          end;

          if FNewPDUList.Count <> 0 then begin
            if (LastSMSReceiveFailure = 0) and FTextMessageOptions.NoBaloon then
              ShowBaloonError(_('Inbox receive failed and suspended temporary!'),30);
            Status(_('Inbox receive failed and suspended temporary'));
            frmInfoView.linkSendMessages.Enabled := True;
          end
          else begin
            if FTextMessageOptions.NoBaloon then
              ShowBaloonInfo(_('Incoming messages received successfuly.'));
            Status(_('Inbox receive completed'));
          end;
        end;
      end;
    finally
      sem := False;
    end;
  end;
end;

procedure TForm1.HandleCMTI(AMsg: String);
begin
  FNewMessageList.Add(AMsg); // Add msg to queue, will download later (see timer2)
end;

procedure TForm1.DoCleanupOutbox;
const
  slFailed = $01;
var
  sl,ml: TStringList;
  i,j: Integer;
  data: PFmaExplorerNode;
begin
  sl := TStringList.Create;
  ml := TStringList.Create;
  try
    data :=ExplorerNew.GetNodeData(FNodeMsgOutbox);
    sl.AddStrings(TStrings(data.Data));
    for i := 0 to sl.Count-1 do
      sl.Objects[i] := nil; // Objects will be used as flag if message is processed, so clear it now

    { Perform cleanup }
    i := 0;
    while i < sl.Count do begin
      { Is message processed or sent? }
      if sl.Objects[i] = nil then begin
        if not GetSMSMembers(i,sl,ml) then
          { Mark all partially stored Messages parts as 'failed'
            ml list will contain partially stored parts and indexes. }
          for j := 0 to ml.Count-1 do
            sl.Objects[Integer(ml.Objects[j])] := Pointer(slFailed);
      end;
      inc(i);
    end;

    { Clear all failed messages from list }
    i := 0;
    while i < sl.Count do begin
      if Integer(sl.Objects[i]) = slFailed then begin
        Log.AddMessage('Database: Cleanup Outbox incomplete message position '+IntToStr(i)+' (ERROR)',lsDebug); // do not localize debug
        sl.Delete(i);
        TStrings(data.Data).Delete(i);
      end
      else
        Inc(i);
    end;
  finally
    ml.Free;
    sl.Free;
  end;
end;

procedure TForm1.ScriptingCleanup;
begin
  try
    { Dako: Recreate entire script control component in order
      to avoid memory leaks... maybe }
    frmEditor.Script.ClearAll;
    frmEditor.Filename := '';
    try
      FAccessoriesMenu := nil;
      try
        ScriptControl.Code.Clear;
        ScriptControl.AutoObjects.Clear;
      finally
        ScriptControl.Free;
      end;
    except
    end;
    ScriptControl := TawScriptControl.Create(Self);
    ScriptControl.OnCallFunction := ScriptControlCallFunction;
    ScriptControl.OnError := ScriptControlError;
  except
    Log.AddMessage(_('ERROR: Can not load cleanup automation objects'), lsError);
  end;
end;

function TForm1.IsStartCanceled: boolean;
begin
  Result := FmaWebUpdate1.Active or FNotFirstInstance;
end;

procedure TForm1.FmaWebUpdate1AfterUpdate(Sender: TObject; Text: String);
begin
  FJustWebUpdated := True;
end;

procedure TForm1.OnOutlookConflictChanges(Sender: TObject;
  const TargetName, Option1Name, Option2Name: WideString);
begin
  with TfrmConflictChanges.Create(nil) do
  try
    Target := TargetName;
    Option1 := Option1Name;
    Option2 := Option2Name;

    if WideCompareStr(FOutlookConflict1.Title,FOutlookConflict2.Title) <> 0 then
      AddChange(_('Title'),FOutlookConflict1.Title,FOutlookConflict2.Title);

    if WideCompareStr(FOutlookConflict1.Name,FOutlookConflict2.Name) <> 0 then
      AddChange(_('Name'),FOutlookConflict1.Name,FOutlookConflict2.Name);

    if WideCompareStr(FOutlookConflict1.SurName,FOutlookConflict2.SurName) <> 0 then
      AddChange(_('Surname'),FOutlookConflict1.SurName,FOutlookConflict2.SurName);

    if WideCompareStr(FOutlookConflict1.FullName,FOutlookConflict2.FullName) <> 0 then
      AddChange(_('Full Name'),FOutlookConflict1.FullName,FOutlookConflict2.FullName);

    if WideCompareStr(FOutlookConflict1.Organization,FOutlookConflict2.Organization) <> 0 then
      AddChange(_('Organization'),FOutlookConflict1.Organization,FOutlookConflict2.Organization);

    if WideCompareStr(FOutlookConflict1.EMail,FOutlookConflict2.EMail) <> 0 then
      AddChange(_('E-mail'),FOutlookConflict1.EMail,FOutlookConflict2.EMail);

    if WideCompareStr(FOutlookConflict1.HomePhone,FOutlookConflict2.HomePhone) <> 0 then
      AddChange(_('Home Phone'),FOutlookConflict1.HomePhone,FOutlookConflict2.HomePhone);

    if WideCompareStr(FOutlookConflict1.WorkPhone,FOutlookConflict2.WorkPhone) <> 0 then
      AddChange(_('Work Phone'),FOutlookConflict1.WorkPhone,FOutlookConflict2.WorkPhone);

    if WideCompareStr(FOutlookConflict1.CellPhone,FOutlookConflict2.CellPhone) <> 0 then
      AddChange(_('Cell Phone'),FOutlookConflict1.CellPhone,FOutlookConflict2.CellPhone);

    if WideCompareStr(FOutlookConflict1.FaxPhone,FOutlookConflict2.FaxPhone) <> 0 then
      AddChange(_('Fax Number'),FOutlookConflict1.FaxPhone,FOutlookConflict2.FaxPhone);

    if WideCompareStr(FOutlookConflict1.OtherPhone,FOutlookConflict2.OtherPhone) <> 0 then
      AddChange(_('Other Phone'),FOutlookConflict1.OtherPhone,FOutlookConflict2.OtherPhone);

    if WideCompareStr(FOutlookConflict1.Street,FOutlookConflict2.Street) <> 0 then
      AddChange(_('Street'),FOutlookConflict1.Street,FOutlookConflict2.Street);

    if WideCompareStr(FOutlookConflict1.City,FOutlookConflict2.City) <> 0 then
      AddChange(_('City'),FOutlookConflict1.City,FOutlookConflict2.City);

    if WideCompareStr(FOutlookConflict1.Region,FOutlookConflict2.Region) <> 0 then
      AddChange(_('Region'),FOutlookConflict1.Region,FOutlookConflict2.Region);

    if WideCompareStr(FOutlookConflict1.PostalCode,FOutlookConflict2.PostalCode) <> 0 then
      AddChange(_('Postal Code'),FOutlookConflict1.PostalCode,FOutlookConflict2.PostalCode);

    if WideCompareStr(FOutlookConflict1.Country,FOutlookConflict2.Country) <> 0 then
      AddChange(_('Country'),FOutlookConflict1.Country,FOutlookConflict2.Country);

    if ChangeCount <> 0 then ShowModal
      else MessageDlgW(_('No changes found.'), mtInformation, MB_OK);
  finally
    Free;
  end;
end;

procedure TForm1.WM_SYSCOLORCHANGE(var Msg: TMessage);
begin
  inherited;
  if FAppInitialized then UpdateColorScheme;
end;

procedure TForm1.UpdateColorScheme;
var
  i: Integer;
  function ShiftColor(Value,Shift: integer): Byte;
  begin
    inc(Value,Shift);
    if Value < 0 then Value := 0;
    if Value > 255 then Value := 255;
    Result := Value;
  end;
begin
  with LMDFill1.FillObject.Gradient do begin
    i := ColorToRGB(clActiveCaption);
    i := (ShiftColor(i and $FF0000 shr 16, 16) shl 16) or (ShiftColor(i and $FF00 shr 8, 16) shl 8) or ShiftColor(i and $FF, 16);
    Color := i;
    i := ColorToRGB(clActiveCaption);
    i := (ShiftColor(i and $FF0000 shr 16,-64) shl 16) or (ShiftColor(i and $FF00 shr 8,-64) shl 8) or ShiftColor(i and $FF,-64);
    EndColor := i;
  end;
  if IsRightToLeft and Assigned(frmInfoView) then with frmInfoView.LMDFill2.FillObject.Gradient do begin
    Color := ColorToRGB(clBtnFace);
    EndColor := ColorToRGB(clWindow);
  end;
end;

function TForm1.IsStartCompleted: boolean;
begin
  Result := not IsStartCanceled and FAppInitialized and not Assigned(frmSplash);
end;

function TForm1.LookupContactGroups(Contact: WideString): String;
var
  itNode: PVirtualNode;
  procedure ScanGroup(RootNode: PVirtualNode);
  var
    Node: PVirtualNode;
    EData: PFmaExplorerNode;
  begin
    Node := RootNode.FirstChild;
    while Node <> nil do begin
      EData := ExplorerNew.GetNodeData(Node);
      if EData.ImageIndex = 58 then // group
        ScanGroup(Node);
      Node := Node.NextSibling;
    end;
    Node := FindExplorerChildNode(Contact,RootNode);
    if Assigned(Node) then begin
      EData := ExplorerNew.GetNodeData(Node);
      if EData.ImageIndex = 8 then begin // contact
        if Result <> '' then Result := Result + ',';
        EData := ExplorerNew.GetNodeData(RootNode);
        Result := Result + WideQuoteStr(EData.Text);
      end;
    end;
  end;
begin
  Result := '';
  { This function will return comma-separated list of Groups
    to which this contact belongs. }
  Contact := ExtractContact(Contact);
  itNode := FNodeGroups.FirstChild;
  while itNode <> nil do begin
    ScanGroup(itNode);
    itNode := itNode.NextSibling;
  end;
end;

procedure TForm1.AskRequestConnection;
begin
  if not FConnected then begin
    MessageBeep(MB_ICONQUESTION);
    if MessageDlgW(_('Phone is disconnected. Do you want to connect now?'),
      mtConfirmation, MB_YESNO) <> ID_YES then
      Abort; // cancel operation!
  end;
  RequestConnection;
end;

procedure TForm1.ActionSyncClockExecute(Sender: TObject);
var
  s,LYear,LHour,LZone: string;
  TimeZone: TTimeZoneInformation;
  Err: WideString;
begin
  AskRequestConnection;
  try
    { If connecting just check, dont show info messages }
    if not CoolTrayIcon1.CycleIcons then begin
      Status(_('Start Sync Phone Clock....'));
      Log.AddSynchronizationMessage(_('Sync Phone Clock started.'));
    end;
    { Reading phone clock setting }
    TxAndWait('AT+CCLK?'); // do not localize
    if FSyncClockPrio = 0 then
      Log.AddSynchronizationMessage(_('Clock Sync Priority set to Phone: will not update.'), lsInformation);
    { Can we sync? }
    if not CoolTrayIcon1.CycleIcons and FDoSyncClock and (FSyncClockPrio <> 0) and
      ((FSyncClockPrio = 1) or (MessageDlgW(_('Phone clock is not synchronized with PC clock.')+' '+
      _('Do you wish to update it now?'),mtConfirmation, MB_YESNO) = ID_YES)) then begin
      LYear := FormatDateTime('yy"/"mm"/"dd',Date); // do not localize
      LHour := FormatDateTime('hh":"nn":"ss',Time); // do not localize
      if FLastClockTZ <> '' then
        if GetTimeZoneInformation(TimeZone) > TIME_ZONE_ID_UNKNOWN then begin
          // do not localize next 4 lines
          LZone := Format('%.2d',[TimeZone.Bias div 15]);
          if LZone[1] = '-' then LZone[1] := '+'
            else if LZone <> '00' then LZone := '-'+LZone
                 else LZone := '+'+LZone;
        end
        else
          LZone := FLastClockTZ
      else
        LZone := ''; // phone doesn't report time zone, so don't set it
      s := '"'+LYear+','+LHour+LZone+'"';
      try
        TxAndWait('AT+CCLK='+s); // do not localize
        Log.AddSynchronizationMessage('CLOCK: Phone clock synchronized OK!', lsDebug); // do not localize debug
        FDoSyncClock := False;
        if not FStartupOptions.NoBaloons then
          ShowBaloonInfo(_('Phone clock synchronized successfully.'));
      except
        on E: Exception do begin
          Err := WideFormat(_('Error: Sync Phone Clock aborted - %s'), [E.Message]);
          Status(Err);
          Log.AddSynchronizationMessage(Err, lsError);
          { TODO: Made clock baloon optional }
          ShowBaloonError(_('Phone clock synchronization failed!'),30);
        end;
      end;
    end;
    if not CoolTrayIcon1.CycleIcons then begin
      Status(_('Sync Phone Clock completed.'));
      Log.AddSynchronizationMessage(_('Sync Phone Clock completed.'));
    end;
  except
    on E: Exception do begin
      Err := WideFormat(_('Error: Reading Phone Clock failed - %s'), [E.Message]);
      Form1.Status(Err);
      Log.AddCommunicationMessage(Err, lsError);
    end;
  end;
end;

procedure TForm1.ExplorerDelFromGroup(GroupIndex: integer; Contact: WideString);
var
  Node,Whom,DelNode: PVirtualNode;
  EData1, EData2 : PFmaExplorerNode;
begin
  DelNode := nil;
  Node := FNodeGroups.FirstChild;
  while Assigned(Node) do begin
    EData1 := ExplorerNew.GetNodeData(Node);
    if EData1.StateIndex = GroupIndex then begin
      Whom := Node.FirstChild;
      while Assigned(Whom) do begin
        EData2 := ExplorerNew.GetNodeData(Whom);
        if Assigned(DelNode) then
          EData2.StateIndex := EData2.StateIndex-1;
        if WideCompareStr(EData2.Text,Contact) = 0 then begin
          DelNode := Whom;
        end;
        Whom := Whom.NextSibling;
      end;
      break;
    end;
    Node := Node.NextSibling;
  end;
  if Assigned(DelNode) then begin
    ExplorerNew.DeleteNode(DelNode);
    { update view if in group view }
    EData1 := ExplorerNew.GetNodeData(ExplorerNew.FocusedNode);
    if (EData1 <> nil) and (EData1.ImageIndex = 58) then
      ExplorerNewChange(ExplorerNew,ExplorerNew.FocusedNode);
  end;
end;

procedure TForm1.ActionViewAddFolderUpdate(Sender: TObject);
var
  EData: PFmaExplorerNode;
begin
  EData := ExplorerNew.GetNodeData(ExplorerNew.FocusedNode);
  ActionViewAddFolder.Visible := (EData <> nil) and
    (EData.StateIndex and $F00000 = FmaMessagesRootFlag) and
    (ExplorerNew.FocusedNode <> FNodeMsgOutbox) and (ExplorerNew.FocusedNode <> FNodeMsgDrafts);
  ActionViewAddFolder.Enabled := ActionViewAddFolder.Visible;
end;

procedure TForm1.ActionViewAddFolderExecute(Sender: TObject);
var
  w: WideString;
begin
  w := '';
  if WideInputQuery(_('Create Folder'),_('Enter folder name:'),w) then
    if Trim(w) <> '' then
      if FindExplorerChildNode(w,ExplorerNew.FocusedNode) = nil then begin
        SMSNewFolder(ExplorerNew.FocusedNode,w);
        ExplorerNew.Selected[ExplorerNew.FocusedNode] := true;;
      end
      else
        MessageDlgW(_('Folder alerady exists.'),mtError,MB_OK)
    else
      MessageDlgW(_('You have to enter folder name.'),mtError,MB_OK);
end;

procedure TForm1.ExplorerNewFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  EData: PFmaExplorerNode;
begin
  EData := Sender.GetNodeData(Node);
  if Assigned(EData) then
    try
      if (Node = FNodeMsgInbox) or (Node = FNodeMsgOutbox) or (Node = FNodeMsgSent) or
         (Node = FNodeMsgArchive) or (Node = FNodeMsgDrafts) or (Node = FNodeContactsME) or
         (Node = FNodeContactsSM) or (Node = FNodeCallsIn) or (Node = FNodeCallsOut) or
         (Node = FNodeCallsMissed) or (Node = FNodeBookmarks) or (Node = FNodeAlarms) or
         (EData.StateIndex = FmaSMSSubFolderFlag) then TStringList(EData.Data).Free;
    finally
      Finalize(EData.Text);
    end;
end;

procedure TForm1.SMSToFolder(FolderNode: PVirtualNode);
var
  total: Integer;
  //i: Integer;
  //index, location: Integer;
  //pdu: string;
  node,curr: PVirtualNode;
  data: PFmaExplorerNode;
  item: PListData;
  //sl: TStringList;
  wl : TTntStringList;
  Ref, Tot, N, j: Integer;
begin
  if not Assigned(FolderNode) or (frmMsgView.ListMsg.SelectedCount = 0) then
    exit;

  total := frmMsgView.ListMsg.SelectedCount;
  Status(WideFormat(_('Processing %d %s...'),[total,ngettext('message','messages',total)]),False);
  //sl := TStringList(Explorer.Selected.Data);
  node := frmMsgView.ListMsg.GetFirst;
  while Assigned(node) do begin
    if frmMsgView.ListMsg.Selected[node] then begin
      { Skip Long SMS entries except for the first one }
      frmMsgView.GetLongMsgData(Node, Ref, Tot, N);
      if (Tot > 1) and (N <> 1) then begin
        node := frmMsgView.ListMsg.GetNext(node);
        Continue;
      end;
      item := frmMsgView.ListMsg.GetNodeData(node);
      wl := TTntStringList.Create;
      try
        { Break long SMS into several parts in order to keep original PDU-s.
          If it's regular SMS, then emulate a Long one with one member (PDU) }
        if Tot = -1 then
          wl.AddObject(item.msg,Pointer(node))
        else
          frmMsgView.GetNodeLongList(node,wl);
        for j := 0 to wl.Count-1 do begin
          curr := PVirtualNode(wl.Objects[j]);
          if Assigned(curr) then begin
            item := frmMsgView.ListMsg.GetNodeData(curr);
            SaveMsgToFolder(FolderNode,item.pdu,True,item.newmsg,False,-1,item.date,FArchiveDublicates); // -1 = no index in PC folders
          end;
        end;
      finally
        wl.Free;
      end;
    end;
    node := frmMsgView.ListMsg.GetNext(node);
  end;
  data := ExplorerNew.GetNodeData(FolderNode);
  UpdateNewMessagesCounter(FolderNode);

  { Update database }
  SavePhoneDataFiles(True);
  Status(WideFormat(_('%0:d %1:s stored in %2:s'),[total,ngettext('message','messages',total),data.Text]),False);
end;

function TForm1.SMSNewFolder(ParentNode: PVirtualNode; AName: WideString): PVirtualNode;
var
  EData: PFmaExplorerNode;
begin
  Result := ExplorerNew.AddChild(ParentNode);
  EData := ExplorerNew.GetNodeData(Result);
  EData.Text := AName;
  EData.ImageIndex := 3;
  EData.StateIndex := FmaSMSSubFolderFlag; // mark as SMS folder
  EData.Data := Pointer(TStringList.Create);
  EData.SpecialImagesFlags := $80; // show 'new message' counter in explorer 
end;

procedure TForm1.LoadUserFoldersData(DBPath: string; ShowUnreadFolders: Boolean);
var
  sl,dl,nl: TStringList;
  Node: PVirtualNode;
  EData: PFmaExplorerNode;
  NodePath: WideString;
  i,j: Integer;
begin
  with TIniFile.Create(DBPath + 'UserFolders.dat') do
  try
    sl := TStringList.Create;
    dl := TStringList.Create;
    try
      ReadSections(sl);
      for i := 0 to sl.Count-1 do begin
        { load database }
        dl.Clear;
        ReadSectionValues(sl[i],dl);
        NodePath := UTF8StringToWideString(dl.Values['Path']); // do not localize
        { remove "My Phone\" prefix }
        GetFirstToken(NodePath,'\'); // do not localize
        { create target folder }
        Node := ExplorerFindNode(NodePath,True);
        { update explorer view }
        EData := ExplorerNew.GetNodeData(Node);
        nl := TStringList(EData.Data);
        nl.Clear;
        for j := 1 to dl.Count-1 do // ignore Value[0] since it is the 'Path' one
          nl.Add(dl.Values[dl.Names[j]]);
        if UpdateNewMessagesCounter(Node) <> 0 then
          if ShowUnreadFolders then
            ExplorerNew.Expanded[Node.Parent] := true;
      end;
    finally
      dl.Free;
      sl.Free;
    end;
  finally
    Free;
  end;
end;

procedure TForm1.SaveUserFoldersData(DBPath: string);
var
  db: TIniFile;
  sl: TStringList;
  i,cnt: Integer;
  procedure SearchUserFolders(Root: PVirtualNode);
  var
    j: Integer;
    s: String;
    NodePath: WideString;
    itNode: PVirtualNode;
    EData: PFmaExplorerNode;
  begin
    if (Root = nil) or (Root = FNodeContactsME) or (Root = FNodeContactsSM) then
      exit;
    itNode := Root.FirstChild;
    while itNode <> nil do begin
      EData := ExplorerNew.GetNodeData(itNode);
      if EData.StateIndex = FmaSMSSubFolderFlag then
      try
        inc(cnt);
        s := 'Folder '+IntToStr(cnt); // section name // do not localize
        { add folder Path in Explorer view as first value }
        NodePath := ExplorerNodePath(itNode); // do not localize
        db.WriteString(s,'Path',WideStringToUTF8String(NodePath)); // do not localize
        { add folder data next }
        sl := TStringList(EData.Data);
        for j := 0 to sl.Count-1 do
          db.WriteString(s,'Line '+IntToStr(j),sl[j]); // do not localize
      except
      end;
      itNode := itNode.NextSibling;
    end;

    itNode := Root.FirstChild;
    while itNode <> nil do begin
      SearchUserFolders(itNode);
      itNode := itNode.NextSibling;
    end;
  end;
begin
  db := TIniFile.Create(DBPath + 'UserFolders.dat');
  try
    { clear old data }
    sl := TStringList.Create;
    try
      db.ReadSections(sl);
      for i := 0 to sl.Count-1 do
        db.EraseSection(sl[i]);
    finally
      sl.Free;
    end;
    { save all user folders to database }
    cnt := 0;
    SearchUserFolders(ExplorerNew.GetFirst);
  finally
    db.Free;
  end;
end;

function TForm1.ExplorerNodePath(Node: PVirtualNode; SepChar: WideChar; SkipRoot: Boolean): WideString;
begin
  Result := '';
  if Assigned(Node) then begin
    Result := GetSMSNodeName(Node);
    Node := Node.Parent;
    while Assigned(Node) and (Node <> ExplorerNew.RootNode) do begin
      Result := GetSMSNodeName(Node) + SepChar + Result;
      Node := Node.Parent;
    end;
    if SkipRoot then // remove first entry
      GetFirstToken(Result,SepChar);
  end;
end;

procedure TForm1.ActionViewDelFolderUpdate(Sender: TObject);
var
  EData: PFmaExplorerNode;
begin
  EData := ExplorerNew.GetNodeData(ExplorerNew.FocusedNode);
  ActionViewDelFolder.Visible := Assigned(EData) and (EData.StateIndex = FmaSMSSubFolderFlag);
  ActionViewDelFolder.Enabled := ActionViewDelFolder.Visible;
end;

procedure TForm1.ActionViewDelFolderExecute(Sender: TObject);
var
  Node: PVirtualNode;
begin
  MessageBeep(MB_ICONASTERISK);
  if MessageDlgW(WideFormat(_('Are you sure you want to delete folder "%s" and ALL its contents (No Undo)?'),
    [GetSMSNodeName(ExplorerNew.FocusedNode)]), mtConfirmation, MB_YESNO or MB_DEFBUTTON2) = ID_YES then begin
    Node := ExplorerNew.FocusedNode.Parent;
    ExplorerNew.DeleteNode(ExplorerNew.FocusedNode);
    SetExplorerNode(Node);
  end;
end;

procedure TForm1.ActionSMSToFolderUpdate(Sender: TObject);
begin
  ActionSMSToFolder.Enabled := Assigned(frmMsgView) and frmMsgView.Visible and (frmMsgView.ListMsg.SelectedCount <> 0) and
    ((ExplorerNew.FocusedNode <> FNodeMsgOutbox) and (ExplorerNew.FocusedNode <> FNodeMsgDrafts));
end;

procedure TForm1.ActionSMSToFolderExecute(Sender: TObject);
var
  EData: PFmaExplorerNode;
begin
  with TfrmBrowseFolders.Create(nil) do
  try
    OnSelectionChange := OnFolderSelected;
    AllowCurrent := False; // do not overwrite messages
    AllowNewFolder := True;
    RootNode := FNodeMsgRoot;
    Caption := _('Move Messages To...');
    if ShowModal = mrOK then begin
      Update;
      EData := tvFolders.GetNodeData(FindNodeWithPath(SelectedNodePath));
      SMSToFolder(EData.Data);
      frmMsgView.DeleteSelected(False);
      ExplorerNewChange(ExplorerNew,ExplorerNew.FocusedNode);
    end;
  finally
    Free;
  end;
end;

procedure TForm1.OnFolderSelected(Sender: TObject; Node: PVirtualNode;
  var EnableOKButton, EnableNewFolder: boolean);
var
  EData: PFmaExplorerNode;
begin
  EData := ExplorerNew.GetNodeData(Node);
  EnableOKButton := Assigned(Node) and ((Node = FNodeMsgArchive) or (EData.StateIndex = FmaSMSSubFolderFlag));
  EnableNewFolder := (Node <> FNodeMsgOutbox) and (Node <> FNodeMsgDrafts);
end;

function TForm1.ExplorerFindNode(NodePath: WideString; AllowCreate: Boolean): PVirtualNode;
var
  ParentNode,Node: PVirtualNode;
  w: WideString;
begin
  Result := nil;
  { Warning! NodePath should not contain "My Phone\" prefix! }
  ParentNode := ExplorerNew.GetFirst;
  repeat
    w := GetFirstToken(NodePath,'\'); // do not localize
    Node := FindExplorerChildNode(w,ParentNode);
    if not Assigned(Node) then
      if AllowCreate then
        Node := SMSNewFolder(ParentNode,w)
      else
        exit;
    ParentNode := Node;
  until NodePath = '';
  Result := Node;
end;

function TForm1.GetSMSDeliveryNode(Sender: WideString; CustomRules: WideString;
  AllowDefaultArchive: Boolean): PVirtualNode;
var
  i: Integer;
  w,c,num1,num2: WideString;
  Node: PVirtualNode;
  rl: TTntStringList;
begin
  if AllowDefaultArchive then Result := FNodeMsgArchive // move to Archive by default
    else Result := nil;
  num1 := ExtractNumber(Sender);
  rl := TTntStringList.Create;
  try
    if CustomRules = '' then rl.Text := FDeliveryRules.Text
      else rl.Text := CustomRules;
    for i := 0 to rl.Count-1 do begin
      w := rl[i];
      c := GetToken(w,1); // get Rule correspondents
      repeat
        num2 := ExtractNumber(GetFirstToken(c,';'));
        if WideCompareStr(num1,num2) = 0 then begin
          { matching number found }
          Node := ExplorerFindNode(GetToken(w,2)); // get node by Rule node path
          if Assigned(Node) then begin
            Result := Node;
            break;
          end;
        end;
      until c = '';
    end;
  finally
    rl.Free;
  end;
end;

function TForm1.GetSMSNodeName(Node: PVirtualNode): WideString;
var
  EData: PFmaExplorerNode;
begin
  EData := ExplorerNew.GetNodeData(Node);
  Result := GetSMSNodeName(EData.Text);
end;

procedure TForm1.ActionSyncAllExecute(Sender: TObject);
begin
  frmInfoView.linkSyncAllClick(nil);
end;

procedure TForm1.ActionSyncMessagesExecute(Sender: TObject);
begin
  DownloadAllMessages;
end;

procedure TForm1.ActionRulesExportUpdate(Sender: TObject);
begin
  ActionRulesExport.Enabled := FDeliveryRules.Count <> 0;
end;

procedure TForm1.ActionRulesExportExecute(Sender: TObject);
var
  Extension: WideString;
  i: Integer;
begin
  RulesSaveDialog.Filter := _('Delivery Rules files (*.rules)|*.rules');
  if RulesSaveDialog.Execute then begin
    case RulesSaveDialog.FilterIndex of
      1: Extension := '.rules';  // do not localize
    end;
    if WideExtractFileExt(RulesSaveDialog.FileName) <> Extension then
      RulesSaveDialog.FileName := RulesSaveDialog.FileName + Extension;
    DeleteFile(RulesSaveDialog.FileName);
    with TIniFile.Create(RulesSaveDialog.FileName) do
    try
      WriteInteger('FMA','Count',FDeliveryRules.Count); // do not localize
      for i := 0 to FDeliveryRules.Count-1 do begin
        WriteString('Rules',IntToStr(i+1),'"'+FDeliveryRules[i]+'"'); // do not localize
      end;
    finally
      Free;
    end;
  end;
end;

procedure TForm1.ImportRules1Click(Sender: TObject);
var
  i,c,Cnt: Integer;
  w: WideString;
begin
  if RulesOpenDialog.Execute then begin
    with TIniFile.Create(RulesOpenDialog.FileName) do
    try
      Status(_('Importing rules...'));

      Cnt := ReadInteger('FMA','Count',0); // do not localize
      c := 0;
      for i := 0 to Cnt-1 do begin
        w := ReadString('Rules',IntToStr(i+1),''); // do not localize
        if (GetTokenCount(w) = 3) and (FDeliveryRules.IndexOf(w) = -1) then begin // sanity check, rule should have 3 params
          FDeliveryRules.Add(w);
          inc(c);
        end;
      end;
    finally
      Free;
      SavePhoneDataFiles(True);
    end;
    Status(_('Import complete.'));
    MessageDlgW(WideFormat(_('%d %s imported successfully.'),[c,ngettext('delivery rule','delivery rules',c)]),
      mtInformation, MB_OK);
  end;
end;

procedure TForm1.DeliveryRules1Click(Sender: TObject);
begin
  with TfrmOptionsPage.Create(nil) do
  try
    with Options, FTextMessageOptions do begin
      chkMsgM.Checked := FMsgM;
      chkMsgMClick(nil);
      cbMsgToArchive.Checked := MoveToArchive;
    end;
    Options.DeliveryRules := FDeliveryRules.Text;
    if ShowPageModal(Options.tabSMSDelivery) = mrOK then begin
      { Apply changes }
      FDeliveryRules.Text := Options.DeliveryRules;
      with Options, FTextMessageOptions do begin
        FMsgM := chkMsgM.Checked;
        FormStorage1.StoredValue['Message Monitor'] := FMsgM; // do not localize
        MoveToArchive := cbMsgToArchive.Checked;
        FormStorage1.StoredValue['MsgAutoArchive'] := MoveToArchive; // do not localize
      end;

      { Save changes }
      SavePhoneDataFiles(True);
    end;
  finally
    Free;
  end;
end;

procedure TForm1.Proximity1Click(Sender: TObject);
begin
  with TfrmOptionsPage.Create(nil) do
  try
    frmOptions := Options; // needed for Test Proximity feature
    with Options, FProximityOptions do begin
      cbProximityLock.Checked := AwayLock;
      rgProximityAway.ItemIndex := AwayMusicMode;
      cbProximityUnlock.Checked := NearUnlock;
      rgProximityNear.ItemIndex := NearMusicMode;
      cbRunSS.Checked := RunSS;
    end;
    if ShowPageModal(Options.tabProximity) = mrOK then begin
      { Apply changes }
      with Options, FProximityOptions do begin
        AwayLock := cbProximityLock.Checked;
        AwayMusicMode := rgProximityAway.ItemIndex;
        NearUnlock := cbProximityUnlock.Checked;
        NearMusicMode := rgProximityNear.ItemIndex;
        RunSS := cbRunSS.Checked;
        FormStorage1.StoredValue['AwayLock'] := AwayLock; // do not localize
        FormStorage1.StoredValue['AwayMusicMode'] := AwayMusicMode; // do not localize
        FormStorage1.StoredValue['NearUnlock'] := NearUnlock; // do not localize
        FormStorage1.StoredValue['NearMusicMode'] := NearMusicMode; // do not localize
        FormStorage1.StoredValue['RunSS'] := RunSS; // do not localize
      end;
      { No need to call SaveData() since all settings are stored in FormStorage1 }
    end;
  finally
    frmOptions := nil;
    Free;
  end;
end;

procedure TForm1.ScriptingOptions1Click(Sender: TObject);
var
  ScriptCheck: Boolean;
begin
  with TfrmOptionsPage.Create(nil) do
  try
    with Options do begin
      CheckScriptEditorExt;
      edScriptEditor.Text := FScriptEditor;
      if FUseScriptEditorExt then
        rbScriptEditorExternal.Checked := True;
      rdScriptEditorClick(nil);

      edScriptPath.Text := FScriptFile;
      edScriptPathChange(edScriptPath);
      if FUseScript then cbUseScripts.Checked := True
        else cbDoNotUseScripts.Checked := True;
      cbUseScriptsClick(nil);
    end;
    if ShowPageModal(Options.tabScripting) = mrOK then begin
      { Apply changes }
      with Options do begin
        FScriptEditor := edScriptEditor.Text;
        CheckScriptEditorExt;
        FUseScriptEditorExt := rbScriptEditorExternal.Checked;
        FormStorage1.StoredValue['ScriptEditor'] := FScriptEditor; // do not localize
        FormStorage1.StoredValue['UseScriptEditorExt'] := FUseScriptEditorExt; // do not localize

        ScriptCheck := FUseScript;
        FUseScript := cbUseScripts.Checked or cbUseScriptingFramework.Checked;
        FormStorage1.StoredValue['UseScript'] := FUseScript; // do not localize
        if FUseScript and (not ScriptCheck or (WideCompareText(FScriptFile,edScriptPath.Text) <> 0)) then begin
          ScriptingEnable(edScriptPath.Text);
        end;
        if not FUseScript and ScriptCheck then
          ScriptingDisable;
      end;
      { No need to call SaveData() since all settings are stored in FormStorage1 }
    end;
  finally
    Free;
  end;
end;

procedure TForm1.LanguageOptions1Click(Sender: TObject);
begin
  with TfrmOptionsPage.Create(nil) do
  try
    Options.UILangChanged := False;
    if ShowPageModal(Options.tabLanguage) = mrOK then begin
      { Apply changes }
      if Options.UILangChanged then
        FormStorage1.StoredValue['LANG'] := Options.NewUILang; // do not localize
      { No need to call SaveData() since all settings are stored in FormStorage1 }
    end;
  finally
    Free;
  end;
end;

procedure TForm1.EditSMSDeliveryRules(Node: PVirtualNode);
var
  rl,sl,dl: TTntStringList;
  i: Integer;
begin
  with TfrmOptionsPage.Create(nil) do
  try
    rl := TTntStringList.Create; // delivery rules list
    sl := TTntStringList.Create; // folder rules before edit
    dl := TTntStringList.Create; // folder rules after edit
    try
      Options.DeliveryRules := Form1.FDeliveryRules.Text;
      Options.DeliveryFolder := Node;
      with Options, FTextMessageOptions do begin
        chkMsgM.Checked := FMsgM;
        chkMsgMClick(nil);
        cbMsgToArchive.Checked := MoveToArchive;
      end;
      rl.Text := FDeliveryRules.Text; // get list
      sl.Text := Options.DeliveryRules;
      if ShowPageModal(Options.tabSMSDelivery, WideFormat('%s - [%s]',
        [Options.tabSMSDelivery.Caption,GetSMSNodeName(Node)])) = mrOK then begin
        dl.Text := Options.DeliveryRules;
        { add new items }
        for i := 0 to dl.Count-1 do
          if sl.IndexOf(dl[i]) = -1 then rl.Add(dl[i]);
        { remove deleted items }
        for i := 0 to sl.Count-1 do
          if dl.IndexOf(sl[i]) = -1 then rl.Delete(rl.IndexOf(sl[i]));
        { save new list }
        FDeliveryRules.Text := rl.Text; // set list
        with Options, FTextMessageOptions do begin
          FMsgM := chkMsgM.Checked;
          FormStorage1.StoredValue['Message Monitor'] := FMsgM; // do not localize
          MoveToArchive := cbMsgToArchive.Checked;
          FormStorage1.StoredValue['MsgAutoArchive'] := MoveToArchive; // do not localize
        end;

        { Save changes }
        SavePhoneDataFiles(True);
      end;
    finally
      dl.Free;
      sl.Free;
      rl.Free;
    end;
  finally
    Free;
  end;
end;

procedure TForm1.ActionSMSDeliveryUpdate(Sender: TObject);
var
  Data: PFmaExplorerNode;
begin
  Data := ExplorerNew.GetNodeData(ExplorerNew.FocusedNode);
  ActionSMSDelivery.Visible := Assigned(Data) and (Data.StateIndex = FmaSMSSubFolderFlag);
  ActionSMSDelivery.Enabled := ActionSMSDelivery.Visible;
end;

procedure TForm1.ActionSMSDeliveryExecute(Sender: TObject);
begin
  EditSMSDeliveryRules(ExplorerNew.FocusedNode);
end;

procedure TForm1.DoProcessRules(Node: PVirtualNode; Rules: WideString);
var
  dlg: TfrmConnect;
  sl: TStringList;
  fl: TTntStringList;
  i,MoveCount,msgType,msgIndex: Integer;
  memType: string;
  w,pdu,who,sender: WideString;
  DeliveryNode: PVirtualNode;
  EData: PFmaExplorerNode;
  sms: TSMS;
  smsDate: TDateTime;
  smsNew: Boolean;
begin
  Status('Applying Rules...');
  MoveCount := 0;
  EData := ExplorerNew.GetNodeData(Node);
  sl := TStringList(EData.Data); // list Folder contents
  fl := TTntStringList.Create;  // modified folders list
  sms := TSMS.Create;
  try
    dlg := GetProgressDialog;
    try
      if CanShowProgress then begin
        dlg.Initialize(sl.Count,_('Applying delivery rules...'));
        dlg.ShowProgress(FProgressLongOnly);
      end;
      { Process folder messages }
      i := 0;
      while i < sl.Count do begin
        pdu := GetToken(sl[i],5);
        sms.PDU := pdu;
        { Find corresponding Rule, if any }
        DeliveryNode := nil;
        if sms.Number <> '' then begin
          who := LookupContact(sms.Number);
          if who = '' then who := sUnknownContact;
          sender := who + ' [' + sms.Number + ']';
          DeliveryNode := GetSMSDeliveryNode(sender,Rules,False);
        end;
        { Apply rule if needed }
        if Assigned(DeliveryNode) and (DeliveryNode <> Node) then begin
          msgType := StrToInt(GetToken(sl[i],0));
          msgIndex := StrToInt(GetToken(sl[i],1));
          smsDate := sms.TimeStamp;
          w := GetToken(sl[i],6);
          if w <> '' then smsDate := StrToDateTime(w);
          smsNew := StrToInt(GetToken(sl[i],7)) <> 0;
          case msgType of
            1: memType := 'ME';
            2: memType := 'SM';
            else memType := ''; // In PC
          end;
          if memType <> '' then begin
            AskRequestConnection;
            try
              DeleteSMS(msgIndex,memType);
            except
              { silently ignore delete failure - it means message is not in phone anyway }
            end;
          end;
          SaveMsgToFolder(DeliveryNode,pdu,True,smsNew,False,-1,smsDate,True); // -1 = no index in PC folders
          EData := ExplorerNew.GetNodeData(DeliveryNode);
          if fl.IndexOf(EData.Text) = -1 then
            fl.AddObject(EData.Text, Pointer(DeliveryNode));
          sl.Delete(i);
          inc(MoveCount);
        end
        else
          inc(i);
        dlg.IncProgress(1);
        if i mod 16 = 0 then Application.ProcessMessages;
      end;
    finally
      { Refresh folders if needed }
      for i := 0 to fl.Count-1 do begin
        DeliveryNode := PVirtualNode(fl.Objects[i]);
        UpdateNewMessagesCounter(DeliveryNode);
        if (ExplorerNew.FocusedNode = DeliveryNode) and frmMsgView.Visible then begin
          EData := ExplorerNew.GetNodeData(DeliveryNode);
          frmMsgView.RenderListView(TStringList(EData.Data));
        end;
      end;
      if MoveCount <> 0 then begin
        UpdateNewMessagesCounter(Node);
        if (ExplorerNew.FocusedNode = Node) and frmMsgView.Visible then begin
          frmMsgView.RenderListView(sl);
        end;
      end;
      { Save changes to Database }
      dlg.SetDescr(_('Saving...'));
      SavePhoneDataFiles(True);
      FreeProgressDialog;
    end;
    Status(WideFormat(_('Delivery completed (%d %s)'),[MoveCount,ngettext('message moved','messages moved',MoveCount)]));
  finally
    sms.Free;
    fl.Free;
  end;
end;

function TForm1.GetSMSNodeName(const Name: WideString): WideString;
var
  s: WideString;
  i: integer;
begin
  s := Name;
  // Obsolete...
  i := Pos(' (',s);
  if i <> 0 then Delete(s,i,Length(s));
  // ...Obsolete
  Result := s;
end;

procedure TForm1.MissedCallsTrayIconDblClick(Sender: TObject);
begin
  ActionMissedCalls.Execute;
  Application.BringToFront;
end;

procedure TForm1.NewMessageTrayIconDblClick(Sender: TObject);
begin
  if FormStorage1.StoredValue['StartMinimized'] = True then // do not localize
    ActionWindowRestore.Execute
  else
    Application.BringToFront;
  with frmInfoView do linkJumpMsgFolderClick(linkShowNewMessages);
end;

procedure TForm1.DeletePhoneDataFiles(ID: string; Wnd: THandle);
var
  Fullpath: string;
  fo: TSHFileOpStructW;
begin
  (* WARNING!!! Use this procedure with cation! ALL PROFILE DATA WILL BE LOST! *)

  Fullpath := GetProfilePath(ID); // do not localize
  if (AnsiCompareStr(Fullpath,ExePath) <> 0) and FileExists(Fullpath + 'dat\Phone.dat') then
    try
      Fullpath := WideExcludeTrailingBackslash(Fullpath);
      Status(_('Deleting phone profile database...'));
      Log.AddMessage('Database: Delete database from user''s Application Data folder', lsDebug); // do not localize debug
      repeat
        WaitASec;
        if Wnd = 0 then Wnd := Handle;
        fo.Wnd := Wnd;
        { Copies the files specified by pFrom to the location specified by pTo.
          Use Copy instead of Move operation, so we could rollback changes (see bellow) }
        fo.wFunc := FO_DELETE;
        { Pointer to a buffer that specifies one or more source file names. Multiple names must be null-separated.
          The list of names must be double null-terminated. }
        fo.pFrom := PWideChar(LongStringToWideString(Fullpath+#0#0)); // do not localize
        { Pointer to a buffer that contains the name of the destination file or directory. The buffer can contain
          mutiple destination file names if the fFlags member specifies FOF_MULTIDESTFILES. Multiple names must be
          null-separated. The list of names must be double null-terminated. }
        fo.pTo := PWideChar(LongStringToWideString(#0#0));
        fo.fFlags := FOF_NOCONFIRMATION or FOF_NOCONFIRMMKDIR or FOF_SIMPLEPROGRESS or FOF_ALLOWUNDO or FOF_NOERRORUI;
        fo.lpszProgressTitle := PWideChar(_('Deleting FMA Database...'));
        if (SHFileOperationW(fo) = 0) and not fo.fAnyOperationsAborted then
          break; // success
        Application.BringToFront;
        if MessageDlgW(_('Some database files are in use. Please close any applicatiions that might cause this and click OK to continue.'),
          mtInformation, MB_OKCANCEL) = ID_CANCEL then begin
          fo.fAnyOperationsAborted := True; { just in case }
          break;
        end;
      until False;
      Application.BringToFront;
      Status('');
      if not fo.fAnyOperationsAborted and (AnsiCompareStr(ID,PhoneIdentity) = 0) then
        ClearExplorerViews;
      {
      DeleteFile(Fullpath + '\Phone.dat'); // do not localize
      DeleteFile(Fullpath + '\SMSInbox.dat'); // do not localize
      DeleteFile(Fullpath + '\SMSIncoming.dat'); // do not localize
      DeleteFile(Fullpath + '\SMSIncoming.Index.dat'); // do not localize
      DeleteFile(Fullpath + '\SMSOutbox.dat'); // do not localize
      DeleteFile(Fullpath + '\SMSSent.dat'); // do not localize
      DeleteFile(Fullpath + '\SMSArchive.dat'); // do not localize
      DeleteFile(Fullpath + '\SMSDrafts.dat'); // do not localize
      DeleteFile(Fullpath + '\Contacts.ME.dat'); // do not localize
      DeleteFile(Fullpath + '\Contacts.SM.dat'); // do not localize
      DeleteFile(Fullpath + '\Contacts.SYNC.dat'); // do not localize
      DeleteFile(Fullpath + '\Contacts.SYNCMAX.dat'); // do not localize
      DeleteFile(Fullpath + '\Calendar.vcs'); // do not localize
      DeleteFile(Fullpath + '\Calendar.SYNC.dat'); // do not localize
      DeleteFile(Fullpath + '\Bookmarks.dat'); // do not localize
      DeleteFile(Fullpath + '\Bookmarks.SYNC.dat'); // do not localize
      DeleteFile(Fullpath + '\CallNotes.dat'); // do not localize
      DeleteFile(Fullpath + '\ContactSync.xml'); // do not localize
      DeleteFile(Fullpath + '\UserFolders.dat'); // do not localize
      }
    except
    end;
end;

function TForm1.ApplicationEvents1Help(Command: Word; Data: Integer;
  var CallHelp: Boolean): Boolean;
const
  Pos: TPoint = (X:0; Y:0);
begin
  CallHelp := False;
  Result := True;
  case Command of
    HELP_SETPOPUP_POS:
      Pos := SmallPointToPoint(TSmallPoint(Data));
    HELP_CONTEXTPOPUP:
      ShowHelpPopup(Pos, Data);
    else
      Result := False;
  end;
end;

function TForm1.GetHelpFilename(AppendPath: WideString): WideString;
begin
  Result := HtmlHelpFile;
  if AppendPath <> '' then
    Result := Result + '::/' + AppendPath;
end;

procedure TForm1.Index1Click(Sender: TObject);
begin
  HtmlHelp(0, nil, HH_CLOSE_ALL, 0);
  HtmlHelp(0, PWideChar(GetHelpFilename('html/welcome.htm')), HH_DISPLAY_TOC, 0);
end;

procedure TForm1.Search1Click(Sender: TObject);
var
  Qry: THHFtsQuery;
begin
  FillChar(Qry, SizeOf(Qry), 0);
  Qry.cbStruct := SizeOf(Qry);
  Qry.fUniCodeStrings := False;
  Qry.pszSearchQuery := nil;
  Qry.iProximity := HH_FTS_DEFAULT_PROXIMITY;
  Qry.fStemmedSearch := False;
  Qry.fTitleOnly := False;
  Qry.fExecute := False;
  Qry.pszWindow := nil;
  HtmlHelp(0, PWideChar(GetHelpFilename), HH_DISPLAY_SEARCH, DWORD(@Qry));
end;

procedure TForm1.InitExplorerTree;
var root: PVirtualNode;
  data: PFmaExplorerNode;
begin
  ExplorerNew.Clear;
  root := ExplorerNew.AddChild(nil);
  data := ExplorerNew.GetNodeData(root);
  data.Text := _('My Phone');
  data.ImageIndex := 51;
  data.StateIndex := -1;
  //data.SpecialImages := $2D2C2D2C;
  //data.SpecialImagesFlags := $77;

    FNodeMsgRoot := ExplorerNew.AddChild(root);
    data := ExplorerNew.GetNodeData(FNodeMsgRoot);
    data.Text := _('Text Messages');
    data.ImageIndex := 5;
    data.StateIndex := $200000;
    data.SpecialImages := $3F400041;
    data.SpecialImagesFlags := $07;

      FNodeMsgInbox := ExplorerNew.AddChild(FNodeMsgRoot);
      data := ExplorerNew.GetNodeData(FNodeMsgInbox);
      data.Text := _('Inbox');
      data.ImageIndex := 39;
      data.StateIndex := $210000;
      //data.SpecialImages := $3F400041;
      //data.SpecialImagesFlags := $07;
      data.SpecialImagesFlags := $80;
      data.Data := TStringList.Create;

      FNodeMsgSent := ExplorerNew.AddChild(FNodeMsgRoot);
      data := ExplorerNew.GetNodeData(FNodeMsgSent);
      data.Text := _('Sent Items');
      data.ImageIndex := 40;
      data.StateIndex := $220000;
      //data.SpecialImages := $3F400041;
      //data.SpecialImagesFlags := $07;
      data.SpecialImagesFlags := $80;
      data.Data := TStringList.Create;

      FNodeMsgOutbox := ExplorerNew.AddChild(FNodeMsgRoot);
      data := ExplorerNew.GetNodeData(FNodeMsgOutbox);
      data.Text := _('Outbox');
      data.ImageIndex := 56;
      data.StateIndex := $2A0000;
      data.SpecialImagesFlags := $80;
      data.Data := TStringList.Create;

      FNodeMsgArchive := ExplorerNew.AddChild(FNodeMsgRoot);
      data := ExplorerNew.GetNodeData(FNodeMsgArchive);
      data.Text := _('Archive');
      data.ImageIndex := 3;
      data.StateIndex := $2B0000;
      data.SpecialImagesFlags := $80;
      data.Data := TStringList.Create;

      FNodeMsgDrafts := ExplorerNew.AddChild(FNodeMsgRoot);
      data := ExplorerNew.GetNodeData(FNodeMsgDrafts);
      data.Text := _('Drafts');
      data.ImageIndex := 57;
      data.StateIndex := $2C0000;
      //data.SpecialImages := $3D00003D;
      //data.SpecialImagesFlags := $65;
      data.SpecialImagesFlags := $80;
      data.Data := TStringList.Create;

    FNodeContactsRoot := ExplorerNew.AddChild(root);
    data := ExplorerNew.GetNodeData(FNodeContactsRoot);
    data.Text := _('Contacts');
    data.ImageIndex := 6;
    data.StateIndex := $000000;

      FNodeContactsME := ExplorerNew.AddChild(FNodeContactsRoot);
      data := ExplorerNew.GetNodeData(FNodeContactsME);
      data.Text := _('Phone Memory');
      data.ImageIndex := 49;
      data.StateIndex := $100000;
      data.SpecialImages := $3F400041;
      data.SpecialImagesFlags := $07;
      data.Data := TStringList.Create;

      FNodeContactsSM := ExplorerNew.AddChild(FNodeContactsRoot);
      data := ExplorerNew.GetNodeData(FNodeContactsSM);
      data.Text := _('SIM Memory');
      data.ImageIndex := 50;
      data.StateIndex := $140000;
      data.SpecialImages := $3F400041;
      data.SpecialImagesFlags := $07;
      data.Data := TStringList.Create;

    FNodeCalls := ExplorerNew.AddChild(root);
    data := ExplorerNew.GetNodeData(FNodeCalls);
    data.Text := _('Calls');
    data.ImageIndex := 30;
    data.StateIndex := $400000;
    data.SpecialImages := $3F400041;
    data.SpecialImagesFlags := $07;

      FNodeCallsIn := ExplorerNew.AddChild(FNodeCalls);
      data := ExplorerNew.GetNodeData(FNodeCallsIn);
      data.Text := _('Incoming');
      data.ImageIndex := 46;
      data.StateIndex := $410000;
      //data.SpecialImages := $3F400041;
      //data.SpecialImagesFlags := $07;
      data.Data := TStringList.Create;

      FNodeCallsOut := ExplorerNew.AddChild(FNodeCalls);
      data := ExplorerNew.GetNodeData(FNodeCallsOut);
      data.Text := _('Outgoing');
      data.ImageIndex := 47;
      data.StateIndex := $420000;
      //data.SpecialImages := $3F400041;
      //data.SpecialImagesFlags := $07;
      data.Data := TStringList.Create;

      FNodeCallsMissed := ExplorerNew.AddChild(FNodeCalls);
      data := ExplorerNew.GetNodeData(FNodeCallsMissed);
      data.Text := _('Missed');
      data.ImageIndex := 48;
      data.StateIndex := $430000;
      //data.SpecialImages := $3F400041;
      //data.SpecialImagesFlags := $07;
      data.Data := TStringList.Create;

    FNodeObex := ExplorerNew.AddChild(root);
    data := ExplorerNew.GetNodeData(FNodeObex);
    data.Text := _('Files');
    data.ImageIndex := 3;
    data.StateIndex := $500000;
    data.SpecialImages := $3F400041;
    data.SpecialImagesFlags := $07;

    FNodeProfiles := ExplorerNew.AddChild(root);
    data := ExplorerNew.GetNodeData(FNodeProfiles);
    data.Text := _('Profiles');
    data.ImageIndex := 23;
    data.StateIndex := $700000;
    data.SpecialImages := $3F400041;
    data.SpecialImagesFlags := $07;

    FNodeGroups := ExplorerNew.AddChild(root);
    data := ExplorerNew.GetNodeData(FNodeGroups);
    data.Text := _('Groups');
    data.ImageIndex := 25;
    data.StateIndex := $800000;
    data.SpecialImages := $3F400041;
    data.SpecialImagesFlags := $07;

    FNodeOrganizer := ExplorerNew.AddChild(root);
    data := ExplorerNew.GetNodeData(FNodeOrganizer);
    data.Text := _('Organizer');
    data.ImageIndex := 28;
    data.StateIndex := $900000;
      FNodeAlarms := ExplorerNew.AddChild(FNodeOrganizer);
      data := ExplorerNew.GetNodeData(FNodeAlarms);
      data.Text := _('Alarms');
      data.ImageIndex := 42;
      data.StateIndex := $310000;
      data.SpecialImages := $3F400041;
      data.SpecialImagesFlags := $07;
      data.Data := TStringList.Create;

      FNodeBookmarks := ExplorerNew.AddChild(FNodeOrganizer);
      data := ExplorerNew.GetNodeData(FNodeBookmarks);
      data.Text := _('Bookmarks');
      data.ImageIndex := 20;
      data.StateIndex := $320000;
      data.SpecialImages := $3F400041;
      data.SpecialImagesFlags := $07;
      data.Data := TStringList.Create;

      FNodeCalendar := ExplorerNew.AddChild(FNodeOrganizer);
      data := ExplorerNew.GetNodeData(FNodeCalendar);
      data.Text := _('Calendar');
      data.ImageIndex := 43;
      data.StateIndex := $340000;
      data.SpecialImages := $3F400041;
      data.SpecialImagesFlags := $07;

    FNodeScripts := ExplorerNew.AddChild(root);
    data := ExplorerNew.GetNodeData(FNodeScripts);
    data.Text := _('Script');
    data.ImageIndex := 61;
    data.StateIndex := $A00000;
end;

procedure TForm1.ExplorerNewGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TFmaExplorerNode);
end;

procedure TForm1.ExplorerNewGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  data: PFmaExplorerNode;
begin
  if Assigned(Node) then begin
    data := Sender.GetNodeData(Node);
    case Column of
      0: CellText := data.Text;
      1: begin
           data := Sender.GetNodeData(Node);
           if (data.SpecialImagesFlags and $80 <> 0) and (data.SpecialImages <> 0) then
             CellText := IntToStr(data.SpecialImages)
           else if (data.SpecialImagesFlags and $01 <> 0) then
             CellText := ' '
           else
             CellText := '';
         end;
    end;
  end;
end;

procedure TForm1.ExplorerNewGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  data: PFmaExplorerNode;
begin
  if Assigned(Node) then begin
    data := Sender.GetNodeData(Node);
    case Column of
      0: ImageIndex := data.ImageIndex;
{      1: begin
           if not (data.SpecialImagesFlags and $FF in [$00,$80]) then begin
             if data.SpecialImagesFlags and $04 <> 0 then begin
               if FConnected and FConnectingComplete then
                 ImageIndex := (data.SpecialImages and $FF000000) shr 24
               else
                 ImageIndex := (data.SpecialImages and $000000FF);
             end
             else
               ImageIndex := (data.SpecialImages and $FF000000) shr 24;
           end;
         end;}
    end;
  end;
end;

procedure TForm1.ExplorerNewMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
const
  LastRedrawnNode: PVirtualNode = nil;
var
  hit: THitInfo;
  rect: TRect;
  i: Integer;
  data: PFmaExplorerNode;
  onImage: boolean;
begin
  ExplorerNew.GetHitTestInfoAt(X, Y, true, hit);
  // should be same as in onClick
  onImage := (X >= (ExplorerNew.ClientWidth - 20)) and (X <= (ExplorerNew.ClientWidth - 2));
  if Assigned(LastRedrawnNode) then begin
    if (not onImage) or (hit.HitColumn <> 1) or (LastRedrawnNode<>hit.HitNode)then begin
      ExplorerNew.RepaintNode(LastRedrawnNode);
      LastRedrawnNode := nil;
    end;
  end
  else if Assigned(hit.HitNode) and (hit.HitColumn = 1) and (onImage) then begin
    data := ExplorerNew.GetNodeData(hit.HitNode);
    if data.SpecialImagesFlags and $02 = 0 then
      Exit;
    if (data.SpecialImagesFlags and $1C < $C) and (not (FConnected and FConnectingComplete)) then Exit;
    rect := ExplorerNew.GetDisplayRect(hit.HitNode, 1, false);
    if (data.SpecialImagesFlags and $14 = $14) and (not (FConnected and FConnectingComplete)) then
      i := (data.SpecialImages and $0000FF00) shr 8
    else
      i := (data.SpecialImages and $00FF0000) shr 16;
    if ExplorerNew.Canvas.TryLock then
      try
        ExplorerNew.Canvas.FillRect(rect);
        ImageList1.Draw(ExplorerNew.Canvas, rect.Right - ImageList1.Width - 1, rect.Top + ((Integer(ExplorerNew.DefaultNodeHeight) - ImageList1.Height) div 2), i);
        LastRedrawnNode := hit.HitNode;
      finally
        ExplorerNew.Canvas.Unlock;
      end;
  end;
end;

procedure TForm1.ExplorerNewClick(Sender: TObject);
var
  hit: THitInfo;
  mouse: TPoint;
  data: PFmaExplorerNode;
  onImage: boolean;
begin
  GetCursorPos(mouse);
  mouse := ExplorerNew.ScreenToClient(mouse);
  ExplorerNew.GetHitTestInfoAt(mouse.X, mouse.Y, true, hit);
  // should be same as in onMouseMove
  onImage := (mouse.X >= (ExplorerNew.ClientWidth - 20)) and (mouse.X <= (ExplorerNew.ClientWidth - 2));
  if Assigned(hit.HitNode) and (hit.HitColumn = 1) and (onImage) then begin
    data := ExplorerNew.GetNodeData(hit.HitNode);
    if data.SpecialImagesFlags and $01 = 0 then
      Exit;
    if (data.SpecialImagesFlags and $24 <> $24) and (not (FConnected and FConnectingComplete)) then
      Exit;
    if FObex.Connected or ThreadSafe.ObexConnecting then
      Exit; // never perform action if Obex is connected
    if (ThreadSafe.Busy) and (data.SpecialImagesFlags and $40 <> $40) then begin
      Log.AddMessage(_('Unable to perform refresh now! Try again later...'));
      Exit;
    end;

    SetExplorerNode(hit.HitNode);

    if hit.HitNode = ExplorerNew.GetFirst then
      ActionConnectionToggle.Execute
    else if hit.HitNode = FNodeMsgInbox then
      DownloadMessages(FNodeMsgInbox)
    else if hit.HitNode = FNodeMsgSent then
      DownloadMessages(FNodeMsgSent)
    else if hit.HitNode = FNodeMsgRoot then
      DownloadAllMessages
    else if hit.HitNode = FNodeMsgDrafts then
      ActionSMSNewMsg.Execute
    else if hit.HitNode = FNodeCalls then
      InitCalls
    else if hit.HitNode = FNodeCallsIn then
      InitCalls(FNodeCallsIn)
    else if hit.HitNode = FNodeCallsOut then
      InitCalls(FNodeCallsOut)
    else if hit.HitNode = FNodeCallsMissed then
      InitCalls(FNodeCallsMissed)
    else if (hit.HitNode = FNodeContactsME) or (hit.HitNode = FNodeContactsSM) then
      ActionContactsDownloadExecute(Self)
    else if hit.HitNode = FNodeAlarms then
      InitAlarms
    else if hit.HitNode = FNodeBookmarks then
      ActionSyncBookmarksExecute(Self)
    else if hit.HitNode = FNodeCalendar then
      ActionSyncCalendarExecute(Self)
    else if hit.HitNode = FNodeObex then
      InitObexFolders
    else if hit.HitNode = FNodeProfiles then
      InitProfile
    else if hit.HitNode = FNodeGroups then
      InitGroups;
  end;
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
begin
  if Assigned(ExplorerNew.FocusedNode) then begin
    ExplorerNew.Selected[ExplorerNew.FocusedNode] := True;
    ExplorerNew.SetFocus;
  end;
end;

procedure TForm1.SetExplorerNode(Node: PVirtualNode);
var
  SelNode: PVirtualNode;
begin
  { Set ExplorerNew.Enabled to False to prevent explorer selection changes }
  if ExplorerNew.Enabled then begin
    SelNode := ExplorerNew.GetFirstSelected;
    ExplorerNew.FocusedNode := Node;
    ExplorerNew.Selected[Node] := True;
    if SelNode = Node then
      ExplorerNewChange(ExplorerNew,ExplorerNew.FocusedNode);
  end;
end;

procedure TForm1.DeviceMonitorUSB1USBArrival(Sender: TObject);
begin
  if not FConnected and Visible and (Screen.ActiveForm <> frmNewDeviceWizard) and
    not FStartupOptions.NoBaloons then
    ShowBaloonInfo(_('New USB Device has been detected. Use built-in Getting Started wizard if you want to connect to your phone.'));
end;

procedure TForm1.ActionPlayerTogglePlayUpdate(Sender: TObject);
begin
  ActionPlayerTogglePlay.Enabled := FUseMediaPlayer and FConnected and FConnectingComplete and
    not FObex.Connected and not ThreadSafe.Busy;
end;

procedure TForm1.ActionPlayerTogglePlayExecute(Sender: TObject);
begin
  try
    if ActionPlayerTogglePlay.ImageIndex = 69 then begin
      TxAndWait('AT*SEMP=1');
      ActionPlayerTogglePlay.ImageIndex := 70;
    end
    else begin
      TxAndWait('AT*SEMP=2');
      ActionPlayerTogglePlay.ImageIndex := 69;
    end;
  except
  end;
end;

procedure TForm1.ActionViewMsgSearchUpdate(Sender: TObject);
begin
  if (frmMsgView <> nil) and frmMsgView.Visible then begin
    ActionViewMsgSearch.Enabled := True;
    ActionViewMsgSearch.Checked := frmMsgView.SearchPanel.Visible;
  end
  else
    ActionViewMsgSearch.Enabled := False;
end;

procedure TForm1.ActionViewMsgSearchExecute(Sender: TObject);
begin
  if not frmMsgView.Visible then
    SetExplorerNode(FNodeMsgArchive);

  if frmMsgView.SearchPanel.Visible then
    frmMsgView.sbClearSearch.Click
  else
    frmMsgView.Search1.Click;
end;

procedure TForm1.ExplorerNewAfterCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellRect: TRect);
var
  EData: PFmaExplorerNode;
  ii: Integer;
begin
  if Column = 1 then begin
    ii := -1;
    EData := Sender.GetNodeData(Node);
    if EData <> nil then begin
      if not (EData.SpecialImagesFlags and $FF in [$00,$80]) then begin
        if EData.SpecialImagesFlags and $04 <> 0 then begin
          if FConnected and FConnectingComplete then
            ii := (EData.SpecialImages and $FF000000) shr 24
          else
            ii := (EData.SpecialImages and $000000FF);
        end
        else
          ii := (EData.SpecialImages and $FF000000) shr 24;
      end;
      if ii > -1 then
        ImageList1.Draw(TargetCanvas, CellRect.Right - ImageList1.Width - 2, CellRect.Top + ((Integer(ExplorerNew.DefaultNodeHeight) - ImageList1.Height) div 2), ii);
    end;
  end;
end;

procedure TForm1.ActionDummyExecute(Sender: TObject);
begin
 // Dummy - do nothing! Atherwise actions will be disabled!
end;

procedure TForm1.Memo3Change(Sender: TObject);
begin
  Memo3.SelStart := Length(Memo3.Text);
  Memo3.SelLength := 0;
end;

procedure TForm1.InitAlarms;
var
  i: Integer;
  w,str: WideString;
  sl,dl: TstringList;
  EData: PFmaExplorerNode;
begin
  try
    if frmInfoView.Visible then EBCAState(False);
    if not CoolTrayIcon1.CycleIcons then
      Status(_('Loading alarms...'));
    TxAndWait('AT+CALA?'); // do not localize
    sl := TstringList.Create;
    sl.Text := ThreadSafe.RxBuffer.Text;
    try
      EData := ExplorerNew.GetNodeData(FNodeAlarms);
      dl := TStringList(EData.Data);
      dl.Clear;
      ExplorerNew.DeleteChildren(FNodeAlarms);
      ExplorerNew.Update;
      for i := 0 to sl.Count - 2 do begin
        if pos('+CALA', sl[i]) = 1 then begin // do not localize
          str := Copy(sl[i], 8, length(sl[i]));
          dl.Add(str);
          w := str;
          EData := ExplorerNew.GetNodeData(ExplorerNew.AddChild(FNodeAlarms));
          EData.Text := GetFirstToken(w);
          EData.ImageIndex := 66;
          EData.StateIndex := StrToInt(GetFirstToken(w));
        end;
      end;
    finally
      sl.Free;
      if frmExplore.Visible then frmExplore.RootNode := ExplorerNew.FocusedNode;
    end;
    if frmInfoView.Visible then EBCAState(True);
    //ExplorerNew.Expanded[FNodeAlarms] := true;
    if not CoolTrayIcon1.CycleIcons then
      Status('');
  except
    Log.AddCommunicationMessage('Error getting Alarms', lsDebug); // do not localize debug
  end;
end;

procedure TForm1.DoRemoveAlarm;
var
  Data: PFmaExplorerNode;
  Node: PVirtualNode;
  s: WideString;
begin
  Node := frmExplore.GetSelectedNode;
  if Assigned(Node) then begin
    Data := ExplorerNew.GetNodeData(FNodeAlarms);
    s := TStringList(Data.Data)[Node.Index];
    if MessageDlgW(WideFormat(_('Deleting alarm for "%s". Do you wish to continue?'), [GetFirstToken(s)]),
      mtConfirmation, MB_YESNO or MB_DEFBUTTON2) = ID_YES then begin
      Status(_('Deleting Alarm...'));
      try
        TxAndWait(Format('AT+CALD=%s',[GetFirstToken(s)]));
        InitAlarms;
      except
        Status(_('Error deleting alarm'));
        MessageDlgW(_('Alarm could not be deleted.'),mtError,MB_OK);
      end;
    end;
  end;
end;

procedure TForm1.ActionNotInObexUpdate(Sender: TObject);
begin
  (Sender as TTntAction).Enabled := not Form1.FObex.Connected;
end;

procedure TForm1.ActionToolsPostAlarmExecute(Sender: TObject);
var
  Data: PFmaExplorerNode;
  Node: PVirtualNode;
begin
  AskRequestConnection;
  Node := ExplorerNew.AddChild(FNodeAlarms);
  try
    Node.States := Node.States - [vsVisible];
    Data := ExplorerNew.GetNodeData(Node);
    Data.Text := '08:00';  // default alarm time
    Data.ImageIndex := 66;
    Data.StateIndex := -1; // used as a flag that it's a new alarm
    { show alarm properties dialog. if OK alarm will be created and
      explorer view will be updated. }
    ShowExplorerProperties(Node);
    { check if alarm is created }
    Node := FNodeAlarms.LastChild;
    if Assigned(Node) then begin
      Data := ExplorerNew.GetNodeData(Node);
      if Data.StateIndex = -1 then
        Abort; // found, delete it and refresh view
    end;
  except
    ExplorerNew.DeleteNode(Node);
    ExplorerNewChange(ExplorerNew,ExplorerNew.FocusedNode);
  end;
end;

function TForm1.InitNewPhone(ReturnDontShow: boolean): boolean;
var
  EData: PFmaExplorerNode;
begin
  { if ReturnDontShow is 'false', function will return FConnected state,
    otherwise it will return wizard's "Dont show again" checkbox state }
  Result := False;
  frmNewDeviceWizard := TfrmNewDeviceWizard.CreateImg(nil,FmaWebUpdate1.Picture,FmaWebUpdate1.PictureSmall);
  try
    frmNewDeviceWizard.IsDontShowVisible := ReturnDontShow;
    if frmNewDeviceWizard.ShowModal = mrOk then begin
      FDatabaseVersion := GetToken(GetBuildVersionDtl,0,' ');
      MessageBeep(MB_ICONQUESTION);
      if not FConnected or (MessageDlgW(WideFormat(_('You are going to connect to "%s".'+slinebreak+slinebreak+
        'The current connection will be dropped. Are you sure?'),[frmNewDeviceWizard.SelectedDevice.FriendlyName]),
        mtConfirmation, MB_YESNO) = ID_YES) then begin
        { Drop any current connection }
        if FConnected then
          ActionConnectionDisconnect.Execute;

        { Apply new phone settings }
        with frmNewDeviceWizard.SelectedDevice do begin
          ThreadSafe.ConnectionType := ConnectionType;
          FormStorage1.StoredValue['ConnectionType'] := ThreadSafe.ConnectionType; // do not localize
          FStartupOptions.NoObex := DisableObex;
          FStartupOptions.NoIRMC := DisableIrmcSync;
          FormStorage1.StoredValue['NoObex'] := DisableObex; // do not localize
          FormStorage1.StoredValue['NoIRMC'] := DisableIrmcSync; // do not localize
          case ConnectionType of
            0: begin // BT
              FBtAddress := Address;
              FBtDevice := DeviceName;
              FBtPort := frmNewDeviceWizard.LocalWBtSocket.Port;
              FormStorage1.StoredValue['BluetoothAddr'] := FBtAddress; // do not localize
              FormStorage1.StoredValue['BluetoothName'] := FBtDevice;  // do not localize
              FormStorage1.StoredValue['BluetoothPort'] := FBtPort;    // do not localize
            end;
            1: begin // IR
              { nothing to do here }
            end;
            2: begin // COM
              ComPort.Port := Address;
              ComPort.BaudRate := MaxSpeed;
              ComPort.FlowControl.ControlRTS := frmNewDeviceWizard.LocalComPort.FlowControl.ControlRTS;
              ComPort.FlowControl.ControlDTR := frmNewDeviceWizard.LocalComPort.FlowControl.ControlDTR;
              FormStorage1.StoredValue['ComPortControlRTS'] := Integer(ComPort.FlowControl.ControlRTS); // do not localize
              FormStorage1.StoredValue['ComPortControlDTR'] := Integer(ComPort.FlowControl.ControlDTR); // do not localize
            end;
          end;
        end;

        { Connect to new phone device }
        try
          ActionConnectionConnect.Execute;
          { Update view }
          FSelPhone := frmNewDeviceWizard.SelectedDevice.FriendlyName;
          EData := ExplorerNew.GetNodeData(ExplorerNew.GetFirst);
          if Assigned(EData) then begin
            if FSelPhone = '' then FSelPhone := _('My Phone');
            EData.Text := FSelPhone;
            ExplorerNew.Repaint;
            Caption := WideFormat(_('floAt''s Mobile Agent %s - [%s]'),[GetBuildVersionDtl,EData.Text]);
          end;
          { Save changes and update explorer }
          SavePhoneDataFiles(True);
          ExplorerNewChange(ExplorerNew,ExplorerNew.FocusedNode);
          { Update tray icon if phone is renamed }
          if FConnected then
            CoolTrayIcon1.Hint := WideFormat(_('Connected to %s'),[FSelPhone]);
        finally
          if ReturnDontShow then
            Result := frmNewDeviceWizard.IsDontShow
          else
            Result := FConnected;
        end;
      end;
    end
    else
      if ReturnDontShow then
        Result := frmNewDeviceWizard.IsDontShow;
  finally
    FreeAndNil(frmNewDeviceWizard);
  end;
end;

function TForm1.PhoneExists(AName: WideString): boolean;
begin
  with TfrmOfflineProfile.Create(nil) do
    try
      { GetPhoneProfile will return True if phone with name AName exists, and False otherwise }
      Result := ProfileExists(AName);
    finally
      Free;
    end;
end;

function TForm1.PhoneUnique(AName, AIdentity: WideString): boolean;
begin
  with TfrmOfflineProfile.Create(nil) do
    try
      { GetPhoneProfile will return ID of phone named AName with ID different than AIdentity }
      Result := GetPhoneProfile(AName, AIdentity) = '';
    finally
      Free;
    end;
end;

procedure TForm1.HandleCALV(AMsg: String);
begin
{
  Description: This unsolicited result code is returned when an alarm is activated. The
  alarm is set using AT+CALA.
  Unsolicited result
  code:
  +CALV: <n>
  Parameter:
  <n>: Integer; identifies an alarm event.
}
  Delete(AMsg,1,7);

  frmNewAlarm.CreateAlarm(_('An phone alarm has been activated. You could Postpone it for up to a few minutes, or Dismiss it right now.'),
    FAlphaCompose,StrToInt(AMsg));
end;

function TForm1.OpenPhoneDataFiles(ID: string): boolean;
var
  Fullpath: string;
  Pass,Name: WideString;
begin
  { This function will only check if the DB is password protected
    and if so, will require user to provide the correct password. }
  Result := True;
  Fullpath := GetProfilePath(ID) + 'dat\Phone.dat';
  if FileExists(Fullpath) then
    with TIniFile.Create(Fullpath) do // do not localize
    try
      Pass := BaseDecode(ReadString('Global','PhoneLock','')); // do not localize
      Name := UTF8StringToWideString(ReadString('Global','PhoneName','')); // do not localize
      if Pass <> '' then begin
        frmPassword := TfrmPassword.Create(nil);
        try
          Result := frmPassword.LoginModal(Name,Pass) = mrOk;
        finally
          FreeAndNil(frmPassword);
        end;
      end;
    finally
      Free;
    end;
end;

procedure TForm1.ActionToolsExportCalendarExecute(Sender: TObject);
begin
  with frmCalendarView do begin
    Status(_('Exporting calendar...'));
    Log.AddSynchronizationMessage(_('Export started'));
    try
      if TntSaveDialog1.Execute then begin
        SaveCalendar(TntSaveDialog1.FileName,False);
        Log.AddSynchronizationMessage(WideFormat(_('Exported %d %s to "%s"'),
          [DB.vCalendar.Count, ngettext('item','items',DB.vCalendar.Count),
          WideExtractFileName(TntSaveDialog1.FileName)]), lsInformation);
      end;
    finally
      Log.AddSynchronizationMessage(_('Export finished'));
      Status(_('Export complete.'));
    end;
  end;
end;

procedure TForm1.ActionToolsExportCalendarUpdate(Sender: TObject);
begin
  ActionToolsExportCalendar.Enabled := frmCalendarView.DB.vCalendar.Count <> 0;
end;

procedure TForm1.ActionToolsImportCalendarExecute(Sender: TObject);
begin
  frmCalendarView.ImportCalendar1Click(nil);
end;

procedure TForm1.ActionToolsImportCalendarUpdate(Sender: TObject);
begin
  ActionToolsImportCalendar.Enabled := IsIrmcSyncEnabled and frmCalendarView.Visible;
end;

procedure TForm1.HandleCIND(AMsg: String);
const
  FSignalCINDidx  : Integer = 0;
  FSignalCINDmax  : Integer = 0;
  FBatteryCINDidx : Integer = 0;
  FBatteryCINDmax : Integer = 0;
  FBattWarCINDidx : Integer = 0;
  FBattWarCINDmax : Integer = 0;
  FChargerCINDidx : Integer = 0;
  FChargerCINDmax : Integer = 0;
var
  s,str: String;
  w: WideString;
  save: Boolean;
  battlow,bstate,signal,i: Integer;
  function Percentage(Pos,Max: integer): string;
  begin
    Result := IntToStr(Round((100*Pos)/Max))+'%';
  end;
begin
  str := copy(AMsg, 8, length(AMsg));

  if pos('("',str) = 1 then begin
    FSignalCINDidx  := -1;
    FBatteryCINDidx := -1;
    FBattWarCINDidx := -1;
    FChargerCINDidx := -1;
    { +CIND: ("service",(0-1)),("callheld",(0-2)),("call",(0-1)),("callsetup",(0-3)),("signal",(0-5)),("roam",(0-1)),
             ("battchg",(0-5)),("message",(0-1)),("batterywarning",(0-1)),("chargerconnected",(0-1))

    Lot of magic follows in order to remove 'bad' chars from the result...  
    }
    str := StringReplace(str,'),(',',',[rfReplaceAll]);
    str := StringReplace(str,'("','"',[rfReplaceAll]);
    str := StringReplace(str,'))','',[rfReplaceAll]);
    str := StringReplace(str,',(','/',[rfReplaceAll]);
    str := StringReplace(str,'),',',',[rfReplaceAll]);
    i := 0;
    w := str;
    repeat
      s := GetFirstToken(w);
      if pos('"signal"',s) = 1 then begin
        Delete(s,1,Pos('/',s));
        Delete(s,1,Pos('-',s));
        FSignalCINDidx := i;
        FSignalCINDmax := StrToInt(s);
      end;
      if pos('"battchg"',s) = 1 then begin
        Delete(s,1,Pos('/',s));
        Delete(s,1,Pos('-',s));
        FBatteryCINDidx := i;
        FBatteryCINDmax := StrToInt(s);
      end;
      if pos('"batterywarning"',s) = 1 then begin
        Delete(s,1,Pos('/',s));
        Delete(s,1,Pos('-',s));
        FBattWarCINDidx := i;
        FBattWarCINDmax := StrToInt(s);
      end;
      if pos('"chargerconnected"',s) = 1 then begin
        Delete(s,1,Pos('/',s));
        Delete(s,1,Pos('-',s));
        FChargerCINDidx := i;
        FChargerCINDmax := StrToInt(s);
      end;
      inc(i);
    until w = '';
    exit;
  end;

  save := FUseCIND;
  FUseCIND := False; // avoid reccursion in HandleStatus()
  try
    if FUseAlternateSignalMeter then begin
      if FSignalCINDidx <> -1 then begin
        signal := StrToInt(GetToken(str, FSignalCINDidx));
        signal := Round((signal / FSignalCINDmax) * 31);
        HandleStatus(Format('+CSQ: %d,99',[signal])); // 99 = RXQUAL Not known or not detectable.
      end;
    end;
    if FUseAlternateBatteryMeter then begin
      if FBatteryCINDidx <> -1 then begin
        signal := StrToInt(GetToken(str, FBatteryCINDidx));
        signal := Round((signal / FBatteryCINDmax) * 100);
        bstate  := 0; // Phone powered by the battery. No charger connected.
        battlow := 0; // Battery is OK
        if FChargerCINDidx <> -1 then
          if StrToInt(GetToken(str, FChargerCINDidx)) = FChargerCINDmax then
            bstate := 1;  // Phone has a battery connected, but it is powered by the charger.
        if FBattWarCINDidx <> -1 then
          if StrToInt(GetToken(str, FBattWarCINDidx)) = FBattWarCINDmax then
            battlow := 1; // Battery low warning
        HandleStatus(Format('+CBC: %d,%d',[bstate,signal]),battlow);
      end;
    end;
  finally
    FUseCIND := save;
  end;
end;

procedure TForm1.GetSignalMeter;
begin
  if FUseCSQ then begin
    if FUseAlternateSignalMeter then begin
      if FUseCIND then
      TxAndWait('AT+CIND?'); // do not localize
    end
    else
      TxAndWait('AT+CSQ'); // do not localize
  end;
end;

procedure TForm1.GetBatteryMeter;
begin
  if FUseCBC then begin
    if FUseAlternateBatteryMeter then begin
      if FUseCIND then
      TxAndWait('AT+CIND?'); // do not localize
    end
    else
      TxAndWait('AT+CBC'); // do not localize
  end;
end;

function TForm1.GetStatus: WideString;
begin
  Result := StatusBar.Panels[4].Text;
end;

initialization
  if FindCmdLineSwitch('LOG') then begin // do not localize
    LogObserverWriter := TLogObserverWriter.Create;
    LogObserverWriter.FileName := ExtractFilePath(Application.ExeName) + 'MobileAgent.log'; // do not localize
    LogObserverWriter.LogWriterEngine := TLogTextWriterEngine.Create;
    LogObserverWriter.LogEnumeration := Log.GetEnumeration;
  end;
finalization
  FreeAndNil(LogObserverWriter);
end.

