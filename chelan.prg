/*
  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 Ý³																								 ³
 Ý³	Programa.....: CHELAN.PRG															 ³
 Ý³	Aplicacaoo...: SISTEMA DE CONTAS CORRENTES									 ³
 Ý³   Versao.......: 3.3.00                                                 ³
 Ý³	Programador..: Vilmar Catafesta													 ³
 Ý³   Empresa......: Microbras Com de Prod de Informatica Ltda              ³
 Ý³	Inicio.......: 12 de Novembro de 1991. 										 ³
 Ý³   Ult.Atual....: 20 de Janeiro de 2001.                                 ³
 Ý³	Compilacao...: Clipper 5.2e														 ³
 Ý³   Linker.......: Blinker 5.00                                           ³
 Ý³	Bibliotecas..: Clipper/Funcoes/Mouse/Funcky15/Funcky50/Classe/Classic ³
 ÝÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "sci.ch"

Proc Chelan()
*************
LOCAL lOk       := OK
LOCAL cCaixa	 := Space(04)
LOCAL cVendedor := Space(40)
LOCAL Op 		 := 1
*:==================================================================================================================================
SetKey( -7, 		  {|| AcionaSpooler()})
SetKey( -4, 		  {|| Saldos()})
SetKey( 23, 		  {|| GravaDisco()})
SetKey( TECLA_ALTC, {|| Altc()})
SetColor("")
AbreArea()
oMenu:Limpa()
IF !VerSenha( @cCaixa, @cVendedor )
	Mensagem("Aguarde, Fechando Arquivos." )
	DbCloseAll()
	Set KEY F2 TO
	Set KEY F3 TO
	Return
EndIF
*:==================================================================================================================================
Op := 1
RefreshClasse()
WHILE lOk
	Begin Sequence
		Op 		  := oMenu:Show()
		Do Case
		Case Op = 0.0 .OR. Op = 1.01
			ErrorBeep()
			IF Conf("Pergunta: Encerrar este modulo ?")
				GravaDisco()
				lOk := FALSO
				Break
			EndIF
		Case Op = 2.01
			Cheq11()
		Case Op = 2.02
			IncConta()
		Case Op = 2.03
			IncSubConta()
		Case Op = 2.04
			CursosInclusao()
		Case Op = 2.05
			EntradaNova()
		Case Op = 3.01
			BrowseContas()
		Case Op = 3.02
			AltConta()
		Case Op = 3.03
			AltSubConta()
		Case Op = 3.04
			Estornos()
		Case Op = 3.05
         AltMovimento()
      Case Op = 3.06
			CursosAlteracao()
      Case Op = 3.07
			ConsultaNova()
		Case Op = 4.01
			BrowseContas()
		Case Op = 4.02
			AltConta()
		Case Op = 4.03
			AltSubConta()
		Case Op = 4.04
			Exclusao()
		Case Op = 4.05
			CursosAlteracao()
		Case Op = 4.06
			ConsultaNova()
		Case Op = 5.01
			TipoLcto()
		Case Op = 5.02
			IndexarData()
		Case Op = 5.03
			Recontrato()
		Case Op = 5.04
			BaixasRece( cCaixa, cVendedor )
		Case Op = 5.05
			Contrato()
		Case Op = 5.06
			DevolveContrato()
		Case Op = 6.01
			CheRelat()
		Case Op = 6.02
			CheRelac( FALSO )
		Case Op = 6.03
			CheRelac( OK )
		Case Op = 6.04
			mnuImpPre()
		Case Op = 6.05
			CheRelac()
		Case Op = 6.06
			ResumoPeriodo()
		Case Op = 6.07
			Contrato()
		Case Op = 6.08
			ReciboIndividual()
		Case Op = 6.09
			Frequencia()
		Case Op = 6.10
			DebitosAlunos()
		Case Op = 6.11
         ProBranco()
		Case Op = 6.12
			ContratoVencido()
		Case Op = 6.13
			Contrato()
		Case Op = 6.14
			Chamada()
		Case Op = 7.01 ; mnuContas( 1 )
		Case Op = 7.02 ; mnuContas( 2 )
		Case Op = 7.03 ; mnuContas( 3 )
		Case Op = 7.04 ; Saldos()
		Case Op = 7.05 ; ExtratoVideo()
		Case Op = 7.06 ; CheRelat()
		Case Op = 7.07 ; AltConta()
		Case Op = 7.08 ; AltSubConta()
		Case Op = 7.09 ; CursosAlteracao()
		Case Op = 8.01 ; Cheq_Pre1()
		Case Op = 8.02 ; BrowsePreDatado()
		Case Op = 8.03 ; BrowsePreDatado()
		Case Op = 8.04 ; Cheq_Pre5()
		Case Op = 8.05 ; mnuImpPre()
		Case Op = 8.06 ; MenuBaixaPre()
		EndCase
	End Sequence
EndDo
Mensagem("Aguarde... Fechando Arquivos.", WARNING, _LIN_MSG )
FechaTudo()
Return

*:==================================================================================================================================

STATIC Proc RefreshClasse()
***************************
oMenu:StatusSup      := oMenu:StSupArray[5]
oMenu:StatusInf      := oMenu:StInfArray[5]
oMenu:Menu           := oMenu:MenuArray[5]
oMenu:Disp           := oMenu:DispArray[5]
Return

Proc ResumoPeriodo()
********************
LOCAL cScreen := SaveScreen()
LOCAL aMenu   := {"Individual", "Parcial", "Geral" }
LOCAL nChoice
LOCAL oBloco
LOCAL cCodiIni
LOCAL cCodiFim
LOCAL dIni
LOCAL dFim

WHILE OK
	M_Title("RELACAO DE CONTAS")
	nChoice := FazMenu( 06, 31, aMenu )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1
		Area("Cheque")
		Cheque->(Order( CHEQUE_CODI ))
		cCodiIni := Space( 04 )
		dIni		:= Date()-30
		dFim		:= Date()
		MaBox( 13, 31, 17, 53 )
		@ 14, 32 Say  "Codigo..:" Get cCodiIni Pict "9999" Valid CheErrado( @cCodiIni )
		@ 15, 32 Say  "Inicio..:" Get dIni     Pict "##/##/##"
		@ 16, 32 Say  "Inicio..:" Get dFim     Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Cheque->(Order( CHEQUE_CODI ))
		Area("Chemov")
		Chemov->(Order( CHEMOV_CODI ))
		Set Rela To Codi Into Cheque
		Chemov->(DbGoTop())
		IF Chemov->(!DbSeek( cCodiIni ))
			Chemov->(DbClearRel())
			Chemov->(DbGoTop())
			ErrorBeep()
			Alerta("Erro: Nenhum Registro Disponivel.", Cor())
			ResTela( cScreen )
			Loop
		EndIF
		IF !InsTru80() .OR. !LptOk()
			ResTela( cScreen )
			Loop
		EndIF
		oBloco := {|| Codi = cCodiIni }
		ImprimeResumo( oBloco, dIni, dFim )
		Chemov->(DbClearRel())
		Chemov->(DbGoTop())
		ResTela( cScreen )
		Loop

	Case nChoice = 2
		Area("Cheque")
		Cheque->(Order( CHEQUE_CODI ))
		cCodiIni := Space(04)
		cCodiFim := Space(04)
		dIni		:= Date()-30
		dFim		:= Date()
		MaBox( 13, 31, 18, 53 )
		@ 14, 32 Say  "Inicial :" Get cCodiIni Pict "9999" Valid CheErrado( @cCodiIni )
		@ 15, 32 Say  "Final   :" Get cCodiFim Pict "9999" Valid CheErrado( @cCodiFim )
		@ 16, 32 Say  "Inicio..:" Get dIni     Pict "##/##/##"
		@ 17, 32 Say  "Inicio..:" Get dFim     Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Cheque->(Order( CHEQUE_CODI ))
		Area("Chemov")
		Chemov->(Order( CHEMOV_CODI ))
		Set Rela To Codi Into Cheque
		Chemov->(DbGoTop())
		nCodiIni   := Val( cCodiIni )
		nCodiFim   := Val( cCodiFim )
		lEncontrou := FALSO
		For nVer := nCodiIni To nCodiFim
			cCodi := StrZero( nVer, 4 )
			IF Chemov->(DbSeek( cCodi ))
				lEncontrou := OK
				Exit
			EndiF
		Next
		IF !lEncontrou
			Chemov->(DbClearRel())
			Chemov->(DbGoTop())
			ErrorBeep()
			Alerta("Erro: Nenhum Registro Disponivel.", Cor())
			ResTela( cScreen )
			Loop
		EndIF
		IF !InsTru80() .OR. !LptOk()
			ResTela( cScreen )
			Loop
		EndIF
		oBloco := {|| Chemov->Codi >= cCodiIni .AND. Chemov->Codi <= cCodiFim  }
		ImprimeResumo( oBloco, dIni, dFim )
		Chemov->(DbClearRel())
		Chemov->(DbGoTop())
		ResTela( cScreen )
		Loop

	Case nChoice = 3
		dIni		:= Date()-30
		dFim		:= Date()
		MaBox( 13, 31, 16, 51 )
		@ 14, 32 Say  "Inicio..:" Get dIni     Pict "##/##/##"
		@ 15, 32 Say  "Inicio..:" Get dFim     Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Cheque->(Order( CHEQUE_CODI ))
		Area("Chemov")
		Chemov->(Order( CHEMOV_CODI ))
		Set Rela To Codi Into Cheque
		Chemov->(DbGoTop())
		IF !InsTru80() .OR. !LptOk()
			ResTela( cScreen )
			Loop
		EndIF
		oBloco := {|| !Eof() }
		ImprimeResumo( oBloco, dIni, dFim )
		Chemov->(DbClearRel())
		Chemov->(DbGoTop())
		ResTela( cScreen )
		Loop
	EndCase
EndDo

Proc ImprimeResumo( oBloco, dIni, dFim )
****************************************
LOCAL cScreen	 := SaveScreen()
LOCAL Tam		 := CPI1280
LOCAL Col		 := 58
LOCAL Pagina	 := 0
LOCAL lSair 	 := FALSO
LOCAL cTitulo	 := "RELACAO DE CONTAS E RESUMO DE SALDOS"
LOCAL cRelato	 := "CODI TITULAR DA CONTA                               DEBITOS         CREDITOS            SALDO"
LOCAL nDebTotal := 0
LOCAL nDebitos  := 0
LOCAL nCreditos := 0
LOCAL nCreTotal := 0
LOCAL nSaldo	 := 0
LOCAL nSalTotal := 0
LOCAL lNovo 	 := OK
LOCAL cUltCodi  := Chemov->Codi

oMenu:Limpa()
Mensagem("Aguarde, Processando e imprimindo.", Cor())
PrintOn()
Fprint( _CPI12 )
SetPrc( 0, 0 )
WHILE Eval( oBloco ).AND. Rel_Ok()
  IF Col >= 56
	  Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
	  Write( 01, 00, Date() )
	  Write( 02, 00, Padc( XNOMEFIR, Tam ) )
	  Write( 03, 00, Padc( "SISTEMA DE CONTROLE BANCARIO", Tam ) )
	  Write( 04, 00, Padc( cTitulo,Tam ) )
	  Write( 05, 00, Repl( SEP, Tam ) )
	  Write( 06, 00, cRelato )
	  Write( 07, 00, Repl( SEP, Tam ) )
	  Col := 8
  EndIF
  IF Chemov->Data >= dIni .AND. Chemov->Data <= dFim
	  nDebitos	+= Chemov->Deb
	  nCreditos += Chemov->Cre
	  nDebTotal += Chemov->Deb
	  nCreTotal += Chemov->Cre
  EndiF
  cNome := Cheque->(Left( Titular, 37 ))
  Chemov->(DbSkip(1))
  IF Chemov->Codi != cUltCodi
	  Qout( cUltCodi, cNome,;
			  Tran( nDebitos, 			  "@E 9,999,999,999.99"),;
			  Tran( nCreditos,			  "@E 9,999,999,999.99"),;
			  Tran( nCreditos - nDebitos, "@E 9,999,999,999.99"))
		Col++
		lNovo 	 := OK
		cUltCodi  := Chemov->Codi
		nCreditos := 0
		nDebitos  := 0
  EndIF
  IF Col >= 57
	  __Eject()
  EndIF
EndDo
Qout("")
Qout("** TOTAL **")
Qqout( Space(31),Tran( nDebTotal,  "@E 9,999,999,999.99"),;
					  Tran( nCreTotal, "@E 9,999,999,999.99"),;
					  Tran( nCreTotal-nDebTotal, "@E 9,999,999,999.99"))
__Eject()
PrintOff()
ResTela( cScreen )
Return

Proc Abrearea()
***************
LOCAL cScreen	:= SaveScreen()
LOCAL aIndices := {}

ErrorBeep()
Mensagem("Aguarde, Abrindo base de dados.", WARNING, _LIN_MSG )
FechaTudo()

IF !UsaArquivo( "CHEQUE")
	MensFecha()
	Return
EndIF
IF !UsaArquivo( "CHEMOV")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("CHEPRE")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("VENDEDOR")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("TAXAS")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("CONTA")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("SUBCONTA")
	MensFecha()
	Return
EndIF
#IFDEF MICROBRAS
	IF !UsaArquivo("RECEBER")
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
	IF !UsaArquivo("VENDEMOV")
		MensFecha()
		Return
	EndIF
	IF !UsaArquivo("VENDEDOR")
		MensFecha()
		Return
	EndIF
	IF !UsaArquivo("CURSOS")
		MensFecha()
		Return
	EndIF
	IF !UsaArquivo("CURSADO")
		MensFecha()
		Return
	EndIF
#ENDIF
Return

Proc mnuContas( nOpcao )
************************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen(	)
LOCAL cTitular
LOCAL cCgc
LOCAL cCodi
LOCAL Op1
FIELD Titular
FIELD Field
FIELD Cgc
FIELD Codi

Cheque->(DbGoTop())
IF Cheque->(Eof())
	Nada()
	ResTela( cScreen )
	Return
EndIF
Area("Cheque")
Do Case
Case nOpcao = 1
	Sx_ClrScope( S_TOP )
	Sx_ClrScope( S_BOTTOM )
	MaBox( 14, 11, 16, 63 )
	cTitular = Space(40)
	@ 15,12 Say "Titular.:" Get cTitular Pict "@!" Valid CheErrado( @cTitular )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	Cheque->(Order( CHEQUE_TITULAR ))
	Sx_SetScope( S_TOP, cTitular )
	Sx_SetScope( S_BOTTOM, cTitular )
	Mensagem('Aguarde, Filtrando.')
	Cheque->(DbGoTop())
	IF Sx_KeyCount() == 0
      Sx_ClrScope( S_TOP )
      Sx_ClrScope( S_BOTTOM )
		Nada()
		ResTela( cScreen )
		Return
	EndIF
	BrowContas()
	Sx_ClrScope( S_TOP )
	Sx_ClrScope( S_BOTTOM )

Case nOpcao = 2
	MaBox( 14, 11, 16, 27 )
	cCodi := Space(4)
	@ 15,12 Say  "Codigo..:" Get cCodi Pict "9999" VALID CheErrado( @cCodi )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	Cheque->(Order( CHEQUE_CODI ))
	Sx_SetScope( S_TOP, cCodi )
	Sx_SetScope( S_BOTTOM, cCodi )
	Mensagem('Aguarde, Filtrando.')
	Cheque->(DbGoTop())
	IF Sx_KeyCount() == 0
      Sx_ClrScope( S_TOP )
      Sx_ClrScope( S_BOTTOM )
		Nada()
		ResTela( cScreen )
		Return
	EndIF
	BrowContas()
	Sx_ClrScope( S_TOP )
	Sx_ClrScope( S_BOTTOM )

Case nOpcao = 3
	Cheque->(Order( CHEQUE_TITULAR ))
	Cheque->(DbGoTop())
	BrowContas()

EndCase
ResTela( cScreen )
Return

Proc Saldos()
************
LOCAL cScreen := SaveScreen()
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL Vetor3
LOCAL Vetor4

oMenu:Limpa()
Cheque->(DbGoTop())
IF Cheque->(Eof())
	Nada()
	ResTela( cScreen )
	Return
EndIF
Set Key -4 To
Area("Cheque")
Vetor3 := {"Titular","Tran( Saldo,'@E 99,999,999,999.99')","Codi","Banco", "Conta","Ag"}
Vetor4 := {"TITULAR","SALDO R$","CODIGO","BANCO","CONTA","AGENCIA"}
Cheque->(Order( CHEQUE_TITULAR ))
DbGoTop()
MaBox( 00, 00, 23, MaxCol(), "SALDO CONTAS" )
Seta1(23)
DbEdit( 01, 01, 22, MaxCol()-1, Vetor3, "Cheq5Func", OK, Vetor4 )
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )
Set Key -4 To Saldos()
Return

Function Cheq5Func( Mode, Ponteiro )
************************************
Do Case
Case Mode = 0
	Return( 1 )

Case Mode = 1 .OR. Mode = 2
	ErrorBeep()
	Return( 1 )

Case LastKey() = 27	 // Esc
	Return( 0 )

OtherWise
	Return( 1 )

EndCase

Proc BrowContas()
*****************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
oBrowse:Add( "CODIGO",    "Codi")
oBrowse:Add( "TITULAR",   "Titular")
oBrowse:Add( "DATA",      "Data")
oBrowse:Add( "BANCO",     "Banco")
oBrowse:Add( "CONTA",     "Conta")
oBrowse:Add( "AG",        "Ag")
oBrowse:Add( "FONE",      "Fone")
oBrowse:Add( "CGC",       "Cgc")
oBrowse:Add( "OBS",       "Obs")
oBrowse:Titulo   := "CONSULTA DE CONTAS"
oBrowse:PreDoGet := {|| PreGetBrowContas( oBrowse ) } // Rotina do Usuario Antes de Atualizar
oBrowse:PosDoGet := NIL
oBrowse:PreDoDel := {|| PreDelBrowContas( oBrowse ) } // Rotina do Usuario Antes de Atualizar
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Function PreGetBrowContas( oBrowse )
************************************
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Alerta("Alteracao nao Permitida")
Return( FALSO )

Function PreDelBrowContas( oBrowse )
************************************
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Alerta("Exclusao nao Permitida")
Return( FALSO )

Proc Estornos()
***************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen()
LOCAL nReg_Ant   := 0
LOCAL nReg_Atual := 0
LOCAL nVlr_Atual := 0
LOCAL nVlr_Mov   := 0
LOCAL nConta	  := 0
LOCAL nSaldo	  := 0
LOCAL cDocAnt	  := ""
LOCAL cHistAnt   := ""
LOCAL cDocNr
LOCAL cCodi
LOCAL xVar
LOCAL dData
LOCAL cCodiAnt
LOCAL cHist
LOCAL Debito
FIELD Data
FIELD Docnr
FIELD Hist
FIELD Codi
FIELD Cre
FIELD Deb
FIELD Banco

WHILE OK
	Area("Chemov")
	Chemov->(Order( CHEMOV_DOCNR ))
	cDocnr := Space(9)
	MaBox( 13, 11, 15, 31 )
	@ 14, 12 Say  "Docto n§:" Get cDocnr Pict "@!" Valid Doccherr( @cDocnr )
	Read
	IF LastKey() = ESC
		IF nConta != 0
			IF Conf("Pergunta: Atualizar Saldos Agora ?")
				IndexarData( cCodiAnt )
			EndIF
		EndIF
		ResTela( cScreen )
		Exit

	EndIF
	IF !TravaReg()
		Loop
	EndIF
	nReg_Ant   := Chemov->(Recno())
	cDocnr	  := Chemov->Docnr
	cDocAnt	  := Chemov->Docnr
	cHistAnt   := Chemov->Hist
	dData 	  := Chemov->Data
	dEmis 	  := Chemov->Emis
	cHist 	  := Chemov->Hist
	cCodiAnt   := Chemov->Codi
	Cheque->(Order( CHEQUE_CODI ))
	Cheque->(DbSeek( cCodiAnt))
	oMenu:Limpa()
	MaBox( 06, 10, 12, 76, "ALTERACAO DE MOVIMENTO")
	Write( 07, 11 , "Codigo...: " + Codi + "  " + Cheque->Titular )
	Write( 08, 11 , "Doc.N§...: " + Docnr )
	Write( 09, 11 , "Data.....: " + Dtoc( Data ))
	Write( 10, 11 , "Historico: " + Hist )
	Write( 11, 11 , "Valor....: ")

	// Verifica se foi credito ou debito
	nVlr_Mov   := IF( Cre = 0, Deb, Cre )
	Debito	  := IF( Cre = 0, OK, FALSO )
	xVar		  := IF( Cre = 0, "DEBITO", "CREDITO" )
	nVlr_Atual := nVlr_Mov

	Write( 11, 22 , Tran( nVlr_Mov, "@E 999,999,999,999.99" ) )
	Write( 11, 45 , xVar )
	IF !PodeAlterar()
		ResTela( cScreen )
		Loop
	EndIF
	cCodi 	  := cCodiAnt
	nReg_Atual := 0
	@ 07, 22 Get cCodi		Pict "9999" Valid Acha_Cheq( @cCodi, @nReg_Atual )
	@ 08, 22 Get cDocnr		Pict "@!"   Valid VerSeJaTem( cDocAnt, cDocnr, cHist )
	@ 09, 22 Get dData		Pict "##/##/##"
	@ 10, 22 Get cHist		Pict "@!"
	@ 11, 22 Get nVlr_Atual Pict "@E 999,999,999,999.99"
	Read
	IF LastKey() = ESC
		Libera()
		ResTela( cScreen )
		Loop

	EndIF
	IF( Debito , Escolha := 3, Escolha := 2 )
	MaBox( 15, 10, 17, 45, "Lancar Valor" )
	AtPrompt( 16, 11, " Cancelar  ")
	AtPrompt( 16, 22, " A Credito ")
	AtPrompt( 16, 33, " A Debito  ")
	Menu To Escolha
	IF Escolha = 0 .OR. Escolha = 1
		ResTela( cScreen )
		Loop
	EndIF
	IF Conf( "Pergunta: Confirma Alteracao do Lancamento ?" )
		nConta++
		Area("Cheque")
		Cheque->(Order( CHEQUE_CODI ))
		Cheque->(DbSeek( cCodiAnt ))		  // Localiza o Codigo do Bco anterior
		IF Cheque->(TravaReg())
			IF Debito				 // Se o valor anterior era debito
				Cheque->Saldo += nVlr_Mov
			Else
				Cheque->Saldo -= nVlr_Mov
			EndIF
			Cheque->(Libera())
			Cheque->(DbGoTo( nReg_Atual ))
			IF Cheque->(TravaReg())
				Cheque->Atualizado := Date()
				IF Escolha = 2 		 // Lancar a Credito ?
					Cheque->Saldo += nVlr_Atual
					nSaldo := Saldo
				ElseIf Escolha = 3	 // ou a Debito ?
					Cheque->Saldo -= nVlr_Atual
					nSaldo := Saldo
				EndIF
				Cheque->(Libera())
				Area("Chemov")
				Chemov->(DbGoTo( nReg_Ant ))
				IF Cheque->(TravaReg())
					Chemov->Codi		 := cCodi
					Chemov->Docnr		 := cDocnr
					Chemov->Data		 := dData
					Chemov->Baixa		 := Date()
					Chemov->Emis		 := dEmis
					Chemov->Hist		 := cHist
					Chemov->Atualizado := Date()
					IF Escolha = 2
						Chemov->Cre   := nVlr_Atual
						Chemov->Deb   := 0
					Else
						Chemov->Deb   := nVlr_Atual
						Chemov->Cre   := 0
					EndIF
					Cheque->(Libera())
				EndIF
			EndIF
		EndIF
		Area("Chemov")
		Chemov->(Order( CHEMOV_DOCNR ))
		IF Chemov->(DbSeek( cDocAnt ))
			WHILE Chemov->Docnr = cDocAnt
				IF Chemov->Hist  == cHistAnt
					IF Chemov->(TravaReg())
						Chemov->Docnr		 := cDocnr
						Chemov->Data		 := dData
						Chemov->Baixa		 := Date()
						Chemov->Emis		 := dEmis
						Chemov->Hist		 := cHist
						Chemov->Atualizado := Date()
						Chemov->(Libera())
					EndIF
				EndIF
				Chemov->(DbSkip(1))
			EndDo
		EndIF
	EndIF
	ResTela( cScreen )
EndDo

Function VerSeJaTem( cDocAnt, cDocnr, cHist )
*********************************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL lRetVal := OK

IF cDocnr == cDocAnt
	Return( OK )
EndIF
Area("Chemov")
Chemov->(Order( CHEMOV_DOCNR ))
IF Chemov->(DbSeek( cDocnr ))
	IF Chemov->Hist != cHist
		ErrorBeep()
		Alerta("Erro: Documento ja Registrado.")
		lRetVal := FALSO
	EndIF
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( lRetVal )


Proc Exclusao()
***************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen()
LOCAL cCodiAnt   := Space(4)
LOCAL cDocNr, cCodi, xVar, nSaldo := 0
LOCAL dData, cHist, Debito, nConta := 0
FIELD Data, Docnr, Hist, Codi, Cre, Deb, Banco

WHILE OK
	Area("Chemov")
	Order( CHEMOV_DOCNR )
	cDocnr := Space(9)
	MaBox( 13, 11, 15, 31 )
	@ 14, 12 Say  "Doc N§..:" Get cDocnr Pict "@!" Valid Doccherr( @cDocnr )
	Read
	IF LastKey() = ESC
		IF nConta != 0
			IF Conf("Atualizar Saldos Agora ? ")
				IndexarData( cCodiAnt )
			EndIF
		EndIF
		ResTela( cScreen )
		Exit
	EndIF
	cDocnr	  := Docnr
	dData 	  := Data
	cHist 	  := Hist
	cCodiAnt   := Codi
	Cheque->(Order( CHEQUE_CODI ))
	Cheque->(DbSeek( cCodiAnt))
	oMenu:Limpa()
	MaBox( 06, 10, 12, 76, "EXCLUSAO DE LANCAMENTO")
	Write( 07, 11 , "Codigo...: " + Codi + "  " + Cheque->Titular )
	Write( 08, 11 , "Doc N§...: " + Docnr )
	Write( 09, 11 , "Data.....: " + Dtoc( Data ))
	Write( 10, 11 , "Historico: " + Hist )
	Write( 11, 11 , "Valor....: " + Tran( IF( Cre = 0, Deb, Cre ), "@E 999,999,999,999.99"))
	IF PodeExcluir()
		IF Conf( "Confirma Exclusao do Lancamento ?" )
		  IF Chemov->(TravaReg())
				nConta++
				Chemov->(DbDelete())
				Chemov->(Libera())
			EndIF
		EndIF
	EndIF
EndDo

Function Acha_Cheq( Var, Reg )
******************************
LOCAL aRotina := {{|| Cheq11() }}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
IF Empty( Var )
	ErrorBeep()
	Alerta("Erro: Codigo Conta Invalida...")
	Return( FALSO )

EndIF
Area("Cheque")
Order( CHEQUE_CODI )
IF !( DbSeek( Var ) )
	Order( CHEQUE_TITULAR )
	DbGoTop()
	Escolhe( 03, 01, 22, "Codi + 'º' + Titular", "CODI TITULAR DA CONTA", aRotina )
	Var := Codi
EndIF
Write( 07, 28, Space( 40 ))
Write( 07, 28, Titular )
Reg := Recno()
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Proc LancaMovimento( cCaixa )
*****************************
LOCAL cScreen	:= SaveScreen()
LOCAL GetList	:= {}
LOCAL cTexto	:= "LANCAMENTOS DEBITOS/CREDITOS"
LOCAL cCodi 	:= IF( cCaixa = NIL, Space(4), "0000")
LOCAL cCodi1	:= Space(04)
LOCAL cCodi2	:= Space(04)
LOCAL cCodi3	:= Space(04)
LOCAL cDebCre	:= "C"
LOCAL cDebCre1 := "C"
LOCAL cDebCre2 := "C"
LOCAL cDebCre3 := "C"
LOCAL nCotacao := 0
LOCAL nValor	:= 0
LOCAL nReg     := 0
LOCAL lSair
LOCAL nSaldo
LOCAL cDocnr
LOCAL dEmis
LOCAL cHist
LOCAL nVlr
LOCAL lOpcional
IF cCaixa = NIL
	Set Key F5 To ExtratoVideo()
EndIF
WHILE OK
	oMenu:Limpa()
	Area("Cheque")
	Order( CHEQUE_CODI )
	MaBox( 02, 10, 04, 75, cTexto )
	@ 03, 11 Say "Codigo Conta..:" Get cCodi  Pict "@K 9999" Valid CheErrado( @cCodi,, Row(),33  )
	Read
	IF LastKey() = ESC
		IF cCaixa = NIL
			Set Key F5 To Saldos()
		EndIF
		ResTela( cScreen )
		Exit
	EndIF
	dEmis   := Date()
	cHist   := Space(40)
	nVlr	  := 0
	lSair   := FALSO
	cData   := StrTran( Dtoc( Date()), "/" )  // 240697
   nConta  := Chemov->(Lastrec())
   Chemov->(Order(0))
   Chemov->(DBGoBottom())
   cDocnr  := Chemov->Docnr
   nReg    := Val(Right(cDocnr,2))
   WHILE OK
		Cheque->(Order( CHEQUE_CODI ))
		Cheque->(DbSeek( cCodi))
		MaBox( 05, 10, 21, 75 )
		Write( 06, 11 , "Codigo.....: " + cCodi + " " + Cheque->Titular )
		Write( 07, 11 , "Banco......: " + Cheque->Banco )
		Write( 08, 11 , "Conta......: " + Cheque->Conta )
		IF cCaixa = NIL
			Write( 09, 11 , "Saldo......: " + Cheque->(AllTrim(Tran( Saldo, "@ECX 9,999,999,999.99"))))
		EndIF
		WHILE OK
         cDocnr  := cData + "-" + StrZero( ++nReg, 2)
			Cheque->(Order( CHEQUE_CODI ))
			Cheque->(DbSeek( cCodi))
			IF cCaixa = NIL
				Write( 09, 11 , "Saldo......: " + Cheque->(AllTrim(Tran( Saldo, "@ECX 9,999,999,999.99"))))
			EndIF
			lOpcional := OK
			cCodi1	 := Space(4)
			cCodi2	 := Space(4)
			cCodi3	 := Space(4)
			@ 10, 11 Say "Data.......:" Get dEmis    Pict "##/##/##"
			@ 10, 11 Say "Data.......: " + Dtoc( dEmis )
			@ 11, 11 Say "Docto. N§..:" Get cDocnr   Pict "@K!" Valid CheqDoc( cDocnr )
			@ 12, 11 Say "Historico..:" Get cHist    Pict "@K!"
			@ 13, 11 Say "Valor......:" Get nVlr     Pict "@E 9,999,999,999.99" Valid CheqVlr( nVlr )
			@ 14, 11 Say "D/C........:" Get cDebCre  Pict "!" Valid cDebCre $("CD")
			@ 15, 11 Say "C. Partida.:" Get cCodi1   Pict "9999" Valid CheErrado( @cCodi1,, Row(), 33, lOpcional )
			@ 16, 11 Say "D/C........:" Get cDebCre1 Pict "!" Valid cDebCre1 $("CD")
			@ 17, 11 Say "C. Partida.:" Get cCodi2   Pict "9999" Valid CheErrado( @cCodi2,, Row(), 33, lOpcional )
			@ 18, 11 Say "D/C........:" Get cDebCre2 Pict "!" Valid cDebCre2 $("CD")
			@ 19, 11 Say "C. Partida.:" Get cCodi3   Pict "9999" Valid CheErrado( @cCodi3,, Row(), 33, lOpcional )
			@ 20, 11 Say "D/C........:" Get cDebCre3 Pict "!" Valid cDebCre3 $("CD")
			Read
			IF LastKey() = ESC
				lSair := OK
				Exit
			EndIF
			nValor1 := nVlr
			nValor2 := nVlr
			nOpcao := Alerta("Voce Deseja ? ", {" Incluir ", " Alterar "," Sair "} )
			IF nOpcao = 1	// Incluir
				IF Chemov->(!TravaArq()) ; Chemov->(Libera()) ; Loop ; EndIF
				IF Cheque->(!TravaArq()) ; Chemov->(Libera()) ; Loop ; EndIF
				Cheque->( DbSeek( cCodi ))
				Area("Chemov")
				Chemov->(DbAppend())
				IF cDebCre = "C"
					Cheque->Saldo += nVlr
					Chemov->Cre   := nVlr
				Else
				  Cheque->Saldo -= nVlr
				  Chemov->Deb	 := nVlr
				EndIF
				nTotal		  := Cheque->Saldo
            nReg          := Val(Right(cDocnr,2))
				Chemov->Atualizado := Date()
				Chemov->Codi  := cCodi
				Chemov->Docnr := cDocnr
				Chemov->Data  := dEmis
				Chemov->Baixa := Date()
				Chemov->Emis  := dEmis
				Chemov->Hist  := cHist
				Chemov->Saldo := nTotal
				Chemov->Caixa := IF( cCaixa = NIL, "", cCaixa )
				Chemov->Tipo  := IF( cCaixa = NIL, "", "OU" )
				*:-------------------------------------------------------
				IF !Empty( cCodi1 )
					Cheque->( DbSeek( cCodi1 ))
					Chemov->(DbAppend())
					IF cDebCre1 = "C"
						Cheque->Saldo		 += nValor1
						Cheque->Atualizado := Date()
						Chemov->Cre 		 := nValor1
					Else
					  Cheque->Saldo		-= nValor1
					  Cheque->Atualizado := Date()
					  Chemov->Deb			:= nValor1
					EndIF
					nTotal		  := Cheque->Saldo
					Chemov->Codi  := cCodi1
					Chemov->Docnr := cDocnr
					Chemov->Data  := dEmis
					Chemov->Baixa := Date()
					Chemov->Emis  := dEmis
					Chemov->Hist  := cHist
					Chemov->Saldo := nTotal
               Chemov->Caixa := IF( cCodi1 = cCodi, IF( cCaixa = NIL, "", cCaixa ), "")
					Chemov->Tipo  := IF( cCodi1 = cCodi, IF( cCaixa = NIL, "", "OU" ), "")
				EndIF
				*:-------------------------------------------------------
				IF !Empty( cCodi2 )
					Cheque->( DbSeek( cCodi2 ))
					Chemov->(DbAppend())
					IF cDebCre2 = "C"
						Cheque->Saldo += nValor2
						Chemov->Cre   := nValor2
					Else
					  Cheque->Saldo -= nValor2
					  Chemov->Deb	 := nValor2
					EndIF
					nTotal				 := Cheque->Saldo
					Chemov->Codi		 := cCodi2
					Chemov->Docnr		 := cDocnr
					Chemov->Data		 := dEmis
					Chemov->Baixa		 := Date()
					Chemov->Emis		 := dEmis
					Chemov->Hist		 := cHist
					Chemov->Saldo		 := nTotal
               Chemov->Caixa      := ''
					Chemov->Tipo		 := IF( cCodi2 = cCodi, IF( cCaixa = NIL, "", "OU" ), "")
					Chemov->Atualizado := Date()
				EndIF
				*:-------------------------------------------------------
				IF !Empty( cCodi3 )
					Cheque->( DbSeek( cCodi3 ))
					Chemov->(DbAppend())
					IF cDebCre3 = "C"
						Cheque->Saldo += nValor2
						Chemov->Cre   := nValor2
					Else
					  Cheque->Saldo -= nValor2
					  Chemov->Deb	 := nValor2
					EndIF
					nTotal				 := Cheque->Saldo
					Chemov->Codi		 := cCodi3
					Chemov->Docnr		 := cDocnr
					Chemov->Data		 := dEmis
					Chemov->Baixa		 := Date()
					Chemov->Emis		 := dEmis
					Chemov->Hist		 := cHist
					Chemov->Saldo		 := nTotal
					Chemov->Caixa		 := ""
					Chemov->Tipo		 := IF( cCodi3 = cCodi, IF( cCaixa = NIL, "", "OU" ), "")
					Chemov->Atualizado := Date()
				EndIF
				Chemov->(Libera())
				Cheque->(Libera())

			ElseIf nOpcao = 2   // Alterar
				Loop
			ElseIF nOpcao = 3  // Sair
				lSair := OK
				Exit
			EndIF
		EndDo
		IF lSair
			IF cCaixa = NIL
				Set Key -4 To Saldos()
			EndIF
			Exit
		EndIF
	Enddo
EndDo

Function DocChCer( Var )
************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
IF Empty( var )
	ErrorBeep()
	Alerta("Erro: Codigo Documento Invalido ...")
	Return( FALSO )
EndIF
Area("Chemov")
Order( CHEMOV_DOCNR )
DbGoTop()
IF ( DbSeek( Var ) )
	ErrorBeep()
	Alerta("Erro: Documento Ja Registrado ...")
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function DocChErr( Var )
************************
LOCAL cValor
IF LasTrec() = 0
	Nada()
	Return( FALSO )
EndIF
IF !( DbSeek( Var ) )
	DbGoTop()
	Chemov->(Escolhe( 03, 00, 22, "Docnr + '³' + Dtoc( Data ) + '³' + Codi + '³' + Hist", "DOC N§    DATA     CODI HISTORICO DO MOVIMENTO"))
	Var := Chemov->Docnr
EndIF
Return( OK )

Proc CheRelat()
***************
LOCAL cScreen	  := SaveScreen( )
LOCAL nChoice	  := 0
LOCAL cCodiIni   := Space(04)
LOCAL cCodiFim   := Space(04)
LOCAL aMenuArray := { "Por Periodo", "Geral" }
LOCAL dIni
LOCAL dFim
LOCAL nItens
LOCAL oBloco

WHILE OK
	Cheque->(Order( CHEQUE_CODI ))
	M_Title("IMPRESSAO EXTRATOS")
	nChoice := FazMenu( 05, 31, aMenuArray )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1
		 cCodiIni := Space( 04 )
		 cCodiFim := Space( 04 )
		 dIni 	 := Date()-30
		 dFim 	 := Date()
		 MaBox( 15, 31, 20, 57 )
		 @ 16, 32 Say "Codigo Inicial.:" Get cCodiIni Pict "9999" Valid CheErrado( @cCodiIni )
		 @ 17, 32 Say "Codigo Final...:" Get cCodiFim Pict "9999" Valid CheErrado( @cCodiFim )
		 @ 18, 32 Say "Data Inicial...:" Get dIni     Pict "##/##/##"
		 @ 19, 32 Say "Data Final.....:" Get dFim     Pict "##/##/##"
		 Read
		 IF LastKey() = ESC
			 ResTela( cScreen )
			 Loop
		 EndIF
		 Area("Chemov")
		 Chemov->(Order( CHEMOV_CODI_DATA ))
		 Sx_ClrScope( S_TOP )
		 Sx_ClrScope( S_BOTTOM )
		 Sx_SetScope( S_TOP, 	cCodiIni + DateToStr( dIni ))
		 Sx_SetScope( S_BOTTOM, cCodiFim + DateToStr( dFim ))
		 Mensagem('Aguarde, Filtrando.')
		 Chemov->(DbGoTop())
		 IF Sx_KeyCount() == 0
          Sx_ClrScope( S_TOP )
          Sx_ClrScope( S_BOTTOM )
			 Nada()
			 ResTela( cScreen )
			 Return
		 EndIF
		 oBloco := {|| Codi >= cCodiIni .AND. Codi <= cCodiFim }
		 Che_Main( dIni, dFim, cCodiIni, oBloco )
		 Sx_ClrScope( S_TOP )
		 Sx_ClrScope( S_BOTTOM )

	Case nChoice = 2
		cCodi := Space( 04 )
		MaBox( 15, 31, 17, 47 )
		@ 16, 32 Say  "Codigo...:" Get cCodi Pict "9999" Valid CheErrado( @cCodi )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Area("Chemov")
		Chemov->(Order( CHEMOV_CODI_DATA ))
		Sx_ClrScope( S_TOP )
		Sx_ClrScope( S_BOTTOM )
		Sx_SetScope( S_TOP,	  cCodi )
		Sx_SetScope( S_BOTTOM, cCodi )
		Mensagem('Aguarde, Filtrando.')
		Chemov->(DbGoTop())
		IF Sx_KeyCount() == 0
         Sx_ClrScope( S_TOP )
         Sx_ClrScope( S_BOTTOM )
			Nada()
			ResTela( cScreen )
			Return
		EndIF
		oBloco := {|| Codi = cCodi }
		dIni	 := Chemov->Data
		dFim	 := Date()
		Che_Main( dIni, dFim, cCodi, oBloco )
		Sx_ClrScope( S_TOP )
		Sx_ClrScope( S_BOTTOM )

	EndCase
	ResTela( cScreen )
EndDo

Proc Che_Main( dIni, dFim, cCodi, oBloco )
******************************************
LOCAL cScreen		 := SaveScreen()
LOCAL nCredito 	 := 0
LOCAL nDebito		 := 0
LOCAL nSaldo		 := 0
LOCAL nTotCredito  := 0
LOCAL nTotDebito	 := 0
LOCAL Pagina		 := 0
LOCAL Col			 := 58
LOCAL Tam			 := 132
LOCAL lJahImprimiu := FALSO
LOCAL cIni			 := Dtoc( dIni )
LOCAL cFim			 := Dtoc( dFim )
LOCAL cTitulo		 := 'EXTRATO DE CONTA CORRENTE NO PERIODO DE ' + cIni + ' A ' + cFim
LOCAL nSaldoAnt
LOCAL oBloco1

IF !InsTruim() .OR. !LptOk()
	ResTela( cScreen )
	Return
EndIF
Cheque->( Order( CHEQUE_CODI ))
Cheque->(DbSeek( cCodi ))
WHILE Cheque->(Eval( oBloco )) .AND. !Eof() .AND. Rel_Ok()
	cCodiCheque := Cheque->Codi
	oBloco1		:= {|| Chemov->Codi = cCodiCheque .AND. Chemov->Data >= dIni .AND. Chemov->Data <= dFim }
	IF !AchaData1( cCodiCheque, dIni )
		Chemov->(DbGoTop())
		Cheque->(DbSkip(1))
		Loop
	EndIF
	cTitular := Cheque->Titular
	IF !lJahImprimiu
		lJahImprimiu := OK
		Mensagem("Aguarde. Imprimindo Extrato.", Cor())
		PrintOn()
		SetPrc( 0, 0 )
		FPrint( PQ )
	EndIF
	nSaldoAnt	:= (( Chemov->Saldo - Chemov->Cre) + Chemov->Deb)
	lNovoCodigo := OK
	WHILE Eval( oBloco1 ) .AND. Rel_Ok()
		IF Col >= 57
			lNovoCodigo := FALSO
			Qout( Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ))
			Qout( Date())
			Qout( Padc( XNOMEFIR, Tam ))
			Qout( Padc( SISTEM_NA5, Tam ))
			Qout( Padc( cTitulo, Tam ))
			Qout( Repl( SEP, Tam ))
			Qout( "EMISSAO  DT LCTO        DOC.N§    HISTORICO DO LANCAMENTO                              DEBITO            CREDITO              SALDO")
			Qout( Repl( SEP, Tam ))
			Qout( NG + Chemov->Codi + " : " + cTitular + Space(74) + Cheque->Conta + NR )
			FPrint( PQ )
			nSaldoAnt := (( Chemov->Saldo - Chemov->Cre) + Chemov->Deb)
			Qout()
			Qout( Space(33), "SALDO DE TRANSPORTE", Space(58), Tran( nSaldoAnt, "@E 999,999,999,999.99"))
			Col := 11
		EndIF
		IF lNovoCodigo
			lNovoCodigo := FALSO
			Qout( NG + Chemov->Codi + " : " + cTitular + Space(74) + Cheque->Conta + NR )
			FPrint( PQ )
			nSaldoAnt := (( Chemov->Saldo - Chemov->Cre) + Chemov->Deb)
			Qout()
			Qout( Space(33), "SALDO DE TRANSPORTE", Space(58), Tran( nSaldoAnt, "@E 999,999,999,999.99"))
			Col += 3
		EndIF
		Chemov->(Qout( Emis, Data, Space(05), Docnr, Hist,;
				Tran( Deb,	 [@E 999,999,999,999.99]),;
				Tran( Cre,	 [@E 999,999,999,999.99]),;
				Tran( Saldo, [@E 999,999,999,999.99])))
		nCredito += Chemov->Cre
		nDebito	+= Chemov->Deb
		nSaldo	:= Chemov->Saldo
		Chemov->(DbSkip(1))
		Col++
		IF Col >= 57
			__Eject()
		EndIF
	EndDo
	IF !lNovoCodigo
		Write( Prow()+2, 000, "*** Total ***" )
		Write( Prow(),   075, Tran( nDebito,  "@E 999,999,999,999.99"))
		Write( Prow() ,  094, Tran( nCredito, "@E 999,999,999,999.99"))
		Write( Prow(),   113, Tran( nSaldo,   "@E 999,999,999,999.99"))
		Qout( Repl( SEP, Tam ))
		Col += 3
	EndIF
	nTotDebito	+= nDebito
	nTotCredito += nCredito
	Cheque->(DbSkip(1))
	nCredito := 0
	nDebito	:= 0
	nSaldo	:= 0
EndDo
IF nTotDebito != 0 .OR. nTotCredito != 0
	IF Col >= 54
		Qout( Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ))
		Qout( Date())
		Qout( Padc( XNOMEFIR, Tam ))
		Qout( Padc( SISTEM_NA5, Tam ))
		Qout( Padc( cTitulo, Tam ))
		Qout( Repl( SEP, Tam ))
		Qout( "EMISSAO  DT LCTO        DOC.N§    HISTORICO DO LANCAMENTO                              DEBITO            CREDITO              SALDO")
		Qout( Repl( SEP, Tam ))
	EndIF
	Qout( NG + "XXXX : TOTAL GERAL DAS CONTAS" + NR )
	Qout()
	FPrint( PQ )
	Write( Prow()+1, 000, "*** Total Geral ***" )
	Write( Prow(),   075, Tran( nTotDebito,  "@E 999,999,999,999.99"))
	Write( Prow() ,  094, Tran( nTotCredito, "@E 999,999,999,999.99"))
	Write( Prow(),   113, Tran( nTotCredito - nTotDebito,   "@E 999,999,999,999.99"))
	__Eject()
EndIF
PrintOff()
Return

Proc CheRelac( lSaldo )
***********************
LOCAL CheRelac := SaveScreen()
LOCAL GetList	:= {}
LOCAL nChoice
LOCAL oBloco
LOCAL cCodiIni
LOCAL cCodiFim

IF lSaldo = Nil
	Alerta("Aviso: Procure fazer atualizacao antes de imprimir")
EndIF
WHILE OK
	M_Title("RELACAO")
	nChoice := FazMenu( 05, 31,;
										 { " Por Codigo         ",;
											" Parcial            ",;
											" Geral Ordem Codigo ", ;
											" Geral Ordem Titular" }, Cor())
	Do Case
	Case nChoice = 0
		DbGoTop()
		ResTela( CheRelac )
		Exit

	Case nChoice = 1
		Area("Cheque")
		Order( CHEQUE_CODI )
		cCodiIni := Space( 04 )
		MaBox( 13, 31, 15, 46 )
		@ 14, 32 Say  "Codigo..:" Get cCodiIni Pict "9999" VALID CheErrado( @cCodiIni )
		Read
		IF LastKey() = ESC
			ResTela( CheRelac )
			Loop
		EndIF
		IF !InsTru80() .OR. !LptOk()
			ResTela( CheRelac )
			Loop
		EndIF
		SetCursor(0)
		oBloco := {|| codi = cCodiIni }
		IF lSaldo != Nil
			Saldo( oBloco, lSaldo )
		Else
			ResumoContas( oBloco )
		EndIF
		SetCursor(1)
		ResTela( CheRelac )
		Loop

	Case nChoice = 2
		Area("Cheque")
		Order( CHEQUE_CODI )
		cCodiIni := Space(04)
		cCodiFim := Space(04)
		MaBox( 13, 31, 16, 46 )
		@ 14, 32 Say  "Inicial.:" Get cCodiIni Pict "9999" Valid CheErrado( @cCodiIni )
		@ 15, 32 Say  "Final...:" Get cCodiFim Pict "9999" Valid CheErrado( @cCodiFim )
		Read
		IF LastKey() = ESC
			ResTela( CheRelac )
			Loop

		EndIF
		IF !InsTru80() .OR. !LptOk()
			ResTela( CheRelac )
			Loop
		EndIF
		SetCursor(0)
		DbSeek( cCodiIni )
		oBloco := {|| Codi >= cCodiIni .AND. Codi <= cCodiFim }
		IF lSaldo != Nil
			Saldo( oBloco, lSaldo )
		Else
			ResumoContas( oBloco )
		EndIF
		SetCursor(1)
		ResTela( CheRelac )
		Loop

	Case nChoice = 3 .OR. nChoice = 4
		IF !InsTru80() .OR. !LptOk()
			ResTela( CheRelac )
			Loop
		EndIF
		Area("Cheque")
		Order( IF( nChoice = 3, CHEQUE_CODI, CHEQUE_TITULAR ))
		DbGoTop()
		SetCursor( 0 )
		oBloco := {|| !Eof() }
		IF lSaldo != Nil
			Saldo( oBloco, lSaldo )
		Else
			ResumoContas( oBloco )
		EndIF
		SetCursor(1)
		ResTela( CheRelac )
		Loop
	EndCase
EndDo

Function CheqVlr( Var )
***********************
IF Empty( Var )
	ErrorBeep()
	Alerta("Erro: Valor ou Quantidade Invalida ...")
	Return( FALSO )
EndIF
Return( OK )

Function LoopData( cCodi, dIni, dFim )
**************************************
LOCAL lAchou	  := FALSO
LOCAL nDiferenca := ( dFim - dIni )
LOCAL nT
LOCAL cData
LOCAL dTemp

IF nDiferenca = 0 // Mesmo Periodo ?
	cData := DateToStr( dIni )
	Return( Chemov->(DbSeek( cCodi + cData )))
Else
	cData := DateToStr( dIni )
	lAchou := Chemov->(DbSeek( cCodi + cData ))
	IF !lAchou
		For nT := 1 To nDiferenca
			dTemp := dIni + nT
			cData := DateToStr( dTemp )
			IF ( lAchou := Chemov->(DbSeek( cCodi + cData )))
				Return( lAchou )
			EndIF
		Next
	EndiF
EndiF
Return( lAchou )
     
Proc Cheq_Pre1()
****************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL nOpcao  := 0
LOCAL cCodi
LOCAL nSaldo1
LOCAL cBanco1
LOCAL cCgc
LOCAL cConta
LOCAL cDocnr
LOCAL dEmis
LOCAL dVcto
LOCAL cHist
LOCAL cObs
LOCAL nVlr
LOCAL cBanco
LOCAL cPraca
LOCAL cAgencia
LOCAL cCpfCgc

IF !PodeIncluir()
	ResTela( cScreen )
	Return
EndIF
Area("Cheque")
Order( CHEQUE_CODI )
WHILE OK
	oMenu:Limpa()
   MaBox( 04, 10, 06, 32 )
	cCodi := Space(4)
   @ 05, 11 Say  "Codigo Conta..:" Get cCodi Pict "9999" Valid CheErrado( @cCodi )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIF
	nSaldo1 := Saldo
	cBanco1 := Banco
	cCgc	  := Cgc
   cConta  := Space(08)
	cDocnr  := Space(9)
	dEmis   := Date()
	dVcto   := Date() + 30
	cHist   := Space(40)
	cObs	  := Space(40)
	nVlr	  := 0
	cPraca  := Space(20)
	cBanco  := Space(10)
	cDebCre := Space(1)
   cAgencia := Space(10)
   cCpfCgc  := Space(14)
	WHILE OK
      MaBox( 07, 10, 22, 71, "INCLUSAO DE CHEQUES PRE-DATADOS" )
      @ 08, 11 Say "Codigo......: " + cCodi + " " + Titular
      @ 09, 11 Say "Banco.......: " + Banco
      @ 10, 11 Say "Emissao.....:" Get dEmis    Pict "@K##/##/##"
      @ 11, 11 Say "Vencimento..:" Get dVcto    Pict "@K##/##/##"
      @ 12, 11 Say "Docto N§....:" Get cDocnr   Pict "@K!" // Valid Ch_Doc_Pre( cDocnr )
      @ 13, 11 Say "Valor.......:" Get nVlr     Pict "@E 9,999,999,999.99" Valid CheqVlr( nVlr )
      @ 14, 11 Say "Historico...:" Get cHist    Pict "@K!"
      @ 15, 11 Say "Banco.......:" Get cBanco   Pict "@K!"
      @ 16, 11 Say "Conta.......:" Get cConta   Pict "@K!"
      @ 17, 11 Say "Praca.......:" Get cPraca   Pict "@K!"
      @ 18, 11 Say "Agencia.....:" Get cAgencia Pict "@K!"
      @ 19, 11 Say "Cpf/Cgc.....:" Get cCpfCgc  Pict "@K!"
      @ 20, 11 Say "Deb/Credito.:" Get cDebCre  Pict "!" Valid PickDebCre( @cDebCre )
      @ 21, 11 Say "Observacao..:" Get cObs     Pict "@K!"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Exit
		EndIF
		nOpcao := Alerta("Voce Deseja ? ", {" Incluir ", " Alterar "," Cancelar "} )
		IF nOpcao = 1	// Incluir
         IF Chepre->(Incluiu())
            Chepre->Codi   := cCodi
            Chepre->Banco  := cBanco1
            Chepre->Obs    := cObs
            Chepre->Docnr  := cDocnr
            Chepre->Data   := dEmis
            Chepre->Valor  := nVlr
            Chepre->Vcto   := dVcto
            Chepre->Hist   := cHist
            Chepre->Conta  := cConta
            Chepre->Banco  := cBanco
            Chepre->Praca  := cPraca
            Chepre->DebCre := cDebCre
            Chepre->Agencia := cAgencia
            Chepre->CpfCgc  := cCpfCgc
            Chepre->Atualizado := Date()
            Chepre->(Libera())
			Else
				Loop
			EndIF
		ElseIf nOpcao = 2 // Alterar
			Loop
		Else
			Exit
		EndIF
	EndDo
EndDo

Function PickDebCre( cSituacao )
/*--------------------------------*/
LOCAL aList 	 := { "C=Cheque Recebido", "D=Cheque Pago" }
LOCAL aSituacao := { "C", "D"}
LOCAL cScreen := SaveScreen()
LOCAL nChoice
IF cSituacao $ aSituacao[1] .OR. cSituacao $ aSituacao[2]
	Return( OK )
Else
	MaBox( 19, 34, 22, 79, NIL, NIL, Roloc( Cor()) )
	IF (nChoice := AChoice( 20, 35, 21, 78, aList )) != 0
		cSituacao := aSituacao[ nChoice ]
	EndIf
EndIF
ResTela( cScreen )
Return( OK )

Proc Cheq_Pre5()
****************
LOCAL cScreen := SaveScreen()
LOCAL aMenu   := {"Por Periodo","Individual","Por Docto","Por Banco", "Por Praca", "Geral" }
LOCAL nChoice
LOCAL cTitular
LOCAL dIni
LOCAL dFim
LOCAL cCodi
LOCAL cCodiIni
LOCAL cCodiFim
LOCAL cDocnr

Chepre->( DbGoTop())
IF Chepre->( Eof())
	Nada()
	ResTela( cScreen )
	Return
EndIF
WHILE OK
	oMenu:Limpa()
	Sx_ClrScope( S_TOP )
	Sx_ClrScope( S_BOTTOM )
	M_Title( "CONSULTAS PRE-DATADOS" )
	nChoice := FazMenu( 05, 20, aMenu )
	Area("ChePre")
	Do Case
	Case nChoice = 0
	  ResTela( cScreen )
	  Exit

	Case nChoice = 1
		MaBox( 16, 20, 19, 45 )
		dIni := Date()-30
		dFim := Date()
		@ 17, 21 Say  "Vcto Inicial..:" Get dIni Pict "##/##/##"
		@ 18, 21 Say  "Vcto Final....:" Get dFim Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Chepre->(Order( CHEPRE_VCTO ))
		Sx_SetScope( S_TOP,	  DateToStr(dIni) )
		Sx_SetScope( S_BOTTOM, DateToStr(dFim ))
		Mensagem('Aguarde, Filtrando.')
		Chepre->(DbGotop())
		IF Sx_KeyCount() == 0
         Sx_ClrScope( S_TOP )
         Sx_ClrScope( S_BOTTOM )
			Nada()
			Loop
		EndIF
		BrowsePredatado()

	Case nChoice = 2
		cCodi := Space(4)
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 16, 20, 20, 45 )
		@ 17, 21 Say  "Codigo........:" Get cCodi Pict "9999" Valid CheErrado( @cCodi )
		@ 18, 21 Say  "Vcto Inicial..:" Get dIni Pict "##/##/##"
		@ 19, 21 Say  "Vcto Final....:" Get dFim Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Chepre->(Order( CHEPRE_CODI_VCTO ))
		Sx_SetScope( S_TOP,	  cCodi + DateToStr( dIni ))
		Sx_SetScope( S_BOTTOM, cCodi + DateToStr( dFim ))
		Mensagem('Aguarde, Filtrando.')
		Chepre->(DbGotop())
		IF Sx_KeyCount() == 0
         Sx_ClrScope( S_TOP )
         Sx_ClrScope( S_BOTTOM )
			Nada()
			Loop
		EndIF
		BrowsePredatado()

	Case nChoice = 3
		cDocnr := Space(9)
		MaBox( 16, 20, 18, 42 )
		@ 17, 21 Say  "Docto N§.:" Get cDocnr Pict "@!" Valid Ch_Doc_Err( @cDocnr )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Chepre->(Order( CHEPRE_DOCNR_VCTO ))
		Sx_SetScope( S_TOP,	  cDocnr )
		Sx_SetScope( S_BOTTOM, cDocnr )
		Mensagem('Aguarde, Filtrando.')
		Chepre->(DbGoTop())
		IF Sx_KeyCount() == 0
         Sx_ClrScope( S_TOP )
         Sx_ClrScope( S_BOTTOM )
			Nada()
			Loop
		EndIF
		BrowsePredatado()

	Case nChoice = 4
		cBanco := Space(10)
		MaBox( 16, 20, 18, 43 )
		@ 17, 21 Say  "Banco....:" Get cBanco Pict "@!" Valid !Empty( cBanco )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Chepre->(Order( CHEPRE_BANCO_VCTO ))
		Sx_SetScope( S_TOP,	cBanco )
		Sx_SetScope( S_BOTTOM, cBanco )
		Mensagem('Aguarde, Filtrando.')
		Chepre->(DbGotop())
		IF Sx_KeyCount() == 0
         Sx_ClrScope( S_TOP )
         Sx_ClrScope( S_BOTTOM )
			Nada()
			Loop
		EndIF
		BrowsePredatado()

	Case nChoice = 5
		cPraca := Space(20)
		MaBox( 16, 20, 18, 53 )
		@ 17, 21 Say  "Praca....:" Get cPraca Pict "@!" Valid !Empty( cPraca )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Chepre->(Order( CHEPRE_PRACA_VCTO ))
		Sx_SetScope( S_TOP,	cPraca )
		Sx_SetScope( S_BOTTOM, cPraca )
		Mensagem('Aguarde, Filtrando.')
		Chepre->(DbGotop())
		IF Sx_KeyCount() == 0
         Sx_ClrScope( S_TOP )
         Sx_ClrScope( S_BOTTOM )
			Nada()
			Loop
		EndIF
		BrowsePredatado()

	Case nChoice = 6
		Chepre->(Order( CHEPRE_CODI_VCTO ))
		Mensagem('Aguarde, Filtrando.')
		Chepre->(DbGoTop())
		BrowsePredatado()

	EndCase
   Sx_ClrScope( S_TOP )
   Sx_ClrScope( S_BOTTOM )
	ResTela( cScreen )
EndDo

Function Ch_Doc_Pre( Var )
**************************
LOCAL Arq_Ant := Alias( )
LOCAL Ind_Ant := IndexOrd()
IF Empty( Var )
	ErrorBeep()
	Alerta("Erro: Numero Documento Invalido ...")
	Return( FALSO )

EndIF
Area( "ChePre" )
Order( CHEPRE_DOCNR_VCTO )
IF ( DbSeek( Var))
	ErrorBeep()
	Alerta("Erro: Documento Ja Registrado ou Incluido por outra Esta‡ao...")
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )

EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function Ch_Doc_Err( cDocnr)
*************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
Area( "ChePre" )
Order( CHEPRE_DOCNR_VCTO )
IF !( DbSeek( cDocnr ))
	Escolhe( 03, 01, 22, "Docnr + 'º' + Hist", "DOCTO N§  HISTORICO DO MOVIMENTO")
	cDocnr := Docnr
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )


Function Ch_Cc_Pre( Var )
*************************
IF Var = "XXX"
	Return( OK )

EndIF
IF Empty( var )
	ErrorBeep()
	Alerta("Erro: Numero Conta Invalida ...")
	Return( FALSO )
EndIF
IF !(DbSeek( Var ) )
	ErrorBeep()
	Alerta("Erro: Numero Conta Nao Registrada ...")
	Return( FALSO )

EndIF
Return( OK )

Proc LancaCheque( lForcarLcto )
******************************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL dData   := Date()
LOCAL dIni	  := Date()
LOCAL dFim	  := Date()

oMenu:Limpa()
MaBox( 10, 10, 14, 40, "ENTRE COM O PERIODO" )
@ 11, 11 Say "Data Inicial..:" Get dIni  Pict "##/##/##"
@ 12, 11 Say "Data Final....:" Get dFim  Pict "##/##/##"
@ 13, 11 Say "Data Baixa....:" Get dData Pict "##/##/##"
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
IF !Conf("Pergunta: Confirma Baixa dos Cheques Vencidos?")
	ResTela( cScreen )
	Return
EndIF
ResTela( cScreen )
Mensagem("Aguarde... Lancando Pre-Datados.", Cor())
Cheque->(Order( CHEQUE_CODI ))
Area( "ChePre" )
Chepre->(Order( CHEPRE_CODI_VCTO ))
Chepre->(DbGoTop())
IF Chepre->(!Eof())	// Banco de Dados Nao Vazio ?
	WHILE !Eof()
		IF Vcto >= dIni .AND. Vcto <= dFim
			cCodi  := Codi
			nValor := Valor
			IF Chepre->(TravaReg())
				IF Cheque->(DbSeek( cCodi ))
					IF Cheque->(TravaReg())
						IF Chemov->(Incluiu())
							Cheque->Saldo -= IF( Chepre->DebCre = "D", Chepre->Valor, 0 )
							Cheque->Saldo += IF( Chepre->DebCre = "C", Chepre->Valor, 0 )
							Cheque->Atualizado := Date()
							Chemov->Codi  := Chepre->Codi
							Chemov->Deb   := IF( Chepre->DebCre = "D", Chepre->Valor, 0 )
							Chemov->Cre   := IF( Chepre->DebCre = "C", Chepre->Valor, 0 )
							Chemov->Saldo := Cheque->Saldo
							Chemov->Docnr := Chepre->Docnr
							Chemov->Emis  := Chepre->Data
							Chemov->Data  := dData
							Chemov->Baixa := Date()
							Chemov->Hist  := Chepre->Hist
							Chemov->Atualizado := Date()
							Cheque->(Libera())
							Chemov->(Libera())
							Chepre->(DbDelete())
							Chepre->(Libera())
						EndIF
					EndIF
				EndIF
			EndIF
		EndIF
		Chepre->(DbSkip(1))
	EndDo
	ResTela( cScreen )
EndIF
Return

Proc Saldo( oBloco, lSaldo )
****************************
LOCAL cScreen	:= SaveScreen()
LOCAL Tam		:= 80
LOCAL Col		:= 58
LOCAL Pagina	:= 0
LOCAL lSair 	:= FALSO
LOCAL nDebito	:= 0
LOCAL nCredito := 0
LOCAL lZerados := OK
LOCAL cTitulo	  := IF( lSaldo, ;
						  "RELATORIO DE CONTAS E SALDOS",;
						  "RELATORIO DE CONTAS")
LOCAL cRelato	  := IF( lSaldo, ;
						  "CODI TITULAR DA CONTA                                   DEBITO           CREDITO",;
						  "CODI TITULAR DA CONTA")

IF lSaldo
	IF !Conf("Pergunta: Imprimir contas com valores zerados ?")
		lZerados := FALSO
	EndIF
EndIF
Mensagem("Aguarde, Imprimindo.", Cor())
PrintOn()
SetPrc( 0, 0 )
WHILE Eval( oBloco ).AND. Rel_Ok()
  IF Col >= 57
	  Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 )))
	  Write( 01, 00, Date() )
	  Write( 02, 00, Padc( XNOMEFIR, Tam ) )
	  Write( 03, 00, Padc( SISTEM_NA5, Tam ) )
	  Write( 04, 00, Padc( cTitulo,Tam ) )
	  Write( 05, 00, Repl( SEP, Tam ) )
	  Write( 06, 00, cRelato )
	  Write( 07, 00, Repl( SEP, Tam ) )
	  Col := 8
  EndIF
  IF lSaldo
	  IF !lZerados
		  IF Cheque->Saldo = 0
			  Cheque->(DbSkip(1))
			  Loop
		  EndIF
	  EndIF
  EndIF
  IF lSaldo
	  IF Saldo < 0
		  nDebito += Saldo
		  Qout( Codi, Titular, Tran( Saldo, "@E 9,999,999,999.99"))
		  Col++
	  Else
		  nCredito += Saldo
		  Qout( Codi, Titular, Space(17), Tran( Saldo, "@E 9,999,999,999.99"))
		  Col++
	  EndIf
  Else
	  Qout( Codi, Titular )
	  Col++
  EndIF
  DbSkip(1)
  IF Col >= 57
	  __Eject()
  EndIF
EndDo
IF lSaldo
	Qout()
	Qout("*** TOTAL ****", Space(29), Tran( nDebito,  "@E 99,999,999,999.99"),;
												 Tran( nCredito, "@E 99,999,999,999.99"))
EndIF
__Eject()
PrintOff()
ResTela( cScreen )
Return

Proc ResumoContas( oBloco )
***************************
LOCAL cScreen	  := SaveScreen()
LOCAL Tam		  := CPI1280
LOCAL Col		  := 58
LOCAL Pagina	  := 0
LOCAL lSair 	  := FALSO
LOCAL cTitulo	  := "RELACAO DE CONTAS E RESUMO DE SALDOS"
lOCAL cRelato	  := "CODI TITULAR DA CONTA                               DEBITOS         CREDITOS            SALDO"
LOCAL aMenuArray := {" Cobranca Interna ", " Cobranca Externa "}
lOCAL nDebitos   := 0
lOCAL nCreditos  := 0
lOCAL nSaldo	  := 0
LOCAL lExterna   := FALSO

oMenu:Limpa()
nChoice := FazMenu( 10, 10, aMenuArray, Cor())
Do Case
Case nChoice = 0
	ResTela( cScreen )
	Return
Case nChoice = 1
	cTitulo := "RELACAO DE CONTAS E RESUMO DE SALDOS - INTERNO"
Case nChoice = 2
	cTitulo := "RELACAO DE CONTAS E RESUMO DE SALDOS - EXTERNO"
	lExterna := OK
EndCase
Mensagem("Aguarde ... Imprimindo.", Cor())
PrintOn()
Fprint( _CPI12 )
SetPrc( 0, 0 )
WHILE Eval( oBloco ).AND. Rel_Ok()
  IF Col >= 57
	  Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
	  Write( 01, 00, Date() )
	  Write( 02, 00, Padc( XNOMEFIR, Tam ) )
	  Write( 03, 00, Padc( SISTEM_NA5, Tam ) )
	  Write( 04, 00, Padc( cTitulo,Tam ) )
	  Write( 05, 00, Repl( SEP, Tam ) )
	  Write( 06, 00, cRelato )
	  Write( 07, 00, Repl( SEP, Tam ) )
	  Col := 8
  EndIF
  IF Cheque->Externa = lExterna
	  Qout( Codi, Left(Titular,37), Tran( Debitos,	"@E 9,999,999,999.99"),;
											  Tran( Creditos, "@E 9,999,999,999.99"),;
											  Tran( Saldo, 	"@E 9,999,999,999.99"))
	  Col++
	  nDebitos	+= Debitos
	  nCreditos += Creditos
	  nSaldo 	+= Saldo
  EndIF
  DbSkip()
  IF Col >= 57
	  __Eject()
  EndIF
EndDo
IF Col >= 56
	Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
	Write( 01, 00, Date() )
	Write( 02, 00, Padc( XNOMEFIR, Tam ) )
	Write( 03, 00, Padc( SISTEM_NA5, Tam ) )
	Write( 04, 00, Padc( cTitulo,Tam ) )
	Write( 05, 00, Repl( SEP, Tam ) )
	Write( 06, 00, cRelato )
	Write( 07, 00, Repl( SEP, Tam ) )
EndIF
Qout("")
Qout("** TOTAL **")
Qqout( Space(31),Tran( nDebitos,  "@E 9,999,999,999.99"),;
					  Tran( nCreditos, "@E 9,999,999,999.99"),;
					  Tran( nSaldo,	 "@E 9,999,999,999.99"))
__Eject()
PrintOff()
ResTela( cScreen )
Return

Function AchaData1( cCodi, dIni )
********************************
LOCAL nRegistro
LOCAL cProcura := cCodi + SubStr(Dtoc(dIni),4,2) ;
								+ Left(Dtoc(dIni),2) 	 ;
								+ Right(Dtoc(dIni),2)
IF Chemov->(DbSeek( cProcura ))
	Return( OK )
EndIF
IF Chemov->(DbSeek( cCodi ))
	While Chemov->Codi = cCodi
		IF Chemov->Data >= dIni
			Return( OK )
		EndIF
		Chemov->(DbSkip())
	EndDo
EndIF
Return( FALSO )

Function AchaData2( cCodi, dIni )
*********************************
IF Chemov->(DbSeek( cCodi ))
	dIni := Chemov->Data
	Return( OK )
EndIF
Return( FALSO )

Function AchaConta1( cCodi )
****************************
IF Chemov->(DbSeek( cCodi ))
	dIni := Chemov->Data
	Return( OK )
EndIF
Return( FALSO )

Proc Contrato( cFatura )
************************
LOCAL cScreen	 := SaveScreen()
LOCAL nQuant	 := 2
LOCAL lRenovado := FALSO

IF cFatura = NIL
	cFatura := Space(07)
Else
	oMenu:Limpa()
EndIF
MaBox( 14, 11, 17, 79, "IMPRESSAO DO CONTRATO")
@ 15,12 Say  "Contrato N§......:" Get cFatura Pict "@!" Valid AchaContrato( @cFatura )
@ 16,12 Say  "Copias...........:" Get nQuant  Pict "99" Valid nQuant > 0
Read
IF LastKey() = ESC .OR. !InsTru80()
	ResTela( cScreen )
	Return
EndIF
Cursos->(Order( CURSOS_CODI ))
Cheque->(Order( CHEQUE_CODI ))
Cursado->(Order( CURSADO_FATURA ))
Cursado->(DbSeek( cFatura ))
cCodi 	 := Cursado->Codi
cCurso	 := Cursado->Curso
nMensal	 := Cursado->Mensalidade
cDuracao  := StrZero(( Cursado->Termino - Cursado->Inicio ) / 30, 2 )
nDuracao  := ( Cursado->Termino - Cursado->Inicio ) / 30
cInicio	 := Cursado->(Dtoc( Inicio ))
dInicio	 := Cursado->Inicio
cDiaVcto  := StrZero(Day( dInicio ), 2 )
cFim		 := Cursado->(Dtoc( Termino ))
Cursos->(DbSeek( cCurso ))
Cheque->(DbSeek( cCodi ))
lRenovado  := Cheque->Renovado

For nA := 1 To nQuant
	PrintOn()
	FPrint( _SALTOOFF )
	FPrint( _SPACO1_8 )
	Qout()
	Qout(GD + NG + Padc("M A C R O S O F T  I N F O R M A T I C A",40) + NR + C18 )
	Qout(GD + NG + Padc("========================================",40) + NR + C18 )
	Qout( 	 Padc("CGC/MF 63.771.588/0001-05       -       INSC.EST. 407.34697-7",80))
	Qout( 	 Padc("Rua Cassimiro de Abreu, 52 - Sala 07 - Centro - CEP 78984-000",80))
	Qout( 	 Padc("Fone (69)3451-3085 - PIMENTA BUENO - RONDONIA",80))
	Qout("")
	Fprint( _CPI12 )
	Qout(NG + GD + Padc("FICHA DE INSCRICAO E CONTRATO", CPI1280/2) + NR + C18 )
	Qout(NG + GD + Padc("PARTICULAR DE PRESTACAO DE SERVICOS", CPI1280/2) + NR + C18 )
	Qout("")
	Fprint( _CPI10 )
	Qout(NG + Padc("DADOS PESSOAIS",80,"-") + NR)
	Qout( 	 "Aluno       :" + Cheque->Titular + " Nascimento :" + Cheque->(Dtoc( Nasci)))
	Qout( 	 "Endereco    :" + Cheque->Ende )
	Qout( 	 "Cidade      :" + Cheque->Cida + Space(14) + " Estado    : " + Cheque->Esta )
	Qout( 	 "Identidade  :" + Cheque->Rg   + Space(21) + " CPF       : " + Cheque->Cpf )
	Qout( 	 "Telefone    :" + Cheque->Fone + Space(26) + " Profissao :" + Cheque->Profissao )
	Qout( 	 "Trabalho    :" + Cheque->Trabalho + " Telefone :" + Cheque->Fone1 )
	Qout( 	 "Matricula   :" + cInicio )
	Qout("")
	Qout(NG + Padc("DADOS RESPONSAVEL",80,"-") + NR)
	Qout( 	 "Responsavel :" + Cheque->Resp )
	Qout( 	 "Endereco    :" + Cheque->Ende1 )
	Qout( 	 "Telefone    :" + Cheque->Fone2 )
	Qout( 	 "Identidade  : " + Cheque->Rg1 + " CPF :" + Cheque->Cpf1 )
	Qout("")
	Qout(NG + Padc("DURACAO/HORARIO/DIAS/CURSO",80,"-") + NR)
	Qout( 	 "Curso   : " + Cursos->Obs )
	Qout( 	 "Horario : " + Cheque->Horario + " Hs.")
	Qout( 	 "Dias    : " + Cheque->Dias )
	Qout( 	 "Inicio  : " + cInicio )
	Qout( 	 "Duracao : " + cDuracao + " Meses.")
	Qout( 	 "Termino : " + cFim )
	Qout("")
	Qout(NG + Padc("DISPOSICOES GERAIS",80,"-") + NR)
	FPrint( PQ )
   Qout(     "   A Microbras Sistemas de Informatica Ltda, estabelecida nesta cidade de Pimenta Bueno, onde ministra cursos de informatica,")
   Qout(     "   doravante denominada MICROBRAS e o aluno ou o responsavel acima citado(s) doravante denominado ALUNO, tem entre si justo e")
	Qout( 	 "   contratado o seguinte:")
	Qout("")
   Qout(     "Clausula Primeira: A MICROBRAS se compromete a ministrar o curso no horario e dia escolhido pelo ALUNO neste contrato,     no")
	Qout( 	 "   periodo compreendido entre o dia &cInicio e &cFim., sendo que o mesmo tera tera a sua disposicao (01) computador e mate-")
	Qout( 	 "   rial didatico necessario, e no final do curso certificado de conclusao caso o mesmo tenha aproveitamento suficiente.")
	Qout("")
   Qout(     "Clausula Segunda: A MICROBRAS ira repor as faltas de aulas se porventura seja constatada a sua culpa, como falta de professor,")
	Qout( 	 "   energia, quebra de maquinas. Outrossim, o ALUNO justificara a falta com atestado medico, ou pagara a parte para repo-las.")
	Qout("")
	Qout( 	 "Clausula Terceira: O ALUNO comparecera nas aulas no horario e dia escolhido, e pagara o curso em " + cDuracao + " parcelas iguais.")
	Qout( 	 "   A Primeira parcela no ato da inscricao e o restante conforme descriminado abaixo:")
	Qout("")
	Qout( 	 "   DOCTO N§  EMISSAO    VENCTO            VALOR")
	Qout( 	 "   --------------------------------------------")
	For nX	:= 1 To nDuracao
		IF Cursado->Matricula != 0  // Primeiro Curso ?
			nMensal := Cursado->Mensalidade + IF( nX = 1, Cursado->Matricula, 0 )
		Else
			nMensal := Cursado->Mensalidade
		EndIF
		nMes					  := Month( dInicio )
		cAno					  := Right( Dtoc( dInicio ),2)
		IF (nMes + (nX-1)) > 12
			nMes -= 12
			cAno := StrZero( Val( cAno )+1, 2)
		EndIF
						dVcto 				  := dInicio + IF( nX = 1, 0, 30 * ( nX-1))
		dVcto  := IF( nX = 1, dInicio, Ctod( cDiaVcto + "/" + StrZero( nMes + nX-1,2) + "/" + cAno ))
		Qout( Space(02), Codi + "-" + Right( cCurso,2) + "-" + StrZero( nX,1), dInicio, dVcto, Tran( nMensal, "@E 9,999,999,999.99"))
	Next
	Qout("")
	Qout( 	 "Clausula Quarta: O comparecimento ou nao do ALUNO(A) ao curso nao o dispensara do pagamento integral do mesmo, seja por qual-")
	Qout( 	 "   quer motivo, salvo dispensa por escrito e carimbado da diretoria da escola.")
	Qout("")
	Qout( 	 "Clausula Quinta: No caso de arrependimento do ALUNO, o qual devera ser informado por escrito e assinado a   diretoria      da")
   Qout(     "   MICROBRAS, o ALUNO pagara a mesma uma multa de 50% (Cinquenta por cento) do valor do contrato, alem do valor ja pago.   Os")
	Qout( 	 "   documentos assinados serao devolvidos mediante pagamento da multa o qual devera ser efetuada no ato do arrependimento.")
	Qout("")
	Qout( 	 "Clausula Sexta: Sera considerado desistencia, caso o ALUNO tenha 04 faltas consecutivas as aulas, salvo Clausula Segunda,")
   Qout(     "   e considerar-se-ao vencidas todas as parcelas vincendas o que dara direito a MICROBRAS a cobrar e receber as mesmas, e")
	Qout( 	 "   disponibizar a vaga ora ocupada.")
	Qout("")
	Qout("")
	FPrint( _CPI10 )
	Qout("")
	Qout("")
	Qout( Repl("-",39) + Space( 02 ) +  Repl("-",39))
	Qout( Cheque->Titular		+ Space( 02 ) + Cheque->Resp )
	Qout()
	Qout()
	Qout( Padc( Repl("-",40),80))
   Qout( Padc("Microbras Com de Prod de de Informatica Ltda",80))
	Qout( Padc("Rep Legal : Vilmar Catafesta",80))
	__Eject()
Next
PrintOff()
ResTela( cScreen )
Return

Proc EntradaNova()
******************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL nMensal := 0

WHILE OK
	oMenu:Limpa()
	cCodi 	  := Space(4)
	cTitular   := Space(40)
	cCpf		  := Space(15)
	cRg		  := Space(18)
	dNasci	  := Date()
	cEnde 	  := Space(35)
	cCida 	  := Space(25)
	cEsta 	  := Space(02)
	cFone 	  := Space(13)
	cProfissao := Space(15)
	cTrabalho  := Space(40)
	cFone1	  := Space(13)
	cFone2	  := Space(13)
	cResp 	  := Space(40)
	cEnde1	  := Space(35)
	cCpf1 	  := Space(15)
	cRg1		  := Space(18)
	dInicio	  := Date()
	cMens 	  := "S"
	cObs		  := Space(40)
	cHorario   := Space(11)
	cDias 	  := Space(15)
	nDuracao   := 0
	cCurso	  := Space(04)
	cCep		  := Space(09)
	WHILE OK
		MaBox( 01, 02, 23, 78, "FICHA DE INCLUSAO DE ALUNOS" )
		Area("Cheque")
		Cheque->(Order( CHEQUE_CODI ))
		DbGoBottom()
		cCodi := StrZero( Val( Codi ) + 1, 4 )
		@ 02,03 Say  "Anterior....: " + Codi + " " + Titular
		@ 03,02 Say "Ã" + Repl("Ä",75) + "´"
		@ 04,03 Say  "Codigo......:" Get cCodi      Pict "9999" Valid CheCerto( @cCodi ) .AND. RecCerto( @cCodi )
		@ 04,22 Say  "Aluno(a):"     Get cTitular   Pict "@!" Valid !Empty( cTitular )
		@ 05,03 Say  "CPF.........:" Get cCpf       Pict "999-999-999-99"
		@ 05,43 Say  "RG.....:"      Get cRg        Pict "@!"
		@ 06,03 Say  "Nascimento..:" Get dNasci     Pict "##/##/##"
		@ 07,03 Say  "Endereco....:" Get cEnde      Pict "@!"
		@ 08,03 Say  "Cidade......:" Get cCep       Pict "#####-###"
		@ 08,27 Say  "/"             Get cCida      Pict "@!"
		@ 08,56 Say  "Estado.:"      Get cEsta      Pict "@!"
		@ 09,03 Say  "Telefone....:" Get cFone      Pict "(999)999-9999"
		@ 10,03 Say  "Profissao...:" Get cProfissao Pict "@!"
		@ 11,03 Say  "Trabalho....:" Get cTrabalho  Pict "@!"
		@ 12,03 Say  "Telefone....:" Get cFone1     Pict "(999)999-9999"
		@ 13,02 Say "Ã" + Repl("Ä",75) + "´"

		@ 14,03 Say  "Responsavel.:" Get cResp      Pict "@!" When (Date() - dNasci) < 6570
		@ 15,03 Say  "Endereco....:" Get cEnde1     Pict "@!" When (Date() - dNasci) < 6570
		@ 16,03 Say  "Telefone....:" Get cFone2     Pict "(999)999-9999" When (Date() - dNasci) < 6570
		@ 17,03 Say  "CPF.........:" Get cCpf1      Pict "999-999-999-99" When (Date() - dNasci) < 6570
		@ 18,03 Say  "RG..........:" Get cRg1       Pict "@!" When (Date() - dNasci) < 6570
		@ 19,02 Say "Ã" + Repl("Ä",75) + "´"
		@ 20,03 Say  "Inicio......:" Get dInicio    Pict "@!"
		@ 21,03 Say  "Dias........:" Get cDias      Pict "@!" Valid PickDia( @cDias )
		@ 21,43 Say  "Horario.....:" Get cHorario   Pict "99:99/99:99" Valid !Empty( cHorario )
		@ 22,03 Say  "Curso/Obs...:" Get cCurso     Pict "9999" Valid CursoErrado( @cCurso, 22, 23, @cObs )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Exit

		EndIF
		nDuracao 	 := Cursos->Duracao
		nMensal		 := Cursos->Mensal
		nTaxa 		 := Cursos->Taxa

		nChoice		 := Alerta( "Voce Deseja ?", {" Incluir ", " Alterar ", " Sair "})
		IF nChoice = 1
			IF !Checerto( @cCodi )
				Loop
			EndIF
			Area("Cursado")
			IF Cursado->(Incluiu())
				Cursado->Codi			:= cCodi
				Cursado->Curso 		:= cCurso
				Cursado->Fatura		:= cCodi + "-" + Right( cCurso, 2)
				Cursado->Inicio		:= dInicio
				Cursado->Termino		:= dInicio + ( nDuracao * 30 )
				Cursado->Matricula	:= nTaxa
				Cursado->Mensalidade := nMensal
				Cursado->Atualizado	:= Date()
				Cursado->(Libera())
			EndIF
			Area("Cheque")
			IF Incluiu()
				Cheque->Codi		 := cCodi
				Cheque->Titular	 := cTitular
				Cheque->Cpf 		 := cCpf
				Cheque->Rg			 := cRg
				Cheque->Nasci		 := dNasci
				Cheque->Ende		 := cEnde
				Cheque->Cida		 := cCida
				Cheque->Esta		 := cEsta
				Cheque->Fone		 := cFone
				Cheque->Profissao  := cProfissao
				Cheque->Trabalho	 := cTrabalho
				Cheque->Fone1		 := cFone1
				Cheque->Fone2		 := cFone2
				Cheque->Resp		 := cResp
				Cheque->Ende1		 := cEnde1
				Cheque->Cpf1		 := cCpf1
				Cheque->Rg1 		 := cRg1
				Cheque->Data		 := dInicio
				Cheque->Mens		 := IF( cMens = "S", OK, FALSO )
				Cheque->Obs 		 := cObs
				Cheque->Horario	 := cHorario
				Cheque->Duracao	 := nDuracao
				Cheque->Dias		 := cDias
				Cheque->Ativo		 := OK
				Cheque->Curso		 := cCurso
				Cheque->Renovado	 := FALSO
				Cheque->Atualizado := Date()
				Cheque->(Libera())
				IF Receber->(Incluiu())
					Receber->UltCompra  := dInicio
					Receber->Data		  := dInicio
					Receber->Codi		  := cCodi
					Receber->Nome		  := cTitular
					Receber->Cpf		  := cCpf
					Receber->Rg 		  := cRg
					Receber->Ende		  := cEnde
					Receber->Cida		  := cCida
					Receber->Esta		  := cEsta
					Receber->Cep		  := cCep
					Receber->Fone		  := cFone
					Receber->Fanta 	  := cResp
					Receber->Obs		  := Cursos->Obs
					Receber->Atualizado := Date()
					Receber->(Libera())
					nJdia := JuroDia( nMensal, aJuroMes[1] )
					For nX := 1 To nDuracao
						IF Recemov->(Incluiu())
							Recemov->Codi		  := cCodi
							Recemov->Docnr 	  := cCodi + "-" + Right( cCurso, 2) + "-" +  StrZero( nX,1 )
							Recemov->Emis		  := dInicio
							Recemov->Qtd_D_Fatu := 1
							dVcto 				  := dInicio + IF( nX = 1, 0, ( 30 * (nX-1) ))
							Recemov->Vcto		  := dVcto
							Recemov->Vlr		  := nMensal + IF( nX = 1, nTaxa, 0 )
							Recemov->Port		  := "B.BRASIL"
							Recemov->Tipo		  := "DL"
							Recemov->Juro		  := aJuroMes[1]
							Recemov->Jurodia	  := nJdia
							Recemov->Fatura	  := cCodi + "-" + Right( cCurso, 2)
							Recemov->VlrFatu	  := nMensal * nDuracao + nTaxa
							Recemov->Titulo	  := OK
							Recemov->VlrDolar   := nMensal + IF( nX = 1, nTaxa, 0 )
							Recemov->Atualizado := Date()
						EndIF
					Next
					Recemov->(Libera())
				EndIF
				oMenu:Limpa()
				WHILE OK
					M_Title("ESCOLHA A OPCAO A IMPRIMIR")
					nEscolha := FazMenu( 06, 29, {"Contrato", "Promissorias", "Duplicatas", "Boleto Bancario","Nenhum"}, Roloc(Cor()))
					IF nEscolha = 0
						Exit
					ElseIF nEscolha = 1
						Contrato( cCodi )
					ElseIF nEscolha = 2
                  ProBranco( cCodi )
					ElseIF nEscolha = 3
                  DupPersonalizado( cCodi )
					ElseIF nEscolha = 4
						DiretaLivre( cCodi )
					ElseIF nEscolha = 4
					  Exit
					EndIF
				EndDo
				cCodi := StrZero( Val( cCodi )+1, 4 )
			EndIF
		ElseIF nChoice = 2
			Loop

		ElseIF nChoice = 3
			Exit

		EndIF
	EndDo
	Exit
EndDo
ResTela( cScreen )

Proc Frequencia()
*****************
LOCAL cScreen		:= SaveScreen()
LOCAL Tam			:= 80
LOCAL Col			:= 58
LOCAL Pagina		:= 0
LOCAL lSair 		:= FALSO
LOCAL cTitulo		:= "LISTAGEM DE ALUNOS"
LOCAL cCabecalho	:= " INICIO  DUR  TERMINO NOME DO ALUNO                                 TELEFONE"
LOCAL lNovaHora	:= OK
LOCAL cNovaHora	:= ""
LOCAL nConta		:= 0
LOCAL aMenuArray	:= { " Alunos Ativos ", " Alunos Inativos " }
LOCAL nChoice		:= 1
LOCAL lAtivo

M_Title("Relatorio de Frequencia")
nChoice := FazMenu( 05, 10, aMenuArray, Cor())
Do Case
Case nChoice = 0
	ResTela( cScreen )
	Return
Case nChoice = 1
	lAtivo  := OK
	cTitulo += " ATIVOS"
Case nChoice = 2
	lAtivo  := FALSO
	cTitulo += " INATIVOS"
EndCase
IF !InsTru80() .OR. !LptOK()
	ResTela( cScreen )
	Return
EndIF
Mensagem("Aguarde, Imprimindo.", Cor())
PrintOn()
SetPrc( 0, 0 )
Area("Cheque")
Cheque->(Order( CHEQUE_HORARIO ))
Cheque->(DbGoTop())
WHILE !Eof() .AND. Rel_Ok()
  IF Col >= 57
	  Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
	  Write( 01, 00, Date() )
	  Write( 02, 00, Padc( XNOMEFIR, Tam ) )
	  Write( 03, 00, Padc( SISTEM_NA5, Tam ) )
	  Write( 04, 00, Padc( cTitulo,Tam ) )
	  Write( 05, 00, Repl( SEP, Tam ) )
	  Write( 06, 00, cCabecalho )
	  Write( 07, 00, Repl( SEP, Tam ) )
	  Col := 8
  EndIF
  IF lAtivo = Cheque->Ativo
	  IF lNovaHora .OR. Col = 8
		  lNovaHora := FALSO
		  Qout("")
		  Qout( NG + Padc( Horario, 80,"=") + NR)
		  Col += 2
	  EndIF
	  Qout( Data, StrZero( Duracao,3), Data + ( 30 * Duracao ), Titular, Fone )
	  cNovaHora := Cheque->Horario
	  Col++
	  nConta++
  EndIF
  DbSkip()
  IF cNovaHora != Cheque->Horario
	  lNovaHora := OK
  EndiF
  IF Col >= 57
	  __Eject()
  EndIF
EndDo
Qout("")
Qout("TOTAL DE ALUNOS : " + StrZero( nConta, 5))
__Eject()
PrintOff()
ResTela( cScreen )
Return

Proc Chamada()
**************
LOCAL cScreen		  := SaveScreen()
LOCAL Tam			  := 132
LOCAL Col			  := 58
LOCAL Pagina		  := 0
LOCAL lSair 		  := FALSO
LOCAL cTitulo		  := "LISTAGEM DE CHAMADA DE ALUNOS "
LOCAL cCabecalho	  := " INICIO  DUR  TERMINO NOME DO ALUNO                                 TELEFONE           ASSINATURA                     OBSERVACOES"
LOCAL lNovaHora	  := OK
LOCAL cNovaHora	  := ""
LOCAL nConta		  := 0
LOCAL aMenuArray	  := { " Alunos Ativos ", " Alunos Inativos " }
LOCAL nChoice		  := 1
LOCAL lLerNovamente := FALSO
LOCAL lAtivo

M_Title("Relatorio de Frequencia")
nChoice := FazMenu( 05, 10, aMenuArray, Cor())
Do Case
Case nChoice = 0
	ResTela( cScreen )
	Return
Case nChoice = 1
	lAtivo  := OK
	cTitulo += "ATIVOS"
Case nChoice = 2
	lAtivo  := FALSO
	cTitulo += "INATIVOS"
EndCase
IF !InsTru80() .OR. !LptOK()
	ResTela( cScreen )
	Return
EndIF
Mensagem("Aguarde, Imprimindo.", Cor())
PrintOn()
SetPrc( 0, 0 )
FPrint( PQ )
Recemov->(Order( RECEMOV_CODI ))
Area("Cheque")
Cheque->(Order( CHEQUE_HORARIO ))
Cheque->(DbGoTop())
WHILE Cheque->(!Eof()) .AND. Rel_Ok()
  IF Col >= 57
	  Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
	  Write( 01, 00, Date() )
	  Write( 02, 00, Padc( XNOMEFIR, Tam ) )
	  Write( 03, 00, Padc( SISTEM_NA5, Tam ) )
	  Write( 04, 00, Padc( cTitulo,Tam ) )
	  Write( 05, 00, Repl( SEP, Tam ) )
	  Write( 06, 00, cCabecalho )
	  Write( 07, 00, Repl( SEP, Tam ) )
	  Col := 8
  EndIF
  IF Cheque->Ativo = lAtivo
	  dVcto := Data + ( 30 * Duracao )
	  IF ( lContratoVencido := IF( Date() >= dVcto, OK, FALSO ))
		  lLerNovamente := OK
		  Cheque->(DbSkip(1))
		  Loop
	  EndIF
	  IF lNovaHora .OR. Col = 8
		  lNovaHora := FALSO
		  Qout("")
		  Qout( Padc( Horario, Tam,"=") )
		  Col += 2
	  EndIF
	  FPrint( PQ )
	  cCodi				 := Cheque->Codi
	  lAtraso			 := FALSO
	  IF Recemov->(DbSeek( cCodi ))
		  WHILE Recemov->Codi = cCodi
			  IF Recemov->Vcto <= Date()
				  lAtraso := OK
			  EndIF
			  Recemov->(DbSkip(1))
		  EndDo
	  EndIF
	  cString := ""
	  IF lContratoVencido
		  cString += "  (01)"
	  EndIF
	  IF lAtraso
		  cString += IF( !lContratoVencido, "        (02)", "  (02)")
	  EndIF
	  Qout( Data, StrZero( Duracao,3), Data + ( 30 * Duracao ), Titular, Fone, Repl("_",40) + cString )
	  cNovaHora := Cheque->Horario
	  Col++
	  nConta++
  EndIF
  Cheque->(DbSkip(1))
  IF cNovaHora != Cheque->Horario
	  lNovaHora := OK
  EndiF
  IF Col >= 57
	  __Eject()
  EndIF
EndDo
IF lLerNovamente
	Qout("")
	Qout( Padc( "ALUNOS COM CONTRATO VENCIDO", Tam,"=") )
	Col += 2
	Cheque->(DbGoTop())
	WHILE Cheque->(!Eof()) .AND. Rel_Ok()
		IF Col >= 57
			Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
			Write( 01, 00, Date() )
			Write( 02, 00, Padc( XNOMEFIR, Tam ) )
			Write( 03, 00, Padc( SISTEM_NA5, Tam ) )
			Write( 04, 00, Padc( cTitulo,Tam ) )
			Write( 05, 00, Repl( SEP, Tam ) )
			Write( 06, 00, cCabecalho )
			Write( 07, 00, Repl( SEP, Tam ) )
			Col := 8
		EndIF
	IF ( lAtivo := Cheque->Ativo )
		dVcto 			  := Data + ( 30 * Duracao )
		cCodi 			  := Cheque->Codi
		lAtraso			  := FALSO
		lContratoVencido := IF( Date() >= dVcto, OK, FALSO )
		IF lContratoVencido
			IF Recemov->(DbSeek( cCodi ))
				WHILE Recemov->Codi = cCodi
					IF Recemov->Vcto <= Date()
						lAtraso := OK
					EndIF
					Recemov->(DbSkip(1))
				EndDo
			EndIF
			cString := "  (01)"
			IF lAtraso
				cString += IF( !lContratoVencido, "        (02)", "  (02)")
			EndIF
			Qout( Data, StrZero( Duracao,3), Data + ( 30 * Duracao ), Titular, Fone, Repl("_",40) + cString )
			Col++
			nConta++
		EndIF
	EndIF
	Cheque->(DbSkip(1))
	EndDo
EndIF
Qout("")
Qout("TOTAL DE ALUNOS : " + StrZero( nConta, 5))
Qout()
Qout("(01) - CONTRATO VENCIDO.")
Qout("(02) - MENSALIDADE EM ATRASO.")
__Eject()
PrintOff()
ResTela( cScreen )
Return

Proc ContratoVencido()
**********************
LOCAL cScreen		:= SaveScreen()
LOCAL Tam			:= 80
LOCAL Col			:= 58
LOCAL Pagina		:= 0
LOCAL lSair 		:= FALSO
LOCAL cTitulo		:= "LISTAGEM DE ALUNOS COM CONTRATO VENCIDO"
LOCAL cCabecalho	:= " INICIO  DUR  TERMINO NOME DO ALUNO                                 TELEFONE"
LOCAL nConta		:= 0
LOCAL lAtivo

IF !InsTru80() .OR. !LptOK()
	ResTela( cScreen )
	Return
EndIF
Mensagem("Aguarde ... Imprimindo.", Cor())
PrintOn()
SetPrc( 0, 0 )
Area("Cheque")
Cheque->(Order( CHEQUE_HORARIO ))
Cheque->(DbGoTop())
WHILE !Eof() .AND. Rel_Ok()
  IF Col >= 57
	  Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
	  Write( 01, 00, Date() )
	  Write( 02, 00, Padc( XNOMEFIR, Tam ) )
	  Write( 03, 00, Padc( SISTEM_NA5, Tam ) )
	  Write( 04, 00, Padc( cTitulo,Tam ) )
	  Write( 05, 00, Repl( SEP, Tam ) )
	  Write( 06, 00, cCabecalho )
	  Write( 07, 00, Repl( SEP, Tam ) )
	  Col := 8
  EndIF
  IF Cheque->Ativo
	  nTermino := Data + ( 30 * Duracao )
	  IF nTermino <= Date()
		  Qout( Data, StrZero( Duracao,3), nTermino, Titular, Fone )
		  Col++
		  nConta++
	  EndIf
  EndIF
  Cheque->(DbSkip(1))
  IF Col >= 57
	  __Eject()
  EndIF
EndDo
Qout("")
Qout("TOTAL DE ALUNOS : " + StrZero( nConta, 5))
__Eject()
PrintOff()
ResTela( cScreen )
Return

Proc Recontrato()
*****************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL nRenova := 0

WHILE OK
	Area("Cheque")
	Order( CHEQUE_CODI )
	WHILE OK
		oMenu:Limpa()
		MaBox( 10, 02, 15, 78, "FICHA DE ALTERACAO DE CONTRATO")
		cCodi 	  := Space(4)
		dInicio	  := Date()
		cObs		  := Space(40)
		cHorario   := Space(11)
		cDias 	  := Space(15)
		cMens 	  := "S"
		nDuracao   := 0
		cCurso	  := Space(04)
		@ 11, 03 Say "Codigo......:" Get cCodi      Pict "9999" Valid CheErrado( @cCodi,, 11, 23 )
		@ 12, 03 Say "Inicio......:" Get dInicio    Pict "@!"
		@ 13, 03 Say "Dias........:" Get cDias      Pict "@!" Valid PickDia( @cDias )
		@ 13, 43 Say "Horario.....:" Get cHorario   Pict "99:99/99:99" Valid !Empty( cHorario )
		@ 14, 03 Say "Curso/Obs...:" Get cCurso     Pict "9999" Valid CursoErrado( @cCurso, 14, 23, @cObs )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Exit
		EndIF
		nDuracao := Cursos->Duracao
		nRenova	:= Cursos->Renova
		nMensal	:= Cursos->Renova
		cFatura	:= cCodi + "-" + Right( cCurso, 2)
		nChoice	:= Alerta( "Voce Deseja ?", {" Incluir ", " Alterar ", " Sair "})
		IF nChoice = 1
			Cursado->(Order( CURSADO_CODI ))
			IF Cursado->(DbSeek( cCodi )) // Aluno Jah Fez Curso ?
				nTaxa := 0
			Else
				nTaxa := Cursos->Taxa
			EndIF
			IF Cursado->(Incluiu())
				Cursado->Codi			:= cCodi
				Cursado->Curso 		:= cCurso
				Cursado->Fatura		:= cCodi + "-" + Right( cCurso, 2)
				Cursado->Inicio		:= dInicio
				Cursado->Termino		:= dInicio + ( nDuracao * 30 )
				Cursado->Mensalidade := nMensal
				Cursado->Matricula	:= nTaxa
				Cursado->Atualizado	:= Date()
				Cursado->(Libera())
			EndIF
			IF Cheque->(TravaReg())
				IF Cheque->Data < dInicio
					Cheque->Data		 := dInicio
					Cheque->Obs 		 := cObs
					Cheque->Horario	 := cHorario
					Cheque->Duracao	 := nDuracao
					Cheque->Dias		 := cDias
					Cheque->Curso		 := cCurso
					Cheque->Atualizado := Date()
				EndIF
				Cheque->Ativo		 := OK
				Cheque->Renovado	 := OK
				Cheque->Atualizado := Date()
				Cheque->(Libera())
				Receber->( Order( RECEBER_CODI ))
				IF Receber->(!DbSeek( cCodi ))
					IF Receber->(Incluiu())
						Receber->UltCompra  := dInicio
						Receber->Data		  := dInicio
						Receber->Nome		  := Cheque->Titular
						Receber->Cpf		  := Cheque->Cpf
						Receber->Rg 		  := Cheque->Rg
						Receber->Ende		  := Cheque->Ende
						Receber->Cida		  := Cheque->Cida
						Receber->Esta		  := Cheque->Esta
						Receber->Fone		  := Cheque->Fone
						Receber->Obs		  := Cursos->Obs
						Receber->Atualizado := Date()
					EndIF
				Else
					IF Receber->(TravaReg())
						Receber->UltCompra  := dInicio
						Receber->Data		  := dInicio
						Receber->Nome		  := Cheque->Titular
						Receber->Fanta 	  := Cheque->Resp
						Receber->Cpf		  := Cheque->Cpf
						Receber->Rg 		  := Cheque->Rg
						Receber->Ende		  := Cheque->Ende
						Receber->Cida		  := Cheque->Cida
						Receber->Esta		  := Cheque->Esta
						Receber->Fone		  := Cheque->Fone
						Receber->Obs		  := Cursos->Obs
						Receber->Atualizado := Date()
					EndIF
				EndIF
				Receber->(Libera())
				nJdia := JuroDia( nRenova, aJuroMes[1] )
				For nX := 1 To nDuracao
					IF Recemov->(Incluiu())
						Recemov->Codi		  := cCodi
						Recemov->Docnr 	  := cCodi + "-" + Right( cCurso, 2) + "-" + StrZero( nX,1 )
						Recemov->Emis		  := dInicio
						Recemov->Qtd_D_Fatu := 1
						dVcto 				  := dInicio + IF( nX = 1, 0, 30 * ( nX-1))
						Recemov->Vcto		  := dVcto
						Recemov->Vlr		  := nRenova
						Recemov->Port		  := "B.BRASIL"
						Recemov->Tipo		  := "DL"
						Recemov->Juro		  := aJuroMes[1]
						Recemov->Jurodia	  := nJdia
						Recemov->Fatura	  := cCodi + "-" + Right( cCurso, 2)
						Recemov->VlrFatu	  := nRenova * nDuracao
						Recemov->Titulo	  := OK
						Recemov->VlrDolar   := nRenova
						Recemov->Atualizado := Date()
					EndIF
				Next
				Recemov->(Libera())
				oMenu:Limpa()
				WHILE OK
					M_Title("ESCOLHA A OPCAO A IMPRIMIR")
					nEscolha := FazMenu( 06, 29, {"Contrato", "Promissorias", "Duplicatas","Boleto Bancario","Nenhum"}, Roloc(Cor()))
					IF nEscolha = 0
						Exit
					ElseIF nEscolha = 1
						Contrato( cFatura )
					ElseIF nEscolha = 2
                  ProBranco( cCodi )
					ElseIF nEscolha = 3
                  DupPersonalizado( cCodi )
					ElseIF nEscolha = 4
						DiretaLivre( cCodi )
					ElseIF nEscolha = 5
					  Exit
					EndIF
				EndDo
			EndIF
		ElseIF nChoice = 2
			Loop
		ElseIF nChoice = 3
			Exit
		EndIF
	EndDo
	Exit
EndDo
ResTela( cScreen )

Proc CursosInclusao()
*********************
Local cScreen := SaveScreen(	)
WHILE OK
  oMenu:Limpa()
  cCurso   := Space(04)
  cObs	  := Space(40)
  nDuracao := 0
  nMensal  := 0
  nRenova  := 0
  nTaxa	  := 0

  Area("Cursos")
  Cursos->(Order( CURSOS_CODI ))
  DbGoBottom()
  cCurso := StrZero( Val( Curso ) + 1, 4 )
  MaBox( 06, 02, 13, 78, "INCLUSAO DE NOVOS CURSOS")
  WHILE OK
	  @ 07,03 Say	"Anterior...: " + Curso + " " + Obs
	  @ 08,03 Say	"Codigo.....:" Get cCurso   Pict "9999"          Valid CursoCerto( @cCurso )
	  @ 08,21 Say	"Descricao..:" Get cObs     Pict "@!"            Valid !Empty( cObs )
	  @ 09,03 Say	"Mensalidade:" Get nMensal  Pict "9999999999.99" Valid nMensal > 0
	  @ 10,03 Say	"Renovacao..:" Get nRenova  Pict "9999999999.99" Valid nRenova > 0
	  @ 11,03 Say	"Taxa Insc..:" Get nTaxa    Pict "9999999999.99" Valid nTaxa   > 0
	  @ 12,03 Say	"Duracao/Mes:" Get nDuracao Pict "999"           Valid nDuracao >= 3
	  Read
	  IF LastKey() = ESC
		  ResTela( cScreen )
		  Exit
	  EndIF
	  ErrorBeep()
	  nOpcao := Alerta(" Pergunta: Voce Deseja ? ", {" Incluir ", " Alterar ", " Sair " })
	  IF nOpcao = 1
		  IF !CursoCerto( @cCurso )
			  Loop
		  EndIF
		  Area("Cursos")
		  IF Cursos->(Incluiu())
			  Cursos->Curso	:= cCurso
			  Cursos->Obs		:= cObs
			  Cursos->Duracao := nDuracao
			  Cursos->Mensal	:= nMensal
			  Cursos->Renova	:= nRenova
			  Cursos->Taxa 	:= nTaxa
			  Cursos->Atualizado := Date()
			  Cursos->(Libera())
			  cCurso := StrZero( Val( cCurso )+1, 4 )
		  EndIF
	  ElseIF nOpcao = 2
		  Loop
	  Else
		  Exit
	  EndIF
  EndDo
  ResTela( cScreen )
  Exit
EndDo

Function CursoCerto( cCurso)
****************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
IF ( Empty( cCurso ) )
	ErrorBeep()
	Alerta( "Erro: C¢digo Curso Invalido..." )
	Return( FALSO )
EndIF
Area( "Cursos" )
Cursos->(Order( CURSOS_CODI ))
IF Cursos->(DbSeek( cCurso ))
	ErrorBeep()
	Alerta("Erro: Codigo curso j  registrado..." )
	cCurso := StrZero( Val( cCurso )+1,4)
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function CursoErrado( cCurso, nRow, nCol, cObs )
************************************************
LOCAL aRotina := {{|| CursosInclusao() }}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Area( "Cursos" )
Cursos->(Order( CURSOS_CODI ))
IF Cursos->(!DbSeek( cCurso ))
	Escolhe( 03, 01, 22, "Curso + 'º' + Obs", "CODIGO DESCRICAO DO CURSO", aRotina )
	cCurso := Cursos->Curso
	cObs	 := Cursos->Obs
	IF nRow != Nil
		Write( nRow, nCol, Obs )
	EndIF
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIF
cObs	 := Cursos->Obs
IF nRow != Nil
	Write( nRow, nCol, Obs )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Proc DebitosAlunos()
********************
LOCAL cScreen		:= SaveScreen()
LOCAL lImpresso	:= FALSO
LOCAL nParcial 	:= 0
LOCAL nTotal		:= 0
LOCAL nRecParcial := 0
LOCAL nRecTotal	:= 0
LOCAL Lista 		:= SISTEM_NA5
LOCAL Titulo		:= "LISTAGEM DE MENSALIDADES A RECEBER/RECEBIDAS"
LOCAL Tam			:= 80
LOCAL Col			:= 58
LOCAL Pagina		:= 0
LOCAL NovoCodi 	:= OK
LOCAL aMenuArray	:= {" Individual ", " Geral ", " Vencidos " }
LOCAL nChoice		:= 1
LOCAL oBloco		:= {|| Receber->(!Eof()) }
LOCAL cCodi 		:= Space(05)
LOCAL lParcial 	:= FALSO

Area("Receber")
Receber->( Order( RECEBER_NOME ))
Area("Recebido")
Area("Recemov")
oBloco := {|| Receber->(!Eof()) }
Receber->(DbGotop())
UltCodi := Receber->Codi
nChoice := FazMenu( 04, 10, aMenuArray, Cor())
Do Case
Case nChoice = 0
	ResTela( cScreen )
	Return
Case nChoice = 1
	MaBox( 10, 10, 12, 70 )
	@ 11, 11 Say "Codigo...." Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,,11, 28 )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	oBloco  := {|| Receber->Codi = cCodi }
	UltCodi := cCodi
	IF Recemov->(!DbSeek( cCodi )) .AND. Recebido->(!DbSeek( cCodi ))
		oMenu:Limpa()
		ErrorBeep()
		Alert("Erro: Nenhum Movimento Disponivel deste Codigo.")
		ResTela( cScreen )
		Return
	EndiF
Case nChoice = 2
	lParcial := FALSO

Case nChoice = 3
	lParcial := OK

EndCase
IF !Instru80() .OR. !LptOk()
	ResTela( cScreen )
	Return
EndIF
Mensagem("Aguarde, Imprimindo. ESC Cancela.", Cor())
PrintOn()
SetPrc( 0 , 0 )
WHILE Eval( oBloco ) .AND. Rel_Ok( )
	cNome 	 := Receber->(AllTrim( Nome ))
	lImpresso := FALSO
	IF Col >= 57
		Linha( Lista, Titulo, @Pagina, Tam )
		Col := 8
	EndIF
	IF !lParcial
		IF Recebido->(DbSeek( UltCodi ))
			lImpresso := OK
			Write( Col, 0, NG + Receber->(Padr( Codi + " " + cNome, Tam,"-")) + NR)
			Col++
			WHILE Recebido->Codi = UltCodi
				IF Col >= 57
					Linha( Lista, Titulo, @Pagina, Tam )
					Col := 8
					lImpresso := OK
					Write( Col, 0, NG + Receber->(Padr( Codi + " " + cNome, Tam,"-")) + NR)
					Col++
				EndIF
				dEmis 		:= Recebido->(Dtoc( Emis ))
				dVcto 		:= Recebido->(Dtoc( Vcto ))
				dPgto 		:= Recebido->(Dtoc( DataPag ))
				nValor		:= Recebido->(Tran( Vlr,  "@E 9,999,999,999.99"))
				nPago 		:= Recebido->(Tran( VlrPag,  "@E 9,999,999,999.99"))
				cDocnr		:= Recebido->Docnr
				nRecParcial += Recebido->VlrPag
				nRecTotal	+= Recebido->VlrPag
				Qout( cDocnr, dEmis, dVcto, nValor, dPgto, nPago )
				Recebido->(DbSkip(1))
				Col++
			EndDo
		Else
			lImpresso := FALSO
		EndIF
	EndIF
	IF Recemov->(DbSeek( UltCodi ))
		IF lParcial
			WHILE Recemov->Codi = UltCodi
				IF Recemov->Vcto > Date()
					Recemov->(DbSkip(1))
					Loop
				EndIF
				Exit
			EndDo
			IF Recemov->Codi != UltCodi
				Receber->(DbSkip(1))
				UltCodi := Receber->Codi
				Loop
			EndIF
		EndIF
		IF !lImpresso
			Write( Col, 0, NG + Receber->(Padr( Codi + " " + cNome, Tam,"-")) + NR)
			Col++
			lImpresso := OK
		EndIF
		IF lParcial
			bBloco := {|| Recemov->Codi = UltCodi .AND. Recemov->Vcto <= Date() }
		Else
			bBloco := {|| Recemov->Codi = UltCodi }
		EndIF
		WHILE Eval( bBloco )
			IF Col >= 57
				Linha( Lista, Titulo, @Pagina, Tam )
				Col := 8
				lImpresso := OK
				Write( Col, 0, NG + Receber->(Padr( Codi + " " + cNome, Tam,"-")) + NR)
				Col++
			EndIF
			dEmis 	:= Recemov->(Dtoc( Emis ))
			dVcto 	:= Recemov->(Dtoc( Vcto ))
			nValor	:= Recemov->(Tran( Vlr,  "@E 9,999,999,999.99"))
			cDocnr	:= Recemov->Docnr
			nParcial += Recemov->Vlr
			nTotal	+= Recemov->Vlr
			Qout( cDocnr, dEmis, dVcto, nValor )
			Recemov->(DbSkip(1))
			Col++
		EndDo
	EndIF
	IF lImpresso
		Col++
		Write( Col, 0,"** Total Aluno   **" + Space(09) + Tran( nParcial, "@E 9,999,999,999.99") + Space(10) + Tran( nRecParcial, "@E 9,999,999,999.99"))
		nParcial 	:= 0
		nRecParcial := 0
		Col			+= 2
	EndiF
	Receber->(DbSkip(1))
	UltCodi := Receber->Codi
	IF Col >= 57
		__Eject()
		IF Receber->(Eof())
			Col := 0
		EndIF
	EndIF
EndDo
Write( Col, 0,"** Total Geral **" + Space(11) + Tran( nTotal, "@E 9,999,999,999.99") + Space(10) + Tran( nRecTotal, "@E 9,999,999,999.99"))
__Eject()
PrintOff()
ResTela( cScreen )
Return

Static Proc Linha( Lista, Titulo, Pagina, Tam )
***********************************************
Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
Write( 01, 01, Dtoc( Date() ))
Write( 02, 00, Padc( XNOMEFIR, Tam ))
Write( 03, 00, Padc( Lista  , Tam ))
Write( 04, 00, Padc( Titulo , Tam ))
Write( 05, 00, Repl( SEP, Tam ) )
Write( 06, 00, "DOCTO N§   EMISSAO   VENCTO            VALOR  DT PGTO       VALOR PAGO")
Write( 07, 00, Repl( SEP, Tam ) )
Return

Function AchaData( cCodi, dIni )
********************************
LOCAL cScreen := SaveScreen()
LOCAL nRegistro
LOCAL cProcura := cCodi + SubStr(Dtoc(dIni),4,2) ;
								+ Left(Dtoc(dIni),2) 	 ;
								+ Right(Dtoc(dIni),2)
IF Chemov->(DbSeek( cProcura ))
	Return( OK )
EndIF
IF Chemov->(DbSeek( cCodi ))
	While Chemov->Codi = cCodi
		IF Chemov->Data >= dIni
			ResTela( cScreen )
			Return( OK )
		EndIF
		Chemov->(DbSkip())
	EndDo
EndIF
ResTela( cScreen )
Return( FALSO )

Proc MenuBaixaPre()
*******************
LOCAL cScreen := SaveScreen()
LOCAL Opcao   := 1

M_Title("BAIXAR PRE-DATADOS")
Opcao := FazMenu( 10, 10, { " Individual   ", " Automatico, Por Periodo "}, Cor() )
Do Case
Case Opcao = 0
	ResTela( cScreen )
	Return

Case Opcao = 1
	BrowseBaixaPre()

Case Opcao = 2
	LancaCheque()

EndCase

Proc DevolveContrato()
**********************
LOCAL cScreen := SaveScreen()
LOCAL cFatu   := Space(07)

WHILE OK
	MaBox( 10, 05, 12, 35 )
	@ 11, 06 Say "Contrato # :" Get cFatu Pict "@!" Valid AchaContrato( @cFatu )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	ErrorBeep()
	IF Conf("Pergunta: Confirma Cancelamento do Contrato ?")
		Recemov->(Order( RECEMOV_FATURA ))
		Chemov->(Order( CHEMOV_FATURA ))
		Cursado->(Order( CURSADO_FATURA ))
		IF Cursado->(DbSeek( cFatu ))
			IF Cursado->(TravaReg())
				Cursado->(DbDelete())
				Cursado->(Libera())
			EndIF
			Recemov->(Order( RECEMOV_FATURA ))
			IF Recemov->(DbSeek( cFatu ))
				IF Recemov->(TravaArq())
					WHILE Recemov->Fatura = cFatu
						Recemov->(DbDelete())
						Recemov->(DbSkip(1))
					EndDo
					Recemov->(Libera())
				EndIF
			EndIF
			IF Chemov->(DbSeek( cFatu ))
				IF Chemov->(TravaArq())
					WHILE Chemov->Fatura = cFatu
						Chemov->(DbDelete())
						Chemov->(DbSkip(1))
					EndDo
					Chemov->(Libera())
				EndIF
			EndIF
			ErrorBeep()
			IF Conf("Pergunta: Deseja Excluir os recebidos tambem ?")
				ErrorBeep()
				IF Conf("Pergunta: Tem Certeza ?")
					Recebido->(Order( RECEBIDO_FATURA ))
					IF Recebido->(DbSeek( cFatu ))
						IF Recebido->(TravaArq())
							WHILE Recebido->Fatura = cFatu
								Recebido->(DbDelete())
								Recebido->(DbSkip(1))
							EndDo
							Recebido->(Libera())
						EndIF
					EndIF
				EndIF
			EndIF
		EndIF
	EndIF
ENDDO

Function AchaContrato( cDocnr, nVlrFatura, cCodi )
**************************************************
LOCAL cScreen	 := SaveScreen()
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL nRegistro := 0
PUBLI Reg_Doc
IF LastKey() = UP
	Return( OK )
EndIF
Receber->(Order( RECEBER_CODI))
Cursado->(Order( CURSADO_FATURA ))
IF Cursado->(!DbSeek( cDocnr ))
	ErrorBeep()
	IF Conf("Erro: Contrato nao Localizado. Localizar por Nome ?.")
		IF LocalizaContrato( @cDocnr, @nRegistro )
			Cursado->( DbGoTo( nRegistro ))
		EndIF
	Else
		Receber->(Order( RECEBER_CODI))
		Area("Cursado")
		Set Rela To Codi Into Receber
		Cursado->(Order( CURSADO_FATURA ))
		Escolhe( 03, 01, 22, "Fatura + 'Ý' + Receber->Nome", "N§ CONTR  ONOME DO CLIENTE")
		Cursado->(DbClearRel())
	EndIF
	cDocnr := Cursado->Fatura
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function LocalizaContrato( cDocnr, nRegistro )
********************************************
LOCAL cScreen	 := SaveScreen()
LOCAL GetList	 := {}
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL nTam		 := 0
LOCAL aDocnr	 := {}
LOCAL aRegistro := {}
LOCAL aTodos	 := {}
LOCAL cCodi 	 := Space(05)
LOCAL cFatura	 := ""
LOCAL cEmissao  := ""
LOCAL cVlr		 := ""

oMenu:Limpa()
MaBox( 15, 05, 17, 73 )
@ 16, 06 Say "Codigo Cliente..: " Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
Read
IF LastKey() = ESC
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
EndIF
Area("Cursado")
Cursado->(Order( CURSADO_CODI ))
IF Cursado->(!DbSeek( cCodi ))
	ErrorBeep()
	Alerta( "Erro: Nenhum Contrato Deste Cliente." )
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
EndIF
Cursos->(Order( CURSOS_CODI ))
WHILE Cursado->Codi = cCodi
	cFatura	:= Cursado->Fatura
	cInicio	:= Cursado->(Dtoc( Inicio ))
	cTermino := Cursado->(Dtoc( Termino ))
	cCurso	:= Cursado->Curso
	IF Cursos->(DbSeek( cCurso ))
		cNomeCurso := Cursos->Obs
	Else
		cNomeCurso := Repl( "*", 10) + "CURSO NAO REGISTRADO" + Repl( "*", 10)
	EndIF
	Aadd( aDocnr,	  cFatura )
	Aadd( aRegistro, Cursado->(Recno()))
	Aadd( aTodos,	 cFatura + " " + cInicio + " " + cTermino  + " " + cNomeCurso )
	Cursado->(DbSkip(1))
EndDo
nTam := Len( aTodos )
IF nTam = 0
	ErrorBeep()
	Alerta( "Erro: Nenhum Contrato Deste Cliente." )
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
EndIF
MaBox( 00, 05, 14, 75, "CONTRATO  INICIO   TERMINO  NOME DO CURSO                           ")
nChoice := aChoice( 01, 06, 13, 74, aTodos )
ResTela( cScreen )
IF nChoice = 0
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
EndIF
cDocnr	 := aDocnr[ nChoice ]
nRegistro := aRegistro[ nChoice ]
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )
Return( OK )

Function PickDia( cDia )
************************
LOCAL cScreen := SaveScreen()
LOCAL aMenu   := { "SEGUNDA/SEXTA  ","SABADO        " }
LOCAL nChoice := 1
LOCAL nX 	  := 1

For nX := 1 To 2
	IF cDia $ aMenu[nX]
		Return( OK )
	EndIF
Next
MaBox( 20, 33, 23, 49 )
nChoice := Achoice( 21, 34, 22, 48, aMenu )
cDia	  := aMenu[ IF( nChoice = 0, 1, nChoice )]
Keyb Chr( ENTER )
ResTela( cScreen )
Return OK

Proc TipoLcto()
***************
LOCAL cScreen := SaveScreen()
LOCAL aMenu   := { " Normal ", " Automatico " }
LOCAL nChoice

WHILE OK
	M_Title("ESCOLHA O TIPO DE LANCAMENTO")
	nChoice := FazMenu( 06, 10, aMenu, Cor())
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit
   Case nChoice = 1
		LancaMovimento()
   Case nChoice = 2
		LancaMoviAuto()
   EndCase
EnDdo

Proc IncConta()
***************
LOCAL cScreen := SaveScreen()
LOCAL GetList := {}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL cCodi   := Space(02)
LOCAL cHist   := Space(40)

WHILE OK
	Area("Conta")
   Conta->(Order( CONTA_CODI ))
	oMenu:Limpa()
	MaBox( 05, 01, 8, 55, "INCLUSAO DE CONTA HISTORICO")
	Conta->(DbGoBoTTom())
	cCodi := Conta->( StrZero( Val( Codi )+1, 2))
	@ 06, 02 Say "Codigo....: " Get cCodi Pict "99" Valid ContaCerta( @cCodi )
	@ 07, 02 Say "Historico.: " Get cHist Pict "@!"
	Read
	IF LastKey() = ESC
		Exit
	EndIF
	ErrorBeep()
	IF Conf("Pergunta: Confirma Inclusao da Conta Historico ?")
		IF ContaCerta( cCodi )
			IF Conta->(Incluiu())
				Conta->Codi 		:= cCodi
				Conta->Hist 		:= cHist
				Conta->Atualizado := Date()
				Conta->(Libera())
			EndIF
		EndIF
	EndIF
EndDo
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Function ContaCerta( cCodi )
****************************
IF Empty( cCodi ) .OR. cCodi = "00" .OR. Len(Alltrim( cCodi )) < 2
	ErrorBeep()
	Alerta("Erro: Codigo Conta Historico Invalida. ")
	Return(FALSO)
EndIF
IF Conta->( DbSeek( cCodi ) )
	ErrorBeep()
	Alerta("Erro: Conta Historico ja registrada. ;" + Conta->(Trim( Hist )))
	cCodi := Conta->(StrZero( Val( Codi ) +1, 2 ))
	Return( FALSO )
EndIF
Return( OK )

Proc IncSubConta()
*******************
LOCAL cScreen	:= SaveScreen()
LOCAL GetList	:= {}
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cCodi 	:= Space(02)
LOCAL cSubCodi := Space(04)
LOCAL cDebCre	:= "C"

WHILE OK
	Area("SubConta")
	Subconta->(Order( SUBCONTA_CODI ))
	oMenu:Limpa()
	MaBox( 05, 01, 09, 75, "INCLUSAO DE SUB CONTA HISTORICO")
	SubConta->(DbGoBoTTom())
	@ 06, 02 Say "Codigo....: " Get cCodi    Pict "99"   Valid ContaErrada( @cCodi, Row(), Col()+1 )
	@ 07, 02 Say "SubConta..: " Get cSubCodi Pict "9999" Valid Cheerrado( @cSubCodi,, Row(), Col()+1 ) .AND. SubContaCerta( @cSubCodi )
	@ 08, 02 Say "Deb/Cre...: " Get cDebCre  Pict "!"    Valid cDebCre $ "CD"
	Read
	IF LastKey() = ESC
		Exit
	EndIF
	ErrorBeep()
	IF Conf("Pergunta: Confirma Inclusao da Sub Conta Historico ?")
		IF SubContaCerta( cSubCodi )
			IF SubConta->(Incluiu())
				SubConta->Codi 		:= cCodi
				SubConta->SubCodi 	:= cSubCodi
				SubConta->DebCre		:= cDebCre
				SubConta->Atualizado := Date()
				SubConta->(Libera())
			EndIF
		EndIF
	EndIF
EndDo
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Function SubContaCerta( cSubCodi )
********************************
IF Empty( cSubCodi ) .OR. Len(Alltrim( cSubCodi )) < 4
	ErrorBeep()
	Alerta("Erro: Codigo Sub Conta Historico Invalida. ")
	Return(FALSO)
EndIF
Return( OK )

Function ContaErrada( cCodi, nRow, nCol )
*****************************************
LOCAL aRotina := {{|| IncConta() }}
LOCAL cScreen := SaveScreen()
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
FIELD Codi
FIELD Hist

Area("Conta")
Conta->(Order( CONTA_CODI ))
IF Conta->( !DbSeek( cCodi ))
	Escolhe( 03, 01, 22, "Codi + 'Ý' + Hist","CODI HISTORICO DA CONTA ", aRotina  )
	cCodi  := Conta->Codi
EndIF
IF nRow != Nil
	Write( nRow, nCol, Conta->Hist )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return(OK)

Proc LancaMoviAuto( cCaixa )
****************************
LOCAL cScreen	:= SaveScreen()
LOCAL GetList	:= {}
LOCAL cTexto	:= "LANCAMENTOS DEBITOS/CREDITOS AUTOMATICO"
LOCAL cCodi 	:= Space(02)
LOCAL aSub		:= {}
LOCAL nValor	:= 0
STATI nDocto	:= 1
LOCAL lSair
LOCAL nSaldo
LOCAL cDocnr	:= Space(09)
LOCAL dEmis 	:= Date()
LOCAL cHist 	:= Space(40)
LOCAL nVlr		:= 0

oMenu:Limpa()
Area("Conta")
Order( CONTA_CODI )
WHILE OK
	cDocnr  := StrTran( Dtoc( Date()), "/" ) + "-" + StrZero( nDocto, 2 ) // 240697-01
	MaBox( 10, 10, 16, 75, cTexto )
	@ 11, 11 Say "Codigo Historico.:" Get cCodi    Pict "@K 99" Valid ContaErrada( @cCodi, Row(), Col()+1 ) .AND. FillConta( cCodi, @aSub )
	@ 12, 11 Say "Data.............:" Get dEmis    Pict "##/##/##"
	@ 13, 11 Say "Docto. N§........:" Get cDocnr   Pict "@K!" Valid CheqDoc( cDocnr )
	@ 14, 11 Say "Historico........:" Get cHist    Pict "@K!"
	@ 15, 11 Say "Valor............:" Get nVlr     Pict "@E 9,999,999,999.99" Valid CheqVlr( nVlr )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	nOpcao := Alerta("Voce Deseja ? ", {" Incluir ", " Alterar "," Sair "} )
	IF nOpcao = 1	// Incluir
		IF Chemov->(!TravaArq()) ; Chemov->(Libera()) ; Loop ; EndIF
		IF Cheque->(!TravaArq()) ; Chemov->(Libera()) ; Loop ; EndIF
		Cheque->(Order( CHEQUE_CODI ))
		nTam := Len( aSub )
		For nX := 1 To nTam
			Cheque->( DbSeek( aSub[nX, 1 ] ))
			Chemov->(DbAppend())
			IF aSub[nX,2] = "C"
				Cheque->Saldo += nVlr
				Chemov->Cre   := nVlr
			Else
				Cheque->Saldo -= nVlr
				Chemov->Deb   := nVlr
			EndIF
			nTotal				 := Cheque->Saldo
			Chemov->Atualizado := Date()
			Chemov->Codi		 := aSub[nX,1]
			Chemov->Docnr		 := cDocnr
			Chemov->Data		 := dEmis
			Chemov->Baixa		 := Date()
			Chemov->Emis		 := dEmis
			Chemov->Hist		 := cHist
			Chemov->Saldo		 := nTotal
			Chemov->Caixa		 := IF( cCaixa = NIL, "", cCaixa )
			Chemov->Tipo		 := IF( cCaixa = NIL, "", "OU" )
			nDocto++
		Next
		Chemov->(Libera())
		Cheque->(Libera())

	ElseIf nOpcao = 2   // Alterar
		Loop
	ElseIF nOpcao = 3  // Sair
		Exit
	EndIF
EndDo
ResTela( cScreen )
Return

Function FillConta( cCodi, aSub )
*********************************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen ()
LOCAL aArray  := {}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

aSub			  := {}
Area("SubConta")
SubConta->( Order( SUBCONTA_CODI ))
IF SubConta->(DbSeek( cCodi ))
	WHILE SubConta->Codi = cCodi
		Aadd( aSub, { SubConta->SubCodi, SubConta->DebCre })
		SubConta->(DbSkip(1))
	EndDo
	Return( OK )
EndIF
ErrorBeep()
Alerta("Erro: Conta Historico sem Sub Conta.")
Return( FALSO )

Proc BrowsePredatado()
**********************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
Area("Chepre")
oBrowse:Add( "CODIGO",    "Codi")
oBrowse:Add( "HISTORICO", "Hist")
oBrowse:Add( "DOCTO N§",  "Docnr")
oBrowse:Add( "DATA",      "Data")
oBrowse:Add( "VCTO",      "Vcto")
oBrowse:Add( "VALOR",     "Valor")
oBrowse:Add( "DEB/CRE",   "DebCre")
oBrowse:Add( "BANCO",     "Banco")
oBrowse:Add( "PRACA",     "Praca")
oBrowse:Add( "CONTA",     "Conta")
oBrowse:Add( "OBSERVACOES","Obs")
oBrowse:Titulo   := "CONSULTA/ALTERACAO DE CHEQUES PRE-DATADOS"
oBrowse:PreDoGet := {|| PodeAlterar()}
oBrowse:PreDoDel := {|| PodeExcluir()}
oBrowse:HotKey( ASTERISTICO, {|| SomaPre() })
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Function SomaPre()
******************
LOCAL nValor := 0
LOCAL nRec	 := Chepre->(Recno())

Chepre->(DbGoTop())
WHILE Chepre->(!Eof())
	nValor += Chepre->Valor
	Chepre->(DbSkip(1))
EndDo
Chepre->(DbGoTo( nRec ))
Alerta( "Soma dos Cheques : " + Tran( nValor, "@E 999,999,999.99"))
Return( OK )

Proc BrowseBaixaPre()
*********************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
Area("Chepre")
oBrowse:Add( "CODIGO",    "Codi")
oBrowse:Add( "HISTORICO", "Hist")
oBrowse:Add( "DOCTO N§",  "Docnr")
oBrowse:Add( "DATA",      "Data")
oBrowse:Add( "VCTO",      "Vcto")
oBrowse:Add( "VALOR",     "Valor")
oBrowse:Add( "DEB/CRE",   "DebCre")
oBrowse:Add( "BANCO",     "Banco")
oBrowse:Add( "PRACA",     "Praca")
oBrowse:Add( "CONTA",     "Conta")
oBrowse:Add( "OBSERVACOES","Obs")
oBrowse:Titulo   := "BAIXA DE CHE-PREDATADOS"
oBrowse:PreDoGet := NIL
oBrowse:PosDoGet := NIL
oBrowse:PreDoDel := {|| PreDelBaixaPre( oBrowse )}
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Function PreDelBaixaPre( oBrowse )
**********************************
LOCAL oCol		:= oBrowse:getColumn( oBrowse:colPos )
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL dData 	:= Date()
LOCAL dEmis 	:= Chepre->Data
LOCAL cDocnr	:= Chepre->Docnr
LOCAL nVlr		:= Chepre->Valor
LOCAL cDebCre	:= Chepre->DebCre
LOCAL cHist 	:= Chepre->Hist
LOCAL cCodi 	:= Chepre->Codi
LOCAL cCodi1	:= Space(04)
LOCAL cCodi2	:= Space(04)
LOCAL cCodi3	:= Space(04)
LOCAL cDebCre1 := "C"
LOCAL cDebCre2 := "C"
LOCAL cDebCre3 := "C"
LOCAL lOpcional := OK

MaBox( 09, 10, 20, 75, NIL, NIL, Roloc( Cor()) )
@ 10, 11 Say "Docnr......:" Get cDocnr   Pict "@!" Valid IF((Chepre->(Order( CHEPRE_DOCNR_VCTO )), Chepre->(!DbSeek( cDocnr ))),  ( ErrorBeep(), Alerta("Erro: Documento nao Localizado"), FALSO ), OK )
@ 11, 11 Say "Data Baixa.:" Get dData    Pict '##/##/##'
@ 12, 11 Say "Historico..:" Get cHist    Pict "@K!"
@ 13, 11 Say "D/C........:" Get cDebCre  Pict "!" Valid cDebCre $("CD")
@ 14, 11 Say "C. Partida.:" Get cCodi1   Pict "9999" Valid CheErrado( @cCodi1,, Row(), 33, lOpcional )
@ 15, 11 Say "D/C........:" Get cDebCre1 Pict "!" Valid cDebCre1 $("CD")
@ 16, 11 Say "C. Partida.:" Get cCodi2   Pict "9999" Valid CheErrado( @cCodi2,, Row(), 33, lOpcional )
@ 17, 11 Say "D/C........:" Get cDebCre2 Pict "!" Valid cDebCre2 $("CD")
@ 18, 11 Say "C. Partida.:" Get cCodi3   Pict "9999" Valid CheErrado( @cCodi3,, Row(), 33, lOpcional )
@ 19, 11 Say "D/C........:" Get cDebCre3 Pict "!" Valid cDebCre3 $("CD")
Read
IF LastKey() != ESC
	ErrorBeep()
	IF Conf("Pergunta: Confirma Baixa deste Cheque ?")
		IF Cheque->(!TravaArq()) ; DbUnLockAll() ; Return( Ventila( cScreen, oBrowse )) ; EndIF
		IF Chemov->(!TravaArq()) ; DbUnLockAll() ; Return( Ventila( cScreen, oBrowse )) ; EndIF
		IF Chepre->(!TravaArq()) ; DbUnLockAll() ; Return( Ventila( cScreen, oBrowse )) ; EndIF
		Cheque->(Order( CHEQUE_CODI ))
		IF Cheque->(DbSeek( Chepre->Codi ))
			Chemov->(DbAppend())
			IF cDebCre = "C"
				Cheque->Saldo		 += nVlr
				Cheque->Atualizado := Date()
				Chemov->Cre 		 := nVlr
			Else
				Cheque->Saldo		 -= nVlr
				Cheque->Atualizado := Date()
				Chemov->Deb 		 := nVlr
			EndIF
			Chemov->Codi  := cCodi
			Chemov->Saldo := Cheque->Saldo
			Chemov->Docnr := cDocnr
			Chemov->Emis  := dEmis
			Chemov->Data  := dData
			Chemov->Baixa := Date()
			Chemov->Hist  := cHist
			Chemov->Atualizado := Date()
			Chepre->(DbDelete())
			Chepre->(Libera())
			*:-------------------------------------------------------
			IF !Empty( cCodi1 )
				Cheque->(Order( CHEQUE_CODI ))
				IF Cheque->( DbSeek( cCodi1 ))
					Chemov->(DbAppend())
					IF cDebCre1 = "C"
						Cheque->Saldo		 += nVlr
						Cheque->Atualizado := Date()
						Chemov->Cre 		 := nVlr
					Else
					  Cheque->Saldo		-= nVlr
					  Cheque->Atualizado := Date()
					  Chemov->Deb			:= nVlr
					EndIF
					nTotal		  := Cheque->Saldo
					Chemov->Codi  := cCodi1
					Chemov->Docnr := cDocnr
					Chemov->Data  := dData
					Chemov->Baixa := Date()
					Chemov->Emis  := dEmis
					Chemov->Hist  := cHist
					Chemov->Saldo := nTotal
				EndIF
			EndIF
			*:-------------------------------------------------------
			IF !Empty( cCodi2 )
				Cheque->(Order( CHEQUE_CODI ))
				IF Cheque->( DbSeek( cCodi2 ))
					Chemov->(DbAppend())
					IF cDebCre2 = "C"
						Cheque->Saldo += nVlr
						Chemov->Cre   := nVlr
					Else
					  Cheque->Saldo -= nVlr
					  Chemov->Deb	 := nVlr
					EndIF
					nTotal				 := Cheque->Saldo
					Chemov->Codi		 := cCodi2
					Chemov->Docnr		 := cDocnr
					Chemov->Data		 := dData
					Chemov->Baixa		 := Date()
					Chemov->Emis		 := dEmis
					Chemov->Hist		 := cHist
					Chemov->Saldo		 := nTotal
					Chemov->Atualizado := Date()
				EndIF
			EndIF
			*:-------------------------------------------------------
			IF !Empty( cCodi3 )
				Cheque->(Order( CHEQUE_CODI ))
				IF Cheque->( DbSeek( cCodi3 ))
					Chemov->(DbAppend())
					IF cDebCre3 = "C"
						Cheque->Saldo += nVlr
						Chemov->Cre   := nVlr
					Else
					  Cheque->Saldo -= nVlr
					  Chemov->Deb	 := nVlr
					EndIF
					nTotal				 := Cheque->Saldo
					Chemov->Codi		 := cCodi3
					Chemov->Docnr		 := cDocnr
					Chemov->Data		 := dData
					Chemov->Baixa		 := Date()
					Chemov->Emis		 := dEmis
					Chemov->Hist		 := cHist
					Chemov->Saldo		 := nTotal
					Chemov->Atualizado := Date()
				EndIF
			EndIF
		EndIF
		Chemov->(Libera())
		Cheque->(Libera())
	EndIF
EndIF
Return( Ventila( cScreen, oBrowse ))

Function Ventila( cScreen, oBrowse )
************************************
Restela( cScreen )
oBrowse:refreshCurrent():forceStable()
oBrowse:up():forceStable()
oBrowse:Freshorder()
Return( FALSO )

Proc ConsultaNova()
*******************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
Area("Cheque")
Cheque->(Order( CHEQUE_TITULAR ))
Cheque->(DbGoTop())
oBrowse:Add( "CODIGO",    "Codi")
oBrowse:Add( "TITULAR",   "Titular")
oBrowse:Add( "CURSO",     "Obs")
oBrowse:Add( "HORARIO",   "Horario")
oBrowse:Add( "DIAS",      "Dias")
oBrowse:Add( "DURACAO",   "Duracao")
oBrowse:Titulo   := "CONSULTA/ALTERACAO DE ALUNOS"
oBrowse:PreDoGet := {|| PreConsultaNova( oBrowse ) } // Rotina do Usuario Antes de Atualizar
oBrowse:PosDoGet := NIL
oBrowse:PreDoDel := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Function PreConsultaNova( oBrowse )
***********************************
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Do Case
Case oCol:Heading = "CODI"
	ErrorBeep()
	Alerta("Erro: Alteracao nao Permitida.")
	Return( FALSO )
Case oCol:Heading = "DURACAO"
	ErrorBeep()
	Alerta("Erro: Alteracao nao Permitida.")
	Return( FALSO )
Otherwise
EndCase
Return( OK )

Proc CursosAlteracao()
**********************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
Area("Cursos")
Cursos->(Order( CURSOS_CODI ))
Cheque->(DbGoTop())
oBrowse:Add( "CODIGO",      "Curso")
oBrowse:Add( "CURSO",       "Obs")
oBrowse:Add( "DURACAO",     "Duracao")
oBrowse:Add( "MENSALIDADE", "Mensal")
oBrowse:Add( "RENOVACAO",   "Renova")
oBrowse:Add( "MATRICULA",   "Taxa")
oBrowse:Titulo   := "CONSULTA/ALTERACAO DE CURSOS"
oBrowse:PreDoGet := {|| PreCursosAlteracao( oBrowse ) } // Rotina do Usuario Antes de Atualizar
oBrowse:PosDoGet := NIL
oBrowse:PreDoDel := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Function PreCursosAlteracao( oBrowse )
**************************************
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Do Case
Case oCol:Heading = "CURSO"
	ErrorBeep()
	Alerta("Erro: Alteracao nao Permitida.")
	Return( FALSO )
Case oCol:Heading = "DURACAO"
Otherwise
EndCase
Return( OK )

Proc BrowseContas()
******************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
Area("Cheque")
Cheque->(Order( CHEQUE_TITULAR ))
Cheque->(DbGoTop())
oBrowse:Add( "CODIGO",    "Codi")
oBrowse:Add( "TITULAR",   "Titular")
oBrowse:Add( "BANCO",     "Banco")
oBrowse:Add( "AGENCIA",   "Ag")
oBrowse:Titulo   := "CONSULTA/ALTERACAO DE CONTAS"
oBrowse:PreDoGet := {|| PreBrowseContas( oBrowse ) } // Rotina do Usuario Antes de Atualizar
oBrowse:PosDoGet := NIL
oBrowse:PreDoDel := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Function PreBrowseContas( oBrowse )
***********************************
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Do Case
Case oCol:Heading = "CODI"
Case oCol:Heading = "TITULAR"
Otherwise
EndCase
Return( OK )

Function PreBrowseBaixarPre( oBrowse )
**************************************
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Do Case
Case oCol:Heading = "CODI"
Case oCol:Heading = "HIST"
Case oCol:Heading = "DEBCRE"
Otherwise
EndCase
Return( OK )

*:---------------------------------------------------------------------------------------------------------------------------------

Proc mnuImpPre()
****************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL aMenu   := { "Individual", "Banco", "Praca", "Geral"}
LOCAL nChoice := 0
LOCAL cCodi   := Space(04)
LOCAL cPraca  := Space(20)
LOCAL cBanco  := Space(10)
LOCAL dIni	  := Date()-30
LOCAL dFim	  := Date()
LOCAL nItens  := 0
LOCAL oBloco
LOCAL cCodiIni
LOCAL cCodiFim
FIELD Codi
FIELD Vcto
FIELD Praca
FIELD Banco

WHILE OK
	Sx_ClrScope( S_TOP )
	Sx_ClrScope( S_BOTTOM )
	oMenu:Limpa()
	M_Title("IMPRESSAO PRE-DATADOS")
	nChoice := FazMenu( 06, 10, aMenu, Cor())
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit
	Case nChoice = 1
		cCodi := Space(4)
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 14, 10, 18, 78 )
		@ 15, 11 Say "Codigo........:" Get cCodi Pict "9999" Valid CheErrado( @cCodi, NIL,  Row(), Col()+1 )
		@ 16, 11 Say "Vcto Inicial..:" Get dIni  Pict "##/##/##"
		@ 17, 11 Say "Vcto Final....:" Get dFim  Pict "##/##/##" Valid IF( dFim < dIni, ( ErrorBeep(), Alerta("Erro: Data final maior que inicial."), FALSO ), OK )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Area("ChePre")
		Chepre->(Order( CHEPRE_CODI_VCTO ))
		Sx_SetScope( S_TOP, cCodi + DateToStr( dini ))
		Sx_SetScope( S_BOTTOM, cCodi + DateToStr( dFim ))
		Mensagem('Aguarde, Filtrando.')
		Chepre->(DbGotop())
		IF (nItens := Sx_KeyCount()) == 0
         Sx_ClrScope( S_TOP )
         Sx_ClrScope( S_BOTTOM )
			Nada()
			Loop
		EndIF

	Case nChoice = 2
		cBanco := Space(10)
		dIni	 := Date()-30
		dFim	 := Date()
		MaBox( 14, 10, 18, 78 )
		@ 15, 11 Say "Banco.........:" Get cBanco Pict "@!"
		@ 16, 11 Say "Vcto Inicial..:" Get dIni   Pict "##/##/##"
		@ 17, 11 Say "Vcto Final....:" Get dFim   Pict "##/##/##" Valid IF( dFim < dIni, ( ErrorBeep(), Alerta("Erro: Data final maior que inicial."), FALSO ), OK )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Area("ChePre")
		Chepre->(Order( CHEPRE_BANCO_VCTO ))
		Sx_SetScope( S_TOP, cBanco + DateToStr( dini ))
		Sx_SetScope( S_BOTTOM, cBanco + DateToStr( dFim ))
		Mensagem('Aguarde, Filtrando.')
		Chepre->(DbGotop())
		IF (nItens := Sx_KeyCount()) == 0
         Sx_ClrScope( S_TOP )
         Sx_ClrScope( S_BOTTOM )
			Nada()
			Loop
		EndIF

	Case nChoice = 3
		cPraca := Space(20)
		dIni	 := Date()-30
		dFim	 := Date()
		MaBox( 14, 10, 18, 78 )
		@ 15, 11 Say "Praca.........:" Get cPraca Pict "@!"
		@ 16, 11 Say "Vcto Inicial..:" Get dIni   Pict "##/##/##"
		@ 17, 11 Say "Vcto Final....:" Get dFim   Pict "##/##/##" Valid IF( dFim < dIni, ( ErrorBeep(), Alerta("Erro: Data final maior que inicial."), FALSO ), OK )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Area("ChePre")
		Chepre->(Order( CHEPRE_PRACA_VCTO ))
		Sx_SetScope( S_TOP, cPraca + DateToStr( dini ))
		Sx_SetScope( S_BOTTOM, cPraca + DateToStr( dFim ))
		Mensagem('Aguarde, Filtrando.')
		Chepre->(DbGotop())
		IF (nItens := Sx_KeyCount()) == 0
         Sx_ClrScope( S_TOP )
         Sx_ClrScope( S_BOTTOM )
			Nada()
			Loop
		EndIF

	Case nChoice = 4
		dIni	 := Date()-30
		dFim	 := Date()
		MaBox( 14, 10, 17, 78 )
		@ 15, 11 Say "Vcto Inicial..:" Get dIni   Pict "##/##/##"
		@ 16, 11 Say "Vcto Final....:" Get dFim   Pict "##/##/##" Valid IF( dFim < dIni, ( ErrorBeep(), Alerta("Erro: Data final maior que inicial."), FALSO ), OK )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Area("ChePre")
		Chepre->(Order( CHEPRE_VCTO ))
		Sx_SetScope( S_TOP, DateToStr( dini ))
		Sx_SetScope( S_BOTTOM, DateToStr( dFim ))
		Mensagem('Aguarde, Filtrando.')
		Chepre->(DbGotop())
		IF (nItens := Sx_KeyCount()) == 0
         Sx_ClrScope( S_TOP )
         Sx_ClrScope( S_BOTTOM )
			Nada()
			Loop
		EndIF

	EndCase
	Pre_Main( dIni, dFim, cPraca )
	Sx_ClrScope( S_TOP )
	Sx_ClrScope( S_BOTTOM )
	ResTela( cScreen )
EndDo
Return

Proc Pre_Main( dIni, dFim, cCodi )
**********************************
LOCAL cScreen	  := SaveScreen()
LOCAL nTotal	  := 0
LOCAL Pagina	  := 0
LOCAL Col		  := 58
LOCAL Tam		  := 132
LOCAL nDocumento := 0
LOCAL cTitulo
LOCAL cCabec
PRIVA cIni		  := Dtoc( dIni )
PRIVA cFim		  := Dtoc( dFim )

IF !InsTruim() .OR. !LptOk()
	ResTela( cScreen )
	Return
EndIF
cTitulo	:= "RELATORIO DE CHEQUES PRE-DATADOS NO PERIODO DE &cIni. A &cFim."
cCabec	:= "CONTA EMISSAO VENCTO   DOCT N§   HISTORICO DO LANCAMENTO                     VALOR DO CHEQUE    BANCO      PRACA"
Mensagem("Aguarde, Imprimindo Pre-Datados.", Cor())
PrintOn()
FPrint( PQ )
SetPrc(0,0)
WHILE !Eof() .AND. Rel_Ok()
	 IF Col >= 57
		  Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
		  Write( 01, 00, Date())
		  Write( 02, 00, Padc( XNOMEFIR, Tam ))
		  Write( 03, 00, Padc( SISTEM_NA5, Tam ))
		  Write( 04, 00, Padc( cTitulo, Tam ))
		  Write( 05, 00, Repl( SEP, Tam ))
		  Write( 06, 00, cCabec )
		  Write( 07, 00, Repl( SEP, Tam ))
		  Col := 8
	 EndIF
	 Qout( Codi, Data, Vcto, Docnr, Hist, Tran( Valor, "@E 999,999,999,999.99"), Space(2),Banco, Praca )
	 nTotal	  += Valor
	 Col		  ++
	 nDocumento++
	 DbSkip()
	 IF Col >= 57
		 __Eject()
	 EndIF
EndDo
Write( Prow()+2, 000, "*** Total ***" )
Write( Prow(),   020, StrZero( nDocumento, 6 ))
Write( Prow(),   070, Tran( nTotal, "@E 999,999,999,999,999.99"))
__Eject()
PrintOff()
Return

Proc ExtratoVideo()
*******************
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL cScreen	 := SaveScreen()
LOCAL nDebitos  := 0
LOCAL nCreditos := 0
LOCAL nSaldo	 := 0
LOCAL nChoice	 := 0
LOCAL oBrowse
LOCAL dData_Ini
LOCAL dData_Fim
LOCAL cCodi
LOCAL cTela
LOCAL aStru

Chemov->(DbGoTop())
IF Chemov->(Eof())
	Nada()
	ResTela( cScreen )
	Return
EndIF
WHILE OK
	Sx_ClrScope( S_TOP )
	Sx_ClrScope( S_BOTTOM )
	Chemov->(Order( CHEMOV_CODI_DATA ))
	Chemov->(DbGoTop())
	cCodi 	 := Space(4)
	nDebitos  := 0
	nCreditos := 0
	nSaldo	 := 0
	dData_Ini := Chemov->Data
	dData_Fim := Date()
	MaBox( 05, 05, 09, 53 )
	@ 06, 06 Say  "Codigo..........:" Get cCodi     Pict "9999"     Valid CheErrado( @cCodi )
	@ 07, 06 Say  "Data Inicial....:" Get dData_Ini Pict "##/##/##"
	@ 08, 06 Say  "Data Final......:" Get dData_Fim Pict "##/##/##" Valid dData_Fim >= dData_Ini
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIF
	Area("Chemov")
	Chemov->(Order( CHEMOV_CODI_DATA ))
	Sx_ClrScope( S_TOP )
	Sx_ClrScope( S_BOTTOM )
	Sx_SetScope( S_TOP,	  cCodi + DateToStr( dData_Ini))
	Sx_SetScope( S_BOTTOM, cCodi + DateToStr( dData_Fim))
	Mensagem("Aguarde. Filtrado Registros.")
	Chemov->(DbGoTop())
	oBrowse := TMsBrowseNew()
	oBrowse:Add( "DATA LCTO", "Data",   "##/##/##")
	oBrowse:Add( "HISTORICO", "Hist",   "@!")
	oBrowse:Add( "DOCTO N§",  "Docnr",  "@!")
	oBrowse:Add( "DEBITO",    "Deb",    "@E 99,999,999,999.99")
	oBrowse:Add( "CREDITO",   "Cre",    "@E 99,999,999,999.99")
	oBrowse:Add( "SALDO",     "Saldo",  "@ECX 99,999,999,999.99")
	oBrowse:Titulo   := "EXTRATO VIDEO - CONTA :" + Cheque->Codi + ' - ' +  AllTrim( Cheque->Titular )
	oBrowse:PreDoGet := {|| PreExtrato( oBrowse ) } // Rotina do Usuario Antes de Atualizar
	oBrowse:PosDoGet := {|| PosExtrato( oBrowse ) } // Rotina do Usuario apos Atualizar
	oBrowse:PreDoDel := {|| PreDelExtrato( oBrowse ) }
	oBrowse:PosDoDel := {|| PosDelExtrato( oBrowse ) }
   oBrowse:HotKey( F4, {|| DuplicaLanc( oBrowse ) })
	oBrowse:Show()
	oBrowse:Processa()
	ResTela( cScreen )
	Sx_ClrScope( S_TOP )
	Sx_ClrScope( S_BOTTOM )
	IF oBrowse:Alterado <> NIL
		ErrorBeep()
		IF Conf("Pergunta: Atualizar Saldos Agora ?")
			IndexarData( cCodi )
		EndIF
	EndIF
Enddo

Function DuplicaLanc( oBrowse )
*******************************
LOCAL cScreen := SaveScreen()
LOCAL oCol    := oBrowse:getColumn( oBrowse:colPos )
LOCAL nMarVar := 0
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL xTemp   := FTempName()
LOCAL aStru   := Chemov->(DbStruct())
LOCAL nConta  := Chemov->(FCount())
LOCAL xRegistro

xRegistro := Chemov->(Recno())
DbCreate( xTemp, aStru )
Use (xTemp) Exclusive Alias xAlias New
xAlias->(DbAppend())
For nField := 1 To nConta
   xAlias->(FieldPut( nField, Chemov->(FieldGet( nField ))))
Next
IF Chemov->(Incluiu())
   For nField := 1 To nConta
      Chemov->(FieldPut( nField, xAlias->(FieldGet( nField ))))
   Next
   Chemov->(Libera())
EndIF
xAlias->(DbCloseArea())
Ferase(xTemp)
AreaAnt( Arq_Ant, Ind_Ant )
Ventila( cScreen, oBrowse )
Chemov->(DbGoto( xRegistro ))
Return( OK )

Function PreExtrato( oBrowse )
******************************
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )
LOCAL nMarVar := 0
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL xStr	  := Chr(0)
LOCAL xRegistro

IF !PodeAlterar()
	Return( FALSO)
EndIF
xRegistro		  := Chemov->(Recno())
oBrowse:Registro := xRegistro
Do Case
Case oCol:Heading = "SALDO"
	ErrorBeep()
	Alerta("Erro: Campo nao alteravel.")
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndCase
Return( PodeAlterar())

Function PosExtrato( oBrowse )
******************************
LOCAL oCol		 := oBrowse:getColumn( oBrowse:colPos )
LOCAL cCodi 	 := Space(04)
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL xRegistro
LOCAL nField

xRegistro		  := Chemov->(Recno())
oBrowse:Registro := xRegistro
IF oCol:Heading = "CODI"
	cCodi := Chemov->Codi
	IF Cheque->(!DbSeek( cCodi ))
		CheErrado( @cCodi )
	EndIF
	Chemov->Codi := cCodi
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Proc PreDelExtrato( oBrowse )
*****************************
oBrowse:Registro := Chemov->(Recno())
IF !PodeExcluir()
	Return( FALSO )
EndIF
Return( OK )

Proc PosDelExtrato( oBrowse )
*****************************
Chemov->(DbGoto( oBrowse:Registro ))
IF Chemov->(TravaReg())
	oBrowse:Deletado := NIL
	Chemov->(DbDelete())
	Chemov->(Libera())
EndIF
Return( OK )

/*
Proc ExtratoVideo()
*******************
LOCAL cArquivo  := FTempname()
LOCAL xNtx1 	 := FTempname()
LOCAL xNtx2 	 := FTempname()
LOCAL xNtx3 	 := FTempname()
LOCAL xNtx4 	 := FTempname()
LOCAL xNtx5 	 := FTempname()
LOCAL xNtx6 	 := FTempname()
LOCAL xSub		 := FTempname()
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL cScreen	 := SaveScreen()
LOCAL nDebitos  := 0
LOCAL nCreditos := 0
LOCAL nSaldo	 := 0
LOCAL nChoice	 := 0
LOCAL oBrowse
LOCAL dData_Ini
LOCAL dData_Fim
LOCAL cCodi
LOCAL cTela
LOCAL aStru

Chemov->(DbGoTop())
IF Chemov->(Eof())
	Nada()
	ResTela( cScreen )
	Return
EndIF
WHILE OK
	Chemov->(Order( CHEMOV_CODI_DATA ))
	Chemov->(DbGoTop())
	Area("Cheque")
	Cheque->(Order( CHEQUE_CODI ))
	cCodi 	 := Space(4)
	nDebitos  := 0
	nCreditos := 0
   nSaldo    := 0
	dData_Ini := Chemov->Data
	dData_Fim := Date()
	MaBox( 05, 05, 09, 53 )
	@ 06, 06 Say  "Codigo..........:" Get cCodi     Pict "9999"     Valid CheErrado( @cCodi )
	@ 07, 06 Say  "Data Inicial....:" Get dData_Ini Pict "##/##/##"
	@ 08, 06 Say  "Data Final......:" Get dData_Fim Pict "##/##/##" Valid dData_Fim >= dData_Ini
	Read
	IF LastKey() = ESC
		Ferase( cArquivo )
		Ferase( xNtx1 )
		Ferase( xNtx2 )
		Ferase( xNtx3 )
		Ferase( xNtx4 )
		Ferase( xNtx5 )
		Ferase( xNtx6 )
		ResTela( cScreen )
		Exit
	EndIF
	Reg_Ant := Recno()
	nChoice := 1
	M_Title("ESCOLHA O TIPO DE LANCAMENTO")
	nChoice := FazMenu( 12, 05, {" Geral ", " Creditos "," Debitos "})
	IF nChoice = 0
		ResTela( cScreen )
		Loop
	EndIF
	oMenu:Limpa()
	MaBox( 21, 00, 24, 79 )
	Cheque->(DbGoTo( Reg_Ant ))
	Write( 22, 01, "Debitos.: " + Tran( nDebitos, "@E 99,999,999,999.99"))
	Write( 22, 29, "Creditos.: " + Tran( nCreditos, "@E 99,999,999,999.99"))
   Write( 23, 01, "Saldo...: " + Tran( nSaldo, "@ECX 99,999,999,999.99"))
	Area("Chemov")
	Order( CHEMOV_CODI_DATA )
	IF !LoopData( cCodi, dData_Ini, dData_Fim )
		Loop
	EndIF
	aStru := Chemov->(DbStruct())
	Aadd( aStru, {"REGISTRO",  "N", 7, 0})
	DbCreate( cArquivo, aStru )
	Use (cArquivo) Exclusive Alias xAlias New
	oBloco := {|| Chemov->Codi = cCodi }
		  cTela	:= Mensagem("Please, Aguarde... Anexando Registro n§ 0000000. ESC Cancela.", Cor())
	nConta := 0
	WHILE Eval( oBloco ) .AND. Rep_Ok()
		IF Chemov->Data > dData_Fim
			Exit
		EndIF
		IF nChoice = 1
			IF Chemov->Codi = cCodi .AND. Chemov->Data >= dData_Ini .AND. Chemov->Data <= dData_Fim
			  nRecno := Chemov->(Recno())
			Else
				Chemov->(DbSkip(1))
				Loop
			EndIF
		ElseIF nChoice = 2
			IF Chemov->Codi = cCodi .AND. Chemov->Data >= dData_Ini .AND. Chemov->Data <= dData_Fim .AND. Chemov->Cre > 0
			  nRecno := Chemov->(Recno())
			Else
				Chemov->(DbSkip(1))
				Loop
			EndIF
		Else
			IF Chemov->Codi = cCodi .AND. Chemov->Data >= dData_Ini .AND. Chemov->Data <= dData_Fim .AND. Chemov->Deb > 0
			  nRecno := Chemov->(Recno())
			Else
				Chemov->(DbSkip(1))
				Loop
			EndIF
		EndIF
		nDebitos  += Chemov->Deb
		nCreditos += Chemov->Cre
      nSaldo    := ( nCreditos - nDebitos )
		nConta++
      Write( 12, 50, StrZero( nConta, 7))
		Write( 22, 01, "Debitos.: " + Tran( nDebitos, "@E 99,999,999,999.99"))
		Write( 22, 29, "Creditos.: " + Tran( nCreditos, "@E 99,999,999,999.99"))
      Write( 23, 01, "Saldo...: " + Tran( nSaldo, "@ECX 99,999,999,999.99"))
      xAlias->(DbAppend())
		For nField := 1 To FCount()
			xAlias->(FieldPut( nField, Chemov->(FieldGet( nField ))))
			xAlias->Registro := Chemov->(Recno())
		Next
					 Chemov->(DbSkip(1))
	EnDdo
	Area("xALias")
	Mensagem("Aguarde, Organizando Tabela.")
	Inde on Codi  To (xNtx1)
	Inde on Docnr To (xNtx2)
	Inde on Codi + DateToStr( Data ) To (xNtx4)
	Inde on Fatura To (xNtx5)
	Inde on Hist To (xNtx6)
	Inde on Data  To (xNtx3)
	xAlias->(DbCloseArea())
	Use (cArquivo) Exclusive Alias xAlias New
	xAlias->(DbSetIndex( xNtx3 ))
	xAlias->(DbSetIndex( xNtx2 ))
	xAlias->(DbSetIndex( xNtx1 ))
	xAlias->(DbSetIndex( xNtx4 ))
	xAlias->(DbSetIndex( xNtx5 ))
	xAlias->(DbSetIndex( xNtx6 ))
	xAlias->(DbGoTop())
	oBrowse := TMsBrowseNew(01,01, 15, MaxCol()-1)
	oBrowse:Add( "DATA LCTO", "Data",   "##/##/##")
	oBrowse:Add( "HISTORICO", "Hist",   "@!")
	oBrowse:Add( "DOCTO N§",  "Docnr",  "@!")
	oBrowse:Add( "DEBITO",    "Deb",    "@E 99,999,999,999.99")
	oBrowse:Add( "CREDITO",   "Cre",    "@E 99,999,999,999.99")
	oBrowse:Add( "SALDO",     "Saldo",  "@ECX 99,999,999,999.99")
	oBrowse:Titulo := "EXTRATO VIDEO - CONTA :" + Cheque->Codi + ' - ' +  AllTrim( Cheque->Titular )
	oBrowse:PreDoGet := {|| PreExtrato( oBrowse ) } // Rotina do Usuario Antes de Atualizar
	oBrowse:PosDoGet := {|| PosExtrato( oBrowse ) } // Rotina do Usuario apos Atualizar
	oBrowse:PreDoDel := {|| PreDelExtrato( oBrowse ) }
	oBrowse:PosDoDel := {|| PosDelExtrato( oBrowse ) }
	oBrowse:Show()
	oBrowse:Processa()
	xAlias->(DbCloseArea())
	Ferase( cArquivo )
	Ferase( xNtx1 )
	Ferase( xNtx2 )
	Ferase( xNtx3 )
	Ferase( xNtx4 )
	Ferase( xNtx5 )
	Ferase( xNtx6 )
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	IF oBrowse:Alterado <> NIL
		ErrorBeep()
		IF Conf("Pergunta: Atualizar Saldos Agora ?")
			IndexarData( cCodi )
		EndIF
	EndIF
Enddo


Function PreExtrato( oBrowse )
******************************
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )
LOCAL nMarVar := 0
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL xStr	  := Chr(0)
LOCAL xRegistro

IF !PodeAlterar()
	Return( FALSO)
EndIF
xRegistro		  := xAlias->Registro
oBrowse:Registro := xRegistro
Do Case
Case oCol:Heading = "SALDO"
	ErrorBeep()
	Alerta("Erro: Campo nao alteravel.")
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndCase
Return( PodeAlterar())

Function PosExtrato( oBrowse )
******************************
LOCAL oCol		 := oBrowse:getColumn( oBrowse:colPos )
LOCAL nLen		 := xAlias->(FCount())
LOCAL cCodi 	 := Space(04)
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL xRegistro
LOCAL nField

xRegistro		  := xAlias->Registro
oBrowse:Registro := xRegistro
IF oCol:Heading = "CODI"
	cCodi := xAlias->Codi
	IF Cheque->(!DbSeek( cCodi ))
		CheErrado( @cCodi )
	EndIF
	xAlias->Codi := cCodi
EndIF
IF xAlias->(Updated())
	Chemov->(DbGoto( xRegistro ))
	IF Chemov->(TravaReg())
		For nField := 1 To nLen
			Chemov->( FieldPut( nField, xAlias->(FieldGet( nField ))))
		Next
		Chemov->(Libera())
		oBrowse:Alterado	 := OK
	EndIF
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Proc PreDelExtrato( oBrowse )
*****************************
oBrowse:Registro := xAlias->Registro
IF !PodeExcluir()
	Return( FALSO )
EndIF
Return( OK )

Proc PosDelExtrato( oBrowse )
*****************************
Chemov->(DbGoto( oBrowse:Registro ))
IF Chemov->(TravaReg())
	oBrowse:Deletado := NIL
	Chemov->(DbDelete())
	Chemov->(Libera())
EndIF
Return( OK )
*/

Proc IndexarData( xCodi )
*************************
LOCAL cScreen	  := SaveScreen()
LOCAL cCodi 	  := Space(4)
LOCAL nSldAtual  := 0
LOCAL nCredito   := 0
LOCAL nDebito	  := 0
LOCAL dData 	  := Date()
LOCAL lCancelado := FALSO
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()
LOCAL lJahVeio   := FALSO
LOCAL aMenuArray := {'Geral Ordem Baixa','Geral Ordem Data', 'Individual Ordem Baixa', 'Individual Ordem Data'}
LOCAL nTipoCaixa := oIni:ReadInteger('relatorios','tipocaixa', 2 )
LOCAL aCodi 	  := {}
LOCAL cTela
LOCAL nChoice
LOCAL nTam
LOCAL nX

IF xCodi = Nil
   M_Title('ATUALIZAR SALDOS')
   nChoice := FazMenu( 09, 10, aMenuArray, Cor())
	IF nChoice = ZERO
		ResTela( cScreen )
		Return
	EndIF
	Do Case
   Case nChoice = 1 .OR. nChoice = 2
		Cheque->(Order( CHEQUE_CODI ))
		xCodi = cCodi
		Cheque->(DbGoTop())
		While Cheque->(!Eof())
			Aadd( aCodi, Cheque->Codi )
			Cheque->(DbSkip(1))
		EndDo
		MaBox( 17, 10, 19, 39 )
		@ 18, 11 Say "A Partir Do Dia... " Get dData Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Return
		EndIF

   Case nChoice = 3 .OR. nChoice = 4
      xCodi = Space(4)
		MaBox( 17, 10, 20, 39 )
		@ 18, 11 Say "Codigo Conta.....: " Get xCodi Pict "9999" Valid Cheerrado( @xCodi)
		@ 19, 11 Say "A Partir Do Dia .: " Get dData Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Return
		EndIF
		Aadd( aCodi, xCodi )
	EndCase
Else
	lJahVeio := OK
	Aadd( aCodi, xCodi )
EndIF
oMenu:Limpa()
Area("Chemov")
Chemov->(Order( IF( nChoice = 1 .OR. nChoice = 3, CHEMOV_CODI_BAIXA, CHEMOV_CODI_DATA )))
Chemov->(DbGoTop())
nTam	 := Len( aCodi )
Mensagem("Informe: Aguarde, atualizando. ESC cancela!", Cor())
MaBox( 18, 01, 22, 19, "CONTA/DATA")
For nX := UM To nTam
	xCodi := aCodi[ nX ]
	yCodi := xCodi
	IF Chemov->(!TravaArq())
		lCancelado := OK
		ErrorBeep()
		Alerta("Erro: Saldo Nao Atualizado...")
		Exit
	EndIF
	nSldAtual := 0
	nCredito  := 0
	nDebito	 := 0
	MaBox( 18, 20, 22, 60, "SALDO ATUAIS ")
	Write( 19, 21, "Credito ¯¯ " + Tran( nCredito,  "@E 999,999,999,999.99"))
	Write( 20, 21, "Debito  ¯¯ " + Tran( nDebito ,  "@E 999,999,999,999.99"))
	Write( 21, 21, "Saldo   ¯¯ " + Tran( nSldAtual, "@E 999,999,999,999.99"))
	Write( 19, 02, "Conta : " + yCodi )
	Write( 20, 02, "Data  : " + Dtoc( Data ))
	IF DbSeek( xCodi )
		xData := Chemov->Data
		IF !lJahVeio
			WHILE !Eof()
				IF Chemov->Data < dData
					nSldAtual := Chemov->Saldo
					Chemov->(DbSkip(1))
					Loop
				EndIF
				IF Chemov->Data = xData
					nSldAtual := 0
				EndiF
				Exit
			EndDo
		EndIF
		WHILE Chemov->Codi == xCodi .AND. !Eof() .AND. Cancela(@lCancelado )
			 Write( 19, 02, "Conta : " + yCodi )
			 Write( 20, 02, "Data  : " + Dtoc( Data ))
			 nCredito  += Cre
			 nDebito   += Deb
			 nSldAtual += Cre
			 nSldAtual -= Deb
			 Chemov->Saldo := nSldAtual
			 Write( 19, 33, Tran( nCredito,	"@E 999,999,999,999.99"))
			 Write( 20, 33, Tran( nDebito ,	"@E 999,999,999,999.99"))
			 Write( 21, 33, Tran( nSldAtual, "@E 999,999,999,999.99"))
			 DbSkip(1)
		EndDo
		IF !lCancelado
			Cheque->(Order( CHEQUE_CODI ))
			IF Cheque->(DbSeek( xCodi ))
				IF Cheque->(TravaReg())
					Cheque->Saldo	  := nSldAtual
					Cheque->Debitos  := nDebito
					Cheque->Creditos := nCredito
					Cheque->(Libera())
				Else
					lCancelado := OK
					ErrorBeep()
					Alerta("Erro: Saldo Nao Atualizado...")
				EndIF
			EndIF
		Else
			Chemov->(Libera())
			AreaAnt( Arq_Ant, Ind_Ant )
			Alerta("Atualizacao Cancelada... ")
			ResTela( cScreen )
			Return
		EndIF
	Else
		Cheque->(Order( CHEQUE_CODI ))
		IF Cheque->(DbSeek( xCodi ))
			IF Cheque->(TravaReg())
				Cheque->Saldo	  := 0
				Cheque->Debitos  := 0
				Cheque->Creditos := 0
				Cheque->(Libera())
			Else
				nX--
			EndIF
		EndIF
	EndIF
	nSldAtual := 0
Next
Chemov->(Libera())
IF !lCancelado
	IF !lJahVeio
		Alerta(" Atualizacao Completada... ")
	EndIF
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )
Return

Function oMenuChelan()
**********************
LOCAL AtPrompt := {}
LOCAL cStr_Get
LOCAL cStr_Sombra

IF !aPermissao[SCI_CONTAS_CORRENTES]
   Return( AtPrompt )
EndIF

IF oAmbiente:Get_Ativo
	cStr_Get := "Desativar Get Tela Cheia"
Else
	cStr_Get := "Ativar Get Tela Cheia"
EndIF
IF oMenu:Sombra
	cStr_Sombra := "DesLigar Sombra"
Else
	cStr_Sombra := "Ligar Sombra"
EndIF
AADD( AtPrompt, {"Sair",    {"Encerrar Sessao"}})
#IFDEF MICROBRAS
	AADD( AtPrompt, {"Inclusao",   {"Contas","Conta Historico","Sub Conta Historico","Cursos","Alunos"}})
   AADD( AtPrompt, {"Alteracao",  {"Contas","Conta Historico","Sub Conta Historico","Lancamentos","Movimento","Cursos","Alunos"}})
	AADD( AtPrompt, {"Exclusao",   {"Contas","Conta Historico","Sub Conta Historico","Lancamentos","Cursos","Alunos"}})
	AADD( AtPrompt, {"Diario",     {"Lancamentos","Atualizar Saldos","Renovacao de Contrato","Recebimentos","Contrato","Cancelamento de Contrato"}})
	AADD( AtPrompt, {"Relatorios", {"Extrato Movimento","Rol de Contas","Rol de Contas/Saldos","Cheques Pre-Datados","Resumo Contas/Saldos","Resumo Contas/Saldo Por Periodo","Ficha Inscricao e Contrato","Emissao de Recibo","Frequencia","Debitos Alunos","Promissorias","Contrato Vencido","Contrato","Listagem de Chamada"}})
	Aadd( AtPrompt, {"Consulta",   {"Contas Por Titular","Contas Por Codigo","Todas as Contas","Saldo Contas","Extrato Video","Extrato Impressora","Conta Historico","Sub Conta Historico","Cursos"}})
#ELSE
	AADD( AtPrompt, {"Inclusao",   {"Contas","Conta Historico","Sub Conta Historico"}})
   AADD( AtPrompt, {"Alteracao",  {"Contas","Conta Historico","Sub Conta Historico","Lancamentos","Movimento"}})
	AADD( AtPrompt, {"Exclusao",   {"Contas","Conta Historico","Sub Conta Historico","Lancamentos"}})
	AADD( AtPrompt, {"Diario",     {"Lancamentos","Atualizar Saldos"}})
	AADD( AtPrompt, {"Relatorios", {"Extrato Movimento","Rol de Contas","Rol de Contas/Saldos","Cheques Pre-Datados","Resumo Contas/Saldos","Resumo Contas/Saldo Por Periodo"}})
	Aadd( AtPrompt, {"Consulta",   {"Contas Por Titular","Contas Por Codigo","Todas as Contas","Saldo Contas","Extrato Video","Extrato Impressora","Conta Historico","Sub Conta Historico"}})
#EndIF
Aadd( AtPrompt, {"Pre-Datados", {"Inclusao","Exclusao","Alteracao","Consultas","Impressao","Baixas"}})
Return( AtPrompt )

*:==================================================================================================================================

Function aDispChelan()
**********************
LOCAL oChelan	:= TIniNew( oAmbiente:xUsuario + ".INI")
LOCAL AtPrompt := oMenuChelan()
LOCAL nMenuH   := Len(AtPrompt)
LOCAL aDisp 	:= Array( nMenuH, 22 )
LOCAL aMenuV   := {}

IF !aPermissao[SCI_CONTAS_CORRENTES]
   Return( aDisp )
EndIF

Mensagem("Aguarde, Verificando Diretivas do CONTAS CORRENTES.")
Return( aDisp := ReadIni("chelan", nMenuH, aMenuV, AtPrompt, aDisp, oChelan))

*:==================================================================================================================================

Proc AltMovimento()
*******************
LOCAL cScreen  := SaveScreen()
LOCAL cCodiOld := Space(04)
LOCAL cCodiNew := Space(04)

WHILE OK
   oMenu:Limpa()
   cCodiOld := Space(04)
   cCodiNew := Space(04)
   MaBox( 10, 10, 13, 78 )
   @ 11, 11 Say  "Conta Velha.:" Get cCodiOld Pict "9999" Valid CheErrado( @cCodiOld,,Row(), Col()+1 )
   @ 12, 11 Say  "Conta Nova..:" Get cCodiNew Pict "9999" Valid CheErrado( @cCodiNew,,Row(), Col()+1 )
   Read
   IF LastKey() = ESC
      ResTela( cScreen )
      Return
   EndIF
   ErrorBeep()
   IF Conf('Pergunta: Confirma alteracao da conta ?')
      Mensagem('Aguarde, Alterando Conta do Movimento.')
      Chemov->(Order( CHEMOV_CODI ))
      While Chemov->(DbSeek( cCodiOld )) .AND. Rep_Ok()
         IF Chemov->(TravaReg())
            Chemov->Codi := cCodiNew
            Chemov->(Libera())
         EndIF
      EndDo
   EndIF
EndDo
