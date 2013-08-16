///<summary>
///Unit CPA_ImportGemeindekennziffer
///</summary>
///<remarks>
///(C) Copyright 2011, CP Solutions - All Rights Reserved.
///</remarks>

unit ARC_ImportCsvPersonen;

interface

uses

  Windows,
  SysUtils,
  Classes,
  StrUtils,
  Variants,
  Forms,
  DB,
  StdCtrls,
  ComCtrls,
  Mask,
  Controls,
  Math,
  DBGrids,
  Grids,
  ExtCtrls,
  DateUtils,
  Menus,
  vcl.Dialogs,
  ImgList,
  Data.Win.ADODB,

  //ArComp
  ARC_Functions,
  ARC_Types,
  ARC_Importpersonen;

type
  TARC_ImportCsvPersonen = class(TObject)

  private
    procedure parseAndAppendRow(query: TAdoQuery; toAppend: string);

  public
    constructor Create();
    destructor Destroy; override;

    function Import(connection: TADOConnection; progressBar: TProgressBar): boolean;

  end;

implementation

constructor TARC_ImportCsvPersonen.Create();
begin
  inherited Create;
end;

destructor TARC_ImportCsvPersonen.Destroy;
begin
  inherited Destroy;
end;

function TARC_ImportCsvPersonen.Import(connection: TADOConnection; progressBar: TProgressBar): boolean;
var
  aRowList   : tStringList;
  i          : integer;
  aOpenDialog: TOpenDialog;
  aDialog    : TFormImportPersonen;
  aQuery     : TAdoQuery;
begin
  aOpenDialog        := TOpenDialog.Create(nil);
  aOpenDialog.Filter := 'CSV|*.csv';

  if aOpenDialog.Execute then
  begin
    aRowList := tStringList.Create;
    aQuery   := TAdoQuery.Create(nil);
    aDialog  := TFormImportPersonen.Create(nil);
    try
      aDialog.setProgressbar(progressBar);
      aQuery.connection    := connection;
      i                    := 0;
      progressBar.Min      := 0;
      progressBar.Position := i;
      aRowList.LoadFromFile(aOpenDialog.FileName);
      progressBar.Max     := aRowList.Count;
      progressBar.Visible := true;
      aDialog.Show;
      while (i < aRowList.Count - 1) do
      begin
        parseAndAppendRow(aQuery, aRowList[i]);
        progressBar.Position := i;
        inc(i);
      end;
      if aQuery.SQL.Count > 0 then
      begin
        aQuery.ExecSQL;
      end;

      aDialog.Close;
      result := true;
    finally
      aRowList.Free;
      aQuery.Free;
      aDialog.Free;
    end;
  end
  else
  begin
    result := false;
  end;

end;

procedure TARC_ImportCsvPersonen.parseAndAppendRow(query: TAdoQuery; toAppend: string);
var
  aRow          : string;
  aSplit        : TExplodeArray;
  aStringBuilder: TStringBuilder;

  aNachname     : string;
  aVorname      : string;
  aLand         : string;
  aBundesland   : string;
  aBogenklasse  : string;
  aAltersklasse : string;
  aVerein       : string;
  aGeschlecht   : string;
  aLizenz       : boolean;
  aLandeswertung: boolean;
  aGeburtsdatum : string;
begin
  aSplit := Explode(';', toAppend);
  if length(aSplit) = 11 then
  begin
    aNachname      := aSplit[0];
    aVorname       := aSplit[1];
    aLand          := aSplit[2];
    aBundesland    := aSplit[3];
    aBogenklasse   := aSplit[4];
    aAltersklasse  := aSplit[5];
    aVerein        := aSplit[6];
    aGeschlecht    := aSplit[7];
    aLizenz        := strtobool(aSplit[8]);
    aLandeswertung := strtobool(aSplit[9]);
    aGeburtsdatum  := aSplit[10];

    aStringBuilder := TStringBuilder.Create;
    try
      aStringBuilder.Append('INSERT INTO PERSON(');
      aStringBuilder.AppendLine();
      aStringBuilder.Append('  PE_ID,');
      aStringBuilder.AppendLine();
      aStringBuilder.Append('  PE_VORNAME,');
      aStringBuilder.AppendLine();
      aStringBuilder.Append('  PE_NACHNAME,');
      aStringBuilder.AppendLine();
      aStringBuilder.Append('  PE_NATION,');
      aStringBuilder.AppendLine();
      aStringBuilder.Append('  PE_BUNDESLAND,');
      aStringBuilder.AppendLine();
      aStringBuilder.Append('  PE_BOGENKATEGORIE,');
      aStringBuilder.AppendLine();
      aStringBuilder.Append('  PE_ALTERSKLASSE,');
      aStringBuilder.AppendLine();
      aStringBuilder.Append('  PE_VEREIN,');
      aStringBuilder.AppendLine();
      aStringBuilder.Append('  PE_GEBURTSDATUM,');
      aStringBuilder.AppendLine();
      aStringBuilder.Append('  PE_GESCHLECHT,');
      aStringBuilder.AppendLine();
      aStringBuilder.Append('  PE_LIZENZ,');
      aStringBuilder.AppendLine();
      aStringBuilder.Append('  PE_LANDESWERTUNG');
      aStringBuilder.AppendLine();
      aStringBuilder.Append(')');
      aStringBuilder.AppendLine();
      aStringBuilder.Append('VALUES(');
      aStringBuilder.AppendLine();
      aStringBuilder.Append('  newID(),');
      aStringBuilder.AppendLine();
      aStringBuilder.Append('  ' + quotedStr(aVorname) + ',');
      aStringBuilder.AppendLine();
      aStringBuilder.Append('  ' + quotedStr(aNachname) + ',');
      aStringBuilder.AppendLine();
      aStringBuilder.Append('  ' + quotedStr(aLand) + ',');
      aStringBuilder.AppendLine();
      aStringBuilder.Append('  ' + quotedStr(aBundesland) + ',');
      aStringBuilder.AppendLine();
      aStringBuilder.Append('  ' + quotedStr(aBogenklasse) + ',');
      aStringBuilder.AppendLine();
      aStringBuilder.Append('  ' + quotedStr(aAltersklasse) + ',');
      aStringBuilder.AppendLine();
      aStringBuilder.Append('  ' + quotedStr(aVerein) + ',');
      aStringBuilder.AppendLine();
      aStringBuilder.Append('  CONVERT(dateTime,' + quotedStr(aGeburtsdatum) + ',104),');
      aStringBuilder.AppendLine();
      aStringBuilder.Append('  ' + quotedStr(aGeschlecht) + ',');
      aStringBuilder.AppendLine();
      aStringBuilder.Append('  ' + inttostr(booltoInt(aLizenz)) + ',');
      aStringBuilder.AppendLine();
      aStringBuilder.Append('  ' + inttostr(booltoInt(aLandeswertung)));
      aStringBuilder.AppendLine();
      aStringBuilder.Append(')');
      aStringBuilder.AppendLine();
      aStringBuilder.AppendLine();

      query.SQL.Add(aStringBuilder.ToString);
    finally
      aStringBuilder.Free;
    end;
  end;
end;

end.
