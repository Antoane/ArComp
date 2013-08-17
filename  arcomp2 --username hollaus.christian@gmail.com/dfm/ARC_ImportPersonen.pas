unit ARC_ImportPersonen;

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
  Vcl.ExtCtrls,
  Data.DB,
  Data.Win.ADODB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.DBCtrls,
  Vcl.StdCtrls,
  Bde.DBTables,
  Vcl.ImgList,
  Vcl.ComCtrls,

  //ArComp

  ARC_ImportCsvPersonen;

type
  TFormImportPersonen = class(TForm)
    progressBar: TProgressBar;
    buttonImport: TButton;
    procedure buttonImportClick(Sender: TObject);

  private
    FConnection: TADOConnection;

    {Private-Deklarationen}
  protected
    procedure CreateParams(var Params: TCreateParams); override;

  public
    procedure setProgressbar(progressBar: TProgressBar);
    destructor Destroy; override;
    constructor Create(aOwner: TComponent);
    procedure setConnection(connection: TADOConnection);
  end;

var
  FormImportPersonen: TFormImportPersonen;

implementation

{$R *.dfm}

procedure TFormImportPersonen.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  //Params.Style := WS_CHILD or WS_DLGFRAME or WS_VISIBLE or DS_CONTROL;
end;

procedure TFormImportPersonen.setProgressbar(progressBar: TProgressBar);
begin
  self.progressBar := progressBar;
end;

destructor TFormImportPersonen.Destroy;
begin
  //SetDesigning(false);
  inherited Destroy;
end;

procedure TFormImportPersonen.buttonImportClick(Sender: TObject);
begin
  TARC_ImportCsvPersonen.import(FConnection, progressBar);
  self.Close;
end;

constructor TFormImportPersonen.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  //if csDesigning in ComponentState then ReadComponentRes(self.ClassName, self);
end;

procedure TFormImportPersonen.setConnection(connection: TADOConnection);
begin
  FConnection := connection;
end;

end.
