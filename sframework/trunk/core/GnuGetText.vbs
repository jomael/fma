'FMA Script Framework Core Class
'GnuGetText
'Messages Localization

Public Const DEFAULT_DOMAIN = ""
Public Const DD = ""

'Public Function g_(domain as String, szMsgId as String)
'Public Function g_(plugin as Object, szMsgId as String)
Public Function g_(domain, szMsgId)
	If IsObject(domain) Then
		g_ = fma.dGetText(TypeName(domain), szMsgId)
	Else
		g_ = fma.dGetText(domain, szMsgId)
	End If
End Function

'Public Function n_(domain, singular, plural, number)
'Public Function n_(plugin, singular, plural, number)
Public Function n_(domain, singular, plural, number)
	If IsObject(domain) Then
		n_ = fma.dnGetText(TypeName(domain), singular, plural, number)
	Else
		n_ = fma.dnGetText(domain, singular, plural, number)
	End If
End Function

' Setup vbs locale with current FMA locale. If FMA locale is not applicable, try to fix this and if can't fix use "en-us" locale
Dim s1
On Error Resume Next
s1 = LCase(Replace(CStr(fma.GetCurrentLocale), "_", "-"))
If Len(s1) < 2 Then
  SetLocale(1033) 'en-us
Else
  SetLocale(s1)
  If Err.Number = 447 Then
  	Err.Clear
  	If Len(s1) = 2 Then s1 = s1 & "-" & s1
  	SetLocale(s1)
    If Err.Number = 447 Then SetLocale(1033) 'en-us
  End If
End If 
Err.Clear
On Error GoTo 0
