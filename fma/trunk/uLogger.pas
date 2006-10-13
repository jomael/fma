unit uLogger;

{
*******************************************************************************
* Descriptions: Logger interfaces and implementation
* $Source: /cvsroot/fma/fma/uLogger.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uLogger.pas,v $
*
}

interface

uses
  Classes, SysUtils;

type
  TLogSeverity = (lsInformation, lsWarning, lsError, lsDebug);
  TLogSeverities = set of TLogSeverity;

  TLogCategory = (lcDefault, lcCommunication, lcSynchronization, lcScript);
  TLogCategories = set of TLogCategory;

const
  ALL_LOG_SEVERITIES = [lsInformation, lsWarning, lsError, lsDebug];
  ALL_LOG_CATEGORIES = [lcDefault, lcCommunication, lcSynchronization, lcScript];

type
  ILog = interface;

  ILogItem = interface
  ['{15C9713B-6002-4AA3-97FA-DD167491A0C6}']
    function GetIndex: Integer;
    function GetDateTime: TDateTime;
    function GetSeverity: TLogSeverity;
    function GetCategory: TLogCategory;
    function GetMessage: WideString;

    function SameAs(Item: ILogItem): Boolean;

    property Index: Integer read GetIndex;
    property DateTime: TDateTime read GetDateTime;
    property Severity: TLogSeverity read GetSeverity;
    property Category: TLogCategory read GetCategory;
    property Message: WideString read GetMessage;
  end;

  ILogEnumeration = interface
  ['{863DB63C-630D-4954-81DB-73625DE6C2B6}']
    function First: ILogItem;
    function Last: ILogItem;
    function Next(const Item: ILogItem): ILogItem;
    function Previous(const Item: ILogItem): ILogItem;

    function Contains(const Item: ILogItem): Boolean;
    function Log: ILog; 
  end;

  ILogObserver = interface
  ['{2CF9421E-DA76-40A5-AB29-725243F0AD91}']
    procedure LogChanged;
  end;

  ILog = interface
  ['{F66C2697-86CE-4562-8BCA-297656A48AD2}']
    procedure AddMessage(const Message: WideString; Severity: TLogSeverity = lsInformation; Category: TLogCategory = lcDefault);
    procedure AddMessageFmt(const Message: WideString; const Args: array of const; Severity: TLogSeverity = lsInformation; Category: TLogCategory = lcDefault);
    procedure AddCommunicationMessage(const Message: WideString; Severity: TLogSeverity = lsInformation);
    procedure AddCommunicationMessageFmt(const Message: WideString; const Args: array of const; Severity: TLogSeverity = lsInformation);
    procedure AddSynchronizationMessage(const Message: WideString; Severity: TLogSeverity = lsInformation);
    procedure AddSynchronizationMessageFmt(const Message: WideString; const Args: array of const; Severity: TLogSeverity = lsInformation);
    procedure AddScriptMessage(const Message: WideString; Severity: TLogSeverity = lsInformation);
    procedure AddScriptMessageFmt(const Message: WideString; const Args: array of const; Severity: TLogSeverity = lsInformation);

    function GetEnumeration(Severities: TLogSeverities = ALL_LOG_SEVERITIES; Categories: TLogCategories = ALL_LOG_CATEGORIES): ILogEnumeration;

    procedure Clear;

    procedure RegisterObserver(const Observer: ILogObserver);
    procedure UnregisterObserver(const Observer: ILogObserver);
  end;

var
  Log: ILog;

function CreateLog: ILog;

function LogSeverityToString(Severity: TLogSeverity): String;
function LogCategoryToString(Category: TLogCategory): String;

implementation


type
  TLogItem = record
    Index: Integer;
    DateTime: TDateTime;
    Severity: TLogSeverity;
    Category: TLogCategory;
    Message: WideString;
  end;
  PLogItem = ^TLogItem;

  TLog = class(TInterfacedObject, ILog)
  private
    FItems: TList;
    FItemsSynchronizer: TMultiReadExclusiveWriteSynchronizer;
    FObservers: TInterfaceList;
    FObserversSynchronizer: TMultiReadExclusiveWriteSynchronizer;
    function GetCount: Integer;
    function GetItem(Index: Integer): PLogItem;
  protected
    property Count: Integer read GetCount;
    property Items[Index: Integer]: PLogItem read GetItem;
    procedure BeginRead;
    procedure EndRead;
    procedure NotifyObserversLogChanged;
  public
    constructor Create;
    destructor Destroy; override;

    procedure AddMessage(const Message: WideString; Severity: TLogSeverity = lsInformation; Category: TLogCategory = lcDefault);
    procedure AddMessageFmt(const Message: WideString; const Args: array of const; Severity: TLogSeverity = lsInformation; Category: TLogCategory = lcDefault);
    procedure AddCommunicationMessage(const Message: WideString; Severity: TLogSeverity = lsInformation);
    procedure AddCommunicationMessageFmt(const Message: WideString; const Args: array of const; Severity: TLogSeverity = lsInformation);
    procedure AddSynchronizationMessage(const Message: WideString; Severity: TLogSeverity = lsInformation);
    procedure AddSynchronizationMessageFmt(const Message: WideString; const Args: array of const; Severity: TLogSeverity = lsInformation);
    procedure AddScriptMessage(const Message: WideString; Severity: TLogSeverity = lsInformation);
    procedure AddScriptMessageFmt(const Message: WideString; const Args: array of const; Severity: TLogSeverity = lsInformation);

    function GetEnumeration(Severities: TLogSeverities = ALL_LOG_SEVERITIES; Categories: TLogCategories = ALL_LOG_CATEGORIES): ILogEnumeration;

    procedure Clear;

    procedure RegisterObserver(const Observer: ILogObserver);
    procedure UnregisterObserver(const Observer: ILogObserver);
  end;

  TLogEnumeration = class(TInterfacedObject, ILogEnumeration)
  private
    FLog: TLog;
    FSeverities: TLogSeverities;
    FCategories: TLogCategories;
  protected
    function CreateLogItem(Item: PLogItem): ILogItem;
    function IsInFilter(Item: PLogItem): Boolean; virtual;
    function NextItemInFilter(Item: PLogItem): PLogItem;
    function PreviousItemInFilter(Item: PLogItem): PLogItem;
    function IsFiltered: Boolean;
  public
    constructor Create(ALog: TLog; ASeverities: TLogSeverities = ALL_LOG_SEVERITIES; ACategories: TLogCategories = ALL_LOG_CATEGORIES);

    function First: ILogItem;
    function Last: ILogItem;
    function Next(const Item: ILogItem): ILogItem;
    function Previous(const Item: ILogItem): ILogItem;

    function Contains(const Item: ILogItem): Boolean;
    function Log: ILog;
  end;

  TLogItemClass = class(TInterfacedObject, ILogItem)
  private
    FIndex: Integer;
    FDateTime: TDateTime;
    FSeverity: TLogSeverity;
    FCategory: TLogCategory;
    FMessage: WideString;

    function GetIndex: Integer;
  protected
    function GetDateTime: TDateTime;
    function GetSeverity: TLogSeverity;
    function GetCategory: TLogCategory;
    function GetMessage: WideString;
  public
    constructor Create(Item: PLogItem);

    function SameAs(Item: ILogItem): Boolean;
    
    property Index: Integer read GetIndex;
    property DateTime: TDateTime read GetDateTime;
    property Severity: TLogSeverity read GetSeverity;
    property Category: TLogCategory read GetCategory;
    property Message: WideString read GetMessage;
  end;

{ Global }

function CreateLog: ILog;
begin
  Result := TLog.Create;
end;

resourcestring
  SCategoryDefault = 'Default';
  SCategoryCommunication = 'Communication';
  SCategorySynchronization = 'Synchronization';
  SCategoryScript = 'Script';
  SCategoryUnknown = 'Unknown';

function LogCategoryToString(Category: TLogCategory): String;
begin
  case Category of
    lcDefault: Result := SCategoryDefault;
    lcCommunication: Result := SCategoryCommunication;
    lcSynchronization: Result := SCategorySynchronization;
    lcScript: Result := SCategoryScript;
    else Result := SCategoryUnknown;
  end;
end;

resourcestring
  SSeverityInformation = 'Information';
  SSeverityWarning = 'Warning';
  SSeverityError = 'Error';
  SSeverityDebug = 'Debug';
  SSeverityUnknown = 'Uknown';

function LogSeverityToString(Severity: TLogSeverity): String;
begin
  case Severity of
    lsInformation: Result := SSeverityInformation;
    lsWarning: Result := SSeverityWarning;
    lsError: Result := SSeverityError;
    lsDebug: Result := SSeverityDebug;
    else Result := SSeverityUnknown;
  end;
end;

{ TLog }

procedure TLog.AddSynchronizationMessage(const Message: WideString; Severity: TLogSeverity);
begin
  AddMessage(Message, Severity, lcSynchronization);
end;

procedure TLog.AddSynchronizationMessageFmt(const Message: WideString; const Args: array of const; Severity: TLogSeverity);
begin
  AddSynchronizationMessage(WideFormat(Message, Args), Severity);
end;

procedure TLog.AddMessage(const Message: WideString; Severity: TLogSeverity; Category: TLogCategory);
var
  Item: PLogItem;
  Index: Integer;
begin
  FItemsSynchronizer.BeginWrite;
  try
    New(Item);
    Index := FItems.Add(Item);

    Item.Index := Index;
    Item.DateTime := Now;
    Item.Severity := Severity;
    Item.Category := Category;
    Item.Message := Message;
  finally
    FItemsSynchronizer.EndWrite;
  end;

  NotifyObserversLogChanged;
end;

procedure TLog.AddMessageFmt(const Message: WideString; const Args: array of const; Severity: TLogSeverity; Category: TLogCategory);
begin
  AddMessage(WideFormat(Message, Args), Severity, Category);
end;

procedure TLog.AddCommunicationMessage(const Message: WideString; Severity: TLogSeverity);
begin
  AddMessage(Message, Severity, lcCommunication);
end;

procedure TLog.AddCommunicationMessageFmt(const Message: WideString; const Args: array of const; Severity: TLogSeverity);
begin
  AddCommunicationMessage(WideFormat(Message, Args), Severity);
end;

procedure TLog.AddScriptMessage(const Message: WideString; Severity: TLogSeverity);
begin
  AddMessage(Message, Severity, lcScript);
end;

procedure TLog.AddScriptMessageFmt(const Message: WideString; const Args: array of const; Severity: TLogSeverity);
begin
  AddScriptMessage(WideFormat(Message, Args), Severity);
end;

constructor TLog.Create;
begin
  inherited;

  FItems := TList.Create;
  FItems.Capacity := 100;
  FItemsSynchronizer := TMultiReadExclusiveWriteSynchronizer.Create;

  FObservers := TInterfaceList.Create;
  FObserversSynchronizer := TMultiReadExclusiveWriteSynchronizer.Create;
end;

destructor TLog.Destroy;
begin
  Clear;
  FItems.Free;
  FItemsSynchronizer.Free;

  FObservers.Free;
  FObserversSynchronizer.Free;
  
  inherited;
end;

procedure TLog.Clear;
var
  Item: PLogItem;
  I: Integer;
begin
  FItemsSynchronizer.BeginWrite;
  try
    for I := 0 to FItems.Count - 1 do begin
      Item := FItems[I];
      Dispose(Item);
    end;

    FItems.Clear;
  finally
    FItemsSynchronizer.EndWrite;
  end;

  NotifyObserversLogChanged;
end;

function TLog.GetEnumeration(Severities: TLogSeverities; Categories: TLogCategories): ILogEnumeration;
begin
  Result := TLogEnumeration.Create(Self, Severities, Categories);
end;

function TLog.GetCount: Integer;
begin
  // Not thread safe! Use BeginRead/EndRead.
  Result := FItems.Count;
end;

function TLog.GetItem(Index: Integer): PLogItem;
begin
  // Not thread safe! Use BeginRead/EndRead.
  Result := FItems[Index];
end;

procedure TLog.BeginRead;
begin
  FItemsSynchronizer.BeginRead;
end;

procedure TLog.EndRead;
begin
  FItemsSynchronizer.EndRead;
end;

procedure TLog.RegisterObserver(const Observer: ILogObserver);
begin
  { TODO : Maybe should move to the LogEnumeration? }
  FObserversSynchronizer.BeginWrite;
  try
    FObservers.Add(Observer);
  finally
    FObserversSynchronizer.EndWrite;
  end;
end;

procedure TLog.UnregisterObserver(const Observer: ILogObserver);
begin
  FObserversSynchronizer.BeginWrite;
  try
    FObservers.Remove(Observer);
  finally
    FObserversSynchronizer.EndWrite;
  end;
end;

procedure TLog.NotifyObserversLogChanged;
var I: Integer;
begin
  FObserversSynchronizer.BeginRead;
  try
    for I := 0 to FObservers.Count - 1 do
      (FObservers[I] as ILogObserver).LogChanged;
  finally
    FObserversSynchronizer.EndRead;
  end;
end;

{ TLogEnumeration }

constructor TLogEnumeration.Create(ALog: TLog; ASeverities: TLogSeverities; ACategories: TLogCategories);
begin
  inherited Create;

  FLog := ALog;
  FSeverities := ASeverities;
  FCategories := ACategories;
end;

function TLogEnumeration.Last: ILogItem;
var
  Item: PLogItem;
begin
  FLog.BeginRead;
  try
    if FLog.Count > 0 then begin
      Item := FLog.Items[FLog.Count - 1];
      if not IsInFilter(Item) then
        Item := PreviousItemInFilter(Item);
    end
    else
      Item := nil;

    if Assigned(Item) then
      Result := CreateLogItem(Item)
    else
      Result := nil;
  finally
    FLog.EndRead;
  end;
end;

function TLogEnumeration.Previous(const Item: ILogItem): ILogItem;
var
  CurrentItem: PLogItem;
begin
  FLog.BeginRead;
  try
    Result := nil;
    
    if Assigned(Item) then begin
      if Item.Index < FLog.Count then begin
        CurrentItem := PreviousItemInFilter(FLog.Items[Item.Index]);
        if Assigned(CurrentItem) then
          Result := CreateLogItem(CurrentItem);
      end;
    end;
  finally
    FLog.EndRead;
  end;
end;

function TLogEnumeration.First: ILogItem;
var
  Item: PLogItem;
begin
  FLog.BeginRead;
  try
    if FLog.Count > 0 then begin
      Item := FLog.Items[0];
      if not IsInFilter(Item) then
        Item := NextItemInFilter(Item);
    end
    else
      Item := nil;

    if Assigned(Item) then
      Result := CreateLogItem(Item)
    else
      Result := nil;
  finally
    FLog.EndRead;
  end;
end;

function TLogEnumeration.Next(const Item: ILogItem): ILogItem;
var
  CurrentItem: PLogItem;
begin
  FLog.BeginRead;
  try
    Result := nil;

    if Assigned(Item) then begin
      if Item.Index < FLog.Count then begin
        CurrentItem := NextItemInFilter(FLog.Items[Item.Index]);
        if Assigned(CurrentItem) then
          Result := CreateLogItem(CurrentItem);
      end;
    end;
  finally
    FLog.EndRead;
  end;
end;

function TLogEnumeration.CreateLogItem(Item: PLogItem): ILogItem;
begin
  Result := TLogItemClass.Create(Item);
end;

function TLogEnumeration.IsInFilter(Item: PLogItem): Boolean;
begin
  Result := (Item.Severity in FSeverities) and (Item.Category in FCategories);
end;

function TLogEnumeration.PreviousItemInFilter(Item: PLogItem): PLogItem;
var
  Index: Integer;
begin
  Result := nil;

  Index := Item.Index - 1;
  while Index >= 0 do begin
    Item := FLog.Items[Index];

    if IsInFilter(Item) then begin
      Result := Item;
      Break;
    end;

    Dec(Index);
  end;
end;

function TLogEnumeration.NextItemInFilter(Item: PLogItem): PLogItem;
var
  Index: Integer;
begin
  Result := nil;

  Index := Item.Index + 1;
  while Index < FLog.Count do begin
    Item := FLog.Items[Index];

    if IsInFilter(Item) then begin
      Result := Item;
      Break;
    end;

    Inc(Index);
  end;
end;

function TLogEnumeration.IsFiltered: Boolean;
begin
  Result := not (FSeverities = ALL_LOG_SEVERITIES) and not (FCategories = ALL_LOG_CATEGORIES);
end;

function TLogEnumeration.Contains(const Item: ILogItem): Boolean;
var
  Index: Integer;
  CurrentItem: PLogItem;
begin
  FLog.BeginRead;
  try
    Result := False;

    if Assigned(Item) then begin
      Index := Item.Index;

      if Index < FLog.Count then begin
        CurrentItem := FLog.Items[Index];

        Result := IsInFilter(CurrentItem) and Item.SameAs(CreateLogItem(CurrentItem));
      end;
    end;
  finally
    FLog.EndRead;
  end;
end;

function TLogEnumeration.Log: ILog;
begin
  Result := FLog;
end;

{ TLogItemClass }

constructor TLogItemClass.Create(Item: PLogItem);
begin
  inherited Create;

  FIndex := Item.Index;
  FDateTime := Item.DateTime;
  FSeverity := Item.Severity;
  FCategory := Item.Category;
  FMessage := Item.Message;
end;

function TLogItemClass.GetDateTime: TDateTime;
begin
  Result := FDateTime;
end;

function TLogItemClass.GetCategory: TLogCategory;
begin
  Result := FCategory;
end;

function TLogItemClass.GetSeverity: TLogSeverity;
begin
  Result := FSeverity;
end;

function TLogItemClass.GetMessage: WideString;
begin
  Result := FMessage;
end;

function TLogItemClass.GetIndex: Integer;
begin
  Result := FIndex;
end;

function TLogItemClass.SameAs(Item: ILogItem): Boolean;
begin
  Result := Assigned(Item) and (Index = Item.Index) and (Severity = Item.Severity) and (Category = Item.Category) and
    (WideCompareText(Message,Item.Message) = 0); // ignore DateTime?
end;

initialization
  Log := CreateLog;
finalization
  Log := nil;
end.
