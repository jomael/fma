unit uConnProgress;

{
*******************************************************************************
* Descriptions: Main Unit for FMA
* $Source: /cvsroot/fma/fma/uConnProgress.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uConnProgress.pas,v $
* Revision 1.7.2.11  2005/11/03 12:16:45  z_stoichev
* crash problem fix by dako.
*
* Revision 1.7.2.10  2005/11/03 11:22:46  z_stoichev
* crash problem fix by mhr.
*
* Revision 1.7.2.9  2005/10/04 10:05:28  expertone
* L10N Fixes
*
* Revision 1.7.2.8  2005/09/20 06:54:25  z_stoichev
* AV bugfixes
*
* Revision 1.7.2.7  2005/09/19 20:54:28  z_stoichev
* Progress dialog Crash issue workaround.
*
* Revision 1.7.2.6  2005/09/19 08:53:48  z_stoichev
* Bugfixes.
*
* Revision 1.7.2.5  2005/09/17 12:13:22  z_stoichev
* Added Task ID refference.
*
* Revision 1.7.2.4  2005/09/16 10:33:41  z_stoichev
* Fixed List Height, changed paint method.
*
* Revision 1.7.2.3  2005/09/16 02:00:41  z_stoichev
* New progress dialog with multitask support.
*
* Revision 1.7.2.2  2005/09/06 18:32:55  z_stoichev
* Bugfixes and improvements (2.1.1.102b)
*
* Revision 1.7.2.1  2005/08/22 23:56:05  z_stoichev
* Various GUI changes and bugfixes.
*
* Revision 1.7  2005/02/08 15:38:34  voxik
* Merged with L10N branch
*
* Revision 1.6.12.3  2005/01/27 13:33:34  voxik
* Fixed Unicode support
*
* Revision 1.6.12.2  2004/10/25 20:21:39  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.6.12.1  2004/10/19 19:48:37  expertone
* Add localization (gnugettext)
*
* Revision 1.6  2004/07/07 08:10:46  z_stoichev
* Common Wizard Image usage
*
* Revision 1.5  2003/12/11 11:56:16  z_stoichev
* Fixed multiple progress + uploads issue
*
* Revision 1.4  2003/11/28 09:38:07  z_stoichev
* Merged with branch-release-1-1 (Fma 0.10.28c)
*
* Revision 1.3.2.3  2003/11/11 18:10:01  z_stoichev
* Use common background.
*
* Revision 1.3.2.2  2003/10/31 14:51:58  z_stoichev
* Change color scheme, add background image.
*
* Revision 1.3.2.1  2003/10/27 07:22:54  z_stoichev
* Build 0.1.0 RC1 Initial Checkin.
*
* Revision 1.3  2003/10/22 13:15:04  z_stoichev
* Make progress dialog optional.
*
*
*
}

interface

uses
  Windows, Variants, 
  TntWindows, Messages, SysUtils, TntSysUtils, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, ExtCtrls, TntExtCtrls, StdCtrls, TntStdCtrls, ComCtrls, TntComCtrls, UniTntCtrls, Buttons, TntButtons,
  SEProgress, jpeg, VirtualTrees, StrUtils;

type
  TTaskData = record
    Captions: TTntStringList;
    ProgressBar: TSEProgress;
    ListNode: PVirtualNode;
    Initialized: boolean;
  end;
  PTaskData = ^TTaskData;

  { Do not create/destroy this form by yourself!!!
    Instead use two methods bellow:
      - GetProgressDialog
      - FreeProgressDialog }
  TfrmConnect = class(TTntForm)
    AbortButton: TTntButton;
    Timer2: TTimer;
    Timer1: TTimer;
    HideButton: TTntButton;
    ListTasks: TVirtualDrawTree;
    cbDontShow: TTntCheckBox;
    procedure AbortButtonClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure HideButtonClick(Sender: TObject);
    procedure ListTasksFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure ListTasksDrawNode(Sender: TBaseVirtualTree;
      const PaintInfo: TVTPaintInfo);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
    procedure NotifyStatusBar;
    function HasUnknownMaxTask: boolean;
    function GetCurrentTask: PTaskData;
    function GetTask(ID: Integer): PTaskData;
    function Get_TaskID: Integer;
  protected
    procedure CreateTask(AName: WideString; MaxProgress: Integer = -1);
    procedure DeleteCurrentTask;
  public
    { Public declarations }
    procedure ShowProgress(Delayed: boolean = False);

    procedure Initialize(MaxProgress: integer; Descr: WideString = '');
    procedure InitializeLoop(Descr: WideString = ''); // Unknown Max
    procedure SetDescr(Descr: WideString; TaskID: Integer = -1);
    procedure IncProgress(Delta: integer; TaskID: Integer = -1);

    procedure SetMaxProgress(MaxProgress: integer);
    procedure ClearMaxProgress;

    property CurrentTaskID: Integer read Get_TaskID;
  end;

var
  frmConnect: TfrmConnect;

{ Returns the current progress form and creates a new progres task into it.
  WARNING!!! Should not free it manually! Instead call FreeProgressDialog! }
function GetProgressDialog(AllowCreateNew: Boolean = True): TfrmConnect;

{ Release progress form usage. }
procedure FreeProgressDialog;

implementation

uses
  gnugettext, gnugettexthelpers,
  Unit1, Types;

{$R *.dfm}

resourcestring
  sDefaultTaskName = 'Working...';

const
  ProgressUsage: integer = 0;

function GetProgressDialog(AllowCreateNew: Boolean): TfrmConnect;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to Screen.FormCount-1 do
    if Screen.Forms[i] is TfrmConnect then begin
      Result := Screen.Forms[i] as TfrmConnect;
      break;
    end;
  if AllowCreateNew and not Assigned(Result) then begin
    frmConnect := TfrmConnect.Create(Application);
    Result := frmConnect;
  end;
  if Assigned(Result) then begin
    Result.CreateTask(sDefaultTaskName);
    inc(ProgressUsage);
  end;
end;

procedure FreeProgressDialog;
begin
  if Assigned(frmConnect) then begin
    frmConnect.DeleteCurrentTask;
    dec(ProgressUsage);
    if ProgressUsage = 0 then begin
      frmConnect.Free;
      frmConnect := nil;
    end;
  end;
end;

{ TfrmConnect }

procedure TfrmConnect.Initialize(MaxProgress: integer; Descr: WideString);
var
  t: PTaskData;
begin
  t := GetCurrentTask;
  if not Assigned(t) then exit;

  if Descr <> '' then
    t^.Captions.Text := Descr;
  t^.ProgressBar.Position := 0;
  t^.ProgressBar.Max := MaxProgress;
  if Visible then
    ListTasks.InvalidateNode(t^.ListNode);
  Timer1.Enabled := HasUnknownMaxTask;
end;

procedure TfrmConnect.AbortButtonClick(Sender: TObject);
begin
  Form1.ActionConnectionAbort.Execute;
end;

procedure TfrmConnect.SetDescr(Descr: WideString; TaskID: Integer = -1);
var
  t: PTaskData;
begin
  if TaskID = -1 then
    t := GetCurrentTask
  else
    t := GetTask(TaskID);
  if not Assigned(t) then exit;

  t^.Captions.Text := Descr;
  if Visible then
    ListTasks.InvalidateNode(t^.ListNode);
end;

procedure TfrmConnect.IncProgress(Delta: integer; TaskID: Integer = -1);
var
  t: PTaskData;
begin
  if TaskID = -1 then
    t := GetCurrentTask
  else
    t := GetTask(TaskID);
  if not Assigned(t) then exit;

  t^.ProgressBar.Position := t^.ProgressBar.Position + Delta;
  if Visible then
    ListTasks.InvalidateNode(t^.ListNode);
  NotifyStatusBar;
end;

procedure TfrmConnect.ShowProgress(Delayed: boolean = False);
var
  t: PTaskData;
begin
  t := GetCurrentTask;
  if not Assigned(t) then exit;

  Form1.SetTaskPercentage(0); // show indicator in status bar at start/zero position
  if Form1.CanShowProgressDialog then
    if Delayed and not Visible then
      Timer2.Enabled := True
    else
      Timer2Timer(nil);
end;

procedure TfrmConnect.Timer2Timer(Sender: TObject);
begin
  Timer2.Enabled := False;
  Show;
  Update;
end;

procedure TfrmConnect.FormCreate(Sender: TObject);
begin
  gghTranslateComponent(self);

  //Image1.Picture.Assign(Form1.CommonBitmaps.Bitmap[1]);
  ListTasks.NodeDataSize := SizeOf(TTaskData);
end;

procedure TfrmConnect.NotifyStatusBar;
var
  t: PTaskData;
begin
  t := GetCurrentTask;
  if not Assigned(t) then exit;

  with t^.ProgressBar do
    Form1.SetTaskPercentage(Position,Max,UnknownMax);
end;

procedure TfrmConnect.FormDestroy(Sender: TObject);
begin
  Timer2.Enabled := False;
  Timer1.Enabled := False;
  Form1.SetTaskPercentage(-1); // hide indicator in status bar
  ListTasks.Clear;
end;

procedure TfrmConnect.Timer1Timer(Sender: TObject);
const
  Sem: boolean = False;
var
  t: PTaskData;
  i,k: Integer;
begin
  if not Sem then begin
    Sem := True;
    k := ListTasks.ChildCount[nil]-1;
    for i := k downto 0 do begin
      t := GetTask(i);
      if Assigned(t) and t^.ProgressBar.UnknownMax then begin
        t^.ProgressBar.StepForward;
        if Visible then
          ListTasks.InvalidateNode(t^.ListNode);
        if i = k then
          NotifyStatusBar;
      end;
    end;
    Sem := False;
  end;
end;

procedure TfrmConnect.InitializeLoop(Descr: WideString);
var
  t: PTaskData;
begin
  t := GetCurrentTask;
  if not Assigned(t) then exit;

  if Descr <> '' then
    t^.Captions.Text := Descr;
  t^.ProgressBar.Position := 0;
  t^.ProgressBar.UnknownMax := True;
  if Visible then
    ListTasks.InvalidateNode(t^.ListNode);
  Timer1.Enabled := HasUnknownMaxTask;
end;

procedure TfrmConnect.CreateTask(AName: WideString; MaxProgress: Integer);
var
  t: PTaskData;
  n: PVirtualNode;
begin
  ListTasks.NodeDataSize := SizeOf(TTaskData);
  n := ListTasks.AddChild(nil);
  t := ListTasks.GetNodeData(n);
  try
    t^.ListNode := n;
    t^.Captions := TTntStringList.Create;
    t^.Captions.Text := AName;
    t^.ProgressBar := TSEProgress.Create(Self);
    t^.ProgressBar.Visible := False; // hide outside parent visible area
    t^.ProgressBar.Parent := ListTasks;
    t^.ProgressBar.Frame := 1;
    t^.ProgressBar.ShowBorder := False;
    t^.ProgressBar.BarColor := clHighlight;
    t^.ProgressBar.Color := clDkGray;
    t^.ProgressBar.UnknownWidth := 25;
    if MaxProgress <> -1 then
      t^.ProgressBar.Max := MaxProgress;
    t^.Initialized := True;  
    Timer1.Enabled := HasUnknownMaxTask;
  except
    ListTasks.DeleteNode(n);
  end;
end;

procedure TfrmConnect.DeleteCurrentTask;
var
  n: PVirtualNode;
begin
  n := ListTasks.GetLast(nil);
  if Assigned(n) then begin
    ListTasks.DeleteNode(n);
    Timer1.Enabled := HasUnknownMaxTask;
  end;
end;

function TfrmConnect.GetCurrentTask: PTaskData;
begin
  Result := GetTask(ListTasks.ChildCount[nil]-1);
end;

procedure TfrmConnect.ClearMaxProgress;
var
  t: PTaskData;
begin
  t := GetCurrentTask;
  if not Assigned(t) then exit;

  t^.ProgressBar.UnknownMax := True;
end;

procedure TfrmConnect.SetMaxProgress(MaxProgress: integer);
var
  t: PTaskData;
begin
  t := GetCurrentTask;
  if not Assigned(t) then exit;

  t^.ProgressBar.Max := MaxProgress;
end;

function TfrmConnect.HasUnknownMaxTask: boolean;
var
  t: PTaskData;
  i: Integer;
begin
  Result := False;
  for i := ListTasks.ChildCount[nil]-1 downto 0 do begin
    t := GetTask(i);
    if Assigned(t) and t^.ProgressBar.UnknownMax then begin
      Result := True;
      break;
    end;
  end;
end;

procedure TfrmConnect.HideButtonClick(Sender: TObject);
begin
  Hide;
end;

procedure TfrmConnect.ListTasksFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  t: PTaskData;
begin
  t := ListTasks.GetNodeData(Node);
  if Assigned(t) then begin
    t^.Initialized := False;
    if Assigned(t^.Captions) then begin
      t^.Captions.Text := '';
      t^.Captions.Free;
      t^.Captions := nil;
    end;
    if Assigned(t^.ProgressBar) then begin
      t^.ProgressBar.Parent := nil;
      t^.ProgressBar.Free;
      t^.ProgressBar := nil;
    end;
  end;
end;

procedure TfrmConnect.ListTasksDrawNode(Sender: TBaseVirtualTree; const PaintInfo: TVTPaintInfo);
const
  Sem: boolean = False;
var
  t: PTaskData;
  w: WideString;
  i: Integer;
  function GetTextLeft(AText: WideString): Integer;
  begin
    { BiDi support here }
    if IsRightToLeft then begin
      Result := PaintInfo.ContentRect.Right-PaintInfo.Canvas.TextWidth(AText)-ListTasks.TextMargin;
    end
    else
      Result := PaintInfo.ContentRect.Left+ListTasks.TextMargin-2;
  end;
begin
  if Sem then exit; // avoid StackOverflow exception and application shutdown issue !!! SOLVED
  Sem := True;
  try
    PaintInfo.Canvas.FillRect(PaintInfo.CellRect);
    t := ListTasks.GetNodeData(PaintInfo.Node);
    if not Assigned(t) or not t^.Initialized then
      exit;

    if PaintInfo.Column = 0 then begin
      with PaintInfo do begin
        Canvas.Font.Assign(ListTasks.Font);
        if Canvas.Brush.Color = clHighlight then
          Canvas.Font.Color := clHighlightText
        else
          Canvas.Font.Color := clWindowText;
        { Paint text }
        if t^.Captions.Count >= 1 then
          Canvas.TextOut(GetTextLeft(t^.Captions[0]),ContentRect.Top+2,t^.Captions[0]);
        if Canvas.Font.Color = clWindowText then
          Canvas.Font.Color := clDkGray;
        w := '';
        if t^.Captions.Count >= 2 then begin
          w := t^.Captions[1];
          for i := 2 to t^.Captions.Count-1 do
            w := w + ' ' + t^.Captions[i];
        end
        else
        if not t^.ProgressBar.UnknownMax and (t^.ProgressBar.Max <> 0) then
          w := WideFormat(_('%d%% ready'),[100 * t^.ProgressBar.Position div t^.ProgressBar.Max])
        else
          if WideCompareStr(sDefaultTaskName,t^.Captions[0]) <> 0 then w := sDefaultTaskName;
        if w <> '' then
          Canvas.TextOut(GetTextLeft(w),ContentRect.Top+15,w);
      end;
    end
    else
    if PaintInfo.Column = 1 then begin
      { Paint progress bar }
      t^.ProgressBar.Width := PaintInfo.ContentRect.Right-PaintInfo.ContentRect.Left-ListTasks.TextMargin-4;
      t^.ProgressBar.Height := ListTasks.DefaultNodeHeight-17;
      { PaintTo() will trigger reccursive call to this handler, so we use a Semafor }
      t^.ProgressBar.PaintTo(PaintInfo.Canvas,PaintInfo.ContentRect.Left+2,PaintInfo.ContentRect.Top+8);
    end;
  finally
    Sem := False;
  end;
end;

procedure TfrmConnect.FormShow(Sender: TObject);
begin
  cbDontShow.Checked := False;
  HideButton.SetFocus;
end;

procedure TfrmConnect.FormHide(Sender: TObject);
begin
  if cbDontShow.Checked then begin
    Form1.FProgressIndicatorOnly := True;
    Form1.FormStorage1.StoredValue['Progress Indicator'] := True; // do not localize
  end;
end;

function TfrmConnect.Get_TaskID: Integer;
var
  n: PVirtualNode;
begin
  Result := -1;
  n := ListTasks.GetLast(nil);
  if Assigned(n) then
    Result := n.Index;
end;

function TfrmConnect.GetTask(ID: Integer): PTaskData;
var
  Node: PVirtualNode;
  Data: PTaskData;
begin
  Result := nil;
  if ID < 0 then exit;
  Node := ListTasks.GetFirst;
  while Assigned(Node) do begin
    if Node.Index = cardinal(ID) then begin
      Data := ListTasks.GetNodeData(Node);
      if Assigned(Data) and Data^.Initialized then
        Result := Data;
      break;
    end;
    Node := ListTasks.GetNext(Node);
  end;
end;

end.

