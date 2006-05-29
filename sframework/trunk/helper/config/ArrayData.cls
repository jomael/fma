VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ArrayData"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private m_Array

Public Sub SetArray(ByRef ary)
    m_Array = ary
End Sub

Public Function GetArray()
    GetArray = m_Array
End Function

Public Property Get First()
    First = LBound(m_Array)
End Property

Public Property Get Last()
    Last = UBound(m_Array)
End Property

Property Get Item(idx)
    Item = m_Array(idx)
End Property

Public Property Let Item(idx, val)
    m_Array(idx) = val
End Property

Public Property Set Item(idx, object)
    Set m_Array(idx) = object
End Property

Public Sub Swap(i, j)
    Dim h
    If IsObject(Me.Item(i)) Then 'object swap
        Set h = Me.Item(i)
        Set Me.Item(i) = Me.Item(j)
        Set Me.Item(j) = h
    Else
        h = Me.Item(i)
        Me.Item(i) = Me.Item(j)
        Me.Item(j) = h
    End If
End Sub


