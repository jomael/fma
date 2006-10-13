unit uDialogs;

{
*******************************************************************************
* Descriptions: Unicode message box/dialog routines.
* $Source: /cvsroot/fma/fma/uDialogs.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uDialogs.pas,v $
*
*******************************************************************************
}

interface

uses
  Dialogs;

function MessageDlgW(const Msg: WideString; DlgType: TMsgDlgType; Buttons: LongWord): Integer;
procedure ShowMessageW(const Msg: WideString);

implementation

uses
  gnugettext,
  Windows, Forms, Classes,
  TnTForms;

function MessageDlgW(const Msg: WideString; DlgType: TMsgDlgType; Buttons: LongWord): Integer;
var
  Icon: LongWord;
  Caption: WideString;
  BiDi: LongWord;
begin
  if Application.BiDiMode = bdLeftToRight then
    BiDi := 0
  else
    BiDi := MB_RTLREADING or MB_RIGHT;

  case DlgType of
    mtWarning:
      begin
        Icon := MB_ICONWARNING;
        Caption := _('Warning');
      end;
    mtError:
      begin
        Icon := MB_ICONERROR;
        Caption := _('Error');
      end;
    mtInformation:
      begin
        Icon := MB_ICONINFORMATION;
        Caption := _('Information');
      end;
    mtConfirmation:
      begin
        Icon := MB_ICONQUESTION;
        Caption := _('Confirm');
      end;
  else
    Icon := 0;
    Caption := TntApplication.Title;
  end;

  Result := MessageBoxW(GetActiveWindow, PWideChar(Msg), PWideChar(Caption),
    Buttons or Icon or BiDi or MB_TASKMODAL);
end;

procedure ShowMessageW(const Msg: WideString);
begin
  MessageDlgW(Msg, mtCustom, MB_OK);
end;

end.
