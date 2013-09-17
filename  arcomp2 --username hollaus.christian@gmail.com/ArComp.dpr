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
  ARC_TurnierDetail in 'dfm\ARC_TurnierDetail.pas' {FormTurnierDetail},
  ARC_Distanzen in 'dfm\ARC_Distanzen.pas' {FormDistanzen},
  ARC_DAL_Distanz in 'pas\DAL\ARC_DAL_Distanz.pas',
  ARC_DAL_Tools in 'pas\DAL\ARC_DAL_Tools.pas',
  ARC_Finalberechtigungen in 'dfm\ARC_Finalberechtigungen.pas' {FormFinalberechtigung},
  ARC_DAL_Finalberechtigungen in 'pas\DAL\ARC_DAL_Finalberechtigungen.pas',
  ARC_BL_Turnier in 'pas\BL\ARC_BL_Turnier.pas',
  ARC_DAL_Turnier in 'pas\DAL\ARC_DAL_Turnier.pas',
  ARC_DAL_SETUP in 'pas\DAL\ARC_DAL_SETUP.pas',
  ARC_ParameterRangliste in 'dfm\Parameter\ARC_ParameterRangliste.pas' {FormParameterRangliste},
  ARC_DAL_ParameterRangliste in 'pas\DAL\ARC_DAL_ParameterRangliste.pas',
  ARC_DAL_Person in 'pas\DAL\ARC_DAL_Person.pas',
  ARC_ParameterLandeswertung in 'dfm\Parameter\ARC_ParameterLandeswertung.pas' {FormParameterLandeswertung};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TMainWindow, MainWindow);
  Application.Run;
end.
