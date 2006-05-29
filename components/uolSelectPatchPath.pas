unit uolSelectPatchPath;

interface

uses
  Classes;

type
  TuolPatchInfo = class;

  TuolVersionInfo = class
    VersionSignature: string;
    Patches: TStringList;
    // Wave Work Fields
    PathSize: Int64;
    PathPatch: TuolPatchInfo;
  end;

  TuolPatchInfo = class
    PatchName: string;
    FormVersion: TuolVersionInfo;
    ToVersion: TuolVersionInfo;
    PatchURL: string;
    PatchMD5: string;
    PatchSize: Int64;
    NeedPatchEngines: string;
  end;

  TuolSelectPatchPath = class
  private
    FGraph: TStringList;
    FMirrors: TStringList;
    function AddVersion(const aVersionSignature: string): TuolVersionInfo;
    function AddPatch(const aPatchName, aFromVersionSignature, aToVersionSignature, aPatchURL: string;
      aPatchSize: Int64; const aNeedPatchEngines: string; const aMD5: string = ''): TuolPatchInfo;
    procedure InternalForwardWave(Front: TStringList; V1i, VAnyi: Integer);
    procedure ClearGraph;

    function GetMirrorParam(MirrorID: string; Index: Integer): string;
  public
    constructor Create; overload;
    constructor Create(const InfoFileName, ModuleName, ExistPatchEngines: string); overload;
    destructor Destroy; override;

    procedure LoadModuleInfo(const InfoFileName, ModuleName, ExistPatchEngines: string);
    procedure LoadMirrorsInfo(const InfoFileName: string);

    procedure SetDefaultMirror(MirrorName,MirrorURL: string);
    function GetDefaultMirrorName: string;
    function GetDefaultMirrorBaseURL: string;
    function GetMirrorName(MirrorID: string): string; overload;
    function GetMirrorName(Index: Integer): string; overload;
    function GetMirrorBaseURL(MirrorID: string): string; overload;
    function GetMirrorBaseURL(Index: Integer): string; overload;

    procedure SortVersions(var Versions: TStrings);

    function FindPossibleVersions(const FromVersionSignature: string; Versions: TStrings): integer;
    function FindBestPath(const FromVersionSignature, ToVersionSignature: string; Path: TStrings): Int64;

    property Graph: TStringList read FGraph;
    property Mirrors: TStringList read FMirrors;
  end;

implementation

uses
  INIFiles, SysUtils;

{ TuolSelectPatchPath }

constructor TuolSelectPatchPath.Create;
begin
  inherited Create;
  FGraph := TStringList.Create;
  FMirrors := TStringList.Create;
end;

constructor TuolSelectPatchPath.Create(const InfoFileName, ModuleName, ExistPatchEngines: string);
begin
  Create;
  LoadModuleInfo(InfoFileName, ModuleName, ExistPatchEngines);
  //LoadMirrorsInfo(InfoFileName);
end;

destructor TuolSelectPatchPath.Destroy;
begin
  ClearGraph;
  FreeAndNil(FGraph);
  FreeAndNil(FMirrors);
  inherited;
end;

function TuolSelectPatchPath.AddVersion(const aVersionSignature: string): TuolVersionInfo;
var
  i: Integer;
begin
  i := Graph.IndexOf(aVersionSignature);
  if i < 0 then
    begin
      Result := TuolVersionInfo.Create;
      Result.VersionSignature := aVersionSignature;
      Result.Patches := TStringList.Create;
      //Result.PathPatch := nil;
      //Result.PathSize := 0;
      Graph.AddObject(aVersionSignature, Result);
    end
  else
    Result := TuolVersionInfo(Graph.Objects[i]);
end;

function TuolSelectPatchPath.AddPatch(const aPatchName, aFromVersionSignature, aToVersionSignature, aPatchURL: string;
  aPatchSize: Int64; const aNeedPatchEngines: string; const aMD5: string): TuolPatchInfo;
begin
  Result := TuolPatchInfo.Create;
  Result.PatchName := aPatchName;
  Result.FormVersion := AddVersion(aFromVersionSignature);
  Result.ToVersion := AddVersion(aToVersionSignature);
  Result.PatchURL := aPatchURL;
  Result.PatchMD5 := aMD5;
  Result.PatchSize := aPatchSize;
  Result.NeedPatchEngines := aNeedPatchEngines;
  Result.FormVersion.Patches.AddObject(aPatchName, Result);
end;

procedure TuolSelectPatchPath.LoadModuleInfo(const InfoFileName, ModuleName, ExistPatchEngines: string);
var
  SL, Temp: TStringList;
  i, j, P: Integer;
  S: string;
  PatchName: string;
  PatchURL: string;
  PatchMD5: string;
  PatchSize: Int64;
  NeedEngines: string;
  NeedEnginesSL: TStringList;
  ExistEnginesSL: TStringList;
  IsSubSet: Boolean;
begin
  ClearGraph;
  with TIniFile.Create(InfoFileName) do
    try
      ExistEnginesSL := TStringList.Create;
      NeedEnginesSL := TStringList.Create;
      Temp := TStringList.Create;
      SL := TStringList.Create;
      try
        NeedEnginesSL.Delimiter := '+';
        ExistEnginesSL.Delimiter := '+';
        ExistEnginesSL.DelimitedText := ExistPatchEngines;

        { Line format is:
          update_name-from_version_signature-to_version_signature = \\
            patch_file_name, patch_file_size, update_engine1+pdate_engine2+...[, patch_md5] }
        ReadSectionValues(ModuleName, SL);

        for i := 0 to SL.Count - 1 do
          begin
            S := SL[i];
            P := AnsiPos('=', S);
            if P > 0 then
              begin
                Temp.CommaText := Trim(Copy(S, P + 1, MaxInt));
                SetLength(S, P - 1);
                PatchName := S;
                PatchURL := Temp[0];
                PatchSize := StrToInt64Def(Temp[1], 0);
                NeedEngines := Temp[2];
                if Temp.Count = 4 then PatchMD5 := Temp[3]
                  else PatchMD5 := '';
                Temp.CommaText := StringReplace(S, '-', ',', [rfReplaceAll]);
                NeedEnginesSL.DelimitedText := NeedEngines;
                IsSubSet := True;
                for j := 0 to NeedEnginesSL.Count - 1 do
                  if ExistEnginesSL.IndexOf(NeedEnginesSL[j]) < 0 then
                    begin
                      IsSubSet := False;
                      break;
                    end;
                if IsSubSet then
                  AddPatch(PatchName, Temp[1], Temp[2], PatchURL, PatchSize, NeedEngines, PatchMD5)
                else
                  begin
                    AddVersion(Temp[1]);
                    AddVersion(Temp[2]);
                  end;
              end;
          end;
      finally
        SL.Free;
        Temp.Free;
        NeedEnginesSL.Free;
        ExistEnginesSL.Free;
      end;
    finally
      Free;
    end;
end;

type
  TuolWaveFront = class
    Version: TuolVersionInfo;
    CurrentPathSize: Int64;
    constructor Create(aVersion: TuolVersionInfo; aCurrentPathSize: Int64);
  end;

constructor TuolWaveFront.Create(aVersion: TuolVersionInfo; aCurrentPathSize: Int64);
begin
  inherited Create;
  Version := aVersion;
  CurrentPathSize := aCurrentPathSize;
end;

procedure TuolSelectPatchPath.InternalForwardWave(Front: TStringList; V1i, VAnyi: Integer);
var
  i, j: Integer;
  V1, V2: TuolVersionInfo;
  P: TuolPatchInfo;
  NextSize: Int64;
begin
  // Init Wave
  if V1i >= 0 then
    Front.AddObject('', TuolWaveFront.Create(TuolVersionInfo(Graph.Objects[V1i]), 0));
  if VAnyi >= 0 then
    Front.AddObject('', TuolWaveFront.Create(TuolVersionInfo(Graph.Objects[VAnyi]), 0));
  for i := 0 to Graph.Count - 1 do
    with TuolVersionInfo(Graph.Objects[i]) do
      begin
        PathSize := 0;
        PathPatch := nil;
      end;

  // Forward Wave
  while Front.Count > 0 do
    begin
      for i := Front.Count - 1 downto 0 do
        begin
          V1 := TuolWaveFront(Front.Objects[i]).Version;
          for j := 0 to V1.Patches.Count - 1 do
            begin
              P := TuolPatchInfo(V1.Patches.Objects[j]);
              NextSize := TuolWaveFront(Front.Objects[i]).CurrentPathSize + P.PatchSize;
              V2 := P.ToVersion;
              if (V2.PathSize = 0) or (V2.PathSize > NextSize) then
                begin
                  V2.PathSize := NextSize;
                  V2.PathPatch := P;
                  //if Front.IndexOf(V2) < 0 then
                  Front.AddObject('', TuolWaveFront.Create(V2, NextSize));
                end;
            end;
          Front.Delete(i);
        end;
    end;
end;

function TuolSelectPatchPath.FindBestPath(const FromVersionSignature, ToVersionSignature: string; Path: TStrings): Int64;
var
  V1i, V2i, VAnyi: Integer;
  Front: TStringList;
  V1, V2, VAny: TuolVersionInfo;
begin
  Result := -1;
  Front := TStringList.Create;
  try
    V1i := Graph.IndexOf(FromVersionSignature);
    V2i := Graph.IndexOf(ToVersionSignature);
    VAnyi := Graph.IndexOf('*');
    if V1i = V2i then
      begin
        Result := 0;
        exit;
      end;
    if V2i < 0 then
      exit;

    // Internal Forward Wave
    InternalForwardWave(Front, V1i, VAnyi);

    // Backward Wave
    if V1i >= 0 then
      V1 := TuolVersionInfo(Graph.Objects[V1i])
    else
      V1 := nil;
    if VAnyi >= 0 then
      VAny := TuolVersionInfo(Graph.Objects[VAnyi])
    else
      VAny := nil;
    V2 := TuolVersionInfo(Graph.Objects[V2i]);
    Result := V2.PathSize;
    while (V1 <> V2) and (VAny <> V2) and (V2.PathPatch <> nil) do
      begin
        Path.Insert(0, V2.PathPatch.PatchURL);
        V2 := V2.PathPatch.FormVersion;
      end;
    if (V1 <> V2) and (VAny <> V2) then
      Result := -1;
  finally
    Front.Free;
  end;
end;

function TuolSelectPatchPath.FindPossibleVersions(const FromVersionSignature: string; Versions: TStrings): integer;
var
  V1i, VAnyi, i: Integer;
  Front: TStringList;
begin
  Front := TStringList.Create;
  try
    //Versions.Add(FromVersionSignature);
    V1i := Graph.IndexOf(FromVersionSignature);
    VAnyi := Graph.IndexOf('*');

    // Internal Forward Wave
    InternalForwardWave(Front, V1i, VAnyi);

    // All Visited are Possible Versions
    for i := 0 to Graph.Count - 1 do
      with TuolVersionInfo(Graph.Objects[i]) do
        if (PathPatch <> nil) and (VersionSignature <> FromVersionSignature) then
          Versions.Add(VersionSignature);
  finally
    Front.Free;
  end;
  Versions.Add(FromVersionSignature);
  SortVersions(Versions);
  Result := Versions.Count;
end;

procedure TuolSelectPatchPath.ClearGraph;
var
  i: Integer;
begin
  for i := 0 to Graph.Count - 1 do
    with TuolVersionInfo(Graph.Objects[i]) do
      begin
        Patches.Free;
        Free;
      end;
  Graph.Clear;
end;

function CompareVersionSignatures(Item1, Item2: Pointer): Integer;
var
  a,b: string;
  function FirstToken(var Text: string): string;
  var
    i: integer;
  begin
    i := Pos('.',Text);
    if i = 0 then i := Length(Text)+1;
    Result := Copy(Text,1,i-1);
    Delete(Text,1,i);
  end;
  function CompareNum(A,B: string): integer; // A,B could be "numbersTEXT"
  var
    s,d: string;
    i,j: integer;
  begin
    if (A = '') or (B = '') then begin
      Result := 0;
      exit;
    end;
    s := ''; d := '';
    i := 1; j := Length(A);
    while (i <= j) and (A[i] in ['0'..'9']) do begin
      s := s + A[i];
      inc(i);
    end;
    Delete(A,1,i-1);
    i := 1; j := Length(B);
    while (i <= j) and (B[i] in ['0'..'9']) do begin
      d := d + B[i];
      inc(i);
    end;
    Delete(B,1,i-1);
    i := StrToInt(s);
    j := StrToInt(d);
    if i < j then
      Result := -1
    else
      if i > j then
        Result := 1
      else
        Result := CompareText(A,B);
  end;
begin
  a := StrPas(PChar(Item1));
  b := StrPas(PChar(Item2));
  Result := CompareNum(FirstToken(a),FirstToken(b));
  if Result = 0 then Result := CompareNum(FirstToken(a),FirstToken(b));
  if Result = 0 then Result := CompareNum(FirstToken(a),FirstToken(b));
  if Result = 0 then Result := CompareNum(FirstToken(a),FirstToken(b));
end;

procedure TuolSelectPatchPath.SortVersions(var Versions: TStrings);
var
  List: TList;
  Result: TStringList;
  i: integer;
begin
  List := TList.Create;
  Result := TStringList.Create;
  try
    for i := 0 to Versions.Count-1 do 
      List.Add(StrNew(PChar(Versions[i])));
    try
      List.Sort(CompareVersionSignatures);
    finally
      for i := 0 to List.Count-1 do begin
        Result.Add(StrPas(PChar(List[i])));
        StrDispose(List[i]);
        List[i] := nil;
      end;
    end;
    Versions.Assign(Result);
  finally
    Result.Free;
    List.Free;
  end;
end;

procedure TuolSelectPatchPath.LoadMirrorsInfo(const InfoFileName: string);
begin
  with TIniFile.Create(InfoFileName) do
    try
      FMirrors.Clear;
      { Line format is (value params might be quoted):
        miror_id=miror_name,base_url }
      ReadSectionValues('mirrors',FMirrors); // do not localize
    finally
      Free;
    end;
end;

procedure TuolSelectPatchPath.SetDefaultMirror(MirrorName,MirrorURL: string);
begin
  { Useful if no mirrors are specified in [mirrors] section. }
  Mirrors.Values['default'] := AnsiQuotedStr(MirrorName,'"') + ',' + AnsiQuotedStr(MirrorURL,'"'); // do not localize
end;

function TuolSelectPatchPath.GetMirrorName(MirrorID: string): string;
begin
  Result := GetMirrorParam(MirrorID,0);
end;

function TuolSelectPatchPath.GetMirrorBaseURL(MirrorID: string): string;
var
  len: Integer;
begin
  Result := GetMirrorParam(MirrorID,1);
  len := Length(Result);
  if (len <> 0) and (Result[len] <> '/') then
    Result := Result + '/';
end;

function TuolSelectPatchPath.GetMirrorParam(MirrorID: string; Index: Integer): string;
var
  s: string;
  sl: TStringList;
begin
  Result := '';
  s := Mirrors.Values[MirrorID];
  if s <> '' then begin
    sl := TStringList.Create;
    try
      sl.CommaText := s;
      if sl.Count >= Index then
        Result := AnsiDequotedStr(sl[Index],'"');
    finally
      sl.Free;
    end;
  end;
end;

function TuolSelectPatchPath.GetDefaultMirrorName: string;
begin
  Result := GetMirrorName('default'); // do not localize
end;

function TuolSelectPatchPath.GetDefaultMirrorBaseURL: string;
begin
  Result := GetMirrorBaseURL('default'); // do not localize
end;

function TuolSelectPatchPath.GetMirrorBaseURL(Index: Integer): string;
begin
  Result := '';
  if (Index >= 0) and (Index < Mirrors.Count) then
    Result := GetMirrorBaseURL(Mirrors.Names[Index]);
end;

function TuolSelectPatchPath.GetMirrorName(Index: Integer): string;
begin
  Result := '';
  if (Index >= 0) and (Index < Mirrors.Count) then
    Result := GetMirrorName(Mirrors.Names[Index]);
end;

end.

