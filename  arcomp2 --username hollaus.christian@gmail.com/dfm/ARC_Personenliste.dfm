object FormPersonenListe: TFormPersonenListe
  Left = 0
  Top = 0
  Caption = 'FormPersonenListe'
  ClientHeight = 532
  ClientWidth = 876
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 876
    Height = 75
    Align = alTop
    TabOrder = 0
    object labelCaption: TLabel
      AlignWithMargins = True
      Left = 31
      Top = 4
      Width = 206
      Height = 67
      Margins.Left = 30
      Align = alLeft
      Caption = 'Bogensch'#252'tzen'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitHeight = 33
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 75
    Width = 876
    Height = 422
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 30
      Width = 874
      Height = 391
      Align = alClient
      DataSource = DataSource1
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      OnTitleClick = DBGrid1TitleClick
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
      Left = 1
      Top = 1
      Width = 874
      Height = 29
      Align = alTop
      TabOrder = 0
      object editSearch: TEdit
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 232
        Height = 21
        Align = alLeft
        TabOrder = 0
      end
      object Button2: TButton
        AlignWithMargins = True
        Left = 242
        Top = 4
        Width = 75
        Height = 21
        Align = alLeft
        Caption = 'Suchen'
        TabOrder = 1
        OnClick = Button2Click
      end
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 497
    Width = 876
    Height = 35
    Align = alBottom
    TabOrder = 2
    object buttonOK: TButton
      AlignWithMargins = True
      Left = 815
      Top = 4
      Width = 27
      Height = 27
      Margins.Right = 0
      Align = alRight
      ImageAlignment = iaCenter
      ImageIndex = 0
      Images = ImageList1
      TabOrder = 0
    end
    object buttonCancel: TButton
      AlignWithMargins = True
      Left = 845
      Top = 4
      Width = 27
      Height = 27
      Align = alRight
      ImageAlignment = iaCenter
      ImageIndex = 1
      Images = ImageList1
      TabOrder = 1
      OnClick = buttonCancelClick
    end
  end
  object querySelectPersonen: TADOQuery
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
      'FROM PERSON pe'
      '  LEFT OUTER JOIN VEREIN ve'
      '    ON pe.VE_ID = ve.VE_ID'
      'WHERE pe.PE_VORNAME LIKE @SEARCHSTRING'
      '  OR pe.PE_NACHNAME LIKE @SEARCHSTRING'
      '  OR ve.VE_NAME LIKE @SEARCHSTRING'
      '')
    Left = 432
    Top = 232
  end
  object DataSource1: TDataSource
    DataSet = querySelectPersonen
    Left = 168
    Top = 208
  end
  object ImageList1: TImageList
    Left = 640
    Top = 152
    Bitmap = {
      494C010102000800300010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FDFDFD00FAFAFA00FEFEFE000000000000000000000000000000
      00000000000000000000000000000000000000000000EBEBEC00F9F9F9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FAFBFB00D6D7D700C9CACB00F3F3F4000000000000000000000000000000
      000000000000000000000000000000000000E8E9E900777980004A4D5D00FBFB
      FB00000000000000000000000000000000000000000000000000000000000000
      0000EFEFEF008E909200D4D5D600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      F700CACBCC005D5F630039474600C3C4C5000000000000000000000000000000
      000000000000000000000000000000000000808184001D203D001E2482007375
      8A00FCFCFC000000000000000000000000000000000000000000F9F9F900A2A3
      A500292C3D00242A76007E7F8300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EEEEEE00B3B4
      B6005B5F61003852490046715E006A6F71000000000000000000000000000000
      000000000000000000000000000000000000C9CACB00777A9E002025A000252C
      B80041434C00FDFDFD00000000000000000000000000EFEFEF007C7D8E002529
      62001D23A4002C305D00B0B1B800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EDEDED00AAABAD003D44
      4500314840005890720050816700404C4B00FAFAFA0000000000000000000000
      00000000000000000000000000000000000000000000F9F9F9004D4F63001F23
      8700282C99005E606B00FDFDFD0000000000E5E5E60040435C001B1F6000262B
      8A00575A7300DBDBDC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F0F0F000A4A5A7003C4445004870
      5800518464002F39380049755C002D3A3700DADADB0000000000000000000000
      0000000000000000000000000000000000000000000000000000FAFAFA006265
      7A00222793002C30AE003C3F4600DFE0E000282B3F001E249C002C3058008C8E
      9400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C8C9CA004D53540041644F005F9B
      7000606C6700D1D1D20032413C00446B530072767700FCFCFC00000000000000
      000000000000000000000000000000000000000000000000000000000000FBFB
      FB005C5E6C0020246D00262B82002B2F51002126BA002D304C00F7F7F8000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BBBCBD0031393800497654005C68
      620000000000FAFBFB003F4746004E7F5B00303C3800ECECED00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FCFCFC007577840022257C002025A10032355400E9E9EA00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F8F8F80063676800EBEB
      EC000000000000000000AFB0B200334B3B003E6246006D707200F9F9F9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EEEEEE002C2F3D00212594001D204B00292E9C006C6E7C00FCFCFC000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F7F7F7003E46440047754B0029332F00D1D1D200FCFC
      FC0000000000000000000000000000000000000000000000000000000000F8F8
      F800515361002125850024274200C8C9CE00292D580022267A004B4D5900FBFB
      FB00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B3B4B500242F2A00477847002F373500DCDC
      DD00FDFDFD000000000000000000000000000000000000000000FDFDFD005D5F
      6500292C860025286800A4A6AD0000000000BDBEC100282B4200252994003437
      4200F9F9F9000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000EAEAEB0055585A0042693D00416D3B002A30
      3100D4D5D600FAFBFB0000000000000000000000000000000000E1E1E2002124
      38001F226D0080819300000000000000000000000000EFEFEF002E3043002529
      94004C4F6500F6F6F60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7F7F700606563003C6231003C66
      2F00303A3500C8C9CA00F5F5F5000000000000000000F8F8F800353841002427
      9A00282B3E00FCFCFC0000000000000000000000000000000000F6F6F6004649
      590021246500383A5100F1F2F200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F7F700393D3E002F46
      26003A652500242E270095989800FAFBFB0000000000ACADAF0024264E002223
      6100A8A8B000000000000000000000000000000000000000000000000000FBFB
      FB006D6F7A0025285D002D304200E0E0E1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F9F9F9008E92
      90002630250024351D00575D5900FAFBFB00F7F7F70067697100202242003638
      4C00000000000000000000000000000000000000000000000000000000000000
      0000FDFDFD0096989D005F616D00E8E9E9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FCFC
      FC00DADADB004D505000E7E8E800FEFEFE00FEFEFE00EAEAEB00A9AAAC007C7E
      8100000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F6F6F600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00F8FF9FFF00000000F0FF0FF100000000
      E0FF07C100000000C0FF038100000000807F810300000000007FC00F00000000
      003FE01F00000000083FF03F000000008C1FF01F00000000FC0FE00F00000000
      FE07C10700000000FE03C38300000000FF0183C100000000FF8087E000000000
      FFC00FF000000000FFE00FFD0000000000000000000000000000000000000000
      000000000000}
  end
  object ADODataSet1: TADODataSet
    Parameters = <>
    Left = 208
    Top = 352
  end
end
