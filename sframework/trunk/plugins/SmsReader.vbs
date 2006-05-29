'FMA Script Framework Plugin
'SmsReader
'Read all new SMS with selected voice

Class SmsReader

  Private m_Self
	Private mainMenu
	Private ReadingEnabled
	Private Voice
	Private NewSmsText

  Public Property Get SHOWABLE()
    SHOWABLE = True
  End Property
  Public Property Get TITLE()
    TITLE = g_(Me,"SMS Reader")
  End Property
  Public Property Get DESCRIPTION()
    DESCRIPTION = g_(Me,"Read all new SMS with selected voice")
  End Property
  Public Property Get AUTHOR()
    AUTHOR = "ExpertOne"
  End Property
  Public Property Get URL()
    URL = "http://www.mobileagent.info/forums/"
  End Property

  Public Property Let Self(s)
    m_Self = s

    If IsEmpty(Settings(Me, "Voice")) or Settings(Me, "Voice") = "" Then Settings(Me, "Voice") = "Gender=Female;Age!=Child;Language={0}"
    If IsEmpty(Settings(Me, "NewSmsText")) or Settings(Me, "NewSmsText") = "" Then Settings(Me, "NewSmsText") = "You have new SMS from {0}. SMS says: {1}."
    If IsEmpty(Settings(Me, "ReadingEnabled")) or Settings(Me, "ReadingEnabled") = "" Then Settings(Me, "ReadingEnabled") = "0"
    ReadingEnabled = Settings(Me, "ReadingEnabled")="1"
    Voice = Replace(g_(Me,Settings(Me, "Voice")), "{0}", Hex(GetLocale))
    NewSmsText = g_(Me,Settings(Me, "NewSmsText"))

    EventManager.RegisterEvent "NewSMS", m_Self & ".SpeakSMS", Me

		Set mainMenu = New ManagedMenu
  End Property

  Public Property Get Self()
    Self = m_Self
  End Property

	Sub Show()
		Dim llist, bi
		Set llist = New LinkedList
		bi = llist.BackInserter
		If ReadingEnabled Then
			bi.Item = Array(g_(Me,"[*] Enabled"), Self & ".ToggleEnabled")
		Else
			bi.Item = Array(g_(Me,"[  ] Enabled"),  Self & ".ToggleEnabled")
		End If
		bi.Item = Array(g_(Me,"Test"), Self & ".Test")
		mainMenu.SetList llist
		mainMenu.Title = TITLE
		mainMenu.ShowMenu
	End Sub

	Sub ToggleEnabled
	  ReadingEnabled = not ReadingEnabled
	  If ReadingEnabled Then
		  Settings(Me, "ReadingEnabled") = "1"
		Else
		  Settings(Me, "ReadingEnabled") = "0"
		End If
		Show
	End Sub

	Sub Test
	  SpeakSMS "Test Sender 1", "Test SMS ""Message"" & 1<2 & 3>2."
	  Show

	  'Recieve Test SMS Message
	  'EventManager.OnEvent "NewSMS", Array("Test Sender 1", "Test SMS ""Message"" & 1<2 & 3>2.")
	  'Show
	End Sub

  Sub SpeakSMS(S, T)
    If ReadingEnabled Then
      Util.speak Replace(Replace(Replace(NewSmsText, "{0}", S), "{1}", T), "{2}", Now), Voice
    End If
  End Sub

End Class