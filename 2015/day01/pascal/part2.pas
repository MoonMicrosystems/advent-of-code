program Part2;

{$mode objfpc}{$H+}

uses
  SysUtils, Classes;

const
  NumberOfTests = 9;
  ExpectedResults: array[5..NumberOfTests] of Integer = (1, 3, 1, 1, 1);

function ReadFileContentsAsString(const FilePath: string): string;
var
  FileData: TextFile;
  Line: string;
  StringBuilder: TStringList;
begin
  StringBuilder := TStringList.Create;
  try
    if FileExists(FilePath) then
    begin
      AssignFile(FileData, FilePath);
      Reset(FileData);
      while not EOF(FileData) do
      begin
        ReadLn(FileData, Line);
        StringBuilder.Add(Line);
      end;
      CloseFile(FileData);
      Result := StringBuilder.Text;
    end
    else
      Writeln('File not found: ', FilePath);
  finally
    StringBuilder.Free;
  end;
end;

function Part2(const Directions: string): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 1 to Length(Directions) do
  begin
    case Directions[i] of
      '(': Inc(Result);
      ')': Dec(Result);
    end;

    if Result = -1 then
      Exit(i);
  end;
end;

var
  FileName: string;
  FileContents: string;
  Expected, Actual: Integer;
  AllTestsPassed: Boolean = True;
  I: Integer;

begin
  for I := 5 to NumberOfTests do
  begin
    FileName := Format('../inputs/sample.%d', [I]);
    FileContents := ReadFileContentsAsString(FileName);

    if FileContents <> '' then
    begin
      Expected := ExpectedResults[I];
      Actual := Part2(FileContents);
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
  end;

  if AllTestsPassed then
  begin
    FileContents := ReadFileContentsAsString('../inputs/input');
    if FileContents <> '' then
    begin
      Actual := Part2(FileContents);
      Writeln('Result for part 2: ', Actual);
    end;
  end;
end.

