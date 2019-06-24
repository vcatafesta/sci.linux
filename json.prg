//---------------------------------------------------------
Function Main()
Local cLinha := ''
cLinha := ;
''+;
   [ {]+;
    ["id": 1,]+;
     ["cliente_id": 123,]+;
     ["observacoes": "Favor faturar urgente.",]+;
      '"items": [ {'+;
            ["id": 5000,]+;
            ["produto_id": 1001]+;
          '},'+;
          '{"id": 8000,"produto_id": 1002}'+;
           ']}'
           
hb_memoWrit("teste.json", cLinha)         //apenas para visualização
Alert( cLinha)

cJSON := cLinha
hJSON := {}//hb_hash()
hb_JSONDecode( cJSON, @hJSON )

element := 0
hTeste  := hJSON

FOR EACH element IN hTeste['items']

   ? element

   ? element["id"]
   ? element["produto_id"]
    
NEXT
wait "Tecle algo"

return nil