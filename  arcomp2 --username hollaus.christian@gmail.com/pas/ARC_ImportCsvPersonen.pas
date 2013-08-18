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
  ARC_DAL_DbUpdate;

type
  TARC_ImportCsvPersonen = class(TObject)

  private
    class procedure parseAndAppendRow(query: TAdoQuery; toAppend: string);
    class procedure getVereinID(var verein: string; const connection: TADOConnection); static;

  public
    constructor Create();
    destructor Destroy; override;

    class function Import(connection: TADOConnection; progressBar: TProgressBar): boolean;

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

class function TARC_ImportCsvPersonen.Import(connection: TADOConnection; progressBar: TProgressBar): boolean;
var
  aRowList   : tStringList;
  i          : integer;
  aOpenDialog: TOpenDialog;
  aQuery     : TAdoQuery;
begin
  aOpenDialog        := TOpenDialog.Create(nil);
  aOpenDialog.Filter := 'CSV|*.csv';

  if aOpenDialog.Execute then
  begin
    aRowList := tStringList.Create;
    aQuery   := TAdoQuery.Create(nil);
    try
      aQuery.connection    := connection;
      i                    := 0;
      progressBar.Min      := 0;
      progressBar.Position := i;
      aRowList.LoadFromFile(aOpenDialog.FileName);
      progressBar.Max     := aRowList.Count;
      progressBar.Visible := true;
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

      result := true;
    finally
      aRowList.Free;
      aQuery.Free;
    end;
  end
  else
  begin
    result := false;
  end;
  TARC_DAL_DbUpdate.updateBogenkategorien(connection);
  TARC_DAL_DbUpdate.updateAlterskategorien(connection);
  TARC_DAL_DbUpdate.updateGeschlecht(connection);
end;

class procedure TARC_ImportCsvPersonen.parseAndAppendRow(query: TAdoQuery; toAppend: string);
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

    getVereinID(aVerein, query.connection);

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
      aStringBuilder.Append('  VE_ID,');
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

class procedure TARC_ImportCsvPersonen.getVereinID(var verein: string; const connection: TADOConnection);
var
  aQuery: TAdoQuery;
  aGUID : string;
begin
  aQuery := TAdoQuery.Create(nil);
  try
    aQuery.connection := connection;

    with aQuery.SQL do
    begin
      Add('SELECT');
      Add('  VE_ID');
      Add('FROM VEREIN');
      Add('WHERE VE_NAME LIKE :NAME');
    end;

    aQuery.Parameters.ParseSQL(aQuery.SQL.Text, true);
    aQuery.Parameters.ParamByName('NAME').value := verein;
    aQuery.Active                               := true;
    aQuery.ExecSQL;

    if aQuery.RecordCount > 0 then
    begin
      verein := aQuery.FieldByName('VE_ID').AsString;
    end
    else
    begin
      aGUID         := newGUID();
      aQuery.Active := false;
      aQuery.Close;
      with aQuery.SQL do
      begin
        clear;
        Add('INSERT INTO VEREIN(');
        Add('  VE_ID,');
        Add('  VE_NAME');
        Add(')');
        Add('VALUES(');
        Add('  ' + quotedStr(aGUID) + ',');
        Add('  ' + quotedStr(verein));
        Add(')');
      end;

      //aQuery.Active := true;
      aQuery.ExecSQL;

      verein := aGUID;
    end;
  finally
    aQuery.Free;
  end;

end;

end.
