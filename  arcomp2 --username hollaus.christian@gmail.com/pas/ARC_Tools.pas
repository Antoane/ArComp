unit ARC_Tools;

interface

uses
  vcl.dbctrls,
  vcl.stdctrls,
  vcl.dbGrids,
  vcl.grids,
  Graphics,
  classes,
  Generics.Collections,
  Data.Win.ADODB,
  system.types,
  winapi.windows,
  Data.db,

  //ArComp
  ARC_Functions;

type
  TARC_Tools = class(TObject)

  private

  public
    class procedure fillDBComboFromTable(combo: TDBComboBox; table, key, value: string;
      connection: TADOConnection); static;
    class procedure fillDBComboFromQuery(combo: TDBComboBox; query: TADOQuery; key, value: string); static;
    class procedure fillComboFromQuery(combo: TComboBox; query: TADOQuery; key, value: string); static;
    class procedure fillComboFromTable(combo: TComboBox; table, key, value: string; connection: TADOConnection); static;
    class procedure gridSort(grid: TDbGrid; Column: TColumn); static;
    class procedure fixDBGridColumnsWidth(const DBGrid: TDbGrid); static;
    class procedure autoSizeColumns(query: TADOQuery; grid: TDbGrid); static;
    class procedure DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState; grid: TDbGrid); static;
    class function getKeyToValue(query: TADOQuery; keyCol, valCol, value: string): string;

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

class procedure TARC_Tools.fillDBComboFromQuery(combo: TDBComboBox; query: TADOQuery; key: string; value: string);
begin
  if query.RecordCount > 0 then
  begin
    combo.Clear;
    combo.Items.add('');
    query.First;
    while not query.Eof do
    begin
      combo.Items.add(query.FieldByName(value).AsString);
      query.Next;
    end;
  end;
end;

class procedure TARC_Tools.fillComboFromQuery(combo: TComboBox; query: TADOQuery; key: string; value: string);
begin
  combo.Clear;
  if query.RecordCount > 0 then
  begin
    combo.Items.add('');
    query.First;
    while not query.Eof do
    begin
      combo.Items.add(query.FieldByName(value).AsString);
      query.Next;
    end;
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

class function TARC_Tools.getKeyToValue(query: TADOQuery; keyCol, valCol, value: string): string;
begin
  if query.Locate(valCol, value, []) then
  begin
    result := query.FieldByName(keyCol).AsString;
  end
  else
  begin
    result := '';
  end;
end;

class procedure TARC_Tools.gridSort(grid: TDbGrid; Column: TColumn);
{$J+}
const
  PreviousColumnIndex: Integer = -1;
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

class procedure TARC_Tools.fixDBGridColumnsWidth(const DBGrid: TDbGrid);
var
  i                   : Integer;
  TotWidth            : Integer;
  VarWidth            : Integer;
  ResizableColumnCount: Integer;
  AColumn             : TColumn;
begin
  //total width of all columns before resize
  TotWidth := 0;
  //how to divide any extra space in the grid
  VarWidth := 0;
  //how many columns need to be auto-resized
  ResizableColumnCount := 0;

  for i := 0 to (DBGrid.Columns.Count - 1) do
  begin
    TotWidth := TotWidth + DBGrid.Columns[i].Width;
    if DBGrid.Columns[i].Field.Tag <> 0 then Inc(ResizableColumnCount);
  end;

  //add 1px for the column separator line
  if dgColLines in DBGrid.Options then TotWidth := TotWidth + DBGrid.Columns.Count;

  //add indicator column width
  if dgIndicator in DBGrid.Options then TotWidth := TotWidth + IndicatorWidth;

  //width vale "left"
  VarWidth := DBGrid.ClientWidth - TotWidth;

  //Equally distribute VarWidth
  //to all auto-resizable columns
  if ResizableColumnCount > 0 then VarWidth := VarWidth div ResizableColumnCount;

  for i := 0 to -1 + DBGrid.Columns.Count do
  begin
    AColumn := DBGrid.Columns[i];
    if AColumn.Field.Tag <> 0 then
    begin
      AColumn.Width                                           := AColumn.Width + VarWidth;
      if AColumn.Width < AColumn.Field.Tag then AColumn.Width := AColumn.Field.Tag;
    end;
  end;
end;

class procedure TARC_Tools.autoSizeColumns(query: TADOQuery; grid: TDbGrid);
var
  maxData         : Integer;
  minwidth        : Integer; //min. Breite
  breitenKorrektur: Integer; //Korr. der Spaltenbreite wg. besserer Optik
  currentWidth    : Integer;
  currentRecord   : Integer;
  spaltenAnzahl   : Integer;
  i               : Integer;
  spaltenbreiten  : TDictionary<Integer, Integer>;
begin
  if not query.Active then
  begin
    exit
  end
  else
  begin
    currentRecord := query.RecNo;

    maxData          := 300;
    minwidth         := 20;
    breitenKorrektur := 10;

    spaltenbreiten := TDictionary<Integer, Integer>.Create();
    try
      query.DisableControls;
      spaltenAnzahl := grid.Columns.Count;

      //minimals Spaltenbreite eintragen
      for i := 0 to spaltenAnzahl - 1 do
      begin
        spaltenbreiten.AddOrSetValue(i, minwidth);
      end;

      //Spaltenbreite bzgl. Überschriften anpassen
      for i := 0 to spaltenAnzahl - 1 do
      begin
        currentWidth := grid.Canvas.TextWidth(grid.Columns.Items[i].title.Caption);
        if currentWidth > spaltenbreiten.Items[i] then
        begin
          spaltenbreiten.AddOrSetValue(i, currentWidth);
        end;
      end;

      //durch alle Zeilen iterieren
      query.First;
      while not query.Eof do
      begin
        //durch alle Spalten iterieren
        for i := 0 to spaltenAnzahl - 1 do
        begin
          currentWidth := grid.Canvas.TextWidth(grid.Columns.grid.Fields[i].Text);
          if currentWidth > spaltenbreiten.Items[i] then
          begin
            spaltenbreiten.AddOrSetValue(i, currentWidth);
          end;
        end;
        query.Next;
      end;

      //Spaltenbreiten setzen
      for i := 0 to spaltenAnzahl - 1 do
      begin
        try
          grid.Columns[i].Width := spaltenbreiten.Items[i] + breitenKorrektur;
        except
          grid.Columns[i].Width := grid.Columns[i].Width;
        end;
      end;

    finally
      query.RecNo := currentRecord;
      query.EnableControls;
      spaltenbreiten.Free;
    end;
  end;
end;

class procedure TARC_Tools.DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState; grid: TDbGrid);
const
  CtrlState: array [boolean] of Integer = (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED);
begin
  //Scheibennummer nicht als Checkbox darstellen!
  if Column.FieldName = 'SE_NUMMER' then
  begin
    exit;
  end;

  //make sure we are adding this for int fields only
  if Column.Field.DataType = ftInteger then
  begin
    //Make sure selected cells are highlighted
    if (gdSelected in State) then
    begin
      grid.Canvas.Brush.Color := RGB2TColor(222, 239, 255);

      grid.Canvas.Pen.Color := RGB2TColor(127, 181, 236);
      grid.Canvas.Polyline([point(Rect.left, Rect.Top - 1), point(Rect.Right, Rect.Top - 1)]);
      grid.Canvas.Polyline([point(Rect.left, Rect.Bottom + 1), point(Rect.Right, Rect.Bottom + 1)]);
    end
    else
    begin
      grid.Canvas.Brush.Color := grid.Color;
    end;

    grid.Canvas.FillRect(Rect);
    DrawFrameControl(grid.Canvas.Handle, Rect, DFC_BUTTON, CtrlState[intToBool(Column.Field.AsInteger)]);
  end;
end;

end.
