unit uThreadSafe;

{
*******************************************************************************
* Descriptions: ThreadSafe Component
* $Source: /cvsroot/fma/fma/uThreadSafe.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uThreadSafe.pas,v $
* Revision 1.3  2005/03/01 12:03:54  z_stoichev
* MSec is cardinal
*
* Revision 1.2  2005/02/28 20:05:53  lordlarry
* Fixed a time out bug which occured after making the code thread safe
*
* Revision 1.1  2005/02/24 21:30:43  lordlarry
* Added a better (but ugly) method to make the TWaitThread code threadsafe. All data that is accessed outside of the class goes through the ThreadSafe object which does the locking.
*
*
}

interface

uses
  SyncObjs, Classes, uWaitComplete;

type
  TThreadSafeStrings = class;
  
  TThreadSafe = class
  private
    FCriticalSection: TCriticalSection;
    FRXBuffer: TThreadSafeStrings;
    FBusy: Boolean;
    FWaitingOK: Boolean;
    FWaitStr: String;
    FLastCommand: String;
    FActiveThread: TWaitThread;
    FAbort: Boolean;
    FAbortDetected: Boolean;
    FAlreadyInUseObex: Boolean;
    FObexConnecting: Boolean;
    FDoCharConvertion: Boolean;
    FInactivityTimeout: Cardinal;
    FConnectionType: Integer;
    FTimedout: Boolean;
    FLastMessageStore: String;
    FMSec: Cardinal;

    function GetActiveThread: TWaitThread;
    function GetBusy: Boolean;
    function GetLastCommand: String;
    function GetWaitingOK: Boolean;
    function GetWaitStr: String;
    procedure SetActiveThread(const Value: TWaitThread);
    procedure SetBusy(const Value: Boolean);
    procedure SetLastCommand(const Value: String);
    procedure SetWaitingOK(const Value: Boolean);
    procedure SetWaitStr(const Value: String);
    function GetAbort: Boolean;
    procedure SetAbort(const Value: Boolean);
    function GetAbortDetected: Boolean;
    procedure SetAbortDetected(const Value: Boolean);
    function GetAlreadyInUseObex: Boolean;
    procedure SetAlreadyInUseObex(const Value: Boolean);
    function GetObexConnecting: Boolean;
    procedure SetObexConnecting(const Value: Boolean);
    function GetDoCharConvertion: Boolean;
    procedure SetDoCharConvertion(const Value: Boolean);
    function GetInactivityTimeout: Cardinal;
    procedure SetInactivityTimeout(const Value: Cardinal);
    function GetConnectionType: Integer;
    procedure SetConnectionType(const Value: Integer);
    function GetTimedout: Boolean;
    procedure SetTimedout(const Value: Boolean);
    function GetLastMessageStore: String;
    procedure SetLastMessageStore(const Value: String);
    function GetMSec: Cardinal;
    procedure SetMSec(const Value: Cardinal);
  public
    constructor Create;
    destructor Destroy; override;

    property Busy: Boolean read GetBusy write SetBusy;
    property WaitingOK: Boolean read GetWaitingOK write SetWaitingOK;
    property WaitStr: String read GetWaitStr write SetWaitStr;
    property LastCommand: String read GetLastCommand write SetLastCommand;
    property ActiveThread: TWaitThread read GetActiveThread write SetActiveThread;
    property Abort: Boolean read GetAbort write SetAbort;
    property AbortDetected: Boolean read GetAbortDetected write SetAbortDetected;
    property AlreadyInUseObex: Boolean read GetAlreadyInUseObex write SetAlreadyInUseObex;
    property ObexConnecting: Boolean read GetObexConnecting write SetObexConnecting;
    property DoCharConvertion: Boolean read GetDoCharConvertion write SetDoCharConvertion;
    property RXBuffer: TThreadSafeStrings read FRXBuffer;
    property InactivityTimeout: Cardinal read GetInactivityTimeout write SetInactivityTimeout;
    property ConnectionType: Integer read GetConnectionType write SetConnectionType;
    property Timedout: Boolean read GetTimedout write SetTimedout;
    property LastMessageStore: String read GetLastMessageStore write SetLastMessageStore;
    property MSec: Cardinal read GetMSec write SetMSec;

    procedure Lock;
    procedure Unlock;
  end;

  TThreadSafeStrings = class
  private
    FCriticalSection: TCriticalSection;
    FStrings: TStrings;
    function GetString(Index: Integer): String;
    procedure SetString(Index: Integer; const Value: String);
    function GetText: String;
    procedure SetText(const Value: String);
    function GetCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    property Strings[Index: Integer]: String read GetString write SetString; default;
    procedure Clear;
    property Text: String read GetText write SetText;
    property Count: Integer read GetCount;
    function Add(const S: string): Integer;

    procedure Lock;
    procedure Unlock;
  end;

var
  ThreadSafe: TThreadSafe = nil;

implementation

uses
  Unit1;

{ TThreadSafe }

constructor TThreadSafe.Create;
begin
  inherited;

  FCriticalSection := TCriticalSection.Create;
  FRXBuffer := TThreadSafeStrings.Create;
end;

destructor TThreadSafe.Destroy;
begin
  FRXBuffer.Free;
  FCriticalSection.Free;

  inherited;
end;

function TThreadSafe.GetAbort: Boolean;
begin
  Lock;
  try
    Result := FAbort;
  finally
    Unlock;
  end;
end;

function TThreadSafe.GetAbortDetected: Boolean;
begin
  Lock;
  try
    Result := FAbortDetected;
  finally
    Unlock;
  end;
end;

function TThreadSafe.GetActiveThread: TWaitThread;
begin
  Lock;
  try
    Result := FActiveThread;
  finally
    Unlock;
  end;
end;

function TThreadSafe.GetAlreadyInUseObex: Boolean;
begin
  Lock;
  try
    Result := FAlreadyInUseObex;
  finally
    Unlock;
  end;
end;

function TThreadSafe.GetBusy: Boolean;
begin
  Lock;
  try
    Result := FBusy;
  finally
    Unlock;
  end;
end;

function TThreadSafe.GetConnectionType: Integer;
begin
  Lock;
  try
    Result := FConnectionType;
  finally
    Unlock;
  end;
end;

function TThreadSafe.GetDoCharConvertion: Boolean;
begin
  Lock;
  try
    Result := FDoCharConvertion;
  finally
    Unlock;
  end;
end;

function TThreadSafe.GetInactivityTimeout: Cardinal;
begin
  Lock;
  try
    Result := FInactivityTimeout;
  finally
    Unlock;
  end;
end;

function TThreadSafe.GetLastCommand: String;
begin
  Lock;
  try
    Result := FLastCommand;
  finally
    Unlock;
  end;
end;

function TThreadSafe.GetLastMessageStore: String;
begin
  Lock;
  try
    Result := FLastMessageStore;
  finally
    Unlock;
  end;
end;

function TThreadSafe.GetMSec: Cardinal;
begin
  Lock;
  try
    Result := FMSec;
  finally
    Unlock;
  end;
end;

function TThreadSafe.GetObexConnecting: Boolean;
begin
  Lock;
  try
    Result := FObexConnecting;
  finally
    Unlock;
  end;
end;

function TThreadSafe.GetTimedout: Boolean;
begin
  Lock;
  try
    Result := FTimedout;
  finally
    Unlock;
  end;
end;

function TThreadSafe.GetWaitingOK: Boolean;
begin
  Lock;
  try
    Result := FWaitingOK;
  finally
    Unlock;
  end;
end;

function TThreadSafe.GetWaitStr: String;
begin
  Lock;
  try
    Result := FWaitStr;
  finally
    Unlock;
  end;
end;

procedure TThreadSafe.Lock;
begin
  FCriticalSection.Acquire;
end;

procedure TThreadSafe.SetAbort(const Value: Boolean);
begin
  Lock;
  try
    FAbort := Value;
  finally
    Unlock;
  end;
end;

procedure TThreadSafe.SetAbortDetected(const Value: Boolean);
begin
  Lock;
  try
    FAbortDetected := Value;
  finally
    Unlock;
  end;
end;

procedure TThreadSafe.SetActiveThread(const Value: TWaitThread);
begin
  Lock;
  try
    FActiveThread := Value;
  finally
    Unlock;
  end;
end;

procedure TThreadSafe.SetAlreadyInUseObex(const Value: Boolean);
begin
  Lock;
  try
    FAlreadyInUseObex := Value;
  finally
    Unlock;
  end;
end;

procedure TThreadSafe.SetBusy(const Value: Boolean);
begin
  Lock;
  try
    FBusy := Value;
  finally
    Unlock;
  end;
end;

procedure TThreadSafe.SetConnectionType(const Value: Integer);
begin
  Lock;
  try
    FConnectionType := Value;
  finally
    Unlock;
  end;
end;

procedure TThreadSafe.SetDoCharConvertion(const Value: Boolean);
begin
  Lock;
  try
    FDoCharConvertion := Value;
  finally
    Unlock;
  end;
end;

procedure TThreadSafe.SetInactivityTimeout(const Value: Cardinal);
begin
  Lock;
  try
    FInactivityTimeout := Value;
  finally
    Unlock;
  end;
end;

procedure TThreadSafe.SetLastCommand(const Value: String);
begin
  Lock;
  try
    FLastCommand := Value;
  finally
    Unlock;
  end;
end;

procedure TThreadSafe.SetLastMessageStore(const Value: String);
begin
  Lock;
  try
    FLastMessageStore := Value;
  finally
    Unlock;
  end;
end;

procedure TThreadSafe.SetMSec(const Value: Cardinal);
begin
  Lock;
  try
    FMSec := Value;
  finally
    Unlock;
  end;
end;

procedure TThreadSafe.SetObexConnecting(const Value: Boolean);
begin
  Lock;
  try
    FObexConnecting := Value;
  finally
    Unlock;
  end;
end;

procedure TThreadSafe.SetTimedout(const Value: Boolean);
begin
  Lock;
  try
    FTimedout := Value;
  finally
    Unlock;
  end;
end;

procedure TThreadSafe.SetWaitingOK(const Value: Boolean);
begin
  Lock;
  try
    FWaitingOK := Value;
  finally
    Unlock;
  end;
end;

procedure TThreadSafe.SetWaitStr(const Value: String);
begin
  Lock;
  try
    FWaitStr := Value;
  finally
    Unlock;
  end;
end;

procedure TThreadSafe.Unlock;
begin
  FCriticalSection.Release;
end;

{ TThreadSafeStrings }

function TThreadSafeStrings.Add(const S: string): Integer;
begin
  Lock;
  try
    Result := FStrings.Add(S);
  finally
    Unlock;
  end;
end;

procedure TThreadSafeStrings.Clear;
begin
  Lock;
  try
    FStrings.Clear;
  finally
    Unlock;
  end;
end;

constructor TThreadSafeStrings.Create;
begin
  inherited;

  FCriticalSection := TCriticalSection.Create;
  FStrings := TStringList.Create;
end;

destructor TThreadSafeStrings.Destroy;
begin
  FStrings.Free;
  FCriticalSection.Free;

  inherited;
end;

function TThreadSafeStrings.GetCount: Integer;
begin
  Lock;
  try
    Result := FStrings.Count;
  finally
    Unlock;
  end;
end;

function TThreadSafeStrings.GetString(Index: Integer): String;
begin
  Lock;
  try
    Result := FStrings[Index];
  finally
    Unlock;
  end;
end;

function TThreadSafeStrings.GetText: String;
begin
  Lock;
  try
    Result := FStrings.Text;
  finally
    Unlock;
  end;
end;

procedure TThreadSafeStrings.Lock;
begin
  FCriticalSection.Acquire;
end;

procedure TThreadSafeStrings.SetString(Index: Integer; const Value: String);
begin
  Lock;
  try
    FStrings[Index] := Value;
  finally
    Unlock;
  end;
end;

procedure TThreadSafeStrings.SetText(const Value: String);
begin
  Lock;
  try
    FStrings.Text := Value;
  finally
    Unlock;
  end;
end;

procedure TThreadSafeStrings.Unlock;
begin
  FCriticalSection.Release;
end;

initialization
  ThreadSafe := TThreadSafe.Create;
finalization
  ThreadSafe.Free;
end.
