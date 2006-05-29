unit gginitialize2;

interface

implementation

uses
  gnugettext,
  TntSystem,
  SysUtils, ActnList, TntActnList, Controls, TntControls,
  ExtCtrls, TntExtCtrls, Graphics, TntGraphics,
  ComCtrls, TntComCtrls,
  Placemnt, CPort, WBluetoothSocket, WIrCOMMSocket, WebUpdate,
  aw_SCtrl;

type
  TGlobalHandleClassHelper = class
    class procedure HandleTreeView(Obj: TObject);
  end;

  THackCustomTreeView = class(TCustomTreeView);
  THackTntCustomTreeView = class(TTntCustomTreeView);

class procedure TGlobalHandleClassHelper.HandleTreeView(Obj: TObject);
var
  N: TTreeNode;
  T: THackCustomTreeView;
  TntN: TTntTreeNode;
  TntT: THackTntCustomTreeView;
begin
  if Obj is TTntCustomTreeView then
    begin
      TntT := THackTntCustomTreeView(Obj);
      TntN := TntT.Items.GetFirstNode;
      while TntN <> nil do
        begin
          TntN.Text := _(TntN.Text);
          TntN := TntN.GetNext;
        end;
    end
  else
    begin
      T := THackCustomTreeView(Obj);
      N := T.Items.GetFirstNode;
      while N <> nil do
        begin
          N.Text := _(N.Text);
          N := N.GetNext;
        end;
    end;
end;

initialization
  /// Tnt Updates
  InstallTntSystemUpdates;

  /// Update SysLocale
  SysLocale.MiddleEast := (_('FlipFlag') <> 'FlipFlag') or (DefaultInstance.GetTranslationProperty('X-FLIPFLAG') <> ''); // set to '1' if language is right-to-left

  /// GG: Additional text translation domains
  DefaultInstance.BindTextDomainToFile('languagecodes', 'locale' + PathDelim + 'languagecodes.mo'); // do not localize

  /// GG: Ignore component Classes, TntClasses, properties, ...
  // VCL
  TP_GlobalIgnoreClassProperty(TTntAction, 'Category'); // do not localize
  TP_GlobalIgnoreClassProperty(TControl, 'HelpKeyword'); // do not localize
  TP_GlobalIgnoreClassProperty(TNotebook, 'Pages'); // do not localize
  // VCL
  TP_GlobalIgnoreClassProperty(TControl, 'ImeName'); // do not localize
  TP_GlobalIgnoreClass(TFont);
  // RX
  TP_GlobalIgnoreClass(TFormStorage);
  // ComPort
  TP_GlobalIgnoreClass(TComPort);
  // WBluetoothSocket
  TP_GlobalIgnoreClass(TWBluetoothSocket);
  // WIrCOMMSocket
  TP_GlobalIgnoreClass(TWIrCOMMSocket);
  // WebUpdate
  TP_GlobalIgnoreClassProperty(TFmaWebUpdate, 'AppName'); // do not localize
  TP_GlobalIgnoreClassProperty(TFmaWebUpdate, 'SupportURL'); // do not localize
  TP_GlobalIgnoreClassProperty(TFmaWebUpdate, 'UpdatesURL'); // do not localize
  // awScriptControl
  TP_GlobalIgnoreClass(TawScriptControl);
  // TTntRadioGroup
  TP_GlobalIgnoreClassProperty(TTntRadioGroup, 'Items'); // do not localize

  // GG: Handle special Classes, TntClasses
  // TCustomTreeView
  TP_GlobalHandleClass(TCustomTreeView, TGlobalHandleClassHelper.HandleTreeView);
end.

