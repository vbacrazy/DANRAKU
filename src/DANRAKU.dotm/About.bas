Attribute VB_Name = "About"
Option Explicit

Public Sub 段落番号ヘルプ()
    Dim WSH: Set WSH = CreateObject("Wscript.Shell")
    WSH.Run "http://www.clockahead.com/soft/danraku/", 3
End Sub

