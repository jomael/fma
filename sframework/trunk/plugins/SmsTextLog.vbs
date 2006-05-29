'-------------Save as a plugin and it will write the SMS to txt file---------

'Credit where credit due. ie none to me (orac) as copied, changed and messed around for hours just to get it to work

' Improved by ExpertOne

'For Simple text writing (default settings) use for example:
' FileName:   SMSText.txt
' Header:     
' DataFormat: {0},{1},{2}
' Footer:     

'For Tab-Separated writing use for example:
' FileName:   SMSText.txt
' Header:     
' DataFormat: {0}{3}{1}{3}{2}
' Footer:     
' Uncomment "EscapeText" function

'For CSV writing use for example:
' FileName:   SMSText.csv
' Header:     Sender, Message, Recieved
' DataFormat: "{0}","{1}","{2}"
' Footer:     
' Uncomment "EscapeText" function

'For XML writing use for example:
' FileName:   SMSText.xml
' Header:     <?xml version='1.0' encoding='utf-8'?> <SMSCollection>
' DataFormat: <SMS><Sender>{0}</Sender><Message>{1}</Message><Recieved>{2}</Recieved></SMS>
' Footer:     </SMSCollection>
' Uncomment "EscapeText" function

Class SmsTextLog

  Private m_Self
  Private m_WinampState
  Private m_FileName
  Private m_Header
  Private m_DataFormat
  Private m_Footer

  'Some info about the plugin
  Public Property Get SHOWABLE() 'Do I have a menu?
    SHOWABLE = False
  End Property
  Public Property Get TITLE() 'What's my name?
    TITLE = g_(Me,"On SMS Write Log")
  End Property
  Public Property Get DESCRIPTION() 'What's my purpose?
    DESCRIPTION = g_(Me,"This will Append the new SMS to File. With this plugin is possible to write new SMSes in XML, CSV, Tab-delimited file, etc. For more info see script file comments.")
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

    If IsEmpty(Settings(Me, "FileName")) Then Settings(Me, "FileName") = "C:\SMSText.txt"
    If IsEmpty(Settings(Me, "Header")) Then Settings(Me, "Header") = ""
    If IsEmpty(Settings(Me, "DataFormat")) or Settings(Me, "DataFormat") = "" Then Settings(Me, "DataFormat") = "{0}, {1}, {2}"
    If IsEmpty(Settings(Me, "Footer")) Then Settings(Me, "Footer") = ""
    m_FileName = Settings(Me, "FileName")
    m_Header = Settings(Me, "Header")
    m_DataFormat = Settings(Me, "DataFormat")
    m_Footer = Settings(Me, "Footer")

    EventManager.RegisterEvent "NewSMS", s & ".WriteSMS", Me
  End Property
        
  Public Property Get Self()
    Self = m_Self
  End Property

  Private Function EscapeText(S)
    EscapeText = S
  End Function

  'Private Function EscapeText(S) ' Tab-sep Escape
  '  EscapeText = Replace(S, vbTab, " ")
  'End Function

  'Private Function EscapeText(S) ' CSV Escape
  '  EscapeText = Replace(S, """", """""")
  'End Function

  'Private Function EscapeText(S) ' XML Escape
  '  S = Replace(S, "&", "&amp;") ' must be first
  '  'S = Replace(S, """", "&quot;")
  '  'S = Replace(S, ">", "&gt;")
  '  EscapeText = Replace(S, "<", "&lt;")
  'End Function

  Sub WriteSMS(S, T)
    If m_FileName <> "" Then
      Debug.DebugMsg "Saving NewSMS to file " & m_FileName
      Dim File, exist, text
      text = Replace(Replace(Replace(Replace(m_DataFormat, "{0}", EscapeText(S)), "{1}", EscapeText(T)), "{2}", EscapeText(Now)), vbTab, "{3}")
      exist = Fso.FileExists(m_FileName)
      If m_Footer = "" Then
        Set File = Fso.OpenTextFile(m_FileName, 8, True)
        If m_Header <> "" and not exist Then
          File.WriteLine m_Header
        End If
        File.WriteLine text
        File.Close
      Else
        'TODO: Rewrite this case (Locate last line (seek FileSize - FooterSize - CRLF), if here is footer text or "" write Data and new footer, else append Data and Footer)

        Set File = Fso.OpenTextFile(m_FileName, 1, True)
        Dim alldata, p
        If not File.AtEndOfStream Then alldata = File.ReadAll Else alldata = "" End If
        File.Close
        p = InStrRev(alldata, m_Footer + vbCrLf)
        If p > 0 Then alldata = Left(alldata,p-1) End If
        Set File = Fso.OpenTextFile(m_FileName, 2, True)
        If m_Header <> "" and not exist Then
          File.WriteLine m_Header
        Else
          File.Write alldata
        End If
        File.WriteLine text
        File.WriteLine m_Footer
        File.Close
      End If
    End If
  End Sub

End Class