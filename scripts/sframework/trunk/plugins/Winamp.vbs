'FMA Script Framework Plugin
'Winamp
'This plugin controls WinAmp

'TODO:
'-Extend Seek dialogue (see carpediem, keep up to date with the tracks current position)

Const WINAMP_SEARCH_ARTIST_MATCH  = 0
Const WINAMP_SEARCH_ARTIST_SUBSTR = 1
Const WINAMP_SEARCH_TITLE_MATCH   = 2
Const WINAMP_SEARCH_TITLE_SUBSTR  = 3
Const WINAMP_SEARCH_BOTH_MATCH    = 4
Const WINAMP_SEARCH_BOTH_SUBSTR   = 5
Const WINAMP_SEARCH_ONE_MATCH     = 6
Const WINAMP_SEARCH_ONE_SUBSTR    = 7

Class Winamp
	
	Private m_Self
	Private mainMenu
	Private playListMenu
	Private searchMenu
	Private InfoBox
	Public playlistExplorer
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = True
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = g_(Me,"WinAmp")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"This plugin controls winamp. You may use the menu and the phones volume keys.")
	End Property
	Public Property Get AUTHOR 'Who created me?
		AUTHOR      = "dVrVm (also starring streawkceur)"
	End Property
	Public Property Get URL 'Were can I be found? Where can you get more information?
		URL = "http://fma.xinium.com/"
	End Property
	
	'Who am I?
	Public Property Let Self (s)
		m_Self = s
		' Some init stuff here:
		If IsEmpty(Settings(Me, "Title"))          or Settings(Me, "Title") = ""          Then Settings(Me, "Title")          = "Winamp"
		If IsEmpty(Settings(Me, "Exe"))            or Settings(Me, "Exe")   = ""          Then Settings(Me, "Exe")            = "C:\Program Files\Winamp\winamp.exe"
		If IsEmpty(Settings(Me, "PlaylistFolder")) or Settings(Me, "PlaylistFolder") = "" Then Settings(Me, "PlaylistFolder") = Fso.GetParentFolderName(Settings(Me, "Exe"))
		Set mainMenu     = New ManagedMenu
		Set playListMenu = New ManagedMenu
		Set searchMenu   = New ManagedMenu
		Set InfoBox = New ManagedMenu
		'Init searchMenu
		Dim llist, bi
		Set llist = New LinkedList
		bi = llist.BackInserter
		bi.Item = Array(g_(Me,"Browse Artists"), m_Self & ".BrowseArtist")
		bi.Item = Array(g_(Me,"Search Artists"), m_Self & ".SearchArtist")
		bi.Item = Array(g_(Me,"Search Titles"),  m_Self & ".SearchTitle")
		bi.Item = Array(g_(Me,"Search Both"),    m_Self & ".SearchBoth")
		searchMenu.SetList llist
		searchMenu.Title = g_(Me,"Search/Browse")
	End Property
	Public Property Get Self
		Self = m_Self
	End Property
	
	'Display me. Eventually put a menu on the screen
	Sub Show()
		'Set the PathExe, launch the program
		If Fso.FileExists(Settings(Me, "Exe")) Then
			ActiveXManager("WinampCOMLib.WinampCOMObj").PathExe = Fso.GetParentFolderName(Settings(Me, "Exe"))
		Else
			Debug.ErrorMsg m_Self & " - Init: File not found: " & Settings(Me, "Exe")
		End If
		
		Dim llist, bi, state
		Set llist = New LinkedList
		bi = llist.BackInserter
		If ActiveXManager("WinampCOMLib.WinampCOMObj").WinampState = True Then
			state = ActiveXManager("WinampCOMLib.WinampCOMObj").GetSongState
			If state = "Playing" Then
				bi.Item = Array(g_(Me,"Restart"),      Self & ".Play")
			Else
				bi.Item = Array(g_(Me,"Play"),         Self & ".Play")
			End If
			If state = "Paused" Then
				bi.Item = Array(g_(Me,"Resume"),       Self & ".Pause")
			Else
				bi.Item = Array(g_(Me,"Pause"),        Self & ".Pause")
			End If
			bi.Item = Array(g_(Me,"Stop"),           Self & ".Stopp")
			bi.Item = Array(g_(Me,"<< Prev Track "), Self & ".PrevTrack")
			bi.Item = Array(g_(Me,">> Next Track "), Self & ".NextTrack")
			bi.Item = Array(g_(Me,"Volume"),         Self & ".Volume")
			bi.Item = Array(g_(Me,"Show Playlist"),  Self & ".Playlist")
			bi.Item = Array(g_(Me,"Load Playlist"),  Self & ".LoadPlaylist")
			bi.Item = Array(g_(Me,"Search/Browse"),  Self & ".SearchBrowse")
			bi.Item = Array("View file info", Self & ".Info")
'			bi.Item = Array("Seek",           Self & ".Seek")
			If ActiveXManager("WinampCOMLib.WinampCOMObj").ShuffleMode Then
				bi.Item = Array(g_(Me,"Shuffle Off"),  Self & ".Shuffle")
			Else
				bi.Item = Array(g_(Me,"Shuffle On"),   Self & ".Shuffle")
			End If
			If ActiveXManager("WinampCOMLib.WinampCOMObj").RepeatMode Then
				bi.Item = Array(g_(Me,"Repeat Off"),   Self & ".Repeat")
			Else
				bi.Item = Array(g_(Me,"Repeat On"),    Self & ".Repeat")
			End If
			bi.Item = Array(g_(Me,"Help"),           Self & ".Help")
			bi.Item = Array(g_(Me,"Close"),          Self & ".Close")
		Else
			bi.Item = Array(g_(Me,"Launch"),         Self & ".Launch")
		End If
		mainMenu.SetList llist
		mainMenu.Title = TITLE
		mainMenu.ShowMenu
		
		EventManager.RegisterEvent "MenuClose",      Self & ".ExitMenu", Me
		EventManager.RegisterEvent "ConnectionLost", Self & ".ExitMenu", Me
	End Sub
	
	Sub Launch
		If Fso.FileExists(Settings(Me, "Exe")) Then
			ActiveXManager("WinampCOMLib.WinampCOMObj").WinampState = True
			'Shell.Exec Settings(Me, "Exe")
			'Util.WaitForAppLoad Settings(Me, "Title"), 10000 'Give winamp max. 10 secs to load
		Else
			Debug.ErrorMsg Self & " - Launch: File not found: " & Settings(Me, "Exe")
		End If
		Show
	End Sub
	
	Sub Close
		ActiveXManager("WinampCOMLib.WinampCOMObj").WinampState = False
		Show
	End Sub
	
	Sub Play
		ActiveXManager("WinampCOMLib.WinampCOMObj").Play
		Show
	End Sub
	
	Sub Pause
		ActiveXManager("WinampCOMLib.WinampCOMObj").Pause
		Show
	End Sub
	
	Sub Stopp
		ActiveXManager("WinampCOMLib.WinampCOMObj").Stop
		Show
	End Sub
	
	Sub PrevTrack
		ActiveXManager("WinampCOMLib.WinampCOMObj").PreviousTrack
		Show
	End Sub
	
	Sub NextTrack
		ActiveXManager("WinampCOMLib.WinampCOMObj").NextTrack
		Show
	End Sub
	
	Sub Shuffle
		ActiveXManager("WinampCOMLib.WinampCOMObj").ShuffleMode = Not ActiveXManager("WinampCOMLib.WinampCOMObj").ShuffleMode
		Show
	End Sub
	
	Sub Repeat
		ActiveXManager("WinampCOMLib.WinampCOMObj").RepeatMode = Not ActiveXManager("WinampCOMLib.WinampCOMObj").RepeatMode
		Show
	End Sub
	
	Sub VolUp
		ActiveXManager("WinampCOMLib.WinampCOMObj").Volumeup
	End Sub
	Sub VolDn
		ActiveXManager("WinampCOMLib.WinampCOMObj").VolumeDown
	End Sub
	
	Sub VolUpPress
		fma.AddTimer 60, Self & ".VolUp"
	End Sub
	Sub VolUpRelease
		fma.DeleteTimer Self & ".VolUp"
	End Sub
	
	Sub VolDnPress
		fma.AddTimer 60, Self & ".VolDn"
	End Sub
	Sub VolDnRelease
		fma.DeleteTimer Self & ".VolDn"
	End Sub
	
	Sub Volume()
		EmptyMenu.ShowMenu
		'Volume Up
		KeyManager.RegisterKey KEY_VOLUP,    Self & ".VolUpPress",   STATE_PRESS,   Me
		KeyManager.RegisterKey KEY_JOYUP,    Self & ".VolUpPress",   STATE_PRESS,   Me
		KeyManager.RegisterKey KEY_JOYRIGHT, Self & ".VolUpPress",   STATE_PRESS,   Me
		KeyManager.RegisterKey KEY_VOLUP,    Self & ".VolUpRelease", STATE_RELEASE, Me
		KeyManager.RegisterKey KEY_JOYUP,    Self & ".VolUpRelease", STATE_RELEASE, Me
		KeyManager.RegisterKey KEY_JOYRIGHT, Self & ".VolUpRelease", STATE_RELEASE, Me
		'Volume Down
		KeyManager.RegisterKey KEY_VOLDOWN,  Self & ".VolDnPress",   STATE_PRESS,   Me
		KeyManager.RegisterKey KEY_JOYDOWN,  Self & ".VolDnPress",   STATE_PRESS,   Me
		KeyManager.RegisterKey KEY_JOYLEFT,  Self & ".VolDnPress",   STATE_PRESS,   Me
		KeyManager.RegisterKey KEY_VOLDOWN,  Self & ".VolDnRelease", STATE_RELEASE, Me
		KeyManager.RegisterKey KEY_JOYDOWN,  Self & ".VolDnRelease", STATE_RELEASE, Me
		KeyManager.RegisterKey KEY_JOYLEFT,  Self & ".VolDnRelease", STATE_RELEASE, Me
		Util.DisplayMsgBox g_(Me,"Increase Volume: Joy-up,-right,Vol-up - Decrease volume: Joy-down,-left,Vol-down"), 0, Self & ".VolumeQuit" 'Mangage the menu quit by ourselves
	End Sub
	Sub VolumeQuit()
		KeyManager.DeregisterAll Me
		MenuStack.Top.Quit 'Remove emtpy menu
	End Sub
	
	
	Sub ExitMenu ( sName )
		If sName = TITLE Then
			KeyManager.DeregisterAll Me
			EventManager.DeregisterAll Me
		End If
	End Sub
	
	Sub Help()
		EmptyMenu.ShowMenu
		Util.DisplayMsgBox g_(Me,"The menu should be mostly self-explaining."), 0, ""
	End Sub
	
	Sub Playlist ()
		Dim pList, pLbi, cnt, pageAndIndex
		'Retrieve playlist
		ActiveXManager("WinampCOMLib.WinampCOMObj").GetPlayList
		Set pList = New LinkedList
		pLbi = pList.BackInserter
		For cnt = 0 To ActiveXManager("WinampCOMLib.WinampCOMObj").GetPlayListLength - 1
			pLbi.Item = Array( getSong(cnt), Self & ".PlaySongShowPlaylist " & cnt)
		Next
		If pList.Count < 1 Then pLbi.Item = Array( g_(Me,"(empty)"), "am.Update" )
		playListMenu.Title = g_(Me,"Playlist")
		playListMenu.SetList pList
		pageAndIndex = playListMenu.GetPageAndIndexByItemIndex(ActiveXManager("WinampCOMLib.WinampCOMObj").GetPlayListPosition - 1)
		playListMenu.ShowPage(pageAndIndex(0)) 'Show page of currently played song
		am.Selected = pageAndIndex(1) + 1 'jump to song
		am.Update
	End Sub
	
	'Play song and show playlist again
	Sub PlaySongShowPlaylist( i )
    ActiveXManager("WinampCOMLib.WinampCOMObj").PlaySongByPosition(i)
		Playlist
	End Sub
	
	'Play song and show the search result again
	Sub PlaySongShowSearch( i )
    ActiveXManager("WinampCOMLib.WinampCOMObj").PlaySongByPosition(i)
		am.Update
	End Sub
	
	Private Function getSong(p)
		Dim s, artist, title, mark
		
		artist = Trim(ActiveXManager("WinampCOMLib.WinampCOMObj").GetArtistbyPosition(p))
		title  = Trim(ActiveXManager("WinampCOMLib.WinampCOMObj").GetSongTitlebyPosition(p))
		If artist <> "" And title <> "" Then
			s = artist & g_(Me," - ") & title
		Else
			s = artist & title
		End If
		s = Replace(s,"( ","(")
		s = Replace(s," )",")")
		s = Replace(s,"[ ","[")
		s = Replace(s," ]","]")
		
		If (ActiveXManager("WinampCOMLib.WinampCOMObj").GetPlayListPosition - 1 = p) Then	'if P is current song being played
		  mark = g_(Me,">") 'mark song
		Else
		  mark = g_(Me,"  ")
		End If
		getSong = mark & s
	End Function
	
	Sub LoadPlaylist()
		If PluginManager.IsLoaded("FileExplorer") Then
			'Create FileExplorer and browse the playlist folder from the settings
			PluginManager("FileExplorer").ShowDir Settings(Me, "PlaylistFolder"), 0
		Else
			Debug.ErrorMsg Self & "You will need the FileExplorer plugin to select playlists!"
			Util.DisplayMsgBox "You have to enable FileExplorer plugin to use this feature!", 5, ""
			am.Update
		End If
	End Sub
	
	Sub SearchBrowse()
		searchMenu.ShowMenu
	End Sub
	
	Sub Seek()
		EmptyMenu.ShowMenu
		ActiveXManager("WinampCOMLib.WinampCOMObj").SongPosParseTime = FALSE
		ActiveXManager("WinampCOMLib.WinampCOMObj").SetLengthParseTime = FALSE
		am.DlgPercent g_(Me,"Seek"), Self & ".SeekResult", 10, 10 * (ActiveXManager("WinampCOMLib.WinampCOMObj").GetSongPosition / ActiveXManager("WinampCOMLib.WinampCOMObj").GetSongLength / 1000)
	End Sub
	Sub SeekResult( value, final )
		If final = 1 Then
			ActiveXManager("WinampCOMLib.WinampCOMObj").JumpToTime value * (ActiveXManager("WinampCOMLib.WinampCOMObj").GetSongLength / 10)
			MenuStack.Top.Quit 'Remove emtpy menu
		End If
	End Sub
	
	Sub BrowseArtist()
		Dim llist, bi, cnt, tempMenu
		'Retrieve playlist
		ActiveXManager("WinampCOMLib.WinampCOMObj").GetPlayList
		Set llist = New LinkedList
		bi = llist.BackInserter
		For cnt = 0 To ActiveXManager("WinampCOMLib.WinampCOMObj").GetTotalUniqueArtist - 1
			bi.Item = Array(Trim(ActiveXManager("WinampCOMLib.WinampCOMObj").GetUniqueArtist(cnt)), Self & ".BrowseTracksByArtistAndTitle " & WINAMP_SEARCH_ARTIST_MATCH & ", """ & Trim(ActiveXManager("WinampCOMLib.WinampCOMObj").GetUniqueArtist(cnt)) & """, Empty")
		Next
		If llist.Count < 1 Then bi.Item = Array( g_(Me,"(empty)"), "am.Update" )
		Set tempMenu = New ManagedMenu
		tempMenu.Title = g_(Me,"Artists")
		tempMenu.SetList llist
		tempMenu.ShowMenu
	End Sub
	
	Sub SearchArtist()
		EmptyMenu.ShowMenu
		am.DlgInputStr g_(Me,"Search artists"), g_(Me,"Artists:"), 16, "", Self & ".SearchArtistResult"
	End Sub
	Sub SearchArtistResult( input )
		MenuStack.Pop 'Remove emtpy menu
		BrowseTracksByArtistAndTitle WINAMP_SEARCH_ARTIST_SUBSTR, input, ""
	End Sub
	
	Sub SearchTitle()
		EmptyMenu.ShowMenu
		am.DlgInputStr g_(Me,"Search titles"), g_(Me,"Titles:"), 16, "", Self & ".SearchTitleResult"
	End Sub
	Sub SearchTitleResult( input )
		MenuStack.Pop 'Remove emtpy menu
		BrowseTracksByArtistAndTitle WINAMP_SEARCH_TITLE_SUBSTR, "", input
	End Sub
	
	Sub SearchBoth()
		EmptyMenu.ShowMenu
		am.DlgInputStr g_(Me,"Search both"), g_(Me,"Artists/Titles:"), 16, "", Self & ".SearchBothResult"
	End Sub
	Sub SearchBothResult( input )
		MenuStack.Pop 'Remove emtpy menu
		BrowseTracksByArtistAndTitle WINAMP_SEARCH_ONE_SUBSTR, input, input
	End Sub
	
	Sub BrowseTracksByArtistAndTitle( searchType, a, t )
		a = LCase(Trim(a))
		t = LCase(Trim(t))
		Dim llist, bi, cnt, artist, title, tempMenu, match
		'Retrieve playlist
		ActiveXManager("WinampCOMLib.WinampCOMObj").GetPlayList
		Set llist = New LinkedList
		bi = llist.BackInserter
		For cnt = 0 To ActiveXManager("WinampCOMLib.WinampCOMObj").GetPlayListLength - 1
			artist = LCase(Trim(ActiveXManager("WinampCOMLib.WinampCOMObj").GetArtistbyPosition(cnt)))
			title  = LCase(Trim(ActiveXManager("WinampCOMLib.WinampCOMObj").GetSongTitlebyPosition(cnt)))
			match  = False
			Select Case searchType
				Case WINAMP_SEARCH_ARTIST_MATCH  If artist = a                                     Then match = True
				Case WINAMP_SEARCH_ARTIST_SUBSTR If InStr(artist, a) > 0                          Then match = True
				Case WINAMP_SEARCH_TITLE_MATCH   If title = t                                      Then match = True
				Case WINAMP_SEARCH_TITLE_SUBSTR  If InStr(title, t) > 0                           Then match = True
				Case WINAMP_SEARCH_BOTH_MATCH    If artist = a And title = t                      Then match = True
				Case WINAMP_SEARCH_BOTH_SUBSTR   If InStr(artist, a) > 0 And InStr(title, t) > 0 Then match = True
				Case WINAMP_SEARCH_ONE_MATCH     If artist = a Or title = t                       Then match = True
				Case WINAMP_SEARCH_ONE_SUBSTR    If InStr(artist, a) > 0 Or InStr(title, t) > 0  Then match = True
			End Select
			If match Then bi.Item = Array( getSong(cnt), Self & ".PlaySongShowSearch " & cnt )
		Next
		If llist.Count < 1 Then bi.Item = Array( g_(Me,"(no matches!)"), "am.Update" )
		Set tempMenu = New ManagedMenu
		tempMenu.SetList llist
		tempMenu.ShowMenu
	End Sub

' File info module (Written by Mr.Floppy - mr.floppy@mail.ru)
	Sub Info ()
		Dim tempList, backIns, state, artist, title, position, result, length, track, plength, bitrate, samplerate, chanel, file  
		ActiveXManager("WinampCOMLib.WinampCOMObj").GetPlayList
		state = ActiveXManager("WinampCOMLib.WinampCOMObj").GetSongState
		track = ActiveXManager("WinampCOMLib.WinampCOMObj").GetPlayListPosition
		artist = ActiveXManager("WinampCOMLib.WinampCOMObj").GetArtistbyPosition(track-1)
		title  = ActiveXManager("WinampCOMLib.WinampCOMObj").GetSongTitlebyPosition(track-1)
		length = ActiveXManager("WinampCOMLib.WinampCOMObj").GetSongLength
		position = ActiveXManager("WinampCOMLib.WinampCOMObj").GetSongPosition/1000
		If position > o Then
			progress = round(100/(length/position))
		Else
			progress = 0
		End If
		plength = ActiveXManager("WinampCOMLib.WinampCOMObj").GetPlayListLength
		bitrate = ActiveXManager("WinampCOMLib.WinampCOMObj").GetSongBitRate
		samplerate = ActiveXManager("WinampCOMLib.WinampCOMObj").GetSongSampleRate
		chanel = ActiveXManager("WinampCOMLib.WinampCOMObj").GetSongChanel
		If chanel = "1" Then chanel = "1 (Mono)"
		If chanel = "2" Then chanel = "2 (Stereo)"
		file = ActiveXManager("WinampCOMLib.WinampCOMObj").GetFileNamebyPosition(track-1)
		Set tempList = New LinkedList
		backIns = tempList.BackInserter
			backIns.Item = Array( "Artist: " & artist, "MenuStack.Top.Quit" )
			backIns.Item = Array( "Title: " & title, "MenuStack.Top.Quit" )
			backIns.Item = Array( "Position: " & ConvertToMin(position) & " (" & progress & "%)", "MenuStack.Top.Quit" )
			backIns.Item = Array( "Length: " & ConvertToMin(length), "MenuStack.Top.Quit" )
			backIns.Item = Array( "Track: " & track & " of " & plength, "MenuStack.Top.Quit" )
			backIns.Item = Array( "Bit rate: " & bitrate & " kbps", "MenuStack.Top.Quit" )
			backIns.Item = Array( "Sample rate: " & samplerate & " kHz", "MenuStack.Top.Quit" )
			backIns.Item = Array( "Chanels: " & chanel, "MenuStack.Top.Quit" )
			backIns.Item = Array( "File: " & file, "MenuStack.Top.Quit" )
		InfoBox.SetList tempList
		InfoBox.Title = state
		InfoBox.ShowMenu
	End Sub

	'Converting seconds to minutes and seconds (in format M:SS)
	Private Function ConvertToMin(input)
		Dim min, sec, p
		input = round(input)
		If input < 60 Then
			min = 0
			sec = input
		End If
		If input >= 60 Then
			min = input/60
			p = instr(min, ",")
			If p <> 0 Then min = mid(min, 1, p-1)
			sec = input - min*60
		End If
		If len(sec) = 1 Then sec = "0" & sec
		ConvertToMin = min & ":" & sec
End Function

End Class