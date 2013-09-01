unit ARC_PersonenDetail;

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
  Vcl.ImgList;

type
  TFormPersonenDetail = class(TForm)
    queryPerson: TADOQuery;
    panelMain: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    editNachname: TDBEdit;
    Label2: TLabel;
    dataSource: TDataSource;
    editLand: TDBEdit;
    Label3: TLabel;
    editBundesland: TDBEdit;
    Label7: TLabel;
    editVorname: TDBEdit;
    Label8: TLabel;
    comboAlterskategorie: TDBComboBox;
    Label4: TLabel;
    comboBogenkategorie: TDBComboBox;
    Label5: TLabel;
    Label6: TLabel;
    editGeburtsdatum: TDBEdit;
    Label9: TLabel;
    comboGeschlecht: TDBComboBox;
    checkLandeswertung: TDBCheckBox;
    checkLizenz: TDBCheckBox;
    buttonOK: TButton;
    buttonCancel: TButton;
    buttonSave: TButton;
    updatePerson: TADOQuery;
    Label10: TLabel;
    comboVerein: TDBComboBox;
    checkInTurnierUebernehmen: TCheckBox;
    Label11: TLabel;
    ImageList: TImageList;
    procedure FormShow(Sender: TObject);
    procedure buttonSaveClick(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);

  private
    {Private-Deklarationen}
    FPE_ID: string;
    procedure loadData;
    function saveData: boolean;
    function getInTurnierUebernehmen: boolean;
    procedure setInTurnierUebernehmen(const Value: boolean);

  public
    constructor create(owner: TComponent; connection: TADOConnection; PE_ID: string);
    {Public-Deklarationen}

    property inTurnierUebernehmen: boolean
      read   getInTurnierUebernehmen
      write  setInTurnierUebernehmen;
  end;

var
  FormPersonenDetail: TFormPersonenDetail;

implementation

{$R *.dfm}

procedure TFormPersonenDetail.buttonCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  self.CloseModal;
end;

procedure TFormPersonenDetail.buttonOKClick(Sender: TObject);
begin
  if saveData() then
  begin
    ModalResult := mrOk;
    self.CloseModal;
  end;
end;

procedure TFormPersonenDetail.buttonSaveClick(Sender: TObject);
begin
  saveData();
end;

constructor TFormPersonenDetail.create(owner: TComponent; connection: TADOConnection; PE_ID: string);
begin
  inherited create(owner);
  queryPerson.connection  := connection;
  updatePerson.connection := connection;
  FPE_ID                  := PE_ID;
end;

procedure TFormPersonenDetail.FormShow(Sender: TObject);
begin
  loadData();
end;

function TFormPersonenDetail.getInTurnierUebernehmen: boolean;
begin
  result := checkInTurnierUebernehmen.Checked;
end;

procedure TFormPersonenDetail.loadData();
begin
  TARC_Tools.fillDBComboFromTable(comboAlterskategorie, 'ALTERSKATEGORIE', 'AK_ID', 'AK_NAME', queryPerson.connection);
  TARC_Tools.fillDBComboFromTable(comboBogenkategorie, 'BOGENKATEGORIE', 'BK_ID', 'BK_NAME', queryPerson.connection);
  TARC_Tools.fillDBComboFromTable(comboVerein, 'VEREIN', 'VE_ID', 'VE_NAME', queryPerson.connection);
  TARC_Tools.fillDBComboFromTable(comboGeschlecht, 'GESCHLECHT', 'GE_ID', 'GE_NAME', queryPerson.connection);

  queryPerson.Parameters.ParseSQL(queryPerson.SQL.Text, True);
  queryPerson.Parameters.ParamByName('ID').Value := FPE_ID;
  queryPerson.Active                             := True;
  queryPerson.Open;
end;

function TFormPersonenDetail.saveData: boolean;
var
  aDate: TDateTime;
begin
  result := True;
  if TryStrToDate(editGeburtsdatum.Text, aDate) then
  begin

    updatePerson.Parameters.ParseSQL(updatePerson.SQL.Text, True);
    with updatePerson.Parameters do
    begin
      ParamByName('PE_VORNAME').Value        := editVorname.Text;
      ParamByName('PE_NACHNAME').Value       := editNachname.Text;
      ParamByName('PE_NATION').Value         := editLand.Text;
      ParamByName('PE_BUNDESLAND').Value     := editBundesland.Text;
      ParamByName('PE_BOGENKATEGORIE').Value := comboBogenkategorie.Text;
      ParamByName('PE_ALTERSKLASSE').Value   := comboAlterskategorie.Text;
      ParamByName('PE_GEBURTSDATUM').Value   := editGeburtsdatum.Text;
      ParamByName('PE_GESCHLECHT').Value     := comboGeschlecht.Text;
      ParamByName('PE_LIZENZ').Value         := boolToInt(checkLizenz.Checked);
      ParamByName('PE_LANDESWERTUNG').Value  := boolToInt(checkLandeswertung.Checked);
      ParamByName('ID').Value                := FPE_ID;
      ParamByName('VE_ID').Value := TARC_DAL_DbUpdate.getVereinID(queryPerson.connection, comboVerein.Text);
    end;
    updatePerson.ExecSQL;

    TARC_DAL_DbUpdate.updateBogenkategorien(updatePerson.connection);
    TARC_DAL_DbUpdate.updateAlterskategorien(updatePerson.connection);
    TARC_DAL_DbUpdate.updateGeschlecht(updatePerson.connection);

  end
  else
  begin
    MessageDlg('bitte geben Sie ein gültiges Geburtsdatum ein.', mtError, [mbOK], 0);
    editGeburtsdatum.SetFocus;
    result := false;
  end;

end;

procedure TFormPersonenDetail.setInTurnierUebernehmen(const Value: boolean);
begin
  checkInTurnierUebernehmen.Checked := Value;
  checkInTurnierUebernehmen.Visible := Value;
end;

end.
