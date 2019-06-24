/*
  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 İ³																								 ³
 İ³	Modulo.......: PAGALAN.PRG		   												 ³
 İ³	Sistema......: CONTROLE DE CONTAS A PAGAR						             ³ 
 İ³	Aplicacao....: SCI - SISTEMA COMERCIAL INTEGRADO                      ³
 İ³	Versao.......: 8.5.00							                            ³
 İ³	Programador..: Vilmar Catafesta				                            ³
 İ³   Empresa......: Macrosoft Informatica Ltda                             ³
 İ³	Inicio.......: 12.11.1991 						                            ³
 İ³   Ult.Atual....: 12.04.2018                                             ³
 İ³   Compilador...: Harbour 3.2/3.4                                        ³
 İ³   Linker.......: BCC/GCC/MSCV                                           ³
 İ³	Bibliotecas..:  									                            ³
 İÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

#include <sci.ch>

Proc PagaLan()
**************
LOCAL Op        := 1
LOCAL lOk		 := OK
LOCAL cCaixa	 := Space(04)
LOCAL cVendedor := Space(40)
*:==================================================================================================================================
SetKey( F5, 		  {|| PagarDbEdit()})
SetKey( F10,		  {|| Calc()})
SetKey( F8, 		  {|| AcionaSpooler()})
SetKey( 23, 		  {|| GravaDisco()})
SetKey( TECLA_ALTC, {|| Altc()})
AbreArea()
oMenu:Limpa()
if !VerSenha( @cCaixa, @cVendedor )
	Mensagem("Aguarde, Fechando Arquivos." )
	DbCloseAll()
	Set KEY F2 TO
	Set KEY F3 TO
	return
endif
*:==========================================================================================================================
Op := 1
RefreshClasse()
WHILE lOk
	Begin Sequence
		Op 		  := oMenu:Show()
		Do Case
		Case Op = 0.0 .OR. Op = 1.01
			ErrorBeep()
			if Conf("Pergunta: Encerrar este modulo ?")
				GravaDisco()
				lOk := FALSO
				Break
			endif

		Case Op = 2.01
			if PodeIncluir()
				ForInclusao()
			endif

		Case Op = 2.02
			if PodeAlterar()
				ForAlteracao( 2 )
			endif

		Case Op = 2.03
			if PodeExcluir()
				ForAlteracao( 3 )
			endif

		Case Op = 2.04
			ForAlteracao( 4 )

		Case Op = 2.05
			PagarDbedit()

		Case Op = 2.06
			PagarDbedit()

		Case Op = 2.07
			PagarDbedit()

		Case Op = 3.01
			if PodeIncluir()
				Paga21()
			endif

		Case Op = 3.02
			if PodePagar()
				Paga22( cCaixa )
			endif

		Case Op = 3.03
			if PodeAlterar()
				PagaAltera()
			endif

		Case Op = 3.04
			if PodeExcluir()
				Paga24()
			endif

		Case Op = 3.05
			Requisicao(cCaixa)

		Case Op = 4.01
			RelFornecedor()

		Case Op = 4.02
			TituloAPagar()

		Case Op = 4.03
			PagosTitulos()

		Case Op = 4.04
			Paga35()

		Case Op = 5.01
			Paga5()

		Case Op = 5.02
			Pagos()

		Case Op = 6.01
			PagaPosi(1)

		Case Op = 6.02
			PagaPosi(2)

		Case Op = 6.03
			PagaPosi(4)

		Case Op = 6.04
			PagaPosi(3)

		Case Op = 6.06
			PagoPago( 1 )

		Case Op = 6.07
			PagoPago( 2 )

		Case Op = 6.08
			PagoPago( 3 )

		Case Op = 6.10
			PagarPago()

		Case Op = 6.11
			PagaGrafico()

		Case op = 7.01 ; CepInclusao()
		Case op = 7.02 ; MudaCep()
		Case op = 7.03 ; MudaCep()
		Case op = 7.04 ; MudaCep()
		Case op = 7.05 ; CepPrint()
		EndCase
	End Sequence
EndDo
Mensagem("Aguarde, Fechando Arquivos.", WARNING, _LIN_MSG )
FechaTudo()
return

STATIC Proc RefreshClasse()
***************************
oMenu:StatusSup      := oMenu:StSupArray[4]
oMenu:StatusInf      := oMenu:StInfArray[4]
oMenu:Menu           := oMenu:MenuArray[4]
oMenu:Disp           := oMenu:DispArray[4]
return

*:==================================================================================================================================

Proc PagaGrafico()
******************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL aMenu   := {"Individual", "Geral"}
LOCAL nChoice

WHILE OK
	oMenu:Limpa()
	M_Title("GRAFICOS DE CONTAS A PAGAR" )
	nChoice := FazMenu( 07, 10, aMenu, Cor())
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1
		Area("Pagar")
		Pagar->(Order( PAGAR_CODI ))
		cCodi := Space( 04 )
		MaBox( 13, 10, 15, 79 )
		@ 14, 11 Say "Codigo....: " Get cCodi Pict "9999" Valid Pagarrado( @cCodi, Row(), Col()+5 )
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		GraficoCodigo( cCodi )

	Case nChoice = 2
		GraficoGeral()

	EndCase
EndDo

Function Pagarrado( cCodi, nRow, nCol, cSigla )
*********************************************
LOCAL aRotina			  := {{|| ForInclusao() }}
LOCAL aRotinaAlteracao := {{|| ForInclusao( OK )}}
LOCAL cScreen			  := SaveScreen()
LOCAL Ind_Ant			  := IndexOrd()
LOCAL Arq_Ant			  := Alias()
FIELD Codi
FIELD Nome

Pagar->(Order( PAGAR_CODI ))
if Pagar->(!DbSeek( cCodi ))
	Pagar->(Order( PAGAR_NOME ))
	Pagar->(Escolhe( 03, 01, 22,"Codi + 'İ' + Nome + 'İ' + Sigla + 'İ' + Fone", "CODI NOME FORNECEDOR                          SIGLA      TELEFONE", aRotina,, aRotinaAlteracao ))
endif
cCodi := if( Len( cCodi ) = 4, Pagar->Codi, Pagar->Nome )
if nRow != Nil
	Write( nRow, nCol, Pagar->Nome )
	cSigla := Pagar->Sigla
endif
AreaAnt( Arq_Ant, Ind_Ant )
return(OK)


Proc GraficoGeral()
*******************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL cAno		:= Space(02)
LOCAL aDataIni
LOCAL aDataFim
LOCAL nConta
LOCAL M[12,2]

Area("PagaMov")
Pagamov->(Order( PAGAMOV_VCTO ))
Pagamov->(DbGoTop())
MaBox( 16, 10, 18, 45 )
@ 17, 11 Say "Entre o ano para Grafico...:" Get cAno Pict "99"
Read
if LastKey() = ESC
	Restela( cScreen )
	return
endif
aDataIni := { Ctod( "01/01/" + cAno ), Ctod( "01/02/" + cAno ),;
				  Ctod( "01/03/" + cAno ), Ctod( "01/04/" + cAno ),;
				  Ctod( "01/05/" + cAno ), Ctod( "01/06/" + cAno ),;
				  Ctod( "01/07/" + cAno ), Ctod( "01/08/" + cAno ),;
				  Ctod( "01/09/" + cAno ), Ctod( "01/10/" + cAno ),;
				  Ctod( "01/11/" + cAno ), Ctod( "01/12/" + cAno )}

aDataFim := { Ctod( "31/01/" + cAno ), Ctod( "28/02/" + cAno ),;
				  Ctod( "31/03/" + cAno ), Ctod( "30/04/" + cAno ),;
				  Ctod( "31/05/" + cAno ), Ctod( "30/06/" + cAno ),;
				  Ctod( "31/07/" + cAno ), Ctod( "31/08/" + cAno ),;
				  Ctod( "30/09/" + cAno ), Ctod( "31/10/" + cAno ),;
				  Ctod( "30/11/" + cAno ), Ctod( "31/12/" + cAno )}

Mensagem( "Aguarde, Calculando Valores.")
Area("Pagamov")
Pagamov->(Order( PAGAMOV_VCTO ))
Pagamov->(DbGoTop())
For nX := 1 To 12
	Sum Vlr To M[nX,1] For Vcto >= aDataIni[nX] .AND. Vcto <= aDataFim[nX]
	m[nX,2] := Upper(Left(Mes(nX),3))
Next
SetColor("")
Cls
Grafico( M, OK, "EVOLUCAO MENSAL DE TITULOS A PAGAR - " + cAno, "EM MILHARES", XNOMEFIR, 1000 )
Inkey(0)
ResTela( cScreen )
return

Proc GraficoCodigo( cCodi )
***************************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL cAno		:= Space(02)
LOCAL aDataIni
LOCAL aDataFim
LOCAL nConta
LOCAL M[12,2]
LOCAL cNome

MaBox( 16, 10, 18, 45 )
@ 17, 11 Say "Entre o ano para Grafico...:" Get cAno Pict "99"
Read
if LastKey() = ESC
	Restela( cScreen )
	return
endif
oMenu:Limpa()
aDataIni := { Ctod( "01/01/" + cAno ), Ctod( "01/02/" + cAno ),;
				  Ctod( "01/03/" + cAno ), Ctod( "01/04/" + cAno ),;
				  Ctod( "01/05/" + cAno ), Ctod( "01/06/" + cAno ),;
				  Ctod( "01/07/" + cAno ), Ctod( "01/08/" + cAno ),;
				  Ctod( "01/09/" + cAno ), Ctod( "01/10/" + cAno ),;
				  Ctod( "01/11/" + cAno ), Ctod( "01/12/" + cAno )}

aDataFim := { Ctod( "31/01/" + cAno ), Ctod( "28/02/" + cAno ),;
				  Ctod( "31/03/" + cAno ), Ctod( "30/04/" + cAno ),;
				  Ctod( "31/05/" + cAno ), Ctod( "30/06/" + cAno ),;
				  Ctod( "31/07/" + cAno ), Ctod( "31/08/" + cAno ),;
				  Ctod( "30/09/" + cAno ), Ctod( "31/10/" + cAno ),;
				  Ctod( "30/11/" + cAno ), Ctod( "31/12/" + cAno )}

Mensagem( "Aguarde, Calculando Valores.", Cor())
Area("Pagamov")
Pagamov->(Order( PAGAMOV_CODI_VCTO ))
Pagamov->(DbGoTop())
For nX := 1 To 12
	Sum Vlr To M[nX,1] For Vcto >= aDataIni[nX] .AND. Vcto <= aDataFim[nX] .AND. Codi = cCodi
	m[nX,2] := Upper(Left(Mes(nX),3))
Next
SetColor("")
Cls
cNome := Pagar->( AllTrim( Nome ) )
Grafico( M, OK, "EVOLUCAO MENSAL DE TITULOS A PAGAR - " + cNome,"EM MILHARES", XNOMEFIR, 1000 )
Inkey(0)
ResTela( cScreen )
return

Proc Paga5()
************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen()
LOCAL aMenuArray := { "Individual", "Geral"}
LOCAL xAlias	  := FTempName("TESTE.TMP")
LOCAL nChoice	  := 0
LOCAL cCodi 	  := Space(04)
LOCAL dIni		  := Date()
LOCAL dFim		  := Date()+30
LOCAL Tot_Juros  := 0
LOCAL Tot_Geral  := 0
LOCAL nConta	  := 0
LOCAL nAtraso	  := 0
LOCAL nJuroDia   := 0
LOCAL nField	  := 0
LOCAL bBloco
LOCAL bCodi
LOCAL bPeriodo
LOCAL bVencido
LOCAL cTela
FIELD Codi

oMenu:Limpa()
WHILE OK
	M_Title("CONSULTAR TITULOS A PAGAR" )
	nChoice := FazMenu( 05, 10, aMenuArray, Cor())
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1
		Area("Pagar" )
		Pagar->( Order( PAGAR_CODI ))
		cCodi 	 := Space( 04 )
		dFim		 := Date()
		dIni		 := dFim - 30
		Tot_Juros := 0
		Tot_Geral := 0
		nConta	 := 0
		MaBox( 11, 10, 15, 75 )
		@ 12, 11 Say "Fornecedor...:" Get cCodi Pict "@!" Valid PagaRrado( @cCodi, Row(), Col()+1 )
		@ 13, 11 Say "Data Inicial.:" Get dIni Pict "##/##/##"
		@ 14, 11 Say "Data Final...:" Get dFim Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Area( "Pagamov" )
		Pagamov->(Order( PAGAMOV_CODI ))
		oMenu:Limpa()
		if !DbSeek( cCodi )
			Nada()
			ResTela( cScreen )
			Loop
		endif
		Copy Stru To ( xAlias )
		Use ( xAlias ) Exclusive Alias xTemp New
		bCodi 	:= {|| Pagamov->Codi = cCodi }
		bPeriodo := {| dVcto | dVcto >= dIni .AND. dVcto <= dFim }
		bVencido := {| dVcto | dVcto < Date() }
		cTela 	:= Mensagem("Aguarde, Processando.", Cor())
		WHILE Eval( bCodi ) .AND. Rep_Ok()
			if Eval( bPeriodo, Pagamov->Vcto )
				nConta++
				Tot_Geral += Pagamov->Vlr
				if Eval( bVencido, Pagamov->Vcto )
					nAtraso	 := Atraso( Date(), Pagamov->Vcto )
					nJuroDia  := JuroDia( Pagamov->Vlr, Pagamov->Juro )
					Tot_Juros += ( nAtraso * nJuroDia )
				endif
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Pagamov->(FieldGet( nField ))))
				Next
			endif
			Pagamov->(DbSkip(1))
		EndDo
		xTemp->(DbGoTop())
		oMenu:Limpa()
		if nConta = 0
			Nada()
		else
			Paga45( Tot_Geral, Tot_Juros )
		endif
		xTemp->(DbCloseArea())
		Ferase( xAlias )

	Case nChoice = 2
		dFim		 := Date()
		dIni		 := dFim - 30
		nConta	 := 0
		Tot_Juros := 0
		Tot_Geral := 0
		MaBox( 11, 10, 14, 75 )
		@ 12, 11 Say "Data Inicial.:" Get dIni Pict "##/##/##"
		@ 13, 11 Say "Data Final...:" Get dFim Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Area( "PagaMov" )
		Pagamov->(Order( PAGAMOV_VCTO ))
		oMenu:Limpa()
		Set Soft On
		Pagamov->(DbSeek( dIni ))
		Set Soft Off
		Copy Stru To ( xAlias )
		Use ( xAlias ) Exclusive Alias xTemp New
		bBloco	:= {|| Pagamov->Vcto >= dIni .AND. Pagamov->Vcto <= dFim }
		bPeriodo := {| dVcto | dVcto >= dIni .AND. dVcto <= dFim }
		bVencido := {| dVcto | dVcto < Date() }
		cTela 	:= Mensagem("Aguarde, Processando.", Cor())
		WHILE Eval( bBloco ) .AND. Rep_Ok()
			if Eval( bPeriodo, Pagamov->Vcto )
				nConta++
				Tot_Geral += Pagamov->Vlr
				if Eval( bVencido, Pagamov->Vcto )
					nAtraso	 := Atraso( Date(), Pagamov->Vcto )
					nJuroDia  := JuroDia( Pagamov->Vlr, Pagamov->Juro )
					Tot_Juros += ( nAtraso * nJuroDia )
				endif
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Pagamov->(FieldGet( nField ))))
				Next
			endif
			Pagamov->(DbSkip(1))
		EndDo
		xTemp->(DbGoTop())
		oMenu:Limpa()
		if nConta = 0
			Nada()
		else
			Paga45( Tot_Geral, Tot_Juros )
		endif
		xTemp->(DbCloseArea())
		Ferase( xAlias )
	EndCase
EndDo
ResTela( cScreen )
return

Proc Pagos()
************
LOCAL cScreen	  := SaveScreen()
LOCAL aMenuArray := { "Individual", "Geral"}
LOCAL nConta	  := 0
LOCAL Tot_Geral  := 0
LOCAL Tot_Juros  := 0
LOCAL nChoice
LOCAL cCodi
LOCAL dIni
LOCAL dFim, cArquivo
FIELD Codi

oMenu:Limpa()
WHILE OK
	M_Title("CONSULTAR TITULOS PAGOS" )
	nChoice := FazMenu( 05, 10, aMenuArray, Cor())
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1
		cCodi 	  := Space( 04 )
		dFim		  := Date()
		dIni		  := dFim - 30
		Tot_Geral  := 0
		Tot_Juros  := 0
		MaBox( 11, 10, 15, 75 )
		@ 12, 11 Say "Fornecedor...:" Get cCodi Pict "@!" Valid PagaRrado( @cCodi, Row(), Col()+1 )
		@ 13, 11 Say "Data Inicial.:" Get dIni Pict "##/##/##"
		@ 14, 11 Say "Data Final...:" Get dFim Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Pagar->( Order( PAGAR_CODI ))
		Area( "Pago" )
		Pago->(Order( PAGO_CODI ))
		oMenu:Limpa()
		if !DbSeek( cCodi )
			ErrorBeep()
			Alerta("Nenhum Debito Pago deste Fornecedor...")
			ResTela( cScreen )
			Loop
		endif
		cArquivo := NovoArquivo()
		Copy Stru To ( cArquivo )
		Use (cArquivo) Exclusive New
		oBloco := {|| Pago->Codi = cCodi }
		cTela  := Mensagem(" Please, Aguarde Processando Registro " + StrZero( nConta, 5), Cor())
		WHILE Eval( oBloco ) .AND. Rep_Ok()
			if Pago->DataPag >= dIni .AND. Pago->DataPag <= dFim
				nConta++
				cTela  := Mensagem(" Please, Aguarde Processando Registro " + StrZero( nConta, 5), Cor())
				nRecno	 := Pago->(Recno())
				Tot_Geral += Pago->Vlr
				if Pago->Vcto < Date()
					Tot_Juros += ( Pago->VlrPag - Pago->Vlr )
				endif
			else
				Pago->(DbSkip(1))
				Loop
			endif
			Appe Reco nRecno From Pago
			Pago->(DbSkip(1))
		EnDdo
		Set Rela To Codi Into Pagar
		DbGoTop()
		ResTela( cTela )
		if nConta = 0
			ErrorBeep()
			Alerta("Nenhum Debito Pago neste Periodo...")
			ResTela( cScreen )
		else
			PagosDbedit( Tot_Geral, Tot_Juros )
		endif
		DbClearRel()
		DbCloseArea() // cArquivo
		Ferase( cArquivo )
		Area("Pago" )

	Case nChoice = 2
		dFim		  := Date()
		dIni		  := dFim - 30
		Tot_Geral  := 0
		Tot_Juros  := 0
		MaBox( 11, 10, 14, 75 )
		@ 12, 11 Say "Data Inicial.:" Get dIni Pict "##/##/##"
		@ 13, 11 Say "Data Final...:" Get dFim Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		oMenu:Limpa()
		Pagar->( Order( PAGAR_CODI ))
		Area( "Pago" )
		Pago->(Order( PAGO_DATAPAG ))
		Set Soft On
		Pago->(DbSeek( dIni ))
		Set Soft Off
		cArquivo := NovoArquivo()
		Copy Stru To ( cArquivo )
		Use (cArquivo) Exclusive New
		oBloco := {|| Pago->DataPag >= dIni .AND. Pago->DataPag <= dFim }
		cTela  := Mensagem(" Please, Aguarde Processando Registro " + StrZero( nConta, 5), Cor())
		WHILE Eval( oBloco ) .AND. Rep_Ok()
			if Pago->DataPag >= dIni .AND. Pago->DataPag <= dFim
				nConta++
				cTela  := Mensagem(" Please, Aguarde Processando Registro " + StrZero( nConta, 5), Cor())
				nRecno	 := Pago->(Recno())
				Tot_Geral += Pago->Vlr
				if Pago->Vcto < Date()
					Tot_Juros += ( Pago->VlrPag - Pago->Vlr )
				endif
			else
				Pago->(DbSkip(1))
				Loop
			endif
			Appe Reco nRecno From Pago
			Pago->(DbSkip(1))
		EnDdo
		Set Rela To Codi Into Pagar
		DbGoTop()
		ResTela( cTela )
		if nConta = 0
			ErrorBeep()
			Alerta("Nenhum Debito Pago neste Periodo...")
			ResTela( cScreen )
		else
			PagosDbedit( Tot_Geral, Tot_Juros )
		endif
		DbClearRel()
		DbCloseArea() // cArquivo
		Ferase( cArquivo )
		Area("Pago" )

	EndCase
	Pago->(DbClearRel())
	Pago->(DbClearFilter())
	Pago->(DbGotop())
	ResTela( cScreen )
EndDo

Proc PagosDbEdit( Tot_Geral, Tot_Juros )
****************************************
LOCAL cScreen := SaveScreen()
LOCAL Vetor3
LOCAL Vetor4
FIELD Vlr
FIELD Emis
FIELD Vcto
FIELD docnr
FIELD Tipo
FIELD Port
FIELD Juro
FIELD Nome
FIELD Codi

Vetor3 := { "Emis","Vcto","Docnr","Tran( Vlr, '@E 999,999,999,999.99')","DataPag",;
				"Tran( VlrPag, '@E 999,999,999,999.99')","Tran( VlrPag-Vlr, '@E 999,999,999,999.99')",;
				"Tipo","Port"}
Vetor4 := { "EMISSAO","VCTO", "DOCTO N§", "VALOR","DATA PGTO","VALOR PAGO","JUROS","TIPO","PORTADOR" }
MaBox( 00, 00, 02,			MaxCol() )
MaBox( 21, 00, MaxRow()-1, MaxCol() )
Write( 22, 03, "Nominal : " + Tran( Tot_Geral,"@E 999,999,999,999.99"))
Write( 22, 37, "Juros   : " + Tran( Tot_Juros,"@E 999,999,999,999.99"))
MaBox( 03, 00, 20, MaxCol() )
Seta1(20)
DbEdit( 04, 01, 19, MaxCol()-1, Vetor3, "Nome2", OK, Vetor4 )
DbClearRel()
ResTela( cScreen )
return

Proc ForAlteracao( nChoice )
****************************
LOCAL cScreen := SaveScreen( )
LOCAL cCodi
FIELD Codi

ifNil( nChoice, 1)
WHILE OK
	oMenu:Limpa()
	MaBox( 14, 19, 16, 78 )
	cCodi := Space( 4 )
	@ 15, 20 Say "Codigo..:" Get  cCodi Pict  "9999" Valid PagaRrado( @cCodi, Row(), Col()+1 )
	Read
	if LastKey() = ESC
		Exit
	endif
	if nChoice = 2
		ForInclusao( OK )
	else
		PagarDbedit( cCodi )
	endif
EndDo
ResTela( cScreen )

Proc PagarDbedit( cCodi )
*************************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
Area("Pagar")
if cCodi != NIL
	Pagar->(Order( PAGAR_CODI ))
	Pagar->(DbSeek( cCodi ))
endif
Pagar->(Order( PAGAR_NOME ))
oBrowse:Add( "CODIGO",    "Codi")
oBrowse:Add( "NOME",      "Nome")
oBrowse:Add( "CIDA",      "Cida")
oBrowse:Add( "ESTADO",    "Esta")
oBrowse:Titulo   := "CONSULTA/ALTERACAO DE FORNECEDORES"
oBrowse:PreDoGet := NIL
oBrowse:PosDoGet := NIL
oBrowse:PreDoDel := {|| HotPreFor( oBrowse ) }
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Function HotPreFor( oBrowse )
*****************************
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )
LOCAL cCodi   := Pagar->Codi

Pagamov->(Order( PAGAMOV_CODI ))
if Pagamov->(DbSeek( cCodi ))
	ErrorBeep()
	if !Conf("Pergunta: Fornecedor com Movimento. Excluir ?")
		return( FALSO )
	endif
endif
Pago->(Order( PAGO_CODI ))
if Pago->(DbSeek( cCodi ))
	ErrorBeep()
	if !Conf("Pergunta: Fornecedor com Movimento. Excluir ?")
		return( FALSO )
	endif
endif
return( OK )

*:---------------------------------------------------------------------------------------------------------------------------------

Proc Paga24()
*************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen( )
LOCAL cDocnr
FIELD Codi
FIELD Nome
FIELD Tipo
FIELD Docnr
FIELD Emis
FIELD Vcto
FIELD Port
FIELD Vlr
FIELD Juro

Pagar->(Order( PAGAR_CODI ))
Area( "PagaMov" )
Pagamov->(Order( PAGAMOV_CODI_VCTO ))
WHILE OK
	oMenu:Limpa()
	MaBox( 15, 10, 17, 31 )
	cDocnr = Space(09)
	@ 16, 11 Say "Docto...:" Get cDocnr Pict "@!" Valid PgDocErrad( @cDocnr )
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		Exit
	endif
	Pagar->(DbSeek( Pagamov->Codi ))
	MaBox( 06, 03, 17, 77, "EXCLUSAO DE MOVIMENTO" )
	Write( 07, 04, "Codigo...: " + Codi + "  " + Pagar->Nome )
	Write( 08, 04, "Tipo.....: " + Tipo )
	Write( 09, 04, "Docto N§.: " + Docnr )
	Write( 10, 04, "Emissao..: " + Dtoc( Emis ) )
	Write( 11, 04, "Vencto...: " + Dtoc( Vcto ) )
	Write( 12, 04, "Portador.: " + Port )
	Write( 13, 04, "Valor....: " + Tran( Vlr, "@E 9,999,999,999.99"))
	Write( 14, 04, "Jr Mes...: " + Tran( Juro, "999.99"))
	Write( 15, 04, "Obs......: " + Obs1 )
	Write( 16, 04, "Obs......: " + Obs2 )
	ErrorBeep()
	if Conf( "Confirma Exclusao do Registro ?" )
		if Pagamov->(TravaReg())
			Pagamov->(DbDelete())
			Pagamov->(Libera())
			Alerta("Informa: Registro Excluido." )
		endif
	endif
EndDo

Proc PagaAltera()
*****************
LOCAL cScreen	  := SaveScreen()
LOCAL nChoice	  := 1
LOCAL aMenuArray := { " A Pagar "," Pago "}

WHILE OK
	M_Title("ALTERACAO DE TITULOS")
	nChoice := FazMenu( 09, 10, aMenuArray, Cor())
	if nChoice = 0
		ResTela( cScreen )
		Exit
	elseif nChoice = 1
		AlteraPagar()
	else
		AlteraPago()
	endif
EndDO

Proc AlteraPagar()  // Alteracao de Movimento
******************
LOCAL cScreen	 := SaveScreen()
LOCAL GetList	 := {}
LOCAL cDocnr	 := Space(09)
LOCAL cTipo 	 := Pagamov->Tipo
LOCAL dEmis 	 := Pagamov->Emis
LOCAL dVcto 	 := Pagamov->Vcto
LOCAL cPort 	 := Pagamov->Port
LOCAL nVlr		 := Pagamov->Vlr
LOCAL nJuro 	 := Pagamov->Juro
LOCAL cCodi 	 := Pagamov->Codi
LOCAL cObs1 	 := Pagamov->Obs1
LOCAL cObs2 	 := Pagamov->Obs2
LOCAL nDesconto := Pagamov->Desconto
LOCAL cSwap 	 := Pagamov->Docnr
LOCAL nJdia 	 := 0

WHILE OK
  oMenu:Limpa()
  MaBox( 03, 05, 05, 76 )
  @ 04, 06 Say "Docto...:" Get cDocnr Pict "@!" Valid PgDocErrad( @cDocnr )
  Read
  if LastKey() = ESC
		ResTela( cScreen )
		Exit
  endif
  cTipo		:= Pagamov->Tipo
  dEmis		:= Pagamov->Emis
  dVcto		:= Pagamov->Vcto
  cPort		:= Pagamov->Port
  nVlr		:= Pagamov->Vlr
  nJuro		:= Pagamov->Juro
  cCodi		:= Pagamov->Codi
  cObs1		:= Pagamov->Obs1
  cObs2		:= Pagamov->Obs2
  nDesconto := Pagamov->Desconto
  cDocnr 	:= Pagamov->Docnr
  cSwap		:= Pagamov->Docnr

  MaBox( 06, 05, 18, 77, "ALTERACAO DE TITULOS A PAGAR" )
  @ 07, 06 Say "Codigo...:" Get cCodi     Pict "9999" Valid Paga_AchaReg( @cCodi, Row(), Col()+1 )
  @ 08, 06 Say "Tipo ....:" Get cTipo     Pict "@!"
  @ 09, 06 Say "Doc N§...:" Get cDocnr    Pict "@!"   Valid PgDocCerto( cDocNr, cSwap )
  @ 10, 06 Say "Emissao..:" Get dEmis     Pict "##/##/##"
  @ 11, 06 Say "Vencto...:" Get dVcto     Pict "##/##/##"
  @ 12, 06 Say "Portador.:" Get cPort     Pict "@!"
  @ 13, 06 Say "Valor....:" Get nVlr      Pict "@E 9,999,999,999.99"
  @ 14, 06 Say "Jrs Mes..:" Get nJuro     Pict "999.99"
  @ 15, 06 Say "Desconto.:" Get nDesconto Pict "@E 999.99"
  @ 16, 06 Say "Obs......:" Get cObs1     Pict "@!"
  @ 17, 06 Say "Obs......:" Get cObs2     Pict "@!"
  Read
  if LastKey() = ESC
	  ResTela( cScreen )
	  Exit
  endif
  ErrorBeep()
  if Conf("Pergunta: Confirma Alteracao ?" )
	  nJDia := JuroDia( nVlr, nJuro )
	  Pagamov->(Order( PAGAMOV_DOCNR ))
	  if Pagamov->(DbSeek( cSwap ))
		  if Pagamov->(TravaReg())
			  Pagamov->Codi		 := cCodi
			  Pagamov->Tipo		 := cTipo
			  Pagamov->Docnr		 := cDocnr
			  Pagamov->Emis		 := dEmis
			  Pagamov->Vcto		 := dVcto
			  Pagamov->Port		 := cPort
			  Pagamov->Vlr 		 := nVlr
			  Pagamov->Juro		 := nJuro
			  Pagamov->Desconto	 := nDesconto
			  Pagamov->Jurodia	 := nJdia
			  Pagamov->Obs1		 := cObs1
			  Pagamov->Obs2		 := cObs2
			  Pagamov->Atualizado := Date()
			  Pagamov->(Libera())
		  endif
	  else
		  ErrorBeep()
		  Alerta("Erro: Registro Anterior nao localizado.; Favor Reindexar.")
	  endif
  endif
EndDo

Function Paga_AchaReg( cCodi, nRow, nCol )
******************************************
LOCAL aRotina := {{||ForInclusao() }}
LOCAL cScreen := SaveScreen()
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
FIELD Nome
FIELD Codi
FIELD Fone

Area( "Pagar" )
Pagar->(Order( PAGAR_CODI ))
if Pagar->(Lastrec()) = 0
	oMenu:Limpa()
	ErrorBeep()
	if Conf( "Erro: Nenhum Fornecedor Registrado. Registrar ?")
		ForInclusao()
	endif
	ResTela( cScreen )
	return(FALSO)
endif
if Pagar->(!DbSeek( cCodi ))
	Pagar->(Order( PAGAR_NOME ))
	Pagar->(Escolhe( 03, 01, 18, "Codi + 'º' + Nome + 'º' + Fone","CODI NOME FORNECEDOR                          TELEFONE", aRotina ))
endif
cCodi := Pagar->Codi
if nRow != NIL
	Write( nRow, nCol, Pagar->Nome )
endif
AreaAnt( Arq_Ant, Ind_Ant )
return( OK )

Proc Paga21()
*************
LOCAL cScreen := SaveScreen( )
LOCAL GetList := {}
LOCAL dEntrada
LOCAL cTipo
LOCAL cNosso
LOCAL cBorde
LOCAL cCodi
LOCAL nJdia
LOCAL cDolar
LOCAL dEmis
LOCAL dVcto
LOCAL nVlr
LOCAL nJuro
LOCAL cPort
LOCAL cDocnr
LOCAL cObs
LOCAL nDesconto

WHILE OK
	oMenu:Limpa()
	cCodi := Space(04)
	MaBox( 04, 02, 06, 77 )
	@ 05, 03 Say "Codigo..:" Get cCodi Pict  "9999" valid Pagarrado( @cCodi, Row(), Col()+1 )
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		Exit
	endif
	cTipo 	  := "DM    "
	dEntrada   := Date()
	cPort 	  := Space(10)
	nJuro 	  := 0
	cFatura	  := Space(09)
	nVlrFatura := 0
	WHILE OK
		cDocnr	  := Space( 09 )
		cNosso	  := Space( 13 )
		cBorde	  := Space( 09 )
		dEmis 	  := Date()
		dEntrada   := Date()
		dVcto 	  := ( Date() + 30 )
		cObs1 	  := Space(60)
		cObs2 	  := Space(60)
		nVlr		  := 0
		nDesconto  := 0
		nRow		  := 08
		nCol		  := 03
		MaBox( 07, 02, 21, 77 )
		@ nRow,	  nCol Say "Fatura N§..:" Get cFatura    Pict "@K!"
		@ Row()+1, nCol Say "Vlr Fatura.:" Get nVlrFatura Pict "@E 9,999,999,999.99"
		@ Row()+1, nCol Say "Tipo.......:" Get cTipo      Pict "@K!"
		@ Row()+1, nCol Say "Docto N§...:" Get cDocnr     Pict "@K!" Valid PgDocCerto( @cDocnr )
		@ Row()+1, nCol Say "Data Lcto..:" Get dEntrada   Pict "##/##/##"
		@ Row()+1, nCol Say "Emissao....:" Get dEmis      Pict "##/##/##"
		@ Row()+1, nCol Say "Vencimento.:" Get dVcto      Pict "##/##/##" Valid dDataVer( dEmis, dVcto )
		@ Row()+1, nCol Say "Portador...:" Get cPort      Pict "@K!"
		@ Row()+1, nCol Say "Valor......:" Get nVlr       Pict "@E 9,999,999,999.99" Valid nVlr > 0
		@ Row()+1, nCol Say "Jr Mes.....:" Get nJuro      Pict "999.99"
		@ Row()+1, nCol Say "Desconto...:" Get nDesconto  Pict "@E 999.99"
		@ Row()+1, nCol Say "Observacoes:" Get cObs1      Pict "@!"
		@ Row()+1, nCol Say "Observacoes:" Get cObs2      Pict "@!"
		Read
		if LastKey() = ESC
			Exit
		endif
		ErrorBeep()
		if Conf( "Confirma Inclusao do Registro ?" )
			if !PgDocCerto( @cDocNr )
				Loop
			endif
			nJdia := JuroDia( nVlr, nJuro )
			if Pagamov->(Incluiu())
				Pagamov->Codi		  := cCodi
				Pagamov->Docnr 	  := cDocnr
				Pagamov->Emis		  := dEmis
				Pagamov->Vcto		  := dVcto
				Pagamov->Vlr		  := nVlr
				Pagamov->Port		  := cPort
				Pagamov->Tipo		  := cTipo
				Pagamov->Juro		  := nJuro
				Pagamov->Jurodia	  := nJDia
				Pagamov->Fatura	  := cFatura
				Pagamov->VlrFatu	  := nVlrFatura
				Pagamov->Desconto   := nDesconto
				Pagamov->Obs1		  := cObs1
				Pagamov->Obs2		  := cObs2
				Pagamov->Atualizado := dEntrada
				Pagamov->(Libera())
			endif
		endif
	Enddo
EndDo

Function dDataVer( dEmis, dVcto )
*********************************
if dVcto < dEmis
  ErrorBeep()
  Alerta("Erro: Emissao Maior que Vencimento...")
  return( FALSO)

endif
return( OK )

Proc Paga45( Tot_Geral, Tot_Juros )
***********************************
LOCAL cScreen := SaveScreen()
LOCAL Vetor3
LOCAL Vetor4
FIELD Vlr
FIELD Emis
FIELD Vcto
FIELD docnr
FIELD Tipo
FIELD Port
FIELD Juro
FIELD Nome
FIELD Codi

Pagar->( Order( PAGAR_CODI ))
Set Rela To Codi Into Pagar
Vetor3 := { "Docnr",;
				"Emis",;
				"Vcto",;
				"Date()-Vcto",;
				"Tran( Vlr,'@E 9,999,999,999.99')",;
				"Juro",;
				"Tran( Desconto, '@E 999.99')",;
				"Tipo",;
				"Port",;
				"Obs1",;
				"Obs2"}

Vetor4 := { "DOCTO N§",;
				"EMISSAO",;
				"VCTO",;
				"ATRASO",;
				"VALOR",;
				"JR MES",;
				"DESCONTO",;
				"TIPO",;
				"PORTADOR",;
				"OBSERVACOES",;
				"OBSERVACOES"}
MaBox( 00, 00, 02, 79 )
MaBox( 21, 00, 23, 79 )
Write( 22, 03, "Nominal.: " + Tran( Tot_Geral, "@E 999,999,999,999.99" ))
Write( 22, 37, "Juros...: " + Tran( Tot_Juros, "@E 999,999,999,999.99" ))
MaBox( 03, 00, 20, MaxCol() )
Seta1(20)
DbEdit(04, 01, 19, MaxCol()-1, Vetor3, "Nome2", OK, Vetor4 )
DbClearRel()
DbClearFilter( )
DbGoTop()
ResTela( cScreen )
return

Function Nome2( Mode, Var, Var1)
********************************
FIELD Codi, Nome
Do Case
Case Mode = 0
	Write( 01, 03, "Fornecedor :" + Codi + " " + Pagar->Nome )
	return( 1 )

Case Mode = 1 .OR. Mode = 2
	ErrorBeep()
	return(1)

Case LastKey( ) = 27
	return(0)

OtherWise
	return(1)

EndCase

Proc PagaPrn002( dIni, dFim, nChoice )
**************************************
LOCAL cScreen	  := SaveScreen()
LOCAL Tam		  := 132
LOCAL NovaPagina := OK
LOCAL Pagina	  := 0
LOCAL NovoCodi   := OK
LOCAL UltCodi	  := Codi
LOCAL GrandTotal := 0
LOCAL GrandJuros := 0
LOCAL GrandGeral := 0
LOCAL nDocumento := 0
LOCAL cIni		  := if( dIni = NIL, Dtoc( Ctod("")), Dtoc( dIni ))
LOCAL cFim		  := if( dFim = NIL, Dtoc( Ctod("")), Dtoc( dFim ))
LOCAL nAtraso	  := 0
LOCAL TotalCli   := 0
LOCAL TotalJur   := 0
LOCAL TotalGer   := 0
LOCAL Juros 	  := 0
LOCAL cTitulo	  := ""
LOCAL Col		  := 58
LOCAL nJurodia   := 0
LOCAL nSomaJuro  := 0
LOCAL Var
LOCAL Cen
LOCAL Paga3_2
LOCAL NovoNome
LOCAL UltNome
LOCAL cNome
LOCAL cVlr
LOCAL cJuroMes
LOCAL cDesconto
LOCAL cAtraso
LOCAL cJuroDia
LOCAL cJuros
LOCAL cTotal
LOCAL cObs
FIELD Docnr
FIELD Tipo
FIELD Emis
FIELD Vcto
FIELD Port
FIELD Vlr
FIELD Juro
FIELD JuroDia
FIELD Nome
FIELD Codi
FIELD Fon
FIELD Desconto
FIELD Obs1
FIELD Obs2
FIELD Ende
FIELD Cida

oMenu:Limpa()
if nChoice = 1
	cTitulo := "ROL INDIVIDUAL DE TITULOS A PAGAR NO PERIODO DE " + cIni + " A " + cFim
elseif nChoice = 2
	cTitulo := "ROL GERAL DE TITULOS A PAGAR NO PERIODO DE " + cIni + " A " + cFim
elseif nChoice = 3
	cTitulo := "ROL GERAL DE TITULOS A PAGAR"
endif
Mensagem("Aguarde, Imprimindo. ESC Cancela.", Cor())
PrintOn()
FPrint( PQ )
WHILE !Eof() .AND. Rel_Ok()
	nAtraso	:= Atraso( Date(), Vcto )
	nJurodia := Jurodia( Vlr, Juro )
	if Col >= 57
		Write( 00, 001, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Dtoc( Date()) + " - " + Time(), ( Tam/2 ) ) )
		Write( 01, 000, Padc( XNOMEFIR, Tam ))
		Write( 02, 000, Padc( SISTEM_NA4, Tam ))
		Write( 03, 000, Padc( cTitulo , Tam ))
		Write( 04, 000, Repl( "=", Tam ) )
		Write( 05, 000, "DOCTO N§  TP      EMISSAO   VENCTO PORTADOR        VALOR JR MES  DESC   ATR     JR DIA      JUROS  VLR+JUROS             OBSERVACOES")
		Write( 06, 000, Repl( "=", Tam ) )
		Col := 7
	endif
	if NovoCodi .OR. Col = 7
		if NovoCodi
			NovoCodi := FALSO
		endif
		Qout( Codi, Pagar->Nome, Pagar->Fone, Pagar->( Trim( Ende )), Pagar->( Trim( Cida )), Pagar->Esta )
		Qout()
		Col += 2
	endif
	nSomaJuro := nJuroDia * nAtraso
	cVlr		 := Tran( Vlr, 				"@E 999,999.99")
	cJuroMes  := Tran( Juro,				"999.99")
	cDesconto := Tran( Desconto,			"999.99")
	cAtraso	 := Tran( nAtraso,			"9999")
	cJurodia  := Tran( nJurodia,			"@E 999,999.99")
	cJuros	 := Tran( nSomaJuro, 		"@E 999,999.99")
	cTotal	 := Tran( Vlr + nSomaJuro, "@E 999,999.99")
	cObs		 := Left( Obs1, 23 )
	Qout( Docnr, Tipo, Emis, Vcto, Port, cVlr, cJuroMes, cDesconto, cAtraso, cJurodia, cJuros, cTotal, cObs )
	Col		  ++
	TotalCli   += Vlr
	TotalJur   += nSomaJuro
	TotalGer   += nSomaJuro + Vlr
	GrandTotal += Vlr
	GrandJuros += nSomaJuro
	GrandGeral += Vlr + nSomaJuro
	nDocumento ++
	UltCodi	  := Codi
	DbSkip(1)
	NovoCodi   := UltCodi != Codi
	if NovoCodi .OR. Col >= 52
		Col++
		Qout()
		Findou( "** Total Fornecedor **", Tam, TotalCli, TotalJur, TotalGer )
		Col		+= 2
		TotalCli := 0
		TotalJur := 0
		TotalGer := 0
		if Col >= 57
			 __Eject()
		endif
	endif
EndDo
if TotalCli != 0
	Col++
	Qout()
	Findou( "** Total Fornecedor **", Tam, TotalCli, TotalJur, TotalGer )
	TotalCli := 0
	TotalJur := 0
	TotalGer := 0
endif
Findou1( "** Total Geral ** ", Tam, GrandTotal, GrandJuros, GrandGeral, nDocumento )
__Eject()
PrintOff()
ResTela( cScreen )
return

Proc TotalPagar()
*****************
LOCAL cScreen	  := SaveScreen()
LOCAL nDocumento := 0
LOCAL nVlr		  := 0
LOCAL nDesconto  := 0
LOCAL nJuros	  := 0
LOCAL nGeral	  := 0
LOCAL nAtraso	  := 0
LOCAL Tam		  := 132
LOCAL Pagina	  := 0

oMenu:Limpa()
Area("Pagamov")
Pagamov->(DbGoTop())
if !Instru80()
	ResTela( cScreen )
	return
endif
Mensagem( "Aguarde, Processando.", Cor())
PrintOn()
FPrint( PQ )
SetPrc( 0, 0 )
WHILE Pagamov->(!Eof() .AND. Rep_Ok())
	nVlr		  += Pagamov->Vlr
	nAtraso	  := Atraso( Date(), Pagamov->Vcto )
	nJuroDia   := JuroDia( Pagamov->Vlr, Pagamov->Juro )
	nJuros	  += ( nAtraso * nJuroDia )
	nDesconto  += Pagamov->Desconto
	nDocumento ++
	Pagamov->(DbSkip( 1 ))
EndDo
nGeral := ( nVlr + nJuros ) - nDesconto
Qout( Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ))
Qout( Dtoc( Date() ))
Qout( Padc( XNOMEFIR, Tam ))
Qout( Padc( SISTEM_NA3, Tam ))
Qout( Padc( "ROL GERAL DE TITULOS A PAGAR - TOTALIZADO" , Tam ))
Qout( Repl( "=", Tam ) )
Qout("              QTDE DCTOS    TOTAL NOMINAL      TOTAL JUROS   TOTAL DESCONTO      TOTAL GERAL")
Qout( Repl( "=", Tam ) )
Qout("** Total Geral **", Tran( nDocumento, "999999" ),;
								  Tran( nVlr,		 "@E 9,999,999,999.99" ),;
								  Tran( nJuros,	 "@E 9,999,999,999.99" ),;
								  Tran( nDesconto, "@E 9,999,999,999.99" ),;
								  Tran( nGeral,	 "@E 9,999,999,999.99" ))
__Eject()
PrintOff()
ResTela( cScreen )
return

Proc FluxoPagar()
*****************
LOCAL cScreen := SaveScreen()
LOCAL aData   := {}
LOCAL aValor  := {}
LOCAL aConta  := {}
LOCAL nConta  := 0
LOCAL nRegis  := 0

oMenu:Limpa()
Area("Pagamov")
Pagamov->(Order( PAGAMOV_VCTO ))
Pagamov->(DbGoTop())
Mensagem( "Aguarde, Processando.", Cor())
nRegis := Lastrec()
WHILE Pagamov->(!Eof() .AND. Rep_Ok())
	nPosicao := Ascan( aData, Pagamov->Vcto )
	if nPosicao = 0
		Aadd( aData,  Pagamov->Vcto )
		Aadd( aValor, Pagamov->Vlr )
		Aadd( aConta, 1 )
	else
		aValor[ nPosicao ] += Pagamov->Vlr
		aConta[ nPosicao ]++
	endif
	DbSkip( 1 )
EndDo
if ( nTamanho := Len( aData ) ) = 0
	NaoTem()
	Restela( cScreen )
	return
endif
oMenu:Limpa()
if InsTru80()
	ImprimirFluxo( aData, aValor, aConta, SISTEM_NA4 )
endif
ResTela( cScreen )
return


Function RetPeriodo( dIni, dFim )
*********************************
MaBox( 14,	10, 17, 40, "ENTRE COM O PERIODO" )
@ 15, 11 Say "Data Inicial.......:" Get dIni Pict  "##/##/##"
@ 16, 11 Say "Data Final.........:" Get dFim Pict  "##/##/##"
Read
if LastKey() = ESC
	return( FALSO )
endif
return( OK )

Proc TotalPago()
****************
LOCAL cScreen	  := SaveScreen()
LOCAL nDocumento := 0
LOCAL nVlr		  := 0
LOCAL nJuros	  := 0
LOCAL nGeral	  := 0
LOCAL Tam		  := 132
LOCAL Pagina	  := 0

oMenu:Limpa()
Area("Pago")
Pago->(DbGoTop())
if !Instru80()
	ResTela( cScreen )
	return
endif
Mensagem( "Aguarde, Processando.", Cor())
PrintOn()
FPrint( PQ )
SetPrc( 0, 0 )
WHILE Pago->(!Eof() .AND. Rep_Ok())
	nVlr		  += Pago->Vlr
	nGeral	  += Pago->VlrPag
	nDocumento ++
	Pago->(DbSkip( 1 ))
EndDo
nJuros := ( nGeral - nVlr )
Qout( Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ))
Qout( Dtoc( Date() ))
Qout( Padc( XNOMEFIR, Tam ))
Qout( Padc( SISTEM_NA3, Tam ))
Qout( Padc( "ROL GERAL DE TITULOS PAGOS - TOTALIZADO" , Tam ))
Qout( Repl( "=", Tam ) )
Qout("              QTDE DCTOS    TOTAL NOMINAL      TOTAL JUROS   TOTAL GERAL")
Qout( Repl( "=", Tam ) )
Qout("** Total Geral **", Tran( nDocumento, "999999" ),;
								  Tran( nVlr,		 "@E 9,999,999,999.99" ),;
								  Tran( nJuros,	 "@E 9,999,999,999.99" ),;
								  Tran( nGeral,	 "@E 9,999,999,999.99" ))
__Eject()
PrintOff()
ResTela( cScreen )
return

Function PgDocCerto( cDocnr, cSwap )
************************************
LOCAL cScreen := SaveScreen()
LOCAL Ind_Ant := IndexOrd()
LOCAL Arq_Ant := Alias()

if LastKey() = UP .OR. cDocnr == cSwap
	return( OK )
endif
if Empty( cDocnr )
	ErrorBeep()
	Alerta("Erro: Entrada Invalida.")
	return( FALSO )
endif
Pagamov->(Order( PAGAMOV_DOCNR ))
if Pagamov->(DbSeek( cDocnr ))
	ErrorBeep()
	Alerta("Erro: Numero ja Registrado.")
	AreaAnt( Arq_Ant, Ind_Ant )
	return(FALSO)
endif
AreaAnt( Arq_Ant, Ind_Ant )
return( OK )

Function PagaBer( cCodi )
*************************
LOCAL cScreen := SaveScreen()
LOCAL Ind_Ant := IndexOrd()
LOCAL Arq_Ant := Alias()

Pagamov->(Order( PAGAMOV_CODI ))
if Pagamov->(!DbSeek( cCodi ))
	ErrorBeep()
	Alerta("Erro: Fornecedor Sem Movimento.")
	AreaAnt( Arq_Ant, Ind_Ant )
	return( FALSO )
endif
cCodi := Pagamov->Codi
AreaAnt( Arq_Ant, Ind_Ant )
return( OK )

STATIC Proc AbreArea()
**********************
LOCAL cScreen := SaveScreen()
ErrorBeep()
Mensagem("Aguarde, Abrindo base de dados.", WARNING, _LIN_MSG )
FechaTudo()

if !UsaArquivo("PAGAR")
	MensFecha()
	return
endif

if !UsaArquivo("PAGO")
	MensFecha()
	return
endif

if !UsaArquivo("PAGAMOV")
	MensFecha()
	return
endif

if !UsaArquivo("CHEQUE")
	MensFecha()
	return
endif

if !UsaArquivo("CHEMOV")
	MensFecha()
	return
endif

if !UsaArquivo("RECEMOV")
	MensFecha()
	return
endif

if !UsaArquivo("ENTRADAS")
	MensFecha()
	return
endif

if !UsaArquivo("CEP")
	MensFecha()
	return
endif
if !UsaArquivo("ENTNOTA")
	MensFecha()
	return
endif
if !UsaArquivo("VENDEDOR")
	MensFecha()
	return
endif

return

Proc PagaPosi( nChoice )
************************
LOCAL GetList		:= {}
LOCAL cScreen		:= SaveScreen()
LOCAL nValorDolar := 0
LOCAL nConta		:= 0
LOCAL dIni			:= Date()
LOCAL dFim			:= Date()+30
LOCAL cTipo 		:= Space(6)
LOCAL cCodi
LOCAL nTotal
LOCAL nValorTotal
LOCAL nTotalGeral
LOCAL nTotalDesco
LOCAL nTotalJuros
LOCAL aTodos
LOCAL aCabec
LOCAL nJuros
LOCAL cTela
LOCAL oBloco
LOCAL cRegiao
LOCAL Col
FIELD Vcto
FIELD Juro
FIELD Codi
FIELD Docnr
FIELD Emis
FIELD Vlr
PRIVA aCodi := {}
PRIVA aObs1 := {}
PRIVA aObs2 := {}
PRIVA aVcto := {}

oMenu:Limpa()
Pagar->(Order( PAGAR_CODI ))
Pagamov->(DbGoTop())
if Pagamov->(Eof())
	Nada()
	ResTela( cScreen )
	return
endif
WHILE OK
	  Do Case
	  Case nChoice = 1
		  cCodi		:= Space(4)
		  dIni		:= Date()
		  dFim		:= Date()+30
		  MaBox( 14, 55, 18, 79 )
		  @ 15, 56 Say "Codigo.......:" Get cCodi Pict "9999" Valid Pagarrado( @cCodi )
		  @ 16, 56 Say "Vcto Inicial.:" Get dIni  Pict "##/##/##"
		  @ 17, 56 Say "Vcto Inicial.:" Get dFim  Pict "##/##/##"
		  Read
		  if LastKey() = ESC
			  ResTela( cScreen )
			  Exit
		  endif
		  Area("Pagamov")
		  Pagamov->(Order(PAGAMOV_CODI_VCTO))
		  oBloco  := {|| Pagamov->Codi = cCodi }
		  oBloco2 := {|| Pagamov->Vcto >= dIni .AND. Pagamov->Vcto <= dFim }
		  if !DbSeek( cCodi )
			  Nada()
			  Loop
		  endif
	  Case nChoice = 2
		  dIni := Date()-30
		  dFim := Date()
		  MaBox( 14, 52, 17, 77 )
		  @ 15, 53 Say "Data Ini..:" Get dIni Pict "##/##/##"
		  @ 16, 53 Say "Data Fim..:" Get dFim Pict "##/##/##"
		  Read
		  if LastKey() = ESC
			  ResTela( cScreen )
			  Exit
		  endif
		  Area("Pagamov")
		  Pagamov->(Order(PAGAMOV_VCTO))
		  Pagamov->(DbGoTop())
		  OBloco  := {|| !Eof() }
		  oBloco2 := {|| Pagamov->Vcto >= dIni .AND. Pagamov->Vcto <= dFim }

	  Case nChoice = 3
		  Area("Pagamov")
		  Pagamov->(Order(PAGAMOV_VCTO ))
		  Pagamov->(DbGoTop())
		  oBloco   := {|| Pagamov->(!Eof()) }
		  oBloco2  := {|| Pagamov->(!Eof()) }

	  Case nChoice = 4
		  cTipo := Space(6)
		  dIni  := Date()-30
		  dFim  := Date()
		  MaBox( 14, 52, 18, 77 )
		  @ 15, 53 Say "Tipo......:" Get cTipo Pict "@!"
		  @ 16, 53 Say "Data Ini..:" Get dIni  Pict "##/##/##"
		  @ 17, 53 Say "Data Fim..:" Get dFim  Pict "##/##/##"
		  Read
		  if LastKey() = ESC
			  ResTela( cScreen )
			  Exit
		  endif
		  Area("Pagamov")
		  Pagamov->(Order(PAGAMOV_VCTO))
		  Pagamov->(DbGoTop())
		  OBloco  := {|| !Eof() }
		  oBloco2 := {|| Pagamov->Vcto >= dIni .AND. Pagamov->Vcto <= dFim }

	  EndCase
	  nValorTotal := 0
	  nJuros 	  := 0
	  nTotal 	  := 0
	  nTotalGeral := 0
	  nValorDolar := 0
	  nTotalDesco := 0
	  nTotalJuros := 0
	  Col 		  := 12
	  aTodos 	  := {}
	  aCodi		  := {}
	  aObs1		  := {}
	  aObs2		  := {}
	  aReg		  := {}
	  nConta 	  := 0
	  nCotacao	  := 0
	  cTela		  := Mensagem("Aguarde... ", Cor())
	  WHILE Pagamov->(Eval( oBloco ))
		  if nChoice = 4
			  if Pagamov->Tipo != cTipo
				  Pagamov->(DbSkip(1))
				  Loop
			  endif
		  endif
		  if Pagamov->(!Eval( oBloco2 ))
			  Pagamov->(DbSkip(1))
			  Loop
		  endif
		  if nConta >= 4096 // Tamanho Max. Array
			  Alerta("Informa:  Muitos registros. Use Relatorios.")
			  Exit
		  endif
		  Aadd( aCodi, Pagamov->Codi )
		  Aadd( aObs1, Pagamov->Obs1 )
		  Aadd( aObs2, Pagamov->Obs2 )
		  nAtraso	  := Atraso( Date(), Vcto )
		  nJuroDia	  := JuroDia( Vlr, Juro )
		  nJuros 	  := if( nAtraso	<= 0, 0, ( nAtraso * nJuroDia))
		  nValorTotal += Vlr
		  nTotal 	  := ( Vlr + nJuros ) - Desconto
		  nTotalGeral += nTotal
		  nTotalDesco += Desconto
		  nTotalJuros += nJuros
		  Aadd( aTodos,;
				  Docnr + " " + ;
				  Dtoc(Emis) + " " + ;
				  Dtoc(Vcto) + " " + ;
				  StrZero( Date()-Vcto, 4) + " " + ;
				  Tran( Vlr,"@E 999,999.99") + " " + ;
				  Tran( Desconto, '@E 999,999.99' ) + " " + ;
				  Tran( nJuros, '@E 999,999.99' ) + " " + ;
				  Tran( nTotal, "@E 999,999.99"))
		  nConta++
		  Pagamov->(DbSkip(1))
	  EndDo
	  ResTela( cTela )
	  if Len( aTodos ) > 0
		  StatusInf("")
		  MaBox( 00, 00, 06, 79 )
		  Print( 24, 0," TOTAL GERAL ¯¯ " + Space(18) + ;
							  Tran( nValorTotal, "@E 999,999.99") + Space(1) +;
							  Tran( nTotalDesco, "@E 999,999.99") + Space(1) +;
							  Tran( nTotalJuros, "@E 999,999.99") + Space(1) +;
							  Tran( nTotalGeral, "@E 999,999.99"), Cor())
		  MaBox( 07, 00, 23, 79, "DOCTO N§   EMISSAO  VENCTO  ATRA    NOMINAL   DESCONTO      JUROS      TOTAL ")
		  M_Title("[ESC] RETORNA")
		  __FuncaoPago( 0, 1, 1 )
		  aChoice( 08, 01, 22, 77, aTodos, OK, "__FuncaoPago" )
	  endif
	  if nChoice = 3
		  ResTela( cScreen )
		  Exit
	  endif
EndDo

Function __FuncaoPago( Mode, nItem, nPosicao )
**********************************************
FIELD UltCompra
FIELD Matraso
FIELD VlrCompra

Do Case
Case Mode = 0
	Pagar->(Order( PAGAR_CODI ))
	Pagar->(DbSeek( aCodi[ nItem ]))
	Write( 01, 01, aCodi[ nItem] + " " + Pagar->Nome )
	Write( 01, 49, "Telefone      : " + Pagar->Fone )
	Write( 02, 01, Pagar->Ende + " " + Pagar->Bair )
	Write( 03, 01, Pagar->Cep	+ "/" + Pagar->Cida + " " + Pagar->Esta )
	Write( 04, 01, aObs1[ nItem] )
	Write( 05, 01, aObs2[ nItem] )
	return(2)

Case LastKey() = ESC .OR. LastKey() = ENTER
	return(0)

OtherWise
	return(2)

EndCase


Proc PagoPago( nChoice )
************************
LOCAL GetList		:= {}
LOCAL cScreen		:= SaveScreen()
LOCAL nValorDolar := 0
LOCAL nConta		:= 0
LOCAL dIni			:= Date()-30
LOCAL dFim			:= Date()
LOCAL cCodi
LOCAL nValorTotal
LOCAL nTotalGeral
LOCAL aTodos
LOCAL aCabec
LOCAL nValorJuros
LOCAL cTela
LOCAL oBloco
LOCAL oBloco2
LOCAL cRegiao
LOCAL Col
FIELD Regiao
FIELD Vcto
FIELD Juro
FIELD Codi
FIELD Docnr
FIELD Emis
FIELD Vlr
PRIVA aCodi := {}
PRIVA aObs1 := {}
PRIVA aObs2 := {}

oMenu:Limpa()
Pagar->(Order( PAGAR_CODI ))
Pago->(DbGoTop())
if Pago->(Eof())
	ErrorBeep()
	Alerta("Nenhum Debito Pago.")
	ResTela( cScreen )
	return
endif
WHILE OK
	  Do Case
	  Case nChoice = 1
		  cCodi := Space(4)
		  dIni  := Date()-30
		  dFim  := Date()
		  MaBox( 14, 55, 18, 79 )
		  @ 15, 56 Say "Codigo.....:" Get cCodi Pict "9999" Valid Pagarrado( @cCodi )
		  @ 16, 56 Say "Pgto Final.:" Get dIni  Pict "##/##/##"
		  @ 17, 56 Say "Pgto Final.:" Get dFim  Pict "##/##/##"
		  Read
		  if LastKey() = ESC
			  ResTela( cScreen )
			  Exit
		  endif
		  Area("Pago")
		  Pago->(Order( PAGO_CODI_DATAPAG ))
		  oBloco  := {|| Pago->Codi = cCodi }
		  oBloco2 := {|| Pago->DataPag >= dIni .AND. Pago->DataPag <= dFim }
		  if !DbSeek( cCodi )
			  ErrorBeep()
			  Alerta("Nenhum Debito Pago.")
			  Loop
		  endif

	  Case nChoice = 2
		  dIni := Date()-30
		  dFim := Date()
		  MaBox( 14, 52, 17, 75 )
		  @ 15, 53 Say "Pgto Ini.. ¯" Get dIni Pict "##/##/##"
		  @ 16, 53 Say "Pgto Final ¯" Get dFim Pict "##/##/##"
		  Read
		  if LastKey() = ESC
			  ResTela( cScreen )
			  Exit
		  endif
		  Area("Pago")
		  Pago->(Order( PAGO_DATAPAG ))
		  DbGoTop()
		  OBloco  := {|| !Eof() }
		  oBloco2 := {|| Pago->DataPag >= dIni .AND. Pago->DataPag <= dFim }

	  Case nChoice = 3
		  Area("Pago")
		  Pago->(Order( PAGO_CODI_DATAPAG ))
		  DbGoTop()
		  oBloco  := {|| Pago->(!Eof()) }
		  oBloco2 := {|| Pago->(!Eof()) }
	  EndCase
	  nValorTotal := 0
	  nValorPago  := 0
	  nTotalGeral := 0
	  Col := 12
	  aTodos   := {}
	  aCodi	  := {}
	  aObs1	  := {}
	  aObs2	  := {}
	  nConta   := 0
	  nCotacao := 0
	  cTela	  := Mensagem("Aguarde... ", Cor())
	  WHILE Pago->(Eval( oBloco ))
		  if Pago->(Eval( oBloco2 ))
			  if nConta >= 4096 // Tamanho Max. Array
				  Alerta("Informa: Impossivel mostrar mais que 4096 registros.")
				  Exit
			  endif
			  Aadd( aCodi, Codi )
			  Aadd( aObs1, Obs1 )
			  Aadd( aObs2, Obs2 )
			  nValorPago  += VlrPag
			  nValorTotal += Vlr
			  Aadd( aTodos, Docnr + " " + Dtoc(Emis) + " " + ;
								 Dtoc(Vcto) + " " + Dtoc( DataPag) + " " + StrZero( DataPag-Vcto, 4) + " " + ;
								 Tran( Vlr, 	 "@E 999,999,999.99") + "  " + ;
								 Tran( VlrPag, "@E 999,999,999.99"))
			  nConta++
		  endif
		  Pago->(DbSkip(1))
	  EndDo
	  ResTela( cTela )
	  if Len( aTodos ) > 0
		  StatusInf("")
		  MaBox( 00, 00, 06, 79 )
		  Print( 24, 0," TOTAL GERAL ¯¯ " + Space(25) + ;
							  Tran( nValorTotal, "@E 9,999,999,999.99") +;
							  Tran( nValorPago,	"@E 9,999,999,999.99"), Cor())
		  MaBox( 07, 00, 23, 79, " DOCTO N§  EMISSAO   VENCTO  DATAPAG ATRA   VALOR TITULO      VALOR PAGO            " )
		  M_Title("[ESC] RETORNA")
		  __FunPago( 0, 1, 1 )
		  aChoice( 08, 01, 22, 77, aTodos, OK, "__FunPago" )
	  endif
	  ResTela( cScreen )
	  if nChoice = 3
		  Exit
	  endif
EndDo

Function __FunPago( Mode, nItem, nPosicao )
*******************************************
FIELD UltCompra
FIELD Matraso
FIELD VlrCompra

Do Case
Case Mode = 0
	Pagar->(Order( PAGAR_CODI ))
	Pagar->(DbSeek( aCodi[ nItem ]))
	Write( 01, 01, aCodi[ nItem] + " " + Pagar->Nome )
	Write( 01, 49, "Telefone      : " + Pagar->Fone )
	Write( 02, 01, Pagar->Ende + " " + Pagar->Bair )
	Write( 03, 01, Pagar->Cep	+ "/" + Pagar->Cida + " " + Pagar->Esta )
	Write( 04, 01, aObs1[ nItem])
	Write( 05, 01, aObs2[ nItem])
	return(2)

Case LastKey() = ESC .OR. LastKey() = ENTER
	return(0)

OtherWise
	return(2)

EndCase

Proc PagarPago()
****************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL cFatura	:= Space(7)
LOCAL aTodos	:= {}
LOCAL nDebito	:= 0
LOCAL nCredito := 0
PRIVA cCodi

WHILE OK
	cFatura := Space(07)
	MaBox( 14, 55, 16, 79 )
	@ 15, 56 Say "Fatura N§..:" Get cFatura Pict "@!" Valid VisualEntraFatura( @cFatura )
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		return
	endif
	nDebito	:= 0
	nCredito := 0
	nTotal	:= 0
	aTodos	:= {}
	EntNota->(Order( ENTNOTA_NUMERO ))
	EntNota->(DbSeek( cFatura ))
	cCodi 	:= EntNota->Codi
	Mensagem('Aguarde, Verificando Movimento')
	Pago->(Order( PAGO_CODI ))
	if Pago->(DbSeek( cCodi ))
		While Pago->Codi = cCodi
			if Pago->Fatura = cFatura
				nCredito += Pago->VlrPag
				nTotal	+= Pago->Vlr
				Aadd( aTodos,;
						Pago->Docnr + " " + ;
						Dtoc( Pago->Emis) + " " + ;
						Dtoc( Pago->Vcto) + " " + ;
						Dtoc( Pago->Datapag) + " " + ;
						StrZero( Pago->Datapag - Pago->Vcto, 4) + " " + ;
						Tran( Pago->Vlr,'@E 999,999.99' )  + " " + ;
						Space(10) + " " + ;
						Tran( Pago->VlrPag,'@E 999,999.99' ))
			endif
			Pago->(DbSkip(1))
		EndDo
	endif
	Pagamov->(Order( PAGAMOV_CODI ))
	if Pagamov->(DbSeek( cCodi ))
		While Pagamov->Codi = cCodi
		  if Pagamov->Fatura = cFatura
			  nDebito += Pagamov->Vlr
			  nTotal  += Pagamov->Vlr
			  Aadd( aTodos,;
					  Pagamov->Docnr + " " + ;
					  Dtoc( Pagamov->Emis) + " " + ;
					  Dtoc( Pagamov->Vcto) + " " + ;
					  Dtoc( Ctod('')) + " " + ;
					  StrZero( Date()-Pagamov->Vcto, 4) + " " + ;
					  Tran( Pagamov->Vlr,"@E 999,999.99") + " " + ;
					  Tran( Pagamov->Vlr,"@E 999,999.99") + " " + ;
					  Space(10))
		  endif
		  Pagamov->(DbSkip(1))
		EndDo
	endif
	if Len( aTodos ) > 0
		StatusInf("")
		MaBox( 00, 00, 06, 79 )
		Print( 24, 0," TOTAL GERAL ¯¯ " + Space(27) + ;
							Tran( nTotal,	 "@E 999,999.99") + ' ' + ;
							Tran( nDebito,  "@E 999,999.99") + ' ' + ;
							Tran( nCredito, "@E 999,999.99"), Cor())
		MaBox( 07, 00, 23, 79, " DOCTO N§  EMISSAO   VENCTO  DATAPAG ATRA   VALOR DEVIDO     VALOR PAGO             " )
		MaBox( 07, 00, 23, 79, " DOCTO N§  EMISSAO   VENCTO  DATAPAG ATRA    NOMINAL    A PAGAR       PAGO          " )
		M_Title("[ESC] RETORNA")
		__FunPP( 0, 1, 1 )
		aChoice( 08, 01, 22, 77, aTodos, OK, "__FunPP" )
	endif
	ResTela( cScreen )
EndDo

Function __FunPP( Mode, nItem, nPosicao )
*******************************************
FIELD UltCompra
FIELD Matraso
FIELD VlrCompra

Do Case
Case Mode = 0
	Pagar->(Order( PAGAR_CODI ))
	Pagar->(DbSeek( cCodi ))
	Write( 01, 01, cCodi + " " + Pagar->Nome )
	Write( 01, 49, "Telefone      : " + Pagar->Fone )
	Write( 02, 01, Pagar->Ende + " " + Pagar->Bair )
	Write( 03, 01, Pagar->Cep	+ "/" + Pagar->Cida + " " + Pagar->Esta )
	return(2)

Case LastKey() = ESC .OR. LastKey() = ENTER
	return(0)

OtherWise
	return(2)

EndCase

Proc Paga35()
*************
LOCAL cScreen	:= SaveScreen()
LOCAL aMenu 	:= { " Individual ", " Geral Ordem Codigo ", " Geral Ordem Nome ", " Configurar Etiquetas " }
LOCAL nChoice	:= 1
LOCAL cCodi 	:= Space(04)
LOCAL nEtiquetas := 1
LOCAL aConfig	:= {}
LOCAL cTemp 	:= "T" + Left( StrTran( Time(), ":"),5) + ".TMP"
LOCAL nRecno	:= 0
LOCAL oBloco
LOCAL nCampos	  := 5
LOCAL nTamanho   := 35
LOCAL nMargem	  := 0
LOCAL nLinhas	  := 1
LOCAL nEspacos   := 1
LOCAL nCarreira  := 1
LOCAL nX 		  := 0
LOCAL aArray	  := {}
LOCAL aGets 	  := {}
LOCAL lComprimir := FALSO
LOCAL lSpVert	  := FALSO

WHILE OK
	 M_Title("IMPRESSAO DE ETIQUETAS FORNECEDORES" )
	 nChoice := FazMenu( 08, 10, aMenu, Cor())
	 Do Case
	 Case nChoice = 0
		 ResTela( cScreen )
		 Exit

	 Case nChoice = 1
		 WHILE OK
			 Area("Pagar")
			 Order( PAGAR_CODI )
			 cCodi		 := Space( 04 )
			 nEtiquetas  := 1
			 cArquivo	 := Space(11)
			 MaBox( 16 , 10 , 19 , 78 )
			 @ 17, 11 Say	"Codigo.....:" Get cCodi      Pict "9999" Valid Pagarrado( @cCodi, Row(), Col() + 5 )
			 @ 18, 11 Say	"Quantidade.:" Get nEtiquetas Pict "9999" Valid nEtiquetas > 0
			 Read
			 if LastKey( ) = ESC
				 ResTela( cScreen )
				 Exit
			 endif
			 aConfig := LerEtiqueta()
			 if !InsTru80() .OR. !LptOk()
				 ResTela( cScreen )
				 return
			 endif
			 nLen := Len( aConfig )
			 if nLen > 0
				 nCampos 	:= aConfig[1]
				 nTamanho	:= aConfig[2]
				 nMargem 	:= aConfig[3]
				 nLinhas 	:= aConfig[4]
				 nEspacos	:= aConfig[5]
				 nCarreira	:= aConfig[6]
				 lComprimir := aConfig[7] == 1
				 lSpVert 	:= aConfig[8] == 1
				 For nX := 9 To nLen
					 Aadd( aGets, aConfig[nX] )
				 Next
			 endif
			 aLinha := Array( aConfig[1] )
			 Afill( aLinha, "" )
			 PrintOn()
			 FPrint( _SALTOOFF ) // Inibir salto picote
			 if lComprimir
				 FPrint( PQ )
			 endif
			 if lSpVert
				 FPrint( _SPACO1_8 )
			 endif
			 SetPrc( 0, 0 )
			 nConta := 0
			 nCol 		:= nMargem
			 For nY := 1 To nEtiquetas
				 nConta++
				 For nB := 1 To nCampos
					 cVar := aGets[nB]
					 nTam := Len( &cVar. )
					 aLinha[nB] += &cVar. + if( nConta = nCarreira, "", Space( ( nTamanho - nTam ) + nEspacos ))
				 Next
				 if nConta = nCarreira
					 nConta := 0
					 For nC := 1 To nCampos
						 //Qout( aLinha[nC] )
						 Qout( Space( nMargem) + aLinha[nC] )
						 aLinha[nC] := ""
					 Next
					 For nD := 1 To nLinhas
						 Qout()
					 Next
				 endif
			 Next nY
			 if nConta >0
				 For nC := 1 To nCampos
					 //Qout( aLinha[nC] )
					 Qout( Space( nMargem) + aLinha[nC] )
					 aLinha[nC] := ""
				 Next
				 For nD := 1 To nLinhas
					 Qout()
				 Next
			 endif
			 PrintOFF()
			 ResTela( cScreen )
		 EndDo

	 Case nChoice = 2 .OR. nChoice = 3
		 Area("Pagar")
		 if nChoice = 2
			 Order( PAGAR_CODI )
		 else
			 Order( PAGAR_NOME )
		 endif
		 Pagar->(DbGoTop())
		 aConfig := LerEtiqueta()
		 if !InsTru80() .OR. !LptOk()
			 ResTela( cScreen )
			 return
		 endif
		 nLen := Len( aConfig )
		 if nLen > 0
			 nCampos 	:= aConfig[1]
			 nTamanho	:= aConfig[2]
			 nMargem 	:= aConfig[3]
			 nLinhas 	:= aConfig[4]
			 nEspacos	:= aConfig[5]
			 nCarreira	:= aConfig[6]
			 lComprimir := aConfig[7] == 1
			 lSpVert 	:= aConfig[8] == 1
			 For nX := 9 To nLen
				 Aadd( aGets, aConfig[nX] )
			 Next
		 endif
		 aLinha := Array( aConfig[1] )
		 Afill( aLinha, "" )
		 PrintOn()
		 FPrint( _SALTOOFF )
		 if lComprimir
			 FPrint( PQ )
		 endif
		 if lSpVert
			 FPrint( _SPACO1_8 )
		 endif
		 SetPrc( 0, 0 )
		 nConta		:= 0
		 nEtiquetas := 1
		 nCol 		:= nMargem
		 WHILE !Eof() .AND. Rep_Ok()
			 For nY := 1 To nEtiquetas
				 nConta++
				 For nB := 1 To nCampos
					 cVar := aGets[nB]
					 nTam := Len( &cVar. )
					 aLinha[nB] += &cVar. + if( nConta = nCarreira, "", Space( ( nTamanho - nTam ) + nEspacos ))
				 Next
				 if nConta = nCarreira
					 nConta := 0
					 For nC := 1 To nCampos
						 //Qout( aLinha[nC] )
						 Qout( Space( nMargem) + aLinha[nC] )
						 aLinha[nC] := ""
					 Next
					 For nD := 1 To nLinhas
						 Qout()
					 Next
				 endif
			 Next nY
			 DbSkip(1)
		 EndDo
		 if nConta >0
			 For nC := 1 To nCampos
				 //Qout( aLinha[nC] )
				 Qout( Space( nMargem) + aLinha[nC] )
				 aLinha[nC] := ""
			 Next
			 For nD := 1 To nLinhas
				 Qout()
			 Next
		 endif
		 PrintOFF()
		 ResTela( cScreen )

	 Case nChoice = 4
		 ConfigurarEtiqueta()
		 ResTela( cScreen )

	 EndCase
EndDo

Proc AlteraPago()
*****************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL nRow		:= 8
LOCAL nCol		:= 6
LOCAL nCotacao := 0
LOCAL cDocnr	:= Space(09)
LOCAL cCodi 	:= Pago->Codi
LOCAL cTipo 	:= Pago->Tipo
LOCAL dEmis 	:= Pago->Emis
LOCAL dVcto 	:= Pago->Vcto
LOCAL cPort 	:= Pago->Port
LOCAL nVlr		:= Pago->Vlr
LOCAL nJuro 	:= Pago->Juro
LOCAL nVlrAnt	:= Pago->Vlr
LOCAL nVlrPag	:= Pago->VlrPag
LOCAL dDataPag := Pago->DataPag
LOCAL cObs1 	:= Pago->Obs1
LOCAL cObs2 	:= Pago->Obs2

Pagar->(Order( PAGAR_CODI ))
Area("Pago")
Pago->(Order( PAGO_DOCNR ))
WHILE OK
	oMenu:Limpa()
	MaBox( 03 , 05 , 05 , 30 )
	@ 04 , 06 Say	"Docto...:"Get cDocNr Pict "@K!" Valid PagoErrado( @cDocNr )
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		Exit
	endif
	cCodi 	:= Pago->Codi
	cTipo 	:= Pago->Tipo
	cDocnr	:= Pago->Docnr
	dEmis 	:= Pago->Emis
	dVcto 	:= Pago->Vcto
	cPort 	:= Pago->Port
	nVlr		:= Pago->Vlr
	nJuro 	:= Pago->Juro
	nVlrAnt	:= Pago->Vlr
	nVlrPag	:= Pago->VlrPag
	dDataPag := Pago->DataPag
	cObs1 	:= Pago->Obs1
	cObs2 	:= Pago->Obs2
	Pagar->(DbSeek( Pago->Codi ))
	MaBox( 06, 05, 19 , 78, "ALTERACAO DE MOVIMENTO PAGO" )
	@ 07, nCol Say "Codigo....:" Get cCodi    Pict "9999" Valid Pagarrado( @cCodi, Row(), Col()+1 )
	@ 08, nCol Say "Tipo......:" Get cTipo    Pict "@!"
	@ 09, nCol Say "Docto.....:" Get cDocnr   Pict "@!"
	@ 10, nCol Say "Emissao...:" Get dEmis    Pict "##/##/##"
	@ 11, nCol Say "Vencto....:" Get dVcto    Pict "##/##/##"
	@ 12, nCol Say "Portador..:" Get cPort    Pict "@!"
	@ 13, nCol Say "Valor.....:" Get nVlr     Pict "@E 9,999,999,999.99"
	@ 14, nCol Say "Jr Mes....:" Get nJuro    Pict "999.99"
	@ 15, nCol Say "Data Pgto.:" Get dDataPag Pict "##/##/##"
	@ 16, nCol Say "Vlr Pago..:" Get nVlrPag  Pict "@E 9,999,999,999.99"
	@ 17, nCol Say "Obs.......:" Get cObs1    Pict "@!"
	@ 18, nCol Say "Obs.......:" Get cObs2    Pict "@!"
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		Exit
	endif
	ErrorBeep()
	if Conf( "Confirma Alteracao Do Registro ?" )
		if Pago->(TravaReg())
			Pago->Codi		:= cCodi
			Pago->Docnr 	:= cDocNr
			Pago->Emis		:= dEmis
			Pago->Emis		:= dEmis
			Pago->Port		:= cPort
			Pago->Vcto		:= dVcto
			Pago->Vlr		:= nVlr
			Pago->Tipo		:= cTipo
			Pago->Juro		:= nJuro
			Pago->VlrPag	:= nVlrPag
			Pago->DataPag	:= dDataPag
			Pago->Obs1		:= cObs1
			Pago->Obs2		:= cObs2
			Pago->(Libera())
		endif
	endif
	ResTela( cScreen )
EndDo

Function PagoErrado( cDocnr )
*****************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Pagar->(Order( PAGAR_CODI ))
Pago->(Order( PAGO_DOCNR ))
if Pago->(!DbSeek( cDocnr ))
	Set Rela To Pago->Codi Into Pagar
	Pago->(Escolhe( 03, 01, 22, "Docnr + 'º' + Pagar->Nome", "DOCTO N§  NOME DO FORNECEDOR"))
	Pago->(DbClearRel())
endif
cDocnr := Pago->Docnr
AreaAnt( Arq_Ant, Ind_Ant )
return( OK )


Proc Findou( cTitulo, Tam, TotalCli, TotalJur, TotalGer )
*********************************************************
Qout( cTitulo )
QQout( Space(23), Tran( TotalCli, "@E 999,999.99"))
Qqout( Space(29), Tran( TotalJur, "@E 999,999.99"))
Qqout( Space(01), Tran( Totalger, "@E 999,999.99"))
Qout( Repl( SEP , Tam ) )
return

Proc Findou1( cTitulo, Tam, TotalCli, TotalJur, TotalGer, nDocumento )
**********************************************************************
Qout( cTitulo )
QQout( StrZero( nDocumento, 6 ))
QQout(Space(21), Tran( TotalCli, "@E 999,999.99"))
Qqout(Space(29), Tran( TotalJur, "@E 999,999.99"))
Qqout(Space(01), Tran( Totalger, "@E 999,999.99"))
Qout( Repl( SEP , Tam ) )
return

Proc RelFornecedor()
********************
LOCAL cScreen := SaveScreen( )
LOCAL nChoice := 0
LOCAL aMenu   := {"Individual", "Por Cidade", "Por Selecao", "Geral "}
LOCAL aTipo   := {"Parcial", "Completa"}
LOCAL cCodi   := Space(04)
LOCAL cCida   := Space(25)
LOCAL cEsta   := Space(02)
LOCAL oBloco
LOCAL Tecla
LOCAL nEscolha
LOCAL aSelecionado := {}
FIELD Codi
FIELD Cida
FIELD Esta

WHILE OK
	M_Title("RELACAO DE FORNECEDORES" )
	nChoice := FazMenu( 05, 10, aMenu, Cor())
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1
		cCodi:= Space(04)
		MaBox( 13, 10, 15, 70 )
		@ 14, 11 Say "Codigo..:" Get cCodi Pict "9999" Valid Pagarrado( @cCodi, Row(), Col()+1 )
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Area("Pagar")
		Pagar->(Order( PAGAR_CODI ))
		Pagar->(DbSeek( cCodi ))
		oBloco := {|| Pagar->Codi = cCodi }

	Case nChoice = 2
		cCida := Space(25)
		MaBox( 13, 10, 15, 70 )
		@ 14, 11 Say "Cidade..:" Get cCida Pict "@!"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Area("Pagar")
		Pagar->(Order( PAGAR_CIDA_NOME ))
		Pagar->(DbSeek( cCida ))
		oBloco := {|| Pagar->Cida = cCida }

	Case nChoice = 4
		Area("Pagar")
		Pagar->(Order( PAGAR_NOME ))
		Pagar->(DbGoTop())
		oBloco := {|| Pagar->(!Eof()) }

	Case nChoice = 3
		aSelecionado := {}
		MaBox( 13, 10, 15, 70 )
		WHILE OK
			cCodi := Space(04)
			Write( 14, 35, "Selecionados ¯ " + StrZero( Len( aSelecionado ), 5 ))
			@ 14, 11 Say "Codigo..:"Get cCodi Pict "9999" Valid Pagarrado( @cCodi )
			Read
			if LastKey() = ESC
				Exit
			endif
			if Ascan( aSelecionado, cCodi ) = 0
				 Aadd( aSelecionado, cCodi )
			else
				ErrorBeep()
				Alerta("Erro: Registro Ja Selecionado.")
			endif
		EndDo
		Area("Pagar")
		Pagar->(Order( PAGAR_CODI ))
		oBloco := {|x| Pagar->(DbSeek( aSelecionado[x]))}
	EndCase
	M_Title("ESCOLHA O TIPO" )
	nEscolha := FazMenu( 16, 10, aTipo, Cor())
	Do Case
	Case nEscolha = 1
		Area("Pagar")
		RelForParcial( oBloco, nChoice, aSelecionado )
	Case nEscolha = 2
		Area("Pagar")
		RelForTotal( oBloco, nChoice, aSelecionado )
	EndCase
	ResTela( cScreen )
EndDo

Proc RelForTotal( oBloco, nOrdem, aSelecionado )
************************************************
LOCAL cScreen := SaveScreen()
LOCAL cTitulo := "LISTAGEM DE FORNECEDORES"
LOCAL Tam	  := 80
LOCAL Col	  := 58
LOCAL Pagina  := 0
LOCAL nX 	  := 1
LOCAL nTam	  := 0
LOCAL Pos1
LOCAL Pos2
LOCAL Pos3
FIELD Codi
FIELD Nome
FIELD Fanta
FIELD Ende
FIELD Bair
FIELD Cida
FIELD Esta
FIELD Cep
FIELD Fone
FIELD Fax
FIELD Caixa
FIELD Cgc
FIELD Rg
FIELD Con
FIELD Obs1
FIELD Obs2
FIELD Insc
FIELD Cpf

oMenu:Limpa()
if !Instru80()
	ResTela( cScreen )
	return
endif
Mensagem("Aguarde, Imprimindo. ESC Cancela.", Cor())
PrintOn()
SetPrc(0, 0 )
if ( nTam := Len( aSelecionado )) != 0
	oBloco := {|| nTam >= nX }
endif
WHILE Eval( oBloco, nX ) .AND. Rel_Ok()
	if nTam != 0
		Pagar->(DbSeek( aSelecionado[ nX ]))
	endif
	if Col >= 57
		Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
		Write( 01, 00, Date() )
		Write( 02, 00, Padc( XNOMEFIR, Tam ) )
		Write( 03, 00, Padc( SISTEM_NA4, Tam ) )
		Write( 04, 00, Padc( cTitulo,Tam ) )
		Col := 5
	endif
	Write(	Col, 0 , Repl( SEP,80 ))
	Write( ++Col, 0 , "CODI      ¯  " + CODI)
	Write( ++Col, 0 , "EMPRESA   ¯  " + NOME)
	Write( ++Col, 0 , "SIGLA     ¯  " + SIGLA)
	Write( ++Col, 0 , "FANTASIA  ¯  " + FANTA)
	Write( ++Col, 0 , "ENDERECO  ¯  " + ENDE)
	Write( ++Col, 0 , "BAIRRO    ¯  " + BAIR)
	Write( ++Col, 0 , "CIDADE    ¯  " + CIDA)
	Write( ++Col, 0 , "ESTADO    ¯  " + ESTA)
	Write( ++Col, 0 , "CEP       ¯  " + CEP)
	Write( ++Col, 0 , "TELEFONE  ¯  " + FONE)
	Write( ++Col, 0 , "FAX       ¯  " + FAX)
	Write( ++Col, 0 , "C.POSTAL  ¯  " + CAIXA)
	Write( ++Col, 0 , "CGC/MF    ¯  " + CGC)
	Write( ++Col, 0 , "INSC.EST  ¯  " + INSC)
	Write( ++Col, 0 , "CPF       ¯  " + CPF)
	Write( ++Col, 0 , "RG        ¯  " + RG)
	Write( ++Col, 0 , "CONTATO   ¯  " + CON)
	Write( ++Col, 0 , "OBSERV    ¯  " + OBS)
	Write( ++Col, 0 , Repl( SEP, 80))
	Col += 8
	nX++
	DbSkip(1)
	if Col >= 57
		__Eject()
		Col := 58
	endif
EndDo
__Eject()
PrintOff()
return

Proc RelForParcial( oBloco, nOrdem, aSelecionado )
**************************************************
LOCAL cScreen := SaveScreen()
LOCAL Tam	  := 132
LOCAL Col	  := 58
LOCAL Pagina  := 0
LOCAL nX 	  := 1
LOCAL nTam	  := 0
LOCAL cTitulo

Do Case
Case nOrdem = 1
	cTitulo := "RELACAO INDIVIDUAL DE FORNECEDOR"
Case nOrdem = 2
	cTitulo := "RELACAO DE FORNECEDORES DA CIDADE DE "+ Rtrim( Cida ) + "-" + Esta
Case nOrdem = 3
	cTitulo := "RELACAO DE FORNECEDORES SELECIONADOS "
Case nOrdem = 4
	cTitulo := "RELACAO GERAL DE FORNECEDORES"
EndCase
oMenu:Limpa()
if !Instru80()
	ResTela( cScreen )
	return
endif
PrintOn()
FPrint( PQ )
SetPrc( 0, 0 )
if ( nTam := Len( aSelecionado )) != 0
	oBloco := {|| nTam >= nX }
endif
WHILE Eval( oBloco, nX ) .AND. Rel_Ok()
	if nTam != 0
		Pagar->(DbSeek( aSelecionado[ nX ]))
	endif
	if Col >= 57
		 Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
		 Write( 01, 00, Date() )
		 Write( 02, 00, Padc( XNOMEFIR, Tam ) )
		 Write( 03, 00, Padc( SISTEM_NA4, Tam ) )
		 Write( 04, 00, Padc( cTitulo,Tam ) )
		 Write( 05, 00, Repl( SEP, Tam ) )
		 Write( 06, 00, "CODI" )
		 Write( 06, 05, "EMPRESA" )
		 Write( 06, 47, "ENDERECO" )
		 Write( 06, 79, "CIDADE" )
		 Write( 06,109, "UF" )
		 Write( 06,117, "TELEFONE" )
		 Write( 07,000, Repl( SEP, Tam ) )
		 Col := 8
	endif
	Qout( Codi, Nome, Ende, Cida, Esta, Fone )
	Col++
	nX++
	DbSkip(1)
	if Col >= 57
		__Eject()
		Col := 58
	endif
EndDo
__Eject()
PrintOff()
return

Proc PagaPrn008( cTitulo, oBloco )
**********************************
LOCAL cScreen		:= SaveScreen()
LOCAL Tam			:= 132
LOCAL Col			:= 58
LOCAL Pagina		:= 0
LOCAL nTotTit		:= 0
LOCAL nTotJur		:= 0
LOCAL nJurParcial := 0
LOCAL nTitParcial := 0
LOCAL nSubDoc		:= 0
LOCAL nTotDoc		:= 0
LOCAL nAtraso		:= 0
LOCAL nJuros		:= 0
LOCAL dUltVcto

oMenu:Limpa()
Mensagem("Informa: Aguarde, Imprimindo. ESC Cancela.")
PrintOn()
FPrint( PQ )
SetPrc( 0, 0 )
WHILE !Eof() .AND. Rel_Ok()
	if !Eval( oBloco )
		DbSkip(1)
	endif
	if(( nAtraso := Date() - Vcto ) <= 0, nJuros := 0, nJuros := ( nAtraso * Jurodia ) )
	if Col >= 57
		Pagina++
		Write( 00, 000, "Pagina N§ " + StrZero( Pagina, 3 ) )
		Write( 00, 117, "Horas " + Time() )
		Write( 01, 000, Dtoc( Date() ) )
		Write( 02, 000, Padc( XNOMEFIR, Tam ) )
		Write( 03, 000, Padc( SISTEM_NA4, Tam ) )
		Write( 04, 000, Padc( cTitulo, Tam ) )
		Write( 05, 000, Repl( SEP, Tam ) )
		Write( 06, 000, "CODI NOME DO FORNECEDOR        TIPO    DOCTO N§   PORTADOR EMISSAO    VENCTO     VALOR TITULO ATRASO       JURO/DIA      VALOR+JUROS")
		Write( 07, 000, Repl( SEP, Tam ) )
		Col := 8
	endif
	Qout( Codi, Left( Nome, 25), Tipo, Docnr,;
			Port, Emis, Vcto, Tran( Vlr, "@E 9,999,999,999.99"),;
			Str( nAtraso, 6), Tran( Jurodia, "@E 999,999,999.99"),;
			Tran( Vlr+nJuros, "@E 9,999,999,999.99"))
	Col			++
	nTitParcial += Vlr
	nJurParcial += Vlr + nJuros
	nTotTit		+= Vlr
	nTotJur		+= Vlr + nJuros
	nSubDoc		++
	nTotDoc		++
	dUltVcto 	:= Vcto
	DbSkip(1)
	if Col >= 57
		Qout()
		Qout( "*  PARCIAL * " + Tran( nSubDoc, "9999"))
		QQout( Space(49), Tran( nTitParcial,"@E 9,999,999,999.99"))
		QQout( Space(22), Tran( nJurParcial,"@E 9,999,999,999.99"))
		Qout(  Repl( SEP, Tam ))
		nSubDoc		:= 0
		nTitParcial := 0
		nJurParcial := 0
		Col			+= 3
		__Eject()
		Loop
	endif
	if Eof()
		Qout(  "** TOTAL GERAL ** " + Tran( nTotDoc, "9999") + Space( Tam-86))
		QQout( Space(08), Tran( nTotTit,"@E 9,999,999,999.99"))
		QQout( Space(22), Tran( nTotJur,"@E 9,999,999,999.99"))
		Col ++
		__Eject()
	endif
EndDo
PrintOff()
ResTela( cScreen )
return


Proc PagosTitulos()
*******************
LOCAL cScreen := SaveScreen( )
LOCAL aMenu   := {"Individual", "Por Periodo", "Por Portador", "Por Tipo", "Ordem de Pgto", "Totalizado" }
LOCAL dIni	  := Date()-30
LOCAL dFim	  := Date()
LOCAL xAlias  := FTempName()
LOCAL xNtx	  := FTempName()
LOCAL nChoice := 1
LOCAL cString := ''
LOCAL aStru
LOCAL cNome
LOCAL cCodi
FIELD DataPag
FIELD Codi
FIELD Port
FIELD Tipo
FIELD Nome

WHILE OK
	oMenu:Limpa()
	M_Title('RELATORIO DE TITULOS PAGOS')
	nChoice := FazMenu( 05, 10, aMenu )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		return

	Case nChoice = 1
		cCodi := Space(04)
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 14, 10, 18, 71 )
		@ 15, 11 Say "Codigo.......:" Get cCodi Pict "9999" Valid Pagarrado( @cCodi, Row(), Col()+1)
		@ 16, 11 Say "Data Inicial.:" Get dIni  Pict  "##/##/##"
		@ 17, 11 Say "Data Final...:" Get dFim  Pict  "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		if !InsTru80()
			ResTela( cScreen )
			Loop
		endif
		Pagar->(Order( PAGAR_CODI ))
		Pago->(Order( PAGO_CODI_DATAPAG ))
		if Pago->(!DbSeek( cCodi ))
			Nada()
			ResTela( cScreen )
			Loop
		endif
		Mensagem('Aguarde, Filtrando.')
		aStru  := Pago->(DbStruct())
		Aadd( aStru, {"NOME", "C", 40, 0})
		oBloco := {|| Pago->DataPag >= dIni .AND. Pago->DataPag <= dFim }
		DbCreate( xAlias, aStru )
		Use (xAlias) Exclusive New Alias xTemp
		WHILE Pago->Codi = cCodi
			if Eval( oBloco )
				cCodi := Pago->Codi
				Pagar->(DbSeek( cCodi ))
				cNome := Pagar->Nome
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Pago->(FieldGet( nField ))))
				Next
				xTemp->Nome := cNome
			endif
			Pago->(DbSkip(1))
		EndDO
		xTemp->(DbGoTop())
		if xTemp->(Eof())
			Nada()
			xTemp->(DbCloseArea())
			Ferase( xAlias )
			Ferase( xNtx )
			ResTela( cScreen )
			Loop
		endif
		Area("xTemp")
		Inde On xTemp->Nome + DateToStr( xTemp->DataPag ) To (xNtx )
		xTemp->(DbGoTop())
		cString := 'FORNECEDOR : ' + Alltrim( cNome ) + ' NO PERIODO DE ' + dtoc( dIni ) + ' A ' + dToc( dFim )
		PagaPrn001( cString)
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )
		ResTela( cScreen )
		Loop

	Case nChoice = 2
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 14, 10, 17, 71 )
		@ 15, 11 Say "Data Inicial.:" Get dIni  Pict  "##/##/##"
		@ 16, 11 Say "Data Final...:" Get dFim  Pict  "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		if !InsTru80()
			ResTela( cScreen )
			Loop
		endif
		Pagar->(Order( PAGAR_CODI ))
		Pago->(Order( PAGO_DATAPAG ))
		Set Soft On
		Pago->(DbSeek( dIni ))
		Set Soft Off
		Mensagem('Aguarde, Filtrando.')
		aStru  := Pago->(DbStruct())
		Aadd( aStru, {"NOME", "C", 40, 0})
		oBloco := {|| Pago->DataPag >= dIni .AND. Pago->DataPag <= dFim }
		DbCreate( xAlias, aStru )
		Use (xAlias) Exclusive New Alias xTemp
		WHILE Eval( oBloco ) .AND. Rep_Ok()
			cCodi := Pago->Codi
			Pagar->(DbSeek( cCodi ))
			cNome := Pagar->Nome
			xTemp->(DbAppend())
			For nField := 1 To FCount()
				xTemp->( FieldPut( nField, Pago->(FieldGet( nField ))))
			Next
			xTemp->Nome := cNome
			Pago->(DbSkip(1))
		EndDO
		xTemp->(DbGoTop())
		if xTemp->(Eof())
			Nada()
			xTemp->(DbCloseArea())
			Ferase( xAlias )
			Ferase( xNtx )
			ResTela( cScreen )
			Loop
		endif
		Area("xTemp")
		Inde On xTemp->Nome + DateToStr( xTemp->DataPag ) To (xNtx )
		xTemp->(DbGoTop())
		cString := 'NO PERIODO DE ' + dtoc( dIni ) + ' A ' + dToc( dFim )
		PagaPrn001( cString)
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )
		ResTela( cScreen )
		Loop

	Case nChoice = 3
		cPort := Space(10)
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 14, 10, 18, 67 )
		@ 15, 11 Say "Portador.....:" Get cPort Pict "@!"
		@ 16, 11 Say "Data Inicial.:" Get dIni  Pict "##/##/##"
		@ 17, 11 Say "Data Final...:" Get dFim  Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		if !InsTru80()
			ResTela( cScreen )
			Loop
		endif
		Pagar->(Order( PAGAR_CODI ))
		Pago->(Order( PAGO_DATAPAG ))
		Set Soft On
		Pago->(DbSeek( dIni ))
		Set Soft Off
		Mensagem('Aguarde, Filtrando.')
		aStru   := Pago->(DbStruct())
		Aadd( aStru, {"NOME", "C", 40, 0})
		oBloco  := {|| Pago->DataPag >= dIni .AND. Pago->DataPag <= dFim }
		oBloco1 := {|| Pago->Port = cPort }
		DbCreate( xAlias, aStru )
		Use (xAlias) Exclusive New Alias xTemp
		WHILE Eval( oBloco ) .AND. Rep_Ok()
			if Eval( oBloco1 )
				cCodi := Pago->Codi
				Pagar->(DbSeek( cCodi ))
				cNome := Pagar->Nome
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Pago->(FieldGet( nField ))))
				Next
				xTemp->Nome := cNome
			endif
			Pago->(DbSkip(1))
		EndDO
		xTemp->(DbGoTop())
		if xTemp->(Eof())
			Nada()
			xTemp->(DbCloseArea())
			Ferase( xAlias )
			Ferase( xNtx )
			ResTela( cScreen )
			Loop
		endif
		Area("xTemp")
		Inde On xTemp->Nome + DateToStr( xTemp->DataPag ) To (xNtx )
		xTemp->(DbGoTop())
		cString := 'PORTADOR : ' + Alltrim( cPort ) + ' NO PERIODO DE ' + dtoc( dIni ) + ' A ' + dToc( dFim )
		PagaPrn001( cString )
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )
		ResTela( cScreen )
		Loop

	Case nChoice = 4 // Por Tipo
		cTipo := Space(6)
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 14, 10, 18, 67 )
		@ 15, 11 Say "Tipo.........:" Get cTipo Pict "@!"
		@ 16, 11 Say "Data Inicial.:" Get dIni  Pict "##/##/##"
		@ 17, 11 Say "Data Final...:" Get dFim  Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		if !InsTruim()
			ResTela( cScreen )
			Loop
		endif
		Pagar->(Order( PAGAR_CODI ))
		Pago->(Order( PAGO_DATAPAG ))
		Set Soft On
		Pago->(DbSeek( dIni ))
		Set Soft Off
		Mensagem('Aguarde, Filtrando.')
		aStru   := Pago->(DbStruct())
		Aadd( aStru, {"NOME", "C", 40, 0})
		oBloco  := {|| Pago->DataPag >= dIni .AND. Pago->DataPag <= dFim }
		oBloco1 := {|| Pago->Tipo = cTipo }
		DbCreate( xAlias, aStru )
		Use (xAlias) Exclusive New Alias xTemp
		WHILE Eval( oBloco ) .AND. Rep_Ok()
			if Eval( oBloco1 )
				cCodi := Pago->Codi
				Pagar->(DbSeek( cCodi ))
				cNome := Pagar->Nome
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Pago->(FieldGet( nField ))))
				Next
				xTemp->Nome := cNome
			endif
			Pago->(DbSkip(1))
		EndDO
		xTemp->(DbGoTop())
		if xTemp->(Eof())
			Nada()
			xTemp->(DbCloseArea())
			Ferase( xAlias )
			Ferase( xNtx )
			ResTela( cScreen )
			Loop
		endif
		Area("xTemp")
		Inde On xTemp->Nome + DateToStr( xTemp->DataPag ) To (xNtx )
		xTemp->(DbGoTop())
		cString := 'TIPO : ' + Alltrim( cTipo ) + ' NO PERIODO DE ' + dtoc( dIni ) + ' A ' + dToc( dFim )
		PagaPrn001( cString )
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )
		ResTela( cScreen )
		Loop

	Case nChoice = 5 // Ordem de Vcto
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 14, 10, 17, 67 )
		@ 15, 11 Say "Data Inicial.:" Get dIni  Pict "##/##/##"
		@ 16, 11 Say "Data Final...:" Get dFim  Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		if !InsTruim()
			ResTela( cScreen )
			Loop
		endif
		Pagar->(Order( PAGAR_CODI ))
		Pago->(Order( PAGO_DATAPAG ))
		Set Soft On
		Pago->(DbSeek( dIni ))
		Set Soft Off
		Mensagem('Aguarde, Filtrando.')
		aStru   := Pago->(DbStruct())
		Aadd( aStru, {"NOME", "C", 40, 0})
		oBloco  := {|| Pago->DataPag >= dIni .AND. Pago->DataPag <= dFim }
		DbCreate( xAlias, aStru )
		Use (xAlias) Exclusive New Alias xTemp
		WHILE Eval( oBloco ) .AND. Rep_Ok()
			cCodi := Pago->Codi
			Pagar->(DbSeek( cCodi ))
			cNome := Pagar->Nome
			xTemp->(DbAppend())
			For nField := 1 To FCount()
				xTemp->( FieldPut( nField, Pago->(FieldGet( nField ))))
			Next
			xTemp->Nome := cNome
			Pago->(DbSkip(1))
		EndDO
		xTemp->(DbGoTop())
		if xTemp->(Eof())
			Nada()
			xTemp->(DbCloseArea())
			Ferase( xAlias )
			Ferase( xNtx )
			ResTela( cScreen )
			Loop
		endif
		Area("xTemp")
		Inde On xTemp->DataPag To (xNtx )
		xTemp->(DbGoTop())
		cString := 'EM ORDEM DE PAGTO NO PERIODO DE ' + dtoc( dIni ) + ' A ' + dToc( dFim )
		PagaPrn003(, cString)
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )
		ResTela( cScreen )
		Loop

	Case nChoice = 6 // Totalizado
		TotalPago()

	EndCase
EndDo

Proc PagaPrn003( oBloco, cString )
**********************************
LOCAL cScreen := SaveScreen()
LOCAL TotTit := 0
LOCAL TotRec := 0
LOCAL nParQt := 0
LOCAL nTotQt := 0
LOCAL Titulo
LOCAL Tam
LOCAL Col
LOCAL Pagina
LOCAL Atraso
FIELD DataPag
FIELD Vcto
FIELD Codi
FIELD Nome
FIELD Tipo
FIELD Docnr
FIELD Emis
FIELD Vlr
FIELD VlrPag
FIELD Port
FIELD Ndeb

oMenu:Limpa()
Tam		:= 132
Col		:= 9
Pagina	:= 0
TotTit	:= 0
TotRec	:= 0
cSistema := SISTEM_NA4
cRelato	:= 'ROL DE TITULOS PAGOS '
cRelato	+= cString
cCabeca	:= "CODI NOME DO FORNECEDOR           TIPO     DOCTO  N§ EMISSAO    VENCTO     VALOR TITULO DATA PGT   ATR       VALOR PAGO PORTADOR  ND"
Mensagem("Aguarde... Imprimindo. ESC Cancela.", Cor())
PrintOn()
FPrint( PQ )
SetPrc( 0,0 )
CabecRel( XNOMEFIR, Tam, ++Pagina, cSistema, cRelato, cCabeca )
Col := 9
WHILE !Eof().AND. Rel_Ok()
	if oBloco != NIL
		if !Eval( oBloco )
			DbSkip(1)
			Loop
		endif
	endif
	Atraso := ( DataPag - Vcto )
	if ( Col >= 57 )
		__Eject()
		CabecRel( XNOMEFIR, Tam, ++Pagina, cSistema, cRelato, cCabeca )
		Col := 9
	endif
	Qout( Codi, Left( Nome, 30), Tipo, Docnr, Emis, Vcto, Tran( Vlr, "@E 9,999,999,999.99"),;
			DataPag, Str( Atraso,5), Tran( VlrPag, "@E 9,999,999,999.99"),;
			Port, if( nDeb = "NAO", "N", "S"))
	Col++
	nParQt ++
	nTotQt ++
	TotTit += Vlr
	TotRec += VlrPag
	if Col = 57
		Write( Col+1,0, Repl( SEP, Tam ) )
	endif
	DbSkip()
EndDo
Write( Col+1, 000, ' ** Total ** ' + StrZero( nParQt, 5))
Write( Col+1, 071, Tran( TotTit,"@E 9,999,999,999.99" ) )
Write( Col+1, 103, Tran( TotRec,"@E 9,999,999,999.99" ) )
__Eject()
PrintOff()
return

Proc PagaPrn001( cString )
**************************
LOCAL cScreen := SaveScreen()
LOCAL TotTit := 0
LOCAL ParTit := 0
LOCAL TotRec := 0
LOCAL ParRec := 0
LOCAL nParQt := 0
LOCAL nTotQt := 0
LOCAL Col	 := 58
LOCAL Titulo
LOCAL Tam
LOCAL Pagina
LOCAL Atraso
FIELD DataPag
FIELD Vcto
FIELD Codi
FIELD Nome
FIELD Tipo
FIELD Docnr
FIELD Emis
FIELD Vlr
FIELD VlrPag
FIELD Port
FIELD Ndeb

oMenu:Limpa()
Tam		:= 132
Pagina	:= 0
TotTit	:= 0
TotRec	:= 0
cSistema := SISTEM_NA4
cRelato	:= 'ROL DE TITULOS PAGOS '
cRelato	+= cString
cCabeca	:= "CODI NOME DO FORNECEDOR           TIPO     DOCTO  N§ EMISSAO    VENCTO     VALOR TITULO DATA PGT   ATR       VALOR PAGO PORTADOR  ND"
Mensagem("Aguarde... Imprimindo. ESC Cancela.", Cor())
PrintOn()
FPrint( PQ )
SetPrc( 0,0 )
cUltCodi := xTemp->Codi
WHILE !Eof().AND. Rel_Ok()
	Atraso := ( DataPag - Vcto )
	if Col >= 57
		CabecRel( XNOMEFIR, Tam, ++Pagina, cSistema, cRelato, cCabeca )
		Col := 9
	endif
	Qout( Codi, Left( Nome, 30), Tipo, Docnr, Emis, Vcto, Tran( Vlr, "@E 9,999,999,999.99"),;
			DataPag, Str( Atraso,5), Tran( VlrPag, "@E 9,999,999,999.99"),;
			Port, if( nDeb = "NAO", "N", "S"))
	Col		++
	nParQt	++
	nTotQt	++
	TotTit	+= Vlr
	TotRec	+= VlrPag
	ParTit	+= Vlr
	ParRec	+= VlrPag
	cUltCodi := xTemp->Codi
	DbSkip(1)
	if cUltCodi != Codi
		Qout()
		Col	 ++
		Qout(' ** Parcial ** ', StrZero( nParQt, 5), Space(48),;
		Tran( ParTit,"@E 9,999,999,999.99" ), Space(14),;
		Tran( ParRec,"@E 9,999,999,999.99" ))
		Col	 ++
		Qout()
		Col	 ++
		nParQt := 0
		ParTit := 0
		ParRec := 0
		if cUltCodi != Codi
			cUltCodi := Codi
		endif
	endif
	if Col >= 56
		__Eject()
		Col := 58
	endif
EndDo
Qout(' **  Total  ** ', StrZero( nTotQt, 5), Space(48),;
Tran( TotTit,"@E 9,999,999,999.99" ), Space(14),;
Tran( TotRec,"@E 9,999,999,999.99" ))
__Eject()
PrintOff()
return

*:---------------------------------------------------------------------------------------------------------------------------------

Function oMenuPagalan()
***********************
LOCAL AtPrompt := {}
LOCAL cStr_Get
LOCAL cStr_Sombra

if !aPermissao[SCI_CONTAS_A_PAGAR]
   return( AtPrompt )
endif

if oAmbiente:Get_Ativo
	cStr_Get := "Desativar Get Tela Cheia"
else
	cStr_Get := "Ativar Get Tela Cheia"
endif
if oMenu:Sombra
	cStr_Sombra := "DesLigar Sombra"
else
	cStr_Sombra := "Ligar Sombra"
endif
AADD( AtPrompt, {"Sair",        {"Encerrar Sessao"}})
AADD( AtPrompt, {"Fornecedor",  {"Inclusao","Alteracao Individual","Exclusao Individual","Consulta Individual","Alteracao Geral", "Exclusao Geral","Consulta Geral"}})
AADD( AtPrompt, {"Lancamentos", {"Titulos", "Baixas", "Alteracao", "Exclusao","Requisicao"}})
AADD( AtPrompt, {"Relatorios",  {"Rol de Fornecedores","Rol Titulos a Pagar","Rol Titulos Pagos","Etiquetas Fornecedores"}})
AADD( AtPrompt, {"Consulta",    {"Titulos a Pagar","Titulos Pagos"}})
AADD( AtPrompt, {"Posicao",     {"Pagar por Fornecedor","Pagar por Periodo","Pagar Por Tipo", "Pagar Geral", "", "Pago por Fornecedor","Pago por Periodo", "Pago Geral","",'Posicao Pagar/Pago for Nota', "Grafico Contas a Pagar"}})
Aadd( AtPrompt, {"Cep",         {"Inclusao","Alteracao","Exclusao","Consulta","Impressao"}})
return( AtPrompt )

*:==================================================================================================================================

Function aDispPagalan()
***********************
LOCAL oPagaLan := TIniNew( oAmbiente:xUsuario + ".INI")
LOCAL AtPrompt := oMenuPagaLan()
LOCAL nMenuH   := Len(AtPrompt)
LOCAL aDisp 	:= Array( nMenuH, 22 )
LOCAL aMenuV   := {}

if !aPermissao[SCI_CONTAS_A_PAGAR]
	return( aDisp )
endif

Mensagem("Aguarde, Verificando Diretivas do CONTAS A PAGAR.")
return( aDisp := ReadIni("pagalan", nMenuH, aMenuV, AtPrompt, aDisp, oPagaLan))

*:==================================================================================================================================

Proc TituloAPagar()
*******************
LOCAL cScreen	:= SaveScreen( )
LOCAL GetList	:= {}
LOCAL dIni		:= Date()-30
LOCAL dFim		:= Date()
LOCAL cCodi 	:= Space(04)
LOCAL cPort 	:= Space(10)
LOCAL cTipo 	:= Space(06)
LOCAL aMenu 	:= {"Individual","Por Periodo","Ordem Vcto","Por Portador", "Por Tipo", "Totalizado", "Fluxo Sintetico", "Ordem Alfabetica"}
LOCAL cTitulo	:= ''
LOCAL xAlias	:= FTempName()
LOCAL xNtx		:= FTempName()
LOCAL nField
LOCAL nCount
LOCAL oBloco
LOCAL nChoice
LOCAL Esc
LOCAL Tecla
LOCAL aStru
LOCAL cDeleteFile

WHILE OK
	oMenu:Limpa()
	M_Title("RELATORIO DE TITULOS A PAGAR" )
	nChoice := FazMenu( 02, 10, aMenu )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1
		cCodi := Space(04)
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 14, 10, 18, 67 )
      @ 15, 11 Say "Codigo.......:" Get cCodi Pict "9999" Valid Pagarrado( @cCodi, Row(), Col()+1) .AND. Pagaber( cCodi )
		@ 16, 11 Say "Data Inicial.:" Get dIni  Pict  "##/##/##"
		@ 17, 11 Say "Data Final...:" Get dFim  Pict  "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Area("PagaMov")
		Pagamov->(Order( PAGAMOV_CODI ))
      if Pagamov->(!DbSeek( cCodi ))
			Nada()
			ResTela( cScreen )
			Loop
		endif
		xNtx			:= TempNew()
		cDeletefile := TempNew()
		aStru 		:= Pagamov->(DbStruct())
      nCount      := Pagamov->(FCount())
		DbCreate( cDeleteFile, aStru )
		Use (cDeleteFile) Alias xTemp Exclusive New
		WHILE Pagamov->Codi = cCodi
			if Pagamov->Vcto >= dIni .AND. Pagamov->Vcto <= dFim
				xTemp->(DbAppend())
				For nField := 1 To nCount
					xTemp->( FieldPut( nField, Pagamov->(FieldGet( nField ))))
				Next
			endif
			Pagamov->(DbSkip(1))
		EndDo
		Pagar->(Order( PAGAR_CODI ))
		Area("xTemp")
		Set Rela To xTemp->Codi Into Pagar
      Inde On xTemp->Codi + xTemp->(DateToStr( Vcto )) To ( xNtx )
		Mensagem('Aguarde, Filtrando.')
		xTemp->(DbGoTop())
		if !InsTru80()
			xTemp->(DbClearRel())
			xTemp->(DbCloseArea())
			Ferase( cDeleteFile )
			Ferase( xNtx )
			ResTela( cScreen )
			Loop
		endif
		PagaPrn002( dIni, dFim, nChoice )
		xTemp->(DbClearRel())
		xTemp->(DbCloseArea())
		Ferase( cDeleteFile )
		Ferase( xNtx )
		ResTela( cScreen )
		Loop

	Case nChoice = 2 // Por Periodo
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 14, 10, 17, 67 )
		@ 15, 11 Say "Data Inicial.:" Get dIni Pict "##/##/##"
		@ 16, 11 Say "Data Final...:" Get dFim Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Area("PagaMov")
		Pagamov->(Order( PAGAMOV_VCTO ))
		Set Soft On
		Pagamov->(DbSeek( dIni ))
		Set Soft Off
		xNtx			:= TempNew()
		cDeletefile := TempNew()
		aStru 		:= Pagamov->(DbStruct())
		DbCreate( cDeleteFile, aStru )
		Use (cDeleteFile) Alias xTemp Exclusive New
		WHILE Pagamov->Vcto >= dIni .AND. Pagamov->Vcto <= dFim
			xTemp->(DbAppend())
			For nField := 1 To FCount()
				xTemp->( FieldPut( nField, Pagamov->(FieldGet( nField ))))
			Next
			Pagamov->(DbSkip(1))
		EndDo
		Pagar->(Order( PAGAR_CODI ))
		Area("xTemp")
		Set Rela To xTemp->Codi Into Pagar
		Inde On xTemp->Codi + xTemp->(DateToStr( Vcto )) To ( xNtx )
		Mensagem('Aguarde, Filtrando.')
		xTemp->(DbGoTop())
		if !InsTruim()
			xTemp->(DbClearRel())
			xTemp->(DbCloseArea())
			Ferase( cDeleteFile )
			Ferase( xNtx )
			ResTela( cScreen )
			Loop
		endif
		PagaPrn002( dIni, dFim, nChoice )
		xTemp->(DbClearRel())
		xTemp->(DbCloseArea())
		Ferase( cDeleteFile )
		Ferase( xNtx )
		ResTela( cScreen )
		Loop

	Case nChoice = 3 // Ordem de Vcto
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 14, 10, 17, 67 )
		@ 15, 11 Say "Data Inicial.:" Get dIni  Pict "##/##/##"
		@ 16, 11 Say "Data Final...:" Get dFim  Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		if !InsTruim()
			ResTela( cScreen )
			Loop
		endif
		oBloco := {|| !Eof() }
		Pagar->(Order( PAGAR_CODI ))
		Area( "PagaMov" )
		Pagamov->(Order( PAGAMOV_VCTO ))
		Set Soft On
		Pagamov->(!DbSeek( dIni ))
		Set Soft Off
		Mensagem('Aguarde, Filtrando.')
		aStru := Pagamov->(DbStruct())
		DbCreate( xAlias, aStru )
		Use (xAlias) Exclusive New Alias xTemp
		WHILE Pagamov->Vcto >= dIni .AND. Pagamov->Vcto <= dFim .AND. Pagamov->(!Eof())
			xTemp->(DbAppend())
			For nField := 1 To FCount()
				xTemp->( FieldPut( nField, Pagamov->(FieldGet( nField ))))
			Next
			Pagamov->(DbSkip(1))
		EndDo
		xTemp->(DbGoTop())
		if xTemp->(Eof())
			Nada()
			xTemp->(DbCloseArea())
			Ferase( xAlias )
			Ferase( xNtx )
			ResTela( cScreen )
			Loop
		endif
		Inde On xTemp->Vcto To (xNtx )
		Set Rela To xTemp->Codi Into Pagar
		xTemp->(DbGoTop())
		cTitulo := 'ROL GERAL TITULOS A PAGAR REF ' + Dtoc( dIni ) + ' A ' + Dtoc( dFim )
		PagaPrn007( cTitulo, oBloco )
		xTemp->(DbClearRel())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )
		ResTela( cScreen )

	Case nChoice = 4 // Por Portador
		cPort := Space(10)
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 14, 10, 18, 67 )
		@ 15, 11 Say "Portador.....:" Get cPort Pict "@!"
		@ 16, 11 Say "Data Inicial.:" Get dIni  Pict "##/##/##"
		@ 17, 11 Say "Data Final...:" Get dFim  Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		if !InsTruim()
			ResTela( cScreen )
			Loop
		endif
		oBloco := {|| Pagamov->Port = cPort }
		Pagar->(Order( PAGAR_CODI ))
		Area( "PagaMov" )
		Pagamov->(Order( PAGAMOV_VCTO ))
		Set Soft On
		Pagamov->(!DbSeek( dIni ))
		Set Soft Off
		Mensagem('Aguarde, Filtrando.')
		aStru := Pagamov->(DbStruct())
		DbCreate( xAlias, aStru )
		Use (xAlias) Exclusive New Alias xTemp
		WHILE Pagamov->Vcto >= dIni .AND. Pagamov->Vcto <= dFim .AND. Pagamov->(!Eof())
			if Eval( oBloco )
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Pagamov->(FieldGet( nField ))))
				Next
			endif
			Pagamov->(DbSkip(1))
		EndDo
		xTemp->(DbGoTop())
		if xTemp->(Eof())
			Nada()
			xTemp->(DbCloseArea())
			Ferase( xAlias )
			Ferase( xNtx )
			ResTela( cScreen )
			Loop
		endif
		Inde On xTemp->Vcto To (xNtx )
		Set Rela To xTemp->Codi Into Pagar
		xTemp->(DbGoTop())
		cTitulo := 'ROL TITULOS A PAGAR REF ' + Dtoc( dIni ) + ' A ' + Dtoc( dFim ) + ' - PORTADOR ' + cPort
		PagaPrn007( cTitulo, {||!Eof() })
		xTemp->(DbClearRel())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )
		ResTela( cScreen )

	Case nChoice = 5 // Por Tipo
		cTipo := Space(06)
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 14, 10, 18, 67 )
		@ 15, 11 Say "Tipo.........:" Get cTipo Pict "@!"
		@ 16, 11 Say "Data Inicial.:" Get dIni  Pict "##/##/##"
		@ 17, 11 Say "Data Final...:" Get dFim  Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		if !InsTruim()
			ResTela( cScreen )
			Loop
		endif
		oBloco := {|| Pagamov->Tipo = cTipo }
		Pagar->(Order( PAGAR_CODI ))
		Area( "PagaMov" )
		Pagamov->(Order( PAGAMOV_VCTO ))
		Set Soft On
		Pagamov->(!DbSeek( dIni ))
		Set Soft Off
		Mensagem('Aguarde, Filtrando.')
		aStru := Pagamov->(DbStruct())
		DbCreate( xAlias, aStru )
		Use (xAlias) Exclusive New Alias xTemp
		WHILE Pagamov->Vcto >= dIni .AND. Pagamov->Vcto <= dFim .AND. Pagamov->(!Eof())
			if Eval( oBloco )
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Pagamov->(FieldGet( nField ))))
				Next
			endif
			Pagamov->(DbSkip(1))
		EndDo
		xTemp->(DbGoTop())
		if xTemp->(Eof())
			Nada()
			xTemp->(DbCloseArea())
			Ferase( xAlias )
			Ferase( xNtx )
			ResTela( cScreen )
			Loop
		endif
		Inde On xTemp->Vcto To (xNtx )
		Set Rela To xTemp->Codi Into Pagar
		xTemp->(DbGoTop())
		cTitulo := 'ROL TITULOS A PAGAR REF ' + Dtoc( dIni ) + ' A ' + Dtoc( dFim ) + ' - TIPO ' + cTipo
		PagaPrn007( cTitulo, {||!Eof() })
		xTemp->(DbClearRel())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )
		ResTela( cScreen )

	Case nChoice = 6 // Totalizado
		TotalPagar()

	Case nChoice = 7 // Fluxo Sintetico
		FluxoPagar()

	Case nChoice = 8 // Ordem Alfabetica
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 14, 10, 17, 67 )
		@ 15, 11 Say "Data Inicial.:" Get dIni  Pict "##/##/##"
		@ 16, 11 Say "Data Final...:" Get dFim  Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		if !InsTruim()
			ResTela( cScreen )
			Loop
		endif
		oBloco := {|| !Eof() }
		Pagar->(Order( PAGAR_CODI ))
		Area( "PagaMov" )
		Pagamov->(Order( PAGAMOV_VCTO ))
		Set Soft On
		Pagamov->(!DbSeek( dIni ))
		Set Soft Off
		Mensagem('Aguarde, Filtrando.')
		aStru := Pagamov->(DbStruct())
		Aadd( aStru, {"NOME",  "C", 40, 0})
		DbCreate( xAlias, aStru )
		Use (xAlias) Exclusive New Alias xTemp
		WHILE Pagamov->Vcto >= dIni .AND. Pagamov->Vcto <= dFim .AND. Pagamov->(!Eof())
			xTemp->(DbAppend())
			For nField := 1 To FCount()
				xTemp->( FieldPut( nField, Pagamov->(FieldGet( nField ))))
				Pagar->(DbSeek( Pagamov->Codi ))
				xTemp->Nome := Pagar->Nome
			Next
			Pagamov->(DbSkip(1))
		EndDo
		xTemp->(DbGoTop())
		if xTemp->(Eof())
			Nada()
			xTemp->(DbCloseArea())
			Ferase( xAlias )
			Ferase( xNtx )
			ResTela( cScreen )
			Loop
		endif
		Inde On xTemp->Nome To (xNtx )
		xTemp->(DbGoTop())
		cTitulo := 'ROL GERAL TITULOS A PAGAR REF ' + Dtoc( dIni ) + ' A ' + Dtoc( dFim )
		PagaPrn008( cTitulo, oBloco )
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )
		ResTela( cScreen )
	EndCase
EndDo

Proc PagaPrn007( cTitulo, oBloco )
**********************************
LOCAL cScreen		:= SaveScreen()
LOCAL Tam			:= 132
LOCAL Col			:= 58
LOCAL Pagina		:= 0
LOCAL nTotTit		:= 0
LOCAL nTotJur		:= 0
LOCAL nJurParcial := 0
LOCAL nTitParcial := 0
LOCAL nSubDoc		:= 0
LOCAL nTotDoc		:= 0
LOCAL nAtraso		:= 0
LOCAL nJuros		:= 0
LOCAL dUltVcto

oMenu:Limpa()
Mensagem("Informa: Aguarde, Imprimindo. ESC Cancela.")
PrintOn()
FPrint( PQ )
SetPrc( 0, 0 )
WHILE !Eof() .AND. Rel_Ok()
	if !Eval( oBloco )
		DbSkip(1)
	endif
	if(( nAtraso := Date() - Vcto ) <= 0, nJuros := 0, nJuros := ( nAtraso * Jurodia ) )
	if Col >= 57
		Pagina++
		Write( 00, 000, "Pagina N§ " + StrZero( Pagina, 3 ) )
		Write( 00, 117, "Horas " + Time() )
		Write( 01, 000, Dtoc( Date() ) )
		Write( 02, 000, Padc( XNOMEFIR, Tam ) )
		Write( 03, 000, Padc( SISTEM_NA4, Tam ) )
		Write( 04, 000, Padc( cTitulo, Tam ) )
		Write( 05, 000, Repl( SEP, Tam ) )
		Write( 06, 000, "CODI NOME DO FORNECEDOR        TIPO    DOCTO N§   PORTADOR EMISSAO    VENCTO     VALOR TITULO ATRASO       JURO/DIA      VALOR+JUROS")
		Write( 07, 000, Repl( SEP, Tam ) )
		Col := 8
	endif
	Qout( Codi, Left( Pagar->Nome,25), Tipo, Docnr,;
			Port, Emis, Vcto, Tran( Vlr, "@E 9,999,999,999.99"),;
			Str( nAtraso, 6), Tran( Jurodia, "@E 999,999,999.99"),;
			Tran( Vlr+nJuros, "@E 9,999,999,999.99"))
	Col			++
	nTitParcial += Vlr
	nJurParcial += Vlr + nJuros
	nTotTit		+= Vlr
	nTotJur		+= Vlr + nJuros
	nSubDoc		++
	nTotDoc		++
	dUltVcto 	:= Vcto
	DbSkip(1)
	if dUltVcto  != Vcto
		Qout()
		Qout( "* TOTAL DIA " + Dtoc( dUltVcto ) + " * " + Tran( nSubDoc, "9999"))
		QQout( Space(49), Tran( nTitParcial,"@E 9,999,999,999.99"))
		QQout( Space(22), Tran( nJurParcial,"@E 9,999,999,999.99"))
		Qout(  Repl( SEP, Tam ))
		nSubDoc		:= 0
		nTitParcial := 0
		nJurParcial := 0
		Col			+= 3
	endif
	if Col >= 57
		__Eject()
		Loop
	endif
	if Eof()
		Qout(  "** TOTAL GERAL ** " + Tran( nTotDoc, "9999") + Space( Tam-86))
		QQout( Space(08), Tran( nTotTit,"@E 9,999,999,999.99"))
		QQout( Space(22), Tran( nTotJur,"@E 9,999,999,999.99"))
		Col ++
		__Eject()
	endif
EndDo
PrintOff()
ResTela( cScreen )
return
