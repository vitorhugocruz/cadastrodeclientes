unit uEndereco;

interface

type
  TEndereco = class
  private
    Fcep: string;
    Flogradouro: string;
    Fcomplemento: string;
    Fbairro: string;
    Flocalidade: string;
    Fuf: string;
    Funidade: string;
    Fibge: string;
    Fgia: string;

  public
    property CEP: string read Fcep write Fcep;
    property Logradouro: string read Flogradouro write Flogradouro;
    property Complemento: string read Fcomplemento write Fcomplemento;
    property Bairro: string read Fbairro write Fbairro;
    property Localidade: string read Flocalidade write Flocalidade;
    property UF: string read Fuf write Fuf;
    property Unidade: string read Funidade write Funidade;
    property IBGE: string read Fibge write Fibge;
    property GIA: string read Fgia write Fgia;
  end;

implementation

end.
