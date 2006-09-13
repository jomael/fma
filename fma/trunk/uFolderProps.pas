unit uFolderProps;

{
*******************************************************************************
* Descriptions: Implementation for Explorer properties click
* $Source: /cvsroot/fma/fma/uFolderProps.pas,v $
* $Locker:  $
*
* Todo:
*    - remove obsolete "if (id and $F00000) = $100000" usage !!!
*
* Change Log:
* $Log: uFolderProps.pas,v $
* Revision 1.20.2.22  2006/03/16 18:39:55  z_stoichev
* Added New profiles database unique ID by phone name.
*
* Revision 1.20.2.21  2006/03/15 13:41:37  z_stoichev
* Changed NoItemsPanel GUI.
*
* Revision 1.20.2.20  2006/03/14 12:21:54  z_stoichev
* - Fixed Change reccurent to non-reccurent Alarm.
* - Fixed Show Alarms properties database details.
* - Fixed Group properties listview columns names.
* - Added Group properties Add Member confirmation.
*
* Revision 1.20.2.19  2006/03/13 13:59:16  z_stoichev
* Create new alarm using Properties dialog.
*
* Revision 1.20.2.18  2006/03/12 22:52:38  z_stoichev
* Added Organized Alarms support (testing).
*
* Revision 1.20.2.17  2006/01/24 14:23:27  z_stoichev
* Fixed NoItemsPanel height adjustment.
*
* Revision 1.20.2.16  2006/01/20 13:53:32  z_stoichev
* Disable Delivery Rules for non-custom folders.
* Change My Phone properties icon image.
*
* Revision 1.20.2.15  2006/01/16 11:26:56  mhr3
* Form1.Explorer -> Form1.ExplorerNew
*
* Revision 1.20.2.14  2005/10/04 14:09:05  z_stoichev
* Fixed GUI.
*
* Revision 1.20.2.13  2005/10/04 14:04:01  z_stoichev
* Fixed GUI.
*
* Revision 1.20.2.12  2005/10/02 22:36:43  z_stoichev
* Delivery Rules implementation changes.
*
* Revision 1.20.2.11  2005/10/01 10:40:25  z_stoichev
* Fixed database nodes info.
*
* Revision 1.20.2.10  2005/09/20 14:44:57  z_stoichev
* Changed Confirmations default button to NO.
*
* Revision 1.20.2.9  2005/09/18 21:43:15  z_stoichev
* Update Explorer Properties on connection change.
* Added Contact Group properties add/remove members.
*
* Revision 1.20.2.8  2005/09/17 11:47:04  z_stoichev
* Added Contacts Group support.
*
* Revision 1.20.2.7  2005/09/06 18:32:55  z_stoichev
* Bugfixes and improvements (2.1.1.102b)
*
* Revision 1.20.2.6  2005/08/22 23:56:05  z_stoichev
* Various GUI changes and bugfixes.
*
* Revision 1.20.2.5  2005/08/19 00:08:05  z_stoichev
* Show different icons in Explorer Properties.
*
* Revision 1.20.2.4  2005/08/18 23:10:17  z_stoichev
* - Added detailed info and some actions to Call properties.
* - Fixed Database info for some Explorer Node properties.
*
* Revision 1.20.2.3  2005/08/18 17:42:23  z_stoichev
* GUI fixes.
*
* Revision 1.20.2.2  2005/08/18 17:11:05  z_stoichev
* - New Folder and File properties dialog.
*
* Revision 1.20.2.1  2005/04/03 12:22:11  lordlarry
* Changed some methods to WideString methods
*
* Revision 1.20  2005/02/08 15:38:51  voxik
* Merged with L10N branch
*
* Revision 1.16.2.3  2005/01/07 17:34:30  expertone
* Merge with MAIN branch
*
* Revision 1.19  2004/12/23 09:41:14  z_stoichev
* Fixed background issue.
*
* Revision 1.18  2004/12/14 11:21:45  z_stoichev
* - Fixed: File properties Preview hided after Refresh.
* - Fixed: Use AppData path to access local files.
* - Fixed: Sound file preview locked on Refresh.
* - Fixed: Themes database profile sub-path.
*
* Revision 1.17  2004/12/11 16:18:13  z_stoichev
* Fixed AV bug on non-file nodes.
*
* Revision 1.16.2.2  2004/10/25 20:21:42  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.16.2.1  2004/10/19 19:48:38  expertone
* Add localization (gnugettext)
*
* Revision 1.16  2004/09/21 14:38:01  z_stoichev
* Fixed TabSheel3 never visible issue
*
* Revision 1.15  2004/09/20 13:49:53  z_stoichev
* Fixed Files Refresh TabSheel update (merged with FileObject)
*
* Revision 1.14  2004/09/20 13:40:34  z_stoichev
* Fixed Files Refresh TabSheel update
*
* Revision 1.13  2004/09/20 12:52:31  merijnb
* bugfix for FileObject (AV on properties of a non-files node)
*
* Revision 1.12  2004/09/20 11:57:00  merijnb
* merged with FileObject
*
* Revision 1.11.8.1  2004/09/02 10:16:33  merijnb
* introduced TFile object
*
* Revision 1.11  2004/08/17 14:47:02  merijnb
* added support for sub-dirs for preview
*
* Revision 1.10  2004/06/28 14:01:29  z_stoichev
* Bugfixes and common General page.
* Added bookmark editing support.
*
* Revision 1.9  2004/06/17 12:42:17  z_stoichev
* Fixed Unicode
*
* Revision 1.8  2004/05/19 18:34:15  z_stoichev
* Build 0.1.0.35c
*
* Revision 1.7  2004/03/26 18:37:39  z_stoichev
* Build 0.1.0.35 RC5
*
* Revision 1.6  2004/03/08 12:54:22  z_stoichev
* Phone number - msg/call contact
* Autoupdate phone details every 1 sec
*
* Revision 1.5  2003/12/16 17:38:05  z_stoichev
* Refresh gives error when folder does not exists.
*
* Revision 1.4  2003/12/11 14:55:24  z_stoichev
* Fixed Explorer properties visual bug issues.
* Phone properties now shown more phone information.
*
* Revision 1.3  2003/12/11 12:41:02  z_stoichev
* Refresh obex file implemented.
*
* Revision 1.2  2003/11/28 09:38:07  z_stoichev
* Merged with branch-release-1-1 (Fma 0.10.28c)
*
* Revision 1.1.2.4  2003/11/13 16:39:54  z_stoichev
* Add more items type support.
*
*
*
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls,
  TntControls, Forms, TntForms, Dialogs, TntDialogs, StdCtrls, TntStdCtrls, ComCtrls, TntComCtrls, UniTntCtrls, ExtCtrls,
  TntExtCtrls, GR32_Image, MPlayer, OKTThemeEngine, uFiles, Menus, TntMenus, ImgList, ImageListXP, VirtualTrees;

const
  fpNone = 0;
  fpPhone = 1;
  fpContact = 2;
  fpBookmark = 3;
  fpDB = 4;
  fsAlarm = 5;

type
  TfrmFolderProps = class(TTntForm)
    ApplyButton: TTntButton;
    PageControl1: TTntPageControl;
    tsGeneral: TTntTabSheet;
    TntImage1: TTntImage;
    TntEdit1: TTntEdit;
    Timer1: TTimer;
    ThemeContainer1: TOKTThemeContainer;
    SaveDialog1: TTntSaveDialog;
    lblName1: TTntLabel;
    Button3: TTntButton;
    pmEffects: TTntPopupMenu;
    BlackandWhite1: TTntMenuItem;
    tsFilePreview: TTntTabSheet;
    TntImage2: TTntImage;
    lblName2: TTntLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Panel1: TPanel;
    Panel2: TPanel;
    pcGeneral: TTntPageControl;
    tsPhone: TTntTabSheet;
    lbManufacturer: TTntLabel;
    lbModel: TTntLabel;
    lbSWRevision: TTntLabel;
    lbSerialNumber: TTntLabel;
    lbvbat: TTntLabel;
    lbicharge: TTntLabel;
    lbcyclescharge: TTntLabel;
    lbdcio: TTntLabel;
    lbiphone: TTntLabel;
    lblTimeLeft: TTntLabel;
    lbtempbatt: TTntLabel;
    lbtempphone: TTntLabel;
    Label11: TTntLabel;
    Label10: TTntLabel;
    Label9: TTntLabel;
    Label8: TTntLabel;
    Label7: TTntLabel;
    Label5: TTntLabel;
    Label4: TTntLabel;
    Label6: TTntLabel;
    Label14: TTntLabel;
    Label16: TTntLabel;
    Label13: TTntLabel;
    Label12: TTntLabel;
    tsContact: TTntTabSheet;
    lblContact: TTntLabel;
    lblContactPrefix: TTntLabel;
    Button1: TTntButton;
    Button2: TTntButton;
    tsDatabase: TTntTabSheet;
    tsFile: TTntTabSheet;
    Label1: TTntLabel;
    lblType: TTntLabel;
    Label3: TTntLabel;
    lblNoCache: TTntLabel;
    Label15: TTntLabel;
    btnDownload: TTntButton;
    edLocalFile: TTntEdit;
    btnFindTarget: TTntButton;
    pcFile: TTntPageControl;
    tsFileImage: TTntTabSheet;
    TntLabel1: TTntLabel;
    imgDim: TTntImage;
    TntLabel2: TTntLabel;
    lblPicName: TTntLabel;
    TntLabel3: TTntLabel;
    lblPicSize: TTntLabel;
    TntLabel4: TTntLabel;
    lblPicPal: TTntLabel;
    lblPicDim: TTntLabel;
    PicPanel1: TTntPanel;
    SelImage: TImage32;
    btnEffects: TTntButton;
    btnSaveImage: TTntButton;
    tsFileSound: TTntTabSheet;
    Label17: TTntLabel;
    imgSnd: TTntImage;
    lblSndType: TTntLabel;
    TntLabel5: TTntLabel;
    lblSndName: TTntLabel;
    TntLabel6: TTntLabel;
    lblSndSize: TTntLabel;
    MediaPlayer1: TMediaPlayer;
    tsFileTheme: TTntTabSheet;
    btnSS: TTntButton;
    lbPreview: TTntListBox;
    Erode1: TTntMenuItem;
    Dilate1: TTntMenuItem;
    ApplyMosaic1: TTntMenuItem;
    ApplyHSLFactor1: TTntMenuItem;
    BitmapChannel1: TTntMenuItem;
    btnUndoChanges: TTntButton;
    lblRemoteFile: TTntLabel;
    TntLabel8: TTntLabel;
    btnFilters: TTntButton;
    pmFilters: TTntPopupMenu;
    Blur1: TTntMenuItem;
    MotionBlur1: TTntMenuItem;
    Soften1: TTntMenuItem;
    Sharpen1: TTntMenuItem;
    Emboss1: TTntMenuItem;
    ThemePanel: TPanel;
    ThemeViewer1: TOKTThemeViewer;
    TntLabel7: TTntLabel;
    lblThemeCreatorLink: TTntLabel;
    TntLabel9: TTntLabel;
    lblAltPEToolLink: TTntLabel;
    btnSaveToPhone: TTntButton;
    TntLabel10: TTntLabel;
    lblSize: TTntLabel;
    TntLabel12: TTntLabel;
    lblContactType: TTntLabel;
    ImageListXP1: TImageListXP;
    tsGroup: TTntTabSheet;
    btnGroupDel: TTntButton;
    btnGroupAdd: TTntButton;
    lvGroupMembers: TTntListView;
    btnFindDB: TTntButton;
    TntLabel13: TTntLabel;
    lbphonedb: TTntLabel;
    btnRules: TTntButton;
    NoItemsPanel: TTntPanel;
    lvDatabase: TTntListView;
    ImageList1: TImageList;
    tsAlarm: TTntTabSheet;
    TntLabel11: TTntLabel;
    dtAlarmTime: TTntDateTimePicker;
    TntLabel14: TTntLabel;
    mmoAlarmNote: TTntMemo;
    TntLabel15: TTntLabel;
    cbAlarmDay1: TTntCheckBox;
    cbAlarmDay2: TTntCheckBox;
    cbAlarmDay3: TTntCheckBox;
    cbAlarmDay4: TTntCheckBox;
    cbAlarmDay5: TTntCheckBox;
    cbAlarmDay6: TTntCheckBox;
    cbAlarmDay7: TTntCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MediaPlayer1Click(Sender: TObject; Button: TMPBtnType;
      var DoDefault: Boolean);
    procedure btnDownloadClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure lbPreviewChange(Sender: TObject);
    procedure btnSSClick(Sender: TObject);
    procedure btnEffectsClick(Sender: TObject);
    procedure ApplyEffectsClick(Sender: TObject);
    procedure TntEdit1Change(Sender: TObject);
    procedure btnFindTargetClick(Sender: TObject);
    procedure btnSaveImageClick(Sender: TObject);
    procedure TntFormDestroy(Sender: TObject);
    procedure btnUndoChangesClick(Sender: TObject);
    procedure btnFiltersClick(Sender: TObject);
    procedure ApplyFilterClick(Sender: TObject);
    procedure LinkClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    procedure btnSaveToPhoneClick(Sender: TObject);
    procedure btnGroupAddClick(Sender: TObject);
    procedure lvGroupMembersSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btnGroupDelClick(Sender: TObject);
    procedure btnFindDBClick(Sender: TObject);
    procedure btnRulesClick(Sender: TObject);
    procedure FieldChange(Sender: TObject);
  private
    { Private declarations }
    Fullpath: string;
    fFile: TFile;
    FModified,FImageModified: boolean;
    FRootNode: PVirtualNode;
    FAlarmIndex: Integer;
    procedure UpdatePhoneDetails;
    procedure UpdateImageDetails;
    procedure UpdateSoundDetails;
    procedure DoSaveChanges;
    procedure SetTab(Control: TTntPageControl; Tab: TTntTabSheet; Where: TPanel);
    procedure SetRootNode(const Value: PVirtualNode);
  public
    { Public declarations }
    procedure OnConnectionChange(Online: boolean);
    property RootNode: PVirtualNode read FRootNode write SetRootNode default nil;
  end;

var
  frmFolderProps: TfrmFolderProps;

implementation

uses
  gnugettext, gnugettexthelpers, uThreadSafe,
  ShellAPI, Unit1, uGlobal, uImg32Helper, uDialogs, uSelectContact, uSyncPhonebook,
  uSIMEdit, uMEEdit, uStatusDlg, uOptionsPage,
  gr32_vbeffects, gr32_vbconv;

{$R *.dfm}

procedure TfrmFolderProps.SetRootNode(const Value: PVirtualNode);
const
  LastIconId: Integer = -1;
var
  i,id: Integer;
  Node,node2: PVirtualNode;
  data,data2: PFmaExplorerNode;
  w,t: WideString;
  cb: TTntCheckBox;
begin
  pcGeneral.ActivePageIndex := -1;
  tsFilePreview.TabVisible := False;
  FModified := False;
  FRootNode := Value;
  if Value = nil then exit;

  { Should we display 'file' properties? }
  Node := Value.Parent;
  while Node <> nil do begin
    if Node.Parent = Form1.FNodeObex then begin
      tsFilePreview.TabVisible := True; //(id and $F00000) = $500000; // this tabsheet should only be visible for files
      break;
    end;
    Node := Node.Parent;
  end;
  data := Form1.ExplorerNew.GetNodeData(Value);
  id := data.StateIndex;
  if (id and $F00000) = $200000 then
    TntEdit1.Text := Form1.GetSMSNodeName(Value) // Text Message folders
  else
    TntEdit1.Text := data.Text;
  TntEdit1Change(nil);

  { Allow phone rename if connected and root is selected }
  if Value = Form1.ExplorerNew.GetFirst then begin
    TntEdit1.Visible := True;
    { Get phone info }
    UpdatePhoneDetails;
    SetTab(pcGeneral,tsPhone,Panel1);
  end;

  if not Visible then begin // will be executed on dialog show (first time)
    { reset stored icon id }
    LastIconId := -1;
    lvDatabase.Clear;
    NoItemsPanel.Visible := False;
    Fullpath := Form1.GetProfilePath+'dat'; // do not localize
    btnFindDB.Enabled := True;
    btnRules.Visible := False;
    lvDatabase.Height := btnFindDB.Top - lvDatabase.Top - 8;
    // Contacts
    if (id and $F00000) = $100000 then begin
      lvDatabase.Items.Add.Caption := 'CallNotes.dat'; // do not localize
      lvDatabase.Items.Add.Caption := 'Contacts.ME.dat'; // do not localize
      lvDatabase.Items.Add.Caption := 'Contacts.SM.dat'; // do not localize
      lvDatabase.Items.Add.Caption := 'Contacts.SYNC.dat'; // do not localize
      lvDatabase.Items.Add.Caption := 'Contacts.SYNCMAX.dat'; // do not localize
      lvDatabase.Items.Add.Caption := 'ContactSync.xml'; // do not localize
    end;
    // Messages
    if (id and $F00000) = $200000 then begin
      lvDatabase.Items.Add.Caption := 'SMSArchive.dat'; // do not localize
      lvDatabase.Items.Add.Caption := 'SMSDrafts.dat'; // do not localize
      lvDatabase.Items.Add.Caption := 'SMSInbox.dat'; // do not localize
      lvDatabase.Items.Add.Caption := 'SMSIncoming.dat'; // do not localize
      lvDatabase.Items.Add.Caption := 'SMSIncoming.Index.dat'; // do not localize
      lvDatabase.Items.Add.Caption := 'SMSOutbox.dat'; // do not localize
      lvDatabase.Items.Add.Caption := 'SMSSent.dat'; // do not localize
      lvDatabase.Items.Add.Caption := 'UserFolders.dat'; // do not localize
      { Allow Rules only for specified folders }
      btnRules.Enabled := data.StateIndex = FmaSMSSubFolderFlag;
      btnRules.Visible := True;
      lvDatabase.Height := btnRules.Top - lvDatabase.Top - 8;
    end;
    // Organizer Bookmarks
    if (id and $FF0000) = $320000 then begin
      lvDatabase.Items.Add.Caption := 'Bookmarks.dat'; // do not localize
      lvDatabase.Items.Add.Caption := 'Bookmarks.SYNC.dat'; // do not localize
    end;
    // Organizer Calendar
    if (id and $FF0000) = $340000 then begin
      lvDatabase.Items.Add.Caption := 'Calendar.vcs'; // do not localize
      lvDatabase.Items.Add.Caption := 'Calendar.SYNC.dat'; // do not localize
    end;
    // Files, Profiles, Groups, Calls, Alarms
    if ((id and $F00000) = $500000) or ((id and $F00000) = $700000) or
      ((id and $F00000) = $800000) or ((id and $F00000) = $400000) or ((id and $FF0000) = $310000) then begin
      NoItemsPanel.Visible := True;
      btnFindDB.Enabled := False;
    end;

    // Phones
    if data.ImageIndex in [9..13] then begin
      lblContactType.Caption := _('Phone number');
      lblContactPrefix.Caption := _('Owner:');
      data2 := Form1.ExplorerNew.GetNodeData(Value.Parent);
      lblContact.Caption := data2.Text;
      SetTab(pcGeneral,tsContact,Panel1);
    end;
    // Calls
    if data.ImageIndex in [53..55] then begin
      data2 := Form1.ExplorerNew.GetNodeData(Value.Parent);
      lblContactType.Caption := _('Call') + ' (' + _(data2.Text) + ')';
      lblContactPrefix.Caption := _('When:');
      lblContact.Caption := GetToken(TStrings(data2.Data)[data.StateIndex-1],1); // HACK! See uExploreView Item.descr
      SetTab(pcGeneral,tsContact,Panel1);
    end;
    // Groups
    if data.ImageIndex = 58 then begin
      lvGroupMembers.Clear;
      node2 := Value.FirstChild;
      while Assigned(node2) do begin
        data2 := Form1.ExplorerNew.GetNodeData(node2);
        with lvGroupMembers.Items.Add do begin
          Caption := data2.Text;
          SubItems.Add(IntToStr(node2.ChildCount));
          ImageIndex := data2.ImageIndex;
          StateIndex := data2.StateIndex;
        end;
        node2 := node2.NextSibling;
      end;
      SetTab(pcGeneral,tsGroup,Panel1);
    end;
    // Alarms
    if data.ImageIndex = 66 then begin
      node2 := Value.Parent;
      if Assigned(node2) then begin
        data2 := Form1.ExplorerNew.GetNodeData(node2);
        FAlarmIndex := data.StateIndex;
        if FAlarmIndex = -1 then
          w := data.Text // creating new alarm, get it's time, no recurrence by default
        else
          w := TStringList(data2.Data)[Value.Index];
        t := GetFirstToken(w);
        dtAlarmTime.Date := 0;
        dtAlarmTime.Time := EncodeTime(StrToInt(Copy(t,1,2)),StrToInt(Copy(t,4,2)),0,0);
        w := GetToken(w,3); // should be 4 but 1 is already removed by GetFirstToken(w)
        if w = '0' then w := '1,2,3,4,5,6,7';
        for i := 1 to 7 do begin
          cb := (FindComponent('cbAlarmDay'+IntToStr(i)) as TTntCheckBox); // do not localize
          if FAlarmIndex <> 1 then begin
            cb.Enabled := True;
            cb.Checked := Pos(IntToStr(i),w) <> 0;
          end
          else begin
            { Alarm #1 is not recurrent }
            cb.Enabled := False;
            cb.Checked := False;
          end;
        end;
        SetTab(pcGeneral,tsAlarm,Panel1);
      end;
    end;

    if NoItemsPanel.Visible or (lvDatabase.Items.Count <> 0) then
      SetTab(pcGeneral,tsDatabase,Panel1);
  end;

  if tsFilePreview.TabVisible then begin
    { show file info on General tab }
    SetTab(pcGeneral,tsFile,Panel1);
    fFile := TFile(data.Data);
    FullPath := ExtractFileDir(Form1.GetProfilePath)+fFile.InternalName;
    btnFindTarget.Enabled := FileExists(Fullpath);
    if btnFindTarget.Enabled then edLocalFile.Text := FullPath
      else edLocalFile.Text := '';
    lblRemoteFile.Caption := fFile.FullPath;
    lblSize.Caption := Format(_('%.1n KB (%d bytes)'),[fFile.Size / 1024,fFile.Size]);
    { show file details tab }
    pcFile.ActivePageIndex := -1;
    try
      data2 := Form1.ExplorerNew.GetNodeData(fFile.TreeNode);
      case data2.ImageIndex of
        36: begin // sound
          SetTab(pcFile,tsFileSound,Panel2);
          lblType.Caption := _('Sound');
          if btnFindTarget.Enabled then begin
            lblNoCache.Caption := _('Downloaded');
            MediaPlayer1.FileName := Fullpath;
            MediaPlayer1.Open;
            MediaPlayer1.Enabled := True;
            UpdateSoundDetails;
          end
          else
            lblNoCache.Caption := _('In phone only');
        end;
        37: begin // image
          SetTab(pcFile,tsFileImage,Panel2);
          lblType.Caption := _('Picture');
          if btnFindTarget.Enabled then begin
            lblNoCache.Caption := _('Downloaded');
            { Use uGlobal function }
            LoadBitmap32FromFile(Fullpath,SelImage.Bitmap);
            SelImage.Visible := True;
            btnEffects.Enabled := True;
            btnFilters.Enabled := True;
            btnSaveImage.Enabled := False;
            btnUndoChanges.Enabled := False;
            btnSaveToPhone.Enabled := False;
            FImageModified := False;
            UpdateImageDetails;
          end
          else
            lblNoCache.Caption := _('In phone only');
        end;
        27: begin // theme
          if not (Form1.IsT610Clone or Form1.IsK700Clone {or Form1.IsK750Clone}) then
            Abort;
          SetTab(pcFile,tsFileTheme,Panel2);
          lblType.Caption := _('Theme');
          if btnFindTarget.Enabled then begin
            lblNoCache.Caption := _('Downloaded');
            ThemeContainer1.OpenTheme(Fullpath);
            ThemeViewer1.Preview := pvStandby;
            lbPreview.ItemIndex := Ord(pvStandby)-1;
          end
          else
            lblNoCache.Caption := _('In phone only');
        end;
        else begin
          lblType.Caption := _('Unknown');
          Abort;
        end;
      end;
    except
      lblNoCache.Caption := _('Not supported');
      tsFilePreview.TabVisible := False;
    end;

    { If corrupt or unsupported file, or not downloaded then hide Advanced tab sheet }
    if (pcFile.ActivePageIndex = -1) or not btnFindTarget.Enabled then
      tsFilePreview.TabVisible := False;
  end;

  { Check connection status }
  OnConnectionChange(Form1.FConnected);

  { Finally, set proper icon }
  id := 0;                                           // other object
  if pcFile.ActivePage = tsFileImage then id := 1;   // image
  if pcFile.ActivePage = tsFileSound then id := 2;   // sound
  if pcFile.ActivePage = tsFileTheme then id := 3;   // theme
  if pcGeneral.ActivePage = tsDatabase then id := 4; // folder
  if pcGeneral.ActivePage = tsContact then begin
    if data.ImageIndex in [9..13] then id := 5;      // phone number
    if data.ImageIndex in [53..55] then id := 6;     // call
  end;
  if pcGeneral.ActivePage = tsPhone then id := 7;    // my phone
  if Value = Form1.FNodeCalendar then id := 8;       // calendar
  if Value = Form1.FNodeBookmarks then id := 9;      // bookmarks
  if data.ImageIndex = 58 then id := 10;             // group
  if data.ImageIndex = 66 then id := 11;             // alarm

  if (id = 0) and (Value.ChildCount <> 0) then id := 4;   // other object with subobjects is folder
  if LastIconId <> id then begin
    ImageListXP1.GetIcon(id,TntImage1.Picture.Icon);
    TntImage2.Picture.Assign(TntImage1.Picture);
    LastIconId := id;
  end;

  FModified := False;
  if (pcGeneral.ActivePage = tsAlarm) and (FAlarmIndex = -1) then
    FModified := True; // creating new alarm
end;

procedure TfrmFolderProps.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);

  pcGeneral.Style := tsButtons;
  pcGeneral.ActivePageIndex := -1;
  pcFile.Style := tsButtons;
  pcFile.ActivePageIndex := -1;

  lblPicDim.Left := imgDim.Left + imgDim.Width + 4;
  lblPicName.Left := TntLabel2.Left + TntLabel2.Width + 4;
  lblPicSize.Left := TntLabel3.Left + TntLabel3.Width + 4;
  lblPicPal.Left := TntLabel4.Left + TntLabel4.Width + 4;
  lblPicDim.Caption := _('128x127 (0x0 pixels)');
  lblPicName.Caption := '';
  lblPicSize.Caption := _('0,0 KB (0 bytes)');
  lblPicPal.Caption := _('Hi-Color (65535 colors)');

  lblSndType.Left := imgSnd.Left + imgSnd.Width + 4;
  lblSndName.Left := TntLabel5.Left + TntLabel5.Width + 4;
  lblSndSize.Left := TntLabel6.Left + TntLabel6.Width + 4;
  lblSndType.Caption := _('(polyphonic stereo sound, supported by phone)');
  lblSndName.Caption := '';
  lblSndSize.Caption := _('0,0 KB (0 bytes)');

  lblThemeCreatorLink.Font.Color := clBlue;
  lblThemeCreatorLink.Font.Style := [fsUnderline];
  lblAltPEToolLink.Font.Color := clBlue;
  lblAltPEToolLink.Font.Style := [fsUnderline];
  
{$IFNDEF VER150}
  Form1.ThemeManager1.CollectForms(Self);
{$ELSE}
  { HACK! Do not apply Win XP themes on Phone Theme Viewer background }
  ThemePanel.ParentBackground := False;
  NoItemsPanel.ParentBackground := False;
{$ENDIF}
end;

procedure TfrmFolderProps.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  ApplyButton.SetFocus;
end;

procedure TfrmFolderProps.MediaPlayer1Click(Sender: TObject;
  Button: TMPBtnType; var DoDefault: Boolean);
begin
  if Button = btStop then MediaPlayer1.Rewind;
end;

procedure TfrmFolderProps.btnDownloadClick(Sender: TObject);
begin
  if (pcFile.ActivePage = tsFileImage) and btnSaveImage.Enabled and
    (MessageDlgW(_('Discard picture changes?'), mtConfirmation, MB_YESNO or MB_DEFBUTTON2) <> ID_YES) then
    exit;
  btnDownload.Enabled := False;
  try
    MediaPlayer1.Close;
    ForceDirectories(ExtractFileDir(Fullpath));
    Form1.ObexGetFile(Fullpath,fFile.FullPath);
    { Update view }
    RootNode := RootNode;
    FImageModified := False;
  except
    lblNoCache.Caption := _('Download failed');
    btnDownload.Enabled := True;
  end;
end;

procedure TfrmFolderProps.UpdatePhoneDetails;
begin
  lbManufacturer.Caption   := Form1.frmInfoView.lbManufacturer.Caption;
  lbModel.Caption          := Form1.frmInfoView.lbModel.Caption;
  lbSWRevision.Caption     := Form1.frmInfoView.lbSWRevision.Caption;
  lbSerialNumber.Caption   := Form1.frmInfoView.lbSerialNumber.Caption;
  lbvbat.Caption           := Form1.frmInfoView.lbvbat.Caption;
  lbicharge.Caption        := Form1.frmInfoView.lbicharge.Caption;
  lbcyclescharge.Caption   := Form1.frmInfoView.lbcyclescharge.Caption;
  lbdcio.Caption           := Form1.frmInfoView.lbdcio.Caption;
  lbiphone.Caption         := Form1.frmInfoView.lbiphone.Caption;
  lblTimeLeft.Caption      := Form1.frmInfoView.lblTimeLeft.Caption;
  lbtempbatt.Caption       := Form1.frmInfoView.lbtempbatt.Caption;
  lbtempphone.Caption      := Form1.frmInfoView.lbtempphone.Caption;
  lbphonedb.Caption        := 'Phone.dat';
  Timer1.Enabled := True;
end;

procedure TfrmFolderProps.Timer1Timer(Sender: TObject);
begin
  UpdatePhoneDetails;
end;

procedure TfrmFolderProps.lbPreviewChange(Sender: TObject);
begin
  ThemeViewer1.Preview := TOKTPreview(lbPreview.ItemIndex+1);
end;

procedure TfrmFolderProps.btnSSClick(Sender: TObject);
begin
  SaveDialog1.FileName := WideFormat('%s - %s.bmp', // do not localize
    [WideChangeFileExt(lblName1.Caption,''),lbPreview.Items[lbPreview.ItemIndex]]);
  if SaveDialog1.Execute then
    ThemeViewer1.ScreenShot.SaveToFile(SaveDialog1.FileName);
end;

procedure TfrmFolderProps.TntEdit1Change(Sender: TObject);
begin
  lblName1.Caption := TntEdit1.Text;
  lblName2.Caption := TntEdit1.Text;
  FModified := True;
end;

procedure TfrmFolderProps.UpdateImageDetails;
begin
  lblPicName.Caption := WideExtractFileName(fFile.InternalName);
  lblPicDim.Caption := Format(_('%dx%d (%dx%d pixels)'),[SelImage.Width,SelImage.Height,
    SelImage.Bitmap.BitmapInfo.bmiHeader.biWidth,-SelImage.Bitmap.BitmapInfo.bmiHeader.biHeight]);
  lblPicSize.Caption := Format(_('%.1n KB (%d bytes)'),[fFile.Size / 1024,fFile.Size]);
  case SelImage.Bitmap.BitmapInfo.bmiHeader.biBitCount of
     8: lblPicPal.Caption := _('Low-Color (256 colors)');
    16: lblPicPal.Caption := _('Hi-Color (65535 colors)');
    24: lblPicPal.Caption := _('True-Color (24-bit colors)');
    32: lblPicPal.Caption := _('True-Color (32-bit colors)');
    else lblPicPal.Caption := _('Low-Color (<256 colors)');
  end;
end;

procedure TfrmFolderProps.UpdateSoundDetails;
begin
  lblSndName.Caption := WideExtractFileName(fFile.InternalName);
  lblSndSize.Caption := Format(_('%.1n KB (%d bytes)'),[fFile.Size / 1024,fFile.Size]);
  try
    MediaPlayer1.Open;
    lblSndType.Caption := Format(_('Track length is %d samples (Custom format)'),[MediaPlayer1.TrackLength[1]]);
  except
    lblSndType.Caption := _('Unknown (Unsupported format)');
    MediaPlayer1.Enabled := False;
  end;
end;

procedure TfrmFolderProps.btnSaveImageClick(Sender: TObject);
begin
  btnSaveImage.Enabled := False;
  try
    { Save modified local file }
    SaveBitmap32ToFile(Fullpath,SelImage.Bitmap);
    btnUndoChanges.Enabled := False;
    btnSaveToPhone.Enabled := True;
    FImageModified := True;
  except
    btnSaveImage.Enabled := True;
    raise;
  end;
end;

procedure TfrmFolderProps.TntFormDestroy(Sender: TObject);
begin
  if Assigned(pcGeneral.ActivePage) then
    pcGeneral.ActivePage.Parent := pcGeneral;
  if Assigned(pcFile.ActivePage) then
    pcFile.ActivePage.Parent := pcFile;
end;

procedure TfrmFolderProps.SetTab(Control: TTntPageControl; Tab: TTntTabSheet;
  Where: TPanel);
begin
  { HACK! Display PageControl active page into a TPanel.
    Windows XP Themes are working correctly this way. }
  if Assigned(Tab) then begin
    Control.ActivePage := Tab;
    Tab.Parent := Where;
  end
  else
    Control.ActivePageIndex := -1;
end;

procedure TfrmFolderProps.ApplyEffectsClick(Sender: TObject);
begin
  btnEffects.Enabled := False;
  try
    case (Sender as TTntMenuItem).Tag of
      0: GrayBitmap(SelImage.Bitmap);
      1: ErodeImage(SelImage.Bitmap,3);
      2: DilateImage(SelImage.Bitmap,3);
      3: ApplyMosaic(SelImage.Bitmap,SelImage.Bitmap,4);
      4: ApplyHSLFactor(SelImage.Bitmap,SelImage.Bitmap,32,32,32,True,True,True);
      5: BitmapChannel(SelImage.Bitmap,1);
    end;
    btnSaveImage.Enabled := True;
    btnUndoChanges.Enabled := True;
  finally
    btnEffects.Enabled := True;
  end;
end;

procedure TfrmFolderProps.btnUndoChangesClick(Sender: TObject);
begin
  btnSaveImage.Enabled := False;
  btnUndoChanges.Enabled := False;
  { Load from local file, use uGlobal function }
  LoadBitmap32FromFile(Fullpath,SelImage.Bitmap);
end;

procedure TfrmFolderProps.btnEffectsClick(Sender: TObject);
var
  p: TPoint;
begin
  p := btnEffects.ClientToScreen(Point(btnEffects.Width,0));
  pmEffects.Popup(p.X,p.Y);
end;

procedure TfrmFolderProps.btnFiltersClick(Sender: TObject);
var
  p: TPoint;
begin
  p := btnFilters.ClientToScreen(Point(btnFilters.Width,0));
  pmFilters.Popup(p.X,p.Y);
end;

procedure TfrmFolderProps.ApplyFilterClick(Sender: TObject);
begin
  btnFilters.Enabled := False;
  try
    case (Sender as TTntMenuItem).Tag of
      0: ConvolveSmall32([1, 1, 1, 1, 4, 1, 1, 1, 1], 12, SelImage.Bitmap);
      1: ConvolveSmall32([0, 0, 0, 1, 1, 1, 0, 0, 0], 3, SelImage.Bitmap);
      2: ConvolveSmall32([2, 2, 2, 2, 0, 2, 2, 2, 2], 16, SelImage.Bitmap);
      3: ConvolveSmall32([0, -1, 0, -1, 12, -1, 0, -1, 0], 8, SelImage.Bitmap);
      4: ConvolveBig32([-6, 0, 0, 0, 0, 0, -7, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0,
         0, 7, 0, 0, 0, 0, 0, 6], 6, SelImage.Bitmap);
    end;
    SelImage.Bitmap.Changed;
    btnSaveImage.Enabled := True;
    btnUndoChanges.Enabled := True;
  finally
    btnFilters.Enabled := True;
  end;
end;

procedure TfrmFolderProps.LinkClick(Sender: TObject);
begin
  ShellExecute(Handle,'open',PChar(String(TTntLabel(Sender).Caption)),'','',SW_SHOWNORMAL); // do not localize
end;

procedure TfrmFolderProps.btnFindTargetClick(Sender: TObject);
begin
  { TODO: Preselect target file in explorer }
  ShellExecute(Handle,'open',PChar(ExtractFileDir(edLocalFile.Text)),'','',SW_SHOWNORMAL); // do not localize
end;

procedure TfrmFolderProps.Button3Click(Sender: TObject);
begin
  if (pcFile.ActivePage = tsFileImage) and btnSaveImage.Enabled and
    (MessageDlgW(_('Discard picture changes?'), mtConfirmation, MB_YESNO or MB_DEFBUTTON2) <> ID_YES) then
    exit;
  if FModified and
    (MessageDlgW(_('Discard current changes?'), mtConfirmation, MB_YESNO or MB_DEFBUTTON2) <> ID_YES) then
    exit;
  ModalResult := mrCancel;
end;

procedure TfrmFolderProps.ApplyButtonClick(Sender: TObject);
begin
  DoSaveChanges;
  ModalResult := mrOk;
end;

procedure TfrmFolderProps.btnSaveToPhoneClick(Sender: TObject);
begin
  btnSaveToPhone.Enabled := False;
  try
    { Delete file from phone }
    Form1.ObexPutFile(fFile.FullPath,True,True);
    { Upload local file to phone }
    Form1.ObexPutFile(Fullpath);
    FImageModified := False;
  except
    btnSaveToPhone.Enabled := True;
    raise;
  end;
end;

procedure TfrmFolderProps.btnGroupAddClick(Sender: TObject);
var
  s,w,cname,cnumb: WideString;
  ContactData: PContactData;
  SIMData: PSIMData;
  index,i: Integer;
  IsModified: boolean;
  dlg: TfrmStatusDlg;
  data: PFmaExplorerNode;
begin
  IsModified := False;
  with TfrmSelContact.Create(nil) do
    try
      index := 0;
      AllowGroups := False; // Do not allow nested Groups - it is still not implemented
      AllowSIMContacts := False; // IMPORTANT!!! Do not allow SIM Book contacts in Groups
      if ShowModal = mrOk then begin
        w := SelContacts;
        i := GetTokenCount(w,';');
        if MessageDlgW(WideFormat(_('Add %d %s to group "%s"?'),[i,ngettext('member','members',i),lblName1.Caption]),
          mtConfirmation, MB_YESNO or MB_DEFBUTTON1) = ID_YES then begin
          dlg := ShowStatusDlg(_('Adding to Group...'));
          try
            repeat
              s := GetFirstToken(w,';');
              if s <> '' then begin
                cname := Form1.ExtractContact(s);
                cnumb := Form1.ExtractNumber(s);
                if Form1.IsIrmcSyncEnabled then begin
                  if not Form1.frmSyncPhonebook.FindContact(cname,ContactData) then
                    continue;
                  index := GetContactPosition(ContactData,cnumb);
                end
                else begin
                  if not Form1.frmMEEdit.FindContact(cname,SIMData) then
                    continue;
                  index := SIMData^.position;
                end;
                if index < 1 then begin
                  Form1.Status(WideFormat(_('Locate position for %s...'),[cname]),False);
                  index := Form1.LocatePBIndex('ME',cname,cnumb); // do not localize
                end;
                if index > 0 then begin
                  { Remember found position, ie. make a cache here }
                  if Form1.IsIrmcSyncEnabled then
                    SetContactPosition(ContactData,cnumb,index);
                  { Already added? }
                  if Form1.FindExplorerPhoneNode(cnumb,FRootNode) <> nil then
                    continue;
                  { Add to group }
                  Form1.Status(WideFormat(_('Adding %s...'),[cname]),False);
                  data := Form1.ExplorerNew.GetNodeData(FRootNode);
                  Form1.TxAndWait('AT*ESAG='+IntToStr(data.StateIndex)+',2,'+IntToStr(index)); // do not localize
                  Form1.ExplorerAddToGroup(data.StateIndex,cname,cnumb);
                  i := 0;
                  while i < lvGroupMembers.Items.Count do begin
                    if WideCompareStr(lvGroupMembers.Items[i].Caption,cname) = 0 then
                      break;
                    inc(i);
                  end;
                  if i = lvGroupMembers.Items.Count then
                    with lvGroupMembers.Items.Add do begin
                      Caption := cname;
                      ImageIndex := 8;
                      StateIndex := i;
                      SubItems.Add('1');
                      MakeVisible(False);
                    end
                  else
                    with lvGroupMembers.Items[i] do SubItems[0] := IntToStr(StrToInt(SubItems[0])+1);
                  IsModified := True;
                end;
              end;
              if ThreadSafe.AbortDetected then break;
            until w = '';
          finally
            dlg.Free;
          end;
        end;
      end;
    finally
      Free;
      if IsModified then begin
        Form1.Status(_('Group updated'),False);
        Form1.ExplorerNewChange(Form1.ExplorerNew,Form1.ExplorerNew.GetFirstSelected);
      end;
    end;
end;

procedure TfrmFolderProps.lvGroupMembersSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  btnGroupDel.Enabled := Form1.FConnected and (lvGroupMembers.SelCount <> 0);
end;

procedure TfrmFolderProps.btnGroupDelClick(Sender: TObject);
var
  i,j: Integer;
  IsModified: boolean;
  data: PFmaExplorerNode;
begin
  if MessageDlgW(WideFormat(_('Remove %d %s from group "%s"?'),[lvGroupMembers.SelCount,
    ngettext('member','members',lvGroupMembers.SelCount),lblName1.Caption]),
    mtConfirmation,MB_YESNO or MB_DEFBUTTON2) = ID_YES then begin
    IsModified := False;
    try
      if btnGroupDel.Enabled then
        for i := lvGroupMembers.Items.Count-1 downto 0 do
          if lvGroupMembers.Items[i].Selected then begin
            Form1.Status(_('Removing from group...'),False);
            data := Form1.ExplorerNew.GetNodeData(FRootNode);
            Form1.TxAndWait('AT*ESDI='+IntToStr(data.StateIndex)+','+IntToStr(lvGroupMembers.Items[i].StateIndex)); // do not localize
            Form1.ExplorerDelFromGroup(data.StateIndex,lvGroupMembers.Items[i].Caption);
            { shift next nodes indexes }
            for j := i+1 to lvGroupMembers.Items.Count-1 do
              with lvGroupMembers.Items[j] do StateIndex := StateIndex-1;
            { delete from list }
            lvGroupMembers.Items[i].Delete;
            IsModified := True;
          end;
    finally
      if IsModified then begin
        Form1.Status(_('Group updated'),False);
        Form1.ExplorerNewChange(Form1.ExplorerNew,Form1.ExplorerNew.GetFirstSelected);
      end;
    end;
  end;
end;

procedure TfrmFolderProps.OnConnectionChange(Online: boolean);
begin
  btnGroupAdd.Enabled := Online;
  btnGroupDel.Enabled := Online and (lvGroupMembers.SelCount <> 0);
  btnDownload.Enabled := Online and (fFile.FileType <> ftDir);
  btnSaveToPhone.Enabled := Online and FImageModified;
end;

procedure TfrmFolderProps.btnFindDBClick(Sender: TObject);
begin
  ShellExecute(Handle,'open',PChar(Fullpath),'','',SW_SHOWNORMAL);
end;

procedure TfrmFolderProps.btnRulesClick(Sender: TObject);
begin
  Form1.EditSMSDeliveryRules(FRootNode);
end;

procedure TfrmFolderProps.FieldChange(Sender: TObject);
begin
  FModified := True;
end;

procedure TfrmFolderProps.DoSaveChanges;
var
  i: Integer;
  s,w: string;
  DelRecurrent: boolean;
  data: PFmaExplorerNode;
begin
  DelRecurrent := False;
  if (pcGeneral.ActivePage = tsAlarm) and FModified then begin
    w := '';
    for i := 1 to 7 do
      with (FindComponent('cbAlarmDay'+IntToStr(i)) as TTntCheckBox) do // do not localize
        if Checked then begin
          if w <> '' then w := w + ',';
          w := w + IntToStr(i);
        end;
    if WideCompareStr(w,'1,2,3,4,5,6,7') = 0 then w := '0';
    { Are we creating a new alarm? }
    if FAlarmIndex = -1 then begin
      if w = '' then
        FAlarmIndex := 1  // HACK! create non-recurrent alarm index (T610)
      else
        FAlarmIndex := 2; // HACK! create recurrent alarm index (T610)
    end;
    { Do we have recurrent to non-recurrent transformation? }
    if (FAlarmIndex = 2) and (w = '') then begin
      FAlarmIndex := 1;
      DelRecurrent := True;
    end;
    s := Format('AT+CALA="%s",%d', [FormatDateTime('HH":"mm',dtAlarmTime.Time),FAlarmIndex]);
    if w <> '' then s := Format('%s,,,"%s"', [s,w]);
    Form1.Status(_('Setting Alarm...'));
    try
      { Do we have recurrent to non-recurrent transformation (see the check above)? if yes,
        then delete recurrent one here, and non-recurrent one will be created bellow }
      if DelRecurrent then Form1.TxAndWait('AT+CALD=2'); // do not localize
      { Update/create alarm in phone }
      Form1.TxAndWait(s);
      Form1.InitAlarms;
    except
      Form1.Status(_('Error setting alarm'));
      MessageDlgW(_('The alarm could not be set.'),mtError,MB_OK);
      Abort;
    end;
  end;
  if (pcFile.ActivePage = tsFileImage) and btnSaveImage.Enabled then
    btnSaveImage.Click;
  if (pcGeneral.ActivePage = tsPhone) and FModified then begin
    data := Form1.ExplorerNew.GetNodeData(FRootNode);
    if Trim(TntEdit1.Text) = '' then
      w := _('You have to enter phone name.')
    else
    if Form1.PhoneExists(TntEdit1.Text) and (WideCompareStr(TntEdit1.Text,data.Text) <> 0) then
      w := _('This phone name already exists.')
    else
      w := '';
    if w <> '' then begin
      MessageDlgW(w,mtError,MB_OK);
      Abort;
    end;
  end;
end;

end.
