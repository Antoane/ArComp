unit ARC_DBSelect;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  System.Classes,
  System.Types,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ImgList,

  ARC_MainWindow;

type
  TFormDBSelect = class(TForm)
    ImageList: TImageList;
    Panel4: TPanel;
    buttonOK: TButton;
    buttonCancel: TButton;
    buttonSave: TButton;
    Panel1: TPanel;
    editProvider: TEdit;
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    radioWindows: TRadioButton;
    radioUserName: TRadioButton;
    editBenutzer: TEdit;
    editPasswort: TEdit;
    labelUser: TLabel;
    labelPassword: TLabel;
    checkPersistSecurityInfo: TCheckBox;
    editDataBase: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    editServer: TEdit;
    checkProcedureForPrepare: TCheckBox;
    checkAutoTranslate: TCheckBox;
    checkDataEncryption: TCheckBox;
    checkCollation: TCheckBox;
    Label6: TLabel;
    editPacketSize: TEdit;
    buttonZurueck: TButton;
    buttonWeiter: TButton;
    buttonNew: TButton;
    butonDelete: TButton;
    labelIndexCaption: TLabel;
    procedure buttonOKClick(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);
    procedure buttonSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure buttonWeiterClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure buttonZurueckClick(Sender: TObject);
    procedure buttonNewClick(Sender: TObject);
    procedure butonDeleteClick(Sender: TObject);

  private
    FListIndex : integer;
    FConfigList: TStringList;
    function getConnectionString: string;
    procedure fillGuiFromConnectionString(const value: string);
    procedure loadData;
    procedure clearGui;
    procedure setLabelIndexCaption;

    {Private-Deklarationen}
  public
    {Public-Deklarationen}
  end;

var
  FormDBSelect: TFormDBSelect;

const
  FConfigFile = 'connectionString.txt';

implementation

{$R *.dfm}

procedure TFormDBSelect.butonDeleteClick(Sender: TObject);
begin
  FConfigList.Delete(FListIndex);
  FListIndex := FListIndex mod FConfigList.Count;

  fillGuiFromConnectionString(FConfigList[FListIndex]);
  setLabelIndexCaption();
end;

procedure TFormDBSelect.buttonCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormDBSelect.buttonNewClick(Sender: TObject);
begin
  FConfigList.Add('Provider=SQLOLEDB.1');
  FListIndex := FConfigList.Count - 1;
  clearGui();
  fillGuiFromConnectionString(FConfigList[FListIndex]);
  setLabelIndexCaption();
end;

procedure TFormDBSelect.buttonOKClick(Sender: TObject);
var
  aMainWindow: TMainWindow;
begin
  aMainWindow                  := TMainWindow.create(self);
  aMainWindow.ConnectionString := getConnectionString();
  self.Visible                 := false;
  aMainWindow.ShowModal;
  self.Close;
end;

procedure TFormDBSelect.buttonSaveClick(Sender: TObject);
begin
  FConfigList[FListIndex] := getConnectionString();
  FConfigList.SaveToFile(FConfigFile);
end;

procedure TFormDBSelect.buttonWeiterClick(Sender: TObject);
begin
  FConfigList[FListIndex] := getConnectionString();

  inc(FListIndex);
  FListIndex := FListIndex mod FConfigList.Count;
  fillGuiFromConnectionString(FConfigList[FListIndex]);
  setLabelIndexCaption();
end;

procedure TFormDBSelect.buttonZurueckClick(Sender: TObject);
begin
  FConfigList[FListIndex] := getConnectionString();

  dec(FListIndex);
  if FListIndex < 0 then
  begin
    FListIndex := FConfigList.Count - 1;
  end;
  fillGuiFromConnectionString(FConfigList[FListIndex]);
  setLabelIndexCaption();
end;

function TFormDBSelect.getConnectionString: string;
begin
  result := '';

  if editProvider.Text <> '' then
  begin
    result := result + 'Provider=' + editProvider.Text + ';';
  end;

  if editDataBase.Text <> '' then
  begin
    result := result + 'Initial Catalog=' + editDataBase.Text + ';';
  end;

  if editServer.Text <> '' then
  begin
    result := result + 'Data Source=' + editServer.Text + ';';
  end;

  if editPacketSize.Text <> '' then
  begin
    result := result + 'Packet Size=' + editPacketSize.Text + ';';
  end;

  if radioWindows.Checked then
  begin
    result := result + 'Integrated Security=SSPI;';
  end
  else if radioUserName.Checked then
  begin
    if (editBenutzer.Text <> '') and (editPasswort.Text <> '') then
    begin
      result := result + 'User ID=' + editBenutzer.Text + ';';
      result := result + 'Password=' + editPasswort.Text + ';';
    end;
  end;

  if checkPersistSecurityInfo.Checked then
  begin
    result := result + 'Persist Security Info=True;';
  end
  else
  begin
    result := result + 'Persist Security Info=False;';
  end;

  if checkProcedureForPrepare.Checked then
  begin
    result := result + 'Use Procedure for Prepare=1;';
  end
  else
  begin
    result := result + 'Use Procedure for Prepare=0;';
  end;

  if checkAutoTranslate.Checked then
  begin
    result := result + 'Auto Translate=True;';
  end
  else
  begin
    result := result + 'Auto Translate=False;';
  end;

  if checkDataEncryption.Checked then
  begin
    result := result + 'Use Encryption for Data=True;';
  end
  else
  begin
    result := result + 'Use Encryption for Data=False;';
  end;

  if checkCollation.Checked then
  begin
    result := result + 'Tag with column collation when possible=True';
  end
  else
  begin
    result := result + 'Tag with column collation when possible=False';
  end;
end;

procedure TFormDBSelect.RadioGroup1Click(Sender: TObject);
begin
  editBenutzer.Visible  := radioUserName.Checked;
  labelUser.Visible     := radioUserName.Checked;
  editPasswort.Visible  := radioUserName.Checked;
  labelPassword.Visible := radioUserName.Checked;
end;

procedure TFormDBSelect.fillGuiFromConnectionString(const value: string);
var
  aSplitText: TStringDynArray;
  aItem     : string;
  aSplitItem: TStringDynArray;
  aKey      : string;
  aValue    : string;
begin
  clearGui();
  aSplitText := SplitString(value, ';');

  for aItem in aSplitText do
  begin
    aSplitItem := SplitString(aItem, '=');
    if length(aSplitItem) = 2 then
    begin
      aKey   := trim(aSplitItem[0]);
      aValue := trim(aSplitItem[1]);

      if aKey = 'Provider' then
      begin
        editProvider.Text := aValue;
      end
      else if aKey = 'Initial Catalog' then
      begin
        editDataBase.Text := aValue;
      end
      else if aKey = 'Data Source' then
      begin
        editServer.Text := aValue;
      end
      else if aKey = 'Integrated Security' then
      begin
        radioWindows.Checked := true;
      end
      else if aKey = 'Persist Security Info' then
      begin
        checkPersistSecurityInfo.Checked := (aValue = 'True');
      end
      else if aKey = 'Use Procedure for Prepare' then
      begin
        checkProcedureForPrepare.Checked := (aValue = '1');
      end
      else if aKey = 'Auto Translate' then
      begin
        checkAutoTranslate.Checked := (aValue = 'True');
      end
      else if aKey = 'Use Encryption for Data' then
      begin
        checkDataEncryption.Checked := (aValue = 'True');
      end
      else if aKey = 'Tag with column collation when possible' then
      begin
        checkCollation.Checked := (aValue = 'True');
      end
      else if aKey = 'User ID' then
      begin
        editBenutzer.Text     := aValue;
        radioUserName.Checked := true;
      end
      else if aKey = 'Password' then
      begin
        editPasswort.Text := aValue;
      end
      else if aKey = 'Packet Size' then
      begin
        editPacketSize.Text := aValue;
      end;
    end;
  end;

end;

procedure TFormDBSelect.clearGui;
begin
  editProvider.Text                := '';
  editDataBase.Text                := '';
  editServer.Text                  := '';
  editBenutzer.Text                := '';
  editPasswort.Text                := '';
  editPacketSize.Text              := '';
  radioWindows.Checked             := true;
  checkPersistSecurityInfo.Checked := false;
  checkProcedureForPrepare.Checked := false;
  checkAutoTranslate.Checked       := false;
  checkDataEncryption.Checked      := false;
  checkCollation.Checked           := false;
end;

procedure TFormDBSelect.FormCreate(Sender: TObject);
begin
  FConfigList := TStringList.create;
  FListIndex  := 0;
end;

procedure TFormDBSelect.FormDestroy(Sender: TObject);
begin
  freeAndNil(FConfigList);
end;

procedure TFormDBSelect.FormShow(Sender: TObject);
begin
  loadData();
end;

procedure TFormDBSelect.loadData;
begin
  FConfigList.LoadFromFile(FConfigFile);
  if FConfigList.Count > 0 then
  begin
    fillGuiFromConnectionString(FConfigList[0]);
  end;
  setLabelIndexCaption();
end;

procedure TFormDBSelect.setLabelIndexCaption;
begin
  labelIndexCaption.caption := intToStr(FListIndex + 1) + '/' + intToStr(FConfigList.Count);
end;

end.
