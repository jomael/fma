'-------------Save as a plugin and it will write the SMS to Database---------

'Credit where credit due. ie none to me (orac) as copied, changed and messed around for hours just to get it to work

' Improved by ExpertOne

'Default connection string is "DRIVER={Microsoft Access Driver (*.mdb)}; DBQ=C:\SMSText.mdb"
'Default SQL append command is "INSERT INTO SMSCollection (Sender,Message) VALUES ('{0}','{1}')"
'SMSCollection is Table name
'SMSCollection Table has at least two fields named Message and Sender, mine has a defaulted Now() field and automatic ID field.
'SmsDBLog_EmptyDB.rar contains database SMSText.mdb with empty SMSCollection table ready for use. Simply unRar it.

Class SmsDBLog

  Private m_Self
  Private m_WinampState
  Private m_adoCon
  Private m_InsertCommand
  
  Sub Class_Terminate()
    Set adoCon = Nothing
  End Sub

  'Some info about the plugin
  Public Property Get SHOWABLE() 'Do I have a menu?
    SHOWABLE = False
  End Property
  Public Property Get TITLE() 'What's my name?
    TITLE = g_(Me,"On SMS Write DB")
  End Property
  Public Property Get DESCRIPTION() 'What's my purpose?
    DESCRIPTION = g_(Me,"This will Append the new SMS to ADO DataBase")
  End Property
  Public Property Get AUTHOR() 'Who created me?
    AUTHOR = "orac, ExpertOne"
  End Property
  Public Property Get URL() 'Were can I be found? Where can you get more information?
    URL = "http://www.mobileagent.info/forums/"
  End Property
        
  'Who am I?
  Public Property Let Self(s)
    m_Self = s

    If IsEmpty(Settings(Me, "ConnectionString")) or Settings(Me, "ConnectionString") = "" Then Settings(Me, "ConnectionString") = "DRIVER={Microsoft Access Driver (*.mdb)}; DBQ=C:\SMSText.mdb"
    If IsEmpty(Settings(Me, "InsertCommand")) or Settings(Me, "InsertCommand") = "" Then Settings(Me, "InsertCommand") = "INSERT INTO SMSCollection (Sender,Message) VALUES ('{0}','{1}')"
    m_InsertCommand = Settings(Me, "InsertCommand")

    EventManager.RegisterEvent "NewSMS", s & ".WriteSMS", Me
  End Property

  Public Property Get Self()
    Self = m_Self
  End Property

  Private Function EscapeSQL(S)
    EscapeSQL = Replace(S, "'", "''")
  End Function

  Sub WriteSMS(S, T)
    Debug.DebugMsg "Saving NewSMS to Database"

    If not IsObject(m_adoCon) Then
      Set m_adoCon = CreateObject("ADODB.Connection")
      'Set an active connection to the Connection object using a DSN-less connection
      m_adoCon.Open Settings(Me, "ConnectionString")
    End If
    m_adoCon.BeginTrans
    m_adoCon.Execute Replace(Replace(m_InsertCommand, "{0}", EscapeSQL(S)), "{1}", EscapeSQL(T))
    m_adoCon.CommitTrans
  End Sub

End Class
