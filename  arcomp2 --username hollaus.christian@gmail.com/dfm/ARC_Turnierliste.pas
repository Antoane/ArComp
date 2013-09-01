unit ARC_Turnierliste;

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
  ARC_TurnierDetail,
  ARC_Tools,
  ARC_Types,
  ARC_Functions,
  ARC_DbGrid;

type
  TFormTurnierListe = class(TForm)
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    querySelectTurnier: TADOQuery;
    DataSource1: TDataSource;
    buttonOK: TButton;
    buttonCancel: TButton;
    labelCaption: TLabel;
    gridTurniere: TDBGrid;
    Panel5: TPanel;
    editSearch: TEdit;
    Button2: TButton;
    buttonHinzufuegen: TButton;
    ButtonLoeschen: TButton;
    buttonAlle: TButton;
    ImageList: TImageList;
    procedure FormShow(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);
    procedure gridTurniereTitleClick(Column: TColumn);
    procedure Button2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure gridTurniereDblClick(Sender: TObject);
    procedure editSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ButtonLoeschenClick(Sender: TObject);
    procedure buttonHinzufuegenClick(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);
    procedure buttonAlleClick(Sender: TObject);

  private
    FTU_ID    : string;
    FDataState: TDataState;
    procedure CreateParams(var Params: TCreateParams);
    procedure searchData(searchString: string);
    procedure deleteTurnier;

    procedure openTurnierDetail(TU_ID: string);

    {Private-Deklarationen}
  public
    constructor Create(aOwner: TComponent);
    destructor Destroy; override;
    procedure setConnection(connection: Tadoconnection);
    procedure addTurnier;
    {Public-Deklarationen}

    property TU_ID: string
      read   FTU_ID
      write  FTU_ID;

    property DataState: TDataState
      read   FDataState
      write  FDataState;
  end;

var
  FormTurnierListe: TFormTurnierListe;
  isCtrlPressed   : boolean;

implementation

{$R *.dfm}

procedure TFormTurnierListe.Button2Click(Sender: TObject);
begin
  searchData(editSearch.Text);
end;

procedure TFormTurnierListe.searchData(searchString: string);
begin
  querySelectTurnier.Close;
  if querySelectTurnier.Active and (querySelectTurnier.RecordCount > 0) then
  begin
    querySelectTurnier.Active := false;
  end;
  querySelectTurnier.Parameters.Clear;
  querySelectTurnier.Parameters.ParseSQL(querySelectTurnier.SQL.Text, True);
  querySelectTurnier.Parameters.ParamByName('SEARCHSTRING').value := '%' + editSearch.Text + '%';
  querySelectTurnier.Open;
  TARC_Tools.autoSizeColumns(querySelectTurnier, gridTurniere);
end;

procedure TFormTurnierListe.buttonAlleClick(Sender: TObject);
begin
  searchData('');
end;

procedure TFormTurnierListe.buttonCancelClick(Sender: TObject);
begin
  self.ModalResult := mrCancel;
  self.CloseModal;
end;

procedure TFormTurnierListe.buttonHinzufuegenClick(Sender: TObject);
begin
  addTurnier();
end;

procedure TFormTurnierListe.addTurnier;
var
  aQuery: TADOQuery;
  aID   : string;
begin
  aQuery := TADOQuery.Create(nil);
  try
    aID               := newGUID();
    aQuery.connection := querySelectTurnier.connection;
    with aQuery.SQL do
    begin
      Clear;
      add('INSERT INTO TURNIER(');
      add('  TU_ID');
      add(')');
      add('VALUES(');
      add('  ' + QuotedStr(aID));
      add(')');
    end;
    aQuery.ExecSQL;
  finally
    aQuery.Free;
  end;
  openTurnierDetail(aID);
end;

procedure TFormTurnierListe.ButtonLoeschenClick(Sender: TObject);
begin
  deleteTurnier();
end;

procedure TFormTurnierListe.buttonOKClick(Sender: TObject);
begin
  if querySelectTurnier.Active and (querySelectTurnier.RecordCount > 0) then
  begin
    FTU_ID      := querySelectTurnier.FieldByName('TU_ID').AsString;
    ModalResult := mrOk;
  end
  else
  begin
    ModalResult := mrCancel;
  end;
  self.CloseModal;
end;

procedure TFormTurnierListe.deleteTurnier;
var
  aQuery: TADOQuery;
  aID   : string;
begin
  if querySelectTurnier.Active and (querySelectTurnier.RecordCount > 0) then
  begin
    if MessageDlg('Wollen Sie das ausgewählte Turnier wirklich löschen?', mtConfirmation, mbYesNo, 0) = mrYes then
    begin
      aQuery := TADOQuery.Create(nil);
      aID    := querySelectTurnier.FieldByName('TU_ID').AsString;
      try
        aQuery.connection := querySelectTurnier.connection;
        with aQuery.SQL do
        begin
          Clear;
          add('DELETE FROM TURNIER');
          add('WHERE TU_ID = ' + QuotedStr(aID));
        end;

        aQuery.ExecSQL;
      finally
        aQuery.Free;
      end;
      searchData(editSearch.Text);
    end;
  end;
end;

procedure TFormTurnierListe.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 17 then isCtrlPressed := True;

  if isCtrlPressed and (Key = 30) then
  begin
    Key := 0;
    editSearch.SetFocus;
  end;
end;

procedure TFormTurnierListe.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  isCtrlPressed := false;
end;

procedure TFormTurnierListe.FormShow(Sender: TObject);
begin
  buttonOK.Visible := DataState = dsSelectMode;
  searchData(editSearch.Text);
end;

procedure TFormTurnierListe.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  //Params.Style := WS_CHILD or WS_DLGFRAME or WS_VISIBLE or DS_CONTROL;
end;

procedure TFormTurnierListe.gridTurniereDblClick(Sender: TObject);
begin
  if querySelectTurnier.Active and (querySelectTurnier.RecordCount > 0) then
  begin
    if DataState = dsSelectMode then
    begin
      FTU_ID      := querySelectTurnier.FieldByName('TU_ID').AsString;
      ModalResult := mrOk;
      self.CloseModal;
    end
    else if DataState = dsEditMode then
    begin
      openTurnierDetail(querySelectTurnier.FieldByName('TU_ID').AsString);
    end;
  end;
end;

procedure TFormTurnierListe.openTurnierDetail(TU_ID: string);
var
  aDialog: TFormTurnierDetail;
begin
  aDialog := TFormTurnierDetail.Create(self, querySelectTurnier.connection, TU_ID);
  if (aDialog.ShowModal = mrOk) then
  begin
    searchData(editSearch.Text);
  end;
end;

procedure TFormTurnierListe.gridTurniereTitleClick(Column: TColumn);
{$J+}
const
  PreviousColumnIndex: integer = -1;
{$J-}
begin
  if gridTurniere.DataSource.DataSet is TCustomADODataSet then
    with TCustomADODataSet(gridTurniere.DataSource.DataSet) do
    begin
      try
        if PreviousColumnIndex >= 0 then
        begin
          gridTurniere.Columns[PreviousColumnIndex].title.Font.Style := gridTurniere.Columns[PreviousColumnIndex]
            .title.Font.Style - [fsBold];
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

destructor TFormTurnierListe.Destroy;
begin
  SetDesigning(false);
  inherited Destroy;
end;

procedure TFormTurnierListe.editSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    searchData(editSearch.Text);
  end;
end;

constructor TFormTurnierListe.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  //if csDesigning in ComponentState then ReadComponentRes(self.ClassName, self);
end;

procedure TFormTurnierListe.setConnection(connection: Tadoconnection);
begin
  querySelectTurnier.connection := connection;
end;

end.
