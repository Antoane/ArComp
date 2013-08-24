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
    class procedure insertFehlendeFinalberechtigungen(const connection: TADOConnection); static;

  public
    class function getIdForName(const name: string; const typ: TFieldType; connection: TADOConnection): string;
    class procedure datenbankBereinigen(connection: TADOConnection); static;
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
      add('');
      add('DELETE FROM FINALBERECHTIGUNG');
      add('WHERE TA_ID NOT IN (SELECT TA_ID FROM TURNIERART)');
      add('  AND AK_ID NOT IN (SELECT AK_ID FROM ALTERSKATEGORIE)');
      add('  AND BK_ID NOT IN (SELECT BK_ID FROM BOGENKATEGORIE)');
      add('  AND GE_ID NOT IN (SELECT GE_ID FROM GESCHLECHT)');
      add('');
    end;
    aQuery.ExecSQL;

    TARC_DAL_Tools.insertFehlendeFinalberechtigungen(connection);
  finally
    aQuery.Free;
  end;
end;

class procedure TARC_DAL_Tools.insertFehlendeFinalberechtigungen(const connection: TADOConnection);
var
  aQuery: TADOQuery;
begin
  aQuery            := TADOQuery.Create(nil);
  aQuery.connection := connection;
  try
    with aQuery.SQL do
    begin
      clear;
      add('INSERT INTO FINALBERECHTIGUNG(');
      add('  FB_ID,');
      add('  TA_ID,');
      add('  AK_ID,');
      add('  BK_ID,');
      add('  GE_ID,');
      add('  FB_FINALBERECHTIGT');
      add(')');
      add('SELECT ');
      add('  newID(),');
      add('  ta.TA_ID, ');
      add('  ak.AK_ID, ');
      add('  bk.BK_ID, ');
      add('  ge.GE_ID, ');
      add('  1');
      add('FROM TURNIERART ta');
      add('  FULL OUTER JOIN  ALTERSKATEGORIE ak');
      add('    ON 1=1');
      add('  FULL OUTER JOIN BOGENKATEGORIE bk');
      add('    ON 1=1');
      add('  FULL OUTER JOIN GESCHLECHT ge');
      add('    ON 1=1');
      add('WHERE (  ');
      add('  SELECT COUNT(*)');
      add('  FROM FINALBERECHTIGUNG fb');
      add('    WHERE fb.TA_ID = ta.TA_ID');
      add('      AND fb.AK_ID = ak.AK_ID');
      add('      AND fb.BK_ID = bk.BK_ID');
      add('      AND fb.GE_ID = ge.GE_ID');
      add(') = 0');
    end;
    aQuery.ExecSQL;
  finally
    aQuery.Free;
  end;

end;

end.
