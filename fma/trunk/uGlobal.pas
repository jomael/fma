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
*
*******************************************************************************
}

interface

uses
  Classes, TntClasses;

const
  EmptyDate = 949998; // for Outlook compatability

function IsEmptyDate(ADate: TDateTime): boolean;
function RemoveUnsafeChars(s: WideString): WideString;

function WideConcatList(Left,Right: WideString; delimiter: WideString = ''): WideString;

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
function SetToken(str,NewToken: WideString; index: Integer; delimiter: WideChar = ','; DontQuote: boolean = False): WideString;
{ Extract all tokens from str and place them in Strings List.
  Caller has to Create and Free AList manually! Assume that Result.count equals to GetTokenCount }
procedure GetTokenList(AList: TTntStrings; str: WideString; delimiter: WideChar = ',');
{ Returns all tokens in wl List as a flat-wide-string, and quotes them if needed }
function GetTokenListText(wl: TTntStringList; delimiter: WideChar = ','): WideString;


implementation

uses
  gnugettext,
  SysUtils, TntSysUtils, TntWideStrings;

function IsEmptyDate(ADate: TDateTime): boolean;
begin
  Result := Trunc(ADate) = EmptyDate;
end;

function RemoveUnsafeChars(s: WideString): WideString;
var
  i: integer;
begin
  // http://msdn.microsoft.com/library/default.asp?url=/library/en-us/fileio/fs/naming_a_file.asp
  i := 1;
  while i <= Length(s) do begin
    case s[i] of
      '<', '>', ':', '/', '\', '|': s[i] := '-';
      #1..#31, '"': begin
        Delete(s, i, 1);
        Dec(i);
      end;
    end;
    Inc(i);
  end;
  Result := s;
end;

(* Unicode *)

function WideConcatList(Left,Right,delimiter: WideString): WideString;
begin
  Left := WideTrim(Left);
  Right := WideTrim(Right);
  if Left <> '' then begin
    Result := Left;
    if Right <> '' then begin
      Result := Result + delimiter; // might include space chars
      Result := Result + Right;
    end;
  end
  else
    Result := Right;
end;

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
  while (i <= j) and (str[i] = ' ') do inc(i); // how about TrimLeft(str)?
  { Find right token end }
  t := Pos(delimiter,str)-1;
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
    Delete(str,1,i);
    Result := '';
    exit;
  end;
  { Extract first token }
  if (str[i] = '"') and (str[j] = '"') then begin
    { token IS quoted }
    s := Copy(str,i+1,j);
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
      Delete(d,Length(d),1);
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
  Delete(str,1,j);
  j := Pos(delimiter,str);
  if j = 0 then j := Length(str)+1;
  Delete(str,1,j);
  { Done }
  Result := s;
end;

function GetToken(str: WideString; index: Integer; delimiter: WideChar): WideString;
var
  s,d: WideString;
begin
  Result := '';
  s := Trim(str);
  while s <> '' do begin
    d := GetFirstToken(s,delimiter);
    if index = 0 then begin
      Result := d;
      break;
    end;
    Dec(index);
  end;
end;

procedure GetTokenList(AList: TTntStrings; str: WideString; delimiter: WideChar);
var
  LastEmpty: Boolean;
  w: WideString;
begin
  AList.Clear;
  w := Trim(str);
  if (w <> '') and (w[Length(w)] = delimiter) then
    LastEmpty := True
  else
    LastEmpty := False;
  while w <> '' do AList.Add(GetFirstToken(w));
  if LastEmpty then AList.Add('');
end;

function GetTokenListText(wl: TTntStringList; delimiter: WideChar = ','): WideString;
var
  w: WideString;
  i: Integer;
begin
  w := '';
  for i := 0 to wl.Count-1 do begin
    if i <> 0 then w := w + delimiter;
    w := w + WideQuoteStr(wl[i],False,delimiter);
  end;
  Result := w;
end;

function SetToken(str,NewToken: WideString; index: Integer; delimiter: WideChar; DontQuote: boolean): WideString;
var
  s: WideString;
  n,k: Integer;
begin
  k := GetTokenCount(str,delimiter);
  s := '';
  if (index >= 0) and (index <= k) then
    for n := 0 to index-1 do begin
      if DontQuote then
        s := s + GetToken(str,n,delimiter) + delimiter
      else
        s := s + WideQuoteStr(GetToken(str,n,delimiter),False,delimiter) + delimiter;
    end;
  if DontQuote then
    s := s + NewToken
  else
    s := s + WideQuoteStr(NewToken,False,delimiter);
  if (index >= 0) and (index < k-1) then
    for n := index+1 to k-1 do begin
      if DontQuote then
        s := s + delimiter + GetToken(str,n,delimiter)
      else
        s := s + delimiter + WideQuoteStr(GetToken(str,n,delimiter),False,delimiter);
    end;
  Result := s;
end;

function GetTokenCount(str: WideString; delimiter: WideChar): Integer;
var
  s: WideString;
begin
  Result := 0;
  s := Trim(str);
  if (s <> '') and (s[Length(s)] = delimiter) then
    Result := 1; // case "aaa,bbb,"
  while s <> '' do begin
    Inc(Result);
    GetFirstToken(s,delimiter);
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

  ww := '"first, second" , last';
  qq := GetFirstToken(ww);
  if qq <> 'first, second' then Halt(1);

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
