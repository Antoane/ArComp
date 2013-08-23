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
  ARC_DAL_Tools,
  ARC_Personenliste,
  ARC_ImportPersonen,
  ARC_VereinListe,
  ARC_Turnierliste,
  ARC_Distanzen,
  ARC_Finalberechtigungen,
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
    panelTurnierinfo: TPanel;
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
    RundenDistanzen1: TMenuItem;
    Finalberechtigung1: TMenuItem;
    procedure Beenden1Click(Sender: TObject);
    procedure Importieren1Click(Sender: TObject);
    procedure Bogenschtzen1Click(Sender: TObject);
    procedure Vereine1Click(Sender: TObject);
    procedure ffnen1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ButtonLoeschenClick(Sender: TObject);
    procedure buttonHinzufuegenClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RundenDistanzen1Click(Sender: TObject);
    procedure Finalberechtigung1Click(Sender: TObject);

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
    procedure addPersonenzuteilung;
    procedure disableComponents;
    procedure normiereDatenbank;

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

procedure TMainWindow.buttonHinzufuegenClick(Sender: TObject);
begin
  addPersonenzuteilung();
end;

procedure TMainWindow.addPersonenzuteilung;
var
  aDialog: Tformpersonenliste;
  id     : string;
  aQuery : TADOQuery;
begin
  aDialog := Tformpersonenliste.Create(nil);
  aQuery  := TADOQuery.Create(nil);
  try
    aQuery.Connection := DBConnection;
    aDialog.setConnection(DBConnection);
    if (aDialog.ShowModal = mrOK) then
    begin
      for id in aDialog.selectedIDs do
      begin
        with aQuery.SQL do
        begin
          clear;
          add('INSERT INTO TURNIER_ZUTEILUNG(');
          add('  TZ_ID,');
          add('  TU_ID,');
          add('  PE_ID');
          add(')');
          add('VALUES(');
          add('  newID(),');
          add('  ' + quotedStr(FTU_ID) + ',');
          add('  ' + quotedStr(id));
          add(')');
        end;
        aQuery.ExecSQL;
      end;
    end;
  finally
    aQuery.Free;
    aDialog.Free;
  end;
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
        aQuery.Connection := DBConnection;
        with aQuery.SQL do
        begin
          clear;
          add('DELETE FROM TURNIER_ZUTEILUNG');
          add('WHERE PE_ID = ' + quotedStr(aID));
          add('  AND TU_ID = ' + quotedStr(FTU_ID));
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

procedure TMainWindow.Finalberechtigung1Click(Sender: TObject);
var
  aDialog: TFormFinalberechtigung;
begin
  aDialog := TFormFinalberechtigung.Create(self, DBConnection);
  try
    aDialog.ShowModal;
  finally
    aDialog.Free;
  end;
end;

procedure TMainWindow.FormShow(Sender: TObject);
begin
  normiereDatenbank();
  disableComponents();
end;

procedure TMainWindow.normiereDatenbank;
begin
  TARC_DAL_Tools.datenbankBereinigen(DBConnection);
end;

procedure TMainWindow.disableComponents;
begin
  pageControl.Enabled      := queryTurnier.Active and (queryTurnier.RecordCount > 0);
  panelTurnierinfo.Enabled := queryTurnier.Active and (queryTurnier.RecordCount > 0);
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
  disableComponents();
end;

procedure TMainWindow.openPersonenliste;
var
  aDialog: Tformpersonenliste;
begin
  aDialog := Tformpersonenliste.Create(nil);
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

procedure TMainWindow.RundenDistanzen1Click(Sender: TObject);
var
  aDialog: TFormDistanzen;
begin
  aDialog := TFormDistanzen.Create(self, DBConnection);
  try
    aDialog.ShowModal;
  finally
    aDialog.Free;
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
  queryTurnier.Close;
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
    querySelectPersonen.Parameters.clear;
    querySelectPersonen.Parameters.ParseSQL(querySelectPersonen.SQL.Text, True);
    querySelectPersonen.Parameters.ParamByName('SEARCHSTRING').value := '%' + searchString + '%';
    querySelectPersonen.Parameters.ParamByName('ID').value           := FTU_ID;
    querySelectPersonen.Active                                       := True;
    querySelectPersonen.Open;
  end;
end;

end.
