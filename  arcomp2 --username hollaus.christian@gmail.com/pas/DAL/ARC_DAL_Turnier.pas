unit ARC_DAL_Turnier;

interface

uses
  Data.Win.ADODB,
  sysutils;

type
  TARC_DAL_Turnier = class(TObject)

  private

  public
    class procedure selectFreieScheibenplaetze(query: TADOQuery); static;

    class procedure selectScore(query: TADOQuery; TU_ID: string; scheibe: integer; scheibenPlatz: string); static;
  end;

implementation

class procedure TARC_DAL_Turnier.selectFreieScheibenplaetze(query: TADOQuery);
begin
  with query.SQL do
  begin
    clear;
    add('DECLARE @TU_ID varchar(36)');
    add('DECLARE @scheibenGesamt integer');
    add('DECLARE @proScheibe integer');
    add('');
    add('SET @TU_ID = :TU_ID');
    add('');
    add('SET @scheibenGesamt = (SELECT TU_SCHEIBENANZAHL FROM TURNIER WHERE TU_ID = @TU_ID)');
    add('SET @proScheibe = (SELECT TU_PERSONEN_PRO_SCHEIBE FROM TURNIER WHERE TU_ID = @TU_ID)');
    add('');
    add('DECLARE @scheibenplaetze TABLE(');
    add('  SE_NUMMER integer,');
    add('  FREIE_PLAETZE integer');
    add(')');
    add('');
    add('DECLARE @i integer');
    add('');
    add('SET @i = 1');
    add('');
    add('WHILE @i <= @scheibenGesamt');
    add('BEGIN ');
    add('    INSERT INTO @scheibenplaetze(');
    add('	  SE_NUMMER,');
    add('	  FREIE_PLAETZE');
    add('	)');
    add('	VALUES(');
    add('	  @i,');
    add('	  @proScheibe');
    add('	)');
    add('	SET @i = @i+1');
    add('END');
    add('');
    add('DECLARE @tmp TABLE(');
    add('  SE_NUMMER integer,');
    add('  FREIE_PLAETZE integer');
    add(')');
    add('');
    add('INSERT INTO @tmp(');
    add('  SE_NUMMER,');
    add('  FREIE_PLAETZE');
    add(')');
    add('SELECT ');
    add('  se.SE_NUMMER,');
    add('  @proScheibe - COUNT(se.SE_NUMMER) AS FREIE_PLAETZE');
    add('FROM SCHEIBENEINTEILUNG se');
    add('WHERE se.TU_ID = @TU_ID');
    add('GROUP BY se.SE_NUMMER');
    add('');
    add('');
    add('UPDATE @scheibenplaetze');
    add('  SET FREIE_PLAETZE = tmp.FREIE_PLAETZE');
    add('    FROM @tmp tmp');
    add('	INNER JOIN @scheibenplaetze sp');
    add('	  on tmp.SE_NUMMER = sp.SE_NUMMER');
    add('');
    add('SELECT * FROM @scheibenplaetze');
  end;
end;

class procedure TARC_DAL_Turnier.selectScore(query: TADOQuery; TU_ID: string; scheibe: integer; scheibenPlatz: string);
begin
  with query.SQL do
  begin
    clear;
    add('DECLARE @TU_ID varchar(36)');
    add('');
    add('SET @TU_ID = ' + quotedStr(TU_ID));
    add('');
    add('DECLARE @tmp TABLE(');
    add('  PE_ID varchar(36),');
    add('  NAME varchar(200),');
    add('  BK_NAME varchar(50),');
    add('  AK_NAME varchar(50),');
    add('  GE_NAME varchar(50),');
    add('  VE_NAME varchar(50),');
    add('  DI_RUNDE varchar(50),');
    add('  DI_DISTANZ decimal(18,2),');
    add('  SE_NUMMER integer,');
    add('  SE_PLATZ varchar(10),');
    add('  SC_ID varchar(36),');
    add('  SC_SCORE integer,');
    add('  SC_ZEHNER integer,');
    add('  SC_NEUNER integer,');
    add('  SC_X integer');
    add(')');
    add('');
    add('INSERT INTO @tmp');
    add('SELECT');
    add('  pe.PE_ID,');
    add('  isNull(pe.PE_NACHNAME,' + quotedStr('') + ') + ' + quotedStr(' ') + ' +isNull(pe.PE_VORNAME,' + quotedStr('')
      + ') AS NAME,');
    add('  bk.BK_NAME,');
    add('  ak.AK_NAME,');
    add('  ge.GE_NAME,');
    add('  ve.VE_NAME,');
    add('  di.DI_RUNDE,');
    add('  di.DI_DISTANZ,');
    add('  se.SE_NUMMER,');
    add('  se.SE_PLATZ,');
    add('  sc.SC_ID,');
    add('  sc.SC_SCORE,');
    add('  sc.SC_ZEHNER,');
    add('  sc.SC_NEUNER,');
    add('  sc.SC_X');
    add('FROM TURNIER tu');
    add('  INNER JOIN TURNIER_ZUTEILUNG zu');
    add('    ON tu.TU_ID = zu.TU_ID');
    add('  INNER JOIN PERSON pe');
    add('    ON zu.PE_ID = pe.PE_ID');
    add('  LEFT OUTER JOIN VEREIN ve');
    add('    ON ve.VE_ID = pe.VE_ID');
    add('  INNER JOIN BOGENKATEGORIE bk');
    add('    ON pe.PE_BOGENKATEGORIE = bk.BK_NAME');
    add('  INNER JOIN ALTERSKATEGORIE ak');
    add('    ON pe.PE_ALTERSKLASSE = ak.AK_NAME');
    add('  INNER JOIN GESCHLECHT ge');
    add('    ON pe.PE_GESCHLECHT = ge.GE_NAME');
    add('  INNER JOIN DISTANZ di');
    add('    ON di.TA_ID = tu.TA_ID');
    add('	  AND di.BK_ID = bk.BK_ID');
    add('	  AND di.AK_ID = ak.AK_ID');
    add('	  AND di.GE_ID = ge.GE_ID');
    add('  INNER JOIN SCHEIBENEINTEILUNG se');
    add('    ON se.TU_ID = tu.TU_ID');
    add('	  AND se.PE_ID = pe.PE_ID');
    add('  LEFT OUTER JOIN SCORES sc');
    add('    ON tu.TU_ID = sc.TU_ID');
    add('	  AND pe.PE_ID = sc.PE_ID');
    add('	  AND di.DI_RUNDE = sc.SC_RUNDE');
    add('WHERE tu.TU_ID = @TU_ID');
    add('  AND se.SE_NUMMER = ' + IntToStr(scheibe));
    add('  AND se.SE_PLATZ = ' + quotedStr(scheibenPlatz));
    add('ORDER BY ');
    add('  di.DI_RUNDE');
    add('');
    add('');
    add('SELECT');
    add('  PE_ID,');
    add('  NAME,');
    add('  BK_NAME,');
    add('  AK_NAME,');
    add('  GE_NAME,');
    add('  VE_NAME,');
    add('  DI_RUNDE,');
    add('  DI_DISTANZ,');
    add('  SE_NUMMER,');
    add('  SE_PLATZ,');
    add('  SC_ID,');
    add('  SC_SCORE,');
    add('  SC_ZEHNER,');
    add('  SC_NEUNER,');
    add('  SC_X');
    add('FROM @tmp');
    add('');
    add('UNION');
    add('');
    add('SELECT');
    add('  PE_ID,');
    add('  NAME,');
    add('  BK_NAME,');
    add('  AK_NAME,');
    add('  GE_NAME,');
    add('  VE_NAME,');
    add('  ' + quotedStr('GESAMT') + ',');
    add('  NULL,');
    add('  NULL,');
    add('  NULL,');
    add('  NULL,');
    add('  SUM(isNull(SC_SCORE,0)),');
    add('  SUM(isNull(SC_ZEHNER,0)),');
    add('  SUM(isNull(SC_NEUNER,0)),');
    add('  SUM(isNull(SC_X,0))');
    add('FROM @tmp');
    add('GROUP BY');
    add('  PE_ID,');
    add('  NAME,');
    add('  BK_NAME,');
    add('  AK_NAME,');
    add('  GE_NAME,');
    add('  VE_NAME');
    add('ORDER BY DI_RUNDE');
  end;
end;

end.
