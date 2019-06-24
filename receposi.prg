#include "HBclass.ch"
#Include "Box.Ch"
#Include "Inkey.Ch"
#Define FALSO .F.
#DEFINE OK    .T.

CLASS TReceposi
	VAR cWho
	VAR cNome
	VAR aHistRecibo
	VAR aUserRecibo
	VAR aAtivo
	VAR aAtivoSwap
   VAR aRecno
	
	VAR aDocnr_Selecao_Imprimir INIT {}
	VAR aSoma_Selecao_Imprimir  INIT {}
	VAR nSoma_Total_Imprimir    INIT 0
	VAR nPrincipalSelecao       INIT 0
	VAR nJurosSelecao           INIT 0
	VAR nMultaSelecao           INIT 0
	
	VAR nPrincipal_Vencer       INIT 0
	VAR nJuros_Vencer           INIT 0
	VAR nMulta_Vencer           INIT 0	
	VAR nTotal_Vencer           INIT 0
	VAR nQtdDoc_Vencer          INIT 0
	
	VAR nPrincipal_Vencido      INIT 0
	VAR nJuros_Vencido          INIT 0
	VAR nMulta_Vencido          INIT 0	
	VAR nTotal_Vencido          INIT 0
	VAR nQtdDoc_Vencido         INIT 0	
	
	VAR cTop
	VAR aBottom
	VAR nBoxRow
	VAR nBoxCol
	VAR nBoxRow1
	VAR nBoxCol1
	VAR nPrtRow
	VAR nPrtCol
	VAR cPrtStr
	VAR nQtdDoc
	VAR nRecebido
	VAR nPrincipal	
	VAR nJurosPago	
	VAR nAberto	
	VAR PosiAgeInd
	VAR PosiAgeAll
	VAR PosiReceber
	VAR lReceberPorPeriodo INIT FALSO
   VAR dIni
   VAR dFim
   VAR dCalculo
	VAR cStr1 INIT ''
	VAR cStr2 INIT ''
	VAR cStr3 INIT ''	

	//METHOD AddVar
	METHOD Resetar
	METHOD Achoice_
	METHOD MaBox_
	METHOD PrintPosi
	METHOD Redraw_
	METHOD New CONSTRUCTOR
	METHOD Hello	
	METHOD ResetSelecao
	METHOD RedrawSelecao
	METHOD RedrawVencer
	METHOD RedrawVencido
	METHOd ZerarSelecao
	METHOD ZerarVencer
	METHOD ZerarVencido
	
ENDCLASS 

Method New()
	Self:cWho	  := "TTReceposi"
	Self:cNome	  := ProcName()
	::aHistRecibo := {}
	::aUserRecibo := {}
	::aAtivo 	  := {}
	::aAtivoSwap  := {}
   ::aRecno      := {}
	::cTop		  := ""
	::aBottom	  := {"",""}
	::nBoxRow	  := 7
	::nBoxCol	  := 0
	::nBoxRow1	  := MaxRow()
	::nBoxCol1	  := MaxCol()
	::nPrtRow	  := MaxRow()
	::nPrtCol	  := 0
	::nQtdDoc	  := 0
	::nRecebido   := 0
	::nPrincipal  := 0
	::nJurosPago  := 0
	::nAberto	  := 0
	::PosiAgeInd  := FALSO
	::PosiAgeAll  := FALSO
	::PosiReceber := FALSO
   ::dIni        := Ctod("01/01/91")
   ::dFim        := Ctod("31/12/" + Right(Dtoc(Date()),2))
   ::dCalculo    := Date()
return Self

METHOD Resetar()
	Self:New()
return Self

METHOD aChoice_(aTodos, aAtivo, cFuncao)
	Achoice(::nBoxRow+1, ::nBoxCol+1, ::nBoxRow1-3, ::nBoxCol1-1, aTodos, aAtivo, cFuncao )
return Self

METHOD MaBox_()
	MaBox(::nBoxRow, ::nBoxCol, ::nBoxRow1-2, ::nBoxCol1, ::cTop)
return Self

METHOD PrintPosi( nRow, nCol, aStr )
	::nPrtRow := nRow
	::nPrtCol := nCol
	::aBottom := aStr
	Print(::nPrtRow-2, ::nPrtCol, ::aBottom[1], Cor(), MaxCol())
	Print(::nPrtRow-1, ::nPrtCol, ::aBottom[2], Cor(), MaxCol())
	Print(::nPrtRow,   ::nPrtCol, ::aBottom[3], Cor(), MaxCol())
return Self

METHOD Redraw_()
	::nBoxRow1--
	::MaBox_()
	::PrintPosi(::nPrtRow, ::nPrtCol, ::aBottom)
return Self

METHOD Hello
  ? "Hello",Self:cWho
  ? "Hello",::cNome
return Self

METHOD ResetSelecao
	LOCAL cStr
	
	::ZerarSelecao()
	::RedrawSelecao()
	::Redraw_()
return Self

METHOd ZerarSelecao class TReceposi
	::aDocnr_Selecao_Imprimir := {}
	::aSoma_Selecao_Imprimir  := {}
	::nSoma_Total_Imprimir    := 0
	::nPrincipalSelecao       := 0
	::nJurosSelecao           := 0
	::nMultaSelecao           := 0
return self

METHOd ZerarVencer class TReceposi	
	::nTotal_Vencer           := 0
	::nPrincipal_Vencer       := 0
	::nJuros_Vencer           := 0
	::nMulta_Vencer           := 0	
	::nQtdDoc_Vencer          := 0
return self	

METHOd ZerarVencido class TReceposi	
	::nTotal_Vencido          := 0
	::nPrincipal_Vencido      := 0
	::nJuros_Vencido          := 0
	::nMulta_Vencido          := 0	
	::nQtdDoc_Vencido         := 0
return self	
	
METHOD RedrawSelecao class TReceposi
	LOCAL cStr
	
	cStr := " TOTAL SELECAO  ¯¯ {"
	cStr += StrZero(Len(::aDocnr_Selecao_Imprimir),5)
	cStr += "}" + Space(4)
	cStr += Tran(::nPrincipalSelecao, 		"@E 999,999.99") + Space(8)
	cStr += Tran(::nJurosSelecao,	  	 		"@E 999,999.99") + Space(1)
	cStr += Tran(::nMultaSelecao,		 		"@E 9,999.99")   + Space(1)
	cStr += Tran(::nSoma_Total_Imprimir,   "@E 999,999.99")
	oMenu:StatInf("")
	oMenu:ContaReg( cStr )
return Self

METHOD RedrawVencer class TReceposi
	::cStr3 := " ABERTO VENCER  ¯¯ {"
	::cStr3 += StrZero(::nQtdDoc_Vencer,5)
	::cStr3 += "}" + Space(4)
	::cStr3 += Tran(::nPrincipal_Vencer, "@E 999,999.99") + Space(8)
	::cStr3 += Tran(::nJuros_Vencer,     "@E 999,999.99") + Space(1)
	::cStr3 += Tran(::nMulta_Vencer,     "@E 9,999.99")   + Space(1)
	::cStr3 += Tran(::nTotal_Vencer,     "@E 999,999.99")
return(::cStr3)

METHOD RedrawVencido class TReceposi
	::cStr2 := " ABERTO VENCIDO ¯¯ {"
	::cStr2 += StrZero(::nQtdDoc_Vencido,5)
	::cStr2 += "}" + Space(4)
	::cStr2 += Tran(::nPrincipal_Vencido, "@E 999,999.99") + Space(8)
	::cStr2 += Tran(::nJuros_Vencido,     "@E 999,999.99") + Space(1)
	::cStr2 += Tran(::nMulta_Vencido,     "@E 9,999.99")   + Space(1)
	::cStr2 += Tran(::nTotal_Vencido,     "@E 999,999.99")
return(::cStr2)	

Function TReceposiNew()
return(TReceposi():New())

*------------------------------------------------------------------------------
