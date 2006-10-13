unit uVpVDB; // do not localize

{
*******************************************************************************
* Descriptions: vCalendar implementation
* $Source: /cvsroot/fma/fma/uVpVDB.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uVpVDB.pas,v $
*
*******************************************************************************
}

interface

uses
  Classes, TntClasses, VpBaseDS, VpData, uVCalendar;

type
  TVpVDataStore = class(TVpCustomDataStore)
  protected
    FCalendar: TVCalendar;
    procedure SetConnected(const Value: boolean); override;
    procedure SetCalendar(const Value: TVCalendar);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Load; override;
    procedure PostResources; override;

    procedure PurgeResource(Res: TVpResource); override;
    procedure PurgeEvents(Res: TVpResource); override;
    procedure PurgeTasks(Res: TVpResource); override;

    // Override just to avoid warnings
    function GetNextID(TableName: string): integer; override;
    procedure LoadEvents; override;
    procedure LoadContacts; override;
    procedure LoadTasks; override;
    procedure PostContacts; override;
    procedure PostEvents; override;
    procedure PostTasks; override;
    procedure SetResourceByName(Value: string); override;

    property vCalendar: TVCalendar read FCalendar write SetCalendar;
  end;

implementation

uses
  Dialogs, TntDialogs, DateUtils, uVBase, SysUtils, TntSysUtils;

constructor TVpVDataStore.Create(AOwner: TComponent);
begin
  inherited;

  FCalendar := nil;
end;

destructor TVpVDataStore.Destroy;
begin
  FCalendar := nil;
  
  inherited;
end;

procedure TVpVDataStore.SetConnected(const Value: boolean);
begin
  { disconnect if destroying }
  if csDestroying in ComponentState then begin
    Exit;
  end;

  { Don't connect at designtime }
  if csDesigning in ComponentState then Exit;

  { Don't try to connect until we're all loaded up }
  if csLoading in ComponentState then Exit;

  if Value then Load;

  inherited;
end;

procedure TVpVDataStore.SetCalendar(const Value: TVCalendar);
begin
  if Value <> FCalendar then
  begin
    FCalendar := Value;
    if FCalendar <> nil then Load;
  end;
end;

procedure TVpVDataStore.Load;
  var
    I: Integer;

    ACalEntity: TVCalEntity;

    Event: TVpEvent;
    Task: TVpTask;
begin
  Loading := true;
  try
    Resources.ClearResources;

    { Load this resource into memory }
    Resource := Resources.AddResource(-1);

    if FCalendar <> nil then begin
      for I := 0 to FCalendar.Count - 1 do begin
        ACalEntity := TVCalEntity(FCalendar[I]);

        // TODO: Display item state
        if ACalEntity.VType.EntityType = tenVEvent then
        begin
          Event := Resource.Schedule.AddEvent(0,
            ACalEntity.VDtStart.GetLocal, ACalEntity.VDtEnd.GetLocal);
          if Event <> nil then begin
            Event.Loading := true;

            Event.Description := ACalEntity.VSummary.PropertyValue;
            // Use UserField0 for location value
            Event.UserField0 := ACalEntity.VLocation.PropertyValue;

            if ACalEntity.VCategories.IsSet then
            begin
              if tcaAppointment in ACalEntity.VCategories.Categories then Event.Category := 1
              else if tcaDate in ACalEntity.VCategories.Categories then Event.Category := 2
              else if tcaTravel in ACalEntity.VCategories.Categories then Event.Category := 3
              else if tcaVacation in ACalEntity.VCategories.Categories then Event.Category := 4
              else if tcaAnniversary in ACalEntity.VCategories.Categories then Event.Category := 5
              else Event.Category := 0
            end;

            if ACalEntity.VAAlarm.IsSet then
            begin
              Event.UserField1 := DateTimeToStr(ACalEntity.VAAlarm.GetLocal);
              Event.AlarmSet := True;
            end;

            // Use UserField9 for FMA Event State
            Event.UserField9 := IntToStr(ACalEntity.VFmaState);

            // RecordID 0 means new event
            Event.RecordID := ACalEntity.ItemIndex + 1;

            Event.Loading := false;
          end;
        end
        else begin
          if ACalEntity.VType.EntityType = tenVTodo then
          begin
            Task := Resource.Tasks.AddTask(0);
            if Task <> nil then begin
              Task.Loading := true;

              Task.Description := ACalEntity.VSummary.PropertyValue;

              if tcaPhoneCall in ACalEntity.VCategories.Categories then Task.Category := 1
              else Task.Category := 0;

              Task.Complete := (ACalEntity.VStatus.Status = tstCompleted);
              Task.CompletedOn := ACalEntity.VCompleted.GetLocal;

              if ACalEntity.VAAlarm.Text <> '' then
              begin
                Task.UserField0 := FloatToStr(Double(ACalEntity.VAAlarm.GetLocal));
              end;

              // Use UserField9 for FMA Task State
              Task.UserField9 := IntToStr(ACalEntity.VFmaState);

              // RecordID 0 means new task
              Task.RecordID := ACalEntity.ItemIndex + 1;

              Task.Loading := false;
            end;
          end;
        end;
      end;
    end;
  finally
    Loading := false;
  end;

  inherited;
end;

function TVpVDataStore.GetNextID(TableName: string): integer;
begin
  // Just to avoid warnings
  inherited;
  Result := 0;
end;

procedure TVpVDataStore.LoadEvents;
begin
  inherited;
end;

procedure TVpVDataStore.LoadContacts;
begin
  // Just to avoid warnings
  inherited;
end;

procedure TVpVDataStore.LoadTasks;
begin
  // Just to avoid warnings
  inherited;
end;

procedure TVpVDataStore.SetResourceByName(Value: string);
begin
  // Just to avoid warnings
  inherited;
end;

procedure TVpVDataStore.PostResources;
begin
  // Just to avoid warnings
  inherited;
end;

procedure TVpVDataStore.PostContacts;
begin
  // Just to avoid warnings
  inherited;
end;

procedure TVpVDataStore.PostEvents;
  var
    I: Integer;
    ACalEntity: TVCalEntity;
    Event: TVpEvent;
begin
  if (Resource <> nil) and Resource.EventsDirty then begin
    for I := pred(Resource.Schedule.EventCount) downto 0 do begin
      Event := Resource.Schedule.GetEvent(I);
      if Event.Deleted then begin
        if Event.RecordID <> 0 then
        begin
          ACalEntity := FCalendar.GetCalEntityByItemIndex(Event.RecordID - 1);

          if Event.UserField9 = '0' then
          begin
            FCalendar.Remove(ACalEntity);
            Event.Free;
          end
          else begin
            ACalEntity.VFmaState := 2;
            Event.UserField9 := IntToStr(2);
          end;
        end
        else Event.Free;

        Continue;
      end

      else if Event.Changed then begin
        if Event.RecordID = 0 then
        begin
          { RecordID = 0 => make new entry }
          ACalEntity := TVCalEntity.Create;
          ACalEntity.VType.EntityType := tenVEvent;

          Event.UserField9 := IntToStr(0);

          FCalendar.Add(ACalEntity);

          Event.RecordID := ACalEntity.ItemIndex + 1;
        end
        else begin
          ACalEntity := FCalendar.GetCalEntityByItemIndex(Event.RecordID - 1);

          if ACalEntity.VIrmcLUID.PropertyValue = '' then Event.UserField9 := IntToStr(0);
        end;

        ACalEntity.VDtStart.IsUtc := False;
        ACalEntity.VDtStart.DateTime := Event.StartTime;
        ACalEntity.VDtStart.LocalToUtc;
        ACalEntity.VDtEnd.IsUtc := False;
        ACalEntity.VDtEnd.DateTime := Event.EndTime;
        ACalEntity.VDtEnd.LocalToUtc;

        ACalEntity.VSummary.PropertyValue := Event.Description;
        // Use UserField0 for location value
        ACalEntity.VLocation.PropertyValue := Event.UserField0;

        case Event.Category of
          0: ACalEntity.VCategories.Categories := [tcaMiscellaneous];
          1: ACalEntity.VCategories.Categories := [tcaAppointment];
          2: ACalEntity.VCategories.Categories := [tcaDate];
          3: ACalEntity.VCategories.Categories := [tcaTravel];
          4: ACalEntity.VCategories.Categories := [tcaVacation];
          5: ACalEntity.VCategories.Categories := [tcaAnniversary];
        else
          ACalEntity.VCategories.Categories := [tcaMiscellaneous];
        end;

        if Event.AlarmSet then
        begin
          ACalEntity.VAAlarm.IsUtc := False;
          ACalEntity.VAAlarm.DateTime := StrToDateTime(Event.UserField1);
          ACalEntity.VAAlarm.LocalToUtc;
        end
        else ACalEntity.VAAlarm.IsSet := False;

        ACalEntity.VFmaState := StrToInt(Event.UserField9);

        Event.Changed := false;
      end;
    end;

    NotifyDependents;
    Resource.Schedule.Sort;
    Resource.EventsDirty := false;
  end;
end;

procedure TVpVDataStore.PostTasks;
  var
    I: Integer;
    ACalEntity: TVCalEntity;
    Task: TVpTask;
begin
  if (Resources <> nil) and Resource.TasksDirty then begin
    for I := pred(Resource.Tasks.Count) downto 0 do begin
      Task := Resource.Tasks.GetTask(I);
      if Task.Deleted then begin
        if Task.RecordID <> 0 then
        begin
          ACalEntity := FCalendar.GetCalEntityByItemIndex(Task.RecordID - 1);

          if Task.UserField9 = '0' then
          begin
            FCalendar.Remove(ACalEntity);
            Task.Free;
          end
          else begin
            ACalEntity.VFmaState := 2;
            Task.UserField9 := '2';
          end;
        end
        else Task.Free;

        Continue;
      end

      else if Task.Changed then begin
        if Task.RecordID = 0 then
        begin
          { RecordID = 0 => make new entry }
          ACalEntity := TVCalEntity.Create;
          ACalEntity.VType.EntityType := tenVTodo;

          Task.UserField9 := IntToStr(0);

          FCalendar.Add(ACalEntity);

          Task.RecordID := ACalEntity.ItemIndex + 1;
        end
        else begin
          ACalEntity := FCalendar.GetCalEntityByItemIndex(Task.RecordID - 1);

          if ACalEntity.VIrmcLUID.PropertyValue = '' then Task.UserField9 := IntToStr(0);
        end;

        ACalEntity.VSummary.PropertyValue := Task.Description;

        if Task.Category = 1 then ACalEntity.VCategories.Categories := [tcaPhoneCall]
        else ACalEntity.VCategories.Categories := [tcaMiscellaneous];

        if Task.Complete then
        begin
          ACalEntity.VStatus.Status := tstCompleted;

          ACalEntity.VCompleted.IsUtc := False;
          ACalEntity.VCompleted.DateTime := Task.CompletedOn;
          ACalEntity.VCompleted.LocalToUtc;
        end
        else begin
          ACalEntity.VStatus.Status := tstNeedsAction;
          ACalEntity.VCompleted.Text := '';
        end;

        ACalEntity.VAAlarm.Text := '';

        if Task.UserField0 <> '' then
        begin
          ACalEntity.VAAlarm.IsUtc := False;
          try
            ACalEntity.VAAlarm.DateTime := StrToFloat(Task.UserField0);
            ACalEntity.VAAlarm.LocalToUtc;
          except
          end;
        end;

        ACalEntity.VFmaState := StrToInt(Task.UserField9);

        Task.Changed := false;
      end;
    end;

    NotifyDependents;
    Resource.TasksDirty := false;
  end;
end;

procedure TVpVDataStore.PurgeResource(Res: TVpResource);
begin
  inherited;
end;

procedure TVpVDataStore.PurgeEvents(Res: TVpResource);
begin
  inherited;
end;

procedure TVpVDataStore.PurgeTasks(Res: TVpResource);
begin
  inherited;
end;

end.
