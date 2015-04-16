unit ARC_Distanzen;

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
  ARC_DAL_Distanz,
  Vcl.ImgList,
  Vcl.Grids,
  Vcl.DBGrids;

type
  TFormDistanzen = class(TForm)
    queryDistanz: TADOQuery;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    dataSource: TDataSource;
    buttonCancel: TButton;
    queryUpdate: TADOQuery;
    gridDistanzen: TDBGrid;
    buttonAdd: TButton;
    buttonDelete: TButton;
    Panel5: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label9: TLabel;
    Label2: TLabel;
    comboAlterskategorie: TComboBox;
    comboBogenkategorie: TComboBox;
    comboGeschlecht: TComboBox;
    checkAlterskategorie: TCheckBox;
    checkBogenkategorie: TCheckBox;
    checkGeschlecht: TCheckBox;
    comboTurnierart: TComboBox;
    checkTurnierart: TCheckBox;
    queryInsert: TADOQuery;
    queryDelete: TADOQuery;
    ImageList: TImageList;
    procedure FormShow(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);
    procedure checkTurnierartClick(Sender: TObject);
    procedure checkAlterskategorieClick(Sender: TObject);
    procedure checkBogenkategorieClick(Sender: TObject);
    procedure checkGeschlechtClick(Sender: TObject);
    procedure comboTurnierartChange(Sender: TObject);
    procedure comboAlterskategorieChange(Sender: TObject);
    procedure comboBogenkategorieChange(Sender: TObject);
    procedure comboGeschlechtChange(Sender: TObject);
    procedure buttonAddClick(Sender: TObject);
    procedure buttonDeleteClick(Sender: TObject);
    procedure gridDistanzenDblClick(Sender: TObject);
    procedure gridDistanzenCellClick(Column: TColumn);
    procedure gridDistanzenTitleClick(Column: TColumn);

  private
    {Private-Deklarationen}
    procedure loadData;
    procedure selectDistanzen;
    procedure deleteSelected;
    procedure setFilter;

  public
    constructor create(owner: TComponent; connection: TADOConnection);
    {Public-Deklarationen}
  end;

var
  FormDistanzen: TFormDistanzen;

implementation

{$R *.dfm}

procedure TFormDistanzen.buttonAddClick(Sender: TObject);
var
  aDistanz    : integer;
  aDistanzText: string;
  aAuflage    : string;
  aSortierung : integer;
begin
  aDistanzText := InputBox('Neue Distanz', 'Bitte geben Sie die Distanz ein', '');
  if TryStrToInt(aDistanzText, aDistanz) then
  begin
    aAuflage    := '';
    aSortierung := 0;
    TARC_DAL_Distanz.insertDistanzen(queryInsert, comboTurnierart.Text, comboBogenkategorie.Text,
      comboAlterskategorie.Text, comboGeschlecht.Text, aDistanz, aAuflage, aSortierung);
    queryInsert.ExecSQL;
    selectDistanzen();
  end
  else
  begin
    MessageDlg('Keine gültige Distanz.', mtError, [mbOK], 0);
  end;
end;

procedure TFormDistanzen.buttonCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  self.CloseModal;
end;

procedure TFormDistanzen.buttonDeleteClick(Sender: TObject);
begin
  if MessageDlg
    ('Wollen Sie wirklich die gewählten Distanzen löschen? Dies inkludiert auch eventuell nachfolgende Runden!',
    mtWarning, mbOKCancel, 0) = mrOK then
  begin
    deleteSelected();
  end;
end;

procedure TFormDistanzen.deleteSelected;
var
  i: integer;
begin
  if gridDistanzen.SelectedRows.Count > 0 then
  begin
    queryDistanz.DisableControls;
    with gridDistanzen.dataSource.DataSet do
    begin
      for i := 0 to gridDistanzen.SelectedRows.Count - 1 do
      begin
        GotoBookmark(pointer(gridDistanzen.SelectedRows.Items[i]));
        queryDelete.Close;
        TARC_DAL_Distanz.deleteDistanz(queryDelete, queryDistanz.FieldByName('DI_ID').AsString);
        queryDelete.ExecSQL;
      end;
    end;
    queryDistanz.EnableControls;
    selectDistanzen();
  end;
end;

procedure TFormDistanzen.checkAlterskategorieClick(Sender: TObject);
begin
  if checkAlterskategorie.Checked then
  begin
    comboAlterskategorie.ItemIndex := 0;
    selectDistanzen();
  end;
end;

procedure TFormDistanzen.checkBogenkategorieClick(Sender: TObject);
begin
  if checkBogenkategorie.Checked then
  begin
    comboBogenkategorie.ItemIndex := 0;
    selectDistanzen();
  end;
end;

procedure TFormDistanzen.checkGeschlechtClick(Sender: TObject);
begin
  if checkGeschlecht.Checked then
  begin
    comboGeschlecht.ItemIndex := 0;
    selectDistanzen();
  end;
end;

procedure TFormDistanzen.checkTurnierartClick(Sender: TObject);
begin
  if checkTurnierart.Checked then
  begin
    comboTurnierart.ItemIndex := 0;
    selectDistanzen();
  end;
end;

procedure TFormDistanzen.comboAlterskategorieChange(Sender: TObject);
begin
  checkAlterskategorie.Checked := comboAlterskategorie.ItemIndex = 0;
  selectDistanzen();
end;

procedure TFormDistanzen.comboBogenkategorieChange(Sender: TObject);
begin
  checkBogenkategorie.Checked := comboBogenkategorie.ItemIndex = 0;
  selectDistanzen();
end;

procedure TFormDistanzen.comboGeschlechtChange(Sender: TObject);
begin
  checkGeschlecht.Checked := comboGeschlecht.ItemIndex = 0;
  selectDistanzen();
end;

procedure TFormDistanzen.comboTurnierartChange(Sender: TObject);
begin
  checkTurnierart.Checked := comboTurnierart.ItemIndex = 0;
  selectDistanzen();
end;

constructor TFormDistanzen.create(owner: TComponent; connection: TADOConnection);
begin
  inherited create(owner);
  queryDistanz.connection := connection;
  queryInsert.connection  := connection;
  queryDelete.connection  := connection;
  queryUpdate.connection  := connection;
end;

procedure TFormDistanzen.gridDistanzenCellClick(Column: TColumn);
var
  aDistanzText   : string;
  aDistanz       : integer;
  sort           : string;
  selectedIndex  : integer;
  aAuflage       : string;
  aSortierungText: string;
  aSortierung    : integer;
begin
  aDistanz    := queryDistanz.FieldByName('DI_DISTANZ').AsInteger;
  aAuflage    := queryDistanz.FieldByName('DI_AUFLAGE').AsString;
  aSortierung := queryDistanz.FieldByName('DI_SORTIERUNG').AsInteger;

  selectedIndex := queryDistanz.RecNo;
  sort          := queryDistanz.sort;

  if Column.FieldName = 'DI_DISTANZ' then
  begin
    aDistanzText := InputBox('Distanz ändern', 'Bitte geben Sie die Distanz ein', '');
    if TryStrToInt(aDistanzText, aDistanz) then
    begin
      queryUpdate.Close;
      TARC_DAL_Distanz.UpdateDistanz(queryUpdate, queryDistanz.FieldByName('DI_ID').AsString, aDistanz, aAuflage,
        aSortierung);
      queryUpdate.ExecSQL;
      selectDistanzen();
    end;
  end;

  if Column.FieldName = 'DI_AUFLAGE' then
  begin
    aAuflage := InputBox('Auflage ändern', 'Bitte geben Sie die Auflage ein', '');
    queryUpdate.Close;
    TARC_DAL_Distanz.UpdateDistanz(queryUpdate, queryDistanz.FieldByName('DI_ID').AsString, aDistanz, aAuflage,
      aSortierung);
    queryUpdate.ExecSQL;
    selectDistanzen();
  end;

  if Column.FieldName = 'DI_SORTIERUNG' then
  begin
    aSortierungText := InputBox('Sortierung ändern', 'Bitte geben Sie die Sortierung ein', '');
    if TryStrToInt(aSortierungText, aSortierung) then
    begin
      queryUpdate.Close;
      TARC_DAL_Distanz.UpdateDistanz(queryUpdate, queryDistanz.FieldByName('DI_ID').AsString, aDistanz, aAuflage,
        aSortierung);
      queryUpdate.ExecSQL;
      selectDistanzen();
    end;
  end;

  queryDistanz.sort  := sort;
  queryDistanz.RecNo := selectedIndex;
end;

procedure TFormDistanzen.gridDistanzenDblClick(Sender: TObject);
begin
  setFilter();
end;

procedure TFormDistanzen.gridDistanzenTitleClick(Column: TColumn);
begin
  TARC_Tools.gridSort(gridDistanzen, Column);
end;

procedure TFormDistanzen.setFilter();
begin
  comboTurnierart.ItemIndex      := comboTurnierart.Items.IndexOf(queryDistanz.FieldByName('TA_NAME').AsString);
  comboAlterskategorie.ItemIndex := comboAlterskategorie.Items.IndexOf(queryDistanz.FieldByName('AK_NAME').AsString);
  comboBogenkategorie.ItemIndex  := comboBogenkategorie.Items.IndexOf(queryDistanz.FieldByName('BK_NAME').AsString);
  comboGeschlecht.ItemIndex      := comboGeschlecht.Items.IndexOf(queryDistanz.FieldByName('GE_NAME').AsString);

  checkTurnierart.Checked      := false;
  checkAlterskategorie.Checked := false;
  checkBogenkategorie.Checked  := false;
  checkGeschlecht.Checked      := false;

  selectDistanzen();
end;

procedure TFormDistanzen.FormShow(Sender: TObject);
begin
  loadData();
end;

procedure TFormDistanzen.loadData();
begin
  TARC_Tools.fillComboFromTable(comboTurnierart, 'TURNIERART', 'TA_ID', 'TA_NAME', queryDistanz.connection);
  TARC_Tools.fillComboFromTable(comboAlterskategorie, 'ALTERSKATEGORIE', 'AK_ID', 'AK_NAME', queryDistanz.connection);
  TARC_Tools.fillComboFromTable(comboBogenkategorie, 'BOGENKATEGORIE', 'BK_ID', 'BK_NAME', queryDistanz.connection);
  TARC_Tools.fillComboFromTable(comboGeschlecht, 'GESCHLECHT', 'GE_ID', 'GE_NAME', queryDistanz.connection);

  selectDistanzen();
end;

procedure TFormDistanzen.selectDistanzen;
begin
  queryDistanz.Close;
  TARC_DAL_Distanz.selectDistanzen(queryDistanz, comboTurnierart.Text, comboBogenkategorie.Text,
    comboAlterskategorie.Text, comboGeschlecht.Text);
  queryDistanz.Open;
  TARC_Tools.autoSizeColumns(queryDistanz, gridDistanzen);
end;

end.
