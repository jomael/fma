unit uKeyPad;

{
*******************************************************************************
* Descriptions: Phone KeyPad window.
* $Source: /cvsroot/fma/fma/uKeyPad.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uKeyPad.pas,v $
*
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, StdCtrls, TntStdCtrls, ComCtrls, TntComCtrls, UniTntCtrls, ExtCtrls, TntExtCtrls, Buttons, TntButtons, Placemnt;

type
  TfrmKeyPad = class(TTntForm)
    Button1: TTntButton;
    Button2: TTntButton;
    Button3: TTntButton;
    Button4: TTntButton;
    Button5: TTntButton;
    Button6: TTntButton;
    Button7: TTntButton;
    Button8: TTntButton;
    Button9: TTntButton;
    GroupBox1: TTntGroupBox;
    Button10: TTntButton;
    Button11: TTntButton;
    Button12: TTntButton;
    Button13: TTntButton;
    Button14: TTntButton;
    Button15: TTntButton;
    Button16: TTntButton;
    Button17: TTntButton;
    Button18: TTntButton;
    Button19: TTntButton;
    Button20: TTntButton;
    Button21: TTntButton;
    Timer1: TTimer;
    SpeedButton1: TTntSpeedButton;
    SpeedButton2: TTntSpeedButton;
    Button22: TTntButton;
    Button23: TTntButton;
    Button24: TTntButton;
    FormPlacement1: TFormPlacement;
    Button25: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure KeyPadMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure KeyPadMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TntFormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TntFormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button25Click(Sender: TObject);
  private
    { Private declarations }
    FTime: Cardinal;
    FLastButton: String;
    procedure SendKey(Key: String; State: Shortint = 2);
  public
    { Public declarations }
    procedure SetKeysMode(T610: boolean = True);
  end;

var
  frmKeyPad: TfrmKeyPad;

implementation

uses
  gnugettext, gnugettexthelpers, uLogger,
  Unit1, uDialogs;

{$R *.dfm}

procedure TfrmKeyPad.Timer1Timer(Sender: TObject);
begin
  if FLastButton <> '' then begin
    SendKey(FLastButton, 1);
    ShowMessageW(_('Key Sent.'));
  end;
end;

procedure TfrmKeyPad.KeyPadMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
   key: String;
begin
   if Button = mbRight then Exit;
   Key := (Sender as TTntButton).Hint;
   SendKey(Key, 0);
end;

procedure TfrmKeyPad.KeyPadMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
   key: String;
begin
   if Button = mbRight then Exit;
   Key := (Sender as TTntButton).Hint;
   SendKey(Key, 1);
end;

procedure TfrmKeyPad.SpeedButton1Click(Sender: TObject);
begin
   SendKey('U'); // do not localize
end;

procedure TfrmKeyPad.SpeedButton2Click(Sender: TObject);
begin
   SendKey('D'); // do not localize
end;

procedure TfrmKeyPad.SendKey(Key: String; State: Shortint);
begin
  try
    case State of
      0: begin // pressed
        Log.AddCommunicationMessage('KeyPad: Key "'+Key+'" pressed', lsDebug); // do not localize debug
        FTime := GetTickCount;
        FLastButton := Key;
        Timer1.Enabled := True;
        if Form1.IsK700orBetter then
          Form1.TxAndWait('AT*EKEY=1,"' + Key + '",0', 'OK'); // do not localize
      end;
      1: begin // released
        Log.AddCommunicationMessage('KeyPad: Key "'+Key+'" released', lsDebug); // do not localize debug
        FLastButton := '';
        Timer1.Enabled := False;
        FTime := (GetTickCount - FTime) div 100;
        if Form1.IsK700orBetter then
          Form1.TxAndWait('AT*EKEY=1,"' + Key + '",1', 'OK') // do not localize
        else begin
          if (FTime < 15) or (FTime >= 256) then
            Form1.TxAndWait('AT+CKPD="' + Key + '"', 'OK') // do not localize
          else if FTime < 256 then
            Form1.TxAndWait('AT+CKPD="' + Key + '",' + IntToStr(FTime), 'OK') // do not localize
          end;
      end;
      2: begin // pressed & released
        Log.AddCommunicationMessage('KeyPad: Sending Key "'+Key+'"', lsDebug); // do not localize debug
        FLastButton := '';
        if Form1.IsK700orBetter then
          Form1.TxAndWait('AT*EKEY=1,"' + Key + '",2', 'OK') // do not localize
        else
          Form1.TxAndWait('AT+CKPD="' + Key + '"', 'OK'); // do not localize
      end;
    end;
  except
  end;
end;

procedure TfrmKeyPad.SetKeysMode(T610: boolean);
begin
  //TODO -cl10n: localize?
  if T610 then begin
    Button6.Caption := '----';
    Button6.Hint := '[';

    Button7.Caption := '----';
    Button7.Hint := ']';

    Button8.Caption := 'Back';
    Button8.Hint := ':R';

    Button22.Hint := ':J';

    Button23.Visible := True;
    Button24.Visible := True;
    ClientHeight := Button24.Top + Button24.Height + 4;
  end
  else begin
    Button6.Caption := 'Yes';
    Button6.Hint := 's';

    Button7.Caption := 'No';
    Button7.Hint := 'e';

    Button8.Caption := 'OPT';
    Button8.Hint := 'f';

    Button23.Visible := False;
    Button24.Visible := False;

    Button22.Hint := 's';
    ClientHeight := Button2.Top + Button2.Height + 4;
  end;
end;

procedure TfrmKeyPad.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);
end;

procedure TfrmKeyPad.TntFormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var keyChar: Char;
  procedure SendKeyAndDispose(const s: String);
  begin
    //Key := 0; seems it doesnt work
    if (FLastButton <> s) then
      SendKey(s, 0);
  end;
begin
  if Shift = [] then begin
    case Key of
      VK_RETURN: SendKeyAndDispose(Button22.Hint);
      VK_BACK: SendKeyAndDispose(Button9.Hint);
      VK_MULTIPLY: SendKeyAndDispose(Button19.Hint);
      else begin
        keyChar := Chr(Key);
        case keyChar of
          //'#': SendKeyAndDispose(keyChar); // VK for this key???
          'W': SendKeyAndDispose(Button1.Hint);
          'S': SendKeyAndDispose(Button3.Hint);
          'A': SendKeyAndDispose(Button4.Hint);
          'D': SendKeyAndDispose(Button5.Hint);
          else
            if ((keyChar >= '0') and (keyChar <= '9')) then
              SendKeyAndDispose(keyChar);
        end;
      end;
    end;
  end;
end;

procedure TfrmKeyPad.TntFormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var keyChar: Char;
  procedure SendKeyAndDispose(const s: String);
  begin
    SendKey(s, 1);
  end;
begin
  if Shift = [] then begin
    case Key of
      VK_RETURN: SendKeyAndDispose(Button22.Hint);
      VK_BACK: SendKeyAndDispose(Button9.Hint);
      VK_MULTIPLY: SendKeyAndDispose(Button19.Hint);
      else begin
        keyChar := Chr(Key);
        case keyChar of
          //'#': SendKeyAndDispose(keyChar); // VK for this key???
          'W': SendKeyAndDispose(Button1.Hint);
          'S': SendKeyAndDispose(Button3.Hint);
          'A': SendKeyAndDispose(Button4.Hint);
          'D': SendKeyAndDispose(Button5.Hint);
          else
            if ((keyChar >= '0') and (keyChar <= '9')) then
              SendKeyAndDispose(keyChar);
        end;
      end;
    end;
  end;
end;

procedure TfrmKeyPad.Button25Click(Sender: TObject);
begin
  MessageDlgW(_('Phone''s keypad can be controlled also with computer''s keyboard.')+sLineBreak+sLineBreak+
              _('Joystick = W,S,A,D; Joystick press = Enter; C button = Backspace;'), mtInformation, MB_OK);
end;

end.
