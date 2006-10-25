Option Explicit
'------------ CarpeDi3m1687.vbscript version 3.5d (see below for actual number) ------------

' :: Requirements ::

'       * FMA build "2.1.1.102" or later
'       * Microsoft Script Control engine
'       * WinampControl build "1.3" or later
'       * Float's Media Control "1.5.1.2" or later
'       * WMPuICE control
'         - made by Christian Mueller (http://www.mediatexx.com)

' :: Credits ::

'       * iTunes support by daveo
'       * WinDVD control by skyw33
'       * Webcam support (T610) by HRS, eMBee
'       * Mouse Control by Vit Ondruch
'       * Winamp support by CarpeDi3m1687
'       * Internet submenu by mhr
'       * Locate Phone by nossenigma, mhr, hazart
'       * Speech Text by skyw33
'       * WMP 9/10 control by mhr
'       * PowerDVD6 control extended by herb.solo
'       * RadLight control extended by !MOJSO!
'       * Monitor ON/OF control extended by !MOJSO!
' :: More ::

'       * original script created by CarpeDi3m <CarpeDi3m1687@hotmail.com>
'       * send any cool scripts to Dako <z_stoichev AT users.sourceforge.net>
'         if you want to share them with all FMA users.

' :: Notes ::

'       * Winamp READ ID3TAGS ON LOAD, must be enabled when using Winamp
'       * Winamp 3.x is not supported
'       * MENU EDITING: Go to script line 247 and enable/disable menu items

' :: Supported Features ::


'   * Volume Control
'     - mute toggle
'     - master volume control
'     - show current master volume level



' ---- Media Players ----


'   * WinAmp 2.x/5.x
'     + dynamic status update
'       - title playing song
'       - playing status current song
'       - song position (songinfo)
'     + automatic reload of playlist (when songs are added, removed or a playlist is chosen)
'     + functions:
'	  * prev/next track (joystick left/right)
'	  * playlist selection
'	  * volume (volume buttons -/+)
'	  * seek playing song
'	  * launch/close Winamp
'	  * standard play functions
'	     + play
'	     + resume
'	     + pause/stop
'	  * search
'	     + artist/band
'	     + title
'	     + show all artists/bands
'	  * main options (press option button)
'	     + shuffle on/off
'	     + repeat on/off
'	     + reload playlist
'	  * playlist (select playing song)
'	     + prev/next songs (joystick left/right)
'	     + Songinfo (select playing song)
'	       - Normal/Detailed info (joystick left/right)
'	     + playlistoptions (press option button)
'	       - Search title (press */# to go to previous/next result within playlist)
'	       - Goto song#
'	       - Seek current song
'	       - Reload playlist

'  * Windows Media Player 9/10
'     + launch/close WMP (if launching takes more than 8 secs, error is returned)
'     + dynamic status update
'     + standart controls
'        - play
'        - pause
'        - stop
'        - previous, next item in playlist (using < and > buttons while in Media player menu)
'     + editing current media item (you can change Artist and Title) - option key
'     + playrate changing (speed) 50-200% (works only on audio files)
'     + current playlist listing (click on current media item)
'        - jumping to specific page using # button
'        - previous/next page < and >
'        - jumping to clicked item
'     + browsing all playlists (including auto playlists)
'        - playlist selection
'     + searching media library
'        - by author
'        - by name
'        - by album
'        - by genre
'         * WARNING: first search returns only EXACT matches
'           clicking Continue search will return substring matches as well
'     + shuffle/repeat: on/off
'     + fullscreen

'   * PowerDVD
'     - standard play functions ( play, pause, stop, prev/next chapter, step backward/forward )
'     - capture frame (Camera button)
'     - switch between (Chapter / Faster / Jump) forward-rewind
'     - audiostream toggle
'     - subtitle toggle
'     - volume (+/- 5)
'     - mute toggle
'     - fullscreen toggle
'     - switch fullscreen mode on/off (will prevent player from popping up when in fullscreen mode)
'     - set repeat point
'     - launch/close PowerDVD
'     - fast forward / rewind
'     - jump 5 seconds forward / back

'   * BSPlayer
'     - standard play functions ( play, pause, stop, prev, next, )
'     - fullscreen toggle
'     - subtitle on/off
'     - zoom
'     - launch/close BSPlayer

'   * Zoom Player
'     - standard play functions ( play, pause, stop, prev, next )
'     - prev/next
'     - fast forward/reverse
'     - jump ahead/back
'     - fullscreen toggle
'     - subtitle on/off
'     - mute
'     - launch/close Zoom Player

'   * WinDVD
'     - Play/Select
'     - Pause
'     - Stop
'     - Prev/Next Chapter
'     - Audiostream Toggle
'     - Subtitles
'     - Volume Up/Down
'     - Mute/UnMute
'     - Full Screen
'     - Speed Up/Down
'     - Fast Forward/Rewind
'     - Step Forward/Backward
'     - DVD navigation (left, right, up, down, main menu, select)
'     - Launch/Close WinDVD

''   * RadLight
'     - standard play functions ( play, pause, stop, prev, next )
'     - prev/next
'     - fast forward/reverse
'     - jump ahead/back
'     - fullscreen toggle
'     - subtitle on/off     
'     - launch/close RadLight
'                    Tested on RadLight version 3.03 [R5]   
'                                 created by !MOJSO! <mojsovski@gmail.com>

' ---- TV software ----

'   * Hauppauge WinTV
'     - remote mode (enter numbers)
'     - mute toggle
'     - fullscreen toggle
'     - prev/next channel (joystick left/right)
'     - freeze image
'     - make snapshot (Camera button)
'     - select source
'     - launch/close WinTV

'   * MoreTV
'     - remote mode (enter numbers)
'     - mute toggle
'     - fullscreen toggle
'     - prev/next channel (joystick left/right)
'     - launch/close MoreTV

'   * DScaler
'     - remote mode (enter numbers)
'     - mute toggle
'     - fullscreen toggle
'     - last channel
'     - prev/next channel (joystick left/right)
'     - freeze image
'     - make snapshot (Camera button)
'     - start/stop recording
'     - preview
'     - teletext
'     - zoom +/-
'     - launch/close DScaler


' ---- Misc ----

'   * File Manager
'     - Browse folders
'     - Open files
'     - Browse Info
'     - browse up  ( press c )

'   * PowerPoint
'     - start show
'     - next slide
'     - prev slide
'     - toggle screen
'     - end show

'   * iTunes
'     - Play/Pause
'     - Stop
'     - Prev Track
'     - Next Track
'     - Vizualizer
'     - Launch/Close

'   * Mouse Control
'     - enter text (press *)
'     - Enter key (press #)

'   * Misc Control
'     + disconnect fma
'     + lock workstation
'     + shutdown
'       - shutdown
'       - hibernate
'       - reboot
'       - Monitor ON/OF To work properly insert a corect program location of Floats` Mobile Agent  Go to script line 284  (fmadir = C:\Program Files\Fma 2) 
'                         Monitor on/of  created by !MOJSO! <mojsovski@gmail.com>

'   * Internet browsing using MSIE
'     - entering address
'     - navigating to homepage
'     - sending e-mail using default email program
'     - forward/back (also using < >)
'     - navigating in IE using volume keys
'     - enter text (press *)
'     - enter key (press #)

 '---- config ----


'   * Custom MenuSettings (option button)
'     - selection of menu items
'     - sorting of menu items
'     - selection of phone [T610/k700/t68i]	(default: T610)
'     - option to save settings in a config-file (default: off)
'
'   * Main Settings
'     + on call
'       - mute
'       - decrease master volume
'       - pause Winamp
'   * calling FMA menu with # key (hold 2.5+seconds)from anywhere outside FMA menu
'


' :: Implementation ::



'************ Change these settings as needed *************

Public FileName
Public OutputDirectory
Public ProgramDir
Public fmadir

ProgramDir = "C:\Program Files" 'for englisch systems
'ProgramDir = "C:\Programme" 'for german systems

WinampDir = "C:\Program Files\Winamp5"
fmadir = fma.MobileAgentFolder      'Float's Mobile Agent Directory

Sub setDefault()
  FileName = "/Pictures/Picture(1).jpg"
  OutputDirectory = "C:\"

  SettingsFile = "C:\CarpeDi3m1687.sav"				'file-location for saving user-settings
  PlaylistPath = "C:\Playlists"

  SaveSettingsBool 	= FALSE		'default saving setting
  SettingMuteOnCall 	= 2		'default mute music on call 0 = false, 1 = true, 2 = set volume value, 3 = pause winamp
  OnCallDecreaseValue	= 40
  SettingStartOnConnect = TRUE		'default autostart (currently not working)

  MyPhoneType(1) 		= 1	'default selected phone (T610)
  setPhone				'load values for selected phone


  ReDim RootItems(0) 'Menu-items listed default as shown in current order


'--------------------- menu order ------------------------------
'  addRootItem(0)		'Hauppauge WinTV
'  addRootItem(1)		'MoreTV
  addRootItem(2)		'Winamp
  addRootItem(3)		'PowerDVD 6.0
'  addRootItem(4)		'BSPlayer
  addRootItem(5)		'Media Player 9/10
  addRootItem(6)		'Volume Control
  addRootItem(7)		'PowerPoint
  addRootItem(8)		'Misc Control
  addRootItem(9)		'Mouse Control
'  addRootItem(10)		'WinDVD
'  addRootItem(11)		'i-Tunes
'  addRootItem(12)		'DScaler
'  addRootItem(13)		'Zoom-Player
  addRootItem(14)		'Browse Files
  addRootItem(15)		'Iexplore
  addRootItem(16)       'RadLight
'--------------------- menu order ------------------------------

'********************** end custom config **********************



  ScriptVersion		= "3.5b" 	'current script version for tracking config file
  NrSongsOnPage = 6			'nr songs in playlist
End Sub

Public RootID		'rows are ordered by ID
Public RootEXE

Sub initRootID()          'inits all menuitems
  Redim RootEXE(16)

'************ Change these settings as needed *************

  RootEXE(0) = ProgramDir & "\WinTV\WinTV2K.EXE"
  RootEXE(1) = ProgramDir & "\MoreTV.353\MoreTV.exe"
  RootEXE(2) = WinampDir & "\winamp.exe"
  RootEXE(3) = ProgramDir & "\CyberLink\PowerDVD\PowerDVD.exe"
  RootEXE(4) = ProgramDir & "\Webteh\BSplayer\bplay.exe"
  RootEXE(5) = "wmplayer.exe"

  RootEXE(6) = "" 'NOT USED volume control
  RootEXE(7) = "" 'NOT USED powerpoint
  RootEXE(8) = "" 'NOT USED misc control
  RootEXE(9) = "" 'NOT USED mouse control

  RootEXE(10) = ProgramDir & "\InterVideo\DVD6\WinVD.exe"
  RootEXE(11) = "iTunes.exe"
  RootEXE(12) = ProgramDir & "\DScaler\DScaler.EXE"
  RootEXE(13) = ProgramDir & "\Zoomplayer\ZPlayer.exe"

  RootEXE(14) = "" 'NOT USED browse files
  RootEXE(15) = ProgramDir & "\Internet Explorer\iexplore.exe" 'internet expl
  RootEXE(16) = ProgramDir & "\RadLight\RadLight3\RadLight.exe"
'********************** end custom config **********************

  Redim RootID(16,2)
  RootID(0,0) = 0		                             'id
  RootID(0,1) = "Win TV"	                       'name in menu
  RootID(0,2) = "enterWinTV"                     'method to enter menu

  RootID(1,0) = 1
  RootID(1,1) = "MoreTV"
  RootID(1,2) = "enterMoreTV"

  RootID(2,0) = 2
  RootID(2,1) = "Winamp"
  RootID(2,2) = "enterWinamp"

  RootID(3,0) = 3
  RootID(3,1) = "PowerDVD 6.0"
  RootID(3,2) = "enterPowerDVD"

  RootID(4,0) = 4
  RootID(4,1) = "BSPlayer"
  RootID(4,2) = "enterBSPlayer"

  RootID(5,0) = 5
  RootID(5,1) = "Media Player"
  RootID(5,2) = "enterMediaPlayer"

  RootID(6,0) = 6
  RootID(6,1) = "Volume Control"
  RootID(6,2) = "enterVolumeControl"

  RootID(7,0) = 7
  RootID(7,1) = "PowerPoint"
  RootID(7,2) = "enterPowerPoint"

  RootID(8,0) = 8
  RootID(8,1) = "Misc Control"
  RootID(8,2) = "enterMiscControl"

  RootID(9,0) = 9
  RootID(9,1) = "Mouse Control"
  RootID(9,2) = "enterMouseControl"

  RootID(10,0) = 10
  RootID(10,1) = "WinDVD"
  RootID(10,2) = "enterWinDVD"

  RootID(11,0) = 11
  RootID(11,1) = "iTunes"
  RootID(11,2) = "enterITunes"

  RootID(12,0) = 12
  RootID(12,1) = "DScaler"
  RootID(12,2) = "enterDScaler"

  RootID(13,0) = 13
  RootID(13,1) = "Zoom Player"
  RootID(13,2) = "enterZoomPlayer"

  RootID(14,0) = 14
  RootID(14,1) = "Browse Files"
  RootID(14,2) = "enterBrowse"

  RootID(15,0) = 15
  RootID(15,1) = "Browse WWW"
  RootID(15,2) = "enterExplorer"

  RootID(16,0) = 16
  RootID(16,1) = "RadLight"
  RootID(16,2) = "enterRadLight"
End Sub


Sub setGotoMethod(m)
  GotoMethodValue = m
End Sub

Sub gotoMethod()		'called after exiting volume
  CurrentItem = ""	'##################
  Select Case CurrentID
    Case "onAMRoot"  onAMRoot
    Case "settings"
      Select Case GotoMethodValue
        Case "enterSettings"  enterSettings
        Case "gotoSelect"     gotoSelect
        Case "gotoOrder"      gotoOrder
      End Select

    Case 0
      If (GotoMethodValue = "channelList") Then
        channelList
      Else
        enterWinTV
      End If

    Case 1
      If (GotoMethodValue = "channelList") Then
        channelList
      Else
        enterMoreTV
      End If

    Case 2
      Select Case GotoMethodValue
        Case "enterWinamp"    enterWinamp
        Case "winampSearch"   winampSearch
        Case "simpleSearch"   simpleSearch
        Case "allArtists"     allArtists
        Case "artistResults"  artistResults
        Case "playList"       playList LastArg1
        Case "songInfo"       songInfo LastArg1
        Case "songInfo2"      songInfo2
        Case "enterSeek"      enterSeek
        Case "winampOptions"  winampOptions
        Case "browsePlaylist" browsePlaylist
      End Select

    Case 3  enterPowerDVD
    Case 4  enterBSPlayer
    Case 5  enterMediaPlayer
    Case 6  enterVolumeControl
    Case 7  enterPowerPoint
    Case 8  enterMiscControl
    Case 10 enterWinDVD
    Case 11 enterITunes

    Case 12
      If (GotoMethodValue = "channelList") Then
        channelList
      Else
        enterDScaler
      End If

    Case 13 enterZoomPlayer
    Case 14 enterBrowse
    Case 15 enterExplorer
    Case 16 enterRadLight
  End Select
End Sub


Sub setMenuItems(a1,a2)			'setting menu items according index values of array a1
  Dim e					'element is index (integer)
  For Each e in a1
    am.AddItem a2(e,1), a2(e,2)		'name in menu and function for entering Menu
  Next
End Sub

Sub setPhone()
  If (MyPhoneType(1)=1) Then		'T610
    ScreenWidth		= 111			'usable screenwidth
    SpaceOption		= 3
    MenuItemExitMenu	= "      [ exit menu ]"

    BackButton = ":R"
    CameraButton = ":C"
    OptionButton = "]"
    OkButton = "["
  ElseIf (MyPhoneType(1)=2) Then	'K700i
    ScreenWidth		= 111			'usable screenwidth
    SpaceOption		= 3
    MenuItemExitMenu	= "   < [ exit menu ] >"

    BackButton = ":R"
    CameraButton = ":C"
    OptionButton = "]"
    OkButton = "["
  ElseIf (MyPhoneType(1)=3) Then	'T68i
    ScreenWidth		= 84			'usable screenwidth
    SpaceOption		= 2
    MenuItemExitMenu	= "   <<< ( exit ) >>>"

    BackButton = "c"
    CameraButton = "Not available"
    OptionButton = "f"
    OkButton = "s"
  End If
End Sub

'***********************************************************
Public ScreenWidth		'phone dependable screen width
Public SpaceOption

Public WinampDir
Public NrSongsOnPage			'smaller or equal to 10

Public BackButton
Public CameraButton
Public OptionButton		'option button on phone
Public OkButton

Public MenuItemExitMenu		'interface text

Public SelectItem		'needed for sorting menu

Public GotoMethodValue		'is used to save position upon entering option or volume

Public LastArg1

Public TempArray		'needed for temporary passing of values "sorted array" and used in search
Public TempArray2

Public GetPlayListBool

Public EnableKeys     'peform keyevents

Public Fso, File		'file read and write variables
Public SettingsFile

Public MyPhoneType(1) 		'Phone selection: 1 = T610; 2 = K700i; 3 = t68i;
MyPhoneType(0) = 3          'Number of phones - used in phone switching sub
Public ScriptVersion

Public SaveSettingsBool
Public SettingMuteOnCall
Public OnCallDecreaseValue
Public SettingStartOnConnect

Public VolumeBackup

Public VolumeCtrl		'objects
Public WinampCtrl
Public WinampVol
Public MouseCtrl
Public WMPplugin
Public WMPCtrl
Public WMPplginI
Public Shell

Public AppOpen

Public BSPlayerZoomValue

Public RootItems		'Array of application ID's 	note: RootItems(0) is empty and not used for implementing reasons

Public CurrentID		'running menu
Public CurrentItem		'running menutitem

Public EnableMouseControl
Public PlaylistPath

' "T610 as a webcam". Copyright (c) 2004 HRS.

' this script remotely triggers the camera of the T610,
' transfers the taken picture on the local pc and
' deletes it from the camera.

' path and FileName of the picture on the camera
' output directory for the transferred files on the local pc
' terminating backslash required


Sub OnInit()
  'Reapply settings (usualy after editing the script inside FMA)
  OnDisconnected
  OnConnected

  'Add main menu options
  fma.AddCmd "How to build your own scripts?", "OnFMAScriptHowto"
  fma.AddCmd "-", ""
  fma.AddCmd "Take a picture", "OnTakeSinglePicture"
  fma.AddCmd "-", ""
  fma.AddCmd "Start Webcam (loop)", "OnStartWebcam"
  fma.AddCmd "Start Webcam (stream)", "OnStartWebcamStream"
  fma.AddCmd "-", ""
  fma.AddCmd "Stop Webcam", "OnStopWebcam"
  fma.AddCmd "-", ""
  fma.AddCmd "Locate the phone", "OnLocatePhone"
End Sub

Sub OnConnected()
  initRootID			'setting default menu-items

  'OnConnected is called in offline mode from OnInit
  'so we should take care of this
  If fma.Connected = 1 Then
     am.Init 							'Initialize the Accessories Menu
     am.DlgMsgBox "Connected to floAt's Mobile Agent", 2
  Else
     am.Clear
  End If

  Set Shell = CreateObject("WScript.Shell")
  Set VolumeCtrl = CreateObject("floAtMediaCtrl.VolumeCtrl")
  Set Fso = CreateObject("Scripting.FileSystemObject")		'FileSystemObject created for reading and writing files
  Set WinampCtrl = CreateObject("WinampCOMLib.WinampCOMObj")
  Set MouseCtrl = CreateObject("floAtMediaCtrl.MouseCtrl")
On Error Resume Next
  Set WMPplugin = CreateObject("WMPuICE.WMPApp")
  WMPplginI = null
  WMPplginI = WMPplugin.Running
On Error GoTo 0
  If (IsNull(WMPplginI)) Then WMPplginI=FALSE Else WMPplginI=TRUE

  EnableMouseControl = 0

  VolumeCtrl.GradualVol = True

  ReDim RootItems(0)
  ReDim PlayListArray(0)
  ReDim TempArray(0)
  ReDim TempArray2(0)
  CurrentID = ""        'Refers to Application
  CurrentItem = ""      'Refers to Item within application menu
  UseSearchPlayList = FALSE

  setDefault			'set default user settings
  readSettings			'read stored user settings (if config file is available)

  GetPlayListBool = TRUE

  BSPlayerZoomValue = 1

  WinampCtrl.PathExe = WinampDir

  WinampVol = 128
  WinampCtrl.SetVolume = WinampVol
  VolumeBackup = VolumeCtrl.Volume

  WinampCtrl.GetPlaylistMode = 1

  If fma.Connected = 1 Then
    Transmit "AT*EAST=" & Chr(34) & "Fma Remote" & Chr(34)
    fma.enablekeymonitor
    If (SettingStartOnConnect) Then onAMRoot
  End If

End Sub

Sub OnDisconnected()
  deleteTimers               'delete timers used in winamp and wmp
  ReDim RootItems(0)
  ReDim PlayListArray(0)
  ReDim TempArray(0)
  ReDim TempArray2(0)
  CurrentID = ""
  CurrentItem = ""

  Set Shell = Nothing
  Set Fso = Nothing
  Set VolumeCtrl = Nothing
  Set WinampCtrl = Nothing
  Set MouseCtrl = Nothing
  Set WMPplugin = Nothing
  Set WMPCtrl = Nothing
End Sub

Sub OnConnectionLost()
  'OnDisconnected
End Sub

Sub OnNewSMS(from,msg)
End Sub

Sub OnProximity(state) '1: away, 0: near
End Sub

Sub OnCall(state,n1,n2)	'state "alerting"  | "calling" | "connecting" | "active"
End Sub

Sub OnMusicMute(state)
  If (state = 1) Then	'incoming call -> mute
    EnableKeys = FALSE
    VolumeBackup = VolumeCtrl.Volume
    Select Case SettingMuteOnCall
      Case 0
      Case 1
         VolumeCtrl.Volume = 0   'decrease volume
         VolumeCtrl.Mute = 1     'mute volume
      Case 2
        VolumeCtrl.Volume = (VolumeBackup-OnCallDecreaseValue)
      Case 3
        WinampCtrl.Pause  'pause Winamp
    End Select
  Else				'call ended (state = 0) -> unmute
    EnableKeys = FALSE
    Select Case SettingMuteOnCall
      Case 0
      Case 1
        VolumeCtrl.Mute = 0              'unmute
        VolumeCtrl.Volume = VolumeBackup 'restore old volume value
      Case 2
        VolumeCtrl.Volume = VolumeBackup 'restore old volume value
      Case 3
        WinampCtrl.Play
    End Select
  End If
End Sub


'Active Menu Start ---------------------------------------------------------
'onAMRoot will be called when Connection/Extra->Accessories->FMA is selected
'Something that's not shown here is am.Back = "Event", will call procedure
'specified rather than go back to the previous menu

Sub onAMRoot()
  am.Clear
'id=13
  EnableKeys = TRUE

  CurrentID = "onAMRoot"
  CurrentItem = "menu"

  If (MyPhoneType(1)=1) Then
   am.Title = "T610 control"
  ElseIf (MyPhoneType(1)=2) Then
   am.Title = "K700i control"
  ElseIf (MyPhoneType(1)=3) Then
   am.Title = "T68i control"
  End If

  setMenuItems RootItems, RootID	'set root

  am.AddItem center("[ settings ]",""), "enterSettings"
  am.AddItem center("[ about ]",""), "about"

  am.back = "exitRoot"
  am.Update
End Sub

Sub exitRoot
  EnableKeys = FALSE
  CurrentID = ""
End Sub

Sub CloseAppDlg
  am.clear
  am.Title = "Closing"
  am.AddItem "Cancel", "onAMRoot"

  am.DlgFeedBack "Closing...","onAMRoot"
  am.update
End Sub
Sub LaunchAppDlg
  am.clear
  am.Title = "Launching"
  am.AddItem "Cancel", "onAMRoot"

  am.DlgFeedBack "Launching...","onAMRoot"
  am.update
End Sub

Public ItemPressMethod

Sub setItemPress(m)		'redirect to function
  ItemPressMethod = m
End Sub

Sub itemPress(i)		'check goto method
  Select Case ItemPressMethod
    Case "clickOnSong"      clickOnSong i
    Case "toggleOption"     toggleOption i
    Case "clickOnFile"      clickOnFile i
    Case "moveItemUp"       moveItemUp i
    Case "songsByArtist"    songsByArtist i
    Case "sendKey"          sendKey i
    Case "mp9PsClick"       mp9PsClick i
    Case "mp9PClick"        mp9PClick i
  End Select
End Sub


Sub itemPress0()		'e.g. clicked on song-event
  itemPress 0	      'click on top item of list
End Sub
Sub itemPress1()		'e.g. clicked on song-event
  itemPress 1		    'click on 2nd item of list
End Sub
Sub itemPress2()
  itemPress 2
End Sub
Sub itemPress3()
  itemPress 3
End Sub
Sub itemPress4()
  itemPress 4
End Sub
Sub itemPress5()
  itemPress 5
End Sub
Sub itemPress6()
  itemPress 6
End Sub
Sub itemPress7()
  itemPress 7
End Sub
Sub itemPress8()
  itemPress 8
End Sub
Sub itemPress9()
  itemPress 9
End Sub
Sub itemPress10()
  itemPress 10
End Sub
Sub itemPress11()
  itemPress 11
End Sub
Sub itemPress12()
  itemPress 12
End Sub
Sub itemPress13()
  itemPress 13
End Sub
Sub itemPress14()
  itemPress 14
End Sub
Sub itemPress15()
  itemPress 15
End Sub
Sub itemPress16()
  itemPress 16
End Sub
Sub itemPress17()
  itemPress 17
End Sub
Sub itemPress18()
  itemPress 18
End Sub

'------------------------ array functions-------------------------

Function elementOf(c,arr)	'determines whether 'c' is element of Array arr
  Dim e

  For Each e In arr
    If (c = e) Then
      elementOf = TRUE
      Exit Function
    End If
  Next

  elementOf = FALSE
End Function

Sub removeElement(id,a)		'remove method with element search
  Dim i
  For i=0 To UBound(a)
    If (a(i) = id) Then
    	removeElementAt i, a
    	Exit For
    End If
  Next
End Sub

Sub removeElementAt(index,a)	'remove method with index argument
  Dim i, limit
  limit = UBound(a)
  For i=index To limit-1
    a(i) = a(i+1)
  Next
  ReDim Preserve a(limit-1)
End Sub

Sub addElement(id,a)		'add method at end of array
  Dim i, limit

  If (a(0) = "") Then		'fill complete array
    a(0) = id
  Else
    limit = UBound(a)
    ReDim Preserve a(limit+1)
    a(limit+1) = id
  End If
End Sub


'------------------ filters a string----------------------
'needed for filtering unicode char which causes lockups

Function filter(str)				'filters a String
  Dim i, s
  s = Trim(Str)
  'For i=128 To 149
  '  s = replace(s,Chr(i),"")
  'Next
  s = replace(s,"`","'")
  s = replace(s,Chr(128),"Euro")  'safe
  s = replace(s,Chr(129),"")
  s = replace(s,Chr(130),",")  'safe
  s = replace(s,Chr(131),"f")  'safe
  s = replace(s,Chr(132),",,")  'safe
  s = replace(s,Chr(133),"...")
  s = replace(s,Chr(134),"+")
  s = replace(s,Chr(135),"++")
  s = replace(s,Chr(136),"^")
  s = replace(s,Chr(137),"%")
  s = replace(s,Chr(138),"S")
  s = replace(s,Chr(139),"<")
  s = replace(s,Chr(140),"CE")
  s = replace(s,Chr(141),"")
  s = replace(s,Chr(142),"Z")
  s = replace(s,Chr(143),"")
  s = replace(s,Chr(144),"")
  s = replace(s,Chr(145),"'")
  s = replace(s,Chr(146),"'")
  s = replace(s,Chr(147),"''")
  s = replace(s,Chr(148),"''")
  s = replace(s,Chr(149),".")
  s = replace(s,Chr(150),"-")
  s = replace(s,Chr(151),"--")
  s = replace(s,Chr(152),"~") 'safe
  s = replace(s,Chr(153),"tm")
  s = replace(s,Chr(154),"s")
  s = replace(s,Chr(155),">")
  s = replace(s,Chr(156),"oe")
  s = replace(s,Chr(157),"")
  s = replace(s,Chr(158),"z")
  s = replace(s,Chr(159),"y")
  s = replace(s,Chr(160)," ")
  s = replace(s,Chr(161),"i")
  s = replace(s,Chr(162),"c")
  s = replace(s,Chr(163),"Pound")
  s = replace(s,Chr(164),"x")
  s = replace(s,Chr(165),"y")
  s = replace(s,Chr(166),"|")
  s = replace(s,Chr(167),"s")
  s = replace(s,Chr(168),"''")
  s = replace(s,Chr(169),"C")
  s = replace(s,Chr(170),"a")
  s = replace(s,Chr(171),"<<")
  s = replace(s,Chr(172),"")
  s = replace(s,Chr(173),"")
  s = replace(s,Chr(174),"R")
  s = replace(s,Chr(175),"")
  s = replace(s,Chr(176),"o")
  s = replace(s,Chr(177),"+-")
  s = replace(s,Chr(178),"2")
  s = replace(s,Chr(179),"3")

  s = replace(s,Chr(180),"'")
  s = replace(s,Chr(181),"u")
  s = replace(s,Chr(182),"")
  s = replace(s,Chr(183),".")
  s = replace(s,Chr(184),",")

  s = replace(s,Chr(185),"1")
  s = replace(s,Chr(186),"o")
  s = replace(s,Chr(187),">>")
  s = replace(s,Chr(188),"1/4")
  s = replace(s,Chr(189),"1/2")
  s = replace(s,Chr(190),"3/4")
  s = replace(s,Chr(191),"?")

  s = replace(s,Chr(192),"A")
  s = replace(s,Chr(193),"A")
  s = replace(s,Chr(194),"A")
  s = replace(s,Chr(195),"A")
  s = replace(s,Chr(196),"A")
  s = replace(s,Chr(197),"A")
  s = replace(s,Chr(198),"AE")
  s = replace(s,Chr(199),"C")
  s = replace(s,Chr(200),"E")
  s = replace(s,Chr(201),"E")
  s = replace(s,Chr(202),"E")
  s = replace(s,Chr(203),"E")


  s = replace(s,Chr(204),"I")
  s = replace(s,Chr(205),"I")
  s = replace(s,Chr(206),"I")
  s = replace(s,Chr(207),"I")

  s = replace(s,Chr(208),"D")
  s = replace(s,Chr(209),"N")

  s = replace(s,Chr(210),"O")
  s = replace(s,Chr(211),"O")
  s = replace(s,Chr(212),"O")
  s = replace(s,Chr(213),"O")
  s = replace(s,Chr(214),"O")
  s = replace(s,Chr(215),"x")
  s = replace(s,Chr(216),"O")

  s = replace(s,Chr(217),"U")
  s = replace(s,Chr(218),"U")
  s = replace(s,Chr(219),"U")
  s = replace(s,Chr(220),"U")
  s = replace(s,Chr(221),"Y")

  s = replace(s,Chr(222),"")

  s = replace(s,Chr(223),"ss") '?

  s = replace(s,Chr(224),"a")
  s = replace(s,Chr(225),"a")
  s = replace(s,Chr(226),"a")
  s = replace(s,Chr(227),"a")
  s = replace(s,Chr(228),"a")
  s = replace(s,Chr(229),"a")

  s = replace(s,Chr(230),"ae")
  s = replace(s,Chr(231),"c")

  s = replace(s,Chr(232),"e")
  s = replace(s,Chr(233),"e")
  s = replace(s,Chr(234),"e")
  s = replace(s,Chr(235),"e")

  s = replace(s,Chr(236),"i")
  s = replace(s,Chr(237),"i")
  s = replace(s,Chr(238),"i")
  s = replace(s,Chr(239),"i")
  s = replace(s,Chr(240),"a") '?

  s = replace(s,Chr(241),"n")

  s = replace(s,Chr(242),"o")
  s = replace(s,Chr(243),"o")
  s = replace(s,Chr(244),"o")
  s = replace(s,Chr(245),"o")
  s = replace(s,Chr(246),"o")
  s = replace(s,Chr(247),"")	'?
  s = replace(s,Chr(248),"o")

  s = replace(s,Chr(249),"u")
  s = replace(s,Chr(250),"u")
  s = replace(s,Chr(251),"u")
  s = replace(s,Chr(252),"u")

  s = replace(s,Chr(253),"y")
  s = replace(s,Chr(254),"") '?

  filter = replace(s,Chr(34),"''")		'reading songs with " char causes lockup
End Function

'------------------ String Pixels calculation -------------

Function strPix(str,max)			'return #pixels needed to display string and
  Dim i, pixsize

  If (Max = -1) Then				'no maximum break
    For i=1 to Len(str)
      pixsize = pixsize + pixelsOf(Mid(str,i,1))
    Next

  Else						'with maximum break max <> -1
    For i=1 to Len(str)
      pixsize = pixsize + pixelsOf(Mid(str,i,1))

      If (pixsize > max) Then			'return -1 if max value is passed (overflow)
        strPix = -1
        Exit Function
      End If
    Next
  End If

  strPix = pixsize				'return #pixels needed
End Function


Function pixelsOf(c)	'return #pixels needed to display a character
  If (MyPhoneType(1)<3) Then
    If (InStr(" il.,!'I|:;_",c)) Then
      pixelsOf = 3
      Exit Function
    ElseIf (InStr("j()[]",c)) Then
      pixelsOf = 4
      Exit Function
    ElseIf (InStr("frt{}-",c)) Then
      pixelsOf = 5
      Exit Function
    ElseIf (InStr("cszZ/1<>=",c)) Then
      pixelsOf = 6
      Exit Function
    'ElseIf (InStr("abdeghknopquxyABCDEFGHJKLOPRSTUY?^$+023456789",c)) then
      'pixelsOf = 7
      'Exit Function
    ElseIf (InStr("vNQVX&0",c)) Then
      pixelsOf = 8
      Exit Function
    ElseIf (InStr("@%",c)) Then
      pixelsOf = 9
      Exit Function
    ElseIf (c="M") Then
      pixelsOf = 10
      Exit Function
    ElseIf (InStr("mwW",c)) Then
      pixelsOf = 11
      Exit Function
    Else
      pixelsOf = 7	'unicode cases
    End If
  Else
    If (InStr("iIl!.'|",c)) Then
      pixelsOf = 2
      Exit Function
    ElseIf (InStr(" fjt():,[];",c)) Then
      pixelsOf = 3
      Exit Function
    ElseIf (InStr("r-/{}",c)) Then
      pixelsOf = 4
      Exit Function
    ElseIf (InStr("cksxzJ_",c)) Then
      pixelsOf = 5
      Exit Function
    'ElseIf (InStr("aàáâãäåeèéêëoòóôõöuùúûüybdghnpqvEBFLSTZ*0123456789?&^+=<>",c)) Then
      'pixelsOf = 6
      'Exit Function
    ElseIf (InStr("OUCDGHKNPRQ~",c)) Then
      pixelsOf = 7
      Exit Function
    ElseIf(InStr("mwAMYVXM%",c)) Then
      pixelsOf = 8
      Exit Function
    ElseIf (InStr("@#",c)) Then
      pixelsOf = 9
      Exit Function
    ElseIf (c="W") Then
      pixelsOf = 10
      Exit Function
    Else
      pixelsOf = 6	'unicode cases
    End If
  End If
End Function

'------------------ String Pixels calculation -------------

Function ShowPixsOfStr(s,x)			'trims down a string to max (x) pixels
  Dim i, pixsize, w
  'Width = ScreenWidth-13		'width available pixels T610:112 t68i = 94
  w = ScreenWidth-x			'width available pixels T610:112 t68i = 94

  For i=1 to Len(s)					'for part to determine last char that fits onto screen
    pixsize = pixsize + pixelsOf(Mid(s,i,1))

    If (pixsize > w) Then
      ShowPixsOfStr = Left(s,i-1)
      Exit Function
    End If
  Next
  ShowPixsOfStr = s
End Function

'------------------ center functions ----------------------

Function center(Str,char)		'center str with char sign on left and right side
  Dim i, r, s, pixs, p
  pixs = strPix(str,ScreenWidth)	'count pixs of string with maximum of screenwidth
  i = 0
  If (pixs = -1) Then		'if #str is larger dan screenwidth  (overflow)
    center = str
    Exit Function

  Else
    r = ScreenWidth - pixs	'remaining pixels

    If (char = "") Then
      s = (ScreenWidth - pixs)\6		'determine number of spaces at left side (remaining pixels div. by 2*3 space pixels)
      center = Space(s) & Str
      Exit Function
    Else
      p = 2*pixelsOf(char)

      i = r\p
      s = (r - i*p)\6
    End If
  End If
  center = Space(s) & String(i,char) & str & String(i,char)
End Function


'------------------ about --------------------------
Sub about()
  CurrentID = "about"

  Dim title, text, text1, text2, text3, text4
  title = "about"

  If (MyPhoneType(1)<3) Then
    text1 = "CarpeDi3m1687 v" & ScriptVersion
    text2 = "        by CarpeDi3m      "
    text3 = Space(38)
  Else
    text1 = "CarpeDi3m1687 " & ScriptVersion
    text2 = "      by CarpeDi3m      "
    text3 = Space(34)
  End If
  text4 = "Contributors: daveo, skyw33, HRS, Vit Ondruch, mhr, nossenigma, hazart, eMBee"
' all should be mentioned, no?

  text = text1 & text2 & text3 & text4

  am.NextState = 2
  am.DlgInformation title, text
  am.back = "onAMRoot"
End Sub


'----------------- end about ----------------------

'------------------ browse and playlist -------------------
Public IsRoot

Public BrowsePath
Public BrowseFilesArray
Public FilesOnPage
Public BrowsePage

Public BeginShow
Public EndShow

Public BeginDrives
BeginDrives = 3
Public EndDrives

Public BeginFolders
Public EndFolders

Public BeginFiles
Public EndFiles

Public BrowseType

FilesOnPage = 6

Sub enterBrowse
  setGotoMethod("enterBrowse")
  enterAppMenu(14)
  CurrentItem = "browse"

  BrowseType = "FoldersFiles"
  BrowsePath = "C:\"
  BrowsePage = 0

  browse
End Sub

Sub browse
  Dim oFolder, oSubFolder, oSubFolders,oFiles, oFile, oDrives, oDrive, oParentFolder, i, FileTempString
  Set oDrives = Fso.Drives

  Set oFolder = Fso.GetFolder(BrowsePath)
  Set oSubFolders = oFolder.SubFolders
  Set oFiles = oFolder.files
  Set oParentFolder = oFolder.ParentFolder

  ReDim BrowseFilesArray(oDrives.Count+oSubFolders.Count+oFiles.Count+3,2)	'+3 for current drive, parrent folder, current folder name
'setting up array

  BrowseFilesArray(0,0) = "<" & Fso.GetDriveName(oFolder.Path) & ">"	'current drive
  BrowseFilesArray(0,1) = Fso.GetDriveName(oFolder.Path)		'current drive

  If (oFolder.IsRootFolder) Then				'parent folder
  	IsRoot = TRUE
    BrowseFilesArray(1,0) = Fso.GetDriveName(oFolder.Path)	'current drive
    BrowseFilesArray(1,1) = Fso.GetDriveName(oFolder.Path)
    BrowseFilesArray(2,0) = Fso.GetDriveName(oFolder.Path)
  Else
    IsRoot = FALSE
    BrowseFilesArray(1,0) = oParentFolder.Name
    BrowseFilesArray(1,1) = oParentFolder.Path
    BrowseFilesArray(2,0) = Left(oFolder.Name,15)	'current folder name
  End If
  BrowseFilesArray(2,1) = oFolder.Path		'current folder path

  Dim TempVolumeName
  i=3						'drive letters
  For Each oDrive in oDrives
    Select Case oDrive.DriveType
      Case 1
        TempVolumeName = "- Removable"
      Case 2
        TempVolumeName = " <" & filter(oDrive.VolumeName) & ">"
      Case 4
        TempVolumeName = "- CDROM"
    End Select

    BrowseFilesArray(i,0) = filter(oDrive.DriveLetter) & ": " & TempVolumeName  'name
    BrowseFilesArray(i,1) = oDrive.DriveLetter & ":\"			'logical notation
    i=i+1
  Next
  EndDrives = i-1

  BeginFolders = i
  For Each oSubFolder in oSubFolders
    BrowseFilesArray(i,0) = "[" & filter(oSubFolder.name) & "]"
    BrowseFilesArray(i,1) = oSubFolder.path
    i=i+1
  Next
  EndFolders = i-1

  BeginFiles = i


  For Each oFile in oFiles
    FileTempString = filter(oFile.name)

    If (CurrentItem = "selectPlaylist") Then

      If ((InStr(LCase(FileTempString),".m3u")) Or (InStr(LCase(FileTempString),".pls")))  Then	'show only files with extensions that are linked
        BrowseFilesArray(i,0) = FileTempString
        BrowseFilesArray(i,1) = oFile.path
        i=i+1
      End If
    Else
      BrowseFilesArray(i,0) = FileTempString
      BrowseFilesArray(i,1) = oFile.path
      i=i+1
    End If
  Next

  EndFiles = i-1

  If ((BeginFolders>EndFolders) And (BeginFiles>EndFiles)) Then
    If (CurrentItem = "selectPlaylist") Then
      BrowseFilesArray(i,0) = "Empty"
    Else
      BrowseFilesArray(i,0) = ".."
    End If
    BrowseFilesArray(i,1) = "empty"
    EndFiles = BeginFiles
  End If

  Select Case CurrentItem
    Case "selectPlaylist"  browsePlaylistShow
    Case Else  browseFoldersFiles
  End Select
End Sub

Sub RunFile(f)
  Shell.Run "RunDLL32.EXE shell32.dll,ShellExec_RunDLL """ & f & """"
  browseShow
End Sub

Sub OpenPlaylist(f)
  shell.Exec RootEXE(2) & " " & Chr(34) & f & Chr(34) 'winamp
  GetPlaylistBool = TRUE
  GetPlaylist
  enterWinamp
End Sub

Sub browseShow
  am.Clear
  If (BrowseType="Drives") Then
  	am.Title = Left("Drives [" & CStr(BrowsePage+1) & "/" & CStr( ((EndShow-BeginShow)\FilesOnPage) +1) & "]", 15)
    am.Back = "onAMRoot"
  ElseIf (CurrentItem = "selectPlaylist") Then
    am.Title = Left("Playlists [" & CStr(BrowsePage+1) & "/" & CStr( ((EndShow-BeginShow)\FilesOnPage) +1) & "]",15)
    am.Back = "enterWinamp"
  Else
   'am.Title = BrowseType & " [" & CStr(BrowsePage+1) & "/" & CStr( ((EndShow-BeginShow)\FilesOnPage) +1) & "]"
    am.Title = Left(BrowseFilesArray(2,0),15)
    am.Back = "onAMRoot"
  End If

  setItemPress("clickOnFile")

  Dim i,j
  Dim TempStr
  For i=0 to FilesOnPage-1
    j = BrowsePage*FilesOnPage + BeginShow + i
    If (j <= EndShow) Then
      If (CurrentItem = "selectPlaylist") Then
        TempStr = BrowseFilesArray(j,0)
      	If (BrowseFilesArray(j,1)="empty") Then
          am.AddItem TempStr, "itemPress" & i
        Else
        am.AddItem Left(TempStr,Len(TempStr)-4), "itemPress" & i
        End If
      Else
        am.AddItem BrowseFilesArray(j,0), "itemPress" & i
      End If
    Else
      Exit For
    End If
  Next

  am.NextState = 2
  am.Update
End Sub

Sub browseOption
   Dim TempFiles, TempPage
  CurrentItem = "browseOption"

   TempPage = CStr(BrowsePage+1) & "/" & CStr( ((EndShow-BeginShow)\FilesOnPage) +1)
   If (BrowseType="Drives") Then
     am.DlgInformation "Browse Info", "Page: " & TempPage & "     Drives: " & CStr(EndDrives - BeginDrives +1)
   Else
     If(BrowseFilesArray(BeginFiles,1)="empty") Then
       TempFiles = "0"
     Else
       TempFiles = CStr(EndFiles - BeginFiles +1)
     End If
     am.DlgInformation "view", "Page: " & TempPage & Space(10) & "Folders: " & CStr(EndFolders - BeginFolders +1) & "   Files: " & TempFiles & "    " & Replace(BrowsePath, "\", "\\") & Space(10)
   End If

  am.NextState = 2
  am.Back = "exitBrowseOption"
End Sub

Sub exitBrowseOption
  CurrentItem = "browse"
  browseShow
End Sub

Sub browsePlaylistShow
  BeginShow = BeginFiles
  EndShow = EndFiles
  browseShow
End Sub

Sub browsePlaylist
  setGotoMethod("browsePlaylist")

  CurrentItem = "selectPlaylist"
  deleteTimers
  BrowsePage = 0
  BrowsePath = PlaylistPath
  browse
End Sub

Sub browseDrives
  BrowsePage = 0
  BrowseType = "Drives"
  BeginShow = BeginDrives
  EndShow = EndDrives
  browseShow
End Sub
Sub browseFoldersFiles
  BrowsePage = 0
  BrowseType = "FoldersFiles"
  BeginShow = BeginFolders
  EndShow = EndFiles
  browseShow
End Sub
Sub browseFolders
  BrowsePage = 0
  BrowseType = "Folders"
  BeginShow = BeginFolders
  EndShow = EndFolders
  browseShow
End Sub
Sub browseFiles
  BrowsePage = 0
  BrowseType = "Files"
  BeginShow = BeginFiles
  EndShow = EndFiles
  browseShow
End Sub

Sub clickOnFile(i)
  Dim i2, p
  i2 = BrowsePage*FilesOnPage + BeginShow + i
  p = BrowseFilesArray(i2,1)
  If ((i2 >= BeginFiles) And (i2 <= EndFiles)) Then
    If (p="empty") Then
      If (CurrentItem = "selectPlaylist") Then
      	enterWinamp
    	Else
        browseUp
    	End If
    Else
    am.DlgFeedBack "Opening.. ", "browseShow"
    am.update
    If (CurrentItem = "selectPlaylist") Then
      OpenPlaylist(p)
    Else
      RunFile(p)
    End If
    End If
  Else
    BrowsePath = p
    am.Clear
    browse
  End If
End Sub

Sub BrowseUp
  BrowsePage = 0
  BrowsePath = BrowseFilesArray(1,1)
  browse
End Sub

Sub nextBrowse
  Dim i
  i = (EndShow-BeginShow)\FilesOnPage
  If (i>0) Then
    If (BrowsePage = i) Then
      BrowsePage = 0
    Else
      BrowsePage = BrowsePage+1
    End If
    browseShow
  End If
End Sub

Sub prevBrowse
  Dim i
  i = (EndShow-BeginShow)\FilesOnPage
  If (i>0) Then
    If (BrowsePage = 0) Then
      BrowsePage = i
    Else
      BrowsePage = BrowsePage-1
    End If
    browseShow
  End If
End Sub

'------------------ end browse and playlist --------------

'-------------------Winamp Control (made by CarpeDi3m1687 version 2.0a)---------

Public Pos		'passing of track position

'------------------ Winamp main menu ----------------------
'id=2

Sub enterWinamp()
  setGotoMethod("enterWinamp")

  If (Not WinampCtrl.WinampState) Then
    LaunchAppDlg
    WinampCtrl.WinampState = TRUE
  End If

  UseSearchPlayList = FALSE
  SimpleSearchOn = FALSE

  am.Clear

  getPlayList

  winamp
End Sub

Public SavePlayListLength
Public SavePlayListPos
Public SaveSongState
Public SaveWinampState

Sub winampUpdate
  If (SavePlayListLength <> WinampCtrl.GetPlayListLength) Then
    reloadPlaylist
  ElseIf (SavePlayListPos<>WinampCtrl.GetPlayListPosition) or (SaveSongState<>WinampCtrl.GetSongState) Then
    winamp
  End If
End Sub
Sub winamp()
  deleteTimers
  enterAppMenu(2)

  If WinampCtrl.WinampState Then
    SavePlayListPos = WinampCtrl.GetPlayListPosition
    fma.AddTimer 4000, "winampUpdate"
    If (WinampCtrl.GetPlayListLength > 0) Then		'not empty playlist
       SaveSongState = WinampCtrl.GetSongState

       Select Case SaveSongState
         Case "Playing"
           am.AddItem "> " & songTitle(SavePlayListPos-1,-ScreenWidth), "enterPlayList"
         Case "Stopped"
           am.AddItem "[ ] " & songTitle(SavePlayListPos-1,-ScreenWidth), "enterPlayList"
         Case "Paused"
           am.AddItem "| | " & songTitle(SavePlayListPos-1,-ScreenWidth), "enterPlayList"
       End Select

       am.AddItem "Search", "Winampsearch"
       am.AddItem "Seek", "enterSeek"

       Select Case SaveSongState			'play
         Case "Playing"
           am.AddItem "Restart", "winampPlay"
         Case "Stopped"
           am.AddItem "Play", "winampPlay"
         Case "Paused"
           am.AddItem "Stop", "winampStop"
       End Select

       Select Case SaveSongState		'pause
         Case "Playing"
           am.AddItem "Pause", "winampPause"
         Case "Stopped"
           am.AddItem "-", "winampPlay"
         Case "Paused"
           am.AddItem "Resume", "winampPause"
       End Select
     am.Title = Left(SaveSongState & " #" & SavePlayListPos,15)
     Else
       am.Title = "Empty playlist"
     End If

     am.AddItem "Playlists", "browsePlaylist"
     am.AddItem "Close Winamp", "winampClose"
  Else
    am.Title = "Winamp"
    am.AddItem "Launch Winamp", "winampLaunch"
  End If
  am.Back = "exitWinamp"
  am.NextState=2
  am.Update
End Sub
Sub exitWinamp
  deleteTimers
  onAMRoot
End Sub

Sub winampLaunch()
  CurrentItem = "LaunchWinamp"
  LaunchAppDlg
  WinampCtrl.WinampState = TRUE
  UseSearchPlaylist = FALSE
  winamp
End Sub

Sub winampClose()
  CurrentItem = "CloseWinamp"
  CloseAppDlg
  WinampCtrl.WinampState = FALSE
  winamp
End Sub

Sub winampPlay()
  WinampCtrl.Play
  winamp
End Sub
Sub winampPause()
  WinampCtrl.Pause
  winamp
End Sub
Sub winampStop()
  WinampCtrl.Stop
  winamp
End Sub
Sub winampPrevSong()
  If (UseSearchPlaylist) Then
    If(Pos=0) Then
      Pos=UBound(PlayListArray)
    Else
      Pos=Pos-1
    End If
    WinampCtrl.PlaySongByPosition(PlayListArray(Pos))
  Else
    WinampCtrl.PreviousTrack
  End If
  winamp
End Sub

Sub winampNextSong()
  If (UseSearchPlaylist) Then
    If(Pos<UBound(PlayListArray)) Then		'if not equal or greater then
      Pos=Pos+1
    Else
      Pos=0
    End If
    WinampCtrl.PlaySongByPosition(PlayListArray(Pos))
  Else
    WinampCtrl.NextTrack
  End If
  winamp
End Sub

Public UseSearchPlaylist

Sub getPlayList
  If (GetPlayListBool) Then
    am.Clear
    am.DlgFeedBack "Loading...","onAMRoot"
    am.title ="Loading..."
    am.AddItem "Cancel","onAmRoot"
    am.back = "enterWinamp"
    am.Update

    GetPlayListBool = FALSE

    WinampCtrl.GetPlayList
    SavePlayListLength = WinampCtrl.GetPlayListLength
  End If
End Sub

'------------------ playlist ------------------------------

Sub enterPlayList()
  If (WinampCtrl.GetPlayListLength > 0) Then		'Playlist is not empty
    If(Not UseSearchPlayList) Then			'Pos is set on search?????
      Pos = (WinampCtrl.GetPlayListPosition - 1)
    End If
    playList(Pos)
    SavePlayListPos = WinampCtrl.GetPlayListPosition
  Else
    am.Update
  End If
End Sub

Sub playlistUpdate
  If (SavePlayListLength <> WinampCtrl.GetPlayListLength) Then
    reloadPlaylist
  ElseIf (SavePlayListPos<>WinampCtrl.GetPlayListPosition) or (SaveSongState<>WinampCtrl.GetSongState) Then	'playing song or state song changed
    If ((Pos<CInt(SavePlayListPos)) and (CInt(SavePlayListPos)<=(Pos+NrSongsOnPage))) Then
        playlist(WinampCtrl.GetPlayListPosition-1)	'only if playing song is shown
    End If
  End If
End Sub

Sub playList(p)			'first track on list is p=0
  Dim i
  deleteTimers
  SavePlayListPos = WinampCtrl.GetPlayListPosition
  setGotoMethod("playList")
  CurrentItem = "playlist"
  LastArg1 = p

  am.Clear
  If (UseSearchPlayList) Then
    am.Title = Left("Search: " & CStr(p+1),15)
  Else
    am.Title = Left("Playlist: " & CStr(p+1),15)
    fma.AddTimer 4000, "playlistUpdate"
  End If

  Pos = p				'var needed to pass to: prevPlayList, nextPlayList, playSongs(1..9)

  setItemPress("clickOnSong")
  For i=0 to NrSongsOnPage-1
    If ( p+i < getTotalSongs) Then			'while there are still songs to be shown
      am.AddItem getSong(getIndex(p+i)), "itemPress" & i
    Else					'no songs to be shonwn
      Exit For
    End If
  Next

  am.Back = "exitPlayList"
  am.NextState=2
  am.Update
End Sub

Sub exitPlayList
  If (UseSearchPlaylist) Then
    SimpleSearchOn = SimpleSearchOnBackup
    Select Case SearchType
      Case "artist"
        artistResults
      Case "title"
        titleResults
      Case Else
        allArtists
    End Select
  Else
    enterWinamp
  End If
End Sub

Sub clickOnSong(index)
  Dim i, b, j
  i = Pos + index
  j = getIndex(i)

  If ((WinampCtrl.GetSongState = "Playing") And (WinampCtrl.GetPlayListPosition-1=j) ) Then			'clicked on a song that is being played then show song info
    SavePlaylistPos = WinampCtrl.GetPlayListPosition
    songInfo(j)
  Else						'if song is not being played
    WinampCtrl.PlaySongByPosition(j)		'index choose function
    playList(i)					'show playlist with song# i at top of list
  End If
End Sub

Sub songInfoUpdate
  If (SavePlayListPos = WinampCtrl.GetPlayListPosition) Then	'same song played
    am.Title = Left("( " & WinampCtrl.GetSongPosition & " )",15)
    am.update
  Else								'show new song info
    deleteTimers	'not needed
    songInfo(WinampCtrl.GetPlayListPosition-1)
  End If
End Sub

Public PlayListArray		'Dynamic array with TrackIndexes

Function getIndex(i)
  If (UseSearchPlaylist) Then
    getIndex = PlayListArray(i)
  Else
    getIndex = i
  End If
End Function

Function getTotalSongs()
  If (UseSearchPlaylist) Then
    getTotalSongs = UBound(PlayListArray)+1
  Else
    getTotalSongs = CInt(WinampCtrl.GetPlayListLength)
  End If
End Function


Sub prevPlayList()
  If (getTotalSongs>NrSongsOnPage) Then
    If (Pos>NrSongsOnPage-1) Then		'not first page
      Pos = Pos - NrSongsOnPage
    ElseIf (Pos=0) Then				'first page with first song of complete playlist
      Pos = getTotalSongs - NrSongsOnPage
    Else					'0 < Pos < NrSongsOnPage
      Pos = 0
    End If
  Else
    Pos = 0
  End If

  playList(Pos)				'Show new playlist with song# (Pos) as top of the list
End Sub

Sub nextPlayList()
  Pos = Pos+NrSongsOnPage

  If (Pos > getTotalSongs-1) Then		'last page
    Pos = 0
  End If

  playList(Pos)		'Show new playlist with song# (Pos) as top of the list
End Sub

Function getSong(p)				'return songtitle of song p
  Dim mark, i
  If (WinampCtrl.GetPlayListPosition-1 = p) Then	'if P is current song being played
    Select Case WinampCtrl.GetSongState
      Case "Playing"
        getSong = "> " & songTitle(p,6)
      Case "Paused"
        getSong = "| | " & songTitle(p,6)
      Case Else
        getSong = "[] " & songTitle(p,6)
    End Select

    Exit Function
  ElseIf (simpleSearchOn) Then
    mark = " "
    For i=0 to SearchResult-1
      If (WinampCtrl.GetSearchSong(i)=p) Then
        mark = "- "
        Exit For
      End If
    Next
  Else	'no simplesearch
    mark = " "
  End If
  getSong = mark & songTitle(p,2)

'  getSong = mark & songTitle(p,13)
End Function

Function songTitle(p,x)
  Dim s
  s = filter(WinampCtrl.GetSongTitlebyPosition(p))

  s = replace(s,"( ","(")
  s = replace(s," )",")")
  s = replace(s,"[ ","[")
  s = replace(s," ]","]")

  songTitle = showPixsOfStr(s,x)
End Function

'------------------ Playlist ------------------------------


'GetFileNamebyPosition[Position: Integer]: String read
'   returns the name of file in a determinated position in playlist

'StartOfPlayList
'FadeOutStop

'------------------ songInfo ------------------------------

Function invertGetIndex(i)
  Dim j
  If (UseSearchPlayList) Then
    For j=0 to UBound(PlayListArray)
      If (PlayListArray(j)=i) Then
      	invertGetIndex = j
      	Exit Function
      End If
    Next
  Else
    invertGetIndex = i
  End If
End Function

Sub songInfo(i)							'show song info of song# i
  Dim arrSong, arrArtist, tempArr
  Dim artist, song, track, length, line1, line2, line3, line4, line5, line6, line7

  setGotoMethod("songInfo")
  CurrentItem = "songInfo"
  deleteTimers
  fma.AddTimer 2250, "songInfoUpdate"
  LastArg1 = i

  WinampCtrl.SongPosParseTime = TRUE
  WinampCtrl.SetLengthParseTime = TRUE				'sets return of WinampCtrl.GetSongLength to (h:m:s)

  song = Filter(WinampCtrl.GetSongTitleByPosition(i))
  artist = Filter(WinampCtrl.GetArtistByPosition(i))

  track = " [ " & invertGetIndex(i)+1 & " of " & getTotalSongs & " ] "
  length = " ( " & WinampCtrl.GetSongLength & " ) "

  arrSong = splitString(song)
  arrArtist = splitString(artist)

  line1 = center(track,"-")
  line2 = center(arrSong(0),"")
  line3 = center(arrSong(1),"")
  line4 = center("-","")
  line5 = center(arrArtist(0),"")
  line6 = center(arrArtist(1),"")

  If (arrSong(1) = "") Then
    If (arrArtist(1) = "") Then
      line3 = line2
      line2 = ""

    ElseIf ( strPix(arrArtist(1),ScreenWidth) = -1 ) Then
      tempArr = splitString(arrArtist(1))

      line3 = line4
      line4 = line5
      line5 = center(tempArr(0),"")
      line6 = center(tempArr(1),"")
    End If

  ElseIf ( (strPix(arrSong(1),ScreenWidth) = -1) And (arrArtist(1) = "") ) Then
    tempArr = splitString(arrSong(1))

    line6 = line5
    line5 = line4
    line3 = center(tempArr(0),"")
    line4 = center(tempArr(1),"")
  End If

  line7 = center(length,"-")

  If (MyPhoneType(1)<3) Then
    boxT610 line1 ,line2 ,line3 ,line4 ,line5 ,line6 ,line7
  Else
    boxT68i line1 ,line2 ,line3 ,line4 ,line5 ,line6 ,line7
  End If

  am.NextState=2
  am.Back = "exitSongInfo"
End Sub

Sub songInfo2()							'show song info of song#
  setGotoMethod("songInfo2")
  am.Clear
  am.Title = Left("( " & WinampCtrl.GetSongPosition & " )",15)

  CurrentItem = "songInfo2"

  am.AddItem center("Samplerate: " & WinampCtrl.GetSongSampleRate & "kHz",""), "enterPlayList"
  am.AddItem center("Bitrate: " & WinampCtrl.GetSongBitRate & "kbps",""), "enterPlayList"
  am.AddItem center(songChanel,""), "enterPlayList"

  am.Back = "exitSongInfo"
  am.NextState=2
  am.update
End Sub

Function songChanel()
  If (WinampCtrl.GetSongChanel = 1) Then
    songChanel = "mono"
  Else
    songChanel = "stereo"
  End If
End Function

Function splitString(s)		'split string into two parts and return an Array with 2 elements (#chars of first element <= width)
  Dim s1, s2, w, pixsize, lw, words, break, temps
  pixsize = 0

  break = FALSE
  words = split(s)

  For Each w In words
    If (break) Then			'build up string 2
      s2 = s2 & w & " "

    Else
      lw = strPix(w,-1)			'count pix of word
        If (pixsize + lw > ScreenWidth) Then	'condition that determines border between string 1 and string 2
          break = TRUE
          s2 = s2 & w & " "		'word belongs to string 2
        Else
          s1 = s1 & w & " "
          pixsize = pixsize + lw + 3
        End If
    End If
  Next

  splitString = Array(RTrim(s1),RTrim(s2))
End Function


'------------------ SongInfo screen -----------------------

Sub boxT68i(line1,line2,line3,line4,line5,line6,line7)	'function needed for songinfo function (opens new window)
  am.Clear
  am.Title = Left("( " & WinampCtrl.GetSongPosition & " )",15)
  am.AddItem line1, "exitSongInfo"
  am.AddItem line2, "exitSongInfo"
  am.AddItem line3, "exitSongInfo"
  am.AddItem line4, "exitSongInfo"
  am.AddItem line5, "exitSongInfo"
  am.AddItem line6, "exitSongInfo"
  am.AddItem line7, "exitSongInfo"
  am.NextState=2
  am.Update
End Sub


Sub boxT610(line1,line2,line3,line4,line5,line6,line7)	'function needed for songinfo function (opens new window)
  Dim SongOneLine
  Dim ArtistOneLine

  am.Clear
  am.Title = Left("( " & WinampCtrl.GetSongPosition & " )",15)
  am.AddItem line1, "exitSongInfo"

  SongOneLine = (Trim(line2) = "") Or (Trim(line3) = "")
  ArtistOneLine = (Trim(line6) = "")

  If ((Not SongOneLine) Or ArtistOneLine) Then	'song multiple lines
    am.AddItem line2, "exitSongInfo"
  Else
    Line3 = line2
  End If

  am.AddItem line3, "exitSongInfo"
  am.AddItem line4, "exitSongInfo"

  If (Not ArtistOneLine) Then		 'Artist multiple lines
    am.AddItem line5, "exitSongInfo"
  Else					 'Artist single line
    Line6 = line5
  End If
  am.AddItem line6, "exitSongInfo"
  am.AddItem line7, "exitSongInfo"
  am.NextState=2
  am.Update
End Sub

Sub exitSongInfo()
  enterPlayList
End Sub



'------------------------------------ Seek --------------------------------------------

Public Showbar, NeededBars
Public RemSteps			'remaining steps to be shown at the last bar

Sub enterSeek()
  Dim p, steps, secPos
  deleteTimers
  'fma.AddTimer 1000, "seekUpdate"

  setGotoMethod("enterSeek")
  CurrentItem = "seek"

  SavePlayListPos = WinampCtrl.GetPlayListPosition

  WinampCtrl.SongPosParseTime = FALSE
  WinampCtrl.SetLengthParseTime = FALSE

  steps = WinampCtrl.GetSongLength\10			'total steps needed for the song
  RemSteps = steps mod 6				'steps needed in the last bar
  NeededBars = (steps\6) + 1


  secPos = (WinampCtrl.GetSongPosition\10000)		'10sec units
  Showbar = (secPos\6) + 1				'Set current bar to be shown

  p = secPos mod 6					'Set step for seekSlide

  WinampCtrl.SetLengthParseTime = TRUE

  seekSlide(p)
End Sub

Sub deleteTimers
  fma.DeleteTimer("seekUpdate")
  fma.DeleteTimer("playlistUpdate")
  fma.DeleteTimer("songInfoUpdate")
  fma.DeleteTimer("winampUpdate")
  fma.DeleteTimer("mediaPlayerUpdate")
  fma.DeleteTimer("mp9seekUpdate")
End Sub

Sub seekSlide(i)
  Dim title

  WinampCtrl.SongPosParseTime = TRUE
  title = "(" & WinampCtrl.GetSongPosition & ")  " & WinampCtrl.GetSongLength

  If(Showbar = NeededBars) Then				'last bar shown steps
    am.DlgPercent title, "seekEvent", RemSteps, i
  Else
    am.DlgPercent title, "seekEvent", 6, i
  End If
End Sub

Sub seekUpdate
  WinampCtrl.SongPosParseTime = FALSE
  seekSlide((WinampCtrl.GetSongPosition\10000) mod 6)
End Sub

Sub seekEvent(value, final)
  Dim JumpTo, ShowLastBar

  If (final = 1) Then
    If (CurrentItem = "menu") Then
      winamp
    Else
      enterPlayList
    End If
  ElseIf(SavePlayListPos <> WinampCtrl.GetPlayListPosition) Then	'a new song is played
    enterSeek
  Else
    ShowLastBar = (Showbar = NeededBars)
    If (ShowLastBar) Then														'last bar shown
      JumpTo = (((Showbar-1)*600) + (value*RemSteps) )*100
    Else
      JumpTo = ((Showbar-1)*100 + value )*600
    End If

    If (WinampCtrl.JumpToTime(JumpTo) = 0) Then		'0 = succes, -1 = not playing, 1 = eof
      If (value = 100) Then				'end of bar
        If (Not ShowLastBar) Then			'not last bar
          Showbar = Showbar + 1
          seekSlide(0)
        Else						'end of song is reached
          winamp					'goto winamp menu
        End If

      ElseIf ((value = 0) and (Showbar <> 1)) Then	'begin of bar and not first bar
        Showbar = Showbar - 1
        seekSlide(6)
      ElseIf (ShowLastBar) Then				'middle
          seekSlide(Round((value*RemSteps)/100))
      Else
          seekSlide(Round((value*6)/100))
      End If
    Else						'not playing || eof
      WinampCtrl.Play
    End If
  End If
End Sub


'------------------ winamp volume control -----------------

Sub winampSlideVol()					'Winamp volume slider
  CurrentItem = "volumeslide"
  am.DlgPercent "Winamp volume", "winampVolEvent", 10, WinampVol/25.5
End Sub

Sub winampVolEvent(value,final)
  WinampVol = value*2.55
  WinampCtrl.SetVolume = WinampVol
  If (final = 1) Then gotoMethod
End Sub


'----------------- winamp volume control ------------------

'----------------------------- shuffle & repeat & menu options ------------------------

Sub enterWinampOptions()
  am.Clear
  winampOptions
End Sub

Sub winampOptions()
  CurrentItem = "options"
  am.ClearMenu
  am.Title = "Winamp options"

  am.AddItem checkBox(WinampCtrl.shuffle) & "Shuffle", "enterShuffleToggle"
  am.AddItem checkBox(WinampCtrl.repeat) & "Repeat", "enterRepeatToggle"
  am.AddItem center("Reload playlist",""), "reloadPlayList"

  am.Back = "Winamp"
  am.NextState=2
  am.Update
End Sub

Sub enterShuffleToggle()
  WinampCtrl.Shuffle = Not WinampCtrl.Shuffle
  winampOptions
End Sub

Sub enterRepeatToggle()
  WinampCtrl.Repeat = Not WinampCtrl.Repeat
  winampOptions
End Sub

'----------------- end options ---------------------------

'---------------------------- Winamp Search -----------------------------------

Public SearchType

Sub winampSearch()
  setGotoMethod("winampSearch")
  CurrentItem = "winampSearch"
  deleteTimers

  am.Clear
  am.Title = "Winamp search"

  am.AddItem "Search artist", "searchArtist"
  am.AddItem "Search songtitle", "searchSong"
  am.AddItem "Show all artists", "enterAllArtists"

  am.Back = "enterWinamp"
  am.NextState=2
  am.Update
End Sub

Sub searchArtist
  SearchType = "artist"
  CurrentItem = "searchInput"
  am.DlgInputStr "Search artist", "Keyword:", 15, "", "searching"
End Sub

Sub searchSong
  SearchType = "title"
  CurrentItem = "searchInput"
  am.DlgInputStr "Search title", "Keyword:", 15, "", "searching"
End Sub

Sub simpleSearch
  SearchType = "simple"
  setGotoMethod("simpleSearch")
  CurrentItem = "simpleSearch"
  am.DlgInputStr "Search title", "Keyword:", 15, "", "searching"
End Sub

Sub searching(s)
  If (Trim(s) = "") Then
    If (SearchType = "simple") Then
      playlistOptions
    Else
      winampSearch
    End If
  Else
    am.DlgFeedback "Searching...", "winampSearch"
    am.update
    search s
  End If
End Sub

Public searchP

Sub playlistOptions
  setGotoMethod("playlistOptions")
  CurrentItem = "playlistOptions"
  am.Clear
  am.Title = "Playlist search"
  am.AddItem "Simple search", "simpleSearch"
  am.AddItem "Goto song#", "enterGotoSong"
  am.AddItem "Seek current song", "enterSeek"
  am.AddItem center("Reload playlist",""), "reloadPlayList"

  am.back = "enterPlayList"
  am.NextState=2
  am.Update
End Sub

Sub reloadPlayList
  SimpleSearchOn = FALSE
  UseSearchPlayList = FALSE
  GetPlayListBool  = TRUE
  getPlayList

  enterWinamp
End Sub

Sub enterGotoSong
  Dim title
  CurrentItem = "gotoSong"
  title = "[ 1 - " & CStr(getTotalSongs) & " ]"
  am.DlgInputInt title, "Goto song#:", 1, getTotalSongs, 1, "gotoSongEvent"
End Sub

Sub gotoSongEvent(i)
  PlayList(i-1)
End Sub

Public SimpleSearchOn
Public SearchResult

Sub simpleResults
  am.Clear
  am.Title = "Search results"

  If (SearchResult > 0) Then
    UseSearchPlayList = FALSE
    SimpleSearchOn = TRUE
    SearchP = 0

    If (SearchResult = 1) Then
      am.AddItem "1 result", "gotoSimpleSearchPlayList"
    Else
      am.AddItem SearchResult & " results", "gotoSimpleSearchPlayList"
    End If

    am.AddItem "New search", "simpleSearch"
  Else
    am.AddItem "No results", "enterPlaylist"
    am.AddItem "Search again", "simpleSearch"
  End If

  am.back = "playlistOptions"
  am.NextState=2
  am.Update
End Sub


Sub nextSearch
  If (SearchP<SearchResult-1) Then
    SearchP = SearchP+1
  Else
    SearchP = 0
  End If
  WinampCtrl.PlaySongByPosition(WinampCtrl.GetSearchSong(SearchP))
  playlist(WinampCtrl.GetSearchSong(SearchP))
End Sub

Sub prevSearch
  If (SearchP=0) Then
    SearchP = SearchResult-1
  Else
    SearchP = SearchP-1
  End If
  WinampCtrl.PlaySongByPosition(WinampCtrl.GetSearchSong(SearchP))
  playlist(WinampCtrl.GetSearchSong(SearchP))
End Sub

Sub gotoSimpleSearchPlayList
  playlist(WinampCtrl.GetSearchSong(0))
End Sub

Public PagePos

Sub search(s)	's always a nonempty string

  Select Case SearchType
    Case "artist"  SearchResult = WinampCtrl.SearchArtist(s)
    Case "title"   SearchResult = WinampCtrl.SearchSong(s)
    Case "simple"  SearchResult = WinampCtrl.SearchSong(s)
  End Select

  If (SearchResult > 0) Then
    UseSearchPlayList = TRUE
    Pos=0
  End If

  Select Case SearchType
    Case "artist"  enterArtistResults
    Case "title"   titleResults
    Case "simple"  simpleResults
  End Select
End Sub

Sub titleResults()
  am.Clear
  am.title = "Title results"

  If (SearchResult > 0) Then
    If (SearchResult = 1) Then
      am.AddItem SearchResult & " result" , "enterSearchPlayList"
    Else
      am.AddItem SearchResult & " results" , "enterSearchPlayList"
    End If
    am.AddItem "New search","searchSong"
  Else
    am.AddItem "No results", "enterPlaylist"
    am.AddItem "Search again", "searchSong"
  End If

  am.back = "winampSearch"
  am.NextState = 2
  am.Update
End Sub

Public SimpleSearchOnBackup

Sub enterSearchPlayList
  Dim i
  ReDim PlayListArray(SearchResult-1)		'resize array

  SimpleSearchOnBackup = SimpleSearchOn
  SimpleSearchOn = FALSE

  For i=0 To SearchResult-1
    PlayListArray(i) = WinampCtrl.GetSearchSong(i)
  Next
    PlayList(0)
End Sub

Sub enterArtistResults
  PagePos = 0
  artistResults
End Sub

Sub enterAllArtists   'show all artists
  SearchType = ""
  PagePos = 0
  allArtists
End Sub

Sub artistResults     'show results of artist search
  Dim i, i2

  setGotoMethod("artistResults")
  CurrentItem = "artistResults"
  am.Clear

  If(SearchResult > 0) Then		'results
    If (SearchResult = 1) Then
      am.Title = "[1/1]"
    Else
      am.Title = Left("[" & CStr(PagePos+1) & "/" & CStr((SearchResult \ NrResults)+1) & "]",15)
    End If

    i2 = PagePos*NrResults
    setItemPress("songsByArtist")
    For i=0 To NrResults-1
      If ((i2+i)<SearchResult) Then
        am.AddItem filter(WinampCtrl.GetSearchArtistString(i2+i)),"itemPress" & i
      Else
        Exit For
      End If
    Next
  Else					'no results
    am.Title = "No results"
    am.AddItem "New search","winampSearch"
  End If

  am.back = "winampSearch"
  am.NextState = 2
  am.update
End Sub

Sub allArtists   'show list of all artists
  setGotoMethod("allArtists")
  CurrentItem = "allArtists"
  am.Clear

  SearchResult = WinampCtrl.GetTotalUniqueArtist
  am.Title = Left("[" & CStr(PagePos+1) & "/" & CStr((SearchResult \ NrResults)+1) & "]",15)

  Dim i, i2
  i2 = PagePos*NrResults

  setItemPress("songsByArtist")
  For i=0 To NrResults-1
    If ((i2+i)<WinampCtrl.GetTotalUniqueArtist) Then
     am.AddItem filter(WinampCtrl.GetUniqueArtist(i2+i)),"itemPress" & i
    Else
      Exit For
    End If
  Next

  am.back = "winampSearch"
  am.NextState = 2
  am.update
End Sub

Public NrResults 'nr search results on a page
NrResults = 6

Sub nextArtists  'next page of artists
  If (PagePos = (SearchResult\NrResults)) Then
    PagePos = 0
  Else
    PagePos = PagePos+1
  End If

  If (CurrentItem = "allArtists") Then
    allArtists
  Else
    artistResults
  End If
End Sub


Sub prevArtists  'prev page of artists
  If (PagePos = 0) Then
    PagePos = (SearchResult\NrResults)
  Else
    PagePos = PagePos - 1
  End If

  If (CurrentItem = "allArtists") Then
    allArtists
  Else
    artistResults
  End If
End Sub


Sub songsByArtist(index)          'show songs of artits with index
  Dim i,i2, j
  i2 = PagePos*NrResults
  If (CurrentItem = "allArtists") Then
    i = WinampCtrl.SearchSongsFromArtist(i2+index)		'if all artist are shown first artist = 0
  Else
    i = WinampCtrl.SearchSongsFromArtist(WinampCtrl.GetSearchArtist(i2+index))	'if search on artist
  End If

  If (i>0) Then		'if there are results then copy to winamparray
    UseSearchPlayList = TRUE
    ReDim PlayListArray(i-1)		'resize array

    For j=0 To i-1
      PlayListArray(j) = WinampCtrl.GetSearchSongsFromArtist(j)
    Next
    PlayList(0)
  End If
End Sub
'---------------------------- Winamp Search -----------------------------------



'---------------------------- Main Volume Control -----------------------------


Sub enterVolumeControl()
  am.Clear
  volumeControl
End Sub

Sub volumeControl()
  enterAppMenu(6)

  Dim VolStat
  VolStat = getVolumeStat

  am.Title = Left(VolStat,15)

  If VolStat = "Muted" Then
    am.AddItem "UnMute", "volMute"
  Else
    am.AddItem "Mute", "volMute"
    am.AddItem "Master volume", "masterVol"
  End If

  am.Back = "onAMRoot"
  am.NextState=2
  am.Update
End Sub

Sub masterVol()
  CurrentItem = "volumeslide"

  If (VolumeCtrl.Mute = 0) Then							'not muted
    am.DlgPercent "Master volume", "masterVolEvent", 10 , VolumeCtrl.Volume/10
  Else										'muted
    volumeControl
  End If
End Sub


Sub masterVolEvent(value, final)
  VolumeCtrl.Volume = value
  If final = 1 Then GotoMethod
End Sub

Sub volMute()
  If VolumeCtrl.Mute = 1 Then
    VolumeCtrl.Mute = 0
  Else
    VolumeCtrl.Mute = 1
  End If

  volumeControl
End Sub


Function getVolumeStat()
  If VolumeCtrl.Mute = 1 Then
    getVolumeStat = "Muted"
  Else
    getVolumeStat = "Vol: " & VolumeCtrl.Volume & "%"
  End If
End Function


'--------------------- app functions -------------

Sub setAppName(s)
  AppName = s
End Sub

Sub enterAppMenu(id)			'called in appsubs to set proper id and title
  CurrentID = RootID(id,0)
  CurrentItem = "menu"

  am.ClearMenu
  am.Title = Left(RootID(id,1),15)
End Sub


'----------------------------------------------------------------------------------

Sub channelList()
  setGotoMethod("channelList")
  CurrentItem = "channelList"
  am.Clear
  am.Title = "Remote mode"
  setItemPress("sendKey")
  am.AddItem center("Press (0-9)",""), "channelList"

  am.Back = RootID(CurrentID,2)
  am.NextState=2
  am.Update
End Sub

Public AppName

Sub sendKey(i)
  If shell.AppActivate(AppName) Then shell.SendKeys(i)
  channelList
End Sub

Sub channel0
  If shell.AppActivate(AppName) Then shell.SendKeys(0)
  channelList
End Sub
Sub channel1
  If shell.AppActivate(AppName) Then shell.SendKeys(1)
  channelList
End Sub
Sub channel2
  If shell.AppActivate(AppName) Then shell.SendKeys(2)
  channelList
End Sub
Sub channel3
  If shell.AppActivate(AppName) Then shell.SendKeys(3)
  channelList
End Sub
Sub channel4
  If shell.AppActivate(AppName) Then shell.SendKeys(4)
  channelList
End Sub
Sub channel5
  If shell.AppActivate(AppName) Then shell.SendKeys(5)
  channelList
End Sub
Sub channel6
  If shell.AppActivate(AppName) Then shell.SendKeys(6)
  channelList
End Sub
Sub channel7
  If shell.AppActivate(AppName) Then shell.SendKeys(7)
  channelList
End Sub
Sub channel8
  If shell.AppActivate(AppName) Then shell.SendKeys(8)
  channelList
End Sub
Sub channel9
  If shell.AppActivate(AppName) Then shell.SendKeys(9)
  channelList
End Sub


'---------------------------- Hauppauge WinTV ---------------------------------

'id=0
Sub enterWinTV()
  setAppName("WinTV32")
  AppOpen = shell.AppActivate("WinTV32")

  am.Clear
  winTV
End Sub

Sub winTV()
  enterAppMenu(0)

  If (AppOpen) Then
    am.AddItem "Remote mode", "channelList"
    am.AddItem "Mute", "winTVMute"
    am.AddItem "Fullscreen", "winTVFullscreen"
    am.AddItem "Freeze", "winTVFreeze"
    If (MyPhoneType(1)=3) Then
      am.AddItem "Snapshot", "winTVSnapshot"
    End If
    am.AddItem "Source", "winTVSource"
    am.AddItem "Close WinTV", "winTVClose"
  Else
    am.AddItem "Launch WinTV", "winTVLaunch"
  End If

  am.Back = "onAMRoot"
  am.NextState=2
  am.Update
End Sub

Sub winTVLaunch()
  LaunchAppDlg
  shell.Exec RootEXE(0)
  AppOpen = TRUE
  winTV
End Sub
Sub winTVClose()
  CloseAppDlg
  If shell.AppActivate("WinTV32") Then shell.SendKeys("%{F4}")
  AppOpen = FALSE
  winTV
End Sub

Sub winTVSnapshot()
  If shell.AppActivate("WinTV32") Then shell.SendKeys("{ }")
  am.Update
End Sub
Sub winTVSource()
  If shell.AppActivate("WinTV32") Then shell.SendKeys("^s")
  am.update
End Sub
Sub winTVFreeze()
  If shell.AppActivate("WinTV32") Then shell.SendKeys("^f")
  am.Update
End Sub
Sub winTVChannelDown()
  If shell.AppActivate("WinTV32") Then shell.SendKeys("{-}")
  am.Update
End Sub
Sub winTVChannelUp()
  If shell.AppActivate("WinTV32") Then shell.SendKeys("{+}")
  am.Update
End Sub

Sub winTVFullscreen()
  If shell.AppActivate("WinTV32") Then shell.SendKeys("^t")
  am.update
End Sub
Sub winTVMute()
  If shell.AppActivate("WinTV32") Then shell.SendKeys("^m")
  am.update
End Sub

'--------------------------- MoreTV -----------------------------------------
'id=1

Sub enterMoreTV()
  setAppName("MoreTV")
  AppOpen = shell.AppActivate("MoreTV")

  am.Clear
  moreTV
End Sub

Sub moreTV()
  enterAppMenu(1)

  If (AppOpen) Then
    am.AddItem "Remote Mode", "channelList"
    am.AddItem "Mute", "moreTVMute"
    am.AddItem "Fullscreen", "moreTVFullscreen"
    am.AddItem "Videotext", "moreTVVideotext"
    am.AddItem "Close MoreTV", "moreTVClose"
  Else
    am.AddItem "Launch MoreTV", "moreTVLaunch"
  End If

  am.Back = "onAMRoot"
  am.NextState=2
  am.Update
End Sub

Sub moreTVLaunch()
  LaunchAppDlg
  shell.Exec RootEXE(1)
  AppOpen = TRUE
  moreTV
End Sub
Sub moreTVClose()
  CloseAppDlg
  If shell.AppActivate("MoreTV") Then shell.SendKeys("{F10}")
  AppOpen = FALSE
  moreTV
End Sub

Sub moreTVChannelUp()
  If shell.AppActivate("MoreTV") Then shell.SendKeys("{UP}")
  am.Update
End Sub
Sub moreTVChannelDown()
  If shell.AppActivate("MoreTV") Then shell.SendKeys("{DOWN}")
  am.Update
End Sub
Sub moreTVMute()
  If shell.AppActivate("MoreTV") Then shell.SendKeys("m")
  am.Update
End Sub
Sub moreTVVideotext()
  If shell.AppActivate("MoreTV") Then shell.SendKeys("v")
  am.Update
End Sub
Sub moreTVFullscreen()
  If shell.AppActivate("MoreTV") Then shell.SendKeys("{F9}")
  am.Update
End Sub

'--------------------------- DScaler -----------------------------------------
'id=12
Sub enterDScaler()
  setAppName("DScaler")
  AppOpen = shell.AppActivate("DScaler")

  am.Clear
  dScaler
End Sub

Sub dScaler()
  enterAppMenu(12)

  If (AppOpen) Then
    am.AddItem "Remote mode", "channelList"
    am.AddItem "Mute", "dScalerMute"
    am.AddItem "Fullscreen", "dScalerFullscreen"
    am.AddItem "Last channel", "dScalerLastChannel"
    am.AddItem "Freeze", "dScalerFreeze"
    If (MyPhoneType(1)=3) Then
      am.AddItem "Snapshot", "dScalerSnapshot"
    End If
    am.AddItem "Start recording", "dScalerStartRecord"
    am.AddItem "Stop recording", "dScalerStopRecord"
    am.AddItem "Preview", "dScalerPreview"
    am.AddItem "Teletext", "dScalerTeletext"
    am.AddItem "Zoom +", "dScalerZoomIn"
    am.AddItem "Zoom -", "dScalerZoomOut"
    am.AddItem "Info", "dScalerInfo"
    am.AddItem "Close DScaler", "dScalerClose"
  Else
    am.AddItem "Launch DScaler", "dScalerLaunch"
  End If

  am.Back = "onAMRoot"
  am.NextState=2
  am.Update
End Sub

Sub dScalerLaunch()
  LaunchAppDlg
  shell.Exec RootEXE(12)
  AppOpen = TRUE
  dScaler
End Sub
Sub dScalerClose()
  CloseAppDlg
  If shell.AppActivate("DScaler") Then shell.SendKeys("%{F4}")
  AppOpen = FALSE
  dScaler
End Sub

Sub dScalerSnapshot()
  If shell.AppActivate("DScaler") Then shell.SendKeys("l")
  am.Update
End Sub
Sub dScalerFreeze()
  If shell.AppActivate("DScaler") Then shell.SendKeys("p")
  am.Update
End Sub
Sub dScalerChannelDown()
  If shell.AppActivate("DScaler") Then shell.SendKeys("{PGDN}")
  am.Update
End Sub
Sub dScalerChannelUp()
  If shell.AppActivate("DScaler") Then shell.SendKeys("{PGUP}")
  am.Update
End Sub

Sub dScalerStartRecord()
  If shell.AppActivate("DScaler") Then shell.SendKeys("+{R}")
  am.Update
End Sub
Sub dScalerStopRecord()
  If shell.AppActivate("DScaler") Then shell.SendKeys("+{S}")
  am.Update
End Sub
Sub dScalerPreview()
  If shell.AppActivate("DScaler") Then shell.SendKeys("{INSERT}")
  am.Update
End Sub
Sub dScalerLastChannel()
  If shell.AppActivate("DScaler") Then shell.SendKeys("^{BKSP}")
  am.Update
End Sub
Sub dScalerZoomIn()
  If shell.AppActivate("DScaler") Then shell.SendKeys("+{Z}")
  am.update
End Sub
Sub dScalerZoomOut()
  If shell.AppActivate("DScaler") Then shell.SendKeys("z")
  am.update
End Sub
Sub dScalerFullscreen()
  If shell.AppActivate("DScaler") Then shell.SendKeys("%{ENTER}")
  am.update
End Sub
Sub dScalerTeletext()
  If shell.AppActivate("DScaler") Then shell.SendKeys("t")
  am.update
End Sub
Sub dScalerMute()
  If shell.AppActivate("DScaler") Then shell.SendKeys("m")
  am.update
End Sub
Sub dScalerInfo()
  If shell.AppActivate("DScaler") Then shell.SendKeys("{ENTER}")
  am.update
End Sub



'--------------------------- BSPlayer -----------------------------------------
'id=4

Sub enterBSPlayer()
  AppOpen = shell.AppActivate("BSPlayer")
  am.Clear
  bsPlayer
End Sub

Sub bsPlayer()
  enterAppMenu(4)

  If (AppOpen) Then
    am.AddItem "Play", "bsPlayerPlay"
    am.AddItem "Pause", "bsPlayerPause"
    am.AddItem "Stop", "bsPlayerStop"
    am.AddItem "Fullscreen", "bsPlayerFullscreen"
    am.AddItem "Sub Toggle", "bsPlayerSub"
    am.AddItem "Zoom", "bsPlayerZoom"
    am.AddItem "Close BSPlayer", "bsPlayerClose"
  Else
    am.AddItem "Launch BSPlayer", "bsPlayerLaunch"
  End If

  am.Back = "onAMRoot"
  am.NextState=2
  am.Update
End Sub

Sub bsPlayerLaunch()
  LaunchAppDlg
  shell.Exec RootEXE(4)
  AppOpen = TRUE
  bsPlayer
End Sub
Sub bsPlayerClose()
  CloseAppDlg
  If shell.AppActivate("BSPlayer") Then shell.SendKeys("%{F4}")
  AppOpen = FALSE
  bsPlayer
End Sub

Sub bsPlayerPlay()
  If shell.AppActivate("BSPlayer") Then shell.SendKeys("x")
  am.Update
End Sub
Sub bsPlayerPause()
  If shell.AppActivate("BSPlayer") Then shell.SendKeys("c")
  am.Update
End Sub
Sub bsPlayerStop()
  If shell.AppActivate("BSPlayer") Then shell.SendKeys("v")
  am.Update
End Sub
Sub bsPlayerPrev()
  If shell.AppActivate("BSPlayer") Then shell.SendKeys("y")
  am.Update
End Sub
Sub bsPlayerNext()
  If shell.AppActivate("BSPlayer") Then shell.SendKeys("b")
  am.Update
End Sub
Sub bsPlayerFullscreen()
  If shell.AppActivate("BSPlayer") Then shell.SendKeys("f")
  am.Update
End Sub
Sub bsPlayerSub()
  If shell.AppActivate("BSPlayer") Then shell.SendKeys("s")
  am.Update
End Sub


'------------------ BSPlayer Zoom control -----------------

Sub bsPlayerZoom()
  CurrentItem = "zoom"
  am.DlgPercent "Zoom control", "bsPlayerZoomEvent", 2, BSPlayerZoomValue
End Sub

Sub bsPlayerZoomEvent(value,final)
  If (final = 1) Then
    bsPlayer
  ElseIf (value = 0) Then
    bsPlayerZoom1
  ElseIf (value = 100) Then
    bsPlayerZoom3
  Else
    bsPlayerZoom2
  End If
End Sub

Sub bsPlayerZoom1()
  If shell.AppActivate("BSPlayer") Then shell.SendKeys("1")
  BSPlayerZoomValue = 0
End Sub
Sub bsPlayerZoom2()
  If shell.AppActivate("BSPlayer") Then shell.SendKeys("2")
  BSPlayerZoomValue = 1
End Sub
Sub bsPlayerZoom3()
  If shell.AppActivate("BSPlayer") Then shell.SendKeys("3")
  BSPlayerZoomValue = 2
End Sub

'----------------- ZoomPlayer control ------------------
'id=13

Sub enterZoomPlayer()
  AppOpen = shell.AppActivate("ZoomPlayer")
  am.Clear
  zoomPlayer
End Sub

Sub zoomPlayer()
  enterAppMenu(13)

  If (AppOpen) Then
    am.AddItem "Play/Pause", "zoomPlayerPlay"
    am.AddItem "Stop", "zoomPlayerStop"
    am.AddItem "Jump ahead", "zoomPlayerJumpAhead"
    am.AddItem "Jump back", "zoomPlayerJumpBack"
    am.AddItem "Mute", "zoomPlayerVolumeMute"
    am.AddItem "Fullscreen", "zoomPlayerFullscreen"
    am.AddItem "Fast Fwd", "zoomPlayerFastForward"
    am.AddItem "Rewind", "zoomPlayerRewind"
    am.AddItem "SubTitles", "zoomPlayerSubtitles"
    am.AddItem "Close ZoomPlayer", "zoomPlayerClose"
  Else
    am.AddItem "Launch ZoomPlayer", "zoomPlayerLaunch"
  End If

  am.Back = "onAMRoot"
  am.NextState=2
  am.Update
End Sub

Sub zoomPlayerLaunch()
  LaunchAppDlg
  shell.Exec RootEXE(13)
  AppOpen = TRUE
  zoomPlayer
End Sub
Sub zoomPlayerClose()
  CloseAppDlg
  If shell.AppActivate("ZoomPlayer") Then shell.SendKeys("%{x}")
  AppOpen = FALSE
  zoomPlayer
End Sub

Sub zoomPlayerPlay
	If shell.AppActivate("ZoomPlayer") Then Shell.SendKeys("p")
	am.Update
End Sub
Sub zoomPlayerStop
	If shell.AppActivate("ZoomPlayer") Then Shell.SendKeys("s")
	am.Update
End Sub
Sub zoomPlayerPrev
	If shell.AppActivate("ZoomPlayer") Then Shell.SendKeys("+[")
	am.Update
End Sub
Sub zoomPlayerNext
	If shell.AppActivate("ZoomPlayer") Then Shell.SendKeys("+]")
	am.Update
End Sub
Sub zoomPlayerJumpAhead
	If shell.AppActivate("ZoomPlayer") Then Shell.SendKeys("%.")
	am.Update
End Sub
Sub zoomPlayerJumpBack
	If shell.AppActivate("ZoomPlayer") Then Shell.SendKeys("%,")
	am.Update
End Sub
Sub zoomPlayerVolumeUp
	If shell.AppActivate("ZoomPlayer") Then Shell.SendKeys("+{UP}")
	am.Update
End Sub
Sub zoomPlayerVolumeDn
	If shell.AppActivate("ZoomPlayer") Then Shell.SendKeys("+{DOWN}")
	am.Update
End Sub
Sub zoomPlayerVolumeMute
	If shell.AppActivate("ZoomPlayer") Then Shell.SendKeys("^m")
	am.Update
End Sub
Sub zoomPlayerSubtitles
	If shell.AppActivate("ZoomPlayer") Then Shell.SendKeys("+;")
	am.Update
End Sub
Sub zoomPlayerFullscreen
	If shell.AppActivate("ZoomPlayer") Then Shell.SendKeys("%{ENTER}")
	am.Update
End Sub
Sub zoomPlayerFastForward
	If shell.AppActivate("ZoomPlayer") Then Shell.SendKeys("%{HOME}")
	am.Update
End Sub
Sub zoomPlayerRewind
	If shell.AppActivate("ZoomPlayer") Then Shell.SendKeys("%{END}")
	am.Update
End Sub

'----------------- RadLight control ------------------
'id=16

Sub enterRadLight()
  AppOpen = shell.AppActivate("RadLight")
  am.Clear
  RadLight
End Sub

Sub RadLight()
  enterAppMenu(16)

  If (AppOpen) Then
    am.AddItem "Play", "RadLightPlay"
    am.AddItem "Stop", "RadLightStop"
    am.AddItem "Pause", "RadLightPause"
    am.AddItem "Mute", "RadLightVolumeMute"
    am.AddItem "Fullscreen", "RadLightFullscreen"
    am.AddItem "Fast Fwd", "RadLightFastForward"
    am.AddItem "Rewind", "RadLightRewind"
    am.AddItem "SubTitles", "RadLightSubtitles"
    am.AddItem "Close RadLight", "RadLightClose"
  Else
    am.AddItem "Launch RadLight", "RadLightLaunch"
  End If

  am.Back = "onAMRoot"
  am.NextState=2
  am.Update
End Sub

Sub RadLightLaunch()
  LaunchAppDlg
  shell.Exec RootEXE(16)
  AppOpen = TRUE
  RadLight
End Sub
Sub RadLightClose()
  CloseAppDlg
  If shell.AppActivate("RadLight") Then shell.SendKeys("^{x}")
  AppOpen = FALSE
  RadLight
End Sub

Sub RadLightPlay
	If shell.AppActivate("RadLight") Then Shell.SendKeys("x")
	am.Update
End Sub
Sub RadLightStop
	If shell.AppActivate("RadLight") Then Shell.SendKeys("c")
	am.Update
End Sub
Sub RadLightPause
	If shell.AppActivate("RadLight") Then Shell.SendKeys("{ }")
	am.Update
End Sub
Sub RadLightPrev
	If shell.AppActivate("RadLight") Then Shell.SendKeys("z")
	am.Update
End Sub
Sub RadLightNext
	If shell.AppActivate("RadLight") Then Shell.SendKeys("b")
	am.Update
End Sub

Sub RadLightVolumeUp
	If shell.AppActivate("RadLight") Then Shell.SendKeys("+{UP}")
	am.Update
End Sub
Sub RadLightVolumeDn
	If shell.AppActivate("RadLight") Then Shell.SendKeys("+{DOWN}")
	am.Update
End Sub
Sub RadLightVolumeMute
	If shell.AppActivate("RadLight") Then Shell.SendKeys("^m")
	am.Update
End Sub
Sub RadLightSubtitles
	If shell.AppActivate("RadLight") Then Shell.SendKeys("s")
	am.Update
End Sub
Sub RadLightFullscreen
	If shell.AppActivate("RadLight") Then Shell.SendKeys("f")
	am.Update
End Sub
Sub RadLightFastForward
	If shell.AppActivate("RadLight") Then Shell.SendKeys("+{RIGHT}")
	am.Update
End Sub
Sub RadLightRewind
	If shell.AppActivate("RadLight") Then Shell.SendKeys("%{LEFT}")
	am.Update
End Sub

'----------------------------- Windows Media Player Control -----------------------------
'id=5

Sub enterMediaPlayer()
dim dwnld
  If (WMPplginI) Then
    AppOpen = WMPplugin.Running
    am.Clear
    mediaPlayer
  Else
    dwnld = MsgBox ("Warning!" & Chr(13) & "You don't have Windows Media Player control plugin installed, you can download it from http://www.mediatexx.com/download/wmpuice.zip, if you don't install it you won't be able to control WMP using your mobile phone." & Chr(13) & "Download it now?", 52, "floAt's Mobile Agent")
    If dwnld=6 Then
      Shell.Run "RunDLL32.EXE url.dll, FileProtocolHandler http://www.mediatexx.com/download/wmpuice.zip"
    End If
    am.Update
  End If
End Sub

Public WMPcurrentItemState

Sub mediaPlayerUpdate
dim WMPnewState, songName

  If (WMPplugin.Running) Then
    WMPnewState = WMPcurrentItemState
    If (WMPCtrl.currentPlaylist.count>0) Then
      songName = Filter(WMPCtrl.currentMedia.name)
      If (WMPCtrl.currentMedia.getItemInfo("Artist")<>"") Then
        songName = songName & " - " & Filter(WMPCtrl.currentMedia.getItemInfo("Artist"))
      End If
      If (WMPCtrl.playState=2) Then
        WMPcurrentItemState = "| | " & songName
      ElseIf (WMPCtrl.playState=3) Then
        WMPcurrentItemState = "> " & songName
      ElseIf (WMPCtrl.playState=9) Then
        WMPcurrentItemState = "[opening] " & songName
      Else
        WMPcurrentItemState = "[ ] " & songName
      End If

      If (WMPcurrentItemState <> WMPnewState)and(CurrentItem="menu")and(CurrentID = RootID(5,0)) Then
        enterMediaPlayer
      ElseIf (CurrentItem<>"menu")or(CurrentID<>RootID(5,0)) Then
        fma.DeleteTimer("mediaPlayerUpdate")
      End If
    Else
      WMPcurrentItemState = "(blank playlist)"
      If (WMPcurrentItemState <> WMPnewState)and(CurrentItem="menu")and(CurrentID = RootID(5,0)) Then
        enterMediaPlayer
      ElseIf (CurrentItem<>"menu")or(CurrentID<>RootID(5,0)) Then
        fma.DeleteTimer("mediaPlayerUpdate")
      End If
    End If
  Else
    deleteTimers
    If (CurrentID = RootID(5,0)) Then enterMediaPlayer
  End If
End Sub

Sub mediaPlayer()
dim songName
  am.ClearMenu
  enterAppMenu(5)
  deleteTimers
  If AppOpen Then
    Pos = 0
    Set WMPCtrl = WMPplugin.Core
    fma.AddTimer 4000, "mediaPlayerUpdate"
    If (WMPCtrl.currentPlaylist.count>0) Then
      songName = Filter(WMPCtrl.currentMedia.name)
      If (WMPCtrl.currentMedia.getItemInfo("Artist")<>"") Then
        songName = songName & " - " & Filter(WMPCtrl.currentMedia.getItemInfo("Artist"))
      End If
      If WMPCtrl.playState=2 Then
        WMPcurrentItemState = "| | " & songName
        am.AddItem WMPcurrentItemState, "mp9currPlaylist"
        am.AddItem "Resume", "mp9PlayPause"
        am.AddItem "Stop", "mp9Stop"
        am.AddItem "Seek", "mp9enterSeek"
      ElseIf (WMPCtrl.playState=3) Then
        WMPcurrentItemState = "> " & songName
        am.AddItem WMPcurrentItemState, "mp9currPlaylist"
        am.AddItem "Pause", "mp9PlayPause"
        am.AddItem "Stop", "mp9Stop"
        am.AddItem "Seek", "mp9enterSeek"
      ElseIf (WMPCtrl.playState=9) Then
        WMPcurrentItemState = "[opening] " & songName
        am.AddItem WMPcurrentItemState, "mp9currPlaylist"
        am.AddItem "Play", "mp9PlayPause"
        am.AddItem "Stop", "mp9Stop"
      Else
        WMPcurrentItemState = "[ ] " & songName
        am.AddItem WMPcurrentItemState, "mp9currPlaylist"
        am.AddItem "Play", "mp9PlayPause"
      End If
    Else
      WMPcurrentItemState = "(blank playlist)"
      am.AddItem WMPcurrentItemState, "mp9Playlists"
    End If
    am.AddItem "Playlist: " & Filter(WMPCtrl.currentPlaylist.name) &", items: "& WMPCtrl.currentPlaylist.count, "mp9Playlists"
    am.AddItem "Search in Media Library", "mp9LibrarySearch"
    am.AddItem checkBox(WMPCtrl.settings.getMode("shuffle")) & "Shuffle", "mp9Shuffle"
    am.AddItem checkBox(WMPCtrl.settings.getMode("loop")) & "Repeat", "mp9Repeat"
'    If (WMPCtrl.fullScreen) Then                            'couldn't get it to work
'      am.AddItem "Exit Fullscreen", "mp9Fullscreen"
'    Else
    am.AddItem "Fullscreen", "mp9Fullscreen"
'    End If
    am.AddItem "Change speed", "mp9speed"
    am.AddItem "Close WMP", "mp9Close"
  Else
    am.AddItem "Launch WMP", "mp9Launch"
  End If
    am.Back = "onAMRoot"
    am.NextState=2
    am.Update
End Sub

'----------------------------------------------
Sub mp9PlayPause()
  If (WMPCtrl.playstate=3) Then
    WMPCtrl.controls.pause
  Else
    WMPCtrl.controls.play
  End If
  mediaPlayer
End Sub
Sub mp9Stop()
  WMPCtrl.controls.stop
  mediaPlayer
End Sub
Sub mp9NextItem()
  WMPCtrl.controls.next
  enterMediaPlayer
End Sub
Sub mp9PrevItem()
  WMPCtrl.controls.previous
  enterMediaPlayer
End Sub

Sub mp9speed()
dim currentPlayRate
  If (WMPCtrl.settings.rate>=1) Then
  currentPlayRate = WMPCtrl.settings.rate*5
  Else
  currentPlayRate = WMPCtrl.settings.rate*10-5
  End If
  CurrentItem = "mp9rate"
  am.DlgPercent "Speed", "mp9SpeedChange", 10 , currentPlayRate
  am.Back = "enterMediaPlayer"
End Sub

Sub mp9SpeedChange(value, final)
  If (value>40) Then
    WMPCtrl.settings.rate = value*0.02
  Else
    WMPCtrl.settings.rate = value*0.01+0.5
  End If
  If final = 1 Then GotoMethod
End Sub

Sub mp9Fullscreen
  WMPplugin.Fullscreen
  mediaPlayer
End Sub

' let's use Showbar, NeededBars from winamp

Sub mp9enterSeek
dim curPos, h1,h2,m1,m2,s1,s2,title
  If (WMPplugin.Running) Then
    If (WMPCtrl.playState=2) or (WMPCtrl.playState=3) Then
      deleteTimers
      fma.AddTimer 1000, "mp9seekUpdate"
      CurrentItem = "mp9seek"
      NeededBars = (WMPCtrl.currentMedia.duration \ 60) + 1
      Showbar = (WMPCtrl.controls.currentPosition \ 60) + 1
      curPos = (WMPCtrl.controls.currentPosition - ((Showbar-1)*60))\10
      Pos = curPos
      If (curPos=0) and (Showbar>1) Then
        curPos = 6
        Showbar = Showbar-1
      End If

      h1 = WMPCtrl.controls.currentPosition \ 3600
      m1 = (WMPCtrl.controls.currentPosition-(3600*h1)) \ 60
      s1 = CInt(WMPCtrl.controls.currentPosition-(3600*h1)-(60*m1))
      h2 = WMPCtrl.currentMedia.duration \ 3600
      m2 = (WMPCtrl.currentMedia.duration-(3600*h2)) \ 60
      s2 = CInt(WMPCtrl.currentMedia.duration-(3600*h2)-(60*m2))
      If m1>=0 and m1<10 Then m1 = "0" & m1
      If s1>=0 and s1<10 Then s1 = "0" & s1
      If m2>=0 and m2<10 Then m2 = "0" & m2
      If s2>=0 and s2<10 Then s2 = "0" & s2

      If CInt(h2)>0 Then
        title = h1 &":"& m1 &":"& s1 &"/"& h2 &":"& m2 &":"& s2
      Else
        title = m1 &":"& s1 &" / "& m2 &":"& s2
      End If
      title = Left(title, 15)
      fma.debug title
      am.DlgPercent title, "mp9seek", 7 , curPos
      am.Back = "enterMediaPlayer"
    Else
      enterMediaPlayer
    End If
  Else
    enterMediaPlayer
  End If
End Sub

Sub mp9seekUpdate
dim curPos
  If (WMPplugin.Running)and(CurrentItem="mp9seek") Then
    curPos = (WMPCtrl.controls.currentPosition - ((Showbar-1)*60))\10
    If (curPos <> Pos)and((curPos <> 6)or(Cint(Right(CStr(CInt(WMPCtrl.controls.currentPosition)),1))=0)) Then mp9enterSeek
  Else
    deleteTimers
  End If
End Sub

Sub mp9seek(value, final)
  If (WMPplugin.Running) Then
    If (WMPCtrl.playState=2) or (WMPCtrl.playState=3) Then
      If final = 1 Then
        deleteTimers
        GotoMethod
      Else
        If (value=0)and(Showbar>1) Then
          WMPCtrl.controls.currentPosition = ((Showbar-1)*60) + Round(value*0.7, 0)
          mp9enterSeek
        ElseIf (value=100)and(Showbar<NeededBars) Then
          WMPCtrl.controls.currentPosition = ((Showbar-1)*60) + Round(value*0.7, 0)
          mp9enterSeek
        Else
          WMPCtrl.controls.currentPosition = ((Showbar-1)*60) + Round(value*0.7, 0)
          Pos = Round(value*0.7, 0) \ 10
        End If
      End If
    Else
      enterMediaPlayer
    End If
  Else
    enterMediaPlayer
  End If
End Sub

Sub mp9Playlists
  am.DlgFeedback "Loading...", "mediaPlayer"
  am.update
  mp9listPlaylists
End Sub

Sub mp9listPlaylists
dim i,j,k,s1,p
  p = Pos
  CurrentItem = "playlists"
  'fma.debug WMPCtrl.settings.mediaAccessRights
  j = WMPCtrl.playlistCollection.getAll.count
  If (j mod NrSongsOnPage<>0) Then k=j\NrSongsOnPage+1 Else k=j\NrSongsOnPage
  am.Clear
  If j<7 Then
    am.Title = Left("Playlists:" & j,15)
  Else
    am.Title = Left("Playlists " & p\NrSongsOnPage+1 & "/" & k,15)
  End If
  setItemPress("mp9PsClick")
  If j=0 Then
    am.AddItem "None available", "mediaPlayer"
  Else
    For i=0 to NrSongsOnPage-1
      If ( p+i < j) Then			'while there are still playlists to be shown
        s1 = Filter(WMPCtrl.playlistCollection.getAll.item(p+i).name)
        am.AddItem s1, "itemPress" & i
      Else					'no songs to be shonwn
        Exit For
      End If
    Next
  End If
    am.Back = "mediaPlayer"
    am.NextState=2
    am.Update
End Sub

Sub mp9PsClick(i)
  WMPCtrl.currentPlaylist = WMPCtrl.playlistCollection.getAll.item(Pos+i)
  enterMediaPlayer
End Sub

Public WMPplaylist
Public WMPsearchSt
Public WMPsearchType
Public WMPsearchSubS
WMPsearchSubS = FALSE

Sub mp9currPlaylist
dim i,j,k,s1,p
  am.DlgFeedback "Loading...", "mediaPlayer"
  am.update
  WMPsearchSubS = FALSE
  Set WMPplaylist = WMPCtrl.currentPlaylist
  mp9browsePlaylist
End Sub

Sub mp9browsePlaylist
dim i,j,k,s1,p
  p = Pos
  CurrentItem = "currPlaylist"
  j = WMPplaylist.count
  If (j mod NrSongsOnPage<>0) Then k=j\NrSongsOnPage+1 Else k=j\NrSongsOnPage
  am.Clear
  If j<=NrSongsOnPage Then
    am.Title = Left("Items: " & j,15)
  Else
    am.Title = Left("Items " & p\NrSongsOnPage+1 & "/" & k,15)
  End If
  setItemPress("mp9PClick")
  If j=0 Then
    If WMPsearchSubS Then
      am.AddItem "No matches found", "mediaPlayer"
    Else
      am.AddItem "No EXACT matches", "mediaPlayer"
      am.AddItem "Continue search for NON-exact matches", "mp9bySubStr"
    End If
  Else
    For i=0 to NrSongsOnPage-1
      If ( p+i < j) Then			'while there are still songs to be shown
        s1 = Filter(WMPplaylist.item(p+i).name)
        If (WMPplaylist.item(p+i).getItemInfo("Artist")<>"") Then
          s1 = s1 & " - " & Filter(WMPplaylist.item(p+i).getItemInfo("Artist"))
        End If
        am.AddItem s1, "itemPress" & i
      Else					'no songs to be shonwn
        Exit For
      End If
    Next
  End If
    am.Back = "mediaPlayer"
    am.NextState=2
    am.Update
End Sub

Sub mp9PClick(i)
  If (not (WMPCtrl.currentPlaylist.isIdentical(WMPplaylist))) Then
    WMPCtrl.currentPlaylist = WMPplaylist
  End If
  WMPCtrl.controls.currentItem = WMPplaylist.item(Pos+i)
  WMPCtrl.controls.play
  enterMediaPlayer
End Sub

Sub mp9LibrarySearch
  fma.DeleteTimer("mediaPlayerUpdate")
  WMPsearchSubS = FALSE
  CurrentItem = "mp9Search"
  Pos = 0
  am.Clear
  am.Title = "Search"
  am.AddItem "by Author", "mp9byAuthor"
  am.AddItem "by Title", "mp9byName"
  am.AddItem "by Album", "mp9byAlbum"
  am.AddItem "by Genre", "mp9byGenre"
  am.Back = "enterMediaPlayer"
  am.NextState=2
  am.Update
End Sub

Sub mp9byAuthor
  If (WMPplugin.Running) Then
    EnterTextBool = TRUE
    am.DlgInputStr "Search author","Author:",30,"","mp9Search1"
    am.NextState = 3
    am.Back = "mp9LibrarySearch"
  Else
    enterMediaPlayer
  End If
End Sub
Sub mp9byName
  If (WMPplugin.Running) Then
    EnterTextBool = TRUE
    am.DlgInputStr "Search item","Title:",30,"","mp9Search2"
    am.NextState = 3
    am.Back = "mp9LibrarySearch"
  Else
    enterMediaPlayer
  End If
End Sub
Sub mp9byAlbum
  If (WMPplugin.Running) Then
    EnterTextBool = TRUE
    am.DlgInputStr "Search album","Album:",30,"","mp9Search3"
    am.NextState = 3
    am.Back = "mp9LibrarySearch"
  Else
    enterMediaPlayer
  End If
End Sub
Sub mp9byGenre
  If (WMPplugin.Running) Then
    EnterTextBool = TRUE
    am.DlgInputStr "Search genre","Genre:",20,"","mp9Search4"
    am.NextState = 3
    am.Back = "mp9LibrarySearch"
  Else
    enterMediaPlayer
  End If
End Sub

Sub mp9bySubStr
  If (WMPplugin.Running) Then
    dim mItem,j,k
    WMPsearchSubS = TRUE
    am.DlgFeedback "Searching...", "mp9LibrarySearch"
    am.update
    Set WMPplaylist = WMPCtrl.mediaCollection.getAll
    k=0
    Do While k<WMPplaylist.count
      Set mItem = WMPplaylist.item(k)
      j = mItem.getItemInfo(WMPsearchType)
      If (InStr(1,j,WMPsearchSt,1)=0) or (InStr(1,j,WMPsearchSt,1)=Null) Then
        WMPplaylist.removeItem(mItem)
        k = k-1
      End If
      k = k+1
    Loop
    WMPplaylist.name = "'" & WMPsearchSt & "' search"
    mp9browsePlaylist
  Else
    enterMediaPlayer
  End If
End Sub

Sub mp9Search1(s)
  am.DlgFeedback "Searching...", "mp9LibrarySearch"
  am.update
  EnterTextBool = FALSE
  WMPsearchSt = s
  WMPsearchType = "Author"
  Set WMPplaylist = WMPCtrl.mediaCollection.getByAuthor(WMPsearchSt)
  mp9browsePlaylist
End Sub
Sub mp9Search2(s)
  am.DlgFeedback "Searching...", "mp9LibrarySearch"
  am.update
  EnterTextBool = FALSE
  WMPsearchSt = s
  WMPsearchType = "Title"
  Set WMPplaylist = WMPCtrl.mediaCollection.getByName(WMPsearchSt)
  mp9browsePlaylist
End Sub
Sub mp9Search3(s)
  am.DlgFeedback "Searching...", "mp9LibrarySearch"
  am.update
  EnterTextBool = FALSE
  WMPsearchSt = s
  WMPsearchType = "Album"
  Set WMPplaylist = WMPCtrl.mediaCollection.getByAlbum(WMPsearchSt)
  mp9browsePlaylist
End Sub
Sub mp9Search4(s)
  am.DlgFeedback "Searching...", "mp9LibrarySearch"
  am.update
  EnterTextBool = FALSE
  WMPsearchSt = s
  WMPsearchType = "Genre"
  Set WMPplaylist = WMPCtrl.mediaCollection.getByGenre(WMPsearchSt)
  mp9browsePlaylist
End Sub

Sub mp9Shuffle()
  WMPCtrl.settings.setMode "shuffle", not(WMPCtrl.settings.getMode("shuffle"))
  mediaPlayer
End Sub

Sub mp9Repeat()
  WMPCtrl.settings.setMode "loop", not (WMPCtrl.settings.getMode("loop"))
  mediaPlayer
End Sub

Sub mp9listJump(i)
dim j,k,l
  'fma.debug i
  EnterTextBool = TRUE
  If (i = 1) Then
    j = WMPCtrl.playlistCollection.getAll.count
    l = Pos\NrSongsOnPage+1
    If (j mod NrSongsOnPage<>0) Then k=j\NrSongsOnPage+1 Else k=j\NrSongsOnPage
    am.DlgInputInt "Jump to page", "Page (1 - " & k & "):", 1, k, l, "mp9list1"
  Else
    j = WMPplaylist.count
    l = Pos\NrSongsOnPage+1
    If (j mod NrSongsOnPage<>0) Then k=j\NrSongsOnPage+1 Else k=j\NrSongsOnPage
    am.DlgInputInt "Jump to page", "Page (1 - " & k & "):", 1, k, l, "mp9list2"
  End If
  am.NextState = 3
  If (i = 1) Then
    am.Back = "mp9listPlaylists"
  Else
    am.Back = "mp9browsePlaylist"
  End If
End Sub

Sub mp9list1(i)
  If (WMPplugin.Running) Then
    EnterTextBool = FALSE
    Pos = (i-1)*NrSongsOnPage
    mp9listPlaylists
  Else
    enterMediaPlayer
  End If
End Sub
Sub mp9list2(i)
  If (WMPplugin.Running) Then
    EnterTextBool = FALSE
    Pos = (i-1)*NrSongsOnPage
    mp9browsePlaylist
  Else
    enterMediaPlayer
  End If
End Sub

Sub mp9askEdit
  If (WMPCtrl.currentPlaylist.count>0) Then
    CurrentItem = "editItem"
    am.DlgYesNo "Edit current item?", "mp9edit1", 7
    am.NextState = 2
    am.Back = "enterMediaPlayer"
  End If
End Sub

Public editedMedia

Sub mp9edit1(r)
'  fma.debug r
  If (r=1) Then
    Set editedMedia = WMPCtrl.currentMedia
    am.DlgInputStr "Edit Item", "Author:", 40, Filter(WMPCtrl.currentMedia.getItemInfo("Author")), "mp9edit2"
    am.NextState = 2
    am.Back = "enterMediaPlayer"
  Else
    enterMediaPlayer
  End If
End Sub

Public NEWArtist
Public NEWTitle

Sub mp9edit2(s)
  NEWArtist = s
  am.DlgInputStr "Edit Item", "Title:", 35, Filter(WMPCtrl.currentMedia.getItemInfo("Title")), "mp9edit3"
  am.NextState = 3
  am.Back = "enterMediaPlayer"
End Sub

Sub mp9edit3(s)
  NEWTitle = s
  If (WMPplugin.Running) Then
    editedMedia.setItemInfo "Artist", NEWArtist
    editedMedia.setItemInfo "Title", NEWTitle
  End If
  enterMediaPlayer
End Sub

' TODO : perhaps volume (with volume keys)
' ------------------------------------------

Sub mp9Launch()
dim i
  If (WMPplugin.Running) Then
    enterMediaPlayer
  Else
    LaunchAppDlg
    WMPplugin.Open
    For i=1 to 8          'Tries 8 times each second if WMP is on
      fma.Sleep (1000)
      On Error Resume Next
      Set WMPplugin = CreateObject("WMPuICE.WMPApp")
      WMPCtrl = null
      Set WMPCtrl = WMPplugin.Core
      On Error GoTo 0
      If (not IsNull(WMPCtrl)) Then
        AppOpen = WMPplugin.Running
        fma.Sleep (100)
        Exit For
      End If
    Next
    If AppOpen Then
      Set WMPplugin = CreateObject("WMPuICE.WMPApp")    'without this lockups happended sometimes
      mediaPlayer
    Else
     am.DlgMsgBox "Application didn't respond...", 3
     onAMRoot
    End If
  End If
End Sub

Sub mp9Close()
  fma.DeleteTimer("mediaPlayerUpdate")
  If (WMPplugin.Running) Then
    CloseAppDlg
    WMPplugin.Close
    AppOpen = FALSE
  End If
  enterMediaPlayer
End Sub


'---------------------------- powerDVD 6.0 Control -------------------------
'id=3

Public FullBool
FullBool  = FALSE


Sub ToggleFullBool()
  FullBool = Not FullBool
  GotoMethod
End Sub

Sub enterPowerDVD()
  AppOpen = shell.AppActivate("PowerDVD")
  am.Clear
  powerDVD
End Sub

Sub powerDVD()
  enterAppMenu(3)

  If (AppOpen) Then
    am.AddItem "Play", "powerDVDPlay"
    am.AddItem "Pause", "powerDVDPause"
    am.AddItem "Stop", "powerDVDStop"

    If powerDVDChapterVar = "Chapter"  Then  am.AddItem "- BW/FW Chapter -", "powerDVDsetChapter"
    If powerDVDChapterVar = "Jump" Then am.AddItem "- BW/FW Jump -", "powerDVDsetChapter"
    If powerDVDChapterVar = "Speed" Then am.AddItem "- BW/FW Speed -", "powerDVDsetChapter"

    If (FullBool) Then
    am.AddItem "- FS Mode ON -" , "ToggleFullBool"
      Else  am.AddItem "- FS Mode OFF -" , "ToggleFullBool"
    End If

    If (MyPhoneType(1)=3) Then
      am.AddItem "Capture Frame", "powerDVDCapture"
    End If

    am.AddItem "Audio Stream", "powerDVDAudio"
    am.AddItem "Subtitles", "powerDVDSubtitle"
    am.AddItem "Mute/UnMute", "powerDVDVolMute"
    am.AddItem "Full Screen", "powerDVDFull"
    am.AddItem "Set repeat", "powerDVDRepeat"
    am.AddItem "Close PowerDVD", "powerDVDClose"
'    am.AddItem "Jump forward", "powerDVDJumpFF"
'    am.AddItem "Jump back", "powerDVDJumpBack"
'    am.AddItem "Fast forward", "powerDVDFF"
'    am.AddItem "Rewind", "PowerDVDRew"

  Else
    am.AddItem "Launch PowerDVD", "powerDVDLaunch"
  End If

  am.Back = "onAMRoot"
  am.NextState=2
  am.Update
End Sub

Sub powerDVDsetChapter()
  If powerDVDChapterVar = "Chapter" Then
  powerDVDChapterVar = "Speed"
  Else
  If powerDVDChapterVar = "Speed" Then
  powerDVDChapterVar = "Jump"
  Else
  If powerDVDChapterVar= "Jump" Then
  powerDVDChapterVar = "Chapter"
  End If
  End If
  End If
  gotoMethod
End Sub


Public powerDVDChapterVar	'Chapter or Jump or Speed
powerDVDChapterVar = "Chapter"

Sub powerDVDLaunch()
  LaunchAppDlg
' shell.Exec ProgramDir & "\RegionFree\RegionFree.exe" 'change this line
  shell.Exec RootEXE(3)
  AppOpen = TRUE
  powerDVD
End Sub
Sub powerDVDClose()
  CloseAppDlg
' If shell.AppActivate("RegionFree Window Title") Then shell.SendKeys("Closing Hotkey") 'change this line
  If shell.AppActivate("PowerDVD") Then shell.SendKeys("^x")
  AppOpen = FALSE
  powerDVD
End Sub

Sub powerDVDPlay()
    If (FullBool) Then
      shell.SendKeys("~")
    Else
      If shell.AppActivate("PowerDVD") Then shell.SendKeys("~")
    End If
  am.Update
End Sub
Sub powerDVDPause()
 If (FullBool) Then
   shell.SendKeys("{ }")
 Else
   If shell.AppActivate("PowerDVD") Then shell.SendKeys("{ }")
 End If
  am.Update
End Sub
Sub powerDVDStop()
 If (FullBool) Then
   shell.SendKeys("s")
 Else
  If shell.AppActivate("PowerDVD") Then shell.SendKeys("s")
 End If
  am.Update
End Sub
Sub powerDVDChapterPrev()
 If (FullBool) Then
   shell.SendKeys("p")
 Else
  If shell.AppActivate("PowerDVD") Then shell.SendKeys("p")
 End If
  am.Update
End Sub
Sub powerDVDChapterNext()
 If (FullBool) Then
   shell.SendKeys("n")
 Else
  If shell.AppActivate("PowerDVD") Then shell.SendKeys("n")
 End If
  am.Update
End Sub
Sub powerDVDSubtitle()
 If (FullBool) Then
   shell.SendKeys("u")
 Else
  If shell.AppActivate("PowerDVD") Then shell.SendKeys("u")
 End If
  am.Update
End Sub
Sub powerDVDRepeat()
 If (FullBool) Then
   shell.SendKeys("r")
 Else
  If shell.AppActivate("PowerDVD") Then shell.SendKeys("r")
 End If
  am.Update
End Sub
Sub powerDVDStepPrev()
 If (FullBool) Then
   shell.SendKeys("^b")
 Else
  If shell.AppActivate("PowerDVD") Then shell.SendKeys("^b")
 End If
 am.Update
End Sub
Sub powerDVDStepNext()
 If (FullBool) Then
   shell.SendKeys("t")
 Else
  If shell.AppActivate("PowerDVD") Then shell.SendKeys("t")
 End If
  am.Update
End Sub
Sub powerDVDCapture()
 If (FullBool) Then
   shell.SendKeys("c")
 Else
  If shell.AppActivate("PowerDVD") Then shell.SendKeys("c")
 End If
  am.Update
End Sub
Sub powerDVDAudio()
 If (FullBool) Then
   shell.SendKeys("h")
 Else
  If shell.AppActivate("PowerDVD") Then shell.SendKeys("h")
 End If
  am.Update
End Sub
Sub powerDVDVolMute()
 If (FullBool) Then
   shell.SendKeys("q")
 Else
  If shell.AppActivate("PowerDVD") Then shell.SendKeys("q")
  End If
  am.Update
End Sub
Sub powerDVDFull()
 If (FullBool) Then
   shell.SendKeys("z")
 Else
  If shell.AppActivate("PowerDVD") Then shell.SendKeys("z")
  End If
  am.Update
End Sub
Sub powerDVDMinimize()
 If (FullBool) Then
   shell.SendKeys("^n")
 Else
  If shell.AppActivate("PowerDVD") Then shell.SendKeys("^n")
 End If
  am.Update
End Sub
Sub PowerDVDJumpFF()
 If (FullBool) Then
   shell.SendKeys("{PgDn}")
 Else
  If shell.AppActivate("PowerDVD") Then shell.SendKeys("{PgDn}")
 End If
  am.Update
End Sub
Sub powerDVDJumpRew()
 If (FullBool) Then
   shell.SendKeys("{PgUp}")
 Else
  If shell.AppActivate("PowerDVD") Then shell.SendKeys("{PgUp}")
  End If
  am.Update
End Sub
Sub powerDVDFF()
 If (FullBool) Then
   shell.SendKeys("f")
 Else
  If shell.AppActivate("PowerDVD") Then shell.SendKeys("f")
 End if
  am.Update
End Sub
Sub PowerDVDRew()
 If (FullBool) Then
   shell.SendKeys("b")
 Else
  If shell.AppActivate("PowerDVD") Then shell.SendKeys("b")
 End if
  am.Update
End Sub

'---------------------------- Begin WinDVD ------------------------------------
'id=10


Sub enterWinDVD()
  AppOpen = shell.AppActivate("InterVideo WinDVD")
  am.Clear
  winDVD
End Sub

Sub winDVD
  enterAppMenu(10)

  If (AppOpen) Then
    am.AddItem "Play/Select", "winDVDPlay"
    am.AddItem "Pause", "winDVDPause"
    am.AddItem "Stop", "winDVDStop"

    If (ChapterBool) Then
      am.AddItem "- BW/FW Chapter -", "setChapter"
    Else
      am.AddItem "- BW/FF -", "setChapter"
    End If
    am.AddItem "Audio Stream", "winDVDAudio"
    am.AddItem "Subtitles", "winDVDSubtitle"
    am.AddItem "Mute/UnMute", "winDVDVolMute"
    am.AddItem "Full Screen", "winDVDFull"

    am.AddItem "Chapter", "winDVDChapter"
    am.AddItem "Playlist", "winDVDPlayList"

    am.AddItem "Speed Down", "winDVDSpeedDown"
    am.AddItem "Speed Up", "winDVDSpeedUp"

    am.AddItem "Step FW", "winDVDStepFW"
    am.AddItem "Step BW", "winDVDStepBW"

    am.AddItem "Main Menu", "winDVDMainMenu"
    am.AddItem "Go Up", "winDVDGoUp"
    am.AddItem "Go Down", "winDVDGoDown"
    am.AddItem "Go Left", "winDVDGoLeft"
    am.AddItem "Go Right", "winDVDGoRight"

    am.AddItem "Close", "winDVDClose"
  Else
    am.AddItem "Launch WinDVD", "winDVDLaunch"
  End If

  am.Back = "onAMRoot"
  am.NextState=2
  am.Update
End Sub

Public TempProg

Sub winDVDLaunch()
  'LaunchAppDlg
  TempProg = ProgramDir & "\InterVideo\DVD6\WinDVD.exe"
  shell.Exec TempProg
  AppOpen = TRUE
  winDVD
End Sub
Sub winDVDClose()
  CloseAppDlg
  If shell.AppActivate("InterVideo WinDVD") Then shell.SendKeys("x")
  AppOpen = FALSE
  winDVD
End Sub

Sub winDVDPlay
 if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys("~")
 am.Update
End Sub
Sub winDVDPause
 if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys("{ }")
 am.Update
End Sub
Sub winDVDAudio
 if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys("a")
 am.Update
End Sub
Sub winDVDChapter
 if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys("c")
 am.Update
End Sub
Sub winDVDFastForward
 if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys("f")
 am.Update
End Sub
Sub winDVDRewind
 if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys("r")
 am.Update
End Sub

Sub winDVDGoUp
 if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys("{UP}")
 am.Update
End Sub
Sub winDVDGoDown
 if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys("{DOWN}")
 am.Update
End Sub
Sub winDVDGoLeft
 if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys("{LEFT}")
 am.Update
End Sub
Sub winDVDGoRight
 if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys("{RIGHT}")
 am.Update
End Sub
Sub winDVDSelect
 If shell.AppActivate("InterVideo WinDVD") Then shell.SendKeys("~")
 am.Update
End Sub
Sub winDVDMainMenu
 if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys("^m")
 am.Update
End Sub

Sub winDVDSpeedDown
 if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys("^{LEFT}")
 am.Update
End Sub
Sub winDVDSpeedUp
 if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys("^{RIGHT}")
 am.Update
End Sub
Sub winDVDPlayList
 if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys("l")
 am.Update
End Sub
Sub winDVDStepFW
 if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys("n")
 am.Update
End Sub
Sub winDVDStepBW
 if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys("^n")
 am.Update
End Sub
Sub winDVDStop
 if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys("{END}")
 am.Update
End Sub
Sub winDVDPrev
 if shell.AppActivate("InterVideo WinDVD")then shell.SendKeys("{PGUP}")
 am.Update
End Sub
Sub winDVDNext
 if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys("{PGDN}")
 am.Update
End Sub
Sub winDVDSubtitle
 if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys("s")
 am.Update
End Sub
Sub winDVDVolMute
 if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys("m")
 am.Update
End Sub
Sub winDVDFull
 if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys("z")
 am.Update
End Sub

'------------------------------ End WinDVD ------------------------------------


'----------------------------- Begin iTunes -----------------------------------
'id=11

Sub enterITunes()
  AppOpen = shell.AppActivate("iTunes")
  am.Clear
  iTunes
End Sub

Sub iTunes
  enterAppMenu(11)

  If (AppOpen) Then
    am.AddItem "Play/Pause", "iTPlayPause"
    am.AddItem "Stop", "iTStop"
    am.AddItem "Vizualizer", "iTFullScreen"
    am.AddItem "Launch", "iTLaunch"
    am.AddItem "Close", "iTClose"
  Else
    am.AddItem "Launch iTunes", "iTunesLaunch"
  End If

  am.Back = "onAMRoot"
  am.NextState=2
  am.Update
End Sub

Sub iTunesLaunch()
  LaunchAppDlg
  shell.Exec RootEXE(11)
  AppOpen = TRUE
  iTunes
End Sub
Sub iTunesClose()
  CloseAppDlg
  If shell.AppActivate("iTunes") Then shell.SendKeys("%{F4}")
  AppOpen = FALSE
  iTunes
End Sub

Sub iTunesPlayPause
  if shell.AppActivate("iTunes") then shell.SendKeys(" ")
  am.Update
End Sub
Sub iTunesStop
  if shell.AppActivate("iTunes") then shell.SendKeys(" ")
  am.Update
End Sub
Sub iTunesPrev
  if shell.AppActivate("iTunes")then shell.SendKeys("^{LEFT}")
  am.Update
End Sub
Sub iTunesNext
  if shell.AppActivate("iTunes") then shell.SendKeys("^{RIGHT}")
  am.Update
End Sub
Sub iTunesFullScreen
  if shell.AppActivate("iTunes") then shell.SendKeys("^t")
  am.Update
End Sub


'------------------------------ End iTunes ------------------------------------


'---------------------------- PowerPoint Control ------------------------------
'id=7
Sub enterPowerPoint()
  am.Clear
  enterAppMenu(7)

  am.AddItem "Start Show", "ppStartShow"
  am.AddItem "Next Slide", "ppNext"
  am.AddItem "Prev Slide", "ppPrev"
  am.AddItem "Toggle Screen", "ppScreen"
  am.AddItem "End Show", "ppEndShow"

  am.Back = "onAMRoot"
  am.NextState=2
  am.Update
End Sub

Sub ppStartShow()
  If shell.AppActivate("Microsoft PowerPoint") Then shell.SendKeys("{F5}")
  am.Update
End Sub
Sub ppNext()
  shell.SendKeys("{DOWN}")
  am.Update
End Sub
Sub ppPrev()
  shell.SendKeys("{UP}")
  am.Update
End Sub
Sub ppScreen
	shell.SendKeys(".")
	am.Update
End Sub
Sub ppEndShow()
  shell.SendKeys("{ESC}")
  am.Update
End Sub


'---------------------------- Misc Control ------------------------------------
'id=8
Sub enterMiscControl()
  am.Clear
  enterAppMenu(8)

  am.Title = "Misc"
  am.AddItem "Lock PC", "lockWorkStation"
  am.AddItem "Disconnect ME", "disconnectME"
  am.AddItem "Shutdown Menu", "shutdownMenu"

  am.Back = "onAMRoot"
  am.NextState=2
  am.Update
End Sub

Sub lockWorkStation()
  shell.Exec "Rundll32.exe user32.dll,LockWorkStation"
  am.Title = "PC locked"
  am.NextState=2
  am.Update
End Sub
Sub disconnectME()
  fma.Disconnect
End Sub
Sub shutdownMenu()
  CurrentItem = "shutdownMenu"

  am.Clear
  am.Title = "Shutdown PC"
  am.AddItem "Monitor OFF", "monitorof"
  am.AddItem "Monitor ON", "monitoron"
  am.AddItem "Shutdown", "shutdown"
  am.AddItem "Hibernate", "hibernate"
  am.AddItem "Reboot", "reboot"
  If (ShutdownBool) Then am.AddItem "Cancel Shutdown", "cancelShutdown"

  am.Back = "enterMiscControl"
  am.NextState=2
  am.Update
End Sub

Public ShutdownBool
ShutdownBool = FALSE

Sub shutdown()
  ShutdownBool = TRUE
  am.Clear
  shell.Exec "shutdown -f -s -t 30"
  am.Title = "Shutdown.."
  am.AddItem center("Cancel reboot",""), "cancelShutdown"

  am.Back = "shutdownMenu"
  am.NextState=2
  am.Update
End Sub

Sub hibernate
	shell.Run "Rundll32.exe powrprof.dll,SetSuspendState"
End Sub

Sub reboot()
  ShutdownBool = TRUE
  am.Clear
  shell.Exec "shutdown -f -r -t 30"
  am.Title = "Reboot.."
  am.AddItem center("Cancel reboot",""), "cancelShutdown"

  am.Back = "shutdownMenu"
  am.NextState=2
  am.Update
End Sub
Sub cancelShutdown()
  ShutdownBool = FALSE

  am.Clear
  shell.Exec "shutdown.exe -a"
  am.Title = "Canceled"
  am.AddItem center("Shutdown Menu",""), "shutdownMenu"

  am.Back = "shutdownMenu"
  am.NextState=2
  am.Update
End Sub
Sub monitorof
 am.Clear
  shell.Exec fmadir & "\sframework\helper\moncloser 0"
  am.Title = "Monitor OFF"
   am.AddItem center("Back to shutdownMenu",""), "shutdownMenu"

  am.Back = "shutdownMenu"
  am.NextState=2
  am.Update
  End Sub
Sub monitoron
 am.Clear
  shell.Exec fmadir & "\sframework\helper\moncloser 1"
     am.Title = "Monitor ON"
   am.AddItem center("Back to shutdownMenu",""), "shutdownMenu"

  am.Back = "shutdownMenu"
  am.NextState=2
  am.Update
End Sub
'---------------------------- user-settings menu ------------------------------

Function checkBox(b)
  If (b) Then		'TRUE set checkbox
    checkBox = "[*] "
    Exit Function
  Else			'FALSE
    checkBox = "[" & Space(SpaceOption) & "] "
    Exit Function
  End If
End Function

Sub enterSettings()
  setGotoMethod("enterSettings")
  am.Clear
  settingsMain
End Sub


Sub settingsMain()
  CurrentID = "settings"
  CurrentItem = "menu"

  am.ClearMenu
  am.Title = "Main settings"

  If (SettingMuteOnCall = 0) Then
    am.AddItem checkBox(FALSE) & center("On call",""), "setMuteOnCall"
    am.AddItem center("Mute",""), "settingsMain"
  ElseIf (SettingMuteOnCall = 1) Then
    am.AddItem checkBox(TRUE) & center("On call",""), "setMuteOnCall"
    am.AddItem center("Mute",""), "settingsMain"
  ElseIf (SettingMuteOnCall = 2) Then
    am.AddItem checkBox(TRUE) & center("On call",""), "setMuteOnCall"
    am.AddItem center("Decrease vol: " & OnCallDecreaseValue & "%",""), "onCallVol"
  Else '3
    am.AddItem checkBox(TRUE) & center("On call",""), "setMuteOnCall"
    am.AddItem center("Pause Winamp",""), "settingsMain"
  End If
  am.AddItem "Playlist: " & NrSongsOnPage & " items per page", "setNrOfSongs"
  am.AddItem checkBox(SettingStartOnConnect) & "Auto start", "setStartOnConnect"
  am.AddItem checkBox(SaveSettingsBool) & "Save settings", "setSaveSettings"

  If (MyPhoneType(1)=1) Then
    am.AddItem center("[SE T610]",""), "setMyPhoneType"
  ElseIf (MyPhoneType(1)=2) Then
    am.AddItem center("[SE K700i]",""), "setMyPhoneType"
  ElseIf (MyPhoneType(1)=3) Then
    am.AddItem center("[SE T68i]",""), "setMyPhoneType"
  End If

  am.AddItem MenuItemExitMenu, "exitSettings"

  am.Back = "exitSettings"
  am.NextState=2
  am.Update
End Sub

Sub onCallVol()
  CurrentItem = "volumeslide"
  am.DlgPercent "Decrease with", "onCallVolEvent", 10 , OnCallDecreaseValue/10
  am.Back = "enterSettings"
End Sub

Sub onCallVolEvent(value, final)
  OnCallDecreaseValue = value
  If final = 1 Then enterSettings
End Sub

Sub exitSettings()
  If (SaveSettingsBool) Then
    saveSettings
  Else
    deleteSettings
  End If
  onAMRoot
End Sub

Sub addRootItem(id)
  addElement id, RootItems
End Sub


Sub setMuteOnCall()
  SettingMuteOnCall = (SettingMuteOnCall+1) Mod 4			'Mute on Call
  settingsMain
End Sub
Sub setNrOfSongs()
  EnterTextBool = TRUE
  am.DlgInputInt "Items/page", "Items (2-10):", 2, 10, 6, "setNrOfSongs2"
  am.NextState = 3
  am.Back = "settingsMain"
End Sub
Sub setNrOfSongs2(i)
  NrSongsOnPage = i
  settingsMain
End Sub
Sub setStartOnConnect()
  SettingStartOnConnect = Not SettingStartOnConnect
  settingsMain
End Sub
Sub setSaveSettings()
  SaveSettingsBool = Not SaveSettingsBool
  settingsMain
End Sub

Sub setMyPhoneType()
  If (MyPhoneType(1)=MyPhoneType(0)) Then MyPhoneType(1)=1 Else MyPhoneType(1)=MyPhoneType(1)+1
  setPhone
  settingsMain
End Sub

'------------------------------------ menu config ----------------------------------------

Sub orderRoot()
  enterOrderMenu RootItems, RootID
End Sub
Sub selectRoot()
  enterSelectMenu RootItems, RootID
End Sub

Sub enterSelectMenu(a1,a2)
  am.Clear
  CurrentID = "settings"
  CurrentItem = "select"

  TempArray = a1
  TempArray2 = a2
  selectMenu a1, a2
End Sub


Sub selectMenu(a1,a2) 		 'a1 contains a selection of sorted indexes from a2 which denotes all available items
  Dim i, b, e
  am.ClearMenu
  am.Title = "Menulist [1/2]"

  setItemPress("toggleOption")

  For i=0 To UBound(a2)		'all elements
    b = FALSE
    For Each e In a1		'sorted indexes
      If (a2(i,0)=e) Then
        b = TRUE
        Exit For
      End If
    Next
    am.AddItem checkBox(b) & a2(i,1), "itemPress" & i
  Next

  am.Back = "exitSettings"
  am.NextState=2
  am.Update
End Sub

Sub toggleOption(i) 'index in all available items
  Dim e
  If (elementOf(i,TempArray)) Then
    removeElement i, TempArray	'remove element from sorted TempArray
  Else
    addElement i, TempArray	'add element to sorted TempArray
  End If
  saveArray
  selectMenu TempArray, TempArray2
End Sub

Sub enterOrderMenu(a1,a2)
  CurrentID = "settings"
  CurrentItem = "order"

  TempArray = a1
  TempArray2 = a2

  SelectItem = 1		'set SelectItem to a proper value
  orderMenu a1
End Sub

Sub orderMenu(arr)		'arr contains selected sorted indexes of all available items in TempArray
  Dim i, limit
  am.Clear
  am.Selected = SelectItem
  limit = UBound(arr)

  If (limit = 0) Then
    am.Title = "No items"
    am.AddItem "Select items", "gotoSelect"
  ElseIf (limit = 1) Then		'too few
    am.Title = "Select more"
    am.AddItem "Select items", "gotoSelect"
  Else
    am.Title = "Set order [2/2]"

    setItemPress("moveItemUp")
    For i=0 To limit					'sorted selection menu-array
      am.AddItem TempArray2(arr(i),1), "itemPress" & i	'name
    Next
  End If

  am.Back = "exitSettings"
  am.NextState=2
  am.Update
End Sub

Sub moveItemUp(i)	'index in arr of which item to be moved  assumed i< ubound(TempArray = arr)
  Dim e
  					'TempArray set on enterOrderMenu
  If (i=0) Then				'1st item list
    e = TempArray(0)
    removeElementAt 0, TempArray	'first element
    addElement e, TempArray		'add to end
    SelectItem = UBound(TempArray)+1	'goto end of list
  Else					'not 1st item on list
    e = TempArray(i-1)
    TempArray(i-1) = TempArray(i)
    TempArray(i) = e
    SelectItem = i
  End If
  saveArray
  orderMenu TempArray
End Sub


'---------------------------- Mouse Control -----------------------------

Sub enterMouseControl
  EnterTextBool = FALSE
  am.NextState = 2

  am.DlgMsgBox "Mouse Control", 0
  EnableMouseControl = 1
End Sub

Sub enterText
  EnterTextBool = TRUE
  am.DlgInputStr "Input","Text:",40,"","enterTextEvent"
  am.NextState = 2
  am.Back = "enterMouseControl"
End Sub

Public EnterTextBool

Sub enterTextEvent(s)     'send entered string
  shell.SendKeys s
  enterMouseControl
End Sub

Sub mouseControlFinish    'end mouse control
  MouseCtrl.MouseStop
  EnableMouseControl = 0  'disable mouse control
  onAMRoot
End Sub

Sub mouseControlEvent(button, state)
  If state = 0 Then
    MouseCtrl.MouseStop
  ElseIf (Not EnterTextBool) Then
    Select Case button
      Case BackButton mouseControlFinish	'T610

      Case "<"  MouseCtrl.MouseMove("W")
      Case "^"  MouseCtrl.MouseMove("N")
      Case ">"  MouseCtrl.MouseMove("E")
      Case "v"  MouseCtrl.MouseMove("S")

      Case "s"  MouseCtrl.MouseLeftClick        't68i
      Case ":J" MouseCtrl.MouseLeftClick        'T610

      Case "*"  enterText
      Case "#"  shell.SendKeys("{enter}")
      Case "c"  shell.SendKeys("{backspace}")

      Case "["  MouseCtrl.MouseLeftClick	'T610
      Case "]"  MouseCtrl.MouseRightClick

      Case "5"  MouseCtrl.MouseLeftClick	't68i
      Case "0"  MouseCtrl.MouseRightClick

      Case "u"  MouseCtrl.MouseWhlUp
      Case "d"  MouseCtrl.MouseWhlDown

      Case "1"  MouseCtrl.MouseMove("NW")
      Case "2"  MouseCtrl.MouseMove("N")
      Case "3"  MouseCtrl.MouseMove("NE")
      Case "4"  MouseCtrl.MouseMove("W")
      Case "6"  MouseCtrl.MouseMove("E")
      Case "7"  MouseCtrl.MouseMove("SW")
      Case "8"  MouseCtrl.MouseMove("S")
      Case "9"  MouseCtrl.MouseMove("SE")
    End Select
  End If
End Sub

'------------------------ End Mouse Control -----------------------------
'------------------ FMA Menu calling from mainmenu ----------------------
Public remoteMenuEnter
Public remoteMenuExit

Sub remoteMenuStart
  'fma.debug "# start"
  remoteMenuEnter = FALSE
  remoteMenuExit = FALSE
  fma.AddTimer 2000, "remoteMenuTimer"
End Sub

Sub remoteMenuStop
  'fma.debug "# stop"
  remoteMenuExit = TRUE
  If (remoteMenuEnter) Then
    Transmit "AT*EAST=" & Chr(34) & "Fma Remote" & Chr(34)
    onAMRoot
  End If
End Sub

Sub remoteMenuTimer
  fma.DeleteTimer "remoteMenuTimer"
  If not remoteMenuExit Then
    remoteMenuEnter = TRUE
    Transmit "AT*EAST=" & Chr(34) & "FMA Remote" & Chr(34)
  End If
End Sub
'----------------- End FMA Menu calling from mainmenu ----------------------
'------------------------- keyevent procedures -----------------------------
' seems that there's a problem with recognizing released key, i had to workaround it //mhr

Public lastPressedKey

Sub OnKeyPress(button, state)				'state=1 :pressed    state=0 :released
'fma.debug CurrentID & ":" & CurrentItem
'fma.debug GotoMethodValue
'fma.debug button & " - " & state

  If state = 1 Then LastPressedKey = button
  fma.ClearKey
  If EnableMouseControl = 1 Then
    mouseControlEvent button, state
  ElseIf (EnableKeys) Then
    If (state = 1) Then
      Select Case button
        Case "u"
          deleteTimers
          volumeKeysEvent("u")
        Case "d"
          deleteTimers
          volumeKeysEvent("d")
        Case OptionButton
          optionKeyEvent
        Case Else					'no volume or option key pressed
          Select Case CurrentID
            Case RootID(0,0)        'wintv
              Select Case CurrentItem
                Case "menu"  WinTVKeyEvent button, state
                Case "channelList"  channelKeyEvent button, state
              End Select

            Case RootID(1,0)        'more tv
              Select Case CurrentItem
                Case "menu"  MoreTVKeyEvent button, state
                Case "channelList"  channelKeyEvent button, state
              End Select

            Case RootID(2,0)  winampKeyEvent button, state       'winamp
            Case RootID(3,0)  powerDVDKeyEvent button, state     'powerdvd
            Case RootID(4,0)  bsPlayerKeyEvent button, state     'bsplayer
            Case RootID(5,0)  mediaPlayerKeyEvent button, state  'mediaplayer
            Case RootID(10,0) winDVDKeyEvent button, state  'WinDVD
            Case RootID(11,0) iTunesKeyEvent button, state  'iTunes

            Case RootID(12,0)        'DScaler
              Select Case CurrentItem
                Case "menu"  DScalerKeyEvent button, state
                Case "channelList"  channelKeyEvent button, state
              End Select

            Case RootID(13,0) zoomPlayerKeyEvent button, state  'Zoom Player
            Case RootID(14,0)
              Select Case CurrentItem
                Case "browseOption"  exitBrowseOption
                Case Else            browseKeyEvent button, state
              End Select
            Case RootID(15,0) iexploreKeyEvent button, state  'iexplore
            Case RootID(16,0) RadLightKeyEvent button, state

            Case "settings"  settingsKeyEvent button, state
          End Select
      End Select
    End If
  ElseIf (button = "#")or(lastPressedKey = "#") Then
    Select Case state
      Case 1 remoteMenuStart
      Case 0 remoteMenuStop
    End Select
  End If
End Sub

Sub optionKeyEvent()        'option events
  Select Case CurrentID
    Case RootID(2,0)        'winamp
      Select Case CurrentItem
        Case "playlist"      'enter playlist options
           deleteTimers      'delete dynamic update timers
           playlistOptions
        Case "winampSearch"		'#########
        Case "searchInput"		'#########
        Case "select"  onAMRoot
        Case "order"   onAMRoot
        Case "songInfo"			'#########
        Case "songInfo2"		'#########
        Case "gotoSong"			'#########
        Case "simpleSearch"		'#########
        Case "playlistOptions"          PlayList LastArg1

        Case Else
          Select Case CurrentItem
            Case "options"  gotoMethod
            Case "selectPlaylist"
            Case Else            'enter general winamp options
              deleteTimers       'delete dynamic update timers
              enterWinampOptions
          End Select
      End Select

    Case RootID(5,0)
      Select Case CurrentItem
        Case "menu"   mp9askEdit
      End Select

    Case RootID(14,0)
      Select Case CurrentItem
        Case "browse"   browseOption
        Case "browseOption"  exitBrowseOption
      End Select

    Case "settings"
      Select Case CurrentItem
        Case "select"  onAMRoot
        Case "order"   onAMRoot
      End Select
    Case "onAMRoot"  gotoSelect
  End Select
End Sub

Sub gotoSelect                 'enter menuitems-selection
  setGotoMethod("gotoSelect")
  selectRoot
End Sub

Sub gotoOrder                  'enter menuitems-order
  setGotoMethod("gotoOrder")
  orderRoot
End Sub

Sub settingsKeyEvent(button, state)   'key events within select-order config menu
  Select Case CurrentItem
    Case "select"
      Select Case button
        Case ">"  gotoOrder
      End Select
    Case "order"
      Select Case button
        Case "<"  gotoSelect
      End Select
  End Select
End Sub

'id=14
Sub browseKeyEvent(button, state)
  If (CurrentItem <> "volumeslide") Then
  Select Case button
      Case "c"
        If (IsRoot) Then
      	  browseDrives
        Else
          browseUp
        End If
      Case ">"
        nextBrowse
      Case "<"
        prevBrowse
  End Select
  End If
End Sub

Sub volumeKeysEvent(s)
  Select Case CurrentID
    Case RootID(2,0)			'within winamp
      If (CurrentItem <> "volumeslide") Then  winampSlideVol
    Case RootID(15,0)			'internet explorer
      If (AppOpen) and (CurrentItem <> "volumeslide") and (s="u") Then
        IEtabB
      ElseIf (AppOpen) and (CurrentItem <> "volumeslide") and (s="d") Then
        IEtabF
      End If
    Case Else					'not in winamp
      If (CurrentItem <> "volumeslide") Then  masterVol
  End Select
End Sub


'---------------- apps key events -------------------
'id=0
Sub WinTVKeyEvent(button, state)
  Select Case CurrentItem
    Case "menu"
      Select Case button
        Case ">"  winTVChannelUp
        Case "<"  winTVChannelDown
        Case CameraButton winTVSnapShot
      End Select
  End Select
End Sub

'id=1
Sub MoreTVKeyEvent(button, state)
  Select Case CurrentItem
    Case "menu"
      Select Case button
        Case ">"  moreTVChannelUp
        Case "<"  moreTVChannelDown
      End Select
  End Select
End Sub

'id=12
Sub DScalerKeyEvent(button, state)
  Select Case CurrentItem
    Case "menu"
      Select Case button
        Case ">"  dScalerChannelUp
        Case "<"  dScalerChannelDown
        Case CameraButton dScalerSnapShot
      End Select
  End Select
End Sub

Sub channelKeyEvent(button, state)       'channel events (tv programs)
  Select Case button
    Case "0"  channel0
    Case "1"  channel1
    Case "2"  channel2
    Case "3"  channel3
    Case "4"  channel4
    Case "5"  channel5
    Case "6"  channel6
    Case "7"  channel7
    Case "8"  channel8
    Case "9"  channel9
  End Select
End Sub

'id=3
Sub powerDVDKeyEvent(button, state)
  Select Case CurrentItem
    Case "menu"
      Select Case button
        Case ">"
          If powerDVDChapterVar = "Chapter" Then
          powerDVDChapterNext
          Else
          If powerDVDChapterVar = "Step" Then
          powerDVDStepNext
          Else
          If powerDVDChapterVar = "Jump" Then
          powerDVDJumpFF
          Else
          If powerDVDChapterVar = "Speed" Then
          PowerDVDFF
          End If
          End If
          End If
          End If
        Case "<"
        If powerDVDChapterVar = "Chapter" Then
          powerDVDChapterPrev
          Else
          If powerDVDChapterVar = "Step" Then
          powerDVDStepPrev
          Else
          If powerDVDChapterVar = "Jump" Then
          powerDVDJumpRew
          Else
          If powerDVDChapterVar = "Speed" Then
          PowerDVDRew
          End If
          End If
          End If
          End If
      End Select
  End Select
End Sub

'id=4
Sub bsPlayerKeyEvent(button, state)
  Select Case CurrentItem
    Case "menu"
      Select Case button
        Case ">"  bsPlayerNext
        Case "<"  bsPlayerPrev
      End Select
   End Select
End Sub

'id=5
Sub mediaPlayerKeyEvent(button, state)
dim j
  Select Case CurrentItem
    Case "menu"
      Select Case button
        Case ">"  mp9NextItem
        Case "<"  mp9PrevItem
        Case Else
      End Select
    Case "playlists"
      Select Case button
        Case ">"
          If (Pos+NrSongsOnPage>=WMPCtrl.playlistCollection.getAll.count) Then
            Pos = 0
          Else
            Pos = Pos + NrSongsOnPage
          End If
          mp9listPlaylists
        Case "<"
          If (Pos-NrSongsOnPage<0) Then
            Pos = ((WMPCtrl.playlistCollection.getAll.count-1)\NrSongsOnPage)*NrSongsOnPage
          Else
            Pos = Pos - NrSongsOnPage
          End If
          mp9listPlaylists
        Case "#"
          j = WMPCtrl.playlistCollection.getAll.count	' doesnt work, i have no idea why //mhr
          If (j>NrSongsOnPage) Then
            mp9listJump 1
          End If
        Case Else
      End Select
    Case "currPlaylist"
      Select Case button
        Case ">"
          If (Pos+NrSongsOnPage>=WMPplaylist.count) Then
            Pos = 0
          Else
            Pos = Pos + NrSongsOnPage
          End If
          mp9browsePlaylist
        Case "<"
          If (Pos-NrSongsOnPage<0) Then
            Pos = ((WMPplaylist.count-1)\NrSongsOnPage)*NrSongsOnPage
          Else
            Pos = Pos - NrSongsOnPage
          End If
          mp9browsePlaylist
        Case "#"
          j = WMPplaylist.count		' doesnt work, i have no idea why //mhr
          If (j>NrSongsOnPage) Then
            mp9listJump 2
          End If
        Case Else
      End Select
  End Select
End Sub

'id=13
Sub zoomPlayerKeyEvent(button, state)
  Select Case CurrentItem
    Case "menu"
      Select Case button
        Case ">"  zoomPlayerNext
        Case "<"  zoomPlayerPrev
        Case Else
      End Select
  End Select
End Sub

'id=16
Sub RadLightKeyEvent(button, state)
  Select Case CurrentItem
    Case "menu"
      Select Case button
        Case ">"  RadLightNext
        Case "<"  RadLightPrev
		Case Else
      End Select
  End Select
End Sub

'id=2
Sub winampKeyEvent(button, state)     'winamp key events
  Select Case CurrentItem
    Case "menu"
      Select Case button
        Case ">"  winampNextSong
        Case "<"  winampPrevSong
        Case Else
      End Select

    Case "playlist"
      Select Case button
        Case ">"  nextPlayList
        Case "<"  prevPlayList
        Case Else
        If (SimpleSearchOn) Then
          Select Case button
            Case "#"   nextSearch
            Case "*"   prevSearch
          End Select
        End If
      End Select

    Case "selectPlaylist"
      Select Case button
        Case ">"  nextBrowse
        Case "<"  prevBrowse
      End Select
    Case "songInfo"
      Select Case button
        Case ">"  songInfo2
        Case "<"  songInfo2
      End Select

    Case "songInfo2"
      Select Case button
        Case ">"  songInfo LastArg1
        Case "<"  songInfo LastArg1
      End Select
    Case "searchInput"
      If (button = BackButton) Then winampSearch
    Case "simpleSearch"
      If (button = BackButton) Then playlistOptions
    Case "gotoSong"
      If (button = BackButton) Then playlistOptions
    Case "artistResults"
      Select Case button
        Case ">"  nextArtists
        Case "<"  prevArtists
      End Select
    Case "allArtists"
      Select Case button
        Case ">"  nextArtists
        Case "<"  prevArtists
      End Select
  End Select
End Sub

'id=10
Sub winDVDKeyEvent(button, state)
  Select Case CurrentItem
    Case "menu"
      Select Case button
        Case ">"
          If (ChapterBool) Then
            winDVDNext
          Else
            winDVDFastForward
          End If
        Case "<"
          If (ChapterBool) Then
            winDVDPrev
          Else
            winDVDRewind
          End If
      End Select
  End Select
End Sub

'id=11
Sub iTunesKeyEvent(button, state)
  Select Case CurrentItem
    Case "menu"
      Select Case button
        Case ">"
          iTNext
        Case "<"
          iTPrev
      End Select
  End Select
End Sub

'id=15
Sub iexploreKeyEvent(button, state)
  Select Case CurrentItem
    Case "menu"
      Select Case button
        Case ">"
          If (not EnterTextBool) Then IEforward
        Case "<"
          If (not EnterTextBool) Then IEback
        Case "*"
          If (not EnterTextBool) Then EnterTextIE3
        Case "#"
          If (not EnterTextBool) Then
            shell.AppActivate("Microsoft Internet Explorer")
            shell.SendKeys "{ENTER}"
            enterExplorer
          End If
      End Select
  End Select
End Sub

'---------------------------- read and save file functions --------------------

Sub saveSettings()
  Dim id

  Set File = Fso.OpenTextFile(SettingsFile,2,True)	'2nd argument = forwriting = 2
  File.WriteLine ScriptVersion
  File.WriteLine MyPhoneType(1)

  File.WriteLine NrSongsOnPage
  File.WriteLine SettingMuteOnCall
  File.WriteLine OnCallDecreaseValue
  File.WriteLine SettingStartOnConnect

  For each id in RootItems
    File.WriteLine id
  Next

  File.WriteLine "EOF"

  File.Close
End Sub

Sub deleteSettings()
    If (Fso.FileExists(SettingsFile)) Then
      Set File = Fso.GetFile(SettingsFile)
      File.Delete
    End If
End Sub

Sub readSettings()
  Dim i, temp, dummy, compatible
  compatible = "3.5"

  If (Fso.FileExists(SettingsFile)) Then
    Set File = Fso.OpenTextFile(SettingsFile, 1)	'1 = forreading
    temp = CStr(File.ReadLine)

    If(ScriptVersion <> temp) and (compatible <> temp) Then	'1st line in settings file denotes version of config file
      File.Close
      deleteSettings
    Else
      SaveSettingsBool = True
      MyPhoneType(1) = CInt(File.ReadLine)

      NrSongsOnPage = CInt(File.ReadLine)
      SettingMuteOnCall = CInt(File.ReadLine)
      OnCallDecreaseValue = CInt(File.ReadLine)
      SettingStartOnConnect = File.ReadLine

      ReDim RootItems(0)

      temp = File.ReadLine
      If (temp <> "EOF") Then
        While (temp <> "EOF")
          addRootItem(CInt(temp))
          temp = File.ReadLine
        Wend
      End If
      File.Close

      setPhone
    End If
  End If
End Sub

Sub saveArray			'needed for saving temparray to root array
  Dim limit, i

  limit = UBound(TempArray)
  ReDim RootItems(limit)
  For i=0 To limit
    RootItems(i) = TempArray(i)
  Next
End Sub


'---------------------------- End Active Menu ---------------------------------

'------------ begin camera ------------------------

Public WebcamStream

Sub OnTakeSinglePicture
  WebcamStream = FALSE
  OnTakeSinglePicture2
End Sub

Sub OnTakeSinglePicture2
 If fma.Connected = 1 Then
   TakePicture
 Else
   fma.Debug "Webcam - Not Connected to Phone"
 End If
End Sub

Sub OnStartWebcam
 If fma.Connected = 1 Then
   ' check if new can take picture on every 2 seconds
   ' (wait for previous call to finish)
   OnStopWebcam
   WebcamStream = FALSE
   fma.AddTimer 2000, "OnTakeSinglePicture2"
 Else
   MsgBox "Webcam - Not Connected to Phone"
 End If
End Sub

Sub OnStartWebcamStream
 If fma.Connected = 1 Then
   ' check if new can take picture on every 2 seconds
   ' (wait for previous call to finish)
   OnStopWebcam
   WebcamStream = TRUE
   fma.AddTimer 2000, "OnTakeSinglePicture2"
 Else
   MsgBox "Webcam - Not Connected to Phone"
 End If
End Sub

Sub OnStopWebcam
 fma.DeleteTimer "OnTakeSinglePicture2"
End Sub

Sub TakePicture
 Dim OutputFile
 If fma.Connected = 1 Then
   fma.Debug "Webcam - Picturing..."

   If (MyPhoneType(1)=1) Then
'code for T610
     Transmit "at+clck=""CS"",0" ' Unlock phone
     fma.Sleep (1000)
     Transmit "AT+CKPD="":C""" ' Enter camera mode
     fma.Sleep (1000)
     Transmit "AT+CKPD="":C""" ' Take picture
'end code for T610
   ElseIf (MyPhoneType(1)=2) Then
'code for k700
     Transmit "at+CKPD=""*"""  ' press * and ] after it to unlock
     fma.Sleep (500)
     Transmit "at+CKPD=""]"""
     fma.Sleep (500)
     Transmit "AT+CKPD="":C"",10"
     fma.Sleep (2000)
     Transmit "at+CKPD=""5""" ' turn the light on
     fma.Sleep (500)
     Transmit "AT+CKPD="":C""" ' Take picture
'end code for k700
   End If

   If (WebcamStream) Then
     OutputFile = "c:\SE_Webcam.jpg"
   Else
     ' create filename here to get the (more or less) exact time & date of the picture
     Outputfile = OutputDirectory & Year(Date) & "-" & LeadZero(Month(Date)) & "-" & LeadZero(Day(Date)) & "_" & LeadZero(Hour (time)) & "-" & LeadZero(Minute (time)) & "-" & LeadZero(Second (time)) & ".jpg"
   End If

   If (MyPhoneType(1)=1) Then
'code for T610
     fma.Sleep (8000) 'old 9000
     Transmit "AT+CKPD="":C""" ' Save picture
     fma.Sleep (4000) 'old 5000
     Transmit "AT+CKPD="":R""" ' Return to main menu
     fma.Sleep (1000)
     Transmit "AT+CKPD="":R"""
'end code for T610
   ElseIf (MyPhoneType(1)=2) Then
'code for k700
     fma.Sleep (5000)
     Transmit "AT+CKPD="":R"",10" ' Return to standby mode
     fma.Sleep (1500)
     Transmit "at+CKPD=""*"""  ' press * and ] after it to lock
     fma.Sleep (500)
     Transmit "at+CKPD=""]"""
     fma.Sleep (500)
'end code for k700
   End If

   fma.ObexCut outputfile, filename
   fma.Debug "Webcam - Picture taken"
 End If
End Sub


'------------ end camera ------------------------

Function LeadZero(ByVal N)
  if (N>=0) and (N<10) then LeadZero = "0" & N else LeadZero = "" & N
End Function

'---------------------------- Internet Explorer ------------------------------------
'id=15
Sub enterExplorer()
  EnterTextBool = FALSE
  AppOpen = shell.AppActivate("Microsoft Internet Explorer")
  am.Clear
  iexplore
End Sub

Sub iexplore
  enterAppMenu(15)

  If (AppOpen) Then
    am.AddItem "Homepage", "IEhome"
    am.AddItem "Enter address", "enterIEadd"
    am.AddItem "<< Back", "IEback"
    am.AddItem ">> Forward", "IEforward"
    am.AddItem "Send e-mail", "sendMail1"
    am.AddItem "Close IE", "IEclose"
  Else
    am.AddItem "Launch IE", "launchIE"
    am.AddItem "Enter address", "enterIEadd2"
    am.AddItem "Send e-mail", "sendMail1"
  End If

  am.Back = "onAMRoot"
  am.NextState=2
  am.Update
End Sub

Sub launchIE()
  LaunchAppDlg
  shell.Exec RootEXE(15)
  AppOpen = TRUE
  iexplore
End Sub

Public EmailAdd
Public EmailSubj
Public EmailBody

Sub sendMail1()
  EnterTextBool = TRUE
  am.DlgInputStr "Enter address","Address:",30,"","sendMail2"
  am.NextState = 2
  am.Back = "enterExplorer"
End Sub

Sub sendMail2(s)
  EmailAdd = s
  am.Clear
  am.DlgInputStr "Enter subject","Subject:",35,"","sendMail3"
  am.NextState = 3
  am.Back = "enterExplorer"
End Sub

Sub sendMail3(s)
  EmailSubj = Replace(s," ", "%20")
  am.Clear
  am.DlgInputStr "Enter text","Text:",100,"","sendMailDlg"
  am.NextState = 4
  am.Back = "enterExplorer"
End Sub

Sub sendMailDlg(s)
  dim text1,text2,text3,text
  EmailBody = Replace(s," ", "%20")
  am.clear
  am.Title = "Preparing"
  am.AddItem "Cancel", "onAMRoot"
  am.DlgFeedBack "Preparing ...","onAMRoot"
  text1 = "mailto:" & EmailAdd
  text2 = "?subject=" & EmailSubj
  text3 = "&body=" & EmailBody
  text = text1 & text2 & text3
  Shell.Run "RunDLL32.EXE shell32.dll,ShellExec_RunDLL " & text
  fma.Sleep (2000)
  EnterTextBool = FALSE
  sendMailSubMenu
End Sub

Sub sendMailSubMenu
  am.Clear
  am.Title = "E-mail"
  am.AddItem "Send e-mail", "sendMail"
  am.AddItem "Cancel", "sendMailClose"
  am.Back = "sendMailClose"
  am.NextState=2
  am.Update
End Sub

Sub sendMail
  shell.SendKeys "%s"
  enterExplorer
End Sub

Sub sendMailClose
  shell.SendKeys "%{F4}"
  enterExplorer
End Sub

Sub IEclose()
  CloseAppDlg
  If shell.AppActivate("Microsoft Internet Explorer") Then shell.SendKeys("%{F4}")
  AppOpen = FALSE
  iexplore
End Sub

Sub IEhome
  shell.AppActivate("Microsoft Internet Explorer")
  shell.SendKeys "%{HOME}"
  am.Update
End Sub

Sub IEback
  shell.AppActivate("Microsoft Internet Explorer")
  shell.SendKeys "%{LEFT}"
  am.Update
End Sub

Sub IEforward
  shell.AppActivate("Microsoft Internet Explorer")
  shell.SendKeys "%{RIGHT}"
  am.Update
End Sub

Sub IEtabF
  shell.AppActivate("Microsoft Internet Explorer")
  shell.SendKeys "{TAB}"
  am.Update
End Sub
Sub IEtabB
  shell.AppActivate("Microsoft Internet Explorer")
  shell.SendKeys "+{TAB}"
  am.Update
End Sub

Sub enterIEadd
  EnterTextBool = TRUE
  am.DlgInputStr "Enter address","Address:",40,"","enterTextIE"
  am.NextState = 2
  am.Back = "enterExplorer"
End Sub

Sub enterIEadd2
  EnterTextBool = TRUE
  am.DlgInputStr "Enter address","Address:",40,"","enterTextIE2"
  am.NextState = 2
  am.Back = "enterExplorer"
End Sub

Sub enterTextIE(s)     'send entered string
  shell.AppActivate("Microsoft Internet Explorer")
  shell.SendKeys "%D"
  shell.SendKeys s
  shell.SendKeys "{ENTER}"
  enterExplorer
End Sub

Sub enterTextIE2(s)     'send entered string
  Shell.Run "RunDLL32.EXE url.dll, FileProtocolHandler " & s
  enterExplorer
End Sub

Sub enterTextIE3
  EnterTextBool = TRUE
  am.DlgInputStr "Input","Text:",50,"","enterTextIE4"
  am.NextState = 2
  am.Back = "enterExplorer"
End Sub

Sub enterTextIE4(s)     'send entered string
  shell.AppActivate("Microsoft Internet Explorer")
  shell.SendKeys s
  enterExplorer
End Sub

'----------------------------- Locate Phone -----------------------------------

Sub OnLocatePhone
  Dim cmd
  If fma.Connected = 1 Then
    LocatePhoneNow
  Else
    fma.Debug "Locate cannot work - Not Connected to Phone"
  End If
End Sub

Sub LocatePhoneNow
  Dim cmd
  If fma.Connected = 1 Then
  fma.Debug "Locating phone..."

  If (MyPhoneType(1)=1) Then
    cmd = "AT+CKPD="":R""" ' Return to main menu (just in case)
    Transmit cmd
    cmd = "AT+CKPD="":R"""
    Transmit cmd
    cmd = "AT+CKPD="":R"""
    Transmit cmd
    cmd = "at+clck=""CS"",0" ' Unlock phone
    Transmit cmd
    cmd = "AT+CKPD="":J""" ' Open menu
    Transmit cmd
    cmd = "AT+CKPD=""7""" ' Open Pictures & Sounds submenu
    Transmit cmd
    cmd = "AT+CKPD=""3""" ' Open Sounds menu
    Transmit cmd
    cmd = "AT+CKPD=""^""" ' Go to first sound at bottom
    Transmit cmd
    cmd = "AT+CKPD="":J""" ' Play sound
    Transmit cmd
    fma.Sleep (15000) ' Change this for play length (default 15000 - 15secs)
    cmd = "AT+CKPD="":R""" ' Return to main menu
    Transmit cmd
    cmd = "AT+CKPD="":R"""
    Transmit cmd
    cmd = "AT+CKPD="":R"""
    Transmit cmd
  ElseIf (MyPhoneType(1)=2) Then
    Transmit "AT+CKPD="":R""" ' Return to main menu
    fma.Sleep (600)
    Transmit "AT+CKPD="":R"""
    fma.Sleep (600)
    Transmit "AT+CKPD="":R"""
    fma.Sleep (600)
    Transmit "at+CKPD=""*"""  ' press * and ] after it to unlock
    fma.Sleep (600)
    Transmit "at+CKPD=""]"""
    fma.Sleep (600)
    Transmit "AT+CKPD="":J""" ' Open menu
    fma.Sleep (600)
    Transmit "AT+CKPD=""7""" ' Open Pictures & Sounds submenu
    fma.Sleep (600)
    Transmit "AT+CKPD=""2""" ' Open Sounds menu
    fma.Sleep (600)
    Transmit "AT+CKPD=""^""" ' Go to first sound at bottom
    fma.Sleep (600)
    Transmit "AT+CKPD="":J""" ' Play sound
    fma.Sleep (15000) ' Change this for play length (default 15000 - 15secs)
    Transmit "AT+CKPD="":R""" ' Return to main menu
    fma.Sleep (600)
    Transmit "AT+CKPD="":R"""
    fma.Sleep (600)
    Transmit "AT+CKPD="":R"""
  ElseIf (MyPhoneType(1)=3) Then
    cmd = "AT+CKPD=""e""" ' Return to main menu (just in case)
    Transmit cmd
    fma.Sleep (400)
    Transmit cmd
    fma.Sleep (400)
    Transmit cmd
    fma.Sleep (400)
    cmd = "at+clck=""CS"",0" ' Unlock phone
    Transmit cmd
    fma.Sleep (400)
    cmd = "AT+CKPD="">""" ' Open menu
    Transmit cmd
    fma.Sleep (400)
    cmd = "AT+CKPD=""4""" ' Open Pictures & Sounds submenu
    Transmit cmd
    fma.Sleep (400)
    cmd = "AT+CKPD=""4""" ' Open Sounds menu
    Transmit cmd
    fma.Sleep (400)
    cmd = "AT+CKPD=""^""" ' Go to first sound at bottom
    Transmit cmd
    fma.Sleep (15000) ' Change this for play length (default 15000 - 15secs)
    cmd = "AT+CKPD=""e""" ' Return to main menu
    Transmit cmd
    fma.Sleep (400)
    Transmit cmd
    fma.Sleep (400)
    Transmit cmd
  End If
  fma.Debug "Phone located"
  End If
End Sub

'--------------------------- End Locate Phone ---------------------------------


'------------------------ Begin MS Agent Speech ---------------------------------
' SpeechSay by skyw33
' Here's a function for having MS Agent speak anything you give it
' Just specify where your agent character file is.
'
' *** THIS IS WORK IN PROGRESS!!! ***
'
' I posted the MS Agent Script a while back. The only way I've gotten it to work is
' to "run" a separate, stand-alone script from within the fma script that contains
' the instructions to launch Agent. So far, the things I've found that run in stand-alone
' mode but don't run from within fma are this and the wscript.sleep function.

Sub SpeechSay(SpeechText)
  On Error Resume Next
  Set AgentControl = CreateObject("Agent.Control.1")
  If IsObject(AgentControl) Then
    AgentControl.Connected = True
    Dim floyd
    On Error Resume Next
    'edit here - specify where your agent character file is
    AgentControl.Characters.Load "floyd", "C:\WINDOWS\MSAGENT\CHARS\floyd.ACS"
    Set floyd = AgentControl.Characters ("floyd")
    floyd.Get "state", "Showing"
    floyd.Get "state", "Speaking"
    floyd.MoveTo 200, 200
    floyd.Show
    floyd.Get "state", "Moving"
    floyd.Speak (SpeechText)
    floyd.Hide
    'unload objects
    Set floyd = nothing
    Set AgentControl = nothing
  End If
End Sub

'--------------------------- End MS Agent Speech ---------------------------------

