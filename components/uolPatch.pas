unit uolPatch;

{
*******************************************************************************
* Descriptions: Apply FMA patches.
* $Source: /cvsroot/fma/fma/components/uolPatch.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uolPatch.pas,v $
* Revision 1.2  2005/02/08 15:39:09  voxik
* Merged with L10N branch
*
* Revision 1.1.4.1  2005/01/07 18:06:52  expertone
* Merge with MAIN branch
*
* Revision 1.1  2004/12/18 17:18:08  z_stoichev
* Use UOLPatch.DLL instead of DosPatch.EXE
* Some Web Update bugfixes.
*
*
}

interface

function IsUOLPatchAvailable: boolean;

type
  TUOLCallback = procedure(CurProccesed,CurTotal: Integer; var Canceled: boolean) of Object;

var
  UOLApplyPatch: function(DiffFilename: PChar; Password: PChar; Callback: TUOLCallback): boolean; stdcall;
  UOLReleaseNotes: function(Target: PChar): integer; stdcall;

implementation

uses
  Windows;

var
  uolpatchdll: THandle;

function IsUOLPatchAvailable: boolean;
begin
  Result := uolpatchdll <> 0;
end;

initialization
  uolpatchdll := LoadLibrary('UOLPatch.dll'); // do not localize
  if uolpatchdll <> 0 then begin
    UOLApplyPatch := GetProcAddress(uolpatchdll,'UOLApplyPatch'); // do not localize
    UOLReleaseNotes := GetProcAddress(uolpatchdll,'UOLReleaseNotes'); // do not localize
  end;
finalization
  if uolpatchdll <> 0 then begin
    FreeLibrary(uolpatchdll);
    uolpatchdll := 0;
  end;
end.

