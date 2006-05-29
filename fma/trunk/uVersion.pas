unit uVersion;

{
*******************************************************************************
* Descriptions: Retrieve file version information
* $Source: /cvsroot/fma/fma/uVersion.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uVersion.pas,v $
* Revision 1.2  2005/02/08 15:38:56  voxik
* Merged with L10N branch
*
* Revision 1.1.16.2  2004/10/25 20:21:57  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.1.16.1  2004/10/19 19:48:49  expertone
* Add localization (gnugettext)
*
* Revision 1.1  2003/12/09 16:09:31  z_stoichev
* Initial checkin.
*
*
*
}

interface

uses
  Windows, TntWindows, SysUtils, TntSysUtils;

function ExtractFileVersionInfo(FileName,ExtractWhat: string): string;

implementation

{ Usage Example:

  Label1.Caption := ExtractFileVersionInfo(Application.ExeName,'FileVersion'); // do not localize
}

function ExtractFileVersionInfo(FileName,ExtractWhat: string): string;
type
  warr = array[0..1] of word;
  pwarr = ^warr;
var
  si: DWORD;
  dw: DWORD;
  pc: pointer;
  ss: pointer;
  ee: pointer;
  ll: UINT;
  la: string;
begin
  Result := '';
  si := GetFileVersionInfoSize(PChar(FileName),dw);
  if si <> 0 then
    begin
      GetMem(pc,si);
      try
        if GetFileVersionInfo(PChar(FileName),dw,si,pc) then
          begin
            if VerQueryValue(pc,PChar('\VarFileInfo\Translation'),ss,ll) and  // do not localize
              (ll >= 4) then // 4 = 2*sizeof(word) - at least one pair exists!
              begin
                la := Format('\StringFileInfo\%.4x%.4x\',[pwarr(ss)^[0],pwarr(ss)^[1]]);  // do not localize
                if VerQueryValue(pc,PChar(la+ExtractWhat),ee,ll) and (ll <> 0) then
                  Result := StrPas(PChar(ee));
              end;
          end;
      finally
        FreeMem(pc,si);
      end;
    end;
end;

end.
