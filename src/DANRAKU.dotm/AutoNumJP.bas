Attribute VB_Name = "AutoNumJP"
Option Explicit

Public Sub 段落番号自動付与JP()
    段落番号削除JP
    AddParagraphMarker
    段落番号など振り直しJP
End Sub

Private Sub AddParagraphMarker()
    Dim subTitles: subTitles = Array("【技術分野】", "【背景技術】", "【特許文献】", "【非特許文献】" _
                                        , "【発明が解決しようとする課題】", "【課題を解決するための手段】" _
                                        , "【発明の効果】", "【図面の簡単な説明】", "【発明を実施するための形態】" _
                                        , "【実施例】", "【産業上の利用可能性】", "【符号の説明】")

    ' 各項目の後ろに変換用の記号を付与
    Dim i: For Each i In subTitles
    Call ReplaceX(i & "([^11^13])", i & "\1＠\1")
    Next
    ' 【化,数,表 が現れる行の上に＠追加
    Dim formula: formula = "【[化数表]"
    Call ReplaceX("([^11^13])([　 ]{1,10})" & formula & "([０-９]{1,2})(】)", "\1＠\1\2" & formula & "\3\4")
    Call ReplaceX("([^11^13])" & formula & "([０-９]{1,2})(】)", "\1＠\1" & formula & "\2\3")
    ' 【実施例＊】の直後に＠追加。
    Call ReplaceX("(【実施例[０-９]{1,2}】)([^11^13])", "\1\2＠\2")
    ' 『　。\r\n　【以外　』の場合、。の次の行頭に＠を追加
    Call ReplaceX("。([^11^13])　([!【])", "。\1＠\1　\2")
End Sub

Private Sub ReplaceX(before, after)
    With ActiveDocument.Range(0, 0).Find
         .Text = before
         .Replacement.Text = after
         .MatchFuzzy = False
         .MatchWildcards = True
         .Execute Replace:=wdReplaceAll
    End With
End Sub
