#include "hbclass.ch"
#Include "Box.Ch"
#Include "Inkey.Ch"

#Define  FALSO   .F.
#Define  OK      .T.
#define SETA_CIMA 			  5
#define SETA_BAIXO			  24
#define SETA_ESQUERDA		  19
#define SETA_DIREITA 		  4
#define TECLA_SPACO			  32
#define TECLA_ALT_F4 		  -33
#define ENABLE 				  .T.
#define DISABLE				  .F.

//CLASS TvMenu INHERIT TAmbiente
CLASS TvMenu FROM TAmbiente
    Export:
        VAR Frame // INHERIT TAmbiente
        Var StatusSup
        Var StatusInf
        Var CorCabec
        Var CorMenu
		  Var CorLightBar
        Var CorBorda
        Var CorFundo
        Var CorDesativada
        Var Ativo
        Var Menu
        Var PanoFundo
        Var NomeFirma
        Var Codifirma
        Var Sombra

		Export:
        METHOD New CONSTRUCTOR
        METHOD Show
        METHOD SetaCor
        METHOD SetaFrame
        METHOD SetaPano
        METHOD SetaBorda
        METHOD StatInf
        METHOD StatSup
        METHOD Limpa
        METHOD MaBox
        METHOD FazMenu
        METHOD SetaSombra
ENDCLASS

Method Limpa
        Cls( ::CorFundo, ::PanoFundo )
		  return Self

Method New()
       ::StatusSup     := "MicroBras"
       ::StatusInf     := ""
       ::CorCabec      := 75
       ::Ativo         := 1
       ::CorMenu       := 31
		 ::CorLightBar      := 15
		 ::CorBorda      := 31
       ::Cordesativada := 24
       ::Menu          := {"Opcao 1 :Item 1:Item 1", "Opcao 2:Item 2:Item2"}
       ::PanoFundo     := "€≤∞±MicroBras€±≤∞"
       ::CorFundo      := 8
       ::Frame         := "⁄ƒø≥Ÿƒ¿≥"
       ::NomeFirma     := "MICROBRAS COM DE PROD DE INFORMATICA LTDA"
       ::Codifirma     := "0001"
       ::Sombra        := OK
       //setattrib("y", ::CorMenu - 1)   // Cor de Menu - 1
       //setattrib("v", 12+16)           // Vermelho
       //setattrib("a", 14+16)           // Amarelo
       //setattrib("d", 10+16)           // Verde
       //setattrib("c", 11+16)           // Ciano
       //setattrib("m", 13+16)           // Magenta setattrib("z", 126)
return( Self )

Method Show
        LOCAL nChoice
        Cls( ::CorFundo, ::PanoFundo )
		  M_Frame( ::Frame )
        ::StatSup()
        ::StatInf()
		  return( nChoice := M_Menu( ::Ativo, ::Menu, ::CorMenu, 1 ))
		  

Method StatInf( cMensagem )
        LOCAL nCol  := LastRow()
        LOCAL nTam  := MaxCol()
        LOCAL nPos  := ( nTam - Len( ::NomeFirma ))
        aPrint( nCol, 00,    if( cMensagem = NIL, ::StatusInf, cMensagem), ::CorCabec, MaxCol() )
        aPrint( nCol, nPos,  ::Codifirma + ':' + ::NomeFirma, ::CorCabec )
        return Self

Method StatSup( cCabecalho )
        LOCAL nTam  := MaxCol()
        LOCAL nPos  := ( nTam - Len( ::StatusSup ))
        aPrint( 00, 00, Padc( if( cCabecalho = NIL, ::StatusSup, cCabecalho), nTam ),  ::CorCabec, nTam )
        aPrint( 00, ( nTam-8), Clock( 00, (nTam-8), ::CorCabec ), ::CorCabec )
        return Self


Method SetaCor( nTipo )
***************************
LOCAL aTipo      := { ::CorMenu, ::CorCabec, ::CorFundo, ::CorDesativada }
LOCAL cPanoFundo := ::PanoFundo
LOCAL cScreen    := SaveScreen()
LOCAL xTipo      := if( nTipo = NIL, 1, nTipo )
LOCAL xColor     := aTipo[ xTipo ]
LOCAL CorAnt     := aTipo[ xTipo ]
LOCAL ikey
LOCAL oCor := TMenuNew()
      oCor:CorMenu        := aTipo[ 1 ]
      oCor:CorCabec       := aTipo[ 2 ]
      oCor:CorFundo       := aTipo[ 3 ]
      oCor:CorDesativada  := aTipo[ 4 ]
      oCor:PanoFundo      := cPanoFundo
      oCor:StatusSup      := "TESTE DE COR - Cabecalho"
      oCor:StatusInf      := "TESTE DE COR"

WHILE .T.
   Keyb( Chr( 27 ))
   oCor:Show()
   M_Frame( ::Frame )
   M_Message("Cor Atual = "+ StrZero( xColor, 3 ) + " - Enter Para Setar ou ESCape", xColor )
   Ikey := WaitKey( 0 )
   if ( Ikey == 24)
      aTipo[ xTipo ] := ( XColor  := Iif( xColor  == 0, 255, --xColor  ))
   elseif ( Ikey == 5)
      ( aTipo[ xTipo ] ) :=  ( xColor  := Iif( xColor  == 255, 0, ++xColor  ))
    elseif ( Ikey == 27 ) .OR. ( IKey == 13 )
       Exit
    endif
    oCor:CorMenu       := aTipo[ 1 ]
    oCor:CorCabec      := aTipo[ 2 ]
    oCor:CorFundo      := aTipo[ 3 ]
    oCor:CorDesativada := aTipo[ 4 ]
End
::CorMenu       := aTipo[ 1 ]
::CorCabec      := aTipo[ 2 ]
::CorFundo      := aTipo[ 3 ]
::CorDesativada := aTipo[ 4 ]
ResTela( cScreen )
return SeLF

Method SetaFrame
****************
LOCAL cScreen := SaveScreen()
LOCAL nChoice := 1
LOCAL aFrames := {"        ",;
                  "⁄ƒø≥Ÿƒ¿≥",;
                  "…Õª∫ºÕ»∫",;
                  "÷ƒ∑∫Ωƒ”∫",;
                  "’Õ∏≥æÕ‘≥",;
                  "ﬂﬂﬂﬁ‹‹‹›",;
                  "€€€€€€€€€",;
                  "…–À« Ã»∂"}
nChoice := ::FazMenu( 03, 10, aFrames, ::CorMenu )
ResTela( cScreen )
if nChoice = 0
   return
endif
::Frame  := aFrames[nChoice]
M_Frame( ::Frame )
return Self

Method SetaSombra
*****************
FT_Shadow( ::Sombra )
return Self

Method SetaBorda
****************
LOCAL aTipo      := { ::CorMenu, ::CorCabec, ::CorFundo }
LOCAL cPanoFundo := ::PanoFundo
LOCAL cScreen    := SaveScreen()
LOCAL xColor     := ::CorBorda
LOCAL ikey
LOCAL oCor := TMenuNew()
      oCor:CorMenu   := aTipo[ 1 ]
      oCor:CorCabec  := aTipo[ 2 ]
      oCor:CorFundo  := aTipo[ 3 ]
      oCor:CorBorda  := ::CorBorda
      oCor:PanoFundo := cPanoFundo
      oCor:StatusSup := "TESTE DE COR DE BORDA"
      oCor:StatusInf := oCor:StatusSup

WHILE .T.
   Keyb( Chr( 27 ))
   oCor:Show()
   M_Frame( ::Frame )
   M_Message("Cor Borda Atual = "+ StrZero( xColor, 3 ) + " - Enter Para Setar ou ESCape", xColor )
   Ikey := WaitKey( 0 )
   if ( Ikey == 24)
      XColor  := Iif( xColor  == 0, 63, --xColor  )
      oCor:CorBorda  := xColor
      ::CorBorda     := xColor
   elseif ( Ikey == 5)
      xColor  := Iif( xColor  == 63, 0, ++xColor  )
      oCor:CorBorda  := xColor
      ::CorBorda     := xColor
    elseif ( Ikey == 27 ) .OR. ( IKey == 13 )
       Exit
    endif
    //Border( ::CorBorda )
End
//Border( ::CorBorda )
ResTela( cScreen )
return SeLF

Method SetaPano
***************
LOCAL nPano
LOCAL Selecionado  := 1
LOCAL nKey         := 0
LOCAL cScreen	    := SaveScreen()
LOCAL oCor

nPano          := Len( ::Panos )
nPos           := Ascan( ::Panos, ::Panofundo )
Selecionado    := if( nPos = 0, 1, nPos )
cPanoFundo     := ::PanoFundo
cCorMenu       := ::CorMenu
cCorCabec      := ::CorCabec
cCorFundo      := ::CorFundo

oCor           := TMenuNew()
oCor:PanoFundo := cPanoFundo
oCor:CorMenu   := cCorMenu
oCor:CorCabec  := cCorCabec
oCor:CorFundo  := cCorFundo

WHILE .T.
   Keyb( Chr( 27 ))
   oCor:Show()
   M_Frame( ::Frame )
   M_Message("Use as setas CIMA e BAIXO para trocar, ENTER para aceitar. Nß " + StrZero( Selecionado, 3 ), ::CorMenu )
   nKey := Inkey(0)
   if ( nKey == 27 .OR. nKey = 13 )
      Exit
   elseif nKey == 24
      Selecionado := if( Selecionado == 1, nPano, --Selecionado  )
      oCor:PanoFundo := ::Panos[ Selecionado ]
   elseif nKey == 5
      Selecionado := if( Selecionado == nPano, 1, ++Selecionado  )
      oCor:PanoFundo := ::Panos[ Selecionado ]
   endif
EndDo
::PanoFundo := ::Panos[ Selecionado ]
PATTERN     := ::PanoFundo
return Self

Method MaBox( nTopo, nEsq, nFundo, nDireita, Cabecalho, Rodape, lInverterCor )
******************************************************************************
LOCAL cPattern := " "
LOCAL nCor     := if( lInverterCor = NIL, ::CorMenu,  lInverterCor )
LOCAL pback

DispBegin()
if nDireita = 79
   nDireita = MaxCol()
endif
ColorSet( @nCor, @pback )
Box( nTopo, nEsq, nFundo, nDireita, ::Frame + cPattern, nCor )
if Cabecalho != Nil
   aPrint( nTopo, nEsq+1, "€", Roloc( nCor ), (nDireita-nEsq)-1)
   aPrint( nTopo, nEsq+1, Padc( Cabecalho, ( nDireita-nEsq)-1), Roloc( nCor ))
endif
if Rodape != Nil
   aPrint( nFundo, nEsq+1, "€", Roloc( nCor ), (nDireita-nEsq)-1)
   aPrint( nFundo, nEsq+1, Padc( Rodape, ( nDireita-nEsq)-1), Roloc( nCor ))
endif
cSetColor( SetColor())
nSetColor( nCor, Roloc( nCor ))
DispEnd()
return

Method FazMenu( nTopo, nEsquerda, aArray, Cor )
***********************************************
LOCAL nFundo     := ( nTopo + Len( aArray ) + 3 )
LOCAL nTamTitle  := ( Len( M_Title() ) + 12 )
LOCAL nDireita   := ( nEsquerda + AmaxStrLen( aArray ) + 1 )
if ( nDireita - nEsquerda ) <  nTamTitle
   nDireita := ( nEsquerda + nTamTitle )
endif
Cor := if( Cor = NIL, ::CorMenu, Cor )
::MaBox( nTopo, nEsquerda, nFundo, nDireita, "", "", Cor )
//nChoice := Mx_Choice( @nTopo, @nEsquerda, @nFundo, @nDireita, aArray, Cor )
nChoice := Achoice( @nTopo, @nEsquerda, @nFundo, @nDireita, aArray)
return( nChoice )

*:----------------------------------------------------------------------------

Function TvMenuNew()
   return( TvMenu():New())

*:----------------------------------------------------------------------------
