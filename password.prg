cSenha := Space(5)
cNome  := Space(20)
cNome  := Space(20)

While .T.
   getlist := {}
   Cls
   @ 10, 10 Say "Senha : " Get cSenha Pict "@S" Valid Retorno( cSenha)
   @ 11, 10 Say "Nome  : " Get cNome  Pict "@!" Valid !Retorno( cNome)
   Read
   if Lastkey() = 27
      __Quit()
   endif
   QOut( cNome )
   QOut( csenha )
   inkey(0)
EndDo


Function Retorno( cSenha )
Alert( cSenha )
return( cSenha == "00000")


/*****
 *
 * GET12.PRG
 *
 * Getting a password and echoing asterisks
 *
 * Clipper get12 /n /w
 * Clipper getpsw /n /w
 * RTLINK FILE get12,getpsw
 *
 */

#include "inkey.ch"

FUNCTION Test()
   LOCAL GetList := {}
   LOCAL cPassword
   LOCAL cScreen

   cScreen := savescreen()
   WHILE .T.
      SCROLL()
      cPassword := SPACE(10)
      @ 10,10 Say "Senha :" GET cPassword SEND reader := {|o| o:varPut(GetPsw(o))}
      READ
      @ 20,10 SAY cPassword
      if INKEY(5) == K_ESC
         EXIT

      endif

   END
   restscreen(,,,,cScreen)
   return (NIL)

// EOF - GET12.PRG //

