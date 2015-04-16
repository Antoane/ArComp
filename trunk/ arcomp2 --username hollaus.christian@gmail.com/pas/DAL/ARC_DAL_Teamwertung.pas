unit ARC_DAL_Teamwertung;

interface

uses
  Data.Win.ADODB,
  sysutils,
  ARC_Types,
  ARC_Functions,
  ARC_Tools;

type
  TARC_DAL_Teamwertung = class(TObject)

  private

  public
    class procedure selectPersonenZuVerein(const query: TADOQuery; const VE_ID: string; const TU_ID: string;
      const bogenkategorie: string); static;
    class procedure selectVereine(const query: TADOQuery); static;
    class function addTeam(const TU_ID: string; const TE_NAME: string; const TE_BOGENKATEGORIE: string;
      const VE_ID: string; const connection: TADOConnection): string; static;
    class procedure addTeamMember(const TE_ID, PE_ID: string; const connection: TADOConnection); static;
    class procedure SQL_Teamwertung(const query: TADOQuery; const TU_ID: string); static;
    class procedure selectTeam(const query: TADOQuery; const TE_ID: string);
    class procedure SQL_TeamEntfernen(const TE_ID: string; const connection: TADOConnection);
    class procedure selectBogenkategorien(const query: TADOQuery); static;
  end;

implementation

class procedure TARC_DAL_Teamwertung.selectVereine(const query: TADOQuery);
begin
  query.Close;
  with query.SQL do
  begin
    clear;
    add('SELECT');
    add('  VE_ID,');
    add('  VE_NAME');
    add('FROM VEREIN');
    add('ORDER BY VE_NAME');
  end;
end;

class procedure TARC_DAL_Teamwertung.selectBogenkategorien(const query: TADOQuery);
begin
  query.Close;
  with query.SQL do
  begin
    clear;
    add('SELECT');
    add('  BK_ID,');
    add('  BK_NAME');
    add('FROM BOGENKATEGORIE');
    add('ORDER BY BK_NAME');
  end;
end;

class procedure TARC_DAL_Teamwertung.selectPersonenZuVerein(const query: TADOQuery; const VE_ID: string;
  const TU_ID: string; const bogenkategorie: string);
begin
  query.Close;
  with query.SQL do
  begin
    clear;
    add('SELECT');
    add('  pe.PE_ID,');
    add('  pe.PE_NACHNAME + ' + quotedStr(' ') + ' + pe.PE_VORNAME AS NAME');
    add('FROM PERSON pe');
    add('  INNER JOIN TURNIER_ZUTEILUNG tz');
    add('    ON pe.PE_ID = tz.PE_ID');
    add('  INNER JOIN VEREIN ve');
    add('    ON pe.VE_ID = ve.VE_ID');
    add('WHERE tz.TU_ID = ' + quotedStr(TU_ID));
    add('  AND pe.VE_ID = ' + quotedStr(VE_ID));
    add('ORDER BY NAME');
  end;
end;

class procedure TARC_DAL_Teamwertung.selectTeam(const query: TADOQuery; const TE_ID: string);
begin
  query.Close;
  with query.SQL do
  begin
    clear;
    add('SELECT');
    add('  te.TE_NAME,');
    add('  te.TE_BOGENKATEGORIE,');
    add('  te.TE_ID,');
    add('  te.VE_ID,');
    add('  tz.PE_ID');
    add('FROM TEAM te');
    add('  LEFT OUTER JOIN TEAM_ZU tz');
    add('    ON te.TE_ID = tz.TE_ID');
    add('WHERE te.TE_ID = ' + quotedStr(TE_ID));
  end;
end;

class procedure TARC_DAL_Teamwertung.SQL_Teamwertung(const query: TADOQuery; const TU_ID: string);
begin
  query.Close;
  with query.SQL do
  begin
    clear;
    add('SELECT');
    add('  te.TE_ID,');
    add('  te.TE_NAME,');
    add('  SUM(isNull(sc.SC_SCORE,0)) AS SCORE,');
    add('  SUM(isNull(sc.SC_ZEHNER,0)) AS ZEHNER,');
    add('  SUM(isNull(sc.SC_NEUNER,0)) AS NEUNER,');
    add('  SUM(isNull(sc.SC_X,0)) AS X');
    add('    FROM TEAM te');
    add('	  INNER JOIN TURNIER tu');
    add('        ON tu.TU_ID = te.TU_ID');
    add('      LEFT OUTER JOIN TEAM_ZU tz');
    add('        ON te.TE_ID = tz.TE_ID');
    add('      LEFT OUTER JOIN PERSON pe');
    add('        ON pe.PE_ID = tz.PE_ID');
    add('      LEFT OUTER JOIN SCORES sc');
    add('        ON sc.PE_ID = pe.PE_ID');
    add('    	  AND sc.TU_ID = tu.TU_ID');
    add('WHERE tu.TU_ID = ' + quotedStr(TU_ID));
    add('GROUP BY ');
    add('  te.TE_ID,');
    add('  te.TE_NAME');
    add('ORDER BY');
    add('  SCORE DESC,');
    add('  ZEHNER DESC,');
    add('  NEUNER DESC,');
    add('  X DESC');
  end;
end;

class function TARC_DAL_Teamwertung.addTeam(const TU_ID: string; const TE_NAME: string; const TE_BOGENKATEGORIE: string;
  const VE_ID: string; const connection: TADOConnection): string;
var
  aQuery: TADOQuery;
  aTE_ID: string;
begin
  aTE_ID := newGUID();
  result := aTE_ID;
  aQuery := TADOQuery.Create(nil);
  try
    aQuery.connection := connection;
    with aQuery.SQL do
    begin
      clear;
      add('INSERT INTO TEAM(');
      add('  TE_ID,');
      add('  TE_NAME,');
      add('  TE_BOGENKATEGORIE,');
      add('  VE_ID,');
      add('  TU_ID');
      add(')');
      add('VALUES(');
      add('  ' + quotedStr(aTE_ID) + ',');
      add('  ' + quotedStr(TE_NAME) + ',');
      add('  ' + quotedStr(TE_BOGENKATEGORIE) + ',');
      add('  ' + quotedStr(VE_ID) + ',');
      add('  ' + quotedStr(TU_ID));
      add(')');
    end;
    aQuery.ExecSQL;
  finally
    aQuery.Free;
  end;
end;

class procedure TARC_DAL_Teamwertung.SQL_TeamEntfernen(const TE_ID: string; const connection: TADOConnection);
var
  aQuery: TADOQuery;
begin
  aQuery := TADOQuery.Create(nil);
  try
    aQuery.connection := connection;
    with aQuery.SQL do
    begin
      clear;
      add('DELETE FROM TEAM_ZU');
      add('WHERE TE_ID = ' + quotedStr(TE_ID));
      add('');
      add('DELETE FROM TEAM');
      add('WHERE TE_ID = ' + quotedStr(TE_ID));
    end;
    aQuery.ExecSQL;
  finally
    aQuery.Free;
  end;
end;

class procedure TARC_DAL_Teamwertung.addTeamMember(const TE_ID: string; const PE_ID: string;
  const connection: TADOConnection);
var
  aQuery: TADOQuery;
  aTE_ID: string;
begin
  aQuery := TADOQuery.Create(nil);
  try
    aQuery.connection := connection;
    with aQuery.SQL do
    begin
      clear;
      add('INSERT INTO TEAM_ZU(');
      add('  TZ_ID,');
      add('  TE_ID,');
      add('  PE_ID');
      add(')');
      add('VALUES(');
      add('  newID(),');
      add('  ' + quotedStr(TE_ID) + ',');
      add('  ' + quotedStr(PE_ID));
      add(')');
    end;
    aQuery.ExecSQL;
  finally
    aQuery.Free;
  end;
end;

end.
