unit uObex;

{
*******************************************************************************
* Descriptions: OBEX Implementation
* $Source: /cvsroot/fma/fma/uObex.pas,v $
* $Locker:  $
*
* Todo:
*    - see code comments "todo:"
*
* Change Log:
* $Log: uObex.pas,v $
* Revision 1.38.2.7  2006/01/23 16:14:19  z_stoichev
* Added Start Obex Session with AT+CPROT support.
*
* Revision 1.38.2.6  2005/12/09 13:30:19  z_stoichev
* - Fixed Preserve OBEX LastErrorCode on error.
*
* Revision 1.38.2.5  2005/10/01 10:12:05  z_stoichev
* WideQuoteStr function fixes.
*
* Revision 1.38.2.4  2005/09/08 11:19:56  z_stoichev
* Unicode bugfixes.
*
* Revision 1.38.2.3  2005/09/06 18:32:56  z_stoichev
* Bugfixes and improvements (2.1.1.102b)
*
* Revision 1.38.2.2  2005/08/16 16:15:31  z_stoichev
* bugfixes
*
* Revision 1.38.2.1  2005/04/03 12:22:11  lordlarry
* Changed some methods to WideString methods
*
* Revision 1.38  2005/02/24 21:29:14  lordlarry
* Added a better (but ugly) method to make the TWaitThread code threadsafe. All data that is accessed outside of the class goes through the ThreadSafe object which does the locking.
*
* Revision 1.37  2005/02/19 11:08:14  lordlarry
* Changed Log Messages Category and Severity (Removing the Debug method)
*
* Revision 1.36  2005/02/09 14:01:44  z_stoichev
* Fixed #13#10 to sLinebreak.
*
* Revision 1.35  2005/02/08 15:38:52  voxik
* Merged with L10N branch
*
* Revision 1.31.2.4  2005/02/02 23:15:52  voxik
* Changed MessageDlg and ShowMessages replaced by new unicode versions
*
* Revision 1.31.2.3  2005/01/07 17:34:38  expertone
* Merge with MAIN branch
*
* Revision 1.34  2004/12/19 17:01:34  lordlarry
* Fixed Typo
*
* Revision 1.33  2004/12/19 10:21:42  voxik
* Fixed typo
*
* Revision 1.32  2004/10/20 18:41:41  voxik
* Fixed Default communication type
*
* Revision 1.31.2.2  2004/10/25 20:21:55  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.31.2.1  2004/10/19 19:48:47  expertone
* Add localization (gnugettext)
*
* Revision 1.31  2004/09/20 11:57:00  merijnb
* merged with FileObject
*
* Revision 1.30.8.1  2004/09/02 10:15:26  merijnb
* added support for paths with CRLF's in them
*
* Revision 1.30  2004/07/14 10:03:41  z_stoichev
* - Added Obex error 'Object is in use' handled.
* - Added Obex CPU 100% usage workarounds.
*
* Revision 1.29  2004/05/19 18:34:16  z_stoichev
* Build 0.1.0.35c
*
* Revision 1.28  2004/03/30 16:43:47  z_stoichev
* SyncML support
* Bugfixes
*
* Revision 1.27  2004/03/12 14:41:00  z_stoichev
* Get/PutObject friendly name
*
* Revision 1.26  2004/01/27 15:55:10  z_stoichev
* Activity log messages cleanups.
*
* Revision 1.25  2004/01/26 10:34:19  z_stoichev
* Fixed Obex Abort method misused with SysUtils one.
* Other fixes.
*
* Revision 1.24  2004/01/15 14:16:03  z_stoichev
* Modified Obex in use process.
*
* Revision 1.23  2003/12/12 12:37:19  z_stoichev
* Add delete file support.
*
* Revision 1.22  2003/12/11 13:14:54  z_stoichev
* WaitASec moved into Unit1.
*
* Revision 1.21  2003/12/03 16:29:19  z_stoichev
* Fixed error when connection interrupted while connecting.
* Fixed Obex session aborting.
* Loop check if application is terminated.
*
* Revision 1.20  2003/12/02 16:38:07  z_stoichev
* Add LastErrorCode propertry.
* Already in use issue changes.
*
* Revision 1.19  2003/12/01 15:58:15  z_stoichev
* Anti-Freeze and Obex Already in use update.
*
* Revision 1.18  2003/11/28 09:38:07  z_stoichev
* Merged with branch-release-1-1 (Fma 0.10.28c)
*
* Revision 1.17.2.10  2003/11/11 13:14:27  z_stoichev
* Show progress only if Restored option support.
*
* Revision 1.17.2.9  2003/11/10 14:03:10  z_stoichev
* RC3
*
* Revision 1.17.2.8  2003/10/31 14:56:45  z_stoichev
* Ask for retry if Obex is already used by another app.
*
* Revision 1.17.2.7  2003/10/30 15:20:24  z_stoichev
* Execute Obex command semafor usage.
* Make Abort working, and add method IsAborted.
*
* Revision 1.17.2.6  2003/10/29 12:01:32  z_stoichev
* Buffers clen up on connect/abort.
*
* Revision 1.17.2.5  2003/10/28 12:58:19  z_stoichev
* Changed Abort handeling to avoid loops.
*
* Revision 1.17.2.4  2003/10/27 15:24:33  z_stoichev
* Changed display messages.
*
* Revision 1.17.2.3  2003/10/27 13:17:27  z_stoichev
* Show status messages after Get/Del operations.
*
* Revision 1.17.2.2  2003/10/27 09:50:55  z_stoichev
* Prerelease bug-fixes.
*
* Revision 1.17.2.1  2003/10/27 07:22:54  z_stoichev
* Build 0.1.0 RC1 Initial Checkin.
*
* Revision 1.17  2003/10/24 12:36:45  z_stoichev
* T300 "Obex Forbidden" issue workaround fixed I hope.
*
* Revision 1.16  2003/10/22 13:21:13  z_stoichev
* Make progress indicator optional.
*
* Revision 1.15  2003/10/21 15:33:25  z_stoichev
* Bugfixes! Synchro was not working, it was too fast.
*
* Revision 1.14  2003/10/21 12:37:59  z_stoichev
* Changed Get method result value to cardinal.
*
* Revision 1.13  2003/10/20 14:50:21  z_stoichev
* More Obex headers are implemented.
* Connection ID and Who Obex support and
* additional checks on Connect.
* Added Connection Forbidden error message.
* CPU usage on transfer is reduced.
* Obex Abort command is implemented.
* Obex Header type support.
*
* Revision 1.12  2003/10/17 12:06:55  z_stoichev
* Fixed leaveing open Obex session on connect error.
* Todo: to process obex headers (skip unknown ones)
*
* Revision 1.11  2003/10/14 15:55:59  z_stoichev
* Fixed is "sync aborted" issue when downloading
* entire address book.
*
* Revision 1.10  2003/10/14 14:57:41  z_stoichev
* Fix two-line output on progress window.
*
* Revision 1.9  2003/10/14 13:02:16  z_stoichev
* Using new SonyEricsson progress bar
* for file transfers.
*
* Revision 1.8  2003/10/13 15:19:54  z_stoichev
* Fixed misused Abort local method instead of silent
* exception call Abort.
*
* Revision 1.7  2003/10/13 14:14:45  z_stoichev
* Recoded methods to avoid memory leaks.
* Parameters are changed alot.
* Addred support for progress dialog.
*
* Revision 1.6  2003/10/10 15:18:16  z_stoichev
* Fixed memory leaks, plus optimize
*
* Revision 1.5  2003/02/14 13:13:14  crino77
* Debugobex moved to public
* PutObject
*       - Added support for stream = nil to delete entries in phone :))
* PutObject from Procedure to Function;
* PutFile added Disconnect;
*     Line added comment by //ADD
*     Line removed comment by //OLD
*
* Revision 1.4  2003/01/30 04:15:57  warren00
* Updated with header comments
*
*
*******************************************************************************
}

interface

uses Windows, TntWindows, Classes, TntClasses, Forms, TntForms, Dialogs, TntDialogs;

const
  ObexNoSession = cardinal(-1);

  ObexFolderBrowserServiceID: string[16] = #$F9#$EC#$7B#$C4#$95#$3C#$11#$D2#$98#$4E#$52#$54#$00#$DC#$9E#$09; // do not localize
  ObexFolderListing: string              = 'x-obex/folder-listing'#00; // do not localize

  ObexSyncMLDataSyncXML: string          = 'application/vnd.syncml+xml'; // do not localize
  ObexSyncMLDataSyncWirelessXML: string  = 'application/vnd.syncml+wbxml'; // do not localize
  ObexSyncMLDevManXML: string            = 'application/vnd.syncml.dm+xml'; // do not localize
  ObexSyncMLDevManWirelessXML: string    = 'application/vnd.syncml.dm+wbxml'; // do not localize

type
  TObexItem = class(TObject)
  private
  protected
    FPacketData: String;
    procedure SetRaw(buffer: String); virtual;
    function GetRaw: String; virtual;
    function GetPacketData: String; virtual;
    procedure SetPacketData(const Value: String); virtual;
    function GetPacketLen: Integer; virtual;
  public
    PacketID: Byte;
    property PacketLen: Integer read GetPacketLen;
    property PacketData: String read GetPacketData write SetPacketData;
    property Raw: String read GetRaw write SetRaw;
    constructor Create(HID: byte = 0; data: String='');
  end;

  // TODO: Add TObexWideStrSeq
  TObexName = class(TObexItem)
  protected
    procedure SetRaw(buffer: String); override;
    function GetRaw: String; override;
  public
    name: WideString;
    constructor Create(nameStr: WideString='');
  end;

  TObexDescription = class(TObexName)
  public
    constructor Create(descrStr: WideString='');
    property descr: WideString read name write name;
  end;

  TObexByteSeq = class(TObexItem)
  protected
    seqbuffer: String;
    procedure SetRaw(buffer: String); override;
    function GetRaw: String; override;
  public
    constructor Create(HID: byte; byteseq: String='');
  end;

  TObexTarget = class(TObexByteSeq)
  public
    constructor Create(targetStr: String='');
    property Target: String read seqbuffer write seqbuffer;
  end;

  TObexWho = class(TObexByteSeq)
  public
    constructor Create(whoStr: String='');
    property Who: string read seqbuffer write seqbuffer;
  end;

  TObexType = class(TObexByteSeq)
  public
    constructor Create(typeStr: String='');
    property MimeType: string read seqbuffer write seqbuffer;
  end;

  // TODO: Add TObexCardinal
  TObexLength = class(TObexItem)
  protected
    procedure SetRaw(buffer: String); override;
    function GetRaw: String; override;
  public
    size: Cardinal;
    constructor Create(s: Cardinal=0);
  end;

  TObexConnection = class(TObexLength)
  public
    constructor Create(cid: Cardinal=0);
    property ConnectionID: cardinal read size write size;
  end;

  TObexItemList = class(TList)
  protected
    function  GetObexItem(Index: integer): TObexItem;
    procedure PutObexItem(Index: integer; ObexItem: TObexItem);
  public
    property Items[Index: integer]: TObexItem read GetObexItem write PutObexItem;
    destructor Destroy; override;
    procedure FreeAll;
  end;

  TObexPacket = class(TObexItem)
  private
    function GetBody: TObexItem;
  protected
    function GetPacketData: String; override;
    procedure SetPacketData(const Value: String); override;
    function GetConnectionID: cardinal;
    function GetLength: integer;
    function GetWho: string;
  public
    Child: TObexItemList;
    property Body: TObexItem read GetBody;
    constructor Create(HID: byte = 0; data: String='');
    destructor Destroy; override;
  end;

  TObexDirList = class(TObexPacket)
    constructor Create;
  end;

  TObexSetPath = class(TObexPacket)
  protected
    procedure SetRaw(buffer: String); override;
    function GetRaw: String; override;
    function GetPacketLen: Integer; override;
  public
    Flags,Constants: Byte;
    constructor Create(path: String=''; GoUpFirst: boolean = False; DontCreateDir: boolean = True);
  end;

  TObexConnectPacket = class(TObexItem)
  protected
    procedure SetRaw(buffer: String); override;
    function GetRaw: String; override;
  public
    // TODO: Add session id support
    ObexVersion: Integer;
    Flag: byte;
    MaxPacketLen: Integer;
    Target: String;
    constructor Create(HID: byte=0; MaxLen: Integer=0; TargetStr: String='');
  end;

  TObexTargetType = (ocOther, ocSyncML, ocIrmcSync, ocFolderBrowseing);

  TObex = class(TObject)
  private
    FAbort: Boolean;
    FLastReceivedPacket: String;
    packetLen: Integer;
    FRxBuffer: String;
    FPacketsize: Integer;
    ConnID: cardinal;
    RcPackets: TStringList;
    function CheckForPacket: boolean;
    procedure GetReceivedObject(var obj: TObexPacket);
    procedure SentObject(obexItem: TObexItem); overload;
    procedure SentObject(HID: byte = 0; data: String=''); overload;
    procedure DoAbort;
    procedure ClearRxBuffers;
  protected
    FLastErrorCode: integer;
    FIsAborted,SendingData: boolean;
    TargetType: TObexTargetType;
  public
    Connected: Boolean;
    MaxPacketSize: Integer;
    debugobex: Boolean;
    constructor Create;
    destructor Destroy; override;
    { For incomming data }
    procedure OnRxChar(c: char);
    { Connection }
    procedure Connect(Target: String='');
    procedure Disconnect;
    { Schedule abort operation }
    function IsAborted: boolean;
    procedure Abort;
    { Dangerous! Do not you if you don't know what are you doing! }
    procedure ForceAbort;
    { Empty dir changes to root folder }
    function ChangeDir(name: WideString): boolean;
    { List folder contents, Result is a XML document (encoded) }
    function List(var Xml: TStringStream): cardinal;
    { Returns current LUID of the object if any. If the stream parameter
      is nil, the object will be deleted. }
    function PutObject(name: WideString; stream: TStream; progress: boolean = False;
      FriendlyName: string = ''): WideString;
    { Returns object size in bytes or 0 on failure. }
    function GetObject(path: WideString; var where: TMemoryStream; progress: boolean = False;
      FriendlyName: string = ''): cardinal;
    { Direct calss }
    procedure PutFile(filename: WideString; Delete: boolean = False);
    procedure GetFile(filename: WideString; objname: WideString = ''; Silent: boolean = False);
  published
    property LastErrorCode: integer read FLastErrorCode;
  end;

const
  FMaxLuidLen: cardinal = 12;

function bytestream2hex(byteStream: String; seperator: String=' '): String;

implementation

uses
  gnugettext, uLogger, uThreadSafe,
  Unit1, SysUtils, TntSysUtils, Math, uConnProgress, uDialogs;

{ TObex }

function TObex.ChangeDir(name: WideString): boolean;
var
  thisPacket: TObexSetPath;
  received: TObexPacket;
  wasconn: boolean;
  aname: WideString;
begin
  Result := False;
  wasconn := Connected;
  if not Connected then Connect; // Start OBEX Mode if it's nessesery
  try
    aname := name;
    if aname = '' then aname := '/';
    Log.AddCommunicationMessage('OBEX going into folder: ' + aname, lsDebug); // do not localize debug

    thisPacket := TObexSetPath.Create(name);
    try
      SentObject(thisPacket);
    finally
      thisPacket.Destroy;
    end;

    received := TObexPacket.Create;
    try
      GetReceivedObject(received);

      if received.PacketID <> $A0 then
        raise Exception.Create(_('Invalid Respond ') + bytestream2hex(received.Raw));

      //Log.AddCommunicationMessage('OBEX folder changed', lsDebug); // do not localize debug
      Result := True;
    finally
      received.Free;
    end;
  finally
    { Stop our connections only }
    if not wasconn then Disconnect;
  end;
end;

function TObex.CheckForPacket: boolean;
var
  s: string;
begin
  //Form1.VaCommRxChar(nil,0);
  if RcPackets.Count <> 0 then begin
    s := RcPackets[0];
    RcPackets.Delete(0);
    if debugobex then Log.AddCommunicationMessage('[RX] ' + bytestream2hex(s), lsDebug); // do not localize debug
    FLastReceivedPacket := s;
    SendingData := False;
    Result := True;
  end
  else
    Result := False;
end;

procedure TObex.Connect(Target: String);
var
  recpackt: TObexPacket;
  sent,received: TObexConnectPacket;
  whoreply: string;
begin
  if Connected then exit;

  ThreadSafe.AlreadyInUseObex := False;
  ThreadSafe.ObexConnecting := True;
  try
    repeat
      if Form1.FUseObexCompat then
        Form1.TxAndWait('AT+CPROT=0', 'CONNECT') // do not localize
      else
        Form1.TxAndWait('AT*EOBEX', 'CONNECT');  // do not localize
      if ThreadSafe.AlreadyInUseObex then begin
        // TODO: Text is not wrapped anymore.
        case MessageDlgW(_('OBEX session can not be established at this time, because '+
          'the service is busy!'+sLinebreak+sLinebreak+
          'Close any other Obex applications (maybe running in background), '+
          'or turn off and then back on your phone connection (disable then '+
          'enable Bluetooth, unplug then plug cable etc). Or check if you have '+
          'to answer on some connection question (contirmation) in your phone. '+
          'If nothing above helps restart your phone and try again.'+sLinebreak+sLinebreak+
          'Do you wish to try again or Cancel current operation?'),
          mtConfirmation, MB_YESNOCANCEL) of
          ID_YES: WaitASec;
          ID_NO: begin
            Form1.Status(_('OBEX is already in use'));
            raise Exception.Create(_('OBEX Connect: Already in use or Connect failed'));
          end;
          ID_CANCEL: begin
            Form1.ActionConnectionAbort.Execute;
            SysUtils.Abort;
          end;
        end;
      end
      else break;
    until False;
  except
    ThreadSafe.ObexConnecting := False;
    raise;
  end;
  
  try
    FIsAborted := False;
    FAbort := False;
    SendingData := False;
    Connected := True;
    ThreadSafe.ObexConnecting := False;
    Log.AddCommunicationMessage('OBEX Session Established', lsDebug); // do not localize debug
    WaitASec;
    if not Connected or FIsAborted then SysUtils.Abort;
    Log.AddCommunicationMessage('OBEX Negotiateing...', lsDebug); // do not localize debug
    sent := TObexConnectPacket.Create($80, MaxPacketSize, Target);
    try
      ClearRxBuffers;
      SentObject(sent);
      received := TObexConnectPacket.Create;
      recpackt := TObexPacket.Create;
      try
        if FLastReceivedPacket = '' then SysUtils.Abort;
        if ord(FLastReceivedPacket[1]) = $C3 then
          raise Exception.Create(_('OBEX: Access to this target is denied'));
        if ord(FLastReceivedPacket[1]) <> $A0 then
          raise Exception.Create(_('Invalid Respond ') + bytestream2hex(FLastReceivedPacket));

        // get packet size
        received.Raw := FLastReceivedPacket;
        FPacketsize := min(MaxPacketSize, received.MaxPacketLen);
        Log.AddCommunicationMessage('OBEX Negotiated: Packet Size = ' + IntToStr(FPacketsize), lsDebug); // do not localize debug
        // TODO: Add support for Obex timeout...
        // process optional headers, remove connect data (6 bytes + opcode)
        Delete(FLastReceivedPacket,1,7);
        recpackt.PacketData := FLastReceivedPacket;
        // get who reply (should be target)
        whoreply := recpackt.GetWho;
        if whoreply <> Target then
          raise Exception.Create(_('Wrong Who Received: ') + whoreply)
        else
          TargetType := ocOther;
          if whoreply <> '' then begin
            if AnsiCompareText(whoreply,ObexFolderBrowserServiceID) = 0 then
              TargetType := ocFolderBrowseing;
            if AnsiCompareText(whoreply,'IRMC-SYNC') = 0 then // do not localize
              TargetType := ocIrmcSync;
            if AnsiCompareText(whoreply,'SYNCML-SYNC') = 0 then // do not localize
              TargetType := ocSyncML;

            if (AnsiCompareText(whoreply,ObexFolderBrowserServiceID) = 0) or
              (AnsiCompareText(whoreply,ObexFolderListing) = 0) then
              whoreply := 'Folder Browsing'; // do not localize
            Log.AddCommunicationMessage('OBEX Negotiated: Application = ' + whoreply, lsDebug); // do not localize debug
          end;
        // get connection id
        ConnID := recpackt.GetConnectionID;
        if ConnID <> ObexNoSession then
          Log.AddCommunicationMessage('OBEX Negotiated: Connection = ' + IntToStr(ConnID), lsDebug); // do not localize debug
      finally
        received.Free;
        recpackt.Free;
      end;
    finally
      sent.Free;
    end;
  except
    Disconnect;
    raise;
  end;
end;

constructor TObex.Create;
begin
  RcPackets := TStringList.Create;
  MaxPacketSize := $0100;
  Connected := False;
  ConnID := ObexNoSession;
end;

destructor TObex.Destroy;
begin
  if Connected then Disconnect;
  RcPackets.Free;
  inherited;
end;

procedure TObex.Disconnect;
var
  received: TObexPacket;
  ec: Integer;
begin
  if not Connected then exit;
  ec := FLastErrorCode; // remember error code if any (see bellow)
  SentObject($81); // Disconnect

  received := TObexPacket.Create;
  try
    GetReceivedObject(received);

    if received.PacketID <> $A0 then // expect 'Sucess'
      raise Exception.Create(_('Invalid Respond: ') + bytestream2hex(received.Raw));

    ConnID := ObexNoSession;
    Connected := False;
    Log.AddCommunicationMessage('OBEX Session Ended', lsDebug); // do not localize debug
  finally
    received.Free;
    if FLastErrorCode = 0 then FLastErrorCode := ec; // restore error code if any
  end;
end;

procedure TObex.DoAbort;
begin
  if Connected and not FIsAborted then begin
    ForceAbort;
    { Do not cancel connection attemt }
    if Form1.CoolTrayIcon1.CycleIcons then ThreadSafe.AbortDetected := False;
  end;
end;

function TObex.GetObject(path: WideString; var where: TMemoryStream; progress: boolean; FriendlyName: string): cardinal;
var
  received, thisPacket: TObexPacket;
  rsize,bsize,sofar: Integer;
  buffer,stat,what: string;
  frmConnect: TfrmConnect;
  wasconn: boolean;
begin
  Result := 0;
  frmConnect := nil;
  FIsAborted := False;
  wasconn := Connected;
  if not Connected then Connect; // Start OBEX Mode if it's nessesery
  try
    Form1.Status(_('Receiving ') + path,False);
    
    try
      thisPacket := TObexPacket.Create($83);
      try
        if TargetType = ocSyncML then
          thisPacket.Child.Add(TObexType.Create(ObexSyncMLDataSyncXML));

        thisPacket.Child.Add(TObexName.Create(path));

        SentObject(thisPacket);
      finally
        thisPacket.Destroy;
      end;

      if FriendlyName <> '' then what := FriendlyName
        else what := path;

      { Show progress window }
      if progress and Form1.CanShowProgress then begin
        frmConnect := GetProgressDialog;
        frmConnect.SetDescr(_('Retrieving ') + what);
        frmConnect.ShowProgress(Form1.FProgressLongOnly);
      end;

      rsize := -2; // set here -3 to prevent size check/detection
      sofar := 0;
      received := TObexPacket.Create;
      try
        repeat
          try
            GetReceivedObject(received);
            { check for length header on first packet only }
            if (rsize = -2) and Assigned(frmConnect) then begin
              rsize := received.GetLength;
              if rsize > 0 then frmConnect.Initialize(rsize);
            end;
            if FIsAborted then break;
            buffer := received.Body.PacketData;
            bsize := length(buffer);
            sofar := sofar + bsize;
            where.WriteBuffer(buffer[1],bsize);
            if (rsize > 0) and Assigned(frmConnect) then
              frmConnect.IncProgress(bsize);

            //Form1.Debug('Packet Sucessfull. Get=' + IntToStr(bsize)); // do not localize debug

            if progress then begin
              {
              if rsize > 0 then
                stat := Format(_('Receiving %s (%d of %d bytes))',[path,sofar,rsize])
              else
                stat := Format(_('Receiving %s (%d bytes so far)'),[path,sofar]);
              Form1.Status(stat);
              }
              if Assigned(frmConnect) then begin
                if rsize > 0 then
                  stat := Format(_('Receiving %s'+sLinebreak+'(%.1n of %.1n kB)'),[what,sofar / 1024,rsize / 1024])
                else
                  stat := Format(_('Receiving %s'+sLinebreak+'(%.1n kB so far)'),[what,sofar / 1024]);
                frmConnect.SetDescr(stat);
              end;
            end;

            if FIsAborted or (received.PacketID <> $90) then break; // expect continue?

            thisPacket := TObexPacket.Create($83);
            try
              if TargetType = ocSyncML then
                thisPacket.Child.Add(TObexType.Create(ObexSyncMLDataSyncXML));
              SentObject(thisPacket);
            finally
              thisPacket.Destroy;
            end;
          except
            { we should abort miltipart operations }
            DoAbort;
            raise;
          end;
        until not Connected or FIsAborted;
      finally
        received.Free;
      end;

      if rsize > 0 then
        Form1.Status(_('Received ') + path + ' (' + IntToStr(rsize) + _(' bytes)'),False)
      else
        Form1.Status(_('Received ') + path,False);
        
      Result := where.size;
      where.Seek(0, soFromBeginning);
    except
      on E: Exception do begin
        Form1.Status(_('Error retrieving ') + path + ': ' + E.Message);
        if FIsAborted then begin
          Form1.Status(_('Operation aborted'));
          raise;
        end
        else
          raise Exception.Create(_('OBEX Get Failed: ') + E.Message);
      end;
    end;
  finally
    { Stop our connections only }
    if not wasconn then Disconnect;
    if Assigned(frmConnect) then FreeProgressDialog;
  end;
end;

procedure TObex.GetReceivedObject(var obj: TObexPacket);
begin
  obj.Raw := FLastReceivedPacket;
  try
    case obj.PacketID of
      $C0: raise Exception.Create(_('Bad request'));
      $C1: raise Exception.Create(_('Unauthorized'));
      $C2: raise Exception.Create(_('Payment required'));
      $C3: raise Exception.Create(_('Forbidden'));
      $C4: raise Exception.Create(_('Not found'));
      $C5: raise Exception.Create(_('Method not allowed'));
      $C6: raise Exception.Create(_('Not Acceptable'));
      $C7: raise Exception.Create(_('Proxy Authentication required'));
      $C8: raise Exception.Create(_('Request Time Out'));
      $C9: raise Exception.Create(_('Conflict'));
      $CA: raise Exception.Create(_('Gone'));
      $CB: raise Exception.Create(_('Length Required'));
      $CC: raise Exception.Create(_('Precondition failed'));
      $CD: raise Exception.Create(_('Requested entity too large'));
      $CE: raise Exception.Create(_('Requested URL too large'));
      $CF: raise Exception.Create(_('Unsupported media type'));
      $D0: raise Exception.Create(_('Internal Server Error'));
      $D1: raise Exception.Create(_('Not Implemented'));
      $D2: raise Exception.Create(_('Bad Gateway'));
      $D3: raise Exception.Create(_('Service Unavailable')); // maybe phone is just switched on? try later
      $D4: raise Exception.Create(_('Gateway Timeout'));
      $D5: raise Exception.Create(_('HTTP version not supported'));
      $E1: raise Exception.Create(_('Object is in use')); // Database locked
    end;
  except
    SendingData := False;
    FLastErrorCode := obj.PacketID;
    raise;
  end;
end;

function TObex.List(var Xml: TStringStream): cardinal;
var
  thisPacket,received: TObexPacket;
  wasconn: boolean;
begin
  Result := 0;
  Xml.Size := 0;
  FIsAborted := False;
  wasconn := Connected;
  if not Connected then Connect; // Start OBEX Mode if it's nessesery
  try
    Log.AddCommunicationMessage('OBEX folder list starting', lsDebug); // do not localize debug

    thisPacket := TObexDirList.Create;
    try
      SentObject(thisPacket);
    finally
      thisPacket.Destroy;
    end;
    try
      received := TObexPacket.Create;
      try
        repeat
          try
            GetReceivedObject(received);
            try
              Xml.WriteString(received.Body.PacketData);
            except
            end;  
            if FIsAborted or (received.PacketID <> $90) then break;
            SentObject($83);
          except
            { we should abort miltipart operations }
            DoAbort;
            raise;
          end;
        until not Connected or FIsAborted;

        Log.AddCommunicationMessage('OBEX folder list complete', lsDebug); // do not localize debug
      finally
        received.Free;
      end;

      Result := length(Xml.DataString);
      Xml.Seek(0, soFromBeginning);
    except
      on E: Exception do begin
        if FIsAborted then begin
          Form1.Status(_('Operation aborted by user'));
          raise;
        end
        else begin
          Form1.Status(_('Error listing folder: ') + E.Message);
          raise Exception.Create(_('OBEX List Failed: ') + E.Message);
        end;  
      end;
    end;
  finally
    { Stop our connections only }
    if not wasconn then Disconnect;
  end;
end;

procedure TObex.OnRxChar(c: char);
begin
  FRxBuffer := FRxBuffer + c;

  if length(FRxBuffer) < 3 then
    packetLen := -1
  else
    if (packetLen = -1) and (length(FRxBuffer) > 2) then
      packetLen := (byte(FRxBuffer[2]) shl 8) or byte(FRxBuffer[3]);

  if length(FRxBuffer) = packetlen then begin
    RcPackets.Add(FRxBuffer);
    FRxBuffer := '';
    packetlen := -1;
  end;
end;

procedure TObex.PutFile(filename: WideString; Delete: boolean);
var
  stream: TFileStream;
  objname: WideString;
  Dir: WideString;
  i: integer;
begin
  objname := WideExtractFileName(filename);
  if Delete then begin
    ChangeDir('');
    repeat
      i := Pos('/',objname);
      if i = 0 then break;
      Dir := Copy(objname,1,i-1);
      StringReplace(Dir, sLinebreak, #10, [rfReplaceAll]);
      System.Delete(objname,1,i);
      ChangeDir(Dir);
    until False;
    PutObject(objname, nil);
  end
  else begin
    { Phone will decide where to put the new file }
    stream := TFileStream.Create(filename, fmOpenRead or fmShareDenyNone);
    try
      PutObject(objname, stream, true);
    finally
      stream.Free;
    end;
  end;
end;

procedure TObex.GetFile(filename,objname: WideString; Silent: boolean);
var
  str: TMemoryStream;
  stream: TFileStream;
  Dir: WideString;
  i: integer;
begin
  if objname = '' then objname := WideExtractFileName(filename);
  ChangeDir('');
  repeat
    i := Pos('/',objname);
    if i = 0 then break;
    Dir := Copy(objname,1,i-1);
    StringReplace(Dir, sLinebreak, #10, [rfReplaceAll]);
    Delete(objname,1,i);
    ChangeDir(Dir);
  until False;
  str := TMemoryStream.Create;
  try
    GetObject(objname, str, not Silent);
    { Create file only on success }
    stream := TFileStream.Create(filename, fmCreate);
    try
      stream.CopyFrom(str,str.Size)
    finally
      stream.Free;
    end;
  finally
    str.Free;
  end;
end;

function TObex.PutObject(name: WideString; stream: TStream; progress: boolean; FriendlyName: string): WideString;
var
  received, thisPacket: TObexPacket;
  emptySlot: Integer;
  buffer,stat,what: String;
  wasconn: boolean;
  frmConnect: TfrmConnect;
begin
  Result := '';
  frmConnect := nil;
  FIsAborted := False;
  wasconn := Connected;
  if not Connected then Connect; // Start OBEX Mode if it's nessesery
  try
    { nil means put null packet and delete the entries }
    if stream = nil then begin
       Form1.Status(_('Deleting ') + name,False);

       thisPacket := TObexPacket.Create($82); // final put
       try
         thisPacket.Child.Add(TObexName.Create(name));
         SentObject(thisPacket);
       finally
         thisPacket.Destroy;
       end;

       received := TObexPacket.Create;
       try
         GetReceivedObject(received);

         if received.PacketID <> $A0 then // expect 'continue'
           raise Exception.Create(_('Invalid Respond ') + bytestream2hex(received.Raw));

         //For Sync i need only the last row (LUID) :)
         if received.Body <> nil then Result := Copy(received.Body.PacketData,3,FMaxLuidLen);
       finally
         received.Free;
       end;
       Form1.Status(_('Deleted ') + name,False);
       { Now exit }
       exit;
    end;

    { Show progress window }
    if progress and Form1.CanShowProgress then begin
      frmConnect := GetProgressDialog;
      frmConnect.Initialize(stream.Size,_('Check your phone for instructions...'));
      frmConnect.ShowProgress(Form1.FProgressLongOnly);
    end;

    Form1.Status(_('Sending ') + name + ' (' + IntToStr(stream.Size) + _(' bytes)'),False);

    if FriendlyName <> '' then what := FriendlyName
      else what := name;

    try
      stream.Seek(0, soFromBeginning);

      // put request
      while Connected and (stream.Position < stream.Size) and (not FIsAborted) do
      try
        thisPacket := TObexPacket.Create($02);
        try
          if TargetType = ocSyncML then
            thisPacket.Child.Add(TObexType.Create(ObexSyncMLDataSyncXML));

          // add name for first packet
          if stream.Position = 0 then begin
            thisPacket.Child.Add(TObexName.Create(name));
            thisPacket.Child.Add(TObexLength.Create(stream.Size));
          end;

          emptySlot := FPacketsize - thisPacket.PacketLen - 3;

          SetLength(buffer, emptySlot);
          SetLength(buffer, stream.Read(buffer[1], emptySlot));

          thisPacket.Child.Add(TObexItem.Create($48, buffer));
          SentObject(thisPacket);
        finally
          thisPacket.Destroy;
        end;

        if Assigned(frmConnect) then frmConnect.IncProgress(emptySlot);

        received := TObexPacket.Create;
        try
          GetReceivedObject(received);
          if FIsAborted then break;

          if received.PacketID <> $90 then // expect 'continue'
            raise Exception.Create(_('Invalid Respond ') + bytestream2hex(received.Raw));

          if progress then begin
            {
            stat := Format(_('Sending %s (%d of %d bytes)'),[name,stream.Position,stream.Size]);
            Form1.Status(stat);
            }
            if Assigned(frmConnect) then begin
              stat := Format(_('Sending %s'+sLinebreak+'(%.1n of %.1n kB)'),[what,stream.Position / 1024,stream.Size / 1024]);
              frmConnect.SetDescr(stat);
            end;
          end;  
        finally
          received.Free;
        end;
      except
        { we should abort miltipart operations }
        DoAbort;
        raise;
      end;

      { bookmarks and etc. ask user to keep file _after_ file transfer }
      if Assigned(frmConnect) then begin
        Form1.Status('Check your phone for instructions...',False);
        frmConnect.SetDescr(_('Check your phone for instructions...'));
      end;

      thisPacket := TObexPacket.Create($82); // final put
      try
        if TargetType = ocSyncML then
          thisPacket.Child.Add(TObexType.Create(ObexSyncMLDataSyncXML));

        thisPacket.Child.Add(TObexItem.Create($49));

        SentObject(thisPacket);
      finally
        thisPacket.Destroy;
      end;

      received := TObexPacket.Create;
      try
        GetReceivedObject(received);

        if received.PacketID <> $A0 then // expect 'continue'
          raise Exception.Create(_('Invalid Respond ') + bytestream2hex(received.Raw));

        //For Sync i need only the last row (LUID) :)
        if received.Body <> nil then Result := Copy(received.Body.PacketData,3,FMaxLuidLen);

        Form1.Status(_('Sent ') + name,False);
      finally
        received.Free;
      end;
    except
      on E: Exception do begin
        Form1.Status(_('Error sending ') + name + ': ' + E.Message);
        if FIsAborted then begin
          Form1.Status(_('Operation aborted by user'));
          raise;
        end
        else
          raise Exception.Create(_('OBEX Put Failed: ') + E.Message);
      end;
    end;
  finally
    { Stop our connections only }
    if not wasconn then Disconnect;
    if Assigned(frmConnect) then FreeProgressDialog;
  end;
end;

procedure TObex.SentObject(obexItem: TObexItem);
const
  Aborting: boolean = False;
var
  sid: TObexConnection;
  Raw: string;
begin
  FLastErrorCode := 0;
  FLastReceivedPacket := '';

  { It is illegal to send a Connection Id and a Target header in the same request. It is legal to send both
    headers in a response, as discussed in section 3.3.1.6. }
  if ConnID <> ObexNoSession then begin
    sid := TObexConnection.Create(ConnID);
    try
      // set conn id as a first header
      obexItem.PacketData := sid.Raw + obexItem.PacketData;
    finally
      sid.Free;
    end;
  end;
  Raw := obexItem.Raw;

  // TODO: Add semafor usafe here and WaitForSingleObject....
  while not IsAborted and SendingData do begin
    if CheckForPacket then break;
    Sleep(25);
    Application.ProcessMessages;
    if Application.Terminated then begin
      SendingData := False;
      SysUtils.Abort;
    end;  
  end;

  if debugobex then Log.AddCommunicationMessage('[TX] ' + bytestream2hex(Raw), lsDebug); // do not localize debug

  SendingData := True;

  if ThreadSafe.ConnectionType = 0 then Form1.WBtSocket.SendStr(Raw)
  else if ThreadSafe.ConnectionType = 1 then Form1.WIrSocket.SendStr(Raw)
  else Form1.ComPort.WriteStr(Raw);

  while Connected and (FLastReceivedPacket = '') and (Aborting or not FAbort) do
    begin
      if CheckForPacket then break;
      Sleep(25);
      Application.ProcessMessages;
      if ThreadSafe.Abort or Application.Terminated then begin
        Aborting := False;
        FAbort := True;
      end;
    end;

  if Connected and not Aborting and FAbort then begin
    Aborting := True;
    try
      FAbort := False;
      DoAbort;
    finally
      Aborting := False;
    end;
    Log.AddCommunicationMessage('OBEX: Aborted by user', lsWarning); // do not localize debug
    Form1.Status(_('Operation aborted by user'),False);
    SysUtils.Abort;
  end;
end;

procedure TObex.SentObject(HID: byte; data: String);
var
  item: TObexItem;
begin
  item := TObexItem.Create(HID, data);
  try
    SentObject(item);
  finally
    item.free;
  end;
end;

procedure TObex.ClearRxBuffers;
begin
  FRxBuffer := '';
  RcPackets.Clear;
end;

procedure TObex.Abort;
begin
  FAbort := True;
end;

procedure TObex.ForceAbort;
var
  tm: cardinal;
  ec: integer;
begin
  FIsAborted := True;
  // Should we remove this command complete wait loop.... ?
  tm := GetTickCount;
  while SendingData do begin
    if CheckForPacket then break;
    Sleep(25);
    Application.ProcessMessages;
    if Abs(GetTickCount - tm) > 10000 then SendingData := False;
  end;
  // Aborting...
  Log.AddCommunicationMessage('OBEX: Aborting...', lsDebug); // do not localize debug
  ClearRxBuffers;

  ec := FLastErrorCode; // preserve error code if any
  try
    SentObject($FF);
  finally
    FLastErrorCode := ec;
  end;

  if (FLastReceivedPacket = '') or (ord(FLastReceivedPacket[1]) <> $A0) then
    Disconnect;
  ThreadSafe.ObexConnecting := False;  
  // Set global abort flag
  if ThreadSafe.Busy then
    ThreadSafe.Abort := True
  else
    ThreadSafe.AbortDetected := True;
end;

function TObex.IsAborted: boolean;
begin
  Result := FIsAborted;
end;

{ TObexPacket }

constructor TObexItem.Create(HID: byte; data: String);
begin
  PacketID := HID;
  PacketData := data;
end;

function TObexItem.GetPacketData: String;
begin
  Result := FPacketData;
end;

function TObexItem.GetPacketLen: Integer;
begin
  Result := length(PacketData) + 3;
end;

function TObexItem.GetRaw: String;
var
  lenHigh, lenLow: Byte;
begin
  lenHigh := (PacketLen and $FF00) shr 8;
  lenLow := PacketLen and $00FF;

  Result := chr(packetID) + chr(lenHigh) + chr(lenLow) + PacketData;
end;

procedure TObexItem.SetPacketData(const Value: String);
begin
  FPacketData := Value;
end;

procedure TObexItem.SetRaw(buffer: String);
begin
  try
    packetID := byte(buffer[1]);
    //  packetLen := (byte(buffer[2]) shl 8) or byte(buffer[3]);
    PacketData := copy(buffer, 4, length(buffer) - 3);
  except
    packetID := 0;
    PacketData := '';
  end;
end;

{ TPutRequestPacket }

constructor TObexConnectPacket.Create(HID: byte; MaxLen: Integer; TargetStr: String);
begin
  PacketID := HID;
  ObexVersion := $10;
  Flag := $00;
  MaxPacketLen := MaxLen;
  Target := TargetStr;
end;

function TObexConnectPacket.GetRaw: String;
var
  lenHigh, lenLow: Byte;
  obexTarget: TObexTarget;
begin
  lenHigh := (MaxPacketLen and $FF00) shr 8;
  lenLow := MaxPacketLen and $00FF;
  PacketData := chr(ObexVersion) + chr(Flag) + chr(lenHigh) + chr(lenLow);

  if Target <> '' then begin
    obexTarget := TObexTarget.Create(Target);
    try
      PacketData := PacketData + obexTarget.Raw;
    finally
      obexTarget.Free;
    end;
  end;

  Result := Inherited GetRaw;
end;

procedure TobexConnectPacket.SetRaw(buffer: String);
begin
  Inherited SetRaw(buffer);

  if length(PacketData) >= 4 then begin
    ObexVersion := byte(PacketData[1]);
    Flag := byte(PacketData[2]);
    MaxPacketLen := (byte(PacketData[3]) shl 8) or byte(PacketData[4]);
  end;
end;

{ TObexPacket }

constructor TObexPacket.Create(HID: byte; data: String);
begin
  Child := TObexItemList.Create;
  inherited Create(HID, data);
end;

destructor TObexPacket.Destroy;
begin
  Child.Free;
end;

function TObexPacket.GetBody: TObexItem;
var
  i: Integer;
begin
  Result := nil;

  for i := 0 to Child.Count - 1 do begin
    if (Child.Items[i].PacketID = $48) or (Child.Items[i].PacketID = $49)
      or (Child.Items[i].PacketID = $4C) then begin
      Result := Child.Items[i];
    end;
  end;
end;

function TObexPacket.GetPacketData: String;
var
  i: Integer;
begin
  Result := '';

  for i := 0 to Child.Count - 1 do begin
    Result := Result + Child.Items[i].Raw;
  end;
end;

function TObexPacket.GetConnectionID: cardinal;
var
  i: integer;
begin
  Result := ObexNoSession;
  for i := 0 to Child.Count-1 do
    if Child.Items[i].ClassType = TObexConnection then begin
      Result := (Child.Items[i] as TObexConnection).ConnectionID;
      break;
    end;
end;

procedure TObexPacket.SetPacketData(const Value: String);
var
  buffer: String;
  itemlen: Integer;
//  item: String;
  obexitem: TObexItem;
  HT, HI: byte;
begin
  Child.FreeAll;
  buffer := Value;
  while buffer <> '' do begin
    itemlen := 0;
    HI := ord(buffer[1]);
    HT := (HI and $C0) shr 6;
    case HT of
      0: begin // null terminated Unicode text, length prefixed with 2 byte unsigned integer
           itemlen := (byte(buffer[2]) shl 8) or byte(buffer[3]);
         end;
      1: begin // byte sequence, length prefixed with 2 byte unsigned integer
           itemlen := (byte(buffer[2]) shl 8) or byte(buffer[3]);
         end;
      2: begin // 1 byte quantity
           itemlen := 2;
         end;
      3: begin // 4 byte quantity – transmitted in network byte order (high byte first)
           itemlen := 5;
         end;
    end;

    // TODO: Add more header ID support here.
    case ord(buffer[1]) of
      $01: obexitem := TObexName.Create;
      $05: obexitem := TObexDescription.Create;
      $46: obexitem := TObexTarget.Create;
      $4A: obexitem := TObexWho.Create;
      $C3: obexitem := TObexLength.Create;
      $CB: obexitem := TObexConnection.Create;
    else
      obexItem := TObexItem.Create;
    end;
    try
      obexItem.Raw := copy(buffer, 1, itemlen);
      Child.Add(obexItem);
    except
      obexItem.Free;
      raise;
    end;
    Delete(buffer,1,itemlen);
  end;
end;

function TObexPacket.GetWho: string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to Child.Count-1 do
    if Child.Items[i].ClassType = TObexWho then begin
      Result := (Child.Items[i] as TObexWho).Who;
      break;
    end;
end;

function TObexPacket.GetLength: integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to Child.Count-1 do
    if Child.Items[i].ClassType = TObexLength then begin
      Result := (Child.Items[i] as TObexLength).size;
      break;
    end;
end;

{ TObexName }

constructor TObexName.Create(nameStr: WideString);
begin
  inherited Create($01);
  name := nameStr;
end;

function TObexName.GetRaw: String;
var
  i, c: Integer;
begin
  PacketData := '';
  for i := 1 to length(name) do begin
    c := ord(name[i]);
    PacketData := PacketData + chr((c and $FF00) shr 8) + chr(c and $00FF);
  end;

  // null terminated (if not empty, and if needed)
  if (PacketData <> '') and (Copy(PacketData,Length(PacketData)-1,2) <> #00#00) then
    PacketData := PacketData + #00#00;

  Result := inherited GetRaw;
end;

procedure TObexName.SetRaw(buffer: String);
var
  i: Integer;
begin
  inherited SetRaw(buffer);

  name := '';
  for i := 0 to round(PacketLen / 2) - 3 do
    name := name + WideChar((ord(PacketData[(i*2)+1]) shl 8) or ord(PacketData[(i*2)+2]));
end;

{ TObexLength }

constructor TObexLength.Create(s: Cardinal);
begin
  inherited Create($C3);
  Size := s;
end;

function TObexLength.GetRaw: String;
begin
  PacketData := chr((Size and $FF000000) shr 24) + chr((Size and $00FF0000) shr 16) +
    chr((Size and $0000FF00) shr 8)  + chr(Size and $000000FF);

  Result := chr(packetID) + PacketData;
end;

procedure TObexLength.SetRaw(buffer: String);
var
  c: cardinal;
begin
  packetID := byte(buffer[1]);

  c := (cardinal(ord(buffer[2])) shl 24) or (cardinal(ord(buffer[3])) shl 16) or
    (cardinal(ord(buffer[4])) shl  8) or cardinal(ord(buffer[5]));
  Size := c;
end;

{ Global }

function bytestream2hex(byteStream, seperator: string): String;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to length(byteStream) do
    Result := Result + IntToHex(byte(byteStream[i]),2) + seperator;
end;

{ TObexItemList }

destructor TObexItemList.Destroy;
begin
  FreeAll;
  inherited;
end;

procedure TObexItemList.FreeAll;
var
  index: Integer;
begin
  for Index := Count-1 downto 0 do
    Items[Index].Free;
  Clear;  
end;

function TObexItemList.GetObexItem(Index: integer): TObexItem;
begin
  Result:=TObexItem(inherited Items[Index]);
end;

procedure TObexItemList.PutObexItem(Index: integer; ObexItem: TObexItem);
begin
  inherited Items[Index]:= ObexItem;
end;

{ TObexConnID }

constructor TObexConnection.Create(cid: Cardinal);
begin
  inherited Create(cid);
  PacketID := $CB;
end;

{ TObexDescription }

constructor TObexDescription.Create(descrStr: WideString);
begin
  inherited Create(descrStr);
  PacketID := $05;
end;

{ TObexDirList }

constructor TObexDirList.Create;
begin
  inherited Create($83);
  Child.Add(TObexItem.Create($42,ObexFolderListing)); // do not localize
end;

{ TObexSetPath }

constructor TObexSetPath.Create(path: String; GoUpFirst,DontCreateDir: boolean);
begin
  Constants := 0;
  if GoUpFirst then Flags := 1 else Flags := 0; // set bit 0
  if DontCreateDir then Flags := Flags + 2; // set bit 1
  inherited Create($85);
  Child.Add(TObexName.Create(path));
end;

function TObexSetPath.GetPacketLen: Integer;
begin
  Result := inherited GetPacketLen + 2;
end;

function TObexSetPath.GetRaw: String;
var
  lenHigh, lenLow: Byte;
begin
  lenHigh := (PacketLen and $FF00) shr 8;
  lenLow := PacketLen and $00FF;
  { Add Flags and Constants }
  Result := chr(packetID) + chr(lenHigh) + chr(lenLow) + chr(Flags) + chr(Constants) + PacketData;
end;

procedure TObexSetPath.SetRaw(buffer: String);
begin
  packetID := byte(buffer[1]);
  Flags := byte(buffer[4]);
  Constants := byte(buffer[5]);
  PacketData := copy(buffer, 6, length(buffer) - 5);
end;

{ TObexByteSeq }

constructor TObexByteSeq.Create(HID: byte; byteseq: String);
begin
  inherited Create(HID);
  seqbuffer := byteseq;
end;

function TObexByteSeq.GetRaw: String;
begin
  PacketData := seqbuffer;
  Result := inherited GetRaw;
end;

procedure TObexByteSeq.SetRaw(buffer: String);
begin
  inherited SetRaw(buffer);
  seqbuffer := PacketData;
end;

{ TObexTarget }

constructor TObexTarget.Create(targetStr: String);
begin
  inherited Create($46,targetStr);
end;

{ TObexWho }

constructor TObexWho.Create(whoStr: String);
begin
  inherited Create($4A,whoStr);
end;

{ TObexType }

constructor TObexType.Create(typeStr: String);
begin
  {
  SyncML 1.1 Specs
  http://www.openmobilealliance.org/tech/affiliates/syncml/syncmlindex.html
  
  MIME header type requirement
  
  Data synchronization client implementations conforming to this specification MUST support
  this header with either the "application/vnd.syncml+xml" or
  "application/vnd.syncml+wbxml" media type values. Data synchronization server
  implementations conforming to this specification MUST support both
  "application/vnd.syncml+xml" and "application/vnd.syncml+wbxml" media
  type values, as requested by the SyncML data synchronization client.

  Device Management client implementations conforming to this specification MUST support
  this header with either the "application/vnd.syncml.dm+xml" or
  "application/vnd.syncml.dm+wbxml" media type values. Device management
  server implementations conforming to this specification MUST support both
  "application/vnd.syncml.dm+xml" and "application/vnd.syncml.dm+wbxml"
  media type values, as requested by the SyncML device management client.
  }
  { Make sure type is null terminated }
  if (typeStr <> '') and (typeStr[length(typeStr)] <> #0) then
    typeStr := typeStr + #0;
  inherited Create($42,typeStr);
end;

end.

