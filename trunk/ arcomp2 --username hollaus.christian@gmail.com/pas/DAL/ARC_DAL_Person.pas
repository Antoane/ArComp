unit ARC_DAL_Person;

interface

uses
  Data.Win.ADODB,
  sysutils,

  //ArComp
  ARC_Functions;

type
  TARC_DAL_Person = class(TObject)
  private

  public
    class procedure updatePerson(query: TADOQuery; vorname, nachname, nation, bundesland, bogenkategorie,
      alterskategorie, geschlecht: string; geburtsdatum: TDateTime; VE_ID, PE_ID: string;
      lizenz, landeswertung: boolean; mitGebutsdatum: boolean); static;

  end;

implementation

{TARC_DAL_Tools}

class procedure TARC_DAL_Person.updatePerson(query: TADOQuery; vorname: string; nachname: string; nation: string;
  bundesland: string; bogenkategorie: string; alterskategorie: string; geschlecht: string; geburtsdatum: TDateTime;
  VE_ID: string; PE_ID: string; lizenz: boolean; landeswertung: boolean; mitGebutsdatum: boolean);
begin
  with query.sql do
  begin
    add('UPDATE PERSON');
    add('SET');
    add('  PE_VORNAME = ' + quotedStr(vorname) + ',');
    add('  PE_NACHNAME = ' + quotedStr(nachname) + ',');
    add('  PE_NATION = ' + quotedStr(nation) + ',');
    add('  PE_BUNDESLAND = ' + quotedStr(bundesland) + ',');
    add('  PE_BOGENKATEGORIE = ' + quotedStr(bogenkategorie) + ',');
    add('  PE_ALTERSKLASSE = ' + quotedStr(alterskategorie) + ',');
    if mitGebutsdatum then
    begin
      add('  PE_GEBURTSDATUM = ' + quotedStr(DateTimeToStr(geburtsdatum)) + ',');
    end
    else
    begin
      add('  PE_GEBURTSDATUM = NULL,');
    end;
    add('  PE_GESCHLECHT = ' + quotedStr(geschlecht) + ',');
    add('  PE_LIZENZ = ' + intToStr(boolToInt(lizenz)) + ',');
    add('  PE_LANDESWERTUNG = ' + intToStr(boolToInt(landeswertung)) + ',');
    add('  VE_ID = ' + quotedStr(VE_ID) + '');
    add('WHERE PE_ID = ' + quotedStr(PE_ID));
  end;

end;

end.
