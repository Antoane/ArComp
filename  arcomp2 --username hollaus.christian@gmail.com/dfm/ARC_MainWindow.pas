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
  ARC_DAL_SETUP,
  ARC_Functions,
  ARC_Personenliste,
  ARC_PersonenDetail,
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
  Vcl.DBCtrls,
  Vcl.ImgList;

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
    buttonNeuPerson: TButton;
    sheetScores: TTabSheet;
    Panel2: TPanel;
    panelScheibenauswahl: TPanel;
    comboScoresScheibe: TComboBox;
    comboScoresScheibenplatz: TComboBox;
    DBGrid1: TDBGrid;
    editScoreName: TDBEdit;
    editScoreVerein: TDBEdit;
    editScoreBogenkategorie: TDBEdit;
    editScoreAlterskategorie: TDBEdit;
    editScoreGeschlecht: TDBEdit;
    queryScores: TADOQuery;
    sourceScores: TDataSource;
    editScore: TEdit;
    edit10er: TEdit;
    edit9er: TEdit;
    editX: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    checkScoresAutoForward: TCheckBox;
    buttonSaveScore: TButton;
    ImageList1: TImageList;
    Label16: TLabel;
    editRunde: TDBEdit;
    buttonAlleTeilnehmer: TButton;
    buttonAlleNichtZugeteilt: TButton;
    buttonAlleZugeteilt: TButton;
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
    procedure editSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure editSearchNichtZugeteiltKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure editSearchZugeteiltKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure gridTeilnehmerDblClick(Sender: TObject);
    procedure buttonNeuPersonClick(Sender: TObject);
    procedure comboScoresScheibeChange(Sender: TObject);
    procedure comboScoresScheibenplatzChange(Sender: TObject);
    procedure pageControlChange(Sender: TObject);
    procedure editScoreKeyPress(Sender: TObject; var Key: Char);
    procedure edit10erKeyPress(Sender: TObject; var Key: Char);
    procedure edit9erKeyPress(Sender: TObject; var Key: Char);
    procedure editXKeyPress(Sender: TObject; var Key: Char);
    procedure queryScoresAfterScroll(DataSet: TDataSet);
    procedure buttonSaveScoreClick(Sender: TObject);
    procedure pageControlScheibeneinteilungChange(Sender: TObject);
    procedure buttonAlleTeilnehmerClick(Sender: TObject);
    procedure buttonAlleNichtZugeteiltClick(Sender: TObject);
    procedure buttonAlleZugeteiltClick(Sender: TObject);

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
    procedure openPersonenDetail(PE_ID: string; neuePerson: boolean = false);
    procedure addPerson;
    procedure selectScores;
    procedure fillComboScores;
    procedure updateEditScores;
    procedure enterAsTab(Sender: TObject; var Key: Char);
    procedure saveScore;
    procedure selectNextScheibe;
    procedure createMissingTables;
    procedure setStartTabs;

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

procedure TMainWindow.buttonNeuPersonClick(Sender: TObject);
begin
  addPerson();
end;

procedure TMainWindow.addPerson;
var
  aQuery: TADOQuery;
  aID   : string;
begin
  aQuery := TADOQuery.create(nil);
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
  openPersonenDetail(aID, true);
end;

procedure TMainWindow.buttonSaveScoreClick(Sender: TObject);
begin
  saveScore();
  selectScores();
end;

procedure TMainWindow.selectNextScheibe;
begin
  //es gibt noch einen weiteren Scheibenplatz
  if (comboScoresScheibenplatz.ItemIndex < comboScoresScheibenplatz.Items.Count - 1) then
  begin
    comboScoresScheibenplatz.ItemIndex := comboScoresScheibenplatz.ItemIndex + 1;
  end
  //es gibt noch eine weitere Scheibe
  else if (comboScoresScheibe.ItemIndex < comboScoresScheibe.Items.Count - 1) then
  begin
    comboScoresScheibe.ItemIndex := comboScoresScheibe.ItemIndex + 1;
    FBL_Turnier.fillComboScoresScheibenPlatz(comboScoresScheibenplatz, FTU_ID, strToInt(comboScoresScheibe.Text));
  end
  else
  //das war die letzte...
  begin
    if MessageDlg('Das war die letzte Scheibe. Wollen Sie wieder zur ersten Scheibe springen?', mtConfirmation, mbYesNo,
      0) = mrYes then
    begin
      comboScoresScheibe.ItemIndex := 0;
      FBL_Turnier.fillComboScoresScheibenPlatz(comboScoresScheibenplatz, FTU_ID, strToInt(comboScoresScheibe.Text));
    end
  end;
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

procedure TMainWindow.comboScoresScheibeChange(Sender: TObject);
begin
  FBL_Turnier.fillComboScoresScheibenPlatz(comboScoresScheibenplatz, FTU_ID, strToInt(comboScoresScheibe.Text));
  selectScores();
end;

procedure TMainWindow.comboScoresScheibenplatzChange(Sender: TObject);
begin
  selectScores();
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

procedure TMainWindow.gridTeilnehmerDblClick(Sender: TObject);
begin
  openPersonenDetail(querySelectPersonen.FieldByName('PE_ID').AsString);
end;

procedure TMainWindow.openPersonenDetail(PE_ID: string; neuePerson: boolean = false);
var
  aDialog: TFormPersonenDetail;
begin
  aDialog := TFormPersonenDetail.create(self, querySelectPersonen.connection, PE_ID);
  if neuePerson then
  begin
    aDialog.inTurnierUebernehmen := true;
  end;
  if (aDialog.ShowModal = mrOk) then
  begin
    if aDialog.inTurnierUebernehmen then
    begin
      FBL_Turnier.teilnehmerEinfuegen(FTU_ID, PE_ID);
    end;
    searchPersonen('');
    loadScheibeneinteilungInfo();
  end;
end;

procedure TMainWindow.gridTeilnehmerTitleClick(Column: TColumn);
begin
  TARC_Tools.gridSort(gridTeilnehmer, Column);
end;

procedure TMainWindow.Button3Click(Sender: TObject);
begin
  searchPersonen(editSearch.Text);
end;

procedure TMainWindow.buttonAlleNichtZugeteiltClick(Sender: TObject);
begin
  searchPersonenNichtZugeteilt('');
end;

procedure TMainWindow.buttonAlleTeilnehmerClick(Sender: TObject);
begin
  searchPersonen('');
end;

procedure TMainWindow.buttonAlleZugeteiltClick(Sender: TObject);
begin
  searchPersonenZugeteilt('');
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
begin
  aDialog := Tformpersonenliste.create(nil);
  try
    aDialog.setConnection(DBConnection);
    if (aDialog.ShowModal = mrOk) then
    begin
      for id in aDialog.selectedIDs do
      begin
        FBL_Turnier.teilnehmerEinfuegen(FTU_ID, id);
      end;
    end;
  finally
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
  createMissingTables();
end;

procedure TMainWindow.createMissingTables;
var
  aQuery: TADOQuery;
begin
  aQuery := TADOQuery.create(nil);
  try
    aQuery.connection := DBConnection;
    TARC_DAL_Setup.createMissingTables(aQuery);
    aQuery.ExecSQL;
  finally
    aQuery.Free;
  end;
end;

procedure TMainWindow.FormShow(Sender: TObject);
begin
  normiereDatenbank();
  disableComponents();
  alignInfoGrid();
  setStartTabs();
end;

procedure TMainWindow.setStartTabs;
begin
  pageControl.ActivePage                   := sheetPersonenzuteilung;
  pageControlScheibeneinteilung.ActivePage := sheetScheibeneinteilungAllgemein;
end;

procedure TMainWindow.alignInfoGrid;
var
  i     : integer;
  aWidth: integer;
begin
  aWidth := GetSystemMetrics(SM_CXVSCROLL) * 2;
  for i  := 0 to gridBogenkategorieUebersicht.Columns.Count - 1 do
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

procedure TMainWindow.edit10erKeyPress(Sender: TObject; var Key: Char);
begin
  enterAsTab(Sender, Key);
end;

procedure TMainWindow.edit9erKeyPress(Sender: TObject; var Key: Char);
begin
  enterAsTab(Sender, Key);
end;

procedure TMainWindow.editScoreKeyPress(Sender: TObject; var Key: Char);
begin
  enterAsTab(Sender, Key);
end;

procedure TMainWindow.enterAsTab(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if HiWord(GetKeyState(VK_SHIFT)) <> 0 then
    begin
      SelectNext(Sender as TWinControl, false, true)
    end
    else
    begin
      SelectNext(Sender as TWinControl, true, true);
    end;
    Key := #0;
  end;
end;

procedure TMainWindow.editSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    searchPersonen(editSearch.Text);
  end;
end;

procedure TMainWindow.editSearchNichtZugeteiltKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    searchPersonenNichtZugeteilt(editSearchNichtZugeteilt.Text);
  end;
end;

procedure TMainWindow.editSearchZugeteiltKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    searchPersonenZugeteilt(editSearchZugeteilt.Text);
  end;
end;

procedure TMainWindow.editXKeyPress(Sender: TObject; var Key: Char);
var
  aRunde        : integer;
  aRundeAusQuery: integer;
begin
  if (Key = #13) and (checkScoresAutoForward.Checked) then
  begin
    if queryScores.RecNo < queryScores.RecordCount then
    begin
      aRunde := queryScores.FieldByName('DI_RUNDE').AsInteger;
      //score speichern
      saveScore();
      //nächste Scheibe auswählen
      selectNextScheibe();
      //Scores laden
      selectScores();
      //Runde selektieren
      queryScores.DisableControls;
      queryScores.first;
      while not queryScores.Eof do
      begin
        if TryStrToInt(queryScores.FieldByName('DI_RUNDE').AsString, aRundeAusQuery) then
        begin
          if aRundeAusQuery = aRunde then break;
          queryScores.Next;
        end
        else
        begin
          queryScores.Next;
        end;
      end;
      if queryScores.Eof then queryScores.first;
      queryScores.EnableControls;

      //editScore focus setzen
      editScore.SetFocus;
    end;
  end;
end;

procedure TMainWindow.openTurnierliste;
var
  aDialog: TFormTurnierListe;
begin
  aDialog := TFormTurnierListe.create(nil);
  try
    //aDialog.Parent := self;
    aDialog.setConnection(DBConnection);
    if (aDialog.ShowModal = mrOk) then
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

procedure TMainWindow.pageControlChange(Sender: TObject);
begin
  if pageControl.ActivePage = sheetPersonenzuteilung then
  begin
    if not querySelectPersonen.Active then
    begin
      searchPersonen('');
    end;
  end
  else if pageControl.ActivePage = sheetScheibeneinteilung then
  begin
    //was zu tun?
  end
  else if pageControl.ActivePage = sheetScores then
  begin
    fillComboScores();
    selectScores();
  end;
end;

procedure TMainWindow.pageControlScheibeneinteilungChange(Sender: TObject);
begin
  if pageControlScheibeneinteilung.ActivePage = sheetScheibeneinteilungNichtZugeteilt then
  begin
    if not queryScheibeneinteilungNichtZugeteilt.Active then
    begin
      searchPersonenNichtZugeteilt('');
    end;
  end
  else if pageControlScheibeneinteilung.ActivePage = sheetScheibeneinteilungZugeteilt then
  begin
    if not queryScheibeneinteilungZugeteilt.Active then
    begin
      searchPersonenZugeteilt('');
    end;
  end;
end;

procedure TMainWindow.queryScoresAfterScroll(DataSet: TDataSet);
begin
  updateEditScores();
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
  queryTurnier.Parameters.ParseSQL(queryTurnier.SQL.Text, true);
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
  queryScheibeneinteilungInfo.Parameters.ParseSQL(queryScheibeneinteilungInfo.SQL.Text, true);
  queryScheibeneinteilungInfo.Parameters.ParamByName('TU_ID').value := FTU_ID;
  queryScheibeneinteilungInfo.Open;
  FBL_Turnier.selectFreieScheibenInfo(queryInfoFreiePlaetze, FTU_ID);

end;

procedure TMainWindow.loadBogenkategorieUebersicht;
begin
  queryBogenkategorieUebersicht.Close;
  queryBogenkategorieUebersicht.Parameters.ParseSQL(queryBogenkategorieUebersicht.SQL.Text, true);
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
    querySelectPersonen.Parameters.Clear;
    querySelectPersonen.Parameters.ParseSQL(querySelectPersonen.SQL.Text, true);
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
    queryScheibeneinteilungNichtZugeteilt.Parameters.Clear;
    queryScheibeneinteilungNichtZugeteilt.Parameters.ParseSQL(queryScheibeneinteilungNichtZugeteilt.SQL.Text, true);
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
    queryScheibeneinteilungZugeteilt.Parameters.Clear;
    queryScheibeneinteilungZugeteilt.Parameters.ParseSQL(queryScheibeneinteilungZugeteilt.SQL.Text, true);
    queryScheibeneinteilungZugeteilt.Parameters.ParamByName('SEARCHSTRING').value := '%' + searchString + '%';
    queryScheibeneinteilungZugeteilt.Parameters.ParamByName('ID').value           := FTU_ID;
    queryScheibeneinteilungZugeteilt.Open;
  end;
end;

procedure TMainWindow.selectScores();
var
  aScheibe      : integer;
  aScheibenplatz: string;
begin
  aScheibe       := strToInt(comboScoresScheibe.Text);
  aScheibenplatz := comboScoresScheibenplatz.Text;

  FBL_Turnier.selectScores(queryScores, aScheibe, aScheibenplatz, FTU_ID);
  updateEditScores();
end;

procedure TMainWindow.fillComboScores();
begin
  FBL_Turnier.fillComboScoresScheiben(comboScoresScheibe, FTU_ID);
  FBL_Turnier.fillComboScoresScheibenPlatz(comboScoresScheibenplatz, FTU_ID, strToInt(comboScoresScheibe.Items[0]));
end;

procedure TMainWindow.updateEditScores;
begin
  if queryScores.Active and (queryScores.RecordCount > 1) then
  begin
    //letzte Zeile = Summe = nicht editieren!
    if queryScores.RecNo < queryScores.RecordCount then
    begin
      editScore.Text := queryScores.FieldByName('SC_SCORE').AsString;
      edit10er.Text  := queryScores.FieldByName('SC_ZEHNER').AsString;
      edit9er.Text   := queryScores.FieldByName('SC_NEUNER').AsString;
      editX.Text     := queryScores.FieldByName('SC_X').AsString;
    end;
  end;
end;

procedure TMainWindow.saveScore();
var
  aPE_ID : string;
  aSC_ID : string;
  aRunde : integer;
  aScore : integer;
  aZehner: integer;
  aNeuner: integer;
  aX     : integer;
begin
  if queryScores.Active and (queryScores.RecordCount > 1) then
  begin
    //letzte Zeile = Summe = nicht editieren!
    if queryScores.RecNo < queryScores.RecordCount then
    begin
      aPE_ID := queryScores.FieldByName('PE_ID').AsString;
      aSC_ID := queryScores.FieldByName('SC_ID').AsString;
      aRunde := queryScores.FieldByName('DI_RUNDE').AsInteger;
      if not TryStrToInt(editScore.Text, aScore) then
      begin
        aScore := 0;
      end;
      if not TryStrToInt(edit10er.Text, aZehner) then
      begin
        aZehner := 0;
      end;
      if not TryStrToInt(edit9er.Text, aNeuner) then
      begin
        aNeuner := 0;
      end;
      if not TryStrToInt(editX.Text, aX) then
      begin
        aX := 0;
      end;

      FBL_Turnier.saveScore(FTU_ID, aPE_ID, aSC_ID, aRunde, aScore, aZehner, aNeuner, aX);
    end;
  end;
end;

end.
