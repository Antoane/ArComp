unit ARC_DAL_SETUP;

interface

uses
  Data.Win.ADODB,
  sysutils;

type
  TARC_DAL_Setup = class(TObject)

  private

  public
    class procedure createMissingTables(query: TADOQuery); static;
  end;

implementation

class procedure TARC_DAL_Setup.createMissingTables(query: TADOQuery);
begin
  with query.SQL do
  begin
    clear;
    add('USE ArComp');
    add('');
    add('SET ANSI_NULLS ON');
    add('');
    add('SET QUOTED_IDENTIFIER ON');
    add('');
    add('SET ANSI_PADDING ON');
    add('');
    add('IF NOT EXISTS (SELECT * from sysobjects ');
    add('           WHERE id = object_id(' + quotedStr('TURNIER') + ') ');
    add('             AND OBJECTPROPERTY(id, ' + quotedStr('IsUserTable') + ') = 1) ');
    add('BEGIN');
    add('  CREATE TABLE TURNIER(');
    add('    TU_ID varchar(36) PRIMARY KEY NOT NULL,');
    add('    TA_ID varchar(36),');
    add('    TU_NAME varchar(100),');
    add('    TU_BEGINN datetime,');
    add('    TU_ENDE datetime,');
    add('    TU_VERANSTALTER varchar(100),');
    add('    TU_TURNIERLEITUNG varchar(100),');
    add('    TU_SCHIEDSRICHTER varchar(100),');
    add('    TU_SCHEIBENANZAHL integer,');
    add('    TU_PERSONEN_PRO_SCHEIBE integer');
    add('  )');
    add('END');
    add('');
    add('');
    add('IF NOT EXISTS (SELECT * from sysobjects ');
    add('           WHERE id = object_id(' + quotedStr('TURNIER_ZUTEILUNG') + ') ');
    add('             AND OBJECTPROPERTY(id, ' + quotedStr('IsUserTable') + ') = 1) ');
    add('BEGIN');
    add('  CREATE TABLE TURNIER_ZUTEILUNG(');
    add('    TZ_ID varchar(36) PRIMARY KEY NOT NULL,');
    add('    TU_ID varchar(36),');
    add('    PE_ID varchar(36)');
    add('  )');
    add('END');
    add('');
    add('');
    add('IF NOT EXISTS (SELECT * from sysobjects ');
    add('           WHERE id = object_id(' + quotedStr('TURNIERART') + ') ');
    add('             AND OBJECTPROPERTY(id, ' + quotedStr('IsUserTable') + ') = 1) ');
    add('BEGIN');
    add('  CREATE TABLE TURNIERART(');
    add('    TA_ID varchar(36) PRIMARY KEY NOT NULL,');
    add('    TA_NAME varchar(100)');
    add('  )');
    add('END');
    add('');
    add('');
    add('IF NOT EXISTS (SELECT * from sysobjects ');
    add('           WHERE id = object_id(' + quotedStr('VEREIN') + ') ');
    add('             AND OBJECTPROPERTY(id, ' + quotedStr('IsUserTable') + ') = 1) ');
    add('BEGIN');
    add('  CREATE TABLE VEREIN(');
    add('    VE_ID varchar(36) PRIMARY KEY NOT NULL,');
    add('    VE_NAME varchar(100)');
    add('  )');
    add('END');
    add('');
    add('');
    add('IF NOT EXISTS (SELECT * from sysobjects ');
    add('           WHERE id = object_id(' + quotedStr('PERSON') + ') ');
    add('             AND OBJECTPROPERTY(id, ' + quotedStr('IsUserTable') + ') = 1) ');
    add('BEGIN');
    add('  CREATE TABLE PERSON(');
    add('    PE_ID varchar(36) PRIMARY KEY NOT NULL,');
    add('    PE_VORNAME varchar(50),');
    add('    PE_NACHNAME varchar(50),');
    add('    PE_NATION varchar(50),');
    add('    PE_BUNDESLAND varchar(50),');
    add('    PE_BOGENKATEGORIE varchar(50),');
    add('    PE_ALTERSKLASSE varchar(50),');
    add('    PE_GEBURTSDATUM datetime,');
    add('    PE_GESCHLECHT varchar(50),');
    add('    PE_LIZENZ int,');
    add('    PE_LANDESWERTUNG int,');
    add('    VE_ID varchar(36)');
    add(')');
    add('END');
    add('');
    add('');
    add('IF NOT EXISTS (SELECT * from sysobjects ');
    add('           WHERE id = object_id(' + quotedStr('GESCHLECHT') + ') ');
    add('             AND OBJECTPROPERTY(id, ' + quotedStr('IsUserTable') + ') = 1) ');
    add('BEGIN');
    add('  CREATE TABLE GESCHLECHT(');
    add('    GE_ID varchar(36) PRIMARY KEY NOT NULL,');
    add('    GE_NAME varchar(50)');
    add('  )');
    add('END');
    add('');
    add('');
    add('IF NOT EXISTS (SELECT * from sysobjects ');
    add('           WHERE id = object_id(' + quotedStr('DISTANZ') + ') ');
    add('             AND OBJECTPROPERTY(id, ' + quotedStr('IsUserTable') + ') = 1) ');
    add('BEGIN');
    add('  CREATE TABLE DISTANZ(');
    add('    DI_ID varchar(36) PRIMARY KEY NOT NULL,');
    add('    TA_ID varchar(36),');
    add('    BK_ID varchar(36),');
    add('    AK_ID varchar(36),');
    add('    GE_ID varchar(36),');
    add('    DI_RUNDE int,');
    add('    DI_DISTANZ decimal(18, 2)');
    add('  )');
    add('END');
    add('');
    add('');
    add('IF NOT EXISTS (SELECT * from sysobjects ');
    add('           WHERE id = object_id(' + quotedStr('BOGENKATEGORIE') + ') ');
    add('             AND OBJECTPROPERTY(id, ' + quotedStr('IsUserTable') + ') = 1) ');
    add('BEGIN');
    add('  CREATE TABLE BOGENKATEGORIE(');
    add('    BK_ID varchar(36) PRIMARY KEY NOT NULL,');
    add('    BK_NAME varchar(36)');
    add('  )');
    add('END');
    add('');
    add('');
    add('IF NOT EXISTS (SELECT * from sysobjects ');
    add('           WHERE id = object_id(' + quotedStr('ALTERSKATEGORIE') + ') ');
    add('             AND OBJECTPROPERTY(id, ' + quotedStr('IsUserTable') + ') = 1) ');
    add('BEGIN');
    add('  CREATE TABLE ALTERSKATEGORIE(');
    add('    AK_ID varchar(36) PRIMARY KEY NOT NULL,');
    add('    AK_NAME varchar(36)');
    add('  )');
    add('END');
    add('');
    add('');
    add('IF NOT EXISTS (SELECT * from sysobjects ');
    add('           WHERE id = object_id(' + quotedStr('SCHEIBENEINTEILUNG') + ') ');
    add('             AND OBJECTPROPERTY(id, ' + quotedStr('IsUserTable') + ') = 1) ');
    add('BEGIN');
    add('  CREATE TABLE SCHEIBENEINTEILUNG(');
    add('    SE_ID varchar(36) PRIMARY KEY NOT NULL,');
    add('    TU_ID varchar(36),');
    add('    PE_ID varchar(36),');
    add('    SE_NUMMER integer,');
    add('    SE_PLATZ varchar(10)');
    add('  )');
    add('END');
    add('');
    add('');
    add('IF NOT EXISTS (SELECT * from sysobjects ');
    add('           WHERE id = object_id(' + quotedStr('FINALBERECHTIGUNG') + ') ');
    add('             AND OBJECTPROPERTY(id, ' + quotedStr('IsUserTable') + ') = 1) ');
    add('BEGIN');
    add('  CREATE TABLE FINALBERECHTIGUNG(');
    add('    FB_ID varchar(36) PRIMARY KEY NOT NULL,');
    add('    TA_ID varchar(36),');
    add('    AK_ID varchar(36),');
    add('    BK_ID varchar(36),');
    add('    GE_ID varchar(36),');
    add('    FB_FINALBERECHTIGT integer');
    add('  )');
    add('END');
    add('');
    add('');
    add('IF NOT EXISTS (SELECT * from sysobjects ');
    add('           WHERE id = object_id(' + quotedStr('SCORES') + ') ');
    add('             AND OBJECTPROPERTY(id, ' + quotedStr('IsUserTable') + ') = 1) ');
    add('BEGIN');
    add('  CREATE TABLE SCORES(');
    add('    SC_ID varchar(36) PRIMARY KEY NOT NULL,');
    add('    TU_ID varchar(36),');
    add('    PE_ID varchar(36),');
    add('    SC_RUNDE varchar(36),');
    add('    SC_SCORE integer,');
    add('    SC_ZEHNER integer,');
    add('    SC_NEUNER integer,');
    add('    SC_X integer');
    add('  )');
    add('END');
    add('');
  end;
end;

end.
