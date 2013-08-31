unit ARC_VereinListe;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.ExtCtrls,
  Data.DB,
  Data.Win.ADODB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.DBCtrls,
  Vcl.StdCtrls,
  Bde.DBTables,
  dialogs,
  Vcl.ImgList,

  //ARComp
  ARC_PersonenDetail,
  ARC_DbGrid;

type
  TFormVereinsListe = class(TForm)
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    querySelectVereine: TADOQuery;
    DataSource1: TDataSource;
    buttonOK: TButton;
    buttonCancel: TButton;
    ImageList1: TImageList;
    labelCaption: TLabel;
    DBGrid1: ARC_DbGrid.TDBGrid;
    Panel5: TPanel;
    editSearch: TEdit;
    buttonSuchen: TButton;
    ButtonLoeschen: TButton;
    buttonHinzufuegen: TButton;
    buttonAlle: TButton;
    procedure FormShow(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure buttonSuchenClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure buttonHinzufuegenClick(Sender: TObject);
    procedure ButtonLoeschenClick(Sender: TObject);
    procedure editSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure buttonAlleClick(Sender: TObject);

  private
    procedure CreateParams(var Params: TCreateParams);
    procedure searchData(searchString: string);
    procedure addVerein;
    procedure deleteVerein;

    {Private-Deklarationen}
  public
    constructor Create(aOwner: TComponent);
    destructor Destroy; override;
    procedure setConnection(connection: Tadoconnection);
    {Public-Deklarationen}
  end;

var
  FormVereinsListe: TFormVereinsListe;
  isCtrlPressed   : boolean;

implementation

{$R *.dfm}

procedure TFormVereinsListe.buttonSuchenClick(Sender: TObject);
begin
  searchData(editSearch.Text);
end;

procedure TFormVereinsListe.searchData(searchString: string);
begin
  querySelectVereine.Close;
  if querySelectVereine.Active and (querySelectVereine.RecordCount > 0) then
  begin
    querySelectVereine.Active := false;
  end;
  querySelectVereine.Parameters.Clear;
  querySelectVereine.Parameters.ParseSQL(querySelectVereine.SQL.Text, True);
  querySelectVereine.Parameters.ParamByName('SEARCHSTRING').value := '%' + editSearch.Text + '%';
  querySelectVereine.Active                                       := True;
  querySelectVereine.Open;
end;

procedure TFormVereinsListe.buttonAlleClick(Sender: TObject);
begin
  searchData('');
end;

procedure TFormVereinsListe.buttonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormVereinsListe.buttonHinzufuegenClick(Sender: TObject);
begin
  addVerein();
end;

procedure TFormVereinsListe.ButtonLoeschenClick(Sender: TObject);
begin
  deleteVerein();
end;

procedure TFormVereinsListe.deleteVerein;
var
  aQuery: TADOQuery;
  aID   : string;
begin
  if querySelectVereine.Active and (querySelectVereine.RecordCount > 0) then
  begin
    if MessageDlg('Wollen Sie den ausgewählten Verein wirklich löschen?', mtConfirmation, mbYesNo, 0) = mrYes then
    begin
      aQuery := TADOQuery.Create(nil);
      aID    := querySelectVereine.FieldByName('VE_ID').AsString;
      try
        aQuery.connection := querySelectVereine.connection;
        with aQuery.SQL do
        begin
          Clear;
          add('UPDATE PERSON');
          add('SET VE_ID = NULL');
          add('WHERE VE_ID = ' + QuotedStr(aID));
          add('');
          add('DELETE FROM VEREIN');
          add('WHERE VE_ID = ' + QuotedStr(aID));
        end;

        aQuery.ExecSQL;
      finally
        aQuery.Free;
      end;
      searchData(editSearch.Text);
    end;
  end;
end;

procedure TFormVereinsListe.addVerein;
var
  aName : string;
  aQuery: TADOQuery;
begin
  aName := InputBox('Neuer Verein', 'Bitte geben Sie einen Vereinsnamen ein', '');

  if trim(aName) <> '' then
  begin
    aQuery := TADOQuery.Create(nil);
    try
      aQuery.connection := querySelectVereine.connection;
      with aQuery.SQL do
      begin
        Clear;
        add('INSERT INTO VEREIN(');
        add('  VE_ID,');
        add('  VE_NAME');
        add(')');
        add('VALUES(');
        add('  newID(),');
        add('  :NAME');
        add(')');
      end;
      aQuery.Parameters.ParseSQL(aQuery.SQL.Text, True);
      aQuery.Parameters.ParamByName('NAME').value := aName;
      aQuery.ExecSQL;
    finally
      aQuery.Free;
    end;
    searchData(editSearch.Text);
  end;
end;

procedure TFormVereinsListe.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 17 then isCtrlPressed := True;

  if isCtrlPressed and (Key = 30) then
  begin
    Key := 0;
    editSearch.SetFocus;
  end;
end;

procedure TFormVereinsListe.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  isCtrlPressed := false;
end;

procedure TFormVereinsListe.FormShow(Sender: TObject);
begin
  searchData(editSearch.Text);
end;

procedure TFormVereinsListe.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  //Params.Style := WS_CHILD or WS_DLGFRAME or WS_VISIBLE or DS_CONTROL;
end;

procedure TFormVereinsListe.DBGrid1DblClick(Sender: TObject);
var
  aDialog: TFormPersonenDetail;
begin
  if querySelectVereine.Active and (querySelectVereine.RecordCount > 0) then
  begin
    aDialog := TFormPersonenDetail.Create(self, querySelectVereine.connection, querySelectVereine.FieldByName('PE_ID')
      .AsString);
    if (aDialog.ShowModal = mrOk) then
    begin
      searchData(editSearch.Text);
    end;
  end;
end;

procedure TFormVereinsListe.DBGrid1TitleClick(Column: TColumn);
{$J+}
const
  PreviousColumnIndex: integer = -1;
{$J-}
begin
  if DBGrid1.DataSource.DataSet is TCustomADODataSet then
    with TCustomADODataSet(DBGrid1.DataSource.DataSet) do
    begin
      try
        if PreviousColumnIndex >= 0 then
        begin
          DBGrid1.Columns[PreviousColumnIndex].title.Font.Style := DBGrid1.Columns[PreviousColumnIndex].title.Font.Style
            - [fsBold];
        end;
      except
      end;

      Column.title.Font.Style := Column.title.Font.Style + [fsBold];
      PreviousColumnIndex     := Column.Index;

      if (Pos(System.Widestring(Column.Field.FieldName), Sort) = 1) and (Pos(System.Widestring(' DESC'), Sort) = 0) then
          Sort  := Column.Field.FieldName + ' DESC'
      else Sort := Column.Field.FieldName + ' ASC';
    end;
end;

destructor TFormVereinsListe.Destroy;
begin
  SetDesigning(false);
  inherited Destroy;
end;

procedure TFormVereinsListe.editSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    searchData(editSearch.Text);
  end;
end;

constructor TFormVereinsListe.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  //if csDesigning in ComponentState then ReadComponentRes(self.ClassName, self);
end;

procedure TFormVereinsListe.setConnection(connection: Tadoconnection);
begin
  querySelectVereine.connection := connection;
end;

end.
