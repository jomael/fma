unit Unit1;

{
*******************************************************************************
* Descriptions: Main Tool Window
* $Source: /cvsroot/fma/fmaUpdmngr/Unit1.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: Unit1.pas,v $
* Revision 1.23  2006/03/17 14:18:40  z_stoichev
* Build 1.0.6.34 (MD5)
*
* Revision 1.22  2006/03/02 09:16:26  z_stoichev
* Bugfixes
*
* Revision 1.21  2005/09/07 15:12:01  z_stoichev
* Bugfixes and improvements (1.0.5.28)
*
* Revision 1.20  2005/09/03 19:33:05  z_stoichev
* Added Delete script selection Action.
*
* Revision 1.19  2005/09/03 13:17:59  z_stoichev
* Fixed Recent Items Shortkeys.
* Added Actions Hint messages.
*
* Revision 1.18  2005/09/03 11:29:56  z_stoichev
* Added Options dialog. Some bugfixes.
*
* Revision 1.17  2005/09/03 01:12:14  z_stoichev
* Added uolDiff.DLL usage.
*
* Revision 1.16  2005/09/02 21:42:50  z_stoichev
* GUI fixes, added Explore popup menu.
* Most things recreated as Actions.
*
* Revision 1.15  2005/09/02 13:20:23  z_stoichev
* Added support for Default mirror.
*
* Revision 1.14  2005/09/02 11:30:59  z_stoichev
* Insert new updates into script and GUI bugfixes.
*
* Revision 1.13  2005/09/02 09:39:23  z_stoichev
* GUI Bugfixes, Added recent open files. Fixed Ctrl+S hotkey.
*
* Revision 1.12  2005/09/02 07:41:09  z_stoichev
* GUI Sync Fixes
*
* Revision 1.11  2005/09/01 16:01:29  z_stoichev
* Added Mirrors support.
*
* Revision 1.10  2005/02/15 14:26:25  z_stoichev
* Build 1.0.3.10
*
* Revision 1.9  2005/02/09 16:33:19  z_stoichev
* Magor updates. Added Manager custom settings in project file.
*
* Revision 1.8  2005/02/01 16:12:22  z_stoichev
* Do not save changes until Save is clicked.
* Fixed multiple File Not Saved questions.
* Auto-update Explorer on script change.
*
* Revision 1.7  2005/01/31 09:17:06  z_stoichev
* GUI changes.
*
* Revision 1.6  2004/06/16 13:07:42  z_stoichev
* Fixed  Index out of bounds when adding new latest release
*
*
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Menus, ToolWin, ExtCtrls, ImgList, ShellAPI,
{$IFNDEF VER150}
  ThemeMgr,
{$ENDIF}
  uolSelectPatchPath, ActnList, StdCtrls, Tabs, AppEvnts, StdActns;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    StatusBar1: TStatusBar;
    TreeView1: TTreeView;
    Splitter1: TSplitter;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    ToolButton1: TToolButton;
    Open1: TMenuItem;
    OpenDialog1: TOpenDialog;
    Exit1: TMenuItem;
    AddUpdate1: TMenuItem;
    ActionList1: TActionList;
    ActionAddUpdate: TAction;
    Version1: TMenuItem;
    AddVersion1: TMenuItem;
    New1: TMenuItem;
    SaveDialog1: TSaveDialog;
    RemoveVersion1: TMenuItem;
    ActionDelVersion: TAction;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    N2: TMenuItem;
    Panel1: TPanel;
    TabSet1: TTabSet;
    Notebook1: TNotebook;
    ListView1: TListView;
    Memo1: TMemo;
    SyncToolButton: TToolButton;
    ToolButton9: TToolButton;
    Save1: TMenuItem;
    ActionDelUpdate: TAction;
    ToolButton8: TToolButton;
    ActionDelete: TAction;
    ToolBar2: TToolBar;
    Help1: TMenuItem;
    About1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    ToolButton7: TToolButton;
    ToolButton10: TToolButton;
    FilterView1: TMenuItem;
    Timer1: TTimer;
    ListView2: TListView;
    AddMirror1: TMenuItem;
    ActionDelMirror: TAction;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    pmMirrors: TPopupMenu;
    AddMirror2: TMenuItem;
    Properties1: TMenuItem;
    View1: TMenuItem;
    Timer2: TTimer;
    OpenRecent1: TMenuItem;
    N5: TMenuItem;
    TargetVersions1: TMenuItem;
    ScriptCode1: TMenuItem;
    MirrorServers1: TMenuItem;
    pmTree: TPopupMenu;
    Delete1: TMenuItem;
    AddVersion2: TMenuItem;
    N8: TMenuItem;
    GenerateUpdates1: TMenuItem;
    N10: TMenuItem;
    Remove1: TMenuItem;
    SetasDefault2: TMenuItem;
    Properties2: TMenuItem;
    ActionEditMirror: TAction;
    ActionSetDefMirror: TAction;
    ActionDelDefMirror: TAction;
    ClearDefault2: TMenuItem;
    ActionOpen: TAction;
    ActionFilter: TAction;
    ActionSave: TAction;
    N4: TMenuItem;
    N1: TMenuItem;
    HomePage1: TMenuItem;
    N12: TMenuItem;
    AddMirror3: TMenuItem;
    ActionAddMirror: TAction;
    ActionAddVersion: TAction;
    ActionNew: TAction;
    pmExplorer: TPopupMenu;
    Explore1: TMenuItem;
    ActionExplore: TAction;
    N11: TMenuItem;
    Delete2: TMenuItem;
    EditScript1: TMenuItem;
    SetasDefault1: TMenuItem;
    Filter1: TMenuItem;
    Close1: TMenuItem;
    N14: TMenuItem;
    Options1: TMenuItem;
    ActionClose: TAction;
    EditDelete1: TEditDelete;
    ActionSaveAs: TAction;
    SaveAs1: TMenuItem;
    Edit1: TMenuItem;
    EditUndo1: TEditUndo;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    Undo1: TMenuItem;
    N15: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    N16: TMenuItem;
    SelectAll1: TMenuItem;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ClearDefault1: TMenuItem;
    GetMD5: TMenuItem;
    OpenDialog2: TOpenDialog;
    ActionUpdateMD5: TAction;
    MD5Update1: TMenuItem;
    ActionDeployApp: TAction;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    NewVersion1: TMenuItem;
    ActionRefresh: TAction;
    ToolButton13: TToolButton;
    ToolButton19: TToolButton;
    N6: TMenuItem;
    RefreshView1: TMenuItem;
    ools1: TMenuItem;
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure Exit1Click(Sender: TObject);
    procedure ActionAddUpdateUpdate(Sender: TObject);
    procedure ActionAddUpdateExecute(Sender: TObject);
    procedure ActionDelVersionUpdate(Sender: TObject);
    procedure RemoveVersion1Click(Sender: TObject);
    procedure ActionDelVersionExecute(Sender: TObject);
    procedure TabSet1Change(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure Memo1Change(Sender: TObject);
    procedure Notebook1PageChanged(Sender: TObject);
    procedure ActionDelUpdateUpdate(Sender: TObject);
    procedure ActionDelUpdateExecute(Sender: TObject);
    procedure ActionDeleteUpdate(Sender: TObject);
    procedure ActionDeleteExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure ToolBar2CustomDrawButton(Sender: TToolBar;
      Button: TToolButton; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListView2DblClick(Sender: TObject);
    procedure ActionDelMirrorUpdate(Sender: TObject);
    procedure ActionDelMirrorExecute(Sender: TObject);
    procedure ListView2Change(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure Timer2Timer(Sender: TObject);
    procedure ViewPageClick(Sender: TObject);
    procedure ActionEditMirrorUpdate(Sender: TObject);
    procedure ActionEditMirrorExecute(Sender: TObject);
    procedure ActionSetDefMirrorUpdate(Sender: TObject);
    procedure ActionSetDefMirrorExecute(Sender: TObject);
    procedure ActionDelDefMirrorUpdate(Sender: TObject);
    procedure ActionDelDefMirrorExecute(Sender: TObject);
    procedure ActionOpenExecute(Sender: TObject);
    procedure ActionFilterExecute(Sender: TObject);
    procedure ActionSaveExecute(Sender: TObject);
    procedure ActionSaveUpdate(Sender: TObject);
    procedure HomePage1Click(Sender: TObject);
    procedure ActionAddMirrorExecute(Sender: TObject);
    procedure ActionAddVersionExecute(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure ActionNewExecute(Sender: TObject);
    procedure ActionExploreUpdate(Sender: TObject);
    procedure ActionExploreExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Options1Click(Sender: TObject);
    procedure ActionCloseUpdate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OpenRecentClick(Sender: TObject);
    procedure pmMirrorsPopup(Sender: TObject);
    procedure ActionNotSyncingUpdate(Sender: TObject);
    procedure pmTreePopup(Sender: TObject);
    procedure ActionUpdateMD5Execute(Sender: TObject);
    procedure ActionUpdateMD5Update(Sender: TObject);
    procedure pmExplorerPopup(Sender: TObject);
    procedure ActionDeployAppExecute(Sender: TObject);
    procedure ActionRefreshExecute(Sender: TObject);
  private
    { Private declarations }
    FSyncingCode,FLoadingFile,FModified,FInitialized: boolean;
    FLastMenuButton: TToolButton;
    NewVerCounter: integer;
    FUpdates: TuolSelectPatchPath;
    FFilter: string;
    function Get_Changed: boolean;
    procedure Set_Changed(const Value: boolean);
    function Get_ChangedGUI: boolean;
    procedure Set_ChangedGUI(const Value: boolean);
    function Get_Syncing: boolean;
    function IsDirectPatched(fromver,tover: string): boolean;
    function CheckScriptName(ForceNewName: boolean = False): boolean;
    procedure CheckScriptSave;
    function CreateTempName: string;
    procedure LoadScript(Filename: string);
    procedure ReleaseMainMenuButton;
    procedure LoadMirrors(Filename: string);
    procedure SaveMirrors(Filename: string);
    procedure LoadCustomData(Filename: string);
    procedure SaveCustomData(Filename: string);
    procedure UpdateDetails;
    procedure UpdateRecentFiles;
    procedure ExplorerOpenItem(ActivateTree: boolean = False);
    procedure NewView(ClearScript: boolean = True);
    procedure LoadSettings;
    procedure SaveSettings;
    procedure DoAddNewVersion(ALabel: string; DoUpdates: Boolean = True);
  public
    { Public declarations }
{$IFNDEF VER150}
    ThemeManager1: TThemeManager;
{$ENDIF}
    procedure SyncGUI2Code(ReloadFile: boolean = False);
    procedure SyncCode2GUI;
    procedure ClearRecentHistory;
  published
    property ViewFilter: string read FFilter;
    property IsSyncChanges: boolean read Get_Syncing;
    property ScriptChanged: boolean read Get_Changed write Set_Changed;
    property GUIChanged: boolean read Get_ChangedGUI write Set_ChangedGUI;
  end;

var
  Form1: TForm1;

procedure SetDefFont;

implementation

uses
  IniFiles, DateUtils, IcsMD5, Zlib,
  uAddUpdate, uVersion, uEditMirror, uGlobal, uolDiff, uDiffOptions, uOptions,
  uGenerate, uAddVersion, uDeployOptions;

{$R *.dfm}
{$R WinXP.res}

procedure SetDefFont;
var
  lf: LOGFONT;
  nc: NONCLIENTMETRICS;
begin
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS,SizeOf(nc),@nc,SPIF_SENDCHANGE) then
    lf := nc.lfMessageFont
  else begin
    if not SystemParametersInfo(SPI_GETICONTITLELOGFONT,SizeOf(lf),@lf,SPIF_UPDATEINIFILE) then begin
      Graphics.DefFontData.Name := 'MS Shell Dlg';
      exit;
    end;
  end;
  Graphics.DefFontData.Name := StrPas(@(lf.lfFaceName[0]));
  Graphics.DefFontData.Height := lf.lfHeight;
  Graphics.DefFontData.Charset := DEFAULT_CHARSET;
end;

{ TForm1 }

procedure TForm1.UpdateDetails;
var
  i,k,j: integer;
  sl: TStringList;
  tover: string;
begin
  ListView1.Items.BeginUpdate;
  ListView1.Items.Clear;
  ListView1.Items.EndUpdate;
  if TreeView1.Selected <> nil then
    if (TreeView1.Items[0] = TreeView1.Selected) or (TreeView1.Items[0] = TreeView1.Selected.Parent) then begin
      if TreeView1.Items[0] = TreeView1.Selected then begin
        ListView1.Columns[0].Caption := 'Source version';
        StatusBar1.Panels[1].Text := '';
      end
      else begin
        ListView1.Columns[0].Caption := 'Target version';
        StatusBar1.Panels[1].Text := IntToStr(TreeView1.Selected.Count)+' targets';
      end;
      if TreeView1.Selected = TreeView1.Items[0] then k := 18 else k := 29;
      for i := 0 to TreeView1.Selected.Count-1 do
        with ListView1.Items.Add do begin
          ImageIndex := k;
          Caption := TreeView1.Selected.Item[i].Text;
          SubItems.Add('');
          SubItems.Add('');
          SubItems.Add('');
        end;
    end
    else begin
      ListView1.Columns[0].Caption := 'Patch engines';
      sl := TStringList.Create;
      try
        tover := TreeView1.Selected.Text;
        FUpdates.FindBestPath(TreeView1.Selected.Parent.Text,tover,sl);
        for i := 0 to sl.Count-1 do
          for k := 0 to FUpdates.Graph.Count-1 do
            for j := 0 to TuolVersionInfo(FUpdates.Graph.Objects[k]).Patches.Count - 1 do begin
              with TuolPatchInfo(TuolVersionInfo(FUpdates.Graph.Objects[k]).Patches.Objects[j]) do
                if PatchURL = sl[i] then
                  with ListView1.Items.Add do begin
                    ImageIndex := 28;
                    Caption := NeedPatchEngines;
                    SubItems.Add(PatchURL);
                    SubItems.Add(Format('%.0n',[1.0*PatchSize]));
                    SubItems.Add(PatchMD5);
                  end;
            end;
        StatusBar1.Panels[1].Text := IntToStr(sl.Count)+' updates';
      finally
        sl.Free;
      end;
    end;
end;

procedure TForm1.SyncGUI2Code(ReloadFile: boolean);
var
  i,j: integer;
  tover: string;
  sl: TStringList;
  ver,script: string;
begin
  FLoadingFile := True;
  Timer1.Enabled := False;
  Timer2.Enabled := False;
  try
    if ReloadFile then CheckScriptSave;

    if not ReloadFile then begin
      script := CreateTempName;
      Memo1.Lines.SaveToFile(script);
    end
    else
      script := OpenDialog1.Filename;

    FreeAndNil(FUpdates);
    if FileExists(script) then begin
      StatusBar1.Panels[1].Text := 'Loading...';
      StatusBar1.Update;
      try
        FUpdates := TuolSelectPatchPath.Create(script,'main','bin+null');
        FUpdates.LoadMirrorsInfo(script); // just for testing
      except
        FUpdates := nil;
      end;
    end;

    LoadCustomData(script);
    NewView(False);
    LoadMirrors(script);

    if ReloadFile then begin
      if FileExists(script) then begin
        Memo1.Lines.LoadFromFile(script);
        StatusBar1.Panels[2].Text := script;
      end
      else NewView;
      { New script loaded, so no changes }
      ScriptChanged := False;
      GUIChanged := False;
    end
    else begin
      DeleteFile(script);
      if OpenDialog1.Filename = '' then
        StatusBar1.Panels[2].Text := 'Noname.updates'
      else
        StatusBar1.Panels[2].Text := OpenDialog1.Filename;
    end;

    if Assigned(FUpdates) then begin
      StatusBar1.Panels[1].Text := 'Analyzing...';
      StatusBar1.Update;
      for i := 0 to FUpdates.Graph.Count - 1 do begin
        ver := TuolVersionInfo(FUpdates.Graph.Objects[i]).VersionSignature;
        if ver <> '*' then
          if (FFilter = '') or (Pos(FFilter,ver) = 1) then
          with TreeView1.Items.AddChild(TreeView1.Items[0],ver) do begin
            ImageIndex := 18;
            SelectedIndex := 18;
            { remember version index }
            StateIndex := i;
          end;
      end;
      sl := TStringList.Create;
      try
        for j := 0 to TreeView1.Items[0].Count-1 do
          for i := 0 to TreeView1.Items[0].Count-1 do
            if i <> j then begin
              { use stored version index to retrieve version name }
              tover := TreeView1.Items[0].Item[i].Text;
              sl.Clear;
              FUpdates.FindBestPath(TreeView1.Items[0].Item[j].Text,tover,sl);
              if sl.Count <> 0 then begin
                with TreeView1.Items.AddChild(TreeView1.Items[0].Item[j],tover) do begin
                  ImageIndex := 29;
                  SelectedIndex := 29;
                  { remember version index }
                  StateIndex := TreeView1.Items[0].Item[i].StateIndex;
                end;
              end;
            end;
      finally
        sl.Free;
      end;
      TreeView1.Items[0].Expand(False);
      if ReloadFile then
        TreeView1.Selected := TreeView1.Items[0];
      StatusBar1.Panels[1].Text := '';
      StatusBar1.Panels[0].Text := IntToStr(TreeView1.Items[0].Count)+' versions';
    end
    else begin
      StatusBar1.Panels[1].Text := '';
      StatusBar1.Panels[0].Text := '';
    end;
  finally
    FLoadingFile := False;
    UpdateDetails;
  end;
end;

procedure TForm1.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  UpdateDetails;
  Notebook1.ActivePage := 'Explorer';
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.ActionAddUpdateUpdate(Sender: TObject);
begin
  ActionAddUpdate.Enabled := not IsSyncChanges and
   (((ActiveControl = ListView1) and (ListView1.Selected <> nil) and (ListView1.Selected.ImageIndex = 18)) or
    ((ActiveControl = TreeView1) and (TreeView1.Selected <> nil) and (TreeView1.Selected.Parent = TreeView1.Items[0]) and
     (TreeView1.Selected.ImageIndex in [18,20]) and (TreeView1.Items[0].Count > 1)));
end;

procedure TForm1.ActionAddUpdateExecute(Sender: TObject);
var
  i,j,k,m: integer;
  s,ver: string;
  sl: TStringList;
  Found,InMain: boolean;
begin
  if not CheckScriptName or IsSyncChanges then
    exit;
    
  if not IsUOLDiffAvailable then begin
    MessageDlg('In order to use Update Manager, you have to download '+sLineBreak+'a small library '+
      'UOLDIFF.DLL from FMA web site'+sLinebreak+sLinebreak+'http://fma.sourceforge.net/'+sLinebreak+sLinebreak+
      'Place it in Update Manager folder and restart application.',mtInformation, [mbOK], 0);
    exit;
  end;
  if ActiveControl = ListView1 then ExplorerOpenItem(True);

  frmAddUpdate.edFromVer.Text := TreeView1.Selected.Text;
  frmAddUpdate.edFromVer.Tag := TreeView1.Selected.StateIndex;
  frmAddUpdate.edToVer.Items.Clear;
  { add all versions as targets }
  for i := 0 to TreeView1.Items[0].Count-1 do
    if TreeView1.Items[0].Item[i] <> TreeView1.Selected then
      frmAddUpdate.edToVer.Items.AddObject(TreeView1.Items[0].Item[i].Text,
        Pointer(TreeView1.Items[0].Item[i].StateIndex));
  { remove already added -- should remove only direct targets }
  for i := 0 to TreeView1.Selected.Count-1 do
    if IsDirectPatched(TreeView1.Selected.Text,TreeView1.Selected.Item[i].Text) then begin
      j := frmAddUpdate.edToVer.Items.IndexOf(TreeView1.Selected.Item[i].Text);
      if j <> -1 then frmAddUpdate.edToVer.Items.Delete(j);
    end;
  if frmAddUpdate.edToVer.Items.Count = 0 then
    raise ERangeError.Create('No target versions are found or all updates are generated!'+sLineBreak+sLineBreak+
      'If Display Filter is applied then some target versions might be hidden');  
  frmAddUpdate.edToVer.ItemIndex := frmAddUpdate.edToVer.Items.Count-1;
  frmAddUpdate.edToVerChange(nil);
  if frmAddUpdate.ShowModal = mrOk then begin
    SyncCode2GUI; // save settings
    sl := TStringList.Create;
    try
      sl.Assign(Memo1.Lines);
      for i := 0 to frmAddUpdate.ReadyUpdates.Count-1 do begin
        { update name }
        s := ExtractFileName(ChangeFileExt(frmAddUpdate.ReadyUpdates[i],''));
        Delete(s,1,Pos('-',s));
        s := 'MobileAgent-'+s+'='+ExtractFileName(frmAddUpdate.ReadyUpdates[i])+',';
        { update size }
        with TFileStream.Create(frmAddUpdate.ReadyUpdates[i],fmOpenRead) do
          try
            s := s + IntToStr(Size) + ',bin';
          finally
            Free;
          end;
        { where to put new update line }
        m := -1;
        if TreeView1.Selected.Count <> 0 then begin
          {
          m := TreeView1.Selected.Item[TreeView1.Selected.Count-1].StateIndex;
          if TuolVersionInfo(FUpdates.Graph.Objects[m]).Patches.Count <> 0 then
            ver := TuolPatchInfo(TuolVersionInfo(FUpdates.Graph.Objects[m]).Patches.Objects[
              TuolVersionInfo(FUpdates.Graph.Objects[m]).Patches.Count-1]).FormVersion.VersionSignature
          else
            ver := TreeView1.Selected.Item[TreeView1.Selected.Count-1].Text;
          }
          ver := TreeView1.Selected.Item[TreeView1.Selected.Count-1].Text;
          {}
          m := TreeView1.Selected.Parent.Count-1;
          while m <> -1 do begin
            if TreeView1.Selected.Parent.Item[m].Text = ver then
              break;
            dec(m);
          end;
        end;
        if m < TreeView1.Selected.Index then
          m := TreeView1.Selected.Index;
        { find 1st occurance ot any next ver }
        j := -1; Found := False; InMain := False;
        while not Found and (j < sl.Count-1) do begin
          inc(j);
          if Copy(sl[j],1,1) = ';' then continue;
          if Pos('[main]',sl[j]) <> 0 then InMain := True
          else begin
            if InMain and (Copy(sl[j],1,1) = '[') then begin
              while (j <> 0) do begin
                if Trim(sl[j-1]) <> '' then break;
                dec(j);
              end;
              break;
            end;
            if InMain then
              for k := m+1 to TreeView1.Selected.Parent.Count-1 do begin
                { MobileAgent-0.1.0.01-0.1.0.99=update-0.1.0.32-0.1.0.31.rev,202636,bin[,<md5>] }
                ver := '-' + TreeView1.Selected.Parent.Item[k].Text;
                if Pos(ver,sl[j]) <> 0 then begin
                  Found := True;
                  break;
                end;
              end;
          end;
        end;
        { MD5 update file }
        s := s + ',' + FileMD5(frmAddUpdate.ReadyUpdates[i]);
        { insert new one }
        sl.Insert(j,s);
      end;
      Memo1.Lines.Assign(sl);
    finally
      sl.Free;
      SyncGUI2Code;
    end;
  end
  else 
    SyncCode2GUI; // save settings
end;

procedure TForm1.NewView(ClearScript: boolean);
begin
  if ClearScript then begin
    CheckScriptSave;
    FFilter := '';
  end;

  { Clear Explorer }
  TreeView1.Items.BeginUpdate;
  TreeView1.Items.Clear;
  TreeView1.Items.EndUpdate;

  { Clear Targets }
  ListView1.Items.BeginUpdate;
  ListView1.Items.Clear;
  ListView1.Items.EndUpdate;

  with TreeView1.Items.Add(nil,'main') do begin
    if FFilter <> '' then Text := Format('main (filtered by %s*)',[FFilter]);
    ImageIndex := 17;
    SelectedIndex := 17;
  end;
  NewVerCounter := 0;

  if ClearScript then begin
    { Clear Mirrors }
    ListView2.Items.BeginUpdate;
    ListView2.Items.Clear;
    ListView2.Items.EndUpdate;

    StatusBar1.Panels[0].Text := '';
    StatusBar1.Panels[1].Text := '';
    StatusBar1.Panels[2].Text := '';
    OpenDialog1.FileName := '';
    Memo1.Lines.Clear;
    ScriptChanged := False;
    GUIChanged := False;
  end;
end;

procedure TForm1.RemoveVersion1Click(Sender: TObject);
begin
  ActionDelVersion.Execute;
end;

procedure TForm1.ActionDelVersionExecute(Sender: TObject);
var
  sl: TStringList;
  i: integer;
  InMain: boolean;
begin
  if MessageDlg('Are you sure you want to delete Version named "'+TreeView1.Selected.Text+'" and ALL its updates?',
    mtConfirmation,[mbYes,mbNo],0) <> ID_YES then
    exit;
  if FileExists(OpenDialog1.FileName) then begin
    sl := TStringList.Create;
    try
      sl.Assign(Memo1.Lines);
      InMain := False;
      for i := 0 to sl.Count-1 do begin
        if Pos('[main]',sl[i]) <> 0 then InMain := True
        else
        if InMain and (sl[i] <> '') then begin
          if sl[i][1] = '[' then break;
          if sl[i][1] = ';' then continue;
          if ((Pos('-'+TreeView1.Selected.Text+'-',sl[i]) <> 0) or (Pos('-'+TreeView1.Selected.Text+'=',sl[i]) <> 0)) then
            sl[i] := '; '+sl[i];
        end;
      end;
      Memo1.Lines.Assign(sl);
    finally
      sl.Free;
    end;
  end;
  SyncGUI2Code;
end;

procedure TForm1.TabSet1Change(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  Notebook1.ActivePage := Notebook1.Pages[NewTab];
end;

procedure TForm1.Memo1Change(Sender: TObject);
begin
  if not FLoadingFile then
    ScriptChanged := True;
end;

procedure TForm1.Notebook1PageChanged(Sender: TObject);
begin
  TabSet1.TabIndex := Notebook1.Pages.IndexOf(Notebook1.ActivePage);
  if Notebook1.ActivePage = 'Script' then Memo1.SetFocus;
  { Update Main Menu's View submenu }
  case TabSet1.TabIndex of
    0: TargetVersions1.Checked := True;
    1: ScriptCode1.Checked := True;
    2: MirrorServers1.Checked := True;
  end;
end;

function TForm1.IsDirectPatched(fromver, tover: string): boolean;
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    FUpdates.FindBestPath(fromver,tover,sl);
    Result := sl.Count = 1;
  finally
    sl.Free;
  end;
end;

procedure TForm1.ActionDelUpdateUpdate(Sender: TObject);
begin
  ActionDelUpdate.Enabled := not IsSyncChanges and
    (ActiveControl = TreeView1) and (TreeView1.Selected <> nil) and
    (TreeView1.Selected.Parent <> nil) and (TreeView1.Selected.ImageIndex = 29); // update
end;

procedure TForm1.ActionDelVersionUpdate(Sender: TObject);
begin
  ActionDelVersion.Enabled := not IsSyncChanges and
    (ActiveControl = TreeView1) and (TreeView1.Selected <> nil) and
    (TreeView1.Selected.Parent = TreeView1.Items[0]) and
    (TreeView1.Selected.ImageIndex in [18,20]); // version or new_version
end;

procedure TForm1.ActionDelUpdateExecute(Sender: TObject);
var
  sl: TStringList;
  i: integer;
  InMain: boolean;
begin
  if MessageDlg('Are you sure you want to delete Update from version "'+TreeView1.Selected.Parent.Text+
    '" to version "'+TreeView1.Selected.Text+'"?',mtConfirmation,[mbYes,mbNo],0) <> ID_YES then
    exit;
  if FileExists(OpenDialog1.FileName) then begin
    sl := TStringList.Create;
    try
      sl.Assign(Memo1.Lines);
      InMain := False;
      for i := 0 to sl.Count-1 do begin
        if Pos('[main]',sl[i]) <> 0 then InMain := True
        else
        if InMain and (sl[i] <> '') then begin
          if sl[i][1] = '[' then break;
          if sl[i][1] = ';' then continue;
          if ((Pos('-'+TreeView1.Selected.Parent.Text+'-'+TreeView1.Selected.Text,sl[i]) <> 0) or
              (Pos('*-'+TreeView1.Selected.Text+'=',sl[i]) <> 0)) then
            sl[i] := '; '+sl[i];
        end;
      end;
      Memo1.Lines.Assign(sl);
    finally
      sl.Free;
    end;
  end;
  SyncGUI2Code;
end;

procedure TForm1.ActionDeleteUpdate(Sender: TObject);
begin
  EditDelete1.Update;
  ActionExplore.Update;

  ActionDelVersion.Update;
  ActionDelUpdate.Update;
  ActionDelMirror.Update;

  ActionDelete.Enabled := ActionExplore.Enabled or ActionDelVersion.Enabled or
    ActionDelUpdate.Enabled or ActionDelMirror.Enabled or EditDelete1.Enabled;
end;

procedure TForm1.ActionDeleteExecute(Sender: TObject);
begin
  if EditDelete1.Execute then exit;
  ActionExplore.Execute;

  if ActionDelVersion.Execute then exit;
  if ActionDelUpdate.Execute then exit;
  if ActionDelMirror.Execute then exit;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin  
{$IFNDEF VER150}
  ThemeManager1 := TThemeManager.Create(Self);
{$ENDIF}
  Caption := Caption + ' ' + ExtractFileVersionInfo(Application.ExeName,'FileVersion');
  Notebook1.ActivePage := 'Explorer';
  New1.Click;
end;

procedure TForm1.About1Click(Sender: TObject);
begin
  MessageBeep(MB_ICONEXCLAMATION);
  MessageDlg(Caption+#13#13'This project is distributed under the terms and conditions of General Public License.'#13+
    'It is a part of floAt''s Mobile Agent project (located at http://fma.sourceforge.net/)'#13#13+
    'Maintained by Zdravko Stoychev (z_stoichev @ users.sourceforge.net)',mtInformation,[mbOk],0);
end;

procedure TForm1.ToolBar2CustomDrawButton(Sender: TToolBar;
  Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
const
  Sel: TToolButton = nil;
begin
  if cdsSelected in State then begin
    if FLastMenuButton <> Button then begin
      Sel := Button;
    end;
  end;
  if (State = []) and (Button = Sel) then begin
    if FLastMenuButton <> Button then begin
      ReleaseMainMenuButton;
      FLastMenuButton := Sel;
      Sel.Down := True;
      Sel := nil;
    end;
  end;
end;

procedure TForm1.ReleaseMainMenuButton;
begin
  if FLastMenuButton <> nil then begin
    FLastMenuButton.Down := False;
    FLastMenuButton := nil;
  end;
end;

procedure TForm1.ApplicationEvents1Idle(Sender: TObject;
  var Done: Boolean);
begin
  if FLastMenuButton <> nil then
    { Update main menu tool button }
    ReleaseMainMenuButton;
end;

function TForm1.CheckScriptName(ForceNewName: boolean): boolean;
var
  i: integer;
begin
  Result := True;
  if ForceNewName or (OpenDialog1.FileName = '') then begin
    if ForceNewName then
      SaveDialog1.FileName := OpenDialog1.FileName;
    if SaveDialog1.Execute then begin
      { Create new file }
      DeleteFile(SaveDialog1.FileName);
      OpenDialog1.FileName := SaveDialog1.FileName;
    end
    else begin
      { Save aborted, so abort update too }
      for i := 0 to frmAddUpdate.ReadyUpdates.Count-1 do
        DeleteFile(frmAddUpdate.ReadyUpdates[i]);
      frmAddUpdate.ReadyUpdates.Clear;
      Result := False;
    end;
  end;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CheckScriptSave;
end;

function TForm1.CreateTempName: string;
var
  i: integer;
  s: string;
begin
  i := 0;
  s := ExtractFilePath(Application.ExeName);
  repeat
    inc(i);
    Result := Format('%s_new%.4d.tmp',[s,i]);
    if not FileExists(Result) then break;
  until i < 32000;
end;

procedure TForm1.CheckScriptSave;
begin
  if ScriptChanged then
    case MessageDlg('Updates Index has been changed. Save changes now?',mtConfirmation,[mbYes,mbNo,mbCancel],0) of
      ID_YES: begin
        ActionSave.Execute;
        if ScriptChanged then Abort;
      end;
      ID_NO: ScriptChanged := False;
      ID_CANCEL: Abort;
    end;
end;

procedure TForm1.LoadCustomData(Filename: string);
begin
  if Assigned(frmAddUpdate) and Assigned(frmDiffOptions) then
  with TIniFile.Create(Filename) do
  try
    { updates }
    frmAddUpdate.edFromExe.Text := ReadString('manager','From Dir','C:\Program Files\FMA 2\MobileAgent.exe');
    frmAddUpdate.edToExe.Text := ReadString('manager','To Dir','C:\Projects\FMA\fma\trunk\MobileAgent.exe');
    frmAddUpdate.edHistory.Text := ReadString('manager','History File','C:\Projects\FMA\fma\trunk\history.txt');
    frmAddUpdate.cbDoReverse.Checked := ReadBool('manager','Add Reverse',True);
    frmAddUpdate.cbDoHistory.Checked := ReadBool('manager','Add History',True);

    { versions }
    frmAddVersion.edFromExe.Text := ReadString('manager','Version Dir','C:\Projects\FMA\fma\trunk\MobileAgent.exe');
    frmAddVersion.cbUseAppDeployment.Checked := ReadBool('manager','Full Update',False);
    frmAddVersion.cbDoIncUpdates.Checked := ReadBool('manager','Do Updates',True);

    { default to ZLib }
    frmDeployOptions.rbCompressNone.Checked := ReadInteger('manager','Version Compression',1) = 0;
    frmDeployOptions.rbCompressZLib.Checked := ReadInteger('manager','Version Compression',1) = 1;
    frmDeployOptions.rbCompressLh5.Checked := ReadInteger('manager','Version Compression',1) = 2;
    { default to None }
    frmDeployOptions.rbEncryptNone.Checked := ReadInteger('manager','Version Encryption',0) = 0;
    frmDeployOptions.rbEncryptXor.Checked := ReadInteger('manager','Version Encryption',0) = 1;
    //frmDeployOptions.rbEncryptMore.Checked := ReadInteger('manager','Version Encryption',0) = 2;

    { default to Size Optimize }
    frmDiffOptions.rbFastBuild.Checked := ReadInteger('manager','Max Compress',1) = 0;
    frmDiffOptions.rbSmallBuild.Checked := ReadInteger('manager','Max Compress',1) = 1;
    frmDiffOptions.rbCustomBuild.Checked := ReadInteger('manager','Max Compress',1) = 2;
    { default to ZLib }
    frmDiffOptions.rbCompressNone.Checked := ReadInteger('manager','Compression',1) = 0;
    frmDiffOptions.rbCompressZLib.Checked := ReadInteger('manager','Compression',1) = 1;
    frmDiffOptions.rbCompressLh5.Checked := ReadInteger('manager','Compression',1) = 2;
    { default to None }
    frmDiffOptions.rbEncryptNone.Checked := ReadInteger('manager','Encryption',0) = 0;
    frmDiffOptions.rbEncryptXor.Checked := ReadInteger('manager','Encryption',0) = 1;
    //frmDiffOptions.rbEncryptMore.Checked := ReadInteger('manager','Encryption',0) = 2;
    { default to None }
    frmDiffOptions.rbPassNone.Checked := ReadInteger('manager','Protection',0) = 0;
    frmDiffOptions.rbPassWord.Checked := ReadInteger('manager','Protection',0) = 1;

    FFilter := ReadString('manager','Filter','');
    TreeView1.Width := ReadInteger('manager','Tree Width',177);
  finally
    Free;
  end;
end;

procedure TForm1.SaveCustomData(Filename: string);
var
  i: Integer;
begin
  { Update manager settings (do not modify manually) }
  with TIniFile.Create(Filename) do
  try
    { updates }
    WriteString('manager','From Dir',frmAddUpdate.edFromExe.Text);
    WriteString('manager','To Dir',frmAddUpdate.edToExe.Text);
    WriteString('manager','History File',frmAddUpdate.edHistory.Text);
    WriteBool('manager','Add Reverse',frmAddUpdate.cbDoReverse.Checked);
    WriteBool('manager','Add History',frmAddUpdate.cbDoHistory.Checked);

    { versions }
    WriteString('manager','Version Dir',frmAddVersion.edFromExe.Text);
    WriteBool('manager','Full Update',frmAddVersion.cbUseAppDeployment.Checked);
    WriteBool('manager','Do Updates',frmAddVersion.cbDoIncUpdates.Checked);

    i := 0; // HACK!

    if frmDeployOptions.rbCompressNone.Checked then i := 0;
    if frmDeployOptions.rbCompressZLib.Checked then i := 1;
    if frmDeployOptions.rbCompressLh5.Checked then i := 2;
    WriteInteger('manager','Version Compression',i);
    if frmDeployOptions.rbEncryptNone.Checked then i := 0;
    if frmDeployOptions.rbEncryptXor.Checked then i := 1;
    //if frmDeployOptions.rbEncryptMore.Checked then i := 2; // not implemented
    WriteInteger('manager','Version Encryption',i);

    if frmDiffOptions.rbFastBuild.Checked then i := 0;
    if frmDiffOptions.rbSmallBuild.Checked then i := 1;
    if frmDiffOptions.rbCustomBuild.Checked then i := 2;
    WriteInteger('manager','Max Compress',i);
    if frmDiffOptions.rbCompressNone.Checked then i := 0;
    if frmDiffOptions.rbCompressZLib.Checked then i := 1;
    if frmDiffOptions.rbCompressLh5.Checked then i := 2;
    WriteInteger('manager','Compression',i);
    if frmDiffOptions.rbEncryptNone.Checked then i := 0;
    if frmDiffOptions.rbEncryptXor.Checked then i := 1;
    //if frmDiffOptions.rbEncryptMore.Checked then i := 2; // not implemented 
    WriteInteger('manager','Encryption',i);
    if frmDiffOptions.rbPassNone.Checked then i := 0;
    if frmDiffOptions.rbPassWord.Checked then i := 1;
    WriteInteger('manager','Protection',i);

    WriteString('manager','Filter',FFilter);
    WriteInteger('manager','Tree Width',TreeView1.Width);
  finally
    Free;
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
{$IFNDEF VER150}
  ThemeManager1.Free;
{$ENDIF}
end;

function TForm1.Get_Changed: boolean;
begin
  Result := FModified;
end;

procedure TForm1.Set_Changed(const Value: boolean);
begin
  FModified := Value;
  Timer1.Enabled := False;
  Timer1.Enabled := Value;
end;

procedure TForm1.ListView2DblClick(Sender: TObject);
begin
  ActionEditMirror.Execute;
end;

procedure TForm1.ActionDelMirrorUpdate(Sender: TObject);
begin
  ActionDelMirror.Enabled := not IsSyncChanges and
    (ActiveControl = ListView2) and (ListView2.Selected <> nil);
end;

procedure TForm1.ActionDelMirrorExecute(Sender: TObject);
begin
  if MessageDlg('Are you sure you want to delete Mirror "'+ListView2.Selected.Caption+'"?',
    mtConfirmation,[mbYes,mbNo],0) <> ID_YES then
    exit;
  ListView2.Selected.Delete;
  GUIChanged := True;  
end;

procedure TForm1.ListView2Change(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  if not FLoadingFile and (Change = ctText) then
    GUIChanged := True;
end;

procedure TForm1.LoadMirrors(Filename: string);
var
  i: Integer;
  s: String;
  sl: TStringList;
begin
  ListView2.Items.BeginUpdate;
  ListView2.Items.Clear;
  sl := TStringList.Create;
  try
    with TIniFile.Create(Filename) do
    try
      ReadSectionValues('mirrors',sl);
      for i := 0 to sl.Count-1 do
        with ListView2.Items.Add do begin
          s := sl.ValueFromIndex[i];
          Caption := GetToken(s,0);
          SubItems.Add(GetToken(s,1));
          if sl.Names[i] = 'default' then SubItems.Add('Yes') else SubItems.Add('');
          ImageIndex := 6;
        end;
    finally
      Free;
    end;
  finally
    sl.Free;
    ListView2.Items.EndUpdate;
  end;
end;

procedure TForm1.SaveMirrors(Filename: string);
var
  i: Integer;
  s: string;
begin
  with TIniFile.Create(Filename) do
  try
    EraseSection('mirrors');
    for i := 0 to ListView2.Items.Count-1 do begin
      if ListView2.Items[i].SubItems[1] = 'Yes' then s := 'default'
        else s := 'mirror_'+IntToStr(i);
      WriteString('mirrors',s,AnsiQuotedStr(ListView2.Items[i].Caption,'"')+','+ListView2.Items[i].SubItems[0]);
    end;
  finally
    Free;
  end;
end;

procedure TForm1.SyncCode2GUI;
var
  TempFile: string;
  SS,SL: integer;
begin
  FSyncingCode := True;
  Timer1.Enabled := False;
  Timer2.Enabled := False;
  SS := Memo1.SelStart;
  SL := Memo1.SelLength;
  Memo1.Lines.BeginUpdate;
  try
    TempFile := CreateTempName;
    Memo1.Lines.SaveToFile(TempFile);

    SaveMirrors(TempFile);
    SaveCustomData(TempFile);

    Memo1.Lines.LoadFromFile(TempFile);
  finally
    DeleteFile(TempFile);
    Memo1.SelStart := SS;
    Memo1.SelLength := SL;
    Memo1.Lines.EndUpdate;
    FSyncingCode := False;
  end;
end;

function TForm1.Get_ChangedGUI: boolean;
begin
  Result := Timer2.Enabled;
end;

procedure TForm1.Set_ChangedGUI(const Value: boolean);
begin
  Timer2.Enabled := False;
  Timer2.Enabled := Value;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  SyncGUI2Code;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  SyncCode2GUI;
end;

procedure TForm1.ViewPageClick(Sender: TObject);
begin
  Notebook1.ActivePage := Notebook1.Pages[(Sender as TMenuItem).Tag];
end;

procedure TForm1.LoadSettings;
var
  i: Integer;
  m: TMenuItem;
  sl: TStringList;
  s: string;
begin
  with TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini')) do
  try
    ClearRecentHistory;
    sl := TStringList.Create;
    try
      frmOptions.cbReloadRecent.Checked := ReadBool('Main','Reopen Recent',True);

      ReadSectionValues('Recent Files',sl);
      for i := 0 to sl.Count-1 do begin
        s := sl.ValueFromIndex[i];
        m := TMenuItem.Create(OpenRecent1);
        m.Caption := '&' + IntToStr(i+1) + ' ' + s;
        m.Hint := s;
        m.OnClick := OpenRecentClick;
        OpenRecent1.Add(m);
      end;
    finally
      sl.Free;
    end;
  finally
    Free;
    OpenRecent1.Enabled := OpenRecent1.Count <> 0;
  end;
end;

procedure TForm1.SaveSettings;
var
  i: Integer;
begin
  with TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini')) do
  try
    WriteBool('Main','Reopen Recent',frmOptions.cbReloadRecent.Checked);

    EraseSection('Recent Files');
    for i := 0 to OpenRecent1.Count-1 do begin
      WriteString('Recent Files','script_'+IntToStr(i),OpenRecent1.Items[i].Hint);
      if i = 7 then break; // save last 7 entries only
    end;
    ClearRecentHistory;
  finally
    Free;
  end;
end;

procedure TForm1.OpenRecentClick(Sender: TObject);
begin
  LoadScript((Sender as TMenuItem).Hint);
end;

procedure TForm1.LoadScript(Filename: string);
begin
  if FileExists(Filename) then begin
    CheckScriptSave;
    OpenDialog1.FileName := Filename;
    SyncGUI2Code(True);
    UpdateRecentFiles;
  end
  else begin
    MessageBeep(MB_ICONASTERISK);
    MessageDlg(Application.Title+' could not open the script file:'+sLineBreak+sLineBreak+Filename, mtError, [mbOk], 0);
  end;
end;

procedure TForm1.ActionEditMirrorUpdate(Sender: TObject);
begin
  ActionEditMirror.Enabled := not IsSyncChanges and
    ListView2.Visible and (ListView2.Selected <> nil);
end;

procedure TForm1.ActionEditMirrorExecute(Sender: TObject);
begin
  frmMirror.edName.Text := ListView2.Selected.Caption;
  frmMirror.mmoURL.Text := ListView2.Selected.SubItems[0];
  frmMirror.cbDefault.Checked := ListView2.Selected.SubItems[1] = 'Yes';
  if frmMirror.ShowModal = mrOk then begin
    ListView2.Items.BeginUpdate;
    try
      ListView2.Selected.Caption := frmMirror.edName.Text;
      ListView2.Selected.SubItems[0] := frmMirror.mmoURL.Text;
      if frmMirror.cbDefault.Checked then
        ActionSetDefMirror.Execute
      else
        ActionDelDefMirror.Execute;
    finally
      ListView2.Items.EndUpdate;
      GUIChanged := True;
    end;
  end;
end;

procedure TForm1.ActionSetDefMirrorUpdate(Sender: TObject);
begin
  ActionSetDefMirror.Enabled := not IsSyncChanges and
    (ActiveControl = ListView2) and (ListView2.Selected <> nil) and
    (ListView2.Selected.SubItems[1] <> 'Yes');
end;

procedure TForm1.ActionSetDefMirrorExecute(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ListView2.Items.Count-1 do
    ListView2.Items[i].SubItems[1] := '';
  ListView2.Selected.SubItems[1] := 'Yes';
  GUIChanged := True;
end;

procedure TForm1.ActionDelDefMirrorUpdate(Sender: TObject);
begin
  ActionDelDefMirror.Enabled := not IsSyncChanges and
    (ActiveControl = ListView2) and (ListView2.Selected <> nil) and
    (ListView2.Selected.SubItems[1] = 'Yes');
end;

procedure TForm1.ActionDelDefMirrorExecute(Sender: TObject);
begin
  ListView2.Selected.SubItems[1] := '';
  GUIChanged := True;
end;

procedure TForm1.ActionOpenExecute(Sender: TObject);
begin
  if OpenDialog1.Execute then LoadScript(OpenDialog1.FileName);
end;

procedure TForm1.ActionFilterExecute(Sender: TObject);
var
  s: string;
begin
  if (NewVerCounter = 0) or (MessageDlg('Changing current filter will remove any New Versions. Continue?',
    mtConfirmation,[mbYes,mbNo],0) = ID_YES) then begin
    s := FFilter;
    if InputQuery('Display Filter','Show only Version names begining with:',s) and
      (CompareStr(s,FFilter) <> 0) then begin
      FFilter := s;
      SyncCode2GUI; // save filter in code
      SyncGUI2Code; // reload GUI
    end;
  end;
end;

procedure TForm1.ActionSaveExecute(Sender: TObject);
var
  ShouldSave: boolean;
begin
  ShouldSave := (Sender as TAction).Tag = 1;
  if (ShouldSave or ScriptChanged) and CheckScriptName(ShouldSave) then begin
    StatusBar1.Panels[1].Text := 'Saving...';
    StatusBar1.Update;
    try
      SyncCode2GUI;
      Memo1.Lines.SaveToFile(OpenDialog1.FileName);
      StatusBar1.Panels[2].Text := OpenDialog1.Filename;
      if ShouldSave then UpdateRecentFiles;
      ScriptChanged := False;
    finally
      SyncGUI2Code;
    end;
  end;
end;

procedure TForm1.ActionSaveUpdate(Sender: TObject);
begin
  ActionSave.Enabled := not IsSyncChanges and ScriptChanged;
end;

procedure TForm1.HomePage1Click(Sender: TObject);
begin
  ShellExecute(Handle,'open','http://fma.sourceforge.net/','','',SW_SHOWNORMAL);
end;

procedure TForm1.ActionAddMirrorExecute(Sender: TObject);
var
  Item: TListItem;
  i: Integer;
begin
  { Switch to Mirrors tab }
  MirrorServers1.Click;
  { Create mirror }
  frmMirror.edName.Text := '';
  frmMirror.mmoURL.Text := 'http://';
  frmMirror.cbDefault.Checked := False;
  if frmMirror.ShowModal = mrOk then begin
    ListView2.Items.BeginUpdate;
    try
      if frmMirror.cbDefault.Checked then
        for i := 0 to ListView2.Items.Count-1 do
          ListView2.Items[i].SubItems[1] := '';
      Item := ListView2.Items.Add;
      Item.Caption := frmMirror.edName.Text;
      Item.SubItems.Add(frmMirror.mmoURL.Text);
      if frmMirror.cbDefault.Checked then Item.SubItems.Add('Yes')
        else Item.SubItems.Add('');
      Item.ImageIndex := 6;
      Item.Focused := True;
      ListView2.Selected := Item;
    finally
      ListView2.Items.EndUpdate;
      GUIChanged := True;
    end;
  end;
end;

procedure TForm1.ActionAddVersionExecute(Sender: TObject);
var
  s: String;
begin
  { Switch to Versions tab }
  TargetVersions1.Click;
  { Create version }
  s := '';
  if InputQuery('Create Folder','Enter new version name:',s) and (Trim(s) <> '') then
    DoAddNewVersion(s,False);
end;

procedure TForm1.ExplorerOpenItem(ActivateTree: boolean);
var
  i: Integer;
begin
  if ListView1.Selected <> nil then begin
    for i := 0 to TreeView1.Selected.Count-1 do
      if TreeView1.Selected.Item[i].Text = ListView1.Selected.Caption then begin
        TreeView1.Selected := TreeView1.Selected.Item[i];
        if ActivateTree then TreeView1.SetFocus;
        break;
      end;
  end;
end;

procedure TForm1.ListView1DblClick(Sender: TObject);
begin
  if ListView1.Selected <> nil then ExplorerOpenItem;
end;

procedure TForm1.ActionNewExecute(Sender: TObject);
begin
  NewView;
  Memo1.Lines.Add(
    '[main]'+SLinebreak+
    '; format: update_name-from_version_signature-to_version_signature=patch_file_name,patch_file_size,update_engine1+pdate_engine2+...'+SLinebreak+
    '; mandatory (incremental)'+SLinebreak+
    '; MobileAgent-0.1.0.31-0.1.0.32=update-0.1.0.31-0.1.0.32.dif,203768,bin'+SLinebreak+
    ';'+SLinebreak+
    '; optional (fast - skip some middle versions)'+SLinebreak+
    '; MobileAgent-0.1.0.31-0.1.0.99=update-0.1.0.31-0.1.0.99.dif,125500,bin'+SLinebreak+
    ';'+SLinebreak+
    '; optional (back)'+SLinebreak+
    '; MobileAgent-0.1.0.32-0.1.0.31=update-0.1.0.32-0.1.0.31.rev,202636,bin'+SLinebreak+
    ';'+SLinebreak+
    '; optional (full - by using a * char as source version)'+SLinebreak+
    '; MobileAgent-*-0.1.0.99=MobileAgent-0.1.0.99.exe,2000000,null'+SLinebreak+
    ''+SLinebreak+
    '[manager]'+SLinebreak+
    '; update manager settings (do not modify manually)'+SLinebreak+
    'From Dir='+SLinebreak+
    'To Dir='+SLinebreak+
    'History File='+SLinebreak+
    'Max Compress=1'+SLinebreak+
    'Add Reverse=1'+SLinebreak+
    'Add History=1'+SLinebreak+
    'Filter='+SLinebreak+
    ''+SLinebreak+
    '[mirrors]'+SLinebreak+
    '; format: miror_id=miror_name,base_url'+SLinebreak+
    '; optional'+SLinebreak+
    'miror_0="SourceForge.net",http://fma.sourceforge.net/updates/');
  ScriptChanged := False;
  SyncGUI2Code;
  GUIChanged := False;
end;

procedure TForm1.ActionExploreUpdate(Sender: TObject);
begin
  ActionExplore.Enabled := not IsSyncChanges and
    (ActiveControl = ListView1) and (ListView1.Selected <> nil) and
    (ListView1.Selected.ImageIndex in [18,29]);
end;

procedure TForm1.ActionExploreExecute(Sender: TObject);
begin
  ExplorerOpenItem(True);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  if not FInitialized and not ScriptChanged and (OpenDialog1.FileName = '') then begin
    LoadSettings;
    FInitialized := True;
    { Reopen last used script on startup }
    if frmOptions.cbReloadRecent.Checked and OpenRecent1.Enabled then
      OpenRecent1.Items[0].Click;
  end;
end;

procedure TForm1.ActionCloseUpdate(Sender: TObject);
begin
  ActionClose.Enabled := not IsSyncChanges and (OpenDialog1.FileName <> '');
end;

procedure TForm1.Options1Click(Sender: TObject);
begin
  frmOptions.ShowModal;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveSettings;
end;

procedure TForm1.ClearRecentHistory;
var
  i: integer;
begin
  for i := OpenRecent1.Count-1 downto 0 do
    OpenRecent1.Items[i].Free;
  OpenRecent1.Enabled := False;
end;

procedure TForm1.UpdateRecentFiles;
var
  i: Integer;
  m: TMenuItem;
  s: string;
begin
  for i := OpenRecent1.Count-1 downto 0 do
    if CompareText(OpenRecent1.Items[i].Hint,OpenDialog1.FileName) = 0 then
      OpenRecent1.Items[i].Free;
  m := TMenuItem.Create(nil);
  m.Caption := 'x ' + OpenDialog1.FileName; // "x" will be replaced with shortkey number later
  m.Hint := OpenDialog1.FileName;
  m.OnClick := OpenRecentClick;
  OpenRecent1.Insert(0,m);
  OpenRecent1.Enabled := True;
  { Rearrange shortkeys to recent items }
  for i := 0 to OpenRecent1.Count-1 do begin
    s := OpenRecent1.Items[i].Caption;
    Delete(s,1,Pos(' ',s));
    OpenRecent1.Items[i].Caption := Format('&%d %s',[i+1,s]);
  end;
end;

procedure TForm1.pmMirrorsPopup(Sender: TObject);
begin
  ActionSetDefMirror.Update;
  ActionDelDefMirror.Update;
  SetasDefault1.Visible := SetasDefault1.Enabled;
  ClearDefault1.Visible := ClearDefault1.Enabled;
end;

function TForm1.Get_Syncing: boolean;
const
  sWorking = 'Working...';
var
  s: String;
begin
  s := StatusBar1.Panels[1].Text;
  if s = sWorking then s := '';
  Result := FLoadingFile or FSyncingCode or Timer1.Enabled or Timer2.Enabled;
  if Result then
    StatusBar1.Panels[1].Text := sWorking
  else
    StatusBar1.Panels[1].Text := s;
  StatusBar1.Update;
end;

procedure TForm1.ActionNotSyncingUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := not IsSyncChanges;
end;

procedure TForm1.pmTreePopup(Sender: TObject);
begin
  if Assigned(TreeView1.Selected) then TreeView1.Selected.Selected := True;
end;

procedure TForm1.ActionUpdateMD5Execute(Sender: TObject);
var
  s: String;
  i: Integer;
begin
  OpenDialog2.Title := 'Get File MD5...';
  OpenDialog2.Filter := 'Patch file|'+ListView1.Selected.SubItems[0];
  OpenDialog2.FileName := ListView1.Selected.SubItems[2];
  if OpenDialog2.Execute then begin
    { compare update size }
    with TFileStream.Create(OpenDialog2.FileName,fmOpenRead) do
      try
        s := Format('%.0n',[1.0*Size])
      finally
        Free;
      end;
    if s = ListView1.Selected.SubItems[1] then begin
      for i := 0 to Memo1.Lines.Count-1 do begin
        { MobileAgent-0.1.0.32-0.1.0.32a=update-0.1.0.32-0.1.0.32a.dif,203768,bin[,<md5>] }
        if GetToken(GetToken(Memo1.Lines[i],1,'='),0) = ListView1.Selected.SubItems[0] then begin
          s := FileMD5(OpenDialog2.FileName);
          Memo1.Lines[i] := SetToken(Memo1.Lines[i],s,3);
          ListView1.Selected.SubItems[2] := s;
          SyncGUI2Code;
          break;
        end;
      end;
    end
    else begin
      MessageBeep(MB_ICONASTERISK);
      MessageDlg('Patch file size do not match the scripted value.', mtError, [mbOk], 0);
    end;
  end;
end;

procedure TForm1.ActionUpdateMD5Update(Sender: TObject);
begin
  ActionUpdateMD5.Enabled := Assigned(ListView1.Selected) and
    (ListView1.Selected.ImageIndex = 28) and (ListView1.Selected.SubItems[2] = '');
end;

procedure TForm1.pmExplorerPopup(Sender: TObject);
begin
  ActionUpdateMD5.Update;
  GetMD5.Visible := GetMD5.Enabled;
end;

procedure TForm1.ActionDeployAppExecute(Sender: TObject);
var
  j: integer;
  s,d,z,ver: string;
  sl: TStringList;
  Found,InMain: boolean;
begin
  { Switch to Versions tab }
  TargetVersions1.Click;
  { Create version }
  frmAddVersion.ForceDeployment(mrNone);
  case frmAddVersion.ShowModal of
    mrAll: begin // do full update
      ver := frmAddVersion.GetVersionLabel;
      sl := TStringList.Create;
      try
        sl.Assign(Form1.Memo1.Lines);
        { find 1st occurance ot any next ver }
        j := -1; Found := False; InMain := False;
        while not Found and (j < sl.Count-1) do begin
          inc(j);
          if Copy(sl[j],1,1) = ';' then continue;
          if Pos('[main]',sl[j]) <> 0 then InMain := True
          else begin
            if InMain and (Copy(sl[j],1,1) = '[') then begin
              while (j <> 0) do begin
                if Trim(sl[j-1]) <> '' then break;
                dec(j);
              end;
              break;
            end;
          end;
        end;
        { MobileAgent-*-0.1.0.99=MobileAgent-0.1.0.99.exe,2000000,null[,<md5>] }
        z := frmAddVersion.GetUpdateFileName;
        s := ExtractFileName(frmAddVersion.GetAppFileName);
        d := ExtractFileName(z);
        s := frmOptions.Edit3.Text + '-*-' + ver + '=' + d + ',' + IntToStr(frmBuild.BuildSize) + ',null';
        { MD5 update file }
        s := s + ',' + FileMD5(z);
        { Update code }
        sl.Insert(j,s);
        Form1.Memo1.Lines.Assign(sl);
        Form1.SyncGUI2Code; // save settings
      finally
        sl.Free;
      end;
    end;
    mrOk: begin // do incremental updates
      DoAddNewVersion(frmAddVersion.GetVersionLabel,frmAddVersion.cbDoIncUpdates.Checked);
    end;
    else
      SyncCode2GUI;
  end;
end;

procedure TForm1.DoAddNewVersion(ALabel: string; DoUpdates: boolean);
var
  vnode: TTreeNode;
  i: integer;
  s: string;
begin
  s := ALabel;
  for i := 0 to TreeView1.Items[0].Count-1 do
    if AnsiCompareText(TreeView1.Items[0].Item[i].Text,s) = 0 then
      raise Exception.Create('This version already exists');
  { Create new 'dummy' version }
  vnode := TreeView1.Items.AddChild(TreeView1.Items[0],s);
  with vnode do begin
    ImageIndex := 20;
    SelectedIndex := 20;
    { indicate new version }
    inc(NewVerCounter);
    StateIndex := MAXWORD + NewVerCounter;
  end;
  if not TreeView1.Items[0].Expanded then TreeView1.Items[0].Expand(False);
  { Find last 'real' version before just created }
  i := vnode.Index;
  while i <> -1 do begin
    if (i = 0) or (TreeView1.Items[0].Item[i].ImageIndex <> 20) then begin
      TreeView1.Selected := TreeView1.Items[0].Item[i];
      TreeView1.SetFocus;
      break;
    end;
    dec(i);
  end;
  { Check filter restrictions }
  if Pos(FFilter,s) <> 1 then
    MessageDlg('This version will not be visible once update is created '+
      'due to current Filter settings.', mtWarning, [mbOk], 0);
  if DoUpdates then begin
    ActionAddUpdate.Update;
    ActionAddUpdate.Execute;
  end;
end;

procedure TForm1.ActionRefreshExecute(Sender: TObject);
begin
  SyncGUI2Code(True);
end;

end.

