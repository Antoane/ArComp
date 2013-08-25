unit ARC_DAL_Turnier;

interface

uses
  Data.Win.ADODB;

type
  TARC_DAL_Turnier = class(TObject)

  private
  public
    class procedure selectFreieScheibenplaetze(query: TADOQuery); static;
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

end.
