unit ARC_Finalberechtigungen;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  Data.Win.ADODB,
  Vcl.StdCtrls,
  Vcl.Mask,
  Vcl.DBCtrls,
  Vcl.ExtCtrls,

  //ArComp
  ARC_Tools,
  ARC_Functions,
  ARC_DAL_DbUpdate,
  ARC_DAL_Finalberechtigungen,
  Vcl.ImgList,
  Vcl.Grids,
  Vcl.DBGrids;

type
  TFormFinalberechtigung = class(TForm)
    querySelect: TADOQuery;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    dataSource: TDataSource;
    buttonCancel: TButton;
    queryUpdate: TADOQuery;
    DBGrid1: TDBGrid;
    ImageList: TImageList;
    procedure FormShow(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);

  private
    {Private-Deklarationen}
    procedure loadData;
    procedure selectFinalberechtigungen;

  public
    constructor create(owner: TComponent; connection: TADOConnection);
    {Public-Deklarationen}
  end;

var
  FormFinalberechtigung: TFormFinalberechtigung;

implementation

{$R *.dfm}

procedure TFormFinalberechtigung.buttonCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  self.CloseModal;
end;

constructor TFormFinalberechtigung.create(owner: TComponent; connection: TADOConnection);
begin
  inherited create(owner);
  querySelect.connection := connection;
  queryUpdate.connection := connection;
end;

procedure TFormFinalberechtigung.DBGrid1CellClick(Column: TColumn);
var
  aDistanzText: string;
  aDistanz    : integer;
begin
  if Column.FieldName = 'FB_FINALBERECHTIGT' then
  begin
    queryUpdate.Close;
    if querySelect.FieldByName('FB_FINALBERECHTIGT').AsInteger = 1 then
    begin
      TARC_DAL_Finalberechtigungen.UpdateBerechtigung(queryUpdate, querySelect.FieldByName('FB_ID').AsString, 0);
    end
    else
    begin
      TARC_DAL_Finalberechtigungen.UpdateBerechtigung(queryUpdate, querySelect.FieldByName('FB_ID').AsString, 1);
    end;
    queryUpdate.ExecSQL;
    selectFinalberechtigungen();
  end;
end;

procedure TFormFinalberechtigung.FormShow(Sender: TObject);
begin
  loadData();
end;

procedure TFormFinalberechtigung.loadData();
begin
  selectFinalberechtigungen();
end;

procedure TFormFinalberechtigung.selectFinalberechtigungen;
begin
  querySelect.Close;
  TARC_DAL_Finalberechtigungen.selectBerechtigung(querySelect);
  querySelect.Open;
  if querySelect.Active and (querySelect.RecordCount > 0) then
  begin
    querySelect.First;
  end;
end;

end.
