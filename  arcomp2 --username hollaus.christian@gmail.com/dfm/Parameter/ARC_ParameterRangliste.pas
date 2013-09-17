unit ARC_ParameterRangliste;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.ExtCtrls,
  Data.DB,
  Data.Win.ADODB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.DBCtrls,
  Vcl.StdCtrls,
  Bde.DBTables,
  Vcl.ImgList,
  dialogs,
  frxDesgn,
  frxClass,
  frxVariables,
  frxADOComponents,

  //ARComp
  ARC_PersonenDetail,
  ARC_DAL_ParameterRangliste,
  ARC_Functions,
  ARC_Tools,
  ARC_Types,
  ARC_DbGrid;

type
  TFormParameterRangliste = class(TForm)
    Panel2: TPanel;
    Panel4: TPanel;
    buttonCancel: TButton;
    labelCaption: TLabel;
    ImageList: TImageList;
    buttonOK: TButton;
    Panel5: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label9: TLabel;
    comboAlterskategorie: TComboBox;
    comboBogenkategorie: TComboBox;
    comboGeschlecht: TComboBox;
    checkAlterskategorie: TCheckBox;
    checkBogenkategorie: TCheckBox;
    checkGeschlecht: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);
    procedure comboAlterskategorieChange(Sender: TObject);
    procedure comboBogenkategorieChange(Sender: TObject);
    procedure comboGeschlechtChange(Sender: TObject);
    procedure checkAlterskategorieClick(Sender: TObject);
    procedure checkBogenkategorieClick(Sender: TObject);
    procedure checkGeschlechtClick(Sender: TObject);

  private
    FBogenkategorie : string;
    FAlterskategorie: string;
    FGeschlecht     : string;
    FConnection     : Tadoconnection;
    FselectedIDs    : TStringList;
    FDataState      : TDataState;
    FRangliste      : TADOQuery;
    procedure setProps;
    function getAlterskategorie: string;
    function getBogenkategorien: string;
    function getGeschlecht: string;

    {Private-Deklarationen}
  public
    constructor Create(aOwner: TComponent);
    destructor Destroy; override;
    procedure setConnection(connection: Tadoconnection);
    {Public-Deklarationen}

    property Rangliste: TADOQuery
      read   FRangliste
      write  FRangliste;

    property Bogenkategorien: string
      read   getBogenkategorien;

    property Alterskategorien: string
      read   getAlterskategorie;

    property Geschlecht: string
      read   getGeschlecht;
  end;

implementation

{$R *.dfm}

procedure TFormParameterRangliste.buttonCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  self.CloseModal;
end;

procedure TFormParameterRangliste.buttonOKClick(Sender: TObject);
begin
  setProps;
  self.ModalResult := mrOk;
  self.CloseModal;
end;

procedure TFormParameterRangliste.checkAlterskategorieClick(Sender: TObject);
begin
  if checkAlterskategorie.Checked then
  begin
    comboAlterskategorie.ItemIndex := 0;
  end;
end;

procedure TFormParameterRangliste.checkBogenkategorieClick(Sender: TObject);
begin
  if checkBogenkategorie.Checked then
  begin
    comboBogenkategorie.ItemIndex := 0;
  end;
end;

procedure TFormParameterRangliste.checkGeschlechtClick(Sender: TObject);
begin
  if checkGeschlecht.Checked then
  begin
    comboGeschlecht.ItemIndex := 0;
  end;
end;

procedure TFormParameterRangliste.comboAlterskategorieChange(Sender: TObject);
begin
  checkAlterskategorie.Checked := (comboAlterskategorie.Text = '');
end;

procedure TFormParameterRangliste.comboBogenkategorieChange(Sender: TObject);
begin
  checkBogenkategorie.Checked := (comboBogenkategorie.Text = '');
end;

procedure TFormParameterRangliste.comboGeschlechtChange(Sender: TObject);
begin
  checkGeschlecht.Checked := (comboGeschlecht.Text = '');
end;

procedure TFormParameterRangliste.FormShow(Sender: TObject);
begin
  TARC_Tools.fillComboFromTable(comboAlterskategorie, 'ALTERSKATEGORIE', 'AK_ID', 'AK_NAME', FConnection);
  TARC_Tools.fillComboFromTable(comboBogenkategorie, 'BOGENKATEGORIE', 'BK_ID', 'BK_NAME', FConnection);
  TARC_Tools.fillComboFromTable(comboGeschlecht, 'GESCHLECHT', 'GE_ID', 'GE_NAME', FConnection);
end;

function TFormParameterRangliste.getAlterskategorie: string;
begin
  result := FAlterskategorie;
end;

function TFormParameterRangliste.getBogenkategorien: string;
begin
  result := FBogenkategorie;
end;

function TFormParameterRangliste.getGeschlecht: string;
begin
  result := FGeschlecht;
end;

constructor TFormParameterRangliste.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
end;

destructor TFormParameterRangliste.Destroy;
begin

  inherited;
end;

procedure TFormParameterRangliste.setConnection(connection: Tadoconnection);
begin
  FConnection := connection;
end;

procedure TFormParameterRangliste.setProps;
begin
  if not checkAlterskategorie.Checked then
  begin
    FAlterskategorie := comboAlterskategorie.Text;
  end
  else
  begin
    FAlterskategorie := '';
  end;

  if not checkBogenkategorie.Checked then
  begin
    FBogenkategorie := comboBogenkategorie.Text;
  end
  else
  begin
    FBogenkategorie := '';
  end;

  if not checkGeschlecht.Checked then
  begin
    FGeschlecht := comboGeschlecht.Text;
  end
  else
  begin
    FGeschlecht := '';
  end;

end;

end.
