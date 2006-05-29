unit UniTntCtrls;

interface

uses
  Classes,
  ComCtrls,
  Controls,
  TntControls,
  TntMenus,
  Messages;

{
  Gabriel Corneanu:

  This is a unit to replace a standard TToolButton to a Unicode capable button.
  It is based on Tnt controls and follows the same ideas.
  A problem is how to simply exchange the controls from design to these versions
  WITHOUT registering as a new component and replacing all buttons on all forms.

  One solution is to use the ReadState method of a form to assign an OnFindComponent
  event on the reader and there replace a class against the new one.
  This envolves a lot of work, and there is another solution: the same class name is
  redefined here and it will be used if this class is used by the compiler
  INSTEAD of the original one;
  to achieve this, this unit must be used in the "uses" clause AFTER the original
  unit which defines the class (in this case "ComCtrls"), in the interface part too.

  The tool button has an extra property ("WholeDropDown") that enables the
  BTNS_WHOLEDROPDOWN style; read MSDN for details
}

const
  BTNS_WHOLEDROPDOWN = $0080;

type
  TToolButton = class(ComCtrls.TToolButton)
  private
    FWholeDropDown: boolean;
    FMenuItem: TTntMenuItem;
    FDropdownMenu: TTntPopupMenu;
    function GetHint: WideString;
    procedure SetHint(const Value: WideString);
    procedure SetCaption(const Value: WideString);
    function GetCaption: WideString;
    procedure SetWholeDropDown(const Value: boolean);
    function IsCaptionStored: Boolean;
    function IsHintStored: Boolean;
    procedure SetMenuItem(Value: TTntMenuItem);
    procedure SetDropdownMenu(Value: TTntPopupMenu);
  protected
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
    //procedure DefineProperties(Filer: TFiler); override;
    function GetActionLinkClass: TControlActionLinkClass; override;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Hint: WideString read GetHint write SetHint stored IsHintStored;
    property Caption: WideString read GetCaption write SetCaption stored IsCaptionStored;
    property WholeDropDown: boolean read FWholeDropDown write SetWholeDropDown default false;
    property MenuItem: TTntMenuItem read FMenuItem write SetMenuItem;
    property DropdownMenu: TTntPopupMenu read FDropdownMenu write SetDropdownMenu;
  end;

  TToolBar = class(ComCtrls.TToolBar)
  private
    FTempWideString: WideString;
    FMenu: TTntMainMenu;
    function CheckBtnMsg(var Message: TMessage): boolean;
    function GetCaption: WideString;
    procedure SetCaption(const Value: WideString);
    function GetHint: WideString;
    function IsCaptionStored: Boolean;
    function IsHintStored: Boolean;
    procedure SetHint(const Value: WideString);
    procedure SetMenu(const Value: TTntMainMenu);
  protected
    procedure WndProc(var Message: TMessage); override;
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
  public
  published
    property Hint: WideString read GetHint write SetHint stored IsHintStored;
    property Caption: WideString read GetCaption write SetCaption stored IsCaptionStored;
    property Menu: TTntMainMenu read FMenu write SetMenu;
  end;

implementation

uses
  CommCtrl,
  TntActnList,
  TntSysUtils,
  SysUtils;

{ Methods of TToolButton }

constructor TToolButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FWholeDropDown := false;
end;

procedure TToolButton.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TTntAction then
    with TTntAction(Sender) do
      begin
        if not CheckDefaults or (Self.Caption = '') or (Self.Caption = Self.Name) then
          Self.Caption := Caption;
        if not CheckDefaults or (Self.Hint = '') then
          Self.Hint := Hint;
      end;
end;

procedure TToolButton.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    begin
      if AComponent = DropdownMenu then
        DropdownMenu := nil
      else if AComponent = MenuItem then
        MenuItem := nil;
    end;
end;

procedure TToolButton.CMHintShow(var Message: TMessage);
begin
  ProcessCMHintShowMsg(Message);
  inherited;
end;

function TToolButton.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TntControl_GetActionLinkClass(Self, TToolButtonActionLink);
end;

procedure TToolButton.SetCaption(const Value: WideString);
begin
  TntControl_SetText(Self, Value);
end;

function TToolButton.GetHint: WideString;
begin
  Result := TntControl_GetHint(Self)
end;

function TToolButton.GetCaption: WideString;
begin
  Result := TntControl_GetText(Self);
end;

procedure TToolButton.SetHint(const Value: WideString);
begin
  TntControl_SetHint(Self, Value);
end;

procedure TToolButton.SetWholeDropDown(const Value: boolean);
begin
  if FWholeDropDown <> Value then
    begin
      FWholeDropDown := Value;
      RefreshControl;
    end;
end;

function TToolButton.IsCaptionStored: Boolean;
begin
  Result := TntControl_IsCaptionStored(Self)
end;

function TToolButton.IsHintStored: Boolean;
begin
  Result := TntControl_IsHintStored(Self)
end;

procedure TToolButton.SetMenuItem(Value: TTntMenuItem);
begin
  { Copy all appropriate values from menu item }
  if Value <> nil then
    begin
      if FMenuItem <> Value then
        Value.FreeNotification(Self);
      Action := Value.Action;
      Caption := Value.Caption;
      Down := Value.Checked;
      Enabled := Value.Enabled;
      Hint := Value.Hint;
      ImageIndex := Value.ImageIndex;
      Visible := Value.Visible;
    end;
  FMenuItem := Value;
end;

procedure TToolButton.SetDropdownMenu(Value: TTntPopupMenu);
begin
  if Value <> FDropdownMenu then
    begin
      FDropdownMenu := Value;
      if Value <> nil then
        Value.FreeNotification(Self);
    end;
end;

{ TToolBar }

function TToolBar.CheckBtnMsg(var Message: TMessage): boolean;
var
  B: UniTntCtrls.TToolButton;

  function CheckButton(ACtrl: TControl; var Style: Byte): boolean;
  begin
    Result := ACtrl.InheritsFrom(UniTntCtrls.TToolButton);
    if Result then
      begin
        B := UniTntCtrls.TToolButton(ACtrl);
        Result := B.FWholeDropDown;
        if Result and (GetComCtlVersion >= ComCtlVersionIE5) then
          Style := Style or BTNS_WHOLEDROPDOWN;
      end;
  end;
var
  BT: PTBButton;
  BI: PTBButtonInfoW;
  T: string;
begin
  Result := false;
  B := nil;
  if Message.Msg = TB_INSERTBUTTON then
    begin
      BT := PTBButton(Message.LParam);
      CheckButton(TControl(BT.dwData), BT.fsStyle);
      if (B <> nil) and ShowCaptions and (BT.iString <> -1) and Win32PlatformIsUnicode then
        begin
          FTempWideString := B.Caption;
          if (WideString(AnsiString(FTempWideString)) <> FTempWideString) then
            begin
              //here 2 nulls are needed
              FTempWideString := FTempWideString + #0;
              BT.iString := Self.Perform(TB_ADDSTRINGW, 0, Longint(PWideChar(FTempWideString)));
            end;
        end;
    end
  else if Message.Msg = TB_SETBUTTONINFO then
    begin
      BI := PTBButtonInfoW(Message.LParam);
      CheckButton(TControl(BI.lParam), BI.fsStyle);
      if (B <> nil) and ShowCaptions and (BI.cchText > 0) and Win32PlatformIsUnicode then
        begin
          T := PChar(BI.pszText);
          FTempWideString := B.Caption;
          if WideString(T) <> FTempWideString then
            begin
              Message.Msg := TB_SETBUTTONINFOW;
              BI.cchText := Length(FTempWideString);
              BI.pszText := PWideChar(FTempWideString);
            end;
        end;
    end;
end;

procedure TToolBar.CMHintShow(var Message: TMessage);
begin
  ProcessCMHintShowMsg(Message);
  inherited;
end;

function TToolBar.GetCaption: WideString;
begin
  Result := TntControl_GetText(Self);
end;

function TToolBar.GetHint: WideString;
begin
  Result := TntControl_GetHint(Self);
end;

function TToolBar.IsCaptionStored: Boolean;
begin
  Result := TntControl_IsCaptionStored(Self);
end;

function TToolBar.IsHintStored: Boolean;
begin
  Result := TntControl_IsHintStored(Self);
end;

procedure TToolBar.SetCaption(const Value: WideString);
begin
  TntControl_SetText(Self, Value);
end;

procedure TToolBar.SetHint(const Value: WideString);
begin
  TntControl_SetHint(Self, Value);
end;

procedure TToolBar.WndProc(var Message: TMessage);
var
  Handled: boolean;
begin
  Handled := CheckBtnMsg(Message);
  if not Handled then
    inherited WndProc(Message);
end;

procedure TToolBar.SetMenu(const Value: TTntMainMenu);
var
  I: Integer;

  procedure SetMenuItem(T:TToolButton; Value: TTntMenuItem);
  begin
    { Copy all appropriate values from menu item }
    if Value <> nil then
      begin
        if T.MenuItem <> Value then
          Value.FreeNotification(T);
        T.Action := Value.Action;
        T.Caption := Value.Caption;
        T.Down := Value.Checked;
        T.Enabled := Value.Enabled;
        T.Hint := Value.Hint;
        T.ImageIndex := Value.ImageIndex;
        T.Visible := Value.Visible;
      end;
    T.MenuItem := Value;
    ComCtrls.TToolButton(T).MenuItem := Value;
{  if Value <> nil then
  begin
    if FMenuItem <> Value then
      Value.FreeNotification(Self);
    Action := Value.Action;
    Caption := Value.Caption;
    Down := Value.Checked;
    Enabled := Value.Enabled;
    Hint := Value.Hint;
    ImageIndex := Value.ImageIndex;
    Visible := Value.Visible;
  end;
  FMenuItem := Value;   }

  end;

begin
  if FMenu = Value then
    exit;
  if csAcceptsControls in ControlStyle then
    begin
      ControlStyle := [csCaptureMouse, csClickEvents,
        csDoubleClicks, csMenuEvents, csSetCaption];
      RecreateWnd;
    end;
  ShowCaptions := True;
  if Assigned(FMenu) then
    for I := ButtonCount - 1 downto 0 do
      Buttons[I].Free;

  if Assigned(FMenu) then
    FMenu.RemoveFreeNotification(Self);
  FMenu := Value;
  if not Assigned(FMenu) then
    exit;
  FMenu.FreeNotification(Self);

  for I := ButtonCount to FMenu.Items.Count - 1 do
    begin
      with TToolButton.Create(Self) do
        try
          AutoSize := True;
          Grouped := True;
          Parent := Self;
          //MenuItem.Assign(FMenu.Items[I]);
          //Buttons[I].MenuItem := FMenu.Items[I];
        except
          Free;
          raise;
        end;
    end;
  { Copy attributes from each menu item }
  for I := 0 to FMenu.Items.Count - 1 do
    SetMenuItem(TToolButton(Buttons[I]), TTntMenuItem(FMenu.Items[I]));
end;

procedure TToolBar.CMDialogChar(var Message: TCMDialogChar);
var
  Button: TToolButton;
begin
  if Enabled and Showing and ShowCaptions then
  begin
    Button := TToolButton(FindButtonFromAccel(Message.CharCode));
    if Button <> nil then
    begin
      { Display a drop-down menu after hitting the accelerator key if IE3
        is installed. Otherwise, fire the OnClick event for IE4. We do this
        because the IE4 version of the drop-down metaphor is more complete,
        allowing the user to click a button OR drop-down its menu. }
      if ((Button.Style <> tbsDropDown) or (GetComCtlVersion < ComCtlVersionIE4)) and
        ((Button.DropdownMenu <> nil) or (Button.MenuItem <> nil)) then
        TrackMenu(Button)
      else
        Button.Click;
      Message.Result := 1;
      Exit;
    end;
  end;
  inherited;
end;

end.

