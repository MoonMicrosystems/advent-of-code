Option _Explicit

Dim FileContents As String
Dim Result As Integer
Dim Expected As Integer

Dim i As Integer
Dim TestFiles(1 To 9) As String
Dim ExpectedResults(1 To 9) As Integer
Dim AllTestsPassed As Integer

TestFiles(1) = "../inputs/sample.1": ExpectedResults(1) = 0
TestFiles(2) = "../inputs/sample.2": ExpectedResults(2) = 0
TestFiles(3) = "../inputs/sample.3": ExpectedResults(3) = 3
TestFiles(4) = "../inputs/sample.4": ExpectedResults(4) = 3
TestFiles(5) = "../inputs/sample.5": ExpectedResults(5) = 3
TestFiles(6) = "../inputs/sample.6": ExpectedResults(6) = -1
TestFiles(7) = "../inputs/sample.7": ExpectedResults(7) = -1
TestFiles(8) = "../inputs/sample.8": ExpectedResults(8) = -3
TestFiles(9) = "../inputs/sample.9": ExpectedResults(9) = -3

AllTestsPassed = 1

For i = 1 To 9
    FileContents = ReadFileContents$(TestFiles(i))
    Result = Part1%(FileContents)
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
    Result = Part1%(FileContents)

    Print "Result for Part 1: "; Result
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

Function Part1% (File$)
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
    Next I

    Part1% = Result
End Function
