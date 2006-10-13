unit uScriptEditor;

{
*******************************************************************************
* Descriptions: Script Editor
* $Source: /cvsroot/fma/fma/uScriptEditor.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uScriptEditor.pas,v $
*
*******************************************************************************
}

interface

uses 
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms, Dialogs, TntDialogs,
  ExtCtrls, TntExtCtrls, StdCtrls, TntStdCtrls, ComCtrls, TntComCtrls, UniTntCtrls, Menus, TntMenus, SynEditHighlighter,
  SynEdit, SynMemo, Buttons, TntButtons, SynHighlighterVBScript, aw_SCtrl;

type
  TfrmEditor = class(TTntFrame)
    MessagesPanel: TTntPanel;
    MessagesSplitter1: TTntSplitter;
    Panel1: TTntPanel;
    sbClose: TTntSpeedButton;
    MessagesMemo1: TTntMemo;
    PrecompileTimer1: TTimer;
    SynVBScriptSyn1: TSynVBScriptSyn;
    PopupMenu1: TTntPopupMenu;
    Delete1: TTntMenuItem;
    N2: TTntMenuItem;
    SelectAll1: TTntMenuItem;
    SaveChanges1: TTntMenuItem;
    N4: TTntMenuItem;
    FindNextError1: TTntMenuItem;
    ReplaceDialog1: TReplaceDialog;
    N5: TTntMenuItem;
    Find1: TTntMenuItem;
    FindNext1: TTntMenuItem;
    Replace1: TTntMenuItem;
    LoadFromFile1: TTntMenuItem;
    Panel2: TPanel;
    DetailsPanel: TTntPanel;
    Script: TSynMemo;
    OpenDialog1: TTntOpenDialog;
    SaveDialog1: TTntSaveDialog;
    sbSave: TSpeedButton;
    lblCaption: TTntLabel;
    N6: TTntMenuItem;
    N1: TTntMenuItem;
    ScriptingOptions1: TTntMenuItem;
    procedure ScriptStatusChange(Sender: TObject;
      Changes: TSynStatusChanges);
    procedure sbCloseClick(Sender: TObject);
    procedure MessagesSplitter1Moved(Sender: TObject);
    procedure MessagesMemo1Change(Sender: TObject);
    procedure PrecompileTimer1Timer(Sender: TObject);
    procedure ScriptChange(Sender: TObject);
    procedure ScriptReplaceText(Sender: TObject; const ASearch,
      AReplace: String; Line, Column: Integer;
      var Action: TSynReplaceAction);
    procedure ScriptControlError(Sender: TObject; Error: TawScriptError);
    procedure SaveChanges1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure FindNextError1Click(Sender: TObject);
    procedure ReplaceDialog1Find(Sender: TObject);
    procedure Find1Click(Sender: TObject);
    procedure FindNext1Click(Sender: TObject);
    procedure Replace1Click(Sender: TObject);
    procedure LoadFromFile1Click(Sender: TObject);
    procedure ScriptingOptions1Click(Sender: TObject);
  private
    { Private declarations }
    FFilename: string;
    FEngineStartAsk: boolean;
    procedure DoShowCaretInfo;
    function Get_MessagesVisible: boolean;
    procedure Set_MessagesVisible(const Value: boolean);
    procedure Set_Filename(const Value: string);
  public
    { Public declarations }
    procedure Initialize;
    procedure Finalize;

    procedure FindReplace(Find,Replace: string; Backwards,WholeWord,ReplaceAll: boolean);

    function CheckFilename: String;

    property MessagesVisible: boolean read Get_MessagesVisible write Set_MessagesVisible;
    property Filename: string read FFilename write Set_Filename;
  end;

implementation

uses
  gnugettext, gnugettexthelpers,
  Unit1, uDialogs;

{$R *.dfm}

procedure TfrmEditor.DoShowCaretInfo;
var
  s,d: string;
begin
  d := Filename;
  if d = '' then d := _('Noname.vbs');
  s := Format(' %s: %.5d  %s: %.5d  %s: %.5d  %s: %.7d',
    [_('Row'),Script.CaretY,_('Col'),Script.CaretX,_('Lines'),Script.Lines.Count,_('Chars'),Length(Script.Text)]);
  if not Script.InsertMode then
    s := s + '  ' + _('Overwrite');
  s := s + '  [' + d + ']';
  lblCaption.Caption := s;
  sbSave.Left := lblCaption.Left + lblCaption.Width + 4;
  sbSave.Visible := Script.Modified;
end;

function TfrmEditor.Get_MessagesVisible: boolean;
begin
  Result := MessagesPanel.Visible;
end;

procedure TfrmEditor.Initialize;
begin
  FEngineStartAsk := True;
  DoShowCaretInfo;
  PrecompileTimer1.Enabled := Visible and not Application.Terminated;
  if not Form1.FUseScript then
    Form1.Status(_('Scripting Engine is disabled in FMA Options'));
end;

procedure TfrmEditor.ScriptStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  if [scInsertMode, scModified, scCaretX, scCaretY] * Changes <> [] then
    DoShowCaretInfo;
end;

procedure TfrmEditor.Set_MessagesVisible(const Value: boolean);
begin
  MessagesPanel.Visible := Value;
  MessagesSplitter1.Visible := Value;
  if Value then
    MessagesSplitter1.Top := MessagesPanel.Top-1
  else
    MessagesMemo1.Lines.Clear;
  Update;
end;

procedure TfrmEditor.sbCloseClick(Sender: TObject);
begin
  MessagesVisible := False;
end;

procedure TfrmEditor.MessagesSplitter1Moved(Sender: TObject);
begin
  if MessagesPanel.Height < MessagesSplitter1.MinSize then
    MessagesPanel.Height := MessagesSplitter1.MinSize;
end;

procedure TfrmEditor.MessagesMemo1Change(Sender: TObject);
begin
  MessagesVisible := MessagesMemo1.Lines.Count <> 0;
end;

procedure TfrmEditor.PrecompileTimer1Timer(Sender: TObject);
var
  ScriptControl: TawScriptControl;
  ext: string;
begin
  PrecompileTimer1.Enabled := False;
  try
    ext := ExtractFileExt(Filename);
    if ext = '' then ext := '.vbs'; // do not localize
    ScriptControl := TawScriptControl.Create(Self);
    try
      ScriptControl.AllowUI := False;
      ScriptControl.Timeout := 30000;
      ScriptControl.OnError := ScriptControlError;
      ScriptControl.Language := Copy(ext, 2, length(ext)-1);
      (*
      ScriptControl.AutoObjects.BeginUpdate;
      try
        with ScriptControl.AutoObjects.Add do begin
          AutoObject := TMobileAgentApp.Create;  { TODO -oLordLarry : Memory Leak. AWScript is full of leaks }
          AutoObjectName := 'fma'; // do not localize
        end;
        with ScriptControl.AutoObjects.Add do begin
          AutoObject := TAccessoriesMenu.Create;
          AutoObjectName := 'am'; // do not localize
        end;
      finally
        ScriptControl.AutoObjects.EndUpdate;
      end;
      try
        ScriptControl.Code.Assign(Script.Lines);
        MessagesVisible := False;
      finally
        ScriptControl.AutoObjects.Clear;
      end;
      *)
      ScriptControl.Code.Assign(Script.Lines);
      MessagesVisible := False;
    finally
      ScriptControl.Code.Clear;
      ScriptControl.Free;
    end;
  except
  end;  
end;

procedure TfrmEditor.ScriptChange(Sender: TObject);
begin
  PrecompileTimer1.Enabled := False;
  PrecompileTimer1.Enabled := True;
end;

procedure TfrmEditor.FindReplace(Find, Replace: string; Backwards,
  WholeWord, ReplaceAll: boolean);
var
  so: TSynSearchOptions;
  sl: string;
begin
  sl := Script.SelText;
  so := [];
  if Backwards then so := so + [ssoBackwards];
  if WholeWord then so := so + [ssoWholeWord];
  if (sl <> '') and (AnsiCompareText(Script.SelText,Find) <> 0) then
    so := so + [ssoSelectedOnly];
  if AnsiCompareText(Find,Replace) <> 0 then so := so + [ssoReplace];
  if ReplaceAll then so := so + [ssoReplaceAll];
  if [ssoReplace,ssoReplaceAll] * so <> [] then so := so + [ssoPrompt];
  Script.SearchReplace(Find,Replace,so);
end;

procedure TfrmEditor.ScriptReplaceText(Sender: TObject; const ASearch,
  AReplace: String; Line, Column: Integer; var Action: TSynReplaceAction);
begin
  MessageBeep(MB_ICONQUESTION);
  // TODO: Add unicode suppport.
  case MessageDlg(_('Do you want to replace this text?'),mtConfirmation,[mbYes,mbNo,mbCancel,mbAll],0) of
    mrYes: Action := raReplace;
    mrNo: Action := raSkip;
    mrCancel: Action := raCancel;
    mrAll: Action := raReplaceAll;
  end;
end;

procedure TfrmEditor.ScriptControlError(Sender: TObject;
  Error: TawScriptError);
begin
  if not MessagesVisible then begin
    Script.CaretX := Error.Column+1;
    Script.CaretY := Error.Line;
  end;
  MessagesMemo1.Lines.Text := Format(_('Error at line %d, col %d:'+sLinebreak+'Reason: %s'),
    [Error.Line,Error.Column+1,Error.Description]);
end;

procedure TfrmEditor.SaveChanges1Click(Sender: TObject);
begin
  { If script engine is not running, ask to start it, but only once }
  if not Form1.FUseScript and FEngineStartAsk then begin
    FEngineStartAsk := False;
    if MessageDlgW(_('Scripting is disabled. Do you want to enable it now?'),
      mtConfirmation, MB_YESNO) = ID_YES then Form1.ScriptingEnable;
  end;
  Form1.ApplyEditorChanges(not Form1.FUseScript);
  //Form1.Status(Format(_('Script saved, %d bytes written'),[Length(Script.Text)]));
end;

procedure TfrmEditor.PopupMenu1Popup(Sender: TObject);
begin
  SaveChanges1.Enabled := Script.Modified;
end;

procedure TfrmEditor.FindNextError1Click(Sender: TObject);
begin
  MessagesVisible := False;
  PrecompileTimer1Timer(PrecompileTimer1);
end;

procedure TfrmEditor.ReplaceDialog1Find(Sender: TObject);
var
  Replace: string;
begin
  if [frReplace,frReplaceAll] * ReplaceDialog1.Options <> [] then
    Replace := ReplaceDialog1.ReplaceText
  else
    Replace := ReplaceDialog1.FindText;
  FindReplace(ReplaceDialog1.FindText,Replace,
    not (frDown in ReplaceDialog1.Options), frWholeWord in ReplaceDialog1.Options,
    frReplaceAll in ReplaceDialog1.Options);
end;

procedure TfrmEditor.Find1Click(Sender: TObject);
begin
  if Script.SelText <> '' then begin
    ReplaceDialog1.FindText := Script.SelText;
    ReplaceDialog1.ReplaceText := '';
  end;
  ReplaceDialog1.Execute;
end;

procedure TfrmEditor.FindNext1Click(Sender: TObject);
begin
  FindReplace(ReplaceDialog1.FindText,ReplaceDialog1.FindText,
    not (frDown in ReplaceDialog1.Options), frWholeWord in ReplaceDialog1.Options,
    frReplaceAll in ReplaceDialog1.Options);
end;

procedure TfrmEditor.Replace1Click(Sender: TObject);
begin
  if Script.SelText <> '' then begin
    ReplaceDialog1.FindText := Script.SelText;
    ReplaceDialog1.ReplaceText := Script.SelText;
  end;
  ReplaceDialog1.Execute;
end;

procedure TfrmEditor.LoadFromFile1Click(Sender: TObject);
begin
  OpenDialog1.InitialDir := ExtractFileDir(Filename);
  if OpenDialog1.Execute then begin
    Form1.ScriptingEnable(OpenDialog1.FileName);
    Initialize;
  end;
end;

procedure TfrmEditor.Finalize;
begin
  PrecompileTimer1.Enabled := False;
  if Script.Modified then
    case MessageDlgW(_('Script is modified. Do you want to apply changes?'), mtConfirmation, MB_YESNOCANCEL) of
      ID_YES: Form1.ApplyEditorChanges(not Form1.FUseScript or Application.Terminated);
      ID_CANCEL: Abort;
    end;
end;

procedure TfrmEditor.Set_Filename(const Value: string);
begin
  FFilename := Value;
  if Visible then DoShowCaretInfo;
end;

function TfrmEditor.CheckFilename: String;
begin
  Result := Filename;
  if (CompareText(Form1.ScriptFilename,Filename) <> 0) or not FileExists(Filename) then begin
    SaveDialog1.InitialDir := ExtractFileDir(Filename);
    if SaveDialog1.Execute then Result := SaveDialog1.FileName
      else Abort;
  end;
end;

procedure TfrmEditor.ScriptingOptions1Click(Sender: TObject);
begin
  Form1.ScriptingOptions1.Click;
end;

end.
