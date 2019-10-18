unit uEnvio;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Edit, FMX.EditBox, FMX.SpinBox,
  FMX.ScrollBox, FMX.Memo;

type
  TfrmEnvio = class(TForm)
    rctRetangulo: TRectangle;
    pnlSeparador: TPanel;
    Panel1: TPanel;
    Rectangle1: TRectangle;
    brnEnviar: TButton;
    imgIcone: TImage;
    lblEmail: TLabel;
    gbxConexao: TGroupBox;
    gbxEmail: TGroupBox;
    edtHost: TEdit;
    Label1: TLabel;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    gbxDestinatario: TGroupBox;
    gbxAnexo: TGroupBox;
    edtRemetente: TEdit;
    edtNome: TEdit;
    edtDestinatario: TEdit;
    edtAssunto: TEdit;
    mmoCorpo: TMemo;
    edtAnexo: TEdit;
    Label2: TLabel;
    sbxPorta: TSpinBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    gbxRemetente: TGroupBox;
    procedure brnEnviarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEnvio: TfrmEnvio;

implementation

uses
 uMensagem, uEmail;

{$R *.fmx}

{ TfrmEmail }

procedure TfrmEnvio.brnEnviarClick(Sender: TObject);
begin
  try
    Email.EnviarEmail(Self, sbxPorta.Text, edtHost.Text, edtUsuario.Text,
    edtSenha.Text, edtRemetente.Text, edtNome.Text, edtDestinatario.Text, edtAssunto.Text,
    mmoCorpo.Text, edtAnexo.Text);
    Mensagem.Informacao('Mensagem enviada com sucesso!');
  except
    on E: Exception do
      Mensagem.Erro(E.message);
  end;
end;

end.
