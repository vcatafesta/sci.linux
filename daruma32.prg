#include "fileio.ch"

set wrap on
set score off
set status off
clear

/*While Principal*/
while .t.
 	
	clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 	@ 0,1 say " Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	
	@ 24,0 clear to 24,80
 	set color to w/b
 	@ 24,1 say " DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE Desenvolvedores DARUMA!!!"
		
	set color to n/bg
 	@ 1,0 clear to 23,80  
 	
 
	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
	
        @  02,02 prompt "Funcoes de Desenvolvimento para FS345 - Impressora Fiscal          "
        @  04,02 prompt "Funcoes de Desenvolvimento para FS318 - Impressora Restaurante     "
 	@  06,02 prompt "Funcoes de Desenvolvimento para DS300 - Mini Impressora            "
 	@  08,02 prompt "Funcoes de Desenvolvimento para FS2000 - Impressora duas estacoes  "

	/*set color to*/

 	menu to VAR_MENU
 
	VAR_BUFFER_COMANDO := "" /*Variavel para Envio do comando*/
 	VAR_BUFFER_RETORNO := "" /*Variavel para Recepcao do Comando*/
        VAR_ESPERARTECLA:=1      /*Variavel que indica se espera o usuario pressionar uma tecla ou nao*/

        do case
	
        	case VAR_MENU = 0
			exit

		/*Funcoes de Desenvolvimento para FS345 (Impressora Fiscal)*/
		case VAR_MENU = 1
			MENU_FS345();

		/*Funcoes de Desenvolvimento para FS318 (Impressora Restaurante)*/
		case VAR_MENU = 2
			MENU_FS318();

		/*Funcoes de Desenvolvimento para DS300 (Mini Impressora)*/
		case VAR_MENU = 3
			MENU_DS300();
		
		/*Funcoes de Desenvolvimento para FS2000 (Impressora duas estações)*/
		case VAR_MENU = 4
			MENU_FS2000();

	endcase

end

return


/*///////////////////////////////////////////// Menu principal FS345 ///////////////////////////////////////////////////*/

static function MENU_FS345()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    
    /*set color to   */

        @  02,02 prompt "Funcoes de Configuracao da DLL                          (1 a 299)"
 	@  03,02 prompt "Funcoes de Inicializacao e Configuracao do ECF        (300 a 599)"
 	@  04,02 prompt "Funcoes de Utilidades e Outras Funcoes                (600 a 899)"
 	@  05,02 prompt "Funcoes de Cupom  Fiscal                            (1000 a 1099)"
 	@  06,02 prompt "Funcoes de Relatorios Fiscais                       (1100 a 1199)"
 	@  07,02 prompt "Funcoes de Operacoes  Nao  Fiscais e Vinculados     (1200 a 1299)"
 	@  08,02 prompt "Funcoes de Autenticacao                             (1300 a 1309)"
 	@  09,02 prompt "Funcoes de Gaveta e Dinheiro                        (1310 a 1319)"
 	@  10,02 prompt "Funcoes de Facilidades para o TEF                   (1900 a 1950)"
 	@  11,02 prompt "Funcoes de Informacoes, Status e Retorno            (1400 a 1800)"	
    
 	menu to VAR_MENU
 
	VAR_BUFFER_COMANDO := "" /*Variavel para Envio do comando*/
 	VAR_BUFFER_RETORNO := "" /*Variavel para Recepcao do Comando*/
        VAR_ESPERARTECLA:=1      /*Variavel que indica se espera o usuario pressionar uma tecla ou nao*/

        do case

		case VAR_MENU = 0
			exit

		/*Funcoes de Configuracao da DLL (1 a 299)*/
		case VAR_MENU = 1
			MENU_REGISTRY();

		/*Funcoes de Inicializacao e Configuracao do ECF (300 a 599)*/
		case VAR_MENU = 2
			MENU_INICIALIZACAO_CONFIGURACAO();

		/*Funcoes de Utilidades e Outras Funcoes (600 a 899)*/
		case VAR_MENU = 3
			MENU_UTILIDADES_OUTROS();

		/*Funcoes de Cupom  Fiscal (1000 a 1099)*/
		case VAR_MENU = 4
			MENU_CUPOM();
		
		/*Funcoes de Relatorios Fiscais (1100 a 1199)*/
		case VAR_MENU = 5
			MENU_RELATORIOS_FISCAIS();

		/*Funcoes de Operacoes  Nao  Fiscais e Vinculados (1200 a 1299)*/
		case VAR_MENU = 6
			MENU_OPERACOES_NAO_FISCAIS();

		/*Funcoes de Autenticacao (1300 a 1309)*/
		case VAR_MENU = 7
			MENU_AUTENTICA();

		/*Funcoes de Gaveta e Dinheiro (1310 a 1319)*/
		case VAR_MENU = 8
			MENU_GAVETA();

		/*Funcoes de Facilidades para o TEF (1900 a 1950)*/
		case VAR_MENU = 9
			MENU_TEF();

		/*Funcoes de Informacoes, Status e Retorno (1400 a 1800)*/
		case VAR_MENU = 10
			MENU_RETORNO();
		
    endcase

enddo

return 

/*////////////////////////////////////////// FIM do Menu principal FS345 ///////////////////////////////////////////////*/


/*/////////////////////////////////// Funcoes de Configuracao da DLL (1 a 299) /////////////////////////////////////////*/

static function MENU_REGISTRY()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_Registry_Porta                              (Indice  1) "
    @  03,02 prompt "Daruma_Registry_Path                               (Indice  2) "
    @  04,02 prompt "Daruma_Registry_Status                             (Indice  3) "
    @  05,02 prompt "Daruma_Registry_StatusFuncao                       (Indice  4) "
    @  06,02 prompt "Daruma_Registry_Retorno                            (Indice  5) "
    @  07,02 prompt "Daruma_Registry_ControlePOrta                      (Indice  6) "
    @  08,02 prompt "Daruma_Registry_ModoGaveta                         (Indice  7) "
    @  09,02 prompt "Daruma_Registry_ConfigRede                         (Indice  8) "
    @  10,02 prompt "Daruma_Registry_Log                                (Indice  9) "
    @  11,02 prompt "Daruma_Registry_NomeLog                            (Indice 10) "
    @  12,02 prompt "Daruma_Registry_Separador                          (Indice 11) "
    @  13,02 prompt "Daruma_Registry_SeparadorMsgPromo                  (Indice 12) "
    @  14,02 prompt "Daruma_Registry_VendeItem1Linha                    (Indice 13) "
    @  15,02 prompt "Daruma_Registry_XAutomatica                        (Indice 14) "
    @  16,02 prompt "Daruma_Registry_ZAutomatica                        (Indice 15) "
    @  17,02 prompt "Daruma_Registry_Emulador                           (Indice 16) "
    @  18,02 prompt "Daruma_Registry_AlteraRegistry                     (Indice 17) "
    @  19,02 prompt "Daruma_Registry_ImprimeRegistry                    (Indice 18) "
    @  20,02 prompt "Daruma_Registry_RetornaValor                       (Indice 19) "
    @  21,02 prompt "Daruma_Registry_Default                            (Indice 20) "
    
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_Registry_Porta*/
		case VAR_MENU_CUPOM = 1
		   /*Indice 1 + Porta de Comunicação de COM1 até a COM5, ou Default busca automatica da porta*/
		   VAR_BUFFER_COMANDO := "1;DEFAULT;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_Registry_Path*/
		case VAR_MENU_CUPOM = 2
		   /*Indice 2 + Caminho onde serão guardados os arquivos de respostas 'OutPut' da impressora*/
		   VAR_BUFFER_COMANDO := "2;C:\Daruma;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_Registry_Status*/
		case VAR_MENU_CUPOM = 3
		   /*Indice 3 + Configura se o status da Impressora será retornado na Variavel (por referência) se setado "0" ou em arquivo Texto (status.txt) se setado" 1"*/
		   VAR_BUFFER_COMANDO := "3;0;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

        	/*Daruma_Registry_StatusFuncao*/
		case VAR_MENU_CUPOM = 4
		   /*Indice 4 + 0 - Para a Função Retornar normal / 1 - Para a Função retornar -27 caso o ECF sinalize valores de status diferentes de OK*/
		   VAR_BUFFER_COMANDO := "4;0;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_Registry_Retorno*/
		case VAR_MENU_CUPOM = 5
                  /*Indice 5 + 0 - Retorna as informações na Variável / 1 - Retorna as informações no arquivo Texto RETORNO.TXT*/
		   VAR_BUFFER_COMANDO := "5;0;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_Registry_ControlePorta*/
		case VAR_MENU_CUPOM = 6
		   /*Indice 6 + 0 - O Aplicativo Controla a porta Serial e deve chamar as funções de Abertura e Fechamento de porta / 1 - Todo este controle fica a cargo da dll de comunicacao Daruma32.dll*/
		   VAR_BUFFER_COMANDO := "6;1;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_Registry_ModoGaveta*/
		case VAR_MENU_CUPOM = 7
                   /*Indice 7 + 0 - Logica Invertida / 1 - Logica Invertida, depende do modelo da gaveta em que se utiliza*/
		   VAR_BUFFER_COMANDO := "7;0;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_Registry_ConfigRede*/
		case VAR_MENU_CUPOM = 8
        	@ 07,02 say "Menu desabilitado, ESC para retornar a tela de Menu Registry"

		/*Daruma_Registry_Log*/
		case VAR_MENU_CUPOM = 9
                   /*Indice 9 + 0 - Nao Cria o Log / 1 - Cria Log com todas as ações, Será criado o Arquivo Daruma32.log no Path que esta configurado como valor da Chave Path.*/
		   VAR_BUFFER_COMANDO := "9;1;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_Registry_NomeLog*/
		case VAR_MENU_CUPOM = 10
                   /*Indice 10 + Nome do Arquivo Log que será Criado.*/
		   VAR_BUFFER_COMANDO := "10;MeuLog.log;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_Registry_Separador*/
		case VAR_MENU_CUPOM = 11
                   /*Indice 11 + Indica qual o separador será para cada parametro no retorno dos dados*/
		   VAR_BUFFER_COMANDO := "11;,;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_ImprimeConfiguracoes*/
		case VAR_MENU_CUPOM = 12
                   /*Indice 12 + 0 - Não inclui a linha Separadora na Mensagem Promocional / 1 - Inclui a linha Separadora na Mensagem Promocional*/
		   VAR_BUFFER_COMANDO := "12;1;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_Registry_VendeItem1Linha*/
		case VAR_MENU_CUPOM = 13
                   /*Indice 13 + 0 - Não tentar Imprimir a venda do Item em uma Linha, neste caso sempre será em duas linhas / 1 - irá tentar vender e imprimir a venda do item em uma linha, sempre que possivel.*/
		   VAR_BUFFER_COMANDO := "13;1;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_Registry_XAutomatica*/
		case VAR_MENU_CUPOM = 14
                   /*Indice 14 + 0 - Não efetua a Leitura X Automaticamente, deixa isso a cargo da aplicação. / 1 - Irá efetuar a Leitura X Automaticamente ao perceber que existe uma LeituraX Pendente para Abrir o Dia*/
		   VAR_BUFFER_COMANDO := "14;0;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_Registry_ZAutomatica*/
		case VAR_MENU_CUPOM = 15
                   /*Indice 15 + 0 - Não efetua a Redução Z Automaticamente, deixa isso a cargo da aplicação. / 1 - Irá efetuar a Redução Z Automaticamente ao perceber que existe uma LeituraX Pendente para Abrir o Dia*/
		   VAR_BUFFER_COMANDO := "15;0;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_Registry_Emulador  */
		case VAR_MENU_CUPOM = 16
                   /*Indice 16 + 0 - Não trabalha com o Emulador / 1 - Trabalha com o Emulador*/
		   VAR_BUFFER_COMANDO := "16;0;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_Registry_AlteraRegistry*/
		case VAR_MENU_CUPOM = 17
                   /*Indice 17 + Comando do Registry + Valor a ser alterado*/
		   VAR_BUFFER_COMANDO := "17;Porta;DEFAULT;" 
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_Registry_ImprimeRegistry */
		case VAR_MENU_CUPOM = 18
                   /*Indice 18 + ECF para imprimir a configuração atual do Registry*/
		   VAR_BUFFER_COMANDO := "18;ECF;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_Registry_RetornaValor*/
		case VAR_MENU_CUPOM = 19
                   /*Indice 19 + Nome do Produto + Nome da Chave*/
		   VAR_BUFFER_COMANDO := "19;ECF;StatusFuncao;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_Registry_RetornaValor*/
		case VAR_MENU_CUPOM = 20
                   /*Indice 20 + Sem Parametros*/
		   VAR_BUFFER_COMANDO := "20;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

    endcase

enddo

return 

/*////////////////////////////// FIM das Funcoes de Configuracao da DLL (1 a 299) //////////////////////////////////////*/



/*/////////////////////////// Funcoes de Inicializacao e Configuracao do ECF (300 a 599) ///////////////////////////////*/

static function MENU_INICIALIZACAO_CONFIGURACAO()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FI_AlteraSimboloMoeda                       (Indice 300) "	
    @  03,02 prompt "Daruma_FI_ProgramaFormasPagamento                  (Indice 301) "	
    @  04,02 prompt "Daruma_FI_ProgramaAliquota                         (Indice 302) "
    @  05,02 prompt "Daruma_FI_ProgramaHorarioVerao                     (Indice 303) "
    @  06,02 prompt "Daruma_FI_NomeiaTotalizadorNaoSujeitoICMS          (Indice 304) "
    @  07,02 prompt "Daruma_FI_ProgramaArredondamento                   (Indice 305) "
    @  08,02 prompt "Daruma_FI_ProgramaTruncamento                      (Indice 306) "
    @  09,02 prompt "Daruma_FI_LinhaEntreCupons                         (Indice 307) "
    @  10,02 prompt "Daruma_FI_EspacoEntreLinhas                        (Indice 308) "
    @  11,02 prompt "Daruma_FI_ForcaImpactoAgulhas                      (Indice 309) "
    @  12,02 prompt "Daruma_FI_ProgramaOperador                         (Indice 310) "
    @  13,02 prompt "Daruma_FI_CfgFechaAutomaticoCupom                  (Indice 400) "
    @  14,02 prompt "Daruma_FI_CfgRedZAutomatico                        (Indice 401) "
    @  15,02 prompt "Daruma_FI_CfgLeituraXAuto                          (Indice 402) "
    @  16,02 prompt "Daruma_FI_CfgCalcArredondamento                    (Indice 403) "
    @  17,02 prompt "Daruma_FI_CfgHorarioVerao                          (Indice 404) "
    @  18,02 prompt "Daruma_FI_CfgSensorAut                             (Indice 405) "
    @  19,02 prompt "Daruma_FI_CfgEspacamentoCupons                     (Indice 407) "
    @  20,02 prompt "Daruma_FI_CfgLimiarNearEnd                         (Indice 409) "
    @  21,02 prompt "Daruma_FI_CfgPermMensPromoCNF                      (Indice 410) "
    @  22,02 prompt "Daruma_FI_CfgCupomAdicional                        (Indice 412) "
    
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Altera Simbolo Moeda*/
		case VAR_MENU_CUPOM = 1
		   /*Indice 300 +ParametrodeMoeda*/
		   VAR_BUFFER_COMANDO := "300; R;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Programa Formas de Pagamento*/
		case VAR_MENU_CUPOM = 2
		   /*Indice 301 +FormaPagamentoA+FormaPagamentoB+FormaPagamentoC...FormaPagamentoP*/
		   VAR_BUFFER_COMANDO := "301;Dinheiro;Cartão;Cheque;Ticket;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Programa Aliquotas*/
		case VAR_MENU_CUPOM = 3
		   /*Indice 302 +Alíquota+Vínculo*/
		   VAR_BUFFER_COMANDO := "302;0500;1;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

        	/*Programa Horario de Verao*/
		case VAR_MENU_CUPOM = 4
		   /*Indice 303 +Não há parametro*/
		   VAR_BUFFER_COMANDO := "303;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Nomeia Totalizador Nao Sujeito a ICMS*/
		case VAR_MENU_CUPOM = 5
		   /*Indice 304 +Indice+Totalizador*/
		   VAR_BUFFER_COMANDO := "304;05;Conta de Luz;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Programa Arredondamento*/
		case VAR_MENU_CUPOM = 6
		   /*Indice 305 +Não há parametro*/
		   VAR_BUFFER_COMANDO := "305;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Programa Truncamento*/
		case VAR_MENU_CUPOM = 7
		   /*Indice 306 +Não há parametro*/
		   VAR_BUFFER_COMANDO := "306;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Linha Entre Cupons*/
		case VAR_MENU_CUPOM = 8
		   /*Indice 307 +Linhas*/
		   VAR_BUFFER_COMANDO := "307;5;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Espaco Entre Linhas*/
		case VAR_MENU_CUPOM = 9
		   /*Indice 308 +espaço entre as linhas*/
		   VAR_BUFFER_COMANDO := "308;002;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Forca Impacto das Agulhas*/
		case VAR_MENU_CUPOM = 10
		   /*Indice 309 + Forca Impacto: 1 – Impacto fraco (default) / 2 – Impacto médio / 3 – Impacto forte*/
		   VAR_BUFFER_COMANDO := "309;2;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Programa Operador*/
		case VAR_MENU_CUPOM = 11
		   /*Indice 310 + Nome do Operador*/
		   VAR_BUFFER_COMANDO := "310;José da Silva;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Configura Fecha Automatico Cupom*/
		case VAR_MENU_CUPOM = 12
		   /*Indice 400 + 0 - Não fecha o Cupom Fiscal Automaticamente, isso fica a cargo do aplicativo. / 1 - Fecha o Cupom Fiscal Automaticamente ao Ligar e Desligar o ECF.*/
		   VAR_BUFFER_COMANDO := "400;1;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Configura Redução Z Automatica*/
		case VAR_MENU_CUPOM = 13
		   /*Indice 400 + 0 - O ECf Não Realiza a Z Automaticamente / 1 - Realiza a Z Automaticamente.*/
		   VAR_BUFFER_COMANDO := "401;1;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Configura Leitura X Automatica*/
		case VAR_MENU_CUPOM = 14
		   /*Indice 402 + 1 - Abre o Dia, ou realiza a X, automaticamente. / 0 - Não Abre o Dia, ou Não realiza a X, automaticamente.*/
		   VAR_BUFFER_COMANDO := "402;1;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Configura Calculo de Arredondamento*/
		case VAR_MENU_CUPOM = 15
		   /*Indice 403 + 0 - Não realiza os Calculos Por arredondamento e simpor truncamento / 1 - Realiza os Calculos por Arredondamento.*/
		   VAR_BUFFER_COMANDO := "403;1;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Configura Horario de Verao*/
		case VAR_MENU_CUPOM = 16
		   /*Indice 404 + 0 - Comanda o ECF para SAIR do horario de Verão, ou seja atrasa o Relogio em 1(uma) hora. / 1 - Comanda o ECF para entrar em Horario de Verão, ou seja, Automaticamente será Adiantado 1(uma) hora no Relógio da Impressora.*/
		   VAR_BUFFER_COMANDO := "404;1;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Configura Sensor de Autenticacao*/
		case VAR_MENU_CUPOM = 17
		   /*Indice 405 + 0 - Sensor de Autenticação Desabilitado. / 1 - Sensor de Autenticação Habilitado.*/
		   VAR_BUFFER_COMANDO := "405;1;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Configura Espacamento entre cupons*/
		case VAR_MENU_CUPOM = 18
		   /*Indice 407 + 2(Dois) dígitos com o número de linhas que você deseja avançar após a emissão de qualquer Documento. */
		   VAR_BUFFER_COMANDO := "407;02;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Configura Limiar Near ENd*/
		case VAR_MENU_CUPOM = 19
		   /*Indice 409 + String com 4(quatro) dígitos que indica quantas linhas o sinal de pouco papel deve ser Atrasado, o Valor 0000 indica que o sina fica desabilitado.*/
		   VAR_BUFFER_COMANDO := "409;0400;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Configura Permite Mensagem Promocional no CNF*/
		case VAR_MENU_CUPOM = 20
		   /*Indice 410 + 0 - Não exige a Mensagem Promocional. / 1 - Exige a Mensagem Promocional. */
		   VAR_BUFFER_COMANDO := "410;1;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Configura Calculo de Arredondamento*/
		case VAR_MENU_CUPOM = 21
		   /*Indice 412 + 0 - Emissão do Cupom Adicional Desablitado. / 1 - Emissão do Cupom Adicional Hablitado.*/
		   VAR_BUFFER_COMANDO := "412;1;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

    endcase

enddo

return 

/*//////////////////////// Fim das Funcoes de Inicializacao e Configuracao do ECF (300 a 599) //////////////////////////*/


/*//////////////////////////////// Funcoes de Utilidades e Outras Funcoes (600 a 899) //////////////////////////////////*/

static function MENU_UTILIDADES_OUTROS()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FI_AbrePortaSerial                          (Indice  600) "
    @  03,02 prompt "Daruma_FI_FechaPortaSerial                         (Indice  601) "
    @  04,02 prompt "Daruma_FI_MapaResumo                               (Indice  602) "
    @  05,02 prompt "Daruma_FI_AberturadoDia                            (Indice  603) "
    @  06,02 prompt "Daruma_FI_FechamentodoDia                          (Indice  604) "
    @  07,02 prompt "Daruma_FI_RelatorioTipo60Analitico                 (Indice  605) "
    @  08,02 prompt "Daruma_FI_RelatorioTipo60Mestre                    (Indice  606) "
    @  09,02 prompt "Daruma_FI_ImprimeConfiguracoes                     (Indice  607) "
    @  10,02 prompt "Daruma_FI_ResetaImpressora                         (Indice  608) "
    
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FI_AbrePortaSerial*/
		case VAR_MENU_CUPOM = 1
		   VAR_BUFFER_COMANDO := "600;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FI_FechaPortaSerial*/
		case VAR_MENU_CUPOM = 2
		   VAR_BUFFER_COMANDO := "601;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_MapaResumo*/
		case VAR_MENU_CUPOM = 3
		   VAR_BUFFER_COMANDO := "602;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_AberturadoDia*/
		case VAR_MENU_CUPOM = 4
		   /*Indice 604 + Valor do Suprimento + Forma de Pagamento*/
		   VAR_BUFFER_COMANDO := "603;50,00;Dinheiro;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_FechamentodoDia*/
		case VAR_MENU_CUPOM = 5
		   VAR_BUFFER_COMANDO := "604;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_RelatorioTipo60Analitico*/
		case VAR_MENU_CUPOM = 6
		   VAR_BUFFER_COMANDO := "605;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_RelatorioTipo60Mestre*/
		case VAR_MENU_CUPOM = 7
		   VAR_BUFFER_COMANDO := "606;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
	
		/*Daruma_FI_ImprimeConfiguracoes*/
		case VAR_MENU_CUPOM = 8
		   VAR_BUFFER_COMANDO := "607;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_ResetaImpressora*/
		case VAR_MENU_CUPOM = 9
		   VAR_BUFFER_COMANDO := "608;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

    endcase

enddo

return 

/*//////////////////////////// Fim das Funcoes de Utilidades e Outras Funcoes (600 a 899) //////////////////////////////*/


/*/////////////////////////////////////// Funcoes de Cupom  Fiscal (1000 a 1099) ///////////////////////////////////////*/

static function MENU_CUPOM()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FI_AbreCupom                                (Indice 1000)"
    @  03,02 prompt "Daruma_FI_VendeItem                                (Indice 1001)"
    @  04,02 prompt "Daruma_FI_VendeItem1Lin13Dig                       (Indice 1002)"
    @  05,02 prompt "Daruma_FI_VendeItem1Lin6Dig                        (Indice 1003)"
    @  06,02 prompt "Daruma_FI_VendeItemDepartamento                    (Indice 1004)"
    @  07,02 prompt "Daruma_FI_VendeItemTresCasasDecimais               (Indice 1019)"
    @  08,02 prompt "Daruma_FI_CancelaItemAnterior                      (Indice 1005)"
    @  09,02 prompt "Daruma_FI_CancelaItemGenerico                      (Indice 1006)"
    @  10,02 prompt "Daruma_FI_IniciaFechamentoCupom                    (Indice 1007)"
    @  11,02 prompt "Daruma_FI_EfetuaFormaPagamento                     (Indice 1008)"
    @  12,02 prompt "Daruma_FI_EfetuaFormaPagamentoDescricaoForma       (Indice 1009)"
    @  13,02 prompt "Daruma_FI_TerminaFechamentoCupom                   (Indice 1010)"
    @  14,02 prompt "Daruma_FI_FechaCupom                               (Indice 1011)"
    @  15,02 prompt "Daruma_FI_FechaCupomResumido                       (Indice 1012)"
    @  16,02 prompt "Daruma_FI_IdentificaConsumidor                     (Indice 1013)"
    @  17,02 prompt "Daruma_FI_CancelaCupom                             (Indice 1014)"
    @  18,02 prompt "Daruma_FI_AumentaDescricaoItem                     (Indice 1015)"
    @  19,02 prompt "Daruma_FI_UsaUnidadeMedida                         (Indice 1016)"
    @  20,02 prompt "Daruma_FI_EstornoFormasPagamento                   (Indice 1017)"
    @  21,02 prompt "Daruma_FI_EmitirCupomAdicional                     (Indice 1018)"
    @  22,02 prompt "Vende 5 Cupons com 10 Itens                                     "
    @  23,02 prompt "Vende 1 Cupom com 10 Itens                                      "

    
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Abre Cupom*/
		case VAR_MENU_CUPOM = 1
		   /*Indice 1000 + Parametro de CNPJ ou CPF*/
		   VAR_BUFFER_COMANDO := "1000;038642297-52;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Vende Item*/
		case VAR_MENU_CUPOM = 2
		   /*Indice 1001 +Codigo+descri+aliquota+tipoquant+Quant+casasdecimais+ValorUnit+TipoDesc+valordesc*/
		   VAR_BUFFER_COMANDO := "1001;123;Caneta78901234567890123456789;FF;I;10;2;0,25;%;0000;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Vende Item uma Linha*/
		case VAR_MENU_CUPOM = 3
		   /*Indice 1002 +Codigo+descri+aliquota+TipoQuant+Quant+CasasDecimal+ValorUnit+TipoDesc+Desc*/
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Vende Item uma Linha*/
		case VAR_MENU_CUPOM = 4
		   /*Indice 1003 +Codigo+descri+aliquota+TipoQuant+Quant+CasasDecimal+ValorUnit+TipoDesc+Desc*/
        	   VAR_BUFFER_COMANDO := "1003;123456;Fanta;FF;10;10;D;0000;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*VendeItemDepartamento*/
		case VAR_MENU_CUPOM = 5
		   /*Indice 1004 +Codigo+descri+aliquota+TipoQuant+Quant+CasasDecimal+ValorUnit+TipoDesc+Desc*/
		   VAR_BUFFER_COMANDO := "1004;123;Caneta;II;0,125;0,100;0;0;03;UN;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Vende Item com Tres Casas Decimais*/
		case VAR_MENU_CUPOM = 6
		   /*Indice 1019 + Codigo+Descricao+Aliquota+Quantidade+ValorUnit+Acrs/Desc+PercAcrs/Desc*/
		   VAR_BUFFER_COMANDO := "1019;123;Caneta;FF;10;1,25;D;05,00;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*CancelaItemAnterior*/
		case VAR_MENU_CUPOM = 7
		   /*Indice 1005 SEM PARAMETROS*/
		   VAR_BUFFER_COMANDO := "1005;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*CancelaItemGenerico*/
		case VAR_MENU_CUPOM = 8
		   /*Indice 1006 + Indice do Item a ser cancelado*/
		   VAR_BUFFER_COMANDO := "1006;001;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Inicia Fechamento Cupom*/
		case VAR_MENU_CUPOM = 9
		   /*Indice 1007 + Tipo de Desconto ou Acrescimo +  Percentual ou Valor + Valor*/
		   VAR_BUFFER_COMANDO := "1007;A;%;1000;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Efetua Forma Pagamento*/
		case VAR_MENU_CUPOM = 10
		   /*Indice 1008 + Forma de Pagamento + Valor da Forma de Pagamento*/
		   VAR_BUFFER_COMANDO := "1008;Dinheiro;100,00;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*EfetuaFormaPagamentoDescricaoForma*/
		case VAR_MENU_CUPOM = 11
		   /*Indice 1009 + Forma de Pagamento + Valor +  Descricao extendida*/
		   VAR_BUFFER_COMANDO := "1009;Cheque;75,00;Vencimento em 15/12/03;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*TerminaFechamentoCupom*/
		case VAR_MENU_CUPOM = 12
		   /*Indice 1010 +  Msg Promo*/
		   VAR_BUFFER_COMANDO := "1010;Obrigado, volte sempre !!!;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*FechaCupom*/
		case VAR_MENU_CUPOM = 13
		   /*Indice 1011 + Forma Pagamento + Acrescimo ou Desconto + Perc ou Valor + Valordesc + valdor forma pagamento + Msgpromo*/
		   VAR_BUFFER_COMANDO := "1011;Dinheiro;A;$;0000;35,00;Obrigado, volte sempre !!!;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Fecha Cupom Resumido*/
		case VAR_MENU_CUPOM = 14
		   /*Indice 1012 + Forma de Pagamento + Msg Promo*/
		   VAR_BUFFER_COMANDO := "1012;Dinheiro;Obrigado, volte sempre !!!;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Identifica Consumidor*/
		case VAR_MENU_CUPOM = 15
		   /*Indice 1013 + Identificacao com 3 campos (Nome, DOC, Endereço)*/
		   VAR_BUFFER_COMANDO := "1013;Nome do Consumidor com 80 Caracteres impressos neste espaco do cupom 11111111111;Endereco do Consumidor com até 80 Caracteres impressos neste espaco do cupom 111;CNPJ ou CPF do Consumidor usando 42 carac;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*CancelaCupom*/
		case VAR_MENU_CUPOM = 16
		   /*Indice 1014 SEM PARAMETROS*/
		   VAR_BUFFER_COMANDO := "1014;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*AumentaDescricaoItem*/
		case VAR_MENU_CUPOM = 17
		   /*Indice 1015 + descricao extendida do produto*/
		   VAR_BUFFER_COMANDO := "1015;Produto 123/776 - 001 abc 123456;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Usa unidade de medida*/
		case VAR_MENU_CUPOM = 18
           	   /*Indice 1016 + Medida a ser usada*/
		   VAR_BUFFER_COMANDO := "1016;KG;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*EstornoFormasPagamento*/
		case VAR_MENU_CUPOM = 19
		   /*Indice 1017 + Forma Origem + Forma Destino + Valor*/
		   VAR_BUFFER_COMANDO := "1017;Dinheiro;Cheque;35,00;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Emissão de cupom Adicional*/
		case VAR_MENU_CUPOM = 20
		   /*Indice 1018 */
		   VAR_BUFFER_COMANDO := "1018;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

                /*Vende 5 Cupons com 10 Itens*/
                case VAR_MENU_CUPOM = 21

                   /*PRIMEIRO CUPOM*/
                   VAR_ESPERARTECLA:=0
                   VAR_BUFFER_COMANDO := "1000;038642297-52;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
        	   VAR_BUFFER_COMANDO := "1007;A;%;1000;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1008;Dinheiro;150,00;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		   VAR_BUFFER_COMANDO := "1013;Daruma32.dll Dll Integradora de Altonivel S.A.;Av. Independencia 3.500 Tatuape;000-000/000-00 BlaBlaBla;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1010;Obrigado, volte sempre !!!;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)


                   /*SEGUNDO CUPOM*/
                   VAR_ESPERARTECLA:=0
                   VAR_BUFFER_COMANDO := "1000;038642297-52;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
        	   VAR_BUFFER_COMANDO := "1007;A;%;1000;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1008;Dinheiro;150,00;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		   VAR_BUFFER_COMANDO := "1013;Daruma32.dll Dll Integradora de Altonivel S.A.;Av. Independencia 3.500 Tatuape;000-000/000-00 BlaBlaBla;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1010;Obrigado, volte sempre !!!;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

                   /*TERCEIRO CUPOM*/
                   VAR_ESPERARTECLA:=0
                   VAR_BUFFER_COMANDO := "1000;038642297-52;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
        	   VAR_BUFFER_COMANDO := "1007;A;%;1000;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1008;Dinheiro;150,00;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		   VAR_BUFFER_COMANDO := "1013;Daruma32.dll Dll Integradora de Altonivel S.A.;Av. Independencia 3.500 Tatuape;000-000/000-00 BlaBlaBla;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1010;Obrigado, volte sempre !!!;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)


                   /*QUARTO CUPOM*/
                   VAR_ESPERARTECLA:=0
                   VAR_BUFFER_COMANDO := "1000;038642297-52;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
        	   VAR_BUFFER_COMANDO := "1007;A;%;1000;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1008;Dinheiro;150,00;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		   VAR_BUFFER_COMANDO := "1013;Daruma32.dll Dll Integradora de Altonivel S.A.;Av. Independencia 3.500 Tatuape;000-000/000-00 BlaBlaBla;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1010;Obrigado, volte sempre !!!;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)


                   /*QUINTO CUPOM*/
                   VAR_ESPERARTECLA:=0
                   VAR_BUFFER_COMANDO := "1000;038642297-52;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
        	   VAR_BUFFER_COMANDO := "1007;A;%;1000;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1008;Dinheiro;150,00;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		   VAR_BUFFER_COMANDO := "1013;Daruma32.dll Dll Integradora de Altonivel S.A.;Av. Independencia 3.500 Tatuape;000-000/000-00 BlaBlaBla;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1010;Obrigado, volte sempre !!!;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

 
                /*Vende 1 Cupom com 10 Itens*/
                case VAR_MENU_CUPOM = 22

                   /*PRIMEIRO CUPOM*/
                   VAR_ESPERARTECLA:=0
                   VAR_BUFFER_COMANDO := "1000;038642297-52;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   VAR_BUFFER_COMANDO := "1002;1234567890123;CocaCola;FF;1;25;A;0000;"
                   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
        	   VAR_BUFFER_COMANDO := "1012;Dinheiro;Obrigado, volte sempre !!!;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)		

		   
		   

    endcase

enddo

return

/*////////////////////////////////// Fim das Funcoes de Cupom  Fiscal (1000 a 1099) ////////////////////////////////////*/


/*//////////////////////////////////// Funcoes de Relatorios Fiscais (1100 a 1199) /////////////////////////////////////*/
static function MENU_RELATORIOS_FISCAIS()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FI_ReducaoZ                                 (Indice 1100)"	
    @  03,02 prompt "Daruma_FI_LeituraX                                 (Indice 1101)"	
    @  04,02 prompt "Daruma_FI_LeituraMemoriaFiscalData                 (Indice 1102)"
    @  05,02 prompt "Daruma_FI_LeituraMemoriaFiscalReducao              (Indice 1103)"
    @  06,02 prompt "Daruma_FI_LeituraMemoriaFiscalSerialData           (Indice 1104)"
    @  07,02 prompt "Daruma_FI_LeituraMemoriaFiscalSerialReducao        (Indice 1105)"
    VAR_MENU_CUPOM:=0
    
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FI_ReducaoZ (indice 1100)*/
		case VAR_MENU_CUPOM = 1
		   VAR_BUFFER_COMANDO := "1100;;;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FI_LeituraX (indice 1101)*/
		case VAR_MENU_CUPOM = 2
		   VAR_BUFFER_COMANDO := "1101;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
 
		/*Daruma_FI_LeituraMemoriaFiscalData (indice 1102)*/
		case VAR_MENU_CUPOM = 5
		   VAR_BUFFER_COMANDO := "1102;01/12/2003;31/01/2004;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_LeituraMemoriaFiscalReducao (indice 1103)*/
		case VAR_MENU_CUPOM = 6
		   VAR_BUFFER_COMANDO := "1103;0001;0020;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_LeituraMemoriaFiscalSerialData (indice 1104)*/
		case VAR_MENU_CUPOM = 7
		   VAR_BUFFER_COMANDO := "1104;01/12/2003;31/01/2004;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_LeituraMemoriaFiscalSerialReducao (indice 1105)*/
		case VAR_MENU_CUPOM = 8
		   VAR_BUFFER_COMANDO := "1105;0001;0020;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)


    endcase

enddo

return 
/*/////////////////////////////// Fim das Funcoes de Relatorios Fiscais (1100 a 1199) //////////////////////////////////*/


/*/////////////////////////// Funcoes de Operacoes  Nao  Fiscais e Vinculados (1200 a 1299) ////////////////////////////*/
static function MENU_OPERACOES_NAO_FISCAIS()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FI_RelatorioGerencial                       (Indice 1200)"
    @  03,02 prompt "Daruma_FI_AbreRelatorioGerencial                   (Indice 1208)"
    @  03,02 prompt "Daruma_FI_FechaRelatorioGerencial                  (Indice 1201)"
    @  07,02 prompt "Daruma_FI_RecebimentoNaoFiscal                     (Indice 1202)"
    @  04,02 prompt "Daruma_FI_AbreComprovanteNaoFiscalVinculado        (Indice 1203)"	
    @  05,02 prompt "Daruma_FI_UsaComprovanteNaoFiscalVinculado         (Indice 1204)"	
    @  06,02 prompt "Daruma_FI_FechaComprovanteNaoFiscalVinculado       (Indice 1205)"
    @  07,02 prompt "Daruma_FI_EnviarTextoCNF                           (Indice 1209)"
    @  08,02 prompt "Daruma_FI_Sangria                                  (Indice 1206)"
    @  09,02 prompt "Daruma_FI_Suprimento                               (Indice 1207)"
 
    VAR_MENU_CUPOM :=0
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FI_RelatorioGerencial (indice 1200)*/
		case VAR_MENU_CUPOM = 1
		   VAR_BUFFER_COMANDO := "1200;teste de relatorio Gerencial"+chr(13)+chr(10)+"teste de relatorio Gerencial Linha1"+chr(13)+chr(10)+"teste de relatorio Gerencial Linha2;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		   /* VAR_BUFFER_COMANDO := "1200;teste de relatorio Gerencial"+chr(13)+chr(10)+"teste de relatorio Gerencial Linha1"+chr(13)+chr(10)+";"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		   VAR_BUFFER_COMANDO := "1200;teste de relatorio Gerencial"+chr(13)+chr(10)+"teste de relatorio Gerencial Linha1;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)*/

		/*Daruma_FI_FechaRelatorioGerencial (indice 1208)*/
		case VAR_MENU_CUPOM = 2
		   VAR_BUFFER_COMANDO := "1208;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_FechaRelatorioGerencial (indice 1201)*/
		case VAR_MENU_CUPOM = 3
		   VAR_BUFFER_COMANDO := "1201;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_RecebimentoNaoFiscal (indice 1202)*/
		case VAR_MENU_CUPOM = 4
		   VAR_BUFFER_COMANDO := "1202;01;30,00;Dinheiro;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_AbreComprovanteNaoFiscalVinculado (indice 1203)*/
		case VAR_MENU_CUPOM = 5
		   VAR_BUFFER_COMANDO := "1203;Dinheiro;;;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FI_UsaComprovanteNaoFiscalVinculado (indice 1204)*/
		case VAR_MENU_CUPOM = 6
		   VAR_BUFFER_COMANDO := "1204;1234789012345678901256901234567890;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		   VAR_BUFFER_COMANDO := "1204;1234789012345678901256901234567890;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		   VAR_BUFFER_COMANDO := "1204;1234789012345678901256901234567890;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		   
		/*Daruma_FI_FechaComprovanteNaoFiscalVinculado (indice 1205)*/
		case VAR_MENU_CUPOM = 7
		   VAR_BUFFER_COMANDO := "1205;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_EnviarTextoCNF (Índice 1209)*/
		case VAR_MENU_CUPOM = 8
		   VAR_BUFFER_COMANDO := "1209;1234789012345678901256901234567890;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_Sangria (indice 1206)*/
		case VAR_MENU_CUPOM = 9
		   VAR_BUFFER_COMANDO := "1206;50,00;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_Suprimento (indice 1207)*/
		case VAR_MENU_CUPOM = 10
		   VAR_BUFFER_COMANDO := "1207;10,00;Dinheiro;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

    endcase

enddo

return 
/*/////////////////// Fim das Funcoes de Operacoes  Nao  Fiscais e Vinculados (1200 a 1299) ////////////////////////////*/


/*/////////////////////////////////// Funcoes de Autenticacao (1300 a 1309) ////////////////////////////////////////////*/
static function MENU_AUTENTICA()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    VAR_MENU_CUPOM:=0
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FI_Autenticacao                             (Indice 1300)"	
    @  03,02 prompt "Daruma_FI_VerificadorAutenticacao                  (Indice 1301)"
    @  04,02 prompt "Daruma_FI_AutenticacaoSTR                          (Indice 1302)"	
   
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FI_Autenticacao (Indice 1300)*/
		case VAR_MENU_CUPOM = 1
		    VAR_BUFFER_COMANDO := "1300;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_VerificadorAutenticacao (Indice 1301)*/
		case VAR_MENU_CUPOM = 2
		   VAR_BUFFER_COMANDO := "1301;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FI_AutenticacaoSTR (Indice 1302)*/
		case VAR_MENU_CUPOM = 3
		   /*Indice 1302 +String de 13 caracteres para autenticar*/
		   VAR_BUFFER_COMANDO := "1302;BancoPostal;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)


    endcase

enddo

return 

/*/////////////////////////////// Fim das Funcoes de Autenticacao (1300 a 1309) ////////////////////////////////////////*/


/*///////////////////////////////// Funcoes de Gaveta e Dinheiro (1310 a 1319) /////////////////////////////////////////*/
static function MENU_GAVETA()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    VAR_MENU_CUPOM:=0
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FI_AcionaGaveta                             (Indice 1310)"
    @  03,02 prompt "Daruma_FI_VerificaEstadoGaveta                     (Indice 1311)"
    
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FI_AcionaGaveta (Indice 1310)*/
		case VAR_MENU_CUPOM = 1
		   VAR_BUFFER_COMANDO := "1310;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_VerificaEstadoGaveta (Indice 1311)*/
		case VAR_MENU_CUPOM = 2
		   VAR_BUFFER_COMANDO := "1311;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		

    endcase

enddo

return 

/*///////////////////////////// Fim das Funcoes de Gaveta e Dinheiro (1310 a 1319) /////////////////////////////////////*/


/*////////////////////////////// Funcoes de Facilidades para o TEF (1900 a 1950) ///////////////////////////////////////*/
static function MENU_TEF()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Exemplo Completo de TEF - Cupom, Impressao e Confirmacao        "	
    @  03,02 prompt "Daruma_TEF_EsperarArquivo                          (Indice 1900)"	
    @  04,02 prompt "Daruma_TEF_ImprimirResposta                        (Indice 1901)"
    @  05,02 prompt "Daruma_TEF_SetFocus                                (Indice 1902)"
    @  06,02 prompt "Daruma_TEF_TravarTeclado                           (Indice 1903)"
    @  07,02 prompt "Daruma_TEF_FechaRelatorio                          (Indice 1904)"
 
    VAR_MENU_CUPOM :=0
    VAR_NUMCUPOM:=" "
    VAR_DADOSGP:=" "
    
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Exemplo Competo de TEF - Cupom, Impressao e Confirmação         */
		case VAR_MENU_CUPOM = 1
		   
		   VAR_ESPERARTECLA:=0
	           /******************BLOCO DE CODIGO DO CUPOM FISCAL***********************/		
		   /*Cupom Fiscal com Pagamento para TEF*/
 		   VAR_BUFFER_COMANDO := "1000;038642297-52;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		   /*Venda da Item*/
		   VAR_BUFFER_COMANDO := "1001;123;Caneta;FF;I;10;2;1,00;%;0000;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		   /*IniciaFechamentoCupom*/
		   VAR_BUFFER_COMANDO := "1007;A;%;0000;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		   /*EfetuaFormaPagamento*/
		   VAR_BUFFER_COMANDO := "1008;Dinheiro;10,00;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		   

		   /*******************BLOCO DE CODIGO DA COMUNICACAO COM O GP**************/
		   /*Gerando um Contador Aleatorio para o GP, chamando a Funcao NumeroCupom*/
		   VAR_BUFFER_COMANDO := "1417;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		   VAR_NUMCUPOM= SubStr(VAR_BUFFER_RETORNO,13,6)
	           VAR_NUMCUPOM= right(VAR_NUMCUPOM,6)	   
		   
		   H_HANDLE := fcreate( "INTPOS.001" )
		   VAR_DADOSGP  := "000-000 = CRT"              + chr( 13 ) + chr( 10 ) + ;
                 		   "001-000 = 0000000001"       + chr( 13 ) + chr( 10 ) + ;
		                   "002-000 = " + VAR_NUMCUPOM  + chr( 13 ) + chr( 10 ) + ;
                 		   "003-000 = " + "10,00"       + chr( 13 ) + chr( 10 ) + ;
			           "999-999 = 0"                + chr( 13 ) + chr( 10 )
		   
		   /*Escreve os dados do TEF no Arquvo esperado pelo GP, faz uma Copia do Arquivo*/
 		   /*Para o Diretorio do GP, este metodo é mais segur0*/
		   fwrite( H_Handle, @VAR_DADOSGP  , len( VAR_DADOSGP   ) )
		   __copyfile( ("C:\" + curdir() + "\INTPOS.001") , "C:\TEF_DIAL\REQ\INTPOS.001" )
		   fclose(H_HANDLE)

		   /*Chama a Funcao da dll que ficara esperando o Arquivo de TEF por 60 Segundos*/
		   VAR_BUFFER_COMANDO := "1900;C:\TEF_DIAL\RESP\INTPOS.001;60;0;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		   /*VAR_BUFFER_COMANDO := "1902;Daruma32.exe;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)*/

		   
		   /*TerminaFechamentoCupom*/
		   VAR_BUFFER_COMANDO := "1010;Obrigado, volte sempre !!!;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		   	   

		   /*Chama a fucao da dll para Imprimir o Arquivo, travando o Teclado enquanto Imprime*/
		   VAR_BUFFER_COMANDO := "1901;C:\TEF_DIAL\RESP\INTPOS.001;Dinheiro;1;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		   VAR_ESPERARTECLA:=1

		   Delete File(( "C:\" + curdir() + "\INTPOS.001") )
		   Delete File( "C:\TEF_DIAL\RESP\INTPOS.001" )

		/*Daruma_TEF_EsperarArquivo                          (Indice 1900)*/
		case VAR_MENU_CUPOM = 2
        	   VAR_BUFFER_COMANDO := "1900;C:\TEF_DIAL\RESP\INTPOS.001;60;0;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		   
		/*Daruma_TEF_ImprimirResposta                        (Indice 1901)*/
		case VAR_MENU_CUPOM = 3
		   VAR_BUFFER_COMANDO := "1901;C:\TEF_DIAL\RESP\INTPOS.001;Dinheiro;1;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_TEF_SetFocus                                (Indice 1902)*/
		case VAR_MENU_CUPOM = 4
		   VAR_BUFFER_COMANDO := "1902;SILVIO2;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_TEF_TravarTeclado                           (Indice 1903)*/
		case VAR_MENU_CUPOM = 5
		   VAR_BUFFER_COMANDO := "1902;SILVIO2;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		   VAR_BUFFER_COMANDO := "1903;1;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
                   INKEY(10)                                       
		   VAR_BUFFER_COMANDO := "1903;0;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		   VAR_BUFFER_COMANDO := "1902;DARUMA;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)



		/*Daruma_TEF_FechaRelatorio                          (Indice 1904)*/
		case VAR_MENU_CUPOM = 6
		   VAR_BUFFER_COMANDO := "1904;"
        	   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

    endcase

enddo

return 
/*/////////////////////////// Fim das Funcoes de Facilidades para o TEF (1900 a 1950) //////////////////////////////////*/


/*/////////////////////////// Funcoes de Informacoes, Status e Retorno (1400 a 1800) //////////////////////////////////*/
static function MENU_RETORNO()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    VAR_MENU_CUPOM:=0
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FI_VerificaImpressoraLigada                 (Indice 1400)"	
    @  03,02 prompt "Daruma_FI_VerificaEstadoImpressora                 (Indice 1401)"	
    @  04,02 prompt "Daruma_FI_RetornoImpressora                        (Indice 1402)"	
    @  05,02 prompt "Daruma_FI_FlagsFiscais                             (Indice 1428)"	
    @  06,02 prompt "Daruma_FI_InformacoesdeMinutos                            [-->>]"
    @  07,02 prompt "Daruma_FI_InformacoesdeContadores                         [-->>]"
    @  08,02 prompt "Daruma_FI_InformacoesCadastroDadosdoECF                   [-->>]"
    @  09,02 prompt "Daruma_FI_InformacoesdeTotalizadores                      [-->>]"
    @  10,02 prompt "Daruma_FI_Outras Informacoes Gerais                       [-->>]"
    @  11,02 prompt "Daruma_FI_RetornosdaImpressora                            [-->>]"
  
    
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FI_VerificaImpressoraLigada                 (Indice 1400)*/
		case VAR_MENU_CUPOM = 1
		    VAR_BUFFER_COMANDO := "1400;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FI_VerificaEstadoImpressora                 (Indice 1401)*/
		case VAR_MENU_CUPOM = 2
		    VAR_BUFFER_COMANDO := "1401;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_RetornoImpressora                        (Indice 1402)*/
		case VAR_MENU_CUPOM = 3
		    VAR_BUFFER_COMANDO := "1402;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_FlagsFiscais                             (Indice 1428)*/
		case VAR_MENU_CUPOM = 4
		   VAR_BUFFER_COMANDO := "1428;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

        	/*Daruma_FI_Informacoes de Minutos                          [-->>]*/
		case VAR_MENU_CUPOM = 5
        	   MENU_INFORMACOES_MINUTOS();

		/*Daruma_FI_Informacoes de Contadores                       [-->>]*/
		case VAR_MENU_CUPOM = 6
		   MENU4_INFORMACOES_CONTADORES();

		/*Daruma_FI_Informacoes de Cadastro de Dados do ECF         [-->>]*/
		case VAR_MENU_CUPOM = 7
		   MENU5_INFORMACOES_CADASTRO_DADOS_ECF();

		/*Daruma_FI_Informacoes de Totalizadores                    [-->>]*/
        	case VAR_MENU_CUPOM = 8
		   MENU6_INFORMACOES_TOTALIZADORES();		

		/*Daruma_FI_Outras Informacoes Gerais                       [-->>]*/
		case VAR_MENU_CUPOM = 9
		   MENU_OUTRAS_INFORMACOES_GERAIS();

		/*Daruma_FI_RetornosdaImpressora                            [-->>]*/
		case VAR_MENU_CUPOM = 10
		   MENU_RIMPRESSORA();

    endcase

enddo

return 
/***************************Final Menu de Infomacoes da Impressora*****************/


/**************************Sub Menu Informacoes Minutos****************************/
static function MENU_INFORMACOES_MINUTOS()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    VAR_MENU_CUPOM:=0
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FI_MinutosLigada                            (Indice 1429)"	
    @  03,02 prompt "Daruma_FI_MinutosImprimindo                        (Indice 1430)"	
 
    
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FI_MinutosLigada*/
		case VAR_MENU_CUPOM = 1
		    VAR_BUFFER_COMANDO := "1429;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_MinutosImprimindo*/
		case VAR_MENU_CUPOM = 2
		   VAR_BUFFER_COMANDO := "1430;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)


    endcase

enddo

return 
/**********************Final do Sub Menu Informacoes Minutos****************************/

/***************************Sub Menu Informacoes Contadores****************************/
static function MENU4_INFORMACOES_CONTADORES()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    VAR_MENU_CUPOM:=0
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FI_NumeroCupom                              (Indice 1417)"	
    @  03,02 prompt "Daruma_FI_NumeroOperacoesNaoFiscais                (Indice 1418)"	
    @  04,02 prompt "Daruma_FI_NumeroCuponsCancelados                   (Indice 1419)"
    @  05,02 prompt "Daruma_FI_NumeroReducoes                           (Indice 1420)"
    @  06,02 prompt "Daruma_FI_NumeroIntervencoes                       (Indice 1421)"
    @  07,02 prompt "Daruma_FI_NumeroSubstituicoesProprietario          (Indice 1422)"
    @  08,02 prompt "Daruma_FI_ContadoresTotalizadoresNaoFiscais        (Indice 1435)"
    @  09,02 prompt "Daruma_FI_COO                                      (Indice 1468)"

    
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FI_NumeroCupom (Indice 1417)*/
		case VAR_MENU_CUPOM = 1
		    VAR_BUFFER_COMANDO := "1417;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FI_NumeroOperacoesNaoFiscais (Indice 1418)*/
		case VAR_MENU_CUPOM = 2
		   VAR_BUFFER_COMANDO := "1418;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_NumeroCuponsCancelados (Indice 1419)*/
		case VAR_MENU_CUPOM = 3
		 VAR_BUFFER_COMANDO := "1419;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_NumeroReducoes (Indice 1420)*/
		case VAR_MENU_CUPOM = 4
		    VAR_BUFFER_COMANDO := "1420;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_NumeroIntervencoes (Indice 1421)*/
		case VAR_MENU_CUPOM = 5
		    VAR_BUFFER_COMANDO := "1421;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FI_NumeroSubstituicoesProprietario(Indice 1422)*/
		case VAR_MENU_CUPOM = 6
		   VAR_BUFFER_COMANDO := "1422;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FI_ContadoresTotalizadoresNaoFiscais (Indice 1435)*/
		case VAR_MENU_CUPOM = 7
		   VAR_BUFFER_COMANDO := "1435;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_COO (Índice 1468)*/
		case VAR_MENU_CUPOM = 8
		   VAR_BUFFER_COMANDO := "1468;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		

    endcase

enddo

return 
/***********************Final Sub Menu Informacoes Contadores**************************/



/********************Sub Menu Informacoes Cadastro Dados do ECF***********************/
static function MENU5_INFORMACOES_CADASTRO_DADOS_ECF()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    VAR_MENU_CUPOM:=0
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FI_NumeroCaixa                              (Indice 1425)"	
    @  03,02 prompt "Daruma_FI_NumeroLoja                               (Indice 1426)"	
    @  04,02 prompt "Daruma_FI_NumeroSerie                              (Indice 1411)"
    @  05,02 prompt "Daruma_FI_NumeroFirmware                           (Indice 1412)"
    @  06,02 prompt "Daruma_FI_NumeroCGC-IE                             (Indice 1413)"
    @  07,02 prompt "Daruma_FI_SimboloMoeda                             (Indice 1427)"
    @  08,02 prompt "Daruma_FI_ClicheProprietario                       (Indice 1424)"
    @  09,02 prompt "Daruma_FI_DataHoraImpressora                       (Indice 1434)"
    @  10,02 prompt "Daruma_FI_ClicheProprietarioEx                     (Indice 1467)"


    
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FI_NumeroCaixa (Indice 1425)*/
		case VAR_MENU_CUPOM = 1
		    VAR_BUFFER_COMANDO := "1425;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FI_NumeroLoja (Indice 1426)*/
		case VAR_MENU_CUPOM = 2
		   VAR_BUFFER_COMANDO := "1426;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_NumeroSerie (Indice 1411)*/
		case VAR_MENU_CUPOM = 3
		 VAR_BUFFER_COMANDO := "1411;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_NumeroFirmware (Indice 1412)*/
		case VAR_MENU_CUPOM = 4
		    VAR_BUFFER_COMANDO := "1412;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_NumeroCGC-IE (Indice 1413)*/
		case VAR_MENU_CUPOM = 5
		    VAR_BUFFER_COMANDO := "1413;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FI_SimboloMoeda (Indice 1427)*/
		case VAR_MENU_CUPOM = 6
		   VAR_BUFFER_COMANDO := "1427;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FI_ClicheProprietario (Indice 1424)*/
		case VAR_MENU_CUPOM = 7
		   VAR_BUFFER_COMANDO := "1424;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FI_DataHoraImpressora (Indice 1434)*/
		case VAR_MENU_CUPOM = 8
		   VAR_BUFFER_COMANDO := "1434;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_ClicheProprietarioEx (Índice 1467)*/
		case VAR_MENU_CUPOM = 9
		   VAR_BUFFER_COMANDO := "1467;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

    endcase

enddo

return 
/*****************Fim do Sub Menu Informacoes Cadastro Dados do ECF*******************/



/************************Sub Menu Informacoes Totalizadores***************************/
static function MENU6_INFORMACOES_TOTALIZADORES()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    VAR_MENU_CUPOM:=0
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FI_Cancelamentos                            (Indice 1416)"	
    @  03,02 prompt "Daruma_FI_Descontos                                (Indice 1415)"	
    @  04,02 prompt "Daruma_FI_Acrescimos                               (Indice 1441)"
    @  05,02 prompt "Daruma_FI_GrandeTotal                              (Indice 1414)"
    @  06,02 prompt "Daruma_FI_DadosUltimaReducao                       (Indice 1410)"
    @  07,02 prompt "Daruma_FI_SubTotal                                 (Indice 1408)"
    @  08,02 prompt "Daruma_FI_VerificaTotalizadoresParciais            (Indice 1407)"
    @  09,02 prompt "Daruma_FI_VerificaTotalizadoresNãoFiscais          (Indice 1436)"
    @  10,02 prompt "Daruma_FI_VerificaTotalizadoresNaoFiscaisEx        (Indice 1486)"
    @  11,02 prompt "Daruma_FI_ValorFormaPagamento                      (Indice 1446)"
    @  12,02 prompt "Daruma_FI_ValorTotalizadorNaoFiscal                (Indice 1447)"
    
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FI_Cancelamentos (Indice 1416)*/
		case VAR_MENU_CUPOM = 1
		    VAR_BUFFER_COMANDO := "1416;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FI_Descontos (Indice 1415)*/
		case VAR_MENU_CUPOM = 2
		   VAR_BUFFER_COMANDO := "1415;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_Acrescimos (Indice 1441)*/
		case VAR_MENU_CUPOM = 3
		   VAR_BUFFER_COMANDO := "1441;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_GrandeTotal (Indice 1414)*/
		case VAR_MENU_CUPOM = 4
		   VAR_BUFFER_COMANDO := "1414;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_DadosUltimaReducao (Indice 1410)*/
		case VAR_MENU_CUPOM = 5
		   VAR_BUFFER_COMANDO := "1410;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FI_SubTotal (Indice 1408)*/
		case VAR_MENU_CUPOM = 6
		   VAR_BUFFER_COMANDO := "1408;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FI_VerificaTotalizadoresParciais (Indice 1407)*/
		case VAR_MENU_CUPOM = 7
		   VAR_BUFFER_COMANDO := "1407;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FI_VerificaTotalizadoresNãoFiscais (Indice 1436)*/
		case VAR_MENU_CUPOM = 8
		   VAR_BUFFER_COMANDO := "1436;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_VerificaTotalizadoresNaoFiscaisEx (Indice 1486)*/
		case VAR_MENU_CUPOM = 9
		   VAR_BUFFER_COMANDO := "1486;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_ValorFormaPagamento (Indice 1446)*/
		case VAR_MENU_CUPOM = 10
		   /*Indice 1446 +FormadePagamento*/
		   VAR_BUFFER_COMANDO := "1446;Dinheiro;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_ValorTotalizadorNaoFiscal (Indice 1447)*/
		case VAR_MENU_CUPOM = 11
		   /*Indice 1447 +TotalizadorNaoFiscal*/
		   VAR_BUFFER_COMANDO := "1447;Conta de Luz;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

    endcase

enddo

return 
/*********************Fim do Sub Menu Informacoes Totalizadores***********************/



/************************Sub Menu Outras Informacoes Gerais***************************/
static function MENU_OUTRAS_INFORMACOES_GERAIS()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    VAR_MENU_CUPOM:=0
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FI_RetornoAliquotas                         (Indice 1406)"	
    @  03,02 prompt "Daruma_FI_UltimoItemVendido                        (Indice 1423)"
    @  04,02 prompt "Daruma_FI_VerificaMododeOperacao                   (Indice 1431)"
    @  05,02 prompt "Daruma_FI_VerificaEpromConectada                   (Indice 1432)"
    @  06,02 prompt "Daruma_FI_ValorPagoUltimoCupom                     (Indice 1433)"
    @  07,02 prompt "Daruma_FI_DataHoraReducao                          (Indice 1437)"
    @  08,02 prompt "Daruma_FI_DataMovimento                            (Indice 1438)"
    @  09,02 prompt "Daruma_FI_VerificaTruncamento                      (Indice 1439)"
    @  10,02 prompt "Daruma_FI_VerificaAliquotaISS                      (Indice 1440)"
    @  11,02 prompt "Daruma_FI_VerificaFormasdePagamento                (Indice 1442)"	
    @  12,02 prompt "Daruma_FI_VerificaRecebimentoNaoFiscal             (Indice 1443)"	
    @  13,02 prompt "Daruma_FI_VerificaTipoImpressora                   (Indice 1444)"
    @  14,02 prompt "Daruma_FI_VerificaIndiceAliquotaISS                (Indice 1445)"
    @  15,02 prompt "Daruma_FI_StatusRelatorioGerencial                 (Indice 1405)"
    @  16,02 prompt "Daruma_FI_StatusCupomFiscal                        (Indice 1404)"
    @  17,02 prompt "Daruma_FI_StatusComprovanteNaoFiscalVinculado      (Indice 1403)"
    @  18,02 prompt "Daruma_FI_VerificaFormasdePagamentoEx              (Indice 1448)"
    @  19,02 prompt "Daruma_FI_VerificaDescricaoFormasPagamento         (Indice 1449)"

    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FI_RetornoAliquotas (Indice 1406)*/
		case VAR_MENU_CUPOM = 1
		    VAR_BUFFER_COMANDO := "1406;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_UltimoItemVendido (Indice 1423)*/
		case VAR_MENU_CUPOM = 2
		   VAR_BUFFER_COMANDO := "1423;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_VerificaMododeOperacao (Indice 1431)*/
		case VAR_MENU_CUPOM = 3
		   VAR_BUFFER_COMANDO := "1431;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_VerificaEpromConectada (Indice 1432)*/
		case VAR_MENU_CUPOM = 4
		   VAR_BUFFER_COMANDO := "1432;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FI_ValorPagoUltimoCupom (Indice 1433)*/
		case VAR_MENU_CUPOM = 5
		   VAR_BUFFER_COMANDO := "1433;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FI_DataHoraReducao (Indice 1437)*/
		case VAR_MENU_CUPOM = 6
		   VAR_BUFFER_COMANDO := "1437;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_DataMovimento (Indice 1438)*/
		case VAR_MENU_CUPOM = 7
		   VAR_BUFFER_COMANDO := "1438;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_VerificaTruncamento (Indice 1439)*/
		case VAR_MENU_CUPOM = 8
		   VAR_BUFFER_COMANDO := "1439;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_VerificaAliquotaISS (Indice 1440)*/
		case VAR_MENU_CUPOM = 9
		   VAR_BUFFER_COMANDO := "1440;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_VerificaFormasdePagamento (Indice 1442)*/
		case VAR_MENU_CUPOM = 10
		   VAR_BUFFER_COMANDO := "1442;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_VerificaRecebimentoNaoFiscal (Indice 1443)*/
		case VAR_MENU_CUPOM = 11
		   VAR_BUFFER_COMANDO := "1443;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_VerificaTipoImpressora (Indice 1444)*/
		case VAR_MENU_CUPOM = 12
		   VAR_BUFFER_COMANDO := "1444;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_VerificaIndiceAliquotaISS (Indice 1445)*/
		case VAR_MENU_CUPOM = 13
		   VAR_BUFFER_COMANDO := "1445;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_StatusRelatorioGerencial (Indice 1405)*/
		case VAR_MENU_CUPOM = 14
		   VAR_BUFFER_COMANDO := "1405;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_StatusCupomFiscal (Indice 1404)*/
		case VAR_MENU_CUPOM = 15
		   VAR_BUFFER_COMANDO := "1404;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_StatusComprovanteNaoFiscalVinculado (Indice 1403)*/
		case VAR_MENU_CUPOM = 16
		   VAR_BUFFER_COMANDO := "1403;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
	
		/*Daruma_FI_VerificaFormasdePagamentoEx (Indice 1448)*/
		case VAR_MENU_CUPOM = 17
		   VAR_BUFFER_COMANDO := "1448;"
        	   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_VerificaDescricaoFormasPagamento (Indice 1449)*/
		case VAR_MENU_CUPOM = 18
		   VAR_BUFFER_COMANDO := "1449;"
        	   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)


    endcase

enddo

return 
/*********************Fim do Sub Menu Outras Informacoes Gerais***********************/



/**************************Sub Menu Retornos da Impressora****************************/
static function MENU_RIMPRESSORA()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    VAR_MENU_CUPOM:=0
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FI_RetornaAcrescimoNF                       (Indice 1451)"
    @  03,02 prompt "Daruma_FI_RetornaCFCancelados                      (Indice 1452)"
    @  04,02 prompt "Daruma_FI_RetornaCNFCancelados                     (Indice 1453)"
    @  05,02 prompt "Daruma_FI_RetornaCLX                               (Indice 1454)"
    @  06,02 prompt "Daruma_FI_RetornaCNFNV                             (Indice 1455)"
    @  07,02 prompt "Daruma_FI_RetornaCNFV                              (Indice 1456)"
    @  08,02 prompt "Daruma_FI_RetornaCRO                               (Indice 1457)"
    @  09,02 prompt "Daruma_FI_RetornaCRZ                               (Indice 1458)"
    @  10,02 prompt "Daruma_FI_RetornaCRZRestante                       (Indice 1459)"
    @  11,02 prompt "Daruma_FI_RetornaCancelamentoNF                    (Indice 1460)"
    @  12,02 prompt "Daruma_FI_RetornaDescontoNF                        (Indice 1461)"
    @  13,02 prompt "Daruma_FI_RetornaGNF                               (Indice 1462)"
    @  14,02 prompt "Daruma_FI_RetornaTempoImprimindo                   (Indice 1463)"
    @  15,02 prompt "Daruma_FI_RetornaTempoLigado                       (Indice 1464)"
    @  16,02 prompt "Daruma_FI_RetornaTotalPagamentos                   (Indice 1465)"
    @  17,02 prompt "Daruma_FI_RetornaTroco                             (Indice 1466)"
    @  18,02 prompt "Daruma_FI_RetornaErroExtendido                     (Indice 1470)"
    @  19,02 prompt "Daruma_FI_RetornaRegistradoresNaoFiscais           (Indice 1484)"
    @  20,02 prompt "Daruma_FI_RetornaRegistradoresFiscais              (Indice 1485)"
    @  21,02 prompt "Daruma_FI_PalavraStatus                            (Indice 1481)"
    @  22,02 prompt "Daruma_FI_PalavraStatusBinario                     (Indice 1482)"
   
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FI_RetornaAcrescimoNF (Indice 1451)*/
		case VAR_MENU_CUPOM = 1
		    VAR_BUFFER_COMANDO := "1451;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FI_RetornaCFCancelados (Indice 1452)*/
		case VAR_MENU_CUPOM = 2
                   VAR_BUFFER_COMANDO := "1452;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_RetornaCNFCancelados (Índice 1453)*/
		case VAR_MENU_CUPOM = 3
		   VAR_BUFFER_COMANDO := "1453;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_RetornaCLX (Índice 1454)*/
		case VAR_MENU_CUPOM = 4
		   VAR_BUFFER_COMANDO := "1454;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_RetornaCNFNV (Índice 1455)*/
		case VAR_MENU_CUPOM = 5
		   VAR_BUFFER_COMANDO := "1455;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
	
		/*Daruma_FI_RetornaCNFV (Índice 1456)*/
		case VAR_MENU_CUPOM = 6
		    VAR_BUFFER_COMANDO := "1456;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FI_RetornaCRO (Índice 1457)*/
		case VAR_MENU_CUPOM = 7
                   VAR_BUFFER_COMANDO := "1457;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_RetornaCRZ (Índice 1458)*/
		case VAR_MENU_CUPOM = 8
		   VAR_BUFFER_COMANDO := "1458;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_RetornaCRZRestante (Índice 1459)*/
		case VAR_MENU_CUPOM = 9
		   VAR_BUFFER_COMANDO := "1459;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_RetornaCancelamentoNF(Índice 1460)*/
		case VAR_MENU_CUPOM = 10
		   VAR_BUFFER_COMANDO := "1460;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_RetornaDescontoNF (Índice 1461)*/
		case VAR_MENU_CUPOM = 11
		    VAR_BUFFER_COMANDO := "1461;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FI_RetornaGNF (Índice 1462)*/
		case VAR_MENU_CUPOM = 12
                   VAR_BUFFER_COMANDO := "1462;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_RetornaTempoImprimindo (Índice 1463)*/
		case VAR_MENU_CUPOM = 13
		   VAR_BUFFER_COMANDO := "1463;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_RetornaTempoLigado (Índice 1464)*/
		case VAR_MENU_CUPOM = 14
		   VAR_BUFFER_COMANDO := "1464;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_RetornaTotalPagamentos (Índice 1465)*/
		case VAR_MENU_CUPOM = 15
		   VAR_BUFFER_COMANDO := "1465;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_RetornaTroco (Índice 1466)*/
		case VAR_MENU_CUPOM = 16
		    VAR_BUFFER_COMANDO := "1466;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FI_RetornaErroExtendido (Índice 1470)*/
		case VAR_MENU_CUPOM = 17
                   VAR_BUFFER_COMANDO := "1470;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_RetornaRegistradoresNaoFiscais (Índice 1484)*/
		case VAR_MENU_CUPOM = 18
		   VAR_BUFFER_COMANDO := "1484;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_RetornaRegistradoresFiscais (Índice 1485)*/
		case VAR_MENU_CUPOM = 19
		   VAR_BUFFER_COMANDO := "1485;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_PalavraStatus (Indice 1481)*/
		case VAR_MENU_CUPOM = 20
		   VAR_BUFFER_COMANDO := "1481;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI_PalavraStatusBinario (Indice 1482)*/
		case VAR_MENU_CUPOM = 21
		   VAR_BUFFER_COMANDO := "1482;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

    endcase

enddo

return 
/***********************Fim do Sub Menu Autenticacao Gaveta***************************/







/*///////////////////////// Fim das Funcoes de Informacoes, Status e Retorno (1400 a 1800) ////////////////////////////*/


/*///////////////////////////////////////////// Menu principal DS300 ///////////////////////////////////////////////////*/

static function MENU_DS300()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    
    /*set color to   */

        @  02,02 prompt "Funcoes de Configuracao do Registry                     (30 a 33)"
 	@  03,02 prompt "Funcoes da Impressora DS300                         (4001 a 4006)"

    
 	menu to VAR_MENU
 
	VAR_BUFFER_COMANDO := "" /*Variavel para Envio do comando*/
 	VAR_BUFFER_RETORNO := "" /*Variavel para Recepcao do Comando*/
        VAR_ESPERARTECLA:=1      /*Variavel que indica se espera o usuario pressionar uma tecla ou nao*/

        do case

		case VAR_MENU = 0
			exit

		/*Funções de Configuração do Registry (30 a 33)*/
		case VAR_MENU = 1
			MENU_ConfReg300();

		/*Funções da Impressora DS300 (4001 a 4006)*/
		case VAR_MENU = 2
			MENU_Func300();

		
    endcase

enddo

return 

/*////////////////////////////////////////// FIM do Menu principal DS300 ///////////////////////////////////////////////*/


/*//////////////////////////////// Funções de Configuração do Registry (30 a 33) ///////////////////////////////////////*/

static function MENU_ConfReg300()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    
    /*set color to   */

        @  02,02 prompt "Daruma_Registry_DUAL_Enter                            (Indice 30)"
 	@  03,02 prompt "Daruma_Registry_DUAL_Porta                            (Indice 31)"
 	@  04,02 prompt "Daruma_Registry_DUAL_Espera                           (Indice 32)"
 	@  05,02 prompt "Daruma_Registry_DUAL_ModoEscrita                      (Indice 33)"

    
    menu to VAR_MENU_CUPOM

    do case
				
                case VAR_MENU_CUPOM = 0
                   exit		

		/*Daruma_Registry_DUAL_Enter (Indice 30)*/
		case VAR_MENU_CUPOM = 1
		   VAR_BUFFER_COMANDO := "30;1;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_Registry_DUAL_Porta (Indice 31)*/
		case VAR_MENU_CUPOM = 2
		   VAR_BUFFER_COMANDO := "31;LPT1;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_Registry_DUAL_Espera (Indice 32)*/
		case VAR_MENU_CUPOM = 3
		   VAR_BUFFER_COMANDO := "32;0;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_Registry_DUAL_ModoEscrita (Indice 33)*/
		case VAR_MENU_CUPOM = 4
		   VAR_BUFFER_COMANDO := "33;1;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
	
    endcase

enddo

return 

/*///////////////////////////// FIM das Funções de Configuração do Registry (30 a 33) //////////////////////////////////*/


/*////////////////////////////////// Funções da Impressora DS300 (4001 a 4006) /////////////////////////////////////////*/

static function MENU_Func300()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    
    /*set color to   */


        @  02,02 prompt "Daruma_DUAL_ImprimirTexto                           (Indice 4001)"
 	@  03,02 prompt "Daruma_DUAL_VerificaSatus                           (Indice 4002)"
 	@  04,02 prompt "Daruma_DUAL_VerificaDocumento                       (Indice 4003)"
 	@  05,02 prompt "Daruma_DUAL_Autenticar                              (Indice 4004)"
 	@  06,02 prompt "Daruma_DUAL_AcionaGaveta                            (Indice 4005)"
 	@  07,02 prompt "Daruma_DUAL_ImprimirTextoFormatado                  (Indice 4006)"
  
    menu to VAR_MENU_CUPOM

    do case
				
                case VAR_MENU_CUPOM = 0
                   exit		

		/*Daruma_DUAL_ImprimirTexto (Indice 4001)*/
		case VAR_MENU_CUPOM = 1
		   VAR_BUFFER_COMANDO := "4001;Impressao de texto livre com ate 1999 caracteres;0;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_DUAL_VerificaSatus (Indice 4002)*/
		case VAR_MENU_CUPOM = 2
		   VAR_BUFFER_COMANDO := "4002;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_DUAL_VerificaDocumento (Indice 4003)*/
		case VAR_MENU_CUPOM = 3
		   VAR_BUFFER_COMANDO := "4003;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_DUAL_Autenticar (Indice 4004)*/
		case VAR_MENU_CUPOM = 4
		   VAR_BUFFER_COMANDO := "4004;1;Texto com ate 48 caracteres;10;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_DUAL_AcionaGaveta (Indice 4005)*/
		case VAR_MENU_CUPOM = 5
		   VAR_BUFFER_COMANDO := "4005;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_DUAL_ImprimirTextoFormatado (Indice 4006)*/
		case VAR_MENU_CUPOM = 6
		   VAR_BUFFER_COMANDO := "4006;Texto a ser impresso com ate 999 caracteres;1;0;0;1;0;0;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
	
    endcase

enddo

return 

/*/////////////////////////////// FIM das Funções da Impressora DS300 (4001 a 4006) ////////////////////////////////////*/

/*///////////////////////////////////////////// Menu principal FS318 ///////////////////////////////////////////////////*/

static function MENU_FS318()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    
    /*set color to   */

        @  02,02 prompt "Funcoes de Inicializacao e Configuracao do ECF        (550 a 554)"
 	@  03,02 prompt "Funcoes de Cupom Fiscal e Mesa                      (3000 a 3052)"
 	@  04,02 prompt "Funcoes de Relatorios Fiscais                       (3100 a 3105)"			
 	@  05,02 prompt "Funcoes de Operações Não Fiscais e Vinculados       (3200 a 3206)"
 	@  06,02 prompt "Funcoes de Gaveta de Dinheiro                       (3310 a 3311)"
 	@  07,02 prompt "Funcoes de Autenticacao                             (3300 a 3301)"
 	@  08,02 prompt "Funcoes de Informacoes, Status e Retorno            (3400 a 3800)"	
 	@  09,02 prompt "Funcoes de Cardapio                                   (555 a 654)"
	
    
 	menu to VAR_MENU
 
	VAR_BUFFER_COMANDO := "" /*Variavel para Envio do comando*/
 	VAR_BUFFER_RETORNO := "" /*Variavel para Recepcao do Comando*/
        VAR_ESPERARTECLA:=1      /*Variavel que indica se espera o usuario pressionar uma tecla ou nao*/

        do case

		case VAR_MENU = 0
			exit

		/*Funcoes de Inicializacao e Configuracao do ECF (550 a 554)*/
		case VAR_MENU = 1
			MENU318A_Config();

		/*Funcoes de Cupom Fiscal e Mesa (3000 a 3052)*/
		case VAR_MENU = 2
			MENU318B_CupomMesa();

		/*Funcoes de Relatorios Fiscais (3100 a 3105)*/
		case VAR_MENU = 3
			MENU318C_RelFiscais();

		/*Funcoes de Operações Não Fiscais e Vinculados (3200 a 3206)*/
		case VAR_MENU = 4
			MENU318D_NFiscaisVinc();
		
		/*Funcoes de Gaveta de Dinheiro (3310 a 3311)*/
		case VAR_MENU = 5
			MENU318E_Gaveta();

		/*Funcoes de Autenticacao (3300 a 3301)*/
		case VAR_MENU = 6
			MENU318F_Autenticacao();

		/*Funcoes de Informacoes, Status e Retorno (3400 a 3800)*/
		case VAR_MENU = 7
			MENU318G_Info();

		/*Funcoes de Cardapio (555 a 652)*/
		case VAR_MENU = 8
			MENU318H_Cardapio();
		
    endcase

enddo

return 

/*////////////////////////////////////////// FIM do Menu principal FS318 ///////////////////////////////////////////////*/


/*/////////////////////////// Funcoes de Inicializacao e Configuracao do ECF (550 a 554) ///////////////////////////////*/

static function MENU318A_Config()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FIR_ProgramaAliquota                        (Indice 550) "	
    @  03,02 prompt "Daruma_FIR_NomeiaTotalizadorNaoSujeitoIcms         (Indice 551) "	
    @  04,02 prompt "Daruma_FIR_ProgramaOperador                        (Indice 552) "
    @  05,02 prompt "Daruma_FIR_ProgramaMsgTaxaServico                  (Indice 553) "
    @  06,02 prompt "Daruma_FIR_ProgramaFormasPagamento                 (Indice 554) "

    
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FIR_ProgramaAliquota*/
		case VAR_MENU_CUPOM = 1
		   VAR_BUFFER_COMANDO := "550;0500;1;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FIR_NomeiaTotalizadorNaoSujeitoIcms*/
		case VAR_MENU_CUPOM = 2
		   VAR_BUFFER_COMANDO := "551;05;Conta de Luz;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_ProgramaOperador*/
		case VAR_MENU_CUPOM = 3
		   VAR_BUFFER_COMANDO := "552;Novo Operador;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

        	/*Daruma_FIR_ProgramaMsgTaxaServico*/
		case VAR_MENU_CUPOM = 4
		   VAR_BUFFER_COMANDO := "553;Volte Sempre;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_ProgramaFormasPagamento*/
		case VAR_MENU_CUPOM = 5
		   VAR_BUFFER_COMANDO := "554;Dinheiro;Cartão;Cheque;Ticket;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)


    endcase

enddo

return 

/*//////////////////////// Fim das Funcoes de Inicializacao e Configuracao do ECF (550 a 554) //////////////////////////*/


/*//////////////////////////////// Funcoes de Cupom Fiscal e Mesa (3000 a 3052) ////////////////////////////////////////*/

static function MENU318B_CupomMesa()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FIR_AbreCupomRestaurante                    (Indice 3000) "	
    @  03,02 prompt "Daruma_FIR_IniciaFechamentoCupom                   (Indice 3007) "	
    @  04,02 prompt "Daruma_FIR_EfetuaFormaPagamento 			(Indice 3008) "
    @  05,02 prompt "Daruma_FIR_EfetuaFormaPagamentoDescricaoForma 	(Indice 3009) "
    @  06,02 prompt "Daruma_FIR_TerminaFechamentoCupom 			(Indice 3010) "
    @  07,02 prompt "Daruma_FIR_FechaCupomRestaurante 			(Indice 3011) "	
    @  08,02 prompt "Daruma_FIR_FechaCupomRestauranteResumido 		(Indice 3012) "	
    @  09,02 prompt "Daruma_FIR_IdentificaConsumidor 			(Indice 3013) "
    @  10,02 prompt "Daruma_FIR_CancelaCupom 				(Indice 3014) "
    @  11,02 prompt "Daruma_FIR_EmitirCupomAdicional 			(Indice 3018) "
    @  12,02 prompt "Daruma_FIR_ImprimePrimeiroCupomDividido 		(Indice 3040) "	
    @  13,02 prompt "Daruma_FIR_RestanteCupomDividido 			(Indice 3041) "	
    @  14,02 prompt "Daruma_FIR_IniciaFechamentoCupomComServico 	(Indice 3042) "
    @  15,02 prompt "Daruma_FIR_CancelarVenda 				(Indice 3045) "
    @  16,02 prompt "Daruma_FIR_ConferenciaMesa 			(Indice 3046) "
    @  17,02 prompt "Daruma_FIR_RegistrarVenda 				(Indice 3048) "	
    @  18,02 prompt "Daruma_FIR_RegistroVendaSerial 			(Indice 3049) "	
    @  19,02 prompt "Daruma_FIR_RelatorioMesasAbertas 			(Indice 3050) "
    @  20,02 prompt "Daruma_FIR_TranferirVenda 				(Indice 3051) "
    @  21,02 prompt "Daruma_FIR_TranferirMesa 				(Indice 3052) "
    @  22,02 prompt "Venda Balcao        				(Indice ****) "    

    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FIR_AbreCupomRestaurante*/
		case VAR_MENU_CUPOM = 1
		   VAR_BUFFER_COMANDO := "3000;123;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FIR_IniciaFechamentoCupom*/
		case VAR_MENU_CUPOM = 2
		   VAR_BUFFER_COMANDO := "3007;A;%;1000;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_EfetuaFormaPagamento*/
		case VAR_MENU_CUPOM = 3
		   VAR_BUFFER_COMANDO := "3008;Dinheiro;50,00;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

        	/*Daruma_FIR_EfetuaFormaPagamentoDescricaoForma*/
		case VAR_MENU_CUPOM = 4
		   VAR_BUFFER_COMANDO := "3009;Cheque;75,00;Vencimento em 25/10/2004;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_TerminaFechamentoCupom*/
		case VAR_MENU_CUPOM = 5
		   VAR_BUFFER_COMANDO := "3010;Mensagem de fim de cupom;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_FechaCupomRestaurante*/
		case VAR_MENU_CUPOM = 6
		   VAR_BUFFER_COMANDO := "3011;Dinheiro;A;%;1000;50,00;0;0,00;Fecha Daruma Restaurante;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FIR_FechaCupomRestauranteResumido*/
		case VAR_MENU_CUPOM = 7
		   VAR_BUFFER_COMANDO := "3012;Dinheiro;Mensagem de fim de cupom;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_IdentificaConsumidor*/
		case VAR_MENU_CUPOM = 8
		   VAR_BUFFER_COMANDO := "3013;Nome do Cliente;Endereco do Cliente;Documento do Cliente;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

        	/*Daruma_FIR_CancelaCupom*/
		case VAR_MENU_CUPOM = 9
		   VAR_BUFFER_COMANDO := "3014;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_EmitirCupomAdicional*/
		case VAR_MENU_CUPOM = 10
		   VAR_BUFFER_COMANDO := "3018;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_ImprimePrimeiroCupomDividido*/
		case VAR_MENU_CUPOM = 11
		   VAR_BUFFER_COMANDO := "3040;123;2;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FIR_RestanteCupomDividido*/
		case VAR_MENU_CUPOM = 12
		   VAR_BUFFER_COMANDO := "3041;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_IniciaFechamentoCupomComServico*/
		case VAR_MENU_CUPOM = 13
		   VAR_BUFFER_COMANDO := "3042;A;%;1000;1;15,00;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

        	/*Daruma_FIR_CancelarVenda*/
		case VAR_MENU_CUPOM = 14
		   VAR_BUFFER_COMANDO := "3045;123;0001;4,000;A;0,50;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_ConferenciaMesa*/
		case VAR_MENU_CUPOM = 15
		   VAR_BUFFER_COMANDO := "3046;123;Conferencia de mesa;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_RegistrarVenda*/
		case VAR_MENU_CUPOM = 16
		   VAR_BUFFER_COMANDO := "3048;123;0001;4,000;A,0,50;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FIR_RegistroVendaSerial*/
		case VAR_MENU_CUPOM = 17
		   VAR_BUFFER_COMANDO := "3049;123;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_RelatorioMesasAbertas*/
		case VAR_MENU_CUPOM = 18
		   VAR_BUFFER_COMANDO := "3050;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

        	/*Daruma_FIR_TranferirVenda*/
		case VAR_MENU_CUPOM = 19
		   VAR_BUFFER_COMANDO := "3051;123;321;0001;4,000;A;0,50;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_TranferirMesa*/
		case VAR_MENU_CUPOM = 20
		   VAR_BUFFER_COMANDO := "3052;321;123;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Venda Balcao*/
		case VAR_MENU_CUPOM = 21
		   VAR_BUFFER_COMANDO := "3053;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		   VAR_BUFFER_COMANDO := "3054;0001;4,000;A;0,00;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		   VAR_BUFFER_COMANDO := "3055;0001;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

    endcase

enddo

return 

/*//////////////////////////// Fim das Funcoes de Cupom Fiscal e Mesa (3000 a 3052) ////////////////////////////////////*/



/*/////////////////////////////////// Funcoes de Relatorios Fiscais (3100 a 3105) /////////////////////////////////////*/

static function MENU318C_RelFiscais()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FIR_ReducaoZ                                (Indice 3100) "	
    @  03,02 prompt "Daruma_FIR_LeituraX                                (Indice 3101) "	
    @  04,02 prompt "Daruma_FIR_LeituraMemoriaFiscalData                (Indice 3102) "
    @  05,02 prompt "Daruma_FIR_LeituraMemoriaFiscalReducao             (Indice 3103) "
    @  06,02 prompt "Daruma_FIR_LeituraMemoriaFiscalSerialData          (Indice 3104) "
    @  07,02 prompt "Daruma_FIR_LeituraMemoriaFiscalSerialReducao       (Indice 3105) "
    
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FIR_ReducaoZ*/
		case VAR_MENU_CUPOM = 1
		   VAR_BUFFER_COMANDO := "3100;;;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FIR_LeituraX*/
		case VAR_MENU_CUPOM = 2
		   VAR_BUFFER_COMANDO := "3101;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_LeituraMemoriaFiscalData*/
		case VAR_MENU_CUPOM = 3
		   VAR_BUFFER_COMANDO := "3102;101103;111103;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

        	/*Daruma_FIR_LeituraMemoriaFiscalReducao*/
		case VAR_MENU_CUPOM = 4
		   VAR_BUFFER_COMANDO := "3103;01;02;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_LeituraMemoriaFiscalSerialData*/
		case VAR_MENU_CUPOM = 5
		   VAR_BUFFER_COMANDO := "3104;101103;11103;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_LeituraMemoriaFiscalSerialReducao*/
		case VAR_MENU_CUPOM = 6
		   VAR_BUFFER_COMANDO := "3105;01;02;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

    endcase

enddo

return 

/*//////////////////////////////// Fim das Funcoes de Relatorios Fiscais (3100 a 3105) /////////////////////////////////*/


/*/////////////////////////// Funcoes de Operações Não Fiscais e Vinculados (3200 a 3206) /////////////////////////////*/

static function MENU318D_NFiscaisVinc()

while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FIR_RelatorioGerencial                      (Indice 3200) "	
    @  03,02 prompt "Daruma_FIR_FechaRelatorioGerencial                 (Indice 3201) "	
    @  04,02 prompt "Daruma_FIR_RecebimentoNaoFiscal                    (Indice 3202) "
    @  04,02 prompt "Daruma_FIR_AbreComprovanteNaoFiscalVinculado       (Indice 3203) "
    @  05,02 prompt "Daruma_FIR_UsaComprovanteNaoFiscalVinculado        (Indice 3204) "
    @  06,02 prompt "Daruma_FIR_FechaComprovanteNaoFiscalVinculado      (Indice 3205) "
    @  07,02 prompt "Daruma_FIR_Sangria                                 (Indice 3206) "
    @  07,02 prompt "Daruma_FIR_Suprimento                              (Indice 3207) "
    
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FIR_RelatorioGerencial*/
		case VAR_MENU_CUPOM = 1
		   VAR_BUFFER_COMANDO := "3200;123456789.123456789.123456789.123456789.FIM;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FIR_FechaRelatorioGerencial*/
		case VAR_MENU_CUPOM = 2
		   VAR_BUFFER_COMANDO := "3201;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_RecebimentoNaoFiscal*/
		case VAR_MENU_CUPOM = 3
		   VAR_BUFFER_COMANDO := "3202;05;30,00;Dinheiro;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

        	/*Daruma_FIR_AbreComprovanteNaoFiscalVinculado*/
		case VAR_MENU_CUPOM = 4
		   VAR_BUFFER_COMANDO := "3203;Dinheiro;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_UsaComprovanteNaoFiscalVinculado*/
		case VAR_MENU_CUPOM = 5
		   VAR_BUFFER_COMANDO := "3204;123456789.123456789.123456789.123456789.FIM;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_FechaComprovanteNaoFiscalVinculado*/
		case VAR_MENU_CUPOM = 6
		   VAR_BUFFER_COMANDO := "3205;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_FechaComprovanteNaoFiscalVinculado*/
		case VAR_MENU_CUPOM = 7
		   VAR_BUFFER_COMANDO := "3206;25,00;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_FechaComprovanteNaoFiscalVinculado*/
		case VAR_MENU_CUPOM = 8
		   VAR_BUFFER_COMANDO := "3207;50;Dinheiro;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)



    endcase

enddo

return 

/*/////////////////////// Fim das Funcoes de Operações Não Fiscais e Vinculados (3200 a 3206) /////////////////////////*/


/*/////////////////////////////////// Funcoes de Gaveta de Dinheiro (3310 a 3311) /////////////////////////////////////*/

static function MENU318E_Gaveta()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FIR_AcionaGaveta                            (Indice 3310) "	
    @  03,02 prompt "Daruma_FIR_VerificaEstadoGaveta                    (Indice 3311) "	
    
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FIR_AcionaGaveta*/
		case VAR_MENU_CUPOM = 1
		   VAR_BUFFER_COMANDO := "3310;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FIR_FechaRelatorioGerencial*/
		case VAR_MENU_CUPOM = 2
		   VAR_BUFFER_COMANDO := "3311;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)


    endcase

enddo

return 

/*/////////////////////////////// Fim das Funcoes de Gaveta de Dinheiro (3310 a 3311) /////////////////////////////////*/


/*////////////////////////////////////// Funcoes de Autenticacao (3301 a 3301) ////////////////////////////////////////*/

static function MENU318F_Autenticacao()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FIR_AutenticacaoStr                         (Indice 3300) "	
    @  03,02 prompt "Daruma_FIR_VerificaDocAutenticacao                 (Indice 3301) "	
    
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FIR_AutenticacaoStr*/
		case VAR_MENU_CUPOM = 1
		   VAR_BUFFER_COMANDO := "3300;String de 13 "
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FIR_VerificaDocAutenticacao*/
		case VAR_MENU_CUPOM = 2
		   VAR_BUFFER_COMANDO := "3311;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)


    endcase

enddo

return 

/*////////////////////////////////// Fim das Funcoes de Autenticacao (3301 a 3301) ////////////////////////////////////*/


/*/////////////////////////// Funcoes de Informacoes, Status e Retorno (3400 a 3800) //////////////////////////////////*/
static function MENU318G_Info()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    VAR_MENU_CUPOM:=0
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FIR_VerificaImpressoraLigada                 (Indice 3400)"	
    @  03,02 prompt "Daruma_FIR_VerificaEstadoImpressora                 (Indice 3401)"	
    @  04,02 prompt "Daruma_FIR_RetornoImpressora                        (Indice 3402)"	
    @  05,02 prompt "Daruma_FIR_FlagsFiscais                             (Indice 3428)"	
    @  06,02 prompt "Daruma_FIR_InformacoesdeMinutos                            [-->>]"
    @  07,02 prompt "Daruma_FIR_InformacoesdeContadores                         [-->>]"
    @  08,02 prompt "Daruma_FIR_InformacoesCadastroDadosdoECF                   [-->>]"
    @  09,02 prompt "Daruma_FIR_InformacoesdeTotalizadores                      [-->>]"
    @  10,02 prompt "Daruma_FIR_Outras Informacoes Gerais                       [-->>]"
    @  11,02 prompt "Daruma_FIR_RetornosdaImpressora                            [-->>]"

    
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FIR_VerificaImpressoraLigada                 (Indice 3400)*/
		case VAR_MENU_CUPOM = 1
		    VAR_BUFFER_COMANDO := "3400;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FIR_VerificaEstadoImpressora                 (Indice 3401)*/
		case VAR_MENU_CUPOM = 2
		    VAR_BUFFER_COMANDO := "3401;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_RetornoImpressora                        (Indice 3402)*/
		case VAR_MENU_CUPOM = 3
		    VAR_BUFFER_COMANDO := "3402;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_FlagsFiscais                             (Indice 3428)*/
		case VAR_MENU_CUPOM = 4
		   VAR_BUFFER_COMANDO := "3428;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

        	/*Daruma_FIR_Informacoes de Minutos                          [-->>]*/
		case VAR_MENU_CUPOM = 5
        	   MENU318I_INFORMACOES_MINUTOS();

		/*Daruma_FIR_Informacoes de Contadores                       [-->>]*/
		case VAR_MENU_CUPOM = 6
		   MENU318J_INFORMACOES_CONTADORES();

		/*Daruma_FIR_Informacoes de Cadastro de Dados do ECF         [-->>]*/
		case VAR_MENU_CUPOM = 7
		   MENU318K_INFORMACOES_CADASTRO_DADOS_ECF();

		/*Daruma_FIR_Informacoes de Totalizadores                    [-->>]*/
        	/*case VAR_MENU_CUPOM = 8*/
		   /*MENU318L_INFORMACOES_TOTALIZADORES();*/		

		/*Daruma_FIR_Outras Informacoes Gerais                       [-->>]*/
		case VAR_MENU_CUPOM = 8
		   MENU318M_OUTRAS_INFORMACOES_GERAIS();

		/*Daruma_FIR_RetornosdaImpressora                            [-->>]*/
		case VAR_MENU_CUPOM = 9
		   MENU31_RIMPR();


    endcase

enddo

return 

/***************************************Final Menu de Infomacoes da Impressora******************************************/


/*******************************************Sub Menu Informacoes Minutos************************************************/
static function MENU318I_INFORMACOES_MINUTOS()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    VAR_MENU_CUPOM:=0
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FIR_MinutosLigada                            (Indice 3429)"	
    @  03,02 prompt "Daruma_FIR_MinutosImprimindo                        (Indice 3430)"	
 
    
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FIR_MinutosLigada*/
		case VAR_MENU_CUPOM = 1
		    VAR_BUFFER_COMANDO := "3429;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_MinutosImprimindo*/
		case VAR_MENU_CUPOM = 2
		   VAR_BUFFER_COMANDO := "3430;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)


    endcase

enddo

return 


/***************************************Final do Sub Menu Informacoes Minutos*******************************************/


/*****************************************Sub Menu Informacoes Contadores***********************************************/


static function MENU318J_INFORMACOES_CONTADORES()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    VAR_MENU_CUPOM:=0
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FIR_NumeroCupom                              (Indice 3417)"	
    @  03,02 prompt "Daruma_FIR_NumeroOperacoesNaoFiscais                (Indice 3418)"	
    @  04,02 prompt "Daruma_FIR_NumeroCuponsCancelados                   (Indice 3419)"
    @  05,02 prompt "Daruma_FIR_NumeroReducoes                           (Indice 3420)"
    @  06,02 prompt "Daruma_FIR_NumeroIntervencoes                       (Indice 3421)"
    @  07,02 prompt "Daruma_FIR_ContadoresTotalizadoresNaoFiscais        (Indice 3435)"
    
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FIR_NumeroCupom (Indice 3417)*/
		case VAR_MENU_CUPOM = 1
		    VAR_BUFFER_COMANDO := "3417;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FIR_NumeroOperacoesNaoFiscais (Indice 3418)*/
		case VAR_MENU_CUPOM = 2
		   VAR_BUFFER_COMANDO := "3418;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_NumeroCuponsCancelados (Indice 3419)*/
		case VAR_MENU_CUPOM = 3
		 VAR_BUFFER_COMANDO := "3419;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_NumeroReducoes (Indice 3420)*/
		case VAR_MENU_CUPOM = 4
		    VAR_BUFFER_COMANDO := "3420;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_NumeroIntervencoes (Indice 3421)*/
		case VAR_MENU_CUPOM = 5
		    VAR_BUFFER_COMANDO := "3421;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FIR_ContadoresTotalizadoresNaoFiscais (Indice 3435)*/
		case VAR_MENU_CUPOM = 6
		   VAR_BUFFER_COMANDO := "3435;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

	

    endcase

enddo

return 


/**************************************Final Sub Menu Informacoes Contadores********************************************/


/***********************************Sub Menu Informacoes Cadastro Dados do ECF******************************************/

static function MENU318K_INFORMACOES_CADASTRO_DADOS_ECF()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    VAR_MENU_CUPOM:=0
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FIR_NumeroCaixa                              (Indice 3425)"	
    @  03,02 prompt "Daruma_FIR_NumeroSerie                              (Indice 3411)"
    @  04,02 prompt "Daruma_FIR_NumeroFirmware                           (Indice 3412)"
    @  05,02 prompt "Daruma_FIR_NumeroCGC-IE                             (Indice 3413)"
    @  06,02 prompt "Daruma_FIR_ClicheProprietario                       (Indice 3424)"
    @  07,02 prompt "Daruma_FIR_DataHoraImpressora                       (Indice 3434)"
    @  08,02 prompt "Daruma_FIR_ClicheProprietarioEx                     (Indice 3467)"


    
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FIR_NumeroCaixa (Indice 3425)*/
		case VAR_MENU_CUPOM = 1
		    VAR_BUFFER_COMANDO := "3425;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_NumeroSerie (Indice 3411)*/
		case VAR_MENU_CUPOM = 2
		 VAR_BUFFER_COMANDO := "3411;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_NumeroFirmware (Indice 3412)*/
		case VAR_MENU_CUPOM = 3
		    VAR_BUFFER_COMANDO := "3412;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_NumeroCGC-IE (Indice 3413)*/
		case VAR_MENU_CUPOM = 4
		    VAR_BUFFER_COMANDO := "3413;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_ClicheProprietario (Indice 3424)*/
		case VAR_MENU_CUPOM = 5
		   VAR_BUFFER_COMANDO := "3424;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FIR_DataHoraImpressora (Indice 3434)*/
		case VAR_MENU_CUPOM = 6
		   VAR_BUFFER_COMANDO := "3434;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_ClicheProprietarioEx (Índice 3467)*/
		case VAR_MENU_CUPOM = 7
		   VAR_BUFFER_COMANDO := "3467;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

    endcase

enddo

return 

/*********************************Fim do Sub Menu Informacoes Cadastro Dados do EFs**************************************/


/***************************************Sub Menu Informacoes Totalizadores***********************************************/

static function MENU318M_OUTRAS_INFORMACOES_GERAIS()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    VAR_MENU_CUPOM:=0
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FIR_Cancelamentos                            (Indice 3416)"	
    @  03,02 prompt "Daruma_FIR_Descontos                                (Indice 3415)"	
    @  04,02 prompt "Daruma_FIR_GrandeTotal                              (Indice 3414)"
    @  05,02 prompt "Daruma_FIR_DadosUltimaReducao                       (Indice 3410)"
    @  06,02 prompt "Daruma_FIR_SubTotal                                 (Indice 3408)"
    @  07,02 prompt "Daruma_FIR_VerificaTotalizadoresParciais            (Indice 3407)"
    @  08,02 prompt "Daruma_FIR_VerificaTotalizadoresNãoFiscais          (Indice 3436)"
    @  10,02 prompt "Daruma_FIR_VerificaTotalizadoresNaoFiscaisEx        (Indice 3486)"
    @  11,02 prompt "Daruma_FIR_ValorFormaPagamento                      (Indice 3446)"
    @  12,02 prompt "Daruma_FIR_ValorTotalizadorNaoFiscal                (Indice 3447)"
    
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FIR_Cancelamentos (Indice 3416)*/
		case VAR_MENU_CUPOM = 1
		    VAR_BUFFER_COMANDO := "3416;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FIR_Descontos (Indice 3415)*/
		case VAR_MENU_CUPOM = 2
		   VAR_BUFFER_COMANDO := "3415;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_GrandeTotal (Indice 3414)*/
		case VAR_MENU_CUPOM = 3
		   VAR_BUFFER_COMANDO := "3414;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_DadosUltimaReducao (Indice 3410)*/
		case VAR_MENU_CUPOM = 5
		   VAR_BUFFER_COMANDO := "3410;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FIR_SubTotal (Indice 3408)*/
		case VAR_MENU_CUPOM = 6
		   VAR_BUFFER_COMANDO := "3408;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FIR_VerificaTotalizadoresParciais (Indice 3407)*/
		case VAR_MENU_CUPOM = 7
		   VAR_BUFFER_COMANDO := "3407;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FIR_VerificaTotalizadoresNãoFiscais (Indice 3436)*/
		case VAR_MENU_CUPOM = 8
		   VAR_BUFFER_COMANDO := "3436;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_VerificaTotalizadoresNaoFiscaisEx (Indice 3486)*/
		case VAR_MENU_CUPOM = 9
		   VAR_BUFFER_COMANDO := "3486;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_ValorFormaPagamento (Indice 3446)*/
		case VAR_MENU_CUPOM = 10
		   /*Indice 1446 +FormadePagamento*/
		   VAR_BUFFER_COMANDO := "3446;Dinheiro;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_ValorTotalizadorNaoFiscal (Indice 3447)*/
		case VAR_MENU_CUPOM = 11
		   /*Indice 1447 +TotalizadorNaoFiscal*/
		   VAR_BUFFER_COMANDO := "3447;Conta de Luz;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

    endcase

enddo

return 

/*************************************Fim do Sub Menu Informacoes Totalizadores******************************************/


/***************************************Sub Menu Outras Informacoes Gerais***********************************************/

static function MENU318N_R3IMPRESSORA()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    VAR_MENU_CUPOM:=0
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FIR_RetornoAliquotas                         (Indice 3406) "	
    @  04,02 prompt "Daruma_FIR_VerificaMododeOperacao                   (Indice 3431) "
    @  05,02 prompt "Daruma_FIR_VerificaEpromConectada                   (Indice 3432) "
    @  06,02 prompt "Daruma_FIR_ValorPagoUltimoCupom                     (Indice 3433) "
    @  07,02 prompt "Daruma_FIR_DataHoraReducao                          (Indice 3437) "
    @  09,02 prompt "Daruma_FIR_VerificaTruncamento                      (Indice 3439) "
    @  10,02 prompt "Daruma_FIR_VerificaAliquotaISS                      (Indice 3440) "
    @  10,02 prompt "Daruma_FIR_VerificaRecebimentoNaoFiscal             (Indice 3443) "
    @  10,02 prompt "Daruma_FIR_VerificaIndiceAliquotaISS                (Indice 3445) "
    @  15,02 prompt "Daruma_FIR_StatusRelatorioGerencial                 (Indice 3405) "
    @  16,02 prompt "Daruma_FIR_StatusCupomFiscal                        (Indice 3404) "
    @  17,02 prompt "Daruma_FIR_StatusComprovanteNaoFiscalVinculado      (Indice 3403) "
    @  18,02 prompt "Daruma_FIR_VerificaFormasdePagamentoEx              (Indice 3448) "
    @  19,02 prompt "Daruma_FIR_VerificaDescricaoFormasPagamento         (Indice 3449) "

    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FIR_RetornoAliquotas (Indice 3406)*/
		case VAR_MENU_CUPOM = 1
		    VAR_BUFFER_COMANDO := "3406;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_VerificaMododeOperacao (Indice 3431)*/
		case VAR_MENU_CUPOM = 2
		   VAR_BUFFER_COMANDO := "3431;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_VerificaEpromConectada (Indice 3432)*/
		case VAR_MENU_CUPOM = 3
		   VAR_BUFFER_COMANDO := "3432;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FIR_ValorPagoUltimoCupom (Indice 3433)*/
		case VAR_MENU_CUPOM = 4
		   VAR_BUFFER_COMANDO := "3433;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FIR_DataHoraReducao (Indice 3437)*/
		case VAR_MENU_CUPOM = 5
		   VAR_BUFFER_COMANDO := "3437;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_VerificaTruncamento (Indice 3439)*/
		case VAR_MENU_CUPOM = 6
		   VAR_BUFFER_COMANDO := "3439;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_VerificaAliquotaISS (Indice 3440)*/
		case VAR_MENU_CUPOM = 7
		   VAR_BUFFER_COMANDO := "3440;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_VerificaRecebimentoNaoFiscal (Indice 3443)*/
		case VAR_MENU_CUPOM = 8
		   VAR_BUFFER_COMANDO := "3443;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_VerificaIndiceAliquotaISS (Indice 3445)*/
		case VAR_MENU_CUPOM = 9
		   VAR_BUFFER_COMANDO := "3445;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_StatusRelatorioGerencial (Indice 3405)*/
		case VAR_MENU_CUPOM = 10
		   VAR_BUFFER_COMANDO := "3405;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_StatusCupomFiscal (Indice 3404)*/
		case VAR_MENU_CUPOM = 11
		   VAR_BUFFER_COMANDO := "3404;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_StatusComprovanteNaoFiscalVinculado (Indice 3403)*/
		case VAR_MENU_CUPOM = 16
		   VAR_BUFFER_COMANDO := "3403;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
	
		/*Daruma_FIR_VerificaFormasdePagamentoEx (Indice 3448)*/
		case VAR_MENU_CUPOM = 17
		   VAR_BUFFER_COMANDO := "3448;"
        	   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_VerificaDescricaoFormasPagamento (Indice 3449)*/
		case VAR_MENU_CUPOM = 18
		   VAR_BUFFER_COMANDO := "3449;"
        	   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)


    endcase

enddo

return 
/*********************Fim do Sub Menu Outras Informacoes Gerais***********************/



/**************************Sub Menu Retornos da Impressora****************************/
static function MENU31_RIMPR()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    VAR_MENU_CUPOM:=0
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FIR_RetornaAcrescimoNF                       (Indice 3451)"
    @  03,02 prompt "Daruma_FIR_RetornaCFCancelados                      (Indice 3452)"
    @  04,02 prompt "Daruma_FIR_RetornaCNFCancelados                     (Indice 3453)"
    @  05,02 prompt "Daruma_FIR_RetornaCLX                               (Indice 3454)"
    @  06,02 prompt "Daruma_FIR_RetornaCNFNV                             (Indice 3455)"
    @  07,02 prompt "Daruma_FIR_RetornaCNFV                              (Indice 3456)"
    @  08,02 prompt "Daruma_FIR_RetornaCRO                               (Indice 3457)"
    @  09,02 prompt "Daruma_FIR_RetornaCRZ                               (Indice 3458)"
    @  10,02 prompt "Daruma_FIR_RetornaCRZRestante                       (Indice 3459)"
    @  11,02 prompt "Daruma_FIR_RetornaCancelamentoNF                    (Indice 3460)"
    @  12,02 prompt "Daruma_FIR_RetornaDescontoNF                        (Indice 3461)"
    @  13,02 prompt "Daruma_FIR_RetornaGNF                               (Indice 3462)"
    @  14,02 prompt "Daruma_FIR_RetornaTempoImprimindo                   (Indice 3463)"
    @  15,02 prompt "Daruma_FIR_RetornaTempoLigado                       (Indice 3464)"
    @  16,02 prompt "Daruma_FIR_RetornaTotalPagamentos                   (Indice 3465)"
    @  17,02 prompt "Daruma_FIR_RetornaTroco                             (Indice 3466)"
    @  18,02 prompt "Daruma_FIR_RetornaErroExtendido                     (Indice 3470)"
    @  19,02 prompt "Daruma_FIR_MesasLivres                              (Indice 3471)"
    @  20,02 prompt "Daruma_FIR_RegistroVendaLivre                       (Indice 3472)"
    @  21,02 prompt "Daruma_FIR_PalavraStatus                            (Indice 3481)"
    @  22,02 prompt "Daruma_FIR_PalavraStatusBinario                     (Indice 3482)"
   
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FIR_RetornaAcrescimoNF (Indice 3451)*/
		case VAR_MENU_CUPOM = 1
		    VAR_BUFFER_COMANDO := "3451;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FIR_RetornaCFCancelados (Indice 3452)*/
		case VAR_MENU_CUPOM = 2
                   VAR_BUFFER_COMANDO := "3452;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_RetornaCNFCancelados (Índice 3453)*/
		case VAR_MENU_CUPOM = 3
		   VAR_BUFFER_COMANDO := "3453;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_RetornaCLX (Índice 3454)*/
		case VAR_MENU_CUPOM = 4
		   VAR_BUFFER_COMANDO := "3454;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_RetornaCNFNV (Índice 3455)*/
		case VAR_MENU_CUPOM = 5
		   VAR_BUFFER_COMANDO := "3455;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
	
		/*Daruma_FIR_RetornaCNFV (Índice 3456)*/
		case VAR_MENU_CUPOM = 6
		    VAR_BUFFER_COMANDO := "3456;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FIR_RetornaCRO (Índice 3457)*/
		case VAR_MENU_CUPOM = 7
                   VAR_BUFFER_COMANDO := "3457;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_RetornaCRZ (Índice 3458)*/
		case VAR_MENU_CUPOM = 8
		   VAR_BUFFER_COMANDO := "3458;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_RetornaCRZRestante (Índice 3459)*/
		case VAR_MENU_CUPOM = 9
		   VAR_BUFFER_COMANDO := "3459;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_RetornaCancelamentoNF(Índice 3460)*/
		case VAR_MENU_CUPOM = 10
		   VAR_BUFFER_COMANDO := "3460;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_RetornaDescontoNF (Índice 3461)*/
		case VAR_MENU_CUPOM = 11
		    VAR_BUFFER_COMANDO := "3461;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FIR_RetornaGNF (Índice 3462)*/
		case VAR_MENU_CUPOM = 12
                   VAR_BUFFER_COMANDO := "3462;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FRI_RetornaTempoImprimindo (Índice 3463)*/
		case VAR_MENU_CUPOM = 13
		   VAR_BUFFER_COMANDO := "3463;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_RetornaTempoLigado (Índice 3464)*/
		case VAR_MENU_CUPOM = 14
		   VAR_BUFFER_COMANDO := "3464;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_RetornaTotalPagamentos (Índice 3465)*/
		case VAR_MENU_CUPOM = 15
		   VAR_BUFFER_COMANDO := "3465;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_RetornaTroco (Índice 3466)*/
		case VAR_MENU_CUPOM = 16
		    VAR_BUFFER_COMANDO := "3466;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FIR_RetornaErroExtendido (Índice 3470)*/
		case VAR_MENU_CUPOM = 17
                   VAR_BUFFER_COMANDO := "3470;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_MesasLivres (Indice 3471)*/
		case VAR_MENU_CUPOM = 18
		   VAR_BUFFER_COMANDO := "3471;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_RegistroVendaLivre (Índice 3472)*/
		case VAR_MENU_CUPOM = 19
		   VAR_BUFFER_COMANDO := "3481;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_PalavraStatus (Indice 3481)*/
		case VAR_MENU_CUPOM = 20
		   VAR_BUFFER_COMANDO := "3481;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_PalavraStatusBinario (Indice 3482)*/
		case VAR_MENU_CUPOM = 21
		   VAR_BUFFER_COMANDO := "3482;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

    endcase

enddo

return 
/***********************Fim do Sub Menu Autenticacao Gaveta***************************/



/*///////////////////////// Fim das Funcoes de Informacoes, Status e Retorno (3400 a 3800) ////////////////////////////*/


/*///////////////////////////////////////// Funcoes de Cardapio (555 a 654) ///////////////////////////////////////////*/

static function MENU318H_Cardapio()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FIR_AdicionaProdutoCardapio                 (Indice 555) "	
    @  03,02 prompt "Daruma_FIR_ZeraCardapio                            (Indice 650) "	
    @  04,02 prompt "Daruma_FIR_ImprimeCardapio                         (Indice 651) "
    @  05,02 prompt "Daruma_FIR_CardapioSerial                          (Indice 652) "
    @  06,02 prompt "Daruma_FIR_LeituraMemoriaTrabalho                  (Indice 653) "
    @  06,02 prompt "Daruma_FIR_RelatorioMesasAbertasSerial             (Indice 654) "

    
    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FIR_AdicionaProdutoCardapio*/
		case VAR_MENU_CUPOM = 1
		   VAR_BUFFER_COMANDO := "555;0001;10,00;1800;fanta diet;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FIR_ZeraCardapio*/
		case VAR_MENU_CUPOM = 2
		   VAR_BUFFER_COMANDO := "650;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_ImprimeCardapior*/
		case VAR_MENU_CUPOM = 3
		   VAR_BUFFER_COMANDO := "651;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

        	/*Daruma_FIR_CardapioSerial*/
		case VAR_MENU_CUPOM = 4
		   VAR_BUFFER_COMANDO := "652;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_LeituraMemoriaTrabalho*/
		case VAR_MENU_CUPOM = 5
		   VAR_BUFFER_COMANDO := "653;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FIR_RelatorioMesasAbertasSerial*/
		case VAR_MENU_CUPOM = 6
		   VAR_BUFFER_COMANDO := "654;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

    endcase

enddo

return 

/*///////////////////////////////////// Fim das Funcoes de Cardapio (650 a 654) ////////////////////////////////////////*/


/*///////////////////////////////////////////// Menu principal FS2000 //////////////////////////////////////////////////*/

static function MENU_FS2000()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    
    /*set color to   */

        @  02,02 prompt "Funcoes de Comandos Especificos                       (** a ****)"
 	@  03,02 prompt "Funcoes de Impressao de cheque                      (**** a ****)"
    
 	menu to VAR_MENU
 
	VAR_BUFFER_COMANDO := "" /*Variavel para Envio do comando*/
 	VAR_BUFFER_RETORNO := "" /*Variavel para Recepcao do Comando*/
        VAR_ESPERARTECLA:=1      /*Variavel que indica se espera o usuario pressionar uma tecla ou nao*/

        do case

		case VAR_MENU = 0
			exit

		/*Funcoes de Comandos Especificos*/
		case VAR_MENU = 1
			MENU2000A_CMDEspec();

		/*Funcoes de Impressao de cheque*/
		case VAR_MENU = 2
			MENU2000B_IMpcheque();

		
    endcase

enddo

return 

/*////////////////////////////////////////// FIM do Menu principal FS2000 //////////////////////////////////////////////*/

/*//////////////////////////////////////// Funcoes de Comandos Especificos /////////////////////////////////////////////*/

static function MENU2000A_CMDEspec()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_Registry_FS2000_CupomAdicional             (Indice  35) "
    @  03,02 prompt "Daruma_FI2000_AbreRelatorioGerencial            (Indice  5012) "
    @  04,02 prompt "Daruma_FI2000_CriaRelatorioGerencial 	     (Indice  5013) "
    @  05,02 prompt "Daruma_FI2000_VerificaRelatorioGerencial 	     (Indice  5014) "
    @  06,02 prompt "Daruma_FI2000_DescontoSobreItemVendido 	     (Indice  5018) "
    @  07,02 prompt "Daruma_FI2000_SegundaViaCNFVinculado 	     (Indice  5019) "
    @  08,02 prompt "Daruma_FI2000_CancelamentoCNFV 		     (Indice  5020) "
    @  09,02 prompt "Daruma_FI2000_AcrescimosICMSISS 		     (Indice  5021) "
    @  10,02 prompt "Daruma_FI2000_CancelamentosICMSISS 	     (Indice  5022) "
    @  11,02 prompt "Daruma_FI2000_DescontosICMSISS 		     (Indice  5023) "
    @  12,02 prompt "Daruma_FI2000_LeituraInformacaoUltimoDoc 	     (Indice  5024) "
    @  13,02 prompt "Daruma_FI2000_LeituraInformacaoUltimosCNF 	     (Indice  5025) "

    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_Registry_FS2000_CupomAdicional*/
		case VAR_MENU_CUPOM = 1
		   VAR_BUFFER_COMANDO := "35;1;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FI2000_AbreRelatorioGerencial*/
		case VAR_MENU_CUPOM = 2
		   VAR_BUFFER_COMANDO := "5012;01;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI2000_CriaRelatorioGerencial*/
		case VAR_MENU_CUPOM = 3
		   VAR_BUFFER_COMANDO := "5013;Relatorio Diario;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

        	/*Daruma_FI2000_VerificaRelatorioGerencial*/
		case VAR_MENU_CUPOM = 4
		   VAR_BUFFER_COMANDO := "5014;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI2000_DescontoSobreItemVendido*/
		case VAR_MENU_CUPOM = 5
		   VAR_BUFFER_COMANDO := "5018;1;$;0;12;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI2000_SegundaViaCNFVinculado*/
		case VAR_MENU_CUPOM = 6
		   VAR_BUFFER_COMANDO := "5019;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI2000_CancelamentoCNFV*/
		case VAR_MENU_CUPOM = 7
		   VAR_BUFFER_COMANDO := "5020;001;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI2000_AcrescimosICMSISS*/
		case VAR_MENU_CUPOM = 8
		   VAR_BUFFER_COMANDO := "5021;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI2000_CancelamentosICMSISS*/
		case VAR_MENU_CUPOM = 9
		   VAR_BUFFER_COMANDO := "5022;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI2000_DescontosICMSISS*/
		case VAR_MENU_CUPOM = 10
		   VAR_BUFFER_COMANDO := "5023;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI2000_LeituraInformacaoUltimoDoc*/
		case VAR_MENU_CUPOM = 11
		   VAR_BUFFER_COMANDO := "5024;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI2000_LeituraInformacaoUltimosCNF*/
		case VAR_MENU_CUPOM = 12
		   VAR_BUFFER_COMANDO := "5025;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
    endcase

enddo

return 

/*/////////////////////////////////// FIM das Funcoes de Comandos Especificos //////////////////////////////////////////*/


/*///////////////////////////////////////// Funcoes de Impressao de cheque /////////////////////////////////////////////*/

static function MENU2000B_IMpcheque()
while .t.
    clear
 	set color to w/b
 	@ 0,0 clear to 40,80
 
	@ 0,1 say "Pressione ESC para Sair - OBSERVER para DOS - Funcoes de ALtoNivel para DOS"
 	@ 36,0 clear to 36,80
 	set color to w/b
 	
	@ 40,1 say "DARUMA - DARUMA DEVELOPER COMMUNITY, COMUNIDADE DE LIDERES!!"
 	set color to n/bg
 	@ 1,0 clear to 38,80
 	/*set color to*/
 	/*@ 1,1 to 37,66 double*/
 	
    
    /*set color to   */
    /*"             "****************************************************************"*/	
    @  02,02 prompt "Daruma_FI2000_SelecionaBanco                    (Indice  5000) "
    @  03,02 prompt "Daruma_FI2000_SelecionaCidade 	             (Indice  5001) "
    @  04,02 prompt "Daruma_FI2000_SelecionaData 		     (Indice  5002) "
    @  04,02 prompt "Daruma_FI2000_SelecionaFavorecido 		     (Indice  5003) "
    @  05,02 prompt "Daruma_FI2000_SelecionaValorChequeH 	     (Indice  5004) "
    @  06,02 prompt "Daruma_FI2000_SelecionaValorChequeV 	     (Indice  5005)"
    @  07,02 prompt "Daruma_FI2000_SelecionaTextoVersoCheque 	     (Indice  5006) "
    @  08,02 prompt "Daruma_FI2000_LeituraCodigoMICR 		     (Indice  5007) "
    @  09,02 prompt "Daruma_FI2000_LiberarCheque 		     (Indice  5008) "
    @  10,02 prompt "Daruma_FI2000_CarregarCheque 		     (Indice  5009) "
    @  11,02 prompt "Daruma_FI2000_CorrigirGeometriaCheque 	     (Indice  5010) "
    @  12,02 prompt "Daruma_FI2000_LeituraTabelaCheque 		     (Indice  5011) "
    @  13,02 prompt "Daruma_FI2000_StatusCheque 	             (Indice  5015) "
    @  14,02 prompt "Daruma_FI2000_ImprimirCheque                    (Indice  5016) "
    @  15,02 prompt "Daruma_FI2000_ImprimirVersoCheque               (Indice  5017) "

    menu to VAR_MENU_CUPOM

    do case
				
		case VAR_MENU_CUPOM = 0
			exit		

		/*Daruma_FI2000_SelecionaBanco*/
		case VAR_MENU_CUPOM = 1
		   VAR_BUFFER_COMANDO := "5000;399;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)
		
		/*Daruma_FI2000_SelecionaCidade*/
		case VAR_MENU_CUPOM = 2
		   VAR_BUFFER_COMANDO := "5001;Curitiba;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI2000_SelecionaData*/
		case VAR_MENU_CUPOM = 3
		   VAR_BUFFER_COMANDO := "5002;10062004;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

        	/*Daruma_FI2000_SelecionaFavorecido*/
		case VAR_MENU_CUPOM = 4
		   VAR_BUFFER_COMANDO := "5003;Daruma;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI2000_SelecionaValorChequeH*/
		case VAR_MENU_CUPOM = 5
		   VAR_BUFFER_COMANDO := "5004;50,90;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI2000_SelecionaValorChequeV*/
		case VAR_MENU_CUPOM = 6
		   VAR_BUFFER_COMANDO := "5005;999,99;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI2000_SelecionaTextoVersoCheque*/
		case VAR_MENU_CUPOM = 7
		   VAR_BUFFER_COMANDO := "5006;Texto no Verso;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI2000_LeituraCodigoMICR*/
		case VAR_MENU_CUPOM = 8
		   VAR_BUFFER_COMANDO := "5007;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI2000_LiberarCheque*/
		case VAR_MENU_CUPOM = 9
		   VAR_BUFFER_COMANDO := "5008;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI2000_CarregarCheque*/
		case VAR_MENU_CUPOM = 10
		   VAR_BUFFER_COMANDO := "5009;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI2000_CorrigirGeometriaCheque*/
		case VAR_MENU_CUPOM = 11
		   VAR_BUFFER_COMANDO := "5010;399;1365131415161718193020;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI2000_LeituraTabelaCheque*/
		case VAR_MENU_CUPOM = 12
		   VAR_BUFFER_COMANDO := "5011;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI2000_StatusCheque*/
		case VAR_MENU_CUPOM = 13
		   VAR_BUFFER_COMANDO := "5015;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI2000_ImprimirCheque*/
		case VAR_MENU_CUPOM = 14
		   VAR_BUFFER_COMANDO := "5016;399;Curitiba;10/06/2004;Daruma;12,85;H;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

		/*Daruma_FI2000_ImprimirVersoCheque*/
		case VAR_MENU_CUPOM = 15
		   VAR_BUFFER_COMANDO := "5017;Escrito no verso do cheque;"
		   COMUNICA_COM_ECF(VAR_BUFFER_COMANDO)

    endcase

enddo

return 

/*/////////////////////////////////// FIM das Funcoes de Comandos Especificos //////////////////////////////////////////*/






























/*////////////////////////////////////////Função que envia os dados para o ECF/////////////////////////////////////////*/

static function COMUNICA_COM_ECF(VAR_COMANDO_ECF)

Delete File("c:\DARUMA.CMD")
Delete File("c:\STATUS.TXT")
Delete File("c:\RETORNO.TXT")
Delete File("c:\DARUMA.RET")



/*Escreve comandos no Arquivo*/
   H_Handle := fcreate("c:\DARUMA.CMD" )
   FWrite( H_Handle , @VAR_COMANDO_ECF, Len( VAR_COMANDO_ECF) )
   FClose( H_Handle  )
   
   VAR_ESPERA:=1
/*Espera que o Arquivo de Resposta Seja Criado*/
   do while VAR_ESPERA > 0
	if File("c:\DARUMA.RET")
	   VAR_ESPERA :=0
	else
	   loop
	end if
   enddo	

   RET_TAM:=0
/*Espera o Arquivo ter um conteudo*/
   do While RET_TAM = 0

   	H_Handle := Fopen("c:\DARUMA.RET")
   	RET_TAM =  FSeek( H_Handle, 0, FS_END )
   	Fclose(H_Handle)
	
   enddo


   H_Handle:= Fopen("c:\DARUMA.RET")

   POS_RET = 0
   VAR_RET_CMD=" "
   VAR_AUX =" "

   if RET_TAM > 0
      for POS_RET = 1 to RET_TAM - 1
         fread( H_Handle, @VAR_AUX, 1)
         if VAR_AUX <> chr(13)
           VAR_RET_CMD= VAR_RET_CMD + VAR_AUX
    	 end if
      next
   endif   
   fclose(H_Handle)
 	
   set color to n/bg
   @ 23,0 clear to 23,80
   @23,0 say "Comando Enviado: " + VAR_COMANDO_ECF
   @24,0 say "Retorno: " + VAR_RET_CMD
   VAR_BUFFER_RETORNO:=VAR_RET_CMD

   if VAR_ESPERARTECLA <> 1 
        inkey(0)
   end if	
  
return NIL

/*////////////////////////////////////Fim da Função que envia os dados para o ECF/////////////////////////////////////*/