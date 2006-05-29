unit uDebug;

{
*******************************************************************************
* Descriptions: Debug log window implementation
* $Source: /cvsroot/fma/fma/uDebug.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uDebug.pas,v $
* Revision 1.9  2005/02/09 14:01:38  z_stoichev
* Fixed #13#10 to sLinebreak.
*
* Revision 1.8  2005/02/08 15:38:34  voxik
* Merged with L10N branch
*
* Revision 1.5.14.4  2005/02/07 23:32:44  voxik
* Fixed Unicode debug logs
*
* Revision 1.5.14.3  2005/01/07 17:34:29  expertone
* Merge with MAIN branch
*
* Revision 1.7  2004/12/19 10:33:37  voxik
* Fixed Debug log is not scrolling anymore when cursor position is not on the end of text
*
* Revision 1.6  2004/12/10 16:07:04  z_stoichev
* Code cleanup.
*
* Revision 1.5.14.2  2004/10/25 20:21:39  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.5.14.1  2004/10/19 19:48:38  expertone
* Add localization (gnugettext)
*
* Revision 1.5  2004/05/21 10:09:02  z_stoichev
* Changed logging handle routines.
*
* Revision 1.4  2003/11/28 09:38:07  z_stoichev
* Merged with branch-release-1-1 (Fma 0.10.28c)
*
* Revision 1.3.2.2  2003/10/28 10:15:35  z_stoichev
* Always show memo last line.
*
* Revision 1.3.2.1  2003/10/27 07:22:54  z_stoichev
* Build 0.1.0 RC1 Initial Checkin.
*
* Revision 1.3  2003/01/30 04:15:57  warren00
* Updated with header comments
*
*
*******************************************************************************
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, StdCtrls, TntStdCtrls, Placemnt, Menus, TntMenus;

type
  TfrmDebug = class(TTntForm)
    Memo: TTntMemo;
    FormPlacement1: TFormPlacement;
    MainMenu1: TTntMainMenu;
    Log1: TTntMenuItem;
    SaveAs1: TTntMenuItem;
    N1: TTntMenuItem;
    Clear1: TTntMenuItem;
    N2: TTntMenuItem;
    Close1: TTntMenuItem;
    SaveDialog1: TTntSaveDialog;
    procedure MemoChange(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure SaveAs1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure DoLog(const Str: WideString; PrefixTimestamp: boolean = True);
  end;

var
  frmDebug: TfrmDebug;

implementation

uses
  gnugettext, gnugettexthelpers,
  Unit1;

{$R *.dfm}

procedure TfrmDebug.MemoChange(Sender: TObject);
begin
  SaveAs1.Enabled := Memo.Text <> '';
  Clear1.Enabled := SaveAs1.Enabled;
  if not Application.Terminated then begin
    Memo.SelLength := 0;
    if not Visible then
      SendMessage(Memo.Handle,WM_VSCROLL,SB_THUMBPOSITION or ((Memo.Lines.Count-1) shl 16),0);
  end;    
end;

procedure TfrmDebug.Close1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmDebug.Clear1Click(Sender: TObject);
begin
  Memo.Lines.Clear;
  SaveAs1.Enabled := False;
  Clear1.Enabled := False;
end;

procedure TfrmDebug.SaveAs1Click(Sender: TObject);
begin
  SaveDialog1.InitialDir := ExtractFileDir(Application.ExeName);
  SaveDialog1.FileName := Caption + '.log'; // do not localize
  if SaveDialog1.Execute then begin
    Memo.Lines.SaveToFile(SaveDialog1.FileName);
    SaveAs1.Enabled := False;
  end;
end;

procedure TfrmDebug.DoLog(const Str: WideString; PrefixTimestamp: boolean);
var
  s: WideString;
  timestamp: String;
  CursorPos, Selection: Integer;
  FirstLine: Integer;
begin
  with Memo do begin
    if PrefixTimestamp then begin
      DateTimeToString(timestamp, 'hh:nn:ss:zzz', now); // do not localize
      s := WideFormat('%s %s', [timestamp, str]); // do not localize
    end
    else s := str;

    { Don't leave an empty line at window bottom }
    if Lines.Count <> 0 then s := sLinebreak + s;

    // If the cursor is on last characted, simply add text to the selection
    // and memo will be scrolled.
    if SelStart = Length(Text) then SelText := s
    else begin
      // Get the number of first visible line.
      FirstLine := Perform(EM_GETFIRSTVISIBLELINE, 0, 0);

			// Reduce flicker by ignoring WM_PAINT.
			Perform(WM_SETREDRAW, Integer(False), 0);

      // Remember selection.
      CursorPos := SelStart;
      Selection := SelLength;

      // Add new text.
      Text := Text + s;

      // Reset position.
      SelStart := CursorPos;
      SelLength := Selection;

      // Scroll back to original position.
      SendMessage(Handle, EM_LINESCROLL, 0, -Lines.count);
      SendMessage(Handle, EM_LINESCROLL, 0, FirstLine);

			// Enable redrawing.
			SendMessage(Handle, WM_SETREDRAW, Integer(True), 0);
    end;
  end;
end;

procedure TfrmDebug.FormCreate(Sender: TObject);
begin
   gghTranslateComponent(self);
end;

end.
