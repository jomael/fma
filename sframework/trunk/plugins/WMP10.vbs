'FMA Script Framework Core Plugin
'WMP9/10
'Advanced WMP control using uICE plugin

'1.0: basic functionality

'TODO:
'some testing and fixing... 
'seeking

Class WMP10

Private m_Self
Private mainMenu
Private playlistsMenu
Private curPlaylistMenu
Private searchMenu
Private update
Private WMPcurrentItemState
Private WMPCtrl
Private WMPplaylist
Private WMPsearchSt
Private WMPsearchType
Private WMPsearchSubS
Private rootMenu
Private eventReg

'Some info about the plugin
Public Property Get SHOWABLE 'Do I have a menu?
 SHOWABLE    = True
End Property
Public Property Get TITLE 'What's my name?
 TITLE       = "WMP9/10"
End Property
Public Property Get DESCRIPTION 'What's my purpose?
 DESCRIPTION = "Controls Windows Media Player 9 / 10"
End Property
Public Property Get AUTHOR 'Who created me?
 AUTHOR      = "mhr"
End Property
Public Property Get URL 'Were can I be found? Where can you get more information?
 URL = "http://www.mobileagent.info/forums/"
End Property

'Who am I?
Public Property Let Self (s)
 m_Self = s
 Set mainMenu   = New ManagedMenu
 Set playlistsMenu = New ManagedMenu
 Set curPlaylistMenu = New ManagedMenu
 Set searchMenu = New ManagedMenu
 WMPcurrentItemState = ""
 update = False
 eventReg = False
End Property
Public Property Get Self
 Self = m_Self
End Property

Sub Show()
 Dim menuList, bi
 rootMenu = True

 Set menuList = New LinkedList
 bi = menuList.BackInserter

 If WMPRunning Then
   WMPcurrentItemState = currentItemState
   If WMPcurrentItemState = "(blank playlist)" Then
     bi.Item = Array(WMPcurrentItemState, 	Self & ".Playlists")
   Else
     bi.Item = Array(WMPcurrentItemState, 	Self & ".currPlaylist")
     If WMPCtrl.playState=2 Then
       bi.Item = Array("Resume", 	Self & ".mp9PlayPause")
       bi.Item = Array("Stop", 		Self & ".mp9Stop")
'       bi.Item = Array("Seek", 		Self & ".mp9enterSeek")
     ElseIf (WMPCtrl.playState=3) Then
       bi.Item = Array("Pause", 	Self & ".mp9PlayPause")
       bi.Item = Array("Stop", 		Self & ".mp9Stop")
'       bi.Item = Array("Seek", 		Self & ".mp9enterSeek")
     ElseIf (WMPCtrl.playState=9) Then
       bi.Item = Array("Play", 		Self & ".mp9PlayPause")
       bi.Item = Array("Stop", 		Self & ".mp9Stop")
     Else
       bi.Item = Array("Play", 		Self & ".mp9PlayPause")
     End If
   End If
   bi.Item = Array("Playlist: " & WMPCtrl.currentPlaylist.name &", items: "& WMPCtrl.currentPlaylist.count, Self & ".Playlists")
   bi.Item = Array("Search in Library", Self & ".mp9LibrarySearch")
   If WMPCtrl.settings.getMode("shuffle") Then
     bi.Item = Array("[*] Shuffle", 	Self & ".mp9Shuffle")
   Else
     bi.Item = Array("[  ] Shuffle", 	Self & ".mp9Shuffle")
   End If
   If WMPCtrl.settings.getMode("loop") Then
     bi.Item = Array("[*] Repeat", 	Self & ".mp9Repeat")
   Else
     bi.Item = Array("[  ] Repeat", 	Self & ".mp9Repeat")
   End If
   bi.Item = Array("Fullscreen", 	Self & ".mp9Fullscreen")
   bi.Item = Array("Close WMP", 	Self & ".mp9Close")

 Else
   WMPcurrentItemState = ""
   bi.Item = Array("Launch WMP", 	Self & ".mp9Launch")
 End If

 mainMenu.SetList menuList
 mainMenu.Title = TITLE
 If update Then
   mainMenu.UpdatePage(page)
   update = False
 Else
   mainMenu.ShowMenu
 End If
 If Not eventReg Then
  EventManager.RegisterEvent "MenuClose",      Self & ".ExitMenu", Me
  KeyManager.RegisterKey KEY_JOYLEFT, Self & ".mp9PrevItem", STATE_PRESS, Me
  KeyManager.RegisterKey KEY_JOYRIGHT, Self & ".mp9NextItem", STATE_PRESS, Me
  fma.AddTimer 3500, Self & ".Timer"
  EventManager.RegisterEvent "OnDisconnected", "fma.DeleteTimer " & Self & ".Timer", Me
  eventReg = True
 End If
End Sub

Sub ExitMenu(title)
  If title = Me.TITLE Then
    Set WMPCtrl = Nothing
    Set WMPplaylist = Nothing
    EventManager.DeregisterAll Me
    KeyManager.DeregisterAll Me
	fma.DeleteTimer Self & ".Timer"
	eventReg = False
  End If
End Sub

Sub Timer
  Dim prevState
  If WMPRunning And rootMenu Then
    If WMPcurrentItemState <> currentItemState Then
	  Debug.DebugMsg "WMPMenu refresh"
	  update = True
	  Me.Show
	End If
  ElseIf rootMenu And WMPcurrentItemState<>"" Then
	Debug.DebugMsg "WMPMenu refresh"
	Me.Show
  End If
End Sub

Function WMPRunning
  On Error Resume Next
  If ActiveXManager("WMPuICE.WMPApp").Running Then Set WMPCtrl = ActiveXManager("WMPuICE.WMPApp").Core
  WMPRunning = ActiveXManager("WMPuICE.WMPApp").Running
  If Err.Number <> 0 Then 
    WMPRunning = False
	Debug.ErrorMsg "Error with WMP plugin - " & Err.Description
	Err.Clear
  End If
  On Error GoTo 0
End Function

Function currentItemState
 dim songName
 If WMPRunning Then
   If (WMPCtrl.currentPlaylist.count>0) Then
     songName = WMPCtrl.currentMedia.name
     If (WMPCtrl.currentMedia.getItemInfo("Artist")<>"") Then
       songName = songName & " - " & WMPCtrl.currentMedia.getItemInfo("Artist")
     End If
     If (WMPCtrl.playState=2) Then
       currentItemState = "| | " & songName
     ElseIf (WMPCtrl.playState=3) Then
       currentItemState = "> " & songName
     ElseIf (WMPCtrl.playState=9) Then
       currentItemState = "[opening] " & songName
     Else
       currentItemState = "[ ] " & songName
     End If
   Else
     currentItemState = "(blank playlist)"
   End If
 Else
   currentItemState = ""
 End If
End Function

Sub mp9PlayPause()
  If WMPRunning Then
    If (WMPCtrl.playstate=3) Then 
      WMPCtrl.controls.pause 
    Else 
      WMPCtrl.controls.play
    End If
  End If
  update = True
  Me.Show
End Sub

Sub mp9Stop()
  If WMPRunning Then
    WMPCtrl.controls.stop
  End If
  update = True
  Me.Show
End Sub

Sub mp9NextItem()
  If WMPRunning And rootMenu Then
    WMPCtrl.controls.next
    update = True
    Me.Show
  End If
End Sub

Sub mp9PrevItem()
  If WMPRunning And rootMenu Then
    WMPCtrl.controls.previous
    update = True
    Me.Show
  End If
End Sub

Sub mp9Fullscreen
  If WMPRunning Then
    WMPplugin.Fullscreen
  End If
  update = True
  Me.Show
End Sub

Sub mp9Shuffle()
  If WMPRunning Then
    WMPCtrl.settings.setMode "shuffle", not(WMPCtrl.settings.getMode("shuffle"))
  End If
  update = True
  Me.Show
End Sub

Sub mp9Repeat()
  If WMPRunning Then
    WMPCtrl.settings.setMode "loop", not (WMPCtrl.settings.getMode("loop"))
  End If
  update = True
  Me.Show
End Sub

Sub Playlists
  If WMPRunning Then
    rootMenu = False
    am.DlgFeedback "Loading...", ""
    am.update
    Me.mp9listPlaylists
  Else
    Me.Show
  End If
End Sub

Sub mp9listPlaylists
  Dim menuList, bi, i, j

  Set menuList = New LinkedList
  bi = menuList.BackInserter

  If WMPRunning Then
    j = CInt(WMPCtrl.playlistCollection.getAll.count)

    If j=0 Then
      bi.Item = Array("None available", Self & ".QuitPlaylistsMenu")
    Else
      For i=0 to j-1
        bi.Item = Array( WMPCtrl.playlistCollection.getAll.item(i).name, Self & ".mp9PsClick " & i)
      Next
    End If

    playlistsMenu.SetList menuList
    playlistsMenu.Title = "Playlists"
    playlistsMenu.ShowMenu
  Else
    Me.Show
  End If
End Sub

Sub QuitPlaylistsMenu
  playlistsMenu.QuitNoShow
  Me.Show
End Sub

Sub mp9PsClick(i)
  If WMPRunning Then
    WMPCtrl.currentPlaylist = WMPCtrl.playlistCollection.getAll.item(i)
  End If
  playlistsMenu.QuitNoShow
  Me.Show
End Sub

Sub currPlaylist
  If WMPRunning Then
    rootMenu = False
    am.DlgFeedback "Loading...", "mediaPlayer"
    am.update
    Set WMPplaylist = WMPCtrl.currentPlaylist
    WMPsearchSubS = FALSE
    Me.mp9browsePlaylist
  Else
    Me.Show
  End If
End Sub

Sub mp9browsePlaylist
  Dim menuList, bi, i, j, s1

  Set menuList = New LinkedList
  bi = menuList.BackInserter

  If WMPRunning Then
    j = WMPplaylist.count
    If j=0 Then
      If WMPsearchSubS Then
        bi.Item = Array("No matches found", Self & ".QuitListMenu")
      Else
        bi.Item = Array("No EXACT matches", Self & ".QuitListMenu")
        bi.Item = Array("Search more", Self & ".mp9bySubStr")
      End If
    Else
      For i=0 to j-1
        s1 = WMPplaylist.item(i).name
        If (WMPplaylist.item(i).getItemInfo("Artist")<>"") Then
          s1 = s1 & " - " & WMPplaylist.item(i).getItemInfo("Artist")
        End If
        bi.Item = Array(s1, Self & ".mp9PClick " & i)
      Next
    End If

    curPlaylistMenu.SetList menuList
    curPlaylistMenu.Title = j & " items"
    curPlaylistMenu.ShowMenu
  Else
    Me.Show
  End If
End Sub

Sub QuitListMenu
  curPlaylistMenu.QuitNoShow
  Me.Show
End Sub

Sub mp9PClick(i)
  If WMPRunning Then
    If (not (WMPCtrl.currentPlaylist.isIdentical(WMPplaylist))) Then
      WMPCtrl.currentPlaylist = WMPplaylist
    End If
    WMPCtrl.controls.currentItem = WMPplaylist.item(i)
    WMPCtrl.controls.play
  End If
  curPlaylistMenu.QuitNoShow
  Me.Show
End Sub

Sub mp9LibrarySearch
  If WMPRunning Then
    Dim menuList, bi
    rootMenu = False
    WMPsearchSubS = False

    Set menuList = New LinkedList
    bi = menuList.BackInserter

    bi.Item = Array("by Author", Self & ".mp9byAuthor")
    bi.Item = Array("by Title", Self & ".mp9byName")
    bi.Item = Array("by Album", Self & ".mp9byAlbum")
    bi.Item = Array("by Genre", Self & ".mp9byGenre")

    searchMenu.SetList menuList
    searchMenu.Title = "Search Library"
    searchMenu.ShowMenu
  Else
    Me.Show
  End If
End Sub

Sub mp9byAuthor
  If WMPRunning Then
    am.DlgInputStr "Search author","Author:",30,"",Self & ".mp9Search1"
    am.NextState = 2
	am.Back = Self & ".mp9LibrarySearch"
  Else
    searchMenu.QuitNoShow
    Me.Show
  End If
End Sub
Sub mp9byName
  If WMPRunning Then
    am.DlgInputStr "Search item","Title:",30,"",Self & ".mp9Search2"
    am.NextState = 2
	am.Back = Self & ".mp9LibrarySearch"
  Else
    searchMenu.QuitNoShow
    Me.Show
  End If
End Sub
Sub mp9byAlbum
  If WMPRunning Then
    am.DlgInputStr "Search album","Album:",30,"",Self & ".mp9Search3"
    am.NextState = 2
	am.Back = Self & ".mp9LibrarySearch"
  Else
    searchMenu.QuitNoShow
    Me.Show
  End If
End Sub
Sub mp9byGenre
  If WMPRunning Then
    am.DlgInputStr "Search genre","Genre:",20,"",Self & ".mp9Search4"
    am.NextState = 2
	am.Back = Self & ".mp9LibrarySearch"
  Else
    searchMenu.QuitNoShow
    Me.Show
  End If
End Sub

Sub mp9bySubStr
  If WMPRunning Then
    dim mItem,j,k
    WMPsearchSubS = TRUE
    am.DlgFeedback "Searching...", ""
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
    searchMenu.QuitNoShow
    Me.Show
  End If
End Sub

Sub mp9Search1(s)
  am.DlgFeedback "Searching...", ""
  am.update
  WMPsearchSt = s
  WMPsearchType = "Author"
  Set WMPplaylist = WMPCtrl.mediaCollection.getByAuthor(WMPsearchSt)
  searchMenu.QuitNoShow
  mp9browsePlaylist
End Sub
Sub mp9Search2(s)
  am.DlgFeedback "Searching...", ""
  am.update
  WMPsearchSt = s
  WMPsearchType = "Title"
  Set WMPplaylist = WMPCtrl.mediaCollection.getByName(WMPsearchSt)
  searchMenu.QuitNoShow
  mp9browsePlaylist
End Sub
Sub mp9Search3(s)
  am.DlgFeedback "Searching...", ""
  am.update
  WMPsearchSt = s
  WMPsearchType = "Album"
  Set WMPplaylist = WMPCtrl.mediaCollection.getByAlbum(WMPsearchSt)
  searchMenu.QuitNoShow
  mp9browsePlaylist
End Sub
Sub mp9Search4(s)
  am.DlgFeedback "Searching...", ""
  am.update
  WMPsearchSt = s
  WMPsearchType = "Genre"
  Set WMPplaylist = WMPCtrl.mediaCollection.getByGenre(WMPsearchSt)
  searchMenu.QuitNoShow
  mp9browsePlaylist
End Sub

Sub mp9Launch()
  Dim i, AppOpen
  If (WMPRunning) Then
    Me.Show
  Else
    Util.LaunchAppDlg
    AppOpen = False
    On Error Resume Next
    ActiveXManager("WMPuICE.WMPApp").Open
    For i=1 to 8          'Tries 8 times each second if WMP is on
      fma.Sleep (1000)
      WMPCtrl = null
      Set WMPCtrl = ActiveXManager("WMPuICE.WMPApp").Core
      If (not IsNull(WMPCtrl)) Then
        AppOpen =  ActiveXManager("WMPuICE.WMPApp").Running
        fma.Sleep (100)
        Exit For
      End If
    Next
    On Error GoTo 0
    If AppOpen Then
      WMPRunning    'without this lockups happended sometimes
      Me.Show
    Else
     Util.DisplayMsgBox "Application didn't respond...", 3, ""
     Me.Show
    End If
  End If
End Sub

Sub mp9Close()
'  fma.DeleteTimer("mediaPlayerUpdate")
  If WMPRunning Then
    Util.CloseAppDlg
    ActiveXManager("WMPuICE.WMPApp").Close
  End If
  rootMenu = False
  mainMenu.Quit
End Sub

End Class