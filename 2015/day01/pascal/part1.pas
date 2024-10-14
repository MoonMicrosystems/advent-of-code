program Part1;

{$mode objfpc}{$H+}

uses
  SysUtils;

function ReadFileContentsAsString(const FilePath: string): string;
var
  FileData: TextFile;
  Line: string;
begin
  Result := '';
  if FileExists(FilePath) then
  begin
    AssignFile(FileData, FilePath);
    Reset(FileData);
    while not EOF(FileData) do
    begin
      ReadLn(FileData, Line);
      Result := Result + Line;
    end;
    CloseFile(FileData);
  end
end;

function Part1(const FileContents: string): integer;
var
  i: integer;
  CurrChar: string;
  Res: Integer;
begin
  Res := 0;
  for i := 1 to Length(FileContents) do
  begin
    CurrChar := FileContents[i];
    if CurrChar = '(' then
      Inc(Res)
    else if CurrChar = ')' then
      Dec(Res);
  end;

  Result := Res;
end;

var
  FileName: String;
  FileContents: string;
  Expected, Actual: Integer;
  ExpectedResults: array[1..9] of Integer = (0, 0, 3, 3, 3, -1, -1, -3, -3);
  AllTestsPassed: Boolean = True;
  I: Integer;
begin
  for i := 1 to 9 do
  begin
    FileName := Format('../inputs/sample.%d', [i]);
    FileContents := ReadFileContentsAsString(FileName);
    Expected := ExpectedResults[i];
    Actual := Part1(FileContents);
    if Expected = Actual then
      Writeln('Sample ', I, ' is correct!')
    else
    begin
      AllTestsPassed := False;
      Writeln('Sample ', I, ' is incorrect!');
      Writeln('Expected: ', Expected);
      Writeln('Actual:   ', Actual);
    end;
  end;

  if AllTestsPassed then
  begin
    FileContents := ReadFileContentsAsString('../inputs/input');
    Actual := Part1(FileContents);
    Writeln('Result for part 1: ', Actual);
  end;
end.