program ArComp;

uses
  Vcl.Forms,
  ARC_Personenliste in 'dfm\ARC_Personenliste.pas' {FormPersonenListe},
  ARC_MainWindow in 'dfm\ARC_MainWindow.pas' {MainWindow},
  ARC_ImportPersonen in 'dfm\ARC_ImportPersonen.pas' {FormImportPersonen},
  ARC_ImportCsvPersonen in 'pas\ARC_ImportCsvPersonen.pas',
  ARC_Functions in 'pas\ARC_Functions.pas',
  ARC_Types in 'pas\ARC_Types.pas',
  ARC_DbGrid in 'components\ARC_DbGrid.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TMainWindow, MainWindow);
  //Application.CreateForm(TFormImportPersonen, FormImportPersonen);
  //   Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
