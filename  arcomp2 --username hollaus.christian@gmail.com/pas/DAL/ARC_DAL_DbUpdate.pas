unit ARC_DAL_DbUpdate;

interface

uses
  Data.Win.ADODB,
  sysutils,

  //ArComp
  ARC_Functions;

type
  TARC_DAL_DbUpdate = class(TObject)
  private

  public
    class procedure updateBogenkategorien(connection: TADOConnection); static;
    class procedure updateAlterskategorien(connection: TADOConnection); static;
    class procedure updateGeschlecht(connection: TADOConnection); static;
    class function getVereinID(connection: TADOConnection; name: string): string; static;
    class function getTurnierartID(connection: TADOConnection; name: string): string; static;
  end;

implementation

class procedure TARC_DAL_DbUpdate.updateBogenkategorien(connection: TADOConnection);
var
  aQuery: TADOQuery;
begin
  aQuery := TADOQuery.Create(nil);
  try
    aQuery.connection := connection;
    with aQuery.SQL do
    begin
      clear;
      add('DELETE FROM BOGENKATEGORIE');
      add('WHERE BK_NAME NOT IN (SELECT DISTINCT PE_BOGENKATEGORIE FROM PERSON)');
      add('');
      add('');
      add('DECLARE @kategorie varchar(50)');
      add('');
      add('DECLARE CURSOR_BOGENKATEGORIE CURSOR FOR');
      add('SELECT DISTINCT');
      add('  PE_BOGENKATEGORIE');
      add('FROM PERSON');
      add('');
      add('OPEN CURSOR_BOGENKATEGORIE');
      add('');
      add('FETCH NEXT FROM CURSOR_BOGENKATEGORIE');
      add('INTO @kategorie');
      add('');
      add('WHILE @@FETCH_STATUS = 0');
      add('BEGIN');
      add('  IF NOT EXISTS(SELECT BK_ID FROM BOGENKATEGORIE WHERE BK_NAME = @kategorie)');
      add('  BEGIN');
      add('    INSERT INTO BOGENKATEGORIE(');
      add('      BK_ID,');
      add('      BK_NAME');
      add('    )');
      add('    VALUES(');
      add('      newID(),');
      add('      @kategorie');
      add('    )');
      add('  END');
      add('  FETCH NEXT FROM CURSOR_BOGENKATEGORIE');
      add('  INTO @kategorie');
      add('END');
      add('');
      add('CLOSE CURSOR_BOGENKATEGORIE');
      add('DEALLOCATE CURSOR_BOGENKATEGORIE');
    end;

    aQuery.ExecSQL;
  finally
    aQuery.Free;
  end;

end;

class procedure TARC_DAL_DbUpdate.updateGeschlecht(connection: TADOConnection);
var
  aQuery: TADOQuery;
begin
  aQuery := TADOQuery.Create(nil);
  try
    aQuery.connection := connection;
    with aQuery.SQL do
    begin
      clear;
      add('DELETE FROM GESCHLECHT');
      add('WHERE GE_NAME NOT IN (SELECT DISTINCT PE_GESCHLECHT FROM PERSON)');
      add('');
      add('');
      add('DECLARE @geschlecht varchar(50)');
      add('');
      add('DECLARE CURSOR_GESCHLECHT CURSOR FOR');
      add('SELECT DISTINCT');
      add('  PE_GESCHLECHT');
      add('FROM PERSON');
      add('');
      add('OPEN CURSOR_GESCHLECHT');
      add('');
      add('FETCH NEXT FROM CURSOR_GESCHLECHT');
      add('INTO @geschlecht');
      add('');
      add('WHILE @@FETCH_STATUS = 0');
      add('BEGIN');
      add('  IF NOT EXISTS(SELECT GE_ID FROM GESCHLECHT WHERE GE_NAME = @geschlecht)');
      add('  BEGIN');
      add('    INSERT INTO GESCHLECHT(');
      add('      GE_ID,');
      add('      GE_NAME');
      add('    )');
      add('    VALUES(');
      add('      newID(),');
      add('      @geschlecht');
      add('    )');
      add('  END');
      add('  FETCH NEXT FROM CURSOR_GESCHLECHT');
      add('  INTO @geschlecht');
      add('END');
      add('');
      add('CLOSE CURSOR_GESCHLECHT');
      add('DEALLOCATE CURSOR_GESCHLECHT');
    end;

    aQuery.ExecSQL;
  finally
    aQuery.Free;
  end;

end;

class function TARC_DAL_DbUpdate.getVereinID(connection: TADOConnection; name: string): string;
var
  aQuery: TADOQuery;
begin
  aQuery := TADOQuery.Create(nil);
  try
    aQuery.connection := connection;
    with aQuery.SQL do
    begin
      clear;
      add('SELECT');
      add('  VE_ID');
      add('FROM VEREIN');
      add('  WHERE VE_NAME = ' + quotedStr(name));
    end;
    aQuery.Open;
    if aQuery.Active and (aQuery.RecordCount > 0) then
    begin
      result := aQuery.FieldByName('VE_ID').AsString;
    end
    else
    begin
      aQuery.Close;
      result := newguid();
      with aQuery.SQL do
      begin
        clear;
        add('INSERT INTO VEREIN(');
        add('  VE_ID,');
        add('  VE_NAME');
        add(')');
        add('VALUES(');
        add('  ' + quotedStr(result) + ',');
        add('  ' + quotedStr(name));
        add(')');
      end;
      aQuery.ExecSQL;
    end;
  finally
    aQuery.Free;
  end;
end;

class procedure TARC_DAL_DbUpdate.updateAlterskategorien(connection: TADOConnection);
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
      add('WHERE AK_NAME NOT IN (SELECT DISTINCT PE_ALTERSKLASSE FROM PERSON)');
      add('');
      add('');
      add('DECLARE @kategorie varchar(50)');
      add('');
      add('DECLARE CURSOR_ALTERSKATEGORIE CURSOR FOR');
      add('SELECT DISTINCT');
      add('  PE_ALTERSKLASSE');
      add('FROM PERSON');
      add('');
      add('OPEN CURSOR_ALTERSKATEGORIE');
      add('');
      add('FETCH NEXT FROM CURSOR_ALTERSKATEGORIE');
      add('INTO @kategorie');
      add('');
      add('WHILE @@FETCH_STATUS = 0');
      add('BEGIN');
      add('  IF NOT EXISTS(SELECT AK_ID FROM ALTERSKATEGORIE WHERE AK_NAME = @kategorie)');
      add('  BEGIN');
      add('    INSERT INTO ALTERSKATEGORIE(');
      add('      AK_ID,');
      add('      AK_NAME');
      add('    )');
      add('    VALUES(');
      add('      newID(),');
      add('      @kategorie');
      add('    )');
      add('  END');
      add('  FETCH NEXT FROM CURSOR_ALTERSKATEGORIE');
      add('  INTO @kategorie');
      add('END');
      add('');
      add('CLOSE CURSOR_ALTERSKATEGORIE');
      add('DEALLOCATE CURSOR_ALTERSKATEGORIE');
    end;

    aQuery.ExecSQL;
  finally
    aQuery.Free;
  end;

end;

class function TARC_DAL_DbUpdate.getTurnierartID(connection: TADOConnection; name: string): string;
var
  aQuery: TADOQuery;
begin
  aQuery := TADOQuery.Create(nil);
  try
    aQuery.connection := connection;
    with aQuery.SQL do
    begin
      clear;
      add('SELECT');
      add('  TA_ID');
      add('FROM TURNIERART');
      add('  WHERE TA_NAME = ' + quotedStr(name));
    end;
    aQuery.Open;
    if aQuery.Active and (aQuery.RecordCount > 0) then
    begin
      result := aQuery.FieldByName('TA_ID').AsString;
    end
    else
    begin
      aQuery.Close;
      result := newguid();
      with aQuery.SQL do
      begin
        clear;
        add('INSERT INTO TURNIERART(');
        add('  TA_ID,');
        add('  TA_NAME');
        add(')');
        add('VALUES(');
        add('  ' + quotedStr(result) + ',');
        add('  ' + quotedStr(name));
        add(')');
      end;
      aQuery.ExecSQL;
    end;
  finally
    aQuery.Free;
  end;
end;

end.
