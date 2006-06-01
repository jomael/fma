library WinampCOMLib;

uses
  ComServ,
  WinampCOMLib_TLB in 'WinampCOMLib_TLB.pas',
  uWinampCOMObj in 'uWinampCOMObj.pas' {WinampCOMObj: CoClass};

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.TLB}

{$R *.RES}

begin
end.
