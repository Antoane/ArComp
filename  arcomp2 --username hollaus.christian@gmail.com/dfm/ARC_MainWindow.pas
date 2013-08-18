unit ARC_MainWindow;

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
  Vcl.ComCtrls,
  Vcl.Menus,
  Data.DB,
  Data.Win.ADODB,

  //ArComp
  ARC_Personenliste,
  ARC_ImportPersonen,
  ARC_VereinListe,
  ARC_Turnierliste,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Mask,
  Vcl.DBCtrls;

type
  TMainWindow = class(TForm)
    MainMenu1: TMainMenu;
    test1: TMenuItem;
    Bearbeiten1: TMenuItem;
    Bearbeiten2: TMenuItem;
    Optionen1: TMenuItem;
    Drucken1: TMenuItem;
    ffnen1: TMenuItem;
    Speichern1: TMenuItem;
    Importieren1: TMenuItem;
    Beenden1: TMenuItem;
    Bogenschtzen1: TMenuItem;
    DBConnection: TADOConnection;
    Vereine1: TMenuItem;
    Panel2: TPanel;
    pageControl: TPageControl;
    sheetPersonenzuteilung: TTabSheet;
    DBGrid1: TDBGrid;
    Panel5: TPanel;
    editSearch: TEdit;
    Button3: TButton;
    Panel4: TPanel;
    buttonHinzufuegen: TButton;
    ButtonLoeschen: TButton;
    querySelectPersonen: TADOQuery;
    sourcePersonen: TDataSource;
    Panel3: TPanel;
    Label5: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    editBeginn: TDBEdit;
    editVeranstalter: TDBEdit;
    editEnde: TDBEdit;
    editTurniername: TDBEdit;
    editTurnierleitung: TDBEdit;
    editSchiedsrichter: TDBEdit;
    editTurnierart: TDBEdit;
    queryTurnier: TADOQuery;
    sourceTurnier: TDataSource;
    procedure Beenden1Click(Sender: TObject);
    procedure Importieren1Click(Sender: TObject);
    procedure Bogenschtzen1Click(Sender: TObject);
    procedure Vereine1Click(Sender: TObject);
    procedure ffnen1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ButtonLoeschenClick(Sender: TObject);

  private
    FTU_ID: string;
    procedure openCSVImportDialog;
    procedure openPersonenliste;
    procedure openVereinsListe;
    procedure openTurnierliste;
    procedure loadData;
    procedure searchPersonen(searchString: string);
    procedure loadTurnierDaten;
    procedure deletePersonenzuteilung;

    {Private-Deklarationen}
  public
    {Public-Deklarationen}
  end;

var
  MainWindow: TMainWindow;

implementation

{$R *.dfm}

procedure TMainWindow.Beenden1Click(Sender: TObject);
begin
  self.Close;
end;

procedure TMainWindow.Bogenschtzen1Click(Sender: TObject);
begin
  openPersonenliste();
end;

procedure TMainWindow.Button3Click(Sender: TObject);
begin
  searchPersonen(editSearch.Text);
end;

procedure TMainWindow.ButtonLoeschenClick(Sender: TObject);
begin
  deletePersonenzuteilung();
end;

procedure TMainWindow.deletePersonenzuteilung;
var
  aQuery: TADOQuery;
  aID   : string;
begin
  if querySelectPersonen.Active and (querySelectPersonen.RecordCount > 0) then
  begin
    if MessageDlg('Wollen Sie die ausgewählte Person aus dem Turnier entfernen?', mtConfirmation, mbYesNo, 0) = mrYes
    then
    begin
      aQuery := TADOQuery.Create(nil);
      aID    := querySelectPersonen.FieldByName('PE_ID').AsString;
      try
        aQuery.connection := DBConnection;
        with aQuery.SQL do
        begin
          Clear;
          add('DELETE FROM TURNIER_ZUTEILUNG');
          add('WHERE PE_ID = ' + QuotedStr(aID));
          add('  AND TU_ID = ' + QuotedStr(FTU_ID));
        end;
        aQuery.ExecSQL;
      finally
        aQuery.Free;
      end;
      searchPersonen(editSearch.Text);
    end;
  end;
end;

procedure TMainWindow.ffnen1Click(Sender: TObject);
begin
  openTurnierliste();
end;

procedure TMainWindow.openTurnierliste;
var
  aDialog: TFormTurnierListe;
begin
  aDialog := TFormTurnierListe.Create(nil);
  try
    //aDialog.Parent := self;
    aDialog.setConnection(DBConnection);
    if (aDialog.ShowModal = mrOK) then
    begin
      FTU_ID := aDialog.TU_ID;
      loadData();
    end;
  finally
    //aDialog.Free;
  end;
end;

procedure TMainWindow.openPersonenliste;
var
  aDialog: TFormPersonenListe;
begin
  aDialog := TFormPersonenListe.Create(nil);
  try
    //aDialog.Parent := self;
    aDialog.setConnection(DBConnection);
    aDialog.Show;
  finally
    //aDialog.Free;
  end;
end;

procedure TMainWindow.Vereine1Click(Sender: TObject);
begin
  openVereinsListe();
end;

procedure TMainWindow.openVereinsListe;
var
  aDialog: TFormVereinsListe;
begin
  aDialog := TFormVereinsListe.Create(nil);
  try
    //aDialog.Parent := self;
    aDialog.setConnection(DBConnection);
    aDialog.Show;
  finally
    //aDialog.Free;
  end;
end;

procedure TMainWindow.Importieren1Click(Sender: TObject);
begin
  openCSVImportDialog();
end;

procedure TMainWindow.openCSVImportDialog;
var
  aImport: TFormImportPersonen;
begin
  aImport := TFormImportPersonen.Create(self);
  aImport.setConnection(DBConnection);
  aImport.Show;
end;

procedure TMainWindow.loadData;
begin
  loadTurnierDaten();
  searchPersonen('');
end;

procedure TMainWindow.loadTurnierDaten;
begin
  queryTurnier.Parameters.ParseSQL(queryTurnier.SQL.Text, True);
  queryTurnier.Parameters.ParamByName('ID').value := FTU_ID;
  queryTurnier.Open;
end;

procedure TMainWindow.searchPersonen(searchString: string);
begin
  begin
    querySelectPersonen.Close;
    if querySelectPersonen.Active and (querySelectPersonen.RecordCount > 0) then
    begin
      querySelectPersonen.Active := false;
    end;
    querySelectPersonen.Parameters.Clear;
    querySelectPersonen.Parameters.ParseSQL(querySelectPersonen.SQL.Text, True);
    querySelectPersonen.Parameters.ParamByName('SEARCHSTRING').value := '%' + searchString + '%';
    querySelectPersonen.Parameters.ParamByName('ID').value           := FTU_ID;
    querySelectPersonen.Active                                       := True;
    querySelectPersonen.Open;
  end;
end;

end.
