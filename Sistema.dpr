program Sistema;

uses
  System.StartUpCopy,
  FMX.Forms,
  uCadastro in 'uCadastro.pas' {frmPrincipal},
  uValidacao in 'uValidacao.pas',
  uMascara in 'uMascara.pas',
  uEndereco in 'uEndereco.pas',
  uRequisicao in 'uRequisicao.pas',
  uCliente in 'uCliente.pas',
  uEnvio in 'uEnvio.pas' {frmEnvio},
  uMensagem in 'uMensagem.pas',
  uEmail in 'uEmail.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmEnvio, frmEnvio);
  Application.Run;
end.
