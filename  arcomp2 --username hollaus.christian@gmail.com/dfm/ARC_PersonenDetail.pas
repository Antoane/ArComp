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
    Panel2: TPanel;
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
    ImageList1: TImageList;
    buttonSave: TButton;
    updatePerson: TADOQuery;
    Label10: TLabel;
    comboVerein: TDBComboBox;
    procedure FormShow(Sender: TObject);
    procedure buttonSaveClick(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);

  private
    {Private-Deklarationen}
    FPE_ID: string;
    procedure loadData;
    procedure saveData;

  public
    constructor create(owner: TComponent; connection: TADOConnection; PE_ID: string);
    {Public-Deklarationen}
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
  saveData();
  ModalResult := mrOk;
  self.CloseModal;
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

procedure TFormPersonenDetail.loadData();
begin
  TARC_Tools.fillDBComboFromTable(comboAlterskategorie, 'ALTERSKATEGORIE', 'AK_ID', 'AK_NAME', queryPerson.connection);
  TARC_Tools.fillDBComboFromTable(comboBogenkategorie, 'BOGENKATEGORIE', 'BK_ID', 'BK_NAME', queryPerson.connection);
  TARC_Tools.fillDBComboFromTable(comboVerein, 'VEREIN', 'VE_ID', 'VE_NAME', queryPerson.connection);
  TARC_Tools.fillDBComboFromTable(comboGeschlecht, 'GESCHLECHT', 'GE_ID', 'GE_NAME', queryPerson.connection);

  queryPerson.Parameters.ParseSQL(queryPerson.SQL.Text, True);
  queryPerson.Parameters.ParamByName('ID').value := FPE_ID;
  queryPerson.Active                             := True;
  queryPerson.Open;
end;

procedure TFormPersonenDetail.saveData;
begin
  updatePerson.Parameters.ParseSQL(updatePerson.SQL.Text, True);
  with updatePerson.Parameters do
  begin
    ParamByName('PE_VORNAME').value        := editVorname.Text;
    ParamByName('PE_NACHNAME').value       := editNachname.Text;
    ParamByName('PE_NATION').value         := editLand.Text;
    ParamByName('PE_BUNDESLAND').value     := editBundesland.Text;
    ParamByName('PE_BOGENKATEGORIE').value := comboBogenkategorie.Text;
    ParamByName('PE_ALTERSKLASSE').value   := comboAlterskategorie.Text;
    ParamByName('PE_GEBURTSDATUM').value   := editGeburtsdatum.Text;
    ParamByName('PE_GESCHLECHT').value     := comboGeschlecht.Text;
    ParamByName('PE_LIZENZ').value         := boolToInt(checkLizenz.Checked);
    ParamByName('PE_LANDESWERTUNG').value  := boolToInt(checkLandeswertung.Checked);
    ParamByName('ID').value                := FPE_ID;
    ParamByName('VE_ID').value             := TARC_DAL_DbUpdate.getVereinID(queryPerson.connection, comboVerein.Text);
  end;
  updatePerson.ExecSQL;

  TARC_DAL_DbUpdate.updateBogenkategorien(updatePerson.connection);
  TARC_DAL_DbUpdate.updateAlterskategorien(updatePerson.connection);
  TARC_DAL_DbUpdate.updateGeschlecht(updatePerson.connection);

end;

end.
