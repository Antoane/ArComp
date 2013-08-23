unit ARC_DAL_Distanz;

interface

uses
  System.SysUtils,
  Data.Win.ADODB,

  //ArComp
  ARC_DAL_Tools,
  ARC_Types;

type
  TARC_DAL_Distanz = class(TObject)
  private

  public
    class procedure selectDistanzen(const query: TADOQuery; const turnierart: string;
      const bogenklasse, altersklasse, geschlecht: string);
    class procedure insertDistanzen(const query: TADOQuery; const turnierart, bogenklasse, altersklasse,
      geschlecht: string; const distanz: integer); static;
    class procedure deleteDistanz(query: TADOQuery; DI_ID: string); static;
    class procedure UpdateDistanz(query: TADOQuery; DI_ID: string; distanz: integer); static;
  end;

implementation

class procedure TARC_DAL_Distanz.selectDistanzen(const query: TADOQuery; const turnierart: string;
  const bogenklasse: string; const altersklasse: string; const geschlecht: string);
begin
  with query.SQL do
  begin
    clear;
    add('SELECT');
    add('  di.DI_ID,');
    add('  di.TA_ID,');
    add('  di.BK_ID,');
    add('  di.AK_ID,');
    add('  di.GE_ID,');
    add('  di.DI_RUNDE,');
    add('  di.DI_DISTANZ,');
    add('  ta.TA_NAME,');
    add('  bk.BK_NAME,');
    add('  ak.AK_NAME,');
    add('  ge.GE_NAME');
    add('FROM DISTANZ di');
    add('  INNER JOIN TURNIERART ta');
    add('    ON di.TA_ID = ta.TA_ID');
    add('  INNER JOIN BOGENKATEGORIE bk');
    add('    ON di.BK_ID = bk.BK_ID');
    add('  INNER JOIN ALTERSKATEGORIE ak');
    add('    ON di.AK_ID = ak.AK_ID');
    add('  INNER JOIN GESCHLECHT ge');
    add('    ON di.GE_ID = ge.GE_ID');
    add('WHERE 1=1');
    if turnierart <> '' then
    begin
      add('AND di.TA_ID = ' + quotedstr(TARC_DAL_Tools.getIdForName(turnierart, tftTurnierart, query.Connection)));
    end;
    if bogenklasse <> '' then
    begin
      add('AND di.BK_ID = ' + quotedstr(TARC_DAL_Tools.getIdForName(bogenklasse, tftBogenklasse, query.Connection)));
    end;
    if altersklasse <> '' then
    begin
      add('AND di.AK_ID = ' + quotedstr(TARC_DAL_Tools.getIdForName(altersklasse, tftAltersklasse, query.Connection)));
    end;
    if geschlecht <> '' then
    begin
      add('AND di.GE_ID = ' + quotedstr(TARC_DAL_Tools.getIdForName(geschlecht, tftGeschlecht, query.Connection)));
    end;
    add('ORDER BY');
    add('  ta.TA_NAME,');
    add('  ak.AK_NAME,');
    add('  bk.BK_NAME,');
    add('  ge.GE_NAME,');
    add('  di.DI_RUNDE');
  end;
end;

class procedure TARC_DAL_Distanz.insertDistanzen(const query: TADOQuery; const turnierart: string;
  const bogenklasse: string; const altersklasse: string; const geschlecht: string; const distanz: integer);
begin
  with query.SQL do
  begin
    clear;
    add('INSERT INTO DISTANZ(');
    add('  DI_ID,');
    add('  TA_ID,');
    add('  AK_ID,');
    add('  BK_ID,');
    add('  GE_ID,');
    add('  DI_RUNDE,');
    add('  DI_DISTANZ');
    add(')');
    add('SELECT ');
    add('  newID(),');
    add('  ta.TA_ID, ');
    add('  ak.AK_ID, ');
    add('  bk.BK_ID, ');
    add('  ge.GE_ID, ');
    add('  isNull(di.DI_RUNDE,0) +1,');
    add('  ' + IntToStr(distanz));
    add('FROM TURNIERART ta');
    add('  FULL OUTER JOIN  ALTERSKATEGORIE ak');
    add('    ON 1=1');
    add('  FULL OUTER JOIN BOGENKATEGORIE bk');
    add('    ON 1=1');
    add('  FULL OUTER JOIN GESCHLECHT ge');
    add('    ON 1=1');
    add('  LEFT OUTER JOIN DISTANZ di');
    add('    ON di.DI_ID =');
    add('	  (SELECT TOP 1');
    add('	      DI_ID');
    add('		FROM DISTANZ di');
    add('		WHERE ak.AK_ID = di.AK_ID');
    add('	      AND ta.TA_ID = di.TA_ID');
    add('	      AND bk.BK_ID = di.BK_ID');
    add('	      AND ge.GE_ID = di.GE_ID');
    add('		ORDER BY DI_RUNDE DESC');
    add('	  )');
    add('WHERE 1=1');
    if turnierart <> '' then
    begin
      add('AND ta.TA_ID = ' + quotedstr(TARC_DAL_Tools.getIdForName(turnierart, tftTurnierart, query.Connection)));
    end;
    if altersklasse <> '' then
    begin
      add('AND ak.AK_ID = ' + quotedstr(TARC_DAL_Tools.getIdForName(altersklasse, tftAltersklasse, query.Connection)));
    end;
    if bogenklasse <> '' then
    begin
      add('AND bk.BK_ID = ' + quotedstr(TARC_DAL_Tools.getIdForName(bogenklasse, tftBogenklasse, query.Connection)));
    end;
    if geschlecht <> '' then
    begin
      add('AND ge.GE_ID = ' + quotedstr(TARC_DAL_Tools.getIdForName(geschlecht, tftGeschlecht, query.Connection)));
    end;
  end;
end;

class procedure TARC_DAL_Distanz.deleteDistanz(query: TADOQuery; DI_ID: string);
begin
  with query.SQL do
  begin
    clear;
    add('DELETE FROM DISTANZ');
    add('WHERE DI_ID IN(');
    add('  SELECT di2.DI_ID');
    add('  FROM DISTANZ di1');
    add('    LEFT OUTER JOIN DISTANZ di2');
    add('      ON di1.TA_ID = di2.TA_ID');
    add('        AND di1.AK_ID = di2.AK_ID');
    add('        AND di1.BK_ID = di2.BK_ID');
    add('        AND di1.GE_ID = di2.GE_ID');
    add('        AND di2.DI_RUNDE > = di1.DI_RUNDE');
    add('  WHERE di1.DI_ID = ' + quotedstr(DI_ID));
    add(')');
  end;
end;

class procedure TARC_DAL_Distanz.UpdateDistanz(query: TADOQuery; DI_ID: string; distanz: integer);
begin
  with query.SQL do
  begin
    clear;
    add('UPDATE DISTANZ');
    add('SET DI_DISTANZ = ' + IntToStr(distanz));
    add('WHERE DI_ID = ' + quotedstr(DI_ID));
  end;
end;

end.
