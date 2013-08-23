unit ARC_DAL_Tools;

interface

uses
  Data.Win.ADODB,
  sysutils,

  //ArComp
  ARC_Types;

type
  TARC_DAL_Tools = class(TObject)
  private
    class procedure datenbankBereinigen(connection: TADOConnection); static;

  public
    class function getIdForName(const name: string; const typ: TFieldType; connection: TADOConnection): string;
  end;

implementation

{TARC_DAL_Tools}

class function TARC_DAL_Tools.getIdForName(const name: string; const typ: TFieldType;
  connection: TADOConnection): string;
var
  aQuery: TADOQuery;
begin
  result := '';
  aQuery := TADOQuery.Create(nil);
  try
    aQuery.connection := connection;
    with aQuery.SQL do
    begin
      clear;
      case typ of
        tftAltersklasse:
          begin
            add('SELECT');
            add('  AK_ID');
            add('FROM ALTERSKATEGORIE');
            add('WHERE AK_NAME = :NAME');
          end;
        tftBogenklasse:
          begin
            add('SELECT');
            add('  BK_ID');
            add('FROM BOGENKATEGORIE');
            add('WHERE BK_NAME = :NAME');
          end;
        tftGeschlecht:
          begin
            add('SELECT');
            add('  GE_ID');
            add('FROM GESCHLECHT');
            add('WHERE GE_NAME = :NAME');
          end;
        tftTurnierart:
          begin
            add('SELECT');
            add('  TA_ID');
            add('FROM TURNIERART');
            add('WHERE TA_NAME = :NAME');
          end;
      end;
      aQuery.Parameters.ParseSQL(aQuery.SQL.Text, True);
      aQuery.Parameters.ParamByName('NAME').value := name;
      aQuery.Open;
      if aQuery.Active and (aQuery.RecordCount > 0) then
      begin
        result := aQuery.Fields[0].AsString;
      end;
    end;
  finally
    aQuery.Free;
  end;
end;

class procedure TARC_DAL_Tools.datenbankBereinigen(connection: TADOConnection);
var
  aQuery: TADOQuery;
begin
  aQuery := TADOQuery.Create(nil);
  try
    aQuery.connection := connection;
    with aQuery.SQL do
    begin
      clear;
      add('DELETE FROM ALTERSKATEGORIE');
      add('WHERE isNull(AK_NAME,' + quotedstr('') + ') = ' + quotedstr(''));
      add('');
      add('DELETE FROM BOGENKATEGORIE');
      add('WHERE isNull(BK_NAME,' + quotedstr('') + ') = ' + quotedstr(''));
      add('');
      add('DELETE FROM GESCHLECHT');
      add('WHERE isNull(GE_NAME,' + quotedstr('') + ') = ' + quotedstr(''));
      add('');
      add('DELETE FROM PERSON');
      add('WHERE isNull(PE_VORNAME,' + quotedstr('') + ') = ' + quotedstr(''));
      add('  AND isNull(PE_NACHNAME,' + quotedstr('') + ') = ' + quotedstr(''));
      add('');
      add('DELETE FROM TURNIER');
      add('WHERE isNull(TU_NAME,' + quotedstr('') + ') = ' + quotedstr(''));
      add('');
      add('DELETE FROM TURNIERART');
      add('WHERE isNull(TA_NAME,' + quotedstr('') + ') = ' + quotedstr(''));
      add('');
      add('DELETE FROM VEREIN');
      add('WHERE isNull(VE_NAME,' + quotedstr('') + ') = ' + quotedstr(''));
    end;
  finally
    aQuery.Free;
  end;

end;

end.
