unit VolumeCtrlCoClass;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, ActiveX, Classes, ComObj, floAtMediaCtrl_TLB, StdVcl;

type

  TVolumeCtrl = class(TAutoObject, IVolumeCtrl)
  protected
    function Get_Mute: Integer; safecall;
    procedure Set_Mute(Value: Integer); safecall;
    function Get_Volume: Integer; safecall;
    procedure Set_Volume(Value: Integer); safecall;
    procedure Set_DestinationID(Param1: Integer); safecall;
    procedure Set_ConnectionID(Param1: Integer); safecall;
    procedure Set_ShowDurationMS(Param1: Integer); safecall;
    procedure Show; safecall;
    function Get_GetReferences: Integer; safecall;
    procedure Set_GradualVol(Value: Integer); safecall;
  private
    function GetRefCount: integer;
  public
    procedure Initialize; override;
    destructor Destroy; override;
  end;

implementation

uses
  ComServ, FormVolumeCtrl, FormOptions;

function TVolumeCtrl.Get_Mute: Integer;
begin
  if FormVolumeDisp.GetMute then
    Result := 1
  else
    Result := 0;
end;

procedure TVolumeCtrl.Set_Mute(Value: Integer);
begin
  if Value = 0 then
    FormVolumeDisp.SetMute(False)
  else
    FormVolumeDisp.SetMute(True);
end;

function TVolumeCtrl.Get_Volume: Integer;
begin
  Result := FormVolumeDisp.GetVolume;
end;

procedure TVolumeCtrl.Set_Volume(Value: Integer);
begin
  FormVolumeDisp.SetVolume(Value);
end;

procedure TVolumeCtrl.Set_DestinationID(Param1: Integer);
begin
  FormVolumeDisp.FDestinationID := Param1;
end;

procedure TVolumeCtrl.Set_ConnectionID(Param1: Integer);
begin
  FormVolumeDisp.FConnectionID := Param1;
end;

procedure TVolumeCtrl.Set_ShowDurationMS(Param1: Integer);
begin
  FormVolumeDisp.Timer1.Interval := Param1;
end;

procedure TVolumeCtrl.Show;
begin
  FormVolumeDisp.ShowOSD;
end;

procedure TVolumeCtrl.Initialize;
begin
  inherited;
  FormSettings.UpdateCoClass(True);
end;

destructor TVolumeCtrl.Destroy;
begin
  FormSettings.UpdateCoClass(False);
  inherited;
end;

function TVolumeCtrl.GetRefCount: integer;
begin
  Result := FormSettings.MixerInstCount;
end;

function TVolumeCtrl.Get_GetReferences: Integer;
begin
  Result := GetRefCount;
end;

procedure TVolumeCtrl.Set_GradualVol(Value: Integer);
begin
  if Value = 0 then
    FormVolumeDisp.FGradualVol := False
  else
    FormVolumeDisp.FGradualVol := True;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TVolumeCtrl, CLASS_VolumeCtrl,
    ciSingleInstance, tmApartment);
end.

