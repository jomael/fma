unit uLogObserverWriter;

{
*******************************************************************************
* Descriptions: Class to Write the Log Directly to a File
* $Source: /cvsroot/fma/fma/uLogObserverWriter.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uLogObserverWriter.pas,v $
* Revision 1.2  2005/03/28 20:23:15  lordlarry
* Fixed it to be thread safe
*
* Revision 1.1  2005/03/28 18:51:57  lordlarry
* Added a parameter /Log which lets FMA write the log directly to disk
*
*
}

interface

uses
  Classes, uLogger, uLogObserver, uLogWriters, SyncObjs;

type
  TLogObserverWriter = class(TObject)
  private
    FLogObserver: TLogObserver;
    FFileName: String;
    FLogWriterEngine: ILogWriterEngine;
    FStream: TFileStream;
    FCriticalSection: TCriticalSection;
    procedure LogItemAdded(Sender: TObject; const LogItem: ILogItem);
    procedure SetFileName(const Value: String);
    procedure SetLogEnumeration(const Value: ILogEnumeration);
    function GetLogEnumeration: ILogEnumeration;
  public
    constructor Create;
    destructor Destroy; override;

    property LogEnumeration: ILogEnumeration read GetLogEnumeration write SetLogEnumeration;
    property LogWriterEngine: ILogWriterEngine read FLogWriterEngine write FLogWriterEngine;
    property FileName: String read FFileName write SetFileName;
  end;

implementation

uses
  SysUtils, Windows;

{ TLogObserverWriter }

constructor TLogObserverWriter.Create;
begin
  inherited;

  FCriticalSection := TCriticalSection.Create;

  FLogObserver := TLogObserver.Create(nil);
  FLogObserver.Synchronized := False;
  FLogObserver.OnLogItemAdded := LogItemAdded;
end;

destructor TLogObserverWriter.Destroy;
begin
  FLogObserver.Free;

  if Assigned(FStream) then
    FreeAndNil(FStream);

  FCriticalSection.Free;

  inherited;
end;

function TLogObserverWriter.GetLogEnumeration: ILogEnumeration;
begin
  Result := FLogObserver.LogEnumeration;
end;

procedure TLogObserverWriter.LogItemAdded(Sender: TObject; const LogItem: ILogItem);
begin
  if Assigned(FLogWriterEngine) then begin
    FCriticalSection.Acquire;
    try
      FLogWriterEngine.WriteItem(FStream, LogItem);

      FlushFileBuffers(FStream.Handle);
    finally
      FCriticalSection.Release;
    end;
  end;
end;

procedure TLogObserverWriter.SetFileName(const Value: String);
begin
  if FFileName <> Value then begin
    FFileName := Value;

    if Assigned(FStream) then
      FreeAndNil(FStream);

    FStream := TFileStream.Create(CreateFile(PChar(FFileName), GENERIC_WRITE, FILE_SHARE_READ, nil, CREATE_ALWAYS, FILE_FLAG_WRITE_THROUGH, 0));
  end;
end;

procedure TLogObserverWriter.SetLogEnumeration(const Value: ILogEnumeration);
begin
  FLogObserver.LogEnumeration := Value;
end;

end.
