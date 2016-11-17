program CFB_Crypter;

{$MODE Delphi}

uses
  Forms, Interfaces,
  Main in 'Main.pas' {MainForm};


{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Шифровальщик файлов';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
