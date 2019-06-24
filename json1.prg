FUNCTION TESTE_JSON
LOCAL hRet := HB_Hash()
LOCAL cRet :='', nPos:=0, cReg:=''
local aARQ := {}

cRet := '{"result":[{"1":[{"placa":"ABC1234"},{"datahora":"25\/10\/2016 16:09:35"},{"latitude":"-23.5763034820557"},{"longitude":"-46.8151245117188"},{"velocidade":"0"},{"pos_chave":"0"},{"bloqueio":"0"},{"endereco":"Estrada das Rosas, 1234 OSASCO - SP"}],"2":[{"placa":"ABC1234"},{"datahora":"25\/10\/2016 17:25:45"},{"latitude":"-23.5766792297363"},{"longitude":"-46.8154640197754"},{"velocidade":"0"},{"pos_chave":"0"},{"bloqueio":"0"},{"endereco":"Rua A, 0 OSASCO - SP"}] }]}'

hb_JsonDecode( cRet, @hRet )

if Len(hRet) != 0
   if HHasKey( hRet, 'result' )
      For nPos=1 To Len( hRet['result',1] )
         cReg := Alltrim(Str(nPos))

         if !Empty(hRet['result',1][cReg,3]['latitude']) .And.;
            !Empty(hRet['result',1][cReg,4]['longitude'])

            AADD(aARQ,{hRet['result',1][cReg,6]['pos_chave']      ,;  // 01 - ignicao
                       hRet['result',1][cReg,5]['velocidade']     ,;  // 02 - velocidade
                       hRet['result',1][cReg,3]['latitude']       ,;  // 03 - latitude
                       hRet['result',1][cReg,4]['longitude']      ,;  // 04 - longitude
                       hRet['result',1][cReg,1]['placa']          ,;  // 05 - placa
                       Substr(hRet['result',1][cReg,2]['datahora'],1,10),;        // 06 - Data Transmissão
                       Substr(hRet['result',1][cReg,2]['datahora'],12,5)+':00',;  // 07 - Hora Transmissão
                       hRet['result',1][cReg,8]['endereco'],;         // 08 - Endereco de Leitura
                       .F. } )                                        // 09 - lido
         endif
      Next
   else
      ALERT('ERRO - RASTREADOR : '+hb_UTF8ToStr(hRet['Message']))
      return(.F.)
   endif
else
   ALERT('ERRO - RASTREADOR : Erro no Envio da Chave :')
   return(.F.)
endif

return(.T.)