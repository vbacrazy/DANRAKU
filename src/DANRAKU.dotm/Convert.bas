Attribute VB_Name = "Convert"
Option Explicit

Public Sub iLΟ·EN2JP()
    Call ConvertParagraph("\[[0-9]{4}\]", "yOOOOz")
    Call iΤΘΗUθΌ΅JP
End Sub

Public Sub iLΟ·JP2EN()
    Call ConvertParagraph("y[OPQRSTUVWX]{4}z", "[0000]")
    Call iΤUθΌ΅EN
End Sub

Private Sub ConvertParagraph(u·O, u·γ)
    Dim AddStr As String
    Dim ParagraphNum As Integer: ParagraphNum = 1
    Dim myRange

    Set myRange = ActiveDocument.Range()
    With myRange.Find
        .ClearFormatting
        .Text = u·O
        .Replacement.Text = ""
        .Forward = True
        .Wrap = wdFindStop
        .Format = False
        .MatchCase = False
        .MatchWholeWord = True
        .MatchByte = False
        .MatchAllWordForms = False
        .MatchSoundsLike = False
        .MatchWildcards = True
        .MatchFuzzy = False
        Do While .Execute = True
            With .parent
                .Delete
                AddStr = u·γ
                .Font.Reset
                .InsertAfter AddStr
                .Move
            End With
            ParagraphNum = ParagraphNum + 1
        Loop
    End With
End Sub
