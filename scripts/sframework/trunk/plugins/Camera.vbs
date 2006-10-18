'FMA Script Framework Plugin
'Camera
'Control your phones camera from your computer

'TODO:
'-wait for an fma internal sleep function that only blocks the script and not fma
'-loop

Class Camera
	
	Private m_Self
	Private mainMenu
	
	'Some info about the plugin
	Public Property Get SHOWABLE 'Do I have a menu?
		SHOWABLE    = True
	End Property
	Public Property Get TITLE 'What's my name?
		TITLE       = g_(Me,"Camera")
	End Property
	Public Property Get DESCRIPTION 'What's my purpose?
		DESCRIPTION = g_(Me,"Control your phones camera from your computer")
	End Property
	Public Property Get AUTHOR 'Who created me?
		AUTHOR      = "streawkceur (inspired by hrs)"
	End Property
	Public Property Get URL 'Were can I be found? Where can you get more information?
		URL = "http://fma.xinium.com/"
	End Property
	
	'Who am I?
	Public Property Let Self (s)
		m_Self = s
		' Some init stuff here:
		Set List = New LinkedList
		Dim bi
		bi = List.BackInserter
		bi.Item = Array( g_(Me,"Help"),          s & ".Help" )
		bi.Item = Array( g_(Me,"Shot & Return"), s & ".ShotAndReturn" )
		bi.Item = Array( g_(Me,"Shot"),          s & ".Shot" )
		Set mainMenu = New ManagedMenu
		mainMenu.Title = TITLE
		mainMenu.SetList List
		EventManager.RegisterEvent "Connected", s & ".Init", Me
		If IsEmpty(Settings(Me, "OutputDirectory")) Or Trim(Settings(Me, "OutputDirectory")) = "" Then Settings(Me, "OutputDirectory") = "C:\"
		If IsEmpty(Settings(Me, "InputFilename"))   Or Trim(Settings(Me, "InputFilename"))   = "" Then Settings(Me, "InputFilename")   = "/Pictures/Image(1).jpg"
	End Property
	Public Property Get Self
		Self = m_Self
	End Property
	
	Sub Show()
		mainMenu.ShowMenu
	End Sub
	
	Sub Init()
		fma.AddCmd g_(Me,"Take a picture"), m_Self & ".Shot"
		fma.AddCmd g_(Me,"blub"), m_Self & ".blub"
	End Sub
	
	Sub Help
		EmptyMenu.ShowMenu
		am.DlgInformation g_(Me,"Camera"), g_(Me,"To use the camera feature use the entries in the FMA Tools menu.")
	End Sub
	
	Sub ShotAndReturn
		Shot 'Take picture
		If PluginManager.IsLoaded("AutoMenu") Then	PluginManager("AutoMenu").GoToMenu 'Return to accessories menu
	End Sub
	
	Sub Shot()
		If IsEmpty(Settings(Me, "OutputDirectory")) Or Trim(Settings(Me, "OutputDirectory")) = "" Then
			Debug.ErrorMsg "You must specify Camera->OutputDirectory in the configurator!"
			Settings(Me, "OutputDirectory") = "C:\"
			Exit Sub
		End If
		If Not Fso.FolderExists(Settings(Me, "OutputDirectory")) Then
			Debug.ErrorMsg "Your specified Camera->OutputDirectory doesn't exist! Please create it or fix the setting!"
			Exit Sub
		End If
		If IsEmpty(Settings(Me, "InputFilename")) Or Trim(Settings(Me, "InputFilename")) = "" Then
			Debug.ErrorMsg "You must specify Camera->InputFilename in the configurator!"
			Settings(Me, "InputFilename") = "/Pictures/Image(1).jpg"
			Exit Sub
		End If
		
		Transmit "AT+CLCK=""CS"",0" ' Unlock phone
		'AT+CKPD=<keys>[,<time>[,<pause>]]
		Transmit "AT+CKPD="":R"",20" ' Go to standby screen
		Transmit "AT+CLCK=""CS"",2" ' Request status to force transmission of previous command...
		Util.Sleep 2200
		Transmit "AT+CKPD="":C""" ' Enter camera mode
		'Transmit "AT+CLCK=""CS"",2" ' Request status to force transmission of previous command...
		Util.Sleep 500
		Debug.DebugMsg "--------------> CAM"
		Transmit "AT+CKPD="":C""" ' Take picture
		Transmit "AT+CLCK=""CS"",2" ' Request status to force transmission of previous command...
		
		' create filename here to get the (more or less) exact time & date of the picture
		Dim outputFile
		outputFile = Settings(Me, "OutputDirectory")
		If Right(outputFile, 1) <> "\" Then outputFile = outputFile & "\"
		outputFile = outputFile & "Phone-Camera (" & Year(Date) & "-" & LeadZero(Month(Date)) & "-" & LeadZero(Day(Date)) & ")-(" & LeadZero(Hour (time)) & "-" & LeadZero(Minute (time)) & "-" & LeadZero(Second (time)) & ").jpg"
		
		Util.Sleep 4000
		Debug.DebugMsg "--------------> SHOT"
		Transmit "AT+CKPD="":C""" ' Save picture
		'Transmit "AT+CLCK=""CS"",2" ' Request status to force transmission of previous command...
		Util.Sleep 2000
		Debug.DebugMsg "--------------> SAVE"
		Transmit "AT+CKPD="":R"",20" ' Go to standby screen
		Transmit "AT+CLCK=""CS"",2" ' Request status to force transmission of previous command...
		
		fma.ObexCut outputfile, Settings(Me, "InputFilename")
	End Sub
	
	Sub blub
		fma.Debug "Before 0"
		Transmit  "AT+CKPD=""0"""
		fma.Debug "After 0"
		'Util.Sleep 1000
		fma.Debug "After Sleep"
		fma.Debug "Before 1"
		Transmit  "AT+CKPD=""1"""
		fma.Debug "After 1"
	End Sub
	
	Function LeadZero( ByVal N )
		If (N>=0) and (N<10) Then LeadZero = "0" & N else LeadZero = "" & N
	End Function
	
End Class


