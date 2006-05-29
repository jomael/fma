'FMA Script Framework
'Version 1.0
'Developed by streawkceur <twittek@smail.uni-koeln.de> and dVRVm

'Main Program
'Optimized for FMA 2.1.2.17, but should work with FMA 2.0 as well

'$Id: fma-scripting-framework.vbs,v 1.5.2.6 2005/12/23 17:07:32 mhr3 Exp $
'$Log: fma-scripting-framework.vbs,v $
'Revision 1.5.2.6  2005/12/23 17:07:32  mhr3
'changed version info
'
'Revision 1.5.2.5  2005/12/20 10:14:54  mhr3
'optimized keymonitoring
'
'Revision 1.5.2.4  2005/10/05 10:40:31  mhr3
'Merged with changes in HEAD branch
'
'Revision 1.7  2005/05/12 19:04:55  voxik
'Added file identification on start of each readed file for easier identification
'Changed core is now loaded to one eval block for easier debug
'
'Revision 1.6  2005/04/17 20:19:17  mhr3
'compability issues
'
'Revision 1.5  2005/02/08 15:39:09  voxik
'Merged with L10N branch
'
'Revision 1.2.2.3  2005/01/07 17:58:11  expertone
'Merge with MAIN branch
'
'Revision 1.4  2004/12/16 08:21:45  z_stoichev
'Fixed: Changed Global Constants to be Dims.
'
'Revision 1.3  2004/11/06 20:01:26  voxik
'Changed KeyManager to properly enable and disable key monitoring.
'
'Revision 1.2.2.2  2004/11/15 13:18:13  expertone
'Update script locale with current FMA GUI language/locale
'
'Revision 1.2.2.1  2004/11/01 20:10:34  expertone
'Add localization (gnugettext)
'
'Revision 1.2  2004/09/16 07:27:12  z_stoichev
'Fixed install dir.
'
'Revision 1.1  2004/09/09 08:00:31  z_stoichev
'Imported from streawkceur's CVS
'
'Revision 1.39  2004/03/22 12:04:20  streawkceur
'Modified Configurator a bit. Added configurator option to exclude some plugins from being loaded. Updated docs.
'
'-Using fma.Sleep now. Configurator forces script to reload settings after it saved th settings. Introduced Util.WaitForAppClose. Updated documentation. Updated Tools plugin, now it should work better. Updated Winamp plugin, now has a dialogue for setting winamp volume. Updated BramusICQ.
'-Now _really_ added ActiveXManager
'-Enhanced AutoMenu plugin. It now directly show a specified plugin menu instead of going to the main menu. See configurator.
'-Checked all files for bad line ends. Now every file should work properly in Notepad.exe :)
'-Keyword test

'FMA-Bugs/-Problems:
'-FMA could check AT command length before TX'ing. Must not be > 250 bytes! May cause an AT error otherwise
'-FMA could check <title> length in AT command that have a title element. It seems that titles must not be >15chars. May cause an AT error otherwise
'-FMA could check against selected item > num items in *EASM command. May cause an AT error otherwise
'-FMA could send multiple EASM commands without final flag to put long menus.

'Core-TODO:
'-Test key monitoring in minimized mode
'-Complete ManagedMenu:
'	-am.ClearMenu, am.Selected, am.DlgOption (which looks like a normal menu...)
'-Remove dummy key registration
'-Version Management?: Framework version, (FMA version), plugins version, plugins dependence on a specific framework version
'-Where is the WScript object? MsgBox WScript.ScriptFullName
'-Complete LinkedList (especially ArrayContainerClass)
'!!!-> See TODO's in each other source file

'DOC-TODO:
'	-More comprehensive LinkedList documentation
'	-Whole core documentation

'Plugins-TODO:
'-Core:
'	-Extend Demo Plugin
'-External:
'	-Finishing needed
'		-Camera: OBEX problem
'		-Winamp: Seek, DlgPercent buggy, winampcomlib doesn't support JumpToTime yet
'		-MasterVolume: DlgPercent buggy, Maybe register VolUp/-Down keys (on side of the phone)
'		-Tools: windows version independent shutdown etc.
'	-Testing
'		-BramusICQ
'		-Hauppauge WinTV (I'm not using WinTV...)
'		-ZoomPlayer
'		-iTunes
'	-Finished:
'		AutoMenu, BSPlayer, Configurator, FileExplorer, MediaCenter, MediaPlayer9, MoreTV, Mouse, MousePlus, OnCallPauseWA, PluginInfo, PowerDVD5, Powerpoint, Test, WinDVD

'Explicit variable declaration neccessary
Option Explicit

'Global Constants
'File operations
Dim FILE_FOR_READING
Dim FILE_FOR_WRITING
FILE_FOR_READING = 1
FILE_FOR_WRITING = 2

'Global external Objects
Public Fso, Shell
Set Fso   = CreateObject("Scripting.FileSystemObject")
Set Shell = CreateObject("WScript.Shell")

Dim ScriptFolder
'Should be CHANGED to FMA installation folder! 
'This should be done automaticaly by FMA 2 installer.
'ScriptFolder = "C:\Program Files\Fma 2\sframework\"

'Autodetect script folder (ask FMA)
On Error Resume Next
ScriptFolder = fma.ScriptFolder
fma.Debug "ScriptFolder: " & ScriptFolder
If Err.Number <> 0 Then
	ScriptFolder = ".\sframework\"
	Err.Clear
End If
On Error GoTo 0

'---> Load core classes
Dim CoreImport
CoreImport = ""
'-> Abstact Data Types
CoreImport = CoreImport & readFile(ScriptFolder & "core\Hash.vbs")
CoreImport = CoreImport & readFile(ScriptFolder & "core\Stack.vbs")
CoreImport = CoreImport & readFile(ScriptFolder & "core\LinkedList.vbs")
'-> Localization
CoreImport = CoreImport & readFile(ScriptFolder & "core\GnuGetText.vbs")
'-> Managers
CoreImport = CoreImport & readFile(ScriptFolder & "core\EventManagerClass.vbs")
CoreImport = CoreImport & readFile(ScriptFolder & "core\KeyManagerClass.vbs")
CoreImport = CoreImport & readFile(ScriptFolder & "core\ManagedMenu.vbs")
CoreImport = CoreImport & readFile(ScriptFolder & "core\PluginManagerClass.vbs")
CoreImport = CoreImport & readFile(ScriptFolder & "core\ActiveXManagerClass.vbs")
'-> Others
CoreImport = CoreImport & readFile(ScriptFolder & "core\QuickSort.vbs")
CoreImport = CoreImport & readFile(ScriptFolder & "core\UtilClass.vbs")
CoreImport = CoreImport & readFile(ScriptFolder & "core\DebugClass.vbs")
CoreImport = CoreImport & readFile(ScriptFolder & "core\SettingsClass.vbs")
'---> Import core classes
Execute(CoreImport)

'---> Create global objects
Public Util, Debug, QuickSorter, Settings, EventManager, KeyManager, PluginManager, ActiveXManager, EmptyMenu
Public keyRegLList

Set Util           = New UtilClass
Set Debug          = Util.CreateObject("DebugClass", "Debug")
'Debug.SetDebugLevel DEBUG_LEVEL_OFF
'Debug.SetDebugLevel DEBUG_LEVEL_ERROR
'Debug.SetDebugLevel DEBUG_LEVEL_WARN
Debug.SetDebugLevel DEBUG_LEVEL_INFO
Debug.SetDebugLevel DEBUG_LEVEL_DEBUG
'Debug.SetDebugLevel DEBUG_LEVEL_NOFMA
Set QuickSorter    = New QuickSort
Set keyRegLList    = New LinkedList
Set EmptyMenu      = New ManagedMenu
Set EventManager   = Util.CreateObject("EventManagerClass", "EventManager")
Set KeyManager     = Util.CreateObject("KeyManagerClass", "KeyManager")
Set Settings       = Util.CreateObject("SettingsClass", "Settings")
Set ActiveXManager = Util.CreateObject("ActiveXManagerClass", "ActiveXManager")
Set PluginManager  = Util.CreateObject("PluginManagerClass", "PluginManager")

On Error Resume Next
Debug.InfoMsg "FMA Locale: " & GetCurrentLocale & "(" & GetLocale & ")"
On Error GoTo 0

'Load Settings
Settings.Load

'Import plugins
PluginManager.LoadPlugins

'Needed for importing classes and plugins
Function ReadFile(fileName)
	If Fso.FileExists(fileName) Then
		Dim FFile
		Set FFile = Fso.OpenTextFile(fileName, FILE_FOR_READING)
		ReadFile = FFile.ReadAll
		FFile.Close
	Else
		'Debug.ErrorMsg "ReadFile: File not found: " & fileName
		MsgBox "ReadFile: File not found: " & fileName
		ReadFile = ""
	End If
End Function

'''Delegate Events
Sub OnInit ()
	Debug.InfoMsg "FMA Scripting Framework loaded!"
	EventManager.OnEvent "Init", Array()
	' For the purpose of switching scripts while connected
	If Util.Connected Then 
  	  Util.SetStandbyScreenText g_(DD, "fma loaded")
	  EventManager.OnEvent "Connected", Array()
	End If
End Sub

Sub OnConnected ()
	Debug.DebugMsg "Initializing accessories menu"
	
	am.Init
	Util.SetStandbyScreenText g_(DD, "fma loaded")
	
	EventManager.OnEvent "Connected", Array()
End Sub

Sub OnConnectionLost ()
	EventManager.OnEvent "ConnectionLost", Array()
End Sub

Sub OnDisconnected ()
	EventManager.OnEvent "Disconnected", Array()
End Sub

Sub OnNewSMS ( Sender, Text )
	EventManager.OnEvent "NewSMS", Array( Sender, Text )
End Sub

' Hmm, no idea what the arguments do...
Sub OnCall (Caption, AlphaCaption, Number)
	EventManager.OnEvent "Call", Array( Caption, AlphaCaption, Number )
End Sub

Sub OnAMRoot ()
	EventManager.OnEvent "AMRoot", Array()
End Sub

Sub OnProximity ( State )
	EventManager.OnEvent "Proximity", Array( State )
End Sub

Sub OnMusicMute ( RtnString )
	EventManager.OnEvent "MusicMute", Array( RtnString )
End Sub

Sub OnKeyPress ( Key, Press )
	EventManager.OnEvent "KeyPress", Array( Key, Press )
	' The keypress manager is supposed to register itself in the event manager.
End Sub