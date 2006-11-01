unit uSyncCalendar;

{
*******************************************************************************
* Descriptions: Calendar View
* $Source: /cvsroot/fma/fma/uSyncCalendar.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uSyncCalendar.pas,v $
*
}

interface

uses
  Windows, TntWindows, Messages, SysUtils, TntSysUtils, Variants, Classes, TntClasses, Graphics, TntGraphics,
  Controls, TntControls, Forms, TntForms, Dialogs, TntDialogs, ExtCtrls, TntExtCtrls, StdCtrls, TntStdCtrls,
  VpMonthView, VpTaskList, VpBase, VpBaseDS, VpDayView, VpData, uVBase, uVCalendar, uVpVDB, 
  Placemnt, uConnProgress, ImgList, Menus, TntMenus;

type
  TfrmCalendarView = class(TTntFrame)
    VpDayView: TVpDayView;
    VpControlLink: TVpControlLink;
    VpTaskList: TVpTaskList;
    VpMonthView: TVpMonthView;
    SplitterVertical: TTntSplitter;
    Panel: TTntPanel;
    SplitterHorizontal: TTntSplitter;
    FormStorage1: TFormStorage;
    ImageListCalPopup: TImageList;
    PopupMenuDayView: TTntPopupMenu;
    ForceasNotModifieDv: TTntMenuItem;
    ForceasModifiedDv: TTntMenuItem;
    ForceasNewEventDv: TTntMenuItem;
    PopupMenuTaskList: TTntPopupMenu;
    ForceasNotModifiedTl: TTntMenuItem;
    ForceasModifiedTl: TTntMenuItem;
    ForceasNewEventTl: TTntMenuItem;
    N1: TTntMenuItem;
    RecurItem1: TTntMenuItem;
    NextDay1: TTntMenuItem;
    NextWeek1: TTntMenuItem;
    NextMonth1: TTntMenuItem;
    NextYear1: TTntMenuItem;
    N2: TTntMenuItem;
    DownloadentireCalendar1: TTntMenuItem;
    N3: TTntMenuItem;
    DownloadEntireCalendar2: TTntMenuItem;
    N4: TTntMenuItem;
    CompletedStatus1: TTntMenuItem;
    CompletedToday1: TTntMenuItem;
    CompletedClear1: TTntMenuItem;
    N5: TTntMenuItem;
    Properties1: TTntMenuItem;
    N6: TTntMenuItem;
    Properties2: TTntMenuItem;
    N7: TTntMenuItem;
    ImportCalendar1: TTntMenuItem;
    ExportCalendar1: TTntMenuItem;
    OpenDialog1: TTntOpenDialog;
    TntSaveDialog1: TTntSaveDialog;
    N8: TTntMenuItem;
    ExportCalendar2: TTntMenuItem;
    ImportCalendar2: TTntMenuItem;
    procedure VpDayViewOwnerEditEvent(Sender: TObject; Event: TVpEvent;
      Resource: TVpResource; var AllowIt: Boolean);
    procedure VpTaskListOwnerEditTask(Sender: TObject; Task: TVpTask;
      Resource: TVpResource; var AllowIt: Boolean);
    procedure VpDayViewDrawIcons(Sender: TObject; Event: TVpEvent;
      var Icons: TVpDVIcons);
    procedure ForceasNotModifieDvClick(Sender: TObject);
    procedure ForceasModifiedDvClick(Sender: TObject);
    procedure ForceasNewEventDvClick(Sender: TObject);
    procedure ForceasNotModifiedTlClick(Sender: TObject);
    procedure ForceasModifiedTlClick(Sender: TObject);
    procedure ForceasNewEventTlClick(Sender: TObject);
    procedure RecurringClick(Sender: TObject);
    procedure PopupMenuDayViewPopup(Sender: TObject);
    procedure PopupMenuTaskListPopup(Sender: TObject);
    procedure DownloadentireCalendar1Click(Sender: TObject);
    procedure CompletedStatusClick(Sender: TObject);
    procedure Properties1Click(Sender: TObject);
    procedure ImportCalendar1Click(Sender: TObject);
    procedure btnSYNCClick(Sender: TObject);
    procedure Properties2Click(Sender: TObject);
    procedure VpDayViewBeforeEdit(Sender: TObject; Event: TVpEvent;
      var AllowIt: Boolean);
    procedure VpTaskListBeforeEdit(Sender: TObject; Task: TVpTask;
      var AllowIt: Boolean);
    procedure VpTaskListDrawIcons(Sender: TObject; Task: TVpTask;
      var Icons: TVpDVIcons);
    procedure VpTaskListCompleteChange(Sender: TObject; Task: TVpTask);
  private
    { Private declarations }
    ConflictVCalPhone,ConflictVCalPC: TVCalEntity;
    FSyncProgressDlg: TfrmConnect;
    VpDB: TVpVDataStore;
    CC: WideString;
    IsNew: Boolean;
    function DoShiftDate(Dt: TDateTime; Year,Month,Day: Word): TDateTime;
    function DoShiftEvent(Event: TVpEvent; Year,Month,Day: Word): boolean;
    { Sync }
    function Synchronize: boolean;
    function FullRefresh: boolean;
    function CheckInArray(A: array of widestring; S: Widestring): boolean;
    function FindCalObj(LUID: Widestring; var ACalEntity: TVCalEntity): Boolean;
    function ResolveConflict(EventName: WideString; Info:WideString; Appointment: Boolean): Integer;
    procedure VpBDAlert(Sender: TObject; Event: TVpEvent);
  protected
    FCalendar: TVCalendar;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure OnConflictChanges(Sender: TObject; const TargetName, Option1Name, Option2Name: WideString);
    procedure OnConnected;
    procedure ClearAllData; // USE WITH CARE!
    procedure LoadCalendar(FileName: WideString; IntoCal: TVCalendar = nil);
    procedure SaveCalendar(FileName: WideString; SaveCC: Boolean = True);
    { Properties }
    property DB: TVpVDataStore read VpDB;
    property Cal: TVCalendar read FCalendar;
  end;

implementation

uses
  gnugettext, gnugettexthelpers, DateUtils, uGlobal, uNewAlarm,
  Unit1, uLogger, VpMisc, uPromptConflict, uEditEvent, uEditTask, uConflictChanges, uDialogs;

{$R *.dfm}

constructor TfrmCalendarView.Create(AOwner: TComponent);
  var
    A: array[0..1] of char;
begin
  inherited;

  GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_IFIRSTDAYOFWEEK, A, SizeOf(A));
  VpMonthView.WeekStartsOn := TVpDayType((Ord(A[0]) - Ord('0') + 1) mod 7);

  VpDB := TVpVDataStore.Create(Self);
  VpDB.OnAlert := VpBDAlert;

  VpDayView.DataStore := VpDB;
  VpMonthView.DataStore := VpDB;
  VpTaskList.DataStore := VpDB;

  FCalendar := TVCalendar.Create;
  VpDB.vCalendar := FCalendar;

  ConflictVCalPhone := TVCalEntity.Create;
  ConflictVCalPC := TVCalEntity.Create;

  IsNew := True;
end;

destructor TfrmCalendarView.Destroy;
begin
  VpDB.Free;
  FCalendar.Free;
  ConflictVCalPhone.Free;
  ConflictVCalPC.Free;

  inherited;
end;

procedure TfrmCalendarView.VpDayViewOwnerEditEvent(Sender: TObject;
  Event: TVpEvent; Resource: TVpResource; var AllowIt: Boolean);
begin
  inherited;
  AllowIt := False;
  with TfrmEditEvent.Create(nil) do
  try
    TntDatePickerStart.DateTime := Event.StartTime;
    TntTimePickerStart.DateTime := Event.StartTime;

    TntDatePickerEnd.DateTime := Event.EndTime;
    TntTimePickerEnd.DateTime := Event.EndTime;

    UpdateDudation;

    txtSubject.Text := Event.Description;
    // Use UserField0 for location value
    txtLocation.Text := Event.UserField0;

    TntComboBoxCategories.ItemIndex := Event.Category;

    if Event.AlarmSet then
      TntRadioGroupReminder.ItemIndex := 7
    else
      TntRadioGroupReminder.ItemIndex := 0;
    AdvMins := Event.AlarmAdv;
    AdvType := Event.AlarmAdvType;

    case Event.RepeatCode of
      rtDaily:
        TntRadioGroupReccurence.ItemIndex := 1;
      rtWeekly:
        TntRadioGroupReccurence.ItemIndex := 2;
      rtMonthlyByDay:
        TntRadioGroupReccurence.ItemIndex := 3;
      rtYearlyByDay:
        TntRadioGroupReccurence.ItemIndex := 4;
      else
        TntRadioGroupReccurence.ItemIndex := 0;
    end;
    TntDatePickerReccurence.DateTime := Event.RepeatRangeEnd;
    TntTimePickerReccurence.DateTime := Event.RepeatRangeEnd;
    if Event.RepeatRangeEnd <> EmptyDate then
      TntComboBoxRangeEnd.ItemIndex := 1
    else
      TntComboBoxRangeEnd.ItemIndex := 0;

    WeekDays := Event.UserField8;

    if Event.UserField9 = '' then Event.UserField9 := '0';

    // edit event
    if ShowModal = mrOk then begin
      Event.StartTime := TntDatePickerStart.DateTime;
      Event.EndTime := TntDatePickerEnd.DateTime;

      Event.Description := txtSubject.Text;

      if Event.UserField0 <> txtLocation.Text then begin
        Event.UserField0 := txtLocation.Text;
        Event.Changed := True;
      end;

      case TntRadioGroupReccurence.ItemIndex of
        0: Event.RepeatCode := rtNone;
        1: Event.RepeatCode := rtDaily;
        2: Event.RepeatCode := rtWeekly;
        3: Event.RepeatCode := rtMonthlyByDay;
        4: Event.RepeatCode := rtYearlyByDay;
      end;
      if TntComboBoxRangeEnd.ItemIndex = 1 then
        Event.RepeatRangeEnd := TntDatePickerReccurence.DateTime
      else
        Event.RepeatRangeEnd := EmptyDate;

      if TntComboBoxCategories.ItemIndex >= 0 then
        Event.Category := TntComboBoxCategories.ItemIndex
      else
        Event.Category := 0;

      if Event.UserField8 <> WeekDays then begin
        Event.UserField8 := WeekDays;
        Event.Changed := True;
      end;

      Event.AlarmSet := TntRadioGroupReminder.ItemIndex <> 0;
      Event.AlarmAdv := AdvMins;
      Event.AlarmAdvType := AdvType;
      if Event.AlarmSet then
        Event.UserField1 := DateTimeToStr(TntDatePickerReminder.DateTime)
      else
        Event.UserField1 := '';

      Event.AlertDisplayed := False;
      
      if Event.Changed and (Event.UserField9 <> '0') then Event.UserField9 := '1';

      AllowIt := True;
    end;
  finally
    Free;
  end;
end;

procedure TfrmCalendarView.VpTaskListOwnerEditTask(Sender: TObject;
  Task: TVpTask; Resource: TVpResource; var AllowIt: Boolean);
var
  AAlarm: String;
  DtDone: TDateTime;
begin
  inherited;
  AllowIt := False;
  with TfrmEditTask.Create(nil) do
  try
    txtSubject.Text := Task.Description;

    if Task.Complete then begin
      chbCompleted.Checked := True;
      txtCompleted.Text := DateTimeToStr(Task.CompletedOn);
    end
    else begin
      chbCompleted.Checked := False;
      txtCompleted.Text := '';
    end;

    if Task.UserField9 = '' then Task.UserField9 := '0';

    dtpDate.DateTime := Task.DueDate;
    dtpTime.DateTime := Task.DueDate;

    Task.DueDate := 0;
    
    if Task.UserField0 <> '' then begin
      chbReminder.Checked := True;

      try
        dtpDate.DateTime := StrToFloat(Task.UserField0);
      except
      end;

      dtpTime.DateTime := dtpDate.DateTime;
    end
    else begin
      dtpDate.DateTime := Now;
      dtpTime.DateTime := dtpDate.DateTime;

      chbReminder.Checked := False;
    end;
    chbReminderClick(self);

    // edit task
    if ShowModal = mrOk then begin
      Task.Description := txtSubject.Text;

      if txtNumber.Text <> '' then
        Task.Category := 1
      else
        Task.Category := 0;

      if chbReminder.Checked then begin
        try
          AAlarm := FloatToStr(DateOf(dtpDate.Date) + TimeOf(dtpTime.Time));
          if Task.UserField0 <> AAlarm then begin
            Task.UserField0 := AAlarm;
            Task.Changed := True;
          end;
        except
        end;
      end
      else begin
        Task.UserField0 := '';
        Task.Changed := True;
      end;

      if chbCompleted.Checked then begin
        try
          DtDone := StrToDateTime(txtCompleted.Text);
          if DtDone <> Task.CompletedOn then begin
            Task.CompletedOn := DtDone;
            Task.Complete := True;
          end;
        except
        end;
      end
      else
        Task.Complete := False;

      if Task.Changed and (Task.UserField9 <> '0') then Task.UserField9 := '1';

      AllowIt := True;
    end;
  finally
    Free;
  end;
end;

procedure TfrmCalendarView.btnSYNCClick(Sender: TObject);
var
  isModified: Boolean;
  Err: WideString;
begin
  Form1.ActionSyncPhonebook.Enabled := False;
  FSyncProgressDlg := GetProgressDialog;
  try
    if Form1.CanShowProgress then
      FSyncProgressDlg.ShowProgress(Form1.FProgressLongOnly);
    FSyncProgressDlg.SetDescr(_('Synchronizing phone calendar'));
    Form1.Status(_('Start Sync Phone Calendar....'));
    Log.AddSynchronizationMessage(_('Sync Phone Calendar started.'));
    try
      //Start the sync process
      isModified := Synchronize;
      //Force refresh Calendar
      if isModified then begin
        FSyncProgressDlg.SetDescr(_('Refreshing local calendar'));
        VpDB.Connected := True;
      end;
      Form1.Status(_('Sync Phone Calendar completed.'));
      Log.AddSynchronizationMessage(_('Sync Phone Calendar completed.'));
    except
      on E: Exception do begin
        Err := WideFormat(_('Error: Sync Phone Calendar aborted - %s'), [E.Message]);
        Form1.Status(Err);
        Log.AddSynchronizationMessage(Err, lsError);
        { TODO: Made calendar baloon optional }
        Form1.ShowBaloonError(_('Phone calendar synchronization failed!'),30);
      end;
    end;
  finally
    FreeProgressDialog;
    Form1.ActionSyncPhonebook.Enabled := True;
  end;
end;

function TfrmCalendarView.Synchronize: boolean; // True if any change is made!
var
  sl, pl: TStringList;
  AEntity, AOutEntity: TVCalEntity;
  addPCalEntity : array of WideString;
  delPCalEntity : array of WideString;
  I, J: Integer;
  Name, LUID : WideString;
  Appointment: Boolean;
  ANewCal, AOutCal: TVCalendar;
  stream : TStream;
  PhoneOnPc,AsNew,BadCC,GetAll: Boolean;
  procedure ShowProgressTarget(AName: WideString);
  begin
    if Assigned(FSyncProgressDlg) then
      FSyncProgressDlg.SetDescr(_('Synchronizing phone calendar')+sLinebreak+'('+AName+')');
  end;
begin
  Result := False;

  // If Calendar has no items, do full refresh
  if FCalendar.Count = 0 then begin
    Result := FullRefresh;
    Exit;
  end;

  //start sync process
  Form1.ObexConnect('IRMC-SYNC'); // do not localize
  if not Form1.FConnected then begin
     ShowMessageW(_('The Sync Calendar can''t start...try to restart your phone.'));
     Log.AddSynchronizationMessage(_('The Sync Calendar can''t start...try to restart your phone.'), lsError);
     Exit;
  end;

  sl := TStringList.Create;
  pl := TStringList.Create;
  ANewCal := TVCalendar.Create;

  // TODO: Check the output encoding
  if Form1.FUseUTF8 then ANewCal.OutputCharSet := tecUtf8
  else ANewCal.OutputCharSet := tecAscii;

  try
    BadCC := (CC = '') or (CC[1] = '-'); // Empty or -1 values
    try
      { if Fma CC is 1020, and phone CC is 1025 the result might be like this:
        (here for example, we have 3 new and one deleted contacts)

        SN:351956003653753
        DID:43A3
        Total-Records:30
        Maximum-Records:380
        M:1022::00003D010000
        M:1023::000047010000
        H:1024::0000E4000000
        M:1025::0000E5000000
      }
      //Get all record changes in phone for latest used LOG Number in FMA
      if not BadCC then
        Form1.ObexGetObject('telecom/cal/luid/' + CC +'.log',pl); // do not localize
    except
      BadCC := True; // Not exists or not authorized
    end;

    if not BadCC then begin
      // Build lists of localy modified and deleted calendar entries (on PC)
      for I := 0 to FCalendar.Count - 1 do begin
        AEntity := FCalendar[I] as TVCalEntity;

        case AEntity.VFmaState of
          1: begin // modified
               SetLength(addPCalEntity, Length(addPCalEntity) + 1);
               addPCalEntity[High(addPCalEntity)] := AEntity.VIrmcLUID.PropertyValue;
             end;
          2: begin // deleted
               SetLength(delPCalEntity, Length(delPCalEntity) + 1);
               delPCalEntity[High(delPCalEntity)] := AEntity.VIrmcLUID.PropertyValue;
             end;
        end;
      end;

      try
        // first apply phone changes
        for j := 0 to pl.Count-1 do begin
          Name := '';

          if Pos('M:', pl[j]) = 1 then begin //entries modified
            LUID := Copy(pl[j], Pos('::', pl[j]) + 2, length(pl[j]));

            AsNew := True;
            // Get new VCalendar item
            Form1.ObexGetObject('telecom/cal/luid/' + LUID + '.vcs', sl); // do not localize
            ANewCal.Clear;
            ANewCal.Raw := sl;

            if FindCalObj(LUID, AEntity) then begin
              Name := AEntity.VSummary.PropertyValue;
              Appointment := AEntity.VType.EntityType = tenVEvent;
              AsNew := False;

              ShowProgressTarget(Name);

              if CheckInArray(addPCalEntity, LUID) then begin
                if ANewCal.Count = 1 then
                  ConflictVCalPhone.Raw := (ANewCal[0] as TVCalEntity).Raw
                else
                  ConflictVCalPhone.Clear;
                ConflictVCalPC.Raw := AEntity.Raw;
                PhoneOnPC := ResolveConflict(Name, _('is modified on phone and modified on pc.'), Appointment) = 0;
                if not PhoneOnPC then continue; // later will overwrite phone contact
                // else overwrite local contact
              end;
              if CheckInArray(delPCalEntity, LUID) then begin
                ConflictVCalPC.Clear;
                ConflictVCalPhone.Clear;
                PhoneOnPC := ResolveConflict(Name, _('is modified on phone and deleted on pc.'), Appointment) = 0;
                if not PhoneOnPC then continue; // later will delete phone contact
                // else resurrect local contact
              end;
            end
            else
              AEntity := nil;

            if not AsNew then begin
              // One entry should be in calendar
              if ANewCal.Count = 1 then AEntity.Raw := (ANewCal[0] as TVCalEntity).Raw;
            end
            else begin
              // One entry should be in calendar
              if ANewCal.Count = 1 then begin
                AEntity := nil;
                AEntity := TVCalEntity.Create;
                AEntity.Raw := (ANewCal[0] as TVCalEntity).Raw;
                FCalendar.Add(AEntity);
              end;
            end;

            ShowProgressTarget(AEntity.VSummary.PropertyValue);

            if AsNew then
               Log.AddSynchronizationMessage(AEntity.VSummary.PropertyValue + _(' added to FMA by phone.'), lsInformation)
            else
               Log.AddSynchronizationMessage(AEntity.VSummary.PropertyValue + _(' modified in FMA by phone.'), lsInformation);

            sl.Clear;
            // Update LOG Number dynamicaly (current LOG record has been processed)
            CC := Copy(pl[j],3,Pos('::',pl[j])-3);
            Result := True;
            Continue;
          end;

          if Pos('H:', pl[j]) = 1 then begin  //entries deleted // do not localize
            LUID := Copy(pl[j], Pos('::', pl[j]) + 2, length(pl[j]));

            if FindCalObj(LUID, AEntity) then begin
              Name := AEntity.VSummary.PropertyValue;
              Appointment := AEntity.VType.EntityType = tenVEvent;

              ShowProgressTarget(Name);

              if CheckInArray(addPCalEntity, AEntity.VIrmcLUID.PropertyValue) then begin
                ConflictVCalPC.Clear;
                ConflictVCalPhone.Clear;
                PhoneOnPC := ResolveConflict(Name, _('is deleted on phone and modified on pc.'), Appointment) = 0;
                if not PhoneOnPC then continue; // later will resurrect phone contact
                // else delete local contact
              end;

              FCalendar.Delete(FCalendar.IndexOf(AEntity));

              Log.AddSynchronizationMessage(Name + _(' deleted in FMA by phone.'), lsInformation);
            end;

            // Update LOG Number dynamicaly (current LOG record has been processed)
            CC := Copy(pl[j],3,Pos('::',pl[j])-3);
            Result := True;
          end;
        end;
        { well, we have processed all "CC.log" entries and we have updated CC up to latest one }
        SetLength(addPCalEntity,0);
        SetLength(delPCalEntity,0);

        // Build lists of contacts modified and deleted in phone
        for j := 0 to pl.Count-1 do begin
          if Pos('M:', pl[j]) = 1 then begin //entries modified // do not localize
            SetLength(addPCalEntity, length(addPCalEntity) + 1);
            addPCalEntity[High(addPCalEntity)] := Copy(pl[j], Pos('::', pl[j]) + 2, length(pl[j]));
          end
          else if Pos('H:', pl[j]) = 1 then begin  //entries deleted // do not localize
            SetLength(delPCalEntity, length(delPCalEntity) + 1);
            delPCalEntity[High(delPCalEntity)] := Copy(pl[j], Pos('::', pl[j]) + 2, length(pl[j]));
          end;
        end;

        // next apply PC changes
        try
          //I := FCalendar.Count;
          for I := FCalendar.Count - 1 downto 0 do begin
            AEntity := FCalendar[I] as TVCalEntity;

            if AEntity.VFmaState <> 3 then begin // skip unmodified contacts
              AOutCal := TVCalendar.Create;
              AOutEntity := TVCalEntity.Create;

              // TODO: Check the output encoding
              if Form1.FUseUTF8 then AOutCal.OutputCharSet := tecUtf8Ascii
              else AOutCal.OutputCharSet := tecAscii;

              // Create copy of entity
              AOutEntity.Raw := AEntity.Raw;
              // Clear FMA state flag for sure
              AOutEntity.VFmaState := 3;

              stream := TMemoryStream.Create;
              try
                // Add it to the new calendar
                AOutCal.Add(AOutEntity);
                AOutCal.Raw.SaveToStream(stream);
                stream.Seek(0, soFromBeginning);
                Name := AEntity.VSummary.PropertyValue;

                ShowProgressTarget(Name);
              
                case AEntity.VFmaState of
                  0: begin //new
                       AEntity.VIrmcLUID.PropertyValue := Form1.ObexPutObject('telecom/cal/luid/.vcs', stream); //New LUID // do not localize
                       Log.AddSynchronizationMessage(Name + _(' added to phone by FMA.'), lsInformation);
                       AEntity.VFmaState := 3; //entries synchronized
                       Result := True;
                     end;
                  1: begin //modified
                       AsNew := CheckInArray(delPCalEntity, AEntity.VIrmcLUID.PropertyValue);
                       if AsNew then begin
                         AEntity.VIrmcLUID.PropertyValue := Form1.ObexPutObject('telecom/cal/luid/.vcs', stream); //New LUID // do not localize
                         Log.AddSynchronizationMessage(Name + _(' added to phone by FMA.'), lsInformation);
                       end
                       else begin
                         AEntity.VIrmcLUID.PropertyValue := Form1.ObexPutObject('telecom/cal/luid/' + AEntity.VIrmcLUID.PropertyValue + '.vcs', stream); //Modified LUID // do not localize
                         Log.AddSynchronizationMessage(Name + _(' modified in phone by FMA.'), lsInformation);
                       end;
                       AEntity.VFmaState := 3; //entries synchronized
                       Result := True;
                     end;
                  2: begin //deleted
                       AEntity.VIrmcLUID.PropertyValue := Form1.ObexPutObject('telecom/cal/luid/' + AEntity.VIrmcLUID.PropertyValue + '.vcs', nil); //deletd LUID // do not localize
                       FCalendar.Delete(FCalendar.IndexOf(AEntity));
                       Log.AddSynchronizationMessage(Name + _(' deleted in phone by FMA.'), lsInformation);
                       Result := True;
                     end;
                end;
              finally
                stream.Free;
                AOutCal.Free;
              end;
            end;
          end;
        finally
          // get current LOG Number from phone -- it will include all changes made in FMA that we just apply to phone
          Form1.ObexGetObject('telecom/cal/luid/cc.log',sl); // do not localize
          CC := sl.Strings[0];
        end;
      finally
        // Do we have to perform a full refresh? (too many changes in phone)
        {
          SN:351956003653753
          DID:43A3
          Total-Records:30
          Maximum-Records:380
          *
        }
        // Local changes have been applied to the phone already, so we can do
        // full refresh, if needed...
        GetAll := (pl.Count <> 0) and (pl[pl.Count-1] = '*');
      end;
    end
    else
      GetAll := MessageDlgW(_('Entire calendar should be downloaded from phone. All local changes will be LOST! Continue?'),
        mtConfirmation, MB_YESNO) = ID_YES;

    if GetAll then Result := FullRefresh;
  finally
    ANewCal.Free;
    sl.Free;
    pl.Free;
    Form1.ObexDisconnect;
  end;
end;

function TfrmCalendarView.FullRefresh: boolean;
  var
    sl: TStringList;
    calstr: TStringList;
    slCC:TStringList;
  vStorage: TVObjStorage;
  i : integer;
  AEntity: TVCalEntity;
  ANewCal: TVCalendar;
begin
  Result := False;
  sl := TStringList.Create;
  calstr := TStringList.Create;
  try
    //check if start OBEX
    if not Form1.FConnected then begin
       ShowMessageW(_('The Sync Calendar can''t start...try to restart your phone.'));
       Log.AddSynchronizationMessage(_('The Sync Calendar can''t start...try to restart your phone.'), lsError);
       Form1.ActionSyncPhonebook.Enabled := True;
       exit;
    end;

    //Start get of entire calendar
    Form1.ObexConnect('IRMC-SYNC'); //start sync process // do not localize
    try
      Form1.ObexGetObject('telecom/cal.vcs',sl,True,_('entire calendar')); // do not localize "telecom..."
      slCC := TStringList.Create;
      try
        Form1.ObexGetObject('telecom/cal/luid/cc.log',slCC); // Take CC // do not localize
        CC := slCC.Strings[0];
      finally
        slCC.Free;
      end;
    finally
      Form1.ObexDisconnect;        //close the connection
    end;

    //Process calendar entries
    vStorage := TVObjStorage.Create;
    ANewCal := TVCalendar.Create;
    try
      VpDB.Connected := False;
      vStorage.Raw := sl;
      Log.AddSynchronizationMessage('Calendar Full Refresh: Storage = ' + inttostr(vStorage.Count), lsDebug); // do not localize debug
      if vStorage.Count = 1 then FCalendar.Raw := (vStorage[0] as TVCalendar).Raw
      else begin
        FCalendar.Clear;
        for I := 0 to vStorage.Count - 1 do begin
          ANewCal.Raw := (vStorage[i] as TVCalendar).Raw;
          if ANewCal.Count = 1 then begin
            AEntity := TVCalEntity.Create;
            AEntity.Raw := (ANewCal[0] as TVCalEntity).Raw;
            FCalendar.Add(AEntity);
            Log.AddSynchronizationMessage(AEntity.VSummary.PropertyValue + _(' added '), lsInformation)

          end;
        end;
      end;
      Log.AddSynchronizationMessage('Calendar Full Refresh: Items = ' + inttostr(FCalendar.count), lsDebug); // do not localize debug

    VpDB.Connected := True;
    finally
      vStorage.Free;
      ANewCal.Free;
    end;

    Result := True;
  finally
    sl.Free;
    calstr.Free;

    OnConnected; // check auto-recurrence
  end;
end;

procedure TfrmCalendarView.SaveCalendar(FileName: WideString; SaveCC: Boolean);
var
  sl: TStrings;
begin
  sl := TStringList.Create;
  try
    if VpDB.vCalendar <> nil then begin
      VpDB.PostTasks;
      VpDB.PostEvents;

      // TODO: Check the output encoding
      if Form1.FUseUTF8 then
        FCalendar.OutputCharSet := tecUtf8
      else
        FCalendar.OutputCharSet := tecAscii;

      FCalendar.Raw.SaveToFile(FileName);

      if SaveCC then begin
        sl.add('CC:' + CC); // do not localize
        sl.SaveToFile(WideChangeFileExt(FileName,'.SYNC.dat')); // do not localize
      end;
    end;                      
  finally
    sl.Free;
  end;
end;

procedure TfrmCalendarView.LoadCalendar(FileName: WideString; IntoCal: TVCalendar);
var
  sl: TStrings;
  vStorage: TVObjStorage;
  i : integer;
  AEntity: TVCalEntity;
  ANewCal: TVCalendar;
  fn: WideString;
begin
  if not Assigned(IntoCal) then IntoCal := FCalendar;
    
  sl := TStringList.Create;
  vStorage := TVObjStorage.Create;
  ANewCal := TVCalendar.Create;
  try
    if IntoCal = FCalendar then VpDB.Connected := False;
    try
      vStorage.LoadFromFile(FileName);
      Log.AddSynchronizationMessage('Loading Calendar: Storage = ' + inttostr(vStorage.Count), lsDebug); // do not localize debug
      if vStorage.Count = 1 then
        IntoCal.Raw := (vStorage[0] as TVCalendar).Raw
      else begin
        for I := 0 to vStorage.Count - 1 do begin
          ANewCal.Raw := (vStorage[i] as TVCalendar).Raw;
          if ANewCal.Count = 1 then begin
            AEntity := TVCalEntity.Create;
            AEntity.Raw := (ANewCal[0] as TVCalEntity).Raw;
            IntoCal.Add(AEntity);
          end;
        end;
      end;
      Log.AddSynchronizationMessage('Loading Calendar: Items = ' + inttostr(IntoCal.count), lsDebug); // do not localize debug
    finally
      if IntoCal = FCalendar then VpDB.Connected := True;
    end;
    { Should we load Sync Index too? }
    if IntoCal = FCalendar then begin
      fn := WideChangeFileExt(FileName,'.SYNC.dat');
      if WideFileExists(fn) then begin
        sl.LoadFromFile(fn); // do not localize
        CC := Copy(sl[0], Pos(':', sl[0]) + 1, length(sl[0]));
      end
      else
        CC := '0';
    end;
  finally
    sl.Free;
    vStorage.Free;
    ANewCal.Free;
  end;
end;

function TfrmCalendarView.FindCalObj(LUID: Widestring; var ACalEntity: TVCalEntity): Boolean;
var
  I: Integer;
  AEntity: TVCalEntity;
begin
  Result := False;

  if (LUID <> '') and (FCalendar.Count > 0) then begin
    for I := 0 to FCalendar.Count - 1 do begin
      AEntity := FCalendar[I] as TVCalEntity;

      if AEntity.VIrmcLUID.PropertyValue = LUID then begin
        ACalEntity := AEntity;
        Result := True;
        Break;
      end;
    end;
  end;
end;

function TfrmCalendarView.ResolveConflict(EventName: WideString; Info:WideString; Appointment: Boolean): Integer;
begin
  Result := Form1.FSyncCalendarPrio;
  if Result = 2 then begin // ask me?
    Result := 0;
    frmPromptConflict := TfrmPromptConflict.Create(Self);
    try
      { Default frmPromptConflict.ObjKind is 'contact' }
      if Appointment then frmPromptConflict.ObjKind := _('The appointment:')
        else frmPromptConflict.ObjKind := _('The task:');
      frmPromptConflict.ObjName := EventName;
      frmPromptConflict.Info := Info;
      if (ConflictVCalPC.Raw.Count <> 0) and (ConflictVCalPhone.Raw.Count <> 0) then
        frmPromptConflict.OnViewChanges := OnConflictChanges;
      if frmPromptConflict.ShowModal = mrOK then begin
        Result := frmPromptConflict.SelectedItem;
        if frmPromptConflict.cbDontAskAgain.Checked then begin
          Form1.FSyncCalendarPrio := Result;
          Form1.FormStorage1.StoredValue['Sync Calendar'] := Form1.FSyncCalendarPrio; // do not localize
        end;
      end;
    finally
      frmPromptConflict.Free;
    end;
  end;  
end;

function TfrmCalendarView.CheckInArray(A: array of widestring; S: Widestring): boolean;
var
   i:Integer;
begin
  for i:=0 to High(A) do begin
     if A[i] = S then begin
        Result := True;
        Exit;
     end;
  end;
  Result := False;
end;

procedure TfrmCalendarView.VpDayViewDrawIcons(Sender: TObject;
  Event: TVpEvent; var Icons: TVpDVIcons);
begin
  if Event.RepeatCode <> rtNone then begin
    Icons[itRecurring].Show := True;

    ImageListCalPopup.GetBitmap(4, Icons[itRecurring].Bitmap);

    Icons[itRecurring].Bitmap.Transparent := True;
  end
  else
    Icons[itRecurring].Show := False;

  if Event.AlarmSet then begin
    Icons[itAlarm].Show := True;

    ImageListCalPopup.GetBitmap(3, Icons[itAlarm].Bitmap);

    Icons[itAlarm].Bitmap.Transparent := True;
  end
  else
    Icons[itAlarm].Show := False;

  if Event.UserField9 <> '' then begin
    Icons[itCustom].Show := True;

    case StrToInt(Event.UserField9) of
      0: ImageListCalPopup.GetBitmap(0, Icons[itCustom].Bitmap);
      1: ImageListCalPopup.GetBitmap(1, Icons[itCustom].Bitmap);
      2: ImageListCalPopup.GetBitmap(2, Icons[itCustom].Bitmap);
    else
      Icons[itCustom].Show := False;
    end;

    Icons[itCustom].Bitmap.Transparent := True;
  end
  else
    Icons[itCustom].Show := False;
end;

procedure TfrmCalendarView.ForceAsNotModifieDvClick(Sender: TObject);
begin
  if Assigned(VpDayView.ActiveEvent) then begin
    // Use UserField9 for FMA Task State
    VpDayView.ActiveEvent.UserField9 := '3';

    VpDayView.ActiveEvent.Deleted := False;
    VpDayView.ActiveEvent.Changed := True;

    // Store changes and repaint
    VpDayView.DataStore.PostEvents;
    VpDayView.Invalidate;
  end;
end;

procedure TfrmCalendarView.ForceAsModifiedDvClick(Sender: TObject);
begin
  if Assigned(VpDayView.ActiveEvent) then begin
    // Use UserField9 for FMA Task State
    VpDayView.ActiveEvent.UserField9 := '1';

    VpDayView.ActiveEvent.Deleted := False;
    VpDayView.ActiveEvent.Changed := True;

    // Store changes and repaint
    VpDayView.DataStore.PostEvents;
    VpDayView.Invalidate;
  end;
end;

procedure TfrmCalendarView.ForceasNewEventDvClick(Sender: TObject);
begin
  if Assigned(VpDayView.ActiveEvent) then begin
    // Use UserField9 for FMA Task State
    VpDayView.ActiveEvent.UserField9 := '0';

    VpDayView.ActiveEvent.Deleted := False;
    VpDayView.ActiveEvent.Changed := True;

    // Store changes and repaint
    VpDayView.DataStore.PostEvents;
    VpDayView.Invalidate;
  end;
end;

procedure TfrmCalendarView.ForceAsNotModifiedTlClick(Sender: TObject);
begin
  if Assigned(VpTaskList.ActiveTask) then begin
    // Use UserField9 for FMA Task State
    VpTaskList.ActiveTask.UserField9 := '3';

    VpTaskList.ActiveTask.Deleted := False;
    VpTaskList.ActiveTask.Changed := True;

    // Store changes and repaint
    VpDayView.DataStore.PostTasks;
    VpTaskList.Invalidate;
  end;
end;

procedure TfrmCalendarView.ForceasModifiedTlClick(Sender: TObject);
begin
  if Assigned(VpTaskList.ActiveTask) then begin
    // Use UserField9 for FMA Task State
    VpTaskList.ActiveTask.UserField9 := '1';

    VpTaskList.ActiveTask.Deleted := False;
    VpTaskList.ActiveTask.Changed := True;

    // Store changes and repaint
    VpTaskList.DataStore.PostTasks;
    VpTaskList.Invalidate;
  end;
end;

procedure TfrmCalendarView.ForceasNewEventTlClick(Sender: TObject);
begin
  if Assigned(VpTaskList.ActiveTask) then begin
    // Use UserField9 for FMA Task State
    VpTaskList.ActiveTask.UserField9 := '0';

    VpTaskList.ActiveTask.Deleted := False;
    VpTaskList.ActiveTask.Changed := True;

    // Store changes and repaint
    VpTaskList.DataStore.PostTasks;
    VpTaskList.Invalidate;
  end;
end;

procedure TfrmCalendarView.OnConflictChanges(Sender: TObject;
  const TargetName, Option1Name, Option2Name: WideString);
begin
  with TfrmConflictChanges.Create(nil) do
  try
    Target := TargetName;
    Option1 := Option1Name;
    Option2 := Option2Name;

    if WideCompareStr(ConflictVCalPhone.VAttach,ConflictVCalPC.VAttach) <> 0 then
      AddChange(_('Attach'),ConflictVCalPhone.VAttach,ConflictVCalPC.VAttach);

    if WideCompareStr(ConflictVCalPhone.VAttendee,ConflictVCalPC.VAttendee) <> 0 then
      AddChange(_('Attendee'),ConflictVCalPhone.VAttendee,ConflictVCalPC.VAttendee);

    if WideCompareStr(ConflictVCalPhone.VDescription,ConflictVCalPC.VDescription) <> 0 then
      AddChange(_('Description'),ConflictVCalPhone.VDescription,ConflictVCalPC.VDescription);

    if ConflictVCalPhone.VCompleted.GetLocal <> ConflictVCalPC.VCompleted.GetLocal then
      AddChange(_('Completed'),DateTimeToStr(ConflictVCalPhone.VCompleted.GetLocal),
        DateTimeToStr(ConflictVCalPC.VCompleted.GetLocal));

    if ConflictVCalPhone.VDtStart.GetLocal <> ConflictVCalPC.VDtStart.GetLocal then
      AddChange(_('Start Date'),DateTimeToStr(ConflictVCalPhone.VDtStart.GetLocal),
        DateTimeToStr(ConflictVCalPC.VDtStart.GetLocal));

    if ConflictVCalPhone.VDtEnd.GetLocal <> ConflictVCalPC.VDtEnd.GetLocal then
      AddChange(_('End Date'),DateTimeToStr(ConflictVCalPhone.VDtEnd.GetLocal),
        DateTimeToStr(ConflictVCalPC.VDtEnd.GetLocal));

    if ConflictVCalPhone.VDue.GetLocal <> ConflictVCalPC.VDue.GetLocal then
      AddChange(_('Due Date'),DateTimeToStr(ConflictVCalPhone.VDue.GetLocal),
        DateTimeToStr(ConflictVCalPC.VDue.GetLocal));

    if WideCompareStr(ConflictVCalPhone.VRelatedTo,ConflictVCalPC.VRelatedTo) <> 0 then
      AddChange(_('Related To'),ConflictVCalPhone.VRelatedTo,ConflictVCalPC.VRelatedTo);
    {
    if WideCompareStr(ConflictVCalPhone.VExRule,ConflictVCalPC.VExRule) <> 0 then
      AddChange(_('VExRule'),ConflictVCalPhone.VExRule,ConflictVCalPC.VExRule);
    }
    if WideCompareStr(ConflictVCalPhone.VRRule.Description,ConflictVCalPC.VRRule.Description) <> 0 then
      AddChange(_('Reccurence'),ConflictVCalPhone.VRRule.Description,ConflictVCalPC.VRRule.Description);

    if WideCompareStr(ConflictVCalPhone.VURL,ConflictVCalPC.VURL) <> 0 then
      AddChange(_('URL'),ConflictVCalPhone.VURL,ConflictVCalPC.VURL);

    if WideCompareStr(ConflictVCalPhone.VLocation.PropertyValue,ConflictVCalPC.VLocation.PropertyValue) <> 0 then
      AddChange(_('Location'),ConflictVCalPhone.VLocation.PropertyValue,ConflictVCalPC.VLocation.PropertyValue);

    if WideCompareStr(ConflictVCalPhone.VPriority.PropertyValue,ConflictVCalPC.VPriority.PropertyValue) <> 0 then
      AddChange(_('Priority'),ConflictVCalPhone.VPriority.PropertyValue,ConflictVCalPC.VPriority.PropertyValue);

    if WideCompareStr(ConflictVCalPhone.VSummary.PropertyValue,ConflictVCalPC.VSummary.PropertyValue) <> 0 then
      AddChange(_('Summary'),ConflictVCalPhone.VSummary.PropertyValue,ConflictVCalPC.VSummary.PropertyValue);

    if ConflictVCalPhone.VAAlarm.GetLocal <> ConflictVCalPC.VAAlarm.GetLocal then
      AddChange(_('Alarm'),DateTimeToStr(ConflictVCalPhone.VAAlarm.GetLocal),
        DateTimeToStr(ConflictVCalPC.VAAlarm.GetLocal));

    if ConflictVCalPhone.VCategories.PropertyValue <> ConflictVCalPC.VCategories.PropertyValue then
      AddChange(_('Categories'),ConflictVCalPhone.VCategories.PropertyValue,ConflictVCalPC.VCategories.PropertyValue);

    if ConflictVCalPhone.VClass.PropertyValue <> ConflictVCalPC.VClass.PropertyValue then
      AddChange(_('Class'),ConflictVCalPhone.VClass.PropertyValue,ConflictVCalPC.VClass.PropertyValue);

    if ConflictVCalPhone.VStatus.PropertyValue <> ConflictVCalPC.VStatus.PropertyValue then
      AddChange(_('Status'),ConflictVCalPhone.VStatus.PropertyValue,ConflictVCalPC.VStatus.PropertyValue);
    {
    if ConflictVCalPhone.VDAlarm <> ConflictVCalPC.VDAlarm then
      AddChange(_('VDAlarm'),ConflictVCalPhone.VDAlarm,ConflictVCalPC.VDAlarm);
    if ConflictVCalPhone.VMAlarm <> ConflictVCalPC.VMAlarm then
      AddChange(_('VMAlarm'),ConflictVCalPhone.VMAlarm,ConflictVCalPC.VMAlarm);
    if ConflictVCalPhone.VPAlarm <> ConflictVCalPC.VPAlarm then
      AddChange(_('VPAlarm'),ConflictVCalPhone.VPAlarm,ConflictVCalPC.VPAlarm);
    if ConflictVCalPhone.VExDate <> ConflictVCalPC.VExDate then
      AddChange(_('VExDate'),ConflictVCalPhone.VExDate,ConflictVCalPC.VExDate);
    if ConflictVCalPhone.VRDate <> ConflictVCalPC.VRDate then
      AddChange(_('VRDate'),ConflictVCalPhone.VRDate,ConflictVCalPC.VRDate);
    }
    if ChangeCount <> 0 then ShowModal
      else MessageDlgW(_('No changes found.'), mtInformation, MB_OK);
  finally
    Free;
  end;
end;

procedure TfrmCalendarView.RecurringClick(Sender: TObject);
var
  Shifted: boolean;
begin
  if Assigned(VpDayView.ActiveEvent) then begin
    if MessageDlgW(WideFormat(_('Going to shift event "%s" into future (%s). Do you wish to continue?'),
      [VpDayView.ActiveEvent.Description,(Sender as TTntMenuItem).Caption]),
      mtConfirmation, MB_YESNO or MB_DEFBUTTON1) = ID_YES then begin
      // Shift event
      if Sender = NextDay1 then                     { Y,M,D }
        Shifted := DoShiftEvent(VpDayView.ActiveEvent,0,0,1)
      else
      if Sender = NextWeek1 then                    { Y,M,D }
        Shifted := DoShiftEvent(VpDayView.ActiveEvent,0,0,7)
      else
      if Sender = NextMonth1 then                   { Y,M,D }
        Shifted := DoShiftEvent(VpDayView.ActiveEvent,0,1,0)
      else
      if Sender = NextYear1 then                    { Y,M,D }
        Shifted := DoShiftEvent(VpDayView.ActiveEvent,1,0,0)
      else
        Shifted := False;

      // Get info
      if Shifted then begin
        // Store changes and repaint
        VpDayView.DataStore.PostEvents;
        VpDayView.Invalidate;
      end;
    end;
  end;
end;

procedure TfrmCalendarView.PopupMenuDayViewPopup(Sender: TObject);
begin
  DownloadentireCalendar1.Enabled := Form1.FConnected and not Form1.FObex.Connected;
  ForceasNotModifieDv.Enabled := Assigned(VpDayView.ActiveEvent);
  ForceasModifiedDv.Enabled := ForceasNotModifieDv.Enabled;
  ForceasNewEventDv.Enabled := ForceasNotModifieDv.Enabled;
  RecurItem1.Enabled := ForceasNotModifieDv.Enabled;
  Properties1.Enabled := ForceasNotModifieDv.Enabled;
end;

function TfrmCalendarView.DoShiftDate(Dt: TDateTime; Year,Month,Day: Word): TDateTime;
var
  Y,M,D,HH,MM,s,u: Word;
begin
  DecodeDateTime(Dt,Y,M,D,HH,MM,s,u);
  if Month > 0 then begin
    inc(M,Month);
    if M > 12 then begin
      inc(Y,(M-1) div 12);
      while M > 12 do dec(M,12);
    end;
  end;
  if Year > 0 then
    inc(Y,Year);
  Result := EncodeDateTime(Y,M,D,HH,MM,s,u);
  if Day > 0 then
    Result := Result + Day;
end;

function TfrmCalendarView.DoShiftEvent(Event: TVpEvent; Year, Month, Day: Word): boolean;
begin
  Event.UserField9 := '1'; // set to modified

  Event.Deleted := False;
  Event.Changed := True;

  // Change date
  Event.StartTime := DoShiftDate(Event.StartTime, Year, Month, Day);
  Event.AlertDisplayed := False;
  if Event.EndTime < Event.StartTime then
    Event.EndTime := DoShiftDate(Event.EndTime, Year, Month, Day);
  if Event.RepeatRangeEnd < Event.StartTime then
    Event.RepeatRangeEnd := DoShiftDate(Event.RepeatRangeEnd, Year, Month, Day);
    
  Result := True;
end;

procedure TfrmCalendarView.OnConnected;
var
  I,Retry: Integer;
  Modified,Asked,Changed: boolean;
  AEntity: TVCalEntity;
begin
  if Form1.FCalRecurrence then 
    try
      if Visible then Update;
      VpDB.Connected := False;
      Changed := False;
      try
        Asked := False;
        Retry := 0;
        repeat
          Modified := False;
          inc(Retry);
          for I := 0 to VpDB.vCalendar.Count-1 do begin
            AEntity := VpDB.vCalendar[I] as TVCalEntity;

            if AEntity.VDtStart.IsSet and (YearOf(AEntity.VDtStart.DateTime) < YearOf(Date)) then begin
              if not Modified and not Asked and Form1.FCalRecurrAsk then begin
                MessageBeep(MB_ICONQUESTION);
                if MessageDlgW(_('You have some Calendar entities in the past year. Do you want to recurrent them to this year?'),
                  mtConfirmation,MB_YESNO) = ID_NO then begin
                  if not Form1.FStartupOptions.NoBaloons then
                    Form1.ShowBaloonInfo(_('You can disable Calendar Reccurence in Tools | Options | Synchronization | Events and  Tasks.'));
                  Abort;
                end;
                Asked := True;
              end;

              AEntity.Raw.BeginUpdate;
              try
                AEntity.VFmaState := 1; // set to modified
                AEntity.VDtStart.DateTime := DoShiftDate(AEntity.VDtStart.DateTime,1,0,0);
                if AEntity.VDtEnd.IsSet and (AEntity.VDtEnd.DateTime < AEntity.VDtStart.DateTime) then
                  AEntity.VDtEnd.DateTime := DoShiftDate(AEntity.VDtEnd.DateTime,1,0,0);
                if AEntity.VDue.IsSet and (AEntity.VDue.DateTime < AEntity.VDtStart.DateTime) then
                  AEntity.VDue.DateTime := DoShiftDate(AEntity.VDue.DateTime,1,0,0);
                if AEntity.VAAlarm.IsSet and (AEntity.VAAlarm.DateTime < AEntity.VDtStart.DateTime) then
                  AEntity.VAAlarm.DateTime := DoShiftDate(AEntity.VAAlarm.DateTime,1,0,0);
                AEntity.VCompleted.Clear;
                AEntity.VLastModified.DateTime := Now;
              finally
                AEntity.Raw.EndUpdate;
              end;
              Changed := True;
              Modified := True;
            end;
          end;
        until not Modified or (Retry > 10);
      except
      end;
      if Changed then
      try
        // Store changes and repaint
        VpDB.RefreshEvents;
        VpDB.RefreshContacts;
        VpDB.RefreshTasks;
        VpDB.RefreshResource;
      except
      end;
    finally
      VpDB.Connected := True;
      if Visible then Update;
    end;
end;

procedure TfrmCalendarView.PopupMenuTaskListPopup(Sender: TObject);
begin
  DownloadEntireCalendar2.Enabled := Form1.FConnected and not Form1.FObex.Connected;
  ForceasNotModifiedTl.Enabled := Assigned(VpTaskList.ActiveTask);
  ForceasModifiedTl.Enabled := ForceasNotModifiedTl.Enabled;
  ForceasNewEventTl.Enabled := ForceasNotModifiedTl.Enabled;
  CompletedStatus1.Enabled := ForceasNotModifiedTl.Enabled;
  Properties2.Enabled := ForceasNotModifiedTl.Enabled;
end;

procedure TfrmCalendarView.DownloadentireCalendar1Click(Sender: TObject);
begin
  if MessageDlgW(_('Local Calendar will be replaced with a fresh copy from the phone.')+
    sLinebreak+sLinebreak+_('Any local changes will be lost. Do you wish to continue?'),
    mtConfirmation, MB_YESNO or MB_DEFBUTTON2) = ID_YES then begin
    ClearAllData;
    FullRefresh;
  end;
end;

procedure TfrmCalendarView.CompletedStatusClick(Sender: TObject);
begin
  if Assigned(VpTaskList.ActiveTask) then begin
    // Use UserField9 for FMA Task State
    VpTaskList.ActiveTask.UserField9 := '1';

    VpTaskList.ActiveTask.Deleted := False;
    VpTaskList.ActiveTask.Changed := True;

    if Sender = CompletedToday1 then begin
      VpTaskList.ActiveTask.Complete := True;
      VpTaskList.ActiveTask.CompletedOn := Now;
    end;
    if Sender = CompletedClear1 then begin
      VpTaskList.ActiveTask.Complete := False;
      VpTaskList.ActiveTask.CompletedOn := 0;
    end;

    // Store changes and repaint
    VpTaskList.DataStore.PostTasks;
    VpTaskList.Invalidate;
  end;
end;

procedure TfrmCalendarView.Properties1Click(Sender: TObject);
begin
  VpDayView.EditSelectedEvent;
end;

procedure TfrmCalendarView.ImportCalendar1Click(Sender: TObject);
var
  j: integer;
  dlg: TfrmConnect;
  Modified: Integer;
  ACalendar: TVCalendar;
  AEntity,NewEntity: TVCalEntity;
begin
  if not OpenDialog1.Execute then exit;
  if Visible then Update;
  dlg := GetProgressDialog;
  try
    if Form1.CanShowProgress then
      dlg.ShowProgress(Form1.FProgressLongOnly);
    dlg.InitializeLoop('Loading calendar file...');

    Form1.Status(_('Importing calendar...'));
    Log.AddSynchronizationMessage(_('Import started'));

    Modified := 0;
    VpDB.Connected := False;
    ACalendar := TVCalendar.Create;
    try
      LoadCalendar(OpenDialog1.FileName,ACalendar);
      dlg.Initialize(ACalendar.Count,_('Importing phone calendar'));

      for j := 0 to ACalendar.Count-1 do begin
        { Object already exists? }
        NewEntity := ACalendar[j] as TVCalEntity;
        if not FindCalObj(NewEntity.VIrmcLUID.PropertyValue,AEntity) then begin
          { Nop, add it to current Calendar items... }
          AEntity := TVCalEntity.Create;
          AEntity.Raw := NewEntity.Raw;
          { ...and mark this item as New }
          AEntity.VFmaState := 0; // UserField9 := '0';
          VpDB.vCalendar.Add(AEntity);
          inc(Modified);
        end;
        dlg.IncProgress(1);
        Application.ProcessMessages;
      end;

      Log.AddSynchronizationMessage(WideFormat(_('Imported %d %s from "%s"'),
        [Modified, ngettext('item','items',Modified), WideExtractFileName(OpenDialog1.FileName)]),
        lsInformation);
    finally
      ACalendar.Free;
      if Modified <> 0 then begin
        // Store changes and repaint
        VpDB.RefreshEvents;
        VpDB.RefreshContacts;
        VpDB.RefreshTasks;
        VpDB.RefreshResource;
      end;
      VpDB.Connected := True;
      if Visible then Update;
    end;
  finally
    FreeProgressDialog;
    Log.AddSynchronizationMessage(_('Import finished'));
    Form1.Status(_('Import complete.'));
  end;
end;

procedure TfrmCalendarView.ClearAllData;
begin
  VpDB.Connected := False;
  try
    VpDB.vCalendar.Clear;
    // Store changes and repaint
    VpDB.RefreshEvents;
    VpDB.RefreshContacts;
    VpDB.RefreshTasks;
    VpDB.RefreshResource;
  finally
    VpDB.Connected := True;
    if Visible then Update;
  end;
end;

procedure TfrmCalendarView.Properties2Click(Sender: TObject);
begin
  if PopupMenuTaskList.Items.Count > 12 then
    PopupMenuTaskList.Items[1].Click; // HACK! Second popup menu item is "Edit Task..."
end;

procedure TfrmCalendarView.VpDayViewBeforeEdit(Sender: TObject; Event: TVpEvent; var AllowIt: Boolean);
begin
  AllowIt := False; // no inline editing!
end;

procedure TfrmCalendarView.VpTaskListBeforeEdit(Sender: TObject;
  Task: TVpTask; var AllowIt: Boolean);
begin
  AllowIt := False; // no inline editing!
end;

procedure TfrmCalendarView.VpTaskListDrawIcons(Sender: TObject;
  Task: TVpTask; var Icons: TVpDVIcons);
begin
  if Task.UserField0 <> '' then begin
    ImageListCalPopup.GetBitmap(3, Icons[itAlarm].Bitmap);
    Icons[itAlarm].Show := True;
    Icons[itAlarm].Bitmap.Transparent := True;
  end
  else
    Icons[itAlarm].Show := False;

  if Task.UserField9 <> '' then begin
    Icons[itCustom].Show := True;
    case StrToInt(Task.UserField9) of
      0: ImageListCalPopup.GetBitmap(0, Icons[itCustom].Bitmap);
      1: ImageListCalPopup.GetBitmap(1, Icons[itCustom].Bitmap);
      2: ImageListCalPopup.GetBitmap(2, Icons[itCustom].Bitmap);
    else
      Icons[itCustom].Show := False;
    end;
    Icons[itCustom].Bitmap.Transparent := True;
  end
  else
    Icons[itCustom].Show := False;
end;

procedure TfrmCalendarView.VpTaskListCompleteChange(Sender: TObject;
  Task: TVpTask);
begin
  if Task.Changed and (Task.UserField9 <> '0') then Task.UserField9 := '1';
end;

procedure TfrmCalendarView.VpBDAlert(Sender: TObject; Event: TVpEvent);
var
  e: TVCalEntity;
begin
  Event.AlertDisplayed := True; // dismiss by default
  e := FCalendar.GetCalEntityByItemIndex(Event.RecordID - 1);
  if Assigned(e) then e.VAlertShown.Text := '1';

  { Create Calendar events in new alarm dialog }
  with TfrmNewAlarm.Create(nil) do
  try
    CreateEvent(Event.Description,255,Event.RecordID);
  except
    Free;
  end;
end;

end.
