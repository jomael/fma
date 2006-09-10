unit uGenerate;

{
*******************************************************************************
* Descriptions: Build Progress Dialog
* $Source: /cvsroot/fma/fmaUpdmngr/uGenerate.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uGenerate.pas,v $
* Revision 1.5  2006/03/17 14:18:40  z_stoichev
* Build 1.0.6.34 (MD5)
*
* Revision 1.4  2005/09/07 15:12:01  z_stoichev
* Bugfixes and improvements (1.0.5.28)
*
* Revision 1.3  2005/09/03 19:32:40  z_stoichev
* Fixed Engine setting for Small Update type.
*
* Revision 1.2  2005/09/03 11:29:36  z_stoichev
* Added Diff Engine Options dialog.
*
* Revision 1.1  2005/09/03 01:11:41  z_stoichev
* Initial checkin.
*
*
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, jpeg, TntExtCtrls;

type
  TfrmBuild = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    Button1: TButton;
    lblEstimated: TLabel;
    lblTimeLeft: TLabel;
    Timer1: TTimer;
    TntImage1: TTntImage;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormHide(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FCanceled,FExiting,FDifAndRev,FReverse: boolean;
    FStartTime: TDateTime;
    FTotalSize: Integer;
    FReadyUpdates: TStringList;
    procedure DoUpdateReady(Filename: string);
    procedure DoRollback;
    function DoCreateZ(AppFile,ZFile: String): Boolean;
  public
    { Public declarations }
    function BuildZ(AppName,ZName: String): boolean;
    function BuildUpdates: boolean;
    function BuildSize: Integer;
    procedure OnDiffCallback(CurProccesed,CurTotal: Integer; var Canceled: boolean);
  end;

var
  frmBuild: TfrmBuild;

implementation

uses Zlib, uolDiff, uAddUpdate, Unit1, uDiffOptions;

{$R *.dfm}

{ TForm2 }

function TfrmBuild.BuildUpdates: boolean;
var
  Notes: TFileStream;
  s,UpdateFilename: string;
  Speed: TDiffMethod;
  Index: TDiffOptimalIndex;
  Packm: TDiffCompression;
  Codec: TDiffEncryption;
  Passw: string;
begin
  Result := False;
  Show;
  Update;
  FExiting := False;
  try
    FTotalSize := 0;
    with frmAddUpdate do begin
      Enabled := False; // HACK! Do not allow focus change since Self is not modal
      try
        FReadyUpdates.Clear;
        Index := 10;
        Speed := dmOptimal;
        if frmDiffOptions.rbFastBuild.Checked then Speed := dmFastest;
        //if frmDiffOptions.rbSmallBuild.Checked then Speed := dmOptimal; // Index = 10 by default
        if frmDiffOptions.rbCustomBuild.Checked then Index := frmDiffOptions.tbSpeedIndex.Position;
        Packm := dcNone;
        if frmDiffOptions.rbCompressZLib.Checked then Packm := dcZlib;
        if frmDiffOptions.rbCompressLh5.Checked then Packm := dcLh5;
        Codec := deNone;
        if frmDiffOptions.rbEncryptNone.Checked then Codec := deXor;
        Passw := '';
        if frmDiffOptions.rbPassWord.Checked then Passw := frmDiffOptions.Secret;
        if cbDoHistory.Checked then begin
          Notes := TFileStream.Create(edHistory.Text,fmOpenRead or fmShareDenyWrite);
          try
            SetLength(s,Notes.Size);
            Notes.ReadBuffer(s[1],Notes.Size);
            UOLReleaseNotes(@s[1],Notes.Size);
          finally
            Notes.Free;
          end;
        end
        else
          UOLReleaseNotes(nil,0);
        UpdateFilename := ExtractFilePath(Form1.OpenDialog1.FileName)+
          'update-'+edFromVer.Text+'-'+edToVer.Text;
        if IsReverseDif then begin
          UpdateFilename := UpdateFilename + '.rev';
          Self.Label1.Caption := 'Building reverse update file...';
        end
        else begin
          UpdateFilename := UpdateFilename + '.dif';
          Self.Label1.Caption := 'Building forward update file...';
        end;
        { Start }
        FDifAndRev := not IsReverseDif and cbDoReverse.Enabled and cbDoReverse.Checked;
        FReverse := False;
        StatusBar1.Panels[0].Text := UpdateFilename;
        StatusBar1.Panels[1].Text := 'Building Update';
        ChDir(ExtractFileDir(edFromExe.Text));
        if UOLBuildPatch(PChar(ExtractFileName(edFromExe.Text)),PChar(edToExe.Text),PChar(UpdateFilename),
          Speed,Index,dsFile,Packm,Codec,PChar(Passw),OnDiffCallback) and not FCanceled then begin
          { Done }
          DoUpdateReady(UpdateFilename);
          { Only wen adding new version, offer a reverse update too }
          if FDifAndRev then begin
            UpdateFilename := ExtractFilePath(Form1.OpenDialog1.FileName)+
              'update-'+edToVer.Text+'-'+edFromVer.Text + '.rev';
            Self.Label1.Caption := 'Building reverse update file...';
            { Start }
            FReverse := True;
            StatusBar1.Panels[0].Text := UpdateFilename;
            ChDir(ExtractFileDir(edToExe.Text));
            if UOLBuildPatch(PChar(ExtractFileName(edToExe.Text)),PChar(edFromExe.Text),PChar(UpdateFilename),
              Speed,Index,dsFile,Packm,Codec,PChar(Passw),OnDiffCallback) and not FCanceled then begin
              { Done }
              DoUpdateReady(UpdateFilename);
              Result := True;
            end
            else
              DoRollback;
          end
          else
            Result := True;
        end;
      finally
        ReadyUpdates.Assign(FReadyUpdates);
        Enabled := True;
        StatusBar1.Panels[0].Text := '';
        StatusBar1.Panels[1].Text := 'Completed';
      end;
    end;
  finally
    FExiting := True;
    Close;
  end;
end;

procedure TfrmBuild.OnDiffCallback(CurProccesed, CurTotal: Integer;
  var Canceled: boolean);
const
  LastPos: Integer = -1;
  LastMax: Integer = -1;
var
  i: Integer;
begin
  if not FCanceled then begin
    i := CurProccesed - LastPos;
    if (i < 0) or (i > 32768) then begin
      LastPos := CurProccesed;
      if FDifAndRev then begin
        { Doing both forward AND reverse updates }
        if FReverse then begin
          { reverse }
          if CurTotal <> 0 then
            ProgressBar1.Position := LastMax + (LastMax * CurProccesed) div CurTotal;
          ProgressBar1.Tag := 0; // this is last update file
        end
        else begin
          { forward }
          LastMax := CurTotal;
          ProgressBar1.Max := 2*LastMax;
          ProgressBar1.Position := CurProccesed;
        end;
      end
      else begin
        { Doing only forward OR only reverse update }
        ProgressBar1.Max := CurTotal;
        ProgressBar1.Position := CurProccesed;
        ProgressBar1.Tag := 0; // this is last update file
      end;
      Application.ProcessMessages;
      Canceled := FCanceled;
    end;
    if (ProgressBar1.Tag = 0) and (CurProccesed = CurTotal) then begin
      ProgressBar1.Position := ProgressBar1.Max;
      lblTimeLeft.Caption := 'Finishing';
      lblTimeLeft.Update;
    end;
  end;
end;

procedure TfrmBuild.FormCreate(Sender: TObject);
begin
  FReadyUpdates := TStringList.Create;
  Image1.Picture.Icon.Assign(Application.Icon);
end;

procedure TfrmBuild.Button1Click(Sender: TObject);
begin
  if MessageDlg('Aborting the Build Process?',
    mtConfirmation,[mbYes,mbNo],0) = ID_YES then begin
    FCanceled := True;
    lblTimeLeft.Caption := 'Aborting';
  end;
end;

procedure TfrmBuild.FormShow(Sender: TObject);
begin
  FCanceled := False;
  ProgressBar1.Tag := 1;
  ProgressBar1.Position := 0;
  Label1.Caption := 'Initializing engine...';
  lblTimeLeft.Caption := 'Calculating';
  Timer1.Interval := 7000;
  Timer1.Enabled := True;
  FStartTime := Now;
end;

procedure TfrmBuild.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := FExiting;
end;

function TfrmBuild.BuildSize: Integer;
begin
  Result := FTotalSize;
end;

procedure TfrmBuild.DoUpdateReady(Filename: string);
var
  fs: TFileStream;
begin
  fs := TFileStream.Create(Filename,fmOpenRead or fmShareDenyWrite);
  try
    FTotalSize := FTotalSize + fs.Size;
  finally
    fs.Free;
    FReadyUpdates.Add(Filename);
  end;
end;

procedure TfrmBuild.DoRollback;
begin
  while FReadyUpdates.Count <> 0 do begin
    DeleteFile(FReadyUpdates[0]);
    FReadyUpdates.Delete(0);
  end;
end;

procedure TfrmBuild.FormHide(Sender: TObject);
begin
  Timer1.Enabled := False;
end;

procedure TfrmBuild.Timer1Timer(Sender: TObject);
var
  Left: TDateTime;
  s: string;
begin
  if ProgressBar1.Position <> 0 then begin
    Left := Now - FStartTime;
    Left := Left * (ProgressBar1.Max - ProgressBar1.Position) / ProgressBar1.Position;
    { get minutes left }
    s := FormatDateTime('n',Left);
    if s = '0' then begin
      { get seconds left }
      s := FormatDateTime('s',Left);
      if s = '1' then
        lblTimeLeft.Caption := s + ' second'
      else
        lblTimeLeft.Caption := s + ' seconds';
      Timer1.Interval := 500;
    end
    else begin
      if s = '1' then
        lblTimeLeft.Caption := s + ' minute'
      else
        lblTimeLeft.Caption := s + ' minutes';
      Timer1.Interval := 2000;
    end;
  end;
end;

function TfrmBuild.BuildZ(AppName,ZName: String): boolean;
begin
  Result := False;
  Show;
  Update;
  FExiting := False;
  try
    FTotalSize := 0;
    with Form1 do begin
      Enabled := False; // HACK! Do not allow focus change since Self is not modal
      try
        FReadyUpdates.Clear;
        Self.Label1.Caption := 'Building deployment file...';
        FDifAndRev := False;
        FReverse := False;
        Result := DoCreateZ(AppName,ZName);
        DoUpdateReady(ZName);
        if not Result then DoRollback;
      finally
        Enabled := True;
      end;
    end;
  finally
    FExiting := True;
    Close;
  end;
end;

procedure TfrmBuild.FormDestroy(Sender: TObject);
begin
  FReadyUpdates.Free;
end;

function TfrmBuild.DoCreateZ(AppFile,ZFile: String): boolean;
var
  str,dst: TFileStream;
  Buffer: array[0..16383] of byte;
  NumRead: Integer;
  fProc,fSize: Int64;
  isCanceled: boolean;
begin
  Result := False;
  isCanceled := False;
  str := TFileStream.Create(AppFile, fmOpenRead or fmShareDenyNone);
  try
    fSize := str.Size;
    dst := TFileStream.Create(ZFile, fmCreate or fmShareExclusive); // do not localize
    try
      with TCompressionStream.Create(clMax,dst) do
      try
        fProc := 0;
        repeat
          OnDiffCallback(fProc,fSize,isCanceled);
          if isCanceled then break;
          NumRead := str.Read(Buffer[0],SizeOf(Buffer));
          if NumRead = 0 then begin
            { All done! }
            Result := True;
            break;
          end;
          Write(Buffer[0],NumRead);
          inc(fProc,NumRead);
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
end;

end.

