unit uCliente;

interface

uses
  uEndereco;

type
  TCliente = class
  private
    Fnome: string;
    Tidentidade: string;
    Tcpf: string;
    Ttelefone: string;
    Temail: string;
    Fcep: string;
    Flogradouro: string;
    Fnumero: string;
    Fcomplemento: string;
    Fbairro: string;
    Fcidade: string;
    Festado: string;
    Fpais: string;
  public
    property Nome: string read Fnome write Fnome;
    property Identidade: string read Tidentidade write Tidentidade;
    property CPF: string read Tcpf write Tcpf;
    property Telefone: string read Ttelefone write Ttelefone;
    property Email: string read Temail write Temail;
    property CEP: string read Fcep write Fcep;
    property Logradouro: string read Flogradouro write Flogradouro;
    property Numero: string read Fnumero write Fnumero;
    property Complemento: string read Fcomplemento write Fcomplemento;
    property Bairro: string read Fbairro write Fbairro;
    property Cidade: string read Fcidade write Fcidade;
    property Estado: string read Festado write Festado;
    property Pais: string read Fpais write Fpais;
  end;

implementation

end.
