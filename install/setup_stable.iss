; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
AppName=floAt's Mobile Agent
AppVerName=FMA 2.2 [Tech3]
AppPublisher=SourceForge
AppPublisherURL=http://sourceforge.net/projects/fma
AppSupportURL=http://www.mobileagent.info/
AppUpdatesURL=http://sourceforge.net/projects/fma
DefaultDirName={pf}\FMA 2.2
DefaultGroupName=floAt's Mobile Agent 2.2
InfoAfterFile=history.txt
OutputBaseFilename=fma-2.2-stable-setup
LicenseFile=General Public License.rtf
Compression=bzip
WizardImageFile=C:\Projects\cvsroot\fma\pics\setup\fma_wizard2.2.bmp
WizardSmallImageFile=C:\Projects\cvsroot\fma\pics\setup\fma_wizard_small.bmp
WindowVisible=false
BackColor=$00b700
BackColor2=$003e00
AppMutex=Fma_Instance_One_Mutex
AppVersion=2.2
AppID={{B580041B-D762-4D5B-B976-D21E83CCF9F8}
UninstallDisplayIcon={app}\MobileAgent.exe
UninstallDisplayName=floAt's Mobile Agent 2.2
UserInfoPage=true
AppCopyright=The Fma Team
SolidCompression=true
WizardImageBackColor=clWhite
OutputDir=Output
ShowLanguageDialog=auto
LanguageDetectionMethod=none
AllowNoIcons=false
InternalCompressLevel=ultra
VersionInfoVersion=2.2
VersionInfoCompany=floAt's
VersionInfoDescription=floAt's Mobile Agent
VersionInfoTextVersion=2.2 Stable
AppModifyPath={app}\UninsHs.exe /m={{B580041B-D762-4D5B-B976-D21E83CCF9F8}
AlwaysShowDirOnReadyPage=true
AlwaysShowGroupOnReadyPage=true
SetupIconFile=C:\Projects\cvsroot\fma\pics\setup\setup2.2.ico

[LangOptions]
TitleFontName=Tahoma
WelcomeFontName=Tahoma
CopyrightFontName=Tahoma

[Tasks]
; NOTE: The following entry contains English phrases ("Create a desktop icon" and "Additional icons"). You are free to translate them into another language if required.
Name: desktopicon; Description: Create a &Desktop FMA icon; GroupDescription: Additional icons:; Components: bin
Name: quickicon; Description: Create a &Quick Launch FMA icon; Components: bin; GroupDescription: Additional icons:
Name: defsounds; Description: Default FMA Sound Scheme; GroupDescription: Install also:; Components: sound
Name: msscriptctrl; Description: Microsoft Script Control; GroupDescription: Install also:; Components: dotscript script
Name: mscrdownload; Description: Microsoft Script 5.6 (optional, install from Web); Flags: unchecked; GroupDescription: Install also:; Components: ms
Name: mxmldownload; Description: Microsoft XML 4.0 SP2 (optional, install from Web); Flags: unchecked; GroupDescription: Install also:; Components: ms

[Dirs]
Name: {userappdata}\FMA; Flags: uninsneveruninstall
Name: {userappdata}\FMA\$setup$; Attribs: hidden; Flags: uninsalwaysuninstall
Name: {app}\source; Components: src
Name: {app}\sounds; Components: sound
Name: {app}\scripts; Components: script
Name: {app}\helper; Components: dotscript script
Name: {group}\Media Control; Components: bin; Tasks: 
Name: {group}\Scripting Framework; Components: dotscript
Name: {group}\Development; Components: src lang
Name: {app}\sframework; Components: dotscript
Name: {app}\sframework\core; Components: dotscript
Name: {app}\sframework\doc; Components: dotscript
Name: {app}\sframework\helper; Components: dotscript
Name: {app}\sframework\plugins; Components: dotscript
Name: {app}\sframework\helper\config; Components: dotscript
Name: {app}\locale; Components: lang
Name: {app}\locale\en; Components: lang
Name: {app}\locale\en\LC_MESSAGES; Components: lang
Name: {app}\locale\de; Components: lang
Name: {app}\locale\de\LC_MESSAGES; Components: lang
Name: {app}\locale\es; Components: lang
Name: {app}\locale\es\LC_MESSAGES; Components: lang
Name: {app}\locale\fi; Components: lang
Name: {app}\locale\fi\LC_MESSAGES; Components: lang
Name: {app}\locale\fr; Components: lang
Name: {app}\locale\fr\LC_MESSAGES; Components: lang
Name: {app}\locale\no; Components: lang
Name: {app}\locale\no\LC_MESSAGES; Components: lang
Name: {app}\locale\ru; Components: lang
Name: {app}\locale\ru\LC_MESSAGES; Components: lang
Name: {app}\locale\sv; Components: lang
Name: {app}\locale\sv\LC_MESSAGES; Components: lang

[Files]
Source: MobileAgent.exe; DestDir: {app}; Flags: ignoreversion uninsremovereadonly replacesameversion promptifolder overwritereadonly; Components: bin
Source: ..\floAtMixer\floAtMediaCtrl.exe; DestDir: {app}; Flags: sharedfile; Components: bin; Languages: 
Source: General Public License.rtf; DestDir: {app}; Flags: overwritereadonly
Source: history.txt; DestDir: {app}; Flags: overwritereadonly
Source: ..\fma\setup\UninsHs.exe; DestDir: {app}; Flags: restartreplace
Source: ..\fma\uolPatch.dll; DestDir: {app}; Components: tools
Source: ..\fma\isxdl.dll; DestDir: {app}; Components: tools
Source: ..\fma\setup\sct10en.exe; DestDir: {tmp}; Flags: deleteafterinstall; Components: dotscript script
Source: ..\fma\CarpediWebMouse-1.4b.vbs; DestDir: {app}\scripts; Components: script
Source: ..\fma\CarpeDi3m1687 v3.5c.vbs; DestDir: {app}\scripts; Components: script
Source: ide-howto.txt; DestDir: {app}\source; Components: src
Source: Output\source.zip; DestDir: {app}\source; Components: src; Tasks: 
Source: snd\newmsg.wav; DestDir: {app}\sounds; Components: sound
Source: snd\offline.wav; DestDir: {app}\sounds; Components: sound
Source: snd\online.wav; DestDir: {app}\sounds; Components: sound
Source: snd\sentmsg.wav; DestDir: {app}\sounds; Components: sound
Source: snd\ringin.wav; DestDir: {app}\sounds; Components: sound
Source: snd\ringout.wav; DestDir: {app}\sounds; Components: sound
Source: sframework\changelog.txt; DestDir: {app}\sframework; Components: dotscript
Source: sframework\fma-scripting-framework.vbs; DestDir: {app}\sframework; Components: dotscript
Source: sframework\fma.settings-default; DestDir: {app}\sframework; DestName: fma.settings; Components: dotscript
Source: sframework\doc\configurator.png; DestDir: {app}\sframework\doc; Components: dotscript
Source: sframework\doc\core.html; DestDir: {app}\sframework\doc; Components: dotscript
Source: sframework\doc\dev.html; DestDir: {app}\sframework\doc; Components: dotscript
Source: sframework\doc\fma-scripting-framework.html; DestDir: {app}\sframework\doc; Components: dotscript
Source: sframework\doc\LinkedList.html; DestDir: {app}\sframework\doc; Components: dotscript
Source: sframework\doc\Simple.vbs; DestDir: {app}\sframework\doc; Components: dotscript
Source: sframework\doc\Simple-l10n.vbs; DestDir: {app}\sframework\doc; Components: dotscript
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
Source: sframework\core\GnuGetText.vbs; DestDir: {app}\sframework\core; Components: dotscript
Source: sframework\helper\MonCloser.exe; DestDir: {app}\sframework\helper; Components: dotscript
Source: sframework\helper\MoosePlusPlusAlert.exe; DestDir: {app}\sframework\helper; Components: dotscript
Source: sframework\helper\AutoItX.chm; DestDir: {app}\helper; Components: dotscript script
Source: sframework\helper\AutoItX.dll; DestDir: {app}\helper; Components: dotscript script; Flags: regserver sharedfile
Source: sframework\helper\BramusICQ.dll; DestDir: {app}\helper; Components: dotscript script; Flags: regserver sharedfile
Source: sframework\helper\wmpuice.dll; DestDir: {app}\helper; Components: dotscript script; Flags: regserver sharedfile
Source: ..\WinampCtrl\WinampCOMLib.dll; DestDir: {app}\helper; Components: dotscript script; Flags: regserver sharedfile
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
Source: sframework\plugins\SmsDBLog.vbs; DestDir: {app}\sframework\plugins; Components: dotscript; DestName: SmsDBLog.vbs-disabled
Source: sframework\plugins\SmsTextLog.vbs; DestDir: {app}\sframework\plugins; Components: dotscript; DestName: SmsTextLog.vbs-disabled
Source: sframework\plugins\MediaCenter.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\MediaPlayer.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\PluginDisabler.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\SageTV.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\SmsDBLog_EmptyDB.rar; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\FmaKey.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\MoosePlusPlus.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\OnCallPauseWMP.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\OnCallDisconnect.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: sframework\plugins\SmsReader.vbs; DestDir: {app}\sframework\plugins; DestName: SmsReader.vbs-disabled; Components: dotscript
Source: sframework\plugins\WMP10.vbs; DestDir: {app}\sframework\plugins; Components: dotscript
Source: {sys}\COMDLG32.OCX; DestDir: {sys}; Flags: regserver uninsneveruninstall external dontcopy restartreplace; Components: ; Tasks: ; Languages: 
Source: L10n-howto.txt; DestDir: {app}\locale; Components: lang
Source: locale\languagecodes.po; DestDir: {app}\locale; Components: lang
Source: locale\en\flag.bmp; DestDir: {app}\locale\en; Components: lang
Source: locale\en\LC_MESSAGES\default.ini; DestDir: {app}\locale\en\LC_MESSAGES; Components: lang
Source: locale\en\LC_MESSAGES\default.po; DestDir: {app}\locale\en\LC_MESSAGES; Components: lang
Source: locale\en\LC_MESSAGES\default.mo; DestDir: {app}\locale\en\LC_MESSAGES; Components: lang
Source: locale\en\LC_MESSAGES\languages.ini; DestDir: {app}\locale\en\LC_MESSAGES; Components: lang
Source: locale\en\LC_MESSAGES\languages.mo; DestDir: {app}\locale\en\LC_MESSAGES; Components: lang
Source: locale\ru\flag.bmp; DestDir: {app}\locale\ru; Components: lang
Source: locale\ru\LC_MESSAGES\default.mo; DestDir: {app}\locale\ru\LC_MESSAGES; Components: lang
Source: locale\ru\LC_MESSAGES\languages.mo; DestDir: {app}\locale\ru\LC_MESSAGES; Components: lang
Source: locale\fr\flag.bmp; DestDir: {app}\locale\fr; Components: lang
Source: locale\fr\LC_MESSAGES\default.mo; DestDir: {app}\locale\fr\LC_MESSAGES; Components: lang
Source: locale\fr\LC_MESSAGES\languages.mo; DestDir: {app}\locale\fr\LC_MESSAGES; Components: lang
Source: locale\no\flag.bmp; DestDir: {app}\locale\no; Components: lang
Source: locale\no\LC_MESSAGES\default.mo; DestDir: {app}\locale\no\LC_MESSAGES; Components: lang
Source: locale\no\LC_MESSAGES\languages.mo; DestDir: {app}\locale\no\LC_MESSAGES; Components: lang
Source: locale\fi\flag.bmp; DestDir: {app}\locale\fi; Components: lang
Source: locale\fi\LC_MESSAGES\default.mo; DestDir: {app}\locale\fi\LC_MESSAGES; Components: lang
Source: locale\fi\LC_MESSAGES\languages.mo; DestDir: {app}\locale\fi\LC_MESSAGES; Components: lang
Source: locale\es\flag.bmp; DestDir: {app}\locale\es; Components: lang
Source: locale\es\LC_MESSAGES\default.mo; DestDir: {app}\locale\es\LC_MESSAGES; Components: lang
Source: locale\es\LC_MESSAGES\languages.mo; DestDir: {app}\locale\es\LC_MESSAGES; Components: lang
Source: locale\sv\flag.bmp; DestDir: {app}\locale\sv; Components: lang
Source: locale\sv\LC_MESSAGES\default.mo; DestDir: {app}\locale\sv\LC_MESSAGES; Components: lang
Source: locale\sv\LC_MESSAGES\languages.mo; DestDir: {app}\locale\sv\LC_MESSAGES; Components: lang
Source: locale\de\flag.bmp; DestDir: {app}\locale\de; Components: lang
Source: locale\de\LC_MESSAGES\default.mo; DestDir: {app}\locale\de\LC_MESSAGES; Components: lang
Source: locale\de\LC_MESSAGES\languages.mo; DestDir: {app}\locale\de\LC_MESSAGES; Components: lang

[Icons]
Name: {userdesktop}\floAt's Mobile Agent 2.2; Filename: {app}\MobileAgent.exe; Tasks: desktopicon; WorkingDir: {app}; IconIndex: 0; Flags: createonlyiffileexists; Components: bin; Comment: Opens floAt's Mobile Agent application.
Name: {userappdata}\Microsoft\Internet Explorer\Quick Launch\floAt's Mobile Agent 2.2; Filename: {app}\MobileAgent.exe; WorkingDir: {app}; Comment: Opens floAt's Mobile Agent application.; IconIndex: 0; Flags: createonlyiffileexists; Components: bin; Tasks: quickicon
Name: {group}\floAt's Mobile Agent; Filename: {app}\MobileAgent.exe; WorkingDir: {app}; IconIndex: 0; Flags: createonlyiffileexists; Components: bin; Comment: Opens floAt's Mobile Agent application.
Name: {group}\floAt's Mobile Agent in Debug Mode; Filename: {app}\MobileAgent.exe; Parameters: /debug /debugobex; IconIndex: 0; WorkingDir: {app}; Flags: createonlyiffileexists; Components: bin; Comment: Opens floAt's Mobile Agent application in debug mode. Useful if you have experienced some problems using Fma.
Name: {group}\General Public License; Filename: {app}\General Public License.rtf; WorkingDir: {app}; Comment: General Public License; Flags: createonlyiffileexists
Name: {group}\Release Change Log; Filename: {app}\history.txt; WorkingDir: {app}; Comment: history; Flags: createonlyiffileexists
Name: {group}\Uninstall floAt's Mobile Agent; Filename: {app}\UninsHs.exe; Parameters: /u={{B580041B-D762-4D5B-B976-D21E83CCF9F8}; IconIndex: 0; Flags: createonlyiffileexists; WorkingDir: {app}
Name: {group}\Development\Delphi IDE Howto; Filename: {app}\source\ide-howto.txt; WorkingDir: {app}\source; Comment: ide-howto; Flags: createonlyiffileexists; Components: src
Name: {group}\Development\Localization Howto; Filename: {app}\locale\L10n-howto.txt; WorkingDir: {app}\locale; Comment: L10n-howto; Flags: createonlyiffileexists; Components: lang
Name: {group}\Media Control\Management Tray Icon; Filename: {app}\floAtMediaCtrl.exe; WorkingDir: {app}; Comment: Loads Media Control in System Tray Area.; Flags: createonlyiffileexists; IconIndex: 0; Components: bin
Name: {group}\Scripting Framework\Configurator; Filename: {app}\sframework\helper\config\config.exe; WorkingDir: {app}\sframework\helper\config; Comment: Opens Scripting Framework's settings Configurator.; Flags: createonlyiffileexists; IconIndex: 0; Components: dotscript
Name: {group}\Scripting Framework\HTML Help; Filename: {app}\sframework\doc\fma-scripting-framework.html; WorkingDir: {app}\sframework\doc; Comment: Opens HTML help about FMA Scripting Framework.; Flags: createonlyiffileexists; Components: dotscript
;Name: {group}\Uninstall floAt's Mobile Agent; Filename: {uninstallexe}; Flags: createonlyiffileexists

[Run]
Filename: {app}\MobileAgent.exe; Description: Launch floAt's Mobile Agent; Flags: nowait postinstall skipifsilent; Components: bin; WorkingDir: {app}
; call Media Control with /u switch to exit any loaded instance
; install new Media Control
Filename: {app}\floAtMediaCtrl.exe; WorkingDir: {app}; Tasks: ; StatusMsg: Starting Media Control...; Flags: waituntilidle skipifdoesntexist; Components: bin
Filename: {tmp}\sct10en.exe; Tasks: msscriptctrl; Parameters: /q; StatusMsg: Installing Script Control...; Flags: runminimized; Components: dotscript script
Filename: {tmp}\scripten.exe; Components: ms; Tasks: mscrdownload; Parameters: /q; StatusMsg: Installing Script Engine...; Flags: runminimized
Filename: msiexec; Components: ms; Flags: runminimized; Tasks: mxmldownload; Parameters: "/quiet /norestart /i ""{tmp}\msxml.msi"""; StatusMsg: Installing XML Parser...
Filename: {app}\UninsHs.exe; Parameters: /r={{B580041B-D762-4D5B-B976-D21E83CCF9F8},{language},{srcexe},{userappdata}\FMA\$setup$\fmamsi.exe; WorkingDir: {app}; Flags: runminimized runhidden nowait; StatusMsg: Saving Setup Settings...

[UninstallRun]
; call Media Control with /u switch to exit any loaded instance
Filename: {app}\floAtMediaCtrl.exe; Parameters: /u; WorkingDir: {app}; Flags: skipifdoesntexist; RunOnceId: StopMediaCtrl

[Components]
Name: bin; Description: Application Files (Required); Flags: fixed; Types: custom full compact
Name: lang; Description: Interface Translations; Flags: disablenouninstallwarning; Types: custom full compact
Name: tools; Description: Automatic Web Update; Flags: disablenouninstallwarning; Types: custom full compact
Name: sound; Description: Sound Effects; Flags: disablenouninstallwarning; Types: custom full compact
Name: script; Description: All-in-one Scripts; Flags: disablenouninstallwarning; Types: custom full
Name: dotscript; Description: Scripting Framework; Flags: disablenouninstallwarning; Types: custom full
Name: src; Description: Borland Delphi 7 Source Code; Flags: disablenouninstallwarning; Types: custom full
Name: ms; Description: Scripting and XML packages (Download from Microsoft.com, English only); Flags: disablenouninstallwarning; Types: custom full; ExtraDiskSpaceRequired: 5965824

[Registry]
Root: HKCU; SubKey: AppEvents\Schemes\Apps\MobileAgent\FMA_MEConnected\.current; ValueType: string; ValueData: {app}\Sounds\online.wav; Components: sound; Tasks: defsounds; Flags: uninsdeletekeyifempty uninsdeletevalue
Root: HKCU; SubKey: AppEvents\Schemes\Apps\MobileAgent\FMA_MEDisconnected\.current; ValueType: string; ValueData: {app}\Sounds\offline.wav; Components: sound; Tasks: defsounds; Flags: uninsdeletekeyifempty uninsdeletevalue
Root: HKCU; SubKey: AppEvents\Schemes\Apps\MobileAgent\FMA_CallReceived\.current; ValueType: string; ValueData: {app}\Sounds\ringin.wav; Components: sound; Tasks: defsounds; Flags: uninsdeletekeyifempty uninsdeletevalue
Root: HKCU; SubKey: AppEvents\Schemes\Apps\MobileAgent\FMA_Calling\.current; ValueType: string; ValueData: {app}\Sounds\ringout.wav; Components: sound; Tasks: defsounds; Flags: uninsdeletekeyifempty uninsdeletevalue
Root: HKCU; SubKey: AppEvents\Schemes\Apps\MobileAgent\FMA_SMSReceived\.current; ValueType: string; ValueData: {app}\Sounds\newmsg.wav; Components: sound; Tasks: defsounds; Flags: uninsdeletekeyifempty uninsdeletevalue
Root: HKCU; SubKey: AppEvents\Schemes\Apps\MobileAgent\FMA_SMSSent\.current; ValueType: string; ValueData: {app}\Sounds\sentmsg.wav; Components: sound; Tasks: defsounds; Flags: uninsdeletekeyifempty uninsdeletevalue
; set default script to Scripting Framework on first install
Root: HKCU; Subkey: Software\floAt\MobileAgent; ValueType: string; ValueName: ScriptFile; ValueData: {app}\sframework\fma-scripting-framework.vbs; Components: dotscript; Flags: createvalueifdoesntexist uninsdeletekeyifempty uninsdeletevalue

[InstallDelete]
; this section is needed for MODIFY uninstall option - we have to delete all files/dirs which components doen't have "fixed" flag; they will be re-installed if needed.
Name: {userdesktop}\floAt's Mobile Agent 2.2.lnk; Type: files
Name: {userappdata}\Microsoft\Internet Explorer\Quick Launch\floAt's Mobile Agent 2.2.lnk; Type: files
Name: {group}; Type: filesandordirs
Name: {app}\locale; Type: filesandordirs
Name: {app}\source; Type: filesandordirs
Name: {app}\sounds; Type: filesandordirs
Name: {app}\sframework; Type: filesandordirs
Name: {app}\scripts; Type: filesandordirs
Name: {app}\isxdl.dll; Type: files
Name: {app}\uolPatch.dll; Type: files

[UninstallDelete]
; remove Web Udate temp files
Name: {app}\update.txt; Type: files
Name: {app}\MobileAgent.lst; Type: files
Name: {app}\*.dif; Type: files
Name: {app}\*.rev; Type: files
; remove Profile dirs if empty
Name: {app}\helper; Type: filesandordirs
Name: {app}\data; Type: dirifempty
Name: {userappdata}\FMA\$setup$; Type: filesandordirs
Name: {userappdata}\FMA; Type: dirifempty

[Languages]
Name: en; MessagesFile: compiler:Default.isl
; Name: br; MessagesFile: ..\fma\locale\setup\BrazilianPortuguese.isl
Name: bg; MessagesFile: ..\fma\locale\setup\Bulgarian.isl
; Name: ca; MessagesFile: ..\fma\locale\setup\Catalan.isl
Name: chs; MessagesFile: ..\fma\locale\setup\ChineseSimp.isl
; Name: cs; MessagesFile: ..\fma\locale\setup\Czech.isl
; Name: da; MessagesFile: ..\fma\locale\setup\Danish.isl
; Name: nl; MessagesFile: ..\fma\locale\setup\Dutch.isl
Name: fi; MessagesFile: ..\fma\locale\setup\Finnish.isl
Name: fr; MessagesFile: ..\fma\locale\setup\French.isl
Name: de; MessagesFile: ..\fma\locale\setup\German.isl
; Name: hu; MessagesFile: ..\fma\locale\setup\Hungarian.isl
Name: it; MessagesFile: ..\fma\locale\setup\Italian.isl
; Name: nb; MessagesFile: ..\fma\locale\setup\Norwegian.isl
; Name: pl; MessagesFile: ..\fma\locale\setup\Polish.isl
; Name: pt; MessagesFile: ..\fma\locale\setup\PortugueseStd.isl
Name: ru; MessagesFile: ..\fma\locale\setup\Russian.isl
; Name: sl; MessagesFile: ..\fma\locale\setup\Slovenian.isl

[Code]
function ShouldSkipPage(CurPage: Integer): Boolean;
begin
  if Pos('/SP-', UpperCase(GetCmdTail)) > 0 then
    case CurPage of
      wpWelcome, wpLicense, wpPassword, wpInfoBefore, wpUserInfo,
      wpSelectDir, wpSelectProgramGroup, wpInfoAfter:
      Result := True;
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
