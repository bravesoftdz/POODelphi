unit uClasses;

interface

  uses
    Classes;
   type
      TProduto = class
         private
            FCodigo: Integer;
            FNome: String;
         public
            property Codigo:Integer read FCodigo write FCodigo;
            property Nome:String read FNome write FNome;
            constructor Create;
            destructor Destroy;override;
      end;

      TItem = class
        private
          FoProduto: TProduto;
          FQuantidade: integer;
          FValor: double;
        public
          property Produto:TProduto read FoProduto write FoProduto;
          property Quantidade:integer read FQuantidade write FQuantidade;
          property Valor:double read FValor write FValor;

      end;

      TPedido = class
        private
          FLista :TList;
          FTotal: double;
        protected
          function getTotal:Double;virtual;
          function getCount:integer;virtual;
          function getItem(index: Integer): TItem;virtual;
          procedure setItem(index: Integer; const Value: TItem);virtual;
        public
          property Total:double read getTotal;
          property Items[index:Integer]:TItem read getItem write setItem;
          property Count:Integer read getCount;
          procedure Add(item:TItem);
          constructor Create;
          destructor Destroy;override;

      end;



implementation

{ TProduto }

constructor TProduto.Create;
begin
   inherited Create;
   FCodigo := 0;
   FNome := 'Default';
end;

destructor TProduto.Destroy;
begin
  inherited;
end;

{ TPedido }

procedure TPedido.Add(item: TItem);
begin
  FLista.Add(item);
end;

constructor TPedido.Create;
begin
  inherited Create;
  FLista := TList.Create;
end;

destructor TPedido.Destroy;
begin
  inherited;

end;

function TPedido.getCount: Integer;
begin
  result := FLista.Count;
end;

function TPedido.getItem(index: Integer): TItem;
begin
    if (index <= FLista.Count - 1 ) then
      result := TItem(Flista[index])
    else
      result := nil;

end;

function TPedido.getTotal: double;
var
  i:integer;
begin
  result := 0;
  for i := 0 to Count - 1do
    result := result + (Items[i].Valor * Items[i].Quantidade);
end;

procedure TPedido.setItem(index: Integer; const Value: TItem);
begin
    if (index <= FLista.Count - 1 ) then
      Flista[index] := Value;

end;

end.
