unit uXMLContactSync; // do not localize

{
*******************************************************************************
* Descriptions: Automaticly Generated Unit for the XMLFmaSync DOM
* $Source: /cvsroot/fma/fma/uXMLContactSync.pas,v $
* $Locker:  $
*
* Change Log:
* $Log: uXMLContactSync.pas,v $
*
}

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLFmaSyncType = interface;
  IXMLContactType = interface;
  IXMLFMAType = interface;
  IXMLExternType = interface;

{ IXMLFmaSyncType }

  IXMLFmaSyncType = interface(IXMLNodeCollection)
    ['{CA4B2EEA-C70C-4AB6-B679-E9D7DD9122B9}'] // do not localize
    { Property Accessors }
    function Get_Contact(Index: Integer): IXMLContactType;
    { Methods & Properties }
    function Add: IXMLContactType;
    function Insert(const Index: Integer): IXMLContactType;
    property Contact[Index: Integer]: IXMLContactType read Get_Contact; default;
  end;

{ IXMLContactType }

  IXMLContactType = interface(IXMLNode)
    ['{5A2C5693-BE46-49BE-BA70-FC2AEBD2399A}'] // do not localize
    { Property Accessors }
    function Get_SyncID: Integer;
    function Get_FMA: IXMLFMAType;
    function Get_Extern: IXMLExternType;
    procedure Set_SyncID(Value: Integer);
    { Methods & Properties }
    property SyncID: Integer read Get_SyncID write Set_SyncID;
    property FMA: IXMLFMAType read Get_FMA;
    property Extern: IXMLExternType read Get_Extern;
  end;

{ IXMLFMAType }

  IXMLFMAType = interface(IXMLNode)
    ['{622B347A-E707-4BD1-9A40-249C4BC27DBA}'] // do not localize
    { Property Accessors }
    function Get_ID: Variant;
    function Get_Hash: WideString;
    procedure Set_ID(Value: Variant);
    procedure Set_Hash(Value: WideString);
    { Methods & Properties }
    property ID: Variant read Get_ID write Set_ID;
    property Hash: WideString read Get_Hash write Set_Hash;
  end;

{ IXMLExternType }

  IXMLExternType = interface(IXMLNode)
    ['{8F521746-8EE0-44B2-903D-9B7B038CE01C}'] // do not localize
    { Property Accessors }
    function Get_ID: Variant;
    function Get_Hash: WideString;
    procedure Set_ID(Value: Variant);
    procedure Set_Hash(Value: WideString);
    { Methods & Properties }
    property ID: Variant read Get_ID write Set_ID;
    property Hash: WideString read Get_Hash write Set_Hash;
  end;

{ Forward Decls }

  TXMLFmasyncType = class;
  TXMLContactType = class;
  TXMLFMAType = class;
  TXMLExternType = class;

{ TXMLFmasyncType }

  TXMLFmasyncType = class(TXMLNodeCollection, IXMLFmaSyncType)
  protected
    { IXMLFmaSyncType }
    function Get_Contact(Index: Integer): IXMLContactType;
    function Add: IXMLContactType;
    function Insert(const Index: Integer): IXMLContactType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLContactType }

  TXMLContactType = class(TXMLNode, IXMLContactType)
  protected
    { IXMLContactType }
    function Get_SyncID: Integer;
    function Get_FMA: IXMLFMAType;
    function Get_Extern: IXMLExternType;
    procedure Set_SyncID(Value: Integer);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLFMAType }

  TXMLFMAType = class(TXMLNode, IXMLFMAType)
  protected
    { IXMLFMAType }
    function Get_ID: Variant;
    function Get_Hash: WideString;
    procedure Set_ID(Value: Variant);
    procedure Set_Hash(Value: WideString);
  end;

{ TXMLExternType }

  TXMLExternType = class(TXMLNode, IXMLExternType)
  protected
    { IXMLExternType }
    function Get_ID: Variant;
    function Get_Hash: WideString;
    procedure Set_ID(Value: Variant);
    procedure Set_Hash(Value: WideString);
  end;

{ Global Functions }

function Getfmasync(Doc: IXMLDocument): IXMLFmaSyncType;
function Loadfmasync(const FileName: WideString): IXMLFmaSyncType;
function Newfmasync: IXMLFmaSyncType;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function Getfmasync(Doc: IXMLDocument): IXMLFmaSyncType;
begin
  Result := Doc.GetDocBinding('fmasync', TXMLFmasyncType, TargetNamespace) as IXMLFmaSyncType; // do not localize
end;

function Loadfmasync(const FileName: WideString): IXMLFmaSyncType;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('fmasync', TXMLFmasyncType, TargetNamespace) as IXMLFmaSyncType; // do not localize
end;

function Newfmasync: IXMLFmaSyncType;
begin
  Result := NewXMLDocument.GetDocBinding('fmasync', TXMLFmasyncType, TargetNamespace) as IXMLFmaSyncType; // do not localize
end;

{ TXMLFmasyncType }

procedure TXMLFmasyncType.AfterConstruction;
begin
  RegisterChildNode('contact', TXMLContactType); // do not localize
  ItemTag := 'contact'; // do not localize
  ItemInterface := IXMLContactType;
  inherited;
end;

function TXMLFmasyncType.Get_Contact(Index: Integer): IXMLContactType;
begin
  Result := List[Index] as IXMLContactType;
end;

function TXMLFmasyncType.Add: IXMLContactType;
begin
  Result := AddItem(-1) as IXMLContactType;
end;

function TXMLFmasyncType.Insert(const Index: Integer): IXMLContactType;
begin
  Result := AddItem(Index) as IXMLContactType;
end;

{ TXMLContactType }

procedure TXMLContactType.AfterConstruction;
begin
  RegisterChildNode('fma', TXMLFMAType); // do not localize
  RegisterChildNode('extern', TXMLExternType); // do not localize
  inherited;
end;

function TXMLContactType.Get_SyncID: Integer;
begin
  Result := AttributeNodes['syncid'].NodeValue; // do not localize
end;

procedure TXMLContactType.Set_SyncID(Value: Integer);
begin
  SetAttribute('syncid', Value); // do not localize
end;

function TXMLContactType.Get_FMA: IXMLFMAType;
begin
  Result := ChildNodes['fma'] as IXMLFMAType; // do not localize
end;

function TXMLContactType.Get_Extern: IXMLExternType;
begin
  Result := ChildNodes['extern'] as IXMLExternType; // do not localize
end;

{ TXMLFMAType }

function TXMLFMAType.Get_ID: Variant;
begin
  Result := AttributeNodes['id'].NodeValue; // do not localize
end;

procedure TXMLFMAType.Set_ID(Value: Variant);
begin
  SetAttribute('id', Value); // do not localize
end;

function TXMLFMAType.Get_Hash: WideString;
begin
  Result := AttributeNodes['hash'].Text; // do not localize
end;

procedure TXMLFMAType.Set_Hash(Value: WideString);
begin
  SetAttribute('hash', Value); // do not localize
end;

{ TXMLExternType }

function TXMLExternType.Get_ID: Variant;
begin
  Result := AttributeNodes['id'].NodeValue; // do not localize
end;

procedure TXMLExternType.Set_ID(Value: Variant);
begin
  SetAttribute('id', Value); // do not localize
end;

function TXMLExternType.Get_Hash: WideString;
begin
  Result := AttributeNodes['hash'].Text; // do not localize
end;

procedure TXMLExternType.Set_Hash(Value: WideString);
begin
  SetAttribute('hash', Value); // do not localize
end;

end. 