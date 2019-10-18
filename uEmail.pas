unit uEmail;

interface

uses
  System.Classes;

type
  TEmail = class
  public
    procedure EnviarEmail(Owner: TComponent; Porta: string; Host, Usuario, Senha, Remetente, Nome,
  Destinatario, Assunto, Corpo, Anexo: string);
  end;

var
  Email: TEmail;

implementation

uses
  System.SysUtils, IdSMTP, IdSSLOpenSSL, IdMessage, IdText, IdAttachmentFile,
  IdExplicitTLSClientServerBase;


{ TEmail }

procedure TEmail.EnviarEmail(Owner: TComponent; Porta: string; Host, Usuario, Senha, Remetente, Nome,
  Destinatario, Assunto, Corpo, Anexo: string);
var
  IdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL;
  IdSMTP: TIdSMTP;
  IdMessage: TIdMessage;
  IdText: TIdText;
  sAnexo: string;
begin
  IdSSLIOHandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create(Owner);
  IdSMTP := TIdSMTP.Create(Owner);
  IdMessage := TIdMessage.Create(Owner);

  try
    IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
    IdSSLIOHandlerSocket.SSLOptions.Mode := sslmClient;

    IdSMTP.IOHandler := IdSSLIOHandlerSocket;
    IdSMTP.UseTLS := utUseImplicitTLS;
    IdSMTP.AuthType := satDefault;
    IdSMTP.Port := StrToInt(Porta);
    IdSMTP.Host := Host;
    IdSMTP.Username := Usuario;
    IdSMTP.Password := Senha;

    IdMessage.From.Address := Remetente;
    IdMessage.From.Name := Nome;
    IdMessage.ReplyTo.EMailAddresses := IdMessage.From.Address;
    IdMessage.Recipients.Add.Text := Destinatario;
    IdMessage.Subject := Assunto;
    IdMessage.Encoding := meMIME;

    IdText := TIdText.Create(IdMessage.MessageParts);
    IdText.Body.Add(Corpo);
    IdText.ContentType := 'text/plain; charset=iso-8859-1';

    sAnexo := Anexo;
    if FileExists(sAnexo) then
      TIdAttachmentFile.Create(IdMessage.MessageParts, sAnexo);

    try
      IdSMTP.Connect;
      IdSMTP.Authenticate;
    except
      on E:Exception do
      begin
        raise Exception.Create('Erro na conexão ou autenticação: ' + E.Message);
      end;
    end;

    try
      IdSMTP.Send(IdMessage);

    except
      On E:Exception do
      begin
        raise Exception.Create('Erro ao enviar a mensagem: ' + E.Message);
      end;
    end;
  finally
    IdSMTP.Disconnect;
    UnLoadOpenSSLLibrary;
    FreeAndNil(IdMessage);
    FreeAndNil(IdSSLIOHandlerSocket);
    FreeAndNil(IdSMTP);
  end;
end;

initialization

if (not Assigned(Email)) then
  Email := TEmail.Create;

finalization

if (Assigned(Email)) then
  FreeAndNil(Email);

end.
