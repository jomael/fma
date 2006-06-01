unit MouseCtrlCoClass;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Classes, Forms, ComObj, floAtMediaCtrl_TLB;

type
  TMouseCtrl = class;

  TMouseMoveThread = class(TThread)
  public
    DirX, DirY: Shortint;
    MouseCtrl: TMouseCtrl;
    Accel, StartSpeed: Integer;
  protected
    procedure Execute; override;
  end;

  TMouseCtrl = class(TAutoObject, IMouseCtrl)
  protected
    procedure MouseMove(const Direction: WideString); safecall;
    procedure MouseStop; safecall;
    procedure MouseWhlUp; safecall;
    procedure MouseWhlDown; safecall;
    procedure MouseRightClick; safecall;
    procedure MouseLeftClick; safecall;
    procedure Set_Accel(Value: Integer); safecall;
    procedure Set_StartSpeed(Value: Integer); safecall;
  private
    MouseMoveThread: TMouseMoveThread;
    SkipThreadExit: boolean;
    FDirection: String;

    function CompAccel(Value: Integer): Integer;
    function CompStartSpeed(Value: Integer): Integer;
  public
    destructor Destroy; override;
  end;

implementation

uses
  Windows, Types, SysUtils, ComServ, Math, FormOptions;

const
  MouseAccelMin = 100;
  MouseAccelMax = 10;

  MouseStartSpeedMin = 150;
  MouseStartSpeedMax = 1;

procedure TMouseMoveThread.Execute;
  var
    P: TPoint;
    Count: Integer;
    I, SleepTime: Integer;
begin
  Count := 0;

  while not Terminated do
  begin
    GetCursorPos(P);
    SetCursorPos(P.X + DirX, P.Y + DirY);

    if Count = 0 then SleepTime := 150
    else SleepTime := Ceil(StartSpeed * Exp(-(Count)/Accel));

    if SleepTime < 1 then SleepTime := 1;

    for I := 1 to SleepTime div 20 do
    begin
      Sleep(20);
      if Terminated then break;
    end;
    if not Terminated then Sleep(SleepTime mod 20);

    Count := Count + 1; // Inc(Count) should also work. Note that we want to start a 0 and thus the Count is increased
  end;

  MouseCtrl.MouseMoveThread := nil;
end;

{ Directions:

    NW  N  NE
        |
    W --+-- E
        |
    SW  S  SE
}

procedure TMouseCtrl.MouseMove(const Direction: WideString);
begin
  if (Direction <> FDirection) and (Length(Direction) > 0) then
  begin
    MouseStop;
    MouseMoveThread := TMouseMoveThread.Create(True);
    MouseMoveThread.FreeOnTerminate := True;
    MouseMoveThread.MouseCtrl := Self;

    MouseMoveThread.Accel := CompAccel(FormSettings.TrackBarAccel.Position);;
    MouseMoveThread.StartSpeed := CompStartSpeed(FormSettings.TrackBarStarSpeed.Position);

    FDirection := UpperCase(Direction);

    MouseMoveThread.DirX := 0;
    MouseMoveThread.DirY := 0;

    case FDirection[1] of
      'N': begin
        MouseMoveThread.DirY := -1;
      end;
      'S': begin
        MouseMoveThread.DirY := 1;
      end;
      'E': begin
        MouseMoveThread.DirX := 1;
      end;
      'W': begin
        MouseMoveThread.DirX := -1;
      end;
    end;

    if Length(FDirection) = 2 then
    begin
      case FDirection[2] of
        'E': begin
          MouseMoveThread.DirX := 1;
        end;
        'W': begin
          MouseMoveThread.DirX := -1;
        end;
      end;
    end;

    MouseMoveThread.Resume;
  end;
end;

procedure TMouseCtrl.MouseStop;
begin
  if MouseMoveThread <> nil then
  begin
    MouseMoveThread.Terminate;
    if not SkipThreadExit then
      while MouseMoveThread <> nil do
      Application.ProcessMessages;
  end;
  FDirection := '';
end;

procedure TMouseCtrl.MouseWhlUp;
  var
    P: TPoint;
    Input: tagINPUT;
    MouseInput: tagMOUSEINPUT;
begin
  GetCursorPos(P);

  Input.Itype := INPUT_MOUSE;

  MouseInput.dwFlags := MOUSEEVENTF_WHEEL;
  MouseInput.dx := P.X;
  MouseInput.dy := P.Y;
  MouseInput.mouseData := WHEEL_DELTA;
  MouseInput.time := 0;
  MouseInput.dwExtraInfo := 0;

  Input.mi := MouseInput;
  SendInput(1, Input, SizeOf(Input));
end;

procedure TMouseCtrl.MouseWhlDown;
  var
    P: TPoint;
    Input: tagINPUT;
    MouseInput: tagMOUSEINPUT;
begin
  GetCursorPos(P);

  Input.Itype := INPUT_MOUSE;

  MouseInput.dwFlags := MOUSEEVENTF_WHEEL;
  MouseInput.dx := P.X;
  MouseInput.dy := P.Y;
  MouseInput.mouseData := Cardinal(-WHEEL_DELTA);
  MouseInput.time := 0;
  MouseInput.dwExtraInfo := 0;

  Input.mi := MouseInput;
  SendInput(1, Input, SizeOf(Input));
end;

procedure TMouseCtrl.MouseRightClick;
  var
    P: TPoint;
    Input: tagINPUT;
    MouseInput: tagMOUSEINPUT;
begin
  GetCursorPos(P);

  Input.Itype := INPUT_MOUSE;

  MouseInput.dx := P.X;
  MouseInput.dy := P.Y;
  MouseInput.mouseData := 0;
  MouseInput.time := 0;
  MouseInput.dwExtraInfo := 0;

  MouseInput.dwFlags := MOUSEEVENTF_RIGHTDOWN;
  Input.mi := MouseInput;
  SendInput(1, Input, SizeOf(Input));

  MouseInput.dwFlags := MOUSEEVENTF_RIGHTUP;
  Input.mi := MouseInput;
  SendInput(1, Input, SizeOf(Input));
end;

procedure TMouseCtrl.MouseLeftClick;
  var
    P: TPoint;
    Input: tagINPUT;
    MouseInput: tagMOUSEINPUT;
begin
  GetCursorPos(P);

  Input.Itype := INPUT_MOUSE;

  MouseInput.dx := P.X;
  MouseInput.dy := P.Y;
  MouseInput.mouseData := 0;
  MouseInput.time := 0;
  MouseInput.dwExtraInfo := 0;

  MouseInput.dwFlags := MOUSEEVENTF_LEFTDOWN;
  Input.mi := MouseInput;
  SendInput(1, Input, SizeOf(Input));

  MouseInput.dwFlags := MOUSEEVENTF_LEFTUP;
  Input.mi := MouseInput;
  SendInput(1, Input, SizeOf(Input));
end;

function TMouseCtrl.CompAccel(Value: Integer): Integer;
begin
  Result := Ceil(((100 - Value) / 100) * Abs(MouseAccelMin - MouseAccelMax)) + MouseAccelMax;
end;

function TMouseCtrl.CompStartSpeed(Value: Integer): Integer;
begin
  Result := Ceil(((100 - Value) / 100) * Abs(MouseStartSpeedMin - MouseStartSpeedMax)) + MouseStartSpeedMax;
end;

procedure TMouseCtrl.Set_Accel(Value: Integer);
  var
    Accel: Integer;
begin
  Accel := Value;

  if Accel > 100 then Accel := 100;
  if Accel < 0 then Accel := 0;

  FormSettings.TrackBarAccel.Position := Accel
end;

procedure TMouseCtrl.Set_StartSpeed(Value: Integer);
  var
    StartSpeed: Integer;
begin
  StartSpeed := Value;

  if StartSpeed > 100 then StartSpeed := 100;
  if StartSpeed < 0 then StartSpeed := 0;

  FormSettings.TrackBarStarSpeed.Position := StartSpeed;
end;

destructor TMouseCtrl.Destroy;
begin
  SkipThreadExit := True;
  MouseStop;
  inherited;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TMouseCtrl, CLASS_MouseCtrl,
    ciSingleInstance, tmApartment);
end.
