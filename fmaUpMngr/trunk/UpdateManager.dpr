program UpdateManager;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  uAddUpdate in 'uAddUpdate.pas' {frmAddUpdate},
  uEditMirror in 'uEditMirror.pas' {frmMirror},
  uolDiff in 'uolDiff.pas',
  uGenerate in 'uGenerate.pas' {frmBuild},
  uDiffOptions in 'uDiffOptions.pas' {frmDiffOptions},
  uPassword in 'uPassword.pas' {frmPassword},
  uOptions in 'uOptions.pas' {frmOptions},
  uVersion in '..\..\fma\trunk\uVersion.pas',
  uGlobal in '..\..\fma\trunk\uGlobal.pas';

{$R *.res}

begin
  with Application do SetDefFont;
  Application.Initialize;
  Application.Title := 'floAt''s Update Manager';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmAddUpdate, frmAddUpdate);
  Application.CreateForm(TfrmMirror, frmMirror);
  Application.CreateForm(TfrmBuild, frmBuild);
  Application.CreateForm(TfrmDiffOptions, frmDiffOptions);
  Application.CreateForm(TfrmPassword, frmPassword);
  Application.CreateForm(TfrmOptions, frmOptions);
  Application.Run;
end.
