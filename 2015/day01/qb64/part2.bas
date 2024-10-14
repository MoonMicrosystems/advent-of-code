Option _Explicit

Dim FileContents As String
Dim Result As Integer
Dim Expected As Integer

Dim i As Integer
Dim TestFiles(5 To 9) As String
Dim ExpectedResults(5 To 9) As Integer
Dim AllTestsPassed As Integer

TestFiles(5) = "../inputs/sample.5": ExpectedResults(5) = 1
TestFiles(6) = "../inputs/sample.6": ExpectedResults(6) = 3
TestFiles(7) = "../inputs/sample.7": ExpectedResults(7) = 1
TestFiles(8) = "../inputs/sample.8": ExpectedResults(8) = 1
TestFiles(9) = "../inputs/sample.9": ExpectedResults(9) = 1

AllTestsPassed = 1

For i = 5 To 9
    FileContents = ReadFileContents$(TestFiles(i))
    Result = Part2%(FileContents)
    Expected = ExpectedResults(i)

    If Result = Expected Then
        Print "Sample "; i; " is correct!"
    Else
        AllTestsPassed = 0
        Print "Sample "; i; " is incorrect!"
        Print "Expected: "; Expected
        Print "Actual:   "; Result
    End If
Next i

If AllTestsPassed = 1 Then
    FileContents = ReadFileContents$("../inputs/input")
    Result = Part2%(FileContents)

    Print "Result for Part 2: "; Result
End If

Function ReadFileContents$ (filePath$)
    Dim FileData As String

    If Len(filePath$) = 0 Then
        ReadFileContents$ = ""
        Exit Function
    End If

    If _FileExists(filePath$) Then
        Open filePath$ For Input As #1
        FileData = Input$(LOF(1), # 1)
        Close #1
        ReadFileContents$ = FileData
    Else
        ReadFileContents$ = ""
    End If
End Function

Function Part2% (File$)
    Dim I As Integer
    Dim CurrChar As String
    Dim Result As Integer
    Result = 0

    For I = 0 To Len(File$)
        CurrChar = Mid$(File$, I, 1)
        If CurrChar = "(" Then
            Result = Result + 1
        ElseIf CurrChar = ")" Then
            Result = Result - 1
        End If

        If Result = -1 Then
            Part2% = I
            Exit Function
        End If
    Next I
End Function
