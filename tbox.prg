#include <sci.ch>

CLASS TBox
    Export:
        VAR Cima
		  VAR Esquerda
		  VAR Baixo
		  VAR Direita
		  VAR cScreen
        VAR Cabecalho
        VAR Rodape
		  VAR Cor
		  VAR Frame

    Export:
        METHOD New CONSTRUCTOR
        METHOD Show
        METHOD Hide
        METHOD Up
        METHOD Down
        METHOD Right
        METHOD PageUp
        METHOD PageDown
        METHOD Move
        METHOD MoveGet
        MESSAGE Inkey    METHOD InkeyMBox
        MESSAGE Esquerda METHOD LeftMBox

End Class

Method New( nCima, nEsquerda, nBaixo, nDireita, cCabecalho, cRodape, lInverterCor )
		  ::Cima 	  := if( nCima 	 != NIL, nCima,	  10 )
		  ::Esquerda  := if( nEsquerda != NIL, nEsquerda, 10 )
		  ::Baixo	  := if( nBaixo	 != NIL, nBaixo,	  20 )
		  ::Direita   := if( nDireita  != NIL, nDireita,  40 )
		  ::Cor		  := if( lInverterCor != NIL, lInverterCor, 31 )
		  ::Cabecalho := if( cCabecalho != NIL, cCabecalho, NIl )
		  ::Rodape	  := if( cRodape	  != NIL, cRodape,	 NIL )
        ::Frame     := B_SINGLE
        return( Self )

Method Move( oGetList, nCima, nEsquerda, nBaixo, nDireita )
		  LOCAL nTam := Len( oGetList )
		  LOCAL nDifTopo := nCima		- ::Cima
		  LOCAL nDifEsq  := nEsquerda - ::Esquerda
		  ::Hide()
        ::Show( nCima, nEsquerda, nBaixo, nDireita )
		  if nTam != 0
			  ::MoveGet( oGetList, nTam, nDifTopo, nDifEsq )
		  endif
        return( Self )

Method MoveGet( oGetList, nTam, nDifTopo, nDifEsq )
		  LOCAL nX
		  For nX := 1 To nTam
			  oGetList[nX]:Row += nDifTopo
			  oGetList[nX]:Col += nDifEsq
		  Next
		  return Self

Method Hide( nTela )
		  ResTela( ::cScreen )
		  return Self

Method InkeyMBox()
		  Inkey(0)
		  if LastKey() = 397
			  ::Up()
		  End
		  return Self

Method Up()
		  ::Hide()
		  ::Cima--
		  ::Baixo--
		  ::Paint()
		  return Self

Method PageUp()
		  ::Hide()
		  ::cScreen  := SaveScreen()
		  ::Cima 	 := 0
		  ::Baixo	 := 4
		  ::Paint()
		  return Self

Method PageDown()
		  ::Hide()
		  ::cScreen  := SaveScreen()
		  ::Cima 	 := 20
		  ::Baixo	 := 24
		  ::Paint()
		  return Self

Method Down()
		  ::Hide()
		  ::cScreen  := SaveScreen()
		  ::Cima++
		  ::Baixo++
		  ::Paint()
		  return Self

Method LeftMBox()
		  ::Hide()
		  ::cScreen  := SaveScreen()
		  ::Esquerda--
		  ::Direita--
		  ::Paint()
		  return Self

Method Right()
		  ::Hide()
		  ::cScreen  := SaveScreen()
		  ::Esquerda++
		  ::Direita++
		  ::Paint()
		  return Self

Method Show( nCima, nEsquerda, nBaixo, nDireita, cCabecalho, cRodape, lInverterCor )
	LOCAL cPattern := " "
	LOCAL cCor
	LOCAL pBack
	::cScreen 	:= SaveScreen()
	::Cima		 := if( nCima		!= NIL, nCima, ::Cima )
	::Esquerda	:= if( nEsquerda != NIL, nEsquerda, ::Esquerda )
	::Baixo		:= if( nBaixo	  != NIL, nBaixo, ::Baixo )
	::Direita	:= if( nDireita  != NIL, nDireita,	::Direita)
	::Cor 	 := if( lInverterCor != NIL, lInverterCor, ::Cor )
	::Cabecalho := if( cCabecalho != NIL, cCabecalho, ::Cabecalho )
	::Rodape 	:= if( cRodape 	!= NIL, cRodape,	  ::Rodape )

   cCor := ::Cor
	DispBegin()
	if ::Direita = 79
		::Direita := MaxCol()
	endif
  
   ColorSet( @cCor, @pback )
	Box( ::Cima, ::Esquerda, ::Baixo, ::Direita, Super:Frame + cPattern, ::Cor )
	if ::Cabecalho != Nil
		aPrint( ::Cima, ::Esquerda+1, "Û", Roloc( ::Cor ), (::Direita-::Esquerda)-1)
		aPrint( ::Cima, ::Esquerda+1, Padc( ::Cabecalho, ( ::Direita-::Esquerda)-1), Roloc( ::Cor ))
	endif
	if ::Rodape != Nil
		aPrint( ::Baixo, ::Esquerda+1, "Û", Roloc( ::Cor ), (::Direita-::Esquerda)-1)
		aPrint( ::Baixo, ::Esquerda+1, Padc( ::Rodape, ( ::Direita-::Esquerda)-1), Roloc( ::Cor ))
	endif
	cSetColor( SetColor())
	nSetColor( cCor, Roloc( cCor ))
	DispEnd()
	return Self

Function TBoxNew()
*******************
   return( TBox():New())
