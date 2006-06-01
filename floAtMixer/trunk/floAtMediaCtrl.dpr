program floAtMediaCtrl;

uses
  Windows,
  Forms,
  FormVolumeCtrl in 'FormVolumeCtrl.pas' {FormVolumeDisp},
  VolumeCtrlCoClass in 'VolumeCtrlCoClass.pas' {VolumeCtrl: CoClass},
  floAtMediaCtrl_TLB in 'floAtMediaCtrl_TLB.pas',
  FormVolume in 'FormVolume.pas' {FormVolumeBar},
  FormOptions in 'FormOptions.pas' {FormSettings},
  MouseCtrlCoClass in 'MouseCtrlCoClass.pas',
  uFormOsd in 'uFormOsd.pas' {FormOSD},
  uVersion in '..\fma\uVersion.pas';

{$R *.TLB}

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'floAt''s Media Control';
  Application.CreateForm(TFormVolumeDisp, FormVolumeDisp);
  Application.CreateForm(TFormSettings, FormSettings);
  Application.CreateForm(TFormVolumeBar, FormVolumeBar);
  Application.ShowMainForm := False;
  Application.Run;
end.
