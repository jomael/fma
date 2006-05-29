unit uWaitComplete;

{
*******************************************************************************
* Descriptions: Sony Ericsson progress bar
* $Source: /cvsroot/fma/fma/uWaitComplete.pas,v $
* $Locker:  $
*
* Todo:
*    - remove ErrorOccured, use DebugStr only as error flag.
*
* Change Log:
* $Log: uWaitComplete.pas,v $
* Revision 1.20.2.3  2006/02/20 09:21:52  mhr3
* fixed possible deadlock
*
* Revision 1.20.2.2  2005/09/06 18:32:57  z_stoichev
* Bugfixes and improvements (2.1.1.102b)
*
* Revision 1.20.2.1  2005/04/11 22:36:31  z_stoichev
* Fixed GSM coding scheme.
*
* Revision 1.20  2005/02/28 20:05:53  lordlarry
* Fixed a time out bug which occured after making the code thread safe
*
* Revision 1.19  2005/02/24 22:01:49  lordlarry
* Fixed some bugs introduced in the conversion to the new Log method
*
* Revision 1.18  2005/02/24 21:29:15  lordlarry
* Added a better (but ugly) method to make the TWaitThread code threadsafe. All data that is accessed outside of the class goes through the ThreadSafe object which does the locking.
*
* Revision 1.17  2005/02/24 18:31:08  lordlarry
* Added Sledge Hammer to make it thread safe
* Added Name for Thread
*
* Revision 1.16  2005/02/19 12:17:17  lordlarry
* Changed Log Messages Category and Severity (Removing the Debug method)
*
* Revision 1.15  2005/02/08 15:38:57  voxik
* Merged with L10N branch
*
* Revision 1.14.2.2  2004/10/25 20:21:58  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.14.2.1  2004/10/19 19:48:49  expertone
* Add localization (gnugettext)
*
* Revision 1.14  2004/10/15 14:01:53  z_stoichev
* Merged with Stable bugfixes
*
* Revision 1.13.6.1  2004/10/14 16:43:28  z_stoichev
* Bugfixes
*
* Revision 1.13  2004/07/02 20:12:15  z_stoichev
* no message
*
* Revision 1.12  2004/07/02 18:14:17  lordlarry
* Fixed 100% CPU when communicating
*
* Revision 1.11  2004/06/28 22:42:26  z_stoichev
* Possible freeze fixed
*
* Revision 1.10  2004/06/28 09:12:38  z_stoichev
* Bugfixes
*
* Revision 1.9  2004/06/25 08:11:25  z_stoichev
* Added Message storage is 90% full warning.
*
* Revision 1.8  2004/05/19 18:34:16  z_stoichev
* Build 0.1.0.35c
*
* Revision 1.7  2004/03/11 13:38:16  z_stoichev
* Show user friendly message on AT error.
*
* Revision 1.6  2004/03/08 09:57:54  z_stoichev
* Fixed timeout on long operations.
*
* Revision 1.5  2004/02/03 16:29:03  z_stoichev
* Bugfixes.
*
* Revision 1.4  2004/01/26 10:32:12  z_stoichev
* Added uWaitComplete again.
*
* Revision 1.2  2003/12/04 16:22:33  z_stoichev
* Bugfixes
*
*
}

interface

uses
  Forms, TntForms, Windows, TntWindows, Classes, TntClasses, Controls, TntControls, SysUtils, TntSysUtils;

type
  TWaitThread = class(TThread)
  private
    DebugStr: WideString;
    FIsFinished: Boolean;
    FIsStarted: Boolean;
    FSendingStr: String;
    function Get_IsErrorOccur: Boolean;
    procedure SetName;
    procedure SendStr(const Str: String);
    procedure DoSendStr;
  protected
    TxData,RcWait: String;
    ErrorOccured: Boolean;
    procedure Execute; override;
  public
    constructor Create(SendData,WaitFor: string);
    function GetLastError: string;
  published
    property Started: Boolean read FIsStarted;
    property Finished: Boolean read FIsFinished;
    property IsErrorOccur: Boolean read Get_IsErrorOccur;
  end;

implementation

uses
  gnugettext, gnugettexthelpers,
  Unit1, uThreadSafe, uSMS, uLogger;

{ Important: Methods and properties of objects in VCL or CLX can only be used
  in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TWaitThread.UpdateCaption;
    begin
      Form1.Caption := _('Updated in a thread');
    end; }

type
  TThreadNameInfo = record
    FType: LongWord;     // must be 0x1000
    FName: PChar;        // pointer to name (in user address space)
    FThreadID: LongWord; // thread ID (-1 indicates caller thread)
    FFlags: LongWord;    // reserved for future use, must be zero
  end;

{ TWaitThread }

procedure TWaitThread.SetName;
var
  ThreadNameInfo: TThreadNameInfo;
begin
  ThreadNameInfo.FType := $1000;
  ThreadNameInfo.FName := 'WaitThread';
  ThreadNameInfo.FThreadID := $FFFFFFFF;
  ThreadNameInfo.FFlags := 0;

  try
    RaiseException( $406D1388, 0, sizeof(ThreadNameInfo) div sizeof(LongWord), @ThreadNameInfo );
  except
  end;
end;

constructor TWaitThread.Create(SendData, WaitFor: string);
begin
  TxData := SendData;
  RcWait := WaitFor;
  FIsFinished := False;
  inherited Create(False);
end;

procedure TWaitThread.Execute;
begin
  SetName;

  ReturnValue := 0;
  ErrorOccured := False;
  DebugStr := '';
  { Wait for any previous thread to finish }
  repeat
    if not Assigned(ThreadSafe.ActiveThread) and (not ThreadSafe.Busy) and //not Form1.FScriptRunning and
       (WaitForSingleObject(WaitCompleteIsBusyEvent,50) = WAIT_OBJECT_0) then break;
    if ThreadSafe.Abort or Application.Terminated or Terminated then begin
      ThreadSafe.ActiveThread := nil;
      FIsFinished := True;
      FIsStarted := True;
      exit;
    end;
    Sleep(25);
  until False;

  { Ok, continue }
  FIsStarted := True;
  Screen.Cursor := crAppStart;
  try
    ThreadSafe.Busy := True;
    ThreadSafe.ActiveThread := Self;
    ThreadSafe.WaitStr := RcWait;
    ThreadSafe.LastCommand := TxData;
    ResetEvent(WaitCompleteEvent);
    if TxData <> '' then begin
      { HACK! Needed for HandleCPMS() in Unit1.pas }
      if Pos('AT+CPMS="',TxData) = 1 then // do not localize
        ThreadSafe.LastMessageStore := Copy(TxData,10,2); // ME or SM or...

      { Convert data }
      Log.AddCommunicationMessageFmt('[TX] %s', [TxData], lsDebug); // do not localize debug
      DebugStr := TxData; // do not localize debug

      if ThreadSafe.DoCharConvertion then
        TxData := GSMEncode7Bit(TxData); //TxData := ConvertCharSet(TxData, True);

      { Where and when to clear ThreadSafe.DoCharConvertion ? }
      if not ThreadSafe.WaitingOK then
        ThreadSafe.RxBuffer.Clear;
      //ShowDebug('RxBuffer: '+IntToStr(FRxBuffer.Count)+' line(s) so far');
      ThreadSafe.WaitingOK := RcWait = 'OK'; // do not localize
      { Send data... }
      ThreadSafe.MSec := GetTickCount + ThreadSafe.InactivityTimeout;
      SendStr(TxData + #13);
    end
    else
      ThreadSafe.MSec := GetTickCount + 500;

    (****************************************************************)

    { Wait complete - Main Loop }
    ThreadSafe.Timedout := False;
    while (WaitForSingleObject(WaitCompleteEvent, 200) = WAIT_TIMEOUT) and not ThreadSafe.Abort and not ThreadSafe.Timedout do begin
      ThreadSafe.Timedout := not (GetTickCount < ThreadSafe.MSec);
      if Application.Terminated then ThreadSafe.Abort := True;
    end;

    (****************************************************************)

    if ThreadSafe.WaitStr = 'ERROR' then begin // do not localize
      ErrorOccured := True;
      Log.AddCommunicationMessage('ERROR: Command return error or not understood ('+TxData+')', lsError); // do not localize debug
      DebugStr := 'Command return error or not understood ('+TxData+')'; // do not localize debug
      ThreadSafe.WaitStr := '';
    end;
    { Do not error or timeout on stray response check }
    if TxData = '' then begin
      ThreadSafe.Timedout := False;
      ErrorOccured := False;
    end;
    { Check for timeout }
    if not ThreadSafe.AlreadyInUseObex and ThreadSafe.Timedout then begin
      ErrorOccured := True;
      { TODO : Form1.IsAutoConnect needs to be Synchronized with MainThread }
      if not Form1.IsAutoConnect then Log.AddCommunicationMessage('ERROR: Wait timeout', lsError); // do not localize debug
      DebugStr := 'Wait timeout'; // be silent in re-connect mode // do not localize debug
    end;
    { Check for user abort }
    if ThreadSafe.Abort then begin
      ThreadSafe.AbortDetected := True;
      ThreadSafe.Abort := False;
      ErrorOccured := True;
      Log.AddCommunicationMessage('ERROR: Aborted by user', lsError); // do not localize debug
      DebugStr := 'Aborted by user'
    end
    else
      ThreadSafe.AbortDetected := False;
  finally
    { Ok, clear the semafor, allow next commands }
    Screen.Cursor := crDefault;
    ReturnValue := byte(ErrorOccured);
    ThreadSafe.ActiveThread := nil;
    FIsFinished := True;
    ThreadSafe.Busy := False;
    ReleaseSemaphore(WaitCompleteIsBusyEvent,1,nil);
  end;
end;

function TWaitThread.GetLastError: string;
begin
  Result := DebugStr;
end;

function TWaitThread.Get_IsErrorOccur: Boolean;
begin
  Result := ErrorOccured and (GetLastError <> '');
end;

procedure TWaitThread.SendStr(const Str: String);
begin
  FSendingStr := Str;
  Synchronize(DoSendStr);
end;

procedure TWaitThread.DoSendStr;
begin
  if ThreadSafe.ConnectionType = 0 then Form1.WBtSocket.SendStr(FSendingStr)
  else if ThreadSafe.ConnectionType = 1 then Form1.WIrSocket.SendStr(FSendingStr)
  else Form1.ComPort.WriteStr(FSendingStr);
end;

end.

