unit uLog;

{
*******************************************************************************
* Descriptions: Event Viewer - display/track FMA log messages.
* $Source: /cvsroot/fma/fma/uLog.pas,v $
* $Locker:  $
*
* Todo:
*   - Add popup menu
*
* Change Log:
* $Log: uLog.pas,v $
* Revision 1.17.2.9  2006/02/23 10:49:42  z_stoichev
* Code small fix.
*
* Revision 1.17.2.8  2006/02/08 18:06:55  mhr3
* changed 1000 items limit
*
* Revision 1.17.2.7  2006/01/30 16:31:55  z_stoichev
* - Fixed Log view speed (limited to 1K items).
* - Added Key Enter to view Log event details.
*
* Revision 1.17.2.6  2005/09/20 14:44:57  z_stoichev
* Changed Confirmations default button to NO.
*
* Revision 1.17.2.5  2005/08/19 15:53:10  z_stoichev
* Remember Event Viewer Filter and Stay On Top setting.
*
* Revision 1.17.2.4  2005/08/18 21:04:27  z_stoichev
* Main menu has been rearranged.
* Added shortcuts to Filter menu.
*
* Revision 1.17.2.3  2005/08/17 18:41:44  lordlarry
* - Fixed a bug from the last merge
*
* Revision 1.17.2.2  2005/08/17 18:39:11  lordlarry
* - Changed Implementation of Log Classes
*
* Revision 1.17.2.1  2005/08/16 16:15:30  z_stoichev
* bugfixes
*
* Revision 1.17  2005/03/12 17:37:30  lordlarry
* Fixed Memory Leaks
*
* Revision 1.16  2005/03/12 16:20:26  z_stoichev
* Fixed detection if the Log is cleared.
* LogDetails form is no longer auto-created.
*
* Revision 1.15  2005/03/12 15:45:14  lordlarry
* Added a seperator between categories and severities
*
* Revision 1.14  2005/03/08 13:32:43  z_stoichev
* Added Log Event Properties dialog.
*
* Revision 1.13  2005/03/06 21:00:29  lordlarry
* Changed the Log Writers so they work on a possible filtered Log Enumeration
*
* Revision 1.12  2005/03/03 19:05:05  lordlarry
* Added Filtering on Log Severity
*
* Revision 1.11  2005/03/03 08:28:23  lordlarry
* Updated to use LogEnumeration
*
* Revision 1.10  2005/03/01 12:19:24  z_stoichev
* Marker is default information message now.
* Add default messages to filter options.
*
* Revision 1.9  2005/02/19 11:02:38  lordlarry
* Changed Log Messages Category and Severity (Removing the Debug method)
*
* Revision 1.8  2005/02/17 14:48:30  z_stoichev
* Log updates, Added Category images display
*
* Revision 1.7  2005/02/16 16:17:25  z_stoichev
* Initial Filter implementation (working)
* Filter internal data should be moved from TLogItem to TLogEnumeration!
*
* Revision 1.6  2005/02/16 10:49:04  z_stoichev
* Ask for Save when clearing log.
* Main menu changed.
* Auto-scroll feature recoded.
* Window type set to SizeToolWin.
*
* Revision 1.5  2005/02/14 19:24:23  lordlarry
* Added category pictures
*
* Revision 1.4  2005/02/14 11:20:10  z_stoichev
* Chaged Headers Style
* Added Filter by Category menu
*
* Revision 1.3  2005/02/14 10:26:36  z_stoichev
* Removed obsolete D6 treeview option.
*
* Revision 1.2  2005/02/12 17:38:40  z_stoichev
* Delphi 6 compatability.
* Auto Scroll feature fixed.
* Track new messages menu/key option.
*
*
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TntForms, Placemnt, TntDialogs, TntMenus, Menus, ImgList,
  VirtualTrees, uLogger, uLogObserver;

type
  TfrmLog = class(TTntForm)
    MainMenu: TTntMainMenu;
    Log1: TTntMenuItem;
    SaveAsText1: TTntMenuItem;
    N1: TTntMenuItem;
    Clear1: TTntMenuItem;
    N2: TTntMenuItem;
    Close1: TTntMenuItem;
    SaveAsTextDialog: TTntSaveDialog;
    FormPlacement: TFormPlacement;
    vstLog: TVirtualStringTree;
    imlSeverity: TImageList;
    View1: TTntMenuItem;
    FilterMessages1: TTntMenuItem;
    Autoscroll1: TTntMenuItem;
    AllEvents1: TTntMenuItem;
    N4: TTntMenuItem;
    imgCategory: TImageList;
    N3: TTntMenuItem;
    AddLogMarker1: TTntMenuItem;
    ShowDetails1: TTntMenuItem;
    View2: TTntMenuItem;
    StayOnTop1: TTntMenuItem;
    N5: TTntMenuItem;
    SaveSettingsNow1: TTntMenuItem;
    FormStorage1: TFormStorage;
    procedure TntFormCreate(Sender: TObject);
    procedure vstLogFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstLogGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure vstLogGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure Close1Click(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure SaveAsText1Click(Sender: TObject);
    procedure TntFormClose(Sender: TObject; var Action: TCloseAction);
    procedure vstLogChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure Autoscroll1Click(Sender: TObject);
    procedure AllEvents1Click(Sender: TObject);
    procedure AddLogMarker1Click(Sender: TObject);
    procedure vstLogDblClick(Sender: TObject);
    procedure TntFormDestroy(Sender: TObject);
    function GetLogEnumeration: ILogEnumeration;
    procedure SetLogEnumeration(const Value: ILogEnumeration);
    procedure StayOnTop1Click(Sender: TObject);
    procedure SaveSettingsNow1Click(Sender: TObject);
    procedure vstLogKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    LogObserver: TLogObserver;
    FScrollLog,FLogSaved: boolean;
    FFilterSev: TLogSeverities;
    FFilterCat: TLogCategories;
    procedure LogChanged(Sender: TObject);
    procedure LogChanging(Sender: TObject);
    procedure LogCleared(Sender: TObject);
    procedure LogItemAdded(Sender: TObject; const LogItem: ILogItem);
    procedure CheckScrollMode;
    procedure DoFilterView;
    procedure DoRestoreFilter;
    procedure FilterCatClick(Sender: TObject);
    procedure FilterSevClick(Sender: TObject);
    property LogEnumeration: ILogEnumeration read GetLogEnumeration write SetLogEnumeration;
  public
  end;

var
  frmLog: TfrmLog;

implementation

{$R *.dfm}

uses
  gnugettext, gnugettexthelpers, uLogWriters, uDialogs, Unit1, uLogDetails;

type
  TLogItemNode = record
    LogItem: ILogItem;
  end;
  PLogItemNode = ^TLogItemNode;

procedure TfrmLog.TntFormCreate(Sender: TObject);
  procedure AddFilterSev(Text: WideString; Severity: TLogSeverity; Sc: TShortCut = 0);
  var
    Item: TMenuItem;
  begin
    Item := TMenuItem.Create(FilterMessages1);
    Item.Caption := Text;
    Item.Tag := Ord(Severity);
    Item.OnClick := FilterSevClick;
    Item.Checked := True; // because FFilterSev = ALL_LOG_SEVERITIES
    Item.AutoCheck := True;
    Item.ShortCut := Sc;
    FilterMessages1.Add(Item);
  end;
  procedure AddFilterCat(Text: WideString; Category: TLogCategory; Sc: TShortCut = 0);
  var
    Item: TMenuItem;
  begin
    Item := TMenuItem.Create(FilterMessages1);
    Item.Caption := Text;
    Item.Tag := Ord(Category);
    Item.OnClick := FilterCatClick;
    Item.Checked := True; // because FFilterCat = ALL_LOG_CATEGORIES
    Item.AutoCheck := True;
    Item.ShortCut := Sc;
    FilterMessages1.Add(Item);
  end;

var
  Item: TMenuItem;
begin
  gghTranslateComponent(Self);

  FLogSaved := False;
  FScrollLog := True;

  FFilterSev := ALL_LOG_SEVERITIES;
  FFilterCat := ALL_LOG_CATEGORIES;

  with TLogWriter.Create(nil) do
    try
      AddFilterSev(_(LogSeverityToString(lsInformation)),lsInformation,Ord('1'));
      AddFilterSev(_(LogSeverityToString(lsWarning)),lsWarning,Ord('2'));
      AddFilterSev(_(LogSeverityToString(lsError)),lsError,Ord('3'));
      AddFilterSev(_(LogSeverityToString(lsDebug)),lsDebug,Ord('4'));

      Item := TMenuItem.Create(FilterMessages1);
      Item.Caption := '-';  // Do not localize
      FilterMessages1.Add(Item);

      AddFilterCat(_(LogCategoryToString(lcDefault)),lcDefault,Ord('5'));
      AddFilterCat(_(LogCategoryToString(lcCommunication)),lcCommunication,Ord('6'));
      AddFilterCat(_(LogCategoryToString(lcSynchronization)),lcSynchronization,Ord('7'));
      AddFilterCat(_(LogCategoryToString(lcScript)),lcScript,Ord('8'));
    finally
      Free;
    end;

  vstLog.NodeDataSize := SizeOf(TLogItemNode);

  LogObserver := TLogObserver.Create(Self);
  LogObserver.OnLogChanging := LogChanging;
  LogObserver.OnLogCleared := LogCleared;
  LogObserver.OnLogItemAdded := LogItemAdded;
  LogObserver.OnLogChanged := LogChanged;

  DoRestoreFilter;
  DoFilterView;

  { the FScrollLog is True by default }
  vstLog.FocusedNode := vstLog.GetLast;
  vstLog.ScrollIntoView(vstLog.FocusedNode,True);
end;

procedure TfrmLog.vstLogFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  LogItemNode: PLogItemNode;
begin
  LogItemNode := Sender.GetNodeData(Node);

  if Assigned(LogItemNode) then begin
    LogItemNode.LogItem := nil;
    
    Finalize(LogItemNode^);
  end;
end;

procedure TfrmLog.vstLogGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  LogItemNode: PLogItemNode;
begin
  LogItemNode := Sender.GetNodeData(Node);

  if Assigned(LogItemNode) and Assigned(LogItemNode.LogItem) then begin
    if Kind = ikState then
      case Column of
        0: ImageIndex := Integer(LogItemNode.LogItem.Severity);
        1: ;
      end
    else
      case Column of
        0: ;
        1: ImageIndex := Integer(LogItemNode.LogItem.Category);
      end
  end;
end;

procedure TfrmLog.vstLogGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  LogItemNode: PLogItemNode;
begin
  LogItemNode := Sender.GetNodeData(Node);

  if Assigned(LogItemNode) and Assigned(LogItemNode.LogItem) then begin
    case Column of
      0: CellText := FormatDateTime('hh":"nn":"ss":"zzz', LogItemNode.LogItem.DateTime);
      1: CellText := LogItemNode.LogItem.Message;
    end;
  end;
end;

procedure TfrmLog.Close1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmLog.Clear1Click(Sender: TObject);
begin
  if not FLogSaved then
    case MessageDlgW(_('Do you want to save "Log" before clearing it?'), mtConfirmation,
      MB_YESNOCANCEL	or MB_DEFBUTTON2) of
      ID_YES: begin
        SaveAsText1.Click;
        if not FLogSaved then exit;
      end;
      ID_CANCEL: exit;
    end;
  Log.Clear;
  Log.AddMessage(_('*** Log Cleared ***'), lsInformation);
  FScrollLog := True;
  FLogSaved := False;
end;

procedure TfrmLog.SaveAsText1Click(Sender: TObject);
var
  LogFile: TStream;
  LogWriter: TLogWriter;
begin
  if SaveAsTextDialog.Execute then begin
    LogFile := TFileStream.Create(SaveAsTextDialog.FileName, fmCreate);
    try
      LogWriter := TLogWriter.Create(LogEnumeration);
      try
        LogWriter.LogWriterEngine := TLogTextWriterEngine.Create;
        LogWriter.ToStream(LogFile);
        FLogSaved := True;
      finally
        LogWriter.Free;
      end;
    finally
      LogFile.Free;
    end;
    Log.AddMessage(_('*** Log Exported ***'), lsInformation);
  end;
end;

procedure TfrmLog.TntFormClose(Sender: TObject; var Action: TCloseAction);
begin
  LogEnumeration := nil;
  vstLog.Clear;
  Action := caFree;
end;

procedure TfrmLog.CheckScrollMode;
begin
  FScrollLog := not Assigned(vstLog.FocusedNode) or not (vsSelected in vstLog.FocusedNode.States);
  { TODO -oagra : Create TAction for auto-scroll feature. }
  Autoscroll1.Checked := FScrollLog;
end;

procedure TfrmLog.vstLogChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  FLogSaved := False;
  CheckScrollMode;
end;

procedure TfrmLog.LogChanged(Sender: TObject);
begin
  vstLog.EndUpdate;

  CheckScrollMode;

  if FScrollLog then begin
    if Assigned(vstLog.FocusedNode) then
      vstLog.FocusedNode.States := vstLog.FocusedNode.States - [vsSelected];
    vstLog.ScrollIntoView(vstLog.GetLast, True);
    vstLog.FocusedNode := vstLog.GetLast;
  end;
end;

procedure TfrmLog.Autoscroll1Click(Sender: TObject);
begin
  { if we want to start scrolling unselect focused item }
  if not FScrollLog and Assigned(vstLog.FocusedNode) then
    vstLog.FocusedNode.States := vstLog.FocusedNode.States - [vsSelected];

  { go to last one if scrolling or no focused item }
  if not FScrollLog or not Assigned(vstLog.FocusedNode) then
    vstLog.FocusedNode := vstLog.GetLast;

  { if we want to stop scrolling select focused item }
  if FScrollLog and Assigned(vstLog.FocusedNode) then begin
    vstLog.FocusedNode.States := vstLog.FocusedNode.States + [vsSelected];
    vstLog.InvalidateNode(vstLog.FocusedNode); // hack!
  end;

  CheckScrollMode;
end;

procedure TfrmLog.AllEvents1Click(Sender: TObject);
var
  i: integer;
begin
  for i := 2 to FilterMessages1.Count-1 do
    FilterMessages1.Items[i].Checked := True;
  FFilterCat := ALL_LOG_CATEGORIES;
  FFilterSev := ALL_LOG_SEVERITIES;

  DoFilterView;
end;

procedure TfrmLog.FilterCatClick(Sender: TObject);
begin
  with Sender as TMenuItem do
    if Checked then
      FFilterCat := FFilterCat + [TLogCategory(Tag)]
    else
      FFilterCat := FFilterCat - [TLogCategory(Tag)];

  if not FormStorage1.Active then
    DoFilterView;
end;

procedure TfrmLog.FilterSevClick(Sender: TObject);
begin
  with Sender as TMenuItem do
    if Checked then
      FFilterSev := FFilterSev + [TLogSeverity(Tag)]
    else
      FFilterSev := FFilterSev - [TLogSeverity(Tag)];

  if not FormStorage1.Active then
    DoFilterView;
end;

procedure TfrmLog.DoFilterView;
begin
  { Clear event details and enumerations }
  if Assigned(frmLogDetails) then
    frmLogDetails.LogEnumeration := nil; // do not remove!
  LogEnumeration := nil; // do not remove!
  vstLog.Clear;

  { Got new filtered log }
  LogEnumeration := Log.GetEnumeration(FFilterSev, FFilterCat);

  { Restore auto-scroll setting to ON }
  if not FScrollLog then Autoscroll1.Click;
end;

procedure TfrmLog.AddLogMarker1Click(Sender: TObject);
begin
  Log.AddMessage(_('*** MARKER ***'), lsInformation);
end;

procedure TfrmLog.vstLogDblClick(Sender: TObject);
var
  LogItemNode: PLogItemNode;
begin
  if Assigned(vstLog.FocusedNode) then begin
    LogItemNode := vstLog.GetNodeData(vstLog.FocusedNode);
    if not Assigned(frmLogDetails) then
      frmLogDetails := TfrmLogDetails.Create(nil);
    frmLogDetails.LogEnumeration := LogEnumeration;
    frmLogDetails.LogItem := LogItemNode^.LogItem;
    frmLogDetails.Show;
  end;
end;

procedure TfrmLog.TntFormDestroy(Sender: TObject);
begin
  FreeAndNil(LogObserver);
end;

procedure TfrmLog.LogChanging(Sender: TObject);
begin
  vstLog.BeginUpdate;
end;

procedure TfrmLog.LogCleared(Sender: TObject);
begin
  if Assigned(frmLogDetails) then
    frmLogDetails.LogItem := nil; // Clear event details as well

  vstLog.Clear;
end;

procedure TfrmLog.LogItemAdded(Sender: TObject; const LogItem: ILogItem);
var
  LogItemNode: PLogItemNode;
  i: Integer;
begin
  LogItemNode := vstLog.GetNodeData(vstLog.AddChild(nil));
  LogItemNode.LogItem := LogItem;

  if vstLog.ChildCount[nil] > 1000 then begin
    vstLog.BeginUpdate;
    try
      { Leave latest 200 messages in the log, delete the rest! }
      for i := 0 to 800 do
        vstLog.DeleteNode(vstLog.GetFirst);
    finally
      vstLog.EndUpdate;
    end;
  end;
end;

function TfrmLog.GetLogEnumeration: ILogEnumeration;
begin
  Result := LogObserver.LogEnumeration;
end;

procedure TfrmLog.SetLogEnumeration(const Value: ILogEnumeration);
begin
  LogObserver.LogEnumeration := Value;
end;

procedure TfrmLog.StayOnTop1Click(Sender: TObject);
begin
  if FormStyle = fsStayOnTop then begin
    FormStyle := fsNormal;
    StayOnTop1.Checked := False;
  end
  else begin
    FormStyle := fsStayOnTop;
    StayOnTop1.Checked := True;
  end;
end;

procedure TfrmLog.SaveSettingsNow1Click(Sender: TObject);
var
  i: integer;
  s: string;
begin
  { will store filter in a string setting }
  s := '';
  for i := 2 to FilterMessages1.Count-1 do begin
    if FilterMessages1.Items[i].Caption = '-' then continue;
    { append '0' or '1' depending on menu option state }
    s := s + IntToStr(Byte(FilterMessages1.Items[i].Checked));
  end;
  FormStorage1.StoredValue['Filter'] := s;
  FormStorage1.StoredValue['OnTop'] := StayOnTop1.Checked;
  { Track new messages will not be saved }
  FormStorage1.SaveFormPlacement;
end;

procedure TfrmLog.DoRestoreFilter;
var
  i: integer;
  s: string;
begin
  if FormStorage1.Active then begin
    FormStorage1.RestoreFormPlacement;
    if FormStorage1.StoredValue['OnTop'] = False then StayOnTop1.Click;
    { read filter from string setting }
    s := FormStorage1.StoredValue['Filter'];
    for i := 2 to FilterMessages1.Count-1 do begin
      if FilterMessages1.Items[i].Caption = '-' then continue;
      { read '0' or '1' as menu option state }
      if Copy(s,1,1) = '0' then FilterMessages1.Items[i].Click;
      Delete(s,1,1);
    end;
    FormStorage1.Active := False;
  end;
end;

procedure TfrmLog.vstLogKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then ShowDetails1.Click;
end;

end.

