unit gginitialize;

{
*******************************************************************************
* Descriptions: GetText initialization routines.
* $Source: /cvsroot/fma/fma/gginitialize.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: gginitialize.pas,v $
* Revision 1.2.2.2  2006/02/23 10:18:37  z_stoichev
* Added Header comments.
*
*
}

interface

implementation

uses
  gnugettext, Windows;

var
  i: Integer;
  L: string;
  LSize: DWORD;
  LType: DWORD;
  TempKey: HKey;

initialization
  /// Current language
  L := '';
  for i := 1 to ParamCount do
    if Pos('-LANG', AnsiUpper(PChar(ParamStr(i)))) = 1 then // do not localize
      begin
        L := ParamStr(i);
        Delete(L, 1, Pos('=', L));
        break;
      end;
  if L = '' then
    begin
      // do not use TRegistry
      if RegOpenKeyEx(HKEY_CURRENT_USER, 'Software\floAt\MobileAgent', 0, KEY_READ, TempKey) = ERROR_SUCCESS then // do not localize
        begin
          if (RegQueryValueEx(TempKey, 'LANG', nil, @LType, nil, @LSize) = ERROR_SUCCESS) and (LType = REG_SZ) then // do not localize
            begin
              SetLength(L, LSize);
              RegQueryValueEx(TempKey, 'LANG', nil, @LType, @L[1], @LSize); // do not localize
              L := string(PChar(@L[1])); // Remove #0 at end of string
            end;
          RegCloseKey(TempKey);
        end;
    end;
  if Pos('AUTO', AnsiUpper(Pchar(@L[1]))) = 1 then // do not localize
    L := '';
  UseLanguage(L); // L='' -> from LANG env. variable OR Windows locale

  /// GG: Additional text translation domains
  {$IFDEF VER140} // Delphi 6
  AddDomainForResourceString('delphi6'); // do not localize
  AddDomainForResourceString('delphi7'); // do not localize
  {$ENDIF}
  {$IFDEF VER150} // Delphi 7
  AddDomainForResourceString('delphi7'); // do not localize
  AddDomainForResourceString('delphi6'); // do not localize
  {$ENDIF}
  AddDomainForResourceString('delphi'); // do not localize
  AddDomainForResourceString('default'); // do not localize
end.

