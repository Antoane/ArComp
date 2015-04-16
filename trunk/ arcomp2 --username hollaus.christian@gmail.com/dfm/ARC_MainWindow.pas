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
  ARC_ParameterRangliste,
  ARC_ParameterLandeswertung,
  ARC_Types,
  ARC_Tools,
  ARC_DAL_SETUP,
  ARC_Functions,
  ARC_Personenliste,
  ARC_PersonenDetail,
  ARC_ImportPersonen,
  ARC_VereinListe,
  ARC_Turnierliste,
  ARC_TurnierDetail,
  ARC_Distanzen,
  ARC_BL_Turnier,
  ARC_BL_Finale,
  ARC_Finalberechtigungen,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Mask,
  Vcl.DBCtrls,
  Vcl.ImgList,
  frxDesgn,
  frxClass,
  frxVariables,
  ARC_DAL_Teamwertung,
  frxADOComponents;

type
  TMainWindow = class(TForm)
    MainMenu1: TMainMenu;
    test1: TMenuItem;
    menuNeuesTurnier: TMenuItem;
    Bearbeiten2: TMenuItem;
    Optionen1: TMenuItem;
    menuItemDrucken: TMenuItem;
    menuOeffnen: TMenuItem;
    Speichern1: TMenuItem;
    Importieren1: TMenuItem;
    Beenden1: TMenuItem;
    menuSchuetzenBearbeiten: TMenuItem;
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
    Label16: TLabel;
    editRunde: TDBEdit;
    buttonAlleTeilnehmer: TButton;
    buttonAlleNichtZugeteilt: TButton;
    buttonAlleZugeteilt: TButton;
    buttonZumScore: TButton;
    urniere1: TMenuItem;
    menuItemReportDesigner: TMenuItem;
    frxReport: TfrxReport;
    menuItemRangliste: TMenuItem;
    Klasseneinteilung1: TMenuItem;
    urnierteilnehmer1: TMenuItem;
    sheetFinale: TTabSheet;
    PageControl2: TPageControl;
    sheetFinaleAnlegen: TTabSheet;
    sourceFinale: TDataSource;
    sourceTmpFinalauswahl: TDataSource;
    queryTmpFinalauswahl: TADOQuery;
    Panel8: TPanel;
    Panel9: TPanel;
    gridTmpFinalauswahl: TDBGrid;
    buttonFinaleAnlegen: TButton;
    comboFinaleBogenkategorie: TComboBox;
    comboFinalealterskategorie: TComboBox;
    comboFinaleGeschlecht: TComboBox;
    Button2: TButton;
    comboFinalRaster: TComboBox;
    Sheet1: TTabSheet;
    comboFinale: TComboBox;
    Button5: TButton;
    DBConnection: TADOConnection;
    frxADOComponents1: TfrxADOComponents;
    frxDesigner1: TfrxDesigner;
    Scheibeneinteilung1: TMenuItem;
    Scorekarten1: TMenuItem;
    ScorekartenBlanko1: TMenuItem;
    buttonResetScheibeneinteilung: TButton;
    buttonDruckScorekarte: TButton;
    urnierteilnehmernachKlasse1: TMenuItem;
    sheetTeamwertung: TTabSheet;
    gridTeamwertung: TDBGrid;
    Panel1: TPanel;
    panelTeam: TPanel;
    comboVerein: TComboBox;
    comboTeamPerson1: TComboBox;
    comboTeamPerson2: TComboBox;
    comboTeamPerson3: TComboBox;
    editTeamname: TEdit;
    buttonTeamHinzufuegen: TButton;
    queryTeamPerson1: TADOQuery;
    queryTeamPerson2: TADOQuery;
    queryTeamPerson3: TADOQuery;
    sourceTeamPerson1: TDataSource;
    sourceTeamPerson2: TDataSource;
    sourceTeamPerson3: TDataSource;
    queryVerein: TADOQuery;
    sourceVerein: TDataSource;
    queryTeamwertung: TADOQuery;
    sourceTeamwertung: TDataSource;
    buttonTeamEntfernen: TButton;
    buttonSaveTeamwertung: TButton;
    urnierteilnehmermitScheibe1: TMenuItem;
    LabelTeamName: TLabel;
    labelVerein: TLabel;
    labelTeamPerson1: TLabel;
    labelTeamPerson2: TLabel;
    labelTeamPerson3: TLabel;
    menuItemRanglisteTeam: TMenuItem;
    comboBogenKategorie: TComboBox;
    Label1: TLabel;
    queryBogenkategorie: TADOQuery;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    ImageList: TImageList;
    Scheibeneinteilungallgemein1: TMenuItem;
    procedure Beenden1Click(Sender: TObject);
    procedure Importieren1Click(Sender: TObject);
    procedure menuSchuetzenBearbeitenClick(Sender: TObject);
    procedure Vereine1Click(Sender: TObject);
    procedure menuOeffnenClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ButtonLoeschenClick(Sender: TObject);
    procedure buttonHinzufuegenClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RundenDistanzen1Click(Sender: TObject);
    procedure Finalberechtigung1Click(Sender: TObject);
    procedure buttonSearchPersonenNichtZugeteiltClick(Sender: TObject);
    procedure buttonZuteilenClick(Sender: TObject);
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
    procedure buttonZumScoreClick(Sender: TObject);
    procedure gridZugeteiltDblClick(Sender: TObject);
    procedure urniere1Click(Sender: TObject);
    procedure menuNeuesTurnierClick(Sender: TObject);
    procedure menuItemReportDesignerClick(Sender: TObject);
    procedure menuItemRanglisteClick(Sender: TObject);
    procedure gridTeilnehmerDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure gridNichtZugeteiltDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure gridZugeteiltDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure Klasseneinteilung1Click(Sender: TObject);
    procedure urnierteilnehmer1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure buttonFinaleAnlegenClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure comboFinaleBogenkategorieChange(Sender: TObject);
    procedure comboFinalealterskategorieChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Scheibeneinteilung1Click(Sender: TObject);
    procedure Scorekarten1Click(Sender: TObject);
    procedure ScorekartenBlanko1Click(Sender: TObject);
    procedure buttonResetScheibeneinteilungClick(Sender: TObject);
    procedure buttonDruckScorekarteClick(Sender: TObject);
    procedure urnierteilnehmernachKlasse1Click(Sender: TObject);
    procedure comboVereinChange(Sender: TObject);
    procedure buttonTeamHinzufuegenClick(Sender: TObject);
    procedure queryTeamwertungAfterScroll(DataSet: TDataSet);
    procedure buttonTeamEntfernenClick(Sender: TObject);
    procedure buttonSaveTeamwertungClick(Sender: TObject);
    procedure urnierteilnehmermitScheibe1Click(Sender: TObject);
    procedure menuItemRanglisteTeamClick(Sender: TObject);
    procedure comboBogenKategorieChange(Sender: TObject);
    procedure ScheibeneinteilungUebersichtClick(Sender: TObject);

  private
    FTU_ID           : string;
    FBL_Turnier      : TARC_BL_Turnier;
    FBL_Finale       : TARC_BL_Finale;
    FConnectionString: string;

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
    procedure goToScore;
    procedure openTurnierDetail(TU_ID: string);
    procedure loadTeamWertung;
    procedure setTeamDaten;
    procedure updatePersonenDropdowns;
    procedure saveTeamwertung;
    procedure insertTeamwertung;
    procedure deleteTeamWertung;
    procedure setConnectionString(const value: string);

    {Private-Deklarationen}
  public

    property ConnectionString: string
      read   FConnectionString
      write  setConnectionString;
    {Public-Deklarationen}
  end;

implementation

{$R *.dfm}

procedure TMainWindow.menuItemRanglisteClick(Sender: TObject);
var
  aDialog         : TFormParameterRangliste;
  aDialog2        : TFormParameterLandeswertung;
  aAlterskategorie: string;
  aBogenkategorie : string;
  aGeschlecht     : string;
  aTest           : string;
begin
  aDialog  := TFormParameterRangliste.create(nil);
  aDialog2 := TFormParameterLandeswertung.create(nil);
  try
    aDialog.setConnection(DBConnection);
    aDialog2.setConnection(DBConnection);
    if aDialog.ShowModal = mrOK then
    begin
      if aDialog2.ShowModal = mrOK then
      begin
        aAlterskategorie := aDialog.Alterskategorien;
        aBogenkategorie  := aDialog.Bogenkategorien;
        aGeschlecht      := aDialog.Geschlecht;
        aTest            := GetCurrentDir;
        frxReport.LoadFromFile('..\Reports\Rangliste.fr3');
        frxReport.Variables[' ' + 'ArComp'] := Null;
        frxReport.Variables['TU_ID']        := quotedStr(FTU_ID);

        frxReport.Variables['FILTER_BOGENKATEGORIE'] := boolToInt(aBogenkategorie <> '');
        frxReport.Variables['PARAM_BOGENKATEGORIE']  := quotedStr(aBogenkategorie);

        frxReport.Variables['FILTER_ALTERSKATEGORIE'] := boolToInt(aAlterskategorie <> '');
        frxReport.Variables['PARAM_ALTERSKATEGORIE']  := quotedStr(aAlterskategorie);

        frxReport.Variables['FILTER_GESCHLECHT'] := boolToInt(aGeschlecht <> '');
        frxReport.Variables['PARAM_GESCHLECHT']  := quotedStr(aGeschlecht);

        frxReport.Variables['MIT_LANDESWERTUNG']  := boolToInt(aDialog2.MitLAndeswertung);
        frxReport.Variables['OHNE_LANDESWERTUNG'] := boolToInt(aDialog2.OhneLAndeswertung);

        //frxReport.DesignReport();
        frxReport.ShowReport(true);
      end;
    end;
  finally
    aDialog.Free;
    aDialog2.Free;
  end;
end;

procedure TMainWindow.menuItemRanglisteTeamClick(Sender: TObject);
var
  aDialog         : TFormParameterRangliste;
  aDialog2        : TFormParameterLandeswertung;
  aAlterskategorie: string;
  aBogenkategorie : string;
  aGeschlecht     : string;
  aTest           : string;
begin
  aDialog  := TFormParameterRangliste.create(nil);
  aDialog2 := TFormParameterLandeswertung.create(nil);
  try
    aDialog.setConnection(DBConnection);
    aDialog2.setConnection(DBConnection);
    if aDialog.ShowModal = mrOK then
    begin
      if aDialog2.ShowModal = mrOK then
      begin
        aAlterskategorie := aDialog.Alterskategorien;
        aBogenkategorie  := aDialog.Bogenkategorien;
        aGeschlecht      := aDialog.Geschlecht;
        aTest            := GetCurrentDir;
        frxReport.LoadFromFile('..\Reports\RanglisteTeam.fr3');
        frxReport.Variables[' ' + 'ArComp'] := Null;
        frxReport.Variables['TU_ID']        := quotedStr(FTU_ID);

        frxReport.Variables['FILTER_BOGENKATEGORIE'] := boolToInt(aBogenkategorie <> '');
        frxReport.Variables['PARAM_BOGENKATEGORIE']  := quotedStr(aBogenkategorie);

        frxReport.Variables['FILTER_ALTERSKATEGORIE'] := boolToInt(aAlterskategorie <> '');
        frxReport.Variables['PARAM_ALTERSKATEGORIE']  := quotedStr(aAlterskategorie);

        frxReport.Variables['FILTER_GESCHLECHT'] := boolToInt(aGeschlecht <> '');
        frxReport.Variables['PARAM_GESCHLECHT']  := quotedStr(aGeschlecht);

        frxReport.Variables['MIT_LANDESWERTUNG']  := boolToInt(aDialog2.MitLAndeswertung);
        frxReport.Variables['OHNE_LANDESWERTUNG'] := boolToInt(aDialog2.OhneLAndeswertung);

        //frxReport.DesignReport();
        frxReport.ShowReport(true);
      end;
    end;
  finally
    aDialog.Free;
    aDialog2.Free;
  end;
end;

procedure TMainWindow.menuItemReportDesignerClick(Sender: TObject);
begin
  frxReport.Script.Variables['TU_ID'] := 'BLA';
  frxReport.DesignReport();
end;

procedure TMainWindow.menuNeuesTurnierClick(Sender: TObject);
var
  aQuery: TADOQuery;
  aID   : string;
begin
  aQuery := TADOQuery.create(nil);
  try
    aID               := newGUID();
    aQuery.Connection := DBConnection;
    with aQuery.SQL do
    begin
      Clear;
      add('INSERT INTO TURNIER(');
      add('  TU_ID');
      add(')');
      add('VALUES(');
      add('  ' + quotedStr(aID));
      add(')');
    end;
    aQuery.ExecSQL;
  finally
    aQuery.Free;
  end;
  openTurnierDetail(aID);
end;

procedure TMainWindow.openTurnierDetail(TU_ID: string);
var
  aDialog: TFormTurnierDetail;
begin
  aDialog := TFormTurnierDetail.create(self, DBConnection, TU_ID);
  if (aDialog.ShowModal = mrOK) then
  begin
    FTU_ID := TU_ID;
    loadData();
    disableComponents();
  end;
end;

procedure TMainWindow.Beenden1Click(Sender: TObject);
begin
  self.Close;
end;

procedure TMainWindow.menuSchuetzenBearbeitenClick(Sender: TObject);
begin
  openPersonenliste();
end;

procedure TMainWindow.buttonNeuPersonClick(Sender: TObject);
begin
  addPerson();
  loadBogenkategorieUebersicht();
  loadScheibeneinteilungInfo();
end;

procedure TMainWindow.buttonResetScheibeneinteilungClick(Sender: TObject);
begin
  if MessageDlg('Wollen Sie wirklich die komplette Scheibeneinteilung zurücksetzen?', mtConfirmation, mbYesNo, 0) = mrYes
  then
  begin
    FBL_Turnier.zuteilungResetten(FTU_ID);
    searchPersonenNichtZugeteilt('');
    searchPersonenZugeteilt('');
    loadScheibeneinteilungInfo();
    pageControlScheibeneinteilung.ActivePage := sheetScheibeneinteilungNichtZugeteilt;
  end
end;

procedure TMainWindow.addPerson;
var
  aQuery: TADOQuery;
  aID   : string;
begin
  aQuery := TADOQuery.create(nil);
  try
    aID               := newGUID();
    aQuery.Connection := querySelectPersonen.Connection;
    with aQuery.SQL do
    begin
      Clear;
      add('INSERT INTO PERSON(');
      add('  PE_ID');
      add(')');
      add('VALUES(');
      add('  ' + quotedStr(aID));
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

procedure TMainWindow.buttonSaveTeamwertungClick(Sender: TObject);
begin
  deleteTeamWertung();
  saveTeamwertung();
  loadTeamWertung();
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

procedure TMainWindow.loadTeamWertung;
begin
  TARC_DAL_Teamwertung.SQL_Teamwertung(queryTeamwertung, FTU_ID);
  queryTeamwertung.Open;
end;

procedure TMainWindow.buttonTeamEntfernenClick(Sender: TObject);
begin
  deleteTeamWertung();
  loadTeamWertung();
end;

procedure TMainWindow.deleteTeamWertung;
begin
  TARC_DAL_Teamwertung.SQL_TeamEntfernen(queryTeamwertung.FieldByName('TE_ID').AsString, DBConnection);
end;

procedure TMainWindow.insertTeamwertung;
var
  aTE_ID         : string;
  aVE_ID         : string;
  aTeamname      : string;
  aBogenkategorie: string;
  aPE_ID1        : string;
  aPE_ID2        : string;
  aPE_ID3        : string;
begin
  aVE_ID          := TARC_Tools.getKeyToValue(queryVerein, 'VE_ID', 'VE_NAME', comboVerein.Text);
  aTeamname       := editTeamname.Text + '_NEU';
  aPE_ID1         := TARC_Tools.getKeyToValue(queryTeamPerson1, 'PE_ID', 'NAME', comboTeamPerson1.Text);
  aPE_ID2         := TARC_Tools.getKeyToValue(queryTeamPerson1, 'PE_ID', 'NAME', comboTeamPerson2.Text);
  aPE_ID3         := TARC_Tools.getKeyToValue(queryTeamPerson1, 'PE_ID', 'NAME', comboTeamPerson3.Text);
  aBogenkategorie := comboBogenKategorie.Text;

  aTE_ID := TARC_DAL_Teamwertung.addTeam(FTU_ID, aTeamname, aBogenkategorie, aVE_ID, DBConnection);

  if aPE_ID1 <> '' then
  begin
    TARC_DAL_Teamwertung.addTeamMember(aTE_ID, aPE_ID1, DBConnection);
  end;
  if aPE_ID2 <> '' then
  begin
    TARC_DAL_Teamwertung.addTeamMember(aTE_ID, aPE_ID2, DBConnection);
  end;
  if aPE_ID3 <> '' then
  begin
    TARC_DAL_Teamwertung.addTeamMember(aTE_ID, aPE_ID3, DBConnection);
  end;
end;

procedure TMainWindow.buttonTeamHinzufuegenClick(Sender: TObject);
begin
  insertTeamwertung();
  loadTeamWertung();
end;

procedure TMainWindow.saveTeamwertung;
var
  aTE_ID         : string;
  aVE_ID         : string;
  aTeamname      : string;
  aPE_ID1        : string;
  aPE_ID2        : string;
  aPE_ID3        : string;
  aBogenkategorie: string;
begin
  aVE_ID          := TARC_Tools.getKeyToValue(queryVerein, 'VE_ID', 'VE_NAME', comboVerein.Text);
  aTeamname       := editTeamname.Text;
  aBogenkategorie := comboBogenKategorie.Text;
  aPE_ID1         := TARC_Tools.getKeyToValue(queryTeamPerson1, 'PE_ID', 'NAME', comboTeamPerson1.Text);
  aPE_ID2         := TARC_Tools.getKeyToValue(queryTeamPerson1, 'PE_ID', 'NAME', comboTeamPerson2.Text);
  aPE_ID3         := TARC_Tools.getKeyToValue(queryTeamPerson1, 'PE_ID', 'NAME', comboTeamPerson3.Text);

  aTE_ID := TARC_DAL_Teamwertung.addTeam(FTU_ID, aTeamname, aBogenkategorie, aVE_ID, DBConnection);

  if aPE_ID1 <> '' then
  begin
    TARC_DAL_Teamwertung.addTeamMember(aTE_ID, aPE_ID1, DBConnection);
  end;
  if aPE_ID2 <> '' then
  begin
    TARC_DAL_Teamwertung.addTeamMember(aTE_ID, aPE_ID2, DBConnection);
  end;
  if aPE_ID3 <> '' then
  begin
    TARC_DAL_Teamwertung.addTeamMember(aTE_ID, aPE_ID3, DBConnection);
  end;
end;

procedure TMainWindow.buttonZumScoreClick(Sender: TObject);
begin
  goToScore();
end;

procedure TMainWindow.goToScore;
begin
  if queryScheibeneinteilungZugeteilt.Active and (queryScheibeneinteilungZugeteilt.RecordCount > 0) then
  begin
    fillComboScores();

    comboScoresScheibe.ItemIndex := comboScoresScheibe.Items.IndexOf
      (queryScheibeneinteilungZugeteilt.FieldByName('SE_NUMMER').AsString);
    comboScoresScheibenplatz.ItemIndex := comboScoresScheibenplatz.Items.IndexOf
      (queryScheibeneinteilungZugeteilt.FieldByName('SE_PLATZ').AsString);

    selectScores();

    pageControl.ActivePage := sheetScores;
  end;
end;

procedure TMainWindow.buttonZuteilenClick(Sender: TObject);
var
  aPE_ID       : string;
  sort         : string;
  selectedIndex: Integer;
begin
  aPE_ID        := '';
  selectedIndex := queryScheibeneinteilungNichtZugeteilt.RecNo;
  sort          := queryScheibeneinteilungNichtZugeteilt.sort;

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
      queryScheibeneinteilungNichtZugeteilt.sort := sort;
      if queryScheibeneinteilungNichtZugeteilt.Active and
        (queryScheibeneinteilungNichtZugeteilt.RecordCount > selectedIndex) then
      begin
        queryScheibeneinteilungNichtZugeteilt.RecNo := selectedIndex;
      end;
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

procedure TMainWindow.comboBogenKategorieChange(Sender: TObject);
begin
  updatePersonenDropdowns();
end;

procedure TMainWindow.comboFinalealterskategorieChange(Sender: TObject);
begin
  FBL_Finale.fillComboFinaleGeschlecht(comboFinaleGeschlecht, FTU_ID, comboFinaleBogenkategorie.Text,
    comboFinalealterskategorie.Text);
end;

procedure TMainWindow.comboFinaleBogenkategorieChange(Sender: TObject);
begin
  FBL_Finale.fillComboFinaleAlterskategorie(comboFinalealterskategorie, FTU_ID, comboFinaleBogenkategorie.Text);
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

procedure TMainWindow.comboVereinChange(Sender: TObject);
begin
  updatePersonenDropdowns();
end;

procedure TMainWindow.updatePersonenDropdowns;
var
  aVE_ID: string;
begin
  aVE_ID := TARC_Tools.getKeyToValue(queryVerein, 'VE_ID', 'VE_NAME', comboVerein.Text);
  TARC_DAL_Teamwertung.selectPersonenZuVerein(queryTeamPerson1, aVE_ID, FTU_ID, comboBogenKategorie.Text);
  queryTeamPerson1.Open;
  TARC_Tools.fillComboFromQuery(comboTeamPerson1, queryTeamPerson1, 'PE_ID', 'NAME');
  TARC_Tools.fillComboFromQuery(comboTeamPerson2, queryTeamPerson1, 'PE_ID', 'NAME');
  TARC_Tools.fillComboFromQuery(comboTeamPerson3, queryTeamPerson1, 'PE_ID', 'NAME');
  //TODO aus verschiedenen queries befüllen?
end;

constructor TMainWindow.create(aOwner: TComponent);
begin
  inherited create(aOwner);
end;

procedure TMainWindow.gridZugeteiltDblClick(Sender: TObject);
begin
  goToScore();
end;

procedure TMainWindow.gridZugeteiltDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  TARC_Tools.DrawColumnCell(Sender, Rect, DataCol, Column, State, gridZugeteilt);
end;

procedure TMainWindow.gridZugeteiltTitleClick(Column: TColumn);
begin
  TARC_Tools.gridSort(gridZugeteilt, Column);
end;

procedure TMainWindow.gridNichtZugeteiltDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
begin
  TARC_Tools.DrawColumnCell(Sender, Rect, DataCol, Column, State, gridNichtZugeteilt);
end;

procedure TMainWindow.gridNichtZugeteiltTitleClick(Column: TColumn);
begin
  TARC_Tools.gridSort(gridNichtZugeteilt, Column);
end;

procedure TMainWindow.gridTeilnehmerDblClick(Sender: TObject);
begin
  openPersonenDetail(querySelectPersonen.FieldByName('PE_ID').AsString);
end;

procedure TMainWindow.gridTeilnehmerDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
begin
  TARC_Tools.DrawColumnCell(Sender, Rect, DataCol, Column, State, gridTeilnehmer);
end;

procedure TMainWindow.openPersonenDetail(PE_ID: string; neuePerson: boolean = false);
var
  aDialog: TFormPersonenDetail;
begin
  aDialog := TFormPersonenDetail.create(self, querySelectPersonen.Connection, PE_ID);
  if neuePerson then
  begin
    aDialog.inTurnierUebernehmen := true;
  end;
  if (aDialog.ShowModal = mrOK) then
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

procedure TMainWindow.Button2Click(Sender: TObject);
begin
  FBL_Finale.addToFinale(queryTmpFinalauswahl, FTU_ID, comboFinaleBogenkategorie.Text, comboFinalealterskategorie.Text,
    comboFinaleGeschlecht.Text);
  TARC_Tools.autoSizeColumns(queryTmpFinalauswahl, gridTmpFinalauswahl);
  FBL_Finale.fillComboFinalRaster(comboFinalRaster, queryTmpFinalauswahl);
end;

procedure TMainWindow.Button3Click(Sender: TObject);
begin
  searchPersonen(editSearch.Text);
end;

procedure TMainWindow.buttonFinaleAnlegenClick(Sender: TObject);
var
  aName: string;
begin
  if comboFinalRaster.Items.Count > 0 then
  begin
    aName := InputBox('Bezeichnung', 'Bitte geben Sie die Bezeichnung für dieses Final ein.', '');
    if trim(aName) <> '' then
    begin
      FBL_Finale.finaleAnlegen(FTU_ID, queryTmpFinalauswahl, strToInt(comboFinalRaster.Text), aName);
      FBL_Finale.fillComboFinale(comboFinale, FTU_ID);
    end;
  end;
end;

procedure TMainWindow.Button5Click(Sender: TObject);
begin
  if (MessageDlg('Möchten Sie das gewählte Finale wirlkich löschen?', mtConfirmation, mbYesNo, 0) = mrYes) then
  begin
    FBL_Finale.deleteSelectedFinale();
    FBL_Finale.fillComboFinale(comboFinale, FTU_ID);
  end;
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

procedure TMainWindow.buttonDruckScorekarteClick(Sender: TObject);
begin
  if queryScheibeneinteilungZugeteilt.Active and (queryScheibeneinteilungZugeteilt.RecordCount > 0) then
  begin
    frxReport.LoadFromFile('..\Reports\Scoreblatt.fr3');
    frxReport.Variables[' ' + 'ArComp'] := Null;
    frxReport.Variables['TU_ID']        := quotedStr(FTU_ID);
    frxReport.Variables['SCHEIBE']      := queryScheibeneinteilungZugeteilt.FieldByName('SE_NUMMER').AsInteger;

    //frxReport.DesignReport();
    frxReport.ShowReport(true);
  end;
end;

procedure TMainWindow.buttonHinzufuegenClick(Sender: TObject);
begin
  addPersonenzuteilung();
  loadBogenkategorieUebersicht();
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
    aDialog.DataState := dsSelectMode;
    if (aDialog.ShowModal = mrOK) then
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
        aQuery.Connection := DBConnection;
        with aQuery.SQL do
        begin
          Clear;
          add('DELETE FROM SCHEIBENEINTEILUNG');
          add('WHERE PE_ID = ' + quotedStr(aID));
          add('  AND TU_ID = ' + quotedStr(FTU_ID));

          add('DELETE FROM SCORES');
          add('WHERE PE_ID = ' + quotedStr(aID));
          add('  AND TU_ID = ' + quotedStr(FTU_ID));

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
  FBL_Finale.Free;
  inherited destroy;
end;

procedure TMainWindow.menuOeffnenClick(Sender: TObject);
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

procedure TMainWindow.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 17 then isCtrlPressed := true;

  //strg-o -> öffnen
  if isCtrlPressed and (Key = 79) then
  begin
    Key := 0;
    openTurnierliste();
  end;

  if pageControl.Visible then
  begin
    if pageControl.ActivePage = sheetPersonenzuteilung then
    begin
      //strg +
      if isCtrlPressed and (Key = 107) then
      begin
        Key := 0;
        buttonHinzufuegenClick(nil);
      end;

      if isCtrlPressed and (Key = 109) then
      begin
        Key := 0;
        ButtonLoeschenClick(nil);
      end;
    end;
  end;
end;

procedure TMainWindow.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  isCtrlPressed := false;
end;

procedure TMainWindow.createMissingTables;
var
  aQuery: TADOQuery;
begin
  aQuery := TADOQuery.create(nil);
  try
    aQuery.Connection := DBConnection;
    TARC_DAL_Setup.createMissingTables(aQuery);
    aQuery.ExecSQL;
  finally
    aQuery.Free;
  end;
end;

procedure TMainWindow.FormShow(Sender: TObject);
begin
  FBL_Turnier          := TARC_BL_Turnier.create(self, DBConnection);
  FBL_Finale           := TARC_BL_Finale.create(self, DBConnection);
  sourceFinale.DataSet := FBL_Finale.Finale;

  normiereDatenbank();
  disableComponents();
  alignInfoGrid();
  setStartTabs();
end;

procedure TMainWindow.setConnectionString(const value: string);
begin
  FConnectionString             := value;
  DBConnection.ConnectionString := FConnectionString;
  createMissingTables();
end;

procedure TMainWindow.setStartTabs;
begin
  pageControl.ActivePage                   := sheetPersonenzuteilung;
  pageControlScheibeneinteilung.ActivePage := sheetScheibeneinteilungAllgemein;
end;

procedure TMainWindow.alignInfoGrid;
var
  i     : Integer;
  aWidth: Integer;
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
  pageControl.Visible      := queryTurnier.Active and (queryTurnier.RecordCount > 0);
  menuItemDrucken.Visible  := queryTurnier.Active and (queryTurnier.RecordCount > 0);
  panelTurnierinfo.Visible := queryTurnier.Active and (queryTurnier.RecordCount > 0);
  logoArcomp.Visible       := not pageControl.Visible;
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
  aRunde        : Integer;
  aRundeAusQuery: Integer;
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
    aDialog.DataState := dsSelectMode;
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
    aDialog.setConnection(DBConnection);
    aDialog.DataState := dsEditMode;
    aDialog.ShowModal;
  finally
    aDialog.Free;
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
  end
  else if pageControl.ActivePage = sheetTeamwertung then
  begin
    loadTeamWertung();
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

procedure TMainWindow.queryTeamwertungAfterScroll(DataSet: TDataSet);
begin
  setTeamDaten();
end;

procedure TMainWindow.setTeamDaten;
var
  aQuery : TADOQuery;
  aVE_ID : string;
  aPE_ID1: string;
  aPE_ID2: string;
  aPE_ID3: string;
begin
  aQuery := TADOQuery.create(nil);
  try
    aQuery.Connection := DBConnection;
    TARC_DAL_Teamwertung.selectTeam(aQuery, queryTeamwertung.FieldByName('TE_ID').AsString);
    aQuery.Open;

    if aQuery.RecordCount >= 1 then
    begin
      editTeamname.Text             := aQuery.FieldByName('TE_NAME').AsString;
      comboBogenKategorie.ItemIndex := comboBogenKategorie.Items.IndexOf(aQuery.FieldByName('TE_BOGENKATEGORIE')
        .AsString);
      aVE_ID := aQuery.FieldByName('VE_ID').AsString;
      if queryVerein.Locate('VE_ID', aVE_ID, []) then
      begin
        comboVerein.ItemIndex := comboVerein.Items.IndexOf(queryVerein.FieldByName('VE_NAME').AsString);
      end;
      updatePersonenDropdowns();

      aQuery.RecNo := 1;
      aPE_ID1      := aQuery.FieldByName('PE_ID').AsString;
      if queryTeamPerson1.Locate('PE_ID', aPE_ID1, []) then
      begin
        comboTeamPerson1.ItemIndex := comboTeamPerson1.Items.IndexOf(queryTeamPerson1.FieldByName('NAME').AsString);
      end;

      aQuery.RecNo := 2;
      aPE_ID2      := aQuery.FieldByName('PE_ID').AsString;
      if queryTeamPerson1.Locate('PE_ID', aPE_ID2, []) then
      begin
        comboTeamPerson2.ItemIndex := comboTeamPerson2.Items.IndexOf(queryTeamPerson1.FieldByName('NAME').AsString);
      end;

      aQuery.RecNo := 3;
      aPE_ID3      := aQuery.FieldByName('PE_ID').AsString;
      if queryTeamPerson1.Locate('PE_ID', aPE_ID3, []) then
      begin
        comboTeamPerson3.ItemIndex := comboTeamPerson3.Items.IndexOf(queryTeamPerson1.FieldByName('NAME').AsString);
      end;
    end;

  finally
    aQuery.Free;
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

procedure TMainWindow.Klasseneinteilung1Click(Sender: TObject);
var
  aDialog: TFormParameterLandeswertung;
begin
  aDialog := TFormParameterLandeswertung.create(nil);
  try
    aDialog.setConnection(DBConnection);
    if aDialog.ShowModal = mrOK then
    begin

      frxReport.LoadFromFile('..\Reports\Klasseneinteilung.fr3');
      frxReport.Variables[' ' + 'ArComp'] := Null;
      frxReport.Variables['TU_ID']        := quotedStr(FTU_ID);

      frxReport.Variables['MIT_LANDESWERTUNG']  := boolToInt(aDialog.MitLAndeswertung);
      frxReport.Variables['OHNE_LANDESWERTUNG'] := boolToInt(aDialog.OhneLAndeswertung);

      //frxReport.DesignReport();
      frxReport.ShowReport(true);
    end;
  finally
    aDialog.Free;
  end;
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
  FBL_Finale.fillComboFinale(comboFinale, FTU_ID);
  FBL_Finale.fillComboFinaleBogenkategorie(comboFinaleBogenkategorie, FTU_ID);
  FBL_Finale.fillComboFinaleAlterskategorie(comboFinalealterskategorie, FTU_ID, comboFinaleBogenkategorie.Text);
  FBL_Finale.fillComboFinaleGeschlecht(comboFinaleGeschlecht, FTU_ID, comboFinaleBogenkategorie.Text,
    comboFinalealterskategorie.Text);

  TARC_DAL_Teamwertung.selectVereine(queryVerein);
  queryVerein.Open;
  TARC_Tools.fillComboFromQuery(comboVerein, queryVerein, 'VE_ID', 'VE_NAME');

  TARC_DAL_Teamwertung.selectBogenkategorien(queryBogenkategorie);
  queryBogenkategorie.Open;
  TARC_Tools.fillComboFromQuery(comboBogenKategorie, queryBogenkategorie, 'BK_ID', 'BK_NAME');
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
    TARC_Tools.autoSizeColumns(querySelectPersonen, gridTeilnehmer);
  end;
end;

procedure TMainWindow.searchPersonenNichtZugeteilt(searchString: string);
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
  TARC_Tools.autoSizeColumns(queryScheibeneinteilungNichtZugeteilt, gridNichtZugeteilt);
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
    TARC_Tools.autoSizeColumns(queryScheibeneinteilungZugeteilt, gridZugeteilt);
  end;
end;

procedure TMainWindow.selectScores();
var
  aScheibe      : Integer;
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

procedure TMainWindow.urniere1Click(Sender: TObject);
var
  aDialog: TFormTurnierListe;
begin
  aDialog := TFormTurnierListe.create(nil);
  try
    //aDialog.Parent := self;
    aDialog.setConnection(DBConnection);
    aDialog.DataState := dsEditMode;
    aDialog.ShowModal;
  finally
    aDialog.Free;
  end;
end;

procedure TMainWindow.urnierteilnehmer1Click(Sender: TObject);
var
  aDialog: TFormParameterLandeswertung;
begin
  aDialog := TFormParameterLandeswertung.create(nil);
  try
    aDialog.setConnection(DBConnection);
    if aDialog.ShowModal = mrOK then
    begin

      frxReport.LoadFromFile('..\Reports\Turnierteilnehmer.fr3');
      frxReport.Variables[' ' + 'ArComp'] := Null;
      frxReport.Variables['TU_ID']        := quotedStr(FTU_ID);

      frxReport.Variables['MIT_LANDESWERTUNG']  := boolToInt(aDialog.MitLAndeswertung);
      frxReport.Variables['OHNE_LANDESWERTUNG'] := boolToInt(aDialog.OhneLAndeswertung);

      //frxReport.DesignReport();
      frxReport.ShowReport(true);
    end;
  finally
    aDialog.Free;
  end;
end;

procedure TMainWindow.urnierteilnehmermitScheibe1Click(Sender: TObject);
var
  aDialog: TFormParameterLandeswertung;
begin
  aDialog := TFormParameterLandeswertung.create(nil);
  try
    aDialog.setConnection(DBConnection);
    if aDialog.ShowModal = mrOK then
    begin

      frxReport.LoadFromFile('..\Reports\Turnierteilnehmer_mit_Scheibe.fr3');
      frxReport.Variables[' ' + 'ArComp'] := Null;
      frxReport.Variables['TU_ID']        := quotedStr(FTU_ID);

      frxReport.Variables['MIT_LANDESWERTUNG']  := boolToInt(aDialog.MitLAndeswertung);
      frxReport.Variables['OHNE_LANDESWERTUNG'] := boolToInt(aDialog.OhneLAndeswertung);

      //frxReport.DesignReport();
      frxReport.ShowReport(true);
    end;
  finally
    aDialog.Free;
  end;
end;

procedure TMainWindow.urnierteilnehmernachKlasse1Click(Sender: TObject);
var
  aDialog: TFormParameterLandeswertung;
begin
  aDialog := TFormParameterLandeswertung.create(nil);
  try
    aDialog.setConnection(DBConnection);
    if aDialog.ShowModal = mrOK then
    begin

      frxReport.LoadFromFile('..\Reports\Turnierteilnehmer_nach_Klasse.fr3');
      frxReport.Variables[' ' + 'ArComp'] := Null;
      frxReport.Variables['TU_ID']        := quotedStr(FTU_ID);

      frxReport.Variables['MIT_LANDESWERTUNG']  := boolToInt(aDialog.MitLAndeswertung);
      frxReport.Variables['OHNE_LANDESWERTUNG'] := boolToInt(aDialog.OhneLAndeswertung);

      //frxReport.DesignReport();
      frxReport.ShowReport(true);
    end;
  finally
    aDialog.Free;
  end;
end;

procedure TMainWindow.saveScore();
var
  aPE_ID : string;
  aSC_ID : string;
  aRunde : Integer;
  aScore : Integer;
  aZehner: Integer;
  aNeuner: Integer;
  aX     : Integer;
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

procedure TMainWindow.Scheibeneinteilung1Click(Sender: TObject);
var
  aDialog: TFormParameterLandeswertung;
begin
  aDialog := TFormParameterLandeswertung.create(nil);
  try
    aDialog.setConnection(DBConnection);
    if aDialog.ShowModal = mrOK then
    begin

      frxReport.LoadFromFile('..\Reports\Scheibeneinteilung.fr3');
      frxReport.Variables[' ' + 'ArComp'] := Null;
      frxReport.Variables['TU_ID']        := quotedStr(FTU_ID);

      frxReport.Variables['MIT_LANDESWERTUNG']  := boolToInt(aDialog.MitLAndeswertung);
      frxReport.Variables['OHNE_LANDESWERTUNG'] := boolToInt(aDialog.OhneLAndeswertung);

      //frxReport.DesignReport();
      frxReport.ShowReport(true);
    end;
  finally
    aDialog.Free;
  end;
end;

procedure TMainWindow.ScheibeneinteilungUebersichtClick(Sender: TObject);
begin
  frxReport.LoadFromFile('..\Reports\Scheibeneinteilung Übersicht.fr3');
  frxReport.Variables[' ' + 'ArComp'] := Null;
  frxReport.Variables['TU_ID']        := quotedStr(FTU_ID);

  frxReport.ShowReport(true);
end;

procedure TMainWindow.Scorekarten1Click(Sender: TObject);
begin
  frxReport.LoadFromFile('..\Reports\Scoreblatt.fr3');
  frxReport.Variables[' ' + 'ArComp'] := Null;
  frxReport.Variables['TU_ID']        := quotedStr(FTU_ID);
  frxReport.Variables['SCHEIBE']      := 0;

  //frxReport.DesignReport();
  frxReport.ShowReport(true);
end;

procedure TMainWindow.ScorekartenBlanko1Click(Sender: TObject);
begin
  frxReport.LoadFromFile('..\Reports\Scoreblatt_blanco.fr3');
  frxReport.Variables[' ' + 'ArComp'] := Null;
  frxReport.Variables['TU_ID']        := quotedStr(FTU_ID);

  //frxReport.DesignReport();
  frxReport.ShowReport(true);
end;

end.
