unit SECalendar;

interface

uses Classes, Controls, Messages, Windows, Forms, Graphics, StdCtrls, Grids, SysUtils;

type
  TDayOfWeek = 0..6;
  TCalSelection = Set of Byte;

  TSECalendar = class(TCustomGrid)
  private
    FDate: TDateTime;
    FMonthOffset,FSelStart,FSelEnd,FSelMove: Integer;
    FOnChange: TNotifyEvent;
    FReadOnly: Boolean;
    FStartOfWeek: TDayOfWeek;
    FUpdating,FSelecting: Boolean;
    FUseCurrentDate: Boolean;
    FDateInfo: TStringList;
    FOnSelChange: TNotifyEvent;
    function GetCellText(ACol, ARow: Integer): string;
    function GetDateElement(Index: Integer): Integer;
    procedure SetCalendarDate(Value: TDateTime);
    procedure SetDateElement(Index: Integer; Value: Integer);
    procedure SetStartOfWeek(Value: TDayOfWeek);
    procedure SetUseCurrentDate(Value: Boolean);
    function StoreCalendarDate: Boolean;
    function GetSelection: TCalSelection;
    procedure SetSelection(const Value: TCalSelection);
    function GetDateObjects(ADate: TDateTime): TObject;
    procedure SetDateObjects(ADate: TDateTime; const Value: TObject);
  protected
    procedure Change; dynamic;
    procedure ChangeMonth(Delta: Integer);
    procedure Click; override;
    function DaysPerMonth(AYear, AMonth: Integer): Integer; virtual;
    function DaysThisMonth: Integer; virtual;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    function IsLeapYear(AYear: Integer): Boolean; virtual;
    function SelectCell(ACol, ARow: Longint): Boolean; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property CalendarDate: TDateTime  read FDate write SetCalendarDate stored StoreCalendarDate;
    property CellText[ACol, ARow: Integer]: string read GetCellText;
    procedure NextMonth;
    procedure NextYear;
    procedure PrevMonth;
    procedure PrevYear;
    procedure SelectAll;
    procedure ClearSelection;
    procedure UpdateCalendar; virtual;
    function ObjectsCount: integer;
    function DateObjectByIndex(Index: integer): TObject;
    property DateObjects[ADate: TDateTime]: TObject read GetDateObjects write SetDateObjects;
    property Selection: TCalSelection read GetSelection write SetSelection;
  published
    property Align;
    property Anchors;
    property BorderStyle;
    property Color;
    property Constraints;
    property Ctl3D;
    property Day: Integer index 3  read GetDateElement write SetDateElement stored False;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property GridLineWidth;
    property Month: Integer index 2  read GetDateElement write SetDateElement stored False;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property ShowHint;
    property StartOfWeek: TDayOfWeek read FStartOfWeek write SetStartOfWeek;
    property TabOrder;
    property TabStop;
    property UseCurrentDate: Boolean read FUseCurrentDate write SetUseCurrentDate default True;
    property Visible;
    property Year: Integer index 1  read GetDateElement write SetDateElement stored False;
    property OnClick;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDock;
    property OnStartDrag;
    property OnSelChange: TNotifyEvent read FOnSelChange write FOnSelChange;
  end;

procedure Register;

implementation

uses DateUtils;

procedure Register;
begin
  RegisterComponents('FMA', [TSECalendar]);
end;

{ TSECalendar }

constructor TSECalendar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDateInfo := TStringList.Create;
  { defaults }
  FUseCurrentDate := True;
  FixedCols := 0;
  FixedRows := 1;
  ColCount := 7;
  RowCount := 7;
  ScrollBars := ssNone;
  Options := Options - [goRangeSelect] + [goDrawFocusSelected];
  FDate := Date;
  DefaultDrawing := False;
  UpdateCalendar;
end;

procedure TSECalendar.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TSECalendar.Click;
var
  TheCellText: string;
begin
  inherited Click;
  TheCellText := CellText[Col, Row];
  if TheCellText <> '' then Day := StrToInt(TheCellText);
end;

function TSECalendar.IsLeapYear(AYear: Integer): Boolean;
begin
  Result := (AYear mod 4 = 0) and ((AYear mod 100 <> 0) or (AYear mod 400 = 0));
end;

function TSECalendar.DaysPerMonth(AYear, AMonth: Integer): Integer;
const
  DaysInMonth: array[1..12] of Integer = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
begin
  Result := DaysInMonth[AMonth];
  if (AMonth = 2) and IsLeapYear(AYear) then Inc(Result); { leap-year Feb is special }
end;

function TSECalendar.DaysThisMonth: Integer;
begin
  Result := DaysPerMonth(Year, Month);
end;

procedure TSECalendar.DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
var
  TheText: string;
  FontCol,PenCol: TColor;
  PenStyle: TPenStyle;
  i: integer;
begin
  TheText := CellText[ACol, ARow];
  with ARect, Canvas do begin
    FontCol := Font.Color;
    Brush.Color := Color;
    if (ARow > 0) and (TheText <> '') then begin
      i := StrToInt(TheText);
      if FSelecting then begin
        if ((FSelStart <= i) and (i <= FSelMove)) or
          ((FSelMove <= i) and (i <= FSelStart)) then
          Brush.Color := ColorToRGB(clInactiveCaption);
      end
      else
        if (FSelStart <= i) and (i <= FSelEnd) then
          Brush.Color := ColorToRGB(clInfoBk);
      Font.Color := ColorToRGB(clInfoText);
    end;
    if gdSelected in AState then begin
      Brush.Color := ColorToRGB(clHighlight);
      Font.Color := ColorToRGB(clHighlightText);
    end;
    if gdFixed in AState then begin
      Brush.Color := ColorToRGB(clBtnFace);
      Font.Color := ColorToRGB(clBtnText);
    end;
    FillRect(ARect);
    Font.Color := FontCol;
    TextRect(ARect, Left + (Right - Left - TextWidth(TheText)) div 2,
      Top + (Bottom - Top - TextHeight(TheText)) div 2, TheText);
    if gdFocused in AState then begin
      PenCol := Pen.Color;
      PenStyle := Pen.Style;
      Pen.Color := ColorToRGB(clBlack);
      Pen.Style := psDot;
      Polyline([Point(Left+1,Top+1),Point(Left+1,Bottom-2),Point(Right-2,Bottom-2),
        Point(Right-2,Top+1),Point(Left+1,Top+1)]);
      Pen.Color := PenCol;
      Pen.Style := PenStyle;
    end;
  end;
end;

function TSECalendar.GetCellText(ACol, ARow: Integer): string;
var
  DayNum: Integer;
begin
  if ARow = 0 then  { day names at tops of columns }
    Result := ShortDayNames[(StartOfWeek + ACol) mod 7 + 1]
  else
  begin
    DayNum := FMonthOffset + ACol + (ARow - 1) * 7;
    if (DayNum < 1) or (DayNum > DaysThisMonth) then Result := ''
    else Result := IntToStr(DayNum);
  end;
end;

function TSECalendar.SelectCell(ACol, ARow: Longint): Boolean;
begin
  if ((not FUpdating) and FReadOnly) or (CellText[ACol, ARow] = '') then
    Result := False
  else Result := inherited SelectCell(ACol, ARow);
end;

procedure TSECalendar.SetCalendarDate(Value: TDateTime);
begin
  FDate := Value;
  UpdateCalendar;
  Change;
end;

function TSECalendar.StoreCalendarDate: Boolean;
begin
  Result := not FUseCurrentDate;
end;

function TSECalendar.GetDateElement(Index: Integer): Integer;
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(FDate, AYear, AMonth, ADay);
  case Index of
    1: Result := AYear;
    2: Result := AMonth;
    3: Result := ADay;
    else Result := -1;
  end;
end;

procedure TSECalendar.SetDateElement(Index: Integer; Value: Integer);
var
  AYear, AMonth, ADay: Word;
begin
  if Value > 0 then
  begin
    DecodeDate(FDate, AYear, AMonth, ADay);
    case Index of
      1: if AYear <> Value then AYear := Value else Exit;
      2: if (Value <= 12) and (Value <> AMonth) then AMonth := Value else Exit;
      3: if (Value <= DaysThisMonth) and (Value <> ADay) then ADay := Value else Exit;
      else Exit;
    end;
    FDate := EncodeDate(AYear, AMonth, ADay);
    FUseCurrentDate := False;
    UpdateCalendar;
    Change;
  end;
end;

procedure TSECalendar.SetStartOfWeek(Value: TDayOfWeek);
begin
  if Value <> FStartOfWeek then
  begin
    FStartOfWeek := Value;
    UpdateCalendar;
  end;
end;

procedure TSECalendar.SetUseCurrentDate(Value: Boolean);
begin
  if Value <> FUseCurrentDate then
  begin
    FUseCurrentDate := Value;
    if Value then
    begin
      FDate := Date; { use the current date, then }
      UpdateCalendar;
    end;
  end;
end;

{ Given a value of 1 or -1, moves to Next or Prev month accordingly }
procedure TSECalendar.ChangeMonth(Delta: Integer);
var
  AYear, AMonth, ADay: Word;
  NewDate: TDateTime;
  CurDay: Integer;
begin
  DecodeDate(FDate, AYear, AMonth, ADay);
  CurDay := ADay;
  if Delta > 0 then ADay := DaysPerMonth(AYear, AMonth)
  else ADay := 1;
  NewDate := EncodeDate(AYear, AMonth, ADay);
  NewDate := NewDate + Delta;
  DecodeDate(NewDate, AYear, AMonth, ADay);
  if DaysPerMonth(AYear, AMonth) > CurDay then ADay := CurDay
  else ADay := DaysPerMonth(AYear, AMonth);
  CalendarDate := EncodeDate(AYear, AMonth, ADay);
end;

procedure TSECalendar.PrevMonth;
begin
  ChangeMonth(-1);
end;

procedure TSECalendar.NextMonth;
begin
  ChangeMonth(1);
end;

procedure TSECalendar.NextYear;
begin
  if IsLeapYear(Year) and (Month = 2) and (Day = 29) then Day := 28;
  Year := Year + 1;
end;

procedure TSECalendar.PrevYear;
begin
  if IsLeapYear(Year) and (Month = 2) and (Day = 29) then Day := 28;
  Year := Year - 1;
end;

procedure TSECalendar.UpdateCalendar;
var
  AYear, AMonth, ADay: Word;
  FirstDate: TDateTime;
begin
  FUpdating := True;
  try
    DecodeDate(FDate, AYear, AMonth, ADay);
    FirstDate := EncodeDate(AYear, AMonth, 1);
    FMonthOffset := 2 - ((DayOfWeek(FirstDate) - StartOfWeek + 7) mod 7); { day of week for 1st of month }
    if FMonthOffset = 2 then FMonthOffset := -5;
    MoveColRow((ADay - FMonthOffset) mod 7, (ADay - FMonthOffset) div 7 + 1,
      False, False);
    Invalidate;
  finally
    FUpdating := False;
  end;
end;

procedure TSECalendar.WMSize(var Message: TWMSize);
var
  GridLines: Integer;
begin
  GridLines := 6 * GridLineWidth;
  DefaultColWidth := (Message.Width - GridLines) div 7;
  DefaultRowHeight := (Message.Height - GridLines) div 7;
end;

procedure TSECalendar.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Cell: TGridCoord;
  s: string;
begin
  inherited;
  FSelStart := 0;
  FSelEnd := 0;
  Cell := MouseCoord(X,Y);
  if (Cell.X >= 0) and (Cell.Y >= 0) then begin
    s := GetCellText(Cell.X,Cell.Y);
    if s <> '' then begin
      FSelStart := StrToInt(s);
      FSelMove := FSelStart;
      FSelecting := True;
    end;
  end;
end;

procedure TSECalendar.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i: integer;
begin
  inherited;
  if FSelStart > 0 then begin
    FSelEnd := FSelMove;
    if FSelEnd < FSelStart then begin
      i := FSelStart;
      FSelStart := FSelEnd;
      FSelEnd := i;
    end;
    FSelMove := 0;
    FSelecting := False;
  end;
  if FSelEnd = 0 then FSelStart := 0;
  Repaint;
  if Assigned(FOnSelChange) then FOnSelChange(Self);
end;

procedure TSECalendar.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Cell: TGridCoord;
  s: string;
  i: integer;
begin
  inherited;
  if (FSelStart > 0) and FSelecting then begin
    Cell := MouseCoord(X,Y);
    if (Cell.X >= 0) and (Cell.Y > 0) then begin
      s := GetCellText(Cell.X,Cell.Y);
      if s <> '' then begin
        i := StrToInt(s);
        if FSelMove <> i then begin
          FSelMove := i;
          Repaint;
        end;
      end;
    end;
  end;
end;

procedure TSECalendar.ClearSelection;
begin
  Selection := [];
end;

function TSECalendar.GetSelection: TCalSelection;
begin
  if FSelStart = 0 then
    Result := []
  else
    Result := [FSelStart..FSelEnd];
end;

procedure TSECalendar.SetSelection(const Value: TCalSelection);
var
  i: integer;
begin
  { ONLY first consecutive set members will be selected }
  FSelStart := 0;
  FSelEnd := 0;
  if Value <> [] then
    for i := 1 to DaysInMonth(CalendarDate) do begin
      if FSelStart = 0 then begin
        if i in Value then begin
          FSelStart := i;
          FSelEnd := i;
        end;
      end
      else
        if i in Value then FSelEnd := i
        else break;
    end;
  Repaint;
  if Assigned(FOnSelChange) then FOnSelChange(Self);
end;

procedure TSECalendar.SelectAll;
begin
  Selection := [1..DaysInMonth(CalendarDate)];
end;

destructor TSECalendar.Destroy;
var
  i: integer;
begin
  for i := 0 to FDateInfo.Count-1 do begin
    FDateInfo.Objects[i].Free;
    FDateInfo.Objects[i] := nil;
  end;
  FDateInfo.Free;
  inherited;
end;

function TSECalendar.GetDateObjects(ADate: TDateTime): TObject;
var
  i: integer;
begin
  i := FDateInfo.IndexOf(IntToStr(Trunc(ADate)));
  if i <> -1 then
    Result := FDateInfo.Objects[i]
  else
    Result := nil;
end;

procedure TSECalendar.SetDateObjects(ADate: TDateTime; const Value: TObject);
var
  i: integer;
  s: string;
begin
  s := IntToStr(Trunc(ADate));
  i := FDateInfo.IndexOf(s);
  if i <> -1 then begin
    FDateInfo.Objects[i].Free;
    FDateInfo.Objects[i] := nil;
    if Assigned(Value) then
      FDateInfo.Objects[i] := Value
    else
      FDateInfo.Delete(i);
  end
  else
    FDateInfo.AddObject(s,Value);
end;

function TSECalendar.ObjectsCount: integer;
begin
  Result := FDateInfo.Count;
end;

function TSECalendar.DateObjectByIndex(Index: integer): TObject;
begin
  if (Index >= 0) and (Index < FDateInfo.Count) then
    Result := FDateInfo.Objects[Index]
  else
    Result := nil;
end;

end.
