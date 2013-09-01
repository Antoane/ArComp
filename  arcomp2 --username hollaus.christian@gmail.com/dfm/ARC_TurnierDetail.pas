unit ARC_TurnierDetail;

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
  TFormTurnierDetail = class(TForm)
    queryTurnier: TADOQuery;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    editBeginn: TDBEdit;
    Label2: TLabel;
    dataSource: TDataSource;
    editVeranstalter: TDBEdit;
    Label3: TLabel;
    editEnde: TDBEdit;
    Label7: TLabel;
    editTurniername: TDBEdit;
    Label8: TLabel;
    comboTurnierart: TDBComboBox;
    Label4: TLabel;
    Label6: TLabel;
    editTurnierleitung: TDBEdit;
    buttonOK: TButton;
    buttonCancel: TButton;
    buttonSave: TButton;
    updateTurnier: TADOQuery;
    Label10: TLabel;
    editSchiedsrichter: TDBEdit;
    Label5: TLabel;
    editAnzahlScheiben: TDBEdit;
    Label9: TLabel;
    editSchuetzenProScheibe: TDBEdit;
    ImageList: TImageList;
    procedure FormShow(Sender: TObject);
    procedure buttonSaveClick(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);

  private
    {Private-Deklarationen}
    FTU_ID: string;
    procedure loadData;
    function saveData: boolean;

  public
    constructor create(owner: TComponent; connection: TADOConnection; PE_ID: string);
    {Public-Deklarationen}
  end;

var
  FormTurnierDetail: TFormTurnierDetail;

implementation

{$R *.dfm}

procedure TFormTurnierDetail.buttonCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  self.CloseModal;
end;

procedure TFormTurnierDetail.buttonOKClick(Sender: TObject);
begin
  if saveData() then
  begin

    ModalResult := mrOk;
    self.CloseModal;
  end;
end;

procedure TFormTurnierDetail.buttonSaveClick(Sender: TObject);
begin
  saveData();
end;

constructor TFormTurnierDetail.create(owner: TComponent; connection: TADOConnection; PE_ID: string);
begin
  inherited create(owner);
  queryTurnier.connection  := connection;
  updateTurnier.connection := connection;
  FTU_ID                   := PE_ID;
end;

procedure TFormTurnierDetail.FormShow(Sender: TObject);
begin
  loadData();
end;

procedure TFormTurnierDetail.loadData();
begin
  TARC_Tools.fillDBComboFromTable(comboTurnierart, 'TURNIERART', 'TA_ID', 'TA_NAME', queryTurnier.connection);

  queryTurnier.Parameters.ParseSQL(queryTurnier.SQL.Text, True);
  queryTurnier.Parameters.ParamByName('ID').value := FTU_ID;
  queryTurnier.Active                             := True;
  queryTurnier.Open;
end;

function TFormTurnierDetail.saveData: boolean;
var
  aDate               : TDateTime;
  aScheibenanzahl     : integer;
  aSchuetzenProScheibe: integer;
begin
  result := True;
  if TryStrToDate(editBeginn.Text, aDate) and TryStrToDate(editEnde.Text, aDate) then
  begin
    if TryStrToInt(editAnzahlScheiben.Text, aScheibenanzahl) and TryStrToInt(editSchuetzenProScheibe.Text,
      aSchuetzenProScheibe) then
    begin
      updateTurnier.Parameters.ParseSQL(updateTurnier.SQL.Text, True);
      with updateTurnier.Parameters do
      begin
        ParamByName('TU_NAME').value                 := editTurniername.Text;
        ParamByName('TU_BEGINN').value               := editBeginn.Text;
        ParamByName('TU_ENDE').value                 := editEnde.Text;
        ParamByName('TU_VERANSTALTER').value         := editVeranstalter.Text;
        ParamByName('TU_TURNIERLEITUNG').value       := editTurnierleitung.Text;
        ParamByName('TU_SCHIEDSRICHTER').value       := editSchiedsrichter.Text;
        ParamByName('TU_SCHEIBENANZAHL').value       := aScheibenanzahl;
        ParamByName('TU_PERSONEN_PRO_SCHEIBE').value := aSchuetzenProScheibe;
        ParamByName('ID').value                      := FTU_ID;
        ParamByName('TA_ID').value := TARC_DAL_DbUpdate.getTurnierartID(queryTurnier.connection, comboTurnierart.Text);
      end;
      updateTurnier.ExecSQL;
    end
    else
    begin
      MessageDlg('bitte geben Sie eine gültige Scheibenanzahl / Schützenanzahl pro Scheibe ein.', mtError, [mbOK], 0);
      editSchuetzenProScheibe.SetFocus;
      result := false;
    end;
  end
  else
  begin
    MessageDlg('bitte geben Sie ein gültiges Start- und Enddatum ein.', mtError, [mbOK], 0);
    editBeginn.SetFocus;
    result := false;
  end;

end;

end.
