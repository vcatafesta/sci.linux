/*
  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 İ³																								 ³
 İ³	Programa.....: SUPORTE.PRG 														 ³
 İ³	Aplicacaoo...: MODULO DE SUPORTE AO SCI										 ³
 İ³	Versao.......: 19.50 																 ³
 İ³	Programador..: Vilmar Catafesta													 ³
 İ³	Empresa......: Microbras Com de Prod de Informatica Ltda 				 ³
 İ³	Inicio.......: 12 de Novembro de 1991. 										 ³
 İ³	Ult.Atual....: 06 de Dezembro de 1998. 										 ³
 İ³	Compilacao...: Clipper 5.02														 ³
 İ³	Linker.......: Blinker 3.20														 ³
 İ³	Bibliotecas..: Clipper/Funcoes/Mouse/Funcky15/Funcky50/Classe/Classic ³
 İÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

#Include <sci.ch>

#DEFINE CURSOR 					{ || Setcursor(IIf( Readinsert(!Readinsert()), 1, 2 )) }
#Define ALTERACAO_ON( b )		( b:cargo := TRUE  )
#Define ALTERACAO_OFF( b ) 	( b:cargo := FALSE )
#Define ALTERACAO_ATIVA( b )	( b:cargo )

Function CriaBrowse(nLinT, nColT, nLinB, nColb, cCabecalho )
************************************************************
MaBox( nLint-1, nColT-1, nLinb+1, nColb+1, cCabecalho )
oBrowse				:= TBrowseDb( nLint, nColt, nLinb+1, nColb )
oBrowse:HeadSep	:= Chr(205) + Chr(209) + Chr(205)
oBrowse:ColSep 	:= Chr(032) + Chr(179) + Chr(032)
oBrowse:FootSep	:= Chr(205) + Chr(207) + Chr(205)
Return( oBrowse )

Function Atraso( dHoje, dVcto )
*******************************
Return( dHoje - dVcto )

Function Carencia( dHoje, dVcto )
*********************************
LOCAL nAtraso	 := Atraso( dHoje, dVcto )
LOCAL nCarencia := oAmbiente:aSciArray[1,SCI_CARENCIA]
LOCAL nDiasApos := oAmbiente:aSciArray[1,SCI_DIASAPOS]

IF nAtraso <= nCarencia
	Return( 0 )
EndIF
IF nAtraso > nCarencia
	IF nDiasApos < nAtraso
		Return( nAtraso )
	EndIF
	Return( nAtraso - nDiasApos )
EndIF
//Return( nAtraso - nCarencia )
Return( nAtraso )

Function VlrMulta( dHoje, dVcto, nVlr )
***************************************
LOCAL nAtraso	 := Carencia( dHoje, dVcto )
LOCAL nMulta    := oAmbiente:aSciArray[1,SCI_MULTA]
LOCAL nDiaMulta := oAmbiente:aSciArray[1,SCI_DIAMULTA]

IF nAtraso <= nDiaMulta
	Return( 0 )
EndIF
Return(( nVlr * nMulta) / 100 )

Function VlrDesconto( dHoje, dVcto, nVlr )
******************************************
LOCAL nAtraso	 := ( dHoje - dVcto )
LOCAL nDesconto := oAmbiente:aSciArray[1,SCI_DESCONTO]
LOCAL nDescApos := oAmbiente:aSciArray[1,SCI_DESCAPOS]
LOCAL nDiasApos := oAmbiente:aSciArray[1,SCI_DIASAPOS]

IF nAtraso > 0
   IF nAtraso <= nDiasApos
      Return( JuroDia(nVlr, nDescApos, 1))
	EndIF
	Return( 0 )
EndIF
Return( JuroDia(nVlr, nDesconto, 1))

Function PercDesconto( dHoje, dVcto, nVlr )
*******************************************
LOCAL nAtraso	 := ( dHoje - dVcto )
LOCAL nDesconto := oAmbiente:aSciArray[1,SCI_DESCONTO]
LOCAL nDescApos := oAmbiente:aSciArray[1,SCI_DESCAPOS]
LOCAL nDiasApos := oAmbiente:aSciArray[1,SCI_DIASAPOS]

IF nAtraso > 0
   IF nAtraso <= nDiasApos
		Return( nDescApos )
	EndIF
	Return( 0 )
EndIF
Return( nDesconto )

Function EscolheTitulo( cCodi_Cli, lSemLoop )
*********************************************
LOCAL GetList		 := {}
LOCAL cScreen		 := SaveScreen()
LOCAL cPraca		 := Space(30)
LOCAL cEsta 		 := Space(02)
LOCAL cCodi 		 := cCodi_Cli
LOCAL cVlr			 := ""
LOCAL cJuro 		 := ""
LOCAL cVcto 		 := ""
LOCAL aFatu 		 := {}
LOCAL aDoc			 := {}
LOCAL aRegistro	 := {}
LOCAL alDisponivel := {}
LOCAL aReg			 := {}
LOCAL nConta		 := 0
LOCAL nPosicao 	 := 1
LOCAL nTot_Dup 	 := 0
LOCAL nCol			 := 0
LOCAL _QtDup		 := 0
LOCAL xReg			 := 0
LOCAL nEscolha 	 := 0
LOCAL nContaReg    := 0
LOCAL cString
LOCAL cString1


WHILE OK
	oMenu:Limpa()
	MaBox( MaxRow()-8, 00, MaxRow()-1, MaxCol()-1, "INFORMACOES CADASTRAIS")
	Write( MaxRow()-7, 1 ,"Cliente ....:                                          Codigo...:")
	Write( MaxRow()-6, 1 ,"Endereco ...:                                Bairro...:")
	Write( MaxRow()-5, 1 ,"Cidade .....:                                           Estado..:")
	Write( MaxRow()-4, 1 ,"Praca Pgto .:                                           Estado..:")
	Write( MaxRow()-3, 1 ,"C.G.C.M/F ..:                              INSCR.EST...:")
	Write( MaxRow()-2, 1 ,"C.P.F ......:                              RG..........:")
	cPraca := Space( 30 )
	cEsta  := Space( 02 )
	@ MaxRow()-7, 66 Get cCodi Pict PIC_RECEBER_CODI Valid Cliente( @cCodi, @cPraca,, @cEsta )
	Read
	@ MaxRow()-4, 15 Say cPraca Pict "99999-999/!!!!!!!!!!!!!!!!!!!"
	@ MaxRow()-4, 66 Say cEsta Pict "@!"
	IF LastKey() = ESC
		Exit
	EndIF
	aFatu 		 := {}
	aDoc			 := {}
	aRegistro	 := {}
	nConta		 := 0
	alDisponivel := {}
	nPosicao 	 := 1
	nTot_Dup 	 := 0
	nContaReg    := 0
	cTela := Mensagem( "Aguarde Varrendo Arquivo.")
	Receber->(Order( RECEBER_CODI ))
	Recemov->(Order( RECEMOV_CODI ))
	Area("Recemov")
	Set Rela To Recemov->Codi Into Receber
	Recemov->(Order( RECEMOV_CODI ))
	Recemov->(DbGoTop())
	bBloco := {|| Recemov->Codi = cCodi }
	IF Recemov->(DbSeek( cCodi ))
		WHILE Eval( bBloco )
			nAtraso		:= Atraso( Date(), Vcto )
			nCarencia	:= Carencia( Date(), Vcto )
			nDesconto	:= VlrDesconto( Date(), Vcto, Vlr )
			nMulta		:= VlrMulta( Date(), Vcto, Vlr )
			IF nAtraso <= 0
				nTotJuros := 0
				nVlrTotal := Recemov->Vlr
			Else
				nTotJuros  := nCarencia * Recemov->Jurodia
				nVlrTotal  := nTotJuros + Recemov->Vlr
			EndIF
			nVlrTotal += nMulta
			nVlrTotal -= nDesconto
			cVlr		 := Tran( Vlr, 	  "@E 9,999.99")
			cDesconto := Tran( nDesconto,"@E 9,999.99")
			cMulta	 := Tran( nMulta,   "@E 9,999.99")
			cJuro 	 := Tran( nTotJuros,"@E 9,999.99")
			cTotal	 := Tran( nVlrTotal,"@E 9,999.99")
			cAtraso	 := Tran( nAtraso,  "9999")
			cVcto 	 := Dtoc( Vcto )
			cEmis 	 := Left( Dtoc( Emis ),5)
			cTipo 	 := Left( Recemov->Tipo, 2 )
			Aadd( aDoc, 		  cTipo + "/" + Recemov->Docnr + " " + ;
									  cEmis		+ " " +;
									  cVcto		+ " " +;
									  cAtraso	+ " " +;
									  cVlr		+ " " +;
									  cDesconto + " " +;
									  cMulta 	+ " " +;
									  cJuro		+ " " +;
									  cTotal    + " " +;
									  Obs)
			Aadd( aFatu,		  Recemov->Fatura )
			Aadd( aRegistro,	  Recemov->( Recno()))
			Aadd( alDisponivel, OK )
			Recemov->( DbSkip(1))
			oMenu:ContaReg(++nContaReg)
		EnDdo
	EndIF
	nTot_Dup := Len( aDoc )
	IF nTot_Dup = 0
		oMenu:Limpa()
		ErrorBeep()
		Alerta( "Erro: Cliente Sem Movimento... " )
		IF lSemLoop = NIL .OR. lSemLoop = FALSO
			Loop
		Else
			ResTela( cScreen )
			Return({})
		EndIF
	EndiF
	nCol		:= 10
	aReg		:= {}
	_QtDup	:= 0
	xReg		:= 5
	cString	:= "ENTER=MARCAR³ESC=SAIR/IMPRIMIR MARCADOS"
	cString1 := " DOCTO N§     EMIS   VENCTO ATRA  NOMINAL     DESC    MULTA    JUROS    GERAL OBSERVACOES" 
	cString1 += Space(MaxCol() - Len(cString1))
	Print( 00, 0, Padc( cString, MaxCol()), 75 )
	MaBox( 01, 00, MaxRow()-9, MaxCol()-1, cString1 )	
	WHILE OK
		nEscolha := Achoice( 03, 01, MaxRow()-10, MaxCol()-2, aDoc, alDisponivel,, nPosicao )
		IF nEscolha = 0
			Exit
		EndIf
		_QtDup++
		Aadd( aReg, aRegistro[ nEscolha] )
		aDoc[ nEscolha]		  += " Ok "
		alDisponivel[nEscolha] := FALSO
		nPosicao 				  := nEscolha + 1
		IF nTot_Dup = 1
			Exit
		EndIF
	EndDo
	IF lSemLoop = NIL .OR. lSemLoop = FALSO
		IF Len( aReg ) = 0
		  Loop
		Else
		  Exit
		EndIF
	Else
		Exit
	EndIF
EndDo
ResTela( cScreen )
Return( aReg )

Proc CarneRec( cCodi_Cli, aReg )
********************************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL lCalcular := FALSO
LOCAL i			 := 0
LOCAL _QtDup	 := 0
FIELD Codi
FIELD Vlr
FIELD Tipo
FIELD Port
FIELD Juro
FIELD Vcto

WHILE OK
	IF PCount() = 0
		cCodi_Cli := Space(05)
		aReg		 := {}
		aReg		 := EscolheTitulo( cCodi_Cli )
	EndIF
	IF ( _QtDup := Len( aReg )) = 0
		ResTela( cScreen )
		Return
	EndIF
	ErrorBeep()
	lCalcular := Conf("Pergunta: Calcular Juros ?")
	IF !InsTru80()
		ResTela( cScreen )
		Exit
	EndIF
	Receber->(Order( RECEBER_CODI ))
	Recemov->(Order( RECEMOV_CODI ))
	Area("Recemov")
	Set Rela To Codi Into Receber
	oMenu:Limpa()
	Mensagem("Aguarde, Imprimindo.", WARNING )
	PrintOn()
	FPrint( PQ )
	FPrInt( Chr(ESC) + "C" + Chr( 22 ))
	SetPrc( 0,0 )
	FOR i :=  1 TO _qtdup
		Recemov->(DbGoto( aReg[i] ))
		_Carne( lCalcular )
		__Eject()
	Next
	FPrInt( Chr( 27 )+ "C" + Chr( 66 ) )
	PrintOff()
	Recemov->(DbClearRel())
	Recemov->(DbGoTop())
EndDo

Proc _Carne( lCalcular )
************************
LOCAL cValor	 := Space(0)
LOCAL cTotal	 := Space(0)
LOCAL cHist 	 := Space(60)
LOCAL cDocnr	 := Space(0)
LOCAL cJuros	 := Space(0)
LOCAL nVlr		 := 0
LOCAL nVlrTotal := 0
LOCAL nOpcao	 := 1
LOCAL Larg		 := 80
LOCAL nCol		 := 0
LOCAL nAtraso	 := 0
LOCAL nCarencia := 0
LOCAL nTotJuros := 0
LOCAL nDesconto := 0
LOCAL nMulta	 := 0
LOCAL nSoma 	 := 0
LOCAL nJurodia  := 0
FIELD Vcto
FIELD Vlr
FIELD Docnr
FIELD Juro
FIELD Codi
FIELD Nome

cDocnr	 := Left( Recemov->Tipo, 2 ) + "/" + Recemov->Docnr
nVlr		 := Recemov->Vlr
nVlrTotal := Recemov->Vlr
IF lCalcular
	nDesconto := VlrDesconto( Date(), Vcto, Vlr )
	nMulta	 := VlrMulta( Date(), Vcto, Vlr )
	nAtraso	 := Atraso( Date(), Vcto )
	nCarencia := Carencia( Date(), Vcto )
	nJuroDia  := JuroDia( Recemov->Vlr, Recemov->Juro )
	nVlr		 := Recemov->Vlr
	nVlrTotal := 0
	nTotJuros := 0
	IF nAtraso <= 0
		nTotJuros := 0
		nVlrTotal := nVlr
	Else
		nTotJuros := ( nCarencia * nJuroDia )
		nVlrTotal := ( nTotJuros + nVlr )
	EndIF
	nVlrTotal += nMulta
	nVlrTotal -= nDesconto
EndIF
nSoma  := ( nTotJuros + nMulta ) - nDesconto
cValor := AllTrim(Tran( nVlr, 	  '@E 999,999.99'))
cJuros := AllTrim(Tran( nSoma,	  '@E 999,999.99'))
cTotal := AllTrim(Tran( nVlrTotal, '@E 999,999.99'))
SetPrc(0,0)
nCol	 := 07
Write( nCol-01, 010,  Receber->Codi )
Write( nCol-01, 020,  cDocnr )
Write( nCol-01, 064,  Receber->Codi )
Write( nCol-01, 074,  cDocnr )
Write( nCol-01, 110,  Receber->Codi )
Write( nCol-01, 120,  cDocnr )

Write( nCol+01, 000,  Receber->Nome )
Write( nCol+01, 048,  Receber->Nome )
Write( nCol+01, 096,  Receber->Nome )

Write( nCol+02, 020,  Recemov->Emis )
Write( nCol+02, 065,  Recemov->Emis )
Write( nCol+02, 115,  Recemov->Emis )

Write( nCol+03, 020,  Recemov->Vcto )
Write( nCol+03, 065,  Recemov->Vcto )
Write( nCol+03, 115,  Recemov->Vcto )

Write( nCol+04, 020,  cValor )
Write( nCol+04, 065,  cValor )
Write( nCol+04, 115,  cValor )

Write( nCol+05, 020,  cJuros )
Write( nCol+05, 065,  cJuros )
Write( nCol+05, 115,  cJuros )

Write( nCol+06, 020,  cTotal )
Write( nCol+06, 065,  cTotal )
Write( nCol+06, 115,  cTotal )

Write( nCol+07, 020,  Date() )
Write( nCol+07, 065,  Date() )
Write( nCol+07, 115,  Date() )
Return

Proc CarnePag( cCodi_Cli, aReg )
********************************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL _Qtdup  := 0
LOCAL I		  := 0

WHILE OK
	IF PCount() = 0
		cCodi_Cli := Space(05)
		aReg		 := {}
		aReg		 := EscolheTitulo( cCodi_Cli )
	EndIF
	IF ( _QtDup := Len( aReg )) = 0
		ResTela( cScreen )
		Return
	EndIF
	IF !InsTru80() .OR. !Rep_Ok()
		Recemov->(DbClearRel())
		Recemov->(DbGoTop())
		ResTela( cScreen )
		Return
	EndIF
	Receber->(Order( RECEBER_CODI ))
	Recemov->(Order( RECEMOV_CODI ))
	Area("Recemov")
	Set Rela To Recemov->Codi Into Receber
	Recemov->(Order( RECEMOV_CODI ))
	Mensagem(" Aguarde, Imprimindo. ESC Cancela.", WARNING )
	For i :=  1 To _QtDup
		Recemov->(DbGoto( aReg[i] ))
		SubCarne()
	Next
	aReg := {}
	IF Pcount() != 0
		Exit
	EndIF
EndDo
Recemov->(DbClearRel())
Recemov->(DbGoTop())
ResTela( cScreen )
Return

Proc CarneCaixa( cCodi_Cli, aReg )
**********************************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL _Qtdup  := 0
LOCAL I		  := 0

WHILE OK
	IF PCount() = 0
		cCodi_Cli := Space(05)
		aReg		 := {}
		aReg		 := EscolheTitulo( cCodi_Cli )
	EndIF
	IF ( _QtDup := Len( aReg )) = 0
		ResTela( cScreen )
		Return
	EndIF
	IF !InsTru80() .OR. !Rep_Ok()
		Recemov->(DbClearRel())
		Recemov->(DbGoTop())
		ResTela( cScreen )
		Return
	EndIF
	Receber->(Order( RECEBER_CODI ))
	Recemov->(Order( RECEMOV_CODI ))
	Area("Recemov")
	Set Rela To Recemov->Codi Into Receber
	Recemov->(Order( RECEMOV_CODI ))
	Mensagem(" Aguarde, Imprimindo. ESC Cancela.", WARNING )
	For i :=  1 To _QtDup
		Recemov->(DbGoto( aReg[i] ))
		SubCarneCaixa()
	Next
	aReg := {}
	IF Pcount() != 0
		Exit
	EndIF
EndDo
Recemov->(DbClearRel())
Recemov->(DbGoTop())
ResTela( cScreen )
Return

Proc SubCarne()
***************
#IFDEF CENTRALCALCADOS
	CarneTipo1()
	Return
#ENDIF
CarneOutros()
Return

Proc SubCarneCaixa()
********************
#IFDEF CENTRALCALCADOS
	CarneTipo2()
	Return
#ENDIF
CarneOutros()
Return

Proc CarneOutros()
******************
LOCAL nDiaMulta := oAmbiente:aSciArray[1,DIAMULTA]
LOCAL nMulta    := oAmbiente:aSciArray[1,MULTA]
LOCAL cObs      := "APOS " + AllTrim(Str(nDiaMulta,3)) + "§ DIA, " + AllTrim(Str(nMulta, 6, 2)) + "% MULTA + JUROS AO DIA"
LOCAL nLargura  := 53
LOCAL nVlr_Dup  := Extenso( Recemov->Vlr, 1, 3, nLargura )
LOCAL cDia		 := StrZero( Day( Recemov->Emis ), 2 )
LOCAL cMes		 := Mes( Recemov->Emis )
LOCAL cAno		 := StrZero( Year( Recemov->Emis ),4)
FIELD Vcto
fIELD Vlr

PrintOn()
FPrInt( Chr(ESC) + "C" + Chr(22))
Fprint( _CPI12 )
SetPrc( 0, 0 )
Write( 00,	00, Repl( SEP, 45 ) )
Write( 00,	50, Repl( SEP, 45 ) )
Write( 00, 100, Repl( SEP, 45 ) )

Write( 01,  00, Padc( AllTrim(oAmbiente:xNomefir), 45 ))
Write( 01,  50, Padc( AllTrim(oAmbiente:xNomefir), 45 ))
Write( 01, 100, Padc( AllTrim(oAmbiente:xNomefir), 45 ))

Write( 03,	00, "Nome : "+ Receber->Nome )
Write( 03,	50, "Nome : "+ Receber->Nome )
Write( 03, 100, "Nome : "+ Receber->Nome )

Write( 04, 00,  "Vcto : " + Recemov->(Dtoc( Vcto )))
Write( 04, 27,  "Pgto : " + "___/___/___")

Write( 04, 50,  "Vcto : " + Recemov->(Dtoc( Vcto )))
Write( 04, 77,  "Pgto : " + "___/___/___")

Write( 04, 100, "Vcto : " + Recemov->(Dtoc( Vcto )))
Write( 04, 127, "Pgto : " + "___/___/___")

Write( 05,	00, "Parc : " + Recemov->Docnr )
Write( 05,	27, "Dcto : " + Recemov->Docnr )
Write( 05,	50, "Parc : " + Recemov->Docnr )
Write( 05,	77, "Dcto : " + Recemov->Docnr )
Write( 05, 100, "Parc : " + Recemov->Docnr )
Write( 05, 127, "Dcto : " + Recemov->Docnr )

Write( 06,	00, "Valor: " + Recemov->(Tran( Vlr,"@E 9,999,999,999.99" )))
Write( 06,	50, "Valor: " + Recemov->(Tran( Vlr,"@E 9,999,999,999.99" )))
Write( 06, 100, "Valor: " + Recemov->(Tran( Vlr,"@E 9,999,999,999.99" )))

Write( 07, 00,  "Multa: "  + Repl("_", 18 ))
Write( 07, 27,  "Jr Dia: " + Repl("_", 10 ))
Write( 07, 50,  "Multa: "  + Repl("_", 18 ))
Write( 07, 77,  "Jr Dia: " + Repl("_", 10 ))
Write( 07, 100, "Multa: "  + Repl("_", 18 ))
Write( 07, 127, "Jr Dia: " + Repl("_", 10 ))

Write( 08,	00, "Total: " + Repl("_", 18 ))
Write( 08,	50, "Total: " + Repl("_", 18 ))
Write( 08, 100, "Total: " + Repl("_", 18 ))

Write( 10,	00, cObs )
Write( 10,	50, cObs )
Write( 10, 100, cObs )

Write( 11,	00, Repl( SEP, 45 ) )
Write( 11,	50, Repl( SEP, 45 ) )
Write( 11, 100, Repl( SEP, 45 ) )

Write( 12,	00, Padc( "VIA FIXA",    45 ))
Write( 12,	50, Padc( "VIA CAIXA",   45))
Write( 12, 100, Padc( "VIA CLIENTE", 45))
__Eject()
PrintOff()
Return

Function CalculaCm(nValor, dVcto, dHoje)
****************************************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL nIndice  := 0
LOCAL nValorCm := nValor

Area("CM")
Cm->(Order(CM_INICIO))
Sx_ClrScope( S_TOP )
Sx_ClrScope( S_BOTTOM )
Cm->(DbGoTop())
Sx_SetScope( S_TOP, dVcto)
Sx_SetScope( S_BOTTOM, dHoje )
Cm->(DbGoTop())
Sum Cm->Indice To nIndice
Sx_ClrScope( S_TOP )
Sx_ClrScope( S_BOTTOM )
Cm->(DbGoTop())
AreaAnt(Arq_Ant, Ind_Ant )
nValorCm := (nValor + (nValor * (nIndice/100)))
Return( nValorCm )

/*
Function Jurodia( nVlr, nJuro )
*******************************
Return( Round((( nVlr * nJuro ) / 100) / 30, 2 ))
*/

Function Jurodia( nVlr, nJuro, nPeriodo )
*****************************************
LOCAL j           // Juros
LOCAL p := nVlr   // Principal
LOCAL i := nJuro  // Taxa de Juros
LOCAL n           // Periodo (Dias, Meses, Anos - Depende do contexto do nJuro, se por mes/ano/etc)
      n := (1/30) // 1mes/30dias=1dia
//    n := 1      // 1mes
//    n := (12/1) // 12meses/1mes=1ano
//    n := (6/1)  // 06meses/1mes=1semestre

IfNil( nPeriodo, n )
Return((j := (p * (i/100) * nPeriodo)))

Function aJuroSimples( nPrincipal, nTaxa, nTempo, nPeriodo)
***********************************************************
LOCAL aArray := {}
LOCAL p      := nPrincipal // Principal
LOCAL i      := nTaxa      // Taxa de Juros
LOCAL f      := nPrincipal // Montante
LOCAL j                    // Juros
LOCAL jp     := 0          // Juros por Periodo
LOCAL n           // Periodo (Dias, Meses, Anos - Depende do contexto do nTaxa, se por mes/ano/etc)
      n := 1      // 1mes
      n := (1/4)  // 01meses/4semanas=1semana
      n := (1/3)  // 01meses/3=10dias
      n := (1/2)  // 01meses/2semanas=1quinzena
      n := (2/1)  // 02meses/1mes=1bimestre
      n := (3/1)  // 03meses/1mes=1trimestre
      n := (6/1)  // 06meses/1mes=1semestre
      n := (12/1) // 12meses/1mes=1ano
      n := (1/30) // 1mes/30dias=1dia

IF nPeriodo = NIL
   nPeriodo := n
Else
   n := nPeriodo
EnDiF
IF nTempo = NIL
   nTempo := 0
EndIF
Aadd( aArray, (f:=(p * (1+(i/100)*(n*nTempo)))))        // Valor Futuro ou Montante
Aadd( aArray, (p:=(f / (1+(i/100)*(n*nTempo)))))        // Valor Presente ou Principal
Aadd( aArray, (i:=((f - p)/(p*n)/nTempo*100)))          // Taxa de Juros
Aadd( aArray, (n:=((f - p)/(p*i)*100/nPeriodo)))        // Numero de Periodos
Aadd( aArray, (j:=(f - p)))                             // Juros
Aadd( aArray, (jp:=(j / n)))                            // Juros por Periodo
Return(aArray)

Function aAntComposto( nPrincipal, nTaxa, nTempo, nPeriodo )
************************************************************
LOCAL aArray   := {}
LOCAL nAtraso  := nTempo
LOCAL nJuros   := 0
LOCAL nBase    := 31
LOCAL nTotJr   := 0
LOCAL x        := 0
LOCAL y        := 0
LOCAL nValor   := nPrincipal
LOCAL nJurodia := Jurodia( nPrincipal, nTaxa, nPeriodo)

For x := 1 To nAtraso
   IF x = nBase
      nAtraso     -= 30
      x           := 0
      nValor      += nJuros
      nJuros      := 0
      nJurodia    := Jurodia( nValor, nTaxa, nPeriodo )
      Loop
   EndIF
   y ++
   nJuros += nJurodia
   nTotJr += nJuroDia
Next
Aadd( aArray, (nPrincipal + nTotJr))   // Valor Futuro ou Montante
Aadd( aArray, (nPrincipal))            // Valor Presente ou Principal
Aadd( aArray, (nTaxa))                 // Taxa de Juros
Aadd( aArray, (nTempo))                // Numero de Periodos
Aadd( aArray, (nTotJr))                // Juros
Aadd( aArray, (nTotJr/nTempo))         // Juros por Periodo
Return(aArray)

Function aJuroComposto( nPrincipal, nTaxa, nTempo, nPeriodo)
************************************************************
LOCAL aArray := {}
LOCAL p      := nPrincipal // Principal
LOCAL i      := nTaxa      // Taxa de Juros
LOCAL f      := nPrincipal // Montante
LOCAL j                    // Juros
LOCAL n                    // Periodo (Dias, Meses, Anos - Depende do contexto do nTaxa, se por mes/ano/etc)
      n := 1               // 1mes
      n := (1/4)           // 01meses/4semanas=1semana
      n := (1/3)           // 01meses/3=10dias
      n := (1/2)           // 01meses/2semanas=1quinzena
      n := (2/1)           // 02meses/1mes=1bimestre
      n := (3/1)           // 03meses/1mes=1trimestre
      n := (6/1)           // 06meses/1mes=1semestre
      n := (12/1)          // 12meses/1mes=1ano
      n := (1/30)          // 1mes/30dias=1dia

IF nPeriodo = NIL
   nPeriodo := n
Else
   n := nPeriodo
EnDiF
IF nTempo = NIL
   nTempo := 0
EndIF

Aadd( aArray, (f:=(p * (1+(i/100))^(n*nTempo))))          // Valor Futuro ou Montante
Aadd( aArray, (p:=(f / (1+(i/100))^(n*nTempo))))          // Valor Presente ou Principal
Aadd( aArray, (i:=((f / p)^(1/(n*nTempo))-1)*100))        // Taxa de Juros

Aadd( aArray, (n:=((f / p)/(p*i)*100/nPeriodo)-1))        // Numero de Periodos
//Aadd( aArray, (n^=((f/p)/(1+i)/nperiodo)-1))                         // Numero de Periodos

Aadd( aArray, (j:=(f - p)))                               // Juros
Aadd( aArray, (jp:=(j / n)))                              // Juros por Periodo
Return(aArray)

Proc ConLista( nChoice )
************************
LOCAL GetList	:= {}
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()
LOCAL bSetKey	:= SetKey( F5 )

IF nChoice = NIL
	nChoice = 0
EndIF
SetKey( F5, NIL )
oMenu:Limpa()
Area("Lista")
Pagar->(Order( PAGAR_CODI ))
Set Rela To Codi Into Pagar
IF nChoice = 1
	Lista->(Order( LISTA_CODIGO ))
Else
	Lista->(Order( LISTA_DESCRICAO ))
EndIF
Lista->(DbGoTop())
oBrowse:Add( "CODIGO",    "Codigo",    "999999")
oBrowse:Add( "DESCRICAO", "Descricao", "@!")
oBrowse:Add( "PCOMPRA",   "PCompra",   "@E 99999999.99")
oBrowse:Add( "MARCUS",    "MarCus",    "999.99")
oBrowse:Add( "PCUSTO",    "Pcusto",    "@E 99999999.99")
oBrowse:Add( "MARVAR",    "Marvar",    "999.99")
oBrowse:Add( "VAREJO",    "Varejo",    "@E 99999999.99")
oBrowse:Add( "MARATA",    "MarAta",    "999.99")
oBrowse:Add( "ATACADO",   "Atacado",   "@E 99999999.99")
oBrowse:Titulo := "CONSULTA/ALTERACAO DE PRODUTOS"
oBrowse:HotKey( F4, {|| oBrowse:DupReg("LISTA", "CODIGO", LISTA_CODIGO)})
oBrowse:HotKey( F3, {|| AjustaLista( oBrowse ) })
oBrowse:PreDoGet := {|| PreConLista( oBrowse, nChoice ) } // Rotina do Usuario Antes de Atualizar
oBrowse:PosDoGet := {|| PosConLista( oBrowse, nChoice ) } // Rotina do Usuario apos Atualizar
oBrowse:PreDoDel := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
Lista->(DbClearRel())
Lista->(DbGoTop())
AreaAnt( Arq_Ant, Ind_Ant )
SetKey( F5, bSetKey )
ResTela( cScreen )

Function AjustaLista( oBrowse )
*******************************
LOCAL cScreen	:= SaveScreen()
LOCAL oCol		:= oBrowse:getColumn( oBrowse:colPos )
LOCAL nMarVar	:= 0
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL xTemp 	:= FTempName()
LOCAL aStru 	:= Lista->(DbStruct())
LOCAL nConta	:= Lista->(FCount())
LOCAL nDebito	:= 0
LOCAL nCredito := 0
LOCAL cMens
LOCAL xRegistro
LOCAL xCodigo

ErrorBeep()
IF !Conf('Pergunta: Ajustar estoque do registro sob o cursor ?')
	Return( OK )
EndIF
xRegistro := Lista->(Recno())
xCodigo	 := Lista->Codigo
Saidas->(Order( SAIDAS_CODIGO ))
IF Saidas->(DbSeek( xCodigo ))
	Mensagem('Aguarde, Somando Saidas.')
	While Saidas->Codigo = xCodigo .AND. Rep_Ok()
		nDebito += Saidas->Saida
		Saidas->(DbSkip(1))
	EndDo
EndIF
Entradas->(Order( ENTRADAS_CODIGO ))
IF Entradas->(DbSeek( xCodigo ))
	Mensagem('Aguarde, Somando Entradas.')
	While Entradas->Codigo = xCodigo  .AND. Rep_Ok()
		nCredito += Entradas->Entrada
		Entradas->(DbSkip(1))
	EndDo
EndIF
Mensagem('Aguarde, Gravando Estoque.')
Lista->(DbGoto(xRegistro))
IF Lista->(TravaReg())
	Lista->Quant := ( nCredito - nDebito )
	Lista->(Libera())
	cMens := "Tarefa: Estoque Atualizado."
Else
	oMenu:Limpa()
	cMens := "Erro: Estoque contado mas nao Atualizado."
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Lista->(DbGoto( xRegistro ))
oBrowse:FreshOrder()
Lista->(DbGoto( xRegistro ))
Alerta( cMens )
Return( OK )

Function PreConLista( oBrowse, nChoice )
****************************************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen()
LOCAL oCol		  := oBrowse:getColumn( oBrowse:colPos )
LOCAL nMarVar	  := 0
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()
LOCAL xStr		  := Chr(0)
LOCAL lAlteracao := OK
LOCAL nRegistro  := Recno()

IF !PodeAlterar()
	Return( FALSO)
EndIF

IF nChoice = 1 .OR. nChoice = 2
	InclusaoProdutos( lAlteracao )
	AreaAnt( Arq_Ant, Ind_Ant )
	oBrowse:RefreshAll()
	Lista->(DbGoTo( nRegistro ))
	oBrowse:RefreshCurrent()
	Return( FALSO )
EndIF
Do Case
Case oCol:Heading = "CODIGO"
	Entradas->(Order( ENTRADAS_CODIGO ))
	Saidas->(Order( SAIDAS_CODIGO ))
	xStr := Lista->Codigo
	IF Saidas->(DbSeek( xStr ))
		ErrorBeep()
		Alerta("Erro: Produto com Saidas de Mercadorias.")
		AreaAnt( Arq_Ant, Ind_Ant )
		Return( FALSO )
	EndIF
	IF Saidas->(DbSeek( xStr ))
		ErrorBeep()
		Alerta("Erro: Produto com Entradas de Mercadorias.")
		AreaAnt( Arq_Ant, Ind_Ant )
		Return( FALSO )
	EndIF
Case oCol:Heading = "QUANT" .OR. oCol:Heading = "ESTOQUE"
	#IFDEF DIMAG
		Return( OK )
	#ENDIF
	ErrorBeep()
	Alerta("Erro: Use Entradas e Saidas.")
	Return( FALSO )
EndCase
Return( PodeAlterar())

Function PosConLista( oBrowse, nChoice )
****************************************
LOCAL oCol		 := oBrowse:getColumn( oBrowse:colPos )
LOCAL nMarVar	 := 0
LOCAL nMarAta	 := 0
LOCAL nMarCus	 := 0
LOCAL cCodi 	 := Space(04)
LOCAL cCodi1	 := Space(04)
LOCAL cCodi2	 := Space(04)
LOCAL cCodi3	 := Space(04)
LOCAL cCodGrupo := Space(03)
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL cClasse	 := Space(02)
LOCAL cSitucao  := Space(01)
LOCAL cRepres	 := Space(04)
Do Case
Case oCol:Heading = "SIGLA"
	ErrorBeep()
	IF !Conf("Mudar a Marca?")
		Lista->Sigla := Pagar->Sigla
	EndIF
	AreaAnt( Arq_Ant, Ind_Ant )
Case oCol:Heading = "REPRES"
	cRepres := Lista->Repres
	Represrrado( @cRepres )
	Lista->Repres := cRepres
	AreaAnt( Arq_Ant, Ind_Ant )
Case oCol:Heading = "SITUACAO"
	cSituacao := Lista->Situacao
	PickClasse( @cSituacao )
	Lista->Situacao := cSituacao
	AreaAnt( Arq_Ant, Ind_Ant )
Case oCol:Heading = "CLASSE"
	cClasse := Lista->Classe
	PickClasse( @cClasse )
	Lista->Classe := cClasse
	AreaAnt( Arq_Ant, Ind_Ant )
Case oCol:Heading = "CODGRUPO"
	cCodGrupo := Lista->CodGrupo
	GrupoErrado( @cCodGrupo )
	Lista->CodGrupo := cCodGrupo
	AreaAnt( Arq_Ant, Ind_Ant )
Case oCol:Heading = "CODI"
	cCodi := Lista->Codi
	Pagarrado( @cCodi )
	Lista->Codi := cCodi
	AreaAnt( Arq_Ant, Ind_Ant )
Case oCol:Heading = "CODI1"
	cCodi1 := Lista->Codi1
	Pagarrado( @cCodi1 )
	Lista->Codi1 := cCodi1
	AreaAnt( Arq_Ant, Ind_Ant )
Case oCol:Heading = "CODI2"
	cCodi2 := Lista->Codi2
	Pagarrado( @cCodi2 )
	Lista->Codi2 := cCodi2
	AreaAnt( Arq_Ant, Ind_Ant )
Case oCol:Heading = "CODI3"
	cCodi3 := Lista->Codi3
	Pagarrado( @cCodi3 )
	Lista->Codi3 := cCodi3
	AreaAnt( Arq_Ant, Ind_Ant )
Case oCol:Heading = "PCOMPRA"
	IF Conf("Atualizar Preco Custo?")
		Lista->PCusto	:= ((Lista->Pcompra * Lista->MarCus ) / 100 ) + Lista->PCompra
	EndIF
Case oCol:Heading = "MARCUS"
	IF Conf("Atualizar Preco Custo?")
		Lista->PCusto	:= ((Lista->Pcompra * Lista->MarCus ) / 100 ) + Lista->PCompra
	EndIF
Case oCol:Heading = "PCUSTO"
	IF Lista->Pcusto = 0
		IF Conf("Zerar Valores de Venda ?")
			Lista->MarCus	:= 0
			Lista->MarVar	:= 0
			Lista->MarAta	:= 0
			Lista->Pcusto	:= 0
			Lista->Varejo	:= 0
			Lista->Atacado := 0
		EndIF
	Else
		IF Conf("Atualizar Preco ?")
			Lista->Varejo	:= ((Lista->Pcusto * Lista->MarVar ) / 100 ) + Lista->Pcusto
			Lista->Atacado := ((Lista->Pcusto * Lista->MarAta ) / 100 ) + Lista->Pcusto
		EndIF
		nMarCus := (( Lista->Pcusto / Lista->Pcompra ) * 100 ) - 100
		IF nMarCus > 999.99
			nMarCus := 999.99
			cTela   := Mensagem("Informa: Margem muito Alta", Cor())
			Inkey(2)
			ResTela( cTela )
		ElseIF nMarcus < -99.99
			nMarcus := -99.99
		EndIF
		Lista->MarCus := nMarCus
	EndIF
Case oCol:Heading = "MARATA"
	IF Conf("Atualizar Preco ?")
		Lista->Atacado := ((Lista->Pcusto * Lista->MarAta ) / 100 ) + Lista->Pcusto
	EndIF
Case oCol:Heading = "MARVAR"
	IF Conf("Atualizar Preco ?")
		Lista->Varejo := ((Lista->Pcusto * Lista->MarVar ) / 100 ) + Lista->Pcusto
	EndIF
Case oCol:Heading = "VAREJO"
	IF Lista->Pcusto != 0
		IF Lista->Varejo = 0
			Lista->Varejo := Pcusto
		EndIF
		nMarVar := (( Lista->Varejo / Lista->Pcusto ) * 100 ) - 100
		IF nMarVar > 999.99
			cTela   := Mensagem("Informa: Margem muito Alta", Cor())
			nMarVar := 999.99
			Inkey(2)
			ResTela( cTela )
		EndIF
		Lista->MarVar := nMarVar
	EndIF
Case oCol:Heading = "ATACADO"
	IF Lista->Pcusto != 0
		IF Lista->Atacado = 0
			Lista->Atacado := Pcusto
		EndIF
		nMarAta := (( Lista->Atacado / Lista->Pcusto ) * 100 ) - 100
		IF nMarAta > 999.99
			cTela   := Mensagem("Informa: Margem muito Alta", Cor())
			nMarAta := 999.99
			Inkey(2)
			ResTela( cTela )
		EndIF
		Lista->MarAta := nMarAta
	EndIF
OtherWise
EndCase
Lista->Atualizado := Date()
//Lista->Sigla 	  := Pagar->Sigla
IF Lista->Data != Date()
	Lista->Data := Date()
EndIF
Return( OK )

Function BarNewCode( cCodeBar, cForn, cCodigo )
***********************************************
cCodeBar := EMPRECODEBAR + cForn + cCodigo
cCodeBar += EanDig( cCodeBar )
Return( OK )

Proc ApDados()
**************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL xArquivo := Space(30)

oMenu:Limpa()
MaBox( 10, 10, 12, 70 )
@ 11, 11 Say "Arquivo a Incluir :" Get xArquivo Pict "@!" Valid VerExis( xArquivo )
Read
IF LastKey() = ESC .OR. !Conf("Pergunta: Continuar com a Anexacao.")
	ResTela( cScreen )
	Return
EndIF

Use ( xArquivo ) Alias Conhec New
Area("Receber")
Receber->(Order( RECEBER_NOME ))
Area("Recemov")
Recemov->(Order( RECEMOV_DOCNR ))
Mensagem("Aguarde, Anexando Registros.", Cor())
Conhec->(DbGoTop())
While Conhec->(!Eof())
	cDocnr		:= Conhec->NrForm_Ch
	cNome 		:= Conhec->Dest_Ch
	cNomeRegiao := Conhec->Cidd_Ch
	Regiao->(Order( REGIAO_NOME ))
	IF Regiao->(!DbSeek( cNomeRegiao ))
		Regiao->(Order( REGIAO_REGIAO ))
		Regiao->(DbGoBottom())
		cCodiRegiao 	:= Regiao->( StrZero( Val( Regiao ) + 1, 2))
		IF Regiao->(Incluiu())
			Regiao->Regiao := cCodiRegiao
			Regiao->Nome	:= cNomeRegiao
			Regiao->(Libera())
		EndIF
	EndIF
	cCodiRegiao := Regiao->Regiao
	cNomeRegiao := Regiao->Nome
	Receber->(Order( RECEBER_NOME ))
	IF Receber->(DbSeek( cNome ))
		cCodi := Receber->Codi
		IF Receber->Regiao != cCodiRegiao
			IF Receber->(TravaReg())
				Receber->Regiao := cCodiRegiao
				Receber->(Libera())
			EndIF
		EndIF
	Else
		Receber->(Order( RECEBER_CODI ))
		Receber->(DbGoBottom())
		cCodi := Receber->( StrZero( Val( Codi ) + 1, 4))
		IF Receber->(Incluiu())
			cCgc				 := Conhec->Cgcd_Ch
			cInsc 			 := Conhec->Iestd_Ch
			Receber->Codi	 := cCodi
			Receber->Nome	 := cNome
			Receber->Cida	 := Conhec->Cidd_Ch
			Receber->Ende	 := Conhec->Endd_Ch
			Receber->Esta	 := Conhec->Estd_Ch
			Receber->Cep	 := Conhec->Cepd_Ch
			Receber->Cgc	 := IF( Right( cCgc, 3 ) = Space(3), "", cCgc )
			Receber->Cpf	 := IF( Right( cCgc, 3 ) = Space(3), cCgc, ""  )
			Receber->Insc	 := IF( Right( cCgc, 3 ) = Space(3), "" , cInsc )
			Receber->Rg 	 := IF( Right( cCgc, 3 ) = Space(3), cInsc, ""  )
			Receber->Regiao := cCodiRegiao
			Receber->(Libera())
		EndIF
	EndIF
	Recebido->(Order( RECEBIDO_DOCNR ))
	IF Recebido->(!DbSeek( cDocnr ))
		IF Recemov->(!DbSeek( cDocnr ))
			IF Recemov->(Incluiu())
				Recemov->Codi		  := cCodi
				Recemov->Vlr		  := Conhec->TotFrete
				Recemov->VlrDolar   := Conhec->TotFrete
				Recemov->Emis		  := Conhec->DtEmis_Ch
				Recemov->Vcto		  := Conhec->DtEmis_Ch + 30
				Recemov->Docnr 	  := cDocnr
				Recemov->Fatura	  := cDocnr
				Recemov->Qtd_D_Fatu := 1
				Recemov->Port		  := "CARTEIRA"
				Recemov->Tipo		  := "DS"
				Recemov->Titulo	  := OK
				Recemov->Regiao	  := cCodiRegiao
				Recemov->(Libera())
			EndIF
		EndIF
	EndIF
	Conhec->(DbSkip(1))
EnDDo
Conhec->(DbCloseArea())
ResTela( cScreen )
Return

Function VerExis( xArquivo )
****************************
IF !File( xArquivo )
	ErrorBeep()
	Alerta("Erro: Arquivo nao localizado.")
	Return( FALSO )
EndIF
Return( OK )

Function EDitarObs( cBuffer, nRow, nCol, nRow1, nCol1 )
******************************************************
LOCAL cScreen := SaveScreen()
LOCAL bSetKey := SetKey( F1 )

IF Lastkey() = UP
	Return( OK )
EndIF
SetKey( F1, NIL )
nRow	:= IF( nRow  = NIL, 01, 		  nRow )
nCol	:= IF( nCol  = NIL, 00, 		  nCol )
nRow1 := IF( nRow1 = NIL, MaxRow()-1, nRow1 )
nCol1 := IF( nCol1 = NIL, MaxCol(),   nCol1 )

MaBox( nRow, nCol, nRow1, nCol1, "OBSERVACOES")
SetColor("B/W")
SetCursor(1)
Liga_Acento()
cBuffer := MemoEdit( cBuffer, nRow+1, nCol+1, nRow1-1, nCol1-1, .T.,"LinhaObs", MaxCol())
oAmbiente:Acento := FALSO
SetKey( F1, bSetKey )
ResTela( cScreen )
Desliga_Acento()
Return( OK )

Function LinhaObs( Mode, Line, Col )
************************************
LOCAL GetList	  := {}
LOCAL nCopias	  := 1
LOCAL cScreen	  := SaveScreen()
LOCAL lCancel	  := FALSO
LOCAL cOldColor  := SetColor()
LOCAL Tela1

DO Case
Case Mode = 0
	Return( 0 )

Case LastKey() =	-1 	  // F2	GRAVA E SAI
	Return( 23 )

Case LastKey() =	27 	  // ESC ?
	IF Conf(" Deseja Gravar o Texto ? " )
		Return( 23 )

	EndIF

Case LastKey() =	F1
	MaBox( 10, 10, 17, 50, "COMANDOS DE EDICAO")
	Write( 11, 11, "CTRL+Y = Limpar Linha Corrente")
	Write( 12, 11, "CTRL+T = Eliminar Palavra a Direita")
	Write( 13, 11, "DELETE = Eliminar Caractere")
	Write( 14, 11, "INSERT = Liga/Desliga Insercao")
	Write( 15, 11, "HOME   = Vai para Inicio da Linha")
	Write( 16, 11, "END    = Vai para Final da Linha")
	Inkey(0)
	ResTela( cScreen )
	Return( 1 )

Case LastKey() =	K_CTRL_P
	nCopias := 1
	MaBox( 13, 10, 15, 31 )
	@ 14,11 SAY "Qtde Copias...:" Get nCopias PICT "999" Valid nCopias > 0
	Read
	IF LastKey() = ESC .OR. !Instru80()
		SetColor( cOldColor )
		ResTela( cScreen )
		Return
	EndIF
	Mensagem("Aguarde, Imprimindo.", Cor())
	PrintOn()
	SetPrc( 0, 0 )
	For X := 1 To nCopias
		 Campo	  := MemoRead( Arquivo )
		 Linhas	  := MlCount( Campo, 80 )
		 For Linha := 1 To Linhas
			 Imprime := MemoLine( Campo, 80, linha )
			 Write( 0 + Linha -1, 0, Imprime )
		 Next
		 __Eject()
	Next
	PrintOff()
	SetColor( cOldColor )
	ResTela( cScreen )
	Return

OtherWise
	Return(0)

EndCase

Proc AltConta()
***************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
Area("Conta")
Conta->(Order( CONTA_CODI ))
Conta->(DbGoTop())
oBrowse:Add( "CODIGO",    "Codi")
oBrowse:Add( "HISTORICO", "Hist")
oBrowse:Titulo := "CONSULTA/ALTERACAO DE CONTA HISTORICO"
oBrowse:PreDoGet := {|| PreAltConta( oBrowse ) } // Rotina do Usuario Antes de Atualizar
oBrowse:PosDoGet := {|| PosAltConta( oBrowse ) } // Rotina do Usuario apos Atualizar
oBrowse:PreDoDel := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Function PreAltConta( oBrowse )
*******************************
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )
LOCAL nMarVar := 0

Do Case
Case oCol:Heading = "CODI"
Case oCol:Heading = "HIST"
Otherwise
EndCase
Return( OK )

Function PosAltConta( oBrowse )
*******************************
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )
LOCAL nMarVar := 0
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Do Case
Case oCol:Heading = "CODI"
Case oCol:Heading = "HIST"
OtherWise
EndCase
Return( OK )

Proc AltSubConta()
******************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
Area("SubConta")
SubConta->(Order( SUBCONTA_CODI ))
SubConta->(DbGoTop())
oBrowse:Add( "CODIGO",    "Codi")
oBrowse:Add( "SUBCODIGO", "SubCodi")
oBrowse:Add( "DEBCRE",    "DebCre")
oBrowse:Titulo   := "CONSULTA/ALTERACAO DE SUB CONTA HISTORICO"
oBrowse:PreDoGet := {|| PreAltSubConta( oBrowse ) } // Rotina do Usuario Antes de Atualizar
oBrowse:PosDoGet := {|| PosAltSubConta( oBrowse ) } // Rotina do Usuario apos Atualizar
oBrowse:PreDoDel := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Function PreAltSubConta( oBrowse )
*******************************
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Do Case
Case oCol:Heading = "CODI"
Case oCol:Heading = "SUBCODI"
Case oCol:Heading = "DEBCRE"
Otherwise
EndCase
Return( OK )

Function PosAltSubConta( oBrowse )
*******************************
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Do Case
Case oCol:Heading = "CODI"
	cCodi := SubConta->Codi
	ContaErrada(@cCodi )
	SubConta->Codi := cCodi
	AreaAnt( Arq_Ant, Ind_Ant )

Case oCol:Heading = "SUBCODI"
	cSubCodi := SubConta->SubCodi
	Cheerrado(@cSubCodi )
	SubConta->SubCodi := cSubCodi
	AreaAnt( Arq_Ant, Ind_Ant )

Case oCol:Heading = "DEBCRE"
OtherWise
EndCase
Return( OK )

Proc TaxasDbEdit()
******************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()
Set Key -8 To

oMenu:Limpa()
Area("Taxas")
Taxas->(Order( TAXAS_DFIM ))
Taxas->(DbGoTop())
oBrowse:Add( "DATA",           "DIni")
oBrowse:Add( "VALIDADE",       "DFim")
oBrowse:Add( "TX ATUALIZACAO", "TxAtu")
oBrowse:Add( "TX JUR VAREJO",  "JurVar")
oBrowse:Add( "TX JUR ATACADO", "JurAta")
oBrowse:Add( "UFIR",           "Ufir")
oBrowse:Add( "DOLAR",          "Cotacao")
oBrowse:Titulo   := "CONSULTA/ALTERACAO DE TAXAS"
oBrowse:PreDoGet := NIL
oBrowse:PosDoGet := NIL
oBrowse:Show()
oBrowse:Processa()
ResTela( cScreen )

Proc RepresDbedit()
*******************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
Area("Repres")
Repres->(Order( REPRES_NOME ))
oBrowse:Add( "CODIGO",    "Repres", "9999")
oBrowse:Add( "NOME",      "Nome")
oBrowse:Add( "CIDA",      "Cida")
oBrowse:Add( "ESTADO",    "Esta")
oBrowse:Add( "CGC",       "Cgc", "99.999.999/9999-99")
oBrowse:Titulo   := "CONSULTA/ALTERACAO DE REPRESENTANTES"
oBrowse:PreDoGet := NIL
oBrowse:PosDoGet := NIL
oBrowse:PreDoDel := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Proc MudaDolar()
****************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()
Set Key -8 To

oMenu:Limpa()
Area("Taxas")
Taxas->(Order( TAXAS_DFIM ))
Taxas->(DbGoTop())
oBrowse:Add( "DATA",    "DFim")
oBrowse:Add( "COTACAO", "Cotacao")
oBrowse:Titulo   := "CONSULTA/ALTERACAO DE COTA€AO DE DOLAR"
oBrowse:PreDoGet := NIL
oBrowse:PosDoGet := NIL
oBrowse:Show()
oBrowse:Processa()
ResTela( cScreen )

Proc GrupoDbEdit()
******************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()
Set Key -8 To

oMenu:Limpa()
Area("Grupo")
Grupo->(Order( DOIS ))
Grupo->(DbGoTop())
oBrowse:Add( "CODIGO",             "CodGrupo")
oBrowse:Add( "DESCRICAO DO GRUPO", "DesGrupo")
oBrowse:Titulo   := "CONSULTA/ALTERACAO DE GRUPOS"
oBrowse:HotKey( F4, {|| oBrowse:DupReg("GRUPO", "CODGRUPO", GRUPO_CODGRUPO)})
oBrowse:PreDoGet := NIL
oBrowse:PosDoGet := {|| PosGrupo( oBrowse ) } // Rotina do Usuario apos Atualizar
oBrowse:Show()
oBrowse:Processa()
ResTela( cScreen )

Function PosGrupo( oBrowse )
****************************
LOCAL oCol := oBrowse:getColumn( oBrowse:colPos )
Grupo->Atualizado := Date()
Return( OK )

Proc FormaConsulta()
********************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()
Set Key -8 To

oMenu:Limpa()
Area("Forma")
Forma->(Order(FORMA_FORMA))
Forma->(DbGoTop())
oBrowse:Add( "CODIGO",            "Forma")
oBrowse:Add( "CONDICOES DE PGTO", "Condicoes")
oBrowse:Add( "DESCRICAO",         "Descricao")
oBrowse:Add( "COMISSAO",          "Comissao")
oBrowse:Add( "FINANCEIRO",        "Iof", "999.9999")
oBrowse:Titulo   := "CONSULTA/ALTERACAO DE FORMAS DE PAGAMENTO"
oBrowse:HotKey( F4, {|| oBrowse:DupReg("FORMA", "FORMA", FORMA_FORMA)})
oBrowse:PreDoGet := {|| PodeAlterar() }
oBrowse:PreDoDel := {|| PodeExcluir() }
oBrowse:Show()
oBrowse:Processa()
ResTela( cScreen )

Function CmDbedit()
**************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()
Set Key -8 To

oMenu:Limpa()
Area("Cm")
Cm->(Order(CM_FIM))
Cm->(DbGoBottom())
oBrowse:Add( "INICIO",     "inicio", PIC_DATA )
oBrowse:Add( "FIM",        "fim",    PIC_DATA )
oBrowse:Add( "INDICE",     "indice", '9999.9999')
oBrowse:Add( "OBSERVACAO", "obs",   '@!')
oBrowse:Titulo   := "CONSULTA/ALTERACAO DE INDICE DE CM"
oBrowse:HotKey( F4, {|| oBrowse:DupReg("CM", "INICIO", CM_INICIO)})
oBrowse:PreDoGet := {|| PodeAlterar() }
oBrowse:PreDoDel := {|| PodeExcluir() }
oBrowse:Show()
oBrowse:Processa()
ResTela( cScreen )
return( nil )

Proc MudaCep()
**************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()
Set Key -8 To

oMenu:Limpa()
Area("Cep")
Cep->(Order(UM ))
Cep->(DbGoTop())
oBrowse:Add( "CEP",      "Cep", '#####-###')
oBrowse:Add( "CIDADE",   "Cida", '@!')
oBrowse:Add( "BAIRRO",   "Bair", '@!')
oBrowse:Add( "UF",       "Esta", '@!')
oBrowse:Titulo   := "CONSULTA/ALTERACAO DE CEP's"
oBrowse:HotKey( F4, {|| oBrowse:DupReg("CEP", "CEP", UM )})
oBrowse:PreDoGet := {|| PodeAlterar() }
oBrowse:PreDoDel := {|| PodeExcluir() }
oBrowse:Show()
oBrowse:Processa()
ResTela( cScreen )

Proc MudaMargem()
*****************
LOCAL nTipo 		:= 1
LOCAL nChoice		:= 1
LOCAL nMargem		:= 0
LOCAL cCodigo		:= SpCodigo()
LOCAL aTipo 		:= {"Atacado", "Varejo"}
LOCAL aMenu 		:= {"Individual", "Por Grupo", "Por Fornecedor", "Geral"}

WHILE OK
	oMenu:Limpa()
	M_Title("ESCOLHA O TIPO")
	nTipo := FazMenu( 05, 08, aTipo, Cor())
	IF nTipo = 0
		Return
	EndIF
	M_Title("ESCOLHA A OPCAO DE ALTERACAO")
	nChoice := FazMenu( 07, 10, aMenu, Cor())
	IF nChoice = 0
		Return
	EndIF
	IF nChoice = 1
		MargemBrowse()
	ElseIf nChoice = 2
		cGrupo  := Space(03)
		nMargem := 0
		Grupo->(Order(GRUPO_CODGRUPO ))
		MaBox( 04, 10, 07, 31 )
		@ 05, 11 Say "Grupo..:" Get cGrupo  Pict "999"   Valid CodiGrupo( @cGrupo )
		@ 06, 11 Say "Margem.:" Get nMargem Pict "999.99"
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		Area("Lista")
		Lista->(Order( LISTA_CODGRUPO ))
		IF Lista->(!DbSeek( cGrupo ))
			Loop
		EndIF
		IF !SimOuNao()
			Loop
		EndIF
		Mabox( 16, 20, 18, 60 )
		cCodigo := Lista->Codigo
		While Lista->CodGrupo = cGrupo .AND. Rep_Ok()
			Write( 17, 21, " Ajustando Codigo " + cCodigo + " em LISTA   " )
			IF Lista->(TravaReg())
				IF nTipo = 1 // Atacado
					Lista->MarAta := nMargem
				ElseIF nTipo = 2 // Varejo
					Lista->MarVar := nMargem
				EndIF
				Lista->(Libera())
			EndIF
			Lista->(DbSkip(1))
			cCodigo := Lista->Codigo
		EndDo
		oMenu:Limpa()
		Alerta("Tarefa: Margem Atualizado.")

	ElseIf nChoice = 3
		cCodi   := Space(04)
		nMargem := 0
		MaBox( 04, 10, 07, 78 )
		@ 05, 11 Say "Fornecedor.:" Get cCodi Pict "9999" Valid Pagarrado( @cCodi, Row(), Col()+5 )
		@ 06, 11 Say "Margem.....:" Get nMargem Pict "999.99"
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		Area("Lista")
		Lista->(Order( LISTA_CODI ))
		IF Lista->(!DbSeek( cCodi ))
			Loop
		EndIF
		IF !SimOuNao()
			Loop
		EndIF
		Mabox( 16, 20, 18, 60 )
		cCodigo := Lista->Codigo
		While Lista->Codi = cCodi .AND. Rep_Ok()
			Write( 17, 21, " Ajustando Codigo " + cCodigo + " em LISTA   " )
			IF Lista->(TravaReg())
				IF nTipo = 1 // Atacado
					Lista->MarAta := nMargem
				ElseIF nTipo = 2 // Varejo
					Lista->MarVar := nMargem
				EndIF
				Lista->(Libera())
			EndIF
			Lista->(DbSkip(1))
			cCodigo := Lista->Codigo
		EndDo
		oMenu:Limpa()
		Alerta("Tarefa: Margem Atualizado.")

	ElseIf nChoice = 4
		nMargem := 0
		MaBox( 04, 10, 06, 31 )
		@ 05, 11 Say "Margem.:" Get nMargem Pict "999.99"
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		IF !SimOuNao()
			Loop
		EndIF
		Mabox( 16, 20, 18, 60 )
		Area("Lista")
		Lista->( Order( LISTA_CODIGO ))
		Lista->( DbGoTop())
		cCodigo := Lista->Codigo
		While Lista->(!Eof()) .AND. Rep_Ok()
			Write( 17, 21, " Ajustando Codigo " + cCodigo + " em LISTA   " )
			IF Lista->(TravaReg())
				IF nTipo = 1 // Atacado
					Lista->MarAta := nMargem
				ElseIF nTipo = 2 // Varejo
					Lista->MarVar := nMargem
				EndIF
				Lista->(Libera())
			EndIF
			Lista->(DbSkip(1))
			cCodigo := Lista->Codigo
		EndDo
		oMenu:Limpa()
		Alerta("Tarefa: Margem Atualizado.")
	EndIF
EndDo
ResTela( cScreen )
Return

Proc MargemBrowse()
*******************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()
Set Key -8 To

oMenu:Limpa()
Area("Lista")
Lista->(Order( DOIS ))
Lista->(DbGoTop())
oBrowse:Add( "CODIGO",      "Codigo")
oBrowse:Add( "DESCRICAO",   "Descricao")
oBrowse:Add( "MARGEM VAR",  "MarVar")
oBrowse:Add( "MARGEM ATA",  "MarAta")
oBrowse:Titulo   := "CONSULTA/ALTERACAO DE MARGEM DE VENDA"
oBrowse:PreDoGet := {|| HotMargem( oBrowse ) }
oBrowse:PosDoGet := NIL
oBrowse:Show()
oBrowse:Processa()
ResTela( cScreen )

Function HotMargem( oBrowse )
******************************
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )
LOCAL nMarVar := 0

IF oCol:Heading = "CODIGO" .OR. oCol:Heading = "DESCRICAO"
	ErrorBeep()
	Alerta("Erro: Use Alteracao de Produtos")
	Return( FALSO )
EndIF
Return( OK )

Proc SubGrupoDbedit()
*********************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()
Set Key -8 To

oMenu:Limpa()
Area("SubGrupo")
SubGrupo->(Order( SUBGRUPO_CODSGRUPO ))
SubGrupo->(DbGoTop())
oBrowse:Add( "CODIGO",      "CodSGrupo")
oBrowse:Add( "DESCRICAO",   "DessGrupo")
oBrowse:Titulo   := "CONSULTA/ALTERACAO DE SUBGRUPOS"
oBrowse:HotKey( F4, {|| oBrowse:DupReg("SUBGRUPO", "CODSGRUPO", SUBGRUPO_CODSGRUPO)})
oBrowse:PreDoGet := NIL
oBrowse:PosDoGet := {|| PosSubGrupo( oBrowse ) } // Rotina do Usuario apos Atualizar
oBrowse:Show()
oBrowse:Processa()
ResTela( cScreen )

Function PosSubGrupo( oBrowse )
*******************************
LOCAL oCol := oBrowse:getColumn( oBrowse:colPos )
SubGrupo->Atualizado := Date()
Return( OK )

Proc SetCentury()
*****************
IF oIni:ReadInteger("config", "seculo", 0 ) = 0
  Set Cent Off
Else
  Set Cent On
EndIF
Return

Proc TabPreco()
***************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
Area("Lista")
Pagar->(Order( PAGAR_CODI ))
Set Rela To Codi Into Pagar
Lista->(Order( LISTA_DESCRICAO ))
Lista->(DbGoTop())
oBrowse:Add( "DESCRICAO", "Descricao", "@!")
oBrowse:Add( "ATACADO",   "Atacado",   "@E 99999999.99")
oBrowse:Add( "VAREJO",    "Varejo",    "@E 99999999.99")
oBrowse:Add( "ESTOQUE",   "Quant",     "9999999.99")
oBrowse:Add( "VENDIDA",   "Vendida",   "9999999.99")
oBrowse:Add( "CODIGO",    "Codigo",    "999999")
oBrowse:Add( "ULT. ATU",  "Data",      "##/##/##")
oBrowse:Add( "LOCAL",     "Local",     "@!")
oBrowse:Add( "COD FABR",  "N_Original","@!")
oBrowse:Titulo   := "CONSULTA DE PRODUTOS"
oBrowse:HotKey( F4, {|| oBrowse:DupReg("LISTA", "CODIGO", LISTA_CODIGO)})
oBrowse:PreDoGet := {|| PreConLista( oBrowse, 3 ) }
oBrowse:PosDoGet := NIL
oBrowse:PreDoDel := {|| PodeExcluir() }
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
Lista->(DbClearRel())
Lista->(DbGoTop())
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Proc GravaBoleto()
******************
LOCAL cScreen := SaveScreen()
LOCAL cFile   := 'BOLETO.COB'

FChdir( oAmbiente:xBaseDoc )
Set Defa To ( oAmbiente:xBaseDoc )
IF File( cFile )
	ErrorBeep()
	IF !Conf("Erro: O Arquivo " + cFile + " ja existe. Regravar ?")
		ResTela( cScreen )
		FChdir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		Return
	EndIF
EndIF
ResTela( cScreen )
Ferase( cFile )
Handle := FCreate( cFile )
IF ( Ferror() != 0 )
	FClose(handle)
	Restela( cScreen )
	Alert("Erro de Criacao de BOLETO.COB")
	FChdir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	Return
EndIF
FWriteLine( Handle,"[configuracao]                      ; Configuracao da Impressora")
FWriteLine( Handle,"ImprimirCondensado=0                ; 0=Nao      1=Sim")
FWriteLine( Handle,"Imprimir12Cpi=1                     ; 0=Nao      1=Sim")
FWriteLine( Handle,"ImprimirNegrito=1                   ; 0=Nao      1=Sim")
FWriteLine( Handle,'EspacamentoVertical=1               ; 0=1/6"     1=1/8"')
FWriteLine( Handle,"TamanhoPagina=32                    ; Comprimento Vertical do Formulario.")
FWriteLine( Handle,"")
FWriteLine( Handle,"[cabecalho]                         ; Configuracao do Boleto")
FWriteLine( Handle,"LocalDePagamento=00,01              ; Linha,Coluna do Local do Pagamento")
FWriteLine( Handle,"Vencimento=00,68                    ; Linha,Coluna do Vencimento")
FWriteLine( Handle,"DataDeEmissao=05,01                 ; Linha,Coluna da Data de Emissao")
FWriteLine( Handle,"NrDocumento=05,12                   ; Linha,Coluna da N§ do Documento")
FWriteLine( Handle,"Especie=-1,-1                       ; Linha,Coluna da Especie de Documento")
FWriteLine( Handle,"Moeda=-1,-1                         ; Linha,Coluna da Especie de Moeda")
FWriteLine( Handle,"ValorDocumento=07,66                ; Linha,Coluna do Valor do Documento")
FWriteLine( Handle,"Instrucoes=10,02                    ; Linha,Coluna das Instrucoes")
FWriteLine( Handle,"Sacado=19,06                        ; Linha,Coluna do Sacado")
FWriteLine( Handle,"")
FWriteLine( Handle,"              Obs. Para nao imprimir uma opcao digite a Linha, Coluna")
FWriteLine( Handle,"                   com valores negativos. Ex.: Especie=-1,-1")
Alert("Informa: Arquivo BOLETO.COB criado.")
FClose(handle)
ResTela( cScreen )
FChdir( oAmbiente:xBaseDados )
Set Defa To ( oAmbiente:xBaseDados )
Return

Proc GravaNota()
****************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL cFile   := "NOTA.NFF"

FChdir( oAmbiente:xBaseDoc )
Set Defa To ( oAmbiente:xBaseDoc )
IF File( cFile )
	ErrorBeep()
	IF !Conf("Erro: O Arquivo " + cFile + " ja existe. Regravar ?")
		FChdir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return
	EndIF
EndIF
ResTela( cScreen )
Ferase( cFile )
Handle := FCreate( cFile )
IF ( Ferror() != 0 )
	Fclose(handle)
	Restela( cScreen )
	Alert("Erro de Criacao de " + cFile )
	FChdir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	Return
EndIF
FWriteLine( Handle,"[configuracao]                                      ; Configuracao da Impressora")
FWriteLine( Handle,"ImprimirCondensado=0                                ; 0=Nao      1=Sim")
FWriteLine( Handle,"Imprimir12Cpi=1                                     ; 0=Nao      1=Sim")
FWriteLine( Handle,"ImprimirNegrito=0                                   ; 0=Nao      1=Sim")
FWriteLine( Handle,'EspacamentoVertical=1                               ; 0=1/6"     1=1/8"')
FWriteLine( Handle,"")
FWriteLine( Handle,"[cabecalho]                                         ; Configuracao do Cabecalho da Nota")
FWriteLine( Handle,"Saida=5,68                                          ; Ln,Col da Saida")
FWriteLine( Handle,"NaturezaDeOperacao=12,3                             ; Ln,Col da Natureza de Operacao")
FWriteLine( Handle,"Cfop=12,26                                          ; Ln,Col do CFOP")
FWriteLine( Handle,"InscricaoEstadualDeSubstituicaoTributaria=-1,-1     ; Ln,Col da Inscricao do Substituto Tributario")
FWriteLine( Handle,"")
FWriteLine( Handle,"[destinatario_remetente]                            ; Configuracao do DestinaLinha/Remetente")
FWriteLine( Handle,"NomeRazaoSocial=17,3                                ; Ln,Col do Nome/Razao Social")
FWriteLine( Handle,"Cgc_Cpf=17,63                                       ; Ln,Col do CGGC/CPF")
FWriteLine( Handle,"DataDeEmissao=17,88                                 ; Ln,Col da Data De Emissao da Nota")
FWriteLine( Handle,"Endereco=20,3                                       ; Ln,Col do Endereco")
FWriteLine( Handle,"BairroDistrito=20,51                                ; Ln,Col do Bairro")
FWriteLine( Handle,"Cep=20,73                                           ; Ln,Col do Cep")
FWriteLine( Handle,"DataSaidaEntrada=20,88                              ; Ln,Col da Data de Saida/Entrada")
FWriteLine( Handle,"Municipio=23,3                                      ; Ln,Col do Municipio")
FWriteLine( Handle,"FoneFax=-1,-1                                       ; Ln,Col do Telefone/Fax")
FWriteLine( Handle,"Uf=23,57                                            ; Ln,Col do Estado")
FWriteLine( Handle,"InscricaoEstadual=23,65                             ; Ln,Col da Inscricao Estadual")
FWriteLine( Handle,"HoraSaida=-1,-1                                     ; Ln,Col da Hora de Saida")
FWriteLine( Handle,"")
FWriteLine( Handle,"[dados_do_produto]                                  ; Configuracao dos Dados do Produto")
FWriteLine( Handle,"QuantidadeDeLinhas=31,1                             ; Quantidade de Linhas dos Produtos")
FWriteLine( Handle,"CodigoOriginal=-1,-1                                ; Ln,Col do Codigo Original")
FWriteLine( Handle,"CodigoProduto=29,03                                 ; Ln,Col do Codigo do Produto")
FWriteLine( Handle,"DescricaoDosProdutos=29,12                          ; Ln,Col da Descricao do Produto")
FWriteLine( Handle,"ClassificacaoFiscal=29,54                           ; Ln,Col da Classificacao Fiscal")
FWriteLine( Handle,"SituacaoTributaria=29,58                            ; Ln,Col da Situacao Tributaria")
FWriteLine( Handle,"Unidade=29,61                                       ; Ln,Col das Instrucoes")
FWriteLine( Handle,"Quantidade=29,64                                    ; Ln,Col da Unidade")
FWriteLine( Handle,"ValorUnitario=29,69                                 ; Ln,Col do Valor Unitario")
FWriteLine( Handle,"ValorTotal=29,82                                    ; Ln,Col do Valor Total")
FWriteLine( Handle,"AliquotaIcms=29,99                                  ; Ln,Col da Aliquota do Icms")
FWriteLine( Handle,"")
FWriteLine( Handle,"[calculo_do_imposto]                                ; Configuracao do Calculo do Imposto")
FWriteLine( Handle,"BaseDeCalculoDoIcms=63,03                           ; Ln,Col da Base de Calculo do Icms")
FWriteLine( Handle,"ValorDoIcms=63,21                                   ; Ln,Col do Valor do Icms")
FWriteLine( Handle,"BaseDeCalculoSubs=-1,-1                             ; Ln,Col do Valor do Icms")
FWriteLine( Handle,"ValorIcmsSubs=-1,-1                                 ; Ln,Col do Valor do Icms")
FWriteLine( Handle,"ValorTotalDosProdutos=63,79                         ; Ln,Col do Valor Total dos Produtos")
FWriteLine( Handle,"ValorTotalDaNota=66,79                              ; Ln,Col do Valor Total da Nota")
FWriteLine( Handle,"")
FWriteLine( Handle,"[transportador_volumes_transportados]               ; Configuracao do Transportador")
FWriteLine( Handle,"NomeRazaoSocial=70,03                               ; Ln,Col do Nome do Transportador")
FWriteLine( Handle,"FretePorConta=70,10                                 ; Ln,Col do Frete por Conta")
FWriteLine( Handle,"PlacaDoVeiculo=70,20                                ; Ln,Col da Placa do Veiculo")
FWriteLine( Handle,"Uf=70,30                                            ; Ln,Col do Estado do Transportador")
FWriteLine( Handle,"Cgc_Cpf=70,40                                       ; Ln,Col do Cgc/CPf do Transportador")
FWriteLine( Handle,"Endereco=73,10                                      ; Ln,Col do Endereco do Transportador")
FWriteLine( Handle,"Municipio=73,20                                     ; Ln,Col do Municipio")
FWriteLine( Handle,"UfCida=73,30                                        ; Ln,Col do Estado")
FWriteLine( Handle,"InscricaoEstadual=73,40                             ; Ln,Col da Inscricao Estadual")
FWriteLine( Handle,"Quantidade=76,10                                    ; Ln,Col da Quantidade")
FWriteLine( Handle,"Especie=76,20                                       ; Ln,Col da Especie")
FWriteLine( Handle,"Marca=76,30                                         ; Ln,Col da Marca")
FWriteLine( Handle,"Numero=76,40                                        ; Ln,Col do Numero")
FWriteLine( Handle,"PesoBruto=76,50                                     ; Ln,Col do Peso Bruto")
FWriteLine( Handle,"PesoLiquido=76,60                                   ; Ln,Col do Peso Liquido")
FWriteLine( Handle,"")
FWriteLine( Handle,"[dados_adicionais]                                  ; Configuracao do Dados Adicionais")
FWriteLine( Handle,"InformacoesComplementares=-1,-1                     ; Ln,Col da Informacao Complementar")
FWriteLine( Handle,"NumeroNotaFiscalCabecalho=-1,-1                     ; Ln,Col do Numero da Nota Fiscal")
FWriteLine( Handle,"NumeroNotaFiscalRodape=-1,-1                        ; Ln,Col do Numero da Nota Fiscal")
FWriteLine( Handle,"InscricaoMunicipal=-1,-1                            ;")
FWriteLine( Handle,"ValorDoIss=-1,-1                                    ;")
FWriteLine( Handle,"ValorTotalDosServicos=-1,-1                         ;")
FWriteLine( Handle,"")
FWriteLine( Handle,"[observacoes]                                       ; observacoes")
FWriteLine( Handle,"Linha1=-1,-1                                        ; Linha1")
FWriteLine( Handle,"Linha2=-1,-1                                        ; Linha2")
FWriteLine( Handle,"Linha3=-1,-1                                        ; Linha3")
FWriteLine( Handle,"; Obs. Para nao imprimir uma opcao digite a Linha, Coluna")
FWriteLine( Handle,";      com valores negativos. Ex.: Especie=-1,-1")
Alert("Informa: Arquivo criado.")
FClose(handle)
ResTela( cScreen )
FChdir( oAmbiente:xBaseDados )
Set Defa To ( oAmbiente:xBaseDados )
Return

Proc GravaDuplicata()
*********************
LOCAL cScreen := SaveScreen()
LOCAL cFile   := 'DUP.DUP'

FChdir( oAmbiente:xBaseDoc )
Set Defa To ( oAmbiente:xBaseDoc )
IF File( cFile )
	ErrorBeep()
	IF !Conf("Erro: O Arquivo " + cFile + " ja existe. Regravar ?")
		FChdir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return
	EndIF
EndIF
ResTela( cScreen )
Ferase( cFile )
Handle := FCreate( cFile )
IF ( Ferror() != 0 )
	Fclose(handle)
	FChdir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	Restela( cScreen )
	Alert("Erro de Criacao de DUP.DUP")
	Return
EndIF
FWriteLine( Handle,"[configuracao]                      ; Configuracao da Impressora")
FWriteLine( Handle,"ImprimirCondensado=0                ; 0=Nao      1=Sim")
FWriteLine( Handle,"Imprimir12Cpi=1                     ; 0=Nao      1=Sim")
FWriteLine( Handle,"ImprimirNegrito=1                   ; 0=Nao      1=Sim")
FWriteLine( Handle,'EspacamentoVertical=0               ; 0=1/6"     1=1/8"')
FWriteLine( Handle,"TamanhoPagina=36                    ; Comprimento Vertical do Formulario.")
FWriteLine( Handle,"")

FWriteLine( Handle,"[empresa]                           ; Configuracao da Empresa")
FWriteLine( Handle,"RazaoSocial=-1,-1                   ; Linha,Coluna da Razao Social")
FWriteLine( Handle,"Endereco=-1,-1                      ; Linha,Coluna do Endereco")
FWriteLine( Handle,"Cgc=-1,-1                           ; Linha,Coluna do CGC")
FWriteLine( Handle,"InscricaoEstadual=-1,-1             ; Linha,Coluna da Inscricao")

FWriteLine( Handle,"")
FWriteLine( Handle,"[cabecalho]                         ; Configuracao da Duplicata")
FWriteLine( Handle,"DataDeEmissao=04,71                 ; Linha,Coluna da Data de Emissao")
FWriteLine( Handle,"ValorDaFatura=08,04                 ; Linha,Coluna do Valor da Fatura")
FWriteLine( Handle,"NumeroDaFatura=08,24                ; Linha,Coluna do Numero da Fatura")
FWriteLine( Handle,"ValorDaDuplicata=08,36              ; Linha,Coluna do Valor da Duplicata")
FWriteLine( Handle,"NumeroDaDuplicata=08,56             ; Linha,Coluna do Numero da Duplicata")
FWriteLine( Handle,"Vencimento=08,68                    ; Linha,Coluna da Vencimento da Duplicata")
FWriteLine( Handle,"JurosPorDiaAtraso=11,31             ; Linha,Coluna do Juros Por Dia Atraso")
FWriteLine( Handle,"CodigoDoVendedor=12,64              ; Linha,Coluna do Codigo do Vendedor")
FWriteLine( Handle,"NomeDoSacado=14,27                  ; Linha,Coluna do Nome do Sacado")
FWriteLine( Handle,"CodigoDoSacado=14,89                ; Linha,Coluna do Codigo do Sacado")
FWriteLine( Handle,"EnderecoDoSacao=15,27               ; Linha,Coluna do Endereco do Sacado")
FWriteLine( Handle,"BairroDoSacado=15,79                ; Linha,Coluna do Bairro do Sacado")
FWriteLine( Handle,"CidadeDoSacado=16,27                ; Linha,Coluna da Cidade do Sacado")
FWriteLine( Handle,"CepDoSacado=16,69                   ; Linha,Coluna da Cidade do Sacado")
FWriteLine( Handle,"EstadoDoSacado=16,89                ; Linha,Coluna do Cep do Sacado")
FWriteLine( Handle,"PracaDePagamento=17,27              ; Linha,Coluna do Estado do Sacado")
FWriteLine( Handle,"CepPracadePagamento=17,69           ; Linha,Coluna da Praca de Pagamento")
FWriteLine( Handle,"EstadoPracaDePagamento=17,89        ; LInha,Coluna do Cep da Praca de Pgto")
FWriteLine( Handle,"Cgc_CpfDoSacado=18,27               ; LInha,Coluna do Estado da Praca de Pgto")
FWriteLine( Handle,"Insc_RgDoSacado=18,69               ; Linha,Coluna do CGC/CPF do Sacado")
FWriteLine( Handle,"ValorPorExtenso=20,29               ; Linha,Coluna da Inscricao/Rg do Sacado")
FWriteLine( Handle,"TamanhoValorPorExtenso=66,1         ; Linha,Coluna do Valor Por Extenso")
FWriteLine( Handle,"Observacoes=-1,-1                   ; Linha,Coluna de banco")
FWriteLine( Handle,"")
FWriteLine( Handle,"              Obs. Para nao imprimir uma opcao digite a Linha, Coluna")
FWriteLine( Handle,"                   com valores negativos. Ex.: Especie=-1,-1")
Alert("Informa: Arquivo DUP.DUP criado.")
FClose(handle)
FChdir( oAmbiente:xBaseDados )
Set Defa To ( oAmbiente:xBaseDados )
ResTela( cScreen )
Return

Function LerBoleto( xArquivo, lRetorno )
****************************************
LOCAL cScreen		:= SaveScreen()
LOCAL nErro 		:= 0
LOCAL aBoleto		:= {}
LOCAL cFiles		:= "*.COB"
LOCAL cString		:= ""
LOCAL Handle

FChdir( oAmbiente:xBaseDoc )
Set Defa To ( oAmbiente:xBaseDoc )
IF xArquivo = NIL
	IF !File( cFiles )
		oMenu:Limpa()
		ErrorBeep()
		Alert("Erro: Arquivos de Boletos nao disponiveis.;" + ;
				"Verifique os arquivos com extensao .COB.")
		FChdir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aBoleto )
	EndIF
	oMenu:Limpa()
	M_Title("ESCOLHA O ARQUIVO DE CONFIGURACAO DE BOLETO")
	xArquivo := Mx_PopFile( 05, 10, 20, 74, cFiles, Cor() )
EndIF
IF Empty( xArquivo )
	FChdir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ErrorBeep()
	ResTela( cScreen )
	Return( aBoleto )
EndIF
Handle  := Fopen( xArquivo )
IF ( Ferror() != 0 )
	ErroConfiguracaoArquivo( Handle, "Abertura do Arquivo", xArquivo )
	FChdir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen )
	Return( aBoleto )
EndIF
cString := "[configuracao]"
nErro := FLocate( Handle, cString )
IF nErro < 0
	ErroConfiguracaoArquivo( Handle, cString, xArquivo )
	FChdir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen )
	Return( aBoleto )
EndIF
FAdvance( Handle )
For nX := 1 To 5
	cLinha  := AllTrim( FReadLine( Handle ))
	cLinha1 := cLinha
	nPosDoIgual := At( "=", cLinha )
	IF nPosDoIgual = 0 // Nao Localizado
		ErroConfiguracaoArquivo( Handle, cLinha, xArquivo )
		FChdir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aBoleto )
	EndIF
	cLinha  := AllTrim( SubStr( cLinha,  nPosDoIgual+1, 3 ))
	IF Empty( cLinha )
		cLinha = "-1"
	EndIF
	Aadd( aBoleto, { Val(cLinha),,  })
Next
cString := "[cabecalho]"
nErro := FLocate( Handle, cString )
IF nErro < 0
	ErroConfiguracaoArquivo( Handle, cLinha, xArquivo )
	FChdir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen )
	Return( aBoleto )
EndIF
FAdvance( Handle )
For nX := 1 To 9
	cLinha  := AllTrim( FReadLine( Handle ))
	cLinha1 := cLinha
	nPosDoIgual := At( "=", cLinha )
	IF nPosDoIgual = 0 // Nao Localizado
		ErroConfiguracaoArquivo( Handle, cLinha, xArquivo )
		FChdir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aBoleto )
	EndIF
	nPosDaVirgula := At( ",", cLinha )
	IF nPosDaVirgula = 0 // Nao Localizado
		ErroConfiguracaoArquivo( Handle, cLinha, xArquivo )
		FChdir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aBoleto )
	EndIF
	cLinha  := AllTrim( SubStr( cLinha,  nPosDoIgual+1, (nPosDaVirgual-nPosDoIgual)))
	cColuna := AllTrim( SubStr( cLinha1, nPosDaVirgula+1, 3 ))
	IF Empty( cLinha )
		cLinha = "-1"
	EndIF
	IF Empty( cColuna )
		cColunha = "-1"
	EndIF
	Aadd( aBoleto, { Val(cLinha), Val(cColuna) })
Next
FClose( Handle )
FChdir( oAmbiente:xBaseDados )
Set Defa To ( oAmbiente:xBaseDados )
ResTela( cScreen )
lRetorno := OK
Return( aBoleto )

Function LerDuplicata( xArquivo, lRetorno )
*******************************************
LOCAL cScreen		:= SaveScreen()
LOCAL nErro 		:= 0
LOCAL aDuplicata	:= {}
LOCAL cFiles		:= '*.DUP'
LOCAL cString		:= ''
LOCAL Handle

FChDir( oAmbiente:xBaseDoc )
Set Defa To ( oAmbiente:xBaseDoc )
IF xArquivo = NIL .OR. !File( xArquivo )
	IF !File( cFiles )
		oMenu:Limpa()
		ErrorBeep()
		Alert("Erro: Arquivos de Duplicatas nao disponiveis.;" + ;
				"Verifique os arquivos com extensao .DUP.")
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aDuplicata )
	EndIF
	oMenu:Limpa()
	M_Title("ESCOLHA O ARQUIVO DE CONFIGURACAO DE DUPLICATA")
	//xArquivo := Mx_PopFile( 05, 10, 20, 74, cFiles, Cor() )
EndIF
IF Empty( xArquivo )
	ErrorBeep()
	FChDir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen )
	Return( aDuplicata )
EndIF
Handle  := Fopen( xArquivo )
IF ( Ferror() != 0 )
	ErroConfiguracaoArquivo( Handle, "Abertura do Arquivo", xArquivo )
	FChDir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen )
	Return( aDuplicata )
EndIF
cString := "[configuracao]"
nErro := FLocate( Handle, cString )
IF nErro < 0
	ErroConfiguracaoArquivo( Handle, cString, xArquivo )
	FChDir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen )
	Return( aDuplicata )
EndIF
FAdvance( Handle )
For nX := 1 To 5
	cLinha  := AllTrim( FReadLine( Handle ))
	cLinha1 := cLinha
	nPosDoIgual := At( "=", cLinha )
	IF nPosDoIgual = 0 // Nao Localizado
		ErroConfiguracaoArquivo( Handle, cLinha, xArquivo )
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aDuplicata )
	EndIF
	cLinha  := AllTrim( SubStr( cLinha,  nPosDoIgual+1, 3 ))
	IF Empty( cLinha )
		cLinha = "-1"
	EndIF
	Aadd( aDuplicata, { Val(cLinha),,  })
Next
cString := "[empresa]"
nErro := FLocate( Handle, cString )
IF nErro < 0
	ErroConfiguracaoArquivo( Handle, cLinha, xArquivo )
	FChDir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen )
	Return( aDuplicata )
EndIF
FAdvance( Handle )
For nX := 1 To 4
	cLinha  := AllTrim( FReadLine( Handle ))
	cLinha1 := cLinha
	nPosDoIgual := At( "=", cLinha )
	IF nPosDoIgual = 0 // Nao Localizado
		ErroConfiguracaoArquivo( Handle, cLinha, xArquivo )
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aDuplicata )
	EndIF
	nPosDaVirgula := At( ",", cLinha )
	IF nPosDaVirgula = 0 // Nao Localizado
		ErroConfiguracaoArquivo( Handle, cLinha, xArquivo )
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aDuplicata )
	EndIF
	cLinha  := AllTrim( SubStr( cLinha,  nPosDoIgual+1, (nPosDaVirgual-nPosDoIgual)))
	cColuna := AllTrim( SubStr( cLinha1, nPosDaVirgula+1, 3 ))
	IF Empty( cLinha )
		cLinha = "-1"
	EndIF
	IF Empty( cColuna )
		cColunha = "-1"
	EndIF
	Aadd( aDuplicata, { Val(cLinha), Val(cColuna) })
Next

cString := "[cabecalho]"
nErro := FLocate( Handle, cString )
IF nErro < 0
	ErroConfiguracaoArquivo( Handle, cLinha, xArquivo )
	FChDir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen )
	Return( aDuplicata )
EndIF
FAdvance( Handle )
For nX := 1 To 23
	cLinha  := AllTrim( FReadLine( Handle ))
	cLinha1 := cLinha
	nPosDoIgual := At( "=", cLinha )
	IF nPosDoIgual = 0 // Nao Localizado
		ErroConfiguracaoArquivo( Handle, cLinha, xArquivo )
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aDuplicata )
	EndIF
	nPosDaVirgula := At( ",", cLinha )
	IF nPosDaVirgula = 0 // Nao Localizado
		ErroConfiguracaoArquivo( Handle, cLinha, xArquivo )
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aDuplicata )
	EndIF
	cLinha  := AllTrim( SubStr( cLinha,  nPosDoIgual+1, (nPosDaVirgual-nPosDoIgual)))
	cColuna := AllTrim( SubStr( cLinha1, nPosDaVirgula+1, 3 ))
	IF Empty( cLinha )
		cLinha = "-1"
	EndIF
	IF Empty( cColuna )
		cColunha = "-1"
	EndIF
	Aadd( aDuplicata, { Val(cLinha), Val(cColuna) })
Next
FClose( Handle )
ResTela( cScreen )
lRetorno := OK
FChDir( oAmbiente:xBaseDados )
Set Defa To ( oAmbiente:xBaseDados )
Return( aDuplicata )

Proc ErroConfiguracaoArquivo( Handle, cLocalDoErro, xArquivo )
***********************************************************
ErrorBeep()
FClose( Handle )
Alert( "Erro no Arquivo " + AllTrim( xArquivo ) + ".;;" + cLocalDoErro )
Return

Function LerNotaFiscal( xArqNota, lRetorno )
********************************************
LOCAL cScreen		:= SaveScreen()
LOCAL nErro 		:= 0
LOCAL aNotaConfig := {}
LOCAL cFiles		:= "*.NFF"
LOCAL cString		:= ""
LOCAL Handle

FChDir( oAmbiente:xBaseDoc )
Set Defa To ( oAmbiente:xBaseDoc )
IF xArqNota = NIL .OR. !File( xArqNota ) .OR. Empty( xArqNota )
	IF !File( cFiles )
		oMenu:Limpa()
		ErrorBeep()
		Alert("Erro: Arquivos de Notas nao disponiveis.;" + ;
				"Verifique os arquivos com extensao .NFF.")
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aNotaConfig )
	EndIF
	SetKey( F11,		{|| GravaNota() })
	SetKey( F12,		{|| Edicao( OK, "*.NFF")})
	oMenu:Limpa()
	M_Title("ESCOLHA O ARQUIVO DE NOTA³F11=CRIAR³F12=ALTERAR")
	//xArqNota := Mx_PopFile( 05, 10, 20, 74, cFiles, Cor() )
EndIF
Handle  := Fopen( xArqNota )
IF ( Ferror() != 0 )
	ErroConfiguracaoArquivo( Handle, "Abertura do Arquivo", xArqNota )
	FChDir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen )
	Return( aNotaConfig )
EndIF

cString := "[configuracao]"
nErro := FLocate( Handle, cString )
IF nErro < 0
	ErroConfiguracaoArquivo( Handle, cString, xArqNota )
	FChDir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen )
	Return( aNotaConfig )
EndIF
FAdvance( Handle )
For nX := 1 To 4
	cLinha  := AllTrim( FReadLine( Handle ))
	cLinha1 := cLinha
	nPosDoIgual := At( "=", cLinha )
	IF nPosDoIgual = 0 // Nao Localizado
		ErroConfiguracaoArquivo( Handle, cLinha, xArqNota )
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aNotaConfig )
	EndIF
	cLinha  := AllTrim( SubStr( cLinha,  nPosDoIgual+1, 3 ))
	IF Empty( cLinha )
		cLinha = "-1"
	EndIF
	Aadd( aNotaConfig, { Val(cLinha),,	})
Next

cString := "[cabecalho]"
nErro := FLocate( Handle, cString )
IF nErro < 0
	ErroConfiguracaoArquivo( Handle, cLinha, xArqNota )
	FChDir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen )
	Return( aNotaConfig )
EndIF
FAdvance( Handle )
For nX := 1 To 4
	cLinha  := AllTrim( FReadLine( Handle ))
	cLinha1 := cLinha
	nPosDoIgual := At( "=", cLinha )
	IF nPosDoIgual = 0 // Nao Localizado
		ErroConfiguracaoArquivo( Handle, cLinha, xArqNota )
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aNotaConfig )
	EndIF
	nPosDaVirgula := At( ",", cLinha )
	IF nPosDaVirgula = 0 // Nao Localizado
		ErroConfiguracaoArquivo( Handle, cLinha, xArqNota )
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aNotaConfig )
	EndIF
	cLinha  := AllTrim( SubStr( cLinha,  nPosDoIgual+1, (nPosDaVirgual-nPosDoIgual)))
	cColuna := AllTrim( SubStr( cLinha1, nPosDaVirgula+1, 3 ))
	IF Empty( cLinha )
		cLinha = "-1"
	EndIF
	IF Empty( cColuna )
		cColunha = "-1"
	EndIF
	Aadd( aNotaConfig, { Val(cLinha), Val(cColuna) })
Next

cString := "[destinatario_remetente]"
nErro := FLocate( Handle, cString )
IF nErro < 0
	ErroConfiguracaoArquivo( Handle, cLinha, xArqNota )
	FChDir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen )
	Return( aNotaConfig )
EndIF
FAdvance( Handle )
For nX := 1 To 12
	cLinha  := AllTrim( FReadLine( Handle ))
	cLinha1 := cLinha
	nPosDoIgual := At( "=", cLinha )
	IF nPosDoIgual = 0 // Nao Localizado
		ErroConfiguracaoArquivo( Handle, cLinha, xArqNota )
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aNotaConfig )
	EndIF
	nPosDaVirgula := At( ",", cLinha )
	IF nPosDaVirgula = 0 // Nao Localizado
		ErroConfiguracaoArquivo( Handle, cLinha, xArqNota )
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aNotaConfig )
	EndIF
	cLinha  := AllTrim( SubStr( cLinha,  nPosDoIgual+1, (nPosDaVirgual-nPosDoIgual)))
	cColuna := AllTrim( SubStr( cLinha1, nPosDaVirgula+1, 3 ))
	IF Empty( cLinha )
		cLinha = "-1"
	EndIF
	IF Empty( cColuna )
		cColunha = "-1"
	EndIF
	Aadd( aNotaConfig, { Val(cLinha), Val(cColuna) })
Next
cString := "[dados_do_produto]"
nErro := FLocate( Handle, cString )
IF nErro < 0
	ErroConfiguracaoArquivo( Handle, cLinha, xArqNota )
	FChDir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen )
	Return( aNotaConfig )
EndIF
FAdvance( Handle )
For nX := 1 To 11
	cLinha  := AllTrim( FReadLine( Handle ))
	cLinha1 := cLinha
	nPosDoIgual := At( "=", cLinha )
	IF nPosDoIgual = 0 // Nao Localizado
		ErroConfiguracaoArquivo( Handle, cLinha, xArqNota )
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aNotaConfig )
	EndIF
	nPosDaVirgula := At( ",", cLinha )
	IF nPosDaVirgula = 0 // Nao Localizado
		ErroConfiguracaoArquivo( Handle, cLinha, xArqNota )
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aNotaConfig )
	EndIF
	cLinha  := AllTrim( SubStr( cLinha,  nPosDoIgual+1, (nPosDaVirgual-nPosDoIgual)))
	cColuna := AllTrim( SubStr( cLinha1, nPosDaVirgula+1, 3 ))
	IF Empty( cLinha )
		cLinha = "-1"
	EndIF
	IF Empty( cColuna )
		cColunha = "-1"
	EndIF
	Aadd( aNotaConfig, { Val(cLinha), Val(cColuna) })
Next
cString := "[calculo_do_imposto]"
nErro := FLocate( Handle, cString )
IF nErro < 0
	ErroConfiguracaoArquivo( Handle, cLinha, xArqNota )
	FChDir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen )
	Return( aNotaConfig )
EndIF
FAdvance( Handle )
For nX := 1 To 6
	cLinha  := AllTrim( FReadLine( Handle ))
	cLinha1 := cLinha
	nPosDoIgual := At( "=", cLinha )
	IF nPosDoIgual = 0 // Nao Localizado
		ErroConfiguracaoArquivo( Handle, cLinha, xArqNota )
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aNotaConfig )
	EndIF
	nPosDaVirgula := At( ",", cLinha )
	IF nPosDaVirgula = 0 // Nao Localizado
		ErroConfiguracaoArquivo( Handle, cLinha, xArqNota )
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aNotaConfig )
	EndIF
	cLinha  := AllTrim( SubStr( cLinha,  nPosDoIgual+1, (nPosDaVirgual-nPosDoIgual)))
	cColuna := AllTrim( SubStr( cLinha1, nPosDaVirgula+1, 3 ))
	IF Empty( cLinha )
		cLinha = "-1"
	EndIF
	IF Empty( cColuna )
		cColunha = "-1"
	EndIF
	Aadd( aNotaConfig, { Val(cLinha), Val(cColuna) })
Next
cString := "[transportador_volumes_transportados]"
nErro := FLocate( Handle, cString )
IF nErro < 0
	ErroConfiguracaoArquivo( Handle, cLinha, xArqNota )
	FChDir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen )
	Return( aNotaConfig )
EndIF
FAdvance( Handle )
For nX := 1 To 15
	cLinha  := AllTrim( FReadLine( Handle ))
	cLinha1 := cLinha
	nPosDoIgual := At( "=", cLinha )
	IF nPosDoIgual = 0 // Nao Localizado
		ErroConfiguracaoArquivo( Handle, cLinha, xArqNota )
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aNotaConfig )
	EndIF
	nPosDaVirgula := At( ",", cLinha )
	IF nPosDaVirgula = 0 // Nao Localizado
		ErroConfiguracaoArquivo( Handle, cLinha, xArqNota )
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aNotaConfig )
	EndIF
	cLinha  := AllTrim( SubStr( cLinha,  nPosDoIgual+1, (nPosDaVirgual-nPosDoIgual)))
	cColuna := AllTrim( SubStr( cLinha1, nPosDaVirgula+1, 3 ))
	IF Empty( cLinha )
		cLinha = "-1"
	EndIF
	IF Empty( cColuna )
		cColunha = "-1"
	EndIF
	Aadd( aNotaConfig, { Val(cLinha), Val(cColuna) })
Next
cString := "[dados_adicionais]"
nErro := FLocate( Handle, cString )
IF nErro < 0
	ErroConfiguracaoArquivo( Handle, cLinha, xArqNota )
	FChDir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen )
	Return( aNotaConfig )
EndIF
FAdvance( Handle )
For nX := 1 To 6
	cLinha  := AllTrim( FReadLine( Handle ))
	cLinha1 := cLinha
	nPosDoIgual := At( "=", cLinha )
	IF nPosDoIgual = 0 // Nao Localizado
		ErroConfiguracaoArquivo( Handle, cLinha, xArqNota )
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aNotaConfig )
	EndIF
	nPosDaVirgula := At( ",", cLinha )
	IF nPosDaVirgula = 0 // Nao Localizado
		ErroConfiguracaoArquivo( Handle, cLinha, xArqNota )
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aNotaConfig )
	EndIF
	cLinha  := AllTrim( SubStr( cLinha,  nPosDoIgual+1, (nPosDaVirgual-nPosDoIgual)))
	cColuna := AllTrim( SubStr( cLinha1, nPosDaVirgula+1, 3 ))
	IF Empty( cLinha )
		cLinha = "-1"
	EndIF
	IF Empty( cColuna )
		cColunha = "-1"
	EndIF
	Aadd( aNotaConfig, { Val(cLinha), Val(cColuna) })
Next
cString := "[observacoes]"
nErro := FLocate( Handle, cString )
IF nErro < 0
	ErroConfiguracaoArquivo( Handle, cLinha, xArqNota )
	FChDir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen )
	Return( aNotaConfig )
EndIF
FAdvance( Handle )
For nX := 1 To 3
	cLinha  := AllTrim( FReadLine( Handle ))
	cLinha1 := cLinha
	nPosDoIgual := At( "=", cLinha )
	IF nPosDoIgual = 0 // Nao Localizado
		ErroConfiguracaoArquivo( Handle, cLinha, xArqNota )
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aNotaConfig )
	EndIF
	nPosDaVirgula := At( ",", cLinha )
	IF nPosDaVirgula = 0 // Nao Localizado
		ErroConfiguracaoArquivo( Handle, cLinha, xArqNota )
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aNotaConfig )
	EndIF
	cLinha  := AllTrim( SubStr( cLinha,  nPosDoIgual+1, (nPosDaVirgual-nPosDoIgual)))
	cColuna := AllTrim( SubStr( cLinha1, nPosDaVirgula+1, 3 ))
	IF Empty( cLinha )
		cLinha = "-1"
	EndIF
	IF Empty( cColuna )
		cColunha = "-1"
	EndIF
	Aadd( aNotaConfig, { Val(cLinha), Val(cColuna) })
Next
FClose( Handle )
FChDir( oAmbiente:xBaseDados )
Set Defa To ( oAmbiente:xBaseDados )
ResTela( cScreen )
lRetorno := OK
Return( aNotaConfig )

Function LerEtiqueta( cArquivo )
********************************
LOCAL cScreen := SaveScreen()
LOCAL nErro   := 0
LOCAL aConfig := {}
LOCAL cFiles  := "*.ETI"
LOCAL Handle
LOCAL oEtiqueta
LOCAL nCampos
LOCAL nTamanho

FChDir( oAmbiente:xBaseDoc )
Set Defa To ( oAmbiente:xBaseDoc )
IF cArquivo = NIL
	IF !File( cFiles )
		oMenu:Limpa()
		ErrorBeep()
		Alert("Erro: Arquivos de etiquetas nao disponiveis.;" + ;
				"Verifique os arquivos com extensao .ETI.")
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aConfig )
	EndIF
	oMenu:Limpa()
	M_Title("ESCOLHA O ARQUIVO DE CONFIGURACAO DE ETIQUETA")
	cArquivo := Mx_PopFile( 05, 10, 20, 74, cFiles, Cor() )
EndIF
IF Empty( cArquivo )
	FChDir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ErrorBeep()
	ResTela( cScreen )
	Return( aConfig )
EndIF
oEtiqueta := TiniNew( cArquivo )
Aadd( aConfig, oEtiqueta:ReadInteger('configuracao', 'Campos',    05 ))
Aadd( aConfig, oEtiqueta:ReadInteger('configuracao', 'Tamanho',   35 ))
Aadd( aConfig, oEtiqueta:ReadInteger('configuracao', 'Margem',    00 ))
Aadd( aConfig, oEtiqueta:ReadInteger('configuracao', 'Linhas',    01 ))
Aadd( aConfig, oEtiqueta:ReadInteger('configuracao', 'Espacos',   01 ))
Aadd( aConfig, oEtiqueta:ReadInteger('configuracao', 'Carreira',  01 ))
Aadd( aConfig, oEtiqueta:ReadInteger('configuracao', 'Comprimir', 00 ))
Aadd( aConfig, oEtiqueta:ReadInteger('configuracao', 'Vertical',  01 ))
nCampos	:= oEtiqueta:ReadInteger('configuracao', 'Campos',  05 )
nTamanho := oEtiqueta:ReadInteger('configuracao', 'Tamanho', 35 )
For nX := 1 To nCampos
	Aadd( aConfig, oEtiqueta:ReadString('campos', 'campo' + StrZero( nX, 3), Repl('X', nTamanho )))
Next
FChDir( oAmbiente:xBaseDados )
Set Defa To ( oAmbiente:xBaseDados )
ResTela( cScreen )
Return( aConfig )

Proc GravaPromissoria()
***********************
LOCAL cScreen := SaveScreen()
LOCAL cFile   := 'NOTA.PRO'

FChdir( oAmbiente:xBaseDoc )
Set Defa To ( oAmbiente:xBaseDoc )
IF File( cFile )
	ErrorBeep()
	IF !Conf("Erro: O Arquivo " + cFile + " ja existe. Regravar ?")
		FChdir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return
	EndIF
EndIF
ResTela( cScreen )
Ferase( cFile )
Handle := FCreate( cFile )
IF ( Ferror() != 0 )
	Fclose(handle)
	FChdir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	Restela( cScreen )
	Alert("Erro de Criacao de NOTA.PRO")
	Return
EndIF
FWriteLine( Handle,"[configuracao]                      ; Configuracao da Impressora")
FWriteLine( Handle,"ImprimirCondensado=0                ; 0=Nao      1=Sim")
FWriteLine( Handle,"Imprimir12Cpi=1                     ; 0=Nao      1=Sim")
FWriteLine( Handle,"ImprimirNegrito=1                   ; 0=Nao      1=Sim")
FWriteLine( Handle,'EspacamentoVertical=0               ; 0=1/6"     1=1/8"')
FWriteLine( Handle,"TamanhoPagina=36                    ; Comprimento Vertical do Formulario.")
FWriteLine( Handle,"TamanhoExtenso=56                   ; Comprimento Valor Extenso.")
FWriteLine( Handle,"DataVctoExtenso=0                   ; 0=Nao      1=Sim")
FWriteLine( Handle,"DataEmissaoExtenso=0                ; 0=Nao      1=Sim")
FWriteLine( Handle,"")
FWriteLine( Handle, "[dados]")
FWriteLine( Handle, "DataVcto=00,75")
FWriteLine( Handle, "NrDocumento=01,12")
FWriteLine( Handle, "VlrDocumento=01,75")
FWriteLine( Handle, "VctoExtenso=03,12")
FWriteLine( Handle, "NomeCedente=07,12")
FWriteLine( Handle, "CpfCgcCedente=07,75")
FWriteLine( Handle, "VlrExtenso=09,12")
FWriteLine( Handle, "CidadePagto=14,12")
FWriteLine( Handle, "NomeEmitente=15,12")
FWriteLine( Handle, "DataEmissao=15,70")
FWriteLine( Handle, "CpfCgcEmitente=16,12")
FWriteLine( Handle, "EnderecoEmitente=17,12")
FWriteLine( Handle, "CidadeEmitente=-1,-1")
FWriteLine( Handle, "EstadoEmitente=-1,-1")
FWriteLine( Handle,"")
Alert("Informa: Arquivo NOTA.PRO criado.")
FClose(handle)
ResTela( cScreen )
FChdir( oAmbiente:xBaseDados )
Set Defa To ( oAmbiente:xBaseDados )
Return

Function LerPromissoria( xArquivo, lRetorno )
*******************************************
LOCAL cScreen		  := SaveScreen()
LOCAL nErro 		  := 0
LOCAL aPromissoria  := {}
LOCAL cFiles		  := '*.PRO'
LOCAL cString		  := ""
LOCAL Handle

FChdir( oAmbiente:xBaseDoc )
Set Defa To ( oAmbiente:xBaseDoc )
IF xArquivo = NIL .OR. !File( xArquivo )
	IF !File( cFiles )
		oMenu:Limpa()
		ErrorBeep()
		Alert("Erro: Arquivos de Promissorias nao disponiveis.;" + ;
				"Verifique os arquivos com extensao .PRO.")
		FChdir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aPromissoria )
	EndIF
	oMenu:Limpa()
	M_Title("ESCOLHA O ARQUIVO DE CONFIGURACAO DE PROMISSORIAS")
	xArquivo := Mx_PopFile( 05, 10, 20, 74, cFiles, Cor() )
EndIF
IF Empty( xArquivo )
	ErrorBeep()
	FChdir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen )
	Return( aPromissoria )
EndIF
Handle  := Fopen( xArquivo )
IF ( Ferror() != 0 )
	ErroConfiguracaoArquivo( Handle, "Abertura do Arquivo", xArquivo )
	FChdir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen )
	Return( aPromissoria )
EndIF
cString := "[configuracao]"
nErro := FLocate( Handle, cString )
IF nErro < 0
	ErroConfiguracaoArquivo( Handle, cString, xArquivo )
	FChdir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen )
	Return( aPromissoria )
EndIF
FAdvance( Handle )
For nX := 1 To 8
	cLinha  := AllTrim( FReadLine( Handle ))
	cLinha1 := cLinha
	nPosDoIgual := At( "=", cLinha )
	IF nPosDoIgual = 0 // Nao Localizado
		ErroConfiguracaoArquivo( Handle, cLinha, xArquivo )
		FChdir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aPromissoria )
	EndIF
	cLinha  := AllTrim( SubStr( cLinha,  nPosDoIgual+1, 3 ))
	IF Empty( cLinha )
		cLinha = "-1"
	EndIF
	Aadd( aPromissoria, { Val(cLinha),,  })
Next
FAdvance( Handle )
cString := "[dados]"
nErro := FLocate( Handle, cString )
IF nErro < 0
	ErroConfiguracaoArquivo( Handle, cLinha, xArquivo )
	FChdir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen )
	Return( aPromissoria )
EndIF
FAdvance( Handle )
For nX := 1 To 14
	cLinha  := AllTrim( FReadLine( Handle ))
	cLinha1 := cLinha
	nPosDoIgual := At( "=", cLinha )
	IF nPosDoIgual = 0 // Nao Localizado
		ErroConfiguracaoArquivo( Handle, cLinha, xArquivo )
		FChdir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aPromissoria )
	EndIF
	nPosDaVirgula := At( ",", cLinha )
	IF nPosDaVirgula = 0 // Nao Localizado
		ErroConfiguracaoArquivo( Handle, cLinha, xArquivo )
		FChdir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( aPromissoria )
	EndIF
	cLinha  := AllTrim( SubStr( cLinha,  nPosDoIgual+1, (nPosDaVirgual-nPosDoIgual)))
	cColuna := AllTrim( SubStr( cLinha1, nPosDaVirgula+1, 3 ))
	IF Empty( cLinha )
		cLinha = "-1"
	EndIF
	IF Empty( cColuna )
		cColunha = "-1"
	EndIF
	Aadd( aPromissoria, { Val(cLinha), Val(cColuna) })
Next
FClose( Handle )
FChdir( oAmbiente:xBaseDados )
Set Defa To ( oAmbiente:xBaseDados )
ResTela( cScreen )
lRetorno := OK
Return( aPromissoria )

Proc DiretaLivre( cCodi_Cli, aReg  )
************************************
LOCAL cScreen			:= SaveScreen()
LOCAL GetList			:= {}
LOCAL aMenu 			:= { "Imprimir, Usando um Arquivo Existente", "Criar Arquivo de Configuracao ", "Alterar Arquivos de Boleto", "Configurar arquivo padrao"}
LOCAL cObs1 			:= "PROTESTAR NO 5§ DIA UTIL APOS VENCIDO.  "
LOCAL cObs2 			:= "NAO DISPENSAR ENCARGOS DE MORA.         "
LOCAL cObs3 			:= Space(40)
LOCAL aNt				:= {}
LOCAL aDados			:= {}
LOCAL nMoeda			:= 1
LOCAL nLen				:= 0
LOCAL _QtDup			:= 0
LOCAL nX 				:= 0
LOCAL nLargura 		:= 0
LOCAL nChoice			:= 0
LOCAL nAcrescimo		:= 0
LOCAL cVar1 			:= ""
LOCAL cCepPagto		:= ""
LOCAL cCidaPagto		:= ""
LOCAL cEstaPagto		:= ""
LOCAL cExtenso 		:= ""
LOCAL lRetornoBeleza := FALSO
LOCAL xBoleto			:= oIni:ReadString('impressao', 'cob', NIL )
LOCAL lImprimir
LOCAL aBoleto
LOCAL aMoeda
LOCAL cMoeda
LOCAL lMora
LOCAL i
LOCAL nPag
LOCAL nLocal
LOCAL nVcto
LOCAL nEmis
LOCAL nDcto
LOCAL nEspecie
LOCAL nDinhe
LOCAL nInstru
LOCAL nSacado
LOCAL nVlr
LOCAL cMora
LOCAL XIMPRIMIRCONDENSADO
LOCAL XIMPRIMIR12CPI
LOCAL XIMPRIMIRNEGRITO
LOCAL XESPACAMENTOVERTICAL
FIELD Cida
FIELD Vlr
FIELD Jurodia

WHILE OK
	IF PCount() = 0
		cCodi_Cli := Space(05)
		aReg		 := {}
		aReg		 := EscolheTitulo( cCodi_Cli )
	EndIF
	IF ( _QtDup := Len( aReg )) = 0
		ResTela( cScreen )
		Return
	EndIF
	IF xBoleto = NIL
		ErrorBeep()
		WHILE OK
			lImprimir := FALSO
			oMenu:Limpa()
			M_Title("IMPRESSAO DE BOLETO BANCARIO")
			nChoice := FazMenu( 10, 10, aMenu, Cor())
			Do Case
			Case nChoice = 0
				Exit
			Case nChoice = 1
				ErrorBeep()
				aBoleto := LerBoleto(, @lRetornoBeleza )
				IF !lRetornoBeleza
					Loop
				EndIF
				oMenu:Limpa()
				MaBox( 10, 10, 15, 51, "ENTRE COM AS INSTRUCOES" )
				MaBox( 16, 10, 18, 51 )
				@ 12, 11 Get cObs1 Pict "@!"
				@ 13, 11 Get cObs2 Pict "@!"
				@ 14, 11 Get cObs3 Pict "@!"
				@ 17, 11 Say "Outros Acrescimos: " Get nAcrescimo Pict "99999.99"
				Read
				IF LastKey() = ESC
					Exit
				EndIF
				lImprimir := OK
				Exit
			Case nChoice = 2
				GravaBoleto()
				Loop
			Case nChoice = 3
				Edicao( OK, "*.COB" )
				Loop
			Case nChoice = 4
				ConfImpressao()
				Loop
			EndCase
		EndDo
		IF !lImprimir
			aReg := {}
			Loop
		EndIF
	Else
		aBoleto := LerBoleto( xBoleto, @lRetornoBeleza )
		IF !lRetornoBeleza
			xBoleto := NIL
			Loop
		EndIF
		oMenu:Limpa()
		MaBox( 10, 10, 15, 51, "ENTRE COM AS INSTRUCOES" )
		MaBox( 16, 10, 18, 51 )
		@ 12, 11 Get cObs1 Pict "@!"
		@ 13, 11 Get cObs2 Pict "@!"
		@ 14, 11 Get cObs3 Pict "@!"
		@ 17, 11 Say "Outros Acrescimos: " Get nAcrescimo Pict "99999.99"
		Read
		IF LastKey() = ESC
			Exit
		EndIF
		lImprimir := OK
	EndIF
	IF Instru80() .AND. LptOk()
		aMoeda := {"R$"}
		cMoeda := aMoeda[IF( nMoeda = 0, 1, nMoeda )]
		lMora  := Conf("Pergunta: Imprimir juros de mora ?")
		 Mensagem("Aguarde, Imprimindo Boletos.", Cor())
		 PrintOn()
		 FPrint( RESETA )
		 Receber->( Order( RECEBER_CODI ))
		 Receber->(DbSeek( cCodi_Cli ))
		 FOR i :=  1 TO _Qtdup
			 Recemov->(DbGoto( aReg[ i ] ))
			 IF Receber->Cgc = "  .   .   /    -  " .OR. Receber->Cgc = Space( 18 )
				 cVar1 := Receber->Cpf
			 Else
				 cVar1 := Receber->Cgc
			 EndIF
			 anT						 := aBoleto
			 XIMPRIMIRCONDENSADO  := 01
			 XIMPRIMIR12CPI		 := 02
			 XIMPRIMIRNEGRITO 	 := 03
			 XESPACAMENTOVERTICAL := 04
			 nPag 					 := 05			  // Tamanho Pagina
			 nLocal 					 := 06			  // Local de Pagamento
			 nVcto					 := 07			  // Data de Vencimento
			 nEmis					 := 08			  // Data de Emissao
			 nDcto					 := 09			  // Numero do Documento
			 nEspecie				 := 10			  // Especie de Documento
			 nDinhe					 := 11			  // Tipo de Moeda
			 nVlr 					 := 12			  // Valor do Documento
			 nInstru 				 := 13			  // Instrucoes
			 nSacado 				 := 14			  // Sacado

			IF aNt[XIMPRIMIRCONDENSADO,1]  > 0 ; FPrint( PQ )			; EndIF
			IF aNt[XIMPRIMIR12CPI,1]		 > 0 ; FPrint( _CPI12 ) 	; EndIF
			IF aNt[XIMPRIMIRNEGRITO,1] 	 > 0 ; FPrint( NG )			; EndIF
			IF aNt[XESPACAMENTOVERTICAL,1] = 0 ; FPrint( _SPACO1_6 ) ; EndIF
			IF aNt[XESPACAMENTOVERTICAL,1] = 1 ; FPrint( _SPACO1_8 ) ; EndIF
			FPrInt( Chr( 27 ) + "C" + Chr( anT[nPag,01]))
			SetPrc( 0,0 )
			cMora :=  IIF( lMora, "MORA DIARIA DE " + cMoeda + " " + Recemov->(AllTrim( Tran( Jurodia,"@E 999,999.99"))), "")
			IF( anT[nLocal,  01] >= 0, Write( anT[nLocal,  01], anT[nLocal,  02], "QUALQUER AGENCIA"),)					
			IF( anT[nVcto,   01] >= 0, Write( anT[nVcto,   01], anT[nVcto,   02], Recemov->Vcto ),)
			IF( anT[nEmis,   01] >= 0, Write( anT[nEmis,   01], anT[nEmis,   02], Recemov->Emis ),)
			IF( anT[nDcto,   01] >= 0, Write( anT[nDcto,   01], anT[nDcto,   02], Recemov->Docnr ),)
			IF( anT[nEspecie,01] >= 0, Write( anT[nEspecie,01], anT[nEspecie,02], Recemov->Tipo  ),)
			IF( anT[nDinhe,  01] >= 0, Write( anT[nDinhe,  01], anT[nDinhe,  02], cMoeda ),)
			IF( anT[nVlr,    01] >= 0, Write( anT[nVlr,    01], anT[nVlr,    02], Recemov->(Tran( Vlr, "@E 999,999,999.99"))),)
			IF( anT[nInstru, 01] >= 0, Write( anT[nInstru, 01], anT[nInstru, 02], cMora ),)

			IF( anT[nInstru, 01] >= 0, Write( anT[nInstru, 01]+1, anT[nInstru, 02], cObs1 ),)
			IF( anT[nInstru, 01] >= 0, Write( anT[nInstru, 01]+2, anT[nInstru, 02], cObs2 ),)
			IF( anT[nInstru, 01] >= 0, Write( anT[nInstru, 01]+3, anT[nInstru, 02], cObs3 ),)

			IF( nAcrescimo > 0, Write( anT[nInstru, 01]+5, anT[nVlr, 02], Tran( nAcrescimo, "@E 999,999,999.99")),)
			IF( anT[nSacado,01] >= 0, Write( anT[nSacado,01]+0, anT[nSacado,02], Receber->Nome + Space(02) + cVar1 ),)
			IF( anT[nSacado,01] >= 0, Write( anT[nSacado,01]+1, anT[nSacado,02], Receber->Ende + " - " + Receber->Bair ),)
			IF( anT[nSacado,01] >= 0, Write( anT[nSacado,01]+2, anT[nSacado,02], Receber->Cep  + "/"+ Receber->( AllTrim( Cida )) + " - " + Receber->Esta ),)
			__Eject()
		Next
		PrintOff()
	EndIf
	IF Pcount() != 0
		ResTela( cScreen )
		Return
	EndIF
EndDo

Proc ProPersonalizado( cCodi_Cli, aReg )
***************************************
LOCAL GetList			:= {}
LOCAL cScreen			:= SaveScreen()
LOCAL nMoeda			:= 1
LOCAL aMenu 			:= { "Imprimir, Usando um Arquivo Existente", "Criar Arquivo de Configuracao ", "Alterar Arquivos de Promissoria", "Configurar arquivo padrao"}
LOCAL aNt				:= {}
LOCAL nChoice			:= 0
LOCAL lRetornoBeleza := FALSO
LOCAL _QtDup			:= 0
LOCAL nX 				:= 0
LOCAL cVar1 			:= ""
LOCAL cCepPagto		:= ""
LOCAL cCidaPagto		:= ""
LOCAL cEstaPagto		:= ""
LOCAL nLargura 		:= 0
LOCAL cExtenso 		:= ""
LOCAL aDados			:= {}
LOCAL xPro				:= oIni:ReadString('impressao', 'pro', NIL )
LOCAL aRow
LOCAL aCol
LOCAL aTodos
LOCAL xDado
LOCAL XIMPRIMIRCONDENSADO
LOCAL XIMPRIMIR12CPI
LOCAL XIMPRIMIRNEGRITO
LOCAL XESPACAMENTOVERTICAL
LOCAL XTAMANHOPAGINA
LOCAL XTAMANHOEXTENSO
LOCAL nTam
FIELD Vlr

WHILE OK
	IF PCount() = 0
		cCodi_Cli := Space(05)
		aReg		  := {}
		aReg		  := EscolheTitulo( cCodi_Cli )
	EndIF
	IF ( _Qtdup := Len( aReg )) = 0
		ResTela( cScreen )
		Return
	EndIF
	IF xPro = NIL
		ErrorBeep()
		WHILE OK
			lImprimir := FALSO
			oMenu:Limpa()
			M_Title("IMPRESSAO DE PROMISSORIAS")
			nChoice := FazMenu( 10, 10, aMenu )
			Do Case
			Case nChoice = 0
				ResTela( cScreen )
				Return
			Case nChoice = 1
				ErrorBeep()
				aNt := LerPromissoria(xPro, @lRetornoBeleza )
				IF !lRetornoBeleza
					GravaPromissoria()
					xPro := NIL
					Loop
				EndIF
				lImprimir := OK
				Exit
			Case nChoice = 2
				GravaPromissoria()
				Loop
			Case nChoice = 3
				Edicao( OK, "*.PRO" )
				Loop
			Case nChoice = 4
				ConfImpressao()
				Loop
			EndCase
		EndDo
		IF !lImprimir
			aReg := {}
			Loop
		EndIF
	Else
		aNt := LerPromissoria(xPro, @lRetornoBeleza )
		IF !lRetornoBeleza
			xPro := NIL
			Loop
		EndIF
		lImprimir := OK
	EndIF
	XIMPRIMIRCONDENSADO	:= 01
	XIMPRIMIR12CPI 		:= 02
	XIMPRIMIRNEGRITO		:= 03
	XESPACAMENTOVERTICAL := 04
	XTAMANHOPAGINA 		:= 05
	XTAMANHOEXTENSO		:= 06
	IF !InsTru80()
		ResTela( cScreen )
		Return
	EndIF
	Mensagem("Aguarde, Imprimindo Promissorias. ESC Cancela.")
	PrintOn()
	FPrint( RESETA )
	IF aNt[XIMPRIMIRCONDENSADO,1]  > 0 ; FPrint( PQ )			; EndIF
	IF aNt[XIMPRIMIR12CPI,1]		 > 0 ; FPrint( _CPI12 ) 	; EndIF
	IF aNt[XIMPRIMIRNEGRITO,1] 	 > 0 ; FPrint( NG )			; EndIF
	IF aNt[XESPACAMENTOVERTICAL,1] = 0 ; FPrint( _SPACO1_6 ) ; EndIF
	IF aNt[XESPACAMENTOVERTICAL,1] = 1 ; FPrint( _SPACO1_8 ) ; EndIF
	FPrInt( Chr( 27 ) + "C" + Chr( anT[XTAMANHOPAGINA,01]))
	SetPrc( 0,0 )
	Cep->(Order( CEP_CEP ))
	Receber->(Order( RECEBER_CODI ))
	Area("Recemov")
	Set Rela To Recemov->Codi Into Receber
	Recemov->(Order( RECEMOV_CODI ))
	FOR nX :=  1 TO _Qtdup
		Recemov->(DbGoto( aReg[ nX ]))
		IF Receber->Cgc = "  .   .   /    -  " .OR. Receber->Cgc = Space( 18 )
			cVar1 := Receber->Cpf
		Else
			cVar1 := Receber->Cgc
		EndIf
		cCepPagto  := Receber->Praca
		cCidaPagto := AllTrim( Receber->Cida )
		cEstaPagto := Receber->Esta
		IF Cep->(DbSeek( cCepPagto ))
			cCidaPagto := AllTrim( Cep->Cida )
			cEstaPagto := Cep->Esta
		EndIF
		nLargura := IF( anT[XTAMANHOEXTENSO,01] >= 0, anT[XTAMANHOEXTENSO,01], 56 )
		cExtenso := Extenso( Recemov->Vlr, nMoeda, 2, nLargura )
		aDados	:= {}
		aRow		:= {}
		aCol		:= {}
		aTodos	:= {}
		xDado 	:= ""
		IF aNt[07,01] = 1 // Vcto Por Extenso
			xDado := Upper( DataExt1( Recemov->Vcto ))
		Else
			xDado := Recemov->Vcto
		EndIF
		Aadd( aTodos, { xDado, anT[09,01], anT[09,02] })
		xDado := Recemov->Docnr
		Aadd( aTodos, { xDado, anT[10,01], anT[10,02] })
		xDado := Recemov->(Tran( Vlr,"@E 999,999,999.99" ))
		Aadd( aTodos, { xDado, anT[11,01], anT[11,02] })
		xDado := Upper( DataExtenso( Recemov->Vcto ))
		Aadd( aTodos, { xDado, anT[12,01], anT[12,02] })
      xDado := AllTrim(oAmbiente:xNomefir)
		Aadd( aTodos, { xDado, anT[13,01], anT[13,02] })
		xDado := XCGCFIR
		Aadd( aTodos, { xDado, anT[14,01], anT[14,02] })
		xDado := Left( cExtenso, nLargura )
		Aadd( aTodos, { xDado, anT[15,01], anT[15,02] })
		xDado := Right( cExtenso, nLargura )
		Aadd( aTodos, { xDado, anT[15,01]+1, anT[15,02] })
		xDado := cCidaPagto + " - " + cEstaPagto
		Aadd( aTodos, { xDado, anT[16,01], anT[16,02] })
		xDado := Receber->Nome
		Aadd( aTodos, { xDado, anT[17,01], anT[17,02] })
		IF aNt[08,01] = 1 // Emissao Por Extenso
			xDado := Upper( DataExt1( Recemov->Emis ))
		Else
			xDado := Recemov->Emis
		EndIF
		Aadd( aTodos, { xDado, anT[18,01], anT[18,02] })
		xDado := cVar1
		Aadd( aTodos, { xDado, anT[19,01], anT[19,02] })
		xDado := Receber->Ende
		Aadd( aTodos, { xDado, anT[20,01], anT[20,02] })
		xDado := AllTrim( Receber->Cida )
		Aadd( aTodos, { xDado, anT[21,01], anT[21,02] })
		xDado := Receber->Esta
		Aadd( aTodos, { xDado, anT[22,01], anT[22,02] })
		Asort( aTodos,,, {| x, y | y[ 2 ] > x[ 2 ] } )
		nTam := Len( aTodos )
		For nA := 1 To nTam
			IF( aTodos[nA,2] >= 0, Write( aTodos[nA,2], aTodos[nA,3], aTodos[nA,1] ),)
		Next
		__Eject()
	Next
	PrintOff()
	Recemov->(DbClearRel())
	Recemov->(DbGoTop())
	IF PCount() != 0
		ResTela( cScreen )
		Return
	EndIF
EndDo
ResTela( cScreen )
Return

Proc xxxxxxx
************
c := "Vilmar.Ponto"
c := Ponto(c,40)
c := strtran(c, ".")
c := tran(c, "@!")
c := transform(c, "@!")
return

Function LerArqDiversos()
*************************
LOCAL cScreen := SaveScreen()
LOCAL cFiles  := '*.DIV'
LOCAL aMenu   := { "Imprimir, Usando um Arquivo Existente", "Criar Arquivo de Configuracao","Alterar Arquivo de Configuracao", "Configurar arquivo padrao"}
LOCAL xDiv	  := oIni:ReadString('impressao', 'div', NIL )
LOCAL nChoice := 0

FChdir( oAmbiente:xBaseDoc )
Set Defa To ( oAmbiente:xBaseDoc )
IF xDiv != NIL
	IF File( xDiv )
		FChdir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		Return( oAmbiente:xBaseDoc + '\' + xDiv )
	EndIF
EndIF
ErrorBeep()
WHILE OK
	oMenu:Limpa()
	M_Title("IMPRESSAO DE DOCUMENTOS DIVERSOS")
	nChoice := FazMenu( 05, 10, aMenu, Cor())
	Do Case
	Case nChoice = 0
		FChdir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( NIL )
	Case nChoice = 2
		GravaDiversos()
		Loop
	Case nChoice = 3
		Edicao( OK, "*.DIV" )
		Loop
	Case nChoice = 4
		ConfImpressao()
		Loop
	EndCase
	IF !File( cFiles )
		oMenu:Limpa()
		ErrorBeep()
		Alert("Erro: Arquivos de Configuracao nao disponiveis.;" + ;
				"Verifique os arquivos com extensao .DIV")
		Loop
	EndIF
	oMenu:Limpa()
	M_Title( oAmbiente:xBaseDoc + '\*.DIV')
	xArquivo := Mx_PopFile( 05, 05, 20, 70, cFiles, Cor() )
	ResTela( cScreen )
	IF Empty( xArquivo )
		Loop
	EndIF
	FChdir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	Return( oAmbiente:xBaseDoc + '\' + xArquivo )
EndDo

Procedure GravaDiversos()
*************************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL cFile   := 'DIVERSO.DIV'
LOCAL oLista

IF File( cFile )
	ErrorBeep()
	IF !Conf("Erro: O Arquivo " + cFile + " ja existe. Regravar ?")
		ResTela( cScreen )
		Return
	EndIF
EndIF
ResTela( cScreen )
Ferase( cFile )
oLista  := TIniNew( cFile )
oLista:WriteBool("configuracao",    "imprimircondensado", FALSO )
oLista:WriteBool("configuracao",    "imprimir12cpi", FALSO )
oLista:WriteBool("configuracao",    "imprimirnegrito", FALSO )
oLista:WriteInteger("configuracao", "espacamentovertical", 1 )
oLista:WriteInteger("configuracao", "tamanhopagina", 66 )
oLista:WriteInteger("configuracao", "campos", 8 )
oLista:WriteString("campos","campo001","01; 01; Recemov->Docnr")
oLista:WriteString("campos","campo002","02; 01; Recemov->Emis")
oLista:WriteString("campos","campo003","03; 01; Recemov->Vcto")
oLista:WriteString("campos","campo004","04; 01; Tran( Recemov->Vlr, '@E 999,999.99')")
oLista:WriteString("campos","campo005","05; 01; Receber->Nome")
oLista:WriteString("campos","campo006","06; 01; Receber->Ende")
oLista:WriteString("campos","campo007","07; 01; Receber->Cida")
oLista:WriteString("campos","campo008","08; 01; Receber->Esta")
oLista:Close()
Return

Proc PrnDiversos( cCodi_Cli, aReg, cCaixa, cVendedor)
*****************************************************
LOCAL GetList		:= {}
LOCAL cScreen		:= SaveScreen()
LOCAL aGets 		:= {}
LOCAL aRow			:= {}
LOCAL aCol			:= {}
LOCAL aLinha		:= {}
LOCAL aLog			:= {}
LOCAL nCampos		:= 0
LOCAL cCampo		:= ""
LOCAL nRow			:= 0
LOCAL nCol			:= 0
LOCAL nTamForm 	:= 0
LOCAL xFile 		:= ""
LOCAL lCondensado := FALSO
LOCAL l12Cpi		:= FALSO
LOCAL lNegrito 	:= FALSO
LOCAL lCompreco	:= FALSO
LOCAL nSpVert		:= 0
LOCAL xString		:= ""
LOCAL cVar			:= ""
LOCAL cCodi 		:= ""
LOCAL cCep			:= ""
LOCAL oLista
LOCAL n
LOCAL nX
LOCAL _Qtdup

IF cCodi_Cli = NIL
	cCodi_Cli  := Space(05)
	aReg		  := {}
	aReg		  := EscolheTitulo( cCodi_Cli )
EndIF
IF ( _Qtdup := Len( aReg )) = 0
	ResTela( cScreen )
	Return
EndIF
xFile := LerArqDiversos()
IF xFile = NIL
	ResTela( cScreen )
	Return
EndIF
oLista		:= TIniNew( xFile )
lCondensado := oLista:ReadBool("configuracao","imprimircondensado", FALSO )
l12Cpi		:= oLista:ReadBool("configuracao","imprimir12cpi", FALSO )
lNegrito 	:= oLista:ReadBool("configuracao","imprimirnegrito", FALSO )
nSpVert		:= oLista:ReadInteger("configuracao","espacamentovertical", 1 )
nTamForm 	:= oLista:ReadInteger("configuracao","tamanhopagina", 66 )
nCampos		:= oLista:ReadInteger("configuracao","campos", 0 )
For n := 1 To nCampos
  nRow	:= 0
  nCol	:= 0
  nRow	:= oLista:ReadInteger("campos", "campo" + StrZero(n, 3), NIL, 1)
  nCol	:= oLista:ReadInteger("campos", "campo" + StrZero(n, 3), NIL, 2)
  cCampo := AllTrim( oLista:ReadString("campos",  "campo" + StrZero(n, 3), NIL, 3))
  IF !Empty(cCampo)
	  Aadd( aGets, cCampo )
	  Aadd( aRow,	nRow )
	  Aadd( aCol,	nCol )
  EndIF
Next
oLista:Close()
nCampos := Len( aGets )
aLinha := Array( nCampos )
IF !Instru80()
	ResTela( cScreen )
	Return
EndIF
Area("Recemov")
Mensagem( "Aguarde, Imprimindo.")
PrintOn()
IF lCondensado
  FPrint( PQ )
EndIF
IF l12Cpi
	FPrint( _CPI12 )
EndIF
IF lNegrito
	FPrint( NG )
EndIF
IF nSpVert = 0
	FPrint( _SPACO1_6 )
Else
	FPrint( _SPACO1_8 )
EndIF
FPrInt( Chr(ESC) + "C" + Chr( nTamForm ))
SetPrc( 0, 0 )
Lista->(Order( LISTA_CODIGO ))
Saidas->(Order( SAIDAS_FATURA ))
Cep->(Order( CEP_CEP ))
Receber->(Order( RECEBER_CODI ))
Area("Recemov")
Recemov->(Order(UM))
FOR nX :=  1 To _Qtdup
	Recemov->(DbGoto( aReg[ nX ]))
	cCodi   := Recemov->Codi
	cFatura := Recemov->Fatura
	Saidas->(DbSeek( cFatura ))
	cCodigo := Saidas->Codigo
	Lista->(DbSeek( cCodigo))
	Receber->(DbSeek( cCodi ))
	aLog	:= {}
   Aadd( aLog, "DIV" )
   Aadd( aLog, Date() )
   Aadd( aLog, Time() )
	Aadd( aLog, oAmbiente:xUsuario + Space( 10 - Len( oAmbiente:xUsuario )))
   Aadd( aLog, cCaixa )
   Aadd( aLog, cVendedor )
   Aadd( aLog, cFatura )
   Aadd( aLog, Saidas->Emis )
   Aadd( aLog, cCodi )
   cCep  := Receber->Cep
	Cep->(DbSeek( cCep ))
	For n := 1 To nCampos
	  cVar		:= aGets[n]
	  aLinha[n] := ""
	  aLinha[n] := eval({||&cVar})
	  Write( aRow[n], aCol[n], aLinha[n] )
	  Aadd( aLog, aLinha[n] )
	Next
   LogEvento( aLog, '.DIV', XCABEC_PRN1, XCABEC_PRN2)
	__Eject()
Next
PrintOff()
ResTela( cScreen )
Return

Function xTypeToStr( xValue )
*****************************
LOCAL cType 	 := ValType( xValue )
LOCAL cNewValue := ""

If cType == "C"
		cNewValue := xValue
ElseIf cType == "N"
		cNewValue := ALLTRIM( STR( xValue ))
ElseIF cType == "L"
		cNewValue := IF( xValue, "1", "0" )
ElseIf cType == "D"
		cNewValue := Dtoc( xValue )
EndIF
Return( cNewValue )

Proc LogEvento( aLog, cExtensao, cCabec1, cCabec2 )
***************************************************
LOCAL xLog		  := StrTran( Dtoc( Date()), "/") + Ifnil( cExtensao, '.NIL')
LOCAL nLen		  := Len( Ifnil( aLog, {}))
LOCAL cString	  := ""
LOCAL lExiste	  := File( xLog )
LOCAL cHandle

Ifnil( cCabec1, "")
Ifnil( cCabec2, "")
IF !File( xLog )
	cHandle := Fcreate( xLog, FC_NORMAL )
	FClose( cHandle )
EndIF
cHandle := FOpen( xLog, FO_READWRITE + FO_SHARED )
IF ( Ferror() != 0 ) // Erro
	Return
EndIF
nErro := FLocate( cHandle, aLog[5]) // Data Sistema
FBot( cHandle )
IF nErro < 0
	IF !lExiste
      FWriteLine( cHandle, Repl("=", 132 ))
      FWriteLine( cHandle, cCabec1 )
      FWriteLine( cHandle, cCabec2 )
      FWriteLine( cHandle, Repl("=", 132 ))
	EndIF
EndIF
For x := 1 To nLen
	cString += AllTrim(xTypeToStr(aLog[x])) + ','
Next
FWriteLine( cHandle, cString )
FClose( cHandle )
Return

FUNCTION SecondsAsDays( nSeconds )
**********************************
RETURN INT(nSeconds / 86400)

FUNCTION TimeAsAMPM( cTime )
****************************
IF VAL(cTime) < 12
	cTime += " am"
ELSEIF VAL(cTime) = 12
	cTime += " pm"
ELSE
	cTime := STR(VAL(cTime) - 12, 2) + SUBSTR(cTime, 3) + " pm"
ENDIF
RETURN cTime

FUNCTION TimeAsSeconds( cTime )
*******************************
RETURN VAL(cTime) * 3600 + VAL(SUBSTR(cTime, 4)) * 60 +;
		 VAL(SUBSTR(cTime, 7))

FUNCTION TimeAsString( nSeconds )
*********************************
RETURN StrZero(INT(Mod(nSeconds / 3600, 24)), 2, 0) + ":" +;
		 StrZero(INT(Mod(nSeconds / 60, 60)), 2, 0) + ":" +;
		 StrZero(INT(Mod(nSeconds, 60)), 2, 0)

FUNCTION TimeDiff( cStartTime, cEndTime )
*****************************************
RETURN TimeAsString(IF(cEndTime < cStartTime, 86400 , 0) +;
		 TimeAsSeconds(cEndTime) - TimeAsSeconds(cStartTime))

FUNCTION TimeIsValid( cTime )
*****************************
RETURN VAL(cTime) < 24 .AND. VAL(SUBSTR(cTime, 4)) < 60 .AND.;
		 VAL(SUBSTR(cTime, 7)) < 60

Proc IntBaseDados()
*******************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen()
LOCAL Tam		  := 80
LOCAL Col		  := 58
LOCAL Pagina	  := 0
LOCAL nDifVlr	  := 0
LOCAL nSomaDoc   := 0
LOCAL nDifDoc	  := 0
LOCAL aMenu 	  := {"Arquivo Nota",;
							"Inconsistencia Faturamento",;
							"Inconsistencia Contas a Receber",;
							"Inconsistencia Contas Recebidas",;
							"Recebido->Caixa", "Numeros nao faturados",;
							"Lista:Pcompra->Saidas:Pcompra",;
							"Importacao/Exportacao de Movimento",;
							"Proteger Base de Dados",;
							"DesProteger Base de Dados",;
							'Arquivo Saidas',;
							'Arquivo Recemov',;
							'Arquivo Chemov',;
							'Arquivo Lista',;
							'Arquivo Receber',;
							'Arquivo Entradas',;
							'Arquivo Pagamov',;
							'Arquivo Recebido'}
LOCAL aPeriodo   := {"Individual", "Por Periodo", "Geral"}
LOCAL nVlrFatura := 0
LOCAL nReceber   := 0
LOCAL nSomaItens := 0
LOCAL nQtd		  := 0
LOCAL nChoice	  := 0
LOCAL nTipo 	  := 0
LOCAL cCaixa	  := Space(04)
LOCAL nPeriodo   := 0
LOCAL xFatura	  := Space(07)
LOCAL aPreco	  := {}
LOCAL dIni		  := Date()
LOCAL dFim		  := Date()
LOCAL cCodigo
LOCAL oBloco
LOCAL Handle
LOCAL cFatura
LOCAL nMaximo
LOCAL nLen

WHILE OK
	 oMenu:Limpa()
	 M_Title("RECONSTRUIR BASE DADOS")
	 nChoice := FazMenu( 02, 10, aMenu, Cor())
	 IF nChoice = 0
		 FechaTudo()
		 ResTela( cScreen )
		 Return
	 EndIF
	 Do Case
	 Case nChoice = 1
		 CriaNewNota()
	 Case nChoice = 2
		 IF !UsaArquivo("SAIDAS")
			 MensFecha()
			 Return
		 EndIF
		 IF !UsaArquivo("RECEMOV")
			 MensFecha()
			 Return
		 EndIF
		 IF !UsaArquivo("RECEBIDO")
			 MensFecha()
			 Return
		 EndIF
		 IF !UsaArquivo("RECEBER")
			 MensFecha()
			 Loop
		 EndIF
		 IF !UsaArquivo("NOTA")
			 MensFecha()
			 Loop
		 EndIF
		 M_Title("ESCOLHA UMA OPCAO")
		 nPeriodo := FazMenu( 12, 10, aPeriodo, Cor())
		 IF nPeriodo = 0
			 Loop
		 ElseIF nPeriodo = 1
			 xFatura := Space(07)
			 MaBox( 19, 10, 21, 40 )
			 @ 20, 11 Say "Fatura..." Get xFatura Pict "@!" Valid VisualAchaFatura( @xFatura )
			 Read
			 IF LastKey() = ESC
				 Loop
			 EndIF
			 Area("Nota")
			 Nota->(Order( NOTA_NUMERO ))
			 Nota->(DbSeek( xFatura ))
			 oBloco := {|| Nota->Numero = xFatura }
		 ElseIF nPeriodo = 2
			 dIni := Date()-30
			 dFim := Date()
			 MaBox( 19, 10, 22, 40 )
			 @ 20, 11 Say "Data Inicial.." Get dIni Pict "##/##/##"
			 @ 21, 11 Say "Data Final...." Get dFim Pict "##/##/##" Valid dFim >= dIni
			 Read
			 IF LastKey() = ESC
				 Loop
			 EndIF
			 Area("Nota")
			 Nota->(Order( NOTA_DATA ))
			 Set Soft On
			 Nota->(DbSeek( dIni ))
			 Set Soft Off
			 oBloco := {|| Nota->Data >= dIni .AND. Nota->Data <= dFim }
		 ElseIF nPeriodo = 3
			 Area("Nota")
			 Nota->(Order( NOTA_DATA ))
			 Nota->(DbGoTop())
			 oBloco := {|| Nota->(!Eof()) }
		 EndIF
		 IF !Conf("Pergunta: Verificacao podera demorar. Continuar ?")
			 Loop
		 EndIF
		 IF !InsTru80()
			 Loop
		 EndIF
		 oMenu:Limpa()
		 Mensagem("Aguarde, SCI Processando Pesado.", Cor())
		 PrintOn()
		 SetPrc( 0, 0 )
		 Area("Recebido")
		 Recebido->(Order( RECEBIDO_FATURA )) // Fatura
		 Area("Recemov")
		 Recemov->(Order( RECEMOV_FATURA ))  // Fatura
		 Area("Saidas")
		 Saidas->(Order( SAIDAS_FATURA ))	  // Fatura
		 Col	  := 58
		 Pagina := 0
		 While Eval( oBloco ) .AND. Rep_Ok()
			  cFatura	 := Nota->Numero
			  cCliente	 := Saidas->Codi
			  nSomaItens := 0
			  nVlrFatura := 0
			  nReceber	 := 0
			  nRecebido  := 0
			  nQtd		 := 0
			  IF Saidas->(DbSeek( cFatura ))
					nSomaItens := 0
					nVlrFatura := Saidas->VlrFatura
					cForma	  := Saidas->Forma
					dEmis 	  := Saidas->Emis
					nQtd		  := Saidas->Qtd_D_Fatu
					nReceber   := 0
					nRecebido  := 0
					While Saidas->Fatura = cFatura
						nSomaItens += ( Saidas->Saida * Saidas->Pvendido )
						Saidas->(DbSkip(1))
					EndDo
					IF Recemov->(DbSeek( cFatura ))
						While Recemov->Fatura = cFatura
							 nReceber++
							 Recemov->(DbSkip(1))
						EndDo
					EndIF
					IF Recebido->(DbSeek( cFatura ))
						While Recebido->Fatura = cFatura
							 nRecebido++
							 Recebido->(DbSkip(1))
						EndDo
					EndIF
			  EndIF
			  IF Col >= 57
				  Write( 00, 00, Linha1( Tam, @Pagina))
				  Write( 01, 00, Linha2())
				  Write( 02, 00, Linha3(Tam))
				  Write( 03, 00, Linha4(Tam, SISTEM_NA2 ))
				  Write( 04, 00, Padc( "RELATORIO RESUMO DIFERENCA DA BASE DE DADOS",Tam ) )
				  Write( 05, 00, Linha5(Tam))
				  Write( 06, 00, "EMISSAO   FATURA  CLI FORMA  VLRFATURA        SAIDAS  =D  +D  -D  #D")
				  Write( 07, 00, Linha5(Tam))
				  Col := 8
			  EndIF
			  nDifVlr  := Int(( nSomaItens - nVlrFatura ))
			  nSomaDoc := ( nReceber + nRecebido )
			  nDifDoc  := ( nSomaDoc - nQtd )
			  IF nDifVlr > 1 .OR. nDifVlr < 0 .OR. nSomaDoc < nQtd
				  Qout( dEmis, cFatura, cCliente, cForma, nVlrFatura, nSomaItens,;
						  Tran( nQtd,"999"), Tran( nReceber, "999"),;
						  Tran( nRecebido, "999"), Tran( nDifDoc, "999"))
				  Col++
			  EndIF
			  Nota->(DbSkip(1))
			  IF Col >= 54 .OR. Nota->(Eof()) .OR. !Eval( oBloco )
				  Qout( Repl( SEP, Tam ))
				  Qout()
				  Qout("=D |= TITULOS FATURADOS.")
				  Qout("+D |= TITULOS A RECEBER.")
				  Qout("-D |= TITULOS RECEBIDOS.")
				  Qout("#D |= DIFERENCA QTD TITULOS.")
				  __Eject()
				  Col := 58
			  EndIF
			EndDo
			__Eject()
			PrintOff()

	 Case nChoice = 3
		 IF !Conf("Pergunta: Verificacao podera demorar. Continuar ?")
			 Loop
		 EndIF
		 IF !InsTru80()
			 Loop
		 EndIF
		 oMenu:Limpa()
		 Mensagem("Aguarde, SCI Processando Pesado.", Cor())
		 IF !UsaArquivo("NOTA")
			 MensFecha()
			 Return
		 EndIF
		 IF !UsaArquivo("RECEMOV")
			 MensFecha()
			 Return
		 EndIF
		 PrintOn()
		 SetPrc( 0, 0 )
		 Area("Recemov")
		 Recemov->(Order( QUATRO )) // Fatura
		 Recemov->(DbGoTop())
		 cFaturaAnt := ""
		 Tam			:= 80
		 Col			:= 58
		 Pagina		:= 0
		 While Recemov->(!Eof()) .AND. Rep_Ok()
			 cFatura 	:= Recemov->Fatura
			 cCliente	:= Recemov->Codi
			 IF cFaturaAnt != cFatura
				 IF Nota->(!DbSeek( cFatura ))
					 nVlrFatura := Recemov->VlrFatu
					 dEmis		:= Recemov->Emis
					 cForma		:= Recemov->Forma
					 IF Col >= 57
						 Write( 00, 00, Linha1( Tam, @Pagina))
						 Write( 01, 00, Linha2())
						 Write( 02, 00, Linha3(Tam))
						 Write( 03, 00, Linha4(Tam, SISTEM_NA2 ))
						 Write( 04, 00, Padc( "RELATORIO RESUMO CONTAS A RECEBER NAO FATURADAS",Tam ) )
						 Write( 05, 00, Linha5(Tam))
						 Write( 06, 00, "EMISSAO   FATURA  CLI FORMA  VLRFATURA")
						 Write( 07, 00, Linha5(Tam))
						 Col := 8
					 EndIF
					 Qout( dEmis, cFatura, cCliente, cForma, nVlrFatura )
					 Col++
					 IF Col >= 58 .OR. Eof()
						 Qout( Repl( SEP, Tam ))
						 __Eject()
						 Col := 58
					 EndIF
				 EndIF
			 EndIF
			 cFaturaAnt := Recemov->Fatura
			 Recemov->(DbSkip(1))
		 EndDo
		 __Eject()
		 PrintOff()

	 Case nChoice = 4
		 IF !Conf("Pergunta: Verificacao podera demorar. Continuar ?")
			 Loop
		 EndIF
		 IF !InsTru80()
			 Loop
		 EndIF
		 oMenu:Limpa()
		 Mensagem("Aguarde, SCI Processando Pesado.", Cor())
		 IF !UsaArquivo("NOTA")
			 MensFecha()
			 Return
		 EndIF
		 IF !UsaArquivo("RECEBIDO")
			 MensFecha()
			 Return
		 EndIF
		 PrintOn()
		 SetPrc( 0, 0 )
		 Area("Recebido")
		 Recebido->(Order( QUATRO )) // Fatura
		 Recebido->(DbGoTop())
		 cFaturaAnt := ""
		 Tam			:= 80
		 Col			:= 58
		 Pagina		:= 0
		 While Recebido->(!Eof()) .AND. Rep_Ok()
			 cFatura 	:= Recebido->Fatura
			 cCliente	:= Recebido->Codi
			 IF cFaturaAnt != cFatura
				 IF Nota->(!DbSeek( cFatura ))
					 dEmis		:= Recebido->Emis
					 IF Col >= 57
						 Write( 00, 00, Linha1( Tam, @Pagina))
						 Write( 01, 00, Linha2())
						 Write( 02, 00, Linha3(Tam))
						 Write( 03, 00, Linha4(Tam, SISTEM_NA2 ))
						 Write( 04, 00, Padc( "RELATORIO RESUMO CONTAS RECEBIDAS NAO FATURADAS",Tam ) )
						 Write( 05, 00, Linha5(Tam))
						 Write( 06, 00, "EMISSAO   FATURA  CLIENTE")
						 Write( 07, 00, Linha5(Tam))
						 Col := 8
					 EndIF
					 Qout( dEmis, cFatura, cCliente )
					 Col++
					 IF Col >= 58 .OR. Eof()
						 Qout( Repl( SEP, Tam ))
						 __Eject()
						 Col := 58
					 EndIF
				 EndIF
			 EndIF
			 cFaturaAnt := Recebido->Fatura
			 Recebido->(DbSkip(1))
		 EndDo
		 __Eject()
		 PrintOff()

	 Case nChoice = 5
		 RecebidoCx()
		 FechaTudo()

	 Case nChoice = 6
		 IF !Conf("Pergunta: Verificacao podera demorar. Continuar ?")
			 Loop
		 EndIF
		 IF !InsTru80()
			 Loop
		 EndIF
		 oMenu:Limpa()
		 Mensagem("Aguarde, SCI Processando Pesado.", Cor())
		 IF !UsaArquivo("NOTA")
			 MensFecha()
			 Return
		 EndIF
		 PrintOn()
		 SetPrc( 0, 0 )
		 Area("Nota")
		 Nota->(Order( NOTA_NUMERO ))
		 Nota->(DbGoBottom())
		 nMaximo 	:= Val( Nota->Numero )
		 nLen 		:= Len( Nota->Numero )
		 Tam			:= 80
		 Row			:= 58
		 Col			:= 0
		 Pagina		:= 0
		 nConta		:= 0
		 nX			:= 0
		 lImpresso	:= FALSO
		 For nX := 1 To nMaximo
			 cFatura := StrZero( nX, nLen )
			 IF Nota->(!DbSeek( cFatura ))
				 nConta	  ++
				 lImpresso := OK
				 IF Row >= 57
					 Write( 00, 00, Linha1( Tam, @Pagina))
					 Write( 01, 00, Linha2())
					 Write( 02, 00, Linha3(Tam))
					 Write( 03, 00, Linha4(Tam, SISTEM_NA2 ))
					 Write( 04, 00, Padc( 'RELATORIO NUMEROS NAO FATURADOS',Tam ) )
					 Write( 05, 00, Linha5(Tam))
					 Write( 06, 00, "FATURA FATURA FATURA FATURA FATURA FATURA FATURA FATURA FATURA FATURA")
					 Write( 07, 00, Linha5(Tam))
					 Row := 8
					 Col := 0
				 EndIF
				 IF Col = 0
					 Qout( cFatura )
					 Row++
				 Else
					 Qqout('', cFatura )
				 EndIF
				 Col += nLen
				 IF Col >= 70
					 Col := 0
				 EndIF
				 IF Row >= 58 .OR. nX = nMaximo
					 Qout( Repl( SEP, Tam ))
					 Qout("REGISTROS LISTADOS :", Int( nConta ))
					 __Eject()
				 EndIF
			 EndIF
		 Next
		 PrintOff()
		 FechaTudo()
	Case nChoice = 7
		 IF !Conf("Pergunta: Ajuste podera demorar. Continuar ?")
			 Loop
		 EndIF
		 IF !UsaArquivo("LISTA")
			 MensFecha()
			 Return
		 EndIF
		 IF !UsaArquivo("SAIDAS")
			 MensFecha()
			 Return
		 EndIF
		 Mensagem("Aguarde, SCI Processando Pesado.", Cor())
		 Lista->(Order( LISTA_CODIGO ))
		 Saidas->(Order( SAIDAS_CODIGO ))
		 Saidas->(DbGoTop())
		 While Saidas->(!Eof())
			 IF Lista->(DbSeek( Saidas->Codigo ))
				 While Saidas->Codigo = Lista->Codigo
					 IF Saidas->Pcompra > Lista->Pcompra .OR. Saidas->Pcompra > Saidas->Pcusto .OR. Saidas->Pcompra = 0
						 IF Saidas->(TravaReg())
							 IF Lista->Pcompra <> 0
								 Saidas->Pcompra := IF( Lista->Pcompra < Saidas->Pcusto, Lista->Pcompra, Saidas->Pcusto )
							 Else
								 Saidas->Pcompra := IF( Lista->Pcompra < Saidas->Pcusto, Saidas->Pcusto, Lista->Pcompra )
							 EndIF
							 Saidas->(Libera())
						 EndIF
					 EndIF
					 Saidas->(DbSkip(1))
				 EndDo
			 Else
				 Saidas->(DbSkip(1))
			 EndIF
		 EndDo
	Case nChoice = 8
		ImpExportaDados()
	Case nChoice = 9
		ProtegerDbf( OK )
	Case nChoice = 10
		ProtegerDbf( FALSO )
	Case nChoice = 11
		 ErrorBeep()
		 IF Conf("Pergunta: Continuar com a opera‡ao ?")
			 DupSaidas()
			 Fechatudo()
			 IF AbreArquivo("SAIDAS")
				 CriaIndice("SAIDAS")
			 EndIF
		 EndIF
	Case nChoice = 12
		 ErrorBeep()
		 IF Conf("Pergunta: Continuar com a opera‡ao ?")
			 DupRecemov()
			 Fechatudo()
			 IF AbreArquivo("RECEMOV")
				 CriaIndice("RECEMOV")
			 EndIF
		 EndIF
	Case nChoice = 13
		 ErrorBeep()
		 IF Conf("Pergunta: Continuar com a opera‡ao ?")
			 DupChemov()
			 Fechatudo()
			 IF AbreArquivo("CHEMOV")
				 CriaIndice("CHEMOV")
			 EndIF
		 EndIF
	Case nChoice = 14
		 ErrorBeep()
		 IF Conf("Pergunta: Continuar com a opera‡ao ?")
			 DupLista()
			 Fechatudo()
			 IF AbreArquivo("LISTA")
				 CriaIndice("LISTA")
			 EndIF
		 EndIF
	Case nChoice = 15
		 ErrorBeep()
		 IF Conf("Pergunta: Continuar com a opera‡ao ?")
			 DupReceber()
			 Fechatudo()
			 IF AbreArquivo("RECEBER")
				 CriaIndice("RECEBER")
			 EndIF
		 EndIF
	Case nChoice = 16
		 ErrorBeep()
		 IF Conf("Pergunta: Continuar com a opera‡ao ?")
			 DupEntradas()
			 Fechatudo()
			 IF AbreArquivo("ENTRADAS")
				 CriaIndice("ENTRADAS")
			 EndIF
		 EndIF
	Case nChoice = 17
		 ErrorBeep()
		 IF Conf("Pergunta: Continuar com a opera‡ao ?")
			 DupPagamov()
			 Fechatudo()
			 IF AbreArquivo("PAGAMOV")
				 CriaIndice("PAGAMOV")
			 EndIF
		 EndIF
	Case nChoice = 18
		 ErrorBeep()
		 IF Conf("Pergunta: Continuar com a opera‡ao ?")
			 DupRecebido()
			 Fechatudo()
			 IF AbreArquivo("RECEBIDO")
				 CriaIndice("RECEBIDO")
			 EndIF
		 EndIF
	EndCase
EndDo


Proc Maiorais()
***************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL oRelato
LOCAL m[12,2]
LOCAL cCodi
LOCAL nTotal

ErrorBeep()
IF !Conf('Pergunta: Podera ser extremamente demorado. Continuar ?')
	ResTela( cScreen )
	Return
EndIF
Receber->(Order( RECEBER_CODI ))
Receber->(DbGoTop())
Saidas->(Order( SAIDAS_CODI ))
Mensagem('Aguarde, processando valores.')
For nX := 1 To 12
	m[nX,1] := 0
Next
While Receber->(!Eof())
	cCodi  := Receber->Codi
	nTotal := 0
	IF Saidas->(DbSeek( cCodi ))
		While Saidas->Codi = cCodi
			nTotal += Saidas->Saida * Saidas->Pvendido
			Saidas->(DbSkip(1))
		EndDo
		Asort( m,,, {| x, y | y[ 1 ] > x[ 1 ] } )
		For nX := 1 To 12
			IF m[nX,1] < nTotal
				m[nX,1] := nTotal
				m[nX,2] := cCodi
				Exit
			EndIF
		Next
	EndIF
	Receber->(DbSkip(1))
EndDo
SetColor("")
Cls
Grafico( m, OK, "OS 12 MAIORES CLIENTES" ,"EM MILHARES", AllTrim(oAmbiente:xNomefir), 1000 )
Inkey(0)
ErrorBeep()
oMenu:Limpa()
IF Conf('Pergunta: Deseja imprimir ?')
	IF !InsTru80()
		ResTela( cScreen )
		Return
	EndIF
	PrintOn()
	SetPrc( 0,0 )
	oRelato := TRelatoNew()
	oRelato:Sistema	:= SISTEM_NA2
	oRelato:Titulo 	:= "RELATORIO DOS 12 MAIORES CLIENTES"
	oRelato:Cabecalho := "CODI  NOME DO CLIENTE                                   VALOR RANKING"
	oRelato:Inicio()
	nConta :=  0
	For nX := 12 To 1 Step -1
		nConta++
		cCodi  := m[nX,2]
		nTotal := m[nX,1]
		Receber->(DbSeek( cCodi ))
		Qout( cCodi, Receber->Nome, Tran( nTotal, '@E 999,999,999.99'), Tran( nConta, '99§' ))
		oRelato:RowPrn ++
	Next
	__Eject()
	PrintOff()
EndIF
ResTela( cScreen )
Return

Proc ImpExportaDados()
**********************
LOCAL cScreen := SaveScreen()
LOCAL aTipo   := {'Exportacao', 'Importacao'}

WHILE OK
	oMenu:Limpa()
	M_Title("ESCOLHA O TIPO")
	nTipo := FazMenu( 05, 08, aTipo )
	Do Case
	Case nTipo = 0
		ResTela( cScreen )
		Return
	Case nTipo = 1
		ExportaDados()
	Case nTipo = 2
		ImportaDados()
	EndCase
EndDo

Proc ImportaDados()
*******************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL cFiles	:= 'SAI*.REM'
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL xArquivo

IF !UsaArquivo("SAIDAS")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("RECEMOV")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("RECEBER")
	MensFecha()
	Return
EndIF
oMenu:Limpa()
M_Title("ESCOLHA ARQUIVO DE SAIDAS PARA IMPORTACAO")
xArquivo := Mx_PopFile( 05, 10, 20, 74, cFiles )
IF Empty( xArquivo )
	ErrorBeep()
	ResTela( cScreen )
	Return
EndIF
Mensagem("Aguarde, Importando Arquivo Saidas.")
Area("Saidas")
Appe From ( xArquivo )
xTemp := StrTran( xArquivo, '.REM')
MsRename( xArquivo, xTemp + '.IMP')

oMenu:Limpa()
cFiles := 'MOV*.REM'
M_Title("ESCOLHA ARQUIVO DE MOVIMENTO PARA IMPORTACAO")
xArquivo := Mx_PopFile( 05, 10, 20, 74, cFiles )
IF Empty( xArquivo )
	ErrorBeep()
	ResTela( cScreen )
	Return
EndIF
Mensagem("Aguarde, Importando Arquivo Recemov.")
Area("Recemov")
Appe From ( xArquivo )
xTemp := StrTran( xArquivo, '.REM')
MsRename( xArquivo, xTemp + '.IMP')

oMenu:Limpa()
cFiles := 'REC*.REM'
M_Title("ESCOLHA ARQUIVO DE CLIENTES PARA IMPORTACAO")
xArquivo := Mx_PopFile( 05, 10, 20, 74, cFiles )
IF Empty( xArquivo )
	ErrorBeep()
	ResTela( cScreen )
	Return
EndIF
Mensagem("Aguarde, Importando Arquivo Recber.")
Area("Receber")
Appe From ( xArquivo )
xTemp := StrTran( xArquivo, '.REM')
MsRename( xArquivo, xTemp + '.IMP')
CriaNewNota( OK )
AreaAnt( Arq_Ant, Ind_Ant )
ResTela(cScreen )
Return

Proc ExportaDados()
*******************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL dIni	  := Date()-30
LOCAL dFim	  := Date()
LOCAL aStru   := {}
LOCAL nField  := 0
LOCAL cReIni
LOCAL cReFim
LOCAL xSai
LOCAL xMov
LOCAL xRec

IF !UsaArquivo("SAIDAS")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("RECEMOV")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("RECEBER")
	MensFecha()
	Return
EndIF
oMenu:Limpa()
dIni := Date()-30
dFim := Date()
MaBox( 11, 10, 14, 40 )
@ 12, 11 Say "Data Inicial.." Get dIni Pict "##/##/##"
@ 13, 11 Say "Data Final...." Get dFim Pict "##/##/##" Valid dFim >= dIni
Read
IF LastKey() = ESC
	Return
EndIF
xSai	  := FTempName('SAI?????.REM')
aStru   := Saidas->(DbStruct())
oBloco2 := {|| !Exportado }
oBloco3 := {|| Saidas->Emis >= dIni .AND. Saidas->Emis <= dFim }
DbCreate( xSai, aStru )
Use (xSai) Alias xSaidas Exclusive New
Area('Saidas')
Saidas->(Order( SAIDAS_EMIS ))
Set Soft On
Saidas->(DbSeek( dIni ))
Set Soft Off
Mensagem('Aguarde, Filtrando e Exportando Saidas.')
Try Eval( oBloco3 ) .AND. !Eof() .AND. Rep_Ok()
	IF Eval( oBloco2 )
		xSaidas->(DbAppend())
		For nField := 1 To FCount()
			xSaidas->( FieldPut( nField, Saidas->(FieldGet( nField ))))
		Next
		IF Saidas->(TravaReg())
			Saidas->Exportado := OK
		EndIF
		Saidas->(Libera())
	EndIF
	Saidas->(DbSkip(1))
EndTry

xMov	  := FTempName('MOV?????.REM')
aStru   := Recemov->(DbStruct())
oBloco2 := {|| !Exportado }
oBloco3 := {|| Recemov->Emis >= dIni .AND. Recemov->Emis <= dFim }
DbCreate( xMov, aStru )
Use (xMov) Alias xRecemov Exclusive New
Area('Recemov')
Recemov->(Order( RECEMOV_EMIS ))
Set Soft On
Recemov->(DbSeek( dIni ))
Set Soft Off
Mensagem('Aguarde, Filtrando e Exportando Recemov.')
Try Eval( oBloco3 ) .AND. !Eof() .AND. Rep_Ok()
	IF Eval( oBloco2 )
		xRecemov->(DbAppend())
		For nField := 1 To FCount()
			xRecemov->( FieldPut( nField, Recemov->(FieldGet( nField ))))
		Next
		IF Recemov->(TravaReg())
			Recemov->Exportado := OK
		EndIF
		Recemov->(Libera())
	EndIF
	Recemov->(DbSkip(1))
EndTry
xRec	  := FTempName('REC?????.REM')
aStru   := Receber->(DbStruct())
oBloco2 := {|| !Exportado }
DbCreate( xRec, aStru )
Use (xRec) Alias xReceber Exclusive New
Area('Receber')
Receber->(Order( RECEBER_ESTA_DATA ))
Receber->(DbGoTop())
cReIni := Receber->Esta
Receber->(DbGoBottom())
cReFim := Receber->Esta
oBloco3 := {|| Receber->Esta >= cReIni .AND. Receber->Esta <= cReFim .AND. Receber->Data >= dIni .AND. Receber->Data <= dFim }
Receber->(DbGoTop())
Mensagem('Aguarde, Filtrando e exportando Receber.')
Try Eval( oBloco3 ) .AND. !Eof() .AND. Rep_Ok()
	IF Eval( oBloco2 )
		xReceber->(DbAppend())
		For nField := 1 To FCount()
			xReceber->( FieldPut( nField, Receber->(FieldGet( nField ))))
		Next
		IF Receber->(TravaReg())
			Receber->Exportado := OK
		EndIF
		Receber->(Libera())
	EndIF
	Receber->(DbSkip(1))
EndTry
xSaidas->(DbGotop())
xRecemov->(DbGotop())
xReceber->(DbGotop())
IF xSaidas->(Lastrec()) = 0
	IF xRecemov->(Lastrec()) = 0
		IF xReceber->(Lastrec()) = 0
		  oMenu:Limpa()
		  ErrorBeep()
		  Alerta('Informa: Nada a exportar no periodo.')
	  EndIF
	EndIF
EndIF
xSaidas->(DbCloseArea())
xRecemov->(DbCloseArea())
xReceber->(DbCloseArea())
Ferase( xSai )
Ferase( xMov )
Ferase( xRec )
ResTela( cScreen )
Return


Function Ean39( cString )
*************************
LOCAL Printer := 'E' // (E)pson (L)aserJet
LOCAL Height  := 2

If cString = NIL
	cString := 'EAN39'
EndIF
//Setup_hp( Printer, Height )
Setup_Epson( Printer, Height )
Def_Code39()
cString	:= "*" + Trim( cString ) + "*"
Set Devi To Print
Write( Prow() + Height, 00, Barcode( cString, Printer, Height ))
//Write( Prow() + IF( Printer = "L", Height, 0 ), Int( Len(  cString ) / 4 ), cString )
Set Devi To Screen
Return NIL

Function BarCode( cString, Printer, Height )
********************************************
Code = ""
Do Case
Case printer = "L"
For i := 1 To Len( cString )
	Letter := Substr( cString,i,1)
	Code += If( At( Letter, Chars) = 0, Letter, Char[ At( Letter, Chars)]) + NS
Next
Code := Start + Code + End
case printer = "E"
	for h = 1 to height
	  for i = 1 to len( cString)
		  letter = substr(cString,i,1)
		  code = if(at(letter,chars)=0,letter,char[at(letter,chars)]) + NS
		  printcode(Chr(27)	+ Chr(76) + Chr(N1) + Chr(N2) + code)
	  next
	  printcode(Chr(27) +Chr(74)+Chr(23)+Chr(13))
  next
  printcode(Chr(27) +Chr(74)+Chr(5)+Chr(13))
  printcode(Chr(27) +"@")
EndCase
Return( Code )

Proc Setup_Hp()
***************
PUBL nb
PUBL wb
PUBL ns
PUBL ws
PUBL start
PUBL end
small_bar := 3
wide_bar  := round(small_bar * 2.25,0) && 2.25 x small_bar
dpl		 := 50
nb 		 := Chr(27)  + "*c"+transform(small_bar,'99')+"a"+alltrim(str(height*dpl))+"b0P"+Chr(27) +"*p+"+transform(small_bar,'99')+"X"
wb 		 := Chr(27)  + "*c"+transform(wide_bar,'99')+"a"+alltrim(str(height*dpl))+"b0P"+Chr(27) +"*p+"+transform(wide_bar,'99')+"X"
ns 		 := Chr(27)  + "*p+"+transform(small_bar,'99')+"X"
ws 		 := Chr(27)  + "*p+"+transform(wide_bar,'99')+"X"
start 	 := Chr(27)  + "*p-50Y"
end		 := Chr(27)  + "*p+50Y"
return

Proc Setup_Epson()
******************
PUBL ns := Chr(0) + Chr(0)
PUBL ws := Chr(0) + Chr(0) + Chr(0) + Chr(0)
PUBL nb := Chr(255)
PUBL wb := Chr(255) + Chr(255) + Chr(255)
PUBL n1
PUBL n2
printcode(Chr(27) + Chr(51) + Chr(2))
cols	  := 21
N1 	  := cols % 256 && modulus
N2 	  := INT(cols/256)
Return

Proc Def_Code39()
*****************
PUBL char[44]
PUBL chars

chars = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ-. *$/+%"
CHAR[01] = WB+NS+NB+WS+NB+NS+NB+NS+WB && "1"
CHAR[02] = NB+NS+WB+WS+NB+NS+NB+NS+WB && "2"
CHAR[03] = WB+NS+WB+WS+NB+NS+NB+NS+NB && "3"
CHAR[04] = NB+NS+NB+WS+WB+NS+NB+NS+WB && "4"
CHAR[05] = WB+NS+NB+WS+WB+NS+NB+NS+NB && "5"
CHAR[06] = NB+NS+WB+WS+WB+NS+NB+NS+NB && "6"
CHAR[07] = NB+NS+NB+WS+NB+NS+WB+NS+WB && "7"
CHAR[08] = WB+NS+NB+WS+NB+NS+WB+NS+NB && "8"
CHAR[09] = NB+NS+WB+WS+NB+NS+WB+NS+NB && "9"
CHAR[10] = NB+NS+NB+WS+WB+NS+WB+NS+NB && "0"
CHAR[11] = WB+NS+NB+NS+NB+WS+NB+NS+WB && "A"
CHAR[12] = NB+NS+WB+NS+NB+WS+NB+NS+WB && "B"
CHAR[13] = WB+NS+WB+NS+NB+WS+NB+NS+NB && "C"
CHAR[14] = NB+NS+NB+NS+WB+WS+NB+NS+WB && "D"
CHAR[15] = WB+NS+NB+NS+WB+WS+NB+NS+NB && "E"
CHAR[16] = NB+NS+WB+NS+WB+WS+NB+NS+NB && "F"
CHAR[17] = NB+NS+NB+NS+NB+WS+WB+NS+WB && "G"
CHAR[18] = WB+NS+NB+NS+NB+WS+WB+NS+NB && "H"
CHAR[19] = NB+NS+WB+NS+NB+WS+WB+NS+NB && "I"
CHAR[20] = NB+NS+NB+NS+WB+WS+WB+NS+NB && "J"
CHAR[21] = WB+NS+NB+NS+NB+NS+NB+WS+WB && "K"
CHAR[22] = NB+NS+WB+NS+NB+NS+NB+WS+WB && "L"
CHAR[23] = WB+NS+WB+NS+NB+NS+NB+WS+NB && "M"
CHAR[24] = NB+NS+NB+NS+WB+NS+NB+WS+WB && "N"
CHAR[25] = WB+NS+NB+NS+WB+NS+NB+WS+NB && "O"
CHAR[26] = NB+NS+WB+NS+WB+NS+NB+WS+NB && "P"
CHAR[27] = NB+NS+NB+NS+NB+NS+WB+WS+WB && "Q"
CHAR[28] = WB+NS+NB+NS+NB+NS+WB+WS+NB && "R"
CHAR[29] = NB+NS+WB+NS+NB+NS+WB+WS+NB && "S"
CHAR[30] = NB+NS+NB+NS+WB+NS+WB+WS+NB && "T"
CHAR[31] = WB+WS+NB+NS+NB+NS+NB+NS+WB && "U"
CHAR[32] = NB+WS+WB+NS+NB+NS+NB+NS+WB && "V"
CHAR[33] = WB+WS+WB+NS+NB+NS+NB+NS+NB && "W"
CHAR[34] = NB+WS+NB+NS+WB+NS+NB+NS+WB && "X"
CHAR[35] = WB+WS+NB+NS+WB+NS+NB+NS+NB && "Y"
CHAR[36] = NB+WS+WB+NS+WB+NS+NB+NS+NB && "Z"
CHAR[37] = NB+WS+NB+NS+NB+NS+WB+NS+WB && "-"
CHAR[38] = WB+WS+NB+NS+NB+NS+WB+NS+NB && "."
CHAR[39] = NB+WS+WB+NS+NB+NS+WB+NS+NB && " "
CHAR[40] = NB+WS+NB+NS+WB+NS+WB+NS+NB && "*"
CHAR[41] = NB+WS+NB+WS+NB+WS+NB+NS+NB && "$"
CHAR[42] = NB+WS+NB+WS+NB+NS+NB+WS+NB && "/"
CHAR[43] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "+"
CHAR[44] = NB+NS+NB+WS+NB+WS+NB+WS+NB && "%"
Return

Function PrintCode( Code )
**************************
Set Cons Off
Set Print On
?? Code
Set Print Off
Set Cons on
Return NIL


Function CdowPort( dDate )
**************************
LOCAL aDataUsa := {'Sunday','Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'}
LOCAL aDataBra := {'Domingo','Segunda', 'Terca', 'Quarta', 'Quinta', 'Sexta', 'Sabado'}
LOCAL nPos		:= 0

nPos := Ascan( aDataUsa, CDow( dDate ))
IF nPos <> 0
	Return( aDataBra[nPos])
EndIF
Return ''

Proc RecebidoCx( cCaixa, cCodiVen, dIni, dFim )
***********************************************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen()
LOCAL Tam		  := 80
LOCAL Col		  := 58
LOCAL Pagina	  := 0
LOCAL nDifVlr	  := 0
LOCAL nSomaDoc   := 0
LOCAL nDifDoc	  := 0
LOCAL nVlrFatura := 0
LOCAL nReceber   := 0
LOCAL nSomaItens := 0
LOCAL nQtd		  := 0
LOCAL nChoice	  := 0
LOCAL nTipo 	  := 0
LOCAL nPeriodo   := 0
LOCAL xFatura	  := Space(07)
LOCAL aPreco	  := {}
LOCAL dBaixa
LOCAL cCodigo
LOCAL oBloco
LOCAL Handle
LOCAL cFatura
LOCAL nMaximo
LOCAL nLen

oMenu:Limpa()
IF cCaixa = NIL .OR. cCodiven = NIL .OR. dIni = NIL .OR. dFim = NIL
	IF !UsaArquivo("CHEQUE")
		MensFecha()
		Return
	EndIF
	IF !UsaArquivo("VENDEDOR")
		MensFecha()
		Return
	EndIF
	IF !UsaArquivo("RECEBIDO")
		MensFecha()
		Return
	EndIF
	IF !UsaArquivo("CHEMOV")
		MensFecha()
		Return
	EndIF
	IF !UsaArquivo("RECEBER")
		MensFecha()
		Return
	EndIF
	cCaixa	:= Space(4)
	cCodiVen := Space(4)
	dIni		:= Date()-30
	dFim		:= Date()-30
	MaBox( 10, 10, 15, 79 )
	@ 11, 11 Say  "Conta Caixa....:" Get cCaixa   Pict "9999" Valid CheErrado( @cCaixa )
	@ 12, 11 Say  "Vendedor/Caixa.:" Get cCodiven Pict "9999" Valid FunErrado( @cCodiven,, Row(), Col()+1 )
	@ 13, 11 Say  "Data Inicial...:" Get dIni     Pict "##/##/##"
	@ 14, 11 Say  "Data Final.....:" Get dFim     Pict "##/##/##"
	Read
	IF LastKey() = ESC
		Return
	EndIF
	IF !Conf("Pergunta: Verificacao podera demorar. Continuar ?")
		Return
	EndIF
EndIF
Mensagem("Aguarde, SCI Processando Pesado.", Cor())
oBloco := {|| Recebido->Datapag >= dIni .AND. Recebido->DataPag <= dFim }
Cheque->( Order( CHEQUE_CODI ))
Receber->( Order( RECEBER_CODI ))
Chemov->( Order( CHEMOV_DOCNR ))
Recebido->(Order( RECEBIDO_DATAPAG ))
Set Soft On
Recebido->(DbSeek( dIni ))
Set Soft Off
MaBox( 10, 10, 12, 40 )
WHILE Eval( oBloco ) .AND. Rep_Ok()
	cDocnr	:= Recebido->Docnr
	nVlr		:= Recebido->VlrPag
	cFatura	:= Recebido->Fatura
	dData 	:= Recebido->DataPag
	cTipo 	:= Recebido->Tipo
	lIncluir := FALSO
	IF Chemov->(DbSeek( cDocnr ))
		Recebido->(DbSkip(1))
		Loop
	EndIF
	cCodi 	:= Recebido->Codi
	dAtu		:= Recebido->Atualizado
	dBaixa	:= Recebido->Baixa
	cHist 	:= "REC "
	nChSaldo := 0
	lIncluir := OK
	@ 11, 11 Say  "Documento....:" + cDocnr
	IF Receber->(DbSeek( cCodi ))
		cHist += Receber->Nome
	EndIF
	IF Cheque->(DbSeek( cCaixa ))
		nChSaldo := Cheque->Saldo
	EndIF
	IF Cheque->(DbSeek( cCaixa ))
		IF Cheque->(TravaReg())
			nChSaldo 	  := Cheque->Saldo
			nChSaldo 	  += nVlr
			Cheque->Saldo += nVlr
			Cheque->(Libera())
		EndIf
	EndIF
	IF Chemov->(Incluiu())
		Chemov->Codi		 := cCaixa
		Chemov->Docnr		 := cDocnr
		Chemov->Emis		 := dData
		Chemov->Data		 := dData
		Chemov->Hist		 := cHist
		Chemov->Saldo		 := nChSaldo
		Chemov->Cre 		 := nVlr
		Chemov->Tipo		 := cTipo
		Chemov->Fatura 	 := cFatura
		Chemov->Caixa		 := cCodiVen
		Chemov->Atualizado := dAtu
		Chemov->Baixa		 := dBaixa
		Chemov->(Libera())
	EndIF
	Recebido->(DbSkip(1))
EndDo
Return

Proc CarneTipo1()
*****************
LOCAL nDesconto := 0
LOCAL nMulta	 := 0
LOCAL nCarencia := 0
LOCAL nAtraso	 := 0
LOCAL nJuros	 := 0
LOCAL nJrDesc	 := 0
LOCAL nJrVlr	 := 0
FIELD Vcto
FIELD Vlr

PrintOn()
FPrInt( Chr(ESC) + "C" + Chr(22))
Fprint( PQ )
SetPrc( 0, 0 )
Write( 05, 36, Tran(oAmbiente:aSciArray[1,SCI_DESCONTO],'99.99%'))
Write( 05, 84, Tran(oAmbiente:aSciArray[1,SCI_DESCONTO],'99.99%'))
Write( 06, 21, Trim(Str(oAmbiente:aSciArray[1,DIASAPOS])))
Write( 06, 41, Tran(oAmbiente:aSciArray[1,SCI_DESCAPOS],'99.99%'))
Write( 06, 69, Trim(Str(oAmbiente:aSciArray[1,DIASAPOS])))
Write( 06, 89, Tran(oAmbiente:aSciArray[1,SCI_DESCAPOS],'99.99%'))
Write( 09, 13, Receber->Codi)
Write( 09, 34, Trim( Recemov->Tipo ) + '-' + Recemov->Docnr)
Write( 09, 60, Receber->Codi)
Write( 09, 82, Trim( Recemov->Tipo ) + '-' + Recemov->Docnr)
Write( 11, 08, Receber->Nome)
Write( 11, 55, Receber->Nome)
Write( 12, 16, Recemov->Emis)
Write( 12, 40, Recemov->Vcto)
Write( 12, 63, Recemov->Emis)
Write( 12, 88, Recemov->Vcto)

nAtraso	 := Atraso( Date(), Recemov->Vcto )
nDesconto := VlrDesconto( Date(), Recemov->Vcto, Recemov->Vlr )
nMulta	 := VlrMulta( Date(), Recemov->Vcto, Recemov->Vlr )
nCarencia := Carencia( Date(), Recemov->Vcto )
IF nAtraso <= 0
	nJuros := 0
Else
	nJuros := Recemov->Jurodia * nCarencia
EndIF
nJrDesc	 := Tran(( nJuros + nMulta ) - nDesconto,  "@E 9,999,999.99")
nJrVlr	 := Tran((( nJuros + Recemov->Vlr ) + nMulta ) - nDesconto,  "@E 9,999,999.99")
Write( 13, 13, Recemov->Vlr)
//Write( 13, 36, nJrDesc )
Write( 13, 60, Recemov->Vlr)
//Write( 13, 84, nJrDesc )
//Write( 14, 14, nJrVlr )
//Write( 14, 40, Date() )
//Write( 14, 61, nJrVlr )
//Write( 14, 88, Date() )
//WriteCodeBar( Recemov->Docnr )
__Eject()
PrintOff()
Return

Proc CarneTipo2()
*****************
LOCAL nDesconto := 0
LOCAL nMulta	 := 0
LOCAL nCarencia := 0
LOCAL nAtraso	 := 0
LOCAL nJuros	 := 0
LOCAL nJrDesc	 := 0
LOCAL nJrVlr	 := 0
FIELD Vcto
FIELD Vlr

PrintOn()
FPrInt( Chr(ESC) + "C" + Chr(22))
Fprint( PQ )
SetPrc( 0, 0 )
Write( 05, 36, Tran(oAmbiente:aSciArray[1,SCI_DESCONTO],'99.99%'))
Write( 05, 84, Tran(oAmbiente:aSciArray[1,SCI_DESCONTO],'99.99%'))

Write( 06, 21, Trim(Str(oAmbiente:aSciArray[1,DIASAPOS])))
Write( 06, 41, Tran(oAmbiente:aSciArray[1,SCI_DESCAPOS],'99.99%'))
Write( 06, 69, Trim(Str(oAmbiente:aSciArray[1,DIASAPOS])))
Write( 06, 89, Tran(oAmbiente:aSciArray[1,SCI_DESCAPOS],'99.99%'))

Write( 09, 13, Receber->Codi)
Write( 09, 34, Trim( Recemov->Tipo ) + '-' + Recemov->Docnr)
Write( 09, 60, Receber->Codi)
Write( 09, 82, Trim( Recemov->Tipo ) + '-' + Recemov->Docnr)

Write( 11, 08, Receber->Nome)
Write( 11, 55, Receber->Nome)
Write( 12, 16, Recemov->Emis)
Write( 12, 40, Recemov->Vcto)
Write( 12, 63, Recemov->Emis)
Write( 12, 88, Recemov->Vcto)

nAtraso	 := Atraso( Date(), Recemov->Vcto )
nDesconto := VlrDesconto( Date(), Recemov->Vcto, Recemov->Vlr )
nMulta	 := VlrMulta( Date(), Recemov->Vcto, Recemov->Vlr )
nCarencia := Carencia( Date(), Recemov->Vcto )
IF nAtraso <= 0
	nJuros := 0
Else
	nJuros := Recemov->Jurodia * nCarencia
EndIF
nJrDesc	 := Tran(( nJuros + nMulta ) - nDesconto,  "@E 9,999,999.99")
nJrVlr	 := Tran((( nJuros + Recemov->Vlr ) + nMulta ) - nDesconto,  "@E 9,999,999.99")
Write( 13, 13, Recemov->Vlr)
Write( 13, 36, nJrDesc )
Write( 13, 60, Recemov->Vlr)
Write( 13, 84, nJrDesc )
Write( 14, 14, nJrVlr )
Write( 14, 40, Date() )
Write( 14, 61, nJrVlr )
Write( 14, 88, Date() )
//WriteCodeBar( Recemov->Docnr )
__Eject()
PrintOff()
Return

Function WriteCodebar( cBar )
*****************************
LOCAL nTipImp := 11
LOCAL nAncho  := 12
LOCAL cCodBar
LOCAL i

nTipImp := LD_TYP_EPSON9
SET DEVICE TO PRINTER
SET CONSOLE OFF
SET PRINTER ON
//cCodBar := LdEan13(ALLTRIM(cBar))
//cCodBar := LdUpc12(ALLTRIM(cBar))
//cCodBar := LdEan8(ALLTRIM(cBar))

/*
cCodBar	 := Ld39(ALLTRIM(cBar))
aRes		 := LdGenerate(nTipImp,cCodBar, nAncho, 1, 10)
*/

// hp_Cor_Des	:= CHR(27)+CHR(42)+CHR(114)+CHR(49)+CHR(85)
// hp_Cor		:= CHR(27)+CHR(42)+CHR(114)+CHR(45)+CHR(51)+CHR(85)
// hp_Azul		:= CHR(27)+CHR(42)+CHR(118)+'1'+CHR(83)
// ?? hp_cor + hp_azul
FOR i:=1 TO LEN(aRes)
	?? aRes[i]+spac(10)+ares[i]
END FOR
SET DEVICE TO SCREEN
SET PRINTER OFF
SET PRINTER TO
SET CONSOLE ON

Proc DupPapelBco( cCodi_Cli, aReg )
***********************************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen()
LOCAL _QtDup	  := 0

WHILE OK
	IF PCount() = 0
		cCodi_Cli := Space(05)
		aReg		 := {}
		aReg		 := EscolheTitulo( cCodi_Cli )
	EndIF
	IF ( _QtDup := Len( aReg )) = 0
		ResTela( cScreen )
		Return
	EndIF
	IF !InsTru80()
		ResTela( cScreen )
		Exit
	EndIF
	Receber->(Order( RECEBER_CODI ))
	Recemov->(Order( RECEMOV_CODI ))
	Area("Recemov")
	Set Rela To Codi Into Receber
	oMenu:Limpa()
	Mensagem("Aguarde, Imprimindo.", WARNING )
	PrintOn()
	FPrInt( Chr(ESC) + "C" + Chr(33))
	SetPrc( 0,0 )
	FOR i :=  1 TO _qtdup
		Recemov->(DbGoto( aReg[i] ))
		_DupPapelBco()
		__Eject()
	Next
	FPrInt( Chr( 27 )+ "C" + Chr( 66 ) )
	PrintOff()
	Recemov->(DbClearRel())
	Recemov->(DbGoTop())
	IF PCount() != 0
		ResTela( cScreen )
		Return
	EndIF
EndDo

Proc _DupPapelBco()
*******************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen()
LOCAL nRow		  := 0
LOCAL xcNomefir  := Padc( AllTrim(oAmbiente:xNomefir), 48 )
LOCAL xcRamo	  := Padc( CapFirst(XRAMO), 48 )
LOCAL xcCgc 	  := Padc( XCGCFIR, 19 )
LOCAL xcEnde	  := Padc( CapFirst(XENDEFIR), 48 )
LOCAL xcInsc	  := Padc( XINSCFIR, 16 )
LOCAL xcFone	  := Padc( CapFirst('TELEFAX ' + XFONE), 48 )
LOCAL xcCepCida  := Padc( XCCEP + '/' + CapFirst( XCCIDA ) + ' - ' + CapFirst( XCESTA ), 48 )
LOCAL xcTrabalho
LOCAL cEmis
LOCAL cVlrFatura
LOCAL cFatura
LOCAL cVlr
LOCAL cDocnr
LOCAL cVn
LOCAL cVd
LOCAL cVcto
LOCAL cDesc
LOCAL cLn1
LOCAL cJrd
LOCAL cNome
LOCAL cEnde
LOCAL cBair
LOCAL cCida
LOCAL cCep
LOCAL cEsta
LOCAL cCgc
LOCAL cRg
LOCAL nLarg
LOCAL nLinhas
LOCAL Vlr_Dup
LOCAL xStr

cEmis 	  := Padc( Dtoc( Recemov->Emis ), 11 )
cVlrFatura := Tran( Recemov->VlrFatu, '@E 9,999,999.99')
cFatura	  := Recemov->Fatura
cVlr		  := Tran( Recemov->Vlr, '@E 9,999,999.99')
cDocnr	  := Recemov->Docnr
cVn		  := Padc( cVlrFatura + Space(5) + cFatura, 23 )
cVd		  := Padc( cVlr		 + Space(5) + cDocnr, 28 )
cVcto 	  := Padc( Dtoc( Recemov->Vcto ), 13 )
cDesc 	  := Tran( VlrDesconto( Date(), Vcto, Recemov->Vlr ), '@E 999.99')
cLn1		  := Padc('Desconto de R$ ' + cDesc + ' Ate ' + cVcto + Space(16), 56 )
cJrd		  := Padr( Tran( JuroDia( Recemov->Vlr, Recemov->Juro ), '@E 999.99'), 11 )
cNome 	  := Padr( Receber->Nome,57 )
cEnde 	  := Padr( Receber->Ende,33 )
cCida 	  := Padr( Receber->Cida,33 )
cCep		  := Receber->Cep
cEsta 	  := Receber->Esta
cBair 	  := Left( Receber->Bair,16 )
cCgc		  := IF( Receber->(Empty( Cgc )) .OR. Receber->Cgc = "  .   .   /    -  ", Receber->Cpf, Receber->Cgc )
cRg		  := IF( Receber->(Empty( Cgc )) .OR. Receber->Cgc = "  .   .   /    -  ", Receber->Rg,  Receber->Insc )
cCgc		  := Padr( cCgc, 33 )
cRg		  := Padr( cRg, 16 )
xcTrabalho := Padr( Receber->Trabalho, 67 )

xStr       := 'portancia acima que pagarei(emos) a ' + AllTrim(oAmbiente:xNomefir) + '., ou a sua ordem na praca e vencimentos indicados.'
nLarg 	  := 60
nLinhas	  := 2
Vlr_Dup	  := Extenso( Recemov->Vlr, 1, nLinhas, nLarg )

Write(nRow+00, 0, 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿')
Write(nRow+01, 0, '³' + xcNomefir +                                '³Duplicata de Venda Mercantil ³')
Write(nRow+02, 0, '³' + xcRamo +                                   '³CGC(MF) : ' + xcCgc+        '³')
Write(nRow+03, 0, '³' + xcEnde +                                   '³I. ESTADUAL :' + xcInsc +   '³')
Write(nRow+04, 0, '³' + xcFone +                                   '³                             ³')
Write(nRow+05, 0, '³' + xcCepCida +                                '³DATA DE EMISSAO : '+ cEmis +'³')
Write(nRow+06, 0, 'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ´')
Write(nRow+07, 0, '³     F A T U R A       ³    D U P L I C A T A       ³ VENCIMENTO  ³Para Uso da³')
Write(nRow+08, 0, '³   Valor      Numero   ³   Valor      N§ de Ordem   ³             ³Inst. Fin. ³')
Write(nRow+09, 0, '³' + NG + cVn +NR +             '³' + NG + cVd + NR +                 '³' + NG + cVcto + NR + '³           ³')
Write(nRow+10, 0, 'ÃÄÄÄÄÄÂÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄ´           ³')
Write(nRow+11, 0, '³     ³A  ³' + cLn1 +                                             '³           ³')
Write(nRow+12, 0, '³     ³S  ³Condicoes Especiais          Juros p/ Dia R$:' + cJrd +'³           ³')
Write(nRow+13, 0, '³     ³S  ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´')
Write(nRow+14, 0, '³     ³   ³Sacado....:' + NG + cNome + NR +                                   '³')
Write(nRow+15, 0, '³     ³d  ³Endereco..:' + cEnde +                     'Bairro :'+ cBair +     '³')
Write(nRow+16, 0, '³     ³o  ³Municipio.:' + cCida +                     'Cep    :'+cCep+' Uf:'+cEsta+' ³')
Write(nRow+17, 0, '³     ³   ³Praca Pgto:' + cCida +                     'Cep    :'+cCep+' Uf:'+cEsta+' ³')
Write(nRow+18, 0, '³     ³E  ³Cnpj/Cpf..:' + cCgc  +                     'I.E/Rg.:' + cRg +      '³')
Write(nRow+19, 0, '³     ³m  ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
Write(nRow+20, 0, '³     ³i  ³Valor   ' + Left( Vlr_Dup, nLarg ) +                               '³')
Write(nRow+21, 0, '³     ³t  ³Extenso ' + Right( Vlr_Dup, nLarg ) +                              '³')
Write(nRow+22, 0, '³     ³e  ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
Write(nRow+23, 0, '³     ³n  ³Reconheco(emos) a exatidao desta DUPLICATA DE VENDA MERCANTIL da im-³')
Write(nRow+24, 0, '³     ³t  ³' + Left(xStr,68) +                                                '³')
Write(nRow+25, 0, '³     ³e  ³' + Padr( Substr(xStr, 69, Len(xStr)),68) +                        '³')
Write(nRow+26, 0, 'ÃÄÄÄÄÄÁÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
Write(nRow+27, 0, '³TRABALHO : ' + xcTrabalho +                                                    '³')
Write(nRow+28, 0, '³Data do Aceite : ___/___/_____               ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ ³')
Write(nRow+29, 0, '³                                                  Assinatura do Sacado        ³')
Write(nRow+30, 0, 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ')
Return

Function SomaReq( yPar, xPar, aQuant, aUnitario, aTotal, nGeral )
*****************************************************************
LOCAL nConta := Len( aQuant )
LOCAL nX

IF LastKey() = UP
	Return( OK )
EndIF

IF yPar <> 0 .AND. xPar <= 0
	ErrorBeep()
	Alerta('Erro: Valor Invalido.')
	Return( FALSO )
EndIF
nGeral := 0
For nX := 1 To nConta
	aTotal[nX] := aQuant[nX] * aUnitario[nX]
	nGeral	  += aTotal[nX]
Next
Write( 15, 68, Tran( nGeral, "999999.99"))
Return( OK )

Proc Requisicao( cCaixa )
*************************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen()
LOCAL xcNomefir  := Padc( AllTrim(oAmbiente:xNomefir), 48 )
LOCAL xcRamo	  := Padc( CapFirst(XRAMO), 48 )
LOCAL xcEnde	  := Padc( CapFirst(XENDEFIR), 48 )
LOCAL xcFone	  := Padc( CapFirst('TELEFAX ' + XFONE), 48 )
LOCAL xcCepCida  := Padc( XCCEP + '/' + CapFirst( XCCIDA ) + ' - ' + CapFirst( XCESTA ), 48 )
LOCAL cEmis
LOCAL cVcto
LOCAL cVlrFatura
LOCAL cNome
LOCAL cHist
LOCAL cCodi
LOCAL cDocnr
LOCAL dEmis
LOCAL dVcto
LOCAL cObs1
LOCAL cObs2
LOCAL cCodiCx
LOCAL cCodiCx1
LOCAL cCodiCx2
LOCAL cDc
LOCAL cDc1
LOCAL cDc2
LOCAL nRow
LOCAL nCol
LOCAL xCol
LOCAL yCol
LOCAL aQuant
LOCAL aUn
LOCAL aDescricao
LOCAL aUnitario
LOCAL aTotal
LOCAL nGeral
LOCAL nY
LOCAL cExtenso

WHILE OK
	oMenu:Limpa()
	cCodi 	  := Space(04)
	cDocnr	  := Space( 09 )
	dEmis 	  := Date()
	dVcto 	  := ( Date() + 30 )
	cObs1 	  := Space(40)
	cObs2 	  := Space(40)
	nRow		  := 02
	xCol		  := 40
	yCol		  := 28
	nCol		  := 03
	aQuant	  := Array(6) ; Afill( aQuant, 0 )
	aUn		  := Array(6) ; Afill( aUn, 'UN')
	aDescricao := Array(6) ; Afill( aDescricao, Space(40))
	aUnitario  := Array(6) ; Afill( aUnitario, 0 )
	aTotal	  := Array(6) ; Afill( aTotal, 0 )
	nGeral	  := 0
	cCodiCx	  := Space(04)
	cCodiCx1   := Space(04)
	cCodiCx2   := Space(04)
	cDc		  := 'D'
	cDc1		  := 'D'
	cDc2		  := 'D'
	MaBox( 01, 02, 10, 77 )
	@ nRow,	  nCol Say "Codigo Fornecedor.:" Get cCodi  Pict "9999"     Valid Pagarrado( @cCodi, Row(), Col()+1 )
	@ Row()+1, nCol Say "Documento N§......:" Get cDocnr Pict "@K!"      Valid PgDocCerto( @cDocnr )
	@ Row()+1, nCol Say "Emissao...........:" Get dEmis  Pict "##/##/##"
	@ Row(),   xCol Say "Vencimento.:"        Get dVcto  Pict "##/##/##" Valid dDataVer( dEmis, dVcto )
	@ Row()+1, nCol Say "A ser utilizado em:" Get cObs1  Pict "@!"
	@ Row()+1, nCol Say "Ao Portador Sr(a).:" Get cObs2  Pict "@!"
	@ Row()+1, nCol Say "C. Partida........:" Get cCodiCx  Pict "9999" Valid CheErrado( @cCodiCx,, Row(), 36)
	@ Row(),   yCol Say "D/C.:"               Get cDc      Pict "!"    Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc )
	@ Row()+1, nCol Say "C. Partida........:" Get cCodiCx1 Pict "9999" Valid CheErrado( @cCodiCx1,, Row(), 36, OK )
	@ Row(),   yCol Say "D/C.:"               Get cDc1     Pict "!"    Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc1 )
	@ Row()+1, nCol Say "C. Partida........:" Get cCodiCx2 Pict "9999" Valid CheErrado( @cCodiCx2,, Row(), 36, OK )
	@ Row(),   yCol Say "D/C.:"               Get cDc2     Pict "!"    Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc2 )
	Read
	IF LastKey() = ESC
		ErrorBeep()
		IF Conf('Pergunta: Cancelar ?')
			Return
		EndIF
		Loop
	EndIF
	MaBox( 11, 02, 18, 77, 'SQ QUANT  UN DESCRICAO                                UNITARIO       TOTAL ')
	nRow		  := 11
	nCol		  := 03
	For nY := 1 To 6
		@ nRow+nY, 03 Say StrZero(nY,2)
		@ nRow+nY, 06 Get aQuant[nY]		Pict "999.99"
		@ nRow+nY, 13 Get aUn[nY]			Pict "@!"
		@ nRow+nY, 16 Get aDescricao[nY] Pict "@!"
		@ nRow+nY, 57 Get aUnitario[nY]	Pict "99999.99" Valid SomaReq( aQuant[nY], aUnitario[nY], aQuant, aUnitario, aTotal, @nGeral)
		@ nRow+nY, 68 Get aTotal[nY]		Pict "999999.99" When Empty( aUnitario[nY])
		Read
		IF LastKey() = ESC
			ErrorBeep()
			IF Conf('Pergunta: Cancelar ?')
				Return
			EndIF
			Loop
		EndIF
		IF aQuant[nY] <= 0
			IF nGeral <= 0
				ErrorBeep()
				IF Conf('Pergunta: Cancelar ?')
					Return
				Else
					Loop
				EndIF
			EndIF
			Exit
		EndIF
	Next nY
	ErrorBeep()
	IF nGeral <= 0
		Alerta('Informa: Nada a Lancar. Cancelando...')
		Loop
	EndIF
	IF Conf('Pergunta: Confirma Inclusao do Registro ?')
		IF Pagamov->(Incluiu())
			Pagamov->Codi		  := cCodi
			Pagamov->Docnr 	  := cDocnr
			Pagamov->Emis		  := dEmis
			Pagamov->Vcto		  := dVcto
			Pagamov->Vlr		  := nGeral
			Pagamov->Port		  := 'CARTEIRA'
			Pagamov->Tipo		  := 'RQ'
			Pagamov->JuroDia	  := JuroDia( nGeral, 10 )
			Pagamov->Juro		  := 10
			Pagamov->Fatura	  := cDocnr
			Pagamov->VlrFatu	  := nGeral
			Pagamov->Obs1		  := cObs1
			Pagamov->Obs2		  := cObs2
			Pagamov->Atualizado := Date()
			Pagamov->(Libera())

			cHist := 'RQ ' + Pagar->Nome
			IF Cheque->(DbSeek( cCodiCx )) .OR. !Empty( cCodiCx )
				IF Cheque->(TravaReg())
					nChSaldo := Cheque->Saldo
					IF Chemov->(Incluiu())
						IF cDc = "C"
							nChSaldo 	  += nGeral
							Cheque->Saldo += nGeral
							Chemov->Cre   := nGeral
						Else
							nChSaldo 	  -= nGeral
							Cheque->Saldo -= nGeral
							Chemov->Deb   := nGeral
						EndIF
						Chemov->Codi	:= cCodiCx
						Chemov->Docnr	:= cDocnr
						Chemov->Emis	:= Date()
						Chemov->Data	:= Date()
						Chemov->Baixa	:= Date()
						Chemov->Hist	:= cHist
						Chemov->Saldo	:= nChSaldo
						Chemov->Tipo	:= 'RQ'
						Chemov->Caixa	:= IF( cCaixa = Nil, Space(4), cCaixa )
						Chemov->Fatura := cDocnr
					EndIF
					Chemov->(Libera())
				EndIF
				Cheque->(Libera())
			EndIF
			*:-------------------------------------------------------
			IF Cheque->(DbSeek( cCodiCx1 )) .OR. !Empty( cCodiCx1 )
				IF Cheque->(TravaReg())
					nChSaldo := Cheque->Saldo
					IF Chemov->(Incluiu())
						IF cDc1 = "C"
							nChSaldo 	  += nGeral
							Cheque->Saldo += nGeral
							Chemov->Cre   := nGeral
						Else
							nChSaldo 	  -= nGeral
							Cheque->Saldo -= nGeral
							Chemov->Deb   := nGeral
						EndIF
						Chemov->Codi	:= cCodiCx1
						Chemov->Docnr	:= cDocnr
						Chemov->Emis	:= Date()
						Chemov->Data	:= Date()
						Chemov->Baixa	:= Date()
						Chemov->Hist	:= cHist
						Chemov->Saldo	:= nChSaldo
						Chemov->Tipo	:= 'RQ'
						Chemov->Caixa	:= IF( cCaixa = Nil, Space(4), cCaixa )
						Chemov->Fatura := cDocnr
					EndIF
					Chemov->(Libera())
				EndIF
				Cheque->(Libera())
			EndIF
			*:-------------------------------------------------------
			IF Cheque->(DbSeek( cCodiCx2 )) .OR. !Empty( cCodiCx2 )
				IF Cheque->(TravaReg())
					nChSaldo := Cheque->Saldo
					IF Chemov->(Incluiu())
						IF cDc2 = "C"
							nChSaldo 	  += nGeral
							Cheque->Saldo += nGeral
							Chemov->Cre   := nGeral
						Else
							nChSaldo 	  -= nGeral
							Cheque->Saldo -= nGeral
							Chemov->Deb   := nGeral
						EndIF
						Chemov->Codi	:= cCodiCx2
						Chemov->Docnr	:= cDocnr
						Chemov->Emis	:= Date()
						Chemov->Data	:= Date()
						Chemov->Baixa	:= Date()
						Chemov->Hist	:= cHist
						Chemov->Saldo	:= nChSaldo
						Chemov->Tipo	:= 'RQ'
						Chemov->Caixa	:= IF( cCaixa = Nil, Space(4), cCaixa )
						Chemov->Fatura := cDocnr
					EndIF
					Chemov->(Libera())
				EndIF
				Cheque->(Libera())
			EndIF

			cEmis 	  := Padc( Dtoc( dEmis ), 11 )
			cDocnr	  := Padc( cDocnr, 16 )
			xcNome	  := Padc( Pagar->Nome, 40 )
			xcObs1	  := Padc( cObs1, 40 )
			xcObs2	  := Padc( cObs2, 40 )
			cVcto 	  := Padc( Dtoc( dVcto ), 11 )
			cVlrFatura := Tran( nGeral, '@E 999,999.99')
			cExtenso   := Extenso( nGeral, 1, 3, 78 )
			IF !InsTru80()
				ResTela( cScreen )
				Loop
			EndIF
			oMenu:Limpa()
			Mensagem("Aguarde, Imprimindo.")
			PrintOn()
			FPrInt( Chr(ESC) + "C" + Chr(33))
			SetPrc( 0,0 )
			nRow := 0
			Write(nRow+00, 0, 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿')
			Write(nRow+01, 0, '³' + xcNomefir +                                '³  R E Q U I S I S I C A O    ³')
			Write(nRow+02, 0, '³' + xcRamo +                                   '³                             ³')
			Write(nRow+03, 0, '³' + xcEnde +                                   '³         N§ :' + cDocnr +   '³')
			Write(nRow+04, 0, '³' + xcFone +                                   '³                             ³')
			Write(nRow+05, 0, '³' + xcCepCida +                                '³DATA DE EMISSAO : '+ cEmis +'³')
			Write(nRow+06, 0, 'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
			Write(nRow+07, 0, '³Fornecedor   :' + xcNome + '                        ³')
			Write(nRow+08, 0, '³Utilizado em :' + xcObs1 + '                        ³')
			Write(nRow+09, 0, '³Portador     :' + xcObs2 + '                        ³')
			Write(nRow+10, 0, 'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
			Write(nRow+11, 0, '³SQ  QUANT               DESCRIMINACAO                 UNITARIO        TOTAL   ³')
			Write(nRow+12, 0, 'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
			nConta := Len( aQuant )
			nRow	 := 12
			nGeral := 0
			For nZ := 1 To nConta
				IF aQuant[nZ] <= 0
					Exit
				EndIF
				nRow ++
				nGeral += aTotal[nZ]
				Write(nRow, 0, '³' + StrZero( nZ, 02 ) + Space(01) + ;
				Tran( aQuant[nZ], 	 '999.99') + Space(01) + ;
				Ponto( aDescricao[nZ], 40 ) + Space(02) + ;
				Tran( aUnitario[nZ], '@E 99,999.99') + Space(03) + ;
				Tran( aTotal[nZ], 	'@E 999,999.99') + Space(04) + '³')
			Next
			nConta := nRow
			For nZ := nConta To 17
				Write(++nRow, 0, '³                                                                              ³')
			Next
			Write(++nRow, 0, '³' + Left( cExtenso, 78 ) + '³')
			Write(++nRow, 0, '³' + SubStr( cExtenso, 79, 78 ) + '³')
			Write(++nRow, 0, '³' + Right( cExtenso, 78 ) + '³')
			Write(++nRow, 0, 'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
			Write(++nRow, 0, '³OBS: Somente pagaremos o que estiver na requisicao nao         ³ ' + Tran( nGeral, '@E 99,999.99') + '    ³')
			Write(++nRow, 0, '³     sendo o uso para outras mercadorias ou fornecedor         ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´')
			Write(++nRow, 0, '³                                                                              ³')
			Write(++nRow, 0, '³                                                                              ³')
			Write(++nRow, 0, '³________________________   ___________________________                        ³')
			Write(++nRow, 0, '³    Ass. Autorizado               Ass. Portador           VENCTO : '+ cVcto +'³')
			Write(++nRow, 0, 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ')
			__Eject()
			FPrInt( Chr( 27 )+ "C" + Chr( 66 ) )
			PrintOff()
		EndIF
	EndIF
EndDo
Return


