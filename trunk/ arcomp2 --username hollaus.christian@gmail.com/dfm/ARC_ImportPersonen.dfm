object FormImportPersonen: TFormImportPersonen
  Left = 0
  Top = 0
  Caption = 'FormImportPersonen'
  ClientHeight = 29
  ClientWidth = 887
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object progressBar: TProgressBar
    Left = 119
    Top = 0
    Width = 768
    Height = 29
    Align = alClient
    TabOrder = 0
  end
  object buttonImport: TButton
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 113
    Height = 23
    Align = alLeft
    Caption = 'Import aus CSV'
    TabOrder = 1
    OnClick = buttonImportClick
  end
end
