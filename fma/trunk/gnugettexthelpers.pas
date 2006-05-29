unit gnugettexthelpers;

interface

uses
  Classes, Forms, TntForms, TntClasses, Controls;

procedure gghTranslateComponent(AnObject: TComponent; TextDomain: string = '');
procedure gghFixRightToLeft(C: TComponent);

function gghGetLocalizedLanguageName(LocaleId: WideString; LocaleList: TTntStrings): WideString;

procedure gghGetTranslatorsList(Translators: TTntStrings; Languages: TTntStrings);

procedure gghWorkaroundMidleEastApplicationExit(MainForm: TForm);

implementation

uses
  gnugettext,
  Windows, SysUtils, TntSysUtils, ComCtrls, TntComCtrls;

procedure gghTranslateComponent(AnObject: TComponent; TextDomain: string = '');
var
  Flip: Boolean;
begin
  Flip := SysLocale.MiddleEast;

  TranslateComponent(AnObject, TextDomain);

  if Flip then
    gghFixRightToLeft(AnObject);
end;

procedure gghFixRightToLeft(C: TComponent);

  procedure FixControl(C: TControl);
  var
    A: TAnchors;
    i: Integer;
  begin
    A := C.Anchors - [akLeft, akRight];
    if akRight in C.Anchors then
      Include(A, akLeft);
    if akLeft in C.Anchors then
      Include(A, akRight);
    C.Anchors := A;

    for i := 0 to C.ComponentCount - 1 do
      if C.Components[i] is TControl then
        FixControl(C.Components[i] as TControl);
  end;

begin
  if C is TWinControl then
    LockWindowUpdate(TWinControl(C).Handle);

  if C is TControl then
    with C as TControl do
      begin
        BiDiMode := bdRightToLeft;

        if C is TWinControl then
          with C as TWinControl do
            FlipChildren(True);

        FixControl(C as TControl);
      end;

  if C is TWinControl then
    LockWindowUpdate(0);
end;

function gghGetLocalizedLanguageName(LocaleId: WideString; LocaleList: TTntStrings): WideString;
var
  i, i1, Index, MaxLen: Integer;
  S, S1, S2: WideString;
begin
  S := dgettext('languagecodes', LocaleId); // do not localize
  if WideSameText(S, LocaleId) then
    begin
      Index := LocaleList.IndexOf(LocaleId);
      S1 := LocaleId;
      S2 := '';
      maxLen := 0;
      if (LocaleList.Count>0) and (LocaleList[0]='') then i1 := 1 else i1 := 0;
      for i := i1 to LocaleList.Count-1 do
        if (i<>Index) and
          WideSameText(Copy(LocaleId,1,Length(LocaleList[i])),LocaleList[i]) and
          (Length(LocaleList[i])>MaxLen) then
          begin
            MaxLen := Length(LocaleList[i]);
            S1 := Copy(LocaleId,1,MaxLen);
            S2 := Copy(LocaleId,MaxLen+1,MaxInt);
          end;
      if WideSameText(Copy(S2,1,1), '_') then Delete(S2,1,1);
      if WideSameText(Copy(S1,Length(S1),1), '_') then Delete(S1,Length(S1),1);
      S2 := ' ' + S2;
      S := dgettext('languagecodes', S1); // do not localize
      if WideSameText(S, S1) then
        S := dgettext('languagecodes', Copy(S1,1,2)); // do not localize
    end
  else
    S2 := '';
  S1 := dgettext('languages', S); // do not localize
  if WideSameText(S, S1) then
    Result := S1 + S2
  else
    Result := S1 + S2 + ' [' + S + ']';
end;

procedure gghGetTranslatorsList(Translators: TTntStrings; Languages: TTntStrings);
var
  SL: TStringList;
  i: Integer;
  W: WideString;
  OldLanguage: string;
begin
  SL := TStringList.Create;
  OldLanguage := GetCurrentLanguage;
  try
    DefaultInstance.GetListOfLanguages(DefaultTextDomain, SL);
    for i := 0 to SL.Count - 1 do
      begin
        Languages.Add(SL[i]);
        UseLanguage(SL[i]);
        W := DefaultInstance.GetTranslationProperty('X-TRANSLATORS');
        if WideTextPos(WideUpperCase(GetTranslatorNameAndEmail), WideUpperCase(W))=0 then
          if W = '' then W := GetTranslatorNameAndEmail;
        Translators.Add(W);
        UseLanguage(OldLanguage);
      end;
  finally
    UseLanguage(OldLanguage);
    SL.Free;
  end;
end;

procedure TerminateIt; stdcall;
begin
  TerminateProcess(GetCurrentProcess, 0);
end;

procedure TerminateIt2(ErrorCode: HResult; ErrorAddr: Pointer);
begin
  TerminateProcess(GetCurrentProcess, 0);
end;

procedure TerminateIt3(const Message, Filename: string; LineNumber: Integer; ErrorAddr: Pointer);
begin
  TerminateProcess(GetCurrentProcess, 0);
end;

procedure gghWorkaroundMidleEastApplicationExit(MainForm: TForm);
begin
  if SysLocale.MiddleEast then
    begin
      try
        // Hide all forms except main form...
        while Screen.FormCount > 1 do
          try
            Screen.Forms[Screen.FormCount-1].Free;
          except
          end;
        // Do not use here Form1 directly !
        // If you do, the FMA components package will not compile !
        if Assigned(MainForm) and Assigned(MainForm.OnDestroy) then
          MainForm.OnDestroy(MainForm);
      except
      end;
      // Sorry for next 3 lines!
      RTLUnwindProc := @TerminateIt;
      SafeCallErrorProc := @TerminateIt2;
      AssertErrorProc := @TerminateIt3;
    end;
end;

end.

