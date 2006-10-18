'FMA Script Framework Plugin
'iTunes
'Lets you control Apple iTunes

'TODO:
'-Testing

const ITUNES_SEARCHTYPE_PL = 0
const ITUNES_SEARCHTYPE_LIB = 1

Class iTunes

Private m_Self
Private mainMenu
Private BrowsePlaylistMenu
Private SearchMenu



'Some info about the plugin
Public Property Get SHOWABLE 'Do I have a menu?
 SHOWABLE = True
End Property

Public Property Get TITLE 'What's my name?
 TITLE = g_(Me,"iTunes")
End Property

Public Property Get DESCRIPTION 'What's my purpose?
 DESCRIPTION = g_(Me,"Lets you control Apple iTunes")
End Property

Public Property Get AUTHOR 'Who created me?
 AUTHOR = "ElmarKirchner & Stumo (inspired by streawkceur (inspired by daveo))"
End Property

Public Property Get URL 'Were can I be found? Where can you get more information?
 URL = "http://fma.xinium.com/"
End Property

'Who am I?
Public Property Let Self (s)
 m_Self = s
 ' Some init stuff here:
 If IsEmpty(Settings(Me, "Title")) or Settings(Me, "Title") = "" Then Settings(Me, "Title") = "iTunes"
 If IsEmpty(Settings(Me, "Exe")) or Settings(Me, "Exe") = "" Then Settings(Me, "Exe") = "C:\Program Files\iTunes\iTunes.exe"
 Set mainMenu = New ManagedMenu
 mainMenu.Title = TITLE

 Set BrowsePlaylistMenu = New ManagedMenu
 Set SearchMenu = New ManagedMenu
End Property

Public Property Get Self
 Self = m_Self
End Property

'Display me. Eventually put a menu on the screen
Sub Show()
 Dim iTunesApp
 Set iTunesApp = CreateObject("iTunes.Application")

 '--> Init Menu
 Dim llist
 Set llist = New LinkedList
 Dim bi
 bi = llist.BackInserter

 Dim iTunesVersion
 iTunesVersion = iTunesApp.Version
 Debug.InfoMsg "iTunes Version " & iTunesVersion

 'If ObjectExist( iTunesApp.CurrentTrack ) Then
 'If Exist(iTunesApp.CurrentTrack) Then
 Debug.InfoMsg "Check if Object does exist!"
 'End If

 if iTunesApp.PlayerState = 0 Then
  bi.Item = Array("Play", Self & ".PlayPause")
 Else
  Dim TrackName, TrackArtist
  TrackArtist = iTunesApp.CurrentTrack.Artist
  TrackName = iTunesApp.CurrentTrack.Name
  bi.Item = Array(TrackArtist & " - " & TrackName, Self & ".TrackInfo")

  bi.Item = Array(g_(Me,"Pause"), Self & ".PlayPause")
  bi.Item = Array(g_(Me,"Stop"), Self & ".Stopp")
 End If

 bi.Item = Array(g_(Me,"Playlist"), Self & ".BrowsePlaylist")
 bi.Item = Array(g_(Me,"Prev Track"), Self & ".PrevTrack")
 bi.Item = Array(g_(Me,"Next Track"), Self & ".NextTrack")
 bi.Item = Array(g_(Me,"Search Current Playlist"), Self & ".SearchPl")
 bi.Item = Array(g_(Me,"Search Library"), Self & ".SearchLib")
 bi.Item = Array(g_(Me,"Close"), Self & ".Close")

 mainMenu.SetList llist
 mainMenu.ShowMenu
End Sub

Sub TrackInfo
 Dim iTunesApp, TrackInfo
 Set iTunesApp = CreateObject("iTunes.Application")

 Dim Name, Artist, Album, Length
 Artist = iTunesApp.CurrentTrack.Artist
 Album = iTunesApp.CurrentTrack.Album
 Name = iTunesApp.CurrentTrack.Name
 Length = iTunesApp.CurrentTrack.Time

 TrackInfo = Artist & " - " & Album & " - " & Name & " - " & Length

 EmptyMenu.ShowMenu
 am.DlgInformation g_(Me,"iTunes"), TrackInfo
End Sub

Sub BrowsePlaylist
 Dim iTunesApp
 Set iTunesApp = CreateObject("iTunes.Application")

 Dim Tracks, PlaylistName
 Set Tracks = iTunesApp.CurrentPlaylist.Tracks
 PlaylistName = iTunesApp.CurrentPlaylist.Name

 Dim plist
 Set plist = New LinkedList
 Dim bi
 bi = plist.BackInserter

 For cnt = 1 To Tracks.Count
  bi.Item = Array( Tracks.Item(cnt).Artist & " - " & Tracks.Item(cnt).Name, Self & ".PlaySongFromPlaylist " & cnt)
 Next

 BrowsePlaylistMenu.SetList plist
 BrowsePlaylistMenu.Title = PlaylistName
 BrowsePlaylistMenu.ShowMenu
End Sub

Sub PlaySongFromPlaylist( i )
 Dim iTunesApp
 Set iTunesApp = CreateObject("iTunes.Application")

 iTunesApp.CurrentPlaylist.Tracks.Item(i).Play
 BrowsePlaylist
End Sub

Sub PlayPause
 Dim iTunesApp
 Set iTunesApp = CreateObject("iTunes.Application")

 iTunesApp.PlayPause
 am.Update
 Show
End Sub

Sub Play
 Dim iTunesApp
 Set iTunesApp = CreateObject("iTunes.Application")

 iTunesApp.Play
 am.Update
 Show
End Sub

Sub ResumeTrack
 Dim iTunesApp
 Set iTunesApp = CreateObject("iTunes.Application")

 iTunesApp.Resume
 am.Update
 Show
End Sub

Sub Stopp
 Dim iTunesApp
 Set iTunesApp = CreateObject("iTunes.Application")

 iTunesApp.Stop
 am.Update
 Show
End Sub

Sub PrevTrack
 Dim iTunesApp
 Set iTunesApp = CreateObject("iTunes.Application")

 iTunesApp.PreviousTrack
 am.Update
 Show
End Sub

Sub NextTrack
 Dim iTunesApp
 Set iTunesApp = CreateObject("iTunes.Application")

 iTunesApp.NextTrack
 am.Update
 Show
End Sub

Sub FastForward
 Dim iTunesApp
 Set iTunesApp = CreateObject("iTunes.Application")

 iTunesApp.FastForward
 am.Update
 Show
 End Sub

Sub Rewind
 Dim iTunesApp
 Set iTunesApp = CreateObject("iTunes.Application")

 iTunesApp.Rewind
 am.Update
 Show
End Sub

Sub Close
 Dim iTunesApp
 Set iTunesApp = CreateObject("iTunes.Application")

 iTunesApp.Quit
 am.Update
End Sub

Sub SearchPl
 Debug.DebugMsg "SearchPl"
 EmptyMenu.ShowMenu
 Dim iTunesApp
 Set iTunesApp = CreateObject("iTunes.Application")
 Dim TitleString
 TitleString = "Search " & iTunesApp.CurrentPlaylist.Name
 Debug.DebugMsg  "Search Title = " &  TitleString 
 am.DlgInputStr g_(Me,"Search"), g_(Me,"Search For:"), 16, "", Self & ".SearchPlResult"
End Sub

Sub SearchLib
 EmptyMenu.ShowMenu
 am.DlgInputStr g_(Me,"Search Library"), g_(Me,"Search For:"), 16, "", Self & ".SearchLibResult"
End Sub

Sub SearchPlResult (input)
 MenuStack.Top.Quit 'remove empty menu
 ChooseTrack ITUNES_SEARCHTYPE_PL,input 
End Sub

Sub SearchLibResult (input)
 MenuStack.Top.Quit 'remove empty menu
 ChooseTrack ITUNES_SEARCHTYPE_LIB,input
End Sub

Sub ChooseTrack(searchtype, input)
 EmptyMenu.ShowMenu
 am.DlgFeedback g_(Me,"Working"), Self & ".DlgFeedbackResult"
 am.Update
 Dim iTunesApp
 Set iTunesApp = CreateObject("iTunes.Application")
 Dim iTunesPlaylist
 if(searchtype = ITUNES_SEARCHTYPE_PL) then
  Set iTunesPlaylist = iTunesApp.CurrentPlaylist
 elseif(searchtype = ITUNES_SEARCHTYPE_LIB) then
  Set iTunesPlaylist = iTunesApp.LibraryPlaylist
 end if
 Dim Tracks
 Set Tracks = iTunesPlaylist.Search(input, 0) 'all fields
 if (Tracks is nothing) then
  EmptyMenu.ShowMenu
  Util.DisplayMsgBox g_(Me,"No Matches"), 5, ""
  am.Update
 else
  Dim matchList
  if(Tracks.Count>300) then
   Util.DisplayMsgBox g_(Me,"More than 300 Tracks returned. Results are unsorted"), 0, ""
   am.Update
   Set matchList = new LinkedList
   Dim bi
   Set bi = matchList.BackInserter
   for cnt = 1 to Tracks.Count
    bi.Item = Array (Tracks.Item(cnt).Artist & " - " & Tracks.Item(cnt).Name, Self & ".ChooseTrackResult " & searchtype & ", " & Tracks.Item(cnt).SourceID & ", " & Tracks.Item(cnt).PlaylistID & ", " & Tracks.Item(cnt).TrackID & ", " & Tracks.Item(cnt).TrackDatabaseId)
   next
  else 'This sorts the tracks into alphabetical order 
   'see comments with the class at the end of the file for how it does it
   Dim Tree
   Set Tree = new ITunesAlphabetTree
   Dim Comparator
   Set Comparator = New ItunesLLArrayItem1Comparator
   Tree.SetComparator Comparator
   For cnt = 1 To Tracks.Count 
    Tree.Add Array (Tracks.Item(cnt).Artist & " - " & Tracks.Item(cnt).Name, Self & ".ChooseTrackResult " & searchtype & ", " & Tracks.Item(cnt).SourceID & ", " & Tracks.Item(cnt).PlaylistID & ", " & Tracks.Item(cnt).TrackID & ", " & Tracks.Item(cnt).TrackDatabaseId)
   Next  
   Set matchList = Tree.GetLinkedList
  end if
  SearchMenu.SetList matchList
  SearchMenu.Title = g_(Me,"Search Results")
  MenuStack.Top.Quit 'remove empty menu
  SearchMenu.ShowMenu
 end if
End Sub

Sub ChooseTrackResult(searchtype, SourceID, PlaylistID, TrackID, TrackDbId)
 Dim iTunesApp
 Set iTunesApp = CreateObject("iTunes.Application")
 Debug.DebugMsg "Trying now..."
 Dim track
 Set track = iTunesApp.GetITObjectByID(SourceID, PlaylistID, TrackID, TrackDbId)
 Debug.DebugMsg "We have a track object - " 
 Debug.DebugMsg track.Name
 if(searchtype = ITUNES_SEARCHTYPE_PL) then
  track.Play
 elseif (searchtype = ITUNES_SEARCHTYPE_LIB) then
  dim PartyShuffle
  set PartyShuffle = iTunesApp.LibrarySource.Playlists.ItemByName("Party Shuffle")
  dim newTrack
  Set newTrack = PartyShuffle.AddTrack(track)
  if(iTunesApp.PlayerState <> 1) then 
   Debug.DebugMsg "Player state was " & iTunesApp.PlayerState 
   newTrack.Play
  elseif (PartyShuffle.PlaylistID <> iTunesApp.CurrentPlaylist.PlaylistID) then
   Debug.DebugMsg "Current Playlist was "& iTunesApp.CurrentPlaylist.Name
   newTrack.Play
  else
   'This code is designed to shuffle the tracks in the PartyShuffle so that
   'The newly added one is the next played. It does this by moving all tracks
   'in between to the bottom of the playlist. Slow and ugly, but it works.
   dim Tracklist
   Set Tracklist = PartyShuffle.Tracks
   dim count
   count = 2
   dim foundTrack
   foundTrack=false    
   while(count < Tracklist.count)
    Dim thisTrack
    Set thisTrack = Tracklist.ItemByPlayOrder(count)
    if(thisTrack.TrackID = newTrack.TrackId) then
     ' We just added this track, break out of the loop
     count = TrackList.count
    elseif(thisTrack.TrackID = iTunesApp.CurrentTrack.TrackID) then
     ' This is the currently playing track, shift stuff after here"
     foundTrack = true
     count = count + 1
    elseif(foundTrack) then
     if(thisTrack.TrackID = iTunesApp.CurrentTrack.TrackID) then
      'Play shifted while we were fiddling
      count = count+1
     else
      'Adding to the end
      PartyShuffle.AddTrack thisTrack
      'Removing from beginning
      thisTrack.Delete
     end if
    else
     count = count+1
    end if    
   wend
  end if
 end if
 MenuStack.Top.Quit
End Sub

End Class

'This stupidly named class does a lower case compare on the first array 
'element of the two supplied arrays

Class ItunesLLArrayItem1Comparator
Public Function Compare( arrA, arrB )
  'compare case insensitive
  dim a,b
  a=Lcase(arrA(0))
  b=Lcase(arrB(0))
'   Debug.DebugMsg "Comparing " & a & " & " & b
  If a = b Then
   Compare = 0
  ElseIf a < b Then
   Compare = -1
  Else
   Compare = 1
  End If
End Function
End Class


'This is a tree designed to sort the items placed into it according to the comparator, so
'it can then be output as a linked list later
'This may be faster than a quicksort. I'm not sure, I haven't tested it. It'll do best when stuff
'comes at it in a random order.

Class iTunesAlphabetTree
private topNode
private comp
Sub SetComparator(Comparator)
 set comp = Comparator
End Sub

Sub Add(Item)
 if(isObject(topNode)) then
  topNode.Add Item,comp
 else
  Set topNode = new iTunesAlphabetNode
  topNode.SetItem Item
 end if
End Sub

Function GetLinkedList
 dim ll
 Set ll = new LinkedList
 dim bi
 Set bi = ll.BackInserter
 if(isObject(topNode)) then
  topNode.Iterate bi
 end if
 Set GetLinkedList = ll
End Function
End Class

' The node for the above tree

Class iTunesAlphabetNode
private my_item
private prevnode
private nextnode

sub SetItem (Item)
 if(isObject (Item)) then
  Set my_item = Item
 else
  my_item = Item
 end if
end sub

Sub Add(Item, comp)
 if(comp.Compare(Item, my_item) <0) then
  if(isObject (prevnode)) then
   prevnode.Add Item, comp
  else
   Set prevnode = new iTunesAlphabetNode
   prevnode.SetItem Item
  end if
 else
  if(isObject (nextnode)) then
   nextnode.Add Item, comp
  else
   Set nextnode = new iTunesAlphabetNode
   nextnode.SetItem Item
  end if
 end if
end sub

Sub Iterate(bi)
 if(isObject (prevnode)) then
  prevnode.Iterate bi 
 end if
 if(isObject(my_item)) then
  Set bi.Item = my_item
 else
  bi.Item = my_item
 end if
 if(isObject (nextnode)) then
  nextnode.Iterate bi
 end if   
end sub
End Class
