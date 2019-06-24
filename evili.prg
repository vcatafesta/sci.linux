   FUNCTION Main()

   // **************
   LOCAL GetList  := {}
   LOCAL cNome    := "EVILI"
   LOCAL cEnde    := "PIMENTA BUENO"
   LOCAL aPessoa  := { cNome, cEnde, "RO" }
   LOCAL aPessoas := { { cNome, cEnde, "RO" }, { "VILMAR", "ROLIM", "SP" } }
   LOCAL n

   Cls
   ? "Hello, " + SubStr( cNome, 2, 3 ) + "MAR"
   ? "Mora em, " + cEnde

   ? aPessoa[ 1 ]
   ? aPessoa[ 2 ]
   ? aPessoa[ 3 ]

   FOR n := 1 TO Len( aPessoas )
      ? n, 1, aPessoas[ n, 1 ]
      ? n, 2, aPessoas[ n, 2 ]
      ? n, 3, aPessoas[ n, 3 ]
   NEXT

   FOR n := 1 TO Len( aPessoas )
      @ 20, 10 SAY "Nome: " GET aPessoas[ n, 1 ]
      @ 21, 10 SAY "Cida: " GET aPessoas[ n, 2 ]
      @ 22, 10 SAY "Esta: " GET aPessoas[ n, 3 ]
      READ
   NEXT


   FOR n := 1 TO Len( aPessoas )
      MostraNome( aPessoas[ n, 1 ] )
      MostraNome( aPessoas[ n, 2 ] )
      MostraNome( aPessoas[ n, 3 ] )
   NEXT

   return( aPessoas )

   FUNCTION MostraNome( cParametro )

   // ********************************
   QOut( cParametro )

   return( NIL )
