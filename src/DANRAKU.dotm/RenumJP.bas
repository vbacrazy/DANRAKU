Attribute VB_Name = "RenumJP"
'各種番号振りなおしマクロ
'   Created By D*suke YAMAKWA
'   last modified : 12/10/16
'
'段落番号の振りなおし部分(RenumberingParagraph)に関して
'   original code : 段落番号置換マクロ 03/08/23 By 岡田
'   modified By D*suke YAMAKWA
'
'【マクロの概要】
' 1. 文書中の＠を段落番号に置き換えた後、
'    文書中の段落番号を、連番になるように書き直します。
'
' 2. 文書中の＊を請求項番号に置き換えた後、
'    文書中の請求項番号を、連番になるように書き直します。
'
' 3. 図、化学式、数式、表の番号を連番になるように書き直します。
'
'【※注意点】
'   "＠"、"＊"が文書の途中にある場合でも置換されます。
'   文の途中では"＠"、"＊"を使わない、もしくは、下記行を削除して下さい。

Public Sub 段落番号など振り直しJP()
    Call ReplaceAll("＠", "【００００】") '＠の置換機能が不要な場合はこの行を削除
    Call RenumberingParagraph

    'Call ReplaceAll("＊", "【請求項０】") '＊の置換機能が不要な場合はこの行を削除
    'Call Renumbering("請求項")
    
    'Call Renumbering("図")
    'Call Renumbering("化")
    'Call Renumbering("数")
    'Call Renumbering("表")
End Sub

Private Sub ReplaceAll(before As String, after As String)
    Selection.Find.ClearFormatting
    Selection.Find.Replacement.ClearFormatting
    With Selection.Find
        .Text = before
        .Replacement.Text = after
        .Forward = True
        .Wrap = wdFindContinue
        .Format = False
        .MatchCase = False
        .MatchWholeWord = False
        .MatchKashida = False
        .MatchDiacritics = False
        .MatchAlefHamza = False
        .MatchControl = False
        .MatchByte = False
        .MatchAllWordForms = False
        .MatchSoundsLike = False
        .MatchWildcards = False
        .MatchFuzzy = False
    End With
    Selection.Find.Execute Replace:=wdReplaceAll
End Sub

Private Sub RenumberingParagraph()
    Dim AddStr As String
    Dim ParagraphNum As Integer: ParagraphNum = 1

    Set myRange = ActiveDocument.Range()
    With myRange.Find
        .ClearFormatting
        .Text = "【[０１２３４５６７８９]*】"
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
                AddStr = "【" + StrConv(Format(ParagraphNum, "0000"), vbWide) + "】"
                .Font.Reset
                .InsertAfter (AddStr)
                .Move
            End With
            ParagraphNum = ParagraphNum + 1
        Loop
    End With
End Sub


Private Sub Renumbering(moji As String)
    Dim num As Integer: num = 1

    Set myRange = ActiveDocument.Range()
    With myRange.Find
        .ClearFormatting
        .Text = "【" & moji & "[０１２３４５６７８９]*】"
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
                AddStr = "【" & moji & StrConv(num, vbWide) & "】"
                .Font.Reset
                .InsertAfter (AddStr)
                .Move
            End With
            num = num + 1
        Loop
    End With
End Sub


