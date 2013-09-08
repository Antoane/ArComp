unit ARC_DAL_ParameterRangliste;

interface

uses
  Data.Win.ADODB,
  sysutils,

  //ArComp
  ARC_Types;

type
  TARC_DAL_ParameterRangliste = class(TObject)
  private

  public

    class procedure selectAlterskategorien(query: TADOQuery); static;
    class procedure selectBogenkategorien(query: TADOQuery); static;
    class procedure selectGeschlecht(query: TADOQuery); static;

    class procedure selectRangliste(query: TADOQuery); static;
  end;

implementation

{TARC_DAL_Tools}

class procedure TARC_DAL_ParameterRangliste.selectAlterskategorien(query: TADOQuery);
begin
  with query.SQL do
  begin
    clear;
    add('SELECT');
    add('1 AS SELECTED,');
    add('AK_ID,');
    add('AK_NAME');
    add('FROM ALTERSKATEGORIE');
    add('ORDER BY AK_NAME');
  end;
end;

class procedure TARC_DAL_ParameterRangliste.selectBogenkategorien(query: TADOQuery);
begin
  with query.SQL do
  begin
    clear;
    add('SELECT');
    add('1 AS SELECTED,');
    add('BK_ID,');
    add('BK_NAME');
    add('FROM BOGENKATEGORIE');
    add('ORDER BY BK_NAME');
  end;
end;

class procedure TARC_DAL_ParameterRangliste.selectGeschlecht(query: TADOQuery);
begin
  with query.SQL do
  begin
    clear;
    add('SELECT');
    add('1 AS SELECTED,');
    add('GE_ID,');
    add('GE_NAME');
    add('FROM GESCHLECHT');
    add('ORDER BY GE_NAME');
  end;
end;

class procedure TARC_DAL_ParameterRangliste.selectRangliste(query: TADOQuery);
begin
  with query.SQL do
  begin
    clear;
//    add('DECLARE @tmp TABLE(');
//    add('  ID varchar(36),');
//    add('  PLATZ varchar(50),');
//    add('  PE_VORNAME varchar(50),');
//    add('  PE_NACHNAME varchar(50),');
//    add('  VE_NAME varchar(50),');
//    add('  KATEGORIE varchar(50),');
//    add('  SCORE integer,');
//    add('  ZEHNER integer,');
//    add('  NEUNER integer,');
//    add('  X integer');
//    add(')');
//    add('');
//    add('INSERT INTO @tmp');
    add('SELECT');
    add('  newID(), ');
    add('  ' + quotedStr('') + ',');
    add('  pe.PE_VORNAME,');
    add('  pe.PE_NACHNAME,');
    add('  ve.VE_NAME,');
    add('  isNull(pe.PE_BOGENKATEGORIE,' + quotedStr('') + ') + ' + quotedStr(' / ') + ' +');
    add('    isNull(pe.PE_ALTERSKLASSE,' + quotedStr('') + ') + ' + quotedStr(' / ') + ' +');
    add('    isNull(pe.PE_GESCHLECHT,' + quotedStr('') + '),');
    add('  SUM(isNull(SC_SCORE,0)) AS SCORE,');
    add('  SUM(isNull(SC_ZEHNER,0)) AS ZEHNER,');
    add('  SUM(isNull(SC_NEUNER,0)) AS NEUNER,');
    add('  SUM(isNull(SC_X,0)) AS X');
    add('FROM SCORES sc');
    add('  INNER JOIN PERSON pe');
    add('    ON pe.PE_ID = sc.PE_ID');
    add('  LEFT OUTER JOIN VEREIN ve');
    add('    ON pe.VE_ID = ve.VE_ID');
    add('GROUP BY');
    add('  pe.PE_VORNAME,');
    add('  pe.PE_NACHNAME,');
    add('  ve.VE_NAME,');
    add('  pe.PE_BOGENKATEGORIE,');
    add('  pe.PE_ALTERSKLASSE,');
    add('  pe.PE_GESCHLECHT');
    add('ORDER BY');
    add('  pe.PE_BOGENKATEGORIE,');
    add('  pe.PE_ALTERSKLASSE,');
    add('  pe.PE_GESCHLECHT,');
    add('  SCORE DESC,');
    add('  ZEHNER DESC,');
    add('  NEUNER DESC,');
    add('  X DESC');
    add('');
    //add('DECLARE @ID varchar(36)');
    //add('DECLARE @Platzierung integer');
    //add('');
    //add('DECLARE @kategorie_alt varchar(50)');
    //add('DECLARE @kategorie_neu varchar(50)');
    //add('');
    //add('DECLARE RANGLISTE_CURSOR CURSOR FOR');
    //add('  SELECT');
    //add('    ID,');
    //add('    KATEGORIE');
    //add('  FROM @tmp');
    //add('  ORDER BY');
    //add('    KATEGORIE,');
    //add('    SCORE DESC,');
    //add('    ZEHNER DESC,');
    //add('    NEUNER DESC,');
    //add('  X DESC');
    //add('');
    //add('OPEN RANGLISTE_CURSOR');
    //add('');
    //add('FETCH NEXT FROM RANGLISTE_CURSOR INTO');
    //add('  @ID,');
    //add('  @kategorie_alt');
    //add('');
    //add('SET @kategorie_neu = @kategorie_alt');
    //add('SET @Platzierung = 0  ');
    //add('');
    //add('WHILE @@FETCH_STATUS = 0');
    //add('BEGIN');
    //add('  IF (@kategorie_neu = @kategorie_alt)');
    //add('  BEGIN');
    //add('    START:');
    //add('    SET  @Platzierung = @Platzierung+1  ');
    //add('');
    //add('    UPDATE @tmp');
    //add('    SET PLATZ = CAST(@Platzierung as varchar(20))+' + quotedStr('.') + '');
    //add('    WHERE ID = @ID');
    //add('  END');
    //add('  ELSE');
    //add('  BEGIN');
    //add('    SET @Platzierung = 0');
    //add('	GOTO START');
    //add('  END');
    //add('');
    //add('  SET @kategorie_alt = @kategorie_neu');
    //add('');
    //add('  FETCH NEXT FROM RANGLISTE_CURSOR INTO');
    //add('    @ID,');
    //add('    @kategorie_neu');
    //add('END');
    //add('');
    //add('CLOSE RANGLISTE_CURSOR');
    //add('DEALLOCATE RANGLISTE_CURSOR');
    //add('');
    //add('');
    //add('SELECT * FROM @tmp');
    //add('ORDER BY');
    //add('  KATEGORIE,');
    //add('  SCORE DESC,');
    //add('  ZEHNER DESC,');
    //add('  NEUNER DESC,');
    //add('  X DESC');
  end;
end;

end.
