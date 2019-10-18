unit uValidacao;

interface

uses
  System.SysUtils;

type
  TValidacao = class
  public
    function ValidarCEP(const CEP: string): Boolean;
    function ValidarCPF(const CPF: string): Boolean;
    function ValidarEmail(const Email: string): Boolean;
  end;

var
  Validacao: TValidacao;

implementation

uses
  System.StrUtils;

{ TValidacao }

function TValidacao.ValidarCEP(const CEP: string): Boolean;
var
  itI: Integer;
  stCEP: string;
begin
  Result := False;
  stCEP := '';

  for itI := 1 to Length(CEP) do
    if CharInSet(CEP[itI], ['0'..'9']) then
      stCEP := stCEP + CEP[itI];

  if (Length(stCEP) = 8) then
    Result := True;
end;

function TValidacao.ValidarCPF(const CPF: string): Boolean;
var
  bI, bNumero, bResto: Byte;
  bDV1, bDV2: Byte;
  itTotal, itSoma: Integer;
begin
  Result := False;

  if (Length(Trim(CPF)) = 11) then
  begin
    itTotal := 0;
    itSoma := 0;

    for bI := 1 to 9 do
    begin
      try
        bNumero := StrToInt(CPF[bI]);
      except
        bNumero := 0;
      end;

      itTotal := itTotal + (bNumero * (11 - bI));
      itSoma := itSoma + bNumero;
    end;

    bResto := itTotal mod 11;

    if bResto > 1 then
      bDV1 := 11 - bResto
    else
      bDV1 := 0;

    itTotal := itTotal + itSoma + 2 * bDV1;
    bResto := itTotal mod 11;

    if bResto > 1 then
      bDV2 := 11 - bResto

    else
      bDV2 := 0;

    if (IntToStr(bDV1) = CPF[10]) and (IntToStr(bDV2) = CPF[11]) then
      Result := True;
  end;
end;

function TValidacao.ValidarEmail(const Email: string): Boolean;
var
  stEmail: string;
begin
  stEmail := Trim(UpperCase(Email));
  if Pos('@', stEmail) > 1 then
  begin
    Delete(stEmail, 1, Pos('@', stEmail));
    Result := (Length(stEmail) > 0) and (Pos('.', stEmail) > 2);
  end
  else
    Result := False;
end;

initialization

if (not Assigned(Validacao)) then
  Validacao := TValidacao.Create;

finalization

if (Assigned(Validacao)) then
  FreeAndNil(Validacao);

end.

