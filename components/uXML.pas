unit uXML; // do not localize

// simple wrapper around opensource XML parse by Jan Verhoeven
// just to make live a little easier :)

interface

uses JanXMLParser2;

type TXMLNode = class(TJanXMLNode2)
     private
      function GetNextSibling: TXMLNode;
      function GetFirstChild: TXMLNode;
      function GetContent: string;
      procedure SetContent(const Value: string);
      function GetTagName: string;
      procedure SetTagName(const Value: string);

      function GetXML: string;

     public
      function AddChild(TagName: string = ''; Content: string = ''): TXMLNode;
      procedure AddAttribute(Name: string; Content: string = '');
      function FindOrAddNewChild(Name: string): TXMLNode;
      function GetChildByName(Name: string; Descent: boolean = false): TXMLNode;


      function GetAttribute(AttributeName: string): string;
      procedure SetAttribute(AttributeName: string; const Value: string);

      procedure Clear;

      property XML: string read GetXML;
      property Content: string read GetContent write SetContent;

      {$WARNINGS OFF}   // unavoidable warnings
      property FirstChild: TXMLNode read GetFirstChild;
      property NextSibling: TXMLNode read GetNextSibling;
      {$WARNINGS ON}

      property TagName: string read GetTagName write SetTagName;
     end;

     TXML = class(TObject)
     private
      fJanXMLParser2: TjanXMLParser2;

      function GetRootNode: TXMLNode;
      function GetTagName: string;
      procedure SetTagName(const Value: string);

      function GetFirstChild: TXMLNode;
      function GetXML: string;
      procedure SetXML(const Value: string);
     public
      constructor Create;
      destructor Destroy; override;

      procedure Load(FileName: string);

      procedure Save(FileName: string);

      function AddChild(TagName: string = ''; Content: string = ''): TXMLNode;

      property RootNode: TXMLNode read GetRootNode;
      property FirstChild: TXMLNode read GetFirstChild;
      property TagName: string read GetTagName write SetTagName;

      property XML: string read GetXML write SetXML;
     end;

implementation

uses Classes;

{ TXMLNode }

procedure TXMLNode.AddAttribute(Name, Content: string);
begin
 Self[Name] := Content;
end;

function TXMLNode.AddChild(TagName, Content: string): TXMLNode;
begin
 result := TXMLNode.Create();
 result.Name := TagName;

 result.Content := Content;

 addNode(result);
end;

procedure TXMLNode.Clear;
begin
 while Assigned(FirstChild) do
  deleteNode(FirstChild);
end;

function TXMLNode.FindOrAddNewChild(Name: string): TXMLNode;
begin
 result := TXMLNode(getChildByName(Name));

 if not assigned(result) then
  result := AddChild(Name);
end;

function TXMLNode.GetAttribute(AttributeName: string): string;
begin
 result := Self[AttributeName];
end;

function TXMLNode.GetChildByName(Name: string; Descent: boolean): TXMLNode;
begin
 result := TXMLNode(TJanXMLNode2(Self).GetChildByName(Name, Descent));  // <-- dit checken
end;

function TXMLNode.GetContent: string;
begin
 result := Self.Text;
end;

function TXMLNode.GetFirstChild: TXMLNode;
begin
 result := TXMLNode(TJanXMLNode2(Self).FirstChild);
end;

function TXMLNode.GetNextSibling: TXMLNode;
begin
 result := TXMLNode(TJanXMLNode2(Self).NextSibling);
end;

function TXMLNode.GetTagName: string;
begin
 result := name;
end;

function TXMLNode.GetXML: string;
begin
 with TJanXMLParser2.Create() do
 try
  Name := 'faulty node'; // do not localize
  addNode(Self.cloneNode);
  result := XML;
 finally
  Free();
 end;

 if result <> '' then
 with TStringList.Create() do
 try
  Text := result;
  Delete(0);
  result := Text;
 finally
  Free();
 end;
end;

procedure TXMLNode.SetAttribute(AttributeName: string; const Value: string);
begin
 Self[AttributeName] := Value;
end;

procedure TXMLNode.SetContent(const Value: string);
begin
 Text := Value;
end;

procedure TXMLNode.SetTagName(const Value: string);
begin
 name := Value;
end;

{ TXML }

function TXML.AddChild(TagName, Content: string): TXMLNode;
begin
 result := RootNode.AddChild(TagName, Content)
end;

constructor TXML.Create;
begin
 fJanXMLParser2 := TJanXMLParser2.create();
 fJanXMLParser2.Name := 'unnamed'; // do not localize
end;

destructor TXML.Destroy;
begin
 fJanXMLParser2.Free();

 inherited;
end;

function TXML.GetFirstChild: TXMLNode;
begin
 result := RootNode.FirstChild;
end;

function TXML.GetRootNode: TXMLNode;
begin
 result := TXMLNode(fJanXMLParser2);
end;

function TXML.GetTagName: string;
begin
 result := fJanXMLParser2.name;
end;

function TXML.GetXML: string;
begin
 result := fJanXMLParser2.xml;
end;

procedure TXML.Load(FileName: string);
begin
 fJanXMLParser2.LoadXML(FileName);
end;

procedure TXML.Save(FileName: string);
begin
 fJanXMLParser2.SaveXML(FileName);
end;

procedure TXML.SetTagName(const Value: string);
begin
 fJanXMLParser2.name := Value;
end;

procedure TXML.SetXML(const Value: string);
begin
 fJanXMLParser2.xml := Value;
end;

end.
