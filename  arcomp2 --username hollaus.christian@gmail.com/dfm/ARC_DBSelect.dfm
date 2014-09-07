object FormDBSelect: TFormDBSelect
  Left = 0
  Top = 0
  Caption = 'FormDBSelect'
  ClientHeight = 427
  ClientWidth = 583
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel4: TPanel
    Left = 0
    Top = 398
    Width = 583
    Height = 29
    Align = alBottom
    TabOrder = 1
    object buttonOK: TButton
      AlignWithMargins = True
      Left = 522
      Top = 4
      Width = 27
      Height = 21
      Margins.Right = 0
      Align = alRight
      ImageAlignment = iaCenter
      ImageIndex = 0
      Images = ImageList
      TabOrder = 1
      OnClick = buttonOKClick
    end
    object buttonCancel: TButton
      AlignWithMargins = True
      Left = 552
      Top = 4
      Width = 27
      Height = 21
      Align = alRight
      ImageAlignment = iaCenter
      ImageIndex = 1
      Images = ImageList
      TabOrder = 2
      OnClick = buttonCancelClick
    end
    object buttonSave: TButton
      AlignWithMargins = True
      Left = 492
      Top = 4
      Width = 27
      Height = 21
      Margins.Right = 0
      Align = alRight
      ImageAlignment = iaCenter
      ImageIndex = 6
      Images = ImageList
      TabOrder = 0
      OnClick = buttonSaveClick
    end
    object buttonNew: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 27
      Height = 21
      Margins.Right = 0
      Align = alLeft
      ImageAlignment = iaCenter
      ImageIndex = 2
      Images = ImageList
      TabOrder = 3
      OnClick = buttonNewClick
    end
    object butonDelete: TButton
      AlignWithMargins = True
      Left = 34
      Top = 4
      Width = 27
      Height = 21
      Margins.Right = 0
      Align = alLeft
      ImageAlignment = iaCenter
      ImageIndex = 3
      Images = ImageList
      TabOrder = 4
      OnClick = butonDeleteClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 583
    Height = 398
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 19
      Width = 40
      Height = 13
      Caption = 'Provider'
    end
    object labelUser: TLabel
      Left = 199
      Top = 135
      Width = 69
      Height = 13
      Caption = 'Benutzername'
    end
    object labelPassword: TLabel
      Left = 199
      Top = 157
      Width = 44
      Height = 13
      Caption = 'Passwort'
    end
    object Label4: TLabel
      Left = 8
      Top = 43
      Width = 52
      Height = 13
      Caption = 'Datenbank'
    end
    object Label5: TLabel
      Left = 8
      Top = 67
      Width = 32
      Height = 13
      Caption = 'Server'
    end
    object Label6: TLabel
      Left = 8
      Top = 91
      Width = 54
      Height = 13
      Caption = 'Packet Size'
    end
    object labelIndexCaption: TLabel
      Left = 503
      Top = 19
      Width = 16
      Height = 13
      Caption = '0/0'
    end
    object editProvider: TEdit
      Left = 96
      Top = 16
      Width = 121
      Height = 21
      ReadOnly = True
      TabOrder = 0
      Text = 'SQLOLEDB.1'
    end
    object RadioGroup1: TRadioGroup
      Left = 8
      Top = 119
      Width = 185
      Height = 59
      Caption = 'Authentifizierung'
      TabOrder = 6
      OnClick = RadioGroup1Click
    end
    object radioWindows: TRadioButton
      Left = 21
      Top = 156
      Width = 153
      Height = 17
      Caption = 'Windows Authentifizierung'
      TabOrder = 9
      OnClick = RadioGroup1Click
    end
    object radioUserName: TRadioButton
      Left = 21
      Top = 134
      Width = 145
      Height = 17
      Caption = 'Benutzername/Passwort'
      Checked = True
      TabOrder = 8
      TabStop = True
      OnClick = RadioGroup1Click
    end
    object editBenutzer: TEdit
      Left = 272
      Top = 132
      Width = 121
      Height = 21
      TabOrder = 7
      Text = 'editBenutzer'
    end
    object editPasswort: TEdit
      Left = 272
      Top = 154
      Width = 121
      Height = 21
      PasswordChar = '*'
      TabOrder = 10
      Text = 'editPasswort'
    end
    object checkPersistSecurityInfo: TCheckBox
      Left = 21
      Top = 187
      Width = 196
      Height = 17
      Caption = 'Persist security info'
      TabOrder = 11
    end
    object editDataBase: TEdit
      Left = 96
      Top = 40
      Width = 121
      Height = 21
      TabOrder = 3
    end
    object editServer: TEdit
      Left = 96
      Top = 64
      Width = 121
      Height = 21
      TabOrder = 4
    end
    object checkProcedureForPrepare: TCheckBox
      Left = 21
      Top = 210
      Width = 196
      Height = 17
      Caption = 'Use Procedure for Prepare'
      TabOrder = 12
    end
    object checkAutoTranslate: TCheckBox
      Left = 21
      Top = 233
      Width = 196
      Height = 17
      Caption = 'Auto Translate'
      TabOrder = 13
    end
    object checkDataEncryption: TCheckBox
      Left = 21
      Top = 256
      Width = 196
      Height = 17
      Caption = 'Use Encryption for Data'
      TabOrder = 14
    end
    object checkCollation: TCheckBox
      Left = 21
      Top = 279
      Width = 222
      Height = 17
      Caption = 'Tag with column collation when possible'
      TabOrder = 15
    end
    object editPacketSize: TEdit
      Left = 96
      Top = 88
      Width = 121
      Height = 21
      NumbersOnly = True
      TabOrder = 5
    end
    object buttonZurueck: TButton
      Left = 475
      Top = 16
      Width = 25
      Height = 21
      ImageIndex = 9
      Images = ImageList
      TabOrder = 1
      OnClick = buttonZurueckClick
    end
    object buttonWeiter: TButton
      Left = 522
      Top = 16
      Width = 25
      Height = 21
      ImageIndex = 10
      Images = ImageList
      TabOrder = 2
      OnClick = buttonWeiterClick
    end
  end
  object ImageList: TImageList
    Left = 496
    Top = 248
    Bitmap = {
      494C01010B004801E00010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFEFE0094C59600F2F6
      F20000000000FEFEFE0094C39600F2F6F2000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF008CBD8C00218C21003194
      3100399C3900429C420042A542004AA54A004AA54A0052A5520052A552005AAD
      5A0063B5630073BD7300B5DEB500FFFFFF00FFFFFF0084B58400107310001873
      18001873180018731800187B1800187B1800107B1000107B1000087B0800087B
      0800007B0000007300007BB57B00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F9F7001B901E003799
      3300D9E7D900F7F9F7001B9B1E00379C3300D9E7D90000000000000000000000
      000000000000000000000000000000000000FFFFFF00187318003194310042A5
      42004AA54A0052AD52005AAD5A0063AD630063B563006BB56B0073BD73007BBD
      7B008CC68C009CCE9C0073BD7300FFFFFF00FFFFFF0010841000218C21002994
      2900319431003194310029942900299C2900219C210018A5180018A5180010A5
      100008A5080000940000006B0000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F9F7000D880A000383
      03001E9A1C00ABCEAA000D9F0A0003A603001E991C00B4D2B300000000000000
      000000000000000000000000000000000000FFFFFF00217B210031943100399C
      390042A542004AA54A004AA54A00FFFFFF00B5DEB50063AD630063B563006BB5
      6B007BBD7B008CC68C006BB56B00FFFFFF00FFFFFF00188C180029942900399C
      3900399C3900399C390039A53900A5D6A500FFFFFF0021AD210018AD180010B5
      100008AD0800009C0000007B0000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F9F7000B8D0900008E
      000000A400000EAC0D000DAE0B0000BB000000A800000F950E0085B88400FEFE
      FE0000000000000000000000000000000000FFFFFF00217B2100319431003194
      3100319C3100319C3100FFFFFF00FFFFFF00FFFFFF0052A552005AAD5A0063AD
      630073BD73007BBD7B005AAD5A00FFFFFF00FFFFFF0021942100399C390042A5
      42004AA54A0042A5420042A54200FFFFFF00FFFFFF00FFFFFF0021B5210018B5
      180010AD100008A50800087B0800FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F9F700098F07000093
      000000AB000000C2000004D3040000C6000000AF00000099000008870700569F
      5500F2F6F200000000000000000000000000FFFFFF00217B2100299429002994
      290029942900FFFFFF00FFFFFF00FFFFFF00429C42004AA54A0052A552005AAD
      5A006BB56B006BB56B0052A55200FFFFFF00FFFFFF0029942900429C42004AA5
      4A0052A552004AA54A0042A5420042AD4200FFFFFF00FFFFFF00FFFFFF0018B5
      180010AD100010A5100008840800FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F9F700078C05000091
      000000A6000000B8000000C2000000BB000000AB00000096000000810000046F
      040031842F00D9E6D9000000000000000000FFFFFF00217B210029942900299C
      2900FFFFFF00FFFFFF00FFFFFF00399C3900429C42004AA54A0052A552005AAD
      5A0063AD630063AD630052A55200FFFFFF00FFFFFF00319C31004AA54A0052A5
      520052A552004AA54A004AA54A0042A5420039AD3900FFFFFF00FFFFFF00FFFF
      FF0018AD180018A5180010841000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F9F700058604000089
      0000009A000000A7000000AD000000A90000009E0000028E0200037C03000268
      020003540300216C2000D8E5D80000000000FFFFFF00217B2100219C2100FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF005AAD5A0042A54200FFFFFF00FFFFFF00429C420052A55200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00219C210018841800FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F9F70011861000168A
      1600199919001DA41D0021AA210026AA260029A529002C9D2C002F932F003489
      3400377F3700337A3300D2E1D20000000000FFFFFF0018841800219C2100FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0052A55200429C4200FFFFFF00FFFFFF0042A542005AAD5A00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00219C2100217B2100FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F9F70019841900268A
      26002A972A002FA02F0034A6340038A738003DA63D0042A24200469C46004491
      44003A7F3900D9E5D9000000000000000000FFFFFF001084100018A5180018AD
      1800FFFFFF00FFFFFF00FFFFFF0039AD390042A542004AA54A004AA54A0052A5
      520052A552004AA54A00319C3100FFFFFF00FFFFFF0052A5520063AD630063AD
      63005AAD5A0052A552004AA54A00429C4200399C3900FFFFFF00FFFFFF00FFFF
      FF00299C290029942900217B2100FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F9F700228222003E92
      3E00439C430048A448004DA84D0051AC510056AC56005BAB5B004E984E005990
      5900F2F5F200000000000000000000000000FFFFFF000884080010A5100010AD
      100018B51800FFFFFF00FFFFFF00FFFFFF0042AD420042A542004AA54A0052A5
      52004AA54A00429C420029942900FFFFFF00FFFFFF0052A552006BB56B006BB5
      6B005AAD5A0052A552004AA54A00429C4200FFFFFF00FFFFFF00FFFFFF002994
      29002994290029942900217B2100FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F8F7002D802D00579D
      57005CA65C0043904300388938006AB56A006FB86F005093500085AA8500FEFE
      FE0000000000000000000000000000000000FFFFFF00087B080008A5080010AD
      100018B5180021B52100FFFFFF00FFFFFF00FFFFFF0042A5420042A542004AA5
      4A0042A54200399C390021942100FFFFFF00FFFFFF005AAD5A007BBD7B0073BD
      730063AD63005AAD5A0052A55200FFFFFF00FFFFFF00FFFFFF00319C3100319C
      31003194310031943100217B2100FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F8F7003880380070AC
      700043844300ABC5AB003F873F0083C383004B894B00B4CAB400000000000000
      000000000000000000000000000000000000FFFFFF00007B0000009C000008AD
      080010B5100018AD180021AD2100FFFFFF00A5D6A50039A53900399C3900399C
      3900399C390029942900188C1800FFFFFF00FFFFFF006BB56B008CC68C007BBD
      7B006BB56B0063B5630063AD6300B5DEB500FFFFFF004AA54A004AA54A0042A5
      4200399C390031943100217B2100FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F8F7004B884B004982
      4900D9E4D900F7F9F700519051004D864D00D9E4D90000000000000000000000
      000000000000000000000000000000000000FFFFFF00006B00000094000008A5
      080010A5100018A5180018A51800219C2100299C290029942900319431003194
      310029942900218C210010841000FFFFFF00FFFFFF0073BD73009CCE9C008CC6
      8C007BBD7B0073BD73006BB56B0063B5630063AD63005AAD5A0052AD52004AA5
      4A0042A542003194310018731800FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFEFE00A9C3A900F2F5
      F20000000000FEFEFE00A9C3A900F2F5F2000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF007BB57B0000730000007B
      0000087B0800087B0800107B1000107B1000187B1800187B1800187318001873
      1800187318001073100084B58400FFFFFF00FFFFFF00B5DEB50073BD730063B5
      63005AAD5A0052A5520052A552004AA54A004AA54A0042A54200429C4200399C
      390031943100218C21008CBD8C00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7F5F400EDE5E300E9E0
      DE00E7DDDA00E5D9D600E3D7D200E2D6D200E5D9D500E7DCD900E9E0DD00E9E7
      E2003C9D5200499D4C00000000000000000000000000F7F5F400EDE5E300E9E0
      DE00E7DDDA00E5D9D600E3D7D200E2D6D200E5D9D500E7DCD900C3BCCF004D50
      AA00EDEBEF00F6F5F7005B5CB500B1B1D90000000000EDEDED00B6B6B600B7B7
      B700CCCCCC00CFCFCF00CFCFCF00CECECE00CECECE00CFCFCF00CCCCCC00B7B6
      B700B1B1B200B1B1B200BFBFBF00F8F8F8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000EBEBEB0000000000EBE3E100EAE1DE00F1EBE900F6F3
      F100F8F5F500F8F6F500F8F6F500F8F5F500F8F5F500F8F5F400F7F4F300F3EE
      EC001C8A2900259F3B000000000000000000EBE3E100EAE1DE00F1EBE900F6F3
      F100F8F5F500F8F6F500F8F6F500F8F5F500F8F5F500F8F5F400595CBB000506
      E9003D3B9100535092000607E7004749BD00000000009B9A9B002C2B2F00302F
      33009D9D9D00A2A2A2009D9D9D00929292008D8D8D008A8A8A00878787002423
      2700252428002B2A2E002D2C3000F4F4F4000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D0D0D0009B9B9B00C0C0C000F3EDEC00EFE8E600F4EFEE00F9F6
      F500F9F7F600F9F7F600F9F7F600F9F7F600F9F7F600F9F7F60038903900288B
      2C0036A8470038AF4F001D982B0041B15500F3EDEC00EFE8E600F4EFEE00F9F6
      F500F9F7F600F9F7F600F9F7F600F9F7F600F9F7F600F9F7F600EDEBF0004145
      BA000306C5000406C2003237B800E8E8F2000000000037363900323135003736
      3900B0B0B0002423260021212200A9A9A900A2A2A2009D9D9D00969696002D2C
      2F002C2B2F003332360035343800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C2C2C20092929200B3B3B300C5C5C500FBFAFA00EDE5E200F5F1F000FAF8
      F700FAF8F700FAF8F700FAF8F700FAF8F700FAF8F700FAF8F7005BAD5D00359E
      3C004CB65B004FBB620040AF520068C37B00FBFAFA00EDE5E200F5F1F000FAF8
      F700FAF8F700FAF8F700FAF8F700FAF8F700FAF8F700FAF8F700EFEDF3005356
      BE003536C3003436BF00474BB900EAEAF4000000000039383B0039383B003B3A
      3E00BABABB00313033002B2B2D00B9B9B900B4B4B400AFAFAF00A9A9A9003736
      3900353437003A393C003E3D4100000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B2B2
      B20085858500BDBDBC00C9C9C900FBFBFB0000000000F2EDEB00F1EBE900F8F5
      F400FAF8F800FBF9F800FBF9F900FBF9F900FBF9F900FBF9F900FAF8F700F6F4
      F30047B258004EBB6500000000000000000000000000F2EDEB00F1EBE900F8F5
      F400FAF8F800FBF9F800FBF9F900FBF9F900FBF9F900FBF9F9006366CA005F61
      DC004E50B5005456B4006061DB005154C200000000003F3E42003F3E42004342
      4500BCBCBC003E3D3F0037363800C4C4C400C3C3C300BFBFBF00BABABA003D3C
      3F003A393B003F3E410041404300000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FEFEFE00A2A2A2007C7C
      7C00C8C8C700CCCCCC00FEFEFE00000000000000000000000000F7F6F600F6F3
      F200F3EFED00EDEDEF00C7D2DD00CCD5DF00F2F1F200FBF9F800FCFBFA00F7FA
      F70083CF910089D59B0000000000000000000000000000000000F7F6F600F6F3
      F200F3EFED00EDEDEF00C7D2DD00CCD5DF00F2F1F200FBF9F800C2C2E8006869
      D000E8E8F500F3F3F9006C6ED100ADAEE3000000000046454800464548004847
      4A00BFBFBF00CBCBCB00CBCBCB00CACACA00CACACA00CBCBCB00C7C7C7003837
      3A00353537004645480048474A00000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFD00979797007E7E7D00D1D0
      CF00D1D1D1000000000000000000000000000000000000000000000000000000
      0000FDFDFD00DEE9F400ADC1D400B1C4D600DDE7F00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FDFDFD00DEE9F400ADC1D400B1C4D600DDE7F00000000000000000000000
      000000000000000000000000000000000000000000004B4A4D004B4A4D004B4A
      4D004B4A4D004D4C4F00504F5200515053005251540052515400504F52004E4D
      50004C4B4D004B4A4D004D4C4F00000000000000000000000000F4F4F400B3B2
      B2009D9C9C009D9D9C00B3B3B300F4F4F400A7A7A70086868500D2D2D100D7D7
      D700000000000000000000000000000000000000000000000000000000000000
      000000000000C7D7E600ABC8E000A8C6DF00D1DDE70000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C7D7E600ABC8E000A8C6DF00D1DDE70000000000000000000000
      000000000000000000000000000000000000000000004E4D50004E4D50004E4D
      50004E4D50004E4D50004E4D50004F4E50004F4E50004F4E50004E4D50004E4D
      50004E4D50004E4D5000515053000000000000000000DBDBDB009F9B9800D7BC
      9700EBD19A00EBD19900D8BC9500A29D9800B6B6B400C8C7C700E0E0E0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F8F9FA00B9D7F000C0DCF400C0DCF400C1D7EA0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F8F9FA00B9D7F000C0DCF400C0DCF400C1D7EA0000000000000000000000
      0000000000000000000000000000000000000000000052515300525153009F99
      9300C1B8AF00C4BBB200C6BDB400C7BEB500C7BEB400C5BCB200C3B9B000BFB6
      AB009E979100525153005554560000000000F6F6F60096919000D6B27F00F8E8
      B100FDF5D000FDF5CF00F9E9B200D9B47F00A49D9A00F8F8F800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DAE9F600C5DEF500D1E6F700D3E6F800C8E0F500EFF4F800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DAE9F600C5DEF500D1E6F700D3E6F800C8E0F500EFF4F800000000000000
      000000000000000000000000000000000000000000005554560055545600C3BC
      B500E7DBCD00E7DBCE00E7DACD00E6DACD00E6DACC00E6D9CB00E5D8CB00E5D8
      C900C1B9B1005554560058575A0000000000B7B7B700B1907500F1D99D00FCF0
      C100FEF7D400FEF7D300FCF0C100F2DB9F00B4917100B7B7B700000000000000
      000000000000000000000000000000000000000000000000000000000000F5F7
      F800B9D5EE00D1E4F600DAEAF800DDEBF800D5E7F700CEE1F200000000000000
      000000000000000000000000000000000000000000000000000000000000F5F7
      F800B9D5EE00D1E4F600DAEAF800DDEBF800D5E7F700CEE1F200000000000000
      0000000000000000000000000000000000000000000059585A0059585A00C7C1
      BB00F3EDE700F3EDE700F3EDE700F2ECE600F2ECE500F1EBE400F1EAE200F0E8
      E000C5BFB80059585A005C5B5D00000000009A9A9A00BD916800F3DD9F00FCEE
      B600FDF2C100FDF2C100FCEFB600F4DFA100BD9062009D9D9D00000000000000
      000000000000000000000000000000000000000000000000000000000000F0F2
      F400A9C3DC00D3E5F600DDEBF800E1EDF900D8E8F700B5CBE000000000000000
      000000000000000000000000000000000000000000000000000000000000F0F2
      F400A9C3DC00D3E5F600DDEBF800E1EDF900D8E8F700B5CBE000000000000000
      000000000000000000000000000000000000000000005C5B5D005C5B5D00CBC7
      C200F0E9E100F0E9E100F0E8E100F0E8E000EFE8DF00EFE7DE00EEE6DD00EDE5
      DC00C9C4BF005C5B5D00605F6100000000009E9E9E00B0815B00EDD29500F9EA
      AC00FCEFB100FCEFB000F9EBAD00EED49700B0805600A0A0A000000000000000
      000000000000000000000000000000000000000000000000000000000000FDFE
      FE0098B2CC00D0E3F500D7E6F400DBE9F500D0E1F200A9BACE00000000000000
      000000000000000000000000000000000000000000000000000000000000FDFE
      FE0098B2CC00D0E3F500D7E6F400DBE9F500D0E1F200A9BACE00000000000000
      00000000000000000000000000000000000000000000605F6100605F6100CECA
      C700FEFDFC00FEFDFC00FEFDFC00FEFDFC00FDFDFC00FDFCFB00FCFBFA00FBF9
      F800CCC8C400605F61006463650000000000C3C3C30098756000D8B48200F2DC
      A300F8E7A400F8E7A300F3DEA400DBB98500966F5800C4C4C400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000092A6BE0092A9C2008299B40098ADC50097ADC600C2CEDC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000092A6BE0092A9C2008299B40098ADC50097ADC600C2CEDC00000000000000
      000000000000000000000000000000000000000000005E5D5E005E5D5F00CDC8
      C400F2EAE300F2EAE300F2EAE300F2EAE300F3EBE400F3ECE500F3EDE600F4EE
      E800CECBC800636264006766680000000000FDFDFD009F9B9A009C6B4B00D3AF
      7F00EDD6A200EDD6A300D6B383009C6948009C979400FDFDFD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DFE5EB008299B5008CA3BE00ABBED500B7C6D900F7F8F900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DFE5EB008299B5008CA3BE00ABBED500B7C6D900F7F8F900000000000000
      000000000000000000000000000000000000000000006968690063626400C6C0
      BB00EEE7E300EFE8E400EFE9E500F0EAE600F1EBE700F1ECE800F0ECEA00F0ED
      EB00C7C3C0006A696A00767577000000000000000000EEEEEE00B0ACAB009C7A
      67009E7356009D73540098736000AAA5A300EEEEEE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F4F5F700D0D7DF00DCE1E700FDFDFD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F4F5F700D0D7DF00DCE1E700FDFDFD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FEFEFE00DADA
      DA00CDCDCC00CCCCCC00D9D9D900FEFEFE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CEF0E7008ECE9B00A4D0A400DCE6DC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C5DBC800289D67000E862000288D2A00398A3D00C7DDC8000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FDFDFD00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CACB
      E100343B8A00B7B7D20000000000000000000000000000000000B7B7D4004E4F
      B900CCCCE5000000000000000000000000000000000000000000000000000000
      00000000000082AE82000B741300038C0600048E09001484190087C38B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E6ECE60044915F007EA384000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CBCBE2002A2C
      9F002E31EA00292C8600B5B5CB000000000000000000B6B6CB00292C89002E32
      EA002A2C9F00CACAE30000000000000000000000000000000000000000000000
      00000000000080A980000D73110015A429001EAE3A00178C230085C18A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E9EEE900418D550017DA5E001EC05A0082A6860000000000000000000000
      0000000000000000000000000000000000000000000000000000343C8E002B30
      E9000000F3001416ED00272B7000B5B5CA00B5B5C900282B71001416ED000000
      F3002E32E9004848A40000000000000000000000000000000000000000000000
      00000000000080AA800015781C0023B4440031C45D002193330086C08B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ECF0
      EC00448D530014BD4F0010C64D000FC54C001CA94E0088AE8B00000000000000
      0000000000000000000000000000000000000000000000000000B8B9D8002229
      A4000E13E2000000E2001215DC0020275F0022295F001215DC000000E2001014
      E200262AA400C0C0DF00000000000000000000000000C2D7C20082AB820080A8
      800080A98000418541001B7D230025B647002EC05700259435004BA1540088C2
      90008AC694008ECD9A00CAE7D0000000000000000000C2C2D9008282B0008080
      AD008080AF008080B2008080B6008080BA008080BF008080C4008080CA008080
      D0008080D6008282DD00C3C3EF00000000000000000000000000EDF2ED004D94
      570038B55D0035BD5D0035BE610033BE5E002DB557002F9E51008EB590000000
      000000000000000000000000000000000000000000000000000000000000B6B6
      DA001C26A5000C12D3000000D0000D13C8000D13C9000000D0000C13D3001E27
      A500B6B6DA00000000000000000000000000C3DCC300056E0500197419001874
      18001A771B001D7C21002E93380020B13E0026B7480037A3480029983800299C
      3A002AA03B002DA7410028B14600CCEBD300C3C3DE000505770019197E001818
      80001818860018188D001818950018189D001818A5001818AD001919B3001818
      B9001818BD001919C4000606D700C3C3F50000000000F0F4F000509656004EB0
      640050B9670050BA690058965F00489F5A0051BD6A0052B869005DAC6B0093BA
      9400000000000000000000000000000000000000000000000000000000000000
      0000B6B6DC001925A7000A12C2000000BC000000BC000A12C2001A26A700B6B6
      DC000000000000000000000000000000000082BA82002589260031A3370038AD
      3F0040B44A0046BA54004BBF5C004DC161004BC2620045BE5B0035B34900129E
      1F00059109000084000037B2500097DEA9008282BF00252593003232B6003838
      C6003D3DD1003F3FD9004040E0003E3EE4003939E4003030E0002222D5000202
      BD000000A900000091001C1CD0008282F200000000009EC29E0059AC660064B8
      710063BA720063A16700F4F7F400C3D6C40054A6600065BC740064B670005DA8
      660097BE97000000000000000000000000000000000000000000000000000000
      0000B6B6DD001D29AA003138C7002F2FC3003232C200323AC2001826A700B6B6
      DE000000000000000000000000000000000083BD83003F9B410049B4530048B8
      53004ABC57004DBF5C0050C2610052C4650052C6660052C5660051C3630059C2
      66003CAE4300108B11004BBA62009AE0AD008383C2003F3FA6004848C9004747
      D0004747D7004747DC004848E1004848E4004848E6004848E5004848E2005353
      DC003A3AC300101098003131D6008484F40000000000FBFCFB006AAA6C0074BD
      7A0064A86500F2F6F2000000000000000000C0D7C0005DAD62007AC1800079BD
      7E005FAA620099C299000000000000000000000000000000000000000000B6B6
      DF00202BAF004147CC003D3DC900494DC700494DC8004040CA00595FD200262F
      B000B6B6E000000000000000000000000000D4E6D4006EB56E0049A14B003796
      3A0037963C0038973F0057AF610058C96C0059C96D005DB86B0044AB560049B2
      5D004FB9650065C47B0084D59A00DDF3E400D4D4E8006E6EBD004646AD003232
      A5003131A7003131AA003131AE003131B4003232B9003232BF003232C6003232
      CC003232D4004848DD006B6BEC00D6D6FA000000000000000000FAFBFA00B1D1
      B100F1F5F10000000000000000000000000000000000BAD5BA0066B5670090CF
      91008FCC900066B56600B8D6B800000000000000000000000000B7B7E100242E
      B400555AD6005454D3005F62D4002D3594002C3495005D60D4005454D3005B5F
      D7003036B600B7B7E100000000000000000000000000E5F0E50090C5900081BC
      830082BC8500469C4C003FA0490061CE750061CE760047AD590052B063008ECF
      9B0091D4A0009FDCAF00EBF8EE000000000000000000E5E5F1008F8FCD008080
      C6008080C6008080C8008080CB008080CE008080D2008080D6008080DB008080
      E1008080E7008E8EEE00E7E7FC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B4D4B40070C1
      7000A8E5A80058B25800D6E7D6000000000000000000000000002022AF00646D
      E4006B6BE6007376E6003239B500B5B5D600B5B5D6003137B6007073E6006B6B
      E6007D83E7001F22AF0000000000000000000000000000000000000000000000
      00000000000085BD890043A64E006AD582006BD582004CB35F008DCE9A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AED1
      AE0081C48100C9E0C90000000000000000000000000000000000CACAEA002B31
      BD008288F200363CC200B6B6E4000000000000000000B6B6E3003339C200848A
      F2003035BD00CACAEB0000000000000000000000000000000000000000000000
      00000000000086C18B0046AD550076DE930076DE930051B966008FD19D000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FDFEFD00000000000000000000000000000000000000000000000000CACA
      EB005051C400B8B8E60000000000000000000000000000000000B8B8E6005153
      C500CBCBEC000000000000000000000000000000000000000000000000000000
      0000000000008BC7920068BF750084E8A60083E8A6006BC77F0096D7A5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CCE6CF00B8DEBD007DCE8D0071CC8500C5E7CD00DDF1E2000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D9EEDC009AD9A50098DAA600E3F4E700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF00FFFF80018001000088FF000000000000
      807F000000000000803F000000000000800F0000000000008007000000000000
      8003000000000000800100000000000080010000000000008003000000000000
      8007000000000000800F000000000000803F000000000000807F000000000000
      88FF000000000000FFFF800180010000800380008000FFFD000300008000FFF8
      000000008001FFF0000000008001FFE0800380008001FF81C003C0008001FF07
      F07FF07F8001C00FF87FF87F8001801FF07FF07F8001003FF03FF03F8001003F
      E03FE03F8001003FE03FE03F8001003FE03FE03F8001003FF03FF03F8001003F
      F03FF03F8001807FF87FF87FFFFFC0FFFFFFFFFFFC3FFFFFFFFFFFFFF81FFFFF
      FDFFE3C7F81FFFFFF8FFC183F81FFFFFF07FC003F81FFFFFE03FC00380018001
      C01FE00700000000800FF00F000000008007F00F000000008303E00700000000
      C781C00380018001FFC1C003F81FFFFFFFE3C183F81FFFFFFFF7E3C7F81FFFFF
      FFFFFFFFF81FFFFFFFFFFFFFFC3FFFFF00000000000000000000000000000000
      000000000000}
  end
end
