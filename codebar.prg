# include "ld.ch"
# include "inkey.ch"

Function Main()
  LOCAL i
  LOCAL cCodBar
  LOCAL nTipImp := 1
  LOCAL cBar   := SPACE(13)
  LOCAL nAncho :=8
  LOCAL n1 := 2
  LOCAL n2 := 10
  LOCAL n3 := 10
  LOCAL n4 := 10
  LOCAL n5 := 12

  while .t.
  cls
  @ 10,10 SAY "tipo impresora ..:"GET nTipImp
  @ 11,10 SAY "Codigo ..........:"GET cBar
  @ 12,10 SAY "Ancho ...........:"GET nAncho
  @ 13,10 SAY "Ancho ...........:"GET n1
  @ 14,10 SAY "Ancho ...........:"GET n2
  @ 15,10 SAY "Ancho ...........:"GET n3
  @ 16,10 SAY "Ancho ...........:"GET n4
  @ 17,10 SAY "Ancho ...........:"GET n5
  READ
  if(lastkey()=K_ESC)
    exit
  end if
  nTipImp := 11
  cCodBar := LdEan13(ALLTRIM(cBar))
  aRes    := LdGenerate(nTipImp,cCodBar,nAncho, n1, n2,   n3, n4, n5 )
  aRes1   := LdGenerate(nTipImp,cCodBar,nAncho, n1, n2*2, n3, n4, n5 )
  cLS
  FOR i:=1 TO 1
    ?? aRes[i], Asc(aRes[i]), len(ares[1])
    For x := 1 To Len(aRes[i])
       ? Asc(Ares[i,x])
   Next
    iNKEY(0)
  END FOR
END WHILE
return nil
