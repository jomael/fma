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
procedure CleanupRegistry;

implementation

uses Windows, Registry;

procedure CleanupRegistry;
begin
  with TRegistry.Create do
  try
    RootKey := HKEY_CURRENT_USER;
    DeleteKey('\AppEvents\Schemes\Apps\MobileAgent'); // do not localize
    DeleteKey('\Software\floAt'); // do not localize

    RootKey := HKEY_LOCAL_MACHINE;
    DeleteKey('\SOFTWARE\Classes\AppID\floAtMediaCtrl.exe'); // do not localize
    DeleteKey('\SOFTWARE\Classes\floAtMediaCtrl.MouseCtrl'); // do not localize
    DeleteKey('\SOFTWARE\Classes\floAtMediaCtrl.VolumeCtrl'); // do not localize
    
    RootKey := HKEY_CLASSES_ROOT;
    DeleteKey('\AppID\floAtMediaCtrl.exe'); // do not localize
    DeleteKey('\floAtMediaCtrl.MouseCtrl'); // do not localize
    DeleteKey('\floAtMediaCtrl.VolumeCtrl'); // do not localize
  finally
    Free;
  end;
end;

procedure InitRegistry;
begin
  with TRegistry.Create do
  try
    RootKey := HKEY_CURRENT_USER;
    OpenKey('\AppEvents\EventLabels\SMSReceived', True); // do not localize
    try
      WriteString('', 'SMS Received'); // do not localize
    finally
      CloseKey;
    end;
    OpenKey('\AppEvents\EventLabels\SMSSent', True); // do not localize
    try
      WriteString('', 'SMS Sent'); // do not localize
    finally
      CloseKey;
    end;
    OpenKey('\AppEvents\EventLabels\Calling', True); // do not localize
    try
      WriteString('', 'Calling Contact'); // do not localize
    finally
      CloseKey;
    end;
    OpenKey('\AppEvents\EventLabels\CallReceived', True); // do not localize
    try
      WriteString('', 'Call Received'); // do not localize
    finally
      CloseKey;
    end;
    OpenKey('\AppEvents\EventLabels\MEConnected', True); // do not localize
    try
      WriteString('', 'Connected to Mobile Equipment'); // do not localize
    finally
      CloseKey;
    end;
    OpenKey('\AppEvents\EventLabels\MEDisconnected', True); // do not localize
    try
      WriteString('', 'Disconnected from Mobile Equipment'); // do not localize
    finally
      CloseKey;
    end;
    OpenKey('\AppEvents\EventLabels\Away', True); // do not localize
    try
      WriteString('', 'Proximity Away'); // do not localize
    finally
      CloseKey;
    end;
    OpenKey('\AppEvents\EventLabels\Near', True); // do not localize
    try
      WriteString('', 'Proximity Near'); // do not localize
    finally
      CloseKey;
    end;
    OpenKey('\AppEvents\EventLabels\Alarm', True); // do not localize
    try
      WriteString('', 'Alarm Activated'); // do not localize
    finally
      CloseKey;
    end;
    OpenKey('\AppEvents\Schemes\Apps\MobileAgent', True); // do not localize
    try
      WriteString('', 'floAt''s Mobile Agent'); // do not localize
    finally
      CloseKey;
    end;
    CreateKey('\AppEvents\Schemes\Apps\MobileAgent\Calling'); // do not localize
    CreateKey('\AppEvents\Schemes\Apps\MobileAgent\CallReceived'); // do not localize
    CreateKey('\AppEvents\Schemes\Apps\MobileAgent\SMSReceived'); // do not localize
    CreateKey('\AppEvents\Schemes\Apps\MobileAgent\SMSSent'); // do not localize
    CreateKey('\AppEvents\Schemes\Apps\MobileAgent\Away'); // do not localize
    CreateKey('\AppEvents\Schemes\Apps\MobileAgent\Near'); // do not localize
    CreateKey('\AppEvents\Schemes\Apps\MobileAgent\MEConnected'); // do not localize
    CreateKey('\AppEvents\Schemes\Apps\MobileAgent\MEDisconnected'); // do not localize
    CreateKey('\AppEvents\Schemes\Apps\MobileAgent\Alarm'); // do not localize
  finally
    Free;
  end;
end;

end.
