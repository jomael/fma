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

