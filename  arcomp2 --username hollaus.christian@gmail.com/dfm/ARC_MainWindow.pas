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
  ARC_Tools,
  ARC_Personenliste,
  ARC_ImportPersonen,
  ARC_VereinListe,
  ARC_Turnierliste,
  ARC_Distanzen,
  ARC_BL_Turnier,
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
    panelMain: TPanel;
    pageControl: TPageControl;
    sheetPersonenzuteilung: TTabSheet;
    gridTeilnehmer: TDBGrid;
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
    sheetScheibeneinteilung: TTabSheet;
    pageControlScheibeneinteilung: TPageControl;
    sheetScheibeneinteilungAllgemein: TTabSheet;
    sheetScheibeneinteilungNichtZugeteilt: TTabSheet;
    sheetScheibeneinteilungZugeteilt: TTabSheet;
    panelScheibeneinteilungInfo: TPanel;
    panelFreieScheiben: TPanel;
    editAnzahlScheiben: TDBEdit;
    Label2: TLabel;
    editSchuetzenProScheibe: TDBEdit;
    Label3: TLabel;
    editAnzahlTeilnehmer: TDBEdit;
    Label4: TLabel;
    Label6: TLabel;
    editAnzahlTeilnehmerMitLizenz: TDBEdit;
    editTeilnehmerOhneScheibe: TDBEdit;
    Label7: TLabel;
    queryScheibeneinteilungInfo: TADOQuery;
    sourceScheibeneinteilungInfo: TDataSource;
    editPlaetze: TDBEdit;
    Label10: TLabel;
    gridNichtZugeteilt: TDBGrid;
    queryScheibeneinteilungNichtZugeteilt: TADOQuery;
    sourceScheibeneinteilungNichtZugeteilt: TDataSource;
    Panel6: TPanel;
    editSearchNichtZugeteilt: TEdit;
    buttonSearchPersonenNichtZugeteilt: TButton;
    panelScheibenEinteilen: TPanel;
    comboScheibenanzahl: TComboBox;
    comboScheibenplatz: TComboBox;
    buttonZuteilen: TButton;
    DBGrid3: TDBGrid;
    queryInfoFreiePlaetze: TADOQuery;
    sourceInfoFreiePlaetze: TDataSource;
    logoArcomp: TImage;
    Panel3: TPanel;
    editSearchZugeteilt: TEdit;
    buttonSearchPersonenZugeteilt: TButton;
    Panel7: TPanel;
    buttonZuteilungEntfernen: TButton;
    gridZugeteilt: TDBGrid;
    queryScheibeneinteilungZugeteilt: TADOQuery;
    sourceScheibeneinteilungZugeteilt: TDataSource;
    gridBogenkategorieUebersicht: TDBGrid;
    queryBogenkategorieUebersicht: TADOQuery;
    sourceBogenkategorieUebersicht: TDataSource;
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
    procedure buttonSearchPersonenNichtZugeteiltClick(Sender: TObject);
    procedure buttonZuteilenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure gridTeilnehmerTitleClick(Column: TColumn);
    procedure gridNichtZugeteiltTitleClick(Column: TColumn);
    procedure buttonSearchPersonenZugeteiltClick(Sender: TObject);
    procedure gridZugeteiltTitleClick(Column: TColumn);
    procedure buttonZuteilungEntfernenClick(Sender: TObject);

  private
    FTU_ID     : string;
    FBL_Turnier: TARC_BL_Turnier;

    constructor create(aOwner: TComponent); override;
    destructor destroy; override;

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
    procedure searchPersonenNichtZugeteilt(searchString: string);
    procedure loadScheibeneinteilungInfo;
    procedure searchPersonenZugeteilt(searchString: string);
    procedure loadBogenkategorieUebersicht;
    procedure alignInfoGrid;

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

procedure TMainWindow.buttonSearchPersonenNichtZugeteiltClick(Sender: TObject);
begin
  searchPersonenNichtZugeteilt(editSearchNichtZugeteilt.Text);
end;

procedure TMainWindow.buttonSearchPersonenZugeteiltClick(Sender: TObject);
begin
  searchPersonenZugeteilt(editSearchZugeteilt.Text);
end;

procedure TMainWindow.buttonZuteilenClick(Sender: TObject);
var
  aPE_ID: string;
begin
  aPE_ID := '';
  if queryScheibeneinteilungNichtZugeteilt.Active and (queryScheibeneinteilungNichtZugeteilt.RecordCount > 0) then
  begin
    aPE_ID := queryScheibeneinteilungNichtZugeteilt.FieldByName('PE_ID').AsString;
  end;

  if aPE_ID <> '' then
  begin
    if FBL_Turnier.zuteilen(FTU_ID, aPE_ID, comboScheibenanzahl, comboScheibenplatz) then
    begin
      searchPersonenNichtZugeteilt('');
      searchPersonenZugeteilt('');
      loadScheibeneinteilungInfo();
    end;
  end;
end;

procedure TMainWindow.buttonZuteilungEntfernenClick(Sender: TObject);
begin
  FBL_Turnier.zuteilungEntfernen(queryScheibeneinteilungZugeteilt.FieldByName('SE_ID').AsString);
  searchPersonenNichtZugeteilt('');
  searchPersonenZugeteilt('');
  loadScheibeneinteilungInfo();
end;

constructor TMainWindow.create(aOwner: TComponent);
begin
  inherited create(aOwner);
  FBL_Turnier := TARC_BL_Turnier.create(self, DBConnection);
end;

procedure TMainWindow.gridZugeteiltTitleClick(Column: TColumn);
begin
  TARC_Tools.gridSort(gridZugeteilt, Column);
end;

procedure TMainWindow.gridNichtZugeteiltTitleClick(Column: TColumn);
begin
  TARC_Tools.gridSort(gridNichtZugeteilt, Column);
end;

procedure TMainWindow.gridTeilnehmerTitleClick(Column: TColumn);
begin
  TARC_Tools.gridSort(gridTeilnehmer, Column);
end;

procedure TMainWindow.Button3Click(Sender: TObject);
begin
  searchPersonen(editSearch.Text);
end;

procedure TMainWindow.buttonHinzufuegenClick(Sender: TObject);
begin
  addPersonenzuteilung();
  loadScheibeneinteilungInfo();
end;

procedure TMainWindow.addPersonenzuteilung;
var
  aDialog: Tformpersonenliste;
  id     : string;
  aQuery : TADOQuery;
begin
  aDialog := Tformpersonenliste.create(nil);
  aQuery  := TADOQuery.create(nil);
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
          add('IF NOT EXISTS(');
          add('  SELECT PE_ID');
          add('  FROM TURNIER_ZUTEILUNG');
          add('  WHERE TU_ID =' + quotedStr(FTU_ID));
          add('    AND PE_ID =' + quotedStr(id));
          add(')');
          add('BEGIN');
          add('  INSERT INTO TURNIER_ZUTEILUNG(');
          add('    TZ_ID,');
          add('    TU_ID,');
          add('    PE_ID');
          add('  )');
          add('  VALUES(');
          add('    newID(),');
          add('    ' + quotedStr(FTU_ID) + ',');
          add('    ' + quotedStr(id));
          add('  )');
          add('END');
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
      aQuery := TADOQuery.create(nil);
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

destructor TMainWindow.destroy;
begin
  FBL_Turnier.Free;
  inherited destroy;
end;

procedure TMainWindow.ffnen1Click(Sender: TObject);
begin
  openTurnierliste();
end;

procedure TMainWindow.Finalberechtigung1Click(Sender: TObject);
var
  aDialog: TFormFinalberechtigung;
begin
  aDialog := TFormFinalberechtigung.create(self, DBConnection);
  try
    aDialog.ShowModal;
  finally
    aDialog.Free;
  end;
end;

procedure TMainWindow.FormCreate(Sender: TObject);
var
  aRowList: tStringList;
begin
  aRowList := tStringList.create;
  try
    aRowList.LoadFromFile('connectionString.txt');
    DBConnection.ConnectionString := aRowList[0];
  finally
    aRowList.Free;
  end;

end;

procedure TMainWindow.FormShow(Sender: TObject);
begin
  normiereDatenbank();
  disableComponents();
  alignInfoGrid();
end;

procedure TMainWindow.alignInfoGrid;
var
  i     : integer;
  aWidth: integer;
begin
  aWidth := GetSystemMetrics(SM_CXVSCROLL)*2;
  for i  := 0 to gridBogenkategorieUebersicht.Columns.Count-1 do
  begin
    aWidth := aWidth + gridBogenkategorieUebersicht.Columns[i].Width;
  end;
  gridBogenkategorieUebersicht.Width := aWidth;
end;

procedure TMainWindow.normiereDatenbank;
begin
  TARC_DAL_Tools.datenbankBereinigen(DBConnection);
end;

procedure TMainWindow.disableComponents;
begin
  pageControl.visible      := queryTurnier.Active and (queryTurnier.RecordCount > 0);
  panelTurnierinfo.visible := queryTurnier.Active and (queryTurnier.RecordCount > 0);
  logoArcomp.visible       := not pageControl.visible;
end;

procedure TMainWindow.openTurnierliste;
var
  aDialog: TFormTurnierListe;
begin
  aDialog := TFormTurnierListe.create(nil);
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
  aDialog := Tformpersonenliste.create(nil);
  try
    //aDialog.Parent := self;
    aDialog.setConnection(DBConnection);
    aDialog.ShowModal;
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
  aDialog := TFormVereinsListe.create(nil);
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
  aDialog := TFormDistanzen.create(self, DBConnection);
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
  aImport := TFormImportPersonen.create(self);
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

  loadScheibeneinteilungInfo();
  loadBogenkategorieUebersicht();

  FBL_Turnier.fillComboScheibenanzahl(comboScheibenanzahl, FTU_ID);
  FBL_Turnier.fillComboScheibenPlatz(comboScheibenplatz, FTU_ID);
end;

procedure TMainWindow.loadScheibeneinteilungInfo;
begin
  queryScheibeneinteilungInfo.Close;
  queryScheibeneinteilungInfo.Parameters.ParseSQL(queryScheibeneinteilungInfo.SQL.Text, True);
  queryScheibeneinteilungInfo.Parameters.ParamByName('TU_ID').value := FTU_ID;
  queryScheibeneinteilungInfo.Open;
  FBL_Turnier.selectFreieScheibenInfo(queryInfoFreiePlaetze, FTU_ID);

end;

procedure TMainWindow.loadBogenkategorieUebersicht;
begin
  queryBogenkategorieUebersicht.Close;
  queryBogenkategorieUebersicht.Parameters.ParseSQL(queryBogenkategorieUebersicht.SQL.Text, True);
  queryBogenkategorieUebersicht.Parameters.ParamByName('TU_ID').value := FTU_ID;
  queryBogenkategorieUebersicht.Open;
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
    querySelectPersonen.Open;
  end;
end;

procedure TMainWindow.searchPersonenNichtZugeteilt(searchString: string);
begin
  begin
    queryScheibeneinteilungNichtZugeteilt.Close;
    if queryScheibeneinteilungNichtZugeteilt.Active and (queryScheibeneinteilungNichtZugeteilt.RecordCount > 0) then
    begin
      queryScheibeneinteilungNichtZugeteilt.Active := false;
    end;
    queryScheibeneinteilungNichtZugeteilt.Parameters.clear;
    queryScheibeneinteilungNichtZugeteilt.Parameters.ParseSQL(queryScheibeneinteilungNichtZugeteilt.SQL.Text, True);
    queryScheibeneinteilungNichtZugeteilt.Parameters.ParamByName('SEARCHSTRING').value := '%' + searchString + '%';
    queryScheibeneinteilungNichtZugeteilt.Parameters.ParamByName('ID').value           := FTU_ID;
    queryScheibeneinteilungNichtZugeteilt.Open;
  end;
end;

procedure TMainWindow.searchPersonenZugeteilt(searchString: string);
begin
  begin
    queryScheibeneinteilungZugeteilt.Close;
    if queryScheibeneinteilungZugeteilt.Active and (queryScheibeneinteilungZugeteilt.RecordCount > 0) then
    begin
      queryScheibeneinteilungZugeteilt.Active := false;
    end;
    queryScheibeneinteilungZugeteilt.Parameters.clear;
    queryScheibeneinteilungZugeteilt.Parameters.ParseSQL(queryScheibeneinteilungZugeteilt.SQL.Text, True);
    queryScheibeneinteilungZugeteilt.Parameters.ParamByName('SEARCHSTRING').value := '%' + searchString + '%';
    queryScheibeneinteilungZugeteilt.Parameters.ParamByName('ID').value           := FTU_ID;
    queryScheibeneinteilungZugeteilt.Open;
  end;
end;

end.
