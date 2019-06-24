/*
  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
 Ý³																								 ?
 Ý³	Programa.....: RECELAN.PRG 														 ?
 Ý³	Aplicacaoo...: SISTEMA DE CONTAS A RECEBER									 ?
 Ý³   Versao.......: 3.3.00                                                 ?
 Ý³	Programador..: Vilmar Catafesta													 ?
 Ý³	Empresa......: Microbras Com de Prod de Informatica Ltda 				 ?
 Ý³	Inicio.......: 12 de Novembro de 1991. 										 ?
 Ý³	Ult.Atual....: 03 de Agosto de 2003.											 ?
 Ý³	Compilacao...: Clipper 5.02														 ?
 Ý³	Linker.......: Blinker 5.10														 ?
 Ý³	Bibliotecas..: Clipper/Funcoes/Mouse/Funcky15/Funcky50/Classe/Classic ?
 ÝÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#include <sci.ch>

function Recelan()
*-----------------*
LOCAL Op          := 1
LOCAL lOk			:= OK
PUBLI cVendedor   := Space(40)
PUBLI cCaixa		:= Space(04)

*:=======================================================================================================
AbreArea()
oMenu:Limpa()
if !VerSenha( @cCaixa, @cVendedor )
	Mensagem("Aguarde, Fechando Arquivos." )
	DbCloseAll()
	Set KEY F2 TO
	Set KEY F3 TO
	return
endif
*:=======================================================================================================
SetKey( -4, 		  {|| ClientesDbEdit() })
SetKey( -7, 		  {|| AcionaSpooler()})
SetKey( 23, 		  {|| GravaDisco()})
//SetKey( F2,         {|| BaixasRece( cCaixa, cVendedor )})
SetKey( TECLA_ALTC, {|| Altc()})
oMenu:Limpa()
*:=======================================================================================================
Op := 1
RefreshClasse()
WHILE lOk
	BEGIN Sequence
		Op := oMenu:Show()
		oAmbiente:cTipoRecibo := "RECCAR"
		Do Case
		Case Op = 0.0 .OR. Op = 1.01
			ErrorBeep()
			if Conf("Pergunta: Encerrar este modulo ?")
            oMenu:nPos := 1
				GravaDisco()
				lOk := FALSO
				Break
			endif
		Case op = 2.01 ; CliInclusao()
		Case op = 2.02 ; CliAltera()
		Case op = 2.03 ; CliAltera()
		Case op = 2.04 ; CliAltera()
		Case op = 2.05 ; ClientesFiltro()
		Case op = 2.06 ; ClientesDbedit()
		Case op = 2.07 ; MarDesmarcaCliente()
		Case op = 2.08 ; AnexarAgendaAntiga()
		Case op = 2.09 ; AnexarLogRecibo()
      Case op = 2.10 ; BidoToRecibo()
      Case op = 2.11 ; FoneTroca()
		Case op = 3.01 ; AlteraReceber()
		Case op = 3.02 ; AlteraRecebido()
      Case op = 3.03 ; MenuTxJuros(op)
      Case op = 3.04 ; MenuTxJuros(op)
		Case op = 3.05 ; AltRegTitRec()
		Case op = 3.06 ; AltRegTitPag()
		Case op = 3.07 ; ReajTitulos()
		Case op = 3.08 ; RemoveCobranca()
		Case op = 3.09 ; RemoveAgenda()
		Case op = 3.10 ; AltRegCfop()
		Case op = 3.11 ; TrocaCliente(cCaixa)
		Case op = 3.12 ; TrocaCobAgenda()
		Case op = 3.13 ; AgendaDbedit()
		Case op = 3.14 ; RecemovDbeditEmTabela(nil)      
		Case op = 4.01 ; Lancamentos(cCaixa)
		Case op = 4.02 ; iif(PodeReceber(), BaixasRece( cCaixa, cVendedor ), NIL)
		Case op = 4.03 ; Exclusao()
		Case op = 4.04 ; FechtoMes()
		Case op = 4.05 ; AgeCobranca()
		Case op = 4.06 ; ImpExpGetDados()
		Case op = 4.07 ; CancelaContrato()
		Case op = 4.08 ; LancaDespesasDiversas(cCaixa, cVendedor, 'RECIBO')
		Case op = 4.09 ; ReciboDiv( cCaixa, cVendedor )
		Case op = 5.01 ; RelCli()
		Case op = 5.02 ; RelReceber()
		Case op = 5.03 ; RelRecebido()
		Case op = 5.04 ; EtiquetasClientes()
		Case op = 5.05 ; CobTitulo()
		Case op = 5.06 ; Extrato()
      Case op = 5.07 ; MenuDuplicata()
      Case op = 5.08 ; DiretaLivre()
      Case op = 5.09 ; MenuPromissoria()
      Case op = 5.10	; ReciboRegiao()
      Case op = 5.11 ; ReciboIndividual(cCaixa, cVendedor)
      Case op = 5.12 ; ReciboDiv( cCaixa, cVendedor )
      Case op = 5.13 ; Carta( FALSO )
      Case op = 5.14 ; CarnePag()
      Case op = 5.15 ; CarneCaixa()
      Case op = 5.16 ; CarneRec()
      Case op = 5.17 ; CartaSpc()
      Case op = 5.18 ; PrnDiversos(NIL,NIL,NIL, cVendedor)
      Case op = 5.19 ; FichaAtendimento( cCaixa, cVendedor )
      Case Op = 6.01 ; NewPosiReceber(1 , NIL , cCaixa )
		Case Op = 6.02 ; NewPosiReceber(2 , NIL , cCaixa )
		Case Op = 6.03 ; NewPosiReceber(3 , NIL , cCaixa )
      Case Op = 6.04 ; NewPosiReceber(4 , NIL , cCaixa )
      Case Op = 6.05 ; NewPosiReceber(5 , NIL , cCaixa )
      Case Op = 6.06 ; NewPosiReceber(6 , NIL , cCaixa )
		Case Op = 6.07 ; NewPosiReceber(1 , NIL , cCaixa, OK )      
		Case Op = 6.08 
		   oAmbiente:cTipoRecibo := "RECBCO"
			NewPosiReceber( 1, NIL, cCaixa )
			oAmbiente:cTipoRecibo := "RECCAR"
		Case Op = 6.09 
		   oAmbiente:cTipoRecibo := "RECOUT"
			NewPosiReceber( 1, NIL, cCaixa )
			oAmbiente:cTipoRecibo := "RECCAR"
		Case Op = 6.11 ; NewPosiReceber(3 , NIL , cCaixa, NIL , NIL , (oAmbiente:cTipoRecibo := "RECCAR"))
      Case Op = 6.12 ; NewPosiReceber(3 , NIL , cCaixa, NIL , NIL , (oAmbiente:cTipoRecibo := "RECBCO"))
      Case Op = 6.13 ; NewPosiReceber(3 , NIL , cCaixa, NIL , NIL , (oAmbiente:cTipoRecibo := "RECOUT"))
		Case Op = 6.14 ; NewPosiReceber(3 , NIL , cCaixa, NIL , NIL , (oAmbiente:cTipoRecibo := "RECALL"))
      Case Op = 6.16 ; ReceGrafico()
      Case Op = 6.18 ; NewPosiAgeInd()
      Case Op = 6.19 ; NewPosiAgeReg()
      Case Op = 6.20 ; NewPosiAgeAll()
		Case Op = 6.21
      Case Op = 6.22 ; SuporteIni()
      Case Op = 6.23 ; SuporteRecibo()
		Case Op = 6.24
		Case Op = 6.25 ; NewGraficoReceberDevedores(08)
		Case Op = 6.26 ; NewGraficoReceberDevedores(09)
		Case Op = 6.27 ; NewGraficoReceberDevedores(10)

		Case Op = 7.01 ; NewPosiReceber(1 , NIL , cCaixa, NIL , NIL , NIL , NIL , (oAmbiente:lRecepago := OK ))
      Case Op = 7.02 ; NewPosiReceber(2 , NIL , cCaixa, NIL , NIL , NIL , NIL , (oAmbiente:lRecepago := OK ))
      Case Op = 7.03 ; NewPosiReceber(3 , NIL , cCaixa, NIL , NIL , NIL , NIL , (oAmbiente:lRecepago := OK ))
      Case Op = 7.04 ; NewPosiReceber(4 , NIL , cCaixa, NIL , NIL , NIL , NIL , (oAmbiente:lRecepago := OK ))
      Case Op = 7.05 ; NewPosiReceber(5 , NIL , cCaixa, NIL , NIL , NIL , NIL , (oAmbiente:lRecepago := OK ))
      Case Op = 7.06 ; NewPosiReceber(6 , NIL , cCaixa, NIL , NIL , NIL , NIL , (oAmbiente:lRecepago := OK ))
      Case Op = 7.05
		Case Op = 7.08 ; BidoGrafico(RECCAR)
      Case Op = 7.09 ; BidoGrafico(RECBCO)
      Case Op = 7.10 ; BidoGrafico(RECOUT)
      Case Op = 7.11 ; BidoGrafico(RECGER)
		Case Op = 7.12
		Case Op = 7.13 ; BidoGrafico(PAGDIA)
		Case Op = 7.14 ; BidoGrafico(PAGDIV)		
		Case Op = 7.15
      Case Op = 7.16 ; NewPosiAgeInd()
      Case Op = 7.17 ; NewPosiAgeReg()
      Case Op = 7.18 ; NewPosiAgeAll()
		Case Op = 7.19
      Case Op = 7.20 ; SuporteIni()
      Case Op = 7.21 ; SuporteRecibo()

		
      Case op = 8.01 ; RegiaoInclusao()
      Case op = 8.02 ; RegiaoConsulta()
      Case op = 8.03 ; RegiaoConsulta()
      Case op = 8.04 ; RegiaoConsulta()

      Case op = 9.01 ; CepInclusao()
      Case op = 9.02 ; MudaCep()
      Case op = 9.03 ; MudaCep()
      Case op = 9.04 ; MudaCep()
      Case op = 9.05 ; CepPrint()

      Case op = 10.01 ; LogConsulta()
      Case op = 10.02 ; ReciboDbedit()
		Case op = 10.03 ; AjustaReciboRecemov()
		Case op = 10.04 ; AjustaRecebidoParaReciboPorFatura()
		Case op = 10.05 ; AjustaRecebidoParaReciboGeral()

      Case op = 11.01 ; CmInclusao()
      Case op = 11.02 ; CmDbEdit()
      Case op = 11.03 ; CmDbEdit()
      Case op = 11.04 ; CmDbEdit()
      Case op = 11.05 ; CmDbEdit()
      
      Case op = 12.01 ; AgeCobranca()
      Case op = 12.02 ; AgendaDbedit()
      Case op = 12.03 ; AgendaDbedit()
      Case op = 12.04 ; AgendaDbedit()
      Case op = 12.05 ; AgendaDbedit()
      Case Op = 12.07 ; NewPosiAgeInd()
      Case Op = 12.08 ; NewPosiAgeReg()
      Case Op = 12.09 ; NewPosiAgeAll()
		EndCase
	End Sequence
EndDo
Mensagem("Aguarde, Fechando Arquivos." )
FechaTudo()
Set KEY F2 TO
Set KEY F3 TO
return nil

function oMenuRecelan()
*----------------------*
LOCAL AtPrompt := {}
LOCAL cStr_Suporte
LOCAL cStr_Recibo

if !aPermissao[SCI_CONTAS_A_RECEBER]
	return( AtPrompt )
endif

if oAmbiente:Mostrar_Desativados
	cStr_Suporte := "Desativar Consulta Clientes Inativos"
else
	cStr_Suporte := "Ativar Consulta Clientes Inativos"
endif
if oAmbiente:Mostrar_Recibo
	cStr_Recibo := "Desativar Checagem de Recibos"
else
	cStr_Recibo := "Ativar Checagem de Recibos"
endif
AADD( AtPrompt, {"S^air",        {"Encerrar Sessao"}})
AADD( AtPrompt, {"C^lientes",     {"Inclusao",;
                                  "Alteracao",;
										    "Exclusao",;
											 "Consulta",;
											 "Consulta por Filtro",;
											 "Pesq/Altera Todos",;
											 "Marcar/Desmarcar Cliente",;
											 "Anexar Agenda Antiga",;
                                  "Anexar Arquivo RECIBO.LOG",;
                                  "Recebido To Recibo",;
                                  "Ajustar Campo Telefone"}})

AADD( AtPrompt, {"A^lteracao",      {"Titulos a Receber",;
											 "Titulos Recebidos",;
											 "Taxa de Juro Geral",;
											 "Taxa de Juro Individual",;
											 "Regiao de Titulos a Receber",;
											 "Regiao de Titulos Recebidos",;
											 "Reajuste de Titulos",;
											 "Remover Comissao Cobrador",;
                                  'Remover Agendamento',;
											 "Cfop por Regiao",;
											 "Cliente de Fatura",;
											 "Cobrador do Agendamento",;
											 "Agendamento",;
											 "Titulos em Tabela"}})

AADD( AtPrompt, {"L^ancamentos", {"Titulos a Receber",;
											"Baixa de Recebimentos",;
											"Exclusao de Titulo",;
											"Fechamento Periodico",;
											"Agendamento de Cobranca",;
											'Imp/Exportacao Dados Externos',;
											'Cancelamento Contrato',;
											'Despesas Diversas',;
											"Recibo/Vale Diversos";
											}})

AADD( AtPrompt, {"I^mpressao",   {"Ficha/Relacao de Clientes",;
                                  "Titulos a Receber",;
                                  "Titulos Recebidos",;
                                  "Etiquetas Clientes",;
                                  "Carta Cobranca Titulos",;
                                  "Extrato de Conta",;
                                  "Duplicata",;
                                  "Boleto Bancario",;
                                  "Promissoria",;
                                  "Recibo Por Regiao",;
                                  "Recibo Individual",;
                                  "Recibo/Vale Diversos",;
                                  "Mala Direta",;
                                  "Carne de Pagamento",;
                                  "Carne de Pagamento Caixa",;
                                  "Carne de Recebimento",;
                                  "Negativar Clientes no Spc",;
                                  "Documentos Diveros",;
                                  "Ficha Atendimento/Ativacao"}})

AADD( AtPrompt, {"R^eceber",     {"Consulta/Recibo Por C^liente",;
                                  "Consulta/Recibo Por R^egiao",;
                                  "Consulta/Recibo Por P^eriodo",;
                                  "Consulta/Recibo Por T^ipo",;
                                  "Consulta/Recibo Por F^atura",;
                                  "Consulta/Recibo G^eral",;
                                  "Consulta/Recibo Para Re^scisao",;
											 "Consulta/Recibo B^anco",;
											 "Consulta/Recibo O^utros",;
                                  "",;
											 "Consulta Recebido C^arteira",;
                                  "Consulta Recebido B^anco",;
                                  "Consulta Recebido O^utros",;
											 "Consulta Recebido G^eral",;
                                  "",;
                                  "G^rafico de Contas a Receber",;
                                  "",;
                                  "Agendamento I^ndividual",;
                                  "Agendamento por Regiao",;
                                  "Agendamento por Periodo",;
											 "",;
                                  cStr_Suporte,;
                                  cStr_Recibo,;
											 "",;
											"Consulta Maiores Devedores Ativos",;
											"Consulta Maiores Devedores Inativos",;
											"Consulta Maiores Devedores"}})

AADD( AtPrompt, {"R^ecebido",    {"Recebido Por Cliente",;
                                  "Recebido por Regiao",;
											 "Recebido Por Periodo",;
											 "Recebido Por Tipo",;											 
                                  "Recebido for Fatura",;
                                  "Recebido Geral",;
                                  "",;
                                  "Grafico de Contas Recebidas em Carteira",;
                                  "Grafico de Contas Recebidas em Banco",;
                                  "Grafico de Contas Recebidas em Outros",;
                                  "Grafico de Contas Recebidas Geral",;											 
                                  "",;
											 "Grafico de Diarias Pagas",;
											 "Grafico de Pagamentos diverso",;
											  "",;
                                  "Consulta Agendamento individual",;
                                  "Consulta Agendamento por regiao",;
                                  "Consulta Agendamento por periodo",;
                                  "",;											 
                                  cStr_Suporte,;
                                  cStr_Recibo }})
Aadd( AtPrompt, {"R^egiao",      {"Inclusao",;
                                  "Alteracao",;
                                  "Exclusao",;
                                  "Consulta"}})
Aadd( AtPrompt, {"C^ep",         {"Inclusao",;
                                  "Alteracao",;
                                  "Exclusao",;
                                  "Consulta",;
                                  "Impressao"}})
Aadd( AtPrompt, {"R^ecibo",      {"Consulta Log",;
                                  "Em tabela",;
											 "Ajustar Recibo->Recemov",;
											 "Ajustar Recebido->Recibo por Fatura",;
											 "Ajustar Recebido->Recibo Geral"}})
Aadd( AtPrompt, {"C^m",          {"Inclusao",;
                                  "Alteracao",;
                                  "Exclusao",;
                                  "Consulta",;
                                  "Em tabela"}})
Aadd( AtPrompt, {"A^gendamento", {"Inclusao",;
                                  "Alteracao",;
                                  "Exclusao",;
                                  "Consulta",;
                                  "Em tabela",;
                                  "",;
                                  "Consulta individual",;
                                  "Consulta por regiao",;
                                  "Consulta por periodo"}})
return( AtPrompt )

function aDispRecelan()
*---------------------*
	LOCAL oRecelan := TIniNew(oAmbiente:xUsuario + ".INI")
	LOCAL AtPrompt := oMenuRecelan()
	LOCAL nMenuH   := Len(AtPrompt)
	LOCAL aDisp 	:= Array( nMenuH, 27 )
	LOCAL aMenuV   := {}

	Mensagem("Aguarde, Verificando Diretivas do CONTAS A RECEBER.")
	aDisp := ReadIni("recelan", nMenuH, aMenuV, AtPrompt, aDisp, oRecelan)
	oRecelan:Close()
	return aDisp

static function LogConsulta()
*----------------------------*

	LOCAL cFile := "recibo.log"
	oMenu:Limpa()
	
	if file( cFile )
		M_Title("LOG DOS RECIBOS EMITIDOS")
		M_View( 00, 00, LastRow(), LastCol(), cFile,  Cor())
	else
		ErrorBeep()
		alerta("Erro: Arquivo " + cFile + " nao localizado.", Cor())
	endif

static function RefreshClasse()
*------------------------------*
	oMenu:StatusSup := oMenu:StSupArray[CONTAS_A_RECEBER]
	oMenu:StatusInf := oMenu:StInfArray[CONTAS_A_RECEBER]
	oMenu:Menu		 := oMenu:MenuArray[CONTAS_A_RECEBER]
	oMenu:Disp		 := oMenu:DispArray[CONTAS_A_RECEBER]
	return nil

static function SuporteRecibo()
*-----------------------------*
	LOCAL lMostrar := oAmbiente:Mostrar_Recibo

	oAmbiente:Mostrar_Recibo := !lMostrar
	oIni:WriteBool('sistema', 'Mostrar_Recibo', !lMostrar )
	Alerta("Info: Consulta Recibo foi "+ if(!lMostrar,"LIGADO","DESLIGADO"))
	oMenu:Menu := oMenuRecelan()
	return nil


static function SuporteIni()
*--------------------------*
	LOCAL lMostrar := oAmbiente:Mostrar_Desativados AS LOGICAL
   
	oAmbiente:Mostrar_Desativados := !lMostrar
	oIni:WriteBool('sistema', 'Mostrar_Desativados', !lMostrar )
	Alerta("Info: Consulta dos Clientes Desativados foi "+ if(!lMostrar,"LIGADO","DESLIGADO"))
	oMenu:Menu := oMenuRecelan()	
	return nil
	
function CliInclusao( lAlteracao )
**********************************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen()
LOCAL nKey		  := SetKey( F9 )
LOCAL lModificar := FALSO
LOCAL cPraca	  := XCCEP
LOCAL cCep		  := XCCEP
LOCAL aNatu 	  := {}
LOCAL aCfop 	  := {}
LOCAL aTxIcms	  := {}
LOCAL cSwap
LOCAL cCodi
LOCAL cString
LOCAL cNome
LOCAL cFanta
LOCAL cCgc
LOCAL cInsc
LOCAL cEnde
LOCAL cBair
LOCAL cCivil
LOCAL cCida
LOCAL cEsta
LOCAL cNatural
LOCAL cRg
LOCAL cCpf
LOCAL cEsposa
LOCAL cResp
LOCAL cEnde2
LOCAL cEnde3
LOCAL cPai
LOCAL cMae
LOCAL cEnde1
LOCAL cFone
LOCAL cFax
LOCAL cFone1
LOCAL cProf
LOCAL cCargo
LOCAL cTraba
LOCAL cFone2
LOCAL cTempo
LOCAL cRefCom
LOCAL cRefBco
LOCAL cImovel
LOCAL cVeiculo
LOCAL cConhecida
LOCAL cObs
LOCAL cObs1
LOCAL cObs2
LOCAL cObs3
LOCAL cObs4
LOCAL cObs5
LOCAL cObs6
LOCAL cObs7
LOCAL cObs8
LOCAL cObs9
LOCAL cObs10
LOCAL cObs11
LOCAL cObs12
LOCAL cObs13
LOCAL cRegiao
LOCAL dNasc
LOCAL dData
LOCAL nDepe
LOCAL nRenda
LOCAL nLimite
LOCAL nMedia
LOCAL cSpc
LOCAL dDataSpc
LOCAL cBanco
LOCAL cCancelada
LOCAL cSuporte
LOCAL cSci
LOCAL cAutorizaca
LOCAL cAssAutoriz
LOCAL cCidaAval
LOCAL cEstaAval
LOCAL cBairAval
LOCAL cFoneAval
LOCAL cFaxAval
LOCAL cRgAval
LOCAL cCpfAval
LOCAL cCFop
LOCAL nIcms
LOCAL cNatu
LOCAL lUpdated     := FALSO
STATI lAtivaRegNew := FALSO

SetKey( F4, {|| AtivaRegNew( @lAtivaRegNew )})
if lAlteracao != NIL .AND. lAlteracao
	lModificar := OK
	if !PodeAlterar()
		SetKey( F4, NIL )
		ResTela( cScreen )
		Return
	endif
endif

if !lModificar
	if !PodeIncluir()
		SetKey( F4, NIL )
		Restela( cScreen )
		Return
	endif
endif
Set Key F9 To
Area("Receber")
Order( RECEBER_CODI )
WHILE OK
	oMenu:Limpa()
	cNome 		:= IF( lModificar, Receber->Nome,		  Space( Len( Receber->Nome 	  )))
	cFanta		:= IF( lModificar, Receber->Fanta,		  Space( Len( Receber->Fanta	  )))
	cCgc			:= IF( lModificar, Receber->Cgc, 		  Space( Len( Receber->Cgc		  )))
	cInsc 		:= IF( lModificar, Receber->Insc,		  Space( Len( Receber->Insc 	  )))
	cEnde 		:= IF( lModificar, Receber->Ende,		  Space( Len( Receber->Ende 	  )))
	cBair 		:= IF( lModificar, Receber->Bair,		  Space( Len( Receber->Bair 	  )))
	cCivil		:= IF( lModificar, Receber->Civil,		  Space( Len( Receber->Civil	  )))
	cCida 		:= IF( lModificar, Receber->Cida,		  Space( Len( Receber->Cida 	  )))
	cEsta 		:= IF( lModificar, Receber->Esta,		  Space( Len( Receber->Esta 	  )))
	cNatural 	:= IF( lModificar, Receber->Natural,	  Space( Len( Receber->Natural  )))
	cRg			:= IF( lModificar, Receber->Rg,			  Space( Len( Receber->Rg		  )))
	cCpf			:= IF( lModificar, Receber->Cpf, 		  Space( Len( Receber->Cpf	     )))
	cEsposa		:= IF( lModificar, Receber->Esposa, 	  Space( Len( Receber->Esposa	  )))
	cEnde3		:= IF( lModificar, Receber->Ende3,		  Space( Len( Receber->Ende3	  )))
	cPai			:= IF( lModificar, Receber->Pai, 		  Space( Len( Receber->Pai		  )))
	cMae			:= IF( lModificar, Receber->Mae, 		  Space( Len( Receber->Mae		  )))
	cEnde1		:= IF( lModificar, Receber->Ende1,		  Space( Len( Receber->Ende1	  )))
	cFone 		:= IF( lModificar, Receber->Fone,		  Space( Len( Receber->Fone 	  )))
	cFax			:= IF( lModificar, Receber->Fax, 		  Space( Len( Receber->Fax		  )))
	cFone1		:= IF( lModificar, Receber->Fone1,		  Space( Len( Receber->Fone1	  )))
	cProf 		:= IF( lModificar, Receber->Profissao,   Space( Len( Receber->Profissao)))
	cCargo		:= IF( lModificar, Receber->Cargo,		  Space( Len( Receber->Cargo	  )))
	cTraba		:= IF( lModificar, Receber->Trabalho,	  Space( Len( Receber->Trabalho )))
	cFone2		:= IF( lModificar, Receber->Fone,		  Space( Len( Receber->Fone 	  )))
	cTempo		:= IF( lModificar, Receber->Tempo,		  Space( Len( Receber->Tempo	  )))
	cRefCom		:= IF( lModificar, Receber->RefCom, 	  Space( Len( Receber->RefCom	  )))
	cRefBco		:= IF( lModificar, Receber->RefBco, 	  Space( Len( Receber->RefBco	  )))
	cImovel		:= IF( lModificar, Receber->Imovel, 	  Space( Len( Receber->Imovel	  )))
	cVeiculo 	:= IF( lModificar, Receber->Veiculo,	  Space( Len( Receber->Veiculo   )))
	cConhecida	:= IF( lModificar, Receber->Conhecida,   Space( Len( Receber->Conhecida )))
	cObs			:= IF( lModificar, Receber->Obs, 		  Space( Len( Receber->Obs	   )))
	cObs1 		:= IF( lModificar, Receber->Obs1,		  Space( Len( Receber->Obs1   )))
	cObs2 		:= IF( lModificar, Receber->Obs2,		  Space( Len( Receber->Obs2   )))
	cObs3 		:= IF( lModificar, Receber->Obs3,		  Space( Len( Receber->Obs3   )))
	cObs4 		:= IF( lModificar, Receber->Obs4,		  Space( Len( Receber->Obs4   )))
	cObs5 		:= IF( lModificar, Receber->Obs5,		  Space( Len( Receber->Obs5   )))
	cObs6 		:= IF( lModificar, Receber->Obs6,		  Space( Len( Receber->Obs6   )))
	cObs7 		:= IF( lModificar, Receber->Obs7,		  Space( Len( Receber->Obs7   )))
	cObs8 		:= IF( lModificar, Receber->Obs8,		  Space( Len( Receber->Obs8   )))
	cObs9 		:= IF( lModificar, Receber->Obs9,		  Space( Len( Receber->Obs9   )))
	cObs10		:= IF( lModificar, Receber->Obs10,		  Space( Len( Receber->Obs10  )))
	cObs11		:= IF( lModificar, Receber->Obs11,		  Space( Len( Receber->Obs11  )))
	cObs12		:= IF( lModificar, Receber->Obs12,		  Space( Len( Receber->Obs12  )))
	cObs13		:= IF( lModificar, Receber->Obs13,		  Space( Len( Receber->Obs13  )))
	cRegiao		:= IF( lModificar, Receber->Regiao, 	  Space( Len( Receber->Regiao )))
	cBanco		:= IF( lModificar, Receber->Banco,		  Space( Len( Receber->Banco  )))
	dNasc 		:= IF( lModificar, Receber->Nasc,		  Ctod("//"))
	dData 		:= IF( lModificar, Receber->Data,		  Date())
	nDepe 		:= IF( lModificar, Receber->Depe,		  0 )
	nRenda		:= IF( lModificar, Receber->Media,		  0)
	nLimite		:= IF( lModificar, Receber->Limite, 	  0)
	nMedia		:= IF( lModificar, Receber->Media,		  0)
	cSpc			:= IF( lModificar, IF( Receber->Spc = OK, "S", "N"), "N")
	dDataSpc 	:= IF( lModificar, Receber->DataSpc,  Ctod("//"))
	cCancelada	:= IF( lModificar, IF( Receber->Cancelada = OK, "S", "N"), "N")
	cSuporte 	:= IF( lModificar, IF( Receber->Suporte	= OK, "S", "N"), "S")
	cSci			:= IF( lModificar, IF( Receber->Sci 		= OK, "S", "N"), "N")
	cFabricante := IF( lModificar, Receber->Fabricante,		Space( Len( Receber->Fabricante )))
	cProduto 	:= IF( lModificar, Receber->Produto,			Space( Len( Receber->Produto	  )))
	cModelo		:= IF( lModificar, Receber->Modelo, 			Space( Len( Receber->Modelo 	  )))
	cLocal		:= IF( lModificar, Receber->Local,				Space( Len( Receber->Local		  )))
	nValor		:= IF( lModificar, Receber->Valor,				0 )
	nPrazo		:= IF( lModificar, Receber->Prazo,				0 )
	nDataVcto	:= IF( lModificar, Receber->DataVcto,			0 )
	nPrazoExt	:= IF( lModificar, Receber->PrazoExt,			0 )
	cAutorizaca := IF( lModificar, IF( Receber->Autorizaca = OK, "S", "N"), "N")
	cAssAutoriz := IF( lModificar, IF( Receber->AssAutoriz = OK, "S", "N"), "N")
	cCidaAval	:= IF( lModificar, Receber->CidaAval,			Space( Len( Receber->CidaAval	)))
	cEstaAval	:= IF( lModificar, Receber->EstaAval,			Space( Len( Receber->EstaAval	)))
	cBairAval	:= IF( lModificar, Receber->BairAval,			Space( Len( Receber->BairAval	)))
	cFoneAval	:= IF( lModificar, Receber->FoneAval,			Space( Len( Receber->FoneAval	)))
	cFaxAval 	:= IF( lModificar, Receber->FaxAval,			Space( Len( Receber->FaxAval	)))
	cRgAval		:= IF( lModificar, Receber->RgAval, 			Space( Len( Receber->RgAval 	)))
	cCpfAval 	:= IF( lModificar, Receber->CpfAval,			Space( Len( Receber->CpfAval	)))
	cCfop 		:= IF( lModificar, Receber->Cfop,				Space( Len( Receber->Cfop		)))
	nIcms 		:= IF( lModificar, Receber->Tx_Icms,			0 )
	cNatu 		:= ''
	cCep			:= IF( lModificar, Receber->Cep, XCCEP)

	IF( !lModificar, Receber->(DbGoBottom()),)
	lSair 	:= FALSO
	if lAtivaRegNew
		nNewCodi :=  Receber->(Val( Codi )+1)
		cCodi 	:= IF( lModificar, Receber->Codi, IF( nNewCodi > 99999, RetProximo(), StrZero( nNewCodi, 5)))
	Else
		IF( lModificar )
			cCodi := Receber->Codi
		Else
			Receber->(Order(NATURAL))
			Receber->(DbGobottom())
			cCodi := ProxCli( Receber->Codi )
		endif
	endif
	cString	:= IF( lModificar, "ALTERACAO DE CLIENTE", "INCLUSAO DE NOVOS CLIENTES")
	cSwap 	:= cCodi
	cPraca	:= XCCEP
	aNatu 	:= LerNatu()
	aCFop 	:= LerCfop()
	aTxIcms	:= LerIcms()
	WHILE OK
		MaBox( 00 , 00 , 24 , 79, cString )
		Write( 01,		 01, "Codigo.....:                                 Data........:")
		Write( Row()+1, 01, "Nome.......:                                              ")
		Write( Row()+1, 01, "Pop........:                                              ")
		Write( Row()+1, 01, "Cidade.....:                                 Estado......:")
		Write( Row()+1, 01, "Pca Pagto..:           Cfop:      Icms:      Regiao......:")
		Write( Row()+1, 01, "Endereco...:                                 Bairro......:")
		Write( Row()+1, 01, "Rg n§......:                                 Cpf.........:")
		Write( Row()+1, 01, "I. Est.....:                                 Cgc/Mf......:")
		Write( Row()+1, 01, "Telefone...:                                 Fax.........:")
		Write( Row()+1, 01, "------------------------------------------------------------------------------")
		Write( Row()+1, 01, "Natural....:                                 Nascimento..:")
		Write( Row()+1, 01, "Estado Civil:                                Dependentes.:")
		Write( Row()+1, 01, "Esposo(a)..:                                              ")
		Write( Row()+1, 01, "Profissao..:                                 Cargo.......:")
		Write( Row()+1, 01, "Trabalho...:                                 Fone........:")
		Write( Row()+1, 01, "Tempo......:                                 Renda Mes...:")
		Write( Row()+1, 01, "Pai........:                                              ")
		Write( Row()+1, 01, "Mae........:                                              ")
		Write( Row()+1, 01, "Endereco...:                                 Fone........:")
		Write( Row()+1, 01, "------------------------------------------------------------------------------")
		Write( Row()+1, 01, "Referencia.:                                         Spc.:   em")
		Write( Row()+1, 01, "Referencia.:")
		Write( Row()+1, 01, "Imoveis....:")
		nCol	:= 13
		nCol1 := 59
		nCol2 := 33
		nCol3 := 29
		nCol4 := 40
		@ 01, 	  nCol  Get cCodi 	 Pict PIC_RECEBER_CODI Valid RecCerto( @cCodi, lModificar, cSwap )
		@ Row(),   nCol1 Get dData 	 Pict "##/##/##"
		@ Row()+1, nCol  Get cNome 	 Pict "@!"
		@ Row()+1, nCol  Get cFanta	 Pict "@!"
		@ Row()+1, nCol  Get cCep		 Pict "#####-###" Valid CepErrado( @cCep, @cCida, @cEsta, @cBair )
		@ Row(),   23	  Get cCida 	 Pict "@!S21"
		@ Row(),   nCol1 Get cEsta 	 Pict "@!"
		@ Row()+1, nCol  Get cPraca	 Pict "#####-###" Valid CepErrado( @cPraca )
		@ Row(),   nCol3 Get cCFop 	 Pict "9.999" Valid PickTam2( @aNatu, @aCfop, @aTxIcms, @cCfop, @cNatu, @nIcms )
		@ Row(),   nCol4 Get nIcms 	 Pict "99.99"
		@ Row(),   nCol1 Get cRegiao	 Pict "99"   Valid RegiaoErrada( @cRegiao )
		@ Row()+1, nCol  Get cEnde 	 Pict "@!"
		@ Row()	, nCol1 Get cBair 	 Pict "@!S21"
		@ Row()+1, nCol  Get cRg		 Pict "@!"
		@ Row(),   nCol1 Get cCpf		 Pict "999.999.999-99"     Valid TestaCpf( cCpf )
		@ Row()+1, nCol  Get cInsc 	 Pict "@!"                 When Empty( Left( cCpf, 3 ))
		@ Row(),   nCol1 Get cCgc		 Pict "99.999.999/9999-99" When Empty( Left( cCpf, 3 )) Valid TestaCgc( cCgc )
		@ Row()+1, nCol  Get cFone 	 Pict PIC_FONE
		@ Row(),   nCol1 Get cFax		 Pict PIC_FONE

		@ Row()+2, nCol  Get cNatural  Pict "@!"             When !Empty( Left( cCpf, 3 ))
		@ Row(),   nCol1 Get dNasc 	 Pict "##/##/##"       When !Empty( Left( cCpf, 3 ))
		@ Row()+1, nCol  Get cCivil	 Pict "@!"             When !Empty( Left( cCpf, 3 ))
		@ Row(),   nCol1 Get nDepe 	 Pict "99"             When !Empty( Left( cCpf, 3 ))
		@ Row()+1, nCol  Get cEsposa	 Pict "@!"             When !Empty( Left( cCpf, 3 ))
		@ Row()+1, nCol  Get cProf 	 Pict "@!"             When !Empty( Left( cCpf, 3 ))
		@ Row(),   nCol1 Get cCargo	 Pict "@!"             When !Empty( Left( cCpf, 3 ))
		@ Row()+1, nCol  Get cTraba	 Pict "@!"             When !Empty( Left( cCpf, 3 ))
		@ Row(),   nCol1 Get cFone2	 Pict PIC_FONE 		  When !Empty( Left( cCpf, 3 ))
		@ Row()+1, nCol  Get cTempo	 Pict "@!"             When !Empty( Left( cCpf, 3 ))
		@ Row(),   nCol1 Get nRenda	 Pict "99999999.99"    When !Empty( Left( cCpf, 3 ))
		@ Row()+1, nCol  Get cPai		 Pict "@!"             When !Empty( Left( cCpf, 3 ))
		@ Row()+1, nCol  Get cMae		 Pict "@!"             When !Empty( Left( cCpf, 3 ))
		@ Row()+1, nCol  Get cEnde1	 Pict "@!"             When !Empty( Left( cCpf, 3 ))
		@ Row(),   58	  Get cFone1	 Pict PIC_FONE 		  When !Empty( Left( cCpf, 3 ))

		@ Row()+2, nCol  Get cRefCom	 Pict "@!"
		@ Row(),   60	  Get cSpc		 Pict "!" Valid cSpc $ "SN"
		@ Row(),   66	  Get dDataSpc  Pict "##/##/##" Valid IF( cSpc = "S", !Empty( dDataSpc ), OK ) .OR. LastKey() = UP
		@ Row()+1, nCol  Get cRefBco	 Pict "@!"
		@ Row()+1, nCol  Get cImovel	 Pict "@!"
		Read
		if LastKey() = ESC
			lSair := OK
			Exit
		endif
		nCol := 18
		MaBox( 00, 00 , 24 , 79, cString )
		@ 01		, 01 Say "Veiculos...:"     Get cVeiculo    Pict '@!'
		@ Row()+1, 01 Say "Avalista...:"     Get cConhecida  Pict "@!"
		@ Row()+1, 01 Say "Cidade.....:"     Get cCidaAval   Pict "@!S21"
		@ Row(),   45 Say "Estado.....:"     Get cEstaAval   Pict "@!"
		@ Row()+1, 01 Say "Endereco...:"     Get cEnde3      Pict "@!"
		@ Row(),   45 Say "Bairro.....:"     Get cBairAval   Pict "@!"
		@ Row()+1, 01 Say "Telefone...:"     Get cFoneAval   Pict PIC_FONE
		@ Row(),   45 Say "Fax........:"     Get cFaxAval    Pict PIC_FONE
		@ Row()+1, 01 Say "Rg n§......:"     Get cRgAval     Pict "@!"
		@ Row(),   45 Say "Cpf........:"     Get cCpfAval    Pict "999.999.999-99"	Valid TestaCpf( cCpfAval )
		@ Row()+1, 01 Say "Limite Credito.:" Get nLimite     Pict "99999999.99"
		@ Row(),   45 Say "Bancos.....:"     Get cBanco      Pict "@!S20"
		@ Row()+1, 01 Say "Ficha Cancelada:" Get cCancelada  Pict "!" 					Valid PickSimNao( @cCancelada )
		@ Row(),   45 Say "Suporte....:"     Get cSuporte    Pict "!" 					Valid PickSimNao( @cSuporte )
		@ Row(),   60 Say "Cliente Sistema.:"Get cSci        Pict "!" 					Valid PickSimNao( @cSci )
		@ Row()+1, 01 Say "Autoriza Compra:" Get cAutorizaca Pict "!" 					Valid PickSimNao( @cAutorizaca )
		@ Row(),   45 Say "Assinou....:"     Get cAssAutoriz Pict "!" 					Valid PickSimNao( @cAssAutoriz )
		Write( Row()+1, 01, "------------------------------------------------------------------------------")
		@ Row()+1, 01 Say "Observacoes....:" Get cObs    Pict "@!"
		@ Row()+1, 01 Say "...............:" Get cObs1   Pict "@!"
		@ Row()+1, 01 Say "...............:" Get cObs2   Pict "@!"
		@ Row()+1, 01 Say "...............:" Get cObs3   Pict "@!"
		@ Row()+1, 01 Say "...............:" Get cObs4   Pict "@!"
		@ Row()+1, 01 Say "...............:" Get cObs5   Pict "@!"
		@ Row()+1, 01 Say "...............:" Get cObs6   Pict "@!"
		@ Row()+1, 01 Say "...............:" Get cObs7   Pict "@!"
		@ Row()+1, 01 Say "...............:" Get cObs8   Pict "@!"
		@ Row()+1, 01 Say "...............:" Get cObs9   Pict "@!"
		@ Row()+1, 01 Say "...............:" Get cObs10  Pict "@!"
		@ Row()+1, 01 Say "...............:" Get cObs11  Pict "@!"
		@ Row()+1, 01 Say "...............:" Get cObs12  Pict "@!"
#ifdef MAXMOTORS
		Read
		if LastKey() = ESC
			lSair := OK
			Exit
		endif
		nCol := 18
		MaBox( 00, 00 , 24 , 79, cString )
		@ 01, 	  01 Say "Fabricante.....:" Get cFabricante Pict "@!"
		@ Row()+1, 01 Say "Produto........:" Get cProduto    Pict "@!"
		@ Row()+1, 01 Say "Modelo.........:" Get cModelo     Pict "@!"
		@ Row(),   50 Say "Valor..........:" Get nValor      Pict "999999999.99"
		@ Row()+1, 01 Say "Local Venda....:" Get cLocal      Pict "@!"
		@ Row(),   50 Say "N§ Prestacoes..:" Get nPrazo      Pict "999"
		@ Row()+1, 01 Say "Data Vcto Pres.:" Get nDataVcto   Pict "99"
		@ Row(),   50 Say "Prazo Exten....." Get nPrazoExt   Pict "99"
#endif
		Read
		if LastKey() = ESC
			lSair := OK
			Exit
		endif
		ErrorBeep()
		nOpcao := Alerta(" Pergunta: Voce Deseja ? ", if(lModificar, aAltCanSai, aIncAltSai))
		if nOpcao = 1	// Incluir
			if lModificar
				if !Receber->(TravaReg()) ; Loop ; endif
			else
				if !RecCerto( @cCodi, lModificar ) ; Loop ; endif
				if !Receber->(Incluiu())			  ; Loop ; endif
			endif
			Receber->Codi		 := cCodi
			Receber->Data		 := dData
			Receber->Nome		 := cNome
			Receber->Fanta 	 := cFanta
			Receber->Cep		 := cCep
			Receber->Praca 	 := cPraca
			Receber->Ende		 := cEnde
			Receber->Cida		 := cCida
			Receber->Bair		 := cBair
			Receber->Esta		 := cEsta
			Receber->Rg 		 := cRg
			Receber->Cpf		 := cCpf
			Receber->Insc		 := cInsc
			Receber->Cgc		 := cCgc
			Receber->Media 	 := nRenda
			Receber->RefCom	 := cRefCom
			Receber->RefBco	 := cRefBco
			Receber->Imovel	 := cImovel
			Receber->Civil 	 := cCivil
			Receber->Natural	 := cNatural
			Receber->Nasc		 := dNasc
			Receber->Esposa	 := cEsposa
			Receber->Depe		 := nDepe
			Receber->Pai		 := cPai
			Receber->Mae		 := cMae
			Receber->Ende1 	 := cEnde1
			Receber->Fax		 := cFax
			Receber->Fone		 := cFone
			Receber->Fone1 	 := cFone1
			Receber->Profissao := cProf
			Receber->Cargo 	 := cCargo
			Receber->Trabalho  := cTraba
			Receber->Fone2 	 := cFone2
			Receber->Tempo 	 := cTempo
			Receber->Veiculo	 := cVeiculo
			Receber->Conhecida := cConhecida
			Receber->Ende3 	 := cEnde3
			Receber->Spc		 := IF( cSpc		 = "S", OK, FALSO )
			Receber->DataSpc	 := dDataSpc
			Receber->Cancelada := IF( cCancelada = "S", OK, FALSO )
			Receber->Suporte	 := IF( cSuporte	 = "S", OK, FALSO )
			Receber->Sci		 := IF( cSci		 = "S", OK, FALSO )
			Receber->Obs		 := cObs
			Receber->Obs1		 := cObs1
			Receber->Obs2		 := cObs2
			Receber->Obs3		 := cObs3
			Receber->Obs4		 := cObs4
			Receber->Obs5		 := cObs5
			Receber->Obs6		 := cObs6
			Receber->Obs7		 := cObs7
			Receber->Obs8		 := cObs8
			Receber->Obs9		 := cObs9
			Receber->Obs10 	 := cObs10
			Receber->Obs11 	 := cObs11
			Receber->Obs12 	 := cObs12
			Receber->Obs13 	 := cObs13
			Receber->Limite	 := nLimite
			Receber->Regiao	 := cRegiao
			Receber->Banco 	 := cBanco
			Receber->Fabricante := cFabricante
			Receber->Produto	  := cProduto
			Receber->Modelo	  := cModelo
			Receber->Local 	  := cLocal
			Receber->Valor 	  := nValor
			Receber->Prazo 	  := nPrazo
			Receber->DataVcto   := nDataVcto
			Receber->PrazoExt   := nPrazoExt
			Receber->Autorizaca := IF( cAutorizaca = "S", OK, FALSO )
			Receber->AssAutoriz := IF( cAssAutoriz = "S", OK, FALSO )
			Receber->CidaAval   := cCidaAval
			Receber->EstaAval   := cEstaAval
			Receber->BairAval   := cBairAval
			Receber->FoneAval   := cFoneAval
			Receber->FaxAval	  := cFaxAval
			Receber->RgAval	  := cRgAval
			Receber->CpfAval	  := cCpfAval
			Receber->Cfop		  := cCfop
			Receber->Tx_Icms	  := nIcms
			Receber->(Libera())
			lUpdated := true
			if lModificar
				lSair := OK
			endif
			Exit

		Elseif nOpcao = 2 // Alterar
			Loop
		Elseif nOpcao = 3 // Sair
			lSair := OK
			Exit
		endif
	EndDo
	if lSair
		SetKey( F4, NIL )
		ResTela( cScreen )
		Exit
	endif
EndDo
return lUpdated

Function RetProximo()
*********************
LOCAL cScreen := SaveScreen()
LOCAL cTela   := Mensagem("Aguarde, Localizando Proximo Registro Vago.")
LOCAL nX

For nX := 1 To 10000
	 cCodi := StrZero( nX, 4 )
	 if Receber->(DbSeek( cCodi ))
		 Loop
	 endif
	 Return( cCodi )
Next
Return( cCodi )	

static function Extrato()
*------------------------*
LOCAL GetList   := {}
LOCAL cScreen   := SaveScreen()
LOCAL aMenu     := {'Individual','Por Regiao','Geral'}
LOCAL aMenu1    := {'Normal Carteira','Para Tribunal'}
LOCAL lTribunal := FALSO
LOCAL nChoice   := 0
LOCAL oBloco 
LOCAL cCodi    AS STRING
LOCAL cRegiao  AS STRING
LOCAL dIni     AS DATE
LOCAL dFim     AS DATE
LOCAL dCalculo AS DATE
FIELD Codi     AS STRING


WHILE OK
	oMenu:Limpa()
	M_Title("FINALIDADE DO EXTRATO DE CONTA" )
	lTribunal := (FazMenu( 03, 20, aMenu1)) == 2
	
	if LastKey() = ESC
		ResTela( cScreen )
		return
	endif
	
	M_Title("ESCOLHA O EXTRATO DE CONTA" )
	nChoice := FazMenu( 09, 20, aMenu )
	
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		return

	Case nChoice = 1
		cCodi    := Space(05)
		dIni     := Ctod("01/01/91")
      dFim     := Ctod("31/12/" + Right(Dtoc(Date()),2))
      dCalculo := Date()
		MaBox( 16, 20, 21, 80 )
		@ 17, 21 Say "Cliente......:" Get cCodi    Pict "99999"  Valid RecErrado( @cCodi )
		@ 18, 21 Say "Data Inicial.:" Get dIni     Pict PIC_DATA Valid AchaUltVcto(cCodi, @dFim)
      @ 19, 21 Say "Data Final...:" Get dFim     Pict PIC_DATA 
      @ 20, 21 Say "Data Calculo.:" Get dCalculo Pict PIC_DATA 		
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Mensagem("Aguarde, Filtrando Registros.")
		Receber->(Order( RECEBER_CODI ))
		Area( "Recemov" )
		Recemov->(Order( RECEMOV_CODI_VCTO ))
		if Recemov->(!DbSeek( cCodi ))
			Nada()
			Loop
		endif
		Set Rela To Recemov->Codi Into Receber
		oBloco := {|| Recemov->Codi = cCodi }
		ExtratoImp( oBloco, lTribunal, dIni, dFim, dCalculo )
		Recemov->(DbClearRel())
		Recemov->(DbGoTop())
		Loop

	Case nChoice = 2
		cRegiao  := Space(02)
		dIni     := Ctod("01/01/91")
      dFim     := Ctod("31/12/" + Right(Dtoc(Date()),2))
      dCalculo := Date()
		MaBox( 16, 20, 21, 50 )
		@ 17, 21 Say "Regiao.......:" Get cRegiao Pict '99' Valid RegiaoErrada( @cRegiao )
		@ 18, 21 Say "Data Inicial.:" Get dIni     Pict PIC_DATA Valid AchaUltVcto(cCodi, @dFim)
      @ 19, 21 Say "Data Final...:" Get dFim     Pict PIC_DATA 
      @ 20, 21 Say "Data Calculo.:" Get dCalculo Pict PIC_DATA 
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Mensagem("Aguarde, Filtrando Registros.")
		Receber->(Order( RECEBER_CODI ))
		Area( "Recemov" )
		Recemov->(Order( RECEMOV_REGIAO_CODI ))
		if Recemov->(!DbSeek( cRegiao ))
			Nada()
			Loop
		endif
		Set Rela To Recemov->Codi Into Receber
		oBloco := {|| Recemov->Regiao = cRegiao }
		ExtratoImp( oBloco, lTribunal, dIni, dFim, dCalculo )
		Recemov->(DbClearRel())
		Recemov->(DbGoTop())
		Loop

	Case nChoice = 3
		MaBox( 16, 20, 20, 50 )
		@ 17, 21 Say "Data Inicial.:" Get dIni     Pict PIC_DATA Valid AchaUltVcto(cCodi, @dFim)
      @ 18, 21 Say "Data Final...:" Get dFim     Pict PIC_DATA 
      @ 19, 21 Say "Data Calculo.:" Get dCalculo Pict PIC_DATA 
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Receber->(Order( RECEBER_CODI ))
		Area( "Recemov" )
		Recemov->(Order( RECEMOV_CODI_VCTO ))
		Recemov->(DbGotop())
		if Recemov->(Eof())
			Nada()
			Loop
		endif
		Mensagem("Aguarde, Filtrando Registros.")
		Set Rela To Recemov->Codi Into Receber
		oBloco := {|| Recemov->(!Eof()) }
		ExtratoImp( oBloco, lTribunal, dIni, dFim, dCalculo )
		Recemov->(DbClearRel())
		Recemov->(DbGoTop())
		Loop
	EndCase
EndDo

static function LancaDespesasDiversas( cCaixa, cVendedor, cTipo)
*--------------------------------------------------------------*
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL cScreen	 := SaveScreen()
LOCAL cNome 	 := Space(40)
LOCAL cEnde 	 := Space(40)
LOCAL cCida 	 := Space(40)
LOCAL cValor	 := Space(0)
LOCAL cHist 	 := Space(40)
LOCAL cRef		 := Space(40)
LOCAL cCodiCx1  := Space(04)
LOCAL cCodiCx2  := Space(04)
LOCAL dData     := Date()
LOCAL cCodiCx	 := '0000'
LOCAL cDc		 := 'D'
LOCAL cDc1		 := 'D'
LOCAL cDc2		 := 'D'
LOCAL nOpcao	 := 1
LOCAL nVlrTotal := 0
LOCAL Larg		 := 80
LOCAL nValor	 := 0
LOCAL nChSaldo  := 0
LOCAL nTamDoc	 := 0
LOCAL nVlrLcto  := 0
LOCAL cTela
LOCAL nRow
LOCAL cNomeFir
LOCAL cStr
LOCAL oObj

cNome 	:= Space(40)
cEnde 	:= Space(40)
cCida 	:= Space(40)
cHist 	:= Space(40)
cRef		:= Space(40)
cCodiCx1 := Space(04)
cCodiCx2 := Space(04)
cCodiCx	:= '0000'
cDc		:= 'D'
cDc1		:= 'D'
cDc2		:= 'D'
nValor	:= 0
cNomeFir := oAmbiente:xNomefir
o1       := TLancaDespesasDiversas():New()

WHILE OK
	o1:GeraDocnr()
	nTamDoc	:= Len( o1:cDocnr)
	oMenu:Limpa()
	MaBox( 10, 00, 20, 79, 'LANCAMENTO DE DESPESAS DIVERSAS' )
   @ 11, 01 Say "Nome Emitente..: " Get cNome    Pict "@!" Valid if(Empty(cNome),  ( ErrorBeep(), Alerta("Ooops!: Entre com um nome!", nil , 31), FALSO ), OK )
	@ 12, 01 Say "Referente......: " Get cRef     Pict "@!" Valid if(Empty(cRef),   ( ErrorBeep(), Alerta("Ooops!: Entre com a referencia!", nil , 31), FALSO ), (ValidarcHist(cRef,@cHist), OK))
	@ 13, 01 Say "Historico Cx...: " Get cHist    Pict "@!" Valid if(Empty(cHist),  ( ErrorBeep(), Alerta("Ooops!: Entre com o historico!"), FALSO ), OK )
	@ 14, 01 Say "Data...........: " Get dData    Pict PIC_DATA Valid if(Empty(dData), ( ErrorBeep(), Alerta("Ooops!: Entre com uma data!"), FALSO ), OK )
	@ 15, 01 Say "Documento #....: " Get o1:cDocnr   Pict "@!" Valid CheqDoc(o1:cDocnr)
	@ 16, 01 Say "Valor R$.......: " Get nValor   Pict "@E 9,999,999.99" Valid if(Empty(nValor), ( ErrorBeep(), Alerta("Ooops!: Entre com um valor!"), FALSO ), OK )
	@ 17, 01 Say "Conta Caixa....: " GET cCodiCx  Pict "9999" Valid CheErrado( @cCodiCx,, Row(), 32, OK )
	@ 17, 24 Say "D/C.:"             GET cDc      Pict "!"    Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc )
	@ 18, 01 Say "C. Partida.....: " GET cCodiCx1 Pict "9999" Valid CheErrado( @cCodiCx1,, Row(), 32, OK )
	@ 18, 24 Say "D/C.:"             GET cDc1     Pict "!"    Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc1 )
	@ 19, 01 Say "C. Partida.....: " GET cCodiCx2 Pict "9999" Valid CheErrado( @cCodiCx2,, Row(), 32, OK )
	@ 19, 24 Say "D/C.:"             GET cDc2     Pict "!"    Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc2 )
	Read
	if LastKey() = ESC
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		return
	endif
	ErrorBeep()
	if !Conf('Pergunta: Confirma lancamento ?')
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Loop
	endif
	nVlrLcto := nValor
	if Cheque->(DbSeek( cCodiCx )) .OR. !Empty( cCodiCx )
		if Cheque->(TravaReg())
			nChSaldo := Cheque->Saldo
			if Chemov->(Incluiu())
				if cDc = "C"
					nChSaldo 	  += nVlrLcto
					Cheque->Saldo += nVlrLcto
					Chemov->Cre   := nVlrLcto
				else
					nChSaldo 	  -= nVlrLcto
					Cheque->Saldo -= nVlrLcto
					Chemov->Deb   := nVlrLcto
				endif
				Chemov->Codi	:= cCodiCx
				Chemov->Docnr	:= o1:cDocnr
				Chemov->Emis	:= dData
				Chemov->Data	:= dData
				Chemov->Baixa	:= Date()
				Chemov->Hist	:= cHist
				Chemov->Saldo	:= nChSaldo
				Chemov->Tipo	:= 'OU'
				Chemov->Caixa	:= if( cCaixa = Nil, Space(4), cCaixa )
				Chemov->Fatura := o1:cDocnr
			endif
			Chemov->(Libera())
		endif
		Cheque->(Libera())
	endif
	*:-------------------------------------------------------
	if Cheque->(DbSeek( cCodiCx1 )) .OR. !Empty( cCodiCx1 )
		if Cheque->(TravaReg())
			nChSaldo := Cheque->Saldo
			if Chemov->(Incluiu())
				if cDc1 = "C"
					nChSaldo 	  += nVlrLcto
					Cheque->Saldo += nVlrLcto
					Chemov->Cre   := nVlrLcto
				else
					nChSaldo 	  -= nVlrLcto
					Cheque->Saldo -= nVlrLcto
					Chemov->Deb   := nVlrLcto
				endif
				Chemov->Codi	:= cCodiCx1
				Chemov->Docnr	:= o1:cDocnr
				Chemov->Emis	:= dData
				Chemov->Data	:= dData
				Chemov->Baixa	:= Date()
				Chemov->Hist	:= cHist
				Chemov->Saldo	:= nChSaldo
				Chemov->Tipo	:= 'OU'
				Chemov->Caixa	:= if( cCaixa = Nil, Space(4), cCaixa )
				Chemov->Fatura := o1:cDocnr
			endif
			Chemov->(Libera())
		endif
		Cheque->(Libera())
	endif
	
	*:-------------------------------------------------------
	
	if Cheque->(DbSeek( cCodiCx2 )) .OR. !Empty( cCodiCx2 )
		if Cheque->(TravaReg())
			nChSaldo := Cheque->Saldo
			if Chemov->(Incluiu())
				if cDc2 = "C"
					nChSaldo 	  += nVlrLcto
					Cheque->Saldo += nVlrLcto
					Chemov->Cre   := nVlrLcto
				else
					nChSaldo 	  -= nVlrLcto
					Cheque->Saldo -= nVlrLcto
					Chemov->Deb   := nVlrLcto
				endif
				Chemov->Codi	:= cCodiCx2
				Chemov->Docnr	:= o1:cDocnr
				Chemov->Emis	:= dData
				Chemov->Data	:= dData
				Chemov->Baixa	:= Date()
				Chemov->Hist	:= cHist
				Chemov->Saldo	:= nChSaldo
				Chemov->Tipo	:= 'OU'
				Chemov->Caixa	:= if( cCaixa = Nil, Space(4), cCaixa )
				Chemov->Fatura := o1:cDocnr
			endif
			Chemov->(Libera())
		endif
		Cheque->(Libera())
	endif

	*:-------------------------------------------------------

   if Recibo->(Incluiu())
		Recibo->Nome	 := cNome
      Recibo->Vcto    := Date()
      Recibo->Tipo    := "PAGDIV"
      Recibo->Codi    := "00000"
		Recibo->Docnr	 := o1:cDocnr
      Recibo->Hora    := Time()
      Recibo->Data    := dData
      Recibo->Usuario := oAmbiente:xUsuario + Space( 10 - Len( oAmbiente:xUsuario ))
      Recibo->Caixa   := cCaixa
      Recibo->Vlr     := -nValor
		Recibo->Hist	 := cHist
		Recibo->(Libera())
	endif
	
EndDo

*:==================================================================================================================================

CLASS TLancaDespesasDiversas
   DATA 	 cDocnr     		INIT Space(9)
	DATA 	 Contador			INIT 0
	METHOD New 					INLINE self
//	METHOD New 					INLINE ::GeraDocnr
	METHOD GeraDocnr()	
END CLASS

METHOD TLancaDespesasDiversas:GeraDocnr()
*-----------------------------------------*
	::cDocnr	:= StrZero(Day(Date()),2)
	::cDocnr += StrZero(Month(Date()),2)
	::cDocnr += Right(StrZero(Year(Date()),4),2)
	::cDocnr += '-'
	::cDocnr += StrZero(++::Contador, 2)
	return self

*:==================================================================================================================================

Proc TrocaCobAgenda()
********************
LOCAL aMenu 	 := {'Por Cobrador','Por Cliente','Geral'}
LOCAL cScreen	 := SaveScreen()
LOCAL cCodiVen  := Space(04)
LOCAL cCobrador := Space(04)
LOCAL cCodi 	 := Space(05)
LOCAL nChoice	 := 0

WHILE OK
	oMenu:Limpa()
	M_Title('TROCA COBRADOR DO AGENDAMENTO')
	nChoice := FazMenu( 03, 10, aMenu )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		return

	Case nChoice = 1
		cCodiVen  := Space( 04 )
		cCobrador := Space( 04 )
		MaBox( 10, 10, 13, 78 )
		@ 11 , 11 Say "Cobrador Anterior.:" Get cCodiVen  Pict "9999" Valid FunErrado( @cCodiVen,, Row(), Col()+1 )
		@ 12 , 11 Say "Cobrador Atual....:" Get cCobrador Pict "9999" Valid FunErrado( @cCobrador,, Row(), Col()+1 )
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		ErrorBeep()
		if Conf("Pergunta: A troca podera demorar. Continua ?")
			Recemov->(DbGotop())
			Mensagem("Aguarde, Trocando de cobrador.")
			While Recemov->(!Eof()) .AND. Rep_Ok()
				if Recemov->Cobrador = cCodiVen
					if Recemov->(TravaReg())
						Recemov->Cobrador := cCobrador
						Recemov->RelCob	:= OK
						Recemov->(Libera())
					endif
				endif
			  Recemov->(DbSkip(1))
			EndDo
		endif

	Case nChoice = 2
		cCodi 	 := Space(05)
		cCobrador := Space(04)
		MaBox( 10, 10, 13, 78 )
		@ 11, 11 Say "Cliente.......:" Get cCodi PICT PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
		@ 12, 11 Say "Novo Cobrador.:" Get cCobrador Pict "9999" Valid FunErrado( @cCobrador,, Row(), Col()+1 )
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		ErrorBeep()
		if Conf("Pergunta: Continua ?")
			Mensagem("Aguarde, Trocando de cobrador.")
			Recemov->(Order( RECEMOV_CODI ))
			if Recemov->(DbSeek( cCodi ))
				While Recemov->Codi = cCodi
					if Recemov->(TravaReg())
						Recemov->Cobrador := cCobrador
						Recemov->RelCob	:= OK
						Recemov->(Libera())
					endif
					Recemov->(DbSkip(1))
				EndDo
			endif
		endif

	Case nChoice = 3
		cCobrador := Space(04)
		MaBox( 10, 10, 12, 78 )
		@ 11, 11 Say "Novo Cobrador.:" Get cCobrador Pict "9999" Valid FunErrado( @cCobrador,, Row(), Col()+1 )
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		ErrorBeep()
		if Conf("Pergunta: Alteracao podera demorar. Continua ?")
			Recemov->(DbGotop())
			Mensagem("Aguarde, Trocando de cobrador.")
			While Recemov->(!Eof()) .AND. Rep_Ok()
				if !Empty( Recemov->Cobrador)
					if Recemov->(TravaReg())
						Recemov->Cobrador := cCobrador
						Recemov->RelCob	:= OK
						Recemov->(Libera())
					endif
				endif
				Recemov->(DbSkip(1))
			EndDo
		endif
	EndCase
EndDo

*:==================================================================================================================================

Proc RemoveCobranca()
*********************
LOCAL aMenu 	:= {'Por Cobrador','Por Cliente','Geral'}
LOCAL cScreen	:= SaveScreen()
LOCAL cCodiVen := Space(04)
LOCAL cCodi 	:= Space(05)
LOCAL nChoice	:= 0

WHILE OK
	oMenu:Limpa()
	M_Title('REMOVE COMISSAO COBRADOR')
	nChoice := FazMenu( 03, 10, aMenu )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		return

	Case nChoice = 1
		MaBox( 10, 10, 12, 78 )
		cCodiVen := Space( 04 )
		@ 11 , 11 Say "Cobrador..:" Get cCodiVen Pict "9999" Valid FunErrado( @cCodiVen,, Row(), Col()+1 )
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		ErrorBeep()
		if Conf("Pergunta: Alteracao podera demorar. Continua ?")
			Recemov->(DbGotop())
			Mensagem("Aguarde, Limpando Comissao Cobrador.")
			While Recemov->(!Eof()) .AND. Rep_Ok()
				if Recemov->Cobrador = cCodiVen
					if Recemov->(TravaReg())
						Recemov->Cobrador := Space(04)
						Recemov->RelCob	:= FALSO
						Recemov->(Libera())
					endif
				endif
			  Recemov->(DbSkip(1))
			EndDo
		endif

	Case nChoice = 2
		cCodi := Space( 05 )
		MaBox( 10, 10, 12, 78 )
		@ 11, 11 Say "Cliente....:" GET cCodi PICT PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		ErrorBeep()
		if Conf("Pergunta: Continua ?")
			Mensagem("Aguarde, Limpando Comissao Cobrador.")
			Recemov->(Order( RECEMOV_CODI ))
			if Recemov->(DbSeek( cCodi ))
				While Recemov->Codi = cCodi
					if Recemov->(TravaReg())
						Recemov->Cobrador := Space(04)
						Recemov->RelCob	:= FALSO
						Recemov->(Libera())
					endif
					Recemov->(DbSkip(1))
				EndDo
			endif
		endif

	Case nChoice = 3
		ErrorBeep()
		if Conf("Pergunta: Alteracao podera demorar. Continua ?")
			Recemov->(DbGotop())
			Mensagem("Aguarde, Limpando Comissao Cobrador.")
			While Recemov->(!Eof()) .AND. Rep_Ok()
				if Recemov->(TravaReg())
					Recemov->Cobrador := Space(04)
					Recemov->RelCob	:= FALSO
					Recemov->(Libera())
				endif
				Recemov->(DbSkip(1))
			EndDo
		endif
	EndCase
EndDo

*:==================================================================================================================================

Function ClientesFiltro()
*************************
LOCAL cScreen	:= SaveScreen()
LOCAL AtPrompt := {"Por Codigo", "Por Cidade", "Por Estado", "Por Regiao", "Todos"}
LOCAL xAlias	:= FTempName()
LOCAL xNtx		:= FTempName()
LOCAL cCodi 	:= Space(05)
LOCAL cCida 	:= Space(25)
LOCAL cEsta 	:= Space(02)
LOCAL cRegiao	:= Space(02)
LOCAL Op1		:= 0
LOCAL aStru
LOCAL nLen
LOCAL nField

Area("Receber")
Receber->(DbGoTop())
if Receber->(Eof())
	Nada()
	ResTela( cScreen )
	return
endif
WHILE OK
	M_Title( "ESCOLHA A OPCAO DE CONSULTA" )
	Op1	:= FazMenu( 04, 10, AtPrompt, Cor() )
	Do Case
	Case Op1 = 0
		ResTela( cScreen )
		Exit

	Case Op1 = 1
		MaBox( 13, 10, 15, 26 )
		cCodi := Space( 05 )
		@ 14 , 11 Say "Codigo..:" GET cCodi PICT PIC_RECEBER_CODI Valid RecErrado( @cCodi )
		Read

		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif

		cTela   := Mensagem("Aguarde, Filtrando Registros. ")
		aStru   := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		Area("Receber")
		Receber->(Order( RECEBER_CODI ))
		nLen := Receber->(FCount())
		if Receber->(DbSeek( cCodi ))
			While ( Receber->Codi = cCodi .AND. Rep_Ok() )
				xTemp->(DbAppend())
				For nField := 1 To nLen
					xTemp->( FieldPut( nField, Receber->(FieldGet( nField ))))
				Next
				Receber->(DbSkip(1))
			EndDo
		endif
		xTemp->(DbGoTop())
		if xTemp->(Eof())  // Nenhum Registro
			Alerta("Erro: Nenhum Cliente Atende a Condicao.")
		else
		  Clifiltro()
		endif
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )

	Case Op1 = 2
		MaBox( 13, 10, 15, 47 )
		cCida := Space( 25 )
		@ 14, 11 Say "Cidade..:" GET cCida PICT "@!"
		Read

		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif

		cTela   := Mensagem("Aguarde, Filtrando Registros.")
		aStru   := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		Area("Receber")
		Receber->(Order( RECEBER_CIDA ))
		nLen := Receber->(FCount())
		if Receber->(DbSeek( cCida ))
			While ( Receber->Cida = cCida .AND. Receber->(!Eof()).AND. Rep_Ok() )
				xTemp->(DbAppend())
				For nField := 1 To nLen
					xTemp->( FieldPut( nField, Receber->(FieldGet( nField ))))
				Next
				Receber->(DbSkip(1))
			EndDo
		endif
		xTemp->(DbGoTop())
		if xTemp->(Eof())  // Nenhum Registro
			Alerta("Erro: Nenhum Cliente Atende a Condicao.")
		else
		  Clifiltro()
		endif
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )

	Case Op1 = 3
		MaBox( 13, 10, 15, 24 )
		cEsta := Space( 02 )
		@ 14 , 11 Say "Estado..:" GET cEsta PICT "@!"
		Read

		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif

		cTela   := Mensagem("Aguarde, Filtrando Registros.")
		aStru   := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		Area("Receber")
		Receber->(Order( RECEBER_ESTA ))
		nLen := Receber->(FCount())
		if Receber->(DbSeek( cEsta ))
			While ( Receber->Esta = cEsta .AND. Receber->(!Eof()) .AND. Rep_Ok() )
				xTemp->(DbAppend())
				For nField := 1 To nLen
					xTemp->( FieldPut( nField, Receber->(FieldGet( nField ))))
				Next
				Receber->(DbSkip(1))
			EndDo
		endif
		xTemp->(DbGoTop())
		if xTemp->(Eof())  // Nenhum Registro
			Alerta("Erro: Nenhum Cliente Atende a Condicao.")
		else
			Clifiltro()
		endif
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )

	Case Op1 = 4
		MaBox( 13, 10, 15, 24 )
		cRegiao := Space(2)
		@ 14 , 11 Say "Regiao..:" GET cRegiao PICT "99" Valid RegiaoErrada( @cRegiao )
		Read

		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif

		cTela   := Mensagem("Aguarde, Filtrando Registros.")
		aStru   := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		Area("Receber")
		Receber->(Order( RECEBER_REGIAO ))
		nLen := Receber->(FCount())
		if Receber->(DbSeek( cRegiao ))
			While ( Receber->Regiao = cRegiao .AND. Rep_Ok() )
				xTemp->(DbAppend())
				For nField := 1 To nLen
					xTemp->( FieldPut( nField, Receber->(FieldGet( nField ))))
				Next
				Receber->(DbSkip(1))
			EndDo
		endif
		xTemp->(DbGoTop())
		if xTemp->(Eof())  // Nenhum Registro
			Alerta("Erro: Nenhum Cliente Atende a Condicao.")
		else
			Clifiltro()
		endif
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )

	Case Op1 = 5
		ClientesDbEdit()

	EndCase
	ResTela( cScreen )

EndDo

*:==================================================================================================================================

Proc Clifiltro()
****************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()
Set Key -8 To

oMenu:Limpa()
Area( xTemp )
xTemp->(DbGoTop())
oBrowse:Add( "CODIGO",    "Codi")
oBrowse:Add( "NOME",      "Nome")
oBrowse:Add( "CIDADE",    "Cida")
oBrowse:Add( "UF",        "Esta")
oBrowse:Titulo   := "CONSULTA DE CLIENTES"
oBrowse:PreDoGet := NIL
oBrowse:PosDoGet := NIL
oBrowse:PreDoDel := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

*:==================================================================================================================================

Proc RegiaoConsulta()
*********************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()
Set Key -8 To

oMenu:Limpa()
Area("Regiao")
Regiao->(Order( REGIAO_NOME ))
Regiao->(DbGoTop())
oBrowse:Add( "CODIGO",    "Regiao")
oBrowse:Add( "DESCRICAO", "Nome")
oBrowse:Titulo   := "CONSULTA/ALTERACAO DE REGIOES"
oBrowse:PreDoGet := NIL
oBrowse:PosDoGet := NIL
oBrowse:PreDoDel := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

*:==================================================================================================================================

STATIC Proc Exclusao()
**********************
LOCAL cScreen := SaveScreen()
LOCAL Doc

Receber->( Order( RECEBER_CODI ))
WHILE OK
	Area("ReceMov")
	Set Rela To Codi Into Receber
	Recemov->(Order( RECEMOV_DOCNR ))
	Recemov->(DbGoTop())
	MaBox( 16 , 10 , 18 , 30 )
	Doc := Space( 9 )
	@ 17 , 11 SAY "Doc.No..¯"GET doc PICT "@K!" Valid DocErrado( @doc )
	Read
	if LastKey() = ESC
		DbClearRel()
		DbGoTop()
		ResTela( cScreen )
		Exit
	endif
	oMenu:Limpa()
	MaBox(  06 , 10, 17 , 76, "EXCLUSAO DE MOVIMENTO" )
	Write( 07 , 11, "Codigo...¯ " + Codi + "  " + Receber->Nome )
	Write( 08 , 11, "Tipo.....¯ " + Tipo)
	Write( 09 , 11, "Doc.N?..¯ " + Docnr)
	Write( 10 , 11, "Nosso N?¯ " + Nossonr)
	Write( 11 , 11, "Bordero..¯ " + Bordero)
	Write( 12 , 11, "Emissao..¯ " + Dtoc( Emis ))
	Write( 13 , 11, "Vencto...¯ " + Dtoc( Vcto ))
	Write( 14 , 11, "Portador.¯ " + Port)
	Write( 15 , 11, "Valor....¯ " + Tran( Vlr,  "@E 9,999,999,999.99"))
	Write( 16 , 11, "Jr Mes...¯ " + Tran( Juro, "999.99"))
	ErrorBeep()
	if Conf( "Confirma Exclusao deste Movimento ?" )
		if Recemov->(TravaReg())
			DbDelete()
			Recemov->(Libera())
			Alerta(" Registro Excluido ...")
			ResTela( cScreen )
			Loop
		endif
	endif
	ResTela( cScreen )
EndDo

*:==================================================================================================================================

Proc Proc_Altera()
******************
LOCAL cScreen	  := SaveScreen()
LOCAL nChoice	  := 1
LOCAL aMenuArray := { " A Receber "," Recebidos "}

WHILE OK
	M_Title("ALTERACAO DE TITULOS")
	nChoice := FazMenu( 10, 10, aMenuArray, Cor())
	if nChoice = 0
		ResTela( cScreen )
		Exit
	elseif nChoice = 1
		AlteraReceber()
	else
		AlteraRecebido()
	endif
EndDO

function AlteraReceber( cDocnr, nRegistro )
*******************************************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL nCotacao := 0
LOCAL lParam   := if( cDocnr == NIL , FALSO, OK)
LOCAL cObs
LOCAL lRetVal  := FALSO
LOCAL cCodi

if !lParam 
   cDocnr := Space(9)
endif

WHILE OK
	Receber->(Order( RECEBER_CODI ))
	Area("ReceMov")
	Recemov->(Order( RECEMOV_DOCNR ))
   if !lParam
	   MaBox( 16 , 10 , 18 , 30 )
	   @ 17 , 11 Say	"Doc.No..¯" Get cDocNr Pict "@K!" Valid DocErrado( @cDocNr )
	   Read
	   if LastKey() = ESC
	   	AreaAnt( Arq_Ant, Ind_Ant )
		   ResTela( cScreen )
		   Exit
	   endif 
	else
	   Recemov->(DbGoto( nRegistro ))
		if Recemov->Docnr != cDocnr
			DocErrado( @cDocNr )
		endif
	endif	
	oMenu:Limpa()
	nRegistro := Recemov->(Recno())	
	cCodi     := Recemov->Codi
	cTipo 	 := Recemov->Tipo
	cDocnr	 := Recemov->Docnr
	cNossoNr  := Recemov->NossoNr
	cBordero  := Recemov->Bordero
	dEmis 	 := Recemov->Emis
	dVcto 	 := Recemov->Vcto
	cPort 	 := Recemov->Port
	nVlr		 := Recemov->Vlr
	nJuro 	 := Recemov->Juro
	nVlrAnt	 := Recemov->Vlr
	cFatura	 := Recemov->Fatura
	cObs		 := Recemov->Obs
	dDataPag  := Recemov->DataPag
	nVlrPag   := Recemov->VlrPag
	
	Receber->(DbSeek( cCodi ))
   MaBox( 06 , 10 , 20 , MaxCol()-4, "ALTERACAO DE MOVIMENTO" )
	Write( 07 , 11 ,	"Codigo...: " + Recemov->Codi + " " + Receber->Nome )
	Write( 08 , 11 ,	"Tipo.....: " + Recemov->Tipo)
	Write( 09 , 11 ,	"Doc.N?..: " + Recemov->Docnr)
	Write( 10 , 11 ,	"Nosso N?: " + Recemov->Nossonr)
	Write( 11 , 11 ,	"Bordero..: " + Recemov->Bordero)
	Write( 12 , 11 ,	"Emissao..: " + Recemov->(Dtoc(Emis)))
	Write( 13 , 11 ,	"Vencto...: " + Recemov->(Dtoc(Vcto)))
	Write( 14 , 11 ,	"Portador.: " + Recemov->Port)
	Write( 15 , 11 ,	"Valor....: " + Recemov->(Tran(Vlr,  "@E 9,999,999,999.99")))
	Write( 16 , 11 ,	"Jr Mes...: " + Recemov->(Tran( Juro, "999.99")))
	Write( 17 , 11 ,	"Obs......: " + Recemov->Obs )
	Write( 18 , 11 ,	"Datapag..: " + Recemov->(Dtoc(Datapag)))
	Write( 19 , 11 ,	"Vlr Pago.: " + Recemov->(Tran(VlrPag,  "@E 9,999,999,999.99")))
	
	@ 07 , 22 Get cCodi    Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi, NIL , Row(), Col()+1)
	@ 08 , 22 Get cTipo	  Pict "@!"
	@ 09 , 22 Get cDocnr   Pict "@!"
	@ 10 , 22 Get cNossoNr Pict "@!"
	@ 11 , 22 Get cBordero Pict "@!"
	@ 12 , 22 Get dEmis	  Pict "##/##/##"
	@ 13 , 22 Get dVcto	  Pict "##/##/##"
	@ 14 , 22 Get cPort	  Pict "@!"
	@ 15 , 22 Get nVlr	  Pict "@E 9,999,999,999.99"
	@ 16 , 22 Get nJuro	  Pict "999.99"
	@ 17 , 22 Get cObs	  Pict "@!"
	@ 18 , 22 Get dDataPag Pict "##/##/##"
	@ 19 , 22 Get nVlrPag  Pict "@E 9,999,999,999.99"
	Read
	if LastKey() = ESC
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		if lParam
		   return( lRetVal )
		endif	
		Exit
	endif	
	DbGoTo( nRegistro )
	ErrorBeep()
	if (lRetVal := Conf( "Confirma Alteracao Do Registro ?"))
		nJdia := Jurodia( nVlr, nJuro )
		if Recemov->(TravaArq())
			DbGoTo( nRegistro )
			Recemov->Codi		:= cCodi
			Recemov->Docnr 	:= cDocNr
			Recemov->Emis		:= dEmis
			Recemov->Emis		:= dEmis
			Recemov->Port		:= cPort
			Recemov->Vcto		:= dVcto
			Recemov->Vlr		:= nVlr
			Recemov->Tipo		:= cTipo
			Recemov->NossoNr	:= cNossoNr
			Recemov->Bordero	:= cBordero
			Recemov->Juro		:= nJuro
			Recemov->Jurodia	:= nJDia
			Recemov->VlrDolar := nVlr
			Recemov->Obs		:= cObs
			Recemov->DataPag  := dDataPag
			Recemov->VlrPag   := nVlrPag
			Recemov->(Order( RECEMOV_FATURA ))
			if Recemov->(DbSeek( cFatura ))
				WHILE Recemov->Fatura = cFatura
					Recemov->VlrFatu -= nVlrAnt
					Recemov->VlrFatu += nVlr
					Recemov->(DbSkip(1))
				EndDo
			endif
			Recemov->(Libera())				
		endif
	endif	
	ResTela( cScreen )
	DbGoTo( nRegistro )
	if lParam
		AreaAnt( Arq_Ant, Ind_Ant )
		return( lRetVal )
	endif	
EndDo

*:==================================================================================================================================

Proc AlteraRecebido()
*********************
LOCAL cScreen	:= SaveScreen()
LOCAL nCotacao := 0
LOCAL cDocnr	:= Space(9)
LOCAL nVlrPag	:= 0
LOCAL cObs		:= ""

Receber->(Order( RECEBER_CODI ))
Area("Recebido")
Recebido->(Order( RECEBIDO_DOCNR ))
Set Rela To Codi Into Receber
WHILE OK
	MaBox( 16 , 10 , 18 , 30 )
	@ 17 , 11 Say	"Doc.No..:"Get cDocNr Pict "@K!" Valid RecebiErrado( @cDocNr )
	Read
	if LastKey() = ESC
		Recebido->(DbClearRel())
		Recebido->(DbClearFilter())
		Recebido->(DbGoTop())
		ResTela( cScreen )
		Exit
	endif
	oMenu:Limpa()
	MaBox( 06 , 10 , 20 , 76, 'ALTERACAO DE TITULO RECEBIDO' )
	Write( 07 , 11 ,	"Codigo...: " + Recebido->Codi + " " + Receber->Nome )
	Write( 08 , 11 ,	"Tipo.....: " + Recebido->Tipo)
	Write( 09 , 11 ,	"Doc.N?..: " + Recebido->Docnr)
	Write( 10 , 11 ,	"Nosso N?: " + Recebido->Nossonr)
	Write( 11 , 11 ,	"Bordero..: " + Recebido->Bordero)
	Write( 12 , 11 ,	"Emissao..: " + Recebido->(Dtoc(Emis)))
	Write( 13 , 11 ,	"Vencto...: " + Recebido->(Dtoc(Vcto)))
	Write( 14 , 11 ,	"Portador.: " + Recebido->Port)
	Write( 15 , 11 ,	"Valor....: " + Recebido->(Tran(Vlr,  "@E 9,999,999,999.99")))
	Write( 16 , 11 ,	"Jr Mes...: " + Recebido->(Tran(Juro, "999.99")))
	Write( 17 , 11 ,	"Data Pgto: " + Recebido->(Dtoc( DataPag)))
	Write( 18 , 11 ,	"Recebido.: " + Recebido->(Tran(VlrPag,"@E 9,999,999,999.99")))
	Write( 19 , 11 ,	"Obs......: " + Recebido->Obs )
	Read
	if LastKey() = ESC
		DbClearFilter()
		ResTela( cScreen )
		Exit
	endif
	cCodi 	:= Recebido->Codi
	cTipo 	:= Recebido->Tipo
	cDocnr	:= Recebido->Docnr
	cNossoNr := Recebido->NossoNr
	cBordero := Recebido->Bordero
	dEmis 	:= Recebido->Emis
	dVcto 	:= Recebido->Vcto
	cPort 	:= Recebido->Port
	nVlr		:= Recebido->Vlr
	nJuro 	:= Recebido->Juro
	nVlrAnt	:= Recebido->Vlr
	nVlrPag	:= Recebido->VlrPag
	cFatura	:= Recebido->Fatura
	dDataPag := Recebido->DataPag
	cObs		:= Recebido->Obs

	@ 07 , 22 Get cCodi	  Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
	@ 08 , 22 Get cTipo	  Pict "@!"
	@ 09 , 22 Get cDocnr   Pict "@!"
	@ 10 , 22 Get cNossoNr Pict "@!"
	@ 11 , 22 Get cBordero Pict "@!"
	@ 12 , 22 Get dEmis	  Pict "##/##/##"
	@ 13 , 22 Get dVcto	  Pict "##/##/##"
	@ 14 , 22 Get cPort	  Pict "@!"
	@ 15 , 22 Get nVlr	  Pict "@E 9,999,999,999.99"
	@ 16 , 22 Get nJuro	  Pict "999.99"
	@ 17 , 22 Get dDataPag Pict "##/##/##"
	@ 18 , 22 Get nVlrPag  Pict "@E 9,999,999,999.99"
	@ 19 , 22 Get cObs	  Pict "@!"
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		Loop
	endif
	ErrorBeep()
	if Conf( "Confirma Alteracao Do Registro ?" )
		if Recebido->(TravaReg())
			Recebido->Codi 	 := cCodi
			Recebido->Docnr	 := cDocNr
			Recebido->Emis 	 := dEmis
			Recebido->Emis 	 := dEmis
			Recebido->Port 	 := cPort
			Recebido->Vcto 	 := dVcto
			Recebido->Vlr		 := nVlr
			Recebido->Tipo 	 := cTipo
			Recebido->NossoNr  := cNossoNr
			Recebido->Bordero  := cBordero
			Recebido->Juro 	 := nJuro
			Recebido->VlrPag	 := nVlrPag
			Recebido->DataPag  := dDataPag
			Recebido->Obs		 := cObs
			Recebido->(Libera())
		endif
	endif
	ResTela( cScreen )
EndDo

*:==================================================================================================================================

Function RecebiErrado( Var )
***************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Area("Recebido")
Recebido->(Order( RECEBIDO_DOCNR ))
Recebido->(DbGoTop())
if Recebido->(Eof())
	AreaAnt( Arq_Ant, Ind_Ant )
	Nada()
	return( FALSO )
endif
if !( DbSeek( Var ) )
	DbGoTop()
	Escolhe( 03, 01, 22, "Docnr + '? + Receber->Nome", "DOCTO N? NOME DO CLIENTE" )
	Var := Docnr
endif
AreaAnt( Arq_Ant, Ind_Ant )
if Empty( Var )
	return( FALSO )
endif
return( OK )

*:==================================================================================================================================

def IsString(xVar)
   return(valtype(xVar) == "C") 
endef

*:==================================================================================================================================

Proc Lancamentos(cCaixa)
************************
LOCAL cScreen	  := SaveScreen()
LOCAL aMenuArray := { " Normal ", " Fechamento Futuro " }
LOCAL nChoice	  := 0

oMenu:Limpa()
WHILE OK
	M_Title( "INCLUIR OS TITULOS COMO ?" )
	nChoice := FazMenu( 02, 10, aMenuArray, Cor())
	Do Case
		Case nChoice = 0
			ResTela( cScreen )
			Exit
	  Case nChoice = 1
			ReceNormal(OK, cCaixa)
	  Case nChoice = 2
			ReceNormal(FALSO, cCaixa)
	  EndCase
EndDo

*:==================================================================================================================================

Function ReceNormal( lTipo, cCaixa, xDados, cObs )
**************************************************
LOCAL cScreen	  := SaveScreen()
LOCAL GetList	  := {}
LOCAL cCodi 	  := Space(05)
LOCAL dUltCompra := Date()
LOCAL nCotacao   := 0
LOCAL cDolar	  := "R"
LOCAL aRecno	  := {}
LOCAL cCond      := nil
LOCAL cFatura    := nil
LOCAL aMenu      := {"Promissoria Papel Branco", "Promissoria Papel Continuo", "Duplicata Form Branco","Duplicata Form Personalizado","Boleto Bancario"}
LOCAL PIC_OBS    := iif(MaxCol() <= 80, "@!S40", "@!")

WHILE OK
	Area("Receber")
	Receber->(Order( RECEBER_CODI ))
	oMenu:Limpa()
	if xDados != NIL
	   lSair := OK
		cCodi := xDados[1]
		nVlr	:= xDados[2]
		if !RecErrado( @cCodi ) .AND. !VerificaPosicao( cCodi, cCond, cFatura)
         return Nil		
      endif		
	else
		lSair  := FALSO
		cCodi  := Space(05)
		nVlr	 := 0
		MaBox( 05 , 10 , 07 , MaxCol()-13 )
		@ 06 , 11 Say	"Cliente.:" Get cCodi Pict "99999" Valid RecErrado( @cCodi ) .AND. VerificaPosicao( cCodi, cCond, cFatura)
		Read
		if LastKey() = ESC
			return( ResTela( cScreen))
		endif
	endif
	cNome 	 := Receber->Nome
	cEnde 	 := Receber->Ende
	nRecoCli  := Receber->(Recno())
	cRegiao	 := Receber->Regiao
	cTipo 	 := "NP      "
	dVcto 	 := Date() 
   nJuro     := oAmbiente:aSciArray[1,SCI_JUROMESSIMPLES]
	cPort 	 := "CARTEIRA  "
	cNosso	 := Space( 13 )
	cBorde	 := Space( 09 )	
	dEmis 	 := Date()
	cDolar	 := "R"
   
   

	WHILE OK
		Nota->(Order( NATURAL ))
		Nota->(DbGoBottom())
		cDocnr := Nota->(StrZero(Id + 1, 7 )) + "-A"
      
      if !IsNil(cObs)
         if IsString(cObs)
            cObs += Space(1) + cDocnr
            cObs += space(80-len(cObs))         
         endif         
      endif            
      hb_default(@cObs, "(escreva at‚ 80 letras - CTRL + Y apaga linha)" + space(80-46))
      
		MaBox( 08 , 10 , 22 , MaxCol()-13 )
		Write( 09 , 11, "Codigo........: " + cCodi )
		Write( 10 , 11, "Cliente.......: " + cNome )
		Write( 11 , 11, "Endereco......: " + cEnde )
		@ 12 , 11 Say	 "Tipo..........:" Get cTipo  Pict "@K!"
		@ 13 , 11 Say	 "Documento n...:" Get cDocnr Pict "@K!"              Valid LastKey()=UP .OR. DocCerto(@cDocnr)
		@ 14 , 11 Say	 "Nosso N.......:" Get cNosso Pict "@K!"
		@ 15 , 11 Say	 "Bordero n.....:" Get cBorde Pict "@K!"
		@ 16 , 11 Say	 "Data Emissao..:" Get dEmis  Pict "##/##/##"
		@ 17 , 11 Say	 "Data Vcto.....:" Get dVcto  Pict "##/##/##"         Valid LastKey()=UP .OR. if((dVcto<dEmis), (ErrorBeep(), Alerta("Erro: Entrada Invalida. Vcto tem que ser maior que Emissao."), FALSO ), OK )
		@ 18 , 11 Say	 "Portador......:" Get cPort  Pict "@K!"            
		@ 19 , 11 Say	 "Valor.........:" Get nVlr   Pict "@E 9999999999.99" Valid LastKey()=UP .OR. if(nVlr == 0,     (ErrorBeep(), Alerta("Erro: Entrada Invalida. Valor zerado fica dificil."),          FALSO ), OK )
		@ 20 , 11 Say	 "Juros Mes.....:" Get nJuro  Pict "999.99"
		@ 21 , 11 Say	 "Observacao....:" Get cObs   Pict PIC_OBS
		
		Read
		if LastKey() = ESC
			Exit
		endif
		nOpcao := Alerta( "Voce Deseja ?", {" Incluir ", " Alterar ", " Sair "})
		if nOpcao = 1 // Incluir
			if !DocCerto( @cDocnr )
				Loop
			endif
			Jdia	:=  Jurodia( nVlr, nJuro )
			if Recemov->(!Incluiu())
				Loop
			endif
			aRecno				  := { Recemov->(Recno()) }
			Recemov->Codi		  := cCodi
			Recemov->Docnr 	  := cDocnr
			Recemov->Emis		  := dEmis
			Recemov->Qtd_D_Fatu := 1
			Recemov->Caixa 	  := cCaixa
			Recemov->Vcto		  := dVcto
			Recemov->Vlr		  := nVlr
			Recemov->Port		  := cPort
			Recemov->Tipo		  := cTipo
			Recemov->NossoNr	  := cNosso
			Recemov->Juro		  := nJuro
			Recemov->Bordero	  := cBorde
			Recemov->Jurodia	  := Jdia
			Recemov->Regiao	  := cRegiao
			Recemov->Fatura	  := Left( cDocnr, 7)
			Recemov->VlrFatu	  := nVlr
			Recemov->VlrDolar   := nVlr
			Recemov->Titulo	  := if( lTipo, OK, FALSO )
			Recemov->Obs        := cObs			
			Recemov->(Libera())

			if ( Receber->(Order( RECEBER_CODI )), Receber->( DbSeek( cCodi )))
				if Receber->UltCompra < dEmis
					if Receber->(TravaReg())
						Receber->UltCompra := dEmis
						Receber->(Libera())
					endif
				endif
			endif			
			if Nota->(!Incluiu())
				Loop
			endif
			aRecno				  := { Recemov->(Recno()) }
			Nota->Numero        := Left(cDocnr,7)
			Nota->Data   		  := Date()
			Nota->Situacao      := "RECEBER"
			Nota->Caixa         := cCaixa
			Nota->Codi		     := cCodi
			Nota->(Libera())
			
			WHILE OK
				oMenu:Limpa()
				ErrorBeep()
				M_Title("LANCAMENTO EFETUDO COM SUCESSO. DESEJA IMPRIMIR ?")
				nEscolha := FazMenu( 10, 10, aMenu )
				Do Case
				Case nEscolha = 0
					lSair := OK
					if xDados != NIL
					   return( ResTela( cScreen))
					endif
					Exit
				Case nEscolha = 1
               ProBranco( cCodi, aRecno )
				Case nEscolha = 2
               ProPersonalizado( cCodi, aRecno )
				Case nEscolha = 3
					DupPapelBco( cCodi, aRecno )
				Case nEscolha = 4
               DupPersonalizado( cCodi, aRecno )
				Case nEscolha = 3
					DiretaLivre( cCodi, aRecno )				
				EndCase
			EndDo

		elseif nOpcao = 2 // Alterar
			Loop

		elseif nOpcao = 3  // Sair
			lSair := OK
			Exit

		endif
	EndDo
	if lSair
		ResTela( cScreen )
		Exit
	endif
EndDo
return nil

*:==================================================================================================================================

Proc MenuDuplicata()
********************
LOCAL cScreen	:= SaveScreen()
LOCAL aData 	:= {}
LOCAL aValor	:= {}
LOCAL aConta	:= {}
LOCAL nRegis	:= 0
LOCAL nPosicao := 0
LOCAL nTamanho := 0
LOCAL dIni		:= Date()-30
LOCAL dFim		:= Date()
LOCAL aMenu    := {"Formulario Branco", "Formulario Personalizado"}
LOCAL oBloco1
LOCAL oBloco2

WHILE OK
   M_Title( "IMPRESSAO DUPLICATA")
   nChoice := FazMenu( 05, 10, aMenu, Cor() )
   Do Case
   Case nChoice = 0
      ResTela( cScreen )
      return
   Case nChoice = 1
     DupPapelBco()
   Case nChoice = 2
      DupPersonalizado()
   EndCase
BEGOUT

*:==================================================================================================================================

Proc MenuPromissoria()
**********************
LOCAL cScreen	:= SaveScreen()
LOCAL aData 	:= {}
LOCAL aValor	:= {}
LOCAL aConta	:= {}
LOCAL nRegis	:= 0
LOCAL nPosicao := 0
LOCAL nTamanho := 0
LOCAL dIni		:= Date()-30
LOCAL dFim		:= Date()
LOCAL aMenu    := {"Formulario Branco", "Formulario Personalizado"}
LOCAL oBloco1
LOCAL oBloco2

WHILE OK   
   M_Title( "IMPRESSAO PROMISSORIA")
   nChoice := FazMenu( 05, 10, aMenu, Cor() )
   Do Case
   Case nChoice = 0
      ResTela( cScreen )
      return
   Case nChoice = 1
     ProBranco()
   Case nChoice = 2
      ProPersonalizado()
   EndCase
BEGOUT

*:==================================================================================================================================

Proc Fluxo()
************
LOCAL cScreen	:= SaveScreen()
LOCAL aData 	:= {}
LOCAL aValor	:= {}
LOCAL aConta	:= {}
LOCAL nRegis	:= 0
LOCAL nPosicao := 0
LOCAL nTamanho := 0
LOCAL dIni		:= Date()-30
LOCAL dFim		:= Date()
LOCAL aMenu 	:= {"Por Vcto", "Por Emissao", "Geral"}
LOCAL oBloco1
LOCAL oBloco2

M_Title( "FLUXO SINTETICO")
nChoice := FazMenu( 03, 20, aMenu, Cor() )
Do Case
Case nChoice = 0
	ResTela( cScreen )
	return
Case nChoice = 1
	MaBox( 13 , 18 , 16, 50 )
	@ 14, 19 Say  "Data Vcto Inicial..:" Get dIni    Pict "##/##/##"
	@ 15, 19 Say  "Data Vcto Final....:" Get dFim    Pict "##/##/##"
	oBloco1 := {|| Recemov->Vcto >= dIni .AND. Recemov->Vcto <= dFim }
Case nChoice = 2
	MaBox( 13 , 18 , 16, 50 )
	@ 14, 19 Say  "Data Emis Inicial..:" Get dIni    Pict "##/##/##"
	@ 15, 19 Say  "Data Emis Final....:" Get dFim    Pict "##/##/##"
	oBloco2 := {|| Recemov->Emis >= dIni .AND. Recemov->Emis <= dFim }
EndCase
Read
if LastKey() = ESC
	ResTela( cScreen )
	return
endif
oMenu:Limpa()
Area("ReceMov")
Recemov->(Order( RECEMOV_VCTO ))
Recemov->(DbGoTop())
Mensagem("Aguarde, Processando. ESC Interrompe.")
nRegis := Lastrec()
WHILE !Eof() .AND. Rep_Ok()
	if nChoice = 1
		if !Eval( oBloco1 )
			Recemov->(DbSkip(1))
			Loop
		endif
	endif
	if nChoice = 2
		if !Eval( oBloco2 )
			Recemov->(DbSkip(1))
			Loop
		endif
	endif
	if ( nPosicao := Ascan( aData, Recemov->Vcto )) = 0
		Aadd( aData,  Recemov->Vcto )
		Aadd( aValor, Recemov->Vlr )
		Aadd( aConta, 1 )
	else
		aValor[ nPosicao ] += Recemov->Vlr
		aConta[ nPosicao ]++
	endif
	Recemov->(DbSkip( 1 ))
EndDo
if ( nTamanho := Len( aData )) = 0
	NaoTem()
	Restela( cScreen )
	return
endif
oMenu:Limpa()
if InsTru80()
	ImprimirFluxo( aData, aValor, aConta, SISTEM_NA3 )
endif
ResTela( cScreen )
return

*:==================================================================================================================================

Proc ImprimirFluxo( aData, aValor, aConta, cSistema )
*****************************************************
LOCAL cScreen	:= SaveScreen()
LOCAL nTamanho := Len( aData )
LOCAL nTotal	:= ATotal( aValor )
LOCAL nConta	:= ATotal( aConta )
LOCAL Tam		:= 80
LOCAL Col		:= 58
LOCAL Pagina	:= 0
LOCAL Relato	:= "FLUXO SINTETICO DE VENCIMENTOS"
LOCAL ContaFor := 0

PrintOn()
SetPrc( 0 , 0 )
FOR ContaFor := 1 To nTamanho
	if Col >= 57
		Write( 00, 00, Padr( "Pagina N?" + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
		Write( 01, 00, Date() )
      Write( 02, 00, Padc( AllTrim(oAmbiente:xNomefir), Tam ) )
		Write( 03, 00, Padc( cSistema, Tam ) )
		Write( 04, 00, Padc( Relato, Tam ) )
		Write( 05, 00, Repl( SEP, Tam ) )
		Write( 06, 00, "VCTO      QTD                                                          VALOR R$")
		Write( 07, 00, Repl( SEP, Tam ) )
		Col := 8
	endif
	Qout( aData[ ContaFor ], Tran( aConta[ContaFor],"9999"), Repl(".", 48 ), Tran( aValor[ ContaFor ],"@E 9,999,999,999.99"))
	Col++
	if Col >= 57
		Write( ++Col, 0, Repl( SEP , Tam ) )
		__Eject()
	endif
Next
Write( ++Col, 00, "*Total*" )
Write(	Col, 09, Tran( nConta, "99999"))
Write(	Col, 62, Tran( nTotal, "@E 999,999,999,999.99" ) )
__Eject()
PrintOff()
ResTela( cScreen )
return

*:==================================================================================================================================

Proc CobTitulo()
****************
LOCAL cScreen	  := SaveScreen()
LOCAL aMenuArray := { "Individual", "Geral" }
LOCAL nChoice	  := 0
LOCAL xDbf		  := FTempName("t*.tmp")
LOCAL dIni		  := Date()-30
LOCAL dFim		  := Date()
LOCAL cCodi
FIELD Codi
FIELD Vcto

WHILE OK
	M_Title("CARTA DE COBRANCA")
	nChoice := FazMenu( 03 , 10, aMenuArray, Cor() )
	Do Case
	Case nChoice  = 0
		ResTela( cScreen )
		return

	Case nChoice  = 1
		cCodi := Space(05)
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 09 , 10, 13 , 36 )
		@ 10, 11 Say  "Cliente......:" Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi )
		@ 11, 11 Say  "Vcto Inicial.:" Get dIni  Pict "##/##/##"
		@ 12, 11 Say  "Vcto Final...:" Get dFim  Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen	)
			Loop
		endif
		Area("ReceMov")
		Recemov->(Order( RECEMOV_CODI ))
		if Recemov->(!DbSeek( cCodi ))
			ErrorBeep()
			Nada()
			ResTela( cScreen )
			Loop
		endif
		Copy Stru To ( xDbf )
		Use (xDbf) Exclusive Alias xTemp New
		WHILE Recemov->Codi = cCodi
			if Recemov->Vcto >= dIni .AND. Recemov->Vcto <= dFim
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Recemov->(FieldGet( nField ))))
				Next
			endif
			Recemov->(DbSkip(1))
		EndDo
		Receber->( Order( RECEBER_CODI ))
		xTemp->(DbGoTop())
		Set Rela To xTemp->Codi Into Receber
		xTemp->(DbGoTop())
		Prn006()
		xTemp->(DbClearRel())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( xDbf )
		ResTela( cScreen )
		Loop

	Case nChoice  = 2
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 09 , 10, 12 , 36 )
		@ 10, 11 Say  "Vcto Inicial.:" Get dIni  Pict "##/##/##"
		@ 11, 11 Say  "Vcto Final...:" Get dFim  Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen	)
			Loop
		endif
		Area("ReceMov")
		Recemov->(Order( RECEMOV_CODI ))
		Copy Stru To ( xDbf )
		Use (xDbf) Exclusive Alias xTemp New
		WHILE Recemov->( !Eof())
			if Recemov->Vcto >= dIni .AND. Recemov->Vcto <= dFim
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Recemov->(FieldGet( nField ))))
				Next
			endif
			Recemov->(DbSkip(1))
		EndDo
		Receber->( Order( RECEBER_CODI ))
		xTemp->(DbGoTop())
		Set Rela To xTemp->Codi Into Receber
		xTemp->(DbGoTop())
		Prn006()
		xTemp->(DbClearRel())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( xDbf )
		ResTela( cScreen )
		Loop

	EndCase
EndDo

*:==================================================================================================================================

Proc Prn006()
*************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL lSair 	 := FALSO
LOCAL NovoNome  := OK
LOCAL Files 	 := "*.DOC"
LOCAL Arquivo	 := "COBRANCA.DOC"
LOCAL nAtraso	 := 0
LOCAL Total 	 := 0
LOCAL TotJur	 := 0
LOCAL nVlrAtual := 0
LOCAL nCarencia := 0
LOCAL nRow		 := 0
LOCAL lTitulo	 := FALSO
LOCAL Imprime
LOCAL UltNome
LOCAL Col
LOCAL Campo
LOCAL Linha
LOCAL Linhas
FIELD Codi
FIELD Vcto
FIELD Vlr
FIELD Docnr
FIELD Emis
FIELD Juro
FIELD Cida
FIELD JuroDia

MaBox( 14 , 10 , 16 , 53 )
@ 15 , 11 Say	"Arquivo Carta de Cobran‡a.:" Get Arquivo Pict "@!"
Read
if LastKey() = ESC
	ResTela( cScreen )
	return
endif
ErrorBeep()
lTitulo := Conf("Pergunta: Imprimir relacao dos titulos em atraso na carta?")
if LastKey() = ESC
	ResTela( cScreen )
	return
endif
FChDir( oAmbiente:xBaseDoc )
Set Defa To ( oAmbiente:xBaseDoc )
if Empty( Arquivo )
	M_Title( "Setas CIMA/BAIXO Move")
	//Arquivo := Mx_PopFile( 17, 10, 23, 61, Files, Cor())
	if Empty( Arquivo )
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ErrorBeep()
		ResTela( cScreen )
		return
  endif
else
	if !File( Arquivo )
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ErrorBeep()
		ResTela( cScreen )
		Alert( Rtrim( Arquivo ) + " Nao Encontrado... " )
		ResTela( cScreen )
		return
	endif
endif
if !InsTru80()
	FChDir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen	)
	return
endif
oMenu:Limpa()
Mensagem("Aguarde, Imprimindo. ESC Cancela.")
UltNome	:= Receber->Nome
PrintOn()
SetPrc( 0 , 0 )
WHILE !Eof() .AND. Rel_Ok()
	nAtraso	 := Atraso( Date(), Vcto )
	nCarencia := Carencia( Date(), Vcto )
	if nAtraso <= 0
		TotJur := 0
	else
		TotJur := ( Jurodia * nCarencia )
	endif
	nVlrAtual := ( TotJur + Vlr )
	if NovoNome
		NovoNome := FALSO
		Total := 0
		Write( 02 , 0, DataExt( Date()))
		Write( 06 , 0, "A" )
		Write( 07 , 0, NG + Receber->Nome + NR )
		Write( 08 , 0, Receber->Ende )
		Write( 09 , 0, Receber->Bair )
		Write( 10 , 0, LIGSUB + Receber->Cep + "/" + Receber->( Rtrim( Cida ) ) + "/" + Receber->Esta + DESSUB )
		Campo  := MemoRead( Arquivo )
		Linhas := MlCount( Campo , 80 )
		FOR Linha  :=	1 To Linhas
			Imprime :=	MemoLine( Campo , 80 , Linha )
			Write( 15 + Linha -1 , 0, Imprime )
		Next
		if lTitulo
			Write( 46 , 0 , "DOCTO N? VENCTO  ATRASO   VALOR ATUAL    DOCTO N? VENCTO  ATRASO   VALOR ATUAL")
			Qout(Repl(SEP,80))
		endif
		Col := 48
	endif
	if nRow = 0
		if lTitulo
			Qout( Docnr, Vcto, Tran(nAtraso,'99999'),Tran(nVlrAtual, "99,999,999.99"))
		endif
		nRow = 40
	else
		if lTitulo
			QQout(Space(3), Docnr, Vcto, Tran(nAtraso,'99999'),Tran(nVlrAtual, "99,999,999.99"))
		endif
		nRow := 0
		Col++
	endif
	UltNome := Receber->Nome
	Total   += nVlrAtual
	DbSkip(1)
	if Col >= 55 .OR. UltNome != Receber->Nome .OR. Eof()
		NovoNome := OK
		if lTitulo
			Qout()
			Qout(" ** Total a Pagar **", Space(12),Tran(Total,"@E 99,999,999.99"))
			Qout(Repl(SEP,80))
		endif
		__Eject()
	endif
EndDo
PrintOff()
FChDir( oAmbiente:xBaseDados )
Set Defa To ( oAmbiente:xBaseDados )
ResTela( cScreen )
return

*:==================================================================================================================================

Function AchaPortador( cPortador )
**********************************
Recebido->(Order( RECEBIDO_PORT ))
if Recebido->(!DbSeek( cPortador ))
	ErrorBeep()
	Alert("Erro: Portador nao localizado.")
	return( FALSO )
endif
return( OK )

*:----------------------------------------------------------------------------

Function DocCerto( cDocNr )
***************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
if LastKey() = UP
	return( OK )
endif
if Empty( cDocNr )
	ErrorBeep()
	Alerta( "Erro: Numero Documento Invalido...")
	return( FALSO )
endif
Area("ReceMov")
Recemov->(Order( RECEMOV_DOCNR ))
Recemov->(DbGoTop())
if Recemov->(DbSeek( cDocNr ))
	ErrorBeep()
	Alerta("Erro: Numero Documento Ja Registrado ou,; Incluido por outra Estacao...")
	cDocnr := StrZero( Val( cDocnr ) + 1, 9 )
	AreaAnt( Arq_Ant, Ind_Ant )
	return( FALSO )
endif
AreaAnt( Arq_Ant, Ind_Ant )
return( OK )

//:---------------------------------------------------------------------------------------------------------------------------------

Proc PrnAlfabetica( nVctoOuEmis )
*********************************
LOCAL cScreen		:= SaveScreen()
LOCAL xAlfa 		:= FTempName()
LOCAL aMenuArray	:= {"Por Regiao", "Por Periodo *", "Por Tipo", "Individual", "Por Portador"}
LOCAL nField		:= 0
LOCAL nChoice		:= 0
LOCAL lSair 		:= FALSO
LOCAL Tam			:= CPI1280
LOCAL Col			:= 8
LOCAL Pagina		:= 0
LOCAL cNome 		:= Space(0)
LOCAL nTotal		:= 0
LOCAL nTotalDolar := 0
LOCAL nTotalAtual := 0
LOCAL nQtdDoc		:= 0
LOCAL cTitle		:= if( nVctoOuEmis == 1, 'VCTO : ', 'EMISSAO : ') + 'ORDEM ALFABETICA'
LOCAL cTitulo		:= if( nVctoOuEmis == 1, 'VENCIMENTO : ', 'EMISSAO : ')
LOCAL nRolRecemov := oIni:ReadInteger('relatorios', 'rolrecemov', 2 )
LOCAL cCodi 		:= ''
LOCAL cPortador	:= ''
LOCAL cFatura
LOCAL Titulo
LOCAL UltCodi
LOCAL dIni
LOCAL dFim
LOCAL bBloco
LOCAL cTipo
LOCAL aStru
LOCAL lMarcado

ErrorBeep()
lMarcado := Conf('Pergunta: Incluir no relatorio os marcados ?')
WHILE OK
	M_Title( cTitle )
	nChoice := FazMenu( 05, 22, aMenuArray, Cor())
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		return

	Case nChoice = 1
		cRegiao := Space(2)
		dIni	  := Date() - 30
		dFim	  := Date()
		MaBox( 17, 10, 21, 35 )
		@ 18, 11 Say "Regiao.....: " Get cRegiao Pict "99" Valid RegiaoErrada( @cRegiao )
		@ 19, 11 Say "Data Ini...: " Get dIni    Pict "##/##/##"
		@ 20, 11 Say "Data Fim...: " Get dFim    Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Regiao->(Order( REGIAO_REGIAO ))
		if Regiao->(DbSeek( cRegiao))
			cNome := Regiao->Nome
		endif
		cIni	 := Dtoc( dIni )
		cFim	 := Dtoc( dFim )
		Titulo := "ROL DE TITULOS A RECEBER DA REGIAO " + AllTrim( cNome ) + " REF. &cIni. A &cFim."
		Mensagem("Aguarde... ")
		Saidas->(Order( SAIDAS_FATURA ))
		Receber->(Order( RECEBER_CODI ))
		Area("Recemov")
		Recemov->(Order( RECEMOV_REGIAO ))
		if Recemov->(!DbSeek( cRegiao ))
			ErrorBeep()
			Alerta('Erro: Regiao nao localizada.')
			ResTela( cScreen )
			Loop
		endif
		aStru := Recemov->(DbStruct())
		Aadd( aStru, {"NOME",  "C", 40, 0})
		DbCreate( xAlfa, aStru )
		Use (xAlfa) Alias xTemp Exclusive New
		While Recemov->Regiao = cRegiao
			if !lMarcado
				if Receber->(DbSeek( Recemov->Codi ))
					if Receber->Rol = OK
						Recemov->(DbSkip(1))
						Loop
					endif
				endif
			endif
			if nVctoOuEmis == 1 // Vcto
				if Recemov->Vcto >= dIni .AND. Recemov->Vcto <= dFim
					if nRolRecemov = 2
						cFatura := Recemov->Fatura
						if Saidas->(DbSeek( cFatura ))
							if !Saidas->Impresso
								Recemov->(DbSkip(1))
								Loop
							endif
						endif
					endif
					xTemp->(DbAppend())
					cCodi := Recemov->Codi
					For nField := 1 To Recemov->(FCount())
						xTemp->(FieldPut( nField, Recemov->(FieldGet( nField ))))
					Next
					Receber->(DbSeek( cCodi ))
					xTemp->Nome := Receber->Nome
				endif
			 else
				if Recemov->Emis >= dIni .AND. Recemov->Emis <= dFim
					xTemp->(DbAppend())
					cCodi := Recemov->Codi
					For nField := 1 To Recemov->(FCount())
						xTemp->(FieldPut( nField, Recemov->(FieldGet( nField ))))
					Next
					Receber->(DbSeek( cCodi ))
					xTemp->Nome := Receber->Nome
				 endif
			 endif
			 Recemov->(DbSkip(1))
		EndDo
		PrnAlfaPrint( Titulo )
		xTemp->(DbCloseArea())
		Ferase( xAlfa )
		ResTela( cScreen )
		Loop

	Case nChoice = 2
		dIni := Date()-30
		dFim := Date()
		MaBox( 17, 10, 20, 35 )
		@ 18, 11 Say "Data Ini...: " Get dIni Pict "##/##/##" Valid if( nVctoOuEmis == 1, AchaVcto( @dIni ), AchaEmis( @dIni ))
		@ 19, 11 Say "Data Fim...: " Get dFim Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		cIni	 := Dtoc( dIni )
		cFim	 := Dtoc( dFim )
		Titulo := "ROL DE TITULOS A RECEBER COM " + cTitulo + " DE &cIni. A &cFim."
		Mensagem("Aguarde... ")
		Saidas->(Order( SAIDAS_FATURA ))
		Receber->(Order( RECEBER_CODI ))
		Area("Recemov")
		if nVctoOuEmis == 1
			Recemov->(Order( RECEMOV_VCTO ))
		else
			Recemov->(Order( RECEMOV_EMIS ))
		endif
		if Recemov->(!DbSeek( dIni ))
			ErrorBeep()
			Alerta('Erro: Data Emissao Inicial nao localizada.')
			ResTela( cScreen )
			Loop
		endif
		aStru := Recemov->(DbStruct())
		Aadd( aStru, {"NOME",  "C", 40, 0})
		DbCreate( xAlfa, aStru )
		Use (xAlfa) Alias xTemp Exclusive New
		if nVctoOuEmis == 1 // Vcto
			While Recemov->Vcto >= dIni .AND. Recemov->Vcto <= dFim
				if !lMarcado
					if Receber->(DbSeek( Recemov->Codi ))
						if Receber->Rol = OK
							Recemov->(DbSkip(1))
							Loop
						endif
					endif
				endif
				if nRolRecemov = 2
					cFatura := Recemov->Fatura
					if Saidas->(DbSeek( cFatura ))
						if !Saidas->Impresso
							Recemov->(DbSkip(1))
							Loop
						endif
					endif
				endif
				xTemp->(DbAppend())
				cCodi := Recemov->Codi
				For nField := 1 To Recemov->(FCount())
					xTemp->(FieldPut( nField, Recemov->(FieldGet( nField ))))
				Next
				Receber->(DbSeek( cCodi ))
				xTemp->Nome := Receber->Nome
				Recemov->(DbSkip(1))
			EndDo
		else
			While Recemov->Emis >= dIni .AND. Recemov->Emis <= dFim
				if !lMarcado
					if Receber->(DbSeek( Recemov->Codi ))
						if Receber->Rol = OK
							Recemov->(DbSkip(1))
							Loop
						endif
					endif
				endif
				xTemp->(DbAppend())
				cCodi := Recemov->Codi
				For nField := 1 To Recemov->(FCount())
					xTemp->(FieldPut( nField, Recemov->(FieldGet( nField ))))
				Next
				Receber->(DbSeek( cCodi ))
				xTemp->Nome := Receber->Nome
				Recemov->(DbSkip(1))
			EndDo
		endif
		PrnAlfaPrint( Titulo )
		xTemp->(DbCloseArea())
		Ferase( xAlfa )
		ResTela( cScreen )
		Loop

	Case nChoice = 3
		cTipo := Space(06)
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 17, 10, 21, 35 )
		@ 18, 11 Say "Tipo.......: " Get cTipo Pict "@!" Valid AchaTipo( cTipo )
		@ 19, 11 Say "Data Ini...: " Get dIni  Pict "##/##/##"
		@ 20, 11 Say "Data Fim...: " Get dFim  Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Titulo := "ROL DE TITULOS A RECEBER TIPO " + cTipo
		Mensagem("Aguarde... ")
		Saidas->(Order( SAIDAS_FATURA ))
		Receber->(Order( RECEBER_CODI ))
		Area("Recemov")
		Recemov->(Order( RECEMOV_TIPO_CODI ))
		if Recemov->(!DbSeek( cTipo ))
			ErrorBeep()
			Alerta('Erro: Tipo nao localizado.')
			ResTela( cScreen )
			Loop
		endif
		aStru := Recemov->(DbStruct())
		Aadd( aStru, {"NOME",  "C", 40, 0})
		DbCreate( xAlfa, aStru )
		Use (xAlfa) Alias xTemp Exclusive New
		While Recemov->Tipo = cTipo
			if !lMarcado
			  if Receber->(DbSeek( Recemov->Codi ))
					if Receber->Rol = OK
						Recemov->(DbSkip(1))
						Loop
					endif
				endif
			endif
			if nVctoOuEmis == 1 // Vcto
				if Recemov->Vcto >= dIni .AND. Recemov->Vcto <= dFim
					if nRolRecemov = 2
						cFatura := Recemov->Fatura
						if Saidas->(DbSeek( cFatura ))
							if !Saidas->Impresso
								Recemov->(DbSkip(1))
								Loop
							endif
						endif
					endif
					xTemp->(DbAppend())
					cCodi := Recemov->Codi
					For nField := 1 To Recemov->(FCount())
						xTemp->(FieldPut( nField, Recemov->(FieldGet( nField ))))
					Next
					Receber->(DbSeek( cCodi ))
					xTemp->Nome := Receber->Nome
				endif
			 else
				if Recemov->Emis >= dIni .AND. Recemov->Emis <= dFim
					xTemp->(DbAppend())
					cCodi := Recemov->Codi
					For nField := 1 To Recemov->(FCount())
						xTemp->(FieldPut( nField, Recemov->(FieldGet( nField ))))
					Next
					Receber->(DbSeek( cCodi ))
					xTemp->Nome := Receber->Nome
				 endif
			 endif
			 Recemov->(DbSkip(1))
		EndDo
		PrnAlfaPrint( Titulo )
		xTemp->(DbCloseArea())
		Ferase( xAlfa )
		ResTela( cScreen )
		Loop

	Case nChoice = 4
		cCodi := Space(05)
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 17, 10, 21, 32 )
		@ 18, 11 Say "Cliente...: " Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi )
		@ 19, 11 Say "Data Ini..: " Get dIni  Pict "##/##/##"
		@ 20, 11 Say "Data Fim..: " Get dFim  Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Titulo := "ROL DE TITULOS A RECEBER DO CLIENTE " + Receber->(Trim( Nome))
		Mensagem("Aguarde... ")
		Saidas->(Order( SAIDAS_FATURA ))
		Receber->(Order( RECEBER_CODI ))
		Area("Recemov")
		Recemov->(Order( RECEMOV_CODI ))
		if Recemov->(!DbSeek( cCodi ))
			ErrorBeep()
			Alerta('Erro: Movimento do Cliente nao localizado.')
			ResTela( cScreen )
			Loop
		endif
		aStru := Recemov->(DbStruct())
		Aadd( aStru, {"NOME",  "C", 40, 0})
		DbCreate( xAlfa, aStru )
		Use (xAlfa) Alias xTemp Exclusive New
		While Recemov->Codi = cCodi
			if !lMarcado
			  if Receber->(DbSeek( Recemov->Codi ))
					if Receber->Rol = OK
						Recemov->(DbSkip(1))
						Loop
					endif
				endif
			endif
			if nVctoOuEmis == 1 // Vcto
				if Recemov->Vcto >= dIni .AND. Recemov->Vcto <= dFim
					if nRolRecemov = 2
						cFatura := Recemov->Fatura
						if Saidas->(DbSeek( cFatura ))
							if !Saidas->Impresso
								Recemov->(DbSkip(1))
								Loop
							endif
						endif
					endif
					xTemp->(DbAppend())
					cCodi := Recemov->Codi
					For nField := 1 To Recemov->(FCount())
						xTemp->(FieldPut( nField, Recemov->(FieldGet( nField ))))
					Next
					Receber->(DbSeek( cCodi ))
					xTemp->Nome := Receber->Nome
				 endif
			 else
				if Recemov->Emis >= dIni .AND. Recemov->Emis <= dFim
					xTemp->(DbAppend())
					cCodi := Recemov->Codi
					For nField := 1 To Recemov->(FCount())
						xTemp->(FieldPut( nField, Recemov->(FieldGet( nField ))))
					Next
					Receber->(DbSeek( cCodi ))
					xTemp->Nome := Receber->Nome
				 endif
			 endif
			 Recemov->(DbSkip(1))
		EndDo
		PrnAlfaPrint( Titulo )
		xTemp->(DbCloseArea())
		Ferase( xAlfa )
		ResTela( cScreen )
		Loop

	Case nChoice = 5
		cPortador := Space(10)
		dIni		 := Date()-30
		dFim		 := Date()
		MaBox( 17, 10, 21, 40 )
		@ 18, 11 Say "Portador...: " Get cPortador Pict "@!"
		@ 19, 11 Say "Data Ini...: " Get dIni      Pict "##/##/##" Valid if( nVctoOuEmis == 1, AchaVcto( @dIni ), AchaEmis( @dIni ))
		@ 20, 11 Say "Data Fim...: " Get dFim      Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Titulo := "ROL DE TITULOS A RECEBER DO PORTADOR " + cPortador
		Mensagem("Aguarde... ")
		Saidas->(Order( SAIDAS_FATURA ))
		Receber->(Order( RECEBER_CODI ))
		Area("Recemov")
		if nVctoOuEmis == 1
			Recemov->(Order( RECEMOV_VCTO ))
		else
			Recemov->(Order( RECEMOV_EMIS ))
		endif
		if Recemov->(!DbSeek( dIni ))
			ErrorBeep()
			Alerta('Erro: Data Emissao Inicial nao localizada.')
			ResTela( cScreen )
			Loop
		endif
		aStru := Recemov->(DbStruct())
		Aadd( aStru, {"NOME",  "C", 40, 0})
		DbCreate( xAlfa, aStru )
		Use (xAlfa) Alias xTemp Exclusive New
		if nVctoOuEmis == 1
			While Recemov->Emis >= dIni .AND. Recemov->Emis <= dFim
				if !lMarcado
				  if Receber->(DbSeek( Recemov->Codi ))
						if Receber->Rol = OK
							Recemov->(DbSkip(1))
							Loop
						endif
					endif
				endif
				if Recemov->Port = cPortador
					if nRolRecemov = 2
						cFatura := Recemov->Fatura
						if Saidas->(DbSeek( cFatura ))
							if !Saidas->Impresso
								Recemov->(DbSkip(1))
								Loop
							endif
						endif
					endif
					xTemp->(DbAppend())
					cCodi := Recemov->Codi
					For nField := 1 To Recemov->(FCount())
						xTemp->(FieldPut( nField, Recemov->(FieldGet( nField ))))
					Next
					Receber->(DbSeek( cCodi ))
					xTemp->Nome := Receber->Nome
				endif
				Recemov->(DbSkip(1))
			EndDo
		else
			While Recemov->Emis >= dIni .AND. Recemov->Emis <= dFim
				if !lMarcado
				  if Receber->(DbSeek( Recemov->Codi ))
						if Receber->Rol = OK
							Recemov->(DbSkip(1))
							Loop
						endif
					endif
				endif
				if Recemov->Port = cPortador
					xTemp->(DbAppend())
					cCodi := Recemov->Codi
					For nField := 1 To Recemov->(FCount())
						xTemp->(FieldPut( nField, Recemov->(FieldGet( nField ))))
					Next
					Receber->(DbSeek( cCodi ))
					xTemp->Nome := Receber->Nome
				endif
				Recemov->(DbSkip(1))
			EndDo
		endif
		PrnAlfaPrint( Titulo )
		xTemp->(DbCloseArea())
		Ferase( xAlfa )
		ResTela( cScreen )
		Loop
	EndCase
EndDo
ResTela( cScreen )
return

Proc PrnAlfaPrint( cTitulo )
****************************
LOCAL aOrdem	 := {"Nome","Codigo","Documento","Emissao", "Portador", "Tipo", "Valor", "Vencimento *"}
LOCAL xNtx		 := FTempName()
LOCAL cScreen	 := SaveScreen()
LOCAL Tam		 := 132
LOCAL Col		 := 8
LOCAL nQtdDoc	 := 0
LOCAL nTotal	 := 0
LOCAL nAtraso	 := 0
LOCAL nCarencia := 0
LOCAL nJuros	 := 0
LOCAL nTotTit	 := 0
LOCAL nTotJur	 := 0
LOCAL cUltLetra := ''
LOCAL nParcDoc  := 0
LOCAL nParcTit  := 0
LOCAL nParcJur  := 0

WHILE OK
	oMenu:Limpa()
	M_Title("ESCOLHA A ORDEM A IMPRIMIR. ESC RETORNA")
	nOpcao := FazMenu( 05, 10, aOrdem )
	Mensagem("Aguarde, Ordenando.")
	Area("xTemp")
	if nOpcao = 0 // Sair ?
		ResTela( cScreen )
		return
	elseif nOpcao = 1
		 Inde On xTemp->Nome To ( xNtx )
	elseif nOpcao = 2
		 Inde On xTemp->Codi To ( xNtx )
	 elseif nOpcao = 3
		 Inde On xTemp->Docnr To ( xNtx )
	 elseif nOpcao = 4
		 Inde On xTemp->Emis To ( xNtx )
	 elseif nOpcao = 5
		 Inde On xTemp->Port To ( xNtx )
	 elseif nOpcao = 6
		 Inde On xTemp->Tipo To ( xNtx )
	 elseif nOpcao = 7
		 Inde On xTemp->Vlr To ( xNtx )
	 elseif nOpcao = 8
		 Inde On xTemp->Vcto To ( xNtx )
	endif
	xTemp->(DbGoTop())
	Tam		 := 132
	Col		 := 8
	nQtdDoc	 := 0
	nTotal	 := 0
	nAtraso	 := 0
	nCarencia := 0
	nJuros	 := 0
	nTotTit	 := 0
	nTotJur	 := 0
	if !InsTru80() .OR. !LptOk()
		ResTela( cScreen )
		return
	endif
	Mensagem("Aguarde, Imprimindo. ESC Cancela.")
	PrintOn()
	FPrint( PQ )
	SetPrc(0, 0)
	cCabec( cTitulo, Tam )
	WHILE !Eof() .AND. Rel_Ok( )
		if Col >= 57
			__Eject()
			cCabec( cTitulo, Tam )
			Col := 8
		endif
		nAtraso	 := Atraso( Date(), Vcto )
		nCarencia := Carencia( Date(), Vcto )
		nJuros	 := if( nAtraso <=0, 0, JuroDia * nCarencia )
		Qout( Codi, Left( Nome, 35), Tipo, Docnr, Emis, Vcto,;
				Vlr, Tran( Juro, "999.99"), Tran( nAtraso, "99999"),;
				Tran( Jurodia,"99999999.99"), Tran( (Vlr + nJuros), "@E 9,999,999,999.99"))
		nQtdDoc	 ++
		nParcDoc  ++
		cUltLetra := Left(Nome,1)
		nTotTit	 += Vlr
		nParcTit  += Vlr
		nTotJur	 += Vlr + nJuros
		nParcJur  += Vlr + nJuros
		Col++
		DbSkip(1)
		if nOpcao = 1 // Ordem Nome
			if Left(Nome,1) <> cUltLetra
				Qout()
				Col++
				Write( Col, 000, " ** Parcial ** " + Tran( nParcDoc, '99999' ))
				Write( Col, 074, Tran( nParcTit, "@E 9,999,999,999.99") )
				Write( Col, 116, Tran( nParcJur, "@E 9,999,999,999.99") )
				Qout()
				Col		++
				nParcDoc := 0
				nParcTit := 0
				nParcJur := 0
			endif
		endif
		if Col >= 57
		  __Eject()
		  cCabec( cTitulo, Tam )
		  Col := 8
		endif
	EndDo
	Qout()
	Write( ++Col, 000, " ** Total ** " + Tran( nQtdDoc, '99999' ))
	Write(	Col, 074, Tran( nTotTit, "@E 9,999,999,999.99") )
	Write(	Col, 116, Tran( nTotJur, "@E 9,999,999,999.99") )
	__Eject()
	PrintOff()
EndDo
ResTela( cScreen )
return

*:---------------------------------------------------------------------------------------------------------------------------------

Function AchaEmis( dEmis )
**************************
LOCAL cScreen	:= SaveScreen()
LOCAL lRetorno := OK

Recemov->(Order( RECEMOV_EMIS ))
if Recemov->(!DbSeek( dEmis ))
	if Conf("Erro: Data Invalida. Localizar Proxima ?")
		Mensagem(SISTEM_NA1 + ';-;Aguarde, Localizando Proxima Emissao.')
		dEmis ++
		While Recemov->(!DbSeek( dEmis ))
			dEmis ++
			Recemov->(DbSkip(1))
		EndDo
	else
		lRetorno := FALSO
	endif
endif
ResTela( cScreen )
return( lRetorno )

Function AchaVcto( dVcto )
**************************
LOCAL cScreen	:= SaveScreen()
LOCAL lRetorno := OK

Recemov->(Order( RECEMOV_VCTO ))
if Recemov->(!DbSeek( dVcto ))
	if Conf("Erro: Data Invalida. Localizar Proxima ?")
		Mensagem(SISTEM_NA1 + ';-;Aguarde, Localizando Proximo Vcto.')
		dVcto ++
		While Recemov->(!DbSeek( dVcto ))
			dVcto ++
			Recemov->(DbSkip(1))
		EndDo
	else
		lRetorno := FALSO
	endif
endif
ResTela( cScreen )
return( lRetorno )

*:---------------------------------------------------------------------------------------------------------------------------------

Function Calcula( nVlr, nVlrDolar, dEmis, dVcto )
*************************************************
LOCAL nCotacao := 0
LOCAL nRetorno := 0
if dEmis >= dVcto
	if dEmis >= Date()
		return( nVlr )
	else
		if Taxas->(DbSeek( Date()))
			nCotacao := Taxas->Cotacao
		endif
	endif
else
	if dVcto >= Date()
		return( nVlr )
	else
		if Taxas->(DbSeek( Date()))
			nCotacao := Taxas->Cotacao
		endif
	endif
endif
nRetorno := ( nVlrDolar * nCotacao )
return( if( nRetorno <= 0, nVlr, nRetorno ))

*:---------------------------------------------------------------------------------------------------------------------------------

Proc cCabec( Titulo, Tam )
*************************
STATIC Pagina := 0
LOCAL nDiv	  := Tam / 2

Write( 00, 000, Padr( "Pagina N?" + StrZero(++Pagina,5), nDiv ) + Padl(Time(), nDiv ))
Write( 01, 001, Dtoc( Date() ))
Write( 02, 000, Padc( AllTrim(oAmbiente:xNomefir), Tam ))
Write( 03, 000, Padc( SISTEM_NA3  , Tam ))
Write( 04, 000, Padc( Titulo , Tam ))
Write( 05, 000, Repl( SEP , Tam ) )
Write( 06, 000, "CODI  NOME DO CLIENTE                     TIPO      DOC.N? EMISSAO   VENCTO  VALOR TITULO JR/MES   ATR    JURO/DIA      VALOR+JUROS" )
Write( 07, 000, Repl( SEP, Tam ) )
return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc Hlp()
**********
LOCAL Tela := SaveScreen()
MaBox( 02 , 09 , 22 , 65, "HELP EDITOR" )
@ 03 , 10 Say	"Seta para cima ou Ctrl+E   - Linha para cima"
@ 04 , 10 Say	"Seta para baixo ou Ctrl+X  - Linha para baixo"
@ 05 , 10 Say	"Seta p/esquerda ou Ctrl+S  - Um caractere a esquerda"
@ 06 , 10 Say	"Seta p/direita ou Ctrl+D   - Um caractere a direita"
@ 07 , 10 Say	"Ctrl-Esquerdaa ou Ctrl+A   - Uma palavra a esquerda"
@ 08 , 10 Say	"Ctrl-Direita ou Ctrl+F     - Uma palavra a direita"
@ 09 , 10 Say	"Home                       - Inicio da linha"
@ 10 , 10 Say	"End                        - Fim da linha"
@ 11 , 10 Say	"Ctrl+Home                  - Inicio do Memo"
@ 12 , 10 Say	"Ctrl+End                   - Fim do Memo"
@ 13 , 10 Say	"PgUp                       - Uma Janela para cima"
@ 14 , 10 Say	"PgDn                       - Uma Janela para baixo"
@ 15 , 10 Say	"Ctrl+PgUp                  - Inicio da Janela Corrente"
@ 16 , 10 Say	"Ctrl+PgDn                  - Fim da Janela Corrente"
@ 17 , 10 Say	"Ctrl+Y                     - Apaga a Linha Corrente"
@ 18 , 10 Say	"Ctrl+T                     - Apaga a Palavra a Direita"
@ 19 , 10 Say	"Ctrl+B                     - Reformate memo na Janela"
@ 20 , 10 Say	"Ctrl+W                     - Termina a Edicao e Salva"
@ 21 , 10 Say	"Esc                        - Aborta a Edicao"
InKey( 0 )
ResTela( Tela )
return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc ClientesDbedit()
*********************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()
Set Key -8 To

oMenu:Limpa()
Area("Receber")
Receber->(Order( RECEBER_NOME ))
Receber->(DbGoTop())
oBrowse:Add( "CODIGO",    "Codi")
oBrowse:Add( "NOME",      "Nome")
oBrowse:Add( "CIDADE",    "Cida")
oBrowse:Add( "UF",        "Esta")
oBrowse:Add( "REGIAO",    "Regiao")
oBrowse:Titulo   := "CONSULTA/ALTERACAO DE CLIENTES"
oBrowse:HotKey( F4, {|| oBrowse:DupReg("RECEBER","CODI", RECEBER_CODI)})
oBrowse:PreDoGet := {|| PreDoCli( oBrowse ) }
oBrowse:PosDoGet := {|| PosDoCli( oBrowse ) }
oBrowse:PreDoDel := {|| HotPreCli( oBrowse ) }
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

*:---------------------------------------------------------------------------------------------------------------------------------

Function ProxCodiCli( cCodi )
*****************************
return( StrZero( Val( cCodi ) + 1, 5))

*:---------------------------------------------------------------------------------------------------------------------------------

Function PreDoCli( oBrowse )
****************************
LOCAL oCol		 := oBrowse:getColumn( oBrowse:colPos )
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()

if !PodeAlterar()
	return( FALSO)
endif

Do Case
Case oCol:Heading = "CODIGO"
	ErrorBeep()
	Alerta("Opa! Nao pode alterar nao.")
	return( FALSO )
OtherWise
EndCase
return( PodeAlterar() )

*:---------------------------------------------------------------------------------------------------------------------------------

Function PosDoCli( oBrowse )
****************************
LOCAL oCol		 := oBrowse:getColumn( oBrowse:colPos )
LOCAL cRegiao	 := Space(02)
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()

Do Case
Case oCol:Heading = "REGIAO"
	cRegiao := Receber->Regiao
	RegiaoErrada( @cRegiao )
	Receber->Regiao := cRegiao
	AreaAnt( Arq_Ant, Ind_Ant )
OtherWise
EndCase
Receber->Atualizado := Date()
return( OK )

*:---------------------------------------------------------------------------------------------------------------------------------

Function HotPreCli( oBrowse )
*****************************
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )
LOCAL cCodi   := Receber->Codi

Recemov->(Order( RECEMOV_CODI ))
if Recemov->(DbSeek( cCodi ))
	ErrorBeep()
	if !Conf("Pergunta: Cliente devendo. Excluir ?")
		return( FALSO )
	endif
endif
Recebido->(Order( RECEBIDO_CODI ))
if Recebido->(DbSeek( cCodi ))
	ErrorBeep()
	if !Conf("Pergunta: Cliente com Movimento. Excluir ?")
		return( FALSO )
	endif
endif
return( OK )

*:---------------------------------------------------------------------------------------------------------------------------------

STATIC Proc AbreArea()
**********************
LOCAL cScreen := SaveScreen()
ErrorBeep()
Mensagem("Aguarde, Abrindo base de dados.")
FechaTudo()

if !UsaArquivo("RECEBER")
	MensFecha()
	return
endif

if !UsaArquivo("VENDEDOR")
	MensFecha()
	return
endif

if !UsaArquivo("VENDEMOV")
	MensFecha()
	return
endif

if !UsaArquivo("RECEMOV")
	MensFecha()
	return
endif

if !UsaArquivo("NOTA")
	MensFecha()
	return
endif

if !UsaArquivo("RECEBIDO")
	MensFecha()
	return
endif

if !UsaArquivo("REGIAO")
	MensFecha()
	return
endif

if !UsaArquivo("TAXAS")
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

if !UsaArquivo("CHEPRE")
	MensFecha()
	return
endif

if !UsaArquivo("PAGAMOV")
	MensFecha()
	return
endif

if !UsaArquivo("CEP")
	MensFecha()
	return
endif

if !UsaArquivo("FORMA")
	MensFecha()
	return
endif
if !UsaArquivo("GRUPO")
	MensFecha()
	return
endif
if !UsaArquivo("LISTA")
	MensFecha()
	return
endif
if !UsaArquivo("SAIDAS")
	MensFecha()
	return
endif
if !UsaArquivo("PREVENDA")
	MensFecha()
	return
endif
if !UsaArquivo("RECIBO")
	MensFecha()
	return
endif
if !UsaArquivo("AGENDA")
	MensFecha()
	return
endif
if !UsaArquivo("CM")
	MensFecha()
	return
endif
if !UsaArquivo("LISTA")
	MensFecha()
	return
endif
if !UsaArquivo("SUBGRUPO")
	MensFecha()
	return
endif
if !UsaArquivo("GRUPO")
	MensFecha()
	return
endif
return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc CliAlteracao( lDeletar )
*****************************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL nKey		 := SetKey( F9 )
LOCAL nFieldLen := Len( Receber->Codi )

Set Key F9 To
WHILE OK
	oMenu:Limpa()
	Area("Receber")
	Receber->(Order( RECEBER_CODI ))
	MaBox( 14 , 19 , 16 , 34 )
	cCodi := Space(05)
	@ 15 , 20 SAY "Cliente.:" Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi )
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		Exit
	endif
	oMenu:Limpa()
	cCodi 	:= Receber->Codi
	dData 	:= Receber->Data
	cNome 	:= Receber->Nome
	cEnde 	:= Receber->Ende
	cRg		:= Receber->Rg
	cCpf		:= Receber->Cpf
	nRenda	:= Receber->Media
	cRef1 	:= Receber->RefCom
	cRef2 	:= Receber->RefBco
	cImovel	:= Receber->Imovel
	cCivil	:= Receber->Civil
	cNatural := Receber->Natural
	dNasc 	:= Receber->Nasc
	cEsposa	:= Receber->Esposa
	nDepe 	:= Receber->Depe
	cPai		:= Receber->Pai
	cMae		:= Receber->Mae
	cEnde1	:= Receber->Ende1
	cFone1	:= Receber->Fone1
	cProf 	:= Receber->Profissao
	cCargo	:= Receber->Cargo
	cTraba	:= Receber->Trabalho
	cFone2	:= Receber->Fone2
	cTempo	:= Receber->Tempo
	cVeicul	:= Receber->Veiculo
	cConhec	:= Receber->Conhecida
	cEnde3	:= Receber->Ende3
	cSpc		:= Receber->(if( Spc, "S", "N" ))
	cCodi 	:= Receber->Codi
	cCep		:= Receber->Cep
	cCida 	:= Receber->Cida
	cEsta 	:= Receber->Esta
	cBair 	:= Receber->Bair

	lSair := FALSO
	if !Receber->(TravaReg())
		Loop
	endif
	WHILE OK
		MaBox( 00 , 00 , 24 , 79, "ALTERACAO/EXCLUSAO DE CLIENTES" )
		Write( 01, 01, "Codigo.........:                                Data Cadastro..:")
		Write( 02, 01, "Nome...........:")
		Write( 03, 01, "Endereco.......:                                Estado Civil:")
		Write( 04, 01, "Cidade.........:                                Estado......:")
		Write( 05, 01, "Natural........:                                Nascimento..:")
		Write( 06, 01, "Identidade n?.:                                CPF.........:")
		Write( 07, 01, "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ")
		Write( 08, 01, "Esposo(a)......:                                           Dependentes..:")
		Write( 09, 01, "Pai............:")
		Write( 10, 01, "Mae............:")
		Write( 11, 01, "Endereco.......:                                 Fone.:")
		Write( 12, 01, "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ")
		Write( 13, 01, "Profissao......:                                 Cargo.:")
		Write( 14, 01, "Trabalho Atual.:                                 Fone..:")
		Write( 15, 01, "Tempo Servico..:                        Renda Mensal...:")
		Write( 16, 01, "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ")
		Write( 17, 01, "Referencia.....:                                                  Spc...:")
		Write( 18, 01, "Referencia.....:")
		Write( 19, 01, "Bens Imoveis...:")
		Write( 20, 01, "Veiculos.......:")
		Write( 21, 01, "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ")
		Write( 22, 01, "Pessoa Conhec..:")
		Write( 23, 01, "Endereco.......:")

		@ 01, 18 Get cCodi	  Pict PIC_RECEBER_CODI
		@ 01, 65 Get dData	  Pict "##/##/##"
		@ 02, 18 Get cNome	  Pict "@!"
		@ 03, 18 Get cEnde	  Pict "@!"
		@ 03, 63 Get cCivil	  Pict "@!"
		@ 04, 18 Get cCep 	  Pict "#####-###" Valid CepErrado( @cCep, @cCida, @cEsta, @cBair )
		@ 04, 28 Get cCida	  Pict "@!S21"
		@ 04, 63 Get cEsta	  Pict "@!"
		@ 05, 18 Get cNatural  Pict "@!"
		@ 05, 63 Get dNasc	  Pict "##/##/##"
		@ 06, 18 Get cRg		  Pict "@!"
		@ 06, 63 Get cCpf 	  Pict "999.999.999-99"
		@ 08, 18 Get cEsposa   Pict "@!"
		@ 08, 75 Get nDepe	  Pict "99"
		@ 09, 18 Get cPai 	  Pict "@!"
		@ 10, 18 Get cMae 	  Pict "@!"
		@ 11, 18 Get cEnde1	  Pict "@!"
		@ 11, 58 Get cFone1	  Pict "(9999)999-9999"
		@ 13, 18 Get cProf	  Pict "@!"
		@ 13, 58 Get cCargo	  Pict "@!"
		@ 14, 18 Get cTraba	  Pict "@!"
		@ 14, 58 Get cFone2	  Pict "(9999)999-9999"
		@ 15, 18 Get cTempo	  Pict "@!"
		@ 15, 58 Get nRenda	  Pict "99999999.99"
		@ 17, 18 Get cRef1	  Pict "@!"
		@ 17, 75 Get cSpc 	  Pict "!" Valid cSpc $ "SN"
		@ 18, 18 Get cRef2	  Pict "@!"
		@ 19, 18 Get cImovel   Pict "@!"
		@ 20, 18 Get cVeicul   Pict "@!"
		@ 22, 18 Get cConhec   Pict "@!"
		@ 23, 18 Get cEnde3	  Pict "@!"
		if lDeletar
			Clear Gets
		else
			Read
		endif
		if LastKey() = ESC
			Receber->(Libera())
			lSair := OK
			Exit
		endif
		ErrorBeep()
		if lDeletar
			nOpcao := Alerta(" Pergunta: Voce Deseja ? ", {" Excluir ", " Cancelar ", " Sair "})
		else
			nOpcao := Alerta(" Pergunta: Voce Deseja ? ", {" Alterar ", " Cancelar ", " Sair "})
		endif
		if lDeletar
			if nOpcao = 1		// Excluir
				Receber->(DbDelete())
				Receber->(Libera())
				Exit
			elseif nOpcao = 2 // Cancelar
				Receber->(Libera())
				Exit
			endif
		endif
		if nOpcao = 1	// Incluir
			Receber->Codi		 := cCodi
			Receber->Data		 := dData
			Receber->Nome		 := cNome
			Receber->Cep		 := cCep
			Receber->Ende		 := cEnde
			Receber->Cida		 := cCida
			Receber->Esta		 := cEsta
			Receber->Rg 		 := cRg
			Receber->Cpf		 := cCpf
			Receber->Media 	 := nRenda
			Receber->RefCom	 := cRef1
			Receber->RefBco	 := cRef2
			Receber->Imovel	 := cImovel
			Receber->Civil 	 := cCivil
			Receber->Natural	 := cNatural
			Receber->Nasc		 := dNasc
			Receber->Esposa	 := cEsposa
			Receber->Depe		 := nDepe
			Receber->Pai		 := cPai
			Receber->Mae		 := cMae
			Receber->Ende1 	 := cEnde1
			Receber->Fone1 	 := cFone1
			Receber->Profissao := cProf
			Receber->Cargo 	 := cCargo
			Receber->Trabalho  := cTraba
			Receber->Fone2 	 := cFone2
			Receber->Tempo 	 := cTempo
			Receber->Veiculo	 := cVeicul
			Receber->Conhecida := cConhec
			Receber->Ende3 	 := cEnde3
			Receber->Spc		 := if( cSpc = "S", OK, FALSO )
			Receber->(Libera())
			Exit
		elseif nOpcao = 2 // Cancelar
			Loop
		elseif nOpcao = 3 // Sair
			Receber->(Libera())
			lSair := OK
			Exit
		endif
	EndDo
	if lSair
		ResTela( cScreen )
		Exit
	endif
EndDo

*:---------------------------------------------------------------------------------------------------------------------------------

Proc ReceGrafico()
******************
LOCAL cScreen := SaveScreen()
LOCAL cScreen1
LOCAL nChoice
LOCAL aMenu   := {"Por Cliente                      ",;
						"Mensal Por Ano Clientes Ativos   ",;
						"Mensal Por Ano Clientes InAtivos ",;
						"Mensal Por Ano Todos Clientes    ",;
						"Ultimos 12 anos Clientes Ativos  ",;
						"Ultimos 12 anos Clientes InAtivos",;
						"Ultimos 12 anos todos Clientes   ";
						}

WHILE OK
	DbClearFilter()
	DbGoTop()
	M_Title("GRAFICOS DE CONTAS A RECEBER - EM ABERTO" )
	nChoice := FazMenu( 07, 10, aMenu)
	cScreen1 := SaveScreen()
	Do Case
	Case nChoice = 0
		return(ResTela( cScreen))

	Case nChoice = 1
		Area("Receber")
		Receber->(Order( RECEBER_CODI ))
		cCodi := Space( 05 )
		MaBox( 18, 10, 20, 78 )
		@ 19, 11 Say "Cliente...: " Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
		Read
		if LastKey() = ESC
			ResTela( cScreen1 )
			Loop
		endif
		GraficoReceberCodigo( cCodi )
		ResTela( cScreen1 )

	Case nChoice > 1 
		GraficoReceberGeral(nChoice)
		ResTela( cScreen1 )		

	EndCase
EndDo

*:---------------------------------------------------------------------------------------------------------------------------------

static function GraficoReceberCodigo(cCodi)
*******************************************
LOCAL cScreen := SaveScreen()
LOCAL nAnual  := 0
LOCAL nBase   := 1
LOCAL aDataIni := {}
LOCAL aDataFim := {}
LOCAL nConta   := 0
LOCAL cValor   := "" 
LOCAL aMes[12,2]
LOCAL aValor[12,2]
PRIVA cAno	   := Space(02)

MaBox( 21, 10, 23, 45 )
@ 22, 11 Say "Entre o ano para Grafico...:" Get cAno Pict "99" Valid if(Empty(cAno), ( ErrorBeep(), Alerta("Ooops!: Entre com o ano!", nil , 31), FALSO ), OK )
Read
if LastKey() = ESC
	return(Restela( cScreen))
endif

oMenu:Limpa()
aDataIni := aMesIniMesFim(cAno)[1]
aDataFim := aMesIniMesFim(cAno)[2]

Area("Recemov")
Recemov->(Order( RECEMOV_CODI ))
Recemov->(Sx_SetScope( S_TOP, cCodi))
Recemov->(Sx_SetScope( S_BOTTOM, cCodi))
Recemov->(DbGoTop())
Mensagem(" Aguarde, Calculando Valores.")
oMenu:ResetReg()
For nX := 1 To 12
	oMenu:ContaReg()
   aMes[nX,1] := 0	
	Sum Recemov->Vlr To aValor[nX,1] For Recemov->Vcto >= aDataIni[nX] .AND. Recemov->Vcto <= aDataFim[nX] .AND. Empty(Recemov->DataPag)
	aMes[nX,1] += aValor[nX,1]
   nAnual     += aValor[nX,1]
Next
Recemov->(Sx_ClrScope( S_TOP))
Recemov->(Sx_ClrScope( S_BOTTOM))
Recemov->(DbGoTop())

aMes   := aMesIniMesFim(cAno, aValor)[3]
cNome  := Receber->( AllTrim( Nome ) )
cValor := "R$" + AllTrim(Tran( nAnual, "@E 9,999,999,999.99"))

SetColor("")
Cls
Grafico( aMes,.T.,"EVOLUCAO MENSAL DE TITULOS A RECEBER - &cNome.", cValor, AllTrim(oAmbiente:xNomefir), nBase )
Inkey(0)
return(ResTela(cScreen))

static function GraficoReceberGeral(nChoice)
*------------------------------------------*
LOCAL cScreen  := SaveScreen()
LOCAL nAnual   := 0
LOCAL nBase    := 1
LOCAL aDataIni := {}
LOCAL aDataFim := {}
LOCAL nConta   := 0
LOCAL nX       := 0
LOCAL dIni     AS DATE
LOCAL dFim     AS DATE
LOCAL cValor   AS STRING     
LOCAL aMes[12,2]
LOCAL aValor[12,2]
PRIVA cAno	   := Tran(Year(Date()), "9999")

MaBox( 18, 10, 20, 58 )
@ 19, 11 Say "Entre com o ultimo ano para Grafico...:" Get cAno Pict "9999" Valid if(Empty(cAno), ( ErrorBeep(), Alerta("Ooops!: Entre com o ano!", nil , 31), FALSO ), OK )
Read
if LastKey() = ESC
	return(Restela(cScreen))
endif
if nChoice > 1 .AND. nChoice < 4
	aDataIni := aMesIniMesFim(cAno)[1]
	aDataFim := aMesIniMesFim(cAno)[2]
else
	aDataIni := aAnoIniAnoFim(cAno)[1]
	aDataFim := aAnoIniAnoFim(cAno)[2]
endif	

Receber->(Order( RECEBER_CODI ))
Recibo->(Order( RECIBO_DOCNR ))
Area("Recemov")
Recemov->(Order( RECEMOV_VCTO ))
Mensagem("Aguarde, calculando valores.")

oMenu:ResetReg()
For nX := 1 To 12
	oMenu:ContaReg()
	aMes[nX,1]   := 0	
	aValor[nX,1] := 0	
	dIni	       := aDataIni[nX]
	dFim	       := aDataFim[nX]
	Recemov->(Sx_SetScope( S_TOP, dIni))
	Recemov->(Sx_SetScope( S_BOTTOM, dFim))	
	Recemov->(DbGoTop())
	While Recemov->(!Eof())
		if Receber->(DbSeek( Recemov->Codi ))
			if nChoice == 2 .OR. nChoice == 5
				if !Receber->Suporte
					Recemov->(DbSkip(1))
					Loop
				endif
			elseif nChoice == 3 .OR. nChoice == 6
				if Receber->Suporte
					Recemov->(DbSkip(1))
					Loop
				endif
			endif							
		endif				
		if Recibo->(!DbSeek( Recemov->Docnr ))
			aValor[nX,1] += Recemov->Vlr
		endif
		Recemov->(DbSkip(1))
	EndDo
	Recemov->(Sx_ClrScope( S_TOP))
	Recemov->(Sx_ClrScope( S_BOTTOM))
	Recemov->(DbGoTop())
	aMes[nX,1] += aValor[nX,1]
   nAnual     += aValor[nX,1]
Next

if nChoice > 1 .AND. nChoice < 4
	aMes   := aMesIniMesFim(cAno, aValor)[3]
else
	aMes   := aAnoIniAnoFim(cAno, aValor)[3]
endif	
cValor := "R$" + AllTrim(Tran( nAnual, "@E 9,999,999,999.99"))

SetColor("")
Cls
Grafico( aMes, true, "EVOLUCAO MENSAL DE TITULOS A RECEBER - &cAno.", cValor, AllTrim(oAmbiente:xNomefir), nBase)
Inkey(0)
return(ResTela(cScreen))

*:---------------------------------------------------------------------------------------------------------------------------------

Proc FechtoMes()
****************
LOCAL cScreen := SaveScreen()
LOCAL nChoice
LOCAL oBloco
LOCAL nJuro
LOCAL cPort
LOCAL nPorc
LOCAL nJdia
LOCAL dEmis
LOCAL dVcto
LOCAL nValor
LOCAL nCotacao

ErrorBeep()
Alert("ATENCAO!!;Procure conhecer esta opcao junto;ao Depto. de Suporte antes de usa-la.")

WHILE OK
	M_Title("ENTRADAS POR FORNECEDOR")
	nChoice := FazMenu( 05, 20, { "Individual", "Todos" })
	if nChoice = 0
		ResTela( cScreen )
		Exit

	elseif nChoice = 1
		Area("Receber")
		Receber->( Order( RECEBER_CODI ))
		Receber->(DbGoTop())
		cCodi := Space( 05)
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 11, 20, 15, 45 )
		@ 12, 21 Say "Cliente.....:" Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi )
		@ 13, 21 Say "Emis Inicial:" Get dIni  Pict "##/##/##"
		@ 14, 21 Say "Emis Final..:" Get dFim  Pict "##/##/##"
		Read
		if LastKey( ) = ESC
			ResTela( cScreen )
			Loop
		endif
		oCondicao := {|| Receber->Codi = cCodi }

	elseif nChoice = 2
		Area("Receber")
		Receber->(Order( RECEBER_CODI ))
		Receber->(DbGoTop())
		cCodi 	 := Space(05)
		oCondicao := {|| cProx( @cCodi ) }
		dIni		 := Date()-30
		dFim		 := Date()
		MaBox( 12, 20, 15, 45 )
		@ 13, 21 Say "Emissao Ini ¯" Get dIni Pict "##/##/##"
		@ 14, 21 Say "Emissao Fim ¯" Get dFim Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
	endif
	MaBox( 16, 20, 19, 55 )
	dEmis 	:= Date()
	dVcto 	:= Date()+30
	nCotacao := 0
	MaBox( 16, 20, 19, 57 )
	@ 17, 21 Say "Emissao do Fechamento..:" Get dEmis Pict "##/##/##"
	@ 18, 21 Say "Vencto  do Fechamento..:" Get dVcto Pict "##/##/##" Valid dVcto >= dEmis
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		Loop
	endif
	lTitulo := Conf("Pergunta: Refazer fechamento no Futuro ?")
	While Eval( oCondicao )
		if nChoice = 1
			oCondicao := {|| FALSO }
		endif
		Area( "Recemov" )
		Recemov->(Order( RECEMOV_CODI ))
		if Recemov->(!Dbseek( cCodi ))
			if nChoice = 1
				ErrorBeep()
				oMenu:Limpa()
				Alerta("Erro: Sem registros a processar deste cliente...")
			endif
			Loop
		endif
		if Recemov->(!TravaArq())
			Loop
		endif
		nJuro 		:= Recemov->Juro
		cPort 		:= Recemov->Port
		nPorc 		:= Recemov->Porc
		cTipo 		:= Recemov->Tipo
		oBloco		:= {|| Recemov->Codi = cCodi }
		cTela 		:= Mensagem("Aguarde... Verificando e Ordenando Movimento.")
		nValor		:= 0
		WHILE Eval( oBloco )
			if Recemov->Titulo .OR. Recemov->Emis < dIni .OR. Recemov->Emis > dFim
				Recemov->(DbSkip(1))
				Loop
			endif
			nValor += Recemov->Vlr
			Recemov->(DbDelete())
			Recemov->(DbSkip(1))
		EndDo
		if nValor != 0
			cDocnr := Right( cCodi,3) + StrTran( Time(), ":")
			Recemov->(DbAppend())
			Recemov->Codi	  := cCodi
			Recemov->Jurodia := JuroDia( nValor, nJuro )
			Recemov->Juro	  := nJuro
			Recemov->Port	  := cPort
			Recemov->Porc	  := nPorc
			Recemov->Emis	  := dEmis
			Recemov->Vcto	  := dVcto
			Recemov->Docnr   := cDocnr
			Recemov->Fatura  := cDocnr
			Recemov->Tipo	  := cTipo
			Recemov->Titulo  := if( lTitulo, FALSO, OK )
			Recemov->Vlr	  := nValor
			Recemov->Regiao  := Receber->Regiao
			Recemov->(Libera())
			nValor			  := 0
		else
			if nChoice = 1
				Recemov->(Libera())
				ErrorBeep()
				oMenu:Limpa()
				Alerta("Erro: Sem registros a processar deste cliente...")
			endif
		endif
	EndDo
	Recemov->(Libera())
	Restela( cScreen )
EndDo

*:---------------------------------------------------------------------------------------------------------------------------------

Function cProx( cCodi )
***********************
Receber->(DbSkip())
cCodi := Receber->Codi
return( Receber->(!Eof()))

*:---------------------------------------------------------------------------------------------------------------------------------

Proc EtiquetasClientes()
************************
LOCAL cScreen		 := SaveScreen()
LOCAL aMenu 		 := { " Individual ", " Por Aniversario ", " Ultima Compra", " Geral Ordem Codigo ", " Geral Ordem Nome ", " Configurar Etiquetas " }
LOCAL cCodi 		 := Space(04)
LOCAL cTemp 		 := FTempName("*.TMP")
LOCAL nChoice		 := 1
LOCAL nEtiquetas	 := 1
LOCAL aConfig		 := {}
LOCAL nRecno		 := 0
LOCAL nCampos		 := 5
LOCAL nTamanho 	 := 35
LOCAL nMargem		 := 0
LOCAL nLinhas		 := 1
LOCAL nEspacos 	 := 1
LOCAL nCarreira	 := 1
LOCAL nX 			 := 0
LOCAL aArray		 := {}
LOCAL aGets 		 := {}
LOCAL lComprimir	 := FALSO
LOCAL lSpVert		 := FALSO
LOCAL nAniversario := 5
LOCAL nDias 		 := 0
LOCAL cDebitos 	 := "N"
LOCAL oBloco

WHILE OK
	 M_Title("IMPRESSAO DE ETIQUETAS CLIENTES" )
	 nChoice := FazMenu( 03, 10, aMenu, Cor())
	 Do Case
	 Case nChoice = 0
		 ResTela( cScreen )
		 Exit

	 Case nChoice = 1
		 WHILE OK
			 Area("Receber")
			 Receber->(Order( RECEBER_CODI ))
			 cCodi		 := Space(05)
			 nEtiquetas  := 1
			 cArquivo	 := Space(11)
			 MaBox( 16 , 10 , 19 , 78 )
			 @ 17, 11 Say	"Cliente....:" Get cCodi      Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col() + 5 )
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
				 Fprint( _SPACO1_8 )
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

	 Case nChoice = 2
		 if !Selecao( nAniversario, @oBloco )
			 ResTela( cScreen )
			 Loop
		 endif
		 aConfig := LerEtiqueta()
		 if !InsTru80() .OR. !LptOk()
			 xAlias->(DbCloseArea())
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
			 Fprint( _SPACO1_8 )
		 endif
		 SetPrc( 0, 0 )
		 nConta		:= 0
		 nEtiquetas := 1
		 nCol 		:= nMargem
		 WHILE xAlias->(!Eof()) .AND. Rep_Ok()
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
				 Qout( Space( nMargem) + aLinha[nC] )
				 aLinha[nC] := ""
			 Next
			 For nD := 1 To nLinhas
				 Qout()
			 Next
		 endif
		 xAlias->(DbCloseArea())
		 PrintOFF()
		 ResTela( cScreen )

	 Case nChoice = 3
		 oMenu:Limpa()
		 MaBox( 10, 10, 13, 45 )
		 @ 11, 11 Say "Dias da Ultima Compra........:" Get nDias    Pict "999"
		 @ 12, 11 Say "Imprimir Carta se tem debitos:" Get cDebitos Pict "!" Valid cDebitos $ "SN"
		 Read
		 if LastKey() = ESC
			 ResTela( cScreen )
			 Loop
		 endif
		 Area("Receber")
		 Receber->(Order( RECEBER_CODI ))
		 Receber->(DbGoTop())
		 cUltCodigo  := Codi
		 aConfig 	 := LerEtiqueta()
		 if !InsTru80() .OR. !LptOk()
			 ResTela( cScreen )
			 Loop
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
			 Fprint( _SPACO1_8 )
		 endif
		 SetPrc( 0, 0 )
		 nConta		:= 0
		 nEtiquetas := 1
		 nCol 		:= nMargem
		 oMenu:Limpa()
		 cTela	:= Mensagem("Aguarde, Imprimindo. ")
		 Recemov->(Order( RECEMOV_CODI ))
		 WHILE !Eof() .AND. Rep_Ok()
			 if ( Date() - UltCompra ) >= nDias
				 if cDebitos = "N"
					 if Recemov->(DbSeek( cUltCodigo ))
						 cUltCodi := Codi
						 DbSkip(1)
						 Loop
					 endif
				 endif
			 else
				 cUltCodi := Codi
				 DbSkip(1)
				 Loop
			 endif
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
						 Qout( Space( nMargem) + aLinha[nC] )
						 aLinha[nC] := ""
					 Next
					 For nD := 1 To nLinhas
						 Qout()
					 Next
				 endif
			 Next nY
			 cUltCodi := Codi
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

	 Case nChoice = 4 .OR. nChoice = 5
		 Area("Receber")
		 if nChoice = 2
			 Receber->(Order( RECEBER_CODI ))
		 else
			 Receber->(Order( RECEBER_NOME ))
		 endif
		 Receber->(DbGoTop())
		 aConfig := LerEtiqueta()
		 if !InsTru80() .OR. !LptOk()
			 ResTela( cScreen )
			 Loop
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
			 Fprint( _SPACO1_8 )
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
				 Qout( Space( nMargem) + aLinha[nC] )
				 aLinha[nC] := ""
			 Next
			 For nD := 1 To nLinhas
				 Qout()
			 Next
		 endif
		 PrintOFF()
		 ResTela( cScreen )

	 Case nChoice = 6
		 ConfigurarEtiqueta()
		 ResTela( cScreen )

	 EndCase
EndDo

*:---------------------------------------------------------------------------------------------------------------------------------


Proc RelReceber()
*****************
LOCAL cScreen	 := SaveScreen()
LOCAL AtPrompt  := {"Por Data de Vencimento","Por Data de Emissao","Relatorio de Cobranca","Relatorio de Cobranca Seletiva","Totalizado","Por Vendedor","Fluxo Sintetico",'Rol Percentual Pagar/Pago'}
LOCAL cCodiVen  := Space(04)
LOCAL dIni		 := Date()-30
LOCAL dFim		 := Date()
LOCAL nChoice

WHILE OK
	oMenu:Limpa()
	M_Title( "ROL DE TITULOS A RECEBER")
	nChoice := FazMenu( 01 , 18,	AtPrompt, Cor() )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit
	Case nChoice = 1 .OR. nChoice = 2
		RelRecDual( nChoice, NIL, atPrompt[nChoice])
	Case nChoice = 3
		RelRecCobranca()
	Case nChoice = 4
		RelRecSeletiva()
	Case nChoice = 5
		RelRecTotalizado()
	Case nChoice = 6
		MaBox( 12 , 18 , 14, 77 )
		@ 13 , 19 Say	"Vendedor:" Get cCodiVen Pict "9999" Valid FunErrado( @cCodiVen,, Row(), Col()+1 )
		Read
		if LastKey() = ESC
			Loop
		endif
		RelRecDual( nChoice, cCodiVen, atPrompt[nChoice])
	Case nChoice = 7
		Fluxo()
	Case nChoice = 8
		RolPagarPago()
	EndCase
EndDo

*:---------------------------------------------------------------------------------------------------------------------------------

Proc RelRecDual( nVctoOuEmis, cCodiVen, cTitle )
*************************************************
LOCAL cScreen	 := SaveScreen()
LOCAL AtPrompt  := { "Por Periodo","Individual", "Por Regiao", "Por Tipo", "Por Portador", "Ordem Alfabetica", "Por Cidade", "Por Grupo de Produtos"}
LOCAL aOrDual	 := { "Nome","Codigo", "Cidade", "Regiao", "Estado","Fantasia", "Endereco" }
LOCAL cRegiao	 := NIL
LOCAL cTipo 	 := NIL
LOCAL cPortador := NIL
LOCAL cCida 	 := NIL
LOCAL cGrupo	 := NIL
LOCAL cTitulo
LOCAL nChoice
LOCAL nOrDual

WHILE OK
	M_Title( AllTrim( Upper( cTitle )))
	nChoice := FazMenu( 03 , 20,	AtPrompt, Cor() )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1
		Area("ReceMov")
		Recemov->(Order( RECEMOV_CODI ))
		Recemov->(DbGoTop())
		M_Title('ORDEM A IMPRIMIR')
		nOrDual := FazMenu( 05 , 22, aOrDual )
		if nOrDual = 0
			ResTela( cScreen )
			Exit
		endif
		Receber->( Order( nOrDual ))
		Receber->(DbGoTop())
		oBloco := {|| Receber->(!Eof()) }
		cTitulo := "ROL GERAL DE TITULOS A RECEBER NO PERIODO DE "
		RolPorPeriodo( cTitulo, oBloco, cRegiao, cTipo, cPortador, nVctoOuEmis, nChoice, cCodiVen )

	Case nChoice = 2
		WHILE OK
			Area("ReceMov")
			Recemov->(Order( RECEMOV_CODI ))
			Recemov->(DbGoTop())
			cCodi := Space(05)
			MaBox( 15 , 20 , 17 , 36 )
			@ 16 , 21 Say	"Cliente.:" Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi )
			Read
			if LastKey() = ESC
				ResTela( cScreen )
				Exit
			endif
			Receber->( Order( RECEBER_NOME ))
			oBloco := {|| Receber->Codi = cCodi }
			cTitulo := "ROL INDIVIDUAL DE TITULOS A RECEBER NO PERIODO DE "
			RolPorPeriodo( cTitulo, oBloco, cRegiao, cTipo, cPortador, nVctoOuEmis, nChoice, cCodiVen )
		EndDo

	Case nChoice = 3
		WHILE OK
			Area("ReceMov")
			Recemov->(Order( RECEMOV_CODI ))
			Recemov->(DbGoTop())
			cRegiao := Space( 02 )
			MaBox( 15 , 20 , 17 , 36 )
			@ 16 , 21 Say	"Regiao..:" Get cRegiao Pict "99" Valid RegiaoErrada( @cRegiao )
			Read
			if LastKey() = ESC
				ResTela( cScreen )
				Exit
			endif
			Receber->( Order( RECEBER_NOME ))
			Receber->(DbGoTop())
			oBloco  := {|| Receber->(!Eof()) }
			cTitulo := "ROL GERAL TITULOS A RECEBER DA REGIAO " + cRegiao + " NO PERIODO DE "
			RolPorPeriodo( cTitulo, oBloco, cRegiao, cTipo, cPortador, nVctoOuEmis, nChoice, cCodiVen )
		EndDo

	Case nChoice = 4
		WHILE OK
			Area("ReceMov")
			Recemov->(Order( RECEMOV_CODI ))
			Recemov->(DbGoTop())
			cTipo := Space( 06 )
			MaBox( 15 , 20 , 17 , 36 )
			@ 16 , 21 Say	"Tipo :" Get cTipo  Pict "@!" Valid !Empty( cTipo )
			Read
			if LastKey() = ESC
				ResTela( cScreen )
				Exit
			endif
			Area("Recemov")
			Recemov->(Order( RECEMOV_TIPO_CODI ))
			if Recemov->(!DbSeek( cTipo ))
				Alerta("Erro: Tipo nao Localizado.")
				Loop
			endif
			Receber->( Order( RECEBER_CODI ))
			Set Rela To Recemov->Codi Into Receber
			oBloco := {|| Recemov->Tipo = cTipo }
			cTitulo := "ROL GERAL TITULOS A RECEBER POR TIPO " + cTipo + " NO PERIODO DE "
			RolPorPeriodo( cTitulo, oBloco, cRegiao, cTipo, cPortador, nVctoOuEmis, nChoice, cCodiVen )
			Recemov->(DbClearRel())
			Recemov->(DbGoTop())
		EndDo

	Case nChoice = 5
		WHILE OK
			Area("ReceMov")
			Recemov->(Order( RECEMOV_CODI ))
			Recemov->(DbGoTop())
			cPortador := Space( 10 )
			MaBox( 15 , 20 , 17 , 42 )
			@ 16 , 21 Say	"Portador :" Get cPortador Pict "@!" Valid !Empty( cPortador )
			Read
			if LastKey() = ESC
				ResTela( cScreen )
				Exit
			endif
			Receber->( Order( RECEBER_NOME ))
			Receber->(DbGoTop())
			oBloco := {|| Receber->(!Eof()) }
			cTitulo := "ROL GERAL TITULOS A RECEBER POR PORTADOR " + cPortador + " NO PERIODO DE "
			RolPorPeriodo( cTitulo, oBloco, cRegiao, cTipo, cPortador, nVctoOuEmis, nChoice, cCodiVen )
		EndDo

	Case nChoice = 6
		PrnAlfabetica( nVctoOuEmis)

	Case nChoice = 7
		WHILE OK
			cCida := Space(25)
			MaBox( 15 , 20 , 17 , 56 )
			@ 16 , 21 Say	"Cidade..:" Get cCida Pict "@!"
			Read
			if LastKey() = ESC
				ResTela( cScreen )
				Exit
			endif
			Area("ReceMov")
			Recemov->(Order( RECEMOV_CODI ))
			Receber->( Order( RECEBER_NOME ))
			Receber->(DbGoTop())
			oBloco  := {|| Receber->(!Eof()) }
			cTitulo := "ROL GERAL TITULOS A RECEBER DA CIDADE " + AllTrim( cCida ) + " NO PERIODO DE "
			RolPorPeriodo( cTitulo, oBloco, cRegiao, cTipo, cPortador, nVctoOuEmis, nChoice, cCodiVen, cCida )
		EndDo

	Case nChoice = 8 // Por Grupo de Produtos
		WHILE OK
			cGrupo := Space(3)
			MaBox( 15 , 20 , 17 , 56 )
			@ 16 , 21 Say	"Grupo...:" Get cGrupo Pict "999" Valid GrupoErrado( @cGrupo )
			Read
			if LastKey() = ESC
				ResTela( cScreen )
				Exit
			endif
			Area("ReceMov")
			Recemov->(Order( RECEMOV_CODI ))
			Receber->( Order( RECEBER_NOME ))
			Receber->(DbGoTop())
			oBloco  := {|| Receber->(!Eof()) }
			cTitulo := "ROL GERAL TITULOS A RECEBER DO GRUPO " + cGrupo + " NO PERIODO DE "
			RolPorPeriodo( cTitulo, oBloco, cRegiao, cTipo, cPortador, nVctoOuEmis, nChoice, cCodiVen, cCida, cGrupo )
		EndDo

	EndCase
	ResTela( cScreen )
EndDo

*:---------------------------------------------------------------------------------------------------------------------------------

Proc RolPorPeriodo( cTitulo, oBloco, cRegiao, cTipo, cPortador, nVctoOuEmis, nChoice, cCodiVen, cCida, cGrupo )
***************************************************************************************************************
LOCAL cScreen	 := SaveScreen()
LOCAL aMenu 	 := {"Normal", "Resumido", "Totalizado", "Juntado"}
LOCAL nResumo	 := 1
LOCAL lJuntado  := FALSO
LOCAL dIni
LOCAL dFim
LOCAL dAtual
LOCAL cCodi

dIni	  := Date() - 30
dFim	  := Date()
dAtual  := Date()
MaBox( 15 , 20 , 19, 50 )
if nVctoOuEmis = 1  .OR. nVctoOuEmis = 5 // Por Vencimento
	@ 16 , 21 Say	"Data Vcto Inicial..:" Get dIni    Pict "##/##/##"
	@ 17 , 21 Say	"Data Vcto Final....:" Get dFim    Pict "##/##/##"
	@ 18 , 21 Say	"Data Para Calculo..:" Get dAtual  Pict "##/##/##"
else
	@ 16 , 21 Say	"Data Emis Inicial..:" Get dIni    Pict "##/##/##"
	@ 17 , 21 Say	"Data Emis Final....:" Get dFim    Pict "##/##/##"
	@ 18 , 21 Say	"Data Para Calculo..:" Get dAtual  Pict "##/##/##"
endif
Read
if LastKey() = ESC
	ResTela( cScreen )
	return
endif
M_Title("TIPO REL")
nResumo := FazMenu( 15 , 51 , aMenu, Cor())
if nResumo = 0
	ResTela( cScreen )
	return
endif
if nResumo = 4
	nResumo = 1
	lJuntado := OK
endif
cTitulo += Dtoc( dIni ) + " A " + Dtoc( dFim )
if nChoice = 4 // Por Tipo
	RolPorTipo( cTitulo, dIni, dFim, dAtual, oBloco, cRegiao, cTipo, cPortador, nVctoOuEmis, nResumo, cCodiVen )
else
	Prn002( cTitulo, dIni, dFim, dAtual, oBloco, cRegiao, cTipo, cPortador, nVctoOuEmis, nResumo, cCodiVen, cCida, cGrupo, lJuntado )
endif
ResTela( cScreen )
return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc Prn002( cTitulo, dIni, dFim, dAtual, oBloco, cRegiao, cTipo, cPortador, nVctoOuEmis, nResumo, cCodiVen, cCida, cGrupo, lJuntado )
**************************************************************************************************************************************
LOCAL cScreen	  := SaveScreen()
LOCAL lSair 	  := FALSO
LOCAL Lista 	  := SISTEM_NA3
LOCAL Tam		  := 132
LOCAL Col		  := 58
LOCAL Pagina	  := 0
LOCAL NovoCodi   := OK
LOCAL lSub		  := FALSO
LOCAL UltCodi	  := Recemov->Codi
LOCAL GrandTotal := 0
LOCAL GrandJuros := 0
LOCAL GrandGeral := 0
LOCAL Atraso	  := 0
LOCAL Juros 	  := 0
LOCAL TotalCli   := 0
LOCAL TotalJur   := 0
LOCAL TotalGer   := 0
LOCAL nJrVlr	  := 0
LOCAL nJuros	  := 0
LOCAL nJdia 	  := 0
LOCAL nAtraso	  := 0
LOCAL nJuro 	  := 0
LOCAL nValor	  := 0
LOCAL nDesconto  := 0
LOCAL nMulta	  := 0
LOCAL nDocumento := 0
LOCAL cTela
LOCAL dEmis
LOCAL dVcto
LOCAL NovoNome
LOCAL UltNome
LOCAL lMarcado

ErrorBeep()
lMarcado := Conf('Pergunta: Incluir no relatorio os marcados ?')
if !InsTru80() .OR. !LptOk()
	ResTela( cScreen )
	return
endif
cTela 	:= Mensagem("Aguarde, imprimindo.")
PrintOn()
FPrint(PQ)
SetPrc( 0 , 0 )
WHILE Eval( oBloco )
	cCodiReceber := Receber->Codi
	if !lMarcado
		if Receber->Rol = OK
			Receber->(DbSkip(1))
			Loop
		endif
	endif
	if cCida != NIL
		if Receber->Cida != cCida
			Receber->(DbSkip(1))
			Loop
		endif
	endif
	if cRegiao != NIL
		if Receber->Regiao != cRegiao
			Receber->(DbSkip(1))
			Loop
		endif
	endif
	if Recemov->(!DbSeek( cCodiReceber ))
		Receber->(DbSkip(1))
		Loop
	endif
	NovoCodi := OK
	WHILE Recemov->Codi = cCodiReceber .AND. Recemov->(!Eof()) .AND. Rel_Ok()
		if cGrupo != NIL
			if Recemov->CodGrupo != cGrupo
				Recemov->(DbSkip(1))
				Loop
			endif
		endif
		if cCodiVen != NIL
			if Recemov->CodiVen != cCodiVen
				Recemov->(DbSkip(1))
				Loop
			endif
		endif
		if cTipo != NIL
			if Recemov->Tipo != cTipo
				Recemov->(DbSkip(1))
				Loop
			endif
		endif
		if cPortador != NIL
			if Recemov->Port != cPortador
				Recemov->(DbSkip(1))
				Loop
			endif
		endif
		if dIni != NIL
			if nVctoOuEmis = 1 .OR. nVctoOuEmis = 5 // Vencimento
				if Recemov->Vcto < dIni .OR. Recemov->Vcto > dFim
					Recemov->(DbSkip(1))
					Loop
				endif
			else
				if Recemov->Emis < dIni .OR. Recemov->Emis > dFim
					Recemov->(DbSkip(1))
					Loop
				endif
			endif
		endif
		dData 	 := if( dAtual = Nil, Date(), dAtual )
		Atraso	 := Atraso( dData, Recemov->Vcto )
		nCarencia := Carencia( dData, Recemov->Vcto )
		nMulta	 := VlrMulta( dData, Recemov->Vcto, Recemov->Vlr )
		nDesconto := VlrDesconto( dData, Recemov->Vcto, Recemov->Vlr )
		if Atraso <= 0
			Juros := 0
		else
			Juros  := Jurodia * nCarencia
		endif
		if Col >= 57
			Write( 01, 001, "Pagina N?" + StrZero( ++Pagina , 3 ) )
			Write( 01, 117, "Horas "+ Time())
			Write( 02, 001, Dtoc( Date() ))
         Write( 03, 000, Padc( AllTrim(oAmbiente:xNomefir), Tam ))
			Write( 04, 000, Padc( Lista  , Tam ))
			Write( 05, 000, Padc( cTitulo , Tam ))
			Write( 06, 000, Repl( "=", Tam ) )
			#ifDEF CICLO
				Write( 07, 000, "DOC N?   TIPO    EMISSAO     VCTO NOSSONR       PORTADOR     VLR TITULO JR MES ATR  JR DIARIO              TOTAL JUROS  TOTAL GERAL")
			#else
				Write( 07, 000, "DOC N?   TIPO    EMISSAO     VCTO PORTADOR     VLR TITULO JR MES ATR  JR DIARIO     DESCONTO        MULTA  TOTAL JUROS  TOTAL GERAL")
			#endif
			Write( 08, 000, Repl( "=", Tam ) )
			Col := 9
		endif
		if nResumo = 1 // Normal
			if NovoCodi .OR. Col = 9
				if NovoCodi
					NovoCodi := FALSO
				endif
				Qout( Codi, Receber->Regiao, Receber->Nome, Receber->Fone, Receber->( Trim( Ende )), Receber->(Trim(Bair)), Receber->( Trim( Cida )), Receber->Esta )
				Qout( Space(05), "SPC:" + if( Receber->Spc, "SIM em " + Dtoc( Receber->DataSpc ), "NAO"),Space(1), Receber->Fanta, Receber->Obs )
				Col += 2
			endif
		endif
		cCodi 	 := Codi
		cNome 	 := Receber->Nome
		dEmis 	 := Dtoc( Emis )
		dVcto 	 := Dtoc( Vcto )
		nJuro 	 := Tran( Juro,	"999.99")
		nAtraso	 := Tran( Atraso, "999")
		nJdia 	 := Tran( Jurodia,		"@E 999,999.99")
		nValor	 := Tran( Vlr, 			"@E 9,999,999.99")
		nJuros	 := Tran( Juros,			"@E 9,999,999.99")
		cDesconto := Tran( nDesconto, 	"@E 9,999,999.99")
		cMulta	 := Tran( nMulta, 		"@E 9,999,999.99")
		nJrVlr	 := Tran(((Vlr + Juros ) + nMulta ) - nDesconto,  "@E 9,999,999.99")

		if nResumo = 1 // Normal
			#ifDEF CICLO
				Qout( Docnr, Tipo, dEmis, dVcto, NossoNr, Port, nValor, nJuro, nAtraso, nJdia, Space(11), nJuros, nJrVlr )
			#else
				Qout( Docnr, Tipo, dEmis, dVcto, Port, nValor, nJuro, nAtraso, nJdia, cDesconto, cMulta, nJuros, nJrVlr )
			#endif
			Col++
		endif
		TotalCli   += Vlr
		TotalJur   += Juros
		TotalGer   += ((( Vlr + Juros ) + nMulta ) - nDesconto )
		GrandTotal += Vlr
		GrandJuros += Juros
		GrandGeral += ((( Vlr + Juros ) + nMulta ) - nDesconto )
		nDocumento ++
		Recemov->(DbSkip(1))
		if Col >= 57
			if nResumo = 1 // Normal
				Col++
				Terminou( Tam, Col, TotalCli, TotalJur, TotalGer )
				Col		+= 2
				__Eject()
			endif
			TotalCli := 0
			TotalJur := 0
			TotalGer := 0
		endif
  EndDo
  if lJuntado
	  Prevenda->(Order( PREVENDA_FATURA ))
	  Prevenda->(DbGotop())
	  WHILE Prevenda->(!Eof())
		  if Prevenda->Codi = cCodi
			  cDesconto := Tran( 0, "@E 9,999,999.99")
			  cMulta 	:= Tran( 0, "@E 9,999,999.99")
			  nValor 	:= Tran( Prevenda->VlrFatura, "@E 9,999,999.99")
			  nJuro		:= Tran( 0, "999.99")
			  nAtraso	:= Tran( 0, "999")
			  nJdia		:= Tran( 0, "@E 999,999.99")
			  nJuros 	:= Tran( 0, "@E 9,999,999.99")
			  cMulta 	:= Tran( 0, "@E 9,999,999.99")
			  nJrVlr 	:= Tran(((Vlr + Juros ) + nMulta ) - nDesconto,  "@E 9,999,999.99")
			  #ifDEF CICLO
				  Qout( Prevenda->Fatura, 'PREVENDA', Prevenda->Emis, Prevenda->Emis, Space(13), Space(10), nValor, nJuro, nAtraso, nJdia, Space(11), nJuros, nValor )
			  #else
				  Qout( Prevenda->Fatura, 'PREVENDA', Prevenda->Emis, Prevenda->Emis, Space(10), nValor, nJuro, nAtraso, nJdia, cDesconto, cMulta, nJuros, nValor )
			  #endif
			  TotalCli	 += Prevenda->VlrFatura
			  TotalGer	 += Prevenda->VlrFatura
			  GrandTotal += Prevenda->VlrFatura
			  GrandGeral += Prevenda->VlrFatura
			  nDocumento ++
			  Col++
			  xFatura := Prevenda->Fatura
			  WHILE Prevenda->Fatura = xFatura
				  Prevenda->(DbSkip(1))
			  EndDo
		  endif
		  Prevenda->(DbSkip(1))
	  EndDO
  endif
  if TotalCli != 0
	  if nResumo = 1 // Normal
		  Col++
		  Terminou( Tam, Col, TotalCli, TotalJur, TotalGer )
		  Col 	  += 2
	  elseif nResumo = 3 // Totalizado
		  Write(  Col , 000, cCodi )
		  Write(  Col , 005, cNome )
		  Write(  Col , 048, Tran( TotalCli, "@E 999,999.99" ))
		  Write(  Col , 109, Tran( TotalJur, "@E 999,999.99" ))
		  Write(  Col , 122, Tran( TotalGer, "@E 999,999.99" ))
		  Col++
	  endif
	  TotalCli := 0
	  TotalJur := 0
	  TotalGer := 0
  endif
  Receber->(DbSkip(1))
EndDo
Qout()
Col++
Write(  Col , 000, "** Total Geral **" )
Write(  Col , 020, StrZero( nDocumento, 6 ))
Write(  Col , 046, Tran( GrandTotal, "@E 9,999,999.99" ))
Write(  Col , 107, Tran( GrandJuros, "@E 9,999,999.99" ))
Write(  Col , 120, Tran( GrandGeral, "@E 9,999,999.99" ))
__Eject()
PrintOff()
ResTela( cScreen )
return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc RolPorTipo( cTitulo, dIni, dFim, dAtual, oBloco, cRegiao, cTipo, cPortador, nVctoOuEmis, nResumo, cCodiVen )
*****************************************************************************************************************
LOCAL cScreen	  := SaveScreen()
LOCAL lSair 	  := FALSO
LOCAL Lista 	  := SISTEM_NA3
LOCAL Tam		  := 132
LOCAL Col		  := 58
LOCAL Pagina	  := 0
LOCAL NovoCodi   := OK
LOCAL lSub		  := FALSO
LOCAL GrandTotal := 0
LOCAL GrandJuros := 0
LOCAL GrandGeral := 0
LOCAL Atraso	  := 0
LOCAL Juros 	  := 0
LOCAL TotalCli   := 0
LOCAL TotalJur   := 0
LOCAL TotalGer   := 0
LOCAL nJrVlr	  := 0
LOCAL nJuros	  := 0
LOCAL nJdia 	  := 0
LOCAL nAtraso	  := 0
LOCAL nJuro 	  := 0
LOCAL nValor	  := 0
LOCAL nDocumento := 0
LOCAL dEmis
LOCAL dVcto
LOCAL NovoNome
LOCAL UltNome
LOCAL UltCodi
LOCAL cTela
LOCAL lMarcado
LOCAL cCodi

ErrorBeep()
lMarcado := Conf('Pergunta: Incluir no relatorio os marcados ?')
if !InsTru80() .OR. !LptOk()
	ResTela( cScreen )
	return
endif
cTela 	:= Mensagem("Aguarde, imprimindo.")
PrintOn()
FPrint(PQ)
SetPrc( 0 , 0 )
UltCodi	:= Recemov->Codi
NovoCodi := OK
WHILE Recemov->Tipo = cTipo .AND. Rel_Ok()
	cCodi := Recemov->Codi
	if !lMarcado
		Receber->(DbSeek( cCodi ))
		if Receber->Rol = OK
			Recemov->(DbSkip(1))
			Loop
		endif
	endif
	if cCodiVen != NIL
		if Recemov->CodiVen != cCodiVen
			Recemov->(DbSkip(1))
			Loop
		endif
	endif
	if Recemov->Codi != UltCodi
		NovoCodi := OK
		UltCodi	:= Recemov->Codi
		if TotalCli != 0
			if nResumo = 1 // Normal
				Col++
				Terminou( Tam, Col, TotalCli, TotalJur, TotalGer )
				Col		+= 2
			endif
			TotalCli := 0
			TotalJur := 0
			TotalGer := 0
		endif
	 endif
	 if dIni != NIL
		 if nVctoOuEmis = 1 .OR. nVctoOuEmis = 5 // Por Vencimento
			 if Recemov->Vcto < dIni .OR. Recemov->Vcto > dFim
				 Recemov->(DbSkip(1))
				 Loop
			 endif
		 else
			 if Recemov->Emis < dIni .OR. Recemov->Emis > dFim
				 Recemov->(DbSkip(1))
				 Loop
			 endif
		 endif
	 endif
	 if dAtual = Nil
		 Atraso	  := Atraso( Date(), Vcto )
		 nCarencia := Carencia( Date(), Vcto )
		 if Atraso <= 0
			 Juros := 0
		 else
			Juros  := Jurodia * nCarencia
		 endif
	 else
		 Atraso	  := Atraso( dAtual, Vcto )
		 nCarencia := Carencia( dAtual, Vcto )
		 if Atraso <= 0
			 Juros := 0
		 else
			Juros  := Jurodia * nCarencia
		 endif
	 endif
	 if Col >= 57
		 Write( 01, 001, "Pagina N?" + StrZero( ++Pagina , 3 ) )
		 Write( 01, 117, "Horas "+ Time())
		 Write( 02, 001, Dtoc( Date() ))
       Write( 03, 000, Padc( AllTrim(oAmbiente:xNomefir), Tam ))
		 Write( 04, 000, Padc( Lista	, Tam ))
		 Write( 05, 000, Padc( cTitulo , Tam ))
		 Write( 06, 000, Repl( "=", Tam ) )
		 Write( 07, 000, "DOC N?   TIPO   EMISSAO  VCTO      NOSSONR      PORTADOR         VLR TITULO JR MES ATRASO  JUROS DIA   TOTAL JUROS    VALOR + JUROS")
		 Write( 08, 000, Repl( "=", Tam ) )
		 Col := 9
	 endif
	 if nResumo = 1 // Normal
		 if NovoCodi .OR. Col = 9
	  if NovoCodi
		  NovoCodi := FALSO
	  endif
	  Qout( Codi, Receber->Nome, Receber->Fone, Receber->( Trim( Ende )), Receber->(Trim(Bair)),Receber->( Trim( Cida )), Receber->Esta )
	  Qout()
	  Col += 2
		 endif
	 endif
	 dEmis	:= Dtoc( Emis )
	 dVcto	:= Dtoc( Vcto )
	 nValor	:= Tran( Vlr,	"@E 9,999,999,999.99")
	 nJuro	:= Tran( Juro, "999.99")
	 nAtraso := Tran( Atraso, "999")
	 nJdia	:= Tran( Jurodia,  "@E 99,999,999.99")
	 nJuros	:= Tran( Juros,  "@E 99,999,999.99")
	 nJrVlr	:= Tran( Juros + Vlr,  "@E 9,999,999,999.99")
	 if nResumo = 1 // Normal
		 Qout( Docnr, Tipo, dEmis, dVcto, NossoNr, Port, nValor, nJuro, nAtraso, nJdia, nJuros, nJrVlr )
		 Col++
	 endif
	 Totalcli	+= Vlr
	 Totaljur	+= Juros
	 Totalger	+= (Juros + Vlr)
	 GrandTotal += Vlr
	 GrandJuros += Juros
	 GrandGeral += ( Vlr+Juros )
	 nDocumento ++
	 Recemov->(DbSkip(1))
	 if Col >= 57
		 if nResumo = 1 // Normal
			 Col++
			 Terminou( Tam, Col, TotalCli, TotalJur, TotalGer )
			 Col		 += 2
			 __Eject()
		 endif
		 TotalCli := 0
		 TotalJur := 0
		 TotalGer := 0
	 endif
EndDo
if TotalCli != 0
	if nResumo = 1 // Normal
		Col++
		Terminou( Tam, Col, TotalCli, TotalJur, TotalGer )
		Col		+= 2
	endif
	TotalCli := 0
	TotalJur := 0
	TotalGer := 0
endif
Write(  Col , 000, "** Total Geral **" )
Write(  Col , 020, StrZero( nDocumento, 6 ))
Write(  Col , 060, Tran( GrandTotal, "@E 9,999,999.99" ))
Write(  Col , 099, Tran( GrandJuros, "@E 9,999,999.99" ))
Write(  Col , 116, Tran( GrandGeral, "@E 9,999,999.99" ))
__Eject()
PrintOff()
ResTela( cScreen )
return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc Terminou( Tam, Col, TotalCli, TotalJur, TotalGer )
*******************************************************
Write(  Col,	000, "** Total Cliente **")
Write(  Col,	046, Tran( TotalCli, "@E 9,999,999.99"))
Write(  Col,	107, Tran( TotalJur, "@E 9,999,999.99"))
Write(  Col,	120, Tran( Totalger, "@E 9,999,999.99"))
Write(  Col+1, 000, Repl( SEP , Tam ) )
return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc RelRecCobranca()
*********************
LOCAL cScreen		  := SaveScreen()
LOCAL aCodi 		  := {}
LOCAL aOrdem		  := {"Codigo","Nome","Endereco","Bairro", "Cidade","Selecao" }
LOCAL aTipo 		  := {"Normal", "Total"}
LOCAL nTam			  := 0
LOCAL dIni			  := Date()-30
LOCAL dFim			  := Date()
LOCAL dAtual		  := Date()
LOCAL dProxCob 	  := Date()-30
LOCAL dProxCobFim   := Date()
LOCAL cCodi 		  := Space(04)
LOCAL cCodiVen 	  := Space(04)
LOCAL cNomeVen 	  := ''
LOCAL lTotal		  := FALSO
LOCAL nChoice		  := 0
LOCAL aTodos		  := {}
LOCAL lIncluir 	  := OK
LOCAL lRolCob		  := oSci:ReadBool('permissao','imprimirrolcobranca', FALSO )
LOCAL lUsuarioAdmin := oSci:ReadBool('permissao','usuarioadmin', FALSO )

MaBox( 13 , 18 , 15 , 77 )
@ 14, 19 Say "Cobrador:" Get cCodiVen Pict "9999" Valid FunErrado( @cCodiVen,, Row(), Col()+1, @cNomeVen )
Read
if LastKey() = ESC
	ResTela( cScreen )
	return
endif
Recemov->(Order( RECEMOV_CODI ))
WHILE OK
	cCodi := Space(05)
	MaBox(16, 18, 18, 77 )
	@ 17, 19 Say  "Cliente.:" Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
	Read
	if LastKey() = ESC
		Exit
	endif
	lIncluir := OK
	if Ascan( aCodi, cCodi ) != 0
		ErrorBeep()
		Alerta("Erro: Cliente Jah Selecionado.")
		Loop
	endif
	if Recemov->(DbSeek( cCodi ))
		WHILE Recemov->Codi = cCodi
			if Recemov->Cobrador != Space(04) .AND. Recemov->Cobrador != cCodiven
				ErrorBeep()
				if !Conf('Pergunta: Cobranca pertence a outro cobrador. Trocar ?')
					lIncluir := FALSO
				endif
				Exit
			endif
			Recemov->(DbSkip(1))
		EndDO
	else
		ErrorBeep()
		Alerta("Erro: Cliente sem debito.")
		Loop
	endif
	if Ascan( aCodi, cCodi ) = 0
		if lIncluir
			ErrorBeep()
			if Conf("Incluir " + Receber->(AllTrim( Nome )) + " ?")
				Aadd( aCodi, cCodi )
				Aadd( aTodos, { cCodi, Receber->Nome, Receber->Ende, Receber->Bair, Receber->Cida })
			endif
		endif
	else
		ErrorBeep()
		Alerta("Erro: Cliente Jah Selecionado.")
	endif
EndDo
if ( nTam := Len( aCodi )) = 0
	ResTela( cScreen )
	return
endif
cTitulo := 'RELACAO DE COBRANCA DO COBRADOR: '
cTitulo += AllTrim( cNomeVen )
cTitulo += ' NO PERIODO DE '
MaBox( 19 , 18 , 23, 67 )
@ 20 , 19 Say	"Vcto Inicial.:" Get dIni        Pict "##/##/##"
@ 20 , 43 Say	"Vcto Final...:" Get dFim        Pict "##/##/##" Valid if( dIni > dFim, ( ErrorBeep(), Alerta("Erro: Data final menor que inicial"), FALSO ), OK )
@ 21 , 19 Say	"Prox Cob Ini.:" Get dProxCob    Pict "##/##/##"
@ 21 , 43 Say	"Prox Cob Fim.:" Get dProxCobFim Pict "##/##/##" Valid if( dProxCob > dProxCobFim, ( ErrorBeep(), Alerta("Erro: Data final menor que inicial"), FALSO ), OK )
@ 22 , 19 Say	"Data Calculo.:" Get dAtual      Pict "##/##/##"
Read
if LastKey() = ESC
	ErrorBeep()
	if Conf("Pergunta: Deseja Cancelar a Selecao ?")
		ResTela( cScreen )
		return
	endif
endif
M_Title("TIPO")
nChoice := FazMenu( 07, 55,  aTipo )
if nChoice = 0
	ErrorBeep()
	if Conf("Pergunta: Deseja Cancelar a Selecao ?")
		ResTela( cScreen )
		return
	endif
endif
ErrorBeep()
oMenu:Limpa()
Mensagem(SISTEM_NA1 + ';-;Aguarde, Autenticando Permissao do Usuario.')
if !lRolCob
	if !lUsuarioAdmin
		if !PedePermissao( SCI_IMPRIMIRROLCOBRANCA )
			ResTela( cScreen )
			return
		endif
	endif
endif
ErrorBeep()
oMenu:Limpa()
ErrorBeep()
if Conf('Pergunta: Anexar os antigos tambem ?')
	Mensagem(SISTEM_NA1 + ';-;Aguarde, Localizando registros.')
	ErrorBeep()
	Recemov->(Order( RECEMOV_CODI ))
	Receber->(Order( RECEBER_CODI ))
	Receber->(DbGoTop())
	While Receber->(!Eof()) .AND. Rel_Ok()
		if Receber->ProxCob < dProxCob .OR. Receber->ProxCob > dProxCobFim .OR. Receber->ProxCob = Ctod('//')
			Receber->(DbSkip(1))
			Loop
		endif
		cCodi 	:= Receber->Codi
		lIncluir := FALSO
		if Recemov->(DbSeek( cCodi ))
			WHILE Recemov->Codi = cCodi
				if Recemov->Cobrador = cCodiven
					lIncluir := OK
					Exit
				endif
				Recemov->(DbSkip(1))
			EndDO
		endif
		if lIncluir
			if Ascan( aCodi, cCodi ) = 0
				Aadd( aCodi, cCodi )
				Aadd( aTodos, { cCodi, Receber->Nome, Receber->Ende, Receber->Bair, Receber->Cida })
			endif
		endif
		Receber->(DbSkip(1))
	EndDo
endif
lTotal := nChoice = 2
WHILE OK
	oMenu:Limpa()
	M_Title("ESCOLHA A ORDEM A IMPRIMIR. ESC RETORNA")
	nOpcao := FazMenu( 05, 10, aOrdem )
	Mensagem("Aguarde, Ordenando.")
	if nOpcao = 0 // Sair ?
		Exit
	elseif nOpcao = 1
		Asort( aTodos,,, {| x, y | y[1] > x[1] } )
	elseif nOpcao = 2
		Asort( aTodos,,, {| x, y | y[2] > x[2] } )
	elseif nOpcao = 3
		Asort( aTodos,,, {| x, y | y[3] > x[3] } )
	elseif nOpcao = 4
		Asort( aTodos,,, {| x, y | y[4] > x[4] } )
	elseif nOpcao = 5
		Asort( aTodos,,, {| x, y | y[5] > x[5] } )
	endif
	nTam	 := Len( aCodi )
	aCodi  := {}
	For nX := 1 To nTam
		Aadd( aCodi, aTodos[nX,1] )
	Next
	ErrorBeep()
	if !InsTru80() .OR. !LptOk()
		ResTela( cScreen )
		return
	endif
	cTitulo += Dtoc( dIni ) + " A " + Dtoc( dFim )
	Prn002Cob( cTitulo, dIni, dFim, dAtual, aCodi, cCodiVen, lTotal, NIL, NIL, dProxCob, dProxCobFim )
EndDo
ResTela( cScreen )
return

Proc RelRecTotalizado()
***********************
LOCAL cScreen	  := SaveScreen()
LOCAL Tam		  := 132
LOCAL Col		  := 58
LOCAL Pagina	  := 0
LOCAL nTotalVlr  := 0
LOCAL nTotalJur  := 0
LOCAL nTotalGer  := 0
LOCAL nTotalMul  := 0
LOCAL nTotalDes  := 0
LOCAL nAtraso	  := 0
LOCAL nDesconto  := 0
LOCAL nMulta	  := 0
LOCAL nJuros	  := 0
LOCAL nCarencia  := 0
LOCAL nDocumento := 0
LOCAL nChoice	  := 1
LOCAL dAtual	  := Date()
LOCAL cTitulo	  := "ROL GERAL DE TITULOS A RECEBER - TOTALIZADO"
LOCAL dIni		  := Date()-30
LOCAL dFim		  := Date()
LOCAL aMenu 	  := {"Por Vcto", "Por Emissao", "Geral"}
LOCAL cTela
LOCAL oBloco1
LOCAL oBloco2

M_Title( "TOTALIZADO")
nChoice := FazMenu( 04 , 20, aMenu, Cor() )
Do Case
Case nChoice = 0
	ResTela( cScreen )
	return
Case nChoice = 1
	MaBox( 13 , 18 , 16, 50 )
	@ 14, 19 Say  "Data Vcto Inicial..:" Get dIni    Pict "##/##/##"
	@ 15, 19 Say  "Data Vcto Final....:" Get dFim    Pict "##/##/##"
	oBloco1 := {|| Recemov->Vcto >= dIni .AND. Recemov->Vcto <= dFim }
Case nChoice = 2
	MaBox( 13 , 18 , 16, 50 )
	@ 14, 19 Say  "Data Emis Inicial..:" Get dIni    Pict "##/##/##"
	@ 15, 19 Say  "Data Emis Final....:" Get dFim    Pict "##/##/##"
	oBloco2 := {|| Recemov->Emis >= dIni .AND. Recemov->Emis <= dFim }
EndCase
Read
if LastKey() = ESC
	ResTela( cScreen )
	return
endif
if Recemov->(Lastrec()) = 0
	return
endif
if !InsTru80() .OR. !LptOk()
	ResTela( cScreen )
	return
endif
cTela := Mensagem("Aguarde, imprimindo.")
PrintOn()
FPrint( PQ )
SetPrc( 0 , 0 )
Area("ReceMov")
Recemov->(DbGoTop())
WHILE Recemov->(!Eof()) .AND. Rel_Ok()
	if nChoice = 1
		if !Eval( oBloco1 )
			Recemov->(DbSkip(1))
			Loop
		endif
	endif
	if nChoice = 2
		if !Eval( oBloco2 )
			Recemov->(DbSkip(1))
			Loop
		endif
	endif
	nAtraso	 := Atraso( dAtual, Vcto )
	nCarencia := Carencia( dAtual, Vcto )
	nMulta	 := VlrMulta( dAtual, Vcto, Vlr )
	nDesconto := VlrDesconto( dAtual, Vcto, Vlr )
	if nAtraso <= 0
		nJuros := 0
	else
		nJuros  := Jurodia * nCarencia
	endif
	if Col >= 57
		Qout( Padr( "Pagina N?" + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ))
		Qout( Dtoc( Date() ))
      Qout( Padc( AllTrim(oAmbiente:xNomefir), Tam ))
		Qout( Padc( SISTEM_NA3, Tam ))
		Qout( Padc( cTitulo , Tam ))
		Qout( Repl( "=", Tam ) )
		Qout("              QTDE DCTOS    TOTAL NOMINAL      TOTAL JUROS      TOTAL MULTA   TOTAL DESCONTO      TOTAL GERAL")
		Qout( Repl( "=", Tam ) )
		Col := 9
	endif
	nDocumento ++
	nTotalVlr  += Vlr
	nTotalJur  += nJuros
	nTotalGer  += (( Vlr + nJuros ) + nMulta ) - nDesconto
	nTotalMul  += nMulta
	nTotalDes  += nDesconto
	Recemov->(DbSkip(1))
EndDo
Qout("** Total Geral **", Tran( nDocumento, "999999" ),;
								  Tran( nTotalVlr, "@E 9,999,999,999.99" ),;
								  Tran( nTotalJur, "@E 9,999,999,999.99" ),;
								  Tran( nTotalMul, "@E 9,999,999,999.99" ),;
								  Tran( nTotalDes, "@E 9,999,999,999.99" ),;
								  Tran( nTotalGer, "@E 9,999,999,999.99" ))
__Eject()
PrintOff()
ResTela( cScreen )
return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc HelpReceber( cProc, nLine, cVar, nChoice )
***********************************************
LOCAL nKey := SetKey( F2 )
Set Key F2 To
PosiReceber( 1, NIL, cCaixa )
Set Key F2 To HelpReceber( 1 )
return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc Prn001( dIni, dFim, cTitulo )
**********************************
LOCAL cScreen		:= SaveScreen()
LOCAL Tam			:= 132
LOCAL Col			:= 58
LOCAL nDocumentos := 0
LOCAL nParDoc		:= 0
LOCAL Pagina		:= 0
LOCAL TotTit		:= 0
LOCAL TotRec		:= 0
LOCAL nParVlr		:= 0
LOCAL nParRec		:= 0
LOCAL nAtraso		:= 0
LOCAL cIni			:= Dtoc( dIni )
LOCAL cFim			:= Dtoc( dFim )
LOCAL Relato		:= "RELATORIO DE TITULOS RECEBIDOS " + AllTrim( cTitulo ) + " REF. " + cIni + " A " + cFim

PrintOn()
FPrint( PQ )
SetPrc( 0 , 0 )
WHILE ( !Eof() .AND. Rep_Ok())
	nAtraso := Atraso( DataPag, Vcto )
	if Col >= 56
		Write( 00, 00, Padr( "Pagina N?" + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
		Write( 01, 00, Date() )
      Write( 02, 00, Padc( AllTrim(oAmbiente:xNomefir), Tam ) )
		Write( 03, 00, Padc( SISTEM_NA3, Tam ) )
		Write( 04, 00, Padc( Relato, Tam ) )
		Write( 05, 00, Repl( SEP, Tam ) )
		Write( 06, 00, "CODI  NOME CLIENTE    EMISSAO  VENCTO   DOCTO N? TIPO   VLR TITULO DATA PGT   ATR   VLR PAGO PORTADOR OBSERVACOES")
		Write( 07, 00, Repl( SEP, Tam ) )
		Col := 08
	endif
	Qout( Codi, Receber->(Left( Nome, 15 )), Emis, Vcto, Docnr, Tipo,;
			Tran( Vlr, "@E 999,999.99"), DataPag, Tran( nAtraso, "99999"),;
			Tran( VlrPag, "@E 999,999.99"), Left( Port, Len( Port)-2), Left( Obs, 29 ))
	Col			++
	nDocumentos ++
	nParDoc		++
	nParVlr		+= Vlr
	nParRec		+= VlrPag
	TotTit		+= Vlr
	TotRec		+= VlrPag
	DbSkip(1)
	if Col >= 56
		Qout()
		Qout( " * Parcial *", Tran( nParDoc, "99999"), Space(31), Tran( nParVlr,"@E 9,999,999,999.99" ), Space(08), Tran( nParRec,"@E 9,999,999,999.99" ))
		nParDoc := 0
		nParVlr := 0
		nParRec := 0
		if !Eof()
			__Eject()
		endif
	endif
EndDo
Qout()
Qout( " * Parcial *", Tran( nParDoc,     "99999"), Space(31), Tran( nParVlr,"@E 9,999,999,999.99" ), Space(08), Tran( nParRec,"@E 9,999,999,999.99" ))
Qout( " ** Total **", Tran( nDocumentos, "99999"), Space(31), Tran( TotTit, "@E 9,999,999,999.99" ), Space(08), Tran( TotRec, "@E 9,999,999,999.99" ))
__Eject()
PrintOff()
ResTela( cScreen )
return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc RelCli()
*************
LOCAL cScreen	:= SaveScreen()
LOCAL nChoice	:= 0
LOCAL aTipo 	:= {" Completa ", " Parcial ", " Contrato" }

WHILE OK
	M_Title( "FICHA/RELACAO CLIENTES" )
	nChoice := FazMenu( 04, 17, aTipo, Cor())
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1
		RelCliCompleta()

	Case nChoice = 2
		RelCliParcial()

	Case nChoice = 3
		ContratoMaxMotors()

	EndCase
EndDo

*:---------------------------------------------------------------------------------------------------------------------------------

Proc RelCliCompleta()
*********************
LOCAL cScreen	:= SaveScreen()
LOCAL nChoice	:= 0
LOCAL nOpcao	:= 0
LOCAL nOrder	:= 1
LOCAL nField	:= 0
LOCAL AtPrompt := { "Individual ", "Por Regiao", "Por Cidade", "Por Estado", "Geral"}
LOCAL aOrdem	:= { "Ordem Nome", "Ordem Codigo", "Ordem Cidade+Nome", "Ordem Regiao", "Ordem Estado"}
LOCAL xAlias
LOCAL xNtx
LOCAL aStru
LOCAL xDado
LOCAL xOrder

WHILE OK
	xAlias := FTempName("T*.TMP*")
	xNtx	 := FTempName("T*.TMP*")
	M_Title( "FICHA/RELACAO CLIENTES" )
	nChoice := FazMenu( 06 , 20 ,  AtPrompt, Cor())
	if nChoice = 0		
		ResTela( cScreen )
		Exit
	endif	
	MaBox( 15 , 20 , 17 , 78 )
	Do Case
		Case nChoice = 1
			xDado  := Space(05)
		   xOrder := RECEBER_CODI 
			@ 16 , 21 Say "Cliente.:" Get xDado Pict PIC_RECEBER_CODI Valid RecErrado(@xDado,, Row(), Col()+1 )
		Case nChoice = 2				
			xDado  := Space(02)
		   xOrder := RECEBER_REGIAO 
			@ 16 , 21 Say "Regiao..:" Get xDado Pict "@!"             Valid RegiaoErrada(@xDado )
		Case nChoice = 3	
			xDado  := Space(25)
			xOrder := RECEBER_CIDA
			@ 16 , 21 Say "Cidade..:" Get xDado Pict "@!"
		Case nChoice = 4	
			xDado  := Space(02)
			xOrder := RECEBER_ESTA
			@ 16 , 21 Say "Estado..:" Get xDado Pict "@!"
		Case nChoice = 5
			xOrder := NATURAL
	endCase
	Read
	if LastKey( ) = ESC
		ResTela( cScreen )
		Loop
	endif
	Receber->(Order( xOrder ))
	if nChoice != 5
		if Receber->(!DbSeek( xDado ))
			Alerta("Erro: Parametros informados nao Localizado.")
			ResTela( cScreen )
			Loop
		endif
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		xTemp->(DbAppend())
		For nField := 1 To FCount()
			xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
		Next
	else	
		Area("Receber")
		Receber->(DbGoTop())
	endif
	
	WHILE OK
		//oMenu:Limpa()
		M_Title("ESCOLHA A ORDEM A IMPRIMIR. ESC RETORNA")
		nOpcao := FazMenu( 18 , 20 , aOrdem )
		if nChoice != 5
			if nOpcao = 0 // Sair ?
				xTemp->(DbCloseArea())
				Ferase( xAlias )
				Ferase( xNtx )
				ResTela( cScreen )
				Exit
			elseif nOpcao = 1 // Por Nome
				 Mensagem("Aguarde, Ordenando Por Nome. ")
				 Area("xTemp")
				 Inde On xTemp->Codi To ( xNtx )
			 elseif nOpcao = 2 // Por Nome
				 Mensagem("Aguarde, Ordenando Por Nome. ")
				 Area("xTemp")
				 Inde On xTemp->Nome To ( xNtx )
			 elseif nOpcao = 3 // Cidade+Nome
				 Mensagem("Aguarde, Ordenando Por Cidade+Nome. ")
				 Area("xTemp")
				 Inde On xTemp->Cida + xTemp->Nome To ( xNtx )
			 elseif nOpcao = 4 // Regiao
				 Mensagem("Aguarde, Ordenando Por Regiao. ")
				 Area("xTemp")
				 Inde On xTemp->Regiao To ( xNtx )
			 elseif nOpcao = 5 // Esta
				 Mensagem("Aguarde, Ordenando Por Estado. ")
				 Area("xTemp")
				 Inde On xTemp->Esta To ( xNtx )
			endif
			xTemp->(DbGoTop())
		else
			if nOpcao = 0 // Sair ?
				ResTela( cScreen )
				Exit
			endif
			Area("Receber")
			Receber->(Order( nOpcao ))
			Receber->(DbGoTop())
		endif
		oMenu:Limpa()
		if !Instru80() .OR. !LptOk()
			ResTela( cScreen )
			Loop
		endif
		Mensagem("Aguarde, Imprimindo.")
		ListaCli( nOpcao )
		if nChoice != 5
			xTemp->(DbClearIndex())
		endif
	EndDo
EndDo
ResTela( cScreen )
return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc ContratoMaxMotors()
************************
LOCAL cScreen	:= SaveScreen()
LOCAL nChoice	:= 0
LOCAL nOpcao	:= 0
LOCAL cCodi 	:= Space(04)
LOCAL cRegiao	:= Space(02)
LOCAL cEsta 	:= Space(02)
LOCAL cCida 	:= Space(25)
LOCAL nOrder	:= 1
LOCAL nField	:= 0
LOCAL AtPrompt := { "Individual ", "Por Regiao", "Por Cidade", "Por Estado", "Geral"}
LOCAL aOrdem	:= { "Ordem Nome", "Ordem Codigo", "Ordem Cidade+Nome", "Ordem Regiao", "Ordem Estado"}
LOCAL xAlias
LOCAL xNtx
LOCAL aStru

WHILE OK
	xAlias := FTempName("t*.tmp")
	xNtx	 := FTempName("t*.tmp")
	M_Title( "FICHA/RELACAO CLIENTES" )
	nChoice := FazMenu(06 , 20 ,  AtPrompt)
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1
		Area("Receber")
		cCodi := Space(05)
		MaBox( 19 , 20 , 21 , 78 )
		@ 20 , 21 Say	"Cliente.:" Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
		Read
		if LastKey( ) = ESC
			ResTela( cScreen )
			Loop
		endif
		Receber->(Order( RECEBER_CODI ))
		if Receber->(!DbSeek( cCodi ))
			Alerta("Erro: Cliente nao Localizado.")
			Loop
		endif
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		xTemp->(DbAppend())
		For nField := 1 To FCount()
			xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
		Next

	Case nChoice = 2
		cRegiao := Space( 02 )
		MaBox( 19 , 20 , 21 , 33 )
		@ 20 , 21 Say "Regiao..:" Get cRegiao Pict "@!" Valid RegiaoErrada( @cRegiao )
		Read
		if LastKey() = ESC
			Loop
		endif
		Receber->(Order( RECEBER_REGIAO ))
		if Receber->(!DbSeek( cRegiao ))
			Alerta("Erro: Nenhum Cliente Registrado nesta Regiao.")
			Loop
		endif
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		WHILE Receber->Regiao = cRegiao
			xTemp->(DbAppend())
			For nField := 1 To FCount()
				xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
			Next
			Receber->(DbSkip(1))
		EnDDo

	Case nChoice = 3
		cCida := Space( 25 )
		MaBox( 19 , 20 , 21 , 56 )
		@ 20, 21 Say "Cidade..:" Get cCida Pict "@!"
		Read
		if LastKey() = ESC
			Loop
		endif
		Receber->(Order( RECEBER_CIDA ))
		if Receber->(!DbSeek( cCida ))
			Alerta("Erro: Nenhum Cliente Registrado nesta Cidade.")
			Loop
		endif
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		WHILE Receber->Cida = cCida
			xTemp->(DbAppend())
			For nField := 1 To FCount()
				xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
			Next
			Receber->(DbSkip(1))
		Enddo

	Case nChoice = 4
		cEsta := Space( 02 )
		MaBox( 19 , 20 , 21 , 56 )
		@ 20, 21 Say "Estado..:" Get cEsta Pict "@!"
		Read
		if LastKey() = ESC
			Loop
		endif
		Receber->(Order( RECEBER_ESTA ))
		if Receber->(!DbSeek( cEsta ))
			Alerta("Erro: Nenhum Cliente Registrado neste Estado.")
			Loop
		endif
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		WHILE Receber->Esta = cEsta
			xTemp->(DbAppend())
			For nField := 1 To FCount()
				xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
			Next
			Receber->(DbSkip(1))
		EndDo

	Case nChoice = 5
		Area("Receber")
		Receber->(DbGoTop())
	EndCase
	WHILE OK
		oMenu:Limpa()
		M_Title("ESCOLHA A ORDEM A IMPRIMIR. ESC RETORNA")
		nOpcao := FazMenu( 05, 10, aOrdem )
		if nChoice != 5
			if nOpcao = 0 // Sair ?
				xTemp->(DbCloseArea())
				Ferase( xAlias )
				Ferase( xNtx )
				ResTela( cScreen )
				Exit
			elseif nOpcao = 1 // Por Nome
				 Mensagem("Aguarde, Ordenando Por Nome.")
				 Area("xTemp")
				 Inde On xTemp->Codi To ( xNtx )
			 elseif nOpcao = 2 // Por Nome
				 Mensagem("Aguarde, Ordenando Por Nome.")
				 Area("xTemp")
				 Inde On xTemp->Nome To ( xNtx )
			 elseif nOpcao = 3 // Cidade+Nome
				 Mensagem("Aguarde, Ordenando Por Cidade+Nome.")
				 Area("xTemp")
				 Inde On xTemp->Cida + xTemp->Nome To ( xNtx )
			 elseif nOpcao = 4 // Regiao
				 Mensagem("Aguarde, Ordenando Por Regiao.")
				 Area("xTemp")
				 Inde On xTemp->Regiao To ( xNtx )
			 elseif nOpcao = 5 // Esta
				 Mensagem("Aguarde, Ordenando Por Estado.")
				 Area("xTemp")
				 Inde On xTemp->Esta To ( xNtx )
			endif
			xTemp->(DbGoTop())
		else
			if nOpcao = 0 // Sair ?
				ResTela( cScreen )
				Exit
			endif
			Area("Receber")
			Receber->(Order( nOpcao ))
			Receber->(DbGoTop())
		endif
		oMenu:Limpa()
		if !Instru80() .OR. !LptOk()
			ResTela( cScreen )
			Loop
		endif
		Mensagem("Aguarde, Imprimindo.")
		ListaContrato( nOpcao )
		if nChoice != 5
			xTemp->(DbClearIndex())
		endif
	EndDo
EndDo
ResTela( cScreen )
return

*:---------------------------------------------------------------------------------------------------------------------------------
Proc ListaContrato( nOrdem )
****************************
LOCAL cScreen := SaveScreen()
LOCAL lSair   := OK
LOCAL cRegiao := Regiao
LOCAL Tam	  := 80
LOCAL Col	  := 6
LOCAL Pagina  := 0
LOCAL Titulo

Regiao->(Order( REGIAO_REGIAO ))
if Regiao->(DbSeek( cRegiao))
	cRegiao := Regiao->Nome
endif
PrintOn()
SetPrc( 0, 0 )
FPrint( _CPI12 )
WHILE !Eof() .AND. Rel_Ok() .AND. !Eof()
	Write( 10, 00, "")
	Write( Prow()+1, 00, NG + "II - DO COMPRADOR" + NR)
	Write( Prow()+1, 00, Repl( SEP , Tam ))
	Write( Prow()+1, 00, "Nome Completo")
	Write( Prow()+1, 00, NG + Nome  + NR )
	Write( Prow()+1, 00, "Endereco Comercial")
	Write( Prow(),   48, "Bairro")
	Write( Prow(),   69, "Fone")
	Write( Prow()+1, 00, Ende )
	Write( Prow(),   48, Bair )
	Write( Prow(),   69, Fone )
	Write( Prow()+1, 00, "Cidade")
	Write( Prow(),   48, "Estado")
	Write( Prow()+1, 00, Cep + "/" + Cida )
	Write( Prow(),   48, Esta )
	Write( Prow()+1, 00, "CIC")
	Write( Prow(),   48, "Carteira de Identidade N§")
	Write( Prow()+1, 00, Cpf )
	Write( Prow(),   48, Rg )
	Write( Prow()+1, 00, "CGC/MF")
	Write( Prow(),   48, "Inscricao Estadual")
	Write( Prow()+1, 00, Cgc )
	Write( Prow(),   48, Insc )
	Write( Prow()+1, 00, "Data Nascimento")
	Write( Prow(),   48, "Estado Civil")
	Write( Prow()+1, 00, + Dtoc( Nasc ))
	Write( Prow(),   48, Civil )

	Write( Prow()+1, 00, "Profissao")
	Write( Prow()+1, 00, Profissao )
	Write( Prow()+1, 00, "Endereco Residencial")
	Write( Prow(),   48, "Bairro")
	Write( Prow()+1, 00, Ende1 )
	Write( Prow(),   48, Bair )
	Write( Prow()+1, 00, "Cidade")
	Write( Prow(),   48, "Estado")
	Write( Prow()+1, 00, Cep + "/" + Cida )
	Write( Prow(),   48, Esta )
	Write( Prow()+1, 00, "Telefone Residencial")
	Write( Prow()+1, 00, Fone1 )
	Write( Prow()+2, 00, NG + "III - DA MERCADORIA OBJETO" + NR)
	Write( Prow()+1, 00, Repl( SEP , Tam ))
	Write( Prow()+1, 00, "Fabricante")
	Write( Prow()+1, 00, Fabricante )
	Write( Prow()+1, 00, "Produto")
	Write( Prow()+1, 00, Produto )
	Write( Prow()+1, 00, "Modelo")
	Write( Prow()+1, 00, Modelo )
	Write( Prow()+2, 00, NG + "IV - DO VALOR DA MERCADORIA OBJETO" + NR)
	Write( Prow()+1, 00, Repl( SEP , Tam ))
	Write( Prow()+1, 00, "Valor da Mercadoria nesta Data")
	Write( Prow(),   48, "Local da Venda")
	Write( Prow()+1, 00, Tran( Valor, "@E 999,999,999.99"))
	Write( Prow(),   48, Local )
	Write( Prow()+2, 00, NG + "V - DO PRAZO DE PAGAMENTO" + NR)
	Write( Prow()+1, 00, Repl( SEP , Tam ))
	Write( Prow()+1, 00, "N?de Prestacoes Contratadas")
	Write( Prow()+1, 00, Tran( Prazo, "999"))
	Write( Prow()+2, 00, NG + "VI - DATA DE VENCIMENTO DAS PRESTACOES" + NR)
	Write( Prow()+1, 00, Repl( SEP , Tam ))
	Write( Prow()+1, 00, "Dia do vencimento das prestacoes mensais nos meses seguintes")
	Write( Prow()+1, 00, Tran( DataVcto, "99"))
	DbSkip(1)
	__Eject()
EndDo
PrintOff()
ResTela( cScreen )
return

Proc ListaCli( nOrdem )
***********************
LOCAL cScreen := SaveScreen()
LOCAL lSair   := OK
LOCAL cRegiao := Regiao
LOCAL Tam	  := CPI1280
LOCAL Col	  := 6
LOCAL Pagina  := 0
LOCAL Titulo

Regiao->(Order( REGIAO_REGIAO ))
if Regiao->(DbSeek( cRegiao))
	cRegiao := Regiao->Nome
endif
if nOrdem = 2
	Titulo := "LISTAGEM DE CLIENTES DA REGIAO " + AllTrim( cRegiao )
else
	Titulo := "LISTAGEM DE CLIENTES"
endif
PrintOn()
SetPrc( 0 , 0 )
FPrint( _CPI12 )
Pagina++
Write( 00 ,  000, "Pagina N?"+ StrZero( Pagina , 3 ))
Write( 00 ,  065, "Horas "+ Time( ) )
Write( 01 ,  000,  Dtoc( Date( ) ) )
Write( 02 ,  000,  Padc( AllTrim(oAmbiente:xNomefir), Tam ))
Write( 03 ,  000,  Padc( SISTEM_NA3, Tam))
Write( 04 ,  000,  Padc( Titulo, Tam))
Col := 5
WHILE !Eof() .AND. Rel_Ok() .AND. !Eof()
	if Col >= 57
		__Eject()
		Pagina++
		Write( 00 ,  000, "Pagina N?"+ StrZero( Pagina , 3 ))
		Write( 00 ,  065, "Horas "+ Time( ) )
		Write( 01 ,  000,  Dtoc( Date( ) ) )
      Write( 02 ,  000,  Padc( AllTrim(oAmbiente:xNomefir), Tam ))
		Write( 03 ,  000,  Padc( SISTEM_NA3, Tam))
		Write( 04 ,  000,  Padc( Titulo, Tam))
		Col := 5
	endif
	Write( Col++, 00, Repl( SEP , Tam ))
	Write( Col,   00, "Codigo.........: " + Codi )
	Write( Col++, 48, "Cadastro.: "       + Dtoc( Data ))
	Write( Col++, 00, "Nome...........: " + Nome )
	Write( Col,   00, "Endereco.......: " + Ende )
	Write( Col++, 48, "E. Civil.: "       + Civil )
	Write( Col,   00, "Cidade.........: " + Cida )
	Write( Col,   48, "Estado...: "       + Esta )
	Write( Col++, 64, "CEP.: "            + Cep )
	Write( Col,   00, "Natural........: " + Natural )
	Write( Col++, 48, "Nascto...: "       + Dtoc( Nasc ))
	Write( Col,   00, "Identidade n?.: " + Rg )
	Write( Col++, 48, "CPF......: "       + Cpf )
	Write( Col,   00, "Insc. Estadual.: " + Insc )
	Write( Col++, 48, "CGC/MF...: "       + Cgc )
	Write( Col,   00, "Telefone.......: " + Fone )
	Write( Col++, 48, "Fax......: "       + Fax )
	Write( Col++, 00, "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ")
	Write( Col,   00, "Esposo(a)......: " + Esposa )
	Write( Col++, 58, "Dependentes..: "   + StrZero( Depe, 2))
	Write( Col++, 00, "Pai............: " + Pai )
	Write( Col++, 00, "Mae............: " + Mae )
	Write( Col,   00, "Endereco.......: " + Ende1 )
	Write( Col++, 48, "Fone.: "           + Fone )
	Write( Col++, 00, "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ")
	Write( Col,   00, "Profissao......: " + Profissao )
	Write( Col++, 48, "Cargo.: "          + Cargo )
	Write( Col,   00, "Trabalho Atual.: " + Trabalho  )
	Write( Col++, 48, "Fone..: "          + Fone2 )
	Write( Col,   00, "Tempo Servico..: " + Tempo )
	Write( Col++, 48, "Renda Mensal...: " + Tran( Media , "@E 99,999,999.99" ))
	Write( Col,   00, "Autoriza Compra: " + if( Autorizaca, "SIM", "NAO"))
	Write( Col++, 48, "Assinou Autoriz: " + if( AssAutoriz, "SIM", "NAO"))
	Write( Col++, 00, "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ")
	Write( Col,   00, "Referencia.....: " + RefBco )
	Write( Col++, 65, "Spc...: " + if( Spc, "SIM", "NAO" ))
	Write( Col++, 00, "Referencia.....: " + RefCom)
	Write( Col++, 00, "Bens Imoveis...: " + Imovel )
	Write( Col++, 00, "Veiculos.......: " + Veiculo )
	Write( Col++, 00, "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ")
	Write( Col++, 00, "Avalista.......: " + Conhecida )
	Write( Col++, 00, "Endereco.......: " + Ende3 )
	Write( Col,   00, "Cidade.........: " + CidaAval )
	Write( Col++, 48, "Estado...: " + EstaAval )
	Write( Col,   00, "Endereco.......: " + Ende3 )
	Write( Col++, 48, "Bairro...: " + BairAval )
	Write( Col,   00, "Telefone.......: " + FoneAval )
	Write( Col++, 48, "Fax......: " + FaxAval )
	Write( Col,   00, "Rg n?.........: " + RgAval )
	Write( Col++, 48, "Cpf......: " + CpfAval )
	Write( Col++, 00, "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ")
	Write( Col++, 00, "Observacoes....: " + Obs )
	Write( Col++, 00, "                 " + Obs1  )
	Write( Col++, 00, "                 " + Obs2  )
	Write( Col++, 00, "                 " + Obs3  )
	Write( Col++, 00, "                 " + Obs4  )
	Write( Col++, 00, "                 " + Obs5  )
	Write( Col++, 00, "                 " + Obs6  )
	Write( Col++, 00, "                 " + Obs7  )
	Write( Col++, 00, "                 " + Obs8  )
	Write( Col++, 00, "                 " + Obs9  )
	Write( Col++, 00, "                 " + Obs10 )
	Col += 1

	Write( Col+01, 00, "________________________________________  _______________________________________")
	Write( Col+02, 00, "AUTORIZO COMPRAR EM MINHA FICHA")

	Write( Col+05, 00, "________________________________________  _______________________________________")
	Write( Col+06, 00,  Nome )
	Write( Col+06, 42,  Conhecida )

	Write( Col+09, 00, "________________________________________  _______________________________________")
	Write( Col+10, 00, Esposa )
   Write( Col+10, 42, AllTrim(oAmbiente:xNomefir) )
	Col := 58
	DbSkip(1)
EndDo
__Eject()
PrintOff()
ResTela( cScreen )
return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc RelCliParcial()
*********************
LOCAL cScreen	:= SaveScreen()
LOCAL nChoice	:= 0
LOCAL nOpcao	:= 0
LOCAL cCodi 	:= Space(05)
LOCAL cCodifim := Space(05)
LOCAL cRegiao	:= Space(02)
LOCAL cEsta 	:= Space(02)
LOCAL cCida 	:= Space(25)
LOCAL nOrder	:= 1
LOCAL nField	:= 0
LOCAL nDias 	:= 0
LOCAL dIni		:= Date()-30
LOCAL dFim		:= Date()
LOCAL AtPrompt := { "Individual ", "Por Regiao", "Por Cidade", "Por Estado", "Geral", "Data Abertura", "Quantitativo de Clientes", "Com Debito e Negativado SPC", "Sem Debito e Negativado SPC", "Com Debito e Positivado SPC", "Clientes com Contrato Ativo", "Clientes Com Contrato Vencido", "Clientes com Contrato Cancelado", "Ultima Compra" }
LOCAL aOrdem	:= { "Ordem Nome", "Ordem Codigo", "Ordem Cidade+Nome", "Ordem Regiao", "Ordem Estado", "Ordem Fantasia"}
LOCAL aTipo 	:= { 'Geral', 'Por Regiao'}
LOCAL xAlias
LOCAL xNtx
LOCAL nTipo
LOCAL aStru
LOCAL cRegiaoIni
LOCAL cRegiaoFim

WHILE OK
	xAlias := FTempName("t*.tmp")
	xNtx	 := FTempName("t*.tmp")
	M_Title( "FICHA/RELACAO CLIENTES" )
	nChoice := FazMenu( 06, 20 ,	AtPrompt, Cor())
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1
		Area("Receber")
		cCodi := Space(05)
		MaBox( 19 , 20 , 21 , 78 )
		@ 20 , 21 Say	"Cliente.:" Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
		Read
		if LastKey( ) = ESC
			ResTela( cScreen )
			Loop
		endif
		Receber->(Order( RECEBER_CODI ))
		if Receber->(!DbSeek( cCodi ))
			Alerta("Erro: Cliente nao Localizado.")
			ResTela( cScreen )
			Loop
		endif
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		xTemp->(DbAppend())
		For nField := 1 To FCount()
			xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
		Next

	Case nChoice = 2
		cRegiao := Space( 02 )
		MaBox( 19 , 20 , 21 , 33 )
		@ 20 , 21 Say "Regiao..:" Get cRegiao Pict "@!" Valid RegiaoErrada( @cRegiao )
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Receber->(Order( RECEBER_REGIAO ))
		if Receber->(!DbSeek( cRegiao ))
			Alerta("Erro: Nenhum Cliente Registrado nesta Regiao.")
			ResTela( cScreen )
			Loop
		endif
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		WHILE Receber->Regiao = cRegiao
			xTemp->(DbAppend())
			For nField := 1 To FCount()
				xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
			Next
			Receber->(DbSkip(1))
		EndDo

	Case nChoice = 3
		cCida := Space( 25 )
		MaBox( 19 , 20 , 21 , 56 )
		@ 20, 21 Say "Cidade..:" Get cCida Pict "@!"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Receber->(Order( RECEBER_CIDA ))
		if Receber->(!DbSeek( cCida ))
			Alerta("Erro: Nenhum Cliente Registrado nesta Cidade.")
			ResTela( cScreen )
			Loop
		endif
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use (xAlias) Exclusive Alias xTemp New
		WHILE Receber->Cida = cCida
			xTemp->(DbAppend())
			For nField := 1 To FCount()
				xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
			Next
			Receber->(DbSkip(1))
		Enddo

	Case nChoice = 4
		cEsta := Space( 02 )
		MaBox( 19 , 20 , 21 , 56 )
		@ 20, 21 Say "Estado..:" Get cEsta Pict "@!"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Receber->(Order( RECEBER_ESTA ))
		if Receber->(!DbSeek( cEsta ))
			ResTela( cScreen )
			Alerta("Erro: Nenhum Cliente Registrado neste Estado.")
			Loop
		endif
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		WHILE Receber->Esta = cEsta
			xTemp->(DbAppend())
			For nField := 1 To FCount()
				xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
			Next
			Receber->(DbSkip(1))
		Enddo

	Case nChoice = 5
		Area("Receber")
		Receber->(DbGoTop())

	Case nChoice = 6
		dIni		  := Date()- 30
		dFim		  := Date()
		cRegiaoIni := Space(02)
		cRegiaoFim := Space(02)
		MaBox( 18 , 20 , 23 , 78 )
		@ 19, 21 Say  "Regiao Inicial...:" Get cRegiaoIni Pict "99" Valid RegiaoErrada( @cRegiaoIni )
		@ 20, 21 Say  "Regiao Final.....:" Get cRegiaoFim Pict "99" Valid RegiaoErrada( @cRegiaoFim )
		@ 21, 21 Say  "Abertura Inicial.:" Get dIni Pict "##/##/##"
		@ 22, 21 Say  "Abertura Final...:" Get dFim Pict "##/##/##" Valid if( dFim < dIni, ( ErrorBeep(), Alerta("Erro: Data final maior que inicial."), FALSO ), OK )
		Read
		if LastKey( ) = ESC
			ResTela( cScreen )
			Loop
		endif
		ErrorBeep()
		if !Conf("Informa: Relatorio podera demorar. Continuar ?")
			ResTela( cScreen )
			Loop
		endif
		lAchou := FALSO
		Receber->(Order( RECEBER_REGIAO ))
		For nX := Val( cRegiaoIni ) To Val( cRegiaoFim )
			if Receber->(DbSeek( StrZero( nX, 2 )))
				lAchou := OK
				Exit
			endif
		Next
		if !lAchou
			ErrorBeep()
			Nada()
			Loop
		endif
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		Mensagem("Aguarde, Trabalhando Duro.")
		WHILE Receber->Regiao >= cRegiaoIni .AND. Receber->Regiao <= cRegiaoFim
			if Receber->Data >= dIni .AND. Receber->Data <= dFim
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
				Next
			endif
			Receber->(DbSkip(1))
		EndDo

	Case nChoice = 7
		ErrorBeep()
		if !Conf("Informa: Relatorio podera demorar. Continuar ?")
			ResTela( cScreen )
			Loop
		endif
		Receber->(Order( RECEBER_CODI ))
		Receber->(DbGoTop())
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		Mensagem("Aguarde, Trabalhando Duro.")
		WHILE Receber->(!Eof())
			xTemp->(DbAppend())
			For nField := 1 To FCount()
				xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
			Next
			Receber->(DbSkip(1))
		EndDo

	Case nChoice = 8 // Com Debitos e Negativado SPC
		ErrorBeep()
		if !Conf("Informa: Relatorio podera demorar. Continuar ?")
			ResTela( cScreen )
			Loop
		endif
		Receber->(Order( RECEBER_CODI ))
		Receber->(DbGoTop())
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		Mensagem("Aguarde, Trabalhando Duro.")
		WHILE Receber->(!Eof())
			if Receber->Spc = OK
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
				Next
			endif
			Receber->(DbSkip(1))
		EndDo

	Case nChoice = 9 // Sem Debitos e Negativado SPC
		ErrorBeep()
		if !Conf("Informa: Relatorio podera demorar. Continuar ?")
			ResTela( cScreen )
			Loop
		endif
		Receber->(Order( RECEBER_CODI ))
		Receber->(DbGoTop())
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		Mensagem("Aguarde, Trabalhando Duro.")
		WHILE Receber->(!Eof())
			if Receber->Spc = OK
				if Recemov->(!DbSeek( Receber->Codi ))
					xTemp->(DbAppend())
					For nField := 1 To FCount()
						xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
					Next
				endif
			endif
			Receber->(DbSkip(1))
		EndDo

	Case nChoice = 10 // Com Debito e Positivado SPC
		cCodi 	:= Space(05)
		cCodifim := Space(05)
		MaBox( 19 , 20 , 22 , 78 )
		@ 20 , 21 Say	"Do  Cliente.:" Get cCodi    Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
		@ 21 , 21 Say	"Ate Cliente.:" Get cCodifim Pict PIC_RECEBER_CODI Valid RecErrado( @cCodifim,, Row(), Col()+1 )
		Read
		if LastKey( ) = ESC
			ResTela( cScreen )
			Loop
		endif
		ErrorBeep()
		if !Conf("Informa: Relatorio podera demorar. Continuar ?")
			ResTela( cScreen )
			Loop
		endif
		Receber->(Order( RECEBER_CODI ))
		Receber->(DbGoTop())
		aStru  := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		Mensagem("Aguarde, Trabalhando Duro.")
		if Receber->(DbSeek( cCodi ))
			WHILE Receber->Codi >= cCodi .AND. Receber->Codi <= cCodifim
				if Receber->Spc = FALSO
					if Recemov->(DbSeek( Receber->Codi ))
						xTemp->(DbAppend())
						For nField := 1 To FCount()
							xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
						Next
					endif
				endif
				Receber->(DbSkip(1))
			EndDo
		endif

	Case nChoice = 11
		M_Title( "FICHA/RELACAO CLIENTES-TIPO" )
		nTipo := FazMenu( 08, 22 , aTipo )
		Do Case
		Case nTipo = 0
			ResTela( cScreen )
			Loop
		Case nTipo = 1
			ErrorBeep()
			if !Conf("Informa: Relatorio podera demorar. Continuar ?")
				ResTela( cScreen )
				Loop
			endif
			Receber->(Order( RECEBER_REGIAO ))
			aStru := Receber->(DbStruct())
			DbCreate( xAlias, aStru )
			Use ( xAlias ) Exclusive Alias xTemp New
			Receber->(DbGoTop())
			WHILE Receber->(!Eof())
				if Receber->Suporte = OK
					xTemp->(DbAppend())
					For nField := 1 To FCount()
						xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
					Next
				endif
				Receber->(DbSkip(1))
			EndDo

		Case nTipo = 2
			cRegiao := Space( 02 )
			MaBox( 21 , 55 , 23 , 80 )
			@ 22 , 56 Say "Regiao..:" Get cRegiao Pict "@!" Valid RegiaoErrada( @cRegiao)
			Read
			if LastKey() = ESC
				ResTela( cScreen )
				Loop
			endif
			ErrorBeep()
			if !Conf("Informa: Relatorio podera demorar. Continuar ?")
				ResTela( cScreen )
				Loop
			endif
			Receber->(Order( RECEBER_REGIAO ))
			if Receber->(!DbSeek( cRegiao ))
				Alerta("Erro: Nenhum Cliente Registrado nesta Regiao.")
				ResTela( cScreen )
				Loop
			endif
			aStru := Receber->(DbStruct())
			DbCreate( xAlias, aStru )
			Use ( xAlias ) Exclusive Alias xTemp New
			WHILE Receber->Regiao = cRegiao
				if Receber->Suporte = OK
					xTemp->(DbAppend())
					For nField := 1 To FCount()
						xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
					Next
				endif
				Receber->(DbSkip(1))
			EndDo

		EndCase
	Case nChoice = 12 // Contrato Suporte Vencido
		ErrorBeep()
		if !Conf("Informa: Relatorio podera demorar. Continuar ?")
			ResTela( cScreen )
			Loop
		endif
		Recemov->(Order( RECEMOV_CODI ))
		Receber->(Order( RECEBER_CODI ))
		Receber->(DbGoTop())
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		Mensagem("Aguarde, Trabalhando Duro.")
		WHILE Receber->(!Eof())
			if Receber->Suporte = OK
				lIncluir := OK
				if Recemov->(DbSeek( Receber->Codi ))
					While Recemov->Codi = Receber->Codi
						if Recemov->Vcto >= Date()
							lIncluir := FALSO
						endif
						Recemov->(DbSkip(1))
					EndDo
				endif
				if lIncluir = OK
					xTemp->(DbAppend())
					For nField := 1 To FCount()
						xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
					Next
				endif
			endif
			Receber->(DbSkip(1))
		EndDo
		
	Case nChoice = 13 // Clientes com Contrato Cancelado
		M_Title( "FICHA/RELACAO CLIENTES-TIPO" )
		nTipo := FazMenu( 08, 22 , aTipo )
		Do Case
		Case nTipo = 0
			ResTela( cScreen )
			Loop
		Case nTipo = 1
			ErrorBeep()
			if !Conf("Informa: Relatorio podera demorar. Continuar ?")
				ResTela( cScreen )
				Loop
			endif
			Receber->(Order( RECEBER_REGIAO ))
			aStru := Receber->(DbStruct())
			DbCreate( xAlias, aStru )
			Use ( xAlias ) Exclusive Alias xTemp New
			Receber->(DbGoTop())
			WHILE Receber->(!Eof())
				if Receber->Suporte = FALSO
					xTemp->(DbAppend())
					For nField := 1 To FCount()
						xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
					Next
				endif
				Receber->(DbSkip(1))
			EndDo

		Case nTipo = 2
			cRegiao := Space( 02 )
			MaBox( 21 , 55 , 23 , 80 )
			@ 22 , 56 Say "Regiao..:" Get cRegiao Pict "@!" Valid RegiaoErrada(@cRegiao)
			Read
			if LastKey() = ESC
				ResTela( cScreen )
				Loop
			endif
			ErrorBeep()
			if !Conf("Informa: Relatorio podera demorar. Continuar ?")
				ResTela( cScreen )
				Loop
			endif
			Receber->(Order( RECEBER_REGIAO ))
			if Receber->(!DbSeek( cRegiao ))
				Alerta("Erro: Nenhum Cliente Registrado nesta Regiao.")
				ResTela( cScreen )
				Loop
			endif
			aStru := Receber->(DbStruct())
			DbCreate( xAlias, aStru )
			Use ( xAlias ) Exclusive Alias xTemp New
			WHILE Receber->Regiao = cRegiao
				if Receber->Suporte = FALSO
					xTemp->(DbAppend())
					For nField := 1 To FCount()
						xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
					Next
				endif
				Receber->(DbSkip(1))
			EndDo
		EndCase	
		
	Case nChoice = 14 // Ultima Compra
		oMenu:Limpa()
		Area("Receber")
		nDias 	:= 0
		cDebitos := Space(1)
		cRegiao	:= Space( 02 )
		MaBox( 10, 10, 14, 45 )
		@ 11, 11 Say "Regiao...................:" Get cRegiao  Pict "@!" Valid RegiaoErrada( @cRegiao )
		@ 12, 11 Say "Dias da Ultima Compra....:" Get nDias    Pict "999"
		@ 13, 11 Say "Imprimir se tem Debito...:" Get cDebitos Pict "!" Valid cDebitos $ "SN"
		Read
		if LastKey() = ESC .OR. !Conf("Pergunta: Confirma Procura ?")
			ResTela( cScreen )
			Loop
		endif
		Receber->(Order( RECEBER_REGIAO ))
		if Receber->(!DbSeek( cRegiao ))
			Alerta("Erro: Nenhum Cliente Registrado nesta Regiao.")
			ResTela( cScreen )
			Loop
		endif
		ErrorBeep()
		lCancelado := Conf('Pergunta: Incluir Cancelados?')
		if !lCancelado
			if Receber->Cancelada
				Saidas->(DbSkip(1))
				Loop
			endif
		endif
		oMenu:Limpa()
		Mensagem("Aguarde, Varrendo Arquivo." )
		Recemov->(Order( RECEMOV_CODI ))
		Receber->(Order( RECEBER_REGIAO ))
		Receber->(DbSeek( cRegiao ))
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		WHILE Receber->Regiao = cRegiao
			if !lCancelado
				if Receber->Cancelada
					Receber->(DbSkip(1))
					Loop
				endif
			endif
			cCodi := Receber->Codi
			if ( Date() - Receber->UltCompra ) >= nDias
				if cDebitos = "N"
					if Recemov->(DbSeek( cCodi ))
						Receber->(DbSkip(1))
						Loop
					endif
				endif
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
				Next
			endif
			Receber->(DbSkip(1))
		EndDo
	EndCase
	WHILE OK
		oMenu:Limpa()
		M_Title("ESCOLHA A ORDEM A IMPRIMIR. ESC RETORNA")
		nOpcao := FazMenu( 05, 10, aOrdem )
		if nChoice != 5
			if nOpcao = 0 // Sair ?
				xTemp->(DbCloseArea())
				Ferase( xAlias )
				Ferase( xNtx )
				ResTela( cScreen )
				Exit
			elseif nOpcao = 1 // Por Nome
				 Mensagem(" Aguarde, Ordenando Por Nome.")
				 Area("xTemp")
				 Inde On xTemp->Nome To ( xNtx )
			 elseif nOpcao = 2 // Por Codi
				 Mensagem(" Aguarde, Ordenando Por Nome.")
				 Area("xTemp")
				 Inde On xTemp->Codi To ( xNtx )
			 elseif nOpcao = 3 // Cidade+Nome
				 Mensagem(" Aguarde, Ordenando Por Cidade+Nome.")
				 Area("xTemp")
				 Inde On xTemp->Cida + xTemp->Nome To ( xNtx )
			 elseif nOpcao = 4 // Regiao
				 Mensagem(" Aguarde, Ordenando Por Regiao.")
				 Area("xTemp")
				 Inde On xTemp->Regiao To ( xNtx )
			 elseif nOpcao = 5 // Esta
				 Mensagem(" Aguarde, Ordenando Por Estado.")
				 Area("xTemp")
				 Inde On xTemp->Esta To ( xNtx )
			 elseif nOpcao = 6 // Fantasia
				 Mensagem(" Aguarde, Ordenando Por Fantasia.")
				 Area("xTemp")
				 Inde On xTemp->Fanta To ( xNtx )
			endif
			xTemp->(DbGoTop())
		else
			if nOpcao = 0 // Sair ?
				ResTela( cScreen )
				Exit
			endif
			Area("Receber")
			Receber->(Order( nOpcao ))
			Receber->(DbGoTop())
		endif
		oMenu:Limpa()
		if !Instru80() .OR. !LptOk()
			ResTela( cScreen )
			Loop
		endif
		Mensagem("Aguarde, Imprimindo.")
		Prn009( nOpcao, nChoice, atPrompt )
		if nChoice != 5
			xTemp->(DbClearIndex())
		endif
	EndDo
EndDo
ResTela( cScreen )
return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc Prn009( nOpcao, nChoice, atPrompt )
****************************************
LOCAL cScreen	  := SaveScreen()
LOCAL lSair 	  := FALSO
LOCAL Tam		  := 132
LOCAL Col		  := 58
LOCAL Pagina	  := 0
LOCAL cNome 	  := Space(0)
LOCAL cRegiao	  := Regiao
LOCAL nTotal	  := 0
LOCAL nCancel	  := 0
LOCAL nTotRegiao := 0
LOCAL nCanRegiao := 0
LOCAL cTitulo
LOCAL cUltRegiao
FIELD Codi
FIELD Nome
FIELD Ende
FIELD Cida
FIELD Esta
FIELD Fone
FIELD Regiao

ErrorBeep()
Regiao->(Order( REGIAO_REGIAO ))
if Regiao->(DbSeek( cRegiao))
	cNome := Regiao->Nome
endif
Do Case
Case nChoice = 1
	cTitulo := "RELACAO INDIVIDUAL DE CLIENTES"
Case nChoice = 2
	cTitulo := "RELACAO DE CLIENTES DA REGIAO " + AllTrim( cNome )
Case nChoice = 3
	cTitulo := "RELACAO DE CLIENTES DA CIDADE DE " + Rtrim( Cida ) + "-" + Esta
Case nChoice = 4
	cTitulo := "RELACAO DE CLIENTES DO ESTADO DE " + esta
Case nChoice = 5
	cTitulo := "RELACAO GERAL DE CLIENTES"
Case nChoice = 6
	cTitulo := "RELACAO DE CLIENTES - DATA DE ABERTURA"
Case nChoice = 8
	cTitulo := "RELACAO GERAL DE CLIENTES COM DEBITO E NEGATIVADOS SPC"
Case nChoice = 9
	cTitulo := "RELACAO GERAL DE CLIENTES SEM DEBITO E NEGATIVADOS SPC"
Case nChoice = 10
	cTitulo := "RELACAO GERAL DE CLIENTES COM DEBITO E POSITIVADO SPC"
Case nChoice = 11
	cTitulo := "RELACAO DE " + Upper(atPrompt[nChoice])
Case nChoice = 13 // Clientes com Contrato Cancelado
	cTitulo := "RELACAO DE " + Upper(atPrompt[nChoice])
EndCase
PrintOn()
Fprint( PQ )
SetPrc( 0 , 0 )
cUltRegiao := Regiao
WHILE !Eof() .AND. Rel_Ok()
	if Col >= 57
		Pagina++
		Col := 0
		Write( Col ,  000, "Pagina N?" + StrZero( Pagina , 3 ))
		Write( Col ,  113, Dtoc( Date() ) + " - " + Time())                         
      #ifDEF GRUPO_MICROBRAS
			Write( ++Col,  000, Repl( '=', Tam ))
		#else
			Write( ++Col,  000, Padc( AllTrim(oAmbiente:RelatorioCabec), Tam))
			Write( ++Col,  000, Padc( SISTEM_NA3, Tam))
		#endif
		Write( ++Col,  000, Padc( cTitulo, Tam))
		Write( ++Col,  000, Repl( '=', Tam ))		
		#ifDEF GRUPO_MICROBRAS
			Write( ++Col,  000, "CODI  NOME                                     ENDERECO                       TORRE      CIDADE                    UF       TELEFONE")
		#else
			Write( ++Col,  000, "CODI  NOME                                     ENDERECO                       BAIRRO   CIDADE                    UF       TELEFONE S")
		#endif
		Write( ++Col,  000, Repl( SEP, Tam ))
	endif
	#ifDEF GRUPO_MICROBRAS
		Qout( Codi, Nome, Ende, Left( Fanta, 10), Cida, Esta, Fone )
	#else
		Qout( Codi, Nome, Ende, Left( Bair,  8), Cida, Esta, Fone, if( Cancelada, "C", "A"))
	#endif				
	Col		  ++
	nTotal	  ++
	nTotRegiao ++
	if Cancelada
		nCancel	  ++
		nCanRegiao ++
	endif
	DbSkip( 1 )
	if nOpcao = 4 // Regiao
		if cUltRegiao != Regiao
			Qout( Repl( SEP, Tam ))
			Qout(  Space(00), "** TOTAL REGIAO " + cUltRegiao + ' : ' + Tran( nTotRegiao,       "99999"))
			QQout( Space(06), "** ATIVAS :" + Tran( nTotRegiao-nCanRegiao, "99999"))
			QQout( Space(06), "** CANCELADAS :" + Tran( nCanRegiao,  "99999"))
			QQout( Space(07), "** STATUS : A=ATIVA|C=CANCELADA")
			Qout( Repl( SEP, Tam ))
			Qout()
			Col		  += 4
			nTotRegiao := 0
			nCanRegiao := 0
		endif
	endif
	cUltRegiao := Regiao
	if Col >= 55 .OR. Eof()		
		Qout( Repl( SEP, Tam ))
		if !Eof()		
			Qout(  Space(00), "** SUB-TOTAL :" + Tran( nTotal,          "99999"))
		else	
			Qout(  Space(00), "** TOTAL     :" + Tran( nTotal,          "99999"))
		endif	
		#ifDEF GRUPO_MICROBRAS	
			Col += 2
		#else
			QQout( Space(06), "** ATIVAS :" + Tran( nTotal-nCancel, "99999"))
			QQout( Space(06), "** CANCELADAS :" + Tran( nCancel,    "99999"))
			QQout( Space(07), "** STATUS : A=ATIVA|C=CANCELADA")
			Col += 3
		#endif
		Qout( Repl( SEP, Tam ))		
	  __Eject()
	endif
EndDo
PrintOff()
return(ResTela(cScreen))

*:---------------------------------------------------------------------------------------------------------------------------------

Proc AltRegCfop()
*****************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL cRegiao := Space(02)
LOCAL aNatu   := {}
LOCAL aCfop   := {}
LOCAL aTxIcms := {}
LOCAL cCFop   := Space(05)
LOCAL nIcms   := 0
LOCAL cNatu   := ''
LOCAL oBloco
LOCAL cTela

WHILE OK
	oMenu:Limpa()
	aNatu   := LerNatu()
	aCFop   := LerCfop()
	aTxIcms := LerIcms()
	cRegiao := Space(2)
	cCFop   := Space(05)
	MaBox( 13, 10, 16, 27 )
	@ 14, 11 Say "Regiao..:" Get cRegiao Pict "99"    Valid RegiaoErrada( @cRegiao )
	@ 15, 11 Say "Cfop....:" Get cCFop   Pict "9.999" Valid PickTam2( @aNatu, @aCfop, @aTxIcms, @cCfop, @cNatu, @nIcms )
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		return
	endif
	ErrorBeep()
	if Conf("Pergunta: Continuar com a alteracao ?")
		Receber->(Order( RECEBER_REGIAO ))
		oBloco  := {|| Receber->Regiao = cRegiao }
		if Receber->(!DbSeek( cRegiao ))
			ErrorBeep()
			Alerta("Erro: Nenhum cliente atende a condicao.")
			Loop
		endif
		cTela := Mensagem("Aguarde, Atualizando Registros")
		WHILE Eval( oBloco )
			if Receber->(TravaReg())
				Receber->Cfop	  := cCfop
				Receber->Tx_Icms := nIcms
				Receber->(LIbera())
			endif
			Receber->(DbSkip(1))
		EndDo
		ResTela( cTela )
	endif
EndDo

*:---------------------------------------------------------------------------------------------------------------------------------

Proc AltRegTitRec()
*******************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL cRegiao := Space(02)
LOCAL oBloco
LOCAL cTela

WHILE OK
	oMenu:Limpa()
	MaBox( 13, 10, 15, 24 )
	cRegiao := Space(2)
	@ 14 , 11 Say "Regiao..:" GET cRegiao PICT "99" Valid RegiaoErrada( @cRegiao )
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		return
	endif
	ErrorBeep()
	if Conf("Pergunta: Continuar com a alteracao ?")
		Recemov->(Order( RECEMOV_CODI ))
		Receber->(Order( RECEBER_REGIAO ))
		oBloco  := {|| Receber->Regiao = cRegiao }
		if Receber->(!DbSeek( cRegiao ))
			ErrorBeep()
			Alerta("Erro: Nenhum cliente atende a condicao.")
			Loop
		endif
		cTela := Mensagem("Aguarde, Atualizando Registros")
		WHILE Eval( oBloco )
			cCodi   := Receber->Codi
			if Recemov->(DbSeek( cCodi ))
				WHILE Recemov->Codi = cCodi
					if Recemov->(TravaReg())
						Recemov->Regiao := cRegiao
						Recemov->(LIbera())
						Recemov->(DbSkip(1))
					endif
				EndDo
			endif
			Receber->(DbSkip(1))
		EndDo
		ResTela( cTela )
	endif
EndDo

*:---------------------------------------------------------------------------------------------------------------------------------

Proc AltRegTitPag()
*******************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL cRegiao := Space(02)
LOCAL oBloco
LOCAL cTela

WHILE OK
	oMenu:Limpa()
	MaBox( 13, 10, 15, 24 )
	cRegiao := Space(2)
	@ 14 , 11 Say "Regiao..:" GET cRegiao PICT "99" Valid RegiaoErrada( @cRegiao )
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		return
	endif
	ErrorBeep()
	if Conf("Pergunta: Continuar com a alteracao ?")
		Receber->(Order( RECEBER_REGIAO ))
		Recebido->(Order( RECEBIDO_CODI ))
		oBloco  := {|| Receber->Regiao = cRegiao }
		if Receber->(!DbSeek( cRegiao ))
			ErrorBeep()
			Alerta("Erro: Nenhum cliente atende a condicao.")
			Loop
		endif
		cTela := Mensagem("Aguarde, Atualizando Registros")
		WHILE Eval( oBloco )
			cCodi   := Receber->Codi
			if Recebido->(DbSeek( cCodi ))
				WHILE Recebido->Codi = cCodi
					if Recebido->(TravaReg())
						Recebido->Regiao := cRegiao
						Recebido->(LIbera())
						Recebido->(DbSkip(1))
					endif
				EndDo
			endif
			Receber->(DbSkip(1))
		EndDo
		ResTela( cTela )
	endif
EndDo

Proc ReajTitulos()
******************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL aMenu   := {'Individual','Por Fatura'}
LOCAL nChoice := 0

WHILE OK
	oMenu:Limpa()
	M_Title("REAJUSTE DE TITULOS" )
	nChoice := FazMenu( 10, 10, aMenu )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		return

	Case nChoice = 1
		ReajTitInd()

	Case nChoice = 2
		ReajTitFat()

	EndCase
EndDo

Proc ReajTitFat()
*****************
LOCAL cScreen	:= SaveScreen()
LOCAL cFatuIni := Space(07)
LOCAL cFatuFim := Space(07)
LOCAL xCodigo	:= 0
LOCAL nChoice	:= 0
LOCAL nPorc 	:= 0
LOCAL lAchou	:= FALSO
LOCAL oBloco
LOCAL cFatura

WHILE OK
	oMenu:Limpa()
	MaBox( 10, 10, 15, 79 )
	cFatuIni := Space(07)
	cFatuFim := Space(07)
	xCodigo	:= 0
	nChoice	:= 0
	nPorc 	:= 0
	@ 11, 11 Say "Fatura Inicial.:" Get cFatuIni Pict "@!"       Valid VisualAchaFatura( @cFatuIni )
	@ 12, 11 Say "Fatura Final...:" Get cFatuFim Pict "@!"       Valid VisualAchaFatura( @cFatuFim )
	@ 13, 11 Say "Produto........:" Get xCodigo  Pict PIC_LISTA_CODIGO Valid CodiErrado(@xCodigo,,, Row(), Col()+1)
	@ 14, 11 Say "Percentual.....:" GET nPorc    PICT "999.9999" Valid nPorc <> 0
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		Exit
	endif
	oBloco := {|| Recemov->Fatura >= cFatuIni .AND. Recemov->Fatura <= cFatuFim }
	Saidas->(Order( SAIDAS_FATURA ))
	Area("Recemov")
	Recemov->(Order( RECEMOV_FATURA ))
	ErrorBeep()
	if Conf("Pergunta: Deseja Continuar ?")
		lRedondo := FALSO
		Set( SOFT, 'on')
		Recemov->(DbSeek( cFatuIni ))
		Set( SOFT, 'off')
		While Recemov->(Eval( oBloco ))
			cFatura := Recemov->Fatura
			lAchou := FALSO
			if Saidas->(DbSeek( cFatura ))
				While Saidas->Fatura = cFatura
					if Saidas->Codigo = xCodigo
						lAchou				:= OK
						Exit
					endif
					Saidas->(DbSkip(1))
				EndDo
			endif
			if lAchou
				if Saidas->(DbSeek( cFatura ))
					While Saidas->Fatura = cFatura
						if Saidas->(TravaReg())
							nReajuste			:= ( Saidas->VlrFatura * nPorc ) / 100
							Saidas->VlrFatura += nReajuste
							nReajuste			:= ( Saidas->Pvendido  * nPorc ) / 100
							Saidas->Pvendido	+= nReajuste
							Saidas->(Libera())
							Saidas->(DbSkip(1))
						endif
					EndDo
				endif
				While Recemov->Fatura = cFatura
					nReajuste := ( Recemov->Vlr * nPorc ) / 100
					if Recemov->(TravaReg())
						if lRedondo
							Recemov->Vlr := Round( Recemov->Vlr + nReajuste, 2 )
						else
							Recemov->Vlr += nReajuste
						endif
						Recemov->(Libera())
					endif
					Recemov->(DbSkip(1))
				Enddo
				Recemov->(DbSkip(1))
			else
				Recemov->(DbSkip(1))
			endif
		Enddo
	endif
EndDo

Proc ReajTitInd()
*****************
LOCAL cScreen := SaveScreen()
LOCAL cCodi   := Space(05)
LOCAL nChoice := 0
LOCAL nPorc   := 0

WHILE OK
	oMenu:Limpa()
	MaBox( 10, 10, 13, 79 )
	cCodi := Space( 05 )
	@ 11, 11 Say "Cliente....:" GET cCodi PICT PIC_RECEBER_CODI  Valid RecErrado( @cCodi, NIL, Row(), Col()+1 )
	@ 12, 11 Say "Percentual.:" GET nPorc PICT "999.9999"        Valid nPorc <> 0
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		Exit
	endif
	Area("Recemov")
	Recemov->(Order( RECEMOV_CODI ))
	if Recemov->(DbSeek( cCodi ))
		ErrorBeep()
		if Conf("Pergunta: Deseja Continuar ?")
			lRedondo := Conf("Pergunta: Arredondar Centavos ")
			While Recemov->Codi = cCodi
				nReajuste := ( Recemov->Vlr * nPorc ) / 100
				if Recemov->(TravaReg())
					if lRedondo
						Recemov->Vlr := Round( Recemov->Vlr + nReajuste, 2 )
					else
						Recemov->Vlr += nReajuste
					endif
					Recemov->(Libera())
				endif
				Recemov->(DbSkip(1))
			Enddo
		endif
	else
		ErrorBeep()
		Alerta("Erro: Cliente Sem Movimento.")
		Loop
	endif
EndDo

Proc RelRecSeletiva()
*********************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL aTipo 	 := {"Normal", "Total"}
LOCAL aReg		 := {}
LOCAL aCodi 	 := {}
LOCAL xReg		 := {}
LOCAL dAtual	 := Date()
LOCAL cCodi 	 := Space(04)
LOCAL cCodiVen  := Space(04)
LOCAL cNomeVen  := ''
LOCAL nChoice	 := 0
LOCAL nTam		 := 0
LOCAL nX 		 := 0
LOCAL lTotal	 := FALSO
LOCAL lSeletiva := OK
LOCAL cTitulo	 := ""
LOCAL lSemLoop  := OK

WHILE OK
	cCodi := Space(05)
	MaBox( 13 , 18 , 15 , 77 )
	@ 14, 19 Say  "Cliente.:" Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
	Read
	if LastKey() = ESC
		if Len( aCodi ) = 0
			ResTela( cScreen )
			return
		endif
		ErrorBeep()
		if Conf("Pergunta: Deseja Cancelar a Selecao ?")
			ResTela( cScreen )
			return
		endif
		Exit
	endif
	Keyb Chr( ENTER )
	xReg := {}
	xReg := EscolheTitulo( cCodi, lSemLoop )
	if Len( xReg ) <> 0
		if Ascan( aCodi, cCodi ) = 0
			Aadd( aCodi, cCodi )
		endif
		For nX := 1 To Len( xReg )
			Aadd( aReg, xReg[nX])
		Next
	endif
EndDo
nTam := Len( aCodi )
if nTam = 0
	ResTela( cScreen )
	return
endif
MaBox(16, 18, 18, 77 )
cCodiVen := Space( 04 )
@ 17 , 19 Say	"Cobrador:" Get cCodiVen Pict "9999" Valid FunErrado( @cCodiVen,, Row(), Col()+1, @cNomeVen )
Read
if LastKey() = ESC
	ErrorBeep()
	if Conf("Pergunta: Deseja Cancelar a Selecao ?")
		ResTela( cScreen )
		return
	endif
endif
cTitulo := 'RELACAO DE COBRANCA SELETIVA DO COBRADOR: '
cTitulo += AllTrim( cNomeVen )
MaBox( 19 , 18 , 21, 42 )
@ 20 , 19 Say	"Data Calculo.:" Get dAtual  Pict "##/##/##"
Read
if LastKey() = ESC
	ErrorBeep()
	if Conf("Pergunta: Deseja Cancelar a Selecao ?")
		ResTela( cScreen )
		return
	endif
endif
M_Title("TIPO")
nChoice := FazMenu( 19, 43,  aTipo, Cor() )
if nChoice = 0
	ErrorBeep()
	if Conf("Pergunta: Deseja Cancelar a Selecao ?")
		ResTela( cScreen )
		return
	endif
endif
lTotal := nChoice = 2
Receber->( Order( RECEBER_CODI ))
ErrorBeep()
if !InsTru80() .OR. !LptOk()
	ResTela( cScreen )
	return
endif
Prn002Cob( cTitulo, NIL, NIL, dAtual, aCodi, cCodiVen, lTotal, lSeletiva, aReg )
ResTela( cScreen )
return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc CartaSpc()
****************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen()
LOCAL aMenuArray := { "Modelo Antigo", "Modelo Novo"}
LOCAL xDbf		  := FTempName("t*.tmp")
LOCAL dIni		  := Date()-30
LOCAL dFim		  := Date()
LOCAL nChoice	  := 0
LOCAL nTamForm   := 33
LOCAL i			  := 0
LOCAL _QtDup	  := 0
LOCAL aReg
LOCAL aStru
LOCAL cCodi
FIELD Codi
FIELD Vcto

WHILE OK
	M_Title("NEGATIVAR CLIENTES NO SPC")
	nChoice := FazMenu( 03 , 10, aMenuArray )
	Do Case
	Case nChoice  = 0
		ResTela( cScreen )
		return

	Case nChoice  = 1
		cCodi 	:= Space(05)
		dIni		:= Date()-30
		dFim		:= Date()
		nTamForm := 33
		MaBox( 09 , 10, 14 , 40 )
		@ 10, 11 Say  "Cliente..........:" Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi )
		@ 11, 11 Say  "Vcto Inicial.....:" Get dIni  Pict "##/##/##"
		@ 12, 11 Say  "Vcto Final.......:" Get dFim  Pict "##/##/##"
		@ 13, 11 Say  "Comp Formulario..:" Get nTamForm Pict "99" Valid nTamForm = 33 .OR. nTamForm = 66
		Read
		if LastKey() = ESC
			ResTela( cScreen	)
			Loop
		endif
		Area("ReceMov")
		Recemov->(Order( RECEMOV_CODI ))
		if Recemov->(!DbSeek( cCodi ))
			ErrorBeep()
			Nada()
			ResTela( cScreen )
			Loop
		endif
		Copy Stru To ( xDbf )
		Use (xDbf) Exclusive Alias xTemp New
		WHILE Recemov->Codi = cCodi
			if Recemov->Vcto >= dIni .AND. Recemov->Vcto <= dFim
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Recemov->(FieldGet( nField ))))
				Next
			endif
			Recemov->(DbSkip(1))
		EndDo
		Receber->( Order( RECEBER_CODI ))
		xTemp->(DbGoTop())
		Set Rela To xTemp->Codi Into Receber
		xTemp->(DbGoTop())
		CartaSpcOld( nTamForm )
		Mensagem("Aguarde, Excluindo Arquivo Temporario.")
		xTemp->(DbClearRel())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( xDbf )
		ResTela( cScreen )
		Loop

	Case nChoice  = 2
		cCodi 	 := Space(05)
		aReg		 := {}
		aReg		 := EscolheTitulo( cCodi )
		if ( _QtDup := Len( aReg )) = 0
			ResTela( cScreen )
			Loop
		endif
		Area("Recemov")
		Recemov->(Order( RECEMOV_CODI ))
		aStru := Recemov->(DbStruct())
		Aadd( aStru, {"QTD",  "N", 3, 0})
		DbCreate( xDbf, aStru )
		Use (xDbf) Exclusive Alias xTemp New
		FOR i :=  1 TO _qtdup
			Recemov->(DbGoto( aReg[i] ))
			xTemp->(DbAppend())
			For nField := 1 To FCount()
				xTemp->( FieldPut( nField, Recemov->(FieldGet( nField ))))
			Next
			xTemp->Qtd ++
		Next
		nTamForm := 33
		Receber->( Order( RECEBER_CODI ))
		xTemp->(DbGoTop())
		Set Rela To xTemp->Codi Into Receber
		xTemp->(DbGoTop())
		CartaSpcNew( nTamForm )
		Mensagem("Aguarde, Excluindo Arquivo Temporario.")
		xTemp->(DbClearRel())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( xDbf )
		ResTela( cScreen )
		Loop
	EndCase
EndDo

Proc CartaSpcOld( nTamForm )
****************************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL NovoNome  := OK
LOCAL Tam		 := 80
LOCAL cVar1
LOCAL cVar2
LOCAL UltNome
LOCAL Col
FIELD Codi
FIELD Vcto
FIELD Vlr
FIELD Docnr
FIELD Emis
FIELD Juro
FIELD Cida
FIELD JuroDia

WHILE OK
	xTemp->(DbGoTop())
	Recemov->(Order( RECEMOV_DOCNR ))
	if !InsTru80()
		ResTela( cScreen	)
		return
	endif
	oMenu:Limpa()
	Mensagem("Aguarde, Imprimindo. ESC Cancela.")
	UltNome	:= Receber->Nome
	PrintOn()
	FPrInt( Chr(ESC) + "C" + Chr( nTamForm ))
	SetPrc(0,0)
	WHILE !Eof() .AND. Rel_Ok()
		if Recemov->(DbSeek( xTemp->Docnr ))
			if Recemov->(TravaReg())
				Recemov->Port := "SPC"
				Recemov->(Libera())
			endif
		endif
		if NovoNome
			if Receber->(TravaReg())
				Receber->Spc	  := OK
				Receber->DataSpc := Date()
				Receber->(Libera())
			endif
			if Receber->Cgc = "  .   .   /    -  " .OR. Receber->Cgc = Space( 18 )
				cVar1 := Receber->Cpf
				cVar2 := Receber->Rg
			else
				cVar1 := Receber->Cgc
				cVar2 := Receber->Insc
			endif
			NovoNome := FALSO
			Qout( Repl("=", Tam ))
			Qout( Padc("SPC - SISTEMA DE PROTECAO AO CREDITO",Tam ))
			Qout( Repl("=", Tam ))
			Qout(  "Codigo no SPC..:", "______")
         Qout(  "Empresa........:", AllTrim(oAmbiente:xNomefir) )
			Qout(  "Nome do Cliente:", NG + Receber->Codi, Receber->Nome, NR)
			Qout(  "Data Nascimento:", Receber->Nasc )
			QQout( Space(16), "Est. Civil:", Receber->Civil )
			Qout(  "Cpf/Cgc........:", cVar1 )
			QQout( Space(10), "Insc/Rg...:", cVar2 )
			Qout(  "Conjuge........:", Receber->Esposa )
			Qout(  "Endereco.......:", Receber->Ende )
			Qout(  "Cidade/Uf......:", AllTrim( Receber->Cida ) + " - " + Receber->Esta )
			Qout(  "Profissao......:", Receber->Profissao )
			Qout(  "Firma..........:", Receber->Trabalho )
			Qout(  "Nome Mae.......:", Receber->Mae )
			Qout(  "Nome Pai.......:", Receber->Pai )
			Qout()
			Qout( Padc( Repl("_",22) + "P R O T O C O L O  D E  E N T R E G A" + Repl("_",21),Tam ))
			Qout( "DOCTO N?      EMISSAO   TIPO                    VALOR     DT VCTO    DATA ENVIO")
			Col := 18
		endif
		Qout( Docnr, Space(03), Emis, Space(03), Tipo, Space(03), Tran( Vlr,"@E 9,999,999,999.99"), Space(03), Vcto, Space(03), Date())
		Col++
		UltNome := Receber->Nome
		DbSkip(1)
		if Col >= ( nTamForm - 10 ) .OR. UltNome != Receber->Nome .OR. Eof()
			NovoNome := OK
			Qout( Repl("=", Tam ))
			Qout( Padl("CARIMBO E ASSINATURA DA EMPRESA", Tam ))
			__Eject()
		endif
	EndDo
	PrintOff()
	ResTela( cScreen )
EndDO

*:---------------------------------------------------------------------------------------------------------------------------------

Proc CartaSpcNew( nTamForm )
****************************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL NovoNome  := OK
LOCAL Tam		 := 80
LOCAL cVar1
LOCAL cVar2
LOCAL UltNome
LOCAL Col
FIELD Codi
FIELD Vcto
FIELD Vlr
FIELD Docnr
FIELD Emis
FIELD Juro
FIELD Cida
FIELD JuroDia

WHILE OK
	xTemp->(DbGoTop())
	Recemov->(Order( RECEMOV_DOCNR ))
	if !InsTru80()
		ResTela( cScreen	)
		return
	endif
	oMenu:Limpa()
	Mensagem("Aguarde, Imprimindo. ESC Cancela.")
	UltNome	:= Receber->Nome
	PrintOn()
	FPrInt( Chr(ESC) + "C" + Chr( nTamForm ))
	SetPrc(0,0)
	WHILE !Eof() .AND. Rel_Ok()
		if Recemov->(DbSeek( xTemp->Docnr ))
			if Recemov->(TravaReg())
				Recemov->Port := "SPC"
				Recemov->(Libera())
			endif
		endif
		if NovoNome
			if Receber->(TravaReg())
				Receber->Spc	  := OK
				Receber->DataSpc := Date()
				Receber->(Libera())
			endif
			if Receber->Cgc = "  .   .   /    -  " .OR. Receber->Cgc = Space( 18 )
				cVar1 := Receber->Cpf
				cVar2 := Receber->Rg
			else
				cVar1 := Receber->Cgc
				cVar2 := Receber->Insc
			endif
			NovoNome := FALSO
			Qout( Repl("=", Tam ))
			Qout( Padc("SPC - SISTEMA DE PROTECAO AO CREDITO",Tam ))
			Qout( Repl("=", Tam ))
			Qout(  "Codigo no SPC..:", "______")
         Qout(  "Empresa........:", AllTrim(oAmbiente:xNomefir) )
			Qout(  "Nome do Cliente:", NG + Receber->Codi, Receber->Nome, NR)
			Qout(  "Data Nascimento:", Receber->Nasc )
			QQout( Space(16), "Est. Civil:", Receber->Civil )
			Qout(  "Cpf/Cgc........:", cVar1 )
			QQout( Space(10), "Insc/Rg...:", cVar2 )
			Qout(  "Conjuge........:", Receber->Esposa )
			Qout(  "Endereco.......:", Receber->Ende )
			Qout(  "Cidade/Uf......:", AllTrim( Receber->Cida ) + " - " + Receber->Esta )
			Qout(  "Profissao......:", Receber->Profissao )
			Qout(  "Firma..........:", Receber->Trabalho )
			Qout(  "Nome Mae.......:", Receber->Mae )
			Qout(  "Nome Pai.......:", Receber->Pai )
			Qout()
			Qout( Padc( Repl("_",22) + "P R O T O C O L O  D E  E N T R E G A" + Repl("_",21),Tam ))
			Qout( "DATA ENVIO      DOCTO N?   N?DE PREST SALDO EM ATRASO          DESDE")
			Col := 18
		endif
		Qout( Date(), Space(5), Docnr, Space(5), StrZero( Qtd, 3), Space(7), Tran( Vlr,"@E 9,999,999.99"), Space(5), Vcto )
		Col++
		UltNome := Receber->Nome
		DbSkip(1)
		if Col >= ( nTamForm - 10 ) .OR. UltNome != Receber->Nome .OR. Eof()
			NovoNome := OK
			Qout( Repl("=", Tam ))
			Qout( Padl("CARIMBO E ASSINATURA DA EMPRESA", Tam ))
			__Eject()
		endif
	EndDo
	PrintOff()
	ResTela( cScreen )
EndDO

Proc ImpExpGetDados()
******************
LOCAL cScreen := SaveScreen()
LOCAL aTipo   := {'Exportacao Recebido', 'Importacao Recebido'}

WHILE OK
	oMenu:Limpa()
	M_Title("ESCOLHA O TIPO")
	nTipo := FazMenu( 05, 08, aTipo )
	Do Case
	Case nTipo = 0
		ResTela( cScreen )
		return
	Case nTipo = 1
		ExportaRecebido()
	Case nTipo = 2
		ImportaRecebido()
	EndCase
EndDo

Proc ExportaRecebido()
**********************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL dIni	  := Date()-30
LOCAL dFim	  := Date()
LOCAL aStru   := {}
LOCAL nField  := 0
LOCAL oBloco  := {|| !Exportado }
LOCAL bBloco  := {|| Recebido->Baixa >= dIni .AND. Recebido->Baixa <= dFim }
LOCAL cReIni
LOCAL cReFim
LOCAL xBid

oMenu:Limpa()
dIni := Date()-30
dFim := Date()
MaBox( 11, 10, 14, 40 )
@ 12, 11 Say "Data Baixa Inicial." Get dIni Pict "##/##/##"
@ 13, 11 Say "Data Baixa Final..." Get dFim Pict "##/##/##" Valid dFim >= dIni
Read
if LastKey() = ESC
	return
endif
xBid	:= FTempName('BID?????.REM')
aStru := Recebido->(DbStruct())
DbCreate( xBid, aStru )
Use (xBid) Alias xRecebido Exclusive New
Area('Recebido')
Recebido->(Order( RECEBIDO_BAIXA ))
Recebido->(DbSeek( dIni ))
Mensagem('Aguarde, Exportando Recebido.')
While Recebido->(Eval( bBloco )) .AND. Recebido->(!Eof()) .AND. Rep_Ok()
	if Eval( oBloco )
		xRecebido->(DbAppend())
		For nField := 1 To FCount()
			xRecebido->( FieldPut( nField, Recebido->(FieldGet( nField ))))
		Next
		if Recebido->(TravaReg())
			Recebido->Exportado := OK
			Recebido->(Libera())
		endif
	endif
	Recebido->(DbSkip(1))
EndTry
xRecebido->(DbGoTop())
if xRecebido->(Eof())
	xRecebido->(DbCloseArea())
	Ferase( xBid )
	Nada()
	ResTela( cScreen )
	return
endif
xRecebido->(DbCloseArea())
ResTela( cScreen )
return

Proc ImportaRecebido()
**********************
	LOCAL GetList	:= {}
	LOCAL cScreen	:= SaveScreen()
	LOCAL cFiles	:= 'BID*.REM'
	LOCAL Arq_Ant	:= Alias()
	LOCAL Ind_Ant	:= IndexOrd()
	LOCAL dIni
	LOCAL dFim
	LOCAL xArquivo
	LOCAL xNtx

	oMenu:Limpa()
	M_Title("ESCOLHA ARQUIVO DE RECEBIDO PARA IMPORTACAO")
	xArquivo := Mx_PopFile( 05, 10, 20, 74, cFiles )
	if Empty( xArquivo )
		ErrorBeep()
		ResTela( cScreen )
		return
	endif
	Mensagem("Aguarde, Importando Arquivo Recebido.")
	Area("Recebido")
	Appe From ( xArquivo )
	Use (xArquivo) Alias xRecebido Exclu New
	Recemov->(Order( RECEMOV_DOCNR ))
	Area('xRecebido')
	Mensagem("Aguarde, Indexando Arquivo Importado.")
	Inde On xRecebido->DataPag To (xNtx)
	xRecebido->(DbGoBottom())
	dFim := xRecebido->DataPag
	xRecebido->(DbGoTop())
	dIni := xRecebido->DataPag
	Mensagem("Aguarde, Baixando Registro Importados.")
	While xRecebido->(!Eof())
		cDocnr := xRecebido->Docnr
		if Recemov->(DbSeek( cDocnr ))
			if Recemov->(Travareg())
				Recemov->(DbDelete())
			endif
			Recemov->(Libera())
		endif
		xRecebido->(DbSkip(1))
	EndDo
	xRecebido->(DbCloseArea())
	Ferase( xNtx )
	xTemp := StrTran( xArquivo, '.REM')
	MsRename( xArquivo, xTemp + '.IMP')
	RecebidoCx('0000','0001', dIni, dFim )
	ResTela(cScreen )
	return

Proc CancelaContrato()
*********************
LOCAL cScreen	:= SaveScreen()
LOCAL cCodi 	:= Space(05)
LOCAL cFatura	:= Space(07)
LOCAL cObs		:= Space(40)
LOCAL dData 	:= Date()

WHILE OK
	oMenu:Limpa()
	MaBox( 13, 05, 17, 78 )
	cCodi   := Space(05)
	cFatura := Space(07)
	@ 14, 06 Say "Fatura............:" Get cFatura Pict "@!"             Valid VisualAchaFatura( @cFatura)
	@ 15, 06 Say "Data Cancelamento.:" GET dData   PICT "##/##/##"       Valid !Empty( dData )
	@ 16, 06 Say "Motivo............:" GET cObs    PICT "@!"
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		return
	endif
	Receber->(Order( RECEBER_CODI ))
	Recemov->(Order( RECEMOV_FATURA ))
	if Conf("Pergunta: Confirma Cancelamento ?")
		WHILE Recemov->(DbSeek( cFatura ))
			cCodi := Recemov->Codi
			Receber->(DbSeek( cCodi ))
			if Recebido->(Incluiu())
				Recebido->Codi 	 := cCodi
				Recebido->Regiao	 := Receber->Regiao
				Recebido->Docnr	 := Recemov->Docnr
				Recebido->Emis 	 := Recemov->Emis
				Recebido->Vcto 	 := Recemov->Vcto
				Recebido->Baixa	 := Date()
				Recebido->Vlr		 := Recemov->Vlr
				Recebido->DataPag  := dData
				Recebido->VlrPag	 := 0
				Recebido->Port 	 := Recemov->Port
				Recebido->Tipo 	 := Recemov->Tipo
				Recebido->Juro 	 := Recemov->Juro
				Recebido->NossoNr  := Recemov->NossoNr
				Recebido->Bordero  := Recemov->Bordero
				Recebido->Fatura	 := Recemov->Fatura
				Recebido->Obs		 := cObs
				Recebido->Parcial  := 'Q'
				Recebido->(Libera())
				Recebido->(Libera())
				if Recemov->(TravaReg())
					Recemov->(DbDelete())
					Recemov->(Libera())
				endif
			endif
		EndDo
	endif
EndDo

Proc TrocaCliente(cCaixa)
************************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL aMenu   := {'Por Fatura','Por Cliente'}
LOCAL nChoice := 0

WHILE OK
	oMenu:Limpa()
	M_Title("TROCA DE FATURA" )
	nChoice := FazMenu( 03, 20, aMenu )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		return

	Case nChoice = 1
		TrClifatura( cCaixa )

	Case nChoice = 2
		TrCliIndividual( cCaixa )

	EndCase
EndDo

Proc TrClifatura(cCaixa)
************************
LOCAL cScreen	:= SaveScreen()
LOCAL cCodi 	:= Space(05)
LOCAL cFatura	:= Space(07)
LOCAL cObs		:= Space(40)
LOCAL dData 	:= Date()

WHILE OK
	oMenu:Limpa()
	MaBox( 13, 05, 16, 78 )
	cCodi   := Space(05)
	cFatura := Space(07)
	@ 14, 06 Say "Fatura.......:" Get cFatura Pict "@!"    Valid VisualAchaFatura( @cFatura)
	@ 15, 06 Say "Novo Cliente.:" GET cCodi   Pict "99999" Valid RecErrado( @cCodi,, Row(), Col()+1 )
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		return
	endif
	Recebido->(Order( RECEBIDO_FATURA ))
	Recemov->(Order( RECEMOV_FATURA ))
	Saidas->(Order( SAIDAS_FATURA ))
	Nota->(Order( NOTA_NUMERO ))
	Vendemov->(Order( VENDEMOV_FATURA ))
	Recibo->(Order( RECIBO_FATURA))
	if Conf("Pergunta: Confirma Alteracao?")
		Mensagem('Informa: Aguarde...')
		if Recemov->(DbSeek( cFatura ))
			WHILE Recemov->Fatura = cFatura
				if Recemov->(TravaReg())
					Recemov->Codi = cCodi
					Recemov->(Libera())
					Recemov->(DbSkip(1))
				endif
			EndDo
		endif
		if Recebido->(DbSeek( cFatura ))
			WHILE Recebido->Fatura = cFatura
				if Recebido->(TravaReg())
					Recebido->Codi = cCodi
					Recebido->(Libera())
					Recebido->(DbSkip(1))
				endif
			EndDo
		endif
		if Saidas->(DbSeek( cFatura ))
			WHILE Saidas->Fatura = cFatura
				if Saidas->(TravaReg())
					Saidas->Codi		 = cCodi
					Saidas->Situacao	 = 'ALTERADA'
					Saidas->Atualizado = Date()
					Saidas->Caixa		 = cCaixa
					Saidas->(Libera())
					Saidas->(DbSkip(1))
				endif
			EndDo
		endif
		if Nota->(DbSeek( cFatura ))
			WHILE Nota->Numero = cFatura
				if Nota->(TravaReg())
					Nota->Codi		  = cCodi
					Nota->Situacao   = 'ALTERADA'
					Nota->Atualizado = Date()
					Nota->Caixa 	  = cCaixa
					Nota->(Libera())
					Nota->(DbSkip(1))
				endif
			EndDo
		endif
		if Vendemov->(DbSeek( cFatura ))
			WHILE Vendemov->Fatura = cFatura
				if Vendemov->(TravaReg())
					Vendemov->Codi = cCodi
					Vendemov->(Libera())
					Vendemov->(DbSkip(1))
				endif
			EndDo
		endif
		if Recibo->(DbSeek( cFatura ))
			WHILE Recibo->Fatura = cFatura
				if Recibo->(TravaReg())
					Recibo->Codi = cCodi
					Recibo->(Libera())
					Recibo->(DbSkip(1))
				endif
			EndDo
		endif
	endif
EndDo

Proc TrCliIndividual(cCaixa)
****************************
LOCAL cScreen	:= SaveScreen()
LOCAL cVelho	:= Space(05)
LOCAL cCodi 	:= Space(05)
LOCAL cFatura	:= Space(07)
LOCAL cObs		:= Space(40)
LOCAL dData 	:= Date()

WHILE OK
	oMenu:Limpa()
	MaBox( 13, 05, 16, 78 )
	cVelho  := Space(05)
	cCodi   := Space(05)
	cFatura := Space(07)
	@ 14, 06 Say "Cliente Velho.:" GET cVelho  Pict "99999" Valid RecErrado( @cVelho,, Row(), Col()+1 )
	@ 15, 06 Say "Cliente Novo..:" GET cCodi   Pict "99999" Valid RecErrado( @cCodi,,Row(),Col()+1 )
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		return
	endif
	Recebido->(Order( RECEBIDO_FATURA ))
	Recemov->(Order( RECEMOV_FATURA ))
	Saidas->(Order( SAIDAS_FATURA ))
	Vendemov->(Order( VENDEMOV_FATURA ))	
	Nota->(Order( NOTA_CODI ))
	Recibo->(Order( RECIBO_FATURA ))		
	if Conf("Pergunta: Confirma Alteracao?")
		Mensagem('Informa: Aguarde...')
		if Nota->(!DbSeek( cVelho ))
			ErrorBeep()
			Alerta("Erro: Nenhuma fatura encontrada.")
			Loop
		endif
		Nota->(Order( NOTA_CODI ))
		WHILE Nota->(DbSeek( cVelho ))
			cFatura := Nota->Numero
			if Recemov->(DbSeek( cFatura ))
				WHILE Recemov->Fatura = cFatura
					if Recemov->(TravaReg())
						Recemov->Codi = cCodi
						Recemov->(Libera())
					  Recemov->(DbSkip(1))
					endif
				EndDo
			endif
			if Recebido->(DbSeek( cFatura ))
				WHILE Recebido->Fatura = cFatura
					if Recebido->(TravaReg())
						Recebido->Codi = cCodi
						Recebido->(Libera())
						Recebido->(DbSkip(1))
					endif
				EndDo
			endif
			if Saidas->(DbSeek( cFatura ))
				WHILE Saidas->Fatura = cFatura
					if Saidas->(TravaReg())
						Saidas->Codi		 = cCodi
						Saidas->Situacao	 = 'ALTERADA'
						Saidas->Atualizado = Date()
						Saidas->Caixa		 = cCaixa
						Saidas->(Libera())
						Saidas->(DbSkip(1))
					endif
				EndDo
			endif
			Nota->(Order( NOTA_NUMERO ))
			if Nota->(DbSeek( cFatura ))
				WHILE Nota->Numero = cFatura
					if Nota->(TravaReg())
						Nota->Codi		  = cCodi
						Nota->Situacao   = 'ALTERADA'
						Nota->Atualizado = Date()
						Nota->Caixa 	  = cCaixa
						Nota->(Libera())
						Nota->(DbSkip(1))
					endif
				EndDo
			endif
			Nota->(Order( NOTA_CODI ))
			if Vendemov->(DbSeek( cFatura ))
				WHILE Vendemov->Fatura = cFatura
					if Vendemov->(TravaReg())
						Vendemov->Codi = cCodi
						Vendemov->(Libera())
						Vendemov->(DbSkip(1))
				  endif
				EndDo
			endif
			Recibo->(Order( RECIBO_FATURA ))
			if Recibo->(DbSeek( cFatura ))
				WHILE Recibo->Fatura = cFatura
					if Recibo->(TravaReg())
						Recibo->Codi = cCodi
						Recibo->(Libera())
						Recibo->(DbSkip(1))
				  endif
				EndDo
			endif			
		EndDo
	endif
EndDo

Proc RolPagarPago()
*******************
LOCAL cScreen	  := SaveScreen()
LOCAL cFatuIni   := Space(07)
LOCAL cFatuFim   := Space(07)
LOCAL nChoice	  := 0
LOCAL nPorc 	  := 0
LOCAL nVlrFatura := 0
LOCAL nPagarPerc := 0
LOCAL nPagoPerc  := 0
LOCAL nTotPagar  := 0
LOCAL nTotPago   := 0
LOCAL lAchou	  := FALSO
LOCAL aRelato	  := {}
LOCAL cCodi 	  := ''
LOCAL cNome 	  := ''
LOCAL nX
LOCAL oRelato
LOCAL oBloco
LOCAL cFatura
LOCAL cPagar
LOCAL cPago

WHILE OK
	oMenu:Limpa()
	MaBox( 10, 10, 14, 79 )
	cFatuIni := Space(07)
	cFatuFim := Space(07)
	xCodigo	:= 0
	nChoice	:= 0
	nPorc 	:= 0
	aRelato	:= {}
	@ 11, 11 Say "Fatura Inicial..:" Get cFatuIni Pict "@!"       Valid VisualAchaFatura( @cFatuIni )
	@ 12, 11 Say "Fatura Final....:" Get cFatuFim Pict "@!"       Valid VisualAchaFatura( @cFatuFim )
	@ 13, 11 Say "Percentual Pago.:" GET nPorc    PICT "999.9999" Valid nPorc <> 0
	Read
	if LastKey() = ESC
		ResTela( cScreen )
		Exit
	endif
	oBloco := {|| Saidas->Fatura >= cFatuIni .AND. Saidas->Fatura <= cFatuFim }
	Receber->(Order( RECEBER_CODI ))
	Recebido->(Order( RECEBIDO_FATURA ))
	Recemov->(Order( RECEMOV_FATURA ))
	Saidas->(Order( SAIDAS_FATURA ))
	ErrorBeep()
	if Conf("Pergunta: Deseja Continuar ?")
		lCancelado := Conf('Pergunta: Incluir Cancelados ?')
		Saidas->(DbSeek( cFatuIni ))
		While Saidas->(Eval( oBloco ))
			nTotPagar  := 0
			nTotPago   := 0
			cCodi 	  := Saidas->Codi
			cFatura	  := Saidas->Fatura
			nVlrFatura := Saidas->VlrFatura
			Receber->(DbSeek( cCodi ))
			cNome 	  := Receber->Nome
			if !lCancelado
				if Receber->Cancelada
					Saidas->(DbSkip(1))
					Loop
				endif
			endif
			if Recemov->(DbSeek( cFatura ))
				While Recemov->Fatura = cFatura
					nTotPagar += Recemov->Vlr
					Recemov->(DbSkip(1))
				Enddo
			endif
			if Recebido->(DbSeek( cFatura ))
				While Recebido->Fatura = cFatura
					nTotPago += Recebido->Vlr
					Recebido->(DbSkip(1))
				Enddo
			endif
			nPagoPerc  := ( nTotPago / nVlrFatura ) * 100
			nPagarPerc := ( 100 - nPagoPerc )
			if nPagarPerc < 0
				nPagarPerc := 0
			endif
			cPago 	  := Tran( nPagoPerc,  "999%")
			cPagar	  := Tran( nPagarPerc, "999%")
			cVlrFatura := Tran( nVlrFatura, '@E 9,999,999.99')
			if Ascan2( aRelato, cFatura, 3 ) <= 0
				if nPagarPerc >= nPorc
					Aadd( aRelato, { cCodi, cNome, cFatura, cVlrFatura, cPago, cPagar })
				endif
			endif
			Saidas->(DbSkip(1))
		Enddo
		if !InsTru80()
			ResTela( cScreen )
			return
		endif
		PrintOn()
		SetPrc( 0,0 )
		oRelato				:= TRelatoNew()
		oRelato:Sistema	:= SISTEM_NA3
		oRelato:Titulo 	:= "RELATORIO DE PERCENTUAL PAGO/PAGAR"
		oRelato:Cabecalho := "CODI  NOME DO CLIENTE                          FATURA      VLR FATURA PAGO PAGAR"
		oRelato:Inicio()
		For nX := 1 To Len( aRelato )
			Qout( aRelato[nX,1], aRelato[nX,2], aRelato[nX,3], aRelato[nX,4], aRelato[nX,5], aRelato[nX,6])
			oRelato:RowPrn ++
		Next
		__Eject()
		PrintOff()
	endif
EndDo


Proc MarDesMarcaCliente()
*************************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
Area("Receber")
Receber->(Order( RECEBER_NOME ))
Receber->(DbGoTop())
oBrowse:Add( "ROL",       "Rol")
oBrowse:Add( "CODIGO",    "Codi")
oBrowse:Add( "NOME",      "Nome")
oBrowse:Add( "CIDADE",    "Cida")
oBrowse:Add( "UF",        "Esta")
oBrowse:Titulo   := "MARCA/DESMARCA CLIENTES PARA RELATORIO COBRANCA"
oBrowse:PreDoGet := NIL
oBrowse:PosDoGet := NIL
oBrowse:PreDoDel := {|| HotPreCli( oBrowse ) }
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

*:==================================================================================================================================

Proc RemoveAgenda()
*******************
LOCAL aMenu 	:= {'Individual','Por Cliente','Geral'}
LOCAL cScreen	:= SaveScreen()
LOCAL cCodiVen := Space(04)
LOCAL cCodi 	:= Space(05)
LOCAL nChoice	:= 0

WHILE OK
	oMenu:Limpa()
	M_Title('REMOVER AGENDAMENTO COBRANCA')
	nChoice := FazMenu( 03, 10, aMenu )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		return

	Case nChoice = 1
		MaBox( 10, 10, 12, 78 )
		cCodiVen := Space( 04 )
		@ 11 , 11 Say "Cobrador..:" Get cCodiVen Pict "9999" Valid FunErrado( @cCodiVen,, Row(), Col()+1 )
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			return
		endif
		ErrorBeep()
		if Conf("Pergunta: Alteracao podera demorar. Continua ?")
			Recemov->(DbGotop())
			Mensagem("Aguarde, Removendo Agendamento por Cobrador.")
			While Recemov->(!Eof()) .AND. Rep_Ok()
				if Recemov->Cobrador = cCodiVen
					cCodi   := Recemov->Codi
					oAgenda := oAmbiente:xBaseDados + '\AGE' + cCodi + '.INI'
					Ferase( oAgenda )
			  endif
			  Recemov->(DbSkip(1))
			EndDo
		endif

	Case nChoice = 2
		cCodi := Space( 05 )
		MaBox( 10, 10, 12, 78 )
		@ 11, 11 Say "Cliente....:" GET cCodi PICT PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			return
		endif
		ErrorBeep()
		if Conf("Pergunta: Continua ?")
			Mensagem("Aguarde, Removendo Agendamento por Cliente.")
			Recemov->(Order( RECEMOV_CODI ))
			if Recemov->(DbSeek( cCodi ))
				While Recemov->Codi = cCodi
					oAgenda := oAmbiente:xBaseDados + '\AGE' + cCodi + '.INI'
					Ferase( oAgenda )
					Recemov->(DbSkip(1))
				EndDo
			endif
		endif

	Case nChoice = 3
		ErrorBeep()
		if Conf("Pergunta: Alteracao podera demorar. Continua ?")
			Recemov->(DbGotop())
			Mensagem("Aguarde, Removendo Agendamento Geral.")
			While Recemov->(!Eof()) .AND. Rep_Ok()
				cCodi   := Recemov->Codi
				oAgenda := oAmbiente:xBaseDados + '\AGE' + cCodi + '.INI'
				Ferase( oAgenda )
				Recemov->(DbSkip(1))
			EndDo
		endif
	EndCase
EndDo

Proc Prn002Cob( cTitulo, dIni, dFim, dAtual, aCodi, cCodiVen, lTotal, lSeletiva, aReg, dProxCob, dProxCobFim )
**************************************************************************************************************
LOCAL cScreen	  := SaveScreen()
LOCAL lSair 	  := FALSO
LOCAL Lista 	  := SISTEM_NA3
LOCAL Tam		  := 132
LOCAL Col		  := 58
LOCAL Pagina	  := 0
LOCAL NovoCodi   := OK
LOCAL lSub		  := FALSO
LOCAL UltCodi	  := Recemov->Codi
LOCAL GrandTotal := 0
LOCAL nCarencia  := 0
LOCAL GrandJuros := 0
LOCAL GrandGeral := 0
LOCAL Atraso	  := 0
LOCAL Juros 	  := 0
LOCAL TotalCli   := 0
LOCAL TotalJur   := 0
LOCAL TotalGer   := 0
LOCAL nJrVlr	  := 0
LOCAL nJuros	  := 0
LOCAL nJdia 	  := 0
LOCAL nAtraso	  := 0
LOCAL nJuro 	  := 0
LOCAL nValor	  := 0
LOCAL nDocumento := 0
LOCAL nClientes  := 0
LOCAL nY 		  := 0
LOCAL nConta	  := 0
LOCAL aRelato	  := {}
LOCAL nResuVlr   := 0
LOCAL nResuDocs  := 0
LOCAL nResuJrVlr := 0
LOCAL cTela
LOCAL dEmis
LOCAL dVcto
LOCAL NovoNome
LOCAL UltNome
LOCAL oAgenda
LOCAL cAgenda1
LOCAL cAgenda2
LOCAL cData1
LOCAL cData2

cTela := Mensagem("Aguarde, imprimindo.")
PrintOn()
FPrint(PQ)
SetPrc( 0 , 0 )
Area("ReceMov")
nLenCodi := Len( aCodi )
For nY := 1 To nLenCodi
	Receber->( Order( RECEBER_CODI ))
	cCodiReceber := aCodi[nY]
	if Receber->(DbSeek( cCodiReceber ))
		Recemov->(Order( RECEMOV_CODI ))
		if Recemov->(!DbSeek( cCodiReceber ))
			Loop
		endif
	else
		Loop
	endif
	NovoCodi := OK
	WHILE Recemov->Codi = cCodiReceber .AND. Recemov->(!Eof()) .AND. Rel_Ok()
		/*
		if dProxCob != NIL
			// if Receber->ProxCob > dProxCob .AND. Receber->ProxCob < dProxCobFim
			if Receber->ProxCob < dProxCob .OR. Receber->ProxCob > dProxCobFim
				Recemov->(DbSkip(1))
				Loop
			endif
		endif
		*/
		if lSeletiva = NIL .OR. lSeletiva = FALSO
			if Recemov->Vcto < dIni .OR. Recemov->Vcto > dFim
				Recemov->(DbSkip(1))
				Loop
			endif
		else
			xRecno := Recemov->(Recno())
			if Ascan( aReg, xRecno ) = 0
				Recemov->(DbSkip(1))
				Loop
			endif
		endif
		Atraso	 := Atraso(   dAtual, Vcto )
		nDesconto := VlrDesconto( dAtual, Vcto, Vlr )
		nMulta	 := VlrMulta( dAtual, Vcto, Vlr )
		nCarencia := Carencia( dAtual, Vcto )
		if Atraso <= 0
			Juros := 0
		else
			Juros := Jurodia * nCarencia
		endif
		if Col >= 57
			Write( 01, 001, "Pagina N?" + StrZero( ++Pagina , 3 ) )
			Write( 01, 117, "Horas "+ Time())
			Write( 02, 001, Dtoc( Date() ))
         Write( 03, 000, Padc( AllTrim(oAmbiente:xNomefir), Tam ))
			Write( 04, 000, Padc( Lista  , Tam ))
			Write( 05, 000, Padc( cTitulo , Tam ))
			Write( 06, 000, Repl( "=", Tam ) )
			Write( 07, 000, "DOC N?RG TIPO    EMISSAO     VCTO PORTADOR     VLR TITULO JR MES ATR  JR DIARIO     DESCONTO        MULTA  TOTAL JUROS  TOTAL GERAL")
			Write( 08, 000, Repl( "=", Tam ) )
			Col := 9
		endif
		if NovoCodi .OR. Col = 9
			if NovoCodi
				NovoCodi := FALSO
			endif
			Qout( Codi, Receber->Regiao, Receber->Nome, Receber->Fone, Receber->( Trim( Ende )), Receber->(Trim(Bair)),Receber->( Trim( Cida )), Receber->Esta )
			Qout( Space(05), "SPC:" + if( Receber->Spc, "SIM em " + Dtoc( Receber->DataSpc ), "NAO"), Space(1), Receber->Fanta, Receber->Obs )
			Qout( Space(05), 'PROFISSAO: ' + Receber->Profissao, 'TRABALHO:' + Receber->Trabalho, 'CARGO : ' + Receber->Cargo )
			Qout( Space(05), 'AVALISTA : ' + Receber->Conhecida,  'ENDERECO:' + Receber->Ende3 )
			Col += 4
			oAgenda := TIniNew('AGE' + cCodiReceber + '.INI')
			nConta := oAgenda:ReadInteger( Codi, 'soma', 0 )
			For nV = 1 To nConta Step 2
				cAgenda1 := Left( oAgenda:ReadString( Codi, StrZero(nV,	2), Repl('_',40), 1), 40)
				cData1	:= Dtoc( oAgenda:ReadDate( Codi,   StrZero(nV,	2), cTod('//'), 2))
				cAgenda2 := Left( oAgenda:ReadString( Codi, StrZero(nV+1,2), Repl('_',40), 1), 40)
				cData2	:= Dtoc( oAgenda:ReadDate( Codi,   StrZero(nV+1,2), cTod('//'), 2))
				Qout(  Space(05), 'AGENDA ' + StrZero( nV,   2) + ': ' + cData1 + ' ' + cAgenda1 )
				QQout( Space(05), 'AGANDA ' + StrZero( nV+1, 2) + ': ' + cData2 + ' ' + cAgenda2 )
				Col++
			Next
			oAgenda:Close()
		endif
		cEmis 	 := Dtoc( Emis )
		cVcto 	 := Dtoc( Vcto )
		cJuro 	 := Tran( Juro,	"999.99")
		cAtraso	 := Tran( Atraso, "999")
		cJdia 	 := Tran( Jurodia,		"@E 999,999.99")
		cValor	 := Tran( Vlr, 			"@E 9,999,999.99")
		cJuros	 := Tran( Juros,			"@E 9,999,999.99")
		cDesconto := Tran( nDesconto, 	"@E 9,999,999.99")
		cMulta	 := Tran( nMulta, 		"@E 9,999,999.99")
		cJrVlr	 := Tran((( Juros + Vlr ) + nMulta ) - nDesconto,	"@E 9,999,999.99")
		nJrVlr	 := ((( Juros + Vlr ) + nMulta ) - nDesconto)
		if !lTotal
			xPos := Ascan2( aRelato, Codi, 2 )
			if xPos <= 0
				Aadd( aRelato, { 1, Codi, Receber->Nome, Vlr, nJrVlr })
			else
				aRelato[xPos,1] += 1
				aRelato[xPos,4] += Vlr
				aRelato[xPos,5] += nJrVlr
			endif
			Qout( Docnr, Tipo, cEmis, cVcto,Port, cValor, cJuro, cAtraso, cJdia, cDesconto, cMulta,cJuros, cJrVlr )
			Col++
		endif
		Totalcli   += Vlr
		Totaljur   += Juros
		Totalger   += nJrVlr
		GrandTotal += Vlr
		GrandJuros += Juros
		GrandGeral += nJrVlr
		nDocumento ++
		if Recemov->(TravaReg())
			Recemov->Cobrador := cCodiVen
			Recemov->RelCob	:= OK
			Recemov->(Libera())
		endif
		Recemov->(DbSkip(1))
		if Col >= 57
			Col++
			Terminou( Tam, Col, TotalCli, TotalJur, TotalGer )
			TotalCli := 0
			TotalJur := 0
			TotalGer := 0
			Col		+= 2
			__Eject()
		endif
	EndDo
	if TotalCli != 0
		Col++
		Terminou( Tam, Col, TotalCli, TotalJur, TotalGer )
		TotalCli := 0
		TotalJur := 0
		TotalGer := 0
		Col		+= 2
	endif
Next
Write(  Col , 000, "** Total Geral **" )
Write(  Col , 020, StrZero( nLenCodi, 6 ) + ' - ' + StrZero( nDocumento, 6 ))
Write(  Col , 046, Tran( GrandTotal, "@E 9,999,999.99" ))
Write(  Col , 107, Tran( GrandJuros, "@E 9,999,999.99" ))
Write(  Col , 120, Tran( GrandGeral, "@E 9,999,999.99" ))
__Eject()
PrintOff()
oMenu:Limpa()
ErrorBeep()
if Conf('Pergunta: Confirma Impressao do Resumo ?')
	Asort( aRelato,,, {| x, y | y[3] > x[3] } )
	if !InsTru80()
		ResTela( cScreen )
		return
	endif
	PrintOn()
	FPrint(PQ)
	SetPrc( 0,0 )
	oRelato				:= TRelatoNew()
	oRelato:Tamanho	:= 132
	oRelato:Sistema	:= SISTEM_NA3
	oRelato:Titulo 	:= cTitulo
	oRelato:Cabecalho := 'CODI  NOME DO CLIENTE                       QTD DOC        VALOR    VLR C/ JR'
	oRelato:Inicio()
	nResuVlr   := 0
	nResuJrVlr := 0
	nResuDocs  := 0
	For nX := 1 To Len( aRelato )
		Qout( aRelato[nX,2], aRelato[nX,3], Tran( aRelato[nX,1], '9999'), Tran( aRelato[nX,4], '@E 9,999,999.99'), Tran( aRelato[nX,5], '@E 9,999,999.99'))
		oRelato:RowPrn ++
		nResuVlr   += aRelato[nX,4]
		nResuJrVlr += aRelato[nX,5]
		nResuDocs  += aRelato[nX,1]
	Next
	Qout()
	Qout('** Total Geral **', Space(28), Tran( nResuDocs, '9999'), Tran( nResuVlr, '@E 9,999,999.99'), Tran( nResuVlr, '@E 9,999,999.99'))
	__Eject()
	PrintOff()
endif
ResTela( cScreen )
return


Function ReciboDiv( cCaixa, cVendedor )
***************************************
LOCAL cScreen := SaveScreen()
LOCAL aMenu   := {'Recibo Diarias Semanal','Recibo Diversos','Vale Diversos'}
LOCAL nChoice := 0

WHILE OK
	oMenu:Limpa()
	M_Title("RECIBOS/VALES DIVERSOS" )
	nChoice := FazMenu( 10, 10, aMenu )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		return

	Case nChoice = 1
      DivDiaria( cCaixa, cVendedor, "RECIBO")

	Case nChoice = 2
      DivRecibo( cCaixa, cVendedor, 'RECIBO', nChoice)

	Case nChoice = 3
      DivRecibo( cCaixa, cVendedor, 'VALE', nChoice)
	EndCase
END

Function DivDiaria( cCaixa, cVendedor, cTipo )
**********************************************
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL cScreen	 := SaveScreen()
LOCAL cCodiven  := Space(04)
LOCAL dIni		 := Date()-5
LOCAL dFim		 := Date()
LOCAL cNome 	 := Space(40)
LOCAL cEnde 	 := Space(40)
LOCAL cCida 	 := Space(40)
LOCAL cValor	 := Space(0)
LOCAL cHist 	 := Space(40)
LOCAL cRef		 := Space(40)
LOCAL cCodiCx	 := '0000'
LOCAL cDc		 := 'D'
LOCAL nOpcao	 := 1
LOCAL nVlrTotal := 0
LOCAL Larg		 := 80
LOCAL nValor	 := 0
LOCAL nChSaldo  := 0
LOCAL cDocnr	 := StrZero( Chemov->(LastRec()), 9 )
LOCAL nTamDoc	 := 0
LOCAL nVlrLcto  := 0
LOCAL cTela
LOCAL nRow

WHILE OK
	oMenu:Limpa()
	cCodiven := Space(04)
	dIni		:= Date()-5
	dFim		:= Date()
	cNome 	:= Space(40)
	cEnde 	:= Space(40)
	cCida 	:= Space(40)
	cHist 	:= 'QUITACAO DIARIAS SERVICO DE INSTALACAO ANTENAS REF '
	cRef		:= cHist
	cCodiCx	:= '0000'
	cDc		:= 'D'
	cDc1		:= 'D'
	cDc2		:= 'D'
	nValor	:= 0
	cDocnr	:= AllTrim( cDocnr )
	nTamDoc	:= Len( cDocnr )
	cDocnr	:= StrZero( Val( cDocnr ) + 1, nTamDoc ) + Space( 9 - nTamDoc )
	MaBox( 07, 00, 13, 79, 'IMPRESSAO DE ' + cTipo + ' DIVERSOS' )
	@ 08, 01 Say "Funcionario....: " Get cCodiven Pict "9999" Valid FunErrado( @cCodiven,,Row(),Col()+1)
	@ 09, 01 Say "Data Inicio....: " Get dIni     Pict "##/##/##" Valid if(Empty(dIni),  ( ErrorBeep(), Alerta("Ooops!: Entre com uma data!"), FALSO ), OK )
	@ 10, 01 Say "Data Final.....: " Get dFim     Pict "##/##/##" Valid if(Empty(dFim),  ( ErrorBeep(), Alerta("Ooops!: Entre com uma data!"), FALSO ), OK )
	@ 11, 01 Say "Valor R$.......: " Get nValor   Pict "@E 9,999,999.99" Valid if(Empty(nValor), ( ErrorBeep(), Alerta("Ooops!: Entre com um valor!"), FALSO ), OK )
	@ 12, 01 Say "Documento N?..: " Get cDocnr   Pict "@!" Valid CheqDoc(cDocnr)
	Read
	if LastKey() = ESC
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		return
	endif
	ErrorBeep()
	if !Conf('Pergunta: Confirma lancamento ?')
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Loop
	endif
	nVlrLcto := nValor
	cHist 	:= 'QUITACAO DIARIAS SERVICO DE INSTALACAO ANTENAS REF '
	cHist 	+= dToc( dIni )
	cHist 	+= ' A '
	cHist 	+= dToc( dFim )
	cRef		:= cHist

	Vendedor->(Order( VENDEDOR_CODIVEN ))
	if Vendedor->(DbSeek( cCodiven ))
		cNome := Alltrim(Vendedor->Nome)
		cEnde := AllTrim(Vendedor->Ende)
		cEnde += if(!Empty(Vendedor->Bair),' - ','')
		cEnde += AllTrim(Vendedor->Bair)
		cCida := AllTrim(Vendedor->Cida)
		cCida += if(!Empty(Vendedor->Esta),'/','')
		cCida += Vendedor->Esta
	endif

	if Cheque->(DbSeek( cCodiCx )) .OR. !Empty( cCodiCx )
		if Cheque->(TravaReg())
			nChSaldo := Cheque->Saldo
			if Chemov->(Incluiu())
				if cDc = "C"
					nChSaldo 	  += nVlrLcto
					Cheque->Saldo += nVlrLcto
					Chemov->Cre   := nVlrLcto
				else
					nChSaldo 	  -= nVlrLcto
					Cheque->Saldo -= nVlrLcto
					Chemov->Deb   := nVlrLcto
				endif
				Chemov->Codi	:= cCodiCx
				Chemov->Docnr	:= cDocnr
				Chemov->Emis	:= Date()
				Chemov->Data	:= Date()
				Chemov->Baixa	:= Date()
				Chemov->Hist	:= cHist
				Chemov->Saldo	:= nChSaldo
				Chemov->Tipo	:= 'OU'
				Chemov->Caixa	:= if( cCaixa = Nil, Space(4), cCaixa )
				Chemov->Fatura := cDocnr
			endif
			Chemov->(Libera())
		endif
		Cheque->(Libera())
	endif
	*:-------------------------------------------------------

	if Recibo->(Incluiu())
		Recibo->Nome	 := cNome
      Recibo->Vcto    := dFim
      Recibo->Tipo    := "PAGDIA"

      Recibo->Codi    := cCodiven
		Recibo->Docnr	 := cDocnr
      Recibo->Hora    := Time()
      Recibo->Data    := Date()
      Recibo->Usuario := oAmbiente:xUsuario + Space( 10 - Len( oAmbiente:xUsuario ))

		Recibo->Caixa	 := cCaixa
      Recibo->Vlr     := -nValor
		Recibo->Hist	 := cHist
		Recibo->(Libera())
	endif


   *:-------------------------------------------------------
	if !Instru80() .OR. !LptOk()
		Restela( cScreen )
		return
	endif
	cTela := Mensagem("Aguarde, Imprimindo Recibo.")
	PrintOn()
	FPrInt( Chr(ESC) + "C" + Chr( 33 ))
	nVlrTotal := nValor
	cValor	 := AllTrim(Tran( nVlrTotal,'@E 9,999,999.99'))
	nValor	 := Extenso( nVlrTotal, 1, 3, Larg )
	SetPrc(0,0)
	nRow := 2
	Write( nRow+00, 00, Repl("=",80))
	Write( nRow+01, 00, GD + Padc( Trim( cNome ), 40) + CA )
	Write( nRow+02, 00, Padc( Trim(cEnde) + " - " + Trim(cCida), 80 ))
	Write( nRow+03, 00, Repl("-",80))
	Write( nRow+04, 40, GD + cTipo + CA + NR)
	Write( nRow+05, 00, "N?" + NG + cDocnr + NR )
	Write( nRow+05, 66, "R$ " + NG + cValor + NR )
   Write( nRow+07, 00, "Recebemos de    : " + NG + AllTrim(oAmbiente:xNomefir)+ NR )
	Write( nRow+08, 00, "Estabelecido  a : " + NG + XENDEFIR + NR )
	Write( nRow+09, 00, "na Cidade de    : " + NG + XCCIDA + ' - ' + XCESTA + NR )
	Write( nRow+11, 00, "A Importancia por extenso abaixo relacionada")
	Write( nRow+12, 00, NG + Left( nValor, Larg ) + NR  )
	Write( nRow+13, 00, NG + SubStr( nValor, Larg + 1, Larg ) + NR  )
	Write( nRow+14, 00, NG + Right( nValor, Larg ) + NR  )
	Write( nRow+16, 00, "Referente a")
	Write( nRow+17, 00, NG + cRef + NR )
	Write( nRow+19, 00, "Para maior clareza firmo(amos) o presente")
	Write( nRow+20, 00, NG + Padl(DataExt( Date()), 80) + NR)
	Write( nRow+24, 00, Padl(Repl("-",40),80))
	Write( nRow+25, 00, Repl("=",80))
	__Eject()
	PrintOff()
	ResTela( cTela )
EndDo

*:---------------------------------------------------------------------------------------------------------------------------------

Proc DivRecibo( cCaixa, cVendedor, cTipo, nChoice )
***************************************************
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL cScreen	 := SaveScreen()
LOCAL cNome 	 := Space(40)
LOCAL cEnde 	 := Space(40)
LOCAL cCida 	 := Space(40)
LOCAL cValor	 := Space(0)
LOCAL cHist 	 := Space(40)
LOCAL cRef		 := Space(40)
LOCAL cCodiCx1  := Space(04)
LOCAL cCodiCx2  := Space(04)
LOCAL cCodiCx	 := '0000'
LOCAL cDc		 := 'D'
LOCAL cDc1		 := 'D'
LOCAL cDc2		 := 'D'
LOCAL nOpcao	 := 1
LOCAL nVlrTotal := 0
LOCAL Larg		 := 80
LOCAL nValor	 := 0
LOCAL nChSaldo  := 0
LOCAL cDocnr	 := StrZero( Chemov->(LastRec()), 9 )
LOCAL nTamDoc	 := 0
LOCAL nVlrLcto  := 0
LOCAL cTela
LOCAL nRow
LOCAL cNomeFir
LOCAL cStr

cNome 	:= Space(40)
cEnde 	:= Space(40)
cCida 	:= Space(40)
cHist 	:= Space(40)
cRef		:= Space(40)
cCodiCx1 := Space(04)
cCodiCx2 := Space(04)
cCodiCx	:= '0000'
cDc		:= 'D'
cDc1		:= 'D'
cDc2		:= 'D'
nValor	:= 0
cDocnr	:= AllTrim( cDocnr )
nTamDoc	:= Len( cDocnr )
cNomeFir := oAmbiente:xNomefir
WHILE OK
	oMenu:Limpa()
	cDocnr	:= StrZero( Val( cDocnr ) + 1, nTamDoc ) + Space( 9 - nTamDoc )
   MaBox( 06, 00, 18, 79, 'IMPRESSAO DE ' + cTipo + ' DIVERSOS' )
   @ 07, 01 Say "Recebemos de...: " Get cNomeFir Pict "@!" Valid if(Empty(cNomeFir),  ( ErrorBeep(), Alerta("Ooops!: Entre com um nome!"), FALSO ), OK )
   @ 08, 01 Say "Nome Emitente..: " Get cNome    Pict "@!" Valid if(Empty(cNome),  ( ErrorBeep(), Alerta("Ooops!: Entre com um nome!"), FALSO ), OK )
	@ 09, 01 Say "Estabelecido a : " Get cEnde    Pict "@!" Valid if(Empty(cEnde),  ( ErrorBeep(), Alerta("Ooops!: Entre com um Endereco!"), FALSO ), OK )
	@ 10, 01 Say "Na Cidade de   : " Get cCida    Pict "@!" Valid if(Empty(cCida),  ( ErrorBeep(), Alerta("Ooops!: Entre com uma Cidade!"), FALSO ), OK )
	@ 11, 01 Say "Documento N?..: " Get cDocnr   Pict "@!" Valid CheqDoc(cDocnr)
	@ 12, 01 Say "Referente......: " Get cRef     Pict "@!" Valid if(Empty(cRef),   ( ErrorBeep(), Alerta("Ooops!: Entre com a referencia!"), FALSO ), (ValidarcHist(cRef,@cHist), OK))
	@ 13, 01 Say "Historico Cx...: " Get cHist    Pict "@!" Valid if(Empty(cHist),  ( ErrorBeep(), Alerta("Ooops!: Entre com o historico!"), FALSO ), OK )
	@ 14, 01 Say "Valor R$.......: " Get nValor   Pict "@E 9,999,999.99" Valid if(Empty(nValor), ( ErrorBeep(), Alerta("Ooops!: Entre com um valor!"), FALSO ), OK )
	@ 15, 01 Say "Conta Caixa....: " GET cCodiCx  Pict "9999" Valid CheErrado( @cCodiCx,, Row(), 32, OK )
	@ 15, 24 Say "D/C.:"             GET cDc      Pict "!"    Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc )
	@ 16, 01 Say "C. Partida.....: " GET cCodiCx1 Pict "9999" Valid CheErrado( @cCodiCx1,, Row(), 32, OK )
	@ 16, 24 Say "D/C.:"             GET cDc1     Pict "!"    Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc1 )
	@ 17, 01 Say "C. Partida.....: " GET cCodiCx2 Pict "9999" Valid CheErrado( @cCodiCx2,, Row(), 32, OK )
	@ 17, 24 Say "D/C.:"             GET cDc2     Pict "!"    Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc2 )
	Read
	if LastKey() = ESC
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		return
	endif
	ErrorBeep()
	if !Conf('Pergunta: Confirma lancamento ?')
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Loop
	endif
	nVlrLcto := nValor
	if Cheque->(DbSeek( cCodiCx )) .OR. !Empty( cCodiCx )
		if Cheque->(TravaReg())
			nChSaldo := Cheque->Saldo
			if Chemov->(Incluiu())
				if cDc = "C"
					nChSaldo 	  += nVlrLcto
					Cheque->Saldo += nVlrLcto
					Chemov->Cre   := nVlrLcto
				else
					nChSaldo 	  -= nVlrLcto
					Cheque->Saldo -= nVlrLcto
					Chemov->Deb   := nVlrLcto
				endif
				Chemov->Codi	:= cCodiCx
				Chemov->Docnr	:= cDocnr
				Chemov->Emis	:= Date()
				Chemov->Data	:= Date()
				Chemov->Baixa	:= Date()
				Chemov->Hist	:= cHist
				Chemov->Saldo	:= nChSaldo
				Chemov->Tipo	:= 'OU'
				Chemov->Caixa	:= if( cCaixa = Nil, Space(4), cCaixa )
				Chemov->Fatura := cDocnr
			endif
			Chemov->(Libera())
		endif
		Cheque->(Libera())
	endif
	*:-------------------------------------------------------
	if Cheque->(DbSeek( cCodiCx1 )) .OR. !Empty( cCodiCx1 )
		if Cheque->(TravaReg())
			nChSaldo := Cheque->Saldo
			if Chemov->(Incluiu())
				if cDc1 = "C"
					nChSaldo 	  += nVlrLcto
					Cheque->Saldo += nVlrLcto
					Chemov->Cre   := nVlrLcto
				else
					nChSaldo 	  -= nVlrLcto
					Cheque->Saldo -= nVlrLcto
					Chemov->Deb   := nVlrLcto
				endif
				Chemov->Codi	:= cCodiCx1
				Chemov->Docnr	:= cDocnr
				Chemov->Emis	:= Date()
				Chemov->Data	:= Date()
				Chemov->Baixa	:= Date()
				Chemov->Hist	:= cHist
				Chemov->Saldo	:= nChSaldo
				Chemov->Tipo	:= 'OU'
				Chemov->Caixa	:= if( cCaixa = Nil, Space(4), cCaixa )
				Chemov->Fatura := cDocnr
			endif
			Chemov->(Libera())
		endif
		Cheque->(Libera())
	endif
	*:-------------------------------------------------------
	if Cheque->(DbSeek( cCodiCx2 )) .OR. !Empty( cCodiCx2 )
		if Cheque->(TravaReg())
			nChSaldo := Cheque->Saldo
			if Chemov->(Incluiu())
				if cDc2 = "C"
					nChSaldo 	  += nVlrLcto
					Cheque->Saldo += nVlrLcto
					Chemov->Cre   := nVlrLcto
				else
					nChSaldo 	  -= nVlrLcto
					Cheque->Saldo -= nVlrLcto
					Chemov->Deb   := nVlrLcto
				endif
				Chemov->Codi	:= cCodiCx2
				Chemov->Docnr	:= cDocnr
				Chemov->Emis	:= Date()
				Chemov->Data	:= Date()
				Chemov->Baixa	:= Date()
				Chemov->Hist	:= cHist
				Chemov->Saldo	:= nChSaldo
				Chemov->Tipo	:= 'OU'
				Chemov->Caixa	:= if( cCaixa = Nil, Space(4), cCaixa )
				Chemov->Fatura := cDocnr
			endif
			Chemov->(Libera())
		endif
		Cheque->(Libera())
	endif

	*:-------------------------------------------------------

   if Recibo->(Incluiu())
		Recibo->Nome	 := cNome
      Recibo->Vcto    := Date()
      Recibo->Tipo    := if( nChoice = 2, "PAGDIV", "PAGDIV")
      Recibo->Codi    := "00000"
		Recibo->Docnr	 := cDocnr
      Recibo->Hora    := Time()
      Recibo->Data    := Date()
      Recibo->Usuario := oAmbiente:xUsuario + Space( 10 - Len( oAmbiente:xUsuario ))
      Recibo->Caixa   := cCaixa
      Recibo->Vlr     := -nValor
		Recibo->Hist	 := cHist
		Recibo->(Libera())
	endif

   *:-------------------------------------------------------

   if !Instru80() .OR. !LptOk()
		Restela( cScreen )
		return
	endif
	Mensagem("Aguarde, Imprimindo Recibo.")
	PrintOn()
	FPrInt( Chr(ESC) + "C" + Chr( 33 ))
	nVlrTotal := nValor
   cStr   := AllTrim(Tran( nVlrTotal,'@E 9,999,999.99'))
   cValor := Extenso( nVlrTotal, 1, 3, Larg )
	SetPrc(0,0)
	nRow := 2
	Write( nRow+00, 00, Repl("=",80))
	Write( nRow+01, 00, GD + Padc( Trim( cNome ), 40) + CA )
	Write( nRow+02, 00, Padc( Trim(cEnde) + " - " + Trim(cCida), 80 ))
	Write( nRow+03, 00, Repl("-",80))
	Write( nRow+04, 40, GD + cTipo + CA + NR)
	Write( nRow+05, 00, "N?" + NG + cDocnr + NR )
   Write( nRow+05, 66, "R$ " + NG + cStr + NR )
   Write( nRow+07, 00, "Recebemos de    : " + NG + cNomeFir + NR )
	Write( nRow+08, 00, "Estabelecido  a : " + NG + XENDEFIR + NR )
	Write( nRow+09, 00, "na Cidade de    : " + NG + XCCIDA + ' - ' + XCESTA + NR )
	Write( nRow+11, 00, "A Importancia por extenso abaixo relacionada")
   Write( nRow+12, 00, NG + Left( cValor, Larg ) + NR  )
   Write( nRow+13, 00, NG + SubStr( cValor, Larg + 1, Larg ) + NR  )
   Write( nRow+14, 00, NG + Right( cValor, Larg ) + NR  )
	Write( nRow+16, 00, "Referente a")
	Write( nRow+17, 00, NG + cRef + NR )
	Write( nRow+19, 00, "Para maior clareza firmo(amos) o presente")
	Write( nRow+20, 00, NG + Padl(DataExt( Date()), 80) + NR)
	Write( nRow+24, 00, Padl(Repl("-",40),80))
	Write( nRow+25, 00, Repl("=",80))
	__Eject()
	PrintOff()
EndDo

*:---------------------------------------------------------------------------------------------------------------------------------

Proc ValidarcHist(cRef,cHist)
*****************************
cHist = cRef
return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc RelRecebido()
******************
LOCAL GetList		 := {}
LOCAL cScreen		 := SaveScreen()
LOCAL aTPrompt 	 := {" Individual ", " Por Portador ", " Por Vendedor ", " Por Forma Pgto", " Por Regiao"," Por Data Baixa *", " Por Tipo", " Por Caixa ", " Totalizado ", " Geral " }
LOCAL aOrdem		 := {"Codigo","Data Pgto *", "Documento","Emissao", "Observacoes", "Portador", "Tipo", "Valor", "Valor Pago", "Vencimento"}
LOCAL nRolRecebido := oIni:ReadInteger('relatorios', 'rolrecebido', 1)
LOCAL xArquivo 	 := TempNew()
LOCAL xNtx			 := TempNew()
LOCAL cForma		 := Space(02)
LOCAL cCodi 		 := Space(05)
LOCAL dIni			 := Date()-30
LOCAL dFim			 := Date()
LOCAL cRegiao		 := Space(02)
LOCAL dBaixaIni	 := Date()-30
LOCAL dBaixaFim	 := Date()
LOCAL cTipo 		 := Space(06)
LOCAL cCaixa		 := Space(04)
LOCAL nConta		 := 0
LOCAL nOpcao		 := 0
LOCAL cTela
LOCAL bPeriodo
LOCAL bTipo
LOCAL nField
LOCAL nChoice
LOCAL oBloco
LOCAL cPortador
LOCAL cCodiVen
LOCAL Tam
LOCAL Col
LOCAL Pagina
LOCAL nTotalVlr
LOCAL nTotalJur
LOCAL nTotalRec
LOCAL nDocumento
LOCAL cFatura
LOCAL bCaixa

WHILE OK
	oMenu:Limpa()
	Saidas->(Order( SAIDAS_FATURA ))
	Area("ReceBido")
	M_Title( "ROL TITULOS RECEBIDOS" )
	nChoice := FazMenu( 01, 20, AtPrompt )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1 // Cliente
		cCodi := Space(05)
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 15, 20 , 19, 79 )
		@ 16, 21 Say "Cliente.:" Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+3 )
		@ 17, 21 Say "Inicio..:" Get dIni  Pict "##/##/##"
		@ 18, 21 Say "Fim.....:" Get dFim  Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Mensagem("Aguarde, Processando Pesado.")
		Area("ReceBido")
		Recebido->(Order( RECEBIDO_CODI ))
		if Recebido->(!DbSeek( cCodi ))
			Nada()
			Restela( cScreen )
			Loop
		endif
		nConta := 0
		Copy Stru To ( xArquivo )
		Use (xArquivo) Exclusive Alias xTemp New
		WHILE Recebido->Codi = cCodi
			if Recebido->DataPag >= dIni .AND. Recebido->DataPag <= dFim
				if nRolRecebido = 2
					cFatura := Recebido->Fatura
					if Saidas->(DbSeek( cFatura ))
						if !Saidas->Impresso
							Recebido->(DbSkip(1))
							Loop
						endif
					endif
				endif
				nConta++
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Recebido->(FieldGet( nField ))))
				Next
			endif
			Recebido->(DbSkip(1))
		EndDo
		if nConta = 0 // Nao Encontrou Nada.
			xTemp->(DbCloseArea())
			Ferase( xArquivo )
			Ferase( xNtx )
			ErrorBeep()
			Nada()
			Restela( cScreen )
			Loop
		endif

	Case nChoice = 2 // Portador
		cPortador := Space( 10 )
		dIni		 := Date()-30
		dFim		 := Date()
		MaBox( 15 , 20 , 19 , 75 )
		@ 16, 21 Say "Portador......... :" Get cPortador Pict "@!" Valid AchaPortador( @cPortador )
		@ 17, 21 Say "Data Pgto Inicial.:" Get dIni Pict "##/##/##"
		@ 18, 21 Say "Data Pgto Final...:" Get dFim Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Mensagem("Aguarde, Processando Pesado.")
		Area("ReceBido")
		Recebido->(Order( RECEBIDO_PORT ))
		if Recebido->(!DbSeek( cPortador ))
			Nada()
			Restela( cScreen )
			Loop
		endif
		nConta := 0
		Copy Stru To ( xArquivo )
		Use (xArquivo) Exclusive Alias xTemp New
		WHILE Recebido->Port = cPortador
			if Recebido->DataPag >= dIni .AND. Recebido->DataPag <= dFim
				if nRolRecebido = 2
					cFatura := Recebido->Fatura
					if Saidas->(DbSeek( cFatura ))
						if !Saidas->Impresso
							Recebido->(DbSkip(1))
							Loop
						endif
					endif
				endif
				nConta++
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Recebido->(FieldGet( nField ))))
				Next
			endif
			Recebido->(DbSkip(1))
		EndDo
		if nConta = 0 // Nao Encontrou Nada.
			xTemp->(DbCloseArea())
			Ferase( xArquivo )
			Ferase( xNtx )
			ErrorBeep()
			Nada()
			Restela( cScreen )
			Loop
		endif

	Case nChoice = 3 // Vendedor
		cCodiVen := Space(04)
		dIni		:= Date()-30
		dFim		:= Date()
		MaBox( 15 , 20 , 19, 75 )
		@ 16, 21 Say "Vendedor..........:" Get cCodiVen Pict "9999" Valid FunErrado( @cCodiVen )
		@ 17, 21 Say "Data Pgto Inicial.:" Get dIni     Pict "##/##/##"
		@ 18, 21 Say "Data Pgto Final...:" Get dFim     Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Mensagem("Aguarde, Processando Pesado.")
		Area("ReceBido")
		Recebido->(Order( RECEBIDO_CODIVEN ))
		if Recebido->(!DbSeek( cCodiVen ))
			Nada()
			Restela( cScreen )
			Loop
		endif
		nConta := 0
		Copy Stru To ( xArquivo )
		Use (xArquivo) Exclusive Alias xTemp New
		WHILE Recebido->CodiVen = cCodiVen
			if Recebido->DataPag >= dIni .AND. Recebido->DataPag <= dFim
				if nRolRecebido = 2
					cFatura := Recebido->Fatura
					if Saidas->(DbSeek( cFatura ))
						if !Saidas->Impresso
							Recebido->(DbSkip(1))
							Loop
						endif
					endif
				endif
				nConta++
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Recebido->(FieldGet( nField ))))
				Next
			endif
			Recebido->(DbSkip(1))
		EndDo
		if nConta = 0 // Nao Encontrou Nada.
			xTemp->(DbCloseArea())
			Ferase( xArquivo )
			Ferase( xNtx )
			ErrorBeep()
			Nada()
			Restela( cScreen )
			Loop
		endif

	Case nChoice = 4 // Forma
		cForma := Space(02)
		dIni	 := Date()-30
		dFim	 := Date()
		MaBox( 15 , 20 , 19, 75 )
		@ 16, 21 Say "Forma.............:" Get cForma Pict "99" Valid FormaErrada( @cForma )
		@ 17, 21 Say "Data Pgto Inicial.:" Get dIni Pict "##/##/##"
		@ 18, 21 Say "Data Pgto Final...:" Get dFim Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Mensagem("Aguarde, Processando Pesado.")
		Area("ReceBido")
		Recebido->(Order( RECEBIDO_FORMA ))
		if Recebido->(!DbSeek( cForma ))
			Nada()
			Restela( cScreen )
			Loop
		endif
		nConta := 0
		Copy Stru To ( xArquivo )
		Use (xArquivo) Exclusive Alias xTemp New
		WHILE Recebido->Forma = cForma
			if Recebido->DataPag >= dIni .AND. Recebido->DataPag <= dFim
				if nRolRecebido = 2
					cFatura := Recebido->Fatura
					if Saidas->(DbSeek( cFatura ))
						if !Saidas->Impresso
							Recebido->(DbSkip(1))
							Loop
						endif
					endif
				endif
				nConta++
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Recebido->(FieldGet( nField ))))
				Next
			endif
			Recebido->(DbSkip(1))
		EndDo
		if nConta = 0 // Nao Encontrou Nada.
			xTemp->(DbCloseArea())
			Ferase( xArquivo )
			Ferase( xNtx )
			ErrorBeep()
			Nada()
			Restela( cScreen )
			Loop
		endif

	Case nChoice = 5 // Por Regiao
		cRegiao := Space(02)
		dIni	  := Date()-30
		dFim	  := Date()
		MaBox( 15 , 20 , 19, 75 )
		@ 16, 21 Say "Regiao............:" Get cRegiao Pict "99" Valid RegiaoErrada( @cRegiao )
		@ 17, 21 Say "Data Pgto Inicial.:" Get dIni     Pict "##/##/##"
		@ 18, 21 Say "Data Pgto Final...:" Get dFim     Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Mensagem("Aguarde, Processando Pesado.")
		Area("ReceBido")
		Recebido->(Order( RECEBIDO_REGIAO ))
		if Recebido->(!DbSeek( cRegiao ))
			Nada()
			Restela( cScreen )
			Loop
		endif
		nConta := 0
		Copy Stru To ( xArquivo )
		Use (xArquivo) Exclusive Alias xTemp New
		WHILE Recebido->Regiao = cRegiao
			if Recebido->DataPag >= dIni .AND. Recebido->DataPag <= dFim
				if nRolRecebido = 2
					cFatura := Recebido->Fatura
					if Saidas->(DbSeek( cFatura ))
						if !Saidas->Impresso
							Recebido->(DbSkip(1))
							Loop
						endif
					endif
				endif
				nConta++
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Recebido->(FieldGet( nField ))))
				Next
			endif
			Recebido->(DbSkip(1))
		EndDo
		if nConta = 0 // Nao Encontrou Nada.
			xTemp->(DbCloseArea())
			Ferase( xArquivo )
			Ferase( xNtx )
			ErrorBeep()
			Nada()
			Restela( cScreen )
			Loop
		endif

	Case nChoice = 6 // Data da Baixa
		dBaixaIni := Date()-30
		dBaixaFim := Date()
		MaBox( 15 , 20 , 18, 75 )
		@ 16, 21 Say  "Data Baixa Inicial..¯" Get dBaixaIni Pict "##/##/##"
		@ 17, 21 Say  "Data Baixa Final....¯" Get dBaixaFim Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Mensagem("Aguarde, Processando Pesado.")
		dIni := dBaixaIni
		dFim := dBaixaFim
		Area("ReceBido")
		Recebido->(Order( RECEBIDO_BAIXA ))
		Set Soft On
		Recebido->(DbSeek( dBaixaIni ))
		nConta := 0
		Copy Stru To ( xArquivo )
		Use (xArquivo) Exclusive Alias xTemp New
		WHILE Recebido->Baixa >= dBaixaIni .AND. Recebido->Baixa <= dBaixaFim
			if nRolRecebido = 2
				cFatura := Recebido->Fatura
				if Saidas->(DbSeek( cFatura ))
					if !Saidas->Impresso
						Recebido->(DbSkip(1))
						Loop
					endif
				endif
			endif
			nConta++
			xTemp->(DbAppend())
			For nField := 1 To FCount()
				xTemp->( FieldPut( nField, Recebido->(FieldGet( nField ))))
			Next
			Recebido->(DbSkip(1))
		EndDo
		Set Soft Off
		if nConta = 0 // Nao Encontrou Nada.
			xTemp->(DbCloseArea())
			Ferase( xArquivo )
			Ferase( xNtx )
			Nada()
			Restela( cScreen )
			Loop
		endif

	Case nChoice = 7 // Por Tipo
		cTipo := Space(06)
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 15 , 20 , 19, 75 )
		@ 16, 21 Say "Tipo..............:" Get cTipo Pict "@!"
		@ 17, 21 Say "Data Pgto Inicial.:" Get dIni Pict "##/##/##"
		@ 18, 21 Say "Data Pgto Final...:" Get dFim Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Mensagem("Aguarde, Processando Pesado.")
		Area("ReceBido")
		Recebido->(Order( RECEBIDO_DATAPAG ))
		Set Soft On
		Recebido->(DbSeek( dIni ))
		nConta	:= 0
		bPeriodo := {| dDataPag | dDataPag >= dIni .AND. dDataPag <= dFim }
		bTipo 	:= {| xTipo 	| xTipo		= cTipo }
		Copy Stru To ( xArquivo )
		Use (xArquivo) Exclusive Alias xTemp New
		WHILE ( Eval( bPeriodo, Recebido->DataPag ) .AND. Rel_Ok() )
			if Eval( bTipo, Recebido->Tipo )
				if nRolRecebido = 2
					cFatura := Recebido->Fatura
					if Saidas->(DbSeek( cFatura ))
						if !Saidas->Impresso
							Recebido->(DbSkip(1))
							Loop
						endif
					endif
				endif
				nConta++
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Recebido->(FieldGet( nField ))))
				Next
			endif
			Recebido->(DbSkip(1))
		EndDo
		Set Soft Off
		if nConta = 0 // Nao Encontrou Nada.
			xTemp->(DbCloseArea())
			Ferase( xArquivo )
			Ferase( xNtx )
			Nada()
			Restela( cScreen )
			Loop
		endif

	Case nChoice = 8 // Por Caixa
		cCaixa := Space(04)
		dIni	 := Date()-30
		dFim	 := Date()
		MaBox( 15 , 20 , 19, 79 )
		@ 16, 21 Say "Caixa.............:" Get cCaixa Pict "9999" Valid FunErrado( @cCaixa,, Row(), Col()+1)
		@ 17, 21 Say "Data Pgto Inicial.:" Get dIni   Pict "##/##/##"
		@ 18, 21 Say "Data Pgto Final...:" Get dFim   Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Mensagem("Aguarde, Processando Pesado.")
		Area("ReceBido")
		Recebido->(Order( RECEBIDO_DATAPAG ))
		Set Soft On
		Recebido->(DbSeek( dIni ))
		nConta	:= 0
		bPeriodo := {| dDataPag | dDataPag >= dIni .AND. dDataPag <= dFim }
		bCaixa	:= {| xCaixa	| xCaixa 	= cCaixa }
		Copy Stru To ( xArquivo )
		Use (xArquivo) Exclusive Alias xTemp New
		WHILE ( Eval( bPeriodo, Recebido->DataPag ) .AND. Rel_Ok() )
			if Eval( bCaixa, Recebido->Caixa )
				if nRolRecebido = 2
					cFatura := Recebido->Fatura
					if Saidas->(DbSeek( cFatura ))
						if !Saidas->Impresso
							Recebido->(DbSkip(1))
							Loop
						endif
					endif
				endif
				nConta++
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Recebido->(FieldGet( nField ))))
				Next
			endif
			Recebido->(DbSkip(1))
		EndDo
		Set Soft Off
		if nConta = 0 // Nao Encontrou Nada.
			xTemp->(DbCloseArea())
			Ferase( xArquivo )
			Ferase( xNtx )
			Nada()
			Restela( cScreen )
			Loop
		endif

	Case nChoice = 9 // Totalizado
		Tam		  := 132
		Col		  := 58
		Pagina	  := 0
		nTotalVlr  := 0
		nTotalJur  := 0
		nTotalRec  := 0
		nDocumento := 0
		if Recebido->(Lastrec()) = 0
			Nada()
			Loop
		endif
		if !InsTru80() .OR. !LptOk()
			Loop
		endif
		cTela := Mensagem("Aguarde, imprimindo.")
		PrintOn()
		FPrint( PQ )
		SetPrc( 0 , 0 )
		Area("Recebido")
		Recebido->(DbGoTop())
		WHILE Recebido->(!Eof()) .AND. Rel_Ok()
			if nRolRecebido = 2
				cFatura := Recebido->Fatura
				if Saidas->(DbSeek( cFatura ))
					if !Saidas->Impresso
						Recebido->(DbSkip(1))
						Loop
					endif
				endif
			endif
			if Col >= 57
				Qout( Padr( "Pagina N?" + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ))
				Qout( Dtoc( Date() ))
            Qout( Padc( AllTrim(oAmbiente:xNomefir), Tam ))
				Qout( Padc( SISTEM_NA3, Tam ))
				Qout( Padc( "ROL GERAL DE TITULOS RECEBIDOS - TOTALIZADO" , Tam ))
				Qout( Repl( "=", Tam ) )
				Qout("              QTDE DCTOS    TOTAL NOMINAL      TOTAL JUROS      TOTAL GERAL")
				Qout( Repl( "=", Tam ) )
				Col := 9
			endif
			nDocumento ++
			nTotalVlr  += Recebido->Vlr
			nTotalRec  += Recebido->VlrPag
			nTotalJur  += ( Recebido->VlrPag - Recebido->Vlr )
			Recebido->(DbSkip(1))
		EndDo
		Qout("** Total Geral **", Tran( nDocumento, "999999" ),;
								  Tran( nTotalVlr, "@E 9,999,999,999.99" ),;
								  Tran( nTotalJur, "@E 9,999,999,999.99" ),;
								  Tran( nTotalRec, "@E 9,999,999,999.99" ))
		__Eject()
		PrintOff()
		ResTela( cScreen )
		Loop

	Case nChoice = 10 // Geral
		dIni := Date()-30
		dFim := Date()
		MaBox( 15 , 20 , 18 , 75 )
		@ 16, 21 Say "Data Pgto Inicial.:" Get dIni Pict "##/##/##"
		@ 17, 21 Say "Data Pgto Final...:" Get dFim Pict "##/##/##"
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			Loop
		endif
		Mensagem("Aguarde, Processando Pesado.")
		Area("ReceBido")
		Recebido->(Order( RECEBIDO_DATAPAG ))
		Set Soft On
		Recebido->(DbSeek( dIni ))
		nConta := 0
		Copy Stru To ( xArquivo )
		Use (xArquivo) Exclusive Alias xTemp New
		WHILE Recebido->DataPag >= dIni .AND. Recebido->DataPag <= dFim
		  if nRolRecebido = 2
			  cFatura := Recebido->Fatura
			  if Saidas->(DbSeek( cFatura ))
				  if !Saidas->Impresso
					  Recebido->(DbSkip(1))
					  Loop
				  endif
			  endif
		  endif
			nConta++
			xTemp->(DbAppend())
			For nField := 1 To FCount()
				xTemp->( FieldPut( nField, Recebido->(FieldGet( nField ))))
			Next
			Recebido->(DbSkip(1))
		EndDo
		Set Soft Off
		if nConta = 0 // Nao Encontrou Nada.
			xTemp->(DbCloseArea())
			Ferase( xArquivo )
			Ferase( xNtx )
			Nada()
			Restela( cScreen )
			Loop
		endif
	EndCase
	WHILE OK
		oMenu:Limpa()
		M_Title("ESCOLHA A ORDEM A IMPRIMIR. ESC RETORNA")
		nOpcao := FazMenu( 05, 10, aOrdem )
		Mensagem(" Aguarde...")
		Area("xTemp")
		if nOpcao = 0 // Sair ?
			xTemp->(DbCloseArea())
			Ferase( xArquivo )
			Ferase( xNtx )
			ResTela( cScreen )
			Exit
		elseif nOpcao = 1
			 Inde On xTemp->Codi To ( xNtx )
		 elseif nOpcao = 2
			 Inde On xTemp->DataPag To ( xNtx )
		 elseif nOpcao = 3
			 Inde On xTemp->Docnr To ( xNtx )
		 elseif nOpcao = 4
			 Inde On xTemp->Emis To ( xNtx )
		 elseif nOpcao = 5
			 Inde On xTemp->Obs To ( xNtx )
		 elseif nOpcao = 6
			 Inde On xTemp->Port To ( xNtx )
		 elseif nOpcao = 7
			 Inde On xTemp->Tipo To ( xNtx )
		 elseif nOpcao = 8
			 Inde On xTemp->Vlr To ( xNtx )
		 elseif nOpcao = 9
			 Inde On xTemp->VlrPag To ( xNtx )
		 elseif nOpcao = 10
			 Inde On xTemp->Vcto To ( xNtx )
		endif
		oMenu:Limpa()
		if !InsTru80()
			ResTela( cScreen )
			Loop
		endif
		Mensagem("Aguarde, Processando Pesado.")
		Receber->( Order( RECEBER_CODI ))
		Set Rela To xTemp->Codi Into Receber
		xTemp->(DbGoTop())
		Prn001( dIni, dFim, Upper( AtPrompt[ nChoice ]) )
		xTemp->(DbClearRel())
		xTemp->(DbGoTop())
		ResTela( cScreen )
	EndDo
EndDo

Proc AgendaDbedit(nRecno)
************************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()
DEFAU nRecno TO Agenda->(LastRec())
Set Key -8 To

oMenu:Limpa()
Receber->(Order(RECEBER_CODI))
Area("Agenda")
Agenda->(Order(NATURAL))
Set Rela to Agenda->Codi Into Receber
Agenda->(DbGoTo(nRecno))

oBrowse:Add( "ID",        "Id")
oBrowse:Add( "CODI",      "Codi")
//oBrowse:Add( "NOME",      "Nome", NIL , "RECEBER")
oBrowse:Add( "DATA",      "Data")
oBrowse:Add( "HORARIO",   "Hora")
oBrowse:Add( "HISTORICO", "Hist")
oBrowse:Titulo   := "CONSULTA/ALTERACAO DE AGENDAMENTO"
SetKey( F2,         {|| FiltraAgenda(oBrowse) } )
oBrowse:HotKey( F4, {|| oBrowse:Duplica()})
oBrowse:PreDoGet := {|| PreDoAgenda( oBrowse )}
oBrowse:PosDoGet := {|| PosDoAgenda( oBrowse )}
oBrowse:PreDoDel := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Function PosDoAgenda( oBrowse )
*******************************
LOCAL oCol		 := oBrowse:getColumn( oBrowse:colPos )
LOCAL cRegiao	 := Space(02)
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()

Do Case
Case oCol:Heading = "REGIAO"
	cRegiao := Receber->Regiao
	RegiaoErrada( @cRegiao )
	Receber->Regiao := cRegiao
	AreaAnt( Arq_Ant, Ind_Ant )
OtherWise
EndCase
Agenda->Atualizado := Date()
return( OK )

Function PreDoAgenda( oBrowse )
****************************
LOCAL oCol		 := oBrowse:getColumn( oBrowse:colPos )
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()

if !PodeAlterar()
	return( FALSO)
endif

Do Case
Case oCol:Heading = "CLIENTE"
   ErrorBeep()
	Alerta("Opa! Alteracao n„o permitida. Altere o cadastro do cliente..")
	return( FALSO )

Case oCol:Heading = "CODIGO"
	ErrorBeep()
	Alerta("Opa! Nao pode alterar nao.")
	return( FALSO )
OtherWise
EndCase
return( PodeAlterar() )

*:---------------------------------------------------------------------------------------------------------------------------------

Function FiltraAgenda( oBrowse )
***********************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL cCodi

WHILE OK
	oMenu:Limpa()
	Receber->(Order( RECEBER_CODI ))
	MaBox( 14 , 19 , 16 , 35 )
	cCodi := Space(05)
	@ 15 , 20 SAY "Cliente.:" Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi )
	Read
	if LastKey() = ESC
		Exit
	endif
	Agenda->(Order( AGENDA_CODI ))
	Sx_SetScope( S_TOP, cCodi)
	Sx_SetScope( S_BOTTOM, cCodi )
	Agenda->(DbGoTop())
	if Sx_KeyCount() == 0
		Sx_ClrScope( S_TOP )
		Sx_ClrScope( S_BOTTOM )
		Nada()
		ResTela( cScreen )
		Loop
	endif
	Exit
EndDo
ResTela( cScreen )
oBrowse:FreshOrder()
return

Proc AnexarAgendaAntiga()
*************************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL nConta	:= 0
LOCAL dCalculo := Date()
LOCAL cString	:= ""
LOCAL cCodi
LOCAL nValorTotal
LOCAL nTotalGeral
LOCAL aTodos
LOCAL aCabec
LOCAL nJuros
LOCAL cTela
LOCAL oBloco
LOCAL cRegiao
LOCAL dIni
LOCAL dFim
LOCAL Col
FIELD Regiao
FIELD Vcto
FIELD Juro
FIELD Codi
FIELD Docnr
FIELD Emis
FIELD Vlr
LOCAL oAgenda

ErrorBeep()
if !Conf("Pergunta: Tem absoluta certeza?")
	return
endif
oMenu:Limpa()
cCodi 	:= Space(05)
dIni		:= Date()-30
dFim		:= Date()
dCalculo := Date()
aTodos	:= {}
aCodi 	:= {}
nConta	:= 0
cTela 	:= Mensagem("Aguarde. Anexando registros da agenda velha.")
Receber->(Order( RECEBER_CODI ))
Receber->(DbGoTop())

While Receber->(!Eof())
	cCodi   := Receber->Codi
	oAgenda := TIniNew("AGE" + cCodi + ".INI")
	dAtual  := cTod('//')
	nConta := oAgenda:ReadInteger( cCodi, 'soma', 0 )
	For nV = 1 To nConta
		cHist := oAgenda:ReadString( cCodi, StrZero(nV,2), Repl('_',40), 1)
		dData := oAgenda:ReadDate(   cCodi, StrZero(nV,2), cTod('//'), 2)
		if Agenda->(Incluiu())
			Agenda->Codi	 := cCodi
			Agenda->Data	 := dData
			Agenda->Hist	 := cHist
			Agenda->Ultimo  := FALSO
			Agenda->(Libera())
			Loop
		endif
	Next
	oAgenda:Close()
	Receber->(DbSkip(1))
EndDo
ResTela( cTela )

Proc AnexarLogRecibo()
**********************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL cFileLog := "recibo.log"
LOCAL xLog		:= "recibo.txt"
LOCAL xLixo 	:= "lixo.txt"
LOCAL nErro 	:= 0
LOCAL aRecibo	:= {}
LOCAL Handle
LOCAL nNew
LOCAL nLixo

ErrorBeep()
if !Conf("Pergunta: Tem absoluta certeza?")
	return
endif
oMenu:Limpa()
cTela := Mensagem("FASE #1: Aguarde. Anexando registros do log.")
if !File( cFileLog )
	oMenu:Limpa()
	ErrorBeep()
	Alert("Erro: Arquivos de Log nao disponiveis.;" + ;
				"Verifique os arquivos com extensao .LOG.")
	ResTela( cScreen )
	return
endif
Handle := Fopen( cFileLog )
if ( Ferror() != 0 )
	ErroConfiguracaoArquivo( Handle, "Abertura do Arquivo", cFileLog )
	ResTela( cScreen )
	return
endif

if !File( xLog )
	nNew := Fcreate( xLog, FC_NORMAL )
	FClose( nNew )
endif
nNew := FOpen( xLog, FO_READWRITE + FO_SHARED )
if ( Ferror() != 0 ) // Erro
	return
endif

if !File( xLixo )
	nLixo := Fcreate( xLixo, FC_NORMAL )
	FClose( nLixo )
endif
nLixo := FOpen( xLixo, FO_READWRITE + FO_SHARED )
if ( Ferror() != 0 ) // Erro
	return
endif

nCount := FLineCount(Handle)
nSoma  := 0
Alerta("Registros no Log: " + Str(nCount))
While !Feof( Handle )
	cLinha := FReadLine( Handle )
	if Left( cLinha, 6) = "BAIXAS" .OR. Left( cLinha, 6) = "RECIBO"
		FWriteLine( nNew, cLinha )
	else
		FWriteLine( nLixo, cLinha )
	endif
	Mensagem("Reg: " + Str(++nSoma))
EndDo
Close( Handle )
Close( nNew )
Close( nLixo )

// Fase 2

xLog := "RECIBO.TXT"
if !File( xLog )
	Handle := Fcreate( xLog, FC_NORMAL )
	FClose( Handle )
endif
Handle := FOpen( xLog, FO_READWRITE + FO_SHARED )
if ( Ferror() != 0 ) // Erro
	return
endif
cTela := Mensagem("FASE #2: Aguarde. Anexando registros no banco de dados.")
Receber->(Order( RECEBER_CODI ))
Recebido->(Order( RECEBIDO_DOCNR ))
Area("RECIBO")
nSoma := 0
While nSoma <= 2285 .AND. !FEof( Handle )
	cLinha	:= FReadLine( Handle )
	cTipo 	:= Left( cLinha,6)
	cCodi 	:= SubStr( cLinha,08,5)
	cDocnr	:= SubStr( cLinha,14,9)
	cHora 	:= SubStr( cLinha,24,8)
	dData 	:= cTod(SubStr( cLinha,33,8))
	cUsuario := SubStr( cLinha,42,10)
	cCaixa	:= SubStr( cLinha,53,04)
	nVlr		:= Val( SubStr(cLinha,58,18))
	cHist 	:= SubStr( cLinha,77,80)

	cNome 	:= Space(0)
	if Receber->(DbSeek( cCodi ))
		cNome := Receber->Nome
	endif

	dVcto 	:= cTod("//")
	if Recebido->(DbSeek( cDocnr ))
		dVcto := Recebido->Vcto
	elseif Recebido->(DbSeek( "Q"+ Right(cDocnr,8)))
		dVcto := Recebido->Vcto
	elseif Recebido->(DbSeek( "R"+ Right(cDocnr,8)))
		dVcto := Recebido->Vcto
	elseif Recebido->(DbSeek( "P"+ Right(cDocnr,8)))
		dVcto := Recebido->Vcto
	endif

	if Recibo->(Incluiu())
		Recibo->Nome	 := cNome
		Recibo->Vcto	 := dVcto

		Recibo->Tipo	 := cTipo
		Recibo->Codi	 := cCodi
		Recibo->Docnr	 := cDocnr
		Recibo->Hora	 := cHora
		Recibo->Data	 := dData
		Recibo->Usuario := cUsuario
		Recibo->Caixa	 := cCaixa
		Recibo->Vlr 	 := nVlr
		Recibo->Hist	 := cHist
		Recibo->(Libera())
	endif
	nSoma++
EndDo

// Fase 3

cTela := Mensagem("FASE #3: Aguarde. Anexando registros no banco de dados.")
While nSoma <= 9621 .AND. !FEof( Handle )
	cLinha	:= FReadLine( Handle )

	cTipo 	:= Left( cLinha,6)
	cCodi 	:= SubStr( cLinha,08,5)
	cNome 	:= SubStr( cLinha,14,40)
	cDocnr	:= SubStr( cLinha,55,9)
	cHora 	:= SubStr( cLinha,65,8)
	dData 	:= cTod(SubStr( cLinha,74,8))
	cUsuario := SubStr( cLinha,83,10)
	cCaixa	:= SubStr( cLinha,94,04)
	nVlr		:= Val( SubStr(cLinha,99,18))
	cHist 	:= SubStr( cLinha,118,80)

	dVcto 	:= cTod("//")
	if Recebido->(DbSeek( cDocnr ))
		dVcto := Recebido->Vcto
	elseif Recebido->(DbSeek( "Q"+ Right(cDocnr,8)))
		dVcto := Recebido->Vcto
	elseif Recebido->(DbSeek( "R"+ Right(cDocnr,8)))
		dVcto := Recebido->Vcto
	elseif Recebido->(DbSeek( "P"+ Right(cDocnr,8)))
		dVcto := Recebido->Vcto
	endif

	if Recibo->(Incluiu())
		Recibo->Vcto	 := dVcto
		Recibo->Nome	 := cNome
		Recibo->Tipo	 := cTipo
		Recibo->Codi	 := cCodi
		Recibo->Docnr	 := cDocnr
		Recibo->Hora	 := cHora
		Recibo->Data	 := dData
      Recibo->Usuario := cUsuario
		Recibo->Caixa	 := cCaixa
		Recibo->Vlr 	 := nVlr
		Recibo->Hist	 := cHist
		Recibo->(Libera())
	endif
	nSoma++
EndDo

// Fase 4

cTela := Mensagem("FASE #4: Aguarde. Anexando registros no banco de dados.")
While nSoma > 9621 .AND. !FEof( Handle )
	cLinha	:= FReadLine( Handle )
	cTipo 	:= Left( cLinha,6)
	cCodi 	:= SubStr( cLinha,08,5)
	cNome 	:= SubStr( cLinha,14,40)
	cDocnr	:= SubStr( cLinha,55,9)
	dVcto 	:= cTod(SubStr( cLinha,65,8))
	cHora 	:= SubStr( cLinha,74,8)
	dData 	:= cTod(SubStr( cLinha,83,8))
	cUsuario := SubStr( cLinha,92,10)
	cCaixa	:= SubStr( cLinha,103,04)
	nVlr		:= Val( SubStr(cLinha,108,18))
	cHist 	:= SubStr( cLinha,127,60)

	if Recibo->(Incluiu())
		Recibo->Vcto	 := dVcto
		Recibo->Nome	 := cNome
		Recibo->Tipo	 := cTipo
		Recibo->Codi	 := cCodi
		Recibo->Docnr	 := cDocnr
		Recibo->Hora	 := cHora
		Recibo->Data	 := dData
		Recibo->Usuario := cUsuario
		Recibo->Caixa	 := cCaixa
		Recibo->Vlr 	 := nVlr
		Recibo->Hist	 := cHist
		Recibo->(Libera())
	endif
	nSoma++
EndDo
Close( Handle )

Proc BidoToRecibo()
*******************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()

ErrorBeep()
if !Conf("Pergunta: Tem absoluta certeza?")
	return
endif
oMenu:Limpa()
cTela := Mensagem("FASE #1: Aguarde. Anexando registros do log.")

Vendedor->(Order( VENDEDOR_CODIVEN ))
Receber->(Order( RECEBER_CODI ))
Recibo->(Order( RECIBO_DOCNR ))
Recebido->(Order( RECEBIDO_DOCNR ))
Recebido->(DbGotop())
While Recebido->(!Eof())
   if Recibo->(DbSeek( Recebido->Docnr ))
      Recebido->(DbSkip(1))
      Loop
   endif
	if Recibo->(Incluiu())
      Receber->(DbSeek( Recebido->Codi ))
      Recibo->Nome    := Receber->Nome
      Recibo->Codi    := Recebido->Codi
      Recibo->Vcto    := Recebido->Vcto
      Recibo->Tipo    := "RECIBO"
      Recibo->Docnr   := Recebido->Docnr
      Recibo->Hora    := Time()
      Recibo->Data    := Recebido->DataPag
      if Vendedor->(DbSeek( Recebido->Caixa ))
         Recibo->Usuario := Left(Vendedor->Nome, 10)
      endif
      Recibo->Caixa   := Recebido->Caixa
      Recibo->Vlr     := Recebido->VlrPag
      Recibo->Hist    := Recebido->Obs
		Recibo->(Libera())
	endif
   Recebido->(DbSkip(1))
EndDo
return

Proc JuroComposto()
*******************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL nJuro 	:= 0
LOCAL nJuroDia := 0
LOCAL cCodi 	:= Space(05)
LOCAL dData 	:= Date()
LOCAL nAtraso	:= 0
LOCAL nAtraso1 := 0
LOCAL nJuros	:= 0
LOCAL nBase 	:= 31
LOCAL nTotJr	:= 0
LOCAL nX 		:= 0

Set Deci To 5
MaBox( 10, 05, 14, 78 )
@ 11, 06 Say "Cliente...............:" GET cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
@ 12, 06 Say "Taxa de Juros ao Mes..:" Get nJuro Pict "999.99"
@ 13, 06 Say "Calcular ate o dia....:" Get dData Pict "##/##/##"
Read
if LastKey() = ESC
   Set Deci To 2
	ResTela( cScreen )
	return
endif
if Conf("Pergunta: Confirma atualizacao da taxa de juro ?")
	Recemov->(Order( RECEMOV_CODI ))
	if Recemov->(DbSeek( cCodi ))
		Mensagem("Aguarde. Atualizando.")
		if Recemov->(TravaArq())
			WHILE Recemov->Codi = cCodi
            nTipo     := 6 // Tx Efetiva Juros Anual
            nAtraso   := dData - Recemov->Vcto
            nTxJuros  := TxEfetiva( nJuro, Recemov->Vcto, dData, nTipo )
            nCapital  := Recemov->Vlr
            nMontante := nCapital * nTxJuros
            nJuros    := nMontante - nCapital
            Recemov->Juro      := nTxJuros
            Recemov->JuroTotal := nJuros
            Recemov->JuroDia   := ( nJuros / nAtraso )
				Recemov->(DbSkip(1))
			EndDo
		endif
		Recemov->(Libera())
		ResTela( cScreen )
		ErrorBeep()
		Alerta("Informa: Taxas Atualizadas.")
	endif
endif
Set Deci To 2

Function TxEfetiva( nJuroMes, dVcto, dAtual, nTipo )
****************************************************
LOCAL nPeriodo
LOCAL nTxJuros
ifNil( nTipo,   1 )

nAtraso       := (dAtual - dVcto)
nPeriodo      := nAtraso / (if(lAnoBissexto(dAtual), 366, 365))
if nTipo = 1     //Anual
   nTxEfetiva := (((1 + nJuroMes/100)^12)-1)*100
   nTxJuros   := ((1 + nTxEfetiva/100)^nPeriodo)
elseif nTipo = 2 // Semestral
   nTxEfetiva := (((1 + nJuroMes/100)^6)-1)*100
elseif nTipo = 3 // Trimestral
   nTxEfetiva := (((1 + nJuroMes/100)^3)-1)*100
elseif nTipo = 4 // Bimestral
   nTxEfetiva := (((1 + nJuroMes/100)^2)-1)*100
elseif nTipo = 5 // Semanal
   nTxEfetiva := (((1 + nJuroMes/100)^(7/30))-1)*100
elseif nTipo = 6 // Diaria
   nTxEfetiva := (((1 + nJuroMes/100)^(1/30))-1)*100
   nTxJuros   := ((1 + nTxEfetiva/100)^nAtraso)
endif
return( nTxJuros )

/*
Qout("Tx Efetiva Anual  :", nTxAnoEfetiva )
Qout("Tx Efetiva Diaria :", nTxDiaEfetiva )
Qout("Dias              :", nDias )
Qout("Periodo de Dias   :", nPeriodo )
Qout("Capital           :", nValor)
Qout("Taxa de Juros     :", nTxJuros )
Qout("Juros             :", nJuros )
Qout("Montante          :", nValor * nTxJuros )
Qout("===========================================")
nTxJuros      := ((1 + nTxDiaEfetiva/100)^nAtraso)
Qout("Capital           :", nValor)
//Qout("Juros             :", nJuros )
Qout("Montante          :", nValor * nTxJuros )
*/


*:---------------------------------------------------------------------------------------------------------------------------------

/*
if Conf("Pergunta: Confirma atualizacao da taxa de juro ?")
	Recemov->(Order( RECEMOV_CODI ))
	if Recemov->(DbSeek( cCodi ))
		Mensagem("Aguarde. Atualizando.")
		if Recemov->(TravaArq())
			WHILE Recemov->Codi = cCodi
				nAtraso	:= dData - Recemov->Vcto
				nAtraso1 := dData - Recemov->Vcto
				nValor	:= Recemov->Vlr
				nJurodia := ((nValor * nJuro) / 100 ) / 30
				nJuros	:= 0
				nBase 	:= 31
				nTotJr	:= 0
				nX 		:= 0
				For nX := 1 To nAtraso
					if nX = nBase
						nAtraso	-= 30
						nX 		:= 0
						nValor	+= nJuros
						nJuros	:= 0
						nJurodia := ((nValor * nJuro ) / 100 ) / 30
						Loop
					endif
					nTotJr += nJuroDia
				Next
				Recemov->JuroDia := ( nTotJr / nAtraso1 )
				Recemov->Juro	  := nTotJr
				Recemov->(DbSkip(1))
			EndDo
		endif
		Recemov->(Libera())
		ResTela( cScreen )
		ErrorBeep()
		Alerta("Informa: Taxas Atualizadas.")
	endif
endif
*/

Proc MenuTxJuros( nChoice )
***************************
LOCAL GetList  := {}
LOCAL cScreen  := SaveScreen()
LOCAL aMenu1   := {'Geral','Individual'}
LOCAL aMenu2   := {'Juros Simples','Juros Composto','Juros Capitalizado','Juros Sobre Juro'}
LOCAL nChoice1 := 0
LOCAL nChoice2 := 0

WHILE OK
	oMenu:Limpa()
   if nChoice = NIL
      M_Title("ESCOLHA ALCANCE" )
      nChoice1 := FazMenu( 02, 05, aMenu1 )
      if nChoice1 = 0
         ResTela( cScreen )
         Exit
      else
         if nChoice1 = 1
            nChoice = 3.03
         elseif nChoice1 = 2
            nChoice = 3.04
         endif
      endif
   endif
   WHILE OK
      M_Title("ESCOLHA TIPO DE CALCULO" )
      nChoice2  := FazMenu( 04, 05, aMenu2 )
      if nChoice2 = 0
         Restela( cScreen)
         Exit
      endif
      Do Case
      Case nChoice2 = 0
         ResTela( cScreen )
         Exit

      Case nChoice = 3.03 .AND. nChoice2 = 1    // Simples Geral
         AltJrGeral(1, oAmbiente:aSciArray[1,SCI_JUROMESSIMPLES])

      Case nChoice = 3.03 .AND. nChoice2 >= 2   // Composto Geral
         AltJrGeral(2, oAmbiente:aSciArray[1,SCI_JUROMESCOMPOSTO])

      Case nChoice = 3.04 .AND. nChoice2 = 1    // Simples Individual
         AltJrInd(1, oAmbiente:aSciArray[1,SCI_JUROMESSIMPLES])

      Case nChoice = 3.04 .AND. nChoice2 >= 2   // Composto Individual
         AltJrInd(2, oAmbiente:aSciArray[1,SCI_JUROMESCOMPOSTO])
     EndCase
   EndDo
   if LastKey() = ESC
      Exit
   endif
EndDo

Function AltJrInd( nChoice, nJuro, xCodi, lMsg, oSender)
********************************************************
LOCAL GetList    := {}
LOCAL cScreen    := SaveScreen()
LOCAL nJuroDia   := 0
LOCAL nValorCm   := 0
LOCAL nVlr       := 0
LOCAL nCm        := 0
LOCAL nJuroTotal := 0
LOCAL dVcto      := Date()
LOCAL dData      := Date()
LOCAL cCodi      := Space(05)
LOCAL aJuro      := {}
LOCAL lResult
hb_default(@nJuro, oAmbiente:aSciArray[1,SCI_JUROMESCOMPOSTO])

if xCodi = NIL
   MaBox( 12, 05, 16, 78 )
   @ 13, 06 Say "Cliente...............:" GET cCodi PICT PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
   @ 14, 06 Say "Taxa de Juros ao Mes..:" Get nJuro Pict "999.99"
   @ 15, 06 Say "Atualizar ate Data....:" Get dData Pict "##/##/##"
   Read
   if LastKey() = ESC
      ResTela( cScreen )
      return
   endif
else
   cCodi := xCodi	
	if oSender != nil
		dData := oSender:dCalculo
	endif		
	if nJuro <= 0 .OR. nJuro == NIL
		nJuro := 1
	   MaBox( 13, 05, 15, 78 )
	   @ 14, 06 Say "Taxa de Juros ao Mes..:" Get nJuro Pict "999.99" Valid nJuro > 0
		Read
		if LastKey() = ESC
			ResTela( cScreen )		
			return( lResult := FALSO )
		endif
		oini:WriteInteger( 'financeiro', 'JuroMesComposto', nJuro )
	   oAmbiente:aSciArray[1,SCI_JUROMESCOMPOSTO] := nJuro
		lMsg    := OK
		lResult := OK
	endif
endif

if lMsg = NIL
   lResult := Conf("Pergunta: Confirma atualizacao da taxa de juro ?")
else
   lResult := OK
endif
if lResult
	Recemov->(Order( RECEMOV_CODI ))
	if Recemov->(DbSeek( cCodi ))
      if lMsg = NIL
         Mensagem("Aguarde. Atualizando.")
      endif
		if Recemov->(TravaArq())
         WHILE Recemov->Codi = cCodi .AND. LastKey() != ESC
            if lMsg = NIL
               Mensagem("Aguarde. Atualizando Taxas de Juros # " + Recemov->(Barra()))
            endif
            if nJuro <> 0
               dVcto              := Recemov->Vcto
               nVlr               := Recemov->Vlr
               nDias              := (dData-dVcto)
               nValorCm           := CalculaCm(nVlr, dVcto, dData)
               nCm                := (nValorCm - nVlr)
               if nChoice = 1
                  nJuroDia        := JuroDia( nValorCm, nJuro, XJURODIARIO)
                  nJuroTotal      := (nJuroDia * nDias)
                  nJuroTotal      += nCm
                  nJuroDia        := (nJuroTotal / nDias)
               else
                  aJuro           := aAntComposto( nValorCm, nJuro, nDias, XJURODIARIO)
                  nJuroDia        := aJuro[6]
                  nJuroTotal      := aJuro[5]
                  nJuroTotal      += nCm
                  nJuroDia        := (nJuroTotal / nDias)
               endif
               Recemov->Juro      := nJuro
               Recemov->JuroDia   := nJuroDia
               Recemov->JuroTotal := nJuroTotal
            else
               Recemov->Juro      := 0
               Recemov->JuroDia   := 0
               Recemov->JuroTotal := 0
            endif
            Recemov->(DbSkip(1))
            if LastKey() = ESC
               if Conf("Pergunta: Cancelar?")
                  Exit
               endif
            endif
         EndDo
		endif
		Recemov->(Libera())
		ResTela( cScreen )
      if lMsg = NIL
         ErrorBeep()
         Alerta("Informa: Taxas Atualizadas.")
      endif
	endif
endif
return lResult

function CalcCmJuros( nChoice, nJuro, nVlr, dVcto, dData)
*********************************************************
LOCAL nDias      := 0
LOCAL nValorCm   := 0
LOCAL nCm        := 0
LOCAL nJuroDia   := 0
LOCAL nJuroTotal := 0
LOCAL aJuro      := {}

__DefaultNIL(@nChoice, 1)
__DefaultNIL(@nJuro, oAmbiente:aSciArray[1,SCI_JUROMESCOMPOSTO])
__DefaultNIL(@nVlr, 0)
__DefaultNIL(@dVcto, Date())
__DefaultNIL(@dData, Date())

aJuro              := {}
nDias              := (dData-dVcto)
nValorCm           := CalculaCm(nVlr, dVcto, dData)
nCm                := (nValorCm - nVlr)
if nChoice = 1
   nJuroDia        := JuroDia( nValorCm, nJuro, XJURODIARIO)
   nJuroTotal      := (nJuroDia * nDias)
   nJuroTotal      += nCm
   nJuroDia        := (nJuroTotal / nDias)
else
   aJuro           := aAntComposto( nValorCm, nJuro, nDias, XJURODIARIO)
   nJuroDia        := aJuro[6]
   nJuroTotal      := aJuro[5]
   nJuroTotal      += nCm
   nJuroDia        := (nJuroTotal / nDias)
endif               
return({nJuro, nJurodia, nJuroTotal})
*:---------------------------------------------------------------------------------------------------------------------------------

Proc AltJrGeral(nChoice, nJuro)
*******************************
LOCAL GetList    := {}
LOCAL aJuro      := {}
LOCAL cScreen    := SaveScreen()
LOCAL nJuroDia   := 0
LOCAL nJuroTotal := 0
LOCAL nValorCm   := 0
LOCAL nCm        := 0
LOCAL nVcto      := 0
LOCAL dData      := Date()
LOCAL nDias      := 0

MaBox( 12, 05, 15, 54 )
@ 13, 06 Say "Entre com a Taxa de Juros...:" Get nJuro Pict "999.99"
@ 14, 06 Say "Atualizar ate Data..........:" Get dData Pict "##/##/##"
Read
if LastKey() = ESC
	ResTela( cScreen )
	return
endif
if Conf("Pergunta: Confirma atualizacao geral da taxa de juro ?")
   oMenu:Limpa()
   Mensagem("Aguarde. Atualizando.")
	if Recemov->(TravaArq())
      Recemov->(Order(0))
      Recemov->(DbGoTop())
      WHILE Recemov->(!Eof()) .AND. LastKey() != ESC
         Mensagem(" Aguarde. Atualizando Taxas de Juros # " + Recemov->(Barra()))
         if nJuro <> 0
            dVcto              := Recemov->Vcto
            nVlr               := Recemov->Vlr
            nDias              := (dData-dVcto)
            nValorCm           := CalculaCm(nVlr, dVcto, dData)
            nCm                := (nValorCm - nVlr)
            if nChoice = 1
               nJuroDia        := JuroDia( nValorCm, nJuro, XJURODIARIO)
               nJuroTotal      := (nJuroDia * nDias)
               nJuroTotal      += nCm
               nJuroDia        := (nJuroTotal / nDias)
            else
               aJuro           := aAntComposto( nValorCm, nJuro, nDias, XJURODIARIO)
               nJuroDia        := aJuro[6]
               nJuroTotal      := aJuro[5]
               nJuroTotal      += nCm
               nJuroDia        := (nJuroTotal / nDias)
            endif
            Recemov->Juro      := nJuro
            Recemov->JuroDia   := nJuroDia
            Recemov->JuroTotal := nJuroTotal
         else
            Recemov->Juro      := 0
            Recemov->JuroDia   := 0
            Recemov->JuroTotal := 0
         endif
			Recemov->(DbSkip(1))
         if LastKey() = ESC
            if Conf("Pergunta: Cancelar?")
               Exit
            endif
         endif
		EndDo
		Recemov->(Libera())
		ResTela( cScreen )
		ErrorBeep()
		Alerta("Informa: Taxas Atualizadas.")
	endif
endif

*:---------------------------------------------------------------------------------------------------------------------------------

def BidoGrafico(nOp)
********************
   LOCAL cScreen := SaveScreen()
   LOCAL aMenu   := {"Por Cliente", "Mensal Por Ano", "Ultimos 12 anos"}
   LOCAL cScreen1
   LOCAL nChoice

   while true
      M_Title("GRAFICO DE CONTAS RECEBIDAS" )
      nChoice  := FazMenu( 06, 10, aMenu )
      cScreen1 := SaveScreen()
      Do Case
      Case nChoice = 0
         ResTela( cScreen )
         Exit

      Case nChoice = 1
         cCodi := Space( 05 )
         WHILE OK
            Area("Receber")
            Receber->(Order( RECEBER_CODI ))
            MaBox( 13, 10, 15, 78 )
            @ 14, 11 Say "Cliente...: " Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
            Read
            if LastKey() = ESC
               ResTela( cScreen1 )
               Exit
            endif
            GrafBidoCodigo(cCodi, nOp)
            ResTela(cScreen1)
         BEGOUT

      Case nChoice = 2
         GrafBidoGeral(nOp)
         ResTela(cScreen1)
         
      Case nChoice = 3
         GrafBidoAnual(nOp)
         ResTela(cScreen1)	
      
      EndCase
   EndDo
endef   

*:---------------------------------------------------------------------------------------------------------------------------------

def GrafBidoCodigo(cCodi, nOp)
******************************
   LOCAL cScreen  := SaveScreen()
   LOCAL nBase    := 1
   LOCAL nAnual   := 0
   LOCAL lFiltrar := true
   LOCAL aDataIni := {}
   LOCAL aDataFim := {}
   LOCAL nConta   := 0
   LOCAL cValor   := ""
   LOCAL aMes[12,2]
   LOCAL aValor[12,2]
   PRIVA cAno     := Space(02)

   MaBox( 16, 10, 18, 45 )
   @ 17, 11 Say "Entre o ano para Grafico...:" Get cAno Pict "99" Valid if(Empty(cAno), ( ErrorBeep(), Alerta("Ooops!: Entre com o ano!", nil , 31), FALSO ), OK )
   Read
   if LastKey() = ESC
      return(Restela(cScreen))
   endif

   oMenu:Limpa()
   if     nOp = RECCAR
      oAmbiente:cTipoRecibo := "RECCAR"   
   elseif nOp = RECBCO
      oAmbiente:cTipoRecibo := "RECBCO"   
   elseif nOp = RECOUT
      oAmbiente:cTipoRecibo := "RECOUT"   
   elseif nOp = PAGDIA
      oAmbiente:cTipoRecibo := "PAGDIA"   	
   elseif nOp = PAGDIV
      oAmbiente:cTipoRecibo := "PAGDIV"   			
   else
      oAmbiente:cTipoRecibo := "RECALL"
      lFiltrar := false
   endif
   aDataIni := aMesIniMesFim(cAno)[1]
   aDataFim := aMesIniMesFim(cAno)[2]

   Area("Recebido")
   Recebido->(Order( RECEBIDO_CODI ))
   Recebido->(Sx_SetScope( S_TOP, cCodi))
   Recebido->(Sx_SetScope( S_BOTTOM, cCodi ))
   Recebido->(DbGoTop())
   Mensagem("Aguarde, calculando valores.")

   oMenu:ResetReg()
   for nX := 1 To 12
      oMenu:ContaReg()
      aValor[nX,1] := 0
      aMes[nX,1]   := 0      
      Recebido->(DbGoTop())
      while Recebido->(!Eof()) .AND. oMenu:ContaReg()
         if Recebido->DataPag >= aDataIni[nX] .and. Recebido->DataPag <= aDataFim[nX]
            aValor[nX,1] += Recebido->VlrPag             
         endif   
         Recebido->(DbSkip(1))
      enddo   
      aMes[nX,1] += aValor[nX,1]
      nAnual     += aValor[nX,1]
   next
   Recebido->(Sx_ClrScope( S_TOP ))
   Recebido->(Sx_ClrScope( S_BOTTOM ))
   Recebido->(DbGoTop())

   Area("Recibo")
   Recibo->(Order( RECIBO_CODI ))
   Recibo->(Sx_SetScope( S_TOP, cCodi))
   Recibo->(Sx_SetScope( S_BOTTOM, cCodi ))
   Recibo->(DbGotop())
   oMenu:ResetReg()
   for nX := 1 To 12	
      aValor[nX,1] := 0
      Recibo->(DbGotop())
      while Recibo->(!Eof()) .AND. oMenu:ContaReg()
         if lFiltrar
            if Recibo->Data >= aDataIni[nX] .and. Recibo->Data <= aDataFim[nX] .and. Recibo->Tipo = oAmbiente:cTipoRecibo
               aValor[nX,1] += Recibo->Vlr      
            endif   
         else
            if Recibo->Data >= aDataIni[nX] .and. Recibo->Data <= aDataFim[nX]
               aValor[nX,1] += Recibo->Vlr      
            endif   
         endif            
         Recibo->(DbSkip(1))
      enddo      
      aMes[nX,1] += aValor[nX,1]
      nAnual     += aValor[nX,1]
   next
   Recibo->(Sx_ClrScope( S_TOP ))
   Recibo->(Sx_ClrScope( S_BOTTOM ))
   Recibo->(DbGoTop())

   aMes   := aMesIniMesFim(cAno, aValor)[3]
   cNome  := Receber->( AllTrim( Nome ) )
   cValor := "R$" + AllTrim(Tran( nAnual, "@E 9,999,999,999.99"))

   SetColor("")
   Cls
   Grafico( aMes, true, "EVOLUCAO MENSAL DE TITULOS RECEBIDOS - &cNome.", cValor, AllTrim(oAmbiente:xNomefir), nBase )
   Inkey(0)
   oAmbiente:cTipoRecibo := NIL
   return(ResTela( cScreen))
endef

*:---------------------------------------------------------------------------------------------------------------------------------

def GrafBidoGeral(nOp)
**********************
   LOCAL cScreen  := SaveScreen()
   LOCAL nBase    := 1
   LOCAL nAnual   := 0
   LOCAL lFiltrar := true
   LOCAL nX       := 0
   LOCAL aMes[12,2] 
   LOCAL aValor[12,2]
   LOCAL aDataIni
   LOCAL aDataFim
   LOCAL dIni
   LOCAL dFim
   LOCAL nConta
   LOCAL cValor   
   LOCAL cAno	  := Space(02)

   MaBox( 13, 10, 15, 45 )
   @ 14, 11 Say "Entre o ano para Grafico...:" Get cAno Pict "99" Valid if(Empty(cAno), ( ErrorBeep(), Alerta("Ooops!: Entre com o ano!", nil , 31), FALSO ), OK )
   Read
   if LastKey() = ESC
      return(Restela( cScreen))
   endif

   if     nOp = RECCAR
      oAmbiente:cTipoRecibo := "RECCAR"
   elseif nOp = RECBCO
      oAmbiente:cTipoRecibo := "RECBCO"   
   elseif nOp = RECOUT
      oAmbiente:cTipoRecibo := "RECOUT"   
   elseif nOp = PAGDIA
      oAmbiente:cTipoRecibo := "PAGDIA"   	
   elseif nOp = PAGDIV
      oAmbiente:cTipoRecibo := "PAGDIV"   		
   else
      oAmbiente:cTipoRecibo := "RECALL"   		
      lFiltrar := false
   endif
   aDataIni := aMesIniMesFim(cAno)[1]
   aDataFim := aMesIniMesFim(cAno)[2]

   Area("Recibo")
   Recibo->(Order( RECIBO_DATA ))   
   oMenu:ResetReg()
   for nX := 1 To 12   
      aMes[nX,1]   := 0
      aValor[nX,1] := 0      
      dIni	       := aDataIni[nX]
      dFim	       := aDataFim[nX]      
      Recibo->(Sx_SetScope( S_TOP,    dIni))
      Recibo->(Sx_SetScope( S_BOTTOM, dFim ))
      Recibo->(DbGotop())
      while Recibo->(!Eof()) .AND. oMenu:ContaReg()         
         if lFiltrar
            if Recibo->Data >= aDataIni[nX] .and. Recibo->Data <= aDataFim[nX] .and. Recibo->Tipo = oAmbiente:cTipoRecibo 
               aValor[nX,1] += Recibo->Vlr      
            endif   
         else
            if Recibo->Data >= aDataIni[nX] .and. Recibo->Data <= aDataFim[nX]
               aValor[nX,1] += Recibo->Vlr      
            endif   
         endif
         Recibo->(DbSkip(1))
      enddo      
      aMes[nX,1] += aValor[nX,1]
      nAnual     += aValor[nX,1]
   next    
   Recibo->(Sx_ClrScope( S_TOP ))
   Recibo->(Sx_ClrScope( S_BOTTOM ))
   Recibo->(DbGoTop())
   aMes   := aMesIniMesFim(cAno, aValor)[3]
   cValor := "R$" + StrTrim(Tran( nAnual, "@E 9,999,999,999.99"))
   SetColor("")
   Cls   
   Grafico( aMes, true, "GRAFICO MENSAL - TIPO:" +  oAmbiente:cTipoRecibo + " - ANO:" + TrimStr(cAno), TrimStr(cValor), AllTrim(oAmbiente:xNomefir), nBase )
   Inkey(0)
   oAmbiente:cTipoRecibo := NIL
   return(ResTela(cScreen))
endef   

*:---------------------------------------------------------------------------------------------------------------------------------

def GrafBidoAnual(nOp)
**********************
   LOCAL cScreen  := SaveScreen()
   LOCAL nBase    := 1
   LOCAL nAnual   := 0
   LOCAL lFiltrar := OK
   LOCAL aMes     := Array(12,2)
   LOCAL aValor   := Array(12, 2)
   LOCAL aDataIni := {}
   LOCAL aDataFim := {}
   LOCAL dIni     := Date()
   LOCAL dFim     := Date()
   LOCAL nConta   := 0
   LOCAL cValor   := ""
   PRIVA cAno	   := Tran(Year(Date()), "9999")
   PRIVA cUltimo

   hb_default(@nOp, 1)
   MaBox( 13, 10, 15, 58 )
   @ 14, 11 Say "Entre com o ultimo ano para o Grafico...:" Get cAno Pict "9999" Valid if(Empty(cAno), ( ErrorBeep(), Alerta("Ooops!: Entre com o ano!", nil , 31), FALSO ), OK )
   Read
   if LastKey() = ESC
      return(Restela(cScreen))
   endif

   lFiltrar := true
   if     nOp = RECCAR
      oAmbiente:cTipoRecibo := "RECCAR"
   elseif nOp = RECBCO
      oAmbiente:cTipoRecibo := "RECBCO"
   elseif nOp = RECOUT
      oAmbiente:cTipoRecibo := "RECOUT"
   elseif nOp = PAGDIA
      oAmbiente:cTipoRecibo := "PAGDIA"   	
   elseif nOp = PAGDIV
      oAmbiente:cTipoRecibo := "PAGDIV"   			
   else
      oAmbiente:cTipoRecibo := "RECALL"
      lFiltrar := false
   endif
   aDataIni := aAnoIniAnoFim(cAno)[1]
   aDataFim := aAnoIniAnoFim(cAno)[2]

   Area("Recibo")
   Recibo->(Order( RECIBO_DATA ))
   Recibo->(Sx_ClrScope( S_TOP ))
   Recibo->(Sx_ClrScope( S_BOTTOM ))
   Recibo->(DbGoTop())
   oAmbiente:nRegistrosImpressos := 0
   Mensagem("Aguarde, Processando Registros...")
   oMenu:ResetReg()
   For nX := 1 To 12 
      oMenu:ContaReg()
      aMes[nX,1]   := 0
      aValor[nX,1] := 0
      dIni	       := aDataIni[nX]
      dFim	       := aDataFim[nX]      
      Recibo->(Sx_SetScope( S_TOP,    dIni))
      Recibo->(Sx_SetScope( S_BOTTOM, dFim ))
      Recibo->(DbGotop())
      if lFiltrar
         if nOp = RECCAR
            //Sum Recibo->Vlr To aValor[nX,1] For Recibo->Tipo = oAmbiente:cTipoRecibo .OR. Recibo->Tipo = "RECIBO" .AND. oMenu:ContaReg()
            while Recibo->(!Eof()) .AND. oMenu:ContaReg()
               if Recibo->Tipo == oAmbiente:cTipoRecibo .or. Recibo->Tipo = "RECIBO"
                  aValor[nX,1] += Recibo->Vlr 
               endif   
               Recibo->(DbSkip(1))
            enddo
         else
            //Sum Recibo->Vlr To aValor[nX,1] For Recibo->Tipo = oAmbiente:cTipoRecibo .AND. oMenu:ContaReg()
            while Recibo->(!Eof()) .AND. oMenu:ContaReg()
               if Recibo->Tipo == oAmbiente:cTipoRecibo
                  aValor[nX,1] += Recibo->Vlr 
               endif   
               Recibo->(DbSkip(1))
            enddo         
         endif
      else
         //Sum Recibo->Vlr To aValor[nX,1] For Recibo->Tipo <> "BAIXAS" .AND. oMenu:ContaReg()
         while Recibo->(!Eof()) .AND. oMenu:ContaReg()
            if Recibo->Tipo <> "BAIXAS"
               aValor[nX,1] += Recibo->Vlr 
            endif   
            Recibo->(DbSkip(1))
         enddo
      endif
      aMes[nX,1] += aValor[nX,1]
      nAnual     += aValor[nX,1]
      Recibo->(Sx_ClrScope( S_TOP ))
      Recibo->(Sx_ClrScope( S_BOTTOM ))
   Next    
   Recibo->(Sx_ClrScope( S_TOP ))
   Recibo->(Sx_ClrScope( S_BOTTOM ))
   Recibo->(DbGoTop())

   aMes    := aAnoIniAnoFim(cAno, aValor)[3]
   nAno    := val( cAno )
   cUltimo := aMes[1,2]
   cValor  := "$" + AllTrim(Tran( nAnual, "@E 9,999,999,999.99"))
   alert(cValor)

   SetColor("")
   Cls
   Grafico( aMes, true,"EVOLUCAO MENSAL DE TITULOS RECEBIDO - &cUltimo. AT &cAno.", cValor, AllTrim(oAmbiente:xNomefir), nBase )
   Inkey(0)
   oAmbiente:cTipoRecibo := NIL
   return(ResTela(cScreen))
endef   

*:---------------------------------------------------------------------------------------------------------------------------------

function aMesIniMesFim(cAno, aValor)
************************************
LOCAL aDataIni   := {}
LOCAL aDataFim   := {}
LOCAL aMes       := {}
LOCAL dIni       := Date()
LOCAL lString    := true
LOCAL lUpper     := true
LOCAL lAbreviado := false
LOCAL x

hb_default(@cAno, Str(Year(Date())))
oMenu:ResetReg()
for x := 1 to 12
	oMenu:ContaReg()
	aadd( aDataIni, StringToData( FirstDayOfMonth(dIni, x, lString := true) + "/" + strzero(x,2) + "/" + cAno ))
	aadd( aDataFim, StringToData( LastDayOfMonth(dIni,  x, lString := true) + "/" + strzero(x,2) + "/" + cAno ))
	if aValor != nil
		aadd( aMes, { aValor[x,1], NomeMesesDoAno(dIni, nMes := x, lAbreviado, lUpper)})
	endif	
next
return{ aDataIni, aDataFim, aMes}

*:---------------------------------------------------------------------------------------------------------------------------------

def RecemovDbeditEmTabela(cFiltro)
*--------------------------------*
   LOCAL Arq_Ant	:= Alias()
   LOCAL Ind_Ant	:= IndexOrd()
   LOCAL cScreen	:= SaveScreen()
   LOCAL oBrowse	:= MsBrowse():New()
   LOCAL cDocnr   
   Set Key -8 To
   Set Key F5 To

   oMenu:Limpa()
   Receber->(Order( RECEBER_CODI ))
   Area("Recemov")
   Set Rela To Recemov->Codi Into Receber

   if cFiltro = nil
      Recemov->(Order( NATURAL ))
      Sx_ClrScope( S_TOP )
      Sx_ClrScope( S_BOTTOM )
      Recemov->(DbGoBottom())
   else
      Recemov->(Order(RECEMOV_FATURA))
      Sx_ClrScope( S_TOP, cFiltro )
      Sx_ClrScope( S_BOTTOM, cFiltro )
      Recemov->(DbGoTop())
   endif	
   oBrowse:Add( "ID",         "Id")
   oBrowse:Add( "TIPO",       "Tipo")
   oBrowse:Add( "CODI",       "Codi")
   oBrowse:Add( "CLIENTE",    "Nome", NIL, "RECEBER")
   oBrowse:Add( "FATURA",     "Fatura")
   oBrowse:Add( "DOCNR",      "Docnr")
   oBrowse:Add( "EMIS",       "Emis")
   oBrowse:Add( "VCTO",       "Vcto")   
   oBrowse:Add( "VALOR",      "Vlr")
   oBrowse:Add( "DATAPAG",    "DataPag")   
   oBrowse:Add( "VLR PAGO",   "VlrPag")   
   oBrowse:Add( "CAIXA",      "Caixa")   
   oBrowse:Add( "OBSERVACAO", "Obs")   
   oBrowse:Titulo   := "CONSULTA/ALTERACAO DE CONTAS A RECEBER"
   
   oBrowse:HotKey( F3, {|| FiltraRecibo( oBrowse )})
   oBrowse:HotKey( F4, {|| oBrowse:Duplica()})
   oBrowse:HotKey( F5, {|| FiltraSoma( oBrowse )})
   oBrowse:HotKey( F7, {|| SomaRecemov( oBrowse )})   
   oBrowse:PreDoGet := {|| PreDoRecibo( oBrowse )}
   oBrowse:PosDoGet := nil
   oBrowse:PreDoDel := {|| PreDoDelRecibo( oBrowse, @cDocnr )}
   oBrowse:PosDoDel := {|| PosDoDelRecibo( oBrowse, @cDocnr )}

   oBrowse:Show()
   oBrowse:Processa()
   Sx_ClrScope( S_TOP )
   Sx_ClrScope( S_BOTTOM )
   Recemov->(DbClearRel())
   AreaAnt( Arq_Ant, Ind_Ant )
   ResTela( cScreen )
endef   

*:---------------------------------------------------------------------------------------------------------------------------------

Function SomaRecemov( oBrowse )
******************************
LOCAL cScreen	:= SaveScreen()
LOCAL nConta   := 0

if conf("Informa: Ira somar do registro corrente ate final arquivo. continuar?")
	Mensagem("Aguarde, somando registros. ESC cancelar")
	While !Eof() .AND. !Tecla_ESC()
		nConta += Recemov->Vlr
		Recemov->(DbSkip(1))
	EndDo
	ResTela( cScreen )
	Alerta("Valor Recebido: R$ " + Alltrim(Tran( nConta, "@E 999,999,999,999.99")))
	oBrowse:FreshOrder()
	return( OK )
endif	

*:---------------------------------------------------------------------------------------------------------------------------------

function aAnoIniAnoFim(cAno, aValor)
************************************
LOCAL aDataIni := {}
LOCAL aDataFim := {}
LOCAL aMes     := {}
LOCAL nAno     
LOCAL x

hb_default(@cAno, Str(Year(Date())))
nAno     := val( cAno) - 12
oMenu:ResetReg()
for x := 1 to 12
	oMenu:ContaReg()
	aadd( aDataIni, Ctod( "01/01/" + Tran( nAno+x, "9999")))
	aadd( aDataFim, Ctod( "31/12/" + Tran( nAno+x, "9999")))
	if aValor != nil
		aadd( aMes, { aValor[x,1], Tran( nAno+x, "9999")})
	endif	
next
return {aDataIni, aDataFim, aMes}

Function ReciboDbedit(cFiltro)
*----------------------------------------------*
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()
LOCAL cDocnr   
Set Key -8 To
Set Key F5 To

oMenu:Limpa()
Receber->(Order( RECEBER_CODI ))
Area("Recibo")
Set Rela To Recibo->Codi Into Receber

if cFiltro = nil
	Recibo->(Order( NATURAL ))
	Sx_ClrScope( S_TOP )
	Sx_ClrScope( S_BOTTOM )
	Recibo->(DbGoBottom())
else
	Recibo->(Order(RECIBO_FATURA))
	Sx_ClrScope( S_TOP, cFiltro )
	Sx_ClrScope( S_BOTTOM, cFiltro )
	Recibo->(DbGoTop())
endif	
oBrowse:Add( "ID",         "Id")
oBrowse:Add( "TIPO",       "Tipo")
oBrowse:Add( "CODI",       "Codi")
oBrowse:Add( "CLIENTE",    "Nome", NIL, "RECEBER")
oBrowse:Add( "DOCNR",      "Docnr")
oBrowse:Add( "VCTO",       "Vcto")
oBrowse:Add( "HORA",       "Hora")
oBrowse:Add( "DATA PGTO",  "Data")
oBrowse:Add( "VLR RECIBO", "Vlr")
oBrowse:Add( "CAIXA",      "Caixa")
oBrowse:Add( "USUARIO",    "Usuario")
oBrowse:Add( "HISTORICO",  "Hist")
oBrowse:Titulo   := "CONSULTA/ALTERACAO DE RECIBOS EMITIDOS"
oBrowse:HotKey( F3, {|| FiltraRecibo( oBrowse )})
oBrowse:HotKey( F4, {|| oBrowse:Duplica()})
oBrowse:HotKey( F7, {|| SomaRecibo( oBrowse )})
oBrowse:HotKey( K_CTRL_Q, {|| ZapTudoRecibo( oBrowse )})
oBrowse:PreDoGet := {|| PreDoRecibo( oBrowse )}
oBrowse:PosDoGet := {|| PosDoRecibo( oBrowse )}
oBrowse:PreDoDel := {|| PreDoDelRecibo( oBrowse, @cDocnr )}
oBrowse:PosDoDel := {|| PosDoDelRecibo( oBrowse, @cDocnr )}
oBrowse:LinhaHelpTecla1 := "[F5] Filtrar e Somar"
oBrowse:LinhaHelpTecla2 := "[F7] Somar Recibo"
oBrowse:Show()
oBrowse:Processa()
Sx_ClrScope( S_TOP )
Sx_ClrScope( S_BOTTOM )
Recibo->(DbClearRel())
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

*:---------------------------------------------------------------------------------------------------------------------------------

def PreDoRecibo( oBrowse )
*-----------------------------*
	LOCAL oCol			  := oBrowse:getColumn( oBrowse:colPos )
	LOCAL Arq_Ant		  := Alias()
	LOCAL Ind_Ant		  := IndexOrd()
	LOCAL lUsuarioAdmin := oSci:ReadBool('permissao','usuarioadmin', FALSO )

	if !PodeAlterar()
		return( FALSO)
	endif

	do case 
	case oCol:Heading == "CLIENTE"
		ErrorBeep()
		MsgOk( oCol:Heading + ";;Opa! Alteracao n„o permitida!;Altere o cadastro do cliente.")		
		return( FALSO )
	case oCol:Heading == "DATA"
		if !lUsuarioAdmin
			ErrorBeep()
			Alerta(oCol:Heading + ";;Opa! Nao pode alterar nao.")
			return( FALSO )
		endif
	endcase
	return(PodeAlterar())

function PreDoDelRecibo( oBrowse, cDocnr )
******************************************
LOCAL oCol			  := oBrowse:getColumn( oBrowse:colPos )
LOCAL Arq_Ant		  := Alias()
LOCAL Ind_Ant		  := IndexOrd()
LOCAL lUsuarioAdmin := oSci:ReadBool('permissao','usuarioadmin', FALSO )

cDocnr := (Alias())->Docnr
return( OK )

function PosDoDelRecibo( oBrowse, cDocnr )
******************************************
LOCAL oCol			  := oBrowse:getColumn( oBrowse:colPos )
LOCAL Arq_Ant		  := Alias()
LOCAL Ind_Ant		  := IndexOrd()
LOCAL lUsuarioAdmin := oSci:ReadBool('permissao','usuarioadmin', FALSO )

Recemov->(Order(RECEMOV_DOCNR))
if Recemov->(DbSeek( cDocnr))
   if Recemov->(TravaReg())
	   Recemov->DataPag := Ctod("//")
		Recemov->VlrPag  := 0
		Recemov->StPag   := FALSO	
		Recemov->(Libera())
		return true
	endif
endif	
return false

*:---------------------------------------------------------------------------------------------------------------------------------

Function SomaRecibo( oBrowse )
******************************
LOCAL cScreen	:= SaveScreen()
LOCAL nConta   := 0

if conf("Informa: Ira somar do registro corrente ate final arquivo. continuar?")
	Mensagem("Aguarde, somando registros. ESC cancelar")
	While !Eof() .AND. !Tecla_ESC()
		nConta += Recibo->Vlr
		Recibo->(DbSkip(1))
	EndDo
	ResTela( cScreen )
	Alerta("Valor Recebido: R$ " + Alltrim(Tran( nConta, "@E 999,999,999,999.99")))
	oBrowse:FreshOrder()
	return( OK )
endif	

*:---------------------------------------------------------------------------------------------------------------------------------

Function ZapTudoRecibo( oBrowse )
*********************************
LOCAL lUsuarioAdmin := oSci:ReadBool('permissao','usuarioadmin', FALSO )
LOCAL cScreen	     := SaveScreen()
LOCAL nConta        := 0

	if !lUsuarioAdmin
		if !PedePermissao(SCI_EXCLUSAO_DE_REGISTROS)
			ResTela( cScreen )
			oBrowse:FreshOrder()
			return
		endif
	endif
	
	ErrorBeep()
	if conf("Informa: Ira zerar o banco de dados de recibos emitidos.; Esta operacao nao tem volta. continuar?")
		Mensagem("Aguarde, zerando registros. ESC cancelar")
		Recibo->(DbCloseArea())
		if Netuse("RECIBO", MONO)
			if Recibo->(TravaArq())
				Recibo->(__DbZap())
				Recibo->(Libera())				
			endif	
			Recibo->(DbCloseArea())
			if AbreArquivo('RECIBO')
				oIndice:ProgressoNtx := OK
				CriaIndice('RECIBO')
				oIndice:ProgressoNtx := FALSO
			EndIF
		endif	
		if Netuse("RECIBO")
			DbSetIndex("recibo")
		endif	
		oBrowse:FreshOrder()
		return
	endif	
	ResTela( cScreen )
	oBrowse:FreshOrder()
	return

Function FiltraSoma( oBrowse )
******************************
LOCAL GetList  := {}
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL nRecno   := Recno()
LOCAL dIni     := Field->Data
LOCAL dFim     := Field->Data
LOCAL nConta

WHILE OK
	oMenu:Limpa()
	MaBox( 14 , 19 , 17 , 43 )	
	nConta := 0
	@ 15, 20 SAY "Data Inicial.:" Get dIni Pict "##/##/##"
	@ 16, 20 SAY "Data Fim.....:" Get dFim Pict "##/##/##"
	Read
	if LastKey() = ESC				
		ResTela( cScreen )
		Recibo->(Sx_ClrScope( S_TOP))
		Recibo->(Sx_ClrScope( S_BOTTOM))
		oBrowse:FreshOrder()		
		AreaAnt( Arq_Ant, Ind_Ant)
		DbGoto(nRecno)
		Exit
	endif
	Recibo->(Order( RECIBO_DATA ))
	Recibo->(Sx_SetScope( S_TOP, dIni))
	Recibo->(Sx_SetScope( S_BOTTOM, dFim))
	Recibo->(DbGoTop())
	if Sx_KeyCount() == 0
		ResTela( cScreen )
		Recibo->(Sx_ClrScope( S_TOP))
		Recibo->(Sx_ClrScope( S_BOTTOM))				
		Recibo->(DbGoto(nRecno))		
		oBrowse:FreshOrder()
		Nada()		
		Loop
	endif
   Mensagem("Aguarde, somando registros. ESC cancelar")
   While !Eof() .AND. !Tecla_ESC()
      nConta += Recibo->Vlr
      Recibo->(DbSkip(1))
   EndDo					
	Alerta("Valor Recebido: R$ " + Alltrim(Tran( nConta, "@E 999,999,999,999.99")))
	ResTela( cScreen )
	DbGoTop()
	oBrowse:FreshOrder()
	return
EndDo
return nil

*:---------------------------------------------------------------------------------------------------------------------------------

Function PosDoRecibo( oBrowse )
*******************************
LOCAL oCol		 := oBrowse:getColumn( oBrowse:colPos )
LOCAL cRegiao	 := Space(02)
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL cDocnr    := Recibo->Docnr

Do Case
Case oCol:Heading == "REGIAO"
	cRegiao := Receber->Regiao
	RegiaoErrada( @cRegiao )
	Receber->Regiao := cRegiao
	AreaAnt( Arq_Ant, Ind_Ant )
EndCase
Recemov->(Order(RECEMOV_DOCNR))
if Recemov->(DbSeek( cDocnr ))
   if Recemov->(TravaReg())
	   Recemov->DataPag := Recibo->Data
		Recemov->VlrPag  := Recibo->Vlr
		Recemov->StPag   := OK
		Recemov->(Libera())		
	endif
endif	
(Alias())->Atualizado := Date()
AreaAnt( Arq_Ant, Ind_Ant )
return( OK )

*:---------------------------------------------------------------------------------------------------------------------------------

Function FiltraRecibo( oBrowse )
********************************
	LOCAL GetList := {}
   LOCAL cScreen := SaveScreen()
   LOCAL cProcura

   if Empty( IndexKey())
      ErrorBeep()
      Alert("Erro: Escolha um indice antes.")
      return(OK)
   endif
   MaBox( 10, 10, 12, 70,,, Roloc(Cor()))
   cProcura := FieldGet(FieldPos( IndexKey()))
   if cProcura = NIL
      cProcura := Space(40)
   endif
   @ 11, 11 Say "Filtrar por : " Get cProcura Pict "@K!"
   Read
   if LastKey() = ESC
      ResTela( cScreen )
      return(OK)
   endif
   if ValType( cProcura ) = "C"
      cProcura := AllTrim( cProcura )
   endif
   Sx_SetScope( S_TOP, cProcura)
   Sx_SetScope( S_BOTTOM, cProcura )
	Recibo->(DbGoTop())
   ResTela( cScreen )
   oBrowse:FreshOrder()
return(OK)

*:==================================================================================================================================

def ExtratoImp( oBloco, lTribunal, dIni, dFim, dCalculo )
*---------------------------------------------------------*
LOCAL cScreen		 := SaveScreen()
LOCAL Tam			 := 132
LOCAL Col			 := 58
LOCAL Pagina		 := 0
LOCAL NovoCodi 	 := OK
LOCAL UltCodi		 := Field->Codi
LOCAL o            := TExtratoImp():New()
DEFAU dCalculo TO Date()

if !Instru80()
	return(ResTela(cScreen))
endif

Recibo->(Order(RECIBO_DOCNR))
Mensagem("Aguarde, Imprimindo.")
PrintOn()
FPrint( PQ )
FPrint( NG )
SetPrc( 0, 0 )
While Eval( oBloco ) .AND. !Eof() .AND. Rel_Ok() 
	if Recemov->Vcto >= dIni .AND. Recemov->Vcto <= dFim
		if Col >=  58
			Col := 0
			Write( Col , 00, Padr( "Pagina N?" + StrZero( ++Pagina,3 ), (Tam / 2)) + Padl( Dtoc(Date()) + ' - ' + Time(), (Tam / 2 )))
			if lTribunal
				Write( ++Col, 00, Repl( SEP, Tam ) )
			else
				Write( ++Col, 00, Padc( AllTrim(oAmbiente:xNomefir), Tam ) )
				Write( ++Col, 00, Padc( SISTEM_NA3, Tam ) )
			endif
			if lTribunal
				Write( ++Col, 00, Padc( "RELATORIO DE CONTA JUDICIAL E CALCULO DA CORRECAO - TABELA TJ/RO", Tam ) )
			else	
				Write( ++Col, 00, Padc( "EXTRATO DE CONTA", Tam ) )
			endif	
			Write( ++Col, 00, Repl( SEP, Tam ) )
			Write( ++Col, 00, "CLIENTE....: " + Codi + " " + Receber->Nome )
			Write( ++Col, 00, "ENDERECO...: " + Receber->Ende + " " + Receber->Bair )
			Write( ++Col, 00, "CIDADE.....: " + Receber->Cep + "/"+ Receber->Cida + " " + "ESTADO..: " + Receber->Esta + Space( 07 ) + "REGIAO..: " + Receber->Regiao )
			Write( ++Col, 00, Repl( SEP, Tam ))		
			if lTribunal
				Write( ++Col, 00, "                              DATA     VALOR    DATA    INICIO        VALOR  DIAS                CORRIGIDO       VALOR         TOTAL")
				Write( ++Col, 00, "TITULO #  TIPO   EMISSAO   INICIAL   INICIAL    FINAL    JUROS    CORRIGIDO JUROS       JUROS      + JUROS    MULTA(2.0%)     +MULTA")
			else
				Write( ++Col, 00,"TITULO #  TIPO   EMISSAO  VENCTO   DESCRICAO                                 PRINCIPAL ATRA DATA_PAG      VLR_PAGO VLR_ATUALIZADO")
			endif
			Write( ++Col, 00, Repl( SEP, Tam ))
		endif
		if NovoCodi
		   NovoCodi := FALSO
			o:Zerar()
		endif	
		o:nVlr     := Recemov->Vlr
		o:dVcto    := Recemov->Vcto
		o:nJurodia := Recemov->Jurodia
		o:dCalculo := dCalculo
		o:CalculaPorraToda()		//o:nVlr, o:dCalculo, o:dVcto, o:nJurodia)
		if lTribunal
			if !Recibo->(DbSeek( Recemov->Docnr ))
				Qout( Field->Docnr, Field->Tipo, Dtoc(Field->Emis), Dtoc( o:dVcto ), Tran( o:nVlr, "@E 99,999.99"), o:dCalculo, o:dCalculo, Tran( o:nVlrCorrigido, "@E 9,999,999.99"), Tran(o:nAtraso, "9999"), Tran( o:nSoJuros, "@E 9,999,999.99"), Tran( o:nVlrCorrigido + o:nSoJuros, "@E 9,999,999.99"), Tran( o:nMulta, "@E 9,999,999.99"), Tran( O:nVlrCorrigido + o:nSoJuros + o:nMulta, "@E 9,999,999.99")) 
				o:ContaTribunal()
				Col++
			endif	
		else	
			if Recibo->(DbSeek( Recemov->Docnr ))
				Qout( Field->Docnr, Field->Tipo, Dtoc(Field->Emis), Dtoc(o:dVcto), Left(Field->Obs, 40), Tran( o:nVlr, "@E 999,999.99"), Tran(Recibo->Data - o:dVcto, "9999"), Recibo->Data, Recibo->Vlr )
				o:ContaRecibo()				
				Col++
			else
				Qout( Field->Docnr, Field->Tipo, Dtoc(Field->Emis), Dtoc(o:dVcto), Left(Field->Obs, 40), Tran( o:nVlr, "@E 999,999.99"), Tran(o:nAtraso, "9999"), space(5), "NC", space(10), "NC", Tran( o:nSoma, "@E 9,999,999.99")) 
				if Recemov->Vcto <= dCalculo // vencido
				   o:ContaVencido()					
				else
				   o:ContaVencer()					
				endif	
				Col++
			endif
		endif	
	endif	
	UltCodi := Field->Codi		
	Recemov->(DbSkip(1))
	if Col >= 54 .OR. UltCodi != Field->Codi
		Qout(Repl( SEP, Tam ))
		if lTribunal
			Qout("TOTAIS          ¯¯ {" + StrZero(o:nRegTribunal, 5) + "}", Space(7), Tran(o:nVlrPrincipalTribunal, "@E 99,999.99"), Space(17), Tran( o:nVlrCorrigidoTotal, "@E 9,999,999.99"),;
					Space(4), Tran( o:nSoJurosTotal, "@E 9,999,999.99"), Tran( o:nVlrCorrigidoMaisnSoJuros, "@E 9,999,999.99"), Tran( o:nMultaTotal, "@E 9,999,999.99"), Tran( o:nTotalGeral, "@E 9,999,999.99")) 
		else	
			Qout(NG + "RECIBO EMITIDO  ¯¯ {" + StrZero(o:nRegRecibo,  5) + "}", space(46), Tran( o:nVlrPrincipalRecibo,  "@E 9,999,999.99" ), space(14), Tran( o:nTotalRecibo, "@E 9,999,999.99" ) + NR)
			Qout(NG + "VENCIDO ABERTO  ¯¯ {" + StrZero(o:nRegVencido, 5) + "}", Space(46), Tran( o:nVlrPrincipalVencido, "@E 9,999,999.99" ), space(14), Tran( 0,              "@E 9,999,999.99" ), Tran( o:nTotalVencido, "@E 9,999,999.99" ) + NR)
			Qout(NG + " VENCER ABERTO  ¯¯ {" + StrZero(o:nRegVencer,  5) + "}", Space(46), Tran( o:nVlrPrincipalVencer,  "@E 9,999,999.99" ), space(14), Tran( 0,              "@E 9,999,999.99" ), Tran( o:nTotalVencer,  "@E 9,999,999.99" ) + NR)						
			Qout()
			Qout("EXTRATO PARA SIMPLES CONFERENCIA. NAO VALE COMO RECIBO.")
			Qout("NOS RESERVAMOS DE COBRAR VALORES QUE NAO ESTEJAM LANCADOS E EXPRESSOS NOS TERMOS E CONDICOES DO CONTRATO.")
		endif	
		if UltCodi != Field->Codi
			NovoCodi := OK
		endif
		Col := 58
		 __Eject()
	endif
EndDo
PrintOff()
return(ResTela(cScreen))

*:==================================================================================================================================

def AjustaReciboRecemov()
*******************************
	LOCAL GetList  := {}
	LOCAL Arq_Ant	:= Alias()
	LOCAL Ind_Ant	:= IndexOrd()
	LOCAL	dIni		:= Ctod("01/" + StrZero(Month(Date()),2) + "/" + Right(Dtoc(Date()),2))
	LOCAL	dFim		:= Date()
	LOCAL oBloco   
	LOCAL cTela
	LOCAL cDocnr

	MaBox( 14, 45, 17, 75 )
	@ 15, 46 Say "Data Inicial.:" Get dIni Pict "##/##/##"
	@ 16, 46 Say "Data Final...:" Get dFim Pict "##/##/##" Valid if((Empty(dFim) .OR. dFim < dIni), ( ErrorBeep(), Alerta("Ooops!: Entre com uma data valida! Maior ou igual data inicial"), FALSO ), OK ) 			
	Read
	if LastKey() = ESC	
		return nil
	endif			

	Recemov->(Order(RECEMOV_DOCNR))
	Recibo->(Order(RECIBO_DATA))
	Recibo->(DbGoTop())
	if Recibo->(!SeekData( dIni, dFim, "Data"))
		AreaAnt( Arq_Ant, Ind_Ant )
		Nada()
		return nil
	endif	
	if conf("Pergunta: Continuar com a tarefa?")
		oBloco := {|| Recibo->Data >= dIni .AND. Recibo->Data <= dFim }
		cTela  := Mensagem("Aguarde... Ajustando registros. ESC cancela.")		
		oMenu:ResetReg()
		While Eval(oBloco) .AND. Rep_Ok()	
			cDocnr := Recibo->Docnr
			Mensagem("Verificando Documento # " + cDocnr, 31, 14, 76)
			if Recemov->(DbSeek(cDocnr))
				if Recemov->(TravaReg())
					Recemov->DataPag := Recibo->Data
					Recemov->VlrPag  := Recibo->Vlr
					Recemov->StPag   := OK
					Recemov->(Libera())				
				endif						
			endif		
			oAmbiente:ContaReg()
			Recibo->(DbSkip(1))
		EndDo
		restela( cTela)
		Alerta("Tarefa realizada com sucesso!")
	endif				
	AreaAnt( Arq_Ant, Ind_Ant )
	return nil

static function NewGraficoReceberDevedores(nChoice, nOrdem)
*-----------------------------------------------------------*
	PRIVA oDevedor := TReceposiNew()

	hb_default(@nOrdem, 3)	   
	oDevedor:nChoice := nChoice
	oDevedor:nOrdem  := nOrdem
	GraficoReceberDevedores(oDevedor)
	return nil
				
static function GraficoReceberDevedores(oDevedor)
*-------------------------------------------------*
	LOCAL cScreen   := SaveScreen()	
	LOCAL cCodi
	LOCAL cNome
	LOCAL cValor, nValor
	LOCAL cMulta, nMulta 
	LOCAL cJuros, nJuros
	LOCAL cSoma,  nSoma 
	LOCAL lPageCircular := FALSO
	LOCAL lMsg          := FALSO
	LOCAL x
	LOCAL nLen
	LOCAL nJuroMesComposto
	LOCAL anMulta_anJuros_anSoma
	LOCAL oSender := oDevedor
	
	Receber->(Order( RECEBER_CODI ))
	Recibo->(Order( RECIBO_DOCNR ))
	Area("Recemov")
	Recemov->(Order( RECEMOV_CODI ))
	Mensagem("Aguarde, calculando valores.")	
	oDevedor:lRescisao := false
	oDevedor:lCalcular := true
	
   oMenu:ResetReg()
	Receber->(DbGoTop())
	While Receber->(!Eof()) .AND. Rep_Ok()
	   cCodi := Receber->Codi
		cNome := Receber->Nome
		if oDevedor:nChoice == 8 
			if !Receber->Suporte
				Receber->(DbSkip(1))
				Loop
			endif
		elseif oDevedor:nChoice == 9
			if Receber->Suporte
				Receber->(DbSkip(1))
				Loop
			endif
		endif							
		nValor := 0
		nMulta := 0
		nJuros := 0
		nSoma  := 0      
		if Recemov->(DbSeek(cCodi))	
			while Recemov->Codi == cCodi
				oMenu:ContaReg()
				if Recibo->(!DbSeek( Recemov->Docnr ))
				   if Recemov->Vcto <= Date()
						anMulta_anJuros_anSoma := AtualizaSoma(oDevedor)
						nValor                  += Recemov->Vlr
						nMulta                  += anMulta_anJuros_anSoma[1]
						nJuros                  += anMulta_anJuros_anSoma[2]
						nSoma                   += anMulta_anJuros_anSoma[3]
					endif	
				endif			  				
				Recemov->(DbSkip(1))
			endDo
			if nValor > 0
			   if len(oDevedor:xTodos) >= 65535
				   Alerta("ERRO: Impossivel adicionar mais que 65535 registros.")
					exit
				endif	
				aadd( oDevedor:xTodos, { cCodi, cNome, nValor, nMulta, nJuros, nSoma})				
			endif
		endif			
		Receber->(DbSkip(1))
	EndDo  	
	
	if (oDevedor:nOrdem == 1 .or. oDevedor:nOrdem == 2 )
		Asort( oDevedor:xTodos,,, {|x,y|x[oDevedor:nOrdem] < y[oDevedor:nOrdem]}) // nValor
	else
		Asort( oDevedor:xTodos,,, {|x,y|x[oDevedor:nOrdem] > y[oDevedor:nOrdem]}) // nValor
	endif

	nLen   := Len(oDevedor:xTodos)
	nValor := 0
	nMulta := 0
	nJuros := 0
	nSoma  := 0
	for x  := 1 to nLen
		aadd( oDevedor:aTodos, StrZero(x,3) + ' ' + ;
			   oDevedor:xTodos[x,1] + ' ' + ;
				oDevedor:xTodos[x,2] + ;
				" | R$" + Tran( oDevedor:xTodos[x,3], "@E 9,999,999.99") + ;
				" | R$" + Tran( oDevedor:xTodos[x,4], "@E 9,999,999.99") + ;
				" | R$" + Tran( oDevedor:xTodos[x,5], "@E 9,999,999.99") + ;
				" | R$" + Tran( oDevedor:xTodos[x,6], "@E 9,999,999.99") ;
		)		
		nValor += oDevedor:xTodos[x,3]
		nMulta += oDevedor:xTodos[x,4]
		nJuros += oDevedor:xTodos[x,5]
		nSoma  += oDevedor:xTodos[x,6]
		
	next	
	nJuroMesComposto := oAmbiente:aSciArray[1,SCI_JUROMESCOMPOSTO]
	nJuroMesComposto := if( nJuroMesComposto <= 0 .OR. nJuroMesComposto == nil , 1 , nJuroMesComposto)   		
	AltJrInd(1,nJuroMesComposto, oDevedor:xTodos[1,1], lMsg, , oSender)				
	
	cValor := "R$" + Tran( nValor, "@E 9,999,999.99")
	cMulta := "R$" + Tran( nMulta, "@E 9,999,999.99")
	cJuros := "R$" + Tran( nJuros, "@E 9,999,999.99")
	cSoma  := "R$" + Tran( nSoma,  "@E 9,999,999.99")
		
	oDevedor:CloneVarColor()		
	MaBox( 01, 00, 07, MaxCol())		  		   					
	oDevedor:cTop    := "#ID CODI  NOME DO CLIENTE                                     VALOR            MULTA            JUROS             SOMA" 
	oDevedor:cTop	  += Space( MaxCol() - Len(oDevedor:cTop))
	oDevedor:cBottom := "TOTAL GERAL DOS DEVEDORES :" + space(26) + cValor + spac(3) + cMulta + space(3) + cJuros + space(3) + cSoma
	oDevedor:cBottom += Space( MaxCol() - len(oDevedor:cBottom))		
	oDevedor:Show()
	__FuncaoDevedores( 0, 1, 1 )	
   //BrowseArray(oDevedor:aTodos)   
	oDevedor:aChoice_(oDevedor:aTodos, true, "__FuncaoDevedores", lPageCircular)	
	return(ResTela(cScreen))

*:---------------------------------------------------------------------------------------------------------------------------------

def __funcaoDevedores( nMode, nCurElemento)
************************************************
//LOCAL pUns  		 := AscanCorHotKey( pFore) 
//LOCAL pUns  		 := AscanCorDesativada( pFore)
//LOCAL pUns  		 := ColorStrToInt("R+/")
LOCAL nMaxCol
LOCAL cString
LOCAL nCol 
LOCAL x
LOCAL cCodi
LOCAL nOp
LOCAL aMenu
FIELD UltCompra
FIELD Matraso
FIELD VlrCompra

#Define POS_OBS 				  11
#define SETA_CIMA 			  5
#define SETA_BAIXO			  24
#define SETA_ESQUERDA		  19
#define SETA_DIREITA 		  4
#define AC_REPAINT           AC_CONT
#define AC_REDRAW            5
#define AC_CURELEMENTO       10

/*
Achoice() Modes
0 AC_IDLE		 Idle
1 AC_HITTOP 	 Tentativa do cursor passar topo da lista
2 AC_HITBOTTOM  Tentativa do cursor passar fim da lista
3 AC_EXCEPT 	 Keystroke exceptions
4 AC_NOITEM 	 No selectable item

ACHOICE() User Function return Values
// ---------------------------------------------------------------------
Value   Achoice.ch	  Action
---------------------------------------------------------------------
0		  AC_ABORT		  Abort selection
1		  AC_SELECT 	  Make selection
2		  AC_CONT		  Continue ACHOICE()
3		  AC_GOTO		  Go to the next item whose first character matches the key pressed
4		  AC_REDRAW
5       AC_REPAINT
10      AC_CURELEMENTO
---------------------------------------------------------------------
*/

SetKey( K_F1, NIL )
SetKey( K_F2, NIL )
SetKey( K_F5, NIL )

x                     := nCurElemento
oDevedor:CurElemento  := x
cCodi                 := oDevedor:xTodos[x,1]

Do Case
Case nMode = AC_IDLE // 0
	cString := Space(0)	
	cString += 'ESC RETORNA|'   
	cString := 'F2-TXJURO|F3-EDITAR|F4-DUPLICA|F5-ATUALIZA|CTRL+F5=VLR ORIGINAL|F6-ORDEM|F7=VISFATURA|SPC-FATURA|' + cString
	StatusSup( cString, Cor(2))
	Receber->(Order( RECEBER_CODI ))
	nMaxCol := MaxCol()
	cCodi   := oDevedor:xTodos[x,1]
	nCol    := 1
	if Receber->(DbSeek( cCodi ))
	    Write( ++nCol, 02, Space(nMaxCol-2))
		Write( ++nCol, 02, Space(nMaxCol-2))
		Write( ++nCol, 02, Space(nMaxCol-2))
		Write( ++nCol, 02, Space(nMaxCol-2))
		Write( ++nCol, 02, Space(nMaxCol-2))
		
		nCol := 1
		Write( ++nCol, 02, cCodi + " " + Receber->Nome )
		Write( ++nCol, 02, Receber->Ende + " " + Receber->Bair )
		Write( ++nCol, 02, Receber->Cep  + "/" + Receber->Cida + " " + Receber->Esta )
		Write( ++nCol, 02, Receber->Obs  )
		Write( ++nCol, 02, Receber->Obs1 )
		
		nCol := 1
		Write( ++nCol, nMaxCol-29, "Inicio      : " + Dtoc( Receber->Data ))
		Write( ++nCol, nMaxCol-29, "Telefone #1 : " + Receber->Fone )
		Write( ++nCol, nMaxCol-29, "Telefone #2 : " + Receber->Fax )
		Write( ++nCol, nMaxCol-29, "Vlr Fatura  : " )		
	else
	    Write( ++nCol, 02, Space(nMaxCol-2))
		Write( ++nCol, 02, Space(nMaxCol-2))
		Write( ++nCol, 02, Space(nMaxCol-2))
		Write( ++nCol, 02, "***** CLIENTE NAO LOCALIZADO ***** TALVEZ DELETADO?")
		Write( ++nCol, 02, Space(nMaxCol-2))
		Write( ++nCol, 02, Space(nMaxCol-2))
	endif
	return( AC_REPAINT)

*===============================================================================
	
Case nMode = AC_HITTOP
	return( AC_CONT)

*===============================================================================	
	
Case nMode = AC_HITBOTTOM
	return( AC_CONT)
	
*===============================================================================	

Case LastKey() = K_F6
		aMenu := {;
						"Mostrar em Ordem [CODI]",;
						"Mostrar em Ordem [NOME]",;
						"Mostrar em Ordem [VALOR (default)]",;
						"Mostrar em Ordem [MULTA]",;
						"Mostrar em Ordem [JUROS]",;
						"Mostrar em Ordem [SOMA]";
					 }
					 
		M_Title("ESCOLHA A ORDEM DE VISUALIZACAO")
		nOp := FazMenu( 10,10, aMenu, Cor())				
		if nOp = 0
			return(AC_CONT)
		else
			NewGraficoReceberDevedores(oDevedor:nChoice, oDevedor:nOrdem := nOp)
		endif
		oDevedor:Redraw_()      	
		return( AC_REPAINT)

*===============================================================================

Case LastKey() = K_F1
	HelpReceposi()
	return(AC_CONT)

Case LastKey() = K_ESC   
	return( AC_ABORT)

Case LastKey() = K_ENTER	
	NewPosiReceber(1 , cCodi, NIL)
	return(AC_CONT)
	
Case LastKey() = K_CTRL_ENTER	
	if CliInclusao(OK)
		eval({|x, cCodi, cNome|
			LOCAL cStr           := oDevedor:aTodos[x]
			LOCAL xLen           := len(cStr)
			oDevedor:xTodos[x,1] := cCodi
			oDevedor:xTodos[x,2] := cNome
			oDevedor:aTodos[x]   := left(cStr,4) + cCodi + ' ' + cNome + right(cStr, (xLen-50))
			return nil
		}, x, Receber->Codi, Receber->Nome)	   
	endif
	return(AC_CONT)	
	
OtherWise
   return( AC_CONT)
	
EndCase
return nil

def AjustaRecebidoParaReciboPorFatura(lAutomatico, cFatu)
*-------------------------------------------------------*
	LOCAL GetList  := {}
	LOCAL cScreen  := SaveScreen()
	LOCAL Arq_Ant	:= Alias()
	LOCAL Ind_Ant	:= IndexOrd()	
	LOCAL oBloco   
	LOCAL cTela

	While OK
		if lAutomatico == nil .OR. !lAutomatico
			hb_default(@cFatu,  Space(7))		
			hb_default(@lAutomatico, FALSO)			
			MaBox( 10, 10, 14, 67 )
			@ 11, 11 Say "Fatura N?:" Get cFatu Pict "@!" Valid VisualAchaFatura(@cFatu)	
			@ 12, 11 Say "Codi......:" 
			@ 13, 11 Say "Nome......:" 
			Read
			
			if LastKey() = ESC .OR. !conf("Pergunta: Continuar com a tarefa?")			
				AreaAnt( Arq_Ant, Ind_Ant )
				return(Restela(cScreen))
			endif					
		endif	 
		oBloco := {|| Recebido->Fatura = cFatu }
		Vendedor->(Order(VENDEDOR_CODIVEN))
		Receber->(Order(RECEBER_CODI))
		Recebido->(Order(RECEBIDO_FATURA))
			
		if Recebido->(DbSeek(cFatu))		
			Receber->(DbSeek(Recebido->Codi))				
			Write(12 , 23 , Recebido->Codi)
			Write(13 , 23 , Receber->Nome)					
			cTela  := Mensagem("Aguarde... Ajustando registros. ESC cancela.")		
         oMenu:ResetReg()			
			While Eval(oBloco) .AND. Rep_Ok()					
				if Recibo->(Incluiu())
					Recibo->Tipo := "RECCAR"
					Recibo->Codi := Recebido->Codi
					if Receber->(DbSeek(Recebido->Codi))
						Recibo->Nome := Receber->Nome
					endif
					Recibo->Vlr        := Recebido->VlrPag
					Recibo->Fatura     := Recebido->Fatura
					Recibo->Docnr      := ConverteStrToNumber(Recebido->Docnr)
					Recibo->DocnrAnt   := Recebido->Docnr
					Recibo->Vcto       := Recebido->Vcto
					Recibo->Data       := Recebido->DataPag
					Recibo->Caixa      := Recebido->Caixa
					Recibo->Usuario    := Vendedor->Nome						
					Recibo->Atualizado := Recebido->Atualizado
					Recibo->Hist       := Recebido->Obs
					oAmbiente:ContaReg()
					Recibo->(Libera())      			  				
				endif				
				Recebido->(DbSkip(1))
			EndDo					
			restela( cTela)
			if !lAutomatico
				Alerta("Tarefa realizada com sucesso!;;" + "Registros encontrados e processados: #" + trim(strzero(oAmbiente:nRegistrosImpressos,5)))
				ReciboDbedit(cFatu)
				loop
			endif			
		else
			if !lAutomatico
				Nada()		
				loop
			endif	
		endif	
		AreaAnt( Arq_Ant, Ind_Ant )
		return(Restela(cScreen))		
	enddo
	return(Restela(cScreen))		
endef	
	
def AjustaRecebidoParaReciboGeral()
*---------------------------------*
	LOCAL GetList  := {}
	LOCAL cScreen  := SaveScreen()
	LOCAL Arq_Ant	:= Alias()
	LOCAL Ind_Ant	:= IndexOrd()	
	LOCAL oBloco   
	LOCAL cTela

	While OK
		if LastKey() = ESC .OR. !conf("Pergunta: Continuar com a tarefa?")			
			AreaAnt( Arq_Ant, Ind_Ant )
			return(Restela(cScreen))
		endif					

		oBloco := {|| Recebido->(!Eof())}
		Recibo->(Order(RECIBO_DOCNR))
		Receber->(Order(RECEBER_CODI))
		Recebido->(Order(RECEBIDO_FATURA))
		
		if Recebido->(LastRec()) >= 1
			Recebido->(DbGoTop())	
			cTela  := Mensagem("Aguarde... Ajustando registros. ESC cancela.")		
			oMenu:ResetReg()
			While Eval(oBloco) .AND. Rep_Ok()			
				cDocnr := Recebido->Docnr
				if Recibo->(!DbSeek(cDocnr))
					if Recibo->(Incluiu())
						Recibo->Tipo := "RECCAR"
						Recibo->Codi := Recebido->Codi
						if Receber->(DbSeek(Recebido->Codi))
							Recibo->Nome := Receber->Nome
						endif
						Recibo->Vlr        := Recebido->VlrPag
						Recibo->Fatura     := Recebido->Fatura
						Recibo->Docnr      := Recebido->Docnr
						Recibo->DocnrAnt   := Recebido->Docnr
						Recibo->Vcto       := Recebido->Vcto
						Recibo->Data       := Recebido->DataPag
						Recibo->Caixa      := Recebido->Caixa
						Recibo->Usuario    := Vendedor->Nome						
						Recibo->Atualizado := Recebido->Atualizado
						Recibo->Hist       := Recebido->Obs
						oAmbiente:ContaReg()
						Recibo->(Libera())      			  				
					endif				
				endif				
				Recebido->(DbSkip(1))
			EndDo					
			restela( cTela)			
			Alerta("Tarefa realizada com sucesso!;;" + "Registros encontrados e processados: #" + trim(strzero(oAmbiente:nRegistrosImpressos,5)))
			ReciboDbedit()			
		else
			Nada()		
			loop
		endif	
		AreaAnt( Arq_Ant, Ind_Ant )
		return(Restela(cScreen))		
	enddo
	return(Restela(cScreen))			
endef
	
*+------------------------------*	
def ConverteStrToNumber(cDocnr)
*+------------------------------*
	LOCAL aLetras := {}		
	LOCAL nStart  := 65
	LOCAL nStop   := nStart + 24	
	LOCAL cLetra := asc(right(upper(cDocnr),1))
	LOCAL cNumber	
	LOCAL i

   if cLetra >= nStart .AND. cLetra <= nStop // Letras A-Z
		for i := nStart to nStop
			aadd(aLetras, upper(chr(i)))		
		next	
		cNumber := strzero(ascan(aLetras, right(cDocnr,1)),2)
		cDocnr  := substr(cDocnr, 2, 7) + cNumber	// 002796-		
	endif		
	return(cDocnr)
enddef

*:---------------------------------------------------------------------------------------------------------------------------------

def AgeCobranca( cCodi )
*+----------------------*
	LOCAL cScreen := SaveScreen()
	LOCAL nConta  := 0
	LOCAL cPict   := '@!S' 
	LOCAL hObs    := { => } // empty hash	
	LOCAL hRecord := NIL
	LOCAL dData
	LOCAL dDataPro	
	LOCAL cCodiVen
	LOCAL lAlterar
	LOCAL lIncluir	
	
	WHILE OK
		oMenu:Limpa()
		if cCodi == NIL
			cCodi := Space(05)
			PutKey( K_ENTER )
		endif
		hObs[1] := Space(132)
		hObs[2] := Space(132)
		hObs[3] := Space(132)
		hObs[4] := Space(132)
		hObs[5] := Space(132)
		
		cCodiVen := cCaixa
		dData 	:= Date()
		dDataPro := cTod("//")
		cPict    := '@!S' + StrZero(iif(MaxCol() > 132, 132, MaxCol()-10),3)
		MaBox(10, 01, 20, MaxCol()-1)
		@ 11, 02 Say "Cliente..........:" GET cCodi    PICT PIC_RECEBER_CODI Valid RecErrado( @cCodi,,    Row(), Col()+1 )
		@ 12, 02 Say "Cobrador.........:" Get cCodiVen Pict "9999"           Valid FunErrado( @cCodiVen,, Row(), Col()+1 )
		@ 13, 02 Say "Data.............:" GET dData    PICT "##/##/##"       Valid if(Empty(dData), (ErrorBeep(), Alerta("Ooops!: Entre com a Data!"),      FALSO ), OK )
		@ 14, 02 Say "Hist #1:"           GET hObs[1]  PICT cPict            Valid if(Empty(hObs[1]),  (ErrorBeep(), Alerta("Ooops!: Entre com o historico!"), FALSO ), OK )
		@ 15, 02 Say "Hist #2:"           GET hObs[2]  PICT cPict       
		@ 16, 02 Say "Hist #3:"           GET hObs[3]  PICT cPict       
		@ 17, 02 Say "Hist #4:"           GET hObs[4]  PICT cPict       
		@ 18, 02 Say "Prox Agendamento.:" GET dDataPro PICT "##/##/##"
		@ 19, 02 Say "Hist #5>"           GET hObs[5]  PICT cPict            Valid if(!Empty(dDataPro) .AND. Empty(hObs[5]), ( ErrorBeep(), Alerta("Ooops!: Entre com o historico!"), FALSO ), OK )
		Read
		if LastKey() = ESC
			ResTela( cScreen )
			return( iif(nConta == 0, FALSO , OK))
		endif
		Recemov->(Order( RECEMOV_CODI ))
		Receber->(Order( RECEBER_CODI ))
		if Receber->(DbSeek( cCodi ))
			ErrorBeep()
			if Conf("Pergunta: Confirma inclusao?")
				lAlterar := FALSO
				lIncluir := OK
				if !lAlterar
					if !lIncluir
						Loop
					endif
				endif
				if Receber->(TravaReg())
					Receber->ProxCob := dData
					Receber->(Libera())
					Agenda->(Order( AGENDA_CODI ))
					While Agenda->Codi = cCodi
						if Agenda->(TravaReg())
							Agenda->Ultimo := FALSO
							Agenda->(Libera())
							Agenda->(DbSkip(1))
						endif
					EndDo
					hRecord := NIL
					FOR EACH hRecord IN hObs
						if !empty(hRecord:__ENUMVALUE())
							if Agenda->(Incluiu())
								Agenda->Codi	 := cCodi
								Agenda->Data	 := if(hRecord:__ENUMKEY() = 5, dDataPro, dData )
								Agenda->Hora    := Time()
								Agenda->Hist	 := hRecord:__ENUMVALUE()
								Agenda->Caixa	 := cCodiVen
								Agenda->Usuario := oAmbiente:xUsuario
								Agenda->Ultimo  := OK
								Agenda->(Libera())							
								nConta++						
							endif
						endif	
					next
					if Recemov->(DbSeek( cCodi ))
						While Recemov->Codi = cCodi
							if Recemov->(TravaReg())
								Recemov->Cobrador := cCodiVen
								Recemov->(Libera())
							endif
							Recemov->(DbSkip(1))
						EndDo
					endif										
				endif
			endif
		endif
	EndDo
