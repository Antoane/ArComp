program ArComp;

uses
  Vcl.Forms,
  System.SysUtils,
  ARC_Personenliste in 'dfm\ARC_Personenliste.pas' {FormPersonenListe},
  ARC_MainWindow in 'dfm\ARC_MainWindow.pas' {MainWindow},
  ARC_ImportPersonen in 'dfm\ARC_ImportPersonen.pas' {FormImportPersonen},
  ARC_ImportCsvPersonen in 'pas\ARC_ImportCsvPersonen.pas',
  ARC_Functions in 'pas\ARC_Functions.pas',
  ARC_Types in 'pas\ARC_Types.pas',
  ARC_DbGrid in 'components\ARC_DbGrid.pas',
  ARC_PersonenDetail in 'dfm\ARC_PersonenDetail.pas' {FormPersonenDetail},
  ARC_Tools in 'pas\ARC_Tools.pas',
  ARC_DAL_DbUpdate in 'pas\DAL\ARC_DAL_DbUpdate.pas',
  ARC_VereinListe in 'dfm\ARC_VereinListe.pas' {FormVereinsListe},
  ARC_Turnierliste in 'dfm\ARC_Turnierliste.pas' {FormTurnierListe},
  ARC_TurnierDetail in 'dfm\ARC_TurnierDetail.pas' {FormTurnierDetail};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TMainWindow, MainWindow);
  Application.CreateForm(TFormTurnierListe, FormTurnierListe);
  Application.CreateForm(TFormTurnierDetail, FormTurnierDetail);
  Application.Run;

  //Application.CreateForm(TFormPersonenDetail, FormPersonenDetail);
  //Application.CreateForm(TFormVereinsListe, FormVereinsListe);
  //Application.CreateForm(TFormImportPersonen, FormImportPersonen);
  //Application.CreateForm(TForm1, Form1);

end.
