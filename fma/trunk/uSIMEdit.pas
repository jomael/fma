unit uSIMEdit;

{
*******************************************************************************
* Descriptions: SIM Card Phonebook Edit Implementation
* $Source: /cvsroot/fma/fma/uSIMEdit.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uSIMEdit.pas,v $
* Revision 1.29.2.15  2006/03/12 13:04:31  z_stoichev
* New UTF8 Codec usage.
*
* Revision 1.29.2.14  2006/03/09 09:13:02  z_stoichev
* Gsm_SMS code merged into uSMS.pas!
*
* Revision 1.29.2.13  2006/01/16 11:26:57  mhr3
* Form1.Explorer -> Form1.ExplorerNew
*
* Revision 1.29.2.12  2005/09/20 14:44:57  z_stoichev
* Changed Confirmations default button to NO.
*
* Revision 1.29.2.11  2005/09/19 12:19:04  z_stoichev
* Added Command line switch "/fixdb" to clean DB.
*
* Revision 1.29.2.10  2005/09/16 02:00:41  z_stoichev
* New progress dialog with multitask support.
*
* Revision 1.29.2.9  2005/09/15 15:00:49  z_stoichev
* Changed popup menu.
*
* Revision 1.29.2.8  2005/09/06 18:32:57  z_stoichev
* Bugfixes and improvements (2.1.1.102b)
*
* Revision 1.29.2.7  2005/08/24 14:36:43  z_stoichev
* no message
*
* Revision 1.29.2.6  2005/08/24 13:37:25  z_stoichev
* - Fixed SIM editor Need rendering detection.
*
* Revision 1.29.2.5  2005/08/24 13:14:48  z_stoichev
* - Fixed Contacts Database loading and parsing.
* - Fixed Contacts Database Unicode support.
*
* Revision 1.29.2.4  2005/08/20 18:13:38  z_stoichev
* - Fixed LookupContact, LookupNumber, ContactNumberByName.
* - Fixed Find contact in Phonebook (Irmc), Phone Book, SIM.
*
* Revision 1.29.2.3  2005/08/19 12:26:10  z_stoichev
* Method param changed.
*
* Revision 1.29.2.2  2005/04/03 12:22:11  lordlarry
* Changed some methods to WideString methods
*
* Revision 1.29.2.1  2005/03/28 18:55:52  lordlarry
* Fixed a typecast bug
* Changed Formats to WideFormats
*
* Revision 1.30  2005/03/28 18:54:19  lordlarry
* Fixed a typecast bug
* Changed Formats to WideFormats
*
* Revision 1.29  2005/03/14 09:27:51  z_stoichev
* Added 'Export to unsupported Import' format warning.
*
* Revision 1.28  2005/02/24 21:29:14  lordlarry
* Added a better (but ugly) method to make the TWaitThread code threadsafe. All data that is accessed outside of the class goes through the ThreadSafe object which does the locking.
*
* Revision 1.27  2005/02/19 12:51:01  lordlarry
* Changed Log Messages Category and Severity (Removing the SyncLog method)
*
* Revision 1.26  2005/02/19 11:59:50  lordlarry
* Changed Log Messages Category and Severity (Removing the Debug method)
*
* Revision 1.25  2005/02/18 15:22:53  z_stoichev
* Fixed behaviour when IRMC is disabled.
* Added Lookup into SIM phone book.
*
* Revision 1.24  2005/02/09 14:01:45  z_stoichev
* Fixed #13#10 to sLinebreak.
*
* Revision 1.23  2005/02/08 15:38:54  voxik
* Merged with L10N branch
*
* Revision 1.22.2.4  2005/02/02 23:15:53  voxik
* Changed MessageDlg and ShowMessages replaced by new unicode versions
*
* Revision 1.22.2.3  2005/01/07 17:34:38  expertone
* Merge with MAIN branch
*
* Revision 1.22.2.2  2004/10/25 20:21:56  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.22.2.1  2004/10/19 19:48:48  expertone
* Add localization (gnugettext)
*
* Revision 1.22  2004/10/15 14:01:59  z_stoichev
* Merged with Stable bugfixes
*
* Revision 1.21  2004/09/10 11:56:29  z_stoichev
* Fixed 998626 "/O" added to Contact names.
*
* Revision 1.20.2.1  2004/09/10 12:12:56  z_stoichev
* - Fixed 998626 "/O" added to Contact names.
*
* Revision 1.20  2004/08/27 20:42:00  lordlarry
* Merge from newxml
*
* Revision 1.19.4.1  2004/08/25 15:41:13  merijnb
* added export to xml for SIM entries
*
* Revision 1.19  2004/07/01 14:38:41  z_stoichev
* Remember columns sort and order.
*
* Revision 1.18  2004/06/24 14:56:03  z_stoichev
* - Fixed Upload Contacts phone type to SIM issues.
* - Fixed Max field length for ME and SM Phonebooks.
* - Fixed Contact name lookup routines use ME phonebook.
* - Changed Connect after unknown number call is entered.
* - Changed Explorer Popup menu reorganized.
* - Added Chat to Contact command to various popup Menus.
* - Added Add to Phonebook to various popup Menus.
* - Added hit Enter in SIM editor to edit contact.
* - Added Remove favorite item confirmation message.
* - Added Download entire SIM phonebook.
* - Added New SIM editor columns (phone type, status).
* - Broken Phonebook editors Sorting is not remembered.
*
* Revision 1.17  2004/06/24 09:10:13  z_stoichev
* - Added Chat to Contact command to various popup Menus.
* - Added Add to Phonebook to various popup Menus.
* - Added hit Enter in SIM editor to edit contact.
* - Added Download entire SIM phonebook.
*
* Revision 1.16  2004/06/23 13:48:53  z_stoichev
* Added Chat support
* Popup menu new items
*
* Revision 1.15  2004/06/22 14:33:17  z_stoichev
* - Fixed SIM database old format detection.
* - Fixed Copy SIM contacts to Phonebook.
* - Fixed Export file type filter misusage/order.
* - Added Import contacts status line feedback.
* - Added Import/Export SIM contacts (vCard only).
* - Added Copy from Phonebook to SIM w/phone type.
*
* Revision 1.14  2004/06/15 13:01:35  z_stoichev
* Fix upload to phone changes detection.
*
* Revision 1.13  2004/05/21 10:09:05  z_stoichev
* Changed logging handle routines.
*
* Revision 1.12  2004/05/19 18:34:16  z_stoichev
* Build 0.1.0.35c
*
* Revision 1.11  2004/03/26 18:37:40  z_stoichev
* Build 0.1.0.35 RC5
*
* Revision 1.10  2004/03/07 21:55:45  z_stoichev
* Apply length restrictions when copy ME to/from SM.
* Sort all in SIM changes misplaced contacts only.
*
* Revision 1.9  2004/01/30 16:42:16  z_stoichev
* Fixed Send contacts from SIM to Phone AV error.
* Added Progress dialog on Uploading contacts.
* Added Fma Windows update on SMS Delete/Upload.
*
* Revision 1.8  2004/01/28 17:35:36  z_stoichev
* Popup menu rearranged.
* Allow editing Phone memory.
*
* Revision 1.7  2003/12/12 16:54:24  z_stoichev
* Added view customization support.
*
* Revision 1.6  2003/11/28 09:38:07  z_stoichev
* Merged with branch-release-1-1 (Fma 0.10.28c)
*
* Revision 1.5.2.7  2003/11/26 12:27:18  z_stoichev
* Sort after new contact.
* Select All works now.
*
* Revision 1.5.2.6  2003/11/13 16:37:10  z_stoichev
* Changed images.
*
* Revision 1.5.2.5  2003/11/12 16:21:07  z_stoichev
* Allow contact properties from Explorer popup menu.
*
* Revision 1.5.2.4  2003/11/11 13:11:32  z_stoichev
* Fixed surname is not cleared on edit.
*
* Revision 1.5.2.3  2003/11/10 14:03:10  z_stoichev
* RC3
*
* Revision 1.5.2.2  2003/11/07 13:56:04  z_stoichev
* SIM view/editor recoded.
*
* Revision 1.5.2.1  2003/10/27 07:22:54  z_stoichev
* Build 0.1.0 RC1 Initial Checkin.
*
* Revision 1.5  2003/10/23 11:52:18  z_stoichev
* Fixed bug for max name and tel length.
* Popup menu recreated.
* Font changed.
*
* Revision 1.4  2003/10/21 11:59:31  z_stoichev
* Update SIM sanity checks added.
* Retrieve max name and tel length.
* Bugfixes.
*
* Revision 1.3  2003/01/30 04:15:57  warren00
* Updated with header comments
*
*
*******************************************************************************
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms, Dialogs, TntDialogs,
  Grids, TntComCtrls, TntGrids, ExtCtrls, TntExtCtrls, StdCtrls, TntStdCtrls, Math, Menus, TntMenus, VirtualTrees, ImgList, uSyncPhonebook,
  Placemnt;

type
  TSIMData = Record
    imageindex: integer; {0=new,1=modified,2=deleted,3=normal}
    position: integer;
    cname,pnumb,ptype: WideString;
    CDID: TGUID;
    LUID : WideString;
  end;
  PSIMData = ^TSIMData;

  TfrmContactsSMEdit = class(TTntFrame)
    Panel1: TTntPanel;
    btnUpdateSIM: TTntButton;
    cbForce: TTntCheckBox;
    btnReset: TTntButton;
    PopupMenu1: TTntPopupMenu;
    Clear1: TTntMenuItem;
    Resetchangeflag1: TTntMenuItem;
    ListNumbers: TVirtualStringTree;
    NoItemsPanel: TTntPanel;
    N1: TTntMenuItem;
    N2: TTntMenuItem;
    Properties1: TTntMenuItem;
    NewPerson1: TTntMenuItem;
    UpdateChanged1: TTntMenuItem;
    UpdateAllRecords1: TTntMenuItem;
    FormStorage1: TFormStorage;
    N5: TTntMenuItem;
    UpdateContactsPosition1: TTntMenuItem;
    UpdateContactsfromPhonebook1: TTntMenuItem;
    SendAllContactstoPhonebook1: TTntMenuItem;
    N4: TTntMenuItem;
    ImportContacts1: TTntMenuItem;
    ExportContacts1: TTntMenuItem;
    OpenDialog1: TTntOpenDialog;
    N3: TTntMenuItem;
    MessageContact1: TTntMenuItem;
    CallContact1: TTntMenuItem;
    ChatContact1: TTntMenuItem;
    N7: TTntMenuItem;
    DownloadEntirePhonebook1: TTntMenuItem;
    SendToPhone1: TTntMenuItem;
    ForceAs1: TTntMenuItem;
    otalChange1: TTntMenuItem;
    otalCopy1: TTntMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure StringGridGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure Resetchangeflag1Click(Sender: TObject);
    procedure ListNumbersAfterPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas);
    procedure ListNumbersCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure ListNumbersGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure ListNumbersGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure ListNumbersHeaderClick(Sender: TVTHeader;
      Column: TColumnIndex; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure NewPerson1Click(Sender: TObject);
    procedure UpdateChanged1Click(Sender: TObject);
    procedure UpdateAllRecords1Click(Sender: TObject);
    procedure UpdateContactsPosition1Click(Sender: TObject);
    procedure UpdateContactsfromPhonebook1Click(Sender: TObject);
    procedure SendAllContactstoPhonebook1Click(Sender: TObject);
    procedure ListNumbersIncrementalSearch(Sender: TBaseVirtualTree;
      Node: PVirtualNode; const SearchText: WideString;
      var Result: Integer);
    procedure ImportContacts1Click(Sender: TObject);
    procedure DownloadEntirePhonebook1Click(Sender: TObject);
    procedure ListNumbersKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormStorage1SavePlacement(Sender: TObject);
    procedure FormStorage1RestorePlacement(Sender: TObject);
    procedure ListNumbersHeaderMouseUp(Sender: TVTHeader;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnResetClick(Sender: TObject);
    procedure btnUpdateSIMClick(Sender: TObject);
    procedure btnDELClick(Sender: TObject);
    procedure btnEDITClick(Sender: TObject);
  private
    { Private declarations }
    FContact: TContactData; // used for SIM contact editing (uEditContact)
    FExplore: PVirtualNode; // remember last rendered data's explorer node
    FOldText: String;
    function IsUniqueGUID(who: PSIMData): boolean;
    function FindFreePos: integer;
    procedure FullRefresh;
    procedure UpdateSIM(MaxItems: cardinal = 0);
    procedure RenderGUIDs;
  protected
    { Protected declarations }
    FRendered: Boolean;
    function GetCapacity(Target, LogName: string): Integer;
  public
    { Public declarations }
    SelContact: PSIMData;
    FMaxNumbers: Cardinal;
    FMaxNameLen,FMaxTelLen: integer;
    constructor Create(AOwner: TComponent); override;
    function RenderData(ForceDBNode: PVirtualNode = nil): boolean;
    procedure UpdatePhonebook;
    procedure OnConnected; virtual;
    procedure ExportList(FileType:Integer; Filename: WideString); virtual;
    function IsMEMode: boolean; virtual;
    function IsRendered: boolean;
    function DoEdit(AsNew: boolean = False; NewNumber: string = ''): boolean;
    function FindContact(Number: WideString): WideString; overload;
    function FindContact(FullName: WideString; var AContact: PSIMData): boolean; overload;
    function FindContact(FullName,NumberType: WideString; var AContact: PSIMData): boolean; overload;
    function FindContact(FullName: WideString; var ANode: PVirtualNode): boolean; overload;
    procedure CheckForChanges;
  end;

implementation

uses
  gnugettext, gnugettexthelpers, cUnicodeCodecs,
  uLogger, uThreadSafe, Unit1, uSMS, uGlobal, uEditContact, uConnProgress, uVcard, uXML, WebUtil, uDialogs;

{$R *.dfm}

{ TfrmContactsSMEdit }

constructor TfrmContactsSMEdit.Create(AOwner: TComponent);
begin
  inherited;
  { Set defaults }
  FMaxNameLen := 14; FMaxTelLen := 80; FMaxNumbers := 200;
  FRendered := False;
end;

function TfrmContactsSMEdit.RenderData(ForceDBNode: PVirtualNode): boolean;
var
  sl: TStrings;
  s: WideString;
  i: Integer;
  contact: PSIMData;
  Node: PVirtualNode;
  EData: PFmaExplorerNode;
  Modified,NeedRefresh: Boolean;
begin
  { ForceDBNode is used when loading Profile database etc. }
  if Assigned(ForceDBNode) then
    FExplore := ForceDBNode
  else
    if Form1.ExplorerNew.FocusedNode = Form1.FNodeContactsME then
      FExplore :=Form1.FNodeContactsME
    else
      FExplore :=Form1.FNodeContactsSM;
  EData := Form1.ExplorerNew.GetNodeData(FExplore);
  sl := EData.Data;
  { Load database }
  Modified := False;
  NeedRefresh := False;
  ListNumbers.BeginUpdate;
  try
    ListNumbers.Clear;
    ListNumbers.NodeDataSize := sizeof(TSIMData);
    for i := 0 to sl.Count - 1 do begin
      s := LongStringToWideString(sl[i]);
      if Trim(s) = '' then continue;
      { process DB }
      Node := ListNumbers.AddChild(nil);
      try
        contact := ListNumbers.GetNodeData(Node);
        contact.cname := UTF8StringToWideString(HTMLDecode(WideStringToLongString(GetFirstToken(s))));
        contact.pnumb := GetFirstToken(s);
        contact.position := StrToInt(GetFirstToken(s));
        if contact.position = 0 then NeedRefresh := True;
        try
          contact.imageindex := StrToInt(GetFirstToken(s));
        except
          contact.imageindex := 3; // 3 = not modified (new) item
          Modified := True;
        end;
        try
          contact.CDID := StringToGUID(GetFirstToken(s));
        except
          contact.CDID := NewGUID;
          Modified := True;
        end;
        contact.LUID := GetFirstToken(s);
        Form1.ExtractName(contact.cname,contact.ptype);
      except
        ListNumbers.DeleteNode(Node);
        Log.AddMessageFmt(_('Database: Error loading data (DB Index %d)'), [i], lsError);
        if FindCmdLineSwitch('FIXDB') then begin
          sl[i] := '';
          Log.AddMessageFmt(_('Database: Removed incorrect data (DB Index: %d)'), [i], lsInformation);
        end;
      end;
    end;
    RenderGUIDs;
    FRendered := True;
  finally
    ListNumbers.EndUpdate;
    ListNumbers.Sort(nil, ListNumbers.Header.SortColumn, ListNumbers.Header.SortDirection);
  end;
  if NeedRefresh then
    Form1.Status(WideFormat(_('Please refresh %s from phone, because some contact positions are missing!'),
      [EData.Text]));
  Result := Modified;
end;

procedure TfrmContactsSMEdit.Button1Click(Sender: TObject);
begin
  if not Form1.FConnected then Form1.ActionConnectionConnectExecute(Self);

  Form1.ActionContactsDownloadExecute(Self);
  RenderData;
end;

procedure TfrmContactsSMEdit.UpdateSIM(MaxItems: cardinal);
var
  PerformCleanup: boolean;
  i,maxPos,LastPos,numType: Integer;
  name, number: WideString;
  w, buf: string;
  Item: PSIMData;
  Node: PVirtualNode;
  frmConnect: TfrmConnect;
  target: string;
begin
  if IsMEMode then
    target := _('Phonebook')
  else
    target := _('SIM');
  PerformCleanup := MaxItems = ListNumbers.RootNodeCount;
  Form1.RequestConnection;
  Log.AddSynchronizationMessageFmt(_('Update %s started.'),[target]);
  frmConnect := GetProgressDialog;
  try
    if Form1.CanShowProgress then
      frmConnect.ShowProgress(Form1.FProgressLongOnly);
    if MaxItems > 0 then
      frmConnect.Initialize(MaxItems,WideFormat(_('Updating %s'),[target]))
    else
      frmConnect.SetDescr(WideFormat(_('Updating %s'),[target]));
    Form1.Status(_('Uploading contacts...'));
    maxPos := 0;
    try
      if IsMEMode then
        Form1.TxAndWait('AT+CPBS="ME"')  // do not localize
      else
        Form1.TxAndWait('AT+CPBS="SM"'); // do not localize
      try
        Node := ListNumbers.GetFirst;
        while Node <> nil do
        try
          item := ListNumbers.GetNodeData(Node);
          if (item.imageindex <> 3) or cbForce.Checked then begin
            numType := 129;
            Name := item.cname;
            Number := item.pnumb;

            if maxPos <= item.position then maxPos := item.position;

            buf := 'AT+CPBW=' + IntToStr(item.position); // do not localize
            if Item.imageindex = 2 then begin
              // Delete
              Log.AddSynchronizationMessageFmt(_('%s deleted in %s by FMA.'),[Name, target], lsDebug);
              Form1.TxAndWait(buf);
            end
            else begin
              // Update
              if Number[1] = '+' then begin
                Number := copy(Number, 2, length(Number));
                numType := 145;
              end;

              if Form1.FUseUTF8 then w := WideStringToUTF8String(Name)
                else w := name;

              { NOTE: When writing to SM, <text> shall be written as �last name?+ comma +
                white space +�first name?+ ??+ <type_of_number> }
              if IsMEMode then begin
                if (Length(w) < (FMaxNameLen-1)) and (item.ptype <> '') then
                case item.ptype[1] of
                  'M': w := w + '/M'; // do not localize
                  'H': w := w + '/H'; // do not localize
                  'W': w := w + '/W'; // do not localize
                  'F': w := w + '/F'; // do not localize
                  'O': w := w + '/O'; // do not localize
                end;
              end
              else begin
                { HACK! remove obsolete '/O' from SIM entries, added by previous FMA releases }
                i := Length(w);
                if (i > 2) and (w[i-1] = '/') and (Char(w[i]) in ['M','H','W','F','O']) then // do not localize
                  Delete(w,i-1,2);
              end;
              buf := buf + ',"' + Number + '",' + IntToStr(numType) + ',"' + w + '"';
              Form1.TxAndWait(buf);
              Log.AddSynchronizationMessageFmt(_('%s stored in %s by FMA.'),[Name, target], lsDebug);
              Item.imageindex := 3;
            end;
          end;
        finally
          frmConnect.IncProgress(1);
          Node := ListNumbers.GetNext(Node);
          ListNumbers.Repaint;
        end;
        { Ususaly happens when you rearrange contacts positions, i.e. modify all of them }
        if PerformCleanup then begin
          Form1.Status(_('Performing cleanup...'));
          frmConnect.SetDescr(_('Performing cleanup'));
          frmConnect.ClearMaxProgress;
          LastPos := FMaxNumbers;
          for maxPos := maxPos + 1 to LastPos do begin
            buf := 'AT+CPBW=' + IntToStr(maxPos); // do not localize
            Form1.TxAndWait(buf);
          end;
        end;
      finally
        UpdatePhonebook;
      end;
    except
      Form1.Status(_('Error updating memory'));
      ShowMessageW(_('Error updating memory'));
      Log.AddSynchronizationMessageFmt(_('Update %s failed.'),[target], lsError);
    end;
    Log.AddSynchronizationMessageFmt(_('Update %s  completed.'),[target]);
  finally
    FreeProgressDialog;
    Form1.Status('');
  end;
end;

procedure TfrmContactsSMEdit.btnUpdateSIMClick(Sender: TObject);
var
  Item: PSIMData;
  Node: PVirtualNode;
  mcount,dcount,count: cardinal;
  s: WideString;
begin
  mcount := 0; dcount := 0;

  Node := ListNumbers.GetFirst;
  while Node <> nil do
  try
    item := ListNumbers.GetNodeData(Node);
    if item.imageindex = 2 then
      // deleted contact
      inc(dcount)
    else
      // then process modified (or all) entries
      if (item.imageindex <> 3) or cbForce.Checked then begin
        { Do sanity check for modified contacts }
        if (Trim(item.cname) = '') and (Trim(item.pnumb) <> '') then
          raise EConvertError.Create(Format(_('Please enter a contact name at position %s'),[IntToStr(item.position)]));
        if (Trim(item.cname) <> '') and (Trim(item.pnumb) = '') then
          raise EConvertError.Create(Format(_('Please enter a phone number at position %s'),[IntToStr(item.position)]));
        if Length(item.cname) > FMaxNameLen then
          raise EConvertError.Create(Format(_('The name at position %s is too long'),[IntToStr(item.position)]));
        if Length(item.pnumb) > (FMaxTelLen+byte(Pos('+',item.pnumb) <> 0)) then
          raise EConvertError.Create(Format(_('The number at position %s is too long'),[IntToStr(item.position)]));
        inc(mcount);
      end;
  finally
    Node := ListNumbers.GetNext(Node);
  end;

  count := mcount + dcount;
  if count <> 0 then begin
    s := '';
    if mcount <> 0 then
      s := WideFormat(ngettext('%d modified contact.', '%d modified contacts.', mcount), [mcount])+sLinebreak;
    if dcount <> 0 then
      s := s + WideFormat(ngettext('%d deleted contact.', '%d deleted contacts.', dcount), [dcount])+sLinebreak;
    case MessageDlgW(_('Changes have been made into current folder.')+sLinebreak+sLinebreak+
      s + sLinebreak+sLinebreak+
      WideFormat(_('Confirm sending to phone?'),[s]), mtConfirmation, MB_YESNOCANCEL) of
      ID_YES: UpdateSIM(count);
      ID_CANCEL: Abort;
    end;
  end;
end;

procedure TfrmContactsSMEdit.btnResetClick(Sender: TObject);
var
  Item: PSIMData;
  Node: PVirtualNode;
begin
  ListNumbers.BeginUpdate;
  Node := ListNumbers.GetFirst;
  while Node <> nil do
  try
    item := ListNumbers.GetNodeData(Node);
    item.imageindex := 3; // mark as not modified
  finally
    Node := ListNumbers.GetNext(Node);
  end;
  ListNumbers.EndUpdate;
  UpdatePhonebook;
end;

procedure TfrmContactsSMEdit.StringGridGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  FOldText := Value;
end;

procedure TfrmContactsSMEdit.btnDELClick(Sender: TObject);
var
  Item: PSIMData;
  Node,Tmp: PVirtualNode;
  s: WideString;
begin
  if ListNumbers.SelectedCount = 0 then exit;
  s := WideFormat(_('Deleting %d %s.'), [ListNumbers.SelectedCount,ngettext('contact','contacts',ListNumbers.SelectedCount)]);
  if MessageDlgW(s+_(' Do you wish to continue?'), mtConfirmation, MB_YESNO	or MB_DEFBUTTON2) <> ID_YES then
    exit;
  Form1.Status(s+'..');
  ListNumbers.BeginUpdate;
  try
    Node := ListNumbers.GetFirst;
    while Node <> nil do begin
      if ListNumbers.Selected[Node] then begin
        item := ListNumbers.GetNodeData(Node);
        if item.imageindex <> 0 then begin
          item.imageindex := 2;
        end
        else begin
          Tmp := Node;
          if Node <> ListNumbers.GetFirst then begin
            Node := ListNumbers.GetPrevious(Node);
            ListNumbers.DeleteNode(Tmp);
          end
          else begin
            ListNumbers.DeleteNode(Tmp);
            Node := ListNumbers.GetFirst;
            continue;
          end;
        end;
      end;
      Node := ListNumbers.GetNext(Node);
    end;
  finally
    ListNumbers.EndUpdate;
    UpdatePhonebook;
  end;
  Form1.Status('');
end;

procedure TfrmContactsSMEdit.Resetchangeflag1Click(Sender: TObject);
var
  Item: PSIMData;
  Node: PVirtualNode;
begin
  ListNumbers.BeginUpdate;
  Node := ListNumbers.GetFirst;
  while Node <> nil do
  try
    if ListNumbers.Selected[Node] then begin
      item := ListNumbers.GetNodeData(Node);
      item.imageindex := 3;
    end;
  finally
    Node := ListNumbers.GetNext(Node);
  end;
  ListNumbers.EndUpdate;
  UpdatePhonebook;
end;

function TfrmContactsSMEdit.GetCapacity(Target, LogName: string): Integer;
var
  i: Integer;
  buffer, stop: String;
  slTmp: TStrings;
begin
  Form1.TxAndWait('AT+CPBS="'+Target+'"'); // do not localize
  Form1.TxAndWait('AT+CPBR=?'); // do not localize
  // defaults
  buffer := '';
  stop := '200'; FMaxNameLen := 14; FMaxTelLen := 80;
  // +CPBR: (1-200),80,14
  for i := 0 to ThreadSafe.RxBuffer.Count-1 do
    if Pos('+CPBR',ThreadSafe.RxBuffer.Strings[i]) = 1 then begin // do not localize
      buffer := ThreadSafe.RxBuffer.Strings[i];
      break;
    end;
  for i := 1 to length(buffer) do begin
    if IsDelimiter('()-,', buffer, i) then buffer[i] := ' ';
  end;
  // +CPBR:  1 200  80 14
  if buffer <> '' then begin
    slTmp := TStringList.Create;
    try
      slTmp.DelimitedText := buffer;
      stop := slTmp.Strings[2];
      Log.AddMessage(LogName+': max entries = '+stop, lsDebug); // do not localize debug
      FMaxTelLen := StrToInt(slTmp.Strings[3]);
      Log.AddMessage(LogName+': max tel length = '+slTmp.Strings[3], lsDebug); // do not localize debug
      FMaxNameLen := StrToInt(slTmp.Strings[4]);
      Log.AddMessage(LogName+': max name length = '+slTmp.Strings[4], lsDebug); // do not localize debug
    finally
      slTmp.Free;
    end;
  end;  
  Result := StrToInt(stop);
end;

procedure TfrmContactsSMEdit.OnConnected;
begin
  FMaxNumbers := GetCapacity('SM','SIM Book');
end;

procedure TfrmContactsSMEdit.ListNumbersAfterPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas);
begin
  NoItemsPanel.Visible := ListNumbers.RootNodeCount = 0;
end;

procedure TfrmContactsSMEdit.ListNumbersCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  SIM1, SIM2: PSIMData;
begin
  SIM1 := Sender.GetNodeData(Node1);
  SIM2 := Sender.GetNodeData(Node2);

  if Column = 0 then begin
    if SIM1.position > SIM2.position then
      Result := 1
    else
      if SIM1.position < SIM2.position then
        Result := -1
      else
        Result := 0;  
  end
  else if Column = 1 then Result := WideCompareStr(SIM1.cname, SIM2.cname)
  else if Column = 2 then Result := WideCompareStr(SIM1.pnumb, SIM2.pnumb);
end;

procedure TfrmContactsSMEdit.ListNumbersGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  SIM: PSIMData;
begin
  if Column = 0 then begin
    if (Kind = ikNormal) or (Kind = ikSelected) then begin
      SIM := Sender.GetNodeData(Node);
      ImageIndex := SIM.imageindex;
    end
    else ImageIndex := -1;
  end;
end;

procedure TfrmContactsSMEdit.ListNumbersGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  SIM: PSIMData;
begin
  SIM := Sender.GetNodeData(Node);

  if Column = 0 then CellText := IntToStr(SIM.position)
  else if Column = 1 then CellText := SIM.cname
  else if Column = 2 then CellText := SIM.pnumb
  else if Column = 3 then begin
    CellText := '';
    if SIM.ptype = 'M' then CellText := _('Cell');
    if SIM.ptype = 'W' then CellText := _('Work');
    if SIM.ptype = 'H' then CellText := _('Home');
    if SIM.ptype = 'O' then CellText := _('Other');
    if SIM.ptype = 'F' then CellText := _('Fax');
  end
  else if Column = 4 then begin
    CellText := '';
    case SIM.imageindex of
      0: CellText := _('New contact');
      1: CellText := _('Modified contact');
      2: CellText := _('Deleted contact');
      3: CellText := '';
    end;
  end;
end;

procedure TfrmContactsSMEdit.ListNumbersHeaderClick(Sender: TVTHeader;
  Column: TColumnIndex; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if Button = mbLeft then begin
    if Column = Sender.SortColumn then begin
      if Sender.SortDirection = sdDescending then
        Sender.SortDirection := sdAscending
      else
        Sender.SortDirection := sdDescending;
    end
    else
      Sender.SortColumn := Column;
    ListNumbers.Sort(nil, ListNumbers.Header.SortColumn, ListNumbers.Header.SortDirection);
  end;
end;

procedure TfrmContactsSMEdit.btnEDITClick(Sender: TObject);
var
  Node :PVirtualNode;
begin
  Node := ListNumbers.FocusedNode;
  if Node <> nil then begin
    SelContact := ListNumbers.GetNodeData(Node);
    DoEdit;
  end;
end;

procedure TfrmContactsSMEdit.PopupMenu1Popup(Sender: TObject);
begin
  Properties1.Enabled := ListNumbers.SelectedCount = 1;
  SendAllContactstoPhonebook1.Enabled := Form1.IsIrmcSyncEnabled;
  SendAllContactstoPhonebook1.Visible := not IsMEMode;
  UpdateContactsfromPhonebook1.Enabled := SendAllContactstoPhonebook1.Enabled;
  UpdateContactsfromPhonebook1.Visible := SendAllContactstoPhonebook1.Visible;
  DownloadEntirePhonebook1.Enabled := Form1.FConnected and not Form1.FObex.Connected;
end;

function TfrmContactsSMEdit.DoEdit(AsNew: boolean; NewNumber: string): boolean;
var
  Node: PVirtualNode;
begin
  Result := False;
  with TfrmEditContact.Create(nil) do
  try
    FillChar(FContact,SizeOf(FContact),0);
    IsNew := AsNew or (Selcontact = nil);
    // set restrictions
    MaxFullNameLen :=  FMaxNameLen;
    txtName.MaxLength := FMaxNameLen;
    txtCell.MaxLength := FMaxTellen;
    // update FContact (see TContactData in uSyncPhonebook)
    if IsNew then begin
      FContact.cell := NewNumber;
    end
    else begin
      { Set contact name and surname }
      SetContactFullName(@FContact,Selcontact^.cname);
      FContact.LUID := Selcontact^.LUID;
      FContact.CDID := Selcontact^.CDID;
      { Set number according to phone type }
      if Selcontact^.pnumb <> '' then
        if not IsMEMode or (Selcontact^.ptype = '') then
          FContact.cell := Selcontact^.pnumb
        else
          case Selcontact^.ptype[1] of
            'M': FContact.cell := Selcontact^.pnumb;
            'W': FContact.work := Selcontact^.pnumb;
            'H': FContact.home := Selcontact^.pnumb;
            'F': FContact.fax := Selcontact^.pnumb;
            'O': FContact.other := Selcontact^.pnumb;
          end;
    end;
    contact := FContact;
    UseSIMMode := True;
    // edit contact as a SIM entry  
    if ShowModal = mrOk then begin
      if Modified then with ListNumbers do begin
        // apply total updates
        BeginUpdate;
        try
          if IsNew then begin // create new node
            Node := AddChild(nil);
            Selcontact := ListNumbers.GetNodeData(Node);
            // new node, update IDs
            Selcontact^.LUID := '';
            Selcontact^.CDID := NewGUID;
            contact.LUID := '';
            contact.CDID := Selcontact^.CDID;
          end
          else
            Node := nil;
          try
            { copy all data }
            FContact := contact;
            Selcontact^.cname := FContact.name;
            if FContact.surname <> '' then
              Selcontact^.cname := Selcontact^.cname + ' ' + FContact.surname;

            { get new number }
            if IsNew then begin
              if FContact.cell <> '' then begin
                Selcontact^.pnumb := FContact.cell;
                Selcontact^.ptype := 'M'; // do not localize
              end;
              if FContact.work <> '' then begin
                Selcontact^.pnumb := FContact.work;
                Selcontact^.ptype := 'W'; // do not localize
              end;
              if FContact.home <> '' then begin
                Selcontact^.pnumb := FContact.home;
                Selcontact^.ptype := 'H'; // do not localize
              end;
              if FContact.fax <> '' then begin
                Selcontact^.pnumb := FContact.fax;
                Selcontact^.ptype := 'F'; // do not localize
              end;
              if FContact.other <> '' then begin
                Selcontact^.pnumb := FContact.other;
                Selcontact^.ptype := 'O'; // do not localize
              end;
            end
            else
              if not IsMEMode or (Selcontact^.ptype = '') then
                Selcontact^.pnumb := FContact.cell
              else
                case Selcontact^.ptype[1] of
                  'M': Selcontact^.pnumb := FContact.cell;
                  'W': Selcontact^.pnumb := FContact.work;
                  'H': Selcontact^.pnumb := FContact.home;
                  'F': Selcontact^.pnumb := FContact.fax;
                  'O': Selcontact^.pnumb := FContact.other;
                end;

            if IsNew then begin
              Selcontact^.imageindex := 0;
              // find free position
              Selcontact^.position := FindFreePos;
              if Selcontact^.position = -1 then begin
                DeleteNode(Node);
                raise Exception.Create(_('No free position available'));
              end
              else
                Result := True;
            end
            else
              if Selcontact^.imageindex <> 0 then begin // mark as modified
                Selcontact^.imageindex := 1;
                Result := True;
              end;
          except;
            if IsNew then DeleteNode(Node);
            raise;
          end;
          UpdatePhonebook;
        finally
          EndUpdate;
        end;
      end;
      if customModified then begin
        { save call notes to DB }
        SetContactNotes(@contact,ContactNotes);
        // no need to call UpdatePhonebook here
        Result := True;
      end;
    end;
  finally
    Free;
  end;
  ListNumbers.Sort(nil, ListNumbers.Header.SortColumn, ListNumbers.Header.SortDirection);
end;

procedure TfrmContactsSMEdit.NewPerson1Click(Sender: TObject);
begin
  if ListNumbers.RootNodeCount < FMaxNumbers then
    DoEdit(True)
  else
    ShowMessageW(_('No more space in memory! New contact can not be created.'));
end;

procedure TfrmContactsSMEdit.UpdateChanged1Click(Sender: TObject);
begin
  cbForce.Checked := False;
  btnUpdateSIM.Click;
end;

procedure TfrmContactsSMEdit.UpdateAllRecords1Click(Sender: TObject);
begin
  cbForce.Checked := True;
  btnUpdateSIM.Click;
end;

function TfrmContactsSMEdit.FindFreePos: integer;
var
  Node :PVirtualNode;
  Item: PSIMData;
  Pos: cardinal;
  found: boolean;
begin
  Pos := 1;
  while Pos <= FMaxNumbers do begin
    found := false;
    Node := ListNumbers.GetFirst;
    while Node <> nil do
    try
      item := ListNumbers.GetNodeData(Node);
      if cardinal(item.position) = Pos then begin
        found := true;
        break;
      end;
    finally
      Node := ListNumbers.GetNext(Node);
    end;
    if not found then break;
    Pos := Pos + 1;
  end;
  if Pos <= FMaxNumbers then Result := Pos
    else Result := -1;
end;

procedure TfrmContactsSMEdit.UpdateContactsPosition1Click(Sender: TObject);
var
  Pos: Integer;
  Item: PSIMData;
  Node: PVirtualNode;
begin
  if MessageDlgW(_('Sorting contacts will replace all contacts position. Are you sure?'),
    mtConfirmation, MB_YESNO or MB_DEFBUTTON2) <> ID_YES then exit;
  Pos := 1;
  try
    Node := ListNumbers.GetFirst;
    while Node <> nil do
    try
      item := ListNumbers.GetNodeData(Node);
      if item.position <> Pos then begin
        item.position := Pos;
        item.imageindex := 1; // mark as modified
      end;
      inc(Pos);
    finally
      Node := ListNumbers.GetNext(Node);
    end;
  finally
    ListNumbers.Sort(nil, ListNumbers.Header.SortColumn, ListNumbers.Header.SortDirection);
    UpdatePhonebook;
  end;  
end;

procedure TfrmContactsSMEdit.UpdateContactsfromPhonebook1Click(Sender: TObject);
var
  sl,dl: TStrings;
  i,maxd: integer;
  s,kind,item,t: WideString;
  data1, data2: PFmaExplorerNode;
begin
  data1 := Form1.ExplorerNew.GetNodeData(Form1.FNodeContactsME);
  data2 := Form1.ExplorerNew.GetNodeData(Form1.FNodeContactsSM);
  sl := TStrings(data1.Data); // source
  dl := TStrings(data2.Data); // destination

  if ListNumbers.RootNodeCount <> 0 then begin
    if sl.Count = 0 then begin
      if MessageDlgW(_('Phonebook is empty. All current SIM entries will be deleted. Continue anyway?'),
        mtConfirmation, MB_YESNO or MB_DEFBUTTON2) <> ID_YES then exit;
    end
    else
      if MessageDlgW(_('Copy all contacts from Phonebook. Current SIM entries will be deleted. Are you sure?'),
        mtConfirmation, MB_YESNO or MB_DEFBUTTON2) <> ID_YES then exit;
  end;

  { Clear SIM database }
  dl.Clear;
  Form1.ExplorerNew.DeleteChildren(Form1.FNodeContactsSM);
  try
    { Build new database }
    maxd := sl.Count;
    if Cardinal(maxd) > FMaxNumbers then maxd := FMaxNumbers;
    for i := 0 to maxd-1 do begin
      // '"Alycia/M",+359887555555555,0'
      { get full name }
      item := GetToken(sl.Strings[i],0);
      Form1.ExtractName(item,kind);
      if kind <> '' then kind := '/' + kind;
      item := Copy(item,1,FMaxNameLen) + kind;
      { get number }
      t := GetToken(sl.Strings[i],1);
      s := Copy(t,1,FMaxTelLen+byte(Pos('+',t) <> 0));
      { Construct a database item }
      item := '"' + item + '",' + s + ',' + IntToStr(i+1) + ',1'; // and mark (1) as modified
      { Add to SIM database }
      dl.Add(item);
    end;
  finally
    Form1.RenderContactList(Form1.FNodeContactsSM);
    { Update view }
    RenderData;
    Form1.Status(WideFormat(_('Copy from Phonebook: %s new items'),[IntToStr(ListNumbers.RootNodeCount)]));
  end;
end;

procedure TfrmContactsSMEdit.SendAllContactstoPhonebook1Click(Sender: TObject);
var
  Item: PSIMData;
  Node,NewNode: PVirtualNode;
  Contact: PContactData;
  NewCnt,UpdCnt: cardinal;
  s,T,N: WideString;
  i,j: integer;
begin
  NewCnt := 0;
  UpdCnt := 0;
  try
    Node := ListNumbers.GetFirst;
    while Node <> nil do
    try
      item := ListNumbers.GetNodeData(Node);
      { Sanity check phone number length }
      i := Form1.frmSyncPhonebook.FMaxTellen;
      if Length(item.pnumb) < i then i := Length(item.pnumb);
      s := Copy(item.pnumb,1+Length(item.pnumb)-i,i);
      { If contact already exists? }
      if Form1.frmSyncPhonebook.FindContact(item.cname,contact) then begin
        { Check if the number already exists for that contact
        O := GetContactPhoneType(contact,s); // get type if number found in ME contact
        if O = '' then T := item.ptype
          else T := O;
        }
        T := item.ptype;
        {}
        if T = 'W' then N := contact^.work else // do not localize
        if T = 'H' then N := contact^.home else // do not localize
        if T = 'F' then N := contact^.fax else // do not localize
        if T = 'O' then N := contact^.other else // do not localize
          N := contact^.cell; // Default to '' or 'M' phone type
        { Number position already filled in? }  
        if N <> '' then
          // TODO: Add wizard for asking where to store new number
          if MessageDlgW(WideFormat(_('Contact %s already exists.'+sLinebreak+sLinebreak),[item.cname])+
            WideFormat(_('Do you want to replace its Phonebook number [%s] with current SIM number [%s] ?'),[N,s]),
            mtConfirmation, MB_YESNO or MB_DEFBUTTON2) <> ID_YES then
            continue;
        if T = 'W' then contact^.work := s else // do not localize
        if T = 'H' then contact^.home := s else // do not localize
        if T = 'F' then contact^.fax := s else // do not localize
        if T = 'O' then contact^.other := s else // do not localize
          contact^.cell := s;
        contact^.StateIndex := 1; // contact modified
        inc(UpdCnt);
      end
      else
      if Form1.frmSyncPhonebook.ListContacts.RootNodeCount < Form1.frmSyncPhonebook.FMaxRecME then begin
        NewNode := Form1.frmSyncPhonebook.ListContacts.AddChild(nil);
        contact := Form1.frmSyncPhonebook.ListContacts.GetNodeData(NewNode);
        FillChar(contact^,SizeOf(contact^),0);
        contact^.cell := item.pnumb;
        contact^.StateIndex := 0; // new contact
        s := Copy(item.cname,1,Form1.frmSyncPhonebook.FMaxNameLen+byte(Pos(' ',s) <> 0)); // sanity check name length
        j := Pos(', ',s);
        if j = 0 then begin
          j := Pos(' ',s);
          if j = 0 then
            contact^.name := s
          else begin
            contact^.name := Copy(s,1,j-1);
            contact^.surname := Copy(s,j+1,Length(s)-j);
          end;
        end
        else begin
          contact^.surname := Copy(s,1,j-1);
          contact^.name := Copy(s,j+2,Length(s)-j-1);
        end;
        inc(NewCnt);
      end
      else
        break;
    finally
      Node := ListNumbers.GetNext(Node);
    end;
  finally
    if (NewCnt + UpdCnt) <> 0 then Form1.UpdateMEPhonebook;
    Form1.Status(WideFormat(_('Copy to Phonebook: %s new, %s modified and %s items skipped'),
      [IntToStr(NewCnt),IntToStr(UpdCnt),IntToStr(ListNumbers.RootNodeCount - NewCnt - UpdCnt)]));
  end;
end;

function TfrmContactsSMEdit.IsMEMode: boolean;
begin
  Result := False; // was... FExplore = Form1.FNodeContactsME;
end;

procedure TfrmContactsSMEdit.UpdatePhonebook;
begin
  if IsMEMode then
    Form1.UpdateMEPhonebook
  else
    Form1.UpdateSMPhonebook;
end;

function TfrmContactsSMEdit.IsRendered: boolean;
begin
  { Do we have rendered data from currently selected Eplorer node? (ME or SM) }
  //Result := FRendered and (IsMEMode = (Form1.Explorer.Selected = Form1.FNodeContactsME));
  Result := FRendered;
end;

procedure TfrmContactsSMEdit.CheckForChanges;
var
  Modified: boolean;
  Contact: PSIMData;
  Node :PVirtualNode;
begin
  Modified := False;
  Node := ListNumbers.GetFirst;
  while Node <> nil do
  try
    Contact := ListNumbers.GetNodeData(Node);
    if Contact^.imageindex <> 3 then begin
      Modified := True;
      break;
    end;
  finally
    Node := ListNumbers.GetNext(Node);
  end;
  if Modified then UpdateChanged1.Click;
end;

procedure TfrmContactsSMEdit.ListNumbersIncrementalSearch(
  Sender: TBaseVirtualTree; Node: PVirtualNode;
  const SearchText: WideString; var Result: Integer);
var
  SIM: PSIMData;
  Text: WideString;
begin
  SIM := Sender.GetNodeData(Node);
  Text := Copy(SIM.cname,1,Length(SearchText));
  Result := WideCompareText(SearchText,Text);
end;

procedure TfrmContactsSMEdit.ImportContacts1Click(Sender: TObject);
var
  i,j,adds,mods: integer;
  Node: PVirtualNode;
  AContact: TContactData;
  PContact: PContactData;
  contact: PSIMData;
  sl: TStringList;
  F,N,T: WideString;
  Modified: boolean;
  dlg: TfrmConnect;
  VCard: TVCard;
begin
  if not OpenDialog1.Execute then exit;
  Update;
  PContact := @AContact;
  dlg := GetProgressDialog;
  VCard := TVCard.Create;
  try
    if Form1.CanShowProgress then
      dlg.ShowProgress(Form1.FProgressLongOnly);
    dlg.Initialize(OpenDialog1.Files.Count,_('Importing SIM contacts'));

    Form1.Status(_('Importing contacts...'));
    //SyncLog(_('Import started'));

    adds := 0; mods := 0;
    //ListContacts.BeginUpdate;
    sl := TStringList.Create;
    try
      for i := 0 to OpenDialog1.Files.Count-1 do begin
        sl.LoadFromFile(OpenDialog1.Files[i]);
        dlg.IncProgress(1);
        VCard.Clear;
        VCard.Raw := sl;
        vCard2Contact(VCard,PContact);
        F := GetvCardFullName(VCard);
        { Process all contact numbers }
        for j := 1 to 4 do begin
          case j of
            1: N := PContact^.cell;
            2: N := PContact^.work;
            3: N := PContact^.home;
            4: N := PContact^.other;
          end;
          if N = '' then continue;
          T := GetContactPhoneType(PContact,N);
          Modified := False;
          // ask to replace old record, if present
          if FindContact(F,T,contact) then begin
            { TODO: Add dialog with replace details }
            if T <> 'O' then // do not owerwrite Other type, but create a new record instead  // do not localize
              // (TODO: add wizard here) 
              case MessageDlgW(
                WideFormat(_('Contact %s already exists. Do you want to replace its current number [%s] with imported number [%s] ?'+
                  sLinebreak+sLinebreak+
                  'Click Yes to replace number, or click No to add it as a New contact'),[F,contact^.pnumb,N]),
                mtConfirmation, MB_YESNOCANCEL or MB_DEFBUTTON2) of
                ID_YES: begin
                  //SyncLog(F + ' modified in FMA by Import.');
                  Modified := True;
                end;
                //mrNo: SyncLog(F + ' added in FMA by Import (as dublicate).');
                ID_CANCEL: Abort;
              end;
            //else SyncLog(F + ' added to FMA by Import.');
          end;
          //else SyncLog(F + ' added to FMA by Import.');
          if not Modified then begin
            Node := ListNumbers.AddChild(nil);
            contact := ListNumbers.GetNodeData(Node);
            contact^.position := FindFreePos;
            contact^.ptype := T;
          end;
          contact^.cname := F;
          contact^.pnumb := N;
          if Modified then begin
            contact^.imageindex := 1;
            inc(mods);
          end
          else begin
            contact^.imageindex := 0;
            inc(adds);
          end;
        end;
        ListNumbers.Update;
      end;
    finally
      sl.free;
      if (adds <> 0) or (mods <> 0) then begin
        //ListContacts.EndUpdate;
        ListNumbers.Sort(nil, ListNumbers.Header.SortColumn, ListNumbers.Header.SortDirection);
        Form1.UpdateSMPhonebook;
        Log.AddSynchronizationMessage('Imported '+IntToStr(adds+mods)+' item(s)... ('+
          IntToStr(adds)+' added, '+IntToStr(mods)+' modified)', lsDebug); // do not localize debug
      end;
    end;
  finally
    VCard.Free;
    FreeProgressDialog;
    //SyncLog(_('Import finished'));
    Form1.Status(_('Import complete.'));
  end;
end;

function TfrmContactsSMEdit.FindContact(FullName: WideString;
  var AContact: PSIMData): boolean;
var
  Node :PVirtualNode;
begin
  Result := False;
  Node := ListNumbers.GetFirst;
  while Node <> nil do
  try
    AContact := ListNumbers.GetNodeData(Node);
    if WideCompareText(FullName,AContact^.cname) = 0 then begin
      Result := True;
      break;
    end;
  finally
    Node := ListNumbers.GetNext(Node);
  end;
end;

function TfrmContactsSMEdit.FindContact(FullName: WideString;
  var ANode: PVirtualNode): boolean;
var
  Node :PVirtualNode;
  AContact: PSIMData;
begin
  Result := False;
  Node := ListNumbers.GetFirst;
  while Node <> nil do
  try
    AContact := ListNumbers.GetNodeData(Node);
    if WideCompareText(FullName,AContact^.cname) = 0 then begin
      ANode := Node;
      Result := True;
      break;
    end;
  finally
    Node := ListNumbers.GetNext(Node);
  end;
end;

function TfrmContactsSMEdit.FindContact(FullName, NumberType: WideString;
  var AContact: PSIMData): boolean;
var
  Node :PVirtualNode;
begin
  Result := False;
  Node := ListNumbers.GetFirst;
  while Node <> nil do
  try
    AContact := ListNumbers.GetNodeData(Node);
    if (WideCompareText(FullName,AContact^.cname) = 0) and
      (WideCompareText(NumberType,AContact^.ptype) = 0) then begin
      Result := True;
      break;
    end;
  finally
    Node := ListNumbers.GetNext(Node);
  end;
end;

procedure TfrmContactsSMEdit.ExportList(FileType: Integer; Filename: WideString);
var
  node: PVirtualNode;
  contact: PSIMData;
  AContact: TContactData;
  PContact: PContactData;
  sl: TStringList;
  str: WideString;
  VCard: TVCard;
  i: integer;
  s: string;
  XML: TXML;
  CurNodeName: string;
begin
  if FileType <> 1 then begin
    if MessageDlgW(_('FMA could Import only vCard contact exports. Do you still want to continue exporting?'),
      mtConfirmation, MB_YESNO or MB_DEFBUTTON2) <> ID_YES then
      exit;
  end;
  PContact := @AContact;
  case FileType of
    1:begin//vCard
        { TODO: export all records/numbers for a contact at once in a vCard file }
        VCard := TVCard.Create;
        sl := TStringList.Create;
        try
          with ListNumbers do begin
            node := GetFirst;
            if node <> nil then
            repeat
               try
                  if Selected[node] then begin
                     contact := GetNodeData(node);
                     FillChar(AContact,SizeOf(AContact),0);
                     SetContactFullName(PContact,contact^.cname);
                     if contact^.ptype = 'W' then PContact^.work := contact^.pnumb else // do not localize
                     if contact^.ptype = 'H' then PContact^.home := contact^.pnumb else // do not localize
                     if contact^.ptype = 'F' then PContact^.fax := contact^.pnumb else // do not localize
                     if contact^.ptype = 'O' then PContact^.other := contact^.pnumb else // do not localize
                       PContact^.cell := contact^.pnumb;
                     Contact2vCard(PContact,VCard);
                     sl.Clear;
                     sl.AddSTrings(VCard.Raw);
                     if ListNumbers.SelectedCount <> 1 then begin
                       str := contact^.ptype;
                       if str = 'O' then str := ''; // hide Other type
                       if str <> '' then str := ' ('+str+')';
                       str := Trim(contact^.cname) + str;
                       str := StringReplace(str,' ','-',[rfReplaceAll]);
                       str := WideChangeFileExt(FileName,'-'+str)+WideExtractFileExt(Filename);
                     end
                     else
                       str := Filename;
                     i := 0; s := str;
                     while WideFileExists(s) do begin
                       inc(i);
                       s := WideChangeFileExt(str,'') + ' (' + IntToStr(i) + ')' + WideExtractFileExt(str);
                     end;
                     sl.SaveToFile(s);
                  end;
               except
               end;
               node := GetNext(node);
            until node = nil;
          end;
        finally
          sl.Free;
          VCard.Free;
        end;
      end;
    2:begin//xml
        XML := TXML.Create();
        XML.TagName := 'fma_contacts'; // do not localize

        try
          with ListNumbers do
          begin
            node := GetFirst;
            if node <> nil then
            repeat
               try
                  if Selected[node] then
                  begin
                     contact := GetNodeData(node);
                     FillChar(AContact,SizeOf(AContact),0);
                     SetContactFullName(PContact,contact^.cname);

                     if contact^.ptype = 'W' then CurNodeName := 'work' else // do not localize
                     if contact^.ptype = 'H' then CurNodeName := 'home' else // do not localize
                     if contact^.ptype = 'F' then CurNodeName := 'fax' else // do not localize
                     if contact^.ptype = 'O' then CurNodeName := 'other' else // do not localize
                       CurNodeName := 'cell'; // do not localize

                     with XML.AddChild('contact') do // do not localize
                     begin
                      AddChild('name', HTMLEncode(WideStringToUTF8String(PContact^.name), False)); // do not localize
                      AddChild(CurNodeName, HTMLEncode(WideStringToUTF8String(contact^.pnumb), False));
                      AddChild('position', HTMLEncode(WideStringToUTF8String(IntToStr(contact^.position)), False)); // do not localize
                     end;
                  end;
               except
               end;
               node := GetNext(node);
            until node = nil;
          end;

          XML.Save(FileName);
        finally
          XML.Free();
        end;
      end;
    else
      raise Exception.Create(_('Not implemented yet'));
  end;
end;

procedure TfrmContactsSMEdit.DownloadEntirePhonebook1Click(Sender: TObject);
begin
  if MessageDlgW(_('Local Phonebook will be replaced with a fresh copy from the phone.'+sLinebreak+sLinebreak+
    'Any local changes will be lost. Do you wish to continue?'),
    mtConfirmation, MB_YESNO or MB_DEFBUTTON2) = ID_YES then begin
      ListNumbers.Clear;
      FullRefresh;
    end;
end;

procedure TfrmContactsSMEdit.ListNumbersKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (ListNumbers.SelectedCount = 1) then
    btnEditClick(nil);
end;

procedure TfrmContactsSMEdit.FullRefresh;
begin
  Form1.ActionContactsDownload.Execute;
  UpdatePhonebook;
end;

procedure TfrmContactsSMEdit.FormStorage1SavePlacement(Sender: TObject);
var
  s: string;
  i: integer;
begin
  with ListNumbers.Header do begin
    s := IntToStr(SortColumn)+','+IntToStr(Ord(SortDirection));
    for i := 0 to Columns.Count-1 do
      s := s+','+IntToStr(Columns[i].Width)+','+IntToStr(Columns[i].Position);
  end;
  FormStorage1.StoredValue['ListHeader'] := s; // do not localize
end;

procedure TfrmContactsSMEdit.FormStorage1RestorePlacement(Sender: TObject);
var
  s: widestring;
  i: integer;
begin
  s := FormStorage1.StoredValue['ListHeader']; // do not localize
  if s <> '' then
    try
      with ListNumbers.Header do begin
        SortColumn := StrToInt(GetFirstToken(s));
        SortDirection := TSortDirection(StrToInt(GetFirstToken(s)));
        for i := 0 to Columns.Count-1 do begin
          Columns[i].Width := StrToInt(GetFirstToken(s));
          Columns[i].Position := StrToInt(GetFirstToken(s));
        end;
      end;
    except
    end;
end;

procedure TfrmContactsSMEdit.ListNumbersHeaderMouseUp(Sender: TVTHeader;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FormStorage1SavePlacement(nil);
end;

function TfrmContactsSMEdit.FindContact(Number: WideString): WideString;
var
  Node: PVirtualNode;
  contact: PSIMData;
begin
  Result := '';
  Node := ListNumbers.GetFirst;
  while Node <> nil do begin
    contact := ListNumbers.GetNodeData(Node);
    if CompareText(Form1.GetPartialNumber(Number),Form1.GetPartialNumber(contact.pnumb)) = 0 then begin
      Result := contact.cname;
      break;
    end;
    Node := ListNumbers.GetNext(Node);
  end;
end;

procedure TfrmContactsSMEdit.RenderGUIDs;
var
  contact: PSIMData;
  Node: PVirtualNode;
begin
  { Make sure all contacts' GUIDs are unique }
  Node := ListNumbers.GetFirst;
  while Node <> nil do begin
    contact := ListNumbers.GetNodeData(Node);
    repeat
      if IsUniqueGUID(contact) then break;
      contact.CDID := NewGUID;
    until False;
    Node := ListNumbers.GetNext(Node);
  end;
end;

function TfrmContactsSMEdit.IsUniqueGUID(who: PSIMData): boolean;
var
  Node: PVirtualNode;
  contact: PSIMData;
begin
  { Checks whether who contact has an unique GUID field }
  Result := True;
  Node := ListNumbers.GetFirst;
  while Node <> nil do begin
    contact := ListNumbers.GetNodeData(Node);
    if (contact <> who) and (GUIDToString(contact.CDID) = GUIDToString(who.CDID)) then begin
      Result := False;
      break;
    end;
    Node := ListNumbers.GetNext(Node);
  end;
end;

end.

