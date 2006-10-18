Option Explicit
' ------------ CarpediWebMouse.vbs version 1.4b (see below for real number) -------------

' :: Requirements ::

'       * FMA build "0.1.0.31e" ar later
'       * Microsoft Script Control engine

' :: TODO ::

'       * Split PowerDVD 4 and 5 menu into several submenus

' :: Credits ::

'       * Compiled by Dako - SEND ANY UPDATES TO ME (see 'Contacts' for details)
'       * iTunes support by daveo
'       * WinDVD5 control by skyw33
'       * WinDVD4 control by rwt
'       * Webcam support (T610) by HRS
'       * Mouse Control by Vit Ondruch
'       * Media Player, PowerDVD, PowerPoint optimizations by jbngar
'       * Locate Phone by nossenigma
'       * Speech Text by skyw33
'       * Shutdown menu by CarpeDi3m

' :: Contacts ::

'       * original script created by CarpeDi3m <CarpeDi3m1687 AT hotmail.com>
'       * send any cool scripts to Dako <z_stoichev AT users.sourceforge.net>
'         if you want to share them with all FMA users.

' :: Supported Features ::

'       * iTunes
'         - Play/Pause
'         - Stop
'         - Prev Track
'         - Next Track
'         - Vizualizer
'         - Launch/Close

'	* Hauppauge WinTV
'	  - remote mode (enter numbers)
'	  - mute toggle
'	  - fullscreen toggle
'	  - prev/next channel
'	  - freeze image
'	  - make snapshot
'	  - launch/close WinTV

'	* MoreTV
'	  - remote mode (enter numbers)
'	  - mute toggle
'	  - fullscreen toggle
'	  - prev/next channel
'	  - freeze image
'	  - make snapshot
'	  - launch/close WinTV


'	* WinAmp 2 and 5 (only with WinampComLib.dll v1.1 plugin)    [NO WINAMP 3.X SUPPORT!!!]
'	  - playlist ( + song info )
'	  - standard play functions ( play, pause, prev/next track )
'	  - volume (slide control)
'	  - seek ( slide control Still buggy!!)
'	  - options ( shuffle on/off, repeat on/off)
'	  - file launcher (*new*)
'	  - launch/close Winamp

'	* PowerDVD
'	  - standard play functions ( play, pause, stop, prev/next chapter, step backward/forward )
'	  - capture frame
'	  - audiostream toggle
'	  - subtitle toggle
'	  - volume (+/- 5)
'	  - mute toggle
'	  - fullscreen toggle
'	  - set repeat points
'	  - launch/close PowerDVD

'       * WinDVD
'         - Play/Select
'         - Pause
'         - Stop
'         - Prev Chapter
'         - Next Chapter
'         - Go Up/Down
'         - Subtitles
'         - Volume Up
'         - Volume Down
'         - Mute toggle
'         - Full Screen
'         - Speed Down
'         - Speed Up
'         - Fast Forward
'         - Rewind
'         - Launch/Close

'       * ZoomPlayer
'         - Play/Pause
'         - Stop
'         - Prev Chapter
'         - Next Chapter
'         - Jump ahead
'         - Jump back
'         - Subtitles
'         - Volume Up
'         - Volume Down
'         - Mute/UnMute
'         - Full Screen
'         - Fast Forward
'         - Rewind
'         - Launch/Close

'	* BSPlayer
'	  - standard play functions ( play, pause, stop, prev, next, )
'	  - fullscreen toggle
'	  - subtitle on/off
'	  - zoom
'	  - launch/close BSPlayer

'	* Media Player 9
'	  - standard play functions ( play, pause, prev/next track )
'	  - fullscreen toggle
'	  - launch/close Media Player 9

'	* Volume Control
'	  - mute toggle
'	  - master volume control
'	  - show current master volume level

'	* PowerPoint
'	  - start show
'	  - next slide
'	  - prev slide
'	  - end show


'	* Custom MenuSettings
'	  - selection of menu items
'	  - sorting of menu items
'	  - selection of phone [t610/t68i]		(default: t610)
'	  - option to save settings in a config-file (default: off)


'       * PC Mouse Control
'         - move
'         - left/right click
'         - wheel up/down

'       * PC Volume Control
'         - volume up/down
'         - mute toggle

' :: Implementation ::

'************ Change these settings as needed *************
' look also in Sub OnConnected (below) for more settings
'**********************************************************

Sub setDefault
  ScriptVersion		= "1.4b"	'current script version for tracking config file

  SaveSettingsBool 	= FALSE		'default saving setting
  SettingBackOption 	= FALSE		'default back menu-item

  T610Enabled 		= TRUE		'default selected phone on T610
  selectPhone				'load values for selected phone

  initID				'setting ID's and default menu-items
  setDefaultMenuItemsArray
End Sub

Sub setDefaultMenuItemsArray
  addElement(WinampID)			'default Menu-items listed as shown in current order
  addElement(PowerDVDID)
  addElement(WinDVD5ID)
  addElement(WinDVD4ID)
  addElement(ZoomPlayerID)
  addElement(iTunesID)
  addElement(BSPlayerID)
  addElement(MediaPlayerID)
  addElement(WinTVID)
  addElement(MoreTVID)
  addElement(VolumeControlID)
  addElement(MouseControlID)
  addElement(PowerPointID)
  addElement(MiscControlID)
  addElement(MsAgentID)
End Sub

Sub initID				'setting variables with application ID's
  WinTVID = "WinTV"
  MoreTVID = "More TV"
  WinampID = "Winamp"
  PowerDVDID = "PowerDVD"
  WinDVD5ID = "InterVideo WinDVD 5"
  WinDVD4ID = "InterVideo WinDVD 4"
  ZoomPlayerID = "ZoomPlayer"
  iTunesID = "iTunes"
  BSPlayerID = "BSPlayer"
  MediaPlayerID = "Media Player"
  VolumeControlID = "Volume Control"
  MouseControlID = "Mouse Control"
  PowerPointID = "PowerPoint"
  MiscControlID = "Misc Control"
  MsAgentID = "Ms Agent"
End Sub

Sub selectPhone
  If (T610Enabled) Then					'T610
    ScreenWidth		= 111				'usable screenwidth
    SpaceOption		= 3
 
    MenuItemExitMenu	= "      [ exit menu ]"
    MenuItemBack	= "  <<<<  ( back )  >>>>"
    MenuItemPrevSongs	= "===  prev songs  ==="
    MenuItemNextSongs	= "===  next songs  ==="
    MenuItemNext	= " <<<<< ( next ) >>>>>"
    MenuItemPrev	= " <<<<< ( prev ) >>>>>"
  Else							'T68i
    ScreenWidth		= 94				'usable screenwidth
    SpaceOption		= 2
 
    MenuItemExitMenu	= "   <<< ( exit ) >>>"
    MenuItemBack	= " <<< ( back ) >>>"
    MenuItemPrevSongs	= " ==  prev songs  =="
    MenuItemNextSongs	= "==   next songs   =="
    MenuItemNext	= "   <<< ( next ) >>>"
    MenuItemPrev	= "   <<< ( prev ) >>>"
  End If
  selectPixelArrays
End Sub


'***********************************************************
Dim T610Enabled			'Boolean phone selection: true = t610 | false = t68i

Dim ScreenWidth			'phone dependable screen width
Dim SpaceOption

Dim MenuItemExitMenu		'interface text
Dim MenuItemBack
Dim MenuItemNextSongs
Dim MenuItemPrevSongs
Dim MenuItemNext
Dim MenuItemPrev

Dim ScriptVersion
Dim SelectItem

Dim WinampState, WinampDir, WinampTitle
Dim FLNbreFilesPage, FLCurDir, FLNumPage, FLNbrePage, FLTabFile(), FLNbreFile	'file launch variables

Dim MouseControlActive

Dim Fso, File			'file read and write variables
Dim SettingsFile
Dim ForReading
Dim ForWriting

Dim SaveSettingsBool
Dim SettingBackOption


Dim VolumeCtrl			'objects
Dim MouseCtrl
Dim WinampCtrl
Dim WinampVol
Dim Shell

Dim WinTVOpen			'open app flags
Dim MoreTVOpen
Dim WinampOpen
Dim PowerDVDOpen
Dim BSPlayerOpen
Dim ZoomPlayerOpen
Dim MediaPlayerOpen
Dim PPTOpen

Dim WinTVEXE			'Variables of application executables
Dim MoreTVEXE
Dim WinampEXE
Dim PowerDVDEXE
Dim BSPlayerEXE
Dim PPTExe
Dim ZoomPlayerExe

Dim BSPlayerZoom

ReDim ArrID(0)			'Array of application ID's 	note: ArrID(0) is empty and not used for implementing reasons
Dim iTunesID
Dim WinTVID
Dim MoreTVID
Dim WinampID
Dim PowerDVDID
Dim WinDVD5ID
Dim WinDVD4ID
Dim ZoomPlayerID
Dim BSPlayerID
Dim MediaPlayerID
Dim VolumeControlID
Dim MouseControlID
Dim PowerPointID
Dim MiscControlID
Dim MsAgentID

' "T610 as a webcam". Copyright (c) 2004 HRS.

' this script remotely triggers the camera of the T610,
' transfers the taken picture on the local pc and
' deletes it from the camera.

' path and filename of the picture on the camera
Dim filename

' output directory for the transferred files on the local pc
' terminating backslash required
Dim outputdirectory

Sub OnInit
  'Reapply settings (usualy after editing the script inside FMA)
  OnDisconnected
  OnConnected

  'Add main menu options
  fma.AddCmd "How to build your own scripts?", "OnFMAScriptHowto"
  fma.AddCmd "-", ""
  fma.AddCmd "Start Webcam mode", "OnStartWebcam"
  fma.AddCmd "Stop Webcam mode", "OnStopWebcam"
  fma.AddCmd "-", ""
  fma.AddCmd "Take a picture", "OnTakeSinglePicture"
  fma.AddCmd "-", ""
  fma.AddCmd "Locate the phone", "OnLocatePhone"
End Sub

sub OnFMAScriptHowto
' Set shell = CreateObject("WScript.Shell")
  shell.Run "IExplore.exe http://fma.sourceforge.net/resources/docs/scripts_sdk.htm"
end sub

Sub OnConnected
  ReDim ArrID(0)

  ForReading = 1
  ForWriting = 2

  ' PLEASE, LOCALIZE filename PATH AND FILENAME !!!
  filename = "/Pictures/Image(1).jpg"
  outputdirectory = "C:\"

  'OnConnected is called in offline mode from OnInit
  'so we should take care of this
  If fma.Connected = 1 Then
     am.Init 							'Initialize the Accessories Menu
     am.DlgMsgBox "Connected to floAt's Mobile Agent", 2
  Else
     am.Clear
  End If
  
  Set Shell = CreateObject("WScript.Shell")
  Set Fso = CreateObject("Scripting.FileSystemObject")		'FileSystemObject created for reading and writing files

  Set VolumeCtrl = CreateObject("floAtMediaCtrl.VolumeCtrl")
  Set MouseCtrl = CreateObject("floAtMediaCtrl.MouseCtrl")
  Set WinampCtrl = CreateObject("WinampCOMLib.WinampCOMObj")
  
' -------------------------- added by CarpeDi3m1687----------------------------


'*********** Change these settings as required ************

  SettingsFile = "C:\CarpeDi3m1687.sav"		'file-location for saving user-settings

  ' WinAmp
  WinampTitle = "Winamp 5.07"
  WinampDir = "C:\Program Files\Winamp5"    'Location of WinAmp.exe
  FLCurDir  = "C:\Program Files\Winamp5"    'Location of m3u playlists
  WinampCtrl.PathExe = WinampDir	           'Winamp 2x	directory-path
  WinampEXE = "C:\Progra~1\Winamp5\winamp.exe" 'Winamp 2x	exe-path

  ' Other Apps
  WinTVEXE = "C:\Progra~1\WinTV\WinTV2K.EXE"			'WinTV		exe-path
  MoreTVEXE = "C:\Progra~1\MoreTV.353\MoreTV.exe"		'MoreTV		exe-path
  PowerDVDEXE = "C:\Progra~1\CyberLink\PowerDVD\PowerDVD.EXE"	'PowerDVD	exe-path
  BSPlayerEXE = "C:\Progra~1\BSPlayer\bplay.exe"		'BSPlayer	exe-path
  PPTExe = "C:\Progra~1\Micros~1\Office11\PowerPnt.exe"		'PowerPoint	exe-path ('office11' = office 2003)
  ZoomPlayerExe = "C:\Progra~1\ZoomPl~1\zplayer.exe"		'Zoom Player	exe-path

'***********************************************************

  setDefault			'set default user settings
  readSettings			'read stored user settings (if config file is available)
  
  BSPlayerZoom = 1

  WinampVol = 128
  WinampCtrl.SetVolume = WinampVol

' -------------------------- added by CarpeDi3m1687----------------------------

  If fma.Connected = 1 Then
     Transmit "AT*EAST=" + Chr(34) + "Fma Remote" + Chr(34)
  End If

  MouseControlActive = 0

End Sub

Sub OnDisconnected
  Set Shell = Nothing
  Set Fso = Nothing			' is this one needed????
  Set VolumeCtrl = Nothing
  Set MouseCtrl = Nothing
  Set WinampCtrl = Nothing
End Sub

Sub OnMusicMute(Start)
  If Start = 1 Then
    WinampState = WinampCtrl.GetSongState
    If WinampState = "playing" Then
      WinampCtrl.Pause
    End If
  Else
    If WinampState = "playing" Then
      WinampCtrl.Pause
    End If
  End If
End Sub


'Active Menu Start ---------------------------------------------------------
'onAMRoot will be called when Connection/Extra->Accessories->FMA is selected
'Something that's not shown here is am.Back = "Event", will call procedure
'specified rather than go back to the previous menu


Sub OnAMRoot
  am.Clear
  If (T610Enabled) Then
   am.Title = "T610 control"
  Else
   am.Title = "T68i control"
  End If

  setRootMenuItems

  am.AddItem center("[ Settings ]"), "onAMSettings"
  am.AddItem center("[ about ]"), "about"

  am.Update
End Sub

Sub about
  Dim title, text, text2, text3, text4, text5
  title = "about"
  
  If (T610Enabled) Then
    text1 = "   CarpediWebMouse   "
    text2 = Space(38)
    text3 = Space(38)
    text4 = "     Version " & ScriptVersion
    text5 = ""
  Else
    text1 = "  CarpediWebMouse  "
    text2 = Space(34)
    text3 = Space(34)
    text4 = "    Version " & ScriptVersion
    text5 = ""
  End If

  text = text1 & text2 & text3 & text4 & text5

  am.back = "OnAMRoot"
  DlgInformation title, text
End Sub


'-------------------Winamp Control (made by CarpeDi3m1687 version 2.0a)---------

Dim Pos

Dim Arr10, Arr9, Arr8, Arr7, Arr6, Arr5, Arr4, Arr3, Arr2, Arr1	'pixelArrays sorted by common and


Sub selectPixelArrays
  If (T610Enabled) Then
    Arr1=Array("")
    Arr2=Array("i","l",".",",","!","'","I","|",":",";","_"," ")
    Arr3=Array("j","(",")","[","]")
    Arr4=Array("f","r","t","{","}","-")
    Arr5=Array("c","s","z","Z","/","1","<",">","=")
    Arr6=Array("a","b","d","e","g","h","k","n","o","p","q","u","x","y","A","B","C","D","E","F","G","H","J","K","L","O","P","R","S","T","U","Y","?","^","$","+","0","2","3","4","5","6","7","8","9")
    Arr7=Array("v","N","Q","V","X","&","0")
    Arr8=Array("@","%")
    Arr9=Array("M")
    Arr10=Array("m","w","W")
  Else
    Arr1=Array("i","I","l","!",".","'","|")
    Arr2=Array(" ","f","j","t","(",")",":",",","[","]",";")
    Arr3=Array("r","-","/","{","}")
    Arr4=Array("c","k","s","x","z","J","_")
    Arr5=Array("a","e","o","u","y","b","d","g","h","n","p","q","v","E","B","F","L","S","T","Z","*","0","1","2","3","4","5","6","7","8","9","?","&","^","+","=","<",">")
    Arr6=Array("O","U","C","D","G","H","K","N","P","R","Q","~")
    Arr7=Array("m","w","A","M","Y","V","X","M","%")
    Arr8=Array("@","#")
    Arr9=Array("W")
    Arr10=Array("")
  End If
End Sub


'------------------ winamp main menu ----------------------

Sub onAMWinamp
  WinampOpen = shell.AppActivate(WinampTitle)
  am.Clear
  winampMenu 
End Sub

Sub winampMenu
  am.ClearMenu
  am.Title = WinampTitle

  If(SelectItem>0) Then
    am.Selected = SelectItem 
    SelectItem = 0
  End If

  If (WinampOpen) Then
     am.AddItem "PlayList", "onAMPlayList"
     am.AddItem "Play", "onWinampPlay"
     am.AddItem "Pause", "onWinampPause"
     am.AddItem "Prev Track", "onWinampPrevTrack"
     am.AddItem "Next Track", "onWinampNextTrack"
     am.AddItem "Volume", "onWinampSlideVol"
     am.AddItem "Seek (buggy)", "enterSlide"
     am.AddItem "Album", "FileLauncherDir"
     am.AddItem "Options", "onAMWinampOptions"
     am.AddItem "Close Winamp", "OnWinampClose"
  Else
    am.AddItem "Launch Winamp", "OnWinampLaunch"
  End If
  If (SettingBackOption) Then am.AddItem MenuItemBack, "onAMRoot"

  am.Back = "onAMRoot"
  am.Update
End Sub

Sub onWinampLaunch
  shell.Run WinampEXE
  WinampOpen = TRUE
  winampMenu 
End Sub

Sub onWinampClose
  shell.SendKeys("%{F4}")
  WinampOpen = FALSE
  winampMenu 
End Sub

Sub onWinampPlay
  WinampCtrl.Play
  am.Update
End Sub

Sub onWinampPause
  WinampCtrl.Pause
  am.Update
End Sub

Sub onWinampPrevTrack
  WinampCtrl.PreviousTrack
  am.Update
End Sub

Sub onWinampNextTrack
  WinampCtrl.NextTrack
  am.Update
End Sub

sub FileLauncherDir
 dim fol
 dim fi,f
 Set fol = Fso.GetFolder(FLCurDir)
 Set fi = fol.Files
 FLNbreFilesPage = 6

 FLNbreFile = fol.Files.Count
 FLNbrePage = Int(FLNbreFile / FLNbreFilesPage) + 1
 If FLNbreFile Mod FLNbreFilesPage = 0 Then FLNbrePage = FLNbrePage - 1
 FLNumPage = 0

 ReDim FLTabFile(FLNbreFile,2)

 Dim cpt
 cpt = 0

 For Each f In fi
  FLTabFile(cpt, 0) = f.Name
  FLTabFile(cpt, 1) = f.ShortPath
  cpt = cpt + 1
 Next
 Set fol = Nothing
 Set fi = Nothing
 FLNumPage = 0
 FileLauncherPage
end sub

sub FileLauncherPage
 dim inc,a
 inc = FLNumPage * FLNbreFilesPage

 am.Clear
 am.Title = "Files (" & (FLNumPage + 1) & "/" & FLNbrePage & ")"

 am.AddItem "---- Prev page ----", "FileLauncherPageup"

 if FLNumPage + 1 <> FLNbrePage then
  for a = 0 to (FLNbreFilesPage - 1)
  'am.AddItem PrepareText(FLTabFile(inc + a, 0)), "FileLauncherLoad" & a
   am.AddItem FLTabFile(inc + a, 0), "FileLauncherLoad" & a
  next
 else
  for a = 0 to (FLNbreFile - inc) - 1
  'am.AddItem PrepareText(FLTabFile(inc + a, 0)), "FileLauncherLoad" & a
   am.AddItem FLTabFile(inc + a, 0), "FileLauncherLoad" & a
  next
 end if
 am.AddItem "---- Next page ----", "FileLauncherPagedown"
 am.Back = "onAMWinamp"
 am.Update
end sub

sub FileLauncherPageup
 if FLNumPage = 0 then
  FLNumPage = FLNbrePage - 1
 else
  FLNumPage = FLNumPage -1
 end if
 FileLauncherPage
end sub

sub FileLauncherPagedown
 if FLNumPage = FLNbrePage - 1 then
  FLNumPage = 0
 else
  FLNumPage = FLNumPage + 1
 end if
 FileLauncherPage
end sub

sub FileLauncherLoad0
 dim width
 width = 5
 shell.run FLTabFile( (FLNumPage * FLNbreFilesPage) , 1 )

 fma.sleep (5000)
 onAMPlayList
 am.Update
end sub

sub FileLauncherLoad1
 dim width
 width = 5
 shell.run FLTabFile( ((FLNumPage * FLNbreFilesPage) + 1) , 1)

 fma.sleep (5000)
 onAMPlayList
 am.Update
end sub

sub FileLauncherLoad2
 dim width
 width = 5
 shell.run FLTabFile( ((FLNumPage * FLNbreFilesPage) + 2) , 1)

 fma.sleep (5000)
 onAMPlayList
 am.Update
end sub

sub FileLauncherLoad3
 dim width
 width = 5
 shell.run FLTabFile( ((FLNumPage * FLNbreFilesPage) + 3) , 1)

 fma.sleep (5000)
 onAMPlayList
 am.Update
end sub

sub FileLauncherLoad4
 dim width
 width = 5
 shell.run FLTabFile( ((FLNumPage * FLNbreFilesPage) + 4) , 1)

 fma.sleep (5000)
 onAMPlayList
 am.Update
end sub

sub FileLauncherLoad5
 dim width
 width = 5
 shell.run FLTabFile( ((FLNumPage * FLNbreFilesPage) + 5) , 1)

 fma.sleep (5000)
 onAMPlayList
 am.Update
end sub

sub FileLauncherLoad6
 dim width
 width = 5
 shell.run FLTabFile( ((FLNumPage * FLNbreFilesPage) + 6) , 1)

 fma.sleep (5000)
 onAMPlayList
 am.Update
end sub

'------------------ playlist ------------------------------

Sub onAMPlayList
  If (WinampCtrl.GetPlayListLength > 0) Then			'Playlist is not empty
    Pos = WinampCtrl.GetPlayListPosition - 1
    WinampCtrl.GetPlayList				'add to speeed up
    playList(Pos)
  End If
  am.Update
End Sub

Sub playList(p)
  Dim Show, Length

  am.Clear
  am.Title = "Playlist: " & CStr(p+1)


  Pos = p								'var needed to pass to functions: prevSongs, nextSongs, playSongs(1..9) 

  'WinampCtrl.GetPlayList						'remove to speed up remove only if no adding or removing songs during playlist use (2000+ songs
  Length = WinampCtrl.GetPlayListLength
  Show = Length - p							'songs to be shown, remaining songs

  If (p > 0) Then am.AddItem MenuItemPrevSongs, "prevSongs"		'if first song of playlist is not shown

  If (Show > 0) Then am.AddItem getSong(p), "playSong1"
  If (Show > 1) Then am.AddItem getSong(p+1), "playSong2"
  If (Show > 2) Then am.AddItem getSong(p+2), "playSong3"
  If (Show > 3) Then am.AddItem getSong(p+3), "playSong4"
  If (Show > 4) Then am.AddItem getSong(p+4), "playSong5"
  If (Show > 5) Then am.AddItem getSong(p+5), "playSong6"
  If (Show > 6) Then am.AddItem getSong(p+6), "playSong7"
  If (Show > 7) Then am.AddItem getSong(p+7), "playSong8"

  If ( (Show>8 and p=0) Or (Show=9) ) Then am.AddItem getSong(p+8), "playSong9"

  If (Length=10 and p=0) Then
    am.AddItem getSong(p+9), "playSong10"
  ElseIf (Show > 9) Then					'Length <> 10
    am.AddItem MenuItemNextSongs, "nextSongs"		'if there are more then 10 remaining songs
  End If

  am.Back = "onAMWinamp"
  am.Update
End Sub

Sub prevSongs
  Pos = Pos-8				'back 8 songs   what if there are 18 songs? and Show =9
  If (Pos<2) Then Pos = 0

  playList(Pos)				'Show new playlist with song# (Pos) as top of the list
End Sub


Sub nextSongs
  If (Pos = 0) Then	'forward 9 songs if at beginning of list
    Pos=Pos+9
  Else
    Pos=Pos+8		'forward 8 songs if not at beginning of list
  End If
  playList(Pos)		'Show new playlist with song# (Pos) as top of the list
End Sub


Sub playSong1		'clicked on song-event
  playSong(Pos)		'play song being shown on top (Pos = value top song)
End Sub

Sub playSong2		'clicked on song-event
  playSong(Pos+1)	'play song being shown on top as 2nd   (Pos = value top song) + 1 offset
End Sub

Sub playSong3
  playSong(Pos+2)
End Sub

Sub playSong4
  playSong(Pos+3)
End Sub

Sub playSong5
  playSong(Pos+4)
End Sub

Sub playSong6
  playSong(Pos+5)
End Sub

Sub playSong7
  playSong(Pos+6)
End Sub

Sub playSong8
  playSong(Pos+7)
End Sub

Sub playSong9
  playSong(Pos+8)
End Sub

Sub playSong10
  playSong(Pos+9)
End Sub


Sub playSong(i)											'function called by clicked on song events song
  If ( (WinampCtrl.GetSongState = "playing") And (WinampCtrl.GetPlayListPosition-1 = i) ) Then	'clicked on a song that is being played then show song info
    songInfo(i)
  Else												'if song is not being played
    WinampCtrl.PlaySongByPosition(i)							 	'then play song and
    playList(i)											'show playlist with song# i at top of list
  End If
End Sub



Function getSong(p)				'return songtitle of song p
  Dim i ,limit ,Str ,s ,size, width, mark
  Width = ScreenWidth-13			'width available pixels t610:112 t68i = 94

  s = filter(WinampCtrl.GetSongTitlebyPosition(p))
  s = replace(s,"( ","(")		'reading songs with " char causes lockup
  s = replace(s," )",")")		'reading songs with " char causes lockup
  s = replace(s,"[ ","[")		'reading songs with " char causes lockup
  Str = replace(s," ]","]")		'reading songs with " char causes lockup

  limit = Len(str)

  If (WinampCtrl.GetPlayListPosition-1 = p) Then	'if P is current song being played
    mark = ">"						'mark song
  Else
    mark = "  "
  End If

  For i=1 to limit					'for part to determine last char that fits onto screen
    size = size + pixelsOf(Mid(str,i,1))

    If (size > width) Then
      getSong = mark & Left(str,i-1)
      Exit Function
    End If
  Next

  getSong = mark & str
End Function


Function filter(str)				'filters a String
  Dim s, i, i2
  s = Trim(Str)
  
'  i = InStr(1, s, "XTINF", 1)
'  If (i = 1) Then				'files without id3 tags and not able to extract song - artist from fileName
'    i2 = InStr(1, s, ",", 1) + 1
'    filter = Mid(s, i2)
'    Exit Function
'  End If

  filter = replace(s,Chr(34),"''")		'reading songs with " char causes lockup

  
  
End Function



'------------------ Playlist ------------------------------


'------------------ String Pixels calculation -------------

Function strPix(str)				'return #pixels needed to display string
  Dim i, limit, size
  limit = Len(str)
  For i=1 to limit
    size = size + pixelsOf(Mid(str,i,1))
  Next
  strPix = size
End Function

Function strPix2(str,max)			'return #pixels needed to display string and 
  Dim i, limit, size
  limit = Len(str)
  For i=1 to limit
    size = size + pixelsOf(Mid(str,i,1))

    If (size > max) Then			'return -1 if max value is passed (overflow)
      strPix2 = -1
      Exit Function
    End If

  Next
  strPix2 = size
End Function

Function pixelsOf(c)				'return #pixels needed to display a character
  If elementOf(c,Arr5) Then
    pixelsOf = 6				'Arr5 is filled with elements that takes 5 pixels + 1 blank pixel
  ElseIf elementOf(c,Arr2) Then
    pixelsOf = 3
  ElseIf elementOf(c,Arr1) Then
    pixelsOf = 2
  ElseIf elementOf(c,Arr4) Then
    pixelsOf = 5
  ElseIf elementOf(c,Arr6) Then
    pixelsOf = 7
  ElseIf elementOf(c,Arr7) Then
    pixelsOf = 8
  ElseIf elementOf(c,Arr10) Then
    pixelsOf = 11
  ElseIf elementOf(c,Arr9) Then
    pixelsOf = 10
  ElseIf elementOf(c,Arr8) Then
    pixelsOf = 9
  ElseIf elementOf(c,Arr3) Then
    pixelsOf = 4
  Else
    pixelsOf = 7
  End If
End Function

Function elementOf(c,arr)	'determines whether 'c' is element of Array
  Dim e

  For each e in arr
    If (c = e) Then
      elementOf = TRUE
      Exit Function
    End If
  Next

  elementOf = FALSE
End Function

'------------------ String Pixels calculation -------------


'------------------ songInfo ------------------------------

Sub songInfo(i)							'show song info of song# i
  Dim arrSong, arrArtist, tempArr
  Dim artist, song, track, length, line1, line2, line3, line4, line5, line6, line7

  WinampCtrl.SetLengthParseTime = TRUE				'sets return of WinampCtrl.GetSongLength to (h:m:s)

  song = Filter(WinampCtrl.GetSongTitleByPosition(i))

  artist = Filter(WinampCtrl.GetArtistByPosition(i))

  track = " [ " & WinampCtrl.GetPlayListPosition & " of " & WinampCtrl.GetPlayListLength & " ] "
  length = " ( " & WinampCtrl.GetSongLength & " ) "
  
  arrSong = splitString(song)
  arrArtist = splitString(artist)


  line1 = center2(track)
  line2 = center(arrSong(0))
  line3 = center(arrSong(1))
  line4 = center("-")
  line5 = center(arrArtist(0))
  line6 = center(arrArtist(1))

  If (arrSong(1) = "") Then
    If (arrArtist(1) = "") Then
      line3 = line2
      line2 = ""

    ElseIf ( strPix2(arrArtist(1),ScreenWidth) = -1 ) Then
      tempArr = splitString(arrArtist(1))

      line3 = line4
      line4 = line5
      line5 = center(tempArr(0))
      line6 = center(tempArr(1))
    End If

  ElseIf ( (strPix2(arrSong(1),ScreenWidth) = -1) And (arrArtist(1) = "") ) Then
    tempArr = splitString(arrSong(1))

    line6 = line5
    line5 = line4
    line3 = center(tempArr(0))
    line4 = center(tempArr(1))
  End If

  line7 = center2(length)
  
  If (T610Enabled) Then
    boxT610 "Song Info" ,line1 ,line2 ,line3 ,line4 ,line5 ,line6 ,line7
  Else
    boxT68i "Song Info" ,line1 ,line2 ,line3 ,line4 ,line5 ,line6 ,line7
  End If

  am.Back = "onAMPlayList"
  am.Update
End Sub


Function splitString(s)		'split string into two parts and return an Array with 2 elements (#chars of first element <= width)
  Dim s1 ,s2 ,size ,lw ,words, break, temps

  If (strPix2(s,ScreenWidth) <> -1) Then		'count pixs of string with maximum of screenwidth
    splitString = Array(s,"")

  Else					'string larger then screenwidth pixs
    break = FALSE
    words = split(s)

    For each w in words
      If (break) Then			'build up string 2
        s2 = s2 & w & " "

'	If (Left(w,1) = "(" ) Then	' proper break ( , [ signs
'		temps = w
          
'	End If


      Else
        lw = strPix(w)

'	If ((Left(w,1) = "(" ) and (Size + lw > 86)) Then	'proper break ( , [ signs
'         break = TRUE
'	  s2 = w + " "

        If (size + lw > ScreenWidth) Then				'condition that determines border between string 1 and string 2
          break = TRUE
          s2 = s2 & w & " "
	Else
          s1 = s1 & w & " "
          size = size + lw + 3
        End If
      End If
    Next

    splitString = Array(RTrim(s1),RTrim(s2))
  End If
End Function


Function splitStringOptimized(s)		'split string into two parts and return an Array with 2 elements (#chars of first element <= width)
  Dim s1 ,s2 ,size ,lw ,words, break, temps

  Size = 0
  s1 = ""
  s2 = ""
  break = FALSE
  words = split(s)

  For each w in words
    If (break) Then			'build up string 2
      s2 = s2 & w & " "

'     If (Left(w,1) = "(" ) Then	' proper break ( , [ signs
'       temps = w
          
'	End If


    Else
      lw = strPix(w)			'count pix of word

'     If ((Left(w,1) = "(" ) and (Size + lw > 86)) Then	'proper break ( , [ signs
'       break = TRUE
'	s2 = w & " "

        If (size + lw > ScreenWidth) Then	'condition that determines border between string 1 and string 2
          break = TRUE
          s2 = s2 & w & " "		'word belongs to string 2
	Else
          s1 = s1 & w & " "
          size = size + lw + 3
        End If
      End If
    Next

    splitString = Array(RTrim(s1),RTrim(s2))
End Function



'------------------ center functions ----------------------

Function center(str)		'center str with spaces at left
  Dim s, pixs
  pixs = strPix2(str,ScreenWidth)	'count pixs of string with maximum of screenwidth

  If (pixs = -1) Then		'if #str is larger dan screenwidth  (overflow)
    center = str
    Exit Function
  Else
    s = (ScreenWidth - pixs)\6		'determine number of spaces at left side (remaining pixels div. by 2*3 space pixels)
    center = Space(s) & str
  End If
End Function


Function center2(str)		'center str with « sign at left and » at right side
  Dim i, r, s, pixs
  pixs = strPix2(str,ScreenWidth)	'count pixs of string with maximum of screenwidth

  If (pixs = -1) Then		'if #str is larger dan screenwidth  (overflow)
    center2 = str
    Exit Function
  Else
    r = ScreenWidth - pixs		'remaining pixels

    If (T610Enabled) Then	't610
    	i = r\10
    	s = (r - i*10)\6
    Else			't68i
        i = r\8
        s = (r - i*8)\6
    End If

    center2 = Space(s) & String(i,"-") & str & String(i,"-")
  End If
End Function



'------------------ SongInfo screen -----------------------

Sub boxT68i(title,line1,line2,line3,line4,line5,line6,line7)	'function needed for songinfo function (opens new window)
  am.clear
  am.Title = title

  am.AddItem line1, "exitSongInfo"
  am.AddItem line2, "exitSongInfo"
  am.AddItem line3, "exitSongInfo"
  am.AddItem line4, "exitSongInfo"
  am.AddItem line5, "exitSongInfo"    
  am.AddItem line6, "exitSongInfo"
  am.AddItem line7, "exitSongInfo"
  am.Update
End Sub


Sub boxT610(title,line1,line2,line3,line4,line5,line6,line7)	'function needed for songinfo function (opens new window)
  Dim SongOneLine
  Dim ArtistOneLine

  am.clear
  am.Title = title
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
  am.Update
End Sub

Sub exitSongInfo
  playlist(WinampCtrl.GetPlayListPosition-1)
End Sub



'---------------------------- Seek (beta 0.1) -------------------------------------

Dim Showbar, NeededBars
Dim RemSteps			'remaining steps to be shown at the last bar

Dim SavePos			'index of current song being played in the list



Sub enterSlide
  Dim p, steps, secPos

  WinampCtrl.SetLengthParseTime = FALSE
  steps = WinampCtrl.GetSongLength\10
  RemSteps = steps mod 6
  NeededBars = (steps\6) + 1
  SavePos = WinampCtrl.GetPlayListPosition

  WinampCtrl.SongPosParseTime = FALSE

  secPos = (WinampCtrl.GetSongPosition\10000)		'10sec units

  p = secPos mod 6					'Set step for slideScan

  Showbar = (secPos\6) + 1				'Set current bar to be shown

  WinampCtrl.SetLengthParseTime = TRUE 			'Needed in slideScan

  slideScan(p)
End Sub


Sub slideScan(i)
  Dim title, steps

  title = "(" & Cstr(Showbar-1) & ":00)" & "  " & WinampCtrl.GetSongLength

  If(Showbar = NeededBars) Then				'last bar shown steps
    steps = RemSteps
  Else
    steps = 6
  End If

  am.DlgPercent title, "winampScanEvent", steps, i
End Sub


Sub winampScanEvent(value, final)
  Dim JumpTo, ShowLastBar

  If (final = 1) Then
    winampMenu

  ElseIf(SavePos <> WinampCtrl.GetPlayListPosition) Then	'a new song is played
    enterSlide

  Else
    ShowLastBar = (Showbar = NeededBars)
    If (ShowLastBar) Then														'last bar shown
      JumpTo = (((Showbar-1)*600) + (value*RemSteps) )*100
    Else
      JumpTo = ((Showbar-1)*100 + value )*600
    End If


    If (WinampCtrl.JumpToTime(JumpTo) = 0) Then		'0 = succes, -1 = not playing, 1 = eof
      If (value = 100) Then				'end of bar
        If (Not ShowLastBar) Then				'end of last bar
          Showbar = Showbar + 1
          slideScan(0)
        End If

      ElseIf ((value = 0) and (Showbar <> 1)) Then	'begin of first bar
        Showbar = Showbar - 1
        slideScan(6)
      End If
    Else						'not playing || eof
      WinampCtrl.Play
    End If

  End If
End Sub


'------------------ winamp volume control -----------------

Sub onWinampSlideVol					'Winamp volume slider
  am.DlgPercent "Winamp Vol", "winampVolEvent", 10, WinampVol/25.5
End Sub

Sub winampVolEvent(value,final)
  If (final = 1) Then winampMenu 
  WinampVol = value*2.55
  WinampCtrl.SetVolume = WinampVol
End Sub

'----------------- winamp volume control ------------------

'----------------------------- shuffle & repeat options ------------------------

Sub onAMWinampOptions
  am.Clear
  winampOptions
End Sub

Sub winampOptions
  am.ClearMenu
  am.Title = "Winamp Options"

  If (WinampCtrl.shuffle) Then
    am.AddItem " [*] shuffle", "onAMShuffleToggle"
  Else
    am.AddItem " [" + Space(SpaceOption) + "] shuffle", "onAMShuffleToggle"
  End If

  If (WinampCtrl.repeat) Then
    am.AddItem " [*] repeat", "onAMRepeatToggle"
  Else
    am.AddItem " [" + Space(SpaceOption) + "] repeat", "onAMRepeatToggle"
  End If

  If (SettingBackOption) Then am.AddItem MenuItemBack, "exitWinampOptions"

  am.Back = "onAMWinamp"
  am.Update
End Sub

Sub exitWinampOptions
  SelectItem = 8
  onAMWinamp
End Sub

Sub onAMShuffleToggle
  WinampCtrl.Shuffle = Not WinampCtrl.Shuffle
  winampOptions
End Sub

Sub onAMRepeatToggle
  WinampCtrl.Repeat = Not WinampCtrl.Repeat
  winampOptions
End Sub


'----------------- end options ---------------------------


'---------------------------- Main Volume Control -----------------------------

Sub onAMVolumeControl
  am.Clear
  volumeControlMenu
End Sub

Sub volumeControlMenu
  Dim VolStat
  VolStat = getVolumeStat

  am.ClearMenu 				'This will just clear the menu, last possition remainds

  am.Title = VolStat

  If VolStat = "Mute" Then
    am.AddItem "UnMute", "onVolMute"
  Else
    am.AddItem "Mute", "onVolMute"
    am.AddItem "Master Vol", "onMasterVol"
  End If

  am.AddItem "Show", "onVolShow"
  If (SettingBackOption) Then am.AddItem MenuItemBack, "onAMRoot"

  am.Back = "onAMRoot"
  am.Update
End Sub

Sub onMasterVol
  am.DlgPercent "Master Vol", "masterVolEvent", 10 , VolumeCtrl.Volume/10
End Sub


Sub masterVolEvent(value, final)
  VolumeCtrl.Volume = value
  If final = 1 Then volumeControlMenu
End Sub

Sub onVolShow
  VolumeCtrl.Show
  am.Update
End Sub

Sub onVolMute
  If VolumeCtrl.Mute = 1 Then
    VolumeCtrl.Mute = 0
  Else
    VolumeCtrl.Mute = 1
  End If

  volumeControlMenu
End Sub


Function getVolumeStat
  If VolumeCtrl.Mute = 1 Then
    getVolumeStat = "Mute"
  Else
    getVolumeStat = "Vol: " & VolumeCtrl.Volume & "%"
  End If
End Function

'---------------------------- Mouse Control -----------------------------

Sub onAMMouseControl
  am.Clear 				'This will just clear the menu, last possition remainds

  am.Title = "Mouse Control"

  If MouseControlActive = 0 Then
    am.AddItem "Activate", "mouseControlStart"
  Else
    am.AddItem "Deactivate", "mouseControlFinish"
  End If

  am.Back = "onAMRoot"
  am.Update
End Sub

Sub mouseControlStart
  fma.EnableKeyMonitor
  MouseControlActive = 1

  'Prevent OK button to close info box
  am.Back = ""

  'But show how to exit Mouse control mode
  am.DlgInformation "Mouse Control", "Use the Back button to Deactivate."
End Sub

Sub mouseControlFinish
  MouseCtrl.MouseStop

  fma.DisableKeyMonitor
  MouseControlActive = 0

  am.Back = "onAMRoot"
End Sub

Sub OnKeyPress(Key, State)
  If MouseControlActive = 1 Then
    If State = 0 Then
	  MouseCtrl.MouseStop
    Else
      Select Case Key
		Case ":R"   mouseControlFinish
		Case ":e"   mouseControlFinish

		Case "<"	MouseCtrl.MouseMove("W")
		Case "^"	MouseCtrl.MouseMove("N")
		Case ">"	MouseCtrl.MouseMove("E")
		Case "v"	MouseCtrl.MouseMove("S")

		Case ":J"   MouseCtrl.MouseLeftClick

		Case "["	MouseCtrl.MouseLeftClick
		Case "]"    MouseCtrl.MouseRightClick

		Case "1"    MouseCtrl.MouseMove("NW")
		Case "2"    MouseCtrl.MouseMove("N")
		Case "3"    MouseCtrl.MouseMove("NE")
		Case "4"    MouseCtrl.MouseMove("W")
		Case "6"    MouseCtrl.MouseMove("E")
		Case "7"    MouseCtrl.MouseMove("SW")
		Case "8"    MouseCtrl.MouseMove("S")
		Case "9"    MouseCtrl.MouseMove("SE")

		Case "5"    MouseCtrl.MouseLeftClick
		Case "0"    MouseCtrl.MouseRightClick

		Case "u"    MouseCtrl.MouseWhlUp
		Case "d"    MouseCtrl.MouseWhlDown
	  End Select
    End If
  End If
End Sub

'---------------------------- Hauppauge WinTV ---------------------------------

Sub onAMWinTV
  WinTVOpen = shell.AppActivate("WinTV32")
  am.Clear
  winTVMenu
End Sub


Sub winTVMenu
  am.ClearMenu
  am.Title = "WinTV"

  If (WinTVOpen) Then
    am.AddItem "Remote Mode", "onWinTVList"
    am.AddItem "Channel Up", "onWinTVChannelUp"
    am.AddItem "Channel Down", "onWinTVChannelDown"
    am.AddItem "Volume", "onWinTVVol"
    am.AddItem "Mute/UnMute", "onWinTVMute"
    am.AddItem "Fullscreen", "onWinTVFullscreen"
    am.AddItem "Freeze", "onWinTVFreeze"
    am.AddItem "Snapshot", "onWinTVSnapshot"
    am.AddItem "Close WinTV", "onWinTVClose"
  Else
    am.AddItem "Launch WinTV", "onWinTVLaunch"
  End If
  If (SettingBackOption) Then am.AddItem MenuItemBack, "onAMRoot"

  am.Back = "onAMRoot"
  am.Update
End Sub

Sub onWinTVLaunch
  shell.Run WinTVEXE
  WinTVOpen = TRUE
  winTVMenu
End Sub

Sub onWinTVClose
  If shell.AppActivate("WinTV32") Then shell.SendKeys("%{F4}")
  WinTVOpen = FALSE
  winTVMenu
End Sub



Sub onWinTVSnapshot
  If shell.AppActivate("WinTV32") Then shell.SendKeys("{ }")
  am.Update
End Sub

Sub onWinTVFreeze
  If shell.AppActivate("WinTV32") Then shell.SendKeys("^f")
  am.Update
End Sub

Sub onWinTVChannelDown
  If shell.AppActivate("WinTV32") Then shell.SendKeys("{-}")
  am.Update
End Sub

Sub onWinTVChannelUp
  If shell.AppActivate("WinTV32") Then shell.SendKeys("{+}")
  am.Update
End Sub

Sub onWinTVVol
  am.DlgPercent "Master Vol", "winTVVolEvent", 10 , VolumeCtrl.Volume/10
End Sub

Sub winTVVolEvent(value, final)
  VolumeCtrl.Volume = value
  If final = 1 Then winTVMenu
End Sub


Sub onWinTVFullscreen
  If shell.AppActivate("WinTV32") Then shell.SendKeys("^t")
  am.update
End Sub

Sub onWinTVMute
  If shell.AppActivate("WinTV32") Then shell.SendKeys("^m")
  am.update
End Sub

Sub onWinTVList
  Dim Button
  Button = "Button "

  am.Clear
  am.Title = "Remote Mode"

  am.AddItem Button & 1, "sendKey1"
  am.AddItem Button & 2, "sendKey2"
  am.AddItem Button & 3, "sendKey3"
  am.AddItem Button & 4, "sendKey4"
  am.AddItem Button & 5, "sendKey5"
  am.AddItem Button & 6, "sendKey6"
  am.AddItem Button & 7, "sendKey7"
  am.AddItem Button & 8, "sendKey8"
  am.AddItem Button & 9, "sendKey9"
  am.AddItem Button & 0, "sendKey0"
  am.AddItem center("Exit Mode"), "exitWinTVList"

  am.Back = "onAMWinTV"
  am.Update
End Sub

Sub exitWinTVList
  onAMWinTV
End Sub


Sub sendKey(b)
  If shell.AppActivate("WinTV32") Then shell.SendKeys b
  onWinTVList
End Sub

Sub sendKey1
  sendKey(1)
End Sub

Sub sendKey2
  sendKey(2)
End Sub

Sub sendKey3
  sendKey(3)
End Sub

Sub sendKey4
  sendKey(4)
End Sub

Sub sendKey5
  sendKey(5)
End Sub

Sub sendKey6
  sendKey(6)
End Sub

Sub sendKey7
  sendKey(7)
End Sub

Sub sendKey8
  sendKey(8)
End Sub

Sub sendKey9
  sendKey(9)
End Sub

Sub sendKey0
  sendKey(0)
End Sub


'--------------------------- MoreTV -----------------------------------------

Sub onAMMoreTV
  MoreTVOpen = shell.AppActivate("MoreTV")
  am.Clear
  MoreTVMenu
End Sub
        
Sub MoreTVMenu
  am.ClearMenu
  am.Title = "MoreTV"
  
  If (MoreTVOpen) Then
    am.AddItem "Remote Mode", "onMoreTVList"
    am.AddItem "Channel Up", "onMoreTVChannelUp"
    am.AddItem "Channel Down", "onMoreTVChannelDown"    
    am.AddItem "Volume", "onMoreTVVol"  
    am.AddItem "Mute/UnMute", "onMoreTVMute"   
    am.AddItem "Fullscreen", "onMoreTVFullscreen"       
    am.AddItem "Videotext", "onMoreTVVideotext"    
    am.AddItem "Close MoreTV", "onMoreTVClose"
  Else
    am.AddItem "Launch MoreTV", "onMoreTVLaunch"
  End If
  If (SettingBackOption) Then am.AddItem MenuItemBack, "onAMRoot"

  am.Back = "onAMRoot"
  am.Update
End Sub

Sub onMoreTVLaunch
  shell.Run MoreTVEXE
  MoreTVOpen = TRUE
  MoreTVMenu
End Sub

Sub onMoreTVClose
  If shell.AppActivate("MoreTV") Then shell.SendKeys "{F10}"
  MoreTVOpen = FALSE
  MoreTVMenu
End Sub


Sub onMoreTVChannelUp
  If shell.AppActivate("MoreTV") Then shell.SendKeys "{UP}"
  am.Selected = 2
  am.Update
End Sub

Sub onMoreTVChannelDown
  If shell.AppActivate("MoreTV") Then shell.SendKeys "{DOWN}"
  am.Update
End Sub

Sub onMoreTVMute
  If shell.AppActivate("MoreTV") Then shell.SendKeys "m"
  am.Update
End Sub

Sub onMoreTVVideotext
  If shell.AppActivate("MoreTV") Then shell.SendKeys "v"
  am.Update
End Sub


Sub onMoreTVVol
  am.DlgPercent "Master Vol", "moreTVVolEvent", 10 , VolumeCtrl.Volume/10
End Sub

Sub moreTVVolEvent(value, final)
  VolumeCtrl.Volume = value
  If final = 1 Then MoreTVMenu
End Sub

Sub onMoreTVFullscreen
  If shell.AppActivate("MoreTV") Then shell.SendKeys "{F9}"
  am.Update
End Sub

Sub onMoreTVList
  Dim Button
  Button = " Program "

  am.Clear
  am.Title = "Remote Mode"

  am.AddItem Button & 1, "sendKeyMTV1"
  am.AddItem Button & 2, "sendKeyMTV2"
  am.AddItem Button & 3, "sendKeyMTV3"
  am.AddItem Button & 4, "sendKeyMTV4"
  am.AddItem Button & 5, "sendKeyMTV5"
  am.AddItem Button & 6, "sendKeyMTV6"
  am.AddItem Button & 7, "sendKeyMTV7"
  am.AddItem Button & 8, "sendKeyMTV8"
  am.AddItem Button & 9, "sendKeyMTV9"
  am.AddItem Button & 0, "sendKeyMTV0"
  am.AddItem center("Exit Mode"), "exitMoreTVList"

  am.Back = "onAMMoreTVMenu"
  am.Update
End Sub

Sub exitMoreTVList
  onAMRoot
End Sub


Sub sendKeyMTV(b)
  If shell.AppActivate("MoreTV") Then shell.SendKeys b
  onMoreTVList
End Sub

Sub sendKeyMTV1
  sendKeyMTV(1)
End Sub

Sub sendKeyMTV2
  sendKeyMTV(2)
End Sub

Sub sendKeyMTV3
  sendKeyMTV(3)
End Sub

Sub sendKeyMTV4
  sendKeyMTV(4)
End Sub

Sub sendKeyMTV5
  sendKeyMTV(5)
End Sub

Sub sendKeyMTV6
  sendKeyMTV(6)
End Sub

Sub sendKeyMTV7
  sendKeyMTV(7)
End Sub

Sub sendKeyMTV8
  sendKeyMTV(8)
End Sub

Sub sendKeyMTV9
  sendKeyMTV(9)
End Sub

Sub sendKeyMTV0
  sendKey(0)
End Sub

'---------------------------- Media Player 9 Control --------------------------

Sub onAMMediaPlayer
  MediaPlayerOpen = shell.AppActivate("Windows Media Player")
  mediaPlayerMenu
End Sub

Sub mediaPlayerMenu
  am.Clear
  am.Title = "Media Player 9"
  
  If (MediaPlayerOpen) Then
    am.AddItem "Play/Pause", "onMP9PlayPause"
    am.AddItem "Stop", "onMP9Stop"
    am.AddItem "Prev Track", "onMP9Prev"
    am.AddItem "Next Track", "onMP9Next"
    am.AddItem "Fullscreen", "onMP9FullScreen"
    am.AddItem "Shuffle", "onMP9Shuffle"
    am.AddItem "Fast Forward", "onMP9FastForward"
    am.AddItem "Volume Up", "onMP9VolUp"
    am.AddItem "Volume Down", "onMP9VolDown"
    am.AddItem "Close MPlayer", "onMP9Close"
  Else
    am.AddItem "Launch MPlayer", "onMP9Launch"
  End If
  If (SettingBackOption) Then am.AddItem MenuItemBack, "onAMRoot"

  am.Back = "onAMRoot"
  am.Update
End Sub

Sub onMP9Launch
  shell.Run "wmplayer.exe"
  MediaPlayerOpen = TRUE
  mediaPlayerMenu
End Sub

Sub onMP9Close
  If shell.AppActivate("Windows Media Player") Then shell.SendKeys "%{F4}"
  MediaPlayerOpen = FALSE
  mediaPlayerMenu
End Sub

Sub onMP9PlayPause
  If shell.AppActivate("Windows Media Player") Then shell.SendKeys "^p"
  am.Update
End Sub

Sub onMP9Stop
  If shell.AppActivate("Windows Media Player") Then shell.SendKeys "^s"
  am.Selected = 1
  am.Update
End Sub

Sub onMP9Prev
  If shell.AppActivate("Windows Media Player")Then shell.SendKeys "^b"
  am.Update
End Sub

Sub onMP9Next
  If shell.AppActivate("Windows Media Player") Then shell.SendKeys "^f"
  am.Update
End Sub

Sub onMP9FullScreen
  If shell.AppActivate("Windows Media Player") Then shell.SendKeys "%~"
  am.Update
End Sub

Sub onMP9VolUp
  If shell.AppActivate("Windows Media Player") Then shell.SendKeys "^%{F10}"
  am.Update
End Sub

Sub onMP9VolDown
  If shell.AppActivate("Windows Media Player") Then shell.SendKeys "^%{F9}"
  am.Update
End Sub

Sub onMP9Shuffle
  If shell.AppActivate("Windows Media Player") Then shell.SendKeys "^h"
  am.Update
End Sub

Sub onMP9FastForward
  If shell.AppActivate("Windows Media Player") Then shell.SendKeys "^F"
  am.Update
End Sub


'--------------------------- BSPlayer -----------------------------------------

Sub onAMBSPlayer
  BSPlayerOpen = shell.AppActivate("BSPlayer")
  am.Clear
  BSPlayerMenu
End Sub
  	
Sub BSPlayerMenu
  am.ClearMenu
  am.Title = "BSPlayer"
  
  If (BSPlayerOpen) Then
    am.AddItem "Play", "onBSPlayerPlay"
    am.AddItem "Pause", "onBSPlayerPause"
    am.AddItem "Stop", "onBSPlayerStop"
    am.AddItem "Prev", "onBSPlayerPrev"
    am.AddItem "Next", "onBSPlayerNext"
    am.AddItem "Fullscreen", "onBSPlayerFullscreen"
    am.AddItem "Sub On", "onBSPlayerSub"
    am.AddItem "Zoom", "onBSPlayerZoom"
    am.AddItem "Close BSPlayer", "onBSPlayerClose"
  Else
    am.AddItem "Launch BSPlayer", "onBSPlayerLaunch"
  End If
  If (SettingBackOption) Then am.AddItem MenuItemBack, "onAMRoot"

  am.Back = "onAMRoot"
  am.Update
End Sub

Sub onBSPlayerLaunch
  shell.Run BSPlayerEXE
  BSPlayerOpen = TRUE
  BSPlayerMenu
End Sub

Sub onBSPlayerClose
  If shell.AppActivate("BSPlayer") Then shell.SendKeys("%{F4}")
  BSPlayerOpen = FALSE
  BSPlayerMenu
End Sub



Sub onBSPlayerPlay
  If shell.AppActivate("BSPlayer") Then shell.SendKeys "x"
  am.Selected = 2
  am.Update
End Sub

Sub onBSPlayerPause
  If shell.AppActivate("BSPlayer") Then shell.SendKeys "c"
  am.Update
End Sub

Sub onBSPlayerStop
  If shell.AppActivate("BSPlayer") Then shell.SendKeys "v"
  am.Selected = 1
  am.Update
End Sub

Sub onBSPlayerPrev
  If shell.AppActivate("BSPlayer") Then shell.SendKeys "z"
  am.Update
End Sub

Sub onBSPlayerNext
  If shell.AppActivate("BSPlayer") Then shell.SendKeys "b"
  am.Update
End Sub

Sub onBSPlayerFullscreen
  If shell.AppActivate("BSPlayer") Then shell.SendKeys "f"
  am.Update
End Sub

Sub onBSPlayerSub
  If shell.AppActivate("BSPlayer") Then shell.SendKeys "s"
  am.Update
End Sub



'------------------ BSPlayer Zoom control -----------------

Sub onBSPlayerZoom			
  am.DlgPercent "Zoom control", "bsPlayerZoomEvent", 2, BSPlayerZoom
End Sub

Sub bsPlayerZoomEvent(value,final)
  If (final = 1) Then
    BSPlayerMenu
  ElseIf (value = 0) Then
    onBSPlayerZoom1
  ElseIf (value = 100) Then
    onBSPlayerZoom3
  Else
    onBSPlayerZoom2
  End If
End Sub


Sub onBSPlayerZoom1
  If shell.AppActivate("BSPlayer") Then shell.SendKeys "1"
  BSPlayerZoom = 0
End Sub

Sub onBSPlayerZoom2
  If shell.AppActivate("BSPlayer") Then shell.SendKeys "2"
  BSPlayerZoom = 1
End Sub

Sub onBSPlayerZoom3
  If shell.AppActivate("BSPlayer") Then shell.SendKeys "3"
  BSPlayerZoom = 2
End Sub

'----------------- BSPlayer Zoom control ------------------



'---------------------------- PowerDVD 5.0 Control -------------------------

Sub onAMPowerDVD
  PowerDVDOpen = shell.AppActivate("PowerDVD")
  powerDVDMenu
End Sub

Sub powerDVDMenu
  am.Clear
  am.Title = "PowerDVD [1/2]"
  
  If (PowerDVDOpen) Then
    am.AddItem "Play", "onPowerDVDPlay"
    am.AddItem "Pause", "onPowerDVDPause"
    am.AddItem "Stop", "onPowerDVDStop"
    am.AddItem "Prev Chapter", "onPowerDVDPrev"
    am.AddItem "Next Chapter", "onPowerDVDNext"
    am.AddItem "Step Backward", "onPowerDVDStepBwd"
    am.AddItem "Step Forward", "onPowerDVDStepFwd"
    am.AddItem "Capture Frame", "onPowerDVDCapture"
    am.AddItem "Audio Stream", "onPowerDVDAudio"
    am.AddItem MenuItemNext, "powerDVDMenu2"
  Else
    am.AddItem "Launch PowerDVD", "onPowerDVDLaunch"
    If (SettingBackOption) Then am.AddItem MenuItemBack, "onAMRoot"
  End If

  am.Back = "onAMRoot"
  am.Update
End Sub

Sub powerDVDMenu2
  am.Clear
  am.Title = "PowerDVD [2/2]"
  
  am.AddItem MenuItemPrev, "powerDVDMenu"
  am.AddItem "Subtitles", "onPowerDVDSubtitle"
  am.AddItem "Volume + 5", "onPowerDVDVolInc"
  am.AddItem "Volume - 5", "onPowerDVDVolDec"
  am.AddItem "Mute/UnMute", "onPowerDVDVolMute"
  am.AddItem "Full Screen", "onPowerDVDFull"
  am.AddItem "Set repeat", "onPowerDVDRepeat"
  am.AddItem "Set shuffle", "onPowerDVDShuffle"
  am.AddItem "Hide Controls", "onPowerDVDHide"
  am.AddItem "Close PowerDVD", "onPowerDVDClose"  

  If (SettingBackOption) Then am.AddItem MenuItemBack, "onAMRoot"

  am.Back = "powerDVDMenu"
  am.Update
End Sub


Sub onPowerDVDLaunch
  shell.Run PowerDVDEXE
  PowerDVDOpen = TRUE
  powerDVDMenu
End Sub

Sub onPowerDVDClose
  If shell.AppActivate("PowerDVD") Then shell.SendKeys "^x"
  PowerDVDOpen = FALSE
  powerDVDMenu
End Sub


Sub onPowerDVDPlay
  If shell.AppActivate("PowerDVD") Then shell.SendKeys "~"
  am.Selected = 2
  am.Update
End Sub

Sub onPowerDVDPause
  If shell.AppActivate("PowerDVD") Then shell.SendKeys "{ }"
  am.Update
End Sub

Sub onPowerDVDHide
  If shell.AppActivate("PowerDVD") Then shell.SendKeys "%{tab}"
  am.Update
End Sub

Sub onPowerDVDStop
  If shell.AppActivate("PowerDVD") Then shell.SendKeys "s"
  am.Selected = 1
  am.Update
End Sub

Sub onPowerDVDPrev
  If shell.AppActivate("PowerDVD") Then shell.SendKeys "p"
  am.Update
End Sub

Sub onPowerDVDNext
  If shell.AppActivate("PowerDVD") Then shell.SendKeys "n"
  am.Update
End Sub

Sub onPowerDVDSubtitle
  If shell.AppActivate("PowerDVD") Then shell.SendKeys "u"
  am.Update
End Sub

Sub onPowerDVDRepeat
  If shell.AppActivate("PowerDVD") Then shell.SendKeys "r"
  am.Update
End Sub

Sub onPowerDVDShuffle
  If shell.AppActivate("PowerDVD") Then shell.SendKeys "u"
  am.Update
End Sub

Sub onPowerDVDStepBwd
  If shell.AppActivate("PowerDVD") Then shell.SendKeys "^b"
  am.Update
End Sub

Sub onPowerDVDStepFwd
  If shell.AppActivate("PowerDVD") Then shell.SendKeys "t"
  am.Update
End Sub

Sub onPowerDVDCapture
  If shell.AppActivate("PowerDVD") Then shell.SendKeys "c"
  am.Update
End Sub

Sub onPowerDVDAudio
  If shell.AppActivate("PowerDVD") Then shell.SendKeys "h"
  am.Update
End Sub

Sub onPowerDVDVolInc
  If shell.AppActivate("PowerDVD") Then shell.SendKeys "{+}"
  am.Update
End Sub

Sub onPowerDVDVolDec
  If shell.AppActivate("PowerDVD") Then shell.SendKeys "{-}"
  am.Update
End Sub

Sub onPowerDVDVolMute
  If shell.AppActivate("PowerDVD") Then shell.SendKeys "q"
  am.Update
End Sub

Sub onPowerDVDFull
  If shell.AppActivate("PowerDVD") Then shell.SendKeys "z"
  am.Update
End Sub

Sub onPowerDVDMinimize
  If shell.AppActivate("PowerDVD") Then shell.SendKeys "^n"
  am.Update
End Sub


'---------------------------- PowerPoint Control ------------------------------

Sub onAMPowerPoint
  PPTOpen = shell.AppActivate("Microsoft Powerpoint")
  am.clear
  ShowPPMenu
End Sub

Sub ShowPPMenu
  am.ClearMenu
  am.Title = "Presentation"

  If (PPTOpen) Then
    am.AddItem "Start Show", "onPPStartShow"
    am.AddItem "Next Slide", "onPPNext"
    am.AddItem "Prev Slide", "onPPPrev"
    am.AddItem "Volume Up", "onPPVolUp"
    am.AddItem "Volume Down", "onPPVolUp"
    am.AddItem "Mute/UnMute", "onPPMute"
    am.AddItem "Switch", "onPPSwitch"
    am.AddItem "Black Screen", "onPPBlackScreen"
    am.AddItem "End Show", "onPPEndShow"
    am.AddItem "Exit PPT", "onPPClose"
  Else
    am.AddItem "Launch PPT", "onPPTLaunch"
    If (SettingBackOption) Then am.AddItem MenuItemBack, "onAMRoot"
  End If

  am.Back = "onAMRoot"
  am.Update
End Sub

Sub onPPTLaunch
  shell.Run PPTEXE
  PPTOpen = TRUE
  ShowPPMenu
End Sub

Sub onPPClose
  If shell.AppActivate("Microsoft PowerPoint") Then shell.SendKeys "%{F4}"
  PPTOpen = FALSE
  onAMRoot
  am.Update
End Sub

Sub onPPVolUp
  If shell.AppActivate("Microsoft PowerPoint") Then shell.SendKeys "^%{F10}"
  am.Update
End Sub

Sub onPPVolDown
  If shell.AppActivate("Microsoft PowerPoint") Then shell.SendKeys "^%{F9}"
  am.Update
End Sub

Sub onPPMute
  If shell.AppActivate("Microsoft PowerPoint") Then shell.SendKeys "^%{F12}"
  am.Update
End Sub

Sub onPPSwitch
  If shell.AppActivate("Microsoft PowerPoint") Then shell.SendKeys "%{tab}"
  am.Update
End Sub

Sub onPPBlackScreen
  If shell.AppActivate("Microsoft PowerPoint") Then shell.SendKeys "%cb"
  am.Update
End Sub

Sub onPPStartShow
  If shell.AppActivate("Microsoft PowerPoint") Then shell.SendKeys "{F5}"
  am.Update
End Sub

Sub onPPNext
  If shell.AppActivate("Microsoft PowerPoint") Then shell.SendKeys "n"
  am.Update
End Sub

Sub onPPPrev
  If shell.AppActivate("Microsoft PowerPoint") Then shell.SendKeys "p"
  am.Update
End Sub

Sub onPPEndShow
  If shell.AppActivate("Microsoft PowerPoint") Then shell.SendKeys "{ESC}"
  am.Update
End Sub



'---------------------------- Misc Control ------------------------------------

Sub onAMMisc
  am.Clear
  am.Title = "Misc"
  am.AddItem "Lock PC", "onAMLockWorkStation"
  am.AddItem "Disconnect ME", "onAMDisconnectME"
  am.AddItem "Shutdown Menu", "onAMshutdownMenu"
  If (SettingBackOption) Then am.AddItem MenuItemBack, "onAMRoot"

  am.Back = "onAMRoot"
  am.Update
End Sub

Sub onAMLockWorkStation
  shell.Run "Rundll32.exe user32.dll,LockWorkStation"
  am.Title = "PC Locked"
  am.Update
End Sub

Sub onAMDisconnectME
  Disconnect
End Sub

Sub onAMshutdownMenu
  am.Clear
  am.Title = "Shutdown PC"
  am.AddItem "Shutdown", "onAMshutdown"
  am.AddItem "Hibernate", "onAMhibernate"  
  am.AddItem "Reboot", "onAMreboot"
  If (ShutdownBool) Then am.AddItem "Cancel Shutdown", "onAMcancelShutdown"

  am.Back = "onAMMisc"
  am.Update
End Sub

Dim ShutdownBool
ShutdownBool = FALSE

Sub onAMshutdown
  ShutdownBool = TRUE
  am.Clear
  shell.Exec "shutdown -f -s -t 30"
  am.Title = "Shutdown.."
  am.AddItem center("Cancel reboot",""), "onAMcancelShutdown"

  am.Back = "onAMshutdownMenu"
  am.Update
End Sub

Sub onAMhibernate
  shell.Run "Rundll32.exe powrprof.dll,SetSuspendState"
End Sub

Sub onAMreboot
  ShutdownBool = TRUE
  am.Clear
  shell.Exec "shutdown -f -r -t 30"
  am.Title = "Reboot.."
  am.AddItem center("Cancel reboot",""), "onAMcancelShutdown"

  am.Back = "onAMshutdownMenu"
  am.Update
End Sub

Sub onAMcancelShutdown
  ShutdownBool = FALSE

  am.Clear
  shell.Exec "shutdown.exe -a"
  am.Title = "Canceled"
  am.AddItem center("Shutdown Menu",""), "onAMshutdownMenu"

  am.Back = "onAMshutdownMenu"
  am.Update
End Sub


'---------------------------------------------------------------------------------------------

Sub setRootMenuItems			'setting the menu items at the root according sequence in the array
  Dim i, id
  For i=1 To UBound(ArrID)		'ArrID(0) is empty and not used
    id = ArrID(i)
    If (id = iTunesID) Then
      am.AddItem "iTunes", "OnAMiTunes"
    ElseIf (id = WinTVID) Then
      am.AddItem "Hauppauge WinTV", "onAMWinTV"
    ElseIf (id = MoreTVID) Then
      am.AddItem "MoreTV", "onAMMoreTV"
    ElseIf (id = WinampID) Then
      am.AddItem "Winamp", "onAMWinamp"
    ElseIf (id = PowerDVDID) Then
      am.AddItem "PowerDVD 5.0", "onAMPowerDVD"
    ElseIf (id = WinDVD5ID) Then
      am.AddItem "WinDVD 5", "OnAMPDVD"
    ElseIf (id = WinDVD4ID) Then
      am.AddItem "WinDVD 4", "OnAMPDVD4"
    ElseIf (id = ZoomPlayerID) Then
      am.AddItem "ZoomPlayer", "OnAMZoomPlayer"
    ElseIf (id = BSPlayerID) Then
      am.AddItem "BSPlayer", "onAMBSPlayer"
    ElseIf (id = MediaPlayerID) Then
      am.AddItem "Media Player 9", "onAMMediaPlayer"
    ElseIf (id = VolumeControlID) Then
      am.AddItem "Volume Control", "onAMVolumeControl"
    ElseIf (id = MouseControlID) Then
      am.AddItem "Mouse Control", "onAMMouseControl"
    ElseIf (id = PowerPointID) Then
      am.AddItem "PowerPoint", "onAMPowerPoint"
    ElseIf (id = MiscControlID) Then
      am.AddItem "Misc Control", "onAMMisc"
    ElseIf (id = MsAgentID) Then
      am.AddItem "Ms Agent", "SpeechSay(SpeechText)"
    End If
  Next
End Sub

'---------------------------- user-settings menu ------------------------------
Function isSet(e)
  isSet = elementOf(e,ArrID)
End Function

Sub onAMsettings
  am.Clear
  settingsMenu
End Sub

Sub settingsMenu
  am.ClearMenu
  am.Title = "Settings [1/2]"

  If (isSet(iTunesID)) Then
    am.AddItem "[*] iTunes", "setiTunes"
  Else
    am.AddItem "[" + Space(SpaceOption) + "] iTunes", "setiTunes"
  End If

  If (isSet(WinTVID)) Then
    am.AddItem "[*] HP WinTV", "setWinTV"
  Else
    am.AddItem "[" + Space(SpaceOption) + "] HP WinTV", "setWinTV"
  End If

  If (isSet(MoreTVID)) Then
    am.AddItem "[*] MoreTV", "setMoreTV"
  Else
    am.AddItem "[" + Space(SpaceOption) +  "] MoreTV", "setMoreTV"
  End If

  If (isSet(WinampID)) Then
    am.AddItem "[*] Winamp", "setWinamp"
  Else
    am.AddItem "[" + Space(SpaceOption) + "] Winamp", "setWinamp"
  End If

  If (isSet(PowerDVDID)) Then
    am.AddItem "[*] PowerDVD 5.0", "setPowerDVD"
  Else
    am.AddItem "[" + Space(SpaceOption) + "] PowerDVD 5.0", "setPowerDVD"
  End If

  If (isSet(WinDVD5ID)) Then
    am.AddItem "[*] WinDVD 5", "setWinDVD5"
  Else
    am.AddItem "[" + Space(SpaceOption) + "] WinDVD 5", "setWinDVD5"
  End If

  If (isSet(WinDVD4ID)) Then
    am.AddItem "[*] WinDVD 4", "setWinDVD4"
  Else
    am.AddItem "[" + Space(SpaceOption) + "] WinDVD 4", "setWinDVD4"
  End If

  If (isSet(ZoomPlayerID)) Then
    am.AddItem "[*] ZoomPlayer", "setZoomPlayer"
  Else
    am.AddItem "[" + Space(SpaceOption) + "] ZoomPlayer", "setZoomPlayer"
  End If

  If (isSet(BSPlayerID)) Then
    am.AddItem "[*] BSPlayer", "setBSPlayer"
  Else
    am.AddItem "[" + Space(SpaceOption) + "] BSPlayer", "setBSPlayer"
  End If

  If (isSet(MediaPlayerID)) Then
    am.AddItem "[*] Media Player 9", "setMediaPlayer"
  Else
    am.AddItem "[" + Space(SpaceOption) + "] Media Player 9", "setMediaPlayer"
  End If

  If (isSet(PowerPointID)) Then
    am.AddItem "[*] PowerPoint", "setPowerPoint"
  Else
    am.AddItem "[" + Space(SpaceOption) + "] PowerPoint", "setPowerPoint"
  End If

  am.AddItem MenuItemNext, "onAMsettingsMenu2"

  am.Back = "exitSettings"
  am.Update
End Sub

Sub onAMsettingsMenu2
  am.clear
  settingsMenu2
End Sub

Sub settingsMenu2
  am.ClearMenu
  am.Title = "Settings [2/2]"

  am.AddItem MenuItemPrev, "onAMsettings"

  If (isSet(VolumeControlID)) Then
    am.AddItem "[*] Volume Control", "setVolumeControl"
  Else
    am.AddItem "[" + Space(SpaceOption) + "] Volume Control", "setVolumeControl"
  End If

  If (isSet(MouseControlID)) Then
    am.AddItem "[*] Mouse Control", "setMouseControl"
  Else
    am.AddItem "[" + Space(SpaceOption) + "] Mouse Control", "setMouseControl"
  End If

  If (isSet(MiscControlID)) Then
    am.AddItem "[*] Misc Control", "setMiscControl"
  Else
    am.AddItem "[" + Space(SpaceOption) + "] Misc Control", "setMiscControl"
  End If

  If (isSet(MsAgentID)) Then
    am.AddItem "[*] Ms Agent", "setMsAgent"
  Else
    am.AddItem "[" + Space(SpaceOption) + "] Ms Agent", "setMsAgent"
  End If

  If (SettingBackOption) Then
    am.AddItem "[*] Show Back", "setBackOption"
  Else
    am.AddItem "[" + Space(SpaceOption) + "] Show Back", "setBackOption"
  End If

  If (SaveSettingsBool) Then
    am.AddItem "[*] Save Settings", "setSaveSettings"
  Else
    am.AddItem "[" + Space(SpaceOption) + "] Save Settings", "setSaveSettings"
  End If

  'am.AddItem center2("-"), "am.update"

  am.AddItem center("[ Sort Menu ]"), "setOrderMenuItems"

  If (T610Enabled) Then
    am.AddItem Center("[*] T610 | [" + Space(SpaceOption) +"] T68i"), "setT610Enabled"
  Else
    am.AddItem Center("[" + Space(SpaceOption) + "]" + " T610 | [*] T68i"), "setT610Enabled"
  End If

  'am.AddItem center2("-"), "am.update"

  am.AddItem MenuItemExitMenu, "exitSettings"

  am.Back = "onAMsettings"
  am.Update
End Sub

Sub exitSettings
  If (SaveSettingsBool) Then
    saveSettings
  Else
    deleteSettings
  End If
  onAMRoot
End Sub


Sub setiTunes
  toggleOption(iTunesID)
End Sub

Sub setWinTV
  toggleOption(WinTVID)
End Sub

Sub setMoreTV
  toggleOption(MoreTVID)
End Sub

Sub setWinamp
  toggleOption(WinampID)
End Sub

Sub setPowerDVD
  toggleOption(PowerDVDID)
End Sub

Sub setWinDVD5
  toggleOption(WinDVD5ID)
End Sub

Sub setWinDVD4
  toggleOption(WinDVD4ID)
End Sub

Sub setZoomPlayer
  toggleOption(ZoomPlayerID)
End Sub

Sub setBSPlayer
  toggleOption(BSPlayerID)
End Sub

Sub setMediaPlayer
  toggleOption(MediaPlayerID)
End Sub  

Sub setVolumeControl
  toggleOption(VolumeControlID)
End Sub

Sub setMouseControl
  toggleOption(MouseControlID)
End Sub

Sub setPowerPoint
  toggleOption(PowerPointID)
End Sub

Sub setMiscControl
  toggleOption(MiscControlID)
End Sub

Sub setMsAgent
  toggleOption(MsAgentID)
End Sub

Sub setBackOption
  SettingBackOption = Not SettingBackOption
  settingsMenu2
End Sub

Sub setSaveSettings
  SaveSettingsBool = Not SaveSettingsBool
  settingsMenu2
End Sub

Sub setT610Enabled
  T610Enabled = Not T610Enabled
  selectPhone
  settingsMenu2
End Sub


Sub toggleOption(id)
  If (isSet(id)) Then
    removeElement(id)
  Else
    addElement(id)
  End If
  settingsMenu
End Sub

'------------------------ array functions-------------------------

Sub removeElement(id)
  Dim i
  For i=0 To UBound(ArrID)
    If (ArrID(i) = id) Then
    	removeElementAt(i)
    	Exit For
    End If
  Next
End Sub

Sub removeElementAt(p)
  Dim i, limit
  limit = UBound(ArrID)
  For i=p To limit-1
    ArrID(i)=ArrID(i+1)
  Next
  ReDim Preserve ArrID(limit-1)
End Sub

Sub addElement(id)
  Dim i, limit
  limit = UBound(ArrID)
  ReDim Preserve ArrID(limit+1)
  ArrID(limit+1) = id
End Sub


'------------------------------------ menu config ----------------------------------------


Sub setOrderMenuItems
  Dim i, id
  am.Clear
  am.Title = "Sort Menu"

  If(SelectItem>0) Then
    am.Selected = SelectItem 
    SelectItem = 0
  End If

  For i=0 To UBound(ArrID)
    id = ArrID(i)
    If (id = iTunesID) Then
      am.AddItem "iTunes", "moveUpiTunes"
    ElseIf (id = WinTVID) Then
      am.AddItem "Hauppauge WinTV", "moveUpWinTV"
    ElseIf (id = MoreTVID) Then
      am.AddItem "MoreTV", "moveUpMoreTV"
    ElseIf (id = WinampID) Then
      am.AddItem "Winamp", "moveUpWinamp"
    ElseIf (id = PowerDVDID) Then
      am.AddItem "PowerDVD 5.0", "moveUpPowerDVD"
    ElseIf (id = WinDVD5ID) Then
      am.AddItem "WinDVD 5", "moveUpWinDVD5"
    ElseIf (id = WinDVD4ID) Then
      am.AddItem "WinDVD 4", "moveUpWinDVD4"
    ElseIf (id = ZoomPlayerID) Then
      am.AddItem "ZoomPlayer", "moveUpZoomPlayer"
    ElseIf (id = BSPlayerID) Then
      am.AddItem "BSPlayer", "moveUpBSPlayer"
    ElseIf (id = MediaPlayerID) Then
      am.AddItem "Media Player 9", "moveUpMediaPlayer"
    ElseIf (id = VolumeControlID) Then
      am.AddItem "Volume Control", "moveUpVolumeControl"
    ElseIf (id = MouseControlID) Then
      am.AddItem "Mouse Control", "moveUpMouseControl"
    ElseIf (id = PowerPointID) Then
      am.AddItem "PowerPoint", "moveUpPowerPoint"
    ElseIf (id = MiscControlID) Then
      am.AddItem "Misc Control", "moveUpMiscControl"
    ElseIf (id = MSAgentID) Then
      am.AddItem "MS Agent", "moveUpMsAgent"
    End If
  Next
  
  am.Back = "settingsMenu2"
  am.Update
End Sub

Sub moveUpiTunes
  moveMenuItemUp(iTunesID)
End Sub

Sub moveUpWinTV
  moveMenuItemUp(WinTVID)
End Sub

Sub moveUpMoreTV
  moveMenuItemUp(MoreTVID)
End Sub

Sub moveUpWinamp
  moveMenuItemUp(WinampID)
End Sub

Sub moveUpPowerDVD
  moveMenuItemUp(PowerDVDID)
End Sub

Sub moveUpWinDVD5
  moveMenuItemUp(WinDVD5ID)
End Sub

Sub moveUpWinDVD4
  moveMenuItemUp(WinDVD4ID)
End Sub

Sub moveUpZoomPlayer
  moveMenuItemUp(ZoomPlayerID)
End Sub

Sub moveUpBSPlayer
  moveMenuItemUp(BSPlayerID)
End Sub

Sub moveUpMediaPlayer
  moveMenuItemUp(MediaPlayerID)
End Sub

Sub moveUpVolumeControl
  moveMenuItemUp(VolumeControlID)
End Sub

Sub moveUpMouseControl
  moveMenuItemUp(MouseControlID)
End Sub

Sub moveUpPowerPoint
  moveMenuItemUp(PowerPointID)
End Sub

Sub moveUpMiscControl
  moveMenuItemUp(MiscControlID)
End Sub

Sub moveUpMsAgent
  moveMenuItemUp(MsAgentID)
End Sub

Sub moveMenuItemUp(id)
  Dim i, limit, temp
  limit = UBound(ArrID)
  For i=1 to limit
    If(id = ArrID(i)) Then
      If (i=1) Then
        temp = ArrID(1)
        removeElementAt(1)
        addElement(temp)
        SelectItem = limit
      Else
        temp = ArrID(i-1)
        ArrID(i-1) = ArrID(i)
        ArrID(i) = temp
        SelectItem = i-1
      End If
      Exit For
    End If
  Next
  setOrderMenuItems
End Sub



'---------------------------- read and save file functions --------------------

Sub saveSettings
  Set File = Fso.OpenTextFile(SettingsFile, ForWriting, True)
  File.WriteLine ScriptVersion
  File.WriteLine T610Enabled

  File.WriteLine SettingBackOption

  For each id in ArrID
    File.WriteLine id
  Next

  File.WriteLine "EOF"
  
  File.Close
End Sub

Sub deleteSettings
    If (Fso.FileExists(SettingsFile)) Then
      Set File = Fso.GetFile(SettingsFile)
      File.Delete
    End If
End Sub

Sub readSettings
  Dim i, temp, dummy
  If (Fso.FileExists(SettingsFile)) Then
    Set File = Fso.OpenTextFile(SettingsFile, ForReading)

    If(ScriptVersion <> File.ReadLine) Then	'1st line in settings file
      File.Close
      deleteSettings
    Else
      SaveSettingsBool = True
      T610Enabled = File.ReadLine

      SettingBackOption = File.ReadLine

      Erase ArrID
      ReDim ArrID(0)
      dummy = File.ReadLine	'first element of array is empty
      temp = File.ReadLine
      If (temp <> "EOF") Then
        While (temp <> "EOF")
          addElement(temp)
          temp = File.ReadLine
        Wend 
      End If
      File.Close
      
      selectPhone
    End If
  End If
End Sub


'---------------------------- End Active Menu ---------------------------------

'---------------------------- Start Webcam ------------------------------------

Sub OnTakeSinglePicture
 Dim cmd
 If fma.Connected = 1 Then
   TakePicture
 Else
   fma.Debug "Webcam - Not Connected to Phone"
 End If
End Sub

Sub OnStartWebcam
 Dim cmd
 If fma.Connected = 1 Then
   ' check if new can take picture on every 2 seconds
   ' (wait for previous call to finish)
   fma.AddTimer 2000, "OnTakeSinglePicture"
 Else
   MsgBox "Webcam - Not Connected to Phone"
 End If
End Sub

Sub OnStopWebcam
 fma.DeleteTimer "OnTakeSinglePicture"
End Sub

Sub TakePicture
 Dim cmd
 If fma.Connected = 1 Then
   fma.Debug "Webcam - Picturing..."

   cmd = "at+clck=""CS"",0" ' Unlock phone
   Transmit cmd
   fma.Sleep (1000)
   cmd = "AT+CKPD="":C""" ' Enter camera mode
   Transmit cmd
   fma.Sleep (1000)
   cmd = "AT+CKPD="":C""" ' Take picture
   Transmit cmd

   ' create filename here to get the (more or less) exact time & date of the picture
   outputfile = outputdirectory & Year(Date) & "-" & LeadZero(Month(Date)) & "-" & LeadZero(Day(Date)) & "_" & LeadZero(Hour (time)) & "-" & LeadZero(Minute (time)) & "-" & LeadZero(Second (time)) & ".jpg"

   fma.Sleep (9000)
   cmd = "AT+CKPD="":C""" ' Save picture
   Transmit cmd
   fma.Sleep (5000)
   cmd = "AT+CKPD="":R""" ' Return to main menu
   Transmit cmd
   fma.Sleep (1000)
   cmd = "AT+CKPD="":R"""
   Transmit cmd

   fma.ObexCut outputfile, filename
   fma.Debug "Webcam - Picture taked"
 End If
End Sub

Function delay(N)   ' delay N seconds
   Dim StartTime, EndTime
   StartTime = Timer
   EndTime = Timer + N
   Do
   Loop while EndTime > Timer
End Function

Function LeadZero(ByVal N)
   if (N>=0) and (N<10) then LeadZero = "0" & N else LeadZero = "" & N
End Function

'---------------------------- End Webcam --------------------------------------

'---------------------------- Begin WinDVD 5 ----------------------------------
' TODO: Split ni several submenus!!!

sub OnAMPDVD
' am.Selected = 1
' am.Update
  am.Clear
  am.Title = "WinDVD"
  am.AddItem "Play/Select", "OnAMPDVDPlay"
  am.AddItem "Pause", "OnAMPDVDPause"
  am.AddItem "Stop", "OnAMPDVDStop"
  am.AddItem "Prev Chapter", "OnAMPDVDPrev"
  am.AddItem "Next Chapter", "OnAMPDVDNext"
  am.AddItem "Go Up", "OnAMPDVDGoUp"
  am.AddItem "Go Down", "OnAMPDVDGoDown"
' am.AddItem "Step Forward", "OnAMPDVDStepFwd"
  am.AddItem "Subtitles", "OnAMPDVDSubtitle"
  am.AddItem "Volume Up", "OnAMPDVDVolInc"
  am.AddItem "Volume Down", "OnAMPDVDVolDec"
  am.AddItem "Mute/UnMute", "OnAMPDVDVolMute"
  am.AddItem "Full Screen", "OnAMPDVDFull"
  am.AddItem "Speed Down", "OnAMPDVDSpeedDown"
  am.AddItem "Speed Up", "OnAMPDVDSpeedUp"
' am.AddItem "Step", "OnAMPDVDStep"
' am.AddItem "Audio Lang", "OnAMPDVDAudio"
' am.AddItem "Chapter", "OnAMPDVDChapter"
  am.AddItem "Fast Forward", "OnAMPDVDFastForward"
  am.AddItem "Rewind", "OnAMPDVDRewind"
' am.AddItem "Playlist", "OnAMPDVDPlayList"
  am.AddItem "Main Menu", "OnAMPDVDMainMenu"
  am.AddItem "Launch", "OnAMPDVDLaunch"
  am.AddItem "Close", "OnAMPDVDClose"
  am.Back = "onAMRoot"
  am.Update
' OnAMPDVDLaunch
end sub

sub OnAMPDVDPlay
  if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys "~"
  am.Update
end sub

sub OnAMPDVDPause
  if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys "{ }"
  am.Update
end sub

sub OnAMPDVDAudio
  if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys "a"
  am.Update
end sub

sub OnAMPDVDChapter
  if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys "c"
  am.Update
end sub

sub OnAMPDVDFastForward
  if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys "f"
  am.Update
end sub

sub OnAMPDVDGoDown
  if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys "{DOWN}"
  am.Update
end sub

sub OnAMPDVDMainMenu
  if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys "^m"
  am.Update
end sub

sub OnAMPDVDSpeedDown
  if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys "^{LEFT}"
  am.Update
end sub

sub OnAMPDVDSpeedUp
  if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys "^{RIGHT}"
  am.Update
end sub

sub OnAMPDVDPlayList
  if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys "l"
  am.Update
end sub

sub OnAMPDVDRewind
  if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys "r"
  am.Update
end sub

sub OnAMPDVDStep
  if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys "n"
  am.Update
end sub

sub OnAMPDVDStop
  if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys "{END}"
  am.Update
end sub

sub OnAMPDVDPrev
  if shell.AppActivate("InterVideo WinDVD")then shell.SendKeys "{PGUP}"
  am.Update
end sub

sub OnAMPDVDNext
  if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys "{PGDN}"
  am.Update
end sub

sub OnAMPDVDSubtitle
  if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys "s"
  am.Update
end sub

sub OnAMPDVDGoUp
  if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys "{UP}"
  am.Update
end sub

sub OnAMPDVDStepFwd
  if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys "n"
  am.Update
end sub

sub OnAMPDVDVolInc
  if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys "+{UP}"
  am.Update
end sub

sub OnAMPDVDVolDec
  if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys "+{DOWN}"
  am.Update
end sub

sub OnAMPDVDVolMute
  if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys "m"
  am.Update
end sub

sub OnAMPDVDFull
  if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys "z"
  am.Update
end sub

sub OnAMPDVDLaunch
  shell.Run "C:\PROGRA~1\INTERV~1\WINDVD\WINDVD.EXE"
  am.Selected = 1
  am.Update
end sub

sub OnAMPDVDClose
  if shell.AppActivate("InterVideo WinDVD") then shell.SendKeys "x"
  am.Selected = 6
  am.Update
end sub

'----------------------------- End WinDVD 5 ------------------------------------

'---------------------------- Begin WinDVD 4 -----------------------------------
'These Key mappings are those used by WinDVD 4 rather than WinDVD 5
'Created 15/08/2004 RWT V1.0 
' TODO: Split in several submenus!!!

sub OnAMPDVD4
  am.Clear
  am.Title = "WinDVD 4"
  am.AddItem "Launch", "OnAMPDVDLaunch4"
  am.AddItem "Play/Select", "OnAMPDVDPlay4"
  am.AddItem "Fast Forward", "OnAMPDVDFastForward4"
  am.AddItem "Pause", "OnAMPDVDPause4"
  am.AddItem "Rewind", "OnAMPDVDRewind4"
  am.AddItem "Stop", "OnAMPDVDStop4"
  am.AddItem "Next Chapter", "OnAMPDVDNext4"
  am.AddItem "Prev Chapter", "OnAMPDVDPrev4"
  am.AddItem "Volume Up", "OnAMPDVDVolInc4"
  am.AddItem "Volume Down", "OnAMPDVDVolDec4"
  am.AddItem "Mute/UnMute", "OnAMPDVDVolMute4"
  am.AddItem "Subtitles", "OnAMPDVDSubtitle4"
  am.AddItem "Main Menu", "OnAMPDVDMainMenu4"
  am.AddItem "Full Screen", "OnAMPDVDFull4"
  am.addItem "Up","OnAMPDVDGoUp4"
  am.addItem "Down","OnAMPDVDGoDown4"
  am.addItem "Select","OnAMPDVDSelect4"
  am.AddItem "Close", "OnAMPDVDClose4"
  am.Back = "onAMRoot"
  am.Update
end sub

sub OnAMPDVDPlay4
  if shell.AppActivate("InterVideo WinDVD 4") then shell.SendKeys "~"
  am.Update
end sub

sub OnAMPDVDFastForward4
  if shell.AppActivate("InterVideo WinDVD 4") then shell.SendKeys "f"
  am.Update
end sub

sub OnAMPDVDPause4
  if shell.AppActivate("InterVideo WinDVD 4") then shell.SendKeys "{ }"
  am.Update
end sub

sub OnAMPDVDRewind4
  if shell.AppActivate("InterVideo WinDVD 4") then shell.SendKeys "r"
  am.Update
end sub

sub OnAMPDVDStop4
  if shell.AppActivate("InterVideo WinDVD 4") then shell.SendKeys "{END}"
  am.Update
end sub

sub OnAMPDVDNext4
  if shell.AppActivate("InterVideo WinDVD 4") then shell.SendKeys "{PGDN}"
  am.Update
end sub

sub OnAMPDVDPrev4
  if shell.AppActivate("InterVideo WinDVD 4")then shell.SendKeys "{PGUP}"
  am.Update
end sub

sub OnAMPDVDGoDown4
  if shell.AppActivate("InterVideo WinDVD 4") then shell.SendKeys "{DOWN}"
  am.Update
end sub

sub OnAMPDVDGoUp4
  if shell.AppActivate("InterVideo WinDVD 4") then shell.SendKeys "{UP}"
  am.Update
end sub

sub OnAMPDVDMainMenu4
  if shell.AppActivate("InterVideo WinDVD 4") then shell.SendKeys "^m"
  am.Update
end sub

sub OnAMPDVDSubtitle4
  if shell.AppActivate("InterVideo WinDVD 4") then shell.SendKeys "s"
  am.Update
end sub

sub OnAMPDVDSelect4
  if shell.AppActivate("InterVideo WinDVD 4") then shell.SendKeys "{ENTER}"
  am.Update
end sub

sub OnAMPDVDGoUp4
  if shell.AppActivate("InterVideo WinDVD 4") then shell.SendKeys "{UP}"
  am.Update
end sub


sub OnAMPDVDVolInc4
  if shell.AppActivate("InterVideo WinDVD 4") then shell.SendKeys "+{UP}"
  am.Update
end sub

sub OnAMPDVDVolDec4
  if shell.AppActivate("InterVideo WinDVD 4") then shell.SendKeys "+{DOWN}"
  am.Update
end sub

sub OnAMPDVDVolMute4
  if shell.AppActivate("InterVideo WinDVD 4") then shell.SendKeys "m"
  am.Update
end sub

sub OnAMPDVDFull4
  if shell.AppActivate("InterVideo WinDVD 4") then shell.SendKeys "z"
  am.Update
end sub

sub OnAMPDVDLaunch4
  shell.Run "C:\PROGRA~1\INTERV~1\WINDVD4\WINDVD.EXE"
  am.Selected = 1
  am.Update
end sub

sub OnAMPDVDClose4
  if shell.AppActivate("InterVideo WinDVD 4") then shell.SendKeys "x"
  am.Selected = 6
  am.Update
end sub
'------------------------------ End WinDVD 4-----------------------------------


'----------------------------- Begin iTunes -----------------------------------

sub OnAMiTunes
  am.Clear
  am.Title = "iTunes"
  am.AddItem "Play/Pause", "OnAMiTPlayPause"
  am.AddItem "Stop", "OnAMiTStop"
  am.AddItem "Prev Track", "OnAMiTPrev"
  am.AddItem "Next Track", "OnAMiTNext"
  am.AddItem "Vizualizer", "OnAMiTFullScreen"
  am.AddItem "Launch", "OnAMiTLaunch"
  am.AddItem "Close", "OnAMiTClose"
  am.Back = "onAMRoot"
  am.Update
end sub

sub OnAMiTPlayPause
  if shell.AppActivate("iTunes") then shell.SendKeys " "
  am.Update
end sub

sub OnAMiTStop
  if shell.AppActivate("iTunes") then shell.SendKeys " "
  am.Update
end sub

sub OnAMiTPrev
  if shell.AppActivate("iTunes")then shell.SendKeys "^{LEFT}"
  am.Update
end sub

sub OnAMiTNext
  if shell.AppActivate("iTunes") then shell.SendKeys "^{RIGHT}"
  am.Update
end sub

sub OnAMiTFullScreen
  if shell.AppActivate("iTunes") then shell.SendKeys "^t"
am.Update
end sub

sub OnAMiTLaunch
  'Specify correct path to the executable here:
  shell.Run "iTunes.exe"
  am.Selected = 1
  am.Update
end sub

sub OnAMiTClose
  if shell.AppActivate("iTunes") then shell.SendKeys "%{F4}"
  am.Selected = 6
  am.Update
end sub

'------------------------------ End iTunes ------------------------------------

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

  fma.Debug "Phone located"
  End If
End Sub

'--------------------------- End Locate Phone ---------------------------------

'---------------------------- Begin ZoomPlayer ------------------------------------

Sub OnAMZoomPlayer
  ZoomPlayerOpen = shell.AppActivate("Zoom Player")
  am.clear
  ZoomPlayerMenu
End Sub

Sub ZoomPlayerMenu
  am.ClearMenu
  am.Title = "ZoomPlayer"

  If (ZoomPlayerOpen) Then
    am.AddItem "Play/Pause", "OnAMZoomPlayerPlay"
    am.AddItem "Stop", "OnAMZoomPlayerStop"
    am.AddItem "Prev Chapter", "OnAMZoomPlayerPrev"
    am.AddItem "Next Chapter", "OnAMZoomPlayerNext"
    am.AddItem "Jump ahead", "OnAMZoomPlayerJumpahead"
    am.AddItem "Jump back", "OnAMZoomPlayerJumpback"
    am.AddItem "Subtitles", "OnAMZoomPlayerSubtitle"
    am.AddItem "Volume Up", "OnAMZoomPlayerVolInc"
    am.AddItem "Volume Down", "OnAMZoomPlayerVolDec"
    am.AddItem "Mute/UnMute", "OnAMZoomPlayerVolMute"
    am.AddItem "Full Screen", "OnAMZoomPlayerFull"
    am.AddItem "Fast Forward", "OnAMZoomPlayerFastForward"
    am.AddItem "Rewind", "OnAMZoomPlayerRewind"
    am.AddItem "Close", "OnAMZoomPlayerClose"
  Else
    am.AddItem "Launch", "OnAMZoomPlayerLaunch"
  End If
  If (SettingBackOption) Then am.AddItem MenuItemBack, "onAMRoot"

  am.Back = "onAMRoot"
  am.Update
End Sub

sub OnAMZoomPlayerLaunch
  'Specify correct path to the executable here:
  shell.Run ZoomPlayerExe
  ZoomPlayerOpen = TRUE
  ZoomPlayerMenu
end sub

sub OnAMZoomPlayerClose
  if shell.AppActivate("Zoom Player") then shell.SendKeys "%x"
  ZoomPlayerOpen = FALSE
  ZoomPlayerMenu
end sub

sub OnAMZoomPlayerPlay
  if shell.AppActivate("Zoom Player") then shell.SendKeys "p"
  am.Update
end sub

sub OnAMZoomPlayerFastForward
  if shell.AppActivate("Zoom Player") then shell.SendKeys "%{HOME}"
  am.Update
end sub

sub OnAMZoomPlayerJumpback
  if shell.AppActivate("Zoom Player") then shell.SendKeys "%,"
  am.Update
end sub

sub OnAMZoomPlayerJumpahead
  if shell.AppActivate("Zoom Player") then shell.SendKeys "%."
  am.Update
end sub

sub OnAMZoomPlayerRewind
  if shell.AppActivate("Zoom Player") then shell.SendKeys "%{END}"
  am.Update
end sub

sub OnAMZoomPlayerStop
  if shell.AppActivate("Zoom Player") then shell.SendKeys "s"
  am.Update
end sub

sub OnAMZoomPlayerPrev
  if shell.AppActivate("Zoom Player")then shell.SendKeys "+["
  am.Update
end sub

sub OnAMZoomPlayerNext
  if shell.AppActivate("Zoom Player") then shell.SendKeys "+]"
  am.Update
end sub

sub OnAMZoomPlayerSubtitle
  if shell.AppActivate("Zoom Player") then shell.SendKeys "+;"
  am.Update
end sub

sub OnAMZoomPlayerVolInc
  if shell.AppActivate("Zoom Player") then shell.SendKeys "+{UP}"
  am.Update
end sub

sub OnAMZoomPlayerVolDec
  if shell.AppActivate("Zoom Player") then shell.SendKeys "+{DOWN}"
  am.Update
end sub

sub OnAMZoomPlayerVolMute
  if shell.AppActivate("Zoom Player") then shell.SendKeys "^m"
  am.Update
end sub

sub OnAMZoomPlayerFull
  if shell.AppActivate("Zoom Player") then shell.SendKeys "%{ENTER}"
  am.Update
end sub

'------------------------------ End ZoomPlayer ------------------------------------

