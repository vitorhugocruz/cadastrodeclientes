unit uCadastro;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Rtti, FMX.Grid.Style,
  FMX.Grid, FMX.ScrollBox, FMX.Edit, FMX.ListBox, FMX.DialogService,
  IPPeerClient, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  Data.Bind.Controls, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Grid, Data.DB,
  Datasnap.DBClient, Data.Bind.DBScope, FMX.Layouts, Fmx.Bind.Navigator;

type
  TfrmPrincipal = class(TForm)
    pnlSeparador: TPanel;
    rctRetangulo: TRectangle;
    lblCadastro: TLabel;
    imgIcone: TImage;
    gbxDados: TGroupBox;
    gbxEndereco: TGroupBox;
    edtNome: TEdit;
    edtIdentidade: TEdit;
    edtTelefone: TEdit;
    edtCPF: TEdit;
    edtEmail: TEdit;
    lblNome: TLabel;
    lblIdentidade: TLabel;
    lblCPF: TLabel;
    lblTelefone: TLabel;
    lblEmail: TLabel;
    lblCEP: TLabel;
    edtCEP: TEdit;
    lblLogradouro: TLabel;
    edtLogradouro: TEdit;
    lblNumero: TLabel;
    edtNumero: TEdit;
    lblComplemento: TLabel;
    edtComplemento: TEdit;
    lblBairro: TLabel;
    edtBairro: TEdit;
    lblCidade: TLabel;
    edtCidade: TEdit;
    lblEstado: TLabel;
    lblPais: TLabel;
    edtPais: TEdit;
    Rectangle1: TRectangle;
    Panel1: TPanel;
    btnEnviarRegistro: TButton;
    BindNavigator1: TBindNavigator;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    Grid1: TGrid;
    cdsClientDataSet: TClientDataSet;
    LinkGridToDataSource1: TLinkGridToDataSource;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    cdsClientDataSetNome: TStringField;
    cdsClientDataSetIdentidade: TStringField;
    cdsClientDataSetCPF: TStringField;
    cdsClientDataSetTelefone: TStringField;
    cdsClientDataSetEmail: TStringField;
    cdsClientDataSetCEP: TStringField;
    cdsClientDataSetLogradouro: TStringField;
    cdsClientDataSetNumero: TStringField;
    cdsClientDataSetComplemento: TStringField;
    cdsClientDataSetBairro: TStringField;
    cdsClientDataSetCidade: TStringField;
    cdsClientDataSetEstado: TStringField;
    cdsClientDataSetPais: TStringField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    LinkControlToField6: TLinkControlToField;
    LinkControlToField7: TLinkControlToField;
    LinkControlToField8: TLinkControlToField;
    LinkControlToField9: TLinkControlToField;
    LinkControlToField10: TLinkControlToField;
    LinkControlToField11: TLinkControlToField;
    LinkControlToField12: TLinkControlToField;
    LinkControlToField13: TLinkControlToField;
    edtEstado: TEdit;
    btnEnviarDados: TButton;
    procedure edtCPFExit(Sender: TObject);
    procedure edtCPFKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edtCPFChange(Sender: TObject);
    procedure edtCEPChange(Sender: TObject);
    procedure edtCEPKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edtCEPExit(Sender: TObject);
    procedure edtEmailExit(Sender: TObject);
    procedure btnEnviarRegistroClick(Sender: TObject);
    procedure btnEnviarDadosClick(Sender: TObject);
  private
    { Private declarations }

    procedure Enviar(Todos: Boolean);
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  uValidacao, uMascara, uEndereco, uRequisicao, uCliente, XMLIntf, XMLDoc,
  uEmail, uMensagem, uEnvio;

{$R *.fmx}

procedure TfrmPrincipal.btnEnviarDadosClick(Sender: TObject);
begin
  Enviar(True);
end;

procedure TfrmPrincipal.btnEnviarRegistroClick(Sender: TObject);
begin
  Enviar(False);
end;

procedure TfrmPrincipal.edtCEPChange(Sender: TObject);
begin
  edtCEP.Text := Mascara.AplicarMascara(edtCEP.Text, CONST_MASCARA_CEP);
end;

procedure TfrmPrincipal.edtCEPExit(Sender: TObject);
var
  stCEP: string;
  Endereco: TEndereco;
begin
  if (not edtCEP.Text.IsEmpty) then
  begin
    stCEP := Mascara.RemoverMascara(edtCEP.Text);

    if (Validacao.ValidarCEP(stCEP)) then
    begin
      Endereco := Requisicao.ObterEndereco(stCEP);

      if (Assigned(Endereco)) then
      begin

        if not ((cdsClientDataSet.State = TDataSetState.dsEdit) or
                (cdsClientDataSet.State = TDataSetState.dsInsert)) then
          cdsClientDataSet.Edit;

         cdsClientDataSet.FieldByName('CEP').AsString := Endereco.CEP;
         cdsClientDataSet.FieldByName('Logradouro').AsString := Endereco.Logradouro;
         cdsClientDataSet.FieldByName('Complemento').AsString := Endereco.Complemento;
         cdsClientDataSet.FieldByName('Bairro').AsString := Endereco.Bairro;
         cdsClientDataSet.FieldByName('Cidade').AsString := Endereco.Localidade;
         cdsClientDataSet.FieldByName('Estado').AsString := Endereco.UF;
      end
      else
        Mensagem.Erro('Não foi possível obter os dados automaticamente.');
    end
    else
      Mensagem.Erro('O CEP informado é inválido.' + #13 +
        'Certifique-se que foi digitado corretamente.');
  end;
end;

procedure TfrmPrincipal.edtCEPKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Mascara.TratarMascara(edtCEP, Key, KeyChar, CONST_MASCARA_CEP);
end;

procedure TfrmPrincipal.edtCPFChange(Sender: TObject);
begin
  edtCPF.Text := Mascara.AplicarMascara(edtCPF.Text, CONST_MASCARA_CPF);
end;

procedure TfrmPrincipal.edtCPFExit(Sender: TObject);
var
  stCPF: string;
begin
  if (not edtCPF.Text.IsEmpty) then
  begin
    stCPF := Mascara.RemoverMascara(edtCPF.Text);
    if (not Validacao.ValidarCPF(stCPF)) then
      Mensagem.Erro('O CPF informado é inválido.' + #13 +
        'Certifique-se que foi digitado corretamente.');
  end;
end;

procedure TfrmPrincipal.edtCPFKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  Mascara.TratarMascara(edtCPF, Key, KeyChar, CONST_MASCARA_CPF);
end;

procedure TfrmPrincipal.edtEmailExit(Sender: TObject);
var
  stEmail: string;
begin
  if (not edtEmail.Text.IsEmpty) then
  begin
    stEmail := edtEmail.Text;
    if (not Validacao.ValidarEmail(stEmail)) then
      Mensagem.Erro('O Email informado é inválido.' + #13 +
        'Certifique-se que foi digitado corretamente.');
  end;
end;

procedure TfrmPrincipal.Enviar(Todos: Boolean);
var
  objXMLDoc: IXMLDocument;
  stArquivo: string;
begin
  try
    if (Todos) then
    begin
      stArquivo := 'C:\Windows\Temp\Dados.xml';
      cdsClientDataSet.SaveToFile(stArquivo);
    end
    else
    begin

      objXMLDoc := TXMLDocument.Create(nil);
      objXMLDoc.Active := True;
      objXMLDoc.Version := '1.0';

      objXMLDoc.DocumentElement := objXMLDoc.CreateNode('cliente', ntElement, '');
      objXMLDoc.DocumentElement.AddChild('nome').Text := edtNome.Text;
      objXMLDoc.DocumentElement.AddChild('identidade').Text := edtIdentidade.Text;
      objXMLDoc.DocumentElement.AddChild('cpf').Text := edtCPF.Text;
      objXMLDoc.DocumentElement.AddChild('telefone').Text := edtTelefone.Text;
      objXMLDoc.DocumentElement.AddChild('email').Text := edtEmail.Text;
      objXMLDoc.DocumentElement.AddChild('cep').Text := edtCEP.Text;
      objXMLDoc.DocumentElement.AddChild('logradouro').Text := edtLogradouro.Text;
      objXMLDoc.DocumentElement.AddChild('numero').Text := edtNumero.Text;
      objXMLDoc.DocumentElement.AddChild('complemento').Text := edtComplemento.Text;
      objXMLDoc.DocumentElement.AddChild('bairro').Text := edtBairro.Text;
      objXMLDoc.DocumentElement.AddChild('cidade').Text := edtCidade.Text;
      objXMLDoc.DocumentElement.AddChild('estado').Text := edtEstado.Text;
      objXMLDoc.DocumentElement.AddChild('pais').Text := edtPais.Text;

      stArquivo := 'C:\Windows\Temp\Registro.xml';
      objXMLDoc.SaveToFile(stArquivo);
    end;

    frmEnvio := TfrmEnvio.Create(Self);
    frmEnvio.edtAnexo.Text := stArquivo;
    frmEnvio.ShowModal;

  except
    Mensagem.Erro('Ocorreu um erro ao exportar o arquivo.');
  end;

end;

end.
