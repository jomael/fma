unit uNewDeviceWizard;

{
*******************************************************************************
* Descriptions: Getting Started... for FMA
* $Source: /cvsroot/fma/fma/uNewDeviceWizard.pas,v $
* $Locker:  $
*
* TODO:
*
* Change Log:
* $Log: uNewDeviceWizard.pas,v $
* Revision 1.5.2.11  2006/03/16 18:39:55  z_stoichev
* Added New profiles database unique ID by phone name.
*
* Revision 1.5.2.10  2006/03/16 12:26:27  z_stoichev
* - Fixed Set friendly name once in Getting Started wizard.
* - Added Set default K750 clones settings for new phones.
* - Added Check OBEX compatability on Getting Started finish.
*
* Revision 1.5.2.9  2006/03/15 10:04:30  z_stoichev
* Fixed Getting Started dialog widgets overlapping.
*
* Revision 1.5.2.8  2006/03/14 14:09:38  z_stoichev
* Initial Getting Started is optional.
*
* Revision 1.5.2.7  2006/02/06 13:51:55  z_stoichev
* Fixed Handle exceptions on Speed calibration.
*
* Revision 1.5.2.6  2005/09/13 14:50:04  z_stoichev
* Added USB device arrival or removed detection.
*
* Revision 1.5.2.5  2005/09/12 18:53:43  expertone
* no message
*
* Revision 1.5.2.4  2005/08/23 20:59:37  z_stoichev
* - Fixed Getting Started Wizard GUI typos.
*
* Revision 1.5.2.3  2005/04/13 20:01:18  lordlarry
* Fixed: Widcomm issue
*
* Revision 1.5.2.2  2005/04/11 22:36:23  z_stoichev
* Fixed GSM coding scheme.
*
* Revision 1.5.2.1  2005/04/11 22:11:27  z_stoichev
* Fixed GSM coding scheme. Fixed typos.
*
* Revision 1.5  2005/03/05 14:23:57  lordlarry
* Changed the Name Locally used Comm Components to prevent confiusion and solve a 'with' bug
*
* Revision 1.4  2005/02/24 21:29:14  lordlarry
* Added a better (but ugly) method to make the TWaitThread code threadsafe. All data that is accessed outside of the class goes through the ThreadSafe object which does the locking.
*
* Revision 1.3  2005/02/17 11:58:57  z_stoichev
* Getting Started Wizard Improvements
*
* Revision 1.2  2005/02/15 11:16:18  z_stoichev
* Wizard finished
*
* Revision 1.1  2005/02/14 16:31:38  z_stoichev
* Initial checkin.
*
*
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, StdCtrls, TntStdCtrls, CheckLst, TntCheckLst, ExtCtrls, TntExtCtrls,
  jpeg, ComCtrls, TntComCtrls, WIrCOMMSocket, WSocket, WBluetoothSocket,
  CPort, ImgList, CPortCtl, Menus, TntMenus, USBMonitor;

const
  WM_NEXTWPAGE = WM_USER + 101;
  WM_PREVWPAGE = WM_USER + 102;
  WM_HANDLEMESSAGE = WM_USER + 103;

  ndcBluetooth   = 0;
  ndcInfrared    = 1;
  ndcSerial      = 2;

type
  TSearchHandleMessage = record
    Msg: Cardinal;
    Message: PChar;
    Length: Longint;
    Result: Longint;
  end;

  TSelectedDeviceInfo = record
    ConnectionType: byte; // 0 - bluetooth, 1 - infrared, 2 - serial
    DeviceName,FriendlyName: WideString;
    MaxSpeed: TBaudRate; // Serial only
    Address: string; // Bluetooth address, or COM port name
    DisableObex,DisableIrmcSync,DisableSyncML: boolean;
  end;

  TfrmNewDeviceWizard = class(TTntForm)
    NextButton: TTntButton;
    CancelButton: TTntButton;
    Bevel1: TTntBevel;
    PreviousButton: TTntButton;
    nbWizard: TNotebook;
    FinishedPanel: TTntPanel;
    imgWizard: TTntImage;
    lbDescription: TTntLabel;
    lbProductName: TTntLabel;
    WelcomePanel: TTntPanel;
    imgFinished: TTntImage;
    lblFinished: TTntLabel;
    Label3: TTntLabel;
    lblWelcomeNext: TTntLabel;
    TopPanel1: TTntPanel;
    TopDetailsLabel5: TTntLabel;
    TopBevel5: TTntBevel;
    TopCaptionLabel5: TTntLabel;
    imgWizardSmall1: TTntImage;
    TntImage1: TTntImage;
    TntLabel1: TTntLabel;
    TntLabel2: TTntLabel;
    TntImage2: TTntImage;
    TntLabel3: TTntLabel;
    TntImage3: TTntImage;
    TntLabel4: TTntLabel;
    TopPanel3: TTntPanel;
    TntLabel5: TTntLabel;
    TntBevel1: TTntBevel;
    TntLabel6: TTntLabel;
    imgWizardSmall3: TTntImage;
    TopPanel2: TTntPanel;
    TntLabel7: TTntLabel;
    TntBevel2: TTntBevel;
    TntLabel8: TTntLabel;
    imgWizardSmall2: TTntImage;
    lvDevices: TTntListView;
    lblSearchInfo: TTntLabel;
    TntLabel10: TTntLabel;
    TntLabel11: TTntLabel;
    edFriendlyName: TTntEdit;
    Animate1: TAnimate;
    LocalComPort: TComPort;
    LocalWBtSocket: TWBluetoothSocket;
    LocalWIrSocket: TWIrCOMMSocket;
    ImageList1: TImageList;
    cbCOM: TComComboBox;
    TntPopupMenu1: TTntPopupMenu;
    Refresh1: TTntMenuItem;
    TntLabel9: TTntLabel;
    ImageList2: TImageList;
    View1: TTntMenuItem;
    N1: TTntMenuItem;
    AsIcons1: TTntMenuItem;
    AsList1: TTntMenuItem;
    TntLabel12: TTntLabel;
    cbCalibrate: TTntCheckBox;
    cbDeviceReady: TTntCheckBox;
    Image1: TImage;
    TntLabel13: TTntLabel;
    RefreshButton: TTntButton;
    mmoSummary: TTntMemo;
    DeviceMonitorUSB1: TDeviceMonitorUSB;
    Timer1: TTimer;
    cbDontShow: TTntCheckBox;
    cbCheckObex: TTntCheckBox;
    NoItemsPanel: TTntPanel;
    TntLabel14: TTntLabel;
    cbSearchBT: TTntCheckBox;
    cbSearchIR: TTntCheckBox;
    cbSearchCOM: TTntCheckBox;
    cbSearchAll: TTntCheckBox;
    procedure NextButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PreviousButtonClick(Sender: TObject);
    procedure nbWizardPageChanged(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure TntFormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure LocalComPortRxChar(Sender: TObject; Count: Integer);
    procedure OnSocketDataAvailable(Sender: TObject; Error: Word);
    procedure TntPopupMenu1Popup(Sender: TObject);
    procedure Refresh1Click(Sender: TObject);
    procedure AsIcons1Click(Sender: TObject);
    procedure AsList1Click(Sender: TObject);
    procedure TntFormDestroy(Sender: TObject);
    procedure cbDeviceReadyClick(Sender: TObject);
    procedure lvDevicesSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure OnUSBDeviceChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure cbDontShowClick(Sender: TObject);
    procedure lvDevicesInsert(Sender: TObject; Item: TListItem);
    procedure cbSearchAllClick(Sender: TObject);
  private
    { Private declarations }
    FConnectionType: byte;
    FCanceled,FExiting,FReceived: boolean;
    FRxBuffer: TStringList;
    FMessageBuf: string;
    FSelected: TSelectedDeviceInfo;
    procedure WizardPageNext(var Msg: TMessage); message WM_NEXTWPAGE;
    procedure WizardPagePrevious(var Msg: TMessage); message WM_PREVWPAGE;
    procedure DoSearch(Reason: WideString = '');
    procedure DoCalibrateConnection;
    procedure DoCheckObex;
    procedure TxAndWait(Data: string);
    procedure AddDevice(Text: WideString; Address: string = '';
      FriendlyName: WideString = ''; Manufacturer: WideString = '');
    function Get_DontShowVis: boolean;
    procedure Set_DontShowVis(const Value: boolean);
    function Get_DontShow: boolean;
  protected
    procedure HandleMessage(var Msg: TSearchHandleMessage); message WM_HANDLEMESSAGE;
  public
    { Public declarations }
    constructor CreateImg(AOwner: TComponent; AImage,AImageSmall: TPicture; AStatus: string = '');
  published
    property IsCanceled: boolean read FCanceled;
    property IsDontShow: boolean read Get_DontShow;
    property IsDontShowVisible: boolean read Get_DontShowVis write Set_DontShowVis;
    property SelectedDevice: TSelectedDeviceInfo read FSelected write FSelected;
  end;

var
  frmNewDeviceWizard: TfrmNewDeviceWizard;

implementation

{$R *.dfm}

uses
  gnugettext, WinSock, TntClasses, Unit1, uGlobal,
  uolSelectPatchPath, uDialogs, uStatusDlg, uThreadSafe, uSMS;

const
  { Wizard pages indexes }
  piWelcome       = 0;
  piPrepare       = 1;
  piSearch        = 2;
  piName          = 3;
  piFinished      = 4;

constructor TfrmNewDeviceWizard.CreateImg(AOwner: TComponent; AImage,AImageSmall: TPicture; AStatus: string);
begin
  Create(AOwner);
  if Assigned(AImage) and Assigned(AImage.Graphic) and not AImage.Graphic.Empty then
    imgWizard.Picture.Assign(AImage);
  if Assigned(AImageSmall) and Assigned(AImageSmall.Graphic) and not AImageSmall.Graphic.Empty then
    imgWizardSmall1.Picture.Assign(AImageSmall);
  { Populate dublicate images }
  if not imgWizard.Picture.Graphic.Empty then imgFinished.Picture.Assign(imgWizard.Picture);
  if not imgWizardSmall1.Picture.Graphic.Empty then begin
    imgWizardSmall2.Picture.Assign(imgWizardSmall1.Picture);
    imgWizardSmall3.Picture.Assign(imgWizardSmall1.Picture);
  end;
  nbWizard.PageIndex := piWelcome;
  if AStatus <> '' then
    lbDescription.Caption := lbDescription.Caption + sLineBreak+sLineBreak + AStatus;
end;

procedure TfrmNewDeviceWizard.FormCreate(Sender: TObject);
begin
  TranslateComponent(Self);
  FRxBuffer := TStringList.Create;
  FCanceled := False;
{$IFDEF VER150}
  WelcomePanel.ParentBackground := False;
  TopPanel1.ParentBackground := False;
  TopPanel2.ParentBackground := False;
  TopPanel3.ParentBackground := False;
  FinishedPanel.ParentBackground := False;
  NoItemsPanel.ParentBackground := False;
{$ENDIF}
end;

procedure TfrmNewDeviceWizard.WizardPageNext(var Msg: TMessage);
begin
  if nbWizard.PageIndex < nbWizard.Pages.Count-1 then
    nbWizard.PageIndex := nbWizard.PageIndex + 1;
end;

procedure TfrmNewDeviceWizard.WizardPagePrevious(var Msg: TMessage);
begin
  if nbWizard.PageIndex > 0 then
    nbWizard.PageIndex := nbWizard.PageIndex - 1;
end;

procedure TfrmNewDeviceWizard.NextButtonClick(Sender: TObject);
begin
  case nbWizard.PageIndex of
    piName: begin
      if Trim(edFriendlyName.Text) = '' then
        MessageDlgW(_('You have to enter phone name.'),mtError,MB_OK)
      else
      if Form1.PhoneExists(edFriendlyName.Text) then
        MessageDlgW(_('This phone name already exists.'),mtError,MB_OK)
      else
        SendMessage(Handle,WM_NEXTWPAGE,0,0);
    end;
    piFinished: begin { finished }
      { Get selected COM port }
      LocalComPort.Port := lvDevices.Selected.SubItems[0];
      if cbCalibrate.Checked then DoCalibrateConnection;
      if cbCheckObex.Checked then DoCheckObex;
      Update;
      { Fill selected device data }
      FSelected.ConnectionType := Integer(lvDevices.Selected.Data);
      FSelected.DeviceName := lvDevices.Selected.Caption;
      FSelected.FriendlyName := edFriendlyName.Text;
      FSelected.MaxSpeed := LocalComPort.BaudRate;
      FSelected.Address := lvDevices.Selected.SubItems[0];
      { Exit Wizard }
      FExiting := True;
      ModalResult := mrOk;
    end
    else
      SendMessage(Handle,WM_NEXTWPAGE,0,0);
  end;
end;

procedure TfrmNewDeviceWizard.PreviousButtonClick(Sender: TObject);
begin
  case nbWizard.PageIndex of
    piWelcome: { welcome }
      { do nothing } ;
    else
      SendMessage(Handle,WM_PREVWPAGE,0,0);
  end;
end;

procedure TfrmNewDeviceWizard.nbWizardPageChanged(Sender: TObject);
const
  sTab = '    ';
var
  s: WideString;
begin
  case nbWizard.PageIndex of
    piWelcome: begin { welcome }
      PreviousButton.Enabled := False;
      NextButton.Caption := _('&Next >');
      NextButton.Enabled := True;
      NextButton.Default := False;
      cbDontShowClick(nil); // update Cancel button
    end;
    piPrepare: begin { install }
      PreviousButton.Enabled := True;
      NextButton.Caption := _('&Search');
      CancelButton.Caption := _('&Cancel');
      cbDeviceReadyClick(cbDeviceReady);
    end;
    piSearch: begin
      if NextButton.Enabled then NextButton.SetFocus;
      NextButton.Caption := _('&Next >');
      lvDevicesSelectItem(lvDevices,nil,False);
      if lvDevices.Items.Count = 0 then DoSearch;
    end;
    piName: begin
      NextButton.Caption := _('&Next >');
      NextButton.Default := False;
      //CancelButton.Enabled := True;
      s := lvDevices.Selected.SubItems[1];
      if s = '' then s := WideFormat(_('My %s phone'),[lvDevices.Selected.Caption]);
      if edFriendlyName.Text = '' then edFriendlyName.Text := s;
    end;
    piFinished: begin { finished }
      NextButton.Caption := _('&Finish');
      //CancelButton.Enabled := False;
      { setup tasks on finish }
      cbCalibrate.Checked := False;
      cbCalibrate.Visible := Integer(lvDevices.Selected.Data) = ndcSerial; // only for serial
      cbCheckObex.Checked := False;
      cbCheckObex.Visible := cbCalibrate.Visible;

      FSelected.DisableObex := False;
      FSelected.DisableIrmcSync := False;
      FSelected.DisableSyncML := True;
      with mmoSummary.Lines do begin
        Clear;
        Add(_('Phone Device:'));
        if lvDevices.Selected.SubItems[1] <> '' then
          Add(sTab + _(lvDevices.Selected.SubItems[1]));
        Add(sTab + _(lvDevices.Selected.SubItems[2]));
        Add(sTab + _(lvDevices.Selected.Caption));
        if (edFriendlyName.Text <> '') and (WideCompareStr(edFriendlyName.Text,lvDevices.Selected.SubItems[1]) <> 0) then
          Add(sTab + _(edFriendlyName.Text));
        Add('');
        Add(_('Connection Type:'));
        case Integer(lvDevices.Selected.Data) of
          ndcBluetooth:  s := 'Bluetooth';
          ndcInfrared:   s := 'Infrared';
          ndcSerial:     s := 'Data Cable or Virtual Bluetooth Port';
        end;
        Add(sTab + _(s));
        Add(sTab + _(lvDevices.Selected.SubItems[0]));
        Add('');
        Add(_('Summary:'));
        if WideCompareText('SONY ERICSSON',lvDevices.Selected.SubItems[2]) <> 0 then begin
          Add(sTab + _('Only Sony Ericsson phones are officialy supported.'));
          Add(sTab + _('Not all of the features might work as expected.'));
        end
        else
        if Integer(lvDevices.Selected.Data) = ndcInfrared then begin
          { Infrared, so no OBEX }
          Add(sTab + _('File Browseing is not supported over Infrared.'));
          Add(sTab + _('Phonebook Sync is not supported (requires above).'));
          Add(sTab + _('Switch to Bluetooth or Data Cable in order to use them.'));
          FSelected.DisableObex := True;
          FSelected.DisableIrmcSync := True;
        end
        else
        if not Form1.IsT610Clone(lvDevices.Selected.Caption) and not Form1.IsK700Clone(lvDevices.Selected.Caption) and
          not Form1.IsK750Clone(lvDevices.Selected.Caption) then begin
          { Older phones (T230, T68, ...) so no OBEX }
          Add(sTab + _('Phonebook Sync is not supported by your phone.'));
          FSelected.DisableIrmcSync := True;
        end
        else
          if Form1.IsK750Clone(lvDevices.Selected.Caption) then
            Add(sTab + _('Your phone device is detected and supported partially.'))
          else
            Add(sTab + _('Your phone device is detected and supported.')); // T610, K700 are OK
      end;
      cbCheckObex.Enabled := cbCheckObex.Visible and not FSelected.DisableObex;
      cbCheckObex.Checked := cbCheckObex.Enabled;
    end;
  end;
  if Visible and NextButton.Visible and NextButton.Enabled then NextButton.SetFocus;
end;

procedure TfrmNewDeviceWizard.CancelButtonClick(Sender: TObject);
begin
  if (nbWizard.PageIndex = piSearch) and Animate1.Active then
    { Just cancel the search process }
    FCanceled := True
  else begin
    MessageBeep(MB_ICONQUESTION);
    if ((nbWizard.PageIndex = piWelcome) and cbDontShow.Checked) or
      (MessageDlgW(_('The Wizard is not complete. Do you really want to exit?'+
      sLinebreak+sLinebreak+'You can run this wizard at a later time to complete it.'+
      sLinebreak+sLinebreak+'To exit Wizard right now click Yes. To continue click No.'),
      mtConfirmation, MB_YESNO) = ID_YES) then begin
      FExiting := True;
      ModalResult := mrCancel;
    end;
  end;
end;

procedure TfrmNewDeviceWizard.TntFormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if CancelButton.Enabled and not FExiting then begin
    CancelButton.Click;
    if not FExiting then begin
      ModalResult := mrNone;
      CanClose := False;
    end;
  end;
  FCanceled := ModalResult = mrCancel;
end;

procedure TfrmNewDeviceWizard.DoSearch(Reason: WideString);
var
  i: integer;
  ComDevice,ComManufacturer: WideString;
  BtDevices: TBtDevicesInfo;
  IrDevices: TIrdaDevicesInfo;
  DevAddr,DevName: string;
  procedure ProbeDevice;
  begin
    ComDevice := '';
    ComManufacturer := '';
    try
      TxAndWait('ATE0'); // do not localize
      if FReceived then begin
        TxAndWait('ATI'); // do not localize
        if FReceived then begin
          ComDevice := FRxBuffer[0];
          try
            { Check if we have GSM device }
            TxAndWait('AT+CGMM'); // do not localize
            if FReceived then ComDevice := WideFormat('%s (%s)',[ComDevice,FRxBuffer[0]]);
            TxAndWait('AT+CGMI'); // do not localize
            if FReceived then ComManufacturer := FRxBuffer[0];
          except
          end;
          AddDevice(ComDevice,DevAddr,DevName,ComManufacturer);
        end;
      end;
    except
    end;
  end;
begin
  if Reason <> '' then Reason := WideFormat(' (%s)',[Reason]);
  Animate1.Visible := True;
  Animate1.Active := True;
  Animate1.Color := clWindow;
  PreviousButton.Visible := False;
  NextButton.Visible := False;
  RefreshButton.Enabled := False;
  IrDevices := nil;
  BtDevices := nil;
  try
    lvDevices.Items.Clear;
    lvDevices.SetFocus;
    NoItemsPanel.Visible := True;
    FCanceled := False;

    lblSearchInfo.Caption := _('Preparing Search...');
    Application.ProcessMessages;
    if FCanceled then exit;

    // bluetooth
    if cbSearchBT.Checked then begin
      try
        BtDevices := LocalWBtSocket.GetConnectedDevices;
      except
        AddDevice(_('Native Bluetooth is not supported!'));
      end;
      lblSearchInfo.Caption := _('Searching Bluetooth...') + Reason;
      Application.ProcessMessages;
      if FCanceled then exit;
      try
        FConnectionType := 0;
        if Assigned(BtDevices) then
          for i := 0 to BtDevices.Count-1 do begin
            if FCanceled or Application.Terminated then break;
            DevName := BtDevices[i].btDeviceName;
            DevAddr := IntToHex(BtDevices[i].btDeviceAddr,12);
            LocalWBtSocket.Addr := DevAddr;
            LocalWBtSocket.Port := '0';
            LocalWBtSocket.Connect;
            try
              while LocalWBtSocket.State = wsConnecting do WaitASec(50,True);
              ProbeDevice;
            finally
              if LocalWBtSocket.State = wsConnected then LocalWBtSocket.Close;
            end;
          end;
      except
      end;
    end;

    // infrared
    if cbSearchIR.Checked then begin
      try
        IrDevices := LocalWIrSocket.GetConnectedDevices;
      except
        AddDevice(_('Native Infrared is not supported!'));
      end;
      lblSearchInfo.Caption := _('Searching Infrared...') + Reason;
      Application.ProcessMessages;
      if FCanceled then exit;
      try
        FConnectionType := 1;
        if Assigned(IrDevices) then
          for i := 0 to IrDevices.Count-1 do begin
            if FCanceled or Application.Terminated then break;
            DevName := IrDevices.Items[i].irdaDeviceName;
            DevAddr := IntToHex(DWORD(IrDevices.Items[i].irdaDeviceID[1]),8);
            LocalWIrSocket.DeviceID := IrDevices.Items[i].irdaDeviceID;
            LocalWIrSocket.Connect;
            try
              while LocalWIrSocket.State = wsConnecting do WaitASec(50,True);
              ProbeDevice;
            finally
              if LocalWIrSocket.State = wsConnected then LocalWIrSocket.Close;
            end;
          end;
      except
      end;
    end;

    // serial cable
    if cbSearchCOM.Checked then begin
      lblSearchInfo.Caption := _('Searching Ports...') + Reason;
      Application.ProcessMessages;
      if FCanceled then exit;
      FConnectionType := 2;
      DevName := '';
      for i := 0 to cbCOM.Items.Count-1 do
      try
        if FCanceled or Application.Terminated then break;
        cbCOM.ItemIndex := i;
        LocalComPort.Port := cbCOM.Text;
        LocalComPort.BaudRate := br9600;
        LocalComPort.FlowControl.ControlRTS := rtsHandshake;
        LocalComPort.FlowControl.ControlDTR := dtrHandshake;
        LocalComPort.Open;

        // Give the chance to run the com thread.
        // The main event loop in TComThread.Execute have to be started (see the CPort.pas)
        WaitASec(200, True);

        try
          DevAddr := cbCOM.Text;
          ProbeDevice;
        finally
          LocalComPort.Close;
        end;
      except
      end;
    end;
  finally
    if Assigned(IrDevices) then IrDevices.Free;
    if Assigned(BtDevices) then BtDevices.Free;
    lblSearchInfo.Caption := _('Select prefered phone device and click Next to continue.');
    NoItemsPanel.Visible := lvDevices.Items.Count = 0;
    Animate1.Active := False;
    Animate1.Visible := False;
    PreviousButton.Visible := True;
    NextButton.Visible := True;
    RefreshButton.Enabled := True;
  end;
end;

procedure TfrmNewDeviceWizard.LocalComPortRxChar(Sender: TObject;
  Count: Integer);
var
  c: char;
  i: Integer;
  buffer: String;
  PStr: PChar;
begin
  if FConnectionType = 0 then begin
    SetLength(buffer, 2048);
    SetLength(buffer, LocalWBtSocket.Receive(@buffer[1], 2048));
  end
  else if FConnectionType = 1 then begin
    SetLength(buffer, 2048);
    SetLength(buffer, LocalWIrSocket.Receive(@buffer[1], 2048));
  end
  else begin
    SetLength(buffer, Count);
    LocalComPort.ReadStr(buffer, Count);
  end;

  if ThreadSafe.DoCharConvertion then
    buffer := GSMDecode7Bit(buffer);

  { process received data }
  for i := 1 to length(buffer) do begin
    c := buffer[i];
    //if ThreadSafe.DoCharConvertion then c := ConvertCharSet(c);
    case c of
      #00:;
      #10:;
      #13:
        begin
          if length(trim(FMessageBuf)) > 0 then
          begin
            PStr := StrNew(PChar(FMessageBuf));
            PostMessage(Handle, WM_HANDLEMESSAGE, Integer(PStr), 0);
          end;
          FMessageBuf := '';
        end;
      else begin
        FMessageBuf := FMessageBuf + c;
      end;
    end;
    if (FMessageBuf = 'OK') and (FMessageBuf <> '') then begin
      PStr := StrNew(PChar(FMessageBuf));
      PostMessage(Handle, WM_HANDLEMESSAGE, Integer(PStr), 0);
      FMessageBuf := '';
    end;
  end;
end;

procedure TfrmNewDeviceWizard.HandleMessage(var Msg: TSearchHandleMessage);
var
  s: string;
begin
  s := Msg.Message;
  StrDispose(Msg.Message);
  FReceived := (CompareText('OK',s) = 0) or (CompareText('ERROR',s) = 0);
  FRxBuffer.Add(s);
  inherited;
end;

procedure TfrmNewDeviceWizard.TxAndWait(Data: string);
var
  FMSec: cardinal;
begin
  FReceived := False;
  FMessageBuf := '';
  FRxBuffer.Clear;

  if ThreadSafe.DoCharConvertion then
    Data := GSMEncode7Bit(Data);

  { Send command }
  if FConnectionType = 0 then LocalWBtSocket.SendStr(Data + #13) // Blutooth
  else if FConnectionType = 1 then LocalWIrSocket.SendStr(Data + #13) // Infrared
       else LocalComPort.WriteStr(Data + #13); // Serial

  { Set timeout, max 5 seconds }
  FMSec := ThreadSafe.InactivityTimeout;
  if FMSec > 5000 then FMSec := 5000;
  FMSec := GetTickCount + FMSec;

  { Wait for response }
  while not FCanceled and not FReceived and not Application.Terminated do begin
    WaitASec(10,True);
    if GetTickCount > FMSec then
      raise EInOutError.Create('Timeout'); // do not localize
  end;
  if FReceived and (CompareText('ERROR',FRxBuffer[0]) = 0) then
    raise EInOutError.Create('AT Error'); // do not localize
end;

procedure TfrmNewDeviceWizard.OnSocketDataAvailable(Sender: TObject;
  Error: Word);
begin
  if Error = 0 then LocalComPortRxChar(nil, 0);
end;

procedure TfrmNewDeviceWizard.TntPopupMenu1Popup(Sender: TObject);
begin
  Refresh1.Enabled := not Animate1.Active;
end;

procedure TfrmNewDeviceWizard.Refresh1Click(Sender: TObject);
begin
  DoSearch;
end;

procedure TfrmNewDeviceWizard.AsIcons1Click(Sender: TObject);
begin
  lvDevices.ViewStyle := vsIcon;
end;

procedure TfrmNewDeviceWizard.AsList1Click(Sender: TObject);
begin
  lvDevices.ViewStyle := vsReport;
end;

procedure TfrmNewDeviceWizard.TntFormDestroy(Sender: TObject);
begin
  FRxBuffer.Free;
end;

procedure TfrmNewDeviceWizard.AddDevice(Text: WideString; Address: string;
  FriendlyName, Manufacturer: WideString);
begin
  { for modems: ImageIndex := 3 }
  if (Text <> '') and (WidePos('MODEM',WideUpperCase(Text)) = 0) then
    with lvDevices.Items.Add do begin
      Caption := Text;        // Device name
      SubItems.Add(Address);  // Peer Bluetooth address or COM port name
      SubItems.Add(FriendlyName);
      SubItems.Add(Manufacturer);
      if Address <> '' then begin
        case FConnectionType of
          0: ImageIndex := 0;
          1: ImageIndex := 1;
          2: ImageIndex := 2;
        end;
        StateIndex := 5;      // Phone found!
      end
      else 
        ImageIndex := 4;      // No address, so it is a warning message
      Data := Pointer(FConnectionType); // Connection type
    end;
end;

procedure TfrmNewDeviceWizard.DoCalibrateConnection;
var
  i: integer;
  dlg: TfrmStatusDlg;
begin
  if Integer(lvDevices.Selected.Data) = ndcSerial then // serial?
    try
      dlg := ShowStatusDlg(_('Calibrating Port Speed...'),poMainFormCenter);
      try
        if Form1.IsK750Clone(FSelected.DeviceName) then begin
          { K750 working settings: Port:'COM X', Baud:256000, RTS:Handshake, DTR:Enabled }
          LocalComPort.BaudRate := br256000;
          LocalComPort.FlowControl.ControlRTS := rtsHandshake;
          LocalComPort.FlowControl.ControlDTR := dtrEnable;
        end;
        { Get already tested speed }
        i := Ord(LocalComPort.BaudRate);
        while i < Ord(High(TBaudRate)) do begin
          { try next higher speed }
          inc(i);
          LocalComPort.BaudRate := TBaudRate(i);
          LocalComPort.Open;

          // Give the chance to run the com thread.
          // The main event loop in TComThread.Execute have to be started (see the CPort.pas)
          WaitASec(200, True);

          try
            try
              { Check if we can transmit/receive on that speed }
              TxAndWait('ATE0'); // do not localize
              if not FReceived then Abort; // just in case
            except
              { Revert to previous speed and exit }
              LocalComPort.BaudRate := TBaudRate(i-1);
              break;
            end;
          finally
            LocalComPort.Close;
          end;
        end;
      finally
        dlg.Free;
      end;
    except
      // be silent
    end;
end;

procedure TfrmNewDeviceWizard.cbDeviceReadyClick(Sender: TObject);
begin
  NextButton.Enabled := cbDeviceReady.Checked and
    (cbSearchBT.Checked or cbSearchIR.Checked or cbSearchCOM.Checked);
  NextButton.Default := NextButton.Enabled;
  if cbDeviceReady.Checked then begin
    cbSearchBT.Enabled := True;
    cbSearchIR.Enabled := True;
    cbSearchCOM.Enabled := True;
    cbSearchAll.Enabled := True;
  end;
end;

procedure TfrmNewDeviceWizard.lvDevicesSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  { Allow selection of devices which have Manufacturer field set, i.e. support AT+CGMI }
  NextButton.Enabled := Assigned(lvDevices.Selected) and (lvDevices.Selected.StateIndex = 5);
  NextButton.Default := NextButton.Enabled;
end;

procedure TfrmNewDeviceWizard.OnUSBDeviceChange(Sender: TObject);
begin
  if nbWizard.PageIndex = piSearch then begin
    Timer1.Enabled := False;
    Timer1.Enabled := True;
  end;
end;

procedure TfrmNewDeviceWizard.Timer1Timer(Sender: TObject);
begin
  if nbWizard.PageIndex = piSearch then begin
    if RefreshButton.Enabled then begin
      Timer1.Enabled := False;
      DoSearch(_('USB device arrival or removed'));
    end
    else
      { Restart searching due to device change }
      FCanceled := True;
  end
  else
    Timer1.Enabled := False;
end;

function TfrmNewDeviceWizard.Get_DontShowVis: boolean;
begin
  Result := cbDontShow.Visible;
end;

procedure TfrmNewDeviceWizard.Set_DontShowVis(const Value: boolean);
begin
  cbDontShow.Visible := Value;
  lblWelcomeNext.Visible := not Value;
end;

function TfrmNewDeviceWizard.Get_DontShow: boolean;
begin
  Result := IsDontShowVisible and cbDontShow.Checked;
end;

procedure TfrmNewDeviceWizard.cbDontShowClick(Sender: TObject);
begin
  if cbDontShow.Checked then
    CancelButton.Caption := _('&Close')
  else
    CancelButton.Caption := _('&Cancel');
end;

procedure TfrmNewDeviceWizard.DoCheckObex;
var
  dlg: TfrmStatusDlg;
begin
  if Integer(lvDevices.Selected.Data) = ndcSerial then // serial?
    try
      dlg := ShowStatusDlg(_('Checking OBEX support...'),poMainFormCenter);
      try
        LocalComPort.Open;

        // Give the chance to run the com thread.
        // The main event loop in TComThread.Execute have to be started (see the CPort.pas)
        WaitASec(200, True);

        try
          TxAndWait('ATE0'); // do not localize
          if not FReceived then Abort; // just in case
          
          try
            TxAndWait('AT*EOBEX=?'); // do not localize
            if not FReceived then begin
              FSelected.DisableObex := True;
              FSelected.DisableIrmcSync := True;
            end;
          except
          end;
          if FSelected.DisableObex then
            try
              TxAndWait('AT+CPROT=?'); // do not localize
              FSelected.DisableObex := not FReceived;
              FSelected.DisableIrmcSync := not FReceived;
            except
            end;
        finally
          LocalComPort.Close;
        end;
      finally
        dlg.Free;
      end;
    except
      // be silent
    end;
end;

procedure TfrmNewDeviceWizard.lvDevicesInsert(Sender: TObject;
  Item: TListItem);
begin
  NoItemsPanel.Visible := False;
end;

procedure TfrmNewDeviceWizard.cbSearchAllClick(Sender: TObject);
begin
  cbSearchBT.Checked := cbSearchAll.Checked;
  cbSearchIR.Checked := cbSearchAll.Checked;
  cbSearchCOM.Checked := cbSearchAll.Checked;
  cbDeviceReadyClick(nil);
end;

end.

