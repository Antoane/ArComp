object MainWindow: TMainWindow
  Left = 0
  Top = 0
  Caption = 'MainWindow'
  ClientHeight = 492
  ClientWidth = 929
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 90
    Width = 929
    Height = 402
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 0
    object pageControl: TPageControl
      Left = 1
      Top = 1
      Width = 927
      Height = 400
      ActivePage = sheetPersonenzuteilung
      Align = alClient
      TabOrder = 0
      object sheetPersonenzuteilung: TTabSheet
        Caption = 'Bogensch'#252'tzen'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        object DBGrid1: TDBGrid
          Left = 0
          Top = 29
          Width = 919
          Height = 308
          Align = alClient
          DataSource = sourcePersonen
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'PE_VORNAME'
              Title.Caption = 'Vorname'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PE_NACHNAME'
              Title.Caption = 'Nachname'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PE_NATION'
              Title.Caption = 'Nation'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PE_BUNDESLAND'
              Title.Caption = 'Bundesland'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PE_BOGENKATEGORIE'
              Title.Caption = 'Bogenkategorie'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PE_ALTERSKLASSE'
              Title.Caption = 'Altersklasse'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VE_NAME'
              Title.Caption = 'Verein'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PE_GEBURTSDATUM'
              Title.Caption = 'Geburtsdatum'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PE_GESCHLECHT'
              Title.Caption = 'Geschlecht'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PE_LIZENZ'
              Title.Caption = 'Lizenz'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PE_LANDESWERTUNG'
              Title.Caption = 'Landeswertung'
              Visible = True
            end>
        end
        object Panel5: TPanel
          Left = 0
          Top = 0
          Width = 919
          Height = 29
          Align = alTop
          TabOrder = 1
          object editSearch: TEdit
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 232
            Height = 21
            Align = alLeft
            TabOrder = 0
          end
          object Button3: TButton
            AlignWithMargins = True
            Left = 242
            Top = 4
            Width = 75
            Height = 21
            Align = alLeft
            Caption = 'Suchen'
            TabOrder = 1
            OnClick = Button3Click
          end
        end
        object Panel4: TPanel
          Left = 0
          Top = 337
          Width = 919
          Height = 35
          Align = alBottom
          TabOrder = 2
          object buttonHinzufuegen: TButton
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 100
            Height = 27
            Align = alLeft
            Caption = 'Hinzuf'#252'gen'
            TabOrder = 0
            OnClick = buttonHinzufuegenClick
          end
          object ButtonLoeschen: TButton
            AlignWithMargins = True
            Left = 110
            Top = 4
            Width = 100
            Height = 27
            Align = alLeft
            Caption = 'L'#246'schen'
            TabOrder = 1
            OnClick = ButtonLoeschenClick
          end
        end
      end
    end
  end
  object panelTurnierinfo: TPanel
    Left = 0
    Top = 0
    Width = 929
    Height = 90
    Align = alTop
    TabOrder = 1
    object Label5: TLabel
      Left = 112
      Top = 39
      Width = 20
      Height = 13
      AutoSize = False
      Caption = '-'
    end
    object Label9: TLabel
      Left = 463
      Top = 9
      Width = 100
      Height = 13
      AutoSize = False
      Caption = 'Veranstalter'
    end
    object Label8: TLabel
      Left = 463
      Top = 37
      Width = 100
      Height = 13
      AutoSize = False
      Caption = 'Turnierleitung'
    end
    object Label11: TLabel
      Left = 462
      Top = 66
      Width = 100
      Height = 13
      AutoSize = False
      Caption = 'Schiedsrichter'
    end
    object editBeginn: TDBEdit
      Left = 5
      Top = 36
      Width = 100
      Height = 21
      DataField = 'TU_BEGINN'
      DataSource = sourceTurnier
      ReadOnly = True
      TabOrder = 1
    end
    object editVeranstalter: TDBEdit
      Left = 559
      Top = 6
      Width = 200
      Height = 21
      DataField = 'TU_VERANSTALTER'
      DataSource = sourceTurnier
      ReadOnly = True
      TabOrder = 3
    end
    object editEnde: TDBEdit
      Left = 126
      Top = 36
      Width = 100
      Height = 21
      DataField = 'TU_ENDE'
      DataSource = sourceTurnier
      ReadOnly = True
      TabOrder = 2
    end
    object editTurniername: TDBEdit
      Left = 5
      Top = 9
      Width = 221
      Height = 21
      DataField = 'TU_NAME'
      DataSource = sourceTurnier
      ReadOnly = True
      TabOrder = 0
    end
    object editTurnierleitung: TDBEdit
      Left = 559
      Top = 34
      Width = 200
      Height = 21
      DataField = 'TU_TURNIERLEITUNG'
      DataSource = sourceTurnier
      ReadOnly = True
      TabOrder = 4
    end
    object editSchiedsrichter: TDBEdit
      Left = 559
      Top = 62
      Width = 200
      Height = 21
      DataField = 'TU_SCHIEDSRICHTER'
      DataSource = sourceTurnier
      ReadOnly = True
      TabOrder = 5
    end
    object editTurnierart: TDBEdit
      Left = 238
      Top = 9
      Width = 138
      Height = 21
      DataField = 'TA_NAME'
      DataSource = sourceTurnier
      ReadOnly = True
      TabOrder = 6
    end
  end
  object MainMenu1: TMainMenu
    Left = 32
    Top = 184
    object test1: TMenuItem
      Caption = 'Datei'
      object Bearbeiten1: TMenuItem
        Caption = 'Neues Turnier'
      end
      object ffnen1: TMenuItem
        Caption = #214'ffnen'
        OnClick = ffnen1Click
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
      object RundenDistanzen1: TMenuItem
        Caption = 'Runden / Distanzen'
        OnClick = RundenDistanzen1Click
      end
      object Finalberechtigung1: TMenuItem
        Caption = 'Finalberechtigung'
        OnClick = Finalberechtigung1Click
      end
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
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 832
    Top = 32
  end
  object querySelectPersonen: TADOQuery
    Connection = DBConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'DECLARE @SEARCHSTRING VARCHAR(50)'
      ''
      'SET @SEARCHSTRING = :SEARCHSTRING'
      ''
      'SELECT'
      '  pe.PE_ID,'
      '  pe.PE_VORNAME,'
      '  pe.PE_NACHNAME,'
      '  pe.PE_NATION,'
      '  pe.PE_BUNDESLAND,'
      '  pe.PE_BOGENKATEGORIE,'
      '  pe.PE_ALTERSKLASSE,'
      '  ve.VE_NAME,'
      '  pe.PE_GEBURTSDATUM,'
      '  pe.PE_GESCHLECHT,'
      '  pe.PE_LIZENZ,'
      '  pe.PE_LANDESWERTUNG'
      'FROM TURNIER_ZUTEILUNG zu'
      '  INNER JOIN TURNIER tu'
      '    ON zu.TU_ID = tu.TU_ID'
      '  INNER JOIN PERSON pe'
      '    ON zu.PE_ID = pe.PE_ID'
      '  LEFT OUTER JOIN VEREIN ve'
      '    ON pe.VE_ID = ve.VE_ID'
      'WHERE tu.TU_ID = :ID'
      '  AND('
      '    pe.PE_VORNAME LIKE @SEARCHSTRING'
      '    OR pe.PE_NACHNAME LIKE @SEARCHSTRING'
      '    OR ve.VE_NAME LIKE @SEARCHSTRING'
      '  )'
      '')
    Left = 832
    Top = 224
  end
  object sourcePersonen: TDataSource
    DataSet = querySelectPersonen
    Left = 840
    Top = 152
  end
  object queryTurnier: TADOQuery
    Connection = DBConnection
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      '  tu.TU_ID,'
      '  tu.TU_NAME,'
      '  ta.TA_NAME,'
      '  tu.TU_BEGINN,'
      '  tu.TU_ENDE,'
      '  tu.TU_VERANSTALTER,'
      '  tu.TU_TURNIERLEITUNG,'
      '  tu.TU_SCHIEDSRICHTER'
      'FROM TURNIER tu'
      '  LEFT OUTER JOIN TURNIERART ta'
      '    on tu.TA_ID = ta.TA_ID'
      'WHERE tu.TU_ID = :ID'
      ''
      '')
    Left = 696
    Top = 240
  end
  object sourceTurnier: TDataSource
    DataSet = queryTurnier
    Left = 696
    Top = 168
  end
end
