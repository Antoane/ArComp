unit ARC_ParameterRangliste;

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
  frxDesgn,
  frxClass,
  frxVariables,
  frxADOComponents,

  //ARComp
  ARC_PersonenDetail,
  ARC_DAL_ParameterRangliste,
  ARC_Functions,
  ARC_Tools,
  ARC_Types,
  ARC_DbGrid;

type
  TFormParameterRangliste = class(TForm)
    Panel2: TPanel;
    Panel4: TPanel;
    queryBogenkategorie: TADOQuery;
    sourceBogenkategorie: TDataSource;
    buttonCancel: TButton;
    labelCaption: TLabel;
    ImageList: TImageList;
    Panel1: TPanel;
    panelAlterskategorie: TPanel;
    gridAlterskategorie: TDBGrid;
    Panel6: TPanel;
    Label2: TLabel;
    panelGeschlecht: TPanel;
    gridGeschlecht: TDBGrid;
    Panel5: TPanel;
    Label1: TLabel;
    panelBogenkategorie: TPanel;
    gridBogenkategorie: TDBGrid;
    Panel8: TPanel;
    Label3: TLabel;
    sourceAlterskategorie: TDataSource;
    queryAlterskategorie: TADOQuery;
    sourceGeschlecht: TDataSource;
    queryGeschlecht: TADOQuery;
    buttonOK: TButton;
    procedure FormShow(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);
    procedure gridGeschlechtDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure gridAlterskategorieDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure gridBogenkategorieDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure buttonOKClick(Sender: TObject);
    procedure gridBogenkategorieCellClick(Column: TColumn);

  private
    FselectedIDs: TStringList;
    FDataState  : TDataState;
    FRangliste  : TADOQuery;
    procedure CreateParams(var Params: TCreateParams);
    procedure searchData(searchString: string);
    procedure deletePerson;
    procedure addPerson;
    procedure openPersonDetail(PE_ID: string);
    procedure setProps;
    procedure fillGridAlterskategorie;
    procedure fillGridBogenketegorie;
    procedure fillGridGeschlecht;
    function getBogenkategorien: string;

    {Private-Deklarationen}
  public
    constructor Create(aOwner: TComponent);
    destructor Destroy; override;
    procedure setConnection(connection: Tadoconnection);
    {Public-Deklarationen}

    property Rangliste: TADOQuery
      read   FRangliste
      write  FRangliste;

    property Bogenkategorien: string
      read   getBogenkategorien;
  end;

implementation

{$R *.dfm}

procedure TFormParameterRangliste.addPerson;
begin

end;

procedure TFormParameterRangliste.buttonCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  self.CloseModal;
end;

procedure TFormParameterRangliste.buttonOKClick(Sender: TObject);
begin
  TARC_DAL_ParameterRangliste.selectRangliste(FRangliste);
  FRangliste.Open;
  self.ModalResult := mrOk;
  self.CloseModal;
end;

procedure TFormParameterRangliste.FormShow(Sender: TObject);
begin
  fillGridAlterskategorie();
  fillGridBogenketegorie();
  fillGridGeschlecht();
end;

procedure TFormParameterRangliste.fillGridAlterskategorie();
begin
  TARC_DAL_ParameterRangliste.selectAlterskategorien(queryAlterskategorie);
  queryAlterskategorie.Open;
end;

procedure TFormParameterRangliste.fillGridBogenketegorie();
begin
  TARC_DAL_ParameterRangliste.selectBogenkategorien(queryBogenkategorie);
  queryBogenkategorie.Open;
end;

procedure TFormParameterRangliste.fillGridGeschlecht();
begin
  TARC_DAL_ParameterRangliste.selectGeschlecht(queryGeschlecht);
  queryGeschlecht.Open;
end;

function TFormParameterRangliste.getBogenkategorien: string;
begin
  result := '';
  queryBogenkategorie.First;
  while not queryBogenkategorie.Eof do
  begin
    if queryBogenkategorie.FieldByName('SELECTED').AsInteger = 1 then
    begin
      result := queryBogenkategorie.FieldByName('BK_NAME').AsString;
      exit;
    end;
    queryBogenkategorie.Next;
  end;
end;

procedure TFormParameterRangliste.gridAlterskategorieDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  TARC_Tools.DrawColumnCell(Sender, Rect, DataCol, Column, State, gridAlterskategorie);
end;

procedure TFormParameterRangliste.gridBogenkategorieCellClick(Column: TColumn);
var
  aRecordNumber: Integer;
begin
  if Column.FieldName = 'SELECTED' then
  begin
    if queryBogenkategorie.FieldByName('SELECTED').AsInteger = 1 then
    begin
      aRecordNumber := queryBogenkategorie.RecNo;
      queryBogenkategorie.DisableControls;
      queryBogenkategorie.First;
      while not queryBogenkategorie.Eof do
      begin
        queryBogenkategorie.Edit;
        queryBogenkategorie.FieldByName('SELECTED').AsInteger := 0;
        queryBogenkategorie.Next;
      end;
      queryBogenkategorie.RecNo := aRecordNumber;
      queryBogenkategorie.Edit;
      queryBogenkategorie.FieldByName('SELECTED').AsInteger := 1;
      queryBogenkategorie.EnableControls;
    end;
  end;
end;

procedure TFormParameterRangliste.gridBogenkategorieDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
begin
  TARC_Tools.DrawColumnCell(Sender, Rect, DataCol, Column, State, gridBogenkategorie);
end;

procedure TFormParameterRangliste.gridGeschlechtDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
begin
  TARC_Tools.DrawColumnCell(Sender, Rect, DataCol, Column, State, gridGeschlecht);
end;

procedure TFormParameterRangliste.openPersonDetail(PE_ID: string);
begin

end;

constructor TFormParameterRangliste.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
end;

procedure TFormParameterRangliste.CreateParams(var Params: TCreateParams);
begin

end;

procedure TFormParameterRangliste.deletePerson;
begin

end;

destructor TFormParameterRangliste.Destroy;
begin

  inherited;
end;

procedure TFormParameterRangliste.searchData(searchString: string);
begin

end;

procedure TFormParameterRangliste.setConnection(connection: Tadoconnection);
begin
  queryBogenkategorie.connection  := connection;
  queryAlterskategorie.connection := connection;
  queryGeschlecht.connection      := connection;
end;

procedure TFormParameterRangliste.setProps;
begin

end;

end.
