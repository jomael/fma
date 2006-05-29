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
* Revision 1.8.2.1  2005/08/17 18:39:11  lordlarry
* - Changed Implementation of Log Classes
*
* Revision 1.9  2005/03/28 18:53:44  lordlarry
* Changed some implementation details of the LogObservers en LogWriters
*
* Revision 1.8  2005/03/08 11:53:24  z_stoichev
* Made helper ToStr functions public.
*
* Revision 1.7  2005/03/06 21:00:29  lordlarry
* Changed the Log Writers so they work on a possible filtered Log Enumeration
*
* Revision 1.6  2005/03/03 08:27:46  lordlarry
* Removed LogCollection.Items and Count
* Changed LogCollection to LogEnumeration
*
* Revision 1.5  2005/02/27 18:14:27  gravanov
* Fixed: Length of log strings, now saving to file works..
*
* Revision 1.4  2005/02/25 21:38:01  voxik
* Fixed WideString support
*
* Revision 1.3  2005/02/19 12:49:02  lordlarry
* Changed: WideSting Compatible
*
* Revision 1.2  2005/02/12 18:11:31  lordlarry
* Added CVS this header
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
    procedure WriteHeader(Stream: TStream);
    procedure WriteItem(Stream: TStream; const Item: ILogItem);
    procedure WriteStr(Stream: TStream; const Str: WideString);
    procedure WriteFooter(Stream: TStream);
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

end.
