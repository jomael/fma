unit uEditProfile;

{
*******************************************************************************
* Descriptions: Profile Dialog placeholder
* $Source: /cvsroot/fma/fma/uEditProfile.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uEditProfile.pas,v $
*
*******************************************************************************
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics, Controls, TntControls, Forms, TntForms,
  Dialogs, TntDialogs, StdCtrls, TntStdCtrls, ExtCtrls, TntExtCtrls, ComCtrls, TntComCtrls, UniTntCtrls;

type
  TfrmEditProfile = class(TTntForm)
    PageControl1: TTntPageControl;
    TabSheet1: TTntTabSheet;
    Edit1: TTntEdit;
    TabSheet2: TTntTabSheet;
    lblNameCopy: TTntLabel;
    grpAns: TTntRadioGroup;
    grpFont: TTntGroupBox;
    fsRadioButton1: TTntRadioButton;
    fsRadioButton2: TTntRadioButton;
    fsRadioButton3: TTntRadioButton;
    grpSMS: TTntRadioGroup;
    grpVib: TTntRadioGroup;
    grpLight: TTntRadioGroup;
    grpKS: TTntGroupBox;
    ksRadioButton1: TTntRadioButton;
    ksRadioButton2: TTntRadioButton;
    ksRadioButton3: TTntRadioButton;
    btnOk: TTntButton;
    btnCancel: TTntButton;
    btnApply: TTntButton;
    TntImage1: TTntImage;
    Bevel1: TTntBevel;
    TntImage2: TTntImage;
    TntBevel1: TTntBevel;
    lblL1: TTntLabel;
    chkIncL1: TTntCheckBox;
    TntLabel1: TTntLabel;
    trkBarL1: TTntTrackBar;
    TntLabel2: TTntLabel;
    Bevel2: TTntBevel;
    lblL2: TTntLabel;
    TntLabel4: TTntLabel;
    TntLabel5: TTntLabel;
    trkBarL2: TTntTrackBar;
    chkIncL2: TTntCheckBox;
    TntBevel2: TTntBevel;
    lblFax: TTntLabel;
    TntLabel7: TTntLabel;
    TntLabel8: TTntLabel;
    TntBevel3: TTntBevel;
    trkBarFax: TTntTrackBar;
    chkIncFax: TTntCheckBox;
    lblData: TTntLabel;
    TntLabel10: TTntLabel;
    TntLabel11: TTntLabel;
    trkBarData: TTntTrackBar;
    chkIncData: TTntCheckBox;
    chkSIL: TTntCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure OnMod(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
    OldName: WideString;
    Oldindex: string;

    MMIFontSupport: boolean;
    function getFontMode: integer;
    function getKeySound: integer;

    procedure ERIL;
    procedure ESIL;
    procedure EFOS;
    procedure ESBL;
    procedure CVIB;
    procedure ESAM;
    procedure ESKS;
    procedure ESMA;
    procedure EAPS;
    procedure EAPS_N;

    procedure InitSetting;
    procedure SendSetting;
  public
    { Public declarations }
  end;

var
  frmEditProfile: TfrmEditProfile;

implementation

uses
  gnugettext, gnugettexthelpers, cUnicodeCodecs,
  uLogger, Unit1, uStatusDlg, uDialogs, uThreadSafe;

{$R *.dfm}

procedure TfrmEditProfile.FormCreate(Sender: TObject);
begin
  //gghTranslateComponent(self);
  TntImage2.Picture.Assign(TntImage1.Picture);

  lblL1.Font.Style := lblL1.Font.Style + [fsBold];
  lblL2.Font.Style := lblL1.Font.Style + [fsBold];
  lblFax.Font.Style := lblL1.Font.Style + [fsBold];
  lblData.Font.Style := lblL1.Font.Style + [fsBold];

{$IFNDEF VER150}
  Form1.ThemeManager1.CollectForms(Self);
{$ENDIF}
end;

procedure TfrmEditProfile.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  btnOk.SetFocus;
  InitSetting;
end;

procedure TfrmEditProfile.InitSetting;
begin
  with ShowStatusDlg(_('Getting setting profile...')) do
  try
    Form1.Status(_('Getting setting profile...'));
    EAPS();
    EAPS_N();
    ESAM();
    ESIL();
    ERIL();
    EFOS();
    ESBL();
    CVIB();
    ESKS();
    ESMA();
    Form1.Status('');
  finally
    Free;
    btnApply.Enabled := False;
  end;
end;

procedure TfrmEditProfile.ERIL;
var
  i: Integer;
  str: String;
  strlst: TStringlist;
  value : Integer;
begin
  try
    Form1.TxAndWait('AT*ERIL?'); // do not localize

    strlst := Tstringlist.Create();
    for i := 0 to ThreadSafe.RxBuffer.Count - 2 do begin
      if pos('*ERIL', ThreadSafe.RxBuffer.Strings[i]) = 1 then // do not localize
        begin
          str := Copy(ThreadSafe.RxBuffer.Strings[i], 8, length(ThreadSafe.RxBuffer.Strings[i]));
          strlst.DelimitedText := str;
          value := strtoint(strlst[0]);
          if strlst[1] = '1' then
              begin
                trkBarL1.Position := value mod 128;
                if value > 128 then
                  chkincl1.Checked := true
                else
                  chkincl1.Checked := false
              end;
          if strlst[1] = '2' then
              begin
                trkBarL2.Position := value mod 128;
                if value > 128 then
                  chkincl2.Checked := true
                else
                  chkincl2.Checked := false
              end;
          if strlst[1] = '3' then
              begin
                trkBarfax.Position := value mod 128;
                if value > 128 then
                  chkincfax.Checked := true
                else
                  chkincfax.Checked := false
              end;
          if strlst[1] = '4' then
              begin
                trkBardata.Position := value mod 128;
                if value > 128 then
                  chkincdata.Checked := true
                else
                  chkincdata.Checked := false
              end;
        end;
    end;
  except
    Log.AddCommunicationMessage('Error getting Sound volume Setting', lsError); // do not localize debug
  end;

end;

procedure TfrmEditProfile.ESIL;
var
  i: Integer;
  str: String;
begin
  try
    Form1.TxAndWait('AT*ESIL?'); // do not localize

    for i := 0 to ThreadSafe.RxBuffer.Count - 2 do begin
      if pos('*ESIL', ThreadSafe.RxBuffer.Strings[i]) = 1 then // do not localize
        begin
          str := Copy(ThreadSafe.RxBuffer.Strings[i], 8, length(ThreadSafe.RxBuffer.Strings[i]));
          if str = '0' then
            chksil.Checked := false
          else
            chksil.Checked := true;
        end;
    end;
  except
    Log.AddCommunicationMessage('Error getting Silent Setting', lsError); // do not localize debug
  end;
end;

procedure TfrmEditProfile.EFOS;
var
  i,j: Integer;
  s: string;
  value: Integer;
begin
  try
    try
      { Read available Font modes }
      Form1.TxAndWait('AT*EFOS=?'); // do not localize

      for i := 0 to ThreadSafe.RxBuffer.Count - 2 do begin
        if pos('*EFOS', ThreadSafe.RxBuffer.Strings[i]) = 1 then // do not localize
          begin
            { format is "(X-Y)" }
            s := Copy(ThreadSafe.RxBuffer.Strings[i], 8, length(ThreadSafe.RxBuffer.Strings[i]));
            j := Pos('-',s);
            for j := StrToInt(s[j-1]) to StrToInt(s[j+1]) do begin
              case j of
                1: fsRadioButton1.Enabled := True;
                2: fsRadioButton2.Enabled := True;
                3: fsRadioButton3.Enabled := True;
              end;
            end;
          end;
      end;
      MMIFontSupport := True;
    except
      MMIFontSupport := False;
      Log.AddCommunicationMessage('MMI Font Setting not supported', lsWarning); // do not localize debug
      Abort;
    end;
    Form1.TxAndWait('AT*EFOS?'); // do not localize

    for i := 0 to ThreadSafe.RxBuffer.Count - 2 do begin
      if pos('*EFOS', ThreadSafe.RxBuffer.Strings[i]) = 1 then // do not localize
        begin
          value := strtoint(Copy(ThreadSafe.RxBuffer.Strings[i], 8, length(ThreadSafe.RxBuffer.Strings[i])));
          case value of
            1: fsRadioButton1.Checked := True;
            2: fsRadioButton2.Checked := True;
            3: fsRadioButton3.Checked := True;
          end;
        end;
    end;
  except
    { Strange that "AT*EFOS=?" works, but "AT*EFOS?" fails on T610 }
    fsRadioButton1.Enabled := False;
    fsRadioButton2.Enabled := False;
    fsRadioButton3.Enabled := False;
    MMIFontSupport := False;
    Log.AddCommunicationMessage('Error getting Font Setting', lsError); // do not localize debug
  end;
end;

procedure TfrmEditProfile.ESBL;
var
  i: Integer;
  value: Integer;
begin
  try
    Form1.TxAndWait('AT*ESBL?'); // do not localize

    for i := 0 to ThreadSafe.RxBuffer.Count - 2 do begin
      if pos('*ESBL: 0', ThreadSafe.RxBuffer.Strings[i]) = 1 then // do not localize
        begin
          value := strtoint(Copy(ThreadSafe.RxBuffer.Strings[i], 10, length(ThreadSafe.RxBuffer.Strings[i])));
          grpLight.ItemIndex := value;
        end;
    end;
  except
    Log.AddCommunicationMessage('Error getting Backlight Setting', lsError); // do not localize debug
  end;

end;

procedure TfrmEditProfile.CVIB;
var
  i: Integer;
  value: Integer;
begin
  try
    Form1.TxAndWait('AT+CVIB?'); // do not localize

    for i := 0 to ThreadSafe.RxBuffer.Count - 2 do begin
      if pos('+CVIB', ThreadSafe.RxBuffer.Strings[i]) = 1 then // do not localize
        begin
          value := strtoint(Copy(ThreadSafe.RxBuffer.Strings[i], 8, length(ThreadSafe.RxBuffer.Strings[i])));
          case value of
            16:  grpVib.ItemIndex := 2;
          else
            grpVib.ItemIndex := value;
          end;
        end;
    end;
  except
    Log.AddCommunicationMessage('Error getting Vibration Setting', lsError); // do not localize debug
  end;
end;

procedure TfrmEditProfile.ESAM;
var
  i: Integer;
  value: Integer;
begin
  try
    Form1.TxAndWait('AT*ESAM?'); // do not localize

    for i := 0 to ThreadSafe.RxBuffer.Count - 2 do begin
      if pos('*ESAM', ThreadSafe.RxBuffer.Strings[i]) = 1 then // do not localize
        begin
          value := strtoint(Copy(ThreadSafe.RxBuffer.Strings[i], 8, length(ThreadSafe.RxBuffer.Strings[i])));
          grpAns.ItemIndex := value;
        end;
    end;
  except
    Log.AddCommunicationMessage('Error getting Answer Setting', lsError); // do not localize debug
  end;
end;

procedure TfrmEditProfile.ESKS;
var
  i,j: Integer;
  s: string;
  value: Integer;
begin
  try
    { Read available Key Sound modes }
    Form1.TxAndWait('AT*ESKS=?'); // do not localize
    for i := 0 to ThreadSafe.RxBuffer.Count - 2 do begin
      if pos('*ESKS', ThreadSafe.RxBuffer.Strings[i]) = 1 then // do not localize
        begin
          { format is "(X-Y)" }
          s := Copy(ThreadSafe.RxBuffer.Strings[i], 8, length(ThreadSafe.RxBuffer.Strings[i]));
          j := Pos('-',s);
          for j := StrToInt(s[j-1]) to StrToInt(s[j+1]) do begin
            case j of
              0: ksRadioButton1.Enabled := True;
              1: ksRadioButton2.Enabled := True;
              2: ksRadioButton3.Enabled := True;
            end;
          end;
        end;
    end;
    Form1.TxAndWait('AT*ESKS?'); // do not localize

    for i := 0 to ThreadSafe.RxBuffer.Count - 2 do begin
      if pos('*ESKS', ThreadSafe.RxBuffer.Strings[i]) = 1 then // do not localize
        begin
          value := strtoint(Copy(ThreadSafe.RxBuffer.Strings[i], 8, length(ThreadSafe.RxBuffer.Strings[i])));
          case value of
            0: ksRadioButton1.Checked := True;
            1: ksRadioButton2.Checked := True;
            2: ksRadioButton3.Checked := True;
          end;
        end;
    end;
  except
    Log.AddCommunicationMessage('Error getting Keys sound Setting', lsError); // do not localize debug
  end;
end;

procedure TfrmEditProfile.ESMA;
var
  i: Integer;
  value: Integer;
begin
  try
    Form1.TxAndWait('AT*ESMA?'); // do not localize

    for i := 0 to ThreadSafe.RxBuffer.Count - 2 do begin
      if pos('*ESMA', ThreadSafe.RxBuffer.Strings[i]) = 1 then // do not localize
        begin
          value := strtoint(Copy(ThreadSafe.RxBuffer.Strings[i], 8, length(ThreadSafe.RxBuffer.Strings[i])));
          grpSMS.ItemIndex := value;
        end;
    end;
  except
    Log.AddCommunicationMessage('Error getting Message sound Setting', lsError); // do not localize debug
  end;
end;

procedure TfrmEditProfile.SendSetting;
var value:Integer;
begin
  with ShowStatusDlg(_('Sending setting profile...')) do
  try
    //send answer
    Form1.TxAndWait('AT*ESAM=' + inttostr(grpAns.ItemIndex)); // do not localize
    //send message sound
    Form1.TxAndWait('AT*ESMA=' + inttostr(grpSMS.ItemIndex)); // do not localize
    //send backlight
    Form1.TxAndWait('AT*ESBL=0,' + inttostr(grpLight.ItemIndex)); // do not localize
    //send font
    if MMIFontSupport then
      Form1.TxAndWait('AT*EFOS=' + inttostr(getFontMode)); // do not localize
    //Form1.TxAndWait('AT*EFOS=' + inttostr(grpFont.ItemIndex + 1)); // do not localize
    //send vibration
    case grpVib.ItemIndex of
      2:  Form1.TxAndWait('AT+CVIB= 16'); // do not localize
    else
      Form1.TxAndWait('AT+CVIB=' + inttostr(grpVib.ItemIndex)); // do not localize
    end;
    //send keys sound
    Form1.TxAndWait('AT*ESKS=' + inttostr(getKeySound)); // do not localize
    //send silent
    if chkSil.Checked then
      Form1.TxAndWait('AT*ESIL=1') // do not localize
    else
      Form1.TxAndWait('AT*ESIL=0'); // do not localize
    //send volume sound L1
    value := trkBarL1.Position;
    if chkIncL1.Checked then
      if value = 0 then
        value := 129
      else
        value := value + 128;
    Form1.TxAndWait('AT*ERIL=' + inttostr(value) + ',1'); // do not localize
    //send volume sound L2
    value := trkBarL2.Position;
    if chkIncL2.Checked then
      if value = 0 then
        value := 129
      else
        value := value + 128;
    Form1.TxAndWait('AT*ERIL=' + inttostr(value) + ',2'); // do not localize
    //send volume sound Fax
    value := trkBarFax.Position;
    if chkIncFax.Checked then
      if value = 0 then
        value := 129
      else
        value := value + 128;
    Form1.TxAndWait('AT*ERIL=' + inttostr(value) + ',3'); // do not localize
    //send volume sound Data
    value := trkBarData.Position;
    if chkIncData.Checked then
      if value = 0 then
        value := 129
      else
        value := value + 128;
    Form1.TxAndWait('AT*ERIL=' + inttostr(value) + ',4'); // do not localize
    //send name
    if Oldname <> edit1.Text then
    try
      if Form1.FUseUTF8 then
        Form1.TxAndWait('AT*EAPN="' + WideStringToUTF8String(Edit1.Text) + '"') // do not localize
      else
        Form1.TxAndWait('AT*EAPN="' + Edit1.Text + '"'); // do not localize
    except
      Edit1.Text := OldName;
      lblNameCopy.Caption := OldName;
      btnApply.Enabled := False; // we're done already sinte this is the last setting
      Form1.Status(_('Rename aborted'));
      MessageBeep(MB_ICONASTERISK);
      MessageDlgW(_('This profile name is hardcoded in phone and can not be renamed'), mtError, MB_OK);
      Abort;
    end
  finally
    Free;
  end;
end;

procedure TfrmEditProfile.EAPS;
var
  i: Integer;
  value: Integer;
  str: String;
  strlst: TStringlist;
begin
  try
    strlst := TStringlist.Create;

    Form1.TxAndWait('AT*EAPS=?'); // do not localize

    for i := 0 to ThreadSafe.RxBuffer.Count - 2 do begin
      if pos('*EAPS', ThreadSafe.RxBuffer.Strings[i]) = 1 then // do not localize
        begin
          str := Copy(ThreadSafe.RxBuffer.Strings[i], 8, length(ThreadSafe.RxBuffer.Strings[i]));
          strlst.DelimitedText := str;
          value := strtoint(strlst[1]);
          edit1.MaxLength := value;
        end;
    end;
  except
    Log.AddCommunicationMessage('Error getting Profile name Setting', lsError); // do not localize debug
  end;
end;

procedure TfrmEditProfile.EAPS_N;
var
  i: Integer;
  str: string;
  strlst: TStringlist;
begin
  try
    strlst := TStringlist.Create;

    Form1.TxAndWait('AT*EAPS?'); // do not localize

    for i := 0 to ThreadSafe.RxBuffer.Count - 2 do begin
      if pos('*EAPS', ThreadSafe.RxBuffer.Strings[i]) = 1 then // do not localize
        begin
          str := Copy(ThreadSafe.RxBuffer.Strings[i], 8, length(ThreadSafe.RxBuffer.Strings[i]));
          //if Form1.FUseUTF8 then str := UTF8StringToWideString(str);
          strlst.DelimitedText := str;
          Oldindex := strlst[0];
          OldName := strlst[1];
          if Form1.FUseUTF8 then OldName := UTF8StringToWideString(strlst[1]);
          Edit1.Text  := OldName;
          Edit1Change(nil);
        end;
    end;
  except
    Log.AddCommunicationMessage('Error getting Active Profile name Setting', lsError); // do not localize debug
  end;
end;

function TfrmEditProfile.getFontMode: integer;
begin
  Result := 1;
  if fsRadioButton2.Checked then
    Result := 2
  else if fsRadioButton3.Checked then
    Result := 3;
end;

function TfrmEditProfile.getKeySound: integer;
begin
  Result := 0;
  if ksRadioButton2.Checked then
    Result := 1
  else if ksRadioButton3.Checked then
    Result := 2;
end;

procedure TfrmEditProfile.Edit1Change(Sender: TObject);
begin
  lblNameCopy.Caption := Edit1.Text;
  btnApply.Enabled := True;
end;

procedure TfrmEditProfile.OnMod(Sender: TObject);
begin
  btnApply.Enabled := True;
end;

procedure TfrmEditProfile.btnApplyClick(Sender: TObject);
begin
  Form1.Status(_('Sending setting profile...'));
  SendSetting;
  if Oldname <> Edit1.Text then
    Form1.InitProfile;
  Form1.Status('');
  btnApply.Enabled := False;
end;

procedure TfrmEditProfile.btnOkClick(Sender: TObject);
begin
  if btnApply.Enabled then btnApply.Click;
  ModalResult := mrOk;
end;

procedure TfrmEditProfile.btnCancelClick(Sender: TObject);
begin
  if not btnApply.Enabled or (MessageDlgW(_('Discard current changes?'),
    mtConfirmation, MB_YESNO or MB_DEFBUTTON2) = ID_YES) then
    ModalResult := mrCancel;
end;

end.
