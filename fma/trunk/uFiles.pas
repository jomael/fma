unit uFiles;

{
*******************************************************************************
* Descriptions: OBEX Files Access
* $Source: /cvsroot/fma/fma/uFiles.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uFiles.pas,v $
* Revision 1.6.2.10  2006/03/12 13:04:31  z_stoichev
* New UTF8 Codec usage.
*
* Revision 1.6.2.9  2006/01/18 10:43:22  z_stoichev
* Fixes.
*
* Revision 1.6.2.8  2006/01/16 11:26:55  mhr3
* Form1.Explorer -> Form1.ExplorerNew
*
* Revision 1.6.2.7  2005/11/20 12:19:39  mhr3
* Fixed WideStringReplace to Tnt_WideStringReplace (update your Tnt package)
*
* Revision 1.6.2.6  2005/09/16 02:00:07  z_stoichev
* Fixed AV bugs on refresh folders.
*
* Revision 1.6.2.5  2005/09/08 11:19:51  z_stoichev
* Unicode bugfixes.
*
*
}

interface

uses
  TntComCtrls, Contnrs, VirtualTrees;

const
  EXTERNAL_PATHSEPERATOR: WideChar = '/';
  INTERNAL_PATHSEPERATOR: WideChar = '\';

type TIcon = (
       iUnknown = 60,      // unknown file
       iSubDir = 33,       // normal sub dir
       iSoundsDir, {34}    // dir with sounds 
       iImagesDir, {35}    // dir with images
       iMidiFile, {36}     // midi file
       iImageFile, {37}    // image file
       iWaveFile, {38}     // wave file
       iThemeFile = 27);   // theme

     RFileIcon = record
       FileExtension: WideString;
       Icon: TIcon;
     end;

const
  FILEICONS: array [0..9] of RFileIcon = (
    (FileExtension: '.thm';  Icon: iThemeFile),  // do not localize
    (FileExtension: '.amr';  Icon: iWaveFile),   // do not localize
    (FileExtension: '.mp3';  Icon: iWaveFile),   // do not localize
    (FileExtension: '.mp4';  Icon: iWaveFile),   // do not localize
    (FileExtension: '.mid';  Icon: iMidiFile),   // do not localize
    (FileExtension: '.imy';  Icon: iMidiFile),   // do not localize
    (FileExtension: '.gif';  Icon: iImageFile),  // do not localize
    (FileExtension: '.jpg';  Icon: iImageFile),  // do not localize
    (FileExtension: '.wbm';  Icon: iImageFile),  // do not localize
    (FileExtension: '.wbmp'; Icon: iImageFile)); // do not localize

type
  TFileType = (ftDir, ftFile);

  TFile = class(TObject)
  private
    fTreeNode: PVirtualNode;
    fTreeView: TBaseVirtualTree;

    fSize: longword;
    fExternalName: WideString;
    fParent: TFile;
    fDirContents: TObjectList;
    fFileType: TFileType;

    function GetFullPath: WideString;
    function Update: boolean;
    procedure SetTreeNode(const Value: PVirtualNode);
    procedure SetFileType(const Value: TFileType);
    procedure SetSize(const Value: longword);
    function GetInternalName: WideString;
    function GetCount: word;
    function GetDirContent(index: word): TFile;

  public
    constructor Create;
    destructor Destroy; override;

    property InternalName: WideString read GetInternalName;
    property ExternalName: WideString read fExternalName write fExternalName;
    property FullPath: WideString read GetFullPath;
    property FileType: TFileType read fFileType write SetFileType;

    property Size: longword read fSize write SetSize;

    property Parent: TFile read fParent write fParent;
    property TreeNode: PVirtualNode read fTreeNode write SetTreeNode;

    property Count: word read GetCount;
    property DirContent[index: word]: TFile read GetDirContent;
  end;

  TFiles = class(TObject)
  private
    fTreeNode: PVirtualNode;
    fRoot: TFile;
  public
    constructor Create(AOwner: TObject; TreeNode: PVirtualNode);
    destructor Destroy; override;

    function Update: boolean;

    property TreeNode: PVirtualNode read fTreeNode;

    class function FindFileIcon(FileName: WideString): TIcon;
  end;

implementation

uses
  gnugettext, gnugettexthelpers, cUnicodeCodecs,
  SysUtils, TntSysUtils, unit1,   // too bad it needs unit1, this is because obex functionality is still in unit1.pas
  uObex, uXML, WebUtil, ComCtrls, UniTntCtrls, StrUtils;

{ TFile }

constructor TFile.Create;
begin
 fDirContents := TObjectList.Create;
end;

destructor TFile.Destroy;
begin
  fDirContents.Free;

  inherited;
end;

function TFile.GetCount: word;
begin
  result := 0;

  if Assigned(fDirContents) then
    result := fDirContents.Count;
end;

function TFile.GetDirContent(index: word): TFile;
begin
  result := nil;

  if Assigned(fDirContents) and (Index < fDirContents.Count) then
    result := TFile(fDirContents[Index]);
end;

function TFile.GetFullPath: WideString;
var
  CurFile: TFile;
begin
  CurFile := self;

  result := '';
  while assigned(CurFile) do
  begin
    result := CurFile.ExternalName + EXTERNAL_PATHSEPERATOR + result;

    CurFile := CurFile.Parent;
  end;

  if (Length(Result) > 1) and (result[Length(Result)] = EXTERNAL_PATHSEPERATOR) then
    SetLength(Result, Length(Result) - 1);
end;

function TFile.GetInternalName: WideString;
var EData: PFmaExplorerNode;
begin
   result := FullPath;

   result := Tnt_WideStringReplace(result, #13#10, '_', [rfReplaceAll]);
   result := Tnt_WideStringReplace(result, #13, '_', [rfReplaceAll]);
   result := Tnt_WideStringReplace(result, #10, '_', [rfReplaceAll]);

   result := Tnt_WideStringReplace(result, EXTERNAL_PATHSEPERATOR, INTERNAL_PATHSEPERATOR, [rfReplaceAll]);

   if result <> '' then begin
     EData := Form1.ExplorerNew.GetNodeData(fTreeNode);
     //// a _real_ solution for this someday would be nice :) ////////////////////////
     if (TIcon(EData.ImageIndex) in [iSoundsDir, iWaveFile, iMidiFile,          //
       iImagesDir, iImageFile, iThemeFile]) then                                    //
       begin                                                                        //
         Delete(result, 1, 1);                                                      //
         while (Length(result) > 0) and (result[1] <> INTERNAL_PATHSEPERATOR) do    //
         Delete(result, 1, 1);                                                      //
                                                                                    //
         case TIcon(EData.ImageIndex) of                                        //
           iSoundsDir,                                                              //
           iWaveFile,                                                               //
           iMidiFile: Result := INTERNAL_PATHSEPERATOR + 'snd' + result; // do not localize
                                                                                    //
           iImagesDir,                                                              //
           iImageFile: Result := INTERNAL_PATHSEPERATOR + 'pic' + result; // do not localize
                                                                                    //
           iThemeFile: Result := INTERNAL_PATHSEPERATOR + 'thm' + result; // do not localize
         end;                                                                       //
       end;                                                                         //
     /////////////////////////////////////////////////////////////////////////////////
   end;
end;

procedure TFile.SetFileType(const Value: TFileType);
var EData: PFmaExplorerNode;
begin
 fFileType := Value;

 case fFileType of
  ftDir:
  begin
    EData := Form1.ExplorerNew.GetNodeData(fTreeNode);
    EData.ImageIndex := integer(iSubDir);
//   fTreeNode.StateIndex := 0;  // don't 'clean up' stateindex (yet), this might be
                                 // the root node, which needs it's abused state index to
                                 // work correctly!!
  end;

  ftFile:
  begin
    EData := Form1.ExplorerNew.GetNodeData(fTreeNode);
    EData.ImageIndex := Integer(TFiles.FindFileIcon(fExternalName));

    if Assigned(fParent) then
      case TIcon(EData.ImageIndex) of
        iMidiFile, iWaveFile:
        begin
          EData := Form1.ExplorerNew.GetNodeData(fParent.TreeNode);
          EData.ImageIndex := integer(iSoundsDir);
        end;
        iImageFile:
        begin
          EData := Form1.ExplorerNew.GetNodeData(fParent.TreeNode);
          EData.ImageIndex := integer(iImagesDir);
        end;
      end;
    end;
  end;
end;

procedure TFile.SetSize(const Value: longword);
var EData: PFmaExplorerNode;
begin
  fSize := Value;
  EData := Form1.ExplorerNew.GetNodeData(fTreeNode);
  EData.StateIndex := Value;  // state index is abused for file size
end;

procedure TFile.SetTreeNode(const Value: PVirtualNode);
var EData: PFmaExplorerNode;
begin
  fTreeNode := Value;
  fTreeView := TreeFromNode(Value);
  EData := fTreeView.GetNodeData(Value);
  EData.Data := Self;
end;

function TFile.Update: boolean;

 function CreateNewFileNode(FileName: WideString): PVirtualNode;
 // tries to locate position for new node (after dirs, alphabetically sorted)
 // if it can't find location (no files yet) places new node as last
 var CurFile: TFile;
     CurNode: PVirtualNode;
     EData: PFmaExplorerNode;
 begin
  CurNode := fTreeNode.FirstChild;

  while assigned(CurNode) do
  begin
   EData := fTreeView.GetNodeData(CurNode);
   CurFile := TFile(Edata.Data);

   if (CurFile.FileType = ftFile) and (WideCompareText(FileName, CurFile.ExternalName) < 0) then
   begin
    Result := fTreeView.InsertNode(CurNode, amInsertBefore);
    EData := fTreeView.GetNodeData(Result);
    EData.Text := FileName;
    exit;
   end;

   CurNode := CurNode.NextSibling;
  end;

  Result := fTreeView.AddChild(fTreeNode);
  EData := fTreeView.GetNodeData(Result);
  EData.Text := FileName;
 end;

 function CreateNewDirNode(DirName: WideString): PVirtualNode;
 // tries to locate position for new node (before files, after other dirs)
 // if it can't find location (no dirs yet) places new node as first
 var CurFile: TFile;
     CurNode: PVirtualNode;
     EData: PFmaExplorerNode;
 begin
  CurNode := fTreeNode.FirstChild;

  while assigned(CurNode) do
  begin
   EData := fTreeView.GetNodeData(CurNode);
   CurFile := TFile(EData.Data);

   if (CurFile.FileType = ftFile) then
   begin
    Result := fTreeView.InsertNode(CurFile.TreeNode, amInsertBefore);
    EData := fTreeView.GetNodeData(Result);
    EData.Text := DirName;
    exit;
   end;

   CurNode := CurNode.NextSibling;
  end;

  Result := fTreeView.AddChild(fTreeNode);
  EData := fTreeView.GetNodeData(Result);
  EData.Text := DirName;
 end;

 procedure AddNewFile(NewFile: TFile);
 // adds a new node in the right place in the list (kinda like CreateNewFileNode and CreateNewDirNode)
 var InsertPos: integer;
 begin
  InsertPos := fDirContents.Count - 1;

  while InsertPos >= 0 do
  begin
   with TFile(fDirContents[InsertPos]) do
    if (FileType = Newfile.FileType) and (WideCompareText(NewFile.ExternalName, ExternalName) >= 0) then
     break;

   dec(InsertPos);
  end;

  if InsertPos < 0 then
   InsertPos := 0;
  fDirContents.Insert(InsertPos, NewFile);
 end;

var
  XML: TXML;
  XMLNode: TXMLNode;
  NewFile: TFile;
  CurName: WideString;
  CurSize: WideString;
begin
 result := true;

 { Process only folders }
 if fFileType = ftFile then exit;

 if Assigned(fTreeNode) then
   fTreeView.DeleteChildren(fTreeNode);

 XML := TXML.Create;

 try
  try
   { get folder listing }
   XML.XML := Form1.ObexListFolder(FullPath, false);

   { create nodes for all files and folders }
   XMLNode := XML.FirstChild;
   while assigned(XMLNode) do
   begin
    if (SameText(XMLNode.TagName, 'file')) or // do not localize
       (SameText(XMLNode.TagName, 'folder')) then // do not localize
    begin

     NewFile := TFile.Create;
     NewFile.Parent := Self;

     CurName := LongStringToWideString(HTMLDecode(XMLNode.attribute['name'])); // do not localize
     if Form1.FUseUTF8 then CurName := UTF8StringToWideString(WideStringToLongString(CurName));

     NewFile.ExternalName := CurName;

     if SameText(XMLNode.TagName, 'file') then // do not localize
     begin
      NewFile.TreeNode := CreateNewFileNode(NewFile.ExternalName);

      CurSize := XMLNode.attribute['size']; // do not localize
      if SameText(RightStr(CurSize, 1), 'D') then                   // check for '12345d' case // do not localize
       SetLength(CurSize, Length(CurSize) - 1);                     // cut of 'd' if found

      NewFile.Size := StrToIntDef(CurSize, 0);
      NewFile.FileType := ftFile;
     end;

     if SameText(XMLNode.TagName, 'folder') then // do not localize
     begin
      NewFile.TreeNode := CreateNewDirNode(NewFile.ExternalName);
      NewFile.FileType := ftDir;
      NewFile.Update;
     end;

     AddNewFile(NewFile);
    end;

    XMLNode := XMLNode.NextSibling;
   end;

  except
   on e: Exception do
   begin
    Form1.Status(Format(_('Obex Folder Browsing not supported: %s'),[e.Message]));

    result := false;
   end;
  end;

 finally
  XML.Free;
 end;
end;

{ TFiles }

constructor TFiles.Create(AOwner: TObject; TreeNode: PVirtualNode);
begin
  fTreeNode := TreeNode;

  fRoot := TFile.Create;
  fRoot.TreeNode := fTreeNode;
  fRoot.FileType := ftDir;
end;

destructor TFiles.Destroy;
begin
  fRoot.Free;

  inherited;
end;

class function TFiles.FindFileIcon(FileName: WideString): TIcon;
var
  i: integer;
begin
  result := iUnknown;
  FileName := ExtractFileExt(FileName);

  for i := 0 to Length(FILEICONS) - 1 do
    if WideCompareText(FILEICONS[i].FileExtension,FileName) = 0 then begin
      result := FILEICONS[i].Icon;
      break;
    end;
end;

function TFiles.Update: boolean;
begin
  Form1.ObexConnect(ObexFolderBrowserServiceID);
  try
    result := fRoot.Update;
  finally
    Form1.ObexDisconnect;
  end;  
end;

end.
