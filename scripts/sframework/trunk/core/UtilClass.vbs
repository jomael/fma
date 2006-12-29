'FMA Script Framework Core Class
'Utilities
'Generally useful functionalities

'TODO:
'-nothing atm

Class UtilClass
	
	Public Sub Sleep( ms )
		'Dim startTime
		'startTime = Timer
		'Do
		'Loop while Timer < startTime + (ms/1000)
		fma.Sleep(ms)
	End Sub
	
	'Usage: test = CreatePluginObject (FilePath, TestClass, test)
	'Load class from file, implicit object creation, "self-setting" and initialization
	'Class is automatically unloaded when object is not used anymore
	Public Function CreatePluginObject(pluginPath, classType, varName)
		Execute(ReadFile(pluginPath))
		Execute("Set CreatePluginObject = new " & classType)
		CreatePluginObject.Self = varName
	End Function

	'Usage: test = CreateObject (TestClass, test)
	'Implicit object creation, "self-setting" and initialization
	Public Function CreateObject(classType, varName)
		Execute("Set CreateObject = new " & classType)
		CreateObject.Self = varName
	End Function
		
	Function Connected
		Connected = fma.Connected > 0
	End Function

	'Sets the centered text message on the standby screen of your mobile phone
	Public Sub SetStandbyScreenText (text)
		On Error Resume Next
		If fma.isK750orBetter = False Then
			Transmit "AT*EAST=" & Chr(34) & text & Chr(34)
		End If
		'Transmit "AT*SETICK=" & Chr(34) & text & Chr(34) & ",1"
		Else
		On Error GoTo 0
	End Sub
	
	Public Sub DisplayMsgBox( message, timeout, backSub)
		Dim s1, maxLength
		maxLength = 80
		On Error Resume Next
		If fma.isK750orBetter = True Then
			maxLength = 5000 'docs suggest 65535
		Else
			maxLength = 80
		End If
		On Error GoTo 0
		s1 = EscapeInvalidATChars(message)
		' message cannot be longer than 80 chars (phone limitation)
		If Len(s1)>maxLength Then
			s1 = Left(s1, maxLength-2) & ".."
		End If
		If backSub <> "" Then am.Back = backSub
		am.DlgMsgBox s1, timeout
	End Sub
	
	Public Sub WaitForAppLoad( title, ms )
		Dim startTime
		LaunchAppDlg
		startTime = Timer
		Do
			If Shell.AppActivate(title) Then Exit Do
			Sleep 10
		Loop while ms = 0 Or Timer < startTime + (ms/1000)
	End Sub
	
	Public Sub WaitForAppClose( title, ms )
		Dim startTime
		CloseAppDlg
		startTime = Timer
		Do
			If Not Shell.AppActivate(title) Then Exit Do
			Sleep 10
		Loop while ms = 0 Or Timer < startTime + (ms/1000)
	End Sub
	
	Function EscapeLinebreaks( ByVal text )
		text = Replace( text, "\", "\\" )
		text = Replace( text, vbCrLf, "\n" )
		text = Replace( text, Chr(10), "\n" )
		text = Replace( text, Chr(13), "\n" )
		EscapeLinebreaks = text
	End Function
	
	Function UnescapeLinebreaks( ByVal text )
		Dim p, q, s
		s = 1
		p = InStr(s, text, "\n")
		q = InStr(s, text, "\\")
		Do
			If p = 0 And q = 0 Then
				Exit Do
			ElseIf p = 0 Then 'q > 0
				'replace \\ with \
				text = Left(text, q - 1) & "\" & Mid(text, q + 2)
				s = q + 1
			ElseIf q = 0 Then 'p > 0
				'replace \n with vbCrLf
				text = Left(text, p - 1) & vbCrLf & Mid(text, p + 2)
				s = p + Len(vbCrLf)
			Else 'p > 0, q > 0, p <> q
				If p < q Then
					'replace \n with vbCrLf
					text = Left(text, p - 1) & vbCrLf & Mid(text, p + 2)
					s = p + Len(vbCrLf)
				ElseIf p > q Then
					'replace \\ with \
					text = Left(text, q - 1) & "\" & Mid(text, q + 2)
					s = q + 1
				End If
			End If
			p = InStr(s, text, "\n")
			q = InStr(s, text, "\\")
		Loop
		UnescapeLinebreaks = text
	End Function
	
	Function EscapeInvalidATChars( ByVal text )
		text = Replace(text, "\", "\\")
		text = Replace(text, """", "''")
		'text = Replace(text, "´", "'")
		'text = Replace(text, "ß", "ss")
		'text = Replace(text, "ä", "ae")
		'text = Replace(text, "ö", "oe")
		'text = Replace(text, "ü", "ue")
		'text = Replace(text, "Ä", "Ae")
		'text = Replace(text, "Ö", "Oe")
		'text = Replace(text, "Ü", "Ue")
		EscapeInvalidATChars = text
	End Function
	
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

  ' Voice Support
  Private Voice
  Private LastVoiceProps
  
  Public Property Get VoiceProps
    If LastVoiceProps = "" Then
      VoiceProps = "Gender=Female;Age!=Child;Language=409"
    Else
      VoiceProps = LastVoiceProps
    End If
	End Property
	Public Property Let VoiceProps (v)
		LastVoiceProps = v
	End Property
		
  Public Function say( SpeechText )
    say = speak(SpeechText, VoiceProps)
	End Function

  Public Function speak( SpeechText, aVoiceProps )
    On Error Resume Next
    speak = False
    If not IsObject(Voice) Then
      Set Voice = ActiveXManager.Control("Sapi.SpVoice")
    End If
    If IsObject(Voice) Then
      Set Voice.Voice = Voice.GetVoices(aVoiceProps).Item(0)
      Debug.DebugMsg "VoiceProps: " & aVoiceProps & " -> " & Voice.Voice.GetDescription
      Debug.DebugMsg "Speaking: " & SpeechText
      Voice.Speak SpeechText
      speak = True
    'Else
    '  MsgBox SpeechText, VBInformation, "Voice"
    End If
    Err.Clear
    On Error GoTo 0
	End Function
	
	'Not needed anymore
	'Function ShortFileName( fileName )
	'	If (Fso.FileExists(fileName)) Then
	'		Dim f
	'		Set f = Fso.GetFile( fileName )
	'		ShortFileName = f.ShortName
	'	Else
	'		Debug.DebugMsg "Util.ShortFileName: File " & fileName & " doesn't exist!"
	'		ShortFileName = Empty
	'	End If
	'End Function	
	
	'Not needed anymore
	'Function ShortPathName( fileName )
	'	If (Fso.FileExists(fileName)) Then
	'		Dim f
	'		Set f = Fso.GetFile( fileName )
	'		ShortPathName = f.ShortPath
	'	Else
	'		Debug.DebugMsg "Util.ShortFileName: File " & fileName & " doesn't exist!"
	'		ShortPathName = Empty
	'	End If
	'End Function	

End Class

