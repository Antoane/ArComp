unit ARC_ParameterLandeswertung;

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
  TFormParameterLandeswertung = class(TForm)
    Panel2: TPanel;
    Panel4: TPanel;
    buttonCancel: TButton;
    labelCaption: TLabel;
    ImageList: TImageList;
    buttonOK: TButton;
    Panel5: TPanel;
    checkMitLandeswertung: TCheckBox;
    checkOhneLandeswertung: TCheckBox;
    procedure buttonCancelClick(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);

  private
    FMitLandeswertung : boolean;
    FOhneLandeswertung: boolean;
    FConnection       : Tadoconnection;
    FDataState        : TDataState;
    procedure setProps;

    {Private-Deklarationen}
  public
    constructor Create(aOwner: TComponent);
    destructor Destroy; override;
    procedure setConnection(connection: Tadoconnection);
    {Public-Deklarationen}

    property MitLandeswertung: boolean
      read   FMitLandeswertung;

    property OhneLandeswertung: boolean
      read   FOhneLandeswertung;
  end;

implementation

{$R *.dfm}

procedure TFormParameterLandeswertung.buttonCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  self.CloseModal;
end;

procedure TFormParameterLandeswertung.buttonOKClick(Sender: TObject);
begin
  setProps;
  self.ModalResult := mrOk;
  self.CloseModal;
end;

constructor TFormParameterLandeswertung.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
end;

destructor TFormParameterLandeswertung.Destroy;
begin

  inherited;
end;

procedure TFormParameterLandeswertung.setConnection(connection: Tadoconnection);
begin
  FConnection := connection;
end;

procedure TFormParameterLandeswertung.setProps;
begin
  FMitLandeswertung  := checkMitLandeswertung.checked;
  FOhneLandeswertung := checkOhneLandeswertung.checked;
end;

end.
