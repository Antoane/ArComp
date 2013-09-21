unit ARC_BL_Turnier;

interface

uses
  Data.Win.ADODB,
  db,
  System.Classes,
  System.SysUtils,
  variants,
  vcl.dialogs,
  vcl.controls,
  vcl.StdCtrls,

  //ArComp

  ARC_DAL_Turnier;

type
  TARC_BL_Turnier = class(TObject)

  private
    FConnection: TADOConnection;

  public
    constructor create(owner: TComponent; connection: TADOConnection);
    destructor destroy();

    procedure fillComboScheibenanzahl(combo: TCombobox; TU_ID: string);
    procedure fillComboScheibenPlatz(combo: TCombobox; TU_ID: string);
    function zuteilen(TU_ID, PE_ID: string; scheibe: TCombobox; platz: TCombobox): boolean;
    procedure zuteilungEntfernen(SE_ID: string);
    procedure selectFreieScheibe(comboScheibe, comboPlatz: TCombobox; TU_ID: string);
    procedure teilnehmerEinfuegen(TU_ID: string; PE_ID: string);

    procedure selectFreieScheibenInfo(query: TADOQuery; TU_ID: string);

    procedure fillComboScoresScheiben(combo: TCombobox; TU_ID: string);
    procedure fillComboScoresScheibenPlatz(combo: TCombobox; TU_ID: string; scheibe: integer);
    procedure selectScores(query: TADOQuery; scheibe: integer; scheibenplatz: string; TU_ID: string);
    procedure saveScore(TU_ID, PE_ID: string; SC_ID: string; runde, score, zehner, neuner, X: integer);

    procedure zuteilungResetten(TU_ID: string);
  end;

implementation

{TARC_BL_Turnier}

constructor TARC_BL_Turnier.create(owner: TComponent; connection: TADOConnection);
begin
  inherited create;
  FConnection := connection;

end;

destructor TARC_BL_Turnier.destroy;
begin
  FConnection.Free;
  inherited destroy();
end;

procedure TARC_BL_Turnier.fillComboScheibenanzahl(combo: TCombobox; TU_ID: string);
var
  aQuery         : TADOQuery;
  aScheibennummer: integer;
begin
  aQuery := TADOQuery.create(nil);
  try
    aQuery.connection := FConnection;
    with aQuery.SQL do
    begin
      clear;
      add('SELECT');
      add('  TU_SCHEIBENANZAHL');
      add('FROM TURNIER');
      add('WHERE TU_ID = ' + quotedStr(TU_ID));
    end;
    aQuery.open();
    if aQuery.Active and (aQuery.RecordCount > 0) then
    begin
      combo.Items.clear;
      aScheibennummer := 1;
      while aScheibennummer <= aQuery.FieldByName('TU_SCHEIBENANZAHL').AsInteger do
      begin
        combo.Items.add(IntToStr(aScheibennummer));
        inc(aScheibennummer);
      end;
      combo.ItemIndex := 0;
    end;
  finally
    aQuery.Free;
  end;
end;

procedure TARC_BL_Turnier.fillComboScheibenPlatz(combo: TCombobox; TU_ID: string);
var
  aQuery           : TADOQuery;
  aPlatznummer     : integer;
  aPlatzbezeichnung: char;
begin
  aQuery := TADOQuery.create(nil);
  try
    aQuery.connection := FConnection;
    with aQuery.SQL do
    begin
      clear;
      add('SELECT');
      add('  TU_PERSONEN_PRO_SCHEIBE');
      add('FROM TURNIER');
      add('WHERE TU_ID = ' + quotedStr(TU_ID));
    end;
    aQuery.open();
    if aQuery.Active and (aQuery.RecordCount > 0) then
    begin
      combo.Items.clear;
      aPlatznummer      := 1;
      aPlatzbezeichnung := 'A';
      while (aPlatznummer <= aQuery.FieldByName('TU_PERSONEN_PRO_SCHEIBE').AsInteger) and (aPlatznummer <= 26) do
      begin
        combo.Items.add(aPlatzbezeichnung);
        aPlatzbezeichnung := Succ(aPlatzbezeichnung);
        inc(aPlatznummer);
      end;
      combo.ItemIndex := 0;
    end;
  finally
    aQuery.Free;
  end;
end;

procedure TARC_BL_Turnier.zuteilungEntfernen(SE_ID: string);
var
  aQuery: TADOQuery;
begin
  aQuery := TADOQuery.create(nil);
  try
    aQuery.connection := FConnection;
    with aQuery.SQL do
    begin
      clear;
      add('DELETE');
      add('FROM SCHEIBENEINTEILUNG');
      add('WHERE SE_ID = ' + quotedStr(SE_ID));
    end;
    aQuery.ExecSQL;
  finally
    aQuery.Free;
  end;
end;

procedure TARC_BL_Turnier.zuteilungResetten(TU_ID: string);
var
  aQuery: TADOQuery;
begin
  aQuery := TADOQuery.create(nil);
  try
    aQuery.connection := FConnection;
    with aQuery.SQL do
    begin
      clear;
      add('DELETE');
      add('FROM SCHEIBENEINTEILUNG');
      add('WHERE TU_ID = ' + quotedStr(TU_ID));
    end;
    aQuery.ExecSQL;
  finally
    aQuery.Free;
  end;
end;

function TARC_BL_Turnier.zuteilen(TU_ID: string; PE_ID: string; scheibe: TCombobox; platz: TCombobox): boolean;
var
  aQueryCheck : TADOQuery;
  aQueryInsert: TADOQuery;
  aScheibe    : integer;
  aPlatz      : string;
begin
  aQueryCheck  := TADOQuery.create(nil);
  aQueryInsert := TADOQuery.create(nil);
  try
    aQueryCheck.connection  := FConnection;
    aQueryInsert.connection := FConnection;
    aScheibe                := StrToInt(scheibe.Text);
    aPlatz                  := platz.Text;
    with aQueryCheck.SQL do
    begin
      clear;
      add('SELECT');
      add('  PE_ID');
      add('FROM SCHEIBENEINTEILUNG');
      add('WHERE TU_ID = ' + quotedStr(TU_ID));
      add('  AND SE_NUMMER = ' + IntToStr(aScheibe));
      add('  AND SE_PLATZ = ' + quotedStr(aPlatz));
    end;
    aQueryCheck.open;
    if aQueryCheck.Active and (aQueryCheck.RecordCount > 0) then
    begin
      if MessageDlg('Die gewählte Scheibe ist bereits einer Person zugeteilt. Soll die Zuordnung geändert werden?',
        mtConfirmation, mbYesNo, 0) = mrNo then
      begin
        result := false;
        exit;
      end;
    end;

    with aQueryInsert.SQL do
    begin
      add('DELETE');
      add('FROM SCHEIBENEINTEILUNG');
      add('WHERE TU_ID = ' + quotedStr(TU_ID));
      add('  AND SE_NUMMER = ' + IntToStr(aScheibe));
      add('  AND SE_PLATZ = ' + quotedStr(aPlatz));
      add('');
      add('INSERT INTO SCHEIBENEINTEILUNG(');
      add('  SE_ID,');
      add('  TU_ID,');
      add('  PE_ID,');
      add('  SE_NUMMER,');
      add('  SE_PLATZ');
      add(')');
      add('VALUES(');
      add('  newID(),');
      add('  ' + quotedStr(TU_ID) + ',');
      add('  ' + quotedStr(PE_ID) + ',');
      add('  ' + IntToStr(aScheibe) + ',');
      add('  ' + quotedStr(aPlatz));
      add(')  ');
    end;
    aQueryInsert.ExecSQL;

    selectFreieScheibe(scheibe, platz, TU_ID);
    result := true;
  finally
    aQueryCheck.Free;
    aQueryInsert.Free;
  end;
end;

procedure TARC_BL_Turnier.selectFreieScheibe(comboScheibe: TCombobox; comboPlatz: TCombobox; TU_ID: string);
var
  aAktuelleScheibe: integer;
  aAktuellerPlatz : string;
  aQuery          : TADOQuery;
  aScheibenIndex  : integer;
  aPlatzIndex     : integer;
begin
  aAktuelleScheibe := StrToInt(comboScheibe.Text);
  aAktuellerPlatz  := comboPlatz.Text;

  aQuery := TADOQuery.create(nil);
  try
    aQuery.connection := FConnection;

    with aQuery.SQL do
    begin
      add('SELECT');
      add('  SE_NUMMER,');
      add('  SE_PLATZ');
      add('FROM SCHEIBENEINTEILUNG');
      add('WHERE TU_ID = ' + quotedStr(TU_ID));
      add('ORDER BY');
      add('  SE_NUMMER,');
      add('  SE_PLATZ');
    end;
    aQuery.open();

    if aQuery.Active and (aQuery.RecordCount > 0) then
    begin
      aScheibenIndex := comboScheibe.ItemIndex;
      aPlatzIndex    := comboPlatz.ItemIndex;

      while aScheibenIndex < comboScheibe.Items.Count do
      begin
        while aPlatzIndex < comboPlatz.Items.Count do
        begin
          if aQuery.Locate('SE_NUMMER; SE_PLATZ',
            varArrayOf([comboScheibe.Items[aScheibenIndex], comboPlatz.Items[aPlatzIndex]]), [locaseInSensitive]) then
          begin
            inc(aPlatzIndex);
          end
          else
          begin
            comboScheibe.ItemIndex := aScheibenIndex;
            comboPlatz.ItemIndex   := aPlatzIndex;
            exit;
          end;
        end;
        inc(aScheibenIndex);
        aPlatzIndex := 0;
      end;
    end;
  finally
    aQuery.Free;
  end;
end;

procedure TARC_BL_Turnier.selectFreieScheibenInfo(query: TADOQuery; TU_ID: string);
begin
  query.Close;
  TARC_DAL_Turnier.selectFreieScheibenplaetze(query);

  query.Parameters.ParseSQL(query.SQL.Text, true);
  query.Parameters.ParamByName('TU_ID').value := TU_ID;
  query.open;
end;

procedure TARC_BL_Turnier.teilnehmerEinfuegen(TU_ID, PE_ID: string);
var
  aQuery: TADOQuery;
begin
  aQuery := TADOQuery.create(nil);
  try
    aQuery.connection := FConnection;

    with aQuery.SQL do
    begin
      clear;
      add('IF NOT EXISTS(');
      add('  SELECT PE_ID');
      add('  FROM TURNIER_ZUTEILUNG');
      add('  WHERE TU_ID =' + quotedStr(TU_ID));
      add('    AND PE_ID =' + quotedStr(PE_ID));
      add(')');
      add('BEGIN');
      add('  INSERT INTO TURNIER_ZUTEILUNG(');
      add('    TZ_ID,');
      add('    TU_ID,');
      add('    PE_ID');
      add('  )');
      add('  VALUES(');
      add('    newID(),');
      add('    ' + quotedStr(TU_ID) + ',');
      add('    ' + quotedStr(PE_ID));
      add('  )');
      add('END');
    end;
    aQuery.ExecSQL;
  finally
    aQuery.Free;
  end;
end;

procedure TARC_BL_Turnier.selectScores(query: TADOQuery; scheibe: integer; scheibenplatz: string; TU_ID: string);
begin
  query.Close;
  TARC_DAL_Turnier.selectScore(query, TU_ID, scheibe, scheibenplatz);
  query.open;
end;

procedure TARC_BL_Turnier.fillComboScoresScheiben(combo: TCombobox; TU_ID: string);
var
  aQuery         : TADOQuery;
  aScheibennummer: integer;
begin
  aQuery := TADOQuery.create(nil);
  try
    aQuery.connection := FConnection;
    with aQuery.SQL do
    begin
      clear;
      add('SELECT DISTINCT');
      add('  SE_NUMMER');
      add('FROM SCHEIBENEINTEILUNG');
      add('WHERE TU_ID = ' + quotedStr(TU_ID));
      add('ORDER BY SE_NUMMER');
    end;
    aQuery.open();
    if aQuery.Active and (aQuery.RecordCount > 0) then
    begin
      combo.Items.clear;
      while not aQuery.Eof do
      begin
        combo.Items.add(aQuery.FieldByName('SE_NUMMER').AsString);
        aQuery.Next;
      end;
      combo.ItemIndex := 0;
    end;
  finally
    aQuery.Free;
  end;
end;

procedure TARC_BL_Turnier.fillComboScoresScheibenPlatz(combo: TCombobox; TU_ID: string; scheibe: integer);
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
      add('  SE_PLATZ');
      add('FROM SCHEIBENEINTEILUNG');
      add('WHERE TU_ID = ' + quotedStr(TU_ID));
      add('  AND SE_NUMMER = ' + IntToStr(scheibe));
      add('ORDER BY SE_PLATZ');
    end;
    aQuery.open();
    if aQuery.Active and (aQuery.RecordCount > 0) then
    begin
      combo.Items.clear;
      while not aQuery.Eof do
      begin
        combo.Items.add(aQuery.FieldByName('SE_PLATZ').AsString);
        aQuery.Next;
      end;
      combo.ItemIndex := 0;
    end;
  finally
    aQuery.Free;
  end;
end;

procedure TARC_BL_Turnier.saveScore(TU_ID: string; PE_ID: string; SC_ID: string; runde: integer; score: integer;
  zehner: integer; neuner: integer; X: integer);
var
  aQuerySave: TADOQuery;
begin
  aQuerySave := TADOQuery.create(nil);
  try
    aQuerySave.connection := FConnection;
    with aQuerySave.SQL do
    begin
      if SC_ID <> '' then
      //existiert bereits -> update
      begin
        add('UPDATE SCORES');
        add('SET');
        add('  SC_SCORE = ' + IntToStr(score) + ',');
        add('  SC_ZEHNER = ' + IntToStr(zehner) + ',');
        add('  SC_NEUNER = ' + IntToStr(neuner) + ',');
        add('  SC_X = ' + IntToStr(X));
        add('WHERE SC_ID = ' + quotedStr(SC_ID));
      end
      else
      //existiert noch nicht -> insert
      begin
        add('INSERT INTO SCORES(');
        add('  SC_ID,');
        add('  TU_ID,');
        add('  PE_ID,');
        add('  SC_RUNDE,');
        add('  SC_SCORE,');
        add('  SC_ZEHNER,');
        add('  SC_NEUNER,');
        add('  SC_X');
        add(')');
        add('VALUES(');
        add('  newID(),');
        add('  ' + quotedStr(TU_ID) + ',');
        add('  ' + quotedStr(PE_ID) + ',');
        add('  ' + IntToStr(runde) + ',');
        add('  ' + IntToStr(score) + ',');
        add('  ' + IntToStr(zehner) + ',');
        add('  ' + IntToStr(neuner) + ',');
        add('  ' + IntToStr(X));
        add(')');
      end;
    end;
    aQuerySave.ExecSQL;
  finally
    aQuerySave.Free;
  end;
end;

end.
