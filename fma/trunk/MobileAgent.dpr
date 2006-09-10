program MobileAgent;

uses
  gnugettext in 'gnugettext.pas',
  gginitialize in 'gginitialize.pas',
  gginitialize2 in 'gginitialize2.pas',
  Graphics,
  TntSystem,
  Windows,
  TntWindows,
  Forms,
  TntForms,
  SysUtils,
  TntSysUtils,
  WebUpdate,
  Unit1 in 'Unit1.pas' {Form1},
  uComposeSMS in 'uComposeSMS.pas' {frmMessageContact},
  uCalling in 'uCalling.pas' {frmCalling},
  uAbout in 'uAbout.pas' {frmAbout},
  uOptions in 'uOptions.pas' {frmOptions},
  uNewMessage in 'uNewMessage.pas' {frmNewMessage},
  MobileAgent_TLB in 'MobileAgent_TLB.pas',
  uMobileAgentUI in 'uMobileAgentUI.pas' {MobileAgent: CoClass},
  uSMSDetail in 'uSMSDetail.pas' {frmDetail},
  uObex in 'uObex.pas',
  uPostNote in 'uPostNote.pas' {frmNote},
  uAccessoriesMenu in 'uAccessoriesMenu.pas' {AccessoriesMenu: CoClass},
  uMEEdit in 'uMEEdit.pas' {frmContactsMEEdit: TTntFrame},
  uMsgView in 'uMsgView.pas' {frmMsgView: TTntFrame},
  uGlobal in 'uGlobal.pas',
  uInfoView in 'uInfoView.pas' {frmInfoView: TTntFrame},
  uEditContact in 'uEditContact.pas' {frmEditContact},
  uVCard in 'uVCard.pas',
  uSyncPhonebook in 'uSyncPhonebook.pas' {frmSync: TTntFrame},
  uPromptConflict in 'uPromptConflict.pas' {frmPromptConflict},
  uMissedCalls in 'uMissedCalls.pas' {frmMissedCalls},
  uKeyPad in 'uKeyPad.pas' {frmKeyPad},
  uPostURL in 'uPostURL.pas' {frmBookmark},
  uConnProgress in 'uConnProgress.pas' {frmConnect},
  uSelectContact in 'uSelectContact.pas' {frmSelContact},
  uEditProfile in 'uEditProfile.pas' {frmEditProfile},
  uExploreView in 'uExploreView.pas' {frmExplore: TTntFrame},
  uFolderProps in 'uFolderProps.pas' {frmFolderProps},
  uVersion in 'uVersion.pas',
  uStatusDlg in 'uStatusDlg.pas' {frmStatusDlg},
  uWaitComplete in 'uWaitComplete.pas',
  uAddToGroup in 'uAddToGroup.pas' {frmAddToGroup},
  uOfflineProfile in 'uOfflineProfile.pas' {frmOfflineProfile},
  uScriptEditor in 'uScriptEditor.pas' {frmEditor: TTntFrame},
  uOrganizeFavs in 'uOrganizeFavs.pas' {frmOrganizeFavs},
  uXMLContactSync in 'uXMLContactSync.pas',
  uContactSync in 'uContactSync.pas',
  uFMASync in 'uFMASync.pas',
  uOutlookSync in 'uOutlookSync.pas',
  uChooseLink in 'uChooseLink.pas' {frmChooseLink},
  uChatSMS in 'uChatSMS.pas' {frmCharMessage},
  uCrash in 'uCrash.pas' {ExceptionDialog},
  uGetContact in 'uGetContact.pas' {frmGetContact},
  uCallContact in 'uCallContact.pas' {frmCallContact},
  uAddToPhonebook in 'uAddToPhonebook.pas' {frmAddContact},
  uVBase in 'uVBase.pas',
  uVCalendar in 'uVCalendar.pas',
  uSyncCalendar in 'uSyncCalendar.pas' {frmCalendarView: TTntFrame},
  uVpVDB in 'uVpVDB.pas',
  uEditTask in 'uEditTask.pas' {frmEditTask},
  uEditEvent in 'uEditEvent.pas' {frmEditEvent},
  uInputQuery in 'uInputQuery.pas' {frmInputQuery},
  uSplash in 'uSplash.pas' {frmSplash},
  uSyncBookmarks in 'uSyncBookmarks.pas' {frmSyncBookmarks},
  gnugettexthelpers in 'gnugettexthelpers.pas',
  uDialogs in 'uDialogs.pas',
  uLogObserver in 'uLogObserver.pas',
  uLogger in 'uLogger.pas',
  uLogWriters in 'uLogWriters.pas',
  uLog in 'uLog.pas' {frmLog: TTntForm},
  uNewDeviceWizard in 'uNewDeviceWizard.pas' {frmNewDeviceWizard: TTntForm},
  uThreadSafe in 'uThreadSafe.pas',
  uLogDetails in 'uLogDetails.pas' {frmLogDetails},
  uSMS in 'uSMS.pas',
  uFiles in 'uFiles.pas',
  uConflictChanges in 'uConflictChanges.pas' {frmConflictChanges},
  uSIMEdit in 'uSIMEdit.pas' {frmContactsSMEdit: TTntFrame},
  uWelcome in 'uWelcome.pas' {frmWelcomeTips},
  uBrowseFolders in 'uBrowseFolders.pas' {frmBrowseFolders},
  uDeliveryRule in 'uDeliveryRule.pas' {frmSMSRule},
  uOptionsPage in 'uOptionsPage.pas' {frmOptionsPage},
  uNewAlarm in 'uNewAlarm.pas' {frmNewAlarm},
  uPassword in 'uPassword.pas' {frmPassword},
  uImg32Helper in 'uImg32Helper.pas';

{$R *.TLB}

{$R *.res}

begin
  SetDefaultFont;
  Application.Initialize;
  with TntApplication do Title := _('floAt''s Mobile Agent');
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmMessageContact, frmMessageContact);
  Application.CreateForm(TfrmCalling, frmCalling);
  Application.CreateForm(TfrmNote, frmNote);
  Application.CreateForm(TfrmEditProfile, frmEditProfile);
  Application.CreateForm(TfrmPromptConflict, frmPromptConflict);
  Application.CreateForm(TfrmMissedCalls, frmMissedCalls);
  Application.CreateForm(TfrmKeyPad, frmKeyPad);
  Application.CreateForm(TfrmCallContact, frmCallContact);
  Application.CreateForm(TfrmWelcomeTips, frmWelcomeTips);
  Application.CreateForm(TfrmNewAlarm, frmNewAlarm);
  with Application do Form1.StartupInitialize; // Run this when all forms are created
  Application.Run;
  gghWorkaroundMidleEastApplicationExit(Form1); //TODO: Remove this workaround
end.

