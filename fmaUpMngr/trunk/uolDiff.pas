unit uolDiff;

{
*******************************************************************************
* Descriptions: Build FMA patches.
* $Source: /cvsroot/fma/fmaUpdmngr/uolDiff.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uolDiff.pas,v $
* Revision 1.1  2005/09/03 01:11:41  z_stoichev
* Initial checkin.
*
*
}

interface

function IsUOLDiffAvailable: boolean;

type
  TDiffMethod = (
    dmFastest,       // Fastest ;-)
    dmOptimal        // Depends on TDiffOptimalIndex value. See below
  );

  TDiffOptimalIndex = 1..10; // used for dmOptimal customization
  
  TDiffCompression = (
    dcNone,          // No compression is used
    dcZlib,          // Zlib based compression
    dcLh5            // LHarc based compression (Obsolete in Inno Setup release)
  );

  TDiffEncryption = (
    deNone,          // No encoding is used
    deXor            // XOR based encoding
  );

  TDiffScaning = (
    dsFile,          // Just a file.
    dsFolder,        // Files in a folder.
    dsTree           // Files in a folder and sub-folders.
  );

  TUOLCallback = procedure(CurProccesed,CurTotal: Integer; var Canceled: boolean) of Object;

var
  UOLBuildPatch: function(Source: PChar; Target: PChar; DiffFilename: PChar;
    ScanMode: TDiffMethod;           // dmFastest, dmOptimal (see ScanDeep)
    ScanDeep: TDiffOptimalIndex;     // 1..10 (ignored if ScanMode = dmFastest)
    ScanWhat: TDiffScaning;          // dsFile, dsFolder, dsTree
    PackMethod: TDiffCompression;    // dcNone, dcZlib, dcLh5
    CryptMethod: TDiffEncryption;    // deNone, deXor
    Password: PChar; Callback: TUOLCallback): boolean; stdcall;
  UOLReleaseNotes: function(Target: PChar; Count: Integer): integer; stdcall;

implementation

uses
  Windows;

var
  uoldiffdll: THandle;

function IsUOLDiffAvailable: boolean;
begin
  Result := uoldiffdll <> 0;
end;

initialization
  uoldiffdll := LoadLibrary('UOLDiff.dll'); // do not localize
  if uoldiffdll <> 0 then begin
    UOLBuildPatch := GetProcAddress(uoldiffdll,'UOLBuildPatch'); // do not localize
    UOLReleaseNotes := GetProcAddress(uoldiffdll,'UOLReleaseNotes'); // do not localize
  end;
finalization
  if uoldiffdll <> 0 then begin
    FreeLibrary(uoldiffdll);
    uoldiffdll := 0;
  end;
end.

