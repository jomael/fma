unit uInetGet;

{
*******************************************************************************
* Descriptions: Downloads file(s) from Internet using Windows Inet APIs.
* $Source: /cvsroot/fma/fma/uInetGet.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uInetGet.pas,v $
* Revision 1.3  2005/02/08 15:38:51  voxik
* Merged with L10N branch
*
* Revision 1.2.16.1  2004/10/25 20:21:42  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.2  2003/12/17 11:37:19  z_stoichev
* Simple mode changes.
*
* Revision 1.1  2003/12/11 14:17:25  z_stoichev
* Initil checkin.
*
*
*
}

interface

function IsInetDownloadAvailable: boolean;

var
  InetDownload: function (hWnd: Integer; URL, Filename: PChar): Integer; stdcall;
  InetAddFile: procedure (URL, Filename: PChar); stdcall;
  InetAddFileSize: procedure (URL, Filename: PChar; Size: Cardinal); stdcall;
  InetDownloadFiles: function (hWnd: Integer): Integer; stdcall;
  InetClearFiles: procedure; stdcall;
  InetIsConnected: function: Integer; stdcall;
  InetSetOption: function (Option, Value: PChar): Integer; stdcall;
  InetGetFileName: function (URL: PChar): PChar; stdcall;

procedure InitInetDownload(ATitle,ALabel,ADescription: string; SimpleMode: boolean = False; ResumeDownloads: boolean = True);

implementation

uses
  Windows, TntWindows;

var
  isxdl: THandle;

function IsInetDownloadAvailable: boolean;
begin
  Result := isxdl <> 0;
end;

procedure InitInetDownload(ATitle,ALabel,ADescription: string; SimpleMode,ResumeDownloads: boolean);
begin
  if IsInetDownloadAvailable then begin
    InetClearFiles;
    InetSetOption('title',PChar(ATitle));
    InetSetOption('label',PChar(ALabel));
    InetSetOption('description',PChar(ADescription));
    if ResumeDownloads then
      InetSetOption('resume','true')
    else
      InetSetOption('resume','false');
    if SimpleMode then
      InetSetOption('simple',PChar(ADescription))
    else
      InetSetOption('simple','');
  end;
end;

initialization
  isxdl := LoadLibrary('isxdl.dll');
  if isxdl <> 0 then begin
    InetDownload := GetProcAddress(isxdl,'isxdl_Download');
    InetAddFile := GetProcAddress(isxdl,'isxdl_AddFile');
    InetAddFileSize := GetProcAddress(isxdl,'isxdl_AddFileSize');
    InetDownloadFiles := GetProcAddress(isxdl,'isxdl_DownloadFiles');
    InetClearFiles := GetProcAddress(isxdl,'isxdl_ClearFiles');
    InetIsConnected := GetProcAddress(isxdl,'isxdl_IsConnected');
    InetSetOption := GetProcAddress(isxdl,'isxdl_SetOption');
    InetGetFileName := GetProcAddress(isxdl,'isxdl_GetFileName');
  end;
finalization
  if isxdl <> 0 then begin
    FreeLibrary(isxdl);
    isxdl := 0;
  end;
end.

