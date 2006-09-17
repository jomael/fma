unit uGlobal;

{
*******************************************************************************
* Descriptions: Global
* $Source: /cvsroot/fma/fma/uGlobal.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uGlobal.pas,v $
* Revision 1.14.2.8  2006/03/23 16:37:06  z_stoichev
* Added Alarm sound setting.
*
* Revision 1.14.2.7  2006/03/14 12:18:53  z_stoichev
* Added optional Delimiter param.
*
* Revision 1.14.2.6  2006/03/10 12:25:32  z_stoichev
* Added SetToken func.
*
* Revision 1.14.2.5  2005/11/20 12:19:39  mhr3
* Fixed WideStringReplace to Tnt_WideStringReplace (update your Tnt package)
*
* Revision 1.14.2.4  2005/10/01 10:12:04  z_stoichev
* WideQuoteStr function fixes.
*
* Revision 1.14.2.3  2005/09/30 19:15:27  z_stoichev
* Unicode fix.
*
* Revision 1.14.2.2  2005/08/18 17:13:47  z_stoichev
* - Added support for JPEG2000 images.
* - Fixed GIF images displaying issue.
*
* Revision 1.14.2.1  2005/04/11 22:21:24  z_stoichev
* Unicode fixes.
*
* Revision 1.14  2005/02/08 15:38:51  voxik
* Merged with L10N branch
*
* Revision 1.13.2.2  2004/10/25 20:21:42  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.13.2.1  2004/10/19 19:48:38  expertone
* Add localization (gnugettext)
*
* Revision 1.13  2004/10/15 14:01:53  z_stoichev
* Merged with Stable bugfixes
*
* Revision 1.12  2004/09/10 11:49:05  z_stoichev
* handle GetTocken from empty string
*
* Revision 1.11.6.1  2004/09/10 12:14:15  z_stoichev
* - Handle GetFirstToken with empty str.
*
* Revision 1.11  2004/07/02 08:14:01  z_stoichev
* - Added Sound events for Proximity Away/Near.
*
* Revision 1.10  2004/06/22 14:33:52  z_stoichev
* - Added GetToken double-quotes support.
*
* Revision 1.9  2004/06/15 13:02:59  z_stoichev
* Fixed registry entries.
*
* Revision 1.8  2004/06/14 09:33:48  z_stoichev
* Fixed '' not integer value.
*
* Revision 1.7  2004/05/19 18:34:15  z_stoichev
* Build 0.1.0.35c
*
* Revision 1.6  2003/12/04 16:30:43  z_stoichev
* Fixed memory leak,
* Added new function GetTokenCount.
*
* Revision 1.5  2003/11/28 09:38:07  z_stoichev
* Merged with branch-release-1-1 (Fma 0.10.28c)
*
* Revision 1.4.2.2  2003/11/27 12:56:10  z_stoichev
* Add sent message sound.
*
* Revision 1.4.2.1  2003/10/27 07:22:54  z_stoichev
* Build 0.1.0 RC1 Initial Checkin.
*
* Revision 1.4  2003/07/02 12:40:30  crino77
* added call sound
*
* Revision 1.3  2003/01/30 04:15:57  warren00
* Updated with header comments
*
*
*******************************************************************************
}

interface

function WideTrim(str: WideString): WideString;
function WideLeftTrim(str: WideString): WideString;
function WideRightTrim(str: WideString): WideString;

function WidePos(substr,str: WideString; startpos: Integer = 1): Integer;
function WidePosRight(substr,str: WideString): Integer;
function WideCopy(str: WideString; Index,Count: Integer): WideString;
function WideDelete(var str: WideString; Index,Count: Integer): WideString;

function WideQuoteStr(str: WideString; ForceQuote: boolean = False; delimiter: WideChar = ','): WideString;

function GetFirstToken(var str: WideString; delimiter: WideChar = ','): WideString;
{ Returns now many tokens are in the string, 1..n, if str is empty returns 0 }
function GetTokenCount(str: WideString; delimiter: WideChar = ','): Integer;
{ Extracts token number 0..n-1 from str, where n is taken from GetTokenCount }
function GetToken(str: WideString; index: Integer; delimiter: WideChar = ','): WideString;
{ Replace token number 0..n-1 in str with NewToken value, where n is taken from GetTokenCount.
  This function could be used to append a new token to the list }
function SetToken(str,NewToken: WideString; index: Integer; delimiter: WideChar = ','): WideString;

procedure InitRegistry;

implementation

uses
  gnugettext,
  Classes, TntClasses, Registry, SysUtils, TntSysUtils, TntWideStrings;

(* Unicode *)

function WidePos(substr,str: WideString; startpos: Integer): Integer;
var
  i,j,k,m: Integer;
  found: Boolean;
begin
  Result := 0;
  k := Length(substr);
  m := Length(str);
  if Length(substr) <> 0 then
    for i := startpos to m-k+1 do
      if str[i] = substr[1] then begin
        found := True;
        for j := 2 to k do 
          if str[i+j-1] <> substr[j] then begin
            found := False;
            break;
          end;
        if found then begin
          Result := i;
          break;
        end;
      end;
end;

function WidePosRight(substr,str: WideString): Integer;
var
  i,j,k,m: Integer;
  found: Boolean;
begin
  Result := 0;
  k := Length(substr);
  m := Length(str);
  if Length(substr) <> 0 then
    for i := m-k+1 downto 1 do
      if str[i] = substr[1] then begin
        found := True;
        for j := 2 to k do 
          if str[i+j-1] <> substr[j] then begin
            found := False;
            break;
          end;
        if found then begin
          Result := i;
          break;
        end;
      end;
end;

function WideCopy(str: WideString; Index,Count: Integer): WideString;
var
  i,j,k: Integer;
begin
  Result := '';
  j := Length(str);
  if (Count > 0) and (Index <= j) then begin
    k := Index+Count-1;
    i := Index;
    if k < j then j := k;
    for i := i to j do
      Result := Result + str[i];
  end;
end;

function WideDelete(var str: WideString; Index,Count: Integer): WideString;
var
  i,j,k,m: Integer;
begin
  j := Length(str);
  if (Count > 0) and (Index <= j) then begin
    Result := '';
    k := Index+Count-1;
    i := Index;
    for m := 1 to j do
      if (m < i) or (m > k) then
        Result := Result + str[m];
    str := Result;
  end
  else
    Result := str;
end;

function WideLeftTrim(str: WideString): WideString;
var
  i,j: Integer;
begin
  Result := '';
  j := Length(str);
  i := 1;
  while (i <= j) and (str[i] = ' ') do inc(i);
  for i := i to j do
    Result := Result + str[i];
end;

function WideRightTrim(str: WideString): WideString;
var
  i,j: Integer;
begin
  Result := '';
  j := Length(str);
  while (j > 0) and (str[j] = ' ') do dec(j);
  for i := 1 to j do
    Result := Result + str[i];
end;

function WideTrim(str: WideString): WideString;
var
  i,j: Integer;
begin
  Result := '';
  j := Length(str);
  while (j > 0) and (str[j] = ' ') do dec(j);
  i := 1;
  while (i < j) and (str[i] = ' ') do inc(i);
  while i <= j do begin
    Result := Result + str[i];
    inc(i);
  end;
end;

function WideQuoteStr(str: WideString; ForceQuote: boolean; delimiter: WideChar): WideString;
var
  Quote: boolean;
  i: integer;
begin
  Quote := ForceQuote;
  if not Quote then
    for i := 1 to Length(str) do
      if (str[i] = ' ') or (str[i] = '"') or (str[i] = delimiter) then begin
        Quote := True;
        break;
      end;
  if Quote then
    str := '"' + Tnt_WideStringReplace(str, '"', '""', [rfReplaceAll]) + '"';
  Result := str;
end;

{ Token routines }

(*
function GetFirstToken(var str: WideString; delimiter: WideChar = ','): WideString;
var
  wl: TTntStringList;
begin
  Result := '';
  wl := TTntStringList.Create;
  try
    wl.Delimiter := delimiter;
    wl.DelimitedText := str;
    if wl.Count <> 0 then begin
      Result := wl[0];
      wl.Delete(0);
      str := wl.DelimitedText;
    end;
  finally
    wl.Free;
  end;
end;

function GetToken(str: WideString; index: Integer; delimiter: WideChar): WideString;
var
  wl: TTntStringList;
begin
  Result := '';
  wl := TTntStringList.Create;
  try
    wl.Delimiter := delimiter;
    wl.DelimitedText := str;
    if (index >= 0) and (index < wl.Count) then
      Result := wl[index];
  finally
    wl.Free;
  end;
end;
*)

function GetFirstToken(var str: WideString; delimiter: WideChar = ','): WideString;
var
  i,j,k,q,t: integer;
  s,d: WideString;
begin
  if delimiter = '"' then delimiter := ','; 
  { Left trim text }
  i := 1;
  j := Length(Str);
  while (i <= j) and (str[i] = ' ') do inc(i);
  { Find right token end }
  t := WidePos(delimiter,str)-1;
  if t < 0 then t := j;
  { Right trim text }
  while (t > 0) and (str[t] = ' ') do dec(t);
  { Get token start-end pos [i-j] }
  if (i < j) and ((str[i] = '"') or (str[t] = '"')) then begin
    { Probably quoted, find next single quote }
    j := i; // find first single quote
    while (j <= t) and (str[j] <> '"') do inc(j);
    inc(j); // skip first quote
    k := Length(str);
    q := 0; // find next single quote
    while j <= k do begin
      if str[j] = '"' then begin
        inc(q);
        { check for double-quotes }
        if q = 2 then begin
          q := 0;
          inc(j);
          continue; // ignore second quote
        end;
      end
      else
        if q = 1 then
          break // single quote found, so exit loop
        else
          q := 0;
      inc(j);
    end;
    if q = 1 then dec(j);
    if j > k then Abort; // not possible if text is correctly quoted!
    if j < t then j := t;
  end
  else begin
    { Not quoted }
    j := t;
  end;
  { Check for empty token }
  if (i > j) or (j = 0) then begin
    { Update source }
    WideDelete(str,1,i);
    Result := '';
    exit;
  end;
  { Extract first token }
  if (str[i] = '"') and (str[j] = '"') then begin
    { token IS quoted }
    s := WideCopy(str,i+1,j);
    k := Length(s);
    j := 1; d := ''; q := 0;
    while (j <= k) do begin
      if s[j] = '"' then begin
        inc(q);
        { check for double-quotes }
        if q = 2 then begin
          q := 0;
          inc(j);
          continue; // ignore second quote
        end;
      end
      else
        if q = 1 then
          break // single quote found, so exit loop
        else
          q := 0;
      d := d + s[j];
      inc(j);
    end;
    if q = 1 then begin // remove last single quote
      dec(j);
      WideDelete(d,Length(d),1);
    end;
    if j <= k then
      s := d
    else
      Abort; // not possible if text is correctly quoted!
  end
  else begin
    { token is NOT quoted }
    s := '';
    for i := i to j do s := s + str[i];
  end;
  { Update source }
  WideDelete(str,1,j);
  j := WidePos(delimiter,str);
  if j = 0 then j := Length(str)+1;
  WideDelete(str,1,j);
  { Done }
  Result := s;
end;

function GetToken(str: WideString; index: Integer; delimiter: WideChar): WideString;
var
  s,d: WideString;
begin
  Result := '';
  s := WideTrim(str);
  while s <> '' do begin
    d := GetFirstToken(s,delimiter);
    if index = 0 then begin
      Result := d;
      break;
    end;
    Dec(index);
  end;
end;

function SetToken(str,NewToken: WideString; index: Integer; delimiter: WideChar): WideString;
var
  s: WideString;
  n,k: Integer;
begin
  k := GetTokenCount(str,delimiter);
  s := '';
  if (index >= 0) and (index <= k) then
    for n := 0 to index-1 do
      s := s + GetToken(str,n,delimiter) + delimiter;
  s := s + NewToken;
  if (index >= 0) and (index < k-1) then
    for n := index+1 to k-1 do
      s := s + delimiter + GetToken(str,n,delimiter);
  Result := s;
end;

function GetTokenCount(str: WideString; delimiter: WideChar): Integer;
var
  s: WideString;
begin
  Result := 0;
  s := WideTrim(str);
  if (s <> '') and (s[Length(s)] = delimiter) then
    Result := 1; // case "aaa,bbb," 
  while s <> '' do begin
    Inc(Result);
    GetFirstToken(s,delimiter);
  end;
end;

procedure InitRegistry;
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  try
    reg.OpenKey('\AppEvents\EventLabels\FMA_SMSReceived', True); // do not localize
    reg.WriteString('', 'SMS Received'); // do not localize
    reg.CloseKey;

    reg.OpenKey('\AppEvents\EventLabels\FMA_SMSSent', True); // do not localize
    reg.WriteString('', 'SMS Sent'); // do not localize
    reg.CloseKey;

    reg.OpenKey('\AppEvents\EventLabels\FMA_Calling', True); // do not localize
    reg.WriteString('', 'Calling Contact'); // do not localize
    reg.CloseKey;

    reg.OpenKey('\AppEvents\EventLabels\FMA_CallReceived', True); // do not localize
    reg.WriteString('', 'Call Received'); // do not localize
    reg.CloseKey;

    reg.OpenKey('\AppEvents\EventLabels\FMA_MEConnected', True); // do not localize
    reg.WriteString('', 'Connected to Mobile Equipment'); // do not localize
    reg.CloseKey;

    reg.OpenKey('\AppEvents\EventLabels\FMA_MEDisconnected', True); // do not localize
    reg.WriteString('', 'Disconnected from Mobile Equipment'); // do not localize
    reg.CloseKey;

    reg.OpenKey('\AppEvents\EventLabels\FMA_Away', True); // do not localize
    reg.WriteString('', 'Proximity Away'); // do not localize
    reg.CloseKey;

    reg.OpenKey('\AppEvents\EventLabels\FMA_Near', True); // do not localize
    reg.WriteString('', 'Proximity Near'); // do not localize
    reg.CloseKey;

    reg.OpenKey('\AppEvents\EventLabels\FMA_Alarm', True); // do not localize
    reg.WriteString('', 'Alarm Activated'); // do not localize
    reg.CloseKey;

    reg.OpenKey('\AppEvents\Schemes\Apps\MobileAgent', True); // do not localize
    reg.WriteString('', 'floAt''s Mobile Agent'); // do not localize
    reg.CloseKey;
    reg.CreateKey('\AppEvents\Schemes\Apps\MobileAgent\FMA_Calling'); // do not localize
    reg.CreateKey('\AppEvents\Schemes\Apps\MobileAgent\FMA_CallReceived'); // do not localize
    reg.CreateKey('\AppEvents\Schemes\Apps\MobileAgent\FMA_SMSReceived'); // do not localize
    reg.CreateKey('\AppEvents\Schemes\Apps\MobileAgent\FMA_SMSSent'); // do not localize
    reg.CreateKey('\AppEvents\Schemes\Apps\MobileAgent\FMA_Away'); // do not localize
    reg.CreateKey('\AppEvents\Schemes\Apps\MobileAgent\FMA_Near'); // do not localize
    reg.CreateKey('\AppEvents\Schemes\Apps\MobileAgent\FMA_MEConnected'); // do not localize
    reg.CreateKey('\AppEvents\Schemes\Apps\MobileAgent\FMA_MEDisconnected'); // do not localize
    reg.CreateKey('\AppEvents\Schemes\Apps\MobileAgent\FMA_Alarm'); // do not localize
  finally
    reg.Free;
  end;
end;

var
  ww,qq: WideString;

initialization
  { Sanity Check - REMOVE in production builds!!! }
  ww := ' first, last';
  qq := GetFirstToken(ww);
  if qq <> 'first' then Halt(1);

  ww := '"first second" ,last';
  qq := GetFirstToken(ww);
  if qq <> 'first second' then Halt(1);

  ww := '"first" second , last';
  qq := GetFirstToken(ww);
  if qq <> '"first" second' then Halt(1);

  ww := ' first "second" ,last';
  qq := GetFirstToken(ww);
  if qq <> 'first "second"' then Halt(1);

  ww := ' "first ""mr"" second",last';
  qq := GetFirstToken(ww);
  if qq <> 'first "mr" second' then Halt(1);

  ww := ' ,last';
  qq := GetFirstToken(ww);
  if qq <> '' then Halt(1);

  ww := '';
  qq := GetFirstToken(ww);
  if qq <> '' then Halt(1);

  ww := ' ';
  qq := GetFirstToken(ww);
  if qq <> '' then Halt(1);

  ww := ' first ';
  qq := GetFirstToken(ww);
  if qq <> 'first' then Halt(1);

  ww := WideCopy('floats',3,2);
  if ww <> 'oa' then Halt(1);

  ww := 'floats';
  qq := WideDelete(ww,3,2);
  if qq <> 'flts' then Halt(1);

  ww := WideTrim(' floats ');
  if ww <> 'floats' then Halt(1);

  ww := WideLeftTrim(' floats');
  if ww <> 'floats' then Halt(1);

  ww := WideRightTrim('floats ');
  if ww <> 'floats' then Halt(1);
  {}
end.
