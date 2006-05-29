unit uolInetGet;

{
*******************************************************************************
* Descriptions: Downloads file(s) from Internet using Windows Inet APIs.
* $Source: /cvsroot/fma/fma/components/uolInetGet.pas,v $
* $Locker:  $
*
* Todo:
*      - bypass proxy contents support
*
* Change Log:
* $Log: uolInetGet.pas,v $
* Revision 1.2  2004/10/11 13:15:47  voxik
* Merged with Calendar branch (Fma 0.1.2.10)
*
* Revision 1.1.4.1  2004/07/02 09:36:36  z_stoichev
* merged with changes made in HEAD meanwhile
*
* Revision 1.1.2.1  2004/03/08 21:35:55  z_stoichev
* Merged with HEAD build 0.1.0.32a.
* Plus some GUI changes.
*
* Revision 1.1  2004/03/07 14:32:23  z_stoichev
* Initial release (moved here from fma folder, ranamed)
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
  Windows;

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

