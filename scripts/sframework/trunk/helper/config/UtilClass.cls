VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "UtilClass"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
    
Function EscapeLinebreaks(ByVal text)
    text = Replace(text, "\", "\\")
    text = Replace(text, vbCrLf, "\n")
    text = Replace(text, Chr(10), "\n")
    text = Replace(text, Chr(13), "\n")
    EscapeLinebreaks = text
End Function

Function UnescapeLinebreaks(ByVal text)
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
