/*
  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 İ³																								 ³
 İ³	Programa.....: TESTE1LA.PRG														 ³
 İ³	Aplicacaoo...: SISTEMA DE CONTROLE DE ESTOQUE								 ³
 İ³	Versao.......: 19.50 																 ³
 İ³	Programador..: Vilmar Catafesta													 ³
 İ³   Empresa......: Microbras Com de Prod de Informatica Ltda              ³
 İ³	Inicio.......: 12 de Novembro de 1991. 										 ³
 İ³	Ult.Atual....: 06 de Dezembro de 1998. 										 ³
 İ³	Compilacao...: Clipper 5.02														 ³
 İ³	Linker.......: Blinker 3.20														 ³
 İ³	Bibliotecas..: Clipper/Funcoes/Mouse/Funcky15/Funcky50/Classe/Classic ³
 İÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#include   <sci.ch>

Proc FormaRelatorio()
*********************
LOCAL cScreen := SaveScreen()
LOCAL Tam	  := CPI1280
LOCAL Col	  := 58
LOCAL Pagina  := 0

if !InsTru80() .OR. !LptOk()
	ResTela( cScreen )
	return
endif

Area("Forma")
Forma->(Order( FORMA_FORMA ))
Forma->(DbGoTop())
Mensagem("Aguarde, Imprimindo", WARNING )
PrintOn()
FPrint( _CPI12 )
WHILE !Eof() .AND. Rel_Ok()
	if Col >= 58
		Write( 00, 00, Linha1( Tam, @Pagina))
		Write( 01, 00, Linha2())
		Write( 02, 00, Linha3(Tam))
		Write( 03, 00, Linha4(Tam, SISTEM_NA2 ))
		Write( 04, 00, Padc( "LISTAGEM DE FORMAS DE PAGAMENTO",Tam ) )
		Write( 05, 00, Linha5(Tam))
		Write( 06, 00, "ID CONDICOES DE PAGTO                        DESCRICAO                               COMISSAO")
		Write( 07, 00, Linha5(Tam))
		Col := 8
	endif
	Forma->(Qout( Forma, Condicoes, Descricao, Str( Comissao, 5,2 )))
	Col++
	if Col >= 58 .OR. Eof()
		Write( Col, 0,  Repl( SEP, Tam ))
		__Eject()
	endif
	Forma->(DbSkip(1))
EndDo
PrintOff()
ResTela( cScreen )
return

Proc IniPequena()
*****************
PrintOn()
FPrint( RESETA 	) // Inicializar Impressora
FPrint( _SALTOOFF ) // Inibir Salto de Picote
FPrint( PQ			) // Condensado
return

Function MostraCodigo( cCodiIni, nCol, nRow)
********************************************
LOCAL aRotina          := {{||InclusaoProdutos() }}
LOCAL aRotinaAlteracao := {{||InclusaoProdutos(OK) }}
LOCAL Arq_Ant          := Alias()
LOCAL Ind_Ant          := IndexOrd()

cCodiIni := StrCodigo( cCodiIni )
Area("Lista")
Lista->(Order( LISTA_CODIGO ))
if !DbSeek( cCodiIni )
	Lista->(Order( LISTA_DESCRICAO ))
   Escolhe( 03, 01, 22,"Codigo + 'º' + Descricao + 'º' + Sigla","CODIG DESCRICAO DO PRODUTO                     SIGLA", aRotina,,aRotinaAlteracao )
	cCodiIni := Codigo
endif
Write( nCol, nRow, Descricao )
AreaAnt( Arq_Ant, Ind_Ant )
return( OK )

Proc GraficoVenda()
*******************
LOCAL cScreen := SaveScreen()
LOCAL MilharesCruzeiros := 1
LOCAL M[12,2]
LOCAL aDataIni
LOCAL aDataFim
LOCAL nConta
PRIVA cAno := Space(02)

MaBox( 10, 10, 12, 42 )
@ 11, 11 Say "Grafico de Vendas do Ano :" Get cAno Pict "99"
Read
if LastKey() = ESC
	Restela( cScreen )
	return
endif
oMenu:Limpa()
Area("Saidas")
Saidas->(Order(SEIS)) // Emissao
Saidas->(DbGoTop())
aDataIni := { Ctod( "01/01/" + cAno ), Ctod( "01/02/" + cAno ), Ctod( "01/03/" + cAno ),;
				  Ctod( "01/04/" + cAno ), Ctod( "01/05/" + cAno ), Ctod( "01/06/" + cAno ),;
				  Ctod( "01/07/" + cAno ), Ctod( "01/08/" + cAno ), Ctod( "01/09/" + cAno ),;
				  Ctod( "01/10/" + cAno ), Ctod( "01/11/" + cAno ), Ctod( "01/12/" + cAno ) }

aDataFim := {Ctod( "31/01/" + cAno ), Ctod( "28/02/" + cAno ), Ctod( "31/03/" + cAno ),;
				 Ctod( "30/04/" + cAno ), Ctod( "31/05/" + cAno ), Ctod( "30/06/" + cAno ),;
				 Ctod( "31/07/" + cAno ), Ctod( "31/08/" + cAno ), Ctod( "30/09/" + cAno ),;
				 Ctod( "31/10/" + cAno ), Ctod( "30/11/" + cAno ), Ctod( "31/12/" + cAno )}

Mensagem( "Aguarde... Calculando Valores.", WARNING )
nTotal	 := 0
For nX := 1 To 12
	 M[nX,1] := 0
Next
Set Soft On
DbSeek( aDataIni[1])
Set Soft Off
WHILE !Eof() .AND. ( nAno := Right(StrZero(Year( Emis ),4),2)) = cAno .AND. Rep_Ok()
	 if nAno != cAno
		 DbSkip()
		 Loop
	endif
	nMes			:= Month( Emis )
	cMes			:= StrZero( nMes,2)
	M[ nMes, 1] += ( Pvendido * Saida )
	DbSkip()
EndDO
M[1,2]="JAN" ; M[2,2]="FEV" ; M[3,2]="MAR" ; M[4,2]="ABR" ; M[5,2]="MAI" ; M[6,2]="JUN"
M[7,2]="JUL" ; M[8,2]="AGO" ; M[9,2]="SET" ; M[10,2]="OUT"; M[11,2]="NOV" ; M[12,2]="DEZ"

SetColor("")
Cls
Grafico( M,.T., "EVOLUCAO MENSAL DAS VENDAS  - &cAno.","EM MILHARES",;
				 XNOMEFIR, 1000 )
Inkey(0)
ResTela( cScreen )
return

Proc GraficoCompra()
********************
LOCAL cScreen := SaveScreen()
LOCAL MilharesCruzeiros := 1
LOCAL M[12,2]
LOCAL aDataIni
LOCAL aDataFim
LOCAL nConta
PRIVA cAno := Space(02)
MaBox( 10, 10, 12, 42 )
@ 11, 11 Say "Grafico de Compra do Ano :" Get cAno Pict "99"
Read
if LastKey() = ESC
	Restela( cScreen )
	return
endif
oMenu:Limpa()
Area("Entradas")
Entradas->(Order(TRES)) // Emissao
Entradas->(DbGoTop())
aDataIni := { Ctod( "01/01/" + cAno ), Ctod( "01/02/" + cAno ), Ctod( "01/03/" + cAno ),;
				  Ctod( "01/04/" + cAno ), Ctod( "01/05/" + cAno ), Ctod( "01/06/" + cAno ),;
				  Ctod( "01/07/" + cAno ), Ctod( "01/08/" + cAno ), Ctod( "01/09/" + cAno ),;
				  Ctod( "01/10/" + cAno ), Ctod( "01/11/" + cAno ), Ctod( "01/12/" + cAno ) }

aDataFim := {Ctod( "31/01/" + cAno ), Ctod( "28/02/" + cAno ), Ctod( "31/03/" + cAno ),;
				 Ctod( "30/04/" + cAno ), Ctod( "31/05/" + cAno ), Ctod( "30/06/" + cAno ),;
				 Ctod( "31/07/" + cAno ), Ctod( "31/08/" + cAno ), Ctod( "30/09/" + cAno ),;
				 Ctod( "31/10/" + cAno ), Ctod( "30/11/" + cAno ), Ctod( "31/12/" + cAno )}

Mensagem( "Aguarde... Calculando Valores.", WARNING )
nTotal	 := 0
For nX := 1 To 12
	 M[nX,1] := 0
Next
Set Soft On
DbSeek( aDataIni[1])
Set Soft Off
WHILE !Eof() .AND. ( nAno := Right(StrZero(Year( Data ),4),2)) = cAno .AND. Rep_Ok()
	 if nAno != cAno
		 DbSkip()
		 Loop
	endif
	nMes			:= Month( Data )
	cMes			:= StrZero( nMes,2)
	M[ nMes, 1] += ( Pcusto * Entrada )
	DbSkip()
EndDO
oMenu:Limpa()
M[1,2]="JAN" ; M[2,2]="FEV" ; M[3,2]="MAR" ; M[4,2]="ABR" ; M[5,2]="MAI" ; M[6,2]="JUN"
M[7,2]="JUL" ; M[8,2]="AGO" ; M[9,2]="SET" ; M[10,2]="OUT"; M[11,2]="NOV" ; M[12,2]="DEZ"

SetColor("")
Cls
Grafico( M,.T., "EVOLUCAO MENSAL DAS COMPRAS  - &cAno.","EM MILHARES",;
			XNOMEFIR, 1000 )
Inkey(0)
ResTela( cScreen )
return

Proc DebitoValor()
******************
LOCAL cScreen		:= SaveScreen()
LOCAL nSubTotal	:= 0
LOCAL nTotal		:= 0
LOCAL nSobra		:= 0
LOCAL nJuro 		:= 0
LOCAL nSubJuros	:= 0
LOCAL nTotalJuros := 0
LOCAL dIni			:= Date()-30
LOCAL dFim			:= Date()

oMenu:Limpa()
WHILE OK
	MaBox( 10, 10, 14, 40 )
	@ 11, 11 Say "Taxa Juros Mes : " Get nJuro Pict "99.99"
	@ 12, 11 Say "Data Inicial...: " Get dIni  Pict PIC_DATA
	@ 13, 11 Say "Data Final.....: " Get dFim  Pict PIC_DATA
	Read
	if LastKey() = ESC
		Saidas->(DbClearRel())
		ResTela( cScreen )
		Exit
	endif
	Lista->(Order(2))
	Area("Saidas")
	Set Rela To Codigo Into Lista
	Order(7) // Codigo Cliente
	Saidas->(DbGotop())
	nSubTotal	:= 0
	nTotal		:= 0
	nSobra		:= 0
	nTotalJuros := 0
	cTela := Mensagem(" Aguarde... Verificando Movimento.", Cor())
	WHILE !Eof() .AND. Rep_OK()
		if !Saidas->c_c  // Movimento nao eh conta corrente ?
			Saidas->(DbSkip(1))
			Loop
		endif
		if Saidas->Saida = Saidas->SaidaPaga
			Saidas->(DbSkip(1))
			Loop
		endif
		if Saidas->Data < dIni .OR. Saidas->Data > dFim
			Saidas->(DbSkip(1))
			Loop
		endif
		nSobra	:= ( Saidas->Saida - Saidas->SaidaPaga )
		nConta	:= Pvendido * nSobra
		nJurodia := 0
		nJdia 	:= 0
		nAtraso	:= 0
		nAtraso := ( Date() - Data ) - 30
		if nAtraso > 1
			nJdia 	  := JuroDia( nConta, nJuro )
			nJuroDia   := ( nJdia * nAtraso )
		endif
		nTotal		+= nConta
		nTotalJuros += nConta + nJurodia
		Saidas->(DbSkip(1))
	EndDo
	ResTela( cTela )
	Alert("Total.....: " + Tran( nTotal,      "@E 99,999,999.99") + ;
			";Com Juros.: " + Tran( nTotalJuros, "@E 99,999,999.99"))
	ResTela( cScreen )
EndDo

Function AchaDocEntrada( cDocnr )
*********************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Entradas->(Order(DOIS))
if Entradas->(!DbSeek( cDocnr ))
	Entradas->(Escolhe( 03, 01, 22,"Fatura","FATURA" ))
	cDocnr := Entradas->Fatura
endif
AreaAnt( Arq_Ant, Ind_Ant )
return( OK )

Proc ProdutosPorFornecedor()
****************************
LOCAL cScreen	  := SaveScreen()
LOCAL aMenuArray := { " Ordem Numerica ", " Ordem Alfabetica ", " Ordem Cod. Fabr " }
LOCAL aTotalParc := { " Total  ", " Parcial    ", " Por Fabricante ", " Por Grupo ", " Por SubGrupo", " Entradas Por Data" }
LOCAL cCodiIni
LOCAL cCodifim
LOCAL cGrupoIni
LOCAL cGrupoFim
LOCAL cSubFim
LOCAL cSubIni
LOCAL cForn
LOCAL nOrder
LOCAL cTela1
LOCAL cTela2
LOCAL cTela3
LOCAL dDataIni
LOCAL dDataFim
WHILE OK
	M_Title("ESC Retorna")
	Codigo_Descricao := FazMenu(03,27, aMenuArray, Cor())
	if Codigo_Descricao = ZERO
		ResTela( cScreen )
		Exit
	endif
	cTela1 := SaveScreen()
	WHILE OK
		M_Title("ESC Retorna")
		Total_Parcial	  := FazMenu(05,29, aTotalParc, Cor())
		if Total_Parcial = ZERO
			ResTela( cScreen )
			Exit
		endif
		cCodiIni   := 0
		cCodifim   := 0
		cForn 	  := Space(4)
		cGrupoIni  := Space(TRES)
		cGrupoFim  := Space(TRES)
		cSubIni	  := Space(SEIS)
		cSubFim	  := Space(SEIS)
		dDataIni   := Date()
		dDataFim   := Date()
		if !Parcial( Total_Parcial, @cCodiIni, @cCodifim,;
						 @cForn, @cGrupoIni, @cGrupoFim, @cSubIni,;
						 @cSubFim, @dDataIni, @dDataFim )
				  ResTela( cTela1 )
				  Loop
		endif
		Area("Lista")
		if 	 Codigo_Descricao = 1 // Codigo
			Order(DOIS )
		elseif Codigo_Descricao = 2 // Descricao
			Order(TRES )
		elseif Codigo_Descricao = 3 // Cod Fabricante
			Order(OITO )
		endif
		nOrder := IndexOrd()
		if 	 Total_Parcial = 1 // Total
				 DbClearFilter()
		elseif Total_Parcial = 2 // Parcial
				 DbSetFilter( {|| Codigo >= cCodiIni .AND. Codigo <= cCodifim	},;
									 " Codigo >= cCodiIni .AND. Codigo <= cCodifim ")
		elseif Total_Parcial = 3 // Por Fornecedor
				 DbSetFilter({|| Codi = cForn },;
									" Codi = cForn " )
		elseif Total_Parcial = 4 // Por Grupo
				 DbSetFilter({|| CodGrupo >= cGrupoIni .AND. CodGrupo <= cGrupoFim },;
									" CodGrupo >= cGrupoIni .AND. CodGrupo <= cGrupoFim ")
		elseif Total_Parcial = 5 // Por SubGrupo
				 DbSetFilter({|| CodsGrupo >= cSubIni .AND. CodsGrupo <= cSubFim },;
									" CodsGrupo >= cSubIni .AND. CodsGrupo <= cSubFim ")
		elseif Total_Parcial = 6 // Entrada Por Data
				 DbSetFilter({|| Data >= dDataIni .AND. Data <= dDataFim },;
									" Data >= dDataIni .AND. Data <= dDataFim ")
		endif
		cTela3 := Mensagem(" Please, Aguarde...", Cor())
		DbGoTop()
		ResTela( cTela3 )
		ImprimePorFornecedor( nOrder )
		DbClearRel()
		DbClearFilter()
		DbGoTop()
		ResTela( cTela1 )
	Enddo
Enddo

Proc ImprimePorFornecedor( nIndice )
************************************
LOCAL GetList		:= {}
LOCAL cScreen		:= SaveScreen( )
LOCAL nChoice		:= 0
LOCAL nCop			:= 1
LOCAL Tam			:= CPI1280
LOCAL Col			:= 58
LOCAL Choice		:= 0
LOCAL Var			:= 0
LOCAL Var1			:= 0
LOCAL Pagina, cTitulo
MaBox( 10, 59, 12, 77 )
@ 11, 60 Say "Qtde Copias " Get nCop Pict "999" Valid nCop > 0
Read
if LastKey() = ESC
	ResTela( cScreen )
	return
endif
if !Instru80() .OR. !LptOk()
	ResTela( cScreen )
	return
endif
For I := 1 To nCop
	Pagina := 0
	Col	 := 58
	if i >= 2
		DbGoTop()
	endif
	PrintOff()
	Mensagem( "Aguarde ... Imprimindo Copia N§ " + StrZero(I,4), WARNING )
	PrintOn()
	Tam	  := 132
	FPrint( PQ )
	SetPrc( 0, 0 )
	cTitulo := "RELATORIO DE FORNECEDOR DE PRODUTOS"
	WHILE !Eof() .AND. REL_OK()
		if Col >= 56
			Write( 00, 00, Linha1(Tam, @Pagina))
			Write( 01, 00, Linha2())
			Write( 02, 00, Linha3(Tam))
			Write( 03, 00, Linha4(Tam, SISTEM_NA2 ))
			Write( 04, 00, Padc( cTitulo, Tam ) )
			Write( 05, 00, Linha5(Tam))
			Write( 06, 00, "ID   DESCRICAO DO PRODUTO                     ESTOQUE  FORNECEDOR TELEFONE       FORNECEDOR TELEFONE       FORNECEDOR TELEFONE")
			Write( 07, 00, Linha5(Tam))
			Col := 8
		endif
		Pagar->(Order(DOIS))
		Qout( Codigo, Ponto( Left(Descricao,39),39), Tran( Quant, "99999.99 "))
		Set Rela To Codi1 Into Pagar
		Pagar->(QQout( Sigla, Fone + " "))
		Lista->(DbClearRel())

		Set Rela To Codi2 Into Pagar
		Pagar->(QQout( Sigla, Fone + " "))
		Lista->(DbClearRel())

		Set Rela To Codi3 Into Pagar
		Pagar->(QQout( Sigla, Fone + " "))
		Lista->(DbClearRel())
		Col++
		DbSkip()
		if Col >= 56 .OR. Eof()
			Write( Col, 0, Repl( SEP, Tam ))
			__Eject()
		endif
	EndDo
	if !Rel_Ok()
		Exit
	endif
Next
PrintOff()
ResTela( cScreen )
return

Proc AjustaIcms()
*****************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL nTx_Icms  := 0
LOCAL cSituacao := Space(1)
LOCAL cClasse	 := Space(1)
LOCAL cTela

MaBox( 10, 10, 14, 50 )
@ 11, 11 Say "Entre com a Situacao Tributaria...:" Get cSituacao Pict "9"   Valid PickSituacao( @cSituacao )
@ 12, 11 Say "Entre com a Classificacao Fiscal..:" Get cClasse   Pict "9"   Valid PickClasse( @cClasse )
@ 13, 11 Say "Entre com a Taxa de Icms..........:" Get nTx_Icms  Pict "999" Valid PickTaxa( nTx_Icms, cClasse )
Read
if LastKey() = ESC
	return
endif
ErrorBeep()
if !Conf("Pergunta: Confirma atualizacao  ?")
	return
endif
Area("Lista")
Lista->(DbGoTop())
cTela := Mensagem("Aguarde, Atualizando.")
WHILE Lista->(!Eof())
	if Lista->Classe = cClasse
		if Lista->(TravaReg())
			Lista->Tx_Icms  := nTx_Icms
			Lista->Situacao := cSituacao
			Lista->(Libera())
		endif
	endif
	Lista->(DbSkip(1))
EndDo
ResTela( cSCreen )
return

Proc PickTaxa( nTx_Icms, cClasse )
**********************************
if LastKey() = UP
	return( OK )
endif
if nTx_Icms = 0
	ErrorBeep()
	Alerta("Erro: Taxa Invalida.")
	return( FALSO )
endif
if cClasse = "1" .OR. cClasse = "3"
	return( OK )
endif
ErrorBeep()
Alerta("Erro: Classificacao Fiscal Invalida.")
return( FALSO )

Proc Totalizado()
*****************
LOCAL cScreen		:= SaveScreen()
LOCAL Tam			:= 132
LOCAL nRegistros	:= 0
LOCAL nMediaAta	:= 0
LOCAL nMediaVar	:= 0
LOCAL nItens		:= 0
LOCAL nTotalCusto := 0
LOCAL nTotalVenda := 0

if !InsTru80()
	 ResTela( cScreen )
	 return
endif
Mensagem(" Aguarde... Imprimindo. ESC Cancela.")
PrintOn()
FPrint( PQ )
SetPrc( 0, 0 )
Write( 01, 00, Padr( "Pagina N§ 001", ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
Write( 02, 00, Date() )
Write( 03, 00, Padc( XNOMEFIR, Tam ) )
Write( 04, 00, Padc( SISTEM_NA2, Tam ) )
Write( 05, 00, Padc( "RELATORIO DA POSICAO FISICO/FINANCEIRO DO ESTOQUE",Tam ) )
Write( 06, 00, Repl( SEP, Tam ))
Write( 07, 00,"REGISTRADOS  ITENS NO ESTOQUE    TOTAL PRECO CUSTO  TOTAL PRECO VENDA    MARGEM MD ATA    MARGEM MD VAR")

Area("Lista")
Lista->(DbGoTop())
WHILE Lista->(!Eof()) .AND. Rel_Ok()
	nRegistros++
	nMediaAta	+= Lista->MarAta
	nMediaVar	+= Lista->MarVar
	nItens		+= Lista->Quant
	nTotalCusto += Lista->( Pcusto * Quant )
	nTotalVenda += Lista->( Varejo * Quant )
	Lista->(DbSkip(1))
EndDo
nMediaAta /= nRegistros
nMediaVar /= nRegistros
Qout( Tran( nRegistros, "99999999999"), Tran( nItens, "99999999999999.99"),  Trans( nTotalCusto, "@E 9,999,999,999,999.99"), Trans( nTotalVenda, "@E 999,999,999,999.99"),;
								  Trans( nMediaAta, "@E 9,999,999,999.99"),   Trans( nMediaVar, "@E 9,999,999,999.99"))
__Eject()
PrintOff()
ResTela( cScreen )
return

Proc RolRepres()
***************
LOCAL GetList	 := {}
LOCAL cScreen	  := SaveScreen( )
LOCAL aMenuArray := {" Completa Individual  "," Completa Geral ", " Parcial Individual ", " Parcial Geral " }
LOCAL aMenu 	  := {" Codigo ", " Nome " }
LOCAL nChoice
LOCAL Tecla
LOCAL Escolha
LOCAL cCodi
LOCAL aSelecionado
LOCAL oBloco

FIELD Codi
FIELD Cida
FIELD Esta
FIELD Repres

BEGIN
	oMenu:Limpa()
	M_Title("RELACAO DE REPRESENTANTES" )
	nChoice := FazMenu( 04, 10, aMenuArray, Cor())
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1
		cCodi := Space( 4 )
		MaBox( 12, 10, 14, 35 )
		@ 13, 11 Say "Codigo..:" Get cCodi Pict  "9999" Valid Represrrado( @cCodi )
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Area("Repres")
		Repres->(Order( REPRES_CODI ))
		oBloco := {|| Repres->Repres = cCodi }
		RolRepresGeral( oBloco )
		ResTela( cScreen )
		Loop

	Case nChoice = 2
		M_Title( "ORDEM DE" )
		Escolha := FazMenu( 12, 10, aMenu, Cor())
		Area("Repres")
		if( Escolha = 1, Repres->(Order( REPRES_CODI )), Repres->( Order( REPRES_NOME )))
		oBloco := {|| !Eof() }
		Repres->(DbGoTop())
		RolRepresGeral( oBloco )
		ResTela( cScreen )
		Loop

	Case nChoice = 3
		cCodi := Space( 4 )
		MaBox( 12, 10, 14, 35 )
		@ 13, 11 Say "Codigo  :" Get  cCodi Pict  "9999" Valid Represrrado( @cCodi )
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Area("Repres")
		Repres->(Order( REPRES_CODI ))
		oBloco := {|| Repres->Repres = cCodi }
		RolRepresParcial( oBloco )
		ResTela( cScreen )
		Loop

	Case nChoice = 4
		M_Title( "ORDEM DE" )
		Escolha := FazMenu( 12, 10, aMenu, Cor())
		Area("Repres")
		if( Escolha = 1, Repres->(Order( REPRES_CODI )), Repres->( Order( REPRES_NOME )))
		oBloco := {|| !Eof() }
		Repres->(DbGoTop())
		RolRepresParcial( oBloco )
		ResTela( cScreen )

	EndCase
EndDo

Proc RolRepresGeral( oBloco )
*****************************
LOCAL cScreen := SaveScreen()
LOCAL Titulo
LOCAL Tam	  := 80
LOCAL Col	  := 60
LOCAL Pagina  := 0
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
FIELD Obs
FIELD Insc
FIELD Cpf

oMenu:Limpa()
Titulo := "LISTAGEM DE REPRESENTANTES"
if !InsTru80() .OR. !LptOk()
	ResTela( cScreen )
	return
endif
Mensagem("Aguarde, Imprimindo. ESC Cancela.", Cor())
PrintOn()
SetPrc(0, 0 )
WHILE Eval( oBloco ) .AND. Rel_Ok()
	if ( Col >= 57 )
		Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
		Write( 01, 00, Date() )
		Write( 02, 00, Padc( XNOMEFIR, Tam ) )
		Write( 03, 00, Padc( SISTEM_NA2, Tam ) )
		Write( 04, 00, Padc( Titulo,Tam ) )
		Col := 5
	endif
	Write(	Col, 0 , Repl( SEP,80 ))
	Write( ++Col, 0 , "CODI      ¯  " + REPRES )
	Write( ++Col, 0 , "EMPRESA   ¯  " + NOME)
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
	Write( ++Col, 0 , "CONTATO   ¯  " + CON)
	Write( ++Col, 0 , "OBSERV    ¯  " + OBS)
	Write( ++Col, 0 , Repl( SEP, 80))
	Col += 3
	if Col >= 57
		__Eject()
	endif
	Repres->(DbSkip(1))
EndDo
__Eject()
PrintOff()
return

Proc RolRepresParcial( oBloco )
*******************************
LOCAL cScreen := SaveScreen()
LOCAL Tam	  := 132
LOCAL Titulo  := "LISTAGEM DE REPRESENTANTES"
LOCAL Col	  := 60
LOCAL Pagina  := 0
FIELD Repres
FIELD Nome
FIELD Ende
FIELD Cida
FIELD Esta
FIELD Fone

if !InsTru80() .OR. !LptOk()
	ResTela( cScreen )
	return
endif
Mensagem("Aguarde, Imprimindo. ESC Cancela.", Cor())
PrintOn()
FPrint( PQ )
SetPrc( 0, 0 )
WHILE Eval( oBloco ) .AND. Rel_Ok()
	if Col >= 57
		 Write( 00, 00, "Pagina N§ " + StrZero( ++Pagina, 3 ) )
		 Write( 00, 00, Padl( "Horas " + Time(), Tam ) )
		 Write( 01, 00, Dtoc( Date() ) )
		 Write( 02, 00, Padc( XNOMEFIR, Tam ) )
		 Write( 03, 00, Padc( SISTEM_NA2, Tam ) )
		 Write( 04, 00, Padc( Titulo, Tam ) )
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
	Write( Col, 000, Repres )
	Write( Col, 005, Nome )
	Write( Col, 046, Ende )
	Write( Col, 078, Cida )
	Write( Col, 107, Esta )
	Write( Col, 115, Fone )
	Col++
	Repres->(DbSkip(1))
	if Col >= 57
		__Eject()
	endif
EndDo
__Eject()
PrintOff()
return

Proc MenuEstoques()
*******************
LOCAL Op
LOCAL cScreen	  := SaveScreen()
LOCAL aMenuArray := {" Estoque Por Fornecedor", " Estoque Diario", " Fisico/Financeiro (Balanco)"," Produtos Por Fornecedor", " Produtos Por Grupo", " Fisico/Financeiro Por Grupo "}

WHILE OK
	M_Title("RELATORIOS DE ESTOQUE")
	Op := FazMenu( 03, 10, aMenuArray, Cor())
	Do Case
	Case Op = ZERO
		ResTela( cScreen )
		Exit
	Case Op = 1
		EstoqueFornecedor()
	Case Op = 2
		EstoqueDia()
	Case Op = 3
		FisicoFinanceiro()
	Case Op = 4
		RolEstoqueFor()
	Case Op = 5
		RolEstGrupo()
	Case Op = 6
		RolFisGrupo()
	EndCase
EndDo

Proc MenuEntSai()
*****************
LOCAL Op
LOCAL cScreen	  := SaveScreen()
LOCAL aMenuArray := {" Conferencia Notas de Entradas",;
							" Entrada/Saida Produtos Individual",;
							" Entrada/Saida Produtos Parcial",;
							" Detalhado de Produtos Adquiridos",;
							" Detalhado de Produtos Vendidos",;
							" Vendas por Cliente",;
							" Vendas de Produtos",;
							" Saidas Por Grupo",;
							" Entradas Por Grupo", ;
							" Acumulado de Produtos Vendidos",;
							" Entrada/Saida com Posicao Atual",;
                     " Totalizado Produtos Vendidos",;
                     " Posicao de Entrada por Nota",;
                     " Fechamento Diario"}
WHILE OK
	oMenu:Limpa()
	M_Title("ROL DE ENTRADAS/SAIDAS")
	Op := FazMenu( 03, 10, aMenuArray, Cor())
	oMenu:Limpa()
	Do Case
	Case Op = ZERO
		ResTela( cScreen )
		Exit
	Case Op = 1
		RelConfEntradas()
	Case Op = 2
		EntSaiEstoque()
	Case Op = 3
		EntSaiParcial()
	Case Op = 4
		Relatori4()
	Case Op = 5
		Relatori5( 5 )
	Case Op = 6
		VendasCliente()
	Case Op = 7
		VendasTipo()
	Case Op = 8
		VendasSaiGrupo()
	Case Op = 9
		VendasEntGrupo()
	Case Op = 10
		Relatori5( 10 )
	Case Op = 11
		PosCompra()
	Case Op = 12
		TotalSaidas()
   Case Op = 13
      RolFatEntrada()
   Case Op = 14
      FechaDia()
	EndCase
EndDo

Proc TotalSaidas()
******************
LOCAL cScreen	 := SaveScreen()
LOCAL nSaidas	 := 0
LOCAL nPcusto	 := 0
LOCAL nVarejo	 := 0
LOCAL nAtacado  := 0
LOCAL nPvendido := 0
LOCAL Tam		 := 132
LOCAL Pagina	 := 0

oMenu:Limpa()
Area("Saidas")
Saidas->(DbGoTop())
if !Instru80()
	ResTela( cScreen )
	return
endif
Mensagem( "Aguarde, Processando.", Cor())
PrintOn()
FPrint( PQ )
SetPrc( 0, 0 )
WHILE Saidas->(!Eof() .AND. Rep_Ok())
	nSaidas	 += Saidas->Saida
	nPcusto	 += Saidas->Saida * Saidas->Pcusto
	nVarejo	 += Saidas->Saida * Saidas->Varejo
	nAtacado  += Saidas->Saida * Saidas->Atacado
	nPvendido += Saidas->Saida * Saidas->Pvendido
	Saidas->(DbSkip( 1 ))
EndDo
Qout( Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ))
Qout( Dtoc( Date() ))
Qout( Padc( XNOMEFIR, Tam ))
Qout( Padc( SISTEM_NA3, Tam ))
Qout( Padc( "ROL SAIDAS DE PRODUTOS - TOTALIZADO" , Tam ))
Qout( Repl( "=", Tam ) )
Qout("                   PRODUTOS      TOTAL CUSTO     TOTAL VAREJO    TOTAL ATACADO    TOTAL VENDIDO")
Qout( Repl( "=", Tam ) )
Qout("** Total Geral **", Tran( nSaidas, "999999.99" ),;
								  Tran( nPcusto,	 "@E 9,999,999,999.99" ),;
								  Tran( nVarejo,	 "@E 9,999,999,999.99" ),;
								  Tran( nAtacado,  "@E 9,999,999,999.99" ),;
								  Tran( nPvendido, "@E 9,999,999,999.99" ))
__Eject()
PrintOff()
ResTela( cScreen )
return

Proc VendasSaiGrupo()
*********************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen( )
LOCAL lSair 	  := FALSO
LOCAL aArray	  := {}
LOCAL nCop		  := 0
LOCAL nTam		  := 132
LOCAL Col		  := 58
LOCAL Pagin 	  := 0
LOCAL xAlias	  := FTempName("T*.TMP")
LOCAL xNtx		  := FTempName("T*.TMP")
LOCAL aMenuArray := { "Codigo", "Descricao", "Estoque", "Total Venda" }
LOCAL cGrupoIni  := Space(03)
LOCAL cGrupoFim  := Space(03)
LOCAL dDataIni   := Date()
LOCAL dDataFim   := Date()
LOCAL aStru 	  := {{ "CODGRUPO",  "C", 03, 0 },;
							{ "DESGRUPO",  "C", 40, 0 },;
							{ "QUANT",     "N", 09, 2 },;
							{ "TOTAL",     "N", 13, 2 }}
LOCAL cTela

WHILE OK
	MaBox( 16, 10, 21, 70 )
	cGrupoIni := Space(03)
	cGrupoFim := Space(03)
	@ 17, 11 Say "Grupo Inicial....:" Get cGrupoIni Pict "999" Valid CodiGrupo( @cGrupoIni )
	@ 18, 11 Say "Grupo Final......:" Get cGrupoFim Pict "999" Valid CodiGrupo( @cGrupoFim )
	@ 19, 11 Say "Data Inicial.....:" Get dDataIni  Pict PIC_DATA
	@ 20, 11 Say "Data Final.......:" Get dDataFim  Pict PIC_DATA Valid dDataFim >= dDataIni
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		return
	endif
	cTela 	:= Mensagem(" Aguarde, Filtrando Registros. ", WARNING )
	oBloco	:= {|| Grupo->CodGrupo >= cGrupoIni .AND. Grupo->CodGrupo <= cGrupoFim }
	bPeriodo := {| dEmis | dEmis >= dDataIni .AND. dEmis <= dDataFim }
	DbCreate( xAlias, aStru )
	Use ( xAlias ) Exclusive Alias xTemp New
	Area("Grupo")
	Grupo->(Order( UM )) 	//CodGrupo
	Lista->(Order( UM )) 	//CodGrupo
	Saidas->(Order( DOIS )) //Codigo
	Set Soft On
	Grupo->(DbSeek( cGrupoIni ))
	Set Soft Off
	While Eval( oBloco ) .AND. Grupo->(!Eof())
		cGrupo	 := Grupo->CodGrupo
		cDesGrupo := Grupo->DesGrupo
		if Lista->(DbSeek( cGrupo ))
			xTemp->(DbAppend())
			xTemp->CodGrupo	:= cGrupo
			xTemp->DesGrupo	:= cDesGrupo
			While ( Lista->CodGrupo = cGrupo .AND. Rel_Ok() )
				cCodigo := Lista->Codigo
				if Saidas->(DbSeek( cCodigo ))
					While ( Saidas->Codigo = cCodigo .AND. Rel_Ok() )
						if Eval( bPeriodo, Saidas->Emis )
							xTemp->Quant		+= Saidas->Saida
							xTemp->Total		+= Saidas->Saida * Saidas->Pvendido
						endif
						Saidas->(DbSkip(1))
					EndDo
				endif
				Lista->(DbSkip(1))
			EndDo
		endif
		Grupo->(DbSkip(1))
	EndDo
	xTemp->(DbGoTop())
	if xTemp->(Eof())  // Nenhum Registro
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )
		Alerta("Erro: Nenhum Produto Atende a Condicao.")
		ResTela( cScreen )
		Loop
	endif
	WHILE OK
		oMenu:Limpa()
		M_Title("ESCOLHA A ORDEM A IMPRIMIR. ESC RETORNA")
		nOpcao := FazMenu( 05, 10, aMenuArray )
		if nOpcao = 0 // Sair ?
			xTemp->(DbCloseArea())
			Ferase( xAlias )
			Ferase( xNtx )
			ResTela( cScreen )
			Exit
		elseif nOpcao = 1 // Por Codigo
			 Mensagem(" Aguarde, Ordenando Por Codigo. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->CodGrupo To ( xNtx )
		 elseif nOpcao = 2 // Por Descricao
			 Mensagem("Aguarde, Ordenando Por Descricao. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->DesGrupo To ( xNtx )
		 elseif nOpcao = 3 // Por Tamanho
			 Mensagem(" Aguarde, Ordenando Por Quantidade. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->Quant To ( xNtx )
		 elseif nOpcao = 4 // Total
			 Mensagem(" Aguarde, Ordenando Por Total Venda. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->Total To ( xNtx )
		endif
		oMenu:Limpa()
		if !Instru80() .OR. !LptOk()
			ResTela( cScreen )
			Loop
		endif
		xTemp->(DbGoTop())
		Mensagem("Aguarde, Imprimindo.", WARNING )
		nTam			:= 80
		Col			:= 58
		Pagina		:= 0
		lSair 		:= FALSO
		cIni			:= Dtoc( dDataIni )
		cFim			:= Dtoc( dDataFim )
		Relato		:= "RELATORIO DE SAIDAS POR GRUPO NO PERIODO DE " + cIni + " A " + cFim
		nTotVenda	:= 0
		nParVenda	:= 0
		nTotQuant	:= 0
		nParQuant	:= 0
		PrintOn()
		SetPrc(0,0)
		WHILE xTemp->(!Eof()) .AND. Rep_Ok()
			if Col >=  57
				if !Rel_OK()
					Exit
				endif
				Write( 00, 00, Linha1( nTam, @Pagina))
				Write( 01, 00, Linha2())
				Write( 02, 00, Linha3(nTam))
				Write( 03, 00, Linha4(nTam, SISTEM_NA2 ))
				Write( 04, 00, Padc( Relato ,nTam ) )
				Write( 05, 00, Linha5(nTam))
				Write( 06, 00, "GRP DESCRICAO DO GRUPO                           QUANT   T. VENDIDO")
				Write( 07, 00, Linha5(nTam))
				Col := 8
			endif
			xTemp->(Qout( CodGrupo, DesGrupo, Quant, Tran( Total, "@E 9,999,999.99")))
			nTotVenda	 += xTemp->Total
			nParVenda	 += xTemp->Total
			nTotQuant	 += xTemp->Quant
			nParQuant	 += xTemp->Quant
			xTemp->(DbSkip(1))
			Col++
			if Col >= 57 .OR. xTemp->(Eof())
				Write( Col, 0, Repl( SEP, nTam ))
				Qout("*** PARCIAL ***", Space(28), Tran( nParQuant, "999999.99"), Tran( nParVenda, "@E 9,999,999.99"))
				if xTemp->(Eof())
					Qout("***  TOTAL  ***", Space(28), Tran( nTotQuant, "999999.99"), Tran( nTotVenda, "@E 9,999,999.99"))
				endif
				__Eject()
			endif
		EndDo
		xTemp->(DbClearIndex())
		PrintOff()
	EndDo
	ResTela( cScreen )
EndDo

Proc VendasEntGrupo()
*********************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen( )
LOCAL lSair 	  := FALSO
LOCAL aArray	  := {}
LOCAL nCop		  := 0
LOCAL nTam		  := 132
LOCAL Col		  := 58
LOCAL Pagin 	  := 0
LOCAL xAlias	  := FTempName("T*.TMP")
LOCAL xNtx		  := FTempName("T*.TMP")
LOCAL aMenuArray := { "Codigo", "Descricao", "Estoque", "Total Venda" }
LOCAL cGrupoIni  := Space(03)
LOCAL cGrupoFim  := Space(03)
LOCAL dDataIni   := Date()
LOCAL dDataFim   := Date()
LOCAL aStru 	  := {{ "CODGRUPO",  "C", 03, 0 },;
							{ "DESGRUPO",  "C", 40, 0 },;
							{ "QUANT",     "N", 09, 2 },;
							{ "TOTAL",     "N", 13, 2 }}
LOCAL cTela

WHILE OK
	MaBox( 16, 10, 21, 70 )
	cGrupoIni := Space(03)
	cGrupoFim := Space(03)
	@ 17, 11 Say "Grupo Inicial....:" Get cGrupoIni Pict "999" Valid CodiGrupo( @cGrupoIni )
	@ 18, 11 Say "Grupo Final......:" Get cGrupoFim Pict "999" Valid CodiGrupo( @cGrupoFim )
	@ 19, 11 Say "Data Inicial.....:" Get dDataIni  Pict PIC_DATA
	@ 20, 11 Say "Data Final.......:" Get dDataFim  Pict PIC_DATA Valid dDataFim >= dDataIni
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		return
	endif
	cTela 	:= Mensagem(" Aguarde, Filtrando Registros. ", WARNING )
	oBloco	:= {|| Grupo->CodGrupo >= cGrupoIni .AND. Grupo->CodGrupo <= cGrupoFim }
	bPeriodo := {| dEmis | dEmis >= dDataIni .AND. dEmis <= dDataFim }
	DbCreate( xAlias, aStru )
	Use ( xAlias ) Exclusive Alias xTemp New
	Area("Grupo")
	Grupo->(Order( UM )) 	//CodGrupo
	Lista->(Order( UM )) 	//CodGrupo
	Entradas->(Order( UM )) //Codigo
	Set Soft On
	Grupo->(DbSeek( cGrupoIni ))
	Set Soft Off
	While Eval( oBloco ) .AND. Grupo->(!Eof())
		cGrupo	 := Grupo->CodGrupo
		cDesGrupo := Grupo->DesGrupo
		if Lista->(DbSeek( cGrupo ))
			xTemp->(DbAppend())
			xTemp->CodGrupo	:= cGrupo
			xTemp->DesGrupo	:= cDesGrupo
			While ( Lista->CodGrupo = cGrupo .AND. Rel_Ok() )
				cCodigo := Lista->Codigo
				if Entradas->(DbSeek( cCodigo ))
					While ( Entradas->Codigo = cCodigo .AND. Rel_Ok() )
						if Eval( bPeriodo, Entradas->Data )
							xTemp->Quant		+= Entradas->Entrada
							xTemp->Total		+= Entradas->Entrada * Entradas->Pcusto
						endif
						Entradas->(DbSkip(1))
					EndDo
				endif
				Lista->(DbSkip(1))
			EndDo
		endif
		Grupo->(DbSkip(1))
	EndDo
	xTemp->(DbGoTop())
	if xTemp->(Eof())  // Nenhum Registro
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )
		Alerta("Erro: Nenhum Produto Atende a Condicao.")
		ResTela( cScreen )
		Loop
	endif
	WHILE OK
		oMenu:Limpa()
		M_Title("ESCOLHA A ORDEM A IMPRIMIR. ESC RETORNA")
		nOpcao := FazMenu( 05, 10, aMenuArray )
		if nOpcao = 0 // Sair ?
			xTemp->(DbCloseArea())
			Ferase( xAlias )
			Ferase( xNtx )
			ResTela( cScreen )
			Exit
		elseif nOpcao = 1 // Por Codigo
			 Mensagem(" Aguarde, Ordenando Por Codigo. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->CodGrupo To ( xNtx )
		 elseif nOpcao = 2 // Por Descricao
			 Mensagem("Aguarde, Ordenando Por Descricao. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->DesGrupo To ( xNtx )
		 elseif nOpcao = 3 // Por Tamanho
			 Mensagem(" Aguarde, Ordenando Por Quantidade. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->Quant To ( xNtx )
		 elseif nOpcao = 4 // Total
			 Mensagem(" Aguarde, Ordenando Por Total Venda. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->Total To ( xNtx )
		endif
		oMenu:Limpa()
		if !Instru80() .OR. !LptOk()
			ResTela( cScreen )
			Loop
		endif
		xTemp->(DbGoTop())
		Mensagem("Aguarde, Imprimindo.", WARNING )
		nTam			:= 80
		Col			:= 58
		Pagina		:= 0
		lSair 		:= FALSO
		cIni			:= Dtoc( dDataIni )
		cFim			:= Dtoc( dDataFim )
		Relato		:= "RELATORIO DE ENTRADAS POR GRUPO NO PERIODO DE " + cIni + " A " + cFim
		nTotVenda	:= 0
		nParVenda	:= 0
		nTotQuant	:= 0
		nParQuant	:= 0
		PrintOn()
		SetPrc(0,0)
		WHILE xTemp->(!Eof()) .AND. Rep_Ok()
			if Col >=  57
				if !Rel_OK()
					Exit
				endif
				Write( 00, 00, Linha1( nTam, @Pagina))
				Write( 01, 00, Linha2())
				Write( 02, 00, Linha3(nTam))
				Write( 03, 00, Linha4(nTam, SISTEM_NA2 ))
				Write( 04, 00, Padc( Relato ,nTam ) )
				Write( 05, 00, Linha5(nTam))
				Write( 06, 00, "GRP DESCRICAO DO GRUPO                           QUANT   T. VENDIDO")
				Write( 07, 00, Linha5(nTam))
				Col := 8
			endif
			xTemp->(Qout( CodGrupo, DesGrupo, Quant, Tran( Total, "@E 9,999,999.99")))
			nTotVenda	 += xTemp->Total
			nParVenda	 += xTemp->Total
			nTotQuant	 += xTemp->Quant
			nParQuant	 += xTemp->Quant
			xTemp->(DbSkip(1))
			Col++
			if Col >= 57 .OR. xTemp->(Eof())
				Write( Col, 0, Repl( SEP, nTam ))
				Qout("*** PARCIAL ***", Space(28), Tran( nParQuant, "999999.99"), Tran( nParVenda, "@E 9,999,999.99"))
				if xTemp->(Eof())
					Qout("***  TOTAL  ***", Space(28), Tran( nTotQuant, "999999.99"), Tran( nTotVenda, "@E 9,999,999.99"))
				endif
				__Eject()
			endif
		EndDo
		xTemp->(DbClearIndex())
		PrintOff()
	EndDo
	ResTela( cScreen )
EndDo

Proc NotaEnt()
**************
LOCAL Op
LOCAL cScreen	  := SaveScreen()
LOCAL aMenuArray := {" Por Fornecedor ", " Geral "}
LOCAL xAlias	  := TempNew()
LOCAL xNtx		  := TempNew()
LOCAL cCodiIni
LOCAL cCodifim
LOCAL dIni
LOCAL dFim

BEGIN
	M_Title("ROL ENTRADAS DE NOTAS")
	Op := FazMenu( 09, 10, aMenuArray, Cor())
	Do Case
	Case Op = ZERO
		ResTela( cScreen )
		Exit
	Case Op = 1
		cCodiIni := Space(04)
		cCodifim := Space(04)
		dIni		:= Date()-30
		dFim		:= Date()
		MaBox( 15, 10, 20, 71 )
		@ 16, 11 Say "Forn Inicial :" Get cCodiIni Pict "9999" Valid Pagarrado( @cCodiIni, Row(), Col()+1 ) .AND. VerEntradas( cCodiIni )
		@ 17, 11 Say "Forn Final   :" Get cCodifim Pict "9999" Valid Pagarrado( @cCodifim, Row(), Col()+1 ) .AND. VerEntradas( cCodifim )
		@ 18, 11 Say "Data Inicial :" Get dIni Pict PIC_DATA
		@ 19, 11 Say "Data Final   :" Get dFim Pict PIC_DATA
		Read
		if LastKey() = ESC
	 ResTela( cScreen )
	 Loop
		endif
		Area("NotaEnt")
		NotaEnt->(Order( DOIS ))
		if NotaEnt->(!DbSeek( cCodiIni ))
			ResTela( cScreen )
			Nada()
			Loop
		endif
		nConta := 0
		Copy Stru To ( xAlias )
		Use ( xAlias ) Exclusive Alias xTemp New
		Mensagem("Aguarde, Processando.", Cor())
		WHILE NotaEnt->Codi >= cCodiIni .AND. NotaEnt->Codi <= cCodifim
			 if NotaEnt->Data >= dIni .AND. NotaEnt->Data <= dFim
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					FieldPut( nField, NotaEnt->(FieldGet( nField )))
				Next
				nConta++
			 endif
			 NotaEnt->(DbSkip(1))
		EndDo
		Pagar->(Order( DOIS )) // Codi
		Sele xTemp
		Set Rela To xTemp->Codi Into Pagar
		xTemp->(DbGoTop())
		if nConta = 0
			Nada()
		else
			oMenu:Limpa()
			M_Title("ESCOLHA ORDEM DO RELATORIO")
			nChoice := FazMenu( 05, 10, {"Nenhuma", "Fornecedor","Documento","Data"}, Cor())
			if nChoice = 2
				Inde On xTemp->Codi To ( xNtx )
			elseif nChoice = 3
				Inde On xTemp->Numero To ( xNtx )
			elseif nChoice = 4
				Inde On xTemp->Data To ( xNtx )
			endif
			xTemp->(DbGoTop())
			RolNotaEnt( dIni, dFim )
		endif
		xTemp->(DbClearRel())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )
		ResTela( cScreen )

	Case Op = 2
		dIni		:= Date()-30
		dFim		:= Date()
		MaBox( 15, 10, 18, 71 )
		@ 16, 11 Say "Data Inicial :" Get dIni Pict PIC_DATA
		@ 17, 11 Say "Data Final   :" Get dFim Pict PIC_DATA
		Read
		if LastKey() = ESC
	 ResTela( cScreen )
	 Loop
		endif
		Area("NotaEnt")
		NotaEnt->(Order( UM ))
		nConta := 0
		Copy Stru To ( xAlias )
		Use ( xAlias ) Exclusive Alias xTemp New
		Set Soft On
		lAchou := NotaEnt->(DbSeek( dIni ))
		Set Soft Off
		if !lAchou
			NotaEnt->(DbGoTop())
			Mensagem("Inicial nao localizada. Aguarde, Processando.", Cor())
		else
			Mensagem("Inicial localizada. Aguarde, Processando.", Cor())
		endif
		WHILE NotaEnt->(!Eof())
			 if NotaEnt->Data >= dIni .AND. NotaEnt->Data <= dFim
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					FieldPut( nField, NotaEnt->(FieldGet( nField )))
				Next
				nConta++
			 endif
			 NotaEnt->(DbSkip(1))
		EndDo
		Pagar->(Order( DOIS )) // Codi
		Sele xTemp
		Set Rela To xTemp->Codi Into Pagar
		xTemp->(DbGoTop())
		if nConta = 0
			Nada()
		else
			oMenu:Limpa()
			M_Title("ESCOLHA ORDEM DO RELATORIO")
			nChoice := FazMenu( 05, 10, {"Nenhuma", "Fornecedor","Documento","Data"}, Cor())
			if nChoice = 2
		 Inde On xTemp->Codi To ( xNtx )
			elseif nChoice = 3
		 Inde On xTemp->Numero To ( xNtx )
			elseif nChoice = 4
		 Inde On xTemp->Data To ( xNtx )
			endif
			xTemp->(DbGoTop())
			RolNotaEnt( dIni, dFim )
		endif
		xTemp->(DbClearRel())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )
		ResTela( cScreen )

	EndCase
EndDo

Function VerEntradas( cCodi )
*****************************
NotaEnt->(Order( DOIS )) // Codi
if NotaEnt->(!DbSeek( cCodi ))
	Nada()
	return( FALSO )
endif
return( OK )


Proc RolNotaEnt( dIni, dFim )
***************************
LOCAL cScreen		 := SaveScreen()
LOCAL Tam			 := CPI1280
LOCAL Col			 := 59
LOCAL Pagina		 := 00
LOCAL nTotalFatura := 0
LOCAL nSubFatura	 := 0
LOCAL nTotalNff	 := 0
LOCAL nSubNff		 := 0
LOCAL nTotalIcms	 := 0
LOCAL nSubIcms 	 := 0
LOCAL nIcms 		 := 0

if !Instru80() .OR. !LptOk()
	ResTela( cScreen )
	return
endif
Mensagem("Aguarde, Imprimindo.", Cor())
lSair 		  := FALSO
cIni			  := Dtoc( dIni )
cFim			  := Dtoc( dFim )

PrintOn()
FPrint( _CPI12 )
While !Eof() .AND. REL_OK()
	if Col >=  58
		Write( 01, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
		Write( 02, 00, Date() )
		Write( 03, 00, Padc( XNOMEFIR, Tam ) )
		Write( 04, 00, Padc( SISTEM_NA6, Tam ) )
		Write( 05, 00, Padc( "RELATORIO DE NOTAS DE ENTRADAS REF. &cIni. A &cFim.", Tam ) )
		Write( 06, 00, Repl( SEP, Tam ) )
		Write( 07, 00,"CODI FORNECEDOR                       DOCTO   EMISSAO  VLR FATURA      VLR NFF TX   VLR ICMS")
		Write( 08, 00, Repl( SEP, Tam ) )
		Col := 09
	endif
	nIcms := ( VlrNff * Icms ) / 100
	Qout( Codi, Pagar->(Left( Nome, 32)), Numero, Data, Tran( VlrFatura, "@E 999,999.99"), Tran( VlrNff, "@E 9,999,999.99"),;
			Icms, Tran( nIcms, "@E 999,999.99"))
	nTotalFatura += VlrFatura
	nSubFatura	 += VlrFatura
	nTotalNff	 += VlrNff
	nSubNff		 += VlrNff
	nTotalIcms	 += nIcms
	nSubIcms 	 += nIcms
	Col++
	DbSkip(1)
	if Col >= 55 .OR. Eof()
		Qout()
		Qout("*** SubTotal *** ", Space(34), Tran( nSubFatura, "@E 9,999,999.99" ), Tran( nSubNff, "@E 9,999,999.99" ), Tran( nSubIcms,"@E 9,999,999.99" ))
		nSubFatura := 0
		nSubNff	  := 0
		nSubIcms   := 0
		if Eof()
			Qout("*** Total Geral *** ", Space(31),Tran( nTotalFatura, "@E 9,999,999.99" ), Tran( nTotalNff, "@E 9,999,999.99" ), Tran( nTotalIcms,"@E 9,999,999.99" ))
		else
			Col := 58
			__Eject()
		endif
	endif
EndDo
__Eject()
PrintOff()
ResTela( cScreen )
return

Proc EntSaiParcial()
*******************
LOCAL cScreen	:= SaveScreen()
LOCAL Tam		:= 0
LOCAL cCodiIni := 0
LOCAL cCodifim := 0

BEGIN
	Area("Saidas")
	Saidas->(Order(DOIS))
	cCodiIni := 0
	cCodifim := 0
	dIni	  := Date() - 30
	dFim	  := Date()
	MaBox( 14, 16, 19, 47, "ROL ENT/SAI PRODUTO")
	@ 15, 17 Say "Codigo Inicial.: " Get cCodiIni Pict PIC_LISTA_CODIGO Valid CodiErrado( @cCodiIni )
	@ 16, 17 Say "Codigo Final...: " Get cCodifim Pict PIC_LISTA_CODIGO Valid CodiErrado( @cCodifim )
	@ 17, 17 Say "Data Inicial...: " Get dIni Pict PIC_DATA
	@ 18, 17 Say "Data Final.....: " Get dFim Pict PIC_DATA
	Read
	if LastKey() = ESC
		Saidas->(DbClearRel())
		Saidas->(DbGoTop())
		ResTela( cScreen )
		Exit
	endif
	Lista->(Order(DOIS))
	Area("Saidas")
	Saidas->(Order(DOIS))
	Set Rela To Codigo Into Lista
	cTela1		  := SaveScreen()
	aTodos		  := {}
	bBloco		  := {|| Saidas->Codigo >= cCodiIni .AND. Saidas->Codigo <= cCodifim }
	Set Soft On
	Saidas->(DbSeek( cCodiIni ))
	Set Soft Off
	Mensagem("Aguarde, Localizando Registros.", Cor())
	WHILE Eval( bBloco )
		nEstoAtual	  := Lista->Quant
		cDescricao	  := Left( Lista->Descricao, 39 )
		if Saidas->Data >= dIni .AND. Saidas->Data <= dFim
			nPos := Ascan2( aTodos, Saidas->Codigo, 1 )
			if nPos = 0
				Aadd( aTodos, { Codigo, cDescricao, nEstoAtual, Saida, 0.00, 0.00, 0.00, 0.00, 0.00 })
			else
				aTodos[nPos, 4] += Saidas->Saida
			endif
		else
			if Saidas->Data < dIni
				nPos := Ascan2( aTodos, Saidas->Codigo, 1 )
				if nPos != 0
					aTodos[nPos, 6] += Saidas->Saida
				endif
			endif
			if Saidas->Data > dFim
				nPos := Ascan2( aTodos, Saidas->Codigo, 1 )
				if nPos != 0
					aTodos[nPos,7] += Saidas->Saida
				endif
			endif
		endif
		Saidas->(DbSkip(1))
	Enddo
	Saidas->(DbClearRel())
	Saidas->(DbGoTop())

	Lista->(Order(DOIS))
	Area("Entradas")
	Entradas->(Order(UM))
	Set Rela To Codigo Into Lista
	bBloco := {|| Entradas->Codigo >= cCodiIni .AND. Entradas->Codigo <= cCodifim }
	Set Soft On
	Entradas->(DbSeek( cCodiIni ))
	Set Soft Off
	WHILE Eval( bBloco )
		nEstoAtual	  := Lista->Quant
		cDescricao	  := Left( Lista->Descricao, 39 )
		if Entradas->Data >= dIni .AND. Entradas->Data <= dFim
			nPos := Ascan2( aTodos, Entradas->Codigo, 1 )
			if nPos = 0
				Aadd( aTodos, { Codigo, cDescricao, nEstoAtual, 0.00, Entradas->Entrada, 0.00, 0.00, 0.00, 0.00 })
			else
				aTodos[nPos, 5] += Entradas->Entrada
			endif
		else
			if Entradas->Data < dIni
				nPos := Ascan2( aTodos, Entradas->Codigo, 1 )
				if nPos != 0
					aTodos[nPos, 8] += Entradas->Entrada
				endif
			endif
			if Entradas->Data > dFim
				nPos := Ascan2( aTodos, Entradas->Codigo, 1 )
				if nPos != 0
					aTodos[nPos,9] += Entradas->Entrada
				endif
			endif
		endif
		Entradas->(DbSkip(1))
	Enddo
	Entradas->(DbClearRel())
	Entradas->(DbGoTop())

	Asort( aTodos,,, {| x, y | y[ 2 ] > x[ 2 ] } )
	nConta	:= Len( aTodos )
	nSaidas	:= 0
	nEntrada := 0
	nSaldo	:= 0
	Tam			  := 132
	Col			  := 58
	Pagina		  := 0
	nContador	  := 0
	lSair 		  := FALSO

	if !Instru80() .OR. !LptOk()
		ResTela( cScreen )
		Loop
	endif

	ResTela( cTela1 )
	Mensagem("Aguarde, Imprimindo. ", Cor())
	PrintOn()
	FPrint( PQ )
	SetPrc( 0, 0 )
	For x := 1 To nConta
		if Col >= 58
			Write( 00, 00, Linha1( Tam, @Pagina))
			Write( 01, 00, Linha2())
			Write( 02, 00, Linha3(Tam))
			Write( 03, 00, Linha4(Tam, SISTEM_NA2 ))
			Write( 04, 00, Padc( "RELATORIO DE ENTRADA E SAIDA DE PRODUTO NO PERIODO DE " + DToc( dIni ) + " A " + DToc( dFim ),Tam ))
			Write( 05, 00, Linha5(Tam))
			Write( 06, 00, "CODIGO DESCRICAO                                (+)ANTERIOR  (+)ENTRADAS    (-)SAIDAS     (=)SALDO     (*)ATUAL          Dif")
			Write( 07, 00, Linha5(Tam))
			Col := 8
		endif
		nAtual		  := aTodos[x,3]
		nSaidas		  := aTodos[x,4]
		nEntradas	  := aTodos[x,5]
		nSaiAnt		  := aTodos[x,6]
		nSaiDep		  := aTodos[x,7]
		nEntAnt		  := aTodos[x,8]
		nEntDep		  := aTodos[x,9]

		nEstoAnterior := ( nAtual + nSaidas ) - nEntradas
		nEstoAnterior := ( nEstoAnterior + nSaiDep ) - nEntDep

		nSaldo		  := ( nEstoAnterior + nEntradas ) - nSaidas
		cCodigo		  := aTodos[x,1]
		cDescricao	  := aTodos[x,2]
		nAtual		  := aTodos[x,3]
		nDif			  :=	nSaldo - ( nAtual - nEstoAnterior )

		Qout( cCodigo, cDescricao, Tran( nEstoAnterior,"999999999.99"),;
											Tran( nEntradas,	  "999999999.99"),;
											Tran( nSaidas, 	  "999999999.99"),;
											Tran( nSaldo,		  "999999999.99"),;
											Tran( nAtual,		  "999999999.99"),;
											Tran( nDif, 		  "999999999.99"))
		Col++
		nContador++
		if Col >= 58 .OR. x = nConta
			Col++
			Write( Col, 0,  Repl( SEP, Tam ))
			__Eject()
		endif
	Next X
	PrintOff()
	ResTela( cTela1 )
EndDo


Proc EtiQueta()
***************
LOCAL cScreen		 := SaveScreen()
LOCAL nChoice		 := 0
LOCAL nQtde 		 := 0
LOCAL aMenuArray	 := {" Etiqueta Normal ",;
							  " Etiqueta Codigo de Barra "}
LOCAL cTela
WHILE OK
	M_Title("ESCOLHA SUA OPCAO")
	nChoice := FazMenu( 05, 12, aMenuArray, Cor())
	Do Case
	Case nChoice = 0
		Exit
	Case nChoice = 1
		EtiNormal()
	Case nChoice = 2
		if CODEBAR
			EtiBarra()
		else
         Alerta("Informa: Informe-se com o suporte.")
		endif
	End
EndDo
ResTela( cScreen )
return

Proc EtiNormal()
****************
LOCAL lJahImpresso := FALSO
LOCAL cScreen		 := SaveScreen()
LOCAL nChoice		 := 0
LOCAL nQtde 		 := 0
LOCAL aConfig		 := {}
LOCAL aGets 		 := {}
LOCAL aMenuArray	 := {" Configurar Etiquetas              ",;
							  " Imprimir Conforme Estoque         ",;
							  " Imprimir Qtde Selecionada         ",;
							  " Imprimir Conforme Nota de Entrada ",;
							  " Imprimir Por Grupo                "}
LOCAL cTela
WHILE OK
	M_Title("ESCOLHA SUA OPCAO")
	nChoice := FazMenu( 05, 12, aMenuArray, Cor())
	if nChoice = 0
		ResTela( cScreen )
		Exit

	endif
	if nChoice = 1
		ConfigurarEtiqueta()
		ResTela( cScreen )
		Loop
	endif
	aConfig := LerEtiqueta()
	nLen	  := Len( aConfig )
	if nLen > 0
		nCampos	  := aConfig[1]
		nTamanho   := aConfig[2]
		nMargem	  := aConfig[3]
		nLinhas	  := aConfig[4]
		nEspacos   := aConfig[5]
		nCarreira  := aConfig[6]
		lComprimir := aConfig[7] == 1
		lSpVert	  := aConfig[8] == 1
		For nX := 9 To nLen
			Aadd( aGets, aConfig[nX] )
		Next
		aLinha := Array( aConfig[1] )
		Afill( aLinha, "" )
	else
		ErrorBeep()
		Alerta("Erro: Favor Escolher Arquivo de Etiquetas.")
		ResTela( cScreen )
		Loop
	endif
	if nChoice < 4
		WHILE OK
			Grupo->(Order(UM))
			SubGrupo->(Order(UM))
			Pagar->(Order( DOIS ))
			Area("Lista")
			Set Rela To CodGrupo Into Grupo,;
							CodsGrupo Into SubGrupo,;
							Codi Into Pagar
			Order(DOIS)
			DbGoTop()
			cInic 	  := 0
			cFina 	  := 0
			nCarreiras := 5
			if nChoice = 2
				MaBox( 14, 12, 17, 44 )
				@ 15, 13 Say 'Codigo Inicial...¯' Get cInic Pict PIC_LISTA_CODIGO Valid CodiErrado( @cInic )
				@ 16, 13 Say 'Codigo Final.....¯' Get cFina Pict PIC_LISTA_CODIGO Valid CodiErrado( @cFina,,OK )
				Read
			else
				MaBox( 14, 12, 18, 44 )
				@ 15, 13 Say 'Codigo Inicial...¯' Get cInic Pict PIC_LISTA_CODIGO Valid CodiErrado( @cInic )
				@ 16, 13 Say 'Codigo Final.....¯' Get cFina Pict PIC_LISTA_CODIGO Valid CodiErrado( @cFina,,OK)
				@ 17, 13 Say 'Qtde Individual..¯' Get nQtde Pict "999" Valid nQtde > 0 When nChoice = 3
				Read
			endif
			if LastKey() = ESC
				ResTela( cScreen )
				Exit
			endif
			if !Instru80() .OR. !LptOk()
				ResTela( cScreen )
				Loop
			endif
			Mensagem("Aguarde. Imprimindo.", Cor())
			PrintOn()
			FPrint( _SALTOOFF )
			if lComprimir
				FPrint( PQ )
			endif
			if lSpVert
				FPrint( _SPACO1_8 )
			endif
			SetPrc( 0, 0 )
			oBloco := {|| Lista->Codigo >= cInic .AND. Lista->Codigo <= cFina }
			DbSeek( cInic )
			nConta := 0
			WHILE Eval( oBloco ) .AND. Rep_Ok()
				if nChoice = 3
					nEtiquetas := nQtde
				else
					nEtiquetas := Lista->Quant
				endif
				nCol := nMargem
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
							Qout( Space( nMargem ) + aLinha[nC] )
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
					Qout( Space( nMargem ) + aLinha[nC] )
					aLinha[nC] := ""
				Next
				For nD := 1 To nLinhas
					Qout()
				Next
			endif
			PrintOFF()
			Lista->(DbClearRel())
			ResTela( cScreen )
		EndDo
	elseif nChoice = 5
	  cTela := SaveScreen()
		WHILE OK
			Grupo->(Order(UM))
			SubGrupo->(Order(UM))
			Pagar->(Order( DOIS ))
			Area("Lista")
			Set Rela To CodGrupo Into Grupo, CodsGrupo Into SubGrupo, Codi Into Pagar
			Lista->(Order(UM)) //Codgrupo
			nCarreiras := 5
			cGrupoIni := Space(TRES)
			cGrupoFim := Space(TRES)
			MaBox( 14, 12, 17, 44 )
			@ 15, 13 Say "Grupo Inicial.:" Get cGrupoIni Pict "999" Valid CodiGrupo( @cGrupoIni )
			@ 16, 13 Say "Grupo Final...:" Get cGrupoFim Pict "999" Valid CodiGrupo( @cGrupoFim )
			Read
			if LastKey() = ESC
				ResTela( cScreen )
				Exit
			endif
			if !Instru80() .OR. !LptOk()
				ResTela( cScreen )
				Loop
			endif
			Mensagem("Aguarde. Imprimindo.", Cor())
			PrintOn()
			FPrint( _SALTOOFF )
			if lComprimir
				FPrint( PQ )
			endif
			if lSpVert
				FPrint( _SPACO1_8 )
			endif
			SetPrc( 0, 0 )
			oBloco := {|| Lista->CodGrupo >= cGrupoIni .AND. Lista->CodGrupo <= cGrupoFim }
			Set Soft On
			if Lista->(!DbSeek( cGrupoIni ))
				Set Soft Off
				Loop
			endif
			Set Soft Off
			nConta := 0
			WHILE Lista->(Eval( oBloco )) .AND. Rep_Ok()
				cCodigo	  := Lista->Codigo
				nEtiquetas := Lista->Quant
				nCol		  := nMargem
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
							Qout( Space( nMargem ) + aLinha[nC] )
							aLinha[nC] := ""
						Next
						For nD := 1 To nLinhas
							Qout()
						Next
					endif
				Next nY
				Lista->(DbSkip(1))
			EndDo
			if nConta >0
				For nC := 1 To nCampos
					Qout( Space( nMargem ) + aLinha[nC] )
					aLinha[nC] := ""
				Next
				For nD := 1 To nLinhas
					Qout()
				Next
			endif
			PrintOFF()
			Lista->(DbClearRel())
			ResTela( cTela  )
		EndDo
	elseif nChoice = 4
		cTela := SaveScreen()
		WHILE OK
			Grupo->(Order(UM))
			SubGrupo->(Order(UM))
			Pagar->(Order( DOIS ))
			Area("Lista")
			Set Rela To CodGrupo Into Grupo, CodsGrupo Into SubGrupo, Codi Into Pagar
			Lista->(Order(DOIS))
			nCarreiras := 5
			Entradas->(Order(DOIS))
			cDocnr := Space(09)
			MaBox( 14, 12, 16, 44 )
			@ 15, 13 Say 'N§ Nota Entrada..:' Get cDocnr Pict "@!" Valid AchaDocEntrada( @cDocnr )
			Read
			if LastKey() = ESC
				ResTela( cScreen )
				Exit
			endif
			if !Instru80() .OR. !LptOk()
				ResTela( cScreen )
				Loop
			endif
			Mensagem("Aguarde. Imprimindo.", Cor())
			PrintOn()
			FPrint( _SALTOOFF )
			if lComprimir
				FPrint( PQ )
			endif
			if lSpVert
				FPrint( _SPACO1_8 )
			endif
			SetPrc( 0, 0 )
			oBloco := {|| Entradas->Fatura = cDocnr }
			if Entradas->(DbSeek( cDocnr ))
				nConta := 0
				WHILE Entradas->(Eval( oBloco )) .AND. Rep_Ok()
					cCodigo	  := Entradas->Codigo
					nEtiquetas := Entradas->Entrada
					if Lista->(DbSeek( cCodigo ))
						nCol		  := nMargem
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
									Qout( Space( nMargem ) + aLinha[nC] )
									aLinha[nC] := ""
								Next
								For nD := 1 To nLinhas
									Qout()
								Next
							endif
						Next nY
					endif
					Entradas->(DbSkip(1))
				EndDo
				if nConta >0
					For nC := 1 To nCampos
						Qout( Space( nMargem ) + aLinha[nC] )
						aLinha[nC] := ""
					Next
					For nD := 1 To nLinhas
						Qout()
					Next
				endif
				PrintOFF()
				Lista->(DbClearRel())
				ResTela( cTela  )
			endif
		EndDo
	endif
EndDo

Proc IniGrande()
***************
PrintOn()
FPrint( RESETA 	) // Inicializar Impressora
FPrint( _SALTOOFF ) // Inibir Salto de Picote
FPrint( PQ			) // Condensado
return


Proc EtiBarra()
***************
LOCAL lJahImpresso := FALSO
LOCAL cScreen		 := SaveScreen()
LOCAL nChoice		 := 0
LOCAL nQtde 		 := 0
LOCAL aConfig		 := {}
LOCAL aGets 		 := {}
LOCAL xAlias		 := FTempName("T*.TMP")
LOCAL xNtx			 := FTempName("T*.TMP")
LOCAL aStru
LOCAL cGrupo		 := Space(03)
LOCAL cLetra1		 := Space(40)
LOCAL cLetra2		 := Space(40)
LOCAL aMenuArray	 := { "Codigo", "Descricao", "Tamanho", "Cod Fabricante", "Qtde Minima", "Estoque", "Preco Venda" }
LOCAL aMenu 		 := {" Imprimir Teste                    ",;
							  " Imprimir Conforme Estoque         ",;
							  " Imprimir Qtde Selecionada         ",;
							  " Imprimir Conforme Nota de Entrada ",;
							  " Imprimir Por Grupo                ",;
							  " Imprimir Por Grupo/Palavra        "}
LOCAL cTela
WHILE OK
	M_Title("ESCOLHA SUA OPCAO")
	nChoice := FazMenu( 04, 12, aMenu, Cor())
	if nChoice = 0
		ResTela( cScreen )
		Exit
	elseif nChoice = 1
		if !Instru80() .OR. !LptOk()
			ResTela( cScreen )
			Loop
		endif
		Mensagem("Aguarde. Imprimindo.", Cor())
		PrintOn()
		Qout( Chr(2) + "f138")
		Qout( Chr(2) + "T")
		Qout( "E"   )
		PrintOff()
		ResTela( cScreen )

	elseif nChoice = 2 .OR. nChoice = 3
		WHILE OK
			Grupo->(Order(UM))
			SubGrupo->(Order(UM))
			Pagar->(Order( DOIS ))
			Area("Lista")
			Set Rela To CodGrupo Into Grupo,;
							CodsGrupo Into SubGrupo,;
							Codi Into Pagar
			Order(DOIS)
			DbGoTop()
			cInic 	  := 0
			cFina 	  := 0
			nCarreiras := 3
			if nChoice = 2
				MaBox( 14, 12, 17, 44 )
				@ 15, 13 Say 'Codigo Inicial...¯' Get cInic Pict PIC_LISTA_CODIGO Valid CodiErrado( @cInic )
				@ 16, 13 Say 'Codigo Final.....¯' Get cFina Pict PIC_LISTA_CODIGO Valid CodiErrado( @cFina,,OK )
				Read
			else
				MaBox( 14, 12, 18, 44 )
				@ 15, 13 Say 'Codigo Inicial...¯' Get cInic Pict PIC_LISTA_CODIGO Valid CodiErrado( @cInic )
				@ 16, 13 Say 'Codigo Final.....¯' Get cFina Pict PIC_LISTA_CODIGO Valid CodiErrado( @cFina,,OK)
				@ 17, 13 Say 'Qtde Individual..¯' Get nQtde Pict "999" Valid nQtde > 0 When nChoice = 3
				Read
			endif
			if LastKey() = ESC
				ResTela( cScreen )
				Exit
			endif
			if !Instru80() .OR. !LptOk()
				ResTela( cScreen )
				Loop
			endif
			Mensagem("Aguarde. Imprimindo.", Cor())
			PrintOn()
			oBloco := {|| Lista->Codigo >= cInic .AND. Lista->Codigo <= cFina }
			DbSeek( cInic )
			nConta := 0
			WHILE Eval( oBloco ) .AND. Rep_Ok()
				if nChoice = 3
					nEtiquetas := nQtde
				else
					nEtiquetas := Lista->Quant
				endif
				For nY := 1 To nEtiquetas
					nConta++
					if nConta = 1
						EtiBar1()
					elseif nConta = 2
						EtiBar2()
					elseif nConta = 3
						EtiBar3()
					endif
					if nConta = 3
						Qout("Q1") // Quantidade de Etiqueta
						Qout("E")  // Imprime a Etiqueta
						nConta := 0
					endif
				Next nY
				DbSkip(1)
			EndDo
			Qout("Q1") // Quantidade de Etiqueta
			Qout("E")  // Imprime a Etiqueta
			PrintOFF()
			Lista->(DbClearRel())
			ResTela( cScreen )
		EndDo
	elseif nChoice = 4
		cTela := SaveScreen()
		WHILE OK
			Grupo->(Order(UM))
			SubGrupo->(Order(UM))
			Pagar->(Order( DOIS ))
			Area("Lista")
			Set Rela To CodGrupo Into Grupo, CodsGrupo Into SubGrupo, Codi Into Pagar
			Lista->(Order(DOIS))
			nCarreiras := 5
			Entradas->(Order(DOIS))
			cDocnr := Space(09)
			MaBox( 14, 12, 16, 44 )
			@ 15, 13 Say 'N§ Nota Entrada..:' Get cDocnr Pict "@!" Valid AchaDocEntrada( @cDocnr )
			Read
			if LastKey() = ESC
				ResTela( cScreen )
				Exit
			endif
			if !Instru80() .OR. !LptOk()
				ResTela( cScreen )
				Loop
			endif
			Mensagem("Aguarde. Imprimindo.", Cor())
			PrintOn()
			oBloco := {|| Entradas->Fatura = cDocnr }
			if Entradas->(DbSeek( cDocnr ))
				nConta := 0
				WHILE Entradas->(Eval( oBloco )) .AND. Rep_Ok()
					cCodigo	  := Entradas->Codigo
					nEtiquetas := Entradas->Entrada
					if Lista->(DbSeek( cCodigo ))
						For nY := 1 To nEtiquetas
							nConta++
							if nConta = 1
								EtiBar1()
							elseif nConta = 2
								EtiBar2()
							elseif nConta = 3
								EtiBar3()
							endif
							if nConta = 3
								Qout("Q1") // Quantidade de Etiqueta
								Qout("E")  // Imprime a Etiqueta
								nConta := 0
							endif
						Next nY
					endif
					Entradas->(DbSkip(1))
				EndDo
				Qout("Q1") // Quantidade de Etiqueta
				Qout("E")  // Imprime a Etiqueta
				PrintOFF()
				Lista->(DbClearRel())
				ResTela( cTela  )
			endif
		EndDo
	elseif nChoice = 5
		cTela := SaveScreen()
		WHILE OK
			Grupo->(Order(UM))
			SubGrupo->(Order(UM))
			Pagar->(Order( DOIS ))
			Area("Lista")
			Set Rela To CodGrupo Into Grupo, CodsGrupo Into SubGrupo, Codi Into Pagar
			Lista->(Order(UM)) //Codgrupo
			nCarreiras := 5
			cGrupoIni := Space(TRES)
			cGrupoFim := Space(TRES)
			MaBox( 14, 12, 17, 44 )
			@ 15, 13 Say "Grupo Inicial.:" Get cGrupoIni Pict "999" Valid CodiGrupo( @cGrupoIni )
			@ 16, 13 Say "Grupo Final...:" Get cGrupoFim Pict "999" Valid CodiGrupo( @cGrupoFim )
			Read
			if LastKey() = ESC
				ResTela( cScreen )
				Exit
			endif
			if !Instru80() .OR. !LptOk()
				ResTela( cScreen )
				Loop
			endif
			Mensagem("Aguarde. Imprimindo.", Cor())
			PrintOn()
			oBloco := {|| Lista->CodGrupo >= cGrupoIni .AND. Lista->CodGrupo <= cGrupoFim }
			Set Soft On
			if Lista->(!DbSeek( cGrupoIni ))
				Set Soft Off
				Loop
			endif
			Set Soft Off
			nConta := 0
			WHILE Lista->(Eval( oBloco )) .AND. Rep_Ok()
				cCodigo	  := Lista->Codigo
				nEtiquetas := Lista->Quant
				For nY := 1 To nEtiquetas
					nConta++
					if nConta = 1
						EtiBar1()
					elseif nConta = 2
						EtiBar2()
					elseif nConta = 3
						EtiBar3()
					endif
					if nConta = 3
						Qout("Q1") // Quantidade de Etiqueta
						Qout("E")  // Imprime a Etiqueta
						nConta := 0
					endif
				Next nY
				Lista->(DbSkip(1))
			EndDo
			Qout("Q1") // Quantidade de Etiqueta
			Qout("E")  // Imprime a Etiqueta
			PrintOFF()
			Lista->(DbClearRel())
			ResTela( cTela  )
		EndDo

	elseif nChoice = 6
		cTela := SaveScreen()
		WHILE OK
			MaBox( 14, 12, 18, 72 )
			cGrupo  := Space(03)
			cLetra1 := Space(40)
			cLetra2 := Space(40)
			@ 15, 13 Say "Grupo............:" Get cGrupo Pict "999" Valid CodiGrupo( @cGrupo )
			@ 16, 13 Say "Palavra Inicial..:" Get cLetra1 Pict "@!" Valid !Empty( cLetra1 )
			@ 17, 13 Say "Palavra Final....:" Get cLetra2 Pict "@!" Valid !Empty( cLetra2 )
			Read
			if LastKey() = ESC
				ResTela( cScreen )
				Exit
			endif
			cLetra1 := AllTrim( cLetra1 )
			cLetra2 := AllTrim( cLetra2 )
			cTela   := Mensagem(" Aguarde, Filtrando Registros. ", WARNING )
			aStru   := Lista->(DbStruct())
			DbCreate( xAlias, aStru )
			Use ( xAlias ) Exclusive Alias xTemp New
			Grupo->(Order(UM))
			SubGrupo->(Order(UM))
			Pagar->(Order( DOIS ))
			Area("Lista")
			Set Rela To CodGrupo Into Grupo, CodsGrupo Into SubGrupo, Codi Into Pagar
			Lista->(Order(UM)) //Codgrupo
			if Lista->(DbSeek( cGrupo ))
				While ( Lista->CodGrupo = cGrupo .AND. Rel_Ok() )
					if Lista->(Left( Descricao, Len( cLetra1 ))) >= cLetra1 .AND. Lista->(Left( Descricao, Len( cLetra2 ))) <= cLetra2
						xTemp->(DbAppend())
						xTemp->Codigo		:= Lista->Codigo
						xTemp->N_Original := Lista->N_Original
						xTemp->Descricao	:= Lista->Descricao
						xTemp->Un			:= Lista->Un
						xTemp->Qmin 		:= Lista->Qmin
						xTemp->Quant		:= Lista->Quant
						xTemp->Tam			:= Lista->Tam
						xTemp->Varejo		:= Lista->Varejo
						xTemp->Codi 		:= Lista->Codi
						xTemp->CodGrupo	:= Lista->CodGrupo
						xTemp->CodeBar 	:= Lista->CodeBar
						xTemp->Varejo		:= Lista->Varejo
					endif
					Lista->(DbSkip(1))
				EndDo
			endif
			xTemp->(DbGoTop())
			if xTemp->(Eof())  // Nenhum Registro
				xTemp->(DbCloseArea())
				Ferase( xAlias )
				Ferase( xNtx )
				Alerta("Erro: Nenhum Produto Atende a Condicao.")
				ResTela( cTela )
				Loop
			endif
			WHILE OK
				oMenu:Limpa()
				M_Title("ESCOLHA A ORDEM A IMPRIMIR. ESC RETORNA")
				nOpcao := FazMenu( 05, 10, aMenuArray )
				if nOpcao = 0 // Sair ?
					xTemp->(DbCloseArea())
					Ferase( xAlias )
					Ferase( xNtx )
					ResTela( cTela )
					Exit
				elseif nOpcao = 1 // Por Codigo
					 Mensagem(" Aguarde, Ordenando Por Codigo. ", WARNING )
					 Area("xTemp")
					 Inde On xTemp->Codigo To ( xNtx )
				 elseif nOpcao = 2 // Por Descricao
					 Mensagem("Aguarde, Ordenando Por Descricao. ", WARNING )
					 Area("xTemp")
					 Inde On xTemp->Descricao To ( xNtx )
				 elseif nOpcao = 3 // Por Tamanho
					 Mensagem(" Aguarde, Ordenando Por Tamanho. ", WARNING )
					 Area("xTemp")
					 Inde On xTemp->Tam To ( xNtx )
				 elseif nOpcao = 4 // N_Original
					 Mensagem(" Aguarde, Ordenando Por Codigo Fabricante. ", WARNING )
					 Area("xTemp")
					 Inde On xTemp->N_Original To ( xNtx )
				 elseif nOpcao = 5 // QMin
					 Mensagem(" Aguarde, Ordenando Por Qtde Minima. ", WARNING )
					 Area("xTemp")
					 Inde On xTemp->Qmin To ( xNtx )
				 elseif nOpcao = 6 // Quant
					 Mensagem(" Aguarde, Ordenando Por Estoque. ", WARNING )
					 Area("xTemp")
					 Inde On xTemp->Quant To ( xNtx )
				 elseif nOpcao = 7 // Quant
					 Mensagem(" Aguarde, Ordenando Por Preco Venda. ", WARNING )
					 Area("xTemp")
					 Inde On xTemp->Varejo To ( xNtx )
				endif
				oMenu:Limpa()
				if !Instru80() .OR. !LptOk()
					ResTela( cTela )
					Loop
				endif
				Mensagem("Aguarde. Imprimindo.", Cor())
				PrintOn()
				xTemp->(DbGoTop())
				nConta := 0
				WHILE xTemp->(!Eof()) .AND. Rep_Ok()
					cCodigo	  := xTemp->Codigo
					nEtiquetas := xTemp->Quant
					For nY := 1 To nEtiquetas
						nConta++
						if nConta = 1
							EtiBar1()
						elseif nConta = 2
							EtiBar2()
						elseif nConta = 3
							EtiBar3()
						endif
						if nConta = 3
							Qout("Q1") // Quantidade de Etiqueta
							Qout("E")  // Imprime a Etiqueta
							nConta := 0
						endif
					Next nY
					xTemp->(DbSkip(1))
				EndDo
				Qout("Q1") // Quantidade de Etiqueta
				Qout("E")  // Imprime a Etiqueta
				PrintOFF()
				Lista->(DbClearRel())
			EndDo
			ResTela( cTela  )
		EndDo
	endif
EndDo

Proc IniBarra()
**************
PrintOn()
FPrint( RESETA 	) // Inicializar Impressora
FPrint( _SALTOOFF ) // Inibir Salto de Picote
FPrint( PQ			) // Condensado
return

Proc EtiBar1()
**************
FPrint( "f138")
FPrint( "O0220")
FPrint( "L")      // Inicia Modo Etiqueta
FPrint( "D11")     // Tamanho Pixel
FPrint( "H15")     // Calor da Cabeca Impressao
Qout("420100000000022" + Descricao )
Qout("102400000100030" + FANTACODEBAR )
Qout("422200002000060" + Tam )
Qout("4F1305000350090" + CodeBar )
Qout("401100000100095" + "CODIGO : " + Codigo )
Qout("401100000100100" + "FORN...: " + Codi )
Qout("401100000100105" + "GRUPO..: " + CodGrupo )
Qout("401100000100110" + "REFE...: " + N_Original )
Qout("421100001700110" + "R$ " + AllTrim( Tran( Varejo, "@E 9,999,999,999.99")))
Qout("401100000100120" + AllTrim( XNOMEFIR ) + " - " + AllTrim( XCCIDA ))
return

Proc EtiBar2()
**************
Qout("420100000000156" + Descricao )
Qout("102400000100164" + FANTACODEBAR )
Qout("422200002000194" + Tam )
Qout("4F1305000350224" + CodeBar )
Qout("401100000100229" + "CODIGO : " + Codigo )
Qout("401100000100234" + "FORN...: " + Codi )
Qout("401100000100239" + "GRUPO..: " + CodGrupo )
Qout("401100000100244" + "REFE...: " + N_Original)
Qout("421100001700244" + "R$ " + AllTrim( Tran( Varejo, "@E 9,999,999,999.99")))
Qout("401100000100254" + AllTrim( XNOMEFIR ) + " - " + AllTrim( XCCIDA ))
return

Proc EtiBar3()
**************
Qout("420100000000290" + Descricao )
Qout("102400000100294" + FANTACODEBAR )
Qout("422200002000324" + Tam )
Qout("4F1305000350354" + CodeBar )
Qout("401100000100359" + "CODIGO : " + Codigo )
Qout("401100000100364" + "FORN...: " + Codi )
Qout("401100000100369" + "GRUPO..: " + CodGrupo )
Qout("401100000100374" + "REFE...: " + N_Original )
Qout("421100001700374" + "R$ " + AllTrim( Tran( Varejo, "@E 9,999,999,999.99")))
Qout("401100000100384" + AllTrim( XNOMEFIR ) + " - " + AllTrim( XCCIDA ))
return

Proc PosCompra()
****************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL nTam		:= 0
LOCAL cCodiIni := 0
LOCAL cCodifim := 0
LOCAL nChoice	:= 0
LOCAL nOrdem	:= 0
LOCAL lFiltro	:= FALSO
LOCAL dIni		:= Date()
LOCAL dFim		:= Date()
LOCAL xAlias	:= FTempName("T*.TMP")
LOCAL xNtx		:= FTempName("T*.TMP")
LOCAL aMenu 	:= {"Parcial", "Por Fornecedor"}
LOCAL aOrdem	:= {"Codigo","Descricao","Cod Fabr/Ref","Agrupado por Cod Fabr/Ref", "Descricao+Tamanho"}
LOCAL aDbf		:= {{"CODIGO",     "C", 06, 0 }, {"DESCRICAO",  "C", 40, 0 },;
						 {"QUANT",      "N", 09, 2 }, {"SAIDA",      "N", 09, 2 },;
						 {"SAIANT",     "N", 09, 2 }, {"SAIPOS",     "N", 09, 2 },;
						 {"ENTRADA",    "N", 09, 2 }, {"ENTANT",     "N", 09, 2 },;
						 {"ENTPOS",     "N", 09, 2 }, {"N_ORIGINAL", "C", 15, 0 },;
						 {"TAM",        "C", 06, 0 }, {"VAREJO",     "N", 11, 2 }, ;
						 {"DATA",       "D", 08, 0 }}
LOCAL cTela1		  := SaveScreen()
LOCAL bBloco		  := {}
LOCAL nEstoAtual	  := 0
LOCAL nSaida		  := 0
LOCAL nVarejo		  := 0
LOCAL nEntrada 	  := 0
LOCAL nSaidas		  := 0
LOCAL nSaldo		  := 0
LOCAL Col			  := 0
LOCAL Pagina		  := 0
LOCAL nContador	  := 0
LOCAL nAtual		  := 0
LOCAL nEntradas	  := 0
LOCAL nSaiAnt		  := 0
LOCAL nSaiDep		  := 0
LOCAL nEntDep		  := 0
LOCAL nEntAnt		  := 0
LOCAL nDif			  := 0
LOCAL nEstoAnterior := 0
LOCAL nParcAnt 	  := 0
LOCAL nParcEnt 	  := 0
LOCAL nParcSai 	  := 0
LOCAL nParcSaldo	  := 0
LOCAL nParcAtual	  := 0
LOCAL cDescricao	  := ""
LOCAL cTam			  := ""
LOCAL cOriginal	  := ""
LOCAL cCodigo		  := ""
LOCAL cCodi 		  := ""
LOCAL cRefAtual	  := ""
LOCAL dData 		  := Date()
LOCAL lSair 		  := FALSO
LOCAL cRefAnt
FIELD Codigo
FIELD Descricao

BEGIN
	oMenu:Limpa()
	M_Title("POSICAO ENTRADA E SAIDA DE PRODUTOS")
	nChoice := FazMenu( 06, 10, aMenu, Cor())
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		return

	Case nChoice = 1
		cCodiIni := 0
		cCodifim := 0
		dIni		:= Date() - 30
		dFim		:= Date()
		MaBox( 12, 10, 17, 70, "ROL ENT/SAI PRODUTO")
		@ 13, 11 Say "Codigo Inicial.: " Get cCodiIni Pict PIC_LISTA_CODIGO Valid CodiErrado( @cCodiIni )
		@ 14, 11 Say "Codigo Final...: " Get cCodifim Pict PIC_LISTA_CODIGO Valid CodiErrado( @cCodifim )
		@ 15, 11 Say "Data Inicial...: " Get dIni Pict PIC_DATA
		@ 16, 11 Say "Data Final.....: " Get dFim Pict PIC_DATA
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		lFiltro := Conf("Pergunta: Selecionar registros zerados ou negativos ?")
		Lista->(Order(DOIS))
		Area("Saidas")
		Saidas->(Order(DOIS))
		Set Rela To Saidas->Codigo Into Lista
		cTela1		  := SaveScreen()
		bBloco		  := {|| Saidas->Codigo >= cCodiIni .AND. Saidas->Codigo <= cCodifim }
		Set Soft On
		Saidas->(DbSeek( cCodiIni ))
		Set Soft Off
		Mensagem("Aguarde, Localizando Registros.", Cor())
		DbCreate( xAlias, aDbf )
		Use ( xAlias ) Alias xTemp Exclusive New
		Inde On xTemp->Codigo To (xNtx )

		WHILE Eval( bBloco )
			nEstoAtual	  := Lista->Quant
			cDescricao	  := Lista->Descricao
			cTam			  := Lista->Tam
			cOriginal	  := Lista->N_Original
			nVarejo		  := Lista->Varejo

			if !( lFiltro )
				if nEstoAtual <= 0
					Saidas->(DbSkip(1))
					Loop
				endif
			endif
			cCodigo := Saidas->Codigo
			nSaida  := Saidas->Saida
			dData   := Saidas->Data

			if xTemp->(!DbSeek( cCodigo ))
				xTemp->(DbAppend())
				xTemp->Codigo		:= cCodigo
				xTemp->Descricao	:= cDescricao
				xTemp->Quant		:= nEstoAtual
				xTemp->N_Original := cOriginal
				xTemp->Tam			:= cTam
				xTemp->Varejo		:= nVarejo
			endif

			if dData >= dIni .AND. dData <= dFim
				xTemp->Saida := nSaida
				xTemp->Data  := dData
			elseif dData < dIni
				xTemp->SaiAnt += nSaida
				xTemp->Data   := dData
			elseif dData > dFim
				xTemp->SaiPos += nSaida
				xTemp->Data   := dData
			endif
			Saidas->(DbSkip(1))
		Enddo
		Saidas->(DbClearRel())
		Saidas->(DbGoTop())

		*------------------------------------------------------------------------

		Lista->(Order(DOIS))
		Area("Entradas")
		Entradas->(Order(UM))
		Set Rela To Entradas->Codigo Into Lista
		bBloco := {|| Entradas->Codigo >= cCodiIni .AND. Entradas->Codigo <= cCodifim }
		Set Soft On
		Entradas->(DbSeek( cCodiIni ))
		Set Soft Off
		WHILE Eval( bBloco )
			nEstoAtual	  := Lista->Quant
			cDescricao	  := Lista->Descricao
			cTam			  := Lista->Tam
			cOriginal	  := Lista->n_Original
			nVarejo		  := Lista->Varejo

			if !( lFiltro )
				if nEstoAtual <= 0
					Entradas->(DbSkip(1))
					Loop
				endif
			endif

			cCodigo	:= Entradas->Codigo
			nEntrada := Entradas->Entrada
			dData 	:= Entradas->Data

			if xTemp->(!DbSeek( cCodigo ))
				xTemp->(DbAppend())
				xTemp->Codigo		:= cCodigo
				xTemp->Descricao	:= cDescricao
				xTemp->Quant		:= nEstoAtual
				xTemp->N_Original := cOriginal
				xTemp->Tam			:= cTam
				xTemp->Varejo		:= nVarejo
			endif

			if dData >= dIni .AND. dData <= dFim
				xTemp->Entrada := nSaida
				xTemp->Data 	:= dData
			elseif dData < dIni
				xTemp->EntAnt	+= nSaida
				xTemp->Data 	:= dData
			elseif dData > dFim
				xTemp->EntPos	+= nSaida
				xTemp->Data 	:= dData
			endif
			Entradas->(DbSkip(1))
		Enddo
		Entradas->(DbClearRel())
		Entradas->(DbGoTop())

	Case nChoice = 2
		cCodi 	:= Space(04)
		dIni		:= Date() - 30
		dFim		:= Date()
		MaBox( 12, 10, 16, 74, "ROL ENT/SAI PRODUTO")
		@ 13, 11 Say "Fornecedor.....: " Get cCodi Pict "9999" Valid Pagarrado( @cCodi, Row(), Col()+1 )
		@ 14, 11 Say "Data Inicial...: " Get dIni  Pict PIC_DATA
		@ 15, 11 Say "Data Final.....: " Get dFim  Pict PIC_DATA
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		lFiltro := Conf("Pergunta: Selecionar registros zerados ou negativos ?")
		Lista->(Order( SEIS ))		// Fornecedor
		Entradas->(Order( CINCO )) // Fornecedor
		Area("Saidas")
		Saidas->(Order( DOIS )) 	// Codigo
		if Lista->( !DbSeek( cCodi ))
			ErrorBeep()
			Nada()
			Loop
		endif
		Set Rela To Saidas->Codigo Into Lista
		cTela1  := SaveScreen()
		bBloco  := {|| Lista->Codi = cCodi }
		Mensagem("Aguarde, Localizando Registros.", Cor())
		DbCreate( xAlias, aDbf )
		Use ( xAlias ) Alias xTemp Exclusive New
		Inde On xTemp->Codigo To (xNtx )
		Lista->(DbSeek( cCodi ))
		WHILE Lista->(Eval( bBloco ))
			nEstoAtual	  := Lista->Quant
			cDescricao	  := Lista->Descricao
			cTam			  := Lista->Tam
			cOriginal	  := Lista->N_Original
			nVarejo		  := Lista->Varejo
			cCodigo		  := Lista->Codigo

			if !( lFiltro )
				if nEstoAtual <= 0
					Lista->(DbSkip(1))
					Loop
				endif
			endif

			if Saidas->(DbSeek( cCodigo ))
				While Saidas->Codigo = cCodigo
					nSaida  := Saidas->Saida
					dData   := Saidas->Data
					if xTemp->(!DbSeek( cCodigo ))
						xTemp->(DbAppend())
						xTemp->Codigo		:= cCodigo
						xTemp->Descricao	:= cDescricao
						xTemp->Quant		:= nEstoAtual
						xTemp->N_Original := cOriginal
						xTemp->Tam			:= cTam
						xTemp->Varejo		:= nVarejo
					endif
					if dData >= dIni .AND. dData <= dFim
						xTemp->Saida := nSaida
						xTemp->Data  := dData
					elseif dData < dIni
						xTemp->SaiAnt += nSaida
						xTemp->Data   := dData
					elseif dData > dFim
						xTemp->SaiPos += nSaida
						xTemp->Data   := dData
					endif
					Saidas->(DbSkip(1))
				EndDo
			endif
			Lista->(DbSkip(1))
		Enddo
		Saidas->(DbClearRel())
		Saidas->(DbGoTop())

		*------------------------------------------------------------------------

		Lista->(Order(DOIS))
		Area("Entradas")
		Entradas->(Order( CINCO ))
		Set Rela To Entradas->Codigo Into Lista
		bBloco := {|| Entradas->Codi = cCodi }
		Entradas->(DbSeek( cCodi ))
		WHILE Eval( bBloco )
			nEstoAtual	  := Lista->Quant
			cDescricao	  := Lista->Descricao
			cTam			  := Lista->Tam
			cOriginal	  := Lista->n_Original
			nVarejo		  := Lista->Varejo

			if !( lFiltro )
				if nEstoAtual <= 0
					Entradas->(DbSkip(1))
					Loop
				endif
			endif

			cCodigo	:= Entradas->Codigo
			nEntrada := Entradas->Entrada
			dData 	:= Entradas->Data

			if xTemp->(!DbSeek( cCodigo ))
				xTemp->(DbAppend())
				xTemp->Codigo		:= cCodigo
				xTemp->Descricao	:= cDescricao
				xTemp->Quant		:= nEstoAtual
				xTemp->N_Original := cOriginal
				xTemp->Tam			:= cTam
				xTemp->Varejo		:= nVarejo
			endif

			if dData >= dIni .AND. dData <= dFim
				xTemp->Entrada := nEntrada
				xTemp->Data 	:= dData
			elseif dData < dIni
				xTemp->EntAnt	+= nEntrada
				xTemp->Data 	:= dData
			elseif dData > dFim
				xTemp->EntPos	+= nEntrada
				xTemp->Data 	:= dData
			endif
			Entradas->(DbSkip(1))
		Enddo
		Entradas->(DbClearRel())
		Entradas->(DbGoTop())
	EndCase

	xTemp->(DbGoTop())
	if xTemp->(Eof())
		xTemp->(DbCloseArea())
		Loop
	endif
	BEGIN
		oMenu:Limpa()
		M_Title("ESCOLHA ORDEM DO RELATORIO")
		nOrdem := FazMenu( 05, 10, aOrdem, Cor())
		Do Case
		Case nOrdem = 0
			xTemp->(DbCloseArea())
			Exit
		Case nOrdem = 1
			Mensagem("Aguarde: Ordenando Registros.", Cor())
			Inde On xTemp->Codigo To ( xNtx )

		Case nOrdem = 2
			Mensagem("Aguarde: Ordenando Registros.", Cor())
			Inde On xTemp->Descricao To ( xNtx )

		Case nOrdem = 3
			Mensagem("Aguarde: Ordenando Registros.", Cor())
			Inde On xTemp->N_Original To ( xNtx )

		Case nOrdem = 4
			Mensagem("Aguarde: Ordenando Registros.", Cor())
			Inde On xTemp->N_Original To ( xNtx )

		Case nOrdem = 5
			Mensagem("Aguarde: Ordenando Registros.", Cor())
			Inde On xTemp->Descricao + xTemp->Tam To ( xNtx )

		EndCase
		nSaidas		  := 0
		nEntrada 	  := 0
		nSaldo		  := 0
		nTam			  := 132
		Col			  := 58
		Pagina		  := 0
		nContador	  := 0
		lSair 		  := FALSO

		if !Instru80() .OR. !LptOk()
			Loop
		endif

		ResTela( cTela1 )
		Mensagem("Aguarde, Imprimindo. ", Cor())
		PrintOn()
		FPrint( PQ )
		SetPrc( 0, 0 )
		Area("xTemp")
		xTemp->(DbGoTop())
		cRefAnt	  := xTemp->N_Original
		nParcAnt   := 0
		nParcEnt   := 0
		nParcSai   := 0
		nParcSaldo := 0
		nParcAtual := 0
		WHILE xTemp->( !Eof()) .AND. Rel_Ok()
			if Col >= 58
				Write( 00, 00, Linha1( nTam, @Pagina))
				Write( 01, 00, Linha2())
				Write( 02, 00, Linha3(nTam))
				Write( 03, 00, Linha4(nTam, SISTEM_NA2 ))
				Write( 04, 00, Padc( "POSICAO DE ENTRADA E SAIDA DE PRODUTO NO PERIODO DE " + DToc( dIni ) + " A " + DToc( dFim ), nTam ))
				Write( 05, 00, Linha5(nTam))
				Write( 06, 00,"CODIGO REFERENCIA     TAM     DESCRICAO                                 VAREJO   (+)ANT   (+)ENT DATA ENT   (-)SAI   (=)SAL (*)ATUAL")
				Write( 07, 00, Linha5(nTam))
				Col := 8
			endif
			nAtual		  := xTemp->Quant
			nSaidas		  := xTemp->Saida
			nEntradas	  := xTemp->Entrada
			nSaiAnt		  := xTemp->SaiAnt
			nSaiDep		  := xTemp->SaiPos
			nEntAnt		  := xTemp->EntAnt
			nEntDep		  := xtemp->EntPos

			nEstoAnterior := ( nAtual + nSaidas ) - nEntradas
			nEstoAnterior := ( nEstoAnterior + nSaiDep ) - nEntDep

			nSaldo		  := ( nEstoAnterior + nEntradas ) - nSaidas
			cCodigo		  := xTemp->Codigo
			cDescricao	  := xTemp->(Left( Descricao, 33 ))
			nAtual		  := xTemp->Quant
			cOriginal	  := xTemp->N_Original
			cTam			  := xTemp->Tam
			nVarejo		  := xTemp->Varejo
			dData 		  := xTemp->Data
			nDif			  := nSaldo - ( nAtual - nEstoAnterior )

			Qout( cCodigo, cOriginal, cTam, cDescricao, Tran( nVarejo, "@E 999,999,999.99"),;
					Tran( nEstoAnterior,"99999.99"),;
					Tran( nEntradas,	  "99999.99"),;
					dData,;
					Tran( nSaidas, 	  "99999.99"),;
					Tran( nSaldo,		  "99999.99"),;
					Tran( nAtual,		  "99999.99"))
			Col++
			nContador++
			nParcAnt   += nEstoAnterior
			nParcEnt   += nEntradas
			nParcSai   += nSaidas
			nParcSaldo += nSaldo
			nParcAtual += nAtual
			cRefAnt	  := xTemp->N_Original
			xTemp->(DbSkip(1))
			if nOrdem = 4 // Agrupar
				if cRefAnt != xTemp->N_Original
					Qout( Repl("-",78 ),;
					Tran( nParcAnt,  "99999.99"),;
					Tran( nParcEnt,  "99999.99"),;
					Space(08),;
					Tran( nParcSai,  "99999.99"),;
					Tran( nParcSaldo,"99999.99"),;
					Tran( nParcAtual,"99999.99"))
					Col++
					Qout()
					Col++
					nParcAnt   := 0
					nParcEnt   := 0
					nParcSai   := 0
					nParcSaldo := 0
					nParcAtual := 0
				endif
			endif
			if Col >= 56 .OR. xTemp->(Eof())
				Qout( Repl( SEP, nTam ))
				Col := 58
				__Eject()
			endif
		EndDo
		PrintOff()
		ResTela( cTela1 )
	EndDo
EndDo

Function CodVal( Var, Var1, cGrupo, cSub )
******************************************
LOCAL Ind_Ant := IndexOrd()
LOCAL Arq_Ant := Alias()
LOCAL Reg_Ant := Recno()

if Empty( Var )
	ErrorBeep()
	Alerta( "Erro: Codigo Produto Invalido... ")
	AreaAnt( Arq_Ant, Ind_Ant )
	DbGoto( Reg_Ant )
	return( FALSO )

endif
if Var == Var1
	AreaAnt( Arq_Ant, Ind_Ant )
	DbGoto( Reg_Ant )
	return( OK )

endif
Area("Lista")
Order( 2 )
DbGoTop()
if ( DbSeek( Var ) )
	ErrorBeep()
	Alerta("Erro: Produto Ja Registrado..." )
	AreaAnt( Arq_Ant, Ind_Ant )
	DbGoto( Reg_Ant )
	return( FALSO )

endif
AreaAnt( Arq_Ant, Ind_Ant )
DbGoto( Reg_Ant )
return( OK )

Proc AntProx()
**************
LOCAL nCol := 14

cCodi  := Lista->Codi
cSigla := Lista->Sigla
if !Empty( cCodi )
	Pagarrado( cCodi, 09, nCol+19, @cSigla)
else
	Write( 09, nCol+19, Space(40))
endif
Write( 06, nCol,	 "Codigo......: " + Codigo )
Write( 07, nCol,	 "Codigo Fab..: " + N_Original )
Write( 08, nCol,	 "Descricao...: " + Descricao )
Write( 09, nCol,	 "Fornecedor..: " + cCodi )
Write( 10, nCol,	 "Unidade.....: " + Un )
Write( 11, nCol,	 "Quant.Min...: " + Str( QMin ))
Write( 12, nCol,	 "Quant.Max...: " + Str( QMax ))
Write( 13, nCol,	 "Embalagem...: " + Str( Emb ))
Write( 14, nCol,	 "Porc. Vend..: " + Str( Porc ))
Write( 15, nCol,	 "Preco Custo.: " + Tran( Pcusto, "@E 99,999,999.99" ))
Write( 16, nCol,	 "Preco Atac..: " + Tran( Atacado,"@E 99,999,999.99" ))
Write( 17, nCol,	 "Preco Varejo: " + Tran( Varejo, "@E 99,999,999.99" ))
return


Proc Ped_Cli9()
***************
LOCAL cScreen := SaveScreen()
LOCAL GetList := {}
LOCAL cFatura := Space(07)

oMenu:Limpa()
WHILE OK
	 Area("Saidas")
	 Saidas->(Order(TRES))
	 Saidas->(DbGoTop())
	 MaBox( 15, 10, 17, 37 )
	 cFatura := Space(7)
	 @ 16, 11 Say "Fatura N§.....¯" Get cFatura Pict "@!" Valid VisualAchaFatura( @cFatura )
	 Read
	 if LastKey() = K_ESC
		 ResTela( cScreen )
		 Exit
	 endif
	 Saidas->(DbGoTop())
	 Ped_Cli9_1( cFatura )
EndDo

Function Fornecedor( cCodi, nCliRecno, nRow, nCol )
***************************************************
LOCAL aRotina := {{|| ForInclusao() }}
LOCAL cScreen := SaveScreen()
LOCAL Ind_Ant := IndexOrd()
LOCAL Arq_Ant := Alias()
Area("Pagar")
Order( PAGAR_CODI )
DbGoTop()
if ( Lastrec() = 0 )
	ErrorBeep()
	if Conf( "Nenhum Fornecedor Registrado. Registrar ?" )
		ForInclusao()
	endif
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	return( FALSO )
endif
Cor := SetColor()
if !(DbSeek( cCodi ) )
	Order( PAGAR_NOME )
	DbGoTop()
	Escolhe( 03, 01, 22, "Codi + 'º' + Nome + 'º' + Sigla", "CODI NOME DO FORNECEDOR                       SIGLA", aRotina )
endif
SetColor( Cor )
nCliRecno := Pagar->(Recno())
cCodi 	 := Pagar->Codi
if nCol != VOID .AND. nRow != VOID
	Write( nRow, nCol, Space( 40 ))
	Write( nRow, nCol, Pagar->Nome )
endif
AreaAnt( Arq_Ant, Ind_Ant )
return(OK)

Function AchaDataIni( dIni, nRecno )
************************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Saidas->(Order( SAIDAS_EMIS ))
if Saidas->(!DbSeek( dIni ))
	ErrorBeep()
	Alerta("Erro: Data Inicial nao encontrada. ")
	AreaAnt( Arq_Ant, Ind_Ant )
	return(FALSO)
endif
nRecno := Saidas->(Recno())
AreaAnt( Arq_Ant, Ind_Ant )
return(OK)

Proc Cabec002( Pagina, Titulo, Tam, Cabecalho)
**********************************************
Write( 00, 00, Padr( "Pagina N§ " + StrZero( Pagina, 4 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
Write( 01, 00, Date() )
Write( 02, 00, Padc( XNOMEFIR, Tam ) )
Write( 03, 00, Padc( SISTEM_NA2, Tam ) )
Write( 04, 00, Padc( Titulo ,Tam ) )
Write( 05, 00, Repl( SEP, Tam ))
Write( 06, 00, Cabecalho )
Write( 07, 00, Repl( SEP, Tam ))
return

Function CodiMov( cCodigo )
***************************
LOCAL aRotina          := {{|| InclusaoProdutos() }}
LOCAL aRotinaAlteracao := {{|| InclusaoProdutos() }}
LOCAL Arq_Ant          := Alias()
LOCAL Ind_Ant          := IndexOrd()
cCodigo                := StrCodigo( cCodigo )

Lista->(Order(DOIS))
if Lista->(!DbSeek( cCodigo ))
	Area("Lista")
	Lista->(Order(TRES))
   Lista->(Escolhe( 03, 01, 22,"Codigo + 'º' + Descricao + 'º' + Sigla","CODIG DESCRICAO DO PRODUTO                     MARCA", aRotina,,aRotinaAlteracao ))
endif
cCodigo := Lista->Codigo
AreaAnt( Arq_Ant, Ind_Ant )
if !( DbSeek( cCodigo ))
	Nada()
	return( FALSO )
endif
return(OK)

Function SGrupoEra( cSubGrupo )
*******************************
LOCAL aRotina := {{|| Lista1_1() }}
if !( DbSeek( cSubGrupo ) )
	Escolhe( 03, 01, 22, "CodSgrupo + 'º' + DesSgrupo ", "CODIGO DESCRICAO DO SUBGRUPO", aRotina )
	cSubGrupo := CodSgrupo
endif
return( OK )

Proc VendasCliente()
********************
LOCAL GetList		:= {}
LOCAL cScreen		:= SaveScreen( )
LOCAL dIni			:= Date()-30
LOCAL dFim			:= Date()
LOCAL cCodi       := Space(05)
LOCAL Col			:= 10
LOCAL nTotal		:= 0
LOCAL nTotalGeral := 0
LOCAL cCodigo
LOCAL cDescricao
LOCAL cUn
LOCAL cOriginal

WHILE OK
	MaBox( 10, 10, 14, 35 )
   @ 11, 11 Say "Cliente......: " Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi )
	@ 12, 11 Say "Data Inicial.: " Get dIni  Pict PIC_DATA
	@ 13, 11 Say "Data Final...: " Get dFim  Pict PIC_DATA
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		Exit
	endif
	Lista->( Order( LISTA_CODIGO ))
	Area("Saidas")
	Saidas->(Order( SAIDAS_CODI ))
	if Saidas->(!DbSeek( cCodi ))
		ErrorBeep()
		Nada()
		ResTela( cScreen )
		Loop
	endif
	if Instru80()
		Mensagem("Informa: Aguarde, Localizando Registros")
		PrintOn()
		FPrint( PQ )
		CabecVen( dIni, dFim)
		WHILE Saidas->Codi = cCodi .AND. Rep_Ok()
			cCodigo	  := Saidas->Codigo
			if Lista->(DbSeek( cCodigo ))
				cDescricao := Lista->Descricao
				cUn		  := Lista->Un
				cOriginal  := Lista->N_Original
			endif
			Qout( Emis, CCodigo, cOriginal, Fatura, Ponto( cDescricao,40 ), cUn,;
					Placa, Saida, Tran( Pvendido,"@E 999,999,999,999.99"))
			nTotal		+= ( Pvendido * Saida )
			nTotalGeral += ( Pvendido * Saida )
			Col++
			Saidas->(DbSkip(1))
			if Col >= 55
				Write( ++Col, 103, Tran( nTotal,"@E 9,999,999,999,999.99"))
				CabecVen(dIni,dFim)
				Col	 := 10
				nTotal := 0
			endif
		EndDo
		Write( ++Col, 103, Tran( nTotal, 	 "@E 9,999,999,999,999.99"))
		Write( ++Col, 103, Tran( nTotalGeral,"@E 9,999,999,999,999.99"))
		__Eject()
		PrintOff()
	endif
	ResTela( cScreen )
EndDo

Proc CabecVen(dIni, dFim)
*************************
LOCAL  Tam	  := 132
STATIC Pagina := 0
		 cIni   := Dtoc( dIni )
		 cFim   := Dtoc( dFim )
Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina, 4 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
Write( 01, 00, Date() )
Write( 02, 00, Padc( XNOMEFIR, Tam ) )
Write( 03, 00, Padc( SISTEM_NA2, Tam ) )
Write( 04, 00, Padc( "RELATORIO DE VENDA INDIVIDUAL NO PERIODO DE &cIni. A &cFim" ,Tam ) )
Write( 05, 00, Repl( SEP, Tam ))
Write( 06, 00, NG + Receber->Codi + " " + Receber->Nome + " " + Receber->Fone + NR)
Write( 07, 00, Repl( SEP, Tam ))
Write( 08, 00, "EMISSAO  CODIGO  COD. FABRIC.   FATURA    DESCRICAO DO PRODUTO                     UN PLACA        QUANT      PRECO VENDIDO")
Write( 09, 00, Repl( SEP, Tam ))
return

Proc Ipi()
**********
LOCAL cScreen := SaveScreen()
LOCAL Tela_Impr
LOCAL Conta
LOCAL Relato
LOCAL Tam
LOCAL Pos1
LOCAL Line
LOCAL Pagina
LOCAL Ok
LOCAL Tot_Reg
LOCAL nReg
LOCAL Esc_Data
LOCAL aPedido
LOCAL nRecno
LOCAL aRegis
LOCAL aMenuArray := { " Por Periodo ", " Por Regiao ", " Todos " }

Saidas->(DbClearFilter())
Saidas->(DbClearRel())
Receber->(Order(2))
Lista->(Order(2))
Area( "Saidas" )
Set Rela To Codi Into Receber, Codigo Into Lista
DbGoTop()
nItens := 0
M_Title( "IMPRIMIR" )
Esc_Data := FazMenu( 10, 44, aMenuArray, Cor())
Do Case
Case Esc_Data = 0
	DbClearRel()
	ResTela( cScreen )
	return

Case Esc_Data = 1
	dIni	 := Date() - 30
	dFim	 := Date()
	nRecno := 0
	MaBox( 18, 20, 21, 56 )
	@ 19, 21 Say "Digite Emissao Inicial...¯" Get dIni Pict "@K##/##/##" Valid AchaDataIni( dIni, @nRecno )
	@ 20, 21 Say "Digite Emissao Final.....¯" Get dFim Pict "@K##/##/##"
	Read
	if LastKey() = ESC
		DbClearRel()
		ResTela( cScreen )
		return

	endif
	Order(6)  // Emis
	oMenu:Limpa()
	Mensagem(" Aguarde... Incluindo... ", WARNING )
	aPedido := {}
	aRegis  := {}
	bBloco := {|| Emis >= dIni .AND. Emis <= dFim }
	DbGoTo( nRecno )
	While Eval( bBloco )
		if Ascan( aPedido, Pedido ) = 0
			nItens++
			Aadd( aPedido, Pedido  )
			Aadd( aRegis,	Recno() )

		endif
		DbSkip()
	EndDo

Case Esc_Data = 2
	nRecno	:= 0
	cRegiao	:= Space(2)
	dIni		:= Date()-30
	dFim		:= Date()
	MaBox( 18, 20, 22, 56 )
	@ 19, 21 Say "Digite a Regiao..........¯" Get cRegiao Pict "99"
	@ 20, 21 Say "Digite Emissao Inicial...¯" Get dIni Pict PIC_DATA Valid AchaDataIni( dIni, @nRecno )
	@ 21, 21 Say "Digite Emissao Final.....¯" Get dFim Pict PIC_DATA
	Read
	if LastKey() = ESC
		DbClearRel()
		ResTela( cScreen )
		return

	endif
	Order(6)  // Emis
	oMenu:Limpa()
	Mensagem(" Aguarde... Incluindo... ", WARNING )
	aPedido := {}
	aRegis  := {}
	bBloco := {|| Emis >= dIni .AND. Emis <= dFim }
	DbGoto( nRecno )
	While Eval( bBloco )
		if Regiao = cRegiao
			if Ascan( aPedido, Pedido ) = 0
				nItens++
				Aadd( aPedido, Pedido  )
				Aadd( aRegis,	Recno() )
			endif
		endif
		DbSkip()
	EndDo

Case Esc_Data = 3
	Order( 6 )	// Emis
	oMenu:Limpa()
	Mensagem(" Aguarde... Incluindo... ", WARNING )
	aPedido := {}
	aRegis  := {}
	While !Eof()
		if Ascan( aPedido, Pedido ) = 0
			nItens++
			Aadd( aPedido, Pedido  )
			Aadd( aRegis,	Recno() )

		endif
		DbSkip()
	EndDo

EndCase
if nItens = 0
	oMenu:Limpa()
	ErrorBeep()
	Alerta( "Erro: Nenhuma Pedido Disponivel...")
	Saidas->( DbClearRel() )
	Saidas->( DbClearFilter() )
	DbGoTop()
	ResTela( cScreen )
	return

endif
oMenu:Limpa()
Conta := 0
Sobra := nItens
MaBox( 06, 00, 08, 79 )
Write( 07, 01, "Total de Pedidos.¯ " + StrZero( nItens,4 ) )
Write( 07, 26, "Selecionadas.....¯ " + StrZero( Conta, 4 ) )
Write( 07, 51, "Disponiveis......¯ " + StrZero( Sobra, 4 ) )
Priv Registro := {},  NoFatu := {}, Col := 11

MaBox( 10, 26, 22, 79 , "PEDIDO   CODI NOME CLIENTE                      " )
WHILE OK
	MaBox( 10, 00, 20, 20 , "PEDIDOS")
	Escolha := Achoice( 11, 03, 19, 19, aPedido )
	if Escolha = 0 			  // Esc ?
		Exit						  // ... Entao Vaza.

	endif
	DbGoTo( aRegis[ Escolha ] )
	Aadd( Registro, aRegis[ Escolha ] )
	Aadd( NoFatu,	 aPedido[ Escolha ] )
	Write( 07, 45, StrZero( ++Conta, 4 ) ,"R/W")
	Write( 07, 70, StrZero( --Sobra, 4 ) ,"R/W")
	Write( Col, 27, Pedido + "    " + Codi + ' ' + Receber->( Left( nome, 36 ) ) , "R/W")
	Adel( aPedido, Escolha )
	Adel( aRegis, Escolha )
	if Col = 21
		Scroll( 11, 27, 21, 78, 1 )
		Col := 21
	else
		Col++
	endif
Enddo
Order( 3 )
DbGoTop()
if (Tamanho := Len( Nofatu )) > 0
	if Conf( 'Confirma Impressao do Demostrativo ?' )
		cCodigo := {}
		cDesc   := {}
		nQuant  := {}
		nSaida  := {}
		if !Instru80() .OR. !LptOk()
			ResTela( cScreen )
			return
		endif
		Tela_Impr := SaveScreen()
		Mensagem("Aguarde ... Somando...", Cor())
		Cabecalho := "DESCRICAO DO PRODUTO                     QUANT.     P.CUSTO       P.TOTAL ALQ.II     VALOR.II ALQ.IPI   VALOR IPI  UFIR/AQU       II/UFIR        IPI/UFIR"
		Relato	 := "DEMOSTRATIVO DE APURACAO DO IMPOSTO DE IMPORTACAO E SOBRE PRODUTOS INDUSTRIALIZADOS"
		Tam		 := 153
		Line		 := 8
		Pagina	 := 0
		PosCur	 := 0
		Area("Saidas")
		Order(4) 	  // PEDIDO.NTX
		For xY := 1 To Len( Nofatu )
			nReco := Registro[ xY ]
			DbGoTo( nReco )
			bBloco := {|| Pedido = Nofatu[ XY ] }
			While Eval( bBloco )
				nPos := Ascan2( cCodigo, Codigo, 1 )
				if nPos = 0 							 // Nao Encontrado ? Inclui.
					Order(2)
					Aadd( cCodigo, { Codigo, Lista->Descricao, Saida, Lista->Pcusto, Lista->Ii, Lista->Ipi, Lista->Ufir } )
				else
				  nQtAnt := cCodigo[ nPos, 3]
				  cCodigo[ nPos, 3 ] := ( nQtAnt + Saida )
				endif
				Order(4)
				DbSkip()
			EndDo
		Next
		Mensagem("Aguarde ... Somando e Imprimindo...", Cor())
		nTamArray := Len( cCodigo )
		Asort( cCodigo,,, {| x,y | y[2] > x[2] } )
		PrintOn()
		FPrint( _CPI12 )
		SetPrc( 0, 0 )
		Cabec002( ++Pagina, Relato, Tam, Cabecalho)
		yCusto  := 0
		yIi		  := 0
		yIpi		  := 0
		yUfir 	  := 0
		yIiUfir	  := 0
		yIpiUfir   := 0
		For i := 1 To Len( cCodigo )
			if Line >=	58
				__Eject()
				Cabec002( ++Pagina, Relato, Tam, Cabecalho)
				Line := 8
			endif
			xDescricao := cCodigo[i,2]
			xSaida	  := cCodigo[i,3]
			xPcusto	  := cCodigo[i,4]
			xIi		  := cCodigo[i,5]
			xIpi		  := cCodigo[i,6]
			xUfir 	  := cCodigo[i,7]
			nSomaItem  := ( xSaida * xPcusto )
			nSomaIpi   := ( nSomaItem * xIpi ) / 100
			nSomaIi	  := ( nSomaItem * xIi	) / 100
			nRedIpi	  := Round(( nSomaIpi / xUfir ),4)
			nRedIi	  := Round(( nSomaIi  / xUfir ),4)
			xSaida	  := Str( xSaida, 9,2)

			yCusto	+= nSomaItem
			yIi		+= nSomaIi
			yIpi		+= nSomaIpi
			yUfir 	+= xUfir
			yIiUfir	+= nRedIi
			yIpiUfir += nRedIpi
			Qout( Ponto( Left( xDescricao,37),37), xSaida, xPcusto, Tran( nSomaItem,"99999999.9999"),;
					xIi, nSomaIi, xIpi, nSomaIpi, xUfir, nRedIi, nRedIpi )
			Line ++
		Next
		if Line >= 51
			__Eject()
			Cabec002( ++Pagina, Relato, Tam, Cabecalho)
			Line := 8
		endif
		Qout("")
		Qout( Repl("-", 153))
		Qout("** TOTAIS **")
		QQout( Space(45), yCusto, Space(5), yIi, Space(5), yIpi, xUfir, yIiUfir, yIpiUfir )
		Qout( Repl("-", 153))
		nUfir := 0
		Area("Taxas")
		Order(DOIS) // Validade
		WHILE !DbSeek( Date())
			ErrorBeep()
			if Conf("Ufir Valida para " + Dtoc(Date()) + " Nao Encontrada. Registrar ? ")
				InclusaoTaxas( Date())
			endif
		EndDo
		nRec := Taxas->(Recno())
		WHILE ( nUfir := Taxas->Ufir ) = 0
			ErrorBeep()
			Alerta(" Registre Valor para Ufir de " + Dtoc( Date()))
			TaxasDbEdit()
			DbGoTo( nRec )
		EndDo
		nUfir := Taxas->Ufir
		Qout("VALOR UNIDADE FISCAL DE REFERENCIA - UFIR DE " + Dtoc( Date()))
		QQout( Space( 89 ), nUfir )
		Qout( Repl("-", 153))
		Qout("VALOR TOTAL DO IMPOSTO DE IMPORTACAO E SOBRE PRODUTOS INDUSTRIALIZADOS A RECOLHER")
		QQout( Space( 42 ), Round(yIiUfir * nUfir,2), Space(1), Round(yIpiUfir * nUfir,2))
		Qout( Repl("-", 153))
		__Eject()
		PrintOff()
		ResTela( Tela_Impr )
		DbClearFilter( )
		DbGoTop()
		DbClearRel()
	endif
endif
ResTela( cScreen )
return


Proc Ped_Cli9_1( cNrfatu )
**************************
LOCAL cScreen	:= SaveScreen()
LOCAL nTotFatu := 0
LOCAL nTotRece := 0
LOCAL cFile1
LOCAL cFile2
LOCAL cFile3

oMenu:Limpa()
Lista->(Order(DOIS))
Area("Saidas")
Set Rela To Codigo Into Lista
Order(TRES)  // FATURA
DbGoTop()
bBloco := {|| Saidas->Fatura = cNrFatu }
DbSeek( cNrFatu )
cCodi  := Codi
cFile1 := TempNew()
Copy Stru Fields Codigo, Saida, Data, Fatura, Pedido, Pvendido, Placa, Forma To ( cFile1 )
Use ( cFile1 ) Alias SaiTemp Exclusive New
WHILE Eval( bBloco )
	SaiTemp->( DbAppend())
	SaiTemp->Codigo	 := Saidas->Codigo
	SaiTemp->Saida 	 := Saidas->Saida
	SaiTemp->Data		 := Saidas->Data
	SaiTemp->Fatura	 := Saidas->Fatura
	SaiTemp->Pedido	 := Saidas->Pedido
	SaiTemp->PVendido  := Saidas->Pvendido
	SaiTemp->Placa 	 := Saidas->Placa
	SaiTemp->Forma 	 := Saidas->Forma
	nTotFatu += Saidas->Saida * Saidas->Pvendido
	Saidas->( DbSkip( 1 ) )

Enddo
Sele SaiTemp
Set Rela To Codigo Into Lista
oSaidas := CriaBrowse( 15, 01, 23, MaxCol()-1, "VALOR TOTAL DA FATURA ¯ " + Tran( nTotFatu, "@E 9,999,999,999.99") )
oSaidas:AddColumn( TBColumnNew( "CODIGO ",   {||codigo } ))
oSaidas:AddColumn( TBColumnNew( "DESCRICAO DO PRODUTO",{|| Lista->Descricao } ))
oSaidas:AddColumn( TBColumnNew( "QUANT",     {||Saida } ))
oSaidas:AddColumn( TBColumnNew( "PVENDIDO",  {||Tran( Pvendido,"@E 999,999.99") } ) )
oSaidas:AddColumn( TBColumnNew( "TOTAL ITEM",{||Tran( (saida * pvendido) ,"@E 9,999,999.99") } ) )
oSaidas:AddColumn( TBColumnNew( "UN",        {||Lista->Un } ))
oSaidas:AddColumn( TBColumnNew( "EMISSAO",   {||Data } ) )
oSaidas:AddColumn( TBColumnNew( "FORMA PGTO",{||Forma } ) )
oSaidas:AddColumn( TBColumnNew( "FATURA N§", {||Fatura } ) )
oSaidas:AddColumn( TBColumnNew( "PEDIDO N§", {||Pedido } ) )
oSaidas:AddColumn( TBColumnNew( "PLACA"    , {||Placa  } ) )
Coluna:=oSaidas:GetColumn(4)       // Pvendido
Coluna:DefColor := { 7, 8 }
Coluna:=oSaidas:GetColumn(5)      // Total
Coluna:DefColor := { 7, 8 }

WHILE ( !oSaidas:Stabilize() )
EndDo

Sele Receber
Order(DOIS)
DbSeek( cCodi )
cFile2 := TempNew()
Copy To ( cFile2 ) Reco Recno()
Use ( cFile2 ) Alias ReceTemp Exclusive New
oReceber := CriaBrowse( 10, 01, 12, MaxCol()-1, "DADOS DO CLIENTE" )
For i := 1 To Fcount()
	oReceber:AddColumn( TbColumnnew( FieldName( i ), FieldwBlock( FieldName( i ), Sele() ) ) )
Next
WHILE ( !oReceber:Stabilize() )
EndDo

Sele ReceMov
Order(QUATRO)	// Fatura
DbGoTop()
oBloco := {|| Recemov->Fatura = cNrFatu }
DbSeek( cNrFatu )
cFile3 := TempNew()
Copy Stru Fields Docnr, Vlr, Vcto, Tipo, Emis, Juro, Port, VlrFatu To ( cFile3 )
Use ( cFile3) Alias MovTemp Exclusive New
WHILE Eval( oBloco )
	MovTemp->( DbAppend())
	MovTemp->Docnr 	 := Recemov->Docnr
	MovTemp->Vlr		 := Recemov->Vlr
   MovTemp->Emis      := Recemov->Emis
   MovTemp->Vcto      := Recemov->Vcto
	MovTemp->Tipo		 := Recemov->Tipo
	MovTemp->Juro		 := Recemov->Juro
	MovTemp->Port		 := "NAO"
   MovTemp->VlrFatu   := 0
	nTotRece 			 += Recemov->Vlr
	Recemov->( DbSkip())
Enddo

Recebido->(Order(QUATRO)) // Fatura
bBloco := {|| Recebido->Fatura = cNrFatu }
Recebido->(DbSeek( cNrFatu ))
WHILE Eval( bBloco )
	MovTemp->( DbAppend())
	MovTemp->Docnr 	 := Recebido->Docnr
	MovTemp->Vlr		 := Recebido->Vlr
   MovTemp->Emis      := Recebido->Emis
   MovTemp->Vcto      := Recebido->Vcto
	MovTemp->Tipo		 := Recebido->Tipo
	MovTemp->Juro		 := Recebido->Juro
	MovTemp->Port		 := Recebido->(Dtoc( DataPag))
   MovTemp->VlrFatu   := Recebido->VlrPag
	nTotRece 			 += Recebido->Vlr
	Recebido->(DbSkip())
Enddo

oRecemov := CriaBrowse( 01, 01, 07, MaxCol()-1, "DESDOBRAMENTO R$  " + Tran( nTotRece, "@E 9,999,999,999.99") )
DbGotop()
oRecemov:AddColumn(TBColumnNew( "TITULO N§ ", {|| DocNr } ))
oRecemov:AddColumn(TBColumnNew( "TIPO",       {|| tipo } ))
oRecemov:AddColumn(TBColumnNew( "EMIS",       {|| Emis } ))
oRecemov:AddColumn(TBColumnNew( "VCTO",       {|| vcto } ))
oRecemov:AddColumn(TBColumnNew( "VALOR",      {|| Tran( Vlr,"@E 999,999.99") } ))
oRecemov:AddColumn(TBColumnNew( "VLR REC",    {|| VlrFatu } ) )
oRecemov:AddColumn(TBColumnNew( "BX",         {|| port } ) )
coluna:=oRecemov:GetColumn(5)       // Vlr
coluna:DefColor := { 7, 8 }
coluna:=oRecemov:GetColumn(6)
coluna:DefColor := { 7, 8 }
WHILE ( !oRecemov:Stabilize())
EndDo

oBrowse := oSaidas
Sele SaiTemp
WHILE OK
	WHILE (! oBrowse:Stabilize())
		Tecla := InKey()
		if (Tecla != ZERO )
			Exit

		endif
	EndDo
	if oBrowse:HitTop .OR. oBrowse:HitBottom
		ErrorBeep()

	endif
	Tecla := InKey( ZERO )
	if Tecla == K_ESC
		 DbClearRel()
		 SaiTemp->( DbCloseArea())
		 ReceTemp->( DbCloseArea())
		 MovTemp->( DbCloseArea())
		 Ferase( cFile1 )
		 Ferase( cFile2 )
		 Ferase( cFile3 )
		 ResTela( cScreen )
		 Area("Saidas")
		 Exit

  elseif Tecla == K_ALT_F1
	  MudaTab1()
  elseif Tecla == K_ALT_F2
	  MudaTab2()
  elseif Tecla == K_ALT_F3
	  MudaTab3()
  elseif Tecla == F10
	  Calc()
  elseif Tecla == F5
	  TabPreco()
  else
		TestaTecla(Tecla, oBrowse)
	endif
EndDo

Function MudaTab1()
*******************
oBrowse := oRecemov
Sele MovTemp

Function MudaTab2()
*******************
oBrowse := oReceber
Sele ReceTemp

Function MudaTab3()
*******************
oBrowse := oSaidas
Sele SaiTemp

Function Acha_Tem( cFatura, cCodigo, Reg_Atual, Reg_Ant, lJahTem)
*******************************************************************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cProcura := cFatura + Space(2) + StrCodigo( cCodigo )

Area("Saidas")
Order(CINCO)	// Fatura + Codigo
if !( DbSeek( cProcura ))
	ErrorBeep()
	if Conf( "Produto Nao Consta na Fatura. Incluir ?" )
		Lista->(Order(DOIS)) 			  // CODIGO
		if Lista->(!DbSeek( cCodigo ))  // Nao Encontrou
			ErrorBeep()
			Alerta("Erro: Produto Nao Registrado...")
			AreaAnt( Arq_Ant, Ind_Ant )  // Seleciona Area Anterior ...
			return( FALSO )
		else
			AreaAnt( Arq_Ant, Ind_Ant )			// Seleciona Area Anterior ...
			// Appe Reco Reg_Ant From Saidas 		// Adiciona um Registro em Saidas
			// DbAppend()

			Area("Saidas")
			if Saidas->( !Incluiu())
				AreaAnt( Arq_Ant, Ind_Ant )  // Seleciona Area Anterior ...
				return(FALSO)
			else
				For nField := 1 To Saidas->(FCount())
					FieldPut( nField, Saidas->(FieldGet( nField )))
				Next
			endif
			Saidas->Codigo   := Lista->Codigo	// Inclui o Novo Codigo no registro
			Saidas->Saida	  := 0					// registro novo. Saida = 0
			Saidas->Pvendido := Lista->Atacado	// idem
			Reg_Atual := Saidas->(Recno())
			lJahTem	 := FALSO
			return(OK)
		endif
	else
		AreaAnt( Arq_Ant, Ind_Ant )  // Seleciona Area Anterior ...
		return(FALSO)
	endif
else										  // Se Encontrou o Registro
	ErrorBeep()
	if Conf( "Produto Ja Consta na Fatura. Alterar Quantidade ? " )
		Reg_Atual := Saidas->(Recno())
		AreaAnt( Arq_Ant, Ind_Ant )  // Seleciona Area Anterior ...
		lJahTem := OK
		return(OK)
	else
		AreaAnt( Arq_Ant, Ind_Ant )  // Seleciona Area Anterior ...
		return(FALSO)
	endif
endif

Proc Pedidos()
**************
LOCAL cScreen := SaveScreen()
LOCAL Salva_Tela, nChoice
LOCAL aMenuArray := { " Visualizar Pedido "," Imprimir Pedido   " }

WHILE OK
   oMenu:Limpa()
   M_Title( "PEDIDOS A FORNECEDOR" )
   nChoice := FazMenu( 02, 08, aMenuArray, Cor())
   if nChoice = 0
      ResTela( cScreen )
      return
   else
      PedidoDbedit( nChoice )
   endif
EndDo

Proc PedidoDbedit( nVerOuImprimir )
***********************************
LOCAL cScreen		:= SaveScreen()
LOCAL aMedia      := { "Normal", "Com Media Venda"}
LOCAL aMenuArray  := { "Individual", "Parcial", "Por Grupo", "Por SubGrupo", "Por Fornecedor", "Geral" }
LOCAL cArquivo    := FTempName()
LOCAL nChoice		:= 0
LOCAL nTotalGeral := 0
LOCAL aVetor1
LOCAL aVetor2
LOCAL cSubIni
LOCAL cSubFim
LOCAL nMedia

WHILE OK
   nMedia := FazMenu( 04, 10, aMedia )
   if nMedia = 0
		ResTela( cScreen )
		Exit
   endif
   if nVerOuImprimir = 1 // Visualizar
		M_Title("VISUALIZAR PEDIDOS A FORNECEDOR")
	else
		M_Title("IMPRIMIR PEDIDOS A FORNECEDOR")
	endif
   nChoice := FazMenu( 06, 12, aMenuArray, Cor())
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1 // Individual
		xCodigo := 0
		MaBox( 16, 12, 18, 68, "ENTRE COM O CODIGO")
		@ 17, 13 Say "Codigo.:" Get xCodigo Pict PIC_LISTA_CODIGO Valid CodiErrado( @xCodigo, NIL, NIL, Row(), Col()+1)
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Area("Lista")
		Copy Stru To ( cArquivo )
		Use (cArquivo) Exclusive Alias xTemp New
		Lista->(Order(2)) // CODIGO
		oBloco := {|| Lista->Codigo = xCodigo }
      cTela := Mensagem("Aguarde...", Cor())
		if Lista->(!DbSeek( xCodigo ))
			Nada()
			xTemp->(DbCloseArea())
			Ferase( cArquivo )
			ResTela( cScreen )
			Loop
		endif
		WHILE Lista->(Eval( oBloco )) .AND. Rep_Ok()
			cCodigo := Lista->Codigo
			if Lista->Quant < Lista->Qmin
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					FieldPut( nField, Lista->(FieldGet( nField )))
				Next
			endif
			Lista->(DbSkip(1))
		EndDo
		xTemp->(DbGoTop())
		Lista->(Order(DOIS))
		Set Rela To Codigo Into Lista
		ResTela( cTela )
		if nVerOuImprimir = 1
			VerPedido()
		else
			PedidoImprime()
		endif
		xTemp->(DbClearFilter())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( cArquivo )
		ResTela( cScreen )
		Loop

	Case nChoice = 2 // Parcial
		xCodigoIni := 0
		xCodigoFim := 0
      MaBox( 16, 12, 19, 76, "ENTRE COM OS CODIGOS")
		@ 17, 13 Say "Codigo Inicial.:" Get xCodigoIni Pict PIC_LISTA_CODIGO Valid CodiErrado( @xCodigoIni, NIL, NIL, Row(), Col()+1 )
		@ 18, 13 Say "Codigo Final...:" Get xCodigoFim Pict PIC_LISTA_CODIGO Valid CodiErrado( @xCodigoFim, NIL, NIL, Row(), Col()+1 )
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Area("Lista")
		Copy Stru To ( cArquivo )
		Use (cArquivo) Exclusive Alias xTemp New
		Lista->(Order(2)) // CODIGO
		oBloco := {|| Lista->Codigo >= xCodigoIni .AND. Lista->Codigo <= xCodigoFim }
		cTela := Mensagem("Aguarde... ", Cor())
		if Lista->(!DbSeek( xCodigoIni ))
			Nada()
			xTemp->(DbCloseArea())
			Ferase( cArquivo )
			ResTela( cScreen )
			Loop
		endif
		WHILE Lista->(Eval( oBloco )) .AND. Rep_Ok()
			cCodigo := Lista->Codigo
			if Lista->Quant < Lista->Qmin
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					FieldPut( nField, Lista->(FieldGet( nField )))
				Next
			endif
			Lista->(DbSkip(1))
		EndDo
		xTemp->(DbGoTop())
		Lista->(Order(DOIS))
		Set Rela To Codigo Into Lista
		ResTela( cTela )
		if nVerOuImprimir = 1
	 VerPedido()
		else
			PedidoImprime()
		endif
		xTemp->(DbClearFilter())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( cArquivo )
		ResTela( cScreen )
		Loop

	Case nChoice = 3	// Por Grupo
		cGrupoIni  := Space(03)
		cGrupoFim  := Space(03)
		xCodigoIni := 0
		xCodigoFim := 0
      MaBox( 16, 12, 19, 73, "ENTRE COM O GRUPO")
		@ 17, 13 Say "Grupo Inicial.:" Get cGrupoIni Pict "999" Valid GrupoCerto( @cGrupoIni, Row(), Col()+1 )
		@ 18, 13 Say "Grupo Final...:" Get cGrupoFim Pict "999" Valid GrupoCerto( @cGrupoFim, Row(), Col()+1 )
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Area("Lista")
		Copy Stru To ( cArquivo )
		Use (cArquivo) Exclusive Alias xTemp New
		Lista->(Order(1)) // CODGRUPO
		oBloco := {|| Lista->CodGrupo >= cGrupoIni .AND. Lista->CodGrupo <= cGrupoFim }
		cTela  := Mensagem("Aguarde... ", Cor())
		lAchou := FALSO
		WHILE Lista->(!(lAchou := DbSeek( cGrupoIni )))
			cGrupoIni := StrZero( Val( cGrupoIni ) + 1, 3 )
			if cGrupoIni > cGrupoFim
				Nada()
				xTemp->(DbCloseArea())
				Ferase( cArquivo )
				Exit
			endif
		EndDo
		if !lAchou
			ResTela( cScreen )
			Exit
		endif
		WHILE Lista->(Eval( oBloco )) .AND. Rep_Ok()
			cCodigo := Lista->Codigo
			if Lista->Quant < Lista->Qmin
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					FieldPut( nField, Lista->(FieldGet( nField )))
				Next
			endif
			Lista->(DbSkip(1))
		EndDo
		xTemp->(DbGoTop())
		Lista->(Order(DOIS))
		Set Rela To Codigo Into Lista
		ResTela( cTela )
		if nVerOuImprimir = 1
	 VerPedido()
		else
			PedidoImprime()
		endif
		xTemp->(DbClearFilter())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( cArquivo )
		ResTela( cScreen )
		Loop

   Case nChoice = 4  // Por SubGrupo
      cSubIni    := Space(06)
      cSubFim    := Space(06)
		xCodigoIni := 0
		xCodigoFim := 0
      MaBox( 16, 12, 18, 73, "ENTRE COM O SUBGRUPO")
      @ 17, 13 Say "SubGrupo.:" Get cSubIni Pict "999.99" Valid SubErrado( @cSubIni, Row(), Col()+1 )
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Area("Lista")
		Copy Stru To ( cArquivo )
		Use (cArquivo) Exclusive Alias xTemp New
      Lista->(Order( LISTA_SUBGRUPO ))
      oBloco := {|| Lista->CodSGrupo = cSubIni }
		cTela  := Mensagem("Aguarde... ", Cor())
      if Lista->(!DbSeek( cSubIni ))
         Nada()
         xTemp->(DbCloseArea())
         Ferase( cArquivo )
			ResTela( cScreen )
			Exit
		endif
		WHILE Lista->(Eval( oBloco )) .AND. Rep_Ok()
			cCodigo := Lista->Codigo
			if Lista->Quant < Lista->Qmin
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					FieldPut( nField, Lista->(FieldGet( nField )))
				Next
			endif
			Lista->(DbSkip(1))
		EndDo
		xTemp->(DbGoTop())
		Lista->(Order(DOIS))
		Set Rela To Codigo Into Lista
		ResTela( cTela )
		if nVerOuImprimir = 1
         VerPedido()
		else
			PedidoImprime()
		endif
		xTemp->(DbClearFilter())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( cArquivo )
		ResTela( cScreen )
		Loop

   Case nChoice = 5 // Por Fornecedor
		cCodi   := Space(04)
      MaBox( 16, 12, 18, 72, "ENTRE COM O FORNECEDOR")
		@ 17, 13 Say "Fornecedor.:" Get cCodi Pict "9999" Valid Pagarrado( @cCodi, Row(), Col()+1 )
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Area("Lista")
		Copy Stru To ( cArquivo )
		Use (cArquivo) Exclusive Alias xTemp New
		Lista->(Order(6)) // CODI
		oBloco := {|| Lista->Codi = cCodi }
		cTela := Mensagem("Aguarde... ", Cor())
		if Lista->(!DbSeek( cCodi ))
			Nada()
			xTemp->(DbCloseArea())
			Ferase( cArquivo )
			ResTela( cScreen )
			Loop
		endif
		WHILE Lista->(Eval( oBloco )) .AND. Rep_Ok()
			cCodigo := Lista->Codigo
			if Lista->Quant < Lista->Qmin
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					FieldPut( nField, Lista->(FieldGet( nField )))
				Next
			endif
			Lista->(DbSkip(1))
		EndDo
		xTemp->(DbGoTop())
		Lista->(Order(DOIS))
		Set Rela To Codigo Into Lista
		ResTela( cTela )
		if nVerOuImprimir = 1
	 VerPedido()
		else
			PedidoImprime()
		endif
		xTemp->(DbClearFilter())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( cArquivo )
		ResTela( cScreen )
		Loop

   Case nChoice = 6 // Geral
		Area("Lista")
		Lista->(Order(3))
		Lista->(DbGoTop())
		Copy Stru To ( cArquivo )
		Use (cArquivo) Exclusive Alias xTemp New
		cTela := Mensagem("Aguarde... ", Cor())
		WHILE Lista->(!Eof())
			if Lista->Quant < Lista->Qmin
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					FieldPut( nField, Lista->(FieldGet( nField )))
				Next
			endif
			Lista->(DbSkip(1))
		EndDo
		xTemp->(DbGoTop())
		Lista->(Order(DOIS))
		Set Rela To Codigo Into Lista
		ResTela( cTela )
		if nVerOuImprimir = 1
         VerPedido()
		else
			PedidoImprime()
		endif
		xTemp->(DbClearFilter())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( cArquivo )
		ResTela( cScreen )
		Loop
   EndCase
EndDo

Proc VerPedido()
****************
LOCAL cScreen		:= SaveScreen()
LOCAL nTotalGeral := 0
PRIVA aVetor1
PRIVA aVetor2

oMenu:Limpa()
Mensagem("Aguarde... Calculando Pedido. ", WARNING )
WHILE xTemp->(!EoF())
	nTotalGeral += Pcusto * (Qmin-Quant)
	xTemp->(DbSkip(1))
EndDo
xTemp->(DbGoTop())
aVetor1 := {"Codigo","Descricao", "Un", "Quant", "Qmin",;
				"Qmax", "(Qmin-Quant)","Tran(Varejo, '@E 9,999,999,999.99')",;
				"Tran(Pcusto, '@E 9,999,999,999.99')",;
				"Tran(Pcusto * (Qmin-Quant),'@E 9,999,999,999.99')" }

aVetor2 := {"CODIGO","DESCRICAO DO PRODUTO", "UN", "ESTOQUE", "Q.MIN",;
				"Q.MAX", "FALTANTE", "P.VENDA VAREJO", "P.CUSTO", "TOTAL PEDIDO" }

oMenu:Limpa()
MaBox( 22, 00, 24, 79)
Write( 23, 01," Total Geral Pedido ¯ " + Tran( nTotalGeral,"@E 999,999,999,999.99"))
MaBox( 00, 00, 21, 79,"CONSULTA DE PRODUTOS ABAIXO DO MINIMO")
Seta1(21)
DbEdit( 01, 01, 20, 78, aVetor1, OK, OK, aVetor2 )
ResTela( cScreen )
return

Function FornFrete( cCodi, nVlrFrete)
************************************
LOCAL aRotina := {{|| ForInclusao() }}
LOCAL cScreen := SaveScreen()
LOCAL Ind_Ant := IndexOrd()
LOCAL Arq_Ant := Alias()
if ( Empty( cCodi ) .AND. nVlrFrete = 0 )
	return( OK )
endif
Area("Pagar")
Order( PAGAR_CODI )
if ( Lastrec() = 0 )
	ErrorBeep()
	if Conf( "Nenhum Fornecedor Registrado... Registrar ?" )
		ForInclusao()
	endif
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	return( FALSO )
endif
Cor := SetColor()
if !(DbSeek( cCodi ) )
	Order( PAGAR_NOME )
	DbGoTop()
	Escolhe( 03, 01, 22, "Codi + 'º' + Nome + 'º' + Sigla", "CODI NOME DO FORNECEDOR                       SIGLA", aRotina )
endif
SetColor( Cor )
cCodi := Codi
Write( 14, 20 , Space( 40 ) )
Write( 14, 20 , Nome )
AreaAnt( Arq_Ant, Ind_Ant )
return(OK)

Proc VendasTipo()
*****************
LOCAL GetList		 := {}
LOCAL cScreen		 := SaveScreen()
LOCAL cCodigo		 := 999999
LOCAL cCodi        := "99999"
LOCAL cForma		 := "99"
LOCAL cTipo 		 := PIC_LISTA_CODIGO
LOCAL dIni			 := Date()-30
LOCAL dFim			 := Date()
LOCAL Col			 := 10
LOCAL nTotal		 := 0
LOCAL nTotalGeral  := 0
LOCAL nVarejo		 := 0
LOCAL nTotalVarejo := 0
LOCAL nQuant		 := 0
LOCAL nQuantGeral  := 0
LOCAL nSobra		 := 0
LOCAL lCodigo		 := FALSO
LOCAL lCodi 		 := FALSO
LOCAL lTipo 		 := FALSO
LOCAL lForma		 := FALSO
LOCAL xArquivo 	 := FTempname("T*.TMP")
LOCAL xNtx			 := FTempname("T*.TMP")
LOCAL aMenu 		 := {"Emissao", "Codigo", "Fatura", "Tipo", "Fatura+Codigo", "Emissao+Fatura"}
LOCAL nChoice
LOCAL oBloco
LOCAL nField
LOCAL cTela
FIELD Emis
FIELD Fatura
FIELD Tipo
FIELD Nome
FIELD Codigo
FIELD Descricao
FIELD Saida
FIELD Varejo
FIELD PVendido

WHILE OK
	cCodigo	:= 999999
   cCodi    := "99999"
	cTipo 	:= PIC_LISTA_CODIGO
	cForma	:= "99"
	MaBox( 05, 10, 12, 35 )
   @ 06, 11 Say "Cliente      : " Get cCodi   Pict PIC_RECEBER_CODI Valid ComSemCli( @cCodi, @lCodi )
	@ 07, 11 Say "Produto      : " Get cCodigo Pict PIC_LISTA_CODIGO Valid ComSemProd( @cCodigo, @lCodigo )
	@ 08, 11 Say "Tipo         : " Get cTipo   Pict "@!"             Valid ComSemTipo( @cTipo, @lTipo )
	@ 09, 11 Say "Forma Pgto   : " Get cForma  Pict "99"             Valid ComSemForma( @cForma, @lForma )
	@ 10, 11 Say "Emis Inicial : " Get dIni    Pict PIC_DATA
	@ 11, 11 Say "Emis Final   : " Get dFim    Pict PIC_DATA
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		Exit
	endif
	cTela := Mensagem("Aguarde, Processando.", Cor())
	Area("Saidas")
   Saidas->(Order(SAIDAS_EMIS)) // Emis
	nTotal		 := 0
	nVarejo		 := 0
	nTotalVarejo := 0
	nTotalGeral  := 0
	nQuant		 := 0
	nQuantGeral  := 0
	nSobra		 := 0
	oBloco		 := {|| Saidas->Emis >= dIni .AND. Saidas->Emis <= dFim }
	Copy Stru To ( xArquivo )
	Use (xArquivo) Exclusive Alias xNewDbf New
	Set Soft On
	Saidas->(DbSeek( dIni ))
	Set Soft Off
	WHILE Eval( oBloco ) .AND. Rep_Ok()
		xNewDbf->(DbAppend())
		For nField := 1 To FCount()
			xNewDbf->(FieldPut( nField, Saidas->(FieldGet( nField ))))
		Next
		Saidas->(DbSkip(1))
	EndDo
	ResTela( cTela )
	xNewDbf->(DbGoTop())
	if xNewDbf->(Eof())
		xNewDbf->(DbCloseArea())
		Ferase( xArquivo )
		Ferase( xNtx )
		ErrorBeep()
		Alerta("Informa: Nada Consta.")
		ResTela( cScreen )
		Loop
	endif
	oMenu:Limpa()
	M_Title("ESCOLHA A ORDEM")
	nChoice := FazMenu( 05, 10, aMenu, Cor())
	if nChoice = 0
		xNewDbf->(DbCloseArea())
		Ferase( xArquivo )
		Ferase( xNtx )
		ResTela( cScreen )
		Loop
	elseif nChoice = 1 // Emissao
		Inde On xNewDbf->Emis To (xNtx )
	elseif nChoice = 2 // Codigo
		Inde On xNewDbf->Codigo To (xNtx )
	elseif nChoice = 3 // Fatura
		Inde On xNewDbf->Fatura To (xNtx )
	elseif nChoice = 4 // Tipo
		Inde On xNewDbf->Tipo To (xNtx )
	elseif nChoice = 5 // Fatura+Tipo
		Inde On xNewDbf->Fatura + xNewDbf->Codigo To (xNtx )
	elseif nChoice = 6 // Fatura+Emissao
		Inde On Dtos( xNewDbf->Emis ) + xNewDbf->Fatura To (xNtx )
	endif
   Lista->(Order(LISTA_CODIGO))
   Receber->( Order(RECEBER_CODI))
	Set Rela To xNewDbf->Codigo Into Lista, xNewDbf->Codi Into Receber
	xNewDbf->(DbGoTop())
	nChoice := Alerta(" Imprimir relatorio de produtos,  ", {"Vendidos", " A receber"})
	if !InsTru80() .OR. !LptOk()
		xNewDbf->(DbCloseArea())
		Ferase( xArquivo )
		Ferase( xNtx )
		ResTela( cScreen )
		Loop
	endif
	Mensagem(" Please, aguarde. Imprimindo.", Cor())
	PrintOn()
	FPrint( _CPI12 )
	FPrint( PQ )
	CabecTipo( cCodi, cTipo, cCodigo, dIni, dFim, nChoice )
	WHILE xNewDbf->(!Eof()) .AND. Rep_Ok()
		if lCodi
			if xNewDbf->Codi != cCodi
				xNewDbf->(DbSkip(1))
				Loop
			endif
		endif
		if lCodigo
			if xNewDbf->Codigo != cCodigo
				xNewDbf->(DbSkip(1))
				Loop
			endif
		endif
		if lTipo
			if xNewDbf->Tipo != cTipo
				xNewDbf->(DbSkip(1))
				Loop
			endif
		endif
		if lForma
			if xNewDbf->Forma != cForma
				xNewDbf->(DbSkip(1))
				Loop
			endif
		endif
		if nChoice = 1
			Qout( Emis, Fatura, Tipo, Receber->(Left( Nome,20)), Codigo,;
					Lista->(Ponto( Left( Descricao,37),37)), Saida,;
					Tran( Varejo, "@E 999,999,999.99"), Tran( Pvendido,"@E 999,999,999.99"), Tran( Pvendido*Saida,"@E 999,999,999.99"), Forma)
			nTotal		 += ( Pvendido * Saida )
			nTotalGeral  += ( Pvendido * Saida )
			nVarejo		 += ( Varejo	* Saida )
			nTotalVarejo += ( Varejo	* Saida )
			nQuant		 += Saida
			nQuantGeral  += Saida
			Col++
		else
			if ( nSobra := ( xNewDbf->Saida - xNewDbf->SaidaPaga )) != 0
				Qout( Emis, Fatura, Tipo, Receber->(Left( Nome,20 )), Codigo,;
						Lista->(Ponto( Left( Descricao,37),37)), Str( nSobra,9,2),;
						Tran( Varejo, "@E 999,999,999.99"), Tran( Pvendido,"@E 999,999,999.99"), Tran( Pvendido*nSobra,"@E 999,999,999.99"), Forma)
				nTotal		 += ( Pvendido * nSobra )
				nTotalGeral  += ( Pvendido * nSobra )
				nTotalGeral  += ( Pvendido * Saida )
				nVarejo		 += ( Varejo	* Saida )
				nQuant		 += nSobra
				nQuantGeral  += nSobra
				Col++
			endif
		endif
		nSobra := 0
		DbSkip(1)
		if Col >= 55
			Write( ++Col, 092, Tran( nQuant,  "@E 999999.99"))
			Write(	Col, 102, Tran( nVarejo, "@E 999,999,999.99"))
			Write(	Col, 132, Tran( nTotal,  "@E 999,999,999.99"))
			CabecTipo( cCodi, cTipo, cCodigo, dIni, dFim, nChoice )
			Col	  := 8
			nTotal  := 0
			nVarejo := 0
			nQuant  := 0
		endif
	EndDo
	xNewDbf->(DbClearFilter())
	xNewDbf->(DbClearRel())
	xNewDbf->(DbCloseArea())
	Ferase( xArquivo )
	Ferase( xNtx )
	Write( ++Col, 092, Tran( nQuant, 		"@E 999999.99"))
	Write(	Col, 102, Tran( nVarejo,		"@E 999,999,999.99"))
	Write(	Col, 132, Tran( nTotal, 		"@E 999,999,999.99"))
	Write( ++Col, 092, Tran( nQuantGeral,	"@E 999999.99"))
	Write(	Col, 102, Tran( nTotalVarejo, "@E 999,999,999.99"))
	Write(	Col, 132, Tran( nTotalGeral,	"@E 999,999,999.99"))
	__Eject()
	PrintOff()
	ResTela( cScreen )
EndDo

Function ComSemProd( cCodigo, lCodigo )
***************************************
if cCodigo != 999999
	lCodigo := OK
	CodiErrado( @cCodigo )
endif
return( OK )

Function ComSemCli( cCodi, lCodi )
**********************************
if cCodi != "99999"
	lCodi := OK
	RecErrado( @cCodi )
endif
return( OK )

Function ComSemTipo( cTipo, lTipo )
***********************************
if cTipo != PIC_LISTA_CODIGO
	lTipo := OK
endif
return( OK )

Function ComSemForma( cForma, lForma )
**************************************
if cForma != "99"
	lForma := OK
	FormaErrada( @cForma )
endif
return( OK )

Proc CabecTipo( cCodi, cTipo, cCodigo, dIni, dFim, nChoice )
************************************************************
LOCAL  Tam	  := CPI12132	//151
STATIC Pagina := 0
		 cIni   := Dtoc( dIni )
		 cFim   := Dtoc( dFim )
Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina, 4 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
Write( 01, 00, Date() )
Write( 02, 00, Padc( XNOMEFIR, Tam ) )
Write( 03, 00, Padc( SISTEM_NA2, Tam ) )
if nChoice = 1
	Write( 04, 00, Padc( "RELATORIO DE VENDAS NO PERIODO DE &cIni. A &cFim" ,Tam ) )
else
	Write( 04, 00, Padc( "RELATORIO DE PRODUTOS A RECEBER NO PERIODO DE &cIni. A &cFim" ,Tam ) )
endif
Write( 05, 00, Repl( SEP, Tam ))
Write( 06, 00, "DATA     DOCTO N§  TIPO   NOME DO CLIENTE      CODIGO DESCRICAO DO PRODUTO                      QUANT      P. VAREJO  PRECO VENDIDO     T. VENDIDO FP")
Write( 07, 00, Repl( SEP, Tam ))
return

Proc BuscaFatura( aFatuTemp, aFatura, aRegis, aRegiTemp, cTitulo )
******************************************************************
LOCAL GetList		 := {}
LOCAL cScreen		 := SaveScreen()
LOCAL aMenuArray	 := { " Por Periodo ", " Por Regiao ", " Selecionar "}
LOCAL dIni			 := Date()-30
LOCAL dFim			 := Date()
LOCAL nRecno		 := 0
LOCAL nItens		 := 0
LOCAL nConta		 := 0
LOCAL nContaFatura := 0
LOCAL nTamanho 	 := 0
LOCAL cRegiao		 := Space(02)
LOCAL cFatura		 := Space(07)
LOCAL nChoice		 := 1
LOCAL Col			 := 0
LOCAL nQuant
LOCAL cSigla
LOCAL cDescricao
LOCAL cCodi
LOCAL cNome
LOCAL bBloco
LOCAL cTela
LOCAL cRelato
LOCAL nTam
LOCAL Pos1
LOCAL Line
LOCAL nPagina
LOCAL Ok
LOCAL Tot_Reg
LOCAL nReg
LOCAL nSobra
LOCAL Escolha
LOCAL aCodigo
LOCAL cCodigo
LOCAL cDesc
LOCAL nSaida
LOCAL cCabecalho
LOCAL PosCur
LOCAL nX
LOCAL nPos
FIELD Codigo
Field Saida

M_Title( cTitulo )
nChoice := FazMenu( 11, 44, aMenuArray, Cor())
Do Case
Case nChoice = 0
	ResTela( cScreen )
	return

Case nChoice = 1
	dIni	 := Date() - 30
	dFim	 := Date()
	nRecno := 0
	MaBox( 18, 20, 21, 56 )
	@ 19, 21 Say "Digite Emissao Inicial.:" Get dIni Pict "@K##/##/##" Valid AchaDataIni( dIni, @nRecno )
	@ 20, 21 Say "Digite Emissao Final...:" Get dFim Pict "@K##/##/##"
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		return
	endif
	Saidas->(Order( SAIDAS_EMIS ))
	oMenu:Limpa()
	Mensagem("Aguarde, Incluindo.", WARNING )
	aFatuTemp	 := {}
	aRegiTemp	 := {}
	bBloco		 := {|| Saidas->Emis >= dIni .AND. Saidas->Emis <= dFim }
	cFatura		 := Space(07)
	nContaFatura := 0
	Saidas->(DbGoTo( nRecno ))
	While Saidas->(Eval( bBloco ))
		cFatura := Saidas->Fatura
		nRecno  := Saidas->(Recno())
		if nContaFatura >= 4096 // Maximo
			ErrorBeep()
			Alerta("Erro: Maximo de 4096 Faturas.")
			Exit
		endif
		if Ascan( aFatuTemp, cFatura ) = 0
			nContaFatura++
			Aadd( aFatuTemp, cFatura  )
			Aadd( aRegiTemp, nRecno )
		endif
		Saidas->(DbSkip(1))
	EndDo

Case nChoice = 2
	nRecno	:= 0
	cRegiao	:= Space(2)
	dIni		:= Date()-30
	dFim		:= Date()
	MaBox( 18, 20, 22, 56 )
	@ 19, 21 Say "Digite a Regiao........:" Get cRegiao Pict "99"       Valid RegiaoErrada( @cRegiao )
	@ 20, 21 Say "Digite Emissao Inicial.:" Get dIni    Pict PIC_DATA Valid AchaDataIni( dIni, @nRecno )
	@ 21, 21 Say "Digite Emissao Final...:" Get dFim    Pict PIC_DATA
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		return
	endif
	oMenu:Limpa()
	Saidas->( Order( SAIDAS_EMIS ))
	Mensagem("Aguarde, Incluindo.", WARNING )
	aFatuTemp	 := {}
	aRegiTemp	 := {}
	bBloco		 := {|| Saidas->Emis >= dIni .AND. Saidas->Emis <= dFim }
	cFatura		 := Space(07)
	nContaFatura := 0
	Saidas->(DbGoto( nRecno ))
	While Saidas->(Eval( bBloco ))
		if Saidas->Regiao = cRegiao
			cFatura := Saidas->Fatura
			nRecno  := Saidas->(Recno())
			if nContaFatura >= 4096 // Maximo
				ErrorBeep()
				Alerta("Erro: Maximo de 4096 Faturas.")
				Exit
			endif
			if Ascan( aFatuTemp, cFatura ) = 0
				nContaFatura++
				Aadd( aFatuTemp, cFatura  )
				Aadd( aRegiTemp, nRecno )
			endif
		endif
		Saidas->(DbSkip(1))
	EndDo

Case nChoice = 3
	oMenu:Limpa()
	nConta := 0
	nItens := Nota->(Lastrec())
	MaBox( 00, 00, 02, 79 )
	Write( 01, 01, "Total de Faturas.: " + StrZero( nItens, 4 ))
	Write( 01, 26, "Selecionadas.....: " + StrZero( nConta, 4 ))
	Write( 01, 51, "Disponiveis......: " + StrZero( nItens - nConta, 4 ))
	aRegis		 := {}
	aFatura		 := {}
	Col			 := 4
	nContaFatura := 0
	MaBox( 03, 26, 22, 79 , "FATURA   CODI NOME CLIENTE                      " )
	WHILE OK
		cFatura := Space( 07 )
		MaBox( 20, 01, 22, 25 )
		@ 21, 02 Say "Fatura N§...:" Get cFatura Pict "@!" Valid VisualAchaFatura( @cFatura )
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Exit
		endif
		Receber->(Order( RECEBER_CODI ))
		Lista->(Order( LISTA_CODIGO ))
		Saidas->(Order( SAIDAS_FATURA ))
		if Saidas->( DbSeek( cFatura ))
			cCodi   := Saidas->Codi
			cFatura := Saidas->Fatura
			nRecno  := Saidas->(Recno())
			if Receber->(!DbSeek( cCodi ))
				cNome := "CLIENTE NAO LOCALIZADO"
			else
				cNome := Receber->Nome
			endif
			if nContaFatura >= 4096 // Maximo
				ErrorBeep()
				Alerta("Erro: Maximo de 4096 Faturas.")
				Exit
			endif
			nContaFatura++
			Aadd( aFatura,   cFatura )
			Aadd( aRegis,	  nRecno )
			Write( 01,	45, StrZero( ++nConta,	4 ) ,"R/W")
			Write( 01,	70, StrZero( --nItens, 4 ) ,"R/W")
			Write( Col, 27, cFatura + "  " + cCodi + " " + Left( cNome, 36 ) , "R/W")
			if Col = 21
				Scroll( 04, 27, 21, 78, 1 )
				Col := 21
			else
				Col++
			endif
		else
			ErrorBeep()
			Alerta("Erro: Favor reindexar.")
		endif
	Enddo
EndCase
if nContaFatura = 0
	oMenu:Limpa()
	ErrorBeep()
	Alerta( "Erro: Nenhuma Fatura Disponivel.")
	ResTela( cScreen )
	return
endif
if nChoice != 3
	oMenu:Limpa()
	nConta := 0
	nSobra := nContaFatura
	MaBox( 00, 00, 02, 79 )
	Write( 01, 01, "Total de Faturas.¯ " + StrZero( nContaFatura, 4 ))
	Write( 01, 26, "Selecionadas.....¯ " + StrZero( nConta,       4 ))
	Write( 01, 51, "Disponiveis......¯ " + StrZero( nSobra,       4 ))
	aRegis	:= {}
	aFatura	:= {}
	Col		:= 4
	Receber->(Order( RECEBER_CODI ))
	Lista->(Order( LISTA_CODIGO ))
	Saidas->(Order( SAIDAS_FATURA ))
	MaBox( 03, 26, 22, 79 , "FATURA   CODI NOME CLIENTE                      " )
	WHILE OK
		MaBox( 03, 00, 22, 20 , "FATURAS")
		Escolha := Achoice( 04, 03, 21, 19, aFatuTemp )
		if Escolha = 0 			  // Esc ?
			Exit						  // ... Entao Vaza.
		endif
		Saidas->(DbGoTo( aRegiTemp[ Escolha ] ))
		Aadd( aFatura,   aFatuTemp[ Escolha ] )
		Aadd( aRegis,	  aRegiTemp[ Escolha ] )
		Write( 01, 45, StrZero( ++nConta,  4 ) ,"R/W")
		Write( 01, 70, StrZero( --nSobra,  4 ) ,"R/W")
		cFatura := aFatuTemp[ Escolha ]
		nRecno  := aRegiTemp[ Escolha ]
		cNome   := "CLIENTE NAO LOCALIZADO"
		if Saidas->( DbSeek( cFatura ))
			cCodi   := Saidas->Codi
			cFatura := Saidas->Fatura
			nRecno  := Saidas->(Recno())
			if Receber->(DbSeek( cCodi ))
				cNome := Receber->Nome
			endif
		endif
		Write( Col, 27, cFatura + "  " + cCodi + ' ' + Left( cNome, 36 ) , "R/W")
		Adel( aFatuTemp, Escolha )
		Adel( aRegiTemp, Escolha )
		if Col = 21
			Scroll( 04, 27, 21, 78, 1 )
			Col := 21
		else
			Col++
		endif
	Enddo
endif

Proc Separacao()
****************
LOCAL GetList		 := {}
LOCAL cScreen		 := SaveScreen()
LOCAL aFatuTemp	 := {}
LOCAL aFatura		 := {}
LOCAL aRegis		 := {}
LOCAL aRegiTemp	 := {}
LOCAL dIni			 := Date()-30
LOCAL dFim			 := Date()
LOCAL nRecno		 := 0
LOCAL nItens		 := 0
LOCAL nConta		 := 0
LOCAL nContaFatura := 0
LOCAL nTamanho 	 := 0
LOCAL cRegiao		 := Space(02)
LOCAL cFatura		 := Space(07)
LOCAL nChoice		 := 1
LOCAL Col			 := 0
LOCAL nQuant
LOCAL cSigla
LOCAL cDescricao
LOCAL cCodi
LOCAL cNome
LOCAL bBloco
LOCAL cTela
LOCAL cRelato
LOCAL nTam
LOCAL Pos1
LOCAL Line
LOCAL nPagina
LOCAL Ok
LOCAL Tot_Reg
LOCAL nReg
LOCAL nSobra
LOCAL Escolha
LOCAL aCodigo
LOCAL cCodigo
LOCAL cDesc
LOCAL nSaida
LOCAL cCabecalho
LOCAL PosCur
LOCAL nX
LOCAL nPos
FIELD Codigo
Field Saida

BuscaFatura( @aFatuTemp, @aFatura, @aRegis, @aRegiTemp, "RELACAO DE SEPARACAO" )
if ( nTamanho := Len( aFatura )) > 0
	oMenu:Limpa()
	ErrorBeep()
	if Conf("Pergunta: Imprimir Relacao de Separacao ?" )
		if !InsTru80() .OR. !LptOk()
			ResTela( cScreen )
			return
		endif
		Lista->(Order( LISTA_CODIGO ))
		Saidas->(Order( SAIDAS_FATURA ))
		Saidas->(DbGoTop())
		aCodigo	 := {}
		cDesc 	 := {}
		cTela 	 := SaveScreen()
		Mensagem("Aguarde, Somando.", Cor())
		cRelato	  := "RELACAO DE PRODUTOS PARA SEPARACAO"
		cCabecalho := "CODIGO DESCRICAO DO PRODUTO                     FORNECEDOR     QUANT   ESTOQUE"
		nTam		  := 80
		Line		  := 08
		nPagina	  := 00
		PosCur	  := 00
		nTamanho   := Len( aFatura )
		For nX := 1 To nTamanho
			nRecno := aRegis[ nX ]
			Saidas->(DbGoTo( nRecno ))
			bBloco := {|| Saidas->Fatura = aFatura[ nX ] }
			While Saidas->(Eval( bBloco ))
				cCodigo	  := Saidas->Codigo
				nSaida	  := Saidas->Saida
				nQuant	  := 0
				cDescricao := Lista->(Space(Len( Descricao )))
				cSigla	  := Lista->(Space(Len( Sigla 	 )))
				if ( nPos := Ascan2( aCodigo, cCodigo, 1 )) = 0 // Nao Encontrado ? Inclui.
					if Lista->(DbSeek( cCodigo ))
						nQuant	  := Lista->Quant
						cDescricao := Lista->Descricao
						cSigla	  := Lista->Sigla
					endif
					Aadd( aCodigo, { cCodigo, cDescricao, nSaida, nQuant, cSigla } )
				else
				  aCodigo[ nPos, 3 ] += nSaida
				endif
				Saidas->(DbSkip(1))
			EndDo
		Next
		nTamanho := Len( aCodigo )
		For nX := 1 To nTamanho
			aCodigo[ nX, 3 ] := StrZero( aCodigo[ nX, 3 ], 9, 2 )
			aCodigo[ nX, 4 ] := StrZero( aCodigo[ nX, 4 ], 9, 2 )
		Next
		Asort( aCodigo,,, {| x, y | y[2] > x[2] } )
		Mensagem("Aguarde, Somando e Imprimindo.", Cor())
		PrintOn()
		SetPrc( 0, 0 )
		Cabec002( ++nPagina, cRelato, nTam, cCabecalho)
		For nX := 1 To Len( aFatura )
			if Poscur >= 79
				Poscur := 0
				Line++
			 endif
			 Write( Line, PosCur, NG + aFatura[ nX ] + Chr( 27) + NR )
			 PosCur += 8
		Next
		Line += 2
		For nX := 1 To Len( aCodigo )
			if Line >=	58
				__Eject()
				Cabec002( ++nPagina, cRelato, nTam, cCabecalho)
				Line := 8
			endif
			Qout( aCodigo[ nX,1 ], Ponto( aCodigo[ nX,2 ],40), Left( aCodigo[ nX,5 ], 14 ) , aCodigo[ nX,3 ], aCodigo[ nX, 4 ] )
			Line ++
		Next
		__Eject()
		PrintOff()
		ResTela( cTela )
	endif
endif
ResTela( cScreen )
return

Proc Espelho( cNoFatura )
*************************
LOCAL cScreen		 := SaveScreen()
LOCAL aFatuTemp	 := {}
LOCAL aFatura		 := {}
LOCAL aRegis		 := {}
LOCAL aRegiTemp	 := {}
LOCAL nTamanho 	 := 0
LOCAL nDesconto	 := 0
LOCAL nRow			 := 0
LOCAL nTotal		 := 0
LOCAL nTotalNota	 := 0
LOCAL nItens		 := 0
LOCAL Pagina		 := 0
LOCAL nBaseIcms	 := 0
LOCAL nBaseSubs	 := 0
LOCAL nVlrIcms 	 := 0
LOCAL nVlrSubs 	 := 0
LOCAL nAliquota	 := 0
LOCAL nTaxa 		 := 0
LOCAL cForma		 := ""
LOCAL cCodiVen 	 := ""
LOCAL nReducao 	 := 0
LOCAL cTela

if cNoFatura = NIL
	BuscaFatura( @aFatuTemp, @aFatura, @aRegis, @aRegiTemp, "ESPELHO DE NOTA" )
else
	Aadd( aFatura, cNofatura )
endif
if ( nTamanho := Len( aFatura )) > 0
	oMenu:Limpa()
	ErrorBeep()
	if Conf("Pergunta: Imprimir Espelho de Nota ?" )
		nDesconto := 0
		MaBox( 10, 10, 12, 70, "INFORMACOES COMPLEMENTARES")
		@ 11, 11 Say "Desconto.........:" Get nDesconto Pict "99.99"
		Read
		if LastKey() = ESC .OR. !InsTru80() .OR. !LptOk()
			ResTela( cScreen )
			return
		endif
		Cep->(Order( CEP_CEP ))
		Receber->(Order( RECEBER_CODI ))
		Lista->(Order( LISTA_CODIGO ))
		Saidas->(Order( SAIDAS_FATURA ))
		cTela 	 := SaveScreen()
		nTamanho  := Len( aFatura )
		Mensagem("Aguarde, Imprimindo.", Cor())
		PrintOn()
		FPrint( _CPI12 )
		For nX := 1 To nTamanho
			cFatura	  := aFatura[ nX ]
			nRow		  := 11
			nTotal	  := 0
			nTotalNota := 0
			nBaseIcms  := 0
			nBaseSubs  := 0
			nVlrIcms   := 0
			nVlrSubs   := 0
			nBaseRed   := 0

			bBloco  := {|| Saidas->Fatura = cFatura }
			if Saidas->(DbSeek( cFatura ))
				dEmis 	:= Saidas->Emis
				cForma	:= Saidas->Forma
				cCodiVen := Saidas->CodiVen
				nItens	:= 0
				Receber->(DbSeek( Saidas->Codi ))
				Cep->(DbSeek( Receber->Cep ))
				nAliquota := Cep->Tx_Icms
				cEsta 	 := Cep->Esta
				WHILE Saidas->(EVal( bBloco )) .AND. Rel_Ok()
					if nItens = 0
						Front( Pagina, cFatura, dEmis, cForma, cCodiVen )
					endif
					nPvendido := Saidas->Pvendido
					nPvendido -= ( nPvendido * nDesconto ) / 100
					nSoma 	 := ( Saidas->Saida * nPvendido )
					Lista->(DbSeek( Saidas->Codigo ))
					Qout( Saidas->Saida,;
							Lista->Un,;
							Lista->Codigo,;
							Lista->Descricao,;
							Lista->Sigla,;
							Tran( nPvendido,"@E 999,999.99" ),;
							Tran( nSoma,	 "@E 999,999.99" ))
					nItens++
					nRow++
					nTotal	  += nSoma
					nTotalNota += nSoma
					*:----------------------------------------------------------------------------
					cClasse	:= Lista->Classe
					cCodigo	:= Lista->Codigo
					nReducao := ReducaoBase( cEsta )
					nTaxa 	:= Lista->Tx_Icms
					nSomaRed := nSoma - (( nSoma * nReducao ) / 100 )
					if nSomaRed = 0
						nSomaRed = nSoma
					endif
					nSomaSub := ( nSoma + (( nSoma * nTaxa ) / 100 ))
					nIcmsRed := ( nSomaRed * nAliquota ) / 100
					nIcms 	:= ( nSoma * nAliquota ) / 100
					nSub		:= (( nSomaSub * nAliquota ) / 100 ) - nIcms
					Do Case
					Case cClasse = "0" // Tributado Integralmente
						nBaseIcms += nSoma
						nBaseSubs += 0
						nVlrIcms  += nIcms
						nVlrSubs  += 0
					Case cClasse = "1" // Tributado e Icms por Substituicao
						nBaseIcms += nSoma
						nBaseSubs += nSomaSub
						nVlrIcms  += nIcms
						nVlrSubs  += nSub
					Case cClasse = "2" // Com Reducao da Base de Calculo
						nBaseIcms += nSomaRed
						nBaseSubs += 0
						nVlrIcms  += nIcmsRed
						nVlrSubs  += 0
					Case cClasse = "3" // Isenta e Icms por Substituicao Tributaria
						nBaseIcms += 0
						nBaseSubs += nSomaSub
						nVlrIcms  += 0
						nVlrSubs  += nSub
					Case cClasse = "4" // Isenta ou nao tributada
						nBaseIcms += 0
						nBaseSubs += 0
						nVlrIcms  += 0
						nVlrSubs  += 0
					Case cClasse = "5"
					Case cClasse = "6"
					Case cClasse = "7"
					EndCase
					*:----------------------------------------------------------------------------
					if nItens = 23
						nItens := 0
						FechaEspelho( nTotal, nRow, nDesconto, nBaseIcms, nBaseSubs, nVlrIcms, nVlrSubs, nTotalNota )
						__Eject()
						nRow		  := 11
						nTotal	  := 0
						nTotalNota := 0
						nBaseIcms  := 0
						nBaseSubs  := 0
						nVlrIcms   := 0
						nVlrSubs   := 0
					endif
					Saidas->(DbSkip(1))
				EndDo
				if nItens != 0
					FechaEspelho( nTotal, nRow, nDesconto, nBaseIcms, nBaseSubs, nVlrIcms, nVlrSubs, nTotalNota )
					__Eject()
				endif
			endif
		Next
		PrintOff()
		ResTela( cTela )
	endif
endif
ResTela( cScreen )
return

Proc FrontParcial( Pagina, cFatura, dEmis, cForma, cCodiVen )
*************************************************************
LOCAL Tam := CPI1280

Forma->(Order( FORMA_FORMA))
Forma->(DbSeek( cForma ))
SetPrc( 0, 0)
Write( 00, 00 , "Emissao....: " + Dtoc( dEmis ))
Write( 00, 52 , "Fatura N§..: " + cFatura )
Write( 01, 00 , "Transporte.: " + "RODOVIARIO" )
Write( 01, 52 , "Nat. Oper..: " + Cep->Nat_Oper )
Write( 02, 00 , "F. Pagto...: " + Forma->Forma + "  " + Forma->Condicoes )
Write( 03, 00 , "Cliente....: " + NG + Receber->Codi  + " " + Receber->Nome + NR )
Write( 04, 00 , "Fantasia...: " + NG + Left(Receber->Fanta,30) + NR )
Write( 04, 52 , "Vendedor...: " + cCodiVen )
Write( 05, 00 , "Endereco...: " + Receber->Ende )
Write( 05, 52 , "Telefone...: ")
Write( 06, 00 , "Cidade.....: " + Receber->Cep + "/" + Receber->Cida )
Write( 06, 52 , "Estado.....: " + Receber->Esta )
Write( 07, 00 , "CGC/CPF....: " + if( Empty( Receber->Cgc ), Receber->Cpf, Receber->Cgc ))
Write( 07, 52 , "Insc/Rg....: " + if( Empty( Receber->Rg  ), Receber->Rg, Receber->Insc ))
Write( 08, 00 , Repl( SEP, Tam ) )
#ifDEF GARRA
   Write( 09, 00 , "    QUANT UN COD_FABRICANTE  DESCRICAO DO PRODUTO            MARCA      P.UNITARIO      TOTAL")
#else
   Write( 09, 00 , "    QUANT UN CODIGO       DESCRICAO DO PRODUTO               MARCA      P.UNITARIO      TOTAL")
#endif
Write( 10, 00 , Repl( SEP, Tam ))
return

Proc Front( Pagina, cFatura, dEmis, cForma, cCodiVen )
******************************************************
LOCAL Tam := CPI1280

Forma->(Order( FORMA_FORMA))
Forma->(DbSeek( cForma ))
SetPrc( 0, 0)
Write( 00, 00 , "Emissao....: " + Dtoc( dEmis ))
Write( 00, 52 , "Fatura N§..: " + cFatura )
Write( 01, 00 , "Transporte.: " + "RODOVIARIO" )
Write( 01, 52 , "Nat. Oper..: " + Cep->Nat_Oper )
Write( 02, 00 , "F. Pagto...: " + Forma->Forma + "  " + Forma->Condicoes )
Write( 03, 00 , "Cliente....: " + NG + Receber->Codi  + " " + Receber->Nome + NR )
Write( 04, 00 , "Fantasia...: " + NG + Left( Receber->Fanta, 30) + NR )
Write( 04, 52 , "Vendedor...: " + cCodiven )
Write( 05, 00 , "Endereco...: " + Receber->Ende )
Write( 05, 52 , "Telefone...: " + Receber->Fone )
Write( 06, 00 , "Cidade.....: " + Receber->Cep + "/" + Receber->Cida )
Write( 06, 52 , "Estado.....: " + Receber->Esta )
Write( 07, 00 , "CGC/CPF....: " + if( Empty( Receber->Cgc ), Receber->Cpf, Receber->Cgc ))
Write( 07, 52 , "Insc/Rg....: " + if( Empty( Receber->Rg  ), Receber->Rg, Receber->Insc ))
Write( 08, 00 , Repl( SEP, Tam ) )
Write( 09, 00 , "    QUANT UN CODIGO DESCRICAO DO PRODUTO                     MARCA      P.UNITARIO      TOTAL")
Write( 10, 00 , Repl( SEP, Tam ))
return

Proc FechaEspelho( nTotal, nRow, nDesconto, nBaseIcms, nBaseSubs, nVlrIcms, nVlrSubs, nTotalNota )
**************************************************************************************************
LOCAL Tam		:= CPI1280
LOCAL nSoma 	:= 0
LOCAL nCol1 	:= 00
LOCAL nCol2 	:= 20
LOCAL nCol3 	:= 39
LOCAL nCol4 	:= 58
LOCAL nCol5 	:= 77
LOCAL oBloco

nRow := 37
Write( ++nRow, 00, Repl( "=", Tam ))
Write( ++nRow, 00,	 "|BASE DO ICMS       |VALOR DO ICMS     |CALCULO ICMS SUBS |VALOR ICMS SUBS   |VALOR PRODUTOS|")
Write( ++nRow, nCol1, "|" + Tran( nBaseIcms, "@E 99,999,999.99" ))
Write(	nRow, nCol2, "|" + Tran( nVlrIcms,  "@E 99,999,999.99" ))
Write(	nRow, nCol3, "|" + Tran( nBaseSubs, "@E 99,999,999.99" ))
Write(	nRow, nCol4, "|" + Tran( nVlrSubs,  "@E 99,999,999.99" ))
Write(	nRow, nCol5, "|" + Tran( nTotal,    "@E 99,999,999.99" ))
Write( ++nRow, 00, Repl( SEP, Tam ))
Write( ++nRow, 00,	 "|VALOR DO FRETE     |VALOR DO SEGURO   |OUTRAS DESPESAS   |VALOR TOTAL IPI   |VLR TOTAL NOTA|")
Write( ++nRow, nCol1, "|" + Tran( 0,          "@E 99,999,999.99" ))
Write(	nRow, nCol2, "|" + Tran( 0,          "@E 99,999,999.99" ))
Write(	nRow, nCol3, "|" + Tran( 0,          "@E 99,999,999.99" ))
Write(	nRow, nCol4, "|" + Tran( 0,          "@E 99,999,999.99" ))
Write(	nRow, nCol5, "|" + Tran( nTotalNota, "@E 99,999,999.99" ))
Write( ++nRow, 00, Repl( "=", Tam ))
FechaTit( nRow, nDesconto )
return

Proc FechaTit( nRow, nDesconto )
********************************
LOCAL Tam	  := CPI1280
LOCAL nAberto := 0
LOCAL nRecebi := 0
LOCAL oBloco
LOCAL cDocnr

nRow := 45
Write( nRow++, 00, "DCTO N§   TP     EMISSAO  VENCTO   PORTADOR    VLR NOMINAL DT PAGTO     VLR PAGO STATUS")
Write( nRow++, 00, Repl( SEP, Tam ) )
Recemov->(Order( RECEMOV_DOCNR ))
Recebido->(Order( RECEBIDO_FATURA ))
if Recebido->( DbSeek( cFatura ))
	oBloco := {|| Recebido->Fatura = cFatura .AND. Recebido->Emis = dEmis }
	WHILE EVal( oBloco ) .AND. Rel_Ok()
		nVlr	  := Recebido->Vlr
		nVlr	  -= ( nVlr * nDesconto ) / 100
		cDocnr  := Recebido->Docnr
		cStatus := "QUITADO"
		if Recemov->(DbSeek( cDocnr ))
			cStatus := "PARCIAL"
		endif
		Recebido->(Qout( Docnr, Tipo, Emis, Vcto, Port, Tran( nVlr, "@E 9,999,999.99"), DataPag, Tran( VlrPag, "@E 9,999,999.99"), cStatus ))
		nRow	++
		nRecebi += Recebido->VlrPag
		Recebido->(DbSkip(1))
	EndDo
endif
oBloco := {|| Recemov->Fatura = cFatura }
Recemov->(Order( RECEMOV_FATURA ))
cStatus := "ABERTO"
if Recemov->(DbSeek( cFatura ))
	WHILE EVal( oBloco ) .AND. Rel_Ok()
		nVlr	:= Recemov->Vlr
		nVlr	-= ( nVlr * nDesconto ) / 100
		Recemov->(Qout( Docnr, Tipo, Emis, Vcto, Port, Tran( nVlr, "@E 9,999,999.99"), Ctod("//"), Tran( 0, "@E 9,999,999.99"), cStatus ))
		nRow	  ++
		nAberto += nVlr
		Recemov->(DbSkip(1))
	EndDo
endif
Qout()
Qout("*** Totais ***", Space(30), Tran( nAberto, "@E 9,999,999.99"), Space(08), Tran( nRecebi, "@E 9,999,999.99"))
return

Proc EspelhoParcial( cNoFatura )
********************************
LOCAL Tam			 := CPI1280
LOCAL cScreen		 := SaveScreen()
LOCAL aFatuTemp	 := {}
LOCAL aFatura		 := {}
LOCAL aRegis		 := {}
LOCAL aRegiTemp	 := {}
LOCAL aAp			 := {}
LOCAL nTamanho 	 := 0
LOCAL nDesconto	 := 0
LOCAL nRow			 := 0
LOCAL nTotal		 := 0
LOCAL nItens		 := 0
LOCAL nLen			 := 0
LOCAL cForma		 := ""
LOCAL cCodiVen 	 := ""
LOCAL cTela

if cNoFatura = NIL
	BuscaFatura( @aFatuTemp, @aFatura, @aRegis, @aRegiTemp, "ESPELHO NOTA PARCIAL" )
else
	Aadd( aFatura, cNofatura )
endif
if ( nTamanho := Len( aFatura )) > 0
	oMenu:Limpa()
	ErrorBeep()
	if Conf("Pergunta: Imprimir Espelho de Nota Parcial ?" )
		nDesconto := 0
		MaBox( 10, 10, 12, 70, "INFORMACOES COMPLEMENTARES")
		@ 11, 11 Say "Desconto.........:" Get nDesconto Pict "99.99"
		Read
		if LastKey() = ESC .OR. !InsTru80() .OR. !LptOk()
			ResTela( cScreen )
			return
		endif
		Cep->(Order( CEP_CEP ))
		Receber->(Order( RECEBER_CODI ))
		Lista->(Order( LISTA_CODIGO ))
		Saidas->(Order( SAIDAS_FATURA ))
		cTela 	 := SaveScreen()
		nTamanho  := Len( aFatura )
		Mensagem("Aguarde, Imprimindo.", Cor())
		PrintOn()
		FPrint( _CPI12 )
		For nX := 1 To nTamanho
			cFatura := aFatura[ nX ]
			nRow	  := 11
			nTotal  := 0
			bBloco  := {|| Saidas->Fatura = cFatura }
			if Saidas->(DbSeek( cFatura ))
				cForma	:= Saidas->Forma
				cCodiVen := Saidas->CodiVen
				dEmis 	:= Saidas->Emis
				nItens	:= 0
				aP 		:= {}
				Receber->(DbSeek( Saidas->Codi ))
				Cep->(DbSeek( Receber->Cep ))
				WHILE Saidas->(EVal( bBloco )) .AND. Rel_Ok()
					nVlr		 := Saidas->Pvendido
					nVlr		 -= ( nVlr * nDesconto ) / 100
					Lista->(DbSeek( Saidas->Codigo ))
               Aadd( aP, { Saidas->Saida, Lista->Un, Lista->Codigo, Lista->(Left( Descricao, 34 )), Lista->Sigla, nVlr, ( Saidas->Saida * nVlr ), Lista->N_Original })
					Saidas->(DbSkip(1))
				EndDo
				Asort( aP,,, {|x, y| y[4] > x[4]} ) // Ordenar Por Descricao
				nItens := 0
				Pagina := 1
				nLen	 := Len( aP )
				For nT := 1 To nLen
					if nItens = 0
						FrontParcial( Pagina, cFatura, dEmis, cForma, cCodiven )
					endif
					FPrint( _CPI12 )
               #ifDEF GARRA
                 Qout( Tran( Ap[nT,1], "999999.99"),;
                       Ap[nT, 2 ],;
                       Ap[nT, 8 ],;
                       Ap[nT, 4 ],;
                       Ap[nT, 5 ],;
                       Tran( Ap[nT,6],"@E 999,999.99"),;
                       Tran( Ap[nT,7],"@E 999,999.99"))
               #else
                 Qout( Tran( Ap[nT,1], "999999.99"),;
                       Ap[nT, 2 ],;
                       Ap[nT, 3 ],;
                       Space(05),;
                       Ap[nT, 4 ],;
                       Ap[nT, 5 ],;
                       Tran( Ap[nT,6],"@E 999,999.99"),;
                       Tran( Ap[nT,7],"@E 999,999.99"))
               #endif
					nItens++
					nRow++
					nTotal += Ap[nT, 7]
					if nItens = 49
						Pagina++
						nRow	 := 11
						nItens := 0
					  __Eject()
					endif
				Next
				Write(  nRow, 00, Repl( SEP, Tam ))
				Write(++nRow, 40, "*** Valor Total do Faturamento ***" )
				Write(  nRow, 77, Tran( nTotal,"@E 9,999,999,999.99" ) )
				nRow += 2
				if nRow >= 45
					__Eject()
					FrontParcial( ++Pagina, cFatura, dEmis, cForma, cCodiven )
					nRow := 11
				endif
				FechaTit( nRow, nDesconto )
				__Eject()
			endif
		Next
		PrintOff()
		ResTela( cTela )
	endif
endif
ResTela( cScreen )
return

Proc RelacaoEntrega()
*********************
LOCAL Tam			 := CPI1280
LOCAL cScreen		 := SaveScreen()
LOCAL aFatuTemp	 := {}
LOCAL aFatura		 := {}
LOCAL aRegis		 := {}
LOCAL aRegiTemp	 := {}
LOCAL aAp			 := {}
LOCAL nRow			 := 58
LOCAL nTamanho 	 := 0
LOCAL nDesconto	 := 0
LOCAL nTotal		 := 0
LOCAL nParcial 	 := 0
LOCAL nItens		 := 0
LOCAL nLen			 := 0
LOCAL Pagina		 := 0
LOCAL cTela

BuscaFatura( @aFatuTemp, @aFatura, @aRegis, @aRegiTemp, "RELACAO DE ENTREGA" )
if ( nTamanho := Len( aFatura )) > 0
	oMenu:Limpa()
	ErrorBeep()
	if Conf("Pergunta: Imprimir Relacao de Entrega ?" )
		if !InsTru80() .OR. !LptOk()
			ResTela( cScreen )
			return
		endif
		Forma->(Order( FORMA_FORMA ))
		Cep->(Order( CEP_CEP ))
		Receber->(Order( RECEBER_CODI ))
		Lista->(Order( LISTA_CODIGO ))
		Saidas->(Order( SAIDAS_FATURA ))
		cTela 	:= SaveScreen()
		nTamanho := Len( aFatura )
		nParcial := 0
		nTotal	:= 0
		Mensagem("Aguarde, Imprimindo.", Cor())
		PrintOn()
		FPrint( _CPI12 )
		For nX := 1 To nTamanho
			cFatura := aFatura[ nX ]
			if Saidas->(DbSeek( cFatura ))
				if nRow >= 52
					Write( 00, 00, Linha1( Tam, @Pagina))
					Write( 01, 00, Linha2())
					Write( 02, 00, Linha3(Tam))
					Write( 03, 00, Linha4(Tam, SISTEM_NA2 ))
					Write( 04, 00, Padc("RELACAO DE FATURAS PARA ENTREGA",Tam ) )
					nRow := 5
				endif
				Qout( Repl( SEP, Tam ))
				Receber->(DbSeek( Saidas->Codi ))
				Forma->(DbSeek(Saidas->Forma))
				Qout( NG + Receber->Codi,;
							  Receber->Nome,;
							  NR,;
							  Receber->Ende,;
							  Receber->Fone )
				Qout( Space(04),;
						Receber->Bair,;
						Receber->Cida,;
						Receber->Esta,;
						Saidas->Forma,;
						Forma->Condicoes )
				Qout( Space(04),;
						"PEDIDO: "  + Saidas->Fatura,;
						"FATURA: "  + Saidas->Fatura,;
						"EMISSAO: " + Saidas->(Dtoc( Emis )),;
						"VALOR: "   + NG + Saidas->(Tran( VlrFatura, "@E 9,999,999,999.99")) + NR )
				Qout( Space(04), "RECEBI TODAS AS MERCADORIAS DA FATURA ACIMA:")
				nRow		+= 5
				nParcial += Saidas->VlrFatura
				nTotal	+= Saidas->VlrFatura
				if nRow >= 52 .OR. nX = nTamanho
					Qout( Repl( SEP, Tam ))
					Qout( NG + " ** SUBTOTAL RELACAO DE ENTREGA ** " + Space(31) + Tran( nParcial, "@E 9,999,999,999.99") + NR)
					nRow		+= 3
					nParcial := 0
					if nX = nTamanho
						Qout( NG + " ** TOTAL RELACAO DE ENTREGA    ** " + Space(31) + Tran( nTotal,   "@E 9,999,999,999.99") + NR )
					endif
					__Eject()
				endif
			endif
		Next
		PrintOff()
		ResTela( cTela )
	endif
endif
ResTela( cScreen )
return

#ifDEF MICROBRASPB
	Proc NotaFiscal( cNoFatura )
	****************************
	LOCAL Getlist	  := {}
	LOCAL cScreen	  := SaveScreen()
	LOCAL aMenuArray := { " Por Periodo ", " Selecionar " }
	LOCAL nChoice	  := 0
	LOCAL lSair 	  := FALSO
	LOCAL lInicio	  := OK
	LOCAL aFatuTemp  := {}
	LOCAL aFatura	  := {}
	LOCAL aRegis	  := {}
	LOCAL aRegiTemp  := {}
	LOCAL nX 		  := 0
	LOCAL nTotal	  := 0
	LOCAL dEmissao   := Date()
	LOCAL dSaida	  := Date()
	LOCAL nDesconto  := 0
	LOCAL nAliquota  := 0
	LOCAL nLine 	  := 0
	LOCAL nPvendido  := 0
	LOCAL nSoma 	  := 0
	LOCAL cCodigo
	LOCAL bBloco
	LOCAL dIni
	LOCAL dFim
	LOCAL nItens
	LOCAL cPedido
	LOCAL nTamanho
	LOCAL nRegis
	LOCAL cTela
	LOCAL cCep
	LOCAL cNatu

	if cNoFatura = NIL
		BuscaFatura( @aFatuTemp, @aFatura, @aRegis, @aRegiTemp, "NOTA FISCAL" )
	else
		Aadd( aFatura, cNofatura )
	endif
	Saidas->(Order(TRES))
	Saidas->(DbGoTop())
	if ( nTamanho := Len( aFatura )) > 0
		oMenu:Limpa()
		dSaida	 := Date()
		dEmissao  := Date()
		nDesconto := 0
		MaBox( 10, 10, 14, 70, "INFORMACOES COMPLEMENTARES")
		@ 11, 11 Say "Desconto.........:" Get nDesconto Pict "99.99"
		@ 12, 11 Say "Emissao..........:" Get dEmissao  Pict PIC_DATA
		@ 13, 11 Say "Saida............:" Get dSaida    Pict PIC_DATA
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			return
		endif
		ErrorBeep()
		if Conf('Pergunta: Confirma Impressao da Nota Fiscal ?' )
			if !InsTru80()
				ResTela( cScreen )
				return
			endif
			Cep->(Order( CEP_CEP ))
			Receber->(Order( RECEBER_CODI ))
			Lista->(Order( LISTA_CODIGO ))
			Saidas->(Order( SAIDAS_FATURA ))
			cTela 	 := SaveScreen()
			nTamanho  := Len( aFatura )
			Mensagem("Aguarde, Imprimindo.", Cor())
			FOR nX := 1 To nTamanho
				if nX > 1
					PrintOff()
					if !Conf("Esperando para imprimir proxima Nota. Imprimir ?")
						lSair := OK
						Exit
					endif
				endif
				cTela  := Mensagem("Aguarde, Imprimindo.", Cor())
				nTotal := 0
				bBloco := {|| Saidas->Fatura = aFatura[ nX ] }
				Saidas->(DbSeek( aFatura[ nX ]))
				Receber->(DbSeek( Saidas->Codi ))
				Cep->(DbSeek( Receber->Cep ))
				nAliquota	 := Cep->Tx_Icms
				cNatu 		 := Cep->Nat_Oper
				PrintOn()
				SetPrc(0, 0)
				nLine   := 23
				nItens  := 0
				lSair   := FALSO
				WHILE EVal( bBloco ) .AND. Rel_Ok()
					if nItens = 0
						if !lInicio
							ResTela( cTela )
							if !Conf("Confirma Impressao Restante Nota Fiscal ?")
								lSair := OK
								Exit
							endif
							nLine := 23
						endif
						CabNota( cNatu, dEmissao, dSaida )
					endif
					cCodigo	 := Saidas->Codigo
					nPvendido := Saidas->Pvendido
					nPvendido -= ( nPvendido * nDesconto ) / 100
					nSoma 	 := ( Saidas->Saida * nPvendido )
					Lista->(DbSeek( cCodigo ))
					Qout( Space(06),;
							Saidas->Codigo,;
							" ",;
							Lista->Descricao,;
							Space(24),;
							Lista->Situacao,;
							Space(04),;
							Lista->Un,;
							Saidas->Saida,;
							Tran( nPvendido, "@E 999,999,999.99"),;
							Space(1),;
							Tran( nSoma,  "@E 9,999,999,999.99"),;
							Space(1),;
							Tran( nAliquota,"99"))
					nItens++
					nLine++
					nTotal += nSoma
					if nItens = 19
						nItens := 0
						SubNota( nLine, nTotal, nAliquota )
						__Eject()
						nLine   := 23
						nTotal  := 0
						lInicio := FALSO
					endif
					Saidas->(DbSkip(1))
				EndDo
				if !lSair
					SubNota( nLine, nTotal, nAliquota )
				endif
				__Eject()
			Next
			PrintOff()
			ResTela( cTela )
		endif
	endif
	ResTela( cScreen )
	return

	Proc CabNota( cNatu, dEmissao, dSaida )
	***************************************
	LOCAL nCol := 03

	FPrint( PQ )
	Write( nCol+00, 82 , "XX")
	Write( nCol+08, 07 , "VENDA")
	Write( nCol+08, 43 , cNatu )
	Write( nCol+11, 07 , Receber->Nome )
	if Empty( Receber->Cgc ) .OR. Receber->Cgc = "  .   .   /    -  "
		Write( nCol+11, 92, Receber->Cpf )
	else
		Write( nCol+11, 92, Receber->Cgc )
	endif
	Write( nCol+11, 127 , dEmissao )
	Write( nCol+13, 007 , Receber->Ende )
	Write( nCol+13, 072 , Receber->Bair )
	Write( nCol+13, 104 , Receber->Cep )
	Write( nCol+13, 127 , dSaida )
	Write( nCol+15, 007 , Receber->Cida )
	Write( nCol+15, 084 , Receber->Esta )
	if Empty( Receber->Cgc ) .OR. Receber->Cgc = "  .   .   /    -  "
		Write( nCol+15, 92, Receber->Rg )
	else
		Write( nCol+15, 92, Receber->Insc )
	endif
	Fprint( PQ )
	Qout("")
	Qout("")
	Qout("")
	Qout("")
	return

	Proc SubNota( nLine, nTotal, nAliquota )
	****************************************
	LOCAL nIcms := ( nTotal * nAliquota / 100 )

	Write( 44, 003, Tran( nTotal, "@E 99,999,999,999.99"))
	Write( 44, 023, Tran( nIcms,	"@E 99,999,999,999.99"))
	Write( 44, 117, Tran( nTotal, "@E 99,999,999,999.99"))
	Write( 46, 117, Tran( nTotal, "@E 99,999,999,999.99"))
	return
#else
	Proc NotaFiscal( cNoFatura )
	****************************
	LOCAL Getlist		 := {}
	LOCAL aTrans		 := {}
	LOCAL aMenuArray	 := { " Por Periodo ", " Por Regiao", " Selecionar " }
	LOCAL nChoice		 := 0
	LOCAL lSair 		 := FALSO
	LOCAL lInicio		 := OK
	LOCAL aNotaConfig  := {}
	LOCAL nTotalProd	 := 0
	LOCAL nTotalServ	 := 0
	LOCAL nTotalNota	 := 0
	LOCAL nLinha		 := 0
	LOCAL nItens		 := 0
	LOCAL cScreen		 := SaveScreen()
	LOCAL aFatuTemp	 := {}
	LOCAL aFatura		 := {}
	LOCAL aRegis		 := {}
	LOCAL aRegiTemp	 := {}
	LOCAL nTamanho 	 := 0
	LOCAL nDesconto	 := 0
	LOCAL nRow			 := 0
	LOCAL Pagina		 := 0
	LOCAL nBaseIcms	 := 0
	LOCAL nBaseSubs	 := 0
	LOCAL nVlrIcms 	 := 0
	LOCAL nVlrSubs 	 := 0
	LOCAL nAliquota	 := 0
	LOCAL nTaxa 		 := 0
	LOCAL lRetornoBeleza := FALSO
	LOCAL aMenuNota
	LOCAL dIni
	LOCAL dFim
	LOCAL cPedido
	LOCAL nQtFaturas
	LOCAL nRegis
	LOCAL cTela
	LOCAL cCodifor
	LOCAL nFrete
	LOCAL cPlaca
	LOCAL cUf
	LOCAL cCgc
	LOCAL cEnde
	LOCAL cUf1
	LOCAL cCida
	LOCAL cInsc
	LOCAL nVolumes
	LOCAL cEspecie
	LOCAL dEmissao
	LOCAL dSaida
	LOCAL cFatura
	LOCAL sNome
	LOCAL sEnde
	LOCAL sCida
	LOCAL sEsta
	LOCAL sFone
	LOCAL sBair
	LOCAL sCep
	LOCAL SCpf
	LOCAL SCgc
	LOCAL sRg
	LOCAL sInsc
	LOCAL cTransportador
	LOCAL cEsta
	LOCAL cInscr
	LOCAL nL
	LOCAL nX
	LOCAL cFaturaSub
	LOCAL cMacro
	LOCAL bBloco
	LOCAL cNatu
	LOCAL Line
	LOCAL nPvendido
	LOCAL nSoma
	LOCAL aNt
	LOCAL nReducao
	LOCAL nSomaSub
	LOCAL nSomaRed
	LOCAL cClasse
	LOCAL nIcmsRed
	LOCAL nIcms
	LOCAL nSub
	LOCAL nBaseRed
	LOCAL cStr
	LOCAL lSequencia
	LOCAL cCodigo
	LOCAL cMarca
	LOCAL cNumero
	LOCAL nPesoBruto
	LOCAL nPesoLiq
	LOCAL lServico
   LOCAL cObs1 := oIni:ReadString('notafiscal', 'obs1')
   LOCAL cObs2 := oIni:ReadString('notafiscal', 'obs2')
   LOCAL cObs3 := oIni:ReadString('notafiscal', 'obs3')
	FIELD Fatura
	FIELD Codigo
	FIELD Saida
	FIELD Vcto

   if cNoFatura = NIL
		BuscaFatura( @aFatuTemp, @aFatura, @aRegis, @aRegiTemp, "NOTA FISCAL" )
	else
		Aadd( aFatura, cNofatura )
	endif
	Saidas->(Order(TRES))
	Saidas->(DbGoTop())
	if Len( aFatura ) > 0
		lRetornoBeleza := FALSO
		aMenuNota		:= { "Imprimir, Usando um Existente", "Criar Arquivo de Configuracao ", "Alterar Arquivos de Nota"}
		if !File("*.NFF")
			WHILE OK
				oMenu:Limpa()
				M_Title("IMPRESSAO DE NOTA FISCAL")
				nChoice := FazMenu( 10, 10, aMenuNota, Cor())
				Do Case
				Case nChoice = 0
					ResTela( cScreen )
					return
				Case nChoice = 2
					GravaNota()
					Loop
				Case nChoice = 3
					Edicao( OK, "*.NFF" )
					Loop
				EndCase
				Exit
			EndDo
		endif
		aNotaConfig := LerNotaFiscal(,@lRetornoBeleza  )
		if !lRetornoBeleza
			ResTela( cScreen )
			return
		endif
		oMenu:Limpa()
		nDesconto		:= 0
		cCodifor 		:= Space(04)
		nFrete			:= 1
		cPlaca			:= Space(08)
		cUf				:= "RO"
		cCgc				:= XCGCFIR
		cEnde 			:= XENDEFIR + Space(40 - Len( XENDEFIR ))
		cCida 			:= XCCIDA	+ Space(25 - Len( XCCIDA ))
		cUf1				:= "RO"
		cInsc 			:= XINSCFIR + Space(14 - Len( XINSCFIR ))
		nVolumes 		:= 1
		cEspecie 		:= "VOLUMES        "
		dEmissao 		:= Date()
		dSaida			:= Date()
		cFatura			:= aFatura[1]
		cMarca			:= Space( 14 )
		cNumero			:= Space( 14 )
		nPesoBruto		:= 0
		nPesoLiq 		:= 0
		lSequencia		:= "S"
		nLinha			:= 09

		Saidas->(DbSeek( cFatura ))
		Receber->(DbSeek( Saidas->Codi ))
		sNome 			:= Receber->Nome
		sEnde 			:= Receber->Ende
		sCida 			:= Receber->Cida
		sEsta 			:= Receber->Esta
		sFone 			:= Receber->Fone
		sBair 			:= Receber->Bair
		sCep				:= Receber->Cep
		sCpf				:= Receber->Cpf
		sCgc				:= Receber->Cgc
		sRg				:= Receber->Rg
		sInsc 			:= Receber->Insc

		if cNoFatura != NIL
			MaBox( 01, 01, 07, 75, "INFORMACOES CLIENTE")
			@ 02		  , 02 Say "Cliente..:" Get sNome          Pict "@!"
			@ 03		  , 02 Say "Endereco.:" Get sEnde          Pict "@!"
			@ 03		  , 44 Say "Bairro...:" Get sBair          Pict "@!"
			@ 04		  , 02 Say "Cidade...:" Get sCida          Pict "@!"
			@ 04		  , 44 Say "Estado...:" Get sEsta          Pict "@!"
			@ 05		  , 02 Say "Cpf......:" Get sCpf           Pict "999.999.999-99"     Valid TestaCpf( sCpf )
			@ 05		  , 44 Say "Cgc......:" Get sCgc           Pict "99.999.999/9999-99" Valid TestaCgc( sCgc )
			@ 06		  , 02 Say "RG.......:" Get sRg            Pict "@!"
			@ 06		  , 44 Say "Insc Est.:" Get sInsc          Pict "@!"
			if LastKey() = ESC
				ResTela( cScreen )
				return
			endif
		endif
		MaBox( 08, 01, 23, 75, "INFORMACOES COMPLEMENTARES")
		@ nLinha   , 02 Say "Imprimir Sequencia..:" Get lSequencia     Pict "!" Valid lSequencia $ "SN"
		@ nLinha+01, 02 Say "N§ Nota Fiscal......:" Get cFatura        Pict "@!" When lSequencia = "S"
		@ nLinha+02, 02 Say "Data Emissao........:" Get dEmissao       Pict PIC_DATA
		@ nLinha+03, 02 Say "Data Saida..........:" Get dSaida         Pict PIC_DATA
		@ nLinha+04, 02 Say "Desconto............:" Get nDesconto      Pict "99.99"
		@ nLinha+05, 02 Say "Transportadora......:" Get cCodifor       Pict "9999" Valid Pagarrado( @cCodifor, Row(), Col()+1 )
		@ nLinha+06, 02 Say "Frete...............:" Get nFrete         Pict "9"
		@ nLinha+07, 02 Say "Placa...............:" Get cPlaca         Pict "@!"
		@ nLinha+08, 02 Say "Qtde Volumes........:" Get nVolumes       Pict "999"
		@ nLinha+09, 02 Say "Especie.............:" Get cEspecie       Pict "@!"
		@ nLinha+10, 02 Say "Marca...............:" Get cMarca         Pict "@!"
		@ nLinha+11, 02 Say "Numero..............:" Get cNumero        Pict "@!"
		@ nLinha+12, 02 Say "Peso Bruto..........:" Get nPesoBruto     Pict "999999.9999"
		@ nLinha+13, 02 Say "Peso Liquido........:" Get nPesoLiq       Pict "999999.9999"

		Read
		if LastKey() = ESC .OR. !InsTru80()
			ResTela( cScreen )
			return
		endif
		cTransportador := Pagar->Nome
		cEnde 			:= Pagar->Ende
		cCida 			:= Pagar->Cida
		cEsta 			:= Pagar->Esta
		cInscr			:= Pagar->Insc
		cCgc				:= Pagar->Cgc
		Aadd( aTrans, cTransportador )
		Aadd( aTrans, nFrete )
		Aadd( aTrans, cPlaca )
		Aadd( aTrans, cUf 	)
		Aadd( aTrans, cCgc	)
		Aadd( aTrans, cEnde	)
		Aadd( aTrans, cCida	)
		Aadd( aTrans, cUf1	)
      Aadd( aTrans, cInscr )
		Aadd( aTrans, nVolumes	)
		Aadd( aTrans, cEspecie	)
		Aadd( aTrans, sNome	)
		Aadd( aTrans, sEnde	)
		Aadd( aTrans, sCida	)
		Aadd( aTrans, sEsta	)
		Aadd( aTrans, sFone	)
		Aadd( aTrans, sBair	)
		Aadd( aTrans, sCep  )
		Aadd( aTrans, sCpf  )
		Aadd( aTrans, sCgc  )
		Aadd( aTrans, sRg  )
      Aadd( aTrans, sInsc )
      Aadd( aTrans, cMarca  )
		Aadd( aTrans, cNumero  )
		Aadd( aTrans, nPesoBruto )
		Aadd( aTrans, nPesoLiq )
      Aadd( aTrans, cEsta )

		Cep->(Order( CEP_CEP ))
		Receber->(Order( RECEBER_CODI ))
		Lista->(Order( LISTA_CODIGO ))
		Saidas->(Order( SAIDAS_FATURA ))

		cTela 			:= SaveScreen()
		lSair 			:= FALSO
		nQtFaturas		:= Len( aFatura )
		nL 				:= Len( AllTrim( cFatura ))
		cTela 			:= Mensagem("Aguarde, Imprimindo Nota.", Cor())
		PrintOn()
		FPrint( RESETA )
		FOR nX := 1 To nQtFaturas
			SetPrc(0, 0)
			cFaturaSub	:= aFatura[nX]
			if lSequencia == "S"
				if nX > 1
					cFatura := StrZero( Val( cFatura ) + 1, nL )
				endif
			else
				cFatura := aFatura[nX]
			endif
			if nX > 1
				LigaTela()
				Set Cons On
				Set Devi To Screen
				if !Conf("Imprimir Proxima Nota ?")
					lSair := OK
					Exit
				endif
				DesLigaTela()
			endif
			nTotalServ		  := 0
			nTotalProd		  := 0
			nTotalNota		  := 0
			bBloco			  := {|| Saidas->Fatura = aFatura[nX] }
			Saidas->(DbSeek( aFatura[ nX ]))
			Receber->(DbSeek( Saidas->Codi ))
			Cep->(DbSeek( Receber->Cep ))
			nAliquota := Cep->Tx_Icms
			cEstado	 := Cep->Esta
			cNatu 	 := Cep->Nat_Oper

			#DEFINE XLINHAS		21
			#DEFINE XORIGINAL 	22
			#DEFINE XCODIGO		23
			#DEFINE XDESCRICAO	24
			#DEFINE XCLASSifI 	25
			#DEFINE XSITUACAO 	26
			#DEFINE XUN 			27
			#DEFINE XQT 			28
			#DEFINE XUNITARIO 	29
			#DEFINE XTOTAL 		30
			#DEFINE XTAXA			31
         #DEFINE XOBS1        59
         #DEFINE XOBS2        60
         #DEFINE XOBS3        61

			Line		 := aNotaConfig[XCODIGO,01]
			nItens	 := 0
			lSair 	 := FALSO
			nBaseIcms := 0
			nBaseSubs := 0
			nVlrIcms  := 0
			nVlrSubs  := 0
			nBaseRed  := 0
			WHILE Saidas->(EVal( bBloco )) .AND. Rel_Ok()
				if nItens = 0
					if !lInicio
						ResTela( cTela )
						LigaTela()
						if !Conf("Confirma Impressao Restante Nota Fiscal ?")
							lSair := OK
							Exit
						endif
						Line := aNotaConfig[XCODIGO,01]	// Inicializa Linha
						DesLigaTela()
					endif
					SetPrc(0, 0)
					CabNota( aNotaConfig, cFatura, cNatu, cNoFatura, dEmissao, dSaida, aTrans )
				endif
				nPvendido := Saidas->Pvendido
				nPvendido -= ( nPvendido * nDesconto ) / 100
				nSoma 	 := ( Saidas->Saida * nPvendido )
				aNt		 := aNotaConfig
				xAliquota := nAliquota
				Lista->(DbSeek( Saidas->Codigo ))
				cClasse	 := Lista->Classe
				cSituacao := Lista->Situacao
				lServico  := Lista->Servico
				if lServico // Produto eh um servico ?
					nTaxa 	  := 0
					nReducao   := 0
					cClasse	  := "4" // Isento ou nao Tributado
					cSituacao  := "0"
					nTotalServ += nSoma
					nAliquota  := 0
				else
					nReducao   := ReducaoBase( cEstado )
					nTaxa 	  := Lista->Tx_Icms
					nTotalProd += nSoma
					nAliquota  := xAliquota
				endif
				*:----------------------------------------------------------------------------
				if( anT[XORIGINAL,	 02] >= 0, Write( Line, anT[XORIGINAL, 	02], Lista->N_Original ),)
				if( anT[XCODIGO,		 02] >= 0, Write( Line, anT[XCODIGO,		02], Saidas->Codigo	  ),)
				if( anT[XDESCRICAO,	 02] >= 0, Write( Line, anT[XDESCRICAO,	02], Lista->Descricao  ),)
				if( anT[XCLASSifI,	 02] >= 0, Write( Line, anT[XCLASSifI, 	02], cClasse			  ),)
				if( anT[XSITUACAO,	 02] >= 0, Write( Line, anT[XSITUACAO, 	02], cSituacao 		  ),)
				if( anT[XUN,			 02] >= 0, Write( Line, anT[XUN, 			02], Lista->Un 		  ),)
				if( anT[XQT,			 02] >= 0, Write( Line, anT[XQT, 			02], Saidas->Saida	  ),)
				if( anT[XUNITARIO,	 02] >= 0, Write( Line, anT[XUNITARIO, 	02], Tran( nPvendido, "@E 999,999,999.99")),)
				if( anT[XTOTAL,		 02] >= 0, Write( Line, anT[XTOTAL, 		02], Tran( nSoma, 	 "@E 999,999,999.99")),)
				if( anT[XTAXA, 		 02] >= 0, Write( Line, anT[XTAXA,			02], Tran( nAliquota, "99")),)
				nItens++
				Line++
				nTotalNota += nSoma
				nSomaRed := nSoma - (( nSoma * nReducao ) / 100 )
				if nSomaRed = 0
					nSomaRed = nSoma
				endif
				nSomaSub   := ( nSoma + (( nSoma * nTaxa ) / 100 ))
				nIcmsRed   := ( nSomaRed * nAliquota ) / 100
				nIcms 	  := ( nSoma * nAliquota ) / 100
				nSub		  := (( nSomaSub * nAliquota ) / 100 ) - nIcms
				Do Case
				Case cClasse = "0" // Tributado Integralmente
					nBaseIcms += nSoma
					nBaseSubs += 0
					nVlrIcms  += nIcms
					nVlrSubs  += 0
				Case cClasse = "1" // Tributado e Icms por Substituicao
					nBaseIcms  += nSoma
					nBaseSubs  += nSomaSub
					nVlrIcms   += nIcms
					nVlrSubs   += nSub
					nTotalNota += nSub
				Case cClasse = "2" // Com Reducao da Base de Calculo
					nBaseIcms += nSomaRed
					nBaseSubs += 0
					nVlrIcms  += nIcmsRed
					nVlrSubs  += 0
				Case cClasse = "3" // Isenta e Icms por Substituicao Tributaria
					nBaseIcms += 0
					nBaseSubs += nSomaSub
					nVlrIcms  += 0
					nVlrSubs  += nSub
					nTotalNota += nSub
				Case cClasse = "4" // Isenta ou nao tributada
					nBaseIcms += 0
					nBaseSubs += 0
					nVlrIcms  += 0
					nVlrSubs  += 0
				Case cClasse = "5"
				Case cClasse = "6"
				Case cClasse = "7"
				EndCase
				*:----------------------------------------------------------------------------
				if nItens		  = anT[XLINHAS,01]
					nItens		  := 0
					SubNota( Line, aNotaConfig, aTrans, cFaturaSub, cFatura, nDesconto, nTotalServ, nTotalProd, nBaseIcms, nBaseSubs, nVlrIcms, nVlrSubs, nTotalNota )
					__Eject()
					Line		  := aNotaConfig[XCODIGO,01]	// Inicializa Linha
					nTotalServ := 0								// Inicializa Valor Total dos Servicos
					nTotalProd := 0								// Inicializa Valor Total dos Produtos
					nTotalNota := 0								// Inicializa Valor Total da Nota
					lInicio	  := FALSO
					nBaseIcms  := 0
					nBaseSubs  := 0
					nVlrIcms   := 0
					nVlrSubs   := 0
					nBaseRed   := 0
				endif
				Saidas->(DbSkip(1))
			EndDo
         *:----------------------------------------------------------------------------
         xLineObs := anT[XOBS1,01]
         if xLineObs >= 0
            Write( anT[XOBS1,01], anT[XOBS1,02], cObs1 )
            Write( anT[XOBS2,01], anT[XOBS2,02], cObs2 )
            Write( anT[XOBS3,01], anT[XOBS3,02], cObs3 )
            Line += 3
         endif
         *:----------------------------------------------------------------------------
			if !lSair
				SubNota( Line, aNotaConfig, aTrans, cFaturaSub, cFatura, nDesconto, nTotalServ, nTotalProd, nBaseIcms, nBaseSubs, nVlrIcms, nVlrSubs, nTotalNota )
			endif
			__Eject()
		Next
		PrintOff()
		ResTela( cTela )
	endif
	ResTela( cScreen )
	return

	Proc CabNota( aNt, cFatura, cNatu, cNoFatura, dEmissao, dSaida, aTrans )
	************************************************************************
	#DEFINE XIMPRIMIRCONDENSADO	1
	#DEFINE XIMPRIMIR12CPI			2
	#DEFINE XIMPRIMIRNEGRITO		3
	#DEFINE XESPACAMENTOVERTICAL	4
	#DEFINE XSAIDA 					5
	#DEFINE XNATUREZA 				6
	#DEFINE XCFOP						7
	#DEFINE XINSCRICAOSUB			8
	#DEFINE XNOME						9
	#DEFINE XCGC						10
	#DEFINE XEMISSAO					11
	#DEFINE XENDERECO 				12
	#DEFINE XBAIRRO					13
	#DEFINE XCEP						14
	#DEFINE XDATASAIDA				15
	#DEFINE XMUNICIPIO				16
	#DEFINE XFONEFAX					17
	#DEFINE XUF 						18
	#DEFINE XINSCRICAO				19
	#DEFINE XHORA						20
	#DEFINE XFATURACABECALHO		54
	LOCAL lCgcVazio					:= FALSO

	if aNt[XIMPRIMIRCONDENSADO,1]  > 0 ; FPrint( PQ )			; endif
	if aNt[XIMPRIMIR12CPI,1]		 > 0 ; FPrint( _CPI12 ) 	; endif
	if aNt[XIMPRIMIRNEGRITO,1] 	 > 0 ; FPrint( NG )			; endif
	if aNt[XESPACAMENTOVERTICAL,1] = 0 ; FPrint( _SPACO1_6 ) ; endif
	if aNt[XESPACAMENTOVERTICAL,1] = 1 ; FPrint( _SPACO1_8 ) ; endif
	if( aNt[XFATURACABECALHO,	 01] >= 0, Write( aNt[XFATURACABECALHO,	01], aNt[XFATURACABECALHO,   02], cFatura ),)
	if( aNt[XSAIDA,				 01] >= 0, Write( aNt[XSAIDA, 				01], aNt[XSAIDA,				  02], "XX"),)
	if( aNt[XNATUREZA,			 01] >= 0, Write( aNt[XNATUREZA, 			01], aNt[XNATUREZA,			  02], "VENDA"),)
	if( aNt[XCFOP, 				 01] >= 0, Write( aNt[XCFOP	 , 			01], aNt[XCFOP,				  02], cNatu ),)
	if( aNt[XNOME, 				 01] >= 0, Write( aNt[XNOME	 , 			01], aNt[XNOME,				  02], if( cNofatura = NIL, Receber->Nome, aTrans[12])),)
	if cNofatura = NIL
		lCgcVazio := Empty( Receber->Cgc ) .OR. Receber->Cgc = "  .   .   /    -  "
	else
		lCgcVazio := Empty( aTrans[20]) .OR. aTrans[20] = "  .   .   /    -  "
	endif
	if lCgcVazio
		if( aNt[XCGC,		01] >= 0,  Write( aNt[XCGC 	, 01], aNt[XCGC,		02],	if( cNofatura = NIL, Receber->Cpf, aTrans[19])),)
	else
		if( aNt[XCGC,		01] >= 0,  Write( aNt[XCGC 	, 01], aNt[XCGC,		02],	if( cNofatura = NIL, Receber->Cgc, aTrans[20])),)
	endif
	if( aNt[XEMISSAO,   01] >= 0, Write( aNt[XEMISSAO	  , 01], aNt[XEMISSAO,		02],	dEmissao ),)
	if( aNt[XENDERECO,  01] >= 0, Write( aNt[XENDERECO   , 01], aNt[XENDERECO, 	02],	if( cNofatura = NIL, Receber->Ende, aTrans[13])),)
	if( aNt[XBAIRRO,	  01] >= 0, Write( aNt[XBAIRRO	  , 01], aNt[XBAIRRO,		02],	if( cNofatura = NIL, Receber->Bair, aTrans[17])),)
	if( aNt[XCEP,		  01] >= 0, Write( aNt[XCEP		  , 01], aNt[XCEP,			02],	if( cNofatura = NIL, Receber->Cep,	aTrans[18])),)
	if( aNt[XDATASAIDA, 01] >= 0, Write( aNt[XDATASAIDA  , 01], aNt[XDATASAIDA,	02],	dSaida ),)
	if( aNt[XMUNICIPIO, 01] >= 0, Write( aNt[XMUNICIPIO  , 01], aNt[XMUNICIPIO,	02],	if( cNofatura = NIL, Receber->Cida, aTrans[14])),)
	if( aNt[XFONEFAX,   01] >= 0, Write( aNt[XFONEFAX, 	 01], aNt[XFONEFAX,		02],	if( cNofatura = NIL, Receber->Fone, aTrans[16])),)
	if( aNt[XUF,		  01] >= 0, Write( aNt[XUF,			 01], aNt[XUF, 			02],	if( cNofatura = NIL, Receber->Esta, aTrans[15])),)
	if cNofatura = NIL
		lCgcVazio := Empty( Receber->Cgc ) .OR. Receber->Cgc = "  .   .   /    -  "
	else
		lCgcVazio := Empty( aTrans[20]) .OR. aTrans[20] = "  .   .   /    -  "
	endif
	if lCgcVazio
		if( aNt[XINSCRICAO, 01] >=0, Write( aNt[XINSCRICAO,	01], aNt[XINSCRICAO,   02],  if( cNofatura = NIL, Receber->Rg, aTrans[21])),)
	else
		if( aNt[XINSCRICAO, 01] >=0, Write( aNt[XINSCRICAO,	01], aNt[XINSCRICAO,   02],  if( cNofatura = NIL, Receber->Insc, aTrans[22])),)
	endif
	if( aNt[XHORA, 01] >=0, Write( aNt[XHORA,   01], aNt[XHORA,   02],  Time()),)
	return

	Proc SubNota( Line, aNotaConfig, aTrans, cFaturaSub, cFatura, nDesconto, nTotalServ, nTotalProd, nBaseIcms, nBaseSubs, nVlrIcms, nVlrSubs, nTotalNota )
	***************************************************************************************************************************************
	LOCAL nRow				 := 0
	LOCAL nCol				 := 0
	LOCAL nConta			 := 0
	LOCAL aConta			 := {"A","B","C","D","E","F","G","H","I","J"}
	LOCAL nVlrComDesconto := 0
	LOCAL nIss				 := 0
	#DEFINE XBASE				32
	#DEFINE XICMS				33
	#DEFINE XBASESUB			34
	#DEFINE XICMSSUB			35
	#DEFINE XTOTALPRODUTOS	36
	#DEFINE XTOTALNOTA		37
	#DEFINE XTRANSPORTADOR	38
	#DEFINE XDADOS 			53
	#DEFINE XFATURARODAPE	55
	#DEFINE XINSCMUN			56
	#DEFINE XISS				57
	#DEFINE XSERVICO			58

	anT		:= aNotaConfig
	nIss		:= ( nTotalServ * aIss[1] ) / 100
	if( anT[XINSCMUN, 		  01] >= 0, Write( anT[XINSCMUN, 		01], anT[XINSCMUN,		 02], aInscMun[1] ),)
	if( anT[XISS,				  01] >= 0, Write( anT[XISS,				01], anT[XISS, 			 02], Tran( nIss, 		 "@E 99,999,999,999.99")),)
	if( anT[XSERVICO, 		  01] >= 0, Write( anT[XSERVICO, 		01], anT[XSERVICO,		 02], Tran( nTotalServ,   "@E 99,999,999,999.99")),)
	if( anT[XBASE, 			  01] >= 0, Write( anT[XBASE, 			01], anT[XBASE,			 02], Tran( nBaseIcms,	  "@E 99,999,999,999.99")),)
	if( anT[XICMS, 			  01] >= 0, Write( anT[XICMS, 			01], anT[XICMS,			 02], Tran( nVlrIcms,	  "@E 99,999,999,999.99")),)
	if( anT[XBASESUB, 		  01] >= 0, Write( anT[XBASESUB, 		01], anT[XBASESUB,		 02], Tran( nBaseSubs,	  "@E 99,999,999,999.99")),)
	if( anT[XICMSSUB, 		  01] >= 0, Write( anT[XICMSSUB, 		01], anT[XICMSSUB,		 02], Tran( nVlrSubs,	  "@E 99,999,999,999.99")),)
	if( anT[XTOTALPRODUTOS,   01] >= 0, Write( anT[XTOTALPRODUTOS, 01], anT[XTOTALPRODUTOS, 02], Tran( nTotalProd,   "@E 99,999,999,999.99")),)
	if( anT[XTOTALNOTA,		  01] >= 0, Write( anT[XTOTALNOTA,		01], anT[XTOTALNOTA, 	 02], Tran( nTotalNota,   "@E 99,999,999,999.99")),)
	if( anT[XTRANSPORTADOR+00,01] >= 0, Write( anT[XTRANSPORTADOR+00, 01], anT[XTRANSPORTADOR+00, 02],  aTrans[01] ),)
	if( anT[XTRANSPORTADOR+01,01] >= 0, Write( anT[XTRANSPORTADOR+01, 01], anT[XTRANSPORTADOR+01, 02],  aTrans[02] ),)
	if( anT[XTRANSPORTADOR+02,01] >= 0, Write( anT[XTRANSPORTADOR+02, 01], anT[XTRANSPORTADOR+02, 02],  aTrans[03] ),)
//   if( anT[XTRANSPORTADOR+03,01] >= 0, Write( anT[XTRANSPORTADOR+03, 01], anT[XTRANSPORTADOR+03, 02],  aTrans[04] ),)
   if( anT[XTRANSPORTADOR+03,01] >= 0, Write( anT[XTRANSPORTADOR+03, 01], anT[XTRANSPORTADOR+03, 02],  aTrans[27] ),)
	if( anT[XTRANSPORTADOR+04,01] >= 0, Write( anT[XTRANSPORTADOR+04, 01], anT[XTRANSPORTADOR+04, 02],  aTrans[05] ),)
	if( anT[XTRANSPORTADOR+05,01] >= 0, Write( anT[XTRANSPORTADOR+05, 01], anT[XTRANSPORTADOR+05, 02],  aTrans[06] ),)
	if( anT[XTRANSPORTADOR+06,01] >= 0, Write( anT[XTRANSPORTADOR+06, 01], anT[XTRANSPORTADOR+06, 02],  aTrans[07] ),)
//   if( anT[XTRANSPORTADOR+07,01] >= 0, Write( anT[XTRANSPORTADOR+07, 01], anT[XTRANSPORTADOR+07, 02],  aTrans[08] ),)
   if( anT[XTRANSPORTADOR+07,01] >= 0, Write( anT[XTRANSPORTADOR+07, 01], anT[XTRANSPORTADOR+07, 02],  aTrans[27] ),)
	if( anT[XTRANSPORTADOR+08,01] >= 0, Write( anT[XTRANSPORTADOR+08, 01], anT[XTRANSPORTADOR+08, 02],  aTrans[09] ),)
	if( anT[XTRANSPORTADOR+09,01] >= 0, Write( anT[XTRANSPORTADOR+09, 01], anT[XTRANSPORTADOR+09, 02],  aTrans[10] ),)
	if( anT[XTRANSPORTADOR+10,01] >= 0, Write( anT[XTRANSPORTADOR+10, 01], anT[XTRANSPORTADOR+10, 02],  aTrans[11] ),)
	if( anT[XTRANSPORTADOR+11,01] >= 0, Write( anT[XTRANSPORTADOR+11, 01], anT[XTRANSPORTADOR+11, 02],  aTrans[23] ),)
	if( anT[XTRANSPORTADOR+12,01] >= 0, Write( anT[XTRANSPORTADOR+12, 01], anT[XTRANSPORTADOR+12, 02],  aTrans[24] ),)
	if( anT[XTRANSPORTADOR+13,01] >= 0, Write( anT[XTRANSPORTADOR+13, 01], anT[XTRANSPORTADOR+13, 02],  Tran( aTrans[25], "999999.9999" )),)
	if( anT[XTRANSPORTADOR+14,01] >= 0, Write( anT[XTRANSPORTADOR+14, 01], anT[XTRANSPORTADOR+14, 02],  Tran( aTrans[26], "999999.9999" )),)
	if( anT[XDADOS,01] >= 0, nRow :=  anT[XDADOS, 01], nRow := 0 )
	if( anT[XDADOS,02] >= 0, nCol :=  anT[XDADOS, 02], nCol := 0 )
	if nRow != 0 .AND. nCol != 0
		 Recemov->(Order( QUATRO )) // Fatura
		 if Recemov->(DbSeek( cFaturaSub ))
			 DevPos( nRow, nCol ) ; DevOut("DOCTO N§    VENCTO            VALOR")
			 WHILE Recemov->Fatura = cFaturaSub
				 nConta++
				 nVlrComDesconto := Recemov->Vlr - ( ( Recemov->Vlr * nDesconto ) / 100)
				 cStr := Alltrim( cFatura ) + "-" + aConta[nConta]
				 Write( ++nRow,  nCol, cStr + Space(03) + Recemov->(Dtoc(Vcto)) + " " + Tran( nVlrComDesconto, "@E 999,999,999.99"))
				 Recemov->(DbSkip(1))
			 EndDo
		endif
	endif
	if( anT[XFATURARODAPE,01] >= 0, Write( anT[XFATURARODAPE, 01], anT[XFATURARODAPE, 02],  cFatura ),)
	return
#endif

Proc Sefaz()
************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL cFile   := "SEFAZ.TXT"
LOCAL aMestre := { "10", "50" }
LOCAL cCgc	  := StrTran(StrTran(StrTran( XCGCFIR, "."),"/"),"-")
LOCAL cInsc   := StrTran(StrTran( XINSCFIR, "."), "-")
LOCAL cNome   := Left( XNOMEFIR, 35 )
LOCAL cCida   := Left( XCCIDA, 30 )
LOCAL cEsta   := XCESTA
LOCAL cFone   := StrTran( StrTran( StrTran( StrTran( XFONE, "(" ), ")" ),"."), "-")
LOCAL dIni	  := Date()-30
LOCAL dFim	  := Date()
LOCAL cIni
LOCAL cFim
LOCAL oBloco
LOCAL Handle
LOCAL nBaseIcms  := 0
LOCAL nVlrIcms   := 0
LOCAL nBaseSubs  := 0
LOCAL nVlrSubs   := 0
LOCAL nTotal	  := 0
LOCAL nTotalNota := 0
LOCAL cCodi
LOCAL cData
LOCAL cFatura
LOCAL cNumero
LOCAL cModelo
LOCAL cSerie
LOCAL cSubSerie
LOCAL cFop
LOCAL cCep
LOCAL cSituacao
LOCAL nAliquota
LOCAL nIsenta
LOCAL nOutras
LOCAL nSoma
LOCAL cClasse
LOCAL nReducao
LOCAL nTaxa
LOCAL cDrive

oMenu:Limpa()
MaBox( 10, 10, 13, 40 )
@ 11, 11 Say "Data Inicial...." Get dIni Pict PIC_DATA  Valid if((Nota->(Order( NOTA_DATA )), Nota->(!DbSeek( dIni ))), ( ErrorBeep(), Alerta("Erro: Data Inicial Nao Localizada."), FALSO ), OK )
@ 12, 11 Say "Data Final......" Get dFim Pict PIC_DATA
Read
if LastKey() = ESC
	ResTela( cScreen )
	return
endif
Receber->(Order( RECEBER_CODI ))
Cep->(Order( CEP_CEP ))
Area("Nota")
Nota->(Order( NOTA_DATA ))
if Nota->(!DbSeek( dIni ))
	Nada()
	ResTela( cScreen )
	return
endif
oMenu:Limpa()
ErrorBeep()
if ( cDrive := MacroCopia()) = NIL
	ResTela( cScreen )
	return
endif
Mensagem("şşş Aguarde, Gerando arquivo.")
cFile  := cDrive + cFile
Handle := FCreate( cFile )
if ( Ferror() != 0 )
	ErrorBeep()
	Alert("Informa: Erro na abertura do arquivo " + cFile )
	ResTela( cScreen )
	return
endif
Mensagem("şşş Aguarde, Escrevendo no Arquivo.")
Set Cent On
Set Date Japan
cInsc 		  += Space(14-Len( AllTrim( cInsc )))
cNome 		  += Space(35-Len( AllTrim( cNome )))
cCida 		  += Space(30-Len( AllTrim( cCida )))
cFone 		  += Space(10-Len( AllTrim( cFone )))
cIni			  := StrTran( Dtoc( dIni ), "/")
cFim			  := StrTran( Dtoc( dFim ), "/")

MsWriteLine( Handle, aMestre[1] + cCgc + cInsc + cNome + cCida + cEsta + cFone + cIni + cFim )
oBloco := {|| Nota->Data >= dIni .AND. Nota->Data <= dFim }
WHILE Nota->( Eval( oBloco ))
	cCodi 	 := Nota->Codi
	cData 	 := StrTran( Dtoc( Nota->Data ), "/")
	cFatura	 := Nota->Numero
	cNumero	 := Right( Nota->Numero, 6 )
	cCgc		 := "00000000000000"
	cInsc 	 := "000000000"
	cEsta 	 := "00"
	cModelo	 := "01"
	cSerie	 := "000"
	cSubSerie := "00"
	cFop		 := "000"
	cCep		 := ""
	cSituacao := "N"
	nAliquota := 0
	if Receber->(DbSeek( cCodi ))
		cCgc	  := StrTran(StrTran(StrTran( Receber->Cgc, "."),"/"),"-")
		cInsc   := StrTran(StrTran( Receber->Insc, "."), "-")
		cEsta   := Receber->Esta
		cCep	  := Receber->Cep
	endif
	cInsc 	  += Space(14-Len( AllTrim( cInsc )))
	cInsc 	  := Left( cInsc, 14 )
	cCgc		  := Left( cCgc, 14 )
	if Cep->(DbSeek( cCep ))
		cFop		 := Cep->Nat_Oper
		nAliquota := Cep->Tx_Icms
	endif
	cFop		  := StrTran( cFop, ".")
	nBaseIcms  := 0
	nVlrIcms   := 0
	nBaseSubs  := 0
	nVlrSubs   := 0
	nTotal	  := 0
	nTotalNota := 0
	CalculoIcms( cFatura, nAliquota, @nBaseIcms, @nVlrIcms, @nBaseSubs, @nVlrSubs, @nTotal, @nTotalNota )
	nIsenta	  := nTotalNota - nBaseIcms
	nAliquota  := IntToStrRepl( nAliquota,  04 )
	nTotalNota := IntToStrRepl( nTotalNota, 13 )
	nBaseIcms  := IntToStrRepl( nBaseIcms,  13 )
	nVlrIcms   := IntToStrRepl( nVlrIcms,	 13 )
	nIsenta	  := IntToStrRepl( nIsenta,	 13 )
	nOutras	  := IntToStrRepl( 0,			 13 )
	MsWriteLine( Handle, aMestre[2] + cCgc + cInsc + cData + cEsta + cModelo + cSerie + cSubSerie + cNumero + ;
								cFop + nTotalNota + nBaseIcms + nVlrIcms + nIsenta + nOutras + nAliquota + cSituacao )
	Nota->(DbSkip(1))
EndDo
FClose( Handle )
oMenu:Limpa()
M_Title( "ESC - Retorna ³Setas CIMA/BAIXO Move")
M_View( 00, 00, MaxRow(), 79, cFile, Cor())
Set Date Brit
Set Cent Off
ResTela( cScreen )
return

Proc CalculoIcms( cFatura, nAliquota, nBaseIcms, nVlrIcms, nBaseSubs, nVlrSubs, nTotal, nTotalNota )
****************************************************************************************************
LOCAL nPvendido := 0
LOCAL nDesconto := 0
LOCAL nBaseRed  := 0
LOCAL nSoma 	 := 0
LOCAL cClasse
LOCAL nReducao
LOCAL nTaxa
LOCAL nSomaRed
LOCAL nSomaSub
LOCAL nIcms
LOCAL nSub
LOCAL nChoice
LOCAL nIcmsRed

Saidas->(Order( SAIDAS_FATURA ))
if Saidas->(DbSeek( cFatura ))
	WHILE Saidas->Fatura = cFatura
		Lista->(DbSeek( Saidas->Codigo ))
		nPvendido  := Saidas->Pvendido
		nPvendido  -= ( nPvendido * nDesconto ) / 100
		nSoma 	  := ( Saidas->Saida * nPvendido )
		nTotal	  += nSoma
		nTotalNota += nSoma
		*:----------------------------------------------------------------------------
		cClasse	:= Lista->Classe
		nReducao := Lista->Reducao
		nTaxa 	:= Lista->Tx_Icms
		nSomaRed := ( nSoma * nReducao ) / 100
		nSomaSub := ( nSoma + (( nSoma * nTaxa ) / 100 ))
		nIcmsRed := ( nSomaRed * nAliquota ) / 100
		nIcms 	:= ( nSoma * nAliquota ) / 100
		nSub		:= (( nSomaSub * nAliquota ) / 100 ) - nIcms
		Do Case
		Case cClasse = "0" // Tributado Integralmente
			nBaseIcms += nSoma
			nBaseSubs += 0
			nVlrIcms  += nIcms
			nVlrSubs  += 0
		Case cClasse = "1" // Tributado e Icms por Substituicao
			nBaseIcms  += nSoma
			nBaseSubs  += nSomaSub
			nVlrIcms   += nIcms
			nVlrSubs   += nSub
			nTotalNota += nSub
		Case cClasse = "2" // Com Reducao da Base de Calculo
			nBaseIcms += nSomaRed
			nBaseSubs += 0
			nVlrIcms  += nIcmsRed
			nVlrSubs  += 0
		Case cClasse = "3" // Isenta e Icms por Substituicao Tributaria
			nBaseIcms += 0
			nBaseSubs += nSomaSub
			nVlrIcms  += 0
			nVlrSubs  += nSub
			nTotalNota += nSub
		Case cClasse = "4" // Isenta ou nao tributada
			nBaseIcms += 0
			nBaseSubs += 0
			nVlrIcms  += 0
			nVlrSubs  += 0
		Case cClasse = "5"
		Case cClasse = "6"
		Case cClasse = "7"
		EndCase
		Saidas->(DbSkip(1))
	EndDo
endif
return

Function MacroCopia()
*********************
LOCAL GetList	:= {}
LOCAL aArray	:= { "A:", "B:", "C:", "D:", "E:", "F:" }
LOCAL cScreen	:= SaveScreen()
LOCAL cComando := Space(256)
LOCAL cOldDir	:= Curdir()
LOCAL cPath
LOCAL xDiretorio
LOCAL xString
LOCAL xDrive
LOCAL nChoice
LOCAL i

WHILE OK
	M_Title("DRIVE PARA COPIA DO ARQUIVO")
	nChoice := FazMenu( 10, 10, aArray, Cor())
	if nChoice = 0
		ResTela( cScreen )
		return( NIL )
	endif
	xDrive := aArray[nChoice]
	if nChoice = 1 .OR. nChoice = 2	// A: B:
		if !IsDisk( xDrive )
			ErrorBeep()
			Alerta("Erro: Drive invalido!")
			Loop
		endif
	endif
	ResTela( cScreen )
	return( xDrive )
EndDo

Function VerVcto( Vcto, dMemis, cMcond )
****************************************
LOCAL nVerifica2, nVerifica3, nVerifica4
LOCAL nVerifica5, nVerifica6, nVerifica7
LOCAL nVerifica8, nConta
Aadd( Vcto, dMemis + Val( Left( cMcond, 2 ) ) )
if Val( Right( cMcond, 14 ) ) = 0
	if Vcto[1] ==	dMemis
		Write( 04, 66, "A VISTA" )
		nConta := 1
	else
		Write( 04, 66, Dtoc( Vcto[ 1 ] ) )
		nConta := 1
	endif
	nVerifica2 := 0
else
	Write( 04, 66, "ABAIXO" )
	nVerifica2 := Val( SubStr( cMcond, 3, 2 ) )
	if nVerifica2 > 0
		nConta := 2
		Aadd(Vcto, dMemis + Val( SubStr( cMcond, 3, 2 ) ) )
	endif
	nVerifica3 := Val( SubStr( cMcond, 5, 2 ) )
	if nVerifica3 > 0
		nConta := 3
		Aadd(Vcto, dMemis + Val( SubStr( cMcond, 5, 2 ) ) )
	endif
	nVerifica4 := Val( SubStr( cMcond, 7, 2 ) )
	if nVerifica4 > 0
		nConta := 4
		Aadd(Vcto, dMemis + Val( SubStr( cMcond, 7, 2 ) ) )
	endif
	nVerifica5 := Val( SubStr( cMcond, 9, 2 ) )
	if nVerifica5 > 0
		nConta := 5
		Aadd(vcto, dMemis + Val( SubStr( cMcond, 9, 2 ) ) )
	endif
	nVerifica6 := Val( SubStr( cMcond, 11, 2 ) )
	if nVerifica6 > 0
		nConta := 6
		Aadd(vcto, dMemis + Val( SubStr( cMcond, 11, 2 ) ) )
	endif
	nVerifica7 := Val( SubStr( cMcond, 13, 2 ) )
	if nVerifica7 > 0
		nConta := 7
		Aadd(Vcto, dMemis + Val( SubStr( cMcond, 13, 2 ) ) )
	endif
	nVerifica8 := Val( SubStr( cMcond, 15, 2 ) )
	if nVerifica8 > 0
		nConta := 8
		Aadd(Vcto, dMemis + Val( SubStr( cMcond, 15, 2 ) ) )
	endif
endif
return nConta

Function ReducaoBase( cEsta )
*****************************
LOCAL nReducao := 0

if cEsta = "AC"
	nReducao := Lista->Ac
elseif cEsta = "AM"
	nReducao := Lista->Ac
elseif cEsta = "MT"
	nReducao := Lista->Mt
elseif cEsta = "RO"
	nReducao := Lista->Ro
elseif cEsta = "RR"
	nReducao := Lista->Rr
else
	nReducao := 0
endif
return( nReducao )

Proc Lisfim( nChoice )
**********************
LOCAL cScreen	  := SaveScreen()
LOCAL aMenu 	  := {"Retornar", "Editar", "Deletar", "Proximo", "Anterior","Localizar","Inicial", "Final", "Novo" }
LOCAL Opcao 	  := 1
LOCAL nAtivo	  := 1
LOCAL xCodigo	  := 0
LOCAL lEdicao	  := FALSO
LOCAL lAlteracao := OK

Area("Lista")
WHILE OK
	MaBox( 12, 23, 14, 47 )
	xCodigo := 0
	@ 13, 24 Say "Codigo..:" Get xCodigo Pict PIC_LISTA_CODIGO Valid CodiErrado( @xCodigo )
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		Exit
	endif
	lEdicao := FALSO
	InclusaoProdutos(lAlteracao, lEdicao)
	WHILE OK
		nOpcao := nAtivo
		Opcao  := M_Menu( nOpcao, aMenu, Cor(), 24 )
		Do Case
			Case Opcao = 0 .OR. Opcao = 1
				ResTela( cScreen )
				return
			Case Opcao = 2 // Editar
				InclusaoProdutos(lAlteracao)
			Case Opcao = 3 // Deletar
				if PodeExcluir()
					ErrorBeep()
					if Conf("Pergunta: Excluir este Registro ?")
						if Lista->(TravaReg())
							Lista->(DbDelete())
							Lista->(Libera())
							Lista->(DbSkip(1))
							InclusaoProdutos(lAlteracao, lEdicao)
						endif
					endif
				endif
			Case Opcao = 4 // Proximo
				Lista->(Order( if( nChoice = 1, 2, 3 )))
				Lista->(DbSkip(1))
				InclusaoProdutos(lAlteracao, lEdicao)
			Case Opcao = 5 // Anterior
				Lista->(Order( if( nChoice = 1, 2, 3 )))
				Lista->(DbSkip(-1))
				InclusaoProdutos(lAlteracao, lEdicao)
			Case Opcao = 6 // Localizar
				oMenu:Limpa()
				Exit
			Case Opcao = 7 // Inicial
				Lista->(Order( if( nChoice = 1, 2, 3 )))
				Lista->(DbGoTop())
				InclusaoProdutos(lAlteracao, lEdicao)
			Case Opcao = 8 // Final
				Lista->(Order( if( nChoice = 1, 2, 3 )))
				Lista->(DbGoBottom())
				InclusaoProdutos(lAlteracao, lEdicao)
			Case Opcao = 9 // Novo
				Lista->(Order( if( nChoice = 1, 2, 3 )))
				InclusaoProdutos()
		EndCase
	EndDo
EndDo
ResTela( cScreen )
return

Proc CargaDescarga( cNoFatura )
********************************
LOCAL GetList		 := {}
LOCAL cScreen		 := SaveScreen()
LOCAL Tam			 := 132
LOCAL aFatuTemp	 := {}
LOCAL aFatura		 := {}
LOCAL aRegis		 := {}
LOCAL aRegiTemp	 := {}
LOCAL aCarga		 := {}
LOCAL aDesCarga	 := {}
LOCAL nTamanho 	 := 0
LOCAL nDesconto	 := 0
LOCAL nRow			 := 0
LOCAL nItens		 := 0
LOCAL nLen			 := 0
LOCAL cForma		 := ""
LOCAL cCodi 		 := ""
LOCAL cCodiDes 	 := ""
LOCAL cFatura		 := Space(07)
LOCAL cDescarga	 := Space(07)
LOCAL cTela

oMenu:Limpa()
MaBox(10, 10, 13, 40)
@ 11, 11 Say "Fatura Carga.....:" Get cFatura   Pict "@!" Valid VisualAchaFatura( @cFatura )
@ 12, 11 Say "Fatura DesCarga..:" Get cDescarga Pict "@!" Valid VisualAchaFatura( @cDescarga )
Read
if LastKey() = ESC
	ResTela( cScreen )
	return
endif
oMenu:Limpa()
ErrorBeep()
if Conf("Pergunta: Imprimir Relacao Carga/Descarga ?" )
	Cep->(Order( CEP_CEP ))
	Receber->(Order( RECEBER_CODI ))
	Lista->(Order( LISTA_CODIGO ))
	Saidas->(Order( SAIDAS_FATURA ))
	cTela 	 := SaveScreen()
	Mensagem("Aguarde, Localizando Movimento.", Cor())
	nRow	  := 11
	bBloco  := {|| Saidas->Fatura = cFatura }
	cBloco  := {|| Saidas->Fatura = cDescarga }
	if Saidas->(DbSeek( cFatura ))
		cForma	:= Saidas->Forma
		cCodi 	:= Saidas->Codi
		dEmis 	:= Saidas->Emis
		nVlr		:= 0
		nItens	:= 0
		aCarga	:= {}
		Receber->(DbSeek( Saidas->Codi ))
		Cep->(DbSeek( Receber->Cep ))
		WHILE Saidas->(EVal( bBloco )) .AND. Rel_Ok()
			nVlr := Saidas->Pvendido
			Lista->(DbSeek( Saidas->Codigo ))
			Aadd( aCarga, { Saidas->Saida, Lista->Un, Lista->Codigo, Lista->(Left( Descricao, 34 )), Lista->Sigla, nVlr, ( Saidas->Saida * nVlr )})
			Saidas->(DbSkip(1))
		EndDo
	endif
	if Saidas->(DbSeek( cDescarga ))
		cFormaDes	 := Saidas->Forma
		cCodiDes 	 := Saidas->Codi
		dEmisDes 	 := Saidas->Emis
		nItens		 := 0
		nVlr			 := 0
		aDesCarga	 := {}
		Receber->(DbSeek( Saidas->Codi ))
		Cep->(DbSeek( Receber->Cep ))
		WHILE Saidas->(EVal( cBloco )) .AND. Rel_Ok()
			nVlr := Saidas->Pvendido
			Lista->(DbSeek( Saidas->Codigo ))
			Aadd( aDesCarga, { Saidas->Saida, Lista->Un, Lista->Codigo, Lista->(Left( Descricao, 34 )), Lista->Sigla, nVlr, ( Saidas->Saida * nVlr )})
			Saidas->(DbSkip(1))
		EndDo
	endif
	Asort( aCarga,,, {|x, y| y[4] > x[4]} ) // Ordenar Por Descricao
	nItens  := 0
	Pagina  := 1
	nLen	  := Len( aCarga )
	nLenDes := Len( aDescarga )
	if !Instru80()
		ResTela( cScreen )
		return
	endif
	Mensagem("Aguarde, Imprimindo.", Cor())
	PrintOn()
	FPrint( PQ )
	nQuantCarga := 0
	nQuantDesca := 0
	nQuantSaldo := 0
	nTotalCarga := 0
	nTotalDesca := 0
	nSaldoSaldo := 0
	For nT := 1 To nLen
		if nItens = 0
			FrontCargaDes(cFatura, cDescarga, dEmis, dEmisDes, cForma, cFormaDes, cCodi, cCodiDes )
		endif
		nQuant	 := 0
		nUnitario := 0
		nTot		 := 0
		nPos		 :=0
		if nLenDes != 0
			cCodigo	 := aCarga[nT,3]
			nPos		 := Ascan( aDesCarga, {|aVal|Aval[3] == cCodigo })
			if nPos != 0
				nQuant	 := aDesCarga[nPos, 1 ]
				nUnitario := aDesCarga[nPos, 6 ]
				nTot		 := aDesCarga[nPos, 7 ]
			endif
		endif
		Qout( aCarga[nT, 3],;
				aCarga[nT, 2],;
				aCarga[nT, 4],;
				Tran( aCarga[nT, 1], 		"999999.99"),;
				Tran( nQuant,					"999999.99"),;
				Space(2),;
				Tran( aCarga[nT,1]-nQuant, "999999.99"),;
				Tran( aCarga[nT, 6], 		"@E 999,999.99"),;
				Tran( nUnitario,				"@E 999,999.99"),;
				Tran( aCarga[nT, 7], 		"@E 999,999.99"),;
				Tran( nTot, 					"@E 999,999.99"),;
				Tran( aCarga[nT,7]-nTot,	"@E 999,999.99"))

		nQuantCarga += aCarga[nT,1]
		nQuantDesca += nQuant
		nQuantSaldo += aCarga[nT,1] - nQuant
		nTotalCarga += aCarga[nT,7]
		nTotalDesca += nTot
		nSaldoSaldo += aCarga[nT,7] - nTot
		nItens++
		nRow++
		if nItens = 49
			Pagina++
			nRow	 := 11
			nItens := 0
		  __Eject()
		endif
	Next
	Qout(Repl( SEP, Tam ))
	Qout( "** TOTAIS **",;
			Space(31),;
			Tran( nQuantCarga,		 "999999.99"),;
			Tran( nQuantDesca,		 "999999.99"),;
			Space(2),;
			Tran( nQuantSaldo,		 "999999.99"),;
			Space(21),;
			Tran( nTotalCarga,		 "@E 999,999.99"),;
			Tran( nTotalDesca,		 "@E 999,999.99"),;
			Tran( nSaldoSaldo,		 "@E 999,999.99"))
	Qout(Repl( SEP, Tam ))
	__Eject()
	PrintOff()
	ResTela( cTela )
endif
ResTela( cScreen )
return

Proc FrontCargaDes(cFatura, cDescarga, dEmis, dEmisDes, cForma, cFormaDes, cCodi, cCodiDes )
********************************************************************************************
LOCAL Tam := 132
SetPrc( 0, 0)
Write( 00, 00 , Padc("RELATORIO DE CARGA E DESCARGA", Tam))
Write( 01, 00 , Repl( SEP, Tam ) )
Write( 02, 00 , "Emissao....: " + Dtoc( dEmis ))
Write( 02, 66 , "Emissao....: " + Dtoc( dEmisDes ))
Write( 03, 00 , "Fatura N§..: " + cFatura )
Write( 03, 66 , "Fatura N§..: " + cDescarga )
Forma->(Order( FORMA_FORMA))
Forma->(DbSeek( cForma ))
Write( 04, 00 , "F. Pagto...: " + Forma->Forma + "  " + Forma->Condicoes )
Forma->(DbSeek( cFormaDes ))
Write( 04, 66 , "F. Pagto...: " + Forma->Forma + "  " + Forma->Condicoes )
Receber->(DbSeek( cCodi ))
Write( 05, 00 , "Cliente....: " + Receber->Codi  + " " + Receber->Nome )
Receber->(DbSeek( cCodiDes ))
Write( 05, 66 , "Cliente....: " + Receber->Codi  + " " + Receber->Nome )
Receber->(DbSeek( cCodi ))
Write( 06, 00 , "Fantasia...: " + Receber->Fanta )
Receber->(DbSeek( cCodiDes ))
Write( 06, 66 , "Fantasia...: " + Receber->Fanta )
Write( 07, 00 , Repl( SEP, Tam ) )
Write( 08, 00 , "                                                 CARGA  DESCARGA                   CARGA   DESCARGA      CARGA   DESCARGA      SALDO")
Write( 09, 00 ,"CODIGO UN DESCRICAO DO PRODUTO                   QUANT     QUANT        SALDO   UNITARIO   UNITARIO      TOTAL      TOTAL      TOTAL")
Write( 10, 00 , Repl( SEP, Tam ))
return
s