; floAt's Mobile Agent setup script
; Maintained by Zdravko Stoychev
; <zdravko@5group.com>
[Setup]
AppName=floAt's Mobile Agent 2
AppVerName=FMA 2.1 Beta 4
AppPublisher=SourceForge
AppPublisherURL=http://fma.sourceforge.net/
AppSupportURL=http://fma.sourceforge.net/forums
AppUpdatesURL=http://sourceforge.net/projects/fma
DefaultDirName={pf}\FMA 2
DefaultGroupName=floAt's Mobile Agent 2
InfoAfterFile=history.txt
OutputBaseFilename=fma-2.1-beta-4-setup
LicenseFile=General Public License.rtf
Compression=bzip
WizardImageFile=..\resources\setup\fma_wizard_z610_black.bmp
WizardSmallImageFile=..\resources\setup\fma_wizard_small_z610_black.bmp
WindowVisible=false
BackColor=clGreen
BackColor2=clBlack
AppMutex=Fma_Instance_One_Mutex
AppVersion=2.1
AppID={{9029363A-8173-435A-9C7C-94AE7E4945D8}
UninstallDisplayIcon={app}\MobileAgent.exe
UninstallDisplayName=floAt's Mobile Agent 2
UserInfoPage=true
AppCopyright=© 2003-2006 by FMA Team
SolidCompression=true
WizardImageBackColor=clWhite
OutputDir=output
ShowLanguageDialog=auto
LanguageDetectionMethod=none
AllowNoIcons=false
InternalCompressLevel=ultra
VersionInfoVersion=2.1.99
VersionInfoCompany=floAt's
VersionInfoDescription=floAt's Mobile Agent
VersionInfoTextVersion=2.1 Beta 4
VersionInfoCopyright=© 2003-2006 by FMA Team

[LangOptions]
TitleFontName=Tahoma
WelcomeFontName=Tahoma
CopyrightFontName=Tahoma

[Tasks]
; NOTE: The following entry contains English phrases ("Create a desktop icon" and "Additional icons"). You are free to translate them into another language if required.
Name: desktopicon; Description: Create a &Desktop FMA icon; GroupDescription: Additional icons:; Components: bin
Name: quickicon; Description: Create a &Quick Launch FMA icon; Components: bin; GroupDescription: Additional icons:
Name: defsounds; Description: Default FMA Sound Scheme; GroupDescription: Install also:; Components: bin
Name: msscriptctrl; Description: Microsoft Script Control; GroupDescription: Install also:; Components: ms
Name: msscript56; Description: Microsoft Script 5.6; GroupDescription: Install also:; Components: ms
Name: msxmlsp2; Description: Microsoft XML 4.0 SP2; GroupDescription: Install also:

[Files]
Source: ..\fma\trunk\MobileAgent.exe; DestDir: {app}; Flags: ignoreversion uninsremovereadonly; Components: bin
Source: ..\fma\trunk\UOLPatch.dll; DestDir: {app}; Components: tools
Source: ..\fma\trunk\isxdl.dll; DestDir: {app}; Components: tools
Source: {sys}\COMDLG32.OCX; DestDir: {sys}; Flags: regserver uninsneveruninstall external dontcopy
Source: General Public License.rtf; DestDir: {app}
Source: history.txt; DestDir: {app}; Components: bin; Tasks: 
Source: ..\sounds\newmsg.wav; DestDir: {app}\sounds; Components: sound
Source: ..\sounds\offline.wav; DestDir: {app}\sounds; Components: sound
Source: ..\sounds\online.wav; DestDir: {app}\sounds; Components: sound
Source: ..\sounds\ringin.wav; DestDir: {app}\sounds; Components: sound
Source: ..\sounds\ringout.wav; DestDir: {app}\sounds; Components: sound
Source: ..\sounds\sentmsg.wav; DestDir: {app}\sounds; Components: sound
Source: redist\script56.chm; DestDir: {app}\help; Components: ms\scripts ms\sframe
Source: ..\scripts\CarpeDi3m1687.vbs; DestDir: {app}; Components: ms\scripts
Source: ..\scripts\CarpediWebMouse.vbs; DestDir: {app}; Components: ms\scripts
Source: ..\floAtMixer\trunk\floAtMediaCtrl.exe; DestDir: {app}; Flags: sharedfile; Tasks: 
Source: ..\winampCOMlib\trunk\WinampCOMLib.dll; DestDir: {app}\sframework\helper; Flags: regserver sharedfile; Components: ms\sframe
Source: ..\scripts\sframework\trunk\fma-scripting-framework.vbs; DestDir: {app}\sframework; Components: ms\sframe
Source: ..\scripts\sframework\trunk\fma.settings-default; DestDir: {app}\sframework; DestName: fma.settings; Components: ms\sframe
Source: ..\scripts\sframework\trunk\doc\configurator.png; DestDir: {app}\sframework\doc; Components: ms\sframe
Source: ..\scripts\sframework\trunk\doc\core.html; DestDir: {app}\sframework\doc; Components: ms\sframe
Source: ..\scripts\sframework\trunk\doc\dev.html; DestDir: {app}\sframework\doc; Components: ms\sframe
Source: ..\scripts\sframework\trunk\doc\fma-scripting-framework.html; DestDir: {app}\sframework\doc; Components: ms\sframe
Source: ..\scripts\sframework\trunk\doc\LinkedList.html; DestDir: {app}\sframework\doc; Components: ms\sframe
Source: ..\scripts\sframework\trunk\doc\Simple.vbs; DestDir: {app}\sframework\doc; Components: ms\sframe
Source: ..\scripts\sframework\trunk\doc\Test.vbs; DestDir: {app}\sframework\doc; Components: ms\sframe
Source: ..\scripts\sframework\trunk\doc\Demo.vbs; DestDir: {app}\sframework\doc; Components: ms\sframe
Source: ..\scripts\sframework\trunk\doc\Simple-l10n.vbs; DestDir: {app}\sframework\doc; Components: ms\sframe
Source: ..\scripts\sframework\trunk\doc\use.html; DestDir: {app}\sframework\doc; Components: ms\sframe
Source: ..\scripts\sframework\trunk\core\GnuGetText.vbs; DestDir: {app}\sframework\core; Components: ms\sframe
Source: ..\scripts\sframework\trunk\core\ActiveXManagerClass.vbs; DestDir: {app}\sframework\core; Components: ms\sframe
Source: ..\scripts\sframework\trunk\core\DebugClass.vbs; DestDir: {app}\sframework\core; Components: ms\sframe
Source: ..\scripts\sframework\trunk\core\EventManagerClass.vbs; DestDir: {app}\sframework\core; Components: ms\sframe
Source: ..\scripts\sframework\trunk\core\Hash.vbs; DestDir: {app}\sframework\core; Components: ms\sframe
Source: ..\scripts\sframework\trunk\core\KeyManagerClass.vbs; DestDir: {app}\sframework\core; Components: ms\sframe
Source: ..\scripts\sframework\trunk\core\LinkedList.vbs; DestDir: {app}\sframework\core; Components: ms\sframe
Source: ..\scripts\sframework\trunk\core\ManagedMenu.vbs; DestDir: {app}\sframework\core; Components: ms\sframe
Source: ..\scripts\sframework\trunk\core\PluginManagerClass.vbs; DestDir: {app}\sframework\core; Components: ms\sframe
Source: ..\scripts\sframework\trunk\core\QuickSort.vbs; DestDir: {app}\sframework\core; Components: ms\sframe
Source: ..\scripts\sframework\trunk\core\SettingsClass.vbs; DestDir: {app}\sframework\core; Components: ms\sframe
Source: ..\scripts\sframework\trunk\core\Stack.vbs; DestDir: {app}\sframework\core; Components: ms\sframe
Source: ..\scripts\sframework\trunk\core\UtilClass.vbs; DestDir: {app}\sframework\core; Components: ms\sframe
Source: ..\scripts\sframework\trunk\helper\wmpuice.dll; DestDir: {app}\sframework\helper; Flags: regserver sharedfile; Components: ms\sframe
Source: ..\scripts\sframework\trunk\helper\MonCloser.exe; DestDir: {app}\sframework\helper; Components: ms\sframe
Source: ..\scripts\sframework\trunk\helper\AutoItX.chm; DestDir: {app}\sframework\helper; Components: ms\sframe
Source: ..\scripts\sframework\trunk\helper\AutoItX.dll; DestDir: {app}\sframework\helper; Flags: regserver sharedfile; Components: ms\sframe
Source: ..\scripts\sframework\trunk\helper\BramusICQ.dll; DestDir: {app}\sframework\helper; Flags: regserver sharedfile; Components: ms\sframe
Source: ..\scripts\sframework\trunk\helper\MoosePlusPlusAlert.exe; DestDir: {app}\sframework\helper; Components: ms\sframe
Source: ..\scripts\sframework\trunk\helper\config\ArrayData.cls; DestDir: {app}\sframework\helper\config; Components: ms\sframe
Source: ..\scripts\sframework\trunk\helper\config\config.exe; DestDir: {app}\sframework\helper\config; Components: ms\sframe
Source: ..\scripts\sframework\trunk\helper\config\config.vbp; DestDir: {app}\sframework\helper\config; Components: ms\sframe
Source: ..\scripts\sframework\trunk\helper\config\config.vbw; DestDir: {app}\sframework\helper\config; Components: ms\sframe
Source: ..\scripts\sframework\trunk\helper\config\DefaultComparator.cls; DestDir: {app}\sframework\helper\config; Components: ms\sframe
Source: ..\scripts\sframework\trunk\helper\config\fma.gif; DestDir: {app}\sframework\helper\config; Components: ms\sframe
Source: ..\scripts\sframework\trunk\helper\config\fma.settings.description; DestDir: {app}\sframework\helper\config; Components: ms\sframe
Source: ..\scripts\sframework\trunk\helper\config\frmSettings.frm; DestDir: {app}\sframework\helper\config; Components: ms\sframe
Source: ..\scripts\sframework\trunk\helper\config\frmSettings.frx; DestDir: {app}\sframework\helper\config; Components: ms\sframe
Source: ..\scripts\sframework\trunk\helper\config\frmSplash.frm; DestDir: {app}\sframework\helper\config; Components: ms\sframe
Source: ..\scripts\sframework\trunk\helper\config\frmSplash.frx; DestDir: {app}\sframework\helper\config; Components: ms\sframe
Source: ..\scripts\sframework\trunk\helper\config\Global.bas; DestDir: {app}\sframework\helper\config; Components: ms\sframe
Source: ..\scripts\sframework\trunk\helper\config\Hash.cls; DestDir: {app}\sframework\helper\config; Components: ms\sframe
Source: ..\scripts\sframework\trunk\helper\config\HashItem.cls; DestDir: {app}\sframework\helper\config; Components: ms\sframe
Source: ..\scripts\sframework\trunk\helper\config\PluginComparator.cls; DestDir: {app}\sframework\helper\config; Components: ms\sframe
Source: ..\scripts\sframework\trunk\helper\config\QuickSort.cls; DestDir: {app}\sframework\helper\config; Components: ms\sframe
Source: ..\scripts\sframework\trunk\helper\config\UtilClass.cls; DestDir: {app}\sframework\helper\config; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\AutoMenu.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\BramusICQ.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\BSPlayer.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\Camera.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\Configurator.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\FileExplorer.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\foobar2000.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\FrameworkMainMenu.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\iTunes.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\MasterVolume.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\MediaCenter9.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\MediaPlayer9.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\MediaPlayerClassic.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\MoreTV.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\Mouse.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\MousePlus.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\OnCallPauseWA.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\PluginInfo.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\PowerDVD5.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\Powerpoint.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\Tools.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\VLCPLayer.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\Winamp.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\WinDVD.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\WinTV.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\ZoomPlayer.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\StreetAtlas8.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\SmsDBLog.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\SmsTextLog.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\MediaCenter.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\MediaPlayer.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\SageTV.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\FmaKey.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\LightAlloy.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\NeroShowTime.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\OnCallDisconnect.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\OnCallPauseWMP.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\PluginManager.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\SmsReader.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\scripts\sframework\trunk\plugins\WMP10.vbs; DestDir: {app}\sframework\plugins; Components: ms\sframe
Source: ..\fma\howtos\ide-howto.txt; DestDir: {app}; Components: src
Source: ..\fma\howtos\L10n-dev-howto.txt; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: ..\fma\howtos\L10n-new-template-howto.txt; DestDir: {app}\source; Flags: overwritereadonly sortfilesbyextension; Components: src
Source: ..\fma\howtos\L10n-howto.txt; DestDir: {app}; Components: lang
Source: ..\locale\languagecodes.po; DestDir: {app}\locale; Components: lang
Source: ..\locale\en\flag.bmp; DestDir: {app}\locale\en; Components: lang
Source: ..\locale\en\LC_MESSAGES\default.ini; DestDir: {app}\locale\en\LC_MESSAGES; Components: lang
Source: ..\locale\en\LC_MESSAGES\default.po; DestDir: {app}\locale\en\LC_MESSAGES; Components: lang
Source: ..\locale\en\LC_MESSAGES\languages.ini; DestDir: {app}\locale\en\LC_MESSAGES; Components: lang
Source: ..\locale\en\LC_MESSAGES\languages.po; DestDir: {app}\locale\en\LC_MESSAGES; Components: lang
Source: ..\fma\trunk\dxgettext.ini; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\gginitialize2.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\gginitialize.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\gnugettext.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\gnugettexthelpers.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\MobileAgent.cfg; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\MobileAgent.dof; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\MobileAgent.dpr; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\MobileAgent.res; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\MobileAgent.tlb; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\MobileAgent_TLB.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uAbout.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uAbout.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uAbout.templ; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uAccessoriesMenu.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uActivityLog.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uActivityLog.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uAddToGroup.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uAddToGroup.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uAddToPhonebook.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uAddToPhonebook.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uBrowseFolders.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uBrowseFolders.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uCallContact.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uCallContact.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uCalling.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uCalling.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uChatSMS.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uChatSMS.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uChooseLink.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uChooseLink.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uComposeSMS.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uComposeSMS.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uConflictChanges.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uConflictChanges.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uConnProgress.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uConnProgress.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uContactSync.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uCrash.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uCrash.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uDebug.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uDebug.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uDeliveryRule.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uDeliveryRule.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uDialogs.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uEditContact.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uEditContact.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uEditEvent.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uEditEvent.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uEditProfile.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uEditProfile.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uEditTask.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uEditTask.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uExploreView.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uExploreView.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uFiles.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uFMASync.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uFolderProps.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uFolderProps.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uGetContact.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uGetContact.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uGlobal.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uImg32Helper.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uInetGet.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uInfoView.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uInfoView.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uInputQuery.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uInputQuery.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uKeyPad.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uKeyPad.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uLog.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uLog.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uLogDetails.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uLogDetails.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uLogger.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uLogObserver.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uLogObserverWriter.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uLogWriters.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uMEEdit.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uMEEdit.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uMissedCalls.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uMissedCalls.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uMobileAgentUI.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uMsgView.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uMsgView.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uNewAlarm.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uNewAlarm.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uNewDeviceWizard.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uNewDeviceWizard.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uNewMessage.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uNewMessage.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\Unit1.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\Unit1.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uObex.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uOfflineProfile.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uOfflineProfile.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uOptions.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uOptions.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uOptionsPage.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uOptionsPage.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uOrganizeFavs.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uOrganizeFavs.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uOutlookSync.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uPassword.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uPassword.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uPostNote.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uPostNote.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uPostURL.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uPostURL.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uPromptConflict.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uPromptConflict.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uRegistry.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uScriptEditor.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uScriptEditor.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uSelectContact.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uSelectContact.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uSIMEdit.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uSIMEdit.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uSMS.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uSMSDetail.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uSMSDetail.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uSplash.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uSplash.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uStatusDlg.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uStatusDlg.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uSyncBookmarks.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uSyncBookmarks.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uSyncCalendar.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uSyncCalendar.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uSyncLog.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uSyncLog.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uSyncPhonebook.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uSyncPhonebook.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uThreadSafe.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uTrayIcon.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uVBase.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uVCalendar.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uVCard.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uVersion.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uVpVDB.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uWABSync.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uWaitComplete.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uWBMP.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uWelcome.dfm; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uWelcome.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\uXMLContactSync.pas; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: ..\fma\trunk\winxp.res; DestDir: {app}\source; Flags: overwritereadonly; Components: src
Source: redist\scripten-me.exe; DestDir: {tmp}; Components: ms; Flags: deleteafterinstall; DestName: scripten.exe; MinVersion: 4.0.950,0; OnlyBelowVersion: 0,4.0.1381
Source: redist\scripten-xp.exe; DestDir: {tmp}; Components: ms; Flags: deleteafterinstall; DestName: scripten.exe; MinVersion: 0,5.0.2195; OnlyBelowVersion: 0,5.2
Source: redist\scripten-srv.exe; DestDir: {tmp}; Components: ms; Flags: deleteafterinstall; DestName: scripten.exe; MinVersion: 0,5.2
Source: redist\sct10en.exe; DestDir: {tmp}; Components: ms; Flags: deleteafterinstall
Source: redist\msxml.msi; DestDir: {tmp}; Flags: deleteafterinstall
Source: ..\fma\help\MobileAgent.chm; DestDir: {app}\help; Components: bin

[Icons]
Name: {userdesktop}\floAt's Mobile Agent 2; Filename: {app}\MobileAgent.exe; Tasks: desktopicon; WorkingDir: {app}; IconIndex: 0; Flags: createonlyiffileexists; Components: bin; Comment: Opens floAt's Mobile Agent application.
Name: {userappdata}\Microsoft\Internet Explorer\Quick Launch\floAt's Mobile Agent 2; Filename: {app}\MobileAgent.exe; WorkingDir: {app}; Comment: Opens floAt's Mobile Agent application.; IconIndex: 0; Flags: createonlyiffileexists; Components: bin; Tasks: quickicon
Name: {group}\floAt's Mobile Agent; Filename: {app}\MobileAgent.exe; WorkingDir: {app}; IconIndex: 0; Flags: createonlyiffileexists; Components: bin; Comment: Opens floAt's Mobile Agent application.
Name: {group}\floAt's Mobile Agent in Debug Mode; Filename: {app}\MobileAgent.exe; Parameters: -debug -debugobex; IconIndex: 0; WorkingDir: {app}; Flags: createonlyiffileexists; Components: bin; Comment: Opens floAt's Mobile Agent application in debug mode. Useful if you have experienced some problems using FMA.
Name: {group}\floAt's Mobile Agent Help; Filename: {app}\help\MobileAgent.chm; WorkingDir: {app}\help; Comment: Opens floAt's Mobile Agent help file.; Flags: createonlyiffileexists; Components: bin
Name: {group}\General Public License; Filename: {app}\General Public License.rtf; WorkingDir: {app}; Comment: Opens floAt's Mobile Agent license agreement file.; Flags: createonlyiffileexists
Name: {group}\Media Control Management; Filename: {app}\floAtMediaCtrl.exe; WorkingDir: {app}; Comment: Starts Media Control application in system tray area.; Flags: createonlyiffileexists; IconIndex: 0; Components: ms\sframe
Name: {group}\Project Compile Notes; Filename: {app}\ide-howto.txt; WorkingDir: {app}; Comment: Opens floAt's Mobile Agent Delphi project IDE Howto file.; Flags: createonlyiffileexists
Name: {group}\Project Localization Notes; Filename: {app}\L10n-howto.txt; WorkingDir: {app}; Comment: Opens floAt's Mobile Agent Delphi project L18N Howto file.; Flags: createonlyiffileexists
Name: {group}\Project Release Notes; Filename: {app}\history.txt; WorkingDir: {app}; Comment: Opens floAt's Mobile Agent release notes file.; Flags: createonlyiffileexists
Name: {group}\Scripting Technologies Help; Filename: {app}\help\script56.chm; WorkingDir: {app}\help; Comment: Opens Microsoft Scripting Technologies Help file.; Flags: createonlyiffileexists; Components: ms\scripts ms\sframe
Name: {group}\Uninstall floAt's Mobile Agent; Filename: {uninstallexe}; Flags: createonlyiffileexists; Comment: Uninstalls floAt's Mobile Agent application.

[Run]
Filename: {app}\MobileAgent.exe; Description: Launch floAt's Mobile Agent; Flags: nowait skipifsilent skipifdoesntexist postinstall; Components: bin; WorkingDir: {app}
Filename: {app}\floAtMediaCtrl.exe; WorkingDir: {app}; Flags: nowait skipifsilent skipifdoesntexist; Tasks: 
Filename: msiexec; Flags: runminimized; Parameters: "/quiet /norestart /i ""{tmp}\msxml.msi"""; StatusMsg: Installing XML Parser...; Tasks: msxmlsp2
Filename: {tmp}\sct10en.exe; Components: ms; Tasks: msscriptctrl; Parameters: /q; StatusMsg: Installing Script Control...; Flags: runminimized
Filename: {tmp}\scripten.exe; Components: ms; Parameters: /q; StatusMsg: Installing Script Engine...; Flags: runminimized; Tasks: msscript56

[Components]
Name: bin; Description: Application Files; Types: custom compact full
Name: sound; Description: Sound Effect Files; Types: custom full
Name: lang; Description: Multilanguage Support; Types: custom compact full
Name: tools; Description: Web Updates Support; Types: custom compact full
Name: ms; Description: Scripting Support; Types: custom full
Name: ms\scripts; Description: All-in-one Scripts; Types: custom full
Name: ms\sframe; Description: Scripting Framework; Types: custom full
Name: src; Description: Delphi 7 Source Code; Types: custom

[Dirs]
Name: {app}\source; Components: src
Name: {app}\sounds; Components: sound
Name: {app}\sframework; Components: ms\sframe
Name: {app}\sframework\core; Components: ms\sframe
Name: {app}\sframework\doc; Components: ms\sframe
Name: {app}\sframework\helper; Components: ms\sframe
Name: {app}\sframework\plugins; Components: ms\sframe
Name: {app}\sframework\helper\config; Components: ms\sframe
Name: {userappdata}\FMA; Flags: uninsneveruninstall; Components: bin
Name: {app}\locale; Components: bin
Name: {app}\locale\en; Components: bin
Name: {app}\locale\en\LC_MESSAGES; Components: bin
Name: {app}\help

[Registry]
Root: HKCU; SubKey: AppEvents\Schemes\Apps\MobileAgent\FMA_MEConnected\.current; ValueType: string; ValueData: {app}\Sounds\online.wav; Flags: createvalueifdoesntexist uninsdeletevalue uninsdeletekeyifempty; Components: sound; Tasks: defsounds
Root: HKCU; SubKey: AppEvents\Schemes\Apps\MobileAgent\FMA_MEDisconnected\.current; ValueType: string; ValueData: {app}\Sounds\offline.wav; Flags: createvalueifdoesntexist uninsdeletevalue uninsdeletekeyifempty; Components: sound; Tasks: defsounds
Root: HKCU; SubKey: AppEvents\Schemes\Apps\MobileAgent\FMA_CallReceived\.current; ValueType: string; ValueData: {app}\Sounds\ringin.wav; Flags: uninsdeletevalue uninsdeletekeyifempty createvalueifdoesntexist; Components: sound; Tasks: defsounds
Root: HKCU; SubKey: AppEvents\Schemes\Apps\MobileAgent\FMA_Calling\.current; ValueType: string; ValueData: {app}\Sounds\ringout.wav; Flags: createvalueifdoesntexist uninsdeletevalue uninsdeletekeyifempty; Components: sound; Tasks: defsounds
Root: HKCU; SubKey: AppEvents\Schemes\Apps\MobileAgent\FMA_SMSReceived\.current; ValueType: string; ValueData: {app}\Sounds\newmsg.wav; Flags: createvalueifdoesntexist uninsdeletevalue uninsdeletekeyifempty; Components: sound; Tasks: defsounds
Root: HKCU; SubKey: AppEvents\Schemes\Apps\MobileAgent\FMA_SMSSent\.current; ValueType: string; ValueData: {app}\Sounds\sentmsg.wav; Flags: createvalueifdoesntexist uninsdeletevalue uninsdeletekeyifempty; Components: sound; Tasks: defsounds
Root: HKCU; Subkey: Software\floAt\MobileAgent; ValueType: string; ValueName: ScriptFile; ValueData: {app}\sframework\fma-scripting-framework.vbs; Flags: uninsdeletekeyifempty uninsdeletevalue createvalueifdoesntexist; Components: ms\sframe

[UninstallDelete]
Name: {app}\*.dif; Type: files
Name: {app}\*.rev; Type: files
Name: {app}\update.txt; Type: files
Name: {app}\MobileAgent.lst; Type: files
Name: {app}\data; Type: dirifempty
Name: {app}\locale; Type: filesandordirs
Name: {userappdata}\FMA\default.tmp; Type: filesandordirs
Name: {userappdata}\FMA; Type: dirifempty

[_ISTool]
UseAbsolutePaths=false
