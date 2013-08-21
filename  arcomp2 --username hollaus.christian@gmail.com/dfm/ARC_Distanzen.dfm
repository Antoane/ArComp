object FormDistanzen: TFormDistanzen
  Left = 0
  Top = 0
  Caption = 'FormDistanzen'
  ClientHeight = 615
  ClientWidth = 1033
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 1033
    Height = 545
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 712
    ExplicitHeight = 322
    object DBGrid1: TDBGrid
      AlignWithMargins = True
      Left = 313
      Top = 4
      Width = 716
      Height = 537
      Align = alClient
      DataSource = dataSource
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'TA_NAME'
          Title.Caption = 'Turnierart'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'AK_NAME'
          Title.Caption = 'Altersklasse'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BK_NAME'
          Title.Caption = 'Bogenklasse'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'GE_NAME'
          Title.Caption = 'Geschlecht'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DI_RUNDE'
          Title.Caption = 'Runde'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DI_DISTANZ'
          Title.Caption = 'Distanz'
          Visible = True
        end>
    end
    object Panel5: TPanel
      Left = 1
      Top = 1
      Width = 309
      Height = 543
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitHeight = 320
      object Label4: TLabel
        Left = 19
        Top = 52
        Width = 100
        Height = 13
        AutoSize = False
        Caption = 'Alterskategorie'
      end
      object Label5: TLabel
        Left = 19
        Top = 79
        Width = 100
        Height = 13
        AutoSize = False
        Caption = 'Bogenkategorie'
      end
      object Label9: TLabel
        Left = 19
        Top = 106
        Width = 100
        Height = 13
        AutoSize = False
        Caption = 'Geschlecht'
      end
      object Label2: TLabel
        Left = 19
        Top = 25
        Width = 100
        Height = 13
        AutoSize = False
        Caption = 'Turnierart'
      end
      object comboAlterskategorie: TComboBox
        Left = 115
        Top = 49
        Width = 145
        Height = 21
        Style = csDropDownList
        TabOrder = 0
        OnChange = comboAlterskategorieChange
      end
      object comboBogenkategorie: TComboBox
        Left = 115
        Top = 76
        Width = 145
        Height = 21
        Style = csDropDownList
        TabOrder = 1
        OnChange = comboBogenkategorieChange
      end
      object comboGeschlecht: TComboBox
        Left = 115
        Top = 103
        Width = 145
        Height = 21
        Style = csDropDownList
        TabOrder = 2
        OnChange = comboGeschlechtChange
      end
      object checkAlterskategorie: TCheckBox
        Left = 267
        Top = 51
        Width = 43
        Height = 17
        Caption = 'alle'
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnClick = checkAlterskategorieClick
      end
      object checkBogenkategorie: TCheckBox
        Left = 267
        Top = 78
        Width = 43
        Height = 17
        Caption = 'alle'
        Checked = True
        State = cbChecked
        TabOrder = 4
        OnClick = checkBogenkategorieClick
      end
      object checkGeschlecht: TCheckBox
        Left = 267
        Top = 105
        Width = 43
        Height = 17
        Caption = 'alle'
        Checked = True
        State = cbChecked
        TabOrder = 5
        OnClick = checkGeschlechtClick
      end
      object comboTurnierart: TComboBox
        Left = 115
        Top = 22
        Width = 145
        Height = 21
        Style = csDropDownList
        TabOrder = 6
        OnChange = comboTurnierartChange
      end
      object checkTurnierart: TCheckBox
        Left = 267
        Top = 24
        Width = 43
        Height = 17
        Caption = 'alle'
        Checked = True
        State = cbChecked
        TabOrder = 7
        OnClick = checkTurnierartClick
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 1033
    Height = 41
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 712
  end
  object Panel4: TPanel
    Left = 0
    Top = 586
    Width = 1033
    Height = 29
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 363
    ExplicitWidth = 712
    object buttonOK: TButton
      AlignWithMargins = True
      Left = 972
      Top = 4
      Width = 27
      Height = 21
      Margins.Right = 0
      Align = alRight
      ImageAlignment = iaCenter
      ImageIndex = 0
      Images = ImageList1
      TabOrder = 0
      OnClick = buttonOKClick
      ExplicitLeft = 651
    end
    object buttonCancel: TButton
      AlignWithMargins = True
      Left = 1002
      Top = 4
      Width = 27
      Height = 21
      Align = alRight
      ImageAlignment = iaCenter
      ImageIndex = 1
      Images = ImageList1
      TabOrder = 1
      OnClick = buttonCancelClick
      ExplicitLeft = 681
    end
    object buttonSave: TButton
      AlignWithMargins = True
      Left = 942
      Top = 4
      Width = 27
      Height = 21
      Margins.Right = 0
      Align = alRight
      ImageAlignment = iaCenter
      ImageIndex = 2
      Images = ImageList1
      TabOrder = 2
      OnClick = buttonSaveClick
      ExplicitLeft = 621
    end
    object buttonAdd: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 75
      Height = 21
      Margins.Right = 0
      Align = alLeft
      Caption = 'Hinzuf'#252'gen'
      TabOrder = 3
      OnClick = buttonAddClick
      ExplicitLeft = 0
      ExplicitHeight = 25
    end
    object buttonDelete: TButton
      AlignWithMargins = True
      Left = 82
      Top = 4
      Width = 75
      Height = 21
      Margins.Right = 0
      Align = alLeft
      Caption = 'L'#246'schen'
      TabOrder = 4
      OnClick = buttonDeleteClick
      ExplicitLeft = 115
      ExplicitTop = 6
      ExplicitHeight = 25
    end
  end
  object queryDistanz: TADOQuery
    Parameters = <>
    Left = 336
    Top = 272
  end
  object dataSource: TDataSource
    DataSet = queryDistanz
    Left = 624
    Top = 232
  end
  object ImageList1: TImageList
    Left = 640
    Top = 152
    Bitmap = {
      494C010103000800600010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFDFD00FAFAFA00FEFEFE000000000000000000000000000000
      00000000000000000000000000000000000000000000EBEBEC00F9F9F9000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000423D3500313132003536
      3900353639003536390035363900353639003536390035373900353739003537
      3900353739003333320046403500E7E1D6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FAFBFB00D6D7D700C9CACB00F3F3F4000000000000000000000000000000
      000000000000000000000000000000000000E8E9E900777980004A4D5D00FBFB
      FB00000000000000000000000000000000000000000000000000000000000000
      0000EFEFEF008E909200D4D5D60000000000413C3500B36E00004C413000E5E5
      E600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00DBDBDC00584A2E00D48A0000454035000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700CACBCC005D5F630039474600C3C4C5000000000000000000000000000000
      000000000000000000000000000000000000808184001D203D001E2482007375
      8A00FCFCFC000000000000000000000000000000000000000000F9F9F900A2A3
      A500292C3D00242A76007E7F830000000000403B3400AD6800004B403000F1F1
      F100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00E8E8E90056482E00CD850000443F34000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EEEEEE00B3B4
      B6005B5F61003852490046715E006A6F71000000000000000000000000000000
      000000000000000000000000000000000000C9CACB00777A9E002025A000252C
      B80041434C00FDFDFD00000000000000000000000000EFEFEF007C7D8E002529
      62001D23A4002C305D00B0B1B80000000000403A3400A76300004A3F3000F1F1
      F100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00E8E8E90055472E00C57F0000433E34000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EDEDED00AAABAD003D44
      4500314840005890720050816700404C4B00FAFAFA0000000000000000000000
      00000000000000000000000000000000000000000000F9F9F9004D4F63001F23
      8700282C99005E606B00FDFDFD0000000000E5E5E60040435C001B1F6000262B
      8A00575A7300DBDBDC0000000000000000003F393400A25D0000493E3000F1F1
      F100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00E8E8E90054472E00C17B0000423D34000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000A4A5A7003C4445004870
      5800518464002F39380049755C002D3A3700DADADB0000000000000000000000
      0000000000000000000000000000000000000000000000000000FAFAFA006265
      7A00222793002C30AE003C3F4600DFE0E000282B3F001E249C002C3058008C8E
      9400000000000000000000000000000000003F3934009C570000483D3000F1F1
      F100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00E8E8E90053452E00BF790000423D34000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C8C9CA004D53540041644F005F9B
      7000606C6700D1D1D20032413C00446B530072767700FCFCFC00000000000000
      000000000000000000000000000000000000000000000000000000000000FBFB
      FB005C5E6C0020246D00262B82002B2F51002126BA002D304C00F7F7F8000000
      0000000000000000000000000000000000003E38340097510000473C3000F1F1
      F100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00E8E8E90052442E00B9730000423D34000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BBBCBD0031393800497654005C68
      620000000000FAFBFB003F4746004E7F5B00303C3800ECECED00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FCFCFC007577840022257C002025A10032355400E9E9EA00000000000000
      0000000000000000000000000000000000003E383400944D0000413224005E5C
      5B007B7874007B7874007B7874007C7874007C7874007C7974007C7974007C79
      74007B7771004D3C2100B36E0000413C34000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F8F8F80063676800EBEB
      EC000000000000000000AFB0B200334B3B003E6246006D707200F9F9F9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EEEEEE002C2F3D00212594001D204B00292E9C006C6E7C00FCFCFC000000
      0000000000000000000000000000000000003D383400924B0000944D00005C36
      0D004A2E11004B3011004C3011004C3211004E3311004F341100503511005035
      110085510700AA660000AD680000403B34000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F7F7F7003E46440047754B0029332F00D1D1D200FCFC
      FC0000000000000000000000000000000000000000000000000000000000F8F8
      F800515361002125850024274200C8C9CE00292D580022267A004B4D5900FBFB
      FB00000000000000000000000000000000003D3834008D450100382418002E25
      29006E6D70006F6E71006F6E71006F6E71005454580052525600525256003A3B
      3E00A25D0000A5600000A7630000403B34000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B3B4B500242F2A00477847002F373500DCDC
      DD00FDFDFD000000000000000000000000000000000000000000FDFDFD005D5F
      6500292C860025286800A4A6AD0000000000BDBEC100282B4200252994003437
      4200F9F9F9000000000000000000000000003C373600883F090035201A003D2D
      3400CBCCCC00DDDEDE00DDDEDE00DDDEDE0035383C001D2025002C2F34006F6E
      71005B390E009F5A0000A25D0000403A34000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000EAEAEB0055585A0042693D00416D3B002A30
      3100D4D5D600FAFBFB0000000000000000000000000000000000E1E1E2002124
      38001F226D0080819300000000000000000000000000EFEFEF002E3043002529
      94004C4F6500F6F6F60000000000000000003C36370083371800341F1D003D2D
      3400CBCCCC00DDDEDE00DDDEDE00DDDEDE0034373B00171A1F002B2E32006F6E
      710059360E009A5400009C5700003F3934000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7F7F700606563003C6231003C66
      2F00303A3500C8C9CA00F5F5F5000000000000000000F8F8F800353841002427
      9A00282B3E00FCFCFC0000000000000000000000000000000000F6F6F6004649
      590021246500383A5100F1F2F200000000003B3538007E301F00331E1F003D2D
      3400CBCCCC00DDDEDE00DDDEDE00DDDEDE0034373B00171A1F002B2E32006F6E
      710057340E00954E0000975100003F3934000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F7F700393D3E002F46
      26003A652500242E270095989800FAFBFB0000000000ACADAF0024264E002223
      6100A8A8B000000000000000000000000000000000000000000000000000FBFB
      FB006D6F7A0025285D002D304200E0E0E1003A34380078272300321C20003D2D
      3400CBCCCC00DDDEDE00DDDEDE00DDDEDE0034373B00171A1F002B2E32006F6E
      710056330E00944D0000944D00003E3834000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F9F9F9008E92
      90002630250024351D00575D5900FAFBFB00F7F7F70067697100202242003638
      4C00000000000000000000000000000000000000000000000000000000000000
      0000FDFDFD0096989D005F616D00E8E9E9003A333900731E2600311B21003D2D
      3400CBCCCC00DDDEDE00DDDEDE00DDDEDE005A5C5F003B3E4200434549006C6B
      6F0054300F00904800009B673100C0BDBB000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FCFC
      FC00DADADB004D505000E7E8E800FEFEFE00FEFEFE00EAEAEB00A9AAAC007C7E
      8100000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F6F6F60000000000DFD8DA003A333900272026002827
      2C002E2F34002E2F34002E2F34002E2F34002E2F34002E2F34002E2F34002527
      2C00292729003D37340080808000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00F8FF9FFF80000000F0FF0FF100000000
      E0FF07C100000000C0FF038100000000807F810300000000007FC00F00000000
      003FE01F00000000083FF03F000000008C1FF01F00000000FC0FE00F00000000
      FE07C10700000000FE03C38300000000FF0183C100000000FF8087E000000000
      FFC00FF000000000FFE00FFD0000000000000000000000000000000000000000
      000000000000}
  end
  object updatePerson: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'UPDATE PERSON'
      'SET'
      '  PE_VORNAME = :PE_VORNAME,'
      '  PE_NACHNAME = :PE_NACHNAME,'
      '  PE_NATION = :PE_NATION,'
      '  PE_BUNDESLAND = :PE_BUNDESLAND,'
      '  PE_BOGENKATEGORIE = :PE_BOGENKATEGORIE,'
      '  PE_ALTERSKLASSE = :PE_ALTERSKLASSE,'
      '  PE_GEBURTSDATUM = :PE_GEBURTSDATUM,'
      '  PE_GESCHLECHT = :PE_GESCHLECHT,'
      '  PE_LIZENZ = :PE_LIZENZ,'
      '  PE_LANDESWERTUNG = :PE_LANDESWERTUNG,'
      '  VE_ID = :VE_ID'
      'WHERE PE_ID = :ID'
      ''
      '')
    Left = 480
    Top = 192
  end
  object queryInsert: TADOQuery
    Parameters = <>
    Left = 352
    Top = 128
  end
  object queryDelete: TADOQuery
    Parameters = <>
    Left = 352
    Top = 192
  end
end
