unit uRegistry;

{
*******************************************************************************
* Descriptions: Global Registry functions
* $Source: /cvsroot/fma/fma/uRegistry.pas,v $
* $Locker:  $
*
* Todo:
*
* Change Log:
* $Log: uRegistry.pas,v $
*
}

interface

procedure InitRegistry;

implementation

uses Registry;

procedure InitRegistry;
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  try
    reg.OpenKey('\AppEvents\EventLabels\SMSReceived', True); // do not localize
    reg.WriteString('', 'SMS Received'); // do not localize
    reg.CloseKey;

    reg.OpenKey('\AppEvents\EventLabels\SMSSent', True); // do not localize
    reg.WriteString('', 'SMS Sent'); // do not localize
    reg.CloseKey;

    reg.OpenKey('\AppEvents\EventLabels\Calling', True); // do not localize
    reg.WriteString('', 'Calling Contact'); // do not localize
    reg.CloseKey;

    reg.OpenKey('\AppEvents\EventLabels\CallReceived', True); // do not localize
    reg.WriteString('', 'Call Received'); // do not localize
    reg.CloseKey;

    reg.OpenKey('\AppEvents\EventLabels\MEConnected', True); // do not localize
    reg.WriteString('', 'Connected to Mobile Equipment'); // do not localize
    reg.CloseKey;

    reg.OpenKey('\AppEvents\EventLabels\MEDisconnected', True); // do not localize
    reg.WriteString('', 'Disconnected from Mobile Equipment'); // do not localize
    reg.CloseKey;

    reg.OpenKey('\AppEvents\EventLabels\Away', True); // do not localize
    reg.WriteString('', 'Proximity Away'); // do not localize
    reg.CloseKey;

    reg.OpenKey('\AppEvents\EventLabels\Near', True); // do not localize
    reg.WriteString('', 'Proximity Near'); // do not localize
    reg.CloseKey;

    reg.OpenKey('\AppEvents\EventLabels\Alarm', True); // do not localize
    reg.WriteString('', 'Alarm Activated'); // do not localize
    reg.CloseKey;

    reg.OpenKey('\AppEvents\Schemes\Apps\MobileAgent', True); // do not localize
    reg.WriteString('', 'floAt''s Mobile Agent'); // do not localize
    reg.CloseKey;
    reg.CreateKey('\AppEvents\Schemes\Apps\MobileAgent\Calling'); // do not localize
    reg.CreateKey('\AppEvents\Schemes\Apps\MobileAgent\CallReceived'); // do not localize
    reg.CreateKey('\AppEvents\Schemes\Apps\MobileAgent\SMSReceived'); // do not localize
    reg.CreateKey('\AppEvents\Schemes\Apps\MobileAgent\SMSSent'); // do not localize
    reg.CreateKey('\AppEvents\Schemes\Apps\MobileAgent\Away'); // do not localize
    reg.CreateKey('\AppEvents\Schemes\Apps\MobileAgent\Near'); // do not localize
    reg.CreateKey('\AppEvents\Schemes\Apps\MobileAgent\MEConnected'); // do not localize
    reg.CreateKey('\AppEvents\Schemes\Apps\MobileAgent\MEDisconnected'); // do not localize
    reg.CreateKey('\AppEvents\Schemes\Apps\MobileAgent\Alarm'); // do not localize
  finally
    reg.Free;
  end;
end;

end.
