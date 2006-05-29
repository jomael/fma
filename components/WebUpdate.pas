unit WebUpdate;

{
*******************************************************************************
* Descriptions: Web Update for FMA
* $Source: /cvsroot/fma/fma/components/WebUpdate.pas,v $
* $Locker:  $
*
* Change Log:
* $Log: WebUpdate.pas,v $
* Revision 1.19.2.6  2006/03/17 13:46:24  z_stoichev
* Added Patch MD5 Signing.
*
* Revision 1.26  2005/09/02 13:03:52  z_stoichev
* Fixed Statrup Web Update when new version found.
*
* Revision 1.25  2005/09/01 09:11:13  z_stoichev
* - Fixed AV errors on WebUpdate intermediate restart.
* - Changed WebUpdate Wizard show notes in new page.
*
* Revision 1.24  2005/08/29 14:02:16  z_stoichev
* Added Mirrors support.
* Various bugfixes and GUI changes.
*
* Revision 1.23  2005/08/23 12:57:15  z_stoichev
* Web Update improvements.
*
* Revision 1.22  2005/08/23 08:20:10  z_stoichev
* Web Update fixes.
*
* Revision 1.21  2005/05/17 12:56:12  z_stoichev
* no message
*
* Revision 1.20  2005/04/07 15:37:45  z_stoichev
* Crash on web update finish workarounds.
*
* Revision 1.19  2005/03/01 11:29:14  z_stoichev
* Add components to FMA pallete.
*
* Revision 1.18  2005/02/12 17:57:05  z_stoichev
* Use sLinebreak and Unicode dialog boxes.
*
* Revision 1.17  2005/02/11 15:54:46  z_stoichev
* Fixed Modal error on Finishing page.
* Fixed sLinebreak usage.
*
* Revision 1.16  2005/02/08 15:39:08  voxik
* Merged with L10N branch
*
* Revision 1.9.12.1  2005/01/07 17:57:48  expertone
* Merge with MAIN branch
*
* Revision 1.15  2004/12/21 13:31:21  z_stoichev
* bugfixes
*
* Revision 1.14  2004/12/21 11:38:41  z_stoichev
* New Wizard bugfixes
*
* Revision 1.13  2004/12/20 16:30:27  z_stoichev
* New Web Update Wizard
*
* Revision 1.12  2004/12/18 17:18:08  z_stoichev
* Use UOLPatch.DLL instead of DosPatch.EXE
* Some Web Update bugfixes.
*
* Revision 1.11  2004/12/16 10:10:17  z_stoichev
* Fixed apply patch while Fma is still running error.
*
* Revision 1.10  2004/11/22 09:59:23  z_stoichev
* Fixed web update failrure while success reported (I hope).
*
* Revision 1.9  2004/06/05 13:30:28  lordlarry
* Merged with OutlookSync branch
*
* Revision 1.8  2004/05/19 18:34:20  z_stoichev
* Build 0.1.0.35c
*
* Revision 1.7  2004/03/26 14:27:22  z_stoichev
* Fixed broken web update - AV bug.
*
* Revision 1.6  2004/03/20 16:25:22  z_stoichev
* FindPossibleVersions implemented
* Added Web Update Wizard installation/help hints.
*
* Revision 1.5  2004/03/13 10:26:55  z_stoichev
* Wait for patch to exit before get Notes.
*
* Revision 1.4  2004/03/09 15:17:59  z_stoichev
* Fixed local update name passed to patch tool.
*
* Revision 1.3  2004/03/09 10:31:16  z_stoichev
* Allow updates to full version.
* Show status dialog with info.
*
* Revision 1.2  2004/03/07 14:35:12  z_stoichev
* Added Ready to Install wizard page.
*
* Revision 1.1  2004/03/07 11:39:19  z_stoichev
* Initial release.
*
*
}

interface

uses
  Windows, Messages, SysUtils, Controls, Classes, Graphics, uolSelectPatchPath,
  WebUpdateWizard;

type
  TWebUpdateError = procedure (Sender: TObject; Message: string) of object;
  TWebUpdateNotes = procedure (Sender: TObject; Text: string) of object;
  TWebRestartEvent = procedure (Sender: TObject; var AllowRestart: boolean) of object;
  TWebUpdateShow = (wuSilant,wuWizardOnUpdate,wuWizardAlways);

  TFmaWebUpdate = class(TComponent)
  private
    { Private declarations }
    FOnError: TWebUpdateError;
    FOnBeforeRestart: TWebRestartEvent;
    FOnAfterRestart: TWebUpdateNotes;
    FBaseURL: string;
    FImage: TPicture;
    FImageSmall: TPicture;
    FReady: string;
    FSupportURL: string;
    FAppName: string;
    FLogName: string;
    FLogVerbose: boolean;
    procedure Set_Image(const Value: TPicture);
    procedure Set_ImageSmall(const Value: TPicture);
    function Get_Build: string;
    procedure Set_Build(const Value: string);
    procedure Set_LogName(const Value: string);
    function Get_Active: boolean;
  protected
    { Protected declarations }
    dlg: TfrmWebUpdate;
    URL,SaveAs,Filename,ExePath: string;
    UsePatch,UseWeb: boolean;
    UpdateIndex: TuolSelectPatchPath;
    function GetTempExeName: string;
    function DoApplyUpdate: boolean; // True if app should be stopped immediately
    procedure DoShowError(Message: string);
    procedure Loaded; override;
    procedure OnDecompress(Sender: TObject);
    procedure OnWizardReady(Sender: TObject);
    function OnGetversionDetails(const FromVersionSignature, ToVersionSignature: string;
      Path: TStrings): Int64;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function NewUpdateExists(CurBuild: string = ''; WizardMode: TWebUpdateShow = wuSilant): string;
    procedure CheckforUpdate(CurBuild: string = ''; Updates: TuolSelectPatchPath = nil);
    procedure UpdateCallback(CurProccesed,CurTotal: Integer; var Canceled: boolean);
  private
    { Private declarations }
    FRestarting: boolean;
    FDecompressFileSize: Integer;
    function DoRetrieveUpdateIndex: TuolSelectPatchPath;
  published
    { Published declarations }
    property Active: boolean read Get_Active;
    property UpdatesURL: string read FBaseURL write FBaseURL;
    property SupportURL: string read FSupportURL write FSupportURL;
    property AppName: string read FAppName write FAppName;
    property ReadyText: string read FReady write FReady;
    property Picture: TPicture read FImage write Set_Image;
    property PictureSmall: TPicture read FImageSmall write Set_ImageSmall;
    property CurrentBuild: string read Get_Build write Set_Build;
    property LogFilename: string read FLogName write Set_LogName;
    property LogVerbose: boolean read FLogVerbose write FLogVerbose;
    property OnError: TWebUpdateError read FOnError write FOnError;
    property OnBeforeUpdate: TWebRestartEvent read FOnBeforeRestart write FOnBeforeRestart;
    property OnAfterUpdate: TWebUpdateNotes read FOnAfterRestart write FOnAfterRestart;
  end;

procedure Register;

function ApplicationVersionInfo(ExtractWhat: string): string;

implementation

uses
  gnugettext,
  Dialogs, uDialogs, Forms, ShellAPI, uolInetGet, uolPatch, zlib, TntCheckLst, IcsMD5;

procedure Register;
begin
  RegisterComponents('FMA', [TFmaWebUpdate]); // do not localize
end;

function ApplicationVersionInfo(ExtractWhat: string): string;
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
  la,FileName: string;
begin
  Result := '';
  FileName := Application.ExeName;
  si := GetFileVersionInfoSize(PChar(FileName),dw);
  if si <> 0 then
    begin
      GetMem(pc,si);
      try
        if GetFileVersionInfo(PChar(FileName),dw,si,pc) then
          begin
            if VerQueryValue(pc,PChar('\VarFileInfo\Translation'),ss,ll) and // do not localize
              (ll >= 4) then // 4 = 2*sizeof(word) - at least one pair exists!
              begin
                la := Format('\StringFileInfo\%.4x%.4x\',[pwarr(ss)^[0],pwarr(ss)^[1]]); // do not localize
                if VerQueryValue(pc,PChar(la+ExtractWhat),ee,ll) and (ll <> 0) then
                  Result := StrPas(PChar(ee));
              end;
          end;
      finally
        FreeMem(pc,si);
      end;
    end;
end;

{ TFmaWebUpdate }

procedure TFmaWebUpdate.CheckforUpdate(CurBuild: string;
  Updates: TuolSelectPatchPath);
var
  i,j: integer;
  sl: TStringList;
begin
  if Trim(FBaseURL) = '' then begin
    DoShowError(_('Could not perform Web Update without Updates URL.'));
    if Assigned(Updates) then FreeAndNil(Updates);
    exit;
  end;
  if Trim(CurBuild) = '' then CurBuild := CurrentBuild;
  if Trim(CurBuild) = '' then begin
    DoShowError(_('Could not perform Web Update with unknown App build.'));
    if Assigned(Updates) then FreeAndNil(Updates);
    exit;
  end;
  { Check for update }
  if Assigned(Updates) then UpdateIndex := Updates
    else UpdateIndex := DoRetrieveUpdateIndex;
  { Process updates }
  with TfrmWebUpdate.CreateImg(nil,FImage,FImageSmall) do
    try
      lblNameVer.Caption := CurBuild;
      lbDescription.Caption := Format(_('This wizard will help you update the %s via Internet or '+
        'through an update file provided by application vendor.'),[FAppName]);
      if IsUOLPatchAvailable then
        if UseWeb and Assigned(UpdateIndex) then begin
          { fill mirrors list }
          clMirrors.Clear;
          for i := 0 to UpdateIndex.Mirrors.Count-1 do begin
            if i > (SizeOf(Integer)*8 - 1) then
              continue; // HACK! because SelectedCustomMirrors is TIntegerSet!! 
            clMirrors.Items.Add(UpdateIndex.GetMirrorName(i));
            clMirrors.Checked[i] := UpdateIndex.GetMirrorBaseURL(i) = UpdateIndex.GetDefaultMirrorBaseURL;
          end;
          { fill versions list }
          clNumbers.Clear;
          sl := TStringList.Create;
          try
            UpdateIndex.FindPossibleVersions(CurBuild,sl);
            // sl is sorted
            for i := 0 to sl.Count-1 do begin
              j := UpdateIndex.Graph.IndexOf(sl[i]);
              if j <> -1 then begin
                clNumbers.Items.Add(sl[i]);
                clNumbers.Items.Objects[clNumbers.Count-1] := pointer(j);
              end;
            end;
          finally
            sl.Free;
          end;
          if clNumbers.Items.Count <> 0 then begin
            clNumbers.TopIndex := clNumbers.Items.Count - (clNumbers.Height div clNumbers.ItemHeight);
            i := clNumbers.Items.IndexOf(CurBuild);
            if i <> -1 then clNumbers.ItemEnabled[i] := False;
            { Are we up to date? 
            i := UpdateIndex.Graph.IndexOf(Build);
            if (i = -1) or (i = UpdateIndex.Graph.IndexOf(clNumbers.Items[clNumbers.Items.Count-1])) then begin
            }
            if CompareText(CurBuild,clNumbers.Items[clNumbers.Items.Count-1]) = 0 then begin
              { using unknown or latest version, so allow only downgrade options }
              RadioButton2.Caption := _('Downgrade to a previous version:');
              RadioButton2.Checked := True;
              RadioButtonClick(nil);
              RadioButton3.Visible := False;
              ShowWarning(Format(_('You are using the latest %s version.'),[FAppName]),noNewVersion);
            end;
          end
          else
            { no updates are EVER available, so thread it as a fatal error - stop wizard }
            ShowWarning(_('No new updates are available over Internet right now.'+sLinebreak+sLinebreak+
              'You could try again later or you could proceed if you have local update files.'),
              noWebUpdates);
        end
        else begin
          if UseWeb then
            { we have Inet connection, but cant download updates index file, so local updates only }
            ShowWarning(Format(_('Updates catalog for %s could not be located (or download failed) on web site '+
              sLinebreak+sLinebreak+'%s'+sLinebreak+sLinebreak+'You could try again later or you could proceed if you '+
              'have local update files (Web updates are disabled).'),[FAppName,FBaseURL]),
              noWebUpdates)
          else
            { no Inet connection, so allow only local update (web update is selected by default) }
            ShowWarning(Format(_('In order to use Web Update feature, you have to download a small library '+
              'ISXDL.DLL from %s web site '+sLinebreak+sLinebreak+'%s'+sLinebreak+sLinebreak+'Place it in your %0:s'+
              ' folder and restart application.'+sLinebreak+sLinebreak+'If you do not want to restart '+
              'right now you could proceed using local update files only (Web updates are disabled).'),[FAppName,FSupportURL]),
              noWebUpdates);
        end
      else begin
        { no Patch tools, so disable all updates }
        ShowWarning(Format(_('In order to use Update feature, you have to download a small library '+
          'UOLPATCH.DLL from %s web site'+sLinebreak+sLinebreak+'%s'+sLinebreak+sLinebreak+'Place it in '+
          '%0:s folder and restart application.'),[FAppName,FSupportURL]),noPatchTool);
      end;
      OnReadyToDownload := OnWizardReady;
      OnGetDetails := OnGetversionDetails;
      { show wizard to user }
      if ShowModal <> mrOk then Abort;
    finally
      if Assigned(UpdateIndex) then FreeAndNil(UpdateIndex);
      Free;
    end;
  { Apply the patch, if any (patch file names should be stored in Filename) }
  if UsePatch then begin
    { First ask user about this }
    with TfrmWebUpdate.CreateImg(nil,FImage,FImageSmall) do
      try
        UsePatch := ReadyToInstall(FReady); // modal
      finally
        Free;
      end;
    if UsePatch and Assigned(FOnBeforeRestart) then
      FOnBeforeRestart(Self,UsePatch);
    if UsePatch then begin
      { Ok, do it }
      SaveAs := GetTempExeName;
      if FileExists(SaveAs) then 
        try
          with TFileStream.Create(SaveAs,fmOpenWrite or fmShareExclusive) do Free;
        except
          DoShowError(Format(_('Con not access temporary file %s for writing'),[SaveAs]));
          exit;
        end;
      CopyFile(PChar(Application.ExeName),PChar(SaveAs),False);
      if ShellExecute(Application.Handle,'open',PChar(SaveAs),PChar('-u "'+Application.ExeName+'" "'+Filename+'"'),'', // do not localize
        SW_SHOWNORMAL) > 32 then begin
        FRestarting := True;
        Application.Terminate;
      end;
    end
    else
      DoShowError(_('Web update installation has been aborted'));
  end;
end;

procedure TFmaWebUpdate.OnWizardReady(Sender: TObject);
var
  sl: TStringList;
  i,m: integer;
  s: string;
  DownloadOK: boolean;
  function DownloadUpdates(ParentWnd: HWND; MirrorURL: string): boolean;
  var
    isok: boolean;
    i,j,k: integer;
    fn: string;
  begin
    Result := False;
    InetClearFiles;
    { add files to download queue }
    for i := 0 to sl.Count-1 do // -- easy way -- InetAddFile(PChar(FBaseURL+sl[i]),PChar(ExePath+sl[i]));
      for k := 0 to UpdateIndex.Graph.Count-1 do
        for j := 0 to TuolVersionInfo(UpdateIndex.Graph.Objects[k]).Patches.Count - 1 do
          with TuolPatchInfo(TuolVersionInfo(UpdateIndex.Graph.Objects[k]).Patches.Objects[j]) do
            if PatchURL = sl[i] then begin
              { we know file size, so add it to help downloader }
              InetAddFileSize(PChar(MirrorURL+PatchURL),PChar(ExePath+PatchURL),PatchSize);
            end;
    { ok, start downloading now... }
    if InetDownloadFiles(ParentWnd) = 1 then begin
      { check patches MD5 (if any) }
      isok := True;
      for i := 0 to sl.Count-1 do
        for k := 0 to UpdateIndex.Graph.Count-1 do
          for j := 0 to TuolVersionInfo(UpdateIndex.Graph.Objects[k]).Patches.Count - 1 do
            with TuolPatchInfo(TuolVersionInfo(UpdateIndex.Graph.Objects[k]).Patches.Objects[j]) do
              if PatchURL = sl[i] then begin
                fn := InetGetFileName(PChar(MirrorURL+sl[i]));
                if (PatchMD5 = '') or (PatchMD5 = FileMD5(fn)) then
                  sl[i] := fn
                else begin
                  isok := False;
                  break;
                end;
              end;
      { all done, save list of downloaded patches }
      if isok then begin
        sl.SaveToFile(SaveAs);
        Filename := SaveAs;
        UsePatch := True;
        Result := True;
      end
      else begin
        EnableWindow(ParentWnd,False);
        MessageBeep(MB_ICONERROR);
        MessageDlgW(WideFormat(_('Patch file "%s" failed MD5 check.'),[fn]),mtError,MB_OK);
        EnableWindow(ParentWnd,True);
      end;
    end;
  end;
begin
  with (Sender as TfrmWebUpdate) do begin
    sl := TStringList.Create;
    try
      if not RadioButton1.Checked then begin
        { use internet updates }
        i := integer(clNumbers.Items.Objects[CheckedIndex]); // [clNumbers.ItemIndex]);
        { find all patch files for selected target version, and then
          select those with smallest download size :) using Wave method }
        UpdateIndex.FindBestPath(lblNameVer.Caption,TuolVersionInfo(UpdateIndex.Graph.Objects[i]).VersionSignature,sl);
        { are updates available at all? }
        if sl.Count = 0 then
          raise Exception.Create(_('Operation not applicable at present time, no such updates are released yet'));
        { yes, download them... }
        InitInetDownload(_('Check For Update'),_('Automatic Updates'),
          _('Please wait while Fma downloads all appropriate update files from Fma web site...'),False,True);
        { iterate through all mirrors until success }
        DownloadOK := False;
        if rbMirrorCustom.Checked then begin
          for m := 0 to clMirrors.Count-1 do begin
            if m in SelectedCustomMirrors then
              if DownloadUpdates(Handle,UpdateIndex.GetMirrorBaseURL(m)) then begin
                DownloadOK := True;
                break;
              end;
          end;
        end
        else
          DownloadOK := DownloadUpdates(Handle,UpdatesURL);
        if not DownloadOK then Abort; // download failed, abort here to prevent wizard exit (so user can try again)
      end
      else begin
        { use local update only, copy to app dir, save its name in file and pass that file further }
        s := edLocal.Text;
        Filename := ExtractFilePath(SaveAs)+ExtractFileName(s);
        if (AnsiCompareText(Filename,s) <> 0) and not CopyFile(PChar(s),PChar(Filename),False) then
          raise EInOutError.Create(Format(_('Could not create file %s'),[Filename]));
        sl.Add(ExtractFileName(Filename));
        sl.SaveToFile(SaveAs);
        Filename := SaveAs;
        UsePatch := True;
      end;
    finally
      sl.Free;
    end;
  end;
end;

function TFmaWebUpdate.DoApplyUpdate: boolean; // True if app should be stopped immediately
var
  Path,AppFile,UpdateFile,TempFile,s,e: string;
  str,dst: TFileStream;
  Buffer: array[0..16383] of byte;
  NumRead: Integer;
  sl: TStringList;
  Notes: string;
  UpdateCount: Integer;
  function GetUpdateNotes(DoStrip: boolean = True): string;
  var
    i: integer;
    p: PChar;
  begin
    Result := '';
    { Show release notes, if any }
    p := nil;
    i := UOLReleaseNotes(p);
    GetMem(p,i);
    try
      UOLReleaseNotes(p);
      SetLength(Result,i);
      Move(p^,Result[1],i);
      if DoStrip then
        Result := sLinebreak+Result+sLinebreak;
    finally
      FreeMem(p,i);
    end;
  end;
  procedure WaitUntilClosed(Filename: string);
  var
    StartTime: TDateTime;
  begin
    if FileExists(Filename) then begin
      StartTime := Now;
      Sleep(1000);
      repeat
        Sleep(100);
        try
          with TFileStream.Create(Filename,fmOpenWrite or fmShareExclusive) do Free;
          break;
        except
          if (Now - StartTime) * SecsPerDay > 10 then begin
            if Assigned(dlg) then
              dlg.ShowStatus(Format(_('Application "%s" is still running. Please, close it manualy.'),
              [ExtractFileName(Filename)]));
          end;
          Application.ProcessMessages;
          if Assigned(dlg) and dlg.IsCanceled then Abort;
        end;
      until Application.Terminated;
    end;
  end;
begin
  Result := False;
  AppFile := ParamStr(2);
  Path := ExtractFilePath(AppFile);
  UpdateFile := ParamStr(3);
  if (UpperCase(ParamStr(1)) = '-U') and FileExists(UpdateFile) then begin // do not localize
    dlg := TfrmWebUpdate.CreateImg(nil,FImage,FImageSmall,_('Preparing Installation...'));
    try
      dlg.BringToFront;
      { Wait for calling application to terminate }
      WaitUntilClosed(AppFile);
      if FLogVerbose then
        Notes := _('*** Update started')+sLinebreak
      else
        Notes := '';  
      sl := TStringList.Create;
      try
        { get list of updates which has to be applied }
        sl.LoadFromFile(UpdateFile);
        UpdateCount := sl.Count;
        while sl.Count <> 0 do begin
          dlg.ShowStatus(Format(_('Applying patch "%s"...'),[sl[0]]),False);
          dlg.ShowTotalProgress(UpdateCount-sl.Count,UpdateCount);
          if FLogVerbose then
            Notes := Notes + '*** ' + sl[0];
          try
            e := UpperCase(ExtractFileExt(sl[0]));
            { Patch file }
            if (e = '.DIF') or (e = '.REV') then begin // do not localize
              try
                UOLApplyPatch(PChar(Path+sl[0]),'',UpdateCallback);
                Notes := Notes + GetUpdateNotes;
              except
                on e: Exception do begin
                  Notes := Notes + sLinebreak+e.Message+sLinebreak;
                  break;
                end;
              end;
              if dlg.IsCanceled then begin
                if FLogVerbose then
                  Notes := Notes + sLinebreak+_('*** User abort detected')+sLinebreak;
                break;
              end;
            end;
            { Whole application }
            if (e = '.EXE') then begin // do not localize
              if MoveFile(PChar(Path+sl[0]),PChar(AppFile)) then
                Notes := Notes + sLinebreak+_('- Application updated successfuly.')+sLinebreak
              else begin
                Notes := Notes + sLinebreak+_('- Application NOT updated (move failed).')+sLinebreak;
                break;
              end;
            end;
            { Whole compressed application }
            if (e = '.Z') then // do not localize
            try
              TempFile := ChangeFileExt(AppFile,'.Z$$');
              str := TFileStream.Create(Path+sl[0], fmOpenRead or fmShareDenyNone);
              try
                FDecompressFileSize := str.Size;
                dst := TFileStream.Create(TempFile, fmCreate or fmShareExclusive); // do not localize
                try
                  with TDecompressionStream.Create(str) do
                  try
                    repeat
                      Application.ProcessMessages;
                      if dlg.IsCanceled then Abort;
                      NumRead := Read(Buffer[0],SizeOf(Buffer));
                      if NumRead = 0 then break;
                      dst.Write(Buffer[0],NumRead);
                    until False;
                  finally
                    Free;
                  end;
                finally
                  dst.Free;
                end;
              finally
                str.Free;
              end;
              if not MoveFile(PChar(TempFile),PChar(AppFile)) then Abort;
              Notes := Notes + sLinebreak+_('- Application updated successfuly.')+sLinebreak;
            except
              DeleteFile(TempFile);
              Notes := Notes + sLinebreak+_('- Application NOT updated (decompress failed).')+sLinebreak;
              break;
            end;
          finally
            sl.Delete(0);
          end;
        end;
        { get all notes together }
        if FLogVerbose then
          Notes := Notes + _('*** Update finished');
        sl.Text := Notes;
        sl.SaveToFile(Path+FLogName);
      finally
        sl.Free;
      end;
    finally
      dlg.CancelButton.Enabled := False;
      dlg.ShowStatus(_('Restarting Application...'));
      { Start new application }
      WaitUntilClosed(AppFile);
      if ShellExecute(0,'open',Pchar(AppFile),PChar('+u "'+Application.ExeName+'" "'+UpdateFile+'"'), // do not localize
        Pchar(Path),SW_SHOWNORMAL) > 32 then begin
        FRestarting := True;
        Result := True; // True means App should be stopped immediately
      end;  
      dlg.Hide;
      FreeAndNil(dlg);
    end;
  end;
  if (UpperCase(ParamStr(1)) = '+U') then begin // do not localize
    dlg := TfrmWebUpdate.CreateImg(nil,FImage,FImageSmall,_('Finishing Installation...'));
    try
      dlg.BringToFront;
      { Wait for calling application to terminate }
      if FileExists(AppFile) then
      try
        WaitUntilClosed(AppFile);
        DeleteFile(AppFile);
      except
        { Ignore dlg.IsCanceled flag }
      end;
      try
        sl := TStringList.Create;
        try
          sl.LoadFromFile(Path+FLogName);
          s := sl.Text;
        finally
          sl.Free;
        end;
      except
        s := '';
      end;
      { hide install page (which is NOT modal) }
      dlg.CancelButton.Enabled := False;
      dlg.Hide;
      { show finished wizard page }
      dlg.UpdateCompleted(s); // show as modal
      { should we perform a cleanup? }
      if dlg.IsCleanupNeeded then begin
        sl := TStringList.Create;
        try
          { get list of updates which has to be DELETED }
          sl.LoadFromFile(UpdateFile);
          while sl.Count <> 0 do begin
            DeleteFile(Path+sl[0]);
            sl.Delete(0);
          end;
          DeleteFile(UpdateFile);
        finally
          sl.Free;
        end;
      end;
      if Assigned(FOnAfterRestart) then FOnAfterRestart(Self,s);
    finally
      FreeAndNil(dlg);
    end;
  end;
end;

procedure TFmaWebUpdate.DoShowError(Message: string);
begin
  if Assigned(FOnError) then
    FOnError(Self,Message)
  else begin
    MessageBeep(MB_ICONERROR);
    MessageDlgW(Message,mtError,MB_OK);
  end;
end;

procedure TFmaWebUpdate.Loaded;
begin
  inherited;
  if (UpperCase(ParamStr(1)) = '+U') or (UpperCase(ParamStr(1)) = '-U') then // do not localize 
    if not (csDesigning in ComponentState) then
      if DoApplyUpdate then
        Application.Terminate;
end;

constructor TFmaWebUpdate.Create(AOwner: TComponent);
begin
  inherited;
  FRestarting := False;
  FImage := TPicture.Create;
  FImageSmall := TPicture.Create;
  FAppName := 'application'; // do not localize
  FSupportURL := 'http://www.application.com/support'; // do not localize
  FBaseURL := 'http://www.application.com/updates'; // do not localize
  FLogName := 'update.txt'; // do not localize
end;

destructor TFmaWebUpdate.Destroy;
begin
  try
    FreeAndNil(FImage);
    FreeAndNil(FImageSmall);
  except
  end;
  inherited;
end;

procedure TFmaWebUpdate.Set_Image(const Value: TPicture);
begin
  FreeAndNil(FImage);
  FImage := TPicture.Create;
  FImage.Assign(Value);
end;

procedure TFmaWebUpdate.Set_ImageSmall(const Value: TPicture);
begin
  FreeAndNil(FImageSmall);
  FImageSmall := TPicture.Create;
  FImageSmall.Assign(Value);
end;

function TFmaWebUpdate.GetTempExeName: string;
begin
  Result := ExtractFilePath(Application.ExeName)+'_wupd$$$.exe'; // do not localize
end;

procedure TFmaWebUpdate.UpdateCallback(CurProccesed, CurTotal: Integer; var Canceled: boolean);
begin
  if Assigned(dlg) and (CurTotal <> 0) then begin
    dlg.ShowProgress(100*CurProccesed div CurTotal);
    Canceled := dlg.IsCanceled;
  end;
end;

function TFmaWebUpdate.OnGetversionDetails(const FromVersionSignature,
  ToVersionSignature: string; Path: TStrings): Int64;
begin
  Result := UpdateIndex.FindBestPath(FromVersionSignature,ToVersionSignature,Path);
end;

function TFmaWebUpdate.Get_Build: string;
begin
  if csDesigning in ComponentState then
    Result := '(unknown)' // do not localize
  else
    Result := ApplicationVersionInfo('FileVersion'); // do not localize
end;

procedure TFmaWebUpdate.Set_Build(const Value: string);
begin
  { Ignore chnages }
end;

procedure TFmaWebUpdate.Set_LogName(const Value: string);
begin
  FLogName := ExtractFileName(Value);
  if ExtractFileExt(FLogName) = '' then FLogName := FLogName + '.txt' // do not localize
end;

function TFmaWebUpdate.NewUpdateExists(CurBuild: string; WizardMode: TWebUpdateShow): string;
var
  i,j: integer;
  sl: TStringList;
begin
  { Will return new update buil number, or empty string if none }
  Result := '';
  if Trim(CurBuild) = '' then CurBuild := CurrentBuild;
  if (Trim(FBaseURL) = '') or (Trim(CurBuild) = '') then
    exit;
  { Check for update }
  UpdateIndex := DoRetrieveUpdateIndex;
  { Process updates }
  if Assigned(UpdateIndex) then begin
    { fill versions list }
    sl := TStringList.Create;
    try
      UpdateIndex.FindPossibleVersions(CurBuild,sl);
      { sl is sorted, find newest available version }
      i := sl.Count-1;
      while i >= 0 do begin
        j := UpdateIndex.Graph.IndexOf(sl[i]);
        if j <> -1 then break;
        dec(i);
      end;
      if (i <> -1) and (CompareText(CurBuild,sl[i]) <> 0) then
        { new update found, return its build number }
        Result := sl[i];
    finally
      case WizardMode of
        wuSilant:
          FreeAndNil(UpdateIndex);
        wuWizardOnUpdate:
          if Result <> '' then begin // do we have any new update at all?
            i := UpdateIndex.FindBestPath(CurBuild,Result,sl);
            if MessageDlgW(WideFormat(_('New version found! %s has been released recently. '+sLineBreak+sLineBreak+
              'Update files are available for downloading (%.0n Kb). Do you want to start Web Update Wizard now?'),
              [FAppName+' '+Result,i / 1024]), mtConfirmation, MB_YESNO) = ID_YES then
              CheckforUpdate(CurBuild,UpdateIndex);
          end
          else
            FreeAndNil(UpdateIndex);
        wuWizardAlways:
          CheckforUpdate(CurBuild,UpdateIndex);
      end;
      sl.Free;
    end;
  end;
end;

function TFmaWebUpdate.DoRetrieveUpdateIndex: TuolSelectPatchPath;
var
  i: Integer;
  found: boolean;
begin
  Result := nil;
  UsePatch := False;
  UseWeb := IsInetDownloadAvailable;
  ExePath := ExtractFilePath(Application.ExeName);
  if FAppName = '' then FAppName := 'application'; // do not localize ?
  SaveAs := ChangeFileExt(Application.ExeName,'.lst'); // do not localize
  { Download updates index }
  if UseWeb then begin
    if FileExists(SaveAs) then
      try
        with TFileStream.Create(SaveAs,fmOpenWrite or fmShareExclusive) do Free;
      except
        DoShowError(Format(_('Con not access temporary file %s for writing'),[SaveAs]));
        exit;
      end;
    if FBaseURL[Length(FBaseURL)] <> '/' then FBaseURL := FBaseURL + '/';
    URL := FBaseURL + UpperCase(ChangeFileExt(ExtractFileName(Application.ExeName),'')) + '.updates'; // do not localize
    InitInetDownload(_('Check For Update'),_('Automatic Updates'),
      Format(_('Please wait while %s downloads a list of available updates...'),[FAppName]),True,False);
    if InetDownload(0,PChar(URL),PChar(SaveAs)) = 1 then begin
      Result := TuolSelectPatchPath.Create(SaveAs,'main','bin+null'); // do not localize
      Result.LoadMirrorsInfo(SaveAs);
      { check if vendor update URL is included into mirrors list }
      found := False;
      for i := 0 to Result.Mirrors.Count-1 do
        { do a case-sensitive check here }
        if CompareStr(UpdatesURL,Result.GetMirrorBaseURL(i)) = 0 then begin
          found := True;
          break;
        end;
      { if not found add it to mirrors }
      if not found then Result.SetDefaultMirror(FAppName,UpdatesURL);
    end;
  end;
end;

procedure TFmaWebUpdate.OnDecompress(Sender: TObject);
begin
  if Assigned(dlg) and (FDecompressFileSize <> 0) then begin
    dlg.ShowProgress(100*TDecompressionStream(Sender).Position div FDecompressFileSize);
  end;
end;

function TFmaWebUpdate.Get_Active: boolean;
begin
  Result := FRestarting;
end;

end.
