unit uWABSync;

{
*******************************************************************************
* Descriptions: WAB Contact Sync Unit
* $Source: /cvsroot/fma/fma/uWABSync.pas,v $
* $Locker:  $
*
* Todo:
*   - Check for memory leaks
*
* Change Log:
* $Log: uWABSync.pas,v $
* Revision 1.5.2.1  2005/12/09 13:33:58  z_stoichev
* FMA 2.2 Tech3
*
* Revision 1.5  2005/02/08 15:38:56  voxik
* Merged with L10N branch
*
* Revision 1.4.12.1  2004/10/25 20:21:58  expertone
* Replaced all standart components with TNT components. Some small fixes
*
* Revision 1.4  2004/06/25 18:27:09  lordlarry
* Added this changelog header
*
*
}

interface

uses
  uContactSync, Classes, TntClasses, WabIab, WabApi, WabDefs;

type
  TWABContact = class(TContact)
  private
    FWABData: TStringList;
    procedure SetWABData(const Value: TStringList);
  protected
    function Exists: Boolean; override;
  public
    constructor Create(ContactSource: TContactSource);
    destructor Destroy; override;

    property WABData: TStringList read FWABData write SetWABData;
  end;

  TWABContactSource = class(TContactSource)
  private
    FFilePath: String;
    AddrBook: IAddrBook;
    WabObject: IWabObject;
    procedure FreeSBinary(var P: PSBinary);
    procedure FreeSRowSet(var P: PSRowSet);
  protected
    function GetName: String; override;
    procedure Read(Contact: TWABContact; WABData: TStringList);
    procedure OpenWAB;
    procedure CloseWAB;
    procedure EntryIDDataToWABData(EntryIDData: PSBinary; WABData: TStringList);
  public
    destructor Destroy; override;

    function New: TContact; override;
    function Add(Value: TContact): TContact; override;
    procedure Update(Contact, Value: TContact); override;
    procedure Delete(Contact: TContact); override;

    procedure Load; override;

    property FilePath: String read FFilePath write FFilePath;
  end;

implementation

uses 
  gnugettext, gnugettexthelpers,
  ComObj, Windows, TntWindows, WabTags, Forms, TntForms, SysUtils, TntSysUtils;

function SPropValueToStr(PropValue: TSPropValue): string;
var
  LT: TFileTime;
  ST: TSystemTime;
begin
  with PropValue do
    case PROP_TYPE(ulPropTag) of
      PT_TSTRING:
        Result := Value.lpszA;
      PT_BINARY:
        if Value.bin.cb = 4 then
          Result := Format(_('$%.8x'), [PDWORD(Value.bin.lpb)^])
        else
          Result := Format(_('[Binary - Size: %d bytes])', [Value.bin.cb]);
      PT_I2:
        Result := IntToStr(Value.i);
      PT_LONG:
        Result := IntToStr(Value.l);
      PT_R4:
        Result := FloatToStr(Value.flt);
      PT_DOUBLE:
        Result := FloatToStr(Value.dbl);
      PT_BOOLEAN:
        Result := IntToStr(Value.b);
      PT_SYSTIME:
        begin
          FileTimeToLocalFileTime(Value.ft, LT);
          FileTimeToSystemTime(LT, ST);
          Result := DateTimeToStr(SystemTimeToDateTime(ST));
        end;
      PT_ERROR:
        Result := '';
    else
      Result := Format(_('[Unknown type %x]'), [PROP_TYPE(ulPropTag)]);
    end;
end;

function StrToSPropValue(const TextValue: String; var PropValue: TSPropValue): Boolean;
begin
  Result := True;
  with PropValue do
    case PROP_TYPE(ulPropTag) of
      PT_TSTRING:
        Value.lpszA := PChar(TextValue);
      PT_I2:
        Value.i := StrToInt(TextValue);
      PT_LONG:
        Value.l := StrToInt(TextValue);
      PT_R4:
        Value.flt := StrToFloat(TextValue);
      PT_DOUBLE:
        Value.dbl := StrToFloat(TextValue);
      PT_BOOLEAN:
        Value.b := StrToInt(TextValue);
    else
      Result := False;
    end;
end;

function IsPropSimpleEditable(PropValue: TSPropValue): Boolean;
begin
  case PROP_TYPE(PropValue.ulPropTag) of
    PT_TSTRING, PT_I2, PT_LONG, PT_R4, PT_DOUBLE, PT_BOOLEAN:
      Result := True;
  else
    Result := False;
  end;
end;        

function SPropValueToTypeStr(PropValue: TSPropValue): string;
const
  TagNames: array[1..321] of record
    Tag: ULONG;
    Name: PChar
  end = (
    (Tag: PR_ENTRYID; Name: 'ENTRYID'), // do not localize
    (Tag: PR_OBJECT_TYPE; Name: 'OBJECT_TYPE'), // do not localize
    (Tag: PR_ICON; Name: 'ICON'), // do not localize
    (Tag: PR_MINI_ICON; Name: 'MINI_ICON'), // do not localize
    (Tag: PR_STORE_ENTRYID; Name: 'STORE_ENTRYID'), // do not localize
    (Tag: PR_STORE_RECORD_KEY; Name: 'STORE_RECORD_KEY'), // do not localize
    (Tag: PR_RECORD_KEY; Name: 'RECORD_KEY'), // do not localize
    (Tag: PR_MAPPING_SIGNATURE; Name: 'MAPPING_SIGNATURE'), // do not localize
    (Tag: PR_ACCESS_LEVEL; Name: 'ACCESS_LEVEL'), // do not localize
    (Tag: PR_INSTANCE_KEY; Name: 'INSTANCE_KEY'), // do not localize
    (Tag: PR_ROW_TYPE; Name: 'ROW_TYPE'), // do not localize
    (Tag: PR_ACCESS; Name: 'ACCESS'), // do not localize
    (Tag: PR_ROWID; Name: 'ROWID'), // do not localize
    (Tag: PR_DISPLAY_NAME; Name: 'DISPLAY_NAME'), // do not localize
    (Tag: PR_DISPLAY_NAME_W; Name: 'DISPLAY_NAME_W'), // do not localize
    (Tag: PR_DISPLAY_NAME_A; Name: 'DISPLAY_NAME_A'), // do not localize
    (Tag: PR_ADDRTYPE; Name: 'ADDRTYPE'), // do not localize
    (Tag: PR_ADDRTYPE_W; Name: 'ADDRTYPE_W'), // do not localize
    (Tag: PR_ADDRTYPE_A; Name: 'ADDRTYPE_A'), // do not localize
    (Tag: PR_EMAIL_ADDRESS; Name: 'EMAIL_ADDRESS'), // do not localize
    (Tag: PR_EMAIL_ADDRESS_W; Name: 'EMAIL_ADDRESS_W'), // do not localize
    (Tag: PR_EMAIL_ADDRESS_A; Name: 'EMAIL_ADDRESS_A'), // do not localize
    (Tag: PR_COMMENT; Name: 'COMMENT'), // do not localize
    (Tag: PR_COMMENT_W; Name: 'COMMENT_W'), // do not localize
    (Tag: PR_COMMENT_A; Name: 'COMMENT_A'), // do not localize
    (Tag: PR_DEPTH; Name: 'DEPTH'), // do not localize
    (Tag: PR_PROVIDER_DISPLAY; Name: 'PROVIDER_DISPLAY'), // do not localize
    (Tag: PR_PROVIDER_DISPLAY_W; Name: 'PROVIDER_DISPLAY_W'), // do not localize
    (Tag: PR_PROVIDER_DISPLAY_A; Name: 'PROVIDER_DISPLAY_A'), // do not localize
    (Tag: PR_CREATION_TIME; Name: 'CREATION_TIME'), // do not localize
    (Tag: PR_LAST_MODIFICATION_TIME; Name: 'LAST_MODIFICATION_TIME'), // do not localize
    (Tag: PR_RESOURCE_FLAGS; Name: 'RESOURCE_FLAGS'), // do not localize
    (Tag: PR_PROVIDER_DLL_NAME; Name: 'PROVIDER_DLL_NAME'), // do not localize
    (Tag: PR_PROVIDER_DLL_NAME_W; Name: 'PROVIDER_DLL_NAME_W'), // do not localize
    (Tag: PR_PROVIDER_DLL_NAME_A; Name: 'PROVIDER_DLL_NAME_A'), // do not localize
    (Tag: PR_SEARCH_KEY; Name: 'SEARCH_KEY'), // do not localize
    (Tag: PR_PROVIDER_UID; Name: 'PROVIDER_UID'), // do not localize
    (Tag: PR_PROVIDER_ORDINAL; Name: 'PROVIDER_ORDINAL'), // do not localize
    (Tag: PR_CONTAINER_FLAGS; Name: 'CONTAINER_FLAGS'), // do not localize
    (Tag: PR_FOLDER_TYPE; Name: 'FOLDER_TYPE'), // do not localize
    (Tag: PR_CONTENT_COUNT; Name: 'CONTENT_COUNT'), // do not localize
    (Tag: PR_CONTENT_UNREAD; Name: 'CONTENT_UNREAD'), // do not localize
    (Tag: PR_CREATE_TEMPLATES; Name: 'CREATE_TEMPLATES'), // do not localize
    (Tag: PR_DETAILS_TABLE; Name: 'DETAILS_TABLE'), // do not localize
    (Tag: PR_SEARCH; Name: 'SEARCH'), // do not localize
    (Tag: PR_SELECTABLE; Name: 'SELECTABLE'), // do not localize
    (Tag: PR_SUBFOLDERS; Name: 'SUBFOLDERS'), // do not localize
    (Tag: PR_STATUS; Name: 'STATUS'), // do not localize
    (Tag: PR_ANR; Name: 'ANR'), // do not localize
    (Tag: PR_ANR_W; Name: 'ANR_W'), // do not localize
    (Tag: PR_ANR_A; Name: 'ANR_A'), // do not localize
    (Tag: PR_CONTENTS_SORT_ORDER; Name: 'CONTENTS_SORT_ORDER'), // do not localize
    (Tag: PR_CONTAINER_HIERARCHY; Name: 'CONTAINER_HIERARCHY'), // do not localize
    (Tag: PR_CONTAINER_CONTENTS; Name: 'CONTAINER_CONTENTS'), // do not localize
    (Tag: PR_FOLDER_ASSOCIATED_CONTENTS; Name: 'FOLDER_ASSOCIATED_CONTENTS'), // do not localize
    (Tag: PR_DEF_CREATE_DL; Name: 'DEF_CREATE_DL'), // do not localize
    (Tag: PR_DEF_CREATE_MAILUSER; Name: 'DEF_CREATE_MAILUSER'), // do not localize
    (Tag: PR_CONTAINER_CLASS; Name: 'CONTAINER_CLASS'), // do not localize
    (Tag: PR_CONTAINER_CLASS_W; Name: 'CONTAINER_CLASS_W'), // do not localize
    (Tag: PR_CONTAINER_CLASS_A; Name: 'CONTAINER_CLASS_A'), // do not localize
    (Tag: PR_CONTAINER_MODIFY_VERSION; Name: 'CONTAINER_MODIFY_VERSION'), // do not localize
    (Tag: PR_AB_PROVIDER_ID; Name: 'AB_PROVIDER_ID'), // do not localize
    (Tag: PR_DEFAULT_VIEW_ENTRYID; Name: 'DEFAULT_VIEW_ENTRYID'), // do not localize
    (Tag: PR_ASSOC_CONTENT_COUNT; Name: 'ASSOC_CONTENT_COUNT'),
    (Tag: PR_DISPLAY_TYPE; Name: 'DISPLAY_TYPE'), // do not localize
    (Tag: PR_TEMPLATEID; Name: 'TEMPLATEID'), // do not localize
    (Tag: PR_PRIMARY_CAPABILITY; Name: 'PRIMARY_CAPABILITY'), // do not localize
    (Tag: PR_7BIT_DISPLAY_NAME; Name: '7BIT_DISPLAY_NAME'), // do not localize
    (Tag: PR_ACCOUNT; Name: 'ACCOUNT'), // do not localize
    (Tag: PR_ACCOUNT_W; Name: 'ACCOUNT_W'), // do not localize
    (Tag: PR_ACCOUNT_A; Name: 'ACCOUNT_A'), // do not localize
    (Tag: PR_ALTERNATE_RECIPIENT; Name: 'ALTERNATE_RECIPIENT'), // do not localize
    (Tag: PR_CALLBACK_TELEPHONE_NUMBER; Name: 'CALLBACK_TELEPHONE_NUMBER'), // do not localize
    (Tag: PR_CALLBACK_TELEPHONE_NUMBER_W; Name: 'CALLBACK_TELEPHONE_NUMBER_W'), // do not localize
    (Tag: PR_CALLBACK_TELEPHONE_NUMBER_A; Name: 'CALLBACK_TELEPHONE_NUMBER_A'), // do not localize
    (Tag: PR_CONVERSION_PROHIBITED; Name: 'CONVERSION_PROHIBITED'), // do not localize
    (Tag: PR_DISCLOSE_RECIPIENTS; Name: 'DISCLOSE_RECIPIENTS'), // do not localize
    (Tag: PR_GENERATION; Name: 'GENERATION'), // do not localize
    (Tag: PR_GENERATION_W; Name: 'GENERATION_W'), // do not localize
    (Tag: PR_GENERATION_A; Name: 'GENERATION_A'), // do not localize
    (Tag: PR_GIVEN_NAME; Name: 'GIVEN_NAME'), // do not localize
    (Tag: PR_GIVEN_NAME_W; Name: 'GIVEN_NAME_W'), // do not localize
    (Tag: PR_GIVEN_NAME_A; Name: 'GIVEN_NAME_A'), // do not localize
    (Tag: PR_GOVERNMENT_ID_NUMBER; Name: 'GOVERNMENT_ID_NUMBER'), // do not localize
    (Tag: PR_GOVERNMENT_ID_NUMBER_W; Name: 'GOVERNMENT_ID_NUMBER_W'), // do not localize
    (Tag: PR_GOVERNMENT_ID_NUMBER_A; Name: 'GOVERNMENT_ID_NUMBER_A'), // do not localize
    (Tag: PR_BUSINESS_TELEPHONE_NUMBER; Name: 'BUSINESS_TELEPHONE_NUMBER'), // do not localize
    (Tag: PR_BUSINESS_TELEPHONE_NUMBER_W; Name: 'BUSINESS_TELEPHONE_NUMBER_W'), // do not localize
    (Tag: PR_BUSINESS_TELEPHONE_NUMBER_A; Name: 'BUSINESS_TELEPHONE_NUMBER_A'), // do not localize
    (Tag: PR_OFFICE_TELEPHONE_NUMBER; Name: 'OFFICE_TELEPHONE_NUMBER'), // do not localize
    (Tag: PR_OFFICE_TELEPHONE_NUMBER_W; Name: 'OFFICE_TELEPHONE_NUMBER_W'), // do not localize
    (Tag: PR_OFFICE_TELEPHONE_NUMBER_A; Name: 'OFFICE_TELEPHONE_NUMBER_A'), // do not localize
    (Tag: PR_HOME_TELEPHONE_NUMBER; Name: 'HOME_TELEPHONE_NUMBER'), // do not localize
    (Tag: PR_HOME_TELEPHONE_NUMBER_W; Name: 'HOME_TELEPHONE_NUMBER_W'), // do not localize
    (Tag: PR_HOME_TELEPHONE_NUMBER_A; Name: 'HOME_TELEPHONE_NUMBER_A'), // do not localize
    (Tag: PR_INITIALS; Name: 'INITIALS'), // do not localize
    (Tag: PR_INITIALS_W; Name: 'INITIALS_W'), // do not localize
    (Tag: PR_INITIALS_A; Name: 'INITIALS_A'), // do not localize
    (Tag: PR_KEYWORD; Name: 'KEYWORD'), // do not localize
    (Tag: PR_KEYWORD_W; Name: 'KEYWORD_W'), // do not localize
    (Tag: PR_KEYWORD_A; Name: 'KEYWORD_A'), // do not localize
    (Tag: PR_LANGUAGE; Name: 'LANGUAGE'), // do not localize
    (Tag: PR_LANGUAGE_W; Name: 'LANGUAGE_W'), // do not localize
    (Tag: PR_LANGUAGE_A; Name: 'LANGUAGE_A'), // do not localize
    (Tag: PR_LOCATION; Name: 'LOCATION'), // do not localize
    (Tag: PR_LOCATION_W; Name: 'LOCATION_W'), // do not localize
    (Tag: PR_LOCATION_A; Name: 'LOCATION_A'), // do not localize
    (Tag: PR_MAIL_PERMISSION; Name: 'MAIL_PERMISSION'), // do not localize
    (Tag: PR_MHS_COMMON_NAME; Name: 'MHS_COMMON_NAME'), // do not localize
    (Tag: PR_MHS_COMMON_NAME_W; Name: 'MHS_COMMON_NAME_W'), // do not localize
    (Tag: PR_MHS_COMMON_NAME_A; Name: 'MHS_COMMON_NAME_A'), // do not localize
    (Tag: PR_ORGANIZATIONAL_ID_NUMBER; Name: 'ORGANIZATIONAL_ID_NUMBER'), // do not localize
    (Tag: PR_ORGANIZATIONAL_ID_NUMBER_W; Name: 'ORGANIZATIONAL_ID_NUMBER_W'), // do not localize
    (Tag: PR_ORGANIZATIONAL_ID_NUMBER_A; Name: 'ORGANIZATIONAL_ID_NUMBER_A'), // do not localize
    (Tag: PR_SURNAME; Name: 'SURNAME'), // do not localize
    (Tag: PR_SURNAME_W; Name: 'SURNAME_W'), // do not localize
    (Tag: PR_SURNAME_A; Name: 'SURNAME_A'), // do not localize
    (Tag: PR_ORIGINAL_ENTRYID; Name: 'ORIGINAL_ENTRYID'), // do not localize
    (Tag: PR_ORIGINAL_DISPLAY_NAME; Name: 'ORIGINAL_DISPLAY_NAME'), // do not localize
    (Tag: PR_ORIGINAL_DISPLAY_NAME_W; Name: 'ORIGINAL_DISPLAY_NAME_W'), // do not localize
    (Tag: PR_ORIGINAL_DISPLAY_NAME_A; Name: 'ORIGINAL_DISPLAY_NAME_A'), // do not localize
    (Tag: PR_ORIGINAL_SEARCH_KEY; Name: 'ORIGINAL_SEARCH_KEY'), // do not localize
    (Tag: PR_POSTAL_ADDRESS; Name: 'POSTAL_ADDRESS'), // do not localize
    (Tag: PR_POSTAL_ADDRESS_W; Name: 'POSTAL_ADDRESS_W'), // do not localize
    (Tag: PR_POSTAL_ADDRESS_A; Name: 'POSTAL_ADDRESS_A'), // do not localize
    (Tag: PR_COMPANY_NAME; Name: 'COMPANY_NAME'), // do not localize
    (Tag: PR_COMPANY_NAME_W; Name: 'COMPANY_NAME_W'), // do not localize
    (Tag: PR_COMPANY_NAME_A; Name: 'COMPANY_NAME_A'), // do not localize
    (Tag: PR_TITLE; Name: 'TITLE'), // do not localize
    (Tag: PR_TITLE_W; Name: 'TITLE_W'), // do not localize
    (Tag: PR_TITLE_A; Name: 'TITLE_A'), // do not localize
    (Tag: PR_DEPARTMENT_NAME; Name: 'DEPARTMENT_NAME'), // do not localize
    (Tag: PR_DEPARTMENT_NAME_W; Name: 'DEPARTMENT_NAME_W'), // do not localize
    (Tag: PR_DEPARTMENT_NAME_A; Name: 'DEPARTMENT_NAME_A'), // do not localize
    (Tag: PR_OFFICE_LOCATION; Name: 'OFFICE_LOCATION'), // do not localize
    (Tag: PR_OFFICE_LOCATION_W; Name: 'OFFICE_LOCATION_W'), // do not localize
    (Tag: PR_OFFICE_LOCATION_A; Name: 'OFFICE_LOCATION_A'), // do not localize
    (Tag: PR_PRIMARY_TELEPHONE_NUMBER; Name: 'PRIMARY_TELEPHONE_NUMBER'), // do not localize
    (Tag: PR_PRIMARY_TELEPHONE_NUMBER_W; Name: 'PRIMARY_TELEPHONE_NUMBER_W'), // do not localize
    (Tag: PR_PRIMARY_TELEPHONE_NUMBER_A; Name: 'PRIMARY_TELEPHONE_NUMBER_A'), // do not localize
    (Tag: PR_BUSINESS2_TELEPHONE_NUMBER; Name: 'BUSINESS2_TELEPHONE_NUMBER'), // do not localize
    (Tag: PR_BUSINESS2_TELEPHONE_NUMBER_W; Name: 'BUSINESS2_TELEPHONE_NUMBER_W'), // do not localize
    (Tag: PR_BUSINESS2_TELEPHONE_NUMBER_A; Name: 'BUSINESS2_TELEPHONE_NUMBER_A'), // do not localize
    (Tag: PR_OFFICE2_TELEPHONE_NUMBER; Name: 'OFFICE2_TELEPHONE_NUMBER'), // do not localize
    (Tag: PR_OFFICE2_TELEPHONE_NUMBER_W; Name: 'OFFICE2_TELEPHONE_NUMBER_W'), // do not localize
    (Tag: PR_OFFICE2_TELEPHONE_NUMBER_A; Name: 'OFFICE2_TELEPHONE_NUMBER_A'), // do not localize
    (Tag: PR_MOBILE_TELEPHONE_NUMBER; Name: 'MOBILE_TELEPHONE_NUMBER'), // do not localize
    (Tag: PR_MOBILE_TELEPHONE_NUMBER_W; Name: 'MOBILE_TELEPHONE_NUMBER_W'), // do not localize
    (Tag: PR_MOBILE_TELEPHONE_NUMBER_A; Name: 'MOBILE_TELEPHONE_NUMBER_A'), // do not localize
    (Tag: PR_CELLULAR_TELEPHONE_NUMBER; Name: 'CELLULAR_TELEPHONE_NUMBER'), // do not localize
    (Tag: PR_CELLULAR_TELEPHONE_NUMBER_W; Name: 'CELLULAR_TELEPHONE_NUMBER_W'), // do not localize
    (Tag: PR_CELLULAR_TELEPHONE_NUMBER_A; Name: 'CELLULAR_TELEPHONE_NUMBER_A'), // do not localize
    (Tag: PR_RADIO_TELEPHONE_NUMBER; Name: 'RADIO_TELEPHONE_NUMBER'), // do not localize
    (Tag: PR_RADIO_TELEPHONE_NUMBER_W; Name: 'RADIO_TELEPHONE_NUMBER_W'), // do not localize
    (Tag: PR_RADIO_TELEPHONE_NUMBER_A; Name: 'RADIO_TELEPHONE_NUMBER_A'), // do not localize
    (Tag: PR_CAR_TELEPHONE_NUMBER; Name: 'CAR_TELEPHONE_NUMBER'), // do not localize
    (Tag: PR_CAR_TELEPHONE_NUMBER_W; Name: 'CAR_TELEPHONE_NUMBER_W'), // do not localize
    (Tag: PR_CAR_TELEPHONE_NUMBER_A; Name: 'CAR_TELEPHONE_NUMBER_A'), // do not localize
    (Tag: PR_OTHER_TELEPHONE_NUMBER; Name: 'OTHER_TELEPHONE_NUMBER'), // do not localize
    (Tag: PR_OTHER_TELEPHONE_NUMBER_W; Name: 'OTHER_TELEPHONE_NUMBER_W'), // do not localize
    (Tag: PR_OTHER_TELEPHONE_NUMBER_A; Name: 'OTHER_TELEPHONE_NUMBER_A'), // do not localize
    (Tag: PR_TRANSMITABLE_DISPLAY_NAME; Name: 'TRANSMITABLE_DISPLAY_NAME'), // do not localize
    (Tag: PR_TRANSMITABLE_DISPLAY_NAME_W; Name: 'TRANSMITABLE_DISPLAY_NAME_W'), // do not localize
    (Tag: PR_TRANSMITABLE_DISPLAY_NAME_A; Name: 'TRANSMITABLE_DISPLAY_NAME_A'), // do not localize
    (Tag: PR_PAGER_TELEPHONE_NUMBER; Name: 'PAGER_TELEPHONE_NUMBER'), // do not localize
    (Tag: PR_PAGER_TELEPHONE_NUMBER_W; Name: 'PAGER_TELEPHONE_NUMBER_W'), // do not localize
    (Tag: PR_PAGER_TELEPHONE_NUMBER_A; Name: 'PAGER_TELEPHONE_NUMBER_A'), // do not localize
    (Tag: PR_BEEPER_TELEPHONE_NUMBER; Name: 'BEEPER_TELEPHONE_NUMBER'), // do not localize
    (Tag: PR_BEEPER_TELEPHONE_NUMBER_W; Name: 'BEEPER_TELEPHONE_NUMBER_W'), // do not localize
    (Tag: PR_BEEPER_TELEPHONE_NUMBER_A; Name: 'BEEPER_TELEPHONE_NUMBER_A'), // do not localize
    (Tag: PR_USER_CERTIFICATE; Name: 'USER_CERTIFICATE'), // do not localize
    (Tag: PR_PRIMARY_FAX_NUMBER; Name: 'PRIMARY_FAX_NUMBER'), // do not localize
    (Tag: PR_PRIMARY_FAX_NUMBER_W; Name: 'PRIMARY_FAX_NUMBER_W'), // do not localize
    (Tag: PR_PRIMARY_FAX_NUMBER_A; Name: 'PRIMARY_FAX_NUMBER_A'), // do not localize
    (Tag: PR_BUSINESS_FAX_NUMBER; Name: 'BUSINESS_FAX_NUMBER'), // do not localize
    (Tag: PR_BUSINESS_FAX_NUMBER_W; Name: 'BUSINESS_FAX_NUMBER_W'), // do not localize
    (Tag: PR_BUSINESS_FAX_NUMBER_A; Name: 'BUSINESS_FAX_NUMBER_A'), // do not localize
    (Tag: PR_HOME_FAX_NUMBER; Name: 'HOME_FAX_NUMBER'), // do not localize
    (Tag: PR_HOME_FAX_NUMBER_W; Name: 'HOME_FAX_NUMBER_W'), // do not localize
    (Tag: PR_HOME_FAX_NUMBER_A; Name: 'HOME_FAX_NUMBER_A'), // do not localize
    (Tag: PR_COUNTRY; Name: 'COUNTRY'), // do not localize
    (Tag: PR_COUNTRY_W; Name: 'COUNTRY_W'), // do not localize
    (Tag: PR_COUNTRY_A; Name: 'COUNTRY_A'), // do not localize
    (Tag: PR_LOCALITY; Name: 'LOCALITY'), // do not localize
    (Tag: PR_LOCALITY_W; Name: 'LOCALITY_W'), // do not localize
    (Tag: PR_LOCALITY_A; Name: 'LOCALITY_A'), // do not localize
    (Tag: PR_STATE_OR_PROVINCE; Name: 'STATE_OR_PROVINCE'), // do not localize
    (Tag: PR_STATE_OR_PROVINCE_W; Name: 'STATE_OR_PROVINCE_W'), // do not localize
    (Tag: PR_STATE_OR_PROVINCE_A; Name: 'STATE_OR_PROVINCE_A'), // do not localize
    (Tag: PR_STREET_ADDRESS; Name: 'STREET_ADDRESS'), // do not localize
    (Tag: PR_STREET_ADDRESS_W; Name: 'STREET_ADDRESS_W'), // do not localize
    (Tag: PR_STREET_ADDRESS_A; Name: 'STREET_ADDRESS_A'), // do not localize
    (Tag: PR_POSTAL_CODE; Name: 'POSTAL_CODE'), // do not localize
    (Tag: PR_POSTAL_CODE_W; Name: 'POSTAL_CODE_W'), // do not localize
    (Tag: PR_POSTAL_CODE_A; Name: 'POSTAL_CODE_A'), // do not localize
    (Tag: PR_POST_OFFICE_BOX; Name: 'POST_OFFICE_BOX'), // do not localize
    (Tag: PR_POST_OFFICE_BOX_W; Name: 'POST_OFFICE_BOX_W'), // do not localize
    (Tag: PR_POST_OFFICE_BOX_A; Name: 'POST_OFFICE_BOX_A'), // do not localize
    (Tag: PR_BUSINESS_ADDRESS_POST_OFFICE_BOX; Name: 'BUSINESS_ADDRESS_POST_OFFICE_BOX'), // do not localize
    (Tag: PR_BUSINESS_ADDRESS_POST_OFFICE_BOX_W; Name: 'BUSINESS_ADDRESS_POST_OFFICE_BOX_W'), // do not localize
    (Tag: PR_BUSINESS_ADDRESS_POST_OFFICE_BOX_A; Name: 'BUSINESS_ADDRESS_POST_OFFICE_BOX_A'), // do not localize
    (Tag: PR_TELEX_NUMBER; Name: 'TELEX_NUMBER'), // do not localize
    (Tag: PR_TELEX_NUMBER_W; Name: 'TELEX_NUMBER_W'), // do not localize
    (Tag: PR_TELEX_NUMBER_A; Name: 'TELEX_NUMBER_A'), // do not localize
    (Tag: PR_ISDN_NUMBER; Name: 'ISDN_NUMBER'), // do not localize
    (Tag: PR_ISDN_NUMBER_W; Name: 'ISDN_NUMBER_W'), // do not localize
    (Tag: PR_ISDN_NUMBER_A; Name: 'ISDN_NUMBER_A'), // do not localize
    (Tag: PR_ASSISTANT_TELEPHONE_NUMBER; Name: 'ASSISTANT_TELEPHONE_NUMBER'), // do not localize
    (Tag: PR_ASSISTANT_TELEPHONE_NUMBER_W; Name: 'ASSISTANT_TELEPHONE_NUMBER_W'), // do not localize
    (Tag: PR_ASSISTANT_TELEPHONE_NUMBER_A; Name: 'ASSISTANT_TELEPHONE_NUMBER_A'), // do not localize
    (Tag: PR_HOME2_TELEPHONE_NUMBER; Name: 'HOME2_TELEPHONE_NUMBER'), // do not localize
    (Tag: PR_HOME2_TELEPHONE_NUMBER_W; Name: 'HOME2_TELEPHONE_NUMBER_W'), // do not localize
    (Tag: PR_HOME2_TELEPHONE_NUMBER_A; Name: 'HOME2_TELEPHONE_NUMBER_A'), // do not localize
    (Tag: PR_ASSISTANT; Name: 'ASSISTANT'), // do not localize
    (Tag: PR_ASSISTANT_W; Name: 'ASSISTANT_W'), // do not localize
    (Tag: PR_ASSISTANT_A; Name: 'ASSISTANT_A'), // do not localize
    (Tag: PR_SEND_RICH_INFO; Name: 'SEND_RICH_INFO'), // do not localize
    (Tag: PR_WEDDING_ANNIVERSARY; Name: 'WEDDING_ANNIVERSARY'), // do not localize
    (Tag: PR_BIRTHDAY; Name: 'BIRTHDAY'), // do not localize
    (Tag: PR_HOBBIES; Name: 'HOBBIES'), // do not localize
    (Tag: PR_HOBBIES_W; Name: 'HOBBIES_W'), // do not localize
    (Tag: PR_HOBBIES_A; Name: 'HOBBIES_A'), // do not localize
    (Tag: PR_MIDDLE_NAME; Name: 'MIDDLE_NAME'), // do not localize
    (Tag: PR_MIDDLE_NAME_W; Name: 'MIDDLE_NAME_W'), // do not localize
    (Tag: PR_MIDDLE_NAME_A; Name: 'MIDDLE_NAME_A'), // do not localize
    (Tag: PR_DISPLAY_NAME_PREFIX; Name: 'DISPLAY_NAME_PREFIX'), // do not localize
    (Tag: PR_DISPLAY_NAME_PREFIX_W; Name: 'DISPLAY_NAME_PREFIX_W'), // do not localize
    (Tag: PR_DISPLAY_NAME_PREFIX_A; Name: 'DISPLAY_NAME_PREFIX_A'), // do not localize
    (Tag: PR_PROFESSION; Name: 'PROFESSION'), // do not localize
    (Tag: PR_PROFESSION_W; Name: 'PROFESSION_W'), // do not localize
    (Tag: PR_PROFESSION_A; Name: 'PROFESSION_A'), // do not localize
    (Tag: PR_PREFERRED_BY_NAME; Name: 'PREFERRED_BY_NAME'), // do not localize
    (Tag: PR_PREFERRED_BY_NAME_W; Name: 'PREFERRED_BY_NAME_W'), // do not localize
    (Tag: PR_PREFERRED_BY_NAME_A; Name: 'PREFERRED_BY_NAME_A'), // do not localize
    (Tag: PR_SPOUSE_NAME; Name: 'SPOUSE_NAME'), // do not localize
    (Tag: PR_SPOUSE_NAME_W; Name: 'SPOUSE_NAME_W'), // do not localize
    (Tag: PR_SPOUSE_NAME_A; Name: 'SPOUSE_NAME_A'), // do not localize
    (Tag: PR_COMPUTER_NETWORK_NAME; Name: 'COMPUTER_NETWORK_NAME'), // do not localize
    (Tag: PR_COMPUTER_NETWORK_NAME_W; Name: 'COMPUTER_NETWORK_NAME_W'), // do not localize
    (Tag: PR_COMPUTER_NETWORK_NAME_A; Name: 'COMPUTER_NETWORK_NAME_A'), // do not localize
    (Tag: PR_CUSTOMER_ID; Name: 'CUSTOMER_ID'), // do not localize
    (Tag: PR_CUSTOMER_ID_W; Name: 'CUSTOMER_ID_W'), // do not localize
    (Tag: PR_CUSTOMER_ID_A; Name: 'CUSTOMER_ID_A'), // do not localize
    (Tag: PR_TTYTDD_PHONE_NUMBER; Name: 'TTYTDD_PHONE_NUMBER'), // do not localize
    (Tag: PR_TTYTDD_PHONE_NUMBER_W; Name: 'TTYTDD_PHONE_NUMBER_W'), // do not localize
    (Tag: PR_TTYTDD_PHONE_NUMBER_A; Name: 'TTYTDD_PHONE_NUMBER_A'), // do not localize
    (Tag: PR_FTP_SITE; Name: 'FTP_SITE'), // do not localize
    (Tag: PR_FTP_SITE_W; Name: 'FTP_SITE_W'), // do not localize
    (Tag: PR_FTP_SITE_A; Name: 'FTP_SITE_A'), // do not localize
    (Tag: PR_GENDER; Name: 'GENDER'), // do not localize
    (Tag: PR_MANAGER_NAME; Name: 'MANAGER_NAME'), // do not localize
    (Tag: PR_MANAGER_NAME_W; Name: 'MANAGER_NAME_W'), // do not localize
    (Tag: PR_MANAGER_NAME_A; Name: 'MANAGER_NAME_A'), // do not localize
    (Tag: PR_NICKNAME; Name: 'NICKNAME'), // do not localize
    (Tag: PR_NICKNAME_W; Name: 'NICKNAME_W'), // do not localize
    (Tag: PR_NICKNAME_A; Name: 'NICKNAME_A'), // do not localize
    (Tag: PR_PERSONAL_HOME_PAGE; Name: 'PERSONAL_HOME_PAGE'), // do not localize
    (Tag: PR_PERSONAL_HOME_PAGE_W; Name: 'PERSONAL_HOME_PAGE_W'), // do not localize
    (Tag: PR_PERSONAL_HOME_PAGE_A; Name: 'PERSONAL_HOME_PAGE_A'), // do not localize
    (Tag: PR_BUSINESS_HOME_PAGE; Name: 'BUSINESS_HOME_PAGE'), // do not localize
    (Tag: PR_BUSINESS_HOME_PAGE_W; Name: 'BUSINESS_HOME_PAGE_W'), // do not localize
    (Tag: PR_BUSINESS_HOME_PAGE_A; Name: 'BUSINESS_HOME_PAGE_A'), // do not localize
    (Tag: PR_CONTACT_VERSION; Name: 'CONTACT_VERSION'), // do not localize
    (Tag: PR_CONTACT_ENTRYIDS; Name: 'CONTACT_ENTRYIDS'), // do not localize
    (Tag: PR_CONTACT_ADDRTYPES; Name: 'CONTACT_ADDRTYPES'), // do not localize
    (Tag: PR_CONTACT_ADDRTYPES_W; Name: 'CONTACT_ADDRTYPES_W'), // do not localize
    (Tag: PR_CONTACT_ADDRTYPES_A; Name: 'CONTACT_ADDRTYPES_A'), // do not localize
    (Tag: PR_CONTACT_DEFAULT_ADDRESS_INDEX; Name: 'CONTACT_DEFAULT_ADDRESS_INDEX'), // do not localize
    (Tag: PR_CONTACT_EMAIL_ADDRESSES; Name: 'CONTACT_EMAIL_ADDRESSES'), // do not localize
    (Tag: PR_CONTACT_EMAIL_ADDRESSES_W; Name: 'CONTACT_EMAIL_ADDRESSES_W'), // do not localize
    (Tag: PR_CONTACT_EMAIL_ADDRESSES_A; Name: 'CONTACT_EMAIL_ADDRESSES_A'), // do not localize
    (Tag: PR_COMPANY_MAIN_PHONE_NUMBER; Name: 'COMPANY_MAIN_PHONE_NUMBER'), // do not localize
    (Tag: PR_COMPANY_MAIN_PHONE_NUMBER_W; Name: 'COMPANY_MAIN_PHONE_NUMBER_W'), // do not localize
    (Tag: PR_COMPANY_MAIN_PHONE_NUMBER_A; Name: 'COMPANY_MAIN_PHONE_NUMBER_A'), // do not localize
    (Tag: PR_CHILDRENS_NAMES; Name: 'CHILDRENS_NAMES'), // do not localize
    (Tag: PR_CHILDRENS_NAMES_W; Name: 'CHILDRENS_NAMES_W'), // do not localize
    (Tag: PR_CHILDRENS_NAMES_A; Name: 'CHILDRENS_NAMES_A'), // do not localize
    (Tag: PR_HOME_ADDRESS_CITY; Name: 'HOME_ADDRESS_CITY'), // do not localize
    (Tag: PR_HOME_ADDRESS_CITY_W; Name: 'HOME_ADDRESS_CITY_W'), // do not localize
    (Tag: PR_HOME_ADDRESS_CITY_A; Name: 'HOME_ADDRESS_CITY_A'), // do not localize
    (Tag: PR_HOME_ADDRESS_COUNTRY; Name: 'HOME_ADDRESS_COUNTRY'), // do not localize
    (Tag: PR_HOME_ADDRESS_COUNTRY_W; Name: 'HOME_ADDRESS_COUNTRY_W'), // do not localize
    (Tag: PR_HOME_ADDRESS_COUNTRY_A; Name: 'HOME_ADDRESS_COUNTRY_A'), // do not localize
    (Tag: PR_HOME_ADDRESS_POSTAL_CODE; Name: 'HOME_ADDRESS_POSTAL_CODE'), // do not localize
    (Tag: PR_HOME_ADDRESS_POSTAL_CODE_W; Name: 'HOME_ADDRESS_POSTAL_CODE_W'), // do not localize
    (Tag: PR_HOME_ADDRESS_POSTAL_CODE_A; Name: 'HOME_ADDRESS_POSTAL_CODE_A'), // do not localize
    (Tag: PR_HOME_ADDRESS_STATE_OR_PROVINCE; Name: 'HOME_ADDRESS_STATE_OR_PROVINCE'), // do not localize
    (Tag: PR_HOME_ADDRESS_STATE_OR_PROVINCE_W; Name: 'HOME_ADDRESS_STATE_OR_PROVINCE_W'), // do not localize
    (Tag: PR_HOME_ADDRESS_STATE_OR_PROVINCE_A; Name: 'HOME_ADDRESS_STATE_OR_PROVINCE_A'), // do not localize
    (Tag: PR_HOME_ADDRESS_STREET; Name: 'HOME_ADDRESS_STREET'), // do not localize
    (Tag: PR_HOME_ADDRESS_STREET_W; Name: 'HOME_ADDRESS_STREET_W'), // do not localize
    (Tag: PR_HOME_ADDRESS_STREET_A; Name: 'HOME_ADDRESS_STREET_A'), // do not localize
    (Tag: PR_HOME_ADDRESS_POST_OFFICE_BOX; Name: 'HOME_ADDRESS_POST_OFFICE_BOX'), // do not localize
    (Tag: PR_HOME_ADDRESS_POST_OFFICE_BOX_W; Name: 'HOME_ADDRESS_POST_OFFICE_BOX_W'), // do not localize
    (Tag: PR_HOME_ADDRESS_POST_OFFICE_BOX_A; Name: 'HOME_ADDRESS_POST_OFFICE_BOX_A'), // do not localize
    (Tag: PR_OTHER_ADDRESS_CITY; Name: 'OTHER_ADDRESS_CITY'), // do not localize
    (Tag: PR_OTHER_ADDRESS_CITY_W; Name: 'OTHER_ADDRESS_CITY_W'), // do not localize
    (Tag: PR_OTHER_ADDRESS_CITY_A; Name: 'OTHER_ADDRESS_CITY_A'), // do not localize
    (Tag: PR_OTHER_ADDRESS_COUNTRY; Name: 'OTHER_ADDRESS_COUNTRY'), // do not localize
    (Tag: PR_OTHER_ADDRESS_COUNTRY_W; Name: 'OTHER_ADDRESS_COUNTRY_W'), // do not localize
    (Tag: PR_OTHER_ADDRESS_COUNTRY_A; Name: 'OTHER_ADDRESS_COUNTRY_A'), // do not localize
    (Tag: PR_OTHER_ADDRESS_POSTAL_CODE; Name: 'OTHER_ADDRESS_POSTAL_CODE'), // do not localize
    (Tag: PR_OTHER_ADDRESS_POSTAL_CODE_W; Name: 'OTHER_ADDRESS_POSTAL_CODE_W'), // do not localize
    (Tag: PR_OTHER_ADDRESS_POSTAL_CODE_A; Name: 'OTHER_ADDRESS_POSTAL_CODE_A'), // do not localize
    (Tag: PR_OTHER_ADDRESS_STATE_OR_PROVINCE; Name: 'OTHER_ADDRESS_STATE_OR_PROVINCE'), // do not localize
    (Tag: PR_OTHER_ADDRESS_STATE_OR_PROVINCE_W; Name: 'OTHER_ADDRESS_STATE_OR_PROVINCE_W'), // do not localize
    (Tag: PR_OTHER_ADDRESS_STATE_OR_PROVINCE_A; Name: 'OTHER_ADDRESS_STATE_OR_PROVINCE_A'), // do not localize
    (Tag: PR_OTHER_ADDRESS_STREET; Name: 'OTHER_ADDRESS_STREET'), // do not localize
    (Tag: PR_OTHER_ADDRESS_STREET_W; Name: 'OTHER_ADDRESS_STREET_W'), // do not localize
    (Tag: PR_OTHER_ADDRESS_STREET_A; Name: 'OTHER_ADDRESS_STREET_A'), // do not localize
    (Tag: PR_OTHER_ADDRESS_POST_OFFICE_BOX; Name: 'OTHER_ADDRESS_POST_OFFICE_BOX'), // do not localize
    (Tag: PR_OTHER_ADDRESS_POST_OFFICE_BOX_W; Name: 'OTHER_ADDRESS_POST_OFFICE_BOX_W'), // do not localize
    (Tag: PR_OTHER_ADDRESS_POST_OFFICE_BOX_A; Name: 'OTHER_ADDRESS_POST_OFFICE_BOX_A'), // do not localize
    (Tag: PR_USER_X509_CERTIFICATE; Name: 'USER_X509_CERTIFICATE'), // do not localize
    (Tag: PR_SEND_INTERNET_ENCODING; Name: 'SEND_INTERNET_ENCODING'), // do not localize
    (Tag: PR_BUSINESS_ADDRESS_CITY; Name: 'BUSINESS_ADDRESS_CITY'), // do not localize
    (Tag: PR_BUSINESS_ADDRESS_COUNTRY; Name: 'BUSINESS_ADDRESS_COUNTRY'), // do not localize
    (Tag: PR_BUSINESS_ADDRESS_POSTAL_CODE; Name: 'BUSINESS_ADDRESS_POSTAL_CODE'), // do not localize
    (Tag: PR_BUSINESS_ADDRESS_STATE_OR_PROVINCE; Name: 'BUSINESS_ADDRESS_STATE_OR_PROVINCE'), // do not localize
    (Tag: PR_BUSINESS_ADDRESS_STREET; Name: 'BUSINESS_ADDRESS_STREET'), // do not localize
    (Tag: PR_RECIPIENT_TYPE; Name: 'RECIPIENT_TYPE') // do not localize
      );
var
  I: Integer;
  PropID: ULONG;
begin
  Result := '';
  PropID := PROP_ID(PropValue.ulPropTag);
  for I := Low(TagNames) to High(TagNames) do
    if PROP_ID(TagNames[I].Tag) = PropID then
    begin
      Result := TagNames[I].Name;
      Break;
    end;
  if Result = '' then Result := Format('[%x]', [PropID]);
end;

{ TWABContactSource }

function TWABContactSource.Add(Value: TContact): TContact;
var
  WabEntryID, WabNewEntryID: PEntryID;
  WabEntryIDSize, WabNewEntryIDSize: ULONG;
  Wnd: ULONG;
  Res: HResult;
  Contact: TWABContact;
begin
  Contact := New as TWABContact;
  Contact.Clone(Value);
  Contact.LinkedContact := Value;
  Value.LinkedContact := Contact;
  Contacts.Add(Contact);

  { TODO : Create new WAB item }
{  OleCheck(HrGetWABTemplateID(MAPI_MAILUSER, WabEntryIDSize, WabEntryID));
  Wnd := Application.Handle;
  Res := AddrBook.NewEntry(Wnd, 0, 0, nil, WabEntryIDSize, WabEntryID,
    WabNewEntryIDSize, WabNewEntryID);
  if Res <> MAPI_E_USER_CANCEL then OleCheck(Res);}

  with Contact.WABData do begin
    Values['TITLE'] := Contact.Title; // do not localize
    Values['GIVEN_NAME'] := Contact.Name; // do not localize
    Values['SURNAME'] := Contact.SurName; // do not localize
    Values['COMPANY_NAME'] := Contact.Organization; // do not localize
    Values['EMAIL_ADDRESS'] := Contact.Email; // do not localize
    Values['HOME_TELEPHONE_NUMBER'] := Contact.HomePhone; // do not localize
    Values['OFFICE_TELEPHONE_NUMBER'] := Contact.WorkPhone; // do not localize
    Values['MOBILE_TELEPHONE_NUMBER'] := Contact.CellPhone; // do not localize
    Values['HOME_FAX_NUMBER'] := Contact.FaxPhone; // do not localize
    Values['OTHER_TELEPHONE_NUMBER'] := Contact.OtherPhone; // do not localize

    { TODO : Write it to WAB }

    Contact.ID := Values['ENTRYID']; // do not localize
  end;

  Result := Contact;
end;

procedure TWABContactSource.CloseWAB;
begin
  AddrBook := nil;
  WabObject := nil;
end;

procedure TWABContactSource.Delete(Contact: TContact);
var
  Container: IABContainer;
  WabEntryID: PEntryID;
  WabEntryIDSize, ObjType: ULONG;
  BinArray: TSBinaryArray;
begin
  with Contact as TWABContact do begin
    OleCheck(AddrBook.GetPAB(WabEntryIDSize, WabEntryID));
    OleCheck(AddrBook.OpenEntry(WabEntryIDSize, WabEntryID, nil, 0, ObjType, IUnknown(Container)));
    BinArray.cValues := 1;
//    BinArray.lpbin := EntryIDData;  // ID to delete 
    OleCheck(Container.DeleteEntries(PEntryList(@BinArray), 0));
    OleCheck(WabObject.FreeBuffer(WabEntryID));

    WABData.Clear;
  end;
end;

destructor TWABContactSource.Destroy;
begin
  CloseWab;

  inherited;
end;

procedure TWABContactSource.EntryIDDataToWABData(EntryIDData: PSBinary; WABData: TStringList);
var MailUser: IMailUser;
    ObjType: ULONG;
    Count: Integer;
    Details: PSPropsArray;
    I: Integer;
begin
  WABData.Clear;
  if EntryIDData = nil then Exit;

  ObjType := 0;
  OleCheck(AddrBook.OpenEntry(EntryIDData^.cb, EntryIDData^.lpb, nil, 0, ObjType, IUnknown(MailUser)));
  OleCheck(MailUser.GetProps(nil, 0, @Count, PSPropValue(Details)));
  try
    for I := 0 to Count - 1 do
      WABData.Add(SPropValueToTypeStr(Details[I]) + WABData.NameValueSeparator + SPropValueToStr(Details[I]));
  finally
    OleCheck(WabObject.FreeBuffer(Details));
  end;
end;

procedure TWABContactSource.FreeSBinary(var P: PSBinary);
begin
  if P = nil then Exit;
  FreeMem(P.lpb);
  Dispose(P);
  P := nil;
end;

procedure TWABContactSource.FreeSRowSet(var P: PSRowSet);
var
  I: Integer;
begin
  for I := 0 to P^.cRows - 1 do
    OleCheck(WabObject.FreeBuffer(P^.aRow[I].lpProps));
  OleCheck(WabObject.FreeBuffer(P));
  P := nil;
end;

function TWABContactSource.GetName: String;
begin
  Result := 'WAB'; //TODO: localize?
end;

procedure TWABContactSource.Load;
const
  TableColumns: record // SizedSPropTagArray macro
    Count: ULONG;
    Definition: array[0..4] of ULONG;
  end = (
    Count: 5;
    Definition:
      (PR_DISPLAY_NAME,
       PR_EMAIL_ADDRESS,
       PR_PERSONAL_HOME_PAGE,
       PR_ENTRYID,
       PR_OBJECT_TYPE);
   );
var Container: IABContainer;
    EntryID: PEntryID;
    EntryIDSize, ObjType: ULONG;
    Table: IMAPITable;
    TableRow: PSRowSet;
    EntryIDData: PSBinary;
    Contact: TWABContact;
    WabData: TStringList;
begin
  if not WabApiLoaded then Exit;

  OpenWAB;

  OleCheck(AddrBook.GetPAB(EntryIDSize, EntryID));
  OleCheck(AddrBook.OpenEntry(EntryIDSize, EntryID, nil, 0,
    ObjType, IUnknown(Container)));
  OleCheck(WabObject.FreeBuffer(EntryID));

  OleCheck(Container.GetContentsTable(0, Table));
  OleCheck(Table.SetColumns(@TableColumns, 0));
  OleCheck(Table.SeekRow(BOOKMARK_BEGINNING, 0, nil));

  WABData := TStringList.Create;
  try
    repeat
      OleCheck(Table.QueryRows(1, 0, TableRow));
      if TableRow.cRows > 0 then with TableRow^.aRow[0] do begin
        if ULONG(lpProps[4].Value.l) in [MAPI_MAILUSER, MAPI_DISTLIST] then begin
          EntryID := lpProps[3].Value.bin.lpb;
          EntryIDSize := lpProps[3].Value.bin.cb;

          OleCheck(WabObject.AllocateBuffer(Sizeof(TSBinary), Pointer(EntryIDData)));
          OleCheck(WabObject.AllocateMore(EntryIDSize, EntryIDData, Pointer(EntryIDData.lpb)));
          CopyMemory(EntryIDData.lpb, EntryID, EntryIDSize);
          EntryIDData^.cb := EntryIDSize;

          EntryIDDataToWABData(EntryIDData, WABData);

          Contact := Contacts.FindByID(WABData.Values['ENTRYID']) as TWABContact; // do not localize

          if Assigned(Contact) then begin
            Contact.WABData := WABData;
          end
          else begin
            Contact := New as TWABContact;
            Contact.ID := WABData.Values['ENTRYID']; // do not localize
            Contact.SyncHash := Contact.Hash;
            Contact.WABData := WABData;
            Contacts.Add(Contact);
          end;

          Read(Contact, WABData);

          Application.ProcessMessages;
        end;
        FreeSRowSet(TableRow);
      end
      else
        Break;
    until False;
  finally
    WABData.Free;
  end;
end;

function TWABContactSource.New: TContact;
begin
  Result := TWABContact.Create(Self);
end;

procedure TWABContactSource.OpenWAB;
var
  WP: TWabParam;
begin
  { Read "HKEY_CURRENT_USER\Software\Microsoft\WAB\WAB4\Wab File Name" default key for .WAB filename }
  ZeroMemory(@WP, Sizeof(WP));
  WP.cbSize := Sizeof(WP);
  WP.szFileName := PChar(FFilePath);
  WP.hwnd := Application.Handle;
  OleCheck(WabOpen(AddrBook, WabObject, @WP, 0));
end;

procedure TWABContactSource.Read(Contact: TWABContact; WABData: TStringList);
begin
  with WABData do begin
    Contact.Title := Values['TITLE']; // do not localize
    Contact.Name := Values['GIVEN_NAME']; // do not localize
    Contact.SurName := Values['SURNAME']; // do not localize
    Contact.Organization := Values['COMPANY_NAME']; // do not localize
    Contact.Email := Values['EMAIL_ADDRESS']; // do not localize
    Contact.HomePhone := DeformatPhoneNumber(Values['HOME_TELEPHONE_NUMBER']); // do not localize
    Contact.WorkPhone := DeformatPhoneNumber(Values['OFFICE_TELEPHONE_NUMBER']); // do not localize
    Contact.CellPhone := DeformatPhoneNumber(Values['MOBILE_TELEPHONE_NUMBER']); // do not localize
    Contact.FaxPhone := DeformatPhoneNumber(Values['HOME_FAX_NUMBER']); // do not localize
    Contact.OtherPhone := DeformatPhoneNumber(Values['OTHER_TELEPHONE_NUMBER']); // do not localize
  end;
end;

procedure TWABContactSource.Update(Contact, Value: TContact);
begin
  with (Contact as TWABContact).WABData do begin
    Values['TITLE'] := Value.Title; // do not localize
    Values['GIVEN_NAME'] := Value.Name; // do not localize
    Values['SURNAME'] := Value.SurName; // do not localize
    Values['COMPANY_NAME'] := Value.Organization; // do not localize
    Values['EMAIL_ADDRESS'] := Value.Email; // do not localize
    Values['HOME_TELEPHONE_NUMBER'] := Value.HomePhone; // do not localize
    Values['OFFICE_TELEPHONE_NUMBER'] := Value.WorkPhone; // do not localize
    Values['MOBILE_TELEPHONE_NUMBER'] := Value.CellPhone; // do not localize
    Values['HOME_FAX_NUMBER'] := Value.FaxPhone; // do not localize
    Values['OTHER_TELEPHONE_NUMBER'] := Value.OtherPhone; // do not localize

    { TODO : Write it to WAB 
    buffer := 'BEGIN:VCARD'+sLinebreak+
              'END:VCARD'+sLinebreak;
    OleCheck(WabObject.VCardRetrieve(AddrBook, WAB_VCARD_STREAM, buffer, MailUser));
    OleCheck(MailUser.SaveChanges(FORCE_SAVE));
    }
  end;
end;

{ TWABContact }

constructor TWABContact.Create(ContactSource: TContactSource);
begin
  inherited;

  FWABData := TStringList.Create;
end;

destructor TWABContact.Destroy;
begin
  FWABData.Free;

  inherited;
end;

function TWABContact.Exists: Boolean;
begin
  Result := not (FWABData.Count = 0);
end;

procedure TWABContact.SetWABData(const Value: TStringList);
begin
  FWABData.Assign(Value);
end;

end.
