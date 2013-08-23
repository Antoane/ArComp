unit ARC_DAL_Finalberechtigungen;

interface

uses
  System.SysUtils,
  Data.Win.ADODB,

  //ArComp
  ARC_DAL_Tools,
  ARC_Types;

type
  TARC_DAL_Finalberechtigungen = class(TObject)
  private

  public
    class procedure selectBerechtigung(const query: TADOQuery);
    class procedure UpdateBerechtigung(query: TADOQuery; FB_ID: string; berechtigung: integer); static;
  end;

implementation

class procedure TARC_DAL_Finalberechtigungen.selectBerechtigung(const query: TADOQuery);
begin
  with query.SQL do
  begin
    clear;
    add('SELECT');
    add('  fb.FB_ID,');
    add('  fb.TA_ID,');
    add('  fb.BK_ID,');
    add('  fb.AK_ID,');
    add('  fb.GE_ID,');
    add('  fb.FB_FINALBERECHTIGT,');
    add('  ta.TA_NAME,');
    add('  bk.BK_NAME,');
    add('  ak.AK_NAME,');
    add('  ge.GE_NAME');
    add('FROM FINALBERECHTIGUNG fb');
    add('  INNER JOIN TURNIERART ta');
    add('    ON fb.TA_ID = ta.TA_ID');
    add('  INNER JOIN BOGENKATEGORIE bk');
    add('    ON fb.BK_ID = bk.BK_ID');
    add('  INNER JOIN ALTERSKATEGORIE ak');
    add('    ON fb.AK_ID = ak.AK_ID');
    add('  INNER JOIN GESCHLECHT ge');
    add('    ON fb.GE_ID = ge.GE_ID');
    add('ORDER BY');
    add('  ta.TA_NAME,');
    add('  ak.AK_NAME,');
    add('  bk.BK_NAME,');
    add('  ge.GE_NAME');
  end;
end;

class procedure TARC_DAL_Finalberechtigungen.UpdateBerechtigung(query: TADOQuery; FB_ID: string; berechtigung: integer);
begin
  with query.SQL do
  begin
    clear;
    add('UPDATE FINALBERECHTIGUNG');
    add('SET FB_FINALBERECHTIGT = ' + IntToStr(berechtigung));
    add('WHERE FB_ID = ' + quotedstr(FB_ID));
  end;
end;

end.
