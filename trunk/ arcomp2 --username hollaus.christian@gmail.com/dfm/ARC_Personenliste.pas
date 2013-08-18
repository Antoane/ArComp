unit ARC_Personenliste;

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
  Vcl.ImgList,
  dialogs,

  //ARComp
  ARC_PersonenDetail,
  ARC_Functions,
  ARC_DbGrid;

type
  TFormPersonenListe = class(TForm)
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    querySelectPersonen: TADOQuery;
    DataSource1: TDataSource;
    buttonOK: TButton;
    buttonCancel: TButton;
    ImageList1: TImageList;
    labelCaption: TLabel;
    DBGrid1: ARC_DbGrid.TDBGrid;
    Panel5: TPanel;
    editSearch: TEdit;
    Button2: TButton;
    buttonHinzufuegen: TButton;
    ButtonLoeschen: TButton;
    procedure FormShow(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure Button2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure editSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ButtonLoeschenClick(Sender: TObject);
    procedure buttonHinzufuegenClick(Sender: TObject);

  private
    procedure CreateParams(var Params: TCreateParams);
    procedure searchData(searchString: string);
    procedure deletePerson;
    procedure addPerson;
    procedure openPersonDetail(PE_ID: string);

    {Private-Deklarationen}
  public
    constructor Create(aOwner: TComponent);
    destructor Destroy; override;
    procedure setConnection(connection: Tadoconnection);
    {Public-Deklarationen}
  end;

var
  FormPersonenListe: TFormPersonenListe;
  isCtrlPressed    : boolean;

implementation

{$R *.dfm}

procedure TFormPersonenListe.Button2Click(Sender: TObject);
begin
  searchData(editSearch.Text);
end;

procedure TFormPersonenListe.searchData(searchString: string);
begin
  querySelectPersonen.Close;
  if querySelectPersonen.Active and (querySelectPersonen.RecordCount > 0) then
  begin
    querySelectPersonen.Active := false;
  end;
  querySelectPersonen.Parameters.Clear;
  querySelectPersonen.Parameters.ParseSQL(querySelectPersonen.SQL.Text, True);
  querySelectPersonen.Parameters.ParamByName('SEARCHSTRING').value := '%' + editSearch.Text + '%';
  querySelectPersonen.Active                                       := True;
  querySelectPersonen.Open;
end;

procedure TFormPersonenListe.buttonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormPersonenListe.buttonHinzufuegenClick(Sender: TObject);
begin
  addPerson();
end;

procedure TFormPersonenListe.addPerson;
var
  aQuery: TADOQuery;
  aID   : string;
begin
  aQuery := TADOQuery.Create(nil);
  try
    aID               := newGUID();
    aQuery.connection := querySelectPersonen.connection;
    with aQuery.SQL do
    begin
      Clear;
      add('INSERT INTO PERSON(');
      add('  PE_ID');
      add(')');
      add('VALUES(');
      add('  ' + QuotedStr(aID));
      add(')');
    end;
    aQuery.ExecSQL;
  finally
    aQuery.Free;
  end;
  openPersonDetail(aID);
end;

procedure TFormPersonenListe.ButtonLoeschenClick(Sender: TObject);
begin
  deletePerson();
end;

procedure TFormPersonenListe.deletePerson;
var
  aQuery: TADOQuery;
  aID   : string;
begin
  if querySelectPersonen.Active and (querySelectPersonen.RecordCount > 0) then
  begin
    if MessageDlg('Wollen Sie den ausgewählten Verein wirklich löschen?', mtConfirmation, mbYesNo, 0) = mrYes then
    begin
      aQuery := TADOQuery.Create(nil);
      aID    := querySelectPersonen.FieldByName('PE_ID').AsString;
      try
        aQuery.connection := querySelectPersonen.connection;
        with aQuery.SQL do
        begin
          Clear;
          add('DELETE FROM PERSON');
          add('WHERE PE_ID = ' + QuotedStr(aID));
        end;

        aQuery.ExecSQL;
      finally
        aQuery.Free;
      end;
      searchData(editSearch.Text);
    end;
  end;
end;

procedure TFormPersonenListe.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 17 then isCtrlPressed := True;

  if isCtrlPressed and (Key = 30) then
  begin
    Key := 0;
    editSearch.SetFocus;
  end;
end;

procedure TFormPersonenListe.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  isCtrlPressed := false;
end;

procedure TFormPersonenListe.FormShow(Sender: TObject);
begin
  searchData(editSearch.Text);
end;

procedure TFormPersonenListe.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  //Params.Style := WS_CHILD or WS_DLGFRAME or WS_VISIBLE or DS_CONTROL;
end;

procedure TFormPersonenListe.DBGrid1DblClick(Sender: TObject);
begin
  if querySelectPersonen.Active and (querySelectPersonen.RecordCount > 0) then
  begin
    openPersonDetail(querySelectPersonen.FieldByName('PE_ID').AsString);
  end;
end;

procedure TFormPersonenListe.openPersonDetail(PE_ID: string);
var
  aDialog: TFormPersonenDetail;
begin
  aDialog := TFormPersonenDetail.Create(self, querySelectPersonen.connection, PE_ID);
  if (aDialog.ShowModal = mrOk) then
  begin
    searchData(editSearch.Text);
  end;
end;

procedure TFormPersonenListe.DBGrid1TitleClick(Column: TColumn);
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

destructor TFormPersonenListe.Destroy;
begin
  SetDesigning(false);
  inherited Destroy;
end;

procedure TFormPersonenListe.editSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    searchData(editSearch.Text);
  end;
end;

constructor TFormPersonenListe.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  //if csDesigning in ComponentState then ReadComponentRes(self.ClassName, self);
end;

procedure TFormPersonenListe.setConnection(connection: Tadoconnection);
begin
  querySelectPersonen.connection := connection;
end;

end.
