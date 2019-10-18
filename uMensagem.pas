unit uMensagem;

interface

type
  TMensagem = class
  public
    procedure Erro(Mensagem: string);
    procedure Informacao(Mensagem: string);
  end;

var
  Mensagem: TMensagem;

implementation

uses
  System.SysUtils,  FMX.DialogService, System.UITypes;

{ Mensagem }

procedure TMensagem.Erro(Mensagem: string);
begin
  TDialogService.MessageDialog(Mensagem, TMsgDlgType.mtError, [TMsgDlgBtn.mbOk],
    TMsgDlgBtn.mbOk, 0, nil);
end;


procedure TMensagem.Informacao(Mensagem: string);
begin
  TDialogService.MessageDialog(Mensagem, TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOk],
    TMsgDlgBtn.mbOk, 0, nil);
end;

initialization

if (not Assigned(Mensagem)) then
  Mensagem := TMensagem.Create;

finalization

if (Assigned(Mensagem)) then
  FreeAndNil(Mensagem);


end.
