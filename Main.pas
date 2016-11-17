unit Main;

{$MODE Delphi}

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, MD5Api, Core;

type
  TMainForm = class(TForm)
    PasswordLbl: TLabel;
    PasswordEdit: TEdit;
    IVLbl: TLabel;
    IVEdit: TEdit;
    SepBevel1: TBevel;
    FileLbl: TLabel;
    FileEdit: TEdit;
    BrowseBtn: TButton;
    SepBevel2: TBevel;
    EncryptBtn: TButton;
    DecryptBtn: TButton;
    QuitBtn: TButton;
    Bar: TProgressBar;
    OpenDlg: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure QuitBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EncryptBtnClick(Sender: TObject);
    procedure BrowseBtnClick(Sender: TObject);
  private

  public

  end;

var
  MainForm: TMainForm;
  Stop: Boolean;

implementation

{$R *.lfm}

function Callback(C, N: Longword): Boolean;
begin
 if N = C then MainForm.Bar.Max := 0 else
  if C and $FFFF = 0 then
   begin
    MainForm.Bar.Max := N;
    MainForm.Bar.Position := C;
    Application.ProcessMessages;
   end;

 Result := Stop;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 DoubleBuffered := True;
 Bar.DoubleBuffered := True;
end;

procedure TMainForm.QuitBtnClick(Sender: TObject);
begin
 Close;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Stop := True;
end;

function IsValidInt64(S: String): Boolean;
Var
 I: Longword;
begin
 Result := (Length(S) = 16);
 if Result then
  for I := 1 to 16 do
   if not (S[I] in ['a'..'f', 'A'..'F', '0'..'9']) then
    begin
     Result := False;
     Exit;
    end;
end;

procedure TMainForm.EncryptBtnClick(Sender: TObject);
const
 INDSTR: array [Boolean] of ShortString = ('шифрование', 'дешифрование');
Var
 H: TMD5Data;
 Key: TSubkeys;
 IV: Int64;
 DoDecrypt, Failed: Boolean;
begin
 DoDecrypt := Boolean(TButton(Sender).Tag);

 H := MD5DataFromString(PasswordEdit.Text);
 KeySchedule(H, SizeOf(H), Key);
 if IsValidInt64(IVEdit.Text) then IV := StrToInt64(Format('$%s', [IVEdit.Text])) else raise Exception.Create('Вектор инициализации является недействительным. Он должен состоять из 16 символов!');
 Failed := False;

 FileEdit.Enabled := False;
 EncryptBtn.Enabled := False;
 DecryptBtn.Enabled := False;
 IVEdit.Enabled := False;
 PasswordEdit.Enabled := False;
 BrowseBtn.Enabled := False;

 if not FileExists(FileEdit.Text) then raise Exception.Create('Файл не существует!') else
  if EncryptFile(FileEdit.Text, Key, IV, DoDecrypt, Callback) then MessageDlg('Файл ' + FileEdit.Text + ' успешно перенес процесс "' + INDSTR[DoDecrypt] + '"!', mtInformation, [mbOK], 0) else Failed := True;

 FileEdit.Enabled := True;
 EncryptBtn.Enabled := True;
 DecryptBtn.Enabled := True;
 IVEdit.Enabled := True;
 PasswordEdit.Enabled := True;
 BrowseBtn.Enabled := True;

 if Failed then raise Exception.Create('При выполнении действия "' + INDSTR[DoDecrypt] + '" произошла ошибка!!');
end;

procedure TMainForm.BrowseBtnClick(Sender: TObject);
begin
 if OpenDlg.Execute then FileEdit.Text := OpenDlg.FileName;
end;

end.
