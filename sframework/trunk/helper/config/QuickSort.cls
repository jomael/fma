VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "QuickSort"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Sub Sort(ByRef a)
    Dim comp
    Set comp = New DefaultComparator
    ComparatorSort a, comp
End Sub

Sub ComparatorSort(ByRef a, comp)
    Dim data
    Set data = New ArrayData
    data.SetArray a
    privSort data, comp, data.First, data.Last
    a = data.GetArray
End Sub

Sub DataSort(data)
    Dim comp
    Set comp = New DefaultComparator
    privSort data, comp, data.First, data.Last
End Sub

Sub DataComparatorSort(data, comp)
    privSort data, comp, data.First, data.Last
End Sub

'QuickSort
Private Sub privSort(data, comp, l, r)
    If r > l Then
        Dim p, i, j
        p = data.Item(r) 'Pivot-Element
        i = l
        j = r
        Do
            Do While comp.Compare(data.Item(i), p) = -1
                i = i + 1
            Loop
            Do While comp.Compare(data.Item(j), p) = 1
                j = j - 1
            Loop
            If i <= j Then
                data.Swap i, j
                i = i + 1
                j = j - 1
            End If
        Loop Until i > j
        privSort data, comp, l, j
        privSort data, comp, i, r
    End If
End Sub

