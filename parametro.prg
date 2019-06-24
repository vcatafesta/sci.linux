FUNCTION Main( ... )

   LOCAL aPar := hb_AParams()
   LOCAL cPar

   FOR EACH cPar IN aPar
      ? "Parametro:", cPar
   NEXT
   teste( ... )

   RETURN

FUNC teste( ... )

   LOCAL aPar := hb_AParams()
   LOCAL cPar

   FOR EACH cPar IN aPar
      ? "Parametro:", cPar, ValType( cPar )
   NEXT
