unit uMascara;

interface

uses
  FMX.Objects, System.Classes, Rtti, TypInfo, FMX.Edit;

type
  TMascara = class
  public
    function AplicarMascara(Valor: string; Mascara: string): string;
    procedure TratarMascara(Campo: TEdit; var Key: Word; var KeyChar: Char;
      Mascara: string);
    function RemoverMascara(Valor: string): string;
  end;

var
  Mascara: TMascara;

const
  CONST_MASCARA_CPF = '999.999.999-99';
  CONST_MASCARA_CEP = '99999-999';

implementation

uses
  System.IOUtils, System.SysUtils, System.Types, System.UITypes,
  System.Character;


{ TMascara }

function TMascara.AplicarMascara(Valor, Mascara: string): string;
var
  stNovo: string;
  chM: Char;
  itM, itV: Integer;
const
{$IFDEF MSWINDOWS}
  N = 1;
{$ELSE}
  N = 0;
{$ENDIF}
begin
  stNovo := '';

  Valor := RemoverMascara(Valor);

  itV := 0 + N;
  for itM := 0 + N to Length(Mascara) - 1 + N do
  begin
    if (itV <= Length(Valor) - 1 + N) then
    begin
      chM := Mascara[itM];
      if (chM = '9') then
      begin
        stNovo := stNovo + Valor[itV];
        itV := itV + 1;
      end
      else
      begin
        stNovo := stNovo + chM;
      end;
    end;
  end;
  Result := stNovo;
end;

function TMascara.RemoverMascara(Valor: string): string;
begin
  Result := Valor;
  Result := Result.Replace('.', '');
  Result := Result.Replace('-', '');
  Result := Result.Replace('/', '');
  Result := Result.Replace(' ', '');
end;

procedure TMascara.TratarMascara(Campo: TEdit; var Key: Word; var KeyChar: Char;
  Mascara: string);
var
  chChar: Char;
  stValor, stAntes, stDepois: string;
  itPos: Integer;
const
  NAVEGACAO = [vkLeft, vkRight, vkHome, vkEnd];
  EXCLUSAO = [vkBack, vkDelete];
  SEPARADORES: array [0 .. 2] of Char = ('.', '/', '-');
{$IFDEF MSWINDOWS}
  N = 1;
{$ELSE}
  N = 0;
{$ENDIF}
begin
  if ((Key in NAVEGACAO) or (Key in EXCLUSAO) or (KeyChar.IsNumber)) then
  begin
    if ((Key in EXCLUSAO) or (KeyChar.IsNumber)) then
    begin
      if (Campo.SelLength > 0) then
      begin
        stAntes := Copy(Campo.Text, 1, Campo.SelStart);
        stDepois := Copy(Campo.Text, Campo.SelStart + Campo.SelLength + 1,
          Length(Campo.Text));

        if ((Key = vkDelete) or (Key = vkBack)) then
        begin
          stValor := stAntes + stDepois;
          itPos := Campo.SelStart;
        end
        else
        begin
          stValor := stAntes + KeyChar + stDepois;
          itPos := Campo.SelStart + 1;
        end;
      end
      else
      begin
        if (Key = vkDelete) then
        begin
          stAntes := Copy(Campo.Text, 1, Campo.SelStart);
          stDepois := Copy(Campo.Text, Campo.SelStart + 2, Length(Campo.Text));
          stValor := stAntes + stDepois;
          itPos := Campo.SelStart;
        end
        else if (Key = vkBack) then
        begin
          stAntes := Copy(Campo.Text, 1, Campo.SelStart - 1);
          stDepois := Copy(Campo.Text, Campo.SelStart + 1, Length(Campo.Text));
          stValor := stAntes + stDepois;
          itPos := Campo.SelStart - 1;
        end
        else
        begin
          stAntes := Copy(Campo.Text, 1, Campo.SelStart);
          stDepois := Copy(Campo.Text, Campo.SelStart + 1, Length(Campo.Text));
          stValor := stAntes + KeyChar + stDepois;
          itPos := Campo.SelStart + 1;
          chChar := Mascara[itPos - 1 + N];
          if (chChar.IsInArray(SEPARADORES)) then
          begin
            itPos := itPos + 1;
          end;
        end;
      end;

      Campo.Text := AplicarMascara(stValor, Mascara);
      Campo.SelStart := itPos;
      Key := vkNone;
      KeyChar := #0;
    end;
  end
  else
  begin
    Key := vkNone;
    KeyChar := #0;
  end;
end;

initialization

if (not Assigned(Mascara)) then
  Mascara := TMascara.Create;

finalization

if (Assigned(Mascara)) then
  FreeAndNil(Mascara);

end.
