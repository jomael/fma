////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// Project:	VCL cmponents fr vewing and editing SE T61x Phones Theme          //
// Components:	TOKTThemeContainer, TOKTThemeViewer                           //
// Descriptions: The Container Class is non visual component this component   //
//               Contain all properties of Theme Files colors,images etc.     //
//               The Container class is support ETT(Extended Theme Tag).      //
//                                                                            //
//               The Viewer class is visual component linked with Container   //
//               Class, this component is sufficient fast themeViewer Class.  //
//               This component Show 30 diferent screen from SE T610 and      //
//               screenShot capability for each screen to Bitmap file         //
//               it use two language for menus and text(Turkish,English)      //
//               dynamicaly sense in container changing(colors,images)        //
//                                                                            //
//                                                                            //
//                                                                            //
// ToDo:        Support for other SE Phones soon                              //
//              Load language resources from external file or resources file  //
//                                                                            //
// Version:	1.0                                                               //
// Release:	1                                                                 //
// Date:	23.01.2004 (My Birth Day)                                           //
// Platform:	Win32 (Tested on WinXP and WinME)                               //
// Dev.Env.:    Borland Delphi 6 Enterprise (Built 6.163)                     //
// Author:	Oktay Kocatürk  E.Mail: oktaykocaturk@gmx.com.tr                  //
// Copyright:	(c) 2003-2004 OktayKocatürk.                                    //
//		All rights reserved.                                                    //
// Requirements: TGifImage of Anders Melander.                                //
//               LibTar of Stefan Heymann.                                    //
//               ABBREVIA of TurboPower Software                              //
//                                                                            //
//              to get EDesktop Source code opinion. :) Thanks                //
//                                                                            //
//                                                                            //
//   if you change any part of the source code please tell me !!!             //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

unit OKTThemeEngine;

interface

uses
  Consts, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PngImage, GifImage, ExtCtrls, LibTar;

type
  TOKTPreview = (pvNone, pvContactName, pvContactHome, pvContactMobile,
    pvContactWork, pvContactMail, pvSetTime, pvSetRingLevel, pvCallContact,
    pvForwardSMS, pvNewSMS, pvNewNote, pvFindContact, pvWapBrowser, pvNotes,
    pvCalendarWeek, pvCalendarMonth, pvSoftKeysDisable, pvSoftKeysEnable,
    pvPopupSelected, pvPopUpDisableSelected, pvSMSSended, pvShowPicture,
    pvSendSMS, pvMenuSelected, pvMenuDisableSelected, pvCallsList, pvMySounds,
    pvDesktop, pvStandby, pvSilentMode);

type
  TThemeLanguage = (lngTurkish, lngEnglish);

type

  TOKTThemeContainer = class; { Main Container Class }

  TThemeChangeLink = class(TObject) { Change Link between Container and Viewer }
  private
    FSender: TOKTThemeContainer;
    FOnChange: TNotifyEvent;
  public
    destructor Destroy; override;
    procedure Change; dynamic;

    property Sender: TOKTThemeContainer read FSender write FSender;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;

  end;

  TCustomThemeViewer = class(TGraphicControl) { Main Theme Viewer Class }
  private
    FPicture: TPicture;
    FCenter: Boolean;
    FDrawing: Boolean;

    function GetCanvas: TCanvas;
    procedure PictureChanged(Sender: TObject);
    procedure SetCenter(Value: Boolean);
    procedure SetPicture(Value: TPicture);

  protected
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    function DestRect: TRect;
    function DoPaletteChange: Boolean;
    function GetPalette: HPALETTE; override;
    procedure Paint; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Canvas: TCanvas read GetCanvas;

  published
    property Center: Boolean read FCenter write SetCenter default False;
    property Enabled;
    property Picture: TPicture read FPicture write SetPicture;
    property PopupMenu;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;

  end;

  TOKTThemeContainer = class(TComponent) { Theme Container Class }
  private
    FClients: TList;
    FXmlFile: string;
    fPhoneModel: string;
    fThemeName: string;
    fThemeCreator: string;
    fModifiedBy: string;
    fThemeCreatedTime: string;
    fThemeFiles: TStringList;
    fStatusBarImageSrc: string;
    fWallpaperImageSrc: string;
    fDesktopImageSrc: string;
    fMenuImageSrc: string;
    fMenuTitleImageSrc: string;
    fMenuHighlightImageSrc: string;
    fPopUpTitleImageSrc: string;
    fPopUpHighLightImageSrc: string;
    fSoftKeysImageSrc: string;
    fStatusBarImage: TPicture; { 128 x 14 Pixel }
    fWallpaperImage: TPicture; { 128 x 127 Pixel }
    fDesktopImage: TPicture; { 128 x 127 Pixel }
    fMenuImage: TPicture; { 128 x 104 Pixel }
    fMenuTitleImage: TPicture; { 128 x 23 Pixel }
    fMenuHighlightImage: TPicture; { 123 x 16 Pixel }
    fPopUpTitleImage: TPicture; { 118 x 23 Pixel }
    fPopUpHighLightImage: TPicture; { 113 x 16 Pixel }
    fSoftKeysImage: TPicture; { 128 x 19 Pixel }
    fOperatorTextColor: TColor;
    fOperatorOutLineColor: TColor;
    fTimeTextColor: TColor;
    fTimeOutlineColor: TColor;
    fDesktopBGColor: TColor;
    fDesktopTitleColor: TColor;
    fDesktopTitleOutlineColor: TColor;
    fNotesBGColor: TColor;
    fNotesTextColor: TColor;
    fMenuBGColor: TColor;
    fHighlightColor: TColor;
    fHighlightTextColor: TColor;
    fHighlightDisabledColor: TColor;
    fMenuTextColor: TColor;
    fMenuDisabledTextColor: TColor;
    fMenuPromptColor: TColor;
    fMenuCursorColor: TColor;
    fMenuTitleBGColor: TColor;
    fMenuTitleTextColor: TColor;
    fMenuTitleShadowColor: TColor;
    fMenuScrollBarColor: TColor;
    fMenuScrollBarBGColor: TColor;
    fPopUpTitleBGColor: TColor;
    fPopUpTitleTextColor: TColor;
    fPopUpTitleShadowColor: TColor;
    fPopUpMenuBGColor: TColor;
    fPopUpMenuTextColor: TColor;
    fPopUpMenuDisabledTextColor: TColor;
    fPopUpMenuPromptColor: TColor;
    fPopUpMenuCursorColor: TColor;
    fPopUpMenuHighlightColor: TColor;
    fPopUpMenuHighlightTextColor: TColor;
    fPopUpMenuHighlightDisabledTextColor: TColor;
    fPopUpFrameColor: TColor;
    fPopUpFrameShadowColor: TColor;
    fPopUpScrollBarColor: TColor;
    fPopUpScrollBarBGColor: TColor;
    fCalendarWeekendColor: TColor;
    fCalendarHighlightColor: TColor;
    fCalendarHighlightTextColor: TColor;
    fWAPBrowserUnderLineColor: TColor;
    fWAPBrowserTableBorderColor: TColor;
    fSoftKeysBGColor: TColor;
    fSoftkeysTextColor: TColor;
    fSoftkeysTextShadowColor: TColor;
    fSoftKeysDisabledTextColor: TColor;
    fSoftkeysDisabledTextShadowColor: TColor;
    fSoftKeysBGActivatedColor: TColor;

  protected

    function GetTempDir: string;
    procedure SetStatusBarImage(Value: TPicture);
    procedure SetWallpaperImage(Value: TPicture);
    procedure SetDesktopImage(Value: TPicture);
    procedure SetMenuImage(Value: TPicture);
    procedure SetMenuTitleImage(Value: TPicture);
    procedure SetMenuHighLightImage(Value: TPicture);
    procedure SetPopUpTitleImage(Value: TPicture);
    procedure SetPopUpHighLightImage(Value: TPicture);
    procedure SetSoftKeysImage(Value: TPicture);
    procedure SetBackground(Value: TColor);
    procedure SetOperatorColor(Value: TColor);
    procedure SetOperatorOutline(Value: TColor);
    procedure SetTimeColor(Value: TColor);
    procedure SetTimeOutline(Value: TColor);
    procedure SetDesktopColor(Value: TColor);
    procedure SetDesktopTitle(Value: TColor);
    procedure SetDesktopOutline(Value: TColor);
    procedure SetNotesBackground(Value: TColor);
    procedure SetNotesTextColor(Value: TColor);
    procedure SetPopupFrame(Value: TColor);
    procedure SetPopupShadow(Value: TColor);
    procedure SetTitleColor(Value: TColor);
    procedure SetTitleTextColor(Value: TColor);
    procedure SetTitleTextShadow(Value: TColor);
    procedure SetHighLightColor(Value: TColor);
    procedure SetHighLightTextColor(Value: TColor);
    procedure SetHighLightDisabled(Value: TColor);
    procedure SetTextColor(Value: TColor);
    procedure SetDisabledTextColor(Value: TColor);
    procedure SetPromptColor(Value: TColor);
    procedure SetCursorColor(Value: TColor);
    procedure SetScrollBarColor(Value: TColor);
    procedure SetScrollBarFrameColor(Value: TColor);
    procedure SetPopupTitleColor(Value: TColor);
    procedure SetPopupTitleTextColor(Value: TColor);
    procedure SetPopupTitleTextShadowColor(Value: TColor);
    procedure SetPopupBackgroundColor(Value: TColor);
    procedure SetPopupTextColor(Value: TColor);
    procedure SetPopupDisabledTextColor(Value: TColor);
    procedure SetPopupPromptColor(Value: TColor);
    procedure SetPopupCursorColor(Value: TColor);
    procedure SetPopupHighlightColor(Value: TColor);
    procedure SetPopupHighlightTextColor(Value: TColor);
    procedure SetPopupHighlightDisabledTextColor(Value: TColor);
    procedure SetPopUpScrollBar(Value: TColor);
    procedure SetPopUpScrollBarFrame(Value: TColor);
    procedure SetCalendarWeekendTextColor(Value: TColor);
    procedure SetCalendarHighLightColor(Value: TColor);
    procedure SetCalendarHighLightTextColor(Value: TColor);
    procedure SetWAPUnderlineColor(Value: TColor);
    procedure SetWAPTableborderColor(Value: TColor);
    procedure SetSoftKeysBackgroundColor(Value: TColor);
    procedure SetSoftkeysTextColor(Value: TColor);
    procedure SetSoftkeysTextShadowColor(Value: TColor);
    procedure SetSoftKeysDisabledTextColor(Value: TColor);
    procedure SetSoftkeysDisabledTextShadowColor(Value: TColor);
    procedure SetSoftKeysBackGroundActivatedColor(Value: TColor);
    procedure ParseThemeXML(FileName: string);
    procedure Change;

  public
    procedure LoadStatusBar(FileName: string);
    procedure LoadWallpaper(FileName: string);
    procedure LoadDesktop(FileName: string);
    procedure LoadMenu(FileName: string);
    procedure LoadMenutitle(FileName: string);
    procedure LoadMenuHighLight(FileName: string);
    procedure LoadPopUpTitle(FileName: string);
    procedure LoadPopUpHighLight(FileName: string);
    procedure LoadSoftKeys(FileName: string);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure OpenTheme(FileName: string);
    procedure SaveTheme(FileName: string);
    procedure CloseTheme;
    procedure Clear;
    procedure SaveXML(FileName: string);
    procedure RegisterChanges(aValue: TThemeChangeLink);
    procedure UnRegisterChanges(aValue: TThemeChangeLink);

  published
    property ThemeName: string read fThemeName write fThemeName;
    property PhoneModel: string read fPhoneModel write fPhoneModel;
    property ThemeCreator: string read fThemeCreator write fThemeCreator;
    property ThemeCreatedTime: string read fThemeCreatedTime write fThemeCreatedTime;
    property ModifiedBy: string read fModifiedBy write fModifiedBy;
    property StatusBarImage: TPicture read fStatusBarImage write setStatusBarImage;
    property WallpaperImage: TPicture read fWallpaperImage write setWallpaperImage;
    property DesktopImage: TPicture read fDesktopImage write setDesktopImage;
    property MenuImage: TPicture read fMenuImage write setMenuImage;
    property MenuTitleImage: TPicture read fMenuTitleImage write setMenuTitleImage;
    property MenuHighlightImage: TPicture read fMenuHighLightImage write setMenuHighLightImage;
    property PopUpTitleImage: TPicture read fPopUpTitleImage write setPopUpTitleImage;
    property PopUpHighLightImage: TPicture read fPopUpHighLightImage write setPopUpHighLightImage;
    property SoftKeysImage: TPicture read fSoftKeysImage write setSoftKeysImage;
    property OperatorTextColor: TColor read fOperatorTextColor write SetOperatorColor;
    property OperatorTextOutlineColor: TColor read fOperatorOutLineColor write SetOperatorOutline;
    property TimeTextColor: TColor read fTimeTextColor write SetTimeColor;
    property TimeTextOutlineColor: TColor read fTimeOutlineColor write SetTimeOutline;
    property DesktopBackGroundColor: TColor read fDesktopBGColor write SetDesktopColor;
    property DesktopTitleColor: TColor read fDesktopTitleColor write SetDesktopTitle;
    property DesktopTitleOutlineColor: TColor read fDesktopTitleOutlineColor write SetDesktopOutline;
    property NotesBackgroundColor: TColor read fNotesBGColor write SetNotesBackground;
    property NotesTextColor: TColor read fNotesTextColor write SetNotesTextColor;
    property PopupTitleBackGroundColor: TColor read fPopUpTitleBGColor write SetPopupTitleColor;
    property PopupTitleTextColor: TColor read fPopUpTitleTextColor write SetPopupTitleTextColor;
    property PopupTitleTextShadowColor: TColor read fPopUpTitleShadowColor write SetPopupTitleTextShadowColor;
    property PopupMenuBackgroundColor: TColor read fPopUpMenuBGColor write SetPopupBackgroundColor;
    property PopupMenuTextColor: TColor read fPopUpMenuTextColor write SetPopupTextColor;
    property PopupMenuTextDisabledColor: TColor read fPopUpMenuDisabledTextColor write SetPopupDisabledTextColor;
    property PopupMenuPromptColor: TColor read fPopUpMenuPromptColor write SetPopupPromptColor;
    property PopupMenuCursorColor: TColor read fPopUpMenuCursorColor write SetPopupCursorColor;
    property PopupHighlightColor: TColor read fPopUpMenuHighlightColor write SetPopupHighlightColor;
    property PopupHighlightTextColor: TColor read fPopUpMenuHighlightTextColor write SetPopupHighlightTextColor;
    property PopupHighlightTextDisabledColor: TColor read fPopUpMenuHighlightDisabledTextColor write SetPopupHighlightDisabledTextColor;
    property PopupFrameColor: TColor read fPopUpFrameColor write SetPopupFrame;
    property PopupFrameShadowColor: TColor read fPopUpFrameShadowColor write SetPopupShadow;
    property PopupScrollBarBarColor: TColor read fPopUpScrollBarColor write SetPopUpScrollBar;
    property PopupScrollBarFrameColor: TColor read fPopUpScrollBarBGColor write SetPopupScrollBarFrame;
    property MenuTitleColor: TColor read fMenuTitleBGColor write SetTitleColor;
    property MenuTitleTextColor: TColor read fMenuTitleTextColor write SetTitleTextColor;
    property MenuTitleTextShadowColor: TColor read fMenuTitleShadowColor write SetTitleTextShadow;
    property MenuBackGroundColor: TColor read fMenuBGColor write SetBackground;
    property MenuTextColor: TColor read fMenuTextColor write SetTextColor;
    property MenuTextDisabledColor: TColor read fMenuDisabledTextColor write SetDisabledTextColor;
    property MenuPromptColor: TColor read fMenuPromptColor write SetPromptColor;
    property MenuCursorColor: TColor read fMenuCursorColor write SetCursorColor;
    property MenuHighlightColor: TColor read fHighlightColor write SetHighlightColor;
    property MenuHighlightTextColor: TColor read fHighlightTextColor write SetHighlightTextColor;
    property MenuHighlightTextDisabledColor: TColor read fHighlightDisabledColor write SetHighlightDisabled;
    property MenuScrollBarBarColor: TColor read fMenuScrollBarColor write SetScrollBarColor;
    property MenuScrollBarFrameColor: TColor read fMenuScrollBarBGColor write SetScrollBarFrameColor;
    property CalendarWeekendColor: TColor read fCalendarWeekendColor write SetCalendarWeekendTextColor;
    property CalendarHighLightColor: TColor read fCalendarHighlightColor write SetCalendarHighLightColor;
    property CalendarHighlightTextColor: TColor read fCalendarHighlightTextColor write SetCalendarHighlightTextColor;
    property WAPUnderlineColor: TColor read fWAPBrowserUnderLineColor write SetWAPUnderlineColor;
    property WAPTableborderColor: TColor read fWAPBrowserTableBorderColor write SetWAPTableborderColor;
    property SoftKeysBackgroundColor: TColor read fSoftKeysBGColor write SetSoftKeysBackgroundColor;
    property SoftkeysTextColor: TColor read fSoftkeysTextColor write SetSoftkeysTextColor;
    property SoftkeysTextShadowColor: TColor read fSoftkeysTextShadowColor write SetSoftkeysTextShadowColor;
    property SoftKeysTextDisabledColor: TColor read fSoftkeysDisabledTextColor write SetSoftkeysDisabledTextColor;
    property SoftkeysTextDisabledShadowColor: TColor read fSoftkeysDisabledTextShadowColor write SetSoftkeysDisabledTextShadowColor;
    property SoftKeysBackGroundActivatedColor: TColor read fSoftKeysBGActivatedColor write SetSoftKeysBackGroundActivatedColor;
    property StatusBarImageSrc: string read fStatusBarImageSrc write fStatusBarImageSrc;
    property WallpaperImageSrc: string read fWallpaperImageSrc write fWallpaperImageSrc;
    property DesktopImageSrc: string read fDesktopImageSrc write fDesktopImageSrc;
    property MenuImageSrc: string read fMenuImageSrc write fMenuImageSrc;
    property MenuTitleImageSrc: string read fMenuTitleImageSrc write fMenuTitleImageSrc;
    property MenuHighlightImageSrc: string read fMenuHighlightImageSrc write fMenuHighlightImageSrc;
    property PopUpTitleImageSrc: string read fPopUpTitleImageSrc write fPopUpTitleImageSrc;
    property PopUpHighLightImageSrc: string read fPopUpHighLightImageSrc write fPopUpHighLightImageSrc;
    property SoftKeysImageSrc: string read fSoftKeysImageSrc write fSoftKeysImageSrc;
    property ThemeFiles: TStringList read fThemeFiles;
    property XMLFile: string read fXMLFile write fXMLFile;
  end;

  TOKTThemeViewer = class(TCustomPanel) { Theme Viewer Class }
  private
    fViewer: TCustomThemeViewer;
    fContainer: TOKTThemeContainer;
    FContainerLink: TThemeChangeLink;
    fImagesVisible: Boolean;
    fPreview: TOKTPreview;
    fLanguage: TThemeLanguage;
    fOperatorName: string;

    fScreenBitmap: TBitmap;

    FThemeOnClick,
      FThemeOnDblClick: TNotifyEvent;
    FThemeOnMouseDown,
      FThemeOnMouseUp: TMouseEvent;
    FThemeOnMouseMove: TMouseMoveEvent;

    strCalls: string;
    strMissedCalls: string;
    strDivertCalls: string;
    strManageCalls: string;
    strTimeAndCost: string;
    strNextCall: string;
    strCall: string;
    strCallList: string;
    strInfo: string;
    strMore: string;
    strOK: string;
    strCancel: string;
    strYes: string;
    strNo: string;
    strAccept: string;
    strSave: string;
    strSelect: string;
    strSMS: string;
    strWriteNew: string;
    strInBox: string;
    strSIMArchive: string;
    strUnSentItems: string;
    strTemplates: string;
    strSentItems: string;
    strSendingMsg: string;
    strMsgSended: string;
    strMyMobile: string;
    strRead: string;
    strSetTime: string;
    strNumber: string;
    strLookUp: string;
    strForward: string;
    strContinue: string;
    strNote: string;
    strFindContact: string;
    strFind: string;
    strTcell: string;
    strMo: string;
    strTu: string;
    strWe: string;
    strTh: string;
    strFr: string;
    strSa: string;
    strSu: string;
    strContactInfo: string;
    strUncheck: string;
    strThemes: string;
    strSend: string;
    strDelete: string;
    strEdit: string;
    strRename: string;
    strThemeInf: string;
    strMemoryStat: string;
    strSE: string;
    strInternetServices: string;
    strMyShortCuts: string;
    strCamera: string;
    strMessaging: string;
    strEntertainment: string;
    strPicturesAndSounds: string;
    strPhonebook: string;
    strConnectivity: string;
    strOrganizer: string;
    strSettings: string;
    strMySounds: string;
    strSetAsringSignal: string;
    strPlay: string;
    strRing_1: string;
    strRing_2: string;
    strRing_3: string;
    strRing_4: string;
    strRing_5: string;
    strRing_6: string;
    strRingVolume: string;
    strContact_1: string;
    strContact_2: string;
    strContact_3: string;
    strContact_4: string;
    strContact_5: string;
    strContact_6: string;
    strContact_7: string;
    strContact_8: string;
    strContact_9: string;
    strContact_10: string;
    strContact_11: string;
    strWallpaper: string;
    strName: string;
    strHome: string;
    strWork: string;
    strMobile: string;
    strFax: string;
    strOther: string;
    strMail: string;
    strAddContact: string;
    strSymbols: string;
    strHHMM: string;

    procedure GetThemeChange(Sender: TObject);

  protected
    procedure SetPreView(Value: TOKTPreview);
    procedure SetOperator(Value: string);
    procedure SetThemeContainer(Container: TOKTThemeContainer);
    procedure SetLanguage(Language: TThemeLanguage);
    procedure SetImagesVisible(const Value: Boolean);
    function GetScreenshot: TBitmap;
    procedure InitializePreview;
    procedure InitUILanguage;
    procedure DrawBackGround(Canvas: TCanvas);
    procedure DrawStatusBar(Canvas: TCanvas);
    procedure DrawSoftKeys(Canvas: TCanvas; LeftText, RightText: string; Activated, Navigator, Disabled, RightVisible: Boolean);
    procedure WriteCalendarDays(Canvas: TCanvas; X, Y, Delta: Integer; Days: array of string; IsWeek: Boolean);
    procedure DrawMenu(Canvas: TCanvas; Title: string; HighLightIndex: Integer; MenuItems: array of string; MenuItemsDisabledIndex: Integer; MenuPromptColor: TColor; MenuCursorColor: TColor; Scrollbar: Boolean);
    procedure DrawMenuWithIcon(Icon_A_Name: string; Icon_a_Idx: Word; Icon_B_Name: string; Icon_B_Idx: Word; Canvas: TCanvas; Title: string; HighLightIndex: Integer; MenuItems: array of string; MenuItemsDisabledIndex: Integer; MenuPromptColor: TColor; MenuCursorColor: TColor);
    procedure DrawPopUpMenu(Canvas: TCanvas; Title: string; HighLightIndex: Integer; MenuItems: array of string; MenuItemsDisabledIndex: Integer; MenuPromptColor: TColor; MenuCursorColor: TColor);
    procedure DrawStandBy(Canvas: TCanvas; OpratorName: string);
    procedure DrawDesktop(Canvas: TCanvas; Titles: array of string);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ResizeCanvas(Sender: TObject);
    property OnResize;
    procedure ThemeClick(Sender: TObject); dynamic;
    procedure ThemeDblClick(Sender: TObject); dynamic;
    procedure ThemeMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); dynamic;
    procedure ThemeMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); dynamic;
    procedure ThemeMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer); dynamic;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    property ThemeContainer: TOKTThemeContainer read fContainer write SetThemeContainer;
    property ImagesVisible: Boolean read fImagesVisible write SetImagesVisible;
    property Preview: TOKTPreview read fpreview write SetPreView;
    property Language: TThemeLanguage read fLanguage write SetLanguage;
    property ScreenShot: TBitmap read GetScreenShot;
    property OperatorName: string read fOperatorName write SetOperator;
    property PopupMenu;
    property Visible;
    property Color;
    property ThemeOnClick: TNotifyEvent read FThemeOnClick write FThemeOnClick;
    property ThemeOnDblClick: TNotifyEvent read FThemeOnDblClick write FThemeOnDblClick;
    property ThemeOnMouseDown: TMouseEvent read FThemeOnMouseDown write FThemeOnMouseDown;
    property ThemeOnMouseUp: TMouseEvent read FThemeOnMouseUp write FThemeOnMouseUp;
    property ThemeOnMouseMove: TMouseMoveEvent read FThemeOnMouseMove write FThemeOnMouseMove;

  end;

procedure Register;

implementation

{$R themeT610.res}

uses DateUtils, AbUnzPrc, AbZipPrc, Calendar;

procedure Register;
begin
  RegisterComponents('FMA', [TOKTThemeContainer, TOKTThemeViewer]);
end;

function MatchStr(s, s1: string; var i, j: integer; ls, ls1: integer): boolean;

{ Returns true if s1 is found at position i in s. }
var
  k: integer;
begin
  j := i;
  k := 1;
  while (s[j] = s1[k]) and (j <= ls) and (k <= ls1) do
  begin
    inc(j);
    inc(k);
  end;
  Result := (k = ls1 + 1)
end;

function StrToThemeColor(HexColorStr: string): TColor;

var
  Red, Green, Blue: Integer;
  TmpStr: string;
begin
  TmpStr := Copy(HexColorStr, 3, Length(HexColorStr) - 2);
  Red := StrToIntDef('$' + Copy(TmpStr, 1, 2), 0);
  Green := StrToIntDef('$' + Copy(TmpStr, 3, 2), 0);
  Blue := StrToIntDef('$' + Copy(TmpStr, 5, 2), 0);
  Result := RGB(Red, Green, Blue);
end;

function ColorToThemeColor(Color: TColor): string;
begin
  Result := '0x' +
    IntToHex(GetRValue(Color), 2) +
    IntToHex(GetGValue(Color), 2) +
    IntToHex(GetBValue(Color), 2);
end;

function DelChars(Str: string; Chr: Char): string;
var
  i: integer;
  TmpStr: string;
begin
  TmpStr := '';
  for i := 1 to length(str) do
  begin
    if str[i] <> Chr then
      TmpStr := TmpStr + Str[i];
  end;
  result := tmpstr;
end;

function CleanXMLStr(aText: string): string;
const
  crlf = chr(13) + chr(10);
  tab = chr(9);
begin
  result := stringreplace(aText, crlf, ' ', [rfreplaceall]);
  result := stringreplace(result, tab, ' ', [rfreplaceall]);
  result := stringreplace(result, '/>', crlf, [rfreplaceall]);
  result := Delchars(result, '<');
  result := AnsiUpperCase(result);
end;

function ReplaceAllStr(s, s1, s2: string): string;

{ Replaces all occurences of s1 in s with s2. }

var
  i, j, ls, ls1: integer;
  c: string;
begin
  i := 1;
  ls := Length(s);
  ls1 := Length(s1);
  c := '';
  while (i <= ls) do
  begin
    if MatchStr(s, s1, i, j, ls, ls1) then
    begin
      c := c + s2;
      i := j;
    end
    else
    begin { no occurence ... }
      c := c + s[i];
      inc(i);
    end;
  end;
  Result := c;
end;

function SplitXMLStr(value, seperator: string; before: boolean; ForceEmpty: boolean = false): string;
var
  i: integer;
begin
  i := Pos(seperator, value);
  if i < 1 then
  begin
    if ForceEmpty then
      result := ''
    else
      result := value;
  end
  else
    if before then
      result := Copy(value, 1, i - 1)
    else
      result := Copy(value, i + Length(seperator), Length(value));
end;

function ParseXMLStr(XMLStr: string; Idx: Integer): string;
var
  TmpStr, Str: string;

begin
  case Idx of
    0:
      begin
        Tmpstr := AnsiUpperCase(SplitXMLStr(XMLStr, '<', false, true));
        str := SplitXMLStr(tmpStr, #32, True, true);
        if Length(str) = 0 then
          str := SplitXMLStr(tmpStr, #09, true, false);
        Result := Str;
      end;
    1:
      begin
        str := AnsiUpperCase(SplitXMLStr(XMLStr, '=', False, false));
        str := SplitXMLStr(str, '"', false, false);
        str := SplitXMLStr(str, '"', true, false);
        Result := Str;
      end;
  end;

end;

procedure InitXMLFile(InFileName, OutFileName: string);
var
  f1, f2: TextFile;
  tmpstr, str: string;
begin
  AssignFile(f1, InFileName);
  Assignfile(f2, OutFileName);
  Reset(f1);
  RewRite(f2);
  while not EOF(f1) do
  begin
    Readln(f1, tmpstr);
    Str := ReplaceAllStr(tmpstr, '>', '>' + #13#10);
    Writeln(f2, str)
  end;
  CloseFile(f1);
  CloseFile(f2);
end;

procedure LoadResGraph(Picture: TPicture; ResName: string);

var
  Stream: TStream;
  GIF: TGIFImage;
  UStrm: TMemoryStream;
  CStrm: TMemoryStream;
begin
  include(GIFImageDefaultDrawOptions, goDirectDraw);
  Stream := TResourceStream.Create(hInstance, ResName, 'SPECIAL');
  UStrm := TMemoryStream.Create;
  CStrm := TMemoryStream.Create;
  UStrm.Clear;
  Cstrm.Clear;
  Cstrm.LoadFromStream(Stream);
  CStrm.Position := 0;
  InflateStream(CStrm, UStrm);
  UStrm.Position := 0;
  try
    GIF := TGIFImage.Create;
    try
      GIF.LoadFromStream(ustrm);
      Picture.Assign(GIF);
    finally
      GIF.Free;
    end;
  finally
    Stream.Free;
    UStrm.Free;
    CStrm.Free;
  end;
end;

procedure WriteOutlinedText(Canvas: TCanvas; X, Y: Integer; Text: string; TextColor, ShadowColor: TColor; FontStyle: TFontStyles);
begin
  with Canvas do
  begin
    Brush.Style := bsClear;
    Font.Style := FontStyle;
    Font.Color := ShadowColor;
    TextOut(X - 1, (Y - 1) - Canvas.TextHeight(Text) div 2, Text);
    TextOut(X - 1, (Y + 1) - Canvas.TextHeight(Text) div 2, Text);
    TextOut(X + 1, (Y - 1) - Canvas.TextHeight(Text) div 2, Text);
    TextOut(X + 1, (Y + 1) - Canvas.TextHeight(Text) div 2, Text);
    TextOut(X + 1, Y - Canvas.TextHeight(Text) div 2, Text);
    TextOut(X - 1, Y - Canvas.TextHeight(Text) div 2, Text);

    Font.Color := TextColor;
    TextOut(X, Y - Canvas.TextHeight(Text) div 2, Text);
  end;
end;

procedure WriteText(Canvas: TCanvas; X, Y: Integer; Text: string; TextColor: TColor; FontStyle: TFontStyles; Alignment: TAlignment);
begin
  with Canvas do
  begin
    Brush.Style := bsClear;
    Font.Style := FontStyle;
    Font.Color := TextColor;
    case Alignment of
      taLeftJustify: TextOut(X, Y - TextHeight(Text) div 2, Text);
      taRightJustify: TextOut(X - TextWidth(Text), Y - TextHeight(Text) div 2, Text);
      taCenter: TextOut(X - TextWidth(Text) div 2, Y - TextHeight(Text) div 2, Text);
    end;
  end;

end;

procedure WriteShadowedText(Canvas: TCanvas; X, Y: Integer; Text: string; TextColor, ShadowColor: TColor; FontStyle: TFontStyles; Alignment: TAlignment);
begin
  with Canvas do
  begin
    Brush.Style := bsClear;
    Font.Style := FontStyle;
    case Alignment of
      taLeftJustify:
        begin
          Font.Color := ShadowColor;
          TextOut(X + 1, (Y + 1) - TextHeight(Text) div 2, Text);
          Font.Color := TextColor;
          TextOut(X, Y - TextHeight(Text) div 2, Text);
        end;
      taRightJustify:
        begin
          Font.Color := ShadowColor;
          TextOut((X + 1) - TextWidth(Text), (Y + 1) - TextHeight(Text) div 2, Text);
          Font.Color := TextColor;
          TextOut(X - TextWidth(Text), Y - TextHeight(Text) div 2, Text);
        end;
      taCenter:
        begin
          Font.Color := ShadowColor;
          TextOut((X + 1) - TextWidth(Text) div 2, (Y + 1) - TextHeight(Text) div 2, Text);
          Font.Color := TextColor;
          TextOut(X - TextWidth(Text) div 2, Y - TextHeight(Text) div 2, Text);
        end;
    end;
  end;
end;

procedure DrawShape(Canvas: TCanvas; Left, Top, Right, Bottom: Integer; ShapeColor: TColor);
begin
  with Canvas do
  begin
    Brush.Color := ShapeColor;
    FillRect(Rect(Left, Top, Right, Bottom));
  end;
end;

procedure DrawShadowedShape(Canvas: TCanvas; Left, Top, Right, Bottom: Integer; ShadowColor, FrameColor, FillColor: TColor);
begin
  with Canvas do
  begin
    Brush.Color := ShadowColor;
    FillRect(Rect(Left + 1, Top + 1, Right + 1, Bottom + 1));
    Brush.Color := FrameColor;
    FillRect(Rect(Left, Top, Right, Bottom));
    Brush.Color := FillColor;
    FillRect(Rect(Left + 1, Top + 1, Right - 1, Bottom - 1));
  end;
end;

procedure WriteUnderLinedText(Canvas: TCanvas; X, Y: integer; TextColor, UnderlineColor: TColor; Text: string; FontStyle: TFontStyles; Alignment: TAlignment);
begin
  with Canvas do
  begin
    Brush.Style := bsClear;
    Font.Style := FontStyle;
    Font.Color := TextColor;
    case Alignment of
      taLeftJustify:
        begin
          TextOut(X, Y - TextHeight(Text) div 2, Text);
          Pen.Color := UnderLineColor;
          MoveTo(X, Y + 7);
          LineTo(X + TextWidth(Text), Y + 7);
        end;
      taCenter:
        begin
          TextOut(X - TextWidth(Text) div 2, Y - TextHeight(Text) div 2, Text);
          Pen.Color := UnderLineColor;
          MoveTo(X - TextWidth(Text) div 2, Y + 7);
          LineTo(X + TextWidth(Text) div 2, Y + 7);
        end;
    end;
  end;
end;

destructor TOKTThemeContainer.Destroy;
begin
  while FClients.Count > 0 do
    UnRegisterChanges(TThemeChangeLink(FClients.Last));
  CloseTheme;
  fStatusBarImage.Free;
  fWallpaperImage.Free;
  fDesktopImage.Free;
  fMenuImage.Free;
  fMenuTitleImage.Free;
  fMenuHighlightImage.Free;
  fPopUpTitleImage.Free;
  fPopUpHighLightImage.Free;
  fSoftKeysImage.Free;
  fThemeFiles.Free;
  FClients.Free;
  inherited Destroy;
end;

constructor TOKTThemeContainer.Create;
begin
  inherited Create(aOwner);
  FClients := TList.Create;
  fThemeName := 'NoName';
  fPhoneModel := 'T61X';
  fThemeCreator := 'BigTurca';
  fModifiedBy := 'BigTurca';
  fThemeFiles := TStringList.Create;
  fStatusBarImage := TPicture.Create; // 128 x 14
  fWallpaperImage := TPicture.Create; // 128 x 127
  fDesktopImage := TPicture.Create; // 128 x 127
  fMenuImage := TPicture.Create; // 128 x 104
  fMenuTitleImage := TPicture.Create; // 128 x 23
  fMenuHighlightImage := TPicture.Create; // 123 x 16
  fPopUpTitleImage := TPicture.Create; // 118 x 23
  fPopUpHighLightImage := TPicture.Create; // 113 x 16
  fSoftKeysImage := TPicture.Create; // 128 x 19
  Clear;
end;

function TOKTThemeContainer.GetTempDir: string;
{$IFDEF WIN32}
var
  Buffer: array[0..1023] of Char;
begin
  SetString(Result, Buffer, GetTempPath(SizeOf(Buffer), Buffer));
{$ELSE}
var
  Buffer: array[0..255] of Char;
begin
  GetTempFileName(GetTempDrive(#0), '$', 1, Buffer);
  Result := ExtractFilePath(StrPas(Buffer));
{$ENDIF}
end;

procedure TOKTThemeContainer.SetStatusBarImage(Value: TPicture);
begin
  fStatusBarImage.Assign(Value);
  Change;
end;

procedure TOKTThemeContainer.SetWallpaperImage(Value: TPicture);
begin
  fWallpaperImage.Assign(Value);
  Change;
end;

procedure TOKTThemeContainer.SetDesktopImage(Value: TPicture);
begin
  fDesktopImage.Assign(Value);
  Change;
end;

procedure TOKTThemeContainer.SetMenuImage(Value: TPicture);
begin
  fMenuImage.Assign(Value);
  Change;
end;

procedure TOKTThemeContainer.SetMenuTitleImage(Value: TPicture);
begin
  fMenuTitleImage.Assign(Value);
  Change;
end;

procedure TOKTThemeContainer.SetMenuHighLightImage(Value: TPicture);
begin
  fMenuHighLightImage.Assign(Value);
  Change;
end;

procedure TOKTThemeContainer.SetPopUpTitleImage(Value: TPicture);
begin
  fPopUpTitleImage.Assign(Value);
  Change;
end;

procedure TOKTThemeContainer.SetPopUpHighLightImage(Value: TPicture);
begin
  fPopUpHighLightImage.Assign(Value);
  Change;
end;

procedure TOKTThemeContainer.SetSoftKeysImage(Value: TPicture);
begin
  fSoftKeysImage.Assign(Value);
  Change;
end;

procedure TOKTThemeContainer.SetOperatorColor(Value: TColor);
begin
  fOperatorTextColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetOperatorOutline(Value: TColor);
begin
  fOperatorOutLineColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetTimeColor(Value: TColor);
begin
  fTimeTextColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetTimeOutline(Value: TColor);
begin
  fTimeOutlineColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetDesktopColor(Value: TColor);
begin
  fDesktopBGColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetDesktopTitle(Value: TColor);
begin
  fDesktopTitleColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetDesktopOutline(Value: TColor);
begin
  fDesktopTitleOutlineColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetNotesBackground(Value: TColor);
begin
  fNotesBGColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetNotesTextColor(Value: TColor);
begin
  fNotesTextColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetPopupFrame(Value: TColor);
begin
  fPopUpFrameColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetPopupShadow(Value: TColor);
begin
  fPopUpFrameShadowColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetPopupScrollBar(Value: TColor);
begin
  fPopUpScrollBarColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetPopupScrollBarFrame(Value: TColor);
begin
  fPopUpScrollBarBGColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetBackground(Value: TColor);
begin
  fMenuBGColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetTitleColor(Value: TColor);
begin
  fMenuTitleBGColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetTitleTextColor(Value: TColor);
begin
  fMenuTitleTextColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetTitleTextShadow(Value: TColor);
begin
  fMenuTitleShadowColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetHighLightColor(Value: TColor);
begin
  fHighlightColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetHighLightTextColor(Value: TColor);
begin
  fHighlightTextColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetHighLightDisabled(Value: TColor);
begin
  fHighlightDisabledColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetTextColor(Value: TColor);
begin
  fMenuTextColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetDisabledTextColor(Value: TColor);
begin
  fMenuDisabledTextColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetPromptColor(Value: TColor);
begin
  fMenuPromptColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetCursorColor(Value: TColor);
begin
  fMenuCursorColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetScrollBarColor(Value: TColor);
begin
  fMenuScrollBarColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetScrollBarFrameColor(Value: TColor);
begin
  fMenuScrollBarBGColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetPopupTitleColor(Value: TColor);
begin
  fPopUpTitleBGColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetPopupTitleTextColor(Value: TColor);
begin
  fPopUpTitleTextColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetPopupTitleTextShadowColor(Value: TColor);
begin
  fPopUpTitleShadowColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetPopupBackgroundColor(Value: TColor);
begin
  fPopUpMenuBGColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetPopupTextColor(Value: TColor);
begin
  fPopUpMenuTextColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetCalendarWeekendTextColor(Value: TColor);
begin
  fCalendarWeekendColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetCalendarHighlightColor(Value: TColor);
begin
  fCalendarHighlightColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetCalendarHighlightTextColor(Value: TColor);
begin
  fCalendarHighlightTextColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetWAPUnderlineColor(Value: TColor);
begin
  fWAPBrowserUnderLineColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetWAPTableborderColor(Value: TColor);
begin
  fWAPBrowserTableBorderColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetSoftKeysBackgroundColor(Value: TColor);
begin
  fSoftKeysBGColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetSoftKeysTextColor(Value: TColor);
begin
  fSoftKeysTextColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetSoftKeysTextShadowColor(Value: TColor);
begin
  fSoftKeysTextShadowColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetSoftKeysDisabledTextColor(Value: TColor);
begin
  fSoftKeysdisabledTextColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetSoftKeysDisabledTextShadowColor(Value: TColor);
begin
  fSoftKeysdisabledTextShadowColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetSoftKeysBackGroundActivatedColor(Value: TColor);
begin
  fSoftKeysBGActivatedColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetPopupDisabledTextColor(Value: TColor);
begin
  fPopUpMenuDisabledTextColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetPopupPromptColor(Value: TColor);
begin
  fPopUpMenuPromptColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetPopupCursorColor(Value: TColor);
begin
  fPopUpMenuCursorColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetPopupHighlightColor(Value: TColor);
begin
  fPopUpMenuHighlightColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetPopupHighlightTextColor(Value: TColor);
begin
  fPopUpMenuHighlightTextColor := Value;
  Change;
end;

procedure TOKTThemeContainer.SetPopupHighlightDisabledTextColor(Value: TColor);
begin
  fPopUpMenuHighlightDisabledTextColor := Value;
  Change;
end;

procedure TOKTThemeContainer.OpenTheme(FileName: string);
var
  ThemeArchive: TTarArchive;
  DirRec: TTarDirRec;
begin
  fXMLfile := '';
  CloseTheme;
  fThemeFiles.Clear;
  try
    ThemeArchive := TTarArchive.Create(FileName);
  except
    exit;
  end;
  ThemeArchive.Reset;

  while ThemeArchive.FindNext(DirRec) do
  begin
    try
      ThemeArchive.ReadFile(GetTempDir + DirRec.Name);
    except
    end;
    fThemeFiles.Add(DirRec.Name);
    if (Pos('.XML', UpperCase(DirRec.Name)) > 0) then
      fXMLfile := DirRec.Name;
  end;
  ThemeArchive.Free;
  ParseThemeXML(GetTempDir + fXMLfile);
end;

procedure TOKTThemeContainer.SaveTheme(FileName: string);
var
  TarWriter: TTarWriter;
  FileCount: LongInt;
begin
  SaveXML(GetTempDir + fXMLFile);
  try
    TarWriter := TTarWriter.Create(FileName);
    TarWriter.AddFile(GetTempDir + fXMLFile, fXMLFile);
    for FileCount := 0 to fThemeFiles.Count - 1 do
    begin
      if (fThemeFiles.Strings[FileCount] <> fXMLFile) then
        TarWriter.AddFile(GetTempDir + fThemeFiles.Strings[FileCount], fThemeFiles.Strings[FileCount]);
    end;
    TarWriter.Free;
  except
  end;
end;

procedure TOKTThemeContainer.CloseTheme;
var
  Count: LongInt;
begin
  if (fThemeFiles.Count < 1) then
    Exit;
  for Count := 0 to fThemeFiles.Count - 1 do
  begin
    try
      DeleteFile(GetTempDir + fThemeFiles.Strings[Count]);
    except
    end;
  end;
  Clear;
end;

procedure TOKTThemeContainer.LoadStatusBar(FileName: string);
begin
  try
    fStatusBarImage.LoadFromFile(FileName);
    fStatusBarImageSrc := ExtractFileName(FileName);
    fThemeFiles.Add(FileName);
  except
  end;
  Change;
end;

procedure TOKTThemeContainer.LoadWallpaper(FileName: string);
begin
  try
    fWallpaperImage.LoadFromFile(FileName);
    fWallpaperImageSrc := ExtractFileName(FileName);
    fThemeFiles.Add(FileName);
  except
  end;
  Change;
end;

procedure TOKTThemeContainer.LoadDesktop(FileName: string);
begin
  try
    fDesktopImage.LoadFromFile(FileName);
    fDesktopImageSrc := ExtractFileName(FileName);
    fThemeFiles.Add(FileName);
  except
  end;
  Change;
end;

procedure TOKTThemeContainer.LoadMenu(FileName: string);
begin
  try
    fMenuImage.LoadFromFile(FileName);
    fMenuImageSrc := ExtractFileName(FileName);
    fThemeFiles.Add(FileName);
  except
  end;
  Change;
end;

procedure TOKTThemeContainer.LoadMenuTitle(FileName: string);
begin
  try
    fMenuTitleImage.LoadFromFile(FileName);
    fMenuTitleImageSrc := ExtractFileName(FileName);
    fThemeFiles.Add(FileName);
  except
  end;
  Change;
end;

procedure TOKTThemeContainer.LoadMenuHighlight(FileName: string);
begin
  try
    fMenuHighlightImage.LoadFromFile(FileName);
    fMenuHighlightImageSrc := ExtractFileName(FileName);
    fThemeFiles.Add(FileName);
  except
  end;
  Change;
end;

procedure TOKTThemeContainer.LoadPopUpTitle(FileName: string);
begin
  try
    fPopUpTitleImage.LoadFromFile(FileName);
    fPopUpTitleImageSrc := ExtractFileName(FileName);
    fThemeFiles.Add(FileName);
  except
  end;
  Change;
end;

procedure TOKTThemeContainer.LoadPopUpHighLight(FileName: string);
begin
  try
    fPopUpHighLightImage.LoadFromFile(FileName);
    fPopUpHighLightImageSrc := ExtractFileName(FileName);
    fThemeFiles.Add(FileName);
  except
  end;
  Change;
end;

procedure TOKTThemeContainer.LoadSoftKeys(FileName: string);
begin
  try
    fSoftKeysImage.LoadFromFile(FileName);
    fSoftKeysImageSrc := ExtractFileName(FileName);
    fThemeFiles.Add(FileName);
  except
  end;
  Change;
end;

procedure TOKTThemeContainer.ParseThemeXML(FileName: string);
var
  F: TextFile;
  XMLStr: string;
begin
  try
    InitXMLFile(FileName, 'Temp.XML');
    AssignFile(F, 'Temp.XML');
    Reset(F);
    fThemeName := '';
    fPhoneModel := '';
    fThemeCreator := '';
    fThemeCreatedTime := '';
    fStatusBarImageSrc := '';
    fWallpaperImageSrc := '';
    fDesktopImageSrc := '';
    fMenuImageSrc := '';
    fMenuTitleImageSrc := '';
    fMenuHighlightImageSrc := '';
    fPopUpTitleImageSrc := '';
    fPopUpHighLightImageSrc := '';
    fSoftKeysImageSrc := '';
    while not EOF(F) do
    begin
      ReadLn(F, XMLStr);
      if ParseXMLStr(XMLStr, 0) = 'THEME_NAME' then
        fThemeName := ParseXMLStr(XMLStr, 1);
      if ParseXMLStr(XMLStr, 0) = 'PHONE_MODEL' then
        fPhoneModel := ParseXMLStr(XMLStr, 1);
      if ParseXMLStr(XMLStr, 0) = 'THEME_CREATOR' then
        fThemeCreator := ParseXMLStr(XMLStr, 1);
      if ParseXMLStr(XMLStr, 0) = 'THEME_CREATED' then
        fThemeCreatedTime := ParseXMLStr(XMLStr, 1);
      if ParseXMLStr(XMLStr, 0) = 'STATUSBAR_BACKGROUND_IMAGE' then
        fStatusBarImageSrc := ParseXMLStr(XMLStr, 1);
      if ParseXMLStr(XMLStr, 0) = 'WALLPAPER_IMAGE' then
        fWallpaperImageSrc := ParseXMLStr(XMLStr, 1);
      if ParseXMLStr(XMLStr, 0) = 'SOFTKEYS_BACKGROUND_IMAGE' then
        fSoftKeysImageSrc := ParseXMLStr(XMLStr, 1);
      if ParseXMLStr(XMLStr, 0) = 'DESKTOP_BACKGROUND_IMAGE' then
        fDesktopImageSrc := ParseXMLStr(XMLStr, 1);
      if ParseXMLStr(XMLStr, 0) = 'TITLE_IMAGE' then
        fMenuTitleImageSrc := ParseXMLStr(XMLStr, 1);
      if ParseXMLStr(XMLStr, 0) = 'GENERAL_BACKGROUND_IMAGE' then
        fMenuImageSrc := ParseXMLStr(XMLStr, 1);
      if ParseXMLStr(XMLStr, 0) = 'HIGHLIGHT_IMAGE' then
        fMenuHighlightImageSrc := ParseXMLStr(XMLStr, 1);
      if ParseXMLStr(XMLStr, 0) = 'MORELIST_POPUP_TITLE_IMAGE' then
        fPopUpTitleImageSrc := ParseXMLStr(XMLStr, 1);
      if ParseXMLStr(XMLStr, 0) = 'MORELIST_POPUP_HIGHLIGHT_IMAGE' then
        fPopUpHighLightImageSrc := ParseXMLStr(XMLStr, 1);
      if ParseXMLStr(XMLStr, 0) = 'STANDBY_OPERATORNAME_TEXT' then
        fOperatorTextColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'STANDBY_OPERATORNAME_OUTLINE' then
        fOperatorOutLineColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'STANDBY_TIME' then
        fTimeTextColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'STANDBY_TIME_OUTLINE' then
        fTimeOutlineColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'BACKGROUND' then
        fMenuBGColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'DESKTOP_BACKGROUND' then
        fDesktopBGColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'DESKTOP_TITLE' then
        fDesktopTitleColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'DESKTOP_TITLE_OUTLINE' then
        fDesktopTitleOutlineColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'TEXT' then
        fMenuTextColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'TITLE' then
        fMenuTitleBGColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'TITLE_TEXT' then
        fMenuTitleTextColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'TITLE_TEXT_SHADOW' then
        fMenuTitleShadowColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'DISABLED_TEXT' then
        fMenuDisabledTextColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'HIGHLIGHT' then
        fHighlightColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'HIGHLIGHT_TEXT' then
        fHighlightTextColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'HIGHLIGHT_DISABLED_TEXT' then
        fHighlightDisabledColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'PROMPT' then
        fMenuPromptColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'CURSOR' then
        fMenuCursorColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'SCROLLBAR' then
        fMenuScrollBarColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'SCROLLBAR_FRAME' then
        fMenuScrollBarBGColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'MORELIST_TITLE' then
        fPopUpTitleBGColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'MORELIST_TITLE_TEXT' then
        fPopUpTitleTextColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'MORELIST_TITLE_TEXT_SHADOW' then
        fPopUpTitleShadowColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'MORELIST_BACKGROUND' then
        fPopUpMenuBGColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'MORELIST_TEXT' then
        fPopUpMenuTextColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'MORELIST_POPUP_FRAME' then
        fPopUpFrameColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'MORELIST_POPUP_SHADOW' then
        fPopUpFrameShadowColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'MORELIST_DISABLED_TEXT' then
        fPopUpMenuDisabledTextColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'MORELIST_PROMPT' then
        fPopUpMenuPromptColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'MORELIST_CURSOR' then
        fPopUpMenuCursorColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'MORELIST_HIGHLIGHT' then
        fPopUpMenuHighlightColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'MORELIST_HIGHLIGHT_TEXT' then
        fPopUpMenuHighlightTextColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'MORELIST_HIGHLIGHT_DISABLED_TEXT' then
        fPopUpMenuHighlightDisabledTextColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'MORELIST_SCROLLBAR' then
        fPopUpScrollBarColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'MORELIST_SCROLLBAR_FRAME' then
        fPopUpScrollBarBGColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'NOTES_BACKGROUND' then
        fNotesBGColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'NOTES_TEXT' then
        fNotesTextColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'CALENDAR_WEEKEND_TEXT' then
        fCalendarWeekendColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'CALENDAR_WEEKEND_HIGHLIGHT' then
        fCalendarHighlightColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'CALENDAR_WEEKEND_HIGHLIGHT_TEXT' then
        fCalendarHighlightTextColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'WAPBROWSER_UNDERLINE' then
        fWAPBrowserUnderLineColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'WAPBROWSER_TABLEBORDER' then
        fWAPBrowserTableBorderColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'SOFTKEYS_BACKGROUND' then
        fSoftKeysBGColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'SOFTKEYS_TEXT' then
        fSoftkeysTextColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'SOFTKEYS_TEXT_SHADOW' then
        fSoftkeysTextShadowColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'SOFTKEYS_DISABLED_TEXT' then
        fSoftKeysDisabledTextColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'SOFTKEYS_DISABLED_TEXT_SHADOW' then
        fSoftkeysDisabledTextShadowColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
      if ParseXMLStr(XMLStr, 0) = 'SOFTKEYS_BACKGROUND_ACTIVATED' then
        fSoftKeysBGActivatedColor := StrToThemeColor(ParseXMLStr(XMLStr, 1));
    end;
  finally
    CloseFile(F);
    DeleteFile('Temp.XML');
  end;
  if not FileExists(GetTempDir + fStatusBarImageSrc) then
    fStatusBarImageSrc := '';
  if not FileExists(GetTempDir + fWallpaperImageSrc) then
    fWallpaperImageSrc := '';
  if not FileExists(GetTempDir + fDesktopImageSrc) then
    fDesktopImageSrc := '';
  if not FileExists(GetTempDir + fMenuImageSrc) then
    fMenuImageSrc := '';
  if not FileExists(GetTempDir + fMenuTitleImageSrc) then
    fMenuTitleImageSrc := '';
  if not FileExists(GetTempDir + fMenuHighlightImageSrc) then
    fMenuHighlightImageSrc := '';
  if not FileExists(GetTempDir + fPopUpTitleImageSrc) then
    fPopUpTitleImageSrc := '';
  if not FileExists(GetTempDir + fPopUpHighLightImageSrc) then
    fPopUpHighLightImageSrc := '';
  if not FileExists(GetTempDir + fSoftKeysImageSrc) then
    fSoftKeysImageSrc := '';
  try
    if (length(fStatusBarImageSrc) > 4) then
      fStatusBarImage.LoadFromFile(GetTempDir + fStatusBarImageSrc)
    else
      fStatusBarImage.Assign(nil);
  except
  end;
  try
    if (length(fWallpaperImageSrc) > 4) then
      fWallpaperImage.LoadFromFile(GetTempDir + fWallpaperImageSrc)
    else
      fWallpaperImage.Assign(nil);
  except
  end;
  try
    if (length(fDesktopImageSrc) > 4) then
      fDesktopImage.LoadFromFile(GetTempDir + fDesktopImageSrc)
    else
      fDesktopImage.Assign(nil);
  except
  end;
  try
    if (length(fMenuImageSrc) > 4) then
      fMenuImage.LoadFromFile(GetTempDir + fMenuImageSrc)
    else
      fMenuImage.Assign(nil);
  except
  end;
  try
    if (length(fMenuTitleImageSrc) > 4) then
      fMenuTitleImage.LoadFromFile(GetTempDir + fMenuTitleImageSrc)
    else
      fMenuTitleImage.Assign(nil);
  except
  end;
  try
    if (length(fMenuHighlightImageSrc) > 4) then
      fMenuHighlightImage.LoadFromFile(GetTempDir + fMenuHighlightImageSrc)
    else
      fMenuHighlightImage.Assign(nil);
  except
  end;
  try
    if (length(fPopUpTitleImageSrc) > 4) then
      fPopUpTitleImage.LoadFromFile(GetTempDir + fPopUpTitleImageSrc)
    else
      fPopUpTitleImage.Assign(nil);
  except
  end;
  try
    if (length(fPopUpHighLightImageSrc) > 4) then
      fPopUpHighLightImage.LoadFromFile(GetTempDir + fPopUpHighLightImageSrc)
    else
      fPopUpHighLightImage.Assign(nil);
  except
  end;
  try
    if (length(fSoftKeysImageSrc) > 4) then
      fSoftKeysImage.LoadFromFile(GetTempDir + fSoftKeysImageSrc)
    else
      fSoftKeysImage.Assign(nil);
  except
  end;
  Change;
end;

procedure TOKTThemeContainer.SaveXML(FileName: string);
var
  F: TextFile;
begin
  try
    AssignFile(F, FileName);
    ReWrite(F);
    writeLn(F, '<?xml version="1.0"?>');
    writeLn(F, '<Sony_Ericsson_theme>');
    writeLn(F, '<!--Created_With_BigTurca_ThemeFactory>');
    writeLn(F, '<Phone_model Name="' + fPhoneModel + '"/>');
    writeLn(F, '<Theme_name Name="' + fThemeName + '"/>');
    writeLn(F, '<Theme_creator Name="' + fThemeCreator + '"/>');
    writeLn(F, '<Theme_modified_by Name="' + fModifiedBy + '"/>');
    writeLn(F, '<Theme_created Date="' + fThemeCreatedTime + '"/>-->');
    if (fStatusBarImageSrc <> '') then
      writeLn(F, '<Statusbar_background_image Source="' + fStatusBarImageSrc + '"/>');
    if (fWallpaperImageSrc <> '') then
      writeLn(F, '<Wallpaper_image Source="' + fWallpaperImageSrc + '"/>');
    if (fDesktopImageSrc <> '') then
      writeLn(F, '<Softkeys_background_image Source="' + fSoftKeysImageSrc + '"/>');
    if (fMenuImageSrc <> '') then
      writeLn(F, '<Desktop_background_image Source="' + fDesktopImageSrc + '"/>');
    if (fMenuTitleImageSrc <> '') then
      writeLn(F, '<Title_image Source="' + fMenuTitleImageSrc + '"/>');
    if (fMenuHighlightImageSrc <> '') then
      writeLn(F, '<General_background_image Source="' + fMenuImageSrc + '"/>');
    if (fPopUpTitleImageSrc <> '') then
      writeLn(F, '<Highlight_image Source="' + fMenuHighlightImageSrc + '"/>');
    if (fPopUpHighLightImageSrc <> '') then
      writeLn(F, '<Morelist_popup_title_image Source="' + fPopUpTitleImageSrc + '"/>');
    if (fSoftKeysImageSrc <> '') then
      writeLn(F, '<Morelist_popup_highlight_image Source="' + fPopUpHighLightImageSrc + '"/>');

    writeLn(F, '<Standby_operatorname_text Color="' + ColorToThemeColor(fOperatorTextColor) + '"/>');
    writeLn(F, '<Standby_operatorname_outline Color="' + ColorToThemeColor(fOperatorOutLineColor) + '"/>');
    writeLn(F, '<Standby_time Color="' + ColorToThemeColor(fTimeTextColor) + '"/>');
    writeLn(F, '<Standby_time_outline Color="' + ColorToThemeColor(fTimeOutlineColor) + '"/>');

    writeLn(F, '<Desktop_background Color="' + ColorToThemeColor(fDesktopBGColor) + '"/>');
    writeLn(F, '<Desktop_title Color="' + ColorToThemeColor(fDesktopTitleColor) + '"/>');
    writeLn(F, '<Desktop_title_outline Color="' + ColorToThemeColor(fDesktopTitleOutlineColor) + '"/>');

    writeLn(F, '<Title Color="' + ColorToThemeColor(fMenuTitleBGColor) + '"/>');
    writeLn(F, '<Title_text Color="' + ColorToThemeColor(fMenuTitleTextColor) + '"/>');
    writeLn(F, '<Title_text_shadow Color="' + ColorToThemeColor(fMenuTitleShadowColor) + '"/>');
    writeLn(F, '<Background Color="' + ColorToThemeColor(fMenuBGColor) + '"/>');
    writeLn(F, '<Text Color="' + ColorToThemeColor(fMenuTextColor) + '"/>');
    writeLn(F, '<Disabled_text Color="' + ColorToThemeColor(fMenuDisabledTextColor) + '"/>');
    writeLn(F, '<Prompt Color="' + ColorToThemeColor(fMenuPromptColor) + '"/>');
    writeLn(F, '<Cursor Color="' + ColorToThemeColor(fMenuCursorColor) + '"/>');
    writeLn(F, '<Scrollbar Color="' + ColorToThemeColor(fMenuScrollBarColor) + '"/>');
    writeLn(F, '<Scrollbar_frame Color="' + ColorToThemeColor(fMenuScrollBarBGColor) + '"/>');
    writeLn(F, '<Highlight Color="' + ColorToThemeColor(fHighlightColor) + '"/>');
    writeLn(F, '<Highlight_text Color="' + ColorToThemeColor(fHighlightTextColor) + '"/>');
    writeLn(F, '<Highlight_disabled_text Color="' + ColorToThemeColor(fHighlightDisabledColor) + '"/>');

    writeLn(F, '<Morelist_title Color="' + ColorToThemeColor(fPopUpTitleBGColor) + '"/>');
    writeLn(F, '<Morelist_title_text Color="' + ColorToThemeColor(fPopUpTitleTextColor) + '"/>');
    writeLn(F, '<Morelist_title_text_shadow Color="' + ColorToThemeColor(fPopUpTitleShadowColor) + '"/>');
    writeLn(F, '<Morelist_background Color="' + ColorToThemeColor(fPopUpMenuBGColor) + '"/>');
    writeLn(F, '<Morelist_text Color="' + ColorToThemeColor(fPopUpMenuTextColor) + '"/>');
    writeLn(F, '<Morelist_disabled_text Color="' + ColorToThemeColor(fPopUpMenuDisabledTextColor) + '"/>');
    writeLn(F, '<Morelist_Prompt Color="' + ColorToThemeColor(fPopUpMenuPromptColor) + '"/>');
    writeLn(F, '<Morelist_Cursor Color="' + ColorToThemeColor(fPopUpMenuCursorColor) + '"/>');
    writeLn(F, '<Morelist_highlight Color="' + ColorToThemeColor(fPopUpMenuHighlightColor) + '"/>');
    writeLn(F, '<Morelist_highlight_text Color="' + ColorToThemeColor(fPopUpMenuHighlightTextColor) + '"/>');
    writeLn(F, '<Morelist_highlight_disabled_text Color="' + ColorToThemeColor(fPopUpMenuHighlightDisabledTextColor) + '"/>');
    writeLn(F, '<Morelist_popup_frame Color="' + ColorToThemeColor(fPopUpFrameColor) + '"/>');
    writeLn(F, '<Morelist_popup_shadow Color="' + ColorToThemeColor(fPopUpFrameShadowColor) + '"/>');
    writeLn(F, '<Morelist_scrollbar Color="' + ColorToThemeColor(fPopUpScrollBarColor) + '"/>');
    writeLn(F, '<Morelist_scrollbar_frame Color="' + ColorToThemeColor(fPopUpScrollBarBGColor) + '"/>');

    writeLn(F, '<Notes_background Color="' + ColorToThemeColor(fNotesBGColor) + '"/>');
    writeLn(F, '<Notes_text Color="' + ColorToThemeColor(fNotesTextColor) + '"/>');

    writeLn(F, '<Calendar_weekend_text Color="' + ColorToThemeColor(fCalendarWeekendColor) + '"/>');
    writeLn(F, '<Calendar_weekend_highlight Color="' + ColorToThemeColor(fCalendarHighlightColor) + '"/>');
    writeLn(F, '<Calendar_weekend_highlight_text Color="' + ColorToThemeColor(fCalendarHighlightTextColor) + '"/>');

    writeLn(F, '<Wapbrowser_underline Color="' + ColorToThemeColor(fWAPBrowserUnderLineColor) + '"/>');
    writeLn(F, '<Wapbrowser_tableborder Color="' + ColorToThemeColor(fWAPBrowserTableBorderColor) + '"/>');

    writeLn(F, '<Softkeys_background Color="' + ColorToThemeColor(fSoftKeysBGColor) + '"/>');
    writeLn(F, '<Softkeys_text Color="' + ColorToThemeColor(fSoftkeysTextColor) + '"/>');
    writeLn(F, '<Softkeys_text_shadow Color="' + ColorToThemeColor(fSoftkeysTextShadowColor) + '"/>');
    writeLn(F, '<Softkeys_disabled_text Color="' + ColorToThemeColor(fSoftKeysDisabledTextColor) + '"/>');
    writeLn(F, '<Softkeys_disabled_text_shadow Color="' + ColorToThemeColor(fSoftkeysDisabledTextShadowColor) + '"/>');
    writeLn(F, '<Softkeys_background_activated Color="' + ColorToThemeColor(fSoftKeysBGActivatedColor) + '"/>');
    writeLn(F, '</Sony_Ericsson_theme>');
  finally
    Flush(F);
    CloseFile(F);
  end;
end;

procedure TOKTThemeContainer.Clear;
var
  YYYY, d, m: Word;
  HH, MM, SS, ms: Word;
  sHH, sMM, sSS: string;
begin
  fThemeFiles.Clear;
  fThemeFiles.Add('MyTheme.xml');
  fXMLFile := 'MyTheme.xml';
  fThemeName := '';
  fPhoneModel := '';
  fThemeCreator := '';

  DecodeDate(Now, YYYY, m, d);
  DecodeTime(Now, HH, MM, SS, ms);

  sHH := IntToStr(HH);
  if (Length(sHH) = 1) then
    sHH := '0' + sHH;
  sMM := IntToStr(MM);
  if (Length(sMM) = 1) then
    sMM := '0' + sMM;
  sSS := IntToStr(SS);
  if (Length(sSS) = 1) then
    sSS := '0' + sSS;
  fThemeCreatedTime := Format('%d.%d.%4d', [d, m, yyyy]) + ' ' + sHH + ':' + sMM + ':' + sSS;

  fStatusBarImageSrc := '';
  fWallpaperImageSrc := '';
  fDesktopImageSrc := '';
  fMenuImageSrc := '';
  fMenuTitleImageSrc := '';
  fMenuHighlightImageSrc := '';
  fPopUpTitleImageSrc := '';
  fPopUpHighLightImageSrc := '';
  fSoftKeysImageSrc := '';

  fOperatorTextColor := $103F68;
  fOperatorOutLineColor := $FFFFFF;

  fTimeTextColor := $103F68;
  fTimeOutlineColor := $FFFFFF;

  fDesktopBGColor := $BFD3E8;
  fDesktopTitleColor := $000000;
  fDesktopTitleOutlineColor := $BDBDBD;

  fNotesBGColor := $FFFFFF;
  fNotesTextColor := $000000;

  fMenuBGColor := $FF80FF;
  fMenuTitleBGColor := $BDBDBD;
  fMenuTitleTextColor := $000000;
  fMenuTitleShadowColor := $BDBDBD;
  fHighlightColor := $1E396C;
  fHighlightTextColor := $FFFFFF;
  fHighlightDisabledColor := $A7B4CA;
  fMenuTextColor := $FF8000;
  fMenuDisabledTextColor := $7F7F7F;
  fMenuPromptColor := $000000;
  fMenuCursorColor := $000000;
  fMenuScrollBarColor := $5689BF;
  fMenuScrollBarBGColor := $E9ECEE;

  fPopUpTitleBGColor := $BDBDBD;
  fPopUpTitleTextColor := $000000;
  fPopUpTitleShadowColor := $BDBDBD;
  fPopUpMenuBGColor := $FFFFFF;
  fPopUpMenuTextColor := $000000;
  fPopUpMenuDisabledTextColor := $7F7F7F;
  fPopUpMenuPromptColor := $000000;
  fPopUpMenuCursorColor := $000000;
  fPopUpMenuHighlightColor := $1E396C;
  fPopUpMenuHighlightTextColor := $FFFFFF;
  fPopUpMenuHighlightDisabledTextColor := $A7B4CA;
  fPopUpFrameColor := $000000;
  fPopUpFrameShadowColor := $30527A;
  fPopUpScrollBarColor := $173E62;
  fPopUpScrollBarBGColor := $A5C1D8;

  fCalendarWeekendColor := $FF8000;
  fCalendarHighlightColor := $1E396C;
  fCalendarHighlightTextColor := $FFFFFF;

  fWAPBrowserUnderLineColor := $00009E;
  fWAPBrowserTableBorderColor := $00009E;

  fSoftKeysBGColor := $BDBDBD;
  fSoftkeysTextColor := $000000;
  fSoftkeysTextShadowColor := $BDBDBD;
  fSoftKeysDisabledTextColor := $7F7F7F;
  fSoftkeysDisabledTextShadowColor := $BDBDBD;
  fSoftKeysBGActivatedColor := $F6F6F5;

end;

procedure TOKTThemeContainer.Change;
var
  i: integer;
begin
  if FClients <> nil then
    for I := 0 to FClients.Count - 1 do
      TThemeChangeLink(FClients[i]).Change;
end;

procedure TOKTThemeContainer.RegisterChanges(aValue: TThemeChangeLink);
begin
  aValue.Sender := self;
  if FClients <> nil then
    FClients.Add(aValue);

end;

{------------------------------------------------------------------------------}

procedure TOKTThemeContainer.UnRegisterChanges(aValue: TThemeChangeLink);
var
  i: integer;
begin
  if FClients <> nil then
    for i := 0 to FClients.Count - 1 do
      if FClients[i] = aValue then
      begin
        aValue.Sender := nil;
        FClients.Delete(i);
        Break;
      end;
end;

destructor TThemeChangeLink.Destroy;
begin
  if Sender <> nil then
    Sender.UnRegisterChanges(Self);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}

procedure TThemeChangeLink.Change;
begin
  if Assigned(OnChange) then
    OnChange(Sender);
end;

constructor tCustomThemeViewer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FPicture := TPicture.Create;
  FPicture.OnChange := PictureChanged;
  Width := 128;
  Height := 160;
end;

destructor tCustomThemeViewer.Destroy;
begin
  FPicture.Free;
  inherited Destroy;
end;

function tCustomThemeViewer.GetPalette: HPALETTE;
begin
  Result := 0;
  if FPicture.Graphic <> nil then
    Result := FPicture.Graphic.Palette;
end;

{**}function tCustomThemeViewer.DestRect: TRect;
var
  w, h, cw, ch: Integer;
  xyaspect: Double;
begin
  w := Picture.Width;
  h := Picture.Height;
  cw := ClientWidth;
  ch := ClientHeight;
  if ((w > cw) or (h > ch)) then
  begin
    if (w > 0) and (h > 0) then
    begin
      xyaspect := w / h;
      if w > h then
      begin
        w := cw;
        h := Trunc(cw / xyaspect);
        if h > ch then // woops, too big
        begin
          h := ch;
          w := Trunc(ch * xyaspect);
        end;
      end
      else
      begin
        h := ch;
        w := Trunc(ch * xyaspect);
        if w > cw then // woops, too big
        begin
          w := cw;
          h := Trunc(cw / xyaspect);
        end;
      end;
    end
    else
    begin
      w := cw;
      h := ch;
    end;
  end;

  with Result do
  begin
    Left := 0;
    Top := 0;
    Right := w;
    Bottom := h;
  end;

  if Center then
    OffsetRect(Result, (cw - w) div 2, (ch - h) div 2);
end;

procedure tCustomThemeViewer.Paint;
var
  Save: Boolean;
begin
  if csDesigning in ComponentState then
    with inherited Canvas do
    begin
      Pen.Style := psDash;
      Brush.Style := bsClear;
      Rectangle(0, 0, Width, Height);
    end;
  Save := FDrawing;
  FDrawing := True;
  try
    with inherited Canvas do
      StretchDraw(DestRect, Picture.Graphic);
  finally
    FDrawing := Save;
  end;
end;

function tCustomThemeViewer.DoPaletteChange: Boolean;
var
  ParentForm: TCustomForm;
  Tmp: TGraphic;
begin
  Result := False;
  Tmp := Picture.Graphic;
  if Visible and (not (csLoading in ComponentState)) and (Tmp <> nil) and
    (Tmp.PaletteModified) then
  begin
    if (Tmp.Palette = 0) then
      Tmp.PaletteModified := False
    else
    begin
      ParentForm := GetParentForm(Self);
      if Assigned(ParentForm) and ParentForm.Active and Parentform.HandleAllocated then
      begin
        if FDrawing then
          ParentForm.Perform(wm_QueryNewPalette, 0, 0)
        else
          PostMessage(ParentForm.Handle, wm_QueryNewPalette, 0, 0);
        Result := True;
        Tmp.PaletteModified := False;
      end;
    end;
  end;
end;

function tCustomThemeViewer.GetCanvas: TCanvas;
var
  Bitmap: TBitmap;
begin
  if Picture.Graphic = nil then
  begin
    Bitmap := TBitmap.Create;
    try
      Bitmap.Width := Width;
      Bitmap.Height := Height;
      Picture.Graphic := Bitmap;
    finally
      Bitmap.Free;
    end;
  end;
  if Picture.Graphic is TBitmap then
    Result := TBitmap(Picture.Graphic).Canvas
  else
    raise EInvalidOperation.Create(SImageCanvasNeedsBitmap);
end;

procedure tCustomThemeViewer.SetCenter(Value: Boolean);
begin
  if FCenter <> Value then
  begin
    FCenter := Value;
    PictureChanged(Self);
  end;
end;

procedure tCustomThemeViewer.SetPicture(Value: TPicture);
begin
  FPicture.Assign(Value);
end;

procedure tCustomThemeViewer.PictureChanged(Sender: TObject);
var
  G: TGraphic;
begin
  if AutoSize and (Picture.Width > 0) and (Picture.Height > 0) then
    SetBounds(Left, Top, Picture.Width, Picture.Height);
  G := Picture.Graphic;
  if G <> nil then
  begin
    if not ((G is TMetaFile) or (G is TIcon)) then
      G.Transparent := False;
    if not G.Transparent then
      ControlStyle := ControlStyle + [csOpaque]
    else // picture might not cover entire clientrect
      ControlStyle := ControlStyle - [csOpaque];
    if DoPaletteChange and FDrawing then
      Update;
  end
  else
    ControlStyle := ControlStyle - [csOpaque];
  if not FDrawing then
    Invalidate;
end;

function tCustomThemeViewer.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
begin
  Result := True;
  if not (csDesigning in ComponentState) or (Picture.Width > 0) and
    (Picture.Height > 0) then
  begin
    if Align in [alNone, alLeft, alRight] then
      NewWidth := Picture.Width;
    if Align in [alNone, alTop, alBottom] then
      NewHeight := Picture.Height;
  end;
end;

function TOKTThemeViewer.GetScreenShot;
begin
  Result := fScreenBitmap;
end;

procedure TOKTThemeViewer.InitUILanguage;
begin
  case fLanguage of
    lngTurkish:
      begin
        strCalls := 'Çaðrýlar';
        strMissedCalls := 'Cevapsýz çaðrýlar';
        strDivertCalls := 'Çaðrý yönlendirme';
        strManageCalls := 'Çaðrýlarý yönet';
        strTimeAndCost := 'Zaman ve ücret';
        strNextCall := 'Sonraki çaðrý';
        strCall := 'Ara';
        strCallList := 'Çaðrý listesi';
        strInfo := 'Bilgi';
        strMore := 'Seçim';
        strOK := 'Tamam';
        strCancel := 'Ýptal';
        strYes := 'Evet';
        strNo := 'Hayýr';
        strAccept := 'Kabul?';
        strSave := 'Kaydet';
        strSelect := 'Seç';
        strSMS := 'SMS';
        strWriteNew := 'Yeni mesaj yaz';
        strInBox := 'Gelenler';
        strSIMArchive := 'SIM arþivi';
        strUnSentItems := 'Gitmeyenler';
        strTemplates := 'Kalýplar';
        strSentItems := 'Gönderilen mesajlar';
        strSendingMsg := 'Mesaj Gönderiliyor';
        strMsgSended := 'Mesaj Gönderildi';
        strMyMobile := '05327237700 ';
        strRead := 'Oku';
        strSetTime := 'Saati ayarla';
        strNumber := 'Numara:';
        strLookUp := 'Baþvur';
        strForward := 'Ýlet';
        strContinue := 'Devam et';
        strNote := 'Not';
        strFindContact := 'Kayýt ara';
        strFind := 'Bul:';
        strTcell := 'TURKCELL';
        strMo := 'P';
        strTu := 'S';
        strWe := 'Ç';
        strTh := 'P';
        strFr := 'C';
        strSa := 'C';
        strSu := 'P';
        strContactInfo := 'Kayýt bilgileri';
        strUncheck := 'Seç.Ýptal';
        strThemes := 'Temalar';
        strSend := 'Gönder';
        strDelete := 'Sil';
        strEdit := 'Düzenle';
        strRename := 'Yeni isim ver';
        strThemeInf := 'Tema bilgisi';
        strMemoryStat := 'Bellek durumu';
        strSE := 'Sony Ericsson';
        strInternetServices := 'Ýnternet servisleri ';
        strMyShortCuts := 'Kýsa yollarým';
        strCamera := 'Kamera';
        strMessaging := 'Mesajlar';
        strEntertainment := 'Eðlence';
        strPicturesAndSounds := 'Resimler & Sesler';
        strPhonebook := 'Telefon defteri';
        strConnectivity := 'Baðlantý';
        strOrganizer := 'Organizer';
        strSettings := 'Ayarlar';
        strMySounds := 'Seslerim';
        strSetAsringSignal := 'Zil sesi olar.ayarla';
        strPlay := 'Dinlet';
        strRing_1 := 'Carribean';
        strRing_2 := 'Copacabana';
        strRing_3 := 'Dataflow';
        strRing_4 := 'Digirain';
        strRing_5 := 'Joybells';
        strRing_6 := 'Moonstar';
        strRingVolume := 'Zil sesi';
        strContact_1 := 'Saddam(6)';
        strContact_2 := 'Hülya';
        strContact_3 := 'Aþkým';
        strContact_4 := 'Bush(4)';
        strContact_5 := 'Tarkan';
        strContact_6 := 'Batuhan';
        strContact_7 := 'Oktay';
        strContact_8 := 'Ýrfan';
        strContact_9 := 'Aslýhan';
        strContact_10 := 'Sema';
        strContact_11 := 'Ayhan';
        strWallpaper := 'Arka Plan';
        strName := 'Ýsim';
        strHome := 'Ev';
        strWork := 'Ýþ';
        strMobile := 'Cep';
        strFax := 'Faks';
        strOther := 'Diðer';
        strMail := 'E-posta';
        strAddContact := 'Kayýt ekle';
        strSymbols := 'Semboller';
        strHHMM := '(SS:DD)';
      end;

  { for english }
    lngEnglish:
      begin
        strCalls := 'Calls';
        strMissedCalls := 'Missed calls';
        strDivertCalls := 'Divert calls';
        strManageCalls := 'Manage calls';
        strTimeAndCost := 'Time and cost';
        strNextCall := 'Next call';
        strCall := 'Call';
        strCallList := 'Call list';
        strInfo := 'Info';
        strMore := 'More';
        strOK := 'Ok';
        strCancel := 'Cancel';
        strYes := 'Yes';
        strNo := 'No';
        strAccept := 'Accept?';
        strSave := 'Save';
        strSelect := 'Select';
        strSMS := 'Text';
        strWriteNew := 'Write new';
        strInBox := 'Inbox';
        strSIMArchive := 'SIM archive';
        strUnSentItems := 'Unsent items';
        strTemplates := 'Templates';
        strSentItems := 'Sent items';
        strSendingMsg := 'Sending message';
        strMsgSended := 'Message sended';
        strMyMobile := '05327237700 ';
        strRead := 'Read';
        strSetTime := 'Set time';
        strNumber := 'Number:';
        strLookUp := 'Look up';
        strForward := 'Forward';
        strContinue := 'Continue';
        strNote := 'Note';
        strFindContact := 'Find contact';
        strFind := 'Find:';
        strTcell := 'TURKCELL';
        strMo := 'M';
        strTu := 'T';
        strWe := 'W';
        strTh := 'T';
        strFr := 'F';
        strSa := 'S';
        strSu := 'S';
        strContactInfo := 'Contact info.';
        strUncheck := 'Uncheck';
        strThemes := 'Themes';
        strSend := 'Send';
        strDelete := 'Delete';
        strEdit := 'Edit';
        strRename := 'Rename';
        strThemeInf := 'Theme info';
        strMemoryStat := 'Memory status';
        strSE := 'Sony Ericsson';
        strInternetServices := 'Internet Services ';
        strMyShortCuts := 'My shortcuts';
        strCamera := 'Camera';
        strMessaging := 'Messaging';
        strEntertainment := 'Entertainment';
        strPicturesAndSounds := 'Pictures & sounds';
        strPhonebook := 'Phonebook';
        strConnectivity := 'Connectivity';
        strOrganizer := 'Organizer';
        strSettings := 'Settings';
        strMySounds := 'My sounds';
        strSetAsringSignal := 'Set as ring signal';
        strPlay := 'Play';
        strRing_1 := 'Carribean';
        strRing_2 := 'Copacabana';
        strRing_3 := 'Dataflow';
        strRing_4 := 'Digirain';
        strRing_5 := 'Joybells';
        strRing_6 := 'Moonstar';
        strRingVolume := 'Ring Volume';
        strContact_1 := 'Saddam(6)';
        strContact_2 := 'john';
        strContact_3 := 'Janet';
        strContact_4 := 'Bush(4)';
        strContact_5 := 'Elton';
        strContact_6 := 'Bruce';
        strContact_7 := 'Mahoni';
        strContact_8 := 'Tim';
        strContact_9 := 'Juliet';
        strContact_10 := 'Sam';
        strContact_11 := 'Simpson';
        strWallpaper := 'Wallpaper';
        strName := 'Name';
        strHome := 'Home';
        strWork := 'Work';
        strMobile := 'Mobile';
        strFax := 'Fax';
        strOther := 'Other';
        strMail := 'E-mail';
        strAddContact := 'Add contact';
        strSymbols := 'Symbols';
        strHHMM := '(HH:MM)';
      end;
  end;
end;

destructor TOKTThemeViewer.Destroy;
begin
  FContainerLink.OnChange := nil;
  fScreenBitmap.Free;
  FContainerLink.Destroy;
  FViewer.Destroy;
  inherited Destroy;
end;

constructor TOKTThemeViewer.Create(AOwner: TComponent);

begin
  inherited Create(AOwner);
  Width := 140;
  Height := 172;
  BevelInner := bvLowered;
  BevelOuter := bvLowered;
  FContainerLink := TThemeChangeLink.Create;
  FContainerLink.OnChange := GetThemeChange;
  fViewer := TCustomThemeViewer.Create(Self);
  fViewer.OnClick := ThemeClick;
  fViewer.OnDblClick := ThemeDblClick;
  fViewer.OnMouseDown := ThemeMouseDown;
  fViewer.OnMouseMove := ThemeMouseMove;
  fViewer.OnMouseUp := ThemeMouseUp;
  fViewer.Parent := Self;
  fViewer.Align := alNone;
  fViewer.Left := 6;
  fViewer.Top := 6;
  fScreenBitmap := TBitmap.Create;
  fOperatorName := 'TR TURKCELL';
  OnResize := ResizeCanvas;
  Color := clBlack;
  fImagesVisible := True;
  fLanguage := lngTurkish;
end;

procedure TOKTThemeViewer.ThemeClick(Sender: TObject);
begin
  if Assigned(FThemeOnClick) then
    FThemeOnClick(Sender);
end;

procedure TOKTThemeViewer.ThemeDblClick(Sender: TObject);
begin
  if Assigned(FThemeOnDblClick) then
    FThemeOnDblClick(Sender);
end;

procedure TOKTThemeViewer.ThemeMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if Assigned(FThemeOnMouseDown) then
    FThemeOnMouseDown(Sender, Button, Shift, X, Y);
end;

procedure TOKTThemeViewer.ThemeMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if Assigned(FThemeOnMouseUp) then
    FThemeOnMouseUp(Sender, Button, Shift, X, Y);
end;

procedure TOKTThemeViewer.ThemeMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FThemeOnMouseMove) then
    FThemeOnMouseMove(Sender, Shift, X, Y);
end;

procedure TOKTThemeViewer.InitializePreview;
var
  Pic: TPicture;
  i, RingLeft, RingTop, RingRight: Integer;
  FillColor: TColor;
 {Calendar month variables}
  ci, cj, cx, cy, cz: Word;
  Cal: TCalendar;
  StrList: TStringList;
  DayOfMonth, WeekOfYear, MonthOfYear: Word;
  MonthStr: string;
  cX1, cY1: Integer;
  {gradient variables}
  Row, Ht: Word;
begin
  Pic := TPicture.Create;
  fScreenBitmap.Width := 128;
  fScreenBitmap.Height := 160;
  fScreenBitmap.PixelFormat := pf24bit;
  fScreenBitmap.Canvas.Brush.Style := bsSolid;
  fScreenBitmap.Canvas.Pen.Style := psSolid;
  fScreenBitmap.Canvas.Brush.Color := clBlue;
  fScreenBitmap.Canvas.FillRect(Rect(0, 0, Width, Height));

  InitUILanguage;

  with fScreenBitmap do
  begin
    with Canvas do
    begin
      case fpreview of

        pvNone: // Draw Gradient Screen

          begin
            Ht := (ClientHeight + 255) div 256;
            for Row := 0 to 255 do
            begin
              Brush.Color := RGB(0, 0, row);
              FillRect(Rect(0, Row * Ht, ClientWidth, (Row + 1) * Ht));
            end;
          end;

        pvContactName: // Add Contact Name

          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            if Assigned(fContainer) then
              DrawShape(Canvas, 0, 14, 128, 37, fContainer.MenuTitleColor)
            else
              DrawShape(Canvas, 0, 14, 128, 37, clRed);
            if (Assigned(fContainer) and fImagesVisible) then
            begin
              StretchDraw(Rect(0, 14, 128, 37), fContainer.MenuTitleImage.Graphic);
              StretchDraw(Rect(0, 37, 128, 141), fContainer.MenuImage.Graphic);
            end;
            if Assigned(fContainer) then
              WriteShadowedText(Canvas, 64, 25, strAddContact, fContainer.MenuTitleTextColor, fContainer.MenuTitleTextShadowColor, [fsBold], taCenter)
            else
              WriteShadowedText(Canvas, 64, 25, strAddContact, clWhite, clBlack, [fsBold], taCenter);
            DrawShadowedShape(Canvas, 2, 54, 124, 136, clblack, clblack, clwhite);
            LoadResGraph(PIC, 'DC0');
            Draw(6, 39, PIC.Graphic);
            LoadResGraph(PIC, 'AA0');
            Draw(52, 39, PIC.Graphic);
            WriteText(Canvas, 7, 80, strName + ':', clBlack, [], taLeftJustify);
            if Assigned(fContainer) then
              Pen.Color := fContainer.MenuCursorColor
            else
              Pen.Color := clBlack;
            MoveTo(7, 89);
            LineTo(7, 103);
            DrawSoftKeys(Canvas, strOK, strMore, false, false, false, true);
          end;

        pvContactHome: // Add contact home

          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            if Assigned(fContainer) then
              DrawShape(Canvas, 0, 14, 128, 37, fContainer.MenuTitleColor)
            else
              DrawShape(Canvas, 0, 14, 128, 37, clRed);
            if (Assigned(fContainer) and fImagesVisible) then
            begin
              StretchDraw(Rect(0, 14, 128, 37), fContainer.MenuTitleImage.Graphic);
              StretchDraw(Rect(0, 37, 128, 141), fContainer.MenuImage.Graphic);
            end;
            if Assigned(fContainer) then
              WriteShadowedText(Canvas, 64, 25, strAddContact, fContainer.MenuTitleTextColor, fContainer.MenuTitleTextShadowColor, [fsBold], taCenter)
            else
              WriteShadowedText(Canvas, 64, 25, strAddContact, clWhite, clBlack, [fsBold], taCenter);
            DrawShadowedShape(Canvas, 11, 59, 117, 128, clblack, clblack, clwhite);
            LoadResGraph(PIC, 'DC1');
            Draw(6, 39, Pic.Graphic);
            WriteText(Canvas, 17, 90, strHome + ':', clBlack, [], taLeftJustify);
            if Assigned(fContainer) then
              Pen.Color := fContainer.MenuCursorColor
            else
              Pen.Color := clBlack;
            MoveTo(17, 99);
            LineTo(17, 113);
            DrawSoftKeys(Canvas, strLookUp, strOK, false, false, false, true);
          end;

        pvContactMobile: // add contact Mobile

          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            if Assigned(fContainer) then
              DrawShape(Canvas, 0, 14, 128, 37, fContainer.MenuTitleColor)
            else
              DrawShape(Canvas, 0, 14, 128, 37, clRed);
            if (Assigned(fContainer) and fImagesVisible) then
            begin
              StretchDraw(Rect(0, 14, 128, 37), fContainer.MenuTitleImage.Graphic);
              StretchDraw(Rect(0, 37, 128, 141), fContainer.MenuImage.Graphic);
            end;
            if Assigned(fContainer) then
              WriteShadowedText(Canvas, 64, 25, strAddContact, fContainer.MenuTitleTextColor, fContainer.MenuTitleTextShadowColor, [fsBold], taCenter)
            else
              WriteShadowedText(Canvas, 64, 25, strAddContact, clWhite, clBlack, [fsBold], taCenter);
            DrawShadowedShape(Canvas, 11, 59, 117, 128, clblack, clblack, clwhite);
            LoadResGraph(PIC, 'DC2');
            Draw(6, 39, Pic.Graphic);
            WriteText(Canvas, 17, 90, strMobile + ':', clBlack, [], taLeftJustify);
            if Assigned(fContainer) then
              Pen.Color := fContainer.MenuCursorColor
            else
              Pen.Color := clBlack;
            MoveTo(17, 99);
            LineTo(17, 113);
            DrawSoftKeys(Canvas, strLookUp, strOK, false, false, false, true);
          end;

        pvContactWork: // add contact work

          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            if Assigned(fContainer) then
              DrawShape(Canvas, 0, 14, 128, 37, fContainer.MenuTitleColor)
            else
              DrawShape(Canvas, 0, 14, 128, 37, clRed);
            if (Assigned(fContainer) and fImagesVisible) then
            begin
              StretchDraw(Rect(0, 14, 128, 37), fContainer.MenuTitleImage.Graphic);
              StretchDraw(Rect(0, 37, 128, 141), fContainer.MenuImage.Graphic);
            end;
            if Assigned(fContainer) then
              WriteShadowedText(Canvas, 64, 25, strAddContact, fContainer.MenuTitleTextColor, fContainer.MenuTitleTextShadowColor, [fsBold], taCenter)
            else
              WriteShadowedText(Canvas, 64, 25, strAddContact, clWhite, clBlack, [fsBold], taCenter);
            DrawShadowedShape(Canvas, 11, 59, 117, 128, clblack, clblack, clwhite);
            LoadResGraph(PIC, 'DC3');
            Draw(6, 39, Pic.Graphic);
            WriteText(Canvas, 17, 90, strWork + ':', clBlack, [], taLeftJustify);
            if Assigned(fContainer) then
              Pen.Color := fContainer.MenuCursorColor
            else
              Pen.Color := clBlack;
            MoveTo(17, 99);
            LineTo(17, 113);
            DrawSoftKeys(Canvas, strLookUp, strOK, false, false, false, true);
          end;

        pvContactMail: // addd contact Mail

          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            if Assigned(fContainer) then
              DrawShape(Canvas, 0, 14, 128, 37, fContainer.MenuTitleColor)
            else
              DrawShape(Canvas, 0, 14, 128, 37, clRed);
            if (Assigned(fContainer) and fImagesVisible) then
            begin
              StretchDraw(Rect(0, 14, 128, 37), fContainer.MenuTitleImage.Graphic);
              StretchDraw(Rect(0, 37, 128, 141), fContainer.MenuImage.Graphic);
            end;
            if Assigned(fContainer) then
              WriteShadowedText(Canvas, 64, 25, strAddContact, fContainer.MenuTitleTextColor, fContainer.MenuTitleTextShadowColor, [fsBold], taCenter)
            else
              WriteShadowedText(Canvas, 64, 25, strAddContact, clWhite, clBlack, [fsBold], taCenter);
            DrawShadowedShape(Canvas, 11, 59, 117, 128, clblack, clblack, clwhite);
            LoadResGraph(PIC, 'DC4');
            Draw(6, 39, Pic.Graphic);
            WriteText(Canvas, 17, 90, strMail + ':', clBlack, [], taLeftJustify);
            if Assigned(fContainer) then
              Pen.Color := fContainer.MenuCursorColor
            else
              Pen.Color := clBlack;
            MoveTo(17, 99);
            LineTo(17, 113);
            DrawSoftKeys(Canvas, strOK, strSymbols, false, false, false, true);
          end;

        pvSetTime: // set time

          begin
            DrawBackGround(canvas);
            DrawStatusBar(Canvas);
            if Assigned(fContainer) then
              DrawShape(Canvas, 0, 14, 128, 37, fContainer.MenuTitleColor)
            else
              DrawShape(Canvas, 0, 14, 128, 37, clRed);
            if (Assigned(fContainer) and fImagesVisible) then
            begin
              StretchDraw(Rect(0, 14, 128, 37), fContainer.MenuTitleImage.Graphic);
              StretchDraw(Rect(0, 37, 128, 141), fContainer.MenuImage.Graphic);
            end;
            if Assigned(fContainer) then
              WriteShadowedText(Canvas, 64, 25, strSetTime, fContainer.MenuTitleTextColor, fContainer.MenuTitleTextShadowColor, [fsBold], taCenter)
            else
              WriteShadowedText(Canvas, 64, 25, strSetTime, clWhite, clBlack, [fsBold], taCenter);
            DrawShadowedShape(Canvas, 11, 59, 117, 128, clblack, clblack, clwhite);
            LoadResGRaph(pic, 'DL7');
            Draw(8, 39, Pic.Graphic);
            Font.Size := 10;
            WriteText(Canvas, 64, 100, FormatDateTime('hh:mm', now), clBlack, [fsBold], taCenter);
            Font.Name := 'Arial';
            Font.Height := 14;
            WriteText(Canvas, 64, 115, strHHMM, clGray, [fsBold], taCenter);
            Font.Name := 'MS Sans Serif';
            Font.Size := 8;
            DrawSoftKeys(Canvas, strSave, '', false, false, false, false);
          end;

        pvSetRingLevel:

          begin
            DrawBackGround(canvas);
            DrawStatusBar(Canvas);
            if Assigned(fContainer) then
              DrawShape(Canvas, 0, 14, 128, 37, fContainer.MenuTitleColor)
            else
              DrawShape(Canvas, 0, 14, 128, 37, clRed);
            if (Assigned(fContainer) and fImagesVisible) then
            begin
              StretchDraw(Rect(0, 14, 128, 37), fContainer.MenuTitleImage.Graphic);
              StretchDraw(Rect(0, 37, 128, 141), fContainer.MenuImage.Graphic);
            end;
            if Assigned(fContainer) then
              WriteShadowedText(Canvas, 64, 25, strRingVolume, fContainer.MenuTitleTextColor, fContainer.MenuTitleTextShadowColor, [fsBold], taCenter)
            else
              WriteShadowedText(Canvas, 64, 25, strRingVolume, clWhite, clBlack, [fsBold], taCenter);

            DrawShadowedShape(Canvas, 11, 59, 119, 128, clblack, clblack, clwhite);
            LoadResGraph(pic, 'DL6');
            Draw(8, 39, Pic.Graphic);
            RingLeft := 18;
            RingTop := 115;
            RingRight := 30;
            if Assigned(fContainer) then
              FillColor := fContainer.MenuBackGroundColor
            else
              FillColor := clGray;
            for i := 0 to 5 do
            begin
              DrawShape(Canvas, RingLeft, RingTop, RingRight, 123, clblack);
              if i = 4 then
                FillColor := ClWhite;
              DrawShape(Canvas, RingLeft + 1, RingTop + 1, RingRight - 1, 122, FillColor);
              Brush.Color := clSilver;
              MoveTo(RingRight, RingTop + 1);
              LineTo(RingRight, 123);
              RingLeft := RingLeft + 16;
              RingTop := RingTop - 8;
              RingRight := RingRight + 16;
            end;
            DrawSoftKeys(Canvas, strSave, '', false, false, false, false);
          end;

        pvCallContact: // Call Contact

          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            DrawStandBy(Canvas, '');
            DrawShadowedShape(Canvas, 11, 51, 117, 120, clblack, clblack, clwhite);
            LoadResGRaph(pic, 'DL0');
            Draw(8, 31, Pic.Graphic);
            Font.Size := 10;
            WriteText(Canvas, 14, 110, strMyMobile, clBlack, [fsBold], taLeftJustify);
            Font.Name := 'MS Sans Serif';
            Font.Size := 8;
            DrawSoftKeys(Canvas, strCall, strMore, false, true, false, True);
          end;

        pvForwardSMS: // forward SMS

          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            if Assigned(fContainer) then
              DrawShape(Canvas, 0, 14, 128, 37, fContainer.MenuTitleColor)
            else
              DrawShape(Canvas, 0, 14, 128, 37, clRed);
            if (Assigned(fContainer) and fImagesVisible) then
              StretchDraw(Rect(0, 14, 128, 37), fContainer.MenuTitleImage.Graphic);
            if Assigned(fContainer) then
              WriteShadowedText(Canvas, 64, 25, strForward, fContainer.MenuTitleTextColor, fContainer.MenuTitleTextShadowColor, [fsBold], taCenter)
            else
              WriteShadowedText(Canvas, 64, 25, strForward, clWhite, clBlack, [fsBold], taCenter);
            if (Assigned(fContainer) and fImagesVisible) then
              StretchDraw(Rect(0, 37, 128, 141), fContainer.MenuImage.Graphic);
            DrawShadowedShape(Canvas, 11, 59, 117, 128, clblack, clblack, clwhite);
            LoadResGRaph(pic, 'DL2');
            Draw(8, 41, Pic.Graphic);
            WriteText(Canvas, 17, 93, strNumber, clBlack, [], taLeftJustify);
            if Assigned(fContainer) then
              Pen.Color := fContainer.MenuCursorColor
            else
              Pen.Color := clBlack;
            MoveTo(17, 100);
            LineTo(17, 113);
            DrawSoftKeys(Canvas, strLookUp, '', false, false, false, False);
          end;

        pvNewSMS: // New SMS

          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            if Assigned(fContainer) then
              DrawShape(Canvas, 0, 14, 128, 37, fContainer.MenuTitleColor)
            else
              DrawShape(Canvas, 0, 14, 128, 37, clRed);
            if (Assigned(fContainer) and fImagesVisible) then
              StretchDraw(Rect(0, 14, 128, 37), fContainer.MenuTitleImage.Graphic);
            if Assigned(fContainer) then
              WriteShadowedText(Canvas, 61, 25, strWriteNew, fContainer.MenuTitleTextColor, fContainer.MenuTitleTextShadowColor, [fsBold], taCenter)
            else
              WriteShadowedText(Canvas, 61, 25, strWriteNew, clWhite, clBlack, [fsBold], taCenter);
            if (Assigned(fContainer) and fImagesVisible) then
              StretchDraw(Rect(0, 37, 128, 141), fContainer.MenuImage.Graphic);
            DrawShadowedShape(Canvas, 1, 54, 125, 138, clBlack, clblack, clwhite);
            LoadResGraph(pic, 'DL5');
            Draw(6, 39, Pic.Graphic);
            LoadResGraph(pic, 'AA0');
            Draw(52, 39, Pic.Graphic);
            if Assigned(fContainer) then
              Pen.Color := fContainer.MenuCursorColor
            else
              Pen.Color := clBlack;
            MoveTo(6, 72);
            LineTo(6, 86);
            DrawSoftKeys(Canvas, strContinue, strMore, false, false, false, true);
          end;

        pvNewNote: // New Note

          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            if Assigned(fContainer) then
              DrawShape(Canvas, 0, 14, 128, 37, fContainer.MenuTitleColor)
            else
              DrawShape(Canvas, 0, 14, 128, 37, clRed);
            if (Assigned(fContainer) and fImagesVisible) then
              StretchDraw(Rect(0, 14, 128, 37), fContainer.MenuTitleImage.Graphic);
            if Assigned(fContainer) then
              WriteShadowedText(Canvas, 61, 25, strNote, fContainer.MenuTitleTextColor, fContainer.MenuTitleTextShadowColor, [fsBold], taCenter)
            else
              WriteShadowedText(Canvas, 61, 25, strNote, clWhite, clBlack, [fsBold], taCenter);
            if (Assigned(fContainer) and fImagesVisible) then
              StretchDraw(Rect(0, 37, 128, 141), fContainer.MenuImage.Graphic);
            DrawShadowedShape(Canvas, 1, 54, 125, 138, clBlack, clblack, clwhite);
            LoadResGraph(pic, 'DL3');
            Draw(6, 39, Pic.Graphic);
            LoadResGraph(pic, 'AA0');
            Draw(52, 39, Pic.Graphic);
            if Assigned(fContainer) then
              Pen.Color := fContainer.MenuCursorColor
            else
              Pen.Color := clBlack;
            MoveTo(6, 72);
            LineTo(6, 86);
            DrawSoftKeys(Canvas, strOK, strMore, false, false, false, true);
          end;

        pvFindContact: // Find contact

          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            if Assigned(fContainer) then
              DrawShape(Canvas, 0, 14, 128, 37, fContainer.MenuTitleColor)
            else
              DrawShape(Canvas, 0, 14, 128, 37, clRed);
            if (Assigned(fContainer) and fImagesVisible) then
              StretchDraw(Rect(0, 14, 128, 37), fContainer.MenuTitleImage.Graphic);
            if Assigned(fContainer) then
              WriteShadowedText(Canvas, 64, 25, strFindContact, fContainer.MenuTitleTextColor, fContainer.MenuTitleTextShadowColor, [fsBold], taCenter)
            else
              WriteShadowedText(Canvas, 64, 25, strFindContact, clWhite, clBlack, [fsBold], taCenter);
            if (Assigned(fContainer) and fImagesVisible) then
              StretchDraw(Rect(0, 37, 128, 141), fContainer.MenuImage.Graphic);
            DrawShadowedShape(Canvas, 11, 59, 117, 128, clblack, clblack, clwhite);
            LoadResGRaph(pic, 'DL1');
            Draw(8, 41, Pic.Graphic);
            WriteText(Canvas, 17, 93, strFind, clBlack, [], taLeftJustify);
            if Assigned(fContainer) then
              Pen.Color := fContainer.MenuCursorColor
            else
              Pen.Color := clBlack;
            MoveTo(17, 100);
            LineTo(17, 113);
            DrawSoftKeys(Canvas, strOK, strMore, false, false, false, True);
          end;

        pvWapBrowser: // Draw wap browser

          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            if Assigned(fContainer) then
              DrawShape(Canvas, 0, 14, 128, 37, fContainer.MenuTitleColor)
            else
              DrawShape(Canvas, 0, 14, 128, 37, clRed);
            if (Assigned(fContainer) and fImagesVisible) then
              StretchDraw(Rect(0, 14, 128, 37), fContainer.MenuTitleImage.Graphic);
            if Assigned(fContainer) then
              WriteShadowedText(Canvas, 64, 25, strTcell, fContainer.MenuTitleTextColor, fContainer.MenuTitleTextShadowColor, [fsBold], taCenter)
            else
              WriteShadowedText(Canvas, 64, 25, strTcell, clWhite, clBlack, [fsBold], taCenter);
            DrawShape(Canvas, 0, 37, 128, 141, clwhite);
            if Assigned(fContainer) then
            begin
              DrawShape(Canvas, 123, 37, 128, 141, fContainer.MenuScrollBarFrameColor);
              DrawShape(Canvas, 124, 38, 127, 110, fContainer.MenuScrollBarBarColor);
            end
            else
            begin
              DrawShape(Canvas, 123, 37, 128, 141, clWhite);
              DrawShape(Canvas, 124, 38, 127, 110, clblack);
            end;
            if Assigned(fContainer) then
              DrawShape(Canvas, (64 - 48 div 2) - 1, 39, (64 + 48 div 2) + 1, 90, fContainer.WAPTableborderColor)
            else
              DrawShape(Canvas, (64 - 48 div 2) - 1, 39, (64 + 48 div 2) + 1, 90, $00009E);

            DrawShape(Canvas, (64 - 48 div 2), 40, (64 + 48 div 2), 89, clWhite);
            LoadResGRaph(Pic, 'WP0');
            Draw(64 - 48 div 2, 40, Pic.Graphic);
            Brush.Color := clBlue;
            DrawShape(Canvas, 64 - Canvas.TextWidth('Shubuo') div 2, 101 - Canvas.TextHeight('Shubuo') div 2, 64 + Canvas.TextWidth('Shubuo') div 2 + 2, 101 + Canvas.TextHeight('Shubuo') div 2 + 2, clBlue);
            if Assigned(fContainer) then
            begin
              WriteUnderlinedText(Canvas, 64, 101, clWhite, fContainer.WAPUnderlineColor, 'Shubuo', [], taCenter);
              WriteUnderlinedText(Canvas, 64, 119, clBlue, fContainer.WAPUnderlineColor, 'MaxiMesaj', [], taCenter);
              WriteUnderlinedText(Canvas, 64, 137, clBlue, fContainer.WAPUnderlineColor, 'TurkcellHizmetleri', [], taCenter);
            end
            else
            begin
              WriteUnderlinedText(Canvas, 64, 101, clWhite, clBlue, 'Shubuo', [], taCenter);
              WriteUnderlinedText(Canvas, 64, 119, clBlue, clBlue, 'MaxiMesaj', [], taCenter);
              WriteUnderlinedText(Canvas, 64, 137, clBlue, clBlue, 'TurkcellHizmetleri', [], taCenter);
            end;
            DrawSoftKeys(Canvas, strSelect, strMore, false, false, false, true);
          end;

        pvNotes: // Draw Notes

          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            DrawStandBy(Canvas, fOperatorName);
            if Assigned(fContainer) then
            begin
              DrawShadowedShape(Canvas, 4, 34, 124, 122, fContainer.PopupFrameShadowColor, fContainer.PopupFrameColor, fContainer.NotesBackgroundColor);
              WriteText(Canvas, 64, 80, strMyMobile + strCall, fContainer.NotesTextColor, [], taCenter);
            end
            else
            begin
              DrawShadowedShape(Canvas, 4, 34, 124, 122, clBlack, clBlack, clWhite);
              WriteText(Canvas, 64, 80, strMyMobile + strCall, clBlack, [], taCenter);
            end;
            DrawSoftKeys(Canvas, strCalls, strMore, false, false, false, true);
          end;

        pvCalendarWeek: // Draw Calendar Week

          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            if Assigned(fContainer) then
              DrawShape(Canvas, 0, 14, 128, 37, fContainer.MenuTitleColor)
            else
              DrawShape(Canvas, 0, 14, 128, 37, clRed);
            if (Assigned(fContainer) and fImagesVisible) then
              StretchDraw(Rect(0, 14, 128, 37), fContainer.MenuTitleImage.Graphic);
            if Assigned(FContainer) then
            begin
              WriteText(Canvas, 8, 25, IntToStr(WeekOftheYear(now)), fContainer.MenuTitleTextColor, [], taLeftJustify);
              WriteShadowedText(Canvas, 64, 25, FormatDateTime('dd mmm yyyy', Now), fContainer.MenuTitleTextColor, fContainer.MenuTitleTextShadowColor, [fsBold], taCenter);
            end
            else
            begin
              WriteText(Canvas, 8, 25, IntToStr(WeekOftheYear(now)), clWhite, [], taLeftJustify);
              WriteShadowedText(Canvas, 64, 25, FormatDateTime('dd mmm yyyy', Now), clWhite, clBlack, [fsBold], taCenter);
            end;
            if (Assigned(fContainer) and fImagesVisible) then
              StretchDraw(Rect(0, 37, 128, 141), fContainer.MenuImage.Graphic);
        {Draw Calendar Frame Shape}
            DrawShape(Canvas, 26, 53, 124, 141, clblack);
        { Draw Calendar Fill Shape }
            DrawShape(Canvas, 27, 54, 123, 141, clwhite);
            pen.Color := clSilver;
            Brush.Style := bsClear;
            MoveTo(40, 54);
            LineTo(40, 141);
            MoveTo(54, 54);
            LineTo(54, 141);
            MoveTo(68, 54);
            LineTo(68, 141);
            MoveTo(82, 54);
            LineTo(82, 141);
            MoveTo(96, 54);
            LineTo(96, 141);
            MoveTo(110, 54);
            LineTo(110, 141);

            MoveTo(27, 61);
            LineTo(123, 61);
            MoveTo(27, 69);
            LineTo(123, 69);
            MoveTo(27, 77);
            LineTo(123, 77);
            MoveTo(27, 85);
            LineTo(123, 85);
            MoveTo(27, 93);
            LineTo(123, 93);
            MoveTo(27, 101);
            LineTo(123, 101);
            MoveTo(27, 109);
            LineTo(123, 109);
            MoveTo(27, 117);
            LineTo(123, 117);
            MoveTo(27, 125);
            LineTo(123, 125);
            MoveTo(27, 133);
            LineTo(123, 133);
            MoveTo(27, 141);
            LineTo(123, 141);
            WriteCalendarDays(Canvas, 23, 45, 4, [strMo, strTu, strWe, strTh, strFr, strSa, strSu], true);
            Font.Name := 'Times New Roman';
            Font.Size := 7;
            if Assigned(fContainer) then
            begin
              WriteText(Canvas, 4, 57, '08', fContainer.MenuTextColor, [], taLeftJustify);
              WriteText(Canvas, 16, 55, 'oo', fContainer.MenuTextColor, [], taLeftJustify);
              WriteText(Canvas, 12, 64, '-', fContainer.MenuTextColor, [], taLeftJustify);
              WriteText(Canvas, 4, 73, '10', fContainer.MenuTextColor, [], taLeftJustify);
              WriteText(Canvas, 16, 71, 'oo', fContainer.MenuTextColor, [], taLeftJustify);
              WriteText(Canvas, 12, 80, '-', fContainer.MenuTextColor, [], taLeftJustify);
              WriteText(Canvas, 4, 88, '12', fContainer.MenuTextColor, [], taLeftJustify);
              WriteText(Canvas, 16, 86, 'oo', fContainer.MenuTextColor, [], taLeftJustify);
              WriteText(Canvas, 12, 95, '-', fContainer.MenuTextColor, [], taLeftJustify);
              WriteText(Canvas, 4, 104, '14', fContainer.MenuTextColor, [], taLeftJustify);
              WriteText(Canvas, 16, 102, 'oo', fContainer.MenuTextColor, [], taLeftJustify);
              WriteText(Canvas, 12, 111, '-', fContainer.MenuTextColor, [], taLeftJustify);
              WriteText(Canvas, 4, 120, '16', fContainer.MenuTextColor, [], taLeftJustify);
              WriteText(Canvas, 16, 118, 'oo', fContainer.MenuTextColor, [], taLeftJustify);
              WriteText(Canvas, 12, 127, '-', fContainer.MenuTextColor, [], taLeftJustify);
              WriteText(Canvas, 4, 136, '18', fContainer.MenuTextColor, [], taLeftJustify);
              WriteText(Canvas, 16, 134, 'oo', fContainer.MenuTextColor, [], taLeftJustify);
            end
            else
            begin
              WriteText(Canvas, 4, 57, '08', clBlack, [], taLeftJustify);
              WriteText(Canvas, 16, 55, 'oo', clBlack, [], taLeftJustify);
              WriteText(Canvas, 12, 64, '-', clBlack, [], taLeftJustify);
              WriteText(Canvas, 4, 73, '10', clBlack, [], taLeftJustify);
              WriteText(Canvas, 16, 71, 'oo', clBlack, [], taLeftJustify);
              WriteText(Canvas, 12, 80, '-', clBlack, [], taLeftJustify);
              WriteText(Canvas, 4, 88, '12', clBlack, [], taLeftJustify);
              WriteText(Canvas, 16, 86, 'oo', clBlack, [], taLeftJustify);
              WriteText(Canvas, 12, 95, '-', clBlack, [], taLeftJustify);
              WriteText(Canvas, 4, 104, '14', clBlack, [], taLeftJustify);
              WriteText(Canvas, 16, 102, 'oo', clBlack, [], taLeftJustify);
              WriteText(Canvas, 12, 111, '-', clBlack, [], taLeftJustify);
              WriteText(Canvas, 4, 120, '16', clBlack, [], taLeftJustify);
              WriteText(Canvas, 16, 118, 'oo', clBlack, [], taLeftJustify);
              WriteText(Canvas, 12, 127, '-', clBlack, [], taLeftJustify);
              WriteText(Canvas, 4, 136, '18', clBlack, [], taLeftJustify);
              WriteText(Canvas, 16, 134, 'oo', clBlack, [], taLeftJustify);
            end;
            Canvas.Font.Name := 'MS Sans Serif';
            Font.Size := 8;
            DrawSoftKeys(Canvas, strSelect, strMore, false, false, false, true);
          end;

        pvCalendarMonth: // Calendar month

          begin
            ci := 0;
            cj := 1;
            DayOfMonth := DayOfTheMonth(Now);
            MonthOfYear := MonthOfTheYear(Now);
            WeekOfYear := WeekOfTheYear(Now);
            MonthStr := FormatDateTime('mmm yyyy', Now);
            StrList := TStringList.Create;
            Cal := TCalendar.Create(nil);
            Cal.StartOfWeek := 1;
            Cal.Month := MonthOfYear;
            repeat
              repeat
                StrList.Add(Cal.CellText[ci, cj]);
                ci := ci + 1;
              until ci = 7;
              cj := cj + 1;
              ci := 0;
            until cj = 7;
            Cal.Free;
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            if Assigned(fContainer) then
              DrawShape(Canvas, 0, 14, 128, 37, fContainer.MenuTitleColor)
            else
              DrawShape(Canvas, 0, 14, 128, 37, clRed);
            if (Assigned(fContainer) and fImagesVisible) then
              StretchDraw(Rect(0, 14, 128, 37), fContainer.MenuTitleImage.Graphic);
            if Assigned(fContainer) then
            begin
              WriteText(Canvas, 8, 25, IntToStr(WeekOfYear), fContainer.MenuTitleTextColor, [], taLeftJustify);
              WriteShadowedText(Canvas, 64, 25, MonthStr, fContainer.MenuTitleTextColor, fContainer.MenuTitleTextShadowColor, [fsBold], taCenter);
            end
            else
            begin
              WriteText(Canvas, 8, 25, IntToStr(WeekOfYear), clWhite, [], taLeftJustify);
              WriteShadowedText(Canvas, 64, 25, MonthStr, clWhite, clBlack, [fsBold], taCenter);
            end;
            if (Assigned(fContainer) and fImagesVisible) then
              StretchDraw(Rect(0, 37, 128, 141), fContainer.MenuImage.Graphic);
        {Draw Calendar Frame Shape}
            DrawShape(Canvas, 4, 52, 124, 137, clBlack);
        {Draw Calendar Fill Shape}
            DrawShape(Canvas, 5, 53, 123, 136, clWhite);
            canvas.pen.Color := clSilver;
        {calendar grid verical lines}
            Canvas.MoveTo(21, 53);
            canvas.LineTo(21, 136);
            Canvas.MoveTo(38, 53);
            canvas.LineTo(38, 136);
            Canvas.MoveTo(55, 53);
            canvas.LineTo(55, 136);
            Canvas.MoveTo(72, 53);
            canvas.LineTo(72, 136);
            Canvas.MoveTo(89, 53);
            canvas.LineTo(89, 136);
            Canvas.MoveTo(106, 53);
            canvas.LineTo(106, 136);
        {Calendar Grid Horizontal lines}
            Canvas.MoveTo(5, 66);
            canvas.LineTo(123, 66);
            Canvas.MoveTo(5, 80);
            canvas.LineTo(123, 80);
            Canvas.MoveTo(5, 94);
            canvas.LineTo(123, 94);
            Canvas.MoveTo(5, 108);
            canvas.LineTo(123, 108);
            Canvas.MoveTo(5, 122);
            canvas.LineTo(123, 122);
            WriteCalendarDays(Canvas, 0, 45, 7, [strMo, strTu, strWe, strTh, strFr, strSa, strSu], false);
            Canvas.Font.Style := [];
            cx := 1;
            cy := 0;
            for cz := 0 to 41 do
            begin
              Canvas.Font.Color := clBlack;
              canvas.Textout(17 * cx - canvas.TextWidth(strList[cz]) + 2, 59 + (14 * cy) - canvas.TextHeight(strList[cz]) div 2, strList[cz]);
              if StrList[cz] = IntTostr(DayOfMonth) then
              begin
                Canvas.Brush.Color := clBlack;
                Canvas.Pen.Style := psClear;
                Canvas.Font.Color := clWhite;
                Canvas.Brush.Style := bsSolid;
                cX1 := 17 * cx - 12;
                cY1 := 59 + (14 * cy) - TextHeight(strList[cz]) div 2;
                Canvas.RoundRect(cX1, cY1, cX1 + 17, cY1 + 14, 1, 1);
                Canvas.Brush.Style := bsClear;
                Canvas.Font.Color := clWhite;
                Textout(17 * cx - canvas.TextWidth(strList[cz]) + 2, 59 + (14 * cy) - canvas.TextHeight(strList[cz]) div 2, strList[cz]);
                Pen.Style := psSolid;
                Pen.Color := clBlack;
              end;
              cx := cx + 1;
              if cx > 7 then
              begin
                cy := cy + 1;
                cx := 1;
              end;
            end;
            StrList.Free;
            Font.Style := [fsBold];
            DrawSoftKeys(Canvas, strSelect, strMore, false, false, false, true);
          end;

        pvSoftKeysDisable: // Draw soft keys1

          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            DrawMenuWithIcon('CB', 2, '', 0, Canvas, strContactInfo, 0, [strName, strHome, strWork, strMobile, strFax, strOther], 0, clblack, clblack);
            DrawSoftKeys(Canvas, strUnCheck, strOK, true, false, true, true);
          end;

        pvSoftKeysEnable: // Draw softkeys 2

          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            DrawMenuWithIcon('IC3', 2, '', 0, Canvas, strSIMArchive, Random(6), [strContact_7, strContact_8, strMyMobile, strContact_9, strContact_10, strContact_11], -1, clblack, clblack);
            DrawSoftKeys(Canvas, strRead, strMore, false, false, false, True);
          end;

        pvPopupSelected: // Draw popup selected

          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            DrawMenu(Canvas, strThemes, 1, ['', '', '', '', '', ''], 3, clblack, clblack, True);
            DrawPopUpMenu(Canvas, strMore, 3, [strSend, strDelete, strRename, strThemeInf, strMemoryStat], 1, clblack, clblack);
            DrawSoftKeys(Canvas, strSelect, '', false, false, false, false);
          end;

        pvPopUpDisableSelected: // Draw popup disable selected

          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            DrawMenu(Canvas, strMySounds, 1, ['', '', '', '', '', ''], 3, clblack, clblack, True);
            DrawPopUpMenu(Canvas, strMore, 1, [strSetAsRingSignal, strEdit, strSend, strDelete, strRename], 1, clblack, clblack);
            DrawSoftKeys(Canvas, strSelect, '', false, false, false, false);
          end;

        pvSMSSended: // Draw SMS Sended

          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            DrawMenu(Canvas,
              strWriteNew, 0,
              ['', '', '', '', '', ''], 1, clblack, clblack, True);
            if Assigned(fContainer) then
              DrawShadowedShape(Canvas, 4, 25, 124, 135, fContainer.PopupFrameShadowColor, fContainer.PopupFrameColor, fContainer.PopupMenuBackgroundColor)
            else
              DrawShadowedShape(Canvas, 4, 25, 124, 135, clBlack, clBlack, clMaroon);
            LoadResGraph(Pic, 'MS1');
            Canvas.Draw(32, 40, Pic.Graphic);
            if Assigned(fContainer) then
              WriteText(Canvas, 64, 110, strMsgSended, fContainer.PopupMenuTextColor, [fsBold], taCenter)
            else
              WriteText(Canvas, 64, 110, strMsgSended, clWhite, [fsBold], taCenter);
            DrawSoftKeys(Canvas, strOK, '', false, false, false, false);
          end;

        pvSilentMode: // Draw SMS Sended

          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            DrawStandBy(Canvas, fOperatorName);
            if Assigned(fContainer) then
              DrawShadowedShape(Canvas, 4, 25, 124, 135, fContainer.PopupFrameShadowColor, fContainer.PopupFrameColor, fContainer.PopupMenuBackgroundColor)
            else
              DrawShadowedShape(Canvas, 4, 25, 124, 135, clBlack, clBlack, clMaroon);
            LoadResGraph(Pic, 'SM1');
            Canvas.Draw(6, 24, Pic.Graphic);
            DrawSoftKeys(Canvas, '', '', false, false, false, true);
          end;

        pvShowPicture: //Draw Wallpaper

          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            DrawMenu(Canvas, strWallpaper, 0, ['', '', '', '', '', ''], -1, clblack, clblack, False);
            if Assigned(fContainer) then
              DrawShadowedShape(Canvas, 4, 25, 124, 135, fContainer.PopupFrameShadowColor, fContainer.PopupFrameColor, fContainer.PopupMenuBackgroundColor)
            else
              DrawShadowedShape(Canvas, 4, 25, 124, 135, clBlack, clBlack, clMaroon);
            LoadResGraph(Pic, 'WL' + InttoStr(Random(10)));
            Canvas.Draw(9, 30, Pic.Graphic);
            if Assigned(fContainer) then
              WriteOutLinedText(Canvas, 64 - Canvas.TextWidth(strAccept) div 2, 121, strAccept, fContainer.PopupMenuTextColor, fContainer.PopupMenuBackgroundColor, [fsBold])
            else
              WriteOutLinedText(Canvas, 64 - Canvas.TextWidth(strAccept) div 2, 121, strAccept, clWhite, clBlack, [fsBold]);
            DrawSoftKeys(Canvas, strYes, strNo, false, false, false, True);
          end;

        pvSendSMS: // Draw send SMS

          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            if Assigned(fContainer) then
            begin
              DrawMenu(Canvas, strWriteNew, 0, ['', '', '', '', '', ''], 3, fContainer.MenuPromptColor, fContainer.MenuCursorColor, true);
              DrawShadowedShape(Canvas, 4, 25, 124, 135, fContainer.PopupFrameShadowColor, fContainer.PopupFrameColor, fContainer.PopupMenuBackgroundColor);
              DrawShape(Canvas, 9, 118, 119, 131, fContainer.PopupMenuTextColor);
              DrawShape(Canvas, 10, 119, 118, 130, fContainer.PopupTitleTextColor);
              DrawShape(Canvas, 20, 120, 56, 129, fContainer.PopupTitleBackGroundColor);
            end
            else
            begin
              DrawMenu(Canvas, strWriteNew, 0, ['', '', '', '', '', ''], 3, clBlack, clblack, true);
              DrawShadowedShape(Canvas, 4, 25, 124, 135, clBlack, clBlack, clMaroon);
              DrawShape(Canvas, 9, 118, 119, 131, clWhite); //popup progressbarBGframe shape
              DrawShape(Canvas, 10, 119, 118, 130, clWhite); //popup progressbarBG shape
              DrawShape(Canvas, 20, 120, 56, 129, clBlue);
            end;
            LoadResGraph(pic, 'MS0');
            Canvas.Draw(32, 40, Pic.Graphic);
            if Assigned(fContainer) then
            begin
              WriteText(Canvas, 64, 90, strSendingMsg, fContainer.PopupMenuTextColor, [fsBold], taCenter);
              WriteText(Canvas, 64, 106, strMyMobile, fContainer.fPopUpMenuTextColor, [fsBold], taCenter);
            end
            else
            begin
              WriteText(Canvas, 64, 90, strSendingMsg, clWhite, [fsBold], taCenter);
              WriteText(Canvas, 64, 106, strMyMobile, clWhite, [fsBold], taCenter);
            end;
            DrawSoftKeys(Canvas, '', strCancel, false, false, false, True);
          end;

        pvMenuSelected: //Draw menu Selected

          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            DrawMenu(Canvas, strSMS, 1, [strWriteNew, strInbox, strSIMArchive + ':(6)', strUnSentItems, strTemplates, strSentItems], 3, clblack, clblack, True);
            DrawSoftKeys(Canvas, strSelect, '', false, false, false, false);
          end;

        pvMenuDisableSelected: //Draw menu disable selected

          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            DrawMenu(Canvas, strCalls, 0, [strMissedCalls, strCallList, strDivertCalls, strManageCalls, strTimeAndCost, strNextCall], 0, clblack, clblack, TRue);
            DrawSoftKeys(Canvas, strSelect, strInfo, false, false, false, True);
          end;

        pvCallsList: // DRaw CAll list random

          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            DrawMenuWithIcon('IC1', 3, 'IC4', 3, Canvas, strCallList, Random(6), [strContact_1, strContact_2, strContact_3, strContact_4, strContact_5, strContact_6], -1, clblack, clblack);
            DrawSoftKeys(Canvas, strCall, strMore, false, false, false, True);
          end;

        pvMySounds: //Draw mysound list
          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            DrawMenuWithIcon('SN', 1, '', 0, Canvas, strMySounds, Random(6), [strRing_1, strRing_2, strRing_3, strRing_4, strRing_5, strRing_6], -1, clblack, clblack);
            DrawSoftKeys(Canvas, strPlay, strMore, false, false, false, True);
          end;

        pvDesktop: // DRaw desktop
          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            DrawDesktop(Canvas, [strSE, strInternetServices, strMyShortCuts, strCamera, strMessaging, strEntertainment, strPicturesAndSounds, strPhoneBook, strCalls, strConnectivity, strOrganizer, strSettings]);
            DrawSoftKeys(Canvas, strSelect, '', false, false, false, false);
          end;

        pvStandBy: // Draw standBy
          begin
            DrawBackGround(Canvas);
            DrawStatusBar(Canvas);
            DrawStandBy(Canvas, fOperatorName);
            DrawSoftKeys(Canvas, strCalls, strMore, false, true, false, true);
          end;
      end;
    end;
  end;
  Pic.Free;
  fScreenBitmap.Canvas.CopyMode := cmSrcCopy;
  fViewer.Canvas.Draw(0, 0, fScreenBitmap);
  inherited;
end;

procedure TOKTThemeViewer.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = fContainer) then
    ThemeContainer := nil;
end;

procedure TOKTThemeViewer.ResizeCanvas;
begin
  Width := 140;
  Height := 172;
end;

procedure TOKTThemeViewer.SetPreView(Value: TOKTPreview);
begin
  fpreview := Value;
  InitializePreview;
end;

procedure TOKTThemeViewer.SetLanguage(Language: TThemeLanguage);
begin
  fLanguage := Language;
  InitializePreview;
end;

procedure TOKTThemeViewer.SetOperator(Value: string);
begin
  fOperatorName := Value;
  InitializePreview;
end;

procedure TOKTThemeViewer.SetImagesVisible(const Value: Boolean);
begin
  if Value <> fImagesVisible then
  begin
    fImagesVisible := Value;
  end;
  InitializePreview;
end;

procedure TOKTThemeViewer.SetThemeContainer(Container: TOKTThemeContainer);
begin
  if Container = fContainer then
    exit;
  if fContainer <> nil then
    fContainer.UnRegisterChanges(FContainerLink);
  fContainer := Container;
  if fContainer <> nil then
  begin
    fContainer.RegisterChanges(FContainerLink);
    fContainer.FreeNotification(Self);
  end;
  InitializePreview;
end;

procedure TOKTThemeViewer.GetThemeChange(Sender: TObject);
begin
  InitializePreview;
end;

procedure TOKTThemeViewer.DrawBackGround(Canvas: TCanvas);
begin
  if Assigned(fContainer) then
    DrawShape(Canvas, 0, 0, 128, 160, fContainer.MenuBackGroundColor)
  else
    DrawShape(Canvas, 0, 0, 128, 160, clGray);
end;

procedure TOKTThemeViewer.DrawStatusBar(Canvas: TCanvas);
var
  Picture: TPicture;
  ResName: string;
  X: Integer;
begin
  Picture := TPicture.Create;
  with Canvas do
  begin
   // property Statusbarimage
    if (Assigned(fContainer) and fImagesVisible) then
      Draw(0, 0, fContainer.StatusBarImage.Graphic);
   //random batery level
    ResName := 'BT' + InttoStr(Random(11));
    LoadResGraph(Picture, ResName);
    Draw(109, 2, Picture.Graphic);
   //random GPRS level
    ResName := 'GP' + InttoStr(Random(2));
    LoadResGraph(Picture, ResName);
    Draw(1, 1, Picture.Graphic);
   //random signal level
    ResName := 'RC' + InttoStr(Random(6));
    LoadResGraph(Picture, ResName);
    Draw(1, 5, Picture.Graphic);
   //random missed,unread,null,silent
    ResName := 'SI2' + InttoStr(Random(4));
    LoadResGraph(Picture, ResName);
    Draw(19, 0, Picture.Graphic);
   //random null,bluetooth,IR
    if ResName = 'SI22' then
      X := 19
    else
      X := 34;
    ResName := 'SI1' + InttoStr(Random(2));
    LoadResGraph(Picture, ResName);
    Draw(X, 0, Picture.Graphic); //random null,bluetooth,IR
  end;
  Picture.Free;
end;

procedure TOKTThemeViewer.DrawSoftKeys(Canvas: TCanvas; LeftText, RightText: string; Activated, Navigator, Disabled, RightVisible: Boolean);
var
  Picture: TPicture;
begin
  Picture := TPicture.Create;
  with canvas do
  begin
    LoadResGraph(Picture, 'JY0');
    if Assigned(fContainer) then
      DrawShape(Canvas, 2, 143, 63, 158, fContainer.SoftKeysBackgroundColor)
    else
      DrawShape(Canvas, 2, 143, 63, 158, clSilver); //SoftKeys Shape 1
    if RightVisible then
    begin
      if Activated then
        if Assigned(fContainer) then
          DrawShape(Canvas, 65, 143, 126, 158, fContainer.SoftKeysBackGroundActivatedColor)
        else
          DrawShape(Canvas, 65, 143, 126, 158, clWhite)
      else
        if Assigned(fContainer) then
          DrawShape(Canvas, 65, 143, 126, 158, fContainer.SoftKeysBackgroundColor)
        else
          DrawShape(Canvas, 65, 143, 126, 158, clSilver); //SoftKeys Shape 2
    end;
    if (Assigned(fContainer) and fImagesVisible) then
      Draw(0, 141, fContainer.SoftKeysImage.Graphic); // Softkeys image
    if navigator then
      Canvas.Draw(59, 145, Picture.Graphic);
    if disabled then
      if Assigned(fContainer) then
        WriteShadowedText(Canvas, 2, 150, LeftText, fContainer.SoftKeysTextDisabledColor, fContainer.SoftkeysTextDisabledShadowColor, [fsBold], taLeftJustify)
      else
        WriteShadowedText(Canvas, 2, 150, LeftText, clSilver, clGray, [fsBold], taLeftJustify)
    else
      if Assigned(fContainer) then
        WriteShadowedText(Canvas, 2, 150, LeftText, fContainer.SoftkeysTextColor, fContainer.SoftkeysTextShadowColor, [fsBold], taLeftJustify)
      else
        WriteShadowedText(Canvas, 2, 150, LeftText, clWhite, clBlack, [fsBold], taLeftJustify);
    if RightVisible then
      if Assigned(fContainer) then
        WriteShadowedText(Canvas, 125, 150, RightText, fContainer.SoftkeysTextColor, fContainer.SoftkeysTextShadowColor, [fsBold], taRightJustify)
      else
        WriteShadowedText(Canvas, 125, 150, RightText, clWhite, clBlack, [fsBold], taRightJustify);
  end;
  Picture.Free;
end;

procedure TOKTThemeViewer.WriteCalendarDays(Canvas: TCanvas; X, Y, Delta: Integer; Days: array of string; IsWeek: Boolean);
var
  S: string;
begin
  Canvas.Brush.Style := bsClear;
  Canvas.Font.Style := [];
  if Assigned(fContainer) then
    Canvas.Font.Color := fContainer.MenuTextColor
  else
    Canvas.Font.Color := clBlack;
  Canvas.Textout((Delta + 10) * 1 - Canvas.TextWidth('W') + X + 3, Y - Canvas.TextHeight('W') div 2, Days[0]);
  Canvas.Textout((Delta + 10) * 2 - Canvas.TextWidth('W') + X + 3, Y - Canvas.TextHeight('W') div 2, Days[1]);
  Canvas.Textout((Delta + 10) * 3 - Canvas.TextWidth('W') + X + 3, Y - Canvas.TextHeight('W') div 2, Days[2]);
  Canvas.Textout((Delta + 10) * 4 - Canvas.TextWidth('W') + X + 3, Y - Canvas.TextHeight('W') div 2, Days[3]);
  Canvas.Textout((Delta + 10) * 5 - Canvas.TextWidth('W') + X + 3, Y - Canvas.TextHeight('W') div 2, Days[4]);
  if Assigned(fContainer) then
    Canvas.Font.Color := fContainer.CalendarWeekendColor
  else
    Canvas.Font.Color := clred;
  Canvas.Textout((Delta + 10) * 6 - Canvas.TextWidth('W') + X + 3, Y - Canvas.TextHeight('W') div 2, Days[5]);
  Canvas.Textout((Delta + 10) * 7 - Canvas.TextWidth('W') + X + 3, Y - Canvas.TextHeight('W') div 2, Days[6]);
  if IsWeek then
  begin
    if Assigned(fContainer) then
      Canvas.Brush.Color := fContainer.CalendarHighLightColor
    else
      Canvas.Brush.Color := $FF80FF;
    Canvas.Pen.Style := psClear;
    if Assigned(fContainer) then
      Canvas.Font.Color := fContainer.CalendarHighlightTextColor
    else
      Canvas.Font.Color := clWhite;
    Canvas.Brush.Style := bsSolid;
    Canvas.RoundRect((Delta + 10) * (DayOftheWeek(Now) - 1) + X + 6, Y - 6, (Delta + 10) * DayOftheWeek(Now) + X + 3, Y + 8, 2, 2);
    case DayOftheWeek(Now) of
      1: S := Days[0];
      2: S := Days[1];
      3: S := Days[2];
      4: S := Days[3];
      5: S := Days[4];
      6: S := Days[4];
      7: S := Days[6];
    end;
    Canvas.Brush.Style := bsClear;
    Canvas.Textout((Delta + 10) * DayOftheWeek(Now) - Canvas.TextWidth(Days[0]) + X, Y - Canvas.TextHeight(S) div 2, S);
    Canvas.Pen.Style := psSolid;
  end;
  Canvas.Brush.Style := bsClear;
end;

procedure TOKTThemeViewer.DrawMenu(Canvas: TCanvas; Title: string; HighLightIndex: Integer; MenuItems: array of string; MenuItemsDisabledIndex: Integer; MenuPromptColor: TColor; MenuCursorColor: TColor; Scrollbar: Boolean);
const
  Text_X: integer = 6;
var
  i: integer;
  Text_Y: Integer;
  Highlight_IDX: Integer;
begin
  HighLight_IDX := 41;
 {Create Menu image 128 X 104 }
  if (Assigned(fContainer) and fImagesVisible) then
    Canvas.StretchDraw(Rect(0, 37, 128, 141), fContainer.MenuImage.Graphic);

 { draw Title Rect caption and Title image 128 X 23 }
  if Assigned(fContainer) then
    DrawShape(Canvas, 0, 14, 128, 37, fContainer.MenuTitleColor)
  else
    DrawShape(Canvas, 0, 14, 128, 37, clRed);
  if (Assigned(fContainer) and fImagesVisible) then
    Canvas.StretchDraw(Rect(0, 14, 128, 37), fContainer.MenuTitleImage.Graphic);
  if Assigned(fContainer) then
    WriteShadowedText(Canvas, 64, 24, Title, fContainer.MenuTitleTextColor, fContainer.MenuTitleTextShadowColor, [fsBold], taCenter)
  else
    WriteShadowedText(Canvas, 64, 24, Title, clWhite, clBlack, [fsBold], taCenter);
 { Draw Menu Highlight Rect and image 123 X 16}
  if HighLightIndex > 0 then
    HighLight_IDX := HighLight_IDX + (HighLightIndex * 16);
  if Assigned(fContainer) then
    DrawShape(Canvas, 0, HighLight_IDX, 123, HighLight_IDX + 16, fContainer.MenuHighlightColor)
  else
    DrawShape(Canvas, 0, HighLight_IDX, 123, HighLight_IDX + 16, clGreen);
  if (Assigned(fContainer) and fImagesVisible) then
    Canvas.StretchDraw(Rect(0, HighLight_IDX, 123, HighLight_IDX + 16), fContainer.MenuHighlightImage.Graphic);

 { Draw ScrollBar Rects}
  if ScrollBar then
  begin
    if Assigned(fContainer) then
    begin
      DrawShape(Canvas, 123, 37, 128, 141, fContainer.MenuScrollBarFrameColor);
      if HighLightIndex >= 4 then
        DrawShape(Canvas, 124, 78, 127, 140, fContainer.MenuScrollBarBarColor)
      else
        DrawShape(Canvas, 124, 38, 127, 100, fContainer.MenuScrollBarBarColor);
    end
    else
    begin
      DrawShape(Canvas, 123, 37, 128, 141, clWhite);
      if HighLightIndex >= 4 then
        DrawShape(Canvas, 124, 78, 127, 140, clBlack)
      else
        DrawShape(Canvas, 124, 38, 127, 100, clBlack);

    end;
  end;
  Text_Y := 48;
  for i := 0 to high(MenuItems) do
  begin
    if Assigned(fContainer) then
      Canvas.Font.Color := fContainer.MenuTextColor
    else
      Canvas.Font.Color := clWhite;
    if i = MenuItemsDisabledIndex then
      if Assigned(fContainer) then
        Canvas.Font.Color := fContainer.MenuTextDisabledColor
      else
        Canvas.Font.Color := clSilver;

    if (i = HighLightIndex) and (i <> MenuItemsDisabledIndex) then
      if Assigned(fContainer) then
        Canvas.Font.Color := fContainer.MenuHighlightTextColor
      else
        Canvas.Font.Color := clblack;
    if (i = HighLightIndex) and (i = MenuItemsDisabledIndex) then
      if Assigned(fContainer) then
        Canvas.Font.Color := fContainer.MenuHighlightTextDisabledColor
      else
        Canvas.Font.Color := clGray;

    Canvas.Brush.Style := bsClear;
    Canvas.TextOut(Text_X, Text_Y - canvas.TextHeight(MenuItems[i]) div 2, MenuItems[i]);
    Text_Y := Text_Y + 16;
  end;
end;

procedure TOKTThemeViewer.DrawMenuWithIcon(Icon_A_Name: string; Icon_a_Idx: Word; Icon_B_Name: string; Icon_B_Idx: Word; Canvas: TCanvas; Title: string; HighLightIndex: Integer; MenuItems: array of string; MenuItemsDisabledIndex: Integer; MenuPromptColor: TColor; MenuCursorColor: TColor);
var
  i: integer;
  Text_X, Text_Y: Integer;
  Highlight_IDX: Integer;
  Icon_a, Icon_b: TPicture;
begin
  Icon_a := TPicture.Create;
  Icon_b := TPicture.Create;
  Canvas.Font.Style := [fsBold];
  HighLight_IDX := 41;
 {Create Menu image 128 X 104 }
  if (Assigned(fContainer) and fImagesVisible) then
    Canvas.StretchDraw(Rect(0, 37, 128, 141), fContainer.MenuImage.Graphic);

 { draw Title Rect caption and Title image 128 X 23 }
  if Assigned(fContainer) then
    DrawShape(Canvas, 0, 14, 128, 37, fContainer.MenuTitleColor)
  else
    DrawShape(Canvas, 0, 14, 128, 37, clRed);
  if (Assigned(fContainer) and fImagesVisible) then
    Canvas.StretchDraw(Rect(0, 14, 128, 37), fContainer.MenuTitleImage.Graphic);
  if Assigned(fContainer) then
    WriteShadowedText(Canvas, 64, 25, Title, fContainer.MenuTitleTextColor, fContainer.MenuTitleTextShadowColor, [fsBold], taCenter)
  else
    WriteShadowedText(Canvas, 64, 25, Title, clWhite, clBlack, [fsBold], taCenter);
 { Draw Menu Highlight Rect and image 123 X 16}
  if HighLightIndex > 0 then
    HighLight_IDX := HighLight_IDX + (HighLightIndex * 16);
  if Assigned(fContainer) then
    DrawShape(Canvas, 0, HighLight_IDX, 123, HighLight_IDX + 16, fContainer.MenuHighlightColor)
  else
    DrawShape(Canvas, 0, HighLight_IDX, 123, HighLight_IDX + 16, clGreen);
  if (Assigned(fContainer) and fImagesVisible) then
    Canvas.StretchDraw(Rect(0, HighLight_IDX, 123, HighLight_IDX + 16), fContainer.MenuHighlightImage.Graphic);

  Text_Y := 48;
  for i := 0 to high(MenuItems) do
  begin
    LoadResGraph(Icon_a, Icon_A_Name + Inttostr(Random(Icon_A_Idx)));
    if Icon_b_Name <> '' then
      LoadResGraph(Icon_b, Icon_b_Name + Inttostr(Random(Icon_b_Idx)));
    if Assigned(fContainer) then
      Canvas.Font.Color := fContainer.MenuTextColor
    else
      Canvas.Font.Color := clWhite;
    if i = MenuItemsDisabledIndex then
      if Assigned(fContainer) then
        Canvas.Font.Color := fContainer.MenuTextDisabledColor
      else
        Canvas.Font.Color := clSilver;
    if (i = HighLightIndex) and (i <> MenuItemsDisabledIndex) then
      if Assigned(fContainer) then
        Canvas.Font.Color := fContainer.MenuHighlightTextColor
      else
        Canvas.Font.Color := clblack;
    if (i = HighLightIndex) and (i = MenuItemsDisabledIndex) then
      if Assigned(fContainer) then
        Canvas.Font.Color := fContainer.MenuHighlightTextDisabledColor
      else
        Canvas.Font.Color := clGray;
    Canvas.Brush.Style := bsClear;
    if Icon_b_Name <> '' then
      Text_X := 32
    else
      Text_X := 16;
    Canvas.TextOut(Text_X, Text_Y - canvas.TextHeight(MenuItems[i]) div 2, MenuItems[i]);
    Canvas.Draw(0, Text_Y - 16 div 2, Icon_a.Graphic);
    if Icon_b_Name <> '' then
      Canvas.Draw(15, Text_Y - 16 div 2, Icon_b.Graphic);
    Text_Y := Text_Y + 16;
  end;
 { Draw ScrollBar Rects}
  if Assigned(fContainer) then
  begin
    DrawShape(Canvas, 123, 37, 128, 141, fContainer.MenuScrollBarFrameColor);
    if HighLightIndex >= 4 then
      DrawShape(Canvas, 124, 78, 127, 140, fContainer.MenuScrollBarBarColor)
    else
      DrawShape(Canvas, 124, 38, 127, 100, fContainer.MenuScrollBarBarColor);
  end
  else
  begin
    DrawShape(Canvas, 123, 37, 128, 141, clWhite);
    if HighLightIndex >= 4 then
      DrawShape(Canvas, 124, 78, 127, 140, clBlack)
    else
      DrawShape(Canvas, 124, 38, 127, 100, clBlack);
  end;

  Icon_a.Free;
  Icon_b.Free;
end;

procedure TOKTThemeViewer.DrawPopUpMenu(Canvas: TCanvas; Title: string; HighLightIndex: Integer; MenuItems: array of string; MenuItemsDisabledIndex: Integer; MenuPromptColor: TColor; MenuCursorColor: TColor);
const
  Text_X: integer = 11;
var
  i: integer;
  Text_Y: Integer;
  Highlight_IDX: Integer;
begin
  Canvas.Font.Style := [fsBold];
  HighLight_IDX := 52;
  if Assigned(fContainer) then
    DrawShadowedShape(Canvas, 4, 25, 124, 135, fContainer.PopupFrameShadowColor, fContainer.PopupFrameColor, fContainer.PopupMenuBackgroundColor)
  else
    DrawShadowedShape(Canvas, 4, 25, 124, 135, clBlack, clBlack, clMaroon);
 { draw Title Rect caption and Title image 128 X 23 }
  if Assigned(fContainer) then
    DrawShape(Canvas, 5, 26, 123, 49, fContainer.PopupTitleBackGroundColor)
  else
    DrawShape(Canvas, 5, 26, 123, 49, clBlue);
  if (Assigned(fContainer) and fImagesVisible) then
    Canvas.StretchDraw(Rect(5, 26, 123, 49), fContainer.PopUpTitleImage.Graphic);
  if Assigned(fContainer) then
    WriteShadowedText(Canvas, 61, 37, Title, fContainer.PopupTitleTextColor,
      fContainer.PopupTitleTextShadowColor, [fsBold], taCenter)
  else
    WriteShadowedText(Canvas, 61, 37, Title, clWhite,
      clBlack, [fsBold], taCenter);

 { Draw Menu Highlight Rect and image 123 X 16}
  if HighLightIndex > 0 then
    HighLight_IDX := HighLight_IDX + (HighLightIndex * 16);
  if Assigned(fContainer) then
    DrawShape(Canvas, 5, HighLight_IDX, 118, HighLight_IDX + 16, fContainer.PopupHighlightColor)
  else
    DrawShape(Canvas, 5, HighLight_IDX, 118, HighLight_IDX + 16, $1E396C);
  if (Assigned(fContainer) and fImagesVisible) then
    Canvas.StretchDraw(Rect(5, HighLight_IDX, 118, HighLight_IDX + 16), fContainer.PopUpHighLightImage.Graphic);

 { Draw ScrollBar Rects}
  if Assigned(fContainer) then
    Canvas.Brush.Color := fContainer.PopupScrollBarFrameColor
  else
    Canvas.Brush.Color := clblue;
  Canvas.FillRect(Rect(118, 49, 123, 134));
  if Assigned(fContainer) then
    Canvas.Brush.Color := fContainer.PopupScrollBarBarColor
  else
    Canvas.Brush.Color := clAqua;
  if HighLightIndex >= 3 then
    Canvas.FillRect(Rect(119, 66, 122, 133))
  else
    Canvas.FillRect(Rect(119, 50, 122, 119));
  Text_Y := 59; {***}
  Canvas.Brush.Style := bsClear;
  for i := 0 to high(MenuItems) do
  begin
    if Assigned(fContainer) then
      Canvas.Font.Color := fContainer.PopupMenuTextColor
    else
      Canvas.Font.Color := clWhite;
    if i = MenuItemsDisabledIndex then
      if Assigned(fContainer) then
        Canvas.Font.Color := fContainer.PopupMenuTextDisabledColor
      else
        Canvas.Font.Color := $7F7F7F;
    if (i = HighLightIndex) and (i <> MenuItemsDisabledIndex) then
      if Assigned(fContainer) then
        Canvas.Font.Color := fContainer.PopupHighlightTextColor
      else
        Canvas.Font.Color := $FFFFFF;
    if (i = HighLightIndex) and (i = MenuItemsDisabledIndex) then
      if Assigned(fContainer) then
        Canvas.Font.Color := fContainer.PopupHighlightTextDisabledColor
      else
        Canvas.Font.Color := $A7B4CA;
    Canvas.TextOut(Text_X, Text_Y - canvas.TextHeight(MenuItems[i]) div 2, MenuItems[i]);
    Text_Y := Text_Y + 16;
  end;
end;

procedure TOKTThemeViewer.DrawStandBy(Canvas: TCanvas; OpratorName: string);

begin
  with Canvas do
  begin
   // wallpaper image
    if (Assigned(fContainer) and fImagesVisible) then
      Canvas.Draw(0, 14, fContainer.WallpaperImage.Graphic);
   // Draw Operator
    if Assigned(fContainer) then
      WriteOutlinedText(Canvas, 64 - Canvas.TextWidth(OpratorName) div 2, 22, OpratorName, fContainer.OperatorTextColor, fContainer.OperatorTextOutlineColor, [fsBold])
    else
      WriteOutlinedText(Canvas, 64 - Canvas.TextWidth(OpratorName) div 2, 22, OpratorName, clWhite, clBlack, [fsBold]);
   // Draw Time (on the left side)
    if Assigned(fContainer) then
      WriteOutlinedText(Canvas, 2, 131, FormatDateTime('hh:nn', Now),
        fContainer.TimeTextColor, fContainer.TimeTextOutlineColor, [fsBold])
    else
      WriteOutlinedText(Canvas, 2, 131, FormatDateTime('hh:nn', Now),
        clWhite, clBlack, [fsBold]);
   // Draw Date (on the right side)
    if Assigned(fContainer) then
      WriteOutlinedText(Canvas, 126 - canvas.TextWidth(FormatDateTime('dd-mmm-yy', Now)), 131, FormatDateTime('dd-mmm-yy', Now), fContainer.TimeTextColor, fContainer.TimeTextOutlineColor, [fsBold])
    else
      WriteOutlinedText(Canvas, 126 - canvas.TextWidth(FormatDateTime('dd-mmm-yy', Now)), 131, FormatDateTime('dd-mmm-yy', Now), clWhite, clBlack, [fsBold]);
  end;
end;

procedure TOKTThemeViewer.DrawDesktop(Canvas: TCanvas; Titles: array of string);
var
  Idx: Word;
  Picture: TPicture;
begin
  Idx := Random(12);
  Picture := TPicture.Create;
  with Canvas do
  begin
   // Draw Desktop Background
    if Assigned(fContainer) then
      DrawShape(Canvas, 0, 14, 128, 141, fContainer.DesktopBackGroundColor)
    else
      DrawShape(Canvas, 0, 14, 128, 141, clTeal);
   // Desktop image;
    if (Assigned(fContainer) and fImagesVisible) then
      StretchDraw(Rect(0, 14, 128, 141), fContainer.DesktopImage.Graphic);

   // Desktop icons DS0 form resurce;
    LoadResGraph(Picture, 'DS0');
    Canvas.Draw(0, 14, Picture.Graphic);
    case Idx of
      0:
        begin
          LoadResGraph(Picture, 'DS1');
          Canvas.Draw(2, 36, Picture.Graphic); // sony ericsson icon
        end;
      1:
        begin
          LoadResGraph(Picture, 'DS2');
          Canvas.Draw(44, 36, Picture.Graphic); // Internet icon
        end;
      2:
        begin
          LoadResGraph(Picture, 'DS3');
          Canvas.Draw(86, 36, Picture.Graphic); // Shortcuts icon
        end;
      3:
        begin
          LoadResGraph(Picture, 'DS4');
          Canvas.Draw(2, 62, Picture.Graphic); // Camera icon
        end;
      4:
        begin
          LoadResGraph(Picture, 'DS5');
          Canvas.Draw(44, 62, Picture.Graphic); // messages icon
        end;
      5:
        begin
          LoadResGraph(Picture, 'DS6');
          Canvas.Draw(86, 62, Picture.Graphic); // enterantement icon
        end;
      6:
        begin
          LoadResGraph(Picture, 'DS7');
          Canvas.Draw(2, 88, Picture.Graphic); // Multimedia icon
        end;
      7:
        begin
          LoadResGraph(Picture, 'DS8');
          Canvas.Draw(44, 88, Picture.Graphic); // Phonebook icon
        end;
      8:
        begin
          LoadResGraph(Picture, 'DS9');
          Canvas.Draw(86, 88, Picture.Graphic); // Calls icon
        end;
      9:
        begin
          LoadResGraph(Picture, 'DS10');
          Canvas.Draw(2, 114, Picture.Graphic); // connectivity icon
        end;
      10:
        begin
          LoadResGraph(Picture, 'DS11');
          Canvas.Draw(44, 114, Picture.Graphic); // organizer icon
        end;
      11:
        begin
          LoadResGraph(Picture, 'DS12');
          Canvas.Draw(86, 114, Picture.Graphic); // settings icon
        end;
    end;
   // Draw title
    if Assigned(fContainer) then
      WriteShadowedText(Canvas, 64, 25, Titles[Idx], fContainer.DesktopTitleColor, fContainer.DesktopTitleOutlineColor, [fsBold], taCenter)
    else
      WriteShadowedText(Canvas, 64, 25, Titles[Idx], clWhite, clBlack, [fsBold], taCenter);
  end;
  Picture.Free;
end;

end.

