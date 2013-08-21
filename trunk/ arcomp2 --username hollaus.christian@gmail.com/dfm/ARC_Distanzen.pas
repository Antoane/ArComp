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
    buttonOK: TButton;
    buttonCancel: TButton;
    ImageList1: TImageList;
    buttonSave: TButton;
    updatePerson: TADOQuery;
    DBGrid1: TDBGrid;
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
    procedure FormShow(Sender: TObject);
    procedure buttonSaveClick(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);
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
    procedure DBGrid1DblClick(Sender: TObject);

  private
    {Private-Deklarationen}
    procedure loadData;
    function saveData: boolean;
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
begin
  aDistanzText := InputBox('Neue Distanz', 'Bitte geben Sie die Distanz ein', '');
  if TryStrToInt(aDistanzText, aDistanz) then
  begin
    TARC_DAL_Distanz.insertDistanzen(queryInsert, comboTurnierart.Text, comboBogenkategorie.Text,
      comboAlterskategorie.Text, comboGeschlecht.Text, aDistanz);
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
  deleteSelected();
end;

procedure TFormDistanzen.deleteSelected;
var
  i: integer;
begin
  if DBGrid1.SelectedRows.Count > 0 then
  begin
    queryDistanz.DisableControls;
    with DBGrid1.dataSource.DataSet do
    begin
      for i := 0 to DBGrid1.SelectedRows.Count - 1 do
      begin
        GotoBookmark(pointer(DBGrid1.SelectedRows.Items[i]));
        queryDelete.Close;
        TARC_DAL_Distanz.deleteDistanz(queryDelete, queryDistanz.FieldByName('DI_ID').AsString);
        queryDelete.ExecSQL;
      end;
    end;
    queryDistanz.EnableControls;
    selectDistanzen();
  end;
end;

procedure TFormDistanzen.buttonOKClick(Sender: TObject);
begin
  if saveData() then
  begin
    ModalResult := mrOk;
    self.CloseModal;
  end;
end;

procedure TFormDistanzen.buttonSaveClick(Sender: TObject);
begin
  saveData();
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
  updatePerson.connection := connection;
end;

procedure TFormDistanzen.DBGrid1DblClick(Sender: TObject);
begin
  setFilter();
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
  if queryDistanz.Active and (queryDistanz.RecordCount > 0) then
  begin
    queryDistanz.First;
  end;
end;

function TFormDistanzen.saveData: boolean;
var
  aDate: TDateTime;
begin
  result := True;

end;

end.
