#require <hbleto>

FUNCTION Main()
   LOCAL cServer:='//127.0.0.1:2812/'
   REQUEST LETO
   RDDSETDEFAULT("LETO")
   if Leto_Connect(cServer)==-1
      MSG('Sem conexao com o servidor '+cServer)
      return NIL
   else
      MSG('Servidor escutando em:' +cServer)
   endif
   DBCreate( cServer + 'TESTE',{;                         
                               {'CODI', 'N',  03,0},;
                               {'NOME', 'C',  40,0},;
                               {'CIDA', 'C',  30,0},;
										 {'ESTA', 'C',  02,0},;
										 {'DATA', 'D',  08,0};
	})

   DBUseArea(.T.,,cServer + 'teste','teste')  //Abrimos la tabla
   //USE ( cServer+'Teste' ) New
   INDEX ON Codi TAG Codi    
   //--
   FOR i:=1 TO 100            
      Teste->(RLock())        
      Teste->(DBAppend())
      Teste->Codi  := i
      Teste->Nome  := 'Registro '+Str(i,3)
      Teste->Data  := Date()
      Teste->(DBUnlock())
   NEXT
   Teste->(DBSeek(50))
   MSG(Teste->Nome)
   Teste->(DBCloseArea())
return NIL

#pragma BEGINDUMP
	#include "windows.h"
	#include "hbapi.h"

	HB_FUNC(  MSG )
	{
		MessageBox( GetActiveWindow(), hb_parc(1), "Ok", 0 );
	}
#pragma ENDDUMP