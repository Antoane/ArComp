unit ARC_BL_Finale;

interface

uses
  Data.Win.ADODB,
  db,
  System.Classes,
  System.SysUtils,
  variants,
  vcl.dialogs,
  vcl.Dbctrls,
  vcl.StdCtrls,

  //ArComp
  ARC_Functions;

type
  TARC_BL_Finale = class(TObject)

  private
    FConnection : TADOConnection;
    FQueryFinale: TADOQuery;
    procedure createTmpTableFinalAuswahl;

    procedure addPersonToFinale(FI_ID, PE_ID: string; platzierung: integer);

  public
    constructor create(owner: TComponent; connection: TADOConnection);
    destructor destroy();

    //Finale
    procedure fillComboFinale(combo: TCombobox; TU_ID: string);
    procedure addFinale(name: string; TU_ID: string; FI_ID: string);
    procedure deleteSelectedFinale;
    procedure fillComboFinaleBogenkategorie(combo: TCombobox; TU_ID: string);
    procedure fillComboFinaleAlterskategorie(combo: TCombobox; TU_ID, bogenkategorie: string);
    procedure fillComboFinaleGeschlecht(combo: TCombobox; TU_ID, bogenkategorie, alterskategorie: string);

    procedure addToFinale(query: TADOQuery; TU_ID, bogenkategorie, alterskategorie, geschlecht: string);
    procedure fillComboFinalRaster(combo: TCombobox; query: TADOQuery);

    procedure finaleAnlegen(TU_ID: string; teilnehmer: TADOQuery; anzahl: integer; finalname: string);

    property Finale: TADOQuery
      read   FQueryFinale;
  end;

implementation

{TARC_BL_Turnier}

constructor TARC_BL_Finale.create(owner: TComponent; connection: TADOConnection);
begin
  inherited create;
  FConnection             := connection;
  FQueryFinale            := TADOQuery.create(nil);
  FQueryFinale.connection := FConnection;

end;

destructor TARC_BL_Finale.destroy;
begin
  FConnection.Free;
  FQueryFinale.Free;
  inherited destroy();
end;

procedure TARC_BL_Finale.fillComboFinale(combo: TCombobox; TU_ID: string);
begin
  with FQueryFinale.SQL do
  begin
    clear;
    add('SELECT');
    add('  FI_ID,');
    add('  FI_NAME');
    add('FROM FINALE');
    add('WHERE TU_ID = ' + quotedStr(TU_ID));
  end;
  FQueryFinale.open();
  FQueryFinale.First;
  combo.Items.clear;

  if FQueryFinale.Active and (FQueryFinale.RecordCount > 0) then
  begin
    while not FQueryFinale.Eof do
    begin
      combo.Items.add(FQueryFinale.FieldByName('FI_NAME').AsString);
      FQueryFinale.Next;
    end;
    combo.ItemIndex := 0;
  end;
end;

procedure TARC_BL_Finale.addFinale(name: string; TU_ID: string; FI_ID: string);
var
  aQuery: TADOQuery;
begin
  aQuery := TADOQuery.create(nil);
  try
    aQuery.connection := FConnection;
    with aQuery.SQL do
    begin
      add('INSERT INTO FINALE');
      add('VALUES(');
      add('  ' + quotedStr(FI_ID) + ',');
      add('  ' + quotedStr(TU_ID) + ',');
      add('  ' + quotedStr(name));
      add(')');
    end;
    aQuery.ExecSQL;
  finally
    aQuery.Free;
  end;
end;

procedure TARC_BL_Finale.deleteSelectedFinale;
var
  aQuery: TADOQuery;
  aFI_ID: string;
begin
  if FQueryFinale.Active and (FQueryFinale.RecordCount > 0) then
  begin
    aFI_ID := FQueryFinale.FieldByName('FI_ID').AsString;
    aQuery := TADOQuery.create(nil);
    try
      aQuery.connection := FConnection;
      with aQuery.SQL do
      begin
        add('DELETE FROM FINALE');
        add('WHERE FI_ID = ' + quotedStr(aFI_ID));
      end;
      aQuery.ExecSQL;
    finally
      aQuery.Free;
    end;
  end;
end;

procedure TARC_BL_Finale.fillComboFinaleBogenkategorie(combo: TCombobox; TU_ID: string);
var
  aQuery: TADOQuery;
begin
  aQuery := TADOQuery.create(nil);
  try
    aQuery.connection := FConnection;
  finally
    with aQuery.SQL do
    begin
      clear;
      add('SELECT DISTINCT');
      add('  pe.PE_BOGENKATEGORIE');
      add('FROM TURNIER tu');
      add('  INNER JOIN TURNIER_ZUTEILUNG zu');
      add('    ON tu.TU_ID = zu.TU_ID');
      add('  INNER JOIN PERSON pe');
      add('    ON zu.PE_ID = pe.PE_ID');
      add('WHERE tu.TU_ID = ' + quotedStr(TU_ID));
    end;
    aQuery.open();
    aQuery.First;
    combo.Items.clear;

    if aQuery.Active and (aQuery.RecordCount > 0) then
    begin
      while not aQuery.Eof do
      begin
        combo.Items.add(aQuery.FieldByName('PE_BOGENKATEGORIE').AsString);
        aQuery.Next;
      end;
      combo.ItemIndex := 0;
    end;
  end;
end;

procedure TARC_BL_Finale.fillComboFinaleAlterskategorie(combo: TCombobox; TU_ID: string; bogenkategorie: string);
var
  aQuery: TADOQuery;
begin
  aQuery := TADOQuery.create(nil);
  try
    aQuery.connection := FConnection;
    with aQuery.SQL do
    begin
      clear;
      add('SELECT DISTINCT');
      add('  pe.PE_ALTERSKLASSE');
      add('FROM TURNIER tu');
      add('  INNER JOIN TURNIER_ZUTEILUNG zu');
      add('    ON tu.TU_ID = zu.TU_ID');
      add('  INNER JOIN PERSON pe');
      add('    ON zu.PE_ID = pe.PE_ID');
      add('WHERE tu.TU_ID = ' + quotedStr(TU_ID));
      add('AND pe.PE_BOGENKATEGORIE = ' + quotedStr(bogenkategorie));
    end;
    aQuery.open();
    aQuery.First;
    combo.Items.clear;

    if aQuery.Active and (aQuery.RecordCount > 0) then
    begin
      while not aQuery.Eof do
      begin
        combo.Items.add(aQuery.FieldByName('PE_ALTERSKLASSE').AsString);
        aQuery.Next;
      end;
      combo.ItemIndex := 0;
    end;
  finally
    aQuery.Free;
  end;
end;

procedure TARC_BL_Finale.fillComboFinaleGeschlecht(combo: TCombobox; TU_ID: string; bogenkategorie: string;
  alterskategorie: string);
var
  aQuery: TADOQuery;
begin
  aQuery := TADOQuery.create(nil);
  try
    aQuery.connection := FConnection;
    with aQuery.SQL do
    begin
      clear;
      add('SELECT DISTINCT');
      add('  pe.PE_GESCHLECHT');
      add('FROM TURNIER tu');
      add('  INNER JOIN TURNIER_ZUTEILUNG zu');
      add('    ON tu.TU_ID = zu.TU_ID');
      add('  INNER JOIN PERSON pe');
      add('    ON zu.PE_ID = pe.PE_ID');
      add('WHERE tu.TU_ID = ' + quotedStr(TU_ID));
      add('AND pe.PE_BOGENKATEGORIE = ' + quotedStr(bogenkategorie));
      add('AND pe.PE_ALTERSKLASSE = ' + quotedStr(alterskategorie));
    end;
    aQuery.open();
    aQuery.First;
    combo.Items.clear;

    if aQuery.Active and (aQuery.RecordCount > 0) then
    begin
      while not aQuery.Eof do
      begin
        combo.Items.add(aQuery.FieldByName('PE_GESCHLECHT').AsString);
        aQuery.Next;
      end;
      combo.ItemIndex := 0;
    end;
  finally
    aQuery.Free;
  end;
end;

procedure TARC_BL_Finale.createTmpTableFinalAuswahl;
var
  aQuery: TADOQuery;
begin
  aQuery := TADOQuery.create(nil);
  try
    aQuery.connection := FConnection;
    with aQuery.SQL do
    begin
      add('IF OBJECT_ID(' + quotedStr('tempdb..#FINALAUSWAHL') + ') IS NULL');
      add('BEGIN');
      add('  CREATE TABLE #FINALAUSWAHL(');
      add('    PE_ID varchar(36),');
      add('    PE_VORNAME varchar(50),');
      add('    PE_NACHNAME varchar(50),');
      add('    VE_NAME varchar(50),');
      add('    PE_BOGENKATEGORIE varchar(50),');
      add('    PE_ALTERSKLASSE varchar(50),');
      add('    PE_GESCHLECHT varchar(50),');
      add('    SCORE integer,');
      add('    ZEHNER integer,');
      add('    NEUNER integer,');
      add('    X integer');
      add('  )');
      add('END');
    end;
    aQuery.ExecSQL;
  finally
    aQuery.Free;
  end;

end;

procedure TARC_BL_Finale.addToFinale(query: TADOQuery; TU_ID: string; bogenkategorie: string; alterskategorie: string;
  geschlecht: string);
begin
  createTmpTableFinalAuswahl();
  query.connection := FConnection;
  with query.SQL do
  begin
    clear;
    add('DECLARE @TU_ID varchar(36)');
    add('DECLARE @BOGENKATEGORIE varchar(50)');
    add('DECLARE @ALTERSKATEGORIE varchar(50)');
    add('DECLARE @GESCHLECHT varchar(50)');
    add('');
    add('SET @TU_ID = ' + quotedStr(TU_ID));
    add('SET @BOGENKATEGORIE = ' + quotedStr(bogenkategorie));
    add('SET @ALTERSKATEGORIE = ' + quotedStr(alterskategorie));
    add('SET @GESCHLECHT = ' + quotedStr(geschlecht));
    add('');
    add('INSERT INTO #FINALAUSWAHL(');
    add('  PE_ID,');
    add('  PE_VORNAME,');
    add('  PE_NACHNAME,');
    add('  VE_NAME,');
    add('  PE_BOGENKATEGORIE,');
    add('  PE_ALTERSKLASSE,');
    add('  PE_GESCHLECHT,');
    add('  SCORE,');
    add('  ZEHNER,');
    add('  NEUNER,');
    add('  X');
    add(')');
    add('SELECT');
    add('  pe.PE_ID,');
    add('  pe.PE_VORNAME,');
    add('  pe.PE_NACHNAME,');
    add('  ve.VE_NAME,');
    add('  pe.PE_BOGENKATEGORIE,');
    add('  pe.PE_ALTERSKLASSE,');
    add('  pe.PE_GESCHLECHT,');
    add('  SUM(isNull(SC_SCORE,0)) AS SCORE,');
    add('  SUM(isNull(SC_ZEHNER,0)) AS ZEHNER,');
    add('  SUM(isNull(SC_NEUNER,0)) AS NEUNER,');
    add('  SUM(isNull(SC_X,0)) AS X');
    add('FROM SCORES sc');
    add('  INNER JOIN PERSON pe');
    add('    ON pe.PE_ID = sc.PE_ID');
    add('  LEFT OUTER JOIN VEREIN ve');
    add('    ON pe.VE_ID = ve.VE_ID                                                                                              ');
    add('WHERE sc.TU_ID =  @TU_ID');
    add('  AND pe.PE_BOGENKATEGORIE = @BOGENKATEGORIE');
    add('  AND pe.PE_ALTERSKLASSE = @ALTERSKATEGORIE');
    add('  AND pe.PE_GESCHLECHT = @GESCHLECHT');
    add('  AND pe.PE_ID NOT IN (SELECT PE_ID FROM #FINALAUSWAHL)');
    add('GROUP BY');
    add('  pe.PE_ID,');
    add('  pe.PE_VORNAME,');
    add('  pe.PE_NACHNAME,');
    add('  ve.VE_NAME,');
    add('  pe.PE_BOGENKATEGORIE,');
    add('  pe.PE_ALTERSKLASSE,');
    add('  pe.PE_GESCHLECHT      ');
    add('ORDER BY                 ');
    add('  SCORE DESC,');
    add('  ZEHNER DESC,');
    add('  NEUNER DESC,');
    add('  X DESC');
    add('');
    add('');
    add('SELECT * FROM #FINALAUSWAHL');
    add('ORDER BY                 ');
    add('  SCORE DESC,');
    add('  ZEHNER DESC,');
    add('  NEUNER DESC,');
    add('  X DESC');
  end;

  query.open;
end;

procedure TARC_BL_Finale.fillComboFinalRaster(combo: TCombobox; query: TADOQuery);
var
  aRaster: integer;
begin
  combo.Items.clear;
  aRaster := 2;
  while aRaster <= query.RecordCount do
  begin
    combo.Items.add(intToStr(aRaster));
    aRaster := aRaster * 2;
  end;

  //1 Kardinalität höher für eventuelles Auffüllen mit Freilosen
  combo.Items.add(intToStr(aRaster));
  if combo.Items.Count > 1 then
  begin
    combo.ItemIndex := combo.Items.Count - 2;
  end
  else
  begin
    combo.ItemIndex := combo.Items.Count - 1;
  end;

end;

procedure TARC_BL_Finale.addPersonToFinale(FI_ID: string; PE_ID: string; platzierung: integer);
var
  aQuery: TADOQuery;
begin
  aQuery := TADOQuery.create(nil);
  try
    aQuery.connection := FConnection;
    with aQuery.SQL do
    begin
      add('INSERT INTO FINALZUORDNUNG(');
      add('  FZ_ID,');
      add('  FI_ID,');
      add('  PE_ID,');
      add('  FZ_PLATZIERUNG');
      add(')');
      add('VALUES(');
      add('  newID(),');
      add('  ' + quotedStr(FI_ID) + ',');
      add('  ' + quotedStr(PE_ID) + ',');
      add('  ' + intToStr(platzierung));
      add(')');
    end;
    aQuery.ExecSQL;
  finally
    aQuery.Free;
  end;
end;

procedure TARC_BL_Finale.finaleAnlegen(TU_ID: string; teilnehmer: TADOQuery; anzahl: integer; finalname: string);
var
  aFinalID    : string;
  aPlatzierung: integer;
begin
  aFinalID := newGUID();

  addFinale(finalname, TU_ID, aFinalID);

  aPlatzierung := 1;
  teilnehmer.DisableControls;
  teilnehmer.First;
  while not teilnehmer.Eof do
  begin
    addPersonToFinale(aFinalID, teilnehmer.FieldByName('PE_ID').AsString, aPlatzierung);
    inc(aPlatzierung);
    teilnehmer.Next;
  end;
  teilnehmer.EnableControls;

  while aPlatzierung <= anzahl do
  begin
    addPersonToFinale(aFinalID, '', aPlatzierung);
    inc(aPlatzierung);
  end;
end;

end.
