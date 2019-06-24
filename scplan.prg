/*
  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 İ³																								 ³
 İ³	Programa.....: SCPLAN.PRG															 ³
 İ³	Aplicacaoo...: SISTEMA DE CONTROLE DE PRODUCAO								 ³
 İ³	Versao.......: 3.3.00																 ³
 İ³	Programador..: Vilmar Catafesta													 ³
 İ³   Empresa......: Microbras Com de Prod de Informatica Ltda              ³
 İ³	Inicio.......: 12 de Novembro de 1991. 										 ³
 İ³   Ult.Atual....: 20 de Janeiro de 2001.                                 ³
 İ³   Compilacao...: Clipper 5.2e                                           ³
 İ³   Linker.......: Blinker 5.0                                            ³
 İ³	Bibliotecas..: Clipper/Funcoes/Mouse/Funcky15/Funcky50/Classe/Classic ³
 İÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include <sci.ch>

*:----------------------------------------------------------------------------

Proc ScpLan()
*************
LOCAL lOk         := OK
LOCAL Op 	      := 1
PUBLI cVendedor   := Space(40)
PUBLI cCaixa		:= Space(04)

*:==================================================================================================================================
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
SetKey( F1, 		  {|| Calc()})
SetKey( F8, 		  {|| AcionaSpooler()})
SetKey( TECLA_ALTC, {|| Altc() })

oMenu:Limpa()
*:==================================================================================================================================
Op := 1
RefreshClasse()
//SetaClasse()
WHILE lOk
	BEGIN Sequence
		Op := oMenu:Show()
		Do Case
		Case Op = 0.0 .OR. Op = 1.01
			ErrorBeep()
			IF Conf("Pergunta: Encerrar este modulo ?")
				GravaDisco()
				lOk := FALSO
				Break
			EndIF
		Case Op = 2.01
			FuncInclusao()
		Case Op = 2.02
			BrowseFuncionario()
		Case Op = 2.03
			BrowseFuncionario()
		Case Op = 2.04
			BrowseFuncionario()
		Case Op = 2.05
			RolFuncionario()
		Case Op = 3.01
			GrpSerInc()
		Case Op = 3.02
			GrpSerAlt()
		Case Op = 3.03
			GrpSerAlt()
		Case Op = 3.04
			GrpSerAlt()
		Case Op = 3.05
			GrpSerPri()
		Case Op = 4.01
			IncServico()
		Case Op = 4.02
			BrowseServico()
		Case Op = 4.03
			BrowseServico()
		Case Op = 4.04
			BrowseServico()
		Case Op = 4.05
			ProduRel2()
		Case Op = 5.01
			Produ31()
		Case Op = 5.02
			Produ32("ALTERACAO DA PRODUCAO")
		Case Op = 5.03
			Produ32("EXCLUSAO DA PRODUCAO")
		Case Op = 5.04
			ProduConsulta()
		Case Op = 5.05
			PrintProducao()
		Case Op = 6.01
			Produ51()
		Case Op = 6.02
			Produ52("ALTERACAO DE MOVIMENTO")
		Case Op = 6.03
			Produ52("EXCLUSAO DE MOVIMENTO")
		Case Op = 6.04
			MoviConsulta()
		Case Op = 6.05
			ProduRel4()
		Case Op = 7.01
			RolFuncionario()
		Case Op = 7.02
			ProduRel2()
		Case Op = 7.03
			PrintProducao()
		Case Op = 7.04
			ProduRel4()
		Case Op = 7.05
			Adiantamentos()
		Case Op = 7.06
			TotalMovi()
		Case Op = 7.07
			SaldoFunc()
		Case Op = 7.08
			Recibofuncionario()
		Case Op = 7.09
			GrpSerPri()
		Case Op = 8.01
			BrowseFuncionario()
		Case Op = 8.02
			BrowseServico()
		Case Op = 8.03
			MoviConsulta()
		Case Op = 8.04
			ProduConsulta()
		Case Op = 8.05
			ScpSaldo()
		Case Op = 8.06
			AdianConsu()
		Case Op = 8.07
			GrpSerAlt()
		Case Op = 9.01
			AdianAdian()
		Case Op = 9.02
			FechaMes()
		Case Op = 9.03
			FechaDebito()
		Case Op = 9.04
			AjusTabInd()
		Case Op = 9.05
			AjusTabGer()
		EndCase
	End Sequence
EndDo
Mensagem("Aguarde... Fechando Arquivos.", WARNING, _LIN_MSG )
FechaTudo()
Return

STATIC Proc RefreshClasse()
***************************
oMenu:StatusSup		:= oMenu:StSupArray[7]
oMenu:StatusInf		:= oMenu:StInfArray[7]
oMenu:Menu				:= oMenu:MenuArray[7]
oMenu:Disp				:= oMenu:DispArray[7]
Return

STATIC Proc SetaClasse()
************************
oMenu:Menu		 := oMenuScpLan()
oMenu:Disp		 := aDispScpLan()
oMenu:StatusSup := SISTEM_NA7 + " " + SISTEM_VERSAO
oMenu:StatusInf := "F1-HELPºF10-CALCºF8-SPOOLºESC-RETORNAº"
Return

Proc ProduRel2()
****************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL nChoice	:= 1
LOCAL aMenu 	:= {"Individual", "Geral"}
LOCAL cCodi
LOCAL oBloco
FIELD CodiSer

WHILE OK
	oMenu:Limpa()
	M_Title("RELATORIO DE SERVICOS" )
	nChoice := FazMenu( 07, 16, aMenu )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1
		Area("Servico")
		Servico->(Order( SERVICO_CODISER ))
		MaBox( 15, 10, 17, 26 )
      cCodi := Space( 03 )
      @ 16, 11 Say "Codigo..:" Get cCodi Pict "999" Valid SerErrado( @cCodi )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Exit
		EndIF
		Servico->(Order( SERVICO_CODISER ))
		oBloco := {|| Codiser = cCodi }
		IF Servico->(!DbSeek( cCodi ))
			Nada()
			Loop
		EndIF
		RelProdu2( oBloco )

	Case nChoice = 2
		Area("Servico")
		Servico->(Order( SERVICO_NOME ))
		Servico->(DbGoTop())
		oBloco := {|| !Eof() }
		RelProdu2( oBloco )

	EndCase
EndDo

Proc ProduRel4()
****************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL aMenu   := {"Individual", "Geral "}
LOCAL nChoice := 1
LOCAL oBloco1
LOCAL oBloco2
LOCAL cNome
LOCAL cCodi
LOCAL dIni
LOCAL dFim
FIELD Codiven
FIELD Data

WHILE OK
	oMenu:Limpa()
	M_Title("RELATORIO DE MOVIMENTO")
	nChoice := FazMenu( 07, 16, aMenu )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Return

	Case nChoice = 1
		cCodi := Space( 04 )
		dIni	:= Date() - 30
		dFim	:= Date()
		MaBox( 14, 16, 18, 43 )
		@ 15, 17 Say "Codigo.........:" Get cCodi Pict "9999" Valid FunciErrado( @cCodi )
		@ 16, 17 Say "Data Inicial...:" Get dIni  Pict "##/##/##"
		@ 17, 17 Say "Data Final.....:" Get dFim  Pict "##/##/##"
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		Vendedor->(Order( VENDEDOR_CODIVEN ))
		Servico->(Order( SERVICO_CODISER ))
		Area( "Movi")
		Set Rela To Movi->Codiven Into Vendedor, Movi->CodiSer Into Servico
      Movi->(Order( MOVI_CODIVEN_DATA ))
		oBloco1 := {|| Movi->Codiven = cCodi }
		oBloco2 := {|| Movi->Data >= dIni .AND. Movi->Data <= dFim }
		IF Movi->(!DbSeek( cCodi ))
			Nada()
			Loop
		EndIF
		RelaProdu1( dIni, dFim, oBloco1, oBloco2 )
		Movi->(DbClearRel())
		Movi->(DbGoTop())

	Case nChoice = 2
		dIni	:= Date() - 30
		dFim	:= Date()
		MaBox( 14, 16, 17, 43 )
		@ 15, 17 Say "Data Inicial...:" Get dIni  Pict "##/##/##"
		@ 16, 17 Say "Data Final.....:" Get dFim  Pict "##/##/##"
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		Vendedor->(Order( VENDEDOR_CODIVEN ))
		Servico->(Order( SERVICO_CODISER ))
		Area( "Movi")
		Set Rela To Movi->Codiven Into Vendedor, Movi->CodiSer Into Servico
      Movi->(Order( MOVI_CODIVEN_DATA ))
      oBloco1 := {|| Movi->(!Eof()) }
		oBloco2 := {|| Movi->Data >= dIni .AND. Movi->Data <= dFim }
		Movi->(DbGoTop())
		RelaProdu1( dIni, dFim, oBloco1, oBloco2 )
		Movi->(DbClearRel())
		Movi->(DbGoTop())

	EndCase
EndDo

Proc RelaProdu1( dIni, dFim, oBloco1, oBloco2 )
***********************************************
LOCAL cScreen	  := SaveScreen()
LOCAL nCop		  := 1
LOCAL Tam		  := 80
LOCAL Col		  := 58
LOCAL Pagina	  := 0
LOCAL i			  := 0
LOCAL nQtdPecas  := 0
LOCAL nTotalVlr  := 0
LOCAL nTotalPcs  := 0
LOCAL nDecisao   := 0
LOCAL nTotalTab  := 0
LOCAL NovoCodi   := OK
LOCAL UltCodi    := Movi->Codiven
LOCAL lSair 	  := FALSO
FIELD Codiven
FIELD CodiSer
FIELD Tabela
FIELD Data
FIELD Qtd
FIELD Valor

IF !Instru80()
	ResTela( cScreen )
	Return
EndIF
Mensagem("Aguarde, Imprimindo.")
PrintOn()
SetPrc( 0, 0 )
WHILE Eval( oBloco1 ) .AND. Rel_Ok()
   IF Col >= 58
      Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
      Write( 01, 00, Date() )
      Write( 02, 00, Padc( XNOMEFIR, Tam ) )
      Write( 03, 00, Padc( SISTEM_NA7, Tam ) )
      Write( 04, 00, Padc( 'RELATORIO DE MOVIMENTO REF. ' + Dtoc( dIni ) + ' A  ' + dToc( dFim ), Tam ))
      Write( 05, 00, Repl( SEP, Tam ) )
      Col := 6
   EndIF
   IF Eval( oBloco2 )
      IF Col = 6 .OR. NovoCodi
         Write(   Col, 00, NG + "FUNCIONARIO..: " + Movi->Codiven + " " + Vendedor->Nome + NR )
         Write( ++Col, 00, Repl( SEP, Tam ) )
         Write( ++Col, 00,"DATA     TAB  SER          QUANT           UNITARIO              TOTAL")
         Write( ++Col, 00, Repl( SEP, Tam ) )
         Col++
      EndIF
      IF NovoCodi
         NovoCodi := FALSO
      EndIf
      Qout( Dtoc( Data), Left( Tabela, 4 ), Right( Tabela, 3), Space(05), Qtd, ;
                  Servico->( TransForm( Valor, "@E 9,999,999,999.9999")), ;
                  Servico->( TransForm( Valor * Movi->Qtd, "@E 9,999,999,999.9999")))
      Col++
      nQtdPecas += Qtd
      nTotalpcs += Qtd
      nTotalVlr += Servico->Valor * Qtd
      nTotalTab += Servico->Valor * Qtd
   EndIF
   UltCodi := Movi->Codiven
	Movi->(DbSkip(1))
   IF UltCodi != Movi->Codiven .OR. Movi->(Eof())
      IF nTotalTab > 0
         NovoCodi  := OK
         nQtdPecas := 0
         nTotalVlr := 0
         Write( ++Col, 00,"** Total Funcionario ** " + Str( nTotalPcs, 7 ) + Space(22) + TransForm( nTotalTab, "@E 9,999,999,999.9999" ) )
         Write( ++Col, 00, Repl("-", Tam ))
         nTotalTab := 0
         nTotalpcs := 0
         Col += 2
      EndIF
	EndIF
   IF Col >= 56
      Col := 58
      __Eject()
   EndIF
EndDo
__Eject()
PrintOff()
ResTela( cScreen )
Return

Proc ProduConsulta()
********************
LOCAL GetList	  := {}
LOCAL aMenuArray := {" Por Tabela ", " Geral " }
LOCAL cScreen	  := SaveScreen()
LOCAL nChoice	  := 1
LOCAL cTabela
LOCAL nItens
FIELD Tabela

WHILE OK
	 oMenu:Limpa()
	 M_Title("CONSULTA PRODUCAO")
	 nChoice := FazMenu( 07, 16, aMenuArray )
	 Do Case
	 Case nChoice = 0
		 ResTela( cScreen )
		 Exit

	 Case nChoice = 1
		  cTabela := Space( 04 )
		  MaBox( 14, 16, 16, 38 )
		  @ 15, 17 Say "Tabela........:" Get cTabela Pict "9999"
		  Read
		  IF LastKey() = ESC
			  Loop
		  EndIF
		  Area("Cortes")
		  Cortes->(Order( CORTES_TABELA ))
		  Sx_ClrScope( S_TOP )
		  Sx_ClrScope( S_BOTTOM )
		  Sx_SetScope( S_TOP, cTabela )
		  Sx_SetScope( S_BOTTOM, cTabela )
		  Mensagem('Aguarde, Filtrando.')
		  Cortes->(DbGoTop())
		  IF Sx_KeyCount() == 0
           Sx_ClrScope( S_TOP )
           Sx_ClrScope( S_BOTTOM )
			  Nada()
			  Loop
		  EndIF
		  ProduBrowse()
		  Sx_ClrScope( S_TOP )
		  Sx_ClrScope( S_BOTTOM )

	 Case nChoice = 2
		 Area("Cortes")
		 Sx_ClrScope( S_TOP )
		 Sx_ClrScope( S_BOTTOM )
		 Cortes->(DbGoTop())
		 IF Cortes->(Eof())
           Sx_ClrScope( S_TOP )
           Sx_ClrScope( S_BOTTOM )
			  Nada()
			  Loop
		 EndIF
		 ProduBrowse()
		 Sx_ClrScope( S_TOP )
		 Sx_ClrScope( S_BOTTOM )
		 Cortes->(DbGoTop())
	 Endcase
EndDo

Proc ProduBrowse()
******************
LOCAL GetList    := {}
LOCAL cScreen    := SaveScreen()
LOCAL nQuant     := 0
LOCAL nSobra     := 0
LOCAL nRegistros := 0
LOCAL Vetor3
LOCAL Vetor4
FIELD Qtd
FIELD Sobra
FIELD Data
FIELD Tabela
FIELD Codiser
FIELD Codigo

oMenu:Limpa()
nRegistros := LasTrec()
Lista->(Order( LISTA_CODIGO ))
Servico->(Order( SERVICO_CODISER ))
Set Rela To CodiSer Into Servico, Codigo Into Lista
DbGoTop()
Mensagem( "Aguarde... Somando !", Cor())
While !Eof()
	nQuant += Qtd
	nSobra += Sobra
	DbSkip(1)
EndDo
Order(1)
DbGoTop()
Vetor3 := { "Data" , "Tabela" , "Tran( qtd, '99999')", "Tran( Sobra, '99999')" }
Vetor4 := { "DATA" , "CODIGO.SER" , "QUANT", "SOBRA" }
MaBox( 20, 00, MaxRow(), MaxCol(), "CONSULTA DE PRODUCAO" )
Write( 21, 10, "Totais....: " )
Write( 21, 42, TransForm( nQuant, "999999999" ) + TransForm( nSobra, "999999999" ))
DbGoTop()
MaBox( 01, 00, 19, MaxCol(), "CONSULTA DE PRODUCAO" )
Seta1(19)
DbEdit( 02, 01, 18, MaxCol()-1, Vetor3, "Func64", OK, Vetor4 )
DbClearRel()
DbClearFilter()
DbGoTop()
ResTela( cScreen )
Return

Func Func64( Mode )
*******************
FIELD CodiSer
FIELD Codiven
FIELD Codigo

Do Case
Case Mode = 0
	Write( 22, 10, "Produto...: " + Codigo  + " " + Lista->Descricao )
	Write( 23, 10, "Servico...: " + CodiSer + "     " + Servico->Nome )
	Return( 1 )

Case Mode = 1 .OR. Mode = 2
	ErrorBeep()
	Return( 1 )

Case LastKey() = 27
	Return( 0 )

OtherWise
	Return( 1 )

EndCase
Return( 1 )

Proc MoviConsulta()
*******************
LOCAL GetList	  := {}
LOCAL aMenuArray := {'Invidual', 'Por Tabela', 'Geral'}
LOCAL cScreen	  := SaveScreen()
LOCAL nChoice	  := 1
LOCAL cCodi
LOCAL nItens
LOCAL cTabela
FIELD Codiven
FIELD Tabela

WHILE OK
	oMenu:Limpa()
	M_Title("CONSULTAR MOVIMENTO")
	nChoice := FazMenu( 07, 16, aMenuArray )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Return

	Case nChoice = 1
		cCodi := Space( 04 )
		MaBox( 14, 16, 16, 38 )
		@ 15, 17 Say "Codigo........:" Get cCodi Pict "9999" Valid FunciErrado( @cCodi )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Area("Movi")
		Movi->(Order( MOVI_CODIVEN_TABELA_CODISER ))
		Sx_ClrScope( S_TOP )
		Sx_ClrScope( S_BOTTOM )
		Sx_SetScope( S_TOP, cCodi )
		Sx_SetScope( S_BOTTOM, cCodi )
		Mensagem('Aguarde, Filtrando.')
		Movi->(DbGoTop())
		IF Sx_KeyCount() == 0
         Sx_ClrScope( S_TOP )
         Sx_ClrScope( S_BOTTOM )
			Nada()
			Loop
		EndIF
		MoviBrowse()
		Sx_ClrScope( S_TOP )
		Sx_ClrScope( S_BOTTOM )

	Case nChoice = 2
		cTabela := Space( 04 )
		MaBox( 14, 16, 16, 38 )
		@ 15, 17 Say "Tabela........:" Get cTabela Pict "9999"
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		Area("Movi")
		Movi->(Order( MOVI_TABELA ))
		Sx_ClrScope( S_TOP )
		Sx_ClrScope( S_BOTTOM )
		Sx_SetScope( S_TOP, cTabela )
		Sx_SetScope( S_BOTTOM, cTabela )
		Mensagem('Aguarde, Filtrando.')
		Movi->(DbGoTop())
		IF Sx_KeyCount() == 0
         Sx_ClrScope( S_TOP )
         Sx_ClrScope( S_BOTTOM )
			Nada()
			Loop
		EndIF
		MoviBrowse()
		Sx_ClrScope( S_TOP )
		Sx_ClrScope( S_BOTTOM )

	Case nChoice = 3
		Area("Movi")
		Movi->(DbGoTop())
		IF Movi->(Eof())
			Nada()
			Loop
		EndIF
		Sx_ClrScope( S_TOP )
		Sx_ClrScope( S_BOTTOM )
		MoviBrowse()
	Endcase
EndDo

Proc MoviBrowse( cTabela )
**************************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
IF cTabela != NIL
	Area("Movi")
	Movi->(Order( MOVI_TABELA ))
	Sx_ClrScope( S_TOP )
	Sx_ClrScope( S_BOTTOM )
	Sx_SetScope( S_TOP, cTabela )
	Sx_SetScope( S_BOTTOM, cTabela )
	Movi->(DbGoTop())
EndIF
Set Rela To Movi->CodiSer Into Servico
Movi->(DbGoTop())
oBrowse:Add( "DATA",       "Data")
oBrowse:Add( "TABELA.SER", "Tabela")
oBrowse:Add( "QUANT",      "Qtd")
oBrowse:Add( "FUNC",       "Codiven")
oBrowse:Add( "SERVICO",    "CodiSer")
oBrowse:Add( "TOTAL",      {||Movi->Qtd * Servico->Valor}, '@E 999,999.9999')
oBrowse:Titulo   := "CONSULTA DE MOVIMENTO"
oBrowse:PreDoGet := {|| FALSO }
oBrowse:PosDoGet := {|| FALSO }
oBrowse:PreDoDel := {|| FALSO }
oBrowse:PosDoDel := {|| FALSO }
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
Movi->(DbClearRel())
Sx_ClrScope( S_TOP )
Sx_ClrScope( S_BOTTOM )
Movi->(DbGoTop())
ResTela( cScreen )
Return

Proc Produ52( cCabecalho )
**************************
LOCAL GetList	 := {}
LOCAL MouseList := {}
LOCAL cScreen	 := SaveScreen()
LOCAL cCodi

WHILE OK
	oMenu:Limpa()
	MaBox( 15, 10, 17, 31 )
   cCodi := Space(08)
   @ 16, 11 Say "Tabela..:" Get cCodi Pict "9999.999" Valid CortesErr( @cCodi )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	Sx_ClrScope( S_TOP )
	Sx_ClrScope( S_BOTTOM )
	Area("Movi")
	Movi->(Order( MOVI_TABELA ))
	Sx_SetScope( S_TOP, cCodi )
	Sx_SetScope( S_BOTTOM, cCodi )
	Mensagem('Aguarde, Filtrando.')
	Cortes->(DbGoTop())
	IF Sx_KeyCount() == 0
      Sx_ClrScope( S_TOP )
      Sx_ClrScope( S_BOTTOM )
		Nada()
		Loop
	EndIF
	Produ52Browse( cCabecalho )
	Sx_ClrScope( S_TOP )
	Sx_ClrScope( S_BOTTOM )
	Cortes->(DbGoTop())

EndDo

Proc Produ52Browse( cCabecalho )
********************************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()
FIELD Tabela
FIELD Codiven
FIELD Codiser
FIELD Qtd
FIELD Data

Write( 10, 24 , Tabela	)
Write( 11, 24 , Codiven )
Write( 12, 24 , CodiSer )
Write( 13, 24 , Qtd )
Write( 14, 24 , Data  )

oMenu:Limpa()
oBrowse:Add( "TABELA.SER", "Tabela")
oBrowse:Add( "FUNC",       "Codiven")
oBrowse:Add( "SERVICO",    "CodiSer")
oBrowse:Add( "QTD",        "Qtd" )
oBrowse:Add( "DATA",       "Data")
oBrowse:Titulo   := cCabecalho
oBrowse:PreDoGet := {|| FALSO }
oBrowse:PosDoGet := {|| FALSO }
oBrowse:PreDoDel := {|| Produ52PreDoDel( oBrowse) }
oBrowse:PosDoDel := {|| FALSO }
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )
Return

Function Produ52PreDoDel( oBrowse )
***********************************
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )
LOCAL cTabela := Movi->Tabela
LOCAL nQtd	  := Movi->Qtd

Cortes->( Order( CORTES_TABELA ))
Cortes->(DbSeek( cTabela ))
IF Cortes->(TravaReg())
	IF Movi->(!TravaReg())
		Cortes->(Libera())
		Return( FALSO )
	EndIF
	Cortes->Sobra := Cortes->Sobra + nQtd
	Cortes->(Libera())
	Return( OK )
EndIF
Return( FALSO )

Function Verifica_Sobra( nQtd, nRegCortes, nQuantAnt )
******************************************************
LOCAL nSobrando

Cortes->(DbGoTo( nRegCortes ) )
nSobrando := ( nQuantAnt + Cortes->Sobra )
IF ( nQtd > nSobrando )
	ErrorBeep()
	nSobrando := AllTrim( Str( nSobrando ) )
	Alerta( "Erro: Quantidade disponivel e " + nSobrando )
	Return( FALSO )

EndIF
Return(OK)

Proc Produ51()
**************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL MouseList := {}
LOCAL nQtd
LOCAL nTotal
LOCAL cCodigo
LOCAL cTabela
LOCAL nValorSer
LOCAL nRecno
LOCAL dData
LOCAL lSair
LOCAL nEscolha
LOCAL cCodiven
FIELD Comissao
FIELD Tabela
FIELD Codiven
FIELD CodiSer
FIELD Qtd
FIELD Data
FIELD Sobra
FIELD Codigo

WHILE OK
	oMenu:Limpa()
	nQtd			:= 0
	nTotal		:= 0
	cCodiven 	:= Space(04)
   cTabela     := Space(08)
	nValorSer	:= 0
	nRecno		:= 0
	dData 		:= Date()
	lSair 		:= FALSO
	WHILE OK
		MaBox( 06, 02, 11, 78, "INCLUSAO DE MOVIMENTO" )
      @ 07, 03 Say "Tabela....:" Get cTabela Pict "9999.999" Valid CortesErr( @cTabela, @nValorSer, Row(), Col()+1 )
      @ 08, 03 Say "Func......:" Get cCodiven Pict "9999" Valid FunciErrado( @cCodiven, Row(), Col()+1 )
		@ 09, 03 Say "Quant.....:" Get nQtd     Pict "9999" Valid VerQtdSobra( nQtd, cTabela )
		@ 10, 03 Say "Data......:" Get dData    Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			lSair := OK
			Exit
		EndIf
		ErrorBeep()
		nEscolha := Alerta("Pergunta: Voce Deseja ?", {"Incluir","Alterar","Sair"})
		IF nEscolha = 1
			IF !VerQtdSobra( nQtd, cTabela )
				Loop
			EndIF
			Cortes->( Order( CORTES_TABELA ))
			Cortes->(DbSeek( cTabela ))
			IF Cortes->(!TravaReg())
				Loop
			EndIF
			IF Movi->(!Incluiu())
				Cortes->(Libera())
				Loop
			EndIF
			cCodigo		  := Cortes->Codigo
			Cortes->Sobra := Cortes->Sobra - nQtd
			Cortes->(Libera())
			Movi->Tabela  := cTabela
			Movi->Codiven := cCodiven
         Movi->CodiSer := Right( cTabela, 3 )
			Movi->Qtd	  := nQtd
			Movi->Data	  := dData
			Movi->Codigo  := cCodigo
			Movi->(Libera())

		ElseIF nEscolha = 2
			Loop

		ElseIF nEscolha = 3
			lSair := OK
			Exit

		EndIF
	EndDo
	IF lSair
		ResTela( cScreen )
		Exit

	EndIf
EndDo

Function VerQtdSobra( nQtd, cTabela )
*************************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL RetVal

IF LastKey() = UP
	Return( OK )
EndIF
IF nQtd = 0
	ErrorBeep()
	Alerta("Erro: Quantidade Invalida.")
	Return( FALSO )
EndIf
Cortes->(DbSeek( cTabela ))
IF nQtd <= Cortes->Sobra
	RetVal := OK
Else
	ErrorBeep()
	nQtdPc := Tran( Cortes->Sobra, "99999")
	IF Conf("Pergunta: Disponivel e de &nQtdPc. Pecas. Consultar ?")
		MoviBrowse( cTabela )
	EndIF
	RetVal := FALSO
EndIf
AreaAnt( Arq_Ant, Ind_Ant )
Return( RetVal )

Function CortesErr( cTabela, nVlrServico, nCol, nRow )
*****************************************************
LOCAL Arq_Ant
LOCAL Ind_Ant
FIELD Tabela
FIELD Valor
FIELD Codiser
FIELD Codigo

Arq_Ant := Alias()
Ind_Ant := IndexOrd()
Area( "Cortes")
IF (Lastrec() = 0 )
	 ErrorBeep()
	 Alerta( "Erro: Nenhum Registro Disponivel ..." )
	 Return( FALSO )
EndIf
Lista->(Order( LISTA_CODIGO ))
Servico->(Order( SERVICO_CODISER ))
Cortes->(Order( CORTES_TABELA ))
Set Rela To CodiSer Into Servico, Codigo Into Lista
IF !( DbSeek( cTabela ) )
	Cortes->(Escolhe( 00, 00, 24, "Tabela + 'İ' + Tran( Sobra, '99999') + 'İ' +Left( Lista->Descricao, 30) + 'İ' + Left( Servico->Nome,30)", "TABELA  SOBRA  PRODUTO                       SERVICO" ))
	cTabela := Cortes->Tabela
EndIF
Cortes->(DbClearRel())
Servico->(Order( SERVICO_CODISER ))
Servico->(DbSeek( Right( cTabela, 3 )))
nVlrServico := Servico->Valor
IF nCol != Nil
	Write( nCol, nRow, Servico->Nome )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function FunciErrado( cCodi, nCol, nRow )
***************************************
LOCAL aRotinaInc := {{|| FuncInclusao() }}
LOCAL aRotinaAlt := {{|| FuncInclusao(OK) }}

LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
FIELD Codiven
FIELD Nome

Vendedor->(Order( VENDEDOR_CODIVEN ))
IF Vendedor->(!DbSeek( cCodi ))
	Vendedor->(Order( VENDEDOR_NOME ))
   Vendedor->(Escolhe( 00, 00, 24, "Codiven + 'İ' + Nome", "ID   NOME FUNCIONARIO ", aRotinaInc, NIL, aRotinaAlt ))
   cCodi := Vendedor->Codiven
EndIf
IF nCol != Nil
	Write( nCol, nRow, Vendedor->Nome )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Proc Produ31()
*************
LOCAL GetList		  := {}
LOCAL cScreen		  := SaveScreen()
LOCAL MouseList	  := {}
LOCAL lAutoProducao := oIni:ReadBool('sistema', 'autoproducao', FALSO )
LOCAL nQtd
LOCAL dData
LOCAL lSair
LOCAL cTabela
LOCAL cCor
LOCAL cCodigo
LOCAL cCodiSer
LOCAL cGrupo
LOCAL nItens
LOCAL nTotal
LOCAL cCodi
FIELD Tabela
FIELD Qtd
FIELD Sobra
FIELD Data
FIELD CodiSer
FIELD Grupo

nQtd	:= nTotal := 0
dData := Date()
oMenu:Limpa()
Area("Cortes")
Cortes->(Order( CORTES_TABELA ))
DbGoBottom()
cTabela := StrZero( Val( Left( Tabela, 4 ) ) + 1, 4 )
cCodigo := cTabela
cCodi   := 0
cGrupo  := Space(3)
MaBox( 06, 02, 12, 78, "INCLUSAO DE PRODUCAO" )
WHILE OK
	lSair := FALSO
   @ 07, 03 Say "Grupo Ser.:" Get cGrupo  Pict "999"    Valid GrpSerErrado( @cGrupo, Row(), Col()+1 )
	@ 08, 03 Say "Tabela....:" Get cCodigo Pict "9999"   Valid CortesCer( @cCodigo )
	@ 09, 03 Say "Quant.....:" Get nQtd    Pict "99999"  Valid nQtd != 0
   @ 10, 03 Say "Codigo....:" Get cCodi   Pict "999999" Valid CodiErrado( @cCodi, NIL, NIL, Row(), Col()+1 )
	@ 11, 03 Say "Data......:" Get dData   Pict "##/##/##"
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIf
	ErrorBeep()
   IF Conf("Confirma Inclusao do Registro ?")
		IF CortesCer( @cCodigo )
			IF Cortes->(TravaArq())
				Lista->(Order( LISTA_CODIGO ))
				Lista->(DbSeek( cCodi ))
				IF Lista->(!TravaReg())
					Cortes->(Libera())
					Loop
				EndIF
				IF Entradas->(!Incluiu())
					Cortes->(Libera())
					Lista->(Libera())
					Loop
				EndIF
				Servico->( Order( SERVICO_CODISER ))
				Servico->( DbGoTop())
				WHILE Servico->(!Eof())
					IF Servico->Grupo = cGrupo
						cCodiSer :=  "." + Servico->CodiSer
						Cortes->(DbAppend())
						Cortes->Tabela  := cCodigo + cCodiser
						Cortes->Qtd 	 := nQtd
						Cortes->Sobra	 := nQtd
						Cortes->Data	 := dData
						Cortes->Codigo  := cCodi
						Cortes->Codiser := Servico->CodiSer
					EndIF
					Servico->(DbSkip(1))
				EndDo
				Cortes->(Libera())
				IF lAutoProducao
					Lista->Quant += nQtd
					Lista->(Libera())
					Entradas->Codigo	  := cCodi
					Entradas->Entrada   := nQtd
					Entradas->Data 	  := dData
					Entradas->Fatura	  := cCodigo
					Entradas->Pcusto	  := Lista->Pcusto
					Entradas->Codi 	  := Lista->Codi
					Entradas->(Libera())
				EndIF
				cTabela := StrZero( Val( Left( cTabela, 4 ) ) + 1, 4 )
				cCodigo := cTabela
			EndIF
		EndIF
	EndIF
EndDo

Proc Produ32( cCabecalho )
**************************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL MouseList := {}
LOCAL cCodi
LOCAL cFatura
LOCAL Opcao
LOCAL cTabela1
LOCAL cTabela2
LOCAL nQtdAnt
LOCAL nQtd
LOCAL dData
LOCAL nRegAnt
LOCAL cTela
LOCAL oBloco
LOCAL cExtensao
LOCAL cProduto
LOCAL nQuant
FIELD Tabela
FIELD Qtd
FIELD Data
FIELD Sobra

WHILE OK
	Area("Cortes")
	Cortes->(Order( CORTES_TABELA ))
	MaBox( 15, 10, 17, 28 )
	cCodi := Space(04)
	@ 16, 11 Say "Tabela..:" Get cCodi Pict "9999" Valid CortesErr( @cCodi )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIf
	oMenu:Limpa()
	MaBox( 09, 10, 13, 65, cCabecalho )
	CortesProx( cCabecalho )
	WHILE OK
		MaBox( 20, 07, 22, 73 )
		AtPrompt( 21, 08, " Editar " )
		AtPrompt( 21, 17, " Deletar " )
		AtPrompt( 21, 27, " Proximo " )
		AtPrompt( 21, 37, " Anterior " )
		AtPrompt( 21, 49, " Localizar " )
		AtPrompt( 21, 61, " Retornar " )
		Menu To opcao
		Do Case
		Case opcao = 0 .OR. opcao = 6 .OR. opcao = 5
			ResTela( cScreen )
			Exit

		Case opcao = 1
			ErrorBeep()
			cTabela1 := cTabela2 := Tabela
			nQtdAnt	:= Qtd
			nQtd		:= Qtd
			dData 	:= Data
			@ 10, 24 Get cTabela2 Pict "9999" Valid CortesTab( cTabela2, @cTabela1 )
			@ 11, 24 Get nQtd 	 Pict "99999"
			@ 12, 24 Get dData	 Pict "##/##/##"
			Read
			IF LastKey() = ESC
				CortesProx( cCabecalho )
				Loop
			EndIF
			IF nQtdAnt != nQtd .OR. cTabela2 != cTabela1 .OR. dData != Data
				Area("Cortes")
				Cortes->(Order( CORTES_TABELA ))
				IF Conf("Pergunta: Confirma Alteracao da Tabela ?" )
					IF Cortes->(TravaArq())
						cTela := Mensagem("Aguarde, Alterando Tabela.", Cor())
						nRegAnt := Cortes->(Recno())
						oBloco  := {|| Cortes->(Left(Tabela,4)) = Left( cTabela1, 4) }
						IF Cortes->( DbSeek( Left( cTabela1, 4)))
							WHILE Eval( oBloco )
                         cExtensao      := Cortes->(Right( Tabela, 4))
                         Cortes->Tabela := Left( cTabela2, 4 ) + cExtensao
								 Cortes->Data	 := dData
								 Cortes->Qtd	 := nQtd
								 Cortes->Sobra  := Cortes->Sobra - nQtdAnt
								 Cortes->Sobra  := Cortes->Sobra + nQtd
								 Cortes->(DbSkip(1))
							 EndDo
						EndIF
						Cortes->(Libera())
						Cortes->(DbGoto( nRegAnt ))
						ResTela( cTela )
						CortesProx( cCabecalho )
					EndIF
				EndIF
			EndIF
			CortesProx( cCabecalho )

		Case opcao = 2
			cFatura	:= Left( cCodi, 4 )
			cTabela1 := Cortes->Tabela
			IF Conf( "Pergunta: Confirma Exclusao da Tabela ?" )
				IF Cortes->(TravaArq())
					cTela   := Mensagem("Aguarde, Excluindo Tabela.", Cor())
					nRegAnt := Cortes->(Recno())
					oBloco  := {|| Cortes->(Left(Tabela,4)) = Left( cTabela1, 4) }
					IF Cortes->( DbSeek( Left( cTabela1, 4)))
						WHILE Eval( oBloco )
							 Cortes->(DbDelete())
							 Cortes->(DbSkip(1))
						 EndDo
					EndIF
					Cortes->(Libera())
					Entradas->(Order( ENTRADAS_FATURA ))
					IF Entradas->(DbSeek( cFatura ))
						cProduto := Entradas->Codigo
						nQuant	:= Entradas->Entrada
						IF Entradas->(TravaReg())
							Entradas->(DbDelete())
							Entradas->(Libera())
						EndIF
						Lista->(Order( LISTA_CODIGO ))
						IF Lista->(DbSeek( cProduto ))
							IF Lista->(TravaReg())
								Lista->Quant -= nQuant
								Lista->(Libera())
							EndIF
						EndIF
					EndIF
					ResTela( cTela )
					CortesProx( cCabecalho )
				EndIF
			EndIF

		Case opcao = 3
			IF Eof()
				ErrorBeep()
				Loop
			EndIf
			Cortes->(DbSkip(1))
			CortesProx( cCabecalho )

		Case opcao = 4
			IF Bof()
				ErrorBeep()
				Loop
			EndIf
			Cortes->(DbSkip(-1))
			CortesProx( cCabecalho )

		EndCase
	EndDo
EndDo

Proc CortesProx( cCabecalho )
*****************************
FIELD Tabela
FIELD Qtd
FIELD Data

MaBox( 09, 10, 13, 65, cCabecalho )
Write( 10, 11 , "Tabela......:" + Left( Tabela, 4 ))
Write( 11, 11 , "Quant.......:" + Tran( Qtd, '99999'))
Write( 12, 11 , "Data........:" + Dtoc( Data ))
Return

Function CortesCer( cTabela )
*****************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
IF ( Empty( cTabela ) )
	ErrorBeep()
	Alerta("Erro: Codigo Tabela Invalida..." )
	Return( FALSO )
EndIF
Area( "Cortes" )
Cortes->(Order( CORTES_TABELA ))
IF !( DbSeek( Left( cTabela, 4 )))
	AreaAnt( Arq_Ant, Ind_Ant )
	Return(OK)
EndIF
ErrorBeep()
Alerta("Erro: Codigo da Tabela Ja Registrada...")
cTabela := StrZero( Val( cTabela )+1, 4)
AreaAnt( Arq_Ant, Ind_Ant )
Return( FALSO )

Proc IncServico()
*****************
LOCAL GetList	 := {}
LOCAL cScreen   := SaveScreen()
LOCAL MouseList := {}
LOCAL cNomeSer
LOCAL nValorSer
LOCAL lSair
LOCAL cCodiSer
LOCAL nEscolha
LOCAL cGrupo
FIELD CodiSer
FIELD Nome
FIELD Valor
FIELD Grupo

cScreen := SaveScreen()
WHILE OK
	oMenu:Limpa()
   cNomeSer  := Space(40)
   cGrupo    := Space(03)
	nValorSer := 0
	lSair 	 := FALSO
	Area("Servico")
	Servico->(Order( SERVICO_CODISER ))
	Servico->(DbGoBottom())
   cCodiSer = Servico->(StrZero( Val( CodiSer ) + 1, 3))
	WHILE OK
		MaBox( 06, 02, 11, 78, "INCLUSAO DE NOVOS SERVICOS" )
      @ 07, 03 Say "Grupo.....:" Get cGrupo     Pict "999" Valid GrpSerErrado( @cGrupo, Row(), Col()+1 )
      @ 08, 03 Say "Codigo....:" Get cCodiSer   Pict "999" Valid CodiSer( @cCodiSer )
		@ 09, 03 Say "Servi‡o...:" Get cNomeSer   Pict "@K!" Valid NomeSer( cNomeSer )
      @ 10, 03 Say "Valor.....:" Get nValorSer  Pict "9999999999.9999" Valid IF( nValorSer <= 0, ( ErrorBeep(), Alerta("Erro: Campo nao Pode ser Zero ou Negativo"), FALSO ), OK )
		Read
		IF LastKey() = ESC
			lSair := OK
			Exit

		EndIf
		ErrorBeep()
		nEscolha := Alerta("Pergunta: Voce Deseja ? ", {" Incluir "," Alterar "," Sair " })
		IF nEscolha = 1
			Area("Servico")
			IF CodiSer( @cCodiSer )
				IF Servico->(Incluiu())
					Servico->CodiSer := cCodiser
					Servico->Nome	  := cNomeSer
					Servico->Valor   := nValorSer
					Servico->Grupo   := cGrupo
					Servico->(Libera())
               cCodiSer := Strzero( Val( cCodiSer ) + 1, 3)
				EndIf
		  EndIf

		ElseIF nEscolha = 2
			Loop

		ElseIF nEscolha = 3
			lSair := OK
			Exit

		EndIF
	EndDo
	IF lSair
		ResTela( cScreen )
		Exit

	EndIf
Enddo

Proc Produ22( cCabecalho )
**************************
LOCAL GetList	 := {}
LOCAL cScreen := SaveScreen()
LOCAL cCodi, MouseList := {}
LOCAL Opcao, cCodi1, cCodi2
FIELD Nome, Valor, CodiSer

WHILE OK
	Area("Servico")
	Servico->(Order( SERVICO_CODISER ))
	MaBox( 15, 10, 17, 26 )
   cCodi := Space(03)
   @ 16, 11 Say "Codigo..:" Get cCodi Pict "999" Valid SerErrado( @cCodi )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIf
	oMenu:Limpa()
	MaBox( 09, 10, 14, 65, cCabecalho )
	SerProx( cCabecalho )
	WHILE OK
		MaBox( 20, 07, 22, 73 )
		__AtPrompt( 21, 08, " Editar " )
		__AtPrompt( 21, 17, " Deletar " )
		__AtPrompt( 21, 27, " Proximo " )
		__AtPrompt( 21, 37, " Anterior " )
		__AtPrompt( 21, 49, " Localizar " )
		__AtPrompt( 21, 61, " Retornar " )
		Menu To opcao
		Do Case
		Case opcao = 0 .OR. opcao = 6 .OR. opcao = 5
			ResTela( cScreen )
			Exit

		Case opcao = 1
			ErrorBeep()
			IF Servico->(TravaReg())
				cCodi2 := cCodi1 := CodiSer
            @ 10, 24 Get Grupo   Pict "999"
				@ 11, 24 Get cCodi2	Pict "@!" Valid SerVal( cCodi2, @cCodi1 )
				@ 12, 24 Get Nome 	Pict "@!"
				@ 13, 24 Get Valor	Pict "9999999999.999"
				Read
				IF LastKey() = ESC
					Servico->(Libera())
					SerProx( cCabecalho )
					Loop
				EndiF
				Servico->CodiSer := cCodi2
				Servico->(Libera())
				SerProx( cCabecalho )
			EndIF

		Case opcao = 2
			ErrorBeep()
			IF Conf( "Pergunta: Confirma Exclusao do Registro ?")
				IF Servico->(TravaReg())
					Servico->(DbDelete())
					Servico->(Libera())
					Alerta( "Tarefa: Registro Excluido...")
					Servico->(DbSkip())
					SerProx( cCabecalho )
				EndIf
			EndIf

		Case opcao = 3
			IF Eof()
				ErrorBeep()
				Loop
			EndIf
			DbSkip()
			SerProx( cCabecalho )

		Case opcao = 4
			IF Bof()
				ErrorBeep()
				Loop

			EndIf
			DbSkip( -1 )
			SerProx( cCabecalho )

		EndCase
	EndDo
EndDo

Function SerVal( cCodi1, cCodi2 )
*********************************
LOCAL Reg_Ant := Recno()

IF Empty( cCodi1 )
	ErrorBeep()
	Alerta( "Erro: Codigo Servi‡o Invalido...")
	Return( FALSO )
EndIf
IF cCodi1 == cCodi2
	DbGoto( Reg_Ant )
	Return( OK )
EndIf
Area("Servico")
Servico->(Order( SERVICO_CODISER ))
DbGoTop()
IF ( DbSeek( cCodi1 ) )
	ErrorBeep()
	Alerta( "Erro: Codigo Servi‡o Ja Registrado...")
	Return( FALSO )
EndIf
DbGoTo( Reg_Ant )
Return(OK)

Function CortesVal( cTabela1, cTabela2 )
***************************************
LOCAL cServico := Right( cTabela1, 3)
LOCAL Reg_Ant  := Recno()

IF Empty( cTabela1 )
	ErrorBeep()
	Alerta( "Erro: Entrada de Tabela Invalida...")
	Return( FALSO )
EndIf
IF cTabela1 == cTabela2
	Return( OK )
EndIf
Area("Cortes")
Cortes->(Order( CORTES_TABELA ))
IF ( DbSeek( cTabela1 ) )
	ErrorBeep()
	Alerta( "Erro: Codigo Tabela Ja Registrado...")
	Return( FALSO )
EndIf
IF Sererrado( @cServico )
	cTabela1 := Left( cTabela1, 5 ) + cServico
EndIF
DbGoTo( Reg_Ant )
Return(OK)

Function CortesTab( cTabela1, cTabela2 )
****************************************
LOCAL cTabela := Cortes->Tabela

IF Empty( cTabela1 )
	ErrorBeep()
	Alerta( "Erro: Entrada de Tabela Invalida.")
	Return( FALSO )
EndIf
IF cTabela1 == cTabela2
	Return( OK )
EndIf
Cortes->(Order( CORTES_TABELA ))
IF Cortes->(DbSeek( Left( cTabela1, 8 )))
	ErrorBeep()
	Alerta( "Erro: Codigo Tabela Ja Registrada.")
	Return( FALSO )
EndIf
Cortes->(DbSeek( cTabela ))
Return(OK)

Function SerErrado( cServico, cCodi )
************************************
LOCAL aRotina := {{|| IncServico() }}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
FIELD Nome
FIELD CodiSer

Area( "Servico")
Servico->(Order( SERVICO_CODISER ))
IF Servico->(!DbSeek( cServico ))
	Servico->(Escolhe( 00, 00, 24, "Nome", "         SERVI€O", aRotina ))
   cServico := IF( Len( cServico ) > 3, Servico->Nome, Servico->CodiSer )
EndIF
cCodi := Servico->CodiSer
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Proc SerProx( cCabecalho )
**************************
LOCAL GetList := {}
FIELD CodiSer
FIELD Nome
FIELD Valor
FIELD Grupo

MaBox( 09, 10, 14, 65, cCabecalho )
Write( 10, 11 , "Grupo.......:" )
Write( 11, 11 , "Codigo......:" )
Write( 12, 11 , "Nome........:" )
Write( 13, 11 , "Valor.......:" )

Write( 10, 24 , Grupo )
Write( 11, 24 , CodiSer )
Write( 12, 24 , Nome )
Write( 13, 24 , Valor )
Return

Function CodiSer( cCodi )
*************************
LOCAL Ind_Ant := IndexOrd()
LOCAL Arq_Ant := Alias()

IF Empty( cCodi )
	ErrorBeep()
	Alerta("Erro: Codigo Servi‡o Invalido..." )
	Return( FALSO )
EndIF
Area( "Servico" )
Servico->(Order( SERVICO_CODISER ))
IF !( DbSeek( cCodi ) )
	AreaAnt( Arq_Ant, Ind_Ant )
	Return(OK)
EndIF
ErrorBeep()
Alerta("Erro: Codigo de Servico Ja Registrado...")
cCodi := StrZero( Val( cCodi ) + 1, 2 )
AreaAnt( Arq_Ant, Ind_Ant )
Return( FALSO )

Function NomeSer( cNome )
*************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
IF ( Empty( cNome ) )
	ErrorBeep()
	Alerta("Erro: Nome Servi‡o Invalido..." )
	Return( FALSO )
EndIF
Area( "Servico" )
Servico->(Order( SERVICO_NOME ))
IF ( DbSeek( cNome ) )
	ErrorBeep()
	Alerta("Erro: Nome Servi‡o Ja Registrado..." )
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIf
AreaAnt( Arq_Ant, Ind_Ant )
Return(OK)

Function ProduPleta( cCep, cCida, cEsta)
****************************************
IF cCep	= XCCEP
	cCida := XCCIDA
	cEsta := XCESTA
	Keyb Chr( 13 ) + Chr( 13 )
EndIF
Return( OK )

Function ProduCerto( Var )
**************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

IF Empty( Var )
	ErrorBeep()
	Alerta( "Erro: Codigo Funcionario Invalido ..." )
	Return( FALSO )
EndIf
Area("Vendedor")
Vendedor->(Order( VENDEDOR_CODIVEN ))
IF !( DbSeek( Var ) )
	Areaant( Arq_Ant, Ind_Ant )
	Return(OK)
EndIf
ErrorBeep()
Alerta( "Erro: Funcionario Ja Registrado..." )
Var := StrZero( Val( Var ) + 1, 4 )
AreaAnt( Arq_Ant, Ind_Ant )
Return( FALSO )

Function ProduVal( Var, Var1 )
******************************
LOCAL Reg_Ant := Recno()

IF Empty( Var )
	ErrorBeep()
	Alerta( "Erro: Codigo Funcionario Invalido..." )
	DbGoto( reg_ant )
	Return( FALSO )
EndIf
IF Var == Var1
	DbGoto( Reg_Ant )
	Return( OK )
EndIf
Area("Vendedor")
Vendedor->(Order( VENDEDOR_CODIVEN ))
DbGoTop()
IF ( DbSeek( Var ) )
	ErrorBeep()
	Alerta( "Erro: Existe Funcionario Registrado Com Este Codigo ..." )
	Return( FALSO )
EndIf
DbGoTo( Reg_Ant )
Return( OK )

Function ProduErrado( Var, cCodi, nCol, nRow )
**********************************************
LOCAL aRotinaInc := {{|| FuncInclusao() }}
LOCAL aRotinaAlt := {{|| FuncInclusao(OK) }}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
FIELD Nome, Codiven

IF ( Lastrec() = 0 )
	ErrorBeep()
	Alerta( "Erro: Nenhum Registro Disponivel ...")
	Return( FALSO )
EndIf
Area("Vendedor")
Vendedor->(Order( VENDEDOR_CODIVEN ))
IF !( DbSeek( Var ) )
	Vendedor->(Order( VENDEDOR_NOME ))
	DbGoTop()
	Escolhe( 00, 00, 24, "Nome", "NOME DO FUNCIONARIO", aRotinaInc, NIL, aRotinaAlt )
	IF( Len( var ) > 4, Var := Nome, Var := Codiven )
EndIf
cCodi := Codiven
IF nCol != Nil
	Write( nCol  ,  nRow, Vendedor->Nome )
	Write( nCol+1,  nRow, Tran( Vendedor->ComissaoS, "999,999,999.999"))
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )


Proc RelProdu2( oBloco )
************************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL Relato  := "RELATORIO DE SERVICOS"
LOCAL Tam	  := 80
LOCAL Col	  := 58
LOCAL Pagina  := 0
FIELD Codiser
FIELD Grupo
FIELD Nome
FIELD Valor
FIELD Docnr

IF !Instru80()
	ResTela( cScreen )
	Return
EndIF
PrintOn()
SetPrc( 0, 0 )
WHILE Eval( oBloco ) .AND. REL_OK()
	IF Col >= 58
		Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
		Write( 01, 00, Date() )
		Write( 02, 00, Padc( XNOMEFIR, Tam ) )
		Write( 03, 00, Padc( SISTEM_NA7, Tam ) )
		Write( 04, 00, Padc( Relato, Tam ) )
		Write( 05, 00, Repl( SEP, Tam ) )
		Write( 06, 00, "CODIGO GRUPO DESCRICAO DO SERVICO                                          VALOR")
		Write( 07, 00, Repl( SEP, Tam ) )
		Col := 8
	Endif
   Qout( CodiSer, Space(3), Grupo, Space(2), Nome + Space(9) + TransForm( Valor, "999,999,999.9999"))
	Col++
	IF Col >= 58
		Write( Col, 0,  Repl( SEP, Tam ) )
		__Eject()
	EndIf
	DbSkip()
EndDo
__Eject()
PrintOff()
Return

Proc AdianConsu()
*****************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL aMenu   := {'Individual','Por Docto','Por data','Geral'}
LOCAL dIni
LOCAL dFim
LOCAL nChoice
LOCAL cCodiven
LOCAL cDocnr
FIELD Codiven
FIELD Docnr

WHILE OK
	 oMenu:Limpa()
	 M_Title("CONSULTA DE ADIANTAMENTOS")
	 nChoice := Fazmenu( 08, 20, aMenu )
    Do Case
	 Case nChoice = 0
		 ResTela( cScreen )
		 Return

	 Case nChoice = 1
		MaBox( 18, 20, 20, 36 )
		cCodiven := Space(04)
		@ 19, 21 Say "Codigo..:" Get cCodiven Pict "9999" Valid ProduErrado( @cCodiven )
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		Area("Funcimov")
		Funcimov->( Order( FUNCIMOV_CODIVEN ))
		Sx_ClrScope( S_TOP )
		Sx_ClrScope( S_BOTTOM )
		Sx_SetScope( S_TOP, cCodiven )
		Sx_SetScope( S_BOTTOM, cCodiven )
		Mensagem('Aguarde, Filtrando.')
		Funcimov->(DbGoTop())
		IF Sx_KeyCount() == 0
         Sx_ClrScope( S_TOP )
         Sx_ClrScope( S_BOTTOM )
			Nada()
			Loop
		EndIF
		AdianMostra()
		Sx_ClrScope( S_TOP )
		Sx_ClrScope( S_BOTTOM )
		Funcimov->(DbGoTop())

	 Case nChoice = 2
		 MaBox( 18, 20, 20, 41 )
		 cDocnr = Space( Len( Docnr )-2 )
		 @ 19, 21 Say "Docto N§...:" Get cDocnr Pict "@!" Valid DocFuErrado( @cDocnr )
		 Read
		 IF LastKey() = ESC
			 Loop
		 EndIF
		 Area("Funcimov")
		 Funcimov->( Order( FUNCIMOV_DOCNR ))
		 Sx_ClrScope( S_TOP )
		 Sx_ClrScope( S_BOTTOM )
		 Sx_SetScope( S_TOP, cDocnr )
		 Sx_SetScope( S_BOTTOM, cDocnr )
		 Mensagem('Aguarde, Filtrando.')
		 Funcimov->(DbGoTop())
		 IF Sx_KeyCount() == 0
          Sx_ClrScope( S_TOP )
          Sx_ClrScope( S_BOTTOM )
			 Nada()
			 Loop
		 EndIF
		 AdianMostra()
		 Sx_ClrScope( S_TOP )
		 Sx_ClrScope( S_BOTTOM )
		 Funcimov->(DbGoTop())

	Case nChoice = 3
		 MaBox( 18, 20, 21, 39 )
		 dIni := Date()-30
		 dFim := Date()
		 @ 19, 21 Say "Inicio..:" Get dIni Pict "##/##/##"
		 @ 20, 21 Say "Final...:" Get dFim Pict "##/##/##"
		 Read
		 IF LastKey() = ESC
			 Loop
		 EndIF
		 Area("Funcimov")
		 Funcimov->( Order( FUNCIMOV_DATA ))
		 Sx_ClrScope( S_TOP )
		 Sx_ClrScope( S_BOTTOM )
		 Sx_SetScope( S_TOP, dIni )
		 Sx_SetScope( S_BOTTOM, dFim )
		 Mensagem('Aguarde, Filtrando.')
		 Funcimov->(DbGoTop())
		 IF Sx_KeyCount() == 0
          Sx_ClrScope( S_TOP )
          Sx_ClrScope( S_BOTTOM )
			 Nada()
			 Loop
		 EndIF
		 AdianMostra()
		 Sx_ClrScope( S_TOP )
		 Sx_ClrScope( S_BOTTOM )
		 Funcimov->(DbGoTop())

    Case nChoice = 4
		 Area("Funcimov")
		 Funcimov->(Order( FUNCIMOV_CODIVEN ))
		 Sx_ClrScope( S_TOP )
		 Sx_ClrScope( S_BOTTOM )
		 Funcimov->(DbGoTop())
		 AdianMostra()
		 Sx_ClrScope( S_TOP )
		 Sx_ClrScope( S_BOTTOM )
		 Funcimov->(DbGoTop())

	 EndCase
EndDo

Proc AdianMostra()
******************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL Mostra1
LOCAL Mostra2
FIELD Codiven
FIELD Deb
FIELD Nome
FIELD Data
FIELD Docnr
FIELD Descricao


oMenu:Limpa()
Vendedor->( Order( VENDEDOR_CODIVEN ))
Area( "Funcimov")
Set Rela To Codiven Into Vendedor
Mostra2 := {"Codiven", "Vendedor->nome", "TransForm( Deb, '@E 999,999,999.9999' )",;
            "TransForm( Cre, '@E 999,999,999.9999' )","data", "docnr", "descricao" }
Mostra1 := {"CODI", "NOME", "DEBITO", "CREDITO" ,"DATA" ,"DOCTO N§" ,"DESCRICAO"}
MaBox( 00, 00, MaxRow(), MaxCol(), "CONSULTA DE DEBITOS/CREDITOS" )
Seta1(24)
DbEdit( 01, 01, MaxRow()-1, MaxCol()-1, Mostra2, OK, OK, Mostra1 )
FunciMov->( DbClearRel() )
FunciMov->( DbClearFilter())
ResTela( cScreen )
Return

Proc AdianAdian()
*****************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL dDataEmis
LOCAL dDataVcto
LOCAL cDocnr
LOCAL cDesc
LOCAL nVlr
LOCAL cCodi
LOCAL cOpcao

oMenu:Limpa()
WHILE OK
	Area("Vendedor")
	Vendedor->(Order( VENDEDOR_CODIVEN ))
	dDataEmis  := Date()
	dDataVcto  := Date()
	cDocnr	  := Space(07)
	cDesc 	  := Space(40)
	nVlr		  := 0
	cCodi 	  := Space(04)
	cOpcao	  := "D"
   MaBox( 09, 10, 17, 68, "CREDITOS/DEBITOS FUNCIONARIOS" )
   @ 10, 11 Say "Codigo....:" Get cCodi Pict "9999" Valid ProduErrado( @cCodi,NIL, Row(), Col()+1 )
	@ 11, 11 Say "Emissao...:" Get dDataEmis Pict "##/##/##"
	@ 12, 11 Say "Vencto....:" Get dDataVcto Pict "##/##/##"
	@ 13, 11 Say "Docto N§..:" Get cDocnr    Pict "@!"
   @ 14, 11 Say "Valor.....:" Get nVlr      Pict "99999999.9999" Valid nVlr <> 0
   @ 15, 11 Say "Cred/Deb..:" Get cOpcao    Pict "!" Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cOpcao )
	@ 16, 11 Say "Descricao.:" Get cDesc     Pict "@!" Valid !Empty( cDesc )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIf
	ErrorBeep()
	IF cOpcao = "D"
		IF Conf( "Pergunta: Confirma Inclusao do Debito ?" )
			IF Vendedor->(TravaReg())
				IF Funcimov->(!Incluiu())
					Vendedor->(Libera())
					Loop
				EndIF
				Vendedor->ComissaoS -= nVlr
				Vendedor->(Libera())
				Funcimov->Deb		  := nVlr
				Funcimov->Codiven   := cCodi
				Funcimov->Data 	  := dDataEmis
				Funcimov->Docnr	  := cDocNr
				Funcimov->Descricao := cDesc
            Funcimov->Comissao  -= nVlr
				Funcimov->(Libera())
			EndIf
			IF Conf("Imprimir Recibo Agora ?")
				ReciboFuncionario( cDocnr )
			EndIF
		EndIf
	Else
		IF Conf( "Pergunta: Confirma Inclusao do Credito ?" )
			IF Vendedor->(TravaReg())
				IF Funcimov->(!Incluiu())
					Vendedor->(Libera())
					Loop
				EndIF
				Vendedor->ComissaoS += nVlr
				Vendedor->(Libera())
				Funcimov->Cre		  := nVlr
				Funcimov->Codiven   := cCodi
				Funcimov->Data 	  := dDataEmis
				Funcimov->Docnr	  := cDocNr
				Funcimov->Descricao := cDesc
            Funcimov->Comissao  += nVlr
				Funcimov->(Libera())
			EndIf
		EndIf
	EndIf
EndDo

Function DocFuErrado( cDocnr )
***************************
FIELD Docnr

IF !( DbSeek( cDocnr ))
	Escolhe( 00, 00, 24, "Docnr", "  DOCTO N§  " )
	cDocnr := Docnr
EndIf
Return( OK )

Proc ScpSaldo()
***************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL aMenu 	 := {'Individual', 'Geral'}
LOCAL nChoice	 := 1
LOCAL cCodiVen

Area("Vendedor")
WHILE OK
	oMenu:Limpa()
	M_Title("CONSULTA DE SALDOS")
	nChoice := Fazmenu( 07, 10, aMenu )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Return

	Case nChoice = 1
		MaBox( 14, 10, 16, 26 )
		cCodiven := Space(4)
		@ 15,11 Say "Codigo..:" Get cCodiven Pict "9999" Valid ProduErrado( @cCodiven )
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		Sx_ClrScope( S_TOP )
		Sx_ClrScope( S_BOTTOM )
		Vendedor->(Order( VENDEDOR_CODIVEN ))
		Vendedor->(DbGoTop())
		Sx_SetScope( S_TOP, cCodiven )
		Sx_SetScope( S_BOTTOM, cCodiven )
		Mensagem('Aguarde, Filtrando.')
		Vendedor->(DbGoTop())
		IF Sx_KeyCount() == 0
         Sx_ClrScope( S_TOP )
         Sx_ClrScope( S_BOTTOM )
			Nada()
			Loop
		EndIF
		Funcao45()
		Sx_ClrScope( S_TOP )
		Sx_ClrScope( S_BOTTOM )

	Case nChoice = 2
		Sx_ClrScope( S_TOP )
		Sx_ClrScope( S_BOTTOM )
		Vendedor->(Order( VENDEDOR_NOME ))
		Vendedor->(DbGoTop())
		Funcao45()
		Sx_ClrScope( S_TOP )
		Sx_ClrScope( S_BOTTOM )

	EndCase
EndDo

Proc Funcao45()
***************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
oBrowse:Add( "CODIGO", "Codiven", '9999')
oBrowse:Add( "NOME",   "Nome", '@!')
oBrowse:Add( "TOTAL",  "ComissaoS", '@E 999,999,999.9999')
oBrowse:Titulo   := "SALDO FUNCIONARIOS"
oBrowse:PreDoGet := {|| FALSO }
oBrowse:PosDoGet := {|| FALSO }
oBrowse:PreDoDel := {|| FALSO }
oBrowse:PosDoDel := {|| FALSO }
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Proc Adiantamentos()
********************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL aMenu   := {"Individual", "Por Periodo"}
LOCAL nChoice
LOCAL dIni
LOCAL dFim
LOCAL cCodi
FIELD Codiven

WHILE OK
   oMenu:Limpa()
	M_Title("POSICAO FINANCEIRA")
   nChoice := FazMenu( 04, 20, aMenu )
	Do Case
   Case nChoice = 0
      ResTela( cScreen )
      Return

   Case nChoice = 1
		cCodi := Space( 4 )
      dIni  := Date() - 30
      dFim  := Date()
      MaBox( 10, 20, 14, 48)
      @ 11, 21 Say "Codigo........:" Get cCodi Pict "9999" Valid ProduErrado( @cCodi )
      @ 12, 21 Say "Data Inicial..:" Get dIni Pict "##/##/##"
      @ 13, 21 Say "Data Final....:" Get dFim Pict "##/##/##"
		Read
		IF LastKey() = ESC
			Loop
      EndIF
      Vendedor->( Order( VENDEDOR_CODIVEN ))
      Area( "Funcimov")
      Funcimov->(Order( FUNCIMOV_CODIVEN_DATA ))
      Set Rela To Codiven Into Vendedor
      Sx_ClrScope( S_TOP )
      Sx_ClrScope( S_BOTTOM )
      Sx_SetScope( S_TOP,    cCodi + DateToStr( dIni ))
      Sx_SetScope( S_BOTTOM, cCodi + DateToStr( dFim ))
      Mensagem('Aguarde, Filtrando.')
      Funcimov->(DbGoTop())
      IF Sx_KeyCount() == 0
         Sx_ClrScope( S_TOP )
         Sx_ClrScope( S_BOTTOM )
         Nada()
         Loop
      EndIF
      AdiantImpressao( dIni, dFim )
      Sx_ClrScope( S_TOP )
      Sx_ClrScope( S_BOTTOM )
      Funcimov->(DbGoTop())

   Case nChoice = 2
      MaBox( 10, 20, 13, 48)
      dIni  := Date() - 30
      dFim  := Date()
      @ 11, 21 Say "Data Inicial..:" Get dIni Pict "##/##/##"
      @ 12, 21 Say "Data Final....:" Get dFim Pict "##/##/##"
		Read
		IF LastKey() = ESC
			Loop
      EndIF
      Vendedor->( Order( VENDEDOR_CODIVEN ))
      Area( "Funcimov")
      Funcimov->(Order( FUNCIMOV_DATA ))
      Set Rela To Codiven Into Vendedor
      Sx_ClrScope( S_TOP )
      Sx_ClrScope( S_BOTTOM )
      Sx_SetScope( S_TOP,    dIni )
      Sx_SetScope( S_BOTTOM, dFim )
      Mensagem('Aguarde, Filtrando.')
      Funcimov->(DbGoTop())
      IF Sx_KeyCount() == 0
         Sx_ClrScope( S_TOP )
         Sx_ClrScope( S_BOTTOM )
         Nada()
         Loop
      EndIF
      AdiantImpressao( dIni, dFim )
      Sx_ClrScope( S_TOP )
      Sx_ClrScope( S_BOTTOM )
      Funcimov->(DbGoTop())
   EndCase
EndDo

Proc AdiantImpressao( dIni, dFim )
**********************************
LOCAL cScreen       := SaveScreen()
LOCAL Tam           := 132
LOCAL Col           := 58
LOCAL Pagina        := 0
LOCAL NovoCodiven   := OK
LOCAL UltCodiven    := Codiven
LOCAL nTotalVend    := 0
LOCAL nSubTotal     := 0
LOCAL nTotalGeral   := 0
LOCAL lSair         := FALSO
FIELD Codiven
FIELD Docnr
FIELD Descricao
FIELD Deb
FIELD Cre
FIELD Data

IF !Instru80()
   Return
EndIF
Mensagem("Aguarde, Imprimindo.")
PrintOn()
FPrint( PQ )
SetPrc( 0, 0 )
While !Eof() .AND. REL_OK()
   IF Col >=  58
      Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
      Write( 01, 00, Date() )
      Write( 02, 00, Padc( XNOMEFIR, Tam ) )
      Write( 03, 00, Padc( SISTEM_NA7, Tam ) )
      Write( 04, 00, Padc( "POSICAO FINANCEIRA REF. " + Dtoc( dIni ) + ' A ' + Dtoc( dFim ), Tam ) )
      Write( 05, 00, Repl( SEP, Tam ) )
      Write( 06, 00,"DATA     DOCTO N§  DESCRICAO                                        DEBITO        CREDITO")
      Write( 07, 00, Repl( SEP, Tam ) )
      Col := 8
   EndIf
   IF Col = 8
      FPrint( PQ )
      Write( Col, 00, NG + "FUNCIONARIO: " + Codiven + " " + Vendedor->Nome + NR )
      Qout()
      Col++
      Col++
   EndIf
   IF NovoCodiven
      NovoCodiven   := FALSO
      nSubTotal     := 0
      nTotalVend    := 0
   EndIf
   Qout( Data, Docnr, Descricao, Tran( Deb, "@E 999,999,999.99" ), Tran( Cre, "@E 999,999,999.99" ))
   Col++
   UltCodiven    := Codiven
   nTotalVend    += Cre
   nSubTotal     += Cre
   nTotalGeral   += Cre
   nTotalVend    -= Deb
   nSubTotal     -= Deb
   nTotalGeral   -= Deb
   DbSkip()
   IF Col = 55 .OR. UltCodiven != Codiven
      Write( (Col + 1), 00, "*** SubTotal Funcionario *")
      Write( (Col + 1), ( MaxCol() - 4), TransForm( nSubTotal, "@E 999,999,999.99" ) )
      nSubTotal := 0
      IF UltCodiven != Codiven
         NovoCodiven := OK
         Write( (Col + 2), 00, "*** Total Funcionario *")
         Write( (Col + 2), ( MaxCol() - 4), TransForm( nTotalVend, "@E 999,999,999.99" ) )
      EndIF
      IF Eof()
         Write( (Col + 3), 00, "*** Total Geral *** ")
         Write( (Col + 3), ( MaxCol() - 4), TransForm( nTotalGeral, "@E 999,999,999.99" ) )
      EndIF
      __Eject()
      Col := 58
   EndIF
EndDo
PrintOff()
Return

Proc SaldoFunc()
****************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL aMenu   := {'Individual', 'Geral' }
LOCAL cNome
LOCAL cCodi
LOCAL nChoice
LOCAL nItens
LOCAL dIni
LOCAL dFim
FIELD Codiven
FIELD Data

WHILE OK
	oMenu:Limpa()
   M_Title("ROL SALDOS")
	Sx_ClrScope( S_TOP )
	Sx_ClrScope( S_BOTTOM )
	nChoice := FazMenu( 07, 16, aMenu )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Return

	Case nChoice = 1
		cCodi := Space( 04 )
		dIni	:= Date()
		dFim	:= Date() + 30
		MaBox( 14, 16, 16, 42 )
		@ 15, 17 Say "Codigo........:" Get cCodi Valid FunciErrado( @cCodi )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Area("Vendedor")
		Vendedor->(Order( VENDEDOR_CODIVEN ))
      Sx_ClrScope( S_TOP )
      Sx_ClrScope( S_BOTTOM )
		Sx_SetScope( S_TOP, cCodi )
		Sx_SetScope( S_BOTTOM, cCodi )
		Mensagem('Aguarde, Filtrando.')
		Vendedor->(DbGoTop())
		IF Sx_KeyCount() == 0
         Sx_ClrScope( S_TOP )
         Sx_ClrScope( S_BOTTOM )
			Nada()
			Loop
		EndIF
		SaldoRel()
		Sx_ClrScope( S_TOP )
		Sx_ClrScope( S_BOTTOM )

   Case nChoice = 2
		Area("Vendedor")
		Vendedor->(Order( VENDEDOR_NOME ))
      Sx_ClrScope( S_TOP )
      Sx_ClrScope( S_BOTTOM )
		Vendedor->(DbGoTop())
		IF Vendedor->(Eof())
         Sx_ClrScope( S_TOP )
         Sx_ClrScope( S_BOTTOM )
			Nada()
			Loop
		EndIf
		SaldoRel()
		Sx_ClrScope( S_TOP )
		Sx_ClrScope( S_BOTTOM )
	EndCase
EndDo

Proc SaldoRel()
****************
LOCAL cScreen     := SaveScreen()
LOCAL Tam         := 80
LOCAL Col         := 58
LOCAL Pagina      := 0
LOCAL nTotalFolha := 0
LOCAL nTotalGeral := 0
LOCAL lSair       := FALSO
FIELD Codiven
FIELD Nome
FIELD ComissaoS

IF !Instru80()
	Return
EndIf
Mensagem("Aguarde, Imprimindo.")
PrintOn()
SetPrc( 0, 0 )
WHILE !Eof() .AND. Rel_Ok()
   IF Col >=  58
      Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
      Write( 01, 00, Date() )
      Write( 02, 00, Padc( XNOMEFIR, Tam ) )
      Write( 03, 00, Padc( SISTEM_NA7, Tam ) )
      Write( 04, 00, Padc( "RELATORIO SALDO DE FUNCIONARIO", Tam ) )
      Write( 05, 00, Repl( SEP, Tam ) )
      Col := 6
   EndIF
   IF Col = 6
      Write( Col, 00,"CODIGO  NOME FUNCIONARIO                                                   SALDO" )
      Col++
      Write( Col, 00, Repl( SEP, Tam ) )
      Col++
   EndIF
   Write( Col, 0, Codiven + "    " + Nome +  Space(14) + Tran( ComissaoS, "9,999,999,999.9999"))
   nTotalFolha += ComissaoS
   nTotalGeral += ComissaoS
   Col++
   DbSkip( 1 )
   IF Col >= 57
      Write( ++Col, 46," ** SubTotal ** " + Tran( nTotalFolha, "9,999,999,999.9999"))
      nTotalFolha := 0
      __Eject()
    EndIF
EndDo
Write( ++Col, 46," ** SubTotal ** " + Tran( nTotalFolha, "9,999,999,999.9999"))
Write( ++Col, 43," ** Total Geral ** " + Tran( nTotalGeral, "9,999,999,999.9999"))
__Eject()
PrintOff()
ResTela( cScreen )
Return

STATIC Proc AbreArea()
**********************
LOCAL cScreen := SaveScreen()
ErrorBeep()
Mensagem("Aguarde, Abrindo base de dados.", WARNING, _LIN_MSG )
FechaTudo()

IF !UsaArquivo("VENDEDOR")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("SERVICO")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("CORTES")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("MOVI")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("FUNCIMOV")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("GRPSER")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("LISTA")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("ENTRADAS")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("GRUPO")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("SUBGRUPO")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("PAGAR")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("REPRES")
	MensFecha()
	Return
EndiF
Return

Proc PrintProducao()
********************
LOCAL GetList	 := {}
LOCAL cScreen		:= SaveScreen()
LOCAL nQtd			:= 0
LOCAL nSobra		:= 0
LOCAL Tam			:= 80
LOCAL Col			:= 58
LOCAL nProduzido	:= 0
LOCAL Pagina		:= 0
LOCAL cTabela		:= ""
FIELD Tabela
FIELD Data
FIELD Qtd
FIELD Sobra

IF !Instru80()
	ResTela( cScreen )
	Return
EndIf
Area("Cortes")
Cortes->(Order( CORTES_TABELA ))
Cortes->(DbGoTop())
Mensagem(" Aguarde... Imprimindo. ESC Cancela.")
PrintOn()
FPrint( _CPI10 )
SetPrc( 0, 0 )
WHILE !Eof() .AND. Rel_Ok()
	IF Col >= 58
		Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
		Write( 01, 00, Date() )
		Write( 02, 00, Padc( XNOMEFIR, Tam ) )
		Write( 03, 00, Padc( SISTEM_NA7, Tam ) )
		Write( 04, 00, Padc( "RELATORIO DE PRODUCAO",Tam ) )
		Write( 05, 00, Repl( SEP, Tam ))
		Write( 06, 00, "DATA       TABELA              QTD       SOBRA         PRODUZIDO")
		Write( 07, 00, Repl( SEP, Tam ))
		Col := 8
	EndIf
	IF cTabela != Left( Tabela, 4 )
		Qout( Data, Space(1), Left( Tabela,4), Space(9), Qtd, Space(3), Sobra, Space(3), ( Qtd - Sobra ) )
		Col++
		nQtd		  += Qtd
		nSobra	  += Sobra
		nProduzido += ( Qtd - Sobra )
	EndIF
	cTabela := Left( Tabela, 4 )
	DbSkip(1)
	IF Col >= 58
		Write( Col + 1, 0, Repl( SEP, Tam ))
		__Eject()
	EndIf
EndDo
Col++
Write( Col, 000," ** Total Geral **" )
Write( Col, 025, Tran( nQtd,		  "@E 99,999.99" ))
Write( Col, 037, Tran( nSobra,	  "@E 99,999.99" ))
Write( Col, 055, Tran( nProduzido, "@E 99,999.99" ))
__Eject()
PrintOff()
ResTela( cScreen )
Return

Proc FechaMes()
***************
LOCAL GetList	 := {}
LOCAL cScreen   := SaveScreen()
LOCAL nValor    := 0
LOCAL lGeral    := FALSO
LOCAL aMenu     := {'Indidual', 'Geral'}
LOCAL cNome
LOCAL cCodi
LOCAL dIni
LOCAL dFim
LOCAL nChoice
LOCAL nItens
FIELD Codiven
FIELD Data
FIELD Codiser
FIELD Baixado

Area("Movi")
Movi->(Order( MOVI_CODIVEN_TABELA_CODISER ))
WHILE OK

   oMenu:Limpa()
   M_Title('Fechamento Mensal')
   nChoice := Fazmenu( 07, 16, aMenu )
   Do Case
   Case nChoice = 0
		ResTela( cScreen )
		Exit
   Case nChoice = 1
		cCodi := Space( 04 )
		dIni	:= Date()
		dFim	:= Date() + 30
		MaBox( 14, 16, 18, 42 )
      @ 15, 17 Say "Codigo........:" Get cCodi Pict "9999" Valid FunciErrado( @cCodi )
      @ 16, 17 Say "Data Inicial..:" Get dIni  Pict "##/##/##"
      @ 17, 17 Say "Data Final....:" Get dFim  Pict "##/##/##" Valid dFim > dIni
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		IF Conf("Pergunta: Confirma Fechamento Individual ?")
			oMenu:Limpa()
			IF Movi->(!TravaArq()) ; ResTela( cScreen ) ; Loop ; EndIF
			IF Vendedor->(!TravaArq()) ; Movi->(Libera()) ; ResTela( cScreen ) ; Loop ; EndIF
			IF Funcimov->(!TravaArq()) ; Movi->(Libera()) ; Vendedor->(Libera()) ; ResTela( cScreen ) ; Loop ; EndIF
			Mensagem(" Aguarde... Lancando Movimento.", Cor())
			Vendedor->( Order( VENDEDOR_CODIVEN ))
			Servico->( Order( SERVICO_CODISER ))
			Area( "Movi")
			Set Rela To Codiven Into Vendedor, CodiSer Into Servico
			Movi->(Order( MOVI_CODIVEN_TABELA_CODISER ))
         Sx_ClrScope( S_TOP )
         Sx_ClrScope( S_BOTTOM )
         Sx_SetScope( S_TOP, cCodi )
         Sx_SetScope( S_BOTTOM, cCodi )
         Mensagem('Aguarde, Filtrando.')
         Movi->(DbGoTop())
         IF Sx_KeyCount() == 0
            Sx_ClrScope( S_TOP )
            Sx_ClrScope( S_BOTTOM )
            Nada()
            Loop
         EndIF
			nValor := 0
			WHILE Movi->(!Eof())
            IF Movi->Data >= dIni .AND. Movi->Data <= dFim .AND. Movi->Baixado = FALSO
               nValor += ( Servico->Valor * Movi->Qtd )
               Movi->Baixado := OK
            EndIF
            Movi->(DbSkip(1))
			EndDo
         Sx_ClrScope( S_TOP )
         Sx_ClrScope( S_BOTTOM )
			IF nValor != 0
				Vendedor->(Order( VENDEDOR_CODIVEN ))
				Vendedor->(DbSeek( cCodi ))
				Vendedor->ComissaoS += nValor
				Funcimov->(DbAppend())
				Funcimov->Codiven   := cCodi
				Funcimov->Cre		  := nValor
				Funcimov->Comissao  := Funcimov->Comissao + nValor
				Funcimov->Descricao := "COM SOB PRODUCAO REF " + Dtoc( dIni ) + " A " + Dtoc( dFim )
				Funcimov->Data 	  := dFim
            Funcimov->Docnr     := Left(StrTran(Time(),":"), 5 ) + cCodi
			EndIf
			Movi->(Libera())
			Vendedor->(Libera())
			Funcimov->(Libera())
		EndIf

   Case nChoice = 2
		dIni	:= Date()
		dFim	:= Date() + 30
		MaBox( 14, 16, 17, 42 )
		@ 15, 17 Say "Data Inicial..:" Get dIni Pict "##/##/##"
		@ 16, 17 Say "Data Final....:" Get dFim Pict "##/##/##" Valid dFim > dIni
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		IF Conf("Pergunta: Confirma Fechamento Geral ?")
			IF Movi->(!TravaArq())								 ; ResTela( cScreen ) ; Loop ;EndIF
			IF Vendedor->(!TravaArq()) ; Movi->(Libera()) ; ResTela( cScreen ) ; Loop ; EndIF
			IF Funcimov->(!TravaArq()) ; Movi->(Libera()) ; Vendedor->(Libera()) ; ResTela( cScreen ) ; Loop ; EndIF
			Vendedor->( Order( VENDEDOR_CODIVEN ))
			Servico->( Order( SERVICO_CODISER ))
			Area( "Movi")
			Movi->(Order( MOVI_CODIVEN_TABELA_CODISER ))
			Set Rela To Codiven Into Vendedor, CodiSer Into Servico
			Movi->(DbGoTop())
			oMenu:Limpa()
			Mensagem(" Aguarde... Lancando Movimento.", Cor())
			Vendedor->(DbGoTop())
			While Vendedor->(!Eof())
				nValor := 0
				cCodi := Vendedor->Codiven
				Movi->(DbSeek( cCodi ) )
				WHILE Movi->(!Eof()) .AND. Movi->Codiven = cCodi
					IF !Movi->Baixado
						IF Movi->Data >= dIni .AND. Movi->Data <= dFim
							nValor += ( Servico->Valor * Movi->Qtd )
							Movi->Baixado := OK
						EndIF
					EndIF
					Movi->(DbSkip(1))
				EndDo
				IF nValor != 0
					Vendedor->(Order( VENDEDOR_CODIVEN ))
					Vendedor->(DbSeek( cCodi ))
					Vendedor->ComissaoS += nValor
					Funcimov->(DbAppend())
					Funcimov->Codiven   := cCodi
					Funcimov->Cre		  := nValor
					Funcimov->Comissao  := Funcimov->Comissao + nValor
					Funcimov->Descricao := "COM SOB PRODUCAO REF " + Dtoc( dIni ) + " A " + Dtoc( dFim )
					Funcimov->Data 	  := dFim
					Funcimov->Docnr	  := Left(StrTran(Time(),":"),5 ) + cCodi
				EndIF
				Movi->(Libera())
				Vendedor->(DbSeek( cCodi ) )
				Vendedor->(DbSkip(1))
			Enddo
			Movi->(Libera())
			Vendedor->(Libera())
			Funcimov->(Libera())
		EndIF
   EndCase
EndDo

Proc ReciboFuncionario( cDocnr )
********************************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL Larg	  := 80
LOCAL Vlr_Dup := 0
LOCAL nUrv	  := 1
LOCAL nLinhas := 3
FIELD Codiven
FIELD Docnr
FIELD Deb
FIELD Cre

Vendedor->(Order( VENDEDOR_CODIVEN ))
Area("Funcimov")
Funcimov->(Order( FUNCIMOV_DOCNR ))
Set Rela To Codiven Into Vendedor
Funcimov->(DbGoTop())
IF cDocnr = NIL
	MaBox( 18, 20, 20, 43 )
	cDocnr := Space( Len( Docnr )-2 )
	@ 19, 21 Say "Docto N§...:" Get cDocnr Pict "@!" Valid DocFuErrado( @cDocnr )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIf
EndIF
Funcimov->(DbSeek( cDocNr ))
IF !InsTru80()
	ResTela( cScreen )
	Return
EndIF
PrintOn()
SetPrc(0,0)
Vlr_Dup := Extenso( Deb, nUrv, nLinhas, Larg )
Write( 00, 00, GD + Padc( "RECIBO",40))
Write( 02, 00, NG + "N§ " + NR + Docnr )
Write( 02, 50, NG + "R$: " + NR + Trim(Tran( Deb, "@E 99,999,999.9999")))
Write( 04, 00, NG + "Recebi(emos) de: " + NR + XNOMEFIR )
Write( 06, 00, NG + "A importancia por extenso abaixo relacionada:" + NR )
Write( 07, 00, Left( Vlr_Dup, Larg ) )
Write( 08, 00, SubStr( Vlr_Dup, Larg + 1, Larg ) )
Write( 09, 00, Right( Vlr_Dup, Larg ) )
Write( 11, 00, NG + "Referente a: " + NR + Funcimov->Descricao )
Write( 13, 00, DataExt( Date()))
Write( 15, 00, "Assinatura:_________________________________________")
Write( 16, 11, Vendedor->Nome )
__Eject()
PrintOff()
Funcimov->(DbClearRel())
Funcimov->(DbGoTop())
ResTela( cScreen )
Return

Proc FechaDebito()
******************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL aMenu   := {'Individual', 'Geral'}
LOCAL nChoice := 1
LOCAL cCodi
LOCAL dFim
LOCAL nItens
LOCAL nValor
FIELD Codiven
FIELD Data

WHILE OK
   oMenu:Limpa()
   M_Title('FECHAMENTO DEBITO')
   nChoice := FazMenu( 07, 16, aMenu )
   Do Case
   Case nChoice = 0
		ResTela( cScreen )
      Return

   Case nChoice = 1
		cCodi := Space( 04 )
		dFim	:= Date()
		MaBox( 14, 16, 17, 42 )
      @ 15, 17 Say "Codigo........:" Get cCodi Pict "9999" Valid FunciErrado( @cCodi )
      @ 16, 17 Say "Data..........:" Get dFim  Pict "##/##/##"
		Read
		IF LastKey() = ESC
         Loop
		EndIF
		IF Conf("Pergunta: Confirma Lancamento Debito Individual ?")
			oMenu:Limpa()
			IF Vendedor->(TravaArq())
				IF Funcimov->(!TravaArq())
					Vendedor->(Libera())
					Loop
				EndIF
			EndIF
			Mensagem(" Aguarde...", Cor())
			Vendedor->( Order( VENDEDOR_CODIVEN ))
			Vendedor->(DbSeek( cCodi ))
			nValor := Vendedor->ComissaoS
			IF nValor > 0
				Vendedor->ComissaoS := 0
				Area("Funcimov")
				Funcimov->(DbAppend())
				Funcimov->Codiven   := cCodi
				Funcimov->Deb		  := nValor
            Funcimov->Comissao  -= nValor
				Funcimov->Descricao := "PAGAMENTO DE SALARIO"
				Funcimov->Data 	  := dFim
				Funcimov->Docnr	  := Left(StrTran(Time(),":"),5 ) + cCodi
			Else
				ErrorBeep()
				Alerta("Saldo Esta Negativo ou Zerado...")
			EndIF
			Vendedor->(Libera())
			Funcimov->(Libera())
      EndIF

   Case nChoice = 2
		dFim	:= Date()
		MaBox( 14, 16, 16, 42 )
		@ 15, 17 Say "Data..........:" Get dFim Pict "##/##/##"
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		IF Conf("Pergunta: Confirma Lancamento Debito Geral ?")
			IF Vendedor->(TravaArq())
				IF Funcimov->(!TravaArq())
					Vendedor->(Libera())
					Loop
				EndIF
			EndIF
			Mensagem(" Aguarde...", Cor())
			Vendedor->( Order( VENDEDOR_CODIVEN ))
			Vendedor->(DbGoTop())
			While Vendedor->(!Eof())
				nValor := Vendedor->ComissaoS
				cCodi  := Vendedor->Codiven
				IF nValor > 0
					Vendedor->ComissaoS := 0
					Area("Funcimov")
					Funcimov->(DbAppend())
					Funcimov->Codiven   := cCodi
					Funcimov->Deb		  := nValor
               Funcimov->Comissao  -= nValor
					Funcimov->Descricao := "PAGAMENTO DE SALARIO"
					Funcimov->Data 	  := dFim
					Funcimov->Docnr	  := Left(StrTran(Time(),":"),5 ) + cCodi
            EndIF
            Vendedor->(DbSeek( cCodi ) )
            Vendedor->(DbSkip(1))
         Enddo
         Vendedor->(Libera())
         Funcimov->(Libera())
      EndIF
   EndCase
EndDo

Proc AjusTabInd()
******************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL nConta	 := 0
LOCAL cCodi

WHILE OK
	oMenu:Limpa()
	Area("Cortes")
	Cortes->(Order( CORTES_TABELA ))
	MaBox( 15, 10, 17, 31 )
   cCodi := Space(08)
   @ 16, 11 Say "Tabela..:" Get cCodi Pict "9999.999" Valid CortesErr( @cCodi )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIF
	Mensagem("Aguarde, Processando.", Cor())
	Area("Movi")
	Movi->(Order( MOVI_TABELA ))
	IF Movi->(!DbSeek( cCodi ))
		Cortes->(Order( CORTES_TABELA ))
		IF Cortes->(DbSeek( cCodi ))
			IF Cortes->(TravaReg())
				Cortes->Sobra := Cortes->Qtd
				Cortes->(Libera())
				Loop
			EndIF
		EndIF
	EndIF
	nConta := 0
	WHILE Movi->Tabela = cCodi
		nConta += Movi->Qtd
		Movi->(DbSkip(1))
	EndDo
	Cortes->(Order( CORTES_TABELA ))
	IF Cortes->(DbSeek( cCodi ))
		IF Cortes->(TravaReg())
			Cortes->Sobra := IF( nConta = 0, Cortes->Qtd, Cortes->Qtd - nConta )
			Cortes->(Libera())
			Loop
		EndIF
	EndIF
EndDo

Proc AjusTabGer()
*****************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL nConta	 := 0
LOCAL cTabela
LOCAL nTotal

oMenu:Limpa()
IF Conf("O Ajuste podera demorar. Continua ?")
	Mensagem("Aguarde, Processando.", Cor())
	Area("Cortes")
	Cortes->(Order( CORTES_TABELA ))
	Cortes->(DbGoTop())
	WHILE Cortes->(!Eof())
		cTabela := Cortes->Tabela
		nTotal  := Cortes->Qtd
		nConta  := 0
		Movi->(DbSeek( cTabela ))
		WHILE Movi->Tabela = cTabela
			nConta += Movi->Qtd
			Movi->(DbSkip(1))
		EndDo
		IF Cortes->(TravaReg())
			Cortes->Sobra := ( nTotal - nConta )
			Cortes->(Libera())
		EndIF
		Cortes->(DbSkip(1))
	EndDo
	Alerta("Informa: Ajuste Completado.")
EndIF
ResTela( cScreen )
Return

Proc BrowseFuncionario()
************************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
Area("Vendedor")
Vendedor->(Order( VENDEDOR_NOME ))
Vendedor->(DbGoTop())
oBrowse:Add( "CODIGO", "Codiven")
oBrowse:Add( "NOME",   "Nome")
oBrowse:Titulo := "CONSULTA/ALTERACAO/EXCLUSAO DE FUNCIONARIOS"
oBrowse:PreDoGet := {|| PreGetFuncionario( oBrowse ) } // Rotina do Usuario Antes de Atualizar
oBrowse:PosDoGet := NIL
oBrowse:PreDoDel := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Function PreGetFuncionario( oBrowse )
*************************************
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )

Do Case
Case oCol:Heading = "CODIGO"
	ErrorBeep()
	Alerta("Erro: Alteracao nao permitida")
	Return( FALSO )
Otherwise
EndCase
Return( OK )

Proc BrowseServico()
********************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
Area("Servico")
Servico->(Order( SERVICO_NOME ))
Servico->(DbGoTop())
oBrowse:Add( "CODIGO",   "CodiSer", '9999')
oBrowse:Add( "NOME",     "Nome", '@!')
oBrowse:Add( "VALOR",    "Valor", "@E 999,999,999.9999")
oBrowse:Titulo   := "CONSULTA/ALTERACAO/EXCLUSAO DE SERVICOS"
oBrowse:PreDoGet := {|| PreGetServico( oBrowse ) } // Rotina do Usuario Antes de Atualizar
oBrowse:PosDoGet := NIL
oBrowse:PreDoDel := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Function PreGetServico( oBrowse )
*********************************
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )

Do Case
Case oCol:Heading = "CODIGO"
	ErrorBeep()
	Alerta("Erro: Alteracao nao permitida")
	Return( FALSO )
Otherwise
EndCase
Return( OK )

Proc TotalMovi()
****************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL aMenu 	 := {"Por Periodo", "Geral"}
LOCAL nChoice	 := 0
LOCAL nItens
LOCAL dIni
LOCAL dFim
FIELD Data

WHILE OK
	oMenu:Limpa()
	M_Title("REL QUANTITATIVO")
   nChoice := FazMenu( 11, 16, aMenu )
   Do Case
   Case nChoice = 0
      ResTela( cScreen )
      Return

	Case nChoice = 1
		dIni := Date() - 30
		dFim := Date()
		MaBox( 17, 16, 20, 43 )
		@ 18, 17 Say "Data Inicial...:" Get dIni Pict "##/##/##"
		@ 19, 17 Say "Data Final.....:" Get dFim Pict "##/##/##"
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		Area("Movi")
		Movi->(Order( MOVI_DATA ))
		Sx_ClrScope( S_TOP )
		Sx_ClrScope( S_BOTTOM )
		Sx_SetScope( S_TOP, dIni )
		Sx_SetScope( S_BOTTOM, dFim )
		Mensagem('Aguarde, Filtrando.')
		Movi->(DbGoTop())
		IF Sx_KeyCount() == 0
         Sx_ClrScope( S_TOP )
         Sx_ClrScope( S_BOTTOM )
			Nada()
			Loop
		EndIF
		TotalRel( dIni, dFim )
		Sx_ClrScope( S_TOP )
		Sx_ClrScope( S_BOTTOM )
		Movi->(DbGoTop())

    Case nChoice = 2
		 Area("Movi")
		 Movi->(Order( MOVI_TABELA ))
		 Movi->(DbGoTop())
		 IF Movi->(Eof())
			 Nada()
			 Loop
		 EndIF
		 TotalRel()
		 Sx_ClrScope( S_TOP )
		 Sx_ClrScope( S_BOTTOM )
		 Movi->(DbGoTop())
	EndCase
EndDo

Proc TotalRel( dIni, dFim )
***************************
LOCAL cScreen		:= SaveScreen()
LOCAL MouseList	:= {}
LOCAL Tam			:= 80
LOCAL Row			:= 58
LOCAL Pagina		:= 0
LOCAL nTotalFolha := 0
LOCAL nQtdPecas	:= 0
LOCAL nTotalVlr	:= 0
LOCAL nTotalPcs	:= 0
LOCAL lSair 		:= FALSO
LOCAL dData 		:= Data
LOCAL UltTabela	:= Left( Tabela, 4 )
LOCAL nTotPecas	:=  0
LOCAL Tecla
LOCAL NovoCodi
LOCAL Relato
LOCAL nDecisao
FIELD Data
FIELD Tabela
FIELD Qtd

IF dIni != Nil
  Relato := "RELATORIO QUANTITATIVO DO MOVIMENTO REF. " + Dtoc( dIni ) + ' A ' + dToc( dFim )
Else
  Relato := "RELATORIO QUANTITATIVO GERAL DO MOVIMENTO"
EndIF
IF !Instru80()
	ResTela( cScreen )
	Return
EndIF
Mensagem("Aguarde, Imprimindo.")
PrintOn()
SetPrc( 0, 0 )
WHILE !Eof() .AND. Rel_Ok()
	IF Row >=  58
		Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
		Write( 01, 00, Date() )
		Write( 02, 00, Padc( XNOMEFIR, Tam ) )
		Write( 03, 00, Padc( SISTEM_NA7, Tam ) )
		Write( 04, 00, Padc( Relato, Tam ) )
		Write( 05, 00, Repl( SEP, Tam ) )
		Row := 6
	EndIF
	IF Row = 6
		Write( Row++, 00,"DATA     TABELA                                                            QUANT " )
		Write( Row++, 00, Repl( SEP, Tam ) )
	EndIF
	WHILE Eval( {|| Left( Tabela, 4 ) = UltTabela } )
		nQtdPecas	+= Qtd
		nTotPecas	+= Qtd
		nTotalFolha += Qtd
		dData 		:= Data
		Movi->(DbSkip(1))
	EndDo
	Write( Row++, 0, Dtoc( dData )  + "   " + UltTabela + Space( 60 ) + Tran( nQtdPecas, "99999" ) )
	UltTabela := Left( Tabela, 4 )
	nQtdPecas := 0
	IF Row >= 57
		Write( Row++, 57," ** SubTotal *** " + Tran( nTotalFolha, "999999" ) )
		nTotalFolha := 0
		Row			:= 58
		__Eject()
	 EndIf
EndDo
Write( ++Row, 57," ** SubTotal *** " + Tran( nTotalFolha, "999999" ) )
Write( ++Row, 54," ** Total Geral *** " + Tran( nTotPecas, "999999" ) )
__Eject()
PrintOff()
ResTela( cScreen )
Return

Proc RolFuncionario()
*********************
LOCAL GetList	 := {}
LOCAL MouseList := {}
LOCAL cScreen	 := SaveScreen()
LOCAL aMenu 	 := {"Individual", "Geral"}
LOCAL oBloco
LOCAL nChoice
LOCAL cCodi

WHILE OK
	M_Title("RELATORIO DE FUNCIONARIOS")
	nChoice := FazMenu( 07, 16, aMenu, Cor())
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1
		Area("Vendedor")
		cCodi := Space( 04 )
		MaBox( 13, 16, 15, 79 )
		@ 14, 17 Say "Codigo.:" Get cCodi Valid FunciErrado( @cCodi, Row(), Col()+1 )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Area("Vendedor")
		oBloco := {|| Vendedor->Codiven = cCodi }
		Funcionarios( oBloco )
		ResTela( cScreen )
		Loop

	Case nChoice = 2
		Area("Vendedor")
		Vendedor->(DbGoTop())
		oBloco := {|| Vendedor->(!Eof()) }
		Funcionarios( oBloco )
		ResTela( cScreen )
		Loop

	EndCase
EndDo

Proc Funcionarios( oBloco )
***************************
LOCAL cScreen := SaveScreen()
LOCAL Tam	  := 80
LOCAL Col	  := 58
LOCAL Pagina  := 0
FIELD Codiven
FIELD Nome
FIELD Cpf
FIELD Rg
FIELD Ende
FIELD Bair
FIELD Cep
FIELD Cida
FIELD Esta

IF !Instru80()
	ResTela( cScreen )
	Return
EndIf
PrintOn()
SetPrc( 0, 0 )
WHILE Eval( oBloco ) .AND. REL_OK()
	IF Col >= 58
		Write( 00, 00, Linha1( Tam, @Pagina))
		Write( 01, 00, Linha2())
		Write( 02, 00, Linha3(Tam))
		Write( 03, 00, Linha4(Tam, SISTEM_NA7 ))
		Write( 04, 00, Padc( "RELATORIO DE FUNCIONARIOS", Tam ) )
		Write( 05, 00, Linha5(Tam))
		Write( 06, 00,"CODI         NOME FUNCIONARIO")
		Write( 07, 00, Linha5(Tam))
		Col := 8
	Endif
   Write(   Col, 00, NG + Codiven + " " + Nome + NR )
	Write( ++Col, 05, Cpf  + Space( 10 ) + Rg)
	Write( ++Col, 05, Ende + " " + Bair )
	Write( ++Col, 05, Cep  + "/" + AllTrim( Cida ) + "-" + Esta )
	Col += 2
	IF Col >= 57
		Write( Col, 0,  Repl( SEP, Tam ) )
		Col := 58
		__Eject()
	EndIf
	DbSkip(1)
EndDo
__Eject()
PrintOff()
Return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc GrpSerInc()
****************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL cGrupo    := Space(03)
LOCAL cDesGrupo := Space(40)
LOCAL lSair     := FALSO
LOCAL nEscolha  := 0
FIELD Grupo
FIELD DesGrupo

cScreen := SaveScreen()
WHILE OK
	oMenu:Limpa()
   cGrupo    := Space(03)
	cDesGrupo := Space(40)
	lSair 	 := FALSO
	Area("GrpSer")
	GrpSer->(Order( GRPSER_GRUPO ))
	GrpSer->(DbGoBottom())
   cGrupo = GrpSer->(StrZero( Val( Grupo ) + 1, 3))
	WHILE OK
		MaBox( 06, 02, 09, 78, "INCLUSAO DE NOVOS GRUPOS" )
      @ 07, 03 Say "Grupo.....:" Get cGrupo     Pict "999"  Valid GrpSerCerto( @cGrupo )
		@ 08, 03 Say "Descricao.:" Get cDesGrupo  Pict "@!"  Valid !Empty( cDesGrupo )
		Read
		IF LastKey() = ESC
			lSair := OK
			Exit
		EndIf
		ErrorBeep()
		nEscolha := Alerta("Pergunta: Voce Deseja ? ", {" Incluir "," Alterar "," Sair " })
		IF nEscolha = 1
			Area("GrpSer")
			IF GrpSerCerto( @cGrupo )
				IF GrpSer->(Incluiu())
					GrpSer->Grupo	  := cGrupo
					GrpSer->DesGrupo := cDesGrupo
					Servico->(Libera())
               cGrupo := Strzero( Val( cGrupo ) + 1, 3 )
				EndIf
		  EndIf

		ElseIF nEscolha = 2
			Loop

		ElseIF nEscolha = 3
			lSair := OK
			Exit

		EndIF
	EndDo
	IF lSair
		ResTela( cScreen )
		Exit

	EndIf
Enddo

Function GrpSerCerto( cGrupo )
******************************
LOCAL Ind_Ant := IndexOrd()
LOCAL Arq_Ant := Alias()

IF Empty( cGrupo)
	ErrorBeep()
	Alerta("Erro: Codigo Grupo Invalido." )
	Return( FALSO )
EndIF
Area( "GrpSer" )
IF ( GrpSer->( Order( GRPSER_GRUPO )), GrpSer->(DbSeek( cGrupo )))
	ErrorBeep()
	Alerta("Erro: Codigo Grupo Registrado." )
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Proc GrpSerAlt()
****************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
Area("GrpSer")
GrpSer->(Order( GRPSER_DESGRUPO ))
GrpSer->(DbGoTop())
oBrowse:Add( "GRUPO",     "Grupo")
oBrowse:Add( "DESCRICAO", "DesGrupo")
oBrowse:Titulo := "CONSULTA/ALTERACAO/EXCLUSAO DE GRUPOS"
oBrowse:PreDoGet := NIL
oBrowse:PosDoGet := NIL
oBrowse:PreDoDel := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )
Return

Function GrpSerErrado( cGrupo, nCol, nRow )
*******************************************
LOCAL aRotina := {{|| GrpSerInc() }}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
FIELD Grupo
FIELD DesGrupo

IF ( GrpSer->(Order( GRPSER_GRUPO )), GrpSer->(!DbSeek( cGrupo )))
	GrpSer->(Order( GRPSER_DESGRUPO ))
	GrpSer->(Escolhe( 00, 00, 24, "Grupo + '³' + DesGrupo", "GRUPO DESCRICAO ", aRotina ))
EndIF
cGrupo := GrpSer->Grupo
IF nCol != Nil
	Write( nCol, nRow, GrpSer->Desgrupo )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

*:==================================================================================================================================

Proc GrpSerPri()
****************
LOCAL cScreen := SaveScreen()
LOCAL Tam	  := 80
LOCAL Col	  := 58
LOCAL Pagina  := 0

IF !Instru80()
	ResTela( cScreen )
	Return
EndIf
PrintOn()
SetPrc( 0, 0 )
Area("GrpSer")
GrpSer->(Order( GRPSER_DESGRUPO ))
GrpSer->(DbGoTop())
WHILE GrpSer->(!Eof()) .AND. REL_OK()
	IF Col >= 58
		Write( 00, 00, Linha1( Tam, @Pagina))
		Write( 01, 00, Linha2())
		Write( 02, 00, Linha3(Tam))
		Write( 03, 00, Linha4(Tam, SISTEM_NA7 ))
		Write( 04, 00, Padc( "RELATORIO DE GRUPOS", Tam ) )
		Write( 05, 00, Linha5(Tam))
		Write( 06, 00,"CODI DESCRICAO DO GRUPO")
		Write( 07, 00, Linha5(Tam))
		Col := 8
	Endif
   Qout( GrpSer->Grupo, ' ', GrpSer->DesGrupo )
	Col++
	IF Col >= 57
		Write( Col, 0,  Repl( SEP, Tam ) )
		Col := 58
		__Eject()
	EndIf
	GrpSer->(DbSkip(1))
EndDo
__Eject()
PrintOff()
Return

*:==================================================================================================================================

Function oMenuScpLan()
**********************
LOCAL AtPrompt := {}
LOCAL cStr_Get
LOCAL cStr_Sombra

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
AADD( AtPrompt, {"Sair",        {"Encerrar Sessao"}})
AADD( AtPrompt, {"Funcionario", {"Inclusao","Alteracao","Exclusao","Consulta","Relatorio"}})
AADD( AtPrompt, {"Grupo",       {"Inclusao","Alteracao","Exclusao","Consulta","Relatorio"}})
AADD( AtPrompt, {"Servico",     {"Inclusao","Alteracao","Exclusao","Consulta","Relatorio"}})
AADD( AtPrompt, {"Producao",    {"Inclusao","Alteracao","Exclusao","Consulta","Relatorio"}})
AADD( AtPrompt, {"Movimento",   {"Inclusao","Alteracao","Exclusao","Consulta","Relatorio"}})
AADD( AtPrompt, {"Relatorio",   {"Funcionarios","Servicos","Producao","Movimento","Posicao Financeira","Quantitativo Movimento","Saldos","Recibo", "Grupos"}})
Aadd( AtPrompt, {"Consulta",    {"Funcionarios","Servicos","Movimento", "Producao", "Saldos", "Debitos/Creditos", "Grupos"}})
Aadd( AtPrompt, {"Lancamento",  {"Debitos/Creditos", "Fechamento Mes", "Debitos Mes", "Ajuste Tabela Individual", "Ajuste Tabela Geral"}})
Return( AtPrompt )

*:==================================================================================================================================

Function aDispScpLan()
**********************
LOCAL oScpLan  := TIniNew(oAmbiente:xUsuario + ".INI")
LOCAL AtPrompt := oMenuScpLan()
LOCAL nMenuH   := Len(AtPrompt)
LOCAL aDisp 	:= Array( nMenuH, 22 )
LOCAL aMenuV   := {}

// IF !aPermissao[SCI_CONTROLE_DE_PRODUCAO]
	// Return( aDisp )
// EndIF

Mensagem("Aguarde, Verificando Diretivas do CONTROLE DE PRODUCAO.")
Return( aDisp := ReadIni("scplan", nMenuH, aMenuV, AtPrompt, aDisp, oScpLan))



