unit ARC_Functions;

interface

uses
  SysUtils,

  //ArComp
  ARC_Types;

function Explode(const cSeparator, vString: string): TExplodeArray;
function strToBool(const text: string): boolean;
function boolToInt(val: boolean): Integer;
function intToBool(val: Integer): boolean;

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

function strToBool(const text: string): boolean;
begin
  if (CompareText(UpperCase(text), 'JA') = 0) or (CompareText(UpperCase(text), 'J') = 0) or
    (CompareText(UpperCase(text), 'YES') = 0) or (CompareText(UpperCase(text), 'Y') = 0) or
    (CompareText(UpperCase(text), 'TRUE') = 0) or (CompareText(UpperCase(text), 'T') = 0) then
  begin
    Result := true;
  end
  else
  begin
    Result := false;
  end;
end;

function boolToInt(val: boolean): Integer;
begin
  if val then
  begin
    Result := 1;
  end
  else
  begin
    Result := 0;
  end;
end;

function intToBool(val: Integer): boolean;
begin
  Result := (val = 1);
end;

end.
