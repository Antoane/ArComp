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

  //ARComp
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
    ADODataSet1: TADODataSet;
    procedure FormShow(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);

  private
    procedure CreateParams(var Params: TCreateParams);

    {Private-Deklarationen}
  public
    constructor Create(aOwner: TComponent);
    destructor Destroy; override;
    procedure setConnection(connection: Tadoconnection);
    {Public-Deklarationen}
  end;

var
  FormPersonenListe: TFormPersonenListe;

implementation

{$R *.dfm}

procedure TFormPersonenListe.buttonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormPersonenListe.FormShow(Sender: TObject);
begin
  querySelectPersonen.Active;
  querySelectPersonen.Open;
end;

procedure TFormPersonenListe.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := WS_CHILD or WS_DLGFRAME or WS_VISIBLE or DS_CONTROL;
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
        DBGrid1.Columns[PreviousColumnIndex].title.Font.Style := DBGrid1.Columns[PreviousColumnIndex].title.Font.Style
          - [fsBold];
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

constructor TFormPersonenListe.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  if csDesigning in ComponentState then ReadComponentRes(self.ClassName, self);
end;

procedure TFormPersonenListe.setConnection(connection: Tadoconnection);
begin
  querySelectPersonen.connection := connection;
end;

end.
