'FMA Script Framework Plugin
'FileExplorer
'Lets you explore your local drives and execute files
'You can even abuse it as a file launcher list by setting the FileExplorerRoot
'setting to a folder containing *.lnk files.

'TODO:
'-nothing atm

Class FileExplorer
	
	Private m_Self
	Private mainMenu
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = True
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = g_(Me,"FileExplorer")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"Lets you explore your local drives and execute files")
	End Property
	Public Property Get AUTHOR 'Who created me?
		AUTHOR      = "streawkceur"
	End Property
	Public Property Get URL 'Were can I be found? Where can you get more information?
		URL = "http://fma.xinium.com/"
	End Property
	
	'Who am I?
	Public Property Let Self (s)
		m_Self = s
	End Property
	Public Property Get Self
		Self = m_Self
	End Property
	
	'Display me. Eventually put a menu on the screen
	Sub Show()
		If IsEmpty(Settings(Me, "Root")) Or Settings(Me, "Root") = "" Or Not Fso.FolderExists(Settings(Me, "Root")) Then Settings(Me, "Root") = "/"
		ShowDir Settings(Me, "Root"), 0
	End Sub
	
	Sub ShowDir( dir, refresh )
		Dim tempList, bi
		Set tempList = New LinkedList
		bi = tempList.BackInserter
		If refresh = 0 Then Set mainMenu = New ManagedMenu 'Only reinit the menu when not refreshing
		bi.Item = Array(g_(Me,"-> Refresh"), Self & ".ShowDir """ & dir & """, 1")
		If dir = "/" Then 'show drives
			
			Dim drv, drives,s
			Set drives = FSO.Drives
			For Each drv In Drives
				If drv.IsReady Then
					bi.Item = Array(">" & Replace(drv.RootFolder, "\", "/"), Self & ".ShowDir """ & drv.RootFolder & """, 0")
				Else
					bi.Item = Array(drv.Path, "am.Update")
				End If
			Next
			mainMenu.Title = g_(Me,"Drives")
			
		Else 'show dir content
			
			If Fso.FolderExists(dir) Then
				Dim folder, subFolders, subFolder,  files, file, llFolders, llFiles, it
				Set folder     = Fso.GetFolder(dir)
				Set subFolders = folder.SubFolders
				Set files      = folder.Files
				
				Set llFolders = New LinkedList
				For Each subFolder In subFolders
					llFolders.AddBack subFolder.Path
				Next
				QuickSorter.SortLL llFolders
				it = llFolders.Begin
				Do Until it.Object Is llFolders.Last.Object
					Dim tmpFolder
					Set tmpFolder = Fso.GetFolder(it.Item)
					bi.Item = Array(">" & tmpFolder.Name, Self & ".ShowDir """ & tmpFolder.Path & """, 0")
					it.iterate()
				Loop
				
				Set llFiles = New LinkedList
				For Each file in files
					llFiles.AddBack file.Path
				Next
				QuickSorter.SortLL llFiles
				it = llFiles.Begin
				Do Until it.Object Is llFiles.Last.Object
					Dim tmpFile
					Set tmpFile = Fso.GetFile(it.Item)
					bi.Item = Array(tmpFile.Name, Self & ".Exec """ & tmpFile.Path & """")
					it.iterate()
				Loop
				mainMenu.Title = Replace(dir, "\", "/")
			Else
				mainMenu.Title = g_(Me,"(error)")
				Debug.ErrorMsg Self & ": Folder " & dir & "doesn't exist!"
			End If
			
		End If
		mainMenu.SetList tempList
		mainMenu.ShowMenu
	End Sub
	
	Sub Exec( file )
		Debug.DebugMsg "Running: " & file
		Shell.Run "RunDLL32.EXE shell32.dll,ShellExec_RunDLL """ & file & """"
		am.Update
	End Sub

End Class

