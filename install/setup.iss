; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
AppName=floAt's Mobile Agent 2
AppVerName=Fma 2.1 Beta 2
AppPublisher=SourceForge
AppPublisherURL=http://sourceforge.net/projects/fma
AppSupportURL=http://sourceforge.net/projects/fma
AppUpdatesURL=http://sourceforge.net/projects/fma
DefaultDirName={pf}\Fma 2
DefaultGroupName=floAt's Mobile Agent 2
InfoAfterFile=C:\Projects\cvsroot\fma\history.txt
OutputBaseFilename=fma-2.1-beta-2-setup
LicenseFile=C:\Projects\cvsroot\fma\General Public License.rtf
Compression=bzip
WizardImageFile=C:\Projects\cvsroot\fma\pics\setup\fma_wizard_k700.bmp
WizardSmallImageFile=C:\Projects\cvsroot\fma\pics\setup\fma_wizard_small.bmp
WindowVisible=false
BackColor=clGreen
BackColor2=clBlack
AppMutex=Fma_Instance_One_Mutex
AppVersion=2.1
AppID={{9029363A-8173-435A-9C7C-94AE7E4945D8}
UninstallDisplayIcon={app}\MobileAgent.exe
UninstallDisplayName=floAt's Mobile Agent 2
UserInfoPage=true
AppCopyright=The Fma Team
SolidCompression=true
WizardImageBackColor=clWhite
OutputDir=C:\Projects\cvsroot\fma\Output
ShowLanguageDialog=auto
LanguageDetectionMethod=none
AllowNoIcons=false
InternalCompressLevel=ultra
VersionInfoVersion=2.1.0.77
VersionInfoCompany=floAt's
VersionInfoDescription=floAt's Mobile Agent
VersionInfoTextVersion=2.1 Beta 2

[LangOptions]
TitleFontName=Tahoma
WelcomeFontName=Tahoma
CopyrightFontName=Tahoma

[Tasks]
; NOTE: The following entry contains English phrases ("Create a desktop icon" and "Additional icons"). You are free to translate them into another language if required.
Name: desktopicon; Description: Create a &Desktop FMA icon; GroupDescription: Additional icons:; Components: bin
Name: quickicon; Description: Create a &Quick Launch FMA icon; Components: bin; GroupDescription: Additional icons:
Name: defsounds; Description: Default FMA Sound Scheme; GroupDescription: Install also:
Name: msscriptctrl; Description: Microsoft Script Control; GroupDescription: Install also:; Components: ms
Name: mscrdownload; Description: Microsoft Script 5.6 (optional, install from Web); Flags: unchecked; GroupDescription: Install also:; Components: ms
Name: mxmldownload; Description: Microsoft XML 4.0 SP2 (optional, install from Web); Flags: unchecked; GroupDescription: Install also:; Components: ms

[Files]
Source: MobileAgent.exe; DestDir: {app}; Flags: ignoreversion uninsremovereadonly; Components: bin
Source: General Public License.rtf; DestDir: {app}
Source: history.txt; DestDir: {app}
Source: todo.txt; DestDir: {app}
Source: ide-howto.txt; DestDir: {app}; Components: src
Source: ..\fma\CarpeDi3m1687 v3.5b.vbs; DestDir: {app}; Components: script
Source: ..\fma\CarpediWebMouse-1.4b.vbs; DestDir: {app}; Components: script
Source: snd\newmsg.wav; DestDir: {app}\sounds; Components: sound
Source: snd\offline.wav; DestDir: {app}\sounds; Components: sound
Source: snd\online.wav; DestDir: {app}\sounds; Components: sound
Source: snd\sentmsg.wav; DestDir: {app}\sounds; Components: sound
Source: snd\ringin.wav; DestDir: {app}\sounds; Components: sound
Source: snd\ringout.wav; DestDir: {app}\sounds; Components: sound
Source: ..\fma\setup\UOLPatch.dll; DestDir: {app}; Components: tools
Source: ..\fma\setup\isxdl.dll; DestDir: {app}; Components: tools
Source: ..\fma\setup\sct10en.exe; DestDir: {tmp}; Components: ms
Source: ..\WinampCtrl\WinampCOMLib.dll; DestDir: {app}\sframework\helper; Components: dotscript; Flags: regserver sharedfile
Source: ..\floAtMixer\floAtMediaCtrl.exe; DestDir: {app}\sframework\helper; Components: dotscript; Flags: sharedfile
Source: sframework\changelog.txt; DestDir: {app}\sframework; Components: dotscript
Source: sframework\fma-scripting-framework.vbs; DestDir: {app}\sframework; Components: dotscript; AfterInstall: UpdateSframeworkPath
Source: sframework\fma.settings-default; DestDir: {app}\sframework; DestName: fma.settings; Components: dotscript
Source: sframework\doc\configurator.png; DestDir: {app}\sframework\doc; Components: dotscript
Source: sframework\doc\core.html; DestDir: {app}\sframework\doc; Components: dotscript
Source: sframework\doc\dev.html; DestDir: {app}\sframework\doc; Components: dotscript
Source: sframework\doc\fma-scripting-framework.html; DestDir: {app}\sframework\doc; Components: dotscript
Source: sframework\doc\LinkedList.html; DestDir: {app}\sframework\doc; Components: dotscript
Source: sframework\doc\Simple.vbs; DestDir: {app}\sframework\doc; Components: dotscript
Source: sframework\doc\use.html; DestDir: {app}\sframework\doc; Components: dotscript
Source: sframework\core\ActiveXManagerClass.vbs; DestDir: {app}\sframework\core; Components: dotscript
Source: sframework\core\DebugClass.vbs; DestDir: {app}\sframework\core; Components: dotscript
Source: sframework\core\EventManagerClass.vbs; DestDir: {app}\sframework\core; Components: dotscript
Source: sframework\core\Hash.vbs; DestDir: {app}\sframework\core; Components: dotscript
Source: sframework\core\KeyManagerClass.vbs; DestDir: {app}\sframework\core; Components: dotscript
Source: sframework\core\LinkedList.vbs; DestDir: {app}\sframework\core; Components: dotscript
Source: sframework\core\ManagedMenu.vbs; DestDir: {app}\sframework\core; Components: dotscript
Source: sframework\core\PluginManagerClass.vbs; DestDir: {app}\sframework\core; Components: dotscript
Source: sframework\core\QuickSort.vbs; DestDir: {app}\sframework\core; Components: dotscript
Source: sframework\core\SettingsClass.vbs; DestDir: {app}\sframework\core; Components: dotscript
Source: sframework\core\Stack.vbs; DestDir: {app}\sframework\core; Components: dotscript
Source: sframework\core\UtilClass.vbs; DestDir: {app}\sframework\core; Components: dotscript
Source: sframework\helper\MonCloser.exe; DestDir: {app}\sframework\helper; Components: dotscript
Source: sframework\helper\AutoItX.chm; DestDir: {app}\sframework\helper; Components: dotscript
Source: sframework\helper\AutoItX.dll; DestDir: {app}\sframework\helper; Components: dotscript; Flags: regserver sharedfile
Source: sframework\helper\BramusICQ.dll; DestDir: {app}\sframework\helper; Components: dotscript; Flags: regserver sharedfile
Source: sframework\helper\config\ArrayData.cls; DestDir: {app}\sframework\helper\config; Components: dotscript
Source: sframework\helper\config\config.exe; DestDir: {app}\sframework\helper\config; Components: dotscript
Source: sframework\helper\config\config.vbp; DestDir: {app}\sframework\helper\config; Components: dotscript
Source: sframework\helper\config\config.vbw; DestDir: {app}\sframework\helper\config; Components: dotscript
Source: sframework\helper\config\DefaultComparator.cls; DestDir: {app}\sframework\helper\config; Components: dotscript
Source: sframework\helper\config\fma.gif; DestDir: {app}\sframework\helper\config; Components: dotscript
Source: sframework\helper\config\fma.settings.description; DestDir: {app}\sframework\helper\config; Components: dotscript
Source: sframework\helper\config\frmSettings.frm; DestDir: {app}\sframework\helper\config; Components: dotscript
Source: sframework\helper\config\frmSettings.frx; DestDir: {app}\sframework\helper\config; Components: dotscript
Source: sframework\helper\config\frmSplash.frm; DestDir: {app}\sframework\helper\config; Components: dotscript
Source: sframework\helper\config\frmSplash.frx; DestDir: {app}\sframework\helper\config; Components: dotscript
Source: sframework\helper\config\Global.bas; DestDir: {app}\sframework\helper\config; Components: dotscript
Source: sframework\helper\config\Hash.cls; DestDir: {app}\sframework\helper\config; Components: dotscript
Source: sframework\helper\config\HashItem.cls; DestDir: {app}\sframework\helper\config; Components: dotscript
Source: sframework\helper\config\PluginComparator.cls; DestDir: {app}\sframework\helper\config; Components: dotscript
Source: sframework\helper\config\QuickSort.cls; DestDir: {app}\sframework\helper\config; Components: dotscript
Source: sframework\helper\config\UtilClass.cls; DestDir: {app}\sframework\helper\config; Components: dotscript
Source: sframework\plugins\AutoMenu.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\BramusICQ.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\BSPlayer.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\Camera.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\Configurator.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\FileExplorer.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\foobar2000.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\FrameworkMainMenu.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\iTunes.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\MasterVolume.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\MediaCenter9.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\MediaPlayer9.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\MediaPlayerClassic.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\MoreTV.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\Mouse.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\MousePlus.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\OnCallPauseWA.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\PluginInfo.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\PowerDVD5.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\Powerpoint.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\Tools.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\VLCPLayer.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\Winamp.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\WinDVD.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\WinTV.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\ZoomPlayer.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\StreetAtlas8.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\Demo.vbs; DestDir: {app}\sframework\plugins; Components: dotscript; DestName: Demo.vbs-disabled
Source: sframework\plugins\Test.vbs; DestDir: {app}\sframework\plugins; Components: dotscript; DestName: Test.vbs-disabled
Source: sframework\plugins\SmsMDBLog.vbs; DestDir: {app}\sframework\plugins; Components: dotscript; DestName: SmsMDBLog.vbs-disabled
Source: sframework\plugins\SmsTextLog.vbs; DestDir: {app}\sframework\plugins; Components: dotscript; DestName: SmsTextLog.vbs-disabled
Source: sframework\plugins\MediaCenter.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\MediaPlayer.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\PluginDisabler.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\SageTV.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: {sys}\COMDLG32.OCX; DestDir: {sys}; Flags: regserver uninsneveruninstall external dontcopy
Source: uAbout.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uActivityLog.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uAddToGroup.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uAddToPhonebook.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uCalendarView.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uCallContact.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uCalling.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uChatSMS.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uChooseLink.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uComposeSMS.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uConnProgress.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uCrash.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uDebug.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uEditContact.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uEditEvent.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uEditProfile.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uEditTask.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uExploreView.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uFolderProps.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uGetContact.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uInfoView.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uInputQuery.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uKeyPad.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uLog.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uLogDetails.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uMissedCalls.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uMsgView.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uNewDeviceWizard.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uNewMessage.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: Unit1.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uOfflineProfile.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uOptions.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uOrganizeFavs.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uPostNote.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uPostURL.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uPromptConflict.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uScriptEditor.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uSelectContact.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uSIMEdit.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uSMSDetail.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uSplash.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uStatusDlg.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uSyncBookmarks.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uSyncLog.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uSyncPhonebook.dfm; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: MobileAgent.dpr; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: gginitialize2.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: gginitialize.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: gnugettext.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: gnugettexthelpers.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: gsm_sms.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: MobileAgent_TLB.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uAbout.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uAccessoriesMenu.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uActivityLog.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uAddToGroup.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uAddToPhonebook.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uCalendarView.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uCallContact.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uCalling.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uChatSMS.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uChooseLink.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uComposeSMS.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uConnProgress.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uContactSync.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uCrash.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uDebug.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uDialogs.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uEditContact.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uEditEvent.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uEditProfile.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uEditTask.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uExploreView.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uFiles.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uFMASync.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uFolderProps.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uGetContact.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uGlobal.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uInetGet.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uInfoView.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uInputQuery.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uKeyPad.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uLog.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uLogDetails.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uLogger.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uLogObserver.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uLogWriters.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uMissedCalls.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uMobileAgentUI.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uMsgView.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uNewDeviceWizard.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uNewMessage.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: Unit1.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uObex.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uOfflineProfile.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uOptions.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uOrganizeFavs.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uOutlookSync.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uPostNote.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uPostURL.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uPromptConflict.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uScriptEditor.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uSelectContact.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uSIMEdit.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uSMSDetail.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uSplash.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uStatusDlg.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uSyncBookmarks.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uSyncLog.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uSyncPhonebook.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uThreadSafe.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uTrayIcon.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uVBase.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uVCalendar.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uVCard.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uVersion.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uVpVDB.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uWABSync.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uWaitComplete.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uWBMP.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uXMLContactSync.pas; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: MobileAgent.dof; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: MobileAgent.drc; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: uAbout.inc; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: MobileAgent.cfg; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: MobileAgent.res; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: winxp.res; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: L10n-dev-howto.txt; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: L10n-new-template-howto.txt; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: MobileAgent.tlb; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: L10n-howto.txt; DestDir: {app}; Components: lang
Source: locale\languagecodes.po; DestDir: {app}\locale; Components: lang
Source: locale\en\flag.bmp; DestDir: {app}\locale\en; Components: lang
Source: locale\en\LC_MESSAGES\default.ini; DestDir: {app}\locale\en\LC_MESSAGES; Components: lang
Source: locale\en\LC_MESSAGES\default.mo; DestDir: {app}\locale\en\LC_MESSAGES; Components: lang
Source: locale\en\LC_MESSAGES\default.po; DestDir: {app}\locale\en\LC_MESSAGES; Components: lang
Source: locale\en\LC_MESSAGES\languages.ini; DestDir: {app}\locale\en\LC_MESSAGES; Components: lang
Source: locale\en\LC_MESSAGES\languages.po; DestDir: {app}\locale\en\LC_MESSAGES; Components: lang
Source: sframework\helper\wmpuice.dll; DestDir: {app}\sframework\helper; Flags: regserver sharedfile; Components: dotscript
Source: sframework\core\GnuGetText.vbs; DestDir: {app}\sframework\core; Components: dotscript

[Icons]
Name: {userdesktop}\floAt's Mobile Agent 2; Filename: {app}\MobileAgent.exe; Tasks: desktopicon; WorkingDir: {app}; IconIndex: 0; Flags: createonlyiffileexists; Components: bin; Comment: Opens floAt's Mobile Agent application.
Name: {userappdata}\Microsoft\Internet Explorer\Quick Launch\floAt's Mobile Agent 2; Filename: {app}\MobileAgent.exe; WorkingDir: {app}; Comment: Opens floAt's Mobile Agent application.; IconIndex: 0; Flags: createonlyiffileexists; Components: bin; Tasks: quickicon
Name: {group}\floAt's Mobile Agent; Filename: {app}\MobileAgent.exe; WorkingDir: {app}; IconIndex: 0; Flags: createonlyiffileexists; Components: bin; Comment: Opens floAt's Mobile Agent application.
Name: {group}\floAt's Mobile Agent in Debug Mode; Filename: {app}\MobileAgent.exe; Parameters: -debug -debugobex; IconIndex: 0; WorkingDir: {app}; Flags: createonlyiffileexists; Components: bin; Comment: Opens floAt's Mobile Agent application in debug mode. Useful if you have experienced some problems using Fma.
Name: {group}\Media Control Tray Icon; Filename: {app}\floAtMediaCtrl.exe; WorkingDir: {app}; Comment: floAtMediaCtrl; Flags: createonlyiffileexists; Components: dotscript
Name: {group}\General Public License; Filename: {app}\General Public License.rtf; WorkingDir: {app}; Comment: General Public License; Flags: createonlyiffileexists
Name: {group}\Project Change Log; Filename: {app}\history.txt; WorkingDir: {app}; Comment: history; Flags: createonlyiffileexists
Name: {group}\Project Delphi IDE Howto; Filename: {app}\ide-howto.txt; WorkingDir: {app}; Comment: ide-howto; Flags: createonlyiffileexists
Name: {group}\Project Localization Howto; Filename: {app}\L10n-howto.txt; WorkingDir: {app}; Comment: L10n-howto; Flags: createonlyiffileexists
Name: {group}\Project Todo List; Filename: {app}\todo.txt; WorkingDir: {app}; Comment: todo; Flags: createonlyiffileexists
Name: {group}\Uninstall floAt's Mobile Agent; Filename: {uninstallexe}; Flags: createonlyiffileexists

[Run]
Filename: {app}\MobileAgent.exe; Description: Launch floAt's Mobile Agent; Flags: nowait postinstall skipifsilent; Components: bin; WorkingDir: {app}
Filename: {app}\sframework\helper\floAtMediaCtrl.exe; WorkingDir: {app}\sframework\helper; Components: dotscript; Flags: nowait
Filename: {tmp}\scripten.exe; Components: ms; Tasks: mscrdownload; Parameters: /q; StatusMsg: Installing Script Engine...; Flags: runminimized
Filename: {tmp}\sct10en.exe; Components: ms; Tasks: msscriptctrl; Parameters: /q; StatusMsg: Installing Script Control...; Flags: runminimized
Filename: msiexec; Components: ms; Flags: runminimized; Tasks: mxmldownload; Parameters: "/quiet /norestart /i ""{tmp}\msxml.msi"""; StatusMsg: Installing XML Parser...

[Components]
Name: bin; Description: Precompiled Binaries; Types: custom compact full
Name: lang; Description: Interface Translations; Types: custom compact full
Name: tools; Description: Update Tools; Types: custom compact full
Name: sound; Description: Sounds; Types: custom full
Name: script; Description: All-in-one Scripts; Types: custom full
Name: dotscript; Description: Scripting Framework; Types: custom full
Name: src; Description: Delphi 6/7 Source Code; Types: custom full
Name: ms; Description: Microsoft Components; Types: custom full

[Dirs]
Name: {app}\source; Components: src
Name: {app}\sounds; Components: sound
Name: {app}\sframework; Components: dotscript
Name: {app}\sframework\core; Components: dotscript
Name: {app}\sframework\doc; Components: dotscript
Name: {app}\sframework\helper; Components: dotscript
Name: {app}\sframework\plugins; Components: dotscript
Name: {app}\sframework\helper\config; Components: dotscript
Name: {userappdata}\FMA; Flags: uninsneveruninstall; Components: bin
Name: {app}\locale
Name: {app}\locale\en
Name: {app}\locale\en\LC_MESSAGES

[Registry]
Root: HKCU; SubKey: AppEvents\Schemes\Apps\MobileAgent\FMA_MEConnected\.current; ValueType: string; ValueData: {app}\Sounds\online.wav; Flags: createvalueifdoesntexist uninsdeletevalue uninsdeletekeyifempty; Components: sound; Tasks: defsounds
Root: HKCU; SubKey: AppEvents\Schemes\Apps\MobileAgent\FMA_MEDisconnected\.current; ValueType: string; ValueData: {app}\Sounds\offline.wav; Flags: createvalueifdoesntexist uninsdeletevalue uninsdeletekeyifempty; Components: sound; Tasks: defsounds
Root: HKCU; SubKey: AppEvents\Schemes\Apps\MobileAgent\FMA_CallReceived\.current; ValueType: string; ValueData: {app}\Sounds\ringin.wav; Flags: uninsdeletevalue uninsdeletekeyifempty createvalueifdoesntexist; Components: sound; Tasks: defsounds
Root: HKCU; SubKey: AppEvents\Schemes\Apps\MobileAgent\FMA_Calling\.current; ValueType: string; ValueData: {app}\Sounds\ringout.wav; Flags: createvalueifdoesntexist uninsdeletevalue uninsdeletekeyifempty; Components: sound; Tasks: defsounds
Root: HKCU; SubKey: AppEvents\Schemes\Apps\MobileAgent\FMA_SMSReceived\.current; ValueType: string; ValueData: {app}\Sounds\newmsg.wav; Flags: createvalueifdoesntexist uninsdeletevalue uninsdeletekeyifempty; Components: sound; Tasks: defsounds
Root: HKCU; SubKey: AppEvents\Schemes\Apps\MobileAgent\FMA_SMSSent\.current; ValueType: string; ValueData: {app}\Sounds\sentmsg.wav; Flags: createvalueifdoesntexist uninsdeletevalue uninsdeletekeyifempty; Components: sound; Tasks: defsounds
Root: HKCU; Subkey: Software\floAt\MobileAgent; ValueType: string; ValueName: ScriptFile; ValueData: {app}\sframework\fma-scripting-framework.vbs; Flags: uninsdeletekeyifempty uninsdeletevalue createvalueifdoesntexist; Components: dotscript

[UninstallDelete]
Name: {app}\update.txt; Type: files
Name: {app}\*.dif; Type: files
Name: {app}\*.rev; Type: files
Name: {app}\data; Type: dirifempty
Name: {app}\locale; Type: filesandordirs

[Code]
procedure UpdateSframeworkPath;
var
  f: TStringList;
  i: integer;
  s: string;
begin
  s := ExpandConstant(CurrentFileName);
  f := TStringList.Create;
  try
    f.LoadFromFile(s);
    for i := 0 to f.Count-1 do
      if Pos('ScriptFolder',Trim(f[i])) = 1 then begin
        f[i] := 'ScriptFolder = "'+ExtractFilePath(s)+'"';
        f.SaveToFile(s);
        break;
      end;
  finally
    f.Free;
  end;
end;

// Function generated by ISTool.
function NextButtonClick(CurPage: Integer): Boolean;
begin
  Result := istool_download(CurPage);
end;

[_ISToolDownload]
Source: http://download.microsoft.com/download/2/8/a/28a5a346-1be1-4049-b554-3bc5f3174353/scripten.exe; DestDir: {tmp}; DestName: scripten.exe; Components: ms; Tasks: mscrdownload
Source: http://download.microsoft.com/download/9/6/5/9657c01e-107f-409c-baac-7d249561629c/msxml.msi; DestDir: {tmp}; DestName: msxml.msi; Components: ms; Tasks: mxmldownload

[_ISTool]
UseAbsolutePaths=false
