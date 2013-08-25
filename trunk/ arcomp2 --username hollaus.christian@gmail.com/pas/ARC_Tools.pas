unit ARC_Tools;

interface

uses
  vcl.dbctrls,
  vcl.stdctrls,
  vcl.dbGrids,
  Graphics,
  Data.Win.ADODB;

type
  TARC_Tools = class(TObject)

  private

  public
    class procedure fillDBComboFromTable(combo: TDBComboBox; table, key, value: string;
      connection: TADOConnection); static;
    class procedure fillComboFromTable(combo: TComboBox; table, key, value: string; connection: TADOConnection); static;
    class procedure gridSort(grid: TDbGrid; Column: TColumn); static;

  published

  end;

implementation

class procedure TARC_Tools.fillDBComboFromTable(combo: TDBComboBox; table: string; key: string; value: string;
  connection: TADOConnection);
var
  aQuery: TADOQuery;
begin
  aQuery := TADOQuery.Create(nil);
  try
    aQuery.connection := connection;
    with aQuery.SQL do
    begin
      add('SELECT DISTINCT');
      add('  ' + key + ',');
      add('  ' + value);
      add('FROM ' + table);
      add('ORDER BY ' + value);
    end;
    aQuery.Active := true;
    aQuery.ExecSQL;

    if aQuery.RecordCount > 0 then
    begin
      combo.Clear;
      combo.Items.add('');
      aQuery.First;
      while not aQuery.Eof do
      begin
        combo.Items.add(aQuery.FieldByName(value).AsString);
        aQuery.Next;
      end;
    end;
  finally
    aQuery.Free;
  end;
end;

class procedure TARC_Tools.fillComboFromTable(combo: TComboBox; table: string; key: string; value: string;
  connection: TADOConnection);
var
  aQuery: TADOQuery;
begin
  aQuery := TADOQuery.Create(nil);
  try
    aQuery.connection := connection;
    with aQuery.SQL do
    begin
      add('SELECT DISTINCT');
      add('  ' + key + ',');
      add('  ' + value);
      add('FROM ' + table);
      add('ORDER BY ' + value);
    end;
    aQuery.Active := true;
    aQuery.ExecSQL;

    if aQuery.RecordCount > 0 then
    begin
      combo.Clear;
      combo.Items.add('');
      aQuery.First;
      while not aQuery.Eof do
      begin
        combo.Items.add(aQuery.FieldByName(value).AsString);
        aQuery.Next;
      end;
    end;
  finally
    aQuery.Free;
  end;
end;

class procedure TARC_Tools.gridSort(grid: TDbGrid; Column: TColumn);
{$J+}
const
  PreviousColumnIndex: integer = -1;
{$J-}
begin
  if grid.DataSource.DataSet is TCustomADODataSet then
    with TCustomADODataSet(grid.DataSource.DataSet) do
    begin
      try
        if PreviousColumnIndex >= 0 then
        begin
          grid.Columns[PreviousColumnIndex].title.Font.Style := grid.Columns[PreviousColumnIndex].title.Font.Style
            - [fsBold];
        end;
      except
      end;

      Column.title.Font.Style := Column.title.Font.Style + [fsBold];
      PreviousColumnIndex     := Column.Index;

      if (Pos(system.Widestring(Column.Field.FieldName), Sort) = 1) and (Pos(system.Widestring(' DESC'), Sort) = 0) then
          Sort  := Column.Field.FieldName + ' DESC'
      else Sort := Column.Field.FieldName + ' ASC';
    end;
end;

end.
