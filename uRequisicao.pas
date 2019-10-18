unit uRequisicao;

interface

uses
  uEndereco, REST.Client;

type
  TRequisicao = class
  private
    objRESTClient: TRESTClient;
    objRESTRequest: TRESTRequest;
  public
    constructor Create;
    destructor Destroy; override;
    function ObterEndereco(CEP: string): TEndereco;
  end;

var
  Requisicao: TRequisicao;

implementation

uses
  System.SysUtils, System.JSON, Rest.JSON;

{ TRequisicao }

constructor TRequisicao.Create;
begin
  objRESTClient := TRESTClient.Create(nil);
  objRESTRequest := TRESTRequest.Create(nil);
  objRESTRequest.Client := objRESTClient;
end;

destructor TRequisicao.Destroy;
begin
  if (Assigned(objRESTRequest)) then
    FreeAndNil(objRESTRequest);

  if (Assigned(objRESTClient)) then
    FreeAndNil(objRESTClient);
  inherited;
end;

function TRequisicao.ObterEndereco(CEP: string): TEndereco;
var
  stJSON: string;
begin
  objRESTClient.BaseURL := 'https://viacep.com.br/ws/' + CEP + '/json/';
  objRESTRequest.Execute;
  stJSON := objRESTRequest.Response.Content;
  Result := TJson.JSONToObject<TEndereco>(stJSON);
end;

initialization

if (not Assigned(Requisicao)) then
  Requisicao := TRequisicao.Create;

finalization

if (Assigned(Requisicao)) then
  FreeAndNil(Requisicao);

end.
