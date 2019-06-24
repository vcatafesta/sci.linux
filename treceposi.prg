#include "sci.ch"
#define beginclass

CLASS TWindow
beginclass
	DATA   hWnd, nOldProc
	CLASSDATA lRegistered AS LOGICAL
ENDCLASS	

CLASS TReceposi
beginclass
	VAR cWho
	VAR cNome
	VAR aHistRecibo				INIT {}
	VAR aUserRecibo			 	INIT {}
	VAR aReciboImpresso		 	INIT {}
	VAR aAtivo					INIT {}
	VAR aAtivoSwap				INIT {}
	VAR aRecno					INIT {}		
	VAR aTodos                  INIT {}		
	VAR aCodi                   INIT {}
	VAR alMulta                 INIT {}
	VAR xTodos                  INIT {}
	VAR aDataPag                INIT {}
	VAR aRescisao               INIT {}
	
	VAR aDocnr_Selecao_Imprimir INIT {}
	VAR aSoma_Selecao_Imprimir  INIT {}
	VAR aObs_Selecao_Imprimir   INIT {}
	VAR aCurElemento_Selecao    INIT {}
	VAR nSoma_Total_Imprimir    INIT 0
	VAR nPrincipalSelecao       INIT 0
	VAR nJurosSelecao           INIT 0
	VAR nMultaSelecao           INIT 0
	VAR nRescisaoSelecao        INIT 0
	
	VAR nPrincipal_Vencer       INIT 0
	VAR nJuros_Vencer           INIT 0
	VAR nMulta_Vencer           INIT 0	
	VAR nTotal_Vencer           INIT 0
	VAR nQtdDoc_Vencer          INIT 0
	
	VAR nPrincipal_Rescisao     INIT 0
	VAR nJuros_Rescisao         INIT 0
	VAR nMulta_Rescisao         INIT 0	
	VAR nTotal_Rescisao         INIT 0
	VAR nQtdDoc_Rescisao        INIT 0
	
	VAR CorVencido              INIT AscanCor(16) // Branco do Menu 
	VAR CorAviso                INIT AscanCor(15) // Amarelo do Menu
	VAR CorDuplicado            INIT AscanCor(14) // Magenta
	VAR CorRecibo               INIT AscanCor(13) // Vermelho do Menu 
	VAR CorDesativado           INIT AscanCor(12) // Brown
	VAR CorVencer               INIT AscanCor(11) // Verde do Menu 
	VAR CorSelecao              INIT AscanCor(10) // Azul do menu	
	VAR CorAlterado             INIT AscanCor(04) // Cyan	
	VAR nCorZebradoBranco       INIT AscanCor(15) 
	VAR nCorZebradoVerde        INIT AscanCor(14) 
	
	VAR nPrincipal_Vencido      INIT 0
	VAR nJuros_Vencido          INIT 0
	VAR nMulta_Vencido          INIT 0	
	VAR nTotal_Vencido          INIT 0
	VAR nQtdDoc_Vencido         INIT 0	
	
	VAR nPrincipal_Recibo       INIT 0
	VAR nJuros_Recibo           INIT 0
	VAR nMulta_Recibo           INIT 0	
	VAR nTotal_Recibo           INIT 0
	VAR nQtdDoc_Recibo          INIT 0	
	
	VAR nPrincipal_Geral        INIT 0
	VAR nJuros_Geral            INIT 0
	VAR nMulta_Geral            INIT 0	
	VAR nTotal_Geral            INIT 0
	VAR nQtdDoc_Geral           INIT 0	
	
	VAR nPrincipal	            INIT 0	
	VAR nJurosPago	            INIT 0	
	VAR nRecebido				INIT 0	
	VAR nAberto              	INIT 0	
	VAR nQtdDoc 				INIT 0	
	VAR cStrSelecao             INIT ''
	VAR cStrRecibo              INIT ''
	VAR cStrVencido             INIT ''
	VAR cStrVencer              INIT ''	
	VAR cStrGeral               INIT ''		
	VAR Color_pFore 	        INIT {}
	VAR Color_pBack             INIT {}
	VAR Color_pUns              INIT {}	
	VAR CurElemento             INIT 1
 	VAR nChoice                 INIT NIL   
	VAR nOrdem                  INIT NIL
 	VAR xParam                  INIT NIL
	VAR cTop	       			INIT ""
	VAR cBottom	       			INIT ""
	VAR aBottom	   				INIT {"","", ""}
	
	VAR nBoxRow	   				INIT 8
	VAR nBoxCol	   				INIT 0
	VAR nBoxRow1				INIT ms_MaxRow()-1
	VAR nBoxCol1				INIT MaxCol()
	
	VAR nPrtRow	   				 INIT MaxRow()
	VAR nPrtCol	   				 INIT 0
	VAR PosiAgeInd 				 INIT FALSO
	VAR PosiAgeAll 				 INIT FALSO
	VAR PosiReceber				 INIT FALSO
   VAR dIni       				 INIT Ctod("01/01/91")
   VAR dFim       				 INIT Ctod("31/12/" + Right(Dtoc(Date()),2))
   VAR dCalculo   				 INIT Date()	
	VAR lRescisao  				 INIT FALSO	
	VAR lCalcular  				 INIT FALSO	
	VAR cPrtStr		
	VAR lReceberPorPeriodo      INIT FALSO
	VAR nT                      INIT 0
	VAR lOrdemAscendente        INIT OK
	VAR lReload                 INIT OK
	VAR nGulosa                 INIT 0 
	VAR nTab                    INIT 16
   
	//Disppage
	VAR nTop
	VAR nLeft
	VAR nRight
	VAR nNumRows
	VAR nNumCols
	
	VAR nPos
	VAR nAtTop
	VAR nArrLen
	VAR nRowsClr 	
	
	// DispLine
	VAR cLine
	VAR nRow
	VAR nCol
	VAR lSelect
	VAR alSelect
	VAR lHiLite
			
	//METHOD TReceposi:AddVar
	METHOD New CONSTRUCTOR
	DESTRUCTOR Destroy()
	METHOD Resetar
	METHOD RenewVar
	METHOD Achoice_
	METHOD Achoice
	METHOD MaBox_
	METHOD PrintPosi
	METHOD Redraw_	
	METHOD Hello	
	METHOD ResetSelecao
	METHOD ResetAll	
	METHOD RedrawSelecao
	METHOD RedrawVencer
	METHOD RedrawVencido
	METHOD RedrawRecibo	
	METHOD RedrawGeral
	METHOD ZerarSelecao
	METHOD ZerarRecibo
	METHOD ZerarVencer
	METHOD ZerarVencido
	METHOD ZerarGeral
	METHOD ZerarRescisao	
	METHOD BarraSoma()
	METHOD ImprimeSoma()
	METHOD _SomaPago( nValorTotal, nValorPago )
	METHOD AssignColor
	METHOD LeftEqI( string, cKey )	
	METHOD Ach_Select( alSelect, nPos )
	METHOD Ach_Limits( /* @ */ nFrstItem, /* @ */ nLastItem, /* @ */ nItems, alSelect, acItems )	
	METHOD Displine( cLine, nRow, nCol, lSelect, lHiLite, nNumCols, nCurElemento )
	METHOD DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nArrLen, nRowsClr )
	METHOD HitTest( nTop, nLeft, nBottom, nRight, mRow, mCol )	
	METHOD AddColor( nColor )
	METHOD CloneVarColor()	
	METHOD ColorToAmbiente()
	METHOD AmbienteToColor()
	METHOD Reset()
	METHOD ResetCorSelecao()
	METHOD DeleteReg(nReg)
	METHOD RegistroEmBranco(cCodi,cFatu)
	METHOD AjustaCorInicio(nAtraso, nT)
	METHOD AjustaCorFinal(nAtraso, nT)
	METHOD cStrComValor(nSomaParcial)	
	METHOD cStrSemValor()
	METHOD cStrAll()
	METHOD AjustaGeral()
	METHOD sTrFormataATodos(nT)
	METHOD Destroy()
	
	MESSAGE Show   METHOD Mabox_()
	MESSAGE Redraw METHOD Redraw_
ENDCLASS 

METHOD Destroy()
	self := nil
	return nil

method New(nBoxRow, nBoxCol, nBoxRow1, nBoxCol1, cTop, cBottom)
	self:cWho  := "TTReceposi"
	self:cNome := ProcName()
	
	hb_default(@nBoxRow,  8)
	hb_default(@nBoxCol,  0)
	hb_default(@nBoxRow1, ms_maxrow()-1)
	hb_default(@nBoxCol1, maxcol())
	hb_default(@cTop,     ::cWho)
	hb_default(@cBottom,  ::cNome)
	
	::nBoxRow   := nBoxRow
	::nBoxCol   := nBoxCol 
	::nBoxRow1  := nBoxRow1
	::nBoxCol1  := nBoxCol1 
	::cTop      := cTop	
	::cBottom   := cBottom	
	::AssignColor()	
	return self
	
METHOD MaBox_()
	MaBox(::nBoxRow, ::nBoxCol, ::nBoxRow1, ::nBoxCol1, ::cTop, ::cBottom)
	return self
	
METHOD Redraw_()
	::MaBox_()	
	if !empty(::aBottom)
		::PrintPosi(::nPrtRow, ::nPrtCol, ::aBottom)
	endif	
	return self

METHOD PrintPosi( nRow, nCol )
	::nPrtRow := nRow
	::nPrtCol := nCol
	::aBottom := { ::cStrRecibo, ::cStrVencido, ::cStrVencer, ::cStrGeral } 
	Print(::nPrtRow-3, ::nPrtCol, ::aBottom[1], ::CorRecibo,  MaxCol()+1)
	Print(::nPrtRow-2, ::nPrtCol, ::aBottom[2], ::CorVencido, MaxCol()+1)
	Print(::nPrtRow-1, ::nPrtCol, ::aBottom[3], ::CorVencer,  MaxCol()+1)
	Print(::nPrtRow,   ::nPrtCol, ::aBottom[4], ::CorVencido, MaxCol()+1)
	return self

METHOD RegistroEmBranco(cCodi,cFatu)
	
	*-----REGISTRO BRANCO--------------------------------------------------------
	Aadd( ::xTodos, {;
						Repl("0",6)+"-00",;
						cTod("01/01/1900"),;
						cTod("01/01/1900"),;
						0,;
						0,;
						0,;
						0,;
						0,;
						0,;
						"00000",;
						Space(40),;
						dTos(cTod("")) + dTos(cTod(""))+Space(9),;
						dTos(cTod("")) + Space(9),;
						dTos(cTod("")) + dTos(cTod("")),;
						iif(::nChoice == 5, cFatu, Space(9)),;
						cTod(""),;
                  OK,;
                  0,;
						dTos(cTod("")) + Space(9) + dTos(cTod("")),;
						dTos(cTod("")) + Space(9) + Space(9) + dTos(cTod("")),;
						dTos(cTod("")) + Space(9) + dTos(cTod("")),;
						dTos(cTod("")) + cCodi + Space(9) + dTos(cTod("")),;
						0,;
						0,;
						}) // Incluir Registro vazio para cursor poder ir topo
	return OK
	*-----END REGISTRO---------------------------------------------------------

METHOD RenewVar()	
	::aTodos		  := {}	
	::xTodos		  := {}	
	::aCodi  	  := {}
   ::aRecno      := {}
	::aRescisao   := {}	
   ::aAtivo      := {}	
	::aAtivoSwap  := {}
	::aHistRecibo := {}
	::aUserRecibo := {}
	::aReciboImpresso := {}	
	::aDataPag        := {}
	::alMulta     := {}
	::CurElemento := 1
	::nQtdDoc 	  := 0
	::Color_pFore := {}
	::Color_pBack := {}
	::Color_pUns  := {}			
	::nPrtRow	  := MaxRow()
	return self

METHOD DeleteReg(nReg)
   hb_default(@nReg, ::CurElemento)	
	HB_ADel( ::aTodos,          nReg, .T. )
	HB_ADel( ::xTodos,          nReg, .T. )
	HB_ADel( ::aCodi,           nReg, .T. )	
	HB_ADel( ::aRecno,          nReg, .T. )	
	HB_ADel( ::aRescisao,       nReg, .T. )		
   HB_ADel( ::aAtivo,          nReg, .T. )		
	HB_ADel( ::aAtivoSwap,      nReg, .T. )	
	HB_ADel( ::aHistRecibo,     nReg, .T. )	
	HB_ADel( ::aUserRecibo,     nReg, .T. )	
	HB_ADel( ::aDataPag,        nReg, .T. )
	HB_ADel( ::aReciboImpresso, nReg, .T. )
	HB_ADel( ::alMulta,         nReg, .T. )	
	HB_ADel( ::CurElemento,     nReg, .T. )	
	HB_ADel( ::nQtdDoc, 	       nReg, .T. )	
	HB_ADel( ::Color_pFore,     nReg, .T. )	
	HB_ADel( ::Color_pBack,     nReg, .T. )	
	HB_ADel( ::Color_pUns,      nReg, .T. )
	::aBottom := ::BarraSoma()
return self

METHOD Resetar()
	self:New()
return self

METHOD CloneVarColor()
*--------------------------------*
	LOCAL xLen  := Len(::xTodos)
	LOCAL pLen  := Len(::Color_pFore)
	LOCAL oLen  := Len(oAmbiente:Color_pFore)
	LOCAL nT    := 0

	if oLen == 0 
		::ColorToAmbiente()		
	else
		::AmbienteToColor()		
	endif
	pLen := Len(::Color_pFore)
	oLen := Len(oAmbiente:Color_pFore)

	if pLen < xLen
		for nT := pLen To xLen
			::AddColor()
		next
	endif
	::ColorToAmbiente()		
	return self

METHOD Reset()
**************
	::RenewVar()
	::ColorToAmbiente()
return self

METHOD ColorToAmbiente()
************************
	oAmbiente:aAtivo      := ::aAtivo
	oAmbiente:aAtivoSwap  := ::aAtivoSwap
	oAmbiente:Color_pFore := ::Color_pFore
	oAmbiente:Color_pBack := ::Color_pBack
	oAmbiente:Color_pUns  := ::Color_pUns
return self

METHOD AmbienteToColor()
************************
	::aAtivo      := oAmbiente:aAtivo 
	::aAtivoSwap  := oAmbiente:aAtivoSwap
	::Color_pFore := oAmbiente:Color_pFore
	::Color_pBack := oAmbiente:Color_pBack
	::Color_pUns  := oAmbiente:Color_pUns 
	return self

METHOD AddColor( nColor )
*************************
__DefaultNIL(@nColor, ::CorVencido)

aadd( ::Color_pFore,  nColor )			
aadd( ::Color_pBack,  oAmbiente:CorLightBar )	
aadd( ::Color_pUns,   ::CorRecibo )	
aadd( ::aAtivo,       OK)			
aadd( ::aAtivoSwap,   OK)			
return self

METHOD AssignColor()
*-------------------------------*
	::Color_pFore   := {}
	::Color_pBack   := {}
	::Color_pUns    := {}		
	::CorRecibo     := AscanCor(13) // Vermelho do Menu 
	::CorVencido    := AscanCor(16) // Branco do Menu 
	::CorVencer     := AscanCor(11) // Verde do Menu 
	::CorSelecao    := AscanCor(10) // Azul do menu
	::CorAviso      := AscanCor(15) // Amarelo do Menu
	::CorDuplicado  := AscanCor(04) // Cyan
	::CorAlterado   := AscanCor(14) // Magenta
	::CorDesativado := AscanCor(12) // Brown
	Afill((::Color_pFore := Array(Len(::xTodos))), ::CorVencido ) // Branco do Menu
	Afill((::Color_pBack := Array(Len(::xTodos))), oAmbiente:CorLightBar )	
	Afill((::Color_pUns  := Array(Len(::xTodos))), ::CorRecibo ) // Vermelho do Menu 	
	::ColorToAmbiente()
return self

METHOD aChoice_(aTodos, aAtivo, cFuncao, lPageCircular)	
   ::Achoice(::nBoxRow+1, ::nBoxCol+1, ::nBoxRow1-1, ::nBoxCol1-1, ::aTodos, ::aAtivo, cFuncao, NIL, NIL, lPageCircular, ::Color_pFore, ::Color_pBack, ::Color_pUns)
	return self

METHOD Hello 
	? "Hello", self:cWho
	? "Hello", ::cNome
	return self

METHOD ResetCorSelecao 
	LOCAL xLen := Len(::aCurElemento_Selecao)
	LOCAL nT
	for nT := 1 to xLen		
		::aAtivo[::aCurElemento_Selecao[nT]]         := OK
		oAmbiente:aAtivo[::aCurElemento_Selecao[nT]] := OK				
	next
	return self

METHOD ResetSelecao 	
	::ZerarSelecao()
	::RedrawSelecao()	
	::Redraw_()
	return self

METHOD ResetAll 
	::ZerarSelecao()
	::RedrawRecibo()	
	::RedrawVencido()	
	::RedrawVencer()	
	::RedrawGeral()
	::Redraw_()
	return self

METHOD ZerarSelecao 
	::aDocnr_Selecao_Imprimir := {}
	::aSoma_Selecao_Imprimir  := {}
	::aObs_Selecao_Imprimir   := {}	
	::aCurElemento_Selecao    := {}
	
	::nSoma_Total_Imprimir    := 0
	::nPrincipalSelecao       := 0
	::nRescisaoSelecao        := 0
	
	::nJurosSelecao           := 0
	::nMultaSelecao           := 0
	return self

METHOD ZerarRecibo 	
	::nTotal_Recibo           := 0
	::nPrincipal_Recibo       := 0
	::nJuros_Recibo           := 0
	::nMulta_Recibo           := 0	
	::nQtdDoc_Recibo          := 0
	return self	

METHOD ZerarVencer 	
	::nTotal_Vencer           := 0
	::nPrincipal_Vencer       := 0
	::nJuros_Vencer           := 0
	::nMulta_Vencer           := 0	
	::nQtdDoc_Vencer          := 0
	return self	

METHOD ZerarVencido 	
	::nTotal_Vencido          := 0
	::nPrincipal_Vencido      := 0
	::nJuros_Vencido          := 0
	::nMulta_Vencido          := 0	
	::nQtdDoc_Vencido         := 0
	return self	

METHOD ZerarGeral 	
	::nTotal_Geral            := 0
	::nPrincipal_Geral        := 0
	::nJuros_Geral            := 0
	::nMulta_Geral            := 0	
	::nQtdDoc_Geral           := 0
	return self	

METHOD ZerarRescisao 	
	::nPrincipal_Rescisao     := 0
	::nJuros_Rescisao         := 0
	::nMulta_Rescisao         := 0	
	::nTotal_Rescisao         := 0
	::nQtdDoc_Rescisao        := 0
	return self		
	
METHOD RedrawRecibo 
	::cStrRecibo := " RECIBO EMITIDO ¯¯ {"
	::cStrRecibo += StrZero(::nQtdDoc_Recibo,5)
	::cStrRecibo += "}" + Space(::nTab)
	::cStrRecibo += Tran(::nPrincipal_Recibo, "@E 999,999.99") + Space(9)
	::cStrRecibo += Tran(::nJuros_Recibo,     "@E 99,999.99")  + Space(1)
	::cStrRecibo += Tran(::nMulta_Recibo,     "@E 99,999.99")  + Space(1)
	::cStrRecibo += Tran(::nTotal_Recibo,     "@E 999,999.99") + Space(1)
	::cStrRecibo += Tran(::nMulta_Recibo,     "@E 999,999.99")
	return(::cStrRecibo)	

METHOD RedrawVencido 
   ::cStrVencido := " ABERTO VENCIDO ¯¯ {"
	if ::nOrdem == 3
	::cStrVencido := "   PAGO VENCIDO ¯¯ {"
	endif
	::cStrVencido += StrZero(::nQtdDoc_Vencido,5)
	::cStrVencido += "}" + Space(::nTab)
	::cStrVencido += Tran(::nPrincipal_Vencido, "@E 999,999.99") + Space(9)
	::cStrVencido += Tran(::nJuros_Vencido,     "@E 99,999.99")  + Space(1)
	::cStrVencido += Tran(::nMulta_Vencido,     "@E 99,999.99")  + Space(1)
	::cStrVencido += Tran(::nTotal_Vencido,     "@E 999,999.99") + Space(1)
	::cStrVencido += Tran(::nTotal_Vencido,     "@E 999,999.99")
	return(::cStrVencido)	

METHOD RedrawVencer 
	::cStrVencer := " ABERTO VENCER  ¯¯ {"
	if ::nOrdem == 3
	::cStrVencer := "   PAGO VENCER  ¯¯ {"
	
	endif
	::cStrVencer += StrZero(::nQtdDoc_Vencer,5)
	::cStrVencer += "}" + Space(::nTab)
	::cStrVencer += Tran(::nPrincipal_Vencer, "@E 999,999.99") + Space(9)
	::cStrVencer += Tran(::nJuros_Vencer,     "@E 99,999.99")  + Space(1)
	::cStrVencer += Tran(::nMulta_Vencer,     "@E 99,999.99")  + Space(1)
	::cStrVencer += Tran(::nTotal_Vencer,     "@E 999,999.99") + space(1)
	::cStrVencer += Tran(::nTotal_Rescisao,   "@E 999,999.99") + space(1)
	::cStrVencer += Tran(::nTotal_Vencido + ::nTotal_Rescisao,   "@E 999,999.99")
	return(::cStrVencer)

METHOD RedrawGeral 
	::cStrGeral := " TOTAL GERAL    ¯¯ {"
	::cStrGeral += StrZero(::nQtdDoc_Geral, 5)
	::cStrGeral += "}" + Space(::nTab)
	::cStrGeral += Tran(::nPrincipal_Geral, "@E 999,999.99") + Space(9)
	::cStrGeral += Tran(::nJuros_Geral,     "@E 99,999.99")  + Space(1)
	::cStrGeral += Tran(::nMulta_Geral,     "@E 99,999.99")  + Space(1)
	::cStrGeral += Tran(::nTotal_Geral,     "@E 999,999.99") + Space(1)
	::cStrGeral += Tran(::nTotal_Vencido + ::nTotal_Rescisao,   "@E 999,999.99")
	return(::cStrGeral)	

METHOD RedrawSelecao 	
	::cStrSelecao := " TOTAL SELECAO  ¯¯ {"
	::cStrSelecao += StrZero(Len(::aDocnr_Selecao_Imprimir),5)
	::cStrSelecao += "}" + Space(::nTab)
	::cStrSelecao += Tran(::nPrincipalSelecao, 		"@E 999,999.99") + Space(9)
	::cStrSelecao += Tran(::nJurosSelecao,	  	 		"@E 99,999.99")  + Space(1)
	::cStrSelecao += Tran(::nMultaSelecao,		 		"@E 99,999.99")  + Space(1)
	::cStrSelecao += Tran(::nSoma_Total_Imprimir,   "@E 999,999.99") + Space(1)
	::cStrSelecao += Tran(::nRescisaoSelecao,       "@E 999,999.99") + space(1)
	oMenu:StatInf("")
	oMenu:ContaReg( ::cStrSelecao, 31)
	return self

METHOD _SomaPago( nValorTotal, nValorPago )
*********************************************
	 ::cStrRecibo := " TOTAL GERAL ¯¯ "
	 ::cStrRecibo += Space(27 + ::nTab)
	 ::cStrRecibo += Tran(nValorTotal, "@E 999,999,999.99")
	 ::cStrRecibo += Space(01)
	 ::cStrRecibo += Tran(nValorPago,  "@E 999,999,999.99")
	 return( ::cStrRecibo)

*-----------------------------*	 
METHOD ImprimeSoma()
*-----------------------------*
	::aBottom := ::BarraSoma()
	return self

*-----------------------------*
METHOD BarraSoma() 	
*-----------------------------*
	LOCAL xLen		    := Len(::xTodos)
	LOCAL nLastColor   := ::nCorZebradoBranco
	LOCAL nSomaParcial := 0
	LOCAL nAtraso
	LOCAL nDiaComUso
	LOCAL nDiaSemUso
	LOCAL nVlrComUso
	LOCAL nVlrSemUso
	LOCAL cStr
	LOCAL nLen
	LOCAL nVlr
	LOCAL cObs
	LOCAL oBloco	
	
	::ZerarRecibo()
	::ZerarVencer()
	::ZerarVencido()	
	::ZerarRescisao()
	::ZerarGeral()

	::aRescisao  := Array(xLen)
	::nT         := 0
	::nGulosa    := 90
	
	if oAmbiente:lReceber .AND. ::Posireceber
		For ::nT := 1 To xLen
			if ::xTodos[::nT, XTODOS_DOCNR] == "000000-00"
			   loop
			endif
			
			//calcular recibos emitidos			
			if (::aReciboImpresso[::nT]) 			
				::aTodos[::nT]            := Left(::aTodos[::nT], ::nGulosa) + " {" + if( MaxCol() > 79, Alltrim(::xTodos[::nT,XTODOS_OBS]) + "}", "{}")
				::nPrincipal_Recibo       += ::xTodos[::nT, XTODOS_VLR]
				::nMulta_Recibo           += ::xTodos[::nT, XTODOS_MULTA]
				::nJuros_Recibo 			  += ::xTodos[::nT, XTODOS_JUROS]
				::nTotal_Recibo           += ::xTodos[::nT, XTODOS_SOMA]
				::nQtdDoc_Recibo++	
				
				if !(oAmbiente:lK_Ctrl_Ins)
					::Color_pFore[::nT]    := ::CorRecibo
					if (::xTodos[::nT, XTODOS_VLR] - ::xTodos[::nT, XTODOS_SOMA]) > 0
						::Color_pFore[::nT]    := ::CorVencido				
					endif	
				endif				
				
				if ::nOrdem == 1
					::Color_pFore[::nT]    := ::CorRecibo
					if ::nChoice = 3
						::aAtivo[::nT]         := OK
					endif					
				endif
				
				if ::nOrdem == 3 // Somente Recebidos
					::Color_pFore[::nT]    := ::CorRecibo
				endif
				
			else				
				::aTodos[::nT]            := ::sTrFormataATodos(::nT)
			endif
		
			nAtraso := Atraso( Date(), ::xTodos[::nT,XTODOS_VCTO]) 
			::AjustaCorInicio(nAtraso, ::nT)				
					
			//calcular vencidos e em aberto
			
			if ::nOrdem == 3
				if (::aReciboImpresso[::nT]) // com recibo 					
					if ::xTodos[::nT,XTODOS_VCTO] <= ::xTodos[::nT,XTODOS_DATAPAG]						
						::nPrincipal_Vencido += ::xTodos[::nT,XTODOS_VLR]
						::nMulta_Vencido     += ::xTodos[::nT,XTODOS_MULTA]
						::nJuros_Vencido     += ::xTodos[::nT,XTODOS_JUROS]
						::nTotal_Vencido     += ::xTodos[::nT,XTODOS_SOMA]	
						::nQtdDoc_Vencido++															
					endif
				endif
			else
				if ::xTodos[::nT,XTODOS_VCTO] <= Date()							   
					if !(::aReciboImpresso[::nT]) // sem recibo 								
						::nPrincipal_Vencido += ::xTodos[::nT,XTODOS_VLR]
						::nMulta_Vencido     += ::xTodos[::nT,XTODOS_MULTA]
						::nJuros_Vencido     += ::xTodos[::nT,XTODOS_JUROS]
						::nTotal_Vencido     += ::xTodos[::nT,XTODOS_SOMA]	
						::nQtdDoc_Vencido++															
					endif
				endif
			endif
			
			//calcular a vencer	
	
			if ::nOrdem == 3 
				if (::aReciboImpresso[::nT]) // com recibo 
					if ::xTodos[::nT,XTODOS_VCTO] > ::xTodos[::nT,XTODOS_DATAPAG]
						::nPrincipal_Vencer   += ::xTodos[::nT,XTODOS_VLR]
						::nMulta_Vencer	    += ::xTodos[::nT,XTODOS_MULTA]
						::nJuros_Vencer	    += ::xTodos[::nT,XTODOS_JUROS]
						::nTotal_Vencer	    += ::xTodos[::nT,XTODOS_SOMA]	
						::nQtdDoc_Vencer++
					endif				
				endif
			else
				if ::xTodos[::nT,XTODOS_VCTO] > Date() 			   
					if !(::aReciboImpresso[::nT]) // sem recibo 
						::nPrincipal_Vencer   += ::xTodos[::nT,XTODOS_VLR]
						::nMulta_Vencer	    += ::xTodos[::nT,XTODOS_MULTA]
						::nJuros_Vencer	    += ::xTodos[::nT,XTODOS_JUROS]
						::nTotal_Vencer	    += ::xTodos[::nT,XTODOS_SOMA]	
						::nQtdDoc_Vencer++				
					endif					
				endif					
			endif					
			
			//calcular rescisao		
			nVlr := ::xTodos[::nT,XTODOS_VLR]
			cStr := ::aTodos[::nT] 
			nLen := Len(cStr)
			cObs := Right(cStr, nLen-::nGulosa)
			
			if ::nOrdem != 3 
			   if !(::aReciboImpresso[::nT]) 	// sem recibo
					if nAtraso < 0
						if nAtraso < -30
							nVlr *= 0.5  // Metade da Mensalidade de Rescisao
							cstr := ::aTodos[::nT] := Left( ::aTodos[::nT], ::nGulosa) + ' ' + Tran(nVlr,  "@E 999,999.99") + ' {50%}'
							cstr += Space(01)
							cstr += cObs
						else
							nDiaComUso := (30 + nAtraso)
							nDiaSemUso := (30 - nDiaComUso)
							nVlrComUso := (nDiaComUso * (nVlr/30))
							nVlrSemUso := (nDiaSemUso * (nVlr/30)*0.5)
							nVlr		  := (nVlrComUso + nVlrSemUso)								
							cstr       := ::aTodos[::nT] := Left( ::aTodos[::nT], ::nGulosa) + ' ' + Tran(nVlr, "@E 999,999.99") + ;
							                                                            ' {' + StrZero(nDiaComUso,2) + 'D}=' + AllTrim(Tran(nVlrComUso, "@E 999,999.99")) + ;
																								       ' + {' + StrZero(nDiaSemUso,2) + 'D}=' + AllTrim(Tran(nVlrSemUso, "@E 999,999.99")) + ' {50%}'
							cstr       += Space(01)
							cstr       += cObs								
						endif
					endif
				endif	
			endif	
			
			if ::xTodos[::nT,XTODOS_VCTO] > Date() 
				if !(::aReciboImpresso[::nT]) 	// sem recibo
					::nPrincipal_Rescisao += nVlr
					::nMulta_Rescisao	    += ::xTodos[::nT,XTODOS_MULTA] /2
					::nJuros_Rescisao	    += ::xTodos[::nT,XTODOS_JUROS] /2
					::nTotal_Rescisao	    += nVlr
					::aTodos[::nT]        := cStr
					::nQtdDoc_Rescisao++												
				endif	
			endif				
			::aRescisao[::nT] := nVlr
			
			//Mostrar Soma
			if oAmbiente:lMostrarSoma			
				if (::aReciboImpresso[::nT]) 			
					nSomaParcial += ::xTodos[::nT,XTODOS_MULTA]
					oBloco       := if(oAmbiente:ZebrarAmostragem, {||Right(::xTodos[::nT+1,XTODOS_DOCNR], 8) != Right(::xTodos[::nT,XTODOS_DOCNR], 8)} , {||::xTodos[::nT+1,XTODOS_DATAPAG] != ::xTodos[::nT,XTODOS_DATAPAG]})
					if ::nT < xLen 
						if Eval(oBloco)
						   cStr         := ::cStrComValor(nSomaParcial)
							nSomaParcial := 0
						else
							if !(::aReciboImpresso[::nT + 1])
								cStr         := ::cStrComValor(nSomaParcial)
								nSomaParcial := 0							
							else						
								cStr := ::cStrSemValor(::nT)
							endif	
						endif
					else
						cStr := ::cStrComValor(nSomaParcial)
					endif					
				else
					if !(::xTodos[::nT,XTODOS_VCTO] > Date())				
						if nSomaParcial != 0
							cStr         := ::cStrComValor(nSomaParcial)
							nSomaParcial := 0							
						else
							cStr := ::cStrSemValor()
						endif	
					endif	
				endif
				::aTodos[::nT] := cStr				
			endif						
			
			//Zebrar Amostragem			
			if oAmbiente:ZebrarAmostragem		
				if ::nT > 1 
				  if Right(::xTodos[::nT-1 , XTODOS_DOCNR], 8) != Right(::xTodos[::nT,XTODOS_DOCNR], 8)						
						nLastColor := if(nLastColor == ::nCorZebradoBranco, ::nCorZebradoVerde, ::nCorZebradoBranco)
					endif				
				endif						
				::Color_pFore[::nT] := nLastColor				
			endif			
			::AjustaCorFinal(nAtraso, ::nT)
			
		Next
	endif
	::AjustaGeral()
	::cStrAll()	
	::Redraw_()					
	return self
	
*--------------------------*	
METHOD cStrAll() 	
*--------------------------*
	::cStrRecibo    := ::RedrawRecibo
	::cStrVencido   := ::RedrawVencido
	::cstrVencer    := ::RedrawVencer
	::cstrGeral     := ::RedrawGeral		
	return self
	
*-------------------------------*	
METHOD AjustaGeral() 	
*-------------------------------*
	if ::nOrdem != 3 
		::nPrincipal_Geral := ::nPrincipal_Recibo + ::nPrincipal_Vencido + ::nPrincipal_Vencer
		::nMulta_Geral     := ::nMulta_Recibo     + ::nMulta_Vencido     + ::nMulta_Vencer
		::nJuros_Geral 	 := ::nJuros_Recibo     + ::nJuros_Vencido     + ::nJuros_Vencer
		::nTotal_Geral     := ::nTotal_Recibo     + ::nTotal_Vencido     + ::nTotal_Vencer
		::nQtdDoc_Geral    := ::nQtdDoc_Recibo    + ::nQtdDoc_Vencido    + ::nQtdDoc_Vencer
	else
		::nPrincipal_Geral := ::nPrincipal_Recibo 
		::nMulta_Geral     := ::nMulta_Recibo     
		::nJuros_Geral 	 := ::nJuros_Recibo     
		::nTotal_Geral     := ::nTotal_Recibo     
		::nQtdDoc_Geral    := ::nQtdDoc_Recibo    
	endif
	return self	
	
*----------------------------------------------------*	
METHOD function cStrComValor(nSomaParcial) 	
*----------------------------------------------------*
	LOCAL cStr
	cStr := Left( ::aTodos[::nT], ::nGulosa) + ' ' + Tran(nSomaParcial, "@E 999,999.99")  + SubStr( ::aTodos[::nT], ::nGulosa + 1 , 200)
	return(cStr)

*--------------------------------------*	
METHOD function cStrSemValor()
*--------------------------------------*
	LOCAL cStr
	cStr := Left( ::aTodos[::nT], ::nGulosa) + Space(11) + SubStr( ::aTodos[::nT], ::nGulosa + 1 , 200)
	return( cStr)
	
*-------------------------------------------*	
METHOD AjustaCorInicio(nAtraso, nT)		
*-------------------------------------------*
	if nAtraso < 0 
		if ::Color_pFore[nT] == ::CorVencido
			::Color_pFore[nT] := ::CorVencer					
		endif	
	endif	
	if nAtraso > oAmbiente:aSciArray[1,SCI_CARENCIA]		   
		if ::Color_pFore[nT] == ::CorVencido
			::Color_pFore[nT] := ::CorVencido			
		endif	
	endif	
	if nAtraso >= 0 .AND. nAtraso <= oAmbiente:aSciArray[1,SCI_CARENCIA]
		if ::Color_pFore[nT] == ::CorVencido
			::Color_pFore[nT] := ::CorAviso
		endif	
	endif		
	return self
	
*------------------------------------------*	
METHOD AjustaCorFinal(nAtraso, nT) 	
*------------------------------------------*
	if !(::aReciboImpresso[nT]) 
		if nAtraso < 0 
			//if ::Color_pFore[nT] == ::nCorZebradoBranco .OR. ::Color_pFore[nT] == ::nCorZebradoVerde
				::Color_pFore[nT] := ::CorVencer					
			//endif	
		endif	
		if nAtraso > oAmbiente:aSciArray[1,SCI_CARENCIA]		   
			//if ::Color_pFore[nT] == ::nCorZebradoBranco .OR. ::Color_pFore[nT] == ::nCorZebradoVerde
				::Color_pFore[nT] := ::CorVencido			
			//endif	
		endif	
		if nAtraso >= 0 .AND. nAtraso <= oAmbiente:aSciArray[1,SCI_CARENCIA]
			//if ::Color_pFore[nT] == ::nCorZebradoBranco .OR. ::Color_pFore[nT] == ::nCorZebradoVerde
				::Color_pFore[nT] := ::CorAviso
			//endif	
		endif		
	endif	
	return self	

*---------------------------------------------*
METHOD function sTrFormataATodos(nT) 
*---------------------------------------------*
	LOCAL cCodi  := ::xTodos[nT,XTODOS_CODI]
	LOCAL cTodos := ::xTodos[nT,XTODOS_DOCNR]                     + " " + ;						  
							  Left( Dtoc( ::xTodos[nT,XTODOS_EMIS]),5 ) + " " + ;
							  Dtoc(::xTodos[nT,XTODOS_VCTO])            + " " + ;
							  StrZero( ::xTodos[nT,XTODOS_ATRASO], 4) + " {" + ;
							  Tran(::xTodos[nT,XTODOS_VLRORIGINA], "@E 99,999.99")  + "} " + ;
							  Tran(::xTodos[nT,XTODOS_VLR],        "@E 99,999.99")  + " " + ;
							  Tran(::xTodos[nT,XTODOS_DESCONTO],   "@E 9,999.99")   + " " + ;
							  Tran(::xTodos[nT,XTODOS_JUROS],      "@E 9,999.99")   + " " + ;
							  Tran(::xTodos[nT,XTODOS_MULTA],      "@E 99,999.99")  + " " + ;
							  Tran(::xTodos[nT,XTODOS_SOMA],       "@E 999,999.99") + " {" + ;
							  if( MaxCol() > 79, Alltrim(::xTodos[nT,XTODOS_OBS]) + "}", "{}")
	::aCodi[nT]  := cCodi
	::aTodos[nT] := cTodos
	return(cTodos)
	
	
	
*--------------------------------------*
Function TReceposiNew(nBoxRow, nBoxCol, nBoxRow1, nBoxCol1, cTop, cBottom)
	return(TReceposi():New(nBoxRow, nBoxCol, nBoxRow1, nBoxCol1, cTop, cBottom))		
*--------------------------------------*

#XCOMMAND DEFAULT <v1> TO <x1> [, <vn> TO <xn> ]								;
			 =>																				;
			 if <v1> == NIL ; <v1> := <x1> ; END									;
			 [; if <vn> == NIL ; <vn> := <xn> ; END ]

#XCOMMAND DEFAU <v1> TO <x1> [, <vn> TO <xn> ]								   ;
			 =>																				;
			 if <v1> == NIL ; <v1> := <x1> ; END									;
			 [; if <vn> == NIL ; <vn> := <xn> ; END ]


#define INRANGE( xLo, xVal, xHi )  ( xVal >= xLo .AND. xVal <= xHi )
#define InRange( xLo, xVal, xHi )  ( xVal >= xLo .AND. xVal <= xHi )
#define BETWEEN( xLo, xVal, xHi )  Min( Max( xLo, xVal ), xHi )
#define AC_CURELEMENTO  10

/* NOTE: Extension: Harbour supports codeblocks and function pointers
         as the xSelect parameter (both when supplied as is, or as an
         array of codeblocks). [vszakats] */

METHOD AChoice( nTop, nLeft, nBottom, nRight, acItems, xSelect, xUserFunc, nPos, nHiLiteRow, lPageCircular)
***********************************************************************************************************
   LOCAL nNumCols           // Number of columns in the window
   LOCAL nNumRows           // Number of rows in the window
   LOCAL nRowsClr           // Number of rows to clear
   LOCAL alSelect           // Select permission
   LOCAL nNewPos   := 0     // The next item to be selected
   LOCAL lFinished          // Is processing finished?
   LOCAL nKey      := 0     // The keystroke to be processed
   LOCAL nMode              // The current operating mode
   LOCAL nAtTop             // The number of the item at the top
   LOCAL nItems    := 0     // The number of items
   LOCAL nGap               // The number of lines between top and current lines
	
   // Block used to search for items
   LOCAL lUserFunc          // Is a user function to be used?
   LOCAL nUserFunc          // return value from user function
   LOCAL nSaveCsr
   LOCAL nFrstItem := 0
   LOCAL nLastItem := 0

   LOCAL bAction
   LOCAL cKey
   LOCAL nAux
	DEFAU lPageCircular TO .T. 	
		
	hb_default( @nTop, 0)
   hb_default( @nBottom, 0)

   hb_default( @nLeft, 0 )
   hb_default( @nRight, 0 )

   if nRight > MaxCol()
      nRight := MaxCol()
   endif

   if nBottom > MaxRow()
      nBottom := MaxRow()-2
   endif
	
   if ! HB_ISARRAY( ::aTodos ) .OR. Len( ::aTodos ) == 0
      SetPos( nTop, nRight + 1 )
      return 0
   endif

   nSaveCsr := SetCursor( SC_NONE )
   ColorSelect( CLR_STANDARD )

   /* NOTE: Undocumented parameter passing handled. AChoice()
            is called in such way in rldialg.prg from RL tool
            supplied with Clipper 5.x. 6th parameter is the
            user function and 7th parameter is zero (empty I
            suppose). [vszakats] */
   if Empty( xUserFunc ) .AND. ValType( ::aAtivo ) $ "CBS"
      xUserFunc := ::aAtivo
      ::aAtivo   := NIL
   endif

   lUserFunc := ! Empty( xUserFunc ) .AND. ValType( xUserFunc ) $ "CBS"

   if ! HB_ISARRAY( ::aAtivo ) .AND. ! HB_ISLOGICAL( ::aAtivo )
      ::aAtivo := .T.               // Array or logical, what is selectable
   endif

   hb_default( @nPos, 1 )          // The number of the selected item
   hb_default( @nHiLiteRow, 0 )    // The row to be highlighted

   nNumCols := nRight - nLeft + 1
   nNumRows := nBottom - nTop + 1

   if HB_ISARRAY( ::aAtivo )
      alSelect := ::aAtivo
   else
      alSelect := Array( Len( ::aTodos ) )
      AFill( alSelect, ::aAtivo )
   endif

   if ( nMode := ::Ach_Limits( @nFrstItem, @nLastItem, @nItems, alSelect, ::aTodos ) ) == AC_NOITEM
      nPos := 0
		::CurElemento := nPos
   endif

   // Ensure hilighted item can be selected
   nPos := BETWEEN( nFrstItem, nPos, nLastItem )
	::CurElemento := nPos
	
   // Force hilighted row to be valid
   nHiLiteRow := BETWEEN( 0, nHiLiteRow, nNumRows - 1 )

   // Force the topmost item to be a valid index of the array
   nAtTop := BETWEEN( 1, Max( 1, nPos - nHiLiteRow ), nItems )

   // Ensure as much of the selection area as possible is covered
   if ( nAtTop + nNumRows - 1 ) > nItems
      nAtTop := Max( 1, nItems - nNumrows + 1 )
   endif

   ::DispPage( ::aTodos, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems, nItems )

   lFinished := ( nMode == AC_NOITEM )
   if lFinished .AND. lUserFunc
	   Do( xUserFunc, nMode, nPos, nPos - nAtTop )
   endif

   WHILE !lFinished
	
		::nTop     := nTop
		::nLeft    := nLeft
		::nRight   := nRight
		::nNumRows := nNumRows
		::nNumCols := nNumCols	
		::nPos     := nPos
		::nAtTop   := nAtTop
		alSelect   := ::aAtivo
		::alSelect := alSelect		
		acItems    := ::aTodos
		xSelect    := ::aAtivo 
	
		if nMode != AC_EXCEPT .AND. nMode != AC_NOITEM .AND. nMode != AC_CURELEMENTO
         nKey  := Inkey( 0 )
         nMode := AC_IDLE
      endif

      DO CASE
		case nMode = AC_CURELEMENTO
		   nNewPos := ::CurElemento
			DO WHILE !::Ach_Select( alSelect, nNewPos )
            nNewPos--
         ENDDO
         if INRANGE( nAtTop, nNewPos, nAtTop + nNumRows - 1 )
            ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
            nPos := nNewPos
            ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
         else
            DispBegin()
            ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
            hb_Scroll( nTop, nLeft, nBottom, nRight, nNewPos - ( nAtTop + nNumRows - 1 ) )
            nAtTop := nNewPos
            nPos   := Max( nPos, nAtTop + nNumRows - 1 )
            DO WHILE nPos > nNewPos
               if nTop + nPos - nAtTop <= nBottom
                  ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               endif
               nPos--
            ENDDO
            ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
            DispEnd()
         endif
		
      CASE ( bAction := SetKey( nKey ) ) != NIL
         Eval( bAction, ProcName( 1 ), ProcLine( 1 ), "" )
         if NextKey() == 0
            hb_keySetLast( 255 )
            nKey := 0
         endif

         nRowsClr := Min( nNumRows, nItems )
         if ( nMode := ::Ach_Limits( @nFrstItem, @nLastItem, @nItems, alSelect, ::aTodos ) ) == AC_NOITEM
            nPos := 0
            nAtTop := Max( 1, nPos - nNumRows + 1 )
         else
            DO WHILE nPos < nLastItem .AND. ! ::Ach_Select( alSelect, nPos )
               nPos++
            ENDDO

            if nPos > nLastItem
               nPos := BETWEEN( nFrstItem, nPos, nLastItem )
            endif

            nAtTop := Min( nAtTop, nPos )
            if nAtTop + nNumRows - 1 > nItems
               nAtTop := BETWEEN( 1, nPos - nNumRows + 1, nItems - nNumRows + 1 )
            endif

            if nAtTop < 1
               nAtTop := 1
            endif				
         endif			
		

         ::DispPage( ::aTodos, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems, nRowsClr )

      CASE ( nKey == K_ESC .OR. nMode == AC_NOITEM ) .AND. ! lUserFunc

         if nPos != 0
            ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
         endif

         nMode     := AC_IDLE
         nPos      := 0
         lFinished := .T.

      CASE nKey == K_LDBLCLK .OR. nKey == K_LBUTTONDOWN
         nAux := HitTest( nTop, nLeft, nBottom, nRight, MRow(), MCol() )
         if nAux != 0 .AND. ( nNewPos := nAtTop + nAux - 1 ) <= nItems
            if ::Ach_Select( alSelect, nNewPos )
               ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               nPos := nNewPos
               ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
               if nKey == K_LDBLCLK
                  hb_keyIns( K_ENTER )
               endif
            endif
         endif

#ifdef HB_CLP_STRICT
      CASE nKey == K_UP
#else
      CASE nKey == K_UP .OR. nKey == K_MWFORWARD
#endif
			nNewPos := nPos - 1
			if nNewPos < nFrstItem
				nPos    := nLastItem
				nAtTop  := Max( 1, nPos - nNumRows + 1 )
				nNewPos := nPos
				::DispPage( ::aTodos, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
				nMode   := AC_HITBOTTOM
			endif
         
            DO WHILE ! ::Ach_Select( alSelect, nNewPos )
               nNewPos--
            ENDDO
            if INRANGE( nAtTop, nNewPos, nAtTop + nNumRows - 1 )
               ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               nPos := nNewPos
               ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
            else
               DispBegin()
               ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               hb_Scroll( nTop, nLeft, nBottom, nRight, nNewPos - ( nAtTop + nNumRows - 1 ) )
               nAtTop := nNewPos
               nPos   := Max( nPos, nAtTop + nNumRows - 1 )
               DO WHILE nPos > nNewPos
                  if nTop + nPos - nAtTop <= nBottom
                     ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
                  endif
                  nPos--
               ENDDO
               ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
               DispEnd()
            endif
         
#ifdef HB_CLP_STRICT
      CASE nKey == K_DOWN
#else
      CASE nKey == K_DOWN .OR. nKey == K_MWBACKWARD
#endif

         // Find the next selectable item to display
            nNewPos := nPos + 1
				if nNewPos > nLastItem
					nPos    := nFrstItem					
					nAtTop  := nPos
					nNewPos := nPos
					::DispPage( ::aTodos, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					nMode   := AC_HITTOP
				endif
				
            DO WHILE ! ::Ach_Select( alSelect, nNewPos )
               nNewPos++
            ENDDO

            if INRANGE( nAtTop, nNewPos, nAtTop + nNumRows - 1 )
               ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               nPos := nNewPos
               ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
            else
               DispBegin()
               ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               hb_Scroll( nTop, nLeft, nBottom, nRight, nNewPos - ( nAtTop + nNumRows - 1 ) )
               nAtTop := nNewPos - nNumRows + 1
               nPos   := Max( nPos, nAtTop )
               DO WHILE nPos < nNewPos
                  ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
                  nPos++
               ENDDO
               ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
               DispEnd()
            endif
								
         //endif

      CASE nKey == K_CTRL_PGUP .OR. ( nKey == K_HOME .AND. ! lUserFunc )

         if nPos == nFrstItem
				if lPageCircular
					nPos    := nLastItem
					nAtTop  := Max( 1, nPos - nNumRows + 1 )
					nNewPos := nPos
					::DispPage( ::aTodos, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					nMode   := AC_HITBOTTOM
				else
					if nAtTop == Max( 1, nPos - nNumRows + 1 )
						nMode := AC_HITTOP
					else
						nAtTop := Max( 1, nPos - nNumRows + 1 )
						::DispPage( ::aTodos, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					endif
				endif	
         else
            nPos   := nFrstItem
            nAtTop := nPos
            ::DispPage( ::aTodos, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
         endif

      CASE nKey == K_CTRL_PGDN .OR. ( nKey == K_END .AND. ! lUserFunc )

         if nPos == nLastItem
				if lPageCircular
					nPos    := nFrstItem					
					nAtTop  := nPos
					nNewPos := nPos
					::DispPage( ::aTodos, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					nMode   := AC_HITTOP
				else	
					if nAtTop == Min( nLastItem, nItems - Min( nItems, nNumRows ) + 1 )
						nMode   := AC_HITTOP
						nMode := AC_HITBOTTOM
					else
						nAtTop := Min( nLastItem, nItems - nNumRows + 1 )
						::DispPage( ::aTodos, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					endif
				endif	
         else
            if INRANGE( nAtTop, nLastItem, nAtTop + nNumRows - 1 )
               ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               nPos := nLastItem
               ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
            else
               nPos   := nLastItem
               nAtTop := Max( 1, nPos - nNumRows + 1 )
               ::DispPage( ::aTodos, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
            endif
         endif

      CASE nKey == K_CTRL_HOME

         if nPos == nFrstItem
            if nAtTop == Max( 1, nPos - nNumRows + 1 )
               nMode := AC_HITTOP
            else
               nAtTop := Max( 1, nPos - nNumRows + 1 )
               ::DispPage( ::aTodos, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
            endif
         else
            nNewPos := nAtTop
            DO WHILE ! ::Ach_Select( alSelect, nNewPos )
               nNewPos++
            ENDDO
            if nNewPos != nPos
               ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               nPos := nNewPos
               ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
            endif
         endif

      CASE nKey == K_CTRL_END

         if nPos == nLastItem
            if nAtTop == Min( nPos, nItems - Min( nItems, nNumRows ) + 1 ) .OR. nPos == nItems
               nMode := AC_HITBOTTOM
            else
               nAtTop := Min( nPos, nItems - nNumRows + 1 )
               ::DispPage( ::aTodos, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
            endif
         else
            nNewPos := Min( nAtTop + nNumRows - 1, nItems )
            DO WHILE ! ::Ach_Select( alSelect, nNewPos )
               nNewPos--
            ENDDO
            if nNewPos != nPos
               ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               nPos := nNewPos
               ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
            endif
         endif

      CASE nKey == K_PGUP

         if nPos == nFrstItem
				if lPageCircular
					nPos    := nLastItem
					nAtTop  := Max( 1, nPos - nNumRows + 1 )
					nNewPos := nPos
					::DispPage( ::aTodos, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					nMode   := AC_HITBOTTOM
				else
					nMode := AC_HITTOP
					if nAtTop > Max( 1, nPos - nNumRows + 1 )
						nAtTop := Max( 1, nPos - nNumRows + 1 )
						::DispPage( ::aTodos, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					endif
				endif	
         else
            if INRANGE( nAtTop, nFrstItem, nAtTop + nNumRows - 1 )
               // On same page as nFrstItem
               nPos   := nFrstItem
               nAtTop := Max( nPos - nNumRows + 1, 1 )
            else
               if ( nPos - nNumRows + 1 ) < nFrstItem
                  nPos   := nFrstItem
                  nAtTop := nFrstItem
               else
                  nPos   := Max( nFrstItem, nPos - nNumRows + 1 )
                  nAtTop := Max( 1, nAtTop - nNumRows + 1 )
                  DO WHILE nPos > nFrstItem .AND. ! ::Ach_Select( alSelect, nPos )
                     nPos--
                     nAtTop--
                  ENDDO
                  nAtTop := Max( 1, nAtTop )
                  if nAtTop < nNumRows .AND. nPos < nNumRows
                     nPos := nNumRows
                     nAtTop := 1
                  endif
               endif
            endif
            ::DispPage( ::aTodos, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
         endif

      CASE nKey == K_PGDN

         if nPos == nLastItem
				if lPageCircular
					nPos    := nFrstItem					
					nAtTop  := nPos
					nNewPos := nPos
					::DispPage( ::aTodos, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					nMode   := AC_HITTOP
				else
					nMode := AC_HITBOTTOM
					if nAtTop < Min( nPos, nItems - nNumRows + 1 )
						nAtTop := Min( nPos, nItems - nNumRows + 1 )
						::DispPage( ::aTodos, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					endif
				endif	
         else
            if INRANGE( nAtTop, nLastItem, nAtTop + nNumRows - 1 )
               // On the same page as nLastItem
               ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               nPos := nLastItem
               ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
            else
               nGap := nPos - nAtTop
               nPos := Min( nLastItem, nPos + nNumRows - 1 )
               if ( nPos + nNumRows - 1 ) > nLastItem
                  // On the last page
                  nAtTop := nLastItem - nNumRows + 1
                  nPos   := Min( nLastItem, nAtTop + nGap )
               else
                  // Not on the last page
                  nAtTop := nPos - nGap
               endif
               // Make sure that the item is selectable
               DO WHILE nPos < nLastItem .AND. ! ::Ach_Select( alSelect, nPos )
                  nPos++
                  nAtTop++
               ENDDO
               // Don't leave blank space on the page
               DO WHILE ( nAtTop + nNumRows - 1 ) > nItems
                  nAtTop--
               ENDDO
               ::DispPage( ::aTodos, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
            endif
         endif

      CASE nKey == K_ENTER .AND. ! lUserFunc

         if nPos != 0
            ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
         endif

         nMode     := AC_IDLE
         lFinished := .T.

      CASE nKey == K_RIGHT .AND. ! lUserFunc

         if nPos != 0
            ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
         endif

         nPos      := 0
         lFinished := .T.

      CASE nKey == K_LEFT .AND. ! lUserFunc

         if nPos != 0
            ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
         endif

         nPos      := 0
         lFinished := .T.

      CASE ( ! lUserFunc .OR. nMode == AC_EXCEPT ) .AND. ;
           ! ( cKey := Upper( hb_keyChar( nKey ) ) ) == ""

         // Find next selectable item
         FOR nNewPos := nPos + 1 TO nItems
            if ::Ach_Select( alSelect, nNewPos ) .AND. LeftEqI( ::aTodos[ nNewPos ], cKey )
               EXIT
            endif
         NEXT
         if nNewPos == nItems + 1
            FOR nNewPos := 1 TO nPos - 1
               if ::Ach_Select( alSelect, nNewPos ) .AND. LeftEqI( ::aTodos[ nNewPos ], cKey )
                  EXIT
               endif
            NEXT
         endif

         if nNewPos != nPos
            if INRANGE( nAtTop, nNewPos, nAtTop + nNumRows - 1 )
               // On same page
               ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               nPos := nNewPos
               ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
            else
               // On different page
               nPos   := nNewPos
               nAtTop := BETWEEN( 1, nPos - nNumRows + 1, nItems )
               ::DispPage( ::aTodos, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
            endif
         endif

         nMode := AC_IDLE

      CASE nMode == AC_EXCEPT
		   nPos := ::CurElemento
         // Handle keypresses which don't translate to characters
         nMode := AC_IDLE
			
		CASE nMode == AC_CURELEMENTO
			nPos := ::CurElemento
			if nPos != 0
				::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
         endif
			nMode := AC_IDLE
         
      CASE nMode != AC_NOITEM
         nMode := iif( nKey == 0, AC_IDLE, AC_EXCEPT )

      ENDCASE

      if lUserFunc
         if HB_ISNUMERIC( nUserFunc := Do( xUserFunc, nMode, nPos, nPos - nAtTop ) )

            SWITCH nUserFunc
            CASE AC_ABORT
					lFinished := .T.
					nPos      := 0
               EXIT
					
				CASE AC_CURELEMENTO
					if ::CurElemento == nLastItem
						 ::CurElemento--
						 nLastItem := ::CurElemento
					endif	
					nPos := ::CurElemento					
					if nPos != 0
						::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
					endif
					lFinished := .F.
               LOOP
               
				CASE AC_REDRAW  /* QUESTION: Is this correct? */
               if nPos != 0						
						//::DispPage( ::aTodos, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems, nItems )
                  ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
               endif
               lFinished := .T.
               nPos      := 0
               EXIT
            CASE AC_SELECT
               if nPos != 0
                  ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
               endif
               lFinished := .T.
               EXIT
            CASE AC_CONT
               // Do nothing
					nMode := AC_IDLE
               EXIT
            CASE AC_GOTO
               // Do nothing. The next keystroke wont be read and
               // this keystroke will be processed as a goto.
               nMode := AC_EXCEPT
               EXIT
            ENDSWITCH

            if nPos > 0 .AND. nMode != AC_EXCEPT

#if 0
               /* TOVERifY: Disabled nRowsClr ::DispPage().
                  Please verify it, I do not know why it was added but
                  it breaks code which adds dynamically new ::aTodos positions */
               nRowsClr := Min( nNumRows, nItems )
#endif
               if ( nMode := ::Ach_Limits( @nFrstItem, @nLastItem, @nItems, alSelect, ::aTodos ) ) == AC_NOITEM
                  nPos := 0
                  nAtTop := Max( 1, nPos - nNumRows + 1 )
               else
                  DO WHILE nPos < nLastItem .AND. ! ::Ach_Select( alSelect, nPos )
                     nPos++
                  ENDDO

                  if nPos > nLastItem
                     nPos := BETWEEN( nFrstItem, nPos, nLastItem )
                  endif

                  nAtTop := Min( nAtTop, nPos )

                  if nAtTop + nNumRows - 1 > nItems
                     nAtTop := BETWEEN( 1, nPos - nNumRows + 1, nItems - nNumRows + 1 )
                  endif

                  if nAtTop < 1
                     nAtTop := 1
                  endif
               endif

               ::DispPage( ::aTodos, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems /*, nRowsClr */ )
            endif
         else
            if nPos != 0
               ::Displine( ::aTodos[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
            endif
            nPos      := 0
            lFinished := .T.
         endif
      endif
   ENDDO
   SetCursor( nSaveCsr )
   return nPos

METHOD HitTest(nTop, nLeft, nBottom, nRight, mRow, mCol)
*------------------------------------------------------------------*
	if mCol >= nLeft  .AND. ;
      mCol <= nRight .AND. ;
      mRow >= nTop   .AND. ;
      mRow <= nBottom
      return mRow - nTop + 1
	endif
   return 0

METHOD DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nArrLen, nRowsClr )
****************************************************************************************************
   LOCAL nCntr
   LOCAL nRow       // Screen row
   LOCAL nIndex     // Array index
	
   hb_default( @nRowsClr, nArrLen )

   DispBegin()
   for nCntr := 1 TO Min( nNumRows, nRowsClr )
      nRow   := nTop + nCntr - 1
      nIndex := nCntr + nAtTop - 1

      if InRange( 1, nIndex, nArrLen )
         ::Displine( ::aTodos[ nIndex ], nRow, nLeft, ::Ach_Select( alSelect, nIndex ), nIndex == nPos, nRight - nLeft + 1, nIndex )
      else
         ColorSelect( CLR_STANDARD )
         hb_DispOutAt( nRow, nLeft, Space( nRight - nLeft + 1 ) )
      endif
   next
   DispEnd()
   return self

	
METHOD Displine( cLine, nRow, nCol, lSelect, lHiLite, nNumCols, nCurElemento )
******************************************************************************
	nSetColor( ::Color_pFore[nCurElemento], ::Color_pBack[nCurElemento], ::Color_pUns[nCurElemento])
	ColorSelect( iif( lSelect .AND. HB_ISSTRING( cLine ), iif( lHiLite, CLR_ENHANCED, CLR_STANDARD ), CLR_UNSELECTED ))	
	hb_DispOutAt( nRow, nCol, iif(HB_ISSTRING(cLine), PadR(cLine, nNumCols), Space(nNumCols)))	
   if lHiLite
      SetPos( nRow, nCol )
   endif
   ColorSelect( CLR_STANDARD )
   return self
	

METHOD Ach_Limits( /* @ */ nFrstItem, /* @ */ nLastItem, /* @ */ nItems, alSelect, acItems)
*******************************************************************************************
   LOCAL nCntr
   
	nFrstItem := nLastItem := nItems := 0
   for nCntr := 1 TO Len( ::aTodos )
      if HB_ISSTRING( ::aTodos[ nCntr ] ) .AND. Len( ::aTodos[ nCntr ] ) > 0
         nItems++
         if ::Ach_Select( alSelect, nCntr )
            if nFrstItem == 0
               nFrstItem := nLastItem := nCntr
            else
               nLastItem := nItems
            endif
         endif
      else
         exit
      endif
   next

   if nFrstItem == 0
      nLastItem := nItems
      return AC_NOITEM
   endif
   return AC_IDLE

*-------------------------------------------*	
METHOD Ach_Select(alSelect, nPos)
*--------------------------------------------*
   LOCAL sel
	
   if nPos >= 1 .AND. nPos <= Len( alSelect )
      sel := alSelect[ nPos ]
      if HB_ISEVALITEM( sel )
         sel := Eval( sel )
      elseif HB_ISSTRING( sel ) .AND. ! Empty( sel )
         sel := Eval( hb_macroBlock( sel ) )
      endif
      if HB_ISLOGICAL( sel )
         return sel
      endif
   endif
   return true

	
METHOD LeftEqI( string, cKey )	
******************************
	LOCAL nLen := Len( cKey )
	return( iif(Left(string, nLen ) == cKey, true , false))

