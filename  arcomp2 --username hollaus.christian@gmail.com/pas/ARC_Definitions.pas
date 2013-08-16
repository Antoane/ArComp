unit ARC_Definitions;

interface

uses
  ARC_Definitions;

function Explode(const cSeparator, vString: string): TExplodeArray;

type
  TExplodeArray = array of string;

implementation

function Explode(const cSeparator, vString: string): TExplodeArray;
var
  i: Integer;
  S: string;
begin
  S := vString;
  SetLength(Result, 0);
  i := 0;
  while Pos(cSeparator, S) > 0 do
  begin
    SetLength(Result, Length(Result) + 1);
    Result[i] := Copy(S, 1, Pos(cSeparator, S) - 1);
    Inc(i);
    S := Copy(S, Pos(cSeparator, S) + Length(cSeparator), Length(S));
  end;
  SetLength(Result, Length(Result) + 1);
  Result[i] := Copy(S, 1, Length(S));
end;

end.
