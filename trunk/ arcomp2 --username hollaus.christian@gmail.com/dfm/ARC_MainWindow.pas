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
  ARC_Personenliste,
  ARC_ImportPersonen,
  ARC_VereinListe,
  ARC_Turnierliste;

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
    procedure Beenden1Click(Sender: TObject);
    procedure Importieren1Click(Sender: TObject);
    procedure Bogenschtzen1Click(Sender: TObject);
    procedure Vereine1Click(Sender: TObject);
    procedure ffnen1Click(Sender: TObject);

  private
    procedure openCSVImportDialog;
    procedure openPersonenliste;
    procedure openVereinsListe;
    procedure openTurnierliste;

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

procedure TMainWindow.ffnen1Click(Sender: TObject);
begin
  openTurnierliste();
end;

procedure TMainWindow.openTurnierliste;
var
  aDialog: TFormTurnierListe;
begin
  aDialog := TFormTurnierListe.Create(nil);
  try
    //aDialog.Parent := self;
    aDialog.setConnection(DBConnection);
    if (aDialog.ShowModal = mrOK) then
    begin
      //
    end;
  finally
    //aDialog.Free;
  end;
end;

procedure TMainWindow.openPersonenliste;
var
  aDialog: TFormPersonenListe;
begin
  aDialog := TFormPersonenListe.Create(nil);
  try
    //aDialog.Parent := self;
    aDialog.setConnection(DBConnection);
    aDialog.Show;
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
  aDialog := TFormVereinsListe.Create(nil);
  try
    //aDialog.Parent := self;
    aDialog.setConnection(DBConnection);
    aDialog.Show;
  finally
    //aDialog.Free;
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
  aImport := TFormImportPersonen.Create(self);
  aImport.setConnection(DBConnection);
  aImport.Show;
end;

end.
