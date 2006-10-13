unit uLogWriters;

{
*******************************************************************************
* Descriptions: Log Writer Classes
* $Source: /cvsroot/fma/fma/uLogWriters.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uLogWriters.pas,v $
*
}

interface

uses
  uLogger, Classes;

type
  ILogWriterEngine = interface
    procedure WriteHeader(Stream: TStream);
    procedure WriteItem(Stream: TStream; const Item: ILogItem);
    procedure WriteStr(Stream: TStream; const Str: WideString);
    procedure WriteFooter(Stream: TStream);
  end;

  TLogWriter = class
  private
    FLogEnumeration: ILogEnumeration;
    FLogWriterEngine: ILogWriterEngine;
  public
    constructor Create(const ALogEnumeration: ILogEnumeration = nil);

    procedure ToStream(Stream: TStream);

    property LogEnumeration: ILogEnumeration read FLogEnumeration write FLogEnumeration;
    property LogWriterEngine: ILogWriterEngine read FLogWriterEngine write FLogWriterEngine;
  end;

  TLogTextWriterEngine = class(TInterfacedObject, ILogWriterEngine)
  public
    procedure WriteHeader(Stream: TStream); virtual;
    procedure WriteItem(Stream: TStream; const Item: ILogItem);
    procedure WriteStr(Stream: TStream; const Str: WideString);
    procedure WriteFooter(Stream: TStream); virtual;
  end;

  TLogTextWriterEngineWithBOM = class(TLogTextWriterEngine)
  public
    procedure WriteHeader(AStream: TStream); override;
  end;

implementation

uses
  SysUtils;

{ TLogWriter }

constructor TLogWriter.Create(const ALogEnumeration: ILogEnumeration);
begin
  inherited Create;

  FLogEnumeration := ALogEnumeration;
end;

procedure TLogWriter.ToStream(Stream: TStream);
var LogItem: ILogItem;
begin
  if Assigned(FLogWriterEngine) then begin
    FLogWriterEngine.WriteHeader(Stream);

    LogItem := FLogEnumeration.First;
    while Assigned(LogItem) do begin
      FLogWriterEngine.WriteItem(Stream, LogItem);

      LogItem := FLogEnumeration.Next(LogItem);
    end;

    FLogWriterEngine.WriteFooter(Stream);
  end;
end;

{ TLogTextWriterEngine }

procedure TLogTextWriterEngine.WriteFooter(Stream: TStream);
begin
end;

procedure TLogTextWriterEngine.WriteHeader(Stream: TStream);
begin
end;

procedure TLogTextWriterEngine.WriteItem(Stream: TStream; const Item: ILogItem);
var
  Msg: WideString;
begin
  { TODO : Write other fields to the file, like severity and category }

  Msg := FormatDateTime('hh":"nn":"ss":"zzz', Item.DateTime);
  Msg := Msg + ': ' + Item.Message;

  WriteStr(Stream, Msg);
end;

procedure TLogTextWriterEngine.WriteStr(Stream: TStream; const Str: WideString);
var
  Msg: WideString;
begin
  Msg := Str + sLinebreak;
  Stream.Write(Msg[1], Length(Msg) * 2);
end;

procedure TLogTextWriterEngineWithBOM.WriteHeader(AStream: TStream);
const BOM: Word = $FEFF;
begin
  AStream.Write(BOM, SizeOf(Word));
end;

end.
