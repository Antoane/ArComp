object MainWindow: TMainWindow
  Left = 0
  Top = 0
  Caption = 'MainWindow'
  ClientHeight = 412
  ClientWidth = 750
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 48
    Top = 32
    object test1: TMenuItem
      Caption = 'Datei'
      object Bearbeiten1: TMenuItem
        Caption = 'Neues Turnier'
      end
      object ffnen1: TMenuItem
        Caption = #214'ffnen'
      end
      object Speichern1: TMenuItem
        Caption = 'Speichern'
      end
      object Importieren1: TMenuItem
        Caption = 'Importieren'
        OnClick = Importieren1Click
      end
      object Beenden1: TMenuItem
        Caption = 'Beenden'
        OnClick = Beenden1Click
      end
    end
    object Bearbeiten2: TMenuItem
      Caption = 'Bearbeiten'
      object Bogenschtzen1: TMenuItem
        Caption = 'Bogensch'#252'tzen'
        OnClick = Bogenschtzen1Click
      end
      object Vereine1: TMenuItem
        Caption = 'Vereine'
        OnClick = Vereine1Click
      end
    end
    object Optionen1: TMenuItem
      Caption = 'Optionen'
    end
    object Drucken1: TMenuItem
      Caption = 'Drucken'
    end
  end
  object DBConnection: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=X3s1s1l1!;Persist Security Info=Tru' +
      'e;User ID=sa;Initial Catalog=ArComp;Data Source=CHRISTIAN-PC;Use' +
      ' Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Wo' +
      'rkstation ID=CPAHOC_PC;Use Encryption for Data=False;Tag with co' +
      'lumn collation when possible=False'
    Provider = 'SQLOLEDB.1'
    Left = 680
    Top = 24
  end
end
