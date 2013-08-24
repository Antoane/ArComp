unit ARC_BL_Turnier;

interface

uses
  Data.Win.ADODB,
  System.Classes,
  System.SysUtils,
  vcl.dialogs,
  vcl.controls,
  vcl.StdCtrls;

type
  TARC_BL_Turnier = class(TObject)

  private
    FConnection: TADOConnection;

  public
    constructor create(owner: TComponent; connection: TADOConnection);
    destructor destroy();

    procedure fillComboScheibenanzahl(combo: TCombobox; TU_ID: string);
    procedure fillComboScheibenPlatz(combo: TCombobox; TU_ID: string);
    function zuteilen(TU_ID, PE_ID: string; scheibe: integer; platz: string): boolean;
    procedure selectFreieScheibe(comboScheibe, comboPlatz: TCombobox);
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

function TARC_BL_Turnier.zuteilen(TU_ID: string; PE_ID: string; scheibe: integer; platz: string): boolean;
var
  aQueryCheck : TADOQuery;
  aQueryInsert: TADOQuery;
begin
  aQueryCheck  := TADOQuery.create(nil);
  aQueryInsert := TADOQuery.create(nil);
  try
    aQueryCheck.connection  := FConnection;
    aQueryInsert.connection := FConnection;
    with aQueryCheck.SQL do
    begin
      clear;
      add('SELECT');
      add('  PE_ID');
      add('FROM SCHEIBENEINTEILUNG');
      add('WHERE TU_ID = ' + quotedStr(TU_ID));
      add('  AND SE_NUMMER = ' + IntToStr(scheibe));
      add('  AND SE_PLATZ = ' + quotedStr(platz));
    end;
    aQueryCheck.open;
    if aQueryCheck.Active and (aQueryCheck.RecordCount > 0) then
    begin
      if MessageDlg('Die gew�hlte Scheibe ist bereits einer Person zugeteilt. Soll die Zuordnung ge�ndert werden?',
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
      add('  AND SE_NUMMER = ' + IntToStr(scheibe));
      add('  AND SE_PLATZ = ' + quotedStr(platz));
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
      add('  ' + IntToStr(scheibe) + ',');
      add('  ' + quotedStr(platz));
      add(')  ');
    end;
    aQueryInsert.ExecSQL;
    result := true;
  finally
    aQueryCheck.Free;
    aQueryInsert.Free;
  end;
end;

procedure TARC_BL_Turnier.selectFreieScheibe(comboScheibe: TCombobox; comboPlatz: TCombobox);
begin
  //
end;

end.