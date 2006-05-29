unit uLogObserver;

{
*******************************************************************************
* Descriptions: Log Observer Component
* $Source: /cvsroot/fma/fma/uLogObserver.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uLogObserver.pas,v $
* Revision 1.2.2.2  2005/08/18 20:37:10  z_stoichev
* Fixed Events Log do not change focus when filtered.
* (Was broken since last LordLarry merge with HEAD)
*
* Revision 1.2.2.1  2005/08/17 18:39:11  lordlarry
* - Changed Implementation of Log Classes
*
* Revision 1.3  2005/03/28 18:53:44  lordlarry
* Changed some implementation details of the LogObservers en LogWriters
*
* Revision 1.2  2005/02/12 18:11:31  lordlarry
* Added CVS this header
*
}

interface

uses
  Classes, Messages, uLogger;

type
  TLogBasicObserver = class(TComponent, ILogObserver)
  private
    FHandle: THandle;
    FLog: ILog;
    FMessageID: Cardinal;
    FOnLogChanged: TNotifyEvent;
    FSynchronized: Boolean;
    procedure ClearMessageQueue;
    procedure WndMethod(var Message: TMessage);
    procedure EnableSynchronization;
    procedure DisableSynchronization;
    procedure SetSynchronized(const Value: Boolean);
  protected
    procedure LogChanged;

    procedure DoLogChanged; virtual;
    procedure SetLog(const Value: ILog); virtual;
    procedure SetLogInternal(const Value: ILog);

    procedure Reset; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Log: ILog read FLog write SetLog;

    property Synchronized: Boolean read FSynchronized write SetSynchronized default True;
    property OnLogChanged: TNotifyEvent read FOnLogChanged write FOnLogChanged;
  end;

  TLogItemAddedEvent = procedure(Sender: TObject; const LogItem: ILogItem) of object;

  TLogObserver = class(TLogBasicObserver)
  private
    FLogEnumeration: ILogEnumeration;
    FOnLogItemAdded: TLogItemAddedEvent;
    FOnLogCleared: TNotifyEvent;
    FLastLogItem: ILogItem;
    FOnLogChanging: TNotifyEvent;
    procedure SetLogEnumeration(const Value: ILogEnumeration);
  protected
    procedure SetLog(const Value: ILog); override;

    procedure DoLogChanging; virtual;
    procedure DoLogChanged; override;
    procedure DoLogCleared; virtual;
    procedure DoLogItemAdded(const LogItem: ILogItem); virtual;

    procedure Reset; override;
  published
    property LogEnumeration: ILogEnumeration read FLogEnumeration write SetLogEnumeration;

    property OnLogChanging: TNotifyEvent read FOnLogChanging write FOnLogChanging;
    property OnLogCleared: TNotifyEvent read FOnLogCleared write FOnLogCleared;
    property OnLogItemAdded: TLogItemAddedEvent read FOnLogItemAdded write FOnLogItemAdded;
  end;

implementation

uses
  Windows;

{ TLogBasicObserver }

procedure TLogBasicObserver.ClearMessageQueue;
var Msg: TMsg;
begin
  while PeekMessage(Msg, FHandle, FMessageID, FMessageID, PM_REMOVE) do ;
end;

constructor TLogBasicObserver.Create(AOwner: TComponent);
begin
  inherited;

  EnableSynchronization;
end;

destructor TLogBasicObserver.Destroy;
begin
  Log := nil;

  if FSynchronized then
    DisableSynchronization;

  inherited;
end;

procedure TLogBasicObserver.DisableSynchronization;
begin
  if FSynchronized then begin
    FSynchronized := False;

    if FHandle <> 0 then begin
      Classes.DeallocateHWnd(FHandle);
      FHandle := 0;
    end;

    FMessageID := 0;
  end;
end;

procedure TLogBasicObserver.DoLogChanged;
begin
  if Assigned(FOnLogChanged) then
    FOnLogChanged(Self);
end;

procedure TLogBasicObserver.EnableSynchronization;
begin
  if not FSynchronized then begin
    FSynchronized := True;

    if not (csDesigning in ComponentState) then begin
      FHandle := Classes.AllocateHWnd(WndMethod);
      FMessageID := RegisterWindowMessage(PChar(String(ClassName)));
    end;
  end;
end;

procedure TLogBasicObserver.LogChanged;
begin
  if FSynchronized then
    PostMessage(FHandle, FMessageID, 0, 0)
  else
    DoLogChanged;
end;

procedure TLogBasicObserver.Reset;
begin
end;

procedure TLogBasicObserver.SetLog(const Value: ILog);
begin
  SetLogInternal(Value);
end;

procedure TLogBasicObserver.SetLogInternal(const Value: ILog);
begin
  if FLog <> Value then begin
    if Assigned(FLog) then FLog.UnregisterObserver(Self);

    FLog := Value;

    if Assigned(FLog) then FLog.RegisterObserver(Self);

    if not (csDestroying in ComponentState) then begin
      Reset;

      LogChanged;
    end;
  end;
end;

procedure TLogBasicObserver.SetSynchronized(const Value: Boolean);
begin
  if Value <> FSynchronized then begin
    if Value then
      EnableSynchronization
    else
      DisableSynchronization;
  end;
end;

procedure TLogBasicObserver.WndMethod(var Message: TMessage);
begin
  if Message.Msg = FMessageID then begin
    ClearMessageQueue;

    DoLogChanged;
  end;
end;

procedure TLogObserver.DoLogChanged;
var
  LogItem: ILogItem;
  ItemAdded: Boolean;
begin
  ItemAdded := False;
  try
    if Assigned(FLogEnumeration) then begin
      if Assigned(FLastLogItem) then begin
        if not FLogEnumeration.Contains(FLastLogItem) then begin // It must have been Cleared
          ItemAdded := True;
          DoLogChanging;
          Reset;
          DoLogCleared;
          LogItem := FLogEnumeration.First;
        end
        else
          LogItem := FLogEnumeration.Next(FLastLogItem);
      end
      else
        LogItem := FLogEnumeration.First;

      while Assigned(LogItem) do begin
        if FLogEnumeration.Contains(LogItem) then begin
          if not ItemAdded then begin
            ItemAdded := True;
            DoLogChanging;
          end;
          DoLogItemAdded(LogItem);
        end;

        FLastLogItem := LogItem;
        LogItem := FLogEnumeration.Next(LogItem);
      end;
    end;
  finally
    if ItemAdded then
      inherited DoLogChanged;
  end;
end;

procedure TLogObserver.DoLogChanging;
begin
  if Assigned(FOnLogChanging) then
    FOnLogChanging(Self);
end;

procedure TLogObserver.DoLogCleared;
begin
  if Assigned(FOnLogCleared) then
    FOnLogCleared(Self);
end;

procedure TLogObserver.DoLogItemAdded(const LogItem: ILogItem);
begin
  if Assigned(FOnLogItemAdded) then
    FOnLogItemAdded(Self, LogItem);
end;

procedure TLogObserver.Reset;
begin
  inherited;

  FLastLogItem := nil;
end;

procedure TLogObserver.SetLog(const Value: ILog);
begin
  if Assigned(Value) then
    FLogEnumeration := Value.GetEnumeration
  else
    FLogEnumeration := nil;

  inherited;
end;

procedure TLogObserver.SetLogEnumeration(const Value: ILogEnumeration);
begin
  FLogEnumeration := Value;

  if Assigned(FLogEnumeration) then
    SetLogInternal(FLogEnumeration.Log)
  else
    SetLogInternal(nil);

  if not (csDestroying in ComponentState) then begin
    Reset;

    LogChanged;
  end;
end;

end.
